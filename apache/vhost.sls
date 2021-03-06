# Manage virtual host
{% if pillar['apache:vhost'] is not defined %}
# No vhost defined throught pillar (see pillar.example under apache:vhost)
{% else %}
{% for vhost, settings in salt['pillar.get']('apache:vhost', {}).iteritems() %}
{%     if settings.enabled == true %}
enable_apache_vhost_{{ vhost }}:
  cmd.run:
    - name: /usr/sbin/a2ensite {{ vhost }}
    - unless: test -L /etc/apache2/site-enabled/{{vhost}}
    - require:
      - sls: apache_vhost_{{ vhost }}
    - watch_in:
      - service: apache
{%     elif settings.enabled == false %}
disable_apache_vhost_{{ vhost }}:
  cmd.run:
    - name: /usr/sbin/a2dissite {{ vhost }}
    - onlyif: test -L /etc/apache2/site-enabled/{{vhost}}
    - watch_in:
      - service: apache
{%     endif %}

apache_vhost_{{ vhost }}:
  file.managed:
    - name: /etc/apache2/site-available/{{ vhost }}
{%     if settings.conftext is defined %}
    - contents_pillar: apache:vhost:{{ vhost }}:conftext
{%     else %}
    - source: salt://apache/files/vhost.jinja
    - template: jinja
    - context:
        config: {{ settings.conf|json() }}
{%     endif %}
    - user: root
    - group: root
    - mode: 644
    - watch_in:
      - service: apache
{% endfor %}
{% endif %}

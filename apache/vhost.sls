# Manage virtual host
# Enable vhost:
{% for vhost in TODO %}
{% if vhost.enabled == true %}
enable_apache_vhost_{{ vhost }}:
  cmd.run:
    - name: /usr/sbin/a2ensite {{ vhost }}
    - unless: test -L /etc/apache2/site-enabled/{{vhost}}
    - require:
      - sls: site_config_{{ vhost }}
    - watch_in:
      - service:
{% else %}
{% endif %}

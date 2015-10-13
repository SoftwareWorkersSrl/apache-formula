# Handle enabling/disabling of Apache modules
{%- for module in salt['pillar.get']('apache:modules_enabled', []) %}
enable_apache_module_{{ module }}:
  cmd.run:
    - name: /usr/sbin/a2enmod {{ module }}
    - unless: test -L /etc/apache2/mods-enabled/{{ module }}.load
    - require:
      - pkg: apache2
    - require_in:
      - service: apache2
    - watch_in:
      - service: apache2
{%- endfor %}

{%- for module in salt['pillar.get']('apache:modules_disabled', []) %}
disable_apache_module_{{ module }}:
  cmd.run:
    - name: /usr/sbin/a2dismod {{ module }}
    - onlyif: test -L /etc/apache2/mods-enabled/{{ module }}.load
    - require:
      - pkg: apache2
    - watch_in:
      - service: apache2
{%- endfor %}

# Extend apache to include a service
extend:
  apache:
    service.running:
      - name: apache2 # todo: move to map jinja
      - enable: True
      - reload: True
      - watch:
        - pkg: apache
      - require:
        - pkg: apache

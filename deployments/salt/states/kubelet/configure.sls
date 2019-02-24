configure kubelet systemd unit file:
  file.managed:
{% if grains['os'] == 'Ubuntu' %}
    - name: /lib/systemd/system/kubelet.service
{% else %}
    - name: /usr/lib/systemd/system/kubelet.service
{% endif %}
    - source: salt://kubelet/kubelet.conf
    - makedirs: True

reload systemd daemon:
  cmd.run:
    - name: systemctl daemon-reload
    - onchanges:
        - configure kubelet systemd unit file
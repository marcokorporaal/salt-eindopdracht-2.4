retrieve_from__logserver:
  cmd.run:
    - name: curl -sS -O http://10.0.6.51/nagioslogserver/scripts/setup-linux.sh
    - cwd: /

add_to_logserver:
  cmd.run:
    - name: sudo bash setup-linux.sh -s 10.0.6.51 -p 5544
    - cwd: /
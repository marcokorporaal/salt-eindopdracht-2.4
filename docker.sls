check_updates:
  cmd.run:
    - name: sudo apt-get update
    - cwd: /

install_needed_packages:
    pkg.installed:
      - pkgs:
        - apt-transport-https
        - ca-certificates
        - curl
        - gnupg-agent
        - software-properties-common

add_gpg_key:
  cmd.run:
    - name: curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    - cwd: /

add_repo:
  cmd.run:
    - name: add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
    - cwd: /

check_updates2:
  cmd.run:
    - name: sudo apt-get update
    - cwd: /

install_docker_engine:
  pkg.installed:
    - pkgs:
      - docker-ce
      - docker-ce-cli
      - containerd.io

run_hello_world:
  cmd.run:
    - name: sudo docker run hello-world
    - cwd: /
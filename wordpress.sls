install_packages:
  pkg.installed:
    - pkgs:
      - apache2
      - mysql-server
      - mysql-client
      - php
      - libapache2-mod-php
      - php-mysql
      - wordpress

create_wp_conf_file:
  cmd.run:
    - name: echo "Alias /blog /usr/share/wordpress

            <Directory /usr/share/wordpress>

            Options FollowSymLinks

            AllowOverride Limit Options FileInfo

            DirectoryIndex index.php

            Order allow,deny

            Allow from all

            </Directory>

            <Directory /usr/share/wordpress/wp-content>

            Options FollowSymLinks

            AllowOverride Limit Options FileInfo

            DirectoryIndex index.php

            Order allow,deny

            Allow from all

            </Directory>

            <Directory /usr/share/wordpress/wp-content>

            Options FollowSymLinks

            Order allow,deny

            Allow from all

            </Directory>" > /etc/apache2/sites-available/wordpress.conf
    - cwd: /

enable_site:
  cmd.run:
    - name: a2ensite wordpress
    - cwd: /

enable_url_rewriting:
  cmd.run:
    - name: a2enmod rewrite
    - cwd: /

reload_apache:
  cmd.run:
    - name: systemctl restart apache2
    - cwd: /

create_db:
  cmd.run:
    - name: mysql -u root -e "CREATE DATABASE IF NOT EXISTS wordpress;"
    - cwd: /

create_db_user:
  cmd.run:
    - name: mysql -u root -e "GRANT SELECT,INSERT,UPDATE,DELETE,CREATE,DROP,ALTER ON wordpress.* TO wordpress@localhost IDENTIFIED BY 'test';"
    - cwd: /

flush_db_priv:
  cmd.run:
    - name: mysql -u root -e "FLUSH PRIVILEGES;"
    - cwd: /

create_wp_config:
  cmd.run:
    - name: echo "<?php

            define('DB_NAME', 'wordpress');

            define('DB_USER', 'wordpress');

            define('DB_PASSWORD', 'test');

            define('DB_HOST', 'localhost');

            define('DB_COLLATE', 'utf8_general_ci');

            define('WP_CONTENT_DIR','/usr/share/wordpress/wp-content');

            ?>" > /etc/wordpress/config-10.0.6.52.php
    - cwd: /

reload_mysql:
  cmd.run:
    - name: service mysql start
    - cwd: /

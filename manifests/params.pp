# == Class: php::params
#
# PHP params class
#
# === Authors
#
# Christian "Jippi" Winther <jippignu@gmail.com>
# Robin Gloster <robin.gloster@mayflower.de>
#
# === Copyright
#
# See LICENSE file
#
class php::params {

  $fpm_service_enable = true
  $composer_source    = 'https://getcomposer.org/composer.phar'
  $composer_path      = '/usr/local/bin/composer'
  $composer_max_age   = 30

  case $::osfamily {
    'Debian': {
      $config_root         = '/etc/php5'
      $config_root_ini     = "${config_root}/mods-available"
      $common_packages     = ['php5-common']
      $cli_inifile         = "${config_root}/cli/php.ini"
      $cli_package         = 'php5-cli'
      $dev_package         = 'php5-dev'
      $fpm_config_file     = "${config_root}/fpm/php-fpm.conf"
      $fpm_inifile         = "${config_root}/fpm/php.ini"
      $fpm_package         = 'php5-fpm'
      $fpm_pool_dir        = "${config_root}/fpm/pool.d"
      $fpm_service_name    = 'php5-fpm'
      $fpm_user            = 'www-data'
      $fpm_group           = 'www-data'
      $package_prefix      = 'php5-'
      $pear_package        = 'php-pear'
      $compiler_packages   = 'build-essential'
      $manage_repos        = true
    }
    'Suse': {
      $config_root         = '/etc/php5'
      $config_root_ini     = "${config_root}/conf.d"
      $common_packages     = []
      $cli_inifile         = "${config_root}/cli/php.ini"
      $cli_package         = 'php5'
      $dev_package         = 'php5-devel'
      $fpm_config_file     = "${config_root}/fpm/php-fpm.conf"
      $fpm_inifile         = "${config_root}/fpm/php.ini"
      $fpm_package         = 'php5-fpm'
      $fpm_pool_dir        = "${config_root}/fpm/pool.d"
      $fpm_service_name    = 'php-fpm'
      $fpm_user            = 'wwwrun'
      $fpm_group           = 'www'
      $package_prefix      = 'php5-'
      $pear_package        = 'php5-pear'
      $manage_repos        = true
      case $::operatingsystem {
        'SLES': {
          $compiler_packages = 'Basis-Devel'
        }
        'OpenSuSE': {
          $compiler_packages = 'devel_basis'
        }
        default: {
          fail("Unsupported operating system ${::operatingsystem}")
        }
      }
    }
    'RedHat': {
      $config_root_ini     = '/etc/php.d'
      $common_packages     = ['php', 'php-common']
      $cli_inifile         = '/etc/php-cli.ini'
      $cli_package         = 'php-cli'
      $dev_package         = 'php-devel'
      $fpm_config_file     = '/etc/php-fpm.conf'
      $fpm_inifile         = '/etc/php.ini'
      $fpm_package         = 'php-fpm'
      $fpm_pool_dir        = '/etc/php-fpm.d'
      $fpm_service_name    = 'php-fpm'
      $fpm_user            = 'apache'
      $fpm_group           = 'apache'
      $package_prefix      = 'php-'
      $pear_package        = 'php-pear'
      $compiler_packages   = ['gcc', 'gcc-c++', 'make']
      $manage_repos        = false
    }
    'Gentoo': {
      $package             = "dev-lang/php"
      $php_slot            = '5.5'
      $php_flags           = [
        'bcmath', 'berkdb', 'bzip2', 'calendar', 'cdb', 'cjk', 'crypt',
        'ctype', 'curl', 'enchant', 'exif', 'frontbase', 'fileinfo', 'filter',
        'firebird', 'flatfile', 'ftp', 'gd', 'gdbm', 'gmp', 'hash', 'iconv',
        'imap', 'inifile', 'intl', 'iodbc', 'json', 'kerberos', 'ldap',
        'ldap-sasl', 'libedit', 'mhash', 'mssql', 'mysql', 'libmysqlclient',
        'mysqli', 'nls', 'oci8-instant-client', 'odbc', 'opcache', 'pcntl',
        'pdo', 'phar', 'posix', 'postgres', 'qdbm', 'readline', 'recode',
        'session', 'sharedmem', 'simplexml', 'snmp', 'soap', 'sockets',
        'spell', 'sqlite', 'ssl', 'sybase-ct', 'sysvipc', 'tidy', 'tokenizer',
        'truetype', 'unicode', 'wddx', 'xml', 'xmlreader', 'xmlwriter',
        'xmlrpc', 'xpm', 'xslt', 'zip', 'zlib'
      ]
      $common_packages     = []
      $config_root_ini     = '/etc/php'
      $cli_inifile         = "${config_root_ini}/cli-php${php_slot}/php.ini"
      $cli_package         = $package
      $fpm_config_file     = "${config_root_ini}/fpm-php${php_slot}/php-fpm.conf"
      $fpm_inifile         = "${config_root_ini}/fpm-php${php_slot}/php.ini"
      $fpm_package         = $package
      $fpm_pool_dir        = '/etc/php-fpm.d'
      $fpm_service_name    = 'php-fpm'
      $fpm_user            = 'www'
      $fpm_group           = 'www'
      $package_prefix      = 'dev-php/pecl-'
      $pear_package        = 'dev-php/pear'
      $compiler_packages   = []
      $manage_repos        = false
    }
    default: {
      fail("Unsupported osfamily: ${::osfamily} operatingsystem: ${::operatingsystem}, module ${module_name} only supports osfamily Debian, RedHat, Suse and Gentoo.\n
        If possible please fork this module, add the correct parameters in params.pp and open a pull request")
    }
  }
}

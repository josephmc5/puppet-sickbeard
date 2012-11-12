class sickbeard::proxy inherits sickbeard::params{
    if $proxy_nginx {
        include nginx
        nginx::resource::upstream { 'sickbeard':
            ensure  => present,
            members => "$sickbeard_host:$sickbeard_port",
        }
        nginx::resource::location { 'sickbeard':
            ensure   => present,
            proxy  => 'http://sickbeard',
            location => "$sickbeard_webroot",
            vhost    => "$external_dns",
        }
    }
}

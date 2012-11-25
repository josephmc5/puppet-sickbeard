class sickbeard::config {
    include sickbeard::proxy
    if $logrotate {
        logrotate::rule { 'sickbeard':
            path          => "$log_dir/*",
            rotate        => 5,
            size          => '100k',
            sharedscripts => true,
            postrotate    => '/usr/bin/supervisorctl restart sickbeard',
        }
    }
    file { "$log_dir":
        ensure => directory,
        owner => "$services_user",
        group => "$services_user",
    }
    file { "$base_dir/sickbeard/config/":
        ensure => directory,
        owner => "$services_user",
        group => "$services_user",
    }
    file { "$base_dir/sickbeard/config/config.ini":
        content => template('sickbeard/config.ini.erb'),
        owner => "$services_user",
        group => "$services_user",
        mode => '0644',
        require => File["$base_dir/sickbeard/config/"],
    }
    file { "$base_dir/sickbeard/config/autoProcessTV.cfg":
        content => template('sickbeard/autoProcessTV.cfg.erb'),
        owner => "$services_user",
        group => "$services_user",
        mode => '0644',
        require => File["$base_dir/sickbeard/config/"],
    }
    
}

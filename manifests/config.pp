class sickbeard::config {
    
    file { "$base_dir/sickbeard/config.ini":
        content => template('sickbeard/config.ini.erb'),
        owner => 'sickbeard',
        group => 'automators',
        mode => '0644',
    }

    file { "$base_dir/sickbeard/autoProcessTV/autoProcessTV.cfg":
        content => template('sickbeard/autoProcessTV.cfg.erb'),
        owner => 'sickbeard',
        group => 'automators',
        mode => '0644',
    }
    
}

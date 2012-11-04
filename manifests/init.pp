class sickbeard inherits sickbeard::params{
    include sickbeard::config
    include git
    
    user { 'sickbeard':
        allowdupe => false,
        ensure => 'present',
        shell => '/bin/bash',
        home => "$base_dir/sickbeard",
        password => '*',
    }
    file { "$base_dir/sickbeard":
        ensure => directory,
        owner => 'sickbeard',
        group => 'sickbeard',
        mode => '0644',
        recurse => 'true'
    }
    exec { 'download-sickbeard':
        command => "/usr/bin/git clone $url src",
        cwd     => "$base_dir/sickbeard/",
        creates => "$base_dir/sickbeard/src",
        require => Class['git'],
    }
}

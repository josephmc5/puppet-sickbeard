class sickbeard inherits sickbeard::params{

    $url = "https://github.com/midgetspy/Sick-Beard"
    
    include sickbeard::config
    
    user { 'sickbeard':
        allowdupe => false,
        ensure => 'present',
        uid => '601',
        shell => '/bin/bash',
        gid => '700',
        home => "$base_dir/sickbeard",
        password => '*',
    }

    file { "$base_dir/sickbeard":
        ensure => directory,
        owner => 'sickbeard',
        group => 'automators',
        mode => '0644',
        recurse => 'true'
    }
    
    exec { 'download-sickbeard':
        command => "/usr/bin/git clone $url sickbeard",
        cwd     => '/usr/local',
        creates => "/usr/local/sickbeard",
    }
    
    file { "/etc/init.d/sickbeard":
        content => template('sickbeard/init-rhel.erb'),
        owner => 'root',
        group => 'root',
        mode => '0755',
    }  
}

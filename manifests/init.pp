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
        recurse => 'false'
    }
    exec { 'venv-create-sickbeard':
        command => "virtualenv $venv_dir",
        cwd => "$base_dir/sickbeard",
        creates => "$base_dir/sickbeard/$venv_dir/bin/activate",
        path => '/usr/bin/',
        require => Class['python::virtualenv'],
        user => 'sickbeard',
    }
    exec { 'install-cheetah-sickbeard':
        command => "$base_dir/sickbeard/venv/bin/pip install cheetah",
        cwd => "$base_dir/sickbeard/venv",
        creates => "$base_dir/sickbeard/venv/bin/cheetah",
        path => "$base_dir/sickbeard/venv/bin",
        require => Exec['venv-create-sickbeard'],
        user => 'sickbeard',
    }   
    exec { 'download-sickbeard':
        command => "/usr/bin/git clone $url src",
        cwd     => "$base_dir/sickbeard/",
        creates => "$base_dir/sickbeard/src",
        require => Class['git'],
        user => 'sickbeard',
    }
    supervisor::service {
        'sickbeard':
            ensure => present,
            enable => true,
            stdout_logfile => "$base_dir/sickbeard/log/supervisor.log",
            stderr_logfile => "$base_dir/sickbeard/log/supervisor.log",
            command => "$base_dir/sickbeard/venv/bin/python $base_dir/sickbeard/src/SickBeard.py --config $base_dir/sickbeard/config/config.ini --datadir $base_dir/sickbeard/data",
            user => 'sickbeard',
            group => 'sickbeard',
            directory => "$base_dir/sickbeard/src/",
            require => Exec['download-sickbeard'],
    }
}

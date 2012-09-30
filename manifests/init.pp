class sickbeard( $source = 'true' ) {
	
	$version = "0.7.3"
	$package = "sickbeard-$version.tar.gz"
	$url = "https://github.com/midgetspy/Sick-Beard/tarball/master"
	
	include sickbeard::config
	
	user { 'sickbeard':
		allowdupe => false,
		ensure => 'present',
		uid => '601',
		shell => '/bin/bash',
		gid => '601',
		home => '/home/sickbeard',
		password => '*',
	}
	
	group { "sickbeard":
		allowdupe => false,
		ensure => present,
		gid => 601,
		name => 'sickbeard',
		before => User["sickbeard"]
	}
	
	exec { 'download-sickbeard':
        command => "/usr/bin/curl -L -o $package $url",
        cwd     => '/usr/local',
        creates => "/usr/local/$package",
    }
	
	file { "/usr/local/sickbeard-$version":
		ensure => directory,
		owner => 'sickbeard',
		group => 'sickbeard',
		mode => '0644',
	}
	
	exec { 'unpackage-sickbeard':
		command => "/bin/tar xzf /usr/local/$package --strip-components 1",
		cwd     => "/usr/local/sickbeard-$version",
		creates => "/usr/local/sickbeard-$version/SickBeard.py",
		user    => "sickbeard",
		group   => "sickbeard",
        require => [ User["sickbeard"], File["/usr/local/sickbeard-$version"] ],
	}
	
	file { "/usr/local/sickbeard":
	    ensure => link,
        target => "/usr/local/sickbeard-$version",
	}	
}

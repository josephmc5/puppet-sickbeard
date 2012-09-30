class sickbeard( $source = 'true' ) {
	
	$version = "0.7.3"
	$package = "sickbeard-$version.tar.gz"
	$url = "https://github.com/midgetspy/Sick-Beard/tarball/master"
	
	include sickbeard::config
	
	exec { 'download-sickbeard':
        command => "/usr/bin/curl -L -o $package $url",
        cwd     => '/usr/local',
        creates => "/usr/local/$package",
    }
	
	file { "/usr/local/sickbeard-$version":
		ensure => directory,
		owner => 'root',
		group => 'root',
		mode => '0644',
	}
	
	exec { 'unpackage-sickbeard':
		command => "/bin/tar xzf /usr/local/$package --strip-components 1",
		cwd     => "/usr/local/sickbeard-$version",
		creates => "/usr/local/sickbeard-$version/SickBeard.py",
        require => File["/usr/local/sickbeard-$version"]
	}
	
	file { "/usr/local/sickbeard":
	    ensure => link,
        target => "/usr/local/sickbeard-$version",
	}	
}

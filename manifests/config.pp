class sickbeard::config {
	
	$nzbmatrix_username = extlookup("nzbmatrix_username")
	$nzbmatrix_apikey = extlookup("nzbmatrix_apikey")
	$newzbin_username = extlookup("newzbin_username")
	$newzbin_password = extlookup("newzbin_password")
	$sab_host = extlookup("sab_host")
	$sab_apikey = extlookup("sab_apikey")
	
	$web_port = "8081"
	
	$nzb_dir = "/usr/local/SABnzbd-downloads/listen/TV"
	
	file { "/usr/local/sickbeard-$version/config.ini":
		content => template('sickbeard/config.ini.erb'),
		owner => 'sickbeard',
		group => 'sickbeard',
		mode => '0644',
        require => Exec['unpackage-sickbeard']
	}
	
}

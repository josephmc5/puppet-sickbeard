class sickbeard::config {
	
	$nzbmatrix_username = extlookup("nzbmatrix_username")
	$nzbmatrix_apikey = extlookup("nzbmatrix_apikey")
	$newzbin_username = extlookup("newzbin_username")
	$newzbin_password = extlookup("newzbin_password")
	$sab_host = extlookup("sabhost")
	$sab_apikey = extlookup("sab_apikey")
	
	$nzb_dir = "/usr/local/SABnzbd-downloads/listen/TV"
	
	file { "/usr/local/SABnzbd-$version/config.ini":
		content => template('sickbeard/config.ini.erb'),
		owner => 'root',
		group => 'root',
		mode => '0644',
        require => Exec['unpackage-sickbeard']
	}
	
}

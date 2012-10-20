class sickbeard::config {
    
    $nzbmatrix_username = extlookup("nzbmatrix_username")
    $nzbmatrix_apikey = extlookup("nzbmatrix_apikey")
    $newzbin_username = extlookup("newzbin_username")
    $newzbin_password = extlookup("newzbin_password")
    $sab_host = extlookup("sab_host")
    $sab_apikey = extlookup("sab_apikey")
    $sickbeard_host = extlookup("sickbeard_host")
    $sickbeard_port = extlookup("sickbeard_port")
    
    $nzb_dir = "/usr/local/SABnzbd-downloads/listen/TV"
    
    file { "/usr/local/sickbeard/config.ini":
        content => template('sickbeard/config.ini.erb'),
        owner => 'sickbeard',
        group => 'automators',
        mode => '0644',
    }

    file { "/usr/local/sickbeard/autoProcessTV/autoProcessTV.cfg":
        content => template('sickbeard/autoProcessTV.cfg.erb'),
        owner => 'sickbeard',
        group => 'automators',
        mode => '0644',
    }
    
}

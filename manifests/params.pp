class sickbeard::params (
    $newzbin_username = hiera("newzbin_username", ""),
    $newzbin_password = hiera("newzbin_passwd", ""),
    $nzbmatrix_username = hiera("nzbmatrix_username", ""),
    $nzbmatrix_apikey = hiera("nzbmatrix_apikey", ""),
    $sabnzbd_host = hiera("sabnzbd_host", ""),
    $sabnzbd_port = hiera("sabnzbd_port", ""),
    $sabnzbd_ssl = hiera("sabnzbd_port", "0"),
    $base_dir = hiera("app_dir", "/opt"),
    $nzb_dir = hiera("nbz_scan_dir", ""),
    $sabnzbd_apikey = hiera("sabnzbd_api_key"),
    $sickbeard_host = hiera("sickbeard_host"),
    $sickbeard_port = hiera("sickbeard_port"),
    $sickbeard_webroot = hiera("sickbeard_webroot"),
    $plex_server_host = hiera("plex_server_host", ""),
    $enable_growl = hiera("enable_growl", "0"),
    $url = hiera("sickbeard_git_url", "git://github.com/midgetspy/Sick-Beard.git"),
){
    if ($sabnzbd_ssl == '1') {
        $protocal = 'https://'
    }
    else {
        $protocal = 'http://'
    }        
    $sabnzbd_url = "$protocal$sabnzbd_host:$sabnzbd_port"
    $log_dir = "$base_dir/sickbeard/log"
}

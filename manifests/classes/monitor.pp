class nagios3::monitor {

	package { ["nagios3", "nagios-plugins"]: ensure => installed }

	service { "nagios3":
		ensure => running,
		hasstatus => true,
		enable => true,
		subscribe => [Package["nagios3"], Package["nagios-plugins"]],
	}


	Nagios_host <<||>> { notify => Exec["chown fast"]}
	Nagios_service <<||>> { notify => Exec["chown fast"]}
	Nagios_hostextinfo <<||>> { notify => Exec["chown fast"]}
	
	exec { "chown fast":
    	command => "chmod -R 644 /etc/nagios3/conf.d/",
    	notify => Service["nagios3"],
	}


}
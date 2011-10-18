class nagios3::monitor {

	package { ["nagios3", "nagios-plugins"]: ensure => installed }

	service { "nagios3":
		ensure => running,
		hasstatus => true,
		enable => true,
		subscribe => [Package["nagios3"], Package["nagios-plugins"]],
	}


	Nagios_host <<||>> { notify => Serivce["nagios3"]}
	Nagios_service <<||>> { notify => Service["nagios3"]}
}
class nagios3::export::target {

	@@nagios_host { "$fqdn":
		ensure 	=> present,
		alias	=> $hostname,
		address => $ipaddress,
		use		=> "generic-host",
		target => "/etc/nagios3/nagios_host.cfg"
	}
	
	@@nagios_service { "check_ping_${hostname}":
		check_command		=> "check_ping!100.0,20%!500.0,60%",
		use					=> "generic-service",
		host_name			=> "$fqdn",
		notification_period	=> "24x7",
		service_description	=> "${hostname}_check_ping",
		target => "/etc/nagios3/nagios_service.cfg"
	}
		
		
}
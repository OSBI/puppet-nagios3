class nagios3::export::target {
include aws
	@@nagios_host { "$fqdn":
		ensure 	=> present,
		alias	=> $hostname,
		address => $ec2_public_ipv4,
		use		=> "generic-host",
		target => "/etc/nagios3/conf.d/${fqdn}_host.cfg"
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
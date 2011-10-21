class nagios3::export::target {
if $ec2_public_ipv4 != "" {
	@@nagios_host { "$fqdn":
		ensure 	=> present,
		alias	=> $hostname,
		address => $ec2_public_ipv4,
		use		=> "generic-host",
		target => "/etc/nagios3/conf.d/${fqdn}_host.cfg"
	}
}else {
	@@nagios_host { "$fqdn":
		ensure 	=> present,
		alias	=> $hostname,
		address => $ipaddress,
		use		=> "generic-host",
		target => "/etc/nagios3/conf.d/${fqdn}_host.cfg"
	}
}
	
	
	
	@@nagios_hostextinfo { $fqdn:
         ensure => present,
         icon_image_alt => $operatingsystem,
         icon_image => "base/$operatingsystem.png",
         statusmap_image => "base/$operatingsystem.gd2",
      }
      
      
	@@nagios_service { "check_ping_${hostname}":
		check_command		=> "check_ping!100.0,20%!500.0,60%",
		use					=> "generic-service",
		host_name			=> "$fqdn",
		notification_period	=> "24x7",
		service_description	=> "${hostname}_check_ping",
		target => "/etc/nagios3/conf.d/${fqdn}_host.cfg",
	}

	#file { "/etc/nagios3/conf.d/${fqdn}_host.cfg" :
	#	mode => 644,
	#	require => Nagios_host["$fqdn"],
	#}

	@@nagios_service { "check_all_disks_${hostname}":
		check_command		=> "check_all_disks!20%!10%",
		use					=> "generic-service",
		host_name			=> "$fqdn",
		notification_period	=> "24x7",
		service_description	=> "${hostname}_check_all_disks",
		target => "/etc/nagios3/conf.d/${fqdn}_host.cfg",
	}

	@@nagios_service { "check_users_${hostname}":
		check_command		=> "check_users!20!50",
		use					=> "generic-service",
		host_name			=> "$fqdn",
		notification_period	=> "24x7",
		service_description	=> "${hostname}_check_users",
		target => "/etc/nagios3/conf.d/${fqdn}_host.cfg",
	}
	
	@@nagios_service { "check_procs_${hostname}":
		check_command		=> "check_procs!250!400",
		use					=> "generic-service",
		host_name			=> "$fqdn",
		notification_period	=> "24x7",
		service_description	=> "${hostname}_check_procs",
		target => "/etc/nagios3/conf.d/${fqdn}_host.cfg",
	}
	
	@@nagios_service { "check_load_${hostname}":
		check_command		=> "check_load!5.0!4.0!3.0!10.0!6.0!4.0",
		use					=> "generic-service",
		host_name			=> "$fqdn",
		notification_period	=> "24x7",
		service_description	=> "${hostname}_check_load",
		target => "/etc/nagios3/conf.d/${fqdn}_host.cfg",
	}
}
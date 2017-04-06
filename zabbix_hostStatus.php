#!/usr/bin/php
<?php
/*
 * Check & returns the monitoring & maintenance status of a host in zabbix
 *
 * @author Braxton Householder <braxton.householder@bodybuilding.com>
 *
 */

// Params
$ops_dir = $_SERVER['HOME'] . '/git';

// Load required libraries
require_once "$ops_dir/scripts/zabbix/ZabbixAPI.class.objects.php";

// Get input
if (!isset($argv[1])) {
  echo "Missing host argument" . "\n";
  exit(1);
}

// Set Host vars
$all_hosts = explode('.', $argv[1]);
$host = $argv[1];
$short_host = array_shift($all_hosts);
$domain = implode('.', $all_hosts);

// Zabbix connection shiz
$zabbix_url = 'http://zabbix.' . $domain . '/';
$zabbix_user = 'api';
$zabbix_pass = '8PwhVelE';


// Instantiate the object for the connection
$zbx = new ZabbixAPI();

// Login to each
if (!$zbx->login($zabbix_url, $zabbix_user, $zabbix_pass)) {
  die("Unable to login to zabbix API - $zabbix_url" . "\n");
}

// Get hosts status
$zabbix_data = $zbx->fetch_array('host', 'get', array('filter' => array('host' => $short_host), 'output' => 'extend'));


echo "$host:" . "\n";
// Check Maintenance
if ($zabbix_data[0]['status'] == 0) {
  echo "-- Monitoring: Enabled" . "\n";
} else {
  echo "-- Monitoring: Disabled" . "\n";
}

// Check maintenance
if ($zabbix_data[0]['maintenance_status'] == 0) {
  echo "-- Maintenance: Disabled (Not in Maintenance)" . "\n";
} else {
  echo "-- Maintenance: Enabled (In Maintenance)" . "\n";
}

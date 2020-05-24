<?php

ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);
?>


<?php

	
function getConnection() {

$servername = "localhost:3307";
$db = "activitiesapp";
$username = "root";
$password = "root";

	
	
//$servername = "database.lcn.com";
//$db = "boomtreecreative_com_faciliteiten";
//$username = "LCN257032_root";
//$password = "7A5T#r_$C!Z$";
	
	

	
	try {
		$conn = new PDO("mysql:host=$servername;dbname=" . $db, $username, $password);
		$conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION); // set the PDO error mode to exception
		//echo "<p>Connected successfully</p>"; 
		return $conn;
	}
	catch(PDOException $e)
	{
		//echo "Connection failed: " . $e->getMessage();
		return false;
	}
	
}
?>








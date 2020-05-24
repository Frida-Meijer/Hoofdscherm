
	<?php
	include 'connect.php';
	?>


	<?php


	$conn = getConnection();
	$param1 = (isset($_GET['id']) ? $_GET['id'] : 0); // default to 0 to include all
	$param2 =  (isset($_GET['limit']) ? $_GET['limit'] : "0,5"); //"LIMIT 0,24"; //paging support

	$sql = ""; //FUNKY ERROR



	//echo "Connected successfully"; 


		$sql = "SELECT DISTINCT `CategoryName` FROM `categories`";


	//echo($sql);

	$stmt = $conn->prepare($sql); 
	$stmt->execute();


	/* Fetch all of the remaining rows in the result set */
	//print("Fetch all of the remaining rows in the result set:\n");
	$result = $stmt->fetchAll(\PDO::FETCH_ASSOC);
		
		
	//echo json_encode($result);
	//print_r($result);
	print_r(json_encode($result));
	$conn = null; //close connection
		
		
	?>









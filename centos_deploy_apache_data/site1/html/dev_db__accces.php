<?php
$user = "userdev";
$password = "passdev";
$database = "dev";
$table = "todo_list";
$servername = "10.250.28.172";


try {
	  $db = new PDO("mysql:host=$servername;dbname=$database", $user, $password);
	    echo "<h2>$database</h2><ol>";
	    foreach($db->query("SELECT content FROM $table") as $row) {
		        echo "<li>" . $row['content'] . "</li>";
			  }
	      echo "</ol>";
} catch (PDOException $e) {
	    print "Error!: " . $e->getMessage() . "<br/>";
	        die();
}


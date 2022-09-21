<?php

$socket = fsockopen("localhost", "9518", $errno, $errstr); 
include './reply.php';


# command input
if (isset($argv[1])) { $command = $argv[1]; }
if (isset($argv[2])) { $argument = $argv[2]; }
if (isset($argv[3])) { $data0 = $argv[3]; }
if (isset($argv[4])) { $data1 = $argv[4]; }

if (isset($command)){
    $exec = $command;
    if (isset($argument)){
        $exec .= " $argument";
        if (isset($data0)){
            $exec .= " $data0";
            if (isset($data1)){
                $exec .= " $data1";
            }
        }
    }
}

if($socket) { 
    echo "Connected \n"; 
} else { 
    echo "Connection failed! \n"; 
} 

function fwrite_stream($fp, $string) {
    for ($written = 0; $written < strlen($string); $written += $fwrite) {
        $fwrite = fwrite($fp, substr($string, $written));
        if ($fwrite === false) {
            return $written;
        }
    }
    return $written;
}

// echo $exec;
fwrite_stream($socket, "$exec \n"); 

// $buffer = ""; 

// while(!feof($socket)) 
// { 
//     $buffer .= fgets($socket, 4096); 
// } 

while (($buffer = fgets($socket, 4096)) !== false) {
    $rpy_arry = explode(" ", "$buffer");
    if (isset($rpy_arry[0])) { $r0 = $rpy_arry[0]; }
    if (isset($rpy_arry[1])) { $r1 = $rpy_arry[1]; }
    if (isset($r0)) { echo $r0; }
    if (isset($r1)) { echo $r1; }

    // if ( $r0 == "$ack\n" ){
    //     echo "ack \n";
    // }

    if ( $r0 == "$inx\n" ){
        echo "inx \n";
        exit(1);
    }
    if ( $r0 == "$cls\n" ){
        echo "cls \n";
        exit(0);
    }

    if ( $r0 == "$req\n" ){
        echo "req \n";
        exit(0);
    }

    // if ( $r0 == "$req\n" ){
    //     echo "req \n";
    //     }
}


// print_r($buffer); 
// echo ""; 
// var_dump($buffer); 

fclose($socket); 
 exit(0);
?> 
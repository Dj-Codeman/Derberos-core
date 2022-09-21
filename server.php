<?php


$addr="127.0.0.1";
$port="9518";

# tmp functions
function reply($stus) {
    global $msgsock, $socket, $msdata;
    # source status file
    include './reply.php';
    if ( $stus == "ack" ) {
    $stus = "$ack";
    } elseif ($stus == "apl" ) {
        $stus = $apl;
    } elseif ($stus == "sub" ) {
        $stus = $sub;
    } elseif ($stus == "svd" ) {
        $stus = $svd;
    } elseif ($stus == "req" ) {
        $stus = $req;
    } elseif ($stus == "inc" ) {
        $stus = $inc;
    } elseif ($stus == "dne" ) {
        $stus = $dne;
    } elseif ($stus == "yes" ) {
        $stus = $yes;
    } elseif ($stus == "noo" ) {
        $stus = $noo;
    } elseif ($stus == "nof" ) {
        $stus = $nof;
    } elseif ($stus == "rty" ) {
        $stus = $rty;
    } elseif ($stus == "inv" ) {
        $stus = $inv;
    } elseif ($stus == "uau" ) {
        $stus = $uau;
    } elseif ($stus == "nex" ) {
        $stus = $nex;
    } elseif ($stus == "nfx" ) {
        $stus = $nfx;
    } elseif ($stus == "inx" ) {
        $stus = $inx;
    } elseif ($stus == "msg" ) {
        $stus = $msdata;
    } elseif ($stus == "cls" ) {
        $stus = $cls;
    } else {
        $stus = $inx;
    }
    $stus .= "\n";
    socket_write($msgsock, $stus, strlen($stus));
}


# creating socket and error msg

if (($socket = socket_create(AF_INET, SOCK_STREAM, SOL_TCP)) === false) {
    echo "Creating socket failed".socket_strerror(socket_last_error())."\n";
}

if (socket_bind($socket, $addr, $port) === false) {
    echo "Bind error".socket_strerror(socket_last_error($socket)) ."\n";
}


if (socket_listen($socket, 5) === false) {
    echo "Listen Failed ".socket_strerror(socket_last_error($socket)) . "\n";
}

do {
    if (($msgsock = socket_accept($socket)) === false) {
        echo "Error: socket_accept: " . socket_strerror(socket_last_error($socket)) . "\n";
        break;
    }

    /* Send Welcome message. */
        # ack connection
        reply("ack");

    // Listen to user input
    do {
        if (false === ($buf = socket_read($msgsock, 4096, PHP_NORMAL_READ))) {
            echo "socket read error: ".socket_strerror(socket_last_error($msgsock)) . "\n";
            break 2;
        }
        if (!$buf = trim($buf)) {
            continue;
        }


        $cmd_array = explode(" ","$buf");

        if (isset($cmd_array[0])) { $command = $cmd_array[0]; }
        if (isset($cmd_array[1])) { $argument = $cmd_array[1]; }
        if (isset($cmd_array[2])) { $data0 = $cmd_array[2]; }
        if (isset($cmd_array[3])) { $data1 = $cmd_array[3]; }

        var_dump($cmd_array);

        if (isset($buf)) {
            # fix logic branch here 
            if ($command == "auth") {
                if ((isset($argument)) && ($argument == "-n")) {
                    reply("noo");
                    # bash check session file
                } elseif (!isset($argument)) {
                    reply("req");
                } elseif (($argument == "-u") && (!isset($data0))) {
                    # dbros authenticate 
                    reply("ack");
                    reply("req");
                } else {
                    if (isset($data1)){
                        reply("ack");
                        #   run validation on $data1
                        # if sucess 
                        reply("cls");
                    } else {
                        reply("ack");
                        reply("req");
                    }
                }
            } else {
                reply("inx");
            }



            // $talkback .= "$command $argument $data \n";
        }



        // Reply to user with their message
        
        // $talkback = "PHP: You said '$buf'.\n";
        // socket_write($msgsock, $talkback, strlen($talkback));
        
    } while (true);
    socket_close($msgsock);

} while (true);
socket_close($socket);
 exit(1);
?>
set ns [new Simulator]
set n1 [$ns node]
set n2 [$ns node]
$ns duplex-link $n1 $n2 1Mb 10ms DropTail
$ns at 0.1 "finish"
proc finish {} { exit 0 }
$ns run

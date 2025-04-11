# Define a simulator instance
set ns [new Simulator]

# Define trace and NAM output files (ensure that "traces" directory exists)
set tracefile [open "traces/simulation.tr" w]
$ns trace-all $tracefile

set namfile [open "traces/simulation.nam" w]
$ns namtrace-all $namfile

# Create network topology (nodes, links, queues)
set n1 [$ns node]
set n2 [$ns node]
$ns duplex-link $n1 $n2 2Mb 10ms DropTail

# Define a TCP agent and attach it to node n1
set tcp [new Agent/TCP]
$ns attach-agent $n1 $tcp

# Define a TCPSink and attach it to node n2
set sink [new Agent/TCPSink]
$ns attach-agent $n2 $sink

# Connect the TCP agent to the sink
$ns connect $tcp $sink

# Create an FTP application to generate traffic over the TCP connection
set ftp [new Application/FTP]
$ftp attach-agent $tcp

# Schedule the start and end of the FTP session
$ns at 0.1 "$ftp start"
$ns at 10.0 "finish"

# Define finish procedure to close files and launch NAM
proc finish {} {
    global ns tracefile namfile
    close $tracefile
    close $namfile
    exec nam traces/simulation.nam &
    exit 0
}

# Run the simulation
$ns run

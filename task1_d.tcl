# create a simulator object
set ns [new Simulator]

# define different colors for nam data flows
$ns color 1 blue
$ns color 2 red
$ns color 3 green
$ns color 4 yellow

# open the nam trace file
set nam_trace_fd [open task1_out.nam w]
$ns namtrace-all $nam_trace_fd

# necessary to remember the old bandwidth
set packetSize 1000

#Define a 'finish' procedure
proc finish {} {
        global ns nam_trace_fd

        # close the nam trace file
        $ns flush-trace
        close $nam_trace_fd

        # execute nam on the trace file
        exit 0
}

# create four nodes
set node1 [$ns node]
set node2 [$ns node]
set node3 [$ns node]
set node4 [$ns node]

# create links between the nodes
$ns duplex-link $node1 $node3 2Mb 10ms DropTail 
$ns duplex-link $node2 $node3 2Mb 10ms DropTail 
$ns duplex-link $node3 $node4 1Mb 10ms DropTail 
$ns queue-limit $node3 $node4 40

# monitor the queue for the link between node 2 and node 3
$ns duplex-link-op $node3 $node4 queuePos 0.5

#Setting for nam
$ns duplex-link-op $node1 $node3 orient right-down
$ns duplex-link-op $node2 $node3 orient right-up
$ns duplex-link-op $node3 $node4 orient right


# First TCP traffic source
# create the first TCP agent and attach it to node node1
set tcp1 [new Agent/TCP]
$ns attach-agent $node1 $tcp1
$tcp1 set fid_ 1		# blue color
$tcp1 set class_ 1

# window_ * (packetsize_ + 40) / RTT
$tcp1 set window_ 5 
$tcp1 set packetSize_ $packetSize

# create a TCP sink agent and attach it to node node4
set sink [new Agent/TCPSink]
$ns attach-agent $node4 $sink

# connect both agents
$ns connect $tcp1 $sink

# create an FTP source "application";
set ftp1 [new Application/FTP]
$ftp1 attach-agent $tcp1


# Second TCP traffic source
# create the second TCP agent and attach it to node node2
set tcp2 [new Agent/TCP]
$ns attach-agent $node2 $tcp2
$tcp2 set fid_ 2		# red color
$tcp2 set class_ 2

# window_ * (packetsize_ + 40) / RTT
$tcp2 set window_ 5 
$tcp2 set packetSize_ $packetSize

# create a second TCP sink agent and attach it to node node4
set sink2 [new Agent/TCPSink]
$ns attach-agent $node4 $sink2

# connect tcp2 source to tcp sink at node 4
$ns connect $tcp2 $sink2

# create a second FTP source "application";
set ftp2 [new Application/FTP]
$ftp2 attach-agent $tcp2


# schedule events for all the flows
$ns at 0.1 "$ftp1 start"
$ns at 0.1 "$ftp2 start"
$ns at 5.0 "$ftp2 stop"
$ns at 5.0 "$ftp1 stop"

# call the finish procedure after 6 seconds of simulation time
$ns at 6 "finish"

# run the simulation
$ns run


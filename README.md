CSC 645 NS2 Lab
ABRAHAM ZEPEDA
911187672

(a) Based on the execution results of the Awk commands, what is the total traffic of each flows? What is the overall packet loss rate of the two TCP flows? 
What is the ratio of throughput between the two TCP flows?

ANS:

The total traffic of each flow is 95,720 bytes.

No packets were dropped.

The tcp ratio of both flows is 0.5.

(b) Revise the sample code "task1_sample.tcl" so that the window size of the second TCP flow (tcp2) changes from 1 to 25, and save it a new file “task1_b.tcl”. 
Use the Awk com- mands to compute the total traffic of each flow. 
How does the packet loss rate change? Which flow uses more bandwidth in the bottleneck from node 3 to node 4? 
What is the reason?

ANS:

Traffic of tcp1: 82,200
Traffic of tcp2: 433,720

Total dropped packets: 14,560

Tcp2's ratio is 0.8407, and therefore uses more of the flow from node 3 to 4. 

This is because tcp2 is allowed to send more data at once, since it's window size is 25 times larger than tcpl's.


(c) Revise the sample code "task1_sample.tcl" so that the window size of both the TCP flows are set to 5, and save it as a new file “task1_c.tcl”. 
Use the Awk commands to com- pute the total traffic of each flows. 
How does the packet loss rate change? Do both flows receive a "fair share" of the available bandwidth of the bottleneck link?

ANS:

Traffic of tcp1: 383,800
Traffic of tcp2: 217,400

Total dropped packets: 11,440

Tcp1 ratio: 0.6384
Tcp2 ratio: 0.3616

Since tcp1 has a higher ratio of traffic, the bandwidth is not fairly shared.

(d) Revise the sample code "task1_sample.tcl" so that the window size of both the TCP flows are set to 5 and the queue buffer size for the link from node 3 to node 4 is set to 40 packets. 
Save the new file as “task1_d.tcl”. Use the Awk commands to compute the total traffic of each flows. 
How does the packet loss rate change? Do both flows receive a "fair share" of the available bandwidth of the bottleneck link?

ANS:

Traffic of tcp1: 305,800
Traffic of tcp2: 303,720

Total dropped packets: 0

Tcp1 ratio: 0.5017
Tcp2 ratio: 0.4983

Both flows have virtually the same ratio, so they are both receiving a "fair share."

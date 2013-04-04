From: CF Adad <cfadad@rocketmail.com>
Subject: AM3517 DaVinci EMAC Ethernet performance issues
Date: Wed, 3 Apr 2013 19:36:07 -0700 (PDT)
Message-ID: <1365042967.79225.YahooMailNeo@web160505.mail.bf1.yahoo.com>
Reply-To: CF Adad <cfadad@rocketmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from nm21.bullet.mail.bf1.yahoo.com ([98.139.212.180]:37912 "EHLO
	nm21.bullet.mail.bf1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932247Ab3DDCgI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 3 Apr 2013 22:36:08 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

(( Attempting to re-post this since Yahoo! shipped the previous one as =
HTML... ))

All,

My team is presently seeing *extremely poor* (on the order of single-di=
git Mbps) Ethernet performance out of an AM3517-based COM (Technexion's=
 TAM-3517 in this case) when it _transmits TCP_. Receiving TCP appears =
to happen fine, and our UDP transmit and receive appears pretty solid. =
Is anyone else seeing anything like this on an AM3517-based platform? (=
I have a CompuLab CM-T3517 that I'll try to get to by the end of this w=
eek for comparison.)

I reported a similar, perhaps related, issue nearly a year ago at http:=
//thread.gmane.org/gmane.linux.ports.arm.omap/78647 & http://e2e.ti.com=
/support/arm/sitara_arm/f/416/t/195442.aspx, and never heard much in re=
sponse. Though the performance of the EMAC port has never been stellar =
(others have admitted that), we've continued working with the COM becau=
se the network performance our tests were seeing at the time was more t=
han adequate to our tasks at hand. Recently however, while testing our =
latest hardware we hit this nasty performance snag and that caused us t=
o revisit this entirely. Frustratingly, these tests are showing that th=
at performance now appears to be way worse than anything we previously =
saw, on both our custom hardware and dev. kit systems.

The behavior is easily characterized using 'iperf'. If the TAM hosts th=
e iperf server (i.e. receives TCP using 'iperf -s'), a client can conne=
ct to it and run ~90Mbps forever. That's perfect. If those roles are re=
versed however, and the TAM plays client (i.e. transmits TCP using 'ipe=
rf -i 10 -t 60 -c <server_ip>'), the data rate becomes sporadic and oft=
en plummets or even times out. Please see captures below. Although it m=
isbehaves dramatically, the driver never registers a single error, xrun=
, nothing...

*** EMAC running server (receiving TCP) ***
$ iperf -i 10 -t 60 -c 10.22.0.17
------------------------------------------------------------
Client connecting to 10.22.0.17, TCP port 5001
TCP window size: 23.5 KByte (default)
------------------------------------------------------------
[ 3] local 10.22.255.5 port 60936 connected with 10.22.0.17 port 5001
[ ID] Interval Transfer Bandwidth
[ 3] 0.0-10.0 sec 113 MBytes 94.5 Mbits/sec
[ 3] 10.0-20.0 sec 112 MBytes 94.3 Mbits/sec
[ 3] 20.0-30.0 sec 112 MBytes 94.0 Mbits/sec
[ 3] 30.0-40.0 sec 112 MBytes 94.2 Mbits/sec
[ 3] 40.0-50.0 sec 112 MBytes 94.3 Mbits/sec
[ 3] 50.0-60.0 sec 112 MBytes 94.0 Mbits/sec
[ 3] 0.0-60.0 sec 674 MBytes 94.2 Mbits/sec

*** EMAC running client (transmitting TCP) ***
# iperf -i 10 -t 60 -c 10.22.255.5
------------------------------------------------------------
Client connecting to 10.22.255.5, TCP port 5001
TCP window size: 19.6 KByte (default)
------------------------------------------------------------
[ 3] local 10.22.0.17 port 43185 connected with 10.22.255.5 port 5001
[ ID] Interval Transfer Bandwidth
[ 3] 0.0-10.0 sec 92.5 MBytes 77.6 Mbits/sec
[ 3] 10.0-20.0 sec 102 MBytes 85.3 Mbits/sec
[ 3] 20.0-30.0 sec 98.6 MBytes 82.7 Mbits/sec
[ 3] 30.0-40.0 sec 55.4 MBytes 46.5 Mbits/sec
[ 3] 40.0-50.0 sec 2.73 MBytes 2.29 Mbits/sec
[ 3] 50.0-60.0 sec 1.26 MBytes 1.06 Mbits/sec
[ 3] 0.0-64.5 sec 352 MBytes 45.8 Mbits/sec

Since discovering this behavior at the end of last week, I have systema=
tically gone back through our generations of our custom carrier boards =
as well as the TAM's Twister dev kit and proven that the issue is now p=
resent on everything we have. Since the behavior appears to have change=
d since we last aggressively tested this nearly a year ago, I'm assumin=
g a slight software alteration somewhere is largely to blame. So I walk=
ed back through all of my recorded boot logs and retried running our ma=
in previous kernels (l-o 3.4-rc6 and l-o 3.5-rc4) as well as older vers=
ions of the bootloaders. In every case, the problem has remained.

The latest software we're running is still based on linux-omap's 3.5-rc=
4. We locked the kernel down there several months ago in order to stage=
 for release, and until we discovered this last week it has been runnin=
g _very_ stably. I have, however, continued to monitor the lists and ma=
jor patch sites looking to see if any major bug fixes are released in t=
he drivers we're using, etc. Since discovering this issue, I've also go=
ne ahead and backported in many of the patches released by the folks I =
CC'd onto this message - at least those I could easily pull in without =
upgrading the kernel. Unless I'm overlooking something, it now looks to=
 me like I have everything but the DT and OF stuff worked into our kern=
el. (I'm assuming that DT and OF stuff really does not impact performan=
ce. Is that a safe assumption?)=A0 Unfortunately, pulling in those chan=
ges has not corrected this issue.

We've done network captures on our link, and the problem is very strang=
e. The iperf client transmits data quickly and steadily for a while, bu=
t then all the sudden just stops. In the captures you can see an ACK co=
me back from the server for the frame that was just sent, but then inst=
ead of immediately sending the next one it just sits there for sometime=
s several seconds. Then, it suddenly picks back up and starts running a=
gain. It's as though it just paused due to lack of data. Again, no erro=
rs or xruns are ever triggered, and even with full NETIF_MSG debugging =
on, we're getting nothing.

One other note: The more I play around with this the more I'm noticing =
that manually increasing the TCP window size helps things dramatically.

*** EMAC running client (transmitting TCP) WITH larger window ***
# iperf -i 10 -t 60 -c 10.22.255.5 -w 85K
------------------------------------------------------------
Client connecting to 10.22.255.5, TCP port 5001
TCP window size: 170 KByte (WARNING: requested 85.0 KByte)
------------------------------------------------------------
[ 3] local 10.22.0.17 port 43189 connected with 10.22.255.5 port 5001
[ ID] Interval Transfer Bandwidth
[ 3] 0.0-10.0 sec 105 MBytes 88.3 Mbits/sec
[ 3] 10.0-20.0 sec 92.0 MBytes 77.2 Mbits/sec
[ 3] 20.0-30.0 sec 94.8 MBytes 79.6 Mbits/sec
[ 3] 30.0-40.0 sec 88.3 MBytes 74.1 Mbits/sec
[ 3] 40.0-50.0 sec 95.8 MBytes 80.3 Mbits/sec
[ 3] 50.0-60.0 sec 105 MBytes 87.9 Mbits/sec
[ 3] 0.0-60.0 sec 581 MBytes 81.2 Mbits/sec

While encouraging, I know I should not have to do this. This feels like=
 it's simply masking the real problem.

I've looked closely sysctl parameters associated with the ipv4 stuff (w=
e're not using ipv6), and have contrasted that against parameters for s=
everal systems around here. Again, I'm not finding anything obvious.

Has anyone seen anything like this out of TI's DaVinci EMAC before and/=
or does anyone have any idea what could be causing this? Any and all he=
lp in tracking this down would be greatly appreciated! To anyone willin=
g to help, I'll happily provide as much info as I can. Please just ask.

While I would prefer to not do so given that it would void the months o=
f testing we've already done, if necessary I can look into pushing our =
kernel forward toward the leading edge of the l-o series.=A0 However, I=
 would prefer other efforts be exhausted first given the sacrifice in t=
esting that would require.

Thanks in advance and thanks to all who contribute to these excellent o=
pen source tools and products.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

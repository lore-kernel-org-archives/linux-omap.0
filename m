From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: OMAP4430 SDP with KS8851: very slow networking
Date: Thu, 6 Dec 2018 13:22:56 +0000
Message-ID: <20181206132256.GT30658@n2100.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
Sender: netdev-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, netdev@vger.kernel.org, Tony Lindgren <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org

Hi,

I'm experiencing very slow networking on my OMAP4430 SDP board, which
uses the SPI ethernet chip KS8851.

The initial symptom I noticed is that tftping the 3MB kernel image
inside Linux takes more than 5 minutes.  Running tcpdump on the tftp
server shows:

13:13:29.018377 IP 192.168.1.189.45542 > 192.168.0.4.40620: UDP, length 4
13:13:29.020683 IP 192.168.1.189.45542 > 192.168.0.4.40620: UDP, length 4
13:13:29.022280 IP 192.168.0.4.40620 > 192.168.1.189.45542: UDP, length 516
13:13:29.078391 IP 192.168.1.189.45542 > 192.168.0.4.40620: UDP, length 4
13:13:29.080696 IP 192.168.1.189.45542 > 192.168.0.4.40620: UDP, length 4
13:13:29.082291 IP 192.168.0.4.40620 > 192.168.1.189.45542: UDP, length 516
13:13:29.138377 IP 192.168.1.189.45542 > 192.168.0.4.40620: UDP, length 4
13:13:29.140563 IP 192.168.1.189.45542 > 192.168.0.4.40620: UDP, length 4
13:13:29.142205 IP 192.168.0.4.40620 > 192.168.1.189.45542: UDP, length 516
13:13:29.198365 IP 192.168.1.189.45542 > 192.168.0.4.40620: UDP, length 4
13:13:29.200709 IP 192.168.1.189.45542 > 192.168.0.4.40620: UDP, length 4
13:13:29.202292 IP 192.168.0.4.40620 > 192.168.1.189.45542: UDP, length 516
13:13:29.258375 IP 192.168.1.189.45542 > 192.168.0.4.40620: UDP, length 4
13:13:29.260708 IP 192.168.1.189.45542 > 192.168.0.4.40620: UDP, length 4
13:13:29.262292 IP 192.168.0.4.40620 > 192.168.1.189.45542: UDP, length 516

which is about 512 bytes every 60ms.  The two length 4 UDPs are the
ACK packets - one of which is a repeated transmission for each
packet.

I also see NFS timing out.

pings also have weirdness:

root@omap-4430sdp:~# ping -c 10 192.168.0.4
PING 192.168.0.4 (192.168.0.4): 56 data bytes
64 bytes from 192.168.0.4: seq=0 ttl=64 time=107.635 ms
64 bytes from 192.168.0.4: seq=1 ttl=64 time=1011.689 ms
64 bytes from 192.168.0.4: seq=2 ttl=64 time=5.157 ms
64 bytes from 192.168.0.4: seq=3 ttl=64 time=1021.820 ms
64 bytes from 192.168.0.4: seq=4 ttl=64 time=4.395 ms
64 bytes from 192.168.0.4: seq=5 ttl=64 time=4.669 ms
64 bytes from 192.168.0.4: seq=6 ttl=64 time=371.735 ms
64 bytes from 192.168.0.4: seq=7 ttl=64 time=882.598 ms
64 bytes from 192.168.0.4: seq=8 ttl=64 time=31.372 ms
64 bytes from 192.168.0.4: seq=9 ttl=64 time=2010.772 ms

--- 192.168.0.4 ping statistics ---
10 packets transmitted, 10 packets received, 0% packet loss
round-trip min/avg/max = 4.395/545.184/2010.772 ms

If I ping the board remotely:

$ ping -i .2 192.168.1.189
PING 192.168.1.189 (192.168.1.189) 56(84) bytes of data.
64 bytes from 192.168.1.189: icmp_req=1 ttl=64 time=2033 ms
64 bytes from 192.168.1.189: icmp_req=2 ttl=64 time=1825 ms
64 bytes from 192.168.1.189: icmp_req=3 ttl=64 time=1616 ms
64 bytes from 192.168.1.189: icmp_req=4 ttl=64 time=1417 ms
64 bytes from 192.168.1.189: icmp_req=5 ttl=64 time=1218 ms
64 bytes from 192.168.1.189: icmp_req=6 ttl=64 time=1018 ms
64 bytes from 192.168.1.189: icmp_req=7 ttl=64 time=819 ms
64 bytes from 192.168.1.189: icmp_req=8 ttl=64 time=610 ms
64 bytes from 192.168.1.189: icmp_req=9 ttl=64 time=411 ms
64 bytes from 192.168.1.189: icmp_req=10 ttl=64 time=202 ms
64 bytes from 192.168.1.189: icmp_req=11 ttl=64 time=4.46 ms
64 bytes from 192.168.1.189: icmp_req=12 ttl=64 time=263 ms
64 bytes from 192.168.1.189: icmp_req=13 ttl=64 time=54.5 ms
64 bytes from 192.168.1.189: icmp_req=14 ttl=64 time=1399 ms
64 bytes from 192.168.1.189: icmp_req=15 ttl=64 time=1199 ms
64 bytes from 192.168.1.189: icmp_req=16 ttl=64 time=990 ms
64 bytes from 192.168.1.189: icmp_req=17 ttl=64 time=781 ms
64 bytes from 192.168.1.189: icmp_req=18 ttl=64 time=572 ms
64 bytes from 192.168.1.189: icmp_req=19 ttl=64 time=372 ms
64 bytes from 192.168.1.189: icmp_req=20 ttl=64 time=163 ms
^C
--- 192.168.1.189 ping statistics ---
22 packets transmitted, 20 received, 9% packet loss, time 4302ms
rtt min/avg/max/mdev = 4.468/848.854/2033.873/592.100 ms, pipe 10

It looks very much like a receive problem - in that the board is not
always aware of a packet having been received until it attempts to
transmit (eg, in the case of TFTP, when it re-sends the ACK after a
receive timeout, it _then_ notices that there's a packet waiting.)

I'm not quite sure when this cropped up as I no longer regularly
update and run my nightly boot tests, but I think 4.18 was fine.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up

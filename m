From: CF Adad <cfadad@rocketmail.com>
Subject: Re: Problems in the DaVinci EMAC driver & AM35xx?
Date: Fri, 15 Jun 2012 12:28:53 -0700 (PDT)
Message-ID: <1339788533.89799.YahooMailNeo@web125202.mail.ne1.yahoo.com>
References: <1339627132.52592.YahooMailNeo@web125204.mail.ne1.yahoo.com>
Reply-To: CF Adad <cfadad@rocketmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from nm33-vm7.bullet.mail.ne1.yahoo.com ([98.138.229.71]:44185 "HELO
	nm33-vm7.bullet.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753900Ab2FOT2y convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 15 Jun 2012 15:28:54 -0400
In-Reply-To: <1339627132.52592.YahooMailNeo@web125204.mail.ne1.yahoo.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

We continue to try to sort this out.=A0 Ignoring the errors for a momen=
t, has anyone else experienced the performance slowdown quoted below be=
tween two EMACs?


If not, could anyone with two AM3517-baed platforms with the EMACs expo=
sed please test this for us?=A0 We've run several tests between all the=
 hardware we have available, and all perform like this.=A0 Connecting a=
n EMAC to another EMAC and testing with iperf ("iperf -s" on one side, =
"iperf -c <IP>" on the other) shows the performance drop vs. connecting=
 the same EMAC to nearly any other non-EMAC NIC and running the same te=
st, even through the same infrastructure.


Our theory is that this could be a driver issue that when only 1 side h=
as it, performance is fine.=A0 However, if both sides have the same iss=
ue, as in the case of EMAC to EMAC, the performance degrades significan=
tly.

Thanks again for looking.

------------------------------------------------------------
Server listening on TCP port 5001
TCP window size: 85.3 KByte (default)
------------------------------------------------------------
{{ DaVinci EMAC server, PC client }}


[=A0 4] local 192.168.2.192 port 5001 connected with 192.168.2.40 port =
44452
[ ID] Interval=A0=A0=A0=A0=A0=A0 Transfer=A0=A0=A0=A0 Bandwidth
[=A0 4]=A0 0.0-10.1 sec=A0=A0=A0 114 MBytes=A0 94.1 Mbits/sec
[=A0 5] local 192.168.2.192 port 5001 connected with 192.168.2.40 port =
44459
[=A0 5]=A0 0.0-10.1 sec=A0=A0=A0 114 MBytes=A0 94.0 Mbits/sec
[=A0 4] local 192.168.2.192 port 5001 connected with 192.168.2.40 port =
44467
[=A0 4]=A0 0.0-10.1 sec=A0=A0=A0 113 MBytes=A0 94.1 Mbits/sec
[=A0 5] local 192.168.2.192 port 5001 connected with 192.168.2.40 port =
44474
[=A0 5]=A0 0.0-10.1 sec=A0=A0=A0 114 MBytes=A0 94.1 Mbits/sec
[=A0 4] local 192.168.2.192 port 5001 connected with 192.168.2.40 port =
44481
[=A0 4]=A0 0.0-10.1 sec=A0=A0=A0 114 MBytes=A0 94.1 Mbits/sec
[=A0 5] local 192.168.2.192 port 5001 connected with 192.168.2.40 port =
44488
[=A0 5]=A0 0.0- 9.8 sec=A0=A0=A0 110 MBytes=A0 94.1 Mbits/sec

{{ same DaVinci EMAC server, still running, just changed to DaVinci EMA=
C client }}

[=A0 5] local 192.168.2.192 port 5001 connected with 192.168.2.74 port =
37325
[=A0 5]=A0 0.0-10.4 sec=A0 73.9 MBytes=A0 59.6 Mbits/sec
[=A0 6] local 192.168.2.192 port 5001 connected with 192.168.2.74 port =
37326
[=A0 6]=A0 0.0-10.8 sec=A0 61.5 MBytes=A0 47.8 Mbits/sec
[=A0 5] local 192.168.2.192 port 5001 connected with 192.168.2.74 port =
37327
[=A0 5]=A0 0.0-10.3 sec=A0 64.6 MBytes=A0 52.6 Mbits/sec
[=A0 6] local 192.168.2.192 port 5001 connected with 192.168.2.74 port =
37328
[=A0 6]=A0 0.0-10.0 sec=A0 78.2 MBytes=A0 65.5 Mbits/sec
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

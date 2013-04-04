From: CF Adad <cfadad@rocketmail.com>
Subject: Re: AM3517 DaVinci EMAC Ethernet performance issues
Date: Thu, 4 Apr 2013 07:18:25 -0700 (PDT)
Message-ID: <1365085105.58314.YahooMailNeo@web160505.mail.bf1.yahoo.com>
References: <1365042051.84279.YahooMailNeo@web160501.mail.bf1.yahoo.com> <515D3A86.6000504@ti.com>
Reply-To: CF Adad <cfadad@rocketmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from nm20-vm0.bullet.mail.bf1.yahoo.com ([98.139.213.165]:29262 "HELO
	nm20-vm0.bullet.mail.bf1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1760751Ab3DDOS0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 4 Apr 2013 10:18:26 -0400
In-Reply-To: <515D3A86.6000504@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mugunthan V N <mugunthanvnm@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "davem@davemloft.net" <davem@davemloft.net>

Mugunthan V N,

Thank you SO much for your repsonse.=A0 That did help enormously.

# ./iperf-arm -i 1 -t 3000 -c 10.22.255.5
------------------------------------------------------------
Client connecting to 10.22.255.5, TCP port 5001
TCP window size: 19.6 KByte (default)
------------------------------------------------------------
[=A0 3] local 10.22.0.17 port 40201 connected with 10.22.255.5 port 500=
1
[ ID] Interval=A0=A0=A0=A0=A0=A0 Transfer=A0=A0=A0=A0 Bandwidth
[=A0 3]=A0 0.0- 1.0 sec=A0 8.88 MBytes=A0 74.4 Mbits/sec
[=A0 3]=A0 1.0- 2.0 sec=A0 10.7 MBytes=A0 90.0 Mbits/sec
[=A0 3]=A0 2.0- 3.0 sec=A0 8.24 MBytes=A0 69.1 Mbits/sec
[=A0 3]=A0 3.0- 4.0 sec=A0 8.54 MBytes=A0 71.6 Mbits/sec
[=A0 3]=A0 4.0- 5.0 sec=A0 7.23 MBytes=A0 60.6 Mbits/sec
[=A0 3]=A0 5.0- 6.0 sec=A0 11.2 MBytes=A0 93.6 Mbits/sec
[=A0 3]=A0 6.0- 7.0 sec=A0 10.6 MBytes=A0 89.2 Mbits/sec
[=A0 3]=A0 7.0- 8.0 sec=A0 10.1 MBytes=A0 84.9 Mbits/sec
[=A0 3]=A0 8.0- 9.0 sec=A0 7.76 MBytes=A0 65.1 Mbits/sec
[=A0 3]=A0 9.0-10.0 sec=A0 4.66 MBytes=A0 39.1 Mbits/sec
[=A0 3] 10.0-11.0 sec=A0 6.79 MBytes=A0 57.0 Mbits/sec
[=A0 3] 11.0-12.0 sec=A0 7.30 MBytes=A0 61.3 Mbits/sec
[=A0 3] 12.0-13.0 sec=A0 7.01 MBytes=A0 58.8 Mbits/sec

We're still not at 100%, but the exhorbitant timeouts are gone, and we'=
re back to bandwidth we can live with for the time being.=A0=A0 Thanks!

The oddity is the patch you shared is one that I actually suggested to =
myself in my code comments from nearly a year ago.=A0 I guess I needed =
someone to remind me of my own notes!=A0 :-P=A0 See the comment in that=
 line from http://article.gmane.org/gmane.linux.ports.arm.omap/79787 ??=
?

Since that fix appears to help, please review the other contents of tha=
t draft patch I posted back then.=A0 Perhaps there are a few other good=
 things that can be applied from there to the driver today?=A0 The bigg=
est change I proposed was removing the redundant=A0 emac_rx_alloc() fun=
ction and replacing it with the standard netdev_alloc_skb_ip_align() in=
stead.=A0 I also took a look at improving the detection and handling of=
 some potential errors.=A0 To be honest, I never saw any of my dev_err(=
) calls hit, but that's not to say that they could never do so.



Thanks again!



----- Original Message -----
=46rom: Mugunthan V N <mugunthanvnm@ti.com>
To: CF Adad <cfadad@rocketmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>; "davem@d=
avemloft.net" <davem@davemloft.net>
Sent: Thursday, April 4, 2013 4:32 AM
Subject: Re: AM3517 DaVinci EMAC Ethernet performance issues

On 4/4/2013 7:50 AM, CF Adad wrote:
> We've done network captures on our link, and the problem is very stra=
nge. The iperf client transmits data quickly and steadily for a while, =
but then all the sudden just stops. In the captures you can see an ACK =
come back from the server for the frame that was just sent, but then in=
stead of immediately sending the next one it just sits there for someti=
mes several seconds. Then, it suddenly picks back up and starts running=
 again. It's as though it just paused due to lack of data.=20
The same kind of issue was observed in different SoC with Davinci EMAC
and resolved by the patch below. Can you make sure the patch is applied
in your kernel and take the performance again.
https://git.kernel.org/cgit/linux/kernel/git/davem/net.git/commit/?id=3D=
7e51cde276ca820d526c6c21cf8147df595a36bf

Regards
Mugunthan V N

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

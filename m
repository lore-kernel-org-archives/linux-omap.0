From: CF Adad <cfadad@rocketmail.com>
Subject: Re: Problems in the DaVinci EMAC driver & AM35xx?
Date: Fri, 22 Jun 2012 13:50:44 -0700 (PDT)
Message-ID: <1340398244.35574.YahooMailNeo@web125202.mail.ne1.yahoo.com>
References: <1339627132.52592.YahooMailNeo@web125204.mail.ne1.yahoo.com> <1339788533.89799.YahooMailNeo@web125202.mail.ne1.yahoo.com> <1340396573.68079.YahooMailNeo@web125202.mail.ne1.yahoo.com>
Reply-To: CF Adad <cfadad@rocketmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from nm21-vm1.bullet.mail.ne1.yahoo.com ([98.138.91.46]:30109 "HELO
	nm21-vm1.bullet.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1755722Ab2FVUuo convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 22 Jun 2012 16:50:44 -0400
In-Reply-To: <1340396573.68079.YahooMailNeo@web125202.mail.ne1.yahoo.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "mgreer@animalcreek.com" <mgreer@animalcreek.com>, "afzal@ti.com" <afzal@ti.com>, "jp.francois@cynove.com" <jp.francois@cynove.com>, "tony@atomide.com" <tony@atomide.com>, "santosh.shilimkar@ti.com" <santosh.shilimkar@ti.com>, "khilman@ti.com" <khilman@ti.com>

A quick follow-up note:

The stress line that was running during the crash mentioned was: "stres=
s --cpu 8 --io 8 --vm 1 --vm-bytes 150M --hdd 2 --timeout 60". The "--h=
dd 2" option was a leftover that was not supposed to be there.=A0 So th=
at may have created a chunk more disk work for the processor.=A0 Regard=
less, stress did not crash.=A0 Ping died with the EMAC error mentioned,=
 but stress was still running fine when I stopped it.


It's been suggested that stress may be eating up too much memory and ca=
using the EMAC driver to do this.=A0 That's a fair point, as these "WAR=
NING: at drivers/net/ethernet/ti/davinci_emac.c:997 emac_rx_alloc" erro=
rs only appear to show up with stress running.=A0 I suspect that could =
be true, though no other drivers or other applications are throwing sim=
ilar errors.=A0 When I've cranked stress too high memory wise in the pa=
st, I've seen it break out the oom-killer.=A0 That's what I would expec=
t.=A0 Since I'm no longer seeing that, I suspect I'm playing within the=
 bounds.=A0 Regardless, should a userspace app sucking up too much memo=
ry cause a driver to crash?


I bring these questions here, as the crash's call stack shares so many =
similarities to the "SLAB crash" discussed "http://thread.gmane.org/gma=
ne.linux.ports.arm.omap/78039/", that I think they're related.=A0 At th=
e very least, the EMAC to EMAC performance issues we have always seen a=
re troubling.=A0 IMHO, clearly the EMAC driver is doing something a lit=
tle questionable.

Thoughts?

Thanks again.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: Kevin Hilman <khilman@ti.com>
Subject: Re: Problems in the DaVinci EMAC driver & AM35xx?
Date: Thu, 28 Jun 2012 12:56:13 -0500
Message-ID: <87fw9fpbgi.fsf@ti.com>
References: <1339627132.52592.YahooMailNeo@web125204.mail.ne1.yahoo.com>
	<1339788533.89799.YahooMailNeo@web125202.mail.ne1.yahoo.com>
	<1340396573.68079.YahooMailNeo@web125202.mail.ne1.yahoo.com>
	<1340398244.35574.YahooMailNeo@web125202.mail.ne1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:47539 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755557Ab2F1R4E convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 28 Jun 2012 13:56:04 -0400
Received: by yhfq11 with SMTP id q11so2926591yhf.1
        for <linux-omap@vger.kernel.org>; Thu, 28 Jun 2012 10:56:01 -0700 (PDT)
In-Reply-To: <1340398244.35574.YahooMailNeo@web125202.mail.ne1.yahoo.com> (CF
	Adad's message of "Fri, 22 Jun 2012 13:50:44 -0700 (PDT)")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: CF Adad <cfadad@rocketmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "mgreer@animalcreek.com" <mgreer@animalcreek.com>, "afzal@ti.com" <afzal@ti.com>, "jp.francois@cynove.com" <jp.francois@cynove.com>, "tony@atomide.com" <tony@atomide.com>, "santosh.shilimkar@ti.com" <santosh.shilimkar@ti.com>

CF Adad <cfadad@rocketmail.com> writes:

[...]

> I bring these questions here, as the crash's call stack shares so man=
y
> similarities to the "SLAB crash" discussed
> "http://thread.gmane.org/gmane.linux.ports.arm.omap/78039/", that I
> think they're related.=C2=A0 At the very least, the EMAC to EMAC
> performance issues we have always seen are troubling.=C2=A0 IMHO, cle=
arly
> the EMAC driver is doing something a little questionable.

I don't know about the crash, but the EMAC performance issues are known=
=2E

Basically, the EMAC on the AM3xxx is not wakeup capable.  Meaning that
if you enter idle, and EMAC interrupt will not wake the system.  The
system will not wake until another wakeup-capable device (e.g. timer)
goes off.

To see if this is causing your problems, add 'nohlt' to your kernel
command line.  This will prevent the SoC from ever entering idle, so
your EMAC interrupt latency will drop significantly.

Kevin


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: epsi@gmx.de
Subject: Re: RE: RE: Memory performance / Cache problem
Date: Wed, 14 Oct 2009 16:48:39 +0200
Message-ID: <20091014144839.115530@gmx.net>
References: <20091012083806.323990@gmx.net>
 <B85A65D85D7EB246BE421B3FB0FBB59301DDE1FF2C@dbde02.ent.ti.com>
 <20091013081651.300080@gmx.net>
 <13B9B4C6EF24D648824FF11BE8967162039B235D5C@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:33068 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933969AbZJNOt3 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 14 Oct 2009 10:49:29 -0400
In-Reply-To: <13B9B4C6EF24D648824FF11BE8967162039B235D5C@dlee02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Woodruff, Richard" <r-woodruff2@ti.com>, linux-omap@vger.kernel.org, premi@ti.com

Mem clock is both times 166MHz. I don't know whether are differences in cycle access and timing, but memclock is fine.

Following Siarhei hints of initialize the buffers (around 1.2 MByte each)
I get different results in 22kernel for use of
malloc alone
memcpy =   473.764, loop4 =   448.430, loop1 =   102.770, rand =    29.641
calloc alone
memcpy =   405.947, loop4 =   361.550, loop1 =    95.441, rand =    21.853
malloc+memset:
memcpy =   239.294, loop4 =   188.617, loop1 =    80.871, rand =     4.726

In 31kernel all 3 measures are about the same (unfortunatly low) level of malloc+memset in 22.

First of all: What performance can be expected?
Does 22 make failures if it is so much faster?
Can the later kernels get a boost in memory handling?

I used a standard memcpy (think this is glib and hence not neonbased)? 
To be neonbased I guess it has to be recompiled?

How can I find out that neon and cache settings are ok?
Using a Omap3530 on EVM board

Unfortunatly I don't have a Lauterbach, just a Spectrum Digital which works only until Linux kernel is booting.

Best regards
Steffen


-------- Original-Nachricht --------
> Datum: Wed, 14 Oct 2009 08:59:05 -0500
> Von: "Woodruff, Richard" <r-woodruff2@ti.com>
> An: "epsi@gmx.de" <epsi@gmx.de>, "Premi, Sanjeev" <premi@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
> Betreff: RE: RE: Memory performance / Cache problem

> > There is no newer u-boot from TI available. There is a SDK 02.01.03.11
> > but it contains the same uboot 2008.10 with the only addition of the
> second
> > generation of EVM boards with another network chip.
> >
> > So I checked the uboot from git, but this doesn't support Microns NAND
> Flash
> > anymore. It is just working with ONENAND.
> >
> > I found a patch which shows the L2 Cache status while kernel boot and
> > implemented it : L2 Cache seems to be already enabled - so this is not
> the
> > reason.
> >
> > So any other ideas?
> 
> Are you confident your memory bus isn't running at 1/2 speed?
> 
> I recall there was a couple day window during wtbu kernel upgrades where
> memory bus speed with pm was running 1/2 speed after kernel started up. 
> This was somewhat a side effect of constraints frame work and a regression in
> forward porting. It seems unlikely psp kernel would have shipped with this
> bug but its something to check. This would match your results.
> 
> If your memcpy() is neon based then I might be worried about
> l1neon-caching effects along with factors of (exlcusive-l1-l2-read-allocate cache + pld
> not being effective on l1 only l2).
> 
> Which memcpy test are you using? Something in lmbench or just one you
> wrote.  Generally results are a little hard to interpret with exclusive cache
> behavior in 3430's r1px core.  3630's r3p2 core gives more traditional
> results as exclusive feature has been removed by arm.
> 
> If you have the ability using Lauterbach + per file will allow internal
> space dump which will show all critical parameters during test.  It's a 1
> minute check for someone who has done it before to ensure the few parameters
> needed are in line.  I can send an example off line of how to do capture.  I
> won't have time to expand on all relevant parameters.
> 
> Regards,
> Richard W.

-- 
Neu: GMX DSL bis 50.000 kBit/s und 200,- Euro Startguthaben!
http://portal.gmx.net/de/go/dsl02

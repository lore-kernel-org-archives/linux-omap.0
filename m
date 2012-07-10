From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 04/14] ARM: OMAP5: Add minimal support for OMAP5430
 SOC
Date: Tue, 10 Jul 2012 01:18:52 -0700
Message-ID: <20120710081851.GL1122@atomide.com>
References: <1341566515-22665-1-git-send-email-santosh.shilimkar@ti.com>
 <1341566515-22665-5-git-send-email-santosh.shilimkar@ti.com>
 <4FFA9B61.8030808@ti.com>
 <20120709131156.GH1122@atomide.com>
 <79CD15C6BA57404B839C016229A409A83EA69538@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:18507 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753328Ab2GJITD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Jul 2012 04:19:03 -0400
Content-Disposition: inline
In-Reply-To: <79CD15C6BA57404B839C016229A409A83EA69538@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "R, Sricharan" <r.sricharan@ti.com>

* Hiremath, Vaibhav <hvaibhav@ti.com> [120709 23:30]:
> On Mon, Jul 09, 2012 at 18:41:58, Tony Lindgren wrote:
> > * Vaibhav Hiremath <hvaibhav@ti.com> [120709 01:55]:
> > > On 7/6/2012 2:51 PM, Santosh Shilimkar wrote:
> > > > --- a/arch/arm/plat-omap/include/plat/clkdev_omap.h
> > > > +++ b/arch/arm/plat-omap/include/plat/clkdev_omap.h
> > > > @@ -39,6 +39,7 @@ struct omap_clk {
> > > >  #define CK_443X		(1 << 11)
> > > >  #define CK_TI816X	(1 << 12)
> > > >  #define CK_446X		(1 << 13)
> > > > +#define CK_54XX		(1 << 14)
> > > 
> > > This is conflicting with AM33XX, you may want to rebase it again, since
> > > AM33xx clock tree is already pushed and available in
> > > linux-omap/devel-am33xx-part2.
> > 
> > Heh these CK_XXXX defines are now running out of the u16 cpu_mask.
> > 
> > They really should be replaced with SoC specific lists of clocks
> > rather than bloating the cpu_mask and repeating it for every clock
> > that's compiled in for 800+ times.
> > 
> > Below (untested) is what could be done in the short term.
> > 
> > I wonder if we could #define CK_OMAP_DUMMY 0 that's always set
> > for non-shared clocks if they only get set in some *_data.c
> > file in a unique way?
> > 
> > Paul got any better ideas?
...

> This also will not scale up in the future and will end up again in the same 
> situation.

Right that's why we want to get rid of it.
 
> Just a quick thought, may work here,
> 
> I looked at the usage of cpu_mask and rates.flag and I believe we can 
> restrict both to given SoC, something like,
> 
> OMAP34XX ->
>           ES1
>           ES2PLUS
>           36XX
>           AM35XX
>           ...
> 
> OMAP4 ->
>           443X
>           446X
> 
> AM33XX ->
>           AM335X
>           TI816X
>           TI814X
>           ...
> 
> XYZ...  ->
>           ...
> 
> 
> The proposal would be,
> 
> To make cpu_mask and rate.flags 32 bit wide and divide it in 16-16 bits -
> 
> Lower 16 bits => describe SoC it is applicable to
> Upper 16 bit => describes silicon versions or families

No thanks.. We don't want to make it 32 bit and bloat all the compiled in
clock even further. 

Regards,

Tony

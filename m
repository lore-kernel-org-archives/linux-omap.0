From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: RE: [PATCH 08/10] OMAP: split plat-omap/common.c
Date: Mon, 4 Oct 2010 13:58:21 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB030CDFE554@dbde02.ent.ti.com>
References: <20101001213119.1408.65395.stgit@twilight.localdomain>
 <20101001213532.1408.55832.stgit@twilight.localdomain>
 <EAF47CD23C76F840A9E7FCE10091EFAB030CDFE3D3@dbde02.ent.ti.com>
 <alpine.DEB.2.00.1010032359220.13816@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:33904 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752939Ab0JDI2b convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Oct 2010 04:28:31 -0400
In-Reply-To: <alpine.DEB.2.00.1010032359220.13816@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Paul,

<<snip>>

> 
> > > +static int __init omap_init_clocksource_32k(void)
> > > +{
> > > +	static char err[] __initdata = KERN_ERR
> > > +			"%s: can't register clocksource!\n";
> > > +
> > > +	if (cpu_is_omap16xx() || cpu_class_is_omap2()) {
> > > +		struct clk *sync_32k_ick;
> > > +
> > > +		if (cpu_is_omap16xx())
> >
> > Avoid cpu_is* checks in plat-omap.
> 
> OK, I'll bite.  Why?

I think this is being looked for all the new code introduced
in plat-omap layer for the following reasons:
Adding cpu-is-* checks makes code unmaintainable going fwd.
plat-omap layer needs to handle common code for all omap platforms.

This was raised for GPIO driver because of which, there was a
requirement to clean-up the gpio driver.

Is this stand changed? Are cpu_is* checks allowed in plat-omap?

> > > +			clocksource_32k.read = omap16xx_32k_read;
> > > +		else if (cpu_is_omap2420())
> > > +			clocksource_32k.read = omap2420_32k_read;
> > > +		else if (cpu_is_omap2430())
> > > +			clocksource_32k.read = omap2430_32k_read;
> > > +		else if (cpu_is_omap34xx())
> > > +			clocksource_32k.read = omap34xx_32k_read;
> > > +		else if (cpu_is_omap44xx())
> > > +			clocksource_32k.read = omap44xx_32k_read;
> > > +		else
> > > +			return -ENODEV;
> > > +
> > > +		sync_32k_ick = clk_get(NULL, "omap_32ksync_ick");
> > > +		if (sync_32k_ick)
> > > +			clk_enable(sync_32k_ick);
> > > +
> > > +		clocksource_32k.mult = clocksource_hz2mult(32768,
> > > +					    clocksource_32k.shift);
> > > +
> > > +		offset_32k = clocksource_32k.read(&clocksource_32k);
> > > +
> > > +		if (clocksource_register(&clocksource_32k))
> > > +			printk(err, clocksource_32k.name);
> > > +	}
> > > +	return 0;
> > > +}
> > > +arch_initcall(omap_init_clocksource_32k);
> > > +


-V Charulatha

From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 08/10] OMAP: split plat-omap/common.c
Date: Mon, 4 Oct 2010 11:27:00 -0700
Message-ID: <20101004182700.GZ3117@atomide.com>
References: <20101001213119.1408.65395.stgit@twilight.localdomain>
 <20101001213532.1408.55832.stgit@twilight.localdomain>
 <EAF47CD23C76F840A9E7FCE10091EFAB030CDFE3D3@dbde02.ent.ti.com>
 <alpine.DEB.2.00.1010032359220.13816@utopia.booyaka.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB030CDFE554@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:57608 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755022Ab0JDS07 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Oct 2010 14:26:59 -0400
Content-Disposition: inline
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB030CDFE554@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Varadarajan, Charulatha" <charu@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

* Varadarajan, Charulatha <charu@ti.com> [101004 01:20]:
> Paul,
> 
> <<snip>>
> 
> > 
> > > > +static int __init omap_init_clocksource_32k(void)
> > > > +{
> > > > +	static char err[] __initdata = KERN_ERR
> > > > +			"%s: can't register clocksource!\n";
> > > > +
> > > > +	if (cpu_is_omap16xx() || cpu_class_is_omap2()) {
> > > > +		struct clk *sync_32k_ick;
> > > > +
> > > > +		if (cpu_is_omap16xx())
> > >
> > > Avoid cpu_is* checks in plat-omap.
> > 
> > OK, I'll bite.  Why?
> 
> I think this is being looked for all the new code introduced
> in plat-omap layer for the following reasons:
> Adding cpu-is-* checks makes code unmaintainable going fwd.
> plat-omap layer needs to handle common code for all omap platforms.
> 
> This was raised for GPIO driver because of which, there was a
> requirement to clean-up the gpio driver.
> 
> Is this stand changed? Are cpu_is* checks allowed in plat-omap?

We should only need to do cpu_is* checks in arch/arm/mach-omap2,
and only in few places during the init.

However, this patch series moves around the existing code to
avoid having oma2plus specific code be in plat-omap.

Again, further patches can be done easily on this.

Tony

From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP2+: l2c: squelch warning dump on power control
 setting
Date: Wed, 9 Jul 2014 02:25:31 -0700
Message-ID: <20140709092531.GK28884@atomide.com>
References: <20140707104727.GM28884@atomide.com>
 <20140707104944.GS3705@n2100.arm.linux.org.uk>
 <20140707110249.GO28884@atomide.com>
 <53BA8983.3030803@ti.com>
 <20140707121512.GT3705@n2100.arm.linux.org.uk>
 <20140707123925.GW28884@atomide.com>
 <20140707134008.GU3705@n2100.arm.linux.org.uk>
 <20140707151024.GJ5582@saruman.home>
 <53BB7980.2060909@ti.com>
 <20140708082948.GE28884@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:63389 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751313AbaGIJZb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Jul 2014 05:25:31 -0400
Content-Disposition: inline
In-Reply-To: <20140708082948.GE28884@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sekhar Nori <nsekhar@ti.com>
Cc: balbi@ti.com, Russell King - ARM Linux <linux@arm.linux.org.uk>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>, Nishanth Menon <nm@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

* Tony Lindgren <tony@atomide.com> [140708 01:32]:
> * Sekhar Nori <nsekhar@ti.com> [140707 21:56]:
> > On Monday 07 July 2014 08:40 PM, Felipe Balbi wrote:
> > > On Mon, Jul 07, 2014 at 02:40:08PM +0100, Russell King - ARM Linux wrote:
> > >> --- a/arch/arm/mm/cache-l2x0.c
> > >> +++ b/arch/arm/mm/cache-l2x0.c
> > >> @@ -732,7 +732,7 @@ static int l2c310_cpu_enable_flz(struct notifier_block *nb, unsigned long act, v
> > >>  
> > >>  static void __init l2c310_enable(void __iomem *base, u32 aux, unsigned num_lock)
> > >>  {
> > >> -	unsigned rev = readl_relaxed(base + L2X0_CACHE_ID) & L2X0_CACHE_ID_PART_MASK;
> > >> +	unsigned rev = readl_relaxed(base + L2X0_CACHE_ID) & L2X0_CACHE_ID_RTL_MASK;
> > >>  	bool cortex_a9 = read_cpuid_part() == ARM_CPU_PART_CORTEX_A9;
> > > 
> > > even with this change, l2c still tries to write to power control
> > > register, at least on AM437x. Looking a little deeper here, AM437x
> > > identifies itself as l2c PL310 r3p3, which should have power control
> > > register, but aparentely there's no way to write that register. I'll
> > > file a bug to our ROM team, but we will certainly need a way to
> > > workaround this inside omap4-common.c
> > 
> > Looks like we need both my patch as well as Russell's patch. I can
> > respin my patch with the pr_info_once() dropped if it helps further
> > reduce boot noise.
> 
> In that case I'm fine with the original patch in this series. Russell,
> got any better ideas?

I guess no more comments. Took a look at the patch again, Sekhar, can
you please update the description with what has been discovered in this
thread and repost?

Regards,

Tony

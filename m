From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL 8/10] omap timer cleanup for v3.5 merge window
Date: Thu, 10 May 2012 13:24:16 -0700
Message-ID: <20120510202415.GO21851@atomide.com>
References: <pull-1336675159-747052>
 <E1SSYJA-0006UJ-4H@merlin.infradead.org>
 <20120510185130.GJ21851@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:12601 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756549Ab2EJUYU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 May 2012 16:24:20 -0400
Content-Disposition: inline
In-Reply-To: <20120510185130.GJ21851@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Tony Lindgren <tony@atomide.com> [120510 11:55]:
> * Tony Lindgren <tony@atomide.com> [120510 11:49]:
> > The following changes since commit bfd17879866b36e95c58721da070d9f2ac7f8901:
> > 
> >   Merge tag 'omap-devel-c-for-3.5' of git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending into devel-hwmod-data (2012-05-09 09:58:42 -0700)
> > 
> > are available in the git repository at:
> > 
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-cleanup-timer-for-v3.5
> > 
> > for you to fetch changes up to 1fe97c8f6a1de67a5f56e029a818903d5bed8017:
> > 
> >   ARM: OMAP: Make OMAP clocksource source selection using kernel param (2012-05-09 10:07:05 -0700)
> > 
> > ----------------------------------------------------------------
> > Timer changes to make it easier to support various SoCs
> > 
> > ----------------------------------------------------------------
> 
> And this has a conflict for common headers:
...

Also looks like this produces a merge conflict with linux-next
commit bd0493ea (ARM: 7413/1: move read_{boot,persistent}_clock to
the architecture level). To resolve, the line to add
register_persistent_clock(NULL, omap_read_persistent_clock);
needs to be resolved as below.

Regards,

Tony


--- a/arch/arm/plat-omap/counter_32k.c
+++ b/arch/arm/plat-omap/counter_32k.c
@@@ -69,40 -69,55 +70,41 @@@ static void omap_read_persistent_clock(
  	*ts = *tsp;
  }
  
 -int __init omap_init_clocksource_32k(void)
 +/**
 + * omap_init_clocksource_32k - setup and register counter 32k as a
 + * kernel clocksource
 + * @pbase: base addr of counter_32k module
 + * @size: size of counter_32k to map
 + *
 + * Returns 0 upon success or negative error code upon failure.
 + *
 + */
 +int __init omap_init_clocksource_32k(void __iomem *vbase)
  {
 -	static char err[] __initdata = KERN_ERR
 -			"%s: can't register clocksource!\n";
 -
 -	if (cpu_is_omap16xx() || cpu_class_is_omap2()) {
 -		u32 pbase;
 -		unsigned long size = SZ_4K;
 -		void __iomem *base;
 -		struct clk *sync_32k_ick;
 -
 -		if (cpu_is_omap16xx()) {
 -			pbase = OMAP16XX_TIMER_32K_SYNCHRONIZED;
 -			size = SZ_1K;
 -		} else if (cpu_is_omap2420())
 -			pbase = OMAP2420_32KSYNCT_BASE + 0x10;
 -		else if (cpu_is_omap2430())
 -			pbase = OMAP2430_32KSYNCT_BASE + 0x10;
 -		else if (cpu_is_omap34xx())
 -			pbase = OMAP3430_32KSYNCT_BASE + 0x10;
 -		else if (cpu_is_omap44xx())
 -			pbase = OMAP4430_32KSYNCT_BASE + 0x10;
 -		else
 -			return -ENODEV;
 -
 -		/* For this to work we must have a static mapping in io.c for this area */
 -		base = ioremap(pbase, size);
 -		if (!base)
 -			return -ENODEV;
 -
 -		sync_32k_ick = clk_get(NULL, "omap_32ksync_ick");
 -		if (!IS_ERR(sync_32k_ick))
 -			clk_enable(sync_32k_ick);
 -
 -		timer_32k_base = base;
 -
 -		/*
 -		 * 120000 rough estimate from the calculations in
 -		 * __clocksource_updatefreq_scale.
 -		 */
 -		clocks_calc_mult_shift(&persistent_mult, &persistent_shift,
 -				32768, NSEC_PER_SEC, 120000);
 -
 -		if (clocksource_mmio_init(base, "32k_counter", 32768, 250, 32,
 -					  clocksource_mmio_readl_up))
 -			printk(err, "32k_counter");
 -
 -		setup_sched_clock(omap_32k_read_sched_clock, 32, 32768);
 -		register_persistent_clock(NULL, omap_read_persistent_clock);
 +	int ret;
 +
 +	/*
 +	 * 32k sync Counter register offset is at 0x10
 +	 */
 +	sync32k_cnt_reg = vbase + OMAP2_32KSYNCNT_CR_OFF;
 +
 +	/*
 +	 * 120000 rough estimate from the calculations in
 +	 * __clocksource_updatefreq_scale.
 +	 */
 +	clocks_calc_mult_shift(&persistent_mult, &persistent_shift,
 +			32768, NSEC_PER_SEC, 120000);
 +
 +	ret = clocksource_mmio_init(sync32k_cnt_reg, "32k_counter", 32768,
 +				250, 32, clocksource_mmio_readl_up);
 +	if (ret) {
 +		pr_err("32k_counter: can't register clocksource\n");
 +		return ret;
  	}
 +
 +	setup_sched_clock(omap_32k_read_sched_clock, 32, 32768);
 +	pr_info("OMAP clocksource: 32k_counter at 32768 Hz\n");
++	register_persistent_clock(NULL, omap_read_persistent_clock);
 +
  	return 0;
  }

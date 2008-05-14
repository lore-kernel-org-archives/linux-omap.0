From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3] ARM: OMAP3: Check for L2 cache enabled
Date: Wed, 14 May 2008 16:06:46 -0700
Message-ID: <20080514230644.GH8928@atomide.com>
References: <48268E60.8010703@googlemail.com> <20080511084423.GA9164@kedavra.cpe.vivax.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-bos.mailhop.org ([63.208.196.179]:61439 "EHLO
	mho-02-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753228AbYENXGq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 May 2008 19:06:46 -0400
Content-Disposition: inline
In-Reply-To: <20080511084423.GA9164@kedavra.cpe.vivax.com.br>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <me@felipebalbi.com>
Cc: Dirk Behme <dirk.behme@googlemail.com>, linux-omap@vger.kernel.org

* Felipe Balbi <me@felipebalbi.com> [080511 01:43]:
> On Sun, May 11, 2008 at 08:12:48AM +0200, Dirk Behme wrote:
> >
> > Enabling L2 cache of Cortex-A8 based OMAP3 has to be done by bootloader. 
> > Check if this is done and warn if not.
> >
> > Signed-off-by: Dirk Behme <dirk.behme@gmail.com>
> Acked-by: Felipe Balbi <felipe.balbi@nokia.com>

Pushing today.

Tony

> >
> > ----
> >
> > Changes in v3: Remove braces. Thanks to Felipe for review!
> 
> > Index: linux-beagle/arch/arm/mach-omap2/id.c
> > ===================================================================
> > --- linux-beagle.orig/arch/arm/mach-omap2/id.c
> > +++ linux-beagle/arch/arm/mach-omap2/id.c
> > @@ -267,3 +267,25 @@ void __init omap2_check_revision(void)
> >  
> >  }
> >  
> > +#ifdef CONFIG_ARCH_OMAP3
> > +/*
> > + * OMAP3 has L2 cache which has to be enabled by bootloader.
> > + */
> > +static int __init omap3_check_l2cache(void)
> > +{
> > +	u32 val;
> > +
> > +	/* Get CP15 AUX register, bit 1 enabled indicates L2 cache is on */
> > +	asm volatile("mrc p15, 0, %0, c1, c0, 1":"=r" (val));
> > +
> > +	if ((val & 0x2) == 0)
> > +		printk(KERN_WARNING "Warning: L2 cache not enabled. Check "
> > +		       "your bootloader. L2 off results in performance loss\n");
> > +	else
> > +		pr_info("OMAP3 L2 cache enabled\n");
> > +
> > +	return 0;
> > +}
> > +
> > +arch_initcall(omap3_check_l2cache);
> > +#endif /* CONFIG_ARCH_OMAP3 */
> 
> 
> -- 
> Best Regards,
> 
> Felipe Balbi
> me@felipebalbi.com
> http://blog.felipebalbi.com
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

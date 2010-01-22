From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 4/4] omap: Make get_irqnr_and_base common for
 mach-omap2 multiboot, v2
Date: Fri, 22 Jan 2010 13:16:28 -0800
Message-ID: <20100122211628.GF11835@atomide.com>
References: <20100116013205.10065.95921.stgit@baageli.muru.com>
 <20100116013520.10065.17921.stgit@baageli.muru.com>
 <20100116115503.GA15904@n2100.arm.linux.org.uk>
 <20100122203953.GA11835@atomide.com>
 <20100122205616.GC18461@n2100.arm.linux.org.uk>
 <20100122210934.GD11835@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:57810 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754336Ab0AVVQZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 22 Jan 2010 16:16:25 -0500
Content-Disposition: inline
In-Reply-To: <20100122210934.GD11835@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [100122 13:07]:
> * Russell King - ARM Linux <linux@arm.linux.org.uk> [100122 12:54]:
> > On Fri, Jan 22, 2010 at 12:39:53PM -0800, Tony Lindgren wrote:
> > > Here's this patch updated. It should now be actually more optimized for
> > > non-multi-omap configurations as it uses the get_irqnr_preamble :)
> > 
> > And the patch looks a lot cleaner and easier to read.
> > 
> > > diff --git a/arch/arm/mach-omap2/include/mach/entry-macro.S b/arch/arm/mach-omap2/include/mach/entry-macro.S
> > > index c7f1720..c5ea026 100644
> > > --- a/arch/arm/mach-omap2/include/mach/entry-macro.S
> > > +++ b/arch/arm/mach-omap2/include/mach/entry-macro.S
> > > @@ -17,47 +17,85 @@
> > >  
> > >  #include <plat/omap24xx.h>
> > >  #include <plat/omap34xx.h>
> > > -
> > > -/* REVISIT: This should be set dynamically if CONFIG_MULTI_OMAP2 is selected */
> > > -#if defined(CONFIG_ARCH_OMAP2420) || defined(CONFIG_ARCH_OMAP2430)
> > > -#define OMAP2_VA_IC_BASE		OMAP2_L4_IO_ADDRESS(OMAP24XX_IC_BASE)
> > > -#elif defined(CONFIG_ARCH_OMAP34XX)
> > > -#define OMAP2_VA_IC_BASE		OMAP2_L4_IO_ADDRESS(OMAP34XX_IC_BASE)
> > > -#endif
> > > -#if defined(CONFIG_ARCH_OMAP4)
> > >  #include <plat/omap44xx.h>
> > > -#endif
> > > -#define INTCPS_SIR_IRQ_OFFSET	0x0040		/* Active interrupt offset */
> > > -#define	ACTIVEIRQ_MASK		0x7f		/* Active interrupt bits */
> > >  
> > >  		.macro	disable_fiq
> > >  		.endm
> > >  
> > > -		.macro  get_irqnr_preamble, base, tmp
> > > -		.endm
> > > -
> > >  		.macro  arch_ret_to_user, tmp1, tmp2
> > >  		.endm
> > >  
> > > -#ifndef CONFIG_ARCH_OMAP4
> > > +#if defined(CONFIG_ARCH_OMAP2420) || defined(CONFIG_ARCH_OMAP2430) || \
> > > +	defined(CONFIG_ARCH_OMAP34XX)
> > 
> > Isn't this equivalent to:
> > 
> > #if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
> > 
> > ?
> 
> Hmm, I guess it's not like that yet, but will be hopefully
> soon.
> 
> Currently I believe we have CONFIG_ARCH_OMAP2 selected
> for CONFIG_ARCH_OMAP3 too..

Hmm, never mind, I guess that issue is sorted out already.
So will update the patch accordingly. Other confusing
Kconfig options still remain, see below.
 
> I have a set of patches that will remove the overlapping
> Kconfig options. Basically I'm planning to convert:
> 
> CONFIG_ARCH_OMAP1	= arch/arm/mach-omap1
> CONFIG_ARCH_OMAP2PLUS	= arch/arm/mach-omap2
> CONFIG_ARCH_OMAP2	= defined(CONFIG_CPU_OMAP2420) || defined(CONFIG_CPU_OMAP2430)
> CONFIG_ARCH_OMAP3	= defined(CONFIG_CPU_OMAP3430) || defined(CONFIG_CPU_OMAP3630)
> CONFIG_ARCH_OMAP4	= stays the same
> 
> That will get rid of the double meaning for current
> CONFIG_ARCH_OMAP2, and get rid of CONFIG_ARCH_OMAP24XX
> and CONFIG_ARCH_OMAP34XX. Will post after I've updated
> those patches again, hopefully during next week.
> 
> Regards,
> 
> Tony
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

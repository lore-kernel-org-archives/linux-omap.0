From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [PATCH] Fixed processing of bootarg 'mpurate'
Date: Mon, 10 Aug 2009 23:19:20 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301D8D27C1A@dbde02.ent.ti.com>
References: <1249899893-5795-1-git-send-email-premi@ti.com>
 <alpine.DEB.2.00.0908101120300.5505@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:36236 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932359AbZHJRtb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 Aug 2009 13:49:31 -0400
In-Reply-To: <alpine.DEB.2.00.0908101120300.5505@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: Paul Walmsley [mailto:paul@pwsan.com] 
> Sent: Monday, August 10, 2009 10:52 PM
> To: Premi, Sanjeev
> Cc: linux-omap@vger.kernel.org
> Subject: Re: [PATCH] Fixed processing of bootarg 'mpurate'
> 
> On Mon, 10 Aug 2009, Sanjeev Premi wrote:
> 
> > The argument 'mpurate' had no effect on the MPU
> > frequency. This patch fixes the same.
> 
> Thanks, I'll plan to squeeze this into the .32 merge window, 
> with a couple 
> of minor changes described below.  Please review the changes:
> 
> > 
> > Signed-off-by: Sanjeev Premi <premi@ti.com>
> > ---
> >  arch/arm/mach-omap2/clock34xx.c |   14 ++++++++++----
> >  1 files changed, 10 insertions(+), 4 deletions(-)
> > 
> > diff --git a/arch/arm/mach-omap2/clock34xx.c 
> b/arch/arm/mach-omap2/clock34xx.c
> > index 045da92..0c62aad 100644
> > --- a/arch/arm/mach-omap2/clock34xx.c
> > +++ b/arch/arm/mach-omap2/clock34xx.c
> > @@ -27,6 +27,7 @@
> >  #include <linux/limits.h>
> >  #include <linux/bitops.h>
> >  
> > +#include <mach/cpu.h>
> >  #include <mach/clock.h>
> >  #include <mach/sram.h>
> >  #include <asm/div64.h>
> > @@ -948,13 +949,18 @@ static int __init omap2_clk_arch_init(void)
> >  	if (clk_set_rate(&virt_prcm_set, mpurate))
> >  		printk(KERN_ERR "Could not find matching MPU rate\n");
> >  #endif
> 
> The previous four lines (including the three above) have been 
> removed from 
> clock34xx.c.

[sp] That is fine.

> 
> > +	if (clk_set_rate(&dpll1_ck, mpurate))
> > +		printk(KERN_ERR "*** Unable to set MPU rate\n");
> > +	omap3_dpll_recalc(&dpll1_ck);
> 
> I dropped the omap3_dpll_recalc(&dpll1_ck); since the following 
> recalculate_root_clocks() should handle this.

[sp] Fine here too.

> 
> >  	recalculate_root_clocks();
> >  
> > -	printk(KERN_INFO "Switched to new clocking rate 
> (Crystal/DPLL3/MPU): "
> > +	printk(KERN_INFO "Switched to new clocking rate 
> (Crystal/Core/MPU): "
> >  	       "%ld.%01ld/%ld/%ld MHz\n",
> > -	       (osc_sys_ck.rate / 1000000), (osc_sys_ck.rate / 
> 100000) % 10,
> > -	       (core_ck.rate / 1000000), (dpll1_fck.rate / 1000000)) ;
> > +	       (osc_sys_ck.rate / 1000000), ((osc_sys_ck.rate / 
> 100000) % 10),
> > +	       (core_ck.rate / 1000000), (arm_fck.rate / 1000000)) ;
> > +
> > +	calibrate_delay();
> >  
> >  	return 0;
> >  }
> > @@ -1013,7 +1019,7 @@ int __init omap2_clk_init(void)
> >  
> >  	recalculate_root_clocks();
> >  
> > -	printk(KERN_INFO "Clocking rate (Crystal/DPLL/ARM core): "
> > +	printk(KERN_INFO "Clocking rate (Crystal/Core/MPU): "
> >  	       "%ld.%01ld/%ld/%ld MHz\n",
> >  	       (osc_sys_ck.rate / 1000000), (osc_sys_ck.rate / 
> 100000) % 10,
> >  	       (core_ck.rate / 1000000), (arm_fck.rate / 1000000));
> > -- 
> > 1.6.2.2
> > 
> 
> 
> - Paul
> 
> 
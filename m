From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [PATCH] Fixed processing of bootarg 'mpurate'
Date: Mon, 10 Aug 2009 15:53:52 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301D8D278D0@dbde02.ent.ti.com>
References: <1249040630-2712-1-git-send-email-premi@ti.com>
 <87ocqt6mfs.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:43441 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753486AbZHJKYD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 Aug 2009 06:24:03 -0400
In-Reply-To: <87ocqt6mfs.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@deeprootsystems.com] 
> Sent: Thursday, August 06, 2009 8:04 PM
> To: Premi, Sanjeev
> Cc: linux-omap@vger.kernel.org
> Subject: Re: [PATCH] Fixed processing of bootarg 'mpurate'
> 
> Sanjeev Premi <premi@ti.com> writes:
> 
> > The argument 'mpurate' had no effect on the MPU
> > frequency. This patch fixes the same.
> >
> > It also ensures that DSP frequency is set according
> > to the OPP definitions.
> >
> > Signed-off-by: Sanjeev Premi <premi@ti.com>
> 
> Can you break this into two patches.  One that simply fixes the MPU
> rate setting bug and that applies against linux-omap master and
> can be queued for omap-fixes.

Created a patch on l-o master against the commit:

4baadee : OMAP3: EHCI: Allow EHCI to work as a module again

> The DSP rate setting is a separate problem and could be done in
> a patch against the PM branch.

Based on the patch for mpurate, a created another one for setting
the dsp frequency against pm branch:

70a1f22 : OMAP3: PM: USBHOST: clear wakeup events on both hosts

Both patches follow this mail.

Best regards,
Sanjeev

> 
> Kevin
> 
> 
> > ---
> >  arch/arm/mach-omap2/clock34xx.c |   57 
> +++++++++++++++++++++++++++++++++++---
> >  1 files changed, 52 insertions(+), 5 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap2/clock34xx.c 
> b/arch/arm/mach-omap2/clock34xx.c
> > index c2e5ef8..a9e7e82 100644
> > --- a/arch/arm/mach-omap2/clock34xx.c
> > +++ b/arch/arm/mach-omap2/clock34xx.c
> > @@ -29,6 +29,7 @@
> >  #include <linux/err.h>
> >  #include <linux/cpufreq.h>
> >  
> > +#include <mach/cpu.h>
> >  #include <mach/clock.h>
> >  #include <mach/sram.h>
> >  #include <mach/omap-pm.h>
> > @@ -42,6 +43,7 @@
> >  #include "prm-regbits-34xx.h"
> >  #include "cm.h"
> >  #include "cm-regbits-34xx.h"
> > +#include "omap3-opp.h"
> >  
> >  static const struct clkops clkops_noncore_dpll_ops;
> >  
> > @@ -1083,6 +1085,11 @@ void omap2_clk_prepare_for_reboot(void)
> >   */
> >  static int __init omap2_clk_arch_init(void)
> >  {
> > +	unsigned short opp=0;
> > +	unsigned short i;
> > +	unsigned long dsprate;
> > +	struct omap_opp *opp_table;
> > +
> >  	if (!mpurate)
> >  		return -EINVAL;
> >  
> > @@ -1092,12 +1099,49 @@ static int __init omap2_clk_arch_init(void)
> >  		printk(KERN_ERR "Could not find matching MPU rate\n");
> >  #endif
> >  
> > +	if (clk_set_rate(&dpll1_ck, mpurate))
> > +		printk(KERN_ERR "*** Unable to set MPU rate\n");
> > +	omap3_dpll_recalc(&dpll1_ck);
> > +
> > +	/* Get the OPP corresponding to the mpurate */
> > +	if (mpu_opps) {
> > +		opp_table = mpu_opps;
> > +
> > +		for (i=0;  opp_table[i].opp_id <= MAX_VDD1_OPP; i++)
> > +			if (opp_table[i].rate == mpurate)
> > +				break;
> > +
> > +		opp = opp_table[i].opp_id;
> > +
> > +		pr_debug("Switched to OPP:%d\n", opp);
> > +	}
> > +
> > +	/* Get dsprate corresponding to the opp */
> > +	if ((dsp_opps) && (opp >= VDD1_OPP1) && (opp <= VDD1_OPP5)) {
> > +		opp_table = dsp_opps;
> > +
> > +		for (i=0;  opp_table[i].opp_id <= MAX_VDD1_OPP; i++)
> > +			if (opp_table[i].opp_id == opp)
> > +				break;
> > +
> > +		dsprate = opp_table[i].rate;
> > +
> > +		if (clk_set_rate(&dpll2_ck, dsprate))
> > +			printk(KERN_ERR "*** Unable to set IVA2 
> rate\n");
> > +		omap3_dpll_recalc(&dpll2_ck);
> > +	}
> > +
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
> > +	       (core_ck.rate / 1000000), (dpll1_ck.rate / 1000000)) ;
> > +
> > +	printk(KERN_INFO "IVA2 clocking rate: %ld MHz\n",
> > +	       (dpll2_ck.rate / 1000000)) ;
> > +
> > +	calibrate_delay();
> >  
> >  	return 0;
> >  }
> > @@ -1156,10 +1200,13 @@ int __init omap2_clk_init(void)
> >  
> >  	recalculate_root_clocks();
> >  
> > -	printk(KERN_INFO "Clocking rate (Crystal/DPLL/ARM core): "
> > +	printk(KERN_INFO "Clocking rate (Crystal/DPLL/MPU core): "
> >  	       "%ld.%01ld/%ld/%ld MHz\n",
> >  	       (osc_sys_ck.rate / 1000000), (osc_sys_ck.rate / 
> 100000) % 10,
> > -	       (core_ck.rate / 1000000), (arm_fck.rate / 1000000));
> > +               (core_ck.rate / 1000000), (dpll1_ck.rate / 
> 1000000));
> > +
> > +	printk(KERN_INFO "IVA2 clocking rate: %ld MHz\n",
> > +	       (dpll2_ck.rate / 1000000)) ;
> >  
> >  	/*
> >  	 * Only enable those clocks we will need, let the drivers
> > -- 
> > 1.6.2.2
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe 
> linux-omap" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
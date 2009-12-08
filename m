From: "Sripathy, Vishwanath" <vishwanath.bs@ti.com>
Subject: RE: [PATCHV3 3/4] OMAP3: Correct width for CLKSEL Fields
Date: Tue, 8 Dec 2009 19:27:51 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC35608702FAAFE239@dbde02.ent.ti.com>
References: <1259211517-12713-1-git-send-email-vishwanath.bs@ti.com>
 <1259211517-12713-2-git-send-email-vishwanath.bs@ti.com>
 <1259211517-12713-3-git-send-email-vishwanath.bs@ti.com>
 <1259211517-12713-4-git-send-email-vishwanath.bs@ti.com>
 <alpine.DEB.2.00.0911300310310.17083@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:42188 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755191AbZLHN5u convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Dec 2009 08:57:50 -0500
In-Reply-To: <alpine.DEB.2.00.0911300310310.17083@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>



Paul,
> -----Original Message-----
> From: Paul Walmsley [mailto:paul@pwsan.com]
> Sent: Monday, November 30, 2009 3:45 PM
> To: Sripathy, Vishwanath
> Cc: linux-omap@vger.kernel.org
> Subject: Re: [PATCHV3 3/4] OMAP3: Correct width for CLKSEL Fields
> 
> Hello Vishwanath,
> 
> On Thu, 26 Nov 2009, Vishwanath BS wrote:
> 
> > DPLL4 M, M3, M4, M5 and M6 field width has been increased by 1 bit in
> > 3630.This patch has changes to accommodate this in CM dynamically based
> > on chip version. Primary changes are
> > 1. Added clksel_mask_3630 to take care clksel width changes
> > 2. CLock nodes which are newly added for 3630 are marked under CK_363X
> > 3. Clock nodes which have changes for 3630 are marked as CK_3XXX | CK_363X
> > 4. Clock nodes which are unchanged for 3630 are retained as CK_3XXX
> > 5. 3630 specific Clock rates are marked as RATE_IN_363X
> 
> ...
> 
> > @@ -1232,6 +1238,12 @@ int __init omap2_clk_init(void)
> >
> >  	for (c = omap34xx_clks; c < omap34xx_clks + ARRAY_SIZE(omap34xx_clks);
> c++)
> >  		if (c->cpu & cpu_clkflg) {
> > +			/* for 3630, change the mask value for clocks which are
> > +				marked as CK_363X*/
> 
> Please follow the comment style in Documentation/CodingStyle.
> 
> > +			if (cpu_is_omap3630() && (c->cpu & CK_363X)) {
> > +				c->lk.clk->clksel_mask =
> > +						c->lk.clk->clksel_mask_3630;
> > +			}
> 
> Again, let's avoid dynamic rewriting of the clock tree.
> 
> ...
> 
> > @@ -754,7 +796,8 @@ static struct clk dpll4_m4_ck = {
> >  	.init		= &omap2_init_clksel_parent,
> >  	.clksel_reg	= OMAP_CM_REGADDR(OMAP3430_DSS_MOD, CM_CLKSEL),
> >  	.clksel_mask	= OMAP3430_CLKSEL_DSS1_MASK,
> > -	.clksel		= div16_dpll4_clksel,
> > +	.clksel_mask_3630 = OMAP3630_CLKSEL_DSS1_MASK,
> > +	.clksel		= div32_dpll4_clksel,
> >  	.clkdm_name	= "dpll4_clkdm",
> >  	.recalc		= &omap2_clksel_recalc,
> >  	.set_rate	= &omap2_clksel_set_rate,
> 
> Okay, now I am convinced.  We need to explore converting the struct clk
> parent pointer into a const char * and a struct clk *, the latter resolved
> at clock code init.  That should let us split some of these struct clks
> that vary between OMAP34xx and OMAP36xx without needing to split other
> unrelated sections of the clock tree.
> 
I am thinking of adding a new file called /mach-omap2/clock36xx.h and have complete 36xx clock tree defined over there instead of tweaking 34xx clock tree. Any comments?
> 
> - Paul

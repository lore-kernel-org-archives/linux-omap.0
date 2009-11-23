From: "Sripathy, Vishwanath" <vishwanath.bs@ti.com>
Subject: RE: [PATCHV2 3/4] OMAP3: Correct width for CLKSEL Fields
Date: Mon, 23 Nov 2009 14:42:29 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC35608702FA751E22@dbde02.ent.ti.com>
References: <1258730937-1962-1-git-send-email-vishwanath.bs@ti.com>
 <1258730937-1962-2-git-send-email-vishwanath.bs@ti.com>
 <1258730937-1962-3-git-send-email-vishwanath.bs@ti.com>
 <1258730937-1962-4-git-send-email-vishwanath.bs@ti.com>
 <4B06BD08.30301@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48431 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756145AbZKWJM2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Nov 2009 04:12:28 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id nAN9CV4A013030
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 23 Nov 2009 03:12:34 -0600
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id nAN9CUHL024182
	for <linux-omap@vger.kernel.org>; Mon, 23 Nov 2009 14:42:31 +0530 (IST)
In-Reply-To: <4B06BD08.30301@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Nishant

> -----Original Message-----
> From: Menon, Nishanth
> Sent: Friday, November 20, 2009 9:30 PM
> To: Sripathy, Vishwanath
> Cc: linux-omap@vger.kernel.org
> Subject: Re: [PATCHV2 3/4] OMAP3: Correct width for CLKSEL Fields
> 
> Hi Vishwa,
> Thanks for the patch, few comments follow:
> Sripathy, Vishwanath had written, on 11/20/2009 09:28 AM, the following:
> > DPLL4 M, M3, M4, M5 and M6 field width has been increased by 1 bit in
> > 3630.This patch has changes to accommodate this in CM dynamically based on
> > chip version.
> >
> > Signed-off-by: Vishwanath BS <vishwanath.bs@ti.com>
> > ---
> >  arch/arm/mach-omap2/clock34xx.c         |   18 ++++++++--
> >  arch/arm/mach-omap2/clock34xx.h         |   53
> ++++++++++++++++++++++++++++--
> >  arch/arm/mach-omap2/cm-regbits-34xx.h   |    7 +++-
> >  arch/arm/plat-omap/include/plat/clock.h |    4 +-
> >  4 files changed, 71 insertions(+), 11 deletions(-)
> >  mode change 100644 => 100755 arch/arm/mach-omap2/clock34xx.c
> >
> > diff --git a/arch/arm/mach-omap2/clock34xx.c b/arch/arm/mach-
> omap2/clock34xx.c
> > index 167f075..1e35f9a
> > --- a/arch/arm/mach-omap2/clock34xx.c
> > +++ b/arch/arm/mach-omap2/clock34xx.c
> > @@ -43,6 +43,7 @@
> >  #include "prm-regbits-34xx.h"
> >  #include "cm.h"
> >  #include "cm-regbits-34xx.h"
> > +#include <plat/cpu.h>
> >
> >  static const struct clkops clkops_noncore_dpll_ops;
> >
> > @@ -97,6 +98,7 @@ struct omap_clk {
> >  #define CK_3XXX		(1 << 0)
> >  #define CK_3430ES1	(1 << 1)
> >  #define CK_3430ES2	(1 << 2)
> > +#define CK_363X		(1 << 3)
> 
> The patch subject/commit msg and actual action here seem to differ
> unfortunately ->  you are in reality introducing the CK_36XX deltas
> here, you may want to fix the commit message OR split this patch into two:
> a) introduce 36XX clocks - You may want to consider these in multiple
> patches each introducing one specific change -> clock wise perhaps.
> b) introduce the DPLL4 Mx changes
> this will allow:
> 1. Later traceability when we do a git bisect to know a specific change
> if we are tracking a bug at a later date.
> 2. easier review for us as each would be one smaller chunk topic to review

Only DPLL4Mx specific changes are added under CK_363X flag. There are no other 3630 Clock changes. May be I can add few more details in Commit message to describe the changes better.

> 
> >
> >  static struct omap_clk omap34xx_clks[] = {
> >  	CLK(NULL,	"omap_32k_fck",	&omap_32k_fck,	CK_3XXX),
> > @@ -134,13 +136,13 @@ static struct omap_clk omap34xx_clks[] = {
> >  	CLK(NULL,	"omap_12m_fck",	&omap_12m_fck,	CK_3XXX),
> >  	CLK(NULL,	"dpll4_m2_ck",	&dpll4_m2_ck,	CK_3XXX),
> >  	CLK(NULL,	"dpll4_m2x2_ck", &dpll4_m2x2_ck, CK_3XXX),
> > -	CLK(NULL,	"dpll4_m3_ck",	&dpll4_m3_ck,	CK_3XXX),
> > +	CLK(NULL,	"dpll4_m3_ck",	&dpll4_m3_ck,	CK_3XXX | CK_363X),
> 
> >  	CLK(NULL,	"dpll4_m3x2_ck", &dpll4_m3x2_ck, CK_3XXX),
> > -	CLK(NULL,	"dpll4_m4_ck",	&dpll4_m4_ck,	CK_3XXX),
> > +	CLK(NULL,	"dpll4_m4_ck",	&dpll4_m4_ck,	CK_3XXX | CK_363X),
> >  	CLK(NULL,	"dpll4_m4x2_ck", &dpll4_m4x2_ck, CK_3XXX),
> > -	CLK(NULL,	"dpll4_m5_ck",	&dpll4_m5_ck,	CK_3XXX),
> > +	CLK(NULL,	"dpll4_m5_ck",	&dpll4_m5_ck,	CK_3XXX | CK_363X),
> >  	CLK(NULL,	"dpll4_m5x2_ck", &dpll4_m5x2_ck, CK_3XXX),
> > -	CLK(NULL,	"dpll4_m6_ck",	&dpll4_m6_ck,	CK_3XXX),
> > +	CLK(NULL,	"dpll4_m6_ck",	&dpll4_m6_ck,	CK_3XXX | CK_363X),
> >  	CLK(NULL,	"dpll4_m6x2_ck", &dpll4_m6x2_ck, CK_3XXX),
> >  	CLK(NULL,	"emu_per_alwon_ck", &emu_per_alwon_ck, CK_3XXX),
> >  	CLK(NULL,	"dpll5_ck",	&dpll5_ck,	CK_3430ES2),
> > @@ -1222,6 +1224,8 @@ int __init omap2_clk_init(void)
> >  				OMAP3630_PERIPH_DPLL_DCO_SEL_MASK;
> >  			dpll4_ck.dpll_data->sd_div_mask =
> >  				OMAP3630_PERIPH_DPLL_SD_DIV_MASK;
> > +			dpll4_dd.mult_mask = OMAP3630_PERIPH_DPLL_MULT_MASK;
> > +			cpu_mask |= RATE_IN_363X;
> these two things probably are different actions..
> 
Not really. It is just to mark that 3630 specific Clock changes (DPLL4Mx) are under flag RATE_IN_363X
> >  			}
> >  	}
> >
> > @@ -1232,6 +1236,12 @@ int __init omap2_clk_init(void)
> >
> >  	for (c = omap34xx_clks; c < omap34xx_clks + ARRAY_SIZE(omap34xx_clks);
> c++)
> >  		if (c->cpu & cpu_clkflg) {
> > +			/* for 3630, change the mask value for clocks which are
> > +				marked as CK_363X*/
> > +			if (cpu_is_omap3630() && (c->cpu & CK_363X)) {
> > +				c->lk.clk->clksel_mask =
> > +						c->lk.clk->clksel_mask_3630;
> > +			}
> >  			clkdev_add(&c->lk);
> >  			clk_register(c->lk.clk);
> >  			omap2_init_clk_clkdm(c->lk.clk);
> > diff --git a/arch/arm/mach-omap2/clock34xx.h b/arch/arm/mach-
> omap2/clock34xx.h
> > index 813a83e..93c92e5 100644
> > --- a/arch/arm/mach-omap2/clock34xx.h
> > +++ b/arch/arm/mach-omap2/clock34xx.h
> > @@ -243,6 +243,42 @@ static const struct clksel_rate div16_dpll_rates[] = {
> >  	{ .div = 0 }
> >  };
> >
> > +static const struct clksel_rate div32_dpll_rates[] = {
> > +	{ .div = 1, .val = 1, .flags = RATE_IN_3XXX | DEFAULT_RATE },
> > +	{ .div = 2, .val = 2, .flags = RATE_IN_3XXX },
> > +	{ .div = 3, .val = 3, .flags = RATE_IN_3XXX },
> > +	{ .div = 4, .val = 4, .flags = RATE_IN_3XXX },
> > +	{ .div = 5, .val = 5, .flags = RATE_IN_3XXX },
> > +	{ .div = 6, .val = 6, .flags = RATE_IN_3XXX },
> > +	{ .div = 7, .val = 7, .flags = RATE_IN_3XXX },
> > +	{ .div = 8, .val = 8, .flags = RATE_IN_3XXX },
> > +	{ .div = 9, .val = 9, .flags = RATE_IN_3XXX },
> > +	{ .div = 10, .val = 10, .flags = RATE_IN_3XXX },
> > +	{ .div = 11, .val = 11, .flags = RATE_IN_3XXX },
> > +	{ .div = 12, .val = 12, .flags = RATE_IN_3XXX },
> > +	{ .div = 13, .val = 13, .flags = RATE_IN_3XXX },
> > +	{ .div = 14, .val = 14, .flags = RATE_IN_3XXX },
> > +	{ .div = 15, .val = 15, .flags = RATE_IN_3XXX },
> > +	{ .div = 16, .val = 16, .flags = RATE_IN_3XXX },
> > +	{ .div = 17, .val = 17, .flags = RATE_IN_363X },
> > +	{ .div = 18, .val = 18, .flags = RATE_IN_363X },
> > +	{ .div = 19, .val = 19, .flags = RATE_IN_363X },
> > +	{ .div = 20, .val = 20, .flags = RATE_IN_363X },
> > +	{ .div = 21, .val = 21, .flags = RATE_IN_363X },
> > +	{ .div = 22, .val = 22, .flags = RATE_IN_363X },
> > +	{ .div = 23, .val = 23, .flags = RATE_IN_363X },
> > +	{ .div = 24, .val = 24, .flags = RATE_IN_363X },
> > +	{ .div = 25, .val = 25, .flags = RATE_IN_363X },
> > +	{ .div = 26, .val = 26, .flags = RATE_IN_363X },
> > +	{ .div = 27, .val = 27, .flags = RATE_IN_363X },
> > +	{ .div = 28, .val = 28, .flags = RATE_IN_363X },
> > +	{ .div = 29, .val = 29, .flags = RATE_IN_363X },
> > +	{ .div = 30, .val = 30, .flags = RATE_IN_363X },
> > +	{ .div = 31, .val = 31, .flags = RATE_IN_363X },
> > +	{ .div = 32, .val = 32, .flags = RATE_IN_363X },
> > +	{ .div = 0 }
> > +};
> > +
> 
> I this this change deserves it's own patch.. as it introduces something
> for 34xx and 36xx in one shot - which I think was the intention of your
> original patch.

Again this change is required only for DPLL4MX change. For me it does not make much sense to split into a separate patch since it does not add any functionally on it's own without other changes.

> 
> >  /* DPLL1 */
> >  /* MPU clock source */
> >  /* Type: DPLL */
> > @@ -588,6 +624,11 @@ static const struct clksel div16_dpll4_clksel[] = {
> >  	{ .parent = NULL }
> >  };
> >
> > +static const struct clksel div32_dpll4_clksel[] = {
> > +	{ .parent = &dpll4_ck, .rates = div32_dpll_rates },
> > +	{ .parent = NULL }
> > +};
> > +
> >  /* This virtual clock is the source for dpll4_m2x2_ck */
> >  static struct clk dpll4_m2_ck = {
> >  	.name		= "dpll4_m2_ck",
> > @@ -668,7 +709,8 @@ static struct clk dpll4_m3_ck = {
> >  	.init		= &omap2_init_clksel_parent,
> >  	.clksel_reg	= OMAP_CM_REGADDR(OMAP3430_DSS_MOD, CM_CLKSEL),
> >  	.clksel_mask	= OMAP3430_CLKSEL_TV_MASK,
> > -	.clksel		= div16_dpll4_clksel,
> > +	.clksel_mask_3630 = OMAP3630_CLKSEL_TV_MASK,
> > +	.clksel		= div32_dpll4_clksel,
> >  	.clkdm_name	= "dpll4_clkdm",
> >  	.recalc		= &omap2_clksel_recalc,
> >  };
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
> > @@ -781,7 +824,8 @@ static struct clk dpll4_m5_ck = {
> >  	.init		= &omap2_init_clksel_parent,
> >  	.clksel_reg	= OMAP_CM_REGADDR(OMAP3430_CAM_MOD, CM_CLKSEL),
> >  	.clksel_mask	= OMAP3430_CLKSEL_CAM_MASK,
> > -	.clksel		= div16_dpll4_clksel,
> > +	.clksel_mask_3630 = OMAP3630_CLKSEL_CAM_MASK,
> > +	.clksel		= div32_dpll4_clksel,
> >  	.clkdm_name	= "dpll4_clkdm",
> >  	.recalc		= &omap2_clksel_recalc,
> >  };
> > @@ -806,7 +850,8 @@ static struct clk dpll4_m6_ck = {
> >  	.init		= &omap2_init_clksel_parent,
> >  	.clksel_reg	= OMAP_CM_REGADDR(OMAP3430_EMU_MOD, CM_CLKSEL1),
> >  	.clksel_mask	= OMAP3430_DIV_DPLL4_MASK,
> > -	.clksel		= div16_dpll4_clksel,
> > +	.clksel_mask_3630 = OMAP3630_DIV_DPLL4_MASK,
> > +	.clksel		= div32_dpll4_clksel,
> >  	.clkdm_name	= "dpll4_clkdm",
> >  	.recalc		= &omap2_clksel_recalc,
> >  };
> > diff --git a/arch/arm/mach-omap2/cm-regbits-34xx.h b/arch/arm/mach-omap2/cm-
> regbits-34xx.h
> > index 6f2802b..a6383f9 100644
> > --- a/arch/arm/mach-omap2/cm-regbits-34xx.h
> > +++ b/arch/arm/mach-omap2/cm-regbits-34xx.h
> > @@ -516,7 +516,8 @@
> >
> >  /* CM_CLKSEL2_PLL */
> >  #define OMAP3430_PERIPH_DPLL_MULT_SHIFT			8
> > -#define OMAP3430_PERIPH_DPLL_MULT_MASK			(0xfff << 8)
> > +#define OMAP3430_PERIPH_DPLL_MULT_MASK			(0x7ff << 8)
> > +#define OMAP3630_PERIPH_DPLL_MULT_MASK			(0xfff << 8)
> >  #define OMAP3430_PERIPH_DPLL_DIV_SHIFT			0
> >  #define OMAP3430_PERIPH_DPLL_DIV_MASK			(0x7f << 0)
> >  #define OMAP3630_PERIPH_DPLL_DCO_SEL_SHIFT		21
> > @@ -573,8 +574,10 @@
> >  /* CM_CLKSEL_DSS */
> >  #define OMAP3430_CLKSEL_TV_SHIFT			8
> >  #define OMAP3430_CLKSEL_TV_MASK				(0x1f << 8)
> > +#define OMAP3630_CLKSEL_TV_MASK				(0x3f << 8)
> >  #define OMAP3430_CLKSEL_DSS1_SHIFT			0
> >  #define OMAP3430_CLKSEL_DSS1_MASK			(0x1f << 0)
> > +#define OMAP3630_CLKSEL_DSS1_MASK			(0x3f << 0)
> >
> >  /* CM_SLEEPDEP_DSS specific bits */
> >
> > @@ -602,6 +605,7 @@
> >  /* CM_CLKSEL_CAM */
> >  #define OMAP3430_CLKSEL_CAM_SHIFT			0
> >  #define OMAP3430_CLKSEL_CAM_MASK			(0x1f << 0)
> > +#define OMAP3630_CLKSEL_CAM_MASK			(0x3f << 0)
> >
> >  /* CM_SLEEPDEP_CAM specific bits */
> >
> > @@ -697,6 +701,7 @@
> >  /* CM_CLKSEL1_EMU */
> >  #define OMAP3430_DIV_DPLL4_SHIFT			24
> >  #define OMAP3430_DIV_DPLL4_MASK				(0x1f << 24)
> > +#define OMAP3630_DIV_DPLL4_MASK				(0x3f << 24)
> >  #define OMAP3430_DIV_DPLL3_SHIFT			16
> >  #define OMAP3430_DIV_DPLL3_MASK				(0x1f << 16)
> >  #define OMAP3430_CLKSEL_TRACECLK_SHIFT			11
> > diff --git a/arch/arm/plat-omap/include/plat/clock.h b/arch/arm/plat-
> omap/include/plat/clock.h
> > index 359ccb4..0e0a5cc 100644
> > --- a/arch/arm/plat-omap/include/plat/clock.h
> > +++ b/arch/arm/plat-omap/include/plat/clock.h
> > @@ -93,7 +93,7 @@ struct clk {
> >  		defined(CONFIG_ARCH_OMAP4)
> >  	u8			fixed_div;
> >  	void __iomem		*clksel_reg;
> > -	u32			clksel_mask;
> > +	u32			clksel_mask, clksel_mask_3630;
> 
> why cant we use clksel_mask instead of introducing mask_3630? from my
> reading, you have specific dividers marked with 3XX and 36XX masks anyways..

We can avoid using clksel_mask_3630 by overwriting clksel_mask with 3630 mask MACRO. However this approach is not generic and will not scale if we have more dplls with clksel changes in future. Having separate clksel will make it more generic. 
> 
> >  	const struct clksel	*clksel;
> >  	struct dpll_data	*dpll_data;
> >  	const char		*clkdm_name;
> > @@ -159,7 +159,7 @@ extern const struct clkops clkops_null;
> >  #define RATE_IN_243X		(1 << 2)
> >  #define RATE_IN_3XXX		(1 << 3)	/* rates common to all 343X */
> >  #define RATE_IN_3430ES2		(1 << 4)	/* 3430ES2 rates only */
> > -
> > +#define RATE_IN_363X		(1 << 5)        /* rates common to all 343X */
> >  #define RATE_IN_24XX		(RATE_IN_242X | RATE_IN_243X)
> >
> >
> 
> 
> --
> Regards,
> Nishanth Menon

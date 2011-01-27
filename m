From: Rajendra Nayak <rnayak@ti.com>
Subject: RE: [RFC 2/3] OMAP3: PM: Fix CLK_SRC mask for IVA2 and MPU on 3430ES2PLUS
Date: Thu, 27 Jan 2011 08:13:06 +0530
Message-ID: <ed776c2c7a95c4d81c8adf03fb62f790@mail.gmail.com>
References: <1295446466-23655-1-git-send-email-rnayak@ti.com><1295446466-23655-2-git-send-email-rnayak@ti.com><1295446466-23655-3-git-send-email-rnayak@ti.com><877hdu6jjg.fsf@ti.com><d1d35c9cad65b4eb1eade2e7bf93125d@mail.gmail.com>
 <87y6690ybs.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:36083 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754387Ab1A0CnH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 26 Jan 2011 21:43:07 -0500
Received: by fxm11 with SMTP id 11so1957078fxm.40
        for <linux-omap@vger.kernel.org>; Wed, 26 Jan 2011 18:43:04 -0800 (PST)
In-Reply-To: <87y6690ybs.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com

Hi Kevin,

> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@ti.com]
> Sent: Tuesday, January 25, 2011 9:29 PM
> To: Rajendra Nayak
> Cc: linux-omap@vger.kernel.org; paul@pwsan.com
> Subject: Re: [RFC 2/3] OMAP3: PM: Fix CLK_SRC mask for IVA2 and MPU on
3430ES2PLUS
>
> Rajendra Nayak <rnayak@ti.com> writes:
>
> > Hi Kevin,
> >
> >> -----Original Message-----
> >> From: Kevin Hilman [mailto:khilman@ti.com]
> >> Sent: Tuesday, January 25, 2011 3:39 AM
> >> To: Rajendra Nayak
> >> Cc: linux-omap@vger.kernel.org; paul@pwsan.com
> >> Subject: Re: [RFC 2/3] OMAP3: PM: Fix CLK_SRC mask for IVA2 and MPU
on
> > 3430ES2PLUS
> >>
> >> Rajendra Nayak <rnayak@ti.com> writes:
> >>
> >> > The IVA2_CLK_SRC and MPU_CLK_SRC for OMAP3430 ES2
> >> > and above are 3 bit fields.
> >> > Define new masks for them, and since they are used
> >> > in a couple of clock nodes, model separate clock
> >> > nodes for 3430ES1 and 3430ES2+.
> >>
> >> This part should probably be separated out as a fix for the -rc
cycle.
> >
> > The reason I clubbed this fix here was because it had a dependency on
the
> > 'reference by name' approach added by the previous patch.
> >
> > Else I was looking at creating too many duplicate nodes, since the
clock
> > nodes which get added in this patch
(dpll1_fck_3430es2/dpll2_fck_3430es2)
> > are part of dpll_data.
>
> OK, thanks for the clarifiation.  Might help to add that bit of
> description in the changelog, or after the '---' for the sake of
> reviewers.

Sure, will do that.

Regards,
Rajendra
>
> Thanks,
>
> Kevin
>
> >>
> >> Kevin
> >>
> >> > Also change reference to these new clock nodes
> >> > from clk pointers to clk name and make a call
> >> > to omap_init_clk_pts to init the pointers at
> >> > run time.
> >> >
> >> > Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> >> > ---
> >> >  arch/arm/mach-omap2/clock3xxx_data.c  |   39
> > ++++++++++++++++++++++++++------
> >> >  arch/arm/mach-omap2/cm-regbits-34xx.h |    2 +
> >> >  2 files changed, 33 insertions(+), 8 deletions(-)
> >> >
> >> > diff --git a/arch/arm/mach-omap2/clock3xxx_data.c
> > b/arch/arm/mach-omap2/clock3xxx_data.c
> >> > index 9c87adb..c3a7ff5 100644
> >> > --- a/arch/arm/mach-omap2/clock3xxx_data.c
> >> > +++ b/arch/arm/mach-omap2/clock3xxx_data.c
> >> > @@ -53,10 +53,6 @@
> >> >   * DPLL5 supplies other peripheral clocks (USBHOST, USIM).
> >> >   */
> >> >
> >> > -/* Forward declarations for DPLL bypass clocks */
> >> > -static struct clk dpll1_fck;
> >> > -static struct clk dpll2_fck;
> >> > -
> >> >  /* PRM CLOCKS */
> >> >
> >> >  /* According to timer32k.c, this is a 32768Hz clock, not a 32000Hz
> > clock. */
> >> > @@ -275,7 +271,7 @@ static struct dpll_data dpll1_dd = {
> >> >  	.mult_div1_reg	= OMAP_CM_REGADDR(MPU_MOD,
> > OMAP3430_CM_CLKSEL1_PLL),
> >> >  	.mult_mask	= OMAP3430_MPU_DPLL_MULT_MASK,
> >> >  	.div1_mask	= OMAP3430_MPU_DPLL_DIV_MASK,
> >> > -	.clk_bypass	= &dpll1_fck,
> >> > +	.clk_bypass_name	= "dpll1_fck",
> >> >  	.clk_ref	= &sys_ck,
> >> >  	.freqsel_mask	= OMAP3430_MPU_DPLL_FREQSEL_MASK,
> >> >  	.control_reg	= OMAP_CM_REGADDR(MPU_MOD,
OMAP3430_CM_CLKEN_PLL),
> >> > @@ -347,7 +343,7 @@ static struct dpll_data dpll2_dd = {
> >> >  	.mult_div1_reg	= OMAP_CM_REGADDR(OMAP3430_IVA2_MOD,
> > OMAP3430_CM_CLKSEL1_PLL),
> >> >  	.mult_mask	= OMAP3430_IVA2_DPLL_MULT_MASK,
> >> >  	.div1_mask	= OMAP3430_IVA2_DPLL_DIV_MASK,
> >> > -	.clk_bypass	= &dpll2_fck,
> >> > +	.clk_bypass_name	= "dpll2_fck",
> >> >  	.clk_ref	= &sys_ck,
> >> >  	.freqsel_mask	= OMAP3430_IVA2_DPLL_FREQSEL_MASK,
> >> >  	.control_reg	= OMAP_CM_REGADDR(OMAP3430_IVA2_MOD,
> > OMAP3430_CM_CLKEN_PLL),
> >> > @@ -1077,6 +1073,17 @@ static struct clk dpll1_fck = {
> >> >  	.recalc		= &omap2_clksel_recalc,
> >> >  };
> >> >
> >> > +static struct clk dpll1_fck_3430es2 = {
> >> > +	.name		= "dpll1_fck",
> >> > +	.ops		= &clkops_null,
> >> > +	.parent		= &core_ck,
> >> > +	.init		= &omap2_init_clksel_parent,
> >> > +	.clksel_reg	= OMAP_CM_REGADDR(MPU_MOD,
> > OMAP3430_CM_CLKSEL1_PLL),
> >> > +	.clksel_mask	= OMAP3430ES2_MPU_CLK_SRC_MASK,
> >> > +	.clksel		= div4_core_clksel,
> >> > +	.recalc		= &omap2_clksel_recalc,
> >> > +};
> >> > +
> >> >  static struct clk mpu_ck = {
> >> >  	.name		= "mpu_ck",
> >> >  	.ops		= &clkops_null,
> >> > @@ -1133,6 +1140,17 @@ static struct clk dpll2_fck = {
> >> >  	.recalc		= &omap2_clksel_recalc,
> >> >  };
> >> >
> >> > +static struct clk dpll2_fck_3430es2 = {
> >> > +	.name		= "dpll2_fck",
> >> > +	.ops		= &clkops_null,
> >> > +	.parent		= &core_ck,
> >> > +	.init		= &omap2_init_clksel_parent,
> >> > +	.clksel_reg	= OMAP_CM_REGADDR(OMAP3430_IVA2_MOD,
> > OMAP3430_CM_CLKSEL1_PLL),
> >> > +	.clksel_mask	= OMAP3430ES2_IVA2_CLK_SRC_MASK,
> >> > +	.clksel		= div4_core_clksel,
> >> > +	.recalc		= &omap2_clksel_recalc,
> >> > +};
> >> > +
> >> >  static struct clk iva2_ck = {
> >> >  	.name		= "iva2_ck",
> >> >  	.ops		= &clkops_omap2_dflt_wait,
> >> > @@ -3261,11 +3279,13 @@ static struct omap_clk omap3xxx_clks[] = {
> >> >  	CLK(NULL,	"clkout2_src_ck", &clkout2_src_ck,
CK_3XXX),
> >> >  	CLK(NULL,	"sys_clkout2",	&sys_clkout2,	CK_3XXX),
> >> >  	CLK(NULL,	"corex2_fck",	&corex2_fck,	CK_3XXX),
> >> > -	CLK(NULL,	"dpll1_fck",	&dpll1_fck,	CK_3XXX),
> >> > +	CLK(NULL,	"dpll1_fck",	&dpll1_fck,
CK_3430ES1),
> >> > +	CLK(NULL,	"dpll1_fck",	&dpll1_fck_3430es2,
> > CK_3430ES2PLUS | CK_AM35XX | CK_36XX),
> >> >  	CLK(NULL,	"mpu_ck",	&mpu_ck,	CK_3XXX),
> >> >  	CLK(NULL,	"arm_fck",	&arm_fck,	CK_3XXX),
> >> >  	CLK("etb",	"emu_mpu_alwon_ck", &emu_mpu_alwon_ck,
CK_3XXX),
> >> > -	CLK(NULL,	"dpll2_fck",	&dpll2_fck,	CK_34XX |
> > CK_36XX),
> >> > +	CLK(NULL,	"dpll2_fck",	&dpll2_fck,
CK_3430ES1),
> >> > +	CLK(NULL,	"dpll2_fck",	&dpll2_fck_3430es2,
> > CK_3430ES2PLUS | CK_36XX),
> >> >  	CLK(NULL,	"iva2_ck",	&iva2_ck,	CK_34XX |
> > CK_36XX),
> >> >  	CLK(NULL,	"l3_ick",	&l3_ick,	CK_3XXX),
> >> >  	CLK(NULL,	"l4_ick",	&l4_ick,	CK_3XXX),
> >> > @@ -3535,6 +3555,9 @@ int __init omap3xxx_clk_init(void)
> >> >  			omap2_init_clk_clkdm(c->lk.clk);
> >> >  		}
> >> >
> >> > +	/* Initialise clk pointers for parent/ref/bypass clks */
> >> > +	omap_init_clk_pts();
> >> > +
> >> >  	recalculate_root_clocks();
> >> >
> >> >  	pr_info("Clocking rate (Crystal/Core/MPU):
%ld.%01ld/%ld/%ld
> > MHz\n",
> >> > diff --git a/arch/arm/mach-omap2/cm-regbits-34xx.h
> > b/arch/arm/mach-omap2/cm-regbits-34xx.h
> >> > index b912759..fd80872 100644
> >> > --- a/arch/arm/mach-omap2/cm-regbits-34xx.h
> >> > +++ b/arch/arm/mach-omap2/cm-regbits-34xx.h
> >> > @@ -80,6 +80,7 @@
> >> >  /* CM_CLKSEL1_PLL_IVA2 */
> >> >  #define OMAP3430_IVA2_CLK_SRC_SHIFT			19
> >> >  #define OMAP3430_IVA2_CLK_SRC_MASK			(0x3 <<
19)
> >> > +#define OMAP3430ES2_IVA2_CLK_SRC_MASK			(0x7 <<
> > 19)
> >> >  #define OMAP3430_IVA2_DPLL_MULT_SHIFT			8
> >> >  #define OMAP3430_IVA2_DPLL_MULT_MASK			(0x7ff <<
> > 8)
> >> >  #define OMAP3430_IVA2_DPLL_DIV_SHIFT			0
> >> > @@ -125,6 +126,7 @@
> >> >  /* CM_CLKSEL1_PLL_MPU */
> >> >  #define OMAP3430_MPU_CLK_SRC_SHIFT			19
> >> >  #define OMAP3430_MPU_CLK_SRC_MASK			(0x3 <<
19)
> >> > +#define OMAP3430ES2_MPU_CLK_SRC_MASK			(0x7 <<
> > 19)
> >> >  #define OMAP3430_MPU_DPLL_MULT_SHIFT			8
> >> >  #define OMAP3430_MPU_DPLL_MULT_MASK			(0x7ff <<
> > 8)
> >> >  #define OMAP3430_MPU_DPLL_DIV_SHIFT			0

From: "Sripathy, Vishwanath" <vishwanath.bs@ti.com>
Subject: RE: [PATCHV2 1/4] OMAP3: introduce DPLL4 Jtype
Date: Tue, 1 Dec 2009 19:57:56 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC35608702FA90250A@dbde02.ent.ti.com>
References: <1259211517-12713-1-git-send-email-vishwanath.bs@ti.com>
 <1259211517-12713-2-git-send-email-vishwanath.bs@ti.com>
 <alpine.DEB.2.00.0911300141440.17083@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:36336 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752305AbZLAO17 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Dec 2009 09:27:59 -0500
In-Reply-To: <alpine.DEB.2.00.0911300141440.17083@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "ext-ari.kauppi@nokia.com" <ext-ari.kauppi@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Woodruff, Richard" <r-woodruff2@ti.com>, "Menon, Nishanth" <nm@ti.com>

Paul

> -----Original Message-----
> From: Paul Walmsley [mailto:paul@pwsan.com]
> Sent: Monday, November 30, 2009 3:00 PM
> To: Sripathy, Vishwanath
> Cc: ext-ari.kauppi@nokia.com; linux-omap@vger.kernel.org; Woodruff, Richard;
> Menon, Nishanth
> Subject: Re: [PATCHV2 1/4] OMAP3: introduce DPLL4 Jtype
> 
> Hello Vishwanath,
> 
> a few comments:
> 
> On Thu, 26 Nov 2009, Vishwanath BS wrote:
> 
> > From: Richard Woodruff <r-woodruff2@ti.com>
> >
> > DPLL4 for 3630 introduces a changed block requiring special divisor bits and
> > additional reg fields. To allow for silicons to use this, this is introduced
> > as a omap3_has_jtype_dpll4() and is enabled for 3630 silicon
> >
> > Tested with 3630 ZOOM3
> 
> Could you please consider Ari Kauppi's suggestions that he posted on
> 30 and 31 October?  They look good to me.  Here is a link:
> 
Regarding comments from Ari Kauppi on addition of dco_sel_mask and sd_div_mask, yes I had a look at them. However I feel, it's better to have these masks in the structure variable. Reason being this approach will help us to support when dpll types for other dplls get changed in future. For example, if dpll3 block is changed, then having new mask will help us to support it.  

>     http://patchwork.kernel.org/patch/55009/
> 
> Also, finally got the 3630 documents, so some more detailed comments are
> now possible:
> 
> - One thing that is confusing is that the 3630 Rev A TRM (SWPU176A)
> conflicts with the 34xx-36xx Delta TRM (SWPU204).  For example, the delta
> TRM claims that the FREQSEL bits are all removed, but the 3630 TRM claims
> that they are still present.  Could you find out which one is correct?  If
> no FREQSEL bits are present, then the clock code shouldn't write to them.
> 

3630 TRM (Rev A) shows that FREQSEL is no longer present for Per DPLL (CM_CLKEN_PLL [23:20] is reserved). So we should not write freqsel for PER dpll. 

> - Table 3-13 in the delta TRM claims that the DPLL4 multiplier bitfield
> can now go to 4096.  [This looks like an off-by-one error in the
> documentation, since only 12 bits are available, so the max is (2^12 - 1)
> = 4095.]  But the important point for this patch is that the struct
> dpll_data.max_multiplier field for DPLL4 needs to be increased.

I confirmed that DPLL4 Multiplier is 12 bits. So max value is 4095.
> 
> A few more questions below:
> 
> > Cc: Paul Walmsley <paul@pwsan.com>
> >
> > Signed-off-by: Richard Woodruff <r-woodruff2@ti.com>
> > Signed-off-by: Nishanth Menon <nm@ti.com>
> > Signed-off-by: Vishwanath BS <Vishwanath.bs@ti.com>
> > ---
> >  arch/arm/mach-omap2/clock34xx.c         |   51
> ++++++++++++++++++++++++++++++-
> >  arch/arm/mach-omap2/cm-regbits-34xx.h   |    6 +++-
> >  arch/arm/mach-omap2/id.c                |    4 ++-
> >  arch/arm/plat-omap/include/plat/clock.h |    3 ++
> >  arch/arm/plat-omap/include/plat/cpu.h   |    3 +-
> >  5 files changed, 63 insertions(+), 4 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap2/clock34xx.c b/arch/arm/mach-
> omap2/clock34xx.c
> > index da5bc1f..832ed0b 100644
> > --- a/arch/arm/mach-omap2/clock34xx.c
> > +++ b/arch/arm/mach-omap2/clock34xx.c
> > @@ -679,6 +679,41 @@ static void omap3_noncore_dpll_disable(struct clk *clk)
> >  	_omap3_noncore_dpll_stop(clk);
> >  }
> >
> > +/**
> > + * lookup_dco_sddiv -  Set j-type DPLL4 compensation variables
> > + * @clk: pointer to a DPLL struct clk
> > + * @dco: digital control oscillator selector
> > + * @sd_div: target sigma-delta divider
> > + * @m: DPLL multiplier to set
> > + * @n: DPLL divider to set
> > + */
> > +static void lookup_dco_sddiv(struct clk *clk, u8 *dco, u8 *sd_div, u16
> > +								m, u8 n)
> > +	{
> > +	unsigned long fint, clkinp, sd; /* watch out for overflow */
> > +	int mod1, mod2;
> > +
> > +	clkinp = clk->parent->rate;
> > +	fint = (clkinp / n) * m;
> > +
> > +	if (fint < 1000000000)
> > +		*dco = 2;
> > +	else
> > +		*dco = 4;
> > +	/*
> > +	 * target sigma-delta to near 250MHz
> > +	 * sd = ceil[(m/(n+1)) * (clkinp_MHz / 250)]
> > +	 */
> > +	clkinp /= 100000; /* shift from MHz to 10*Hz for 38.4 and 19.2*/
> > +	mod1 = (clkinp * m) % (250 * n);
> > +	sd = (clkinp * m) / (250 * n);
> > +	mod2 = sd % 10;
> > +	sd /= 10;
> > +
> > +	if (mod1 + mod2)
> > +		sd++;
> > +	*sd_div = sd;
> > +}
> >
> >  /* Non-CORE DPLL rate set code */
> >
> > @@ -711,6 +746,13 @@ static int omap3_noncore_dpll_program(struct clk *clk,
> u16 m, u8 n, u16 freqsel)
> >  	v &= ~(dd->mult_mask | dd->div1_mask);
> >  	v |= m << __ffs(dd->mult_mask);
> >  	v |= (n - 1) << __ffs(dd->div1_mask);
> > +	if (dd->jtype) {
> > +		u8 dco, sd_div;
> > +		lookup_dco_sddiv(clk, &dco, &sd_div, m, n);
> > +		v &= ~(dd->dco_sel_mask | dd->sd_div_mask);
> > +		v |=  dco << __ffs(dd->dco_sel_mask);
> > +		v |=  sd_div << __ffs(dd->sd_div_mask);
> > +	}
> >  	__raw_writel(v, dd->mult_div1_reg);
> >
> >  	/* We let the clock framework set the other output dividers later */
> > @@ -1026,7 +1068,7 @@ static unsigned long omap3_clkoutx2_recalc(struct clk
> *clk)
> >
> >  	v = __raw_readl(dd->control_reg) & dd->enable_mask;
> >  	v >>= __ffs(dd->enable_mask);
> > -	if (v != OMAP3XXX_EN_DPLL_LOCKED)
> > +	if (v != OMAP3XXX_EN_DPLL_LOCKED && (!dd->jtype))
> >  		rate = clk->parent->rate;
> >  	else
> >  		rate = clk->parent->rate * 2;
> 
> Could you provide more information, and hopefully a TRM cite, on the above
> change?  It seems that DPLL4's outputs are multiplied by two even if the
> DPLL is unlocked?
> 
In jtype dpll, o/p is same as parent clock. (o/p is NOT multiplied by 2). This is described in the TRM under section 3.5.3.3.3.2 Type B DPLL (Low-Jitter). 
So above condition should have been 
	if ((v != OMAP3XXX_EN_DPLL_LOCKED) || (dd->jtype))
		rate = clk->parent->rate;
  	else
  		rate = clk->parent->rate * 2;
>	
> > @@ -1174,6 +1216,13 @@ int __init omap2_clk_init(void)
> >  			cpu_mask |= RATE_IN_3430ES2;
> >  			cpu_clkflg |= CK_3430ES2;
> >  		}
> > +		if (omap3_has_jtype_dpll4()) {
> > +			dpll4_ck.dpll_data->jtype = 1;
> > +			dpll4_ck.dpll_data->dco_sel_mask =
> > +				OMAP3630_PERIPH_DPLL_DCO_SEL_MASK;
> > +			dpll4_ck.dpll_data->sd_div_mask =
> > +				OMAP3630_PERIPH_DPLL_SD_DIV_MASK;
> > +			}
> 
> Let's not change the clock data at runtime if we can avoid it.  This makes
> clock34xx.h much harder to read.  Instead, how about defining two separate
> struct clks for the 34xx and 36xx DPLL4s -- something like dpll4_ck_34xx
> and dpll4_ck_36xx ? Also two separate struct dpll_data for DPLL4.  Then
> mark them with the appropriate CK_* flags in clock34xx.c.
> 

Then we will need to duplicate whole of dpll4 clock tree. In stead I would rather go with your other suggestion of converting the struct clk parent pointer into a const char * and a struct clk *, the latter resolved at clock code init. Let me explore that. 

> >  	}
> >
> >  	clk_init(&omap2_clk_functions);
> > diff --git a/arch/arm/mach-omap2/cm-regbits-34xx.h b/arch/arm/mach-omap2/cm-
> regbits-34xx.h
> > index 6923deb..6f2802b 100644
> > --- a/arch/arm/mach-omap2/cm-regbits-34xx.h
> > +++ b/arch/arm/mach-omap2/cm-regbits-34xx.h
> > @@ -516,9 +516,13 @@
> >
> >  /* CM_CLKSEL2_PLL */
> >  #define OMAP3430_PERIPH_DPLL_MULT_SHIFT			8
> > -#define OMAP3430_PERIPH_DPLL_MULT_MASK			(0x7ff << 8)
> > +#define OMAP3430_PERIPH_DPLL_MULT_MASK			(0xfff << 8)
> >  #define OMAP3430_PERIPH_DPLL_DIV_SHIFT			0
> >  #define OMAP3430_PERIPH_DPLL_DIV_MASK			(0x7f << 0)
> > +#define OMAP3630_PERIPH_DPLL_DCO_SEL_SHIFT		21
> > +#define OMAP3630_PERIPH_DPLL_DCO_SEL_MASK		(0x7 << 21)
> > +#define OMAP3630_PERIPH_DPLL_SD_DIV_SHIFT		24
> > +#define OMAP3630_PERIPH_DPLL_SD_DIV_MASK		(0xff << 24)
> >
> >  /* CM_CLKSEL3_PLL */
> >  #define OMAP3430_DIV_96M_SHIFT				0
> > diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
> > index f48a4b2..3c1194c 100644
> > --- a/arch/arm/mach-omap2/id.c
> > +++ b/arch/arm/mach-omap2/id.c
> > @@ -176,6 +176,8 @@ void __init omap3_check_features(void)
> >  	OMAP3_CHECK_FEATURE(status, NEON);
> >  	OMAP3_CHECK_FEATURE(status, ISP);
> >
> > +	if (cpu_is_omap3630())
> > +		omap3_features |= OMAP3_HAS_JTYPE_DPLL4;
> >  	/*
> >  	 * TODO: Get additional info (where applicable)
> >  	 *       e.g. Size of L2 cache.
> > @@ -316,7 +318,7 @@ void __init omap3_cpuinfo(void)
> >  	OMAP3_SHOW_FEATURE(sgx);
> >  	OMAP3_SHOW_FEATURE(neon);
> >  	OMAP3_SHOW_FEATURE(isp);
> > -
> > +	OMAP3_SHOW_FEATURE(jtype_dpll4);
> >  	printk(")\n");
> >  }
> >
> > diff --git a/arch/arm/plat-omap/include/plat/clock.h b/arch/arm/plat-
> omap/include/plat/clock.h
> > index 4b8b0d6..66648d4 100644
> > --- a/arch/arm/plat-omap/include/plat/clock.h
> > +++ b/arch/arm/plat-omap/include/plat/clock.h
> > @@ -60,6 +60,9 @@ struct dpll_data {
> >  	void __iomem		*idlest_reg;
> >  	u32			autoidle_mask;
> >  	u32			freqsel_mask;
> > +	u32			dco_sel_mask;
> > +	u32			sd_div_mask;
> > +	u8			jtype;
> 
> As Ari mentioned, these don't seem to be necessary.

Already gave my response 

> 
> >  	u32			idlest_mask;
> >  	u8			auto_recal_bit;
> >  	u8			recal_en_bit;
> > diff --git a/arch/arm/plat-omap/include/plat/cpu.h b/arch/arm/plat-
> omap/include/plat/cpu.h
> > index 2e17890..65c08d5 100644
> > --- a/arch/arm/plat-omap/include/plat/cpu.h
> > +++ b/arch/arm/plat-omap/include/plat/cpu.h
> > @@ -497,6 +497,7 @@ extern u32 omap3_features;
> >  #define OMAP3_HAS_SGX			BIT(2)
> >  #define OMAP3_HAS_NEON			BIT(3)
> >  #define OMAP3_HAS_ISP			BIT(4)
> > +#define OMAP3_HAS_JTYPE_DPLL4		BIT(5)
> >
> >  #define OMAP3_HAS_FEATURE(feat,flag)			\
> >  static inline unsigned int omap3_has_ ##feat(void)	\
> > @@ -509,5 +510,5 @@ OMAP3_HAS_FEATURE(sgx, SGX)
> >  OMAP3_HAS_FEATURE(iva, IVA)
> >  OMAP3_HAS_FEATURE(neon, NEON)
> >  OMAP3_HAS_FEATURE(isp, ISP)
> > -
> > +OMAP3_HAS_FEATURE(jtype_dpll4, JTYPE_DPLL4)
> >  #endif
> > --
> > 1.5.6.3
> >
> 
> 
> - Paul

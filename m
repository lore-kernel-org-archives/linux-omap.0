From: "Kauppi Ari (EXT-Ixonos/Oulu)" <ext-ari.kauppi@nokia.com>
Subject: Re: [PATCH 2/2 v2] OMAP3:clk - introduce DPLL4 jtype support
Date: Fri, 30 Oct 2009 16:23:17 +0200
Message-ID: <1256912597.3638.4.camel@kauppi-desktop>
References: <[PATCH 2/2] OMAP3:clk: introduce DPLL4 jtype support>
	 <1256068968-16564-1-git-send-email-nm@ti.com>
	 <alpine.DEB.2.00.0910282032550.19865@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:60845 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932162AbZJ3OX2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 30 Oct 2009 10:23:28 -0400
In-Reply-To: <alpine.DEB.2.00.0910282032550.19865@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>, Richard Woodruff <r-woodruff2@ti.com>
Cc: ext Paul Walmsley <paul@pwsan.com>, linux-omap <linux-omap@vger.kernel.org>, Vikram Pandita <vikram.pandita@ti.com>, "Sonasath, Moiz Sonasath" <m-sonasath@ti.com>, Sergio Alberto Aguirre Rodriguez <saaguirre@ti.com>

Hi from here, too,

On Thu, 2009-10-29 at 03:39 +0100, ext Paul Walmsley wrote:
> Hi Richard, Nishanth,
> 
> one quick question on this patch:
> 
> On Tue, 20 Oct 2009, Nishanth Menon wrote:
> 
> > From: Richard Woodruff <r-woodruff2@ti.com>
> > 
> > **---
> > V2 - patch with comments from Sergio cleanups in general
> > 	+  static used instead of a global function
> > V1 - original patch
> > **---
> > DPLL4 for 3630 introduces a changed block requiring
> > special divisor bits and additional reg fields
> > 
> > To allow for silicons to use this, this is introduced
> > as a omap3_has_jtype_dpll4() and is enabled for 3630
> > silicon

Sorry about replying on top of Paul's email, I don't seem to have the
original email at my mailbox anymore.

I was wondering where are the dd->dco_sel_mask and dd->sd_div_mask set
to something else than 0? Is the clock34xx.h part of this patch missing?

As far as I can see the structs have some new fields, there are some
#define's but they are not really used anywhere. That means that the bit
clearing part of omap3_noncore_dpll_program for j-type dll does not
really clear the dco_sel / sd_div parts?

> > Tested with SDP3430, SDP3630
> > 
> > Cc: Vikram Pandita <vikram.pandita@ti.com>
> > Cc: Sonasath, Moiz Sonasath <m-sonasath@ti.com>
> > Cc: Sergio Alberto Aguirre Rodriguez <saaguirre@ti.com>
> > Signed-off-by: Richard Woodruff <r-woodruff2@ti.com>
> > Signed-off-by: Nishanth Menon <nm@ti.com>
> > ---
> >  arch/arm/mach-omap2/clock34xx.c         |   46 ++++++++++++++++++++++++++++++-
> >  arch/arm/mach-omap2/cm-regbits-34xx.h   |    6 +++-
> >  arch/arm/mach-omap2/id.c                |    3 ++
> >  arch/arm/plat-omap/include/plat/clock.h |    3 ++
> >  arch/arm/plat-omap/include/plat/cpu.h   |    2 +
> >  5 files changed, 58 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/arm/mach-omap2/clock34xx.c b/arch/arm/mach-omap2/clock34xx.c
> > index c258f87..2ebddb7 100644
> > --- a/arch/arm/mach-omap2/clock34xx.c
> > +++ b/arch/arm/mach-omap2/clock34xx.c
> > @@ -675,6 +675,41 @@ static void omap3_noncore_dpll_disable(struct clk *clk)
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
> > +static void lookup_dco_sddiv(struct clk *clk, u8 *dco, u8 *sd_div, u16 m, u8 n)
> > +{
> > +	unsigned long fint, clkinp, sd; /* watch out for overflow */
> > +	int mod1, mod2;
> > +
> > +	n++; /* always n+1 below */
> 
> The N that's passed into lookup_dco_sddiv() is the real N -- that is, it's 
> the register bitfield plus one.  That can be seen below in this line:
> 
> >  	v |= (n - 1) << __ffs(dd->div1_mask);
> 
> Given this, is the "n++;" above correct?
> 
> The rest of the code looks fine.  (Of course, I can't review the 
> technical basis of the code since I don't have the 3630 docs yet, but I'm 
> fine with taking it in the meantime.)  
> 
> I might change the 'u8 jtype;' field below into 'u8 flags;'; please let me 
> know if you foresee a problem with that.
> 
> 
> - Paul
> 
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
> > @@ -707,6 +742,13 @@ static int omap3_noncore_dpll_program(struct clk *clk, u16 m, u8 n, u16 freqsel)
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
> > @@ -1022,7 +1064,7 @@ static unsigned long omap3_clkoutx2_recalc(struct clk *clk)
> >  
> >  	v = __raw_readl(dd->control_reg) & dd->enable_mask;
> >  	v >>= __ffs(dd->enable_mask);
> > -	if (v != OMAP3XXX_EN_DPLL_LOCKED)
> > +	if (v != OMAP3XXX_EN_DPLL_LOCKED && (!dd->jtype))
> >  		rate = clk->parent->rate;
> >  	else
> >  		rate = clk->parent->rate * 2;
> > @@ -1135,6 +1177,8 @@ int __init omap2_clk_init(void)
> >  			cpu_mask |= RATE_IN_3430ES2;
> >  			cpu_clkflg |= CK_3430ES2;
> >  		}
> > +		if (omap3_has_jtype_dpll4())
> > +			dpll4_ck.dpll_data->jtype = 1;
> >  	}
> >  
> >  	clk_init(&omap2_clk_functions);
> > diff --git a/arch/arm/mach-omap2/cm-regbits-34xx.h b/arch/arm/mach-omap2/cm-regbits-34xx.h
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
> > index 702d3b4..9cddddc 100644
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
> > @@ -314,6 +316,7 @@ void __init omap3_cpuinfo(void)
> >  	OMAP3_SHOW_FEATURE(sgx);
> >  	OMAP3_SHOW_FEATURE(neon);
> >  	OMAP3_SHOW_FEATURE(isp);
> > +	OMAP3_SHOW_FEATURE(jtype_dpll4);
> >  }
> >  
> >  /*
> > diff --git a/arch/arm/plat-omap/include/plat/clock.h b/arch/arm/plat-omap/include/plat/clock.h
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
> >  	u32			idlest_mask;
> >  	u8			auto_recal_bit;
> >  	u8			recal_en_bit;
> > diff --git a/arch/arm/plat-omap/include/plat/cpu.h b/arch/arm/plat-omap/include/plat/cpu.h
> > index 7cb0556..6201a2e 100644
> > --- a/arch/arm/plat-omap/include/plat/cpu.h
> > +++ b/arch/arm/plat-omap/include/plat/cpu.h
> > @@ -482,6 +482,7 @@ extern u32 omap3_features;
> >  #define OMAP3_HAS_SGX			BIT(2)
> >  #define OMAP3_HAS_NEON			BIT(3)
> >  #define OMAP3_HAS_ISP			BIT(4)
> > +#define OMAP3_HAS_JTYPE_DPLL4		BIT(5)
> >  
> >  #define OMAP3_HAS_FEATURE(feat,flag)			\
> >  static inline unsigned int omap3_has_ ##feat(void)	\
> > @@ -494,5 +495,6 @@ OMAP3_HAS_FEATURE(sgx, SGX)
> >  OMAP3_HAS_FEATURE(iva, IVA)
> >  OMAP3_HAS_FEATURE(neon, NEON)
> >  OMAP3_HAS_FEATURE(isp, ISP)
> > +OMAP3_HAS_FEATURE(jtype_dpll4, JTYPE_DPLL4)
> >  
> >  #endif
> > -- 
> > 1.6.3.3
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
> 
> 
> - Paul
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--
Ari


From: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Subject: RE: [PATCH 2/2] OMAP3:clk: introduce DPLL4 jtype support
Date: Tue, 20 Oct 2009 09:15:30 -0500
Message-ID: <A24693684029E5489D1D202277BE89444CFD9B75@dlee02.ent.ti.com>
References: <1256035738-17571-1-git-send-email-nm@ti.com>
 <1256035738-17571-2-git-send-email-nm@ti.com>
 <1256035738-17571-3-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:59558 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751845AbZJTOP3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 Oct 2009 10:15:29 -0400
Received: from dlep33.itg.ti.com ([157.170.170.112])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id n9KEFYoN027559
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 20 Oct 2009 09:15:34 -0500
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep33.itg.ti.com (8.13.7/8.13.7) with ESMTP id n9KEFY2U014410
	for <linux-omap@vger.kernel.org>; Tue, 20 Oct 2009 09:15:34 -0500 (CDT)
Received: from dlee74.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id n9KEFXRt023029
	for <linux-omap@vger.kernel.org>; Tue, 20 Oct 2009 09:15:34 -0500 (CDT)
In-Reply-To: <1256035738-17571-3-git-send-email-nm@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>, linux-omap <linux-omap@vger.kernel.org>
Cc: "Woodruff, Richard" <r-woodruff2@ti.com>, "Pandita, Vikram" <vikram.pandita@ti.com>, "Sonasath, Moiz" <m-sonasath@ti.com>

Nishanth, 

From: linux-omap-owner@vger.kernel.org 
[mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Menon, Nishanth
Sent: Tuesday, October 20, 2009 5:49 AM
> From: Richard Woodruff <r-woodruff2@ti.com>
> 
> DPLL4 for 3630 introduces a changed block requiring
> special divisor bits and additional reg fields
> 
> To allow for silicons to use this, this is introduced
> as a omap3_has_jtype_dpll4() and is enabled for 3630
> silicon
> 
> Tested with SDP3430, SDP3630
> 
> Cc: Vikram Pandita <vikram.pandita@ti.com>
> Cc: Sonasath, Moiz Sonasath <m-sonasath@ti.com>
> Signed-off-by: Richard Woodruff <r-woodruff2@ti.com>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
>  arch/arm/mach-omap2/clock34xx.c         |   45 
> ++++++++++++++++++++++++++++++-
>  arch/arm/mach-omap2/cm-regbits-34xx.h   |    6 +++-
>  arch/arm/mach-omap2/id.c                |    3 ++
>  arch/arm/plat-omap/include/plat/clock.h |    3 ++
>  arch/arm/plat-omap/include/plat/cpu.h   |    2 +
>  5 files changed, 57 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/clock34xx.c 
> b/arch/arm/mach-omap2/clock34xx.c
> index c258f87..ba96023 100644
> --- a/arch/arm/mach-omap2/clock34xx.c
> +++ b/arch/arm/mach-omap2/clock34xx.c
> @@ -675,6 +675,40 @@ static void 
> omap3_noncore_dpll_disable(struct clk *clk)
>  	_omap3_noncore_dpll_stop(clk);
>  }
>  
> +/**
> + * lookup_dco_sddiv -j-type DPLL4 compensation variables

Put a space before the j-type, and add better description.
Doesn't clarify what it really does IMHO:

Something like:
"* lookup_dco_sddiv - Set j-type DPLL4 compensation variables"

> + * @clk: pointer to a DPLL struct clk
> + * @dco: digital control oscillator selector
> + * @sd_div: target sigma-delta divider
> + * @m: DPLL multiplier to set
> + * @n: DPLL divider to set
> + */
> +void lookup_dco_sddiv(struct clk *clk, u8 *dco, u8 *sd_div, 
> u16 m, u8 n)
> +{
> +	unsigned long fint, clkinp, sd; /* watch out for overflow */
> +	int mod1, mod2;

Add Space after var declarations.

Declare function as static.

Should you do something like:

	BUG_ON(!clk->parent);

? (not sure)

What do you think?

Regards,
Sergio

> +	++n; /* always n+1 below */
> +	clkinp = clk->parent->rate;
> +	fint = (clkinp / n) * m;
> +
> +	if (fint < 1000000000)
> +		*dco = 2;
> +	else
> +		*dco = 4;
> +	/*
> +	* target sigma-delta to near 250MHz
> +	* sd = ceil[(m/(n+1)) * (clkinp_MHz / 250)]
> +	*/
> +	clkinp /= 100000; /* shift from MHz to 10*Hz for 38.4 and 19.2*/
> +	mod1 = (clkinp * m) % (250 * n);
> +	sd = (clkinp * m) / (250 * n);
> +	mod2 = sd % 10;
> +	sd /= 10;
> +
> +	if (mod1 + mod2)
> +		++sd;
> +	*sd_div = sd;
> +}
>  
>  /* Non-CORE DPLL rate set code */
>  
> @@ -707,6 +741,13 @@ static int 
> omap3_noncore_dpll_program(struct clk *clk, u16 m, u8 n, u16 freqsel)
>  	v &= ~(dd->mult_mask | dd->div1_mask);
>  	v |= m << __ffs(dd->mult_mask);
>  	v |= (n - 1) << __ffs(dd->div1_mask);
> +	if (dd->jtype) {
> +		u8 dco, sd_div;
> +		lookup_dco_sddiv(clk, &dco, &sd_div, m, n);
> +		v &= ~(dd->dco_sel_mask | dd->sd_div_mask);
> +		v |=  dco << __ffs(dd->dco_sel_mask);
> +		v |=  sd_div << __ffs(dd->sd_div_mask);
> +	}
>  	__raw_writel(v, dd->mult_div1_reg);
>  
>  	/* We let the clock framework set the other output 
> dividers later */
> @@ -1022,7 +1063,7 @@ static unsigned long 
> omap3_clkoutx2_recalc(struct clk *clk)
>  
>  	v = __raw_readl(dd->control_reg) & dd->enable_mask;
>  	v >>= __ffs(dd->enable_mask);
> -	if (v != OMAP3XXX_EN_DPLL_LOCKED)
> +	if (v != OMAP3XXX_EN_DPLL_LOCKED && (!dd->jtype))
>  		rate = clk->parent->rate;
>  	else
>  		rate = clk->parent->rate * 2;
> @@ -1135,6 +1176,8 @@ int __init omap2_clk_init(void)
>  			cpu_mask |= RATE_IN_3430ES2;
>  			cpu_clkflg |= CK_3430ES2;
>  		}
> +		if (omap3_has_jtype_dpll4())
> +			dpll4_ck.dpll_data->jtype = 1;
>  	}
>  
>  	clk_init(&omap2_clk_functions);
> diff --git a/arch/arm/mach-omap2/cm-regbits-34xx.h 
> b/arch/arm/mach-omap2/cm-regbits-34xx.h
> index 6923deb..6f2802b 100644
> --- a/arch/arm/mach-omap2/cm-regbits-34xx.h
> +++ b/arch/arm/mach-omap2/cm-regbits-34xx.h
> @@ -516,9 +516,13 @@
>  
>  /* CM_CLKSEL2_PLL */
>  #define OMAP3430_PERIPH_DPLL_MULT_SHIFT			8
> -#define OMAP3430_PERIPH_DPLL_MULT_MASK			
> (0x7ff << 8)
> +#define OMAP3430_PERIPH_DPLL_MULT_MASK			
> (0xfff << 8)
>  #define OMAP3430_PERIPH_DPLL_DIV_SHIFT			0
>  #define OMAP3430_PERIPH_DPLL_DIV_MASK			
> (0x7f << 0)
> +#define OMAP3630_PERIPH_DPLL_DCO_SEL_SHIFT		21
> +#define OMAP3630_PERIPH_DPLL_DCO_SEL_MASK		(0x7 << 21)
> +#define OMAP3630_PERIPH_DPLL_SD_DIV_SHIFT		24
> +#define OMAP3630_PERIPH_DPLL_SD_DIV_MASK		(0xff << 24)
>  
>  /* CM_CLKSEL3_PLL */
>  #define OMAP3430_DIV_96M_SHIFT				0
> diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
> index 702d3b4..9cddddc 100644
> --- a/arch/arm/mach-omap2/id.c
> +++ b/arch/arm/mach-omap2/id.c
> @@ -176,6 +176,8 @@ void __init omap3_check_features(void)
>  	OMAP3_CHECK_FEATURE(status, NEON);
>  	OMAP3_CHECK_FEATURE(status, ISP);
>  
> +	if (cpu_is_omap3630())
> +		omap3_features |= OMAP3_HAS_JTYPE_DPLL4;
>  	/*
>  	 * TODO: Get additional info (where applicable)
>  	 *       e.g. Size of L2 cache.
> @@ -314,6 +316,7 @@ void __init omap3_cpuinfo(void)
>  	OMAP3_SHOW_FEATURE(sgx);
>  	OMAP3_SHOW_FEATURE(neon);
>  	OMAP3_SHOW_FEATURE(isp);
> +	OMAP3_SHOW_FEATURE(jtype_dpll4);
>  }
>  
>  /*
> diff --git a/arch/arm/plat-omap/include/plat/clock.h 
> b/arch/arm/plat-omap/include/plat/clock.h
> index 4b8b0d6..66648d4 100644
> --- a/arch/arm/plat-omap/include/plat/clock.h
> +++ b/arch/arm/plat-omap/include/plat/clock.h
> @@ -60,6 +60,9 @@ struct dpll_data {
>  	void __iomem		*idlest_reg;
>  	u32			autoidle_mask;
>  	u32			freqsel_mask;
> +	u32			dco_sel_mask;
> +	u32			sd_div_mask;
> +	u8			jtype;
>  	u32			idlest_mask;
>  	u8			auto_recal_bit;
>  	u8			recal_en_bit;
> diff --git a/arch/arm/plat-omap/include/plat/cpu.h 
> b/arch/arm/plat-omap/include/plat/cpu.h
> index 7cb0556..6201a2e 100644
> --- a/arch/arm/plat-omap/include/plat/cpu.h
> +++ b/arch/arm/plat-omap/include/plat/cpu.h
> @@ -482,6 +482,7 @@ extern u32 omap3_features;
>  #define OMAP3_HAS_SGX			BIT(2)
>  #define OMAP3_HAS_NEON			BIT(3)
>  #define OMAP3_HAS_ISP			BIT(4)
> +#define OMAP3_HAS_JTYPE_DPLL4		BIT(5)
>  
>  #define OMAP3_HAS_FEATURE(feat,flag)			\
>  static inline unsigned int omap3_has_ ##feat(void)	\
> @@ -494,5 +495,6 @@ OMAP3_HAS_FEATURE(sgx, SGX)
>  OMAP3_HAS_FEATURE(iva, IVA)
>  OMAP3_HAS_FEATURE(neon, NEON)
>  OMAP3_HAS_FEATURE(isp, ISP)
> +OMAP3_HAS_FEATURE(jtype_dpll4, JTYPE_DPLL4)
>  
>  #endif
> -- 
> 1.6.3.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe 
> linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
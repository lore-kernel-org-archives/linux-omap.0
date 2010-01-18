From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCHV2 2/2] OMAP3630: Clock: Fixing HSDivider Limitation
Date: Mon, 18 Jan 2010 11:04:30 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1001181042530.3977@utopia.booyaka.com>
References: <E0D41E29EB0DAC4E9F3FF173962E9E94026B2DBC17@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:44684 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753591Ab0ARSEb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 Jan 2010 13:04:31 -0500
In-Reply-To: <E0D41E29EB0DAC4E9F3FF173962E9E94026B2DBC17@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "G.N, Vijayakumar" <vijaykumar.gn@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "Turquette, Mike" <mturquette@ti.com>

Vijayakumar, Mike,

some threshold comments,

On Mon, 18 Jan 2010, G.N, Vijayakumar wrote:

> >From 719417657425d4f12369b5ddad79c86baddfefa5 Mon Sep 17 00:00:00 2001
> From: Mike Turquette <mturquette@ti.com>
> Date: Mon, 18 Jan 2010 17:38:19 +0530
> Subject: [PATCH 2/2] OMAP3630: Clock: Fixing HSDivider Limitation

Again please make sure the patch comment area is clean.

> It implements the recommended sequence to solve HS divider PWRDN limitation in
> OMAP3630 DPLL3 and DPLL4.

If there is a Limitation reference number or Errata reference number with 
this issue, please reference it in the patch description or comments so 
people can cross-reference it with documentation.

> Without this workaround the divider value goes
> to its reset state after the corresponding PWRDN bit is set from the
> CM_CLKEN_PLL register. The correct divider value can be restored by
> writing a dummy value to the register different than what is in there, and
> then re-writing the desired value.
> This Work around is applicable for below HS Dividers.
>  1. DPLL3_M3
>  2. DPLL4_M2
>  3. DPLL4_M3
>  4. DPLL4_M4
>  5. DPLL4_M5
>  6. DPLL4_M6
> 
> Signed-off-by: Mike Turquette <mturquette@ti.com>
> Signed-off-by: Vishwanath BS <vishwanath.bs@ti.com>
> Signed-off-by: Vijaykumar GN <vijaykumar.gn@ti.com>
> ---
>  arch/arm/mach-omap2/clock34xx.c      |   36 ++++++++++++++++++++++++++++++++++
>  arch/arm/mach-omap2/clock34xx.h      |    1 +
>  arch/arm/mach-omap2/clock34xx_data.c |   15 ++++++++++++++
>  3 files changed, 52 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/clock34xx.c b/arch/arm/mach-omap2/clock34xx.c
> index 0d30e53..e5213f8 100644
> --- a/arch/arm/mach-omap2/clock34xx.c
> +++ b/arch/arm/mach-omap2/clock34xx.c
> @@ -146,6 +146,42 @@ const struct clkops clkops_omap3430es2_hsotgusb_wait = {
>  	.find_companion = omap2_clk_dflt_find_companion,
>  };
>  
> +/** omap3_pwrdn_clk_enable_with_hsdiv_restore - enable clocks suffering
> + *         from HSDivider problem.

The '/**' needs to be on its own line.  I appreciate the useful comments, 
but please make sure they conform to 
Documentation/kernel-doc-nano-HOWTO.txt

> + * @clk: DPLL output struct clk
> + *
> + * 3630 only: dpll3_m3_ck, dpll4_m2_ck, dpll4_m3_ck, dpll4_m4_ck, dpll4_m5_ck
> + * & dpll4_m6_ck dividers get lost after their respective PWRDN bits are set.
> + * Any write to the corresponding CM_CLKSEL register will refresh the
> + * dividers.  Only x2 clocks are affected, so it is safe to trust the parent
> + * clock information to refresh the CM_CLKSEL registers.
> + */
> +int omap3_pwrdn_clk_enable_with_hsdiv_restore(struct clk *clk)
> +{
> +	u32 v;
> +	int ret;
> +
> +	/* enable the clock */
> +	ret = omap2_dflt_clk_enable(clk);
> +
> +	/* Restore the dividers */
> +	if (!ret) {
> +		v = __raw_readl(clk->parent->clksel_reg);
> +		v += (1 << clk->parent->clksel_shift);

Using += here could affect many bits in the register if the add carries.  
This doesn't seem like what you want.

Also, isn't there a risk of side-effects here, that if this bit was not 
already set, that everything further down the clock tree from this could 
be affected?  Wouldn't it be best to just rewrite the correct clksel 
value?

Also, this should be using __ffs() as mentioned previously.

> +		__raw_writel(v, clk->parent->clksel_reg);
> +		v -= (1 << clk->parent->clksel_shift);

etc., same problems as above.

> +		__raw_writel(v, clk->parent->clksel_reg);

Should there be an OCP barrier after this?  See omap2_clksel_set_rate().

> +	}
> +	return ret;
> +}
> +
> +const struct clkops clkops_omap3_pwrdn_with_hsdiv_wait_restore = {
> +	.enable		= omap3_pwrdn_clk_enable_with_hsdiv_restore,
> +	.disable	= omap2_dflt_clk_disable,
> +	.find_companion	= omap2_clk_dflt_find_companion,
> +	.find_idlest	= omap2_clk_dflt_find_idlest,
> +};
> +
>  const struct clkops clkops_noncore_dpll_ops = {
>  	.enable		= omap3_noncore_dpll_enable,
>  	.disable	= omap3_noncore_dpll_disable,
> diff --git a/arch/arm/mach-omap2/clock34xx.h b/arch/arm/mach-omap2/clock34xx.h
> index 9a2c07e..6f7d271 100644
> --- a/arch/arm/mach-omap2/clock34xx.h
> +++ b/arch/arm/mach-omap2/clock34xx.h
> @@ -20,5 +20,6 @@ extern const struct clkops clkops_omap3430es2_ssi_wait;
>  extern const struct clkops clkops_omap3430es2_hsotgusb_wait;
>  extern const struct clkops clkops_omap3430es2_dss_usbhost_wait;
>  extern const struct clkops clkops_noncore_dpll_ops;
> +extern const struct clkops clkops_omap3_pwrdn_with_hsdiv_wait_restore;
>  
>  #endif
> diff --git a/arch/arm/mach-omap2/clock34xx_data.c b/arch/arm/mach-omap2/clock34xx_data.c
> index 955d4ef..39a1b3c 100755
> --- a/arch/arm/mach-omap2/clock34xx_data.c
> +++ b/arch/arm/mach-omap2/clock34xx_data.c
> @@ -3447,6 +3447,21 @@ int __init omap2_clk_init(void)
>  		dpll4_m4_ck = dpll4_m4_ck_3630;
>  		dpll4_m5_ck = dpll4_m5_ck_3630;
>  		dpll4_m6_ck = dpll4_m6_ck_3630;
> +
> +		/* For 3630: override clkops_omap2_dflt_wait for the
> +		 * clocks affected from HSDivider PWRDN reset limitation */

Your comments need to conform with Documentation/CodingStyle.

> +		dpll3_m3x2_ck.ops =
> +			&clkops_omap3_pwrdn_with_hsdiv_wait_restore;
> +		dpll4_m2x2_ck.ops =
> +			&clkops_omap3_pwrdn_with_hsdiv_wait_restore;
> +		dpll4_m3x2_ck.ops =
> +			&clkops_omap3_pwrdn_with_hsdiv_wait_restore;
> +		dpll4_m4x2_ck.ops =
> +			&clkops_omap3_pwrdn_with_hsdiv_wait_restore;
> +		dpll4_m5x2_ck.ops =
> +			&clkops_omap3_pwrdn_with_hsdiv_wait_restore;
> +		dpll4_m6x2_ck.ops =
> +			&clkops_omap3_pwrdn_with_hsdiv_wait_restore;
>  	} else {
>  		dpll4_dd = dpll4_dd_34xx;
>  		dpll4_m2_ck = dpll4_m2_ck_34xx;
> -- 
> 1.5.6.3


- Paul

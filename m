From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 4/6] OMAP: powerdomain: Arch specific funcs for logic
 control
Date: Sun, 28 Nov 2010 17:17:58 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1011281715040.2515@utopia.booyaka.com>
References: <1289921886-5139-1-git-send-email-rnayak@ti.com> <1289921886-5139-2-git-send-email-rnayak@ti.com> <1289921886-5139-3-git-send-email-rnayak@ti.com> <1289921886-5139-4-git-send-email-rnayak@ti.com> <1289921886-5139-5-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:46248 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754176Ab0K2AR7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 28 Nov 2010 19:17:59 -0500
In-Reply-To: <1289921886-5139-5-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org, b-cousson@ti.com, khilman@deeprootsystems.com

Some comments:

On Tue, 16 Nov 2010, Rajendra Nayak wrote:

> Define the following architecture specific funtions for omap2/3/4
> .pwrdm_set_logic_retst
> .pwrdm_read_logic_pwrst
> .pwrdm_read_prev_logic_pwrst
> .pwrdm_read_logic_retst
> 
> Convert the platform-independent framework to call these functions.
> 
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Benoit Cousson <b-cousson@ti.com>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>
> ---
>  arch/arm/mach-omap2/powerdomains2xxx.c |   34 +++++++++++++++++++++
>  arch/arm/mach-omap2/powerdomains44xx.c |   26 ++++++++++++++++
>  arch/arm/plat-omap/powerdomain.c       |   51 ++++++++++++++------------------
>  3 files changed, 82 insertions(+), 29 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/powerdomains2xxx.c b/arch/arm/mach-omap2/powerdomains2xxx.c
> index dfeb8af..779529d 100644
> --- a/arch/arm/mach-omap2/powerdomains2xxx.c
> +++ b/arch/arm/mach-omap2/powerdomains2xxx.c
> @@ -45,9 +45,43 @@ static int omap2_pwrdm_read_prev_pwrst(struct powerdomain *pwrdm)
>  				OMAP3430_LASTPOWERSTATEENTERED_MASK);
>  }
>  
> +static int omap2_pwrdm_set_logic_retst(struct powerdomain *pwrdm, u8 pwrst)
> +{
> +	u32 v;
> +
> +	v = pwrst << __ffs(OMAP3430_LOGICL1CACHERETSTATE_MASK);
> +	prm_rmw_mod_reg_bits(OMAP3430_LOGICL1CACHERETSTATE_MASK, v,
> +				pwrdm->prcm_offs, OMAP2_PM_PWSTCTRL);
> +
> +	return 0;
> +}
> +
> +static int omap2_pwrdm_read_logic_pwrst(struct powerdomain *pwrdm)
> +{
> +	return prm_read_mod_bits_shift(pwrdm->prcm_offs, OMAP2_PM_PWSTST,
> +					OMAP3430_LOGICSTATEST_MASK);
> +}

Not present on OMAP2xxx, so, does not belong here.

> +
> +
> +static int omap2_pwrdm_read_prev_logic_pwrst(struct powerdomain *pwrdm)
> +{
> +	return prm_read_mod_bits_shift(pwrdm->prcm_offs, OMAP3430_PM_PREPWSTST,
> +					OMAP3430_LASTLOGICSTATEENTERED_MASK);
> +}

Not present on OMAP2xxx, so, does not belong here.

> +
> +static int omap2_pwrdm_read_logic_retst(struct powerdomain *pwrdm)
> +{
> +	return prm_read_mod_bits_shift(pwrdm->prcm_offs, OMAP2_PM_PWSTCTRL,
> +					OMAP3430_LOGICSTATEST_MASK);
> +}

Not present on OMAP2xxx, so, does not belong here.

> +
>  struct pwrdm_functions omap2_pwrdm_functions = {
>  	.pwrdm_set_next_pwrst	= omap2_pwrdm_set_next_pwrst,
>  	.pwrdm_read_next_pwrst	= omap2_pwrdm_read_next_pwrst,
>  	.pwrdm_read_pwrst	= omap2_pwrdm_read_pwrst,
>  	.pwrdm_read_prev_pwrst	= omap2_pwrdm_read_prev_pwrst,
> +	.pwrdm_set_logic_retst	= omap2_pwrdm_set_logic_retst,
> +	.pwrdm_read_logic_pwrst	= omap2_pwrdm_read_logic_pwrst,
> +	.pwrdm_read_prev_logic_pwrst	= omap2_pwrdm_read_prev_logic_pwrst,
> +	.pwrdm_read_logic_retst	= omap2_pwrdm_read_logic_retst,
>  };
> diff --git a/arch/arm/mach-omap2/powerdomains44xx.c b/arch/arm/mach-omap2/powerdomains44xx.c
> index b3aaf9b..016a425 100644
> --- a/arch/arm/mach-omap2/powerdomains44xx.c
> +++ b/arch/arm/mach-omap2/powerdomains44xx.c
> @@ -45,9 +45,35 @@ static int omap4_pwrdm_read_prev_pwrst(struct powerdomain *pwrdm)
>  				OMAP4430_LASTPOWERSTATEENTERED_MASK);
>  }
>  
> +static int omap4_pwrdm_set_logic_retst(struct powerdomain *pwrdm, u8 pwrst)
> +{
> +	u32 v;
> +
> +	v = pwrst << __ffs(OMAP4430_LOGICRETSTATE_MASK);
> +	prm_rmw_mod_reg_bits(OMAP4430_LOGICRETSTATE_MASK, v,
> +				pwrdm->prcm_offs, OMAP4_PM_PWSTCTRL);
> +
> +	return 0;
> +}
> +
> +static int omap4_pwrdm_read_logic_pwrst(struct powerdomain *pwrdm)
> +{
> +	return prm_read_mod_bits_shift(pwrdm->prcm_offs, OMAP4_PM_PWSTST,
> +					OMAP4430_LOGICSTATEST_MASK);
> +}
> +
> +static int omap4_pwrdm_read_logic_retst(struct powerdomain *pwrdm)
> +{
> +	return prm_read_mod_bits_shift(pwrdm->prcm_offs, OMAP4_PM_PWSTCTRL,
> +					OMAP4430_LOGICRETSTATE_MASK);
> +}
> +
>  struct pwrdm_functions omap4_pwrdm_functions = {
>  	.pwrdm_set_next_pwrst	= omap4_pwrdm_set_next_pwrst,
>  	.pwrdm_read_next_pwrst	= omap4_pwrdm_read_next_pwrst,
>  	.pwrdm_read_pwrst	= omap4_pwrdm_read_pwrst,
>  	.pwrdm_read_prev_pwrst	= omap4_pwrdm_read_prev_pwrst,
> +	.pwrdm_set_logic_retst	= omap4_pwrdm_set_logic_retst,
> +	.pwrdm_read_logic_pwrst	= omap4_pwrdm_read_logic_pwrst,
> +	.pwrdm_read_logic_retst	= omap4_pwrdm_read_logic_retst,
>  };
> diff --git a/arch/arm/plat-omap/powerdomain.c b/arch/arm/plat-omap/powerdomain.c
> index 73d6dad..9177fbb 100644
> --- a/arch/arm/plat-omap/powerdomain.c
> +++ b/arch/arm/plat-omap/powerdomain.c
> @@ -531,7 +531,7 @@ int pwrdm_read_prev_pwrst(struct powerdomain *pwrdm)
>   */
>  int pwrdm_set_logic_retst(struct powerdomain *pwrdm, u8 pwrst)
>  {
> -	u32 v;
> +	int ret = -EINVAL;
>  
>  	if (!pwrdm)
>  		return -EINVAL;
> @@ -542,17 +542,10 @@ int pwrdm_set_logic_retst(struct powerdomain *pwrdm, u8 pwrst)
>  	pr_debug("powerdomain: setting next logic powerstate for %s to %0x\n",
>  		 pwrdm->name, pwrst);
>  
> -	/*
> -	 * The register bit names below may not correspond to the
> -	 * actual names of the bits in each powerdomain's register,
> -	 * but the type of value returned is the same for each
> -	 * powerdomain.
> -	 */
> -	v = pwrst << __ffs(OMAP3430_LOGICL1CACHERETSTATE_MASK);
> -	prm_rmw_mod_reg_bits(OMAP3430_LOGICL1CACHERETSTATE_MASK, v,
> -			     pwrdm->prcm_offs, pwrstctrl_reg_offs);
> +	if (arch_pwrdm && arch_pwrdm->pwrdm_set_logic_retst)
> +		ret = arch_pwrdm->pwrdm_set_logic_retst(pwrdm, pwrst);
>  
> -	return 0;
> +	return ret;
>  }
>  
>  /**
> @@ -695,11 +688,15 @@ int pwrdm_set_mem_retst(struct powerdomain *pwrdm, u8 bank, u8 pwrst)
>   */
>  int pwrdm_read_logic_pwrst(struct powerdomain *pwrdm)
>  {
> +	int ret = -EINVAL;
> +
>  	if (!pwrdm)
>  		return -EINVAL;
>  
> -	return prm_read_mod_bits_shift(pwrdm->prcm_offs, pwrstst_reg_offs,
> -				       OMAP3430_LOGICSTATEST_MASK);
> +	if (arch_pwrdm && arch_pwrdm->pwrdm_read_logic_pwrst)
> +		ret = arch_pwrdm->pwrdm_read_logic_pwrst(pwrdm);
> +
> +	return ret;
>  }
>  
>  /**
> @@ -712,17 +709,15 @@ int pwrdm_read_logic_pwrst(struct powerdomain *pwrdm)
>   */
>  int pwrdm_read_prev_logic_pwrst(struct powerdomain *pwrdm)
>  {
> +	int ret = -EINVAL;
> +
>  	if (!pwrdm)
>  		return -EINVAL;
>  
> -	/*
> -	 * The register bit names below may not correspond to the
> -	 * actual names of the bits in each powerdomain's register,
> -	 * but the type of value returned is the same for each
> -	 * powerdomain.
> -	 */
> -	return prm_read_mod_bits_shift(pwrdm->prcm_offs, OMAP3430_PM_PREPWSTST,
> -					OMAP3430_LASTLOGICSTATEENTERED_MASK);
> +	if (arch_pwrdm && arch_pwrdm->pwrdm_read_prev_logic_pwrst)
> +		ret = arch_pwrdm->pwrdm_read_prev_logic_pwrst(pwrdm);
> +
> +	return ret;
>  }
>  
>  /**
> @@ -735,17 +730,15 @@ int pwrdm_read_prev_logic_pwrst(struct powerdomain *pwrdm)
>   */
>  int pwrdm_read_logic_retst(struct powerdomain *pwrdm)
>  {
> +	int ret = -EINVAL;
> +
>  	if (!pwrdm)
>  		return -EINVAL;
>  
> -	/*
> -	 * The register bit names below may not correspond to the
> -	 * actual names of the bits in each powerdomain's register,
> -	 * but the type of value returned is the same for each
> -	 * powerdomain.
> -	 */
> -	return prm_read_mod_bits_shift(pwrdm->prcm_offs, pwrstctrl_reg_offs,
> -				       OMAP3430_LOGICSTATEST_MASK);
> +	if (arch_pwrdm && arch_pwrdm->pwrdm_read_logic_retst)
> +		ret = arch_pwrdm->pwrdm_read_logic_retst(pwrdm);
> +
> +	return ret;
>  }
>  
>  /**
> -- 
> 1.7.0.4
> 


- Paul

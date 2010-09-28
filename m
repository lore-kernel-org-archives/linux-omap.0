From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 08/13 v3] OMAP3: PRCM: Consider UART4 for 3630 chip in
     prcm_setup_regs
Date: Tue, 28 Sep 2010 15:15:24 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1009281514410.5439@utopia.booyaka.com>
References: <43704.10.24.255.17.1285599025.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:58523 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752700Ab0I1VPZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 28 Sep 2010 17:15:25 -0400
In-Reply-To: <43704.10.24.255.17.1285599025.squirrel@dbdmail.itg.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>, "Govindraj.R" <govindraj.raja@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, Sergio Aguirre <saaguirre@ti.com>, Tony Lindgren <tony@atomide.com>

On Mon, 27 Sep 2010, Govindraj.R wrote:

> To standarize among other uarts (1 to 3), we shall now:
> 
>  - Enable uart4 autodile bit.
>  - Enable uart4 wakeup in PER.
>  - Allow uart4 to wakeup the MPU.

... and likewise,

Acked-by: Paul Walmsley <paul@pwsan.com>

> 
> Signed-off-by: Sergio Aguirre <saaguirre@ti.com>
> Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
> ---
>  arch/arm/mach-omap2/cm-regbits-34xx.h  |    2 ++
>  arch/arm/mach-omap2/pm34xx.c           |   15 +++++++++++++--
>  arch/arm/mach-omap2/prcm-common.h      |    2 ++
>  arch/arm/mach-omap2/prm-regbits-34xx.h |    1 +
>  4 files changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/cm-regbits-34xx.h b/arch/arm/mach-omap2/cm-regbits-34xx.h
> index fe82b79..4f959a7 100644
> --- a/arch/arm/mach-omap2/cm-regbits-34xx.h
> +++ b/arch/arm/mach-omap2/cm-regbits-34xx.h
> @@ -649,6 +649,8 @@
>  #define OMAP3430_ST_MCBSP2_MASK				(1 << 0)
> 
>  /* CM_AUTOIDLE_PER */
> +#define OMAP3630_AUTO_UART4_MASK			(1 << 18)
> +#define OMAP3630_AUTO_UART4_SHIFT			18
>  #define OMAP3430_AUTO_GPIO6_MASK			(1 << 17)
>  #define OMAP3430_AUTO_GPIO6_SHIFT			17
>  #define OMAP3430_AUTO_GPIO5_MASK			(1 << 16)
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
> index d2b940c..043faaa 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -676,6 +676,14 @@ static void __init omap3_d2d_idle(void)
> 
>  static void __init prcm_setup_regs(void)
>  {
> +	u32 omap3630_auto_uart4_mask = cpu_is_omap3630() ?
> +					OMAP3630_AUTO_UART4_MASK : 0;
> +	u32 omap3630_en_uart4_mask = cpu_is_omap3630() ?
> +					OMAP3630_EN_UART4_MASK : 0;
> +	u32 omap3630_grpsel_uart4_mask = cpu_is_omap3630() ?
> +					OMAP3630_GRPSEL_UART4_MASK : 0;
> +
> +
>  	/* XXX Reset all wkdeps. This should be done when initializing
>  	 * powerdomains */
>  	prm_write_mod_reg(0, OMAP3430_IVA2_MOD, PM_WKDEP);
> @@ -762,6 +770,7 @@ static void __init prcm_setup_regs(void)
>  		CM_AUTOIDLE);
> 
>  	cm_write_mod_reg(
> +		omap3630_auto_uart4_mask |
>  		OMAP3430_AUTO_GPIO6_MASK |
>  		OMAP3430_AUTO_GPIO5_MASK |
>  		OMAP3430_AUTO_GPIO4_MASK |
> @@ -838,14 +847,16 @@ static void __init prcm_setup_regs(void)
>  				OMAP3430_DSS_MOD, PM_WKEN);
> 
>  	/* Enable wakeups in PER */
> -	prm_write_mod_reg(OMAP3430_EN_GPIO2_MASK | OMAP3430_EN_GPIO3_MASK |
> +	prm_write_mod_reg(omap3630_en_uart4_mask |
> +			  OMAP3430_EN_GPIO2_MASK | OMAP3430_EN_GPIO3_MASK |
>  			  OMAP3430_EN_GPIO4_MASK | OMAP3430_EN_GPIO5_MASK |
>  			  OMAP3430_EN_GPIO6_MASK | OMAP3430_EN_UART3_MASK |
>  			  OMAP3430_EN_MCBSP2_MASK | OMAP3430_EN_MCBSP3_MASK |
>  			  OMAP3430_EN_MCBSP4_MASK,
>  			  OMAP3430_PER_MOD, PM_WKEN);
>  	/* and allow them to wake up MPU */
> -	prm_write_mod_reg(OMAP3430_GRPSEL_GPIO2_MASK |
> +	prm_write_mod_reg(omap3630_grpsel_uart4_mask |
> +			  OMAP3430_GRPSEL_GPIO2_MASK |
>  			  OMAP3430_GRPSEL_GPIO3_MASK |
>  			  OMAP3430_GRPSEL_GPIO4_MASK |
>  			  OMAP3430_GRPSEL_GPIO5_MASK |
> diff --git a/arch/arm/mach-omap2/prcm-common.h b/arch/arm/mach-omap2/prcm-common.h
> index 86edcf9..298a22a 100644
> --- a/arch/arm/mach-omap2/prcm-common.h
> +++ b/arch/arm/mach-omap2/prcm-common.h
> @@ -425,6 +425,8 @@
>  #define OMAP3430_EN_MCBSP2_SHIFT			0
> 
>  /* CM_IDLEST_PER, PM_WKST_PER shared bits */
> +#define OMAP3630_ST_UART4_SHIFT				18
> +#define OMAP3630_ST_UART4_MASK				(1 << 18)
>  #define OMAP3430_ST_GPIO6_SHIFT				17
>  #define OMAP3430_ST_GPIO6_MASK				(1 << 17)
>  #define OMAP3430_ST_GPIO5_SHIFT				16
> diff --git a/arch/arm/mach-omap2/prm-regbits-34xx.h b/arch/arm/mach-omap2/prm-regbits-34xx.h
> index 7fd6023..9e63cb7 100644
> --- a/arch/arm/mach-omap2/prm-regbits-34xx.h
> +++ b/arch/arm/mach-omap2/prm-regbits-34xx.h
> @@ -122,6 +122,7 @@
>  #define OMAP3430_MEMRETSTATE_MASK			(1 << 8)
> 
>  /* PM_MPUGRPSEL_PER, PM_IVA2GRPSEL_PER shared bits */
> +#define OMAP3630_GRPSEL_UART4_MASK			(1 << 18)
>  #define OMAP3430_GRPSEL_GPIO6_MASK			(1 << 17)
>  #define OMAP3430_GRPSEL_GPIO5_MASK			(1 << 16)
>  #define OMAP3430_GRPSEL_GPIO4_MASK			(1 << 15)
> -- 
> 1.6.3.3
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


- Paul

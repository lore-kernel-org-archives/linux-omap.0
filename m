From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 08/12] arm: omap3: am35x: Fix clockdomain dependencies
Date: Wed, 11 Apr 2012 15:44:38 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1204111540060.29473@utopia.booyaka.com>
References: <1334171147-7517-1-git-send-email-mgreer@animalcreek.com> <1334171147-7517-9-git-send-email-mgreer@animalcreek.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:52014 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761321Ab2DKVoj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Apr 2012 17:44:39 -0400
In-Reply-To: <1334171147-7517-9-git-send-email-mgreer@animalcreek.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mark A. Greer" <mgreer@animalcreek.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@ti.com

Hi

a few minor comments based on only a quick look

On Wed, 11 Apr 2012, Mark A. Greer wrote:

> From: "Mark A. Greer" <mgreer@animalcreek.com>
> 
> The am35x family of SoCs do not have an IVA so
> a parallel set of clockdomain dependencies are
> required that are simililar to OMAP3 but without
> any IVA dependencies.
> 
> Signed-off-by: Mark A. Greer <mgreer@animalcreek.com>
> ---
>  arch/arm/mach-omap2/clockdomains3xxx_data.c |  146 ++++++++++++++++++++++++++-
>  1 file changed, 141 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/clockdomains3xxx_data.c b/arch/arm/mach-omap2/clockdomains3xxx_data.c
> index b84e138..a05a8cb 100644
> --- a/arch/arm/mach-omap2/clockdomains3xxx_data.c
> +++ b/arch/arm/mach-omap2/clockdomains3xxx_data.c
> @@ -59,6 +59,12 @@ static struct clkdm_dep gfx_sgx_3xxx_wkdeps[] = {
>  	{ NULL },
>  };
>  
> +static struct clkdm_dep gfx_sgx_am35x_wkdeps[] = {
> +	{ .clkdm_name = "mpu_clkdm", },
> +	{ .clkdm_name = "wkup_clkdm", },
> +	{ NULL },
> +};

Looks like there are an extra set of commas here, maybe just use:

static struct clkdm_dep gfx_sgx_am35x_wkdeps[] = {
	{ .clkdm_name = "mpu_clkdm" },
	{ .clkdm_name = "wkup_clkdm" },
	{ NULL },
};

> +
>  /* 3430: PM_WKDEP_PER: CORE, IVA2, MPU, WKUP */
>  static struct clkdm_dep per_wkdeps[] = {
>  	{ .clkdm_name = "core_l3_clkdm" },
> @@ -69,6 +75,14 @@ static struct clkdm_dep per_wkdeps[] = {
>  	{ NULL },
>  };
>  
> +static struct clkdm_dep per_am35x_wkdeps[] = {
> +	{ .clkdm_name = "core_l3_clkdm" },
> +	{ .clkdm_name = "core_l4_clkdm" },
> +	{ .clkdm_name = "mpu_clkdm" },
> +	{ .clkdm_name = "wkup_clkdm" },
> +	{ NULL },
> +};
> +
>  /* 3430ES2: PM_WKDEP_USBHOST: CORE, IVA2, MPU, WKUP */
>  static struct clkdm_dep usbhost_wkdeps[] = {
>  	{ .clkdm_name = "core_l3_clkdm" },
> @@ -79,6 +93,14 @@ static struct clkdm_dep usbhost_wkdeps[] = {
>  	{ NULL },
>  };
>  
> +static struct clkdm_dep usbhost_am35x_wkdeps[] = {
> +	{ .clkdm_name = "core_l3_clkdm" },
> +	{ .clkdm_name = "core_l4_clkdm" },
> +	{ .clkdm_name = "mpu_clkdm" },
> +	{ .clkdm_name = "wkup_clkdm" },
> +	{ NULL },
> +};
> +
>  /* 3430 PM_WKDEP_MPU: CORE, IVA2, DSS, PER */
>  static struct clkdm_dep mpu_3xxx_wkdeps[] = {
>  	{ .clkdm_name = "core_l3_clkdm" },
> @@ -89,6 +111,14 @@ static struct clkdm_dep mpu_3xxx_wkdeps[] = {
>  	{ NULL },
>  };
>  
> +static struct clkdm_dep mpu_am35x_wkdeps[] = {
> +	{ .clkdm_name = "core_l3_clkdm" },
> +	{ .clkdm_name = "core_l4_clkdm" },
> +	{ .clkdm_name = "dss_clkdm" },
> +	{ .clkdm_name = "per_clkdm" },
> +	{ NULL },
> +};
> +
>  /* 3430 PM_WKDEP_IVA2: CORE, MPU, WKUP, DSS, PER */
>  static struct clkdm_dep iva2_wkdeps[] = {
>  	{ .clkdm_name = "core_l3_clkdm" },
> @@ -116,6 +146,12 @@ static struct clkdm_dep dss_wkdeps[] = {
>  	{ NULL },
>  };
>  
> +static struct clkdm_dep dss_am35x_wkdeps[] = {
> +	{ .clkdm_name = "mpu_clkdm" },
> +	{ .clkdm_name = "wkup_clkdm" },
> +	{ NULL },
> +};
> +
>  /* 3430: PM_WKDEP_NEON: MPU */
>  static struct clkdm_dep neon_wkdeps[] = {
>  	{ .clkdm_name = "mpu_clkdm" },
> @@ -131,6 +167,11 @@ static struct clkdm_dep dss_sleepdeps[] = {
>  	{ NULL },
>  };
>  
> +static struct clkdm_dep dss_am35x_sleepdeps[] = {
> +	{ .clkdm_name = "mpu_clkdm" },
> +	{ NULL },
> +};
> +
>  /* 3430: CM_SLEEPDEP_PER: MPU, IVA */
>  static struct clkdm_dep per_sleepdeps[] = {
>  	{ .clkdm_name = "mpu_clkdm" },
> @@ -138,6 +179,11 @@ static struct clkdm_dep per_sleepdeps[] = {
>  	{ NULL },
>  };
>  
> +static struct clkdm_dep per_am35x_sleepdeps[] = {
> +	{ .clkdm_name = "mpu_clkdm" },
> +	{ NULL },
> +};
> +
>  /* 3430ES2: CM_SLEEPDEP_USBHOST: MPU, IVA */
>  static struct clkdm_dep usbhost_sleepdeps[] = {
>  	{ .clkdm_name = "mpu_clkdm" },
> @@ -145,6 +191,11 @@ static struct clkdm_dep usbhost_sleepdeps[] = {
>  	{ NULL },
>  };
>  
> +static struct clkdm_dep usbhost_am35x_sleepdeps[] = {
> +	{ .clkdm_name = "mpu_clkdm" },
> +	{ NULL },
> +};
> +
>  /* 3430: CM_SLEEPDEP_CAM: MPU */
>  static struct clkdm_dep cam_sleepdeps[] = {
>  	{ .clkdm_name = "mpu_clkdm" },
> @@ -175,6 +226,15 @@ static struct clockdomain mpu_3xxx_clkdm = {
>  	.clktrctrl_mask = OMAP3430_CLKTRCTRL_MPU_MASK,
>  };
>  
> +static struct clockdomain mpu_am35x_clkdm = {
> +	.name		= "mpu_clkdm",
> +	.pwrdm		= { .name = "mpu_pwrdm" },
> +	.flags		= CLKDM_CAN_HWSUP | CLKDM_CAN_FORCE_WAKEUP,
> +	.dep_bit	= OMAP3430_EN_MPU_SHIFT,
> +	.wkdep_srcs	= mpu_am35x_wkdeps,
> +	.clktrctrl_mask = OMAP3430_CLKTRCTRL_MPU_MASK,
> +};
> +
>  static struct clockdomain neon_clkdm = {
>  	.name		= "neon_clkdm",
>  	.pwrdm		= { .name = "neon_pwrdm" },
> @@ -210,6 +270,15 @@ static struct clockdomain sgx_clkdm = {
>  	.clktrctrl_mask = OMAP3430ES2_CLKTRCTRL_SGX_MASK,
>  };
>  
> +static struct clockdomain sgx_am35x_clkdm = {
> +	.name		= "sgx_clkdm",
> +	.pwrdm		= { .name = "sgx_pwrdm" },
> +	.flags		= CLKDM_CAN_HWSUP_SWSUP,
> +	.wkdep_srcs	= gfx_sgx_am35x_wkdeps,
> +	.sleepdep_srcs	= gfx_sgx_sleepdeps,
> +	.clktrctrl_mask = OMAP3430ES2_CLKTRCTRL_SGX_MASK,
> +};
> +
>  /*
>   * The die-to-die clockdomain was documented in the 34xx ES1 TRM, but
>   * then that information was removed from the 34xx ES2+ TRM.  It is
> @@ -261,6 +330,16 @@ static struct clockdomain dss_3xxx_clkdm = {
>  	.clktrctrl_mask = OMAP3430_CLKTRCTRL_DSS_MASK,
>  };
>  
> +static struct clockdomain dss_am35x_clkdm = {
> +	.name		= "dss_clkdm",
> +	.pwrdm		= { .name = "dss_pwrdm" },
> +	.flags		= CLKDM_CAN_HWSUP_SWSUP,
> +	.dep_bit	= OMAP3430_PM_WKDEP_MPU_EN_DSS_SHIFT,
> +	.wkdep_srcs	= dss_am35x_wkdeps,
> +	.sleepdep_srcs	= dss_am35x_sleepdeps,
> +	.clktrctrl_mask = OMAP3430_CLKTRCTRL_DSS_MASK,
> +};
> +
>  static struct clockdomain cam_clkdm = {
>  	.name		= "cam_clkdm",
>  	.pwrdm		= { .name = "cam_pwrdm" },
> @@ -279,6 +358,15 @@ static struct clockdomain usbhost_clkdm = {
>  	.clktrctrl_mask = OMAP3430ES2_CLKTRCTRL_USBHOST_MASK,
>  };
>  
> +static struct clockdomain usbhost_am35x_clkdm = {
> +	.name		= "usbhost_clkdm",
> +	.pwrdm		= { .name = "core_pwrdm" },
> +	.flags		= CLKDM_CAN_HWSUP_SWSUP,
> +	.wkdep_srcs	= usbhost_am35x_wkdeps,
> +	.sleepdep_srcs	= usbhost_am35x_sleepdeps,
> +	.clktrctrl_mask = OMAP3430ES2_CLKTRCTRL_USBHOST_MASK,
> +};
> +
>  static struct clockdomain per_clkdm = {
>  	.name		= "per_clkdm",
>  	.pwrdm		= { .name = "per_pwrdm" },
> @@ -289,6 +377,16 @@ static struct clockdomain per_clkdm = {
>  	.clktrctrl_mask = OMAP3430_CLKTRCTRL_PER_MASK,
>  };
>  
> +static struct clockdomain per_am35x_clkdm = {
> +	.name		= "per_clkdm",
> +	.pwrdm		= { .name = "per_pwrdm" },
> +	.flags		= CLKDM_CAN_HWSUP_SWSUP,
> +	.dep_bit	= OMAP3430_EN_PER_SHIFT,
> +	.wkdep_srcs	= per_am35x_wkdeps,
> +	.sleepdep_srcs	= per_am35x_sleepdeps,
> +	.clktrctrl_mask = OMAP3430_CLKTRCTRL_PER_MASK,
> +};
> +
>  /*
>   * Disable hw supervised mode for emu_clkdm, because emu_pwrdm is
>   * switched of even if sdti is in use
> @@ -341,6 +439,15 @@ static struct clkdm_autodep clkdm_autodeps[] = {
>  	}
>  };
>  
> +static struct clkdm_autodep clkdm_am35x_autodeps[] = {
> +	{
> +		.clkdm = { .name = "mpu_clkdm" },
> +	},
> +	{
> +		.clkdm = { .name = NULL },
> +	}
> +};
> +
>  /*
>   *
>   */
> @@ -366,6 +473,26 @@ static struct clockdomain *clockdomains_omap3430_common[] __initdata = {
>  	NULL
>  };
>  
> +static struct clockdomain *clockdomains_am35x_common[] __initdata = {
> +	&wkup_common_clkdm,
> +	&cm_common_clkdm,
> +	&prm_common_clkdm,
> +	&mpu_am35x_clkdm,
> +	&neon_clkdm,
> +	&sgx_am35x_clkdm,
> +	&core_l3_3xxx_clkdm,
> +	&core_l4_3xxx_clkdm,
> +	&dss_am35x_clkdm,
> +	&per_am35x_clkdm,
> +	&emu_clkdm,
> +	&usbhost_am35x_clkdm,
> +	&dpll1_clkdm,
> +	&dpll3_clkdm,
> +	&dpll4_clkdm,
> +	&dpll5_clkdm,
> +	NULL
> +};

Looks like many of these clockdomains are shared with the rest of 
OMAP3xxx.  Maybe move the shared ones into a common array, remove them 
from clockdomains_omap3430_common, and in the init function below, first 
register the shared ones?  That will avoid duplicate listings.

> +
>  static struct clockdomain *clockdomains_omap3430es1[] __initdata = {
>  	&gfx_3430es1_clkdm,
>  	NULL,
> @@ -381,18 +508,27 @@ static struct clockdomain *clockdomains_omap3430es2plus[] __initdata = {
>  void __init omap3xxx_clockdomains_init(void)
>  {
>  	struct clockdomain **sc;
> +	unsigned int rev;
>  
>  	if (!cpu_is_omap34xx())
>  		return;
>  
>  	clkdm_register_platform_funcs(&omap3_clkdm_operations);
> -	clkdm_register_clkdms(clockdomains_omap3430_common);
>  
> -	sc = (omap_rev() == OMAP3430_REV_ES1_0) ? clockdomains_omap3430es1 :
> -		clockdomains_omap3430es2plus;
> +	rev = omap_rev();
>  
> -	clkdm_register_clkdms(sc);
> +	if (rev == OMAP3517_REV_ES1_0 || rev == OMAP3517_REV_ES1_1) {
> +		clkdm_register_clkdms(clockdomains_am35x_common);
> +		clkdm_register_autodeps(clkdm_am35x_autodeps);
> +	} else {
> +		clkdm_register_clkdms(clockdomains_omap3430_common);
> +
> +		sc = (rev == OMAP3430_REV_ES1_0) ?
> +			clockdomains_omap3430es1 : clockdomains_omap3430es2plus;
> +
> +		clkdm_register_clkdms(sc);
> +		clkdm_register_autodeps(clkdm_autodeps);
> +	}
>  
> -	clkdm_register_autodeps(clkdm_autodeps);
>  	clkdm_complete_init();
>  }
> -- 
> 1.7.9.4
> 


- Paul

From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 1/3] ARM: OMAP2: HACK: hardcode hsmmc2 input clock
 source for N950/N9
Date: Mon, 23 Sep 2013 10:38:43 -0700
Message-ID: <20130923173843.GI2684@atomide.com>
References: <1379771142-29087-1-git-send-email-aaro.koskinen@iki.fi>
 <1379771142-29087-2-git-send-email-aaro.koskinen@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1379771142-29087-2-git-send-email-aaro.koskinen-X3B1VOXEql0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>
Cc: =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sakari Ailus <sakari.ailus-X3B1VOXEql0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org> [130921 06:56]:
> Without this the eMMC (root file system) cannot be used on N950/N9.
> Any ideas for a proper solution?
> 
> Signed-off-by: Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>
> ---
>  arch/arm/mach-omap2/board-generic.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
> index 39c7838..8be49b3 100644
> --- a/arch/arm/mach-omap2/board-generic.c
> +++ b/arch/arm/mach-omap2/board-generic.c
> @@ -20,6 +20,7 @@
>  #include <asm/mach/arch.h>
>  
>  #include "common.h"
> +#include "control.h"
>  #include "common-board-devices.h"
>  #include "dss-common.h"
>  
> @@ -51,12 +52,26 @@ static void __init legacy_init_ehci_clk(char *clkname)
>  	}
>  }
>  
> +static void __init hsmmc2_input_clk(void)
> +{
> +	u32 reg;
> +
> +	reg = omap_ctrl_readl(OMAP343X_CONTROL_DEVCONF1);
> +	reg |= OMAP2_MMCSDIO2ADPCLKISEL;
> +	omap_ctrl_writel(reg, OMAP343X_CONTROL_DEVCONF1);
> +}
> +
>  static void __init omap_generic_init(void)
>  {
>  	omap_sdrc_init(NULL, NULL);
>  
>  	of_platform_populate(NULL, omap_dt_match_table, NULL, NULL);
>  
> +	/* HACK: Configure the MMC input clock source on N950/N9. */
> +	if (of_machine_is_compatible("nokia,omap3-n950") ||
> +	    of_machine_is_compatible("nokia,omap3-n9"))
> +		hsmmc2_input_clk();
> +
>  	/*
>  	 * HACK: call display setup code for selected boards to enable omapdss.
>  	 * This will be removed when omapdss supports DT.
> 

Can you please update this patch on the quirks series I posted
few days ago?

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

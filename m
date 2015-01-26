From: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/4] arm: omap: hwmod: 43xx: add DebugSS hwmod data
Date: Mon, 26 Jan 2015 02:04:35 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1501260142590.5450@utopia.booyaka.com>
References: <1422054704-14915-1-git-send-email-balbi@ti.com> <1422054704-14915-2-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1422054704-14915-2-git-send-email-balbi-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux ARM Kernel Mailing List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi

the references below are from SPRUHL7

On Fri, 23 Jan 2015, Felipe Balbi wrote:

> Without hwmod data for DebugSS, performance monitors
> have no chance of running on AM43xx devices.
> 
> Signed-off-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
> ---
>  arch/arm/mach-omap2/omap_hwmod_43xx_data.c | 40 ++++++++++++++++++++++++++++++
>  arch/arm/mach-omap2/prcm43xx.h             |  1 +
>  2 files changed, 41 insertions(+)
> 
> diff --git a/arch/arm/mach-omap2/omap_hwmod_43xx_data.c b/arch/arm/mach-omap2/omap_hwmod_43xx_data.c
> index 5c6c8410160e..6709704dd5b5 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_43xx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_43xx_data.c
> @@ -19,6 +19,7 @@
>  #include "omap_hwmod.h"
>  #include "omap_hwmod_33xx_43xx_common_data.h"
>  #include "prcm43xx.h"
> +#include "prm44xx.h"
>  #include "omap_hwmod_common_data.h"
>  
>  
> @@ -60,6 +61,44 @@ static struct omap_hwmod am43xx_wkup_m3_hwmod = {
>  	.rst_lines_cnt	= ARRAY_SIZE(am33xx_wkup_m3_resets),
>  };
>  
> +/*
> + * 'debugss' class
> + * debug and emulation sub system
> + */
> +static struct omap_hwmod_opt_clk am43xx_debugss_opt_clks[] = {
> +	{ .role = "dbg_sysclk", .clk = "dbg_sysclk_ck" },
> +	{ .role = "dbg_clka", .clk = "dbg_clka_ck", },
> +	{ .role = "dbg_clkb", .clk = "dbg_clkb_ck", },
> +	{ .role = "dbg_clkc", .clk = "dbg_clkc_ck", },
> +};
> +
> +static struct omap_hwmod_class am43xx_debugss_hwmod_class = {
> +	.name	= "debugss",
> +};
> +
> +/* debugss */
> +static struct omap_hwmod am43xx_debugss_hwmod = {
> +	.name		= "debugss",
> +	.class		= &am43xx_debugss_hwmod_class,
> +	.clkdm_name	= "l3_aon_clkdm",
> +	.main_clk	= "trace_clk_div_ck",
> +	.prcm = {
> +		.omap4 = {
> +			.clkctrl_offs = AM43XX_CM_WKUP_DBGSS_CLKCTRL_OFFSET,

According to Table 6-275 "PRCM_CM_WKUP_DBGSS_CLKCTRL Register Field 
Descriptions" this should have a 

			.modulemode   = MODULEMODE_SWCTRL,

> +		},
> +	},
> +	.opt_clks	= am43xx_debugss_opt_clks,
> +	.opt_clks_cnt	= ARRAY_SIZE(am43xx_debugss_opt_clks),
> +};
> +
> +/* debugss -> l3_main_2 */
> +static struct omap_hwmod_ocp_if am43xx_debugss__l3_main = {
> +	.master		= &am43xx_debugss_hwmod,
> +	.slave		= &am33xx_l3_main_hwmod,
> +	.clk		= "sys_clkin_ck",
> +	.user		= OCP_USER_MPU | OCP_USER_SDMA,
> +};
> +

According to Table 31-25 "Debug Modules Memory Mapping" there are a few 
initiator ports on the DEBUGSS that are connected to various slave ports 
on various chip-wide interconnects: L3_EMU, L4_PER, L4_WAKEUP, L4_CFG. I 
would suggest starting by adding at least one of them as a struct 
omap_hwmod_ocp_if record.  The one attached to L3_EMU would seem like a 
good one to start with.

> diff --git a/arch/arm/mach-omap2/prcm43xx.h b/arch/arm/mach-omap2/prcm43xx.h
> index ad7b3e9977f8..bb42cd80526d 100644
> --- a/arch/arm/mach-omap2/prcm43xx.h
> +++ b/arch/arm/mach-omap2/prcm43xx.h
> @@ -93,6 +93,7 @@
>  #define AM43XX_CM_PER_TIMER5_CLKCTRL_OFFSET		0x0548
>  #define AM43XX_CM_PER_TIMER6_CLKCTRL_OFFSET		0x0550
>  #define AM43XX_CM_PER_TIMER7_CLKCTRL_OFFSET		0x0558
> +#define AM43XX_CM_WKUP_DBGSS_CLKCTRL_OFFSET		0x0020
>  #define AM43XX_CM_WKUP_WKUP_M3_CLKCTRL_OFFSET		0x0228
>  #define AM43XX_CM_WKUP_CONTROL_CLKCTRL_OFFSET		0x0360
>  #define AM43XX_CM_WKUP_SMARTREFLEX0_CLKCTRL_OFFSET	0x0350
> -- 
> 2.3.0-rc1


- Paul
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

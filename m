From: Benoit Cousson <b-cousson@ti.com>
Subject: Re: [RFC 02/14] ARM: OMAP2+: add omapdss_init_of()
Date: Wed, 27 Mar 2013 10:28:51 +0100
Message-ID: <5152BBD3.9070202@ti.com>
References: <1364373921-7599-1-git-send-email-tomi.valkeinen@ti.com> <1364373921-7599-3-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:37781 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751389Ab3C0J3O (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 27 Mar 2013 05:29:14 -0400
In-Reply-To: <1364373921-7599-3-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, Archit Taneja <archit@ti.com>, Andy Gross <andy.gross@ti.com>, Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

Hi Tomi,

On 03/27/2013 09:45 AM, Tomi Valkeinen wrote:
> omapdss driver uses a omapdss platform device to pass platform specific
> function pointers and DSS hardware version from the arch code to the
> driver. This device is needed also when booting with DT.
> 
> This patch adds omapdss_init_of() function, called from board-generic at
> init time, which creates the omapdss device.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> ---
>  arch/arm/mach-omap2/board-generic.c |    1 +
>  arch/arm/mach-omap2/common.h        |    2 ++
>  arch/arm/mach-omap2/display.c       |   34 ++++++++++++++++++++++++++++++++++
>  3 files changed, 37 insertions(+)
> 
> diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
> index a61544b..29eb085 100644
> --- a/arch/arm/mach-omap2/board-generic.c
> +++ b/arch/arm/mach-omap2/board-generic.c
> @@ -41,6 +41,7 @@ static void __init omap_generic_init(void)
>  
>  	of_platform_populate(NULL, omap_dt_match_table, NULL, NULL);
>  
> +	omapdss_init_of();

Mmm, you should not have to call that explicitly. It looks like a hack
to me. Everything in theory should be initialized during
of_platform_populate / driver probe.

>  }
>  
>  #ifdef CONFIG_SOC_OMAP2420
> diff --git a/arch/arm/mach-omap2/common.h b/arch/arm/mach-omap2/common.h
> index 40f4a03..e9ac1fd 100644
> --- a/arch/arm/mach-omap2/common.h
> +++ b/arch/arm/mach-omap2/common.h
> @@ -293,5 +293,7 @@ extern void omap_reserve(void);
>  struct omap_hwmod;
>  extern int omap_dss_reset(struct omap_hwmod *);
>  
> +int __init omapdss_init_of(void);
> +
>  #endif /* __ASSEMBLER__ */
>  #endif /* __ARCH_ARM_MACH_OMAP2PLUS_COMMON_H */
> diff --git a/arch/arm/mach-omap2/display.c b/arch/arm/mach-omap2/display.c
> index ff37be1..c62aee0 100644
> --- a/arch/arm/mach-omap2/display.c
> +++ b/arch/arm/mach-omap2/display.c
> @@ -23,6 +23,8 @@
>  #include <linux/clk.h>
>  #include <linux/err.h>
>  #include <linux/delay.h>
> +#include <linux/of.h>
> +#include <linux/of_platform.h>
>  
>  #include <video/omapdss.h>
>  #include "omap_hwmod.h"
> @@ -564,3 +566,35 @@ int omap_dss_reset(struct omap_hwmod *oh)
>  
>  	return r;
>  }
> +
> +int __init omapdss_init_of(void)
> +{
> +	int r;
> +	enum omapdss_version ver;
> +
> +	static struct omap_dss_board_info board_data = {
> +		.dsi_enable_pads = omap_dsi_enable_pads,
> +		.dsi_disable_pads = omap_dsi_disable_pads,

Pads config should be handle by pinmux framework is possible. Otherwise
a dedicated driver will be required.

> +		.get_context_loss_count = omap_pm_get_dev_context_loss_count,
> +		.set_min_bus_tput = omap_dss_set_min_bus_tput,


All that code should disappear with DT. hacking a platform device with
pdata is the old way of initializing a device.

I know that you do have some omap_pm callback, but you'd better get rid
of them in case of DT boot.
Fixing that is a generic issue, and as soon as a solution will be done
to handle these specific hooks, every drivers will be able to use that.

> +	};
> +
> +	ver = omap_display_get_version();
> +
> +	if (ver == OMAPDSS_VER_UNKNOWN) {
> +		pr_err("DSS not supported on this SoC\n");
> +		return -ENODEV;
> +	}
> +
> +	board_data.version = ver;
> +
> +	omap_display_device.dev.platform_data = &board_data;

Regards,
Benoit


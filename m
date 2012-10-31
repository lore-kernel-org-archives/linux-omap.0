From: Archit Taneja <archit@ti.com>
Subject: Re: [PATCH 12/12] OMAPDSS: DPI: always use DSI PLL if available
Date: Wed, 31 Oct 2012 12:56:06 +0530
Message-ID: <5090D28E.6050703@ti.com>
References: <1351613409-21186-1-git-send-email-tomi.valkeinen@ti.com> <1351613409-21186-13-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:38976 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932294Ab2JaH0W (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 31 Oct 2012 03:26:22 -0400
In-Reply-To: <1351613409-21186-13-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, rob@ti.com

On Tuesday 30 October 2012 09:40 PM, Tomi Valkeinen wrote:
> We currently get the decision whether to use PRCM or DSI PLL clock for
> DPI from the board file. This is not a good way to handle it, and it
> won't work with device tree.
>
> This patch changes DPI to always use DSI PLL if it's available.
>
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> ---
>   drivers/video/omap2/dss/dpi.c |   64 ++++++++++++++++++++++++-----------------
>   1 file changed, 37 insertions(+), 27 deletions(-)
>
> diff --git a/drivers/video/omap2/dss/dpi.c b/drivers/video/omap2/dss/dpi.c
> index 267caf0..32e7dd5 100644
> --- a/drivers/video/omap2/dss/dpi.c
> +++ b/drivers/video/omap2/dss/dpi.c
> @@ -49,28 +49,30 @@ static struct {
>   	struct omap_dss_output output;
>   } dpi;
>
> -static struct platform_device *dpi_get_dsidev(enum omap_dss_clk_source clk)
> +static struct platform_device *dpi_get_dsidev(enum omap_channel channel)
>   {
> -	int dsi_module;
> -
> -	dsi_module = clk == OMAP_DSS_CLK_SRC_DSI_PLL_HSDIV_DISPC ? 0 : 1;
> -
> -	return dsi_get_dsidev_from_id(dsi_module);
> +	switch (channel) {
> +	case OMAP_DSS_CHANNEL_LCD:
> +		return dsi_get_dsidev_from_id(0);
> +	case OMAP_DSS_CHANNEL_LCD2:
> +		return dsi_get_dsidev_from_id(1);
> +	default:
> +		return NULL;
> +	}
>   }
>
> -static bool dpi_use_dsi_pll(struct omap_dss_device *dssdev)
> +static enum omap_dss_clk_source dpi_get_alt_clk_src(enum omap_channel channel)
>   {
> -	if (dssdev->clocks.dispc.dispc_fclk_src ==
> -			OMAP_DSS_CLK_SRC_DSI_PLL_HSDIV_DISPC ||
> -			dssdev->clocks.dispc.dispc_fclk_src ==
> -			OMAP_DSS_CLK_SRC_DSI2_PLL_HSDIV_DISPC ||
> -			dssdev->clocks.dispc.channel.lcd_clk_src ==
> -			OMAP_DSS_CLK_SRC_DSI_PLL_HSDIV_DISPC ||
> -			dssdev->clocks.dispc.channel.lcd_clk_src ==
> -			OMAP_DSS_CLK_SRC_DSI2_PLL_HSDIV_DISPC)
> -		return true;
> -	else
> -		return false;
> +	switch (channel) {
> +	case OMAP_DSS_CHANNEL_LCD:
> +		return OMAP_DSS_CLK_SRC_DSI_PLL_HSDIV_DISPC;
> +	case OMAP_DSS_CHANNEL_LCD2:
> +		return OMAP_DSS_CLK_SRC_DSI2_PLL_HSDIV_DISPC;
> +	default:
> +		/* this shouldn't happen */
> +		WARN_ON(1);
> +		return OMAP_DSS_CLK_SRC_FCK;
> +	}
>   }
>
>   static int dpi_set_dsi_clk(struct omap_dss_device *dssdev,
> @@ -92,7 +94,7 @@ static int dpi_set_dsi_clk(struct omap_dss_device *dssdev,
>   		return r;
>
>   	dss_select_lcd_clk_source(mgr->id,
> -			dssdev->clocks.dispc.channel.lcd_clk_src);
> +			dpi_get_alt_clk_src(mgr->id));
>
>   	dpi.mgr_config.clock_info = dispc_cinfo;
>
> @@ -385,6 +387,8 @@ static int __init dpi_verify_dsi_pll(struct platform_device *dsidev)
>
>   static int __init dpi_init_display(struct omap_dss_device *dssdev)
>   {
> +	struct platform_device *dsidev;
> +
>   	DSSDBG("init_display\n");
>
>   	if (dss_has_feature(FEAT_DPI_USES_VDDS_DSI) &&
> @@ -401,17 +405,23 @@ static int __init dpi_init_display(struct omap_dss_device *dssdev)
>   		dpi.vdds_dsi_reg = vdds_dsi;
>   	}
>
> -	if (dpi_use_dsi_pll(dssdev)) {
> -		enum omap_dss_clk_source dispc_fclk_src =
> -			dssdev->clocks.dispc.dispc_fclk_src;
> -		dpi.dsidev = dpi_get_dsidev(dispc_fclk_src);
> +	/*
> +	 * XXX We shouldn't need dssdev->channel for this. The dsi pll clock
> +	 * source for DPI is SoC integration detail, not something that should
> +	 * be configured in the dssdev
> +	 */

It is SoC integration detail, but it's flexible, it depends on which 
manager is connected to DPI output. If it's connected to LCD1, the 
source can be DSI1 PLL, if it's LCD2, it's source can be DSI2 PLL, if 
it's connected to TV manager, it's source "has to be" HDMI PLL. And 
these connections vary based on which OMAP revision we are on. We can 
only be certain on OMAP3 that the source for DPI pixel clock can be 
either PRCM or DSI PLL.

At the point of probe, we really don't know which manager is the DPI 
output connected to. Hence, we sort of use dssdev->channel to make a 
guess what manager we connect to in the future.

The right approach would be to figure this out at the time of enable, 
where we know which manager the DPI output is connected to. We could 
probably move the verification there too.

Archit

> +	dsidev = dpi_get_dsidev(dssdev->channel);
>
> -		if (dpi_verify_dsi_pll(dpi.dsidev)) {
> -			dpi.dsidev = NULL;
> -			DSSWARN("DSI PLL not operational\n");
> -		}
> +	if (dpi_verify_dsi_pll(dsidev)) {
> +		dsidev = NULL;
> +		DSSWARN("DSI PLL not operational\n");
>   	}
>
> +	if (dsidev)
> +		DSSDBG("using DSI PLL for DPI clock\n");
> +
> +	dpi.dsidev = dsidev;
> +
>   	return 0;
>   }
>
>


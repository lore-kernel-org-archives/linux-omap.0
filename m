From: Archit Taneja <archit@ti.com>
Subject: Re: [PATCH 15/32] OMAPDSS: DPI: cleanup pll & regulator init
Date: Fri, 7 Jun 2013 12:21:35 +0530
Message-ID: <51B182F7.7050002@ti.com>
References: <1369906493-27538-1-git-send-email-tomi.valkeinen@ti.com> <1369906493-27538-16-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:43266 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750871Ab3FGGwt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Jun 2013 02:52:49 -0400
In-Reply-To: <1369906493-27538-16-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org

On Thursday 30 May 2013 03:04 PM, Tomi Valkeinen wrote:
> Split regulator and DSI PLL init code to their own functions for
> clarity.
>
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> ---
>   drivers/video/omap2/dss/dpi.c | 100 ++++++++++++++++++++++--------------------
>   1 file changed, 53 insertions(+), 47 deletions(-)
>
> diff --git a/drivers/video/omap2/dss/dpi.c b/drivers/video/omap2/dss/dpi.c
> index 43f6b26..66ba9a6 100644
> --- a/drivers/video/omap2/dss/dpi.c
> +++ b/drivers/video/omap2/dss/dpi.c
> @@ -545,6 +545,53 @@ static int dpi_verify_dsi_pll(struct platform_device *dsidev)
>   	return 0;
>   }
>
> +static int dpi_init_regulator(void)
> +{
> +	struct regulator *vdds_dsi;
> +
> +	if (!dss_has_feature(FEAT_DPI_USES_VDDS_DSI))
> +		return 0;
> +
> +	if (dpi.vdds_dsi_reg)
> +		return 0;
> +
> +	vdds_dsi = dss_get_vdds_dsi();
> +
> +	if (!IS_ERR(vdds_dsi)) {
> +		dpi.vdds_dsi_from_core = true;
> +		dpi.vdds_dsi_reg = vdds_dsi;
> +		return 0;
> +	}
> +
> +	vdds_dsi = regulator_get(&dpi.pdev->dev, "vdds_dsi");
> +	if (!IS_ERR(vdds_dsi)) {
> +		dpi.vdds_dsi_from_core = false;
> +		dpi.vdds_dsi_reg = vdds_dsi;
> +		return 0;
> +	}
> +
> +	return PTR_ERR(vdds_dsi);
> +}
> +
> +static void dpi_init_pll(void)
> +{
> +	struct platform_device *dsidev;
> +
> +	if (dpi.dsidev)
> +		return;
> +
> +	dsidev = dpi_get_dsidev(dpi.output.dispc_channel);
> +	if (!dsidev)
> +		return;
> +
> +	if (dpi_verify_dsi_pll(dsidev)) {
> +		DSSWARN("DSI PLL not operational\n");
> +		return;
> +	}
> +
> +	dpi.dsidev = dsidev;
> +}
> +
>   /*
>    * Return a hardcoded channel for the DPI output. This should work for
>    * current use cases, but this can be later expanded to either resolve
> @@ -575,46 +622,6 @@ static enum omap_channel dpi_get_channel(void)
>   	}
>   }
>
> -static int dpi_init_display(struct omap_dss_device *dssdev)
> -{
> -	struct platform_device *dsidev;
> -
> -	DSSDBG("init_display\n");
> -
> -	if (dss_has_feature(FEAT_DPI_USES_VDDS_DSI) &&
> -					dpi.vdds_dsi_reg == NULL) {
> -		struct regulator *vdds_dsi;
> -
> -		vdds_dsi = dss_get_vdds_dsi();
> -		if (IS_ERR(vdds_dsi)) {
> -			vdds_dsi = regulator_get(&dpi.pdev->dev, "vdds_dsi");

same comment about devm_ usage here, and the next few patches.

Archit


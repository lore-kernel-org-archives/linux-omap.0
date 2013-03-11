From: Archit Taneja <archit@ti.com>
Subject: Re: [PATCH 10/20] OMAPDSS: Resolve channels for outputs
Date: Mon, 11 Mar 2013 11:05:02 +0530
Message-ID: <513D6D06.7030902@ti.com>
References: <1362743515-10152-1-git-send-email-tomi.valkeinen@ti.com> <1362743515-10152-11-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:38631 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750944Ab3CKFfo (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 Mar 2013 01:35:44 -0400
In-Reply-To: <1362743515-10152-11-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

Hi,

On Friday 08 March 2013 05:21 PM, Tomi Valkeinen wrote:
> The DISPC channel used for each output is currently passed in panel
> platform data from the board files.
>
> To simplify this, and to make the panel drivers less dependent on OMAP,
> this patch changes omapdss to resolve the channel independently. The
> channel is resolved based on the OMAP version and, in case of DSI, the
> DSI module id.
>
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> ---
>   drivers/video/omap2/dss/dpi.c  |   37 ++++++++++++++++++++++++++-----
>   drivers/video/omap2/dss/dsi.c  |   48 ++++++++++++++++++++++++++++++++++++++++
>   drivers/video/omap2/dss/rfbi.c |    2 ++
>   drivers/video/omap2/dss/sdi.c  |    2 ++
>   4 files changed, 84 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/video/omap2/dss/dpi.c b/drivers/video/omap2/dss/dpi.c
> index e282456..3261644 100644
> --- a/drivers/video/omap2/dss/dpi.c
> +++ b/drivers/video/omap2/dss/dpi.c
> @@ -396,12 +396,44 @@ static int __init dpi_verify_dsi_pll(struct platform_device *dsidev)
>   	return 0;
>   }
>
> +/*
> + * Return a hardcoded channel for the DPI output. This should work for
> + * current use cases, but this can be later expanded to either resolve
> + * the channel in some more dynamic manner, or get the channel as a user
> + * parameter.
> + */
> +static enum omap_channel dpi_get_channel(void)
> +{
> +	switch (omapdss_get_version()) {
> +	case OMAPDSS_VER_OMAP24xx:
> +	case OMAPDSS_VER_OMAP34xx_ES1:
> +	case OMAPDSS_VER_OMAP34xx_ES3:
> +	case OMAPDSS_VER_OMAP3630:
> +	case OMAPDSS_VER_AM35xx:
> +		return OMAP_DSS_CHANNEL_LCD;
> +
> +	case OMAPDSS_VER_OMAP4430_ES1:
> +	case OMAPDSS_VER_OMAP4430_ES2:
> +	case OMAPDSS_VER_OMAP4:
> +		return OMAP_DSS_CHANNEL_LCD2;
> +
> +	case OMAPDSS_VER_OMAP5:
> +		return OMAP_DSS_CHANNEL_LCD2;
> +
> +	default:
> +		DSSWARN("unsupported DSS version\n");
> +		return OMAP_DSS_CHANNEL_LCD;
> +	}
> +}
> +
>   static int __init dpi_init_display(struct omap_dss_device *dssdev)
>   {
>   	struct platform_device *dsidev;
>
>   	DSSDBG("init_display\n");
>
> +	dssdev->channel = dpi_get_channel();

In patch 14 of the series, we remove these dssdev->channel assignments. 
I don't see the point of adding them in this patch in the first place. 
The dssdev->channel assignments will not be modified in this series, so 
we don't need to worry about a kernel crash or something after this patch.

I feel this patch should only add the dpi_get_channel and 
dsi_get_channel funcs.

> +
>   	if (dss_has_feature(FEAT_DPI_USES_VDDS_DSI) &&
>   					dpi.vdds_dsi_reg == NULL) {
>   		struct regulator *vdds_dsi;
> @@ -416,11 +448,6 @@ static int __init dpi_init_display(struct omap_dss_device *dssdev)
>   		dpi.vdds_dsi_reg = vdds_dsi;
>   	}
>
> -	/*
> -	 * XXX We shouldn't need dssdev->channel for this. The dsi pll clock
> -	 * source for DPI is SoC integration detail, not something that should
> -	 * be configured in the dssdev
> -	 */
>   	dsidev = dpi_get_dsidev(dssdev->channel);
>
>   	if (dsidev && dpi_verify_dsi_pll(dsidev)) {
> diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
> index 1a6ad6f..c39ca86 100644
> --- a/drivers/video/omap2/dss/dsi.c
> +++ b/drivers/video/omap2/dss/dsi.c
> @@ -4946,6 +4946,52 @@ void omapdss_dsi_set_videomode_timings(struct omap_dss_device *dssdev,
>   }
>   EXPORT_SYMBOL(omapdss_dsi_set_videomode_timings);
>
> +/*
> + * Return a hardcoded channel for the DSI output. This should work for
> + * current use cases, but this can be later expanded to either resolve
> + * the channel in some more dynamic manner, or get the channel as a user
> + * parameter.
> + */
> +static enum omap_channel dsi_get_channel(int module_id)
> +{
> +	switch (omapdss_get_version()) {
> +	case OMAPDSS_VER_OMAP24xx:

We should remove the above case so that we hit the default case and get 
a warning about omap2 not having DSI.

> +	case OMAPDSS_VER_OMAP34xx_ES1:
> +	case OMAPDSS_VER_OMAP34xx_ES3:
> +	case OMAPDSS_VER_OMAP3630:
> +	case OMAPDSS_VER_AM35xx:

<snip>

Archit


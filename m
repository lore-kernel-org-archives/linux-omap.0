From: Archit Taneja <a0393947@ti.com>
Subject: Re: [PATCH 8/8] OMAPDSS: fix use of dssdev->caps
Date: Fri, 24 Aug 2012 11:21:14 +0530
Message-ID: <50371652.2000405@ti.com>
References: <1345729514-2441-1-git-send-email-tomi.valkeinen@ti.com> <1345729514-2441-9-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:38250 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750761Ab2HXFws (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Aug 2012 01:52:48 -0400
In-Reply-To: <1345729514-2441-9-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

On Thursday 23 August 2012 07:15 PM, Tomi Valkeinen wrote:
> Recent commit dca2b1522ccab28d03fb79f6e70e70ea78033d52 (OMAPDSS: DSI:
> Maintain copy of operation mode in driver data) broke DSI for video mode
> displays. The commit changed the way dssdev->caps are initialized, and
> the result was that every DSI display is initialized with manual-update
> and tear-elim caps.

Ah, I didn't realise that. Thanks for catching this.

>
> The code that sets dssdev->caps is not very good, even when fixed.
> omapdss driver shouldn't be writing dssdev->caps at all.
>
> This patch fixes the problem with video mode displays by moving the
> initialization of dssdev->caps to the panel driver. The same change is
> done for RFBI.

Yes, it makes more sense to configure these in the panel driver.

Archit

>
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> ---
>   drivers/video/omap2/displays/panel-n8x0.c |    1 +
>   drivers/video/omap2/displays/panel-taal.c |    2 ++
>   drivers/video/omap2/dss/dsi.c             |    5 -----
>   drivers/video/omap2/dss/rfbi.c            |    1 -
>   4 files changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/video/omap2/displays/panel-n8x0.c b/drivers/video/omap2/displays/panel-n8x0.c
> index 17ae85e..3fc5ad0 100644
> --- a/drivers/video/omap2/displays/panel-n8x0.c
> +++ b/drivers/video/omap2/displays/panel-n8x0.c
> @@ -489,6 +489,7 @@ static int n8x0_panel_probe(struct omap_dss_device *dssdev)
>   	dssdev->panel.timings.y_res = 480;
>   	dssdev->ctrl.pixel_size = 16;
>   	dssdev->ctrl.rfbi_timings = n8x0_panel_timings;
> +	dssdev->caps = OMAP_DSS_DISPLAY_CAP_MANUAL_UPDATE;
>
>   	memset(&props, 0, sizeof(props));
>   	props.max_brightness = 127;
> diff --git a/drivers/video/omap2/displays/panel-taal.c b/drivers/video/omap2/displays/panel-taal.c
> index ddda96a..7b2d7bb 100644
> --- a/drivers/video/omap2/displays/panel-taal.c
> +++ b/drivers/video/omap2/displays/panel-taal.c
> @@ -884,6 +884,8 @@ static int taal_probe(struct omap_dss_device *dssdev)
>
>   	dssdev->panel.timings = panel_config->timings;
>   	dssdev->panel.dsi_pix_fmt = OMAP_DSS_DSI_FMT_RGB888;
> +	dssdev->caps = OMAP_DSS_DISPLAY_CAP_MANUAL_UPDATE |
> +		OMAP_DSS_DISPLAY_CAP_TEAR_ELIM;
>
>   	td = kzalloc(sizeof(*td), GFP_KERNEL);
>   	if (!td) {
> diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
> index 340c832..254666f 100644
> --- a/drivers/video/omap2/dss/dsi.c
> +++ b/drivers/video/omap2/dss/dsi.c
> @@ -4866,11 +4866,6 @@ static int __init dsi_init_display(struct omap_dss_device *dssdev)
>
>   	DSSDBG("DSI init\n");
>
> -	if (dsi->mode == OMAP_DSS_DSI_CMD_MODE) {
> -		dssdev->caps = OMAP_DSS_DISPLAY_CAP_MANUAL_UPDATE |
> -			OMAP_DSS_DISPLAY_CAP_TEAR_ELIM;
> -	}
> -
>   	if (dsi->vdds_dsi_reg == NULL) {
>   		struct regulator *vdds_dsi;
>
> diff --git a/drivers/video/omap2/dss/rfbi.c b/drivers/video/omap2/dss/rfbi.c
> index 5a9c0e9..2e520d3 100644
> --- a/drivers/video/omap2/dss/rfbi.c
> +++ b/drivers/video/omap2/dss/rfbi.c
> @@ -939,7 +939,6 @@ EXPORT_SYMBOL(omapdss_rfbi_display_disable);
>   static int __init rfbi_init_display(struct omap_dss_device *dssdev)
>   {
>   	rfbi.dssdev[dssdev->phy.rfbi.channel] = dssdev;
> -	dssdev->caps = OMAP_DSS_DISPLAY_CAP_MANUAL_UPDATE;
>   	return 0;
>   }
>
>


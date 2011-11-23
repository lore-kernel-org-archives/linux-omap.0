From: Archit Taneja <a0393947@ti.com>
Subject: Re: [PATCH 42/65] OMAPDSS: DSI: call mgr_enable/disable for cmd mode
 displays
Date: Wed, 23 Nov 2011 15:40:20 +0530
Message-ID: <4ECCC68C.7070106@ti.com>
References: <1321953724-6350-1-git-send-email-tomi.valkeinen@ti.com> <1321953724-6350-43-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:53679 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750884Ab1KWKKt (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 23 Nov 2011 05:10:49 -0500
In-Reply-To: <1321953724-6350-43-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, archit@ti.com

On Tuesday 22 November 2011 02:51 PM, Tomi Valkeinen wrote:
> The current code uses dsi_video_mode_enable/disable functions to
> enable/disable DISPC output for video mode displays. For command mode
> displays we have no notion in the DISPC side of whether the panel is
> enabled, except when a dss_start_update() call is made.
>
> However, to properly maintain the DISPC state in apply.c, we need to
> know if a manager used for a manual update display is currently in use.
>
> This patch achieves that by changing dsi_video_mode_enable/disable to
> dsi_enable/disable_video_output, which is called by both video and
> command mode displays. For video mode displays it starts the actual
> pixel stream, as it did before. For command mode displays it doesn't do
> anything else than mark that the manager is currently in use.

dsi_video_mode_enable() doesn't only enable the DISPC output, it also 
sends the long packet header to start video mode transfer.

I think it would be better if we had 2 separate functions, one which 
starts/stops DSI video mode, and the other which enables/disables the 
DISPC video port.

This way, a manual update panel would need to call only 
dsi_enable/disable_video_output(which just enables or disables the 
manager), whereas a video mode panel will need to call both.

This is just a suggestion though. It's probably okay to have both in the 
same function too. We might have to separate them out later if we were 
planning to standardise mipi dsi across SoCs.

Archit

>
> Signed-off-by: Tomi Valkeinen<tomi.valkeinen@ti.com>
> ---
>   drivers/video/omap2/displays/panel-taal.c |    6 ++
>   drivers/video/omap2/dss/apply.c           |    6 ++-
>   drivers/video/omap2/dss/dsi.c             |   73 +++++++++++++++-------------
>   include/video/omapdss.h                   |    4 +-
>   4 files changed, 51 insertions(+), 38 deletions(-)
>
> diff --git a/drivers/video/omap2/displays/panel-taal.c b/drivers/video/omap2/displays/panel-taal.c
> index dd64bd1..00c5c61 100644
> --- a/drivers/video/omap2/displays/panel-taal.c
> +++ b/drivers/video/omap2/displays/panel-taal.c
> @@ -1182,6 +1182,10 @@ static int taal_power_on(struct omap_dss_device *dssdev)
>   	if (r)
>   		goto err;
>
> +	r = dsi_enable_video_output(dssdev, td->channel);
> +	if (r)
> +		goto err;
> +
>   	td->enabled = 1;
>
>   	if (!td->intro_printed) {
> @@ -1211,6 +1215,8 @@ static void taal_power_off(struct omap_dss_device *dssdev)
>   	struct taal_data *td = dev_get_drvdata(&dssdev->dev);
>   	int r;
>
> +	dsi_disable_video_output(dssdev, td->channel);
> +
>   	r = taal_dcs_write_0(td, MIPI_DCS_SET_DISPLAY_OFF);
>   	if (!r)
>   		r = taal_sleep_in(td);
> diff --git a/drivers/video/omap2/dss/apply.c b/drivers/video/omap2/dss/apply.c
> index 9ad2a36..66f4c56 100644
> --- a/drivers/video/omap2/dss/apply.c
> +++ b/drivers/video/omap2/dss/apply.c
> @@ -648,7 +648,8 @@ void dss_mgr_enable(struct omap_overlay_manager *mgr)
>   {
>   	mutex_lock(&apply_lock);
>
> -	dispc_mgr_enable(mgr->id, true);
> +	if (!mgr_manual_update(mgr))
> +		dispc_mgr_enable(mgr->id, true);
>   	mgr->enabled = true;
>
>   	mutex_unlock(&apply_lock);
> @@ -658,7 +659,8 @@ void dss_mgr_disable(struct omap_overlay_manager *mgr)
>   {
>   	mutex_lock(&apply_lock);
>
> -	dispc_mgr_enable(mgr->id, false);
> +	if (!mgr_manual_update(mgr))
> +		dispc_mgr_enable(mgr->id, false);
>   	mgr->enabled = false;
>
>   	mutex_unlock(&apply_lock);
> diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
> index 08d3de90..a35f3fb 100644
> --- a/drivers/video/omap2/dss/dsi.c
> +++ b/drivers/video/omap2/dss/dsi.c
> @@ -3939,65 +3939,70 @@ static void dsi_proto_timings(struct omap_dss_device *dssdev)
>   	}
>   }
>
> -int dsi_video_mode_enable(struct omap_dss_device *dssdev, int channel)
> +int dsi_enable_video_output(struct omap_dss_device *dssdev, int channel)
>   {
>   	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
>   	int bpp = dsi_get_pixel_size(dssdev->panel.dsi_pix_fmt);
>   	u8 data_type;
>   	u16 word_count;
>
> -	switch (dssdev->panel.dsi_pix_fmt) {
> -	case OMAP_DSS_DSI_FMT_RGB888:
> -		data_type = MIPI_DSI_PACKED_PIXEL_STREAM_24;
> -		break;
> -	case OMAP_DSS_DSI_FMT_RGB666:
> -		data_type = MIPI_DSI_PIXEL_STREAM_3BYTE_18;
> -		break;
> -	case OMAP_DSS_DSI_FMT_RGB666_PACKED:
> -		data_type = MIPI_DSI_PACKED_PIXEL_STREAM_18;
> -		break;
> -	case OMAP_DSS_DSI_FMT_RGB565:
> -		data_type = MIPI_DSI_PACKED_PIXEL_STREAM_16;
> -		break;
> -	default:
> -		BUG();
> -	};
> +	if (dssdev->panel.dsi_mode == OMAP_DSS_DSI_VIDEO_MODE) {
> +		switch (dssdev->panel.dsi_pix_fmt) {
> +		case OMAP_DSS_DSI_FMT_RGB888:
> +			data_type = MIPI_DSI_PACKED_PIXEL_STREAM_24;
> +			break;
> +		case OMAP_DSS_DSI_FMT_RGB666:
> +			data_type = MIPI_DSI_PIXEL_STREAM_3BYTE_18;
> +			break;
> +		case OMAP_DSS_DSI_FMT_RGB666_PACKED:
> +			data_type = MIPI_DSI_PACKED_PIXEL_STREAM_18;
> +			break;
> +		case OMAP_DSS_DSI_FMT_RGB565:
> +			data_type = MIPI_DSI_PACKED_PIXEL_STREAM_16;
> +			break;
> +		default:
> +			BUG();
> +		};
>
> -	dsi_if_enable(dsidev, false);
> -	dsi_vc_enable(dsidev, channel, false);
> +		dsi_if_enable(dsidev, false);
> +		dsi_vc_enable(dsidev, channel, false);
>
> -	/* MODE, 1 = video mode */
> -	REG_FLD_MOD(dsidev, DSI_VC_CTRL(channel), 1, 4, 4);
> +		/* MODE, 1 = video mode */
> +		REG_FLD_MOD(dsidev, DSI_VC_CTRL(channel), 1, 4, 4);
>
> -	word_count = DIV_ROUND_UP(dssdev->panel.timings.x_res * bpp, 8);
> +		word_count = DIV_ROUND_UP(dssdev->panel.timings.x_res * bpp, 8);
>
> -	dsi_vc_write_long_header(dsidev, channel, data_type, word_count, 0);
> +		dsi_vc_write_long_header(dsidev, channel, data_type,
> +				word_count, 0);
>
> -	dsi_vc_enable(dsidev, channel, true);
> -	dsi_if_enable(dsidev, true);
> +		dsi_vc_enable(dsidev, channel, true);
> +		dsi_if_enable(dsidev, true);
> +	}
>
>   	dss_mgr_enable(dssdev->manager);
>
>   	return 0;
>   }
> -EXPORT_SYMBOL(dsi_video_mode_enable);
> +EXPORT_SYMBOL(dsi_enable_video_output);
>
> -void dsi_video_mode_disable(struct omap_dss_device *dssdev, int channel)
> +void dsi_disable_video_output(struct omap_dss_device *dssdev, int channel)
>   {
>   	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
>
> -	dsi_if_enable(dsidev, false);
> -	dsi_vc_enable(dsidev, channel, false);
> +	if (dssdev->panel.dsi_mode == OMAP_DSS_DSI_VIDEO_MODE) {
> +		dsi_if_enable(dsidev, false);
> +		dsi_vc_enable(dsidev, channel, false);
>
> -	/* MODE, 0 = command mode */
> -	REG_FLD_MOD(dsidev, DSI_VC_CTRL(channel), 0, 4, 4);
> +		/* MODE, 0 = command mode */
> +		REG_FLD_MOD(dsidev, DSI_VC_CTRL(channel), 0, 4, 4);
>
> -	dsi_vc_enable(dsidev, channel, true);
> -	dsi_if_enable(dsidev, true);
> +		dsi_vc_enable(dsidev, channel, true);
> +		dsi_if_enable(dsidev, true);
> +	}
>
>   	dss_mgr_disable(dssdev->manager);
>   }
> -EXPORT_SYMBOL(dsi_video_mode_disable);
> +EXPORT_SYMBOL(dsi_disable_video_output);
>
>   static void dsi_update_screen_dispc(struct omap_dss_device *dssdev,
>   		u16 w, u16 h)
> diff --git a/include/video/omapdss.h b/include/video/omapdss.h
> index eaeca89..25ef771 100644
> --- a/include/video/omapdss.h
> +++ b/include/video/omapdss.h
> @@ -294,8 +294,8 @@ int dsi_vc_set_max_rx_packet_size(struct omap_dss_device *dssdev, int channel,
>   		u16 len);
>   int dsi_vc_send_null(struct omap_dss_device *dssdev, int channel);
>   int dsi_vc_send_bta_sync(struct omap_dss_device *dssdev, int channel);
> -int dsi_video_mode_enable(struct omap_dss_device *dssdev, int channel);
> -void dsi_video_mode_disable(struct omap_dss_device *dssdev, int channel);
> +int dsi_enable_video_output(struct omap_dss_device *dssdev, int channel);
> +void dsi_disable_video_output(struct omap_dss_device *dssdev, int channel);
>
>   /* Board specific data */
>   struct omap_dss_board_info {


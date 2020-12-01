Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32AD9C63777
	for <linux-omap@archiver.kernel.org>; Tue,  1 Dec 2020 00:38:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE5D920809
	for <linux-omap@archiver.kernel.org>; Tue,  1 Dec 2020 00:38:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="aQnzZlgl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729578AbgLAAib (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Mon, 30 Nov 2020 19:38:31 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:35784 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729520AbgLAAib (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Mon, 30 Nov 2020 19:38:31 -0500
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 8B77C31D;
        Tue,  1 Dec 2020 01:37:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1606783068;
        bh=CxS1rXgYRcznMBhyfsvneilD1fqeJVpv/kCAxBga584=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aQnzZlglJuudhgysr/kKtUjibUKYydANwSmP5ohXBu2Zg4fz6mkA9tVWDlAsxp+lR
         sy/pjGMgJZDEy5slrstHDvbJHdpGGRAv4R1IykkyH7T9CN/5vvUJY8ZDNasQ/zjloR
         09QjSTW+gkhxOt3VNBd9m5CGE9jEMJOD12KVaqKE=
Date:   Tue, 1 Dec 2020 02:37:40 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Nikhil Devshatwar <nikhil.nd@ti.com>,
        linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Sekhar Nori <nsekhar@ti.com>, Tony Lindgren <tony@atomide.com>,
        hns@goldelico.com
Subject: Re: [PATCH v4 77/80] drm/omap: dsi: split video mode enable/disable
 into separate func
Message-ID: <20201201003740.GA4315@pendragon.ideasonboard.com>
References: <20201124124538.660710-1-tomi.valkeinen@ti.com>
 <20201124124538.660710-78-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201124124538.660710-78-tomi.valkeinen@ti.com>
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

Hi Tomi,

Thank you for the patch.

On Tue, Nov 24, 2020 at 02:45:35PM +0200, Tomi Valkeinen wrote:
> Clean up the code by separating video-mode enable/disable code into
> functions of their own.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/gpu/drm/omapdrm/dss/dsi.c | 101 +++++++++++++++++-------------
>  1 file changed, 57 insertions(+), 44 deletions(-)
> 
> diff --git a/drivers/gpu/drm/omapdrm/dss/dsi.c b/drivers/gpu/drm/omapdrm/dss/dsi.c
> index 27d0d119668b..6d20245495ac 100644
> --- a/drivers/gpu/drm/omapdrm/dss/dsi.c
> +++ b/drivers/gpu/drm/omapdrm/dss/dsi.c
> @@ -3207,12 +3207,61 @@ static int dsi_configure_pins(struct dsi_data *dsi,
>  	return 0;
>  }
>  
> -static void dsi_enable_video_output(struct omap_dss_device *dssdev, int vc)
> +static int dsi_enable_video_mode(struct dsi_data *dsi, int vc)
>  {
> -	struct dsi_data *dsi = to_dsi_data(dssdev);
>  	int bpp = mipi_dsi_pixel_format_to_bpp(dsi->pix_fmt);
>  	u8 data_type;
>  	u16 word_count;
> +
> +	switch (dsi->pix_fmt) {
> +	case MIPI_DSI_FMT_RGB888:
> +		data_type = MIPI_DSI_PACKED_PIXEL_STREAM_24;
> +		break;
> +	case MIPI_DSI_FMT_RGB666:
> +		data_type = MIPI_DSI_PIXEL_STREAM_3BYTE_18;
> +		break;
> +	case MIPI_DSI_FMT_RGB666_PACKED:
> +		data_type = MIPI_DSI_PACKED_PIXEL_STREAM_18;
> +		break;
> +	case MIPI_DSI_FMT_RGB565:
> +		data_type = MIPI_DSI_PACKED_PIXEL_STREAM_16;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	dsi_if_enable(dsi, false);
> +	dsi_vc_enable(dsi, vc, false);
> +
> +	/* MODE, 1 = video mode */
> +	REG_FLD_MOD(dsi, DSI_VC_CTRL(vc), 1, 4, 4);
> +
> +	word_count = DIV_ROUND_UP(dsi->vm.hactive * bpp, 8);
> +
> +	dsi_vc_write_long_header(dsi, vc, dsi->dsidev->channel, data_type,
> +			word_count, 0);
> +
> +	dsi_vc_enable(dsi, vc, true);
> +	dsi_if_enable(dsi, true);
> +
> +	return 0;
> +}
> +
> +static void dsi_disable_video_mode(struct dsi_data *dsi, int vc)
> +{
> +	dsi_if_enable(dsi, false);
> +	dsi_vc_enable(dsi, vc, false);
> +
> +	/* MODE, 0 = command mode */
> +	REG_FLD_MOD(dsi, DSI_VC_CTRL(vc), 0, 4, 4);
> +
> +	dsi_vc_enable(dsi, vc, true);
> +	dsi_if_enable(dsi, true);
> +}
> +
> +static void dsi_enable_video_output(struct omap_dss_device *dssdev, int vc)
> +{
> +	struct dsi_data *dsi = to_dsi_data(dssdev);
>  	int r;
>  
>  	r = dsi_init_dispc(dsi);
> @@ -3222,37 +3271,9 @@ static void dsi_enable_video_output(struct omap_dss_device *dssdev, int vc)
>  	}
>  
>  	if (dsi->mode == OMAP_DSS_DSI_VIDEO_MODE) {
> -		switch (dsi->pix_fmt) {
> -		case MIPI_DSI_FMT_RGB888:
> -			data_type = MIPI_DSI_PACKED_PIXEL_STREAM_24;
> -			break;
> -		case MIPI_DSI_FMT_RGB666:
> -			data_type = MIPI_DSI_PIXEL_STREAM_3BYTE_18;
> -			break;
> -		case MIPI_DSI_FMT_RGB666_PACKED:
> -			data_type = MIPI_DSI_PACKED_PIXEL_STREAM_18;
> -			break;
> -		case MIPI_DSI_FMT_RGB565:
> -			data_type = MIPI_DSI_PACKED_PIXEL_STREAM_16;
> -			break;
> -		default:
> -			r = -EINVAL;
> -			goto err_pix_fmt;
> -		}
> -
> -		dsi_if_enable(dsi, false);
> -		dsi_vc_enable(dsi, vc, false);
> -
> -		/* MODE, 1 = video mode */
> -		REG_FLD_MOD(dsi, DSI_VC_CTRL(vc), 1, 4, 4);
> -
> -		word_count = DIV_ROUND_UP(dsi->vm.hactive * bpp, 8);
> -
> -		dsi_vc_write_long_header(dsi, vc, dsi->dsidev->channel, data_type,
> -				word_count, 0);
> -
> -		dsi_vc_enable(dsi, vc, true);
> -		dsi_if_enable(dsi, true);
> +		r = dsi_enable_video_mode(dsi, vc);
> +		if (r)
> +			goto err_video_mode;
>  	}
>  
>  	r = dss_mgr_enable(&dsi->output);
> @@ -3266,7 +3287,7 @@ static void dsi_enable_video_output(struct omap_dss_device *dssdev, int vc)
>  		dsi_if_enable(dsi, false);
>  		dsi_vc_enable(dsi, vc, false);
>  	}
> -err_pix_fmt:
> +err_video_mode:
>  	dsi_uninit_dispc(dsi);
>  	dev_err(dsi->dev, "failed to enable DSI encoder!\n");
>  	return;
> @@ -3276,16 +3297,8 @@ static void dsi_disable_video_output(struct omap_dss_device *dssdev, int vc)
>  {
>  	struct dsi_data *dsi = to_dsi_data(dssdev);
>  
> -	if (dsi->mode == OMAP_DSS_DSI_VIDEO_MODE) {
> -		dsi_if_enable(dsi, false);
> -		dsi_vc_enable(dsi, vc, false);
> -
> -		/* MODE, 0 = command mode */
> -		REG_FLD_MOD(dsi, DSI_VC_CTRL(vc), 0, 4, 4);
> -
> -		dsi_vc_enable(dsi, vc, true);
> -		dsi_if_enable(dsi, true);
> -	}
> +	if (dsi->mode == OMAP_DSS_DSI_VIDEO_MODE)
> +		dsi_disable_video_mode(dsi, vc);
>  
>  	dss_mgr_disable(&dsi->output);
>  

-- 
Regards,

Laurent Pinchart

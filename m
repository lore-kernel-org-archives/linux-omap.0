From: Markus Pargmann <mpa@pengutronix.de>
Subject: Re: [PATCH] drm/tilcdc: Defer probe if no encoders/connectors found
Date: Sun, 16 Feb 2014 23:10:01 +0100
Message-ID: <20140216221001.GD31006@pengutronix.de>
References: <1387374961-11741-1-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:46215 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753067AbaBPWKF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 16 Feb 2014 17:10:05 -0500
Content-Disposition: inline
In-Reply-To: <1387374961-11741-1-git-send-email-mpa@pengutronix.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Airlie <airlied@linux.ie>
Cc: dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org, kernel@pengutronix.de

Hi,

On Wed, Dec 18, 2013 at 02:56:01PM +0100, Markus Pargmann wrote:
> At the moment this driver fails to load if no encoders/connectors were
> found. In case other drivers that register encoders/connectors
> (tilcdc_panel) are defered it would be better to check for
> encoders/connectors later again. This patch replaces the returncode
> -ENXIO with -EPROBE_DEFER to get a working setup even if tilcdc_panel
> probes after tilcdc.
> 

Ping. Anything I need to change?

Regards,

Markus

> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> ---
>  drivers/gpu/drm/tilcdc/tilcdc_drv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/tilcdc/tilcdc_drv.c b/drivers/gpu/drm/tilcdc/tilcdc_drv.c
> index 116da19..217303c 100644
> --- a/drivers/gpu/drm/tilcdc/tilcdc_drv.c
> +++ b/drivers/gpu/drm/tilcdc/tilcdc_drv.c
> @@ -84,7 +84,7 @@ static int modeset_init(struct drm_device *dev)
>  	if ((priv->num_encoders == 0) || (priv->num_connectors == 0)) {
>  		/* oh nos! */
>  		dev_err(dev->dev, "no encoders/connectors found\n");
> -		return -ENXIO;
> +		return -EPROBE_DEFER;
>  	}
>  
>  	dev->mode_config.min_width = 0;
> -- 
> 1.8.5.1
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

From: Rob Clark <robdclark@gmail.com>
Subject: Re: [PATCH] drm/tilcdc: Defer probe if no encoders/connectors found
Date: Wed, 18 Dec 2013 10:01:44 -0500
Message-ID: <CAF6AEGusvw09sLvBUe=L54qwsY8E6V0YUY+o4Ewmdkj3v_C8LQ@mail.gmail.com>
References: <1387374961-11741-1-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ie0-f170.google.com ([209.85.223.170]:49239 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754778Ab3LRPBp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Dec 2013 10:01:45 -0500
Received: by mail-ie0-f170.google.com with SMTP id qd12so10476163ieb.29
        for <linux-omap@vger.kernel.org>; Wed, 18 Dec 2013 07:01:44 -0800 (PST)
In-Reply-To: <1387374961-11741-1-git-send-email-mpa@pengutronix.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Markus Pargmann <mpa@pengutronix.de>
Cc: David Airlie <airlied@linux.ie>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, linux-omap <linux-omap@vger.kernel.org>, "kernel@pengutronix.de" <kernel@pengutronix.de>

On Wed, Dec 18, 2013 at 8:56 AM, Markus Pargmann <mpa@pengutronix.de> wrote:
> At the moment this driver fails to load if no encoders/connectors were
> found. In case other drivers that register encoders/connectors
> (tilcdc_panel) are defered it would be better to check for
> encoders/connectors later again. This patch replaces the returncode
> -ENXIO with -EPROBE_DEFER to get a working setup even if tilcdc_panel
> probes after tilcdc.

yeah, that is probably better than relying on late_initcall() hacks..

Signed-off-by: Rob Clark <robdclark@gmail.com>

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
>         if ((priv->num_encoders == 0) || (priv->num_connectors == 0)) {
>                 /* oh nos! */
>                 dev_err(dev->dev, "no encoders/connectors found\n");
> -               return -ENXIO;
> +               return -EPROBE_DEFER;
>         }
>
>         dev->mode_config.min_width = 0;
> --
> 1.8.5.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

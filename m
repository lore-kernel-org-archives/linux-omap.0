From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] omapfb: remove wrong scale call for gfx_plane
Date: Wed, 10 Sep 2008 10:53:00 -0700
Message-ID: <20080910175259.GD21163@atomide.com>
References: <c656a4d20809090043g27d7a73eqf345588b4575c68d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:64660 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751377AbYIJRxE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Sep 2008 13:53:04 -0400
Content-Disposition: inline
In-Reply-To: <c656a4d20809090043g27d7a73eqf345588b4575c68d@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: arun c <arunedarath@mistralsolutions.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* arun c <arunedarath@mistralsolutions.com> [080909 00:47]:
> The gfx_plane doesn't support scaling.

Pushing today.

Tony

> 
> Signed-off-by: Arun C <arunedarath@mistralsolutions.com>
> ---
>  drivers/video/omap/dispc.c       |    3 +--
>  drivers/video/omap/omapfb_main.c |    6 ++++--
>  2 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/video/omap/dispc.c b/drivers/video/omap/dispc.c
> index 82ba030..ce4c4de 100644
> --- a/drivers/video/omap/dispc.c
> +++ b/drivers/video/omap/dispc.c
> @@ -519,8 +519,7 @@ static int omap_dispc_set_scale(int plane,
>  	if ((unsigned)plane > OMAPFB_PLANE_NUM)
>  		return -ENODEV;
> 
> -	if (plane == OMAPFB_PLANE_GFX &&
> -	    (out_width != orig_width || out_height != orig_height))
> +	if (out_width != orig_width || out_height != orig_height)
>  		return -EINVAL;
> 
>  	enable_lcd_clocks(1);
> diff --git a/drivers/video/omap/omapfb_main.c b/drivers/video/omap/omapfb_main.c
> index 1ffe74c..d176a2c 100644
> --- a/drivers/video/omap/omapfb_main.c
> +++ b/drivers/video/omap/omapfb_main.c
> @@ -223,13 +223,15 @@ static int ctrl_change_mode(struct fb_info *fbi)
>  		if((r = fbdev->ctrl->set_rotate(var->rotate)) < 0)
>  			return r;
> 
> -	if (fbdev->ctrl->set_scale != NULL)
> +	if ((fbdev->ctrl->set_scale != NULL) && (plane->idx > 0))
>  		r = fbdev->ctrl->set_scale(plane->idx,
>  				   var->xres, var->yres,
>  				   plane->info.out_width,
>  				   plane->info.out_height);
> +	if (r < 0)
> +		return r;
> 
> -	return r;
> +	return 0;
>  }
> 
>  /*
> -- 
> 1.5.3.4
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

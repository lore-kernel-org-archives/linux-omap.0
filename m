From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] This patch removes a dead line from omapfb_main.c
Date: Mon, 31 Mar 2008 13:45:12 +0300
Message-ID: <20080331104511.GJ26502@atomide.com>
References: <c656a4d20803302352q672816b7pdba535cf6b2d4143@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-bos.mailhop.org ([63.208.196.179]:57790 "EHLO
	mho-02-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751543AbYCaKpP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 31 Mar 2008 06:45:15 -0400
Content-Disposition: inline
In-Reply-To: <c656a4d20803302352q672816b7pdba535cf6b2d4143@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: arun c <arunedarath@mistralsolutions.com>
Cc: linux-omap@vger.kernel.org

* arun c <arunedarath@mistralsolutions.com> [080331 09:53]:
> This patch removes a dead line from omapfb_main.c

Pushing today.

Tony

> 
> Signed-off-by: arun c <arunedarath@mistralsolutions.com>
> ---
>  drivers/video/omap/omapfb_main.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/video/omap/omapfb_main.c b/drivers/video/omap/omapfb_main.c
> index 139c84c..418ed9f 100644
> --- a/drivers/video/omap/omapfb_main.c
> +++ b/drivers/video/omap/omapfb_main.c
> @@ -559,7 +559,6 @@ static int set_fb_var(struct fb_info *fbi,
>  		var->xoffset = var->xres_virtual - var->xres;
>  	if (var->yres + var->yoffset > var->yres_virtual)
>  		var->yoffset = var->yres_virtual - var->yres;
> -	line_size = var->xres * bpp / 8;
> 
>  	if (plane->color_mode == OMAPFB_COLOR_RGB444) {
>  		var->red.offset	  = 8; var->red.length	 = 4;
> -- 
> 1.5.0.6
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

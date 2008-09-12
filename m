From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] omapfb: use proper bits per pixel for beagleboard.
Date: Fri, 12 Sep 2008 16:52:55 -0700
Message-ID: <20080912235253.GK10675@atomide.com>
References: <c656a4d20809120913i2cf6b2d0i33289ac8b45f76e9@mail.gmail.com> <1221258481-18531-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:54282 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755493AbYILXw4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Sep 2008 19:52:56 -0400
Content-Disposition: inline
In-Reply-To: <1221258481-18531-1-git-send-email-felipe.contreras@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: linux-omap@vger.kernel.org

* Felipe Contreras <felipe.contreras@gmail.com> [080912 15:28]:
> This was suggested by Mans Rullgard, otherwise it doesn't work.

Pushing today.

Tony

> 
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  drivers/video/omap/lcd_omap3beagle.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/video/omap/lcd_omap3beagle.c b/drivers/video/omap/lcd_omap3beagle.c
> index 9637735..dc59f39 100644
> --- a/drivers/video/omap/lcd_omap3beagle.c
> +++ b/drivers/video/omap/lcd_omap3beagle.c
> @@ -66,7 +66,7 @@ struct lcd_panel omap3beagle_panel = {
>  	.name		= "omap3beagle",
>  	.config		= OMAP_LCDC_PANEL_TFT,
>  
> -	.bpp		= 24,
> +	.bpp		= 16,
>  	.data_lines	= 24,
>  	.x_res		= LCD_XRES,
>  	.y_res		= LCD_YRES,
> -- 
> 1.6.0.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

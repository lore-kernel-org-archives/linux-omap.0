From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/1] OMAP3 EVM: Fix pixel_clock picoseconds/kHz error
Date: Wed, 14 May 2008 16:05:29 -0700
Message-ID: <20080514230528.GG8928@atomide.com>
References: <5e088bd90805122103r7a4303b4r45ac312cfb8353f7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-bos.mailhop.org ([63.208.196.179]:60470 "EHLO
	mho-02-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752936AbYENXFa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 May 2008 19:05:30 -0400
Content-Disposition: inline
In-Reply-To: <5e088bd90805122103r7a4303b4r45ac312cfb8353f7@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Steve Sakoman <sakoman@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Steve Sakoman <sakoman@gmail.com> [080512 21:04]:
> From: Steve Sakoman <steve@sakoman.com>
> 
> Fix pixel_clock picoseconds/kHz error in LCD config, eliminate unused #define

Pushing today.

Tony

> Signed-off-by: Steve Sakoman <steve@sakoman.com>
> 
> ---
>  drivers/video/omap/lcd_omap3evm.c |    5 ++---
>  1 files changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/video/omap/lcd_omap3evm.c
> b/drivers/video/omap/lcd_omap3evm.c
> index 04e40b6..4e0a64c 100644
> --- a/drivers/video/omap/lcd_omap3evm.c
> +++ b/drivers/video/omap/lcd_omap3evm.c
> @@ -38,8 +38,7 @@
> 
>  #define LCD_XRES	 	480
>  #define LCD_YRES 		640
> -#define LCD_PIXCLOCK_MAX	41700 /* in pico seconds  */
> -#define LCD_PIXCLOCK_MIN	38000 /* in pico seconds */
> +#define LCD_PIXCLOCK		26000 /* in kHz  */
> 
>  #define ENABLE_VDAC_DEDICATED	0x03
>  #define ENABLE_VDAC_DEV_GRP	0x20
> @@ -111,7 +110,7 @@ struct lcd_panel omap3evm_panel = {
>  	.vfp		= 2,		/* lower_margin */
>  	.vbp		= 7,		/* upper_margin (8) - 1 */
> 
> -	.pixel_clock	= LCD_PIXCLOCK_MAX,
> +	.pixel_clock	= LCD_PIXCLOCK,
> 
>  	.init		= omap3evm_panel_init,
>  	.cleanup	= omap3evm_panel_cleanup,
> -- 
> 1.5.4.5
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] N900: enable N900-specific drivers even if device tree
 is enabled
Date: Thu, 4 Jul 2013 04:47:56 -0700
Message-ID: <20130704114755.GE5523@atomide.com>
References: <20130613141001.GF8164@atomide.com>
 <20130613142809.GA3775@amd.pavel.ucw.cz>
 <20130613145724.GH8164@atomide.com>
 <20130613155240.GB3775@amd.pavel.ucw.cz>
 <20130613161418.GJ8164@atomide.com>
 <20130613230808.GA14876@amd.pavel.ucw.cz>
 <20130614055629.GM8164@atomide.com>
 <20130614212816.GA31768@atrey.karlin.mff.cuni.cz>
 <20130617111031.GQ20992@atomide.com>
 <20130701211504.GB15318@amd.pavel.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130701211504.GB15318@amd.pavel.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, pali.rohar@gmail.com, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Pavel Machek <pavel@ucw.cz> [130701 14:21]:
> 
> We still need video & sound drivers with device tree enabled.
> 
> Signed-off-by: Pavel Machek <pavel@ucw.cz>

Thanks, applying this into omap-for-v3.11/fixes. Benoit should
queue the .dts related changes.

Tony

> 
> ---
> 
> Patch against 3.10.
> 
> --- linux-delme-clean//arch/arm/mach-omap2/board-rx51-video.c	2013-07-01 21:51:07.000000000 +0200
> +++ linux-delme/arch/arm/mach-omap2/board-rx51-video.c	2013-07-01 22:50:27.000000000 +0200
> @@ -61,7 +61,7 @@
>  
>  static int __init rx51_video_init(void)
>  {
> -	if (!machine_is_nokia_rx51())
> +	if (!machine_is_nokia_rx51() && !of_machine_is_compatible("nokia,omap3-n900"))
>  		return 0;
>  
>  	if (omap_mux_init_gpio(RX51_LCD_RESET_GPIO, OMAP_PIN_OUTPUT)) {
> diff -urN linux-delme-clean//sound/soc/omap/rx51.c linux-delme/sound/soc/omap/rx51.c
> --- linux-delme-clean//sound/soc/omap/rx51.c	2013-07-01 21:54:49.000000000 +0200
> +++ linux-delme/sound/soc/omap/rx51.c	2013-07-01 22:50:27.000000000 +0200
> @@ -396,7 +396,7 @@
>  {
>  	int err;
>  
> -	if (!machine_is_nokia_rx51())
> +	if (!machine_is_nokia_rx51() && !of_machine_is_compatible("nokia,omap3-n900"))
>  		return -ENODEV;
>  
>  	err = gpio_request_one(RX51_TVOUT_SEL_GPIO,
> 
> -- 
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

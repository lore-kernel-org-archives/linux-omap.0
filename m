From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/1] omap: fix section mismatch errors
Date: Thu, 23 Sep 2010 09:36:44 -0700
Message-ID: <20100923163644.GK4211@atomide.com>
References: <1281972677-1636-1-git-send-email-premi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:60934 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754360Ab0IWQgq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 23 Sep 2010 12:36:46 -0400
Content-Disposition: inline
In-Reply-To: <1281972677-1636-1-git-send-email-premi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sanjeev Premi <premi@ti.com>
Cc: linux-omap@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@nokia.com>

* Sanjeev Premi <premi@ti.com> [100816 08:24]:
> This patch fixes miltiple section mismatch errors
> observed with the latest master.

Few comments below.
 
> @@ -134,7 +134,7 @@ static inline void board_smc91x_init(void)
>  
>  #endif
>  
> -static struct omap_board_config_kernel sdp2430_config[] = {
> +static struct omap_board_config_kernel sdp2430_config[] __initdata = {
>  	{OMAP_TAG_LCD, &sdp2430_lcd_config},
>  };
...
  
Let's just get rid of omap_get_config stuff. The OMAP_TAG_LCD
and OMAP_TAG_FBMEM are the last remaining legacy tags. They should
be replaced with just platform_data. And while at it, it should
be done for all the boards.

Tomi, do you see any problems with that?

> --- a/arch/arm/mach-omap2/board-zoom-peripherals.c
> +++ b/arch/arm/mach-omap2/board-zoom-peripherals.c
> @@ -171,7 +171,7 @@ static struct omap2_hsmmc_info mmc[] __initdata = {
>  	{}      /* Terminator */
>  };
>  
> -static int zoom_twl_gpio_setup(struct device *dev,
> +static int __init zoom_twl_gpio_setup(struct device *dev,
>  		unsigned gpio, unsigned ngpio)
>  {
>  	/* gpio + 0 is "mmc0_cd" (input/IRQ) */

This should be safe to do for all the board, pdata->setup is only
called during the probe.

> @@ -209,27 +209,27 @@ static struct twl4030_usb_data zoom_usb_data = {
>  	.usb_mode	= T2_USB_MODE_ULPI,
>  };
>  
> -static struct twl4030_gpio_platform_data zoom_gpio_data = {
> +static struct twl4030_gpio_platform_data zoom_gpio_data __initdata = {
>  	.gpio_base	= OMAP_MAX_GPIO_LINES,
>  	.irq_base	= TWL4030_GPIO_IRQ_BASE,
>  	.irq_end	= TWL4030_GPIO_IRQ_END,
>  	.setup		= zoom_twl_gpio_setup,
>  };

But this is not safe to do as twl4030-gpio.c uses pdata in
gpio_twl4030_remove.

It's best to split the initdata changes so you make one change for
all the boards per patch, that way it's possible to check if it's
OK to do that change from the driver point of view.

Regards,

Tony

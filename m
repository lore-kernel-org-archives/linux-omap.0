From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/1] This patch adds backlight control for omap3evm
Date: Thu, 3 Jul 2008 13:28:27 +0300
Message-ID: <20080703102824.GL14276@atomide.com>
References: <c656a4d20807010522u2742a089qad5ec3316d0db15a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:63401 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751815AbYGCM1p (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Jul 2008 08:27:45 -0400
Content-Disposition: inline
In-Reply-To: <c656a4d20807010522u2742a089qad5ec3316d0db15a@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: arun c <arunedarath@mistralsolutions.com>
Cc: linux-omap@vger.kernel.org

* arun c <arunedarath@mistralsolutions.com> [080701 15:25]:
> TWL4030 LEDdriver A(LEDA) is used here to control the LCD backlight

Pushing today.

Tony

> Signed-off-by: Arun C <arunedarath@mistralsolutions.com>
> ---
>  drivers/video/omap/lcd_omap3evm.c |   39 +++++++++++++++++++++++++++++++++---
>  1 files changed, 35 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/video/omap/lcd_omap3evm.c
> b/drivers/video/omap/lcd_omap3evm.c
> index 5d2ed04..f5a1477 100644
> --- a/drivers/video/omap/lcd_omap3evm.c
> +++ b/drivers/video/omap/lcd_omap3evm.c
> @@ -45,6 +45,12 @@
>  #define ENABLE_VPLL2_DEDICATED	0x05
>  #define ENABLE_VPLL2_DEV_GRP	0xE0
> 
> +#define TWL_LED_LEDEN		0x00
> +#define TWL_PWMA_PWMAON		0x00
> +#define TWL_PWMA_PWMAOFF	0x01
> +
> +static unsigned int bklight_level;
> +
>  static int omap3evm_panel_init(struct lcd_panel *panel,
>  				struct omapfb_device *fbdev)
>  {
> @@ -60,10 +66,10 @@ static int omap3evm_panel_init(struct lcd_panel *panel,
>  	omap_set_gpio_direction(LCD_PANEL_RESB, 0);
>  	omap_set_gpio_direction(LCD_PANEL_QVGA, 0);
> 
> -	twl4030_i2c_write_u8(TWL4030_MODULE_PWMA, 0x7F, 0);
> -	twl4030_i2c_write_u8(TWL4030_MODULE_PWMA, 0x7F, 1);
> -	twl4030_i2c_write_u8(TWL4030_MODULE_PWMB, 0x7F, 0);
> -	twl4030_i2c_write_u8(TWL4030_MODULE_PWMB, 0x7F, 1);
> +	twl4030_i2c_write_u8(TWL4030_MODULE_LED, 0x11, TWL_LED_LEDEN);
> +	twl4030_i2c_write_u8(TWL4030_MODULE_PWMA, 0x01, TWL_PWMA_PWMAON);
> +	twl4030_i2c_write_u8(TWL4030_MODULE_PWMA, 0x02, TWL_PWMA_PWMAOFF);
> +	bklight_level = 100;
> 
>  	omap_set_gpio_dataout(LCD_PANEL_RESB, 1);
>  	omap_set_gpio_dataout(LCD_PANEL_INI, 1);
> @@ -94,6 +100,28 @@ static unsigned long
> omap3evm_panel_get_caps(struct lcd_panel *panel)
>  	return 0;
>  }
> 
> +static int omap3evm_bklight_setlevel(struct lcd_panel *panel,
> +						unsigned int level)
> +{
> +	u8 c;
> +	if ((level >= 0) && (level <= 100)) {
> +		c = (125 * (100 - level)) / 100 + 2;
> +		twl4030_i2c_write_u8(TWL4030_MODULE_PWMA, c, TWL_PWMA_PWMAOFF);
> +		bklight_level = level;
> +	}
> +	return 0;
> +}
> +
> +static unsigned int omap3evm_bklight_getlevel(struct lcd_panel *panel)
> +{
> +	return bklight_level;
> +}
> +
> +static unsigned int omap3evm_bklight_getmaxlevel(struct lcd_panel *panel)
> +{
> +	return 100;
> +}
> +
>  struct lcd_panel omap3evm_panel = {
>  	.name		= "omap3evm",
>  	.config		= OMAP_LCDC_PANEL_TFT | OMAP_LCDC_INV_VSYNC |
> @@ -117,6 +145,9 @@ struct lcd_panel omap3evm_panel = {
>  	.enable		= omap3evm_panel_enable,
>  	.disable	= omap3evm_panel_disable,
>  	.get_caps	= omap3evm_panel_get_caps,
> +	.set_bklight_level      = omap3evm_bklight_setlevel,
> +	.get_bklight_level      = omap3evm_bklight_getlevel,
> +	.get_bklight_max        = omap3evm_bklight_getmaxlevel,
>  };
> 
>  static int omap3evm_panel_probe(struct platform_device *pdev)
> -- 
> 1.5.5.3

> From 92a1094c65e90ae0f0fe5b970f733d584d2f7201 Mon Sep 17 00:00:00 2001
> From: Arun C <arunedarath@mistralsolutions.com>
> Date: Tue, 1 Jul 2008 16:54:55 +0530
> Subject: [PATCH] This patch adds backlight control for omap3evm
> 
> TWL4030 LEDdriver A(LEDA) is used here to control the LCD backlight
> 
> Signed-off-by: Arun C <arunedarath@mistralsolutions.com>
> ---
>  drivers/video/omap/lcd_omap3evm.c |   39 +++++++++++++++++++++++++++++++++---
>  1 files changed, 35 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/video/omap/lcd_omap3evm.c b/drivers/video/omap/lcd_omap3evm.c
> index 5d2ed04..f5a1477 100644
> --- a/drivers/video/omap/lcd_omap3evm.c
> +++ b/drivers/video/omap/lcd_omap3evm.c
> @@ -45,6 +45,12 @@
>  #define ENABLE_VPLL2_DEDICATED	0x05
>  #define ENABLE_VPLL2_DEV_GRP	0xE0
>  
> +#define TWL_LED_LEDEN		0x00
> +#define TWL_PWMA_PWMAON		0x00
> +#define TWL_PWMA_PWMAOFF	0x01
> +
> +static unsigned int bklight_level;
> +
>  static int omap3evm_panel_init(struct lcd_panel *panel,
>  				struct omapfb_device *fbdev)
>  {
> @@ -60,10 +66,10 @@ static int omap3evm_panel_init(struct lcd_panel *panel,
>  	omap_set_gpio_direction(LCD_PANEL_RESB, 0);
>  	omap_set_gpio_direction(LCD_PANEL_QVGA, 0);
>  
> -	twl4030_i2c_write_u8(TWL4030_MODULE_PWMA, 0x7F, 0);
> -	twl4030_i2c_write_u8(TWL4030_MODULE_PWMA, 0x7F, 1);
> -	twl4030_i2c_write_u8(TWL4030_MODULE_PWMB, 0x7F, 0);
> -	twl4030_i2c_write_u8(TWL4030_MODULE_PWMB, 0x7F, 1);
> +	twl4030_i2c_write_u8(TWL4030_MODULE_LED, 0x11, TWL_LED_LEDEN);
> +	twl4030_i2c_write_u8(TWL4030_MODULE_PWMA, 0x01, TWL_PWMA_PWMAON);
> +	twl4030_i2c_write_u8(TWL4030_MODULE_PWMA, 0x02, TWL_PWMA_PWMAOFF);
> +	bklight_level = 100;
>  
>  	omap_set_gpio_dataout(LCD_PANEL_RESB, 1);
>  	omap_set_gpio_dataout(LCD_PANEL_INI, 1);
> @@ -94,6 +100,28 @@ static unsigned long omap3evm_panel_get_caps(struct lcd_panel *panel)
>  	return 0;
>  }
>  
> +static int omap3evm_bklight_setlevel(struct lcd_panel *panel,
> +						unsigned int level)
> +{
> +	u8 c;
> +	if ((level >= 0) && (level <= 100)) {
> +		c = (125 * (100 - level)) / 100 + 2;
> +		twl4030_i2c_write_u8(TWL4030_MODULE_PWMA, c, TWL_PWMA_PWMAOFF);
> +		bklight_level = level;
> +	}
> +	return 0;
> +}
> +
> +static unsigned int omap3evm_bklight_getlevel(struct lcd_panel *panel)
> +{
> +	return bklight_level;
> +}
> +
> +static unsigned int omap3evm_bklight_getmaxlevel(struct lcd_panel *panel)
> +{
> +	return 100;
> +}
> +
>  struct lcd_panel omap3evm_panel = {
>  	.name		= "omap3evm",
>  	.config		= OMAP_LCDC_PANEL_TFT | OMAP_LCDC_INV_VSYNC |
> @@ -117,6 +145,9 @@ struct lcd_panel omap3evm_panel = {
>  	.enable		= omap3evm_panel_enable,
>  	.disable	= omap3evm_panel_disable,
>  	.get_caps	= omap3evm_panel_get_caps,
> +	.set_bklight_level      = omap3evm_bklight_setlevel,
> +	.get_bklight_level      = omap3evm_bklight_getlevel,
> +	.get_bklight_max        = omap3evm_bklight_getmaxlevel,
>  };
>  
>  static int omap3evm_panel_probe(struct platform_device *pdev)
> -- 
> 1.5.5.3
> 


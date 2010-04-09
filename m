From: Thomas Weber <weber@corscience.de>
Subject: Re: [PATCH 2/2] Setup LCD reset for Devkit8000
Date: Fri, 09 Apr 2010 13:13:32 +0000
Message-ID: <4BBF27FC.2020507@corscience.de>
References: <1270629267-27068-1-git-send-email-kanru@0xlab.org> <1270629267-27068-2-git-send-email-kanru@0xlab.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:54562 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750977Ab0DIMNt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Apr 2010 08:13:49 -0400
In-Reply-To: <1270629267-27068-2-git-send-email-kanru@0xlab.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kan-Ru Chen <kanru@0xlab.org>
Cc: linux-omap@vger.kernel.org, Thomas Weber <weber@corscience.de>, Tony Lindgren <tony@atomide.com>

Hello Kan-Ru,

On 04/07/10 08:34, Kan-Ru Chen wrote:
> This patch corrects the LCD reset pin config
> 
> Original code from early devkit8000 patch sets the TWL4030 GPIO_1
> to EHCI_nOC and TWL4030_GPIO_MAX+1 to ledA. Indeed these two pins
> are both LCD_PWREN. Setup the lcd reset_gpio properly so it can be
> disabled when other display is turned on.
> 
> Signed-off-by: Kan-Ru Chen <kanru@0xlab.org>
> ---
>  arch/arm/mach-omap2/board-devkit8000.c |   22 +++++++++++-----------
>  1 files changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-devkit8000.c b/arch/arm/mach-omap2/board-devkit8000.c
> index fd4454a..e38a669 100644
> --- a/arch/arm/mach-omap2/board-devkit8000.c
> +++ b/arch/arm/mach-omap2/board-devkit8000.c
> @@ -135,11 +135,15 @@ static int devkit8000_panel_enable_lcd(struct omap_dss_device *dssdev)
>  	twl_i2c_write_u8(TWL4030_MODULE_GPIO, 0x80, REG_GPIODATADIR1);
>  	twl_i2c_write_u8(TWL4030_MODULE_LED, 0x0, 0x0);
>  
> +	if (dssdev->reset_gpio != -EINVAL)
> +		gpio_set_value(dssdev->reset_gpio, 1);
>  	return 0;
>  }
>  
>  static void devkit8000_panel_disable_lcd(struct omap_dss_device *dssdev)
>  {
> +	if (dssdev->reset_gpio != -EINVAL)
> +		gpio_set_value(dssdev->reset_gpio, 0);
>  }
>  
>  static int devkit8000_panel_enable_dvi(struct omap_dss_device *dssdev)
> @@ -180,6 +184,7 @@ static struct omap_dss_device devkit8000_lcd_device = {
>  	.driver_name            = "innolux_at_panel",
>  	.type                   = OMAP_DISPLAY_TYPE_DPI,
>  	.phy.dpi.data_lines     = 24,
> +	.reset_gpio             = -EINVAL, /* will be replaced */
>  	.platform_enable        = devkit8000_panel_enable_lcd,
>  	.platform_disable       = devkit8000_panel_disable_lcd,
>  };
> @@ -275,20 +280,15 @@ static int devkit8000_twl_gpio_setup(struct device *dev,
>  	devkit8000_vmmc1_supply.dev = mmc[0].dev;
>  	devkit8000_vsim_supply.dev = mmc[0].dev;
>  
> -	/* REVISIT: need ehci-omap hooks for external VBUS
> -	 * power switch and overcurrent detect
> -	 */
> -
> -	gpio_request(gpio + 1, "EHCI_nOC");
> -	gpio_direction_input(gpio + 1);
> -
> -	/* TWL4030_GPIO_MAX + 0 == ledA, EHCI nEN_USB_PWR (out, active low) */
> -	gpio_request(gpio + TWL4030_GPIO_MAX, "nEN_USB_PWR");
> -	gpio_direction_output(gpio + TWL4030_GPIO_MAX, 1);
> -
This is already fixed in
http://marc.info/?l=linux-omap&m=126943519124317&w=2
>  	/* TWL4030_GPIO_MAX + 1 == ledB, PMU_STAT (out, active low LED) */
>  	gpio_leds[2].gpio = gpio + TWL4030_GPIO_MAX + 1;
>  
> +        /* gpio + 1 is "LCD_PWREN" (out, active high) */
> +	devkit8000_lcd_device.reset_gpio = gpio + 1;
> +	gpio_request(devkit8000_lcd_device.reset_gpio, "LCD_PWREN");
> +	/* Disable until needed */
> +	gpio_direction_output(devkit8000_lcd_device.reset_gpio, 0);
> +
>  	/* gpio + 7 is "DVI_PD" (out, active low) */
>  	devkit8000_dvi_device.reset_gpio = gpio + 7;
>  	gpio_request(devkit8000_dvi_device.reset_gpio, "DVI PowerDown");

Thomas

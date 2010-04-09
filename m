From: Thomas Weber <weber@corscience.de>
Subject: Re: [PATCH 1/2] Enable DVI-D output for Devkit8000
Date: Fri, 09 Apr 2010 13:07:07 +0000
Message-ID: <4BBF267B.7030606@corscience.de>
References: <1270629267-27068-1-git-send-email-kanru@0xlab.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:56258 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750977Ab0DIMHZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Apr 2010 08:07:25 -0400
In-Reply-To: <1270629267-27068-1-git-send-email-kanru@0xlab.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kan-Ru Chen <kanru@0xlab.org>
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

Hello Kan-Ru,

On 04/07/10 08:34, Kan-Ru Chen wrote:
> This patch corrects the DVI-D output setup of Devkit8000
> 
> Devkit8000 has different DVI reset pin with the BeagleBoard. On Devkit8000
> the TWL4030 GPIO_7 is assigned to do the job.
> 
> Signed-off-by: Kan-Ru Chen <kanru@0xlab.org>
> ---
>  arch/arm/mach-omap2/board-devkit8000.c |   20 +++++++++++++-------
>  1 files changed, 13 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-devkit8000.c b/arch/arm/mach-omap2/board-devkit8000.c
> index 5bfc13b..fd4454a 100644
> --- a/arch/arm/mach-omap2/board-devkit8000.c
> +++ b/arch/arm/mach-omap2/board-devkit8000.c
> @@ -141,13 +141,18 @@ static int devkit8000_panel_enable_lcd(struct omap_dss_device *dssdev)
>  static void devkit8000_panel_disable_lcd(struct omap_dss_device *dssdev)
>  {
>  }
> +
>  static int devkit8000_panel_enable_dvi(struct omap_dss_device *dssdev)
>  {
> +	if (dssdev->reset_gpio != -EINVAL)
> +		gpio_set_value(dssdev->reset_gpio, 1);
>  	return 0;
>  }
>  
>  static void devkit8000_panel_disable_dvi(struct omap_dss_device *dssdev)
>  {
> +	if (dssdev->reset_gpio != -EINVAL)
> +		gpio_set_value(dssdev->reset_gpio, 0);
>  }
>  
>  static int devkit8000_panel_enable_tv(struct omap_dss_device *dssdev)
> @@ -183,6 +188,7 @@ static struct omap_dss_device devkit8000_dvi_device = {
>  	.driver_name            = "generic_panel",
>  	.type                   = OMAP_DISPLAY_TYPE_DPI,
>  	.phy.dpi.data_lines     = 24,
> +	.reset_gpio             = -EINVAL, /* will be replaced */
>  	.platform_enable        = devkit8000_panel_enable_dvi,
>  	.platform_disable       = devkit8000_panel_disable_dvi,
>  };
> @@ -283,6 +289,12 @@ static int devkit8000_twl_gpio_setup(struct device *dev,
>  	/* TWL4030_GPIO_MAX + 1 == ledB, PMU_STAT (out, active low LED) */
>  	gpio_leds[2].gpio = gpio + TWL4030_GPIO_MAX + 1;
>  
> +	/* gpio + 7 is "DVI_PD" (out, active low) */
> +	devkit8000_dvi_device.reset_gpio = gpio + 7;
> +	gpio_request(devkit8000_dvi_device.reset_gpio, "DVI PowerDown");
> +	/* Disable until needed */
> +	gpio_direction_output(devkit8000_dvi_device.reset_gpio, 0);
> +
>  	return 0;
>  }
>  
> @@ -303,7 +315,7 @@ static struct regulator_consumer_supply devkit8000_vpll2_supplies[] = {
>  	.dev		= &devkit8000_lcd_device.dev,
>  	},
>  	{
> -	.supply		= "vdss_dsi",
> +	.supply		= "vdds_dsi",
>  	.dev		= &devkit8000_dss_device.dev,
>  	}
>  };
This is already fixed in patch
http://marc.info/?l=linux-omap&m=126943519824335&w=2

> @@ -665,12 +677,6 @@ static void __init devkit8000_init(void)
>  
>  	devkit8000_ads7846_init();
>  
> -	omap_mux_init_gpio(170, OMAP_PIN_INPUT);
> -
> -	gpio_request(170, "DVI_nPD");
> -	/* REVISIT leave DVI powered down until it's needed ... */
> -	gpio_direction_output(170, true);
> -
>  	usb_musb_init(&musb_board_data);
>  	usb_ehci_init(&ehci_pdata);
>  	devkit8000_flash_init();
This is already fixed in patch
http://marc.info/?l=linux-omap&m=126943519124317&w=2

Thomas

From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: [PATCH] board-omap3-beagle: add DSS2 support
Date: Mon, 12 Apr 2010 13:37:11 +0300
Message-ID: <1271068631.2690.40.camel@tubuntu.research.nokia.com>
References: <1271063990-12819-1-git-send-email-koen@dominion.thruhere.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:28014 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753312Ab0DLKhp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 Apr 2010 06:37:45 -0400
In-Reply-To: <1271063990-12819-1-git-send-email-koen@dominion.thruhere.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Koen Kooi <koen.kooi@gmail.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Koen Kooi <koen@dominion.thruhere.net>


On Mon, 2010-04-12 at 11:19 +0200, ext Koen Kooi wrote:
> This patch adds DSS2 support to the beagleboard boardfile. DVI and TV-out are supported.
> 
> Signed-off-by: Koen Kooi <koen@dominion.thruhere.net>

Fiddling with TWL directly in tv enable/disable functions is a bit ugly,
but I'm not sure if there's a better way for that. Otherwise:

Acked-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>

 Tomi

> ---
>  arch/arm/mach-omap2/board-omap3beagle.c |  130 ++++++++++++++++++++++++-------
>  1 files changed, 103 insertions(+), 27 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
> index 962d377..534316c 100644
> --- a/arch/arm/mach-omap2/board-omap3beagle.c
> +++ b/arch/arm/mach-omap2/board-omap3beagle.c
> @@ -39,6 +39,7 @@
>  
>  #include <plat/board.h>
>  #include <plat/common.h>
> +#include <plat/display.h>
>  #include <plat/gpmc.h>
>  #include <plat/nand.h>
>  #include <plat/usb.h>
> @@ -106,6 +107,105 @@ static struct platform_device omap3beagle_nand_device = {
>  	.resource	= &omap3beagle_nand_resource,
>  };
>  
> +/* DSS */
> +
> +static int beagle_enable_dvi(struct omap_dss_device *dssdev)
> +{
> +	if (dssdev->reset_gpio != -1)
> +		gpio_set_value(dssdev->reset_gpio, 1);
> +
> +	return 0;
> +}
> +
> +static void beagle_disable_dvi(struct omap_dss_device *dssdev)
> +{
> +	if (dssdev->reset_gpio != -1)
> +		gpio_set_value(dssdev->reset_gpio, 0);
> +}
> +
> +static struct omap_dss_device beagle_dvi_device = {
> +	.type = OMAP_DISPLAY_TYPE_DPI,
> +	.name = "dvi",
> +	.driver_name = "generic_panel",
> +	.phy.dpi.data_lines = 24,
> +	.reset_gpio = 170,
> +	.platform_enable = beagle_enable_dvi,
> +	.platform_disable = beagle_disable_dvi,
> +};
> +
> +static int beagle_panel_enable_tv(struct omap_dss_device *dssdev)
> +{
> +#define ENABLE_VDAC_DEDICATED           0x03
> +#define ENABLE_VDAC_DEV_GRP             0x20
> +
> +	twl_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER,
> +			ENABLE_VDAC_DEDICATED,
> +			TWL4030_VDAC_DEDICATED);
> +	twl_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER,
> +			ENABLE_VDAC_DEV_GRP, TWL4030_VDAC_DEV_GRP);
> +
> +	return 0;
> +}
> +
> +static void beagle_panel_disable_tv(struct omap_dss_device *dssdev)
> +{
> +	twl_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER, 0x00,
> +			TWL4030_VDAC_DEDICATED);
> +	twl_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER, 0x00,
> +			TWL4030_VDAC_DEV_GRP);
> +}
> +
> +static struct omap_dss_device beagle_tv_device = {
> +	.name = "tv",
> +	.driver_name = "venc",
> +	.type = OMAP_DISPLAY_TYPE_VENC,
> +	.phy.venc.type = OMAP_DSS_VENC_TYPE_SVIDEO,
> +	.platform_enable = beagle_panel_enable_tv,
> +	.platform_disable = beagle_panel_disable_tv,
> +};
> +
> +static struct omap_dss_device *beagle_dss_devices[] = {
> +	&beagle_dvi_device,
> +	&beagle_tv_device,
> +};
> +
> +static struct omap_dss_board_info beagle_dss_data = {
> +	.num_devices = ARRAY_SIZE(beagle_dss_devices),
> +	.devices = beagle_dss_devices,
> +	.default_device = &beagle_dvi_device,
> +};
> +
> +static struct platform_device beagle_dss_device = {
> +	.name          = "omapdss",
> +	.id            = -1,
> +	.dev            = {
> +		.platform_data = &beagle_dss_data,
> +	},
> +};
> +
> +static struct regulator_consumer_supply beagle_vdac_supply = {
> +	.supply		= "vdda_dac",
> +	.dev		= &beagle_dss_device.dev,
> +};
> +
> +static struct regulator_consumer_supply beagle_vdvi_supply = {
> +	.supply		= "vdds_dsi",
> +	.dev		= &beagle_dss_device.dev,
> +};
> +
> +static void __init beagle_display_init(void)
> +{
> +	int r;
> +
> +	r = gpio_request(beagle_dvi_device.reset_gpio, "DVI reset");
> +	if (r < 0) {
> +		printk(KERN_ERR "Unable to get DVI reset GPIO\n");
> +		return;
> +	}
> +
> +	gpio_direction_output(beagle_dvi_device.reset_gpio, 0);
> +}
> +
>  #include "sdram-micron-mt46h32m32lf-6.h"
>  
>  static struct omap2_hsmmc_info mmc[] = {
> @@ -117,15 +217,6 @@ static struct omap2_hsmmc_info mmc[] = {
>  	{}	/* Terminator */
>  };
>  
> -static struct platform_device omap3_beagle_lcd_device = {
> -	.name		= "omap3beagle_lcd",
> -	.id		= -1,
> -};
> -
> -static struct omap_lcd_config omap3_beagle_lcd_config __initdata = {
> -	.ctrl_name	= "internal",
> -};
> -
>  static struct regulator_consumer_supply beagle_vmmc1_supply = {
>  	.supply			= "vmmc",
>  };
> @@ -181,16 +272,6 @@ static struct twl4030_gpio_platform_data beagle_gpio_data = {
>  	.setup		= beagle_twl_gpio_setup,
>  };
>  
> -static struct regulator_consumer_supply beagle_vdac_supply = {
> -	.supply		= "vdac",
> -	.dev		= &omap3_beagle_lcd_device.dev,
> -};
> -
> -static struct regulator_consumer_supply beagle_vdvi_supply = {
> -	.supply		= "vdvi",
> -	.dev		= &omap3_beagle_lcd_device.dev,
> -};
> -
>  /* VMMC1 for MMC1 pins CMD, CLK, DAT0..DAT3 (20 mA, plus card == max 220 mA) */
>  static struct regulator_init_data beagle_vmmc1 = {
>  	.constraints = {
> @@ -349,14 +430,8 @@ static struct platform_device keys_gpio = {
>  	},
>  };
>  
> -static struct omap_board_config_kernel omap3_beagle_config[] __initdata = {
> -	{ OMAP_TAG_LCD,		&omap3_beagle_lcd_config },
> -};
> -
>  static void __init omap3_beagle_init_irq(void)
>  {
> -	omap_board_config = omap3_beagle_config;
> -	omap_board_config_size = ARRAY_SIZE(omap3_beagle_config);
>  	omap2_init_common_hw(mt46h32m32lf6_sdrc_params,
>  			     mt46h32m32lf6_sdrc_params);
>  	omap_init_irq();
> @@ -367,9 +442,9 @@ static void __init omap3_beagle_init_irq(void)
>  }
>  
>  static struct platform_device *omap3_beagle_devices[] __initdata = {
> -	&omap3_beagle_lcd_device,
>  	&leds_gpio,
>  	&keys_gpio,
> +	&beagle_dss_device,
>  };
>  
>  static void __init omap3beagle_flash_init(void)
> @@ -456,8 +531,9 @@ static void __init omap3_beagle_init(void)
>  	/* Ensure SDRC pins are mux'd for self-refresh */
>  	omap_mux_init_signal("sdrc_cke0", OMAP_PIN_OUTPUT);
>  	omap_mux_init_signal("sdrc_cke1", OMAP_PIN_OUTPUT);
> -}
>  
> +	beagle_display_init();
> +}
>  static void __init omap3_beagle_map_io(void)
>  {
>  	omap2_set_globals_343x();



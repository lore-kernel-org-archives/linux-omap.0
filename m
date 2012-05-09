From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/2] Add LCD support for the LogicPD OMAP3530 DevKits
Date: Tue, 8 May 2012 17:13:22 -0700
Message-ID: <20120509001321.GA5088@atomide.com>
References: <1336418480-32635-1-git-send-email-ashwin.bihari@logicpd.com>
 <1336418480-32635-3-git-send-email-ashwin.bihari@logicpd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:61152 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751241Ab2EIANY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 May 2012 20:13:24 -0400
Content-Disposition: inline
In-Reply-To: <1336418480-32635-3-git-send-email-ashwin.bihari@logicpd.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ashwin Bihari <ashwin.bihari@logicpd.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>

* Ashwin Bihari <ashwin.bihari@logicpd.com> [120507 12:41]:
> Use the generic DSS panel driver that provides support for
> the 4.3" Sharp LQ043T1DG01 that comes standard on the
> OMAP3530 SOM-LV and Torpedo DevKits.

Applying the 1/2 of this into board branch, but this probably
needs to be coordinated with changes Tomi is doing.

Regards,

Tony

 
> Signed-off-by: Ashwin Bihari <ashwin.bihari@logicpd.com>
> ---
>  arch/arm/mach-omap2/board-omap3logic.c |  147 ++++++++++++++++++++++++++++++++
>  1 files changed, 147 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-omap3logic.c b/arch/arm/mach-omap2/board-omap3logic.c
> index c008bf8..f0545c9 100644
> --- a/arch/arm/mach-omap2/board-omap3logic.c
> +++ b/arch/arm/mach-omap2/board-omap3logic.c
> @@ -47,6 +47,8 @@
>  #include <plat/gpmc.h>
>  #include <plat/sdrc.h>
>  #include <plat/usb.h>
> +#include <video/omapdss.h>
> +#include <video/omap-panel-generic-dpi.h>
>  
>  #define OMAP3LOGIC_SMSC911X_CS			1
>  
> @@ -57,6 +59,11 @@
>  #define OMAP3_TORPEDO_MMC_GPIO_CD		127
>  #define OMAP3_TORPEDO_SMSC911X_GPIO_IRQ		129
>  
> +#define LCD_PANEL_PWR				155
> +#define OMAP3530_LV_SOM_BACKLIGHT_PWR		8
> +#define OMAP3530_TORPEDO_BACKLIGHT_PWR		154
> +#define OMAP3530_TORPEDO_MDISP			56
> +
>  static struct regulator_consumer_supply omap3logic_vmmc1_supply[] = {
>  	REGULATOR_SUPPLY("vmmc", "omap_hsmmc.0"),
>  };
> @@ -104,6 +111,10 @@ static struct twl4030_platform_data omap3logic_twldata = {
>  
>  static int __init omap3logic_i2c_init(void)
>  {
> +	omap3_pmic_get_config(&omap3logic_twldata,
> +			      TWL_COMMON_PDATA_USB,
> +			      TWL_COMMON_REGULATOR_VDAC | TWL_COMMON_REGULATOR_VPLL2);
> +
>  	omap3_pmic_init("twl4030", &omap3logic_twldata);
>  	return 0;
>  }
> @@ -207,6 +218,36 @@ static struct omap_board_mux board_mux[] __initdata = {
>  	OMAP3_MUX(HSUSB0_DATA6, OMAP_MUX_MODE0 | OMAP_PIN_INPUT),
>  	OMAP3_MUX(HSUSB0_DATA7, OMAP_MUX_MODE0 | OMAP_PIN_INPUT),
>  
> +	/* DSS */
> +	OMAP3_MUX(DSS_PCLK, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
> +	OMAP3_MUX(DSS_HSYNC, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
> +	OMAP3_MUX(DSS_VSYNC, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
> +	OMAP3_MUX(DSS_ACBIAS, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
> +	OMAP3_MUX(DSS_DATA0, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
> +	OMAP3_MUX(DSS_DATA1, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
> +	OMAP3_MUX(DSS_DATA2, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
> +	OMAP3_MUX(DSS_DATA3, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
> +	OMAP3_MUX(DSS_DATA4, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
> +	OMAP3_MUX(DSS_DATA5, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
> +	OMAP3_MUX(DSS_DATA6, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
> +	OMAP3_MUX(DSS_DATA7, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
> +	OMAP3_MUX(DSS_DATA8, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
> +	OMAP3_MUX(DSS_DATA9, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
> +	OMAP3_MUX(DSS_DATA10, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
> +	OMAP3_MUX(DSS_DATA11, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
> +	OMAP3_MUX(DSS_DATA12, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
> +	OMAP3_MUX(DSS_DATA13, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
> +	OMAP3_MUX(DSS_DATA14, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
> +	OMAP3_MUX(DSS_DATA15, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
> +	OMAP3_MUX(DSS_DATA16, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
> +	OMAP3_MUX(DSS_DATA17, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
> +	OMAP3_MUX(DSS_DATA18, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
> +	OMAP3_MUX(DSS_DATA19, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
> +	OMAP3_MUX(DSS_DATA20, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
> +	OMAP3_MUX(DSS_DATA21, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
> +	OMAP3_MUX(DSS_DATA22, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
> +	OMAP3_MUX(DSS_DATA23, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
> +
>  	{ .reg_offset = OMAP_MUX_TERMINATOR },
>  };
>  #endif
> @@ -216,17 +257,123 @@ static struct regulator_consumer_supply dummy_supplies[] = {
>  	REGULATOR_SUPPLY("vdd33a", "smsc911x.0"),
>  };
>  
> +#if defined(CONFIG_PANEL_GENERIC_DPI) || \
> +	defined(CONFIG_PANEL_GENERIC_DPI_MODULE)
> +static void __init omap3logic_display_init(void)
> +{
> +	int r;
> +
> +	omap_mux_init_gpio(LCD_PANEL_PWR, OMAP_PIN_OUTPUT);
> +	if (machine_is_omap3530_lv_som())
> +		omap_mux_init_gpio(OMAP3530_LV_SOM_BACKLIGHT_PWR, OMAP_PIN_OUTPUT);
> +	else if (machine_is_omap3_torpedo()) {
> +		omap_mux_init_gpio(OMAP3530_TORPEDO_BACKLIGHT_PWR, OMAP_PIN_OUTPUT);
> +		omap_mux_init_gpio(OMAP3530_TORPEDO_MDISP, OMAP_PIN_OUTPUT);
> +	}
> +
> +	r = gpio_request(LCD_PANEL_PWR, "lcd enable");
> +	if (r) {
> +		printk(KERN_ERR "Failed to get DSS panel enable GPIO\n");
> +		return;
> +	}
> +	gpio_direction_output(LCD_PANEL_PWR, 0);
> +
> +	if (machine_is_omap3530_lv_som()) {
> +		r = gpio_request(OMAP3530_LV_SOM_BACKLIGHT_PWR, "lcd backlight enable");
> +		if (r) {
> +			printk(KERN_ERR "Failed to get DSS panel backlight enable GPIO\n");
> +			return;
> +		}
> +		gpio_direction_output(OMAP3530_LV_SOM_BACKLIGHT_PWR, 0);
> +	} else if (machine_is_omap3_torpedo()) {
> +		r = gpio_request(OMAP3530_TORPEDO_BACKLIGHT_PWR, "lcd backlight enable");
> +		if (r) {
> +			printk(KERN_ERR "Failed to get DSS panel backlight enable GPIO\n");
> +			return;
> +		}
> +		gpio_direction_output(OMAP3530_TORPEDO_BACKLIGHT_PWR, 0);
> +
> +		r = gpio_request(OMAP3530_TORPEDO_MDISP, "lcd mdisp");
> +		if (r) {
> +			printk(KERN_ERR "Failed to get DSS panel mdisp GPIO\n");
> +			return;
> +		}
> +		gpio_direction_output(OMAP3530_TORPEDO_MDISP, 0);
> +	}
> +
> +	printk(KERN_INFO "Display initialized successfully\n");
> +}
> +#else
> +static void __init omap3logic_dislpay_init(void) {}
> +#endif
> +
> +static int omap3logic_panel_enable_lcd(struct omap_dss_device *dssdev)
> +{
> +	gpio_set_value(LCD_PANEL_PWR, 1);
> +	if (machine_is_omap3530_lv_som())
> +		gpio_set_value(OMAP3530_LV_SOM_BACKLIGHT_PWR, 1);
> +	else if (machine_is_omap3_torpedo()) {
> +		gpio_set_value(OMAP3530_TORPEDO_BACKLIGHT_PWR, 1);
> +
> +		gpio_set_value(OMAP3530_TORPEDO_MDISP, 1);
> +	}
> +
> +	return 0;
> +}
> +
> +static int omap3logic_panel_disable_lcd(struct omap_dss_device *dssdev)
> +{
> +	gpio_set_value(LCD_PANEL_PWR, 0);
> +	if (machine_is_omap3530_lv_som())
> +		gpio_set_value(OMAP3530_LV_SOM_BACKLIGHT_PWR, 0);
> +	else if (machine_is_omap3_torpedo()) {
> +		gpio_set_value(OMAP3530_TORPEDO_BACKLIGHT_PWR, 0);
> +
> +		gpio_set_value(OMAP3530_TORPEDO_MDISP, 0);
> +	}
> +
> +	return 0;
> +}
> +
> +static struct panel_generic_dpi_data lcd_panel = {
> +	.name			= "sharp_lq",
> +	.platform_enable	= omap3logic_panel_enable_lcd,
> +	.platform_disable	= omap3logic_panel_disable_lcd,
> +};
> +
> +static struct omap_dss_device omap3logic_lcd_device = {
> +	.type			= OMAP_DISPLAY_TYPE_DPI,
> +	.name			= "lcd",
> +	.driver_name		= "generic_dpi_panel",
> +	.data			= &lcd_panel,
> +	.phy.dpi.data_lines	= 16,
> +};
> +
> +static struct omap_dss_device *omap3logic_dss_devices[] = {
> +	&omap3logic_lcd_device,
> +};
> +
> +static struct omap_dss_board_info omap3logic_dss_data = {
> +	.num_devices		= ARRAY_SIZE(omap3logic_dss_devices),
> +	.devices		= omap3logic_dss_devices,
> +	.default_device		= &omap3logic_lcd_device,
> +};
> +
>  static void __init omap3logic_init(void)
>  {
>  	regulator_register_fixed(0, dummy_supplies, ARRAY_SIZE(dummy_supplies));
>  	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
>  	omap3torpedo_fix_pbias_voltage();
>  	omap3logic_i2c_init();
> +	omap_display_init(&omap3logic_dss_data);
>  	omap_serial_init();
>  	omap_sdrc_init(NULL, NULL);
>  	board_mmc_init();
>  	board_smsc911x_init();
>  
> +	/* DSS */
> +	omap3logic_display_init();
> +
>  	usb_musb_init(NULL);
>  
>  	/* Ensure SDRC pins are mux'd for self-refresh */
> -- 
> 1.7.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

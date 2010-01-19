From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH 1/2] OMAP: DSS: Add display board file for zoom boards
Date: Tue, 19 Jan 2010 23:22:02 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044A47239C@dbde02.ent.ti.com>
References: <E0D41E29EB0DAC4E9F3FF173962E9E94026B2DC23C@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:53006 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751151Ab0ASRwW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Jan 2010 12:52:22 -0500
In-Reply-To: <E0D41E29EB0DAC4E9F3FF173962E9E94026B2DC23C@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Y, Kishore" <kishore.y@ti.com>, Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Y, Kishore
> Sent: Tuesday, January 19, 2010 6:42 PM
> To: Tomi Valkeinen
> Cc: linux-omap@vger.kernel.org
> Subject: [PATCH 1/2] OMAP: DSS: Add display board file for zoom
> boards
> 
> From: Kishore Y <kishore.y@ti.com>
> 
> board-zoom-display.c added as a common file for display
> fucntionality
> on boards zoom2, zoom3 and 3630sdp
> 
> Signed-off-by: Mukund Mittal <mmittal@ti.com>
> Signed-off-by: Kishore Y <kishore.y@ti.com>
> ---
>  arch/arm/mach-omap2/Makefile                  |    3 +
>  arch/arm/mach-omap2/board-zoom-display.c      |  232
> +++++++++++++++++++++++++
>  arch/arm/mach-omap2/board-zoom-peripherals.c  |   36 ++++
>  arch/arm/mach-omap2/include/mach/board-zoom.h |    3 +
>  4 files changed, 274 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/mach-omap2/board-zoom-display.c
> 
> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-
> omap2/Makefile
> index b32678b..3dbe694 100644
> --- a/arch/arm/mach-omap2/Makefile
> +++ b/arch/arm/mach-omap2/Makefile
> @@ -91,14 +91,17 @@ obj-$(CONFIG_MACH_NOKIA_RX51)		+=
> board-rx51.o \
>  					   board-rx51-peripherals.o \
>  					   mmc-twl4030.o
>  obj-$(CONFIG_MACH_OMAP_ZOOM2)		+= board-zoom2.o \
> +					   board-zoom-display.o \
>  					   board-zoom-peripherals.o \
>  					   mmc-twl4030.o \
>  					   board-zoom-debugboard.o
>  obj-$(CONFIG_MACH_OMAP_ZOOM3)		+= board-zoom3.o \
> +					   board-zoom-display.o \
>  					   board-zoom-peripherals.o \
>  					   mmc-twl4030.o \
>  					   board-zoom-debugboard.o
>  obj-$(CONFIG_MACH_OMAP_3630SDP)		+= board-3630sdp.o \
> +					   board-zoom-display.o \
>  					   board-zoom-peripherals.o \
>  					   mmc-twl4030.o
>  obj-$(CONFIG_MACH_CM_T35)		+= board-cm-t35.o \
> diff --git a/arch/arm/mach-omap2/board-zoom-display.c
> b/arch/arm/mach-omap2/board-zoom-display.c
> new file mode 100644
> index 0000000..c8f47f4
> --- /dev/null
> +++ b/arch/arm/mach-omap2/board-zoom-display.c
> @@ -0,0 +1,232 @@
> +/*
> + * Copyright (C) 2009 Texas Instruments Inc.
> + *
> + * Modified from mach-omap2/board-zoom-peripherals.c
> + *
> + * This program is free software; you can redistribute it and/or
> modify
> + * it under the terms of the GNU General Public License version 2
> as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/platform_device.h>
> +#include <linux/gpio.h>
> +#include <linux/i2c/twl.h>
> +#include <linux/spi/spi.h>
> +#include <linux/regulator/machine.h>
> +#include <linux/regulator/consumer.h>
> +#include <plat/common.h>
> +#include <plat/control.h>
> +#include <plat/mcspi.h>
> +#include <plat/display.h>
> +
> +#define LCD_PANEL_ENABLE_GPIO		(7 + OMAP_MAX_GPIO_LINES)
> +#define LCD_PANEL_RESET_GPIO_PROD	96
> +#define LCD_PANEL_RESET_GPIO_PILOT	55
> +#define LCD_PANEL_QVGA_GPIO		56
> +#define TV_PANEL_ENABLE_GPIO		95
> +
> +struct zoom_dss_board_info {
> +	int gpio_flag;
> +};
> +
> +static void zoom_lcd_tv_panel_init(void)
> +{
> +	int ret;
> +	unsigned char lcd_panel_reset_gpio;
> +
> +	if (omap_rev() > OMAP3430_REV_ES3_0) {
> +		/* Production Zoom2 board:
> +		 * GPIO-96 is the LCD_RESET_GPIO
> +		 */
> +		lcd_panel_reset_gpio = LCD_PANEL_RESET_GPIO_PROD;
> +	} else {
> +		/* Pilot Zoom2 board:
> +		 * GPIO-55 is the LCD_RESET_GPIO
> +		 */
> +		lcd_panel_reset_gpio = LCD_PANEL_RESET_GPIO_PILOT;
> +	}
> +
> +	ret = gpio_request(lcd_panel_reset_gpio, "lcd reset");
> +	if (ret) {
> +		pr_err("Failed to get LCD reset GPIO.\n");
> +		return;
> +	}
> +	gpio_direction_output(lcd_panel_reset_gpio, 1);
> +
> +	ret = gpio_request(LCD_PANEL_QVGA_GPIO, "lcd qvga");
> +	if (ret) {
> +		pr_err("Failed to get LCD_PANEL_QVGA_GPIO.\n");
> +		goto err0;
> +	}
> +	gpio_direction_output(LCD_PANEL_QVGA_GPIO, 1);
> +
> +	ret = gpio_request(TV_PANEL_ENABLE_GPIO, "tv panel");
> +	if (ret) {
> +		pr_err("Failed to get TV_PANEL_ENABLE_GPIO.\n");
> +		goto err1;
> +	}
> +	gpio_direction_output(TV_PANEL_ENABLE_GPIO, 0);
> +
> +	return 0;
> +
[Hiremath, Vaibhav] How are you not getting an warning here? You are returning integer value from void function.

> +err1:
> +	gpio_free(LCD_PANEL_QVGA_GPIO);
> +err0:
> +	gpio_free(lcd_panel_reset_gpio);
> +}
> +
> +static int zoom_panel_power_enable(int enable)
> +{
> +	int ret;
> +	struct regulator *vpll2_reg;
> +
> +	vpll2_reg = regulator_get(NULL, "vpll2");
> +	if (IS_ERR(vpll2_reg)) {
> +		pr_err("Unable to get vpll2 regulator\n");
> +		return PTR_ERR(vpll2_reg);
> +	}
> +
[Hiremath, Vaibhav] The above code snippet is getting executed every time you call this function, and I believe regulator_get maintains some book-keeping for this. This should be part of one-time init code.

> +	if (enable)
> +		ret = regulator_enable(vpll2_reg);
> +	else
> +		ret = regulator_disable(vpll2_reg);
> +
> +	return ret;
> +}
> +
> +static int zoom_panel_enable_lcd(struct omap_dss_device *dssdev)
> +{
> +	int ret;
> +	struct zoom_dss_board_info *pdata;
> +
> +	ret = zoom_panel_power_enable(1);
> +	if (ret < 0)
> +		return ret;
> +	pdata = dssdev->dev.platform_data;
> +	if (pdata->gpio_flag == 0) {
> +		ret = gpio_request(LCD_PANEL_ENABLE_GPIO, "lcd enable");
[Hiremath, Vaibhav] Can we move this to zoom_lcd_tv_panel_init/zoom_display_init and just call gpio_set_value from here?

Did you face any issues with this?

> +		if (ret) {
> +			pr_err("Failed to get LCD_PANEL_ENABLE_GPIO.\n");
> +			return ret;
> +		}
> +		gpio_direction_output(LCD_PANEL_ENABLE_GPIO, 1);
> +		pdata->gpio_flag = 1;
> +	} else {
> +		gpio_set_value(LCD_PANEL_ENABLE_GPIO, 1);
> +	}
> +
> +	return 0;
> +}
> +
> +static void zoom_panel_disable_lcd(struct omap_dss_device *dssdev)
> +{
> +	zoom_panel_power_enable(0);
> +	gpio_set_value(LCD_PANEL_ENABLE_GPIO, 0);
> +}
> +
> +static int zoom_panel_enable_tv(struct omap_dss_device *dssdev)
> +{
> +	int ret;
> +	struct regulator *vdac_reg;
> +
> +	vdac_reg = regulator_get(NULL, "vdda_dac");
> +	if (IS_ERR(vdac_reg)) {
> +		pr_err("Unable to get vdac regulator\n");
> +		return PTR_ERR(vdac_reg);
> +	}
[Hiremath, Vaibhav] Same here.

> +	ret = regulator_enable(vdac_reg);
> +	if (ret < 0)
> +		return ret;
> +	gpio_set_value(TV_PANEL_ENABLE_GPIO, 0);
> +
> +	return 0;
> +}
> +
> +static void zoom_panel_disable_tv(struct omap_dss_device *dssdev)
> +{
> +	struct regulator *vdac_reg;
> +
> +	vdac_reg = regulator_get(NULL, "vdda_dac");
> +	if (IS_ERR(vdac_reg)) {
> +		pr_err("Unable to get vpll2 regulator\n");
> +		return;
> +	}
[Hiremath, Vaibhav] Again same thing here.

One thing I am not able to understand here is, you are not calling regulator_put anywhere in your code. Am I missing anything here?

Thanks,
Vaibhav

> +	regulator_disable(vdac_reg);
> +	gpio_set_value(TV_PANEL_ENABLE_GPIO, 1);
> +}
> +
> +static struct zoom_dss_board_info zoom_dss_lcd_data = {
> +	.gpio_flag = 0,
> +};
> +
> +static struct omap_dss_device zoom_lcd_device = {
> +	.name = "lcd",
> +	.driver_name = "NEC_8048_panel",
> +	.type = OMAP_DISPLAY_TYPE_DPI,
> +	.phy.dpi.data_lines = 24,
> +	.platform_enable = zoom_panel_enable_lcd,
> +	.platform_disable = zoom_panel_disable_lcd,
> +	.dev = {
> +		.platform_data = &zoom_dss_lcd_data,
> +	},
> +};
> +
> +static struct omap_dss_device zoom_tv_device = {
> +	.name                   = "tv",
> +	.driver_name            = "venc",
> +	.type                   = OMAP_DISPLAY_TYPE_VENC,
> +	.phy.venc.type          = -1,
> +	.platform_enable        = zoom_panel_enable_tv,
> +	.platform_disable       = zoom_panel_disable_tv,
> +};
> +
> +static struct omap_dss_device *zoom_dss_devices[] = {
> +	&zoom_lcd_device,
> +	&zoom_tv_device,
> +};
> +
> +static struct omap_dss_board_info zoom_dss_data = {
> +	.num_devices = ARRAY_SIZE(zoom_dss_devices),
> +	.devices = zoom_dss_devices,
> +	.default_device = &zoom_lcd_device,
> +};
> +
> +static struct platform_device zoom_dss_device = {
> +	.name          = "omapdss",
> +	.id            = -1,
> +	.dev            = {
> +		.platform_data = &zoom_dss_data,
> +	},
> +};
> +
> +static struct omap2_mcspi_device_config dss_lcd_mcspi_config = {
> +	.turbo_mode             = 0,
> +	.single_channel         = 1,  /* 0: slave, 1: master */
> +};
> +
> +static struct spi_board_info nec_8048_spi_board_info[] __initdata =
> {
> +	[0] = {
> +		.modalias               = "nec_8048_spi",
> +		.bus_num                = 1,
> +		.chip_select            = 2,
> +		.max_speed_hz           = 375000,
> +		.controller_data        = &dss_lcd_mcspi_config,
> +	},
> +};
> +
> +static struct platform_device *zoom_display_devices[] __initdata =
> {
> +	&zoom_dss_device,
> +};
> +
> +void __init zoom_display_init(enum omap_dss_venc_type venc_type)
> +{
> +	zoom_tv_device.phy.venc.type = venc_type;
> +	platform_add_devices(zoom_display_devices,
> +				ARRAY_SIZE(zoom_display_devices));
> +	spi_register_board_info(nec_8048_spi_board_info,
> +				ARRAY_SIZE(nec_8048_spi_board_info));
> +	zoom_lcd_tv_panel_init();
> +}
> +
> diff --git a/arch/arm/mach-omap2/board-zoom-peripherals.c
> b/arch/arm/mach-omap2/board-zoom-peripherals.c
> index 8dd277c..37a1c5e 100755
> --- a/arch/arm/mach-omap2/board-zoom-peripherals.c
> +++ b/arch/arm/mach-omap2/board-zoom-peripherals.c
> @@ -170,6 +170,40 @@ static struct twl4030_hsmmc_info mmc[]
> __initdata = {
>  	{}      /* Terminator */
>  };
> 
> +static struct regulator_consumer_supply zoom_vpll2_supply = {
> +	.supply         = "vpll2",
> +};
> +
> +static struct regulator_consumer_supply zoom_vdda_dac_supply = {
> +	.supply         = "vdda_dac",
> +};
> +
> +static struct regulator_init_data zoom_vpll2 = {
> +	.constraints = {
> +		.min_uV                 = 1800000,
> +		.max_uV                 = 1800000,
> +		.valid_modes_mask       = REGULATOR_MODE_NORMAL
> +					| REGULATOR_MODE_STANDBY,
> +		.valid_ops_mask         = REGULATOR_CHANGE_MODE
> +					| REGULATOR_CHANGE_STATUS,
> +	},
> +	.num_consumer_supplies  = 1,
> +	.consumer_supplies      = &zoom_vpll2_supply,
> +};
> +
> +static struct regulator_init_data zoom_vdac = {
> +	.constraints = {
> +		.min_uV                 = 1800000,
> +		.max_uV                 = 1800000,
> +		.valid_modes_mask       = REGULATOR_MODE_NORMAL
> +					| REGULATOR_MODE_STANDBY,
> +		.valid_ops_mask         = REGULATOR_CHANGE_MODE
> +					| REGULATOR_CHANGE_STATUS,
> +	},
> +	.num_consumer_supplies  = 1,
> +	.consumer_supplies      = &zoom_vdda_dac_supply,
> +};
> +
>  static int zoom_twl_gpio_setup(struct device *dev,
>  		unsigned gpio, unsigned ngpio)
>  {
> @@ -242,6 +276,8 @@ static struct twl4030_platform_data zoom_twldata
> = {
>  	.vmmc1          = &zoom_vmmc1,
>  	.vmmc2          = &zoom_vmmc2,
>  	.vsim           = &zoom_vsim,
> +	.vpll2		= &zoom_vpll2,
> +	.vdac		= &zoom_vdac,
> 
>  };
> 
> diff --git a/arch/arm/mach-omap2/include/mach/board-zoom.h
> b/arch/arm/mach-omap2/include/mach/board-zoom.h
> index c93b29e..aec73b4 100644
> --- a/arch/arm/mach-omap2/include/mach/board-zoom.h
> +++ b/arch/arm/mach-omap2/include/mach/board-zoom.h
> @@ -1,5 +1,8 @@
>  /*
>   * Defines for zoom boards
>   */
> +#include <plat/display.h>
> +
>  extern int __init zoom_debugboard_init(void);
>  extern void __init zoom_peripherals_init(void);
> +extern void __init zoom_display_init(enum omap_dss_venc_type
> venc_type);
> --
> 1.5.4.3
> 
> 
> Regards,
> Kishore Y
> --
> To unsubscribe from this list: send the line "unsubscribe linux-
> omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

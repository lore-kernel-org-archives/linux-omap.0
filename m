From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: RE: [PATCH 1/2 V2] OMAP: DSS: Add display board file for zoom boards
Date: Thu, 11 Feb 2010 17:05:25 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E94026B7E8C25@dbde02.ent.ti.com>
References: <E0D41E29EB0DAC4E9F3FF173962E9E94026B7E8B93@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:47128 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752197Ab0BKLfh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Feb 2010 06:35:37 -0500
In-Reply-To: <E0D41E29EB0DAC4E9F3FF173962E9E94026B7E8B93@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Y, Kishore" <kishore.y@ti.com>, Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Hiremath, Vaibhav" <hvaibhav@ti.com>, Grazvydas Ignotas <notasas@gmail.com>




> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org 
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Y, Kishore
> Sent: Thursday, February 11, 2010 3:33 PM
> To: Tomi Valkeinen
> Cc: linux-omap@vger.kernel.org; Hiremath, Vaibhav; Grazvydas Ignotas
> Subject: [PATCH 1/2 V2] OMAP: DSS: Add display board file for 
> zoom boards
> 
> From: Kishore Y <kishore.y@ti.com>
> 
> board-zoom-display.c added as a common file for display fucntionality
> on boards zoom2, zoom3 and 3630sdp
> 
> Signed-off-by: Mukund Mittal <mmittal@ti.com>
> Signed-off-by: Kishore Y <kishore.y@ti.com>
> ---
>  arch/arm/mach-omap2/Makefile                  |    3 +
>  arch/arm/mach-omap2/board-zoom-display.c      |  188 
> +++++++++++++++++++++++++
>  arch/arm/mach-omap2/board-zoom-peripherals.c  |   36 +++++
>  arch/arm/mach-omap2/include/mach/board-zoom.h |    3 +
>  4 files changed, 230 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/mach-omap2/board-zoom-display.c
> 
> diff --git a/arch/arm/mach-omap2/Makefile 
> b/arch/arm/mach-omap2/Makefile
> index b32678b..3dbe694 100644
> --- a/arch/arm/mach-omap2/Makefile
> +++ b/arch/arm/mach-omap2/Makefile
> @@ -91,14 +91,17 @@ obj-$(CONFIG_MACH_NOKIA_RX51)		
> += board-rx51.o \
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
> index 0000000..fcadfd4
> --- /dev/null
> +++ b/arch/arm/mach-omap2/board-zoom-display.c
> @@ -0,0 +1,188 @@
> +/*
> + * Copyright (C) 2009 Texas Instruments Inc.

2009?

> + *
> + * Modified from mach-omap2/board-zoom-peripherals.c
> + *
> + * This program is free software; you can redistribute it 
> and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/platform_device.h>
> +#include <linux/gpio.h>
> +#include <linux/i2c/twl.h>
> +#include <linux/spi/spi.h>
> +#include <plat/common.h>
> +#include <plat/control.h>
> +#include <plat/mcspi.h>
> +#include <plat/display.h>
> +
> +#define LCD_PANEL_ENABLE_GPIO		(7 + 
> OMAP_MAX_GPIO_LINES)
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

How about: 

lcd_panel_reset_gpio = (omap_rev() > OMAP3430_REV_ES3_0) ? LCD_PANEL_RESET_GPIO_PROD :
						LCD_PANEL_RESET_GPIO_PILOT;

> +
> +	ret = gpio_request(lcd_panel_reset_gpio, "lcd reset");
> +	if (ret) {
> +		pr_err("Failed to get LCD reset GPIO.\n");

Something like:

       pr_err("Failed to request GPIO%d for LCD reset GPIO\n",
                                lcd_panel_reset_gpio);

Will be useful info for the user incase of failure.

> +		return;
> +	}
> +	gpio_direction_output(lcd_panel_reset_gpio, 1);
> +
> +	ret = gpio_request(LCD_PANEL_QVGA_GPIO, "lcd qvga");
> +	if (ret) {
> +		pr_err("Failed to get LCD_PANEL_QVGA_GPIO.\n");

-Ditto-

> +		goto err0;
> +	}
> +	gpio_direction_output(LCD_PANEL_QVGA_GPIO, 1);
> +
> +	ret = gpio_request(TV_PANEL_ENABLE_GPIO, "tv panel");
> +	if (ret) {
> +		pr_err("Failed to get TV_PANEL_ENABLE_GPIO.\n");

-Ditto- 

> +		goto err1;
> +	}
> +	gpio_direction_output(TV_PANEL_ENABLE_GPIO, 0);
> +
> +	return;
> +
> +err1:
> +	gpio_free(LCD_PANEL_QVGA_GPIO);
> +err0:
> +	gpio_free(lcd_panel_reset_gpio);
> +}
> +
> +static int zoom_panel_enable_lcd(struct omap_dss_device *dssdev)
> +{
> +	int ret;
> +	struct zoom_dss_board_info *pdata;
> +
> +	pdata = dssdev->dev.platform_data;
> +	if (pdata->gpio_flag == 0) {
> +		ret = gpio_request(LCD_PANEL_ENABLE_GPIO, "lcd enable");
> +		if (ret) {
> +			pr_err("Failed to get 
> LCD_PANEL_ENABLE_GPIO.\n");

-Ditto- 

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
> +	gpio_set_value(LCD_PANEL_ENABLE_GPIO, 0);
> +}
> +
> +static int zoom_panel_enable_tv(struct omap_dss_device *dssdev)
> +{
> +	gpio_set_value(TV_PANEL_ENABLE_GPIO, 0);
> +
> +	return 0;
> +}
> +
> +static void zoom_panel_disable_tv(struct omap_dss_device *dssdev)
> +{
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

Any reason for not enabling turbo mode? If you are configuring spi in single
Channel mode, turbo mode can increase data transfer throughput.

-Manjunath

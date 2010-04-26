From: "Y, Kishore" <kishore.y@ti.com>
Subject: RE: [PATCH 1/2 V5] OMAP: DSS: Add display board file for zoom boards
Date: Mon, 26 Apr 2010 13:48:07 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E94026F6E2E31@dbde02.ent.ti.com>
References: <19F8576C6E063C45BE387C64729E7394044E1EBBE6@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:58104 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754584Ab0DZIQt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 26 Apr 2010 04:16:49 -0400
In-Reply-To: <19F8576C6E063C45BE387C64729E7394044E1EBBE6@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>, Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


> -----Original Message-----
> From: Hiremath, Vaibhav
> Sent: Sunday, April 25, 2010 8:58 PM
> To: Y, Kishore; Tomi Valkeinen
> Cc: linux-omap@vger.kernel.org
> Subject: RE: [PATCH 1/2 V5] OMAP: DSS: Add display board file for zoom
> boards
> 
> > -----Original Message-----
> > From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> > owner@vger.kernel.org] On Behalf Of Y, Kishore
> > Sent: Sunday, April 25, 2010 2:00 PM
> > To: Tomi Valkeinen
> > Cc: linux-omap@vger.kernel.org
> > Subject: [PATCH 1/2 V5] OMAP: DSS: Add display board file for zoom
> boards
> >
> >
> > board-zoom-display.c added as a common file for display fucntionality
> > on boards zoom2, zoom3 and 3630sdp
> >
> > Signed-off-by: Mukund Mittal <mmittal@ti.com>
> > Signed-off-by: Kishore Y <kishore.y@ti.com>
> > Reviewed-by: Gadiyar, Anand <gadiyar@ti.com>
> > ---
> >  arch/arm/mach-omap2/Makefile                  |    3 +
> >  arch/arm/mach-omap2/board-zoom-display.c      |  158
> > +++++++++++++++++++++++++
> >  arch/arm/mach-omap2/board-zoom-peripherals.c  |   48 ++++++++-
> >  arch/arm/mach-omap2/include/mach/board-zoom.h |    3 +
> >  4 files changed, 211 insertions(+), 1 deletions(-)
> >  create mode 100644 arch/arm/mach-omap2/board-zoom-display.c
> >
> > diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
> > index 4b9fc57..69f7d2f 100644
> > --- a/arch/arm/mach-omap2/Makefile
> > +++ b/arch/arm/mach-omap2/Makefile
> > @@ -124,14 +124,17 @@ obj-$(CONFIG_MACH_NOKIA_RX51)		+= board-
> rx51.o
> > \
> >  					   board-rx51-peripherals.o \
> >  					   hsmmc.o
> >  obj-$(CONFIG_MACH_OMAP_ZOOM2)		+= board-zoom2.o \
> > +					   board-zoom-display.o \
> >  					   board-zoom-peripherals.o \
> >  					   hsmmc.o \
> >  					   board-zoom-debugboard.o
> >  obj-$(CONFIG_MACH_OMAP_ZOOM3)		+= board-zoom3.o \
> > +					   board-zoom-display.o \
> >  					   board-zoom-peripherals.o \
> >  					   hsmmc.o \
> >  					   board-zoom-debugboard.o
> >  obj-$(CONFIG_MACH_OMAP_3630SDP)		+= board-3630sdp.o \
> > +					   board-zoom-display.o \
> >  					   board-zoom-peripherals.o \
> >  					   hsmmc.o
> >  obj-$(CONFIG_MACH_CM_T35)		+= board-cm-t35.o \
> > diff --git a/arch/arm/mach-omap2/board-zoom-display.c b/arch/arm/mach-
> > omap2/board-zoom-display.c
> > new file mode 100644
> > index 0000000..59c98f4
> > --- /dev/null
> > +++ b/arch/arm/mach-omap2/board-zoom-display.c
> > @@ -0,0 +1,158 @@
> > +/*
> > + * Copyright (C) 2010 Texas Instruments Inc.
> > + *
> > + * Modified from mach-omap2/board-zoom-peripherals.c
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > + */
> > +
> > +#include <linux/kernel.h>
> > +#include <linux/init.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/gpio.h>
> > +#include <linux/i2c/twl.h>
> > +#include <linux/spi/spi.h>
> > +#include <plat/common.h>
> > +#include <plat/control.h>
> > +#include <plat/mcspi.h>
> > +#include <plat/display.h>
> > +
> > +#define LCD_PANEL_ENABLE_GPIO		(7 + OMAP_MAX_GPIO_LINES)
> > +#define LCD_PANEL_RESET_GPIO_PROD	96
> > +#define LCD_PANEL_RESET_GPIO_PILOT	55
> > +#define LCD_PANEL_QVGA_GPIO		56
> > +#define TV_PANEL_ENABLE_GPIO		95
> > +
> > +static void zoom_lcd_tv_panel_init(void)
> > +{
> > +	int ret;
> > +	unsigned char lcd_panel_reset_gpio;
> > +
> > +	lcd_panel_reset_gpio = (omap_rev() > OMAP3430_REV_ES3_0) ?
> > +				LCD_PANEL_RESET_GPIO_PROD :
> > +				LCD_PANEL_RESET_GPIO_PILOT;
> > +
> > +	ret = gpio_request(lcd_panel_reset_gpio, "lcd reset");
> > +	if (ret) {
> > +		pr_err("Failed to get LCD reset GPIO (gpio%d)\n",
> > +			lcd_panel_reset_gpio);
> > +		return;
> > +	}
> > +	gpio_direction_output(lcd_panel_reset_gpio, 1);
> > +
> > +	ret = gpio_request(LCD_PANEL_QVGA_GPIO, "lcd qvga");
> > +	if (ret) {
> > +		pr_err("Failed to get LCD_PANEL_QVGA_GPIO (gpio%d).\n",
> > +			LCD_PANEL_QVGA_GPIO);
> > +		goto err0;
> > +	}
> > +	gpio_direction_output(LCD_PANEL_QVGA_GPIO, 1);
> > +
> > +	ret = gpio_request(TV_PANEL_ENABLE_GPIO, "tv panel");
> > +	if (ret) {
> > +		pr_err("Failed to get TV_PANEL_ENABLE_GPIO (gpio%d).\n",
> > +			TV_PANEL_ENABLE_GPIO);
> > +		goto err1;
> > +	}
> > +	gpio_direction_output(TV_PANEL_ENABLE_GPIO, 0);
> [Hiremath, Vaibhav] I think, by default you should disable all the panel
> control signals and driver code should take care of enabling
> default/selected panel.
> 
> Say for example, if you choose the default output to TV from bootargs, the
> LCD enable GPIO is going to high (1) irrespective of whether the default
> output is LCD or not.
> 
Actually I have turned on all the gpio pins at bootup (0 is enable for tv)
Might not be a good idea as you suggested. 
I will correct this and send out the next version

Regards
Kishore
> > +
> > +	return;
> > +
> > +err1:
> > +	gpio_free(LCD_PANEL_QVGA_GPIO);
> > +err0:
> > +	gpio_free(lcd_panel_reset_gpio);
> > +}
> > +
> > +static int zoom_panel_enable_lcd(struct omap_dss_device *dssdev)
> > +{
> > +	gpio_set_value(LCD_PANEL_ENABLE_GPIO, 1);
> > +
> > +	return 0;
> > +}
> > +
> > +static void zoom_panel_disable_lcd(struct omap_dss_device *dssdev)
> > +{
> > +	gpio_set_value(LCD_PANEL_ENABLE_GPIO, 0);
> > +}
> > +
> > +static int zoom_panel_enable_tv(struct omap_dss_device *dssdev)
> > +{
> > +	gpio_set_value(TV_PANEL_ENABLE_GPIO, 0);
> > +
> > +	return 0;
> > +}
> > +
> > +static void zoom_panel_disable_tv(struct omap_dss_device *dssdev)
> > +{
> > +	gpio_set_value(TV_PANEL_ENABLE_GPIO, 1);
> > +}
> > +
> > +static struct omap_dss_device zoom_lcd_device = {
> > +	.name = "lcd",
> > +	.driver_name = "NEC_8048_panel",
> > +	.type = OMAP_DISPLAY_TYPE_DPI,
> > +	.phy.dpi.data_lines = 24,
> > +	.platform_enable = zoom_panel_enable_lcd,
> > +	.platform_disable = zoom_panel_disable_lcd,
> > +};
> > +
> > +static struct omap_dss_device zoom_tv_device = {
> > +	.name                   = "tv",
> > +	.driver_name            = "venc",
> > +	.type                   = OMAP_DISPLAY_TYPE_VENC,
> > +	.phy.venc.type          = -1,
> > +	.platform_enable        = zoom_panel_enable_tv,
> > +	.platform_disable       = zoom_panel_disable_tv,
> > +};
> > +
> > +static struct omap_dss_device *zoom_dss_devices[] = {
> > +	&zoom_lcd_device,
> > +	&zoom_tv_device,
> > +};
> > +
> > +static struct omap_dss_board_info zoom_dss_data = {
> > +	.num_devices = ARRAY_SIZE(zoom_dss_devices),
> > +	.devices = zoom_dss_devices,
> > +	.default_device = &zoom_lcd_device,
> > +};
> > +
> > +static struct platform_device zoom_dss_device = {
> > +	.name          = "omapdss",
> > +	.id            = -1,
> > +	.dev            = {
> > +		.platform_data = &zoom_dss_data,
> > +	},
> > +};
> > +
> > +static struct omap2_mcspi_device_config dss_lcd_mcspi_config = {
> > +	.turbo_mode             = 1,
> > +	.single_channel         = 1,  /* 0: slave, 1: master */
> > +};
> > +
> > +static struct spi_board_info nec_8048_spi_board_info[] __initdata = {
> > +	[0] = {
> > +		.modalias               = "nec_8048_spi",
> > +		.bus_num                = 1,
> > +		.chip_select            = 2,
> > +		.max_speed_hz           = 375000,
> > +		.controller_data        = &dss_lcd_mcspi_config,
> > +	},
> > +};
> > +
> > +static struct platform_device *zoom_display_devices[] __initdata = {
> > +	&zoom_dss_device,
> > +};
> > +
> > +void __init zoom_display_init(enum omap_dss_venc_type venc_type)
> > +{
> > +	zoom_tv_device.phy.venc.type = venc_type;
> > +	platform_add_devices(zoom_display_devices,
> > +				ARRAY_SIZE(zoom_display_devices));
> > +	spi_register_board_info(nec_8048_spi_board_info,
> > +				ARRAY_SIZE(nec_8048_spi_board_info));
> > +	zoom_lcd_tv_panel_init();
> > +}
> > +
> > diff --git a/arch/arm/mach-omap2/board-zoom-peripherals.c
> b/arch/arm/mach-
> > omap2/board-zoom-peripherals.c
> > index 6b39849..0dfa7c7 100644
> > --- a/arch/arm/mach-omap2/board-zoom-peripherals.c
> > +++ b/arch/arm/mach-omap2/board-zoom-peripherals.c
> > @@ -27,6 +27,8 @@
> >  #include "mux.h"
> >  #include "hsmmc.h"
> >
> > +#define LCD_PANEL_ENABLE_GPIO		(7 + OMAP_MAX_GPIO_LINES)
> > +
> >  /* Zoom2 has Qwerty keyboard*/
> >  static int board_keymap[] = {
> >  	KEY(0, 0, KEY_E),
> > @@ -171,9 +173,43 @@ static struct omap2_hsmmc_info mmc[] __initdata = {
> >  	{}      /* Terminator */
> >  };
> >
> > +static struct regulator_consumer_supply zoom_vpll2_supply =
> > +	REGULATOR_SUPPLY("vdds_dsi", "omapdss");
> > +
> > +static struct regulator_consumer_supply zoom_vdda_dac_supply =
> > +	REGULATOR_SUPPLY("vdda_dac", "omapdss");
> > +
> > +static struct regulator_init_data zoom_vpll2 = {
> > +	.constraints = {
> > +		.min_uV                 = 1800000,
> > +		.max_uV                 = 1800000,
> > +		.valid_modes_mask       = REGULATOR_MODE_NORMAL
> > +					| REGULATOR_MODE_STANDBY,
> > +		.valid_ops_mask         = REGULATOR_CHANGE_MODE
> > +					| REGULATOR_CHANGE_STATUS,
> > +	},
> > +	.num_consumer_supplies  = 1,
> > +	.consumer_supplies      = &zoom_vpll2_supply,
> > +};
> > +
> > +static struct regulator_init_data zoom_vdac = {
> > +	.constraints = {
> > +		.min_uV                 = 1800000,
> > +		.max_uV                 = 1800000,
> > +		.valid_modes_mask       = REGULATOR_MODE_NORMAL
> > +					| REGULATOR_MODE_STANDBY,
> > +		.valid_ops_mask         = REGULATOR_CHANGE_MODE
> > +					| REGULATOR_CHANGE_STATUS,
> > +	},
> > +	.num_consumer_supplies  = 1,
> > +	.consumer_supplies      = &zoom_vdda_dac_supply,
> > +};
> > +
> >  static int zoom_twl_gpio_setup(struct device *dev,
> >  		unsigned gpio, unsigned ngpio)
> >  {
> > +	int ret;
> > +
> >  	/* gpio + 0 is "mmc0_cd" (input/IRQ) */
> >  	mmc[0].gpio_cd = gpio + 0;
> >  	omap2_hsmmc_init(mmc);
> > @@ -185,7 +221,15 @@ static int zoom_twl_gpio_setup(struct device *dev,
> >  	zoom_vsim_supply.dev = mmc[0].dev;
> >  	zoom_vmmc2_supply.dev = mmc[1].dev;
> >
> > -	return 0;
> > +	ret = gpio_request(LCD_PANEL_ENABLE_GPIO, "lcd enable");
> > +	if (ret) {
> > +		pr_err("Failed to get LCD_PANEL_ENABLE_GPIO (gpio%d).\n",
> > +				LCD_PANEL_ENABLE_GPIO);
> > +		return ret;
> > +	}
> > +	gpio_direction_output(LCD_PANEL_ENABLE_GPIO, 1);
> > +
> [Hiremath, Vaibhav] Ditto here.
> > +	return ret;
> >  }
> >
> >
> > @@ -243,6 +287,8 @@ static struct twl4030_platform_data zoom_twldata = {
> >  	.vmmc1          = &zoom_vmmc1,
> >  	.vmmc2          = &zoom_vmmc2,
> >  	.vsim           = &zoom_vsim,
> > +	.vpll2		= &zoom_vpll2,
> > +	.vdac		= &zoom_vdac,
> >
> >  };
> >
> > diff --git a/arch/arm/mach-omap2/include/mach/board-zoom.h
> b/arch/arm/mach-
> > omap2/include/mach/board-zoom.h
> > index c93b29e..aec73b4 100644
> > --- a/arch/arm/mach-omap2/include/mach/board-zoom.h
> > +++ b/arch/arm/mach-omap2/include/mach/board-zoom.h
> > @@ -1,5 +1,8 @@
> >  /*
> >   * Defines for zoom boards
> >   */
> > +#include <plat/display.h>
> > +
> >  extern int __init zoom_debugboard_init(void);
> >  extern void __init zoom_peripherals_init(void);
> > +extern void __init zoom_display_init(enum omap_dss_venc_type
> venc_type);
> > --
> > 1.5.6.3
> >
> >
> > Regards,
> > Kishore Y
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html

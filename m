From: Archit Taneja <archit@ti.com>
Subject: Re: [PATCHv2 2/4] OMAP: 2420SDP: Port the display driver to new DSS2
Date: Mon, 12 Sep 2011 17:18:00 +0530
Message-ID: <4E6DF170.20303@ti.com>
References: <1315826494-27993-1-git-send-email-tomi.valkeinen@ti.com> <1315826494-27993-3-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:44233 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752194Ab1ILLrK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 Sep 2011 07:47:10 -0400
In-Reply-To: <1315826494-27993-3-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Valkeinen, Tomi" <tomi.valkeinen@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Hunyue Yau <hyau@mvista.com>

On Monday 12 September 2011 04:51 PM, Valkeinen, Tomi wrote:
> Port the old omapfb panel driver for 2420SDP to DSS2.

Minor comment: The subject and commit message say 2420SDP, but patch 
says 2430SDP.

I'll try to find the name of the panel.

Archit

>
> Cc: Hunyue Yau<hyau@mvista.com>
> Signed-off-by: Tomi Valkeinen<tomi.valkeinen@ti.com>
> ---
>   drivers/video/omap/Makefile                      |    2 -
>   drivers/video/omap/lcd_2430sdp.c                 |  203 ----------------------
>   drivers/video/omap2/displays/panel-generic-dpi.c |   21 +++
>   3 files changed, 21 insertions(+), 205 deletions(-)
>   delete mode 100644 drivers/video/omap/lcd_2430sdp.c
>
> diff --git a/drivers/video/omap/Makefile b/drivers/video/omap/Makefile
> index 37c03c2..43eb64a 100644
> --- a/drivers/video/omap/Makefile
> +++ b/drivers/video/omap/Makefile
> @@ -27,8 +27,6 @@ objs-$(CONFIG_ARCH_OMAP15XX)$(CONFIG_MACH_OMAP_INNOVATOR) += lcd_inn1510.o
>   objs-y$(CONFIG_MACH_OMAP_OSK) += lcd_osk.o
>
>   objs-y$(CONFIG_MACH_OMAP_APOLLON) += lcd_apollon.o
> -objs-y$(CONFIG_MACH_OMAP_2430SDP) += lcd_2430sdp.o
> -objs-y$(CONFIG_MACH_OMAP_3430SDP) += lcd_2430sdp.o
>   objs-y$(CONFIG_FB_OMAP_LCD_MIPID) += lcd_mipid.o
>   objs-y$(CONFIG_MACH_HERALD) += lcd_htcherald.o
>
> diff --git a/drivers/video/omap/lcd_2430sdp.c b/drivers/video/omap/lcd_2430sdp.c
> deleted file mode 100644
> index e3eccc9..0000000
> --- a/drivers/video/omap/lcd_2430sdp.c
> +++ /dev/null
> @@ -1,203 +0,0 @@
> -/*
> - * LCD panel support for the TI 2430SDP board
> - *
> - * Copyright (C) 2007 MontaVista
> - * Author: Hunyue Yau<hyau@mvista.com>
> - *
> - * Derived from drivers/video/omap/lcd-apollon.c
> - *
> - * This program is free software; you can redistribute it and/or modify it
> - * under the terms of the GNU General Public License as published by the
> - * Free Software Foundation; either version 2 of the License, or (at your
> - * option) any later version.
> - *
> - * This program is distributed in the hope that it will be useful, but
> - * WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> - * General Public License for more details.
> - *
> - * You should have received a copy of the GNU General Public License along
> - * with this program; if not, write to the Free Software Foundation, Inc.,
> - * 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
> - */
> -
> -#include<linux/module.h>
> -#include<linux/platform_device.h>
> -#include<linux/delay.h>
> -#include<linux/gpio.h>
> -#include<linux/i2c/twl.h>
> -
> -#include<plat/mux.h>
> -#include<asm/mach-types.h>
> -
> -#include "omapfb.h"
> -
> -#define SDP2430_LCD_PANEL_BACKLIGHT_GPIO	91
> -#define SDP2430_LCD_PANEL_ENABLE_GPIO		154
> -#define SDP3430_LCD_PANEL_BACKLIGHT_GPIO	24
> -#define SDP3430_LCD_PANEL_ENABLE_GPIO		28
> -
> -static unsigned backlight_gpio;
> -static unsigned enable_gpio;
> -
> -#define LCD_PIXCLOCK_MAX		5400 /* freq 5.4 MHz */
> -#define PM_RECEIVER             TWL4030_MODULE_PM_RECEIVER
> -#define ENABLE_VAUX2_DEDICATED  0x09
> -#define ENABLE_VAUX2_DEV_GRP    0x20
> -#define ENABLE_VAUX3_DEDICATED	0x03
> -#define ENABLE_VAUX3_DEV_GRP	0x20
> -
> -#define ENABLE_VPLL2_DEDICATED          0x05
> -#define ENABLE_VPLL2_DEV_GRP            0xE0
> -#define TWL4030_VPLL2_DEV_GRP           0x33
> -#define TWL4030_VPLL2_DEDICATED         0x36
> -
> -#define t2_out(c, r, v) twl_i2c_write_u8(c, r, v)
> -
> -
> -static int sdp2430_panel_init(struct lcd_panel *panel,
> -				struct omapfb_device *fbdev)
> -{
> -	if (machine_is_omap_3430sdp()) {
> -		enable_gpio    = SDP3430_LCD_PANEL_ENABLE_GPIO;
> -		backlight_gpio = SDP3430_LCD_PANEL_BACKLIGHT_GPIO;
> -	} else {
> -		enable_gpio    = SDP2430_LCD_PANEL_ENABLE_GPIO;
> -		backlight_gpio = SDP2430_LCD_PANEL_BACKLIGHT_GPIO;
> -	}
> -
> -	gpio_request(enable_gpio, "LCD enable");	/* LCD panel */
> -	gpio_request(backlight_gpio, "LCD bl");		/* LCD backlight */
> -	gpio_direction_output(enable_gpio, 0);
> -	gpio_direction_output(backlight_gpio, 0);
> -
> -	return 0;
> -}
> -
> -static void sdp2430_panel_cleanup(struct lcd_panel *panel)
> -{
> -	gpio_free(backlight_gpio);
> -	gpio_free(enable_gpio);
> -}
> -
> -static int sdp2430_panel_enable(struct lcd_panel *panel)
> -{
> -	u8 ded_val, ded_reg;
> -	u8 grp_val, grp_reg;
> -
> -	if (machine_is_omap_3430sdp()) {
> -		ded_reg = TWL4030_VAUX3_DEDICATED;
> -		ded_val = ENABLE_VAUX3_DEDICATED;
> -		grp_reg = TWL4030_VAUX3_DEV_GRP;
> -		grp_val = ENABLE_VAUX3_DEV_GRP;
> -
> -		if (omap_rev()>  OMAP3430_REV_ES1_0) {
> -			t2_out(PM_RECEIVER, ENABLE_VPLL2_DEDICATED,
> -					TWL4030_VPLL2_DEDICATED);
> -			t2_out(PM_RECEIVER, ENABLE_VPLL2_DEV_GRP,
> -					TWL4030_VPLL2_DEV_GRP);
> -		}
> -	} else {
> -		ded_reg = TWL4030_VAUX2_DEDICATED;
> -		ded_val = ENABLE_VAUX2_DEDICATED;
> -		grp_reg = TWL4030_VAUX2_DEV_GRP;
> -		grp_val = ENABLE_VAUX2_DEV_GRP;
> -	}
> -
> -	gpio_set_value(enable_gpio, 1);
> -	gpio_set_value(backlight_gpio, 1);
> -
> -	if (0 != t2_out(PM_RECEIVER, ded_val, ded_reg))
> -		return -EIO;
> -	if (0 != t2_out(PM_RECEIVER, grp_val, grp_reg))
> -		return -EIO;
> -
> -	return 0;
> -}
> -
> -static void sdp2430_panel_disable(struct lcd_panel *panel)
> -{
> -	gpio_set_value(enable_gpio, 0);
> -	gpio_set_value(backlight_gpio, 0);
> -	if (omap_rev()>  OMAP3430_REV_ES1_0) {
> -		t2_out(PM_RECEIVER, 0x0, TWL4030_VPLL2_DEDICATED);
> -		t2_out(PM_RECEIVER, 0x0, TWL4030_VPLL2_DEV_GRP);
> -		msleep(4);
> -	}
> -}
> -
> -static unsigned long sdp2430_panel_get_caps(struct lcd_panel *panel)
> -{
> -	return 0;
> -}
> -
> -struct lcd_panel sdp2430_panel = {
> -	.name		= "sdp2430",
> -	.config		= OMAP_LCDC_PANEL_TFT | OMAP_LCDC_INV_VSYNC |
> -			  OMAP_LCDC_INV_HSYNC,
> -
> -	.bpp		= 16,
> -	.data_lines	= 16,
> -	.x_res		= 240,
> -	.y_res		= 320,
> -	.hsw		= 3,		/* hsync_len (4) - 1 */
> -	.hfp		= 3,		/* right_margin (4) - 1 */
> -	.hbp		= 39,		/* left_margin (40) - 1 */
> -	.vsw		= 1,		/* vsync_len (2) - 1 */
> -	.vfp		= 2,		/* lower_margin */
> -	.vbp		= 7,		/* upper_margin (8) - 1 */
> -
> -	.pixel_clock	= LCD_PIXCLOCK_MAX,
> -
> -	.init		= sdp2430_panel_init,
> -	.cleanup	= sdp2430_panel_cleanup,
> -	.enable		= sdp2430_panel_enable,
> -	.disable	= sdp2430_panel_disable,
> -	.get_caps	= sdp2430_panel_get_caps,
> -};
> -
> -static int sdp2430_panel_probe(struct platform_device *pdev)
> -{
> -	omapfb_register_panel(&sdp2430_panel);
> -	return 0;
> -}
> -
> -static int sdp2430_panel_remove(struct platform_device *pdev)
> -{
> -	return 0;
> -}
> -
> -static int sdp2430_panel_suspend(struct platform_device *pdev,
> -					pm_message_t mesg)
> -{
> -	return 0;
> -}
> -
> -static int sdp2430_panel_resume(struct platform_device *pdev)
> -{
> -	return 0;
> -}
> -
> -struct platform_driver sdp2430_panel_driver = {
> -	.probe		= sdp2430_panel_probe,
> -	.remove		= sdp2430_panel_remove,
> -	.suspend	= sdp2430_panel_suspend,
> -	.resume		= sdp2430_panel_resume,
> -	.driver		= {
> -		.name	= "sdp2430_lcd",
> -		.owner	= THIS_MODULE,
> -	},
> -};
> -
> -static int __init sdp2430_panel_drv_init(void)
> -{
> -	return platform_driver_register(&sdp2430_panel_driver);
> -}
> -
> -static void __exit sdp2430_panel_drv_exit(void)
> -{
> -	platform_driver_unregister(&sdp2430_panel_driver);
> -}
> -
> -module_init(sdp2430_panel_drv_init);
> -module_exit(sdp2430_panel_drv_exit);
> diff --git a/drivers/video/omap2/displays/panel-generic-dpi.c b/drivers/video/omap2/displays/panel-generic-dpi.c
> index b401304..0a4d340 100644
> --- a/drivers/video/omap2/displays/panel-generic-dpi.c
> +++ b/drivers/video/omap2/displays/panel-generic-dpi.c
> @@ -257,6 +257,27 @@ static struct panel_config generic_dpi_panels[] = {
>   		.power_off_delay	= 0,
>   		.name			= "innolux_at070tn83",
>   	},
> +
> +	/* Unknown panel used in OMAP 2430 SDP */
> +	{
> +		{
> +			.x_res		= 240,
> +			.y_res		= 320,
> +
> +			.pixel_clock	= 5400,
> +
> +			.hsw		= 3,
> +			.hfp		= 3,
> +			.hbp		= 39,
> +
> +			.vsw		= 1,
> +			.vfp		= 2,
> +			.vbp		= 7,
> +		},
> +		.config			= OMAP_DSS_LCD_TFT | OMAP_DSS_LCD_IVS |
> +						OMAP_DSS_LCD_IHS,
> +		.name			= "2430sdp",
> +	},
>   };
>
>   struct panel_drv_data {


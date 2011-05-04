From: Koen Kooi <koen@dominion.thruhere.net>
Subject: Re: [PATCH 1/7] OMAP: OMAPFB: Remove unused lcd drivers
Date: Wed, 4 May 2011 15:43:47 +0200
Message-ID: <0AF1D4D2-6F7E-41D8-AC0A-16AF5D355A1E@dominion.thruhere.net>
References: <1304512059-10372-1-git-send-email-tomi.valkeinen@ti.com> <1304512059-10372-2-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:39810 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752128Ab1EDNnx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 May 2011 09:43:53 -0400
In-Reply-To: <1304512059-10372-2-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Arun C <arunedarath@mistralsolutions.com>, Koen Kooi <koen@openembedded.org>, Steve Sakoman <steve@sakoman.com>


Op 4 mei 2011, om 14:27 heeft Tomi Valkeinen het volgende geschreven:

> drivers/video/omap/ contains some lcd drivers which are not used by any
> board. They can be removed.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Cc: Arun C <arunedarath@mistralsolutions.com>
> Cc: Koen Kooi <koen@openembedded.org>
> Cc: Steve Sakoman <steve@sakoman.com>

Acked-by: Koen Kooi <koen@openembedded.org>

> ---
> drivers/video/omap/Makefile          |    4 -
> drivers/video/omap/lcd_omap2evm.c    |  192 ---------------------------------
> drivers/video/omap/lcd_omap3beagle.c |  130 -----------------------
> drivers/video/omap/lcd_omap3evm.c    |  193 ----------------------------------
> drivers/video/omap/lcd_overo.c       |  180 -------------------------------
> 5 files changed, 0 insertions(+), 699 deletions(-)
> delete mode 100644 drivers/video/omap/lcd_omap2evm.c
> delete mode 100644 drivers/video/omap/lcd_omap3beagle.c
> delete mode 100644 drivers/video/omap/lcd_omap3evm.c
> delete mode 100644 drivers/video/omap/lcd_overo.c
> 
> diff --git a/drivers/video/omap/Makefile b/drivers/video/omap/Makefile
> index 49226a1..8eec6d7 100644
> --- a/drivers/video/omap/Makefile
> +++ b/drivers/video/omap/Makefile
> @@ -30,11 +30,7 @@ objs-y$(CONFIG_MACH_OMAP_APOLLON) += lcd_apollon.o
> objs-y$(CONFIG_MACH_OMAP_2430SDP) += lcd_2430sdp.o
> objs-y$(CONFIG_MACH_OMAP_3430SDP) += lcd_2430sdp.o
> objs-y$(CONFIG_MACH_OMAP_LDP) += lcd_ldp.o
> -objs-y$(CONFIG_MACH_OMAP2EVM) += lcd_omap2evm.o
> -objs-y$(CONFIG_MACH_OMAP3EVM) += lcd_omap3evm.o
> -objs-y$(CONFIG_MACH_OMAP3_BEAGLE) += lcd_omap3beagle.o
> objs-y$(CONFIG_FB_OMAP_LCD_MIPID) += lcd_mipid.o
> -objs-y$(CONFIG_MACH_OVERO) += lcd_overo.o
> objs-y$(CONFIG_MACH_HERALD) += lcd_htcherald.o
> 
> omapfb-objs := $(objs-yy)
> diff --git a/drivers/video/omap/lcd_omap2evm.c b/drivers/video/omap/lcd_omap2evm.c
> deleted file mode 100644
> index 7e7a65c..0000000
> --- a/drivers/video/omap/lcd_omap2evm.c
> +++ /dev/null
> @@ -1,192 +0,0 @@
> -/*
> - * LCD panel support for the MISTRAL OMAP2EVM board
> - *
> - * Author: Arun C <arunedarath@mistralsolutions.com>
> - *
> - * Derived from drivers/video/omap/lcd_omap3evm.c
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
> -#include <linux/module.h>
> -#include <linux/platform_device.h>
> -#include <linux/gpio.h>
> -#include <linux/i2c/twl.h>
> -
> -#include <plat/mux.h>
> -#include <asm/mach-types.h>
> -
> -#include "omapfb.h"
> -
> -#define LCD_PANEL_ENABLE_GPIO	154
> -#define LCD_PANEL_LR		128
> -#define LCD_PANEL_UD		129
> -#define LCD_PANEL_INI		152
> -#define LCD_PANEL_QVGA		148
> -#define LCD_PANEL_RESB		153
> -
> -#define TWL_LED_LEDEN		0x00
> -#define TWL_PWMA_PWMAON		0x00
> -#define TWL_PWMA_PWMAOFF	0x01
> -
> -static unsigned int bklight_level;
> -
> -static int omap2evm_panel_init(struct lcd_panel *panel,
> -				struct omapfb_device *fbdev)
> -{
> -	gpio_request(LCD_PANEL_ENABLE_GPIO, "LCD enable");
> -	gpio_request(LCD_PANEL_LR, "LCD lr");
> -	gpio_request(LCD_PANEL_UD, "LCD ud");
> -	gpio_request(LCD_PANEL_INI, "LCD ini");
> -	gpio_request(LCD_PANEL_QVGA, "LCD qvga");
> -	gpio_request(LCD_PANEL_RESB, "LCD resb");
> -
> -	gpio_direction_output(LCD_PANEL_ENABLE_GPIO, 1);
> -	gpio_direction_output(LCD_PANEL_RESB, 1);
> -	gpio_direction_output(LCD_PANEL_INI, 1);
> -	gpio_direction_output(LCD_PANEL_QVGA, 0);
> -	gpio_direction_output(LCD_PANEL_LR, 1);
> -	gpio_direction_output(LCD_PANEL_UD, 1);
> -
> -	twl_i2c_write_u8(TWL4030_MODULE_LED, 0x11, TWL_LED_LEDEN);
> -	twl_i2c_write_u8(TWL4030_MODULE_PWMA, 0x01, TWL_PWMA_PWMAON);
> -	twl_i2c_write_u8(TWL4030_MODULE_PWMA, 0x02, TWL_PWMA_PWMAOFF);
> -	bklight_level = 100;
> -
> -	return 0;
> -}
> -
> -static void omap2evm_panel_cleanup(struct lcd_panel *panel)
> -{
> -	gpio_free(LCD_PANEL_RESB);
> -	gpio_free(LCD_PANEL_QVGA);
> -	gpio_free(LCD_PANEL_INI);
> -	gpio_free(LCD_PANEL_UD);
> -	gpio_free(LCD_PANEL_LR);
> -	gpio_free(LCD_PANEL_ENABLE_GPIO);
> -}
> -
> -static int omap2evm_panel_enable(struct lcd_panel *panel)
> -{
> -	gpio_set_value(LCD_PANEL_ENABLE_GPIO, 0);
> -	return 0;
> -}
> -
> -static void omap2evm_panel_disable(struct lcd_panel *panel)
> -{
> -	gpio_set_value(LCD_PANEL_ENABLE_GPIO, 1);
> -}
> -
> -static unsigned long omap2evm_panel_get_caps(struct lcd_panel *panel)
> -{
> -	return 0;
> -}
> -
> -static int omap2evm_bklight_setlevel(struct lcd_panel *panel,
> -						unsigned int level)
> -{
> -	u8 c;
> -	if ((level >= 0) && (level <= 100)) {
> -		c = (125 * (100 - level)) / 100 + 2;
> -		twl_i2c_write_u8(TWL4030_MODULE_PWMA, c, TWL_PWMA_PWMAOFF);
> -		bklight_level = level;
> -	}
> -	return 0;
> -}
> -
> -static unsigned int omap2evm_bklight_getlevel(struct lcd_panel *panel)
> -{
> -	return bklight_level;
> -}
> -
> -static unsigned int omap2evm_bklight_getmaxlevel(struct lcd_panel *panel)
> -{
> -	return 100;
> -}
> -
> -struct lcd_panel omap2evm_panel = {
> -	.name		= "omap2evm",
> -	.config		= OMAP_LCDC_PANEL_TFT | OMAP_LCDC_INV_VSYNC |
> -			  OMAP_LCDC_INV_HSYNC,
> -
> -	.bpp		= 16,
> -	.data_lines	= 18,
> -	.x_res		= 480,
> -	.y_res		= 640,
> -	.hsw		= 3,
> -	.hfp		= 0,
> -	.hbp		= 28,
> -	.vsw		= 2,
> -	.vfp		= 1,
> -	.vbp		= 0,
> -
> -	.pixel_clock	= 20000,
> -
> -	.init		= omap2evm_panel_init,
> -	.cleanup	= omap2evm_panel_cleanup,
> -	.enable		= omap2evm_panel_enable,
> -	.disable	= omap2evm_panel_disable,
> -	.get_caps	= omap2evm_panel_get_caps,
> -	.set_bklight_level      = omap2evm_bklight_setlevel,
> -	.get_bklight_level      = omap2evm_bklight_getlevel,
> -	.get_bklight_max        = omap2evm_bklight_getmaxlevel,
> -};
> -
> -static int omap2evm_panel_probe(struct platform_device *pdev)
> -{
> -	omapfb_register_panel(&omap2evm_panel);
> -	return 0;
> -}
> -
> -static int omap2evm_panel_remove(struct platform_device *pdev)
> -{
> -	return 0;
> -}
> -
> -static int omap2evm_panel_suspend(struct platform_device *pdev,
> -				   pm_message_t mesg)
> -{
> -	return 0;
> -}
> -
> -static int omap2evm_panel_resume(struct platform_device *pdev)
> -{
> -	return 0;
> -}
> -
> -struct platform_driver omap2evm_panel_driver = {
> -	.probe		= omap2evm_panel_probe,
> -	.remove		= omap2evm_panel_remove,
> -	.suspend	= omap2evm_panel_suspend,
> -	.resume		= omap2evm_panel_resume,
> -	.driver		= {
> -		.name	= "omap2evm_lcd",
> -		.owner	= THIS_MODULE,
> -	},
> -};
> -
> -static int __init omap2evm_panel_drv_init(void)
> -{
> -	return platform_driver_register(&omap2evm_panel_driver);
> -}
> -
> -static void __exit omap2evm_panel_drv_exit(void)
> -{
> -	platform_driver_unregister(&omap2evm_panel_driver);
> -}
> -
> -module_init(omap2evm_panel_drv_init);
> -module_exit(omap2evm_panel_drv_exit);
> diff --git a/drivers/video/omap/lcd_omap3beagle.c b/drivers/video/omap/lcd_omap3beagle.c
> deleted file mode 100644
> index d7c6c3e..0000000
> --- a/drivers/video/omap/lcd_omap3beagle.c
> +++ /dev/null
> @@ -1,130 +0,0 @@
> -/*
> - * LCD panel support for the TI OMAP3 Beagle board
> - *
> - * Author: Koen Kooi <koen@openembedded.org>
> - *
> - * Derived from drivers/video/omap/lcd-omap3evm.c
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
> -#include <linux/module.h>
> -#include <linux/platform_device.h>
> -#include <linux/gpio.h>
> -#include <linux/i2c/twl.h>
> -
> -#include <asm/mach-types.h>
> -
> -#include "omapfb.h"
> -
> -#define LCD_PANEL_ENABLE_GPIO       170
> -
> -static int omap3beagle_panel_init(struct lcd_panel *panel,
> -				struct omapfb_device *fbdev)
> -{
> -	gpio_request(LCD_PANEL_ENABLE_GPIO, "LCD enable");
> -	return 0;
> -}
> -
> -static void omap3beagle_panel_cleanup(struct lcd_panel *panel)
> -{
> -	gpio_free(LCD_PANEL_ENABLE_GPIO);
> -}
> -
> -static int omap3beagle_panel_enable(struct lcd_panel *panel)
> -{
> -	gpio_set_value(LCD_PANEL_ENABLE_GPIO, 1);
> -	return 0;
> -}
> -
> -static void omap3beagle_panel_disable(struct lcd_panel *panel)
> -{
> -	gpio_set_value(LCD_PANEL_ENABLE_GPIO, 0);
> -}
> -
> -static unsigned long omap3beagle_panel_get_caps(struct lcd_panel *panel)
> -{
> -	return 0;
> -}
> -
> -struct lcd_panel omap3beagle_panel = {
> -	.name		= "omap3beagle",
> -	.config		= OMAP_LCDC_PANEL_TFT,
> -
> -	.bpp		= 16,
> -	.data_lines	= 24,
> -	.x_res		= 1024,
> -	.y_res		= 768,
> -	.hsw		= 3,		/* hsync_len (4) - 1 */
> -	.hfp		= 3,		/* right_margin (4) - 1 */
> -	.hbp		= 39,		/* left_margin (40) - 1 */
> -	.vsw		= 1,		/* vsync_len (2) - 1 */
> -	.vfp		= 2,		/* lower_margin */
> -	.vbp		= 7,		/* upper_margin (8) - 1 */
> -
> -	.pixel_clock	= 64000,
> -
> -	.init		= omap3beagle_panel_init,
> -	.cleanup	= omap3beagle_panel_cleanup,
> -	.enable		= omap3beagle_panel_enable,
> -	.disable	= omap3beagle_panel_disable,
> -	.get_caps	= omap3beagle_panel_get_caps,
> -};
> -
> -static int omap3beagle_panel_probe(struct platform_device *pdev)
> -{
> -	omapfb_register_panel(&omap3beagle_panel);
> -	return 0;
> -}
> -
> -static int omap3beagle_panel_remove(struct platform_device *pdev)
> -{
> -	return 0;
> -}
> -
> -static int omap3beagle_panel_suspend(struct platform_device *pdev,
> -				   pm_message_t mesg)
> -{
> -	return 0;
> -}
> -
> -static int omap3beagle_panel_resume(struct platform_device *pdev)
> -{
> -	return 0;
> -}
> -
> -struct platform_driver omap3beagle_panel_driver = {
> -	.probe		= omap3beagle_panel_probe,
> -	.remove		= omap3beagle_panel_remove,
> -	.suspend	= omap3beagle_panel_suspend,
> -	.resume		= omap3beagle_panel_resume,
> -	.driver		= {
> -		.name	= "omap3beagle_lcd",
> -		.owner	= THIS_MODULE,
> -	},
> -};
> -
> -static int __init omap3beagle_panel_drv_init(void)
> -{
> -	return platform_driver_register(&omap3beagle_panel_driver);
> -}
> -
> -static void __exit omap3beagle_panel_drv_exit(void)
> -{
> -	platform_driver_unregister(&omap3beagle_panel_driver);
> -}
> -
> -module_init(omap3beagle_panel_drv_init);
> -module_exit(omap3beagle_panel_drv_exit);
> diff --git a/drivers/video/omap/lcd_omap3evm.c b/drivers/video/omap/lcd_omap3evm.c
> deleted file mode 100644
> index 06840da..0000000
> --- a/drivers/video/omap/lcd_omap3evm.c
> +++ /dev/null
> @@ -1,193 +0,0 @@
> -/*
> - * LCD panel support for the TI OMAP3 EVM board
> - *
> - * Author: Steve Sakoman <steve@sakoman.com>
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
> -#include <linux/module.h>
> -#include <linux/platform_device.h>
> -#include <linux/gpio.h>
> -#include <linux/i2c/twl.h>
> -
> -#include <plat/mux.h>
> -#include <asm/mach-types.h>
> -
> -#include "omapfb.h"
> -
> -#define LCD_PANEL_ENABLE_GPIO       153
> -#define LCD_PANEL_LR                2
> -#define LCD_PANEL_UD                3
> -#define LCD_PANEL_INI               152
> -#define LCD_PANEL_QVGA              154
> -#define LCD_PANEL_RESB              155
> -
> -#define ENABLE_VDAC_DEDICATED	0x03
> -#define ENABLE_VDAC_DEV_GRP	0x20
> -#define ENABLE_VPLL2_DEDICATED	0x05
> -#define ENABLE_VPLL2_DEV_GRP	0xE0
> -
> -#define TWL_LED_LEDEN		0x00
> -#define TWL_PWMA_PWMAON		0x00
> -#define TWL_PWMA_PWMAOFF	0x01
> -
> -static unsigned int bklight_level;
> -
> -static int omap3evm_panel_init(struct lcd_panel *panel,
> -				struct omapfb_device *fbdev)
> -{
> -	gpio_request(LCD_PANEL_LR, "LCD lr");
> -	gpio_request(LCD_PANEL_UD, "LCD ud");
> -	gpio_request(LCD_PANEL_INI, "LCD ini");
> -	gpio_request(LCD_PANEL_RESB, "LCD resb");
> -	gpio_request(LCD_PANEL_QVGA, "LCD qvga");
> -
> -	gpio_direction_output(LCD_PANEL_RESB, 1);
> -	gpio_direction_output(LCD_PANEL_INI, 1);
> -	gpio_direction_output(LCD_PANEL_QVGA, 0);
> -	gpio_direction_output(LCD_PANEL_LR, 1);
> -	gpio_direction_output(LCD_PANEL_UD, 1);
> -
> -	twl_i2c_write_u8(TWL4030_MODULE_LED, 0x11, TWL_LED_LEDEN);
> -	twl_i2c_write_u8(TWL4030_MODULE_PWMA, 0x01, TWL_PWMA_PWMAON);
> -	twl_i2c_write_u8(TWL4030_MODULE_PWMA, 0x02, TWL_PWMA_PWMAOFF);
> -	bklight_level = 100;
> -
> -	return 0;
> -}
> -
> -static void omap3evm_panel_cleanup(struct lcd_panel *panel)
> -{
> -	gpio_free(LCD_PANEL_QVGA);
> -	gpio_free(LCD_PANEL_RESB);
> -	gpio_free(LCD_PANEL_INI);
> -	gpio_free(LCD_PANEL_UD);
> -	gpio_free(LCD_PANEL_LR);
> -}
> -
> -static int omap3evm_panel_enable(struct lcd_panel *panel)
> -{
> -	gpio_set_value(LCD_PANEL_ENABLE_GPIO, 0);
> -	return 0;
> -}
> -
> -static void omap3evm_panel_disable(struct lcd_panel *panel)
> -{
> -	gpio_set_value(LCD_PANEL_ENABLE_GPIO, 1);
> -}
> -
> -static unsigned long omap3evm_panel_get_caps(struct lcd_panel *panel)
> -{
> -	return 0;
> -}
> -
> -static int omap3evm_bklight_setlevel(struct lcd_panel *panel,
> -						unsigned int level)
> -{
> -	u8 c;
> -	if ((level >= 0) && (level <= 100)) {
> -		c = (125 * (100 - level)) / 100 + 2;
> -		twl_i2c_write_u8(TWL4030_MODULE_PWMA, c, TWL_PWMA_PWMAOFF);
> -		bklight_level = level;
> -	}
> -	return 0;
> -}
> -
> -static unsigned int omap3evm_bklight_getlevel(struct lcd_panel *panel)
> -{
> -	return bklight_level;
> -}
> -
> -static unsigned int omap3evm_bklight_getmaxlevel(struct lcd_panel *panel)
> -{
> -	return 100;
> -}
> -
> -struct lcd_panel omap3evm_panel = {
> -	.name		= "omap3evm",
> -	.config		= OMAP_LCDC_PANEL_TFT | OMAP_LCDC_INV_VSYNC |
> -			  OMAP_LCDC_INV_HSYNC,
> -
> -	.bpp		= 16,
> -	.data_lines	= 18,
> -	.x_res		= 480,
> -	.y_res		= 640,
> -	.hsw		= 3,		/* hsync_len (4) - 1 */
> -	.hfp		= 3,		/* right_margin (4) - 1 */
> -	.hbp		= 39,		/* left_margin (40) - 1 */
> -	.vsw		= 1,		/* vsync_len (2) - 1 */
> -	.vfp		= 2,		/* lower_margin */
> -	.vbp		= 7,		/* upper_margin (8) - 1 */
> -
> -	.pixel_clock	= 26000,
> -
> -	.init		= omap3evm_panel_init,
> -	.cleanup	= omap3evm_panel_cleanup,
> -	.enable		= omap3evm_panel_enable,
> -	.disable	= omap3evm_panel_disable,
> -	.get_caps	= omap3evm_panel_get_caps,
> -	.set_bklight_level      = omap3evm_bklight_setlevel,
> -	.get_bklight_level      = omap3evm_bklight_getlevel,
> -	.get_bklight_max        = omap3evm_bklight_getmaxlevel,
> -};
> -
> -static int omap3evm_panel_probe(struct platform_device *pdev)
> -{
> -	omapfb_register_panel(&omap3evm_panel);
> -	return 0;
> -}
> -
> -static int omap3evm_panel_remove(struct platform_device *pdev)
> -{
> -	return 0;
> -}
> -
> -static int omap3evm_panel_suspend(struct platform_device *pdev,
> -				   pm_message_t mesg)
> -{
> -	return 0;
> -}
> -
> -static int omap3evm_panel_resume(struct platform_device *pdev)
> -{
> -	return 0;
> -}
> -
> -struct platform_driver omap3evm_panel_driver = {
> -	.probe		= omap3evm_panel_probe,
> -	.remove		= omap3evm_panel_remove,
> -	.suspend	= omap3evm_panel_suspend,
> -	.resume		= omap3evm_panel_resume,
> -	.driver		= {
> -		.name	= "omap3evm_lcd",
> -		.owner	= THIS_MODULE,
> -	},
> -};
> -
> -static int __init omap3evm_panel_drv_init(void)
> -{
> -	return platform_driver_register(&omap3evm_panel_driver);
> -}
> -
> -static void __exit omap3evm_panel_drv_exit(void)
> -{
> -	platform_driver_unregister(&omap3evm_panel_driver);
> -}
> -
> -module_init(omap3evm_panel_drv_init);
> -module_exit(omap3evm_panel_drv_exit);
> diff --git a/drivers/video/omap/lcd_overo.c b/drivers/video/omap/lcd_overo.c
> deleted file mode 100644
> index 564933f..0000000
> --- a/drivers/video/omap/lcd_overo.c
> +++ /dev/null
> @@ -1,180 +0,0 @@
> -/*
> - * LCD panel support for the Gumstix Overo
> - *
> - * Author: Steve Sakoman <steve@sakoman.com>
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
> - *
> - */
> -
> -#include <linux/module.h>
> -#include <linux/platform_device.h>
> -#include <linux/i2c/twl.h>
> -
> -#include <mach/gpio.h>
> -#include <plat/mux.h>
> -#include <asm/mach-types.h>
> -
> -#include "omapfb.h"
> -
> -#define LCD_ENABLE       144
> -
> -static int overo_panel_init(struct lcd_panel *panel,
> -				struct omapfb_device *fbdev)
> -{
> -	if ((gpio_request(LCD_ENABLE, "LCD_ENABLE") == 0) &&
> -	    (gpio_direction_output(LCD_ENABLE, 1) == 0))
> -		gpio_export(LCD_ENABLE, 0);
> -	else
> -		printk(KERN_ERR "could not obtain gpio for LCD_ENABLE\n");
> -
> -	return 0;
> -}
> -
> -static void overo_panel_cleanup(struct lcd_panel *panel)
> -{
> -	gpio_free(LCD_ENABLE);
> -}
> -
> -static int overo_panel_enable(struct lcd_panel *panel)
> -{
> -	gpio_set_value(LCD_ENABLE, 1);
> -	return 0;
> -}
> -
> -static void overo_panel_disable(struct lcd_panel *panel)
> -{
> -	gpio_set_value(LCD_ENABLE, 0);
> -}
> -
> -static unsigned long overo_panel_get_caps(struct lcd_panel *panel)
> -{
> -	return 0;
> -}
> -
> -struct lcd_panel overo_panel = {
> -	.name		= "overo",
> -	.config		= OMAP_LCDC_PANEL_TFT,
> -	.bpp		= 16,
> -	.data_lines	= 24,
> -
> -#if defined CONFIG_FB_OMAP_031M3R
> -
> -	/* 640 x 480 @ 60 Hz  Reduced blanking VESA CVT 0.31M3-R */
> -	.x_res		= 640,
> -	.y_res		= 480,
> -	.hfp		= 48,
> -	.hsw		= 32,
> -	.hbp		= 80,
> -	.vfp		= 3,
> -	.vsw		= 4,
> -	.vbp		= 7,
> -	.pixel_clock	= 23500,
> -
> -#elif defined CONFIG_FB_OMAP_048M3R
> -
> -	/* 800 x 600 @ 60 Hz  Reduced blanking VESA CVT 0.48M3-R */
> -	.x_res		= 800,
> -	.y_res		= 600,
> -	.hfp		= 48,
> -	.hsw		= 32,
> -	.hbp		= 80,
> -	.vfp		= 3,
> -	.vsw		= 4,
> -	.vbp		= 11,
> -	.pixel_clock	= 35500,
> -
> -#elif defined CONFIG_FB_OMAP_079M3R
> -
> -	/* 1024 x 768 @ 60 Hz  Reduced blanking VESA CVT 0.79M3-R */
> -	.x_res		= 1024,
> -	.y_res		= 768,
> -	.hfp		= 48,
> -	.hsw		= 32,
> -	.hbp		= 80,
> -	.vfp		= 3,
> -	.vsw		= 4,
> -	.vbp		= 15,
> -	.pixel_clock	= 56000,
> -
> -#elif defined CONFIG_FB_OMAP_092M9R
> -
> -	/* 1280 x 720 @ 60 Hz  Reduced blanking VESA CVT 0.92M9-R */
> -	.x_res		= 1280,
> -	.y_res		= 720,
> -	.hfp		= 48,
> -	.hsw		= 32,
> -	.hbp		= 80,
> -	.vfp		= 3,
> -	.vsw		= 5,
> -	.vbp		= 13,
> -	.pixel_clock	= 64000,
> -
> -#else
> -
> -	/* use 640 x 480 if no config option */
> -	/* 640 x 480 @ 60 Hz  Reduced blanking VESA CVT 0.31M3-R */
> -	.x_res		= 640,
> -	.y_res		= 480,
> -	.hfp		= 48,
> -	.hsw		= 32,
> -	.hbp		= 80,
> -	.vfp		= 3,
> -	.vsw		= 4,
> -	.vbp		= 7,
> -	.pixel_clock	= 23500,
> -
> -#endif
> -
> -	.init		= overo_panel_init,
> -	.cleanup	= overo_panel_cleanup,
> -	.enable		= overo_panel_enable,
> -	.disable	= overo_panel_disable,
> -	.get_caps	= overo_panel_get_caps,
> -};
> -
> -static int overo_panel_probe(struct platform_device *pdev)
> -{
> -	omapfb_register_panel(&overo_panel);
> -	return 0;
> -}
> -
> -static int overo_panel_remove(struct platform_device *pdev)
> -{
> -	/* omapfb does not have unregister_panel */
> -	return 0;
> -}
> -
> -static struct platform_driver overo_panel_driver = {
> -	.probe		= overo_panel_probe,
> -	.remove		= overo_panel_remove,
> -	.driver		= {
> -		.name	= "overo_lcd",
> -		.owner	= THIS_MODULE,
> -	},
> -};
> -
> -static int __init overo_panel_drv_init(void)
> -{
> -	return platform_driver_register(&overo_panel_driver);
> -}
> -
> -static void __exit overo_panel_drv_exit(void)
> -{
> -	platform_driver_unregister(&overo_panel_driver);
> -}
> -
> -module_init(overo_panel_drv_init);
> -module_exit(overo_panel_drv_exit);
> -- 
> 1.7.4.1
> 


From: Imre Deak <imre.deak@nokia.com>
Subject: [PATCH 10/20] omapfb: Add support for the Gumstix Overo LCD
Date: Thu,  4 Jun 2009 20:52:35 +0300
Message-ID: <057471246e776de4c452b4ba2ebf2a4579f3171c.1244131952.git.imre.deak@nokia.com>
References: <1244137965-8937-1-git-send-email-imre.deak@nokia.com>
 <fab39c1a822c428466db6a19531be646d483664e.1244131952.git.imre.deak@nokia.com>
 <e7f92ea9f0a823f7be401e34243754141b7f72c1.1244131952.git.imre.deak@nokia.com>
 <e9040774f324311979aebd3fa5fa71d20890d433.1244131952.git.imre.deak@nokia.com>
 <833ed44e61e3d4093eb27b55b97252967e042d41.1244131952.git.imre.deak@nokia.com>
 <5ba715a9dbc88b8c3a8225bc1cfdabd3faffe00f.1244131952.git.imre.deak@nokia.com>
 <646692ce09a12e1a8a2d4072097b4d440b7de5d5.1244131952.git.imre.deak@nokia.com>
 <b0e578438bb53d9fbf333e5bd10d4d33f869b373.1244131952.git.imre.deak@nokia.com>
 <9139035cc12b22600135677cd5d3096c1dcd286d.1244131952.git.imre.deak@nokia.com>
 <08ba068bda363adf4cb8a1f5afe11245c828d017.1244131952.git.imre.deak@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:21362 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751410AbZFDRzw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Jun 2009 13:55:52 -0400
In-Reply-To: <08ba068bda363adf4cb8a1f5afe11245c828d017.1244131952.git.imre.deak@nokia.com>
In-Reply-To: <fab39c1a822c428466db6a19531be646d483664e.1244131952.git.imre.deak@nokia.com>
References: <fab39c1a822c428466db6a19531be646d483664e.1244131952.git.imre.deak@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Antonino Daplas <adaplas@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Tomi Valkeinen <Tomi.Valkeinen@nokia.com>, Steve Sakoman <steve@sakoman.com>, Imre Deak <imre.deak@nokia.com>

From: Steve Sakoman <steve@sakoman.com>

Signed-off-by: Steve Sakoman <steve@sakoman.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Imre Deak <imre.deak@nokia.com>
---
 drivers/video/omap/Kconfig     |   21 +++++
 drivers/video/omap/Makefile    |    1 +
 drivers/video/omap/lcd_overo.c |  179 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 201 insertions(+), 0 deletions(-)
 create mode 100644 drivers/video/omap/lcd_overo.c

diff --git a/drivers/video/omap/Kconfig b/drivers/video/omap/Kconfig
index 574453f..eb05e09 100644
--- a/drivers/video/omap/Kconfig
+++ b/drivers/video/omap/Kconfig
@@ -7,6 +7,27 @@ config FB_OMAP
 	help
           Frame buffer driver for OMAP based boards.
 
+choice
+	depends on FB_OMAP && MACH_OVERO
+	prompt "Screen resolution"
+	default FB_OMAP_079M3R
+	help
+	  Selected desired screen resolution
+
+config FB_OMAP_031M3R
+	boolean "640 x 480 @ 60 Hz Reduced blanking"
+
+config FB_OMAP_048M3R
+	boolean "800 x 600 @ 60 Hz Reduced blanking"
+
+config FB_OMAP_079M3R
+	boolean "1024 x 768 @ 60 Hz Reduced blanking"
+
+config FB_OMAP_092M9R
+	boolean "1280 x 720 @ 60 Hz Reduced blanking"
+
+endchoice
+
 config FB_OMAP_LCD_MIPID
 	bool "MIPI DBI-C/DCS compatible LCD support"
 	depends on FB_OMAP && SPI_MASTER
diff --git a/drivers/video/omap/Makefile b/drivers/video/omap/Makefile
index 9ff1815..0d2996a 100644
--- a/drivers/video/omap/Makefile
+++ b/drivers/video/omap/Makefile
@@ -33,6 +33,7 @@ objs-y$(CONFIG_MACH_OMAP2EVM) += lcd_omap2evm.o
 objs-y$(CONFIG_MACH_OMAP3EVM) += lcd_omap3evm.o
 objs-y$(CONFIG_MACH_OMAP3_BEAGLE) += lcd_omap3beagle.o
 objs-y$(CONFIG_FB_OMAP_LCD_MIPID) += lcd_mipid.o
+objs-y$(CONFIG_MACH_OVERO) += lcd_overo.o
 
 omapfb-objs := $(objs-yy)
 
diff --git a/drivers/video/omap/lcd_overo.c b/drivers/video/omap/lcd_overo.c
new file mode 100644
index 0000000..2bc5c92
--- /dev/null
+++ b/drivers/video/omap/lcd_overo.c
@@ -0,0 +1,179 @@
+/*
+ * LCD panel support for the Gumstix Overo
+ *
+ * Author: Steve Sakoman <steve@sakoman.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/i2c/twl4030.h>
+
+#include <mach/gpio.h>
+#include <mach/mux.h>
+#include <mach/omapfb.h>
+#include <asm/mach-types.h>
+
+#define LCD_ENABLE       144
+
+static int overo_panel_init(struct lcd_panel *panel,
+				struct omapfb_device *fbdev)
+{
+	if ((gpio_request(LCD_ENABLE, "LCD_ENABLE") == 0) &&
+	    (gpio_direction_output(LCD_ENABLE, 1) == 0))
+		gpio_export(LCD_ENABLE, 0);
+	else
+		printk(KERN_ERR "could not obtain gpio for LCD_ENABLE\n");
+
+	return 0;
+}
+
+static void overo_panel_cleanup(struct lcd_panel *panel)
+{
+	gpio_free(LCD_ENABLE);
+}
+
+static int overo_panel_enable(struct lcd_panel *panel)
+{
+	gpio_set_value(LCD_ENABLE, 1);
+	return 0;
+}
+
+static void overo_panel_disable(struct lcd_panel *panel)
+{
+	gpio_set_value(LCD_ENABLE, 0);
+}
+
+static unsigned long overo_panel_get_caps(struct lcd_panel *panel)
+{
+	return 0;
+}
+
+struct lcd_panel overo_panel = {
+	.name		= "overo",
+	.config		= OMAP_LCDC_PANEL_TFT,
+	.bpp		= 16,
+	.data_lines	= 24,
+
+#if defined CONFIG_FB_OMAP_031M3R
+
+	/* 640 x 480 @ 60 Hz  Reduced blanking VESA CVT 0.31M3-R */
+	.x_res		= 640,
+	.y_res		= 480,
+	.hfp		= 48,
+	.hsw		= 32,
+	.hbp		= 80,
+	.vfp		= 3,
+	.vsw		= 4,
+	.vbp		= 7,
+	.pixel_clock	= 23500,
+
+#elif defined CONFIG_FB_OMAP_048M3R
+
+	/* 800 x 600 @ 60 Hz  Reduced blanking VESA CVT 0.48M3-R */
+	.x_res		= 800,
+	.y_res		= 600,
+	.hfp		= 48,
+	.hsw		= 32,
+	.hbp		= 80,
+	.vfp		= 3,
+	.vsw		= 4,
+	.vbp		= 11,
+	.pixel_clock	= 35500,
+
+#elif defined CONFIG_FB_OMAP_079M3R
+
+	/* 1024 x 768 @ 60 Hz  Reduced blanking VESA CVT 0.79M3-R */
+	.x_res		= 1024,
+	.y_res		= 768,
+	.hfp		= 48,
+	.hsw		= 32,
+	.hbp		= 80,
+	.vfp		= 3,
+	.vsw		= 4,
+	.vbp		= 15,
+	.pixel_clock	= 56000,
+
+#elif defined CONFIG_FB_OMAP_092M9R
+
+	/* 1280 x 720 @ 60 Hz  Reduced blanking VESA CVT 0.92M9-R */
+	.x_res		= 1280,
+	.y_res		= 720,
+	.hfp		= 48,
+	.hsw		= 32,
+	.hbp		= 80,
+	.vfp		= 3,
+	.vsw		= 5,
+	.vbp		= 13,
+	.pixel_clock	= 64000,
+
+#else
+
+	/* use 640 x 480 if no config option */
+	/* 640 x 480 @ 60 Hz  Reduced blanking VESA CVT 0.31M3-R */
+	.x_res		= 640,
+	.y_res		= 480,
+	.hfp		= 48,
+	.hsw		= 32,
+	.hbp		= 80,
+	.vfp		= 3,
+	.vsw		= 4,
+	.vbp		= 7,
+	.pixel_clock	= 23500,
+
+#endif
+
+	.init		= overo_panel_init,
+	.cleanup	= overo_panel_cleanup,
+	.enable		= overo_panel_enable,
+	.disable	= overo_panel_disable,
+	.get_caps	= overo_panel_get_caps,
+};
+
+static int overo_panel_probe(struct platform_device *pdev)
+{
+	omapfb_register_panel(&overo_panel);
+	return 0;
+}
+
+static int overo_panel_remove(struct platform_device *pdev)
+{
+	/* omapfb does not have unregister_panel */
+	return 0;
+}
+
+static struct platform_driver overo_panel_driver = {
+	.probe		= overo_panel_probe,
+	.remove		= overo_panel_remove,
+	.driver		= {
+		.name	= "overo_lcd",
+		.owner	= THIS_MODULE,
+	},
+};
+
+static int __init overo_panel_drv_init(void)
+{
+	return platform_driver_register(&overo_panel_driver);
+}
+
+static void __exit overo_panel_drv_exit(void)
+{
+	platform_driver_unregister(&overo_panel_driver);
+}
+
+module_init(overo_panel_drv_init);
+module_exit(overo_panel_drv_exit);
-- 
1.6.3.1


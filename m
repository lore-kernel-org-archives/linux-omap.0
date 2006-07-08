From: Jonathan McDowell <noodles@earth.li>
Subject: [PATCH] ARM: OMAP: omapfb: Add Amstrad Delta LCD driver.
Date: Sat, 8 Jul 2006 23:57:36 +0100
Message-ID: <20060708225736.GB26313@earth.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

This is an updated version of the LCD driver for the Amstrad Delta to
take into account the recent changes to the omapfb infrastructure. The
Delta features a 480x320 12 bit DSTN panel.

Signed-Off-By: Jonathan McDowell <noodles@earth.li>

-----
diff -ruNp linux-2.6.17-e3-03/drivers/video/omap/lcd_ams_delta.c linux-2.6.17-e3-04/drivers/video/omap/lcd_ams_delta.c
--- linux-2.6.17-e3-03/drivers/video/omap/lcd_ams_delta.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.17-e3-04/drivers/video/omap/lcd_ams_delta.c	2006-07-08 16:28:12.975281500 +0100
@@ -0,0 +1,140 @@
+/*
+ * File: drivers/video/omap/lcd_ams_delta.c
+ *
+ * Based on drivers/video/omap/lcd_inn1510.c
+ *
+ * LCD panel support for the Amstrad E3 (Delta) videophone.
+ *
+ * Copyright (C) 2006 Jonathan McDowell <noodles@earth.li>
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
+ */
+
+#include <linux/module.h>
+#include <linux/platform_device.h>
+
+#include <asm/delay.h>
+#include <asm/io.h>
+
+#include <asm/arch/board-ams-delta.h>
+#include <asm/arch/omap16xx.h>
+#include <asm/arch/omapfb.h>
+
+#define AMS_DELTA_DEFAULT_CONTRAST	112
+
+static int ams_delta_panel_init(struct lcd_panel *panel,
+		struct omapfb_device *fbdev)
+{
+	return 0;
+}
+
+static void ams_delta_panel_cleanup(struct lcd_panel *panel)
+{
+}
+
+static int ams_delta_panel_enable(struct lcd_panel *panel)
+{
+	ams_delta_latch2_write(AMS_DELTA_LATCH2_LCD_NDISP,
+			AMS_DELTA_LATCH2_LCD_NDISP);
+	ams_delta_latch2_write(AMS_DELTA_LATCH2_LCD_VBLEN,
+			AMS_DELTA_LATCH2_LCD_VBLEN);
+
+	omap_writeb(1, OMAP16XX_PWL_CLK_ENABLE);
+	omap_writeb(AMS_DELTA_DEFAULT_CONTRAST, OMAP16XX_PWL_ENABLE);
+
+	return 0;
+}
+
+static void ams_delta_panel_disable(struct lcd_panel *panel)
+{
+	ams_delta_latch2_write(AMS_DELTA_LATCH2_LCD_VBLEN, 0);
+	ams_delta_latch2_write(AMS_DELTA_LATCH2_LCD_NDISP, 0);
+}
+
+static unsigned long ams_delta_panel_get_caps(struct lcd_panel *panel)
+{
+	return 0;
+}
+
+static struct lcd_panel ams_delta_panel = {
+	.name		= "ams-delta",
+	.config		= 0,
+
+	.bpp		= 12,
+	.data_lines	= 16,
+	.x_res		= 480,
+	.y_res		= 320,
+	.pixel_clock	= 4687,
+	.hsw		= 3,
+	.hfp		= 1,
+	.hbp		= 1,
+	.vsw		= 1,
+	.vfp		= 0,
+	.vbp		= 0,
+	.pcd		= 0,
+	.acb		= 37,
+
+	.init		= ams_delta_panel_init,
+	.cleanup	= ams_delta_panel_cleanup,
+	.enable		= ams_delta_panel_enable,
+	.disable	= ams_delta_panel_disable,
+	.get_caps	= ams_delta_panel_get_caps,
+};
+
+static int ams_delta_panel_probe(struct platform_device *pdev)
+{
+	omapfb_register_panel(&ams_delta_panel);
+	return 0;
+}
+
+static int ams_delta_panel_remove(struct platform_device *pdev)
+{
+	return 0;
+}
+
+static int ams_delta_panel_suspend(struct platform_device *pdev,
+		pm_message_t mesg)
+{
+	return 0;
+}
+
+static int ams_delta_panel_resume(struct platform_device *pdev)
+{
+	return 0;
+}
+
+struct platform_driver ams_delta_panel_driver = {
+	.probe		= ams_delta_panel_probe,
+	.remove		= ams_delta_panel_remove,
+	.suspend	= ams_delta_panel_suspend,
+	.resume		= ams_delta_panel_resume,
+	.driver		= {
+		.name	= "lcd_ams_delta",
+		.owner	= THIS_MODULE,
+	},
+};
+
+static int ams_delta_panel_drv_init(void)
+{
+	return platform_driver_register(&ams_delta_panel_driver);
+}
+
+static void ams_delta_panel_drv_cleanup(void)
+{
+	platform_driver_unregister(&ams_delta_panel_driver);
+}
+
+module_init(ams_delta_panel_drv_init);
+module_exit(ams_delta_panel_drv_cleanup);
diff -ruNp linux-2.6.17-e3-03/drivers/video/omap/lcdc.c linux-2.6.17-e3-04/drivers/video/omap/lcdc.c
--- linux-2.6.17-e3-03/drivers/video/omap/lcdc.c	2006-07-05 23:33:23.537127500 +0100
+++ linux-2.6.17-e3-04/drivers/video/omap/lcdc.c	2006-07-08 16:23:41.422310500 +0100
@@ -809,6 +809,8 @@ static int omap_lcdc_init(struct omapfb_
 	rate = clk_get_rate(tc_ck);
 	clk_put(tc_ck);
 
+	if (machine_is_ams_delta())
+		rate /= 4;
 	if (machine_is_omap_h3())
 		rate /= 3;
 	r = clk_set_rate(lcdc.lcd_ck, rate);
diff -ruNp linux-2.6.17-e3-03/drivers/video/omap/Makefile linux-2.6.17-e3-04/drivers/video/omap/Makefile
--- linux-2.6.17-e3-03/drivers/video/omap/Makefile	2006-07-05 23:33:23.581130250 +0100
+++ linux-2.6.17-e3-04/drivers/video/omap/Makefile	2006-07-08 16:23:41.406309500 +0100
@@ -14,6 +14,7 @@ objs-$(CONFIG_ARCH_OMAP2)$(CONFIG_FB_OMA
 
 objs-y$(CONFIG_FB_OMAP_LCDC_HWA742) += hwa742.o
 
+objs-y$(CONFIG_MACH_AMS_DELTA) += lcd_ams_delta.o
 objs-y$(CONFIG_MACH_OMAP_H4) += lcd_h4.o
 objs-y$(CONFIG_MACH_OMAP_H3) += lcd_h3.o
 objs-y$(CONFIG_MACH_OMAP_H2) += lcd_h2.o
-----

J.

-- 
Revd. Jonathan McDowell, ULC | It does it for me our kid!

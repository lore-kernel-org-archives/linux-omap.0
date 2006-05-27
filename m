From: Jonathan McDowell <noodles@earth.li>
Subject: [PATCH 1/2] FB: OMAP: Add LCD support for Amstrad Delta
Date: Sat, 27 May 2006 16:04:25 +0100
Message-ID: <20060527150425.GA3864@earth.li>
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

The patch below adds support for the 12bit 480x320 DSTN panel used in
the Amstrad Delta (E3) videophone. It just adds support to the
drivers/video/omap/ tree; my next patch will add the appropriate
arch/arm/ configuration to make the Delta use the driver.

Patch is against current linux-omap git.

Signed-Off-By: Jonathan McDowell <noodles@earth.li>

-----
diff --git a/drivers/video/omap/Makefile b/drivers/video/omap/Makefile
index 725ea29..e2ad039 100644
--- a/drivers/video/omap/Makefile
+++ b/drivers/video/omap/Makefile
@@ -14,6 +14,7 @@ objs-$(CONFIG_ARCH_OMAP2)$(CONFIG_FB_OMA
 
 objs-y$(CONFIG_FB_OMAP_LCDC_HWA742) += hwa742.o
 
+objs-y$(CONFIG_MACH_AMS_DELTA) += lcd_ams_delta.o
 objs-y$(CONFIG_MACH_OMAP_H4) += lcd_h4.o
 objs-y$(CONFIG_MACH_OMAP_H3) += lcd_h3.o
 objs-y$(CONFIG_MACH_OMAP_H2) += lcd_h2.o
diff --git a/drivers/video/omap/lcdc.c b/drivers/video/omap/lcdc.c
index a86cd73..d401d8a 100644
--- a/drivers/video/omap/lcdc.c
+++ b/drivers/video/omap/lcdc.c
@@ -844,6 +844,8 @@ static int omap_lcdc_init(struct omapfb_
 	rate = clk_get_rate(tc_ck);
 	clk_put(tc_ck);
 
+	if (machine_is_ams_delta())
+		rate /= 4;
 	if (machine_is_omap_h3())
 		rate /= 3;
 	r = clk_set_rate(omap_lcdc.lcd_ck, rate);
diff --git a/drivers/video/omap/lcd_ams_delta.c b/drivers/video/omap/lcd_ams_delta.c
--- a/drivers/video/omap/lcd_ams_delta.c
+++ b/drivers/video/omap/lcd_ams_delta.c
@@ -0,0 +1,157 @@
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
+/* #define OMAPFB_DBG 1 */
+
+#include "debug.h"
+
+#define AMS_DELTA_DEFAULT_CONTRAST	112
+
+static int ams_delta_panel_init(struct omapfb_device *fbdev)
+{
+	DBGENTER(1);
+	DBGLEAVE(1);
+	return 0;
+}
+
+static void ams_delta_panel_cleanup(void)
+{
+	DBGENTER(1);
+	DBGLEAVE(1);
+}
+
+static int ams_delta_panel_enable(void)
+{
+	DBGENTER(1);
+
+	ams_delta_latch2_write(AMS_DELTA_LATCH2_LCD_NDISP,
+			AMS_DELTA_LATCH2_LCD_NDISP);
+	ams_delta_latch2_write(AMS_DELTA_LATCH2_LCD_VBLEN,
+			AMS_DELTA_LATCH2_LCD_VBLEN);
+
+	omap_writeb(1, OMAP16XX_PWL_CLK_ENABLE);
+	omap_writeb(AMS_DELTA_DEFAULT_CONTRAST, OMAP16XX_PWL_ENABLE);
+
+	DBGLEAVE(1);
+	return 0;
+}
+
+static void ams_delta_panel_disable(void)
+{
+	DBGENTER(1);
+
+	ams_delta_latch2_write(AMS_DELTA_LATCH2_LCD_VBLEN, 0);
+	ams_delta_latch2_write(AMS_DELTA_LATCH2_LCD_NDISP, 0);
+
+	DBGLEAVE(1);
+}
+
+static unsigned long ams_delta_panel_get_caps(void)
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
+	DBGENTER(1);
+	omapfb_register_panel(&ams_delta_panel);
+	return 0;
+}
+
+static int ams_delta_panel_remove(struct platform_device *pdev)
+{
+	DBGENTER(1);
+	return 0;
+}
+
+static int ams_delta_panel_suspend(struct platform_device *pdev, pm_message_t mesg)
+{
+	DBGENTER(1);
+	return 0;
+}
+
+static int ams_delta_panel_resume(struct platform_device *pdev)
+{
+	DBGENTER(1);
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
-----

J.

-- 
                                            jid: noodles@jabber.earth.li
noodles is said to have been introduced to
                                            europe by marco polo after
he returned from china

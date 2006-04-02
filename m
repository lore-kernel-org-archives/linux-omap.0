From: Jonathan McDowell <noodles@earth.li>
Subject: [PATCH 2/3] Add LCD support for Amstrad Delta
Date: Sun, 2 Apr 2006 17:38:32 +0100
Message-ID: <20060402163832.GD26949@earth.li>
References: <20060402163614.GC26949@earth.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <20060402163614.GC26949@earth.li>
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
Cc: e3-hacking@earth.li
List-Id: linux-omap@vger.kernel.org

Add support for the Amstrad Delta LCD, which is a 12 bit DSTN panel.
This patch treats it as a 16 bit panel; in reality it's in 0444 mode and
will ignore the top 4 bits, but the next patch adds support for that in
the OMAP FB driver.

Signed-Off-By: Jonathan McDowell <noodles@earth.li>

diff -rupN -X linux-omap/Documentation/dontdiff linux-omap/arch/arm/mach-omap1/board-ams-delta.c linux-omap-lcd/arch/arm/mach-omap1/board-ams-delta.c
--- linux-omap/arch/arm/mach-omap1/board-ams-delta.c	2006-04-02 16:05:20.366858000 +0100
+++ linux-omap-lcd/arch/arm/mach-omap1/board-ams-delta.c	2006-04-02 16:55:12.329102250 +0100
@@ -76,11 +76,16 @@ static struct map_desc ams_delta_io_desc
 	}
 };
 
+static struct omap_lcd_config ams_delta_lcd_config __initdata = {
+	.ctrl_name	= "internal",
+};
+
 static struct omap_uart_config ams_delta_uart_config __initdata = {
 	.enabled_uarts = 1,
 };
 
 static struct omap_board_config_kernel ams_delta_config[] = {
+	{ OMAP_TAG_LCD,		&ams_delta_lcd_config },
 	{ OMAP_TAG_UART,	&ams_delta_uart_config },
 };
 
@@ -89,8 +94,14 @@ static struct platform_device ams_delta_
 	.id	= -1,
 };
 
+static struct platform_device ams_delta_lcd_device = {
+	.name	= "lcd_ams_delta",
+	.id	= "-1",
+};
+
 static struct platform_device *ams_delta_devices[] __initdata = {
 	&ams_delta_bl_device,
+	&ams_delta_lcd_device,
 };
 
 static void __init ams_delta_init(void)
diff -rupN -X linux-omap/Documentation/dontdiff linux-omap/arch/arm/mach-omap1/clock.c linux-omap-lcd/arch/arm/mach-omap1/clock.c
--- linux-omap/arch/arm/mach-omap1/clock.c	2006-04-02 15:46:08.788044000 +0100
+++ linux-omap-lcd/arch/arm/mach-omap1/clock.c	2006-04-02 16:55:59.588055750 +0100
@@ -19,6 +19,7 @@
 #include <linux/clk.h>
 
 #include <asm/io.h>
+#include <asm/mach-types.h>
 
 #include <asm/arch/usb.h>
 #include <asm/arch/clock.h>
@@ -766,6 +767,14 @@ int __init omap1_clk_init(void)
 	omap_writew(omap_readw(OMAP730_PCC_UPLD_CTRL) & ~0x1, OMAP730_PCC_UPLD_CTRL);
 #endif
 
+#ifdef CONFIG_MACH_AMS_DELTA
+	/* Amstrad Delta wants BCLK high when inactive */
+	if (machine_is_ams_delta())
+		omap_writel(omap_readl(ULPD_CLOCK_CTRL) |
+				(1 << SDW_MCLK_INV_BIT),
+				ULPD_CLOCK_CTRL);
+#endif
+
 	/* Turn off DSP and ARM_TIMXO. Make sure ARM_INTHCK is not divided */
 	omap_writew(omap_readw(ARM_CKCTL) & 0x0fff, ARM_CKCTL);
 
diff -rupN -X linux-omap/Documentation/dontdiff linux-omap/arch/arm/mach-omap1/clock.h linux-omap-lcd/arch/arm/mach-omap1/clock.h
--- linux-omap/arch/arm/mach-omap1/clock.h	2006-04-02 15:46:51.617298000 +0100
+++ linux-omap-lcd/arch/arm/mach-omap1/clock.h	2006-04-02 16:56:13.808944500 +0100
@@ -89,6 +89,7 @@ struct arm_idlect1_clk {
 #define EN_DSPTIMCK	5
 
 /* Various register defines for clock controls scattered around OMAP chip */
+#define SDW_MCLK_INV_BIT	2	/* In ULPD_CLKC_CTRL */
 #define USB_MCLK_EN_BIT		4	/* In ULPD_CLKC_CTRL */
 #define USB_HOST_HHC_UHOST_EN	9	/* In MOD_CONF_CTRL_0 */
 #define SWD_ULPD_PLL_CLK_REQ	1	/* In SWD_CLK_DIV_CTRL_SEL */
diff -rupN -X linux-omap/Documentation/dontdiff linux-omap/drivers/video/omap/lcd_ams_delta.c linux-omap-lcd/drivers/video/omap/lcd_ams_delta.c
--- linux-omap/drivers/video/omap/lcd_ams_delta.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-omap-lcd/drivers/video/omap/lcd_ams_delta.c	2006-04-02 16:53:09.881449750 +0100
@@ -0,0 +1,148 @@
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
+#include <asm/arch/omapfb.h>
+
+/* #define OMAPFB_DBG 1 */
+
+#include "debug.h"
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
+
+	DBGLEAVE(1);
+	return 0;
+}
+
+static void ams_delta_panel_disable(void)
+{
+	DBGENTER(1);
+
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
+struct lcd_panel ams_delta_panel = {
+	.name		= "ams-delta",
+	.config		= 0,
+
+	.bpp		= 16,
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
diff -rupN -X linux-omap/Documentation/dontdiff linux-omap/drivers/video/omap/lcdc.c linux-omap-lcd/drivers/video/omap/lcdc.c
--- linux-omap/drivers/video/omap/lcdc.c	2006-04-02 15:53:36.433153500 +0100
+++ linux-omap-lcd/drivers/video/omap/lcdc.c	2006-04-02 16:56:46.278973750 +0100
@@ -836,6 +836,8 @@ static int omap_lcdc_init(struct omapfb_
 	rate = clk_get_rate(tc_ck);
 	clk_put(tc_ck);
 
+	if (machine_is_ams_delta())
+		rate /= 4;
 	if (machine_is_omap_h3())
 		rate /= 3;
 	r = clk_set_rate(omap_lcdc.lcd_ck, rate);
diff -rupN -X linux-omap/Documentation/dontdiff linux-omap/drivers/video/omap/Makefile linux-omap-lcd/drivers/video/omap/Makefile
--- linux-omap/drivers/video/omap/Makefile	2006-04-02 15:53:29.504720500 +0100
+++ linux-omap-lcd/drivers/video/omap/Makefile	2006-04-02 17:03:10.811820750 +0100
@@ -14,6 +14,7 @@ objs-$(CONFIG_ARCH_OMAP2)$(CONFIG_FB_OMA
 
 objs-y$(CONFIG_FB_OMAP_LCDC_HWA742) += hwa742.o
 
+objs-y$(CONFIG_MACH_AMS_DELTA) += lcd_ams_delta.o
 objs-y$(CONFIG_MACH_OMAP_H4) += lcd_h4.o
 objs-y$(CONFIG_MACH_OMAP_H3) += lcd_h3.o
 objs-y$(CONFIG_MACH_OMAP_H2) += lcd_h2.o

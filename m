From: leed.aguilar@ti.com
Subject: [PATCH][OMAPZOOM] padconfig for NEC WVGA lcd
Date: Wed, 19 Nov 2008 11:04:26 -0600
Message-ID: <1227114266-30993-1-git-send-email-leed.aguilar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:35555 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751205AbYKSREg (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 19 Nov 2008 12:04:36 -0500
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id mAJH4UWU031160
	for <linux-omap@vger.kernel.org>; Wed, 19 Nov 2008 11:04:35 -0600
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: vikram.pandita@ti.com, Leed Aguilar <leed.aguilar@ti.com>

From: Leed Aguilar <leed.aguilar@ti.com>

This patch sets the proper padconfig value for wvga spi chip select.

Also ensures that dvi output is disable.

LCD data lines has been changed to 24 for Zoom2

Signed-off-by: Leed Aguilar <leed.aguilar@ti.com>
---
 arch/arm/mach-omap2/mux.c             |   15 ++++++++++++---
 arch/arm/plat-omap/display.c          |    4 ++--
 arch/arm/plat-omap/include/mach/mux.h |    8 ++++++++
 drivers/video/omap/omap_disp_out.c    |   25 +++++++++++++++++--------
 4 files changed, 39 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
index 0e650a4..cd6de1d 100644
--- a/arch/arm/mach-omap2/mux.c
+++ b/arch/arm/mach-omap2/mux.c
@@ -25,10 +25,11 @@
  */
 #include <linux/module.h>
 #include <linux/init.h>
-#include <asm/system.h>
 #include <linux/io.h>
 #include <linux/spinlock.h>
 
+#include <asm/system.h>
+
 #include <mach/control.h>
 #include <mach/mux.h>
 
@@ -450,7 +451,7 @@ MUX_CFG_34XX("AD2_3430_USB3FS_PHY_MM3_TXDAT", 0x188,
 MUX_CFG_34XX("AC1_3430_USB3FS_PHY_MM3_TXEN_N", 0x18a,
 		OMAP34XX_MUX_MODE6 | OMAP34XX_PIN_OUTPUT)
 
- /* UART3 */
+/* UART3 */
 MUX_CFG_34XX("R21_3430_UART3_CTS_RCTX",	0x19a,
 		OMAP34XX_MUX_MODE0 | OMAP34XX_PIN_INPUT_PULLDOWN)
 MUX_CFG_34XX("T21_3430_UART3_RTS_SD", 0x19c,
@@ -460,11 +461,15 @@ MUX_CFG_34XX("U21_3430_UART3_RX_IRRX", 0x19e,
 MUX_CFG_34XX("V21_3430_UART3_TX_IRTX", 0x1a0,
 		OMAP34XX_MUX_MODE0 | OMAP34XX_PIN_INPUT_PULLDOWN)
 
- /* GPIO */
+/* GPIO */
 MUX_CFG_34XX("T21_3430_GPIO164", 0x19c,
 		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_INPUT_PULLDOWN)
 MUX_CFG_34XX("V21_3430_GPIO166", 0x1a0,
 		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_INPUT_PULLDOWN)
+MUX_CFG_34XX("AF21_3430_GPIO8", 0xa16,
+		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_OUTPUT)
+MUX_CFG_34XX("B23_3430_GPIO167", 0x130,
+		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_OUTPUT)
 
 /* 34XX GPIO - bidirectional, unless the name has an "_OUT" suffix.
  * No internal pullup/pulldown without "_UP" or "_DOWN" suffix.
@@ -473,6 +478,10 @@ MUX_CFG_34XX("AH8_34XX_GPIO29", 0x5fa,
 		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_INPUT)
 MUX_CFG_34XX("J25_34XX_GPIO170", 0x1c6,
 		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_INPUT)
+
+/* McSPI */
+MUX_CFG_34XX("AB1_3430_McSPI1_CS2", 0x1d2,
+		OMAP34XX_MUX_MODE0 | OMAP34XX_PIN_INPUT_PULLDOWN)
 };
 
 #define OMAP34XX_PINS_SZ	ARRAY_SIZE(omap34xx_pins)
diff --git a/arch/arm/plat-omap/display.c b/arch/arm/plat-omap/display.c
index 9ec7ff2..2fca7a9 100644
--- a/arch/arm/plat-omap/display.c
+++ b/arch/arm/plat-omap/display.c
@@ -1975,10 +1975,10 @@ omap2_disp_config_lcd(u32 clkdiv, u32 hbp, u32 hfp, u32 hsw,
 #endif
 	dispc_reg_out(DISPC_DIVISOR, divisor);
 	control = dispc_reg_in(DISPC_CONTROL);
-#ifdef CONFIG_FB_OMAP_720P_STREAMING
+#if defined(CONFIG_FB_OMAP_720P_STREAMING) || defined(CONFIG_MACH_OMAP_ZOOM2)
 	control |= DISPC_CONTROL_TFTDATALINES_OALSB24B;
 #else
-#if defined(CONFIG_MACH_OMAP_LDP) || defined(CONFIG_MACH_OMAP_ZOOM2)
+#ifdef CONFIG_MACH_OMAP_LDP
 	control |= DISPC_CONTROL_TFTDATALINES_OALSB18B;
 #else
 	control |= DISPC_CONTROL_TFTDATALINES_OALSB16B;
diff --git a/arch/arm/plat-omap/include/mach/mux.h b/arch/arm/plat-omap/include/mach/mux.h
index 0447a78..4055763 100644
--- a/arch/arm/plat-omap/include/mach/mux.h
+++ b/arch/arm/plat-omap/include/mach/mux.h
@@ -785,8 +785,13 @@ enum omap34xx_index {
 	T21_3430_UART3_RTS_SD,
 	U21_3430_UART3_RX_IRRX,
 	V21_3430_UART3_TX_IRTX,
+
+	/* GPIO */
 	T21_3430_GPIO164,
 	V21_3430_GPIO166,
+	AF21_3430_GPIO8,
+	B23_3430_GPIO167,
+
 	/* 34xx GPIO
 	 *  - normally these are bidirectional, no internal pullup/pulldown
 	 *  - "_UP" suffix (GPIO3_UP) if internal pullup is configured
@@ -795,6 +800,9 @@ enum omap34xx_index {
 	 */
 	AH8_34XX_GPIO29,
 	J25_34XX_GPIO170,
+
+	/* McSPI */
+	AB1_3430_McSPI1_CS2,
 };
 
 struct omap_mux_cfg {
diff --git a/drivers/video/omap/omap_disp_out.c b/drivers/video/omap/omap_disp_out.c
index 62bf126..4dc818e 100755
--- a/drivers/video/omap/omap_disp_out.c
+++ b/drivers/video/omap/omap_disp_out.c
@@ -30,25 +30,29 @@
 #include <linux/fb.h>
 #include <linux/delay.h>
 #include <linux/device.h>
-#include <mach/hardware.h>
+#include <linux/delay.h>
+#include <linux/workqueue.h>
+#include <linux/platform_device.h>
+
 #include <asm/uaccess.h>
 #include <asm/delay.h>
-#include <linux/delay.h>
-#include <mach/display.h>
+
 #include <mach/gpio.h>
 #include <mach/clock.h>
+#include <mach/hardware.h>
+#include <mach/mux.h>
+#include <mach/power_companion.h>
+#include <mach/resource.h>
+#include <mach/display.h>
+
 #if defined(CONFIG_MACH_OMAP_2430SDP) || defined (CONFIG_MACH_OMAP_3430SDP) ||\
     defined(CONFIG_MACH_OMAP_LDP) || defined(CONFIG_MACH_OMAP_ZOOM2)
 #include <linux/i2c/twl4030.h>
 #endif
-#include <linux/workqueue.h>
-#include <mach/power_companion.h>
-#include <mach/resource.h>
 #ifdef CONFIG_PM
 #include <linux/notifier.h>
 #include <linux/pm.h>
 #endif
-#include <linux/platform_device.h>
 #ifdef CONFIG_FB_OMAP_LCD_WVGA
 #include <linux/spi/spi.h>
 #endif
@@ -129,7 +133,7 @@
 #define LCD_PANEL_RESET_GPIO		55
 #define LCD_PANEL_QVGA_GPIO		56
 #define LCD_PANEL_BACKLIGHT_GPIO 	(7 + OMAP_MAX_GPIO_LINES)
-#define DVI_OUTPUT_GPIO		8
+#define DVI_OUTPUT_GPIO			8
 #define DVI_POWER_ON_GPIO		167
 #elif defined(CONFIG_OMAP3430_ES2)
 #define LCD_PANEL_ENABLE_GPIO 		5
@@ -666,6 +670,7 @@ int initialize_nec_wvgalcd(void)
 	spi_wvgalcd_send(157, 0x00);  /* R157 = 00h */
 	udelay(20);
 	spi_wvgalcd_send(2, 0x00);    /* R2 = 00h */
+
 	return 0;
 }
 #endif
@@ -922,10 +927,14 @@ lcd_probe(struct platform_device *odev)
 #ifdef CONFIG_FB_OMAP_LCD_WVGA
 static int wvgalcd_probe(struct spi_device *spi)
 {
+	omap_cfg_reg(AF21_3430_GPIO8);
+	omap_cfg_reg(B23_3430_GPIO167);
+	omap_cfg_reg(AB1_3430_McSPI1_CS2);
 	wvgalcd_spi = spi;
 	wvgalcd_spi->mode = SPI_MODE_0;
 	wvgalcd_spi->bits_per_word = 32;
 	spi_setup(wvgalcd_spi);
+
 	return omap_lcd_init(0);
 }
 #endif
-- 
1.6.0


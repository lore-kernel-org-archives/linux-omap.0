From: chudson@kionix.com
Subject: [RFC PATCH v3 2/3] mach-omap2:kxte9 accelerometer support for OMAP ZoomII
Date: Mon, 30 Nov 2009 09:42:55 -0500
Message-ID: <1259592176-18634-2-git-send-email-chudson@kionix.com>
References: <1259592176-18634-1-git-send-email-chudson@kionix.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from barracuda.kionix.com ([205.232.90.213]:56631 "EHLO
	mail.kionix.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752542AbZK3Omy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 30 Nov 2009 09:42:54 -0500
In-Reply-To: <1259592176-18634-1-git-send-email-chudson@kionix.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: linux-omap@vger.kernel.org, dmitry.torokhov@gmail.com, jic23@cam.ac.uk, Chris Hudson <chudson@kionix.com>

From: Chris Hudson <chudson@kionix.com>

This patch alters board-zoom-peripherals.c to add platform data initialization,
gpio configuration, and i2c-2 bus initialization in support of the kxte9 
accelerometer on the OMAP ZoomII platform.

Signed-off-by: Chris Hudson <chudson@kionix.com>
---
 arch/arm/mach-omap2/board-zoom-peripherals.c |   58 ++++++++++++++++++++++++++
 1 files changed, 58 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-zoom-peripherals.c b/arch/arm/mach-omap2/board-zoom-peripherals.c
index f14baa3..f6d1c40 100755
--- a/arch/arm/mach-omap2/board-zoom-peripherals.c
+++ b/arch/arm/mach-omap2/board-zoom-peripherals.c
@@ -26,6 +26,47 @@
 
 #include "mmc-twl4030.h"
 
+#ifdef CONFIG_INPUT_KXTE9
+/* KIONIX KXTE9 Digital Tri-axis Accelerometer */
+#include <plat/mux.h>
+#include <linux/kxte9.h>
+#define ZOOM2_KIONIX_INT_GPIO	156
+
+static void __init zoom2_kionix_init(void)
+{
+	omap_cfg_reg(Y21_34XX_GPIO156);
+	if (gpio_request(ZOOM2_KIONIX_INT_GPIO, "kionix_irq") < 0) {
+		printk(KERN_ERR "kionix error retrieving GPIO\n");
+		return;
+	}
+	gpio_direction_input(ZOOM2_KIONIX_INT_GPIO);
+}
+
+static struct kxte9_platform_data zoom2_kxte9_data = {
+	.min_interval	= 25,
+	.poll_interval	= 200,
+
+	.axis_map_x	= 0,
+	.axis_map_y	= 1,
+	.axis_map_z	= 2,
+
+	.negate_x	= 0,
+	.negate_y	= 0,
+	.negate_z	= 0,
+
+	.ctrl_reg1_init		= TPE | WUFE | B2SE,
+	.engine_odr_init	= OB2S10 | OWUF40,
+	.int_ctrl_init		= KXTE9_IEN | KXTE9_IEA,
+	.tilt_timer_init	= 0x03,
+	.wuf_timer_init		= 0x01,
+	.b2s_timer_init		= 0x01,
+	.wuf_thresh_init	= 0x20,
+	.b2s_thresh_init	= 0x60,
+
+	.gpio = ZOOM2_KIONIX_INT_GPIO,
+};
+#endif
+
 /* Zoom2 has Qwerty keyboard*/
 static int board_keymap[] = {
 	KEY(0, 0, KEY_E),
@@ -250,17 +291,34 @@ static struct i2c_board_info __initdata zoom_i2c_boardinfo[] = {
 	},
 };
 
+#ifdef CONFIG_INPUT_KXTE9
+static struct i2c_board_info __initdata zoom2_i2c_bus2info[] = {
+	{
+		I2C_BOARD_INFO("kxte9", KXTE9_I2C_ADDR),
+		.platform_data = &zoom2_kxte9_data,
+	},
+};
+#endif
+
 static int __init omap_i2c_init(void)
 {
 	omap_register_i2c_bus(1, 2400, zoom_i2c_boardinfo,
 			ARRAY_SIZE(zoom_i2c_boardinfo));
+#ifndef CONFIG_INPUT_KXTE9
 	omap_register_i2c_bus(2, 400, NULL, 0);
+#else
+	omap_register_i2c_bus(2, 400, zoom2_i2c_bus2info,
+			ARRAY_SIZE(zoom2_i2c_bus2info));
+#endif
 	omap_register_i2c_bus(3, 400, NULL, 0);
 	return 0;
 }
 
 void __init zoom_peripherals_init(void)
 {
+#ifdef CONFIG_INPUT_KXTE9
+	zoom2_kionix_init();
+#endif
 	omap_i2c_init();
 	omap_serial_init();
 	usb_musb_init();
-- 
1.5.4.3


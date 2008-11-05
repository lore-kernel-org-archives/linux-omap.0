From: Grazvydas Ignotas <notasas@gmail.com>
Subject: [PATCH 1/2] Add touchscreen support for Pandora
Date: Wed,  5 Nov 2008 23:19:42 +0200
Message-ID: <1225919983-26144-1-git-send-email-notasas@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.190]:4662 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752000AbYKEVUQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Nov 2008 16:20:16 -0500
Received: by nf-out-0910.google.com with SMTP id d3so128288nfc.21
        for <linux-omap@vger.kernel.org>; Wed, 05 Nov 2008 13:20:01 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Grazvydas Ignotas <notasas@gmail.com>

This patch adds ADS7846 compatible touchscreen support for
OMAP3 Pandora.

Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
---
 arch/arm/mach-omap2/board-omap3pandora.c           |   55 ++++++++++++++++++++
 .../plat-omap/include/mach/board-omap3pandora.h    |   25 +++++++++
 arch/arm/plat-omap/include/mach/hardware.h         |    4 ++
 3 files changed, 84 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/plat-omap/include/mach/board-omap3pandora.h

diff --git a/arch/arm/mach-omap2/board-omap3pandora.c b/arch/arm/mach-omap2/board-omap3pandora.c
index f4180a0..96c9b6e 100644
--- a/arch/arm/mach-omap2/board-omap3pandora.c
+++ b/arch/arm/mach-omap2/board-omap3pandora.c
@@ -25,6 +25,8 @@
 #include <linux/kernel.h>
 #include <linux/platform_device.h>
 
+#include <linux/spi/spi.h>
+#include <linux/spi/ads7846.h>
 #include <linux/i2c/twl4030.h>
 
 #include <linux/mtd/mtd.h>
@@ -45,6 +47,7 @@
 #include <mach/nand.h>
 #include <mach/usb-ehci.h>
 #include <mach/usb-musb.h>
+#include <mach/mcspi.h>
 
 #include "sdram-micron-mt46h32m32lf-6.h"
 
@@ -183,6 +186,55 @@ static void __init omap3pandora_init_irq(void)
 	omap_gpio_init();
 }
 
+static void __init omap3pandora_ads7846_init(void)
+{
+	int gpio = OMAP3_PANDORA_TS_GPIO;
+	int ret;
+
+	ret = gpio_request(gpio, "ads7846_pen_down");
+	if (ret < 0) {
+		printk(KERN_ERR "Failed to request GPIO %d for "
+				"ads7846 pen down IRQ\n", gpio);
+		return;
+	}
+
+	gpio_direction_input(gpio);
+}
+
+static int ads7846_get_pendown_state(void)
+{
+	return !gpio_get_value(OMAP3_PANDORA_TS_GPIO);
+}
+
+static struct ads7846_platform_data ads7846_config = {
+	.x_max			= 0x0fff,
+	.y_max			= 0x0fff,
+	.x_plate_ohms		= 180,
+	.pressure_max		= 255,
+	.debounce_max		= 10,
+	.debounce_tol		= 3,
+	.debounce_rep		= 1,
+	.get_pendown_state	= ads7846_get_pendown_state,
+	.keep_vref_on		= 1,
+};
+
+static struct omap2_mcspi_device_config ads7846_mcspi_config = {
+	.turbo_mode	= 0,
+	.single_channel	= 1,  /* 0: slave, 1: master */
+};
+
+static struct spi_board_info omap3pandora_spi_board_info[] = {
+	{
+		.modalias		= "ads7846",
+		.bus_num		= 1,
+		.chip_select		= 0,
+		.max_speed_hz		= 1500000,
+		.controller_data	= &ads7846_mcspi_config,
+		.irq			= OMAP_GPIO_IRQ(OMAP3_PANDORA_TS_GPIO),
+		.platform_data		= &ads7846_config,
+	}
+};
+
 static struct platform_device omap3pandora_lcd_device = {
 	.name		= "pandora_lcd",
 	.id		= -1,
@@ -207,11 +259,14 @@ static void __init omap3pandora_init(void)
 	platform_add_devices(omap3pandora_devices, ARRAY_SIZE(omap3pandora_devices));
 	omap_board_config = omap3pandora_config;
 	omap_board_config_size = ARRAY_SIZE(omap3pandora_config);
+	spi_register_board_info(omap3pandora_spi_board_info,
+			ARRAY_SIZE(omap3pandora_spi_board_info));
 	omap_serial_init();
 	hsmmc_init();
 	usb_musb_init();
 	usb_ehci_init();
 	omap3pandora_flash_init();
+	omap3pandora_ads7846_init();
 }
 
 static void __init omap3pandora_map_io(void)
diff --git a/arch/arm/plat-omap/include/mach/board-omap3pandora.h b/arch/arm/plat-omap/include/mach/board-omap3pandora.h
new file mode 100644
index 0000000..bc7f09f
--- /dev/null
+++ b/arch/arm/plat-omap/include/mach/board-omap3pandora.h
@@ -0,0 +1,25 @@
+/*
+ * board-omap3pandora.h
+ *
+ * Hardware definitions for OMAP3 Pandora.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
+ */
+
+#ifndef __ASM_ARCH_OMAP3_PANDORA_H
+#define __ASM_ARCH_OMAP3_PANDORA_H
+
+#define	OMAP3_PANDORA_TS_GPIO		94
+
+#endif /* __ASM_ARCH_OMAP3_PANDORA_H */
diff --git a/arch/arm/plat-omap/include/mach/hardware.h b/arch/arm/plat-omap/include/mach/hardware.h
index 3486524..72790a3 100644
--- a/arch/arm/plat-omap/include/mach/hardware.h
+++ b/arch/arm/plat-omap/include/mach/hardware.h
@@ -342,6 +342,10 @@
 #include "board-omap3beagle.h"
 #endif
 
+#ifdef CONFIG_MACH_OMAP3_PANDORA
+#include "board-omap3pandora.h"
+#endif
+
 #ifdef CONFIG_MACH_OMAP_LDP
 #include "board-ldp.h"
 #endif
-- 
1.5.4.3


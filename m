From: Eduardo Valentin <eduardo.valentin@nokia.com>
Subject: [PATCH 4/8] OMAP: RX51: Add audio board file
Date: Thu,  8 Oct 2009 14:58:53 +0300
Message-ID: <1255003137-1034-5-git-send-email-eduardo.valentin@nokia.com>
References: <1255003137-1034-1-git-send-email-eduardo.valentin@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:45217 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757759AbZJHMBI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Oct 2009 08:01:08 -0400
In-Reply-To: <1255003137-1034-1-git-send-email-eduardo.valentin@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, ext Tony Lindgren <tony@atomide.com>
Cc: "Ujfalusi Peter (Nokia-D/Tampere)" <peter.ujfalusi@nokia.com>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>, Jarkko Nikula <jhnikula@gmail.com>, Linux-OMAP <linux-omap@vger.kernel.org>, ALSA-Devel <alsa-devel@vger.kernel.org>, Eduardo Valentin <eduardo.valentin@nokia.com>

From: Eduardo Valentin <eduardo.valentin@nokia.com>

Add board-rx51-audio.c with audio support for rx51 boards.
Platform data included for the following drivers:
si4713, aic34b_dummy and tpa6130a2.

Signed-off-by: Eduardo Valentin <eduardo.valentin@nokia.com>
---
 arch/arm/mach-omap2/Makefile           |    1 +
 arch/arm/mach-omap2/board-rx51-audio.c |  132 ++++++++++++++++++++++++++++++++
 2 files changed, 133 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-omap2/board-rx51-audio.c

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 6b7702f..50f2fbe 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -70,6 +70,7 @@ obj-$(CONFIG_MACH_OMAP_3430SDP)		+= board-3430sdp.o \
 obj-$(CONFIG_MACH_NOKIA_N8X0)		+= board-n8x0.o
 obj-$(CONFIG_MACH_NOKIA_RX51)		+= board-rx51.o \
 					   board-rx51-peripherals.o \
+					   board-rx51-audio.o \
 					   mmc-twl4030.o
 obj-$(CONFIG_MACH_OMAP_ZOOM2)		+= board-zoom2.o \
 					   mmc-twl4030.o \
diff --git a/arch/arm/mach-omap2/board-rx51-audio.c b/arch/arm/mach-omap2/board-rx51-audio.c
new file mode 100644
index 0000000..cba42b5
--- /dev/null
+++ b/arch/arm/mach-omap2/board-rx51-audio.c
@@ -0,0 +1,132 @@
+/*
+ * linux/arch/arm/mach-omap2/board-rx51-audio.c
+ *
+ * Copyright (C) 2008 Nokia
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/i2c.h>
+#include <linux/gpio.h>
+#include <linux/delay.h>
+#include <linux/i2c/twl4030.h>
+#include <sound/tpa6130a2-plat.h>
+#include <media/si4713.h>
+#include <media/radio-si4713.h>
+#include <linux/platform_device.h>
+#include <asm/mach-types.h>
+
+#define RX51_FMTX_RESET_GPIO  	163
+#define RX51_FMTX_IRQ		53
+#define RX51_FMRX_IRQ		43
+#define RX51_HEADPHN_EN_GPIO	98
+
+static int si4713_set_power(int power)
+{
+	if (!power)
+		udelay(1);
+	gpio_set_value(RX51_FMTX_RESET_GPIO, power);
+	udelay(50);
+
+	return 0;
+}
+
+static struct si4713_platform_data rx51_si4713_platform_data = {
+	.set_power	= si4713_set_power,
+};
+
+static void __init rx51_init_si4713(void)
+{
+	int r;
+
+	r = gpio_request(RX51_FMTX_RESET_GPIO, "si4713");
+	if (r < 0) {
+		printk(KERN_ERR "Failed to request gpio for FMTx rst\n");
+		return;
+	}
+
+	gpio_direction_output(RX51_FMTX_RESET_GPIO, 0);
+}
+
+static int tpa6130a2_set_power(int state)
+{
+	gpio_set_value(RX51_HEADPHN_EN_GPIO, !!state);
+	return 0;
+}
+
+static struct tpa6130a2_platform_data rx51_tpa6130a2_platform_data = {
+	.set_power = tpa6130a2_set_power,
+};
+
+static void __init rx51_init_tpa6130a2(void)
+{
+	int r;
+
+	r = gpio_request(RX51_HEADPHN_EN_GPIO, "tpa6130a2");
+	if (r < 0) {
+		printk(KERN_ERR "Failed to request shutdown gpio "
+		       "for TPA6130a2 chip\n");
+	}
+
+	gpio_direction_output(RX51_HEADPHN_EN_GPIO, 0);
+
+	return;
+}
+
+struct i2c_board_info si4713_board_info = {
+	I2C_BOARD_INFO("si4713", SI4713_I2C_ADDR_BUSEN_HIGH),
+	.irq            = OMAP_GPIO_IRQ(RX51_FMTX_IRQ),
+	.platform_data  = &rx51_si4713_platform_data,
+};
+
+static struct radio_si4713_platform_data rx51_radio_si4713_platform_data = {
+	.i2c_bus                = 2,
+	.subdev_board_info      = &si4713_board_info,
+};
+
+static struct platform_device radio_fmtx = {
+	.name           = "radio-si4713",
+	.id             = -1,
+	.dev            = {
+		.platform_data  = &rx51_radio_si4713_platform_data,
+	},
+};
+
+static struct platform_device *rx51_audio_devices[] = {
+	&radio_fmtx,
+};
+
+static struct i2c_board_info __initdata rx51_audio_i2c_board_info_2[] = {
+	{
+		I2C_BOARD_INFO("aic34b_dummy", 0x19),
+	},
+	{
+		I2C_BOARD_INFO("tlv320aic3x", 0x18),
+	},
+	{
+		I2C_BOARD_INFO("tpa6130a2", 0x60),
+		.platform_data	= &rx51_tpa6130a2_platform_data,
+	},
+};
+
+static int __init rx51_audio_init(void)
+{
+	if (!machine_is_nokia_rx51())
+		return 0;
+
+	platform_add_devices(rx51_audio_devices,
+			ARRAY_SIZE(rx51_audio_devices));
+
+	rx51_init_tpa6130a2();
+	rx51_init_si4713();
+	i2c_register_board_info(2, rx51_audio_i2c_board_info_2,
+			      ARRAY_SIZE(rx51_audio_i2c_board_info_2));
+
+	return 0;
+}
+
+subsys_initcall(rx51_audio_init);
-- 
1.6.4.183.g04423


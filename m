From: hvaibhav@ti.com
Subject: [PATCH 2/2-V3] AM3517: Enable I2C-GPIO Expander driver support for AM3517EVM
Date: Sat, 13 Feb 2010 17:17:57 +0530
Message-ID: <1266061677-12681-3-git-send-email-hvaibhav@ti.com>
References: <hvaibhav@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:47238 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753986Ab0BMLsG (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 13 Feb 2010 06:48:06 -0500
In-Reply-To: <hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, Vaibhav Hiremath <hvaibhav@ti.com>

From: Vaibhav Hiremath <hvaibhav@ti.com>

Add platform hook-up interface to support I2C based GPIo expander
(TCA6416).

There are 3 instances of I2C Expander on AM3517EVM,
	- One is over I2C-2 mounted on Base board
	- Two are over I2C3 mounted on UI Card

Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
---
 arch/arm/mach-omap2/board-am3517evm.c |   40 +++++++++++++++++++++++++++++++-
 1 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/board-am3517evm.c b/arch/arm/mach-omap2/board-am3517evm.c
index 9589e46..757dbcf 100644
--- a/arch/arm/mach-omap2/board-am3517evm.c
+++ b/arch/arm/mach-omap2/board-am3517evm.c
@@ -20,6 +20,7 @@
 #include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/gpio.h>
+#include <linux/i2c/pca953x.h>

 #include <mach/hardware.h>
 #include <mach/am35xx.h>
@@ -208,11 +209,46 @@ static void __init am3517_evm_rtc_init(void)
 	am3517evm_i2c_boardinfo[0].irq = gpio_to_irq(GPIO_RTCS35390A_IRQ);
 }

+/*
+ * I2C GPIO Expander - TCA6416
+ */
+
+/* Mounted on Base-Board */
+static struct pca953x_platform_data am3517evm_gpio_expander_info_0 = {
+	.gpio_base	= OMAP_MAX_GPIO_LINES,
+};
+static struct i2c_board_info __initdata am3517evm_tca6516_info_0[] = {
+	{
+		I2C_BOARD_INFO("tca6416", 0x21),
+		.platform_data = &am3517evm_gpio_expander_info_0,
+	},
+};
+
+/* Mounted on UI Card */
+static struct pca953x_platform_data am3517evm_ui_gpio_expander_info_1 = {
+	.gpio_base	= OMAP_MAX_GPIO_LINES + 16,
+};
+static struct pca953x_platform_data am3517evm_ui_gpio_expander_info_2 = {
+	.gpio_base	= OMAP_MAX_GPIO_LINES + 32,
+};
+static struct i2c_board_info __initdata am3517evm_ui_tca6516_info[] = {
+	{
+		I2C_BOARD_INFO("tca6416", 0x20),
+		.platform_data = &am3517evm_ui_gpio_expander_info_1,
+	},
+	{
+		I2C_BOARD_INFO("tca6416", 0x21),
+		.platform_data = &am3517evm_ui_gpio_expander_info_2,
+	},
+};
+
 static int __init am3517_evm_i2c_init(void)
 {
 	omap_register_i2c_bus(1, 400, NULL, 0);
-	omap_register_i2c_bus(2, 400, NULL, 0);
-	omap_register_i2c_bus(3, 400, NULL, 0);
+	omap_register_i2c_bus(2, 400, am3517evm_tca6516_info_0,
+			ARRAY_SIZE(am3517evm_tca6516_info_0));
+	omap_register_i2c_bus(3, 400, am3517evm_ui_tca6516_info,
+			ARRAY_SIZE(am3517evm_ui_tca6516_info));

 	return 0;
 }
--
1.6.2.4


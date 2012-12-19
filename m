From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH] ARM: OMAP1: nokia770: enable CBUS/Retu
Date: Wed, 19 Dec 2012 23:41:01 +0200
Message-ID: <1355953262-4352-1-git-send-email-aaro.koskinen@iki.fi>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from filtteri2.pp.htv.fi ([213.243.153.185]:49270 "EHLO
	filtteri2.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751009Ab2LSVmE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Dec 2012 16:42:04 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>

Add needed platform data so that it's possible to use Retu and e.g. feed
Retu watchdog.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 arch/arm/mach-omap1/board-nokia770.c |   43 ++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/arch/arm/mach-omap1/board-nokia770.c b/arch/arm/mach-omap1/board-nokia770.c
index 24d2f2d..ecd3f2a 100644
--- a/arch/arm/mach-omap1/board-nokia770.c
+++ b/arch/arm/mach-omap1/board-nokia770.c
@@ -7,6 +7,7 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
+#include <linux/irq.h>
 #include <linux/gpio.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
@@ -23,6 +24,8 @@
 
 #include <linux/platform_data/keypad-omap.h>
 #include <linux/platform_data/lcd-mipid.h>
+#include <linux/platform_data/gpio-omap.h>
+#include <linux/platform_data/i2c-cbus-gpio.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -212,6 +215,45 @@ static inline void nokia770_mmc_init(void)
 }
 #endif
 
+#if defined(CONFIG_I2C_CBUS_GPIO) || defined(CONFIG_I2C_CBUS_GPIO_MODULE)
+static struct i2c_cbus_platform_data nokia770_cbus_data = {
+	.clk_gpio = OMAP_MPUIO(9),
+	.dat_gpio = OMAP_MPUIO(10),
+	.sel_gpio = OMAP_MPUIO(11),
+};
+
+static struct platform_device nokia770_cbus_device = {
+	.name   = "i2c-cbus-gpio",
+	.id     = 2,
+	.dev    = {
+		.platform_data = &nokia770_cbus_data,
+	},
+};
+
+static struct i2c_board_info nokia770_i2c_board_info_2[] __initdata = {
+	{
+		I2C_BOARD_INFO("retu-mfd", 0x01),
+	},
+};
+
+static void __init nokia770_cbus_init(void)
+{
+	const int retu_irq_gpio = 62;
+
+	if (gpio_request_one(retu_irq_gpio, GPIOF_IN, "Retu IRQ"))
+		return;
+	irq_set_irq_type(gpio_to_irq(retu_irq_gpio), IRQ_TYPE_EDGE_RISING);
+	nokia770_i2c_board_info_2[0].irq = gpio_to_irq(retu_irq_gpio);
+	i2c_register_board_info(2, nokia770_i2c_board_info_2,
+				ARRAY_SIZE(nokia770_i2c_board_info_2));
+	platform_device_register(&nokia770_cbus_device);
+}
+#else /* CONFIG_I2C_CBUS_GPIO */
+static void __init nokia770_cbus_init(void)
+{
+}
+#endif /* CONFIG_I2C_CBUS_GPIO */
+
 static void __init omap_nokia770_init(void)
 {
 	/* On Nokia 770, the SleepX signal is masked with an
@@ -233,6 +275,7 @@ static void __init omap_nokia770_init(void)
 	mipid_dev_init();
 	omap1_usb_init(&nokia770_usb_config);
 	nokia770_mmc_init();
+	nokia770_cbus_init();
 }
 
 MACHINE_START(NOKIA770, "Nokia 770")
-- 
1.7.10.4


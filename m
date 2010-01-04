From: hvaibhav@ti.com
Subject: [PATCH 2/4] AM3517: Add support for TSC2004 driver
Date: Mon,  4 Jan 2010 19:46:35 +0530
Message-ID: <1262614597-21685-3-git-send-email-hvaibhav@ti.com>
References: <hvaibhav@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:34061 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753125Ab0ADOQo (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 4 Jan 2010 09:16:44 -0500
In-Reply-To: <hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, Vaibhav Hiremath <hvaibhav@ti.com>

From: Vaibhav Hiremath <hvaibhav@ti.com>

This patch is dependent on the TSC2004 driver patch, please refer
below link -

http://marc.info/?l=linux-omap&m=125864200818153&w=2

Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
---
 arch/arm/mach-omap2/board-am3517evm.c |   60 +++++++++++++++++++++++++++++++++
 1 files changed, 60 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-am3517evm.c b/arch/arm/mach-omap2/board-am3517evm.c
index 61ccb98..d97e02e 100644
--- a/arch/arm/mach-omap2/board-am3517evm.c
+++ b/arch/arm/mach-omap2/board-am3517evm.c
@@ -20,6 +20,8 @@
 #include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/gpio.h>
+#include <linux/irq.h>
+#include <linux/i2c/tsc2004.h>

 #include <mach/hardware.h>
 #include <asm/mach-types.h>
@@ -32,6 +34,59 @@

 #include "mux.h"

+/*
+ * TSC 2004 Support
+ */
+#define	GPIO_TSC2004_IRQ	65
+
+static int tsc2004_init_irq(void)
+{
+	int ret = 0;
+
+	ret = gpio_request(GPIO_TSC2004_IRQ, "tsc2004-irq");
+	if (ret < 0) {
+		printk(KERN_WARNING "failed to request GPIO#%d: %d\n",
+				GPIO_TSC2004_IRQ, ret);
+		return ret;
+	}
+
+	if (gpio_direction_input(GPIO_TSC2004_IRQ)) {
+		printk(KERN_WARNING "GPIO#%d cannot be configured as "
+				"input\n", GPIO_TSC2004_IRQ);
+		return -ENXIO;
+	}
+
+	omap_set_gpio_debounce(GPIO_TSC2004_IRQ, 1);
+	omap_set_gpio_debounce_time(GPIO_TSC2004_IRQ, 0xa);
+	return ret;
+}
+
+static void tsc2004_exit_irq(void)
+{
+	gpio_free(GPIO_TSC2004_IRQ);
+}
+
+static int tsc2004_get_irq_level(void)
+{
+	return gpio_get_value(GPIO_TSC2004_IRQ) ? 0 : 1;
+}
+
+struct tsc2004_platform_data am3517evm_tsc2004data = {
+	.model = 2004,
+	.x_plate_ohms = 180,
+	.get_pendown_state = tsc2004_get_irq_level,
+	.init_platform_hw = tsc2004_init_irq,
+	.exit_platform_hw = tsc2004_exit_irq,
+};
+
+static struct i2c_board_info __initdata am3517evm_tsc_i2c_boardinfo[] = {
+	{
+		I2C_BOARD_INFO("tsc2004", 0x4B),
+		.type		= "tsc2004",
+		.platform_data	= &am3517evm_tsc2004data,
+	},
+};
+
 static int __init am3517_evm_i2c_init(void)
 {
 	omap_register_i2c_bus(1, 400, NULL, 0);
@@ -89,6 +144,11 @@ static void __init am3517_evm_init(void)

 	omap_serial_init();
 	usb_ehci_init(&ehci_pdata);
+	/* TSC 2004 */
+	omap_mux_init_gpio(65, OMAP_PIN_INPUT_PULLUP);
+	am3517evm_tsc_i2c_boardinfo[0].irq = gpio_to_irq(GPIO_TSC2004_IRQ);
+	i2c_register_board_info(1, am3517evm_tsc_i2c_boardinfo,
+				ARRAY_SIZE(am3517evm_tsc_i2c_boardinfo));
 }

 static void __init am3517_evm_map_io(void)
--
1.6.2.4


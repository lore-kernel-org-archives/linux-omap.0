From: hvaibhav@ti.com
Subject: [PATCH 3/3] AM3517: Add support for TSC2004 driver
Date: Thu, 19 Nov 2009 20:17:07 +0530
Message-ID: <1258642027-2520-1-git-send-email-hvaibhav@ti.com>
References: <hvaibhav@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:56063 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753287AbZKSOrE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 19 Nov 2009 09:47:04 -0500
In-Reply-To: <hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Vaibhav Hiremath <hvaibhav@ti.com>

From: Vaibhav Hiremath <hvaibhav@ti.com>


Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
---
 arch/arm/mach-omap2/board-am3517evm.c |   62 +++++++++++++++++++++++++++++++++
 1 files changed, 62 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-am3517evm.c b/arch/arm/mach-omap2/board-am3517evm.c
index 415a13d..ae47b51 100644
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
@@ -27,10 +29,64 @@
 #include <asm/mach/map.h>
 
 #include <plat/board.h>
+#include <plat/mux.h>
 #include <plat/common.h>
 #include <plat/usb.h>
 
 /*
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
+/*
  * Board initialization
  */
 static struct omap_board_config_kernel am3517_evm_config[] __initdata = {
@@ -67,6 +123,12 @@ static void __init am3517_evm_init(void)
 
 	omap_serial_init();
 	usb_ehci_init(&ehci_pdata);
+
+	/* TSC 2004 */
+	omap_cfg_reg(U1_34XX_GPIO65);
+	am3517evm_tsc_i2c_boardinfo[0].irq = gpio_to_irq(GPIO_TSC2004_IRQ);
+	i2c_register_board_info(1, am3517evm_tsc_i2c_boardinfo,
+				ARRAY_SIZE(am3517evm_tsc_i2c_boardinfo));
 }
 
 static void __init am3517_evm_map_io(void)
-- 
1.6.2.4


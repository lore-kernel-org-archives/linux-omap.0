From: hvaibhav@ti.com
Subject: [PATCH 3/4] AM3517: Add RTC-S35390A support
Date: Mon,  4 Jan 2010 19:46:36 +0530
Message-ID: <1262614597-21685-4-git-send-email-hvaibhav@ti.com>
References: <hvaibhav@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:34063 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753424Ab0ADOQo (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 4 Jan 2010 09:16:44 -0500
In-Reply-To: <hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, Vaibhav Hiremath <hvaibhav@ti.com>

From: Vaibhav Hiremath <hvaibhav@ti.com>


Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
---
 arch/arm/mach-omap2/board-am3517evm.c |   30 ++++++++++++++++++++++++++----
 1 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/board-am3517evm.c b/arch/arm/mach-omap2/board-am3517evm.c
index d97e02e..fe6c86d 100644
--- a/arch/arm/mach-omap2/board-am3517evm.c
+++ b/arch/arm/mach-omap2/board-am3517evm.c
@@ -79,14 +79,24 @@ struct tsc2004_platform_data am3517evm_tsc2004data = {
 	.exit_platform_hw = tsc2004_exit_irq,
 };
 
-static struct i2c_board_info __initdata am3517evm_tsc_i2c_boardinfo[] = {
+/*
+ * RTC - S35390A
+ */
+#define	GPIO_RTCS35390A_IRQ	55
+
+static struct i2c_board_info __initdata am3517evm_i2c_boardinfo[] = {
 	{
 		I2C_BOARD_INFO("tsc2004", 0x4B),
 		.type		= "tsc2004",
 		.platform_data	= &am3517evm_tsc2004data,
 	},
+	{
+		I2C_BOARD_INFO("s35390a", 0x30),
+		.type		= "s35390a",
+	},
 };
 
+
 static int __init am3517_evm_i2c_init(void)
 {
 	omap_register_i2c_bus(1, 400, NULL, 0);
@@ -144,11 +154,23 @@ static void __init am3517_evm_init(void)
 
 	omap_serial_init();
 	usb_ehci_init(&ehci_pdata);
+
 	/* TSC 2004 */
 	omap_mux_init_gpio(65, OMAP_PIN_INPUT_PULLUP);
-	am3517evm_tsc_i2c_boardinfo[0].irq = gpio_to_irq(GPIO_TSC2004_IRQ);
-	i2c_register_board_info(1, am3517evm_tsc_i2c_boardinfo,
-				ARRAY_SIZE(am3517evm_tsc_i2c_boardinfo));
+	am3517evm_i2c_boardinfo[0].irq = gpio_to_irq(GPIO_TSC2004_IRQ);
+
+	/* RTC - S35390A */
+	omap_mux_init_gpio(55, OMAP_PIN_INPUT_PULLUP);
+	if (gpio_request(GPIO_RTCS35390A_IRQ, "rtcs35390a-irq") < 0)
+		printk(KERN_WARNING "failed to request GPIO#%d\n",
+				GPIO_RTCS35390A_IRQ);
+	if (gpio_direction_input(GPIO_RTCS35390A_IRQ))
+		printk(KERN_WARNING "GPIO#%d cannot be configured as "
+				"input\n", GPIO_RTCS35390A_IRQ);
+	am3517evm_i2c_boardinfo[1].irq = gpio_to_irq(GPIO_RTCS35390A_IRQ);
+
+	i2c_register_board_info(1, am3517evm_i2c_boardinfo,
+				ARRAY_SIZE(am3517evm_i2c_boardinfo));
 }
 
 static void __init am3517_evm_map_io(void)
-- 
1.6.2.4


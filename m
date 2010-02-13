From: hvaibhav@ti.com
Subject: [PATCH 1/2-V3] AM3517: Enable RTC driver support for AM3517EVM
Date: Sat, 13 Feb 2010 17:17:56 +0530
Message-ID: <1266061677-12681-2-git-send-email-hvaibhav@ti.com>
References: <hvaibhav@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:47239 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753884Ab0BMLsG (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 13 Feb 2010 06:48:06 -0500
In-Reply-To: <hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, Vaibhav Hiremath <hvaibhav@ti.com>

From: Vaibhav Hiremath <hvaibhav@ti.com>

Add platform hook-up interface to support RTC driver (S35390A).

Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
---
 arch/arm/mach-omap2/board-am3517evm.c |   39 +++++++++++++++++++++++++++++++++
 1 files changed, 39 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-am3517evm.c b/arch/arm/mach-omap2/board-am3517evm.c
index 247c700..9589e46 100644
--- a/arch/arm/mach-omap2/board-am3517evm.c
+++ b/arch/arm/mach-omap2/board-am3517evm.c
@@ -175,6 +175,39 @@ struct platform_device am3517_evm_dss_device = {
 	},
 };

+static struct i2c_board_info __initdata am3517evm_i2c_boardinfo[] = {
+	{
+		I2C_BOARD_INFO("s35390a", 0x30),
+		.type		= "s35390a",
+	},
+};
+
+/*
+ * RTC - S35390A
+ */
+#define GPIO_RTCS35390A_IRQ	55
+
+static void __init am3517_evm_rtc_init(void)
+{
+	int r;
+
+	omap_mux_init_gpio(GPIO_RTCS35390A_IRQ, OMAP_PIN_INPUT_PULLUP);
+	r = gpio_request(GPIO_RTCS35390A_IRQ, "rtcs35390a-irq");
+	if (r < 0) {
+		printk(KERN_WARNING "failed to request GPIO#%d\n",
+				GPIO_RTCS35390A_IRQ);
+		return;
+	}
+	r = gpio_direction_input(GPIO_RTCS35390A_IRQ);
+	if (r < 0) {
+		printk(KERN_WARNING "GPIO#%d cannot be configured as input\n",
+				GPIO_RTCS35390A_IRQ);
+		gpio_free(GPIO_RTCS35390A_IRQ);
+		return;
+	}
+	am3517evm_i2c_boardinfo[0].irq = gpio_to_irq(GPIO_RTCS35390A_IRQ);
+}
+
 static int __init am3517_evm_i2c_init(void)
 {
 	omap_register_i2c_bus(1, 400, NULL, 0);
@@ -235,6 +268,12 @@ static void __init am3517_evm_init(void)
 	usb_ehci_init(&ehci_pdata);
 	/* DSS */
 	am3517_evm_display_init();
+
+	/* RTC - S35390A */
+	am3517_evm_rtc_init();
+
+	i2c_register_board_info(1, am3517evm_i2c_boardinfo,
+				ARRAY_SIZE(am3517evm_i2c_boardinfo));
 }

 static void __init am3517_evm_map_io(void)
--
1.6.2.4


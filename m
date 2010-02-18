From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 19/23] AM3517: Enable RTC driver support for AM3517EVM
Date: Wed, 17 Feb 2010 17:32:38 -0800
Message-ID: <20100218013238.32075.67764.stgit@baageli.muru.com>
References: <20100218013012.32075.43788.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:63599 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751657Ab0BRBbt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Feb 2010 20:31:49 -0500
In-Reply-To: <20100218013012.32075.43788.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, Vaibhav Hiremath <hvaibhav@ti.com>

From: Vaibhav Hiremath <hvaibhav@ti.com>

Add platform hook-up interface to support RTC driver (S35390A).

Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-am3517evm.c |   39 +++++++++++++++++++++++++++++++++
 1 files changed, 39 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-am3517evm.c b/arch/arm/mach-omap2/board-am3517evm.c
index af99faf..fe2446d 100644
--- a/arch/arm/mach-omap2/board-am3517evm.c
+++ b/arch/arm/mach-omap2/board-am3517evm.c
@@ -38,6 +38,39 @@
 #define LCD_PANEL_BKLIGHT_PWR	182
 #define LCD_PANEL_PWM		181
 
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


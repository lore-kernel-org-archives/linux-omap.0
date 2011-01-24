From: hvaibhav@ti.com
Subject: [PATCH] OMAP3EVM:FIX: Reset the SMSC911x Ethernet controller in board_init
Date: Mon, 24 Jan 2011 20:11:48 +0530
Message-ID: <1295880108-15584-1-git-send-email-hvaibhav@ti.com>
References: <hvaibhav@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:45424 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753088Ab1AXOly (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 24 Jan 2011 09:41:54 -0500
In-Reply-To: <hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: charu@ti.com, khilman@ti.com, tony@atomide.com, Vaibhav Hiremath <hvaibhav@ti.com>

From: Vaibhav Hiremath <hvaibhav@ti.com>

With addition of HWMOD support to GPIO, the Ethernet controller
goes undetected for OMAP35xEVM. So explicitely assert the reset signal to
Ethernet controller smsc911x -

	- GPIO7 (>=RevG version of EVM's)
	- GPIO64 (<=RevD version of EVM's)

I have tested this patch on RevG version of EVM with ES3.1 Si.
This patch is based on intial version from Charulatha V.

Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
---
NOTE: I have not been able to test it on older version of EVM's.

 arch/arm/mach-omap2/board-omap3evm.c |   27 ++++++++++++++++++++++++++-
 1 files changed, 26 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index 212d88c..336c012 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -124,10 +124,15 @@ static struct platform_device omap3evm_smsc911x_device = {

 static inline void __init omap3evm_init_smsc911x(void)
 {
-	int eth_cs;
+	int eth_cs, eth_rst;
 	struct clk *l3ck;
 	unsigned int rate;

+	if (get_omap3_evm_rev() == OMAP3EVM_BOARD_GEN_1)
+		eth_rst = 64;
+	else
+		eth_rst = 7;
+
 	eth_cs = OMAP3EVM_SMSC911X_CS;

 	l3ck = clk_get(NULL, "l3_ck");
@@ -136,6 +141,22 @@ static inline void __init omap3evm_init_smsc911x(void)
 	else
 		rate = clk_get_rate(l3ck);

+	/* Configure ethernet controller reset gpio */
+	if (cpu_is_omap3430()) {
+		if (gpio_request(eth_rst, "SMSC911x gpio") < 0) {
+			pr_err(KERN_ERR "Failed to request GPIO7 for smsc911x\n");
+			return;
+		}
+
+		gpio_direction_output(eth_rst, 1);
+		/* reset pulse to ethernet controller*/
+		usleep_range(150, 220);
+		gpio_set_value(eth_rst, 0);
+		usleep_range(150, 220);
+		gpio_set_value(eth_rst, 1);
+		usleep_range(1, 2);
+	}
+
 	if (gpio_request(OMAP3EVM_ETHR_GPIO_IRQ, "SMSC911x irq") < 0) {
 		printk(KERN_ERR "Failed to request GPIO%d for smsc911x IRQ\n",
 			OMAP3EVM_ETHR_GPIO_IRQ);
@@ -703,6 +724,10 @@ static struct omap_board_mux omap35x_board_mux[] __initdata = {
 	OMAP3_MUX(MCSPI1_CS1, OMAP_MUX_MODE4 | OMAP_PIN_INPUT_PULLUP |
 				OMAP_PIN_OFF_INPUT_PULLUP | OMAP_PIN_OFF_OUTPUT_LOW |
 				OMAP_PIN_OFF_WAKEUPENABLE),
+	OMAP3_MUX(SYS_BOOT5, OMAP_MUX_MODE4 | OMAP_PIN_INPUT_PULLUP |
+				OMAP_PIN_OFF_NONE),
+	OMAP3_MUX(GPMC_WAIT2, OMAP_MUX_MODE4 | OMAP_PIN_INPUT_PULLUP |
+				OMAP_PIN_OFF_NONE),
 	{ .reg_offset = OMAP_MUX_TERMINATOR },
 };

--
1.6.2.4


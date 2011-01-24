From: Vaibhav Hiremath <hvaibhav@ti.com>
Subject: [PATCH-V2] OMAP3EVM:FIX: Reset the smsc911x ethernet controller in board_init
Date: Tue, 25 Jan 2011 00:55:55 +0530
Message-ID: <1295897155-31456-1-git-send-email-hvaibhav@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48040 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750772Ab1AXT0A (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 24 Jan 2011 14:26:00 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, khilman@ti.com, Vaibhav Hiremath <hvaibhav@ti.com>

With addition of hwmod support to gpio, the ethernet controller
goes undetected for OMAP35xEVM. So explicitly assert the reset signal to
ethernet controller smsc911x -

	- GPIO7 (>=RevG version of EVM's)
	- GPIO64 (<=RevD version of EVM's)

Tested this patch on RevG version of EVM with ES3.1 Si.

This patch is based on intial version from Charulatha V, reference
to original discussion -
http://www.mail-archive.com/linux-omap@vger.kernel.org/msg35784.html
Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
---
Changes from V1 -
	- Removed hardcoded value for rst gpio
	- Added check for return value to gpio_direction_output api

 arch/arm/mach-omap2/board-omap3evm.c |   39 +++++++++++++++++++++++++++++++++-
 1 files changed, 38 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index a888a7d..1716f4c 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -58,6 +58,13 @@
 #define OMAP3EVM_ETHR_ID_REV	0x50
 #define OMAP3EVM_ETHR_GPIO_IRQ	176
 #define OMAP3EVM_SMSC911X_CS	5
+/*
+ * Eth Reset signal
+ *	64 = Generation 1 (<=RevD)
+ *	7 = Generation 2 (>=RevE)
+ */
+#define OMAP3EVM_GEN1_ETHR_GPIO_RST	64
+#define OMAP3EVM_GEN2_ETHR_GPIO_RST	7

 static u8 omap3_evm_version;

@@ -124,10 +131,15 @@ static struct platform_device omap3evm_smsc911x_device = {

 static inline void __init omap3evm_init_smsc911x(void)
 {
-	int eth_cs;
+	int eth_cs, eth_rst;
 	struct clk *l3ck;
 	unsigned int rate;

+	if (get_omap3_evm_rev() == OMAP3EVM_BOARD_GEN_1)
+		eth_rst = OMAP3EVM_GEN1_ETHR_GPIO_RST;
+	else
+		eth_rst = OMAP3EVM_GEN2_ETHR_GPIO_RST;
+
 	eth_cs = OMAP3EVM_SMSC911X_CS;

 	l3ck = clk_get(NULL, "l3_ck");
@@ -136,6 +148,27 @@ static inline void __init omap3evm_init_smsc911x(void)
 	else
 		rate = clk_get_rate(l3ck);

+	/* Configure ethernet controller reset gpio */
+	if (cpu_is_omap3430()) {
+		if (gpio_request(eth_rst, "SMSC911x gpio") < 0) {
+			pr_err(KERN_ERR "Failed to request %d for smsc911x\n",
+					eth_rst);
+			return;
+		}
+
+		if (gpio_direction_output(eth_rst, 1) < 0) {
+			pr_err(KERN_ERR "Failed to set direction of %d for" \
+					" smsc911x\n", eth_rst);
+			return;
+		}
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
@@ -689,6 +722,10 @@ static struct omap_board_mux omap35x_board_mux[] __initdata = {
 				OMAP_PIN_OFF_WAKEUPENABLE),
 	OMAP3_MUX(MCSPI1_CS1, OMAP_MUX_MODE4 | OMAP_PIN_INPUT_PULLUP |
 				OMAP_PIN_OFF_INPUT_PULLUP | OMAP_PIN_OFF_OUTPUT_LOW),
+	OMAP3_MUX(SYS_BOOT5, OMAP_MUX_MODE4 | OMAP_PIN_INPUT_PULLUP |
+				OMAP_PIN_OFF_NONE),
+	OMAP3_MUX(GPMC_WAIT2, OMAP_MUX_MODE4 | OMAP_PIN_INPUT_PULLUP |
+				OMAP_PIN_OFF_NONE),
 	{ .reg_offset = OMAP_MUX_TERMINATOR },
 };

--
1.6.2.4


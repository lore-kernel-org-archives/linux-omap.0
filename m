From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: [PATCH RFC:] FIX: OMAP3EVM: Ethernet controller smsc911x reset
Date: Sat, 25 Sep 2010 17:06:33 +0530
Message-ID: <1285414593-28013-1-git-send-email-charu@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:36464 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755335Ab0IYLgq (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 25 Sep 2010 07:36:46 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, tony@atomide.com, premi@ti.com, "Varadarajan, Charulatha" <charu@ti.com>

Do reset of Ethernet controller smsc911x using OMAP gpio7
while initializing the Ethernet controller.

Signed-off-by: Charulatha V <charu@ti.com>
---
 arch/arm/mach-omap2/board-omap3evm.c |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index f76d9c0..54a7e20 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -55,6 +55,7 @@
 #define OMAP3EVM_ETHR_SIZE	1024
 #define OMAP3EVM_ETHR_ID_REV	0x50
 #define OMAP3EVM_ETHR_GPIO_IRQ	176
+#define OMAP3EVM_ETHR_GPIO_RST  7
 #define OMAP3EVM_SMSC911X_CS	5
 
 static u8 omap3_evm_version;
@@ -134,6 +135,20 @@ static inline void __init omap3evm_init_smsc911x(void)
 	else
 		rate = clk_get_rate(l3ck);
 
+	/* Configure ethernet controller reset gpio */
+	if (gpio_request(OMAP3EVM_ETHR_GPIO_RST, "SMSC911x gpio") < 0) {
+		pr_err(KERN_ERR "Failed to request GPIO8 for smsc911x gpio\n");
+		return;
+	}
+
+	gpio_direction_output(OMAP3EVM_ETHR_GPIO_RST, 1);
+
+	/* reset pulse to ethernet controller*/
+	gpio_set_value(OMAP3EVM_ETHR_GPIO_RST, 0);
+	usleep_range(150, 220);
+	gpio_set_value(OMAP3EVM_ETHR_GPIO_RST, 1);
+	usleep_range(1, 2);
+
 	if (gpio_request(OMAP3EVM_ETHR_GPIO_IRQ, "SMSC911x irq") < 0) {
 		printk(KERN_ERR "Failed to request GPIO%d for smsc911x IRQ\n",
 			OMAP3EVM_ETHR_GPIO_IRQ);
-- 
1.7.0.4


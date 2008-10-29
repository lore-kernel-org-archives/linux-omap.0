From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: [RFC 13/21] ARM: OMAP: Complete OMAP1 board files gpiolib conversion
Date: Wed, 29 Oct 2008 13:36:21 +0200
Message-ID: <1225280189-6559-14-git-send-email-jarkko.nikula@nokia.com>
References: <1225280189-6559-1-git-send-email-jarkko.nikula@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:59950 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753440AbYJ2Lhy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Oct 2008 07:37:54 -0400
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m9TBbbhu018092
	for <linux-omap@vger.kernel.org>; Wed, 29 Oct 2008 13:37:52 +0200
In-Reply-To: <1225280189-6559-1-git-send-email-jarkko.nikula@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Jarkko Nikula <jarkko.nikula@nokia.com>

Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
---
 arch/arm/mach-omap1/board-fsample.c   |    5 +++--
 arch/arm/mach-omap1/board-h2.c        |   15 ++++++++-------
 arch/arm/mach-omap1/board-h3.c        |    7 ++++---
 arch/arm/mach-omap1/board-innovator.c |    2 +-
 arch/arm/mach-omap1/board-nokia770.c  |    2 +-
 arch/arm/mach-omap1/board-palmte.c    |    4 ++--
 arch/arm/mach-omap1/board-palmz71.c   |    4 ++--
 arch/arm/mach-omap1/board-perseus2.c  |    5 +++--
 arch/arm/mach-omap1/board-sx1.c       |    6 +++---
 arch/arm/mach-omap1/board-voiceblue.c |   16 ++++++++--------
 10 files changed, 35 insertions(+), 31 deletions(-)

diff --git a/arch/arm/mach-omap1/board-fsample.c b/arch/arm/mach-omap1/board-fsample.c
index 68da313..3030829 100644
--- a/arch/arm/mach-omap1/board-fsample.c
+++ b/arch/arm/mach-omap1/board-fsample.c
@@ -223,8 +223,9 @@ static struct omap_board_config_kernel fsample_config[] = {
 
 static void __init omap_fsample_init(void)
 {
-	if (!(omap_request_gpio(P2_NAND_RB_GPIO_PIN)))
-		nand_data.dev_ready = nand_dev_ready;
+	if (gpio_request(P2_NAND_RB_GPIO_PIN, "NAND ready") < 0)
+		BUG();
+	nand_data.dev_ready = nand_dev_ready;
 
 	omap_cfg_reg(L3_1610_FLASH_CS2B_OE);
 	omap_cfg_reg(M8_1610_FLASH_CS2B_WE);
diff --git a/arch/arm/mach-omap1/board-h2.c b/arch/arm/mach-omap1/board-h2.c
index a621440..7cbed54 100644
--- a/arch/arm/mach-omap1/board-h2.c
+++ b/arch/arm/mach-omap1/board-h2.c
@@ -431,7 +431,7 @@ static struct platform_device *h2_devices[] __initdata = {
 
 static void __init h2_init_smc91x(void)
 {
-	if ((omap_request_gpio(0)) < 0) {
+	if (gpio_request(0, "SMC91x irq") < 0) {
 		printk("Error requesting gpio 0 for smc91x irq\n");
 		return;
 	}
@@ -522,8 +522,9 @@ static void __init h2_init(void)
 
 	h2_nand_resource.end = h2_nand_resource.start = OMAP_CS2B_PHYS;
 	h2_nand_resource.end += SZ_4K - 1;
-	if (!(omap_request_gpio(H2_NAND_RB_GPIO_PIN)))
-		h2_nand_data.dev_ready = h2_nand_dev_ready;
+	if (gpio_request(H2_NAND_RB_GPIO_PIN, "NAND ready") < 0)
+		BUG();
+	gpio_direction_input(H2_NAND_RB_GPIO_PIN);
 
 	omap_cfg_reg(L3_1610_FLASH_CS2B_OE);
 	omap_cfg_reg(M8_1610_FLASH_CS2B_WE);
@@ -535,10 +536,10 @@ static void __init h2_init(void)
 	/* Irda */
 #if defined(CONFIG_OMAP_IR) || defined(CONFIG_OMAP_IR_MODULE)
 	omap_writel(omap_readl(FUNC_MUX_CTRL_A) | 7, FUNC_MUX_CTRL_A);
-	if (!(omap_request_gpio(H2_IRDA_FIRSEL_GPIO_PIN))) {
-		gpio_direction_output(H2_IRDA_FIRSEL_GPIO_PIN, 0);
-		h2_irda_data.transceiver_mode = h2_transceiver_mode;
-	}
+	if (gpio_request(H2_IRDA_FIRSEL_GPIO_PIN, "IRDA mode") < 0)
+		BUG();
+	gpio_direction_output(H2_IRDA_FIRSEL_GPIO_PIN, 0);
+	h2_irda_data.transceiver_mode = h2_transceiver_mode;
 #endif
 
 	platform_add_devices(h2_devices, ARRAY_SIZE(h2_devices));
diff --git a/arch/arm/mach-omap1/board-h3.c b/arch/arm/mach-omap1/board-h3.c
index fe9eebf..da29f4c 100644
--- a/arch/arm/mach-omap1/board-h3.c
+++ b/arch/arm/mach-omap1/board-h3.c
@@ -608,8 +608,9 @@ static void __init h3_init(void)
 
 	nand_resource.end = nand_resource.start = OMAP_CS2B_PHYS;
 	nand_resource.end += SZ_4K - 1;
-	if (!(omap_request_gpio(H3_NAND_RB_GPIO_PIN)))
-		nand_data.dev_ready = nand_dev_ready;
+	if (gpio_request(H3_NAND_RB_GPIO_PIN, "NAND ready") < 0)
+		BUG();
+	nand_data.dev_ready = nand_dev_ready;
 
 	/* GPIO10 Func_MUX_CTRL reg bit 29:27, Configure V2 to mode1 as GPIO */
 	/* GPIO10 pullup/down register, Enable pullup on GPIO10 */
@@ -635,7 +636,7 @@ static void __init h3_init(void)
 static void __init h3_init_smc91x(void)
 {
 	omap_cfg_reg(W15_1710_GPIO40);
-	if (omap_request_gpio(40) < 0) {
+	if (gpio_request(40, "SMC91x irq") < 0) {
 		printk("Error requesting gpio 40 for smc91x irq\n");
 		return;
 	}
diff --git a/arch/arm/mach-omap1/board-innovator.c b/arch/arm/mach-omap1/board-innovator.c
index 7a97f6b..eee0657 100644
--- a/arch/arm/mach-omap1/board-innovator.c
+++ b/arch/arm/mach-omap1/board-innovator.c
@@ -302,7 +302,7 @@ static void __init innovator_init_smc91x(void)
 			   OMAP1510_FPGA_RST);
 		udelay(750);
 	} else {
-		if ((omap_request_gpio(0)) < 0) {
+		if (gpio_request(0, "SMC91x irq") < 0)
 			printk("Error requesting gpio 0 for smc91x irq\n");
 			return;
 		}
diff --git a/arch/arm/mach-omap1/board-nokia770.c b/arch/arm/mach-omap1/board-nokia770.c
index 3e4625e..7f50fad 100644
--- a/arch/arm/mach-omap1/board-nokia770.c
+++ b/arch/arm/mach-omap1/board-nokia770.c
@@ -126,7 +126,7 @@ static void mipid_dev_init(void)
 
 static void ads7846_dev_init(void)
 {
-	if (omap_request_gpio(ADS7846_PENDOWN_GPIO) < 0)
+	if (gpio_request(ADS7846_PENDOWN_GPIO, "ADS7846 pendown") < 0)
 		printk(KERN_ERR "can't get ads7846 pen down GPIO\n");
 }
 
diff --git a/arch/arm/mach-omap1/board-palmte.c b/arch/arm/mach-omap1/board-palmte.c
index 3548bc2..cc99031 100644
--- a/arch/arm/mach-omap1/board-palmte.c
+++ b/arch/arm/mach-omap1/board-palmte.c
@@ -369,14 +369,14 @@ static struct omap_gpio_switch palmte_switches[] __initdata = {
 static void __init palmte_misc_gpio_setup(void)
 {
 	/* Set TSC2102 PINTDAV pin as input (used by TSC2102 driver) */
-	if (omap_request_gpio(PALMTE_PINTDAV_GPIO)) {
+	if (gpio_request(PALMTE_PINTDAV_GPIO, "TSC2102 PINTDAV") < 0) {
 		printk(KERN_ERR "Could not reserve PINTDAV GPIO!\n");
 		return;
 	}
 	gpio_direction_input(PALMTE_PINTDAV_GPIO);
 
 	/* Set USB-or-DC-IN pin as input (unused) */
-	if (omap_request_gpio(PALMTE_USB_OR_DC_GPIO)) {
+	if (gpio_request(PALMTE_USB_OR_DC_GPIO, "USB/DC-IN") < 0) {
 		printk(KERN_ERR "Could not reserve cable signal GPIO!\n");
 		return;
 	}
diff --git a/arch/arm/mach-omap1/board-palmz71.c b/arch/arm/mach-omap1/board-palmz71.c
index b44fde6..cc05257 100644
--- a/arch/arm/mach-omap1/board-palmz71.c
+++ b/arch/arm/mach-omap1/board-palmz71.c
@@ -315,14 +315,14 @@ palmz71_gpio_setup(int early)
 		gpio_direction_output(1, 1);
 	} else {
 		/* Set MMC/SD host WP pin as input */
-		if (omap_request_gpio(PALMZ71_MMC_WP_GPIO)) {
+		if (gpio_request(PALMZ71_MMC_WP_GPIO, "MMC WP") < 0) {
 			printk(KERN_ERR "Could not reserve WP GPIO!\n");
 			return;
 		}
 		gpio_direction_input(PALMZ71_MMC_WP_GPIO);
 
 		/* Monitor the Power-cable-connected signal */
-		if (omap_request_gpio(PALMZ71_USBDETECT_GPIO)) {
+		if (gpio_request(PALMZ71_USBDETECT_GPIO, "USB detect") < 0) {
 			printk(KERN_ERR
 				"Could not reserve cable signal GPIO!\n");
 			return;
diff --git a/arch/arm/mach-omap1/board-perseus2.c b/arch/arm/mach-omap1/board-perseus2.c
index b8f0077..3b9f907 100644
--- a/arch/arm/mach-omap1/board-perseus2.c
+++ b/arch/arm/mach-omap1/board-perseus2.c
@@ -223,8 +223,9 @@ static struct omap_board_config_kernel perseus2_config[] __initdata = {
 
 static void __init omap_perseus2_init(void)
 {
-	if (!(omap_request_gpio(P2_NAND_RB_GPIO_PIN)))
-		nand_data.dev_ready = nand_dev_ready;
+	if (gpio_request(P2_NAND_RB_GPIO_PIN, "NAND ready") < 0)
+		BUG();
+	nand_data.dev_ready = nand_dev_ready;
 
 	omap_cfg_reg(L3_1610_FLASH_CS2B_OE);
 	omap_cfg_reg(M8_1610_FLASH_CS2B_WE);
diff --git a/arch/arm/mach-omap1/board-sx1.c b/arch/arm/mach-omap1/board-sx1.c
index 786c6a0..bfafba2 100644
--- a/arch/arm/mach-omap1/board-sx1.c
+++ b/arch/arm/mach-omap1/board-sx1.c
@@ -424,9 +424,9 @@ static void __init omap_sx1_init(void)
 
 	/* turn on USB power */
 	/* sx1_setusbpower(1); cant do it here because i2c is not ready */
-	omap_request_gpio(1);	/* A_IRDA_OFF */
-	omap_request_gpio(11);	/* A_SWITCH */
-	omap_request_gpio(15);	/* A_USB_ON */
+	gpio_request(1, "A_IRDA_OFF");
+	gpio_request(11, "A_SWITCH");
+	gpio_request(15, "A_USB_ON");
 	gpio_direction_output(1, 1);	/*A_IRDA_OFF = 1 */
 	gpio_direction_output(11, 0);	/*A_SWITCH = 0 */
 	gpio_direction_output(15, 0);	/*A_USB_ON = 0 */
diff --git a/arch/arm/mach-omap1/board-voiceblue.c b/arch/arm/mach-omap1/board-voiceblue.c
index abf6cb4..c224f3c 100644
--- a/arch/arm/mach-omap1/board-voiceblue.c
+++ b/arch/arm/mach-omap1/board-voiceblue.c
@@ -160,23 +160,23 @@ static void __init voiceblue_init_irq(void)
 static void __init voiceblue_init(void)
 {
 	/* Watchdog */
-	omap_request_gpio(0);
+	gpio_request(0, "Watchdog");
 	/* smc91x reset */
-	omap_request_gpio(7);
+	gpio_request(7, "SMC91x reset");
 	gpio_direction_output(7, 1);
 	udelay(2);	/* wait at least 100ns */
 	gpio_set_value(7, 0);
 	mdelay(50);	/* 50ms until PHY ready */
 	/* smc91x interrupt pin */
-	omap_request_gpio(8);
+	gpio_request(8, "SMC91x irq");
 	/* 16C554 reset*/
-	omap_request_gpio(6);
+	gpio_request(6, "16C554 reset");
 	gpio_direction_output(6, 0);
 	/* 16C554 interrupt pins */
-	omap_request_gpio(12);
-	omap_request_gpio(13);
-	omap_request_gpio(14);
-	omap_request_gpio(15);
+	gpio_request(12, "16C554 irq");
+	gpio_request(13, "16C554 irq");
+	gpio_request(14, "16C554 irq");
+	gpio_request(15, "16C554 irq");
 	set_irq_type(gpio_to_irq(12), IRQ_TYPE_EDGE_RISING);
 	set_irq_type(gpio_to_irq(13), IRQ_TYPE_EDGE_RISING);
 	set_irq_type(gpio_to_irq(14), IRQ_TYPE_EDGE_RISING);
-- 
1.5.6.5


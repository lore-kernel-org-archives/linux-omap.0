From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 10/11] ARM: OMAP: Switch to gpio_request/free calls
Date: Fri, 28 Nov 2008 17:10:57 -0800
Message-ID: <20081129011057.12337.69529.stgit@localhost>
References: <20081129010728.12337.8217.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:58483 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754671AbYK2BK4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 28 Nov 2008 20:10:56 -0500
In-Reply-To: <20081129010728.12337.8217.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, Jarkko Nikula <jarkko.nikula@nokia.com>

From: Jarkko Nikula <jarkko.nikula@nokia.com>

Switch to gpio_request/free calls

Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap1/board-fsample.c   |    5 +++--
 arch/arm/mach-omap1/board-h2.c        |   15 ++++++++-------
 arch/arm/mach-omap1/board-h3.c        |    7 ++++---
 arch/arm/mach-omap1/board-innovator.c |    2 +-
 arch/arm/mach-omap1/board-nokia770.c  |    2 +-
 arch/arm/mach-omap1/board-palmte.c    |    4 ++--
 arch/arm/mach-omap1/board-palmz71.c   |    4 ++--
 arch/arm/mach-omap1/board-perseus2.c  |    5 +++--
 arch/arm/mach-omap1/board-voiceblue.c |   16 ++++++++--------
 arch/arm/mach-omap1/fpga.c            |    2 +-
 arch/arm/mach-omap1/leds.c            |    4 ++--
 arch/arm/mach-omap1/serial.c          |    4 ++--
 arch/arm/mach-omap2/board-2430sdp.c   |    2 +-
 arch/arm/mach-omap2/board-apollon.c   |    4 ++--
 arch/arm/mach-omap2/usb-tusb6010.c    |    4 ++--
 arch/arm/plat-omap/debug-devices.c    |    2 +-
 16 files changed, 43 insertions(+), 39 deletions(-)

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
index 7329ad5..c5b4a3b 100644
--- a/arch/arm/mach-omap1/board-h2.c
+++ b/arch/arm/mach-omap1/board-h2.c
@@ -339,7 +339,7 @@ static struct platform_device *h2_devices[] __initdata = {
 
 static void __init h2_init_smc91x(void)
 {
-	if ((omap_request_gpio(0)) < 0) {
+	if (gpio_request(0, "SMC91x irq") < 0) {
 		printk("Error requesting gpio 0 for smc91x irq\n");
 		return;
 	}
@@ -425,8 +425,9 @@ static void __init h2_init(void)
 
 	h2_nand_resource.end = h2_nand_resource.start = OMAP_CS2B_PHYS;
 	h2_nand_resource.end += SZ_4K - 1;
-	if (!(omap_request_gpio(H2_NAND_RB_GPIO_PIN)))
-		h2_nand_data.dev_ready = h2_nand_dev_ready;
+	if (gpio_request(H2_NAND_RB_GPIO_PIN, "NAND ready") < 0)
+		BUG();
+	gpio_direction_input(H2_NAND_RB_GPIO_PIN);
 
 	omap_cfg_reg(L3_1610_FLASH_CS2B_OE);
 	omap_cfg_reg(M8_1610_FLASH_CS2B_WE);
@@ -438,10 +439,10 @@ static void __init h2_init(void)
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
index c524f47..0332203 100644
--- a/arch/arm/mach-omap1/board-h3.c
+++ b/arch/arm/mach-omap1/board-h3.c
@@ -516,8 +516,9 @@ static void __init h3_init(void)
 
 	nand_resource.end = nand_resource.start = OMAP_CS2B_PHYS;
 	nand_resource.end += SZ_4K - 1;
-	if (!(omap_request_gpio(H3_NAND_RB_GPIO_PIN)))
-		nand_data.dev_ready = nand_dev_ready;
+	if (gpio_request(H3_NAND_RB_GPIO_PIN, "NAND ready") < 0)
+		BUG();
+	nand_data.dev_ready = nand_dev_ready;
 
 	/* GPIO10 Func_MUX_CTRL reg bit 29:27, Configure V2 to mode1 as GPIO */
 	/* GPIO10 pullup/down register, Enable pullup on GPIO10 */
@@ -537,7 +538,7 @@ static void __init h3_init(void)
 static void __init h3_init_smc91x(void)
 {
 	omap_cfg_reg(W15_1710_GPIO40);
-	if (omap_request_gpio(40) < 0) {
+	if (gpio_request(40, "SMC91x irq") < 0) {
 		printk("Error requesting gpio 40 for smc91x irq\n");
 		return;
 	}
diff --git a/arch/arm/mach-omap1/board-innovator.c b/arch/arm/mach-omap1/board-innovator.c
index cbc11be..dd6b54a 100644
--- a/arch/arm/mach-omap1/board-innovator.c
+++ b/arch/arm/mach-omap1/board-innovator.c
@@ -301,7 +301,7 @@ static void __init innovator_init_smc91x(void)
 			   OMAP1510_FPGA_RST);
 		udelay(750);
 	} else {
-		if ((omap_request_gpio(0)) < 0) {
+		if (gpio_request(0, "SMC91x irq") < 0)
 			printk("Error requesting gpio 0 for smc91x irq\n");
 			return;
 		}
diff --git a/arch/arm/mach-omap1/board-nokia770.c b/arch/arm/mach-omap1/board-nokia770.c
index e0576f5..b267824 100644
--- a/arch/arm/mach-omap1/board-nokia770.c
+++ b/arch/arm/mach-omap1/board-nokia770.c
@@ -124,7 +124,7 @@ static void mipid_dev_init(void)
 
 static void ads7846_dev_init(void)
 {
-	if (omap_request_gpio(ADS7846_PENDOWN_GPIO) < 0)
+	if (gpio_request(ADS7846_PENDOWN_GPIO, "ADS7846 pendown") < 0)
 		printk(KERN_ERR "can't get ads7846 pen down GPIO\n");
 }
 
diff --git a/arch/arm/mach-omap1/board-palmte.c b/arch/arm/mach-omap1/board-palmte.c
index 0995a0f..4141e39 100644
--- a/arch/arm/mach-omap1/board-palmte.c
+++ b/arch/arm/mach-omap1/board-palmte.c
@@ -347,14 +347,14 @@ static void palmte_headphones_detect(void *data, int state)
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
index 1b7d358..801fb5f 100644
--- a/arch/arm/mach-omap1/board-palmz71.c
+++ b/arch/arm/mach-omap1/board-palmz71.c
@@ -326,14 +326,14 @@ palmz71_gpio_setup(int early)
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
diff --git a/arch/arm/mach-omap1/board-voiceblue.c b/arch/arm/mach-omap1/board-voiceblue.c
index bb4f4a8..92c9de1 100644
--- a/arch/arm/mach-omap1/board-voiceblue.c
+++ b/arch/arm/mach-omap1/board-voiceblue.c
@@ -168,23 +168,23 @@ static void __init voiceblue_init_irq(void)
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
diff --git a/arch/arm/mach-omap1/fpga.c b/arch/arm/mach-omap1/fpga.c
index 55748ec..4f2b8a7 100644
--- a/arch/arm/mach-omap1/fpga.c
+++ b/arch/arm/mach-omap1/fpga.c
@@ -177,7 +177,7 @@ void omap1510_fpga_init_irq(void)
 	 * NOTE: For general GPIO/MPUIO access and interrupts, please see
 	 * gpio.[ch]
 	 */
-	omap_request_gpio(13);
+	gpio_request(13, "FPGA irq");
 	gpio_direction_input(13);
 	set_irq_type(gpio_to_irq(13), IRQ_TYPE_EDGE_RISING);
 	set_irq_chained_handler(OMAP1510_INT_FPGA, innovator_fpga_IRQ_demux);
diff --git a/arch/arm/mach-omap1/leds.c b/arch/arm/mach-omap1/leds.c
index 540434e..8cbf256 100644
--- a/arch/arm/mach-omap1/leds.c
+++ b/arch/arm/mach-omap1/leds.c
@@ -47,13 +47,13 @@ omap_leds_init(void)
 		 * that's a different kind of LED (just one color at a time).
 		 */
 		omap_cfg_reg(P18_1610_GPIO3);
-		if (omap_request_gpio(3) == 0)
+		if (gpio_request(3, "LED red") == 0)
 			gpio_direction_output(3, 1);
 		else
 			printk(KERN_WARNING "LED: can't get GPIO3/red?\n");
 
 		omap_cfg_reg(MPUIO4);
-		if (omap_request_gpio(OMAP_MPUIO(4)) == 0)
+		if (gpio_request(OMAP_MPUIO(4), "LED green") == 0)
 			gpio_direction_output(OMAP_MPUIO(4), 1);
 		else
 			printk(KERN_WARNING "LED: can't get MPUIO4/green?\n");
diff --git a/arch/arm/mach-omap1/serial.c b/arch/arm/mach-omap1/serial.c
index b63da3f..0002084 100644
--- a/arch/arm/mach-omap1/serial.c
+++ b/arch/arm/mach-omap1/serial.c
@@ -244,7 +244,7 @@ static void __init omap_serial_set_port_wakeup(int gpio_nr)
 {
 	int ret;
 
-	ret = omap_request_gpio(gpio_nr);
+	ret = gpio_request(gpio_nr, "UART wake");
 	if (ret < 0) {
 		printk(KERN_ERR "Could not request UART wake GPIO: %i\n",
 		       gpio_nr);
@@ -254,7 +254,7 @@ static void __init omap_serial_set_port_wakeup(int gpio_nr)
 	ret = request_irq(gpio_to_irq(gpio_nr), &omap_serial_wake_interrupt,
 			  IRQF_TRIGGER_RISING, "serial wakeup", NULL);
 	if (ret) {
-		omap_free_gpio(gpio_nr);
+		gpio_free(gpio_nr);
 		printk(KERN_ERR "No interrupt for UART wake GPIO: %i\n",
 		       gpio_nr);
 		return;
diff --git a/arch/arm/mach-omap2/board-2430sdp.c b/arch/arm/mach-omap2/board-2430sdp.c
index f844a67..6748de6 100644
--- a/arch/arm/mach-omap2/board-2430sdp.c
+++ b/arch/arm/mach-omap2/board-2430sdp.c
@@ -168,7 +168,7 @@ static inline void __init sdp2430_init_smc91x(void)
 	sdp2430_smc91x_resources[0].end = cs_mem_base + 0x30f;
 	udelay(100);
 
-	if (omap_request_gpio(OMAP24XX_ETHR_GPIO_IRQ) < 0) {
+	if (gpio_request(OMAP24XX_ETHR_GPIO_IRQ, "SMC91x irq") < 0) {
 		printk(KERN_ERR "Failed to request GPIO%d for smc91x IRQ\n",
 			OMAP24XX_ETHR_GPIO_IRQ);
 		gpmc_cs_free(eth_cs);
diff --git a/arch/arm/mach-omap2/board-apollon.c b/arch/arm/mach-omap2/board-apollon.c
index ab6b8cd..d83035b 100644
--- a/arch/arm/mach-omap2/board-apollon.c
+++ b/arch/arm/mach-omap2/board-apollon.c
@@ -236,7 +236,7 @@ static inline void __init apollon_init_smc91x(void)
 	udelay(100);
 
 	omap_cfg_reg(W4__24XX_GPIO74);
-	if (omap_request_gpio(APOLLON_ETHR_GPIO_IRQ) < 0) {
+	if (gpio_request(APOLLON_ETHR_GPIO_IRQ, "SMC91x irq") < 0) {
 		printk(KERN_ERR "Failed to request GPIO%d for smc91x IRQ\n",
 			APOLLON_ETHR_GPIO_IRQ);
 		gpmc_cs_free(APOLLON_ETH_CS);
@@ -359,7 +359,7 @@ static void __init apollon_usb_init(void)
 	/* USB device */
 	/* DEVICE_SUSPEND */
 	omap_cfg_reg(P21_242X_GPIO12);
-	omap_request_gpio(12);
+	gpio_request(12, "USB suspend");
 	gpio_direction_output(12, 0);
 }
 
diff --git a/arch/arm/mach-omap2/usb-tusb6010.c b/arch/arm/mach-omap2/usb-tusb6010.c
index eb2399d..15e5090 100644
--- a/arch/arm/mach-omap2/usb-tusb6010.c
+++ b/arch/arm/mach-omap2/usb-tusb6010.c
@@ -12,11 +12,11 @@
 #include <linux/errno.h>
 #include <linux/delay.h>
 #include <linux/platform_device.h>
+#include <linux/gpio.h>
 
 #include <linux/usb/musb.h>
 
 #include <mach/gpmc.h>
-#include <mach/gpio.h>
 #include <mach/mux.h>
 
 
@@ -292,7 +292,7 @@ tusb6010_setup_interface(struct musb_hdrc_platform_data *data,
 			);
 
 	/* IRQ */
-	status = omap_request_gpio(irq);
+	status = gpio_request(irq, "TUSB6010 irq");
 	if (status < 0) {
 		printk(error, 3, status);
 		return status;
diff --git a/arch/arm/plat-omap/debug-devices.c b/arch/arm/plat-omap/debug-devices.c
index 7d9c87c..f668483 100644
--- a/arch/arm/plat-omap/debug-devices.c
+++ b/arch/arm/plat-omap/debug-devices.c
@@ -72,7 +72,7 @@ int __init debug_card_init(u32 addr, unsigned gpio)
 	smc91x_resources[1].start = gpio_to_irq(gpio);
 	smc91x_resources[1].end   = gpio_to_irq(gpio);
 
-	status = omap_request_gpio(gpio);
+	status = gpio_request(gpio, "SMC91x irq");
 	if (status < 0) {
 		printk(KERN_ERR "GPIO%d unavailable for smc91x IRQ\n", gpio);
 		return status;


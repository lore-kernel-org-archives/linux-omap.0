From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 07/11] ARM: OMAP: use gpio_to_irq
Date: Fri, 28 Nov 2008 17:10:36 -0800
Message-ID: <20081129011036.12337.42892.stgit@localhost>
References: <20081129010728.12337.8217.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:58201 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753458AbYK2BKf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 28 Nov 2008 20:10:35 -0500
In-Reply-To: <20081129010728.12337.8217.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: David Brownell <dbrownell@users.sourceforge.net>, linux-omap@vger.kernel.org

From: David Brownell <dbrownell@users.sourceforge.net>

Have most uses of OMAP_GPIO_IRQ() use gpio_to_irq() instead.
Calls used for table initialization are left alone, at least
this time around.

(This patch is for code in both the OMAP tree and mainline.)

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap1/board-osk.c       |   11 ++++++-----
 arch/arm/mach-omap1/board-palmz71.c   |    8 ++++----
 arch/arm/mach-omap1/board-voiceblue.c |    8 ++++----
 arch/arm/mach-omap1/fpga.c            |    2 +-
 arch/arm/mach-omap1/serial.c          |    4 ++--
 arch/arm/plat-omap/debug-devices.c    |    4 ++--
 drivers/input/keyboard/omap-keypad.c  |    8 ++++----
 drivers/mtd/onenand/omap2.c           |    6 +++---
 8 files changed, 26 insertions(+), 25 deletions(-)

diff --git a/arch/arm/mach-omap1/board-osk.c b/arch/arm/mach-omap1/board-osk.c
index 3e766e4..2f88095 100644
--- a/arch/arm/mach-omap1/board-osk.c
+++ b/arch/arm/mach-omap1/board-osk.c
@@ -288,7 +288,7 @@ static void __init osk_init_cf(void)
 		return;
 	}
 	/* the CF I/O IRQ is really active-low */
-	set_irq_type(OMAP_GPIO_IRQ(62), IRQ_TYPE_EDGE_FALLING);
+	set_irq_type(gpio_to_irq(62), IRQ_TYPE_EDGE_FALLING);
 }
 
 static void __init osk_init_irq(void)
@@ -483,7 +483,7 @@ static void __init osk_mistral_init(void)
 	omap_cfg_reg(P20_1610_GPIO4);	/* PENIRQ */
 	gpio_request(4, "ts_int");
 	gpio_direction_input(4);
-	set_irq_type(OMAP_GPIO_IRQ(4), IRQ_TYPE_EDGE_FALLING);
+	set_irq_type(gpio_to_irq(4), IRQ_TYPE_EDGE_FALLING);
 
 	spi_register_board_info(mistral_boardinfo,
 			ARRAY_SIZE(mistral_boardinfo));
@@ -492,14 +492,15 @@ static void __init osk_mistral_init(void)
 	omap_cfg_reg(N15_1610_MPUIO2);
 	if (gpio_request(OMAP_MPUIO(2), "wakeup") == 0) {
 		int ret = 0;
+		int irq = gpio_to_irq(OMAP_MPUIO(2));
 
 		gpio_direction_input(OMAP_MPUIO(2));
-		set_irq_type(OMAP_GPIO_IRQ(OMAP_MPUIO(2)), IRQ_TYPE_EDGE_RISING);
+		set_irq_type(irq, IRQ_TYPE_EDGE_RISING);
 #ifdef	CONFIG_PM
 		/* share the IRQ in case someone wants to use the
 		 * button for more than wakeup from system sleep.
 		 */
-		ret = request_irq(OMAP_GPIO_IRQ(OMAP_MPUIO(2)),
+		ret = request_irq(irq,
 				&osk_mistral_wake_interrupt,
 				IRQF_SHARED, "mistral_wakeup",
 				&osk_mistral_wake_interrupt);
@@ -508,7 +509,7 @@ static void __init osk_mistral_init(void)
 			printk(KERN_ERR "OSK+Mistral: no wakeup irq, %d?\n",
 				ret);
 		} else
-			enable_irq_wake(OMAP_GPIO_IRQ(OMAP_MPUIO(2)));
+			enable_irq_wake(irq);
 #endif
 	} else
 		printk(KERN_ERR "OSK+Mistral: wakeup button is awol\n");
diff --git a/arch/arm/mach-omap1/board-palmz71.c b/arch/arm/mach-omap1/board-palmz71.c
index dec2010..1b7d358 100644
--- a/arch/arm/mach-omap1/board-palmz71.c
+++ b/arch/arm/mach-omap1/board-palmz71.c
@@ -297,11 +297,11 @@ palmz71_powercable(int irq, void *dev_id)
 {
 	if (gpio_get_value(PALMZ71_USBDETECT_GPIO)) {
 		printk(KERN_INFO "PM: Power cable connected\n");
-		set_irq_type(OMAP_GPIO_IRQ(PALMZ71_USBDETECT_GPIO),
+		set_irq_type(gpio_to_irq(PALMZ71_USBDETECT_GPIO),
 				IRQ_TYPE_EDGE_FALLING);
 	} else {
 		printk(KERN_INFO "PM: Power cable disconnected\n");
-		set_irq_type(OMAP_GPIO_IRQ(PALMZ71_USBDETECT_GPIO),
+		set_irq_type(gpio_to_irq(PALMZ71_USBDETECT_GPIO),
 				IRQ_TYPE_EDGE_RISING);
 	}
 	return IRQ_HANDLED;
@@ -339,12 +339,12 @@ palmz71_gpio_setup(int early)
 			return;
 		}
 		gpio_direction_input(PALMZ71_USBDETECT_GPIO);
-		if (request_irq(OMAP_GPIO_IRQ(PALMZ71_USBDETECT_GPIO),
+		if (request_irq(gpio_to_irq(PALMZ71_USBDETECT_GPIO),
 				palmz71_powercable, IRQF_SAMPLE_RANDOM,
 				"palmz71-cable", 0))
 			printk(KERN_ERR
 					"IRQ request for power cable failed!\n");
-		palmz71_powercable(OMAP_GPIO_IRQ(PALMZ71_USBDETECT_GPIO), 0);
+		palmz71_powercable(gpio_to_irq(PALMZ71_USBDETECT_GPIO), 0);
 	}
 }
 
diff --git a/arch/arm/mach-omap1/board-voiceblue.c b/arch/arm/mach-omap1/board-voiceblue.c
index 43b008f..bb4f4a8 100644
--- a/arch/arm/mach-omap1/board-voiceblue.c
+++ b/arch/arm/mach-omap1/board-voiceblue.c
@@ -185,10 +185,10 @@ static void __init voiceblue_init(void)
 	omap_request_gpio(13);
 	omap_request_gpio(14);
 	omap_request_gpio(15);
-	set_irq_type(OMAP_GPIO_IRQ(12), IRQ_TYPE_EDGE_RISING);
-	set_irq_type(OMAP_GPIO_IRQ(13), IRQ_TYPE_EDGE_RISING);
-	set_irq_type(OMAP_GPIO_IRQ(14), IRQ_TYPE_EDGE_RISING);
-	set_irq_type(OMAP_GPIO_IRQ(15), IRQ_TYPE_EDGE_RISING);
+	set_irq_type(gpio_to_irq(12), IRQ_TYPE_EDGE_RISING);
+	set_irq_type(gpio_to_irq(13), IRQ_TYPE_EDGE_RISING);
+	set_irq_type(gpio_to_irq(14), IRQ_TYPE_EDGE_RISING);
+	set_irq_type(gpio_to_irq(15), IRQ_TYPE_EDGE_RISING);
 
 	platform_add_devices(voiceblue_devices, ARRAY_SIZE(voiceblue_devices));
 	omap_board_config = voiceblue_config;
diff --git a/arch/arm/mach-omap1/fpga.c b/arch/arm/mach-omap1/fpga.c
index 40cf504..55748ec 100644
--- a/arch/arm/mach-omap1/fpga.c
+++ b/arch/arm/mach-omap1/fpga.c
@@ -179,7 +179,7 @@ void omap1510_fpga_init_irq(void)
 	 */
 	omap_request_gpio(13);
 	gpio_direction_input(13);
-	set_irq_type(OMAP_GPIO_IRQ(13), IRQ_TYPE_EDGE_RISING);
+	set_irq_type(gpio_to_irq(13), IRQ_TYPE_EDGE_RISING);
 	set_irq_chained_handler(OMAP1510_INT_FPGA, innovator_fpga_IRQ_demux);
 }
 
diff --git a/arch/arm/mach-omap1/serial.c b/arch/arm/mach-omap1/serial.c
index 1a0bc47..b63da3f 100644
--- a/arch/arm/mach-omap1/serial.c
+++ b/arch/arm/mach-omap1/serial.c
@@ -251,7 +251,7 @@ static void __init omap_serial_set_port_wakeup(int gpio_nr)
 		return;
 	}
 	gpio_direction_input(gpio_nr);
-	ret = request_irq(OMAP_GPIO_IRQ(gpio_nr), &omap_serial_wake_interrupt,
+	ret = request_irq(gpio_to_irq(gpio_nr), &omap_serial_wake_interrupt,
 			  IRQF_TRIGGER_RISING, "serial wakeup", NULL);
 	if (ret) {
 		omap_free_gpio(gpio_nr);
@@ -259,7 +259,7 @@ static void __init omap_serial_set_port_wakeup(int gpio_nr)
 		       gpio_nr);
 		return;
 	}
-	enable_irq_wake(OMAP_GPIO_IRQ(gpio_nr));
+	enable_irq_wake(gpio_to_irq(gpio_nr));
 }
 
 static int __init omap_serial_wakeup_init(void)
diff --git a/arch/arm/plat-omap/debug-devices.c b/arch/arm/plat-omap/debug-devices.c
index 60076a8..7d9c87c 100644
--- a/arch/arm/plat-omap/debug-devices.c
+++ b/arch/arm/plat-omap/debug-devices.c
@@ -69,8 +69,8 @@ int __init debug_card_init(u32 addr, unsigned gpio)
 	smc91x_resources[0].start = addr + 0x300;
 	smc91x_resources[0].end   = addr + 0x30f;
 
-	smc91x_resources[1].start = OMAP_GPIO_IRQ(gpio);
-	smc91x_resources[1].end   = OMAP_GPIO_IRQ(gpio);
+	smc91x_resources[1].start = gpio_to_irq(gpio);
+	smc91x_resources[1].end   = gpio_to_irq(gpio);
 
 	status = omap_request_gpio(gpio);
 	if (status < 0) {
diff --git a/drivers/input/keyboard/omap-keypad.c b/drivers/input/keyboard/omap-keypad.c
index 69e674e..db22fd9 100644
--- a/drivers/input/keyboard/omap-keypad.c
+++ b/drivers/input/keyboard/omap-keypad.c
@@ -101,7 +101,7 @@ static irqreturn_t omap_kp_interrupt(int irq, void *dev_id)
 	if (cpu_is_omap24xx()) {
 		int i;
 		for (i = 0; i < omap_kp->rows; i++)
-			disable_irq(OMAP_GPIO_IRQ(row_gpios[i]));
+			disable_irq(gpio_to_irq(row_gpios[i]));
 	} else
 		/* disable keyboard interrupt and schedule for handling */
 		omap_writew(1, OMAP_MPUIO_BASE + OMAP_MPUIO_KBD_MASKIT);
@@ -224,7 +224,7 @@ static void omap_kp_tasklet(unsigned long data)
 		if (cpu_is_omap24xx()) {
 			int i;
 			for (i = 0; i < omap_kp_data->rows; i++)
-				enable_irq(OMAP_GPIO_IRQ(row_gpios[i]));
+				enable_irq(gpio_to_irq(row_gpios[i]));
 		} else {
 			omap_writew(0, OMAP_MPUIO_BASE + OMAP_MPUIO_KBD_MASKIT);
 			kp_cur_group = -1;
@@ -397,7 +397,7 @@ static int __init omap_kp_probe(struct platform_device *pdev)
 		omap_writew(0, OMAP_MPUIO_BASE + OMAP_MPUIO_KBD_MASKIT);
 	} else {
 		for (irq_idx = 0; irq_idx < omap_kp->rows; irq_idx++) {
-			if (request_irq(OMAP_GPIO_IRQ(row_gpios[irq_idx]),
+			if (request_irq(gpio_to_irq(row_gpios[irq_idx]),
 					omap_kp_interrupt,
 					IRQF_TRIGGER_FALLING,
 					"omap-keypad", omap_kp) < 0)
@@ -438,7 +438,7 @@ static int omap_kp_remove(struct platform_device *pdev)
 			gpio_free(col_gpios[i]);
 		for (i = 0; i < omap_kp->rows; i++) {
 			gpio_free(row_gpios[i]);
-			free_irq(OMAP_GPIO_IRQ(row_gpios[i]), 0);
+			free_irq(gpio_to_irq(row_gpios[i]), 0);
 		}
 	} else {
 		omap_writew(1, OMAP_MPUIO_BASE + OMAP_MPUIO_KBD_MASKIT);
diff --git a/drivers/mtd/onenand/omap2.c b/drivers/mtd/onenand/omap2.c
index c7145af..97fb5bc 100644
--- a/drivers/mtd/onenand/omap2.c
+++ b/drivers/mtd/onenand/omap2.c
@@ -637,7 +637,7 @@ static int __devinit omap2_onenand_probe(struct platform_device *pdev)
 	}
 	gpio_direction_input(c->gpio_irq);
 
-	if ((r = request_irq(OMAP_GPIO_IRQ(c->gpio_irq),
+	if ((r = request_irq(gpio_to_irq(c->gpio_irq),
 			     omap2_onenand_interrupt, IRQF_TRIGGER_RISING,
 			     pdev->dev.driver->name, c)) < 0)
 		goto err_release_gpio;
@@ -724,7 +724,7 @@ err_release_dma:
 	if (c->dma_channel != -1)
 		omap_free_dma(c->dma_channel);
 	if (c->gpio_irq)
-		free_irq(OMAP_GPIO_IRQ(c->gpio_irq), c);
+		free_irq(gpio_to_irq(c->gpio_irq), c);
 err_release_gpio:
 	if (c->gpio_irq)
 		omap_free_gpio(c->gpio_irq);
@@ -761,7 +761,7 @@ static int __devexit omap2_onenand_remove(struct platform_device *pdev)
 	omap2_onenand_shutdown(pdev);
 	platform_set_drvdata(pdev, NULL);
 	if (c->gpio_irq) {
-		free_irq(OMAP_GPIO_IRQ(c->gpio_irq), c);
+		free_irq(gpio_to_irq(c->gpio_irq), c);
 		omap_free_gpio(c->gpio_irq);
 	}
 	iounmap(c->onenand.base);


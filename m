From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.28-rc2-omap 4/5] use gpio_to_irq (OMAP and mainline)
Date: Thu, 30 Oct 2008 00:36:45 -0700
Message-ID: <200810300036.46218.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp120.sbc.mail.sp1.yahoo.com ([69.147.64.93]:34860 "HELO
	smtp120.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753197AbYJ3Hik (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 30 Oct 2008 03:38:40 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: David Brownell <dbrownell@users.sourceforge.net>

Have most uses of OMAP_GPIO_IRQ() use gpio_to_irq() instead.
Calls used for table initialization are left alone, at least
this time around.

(This patch is for code in both the OMAP tree and mainline.)

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
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

--- a/arch/arm/mach-omap1/board-osk.c
+++ b/arch/arm/mach-omap1/board-osk.c
@@ -290,7 +290,7 @@ static void __init osk_init_cf(void)
 		return;
 	}
 	/* the CF I/O IRQ is really active-low */
-	set_irq_type(OMAP_GPIO_IRQ(62), IRQ_TYPE_EDGE_FALLING);
+	set_irq_type(gpio_to_irq(62), IRQ_TYPE_EDGE_FALLING);
 }
 
 static void __init osk_init_irq(void)
@@ -485,7 +485,7 @@ static void __init osk_mistral_init(void
 	omap_cfg_reg(P20_1610_GPIO4);	/* PENIRQ */
 	gpio_request(4, "ts_int");
 	gpio_direction_input(4);
-	set_irq_type(OMAP_GPIO_IRQ(4), IRQ_TYPE_EDGE_FALLING);
+	set_irq_type(gpio_to_irq(4), IRQ_TYPE_EDGE_FALLING);
 
 	spi_register_board_info(mistral_boardinfo,
 			ARRAY_SIZE(mistral_boardinfo));
@@ -494,14 +494,15 @@ static void __init osk_mistral_init(void
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
@@ -510,7 +511,7 @@ static void __init osk_mistral_init(void
 			printk(KERN_ERR "OSK+Mistral: no wakeup irq, %d?\n",
 				ret);
 		} else
-			enable_irq_wake(OMAP_GPIO_IRQ(OMAP_MPUIO(2)));
+			enable_irq_wake(irq);
 #endif
 	} else
 		printk(KERN_ERR "OSK+Mistral: wakeup button is awol\n");
--- a/arch/arm/mach-omap1/board-palmz71.c
+++ b/arch/arm/mach-omap1/board-palmz71.c
@@ -286,11 +286,11 @@ palmz71_powercable(int irq, void *dev_id
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
@@ -328,12 +328,12 @@ palmz71_gpio_setup(int early)
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
 
--- a/arch/arm/mach-omap1/board-voiceblue.c
+++ b/arch/arm/mach-omap1/board-voiceblue.c
@@ -177,10 +177,10 @@ static void __init voiceblue_init(void)
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
 
--- a/arch/arm/mach-omap1/serial.c
+++ b/arch/arm/mach-omap1/serial.c
@@ -251,7 +251,7 @@ static void __init omap_serial_set_port_
 		return;
 	}
 	gpio_direction_input(gpio_nr);
-	ret = request_irq(OMAP_GPIO_IRQ(gpio_nr), &omap_serial_wake_interrupt,
+	ret = request_irq(gpio_to_irq(gpio_nr), &omap_serial_wake_interrupt,
 			  IRQF_TRIGGER_RISING, "serial wakeup", NULL);
 	if (ret) {
 		omap_free_gpio(gpio_nr);
@@ -259,7 +259,7 @@ static void __init omap_serial_set_port_
 		       gpio_nr);
 		return;
 	}
-	enable_irq_wake(OMAP_GPIO_IRQ(gpio_nr));
+	enable_irq_wake(gpio_to_irq(gpio_nr));
 }
 
 static int __init omap_serial_wakeup_init(void)
--- a/arch/arm/plat-omap/debug-devices.c
+++ b/arch/arm/plat-omap/debug-devices.c
@@ -69,8 +69,8 @@ int __init debug_card_init(u32 addr, uns
 	smc91x_resources[0].start = addr + 0x300;
 	smc91x_resources[0].end   = addr + 0x30f;
 
-	smc91x_resources[1].start = OMAP_GPIO_IRQ(gpio);
-	smc91x_resources[1].end   = OMAP_GPIO_IRQ(gpio);
+	smc91x_resources[1].start = gpio_to_irq(gpio);
+	smc91x_resources[1].end   = gpio_to_irq(gpio);
 
 	status = omap_request_gpio(gpio);
 	if (status < 0) {
--- a/drivers/input/keyboard/omap-keypad.c
+++ b/drivers/input/keyboard/omap-keypad.c
@@ -113,7 +113,7 @@ static irqreturn_t omap_kp_interrupt(int
 	if (cpu_is_omap24xx()) {
 		int i;
 		for (i = 0; i < omap_kp->rows; i++)
-			disable_irq(OMAP_GPIO_IRQ(row_gpios[i]));
+			disable_irq(gpio_to_irq(row_gpios[i]));
 	} else
 		/* disable keyboard interrupt and schedule for handling */
 		omap_writew(1, OMAP_MPUIO_BASE + OMAP_MPUIO_KBD_MASKIT);
@@ -232,7 +232,7 @@ static void omap_kp_tasklet(unsigned lon
 		if (cpu_is_omap24xx()) {
 			int i;
 			for (i = 0; i < omap_kp_data->rows; i++)
-				enable_irq(OMAP_GPIO_IRQ(row_gpios[i]));
+				enable_irq(gpio_to_irq(row_gpios[i]));
 		} else {
 			omap_writew(0, OMAP_MPUIO_BASE + OMAP_MPUIO_KBD_MASKIT);
 			kp_cur_group = -1;
@@ -421,7 +421,7 @@ static int __init omap_kp_probe(struct p
 		omap_writew(0, OMAP_MPUIO_BASE + OMAP_MPUIO_KBD_MASKIT);
 	} else {
 		for (irq_idx = 0; irq_idx < omap_kp->rows; irq_idx++) {
-			if (request_irq(OMAP_GPIO_IRQ(row_gpios[irq_idx]),
+			if (request_irq(gpio_to_irq(row_gpios[irq_idx]),
 					omap_kp_interrupt,
 					IRQF_TRIGGER_FALLING,
 					"omap-keypad", omap_kp) < 0)
@@ -462,7 +462,7 @@ static int omap_kp_remove(struct platfor
 			gpio_free(col_gpios[i]);
 		for (i = 0; i < omap_kp->rows; i++) {
 			gpio_free(row_gpios[i]);
-			free_irq(OMAP_GPIO_IRQ(row_gpios[i]), 0);
+			free_irq(gpio_to_irq(row_gpios[i]), 0);
 		}
 	} else {
 		omap_writew(1, OMAP_MPUIO_BASE + OMAP_MPUIO_KBD_MASKIT);
--- a/drivers/mtd/onenand/omap2.c
+++ b/drivers/mtd/onenand/omap2.c
@@ -637,7 +637,7 @@ static int __devinit omap2_onenand_probe
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
@@ -761,7 +761,7 @@ static int __devexit omap2_onenand_remov
 	omap2_onenand_shutdown(pdev);
 	platform_set_drvdata(pdev, NULL);
 	if (c->gpio_irq) {
-		free_irq(OMAP_GPIO_IRQ(c->gpio_irq), c);
+		free_irq(gpio_to_irq(c->gpio_irq), c);
 		omap_free_gpio(c->gpio_irq);
 	}
 	iounmap(c->onenand.base);

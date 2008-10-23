From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.27-omap-git 4/4] use gpio_to_irq()
Date: Wed, 22 Oct 2008 23:57:37 -0700
Message-ID: <200810222357.37405.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp125.sbc.mail.sp1.yahoo.com ([69.147.65.184]:27104 "HELO
	smtp125.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752047AbYJWHCR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 23 Oct 2008 03:02:17 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: David Brownell <dbrownell@users.sourceforge.net>

Have most uses of OMAP_GPIO_IRQ() use gpio_to_irq() instead.
Calls used for static initialization are left alone, at least
this time around.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
---
 arch/arm/mach-omap1/board-osk.c        |   11 ++++++-----
 arch/arm/mach-omap1/board-palmz71.c    |    8 ++++----
 arch/arm/mach-omap1/board-voiceblue.c  |    8 ++++----
 arch/arm/mach-omap1/fpga.c             |    2 +-
 arch/arm/mach-omap1/serial.c           |    4 ++--
 arch/arm/mach-omap2/board-3430sdp.c    |    4 ++--
 arch/arm/mach-omap2/board-ldp.c        |    2 +-
 arch/arm/mach-omap2/board-n800.c       |    4 ++--
 arch/arm/plat-omap/debug-devices.c     |    4 ++--
 arch/arm/plat-omap/gpio-switch.c       |    8 ++++----
 drivers/bluetooth/brf6150.c            |   16 ++++++++--------
 drivers/bluetooth/hci_h4p/core.c       |    8 ++++----
 drivers/cbus/retu.c                    |   10 +++++-----
 drivers/cbus/tahvo.c                   |    8 ++++----
 drivers/input/keyboard/omap-keypad.c   |    8 ++++----
 drivers/input/touchscreen/omap/ts_hx.c |    2 +-
 drivers/input/touchscreen/tsc2005.c    |    2 +-
 drivers/mtd/onenand/omap2.c            |    6 +++---
 18 files changed, 58 insertions(+), 57 deletions(-)

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
@@ -483,7 +483,7 @@ static void __init osk_mistral_init(void
 	omap_cfg_reg(P20_1610_GPIO4);	/* PENIRQ */
 	gpio_request(4, "ts_int");
 	gpio_direction_input(4);
-	set_irq_type(OMAP_GPIO_IRQ(4), IRQ_TYPE_EDGE_FALLING);
+	set_irq_type(gpio_to_irq(4), IRQ_TYPE_EDGE_FALLING);
 
 	spi_register_board_info(mistral_boardinfo,
 			ARRAY_SIZE(mistral_boardinfo));
@@ -492,14 +492,15 @@ static void __init osk_mistral_init(void
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
@@ -508,7 +509,7 @@ static void __init osk_mistral_init(void
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
@@ -176,10 +176,10 @@ static void __init voiceblue_init(void)
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
@@ -181,7 +181,7 @@ void omap1510_fpga_init_irq(void)
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
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -269,7 +269,7 @@ static inline void __init sdp3430_init_s
 	else
 		eth_gpio = OMAP34XX_ETHR_GPIO_IRQ_SDPV1;
 
-	sdp3430_smc91x_resources[1].start = OMAP_GPIO_IRQ(eth_gpio);
+	sdp3430_smc91x_resources[1].start = gpio_to_irq(eth_gpio);
 
 	if (omap_request_gpio(eth_gpio) < 0) {
 		printk(KERN_ERR "Failed to request GPIO%d for smc91x IRQ\n",
@@ -372,7 +372,7 @@ static void __init omap_3430sdp_init(voi
 		ts_gpio = OMAP34XX_TS_GPIO_IRQ_SDPV2;
 	else
 		ts_gpio = OMAP34XX_TS_GPIO_IRQ_SDPV1;
-	sdp3430_spi_board_info[0].irq = OMAP_GPIO_IRQ(ts_gpio);
+	sdp3430_spi_board_info[0].irq = gpio_to_irq(ts_gpio);
 	spi_register_board_info(sdp3430_spi_board_info,
 				ARRAY_SIZE(sdp3430_spi_board_info));
 	ads7846_dev_init();
--- a/arch/arm/mach-omap2/board-ldp.c
+++ b/arch/arm/mach-omap2/board-ldp.c
@@ -250,7 +250,7 @@ static void __init omap_ldp_init(void)
 	omap_board_config = ldp_config;
 	omap_board_config_size = ARRAY_SIZE(ldp_config);
 	ts_gpio = 54;
-	ldp_spi_board_info[0].irq = OMAP_GPIO_IRQ(ts_gpio);
+	ldp_spi_board_info[0].irq = gpio_to_irq(ts_gpio);
 	spi_register_board_info(ldp_spi_board_info,
 				ARRAY_SIZE(ldp_spi_board_info));
 	msecure_init();
--- a/arch/arm/mach-omap2/board-n800.c
+++ b/arch/arm/mach-omap2/board-n800.c
@@ -303,7 +303,7 @@ static void tsc2301_dev_init(void)
 	r = gpio_request(gpio, "tsc2301 KBD IRQ");
 	if (r >= 0) {
 		gpio_direction_input(gpio);
-		tsc2301_config.keyb_int = OMAP_GPIO_IRQ(gpio);
+		tsc2301_config.keyb_int = gpio_to_irq(gpio);
 	} else {
 		printk(KERN_ERR "unable to get KBD GPIO");
 	}
@@ -312,7 +312,7 @@ static void tsc2301_dev_init(void)
 	r = gpio_request(gpio, "tsc2301 DAV IRQ");
 	if (r >= 0) {
 		gpio_direction_input(gpio);
-		tsc2301_config.dav_int = OMAP_GPIO_IRQ(gpio);
+		tsc2301_config.dav_int = gpio_to_irq(gpio);
 	} else {
 		printk(KERN_ERR "unable to get DAV GPIO");
 	}
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
--- a/arch/arm/plat-omap/gpio-switch.c
+++ b/arch/arm/plat-omap/gpio-switch.c
@@ -191,9 +191,9 @@ static irqreturn_t gpio_sw_irq_handler(i
 
 	if (!sw->both_edges) {
 		if (gpio_get_value(sw->gpio))
-			set_irq_type(OMAP_GPIO_IRQ(sw->gpio), IRQ_TYPE_EDGE_FALLING);
+			set_irq_type(gpio_to_irq(sw->gpio), IRQ_TYPE_EDGE_FALLING);
 		else
-			set_irq_type(OMAP_GPIO_IRQ(sw->gpio), IRQ_TYPE_EDGE_RISING);
+			set_irq_type(gpio_to_irq(sw->gpio), IRQ_TYPE_EDGE_RISING);
 	}
 
 	state = gpio_sw_get_state(sw);
@@ -313,7 +313,7 @@ static int __init new_switch(struct gpio
 		else
 			trigger = IRQF_TRIGGER_RISING;
 	}
-	r = request_irq(OMAP_GPIO_IRQ(sw->gpio), gpio_sw_irq_handler,
+	r = request_irq(gpio_to_irq(sw->gpio), gpio_sw_irq_handler,
 			IRQF_SHARED | trigger, sw->name, sw);
 	if (r < 0) {
 		printk(KERN_ERR "gpio-switch: request_irq() failed "
@@ -448,7 +448,7 @@ static void gpio_sw_cleanup(void)
 		flush_scheduled_work();
 		del_timer_sync(&sw->timer);
 
-		free_irq(OMAP_GPIO_IRQ(sw->gpio), sw);
+		free_irq(gpio_to_irq(sw->gpio), sw);
 
 		device_remove_file(&sw->pdev.dev, &dev_attr_state);
 		device_remove_file(&sw->pdev.dev, &dev_attr_type);
--- a/drivers/bluetooth/brf6150.c
+++ b/drivers/bluetooth/brf6150.c
@@ -742,7 +742,7 @@ static int brf6150_hci_open(struct hci_d
 	info->garbage_bytes = 0;
 	info->rx_skb = NULL;
 	info->pm_enabled = 0;
-	set_irq_type(OMAP_GPIO_IRQ(info->btinfo->host_wakeup_gpio), IRQ_TYPE_NONE);
+	set_irq_type(gpio_to_irq(info->btinfo->host_wakeup_gpio), IRQ_TYPE_NONE);
 	init_completion(&info->fw_completion);
 
 	clk_enable(info->uart_ck);
@@ -771,7 +771,7 @@ static int brf6150_hci_open(struct hci_d
 	if (err < 0)
 		printk(KERN_ERR "brf6150: Sending firmware failed. Bluetooth won't work properly\n");
 
-	set_irq_type(OMAP_GPIO_IRQ(info->btinfo->host_wakeup_gpio), IRQ_TYPE_EDGE_BOTH);
+	set_irq_type(gpio_to_irq(info->btinfo->host_wakeup_gpio), IRQ_TYPE_EDGE_BOTH);
 	info->pm_enabled = 1;
 	set_bit(HCI_RUNNING, &hdev->flags);
 	return 0;
@@ -787,7 +787,7 @@ static int brf6150_hci_close(struct hci_
 	clk_disable(info->uart_ck);
 	del_timer_sync(&info->pm_timer);
 	gpio_set_value(info->btinfo->bt_wakeup_gpio, 0);
-	set_irq_type(OMAP_GPIO_IRQ(info->btinfo->host_wakeup_gpio), IRQ_TYPE_NONE);
+	set_irq_type(gpio_to_irq(info->btinfo->host_wakeup_gpio), IRQ_TYPE_NONE);
 
 	return 0;
 }
@@ -946,7 +946,7 @@ static int __init brf6150_init(void)
 	gpio_direction_output(info->btinfo->reset_gpio, 0);
 	gpio_direction_output(info->btinfo->bt_wakeup_gpio, 0);
 	gpio_direction_input(info->btinfo->host_wakeup_gpio);
-	set_irq_type(OMAP_GPIO_IRQ(info->btinfo->host_wakeup_gpio), IRQ_TYPE_NONE);
+	set_irq_type(gpio_to_irq(info->btinfo->host_wakeup_gpio), IRQ_TYPE_NONE);
 
 	switch (info->btinfo->bt_uart) {
 	case 1:
@@ -985,11 +985,11 @@ static int __init brf6150_init(void)
 		goto cleanup;
 	}
 
-	err = request_irq(OMAP_GPIO_IRQ(info->btinfo->host_wakeup_gpio),
+	err = request_irq(gpio_to_irq(info->btinfo->host_wakeup_gpio),
 			brf6150_wakeup_interrupt, 0, "brf6150_wkup", (void *)info);
 	if (err < 0) {
 		printk(KERN_ERR "brf6150: unable to get wakeup IRQ %d\n",
-				OMAP_GPIO_IRQ(info->btinfo->host_wakeup_gpio));
+				gpio_to_irq(info->btinfo->host_wakeup_gpio));
 		free_irq(irq, (void *)info);
 		goto cleanup;
 	}
@@ -1020,7 +1020,7 @@ static int __init brf6150_init(void)
 
 cleanup_irq:
 	free_irq(irq, (void *)info);
-	free_irq(OMAP_GPIO_IRQ(info->btinfo->host_wakeup_gpio), (void *)info);
+	free_irq(gpio_to_irq(info->btinfo->host_wakeup_gpio), (void *)info);
 cleanup:
 	omap_free_gpio(info->btinfo->reset_gpio);
 	omap_free_gpio(info->btinfo->bt_wakeup_gpio);
@@ -1038,7 +1038,7 @@ static void __exit brf6150_exit(void)
 	omap_free_gpio(exit_info->btinfo->bt_wakeup_gpio);
 	omap_free_gpio(exit_info->btinfo->host_wakeup_gpio);
 	free_irq(exit_info->irq, (void *)exit_info);
-	free_irq(OMAP_GPIO_IRQ(exit_info->btinfo->host_wakeup_gpio), (void *)exit_info);
+	free_irq(gpio_to_irq(exit_info->btinfo->host_wakeup_gpio), (void *)exit_info);
 	kfree(exit_info);
 }
 
--- a/drivers/bluetooth/hci_h4p/core.c
+++ b/drivers/bluetooth/hci_h4p/core.c
@@ -911,13 +911,13 @@ static int hci_h4p_probe(struct platform
 		goto cleanup;
 	}
 
-	err = request_irq(OMAP_GPIO_IRQ(info->host_wakeup_gpio),
+	err = request_irq(gpio_to_irq(info->host_wakeup_gpio),
 			  hci_h4p_wakeup_interrupt,
 				IRQF_TRIGGER_FALLING | IRQF_TRIGGER_RISING,
 			  "hci_h4p_wkup", (void *)info);
 	if (err < 0) {
 		dev_err(info->dev, "hci_h4p: unable to get wakeup IRQ %d\n",
-			  OMAP_GPIO_IRQ(info->host_wakeup_gpio));
+			  gpio_to_irq(info->host_wakeup_gpio));
 		free_irq(irq, (void *)info);
 		goto cleanup;
 	}
@@ -950,7 +950,7 @@ static int hci_h4p_probe(struct platform
 
 cleanup_irq:
 	free_irq(irq, (void *)info);
-	free_irq(OMAP_GPIO_IRQ(info->host_wakeup_gpio), (void *)info);
+	free_irq(gpio_to_irq(info->host_wakeup_gpio), (void *)info);
 cleanup:
 	gpio_set_value(info->reset_gpio, 0);
 	omap_free_gpio(info->reset_gpio);
@@ -969,7 +969,7 @@ static int hci_h4p_remove(struct platfor
 	info = platform_get_drvdata(dev);
 
 	hci_h4p_hci_close(info->hdev);
-	free_irq(OMAP_GPIO_IRQ(info->host_wakeup_gpio), (void *) info);
+	free_irq(gpio_to_irq(info->host_wakeup_gpio), (void *) info);
 	hci_free_dev(info->hdev);
 	omap_free_gpio(info->reset_gpio);
 	omap_free_gpio(info->bt_wakeup_gpio);
--- a/drivers/cbus/retu.c
+++ b/drivers/cbus/retu.c
@@ -344,7 +344,7 @@ static int __devinit retu_probe(struct d
 	gpio_direction_input(retu_irq_pin);
 
 	/* Rising edge triggers the IRQ */
-	set_irq_type(OMAP_GPIO_IRQ(retu_irq_pin), IRQ_TYPE_EDGE_RISING);
+	set_irq_type(gpio_to_irq(retu_irq_pin), IRQ_TYPE_EDGE_RISING);
 
 	retu_initialized = 1;
 
@@ -358,14 +358,14 @@ static int __devinit retu_probe(struct d
 	/* Mask all RETU interrupts */
 	retu_write_reg(RETU_REG_IMR, 0xffff);
 
-	ret = request_irq(OMAP_GPIO_IRQ(retu_irq_pin), retu_irq_handler, 0,
+	ret = request_irq(gpio_to_irq(retu_irq_pin), retu_irq_handler, 0,
 			  "retu", 0);
 	if (ret < 0) {
 		printk(KERN_ERR PFX "Unable to register IRQ handler\n");
 		omap_free_gpio(retu_irq_pin);
 		return ret;
 	}
-	set_irq_wake(OMAP_GPIO_IRQ(retu_irq_pin), 1);
+	set_irq_wake(gpio_to_irq(retu_irq_pin), 1);
 
 	/* Register power off function */
 	pm_power_off = retu_power_off;
@@ -374,7 +374,7 @@ static int __devinit retu_probe(struct d
 	/* Initialize user-space interface */
 	if (retu_user_init() < 0) {
 		printk(KERN_ERR "Unable to initialize driver\n");
-		free_irq(OMAP_GPIO_IRQ(retu_irq_pin), 0);
+		free_irq(gpio_to_irq(retu_irq_pin), 0);
 		omap_free_gpio(retu_irq_pin);
 		return ret;
 	}
@@ -390,7 +390,7 @@ static int retu_remove(struct device *de
 #endif
 	/* Mask all RETU interrupts */
 	retu_write_reg(RETU_REG_IMR, 0xffff);
-	free_irq(OMAP_GPIO_IRQ(retu_irq_pin), 0);
+	free_irq(gpio_to_irq(retu_irq_pin), 0);
 	omap_free_gpio(retu_irq_pin);
 	tasklet_kill(&retu_tasklet);
 
--- a/drivers/cbus/tahvo.c
+++ b/drivers/cbus/tahvo.c
@@ -331,12 +331,12 @@ static int __devinit tahvo_probe(struct 
 	gpio_direction_input(tahvo_irq_pin);
 
 	/* Rising edge triggers the IRQ */
-	set_irq_type(OMAP_GPIO_IRQ(tahvo_irq_pin), IRQ_TYPE_EDGE_RISING);
+	set_irq_type(gpio_to_irq(tahvo_irq_pin), IRQ_TYPE_EDGE_RISING);
 
 	/* Mask all TAHVO interrupts */
 	tahvo_write_reg(TAHVO_REG_IMR, 0xffff);
 
-	ret = request_irq(OMAP_GPIO_IRQ(tahvo_irq_pin), tahvo_irq_handler, 0,
+	ret = request_irq(gpio_to_irq(tahvo_irq_pin), tahvo_irq_handler, 0,
 			  "tahvo", 0);
 	if (ret < 0) {
 		printk(KERN_ERR PFX "Unable to register IRQ handler\n");
@@ -347,7 +347,7 @@ static int __devinit tahvo_probe(struct 
 	/* Initialize user-space interface */
 	if (tahvo_user_init() < 0) {
 		printk(KERN_ERR "Unable to initialize driver\n");
-		free_irq(OMAP_GPIO_IRQ(tahvo_irq_pin), 0);
+		free_irq(gpio_to_irq(tahvo_irq_pin), 0);
 		omap_free_gpio(tahvo_irq_pin);
 		return ret;
 	}
@@ -362,7 +362,7 @@ static int tahvo_remove(struct device *d
 #endif
 	/* Mask all TAHVO interrupts */
 	tahvo_write_reg(TAHVO_REG_IMR, 0xffff);
-	free_irq(OMAP_GPIO_IRQ(tahvo_irq_pin), 0);
+	free_irq(gpio_to_irq(tahvo_irq_pin), 0);
 	omap_free_gpio(tahvo_irq_pin);
 	tasklet_kill(&tahvo_tasklet);
 
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
--- a/drivers/input/touchscreen/omap/ts_hx.c
+++ b/drivers/input/touchscreen/omap/ts_hx.c
@@ -91,7 +91,7 @@ static int __init hx_ts_probe(struct oma
 	} else
 		return -ENODEV;
 
-	ts->irq = OMAP_GPIO_IRQ(gpio);
+	ts->irq = gpio_to_irq(gpio);
 	if (omap_request_gpio(gpio) != 0) {
 		printk(KERN_ERR "hX_ts_init.c: Could not reserve GPIO!\n");
 		return -EINVAL;
--- a/drivers/input/touchscreen/tsc2005.c
+++ b/drivers/input/touchscreen/tsc2005.c
@@ -541,7 +541,7 @@ static int __devinit tsc2005_ts_init(str
 		goto err1;
 	}
 	gpio_direction_input(dav_gpio);
-	ts->irq = OMAP_GPIO_IRQ(dav_gpio);
+	ts->irq = gpio_to_irq(dav_gpio);
 	dev_dbg(&ts->spi->dev, "TSC2005: DAV IRQ = %d\n", ts->irq);
 #endif
 	init_timer(&ts->penup_timer);
--- a/drivers/mtd/onenand/omap2.c
+++ b/drivers/mtd/onenand/omap2.c
@@ -617,7 +617,7 @@ static int __devinit omap2_onenand_probe
 	}
 	gpio_direction_input(c->gpio_irq);
 
-	if ((r = request_irq(OMAP_GPIO_IRQ(c->gpio_irq),
+	if ((r = request_irq(gpio_to_irq(c->gpio_irq),
 			     omap2_onenand_interrupt, IRQF_TRIGGER_RISING,
 			     pdev->dev.driver->name, c)) < 0)
 		goto err_release_gpio;
@@ -704,7 +704,7 @@ err_release_dma:
 	if (c->dma_channel != -1)
 		omap_free_dma(c->dma_channel);
 	if (c->gpio_irq)
-		free_irq(OMAP_GPIO_IRQ(c->gpio_irq), c);
+		free_irq(gpio_to_irq(c->gpio_irq), c);
 err_release_gpio:
 	if (c->gpio_irq)
 		omap_free_gpio(c->gpio_irq);
@@ -741,7 +741,7 @@ static int __devexit omap2_onenand_remov
 	omap2_onenand_shutdown(pdev);
 	platform_set_drvdata(pdev, NULL);
 	if (c->gpio_irq) {
-		free_irq(OMAP_GPIO_IRQ(c->gpio_irq), c);
+		free_irq(gpio_to_irq(c->gpio_irq), c);
 		omap_free_gpio(c->gpio_irq);
 	}
 	iounmap(c->onenand.base);

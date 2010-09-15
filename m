From: Anti Sullin <anti.sullin@artecdesign.ee>
Subject: [PATCH] overo twl4030: fix twl4030 IRQ (used for usb otg detection)
Date: Wed, 15 Sep 2010 19:29:33 +0300
Message-ID: <4C90F46D.2020902@artecdesign.ee>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.artecdesign.ee ([195.50.213.123]:59788 "EHLO
	postikukk.artecdesign.ee" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754753Ab0IORAu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Sep 2010 13:00:50 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Felipe Balbi <felipe.balbi@nokia.com>, David Brownell <dbrownell@users.sourceforge.net>

I was not getting OTG USB vbus/id pin change interrupts on Gumstix Overo
and the reason was a mis-configured irq. I added some more checks to avoid
having a non-bootable kernel on boards with bootloaders that have wrong pinmux.
The changes of twl4030 should be tested on other boards too.

---
Gumstix Overo has TPS65950 (TWL4030) IRQ1 connected to GPIO112.

This patch fixes the TWL4030 IRQ mapping. The TWL4030 IRQ is used to signal USB OTG
connection events. If this does not work, the USB OTG and peripheral modes
do not work.

GPIO112 mux is wrong in bootloader, too. In case the board uses an older
bootloader, we'll try to re-mux it in kernel (requires CONFIG_OMAP_MUX).

TWL4030 IRQ1 requires pull-up to be activated on GPIO112. If it is not
(bootloader did not do it and kernel has CONFIG_OMAP_MUX disabled)
the kernel would have a stuck interrupt. To avoid freeze, spurious interrupt
detection is added to TWL4030.

Signed-off-by: Anti Sullin <anti.sullin@artecdesign.ee>
---
diff -pur linux-2.6.34/arch/arm/mach-omap2/board-overo.c linux-2.6.34-ok/arch/arm/mach-omap2/board-overo.c
--- linux-2.6.34/arch/arm/mach-omap2/board-overo.c	2010-05-17 00:17:36.000000000 +0300
+++ linux-2.6.34-ok/arch/arm/mach-omap2/board-overo.c	2010-09-14 19:49:00.000000000 +0300
@@ -52,6 +52,7 @@
 
 #define OVERO_GPIO_BT_XGATE	15
 #define OVERO_GPIO_W2W_NRESET	16
+#define OVERO_GPIO_TPS65950_IRQ	112
 #define OVERO_GPIO_PENDOWN	114
 #define OVERO_GPIO_BT_NRESET	164
 #define OVERO_GPIO_USBH_CPEN	168
@@ -353,7 +354,7 @@ static struct i2c_board_info __initdata 
 	{
 		I2C_BOARD_INFO("tps65950", 0x48),
 		.flags = I2C_CLIENT_WAKE,
-		.irq = INT_34XX_SYS_NIRQ,
+		.irq = OMAP_GPIO_IRQ(OVERO_GPIO_TPS65950_IRQ),
 		.platform_data = &overo_twldata,
 	},
 };
@@ -422,6 +423,21 @@ static struct omap_musb_board_data musb_
 static void __init overo_init(void)
 {
 	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
+
+	/* Mux GPIO112 to pull-up input. In case bad bootloader is used,
+	 * override mux settings manually here.
+	 * Requires CONFIG_OMAP_MUX! */
+	omap_mux_set_gpio(OMAP_MUX_MODE4 | OMAP_PIN_INPUT_PULLUP,
+			OVERO_GPIO_TPS65950_IRQ);
+
+	if ((gpio_request(OVERO_GPIO_TPS65950_IRQ, "TPS65950_IRQ") == 0) &&
+	    (gpio_direction_input(OVERO_GPIO_TPS65950_IRQ) == 0)) {
+		gpio_export(OVERO_GPIO_TPS65950_IRQ, 0);
+	} else {
+		printk(KERN_ERR "could not obtain gpio for TPS65950 IRQ\n");
+		return;
+	}
+
 	overo_i2c_init();
 	platform_add_devices(overo_devices, ARRAY_SIZE(overo_devices));
 	omap_serial_init();
diff -pur linux-2.6.34/drivers/mfd/twl4030-irq.c linux-2.6.34-ok/drivers/mfd/twl4030-irq.c
--- linux-2.6.34/drivers/mfd/twl4030-irq.c	2010-05-17 00:17:36.000000000 +0300
+++ linux-2.6.34-ok/drivers/mfd/twl4030-irq.c	2010-09-14 19:50:25.000000000 +0300
@@ -312,6 +312,14 @@ static int twl4030_irq_thread(void *data
 			continue;
 		}
 
+		/* Check for spurious interrupts */
+		if (!pih_isr) {
+			printk(KERN_ERR "Spurious TWL4030 interrupt"
+					" detected.  Terminating %s.\n",
+					__func__);
+			break;
+		}
+
 		/* these handlers deal with the relevant SIH irq status */
 		local_irq_disable();
 		for (module_irq = twl4030_irq_base;
@@ -832,7 +840,7 @@ int twl4030_init_irq(int irq_num, unsign
 
 	init_completion(&irq_event);
 
-	status = request_irq(irq_num, handle_twl4030_pih, IRQF_DISABLED,
+	status = request_irq(irq_num, handle_twl4030_pih, IRQF_TRIGGER_LOW | IRQF_DISABLED,
 				"TWL4030-PIH", &irq_event);
 	if (status < 0) {
 		pr_err("twl4030: could not claim irq%d: %d\n", irq_num, status);



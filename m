From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 2/14] ARM: OMAP: 5912 OSK GPIO updates
Date: Mon, 17 Mar 2008 11:42:26 +0200
Message-ID: <1205746958-11242-3-git-send-email-tony@atomide.com>
References: omap-upstream-2008-03-17-114234
 <1205746958-11242-1-git-send-email-tony@atomide.com>
 <1205746958-11242-2-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-bos.mailhop.org ([63.208.196.179]:64205 "EHLO
	mho-02-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752819AbYCQJnV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Mar 2008 05:43:21 -0400
In-Reply-To: <1205746958-11242-2-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, David Brownell <david-b@pacbell.net>, David Brownell <dbrownell@users.sourceforge.net>, Tony Lindgren <tony@atomide.com>

From: David Brownell <david-b@pacbell.net>

Start cleaning up GPIO handling for OMAP5912 OSK board:

 - Initialize GPIOs using the cross-platform calls, not the old
   OMAP-private ones.

 - Move touchscreen setup out of ads7846 code into board-specfic
   setup code, where it belongs.

This doesn't depend on the patches to update OMAP to use the
gpiolib implementation framework.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap1/board-osk.c     |   30 ++++++++++++++-----------
 drivers/input/touchscreen/ads7846.c |   40 -----------------------------------
 2 files changed, 17 insertions(+), 53 deletions(-)

diff --git a/arch/arm/mach-omap1/board-osk.c b/arch/arm/mach-omap1/board-osk.c
index 5279e35..dd9ece8 100644
--- a/arch/arm/mach-omap1/board-osk.c
+++ b/arch/arm/mach-omap1/board-osk.c
@@ -198,7 +198,7 @@ static struct i2c_board_info __initdata osk_i2c_board_info[] = {
 
 static void __init osk_init_smc91x(void)
 {
-	if ((omap_request_gpio(0)) < 0) {
+	if ((gpio_request(0, "smc_irq")) < 0) {
 		printk("Error requesting gpio 0 for smc91x irq\n");
 		return;
 	}
@@ -210,7 +210,7 @@ static void __init osk_init_smc91x(void)
 static void __init osk_init_cf(void)
 {
 	omap_cfg_reg(M7_1610_GPIO62);
-	if ((omap_request_gpio(62)) < 0) {
+	if ((gpio_request(62, "cf_irq")) < 0) {
 		printk("Error requesting gpio 62 for CF irq\n");
 		return;
 	}
@@ -334,7 +334,7 @@ static struct platform_device *mistral_devices[] __initdata = {
 
 static int mistral_get_pendown_state(void)
 {
-	return !omap_get_gpio_datain(4);
+	return !gpio_get_value(4);
 }
 
 static const struct ads7846_platform_data mistral_ts_info = {
@@ -396,25 +396,31 @@ static void __init osk_mistral_init(void)
 	omap_cfg_reg(W14_1610_CCP_DATAP);
 
 	/* CAM_PWDN */
-	if (omap_request_gpio(11) == 0) {
+	if (gpio_request(11, "cam_pwdn") == 0) {
 		omap_cfg_reg(N20_1610_GPIO11);
-		omap_set_gpio_direction(11, 0 /* out */);
-		omap_set_gpio_dataout(11, 0 /* off */);
+		gpio_direction_output(11, 0);
 	} else
 		pr_debug("OSK+Mistral: CAM_PWDN is awol\n");
 
 
 	/* omap_cfg_reg(P19_1610_GPIO6); */	/* BUSY */
+	gpio_request(6, "ts_busy");
+	gpio_direction_input(6);
+
 	omap_cfg_reg(P20_1610_GPIO4);	/* PENIRQ */
+	gpio_request(4, "ts_int");
+	gpio_direction_input(4);
 	set_irq_type(OMAP_GPIO_IRQ(4), IRQT_FALLING);
+
 	spi_register_board_info(mistral_boardinfo,
 			ARRAY_SIZE(mistral_boardinfo));
 
 	/* the sideways button (SW1) is for use as a "wakeup" button */
 	omap_cfg_reg(N15_1610_MPUIO2);
-	if (omap_request_gpio(OMAP_MPUIO(2)) == 0) {
+	if (gpio_request(OMAP_MPUIO(2), "wakeup") == 0) {
 		int ret = 0;
-		omap_set_gpio_direction(OMAP_MPUIO(2), 1);
+
+		gpio_direction_input(OMAP_MPUIO(2));
 		set_irq_type(OMAP_GPIO_IRQ(OMAP_MPUIO(2)), IRQT_RISING);
 #ifdef	CONFIG_PM
 		/* share the IRQ in case someone wants to use the
@@ -425,7 +431,7 @@ static void __init osk_mistral_init(void)
 				IRQF_SHARED, "mistral_wakeup",
 				&osk_mistral_wake_interrupt);
 		if (ret != 0) {
-			omap_free_gpio(OMAP_MPUIO(2));
+			gpio_free(OMAP_MPUIO(2));
 			printk(KERN_ERR "OSK+Mistral: no wakeup irq, %d?\n",
 				ret);
 		} else
@@ -438,10 +444,8 @@ static void __init osk_mistral_init(void)
 	 * board, like the touchscreen, EEPROM, and wakeup (!) switch.
 	 */
 	omap_cfg_reg(PWL);
-	if (omap_request_gpio(2) == 0) {
-		omap_set_gpio_direction(2, 0 /* out */);
-		omap_set_gpio_dataout(2, 1 /* on */);
-	}
+	if (gpio_request(2, "lcd_pwr") == 0)
+		gpio_direction_output(2, 1);
 
 	platform_add_devices(mistral_devices, ARRAY_SIZE(mistral_devices));
 }
diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
index 58934a4..7077090 100644
--- a/drivers/input/touchscreen/ads7846.c
+++ b/drivers/input/touchscreen/ads7846.c
@@ -28,13 +28,6 @@
 #include <linux/spi/ads7846.h>
 #include <asm/irq.h>
 
-#ifdef	CONFIG_ARM
-#include <asm/mach-types.h>
-#ifdef	CONFIG_ARCH_OMAP
-#include <asm/arch/gpio.h>
-#endif
-#endif
-
 
 /*
  * This code has been heavily tested on a Nokia 770, and lightly
@@ -1174,31 +1167,6 @@ static struct spi_driver ads7846_driver = {
 
 static int __init ads7846_init(void)
 {
-	/* grr, board-specific init should stay out of drivers!! */
-
-#ifdef	CONFIG_ARCH_OMAP
-	if (machine_is_omap_osk()) {
-		/* GPIO4 = PENIRQ; GPIO6 = BUSY */
-		omap_request_gpio(4);
-		omap_set_gpio_direction(4, 1);
-		omap_request_gpio(6);
-		omap_set_gpio_direction(6, 1);
-	}
-	// also TI 1510 Innovator, bitbanging through FPGA
-	// also Nokia 770
-	// also Palm Tungsten T2
-#endif
-
-	// PXA:
-	// also Dell Axim X50
-	// also HP iPaq H191x/H192x/H415x/H435x
-	// also Intel Lubbock (additional to UCB1400; as temperature sensor)
-	// also Sharp Zaurus C7xx, C8xx (corgi/sheperd/husky)
-
-	// Atmel at91sam9261-EK uses ads7843
-
-	// also various AMD Au1x00 devel boards
-
 	return spi_register_driver(&ads7846_driver);
 }
 module_init(ads7846_init);
@@ -1206,14 +1174,6 @@ module_init(ads7846_init);
 static void __exit ads7846_exit(void)
 {
 	spi_unregister_driver(&ads7846_driver);
-
-#ifdef	CONFIG_ARCH_OMAP
-	if (machine_is_omap_osk()) {
-		omap_free_gpio(4);
-		omap_free_gpio(6);
-	}
-#endif
-
 }
 module_exit(ads7846_exit);
 
-- 
1.5.3.6


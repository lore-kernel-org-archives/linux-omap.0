From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: [OMAP tree][RFC 2.6.28-rc2-omap 2/9] ARM: OMAP: Switch to gpio_request/free calls (part 2)
Date: Fri, 31 Oct 2008 14:18:50 +0200
Message-ID: <1225455537-14017-3-git-send-email-jarkko.nikula@nokia.com>
References: <1225455537-14017-1-git-send-email-jarkko.nikula@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:33831 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751223AbYJaMUH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 31 Oct 2008 08:20:07 -0400
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m9VCIuSM032147
	for <linux-omap@vger.kernel.org>; Fri, 31 Oct 2008 07:20:05 -0500
In-Reply-To: <1225455537-14017-1-git-send-email-jarkko.nikula@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Jarkko Nikula <jarkko.nikula@nokia.com>

This converts new files which are not yet merged upstream including
gpio-switch and board files for 3430sdp, Nokia N800 and omap3evm.

Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
---
 arch/arm/mach-omap2/board-3430sdp.c     |    4 ++--
 arch/arm/mach-omap2/board-n800-camera.c |    4 ++--
 arch/arm/mach-omap2/board-n800-mmc.c    |   14 +++++++-------
 arch/arm/mach-omap2/board-n800-usb.c    |    6 +++---
 arch/arm/mach-omap2/board-n800.c        |    6 +++---
 arch/arm/mach-omap2/board-omap3evm.c    |    4 ++--
 arch/arm/plat-omap/gpio-switch.c        |    8 ++++----
 7 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index 1feeff6..0155920 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -165,7 +165,7 @@ out:
  */
 static void ads7846_dev_init(void)
 {
-	if (omap_request_gpio(ts_gpio) < 0) {
+	if (gpio_request(ts_gpio, "ADS7846 pendown") < 0) {
 		printk(KERN_ERR "can't get ads746 pen down GPIO\n");
 		return;
 	}
@@ -273,7 +273,7 @@ static inline void __init sdp3430_init_smc91x(void)
 
 	sdp3430_smc91x_resources[1].start = gpio_to_irq(eth_gpio);
 
-	if (omap_request_gpio(eth_gpio) < 0) {
+	if (gpio_request(eth_gpio, "SMC91x irq") < 0) {
 		printk(KERN_ERR "Failed to request GPIO%d for smc91x IRQ\n",
 			eth_gpio);
 		return;
diff --git a/arch/arm/mach-omap2/board-n800-camera.c b/arch/arm/mach-omap2/board-n800-camera.c
index 1f3b1e9..3959128 100644
--- a/arch/arm/mach-omap2/board-n800-camera.c
+++ b/arch/arm/mach-omap2/board-n800-camera.c
@@ -25,13 +25,13 @@
 #include <linux/platform_device.h>
 #include <linux/delay.h>
 #include <linux/videodev2.h>
+#include <linux/gpio.h>
 #include <linux/i2c/menelaus.h>
 
 #include <media/v4l2-int-device.h>
 
 #include <asm/mach-types.h>
 
-#include <mach/gpio.h>
 #include <mach/board.h>
 
 #include <../drivers/cbus/retu.h>
@@ -356,7 +356,7 @@ void __init n800_cam_init(void)
 {
 	int r;
 
-	r = omap_request_gpio(N800_CAM_SENSOR_RESET_GPIO);
+	r = gpio_request(N800_CAM_SENSOR_RESET_GPIO, "TCM825x reset");
 	if (r < 0) {
 		printk(KERN_WARNING "%s: failed to request gpio\n",
 			__func__);
diff --git a/arch/arm/mach-omap2/board-n800-mmc.c b/arch/arm/mach-omap2/board-n800-mmc.c
index 52328c0..2ec8192 100644
--- a/arch/arm/mach-omap2/board-n800-mmc.c
+++ b/arch/arm/mach-omap2/board-n800-mmc.c
@@ -11,12 +11,12 @@
 
 #include <linux/delay.h>
 #include <linux/platform_device.h>
+#include <linux/gpio.h>
 #include <linux/i2c/menelaus.h>
 
 #include <asm/mach-types.h>
 
 #include <mach/mmc.h>
-#include <mach/gpio.h>
 
 #if defined(CONFIG_MMC_OMAP) || defined(CONFIG_MMC_OMAP_MODULE)
 
@@ -284,11 +284,11 @@ static void n800_mmc_cleanup(struct device *dev)
 {
 	menelaus_unregister_mmc_callback();
 
-	omap_free_gpio(slot_switch_gpio);
+	gpio_free(slot_switch_gpio);
 
 	if (machine_is_nokia_n810()) {
-		omap_free_gpio(n810_slot2_pw_vddf);
-		omap_free_gpio(n810_slot2_pw_vdd);
+		gpio_free(n810_slot2_pw_vddf);
+		gpio_free(n810_slot2_pw_vdd);
 	}
 }
 
@@ -344,16 +344,16 @@ void __init n800_mmc_init(void)
 		mmc1_data.slots[1].ban_openended = 1;
 	}
 
-	if (omap_request_gpio(slot_switch_gpio) < 0)
+	if (gpio_request(slot_switch_gpio, "MMC slot switch") < 0)
 		BUG();
 	gpio_direction_output(slot_switch_gpio, 0);
 
 	if (machine_is_nokia_n810()) {
-		if (omap_request_gpio(n810_slot2_pw_vddf) < 0)
+		if (gpio_request(n810_slot2_pw_vddf, "MMC slot 2 Vddf") < 0)
 			BUG();
 		gpio_direction_output(n810_slot2_pw_vddf, 0);
 
-		if (omap_request_gpio(n810_slot2_pw_vdd) < 0)
+		if (gpio_request(n810_slot2_pw_vdd, "MMC slot 2 Vdd") < 0)
 			BUG();
 		gpio_direction_output(n810_slot2_pw_vdd, 0);
 	}
diff --git a/arch/arm/mach-omap2/board-n800-usb.c b/arch/arm/mach-omap2/board-n800-usb.c
index 5ab453d..e182a93 100644
--- a/arch/arm/mach-omap2/board-n800-usb.c
+++ b/arch/arm/mach-omap2/board-n800-usb.c
@@ -14,9 +14,9 @@
 #include <linux/platform_device.h>
 #include <linux/clk.h>
 #include <linux/err.h>
+#include <linux/gpio.h>
 #include <linux/usb/musb.h>
 #include <mach/gpmc.h>
-#include <mach/gpio.h>
 #include <mach/pm.h>
 
 #define TUSB_ASYNC_CS		1
@@ -150,7 +150,7 @@ void __init n800_usb_init(void)
 	static char	announce[] __initdata = KERN_INFO "TUSB 6010\n";
 
 	/* PM companion chip power control pin */
-	ret = omap_request_gpio(GPIO_TUSB_ENABLE);
+	ret = gpio_request(GPIO_TUSB_ENABLE, "TUSB6010 enable");
 	if (ret != 0) {
 		printk(KERN_ERR "Could not get TUSB power GPIO%i\n",
 		       GPIO_TUSB_ENABLE);
@@ -171,5 +171,5 @@ void __init n800_usb_init(void)
 	return;
 
 err:
-	omap_free_gpio(GPIO_TUSB_ENABLE);
+	gpio_free(GPIO_TUSB_ENABLE);
 }
diff --git a/arch/arm/mach-omap2/board-n800.c b/arch/arm/mach-omap2/board-n800.c
index 66c7d18..b38b295 100644
--- a/arch/arm/mach-omap2/board-n800.c
+++ b/arch/arm/mach-omap2/board-n800.c
@@ -127,7 +127,7 @@ void __init nokia_n800_init_irq(void)
 	omap_gpio_init();
 
 #ifdef CONFIG_OMAP_STI
-	if (omap_request_gpio(N800_STI_GPIO) < 0) {
+	if (gpio_request(N800_STI_GPIO, "STI") < 0) {
 		printk(KERN_ERR "Failed to request GPIO %d for STI\n",
 		       N800_STI_GPIO);
 		return;
@@ -254,7 +254,7 @@ static void __init blizzard_dev_init(void)
 {
 	int r;
 
-	r = omap_request_gpio(N800_BLIZZARD_POWERDOWN_GPIO);
+	r = gpio_request(N800_BLIZZARD_POWERDOWN_GPIO, "Blizzard pd");
 	if (r < 0)
 		return;
 	gpio_direction_output(N800_BLIZZARD_POWERDOWN_GPIO, 1);
@@ -331,7 +331,7 @@ static int __init tea5761_dev_init(void)
 		pr_debug("Enabling tea5761 at GPIO %d\n",
 			 enable_gpio);
 
-		if (omap_request_gpio(enable_gpio) < 0) {
+		if (gpio_request(enable_gpio, "TEA5761 enable") < 0) {
 			printk(KERN_ERR "Can't request GPIO %d\n",
 			       enable_gpio);
 			return -ENODEV;
diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index 8a8b2fa..7644cf6 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -75,7 +75,7 @@ static inline void __init omap3evm_init_smc911x(void)
 	else
 		rate = clk_get_rate(l3ck);
 
-	if (omap_request_gpio(OMAP3EVM_ETHR_GPIO_IRQ) < 0) {
+	if (gpio_request(OMAP3EVM_ETHR_GPIO_IRQ, "SMC911x irq") < 0) {
 		printk(KERN_ERR "Failed to request GPIO%d for smc911x IRQ\n",
 			OMAP3EVM_ETHR_GPIO_IRQ);
 		return;
@@ -171,7 +171,7 @@ static struct omap_lcd_config omap3_evm_lcd_config __initdata = {
 
 static void ads7846_dev_init(void)
 {
-	if (omap_request_gpio(OMAP3_EVM_TS_GPIO) < 0)
+	if (gpio_request(OMAP3_EVM_TS_GPIO, "ADS7846 pendown") < 0)
 		printk(KERN_ERR "can't get ads7846 pen down GPIO\n");
 
 	gpio_direction_input(OMAP3_EVM_TS_GPIO);
diff --git a/arch/arm/plat-omap/gpio-switch.c b/arch/arm/plat-omap/gpio-switch.c
index f18f6df..2b5665d 100644
--- a/arch/arm/plat-omap/gpio-switch.c
+++ b/arch/arm/plat-omap/gpio-switch.c
@@ -19,8 +19,8 @@
 #include <linux/platform_device.h>
 #include <linux/timer.h>
 #include <linux/err.h>
+#include <linux/gpio.h>
 #include <mach/hardware.h>
-#include <mach/gpio.h>
 #include <mach/irqs.h>
 #include <mach/mux.h>
 #include <mach/board.h>
@@ -278,7 +278,7 @@ static int __init new_switch(struct gpio_switch *sw)
 	}
 	dev_set_drvdata(&sw->pdev.dev, sw);
 
-	r = omap_request_gpio(sw->gpio);
+	r = gpio_request(sw->gpio, sw->name);
 	if (r < 0) {
 		platform_device_unregister(&sw->pdev);
 		return r;
@@ -319,7 +319,7 @@ static int __init new_switch(struct gpio_switch *sw)
 		printk(KERN_ERR "gpio-switch: request_irq() failed "
 		       "for GPIO %d\n", sw->gpio);
 		platform_device_unregister(&sw->pdev);
-		omap_free_gpio(sw->gpio);
+		gpio_free(sw->gpio);
 		return r;
 	}
 
@@ -455,7 +455,7 @@ static void gpio_sw_cleanup(void)
 		device_remove_file(&sw->pdev.dev, &dev_attr_direction);
 
 		platform_device_unregister(&sw->pdev);
-		omap_free_gpio(sw->gpio);
+		gpio_free(sw->gpio);
 		old = sw;
 	}
 	kfree(old);
-- 
1.5.6.5


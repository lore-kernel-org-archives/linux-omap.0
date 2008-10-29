From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: [RFC 11/21] ARM: OMAP: Complete N8x0 board file gpiolib conversion
Date: Wed, 29 Oct 2008 13:36:19 +0200
Message-ID: <1225280189-6559-12-git-send-email-jarkko.nikula@nokia.com>
References: <1225280189-6559-1-git-send-email-jarkko.nikula@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:53269 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752280AbYJ2Lhr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Oct 2008 07:37:47 -0400
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m9TBbQx7031718
	for <linux-omap@vger.kernel.org>; Wed, 29 Oct 2008 06:37:45 -0500
In-Reply-To: <1225280189-6559-1-git-send-email-jarkko.nikula@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Jarkko Nikula <jarkko.nikula@nokia.com>

Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
---
 arch/arm/mach-omap2/board-n800-camera.c |    4 ++--
 arch/arm/mach-omap2/board-n800-mmc.c    |   14 +++++++-------
 arch/arm/mach-omap2/board-n800-usb.c    |    6 +++---
 arch/arm/mach-omap2/board-n800.c        |    6 +++---
 4 files changed, 15 insertions(+), 15 deletions(-)

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
index 469572e..178f895 100644
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
 
@@ -287,11 +287,11 @@ static void n800_mmc_cleanup(struct device *dev)
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
 
@@ -347,16 +347,16 @@ void __init n800_mmc_init(void)
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
-- 
1.5.6.5


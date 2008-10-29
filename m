From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: [RFC 06/21] CBUS: Complete gpiolib conversion
Date: Wed, 29 Oct 2008 13:36:14 +0200
Message-ID: <1225280189-6559-7-git-send-email-jarkko.nikula@nokia.com>
References: <1225280189-6559-1-git-send-email-jarkko.nikula@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:59919 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753329AbYJ2Lhi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Oct 2008 07:37:38 -0400
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m9TBb6RJ017033
	for <linux-omap@vger.kernel.org>; Wed, 29 Oct 2008 13:37:36 +0200
In-Reply-To: <1225280189-6559-1-git-send-email-jarkko.nikula@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Jarkko Nikula <jarkko.nikula@nokia.com>

Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
---
 drivers/cbus/cbus.c  |   12 ++++++------
 drivers/cbus/retu.c  |   10 +++++-----
 drivers/cbus/tahvo.c |   10 +++++-----
 3 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/cbus/cbus.c b/drivers/cbus/cbus.c
index 1a184b0..020afad 100644
--- a/drivers/cbus/cbus.c
+++ b/drivers/cbus/cbus.c
@@ -28,8 +28,8 @@
 #include <linux/kernel.h>
 #include <linux/delay.h>
 #include <linux/spinlock.h>
+#include <linux/gpio.h>
 
-#include <mach/gpio.h>
 #include <mach/board.h>
 
 #include <asm/io.h>
@@ -253,13 +253,13 @@ int __init cbus_bus_init(void)
 	}
 #endif
 
-	if ((ret = omap_request_gpio(chost->clk_gpio)) < 0)
+	if ((ret = gpio_request(chost->clk_gpio, "CBUS clk")) < 0)
 		goto exit1;
 
-	if ((ret = omap_request_gpio(chost->dat_gpio)) < 0)
+	if ((ret = gpio_request(chost->dat_gpio, "CBUS data")) < 0)
 		goto exit2;
 
-	if ((ret = omap_request_gpio(chost->sel_gpio)) < 0)
+	if ((ret = gpio_request(chost->sel_gpio, "CBUS sel")) < 0)
 		goto exit3;
 
 	gpio_direction_output(chost->clk_gpio, 0);
@@ -273,9 +273,9 @@ int __init cbus_bus_init(void)
 
 	return 0;
 exit3:
-	omap_free_gpio(chost->dat_gpio);
+	gpio_free(chost->dat_gpio);
 exit2:
-	omap_free_gpio(chost->clk_gpio);
+	gpio_free(chost->clk_gpio);
 exit1:
 	kfree(chost);
 	return ret;
diff --git a/drivers/cbus/retu.c b/drivers/cbus/retu.c
index 5f9a20a..35ea149 100644
--- a/drivers/cbus/retu.c
+++ b/drivers/cbus/retu.c
@@ -35,11 +35,11 @@
 #include <linux/irq.h>
 #include <linux/interrupt.h>
 #include <linux/platform_device.h>
+#include <linux/gpio.h>
 
 #include <asm/uaccess.h>
 
 #include <mach/mux.h>
-#include <mach/gpio.h>
 #include <mach/board.h>
 
 #include "cbus.h"
@@ -335,7 +335,7 @@ static int __devinit retu_probe(struct device *dev)
 
 	retu_irq_pin = em_asic_config->retu_irq_gpio;
 
-	if ((ret = omap_request_gpio(retu_irq_pin)) < 0) {
+	if ((ret = gpio_request(retu_irq_pin, "RETU irq")) < 0) {
 		printk(KERN_ERR PFX "Unable to reserve IRQ GPIO\n");
 		return ret;
 	}
@@ -362,7 +362,7 @@ static int __devinit retu_probe(struct device *dev)
 			  "retu", 0);
 	if (ret < 0) {
 		printk(KERN_ERR PFX "Unable to register IRQ handler\n");
-		omap_free_gpio(retu_irq_pin);
+		gpio_free(retu_irq_pin);
 		return ret;
 	}
 	set_irq_wake(gpio_to_irq(retu_irq_pin), 1);
@@ -375,7 +375,7 @@ static int __devinit retu_probe(struct device *dev)
 	if (retu_user_init() < 0) {
 		printk(KERN_ERR "Unable to initialize driver\n");
 		free_irq(gpio_to_irq(retu_irq_pin), 0);
-		omap_free_gpio(retu_irq_pin);
+		gpio_free(retu_irq_pin);
 		return ret;
 	}
 #endif
@@ -391,7 +391,7 @@ static int retu_remove(struct device *dev)
 	/* Mask all RETU interrupts */
 	retu_write_reg(RETU_REG_IMR, 0xffff);
 	free_irq(gpio_to_irq(retu_irq_pin), 0);
-	omap_free_gpio(retu_irq_pin);
+	gpio_free(retu_irq_pin);
 	tasklet_kill(&retu_tasklet);
 
 	return 0;
diff --git a/drivers/cbus/tahvo.c b/drivers/cbus/tahvo.c
index fe665d4..eab593f 100644
--- a/drivers/cbus/tahvo.c
+++ b/drivers/cbus/tahvo.c
@@ -35,11 +35,11 @@
 #include <linux/irq.h>
 #include <linux/interrupt.h>
 #include <linux/platform_device.h>
+#include <linux/gpio.h>
 
 #include <asm/uaccess.h>
 
 #include <mach/mux.h>
-#include <mach/gpio.h>
 #include <mach/board.h>
 
 #include "cbus.h"
@@ -322,7 +322,7 @@ static int __devinit tahvo_probe(struct device *dev)
 
 	tahvo_irq_pin = em_asic_config->tahvo_irq_gpio;
 
-	if ((ret = omap_request_gpio(tahvo_irq_pin)) < 0) {
+	if ((ret = gpio_request(tahvo_irq_pin, "TAHVO irq")) < 0) {
 		printk(KERN_ERR PFX "Unable to reserve IRQ GPIO\n");
 		return ret;
 	}
@@ -340,7 +340,7 @@ static int __devinit tahvo_probe(struct device *dev)
 			  "tahvo", 0);
 	if (ret < 0) {
 		printk(KERN_ERR PFX "Unable to register IRQ handler\n");
-		omap_free_gpio(tahvo_irq_pin);
+		gpio_free(tahvo_irq_pin);
 		return ret;
 	}
 #ifdef CONFIG_CBUS_TAHVO_USER
@@ -348,7 +348,7 @@ static int __devinit tahvo_probe(struct device *dev)
 	if (tahvo_user_init() < 0) {
 		printk(KERN_ERR "Unable to initialize driver\n");
 		free_irq(gpio_to_irq(tahvo_irq_pin), 0);
-		omap_free_gpio(tahvo_irq_pin);
+		gpio_free(tahvo_irq_pin);
 		return ret;
 	}
 #endif
@@ -363,7 +363,7 @@ static int tahvo_remove(struct device *dev)
 	/* Mask all TAHVO interrupts */
 	tahvo_write_reg(TAHVO_REG_IMR, 0xffff);
 	free_irq(gpio_to_irq(tahvo_irq_pin), 0);
-	omap_free_gpio(tahvo_irq_pin);
+	gpio_free(tahvo_irq_pin);
 	tasklet_kill(&tahvo_tasklet);
 
 	return 0;
-- 
1.5.6.5


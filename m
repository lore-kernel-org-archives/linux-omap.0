From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH 21/22] twl4030-gpio: irq and other cleanup
Date: Mon, 29 Sep 2008 16:14:38 +0300
Message-ID: <1222694079-16289-22-git-send-email-felipe.balbi@nokia.com>
References: <1222694079-16289-1-git-send-email-felipe.balbi@nokia.com>
 <1222694079-16289-2-git-send-email-felipe.balbi@nokia.com>
 <1222694079-16289-3-git-send-email-felipe.balbi@nokia.com>
 <1222694079-16289-4-git-send-email-felipe.balbi@nokia.com>
 <1222694079-16289-5-git-send-email-felipe.balbi@nokia.com>
 <1222694079-16289-6-git-send-email-felipe.balbi@nokia.com>
 <1222694079-16289-7-git-send-email-felipe.balbi@nokia.com>
 <1222694079-16289-8-git-send-email-felipe.balbi@nokia.com>
 <1222694079-16289-9-git-send-email-felipe.balbi@nokia.com>
 <1222694079-16289-10-git-send-email-felipe.balbi@nokia.com>
 <1222694079-16289-11-git-send-email-felipe.balbi@nokia.com>
 <1222694079-16289-12-git-send-email-felipe.balbi@nokia.com>
 <1222694079-16289-13-git-send-email-felipe.balbi@nokia.com>
 <1222694079-16289-14-git-send-email-felipe.balbi@nokia.com>
 <1222694079-16289-15-git-send-email-felipe.balbi@nokia.com>
 <1222694079-16289-16-git-send-email-felipe.balbi@nokia.com>
 <1222694079-16289-17-git-send-email-felipe.balbi@nokia.com>
 <1222694079-16289-18-git-send-email-felipe.balbi@nokia.com>
 <1222694079-16289-19-git-send-email-felipe.balbi@nokia.com>
 <1222694079-16289-20-git-send-email-felipe.balbi@nokia.com>
 <1222694079-16289-21-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:52212 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751838AbYI2NP0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Sep 2008 09:15:26 -0400
In-Reply-To: <1222694079-16289-21-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: David Brownell <dbrownell@users.sourceforge.net>, Tony Lindgren <tony@atomide.com>, Felipe Balbi <felipe.balbi@nokia.com>

From: David Brownell <dbrownell@users.sourceforge.net>

Remove some ARM and OMAP specific stuff from the twl4030 GPIO code,
and some unused/undesirable CPP symbols.  Add minor checkpatch fixes.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/gpio/twl4030-gpio.c |   27 ++++++++-------------------
 include/linux/i2c/twl4030.h |    6 ------
 2 files changed, 8 insertions(+), 25 deletions(-)

diff --git a/drivers/gpio/twl4030-gpio.c b/drivers/gpio/twl4030-gpio.c
index 404cb34..cb83ff3 100644
--- a/drivers/gpio/twl4030-gpio.c
+++ b/drivers/gpio/twl4030-gpio.c
@@ -40,20 +40,12 @@
 #include <linux/i2c/twl4030.h>
 #include <linux/i2c/twl4030-gpio.h>
 
-#include <mach/irqs.h>
-#include <asm/mach/irq.h>
-#include <mach/gpio.h>
-#include <mach/mux.h>
 
-
-/* REVISIT when these symbols vanish elsewhere, remove them here too */
-/* #undef TWL4030_GPIO_IRQ_BASE */
-/* #undef TWL4030_GPIO_IRQ_END */
-
-static struct gpio_chip twl_gpiochip;
 static int twl4030_gpio_irq_base;
 static int twl4030_gpio_irq_end;
+static struct gpio_chip twl_gpiochip;
 
+/* genirq interfaces are not available to modules */
 #ifdef MODULE
 #define is_module()	true
 #else
@@ -530,7 +522,7 @@ static int twl4030_set_gpio_edge_ctrl(int gpio, int edge)
 	if (ret >= 0) {
 		/* clear the previous rising/falling values */
 		reg = (u8) ret;
-		reg &= ~( MASK_GPIO_EDR1_GPIOxFALLING(c_off)
+		reg &= ~(MASK_GPIO_EDR1_GPIOxFALLING(c_off)
 			| MASK_GPIO_EDR1_GPIOxRISING(c_off));
 		reg |= c_msk;
 		ret = gpio_twl4030_write(base, reg);
@@ -598,7 +590,7 @@ int twl4030_set_gpio_card_detect(int gpio, int enable)
 		ret = gpio_twl4030_write(REG_GPIO_CTRL, reg);
 	}
 	mutex_unlock(&gpio_lock);
-	return (ret);
+	return ret;
 }
 #endif
 
@@ -847,9 +839,9 @@ static int __devinit gpio_twl4030_probe(struct platform_device *pdev)
 		/* install an irq handler for each of the gpio interrupts */
 		for (irq = twl4030_gpio_irq_base; irq < twl4030_gpio_irq_end;
 				irq++) {
-			set_irq_chip(irq, &twl4030_gpio_irq_chip);
-			set_irq_handler(irq, do_twl4030_gpio_irq);
-			set_irq_flags(irq, IRQF_VALID);
+			set_irq_noprobe(irq);
+			set_irq_chip_and_handler(irq, &twl4030_gpio_irq_chip,
+					do_twl4030_gpio_irq);
 		}
 
 		/* gpio module IRQ */
@@ -918,13 +910,10 @@ static int __devexit gpio_twl4030_remove(struct platform_device *pdev)
 	/* uninstall the gpio demultiplexing interrupt handler */
 	irq = platform_get_irq(pdev, 0);
 	set_irq_handler(irq, NULL);
-	set_irq_flags(irq, 0);
 
 	/* uninstall the irq handler for each of the gpio interrupts */
-	for (irq = twl4030_gpio_irq_base; irq < twl4030_gpio_irq_end; irq++) {
+	for (irq = twl4030_gpio_irq_base; irq < twl4030_gpio_irq_end; irq++)
 		set_irq_handler(irq, NULL);
-		set_irq_flags(irq, 0);
-	}
 
 	/* stop the gpio unmask kernel thread */
 	if (gpio_unmask_thread) {
diff --git a/include/linux/i2c/twl4030.h b/include/linux/i2c/twl4030.h
index f26fda1..56a9415 100644
--- a/include/linux/i2c/twl4030.h
+++ b/include/linux/i2c/twl4030.h
@@ -138,17 +138,11 @@ struct twl4030_platform_data {
 
 /* TWL4030 GPIO interrupt definitions */
 
-#define TWL4030_GPIO_MIN		0
 #define TWL4030_GPIO_MAX		18
-#define TWL4030_GPIO_MAX_CD		2
 #define TWL4030_GPIO_IRQ_NO(n)		(TWL4030_GPIO_IRQ_BASE + (n))
-#define TWL4030_GPIO_IS_INPUT		1
-#define TWL4030_GPIO_IS_OUTPUT		0
 #define TWL4030_GPIO_IS_ENABLE		1
-#define TWL4030_GPIO_IS_DISABLE		0
 #define TWL4030_GPIO_PULL_UP		0
 #define TWL4030_GPIO_PULL_DOWN		1
-#define TWL4030_GPIO_PULL_NONE		2
 
 /* Functions to read and write from TWL4030 */
 
-- 
1.6.0.2.307.gc427


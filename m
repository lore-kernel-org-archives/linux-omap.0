From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH 03/23] I2C: TWL4030: checkpatch.pl fixes for twl4030-gpio.c
Date: Fri, 11 Apr 2008 11:28:16 +0300
Message-ID: <1207902516-6374-4-git-send-email-felipe.balbi@nokia.com>
References: <1207902516-6374-1-git-send-email-felipe.balbi@nokia.com>
 <1207902516-6374-2-git-send-email-felipe.balbi@nokia.com>
 <1207902516-6374-3-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:40220 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756803AbYDKI3o (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Apr 2008 04:29:44 -0400
Received: from esebh108.NOE.Nokia.com (esebh108.ntc.nokia.com [172.21.143.145])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m3B8TWu9030692
	for <linux-omap@vger.kernel.org>; Fri, 11 Apr 2008 03:31:59 -0500
In-Reply-To: <1207902516-6374-3-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Felipe Balbi <felipe.balbi@nokia.com>

Misc cleanup patch.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/i2c/chips/twl4030-gpio.c |   37 ++++++++++++++++++-------------------
 1 files changed, 18 insertions(+), 19 deletions(-)

diff --git a/drivers/i2c/chips/twl4030-gpio.c b/drivers/i2c/chips/twl4030-gpio.c
index a9f3b1d..349cbda 100644
--- a/drivers/i2c/chips/twl4030-gpio.c
+++ b/drivers/i2c/chips/twl4030-gpio.c
@@ -34,13 +34,13 @@
 #include <linux/random.h>
 #include <linux/syscalls.h>
 #include <linux/kthread.h>
+#include <linux/irq.h>
 
 #include <linux/i2c.h>
 #include <linux/i2c/twl4030.h>
 #include <linux/slab.h>
 
 #include <asm/arch/irqs.h>
-#include <asm/irq.h>
 #include <asm/mach/irq.h>
 #include <asm/arch/gpio.h>
 #include <asm/arch/mux.h>
@@ -145,16 +145,16 @@
 #define GPIO_BANK_MAX			GET_GPIO_CTL_BANK(TWL4030_GPIO_MAX)
 
 /* GPIOPUPDCTRx Fields 5 banks of 4 gpios each */
-#define BIT_GPIOPUPDCTR1_GPIOxPD(x)	(2 *(x))
-#define MASK_GPIOPUPDCTR1_GPIOxPD(x)	(0x01 << (2*(x)))
+#define BIT_GPIOPUPDCTR1_GPIOxPD(x)	(2 * (x))
+#define MASK_GPIOPUPDCTR1_GPIOxPD(x)	(0x01 << (2 * (x)))
 #define BIT_GPIOPUPDCTR1_GPIOxPU(x)	((x) + 1)
-#define MASK_GPIOPUPDCTR1_GPIOxPU(x)	(0x01 << (((2*(x)) + 1)))
+#define MASK_GPIOPUPDCTR1_GPIOxPU(x)	(0x01 << (((2 * (x)) + 1)))
 
 /* GPIO_EDR1 Fields */
-#define BIT_GPIO_EDR1_GPIOxFALLING(x)	(2 *(x))
-#define MASK_GPIO_EDR1_GPIOxFALLING(x)	(0x01 << (2*(x)))
+#define BIT_GPIO_EDR1_GPIOxFALLING(x)	(2 * (x))
+#define MASK_GPIO_EDR1_GPIOxFALLING(x)	(0x01 << (2 * (x)))
 #define BIT_GPIO_EDR1_GPIOxRISING(x)	((x) + 1)
-#define MASK_GPIO_EDR1_GPIOxRISING(x)	(0x01 << (((2*(x)) + 1)))
+#define MASK_GPIO_EDR1_GPIOxRISING(x)	(0x01 << (((2 * (x)) + 1)))
 
 /* GPIO_SIH_CTRL Fields */
 #define BIT_GPIO_SIH_CTRL_EXCLEN	(0x000)
@@ -343,6 +343,7 @@ int twl4030_request_gpio(int gpio)
 	up(&gpio_sem);
 	return ret;
 }
+EXPORT_SYMBOL(twl4030_request_gpio);
 
 /*
  * TWL4030 GPIO free module
@@ -368,6 +369,7 @@ int twl4030_free_gpio(int gpio)
 	up(&gpio_sem);
 	return ret;
 }
+EXPORT_SYMBOL(twl4030_free_gpio);
 
 /*
  * Set direction for TWL4030 GPIO
@@ -399,6 +401,7 @@ int twl4030_set_gpio_direction(int gpio, int is_input)
 	up(&gpio_sem);
 	return ret;
 }
+EXPORT_SYMBOL(twl4030_set_gpio_direction);
 
 /*
  * To enable/disable GPIO pin on TWL4030
@@ -424,6 +427,7 @@ int twl4030_set_gpio_dataout(int gpio, int enable)
 	up(&gpio_sem);
 	return ret;
 }
+EXPORT_SYMBOL(twl4030_set_gpio_dataout);
 
 /*
  * To get the status of a GPIO pin on TWL4030
@@ -448,6 +452,7 @@ int twl4030_get_gpio_datain(int gpio)
 
 	return ret;
 }
+EXPORT_SYMBOL(twl4030_get_gpio_datain);
 
 /*
  * Configure PULL type for a GPIO pin on TWL4030
@@ -484,6 +489,7 @@ int twl4030_set_gpio_pull(int gpio, int pull_dircn)
 	up(&gpio_sem);
 	return ret;
 }
+EXPORT_SYMBOL(twl4030_set_gpio_pull);
 
 /*
  * Configure Edge control for a GPIO pin on TWL4030
@@ -523,6 +529,7 @@ int twl4030_set_gpio_edge_ctrl(int gpio, int edge)
 	up(&gpio_sem);
 	return ret;
 }
+EXPORT_SYMBOL(twl4030_set_gpio_edge_ctrl);
 
 /*
  * Configure debounce timing value for a GPIO pin on TWL4030
@@ -553,6 +560,7 @@ int twl4030_set_gpio_debounce(int gpio, int enable)
 	up(&gpio_sem);
 	return ret;
 }
+EXPORT_SYMBOL(twl4030_set_gpio_debounce);
 
 /*
  * Configure Card detect for GPIO pin on TWL4030
@@ -583,6 +591,7 @@ int twl4030_set_gpio_card_detect(int gpio, int enable)
 	up(&gpio_sem);
 	return (ret);
 }
+EXPORT_SYMBOL(twl4030_set_gpio_card_detect);
 
 /* MODULE FUNCTIONS */
 
@@ -765,8 +774,8 @@ static int __init gpio_twl4030_init(void)
 			NULL, "twl4030 gpio");
 		if (!gpio_unmask_thread) {
 			printk(KERN_ERR
-				"%s: could not create twl4030 gpio unmask thread!\n",
-				__FUNCTION__);
+				"%s: could not create twl4030 gpio unmask"
+				" thread!\n", __func__);
 			ret = -ENOMEM;
 		}
 	}
@@ -821,16 +830,6 @@ static void __exit gpio_twl4030_exit(void)
 module_init(gpio_twl4030_init);
 module_exit(gpio_twl4030_exit);
 
-EXPORT_SYMBOL(twl4030_request_gpio);
-EXPORT_SYMBOL(twl4030_free_gpio);
-EXPORT_SYMBOL(twl4030_set_gpio_direction);
-EXPORT_SYMBOL(twl4030_set_gpio_dataout);
-EXPORT_SYMBOL(twl4030_get_gpio_datain);
-EXPORT_SYMBOL(twl4030_set_gpio_pull);
-EXPORT_SYMBOL(twl4030_set_gpio_edge_ctrl);
-EXPORT_SYMBOL(twl4030_set_gpio_debounce);
-EXPORT_SYMBOL(twl4030_set_gpio_card_detect);
-
 MODULE_AUTHOR("Texas Instruments, Inc.");
 MODULE_DESCRIPTION("GPIO interface for TWL4030");
 MODULE_LICENSE("GPL");
-- 
1.5.5.23.g2a5fe


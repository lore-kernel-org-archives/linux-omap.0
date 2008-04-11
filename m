From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH 2/2] I2C: TWL4030: sparse fixes for twl4030 driver
Date: Fri, 11 Apr 2008 13:59:17 +0300
Message-ID: <1207911557-9392-3-git-send-email-felipe.balbi@nokia.com>
References: <1207911557-9392-1-git-send-email-felipe.balbi@nokia.com>
 <1207911557-9392-2-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:22612 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759366AbYDKLAg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Apr 2008 07:00:36 -0400
Received: from esebh108.NOE.Nokia.com (esebh108.ntc.nokia.com [172.21.143.145])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m3BB06ho021799
	for <linux-omap@vger.kernel.org>; Fri, 11 Apr 2008 14:00:33 +0300
In-Reply-To: <1207911557-9392-2-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Felipe Balbi <felipe.balbi@nokia.com>

Get rid of some sparse warnings in twl4030 driver.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/i2c/chips/twl4030-core.c     |    2 +-
 drivers/i2c/chips/twl4030-gpio.c     |   53 ++++++++++++++++------------------
 drivers/i2c/chips/twl4030-poweroff.c |    2 +-
 3 files changed, 27 insertions(+), 30 deletions(-)

diff --git a/drivers/i2c/chips/twl4030-core.c b/drivers/i2c/chips/twl4030-core.c
index 953c247..eedbebd 100644
--- a/drivers/i2c/chips/twl4030-core.c
+++ b/drivers/i2c/chips/twl4030-core.c
@@ -638,7 +638,7 @@ static int twl4030_detach_client(struct i2c_client *client)
 	return 0;
 }
 
-struct task_struct *start_twl4030_irq_thread(int irq)
+static struct task_struct *start_twl4030_irq_thread(int irq)
 {
 	struct task_struct *thread;
 
diff --git a/drivers/i2c/chips/twl4030-gpio.c b/drivers/i2c/chips/twl4030-gpio.c
index 349cbda..c1f7107 100644
--- a/drivers/i2c/chips/twl4030-gpio.c
+++ b/drivers/i2c/chips/twl4030-gpio.c
@@ -190,9 +190,6 @@ static unsigned int gpio_pending_unmask;
 /* pointer to gpio unmask thread struct */
 static struct task_struct *gpio_unmask_thread;
 
-static inline int gpio_twl4030_read(u8 address);
-static inline int gpio_twl4030_write(u8 address, u8 data);
-
 /*
  * Helper functions to read and write the GPIO ISR and IMR registers as
  * 32-bit integers. Functions return 0 on success, non-zero otherwise.
@@ -312,6 +309,31 @@ static struct irq_chip twl4030_gpio_module_irq_chip = {
 };
 
 /*
+ * To configure TWL4030 GPIO module registers
+ */
+static inline int gpio_twl4030_write(u8 address, u8 data)
+{
+	int ret = 0;
+
+	ret = twl4030_i2c_write_u8(TWL4030_MODULE_GPIO, data, address);
+	return ret;
+}
+
+/*
+ * To read a TWL4030 GPIO module register
+ */
+static inline int gpio_twl4030_read(u8 address)
+{
+	u8 data;
+	int ret = 0;
+
+	ret = twl4030_i2c_read_u8(TWL4030_MODULE_GPIO, &data, address);
+	if (ret >= 0)
+		ret = data;
+	return ret;
+}
+
+/*
  * twl4030 GPIO request function
  */
 int twl4030_request_gpio(int gpio)
@@ -596,31 +618,6 @@ EXPORT_SYMBOL(twl4030_set_gpio_card_detect);
 /* MODULE FUNCTIONS */
 
 /*
- * To configure TWL4030 GPIO module registers
- */
-static inline int gpio_twl4030_write(u8 address, u8 data)
-{
-	int ret = 0;
-
-	ret = twl4030_i2c_write_u8(TWL4030_MODULE_GPIO, data, address);
-	return ret;
-}
-
-/*
- * To read a TWL4030 GPIO module register
- */
-static inline int gpio_twl4030_read(u8 address)
-{
-	u8 data;
-	int ret = 0;
-
-	ret = twl4030_i2c_read_u8(TWL4030_MODULE_GPIO, &data, address);
-	if (ret >= 0)
-		ret = data;
-	return ret;
-}
-
-/*
  * gpio_unmask_thread() runs as a kernel thread.  It is awakened by the unmask
  * method for the GPIO interrupts.  It unmasks all of the GPIO interrupts
  * specified in the gpio_pending_unmask bitmask.  We have to do the unmasking
diff --git a/drivers/i2c/chips/twl4030-poweroff.c b/drivers/i2c/chips/twl4030-poweroff.c
index dbe413a..57c7fc7 100644
--- a/drivers/i2c/chips/twl4030-poweroff.c
+++ b/drivers/i2c/chips/twl4030-poweroff.c
@@ -28,7 +28,7 @@
 #define PWR_P1_SW_EVENTS	0x10
 #define PWR_DEVOFF	(1<<0)
 
-void twl4030_poweroff(void)
+static void twl4030_poweroff(void)
 {
 	u8 val;
 	int err;
-- 
1.5.5.23.g2a5fe


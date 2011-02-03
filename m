From: Felipe Balbi <balbi@ti.com>
Subject: [RFT/RFC/PATCH 09/13] cbus: retu-pwrbutton: convert to threaded irq
Date: Thu,  3 Feb 2011 12:20:24 +0200
Message-ID: <1296728428-26399-10-git-send-email-balbi@ti.com>
References: <1296728428-26399-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:47435 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756152Ab1BCKVC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Feb 2011 05:21:02 -0500
Received: by mail-fx0-f47.google.com with SMTP id 17so984025fxm.6
        for <linux-omap@vger.kernel.org>; Thu, 03 Feb 2011 02:21:01 -0800 (PST)
In-Reply-To: <1296728428-26399-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <balbi@ti.com>

Drop the timer function and move to threaded
irq infrastructure.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/cbus/Makefile         |    2 +-
 drivers/cbus/retu-pwrbutton.c |   37 +++++++++----------------------------
 2 files changed, 10 insertions(+), 29 deletions(-)

diff --git a/drivers/cbus/Makefile b/drivers/cbus/Makefile
index 841bed5..23f82b4 100644
--- a/drivers/cbus/Makefile
+++ b/drivers/cbus/Makefile
@@ -9,7 +9,7 @@ obj-$(CONFIG_CBUS_TAHVO_USB)	+= tahvo-usb.o
 obj-$(CONFIG_CBUS_TAHVO_USER)	+= tahvo-user.o
 
 ## Disable Retu children until converted to threaded IRQ
-#obj-$(CONFIG_CBUS_RETU_POWERBUTTON) += retu-pwrbutton.o
+obj-$(CONFIG_CBUS_RETU_POWERBUTTON) += retu-pwrbutton.o
 #obj-$(CONFIG_CBUS_RETU_RTC)	+= retu-rtc.o
 #obj-$(CONFIG_CBUS_RETU_WDT)	+= retu-wdt.o
 obj-$(CONFIG_CBUS_RETU_HEADSET)	+= retu-headset.o
diff --git a/drivers/cbus/retu-pwrbutton.c b/drivers/cbus/retu-pwrbutton.c
index 6b8dfa9..2a5ccb0 100644
--- a/drivers/cbus/retu-pwrbutton.c
+++ b/drivers/cbus/retu-pwrbutton.c
@@ -30,9 +30,10 @@
 #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/input.h>
-#include <linux/timer.h>
 #include <linux/jiffies.h>
 #include <linux/bitops.h>
+#include <linux/irq.h>
+#include <linux/interrupt.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 
@@ -46,15 +47,14 @@
 
 struct retu_pwrbutton {
 	struct input_dev	*idev;
-	struct timer_list	timer;
 
 	int			state;
 	int			irq;
 };
 
-static void retubutton_timer_func(unsigned long arg)
+static irqreturn_t retubutton_irq(int irq, void *_pwr)
 {
-	struct retu_pwrbutton *pwr = (struct retu_pwrbutton *) arg;
+	struct retu_pwrbutton *pwr = _pwr;
 	int state;
 
 	if (retu_read_reg(RETU_REG_STATUS) & RETU_STATUS_PWRONX)
@@ -67,24 +67,10 @@ static void retubutton_timer_func(unsigned long arg)
 		input_sync(pwr->idev);
 		pwr->state = state;
 	}
-}
-
-/**
- * Interrupt function is called whenever power button key is pressed
- * or released.
- */
-static void retubutton_irq(unsigned long arg)
-{
-	struct retu_pwrbutton *pwr = (struct retu_pwrbutton *) arg;
 
-	retu_ack_irq(RETU_INT_PWR);
-	mod_timer(&pwr->timer, jiffies + msecs_to_jiffies(PWRBTN_DELAY));
+	return IRQ_HANDLED;
 }
 
-/**
- * Init function.
- * Allocates interrupt for power button and registers itself to input layer.
- */
 static int __init retubutton_probe(struct platform_device *pdev)
 {
 	struct retu_pwrbutton		*pwr;
@@ -99,10 +85,9 @@ static int __init retubutton_probe(struct platform_device *pdev)
 
 	pwr->irq = RETU_INT_PWR;
 	platform_set_drvdata(pdev, pwr);
-	setup_timer(&pwr->timer, retubutton_timer_func, (unsigned long) pwr);
 
-	ret = retu_request_irq(pwr->irq, retubutton_irq, (unsigned long) pwr,
-			"PwrOnX");
+	ret = request_threaded_irq(pwr->irq, NULL, retubutton_irq, 0,
+			"retu-pwrbutton", pwr);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "Cannot allocate irq\n");
 		goto err1;
@@ -131,7 +116,7 @@ err3:
 	input_free_device(pwr->idev);
 
 err2:
-	retu_free_irq(pwr->irq);
+	free_irq(pwr->irq, pwr);
 
 err1:
 	kfree(pwr);
@@ -140,15 +125,11 @@ err0:
 	return ret;
 }
 
-/**
- * Cleanup function which is called when driver is unloaded
- */
 static int __exit retubutton_remove(struct platform_device *pdev)
 {
 	struct retu_pwrbutton		*pwr = platform_get_drvdata(pdev);
 
-	retu_free_irq(pwr->irq);
-	del_timer_sync(&pwr->timer);
+	free_irq(pwr->irq, pwr);
 	input_unregister_device(pwr->idev);
 	input_free_device(pwr->idev);
 	kfree(pwr);
-- 
1.7.4.rc2


From: Felipe Balbi <balbi@ti.com>
Subject: [RFT/RFC/PATCH 10/13] cbus: retu-rtc: move to threaded irq
Date: Thu,  3 Feb 2011 12:20:25 +0200
Message-ID: <1296728428-26399-11-git-send-email-balbi@ti.com>
References: <1296728428-26399-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:38971 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756130Ab1BCKWC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Feb 2011 05:22:02 -0500
Received: by mail-fx0-f46.google.com with SMTP id 20so1016728fxm.19
        for <linux-omap@vger.kernel.org>; Thu, 03 Feb 2011 02:22:00 -0800 (PST)
In-Reply-To: <1296728428-26399-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <balbi@ti.com>

Move to the generic threaded irq infrastructure
and drop all the retu-specific magic.

Unfortunately, due to the conversion and lack of
docs, retu_rtc_ioctl() had to be dropped, someone
else with access to docs is free to implement it
later considering the new style of the driver.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/cbus/Makefile   |    2 +-
 drivers/cbus/retu-rtc.c |  120 ++++++----------------------------------------
 2 files changed, 17 insertions(+), 105 deletions(-)

diff --git a/drivers/cbus/Makefile b/drivers/cbus/Makefile
index 23f82b4..7bfd997 100644
--- a/drivers/cbus/Makefile
+++ b/drivers/cbus/Makefile
@@ -10,6 +10,6 @@ obj-$(CONFIG_CBUS_TAHVO_USER)	+= tahvo-user.o
 
 ## Disable Retu children until converted to threaded IRQ
 obj-$(CONFIG_CBUS_RETU_POWERBUTTON) += retu-pwrbutton.o
-#obj-$(CONFIG_CBUS_RETU_RTC)	+= retu-rtc.o
+obj-$(CONFIG_CBUS_RETU_RTC)	+= retu-rtc.o
 #obj-$(CONFIG_CBUS_RETU_WDT)	+= retu-wdt.o
 obj-$(CONFIG_CBUS_RETU_HEADSET)	+= retu-headset.o
diff --git a/drivers/cbus/retu-rtc.c b/drivers/cbus/retu-rtc.c
index cc789ed..6e201aa 100644
--- a/drivers/cbus/retu-rtc.c
+++ b/drivers/cbus/retu-rtc.c
@@ -38,11 +38,9 @@
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/module.h>
-#include <linux/completion.h>
 #include <linux/platform_device.h>
 #include <linux/mutex.h>
 #include <linux/rtc.h>
-#include <linux/workqueue.h>
 
 #include "cbus.h"
 #include "retu.h"
@@ -50,8 +48,6 @@
 struct retu_rtc {
 	/* device lock */
 	struct mutex		mutex;
-	struct completion	sync;
-	struct work_struct	work;
 	struct device		*dev;
 	struct rtc_device	*rtc;
 
@@ -59,18 +55,6 @@ struct retu_rtc {
 	u16			reset_occurred;
 };
 
-#define work_to_rtc(r)	(container_of(r, struct retu_rtc, work))
-
-/* This function provides syncronization with the RTCS interrupt handler */
-static void retu_rtc_barrier(struct retu_rtc *rtc)
-{
-	INIT_COMPLETION(rtc->sync);
-	retu_ack_irq(RETU_INT_RTCS);
-	retu_enable_irq(RETU_INT_RTCS);
-	wait_for_completion(&rtc->sync);
-	retu_disable_irq(RETU_INT_RTCS);
-}
-
 static void retu_rtc_do_reset(struct retu_rtc *rtc)
 {
 	u16 ccr1;
@@ -81,7 +65,6 @@ static void retu_rtc_do_reset(struct retu_rtc *rtc)
 	/* RTC in normal operating mode */
 	retu_write_reg(RETU_REG_CC1, ccr1 & ~0x0001);
 
-	retu_rtc_barrier(rtc);
 	/* Disable alarm and RTC WD */
 	retu_write_reg(RETU_REG_RTCHMAR, 0x7f3f);
 	/* Set Calibration register to default value */
@@ -91,62 +74,33 @@ static void retu_rtc_do_reset(struct retu_rtc *rtc)
 	rtc->reset_occurred = 1;
 }
 
-static void retu_rtca_disable(struct retu_rtc *rtc)
+static irqreturn_t retu_rtc_interrupt(int irq, void *_rtc)
 {
-	retu_disable_irq(RETU_INT_RTCA);
+	struct retu_rtc		*rtc = _rtc;
+
+	mutex_lock(&rtc->mutex);
 	rtc->alarm_expired = 1;
-	retu_rtc_barrier(rtc);
 	retu_write_reg(RETU_REG_RTCHMAR, (24 << 8) | 60);
-}
-
-static void retu_rtca_expired(struct work_struct *work)
-{
-	struct retu_rtc		*rtc = work_to_rtc(work);
-
-	retu_rtca_disable(rtc);
-}
-
-/*
- * RTCHMR RTCHMAR RTCCAL must be accessed within 0.9 s since the seconds
- * interrupt has been signaled in the IDR register
- */
-static void retu_rtcs_interrupt(unsigned long _rtc)
-{
-	struct retu_rtc		*rtc = (struct retu_rtc *) _rtc;
-
-	retu_ack_irq(RETU_INT_RTCS);
-	complete_all(&rtc->sync);
-}
-
-static void retu_rtca_interrupt(unsigned long _rtc)
-{
-	struct retu_rtc		*rtc = (struct retu_rtc *) _rtc;
+	mutex_unlock(&rtc->mutex);
 
-	retu_ack_irq(RETU_INT_RTCA);
-	schedule_work(&rtc->work);
+	return IRQ_HANDLED;
 }
 
 static int retu_rtc_init_irq(struct retu_rtc *rtc)
 {
 	int ret;
 
-	ret = retu_request_irq(RETU_INT_RTCS, retu_rtcs_interrupt,
-			(unsigned long) rtc, "RTCS");
+	ret = request_threaded_irq(RETU_INT_RTCS, NULL, retu_rtc_interrupt,
+			0, "RTCS", rtc);
 	if (ret != 0)
 		return ret;
-	/*
-	 * We will take care of enabling and disabling the interrupt
-	 * elsewhere, so leave it off by default..
-	 */
-	retu_disable_irq(RETU_INT_RTCS);
 
-	ret = retu_request_irq(RETU_INT_RTCA, retu_rtca_interrupt,
-			(unsigned long) rtc, "RTCA");
+	ret = request_threaded_irq(RETU_INT_RTCA, NULL, retu_rtc_interrupt,
+			0, "RTCA", rtc);
 	if (ret != 0) {
-		retu_free_irq(RETU_INT_RTCS);
+		free_irq(RETU_INT_RTCS, rtc);
 		return ret;
 	}
-	retu_disable_irq(RETU_INT_RTCA);
 
 	return 0;
 }
@@ -231,42 +185,7 @@ static int retu_rtc_read_time(struct device *dev, struct rtc_time *tm)
 	return 0;
 }
 
-#ifdef CONFIG_RTC_INTF_DEV
-
-static int retu_rtc_ioctl(struct device *dev, unsigned int cmd,
-		unsigned long arg)
-{
-	struct retu_rtc		*rtc = dev_get_drvdata(dev);
-
-	mutex_lock(&rtc->mutex);
-
-	switch (cmd) {
-	case RTC_AIE_OFF:
-		retu_disable_irq(RETU_INT_RTCA);
-		break;
-	case RTC_AIE_ON:
-		retu_enable_irq(RETU_INT_RTCA);
-		break;
-	case RTC_UIE_OFF:
-		retu_disable_irq(RETU_INT_RTCS);
-		break;
-	case RTC_UIE_ON:
-		retu_enable_irq(RETU_INT_RTCS);
-		break;
-	default:
-		return -ENOIOCTLCMD;
-	}
-
-	mutex_unlock(&rtc->mutex);
-
-	return 0;
-}
-#else
-#define retu_rtc_ioctl	NULL
-#endif
-
 static struct rtc_class_ops retu_rtc_ops = {
-	.ioctl			= retu_rtc_ioctl,
 	.read_time		= retu_rtc_read_time,
 	.set_time		= retu_rtc_set_time,
 	.read_alarm		= retu_rtc_read_alarm,
@@ -287,9 +206,7 @@ static int __init retu_rtc_probe(struct platform_device *pdev)
 
 	rtc->dev = &pdev->dev;
 	platform_set_drvdata(pdev, rtc);
-	INIT_WORK(&rtc->work, retu_rtca_expired);
 	mutex_init(&rtc->mutex);
-	init_completion(&rtc->sync);
 
 	r = retu_get_status();
 	if (!r) {
@@ -324,10 +241,8 @@ static int __init retu_rtc_probe(struct platform_device *pdev)
 	return 0;
 
 err2:
-	retu_disable_irq(RETU_INT_RTCS);
-	retu_disable_irq(RETU_INT_RTCA);
-	retu_free_irq(RETU_INT_RTCS);
-	retu_free_irq(RETU_INT_RTCA);
+	free_irq(RETU_INT_RTCS, rtc);
+	free_irq(RETU_INT_RTCA, rtc);
 
 err1:
 	kfree(rtc);
@@ -340,10 +255,8 @@ static int __devexit retu_rtc_remove(struct platform_device *pdev)
 {
 	struct retu_rtc		*rtc = platform_get_drvdata(pdev);
 
-	retu_disable_irq(RETU_INT_RTCS);
-	retu_disable_irq(RETU_INT_RTCA);
-	retu_free_irq(RETU_INT_RTCS);
-	retu_free_irq(RETU_INT_RTCA);
+	free_irq(RETU_INT_RTCS, rtc);
+	free_irq(RETU_INT_RTCA, rtc);
 	rtc_device_unregister(rtc->rtc);
 	kfree(rtc);
 
@@ -361,13 +274,12 @@ static int __init retu_rtc_init(void)
 {
 	return platform_driver_probe(&retu_rtc_driver, retu_rtc_probe);
 }
+module_init(retu_rtc_init);
 
 static void __exit retu_rtc_exit(void)
 {
 	platform_driver_unregister(&retu_rtc_driver);
 }
-
-module_init(retu_rtc_init);
 module_exit(retu_rtc_exit);
 
 MODULE_DESCRIPTION("Retu RTC");
-- 
1.7.4.rc2


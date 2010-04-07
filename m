From: felipe.balbi@nokia.com
Subject: [RFC PATCH 34/37] cbus: retu-rtc: switch to rtc class device
Date: Wed,  7 Apr 2010 19:04:25 +0300
Message-ID: <1270656268-7034-35-git-send-email-felipe.balbi@nokia.com>
References: <1270656268-7034-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:62426 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932908Ab0DGQGz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Apr 2010 12:06:55 -0400
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx09.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id o37G5Pt7007673
	for <linux-omap@vger.kernel.org>; Wed, 7 Apr 2010 11:06:54 -0500
In-Reply-To: <1270656268-7034-1-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux OMAP Mailing List <linux-omap@vger.kernel.org>
Cc: Felipe Balbi <felipe.balbi@nokia.com>

From: Felipe Balbi <felipe.balbi@nokia.com>

remove the old syfs interface and move to rtc class
device registration.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/cbus/Kconfig    |    2 +-
 drivers/cbus/retu-rtc.c |  382 ++++++++++++++++-------------------------------
 2 files changed, 130 insertions(+), 254 deletions(-)

diff --git a/drivers/cbus/Kconfig b/drivers/cbus/Kconfig
index c344a99..c6b39fb 100644
--- a/drivers/cbus/Kconfig
+++ b/drivers/cbus/Kconfig
@@ -65,7 +65,7 @@ config CBUS_RETU_POWERBUTTON
 	  If you want support for the Retu power button, you should say Y here.
 
 config CBUS_RETU_RTC
-	depends on CBUS_RETU && SYSFS
+	depends on CBUS_RETU && RTC_CLASS
 	tristate "Support for Retu pseudo-RTC"
 	---help---
 	  Say Y here if you want support for the device that alleges to be an
diff --git a/drivers/cbus/retu-rtc.c b/drivers/cbus/retu-rtc.c
index 1fe2b51..b0a0f3d 100644
--- a/drivers/cbus/retu-rtc.c
+++ b/drivers/cbus/retu-rtc.c
@@ -40,6 +40,7 @@
 #include <linux/completion.h>
 #include <linux/platform_device.h>
 #include <linux/mutex.h>
+#include <linux/rtc.h>
 #include <linux/workqueue.h>
 
 #include "cbus.h"
@@ -51,6 +52,7 @@ struct retu_rtc {
 	struct completion	sync;
 	struct work_struct	work;
 	struct device		*dev;
+	struct rtc_device	*rtc;
 
 	u16			alarm_expired;
 	u16			reset_occurred;
@@ -68,92 +70,6 @@ static void retu_rtc_barrier(struct retu_rtc *rtc)
 	retu_disable_irq(RETU_INT_RTCS);
 }
 
-static ssize_t retu_rtc_time_show(struct device *dev,
-		struct device_attribute *attr, char *buf)
-{
-	struct retu_rtc		*rtc = dev_get_drvdata(dev);
-	u16			dsr, hmr, dsr2;
-
-	mutex_lock(&rtc->mutex);
-
-	do {
-		u16 dummy;
-
-		/*
-		 * Not being in_interrupt() for a retu rtc IRQ, we need to
-		 * read twice for consistency..
-		 */
-		dummy	= retu_read_reg(RETU_REG_RTCDSR);
-		dsr	= retu_read_reg(RETU_REG_RTCDSR);
-
-		dummy	= retu_read_reg(RETU_REG_RTCHMR);
-		hmr	= retu_read_reg(RETU_REG_RTCHMR);
-
-		dummy	= retu_read_reg(RETU_REG_RTCDSR);
-		dsr2	= retu_read_reg(RETU_REG_RTCDSR);
-	} while ((dsr != dsr2));
-
-	mutex_unlock(&rtc->mutex);
-
-	/*
-	 * Format a 32-bit date-string for userspace
-	 *
-	 * days | hours | minutes | seconds
-	 *
-	 * 8 bits for each.
-	 *
-	 * This mostly sucks because days and seconds are tracked in RTCDSR
-	 * while hours and minutes are tracked in RTCHMR. And yes, there
-	 * really are no words that can describe an 8 bit day register (or
-	 * rather, none that will be reprinted here).
-	 */
-	return sprintf(buf, "0x%08x\n", (((dsr >> 8) & 0xff) << 24) |
-			(((hmr >> 8) & 0x1f) << 16) |
-			((hmr & 0x3f) << 8) | (dsr & 0x3f));
-}
-
-static ssize_t retu_rtc_time_store(struct device *dev,
-		struct device_attribute *attr, const char *buf, size_t count)
-{
-	struct retu_rtc		*rtc = dev_get_drvdata(dev);
-
-	mutex_lock(&rtc->mutex);
-	/*
-	 * Writing anything to the day counter forces it to 0
-	 * The seconds counter would be cleared by resetting the minutes
-	 * counter, however this won't happen, since we are using the
-	 * hh:mm counters as a set of free running counters and the
-	 * day counter as a multiple overflow holder.
-	 */
-
-	/* Reset day counter, but keep Temperature Shutdown state */
-	retu_write_reg(RETU_REG_RTCDSR,
-		       retu_read_reg(RETU_REG_RTCDSR) & (1 << 6));
-
-	mutex_unlock(&rtc->mutex);
-
-	return count;
-}
-static DEVICE_ATTR(time, S_IRUGO | S_IWUSR, retu_rtc_time_show,
-		   retu_rtc_time_store);
-
-static ssize_t retu_rtc_reset_show(struct device *dev,
-		struct device_attribute *attr, char *buf)
-{
-	struct retu_rtc		*rtc = dev_get_drvdata(dev);
-
-	/*
-	 * Returns the status of the rtc
-	 *
-	 * 0: no reset has occurred or the status has been cleared
-	 * 1: a reset has occurred
-	 *
-	 * RTC needs to be reset only when both main battery
-	 * _AND_ backup battery are discharged
-	 */
-	return sprintf(buf, "%u\n", rtc->reset_occurred);
-}
-
 static void retu_rtc_do_reset(struct retu_rtc *rtc)
 {
 	u16 ccr1;
@@ -174,167 +90,6 @@ static void retu_rtc_do_reset(struct retu_rtc *rtc)
 	rtc->reset_occurred = 1;
 }
 
-static ssize_t retu_rtc_reset_store(struct device *dev,
-		struct device_attribute *attr, const char *buf, size_t count)
-{
-	struct retu_rtc		*rtc = dev_get_drvdata(dev);
-	unsigned		choice;
-
-	if (sscanf(buf, "%u", &choice) != 1)
-		return count;
-	mutex_lock(&rtc->mutex);
-	if (choice == 0)
-		rtc->reset_occurred = 0;
-	else if (choice == 1)
-		retu_rtc_do_reset(rtc);
-	mutex_unlock(&rtc->mutex);
-	return count;
-}
-static DEVICE_ATTR(reset, S_IRUGO | S_IWUSR, retu_rtc_reset_show,
-		   retu_rtc_reset_store);
-
-static ssize_t retu_rtc_alarm_show(struct device *dev,
-		struct device_attribute *attr, char *buf)
-{
-	struct retu_rtc		*rtc = dev_get_drvdata(dev);
-	ssize_t			retval;
-	u16			chmar;
-
-	mutex_lock(&rtc->mutex);
-	/*
-	 * Format a 16-bit date-string for userspace
-	 *
-	 * hours | minutes
-	 * 8 bits for each.
-	 */
-	chmar = retu_read_reg(RETU_REG_RTCHMAR);
-	/* No shifting needed, only masking unrelated bits */
-	retval = sprintf(buf, "0x%04x\n", chmar & 0x1f3f);
-	mutex_unlock(&rtc->mutex);
-
-	return retval;
-}
-
-static ssize_t retu_rtc_alarm_store(struct device *dev,
-		struct device_attribute *attr, const char *buf, size_t count)
-{
-	struct retu_rtc		*rtc = dev_get_drvdata(dev);
-
-	unsigned		minutes;
-	unsigned		hours;
-	unsigned		alrm;
-
-	u16			chmar;
-
-	mutex_lock(&rtc->mutex);
-
-	if (sscanf(buf, "%x", &alrm) != 1)
-		return count;
-	hours = (alrm >> 8) & 0x001f;
-	minutes = (alrm >> 0) & 0x003f;
-	if ((hours < 24 && minutes < 60) || (hours == 24 && minutes == 60)) {
-		/*
-		 * OK, the time format for the alarm is valid (including the
-		 * disabling values)
-		 */
-		/* Keeps the RTC watchdog status */
-		chmar = retu_read_reg(RETU_REG_RTCHMAR) & 0x6000;
-		chmar |= alrm & 0x1f3f;	/* Stores the requested alarm */
-		retu_rtc_barrier(rtc);
-		retu_write_reg(RETU_REG_RTCHMAR, chmar);
-		/* If the alarm is being disabled */
-		if (hours == 24 && minutes == 60) {
-			/* disable the interrupt */
-			retu_disable_irq(RETU_INT_RTCA);
-			rtc->alarm_expired = 0;
-		} else
-			/* enable the interrupt */
-			retu_enable_irq(RETU_INT_RTCA);
-	}
-	mutex_unlock(&rtc->mutex);
-
-	return count;
-}
-static DEVICE_ATTR(alarm, S_IRUGO | S_IWUSR, retu_rtc_alarm_show,
-		   retu_rtc_alarm_store);
-
-static ssize_t retu_rtc_alarm_expired_show(struct device *dev,
-		struct device_attribute *attr, char *buf)
-{
-	struct retu_rtc		*rtc = dev_get_drvdata(dev);
-	ssize_t			retval;
-
-	retval = sprintf(buf, "%u\n", rtc->alarm_expired);
-
-	return retval;
-}
-
-static ssize_t retu_rtc_alarm_expired_store(struct device *dev,
-		struct device_attribute *attr, const char *buf, size_t count)
-{
-	struct retu_rtc		*rtc = dev_get_drvdata(dev);
-
-	rtc->alarm_expired = 0;
-
-	return count;
-}
-static DEVICE_ATTR(alarm_expired, S_IRUGO | S_IWUSR,
-		retu_rtc_alarm_expired_show, retu_rtc_alarm_expired_store);
-
-
-static ssize_t retu_rtc_cal_show(struct device *dev,
-		struct device_attribute *attr, char *buf)
-{
-	struct retu_rtc		*rtc = dev_get_drvdata(dev);
-	u16			rtccalr1;
-
-	mutex_lock(&rtc->mutex);
-	rtccalr1 = retu_read_reg(RETU_REG_RTCCALR);
-	mutex_unlock(&rtc->mutex);
-
-	/*
-	 * Shows the status of the Calibration Register.
-	 *
-	 * Default, after power loss: 0x0000
-	 * Default, for R&D: 0x00C0
-	 * Default, for factory: 0x00??
-	 *
-	 */
-	return sprintf(buf, "0x%04x\n", rtccalr1 & 0x00ff);
-}
-
-static ssize_t retu_rtc_cal_store(struct device *dev,
-		struct device_attribute *attr, const char *buf, size_t count)
-{
-	struct retu_rtc		*rtc = dev_get_drvdata(dev);
-	unsigned		calibration_value;
-
-	if (sscanf(buf, "%x", &calibration_value) != 1)
-		return count;
-
-	mutex_lock(&rtc->mutex);
-	retu_rtc_barrier(rtc);
-	retu_write_reg(RETU_REG_RTCCALR, calibration_value & 0x00ff);
-	mutex_unlock(&rtc->mutex);
-
-	return count;
-}
-static DEVICE_ATTR(cal, S_IRUGO | S_IWUSR, retu_rtc_cal_show,
-		   retu_rtc_cal_store);
-
-static struct attribute *retu_rtc_attrs[] = {
-	&dev_attr_cal.attr,
-	&dev_attr_alarm_expired.attr,
-	&dev_attr_alarm.attr,
-	&dev_attr_reset.attr,
-	&dev_attr_time.attr,
-	NULL,
-};
-
-static const struct attribute_group retu_rtc_group = {
-	.attrs = retu_rtc_attrs,
-};
-
 static void retu_rtca_disable(struct retu_rtc *rtc)
 {
 	retu_disable_irq(RETU_INT_RTCA);
@@ -348,8 +103,6 @@ static void retu_rtca_expired(struct work_struct *work)
 	struct retu_rtc		*rtc = work_to_rtc(work);
 
 	retu_rtca_disable(rtc);
-
-	sysfs_notify(&rtc->dev->kobj, NULL, "alarm_expired");
 }
 
 /*
@@ -397,6 +150,127 @@ static int retu_rtc_init_irq(struct retu_rtc *rtc)
 	return 0;
 }
 
+static int retu_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alm)
+{
+	struct retu_rtc		*rtc = dev_get_drvdata(dev);
+	u16			chmar;
+
+	mutex_lock(&rtc->mutex);
+
+	chmar = ((alm->time.tm_hour & 0x1f) << 8) | (alm->time.tm_min & 0x3f);
+	retu_write_reg(RETU_REG_RTCHMAR, chmar);
+
+	mutex_unlock(&rtc->mutex);
+
+	return 0;
+}
+
+static int retu_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alm)
+{
+	struct retu_rtc		*rtc = dev_get_drvdata(dev);
+	u16			chmar;
+
+	mutex_lock(&rtc->mutex);
+
+	chmar = retu_read_reg(RETU_REG_RTCHMAR);
+
+	alm->time.tm_hour	= (chmar >> 8) & 0x1f;
+	alm->time.tm_min	= chmar & 0x3f;
+	alm->enabled		= !!rtc->alarm_expired;
+
+	mutex_unlock(&rtc->mutex);
+
+	return 0;
+}
+
+static int retu_rtc_set_time(struct device *dev, struct rtc_time *tm)
+{
+	struct retu_rtc		*rtc = dev_get_drvdata(dev);
+	u16			dsr;
+	u16			hmr;
+
+	dsr = ((tm->tm_mday & 0xff) << 8) | (tm->tm_hour & 0xff);
+	hmr = ((tm->tm_min & 0xff) << 8) | (tm->tm_sec & 0xff);
+
+	mutex_lock(&rtc->mutex);
+
+	retu_write_reg(RETU_REG_RTCDSR, dsr);
+	retu_write_reg(RETU_REG_RTCHMR, hmr);
+
+	mutex_unlock(&rtc->mutex);
+
+	return 0;
+}
+
+static int retu_rtc_read_time(struct device *dev, struct rtc_time *tm)
+{
+	struct retu_rtc		*rtc = dev_get_drvdata(dev);
+	u16			dsr;
+	u16			hmr;
+
+	/*
+	 * DSR holds days and hours
+	 * HMR hols minutes and seconds
+	 *
+	 * both are 16 bit registers with 8-bit for each field.
+	 */
+
+	mutex_lock(&rtc->mutex);
+
+	dsr	= retu_read_reg(RETU_REG_RTCDSR);
+	hmr	= retu_read_reg(RETU_REG_RTCHMR);
+
+	tm->tm_sec	= hmr & 0xff;
+	tm->tm_min	= hmr >> 8;
+	tm->tm_hour	= dsr & 0xff;
+	tm->tm_mday	= dsr >> 8;
+
+	mutex_unlock(&rtc->mutex);
+
+	return 0;
+}
+
+#ifdef CONFIG_RTC_INTF_DEV
+
+static int retu_rtc_ioctl(struct device *dev, unsigned int cmd,
+		unsigned long arg)
+{
+	struct retu_rtc		*rtc = dev_get_drvdata(dev);
+
+	mutex_lock(&rtc->mutex);
+
+	switch (cmd) {
+	case RTC_AIE_OFF:
+		retu_disable_irq(RETU_INT_RTCA);
+		break;
+	case RTC_AIE_ON:
+		retu_enable_irq(RETU_INT_RTCA);
+		break;
+	case RTC_UIE_OFF:
+		retu_disable_irq(RETU_INT_RTCS);
+		break;
+	case RTC_UIE_ON:
+		retu_enable_irq(RETU_INT_RTCS);
+		break;
+	default:
+		return -ENOIOCTLCMD;
+	}
+
+	mutex_unlock(&rtc->mutex);
+
+	return 0;
+}
+#else
+#define retu_rtc_ioctl	NULL
+#endif
+
+static struct rtc_class_ops retu_rtc_ops = {
+	.ioctl			= retu_rtc_ioctl,
+	.read_time		= retu_rtc_read_time,
+	.set_time		= retu_rtc_set_time,
+	.read_alarm		= retu_rtc_read_alarm,
+	.set_alarm		= retu_rtc_set_alarm,
+};
 
 static int __devinit retu_rtc_probe(struct platform_device *pdev)
 {
@@ -437,9 +311,11 @@ static int __devinit retu_rtc_probe(struct platform_device *pdev)
 	else
 		retu_rtc_do_reset(rtc);
 
-	r = sysfs_create_group(&pdev->dev.kobj, &retu_rtc_group);
-	if (r) {
-		dev_err(&pdev->dev, "couldn't create sysfs interface\n");
+
+	rtc->rtc = rtc_device_register(pdev->name, &pdev->dev, &
+			retu_rtc_ops, THIS_MODULE);
+	if (IS_ERR(rtc->rtc)) {
+		dev_err(&pdev->dev, "can't register RTC device\n");
 		goto err2;
 	}
 
@@ -466,7 +342,7 @@ static int __devexit retu_rtc_remove(struct platform_device *pdev)
 	retu_disable_irq(RETU_INT_RTCA);
 	retu_free_irq(RETU_INT_RTCS);
 	retu_free_irq(RETU_INT_RTCA);
-	sysfs_remove_group(&pdev->dev.kobj, &retu_rtc_group);
+	rtc_device_unregister(rtc->rtc);
 	kfree(rtc);
 
 	return 0;
-- 
1.7.0.rc0.33.g7c3932


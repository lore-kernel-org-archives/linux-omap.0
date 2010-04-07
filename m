From: felipe.balbi@nokia.com
Subject: [RFC PATCH 31/37] cbus: retu-rtc: get rid of globals
Date: Wed,  7 Apr 2010 19:04:22 +0300
Message-ID: <1270656268-7034-32-git-send-email-felipe.balbi@nokia.com>
References: <1270656268-7034-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:62337 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932860Ab0DGQFX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Apr 2010 12:05:23 -0400
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx09.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id o37G5KjW007656
	for <linux-omap@vger.kernel.org>; Wed, 7 Apr 2010 11:05:22 -0500
In-Reply-To: <1270656268-7034-1-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux OMAP Mailing List <linux-omap@vger.kernel.org>
Cc: Felipe Balbi <felipe.balbi@nokia.com>

From: Felipe Balbi <felipe.balbi@nokia.com>

allocate everything we need on demand and get rid
of global variables.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/cbus/retu-rtc.c |  251 ++++++++++++++++++++++++++++-------------------
 1 files changed, 150 insertions(+), 101 deletions(-)

diff --git a/drivers/cbus/retu-rtc.c b/drivers/cbus/retu-rtc.c
index 2a1623b..b99c227 100644
--- a/drivers/cbus/retu-rtc.c
+++ b/drivers/cbus/retu-rtc.c
@@ -45,20 +45,27 @@
 #include "cbus.h"
 #include "retu.h"
 
-static struct mutex retu_rtc_mutex;
-static u16 retu_rtc_alarm_expired;
-static u16 retu_rtc_reset_occurred;
+struct retu_rtc {
+	struct mutex		mutex;
+	struct completion	sync;
+	struct work_struct	work;
+	struct device		*dev;
+
+	u16			alarm_expired;
+	u16			reset_occurred;
+};
 
-static DECLARE_COMPLETION(retu_rtc_sync);
+#define work_to_rtc(r)	(container_of(r, struct retu_rtc, work))
 
-static void retu_rtc_barrier(void);
+static void retu_rtc_barrier(struct retu_rtc *rtc);
 
 static ssize_t retu_rtc_time_show(struct device *dev, struct device_attribute *attr,
 				  char *buf)
 {
-	u16 dsr, hmr, dsr2;
+	struct retu_rtc		*rtc = dev_get_drvdata(dev);
+	u16			dsr, hmr, dsr2;
 
-	mutex_lock(&retu_rtc_mutex);
+	mutex_lock(&rtc->mutex);
 
 	do {
 		u16 dummy;
@@ -77,7 +84,7 @@ static ssize_t retu_rtc_time_show(struct device *dev, struct device_attribute *a
 		dsr2	= retu_read_reg(RETU_REG_RTCDSR);
 	} while ((dsr != dsr2));
 
-	mutex_unlock(&retu_rtc_mutex);
+	mutex_unlock(&rtc->mutex);
 
 	/*
 	 * Format a 32-bit date-string for userspace
@@ -99,7 +106,9 @@ static ssize_t retu_rtc_time_show(struct device *dev, struct device_attribute *a
 static ssize_t retu_rtc_time_store(struct device *dev, struct device_attribute *attr,
 				   const char *buf, size_t count)
 {
-	mutex_lock(&retu_rtc_mutex);
+	struct retu_rtc		*rtc = dev_get_drvdata(dev);
+
+	mutex_lock(&rtc->mutex);
 	/*
 	 * Writing anything to the day counter forces it to 0
 	 * The seconds counter would be cleared by resetting the minutes counter,
@@ -112,7 +121,7 @@ static ssize_t retu_rtc_time_store(struct device *dev, struct device_attribute *
 	retu_write_reg(RETU_REG_RTCDSR,
 		       retu_read_reg(RETU_REG_RTCDSR) & (1 << 6));
 
-	mutex_unlock(&retu_rtc_mutex);
+	mutex_unlock(&rtc->mutex);
 
 	return count;
 }
@@ -123,6 +132,8 @@ static DEVICE_ATTR(time, S_IRUGO | S_IWUSR, retu_rtc_time_show,
 
 static ssize_t retu_rtc_reset_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
+	struct retu_rtc		*rtc = dev_get_drvdata(dev);
+
 	/*
 	 * Returns the status of the rtc
 	 *
@@ -132,10 +143,10 @@ static ssize_t retu_rtc_reset_show(struct device *dev, struct device_attribute *
 	 * RTC needs to be reset only when both main battery
 	 * _AND_ backup battery are discharged
 	 */
-	return sprintf(buf, "%u\n", retu_rtc_reset_occurred);
+	return sprintf(buf, "%u\n", rtc->reset_occurred);
 }
 
-static void retu_rtc_do_reset(void)
+static void retu_rtc_do_reset(struct retu_rtc *rtc)
 {
 	u16 ccr1;
 
@@ -145,29 +156,30 @@ static void retu_rtc_do_reset(void)
 	/* RTC in normal operating mode */
 	retu_write_reg(RETU_REG_CC1, ccr1 & ~0x0001);
 
-	retu_rtc_barrier();
+	retu_rtc_barrier(rtc);
 	/* Disable alarm and RTC WD */
 	retu_write_reg(RETU_REG_RTCHMAR, 0x7f3f);
 	/* Set Calibration register to default value */
 	retu_write_reg(RETU_REG_RTCCALR, 0x00c0);
 
-	retu_rtc_alarm_expired = 0;
-	retu_rtc_reset_occurred = 1;
+	rtc->alarm_expired = 0;
+	rtc->reset_occurred = 1;
 }
 
 static ssize_t retu_rtc_reset_store(struct device *dev, struct device_attribute *attr,
 				    const char *buf, size_t count)
 {
-	unsigned choice;
+	struct retu_rtc		*rtc = dev_get_drvdata(dev);
+	unsigned		choice;
 
 	if(sscanf(buf, "%u", &choice) != 1)
 		return count;
-	mutex_lock(&retu_rtc_mutex);
+	mutex_lock(&rtc->mutex);
 	if (choice == 0)
-		retu_rtc_reset_occurred = 0;
+		rtc->reset_occurred = 0;
 	else if (choice == 1)
-		retu_rtc_do_reset();
-	mutex_unlock(&retu_rtc_mutex);
+		retu_rtc_do_reset(rtc);
+	mutex_unlock(&rtc->mutex);
 	return count;
 }
 
@@ -177,10 +189,11 @@ static DEVICE_ATTR(reset, S_IRUGO | S_IWUSR, retu_rtc_reset_show,
 static ssize_t retu_rtc_alarm_show(struct device *dev, struct device_attribute *attr,
 				   char *buf)
 {
-	u16 chmar;
-	ssize_t retval;
+	struct retu_rtc		*rtc = dev_get_drvdata(dev);
+	ssize_t			retval;
+	u16			chmar;
 
-	mutex_lock(&retu_rtc_mutex);
+	mutex_lock(&rtc->mutex);
 	/*
 	 * Format a 16-bit date-string for userspace
 	 *
@@ -190,7 +203,7 @@ static ssize_t retu_rtc_alarm_show(struct device *dev, struct device_attribute *
 	chmar = retu_read_reg(RETU_REG_RTCHMAR);
 	/* No shifting needed, only masking unrelated bits */
 	retval = sprintf(buf, "0x%04x\n", chmar & 0x1f3f);
-	mutex_unlock(&retu_rtc_mutex);
+	mutex_unlock(&rtc->mutex);
 
 	return retval;
 }
@@ -198,12 +211,15 @@ static ssize_t retu_rtc_alarm_show(struct device *dev, struct device_attribute *
 static ssize_t retu_rtc_alarm_store(struct device *dev, struct device_attribute *attr,
 				    const char *buf, size_t count)
 {
-	u16 chmar;
-	unsigned alrm;
-	unsigned hours;
-	unsigned minutes;
+	struct retu_rtc		*rtc = dev_get_drvdata(dev);
+
+	unsigned		minutes;
+	unsigned		hours;
+	unsigned		alrm;
 
-	mutex_lock(&retu_rtc_mutex);
+	u16			chmar;
+
+	mutex_lock(&rtc->mutex);
 
 	if(sscanf(buf, "%x", &alrm) != 1)
 		return count;
@@ -217,18 +233,18 @@ static ssize_t retu_rtc_alarm_store(struct device *dev, struct device_attribute
 		/* Keeps the RTC watchdog status */
 		chmar = retu_read_reg(RETU_REG_RTCHMAR) & 0x6000;
 		chmar |= alrm & 0x1f3f;	/* Stores the requested alarm */
-		retu_rtc_barrier();
+		retu_rtc_barrier(rtc);
 		retu_write_reg(RETU_REG_RTCHMAR, chmar);
 		/* If the alarm is being disabled */
 		if (hours == 24 && minutes == 60) {
 			/* disable the interrupt */
 			retu_disable_irq(RETU_INT_RTCA);
-			retu_rtc_alarm_expired = 0;
+			rtc->alarm_expired = 0;
 		} else
 			/* enable the interrupt */
 			retu_enable_irq(RETU_INT_RTCA);
 	}
-	mutex_unlock(&retu_rtc_mutex);
+	mutex_unlock(&rtc->mutex);
 
 	return count;
 }
@@ -239,9 +255,10 @@ static DEVICE_ATTR(alarm, S_IRUGO | S_IWUSR, retu_rtc_alarm_show,
 static ssize_t retu_rtc_alarm_expired_show(struct device *dev, struct device_attribute *attr,
 					   char *buf)
 {
-	ssize_t retval;
+	struct retu_rtc		*rtc = dev_get_drvdata(dev);
+	ssize_t			retval;
 
-	retval = sprintf(buf, "%u\n", retu_rtc_alarm_expired);
+	retval = sprintf(buf, "%u\n", rtc->alarm_expired);
 
 	return retval;
 }
@@ -249,7 +266,9 @@ static ssize_t retu_rtc_alarm_expired_show(struct device *dev, struct device_att
 static ssize_t retu_rtc_alarm_expired_store(struct device *dev, struct device_attribute *attr,
 					    const char *buf, size_t count)
 {
-	retu_rtc_alarm_expired = 0;
+	struct retu_rtc		*rtc = dev_get_drvdata(dev);
+
+	rtc->alarm_expired = 0;
 
 	return count;
 }
@@ -261,11 +280,12 @@ static DEVICE_ATTR(alarm_expired, S_IRUGO | S_IWUSR, retu_rtc_alarm_expired_show
 static ssize_t retu_rtc_cal_show(struct device *dev, struct device_attribute *attr,
 				 char *buf)
 {
-	u16 rtccalr1;
+	struct retu_rtc		*rtc = dev_get_drvdata(dev);
+	u16			rtccalr1;
 
-	mutex_lock(&retu_rtc_mutex);
+	mutex_lock(&rtc->mutex);
 	rtccalr1 = retu_read_reg(RETU_REG_RTCCALR);
-	mutex_unlock(&retu_rtc_mutex);
+	mutex_unlock(&rtc->mutex);
 
 	/*
 	 * Shows the status of the Calibration Register.
@@ -281,15 +301,16 @@ static ssize_t retu_rtc_cal_show(struct device *dev, struct device_attribute *at
 static ssize_t retu_rtc_cal_store(struct device *dev, struct device_attribute *attr,
 				  const char *buf, size_t count)
 {
-	unsigned calibration_value;
+	struct retu_rtc		*rtc = dev_get_drvdata(dev);
+	unsigned		calibration_value;
 
 	if (sscanf(buf, "%x", &calibration_value) != 1)
 		return count;
 
-	mutex_lock(&retu_rtc_mutex);
-	retu_rtc_barrier();
+	mutex_lock(&rtc->mutex);
+	retu_rtc_barrier(rtc);
 	retu_write_reg(RETU_REG_RTCCALR, calibration_value & 0x00ff);
-	mutex_unlock(&retu_rtc_mutex);
+	mutex_unlock(&rtc->mutex);
 
 	return count;
 }
@@ -297,45 +318,62 @@ static ssize_t retu_rtc_cal_store(struct device *dev, struct device_attribute *a
 static DEVICE_ATTR(cal, S_IRUGO | S_IWUSR, retu_rtc_cal_show,
 		   retu_rtc_cal_store);
 
-static struct platform_device retu_rtc_device;
+static struct attribute *retu_rtc_attrs[] = {
+	&dev_attr_cal.attr,
+	&dev_attr_alarm_expired.attr,
+	&dev_attr_alarm.attr,
+	&dev_attr_reset.attr,
+	&dev_attr_time.attr,
+	NULL,
+};
+
+static const struct attribute_group retu_rtc_group = {
+	.attrs = retu_rtc_attrs,
+};
 
-static void retu_rtca_disable(void)
+static void retu_rtca_disable(struct retu_rtc *rtc)
 {
 	retu_disable_irq(RETU_INT_RTCA);
-	retu_rtc_alarm_expired = 1;
-	retu_rtc_barrier();
+	rtc->alarm_expired = 1;
+	retu_rtc_barrier(rtc);
 	retu_write_reg(RETU_REG_RTCHMAR, (24 << 8) | 60);
 }
 
-static void retu_rtca_expired(struct work_struct *unused)
+static void retu_rtca_expired(struct work_struct *work)
 {
-	retu_rtca_disable();
-	sysfs_notify(&retu_rtc_device.dev.kobj, NULL, "alarm_expired");
-}
+	struct retu_rtc		*rtc = work_to_rtc(work);
 
-DECLARE_WORK(retu_rtca_work, retu_rtca_expired);
+	retu_rtca_disable(rtc);
+
+	sysfs_notify(&rtc->dev->kobj, NULL, "alarm_expired");
+}
 
 /*
  * RTCHMR RTCHMAR RTCCAL must be accessed within 0.9 s since the seconds
  * interrupt has been signaled in the IDR register
  */
-static void retu_rtcs_interrupt(unsigned long unused)
+static void retu_rtcs_interrupt(unsigned long _rtc)
 {
+	struct retu_rtc		*rtc = (struct retu_rtc *) _rtc;
+
 	retu_ack_irq(RETU_INT_RTCS);
-	complete_all(&retu_rtc_sync);
+	complete_all(&rtc->sync);
 }
 
-static void retu_rtca_interrupt(unsigned long unused)
+static void retu_rtca_interrupt(unsigned long _rtc)
 {
+	struct retu_rtc		*rtc = (struct retu_rtc *) _rtc;
+
 	retu_ack_irq(RETU_INT_RTCA);
-	schedule_work(&retu_rtca_work);
+	schedule_work(&rtc->work);
 }
 
-static int retu_rtc_init_irq(void)
+static int retu_rtc_init_irq(struct retu_rtc *rtc)
 {
 	int ret;
 
-	ret = retu_request_irq(RETU_INT_RTCS, retu_rtcs_interrupt, 0, "RTCS");
+	ret = retu_request_irq(RETU_INT_RTCS, retu_rtcs_interrupt,
+			(unsigned long) rtc, "RTCS");
 	if (ret != 0)
 		return ret;
 	/*
@@ -344,7 +382,8 @@ static int retu_rtc_init_irq(void)
 	 */
 	retu_disable_irq(RETU_INT_RTCS);
 
-	ret = retu_request_irq(RETU_INT_RTCA, retu_rtca_interrupt, 0, "RTCA");
+	ret = retu_request_irq(RETU_INT_RTCA, retu_rtca_interrupt,
+			(unsigned long) rtc, "RTCA");
 	if (ret != 0) {
 		retu_free_irq(RETU_INT_RTCS);
 		return ret;
@@ -357,64 +396,74 @@ static int retu_rtc_init_irq(void)
 
 static int __devinit retu_rtc_probe(struct platform_device *pdev)
 {
-	struct device		*dev = &pdev->dev;
-	int r;
+	struct retu_rtc		*rtc;
+	int			r;
+
+	rtc = kzalloc(sizeof(*rtc), GFP_KERNEL);
+	if (!rtc) {
+		dev_err(&pdev->dev, "not enough memory\n");
+		r = -ENOMEM;
+		goto err0;
+	}
 
-	r = retu_get_status();
-	if (!r)
-		return -ENODEV;
+	rtc->dev = &pdev->dev;
+	platform_set_drvdata(pdev, rtc);
+	INIT_WORK(&rtc->work, retu_rtca_expired);
+	mutex_init(&rtc->mutex);
 
-	retu_rtc_alarm_expired = retu_read_reg(RETU_REG_IDR) &
-					       (0x1 << RETU_INT_RTCA);
+	r = retu_get_status();
+	if (!r) {
+		dev_err(&pdev->dev, "retu not initialized\n");
+		goto err1;
+	}
 
-	if ((r = retu_rtc_init_irq()) != 0)
-		return r;
+	rtc->alarm_expired = retu_read_reg(RETU_REG_IDR) &
+		(0x1 << RETU_INT_RTCA);
 
-	mutex_init(&retu_rtc_mutex);
+	r = retu_rtc_init_irq(rtc);
+	if (r < 0) {
+		dev_err(&pdev->dev, "failed to request retu irq\n");
+		goto err1;
+	}
 
 	/* If the calibration register is zero, we've probably lost
 	 * power */
 	if (retu_read_reg(RETU_REG_RTCCALR) & 0x00ff)
-		retu_rtc_reset_occurred = 0;
-	else
-		retu_rtc_do_reset();
-
-	if ((r = device_create_file(dev, &dev_attr_time)) != 0)
-		return r;
-	else if ((r = device_create_file(dev, &dev_attr_reset)) != 0)
-		goto err_unregister_time;
-	else if ((r = device_create_file(dev, &dev_attr_alarm)) != 0)
-		goto err_unregister_reset;
-	else if ((r = device_create_file(dev, &dev_attr_alarm_expired)) != 0)
-		goto err_unregister_alarm;
-	else if ((r = device_create_file(dev, &dev_attr_cal)) != 0)
-		goto err_unregister_alarm_expired;
+		rtc->reset_occurred = 0;
 	else
-		return r;
-
-err_unregister_alarm_expired:
-	device_remove_file(dev, &dev_attr_alarm_expired);
-err_unregister_alarm:
-	device_remove_file(dev, &dev_attr_alarm);
-err_unregister_reset:
-	device_remove_file(dev, &dev_attr_reset);
-err_unregister_time:
-	device_remove_file(dev, &dev_attr_time);
+		retu_rtc_do_reset(rtc);
+
+	r = sysfs_create_group(&pdev->dev.kobj, &retu_rtc_group);
+	if (r) {
+		dev_err(&pdev->dev, "couldn't create sysfs interface\n");
+		goto err2;
+	}
+
+	return 0;
+
+err2:
+	retu_disable_irq(RETU_INT_RTCS);
+	retu_disable_irq(RETU_INT_RTCA);
+	retu_free_irq(RETU_INT_RTCS);
+	retu_free_irq(RETU_INT_RTCA);
+
+err1:
+	kfree(rtc);
+
+err0:
 	return r;
 }
 
 static int __devexit retu_rtc_remove(struct platform_device *pdev)
 {
-	struct device		*dev = &pdev->dev;
+	struct retu_rtc		*rtc = platform_get_drvdata(pdev);
 
 	retu_disable_irq(RETU_INT_RTCS);
+	retu_disable_irq(RETU_INT_RTCA);
 	retu_free_irq(RETU_INT_RTCS);
 	retu_free_irq(RETU_INT_RTCA);
-	device_remove_file(dev, &dev_attr_cal);
-	device_remove_file(dev, &dev_attr_alarm_expired);
-	device_remove_file(dev, &dev_attr_alarm);
-	device_remove_file(dev, &dev_attr_reset);
-	device_remove_file(dev, &dev_attr_time);
+	sysfs_remove_group(&pdev->dev.kobj, &retu_rtc_group);
+	kfree(rtc);
 
 	return 0;
 }
@@ -428,12 +477,12 @@ static struct platform_driver retu_rtc_driver = {
 };
 
 /* This function provides syncronization with the RTCS interrupt handler */
-static void retu_rtc_barrier(void)
+static void retu_rtc_barrier(struct retu_rtc *rtc)
 {
-	INIT_COMPLETION(retu_rtc_sync);
+	INIT_COMPLETION(rtc->sync);
 	retu_ack_irq(RETU_INT_RTCS);
 	retu_enable_irq(RETU_INT_RTCS);
-	wait_for_completion(&retu_rtc_sync);
+	wait_for_completion(&rtc->sync);
 	retu_disable_irq(RETU_INT_RTCS);
 }
 
-- 
1.7.0.rc0.33.g7c3932


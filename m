From: felipe.balbi@nokia.com
Subject: [RFC PATCH 33/37] cbus: retu-rtc: make checkpatch.pl happy
Date: Wed,  7 Apr 2010 19:04:24 +0300
Message-ID: <1270656268-7034-34-git-send-email-felipe.balbi@nokia.com>
References: <1270656268-7034-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:58638 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932905Ab0DGQGW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Apr 2010 12:06:22 -0400
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx03.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id o37G5wgV005211
	for <linux-omap@vger.kernel.org>; Wed, 7 Apr 2010 19:06:19 +0300
In-Reply-To: <1270656268-7034-1-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux OMAP Mailing List <linux-omap@vger.kernel.org>
Cc: Felipe Balbi <felipe.balbi@nokia.com>

From: Felipe Balbi <felipe.balbi@nokia.com>

trivial changes to make checkpatch.pl happy.
No functional changes.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/cbus/retu-rtc.c |   67 ++++++++++++++++++++++------------------------
 1 files changed, 32 insertions(+), 35 deletions(-)

diff --git a/drivers/cbus/retu-rtc.c b/drivers/cbus/retu-rtc.c
index 90d199e..1fe2b51 100644
--- a/drivers/cbus/retu-rtc.c
+++ b/drivers/cbus/retu-rtc.c
@@ -46,6 +46,7 @@
 #include "retu.h"
 
 struct retu_rtc {
+	/* device lock */
 	struct mutex		mutex;
 	struct completion	sync;
 	struct work_struct	work;
@@ -67,8 +68,8 @@ static void retu_rtc_barrier(struct retu_rtc *rtc)
 	retu_disable_irq(RETU_INT_RTCS);
 }
 
-static ssize_t retu_rtc_time_show(struct device *dev, struct device_attribute *attr,
-				  char *buf)
+static ssize_t retu_rtc_time_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
 {
 	struct retu_rtc		*rtc = dev_get_drvdata(dev);
 	u16			dsr, hmr, dsr2;
@@ -107,22 +108,22 @@ static ssize_t retu_rtc_time_show(struct device *dev, struct device_attribute *a
 	 * rather, none that will be reprinted here).
 	 */
 	return sprintf(buf, "0x%08x\n", (((dsr >> 8) & 0xff) << 24) |
-				        (((hmr >> 8) & 0x1f) << 16) |
-					 ((hmr & 0x3f) << 8) | (dsr & 0x3f));
+			(((hmr >> 8) & 0x1f) << 16) |
+			((hmr & 0x3f) << 8) | (dsr & 0x3f));
 }
 
-static ssize_t retu_rtc_time_store(struct device *dev, struct device_attribute *attr,
-				   const char *buf, size_t count)
+static ssize_t retu_rtc_time_store(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct retu_rtc		*rtc = dev_get_drvdata(dev);
 
 	mutex_lock(&rtc->mutex);
 	/*
 	 * Writing anything to the day counter forces it to 0
-	 * The seconds counter would be cleared by resetting the minutes counter,
-	 * however this won't happen, since we are using the hh:mm counters as
-	 * a set of free running counters and the day counter as a multiple
-	 * overflow holder.
+	 * The seconds counter would be cleared by resetting the minutes
+	 * counter, however this won't happen, since we are using the
+	 * hh:mm counters as a set of free running counters and the
+	 * day counter as a multiple overflow holder.
 	 */
 
 	/* Reset day counter, but keep Temperature Shutdown state */
@@ -133,12 +134,11 @@ static ssize_t retu_rtc_time_store(struct device *dev, struct device_attribute *
 
 	return count;
 }
-
 static DEVICE_ATTR(time, S_IRUGO | S_IWUSR, retu_rtc_time_show,
 		   retu_rtc_time_store);
 
-
-static ssize_t retu_rtc_reset_show(struct device *dev, struct device_attribute *attr, char *buf)
+static ssize_t retu_rtc_reset_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
 {
 	struct retu_rtc		*rtc = dev_get_drvdata(dev);
 
@@ -174,13 +174,13 @@ static void retu_rtc_do_reset(struct retu_rtc *rtc)
 	rtc->reset_occurred = 1;
 }
 
-static ssize_t retu_rtc_reset_store(struct device *dev, struct device_attribute *attr,
-				    const char *buf, size_t count)
+static ssize_t retu_rtc_reset_store(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct retu_rtc		*rtc = dev_get_drvdata(dev);
 	unsigned		choice;
 
-	if(sscanf(buf, "%u", &choice) != 1)
+	if (sscanf(buf, "%u", &choice) != 1)
 		return count;
 	mutex_lock(&rtc->mutex);
 	if (choice == 0)
@@ -190,12 +190,11 @@ static ssize_t retu_rtc_reset_store(struct device *dev, struct device_attribute
 	mutex_unlock(&rtc->mutex);
 	return count;
 }
-
 static DEVICE_ATTR(reset, S_IRUGO | S_IWUSR, retu_rtc_reset_show,
 		   retu_rtc_reset_store);
 
-static ssize_t retu_rtc_alarm_show(struct device *dev, struct device_attribute *attr,
-				   char *buf)
+static ssize_t retu_rtc_alarm_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
 {
 	struct retu_rtc		*rtc = dev_get_drvdata(dev);
 	ssize_t			retval;
@@ -216,8 +215,8 @@ static ssize_t retu_rtc_alarm_show(struct device *dev, struct device_attribute *
 	return retval;
 }
 
-static ssize_t retu_rtc_alarm_store(struct device *dev, struct device_attribute *attr,
-				    const char *buf, size_t count)
+static ssize_t retu_rtc_alarm_store(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct retu_rtc		*rtc = dev_get_drvdata(dev);
 
@@ -229,7 +228,7 @@ static ssize_t retu_rtc_alarm_store(struct device *dev, struct device_attribute
 
 	mutex_lock(&rtc->mutex);
 
-	if(sscanf(buf, "%x", &alrm) != 1)
+	if (sscanf(buf, "%x", &alrm) != 1)
 		return count;
 	hours = (alrm >> 8) & 0x001f;
 	minutes = (alrm >> 0) & 0x003f;
@@ -256,12 +255,11 @@ static ssize_t retu_rtc_alarm_store(struct device *dev, struct device_attribute
 
 	return count;
 }
-
 static DEVICE_ATTR(alarm, S_IRUGO | S_IWUSR, retu_rtc_alarm_show,
 		   retu_rtc_alarm_store);
 
-static ssize_t retu_rtc_alarm_expired_show(struct device *dev, struct device_attribute *attr,
-					   char *buf)
+static ssize_t retu_rtc_alarm_expired_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
 {
 	struct retu_rtc		*rtc = dev_get_drvdata(dev);
 	ssize_t			retval;
@@ -271,8 +269,8 @@ static ssize_t retu_rtc_alarm_expired_show(struct device *dev, struct device_att
 	return retval;
 }
 
-static ssize_t retu_rtc_alarm_expired_store(struct device *dev, struct device_attribute *attr,
-					    const char *buf, size_t count)
+static ssize_t retu_rtc_alarm_expired_store(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct retu_rtc		*rtc = dev_get_drvdata(dev);
 
@@ -280,13 +278,12 @@ static ssize_t retu_rtc_alarm_expired_store(struct device *dev, struct device_at
 
 	return count;
 }
-
-static DEVICE_ATTR(alarm_expired, S_IRUGO | S_IWUSR, retu_rtc_alarm_expired_show,
-		   retu_rtc_alarm_expired_store);
+static DEVICE_ATTR(alarm_expired, S_IRUGO | S_IWUSR,
+		retu_rtc_alarm_expired_show, retu_rtc_alarm_expired_store);
 
 
-static ssize_t retu_rtc_cal_show(struct device *dev, struct device_attribute *attr,
-				 char *buf)
+static ssize_t retu_rtc_cal_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
 {
 	struct retu_rtc		*rtc = dev_get_drvdata(dev);
 	u16			rtccalr1;
@@ -306,8 +303,8 @@ static ssize_t retu_rtc_cal_show(struct device *dev, struct device_attribute *at
 	return sprintf(buf, "0x%04x\n", rtccalr1 & 0x00ff);
 }
 
-static ssize_t retu_rtc_cal_store(struct device *dev, struct device_attribute *attr,
-				  const char *buf, size_t count)
+static ssize_t retu_rtc_cal_store(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct retu_rtc		*rtc = dev_get_drvdata(dev);
 	unsigned		calibration_value;
@@ -322,7 +319,6 @@ static ssize_t retu_rtc_cal_store(struct device *dev, struct device_attribute *a
 
 	return count;
 }
-
 static DEVICE_ATTR(cal, S_IRUGO | S_IWUSR, retu_rtc_cal_show,
 		   retu_rtc_cal_store);
 
@@ -501,4 +497,5 @@ MODULE_DESCRIPTION("Retu RTC");
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Paul Mundt");
 MODULE_AUTHOR("Igor Stoppa");
+MODULE_AUTHOR("Felipe Balbi <felipe.balbi@nokia.com>");
 
-- 
1.7.0.rc0.33.g7c3932


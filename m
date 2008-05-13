From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 2/3] CBUS: Checkpatch.pl fixes for retu-wdt.c
Date: Mon, 12 May 2008 17:35:17 -0700
Message-ID: <1210638918-26644-3-git-send-email-tony@atomide.com>
References: retu-2008-05-12-173514
 <1210638918-26644-1-git-send-email-tony@atomide.com>
 <1210638918-26644-2-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:62577 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754831AbYEMAfV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 May 2008 20:35:21 -0400
In-Reply-To: <1210638918-26644-2-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>

Checkpatch.pl fixes for retu-wdt.c

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/cbus/retu-wdt.c |   24 ++++++++++++++----------
 1 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/cbus/retu-wdt.c b/drivers/cbus/retu-wdt.c
index 85202ef..b7b20b7 100644
--- a/drivers/cbus/retu-wdt.c
+++ b/drivers/cbus/retu-wdt.c
@@ -42,7 +42,8 @@
 static struct completion retu_wdt_completion;
 static DEFINE_MUTEX(retu_wdt_mutex);
 
-static unsigned int period_val = RETU_WDT_DEFAULT_TIMER;	/* Current period of watchdog */
+/* Current period of watchdog */
+static unsigned int period_val = RETU_WDT_DEFAULT_TIMER;
 static int counter_param = RETU_WDT_MAX_TIMER;
 
 static int retu_modify_counter(unsigned int new)
@@ -61,15 +62,16 @@ static int retu_modify_counter(unsigned int new)
 	return ret;
 }
 
-static ssize_t retu_wdt_period_show(struct device *dev, struct device_attribute *attr,
-				    char *buf)
+static ssize_t retu_wdt_period_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
 {
 	/* Show current max counter */
 	return sprintf(buf, "%u\n", (u16)period_val);
 }
 
-static ssize_t retu_wdt_period_store(struct device *dev, struct device_attribute *attr,
-				     const char *buf, size_t count)
+static ssize_t retu_wdt_period_store(struct device *dev,
+				struct device_attribute *attr,
+				const char *buf, size_t count)
 {
 	unsigned int new_period;
 	int ret;
@@ -86,8 +88,8 @@ static ssize_t retu_wdt_period_store(struct device *dev, struct device_attribute
 	return strnlen(buf, count);
 }
 
-static ssize_t retu_wdt_counter_show(struct device *dev, struct device_attribute *attr,
-				     char *buf)
+static ssize_t retu_wdt_counter_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
 {
 	u16 counter;
 
@@ -99,7 +101,7 @@ static ssize_t retu_wdt_counter_show(struct device *dev, struct device_attribute
 }
 
 static DEVICE_ATTR(period, S_IRUGO | S_IWUSR, retu_wdt_period_show, \
-                   retu_wdt_period_store);
+			retu_wdt_period_store);
 static DEVICE_ATTR(counter, S_IRUGO, retu_wdt_counter_show, NULL);
 
 static int __devinit retu_wdt_probe(struct device *dev)
@@ -108,14 +110,16 @@ static int __devinit retu_wdt_probe(struct device *dev)
 
 	ret = device_create_file(dev, &dev_attr_period);
 	if (ret) {
-		printk(KERN_ERR "retu_wdt_probe: Error creating sys device file: period\n");
+		printk(KERN_ERR "retu_wdt_probe: Error creating "
+					"sys device file: period\n");
 		return ret;
 	}
 
 	ret = device_create_file(dev, &dev_attr_counter);
 	if (ret) {
 		device_remove_file(dev, &dev_attr_period);
-		printk(KERN_ERR "retu_wdt_probe: Error creating sys device file: counter\n");
+		printk(KERN_ERR "retu_wdt_probe: Error creating "
+					"sys device file: counter\n");
 	}
 
 	return ret;
-- 
1.5.3.6


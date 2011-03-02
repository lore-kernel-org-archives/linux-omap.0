From: Michael Buesch <mb@bu3sch.de>
Subject: [PATCH] cbus-retu-wdt: Make the watchdog driver fully preemptible
Date: Wed, 02 Mar 2011 17:11:47 +0100
Message-ID: <1299082307.13604.12.camel@marge>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 80-190-117-144.ip-home.de ([80.190.117.144]:45227 "EHLO
	bu3sch.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752002Ab1CBQLx (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 2 Mar 2011 11:11:53 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <balbi@ti.com>, linux-omap <linux-omap@vger.kernel.org>

Make the WDT driver fully preemptible.
This is required in order to apply a locking fix to retu_write_reg.
It also improves power management by using round_relative_jiffies().

Signed-off-by: Michael Buesch <mb@bu3sch.de>

---

Tony, thanks for the report on this issue.
You may apply the locking fix on to of this.


Index: linux-2.6.38-rc6/drivers/cbus/retu-wdt.c
===================================================================
--- linux-2.6.38-rc6.orig/drivers/cbus/retu-wdt.c	2011-03-02 16:08:59.022211654 +0100
+++ linux-2.6.38-rc6/drivers/cbus/retu-wdt.c	2011-03-02 16:29:43.215284501 +0100
@@ -58,13 +58,11 @@ struct retu_wdt_dev {
 	struct device		*dev;
 	int			users;
 	struct miscdevice	retu_wdt_miscdev;
-	struct timer_list	ping_timer;
+	struct delayed_work	ping_work;
 };
 
 static struct retu_wdt_dev *retu_wdt;
 
-static void retu_wdt_set_ping_timer(unsigned long enable);
-
 static int _retu_modify_counter(unsigned int new)
 {
 	if (retu_wdt)
@@ -86,6 +84,31 @@ static int retu_modify_counter(unsigned
 	return 0;
 }
 
+/*
+ * Since retu watchdog cannot be disabled in hardware, we must kick it
+ * with a timer until userspace watchdog software takes over. Do this
+ * unless /dev/watchdog is open or CONFIG_WATCHDOG_NOWAYOUT is set.
+ */
+static void retu_wdt_ping_enable(struct retu_wdt_dev *wdev)
+{
+	_retu_modify_counter(RETU_WDT_MAX_TIMER);
+	schedule_delayed_work(&wdev->ping_work,
+			      round_jiffies_relative(RETU_WDT_DEFAULT_TIMER * HZ));
+}
+
+static void retu_wdt_ping_disable(struct retu_wdt_dev *wdev)
+{
+	_retu_modify_counter(RETU_WDT_MAX_TIMER);
+	cancel_delayed_work_sync(&wdev->ping_work);
+}
+
+static void retu_wdt_ping_work(struct work_struct *work)
+{
+	struct retu_wdt_dev *wdev = container_of(to_delayed_work(work),
+					struct retu_wdt_dev, ping_work);
+	retu_wdt_ping_enable(wdev);
+}
+
 static ssize_t retu_wdt_period_show(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
@@ -105,7 +128,7 @@ static ssize_t retu_wdt_period_store(str
 	int ret;
 
 #ifdef CONFIG_WATCHDOG_NOWAYOUT
-	retu_wdt_set_ping_timer(0);
+	retu_wdt_ping_disable(retu_wdt);
 #endif
 
 	if (sscanf(buf, "%u", &new_period) != 1) {
@@ -136,30 +159,13 @@ static DEVICE_ATTR(period, S_IRUGO | S_I
 			retu_wdt_period_store);
 static DEVICE_ATTR(counter, S_IRUGO, retu_wdt_counter_show, NULL);
 
-/*----------------------------------------------------------------------------*/
-
-/*
- * Since retu watchdog cannot be disabled in hardware, we must kick it
- * with a timer until userspace watchdog software takes over. Do this
- * unless /dev/watchdog is open or CONFIG_WATCHDOG_NOWAYOUT is set.
- */
-static void retu_wdt_set_ping_timer(unsigned long enable)
-{
-	_retu_modify_counter(RETU_WDT_MAX_TIMER);
-	if (enable)
-		mod_timer(&retu_wdt->ping_timer,
-				jiffies + RETU_WDT_DEFAULT_TIMER * HZ);
-	else
-		del_timer_sync(&retu_wdt->ping_timer);
-}
-
 static int retu_wdt_open(struct inode *inode, struct file *file)
 {
 	if (test_and_set_bit(1, (unsigned long *)&(retu_wdt->users)))
 		return -EBUSY;
 
 	file->private_data = (void *)retu_wdt;
-	retu_wdt_set_ping_timer(0);
+	retu_wdt_ping_disable(retu_wdt);
 
 	return nonseekable_open(inode, file);
 }
@@ -169,7 +175,7 @@ static int retu_wdt_release(struct inode
 	struct retu_wdt_dev *wdev = file->private_data;
 
 #ifndef CONFIG_WATCHDOG_NOWAYOUT
-	retu_wdt_set_ping_timer(1);
+	retu_wdt_ping_enable(retu_wdt);
 #endif
 	wdev->users = 0;
 
@@ -232,7 +238,7 @@ static int __devinit retu_wdt_ping(void)
 #ifdef CONFIG_WATCHDOG_NOWAYOUT
 	retu_modify_counter(RETU_WDT_MAX_TIMER);
 #else
-	retu_wdt_set_ping_timer(1);
+	retu_wdt_ping_enable(retu_wdt);
 #endif
 
 	return 0;
@@ -283,7 +289,7 @@ static int __init retu_wdt_probe(struct
 	if (ret)
 		goto free3;
 
-	setup_timer(&wdev->ping_timer, retu_wdt_set_ping_timer, 1);
+	INIT_DELAYED_WORK(&wdev->ping_work, retu_wdt_ping_work);
 
 	/* passed as module parameter? */
 	ret = retu_modify_counter(counter_param);
@@ -326,6 +332,7 @@ static int __devexit retu_wdt_remove(str
 	misc_deregister(&wdev->retu_wdt_miscdev);
 	device_remove_file(&pdev->dev, &dev_attr_period);
 	device_remove_file(&pdev->dev, &dev_attr_counter);
+	cancel_delayed_work_sync(&wdev->ping_work);
 	kfree(wdev);
 
 	return 0;

-- 
Greetings, Michael.



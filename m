From: Jouni Hogander <jouni.hogander@nokia.com>
Subject: [PATCH 3/6] OMAP: PM: Add new sysfs option for disabling clocks when entering idle
Date: Mon, 30 Jun 2008 11:52:48 +0300
Message-ID: <1214815968-23157-1-git-send-email-jouni.hogander@nokia.com>
References: <87tzfb9uhs.fsf@trdhcp146196.ntc.nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:62403 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753766AbYF3Iwx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 30 Jun 2008 04:52:53 -0400
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m5U8q6eR014748
	for <linux-omap@vger.kernel.org>; Mon, 30 Jun 2008 03:52:51 -0500
Received: from localhost.localdomain (trdhcp146197.ntc.nokia.com [172.22.146.197])
	by mgw-int02.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id m5U8qmq7022655
	for <linux-omap@vger.kernel.org>; Mon, 30 Jun 2008 11:52:48 +0300
In-Reply-To: <87tzfb9uhs.fsf@trdhcp146196.ntc.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

There are drivers that are not disabling their clocks (gpio &
uart). These clocks need to be disabled if retention/off state is
wanted when idling. Before disabling them in idle loop this option
needs to be checked.

Signed-off-by: Jouni Hogander <jouni.hogander@nokia.com>
---
 arch/arm/mach-omap2/pm.c |   37 +++++++++++++++++++++++++++++++------
 arch/arm/mach-omap2/pm.h |    1 +
 2 files changed, 32 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
index bef58d7..b7434df 100644
--- a/arch/arm/mach-omap2/pm.c
+++ b/arch/arm/mach-omap2/pm.c
@@ -31,30 +31,51 @@
 #include "pm.h"
 
 unsigned short enable_dyn_sleep;
+unsigned short clocks_off_while_idle;
 atomic_t sleep_block = ATOMIC_INIT(0);
 
+static ssize_t idle_show(struct kobject *, struct kobj_attribute *, char *);
+static ssize_t idle_store(struct kobject *k, struct kobj_attribute *,
+			  const char *buf, size_t n);
+
+static struct kobj_attribute sleep_while_idle_attr =
+	__ATTR(sleep_while_idle, 0644, idle_show, idle_store);
+
+static struct kobj_attribute clocks_off_while_idle_attr =
+	__ATTR(clocks_off_while_idle, 0644, idle_show, idle_store);
+
 static ssize_t idle_show(struct kobject *kobj, struct kobj_attribute *attr,
 			 char *buf)
 {
-	return sprintf(buf, "%hu\n", enable_dyn_sleep);
+	if (attr == &sleep_while_idle_attr)
+		return sprintf(buf, "%hu\n", enable_dyn_sleep);
+	else if (attr == &clocks_off_while_idle_attr)
+		return sprintf(buf, "%hu\n", clocks_off_while_idle);
+	else
+		return -EINVAL;
 }
 
 static ssize_t idle_store(struct kobject *kobj, struct kobj_attribute *attr,
 			  const char *buf, size_t n)
 {
 	unsigned short value;
+
 	if (sscanf(buf, "%hu", &value) != 1 ||
 	    (value != 0 && value != 1)) {
-		printk(KERN_ERR "idle_sleep_store: Invalid value\n");
+		printk(KERN_ERR "idle_store: Invalid value\n");
 		return -EINVAL;
 	}
-	enable_dyn_sleep = value;
+
+	if (attr == &sleep_while_idle_attr)
+		enable_dyn_sleep = value;
+	else if (attr == &clocks_off_while_idle_attr)
+		clocks_off_while_idle = value;
+	else
+		return -EINVAL;
+
 	return n;
 }
 
-static struct kobj_attribute sleep_while_idle_attr =
-	__ATTR(sleep_while_idle, 0644, idle_show, idle_store);
-
 void omap2_block_sleep(void)
 {
 	atomic_inc(&sleep_block);
@@ -86,6 +107,10 @@ int __init omap_pm_init(void)
 	error = sysfs_create_file(power_kobj, &sleep_while_idle_attr.attr);
 	if (error)
 		printk(KERN_ERR "sysfs_create_file failed: %d\n", error);
+	error = sysfs_create_file(power_kobj,
+				  &clocks_off_while_idle_attr.attr);
+	if (error)
+		printk(KERN_ERR "sysfs_create_file failed: %d\n", error);
 
 	return error;
 }
diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
index 351456e..0aeb461 100644
--- a/arch/arm/mach-omap2/pm.h
+++ b/arch/arm/mach-omap2/pm.h
@@ -17,6 +17,7 @@ extern int omap2_pm_init(void);
 extern int omap3_pm_init(void);
 
 extern unsigned short enable_dyn_sleep;
+extern unsigned short clocks_off_while_idle;
 extern atomic_t sleep_block;
 
 #ifdef CONFIG_PM_DEBUG
-- 
1.5.5


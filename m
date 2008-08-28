From: Kalle Jokiniemi <ext-kalle.jokiniemi@nokia.com>
Subject: [PATCH 2/3] OMAP: Sysfs interface for enabling voltage off in idle
Date: Thu, 28 Aug 2008 16:25:58 +0300
Message-ID: <1219929959-6611-2-git-send-email-ext-kalle.jokiniemi@nokia.com>
References: <>
 <1219929959-6611-1-git-send-email-ext-kalle.jokiniemi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:22368 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751432AbYH1NW1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 Aug 2008 09:22:27 -0400
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m7SDKn2o015530
	for <linux-omap@vger.kernel.org>; Thu, 28 Aug 2008 08:22:26 -0500
In-Reply-To: <1219929959-6611-1-git-send-email-ext-kalle.jokiniemi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Kalle Jokiniemi <ext-kalle.jokiniemi@nokia.com>

This patch creates a sysfs interface (/sys/power/voltage_off_while_idle) to
set or clear a variable which can be used in determining wether voltage
regulators should be shut down in idle.

Signed-off-by: Kalle Jokiniemi <ext-kalle.jokiniemi@nokia.com>
---
 arch/arm/mach-omap2/pm.c |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
index 4652136..05fbb9c 100644
--- a/arch/arm/mach-omap2/pm.c
+++ b/arch/arm/mach-omap2/pm.c
@@ -33,6 +33,7 @@
 
 unsigned short enable_dyn_sleep;
 unsigned short clocks_off_while_idle;
+unsigned short voltage_off_while_idle;
 atomic_t sleep_block = ATOMIC_INIT(0);
 
 static ssize_t idle_show(struct kobject *, struct kobj_attribute *, char *);
@@ -45,6 +46,9 @@ static struct kobj_attribute sleep_while_idle_attr =
 static struct kobj_attribute clocks_off_while_idle_attr =
 	__ATTR(clocks_off_while_idle, 0644, idle_show, idle_store);
 
+static struct kobj_attribute voltage_off_while_idle_attr =
+	__ATTR(voltage_off_while_idle, 0644, idle_show, idle_store);
+
 static ssize_t idle_show(struct kobject *kobj, struct kobj_attribute *attr,
 			 char *buf)
 {
@@ -52,6 +56,8 @@ static ssize_t idle_show(struct kobject *kobj, struct kobj_attribute *attr,
 		return sprintf(buf, "%hu\n", enable_dyn_sleep);
 	else if (attr == &clocks_off_while_idle_attr)
 		return sprintf(buf, "%hu\n", clocks_off_while_idle);
+	else if (attr == &voltage_off_while_idle_attr)
+		return sprintf(buf, "%hu\n", voltage_off_while_idle);
 	else
 		return -EINVAL;
 }
@@ -71,6 +77,8 @@ static ssize_t idle_store(struct kobject *kobj, struct kobj_attribute *attr,
 		enable_dyn_sleep = value;
 	else if (attr == &clocks_off_while_idle_attr)
 		clocks_off_while_idle = value;
+	else if (attr == &voltage_off_while_idle_attr)
+		voltage_off_while_idle = value;
 	else
 		return -EINVAL;
 
@@ -113,6 +121,15 @@ static int __init omap_pm_init(void)
 	if (error)
 		printk(KERN_ERR "sysfs_create_file failed: %d\n", error);
 
+	voltage_off_while_idle = 0;
+	/* Going to 0V on anything under ES2.1 will eventually cause a crash */
+	if (is_sil_rev_greater_than(OMAP3430_REV_ES2_0)) {
+		error = sysfs_create_file(power_kobj,
+				  &voltage_off_while_idle_attr.attr);
+		if (error)
+			printk(KERN_ERR "sysfs_create_file failed: %d\n",
+								error);
+	}
 	return error;
 }
 
-- 
1.5.4.3


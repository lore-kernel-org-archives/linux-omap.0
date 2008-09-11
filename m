From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 26/29] OMAP: Sysfs interface for enabling voltage off in idle
Date: Thu, 11 Sep 2008 15:34:10 +0300
Message-ID: <1221136453-16697-26-git-send-email-khilman@deeprootsystems.com>
References: <87iqt2amoi.fsf@deeprootsystems.com>
 <1221136453-16697-1-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-2-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-3-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-4-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-5-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-6-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-7-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-8-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-9-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-10-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-11-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-12-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-13-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-14-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-15-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-16-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-17-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-18-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-19-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-20-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-21-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-22-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-23-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-24-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-25-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:19035 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754412AbYIKMfI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Sep 2008 08:35:08 -0400
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m8BCZ0F2018889
	for <linux-omap@vger.kernel.org>; Thu, 11 Sep 2008 15:35:06 +0300
In-Reply-To: <1221136453-16697-25-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Kalle Jokiniemi <ext-kalle.jokiniemi@nokia.com>

From: Kalle Jokiniemi <ext-kalle.jokiniemi@nokia.com>

This patch creates a sysfs interface (/sys/power/voltage_off_while_idle) to
set or clear a variable which can be used in determining wether voltage
regulators should be shut down in idle.

Signed-off-by: Kalle Jokiniemi <ext-kalle.jokiniemi@nokia.com>
---
 arch/arm/mach-omap2/pm.c |   21 ++++++++++++++++++++-
 arch/arm/mach-omap2/pm.h |    1 +
 2 files changed, 21 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
index c063565..c89de1e 100644
--- a/arch/arm/mach-omap2/pm.c
+++ b/arch/arm/mach-omap2/pm.c
@@ -36,6 +36,7 @@
 unsigned short enable_dyn_sleep;
 unsigned short gpio_clocks_off_while_idle;
 unsigned short uart_clocks_off_while_idle;
+unsigned short voltage_off_while_idle;
 atomic_t sleep_block = ATOMIC_INIT(0);
 
 static ssize_t idle_show(struct kobject *, struct kobj_attribute *, char *);
@@ -51,6 +52,9 @@ static struct kobj_attribute gpio_clocks_off_while_idle_attr =
 static struct kobj_attribute uart_clocks_off_while_idle_attr =
 	__ATTR(uart_clocks_off_while_idle, 0644, idle_show, idle_store);
 
+static struct kobj_attribute voltage_off_while_idle_attr =
+	__ATTR(voltage_off_while_idle, 0644, idle_show, idle_store);
+
 static ssize_t idle_show(struct kobject *kobj, struct kobj_attribute *attr,
 			 char *buf)
 {
@@ -60,6 +64,8 @@ static ssize_t idle_show(struct kobject *kobj, struct kobj_attribute *attr,
 		return sprintf(buf, "%hu\n", gpio_clocks_off_while_idle);
 	else if (attr == &uart_clocks_off_while_idle_attr)
 		return sprintf(buf, "%hu\n", uart_clocks_off_while_idle);
+	else if (attr == &voltage_off_while_idle_attr)
+		return sprintf(buf, "%hu\n", voltage_off_while_idle);
 	else
 		return -EINVAL;
 }
@@ -81,6 +87,8 @@ static ssize_t idle_store(struct kobject *kobj, struct kobj_attribute *attr,
 		gpio_clocks_off_while_idle = value;
 	else if (attr == &uart_clocks_off_while_idle_attr)
 		uart_clocks_off_while_idle = value;
+	else if (attr == &voltage_off_while_idle_attr)
+		voltage_off_while_idle = value;
 	else
 		return -EINVAL;
 
@@ -129,9 +137,20 @@ static int __init omap_pm_init(void)
 
 	error = sysfs_create_file(power_kobj,
 				  &gpio_clocks_off_while_idle_attr.attr);
-	if (error)
+	if (error) {
 		printk(KERN_ERR "sysfs_create_file failed: %d\n", error);
+		return error;
+	}
 
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
 
diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
index 7776cdb..aad4aeb 100644
--- a/arch/arm/mach-omap2/pm.h
+++ b/arch/arm/mach-omap2/pm.h
@@ -19,6 +19,7 @@ extern int omap3_pm_init(void);
 extern unsigned short enable_dyn_sleep;
 extern unsigned short gpio_clocks_off_while_idle;
 extern unsigned short uart_clocks_off_while_idle;
+extern unsigned short voltage_off_while_idle;
 extern atomic_t sleep_block;
 
 extern void omap2_block_sleep(void);
-- 
1.6.0


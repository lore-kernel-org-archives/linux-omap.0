From: Viktor Rosendahl <viktor.rosendahl@nokia.com>
Subject: [PATCH 05/10] lowmem: sysfs has changed
Date: Thu, 11 Sep 2008 19:20:37 +0300
Message-ID: <1221150042-10873-6-git-send-email-viktor.rosendahl@nokia.com>
References: <1221150042-10873-1-git-send-email-viktor.rosendahl@nokia.com>
 <1221150042-10873-2-git-send-email-viktor.rosendahl@nokia.com>
 <1221150042-10873-3-git-send-email-viktor.rosendahl@nokia.com>
 <1221150042-10873-4-git-send-email-viktor.rosendahl@nokia.com>
 <1221150042-10873-5-git-send-email-viktor.rosendahl@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:63310 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753122AbYIKQLg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Sep 2008 12:11:36 -0400
Received: from esebh107.NOE.Nokia.com (esebh107.ntc.nokia.com [172.21.143.143])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m8BGAhWx025093
	for <linux-omap@vger.kernel.org>; Thu, 11 Sep 2008 11:11:34 -0500
Received: from localhost.localdomain (viktor.research.nokia.com [172.21.50.87])
	by mgw-int02.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id m8BGBJOo012003
	for <linux-omap@vger.kernel.org>; Thu, 11 Sep 2008 19:11:26 +0300
In-Reply-To: <1221150042-10873-5-git-send-email-viktor.rosendahl@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Currently, the lowmem module doesn't even compile because the kernel API has
changed. This patch will unbreak the sysfs related code.

Signed-off-by: Viktor Rosendahl <viktor.rosendahl@nokia.com>
---
 security/lowmem.c |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/security/lowmem.c b/security/lowmem.c
index 183c57f..a5b6088 100644
--- a/security/lowmem.c
+++ b/security/lowmem.c
@@ -117,16 +117,18 @@ static ctl_table lowmem_root_table[] = {
 };
 
 #define KERNEL_ATTR_RO(_name) \
-static struct subsys_attribute _name##_attr = __ATTR_RO(_name)
+static struct kobj_attribute _name##_attr = __ATTR_RO(_name)
 
 static int low_watermark_reached, high_watermark_reached;
 
-static ssize_t low_watermark_show(struct subsystem *subsys, char *page)
+static ssize_t low_watermark_show(struct kobject *kobj,
+				  struct kobj_attribute *attr, char *page)
 {
 	return sprintf(page, "%u\n", low_watermark_reached);
 }
 
-static ssize_t high_watermark_show(struct subsystem *subsys, char *page)
+static ssize_t high_watermark_show(struct kobject *kobj,
+				   struct kobj_attribute *attr, char *page)
 {
 	return sprintf(page, "%u\n", high_watermark_reached);
 }
@@ -138,7 +140,7 @@ static void low_watermark_state(int new_state)
 {
 	if (low_watermark_reached != new_state) {
 		low_watermark_reached = new_state;
-		sysfs_notify(&kernel_subsys.kset.kobj, NULL, "low_watermark");
+		sysfs_notify(kernel_kobj, NULL, "low_watermark");
 	}
 }
 
@@ -146,7 +148,7 @@ static void high_watermark_state(int new_state)
 {
 	if (high_watermark_reached != new_state) {
 		high_watermark_reached = new_state;
-		sysfs_notify(&kernel_subsys.kset.kobj, NULL, "high_watermark");
+		sysfs_notify(kernel_kobj, NULL, "high_watermark");
 	}
 }
 
@@ -279,9 +281,7 @@ static int __init lowmem_init(void)
 	if (unlikely(!lowmem_table_header))
 		return -EPERM;
 
-	kernel_subsys.kset.kobj.kset = &kernel_subsys.kset;
-
-	r = sysfs_create_group(&kernel_subsys.kset.kobj,
+	r = sysfs_create_group(kernel_kobj,
 			       &lowmem_attr_group);
 	if (unlikely(r))
 		return r;
@@ -307,7 +307,7 @@ static void __exit lowmem_exit(void)
 
 	unregister_sysctl_table(lowmem_table_header);
 
-	sysfs_remove_group(&kernel_subsys.kset.kobj, &lowmem_attr_group);
+	sysfs_remove_group(kernel_kobj, &lowmem_attr_group);
 
 	printk(KERN_INFO MY_NAME ": Module removed.\n");
 }
-- 
1.5.6.3


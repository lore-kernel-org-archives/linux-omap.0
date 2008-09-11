From: Viktor Rosendahl <viktor.rosendahl@nokia.com>
Subject: [PATCH 08/10] lowmem: add compatibility code
Date: Thu, 11 Sep 2008 19:20:40 +0300
Message-ID: <1221150042-10873-9-git-send-email-viktor.rosendahl@nokia.com>
References: <1221150042-10873-1-git-send-email-viktor.rosendahl@nokia.com>
 <1221150042-10873-2-git-send-email-viktor.rosendahl@nokia.com>
 <1221150042-10873-3-git-send-email-viktor.rosendahl@nokia.com>
 <1221150042-10873-4-git-send-email-viktor.rosendahl@nokia.com>
 <1221150042-10873-5-git-send-email-viktor.rosendahl@nokia.com>
 <1221150042-10873-6-git-send-email-viktor.rosendahl@nokia.com>
 <1221150042-10873-7-git-send-email-viktor.rosendahl@nokia.com>
 <1221150042-10873-8-git-send-email-viktor.rosendahl@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:17884 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753355AbYIKQLn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Sep 2008 12:11:43 -0400
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m8BGBETI012096
	for <linux-omap@vger.kernel.org>; Thu, 11 Sep 2008 19:11:40 +0300
Received: from localhost.localdomain (viktor.research.nokia.com [172.21.50.87])
	by mgw-int02.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id m8BGBJOr012003
	for <linux-omap@vger.kernel.org>; Thu, 11 Sep 2008 19:11:30 +0300
In-Reply-To: <1221150042-10873-8-git-send-email-viktor.rosendahl@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

This is a patch that will reintroduce the old sysctl lowmem variables as read
only values in /proc/sys/vm. Some parts of the userland (at least libosso) are
reading these and it would probably greatly ease the transition to the new
scheme with memory limits in pages. We can revert this ugly patch when userland
has moved to the new scheme.

Signed-off-by: Viktor Rosendahl <viktor.rosendahl@nokia.com>
---
 security/lowmem.c |   94 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 94 insertions(+), 0 deletions(-)

diff --git a/security/lowmem.c b/security/lowmem.c
index 87f6cec..56f1f6e 100644
--- a/security/lowmem.c
+++ b/security/lowmem.c
@@ -23,6 +23,10 @@ enum {
 	VM_LOWMEM_ALLOWED_UIDS,
 	VM_LOWMEM_ALLOWED_PAGES,
 	VM_LOWMEM_FREE_PAGES,
+	VM_LOWMEM_DENY,
+	VM_LOWMEM_LEVEL1_NOTIFY,
+	VM_LOWMEM_LEVEL2_NOTIFY,
+	VM_LOWMEM_USED_PAGES
 };
 
 static long deny_pages;
@@ -33,6 +37,22 @@ static unsigned long lowmem_free_pages;
 static unsigned int allowed_uids[LOWMEM_MAX_UIDS];
 static unsigned int minuid = 1;
 static unsigned int maxuid = 65535;
+static unsigned int deny_percentage;
+static unsigned int l1_notify, l2_notify;
+static long used_pages;
+
+static int
+proc_dointvec_used(ctl_table *table, int write, struct file *filp,
+			void __user *buffer, size_t *lenp, loff_t *ppos);
+static int
+proc_dointvec_l1_notify(ctl_table *table, int write, struct file *filp,
+			void __user *buffer, size_t *lenp, loff_t *ppos);
+static int
+proc_dointvec_l2_notify(ctl_table *table, int write, struct file *filp,
+			void __user *buffer, size_t *lenp, loff_t *ppos);
+static int
+proc_dointvec_deny(ctl_table *table, int write, struct file *filp,
+			void __user *buffer, size_t *lenp, loff_t *ppos);
 
 static ctl_table lowmem_table[] = {
 	{
@@ -45,6 +65,42 @@ static ctl_table lowmem_table[] = {
 		.proc_handler = &proc_dointvec,
 		.strategy = &sysctl_intvec,
 	}, {
+		.ctl_name = VM_LOWMEM_DENY,
+		.procname = "lowmem_deny_watermark",
+		.data = &deny_percentage,
+		.maxlen = sizeof(unsigned int),
+		.mode = 0444,
+		.child = NULL,
+		.proc_handler = &proc_dointvec_deny,
+		.strategy = &sysctl_intvec,
+	}, {
+		.ctl_name = VM_LOWMEM_LEVEL1_NOTIFY,
+		.procname = "lowmem_notify_low",
+		.data = &l1_notify,
+		.maxlen = sizeof(unsigned int),
+		.mode = 0444,
+		.child = NULL,
+		.proc_handler = &proc_dointvec_l1_notify,
+		.strategy = &sysctl_intvec,
+	}, {
+		.ctl_name = VM_LOWMEM_LEVEL2_NOTIFY,
+		.procname = "lowmem_notify_high",
+		.data = &l2_notify,
+		.maxlen = sizeof(unsigned int),
+		.mode = 0444,
+		.child = NULL,
+		.proc_handler = &proc_dointvec_l2_notify,
+		.strategy = &sysctl_intvec,
+	}, {
+		.ctl_name = VM_LOWMEM_USED_PAGES,
+		.procname = "lowmem_used_pages",
+		.data = &used_pages,
+		.maxlen = sizeof(long),
+		.mode = 0444,
+		.child = NULL,
+		.proc_handler = &proc_dointvec_used,
+		.strategy = &sysctl_intvec,
+	}, {
 		.ctl_name = VM_LOWMEM_NOTIFY_LOW_PAGES,
 		.procname = "lowmem_notify_low_pages",
 		.data = &notify_low_pages,
@@ -121,6 +177,44 @@ static struct kobj_attribute _name##_attr = __ATTR_RO(_name)
 
 static int low_watermark_reached, high_watermark_reached;
 
+static int
+proc_dointvec_l1_notify(ctl_table *table, int write, struct file *filp,
+			void __user *buffer, size_t *lenp, loff_t *ppos)
+{
+	l1_notify =
+	100 - (100 * notify_low_pages + allowed_pages / 2) / allowed_pages;
+	return proc_dointvec(table, write, filp, buffer, lenp, ppos);
+}
+
+static int
+proc_dointvec_l2_notify(ctl_table *table, int write, struct file *filp,
+			void __user *buffer, size_t *lenp, loff_t *ppos)
+{
+	l2_notify =
+	100 - (100 * notify_high_pages + allowed_pages / 2) / allowed_pages;
+	return proc_dointvec(table, write, filp, buffer, lenp, ppos);
+}
+
+static int
+proc_dointvec_deny(ctl_table *table, int write, struct file *filp,
+			void __user *buffer, size_t *lenp, loff_t *ppos)
+{
+	deny_percentage =
+	100 - (100 * deny_pages + allowed_pages / 2) / allowed_pages;
+	return proc_dointvec(table, write, filp, buffer, lenp, ppos);
+}
+
+static int
+proc_dointvec_used(ctl_table *table, int write, struct file *filp,
+			void __user *buffer, size_t *lenp, loff_t *ppos)
+{
+	if (lowmem_free_pages > 0 && allowed_pages > lowmem_free_pages)
+		used_pages = allowed_pages - lowmem_free_pages;
+	else
+		used_pages = 0;
+	return proc_dointvec(table, write, filp, buffer, lenp, ppos);
+}
+
 static ssize_t low_watermark_show(struct kobject *kobj,
 				  struct kobj_attribute *attr, char *page)
 {
-- 
1.5.6.3


From: Viktor Rosendahl <viktor.rosendahl@nokia.com>
Subject: [PATCH 03/10] lowmem: get rid of the percentages
Date: Thu, 11 Sep 2008 19:20:35 +0300
Message-ID: <1221150042-10873-4-git-send-email-viktor.rosendahl@nokia.com>
References: <1221150042-10873-1-git-send-email-viktor.rosendahl@nokia.com>
 <1221150042-10873-2-git-send-email-viktor.rosendahl@nokia.com>
 <1221150042-10873-3-git-send-email-viktor.rosendahl@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:17864 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752498AbYIKQL2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Sep 2008 12:11:28 -0400
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m8BGBESu012096
	for <linux-omap@vger.kernel.org>; Thu, 11 Sep 2008 19:11:26 +0300
Received: from localhost.localdomain (viktor.research.nokia.com [172.21.50.87])
	by mgw-int02.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id m8BGBJOm012003
	for <linux-omap@vger.kernel.org>; Thu, 11 Sep 2008 19:11:23 +0300
In-Reply-To: <1221150042-10873-3-git-send-email-viktor.rosendahl@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

The purpose of this patch is to get rid of the lame percentage calculations in
lowmem.c. Currently, the limits (measured in pages) are calculated from
percentages every time somebody from userspace requests some memory. With this
patch, the limits are in pages and furthermore, they are specified as minimum
amount of "free pages", instead of as maximum amount of "used pages". "Free"
means free pages or such pages that can easily be freed by the VM system.

This patch changes the names of the lowmem sysctl limits in /proc/sys/vm:
lowmem_deny_watermark  	     => lowmem_deny_watermark_pages
lowmem_notify_low	     => lowmem_notify_low_pages
lowmem_notify_high 	     => lowmem_notify_high_pages

The following read only value disappears:
lowmem_used_pages

The following read only value is introduced:
lowmem_free_pages

The old value can be calculated from userspace with the following pseudocode:

if lowmem_free_pages < lowmem_allowed_pages
   lowmem_used_pages = lowmem_allowed_pages - lowmem_free_pages
else
   lowmem_used_pages = 0;

Note that the value of lowmem_free_pages is only accurate when the system is
rather low on memory (otherwise it's a bit too pessimistic), this was true also
for the lowmem_used_pages metric.

Signed-off-by: Viktor Rosendahl <viktor.rosendahl@nokia.com>
---
 security/lowmem.c |   82 +++++++++++++++++++++++-----------------------------
 1 files changed, 36 insertions(+), 46 deletions(-)

diff --git a/security/lowmem.c b/security/lowmem.c
index a965676..2dc0c4a 100644
--- a/security/lowmem.c
+++ b/security/lowmem.c
@@ -16,48 +16,48 @@
 #define LOWMEM_MAX_UIDS 8
 
 enum {
-	VM_LOWMEM_DENY = 1,
-	VM_LOWMEM_LEVEL1_NOTIFY,
-	VM_LOWMEM_LEVEL2_NOTIFY,
+	VM_LOWMEM_DENY_PAGES = 1,
+	VM_LOWMEM_NOTIFY_LOW_PAGES,
+	VM_LOWMEM_NOTIFY_HIGH_PAGES,
 	VM_LOWMEM_NR_DECAY_PAGES,
 	VM_LOWMEM_ALLOWED_UIDS,
 	VM_LOWMEM_ALLOWED_PAGES,
-	VM_LOWMEM_USED_PAGES,
+	VM_LOWMEM_FREE_PAGES,
 };
 
-static unsigned int deny_percentage;
-static unsigned int l1_notify, l2_notify;
+static long deny_pages;
+static long notify_low_pages, notify_high_pages;
 static unsigned int nr_decay_pages;
 static unsigned long allowed_pages;
-static long used_pages;
+static unsigned long lowmem_free_pages;
 static unsigned int allowed_uids[LOWMEM_MAX_UIDS];
 static unsigned int minuid = 1;
 static unsigned int maxuid = 65535;
 
 static ctl_table lowmem_table[] = {
 	{
-		.ctl_name = VM_LOWMEM_DENY,
-		.procname = "lowmem_deny_watermark",
-		.data = &deny_percentage,
-		.maxlen = sizeof(unsigned int),
+		.ctl_name = VM_LOWMEM_DENY_PAGES,
+		.procname = "lowmem_deny_watermark_pages",
+		.data = &deny_pages,
+		.maxlen = sizeof(long),
 		.mode = 0644,
 		.child = NULL,
 		.proc_handler = &proc_dointvec,
 		.strategy = &sysctl_intvec,
 	}, {
-		.ctl_name = VM_LOWMEM_LEVEL1_NOTIFY,
-		.procname = "lowmem_notify_low",
-		.data = &l1_notify,
-		.maxlen = sizeof(unsigned int),
+		.ctl_name = VM_LOWMEM_NOTIFY_LOW_PAGES,
+		.procname = "lowmem_notify_low_pages",
+		.data = &notify_low_pages,
+		.maxlen = sizeof(long),
 		.mode = 0644,
 		.child = NULL,
 		.proc_handler = &proc_dointvec,
 		.strategy = &sysctl_intvec,
 	}, {
-		.ctl_name = VM_LOWMEM_LEVEL2_NOTIFY,
-		.procname = "lowmem_notify_high",
-		.data = &l2_notify,
-		.maxlen = sizeof(unsigned int),
+		.ctl_name = VM_LOWMEM_NOTIFY_HIGH_PAGES,
+		.procname = "lowmem_notify_high_pages",
+		.data = &notify_high_pages,
+		.maxlen = sizeof(long),
 		.mode = 0644,
 		.child = NULL,
 		.proc_handler = &proc_dointvec,
@@ -92,10 +92,10 @@ static ctl_table lowmem_table[] = {
 		.proc_handler = &proc_dointvec,
 		.strategy = &sysctl_intvec,
 	}, {
-		.ctl_name = VM_LOWMEM_USED_PAGES,
-		.procname = "lowmem_used_pages",
-		.data = &used_pages,
-		.maxlen = sizeof(long),
+		.ctl_name = VM_LOWMEM_FREE_PAGES,
+		.procname = "lowmem_free_pages",
+		.data = &lowmem_free_pages,
+		.maxlen = sizeof(unsigned long),
 		.mode = 0444,
 		.child = NULL,
 		.proc_handler = &proc_dointvec,
@@ -163,21 +163,18 @@ static void high_watermark_state(int new_state)
 static int low_vm_enough_memory(long pages)
 {
 	unsigned long free, allowed;
-	long deny_threshold, level1, level2, used;
 	int cap_sys_admin = 0, notify;
 
 	if (cap_capable(current, CAP_SYS_ADMIN) == 0)
 		cap_sys_admin = 1;
 
+	allowed = totalram_pages - hugetlb_total_pages();
+	allowed_pages = allowed;
+
 	/* We activate ourselves only after both parameters have been
 	 * configured. */
-	if (deny_percentage == 0 || l1_notify == 0 || l2_notify == 0)
-		return __vm_enough_memory(pages, cap_sys_admin);
-
-	allowed = totalram_pages - hugetlb_total_pages();
-	deny_threshold = allowed * deny_percentage / 100;
-	level1 = allowed * l1_notify / 100;
-	level2 = allowed * l2_notify / 100;
+	if (deny_pages == 0 || notify_low_pages == 0 || notify_high_pages == 0)
+		return  __vm_enough_memory(pages, cap_sys_admin);
 
 	vm_acct_memory(pages);
 
@@ -186,22 +183,16 @@ static int low_vm_enough_memory(long pages)
 	free += nr_swap_pages;
 	free += global_page_state(NR_SLAB_RECLAIMABLE);
 
-	used = allowed - free;
-	if (unlikely(used < 0))
-		used = 0;
-
-	/* The hot path, plenty of memory */
-	if (likely(used < level1))
+	if (likely(free > notify_low_pages))
 		goto enough_memory;
 
 	/* No luck, lets make it more expensive and try again.. */
-	used -= nr_free_pages();
+	free += nr_free_pages();
 
-	if (used >= deny_threshold) {
+	if (free < deny_pages) {
 		int i;
 
-		allowed_pages = allowed;
-		used_pages = used;
+		lowmem_free_pages = free;
 		low_watermark_state(1);
 		high_watermark_state(1);
 		/* Memory allocations by root are always allowed */
@@ -227,7 +218,7 @@ static int low_vm_enough_memory(long pages)
 
 enough_memory:
 	/* See if we need to notify level 1 */
-	low_watermark_state(used >= level1);
+	low_watermark_state(free < notify_low_pages);
 
 	/*
 	 * In the level 2 notification case things are more complicated,
@@ -236,13 +227,12 @@ enough_memory:
 	 * on the same watermark level ends up bouncing back and forth
 	 * when applications are being stupid.
 	 */
-	notify = used >= level2;
-	if (notify || used + nr_decay_pages < level2)
+	notify = free < notify_high_pages;
+	if (notify || free - nr_decay_pages > notify_high_pages)
 		high_watermark_state(notify);
 
 	/* We have plenty of memory */
-	allowed_pages = allowed;
-	used_pages = used;
+	lowmem_free_pages = free;
 	return 0;
 }
 
-- 
1.5.6.3


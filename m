From: Artem Bityutskiy <dedekind1@gmail.com>
Subject: [PATCH] OMAP3: PM: introduce a new powerdomain walk helper
Date: Thu,  1 Oct 2009 10:01:55 +0300
Message-ID: <1254380515-32175-1-git-send-email-dedekind1@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:17523 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754185AbZJAHHE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Oct 2009 03:07:04 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org, Artem Bityutskiy <Artem.Bityutskiy@nokia.com>

From: Artem Bityutskiy <Artem.Bityutskiy@nokia.com>

The 'pwrdm_for_each()' function walks powerdomains with a spinlock
locked, so the the callbacks cannot do anything which may sleep.
This patch introduces a 'pwrdm_for_each_nolock()' helper which does
the same, but without the spinlock locked. This fixes the following
lockdep warning:

[    0.000000] WARNING: at kernel/lockdep.c:2460 lockdep_trace_alloc+0xac/0xec()
[    0.000000] Modules linked in:
(unwind_backtrace+0x0/0xdc) from [<c0045464>] (warn_slowpath_common+0x48/0x60)
(warn_slowpath_common+0x48/0x60) from [<c0067dd4>] (lockdep_trace_alloc+0xac/0xec)
(lockdep_trace_alloc+0xac/0xec) from [<c009da14>] (kmem_cache_alloc+0x1c/0xd0)
(kmem_cache_alloc+0x1c/0xd0) from [<c00b21d8>] (d_alloc+0x1c/0x1a4)
(d_alloc+0x1c/0x1a4) from [<c00a887c>] (__lookup_hash+0xd8/0x118)
(__lookup_hash+0xd8/0x118) from [<c00a9f20>] (lookup_one_len+0x84/0x94)
(lookup_one_len+0x84/0x94) from [<c010d12c>] (debugfs_create_file+0x8c/0x20c)
(debugfs_create_file+0x8c/0x20c) from [<c010d320>] (debugfs_create_dir+0x1c/0x20)
(debugfs_create_dir+0x1c/0x20) from [<c000e8cc>] (pwrdms_setup+0x60/0x90)
(pwrdms_setup+0x60/0x90) from [<c002e010>] (pwrdm_for_each+0x30/0x80)
(pwrdm_for_each+0x30/0x80) from [<c000e79c>] (pm_dbg_init+0x7c/0x14c)
(pm_dbg_init+0x7c/0x14c) from [<c00232b4>] (do_one_initcall+0x5c/0x1b8)
(do_one_initcall+0x5c/0x1b8) from [<c00083f8>] (kernel_init+0x90/0x10c)
(kernel_init+0x90/0x10c) from [<c00242c4>] (kernel_thread_exit+0x0/0x8)

Signed-off-by: Artem Bityutskiy <Artem.Bityutskiy@nokia.com>
---
 arch/arm/mach-omap2/pm-debug.c                |    4 +-
 arch/arm/mach-omap2/powerdomain.c             |   39 +++++++++++++++++-------
 arch/arm/plat-omap/include/mach/powerdomain.h |    2 +
 3 files changed, 31 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-omap2/pm-debug.c b/arch/arm/mach-omap2/pm-debug.c
index 1b4c160..2fc4d6a 100644
--- a/arch/arm/mach-omap2/pm-debug.c
+++ b/arch/arm/mach-omap2/pm-debug.c
@@ -541,7 +541,7 @@ static int __init pm_dbg_init(void)
 		printk(KERN_ERR "%s: only OMAP3 supported\n", __func__);
 		return -ENODEV;
 	}
-		
+
 	d = debugfs_create_dir("pm_debug", NULL);
 	if (IS_ERR(d))
 		return PTR_ERR(d);
@@ -551,7 +551,7 @@ static int __init pm_dbg_init(void)
 	(void) debugfs_create_file("time", S_IRUGO,
 		d, (void *)DEBUG_FILE_TIMERS, &debug_fops);
 
-	pwrdm_for_each(pwrdms_setup, (void *)d);
+	pwrdm_for_each_nolock(pwrdms_setup, (void *)d);
 
 	pm_dbg_dir = debugfs_create_dir("registers", d);
 	if (IS_ERR(pm_dbg_dir))
diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
index 2594cbf..f00289a 100644
--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -273,35 +273,50 @@ struct powerdomain *pwrdm_lookup(const char *name)
 }
 
 /**
- * pwrdm_for_each - call function on each registered clockdomain
+ * pwrdm_for_each_nolock - call function on each registered clockdomain
  * @fn: callback function *
  *
  * Call the supplied function for each registered powerdomain.  The
  * callback function can return anything but 0 to bail out early from
- * the iterator.  The callback function is called with the pwrdm_rwlock
- * held for reading, so no powerdomain structure manipulation
- * functions should be called from the callback, although hardware
- * powerdomain control functions are fine.  Returns the last return
- * value of the callback function, which should be 0 for success or
- * anything else to indicate failure; or -EINVAL if the function
- * pointer is null.
+ * the iterator.  Returns the last return value of the callback function, which
+ * should be 0 for success or anything else to indicate failure; or -EINVAL if
+ * the function pointer is null.
  */
-int pwrdm_for_each(int (*fn)(struct powerdomain *pwrdm, void *user),
-			void *user)
+int pwrdm_for_each_nolock(int (*fn)(struct powerdomain *pwrdm, void *user),
+				void *user)
 {
 	struct powerdomain *temp_pwrdm;
-	unsigned long flags;
 	int ret = 0;
 
 	if (!fn)
 		return -EINVAL;
 
-	read_lock_irqsave(&pwrdm_rwlock, flags);
 	list_for_each_entry(temp_pwrdm, &pwrdm_list, node) {
 		ret = (*fn)(temp_pwrdm, user);
 		if (ret)
 			break;
 	}
+
+	return ret;
+}
+
+/**
+ * pwrdm_for_each - call function on each registered clockdomain
+ * @fn: callback function *
+ *
+ * This function is the same as 'pwrdm_for_each_nolock()', but keeps the
+ * &pwrdm_rwlock locked for reading, so no powerdomain structure manipulation
+ * functions should be called from the callback, although hardware powerdomain
+ * control functions are fine.
+ */
+int pwrdm_for_each(int (*fn)(struct powerdomain *pwrdm, void *user),
+			void *user)
+{
+	unsigned long flags;
+	int ret;
+
+	read_lock_irqsave(&pwrdm_rwlock, flags);
+	ret = pwrdm_for_each_nolock(fn, user);
 	read_unlock_irqrestore(&pwrdm_rwlock, flags);
 
 	return ret;
diff --git a/arch/arm/plat-omap/include/mach/powerdomain.h b/arch/arm/plat-omap/include/mach/powerdomain.h
index 6271d85..fa64614 100644
--- a/arch/arm/plat-omap/include/mach/powerdomain.h
+++ b/arch/arm/plat-omap/include/mach/powerdomain.h
@@ -135,6 +135,8 @@ struct powerdomain *pwrdm_lookup(const char *name);
 
 int pwrdm_for_each(int (*fn)(struct powerdomain *pwrdm, void *user),
 			void *user);
+int pwrdm_for_each_nolock(int (*fn)(struct powerdomain *pwrdm, void *user),
+			void *user);
 
 int pwrdm_add_clkdm(struct powerdomain *pwrdm, struct clockdomain *clkdm);
 int pwrdm_del_clkdm(struct powerdomain *pwrdm, struct clockdomain *clkdm);
-- 
1.6.2.5


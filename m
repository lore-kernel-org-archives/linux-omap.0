From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH] PM: fix suspend_set_ops() to take const pointer
Date: Wed,  5 Jan 2011 16:22:53 -0800
Message-ID: <1294273373-8967-1-git-send-email-khilman@ti.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

checkpatch warns that pointers for certain structs should be const,
and platform_suspend_ops is one of those structs.  If you follow this
suggestion you trade a checkpatch warning for a compiler warning of
the form:

   warning: passing argument 1 of 'suspend_set_ops' discards qualifiers from pointer target type

Fix suspend_set_ops() to take a const pointer so everyone expects
const.

Signed-off-by: Kevin Hilman <khilman@ti.com>
---
Applies to v2.6.37, but also applies cleanly to suspend-2.6/linux-next

 include/linux/suspend.h |    4 ++--
 kernel/power/suspend.c  |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/suspend.h b/include/linux/suspend.h
index 2669751..bb98383 100644
--- a/include/linux/suspend.h
+++ b/include/linux/suspend.h
@@ -122,7 +122,7 @@ struct platform_suspend_ops {
  * suspend_set_ops - set platform dependent suspend operations
  * @ops: The new suspend operations to set.
  */
-extern void suspend_set_ops(struct platform_suspend_ops *ops);
+extern void suspend_set_ops(const struct platform_suspend_ops *ops);
 extern int suspend_valid_only_mem(suspend_state_t state);
 
 /**
@@ -147,7 +147,7 @@ extern int pm_suspend(suspend_state_t state);
 #else /* !CONFIG_SUSPEND */
 #define suspend_valid_only_mem	NULL
 
-static inline void suspend_set_ops(struct platform_suspend_ops *ops) {}
+static inline void suspend_set_ops(const struct platform_suspend_ops *ops) {}
 static inline int pm_suspend(suspend_state_t state) { return -ENOSYS; }
 #endif /* !CONFIG_SUSPEND */
 
diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index ecf7705..0c0af3d 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -36,7 +36,7 @@ static struct platform_suspend_ops *suspend_ops;
  *	suspend_set_ops - Set the global suspend method table.
  *	@ops:	Pointer to ops structure.
  */
-void suspend_set_ops(struct platform_suspend_ops *ops)
+void suspend_set_ops(const struct platform_suspend_ops *ops)
 {
 	mutex_lock(&pm_mutex);
 	suspend_ops = ops;
-- 
1.7.3.4

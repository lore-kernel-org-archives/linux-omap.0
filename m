From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 02/12] ARM: OMAP2+: PM/powerdomain: move the power state
 time tracking into the powerdomain code
Date: Sun, 09 Dec 2012 13:03:17 -0700
Message-ID: <20121209200259.3196.84569.stgit@dusk.lan>
References: <20121209200108.3196.12452.stgit@dusk.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:40187 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758920Ab2LIUFG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 9 Dec 2012 15:05:06 -0500
In-Reply-To: <20121209200108.3196.12452.stgit@dusk.lan>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Tero Kristo <t-kristo@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>

Move the power state time tracking code into the powerdomain code.
This code accesses internal powerdomain state, so this change will
allow us to reduce what is exported from the powerdomain code.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Tero Kristo <t-kristo@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/pm-debug.c    |   24 ------------------------
 arch/arm/mach-omap2/pm.h          |    6 ------
 arch/arm/mach-omap2/powerdomain.c |   22 +++++++++++++++++++++-
 3 files changed, 21 insertions(+), 31 deletions(-)

diff --git a/arch/arm/mach-omap2/pm-debug.c b/arch/arm/mach-omap2/pm-debug.c
index 03da2e3..80c001a 100644
--- a/arch/arm/mach-omap2/pm-debug.c
+++ b/arch/arm/mach-omap2/pm-debug.c
@@ -53,21 +53,6 @@ enum {
 	DEBUG_FILE_TIMERS,
 };
 
-void pm_dbg_update_time(struct powerdomain *pwrdm, int prev)
-{
-	s64 t;
-
-	if (!pm_dbg_init_done)
-		return ;
-
-	/* Update timer for previous state */
-	t = sched_clock();
-
-	pwrdm->fpwrst_timer[prev - PWRDM_FPWRST_OFFSET] += t - pwrdm->timer;
-
-	pwrdm->timer = t;
-}
-
 static int clkdm_dbg_show_counter(struct clockdomain *clkdm, void *user)
 {
 	struct seq_file *s = (struct seq_file *)user;
@@ -197,17 +182,8 @@ DEFINE_SIMPLE_ATTRIBUTE(pwrdm_suspend_fops, pwrdm_suspend_get,
 
 static int __init pwrdms_setup(struct powerdomain *pwrdm, void *dir)
 {
-	int i;
-	s64 t;
 	struct dentry *d;
 
-	t = sched_clock();
-
-	for (i = 0; i < PWRDM_FPWRSTS_COUNT; i++)
-		pwrdm->fpwrst_timer[i] = 0;
-
-	pwrdm->timer = t;
-
 	if (strncmp(pwrdm->name, "dpll", 4) == 0)
 		return 0;
 
diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
index 19ef376..c496f27 100644
--- a/arch/arm/mach-omap2/pm.h
+++ b/arch/arm/mach-omap2/pm.h
@@ -59,12 +59,6 @@ extern u32 enable_off_mode;
 #define enable_off_mode 0
 #endif
 
-#if defined(CONFIG_PM_DEBUG) && defined(CONFIG_DEBUG_FS)
-extern void pm_dbg_update_time(struct powerdomain *pwrdm, int prev);
-#else
-#define pm_dbg_update_time(pwrdm, prev) do {} while (0);
-#endif /* CONFIG_PM_DEBUG */
-
 /* 24xx */
 extern void omap24xx_idle_loop_suspend(void);
 extern unsigned int omap24xx_idle_loop_suspend_sz;
diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
index b67d721..53bc852 100644
--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -20,6 +20,8 @@
 #include <linux/errno.h>
 #include <linux/string.h>
 #include <linux/spinlock.h>
+#include <linux/sched.h>
+
 #include <trace/events/power.h>
 
 #include "cm2xxx_3xxx.h"
@@ -126,6 +128,9 @@ static int _pwrdm_register(struct powerdomain *pwrdm)
 	arch_pwrdm->pwrdm_wait_transition(pwrdm);
 	pwrdm->fpwrst = pwrdm_read_fpwrst(pwrdm);
 	pwrdm->fpwrst_counter[pwrdm->fpwrst - PWRDM_FPWRST_OFFSET] = 1;
+#ifdef CONFIG_PM_DEBUG
+	pwrdm->timer = sched_clock();
+#endif
 
 	return 0;
 }
@@ -579,6 +584,21 @@ static int _pwrdm_set_mem_retst(struct powerdomain *pwrdm, u8 bank, u8 pwrst)
 	return ret;
 }
 
+/* XXX prev is wrong type */
+/* XXX is sched_clock() correct to use here? */
+/* Update timer for previous state */
+static void _pwrdm_update_pwrst_time(struct powerdomain *pwrdm, int prev)
+{
+#ifdef CONFIG_PM_DEBUG
+	s64 t;
+
+	t = sched_clock();
+
+	pwrdm->fpwrst_timer[prev - PWRDM_FPWRST_OFFSET] += t - pwrdm->timer;
+
+	pwrdm->timer = t;
+#endif
+}
 
 /* XXX Caller must hold pwrdm->_lock */
 static int _pwrdm_state_switch(struct powerdomain *pwrdm, int flag)
@@ -617,7 +637,7 @@ static int _pwrdm_state_switch(struct powerdomain *pwrdm, int flag)
 	if (fpwrst != prev)
 		pwrdm->fpwrst_counter[fpwrst - PWRDM_FPWRST_OFFSET]++;
 
-	pm_dbg_update_time(pwrdm, prev);
+	_pwrdm_update_pwrst_time(pwrdm, prev);
 
 	pwrdm->fpwrst = fpwrst;
 



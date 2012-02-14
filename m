From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 6/6] arm: omap: pm-debug: enhanced usecount debug support
Date: Tue, 14 Feb 2012 18:36:42 +0200
Message-ID: <1329237402-26008-7-git-send-email-t-kristo@ti.com>
References: <1329237402-26008-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:49335 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756747Ab2BNQug (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 14 Feb 2012 11:50:36 -0500
In-Reply-To: <1329237402-26008-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, khilman@ti.com
Cc: linux-arm-kernel@lists.infradead.org

Voltdm, pwrdm, clkdm, hwmod and clk usecounts are now separeted to
their own file, 'usecount'. This file shows the usecounts for every
active domain and their children recursively. 'count' file now only
shows power state counts for powerdomains.

This patch also provices a way to do printk dumps from kernel code,
by calling the pm_dbg_dump_X functions. The plan is to call these
functions once an error condition is detected, e.g. failed suspend.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/pm-debug.c |  128 ++++++++++++++++++++++++++++++++++------
 arch/arm/mach-omap2/pm.h       |    6 ++
 2 files changed, 115 insertions(+), 19 deletions(-)

diff --git a/arch/arm/mach-omap2/pm-debug.c b/arch/arm/mach-omap2/pm-debug.c
index 4411163..444588e 100644
--- a/arch/arm/mach-omap2/pm-debug.c
+++ b/arch/arm/mach-omap2/pm-debug.c
@@ -51,6 +51,7 @@ static int pm_dbg_init(void);
 enum {
 	DEBUG_FILE_COUNTERS = 0,
 	DEBUG_FILE_TIMERS,
+	DEBUG_FILE_USECOUNT,
 };
 
 static const char pwrdm_state_names[][PWRDM_MAX_PWRSTS] = {
@@ -75,23 +76,6 @@ void pm_dbg_update_time(struct powerdomain *pwrdm, int prev)
 	pwrdm->timer = t;
 }
 
-static int clkdm_dbg_show_counter(struct clockdomain *clkdm, void *user)
-{
-	struct seq_file *s = (struct seq_file *)user;
-
-	if (strcmp(clkdm->name, "emu_clkdm") == 0 ||
-		strcmp(clkdm->name, "wkup_clkdm") == 0 ||
-		strncmp(clkdm->name, "dpll", 4) == 0)
-		return 0;
-
-	seq_printf(s, "%s->%s (%d)", clkdm->name,
-			clkdm->pwrdm.ptr->name,
-			atomic_read(&clkdm->usecount));
-	seq_printf(s, "\n");
-
-	return 0;
-}
-
 static int pwrdm_dbg_show_counter(struct powerdomain *pwrdm, void *user)
 {
 	struct seq_file *s = (struct seq_file *)user;
@@ -145,11 +129,112 @@ static int pwrdm_dbg_show_timer(struct powerdomain *pwrdm, void *user)
 	return 0;
 }
 
+static struct voltagedomain *parent_voltdm;
+static struct powerdomain *parent_pwrdm;
+static struct clockdomain *parent_clkdm;
+
+#define PM_DBG_PRINT(s, fmt, args...)			\
+	{						\
+		if (s)					\
+			seq_printf(s, fmt, ## args);	\
+		else					\
+			pr_info(fmt, ## args);		\
+	}
+
+static int _pm_dbg_dump_clk(struct clk *clk, void *user)
+{
+	struct seq_file *s = user;
+
+	if (clk->clkdm == parent_clkdm && clk->usecount && !clk->autoidle)
+		PM_DBG_PRINT(s, "      ck:%s: %d\n", clk->name, clk->usecount);
+
+	return 0;
+}
+
+static int _pm_dbg_dump_hwmod(struct omap_hwmod *oh, void *user)
+{
+	struct seq_file *s = user;
+
+	if (oh->clkdm != parent_clkdm)
+		return 0;
+
+	if (oh->_state != _HWMOD_STATE_ENABLED)
+		return 0;
+
+	PM_DBG_PRINT(s, "      oh:%s: enabled\n", oh->name);
+
+	return 0;
+}
+
+static int _pm_dbg_dump_clkdm(struct clockdomain *clkdm, void *user)
+{
+	struct seq_file *s = user;
+	u32 usecount;
+
+	if (clkdm->pwrdm.ptr == parent_pwrdm) {
+		usecount = atomic_read(&clkdm->usecount);
+		if (usecount) {
+			PM_DBG_PRINT(s, "    cd:%s: %d\n", clkdm->name,
+				usecount);
+			parent_clkdm = clkdm;
+			omap_hwmod_for_each(_pm_dbg_dump_hwmod, s);
+			omap_clk_for_each(_pm_dbg_dump_clk, s);
+		}
+	}
+	return 0;
+}
+
+static int _pm_dbg_dump_pwrdm(struct powerdomain *pwrdm, void *user)
+{
+	struct seq_file *s = user;
+	u32 usecount;
+
+	if (pwrdm->voltdm.ptr == parent_voltdm) {
+		usecount = atomic_read(&pwrdm->usecount);
+		if (usecount) {
+			PM_DBG_PRINT(s, "  pd:%s: %d\n", pwrdm->name, usecount);
+			parent_pwrdm = pwrdm;
+			clkdm_for_each(_pm_dbg_dump_clkdm, s);
+		}
+	}
+	return 0;
+}
+
+void pm_dbg_dump_pwrdm(struct powerdomain *pwrdm)
+{
+	pr_info("pd:%s: %d\n", pwrdm->name, atomic_read(&pwrdm->usecount));
+	parent_pwrdm = pwrdm;
+	clkdm_for_each(_pm_dbg_dump_clkdm, NULL);
+}
+
+void pm_dbg_dump_voltdm(struct voltagedomain *voltdm)
+{
+	pr_info("vd:%s: %d\n", voltdm->name, atomic_read(&voltdm->usecount));
+	parent_voltdm = voltdm;
+	pwrdm_for_each(_pm_dbg_dump_pwrdm, NULL);
+}
+
+static int _voltdm_dbg_show_counters(struct voltagedomain *voltdm, void *user)
+{
+	struct seq_file *s = user;
+
+	seq_printf(s, "vd:%s: %d\n", voltdm->name,
+		atomic_read(&voltdm->usecount));
+
+	parent_voltdm = voltdm;
+	pwrdm_for_each(_pm_dbg_dump_pwrdm, s);
+	return 0;
+}
+
+static int pm_dbg_show_usecount(struct seq_file *s, void *unused)
+{
+	voltdm_for_each(_voltdm_dbg_show_counters, s);
+	return 0;
+}
+
 static int pm_dbg_show_counters(struct seq_file *s, void *unused)
 {
 	pwrdm_for_each(pwrdm_dbg_show_counter, s);
-	clkdm_for_each(clkdm_dbg_show_counter, s);
-
 	return 0;
 }
 
@@ -162,6 +247,9 @@ static int pm_dbg_show_timers(struct seq_file *s, void *unused)
 static int pm_dbg_open(struct inode *inode, struct file *file)
 {
 	switch ((int)inode->i_private) {
+	case DEBUG_FILE_USECOUNT:
+		return single_open(file, pm_dbg_show_usecount,
+			&inode->i_private);
 	case DEBUG_FILE_COUNTERS:
 		return single_open(file, pm_dbg_show_counters,
 			&inode->i_private);
@@ -271,6 +359,8 @@ static int __init pm_dbg_init(void)
 		d, (void *)DEBUG_FILE_COUNTERS, &debug_fops);
 	(void) debugfs_create_file("time", S_IRUGO,
 		d, (void *)DEBUG_FILE_TIMERS, &debug_fops);
+	(void) debugfs_create_file("usecount", S_IRUGO,
+		d, (void *)DEBUG_FILE_USECOUNT, &debug_fops);
 
 	pwrdm_for_each(pwrdms_setup, (void *)d);
 
diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
index b737b11..ec8f874 100644
--- a/arch/arm/mach-omap2/pm.h
+++ b/arch/arm/mach-omap2/pm.h
@@ -61,10 +61,16 @@ inline void omap3_pm_init_cpuidle(struct cpuidle_params *cpuidle_board_params)
 extern int omap3_pm_get_suspend_state(struct powerdomain *pwrdm);
 extern int omap3_pm_set_suspend_state(struct powerdomain *pwrdm, int state);
 
+struct clk;
+
 #ifdef CONFIG_PM_DEBUG
 extern u32 enable_off_mode;
+extern void pm_dbg_dump_pwrdm(struct powerdomain *pwrdm);
+extern void pm_dbg_dump_voltdm(struct voltagedomain *voltdm);
 #else
 #define enable_off_mode 0
+static inline void pm_dbg_dump_pwrdm(struct powerdomain *pwrdm) { }
+static inline void pm_dbg_dump_voltdm(struct voltagedomain *voltdm) { }
 #endif
 
 #if defined(CONFIG_PM_DEBUG) && defined(CONFIG_DEBUG_FS)
-- 
1.7.4.1


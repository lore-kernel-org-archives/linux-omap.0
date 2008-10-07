From: "Peter 'p2' De Schrijver" <peter.de-schrijver@nokia.com>
Subject: [PATCH 2/3] Add pm-debug counters
Date: Tue,  7 Oct 2008 16:33:15 +0300
Message-ID: <1223386396-29560-3-git-send-email-peter.de-schrijver@nokia.com>
References: <1223386396-29560-1-git-send-email-peter.de-schrijver@nokia.com>
 <1223386396-29560-2-git-send-email-peter.de-schrijver@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:25276 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753499AbYJGNdv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Oct 2008 09:33:51 -0400
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m97DXPrX005627
	for <linux-omap@vger.kernel.org>; Tue, 7 Oct 2008 16:33:48 +0300
In-Reply-To: <1223386396-29560-2-git-send-email-peter.de-schrijver@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>


Signed-off-by: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
---
 arch/arm/mach-omap2/pm-debug.c                |  153 ++++++++++++-------------
 arch/arm/mach-omap2/pm.h                      |   19 +---
 arch/arm/plat-omap/include/mach/powerdomain.h |   14 ++-
 3 files changed, 87 insertions(+), 99 deletions(-)

diff --git a/arch/arm/mach-omap2/pm-debug.c b/arch/arm/mach-omap2/pm-debug.c
index 380a2a0..64d40c4 100644
--- a/arch/arm/mach-omap2/pm-debug.c
+++ b/arch/arm/mach-omap2/pm-debug.c
@@ -167,8 +167,8 @@ struct dentry *pm_dbg_dir;
 static int pm_dbg_init_done;
 
 enum {
-	PM_DBG_STATE_NOW = 0,
-	PM_DBG_STATE_PREV,
+	DEBUG_FILE_COUNTERS = 0,
+	DEBUG_FILE_TIMERS,
 };
 
 struct pm_module_def {
@@ -218,6 +218,13 @@ static const struct pm_module_def pm_dbg_reg_modules[] = {
 
 static void *pm_dbg_reg_set[PM_DBG_MAX_REG_SETS];
 
+static const char pwrdm_state_names[][4] = {
+	"OFF",
+	"RET",
+	"INA",
+	"ON"
+};
+
 static int pm_dbg_get_regset_size(void)
 {
 	static int regset_size;
@@ -318,107 +325,96 @@ int pm_dbg_regset_save(int reg_set)
 	return 0;
 }
 
-static int _pm_dbg_state_switch(struct powerdomain *pwrdm, int flag)
+void pm_dbg_update_time(struct powerdomain *pwrdm, int prev)
 {
 	s64 t;
 	struct timespec now;
-	int prev;
-	int state;
 
-	if (pwrdm == NULL)
-		return -EINVAL;
+	if (!pm_dbg_init_done)
+		return ;
 
-	state = pwrdm_read_pwrst(pwrdm);
+	/* Update timer for previous state */
+	getnstimeofday(&now);
+	t = timespec_to_ns(&now);
 
-	switch (flag) {
-	case PM_DBG_STATE_NOW:
-		prev = pwrdm->state;
-		break;
-	case PM_DBG_STATE_PREV:
-		prev = pwrdm_read_prev_pwrst(pwrdm);
-		if (pwrdm->state != prev)
-			pwrdm->state_counter[prev]++;
-		break;
-	default:
-		return -EINVAL;
-	}
+	pwrdm->state_timer[prev] += t - pwrdm->timer;
 
-	if (pm_dbg_init_done) {
-		/* Update timer for previous state */
-		getnstimeofday(&now);
-		t = timespec_to_ns(&now);
+	pwrdm->timer = t;
 
-		pwrdm->state_timer[prev] += t - pwrdm->timer;
+}
 
-		pwrdm->timer = t;
+static int clkdm_dbg_show_counter(struct clockdomain *clkdm, void *user)
+{
+	struct seq_file *s = (struct seq_file *)user;
 
-		if (state != prev)
-			pwrdm->state_counter[state]++;
-	}
+	if (strcmp(clkdm->name, "emu_clkdm") == 0 ||
+		strcmp(clkdm->name, "wkup_clkdm") == 0)
+		return 0;
 
-	pwrdm->state = state;
+	seq_printf(s, "%s->%s (%d)", clkdm->name,
+			clkdm->pwrdm.ptr->name,
+			atomic_read(&clkdm->usecount));
+	seq_printf(s, "\n");
 
 	return 0;
 }
 
-int pm_dbg_pwrdm_state_switch(struct powerdomain *pwrdm)
+static int pwrdm_dbg_show_counter(struct powerdomain *pwrdm, void *user)
 {
-	return _pm_dbg_state_switch(pwrdm, PM_DBG_STATE_NOW);
-}
+	struct seq_file *s = (struct seq_file *)user;
+	int i;
 
-int pm_dbg_clkdm_state_switch(struct clockdomain *clkdm)
-{
-	if (clkdm != NULL && clkdm->pwrdm.ptr != NULL) {
-		pwrdm_wait_transition(clkdm->pwrdm.ptr);
-		return pm_dbg_pwrdm_state_switch(clkdm->pwrdm.ptr);
-	}
+	if (strcmp(pwrdm->name, "emu_pwrdm") == 0 ||
+		strcmp(pwrdm->name, "wkup_pwrdm") == 0)
+		return 0;
 
-	return -EINVAL;
-}
+	if (pwrdm->state != pwrdm_read_pwrst(pwrdm))
+		printk(KERN_ERR "pwrdm state mismatch(%s) %d != %d\n",
+			pwrdm->name, pwrdm->state, pwrdm_read_pwrst(pwrdm));
 
-int pm_dbg_clk_state_switch(struct clk *clk)
-{
-	if (clk != NULL && clk->clkdm.ptr != NULL)
-		return pm_dbg_clkdm_state_switch(clk->clkdm.ptr);
-	return -EINVAL;
-}
+	seq_printf(s, "%s (%s)", pwrdm->name,
+			pwrdm_state_names[pwrdm->state]);
+	for (i = 0; i < 4; i++)
+		seq_printf(s, ",%s:%d", pwrdm_state_names[i],
+			pwrdm->state_counter[i]);
 
-static int pm_dbg_pre_suspend_cb(struct powerdomain *pwrdm)
-{
-	pwrdm_clear_all_prev_pwrst(pwrdm);
-	_pm_dbg_state_switch(pwrdm, PM_DBG_STATE_NOW);
-	return 0;
-}
+	seq_printf(s, "\n");
 
-static int pm_dbg_post_suspend_cb(struct powerdomain *pwrdm)
-{
-	_pm_dbg_state_switch(pwrdm, PM_DBG_STATE_PREV);
 	return 0;
 }
 
-int pm_dbg_pre_suspend(void)
+static int pwrdm_dbg_show_timer(struct powerdomain *pwrdm, void *user)
 {
-	pwrdm_for_each(pm_dbg_pre_suspend_cb);
+	struct seq_file *s = (struct seq_file *)user;
+	int i;
+
+	if (strcmp(pwrdm->name, "emu_pwrdm") == 0 ||
+		strcmp(pwrdm->name, "wkup_pwrdm") == 0)
+		return 0;
+
+	pwrdm_state_switch(pwrdm);
+
+	seq_printf(s, "%s (%s)", pwrdm->name,
+		pwrdm_state_names[pwrdm->state]);
+
+	for (i = 0; i < 4; i++)
+		seq_printf(s, ",%s:%lld", pwrdm_state_names[i],
+			pwrdm->state_timer[i]);
+
+	seq_printf(s, "\n");
+
 	return 0;
 }
 
-int pm_dbg_post_suspend(void)
+static void pm_dbg_show_counters(struct seq_file *s, void *unused)
 {
-	pwrdm_for_each(pm_dbg_post_suspend_cb);
-	return 0;
+	pwrdm_for_each(pwrdm_dbg_show_counter, s);
+	clkdm_for_each(clkdm_dbg_show_counter, s);
 }
 
-enum {
-	DEBUG_FILE_COUNTERS = 0,
-	DEBUG_FILE_TIMERS,
-};
-
-int pm_dbg_show_counters(struct seq_file *s, void *unused)
+static void pm_dbg_show_timers(struct seq_file *s, void *unused)
 {
-	pwrdm_dbg_show_counters(s, unused);
-	clkdm_dbg_show_counters(s, unused);
-
-	return 0;
+	pwrdm_for_each(pwrdm_dbg_show_timer, s);
 }
 
 static int pm_dbg_open(struct inode *inode, struct file *file)
@@ -429,7 +425,7 @@ static int pm_dbg_open(struct inode *inode, struct file *file)
 			&inode->i_private);
 	case DEBUG_FILE_TIMERS:
 	default:
-		return single_open(file, pwrdm_dbg_show_timers,
+		return single_open(file, pm_dbg_show_timers,
 			&inode->i_private);
 	};
 }
@@ -489,23 +485,18 @@ int pm_dbg_regset_init(int reg_set)
 	return 0;
 }
 
-static int __init pwrdms_setup(struct powerdomain *pwrdm)
+static int __init pwrdms_setup(struct powerdomain *pwrdm, void *unused)
 {
-	s64 t;
 	int i;
+	s64 t;
 	struct timespec now;
 
 	getnstimeofday(&now);
 	t = timespec_to_ns(&now);
 
-	for (i = 0; i < 4; i++) {
-		pwrdm->state_counter[i] = 0;
+	for (i = 0; i < 4; i++)
 		pwrdm->state_timer[i] = 0;
-	}
 
-	pwrdm_wait_transition(pwrdm);
-	pwrdm->state = pwrdm_read_pwrst(pwrdm);
-	pwrdm->state_counter[pwrdm->state] = 1;
 	pwrdm->timer = t;
 
 	(void) debugfs_create_file(pwrdm->name, S_IRUGO|S_IWUSR,
@@ -535,7 +526,7 @@ static int __init pm_dbg_init(void)
 	if (IS_ERR(pm_dbg_dir))
 		return PTR_ERR(pm_dbg_dir);
 
-	pwrdm_for_each(pwrdms_setup);
+	pwrdm_for_each(pwrdms_setup, NULL);
 
 	pm_dbg_dir = debugfs_create_dir("registers", d);
 	if (IS_ERR(pm_dbg_dir))
diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
index 038931c..55a9cdd 100644
--- a/arch/arm/mach-omap2/pm.h
+++ b/arch/arm/mach-omap2/pm.h
@@ -31,32 +31,21 @@ extern int omap2_pm_debug;
 #define omap2_pm_debug 0
 #endif
 
+extern int set_pwrdm_state(struct powerdomain *pwrdm, u32 state);
+
 #if defined(CONFIG_PM_DEBUG) && defined(CONFIG_DEBUG_FS)
 struct seq_file;
 struct clk;
 struct clockdomain;
 struct powerdomain;
-extern int pm_dbg_pwrdm_state_switch(struct powerdomain *pwrdm);
-extern int pm_dbg_clkdm_state_switch(struct clockdomain *clkdm);
-extern int pm_dbg_clk_state_switch(struct clk *clk);
-extern int pm_dbg_pre_suspend(void);
-extern int pm_dbg_post_suspend(void);
 extern int pm_dbg_regset_save(int reg_set);
 extern int pm_dbg_regset_init(int reg_set);
-extern int pwrdm_dbg_show_counters(struct seq_file *s, void *unused);
-extern int pwrdm_dbg_show_timers(struct seq_file *s, void *unused);
 extern int clkdm_dbg_show_counters(struct seq_file *s, void *unused);
-extern int set_pwrdm_state(struct powerdomain *pwrdm, u32 state);
+extern void pm_dbg_update_time(struct powerdomain *pwrdm, int prev);
 #else
-#define pm_dbg_pwrdm_state_switch(domain) do; while (0)
-#define pm_dbg_clkdm_state_switch(domain) do; while (0)
-#define pm_dbg_clk_state_switch(domain) do; while (0)
-#define pm_dbg_pre_suspend() do; while (0)
-#define pm_dbg_post_suspend() do; while (0)
 #define pm_dbg_regset_save(reg_set) do; while (0)
 #define pm_dbg_regset_init(reg_set) do; while (0)
-#define pwrdm_dbg_show_counters(s,unused) do; while (0)
-#define pwrdm_dbg_show_timers(s,unused) do; while (0)
 #define clkdm_dbg_show_counters(s,unused) do; while (0)
+#define pm_dbg_update_time(pwrdm, prev) do; while (0)
 #endif /* CONFIG_PM_DEBUG */
 #endif
diff --git a/arch/arm/plat-omap/include/mach/powerdomain.h b/arch/arm/plat-omap/include/mach/powerdomain.h
index 1c27d7d..2d6f9a0 100644
--- a/arch/arm/plat-omap/include/mach/powerdomain.h
+++ b/arch/arm/plat-omap/include/mach/powerdomain.h
@@ -74,6 +74,11 @@ struct pwrdm_dep {
 
 	int state;
 	unsigned state_counter[4];
+
+#ifdef CONFIG_PM_DEBUG
+	s64 timer;
+	s64 state_timer[4];
+#endif
 };
 
 struct powerdomain {
@@ -118,9 +123,11 @@ struct powerdomain {
 	struct clockdomain *pwrdm_clkdms[PWRDM_MAX_CLKDMS];
 
 	struct list_head node;
-#ifdef CONFIG_PM_DEBUG
+
 	int state;
-	int state_counter[4];
+	unsigned state_counter[4];
+
+#ifdef CONFIG_PM_DEBUG
 	s64 timer;
 	s64 state_timer[4];
 #endif
@@ -133,7 +140,8 @@ int pwrdm_register(struct powerdomain *pwrdm);
 int pwrdm_unregister(struct powerdomain *pwrdm);
 struct powerdomain *pwrdm_lookup(const char *name);
 
-int pwrdm_for_each(int (*fn)(struct powerdomain *pwrdm));
+int pwrdm_for_each(int (*fn)(struct powerdomain *pwrdm, void *user),
+			void *user);
 
 int pwrdm_add_clkdm(struct powerdomain *pwrdm, struct clockdomain *clkdm);
 int pwrdm_del_clkdm(struct powerdomain *pwrdm, struct clockdomain *clkdm);
-- 
1.5.6.3


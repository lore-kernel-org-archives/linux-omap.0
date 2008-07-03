From: Tero Kristo <tero.kristo@nokia.com>
Subject: [PATCH 2/3] PM debug support for 34xx
Date: Thu,  3 Jul 2008 18:59:15 +0300
Message-ID: <1215100756-31445-3-git-send-email-tero.kristo@nokia.com>
References: <>
 <1215100756-31445-1-git-send-email-tero.kristo@nokia.com>
 <1215100756-31445-2-git-send-email-tero.kristo@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:41776 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761603AbYGCOAN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Jul 2008 10:00:13 -0400
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m63DwwaF015143
	for <linux-omap@vger.kernel.org>; Thu, 3 Jul 2008 09:00:12 -0500
Received: from localhost.localdomain (sokoban.ntc.nokia.com [172.22.144.95])
	by mgw-int02.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id m63Dxh3f018829
	for <linux-omap@vger.kernel.org>; Thu, 3 Jul 2008 16:59:46 +0300
In-Reply-To: <1215100756-31445-2-git-send-email-tero.kristo@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

This patch adds a few files to the debug file system for PM debugging
purposes. Enabled with kernel config options CONFIG_PM_DEBUG and
CONFIG_DEBUG_FS. Data available in debug filesystem after this patch:
- State enter counters for power domains (OFF, RET, ON)
- State timers for the above (in ns)
- PM register dumps with programmable save points

This patch depends on the PM workaround set from Jouni Hogander.

Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
---
 arch/arm/mach-omap2/clockdomain.c       |   38 ++++
 arch/arm/mach-omap2/pm-debug.c          |  365 +++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/pm.c                |    2 +
 arch/arm/mach-omap2/pm.h                |   18 ++
 arch/arm/mach-omap2/pm34xx.c            |    4 +
 arch/arm/mach-omap2/powerdomain.c       |   65 ++++++
 arch/arm/mach-omap2/serial.c            |    1 -
 include/asm-arm/arch-omap/powerdomain.h |    7 +-
 8 files changed, 498 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/clockdomain.c b/arch/arm/mach-omap2/clockdomain.c
index 6e5f892..c3c398e 100644
--- a/arch/arm/mach-omap2/clockdomain.c
+++ b/arch/arm/mach-omap2/clockdomain.c
@@ -36,6 +36,12 @@
 #include <asm/arch/powerdomain.h>
 #include <asm/arch/clockdomain.h>
 
+#if defined(CONFIG_PM_DEBUG) && defined(CONFIG_DEBUG_FS)
+#include <linux/debugfs.h>
+#include <linux/seq_file.h>
+#include "pm.h"
+#endif
+
 /* clkdm_list contains all registered struct clockdomains */
 static LIST_HEAD(clkdm_list);
 
@@ -567,6 +573,13 @@ int omap2_clkdm_clk_enable(struct clockdomain *clkdm, struct clk *clk)
 	else
 		omap2_clkdm_wakeup(clkdm);
 
+#ifdef CONFIG_PM_DEBUG
+	if (clkdm != NULL && clkdm->pwrdm != NULL) {
+		pwrdm_wait_transition(clkdm->pwrdm);
+		pm_dbg_state_switch(clkdm->pwrdm);
+	}
+#endif
+
 	return 0;
 }
 
@@ -618,6 +631,31 @@ int omap2_clkdm_clk_disable(struct clockdomain *clkdm, struct clk *clk)
 	else
 		omap2_clkdm_sleep(clkdm);
 
+#ifdef CONFIG_PM_DEBUG
+	if (clkdm != NULL && clkdm->pwrdm != NULL) {
+		pwrdm_wait_transition(clkdm->pwrdm);
+		pm_dbg_state_switch(clkdm->pwrdm);
+	}
+#endif
+
 	return 0;
 }
 
+#if defined(CONFIG_PM_DEBUG) && defined(CONFIG_DEBUG_FS)
+int clkdm_dbg_show_counters(struct seq_file *s, void *unused)
+{
+	struct clockdomain *clkdm;
+
+	list_for_each_entry(clkdm, &clkdm_list, node) {
+		if (strcmp(clkdm->name, "emu_clkdm") == 0 ||
+			strcmp(clkdm->name, "wkup_clkdm") == 0)
+			continue;
+		seq_printf(s, "%s->%s (%d)", clkdm->name, clkdm->pwrdm_name,
+			atomic_read(&clkdm->usecount));
+		seq_printf(s, "\n");
+	}
+
+	return 0;
+}
+
+#endif
diff --git a/arch/arm/mach-omap2/pm-debug.c b/arch/arm/mach-omap2/pm-debug.c
index 61d4501..b6f8621 100644
--- a/arch/arm/mach-omap2/pm-debug.c
+++ b/arch/arm/mach-omap2/pm-debug.c
@@ -30,6 +30,8 @@
 #include <asm/arch/clock.h>
 #include <asm/arch/board.h>
 
+#include <asm/arch/powerdomain.h>
+#include <asm/arch/common.h>
 #include "prm.h"
 #include "cm.h"
 #include "pm.h"
@@ -153,4 +155,367 @@ void omap2_pm_dump(int mode, int resume, unsigned int us)
 		printk("%-20s: 0x%08x\n", regs[i].name, regs[i].val);
 }
 
+#ifdef CONFIG_DEBUG_FS
+#include <linux/debugfs.h>
+#include <linux/seq_file.h>
+
+static void pm_dbg_regset_store(u32 *ptr);
+
+struct dentry *pm_dbg_reg_dir;
+
+static int pm_dbg_init_done;
+
+enum {
+	PM_DBG_STATE_NOW = 0,
+	PM_DBG_STATE_PREV,
+};
+
+struct pm_module_def {
+	char name[8]; /* Name of the module */
+	short type; /* CM or PRM */
+	unsigned short offset;
+	int low; /* First register address on this module */
+	int high; /* Last register address on this module */
+};
+
+#define MOD_CM 0
+#define MOD_PRM 1
+
+static const struct pm_module_def pm_dbg_reg_modules[] = {
+	{ "OCP", MOD_CM, OCP_MOD, 0, 0x10 },
+	{ "MPU", MOD_CM, MPU_MOD, 4, 0x4c },
+	{ "CORE", MOD_CM, CORE_MOD, 0, 0x4c },
+	{ "NEON", MOD_CM, OMAP3430_NEON_MOD, 0x20, 0x48 },
+	{ "WKUP", MOD_CM, WKUP_MOD, 0, 0x40 },
+	{ "EMU", MOD_CM, OMAP3430_EMU_MOD, 0x40, 0x54 },
+	{ "CCR", MOD_CM, PLL_MOD, 0, 0x70 },
+	{ "DSS", MOD_CM, OMAP3430_DSS_MOD, 0, 0x4c },
+	{ "PER", MOD_CM, OMAP3430_PER_MOD, 0, 0x4c },
+	{ "USB", MOD_CM, OMAP3430ES2_USBHOST_MOD, 0, 0x4c },
+
+	{ "OCP", MOD_PRM, OCP_MOD, 0x1c },
+	{ "MPU", MOD_PRM, MPU_MOD, 0x58, 0xe8 },
+	{ "CORE", MOD_PRM, CORE_MOD, 0x58, 0xf8 },
+	{ "NEON", MOD_PRM, OMAP3430_NEON_MOD, 0x58, 0xe8 },
+	{ "WKUP", MOD_PRM, WKUP_MOD, 0xa0, 0xb0 },
+	{ "EMU", MOD_PRM, OMAP3430_EMU_MOD, 0x58, 0xe4 },
+	{ "CCR", MOD_PRM, PLL_MOD, 0x40, 0x70 },
+	{ "DSS", MOD_PRM, OMAP3430_DSS_MOD, 0x58, 0xe8 },
+	{ "PER", MOD_PRM, OMAP3430_PER_MOD, 0x58, 0xe8 },
+	{ "USB", MOD_PRM, OMAP3430ES2_USBHOST_MOD, 0x58, 0xe8 },
+	{ "", 0, 0, 0, 0 },
+};
+
+#define PM_DBG_MAX_REG_SETS 4
+
+static void *pm_dbg_reg_set[PM_DBG_MAX_REG_SETS];
+
+static int pm_dbg_get_regset_size(void)
+{
+	static int regset_size;
+
+	if (regset_size == 0) {
+		int i = 0;
+
+		while (pm_dbg_reg_modules[i].name[0] != 0) {
+			regset_size += pm_dbg_reg_modules[i].high +
+				4 - pm_dbg_reg_modules[i].low;
+			i++;
+		}
+	}
+	return regset_size;
+}
+
+static int pm_dbg_show_regs(struct seq_file *s, void *unused)
+{
+	int i, j;
+	unsigned long val;
+	int reg_set = (int)s->private;
+	u32 *ptr;
+	void *store = NULL;
+	int regs;
+
+	if (reg_set == 0) {
+		store = kmalloc(pm_dbg_get_regset_size(), GFP_KERNEL);
+		ptr = store;
+		pm_dbg_regset_store(ptr);
+	} else {
+		ptr = pm_dbg_reg_set[reg_set - 1];
+	}
+
+	i = 0;
+
+	while (pm_dbg_reg_modules[i].name[0] != 0) {
+		regs = 0;
+		if (pm_dbg_reg_modules[i].type == MOD_CM)
+			seq_printf(s, "MOD: CM_%s (%08x)\n",
+				pm_dbg_reg_modules[i].name,
+				(u32)(OMAP2_CM_BASE +
+				pm_dbg_reg_modules[i].offset));
+		else
+			seq_printf(s, "MOD: PRM_%s (%08x)\n",
+				pm_dbg_reg_modules[i].name,
+				(u32)(OMAP2_PRM_BASE +
+				pm_dbg_reg_modules[i].offset));
+
+		for (j = pm_dbg_reg_modules[i].low;
+			j <= pm_dbg_reg_modules[i].high; j += 4) {
+			val = *(ptr++);
+			if (val != 0) {
+				regs++;
+				seq_printf(s, "  %02x => %08lx", j, val);
+				if (regs % 4 == 0)
+					seq_printf(s, "\n");
+			}
+		}
+		seq_printf(s, "\n");
+		i++;
+	}
+
+	if (store != NULL)
+		kfree(store);
+
+	return 0;
+}
+
+static void pm_dbg_regset_store(u32 *ptr)
+{
+	int i, j;
+	u32 val;
+
+	i = 0;
+
+	while (pm_dbg_reg_modules[i].name[0] != 0) {
+		for (j = pm_dbg_reg_modules[i].low;
+			j <= pm_dbg_reg_modules[i].high; j += 4) {
+			if (pm_dbg_reg_modules[i].type == MOD_CM)
+				val = cm_read_mod_reg(
+					pm_dbg_reg_modules[i].offset, j);
+			else
+				val = prm_read_mod_reg(
+					pm_dbg_reg_modules[i].offset, j);
+			*(ptr++) = val;
+		}
+		i++;
+	}
+}
+
+int pm_dbg_regset_save(int reg_set)
+{
+	if (pm_dbg_reg_set[reg_set-1] == NULL)
+		return -EINVAL;
+
+	pm_dbg_regset_store(pm_dbg_reg_set[reg_set-1]);
+
+	return 0;
+}
+
+static int _pm_dbg_state_switch(struct powerdomain *pwrdm, int flag)
+{
+	s64 t;
+	struct timespec now;
+	int prev;
+	int state;
+
+	if (pwrdm == NULL)
+		return -EINVAL;
+
+	state = pwrdm_read_pwrst(pwrdm);
+
+	switch (flag) {
+	case PM_DBG_STATE_NOW:
+		prev = pwrdm->state;
+		break;
+	case PM_DBG_STATE_PREV:
+		prev = pwrdm_read_prev_pwrst(pwrdm);
+		if (pwrdm->state != prev)
+			pwrdm->state_counter[prev]++;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (pm_dbg_init_done) {
+		/* Update timer for previous state */
+		getnstimeofday(&now);
+		t = timespec_to_ns(&now);
+
+		pwrdm->state_timer[prev] += t - pwrdm->timer;
+
+		pwrdm->timer = t;
+
+		if (state != prev)
+			pwrdm->state_counter[state]++;
+	}
+
+	pwrdm->state = state;
+
+	return 0;
+}
+
+int pm_dbg_state_switch(struct powerdomain *pwrdm)
+{
+	return _pm_dbg_state_switch(pwrdm, PM_DBG_STATE_NOW);
+}
+
+static int pm_dbg_pre_suspend_cb(struct powerdomain *pwrdm)
+{
+	pwrdm_clear_all_prev_pwrst(pwrdm);
+	_pm_dbg_state_switch(pwrdm, PM_DBG_STATE_NOW);
+	return 0;
+}
+
+static int pm_dbg_post_suspend_cb(struct powerdomain *pwrdm)
+{
+	_pm_dbg_state_switch(pwrdm, PM_DBG_STATE_PREV);
+	return 0;
+}
+
+int pm_dbg_pre_suspend(void)
+{
+	pwrdm_for_each(pm_dbg_pre_suspend_cb);
+	return 0;
+}
+
+int pm_dbg_post_suspend(void)
+{
+	pwrdm_for_each(pm_dbg_post_suspend_cb);
+	return 0;
+}
+
+enum {
+	DEBUG_FILE_COUNTERS = 0,
+	DEBUG_FILE_TIMERS,
+};
+
+int pm_dbg_show_counters(struct seq_file *s, void *unused)
+{
+	pwrdm_dbg_show_counters(s, unused);
+	clkdm_dbg_show_counters(s, unused);
+
+	return 0;
+}
+
+static int pm_dbg_open(struct inode *inode, struct file *file)
+{
+	switch ((int)inode->i_private) {
+	case DEBUG_FILE_COUNTERS:
+		return single_open(file, pm_dbg_show_counters,
+			&inode->i_private);
+	case DEBUG_FILE_TIMERS:
+	default:
+		return single_open(file, pwrdm_dbg_show_timers,
+			&inode->i_private);
+	};
+}
+
+static int pm_dbg_reg_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, pm_dbg_show_regs, inode->i_private);
+}
+
+static const struct file_operations debug_fops = {
+	.open           = pm_dbg_open,
+	.read           = seq_read,
+	.llseek         = seq_lseek,
+	.release        = single_release,
+};
+
+static const struct file_operations debug_reg_fops = {
+	.open           = pm_dbg_reg_open,
+	.read           = seq_read,
+	.llseek         = seq_lseek,
+	.release        = single_release,
+};
+
+int pm_dbg_regset_init(int reg_set)
+{
+	char name[2];
+
+	if (reg_set < 1 || reg_set > PM_DBG_MAX_REG_SETS ||
+		pm_dbg_reg_set[reg_set-1] != NULL)
+		return -EINVAL;
+
+	pm_dbg_reg_set[reg_set-1] =
+		kmalloc(pm_dbg_get_regset_size(), GFP_KERNEL);
+
+	if (pm_dbg_reg_set[reg_set-1] == NULL)
+		return -ENOMEM;
+
+	if (pm_dbg_reg_dir != NULL) {
+		sprintf(name, "%d", reg_set);
+
+		(void) debugfs_create_file(name, S_IRUGO,
+			pm_dbg_reg_dir, (void *)reg_set, &debug_reg_fops);
+	}
+
+	return 0;
+}
+
+static int __init pwrdms_setup(struct powerdomain *pwrdm)
+{
+	s64 t;
+	int i;
+	struct timespec now;
+
+	getnstimeofday(&now);
+	t = timespec_to_ns(&now);
+
+	for (i = 0; i < 4; i++) {
+		pwrdm->state_counter[i] = 0;
+		pwrdm->state_timer[i] = 0;
+	}
+
+	pwrdm_wait_transition(pwrdm);
+	pwrdm->state = pwrdm_read_pwrst(pwrdm);
+	pwrdm->state_counter[pwrdm->state] = 1;
+	pwrdm->timer = t;
+
+	return 0;
+}
+
+static int __init pm_dbg_init(void)
+{
+	int i;
+	struct dentry *d;
+	char name[2];
+
+	printk(KERN_INFO "pm_dbg_init()\n");
+
+	d = debugfs_create_dir("pm_debug", NULL);
+	if (IS_ERR(d))
+		return PTR_ERR(d);
+
+	(void) debugfs_create_file("count", S_IRUGO,
+		d, (void *)DEBUG_FILE_COUNTERS, &debug_fops);
+	(void) debugfs_create_file("time", S_IRUGO,
+		d, (void *)DEBUG_FILE_TIMERS, &debug_fops);
+
+	if (pm_dbg_reg_dir == NULL) {
+		d = debugfs_create_dir("registers", d);
+		if (IS_ERR(d))
+			return PTR_ERR(d);
+		pm_dbg_reg_dir = d;
+	}
+
+	(void) debugfs_create_file("current", S_IRUGO,
+		pm_dbg_reg_dir, (void *)0, &debug_reg_fops);
+
+	pwrdm_for_each(pwrdms_setup);
+
+	for (i = 0; i < PM_DBG_MAX_REG_SETS; i++)
+		if (pm_dbg_reg_set[i] != NULL) {
+			sprintf(name, "%d", i+1);
+			(void) debugfs_create_file(name, S_IRUGO,
+				pm_dbg_reg_dir, (void *)(i+1), &debug_reg_fops);
+
+		}
+
+	pm_dbg_init_done = 1;
+
+	return 0;
+}
+late_initcall(pm_dbg_init);
+#endif
+
 #endif
diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
index b7434df..02de739 100644
--- a/arch/arm/mach-omap2/pm.c
+++ b/arch/arm/mach-omap2/pm.c
@@ -28,6 +28,8 @@
 #include <asm/mach/time.h>
 #include <asm/atomic.h>
 
+#include <asm/arch/powerdomain.h>
+
 #include "pm.h"
 
 unsigned short enable_dyn_sleep;
diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
index 4f1f90c..4bccc5b 100644
--- a/arch/arm/mach-omap2/pm.h
+++ b/arch/arm/mach-omap2/pm.h
@@ -30,8 +30,26 @@ extern atomic_t sleep_block;
 #ifdef CONFIG_PM_DEBUG
 extern void omap2_pm_dump(int mode, int resume, unsigned int us);
 extern int omap2_pm_debug;
+extern int pm_dbg_state_switch(struct powerdomain *pwrdm);
+extern int pm_dbg_pre_suspend(void);
+extern int pm_dbg_post_suspend(void);
+extern int pm_dbg_regset_save(int reg_set);
+extern int pm_dbg_regset_init(int reg_set);
+#ifdef CONFIG_DEBUG_FS
+extern int pwrdm_dbg_show_counters(struct seq_file *s, void *unused);
+extern int pwrdm_dbg_show_timers(struct seq_file *s, void *unused);
+extern int clkdm_dbg_show_counters(struct seq_file *s, void *unused);
+#endif
 #else
 #define omap2_pm_dump(mode,resume,us) do; while(0)
 #define omap2_pm_debug 0
+#define pm_dbg_state_switch(domain) do; while (0)
+#define pm_dbg_pre_suspend() do; while (0)
+#define pm_dbg_post_suspend() do; while (0)
+#define pm_dbg_regset_save(reg_set) do; while(0)
+#define pm_dbg_regset_init(reg_set) do; while(0)
+#define pwrdm_dbg_show_counters(s,unused) do; while (0)
+#define pwrdm_dbg_show_timers(s,unused) do; while (0)
+#define clkdm_dbg_show_counters(s,unused) do; while (0)
 #endif /* CONFIG_PM_DEBUG */
 #endif
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index ff9890a..4bb562c 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -255,6 +255,8 @@ void omap_sram_idle(void)
 		return;
 	}
 
+	pm_dbg_pre_suspend();
+
 	omap3_save_core_ctx();
 	omap3_save_prcm_ctx();
 
@@ -292,6 +294,8 @@ void omap_sram_idle(void)
 	omap3_restore_per_ctx();
 
 	omap2_gpio_resume_after_retention();
+
+	pm_dbg_post_suspend();
 }
 
 static int omap3_fclks_active(void)
diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
index 7615f9d..3da5554 100644
--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -1110,4 +1110,69 @@ int pwrdm_wait_transition(struct powerdomain *pwrdm)
 	return 0;
 }
 
+#if defined(CONFIG_PM_DEBUG) && defined(CONFIG_DEBUG_FS)
 
+#include <linux/debugfs.h>
+#include <linux/seq_file.h>
+#include "pm.h"
+
+static const char pwrdm_state_names[][4] = {
+	"OFF",
+	"RET",
+	"INA",
+	"ON"
+};
+
+int pwrdm_dbg_show_counters(struct seq_file *s, void *unused)
+{
+	int i;
+	struct powerdomain *pwrdm;
+	unsigned long flags;
+
+	read_lock_irqsave(&pwrdm_rwlock, flags);
+	list_for_each_entry(pwrdm, &pwrdm_list, node) {
+		if (strcmp(pwrdm->name, "emu_pwrdm") == 0 ||
+			strcmp(pwrdm->name, "wkup_pwrdm") == 0)
+			continue;
+		seq_printf(s, "%s (%s)", pwrdm->name,
+			pwrdm_state_names[pwrdm->state]);
+		for (i = 0; i < 4; i++) {
+			seq_printf(s, ",%s:%d", pwrdm_state_names[i],
+				pwrdm->state_counter[i]);
+		}
+		seq_printf(s, "\n");
+	}
+	read_unlock_irqrestore(&pwrdm_rwlock, flags);
+
+	return 0;
+}
+
+int pwrdm_dbg_show_timers(struct seq_file *s, void *unused)
+{
+	int i;
+	struct powerdomain *pwrdm;
+	unsigned long flags;
+
+	read_lock_irqsave(&pwrdm_rwlock, flags);
+	list_for_each_entry(pwrdm, &pwrdm_list, node) {
+		if (strcmp(pwrdm->name, "emu_pwrdm") == 0 ||
+			strcmp(pwrdm->name, "wkup_pwrdm") == 0)
+			continue;
+
+		/* Update timer for current state */
+		pm_dbg_state_switch(pwrdm);
+
+		seq_printf(s, "%s (%s)", pwrdm->name,
+			pwrdm_state_names[pwrdm->state]);
+		for (i = 0; i < 4; i++) {
+			seq_printf(s, ",%s:%lld", pwrdm_state_names[i],
+				pwrdm->state_timer[i]);
+		}
+		seq_printf(s, "\n");
+	}
+	read_unlock_irqrestore(&pwrdm_rwlock, flags);
+
+	return 0;
+}
+
+#endif
diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index c222e77..b49bc41 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -26,7 +26,6 @@
 #include <asm/arch/control.h>
 
 #include "prm.h"
-#include "pm.h"
 
 #define SERIAL_AWAKE_TIME 5
 
diff --git a/include/asm-arm/arch-omap/powerdomain.h b/include/asm-arm/arch-omap/powerdomain.h
index 0e79459..7cae592 100644
--- a/include/asm-arm/arch-omap/powerdomain.h
+++ b/include/asm-arm/arch-omap/powerdomain.h
@@ -116,7 +116,12 @@ struct powerdomain {
 	struct clockdomain *pwrdm_clkdms[PWRDM_MAX_CLKDMS];
 
 	struct list_head node;
-
+#ifdef CONFIG_PM_DEBUG
+	int state;
+	int state_counter[4];
+	s64 timer;
+	s64 state_timer[4];
+#endif
 };
 
 
-- 
1.5.4.3


From: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
Subject: [PATCH 04/10] OMAP: PM: Add pm-debug counters
Date: Thu, 13 Aug 2009 09:52:33 -0700
Message-ID: <1250182359-18830-5-git-send-email-khilman@deeprootsystems.com>
References: <1250182359-18830-1-git-send-email-khilman@deeprootsystems.com>
 <1250182359-18830-2-git-send-email-khilman@deeprootsystems.com>
 <1250182359-18830-3-git-send-email-khilman@deeprootsystems.com>
 <1250182359-18830-4-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-arm-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1250182359-18830-4-git-send-email-khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
Sender: linux-arm-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW@public.gmane.org, linux-arm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Peter 'p2' De Schrijver <peter.de-schrijver-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, Tero Kristo <tero.kristo-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

From: Peter 'p2' De Schrijver <peter.de-schrijver-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>

This patch provides the debugfs entries and a function which will be
called by the PM code to register the time spent per domain per
state. Also some new fields are added to the powerdomain struct to
keep the time information.

NOTE: As of v2.6.29, using getnstimeofday() after drivers are
suspended is no longer safe since the timekeeping subsystem is also
suspended as part of the suspend process.  Instead use sched_clock()
which on OMAP returns the 32k SYNC timer in nanoseconds.

Also, do not print out status for meta powerdomains (dpll*)

Signed-off-by: Peter 'p2' De Schrijver <peter.de-schrijver-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Signed-off-by: Tero Kristo <tero.kristo-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Signed-off-by: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
---
 arch/arm/mach-omap2/pm-debug.c                |  178 ++++++++++++++++++++++++-
 arch/arm/mach-omap2/pm.h                      |    4 +
 arch/arm/plat-omap/include/mach/powerdomain.h |    5 +
 3 files changed, 186 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/pm-debug.c b/arch/arm/mach-omap2/pm-debug.c
index 6cc375a..9199c17 100644
--- a/arch/arm/mach-omap2/pm-debug.c
+++ b/arch/arm/mach-omap2/pm-debug.c
@@ -20,13 +20,15 @@
  */
 
 #include <linux/kernel.h>
-#include <linux/timer.h>
+#include <linux/sched.h>
 #include <linux/clk.h>
 #include <linux/err.h>
 #include <linux/io.h>
 
 #include <mach/clock.h>
 #include <mach/board.h>
+#include <mach/powerdomain.h>
+#include <mach/clockdomain.h>
 
 #include "prm.h"
 #include "cm.h"
@@ -150,3 +152,177 @@ void omap2_pm_dump(int mode, int resume, unsigned int us)
 	for (i = 0; i < reg_count; i++)
 		printk(KERN_INFO "%-20s: 0x%08x\n", regs[i].name, regs[i].val);
 }
+
+#ifdef CONFIG_DEBUG_FS
+#include <linux/debugfs.h>
+#include <linux/seq_file.h>
+
+struct dentry *pm_dbg_dir;
+
+static int pm_dbg_init_done;
+
+enum {
+	DEBUG_FILE_COUNTERS = 0,
+	DEBUG_FILE_TIMERS,
+};
+
+static const char pwrdm_state_names[][4] = {
+	"OFF",
+	"RET",
+	"INA",
+	"ON"
+};
+
+void pm_dbg_update_time(struct powerdomain *pwrdm, int prev)
+{
+	s64 t;
+
+	if (!pm_dbg_init_done)
+		return ;
+
+	/* Update timer for previous state */
+	t = sched_clock();
+
+	pwrdm->state_timer[prev] += t - pwrdm->timer;
+
+	pwrdm->timer = t;
+}
+
+static int clkdm_dbg_show_counter(struct clockdomain *clkdm, void *user)
+{
+	struct seq_file *s = (struct seq_file *)user;
+
+	if (strcmp(clkdm->name, "emu_clkdm") == 0 ||
+		strcmp(clkdm->name, "wkup_clkdm") == 0 ||
+		strncmp(clkdm->name, "dpll", 4) == 0)
+		return 0;
+
+	seq_printf(s, "%s->%s (%d)", clkdm->name,
+			clkdm->pwrdm.ptr->name,
+			atomic_read(&clkdm->usecount));
+	seq_printf(s, "\n");
+
+	return 0;
+}
+
+static int pwrdm_dbg_show_counter(struct powerdomain *pwrdm, void *user)
+{
+	struct seq_file *s = (struct seq_file *)user;
+	int i;
+
+	if (strcmp(pwrdm->name, "emu_pwrdm") == 0 ||
+		strcmp(pwrdm->name, "wkup_pwrdm") == 0 ||
+		strncmp(pwrdm->name, "dpll", 4) == 0)
+		return 0;
+
+	if (pwrdm->state != pwrdm_read_pwrst(pwrdm))
+		printk(KERN_ERR "pwrdm state mismatch(%s) %d != %d\n",
+			pwrdm->name, pwrdm->state, pwrdm_read_pwrst(pwrdm));
+
+	seq_printf(s, "%s (%s)", pwrdm->name,
+			pwrdm_state_names[pwrdm->state]);
+	for (i = 0; i < 4; i++)
+		seq_printf(s, ",%s:%d", pwrdm_state_names[i],
+			pwrdm->state_counter[i]);
+
+	seq_printf(s, "\n");
+
+	return 0;
+}
+
+static int pwrdm_dbg_show_timer(struct powerdomain *pwrdm, void *user)
+{
+	struct seq_file *s = (struct seq_file *)user;
+	int i;
+
+	if (strcmp(pwrdm->name, "emu_pwrdm") == 0 ||
+		strcmp(pwrdm->name, "wkup_pwrdm") == 0 ||
+		strncmp(pwrdm->name, "dpll", 4) == 0)
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
+	return 0;
+}
+
+static int pm_dbg_show_counters(struct seq_file *s, void *unused)
+{
+	pwrdm_for_each(pwrdm_dbg_show_counter, s);
+	clkdm_for_each(clkdm_dbg_show_counter, s);
+
+	return 0;
+}
+
+static int pm_dbg_show_timers(struct seq_file *s, void *unused)
+{
+	pwrdm_for_each(pwrdm_dbg_show_timer, s);
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
+		return single_open(file, pm_dbg_show_timers,
+			&inode->i_private);
+	};
+}
+
+static const struct file_operations debug_fops = {
+	.open           = pm_dbg_open,
+	.read           = seq_read,
+	.llseek         = seq_lseek,
+	.release        = single_release,
+};
+
+static int __init pwrdms_setup(struct powerdomain *pwrdm, void *unused)
+{
+	int i;
+	s64 t;
+
+	t = sched_clock();
+
+	for (i = 0; i < 4; i++)
+		pwrdm->state_timer[i] = 0;
+
+	pwrdm->timer = t;
+
+	return 0;
+}
+
+static int __init pm_dbg_init(void)
+{
+	struct dentry *d;
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
+	pwrdm_for_each(pwrdms_setup, NULL);
+
+	pm_dbg_init_done = 1;
+
+	return 0;
+}
+late_initcall(pm_dbg_init);
+
+#else
+void pm_dbg_update_time(struct powerdomain *pwrdm, int prev) {}
+#endif
diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
index 21201cd..4589db1 100644
--- a/arch/arm/mach-omap2/pm.h
+++ b/arch/arm/mach-omap2/pm.h
@@ -11,12 +11,16 @@
 #ifndef __ARCH_ARM_MACH_OMAP2_PM_H
 #define __ARCH_ARM_MACH_OMAP2_PM_H
 
+#include <mach/powerdomain.h>
+
 #ifdef CONFIG_PM_DEBUG
 extern void omap2_pm_dump(int mode, int resume, unsigned int us);
 extern int omap2_pm_debug;
+extern void pm_dbg_update_time(struct powerdomain *pwrdm, int prev);
 #else
 #define omap2_pm_dump(mode, resume, us)		do {} while (0);
 #define omap2_pm_debug				0
+#define pm_dbg_update_time(pwrdm, prev) do {} while (0);
 #endif /* CONFIG_PM_DEBUG */
 
 extern void omap24xx_idle_loop_suspend(void);
diff --git a/arch/arm/plat-omap/include/mach/powerdomain.h b/arch/arm/plat-omap/include/mach/powerdomain.h
index de03f3d..6271d85 100644
--- a/arch/arm/plat-omap/include/mach/powerdomain.h
+++ b/arch/arm/plat-omap/include/mach/powerdomain.h
@@ -119,6 +119,11 @@ struct powerdomain {
 
 	int state;
 	unsigned state_counter[4];
+
+#ifdef CONFIG_PM_DEBUG
+	s64 timer;
+	s64 state_timer[4];
+#endif
 };
 
 
-- 
1.6.4

--
To unsubscribe from this list: send the line "unsubscribe linux-arm" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

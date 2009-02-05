From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 15/21] OMAP: PM: Add pm-debug counters
Date: Wed,  4 Feb 2009 18:06:01 -0800
Message-ID: <1233799567-22250-16-git-send-email-khilman@deeprootsystems.com>
References: <1233799567-22250-1-git-send-email-khilman@deeprootsystems.com>
 <1233799567-22250-2-git-send-email-khilman@deeprootsystems.com>
 <1233799567-22250-3-git-send-email-khilman@deeprootsystems.com>
 <1233799567-22250-4-git-send-email-khilman@deeprootsystems.com>
 <1233799567-22250-5-git-send-email-khilman@deeprootsystems.com>
 <1233799567-22250-6-git-send-email-khilman@deeprootsystems.com>
 <1233799567-22250-7-git-send-email-khilman@deeprootsystems.com>
 <1233799567-22250-8-git-send-email-khilman@deeprootsystems.com>
 <1233799567-22250-9-git-send-email-khilman@deeprootsystems.com>
 <1233799567-22250-10-git-send-email-khilman@deeprootsystems.com>
 <1233799567-22250-11-git-send-email-khilman@deeprootsystems.com>
 <1233799567-22250-12-git-send-email-khilman@deeprootsystems.com>
 <1233799567-22250-13-git-send-email-khilman@deeprootsystems.com>
 <1233799567-22250-14-git-send-email-khilman@deeprootsystems.com>
 <1233799567-22250-15-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rn-out-0910.google.com ([64.233.170.185]:8129 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759896AbZBECHY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Feb 2009 21:07:24 -0500
Received: by rn-out-0910.google.com with SMTP id k40so2118065rnd.17
        for <linux-omap@vger.kernel.org>; Wed, 04 Feb 2009 18:07:23 -0800 (PST)
In-Reply-To: <1233799567-22250-15-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>

From: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>

This patch provides the debugfs entries and a function which will be
called by the PM code to register the time spent per domain per
state. Also some new fields are added to the powerdomain struct to
keep the time information.

Signed-off-by: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/pm-debug.c                |  177 +++++++++++++++++++++++++
 arch/arm/mach-omap2/pm.h                      |    4 +
 arch/arm/plat-omap/include/mach/powerdomain.h |    5 +
 3 files changed, 186 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/pm-debug.c b/arch/arm/mach-omap2/pm-debug.c
index fe8d494..6cf0e9a 100644
--- a/arch/arm/mach-omap2/pm-debug.c
+++ b/arch/arm/mach-omap2/pm-debug.c
@@ -27,6 +27,8 @@
 
 #include <mach/clock.h>
 #include <mach/board.h>
+#include <mach/powerdomain.h>
+#include <mach/clockdomain.h>
 
 #include "prm.h"
 #include "cm.h"
@@ -150,3 +152,178 @@ void omap2_pm_dump(int mode, int resume, unsigned int us)
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
+	struct timespec now;
+
+	if (!pm_dbg_init_done)
+		return ;
+
+	/* Update timer for previous state */
+	getnstimeofday(&now);
+	t = timespec_to_ns(&now);
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
+		strcmp(clkdm->name, "wkup_clkdm") == 0)
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
+		strcmp(pwrdm->name, "wkup_pwrdm") == 0)
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
+	struct timespec now;
+
+	getnstimeofday(&now);
+	t = timespec_to_ns(&now);
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
+	pwrdm_for_each(pwrdms_setup, NULL);
+
+	pm_dbg_init_done = 1;
+
+	return 0;
+}
+late_initcall(pm_dbg_init);
+
+#endif
diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
index 625a905..65d624a 100644
--- a/arch/arm/mach-omap2/pm.h
+++ b/arch/arm/mach-omap2/pm.h
@@ -11,6 +11,8 @@
 #ifndef __ARCH_ARM_MACH_OMAP2_PM_H
 #define __ARCH_ARM_MACH_OMAP2_PM_H
 
+#include <mach/powerdomain.h>
+
 extern int omap2_pm_init(void);
 extern int omap3_pm_init(void);
 
@@ -24,9 +26,11 @@ extern void omap2_allow_sleep(void);
 #ifdef CONFIG_PM_DEBUG
 extern void omap2_pm_dump(int mode, int resume, unsigned int us);
 extern int omap2_pm_debug;
+extern void pm_dbg_update_time(struct powerdomain *pwrdm, int prev);
 #else
 #define omap2_pm_dump(mode, resume, us)		do {} while (0);
 #define omap2_pm_debug				0
+#define pm_dbg_update_time(pwrdm, prev) do {} while (0);
 #endif /* CONFIG_PM_DEBUG */
 
 #endif
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
1.6.1


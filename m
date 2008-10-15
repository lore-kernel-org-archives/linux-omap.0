From: "Peter 'p2' De Schrijver" <peter.de-schrijver@nokia.com>
Subject: [PATCH 2/3] Add pm-debug counters
Date: Wed, 15 Oct 2008 18:13:48 +0300
Message-ID: <1224083629-25061-3-git-send-email-peter.de-schrijver@nokia.com>
References: <1224083629-25061-1-git-send-email-peter.de-schrijver@nokia.com>
 <1224083629-25061-2-git-send-email-peter.de-schrijver@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:19036 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752100AbYJOPN7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Oct 2008 11:13:59 -0400
Received: from esebh107.NOE.Nokia.com (esebh107.ntc.nokia.com [172.21.143.143])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m9FFDrsp022244
	for <linux-omap@vger.kernel.org>; Wed, 15 Oct 2008 18:13:56 +0300
In-Reply-To: <1224083629-25061-2-git-send-email-peter.de-schrijver@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>

This patch provides the debugfs entries and a function which will be called
by the PM code to register the time spent per domain per state. Also some
new fields are added to the powerdomain struct to keep the time information.

Signed-off-by: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
---
 arch/arm/mach-omap2/pm-debug.c                |  175 +++++++++++++++++++++++++
 arch/arm/mach-omap2/pm.h                      |    2 +
 arch/arm/plat-omap/include/mach/powerdomain.h |    5 +
 3 files changed, 182 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/pm-debug.c b/arch/arm/mach-omap2/pm-debug.c
index 0b5c044..4ba6cec 100644
--- a/arch/arm/mach-omap2/pm-debug.c
+++ b/arch/arm/mach-omap2/pm-debug.c
@@ -29,6 +29,8 @@
 
 #include <mach/clock.h>
 #include <mach/board.h>
+#include <mach/powerdomain.h>
+#include <mach/clockdomain.h>
 
 #include "prm.h"
 #include "cm.h"
@@ -288,4 +290,177 @@ void omap2_pm_dump(int mode, int resume, unsigned int us)
 		printk("%-20s: 0x%08x\n", regs[i].name, regs[i].val);
 }
 
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
+
+	return 0;
+}
+
+static void pm_dbg_show_counters(struct seq_file *s, void *unused)
+{
+	pwrdm_for_each(pwrdm_dbg_show_counter, s);
+	clkdm_for_each(clkdm_dbg_show_counter, s);
+}
+
+static void pm_dbg_show_timers(struct seq_file *s, void *unused)
+{
+	pwrdm_for_each(pwrdm_dbg_show_timer, s);
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
+
 #endif
diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
index 68c9278..fb6693b 100644
--- a/arch/arm/mach-omap2/pm.h
+++ b/arch/arm/mach-omap2/pm.h
@@ -31,6 +31,7 @@ extern void serial_console_fclk_mask(u32 *f1, u32 *f2);
 extern void pm_init_serial_console(void);
 extern void serial_console_sleep(int enable);
 extern int omap2_pm_debug;
+extern void pm_dbg_update_time(struct powerdomain *pwrdm, int prev);
 #else
 #define omap2_read_32k_sync_counter()		0
 #define serial_console_sleep(enable)		do {} while (0);
@@ -38,5 +39,6 @@ extern int omap2_pm_debug;
 #define omap2_pm_dump(mode, resume, us)		do {} while (0);
 #define serial_console_fclk_mask(f1, f2)		do {} while (0);
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
1.5.6.3


From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH v2 7/7] OMAP: PM: Added suspend target state control to debugfs for OMAP3
Date: Mon, 24 Aug 2009 00:32:26 +0300
Message-ID: <1251063146-9255-8-git-send-email-khilman@deeprootsystems.com>
References: <1251063146-9255-1-git-send-email-khilman@deeprootsystems.com>
 <1251063146-9255-2-git-send-email-khilman@deeprootsystems.com>
 <1251063146-9255-3-git-send-email-khilman@deeprootsystems.com>
 <1251063146-9255-4-git-send-email-khilman@deeprootsystems.com>
 <1251063146-9255-5-git-send-email-khilman@deeprootsystems.com>
 <1251063146-9255-6-git-send-email-khilman@deeprootsystems.com>
 <1251063146-9255-7-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f207.google.com ([209.85.219.207]:35606 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934144AbZHWVcr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 23 Aug 2009 17:32:47 -0400
Received: by mail-ew0-f207.google.com with SMTP id 3so1908394ewy.18
        for <linux-omap@vger.kernel.org>; Sun, 23 Aug 2009 14:32:49 -0700 (PDT)
In-Reply-To: <1251063146-9255-7-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tero Kristo <tero.kristo@nokia.com>

From: Tero Kristo <tero.kristo@nokia.com>

Target state can be read / programmed via files under:
  [debugfs]/pm_debug/[pwrdm]/suspend

Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/pm-debug.c |   31 +++++++++++++++++++++++++++++--
 arch/arm/mach-omap2/pm.h       |    3 +++
 arch/arm/mach-omap2/pm34xx.c   |   24 ++++++++++++++++++++++++
 3 files changed, 56 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/pm-debug.c b/arch/arm/mach-omap2/pm-debug.c
index 982aa67..1b4c160 100644
--- a/arch/arm/mach-omap2/pm-debug.c
+++ b/arch/arm/mach-omap2/pm-debug.c
@@ -24,6 +24,7 @@
 #include <linux/clk.h>
 #include <linux/err.h>
 #include <linux/io.h>
+#include <linux/module.h>
 
 #include <mach/clock.h>
 #include <mach/board.h>
@@ -484,10 +485,28 @@ int pm_dbg_regset_init(int reg_set)
 	return 0;
 }
 
-static int __init pwrdms_setup(struct powerdomain *pwrdm, void *unused)
+static int pwrdm_suspend_get(void *data, u64 *val)
+{
+	*val = omap3_pm_get_suspend_state((struct powerdomain *)data);
+
+	if (*val >= 0)
+		return 0;
+	return *val;
+}
+
+static int pwrdm_suspend_set(void *data, u64 val)
+{
+	return omap3_pm_set_suspend_state((struct powerdomain *)data, (int)val);
+}
+
+DEFINE_SIMPLE_ATTRIBUTE(pwrdm_suspend_fops, pwrdm_suspend_get,
+			pwrdm_suspend_set, "%llu\n");
+
+static int __init pwrdms_setup(struct powerdomain *pwrdm, void *dir)
 {
 	int i;
 	s64 t;
+	struct dentry *d;
 
 	t = sched_clock();
 
@@ -496,6 +515,14 @@ static int __init pwrdms_setup(struct powerdomain *pwrdm, void *unused)
 
 	pwrdm->timer = t;
 
+	if (strncmp(pwrdm->name, "dpll", 4) == 0)
+		return 0;
+
+	d = debugfs_create_dir(pwrdm->name, (struct dentry *)dir);
+
+	(void) debugfs_create_file("suspend", S_IRUGO|S_IWUSR, d,
+			(void *)pwrdm, &pwrdm_suspend_fops);
+
 	return 0;
 }
 
@@ -524,7 +551,7 @@ static int __init pm_dbg_init(void)
 	(void) debugfs_create_file("time", S_IRUGO,
 		d, (void *)DEBUG_FILE_TIMERS, &debug_fops);
 
-	pwrdm_for_each(pwrdms_setup, NULL);
+	pwrdm_for_each(pwrdms_setup, (void *)d);
 
 	pm_dbg_dir = debugfs_create_dir("registers", d);
 	if (IS_ERR(pm_dbg_dir))
diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
index 8fa8567..8400f57 100644
--- a/arch/arm/mach-omap2/pm.h
+++ b/arch/arm/mach-omap2/pm.h
@@ -13,6 +13,9 @@
 
 #include <mach/powerdomain.h>
 
+extern int omap3_pm_get_suspend_state(struct powerdomain *pwrdm);
+extern int omap3_pm_set_suspend_state(struct powerdomain *pwrdm, int state);
+
 #ifdef CONFIG_PM_DEBUG
 extern void omap2_pm_dump(int mode, int resume, unsigned int us);
 extern int omap2_pm_debug;
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 331dfca..26f2aca 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -664,6 +664,30 @@ static void __init prcm_setup_regs(void)
 	omap3_d2d_idle();
 }
 
+int omap3_pm_get_suspend_state(struct powerdomain *pwrdm)
+{
+	struct power_state *pwrst;
+
+	list_for_each_entry(pwrst, &pwrst_list, node) {
+		if (pwrst->pwrdm == pwrdm)
+			return pwrst->next_state;
+	}
+	return -EINVAL;
+}
+
+int omap3_pm_set_suspend_state(struct powerdomain *pwrdm, int state)
+{
+	struct power_state *pwrst;
+
+	list_for_each_entry(pwrst, &pwrst_list, node) {
+		if (pwrst->pwrdm == pwrdm) {
+			pwrst->next_state = state;
+			return 0;
+		}
+	}
+	return -EINVAL;
+}
+
 static int __init pwrdms_setup(struct powerdomain *pwrdm, void *unused)
 {
 	struct power_state *pwrst;
-- 
1.6.4


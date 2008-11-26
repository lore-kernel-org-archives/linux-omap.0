From: Tero Kristo <tero.kristo@nokia.com>
Subject: [PATCH] PM: Added suspend target state control to debugfs for OMAP3
Date: Wed, 26 Nov 2008 12:26:24 +0200
Message-ID: <1227695184-2870-1-git-send-email-tero.kristo@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:58769 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750823AbYKZKal (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 26 Nov 2008 05:30:41 -0500
Received: from esebh107.NOE.Nokia.com (esebh107.ntc.nokia.com [172.21.143.143])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id mAQAUGks030656
	for <linux-omap@vger.kernel.org>; Wed, 26 Nov 2008 12:30:38 +0200
Received: from localhost.localdomain (sokoban.ntc.nokia.com [172.22.144.95])
	by mgw-int02.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id mAQAUIUv030794
	for <linux-omap@vger.kernel.org>; Wed, 26 Nov 2008 12:30:18 +0200
In-Reply-To: <>
References: <>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Target state can be read / programmed via files under:
  [debugfs]/pm_debug/[pwrdm]/suspend

Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
---
 arch/arm/mach-omap2/pm-debug.c |   30 ++++++++++++++++++++++++++++--
 arch/arm/mach-omap2/pm.h       |    4 ++++
 arch/arm/mach-omap2/pm34xx.c   |   24 ++++++++++++++++++++++++
 3 files changed, 56 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/pm-debug.c b/arch/arm/mach-omap2/pm-debug.c
index 82219f4..ac61d15 100644
--- a/arch/arm/mach-omap2/pm-debug.c
+++ b/arch/arm/mach-omap2/pm-debug.c
@@ -26,6 +26,7 @@
 #include <linux/clk.h>
 #include <linux/err.h>
 #include <linux/io.h>
+#include <linux/module.h>
 
 #include <mach/clock.h>
 #include <mach/board.h>
@@ -511,11 +512,28 @@ int pm_dbg_regset_init(int reg_set)
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
+DEFINE_SIMPLE_ATTRIBUTE(pwrdm_suspend_fops, pwrdm_suspend_get, pwrdm_suspend_set, "%llu\n");
+
+static int __init pwrdms_setup(struct powerdomain *pwrdm, void *dir)
 {
 	int i;
 	s64 t;
 	struct timespec now;
+	struct dentry *d;
 
 	getnstimeofday(&now);
 	t = timespec_to_ns(&now);
@@ -525,6 +543,14 @@ static int __init pwrdms_setup(struct powerdomain *pwrdm, void *unused)
 
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
 
@@ -545,7 +571,7 @@ static int __init pm_dbg_init(void)
 	(void) debugfs_create_file("time", S_IRUGO,
 		d, (void *)DEBUG_FILE_TIMERS, &debug_fops);
 
-	pwrdm_for_each(pwrdms_setup, NULL);
+	pwrdm_for_each(pwrdms_setup, (void *)d);
 
 	pm_dbg_dir = debugfs_create_dir("registers", d);
 	if (IS_ERR(pm_dbg_dir))
diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
index 4b1ba7c..78fde57 100644
--- a/arch/arm/mach-omap2/pm.h
+++ b/arch/arm/mach-omap2/pm.h
@@ -34,8 +34,12 @@ extern void omap2_block_sleep(void);
 extern void omap2_allow_sleep(void);
 #ifdef CONFIG_ARCH_OMAP3
 extern void omap3_pm_off_mode_enable(int);
+extern int omap3_pm_get_suspend_state(struct powerdomain *pwrdm);
+extern int omap3_pm_set_suspend_state(struct powerdomain *pwrdm, int state);
 #else
 #define omap3_pm_off_mode_enable(int) do {} while (0);
+#define omap3_pm_get_suspend_state(pwrdm) do {} while (0);
+#define omap3_pm_set_suspend_state(pwrdm,state) do {} while (0);
 #endif
 extern int set_pwrdm_state(struct powerdomain *pwrdm, u32 state);
 
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 191299c..73ac22c 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -780,6 +780,30 @@ void omap3_pm_off_mode_enable(int enable)
 	}
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
1.5.4.3


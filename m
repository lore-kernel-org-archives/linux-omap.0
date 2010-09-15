From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 02/10] OMAP: PM debugfs removing OMAP3 hardcodings.
Date: Wed, 15 Sep 2010 16:55:38 -0700
Message-ID: <1284594946-28963-3-git-send-email-khilman@deeprootsystems.com>
References: <1284594946-28963-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:38749 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753718Ab0IOXzx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Sep 2010 19:55:53 -0400
Received: by iwn5 with SMTP id 5so516274iwn.19
        for <linux-omap@vger.kernel.org>; Wed, 15 Sep 2010 16:55:52 -0700 (PDT)
In-Reply-To: <1284594946-28963-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Thara Gopinath <thara@ti.com>

From: Thara Gopinath <thara@ti.com>

This patch removes omap3 hardcodings from pm-debug.c
so that enabling PM debugfs support does break compilation
for other OMAP's. This is a preparatory patch for supporting
OMAP4 pm entries through PM debugfs.

Signed-off-by: Thara Gopinath <thara@ti.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/pm-debug.c |   21 ++++++++++++++++-----
 arch/arm/mach-omap2/pm34xx.c   |    5 -----
 2 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-omap2/pm-debug.c b/arch/arm/mach-omap2/pm-debug.c
index 723b44e..056ff17 100644
--- a/arch/arm/mach-omap2/pm-debug.c
+++ b/arch/arm/mach-omap2/pm-debug.c
@@ -37,6 +37,10 @@
 #include "pm.h"
 
 int omap2_pm_debug;
+u32 enable_off_mode;
+u32 sleep_while_idle;
+u32 wakeup_timer_seconds;
+u32 wakeup_timer_milliseconds;
 
 #define DUMP_PRM_MOD_REG(mod, reg)    \
 	regs[reg_count].name = #mod "." #reg; \
@@ -494,8 +498,10 @@ int pm_dbg_regset_init(int reg_set)
 
 static int pwrdm_suspend_get(void *data, u64 *val)
 {
-	int ret;
-	ret = omap3_pm_get_suspend_state((struct powerdomain *)data);
+	int ret = -EINVAL;
+
+	if (cpu_is_omap34xx())
+		ret = omap3_pm_get_suspend_state((struct powerdomain *)data);
 	*val = ret;
 
 	if (ret >= 0)
@@ -505,7 +511,10 @@ static int pwrdm_suspend_get(void *data, u64 *val)
 
 static int pwrdm_suspend_set(void *data, u64 val)
 {
-	return omap3_pm_set_suspend_state((struct powerdomain *)data, (int)val);
+	if (cpu_is_omap34xx())
+		return omap3_pm_set_suspend_state(
+			(struct powerdomain *)data, (int)val);
+	return -EINVAL;
 }
 
 DEFINE_SIMPLE_ATTRIBUTE(pwrdm_suspend_fops, pwrdm_suspend_get,
@@ -553,8 +562,10 @@ static int option_set(void *data, u64 val)
 
 	*option = val;
 
-	if (option == &enable_off_mode)
-		omap3_pm_off_mode_enable(val);
+	if (option == &enable_off_mode) {
+		if (cpu_is_omap34xx())
+			omap3_pm_off_mode_enable(val);
+	}
 
 	return 0;
 }
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index b5e5bcb..429268e 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -55,11 +55,6 @@
 #define OMAP343X_TABLE_VALUE_OFFSET	   0x30
 #define OMAP343X_CONTROL_REG_VALUE_OFFSET  0x32
 
-u32 enable_off_mode;
-u32 sleep_while_idle;
-u32 wakeup_timer_seconds;
-u32 wakeup_timer_milliseconds;
-
 struct power_state {
 	struct powerdomain *pwrdm;
 	u32 next_state;
-- 
1.7.2.1


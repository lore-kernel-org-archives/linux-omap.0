From: Manjunatha GK <manjugk@ti.com>
Subject: [PATCH v3] [OMAP3_PM] Fix zoom2/zoom3 build error
Date: Mon, 16 Nov 2009 20:16:52 +0530
Message-ID: <20091116144652.GA31051@DFL-61>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:35970 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752087AbZKPOpv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 Nov 2009 09:45:51 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com

The Zoom2 and Zoom3 build breaks on linux-omap-pm(HEAD:pm)
when CONFIG_DEBUG_FS is not enabled. 

Build error log:
arch/arm/mach-omap2/built-in.o: In function `omap_sram_idle':
arch/arm/mach-omap2/pm34xx.c:449: undefined reference to `pm_dbg_regset_save'
arch/arm/mach-omap2/pm34xx.c:460: undefined reference to `pm_dbg_regset_save'
arch/arm/mach-omap2/built-in.o: In function `configure_vc':
arch/arm/mach-omap2/pm34xx.c:1237: undefined reference to `pm_dbg_regset_init'
arch/arm/mach-omap2/pm34xx.c:1238: undefined reference to `pm_dbg_regset_init'
make: *** [.tmp_vmlinux1] Error 1

This patch fixes the above errors.

Kernel booting is tested on omap zoom2 and zoom3 boards.

Review Comments fixed:
http://patchwork.kernel.org/patch/56955/
http://patchwork.kernel.org/patch/56946/

Signed-off-by: Manjunatha GK <manjugk@ti.com>
---
 arch/arm/mach-omap2/pm-debug.c |    2 --
 arch/arm/mach-omap2/pm.h       |    8 ++++++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/pm-debug.c b/arch/arm/mach-omap2/pm-debug.c
index 767ebbc..5284967 100644
--- a/arch/arm/mach-omap2/pm-debug.c
+++ b/arch/arm/mach-omap2/pm-debug.c
@@ -623,6 +623,4 @@ static int __init pm_dbg_init(void)
 }
 arch_initcall(pm_dbg_init);
 
-#else
-void pm_dbg_update_time(struct powerdomain *pwrdm, int prev) {}
 #endif
diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
index c195b14..7bc86b6 100644
--- a/arch/arm/mach-omap2/pm.h
+++ b/arch/arm/mach-omap2/pm.h
@@ -76,12 +76,16 @@ extern struct omap_dm_timer *gptimer_wakeup;
 #ifdef CONFIG_PM_DEBUG
 extern void omap2_pm_dump(int mode, int resume, unsigned int us);
 extern int omap2_pm_debug;
+#else
+#define omap2_pm_dump(mode, resume, us)		do {} while (0);
+#define omap2_pm_debug				0
+#endif
+
+#if defined(CONFIG_PM_DEBUG) && defined(CONFIG_DEBUG_FS)
 extern void pm_dbg_update_time(struct powerdomain *pwrdm, int prev);
 extern int pm_dbg_regset_save(int reg_set);
 extern int pm_dbg_regset_init(int reg_set);
 #else
-#define omap2_pm_dump(mode, resume, us)		do {} while (0);
-#define omap2_pm_debug				0
 #define pm_dbg_update_time(pwrdm, prev) do {} while (0);
 #define pm_dbg_regset_save(reg_set) do {} while (0);
 #define pm_dbg_regset_init(reg_set) do {} while (0);
-- 
1.6.0.4


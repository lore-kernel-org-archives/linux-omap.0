From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 09/13] OMAP3: PM debug: fix build error when !CONFIG_DEBUG_FS
Date: Fri,  8 Jan 2010 09:59:27 -0800
Message-ID: <1262973571-25796-10-git-send-email-khilman@deeprootsystems.com>
References: <1262973571-25796-1-git-send-email-khilman@deeprootsystems.com>
 <1262973571-25796-2-git-send-email-khilman@deeprootsystems.com>
 <1262973571-25796-3-git-send-email-khilman@deeprootsystems.com>
 <1262973571-25796-4-git-send-email-khilman@deeprootsystems.com>
 <1262973571-25796-5-git-send-email-khilman@deeprootsystems.com>
 <1262973571-25796-6-git-send-email-khilman@deeprootsystems.com>
 <1262973571-25796-7-git-send-email-khilman@deeprootsystems.com>
 <1262973571-25796-8-git-send-email-khilman@deeprootsystems.com>
 <1262973571-25796-9-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f171.google.com ([209.85.222.171]:63991 "EHLO
	mail-pz0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753783Ab0AHR7x (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Jan 2010 12:59:53 -0500
Received: by mail-pz0-f171.google.com with SMTP id 1so3897390pzk.33
        for <linux-omap@vger.kernel.org>; Fri, 08 Jan 2010 09:59:53 -0800 (PST)
In-Reply-To: <1262973571-25796-9-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Manjunatha GK <manjugk@ti.com>

From: Manjunatha GK <manjugk@ti.com>

The PM debug code fails to build on when CONFIG_DEBUG_FS is not
enabled.

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

Signed-off-by: Manjunatha GK <manjugk@ti.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/pm-debug.c |    2 --
 arch/arm/mach-omap2/pm.h       |    8 ++++++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/pm-debug.c b/arch/arm/mach-omap2/pm-debug.c
index 860b755..e9d3993 100644
--- a/arch/arm/mach-omap2/pm-debug.c
+++ b/arch/arm/mach-omap2/pm-debug.c
@@ -604,6 +604,4 @@ static int __init pm_dbg_init(void)
 }
 arch_initcall(pm_dbg_init);
 
-#else
-void pm_dbg_update_time(struct powerdomain *pwrdm, int prev) {}
 #endif
diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
index 0bf345d..7a9c2d0 100644
--- a/arch/arm/mach-omap2/pm.h
+++ b/arch/arm/mach-omap2/pm.h
@@ -32,12 +32,16 @@ extern struct omap_dm_timer *gptimer_wakeup;
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
1.6.6.rc2.1.g42108


From: Thara Gopinath <thara@ti.com>
Subject: [PATCH v3 01/11] OMAP: PM: Export the main pm debugfs directory
Date: Wed, 22 Sep 2010 20:15:09 +0530
Message-ID: <1285166719-19352-2-git-send-email-thara@ti.com>
References: <1285166719-19352-1-git-send-email-thara@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:56258 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753581Ab0IVOpg (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 22 Sep 2010 10:45:36 -0400
In-Reply-To: <1285166719-19352-1-git-send-email-thara@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, paul@pwsan.com, b-cousson@ti.com, vishwanath.bs@ti.com, sawant@ti.com, Thara Gopinath <thara@ti.com>

This patch makes generic pm_debug directory  global
so that other drivers can include it and use it to create
sub-entries.

Signed-off-by: Thara Gopinath <thara@ti.com>
---
 arch/arm/mach-omap2/pm-debug.c |    3 +++
 arch/arm/mach-omap2/pm.h       |    1 +
 2 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/pm-debug.c b/arch/arm/mach-omap2/pm-debug.c
index af00c17..390f1c6 100644
--- a/arch/arm/mach-omap2/pm-debug.c
+++ b/arch/arm/mach-omap2/pm-debug.c
@@ -42,6 +42,7 @@ u32 enable_off_mode;
 u32 sleep_while_idle;
 u32 wakeup_timer_seconds;
 u32 wakeup_timer_milliseconds;
+struct dentry *pm_dbg_main_dir;
 
 #define DUMP_PRM_MOD_REG(mod, reg)    \
 	regs[reg_count].name = #mod "." #reg; \
@@ -641,6 +642,8 @@ static int __init pm_dbg_init(void)
 	(void) debugfs_create_file("wakeup_timer_milliseconds",
 			S_IRUGO | S_IWUGO, d, &wakeup_timer_milliseconds,
 			&pm_dbg_option_fops);
+
+	pm_dbg_main_dir = d;
 	pm_dbg_init_done = 1;
 
 	return 0;
diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
index f3ba1e6..c06cedd 100644
--- a/arch/arm/mach-omap2/pm.h
+++ b/arch/arm/mach-omap2/pm.h
@@ -55,6 +55,7 @@ extern int omap2_pm_debug;
 #define omap2_pm_dump(mode, resume, us)		do {} while (0);
 #define omap2_pm_wakeup_on_timer(seconds, milliseconds)	do {} while (0);
 #define omap2_pm_debug				0
+#define pm_dbg_main_dir				0
 #endif
 
 #if defined(CONFIG_CPU_IDLE)
-- 
1.7.1.GIT


From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 07/28] OMAP3: PM: SRAM restore function
Date: Thu,  1 Oct 2009 16:58:37 -0700
Message-ID: <1254441538-9257-8-git-send-email-khilman@deeprootsystems.com>
References: <1254441538-9257-1-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-2-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-3-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-4-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-5-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-6-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-7-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f179.google.com ([209.85.216.179]:51872 "EHLO
	mail-px0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753844AbZJAX7I (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Oct 2009 19:59:08 -0400
Received: by mail-px0-f179.google.com with SMTP id 9so694314pxi.4
        for <linux-omap@vger.kernel.org>; Thu, 01 Oct 2009 16:59:13 -0700 (PDT)
In-Reply-To: <1254441538-9257-7-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Rajendra Nayak <rnayak@ti.com>

From: Rajendra Nayak <rnayak@ti.com>

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/pm34xx.c           |   10 +++++++---
 arch/arm/plat-omap/include/mach/sram.h |    1 +
 arch/arm/plat-omap/sram.c              |    6 +++---
 3 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 378c2f6..9dbb5a0 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -748,6 +748,12 @@ static int __init clkdms_setup(struct clockdomain *clkdm, void *unused)
 	return 0;
 }
 
+void omap_push_sram_idle(void)
+{
+	_omap_sram_idle = omap_sram_push(omap34xx_cpu_suspend,
+					omap34xx_cpu_suspend_sz);
+}
+
 static int __init omap3_pm_init(void)
 {
 	struct power_state *pwrst, *tmp;
@@ -785,9 +791,7 @@ static int __init omap3_pm_init(void)
 		goto err2;
 	}
 
-	_omap_sram_idle = omap_sram_push(omap34xx_cpu_suspend,
-					 omap34xx_cpu_suspend_sz);
-
+	omap_push_sram_idle();
 #ifdef CONFIG_SUSPEND
 	suspend_set_ops(&omap_pm_ops);
 #endif /* CONFIG_SUSPEND */
diff --git a/arch/arm/plat-omap/include/mach/sram.h b/arch/arm/plat-omap/include/mach/sram.h
index 8974e3f..a943014 100644
--- a/arch/arm/plat-omap/include/mach/sram.h
+++ b/arch/arm/plat-omap/include/mach/sram.h
@@ -67,5 +67,6 @@ extern u32 omap3_sram_configure_core_dpll(
 			u32 sdrc_rfr_ctrl_1, u32 sdrc_actim_ctrl_a_1,
 			u32 sdrc_actim_ctrl_b_1, u32 sdrc_mr_1);
 extern unsigned long omap3_sram_configure_core_dpll_sz;
+extern void omap_push_sram_idle(void);
 
 #endif
diff --git a/arch/arm/plat-omap/sram.c b/arch/arm/plat-omap/sram.c
index 925f647..4f064b2 100644
--- a/arch/arm/plat-omap/sram.c
+++ b/arch/arm/plat-omap/sram.c
@@ -395,14 +395,14 @@ u32 omap3_configure_core_dpll(u32 m2, u32 unlock_dll, u32 f, u32 inc,
 			sdrc_actim_ctrl_b_1, sdrc_mr_1);
 }
 
-/* REVISIT: Should this be same as omap34xx_sram_init() after off-idle? */
-void restore_sram_functions(void)
+void omap3_sram_restore_context(void)
 {
 	omap_sram_ceil = omap_sram_base + omap_sram_size;
 
 	_omap3_sram_configure_core_dpll =
 		omap_sram_push(omap3_sram_configure_core_dpll,
 			       omap3_sram_configure_core_dpll_sz);
+	omap_push_sram_idle();
 }
 
 int __init omap34xx_sram_init(void)
@@ -410,7 +410,7 @@ int __init omap34xx_sram_init(void)
 	_omap3_sram_configure_core_dpll =
 		omap_sram_push(omap3_sram_configure_core_dpll,
 			       omap3_sram_configure_core_dpll_sz);
-
+	omap_push_sram_idle();
 	return 0;
 }
 #else
-- 
1.6.4.3


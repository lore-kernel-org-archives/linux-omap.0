From: "Rajendra Nayak" <rnayak@ti.com>
Subject: [PATCH 10/16] OMAP3: SRAM restore function
Date: Fri, 26 Sep 2008 17:49:14 +0530
Message-ID: <01fb01c91fd2$17430070$LocalHost@wipultra1382>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:34345 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751903AbYIZMTZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Sep 2008 08:19:25 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: 'Kevin Hilman' <khilman@deeprootsystems.com>

This patch updates the context restore function for sram

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/pm34xx.c           |   10 +++++++---
 arch/arm/plat-omap/include/mach/sram.h |    1 +
 arch/arm/plat-omap/sram.c              |    6 +++---
 3 files changed, 11 insertions(+), 6 deletions(-)

Index: linux-omap-2.6/arch/arm/mach-omap2/pm34xx.c
===================================================================
--- linux-omap-2.6.orig/arch/arm/mach-omap2/pm34xx.c	2008-09-25 16:27:12.000000000 +0530
+++ linux-omap-2.6/arch/arm/mach-omap2/pm34xx.c	2008-09-25 16:27:17.000000000 +0530
@@ -558,6 +558,12 @@ static int __init clkdms_setup(struct cl
 	return 0;
 }
 
+void omap_push_sram_idle()
+{
+	_omap_sram_idle = omap_sram_push(omap34xx_cpu_suspend,
+					omap34xx_cpu_suspend_sz);
+}
+
 int __init omap3_pm_init(void)
 {
 	struct power_state *pwrst;
@@ -592,9 +598,7 @@ int __init omap3_pm_init(void)
 		goto err2;
 	}
 
-	_omap_sram_idle = omap_sram_push(omap34xx_cpu_suspend,
-					omap34xx_cpu_suspend_sz);
-
+	omap_push_sram_idle();
 	suspend_set_ops(&omap_pm_ops);
 
 	pm_idle = omap3_pm_idle;
Index: linux-omap-2.6/arch/arm/plat-omap/sram.c
===================================================================
--- linux-omap-2.6.orig/arch/arm/plat-omap/sram.c	2008-09-25 16:26:40.000000000 +0530
+++ linux-omap-2.6/arch/arm/plat-omap/sram.c	2008-09-25 16:27:17.000000000 +0530
@@ -367,14 +367,14 @@ u32 omap3_configure_core_dpll(u32 sdrc_r
 					       sdrc_actim_ctrlb, m2);
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
 
 int __init omap3_sram_init(void)
@@ -382,7 +382,7 @@ int __init omap3_sram_init(void)
 	_omap3_sram_configure_core_dpll =
 		omap_sram_push(omap3_sram_configure_core_dpll,
 			       omap3_sram_configure_core_dpll_sz);
-
+	omap_push_sram_idle();
 	return 0;
 }
 #else
Index: linux-omap-2.6/arch/arm/plat-omap/include/mach/sram.h
===================================================================
--- linux-omap-2.6.orig/arch/arm/plat-omap/include/mach/sram.h	2008-09-25 16:26:40.000000000 +0530
+++ linux-omap-2.6/arch/arm/plat-omap/include/mach/sram.h	2008-09-25 16:27:17.000000000 +0530
@@ -62,5 +62,6 @@ extern u32 omap3_sram_configure_core_dpl
 					  u32 sdrc_actim_ctrla,
 					  u32 sdrc_actim_ctrlb, u32 m2);
 extern unsigned long omap3_sram_configure_core_dpll_sz;
+extern void omap_push_sram_idle();
 
 #endif


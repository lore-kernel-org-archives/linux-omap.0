From: "Rajendra Nayak" <rnayak@ti.com>
Subject: [PATCH 08/12] update sram restore function
Date: Mon, 1 Sep 2008 19:11:28 +0530 (IST)
Message-ID: <62087.192.168.10.89.1220276488.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:49359 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751108AbYIANle (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Sep 2008 09:41:34 -0400
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id m81DfSZu007207
	for <linux-omap@vger.kernel.org>; Mon, 1 Sep 2008 08:41:33 -0500
Received: from webmail.ti.com (localhost [127.0.0.1])
	by dlep34.itg.ti.com (8.13.7/8.13.7) with ESMTP id m81DfQRH021915
	for <linux-omap@vger.kernel.org>; Mon, 1 Sep 2008 08:41:27 -0500 (CDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

This patch updates the context restore function for sram

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/pm34xx.c |   12 ++++++++----
 arch/arm/plat-omap/sram.c    |   10 +++++++---
 2 files changed, 15 insertions(+), 7 deletions(-)

Index: linux-omap-2.6/arch/arm/mach-omap2/pm34xx.c
===================================================================
--- linux-omap-2.6.orig/arch/arm/mach-omap2/pm34xx.c	2008-09-01
18:11:35.000000000 +0530
+++ linux-omap-2.6/arch/arm/mach-omap2/pm34xx.c	2008-09-01 18:11:54.000000000
+0530
@@ -50,7 +50,7 @@ struct power_state {

 static LIST_HEAD(pwrst_list);

-static void (*_omap_sram_idle)(u32 *addr, int save_state);
+void (*_omap_sram_idle)(u32 *addr, int save_state);

 static void (*saved_idle)(void);

@@ -798,6 +798,12 @@ static int __init pwrdms_setup(struct po
 	return set_pwrdm_state(pwrst->pwrdm, pwrst->next_state);
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
@@ -835,9 +841,7 @@ int __init omap3_pm_init(void)
 	per_pwrdm = pwrdm_lookup("per_pwrdm");
 	core_pwrdm = pwrdm_lookup("core_pwrdm");

-	_omap_sram_idle = omap_sram_push(omap34xx_cpu_suspend,
-					omap34xx_cpu_suspend_sz);
-
+	omap_push_sram_idle();
 	suspend_set_ops(&omap_pm_ops);

 #ifndef CONFIG_CPU_IDLE
Index: linux-omap-2.6/arch/arm/plat-omap/sram.c
===================================================================
--- linux-omap-2.6.orig/arch/arm/plat-omap/sram.c	2008-09-01 18:11:28.000000000
+0530
+++ linux-omap-2.6/arch/arm/plat-omap/sram.c	2008-09-01 18:11:54.000000000 +0530
@@ -26,6 +26,7 @@
 #include <mach/board.h>

 #include <mach/control.h>
+#include <mach/pm.h>

 #if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
 # include "../mach-omap2/prm.h"
@@ -75,6 +76,8 @@ extern unsigned long omapfb_reserve_sram
 					 unsigned long sram_size,
 					 unsigned long pstart_avail,
 					 unsigned long size_avail);
+extern void (*_omap_sram_idle)(u32 *addr, int save_state);
+extern void omap_push_sram_idle();

 /*
  * Depending on the target RAMFS firewall setup, the public usable amount of
@@ -367,14 +370,14 @@ u32 omap3_configure_core_dpll(u32 sdrc_r
 					       sdrc_actim_ctrlb, m2);
  }

-/* REVISIT: Should this be same as omap34xx_sram_init() after off-idle? */
-void restore_sram_functions(void)
+void omap3_restore_sram_ctx(void)
 {
 	omap_sram_ceil = omap_sram_base + omap_sram_size;

 	_omap3_sram_configure_core_dpll =
 		omap_sram_push(omap3_sram_configure_core_dpll,
 			       omap3_sram_configure_core_dpll_sz);
+	omap_push_sram_idle();
 }

 int __init omap3_sram_init(void)
@@ -382,7 +385,8 @@ int __init omap3_sram_init(void)
 	_omap3_sram_configure_core_dpll =
 		omap_sram_push(omap3_sram_configure_core_dpll,
 			       omap3_sram_configure_core_dpll_sz);
-
+	_omap_sram_idle = omap_sram_push(omap34xx_cpu_suspend,
+				omap34xx_cpu_suspend_sz);
 	return 0;
 }
 #else



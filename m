From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 09/11] ARM: OMAP3: PRM: add support for legacy iomapping init
Date: Tue, 16 Dec 2014 18:20:54 +0200
Message-ID: <1418746856-17173-10-git-send-email-t-kristo@ti.com>
References: <1418746856-17173-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:47466 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751117AbaLPQUM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Dec 2014 11:20:12 -0500
In-Reply-To: <1418746856-17173-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, mturquette@linaro.org, tony@atomide.com, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org

As the legacy clock data is being moved under clock driver, the
clock data will be using the same low level infrastructure for
register accesses. This requires the clk_memmaps to be initialized
properly. This patch adds a support hook to the PRM driver to
initialize the mappings.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/prm.h        |    1 +
 arch/arm/mach-omap2/prm_common.c |   11 +++++++++++
 2 files changed, 12 insertions(+)

diff --git a/arch/arm/mach-omap2/prm.h b/arch/arm/mach-omap2/prm.h
index 48480d5..a33303c 100644
--- a/arch/arm/mach-omap2/prm.h
+++ b/arch/arm/mach-omap2/prm.h
@@ -20,6 +20,7 @@ extern void __iomem *prm_base;
 extern u16 prm_features;
 extern void omap2_set_globals_prm(void __iomem *prm);
 int of_prcm_init(void);
+void omap3_prcm_legacy_iomaps_init(void);
 # endif
 
 /*
diff --git a/arch/arm/mach-omap2/prm_common.c b/arch/arm/mach-omap2/prm_common.c
index ee2b522..18f8bac 100644
--- a/arch/arm/mach-omap2/prm_common.c
+++ b/arch/arm/mach-omap2/prm_common.c
@@ -35,6 +35,8 @@
 #include "prm44xx.h"
 #include "common.h"
 #include "clock.h"
+#include "cm.h"
+#include "control.h"
 
 /*
  * OMAP_PRCM_MAX_NR_PENDING_REG: maximum number of PRM_IRQ*_MPU regs
@@ -528,6 +530,15 @@ int __init of_prcm_init(void)
 	return 0;
 }
 
+void __init omap3_prcm_legacy_iomaps_init(void)
+{
+	ti_clk_ll_ops = &omap_clk_ll_ops;
+
+	clk_memmaps[TI_CLKM_CM] = cm_base + OMAP3430_IVA2_MOD;
+	clk_memmaps[TI_CLKM_PRM] = prm_base + OMAP3430_IVA2_MOD;
+	clk_memmaps[TI_CLKM_SCRM] = omap_ctrl_base_get();
+}
+
 static int __init prm_late_init(void)
 {
 	if (prm_ll_data->late_init)
-- 
1.7.9.5


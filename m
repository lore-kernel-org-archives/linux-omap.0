From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH 5/7] omap: dpll: Enable all OMAP3/4 dpll autoidle late at boot
Date: Tue,  8 Feb 2011 15:40:36 +0530
Message-ID: <1297159838-30282-6-git-send-email-rnayak@ti.com>
References: <1297159838-30282-1-git-send-email-rnayak@ti.com>
 <1297159838-30282-2-git-send-email-rnayak@ti.com>
 <1297159838-30282-3-git-send-email-rnayak@ti.com>
 <1297159838-30282-4-git-send-email-rnayak@ti.com>
 <1297159838-30282-5-git-send-email-rnayak@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:51005 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753130Ab1BHKKx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Feb 2011 05:10:53 -0500
In-Reply-To: <1297159838-30282-5-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: paul@pwsan.com, b-cousson@ti.com, khilman@ti.com, santosh.shilimkar@ti.com, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>

Enable all dpll autoidle for OMAP4 and OMAP3 (OMAP3
already had dpll autoidle turned on, but was done
using low level cm accessor apis).
On OMAP3, replace the cm accessor apis doing this
with the now available support for doing this in
clock framework, using omap_clk_enable_autoidle().

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/pm34xx.c |   18 ++++--------------
 arch/arm/mach-omap2/pm44xx.c |    4 ++++
 2 files changed, 8 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 2f864e4..5a101fa 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -38,6 +38,7 @@
 #include <plat/prcm.h>
 #include <plat/gpmc.h>
 #include <plat/dma.h>
+#include <plat/clock.h>
 
 #include <asm/tlbflush.h>
 
@@ -814,21 +815,10 @@ static void __init prcm_setup_regs(void)
 	omap_ctrl_writel(OMAP3430_AUTOIDLE_MASK, OMAP2_CONTROL_SYSCONFIG);
 
 	/*
-	 * Set all plls to autoidle. This is needed until autoidle is
-	 * enabled by clockfw
+	 * Set all plls to autoidle.
+	 * TODO: Add all the iclk autoidles in here as well.
 	 */
-	omap2_cm_write_mod_reg(1 << OMAP3430_AUTO_IVA2_DPLL_SHIFT,
-			 OMAP3430_IVA2_MOD, CM_AUTOIDLE2);
-	omap2_cm_write_mod_reg(1 << OMAP3430_AUTO_MPU_DPLL_SHIFT,
-			 MPU_MOD,
-			 CM_AUTOIDLE2);
-	omap2_cm_write_mod_reg((1 << OMAP3430_AUTO_PERIPH_DPLL_SHIFT) |
-			 (1 << OMAP3430_AUTO_CORE_DPLL_SHIFT),
-			 PLL_MOD,
-			 CM_AUTOIDLE);
-	omap2_cm_write_mod_reg(1 << OMAP3430ES2_AUTO_PERIPH2_DPLL_SHIFT,
-			 PLL_MOD,
-			 CM_AUTOIDLE2);
+	omap_clk_enable_autoidle();
 
 	/*
 	 * Enable control of expternal oscillator through
diff --git a/arch/arm/mach-omap2/pm44xx.c b/arch/arm/mach-omap2/pm44xx.c
index 76cfff2..8431d41 100644
--- a/arch/arm/mach-omap2/pm44xx.c
+++ b/arch/arm/mach-omap2/pm44xx.c
@@ -15,6 +15,7 @@
 #include <linux/list.h>
 #include <linux/err.h>
 #include <linux/slab.h>
+#include <plat/clock.h>
 
 #include "powerdomain.h"
 #include <mach/omap4-common.h>
@@ -111,6 +112,9 @@ static int __init omap4_pm_init(void)
 		pr_err("Failed to setup powerdomains\n");
 		goto err2;
 	}
+
+	/* Enable autoidle for all clks which support it*/
+	omap_clk_enable_autoidle();
 #endif
 
 #ifdef CONFIG_SUSPEND
-- 
1.7.0.4


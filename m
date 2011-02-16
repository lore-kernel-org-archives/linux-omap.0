From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [PATCH v2 5/7] omap: dpll: Enable all OMAP3/4 dpll autoidle late
 at boot
Date: Wed, 16 Feb 2011 15:37:26 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1102161531460.29817@utopia.booyaka.com>
References: <1297329400-5936-1-git-send-email-rnayak@ti.com> <1297329400-5936-2-git-send-email-rnayak@ti.com> <1297329400-5936-3-git-send-email-rnayak@ti.com> <1297329400-5936-4-git-send-email-rnayak@ti.com> <1297329400-5936-5-git-send-email-rnayak@ti.com>
 <1297329400-5936-6-git-send-email-rnayak@ti.com> <alpine.DEB.2.00.1102121741340.21991@utopia.booyaka.com> <ee3e93f406daf1a283b8d551f57933e3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:51239 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751346Ab1BPWh1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 Feb 2011 17:37:27 -0500
In-Reply-To: <ee3e93f406daf1a283b8d551f57933e3@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org, Benoit Cousson <b-cousson@ti.com>, Kevin Hilman <khilman@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-arm-kernel@lists.infradead.org


Hi

After Rajendra's E-mail here:

   http://marc.info/?l=linux-arm-kernel&m=129785498406128&w=2

upon looking further, mach-omap2/pm.c is compiled in for !CONFIG_PM.  
This will be dealt with in a separate patch, but in the meantime, I 
propose we enable clock autoidle if CONFIG_OMAP_RESET_CLOCKS is set.  
(Really this config option should be called CONFIG_OMAP_DONT_BREAK_CLOCKFW 
or CONFIG_OMAP_MAKE_POWER_MANAGEMENT_WORK, but all that, too, is a matter 
for another patch.)

Here's what I'm proposing to use as a replacement; comments welcome.  The 
clk_autoidle_a_2.6.39 branch has been updated accordingly.


- Paul

From: Paul Walmsley <paul@pwsan.com>
Date: Mon, 14 Feb 2011 09:39:11 -0700
Subject: [PATCH] OMAP2+: clock: autoidle as many clocks as possible if CONFIG_OMAP_RESET_CLOCKS

Attempt to enable autoidle for as many clocks as possible in the
OMAP2+-common CONFIG_OMAP_RESET_CLOCKS code.  Currently, this only
enables DPLL autoidle for OMAP3/4 DPLLs; but future patches will
enable autoidle for other clocks and the OMAP2 DPLL/APLLs.

In the long run, we should probably get rid of
CONFIG_OMAP_RESET_CLOCKS, and unconditionally run the code that it
selects.  Otherwise, the state of the clock tree won't match the
hardware state - this could result in clocks being enabled or disabled
unpredictably.

Based on a patch by Rajendra Nayak <rnayak@ti.com> that did this in
the pm34xx.c/pm44xx.c code.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/pm34xx.c |   17 -----------------
 arch/arm/plat-omap/clock.c   |    1 +
 2 files changed, 1 insertions(+), 17 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 2f864e4..1fe2e73 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -814,23 +814,6 @@ static void __init prcm_setup_regs(void)
 	omap_ctrl_writel(OMAP3430_AUTOIDLE_MASK, OMAP2_CONTROL_SYSCONFIG);
 
 	/*
-	 * Set all plls to autoidle. This is needed until autoidle is
-	 * enabled by clockfw
-	 */
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
-
-	/*
 	 * Enable control of expternal oscillator through
 	 * sys_clkreq. In the long run clock framework should
 	 * take care of this.
diff --git a/arch/arm/plat-omap/clock.c b/arch/arm/plat-omap/clock.c
index 0ae0eae..2770ddd 100644
--- a/arch/arm/plat-omap/clock.c
+++ b/arch/arm/plat-omap/clock.c
@@ -446,6 +446,7 @@ static int __init clk_disable_unused(void)
 	return 0;
 }
 late_initcall(clk_disable_unused);
+late_initcall(omap_clk_enable_autoidle_all);
 #endif
 
 int __init clk_init(struct clk_functions * custom_clocks)
-- 
1.7.2.3


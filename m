From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v2 5/7] omap: dpll: Enable all OMAP3/4 dpll autoidle late
 at boot
Date: Sat, 12 Feb 2011 17:42:56 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1102121741340.21991@utopia.booyaka.com>
References: <1297329400-5936-1-git-send-email-rnayak@ti.com> <1297329400-5936-2-git-send-email-rnayak@ti.com> <1297329400-5936-3-git-send-email-rnayak@ti.com> <1297329400-5936-4-git-send-email-rnayak@ti.com> <1297329400-5936-5-git-send-email-rnayak@ti.com>
 <1297329400-5936-6-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:46365 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752514Ab1BMAm5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 12 Feb 2011 19:42:57 -0500
In-Reply-To: <1297329400-5936-6-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org, b-cousson@ti.com, khilman@ti.com, santosh.shilimkar@ti.com, linux-arm-kernel@lists.infradead.org

On Thu, 10 Feb 2011, Rajendra Nayak wrote:

> Enable all dpll autoidle for OMAP4 and OMAP3 (OMAP3
> already had dpll autoidle turned on, but was done
> using low level cm accessor apis).
> On OMAP3, replace the cm accessor apis doing this
> with the now available support for doing this in
> clock framework, using omap_clk_enable_autoidle().

I propose this patch instead.  What do you think?  Care to reply with a 
Reviewed-by: and/or Tested-by: ?


- Paul

From: Paul Walmsley <paul@pwsan.com>
Date: Sat, 12 Feb 2011 17:36:38 -0600
Subject: [PATCH] OMAP2+: clock: autoidle as many clocks as possible in OMAP2+-common PM code

Attempt to enable autoidle for as many clocks as possible in the
OMAP2+-common PM code.  Currently, this only enables DPLL autoidle for
OMAP3/4 DPLLs; but it should also eventually enable autoidle for other
clocks and the OMAP2 DPLL/APLLs.

Based on a patch by Rajendra Nayak <rnayak@ti.com> that did this in
the pm34xx.c/pm44xx.c code, rather than the common PM code.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/pm.c     |    8 ++++++++
 arch/arm/mach-omap2/pm34xx.c |   17 -----------------
 2 files changed, 8 insertions(+), 17 deletions(-)

diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
index d5a102c..b507702 100644
--- a/arch/arm/mach-omap2/pm.c
+++ b/arch/arm/mach-omap2/pm.c
@@ -262,6 +262,14 @@ static int __init omap2_common_pm_late_init(void)
 	/* Smartreflex device init */
 	omap_devinit_smartreflex();
 
+	/*
+	 * Set all OMAP3/4 DPLLs to autoidle.
+	 * XXX TODO: Add all the iclk autoidles in here as well,
+	 * the OMAP2 DPLL, the OMAP2 APLLs, and the AUTOEXTCLKMODE
+	 * control here too.
+	 */
+	omap_clk_enable_autoidle_all();
+
 	return 0;
 }
 late_initcall(omap2_common_pm_late_init);
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
-- 
1.7.2.3


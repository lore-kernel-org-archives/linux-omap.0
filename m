From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 4/5] OMAP2/3 clock: convert omap2_clk_wait_ready() to use the
	idlest_bit field
Date: Tue, 16 Sep 2008 08:58:38 -0600
Message-ID: <20080916145834.1470.20550.stgit@localhost.localdomain>
References: <20080916145747.1470.51591.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:47790 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754264AbYIPPPK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Sep 2008 11:15:10 -0400
In-Reply-To: <20080916145747.1470.51591.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>, Russell King <linux@arm.linux.org.uk>

Simplify omap2_clk_wait_ready() to use the new idlest_bit field in
struct clk, rather than the hunk of conditionals that were there
previously.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Russell King <linux@arm.linux.org.uk>
---
 arch/arm/mach-omap2/clock.c |   96 ++++++++++---------------------------------
 1 files changed, 23 insertions(+), 73 deletions(-)

diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index 7ae8baa..1411a91 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -295,100 +295,50 @@ int omap2_wait_clock_ready(u16 prcm_mod, u16 reg_index, u32 mask,
 
 
 /*
- * Note: We don't need special code here for INVERT_ENABLE
- * for the time being since INVERT_ENABLE only applies to clocks enabled by
- * CM_CLKEN_PLL
+ * omap2_clk_wait_ready - wait for a OMAP module to come out of target idle
+ * @clk: struct clk * recently enabled to indicate the module to test
  *
- * REVISIT: This code is ugly and does not belong here.
+ * Wait for an OMAP module with a target idle state bit to come out of
+ * idle once both its interface clock and primary functional clock are
+ * both enabled.  Any register read or write to the device before it
+ * returns from idle will cause an abort.  Not all modules have target
+ * idle state bits (for example, DSS and CAM on OMAP24xx); so we don't
+ * wait for those.  No return value.
+ *
+ * We don't need special code here for INVERT_ENABLE for the time
+ * being since INVERT_ENABLE only applies to clocks enabled by
+ * CM_CLKEN_PLL.
+ *
+ * REVISIT: This function is misnamed: it should be something like
+ * "omap2_module_wait_ready", and in the long-term, it does not belong
+ * in the clock framework. It also shouldn't be doing register
+ * arithmetic to determine the companion clock.
  */
 static void omap2_clk_wait_ready(struct clk *clk)
 {
 	u16 other_reg, idlest_reg;
-	u32 other_bit, idlest_bit;
+	u32 other_bit;
 
-	/* Only CM-controlled clocks affect module IDLEST */
-	if (clk->prcm_mod & ~PRCM_MOD_ADDR_MASK)
+	if (!(clk->flags & WAIT_READY))
 		return;
 
+	/* If we are enabling an iclk, also test the fclk; and vice versa */
+	other_bit = 1 << clk->enable_bit;
 	other_reg = clk->enable_reg & ~PRCM_REGTYPE_MASK;
 
-	/* If we are enabling an iclk, also test the fclk; and vice versa */
 	if (clk->enable_reg & CM_ICLKEN_REGTYPE)
 		other_reg |= CM_FCLKEN_REGTYPE;
 	else
 		other_reg |= CM_ICLKEN_REGTYPE;
 
-	/* Covers most of the cases - a few exceptions are below */
-	other_bit = 1 << clk->enable_bit;
-	idlest_bit = other_bit;
-
-	/* 24xx: DSS and CAM have no idlest bits for their target agents */
-	if (cpu_is_omap24xx() && clk->prcm_mod == CORE_MOD &&
-	    (clk->enable_reg == CM_FCLKEN1 || clk->enable_reg == CM_ICLKEN1)) {
-
-		if (clk->enable_bit == OMAP24XX_EN_DSS2_SHIFT ||
-		    clk->enable_bit == OMAP24XX_EN_DSS1_SHIFT ||
-		    clk->enable_bit == OMAP24XX_EN_CAM_SHIFT)
-			return;
-
-	}
-
-	/* REVISIT: What are the appropriate exclusions for 34XX? */
-	if (cpu_is_omap34xx()) {
-
-		/* SSI */
-		if (clk->prcm_mod == CORE_MOD &&
-		    (clk->enable_reg == CM_FCLKEN1 ||
-		     clk->enable_reg == CM_ICLKEN1) &&
-		    clk->enable_bit == OMAP3430_EN_SSI_SHIFT) {
-
-			if (system_rev == OMAP3430_REV_ES1_0)
-				return;
-
-			idlest_bit = OMAP3430ES2_ST_SSI_IDLE_SHIFT;
-		}
-
-		/* DSS */
-		if (clk->prcm_mod == OMAP3430_DSS_MOD) {
-
-			/* 3430ES1 DSS has no target idlest bits */
-			if (system_rev == OMAP3430_REV_ES1_0)
-				return;
-
-			/*
-			 * For 3430ES2+ DSS, only wait once (dss1_alwon_fclk,
-			 * dss_l3_iclk, dss_l4_iclk) are enabled
-			 */
-			if (clk->enable_bit != OMAP3430_EN_DSS1_SHIFT)
-				return;
-
-			idlest_bit = OMAP3430ES2_ST_DSS_IDLE_SHIFT;
-		}
-
-		/* USBHOST */
-		if (system_rev > OMAP3430_REV_ES1_0 &&
-		    clk->prcm_mod == OMAP3430ES2_USBHOST_MOD) {
-
-			/*
-			 * The 120MHz clock apparently has nothing to do with
-			 * USBHOST module accessibility
-			 */
-			if (clk->enable_bit == OMAP3430ES2_EN_USBHOST2_SHIFT)
-				return;
-
-			idlest_bit = OMAP3430ES2_ST_USBHOST_IDLE_SHIFT;
-
-		}
-	}
-
-	/* Check if both functional and interface clocks are running. */
+	/* Ensure functional and interface clocks are running. */
 	if (!(cm_read_mod_reg(clk->prcm_mod, other_reg) & other_bit))
 		return;
 
 	idlest_reg = other_reg & ~PRCM_REGTYPE_MASK;
 	idlest_reg |= CM_IDLEST_REGTYPE;
 
-	omap2_wait_clock_ready(clk->prcm_mod, idlest_reg, idlest_bit,
+	omap2_wait_clock_ready(clk->prcm_mod, idlest_reg, 1 << clk->idlest_bit,
 			       clk->name);
 }
 



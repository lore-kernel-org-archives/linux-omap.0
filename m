From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 2/2] OMAP3 clock: don't wait for USBHOST IDLEST bit on
	usbhost_120m_fclk enable
Date: Wed, 16 Jul 2008 20:14:59 -0600
Message-ID: <20080717021304.21489.17884.stgit@localhost.localdomain>
References: <20080717021112.21489.95137.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:52905 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754708AbYGQCPn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 Jul 2008 22:15:43 -0400
In-Reply-To: <20080717021112.21489.95137.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: vikram.pandita@ti.com

USBHOST on 3430ES2+ has both an initiator and a target CM_IDLEST bit.
Previously, usbhost_48m_fclk enable waited on the wrong bit -- now
fixed.  Also, it appears that USBHOST module readiness (in terms of
CM_IDLEST) only depends on usbhost_48m_fclk and usbhost_iclk.  So
don't wait on usbhost_120m_fck.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---

 arch/arm/mach-omap2/clock.c           |   63 ++++++++++++++++++---------------
 arch/arm/mach-omap2/cm-regbits-34xx.h |    2 +
 2 files changed, 36 insertions(+), 29 deletions(-)

diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index 577be44..5174892 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -222,8 +222,8 @@ int omap2_wait_clock_ready(void __iomem *reg, u32 mask, const char *name)
  */
 static void omap2_clk_wait_ready(struct clk *clk)
 {
-	u32 bit;
-	unsigned long reg, other_reg, st_reg, prcm_mod, prcm_regid;
+	u32 other_bit, idlest_bit;
+	unsigned long reg, other_reg, idlest_reg, prcm_mod, prcm_regid;
 
 	reg = (unsigned long)clk->enable_reg;
 	prcm_mod = reg & ~0xff;
@@ -236,6 +236,10 @@ static void omap2_clk_wait_ready(struct clk *clk)
 	else
 		return;
 
+	/* Covers most of the cases - a few exceptions are below */
+	other_bit = 1 << clk->enable_bit;
+	idlest_bit = other_bit;
+
 	/* 24xx: DSS and CAM have no idlest bits for their target agents */
 	if (cpu_is_omap24xx() &&
 	    (prcm_mod == OMAP2420_CM_REGADDR(CORE_MOD, 0) ||
@@ -253,11 +257,15 @@ static void omap2_clk_wait_ready(struct clk *clk)
 	if (cpu_is_omap34xx()) {
 
 		/* SSI */
-		if (is_sil_rev_equal_to(OMAP3430_REV_ES1_0) &&
-		    prcm_mod == OMAP34XX_CM_REGADDR(CORE_MOD, 0) &&
+		if (prcm_mod == OMAP34XX_CM_REGADDR(CORE_MOD, 0) &&
 		    (reg & 0x0f) == 0 &&
-		    clk->enable_bit == OMAP3430_EN_SSI_SHIFT)
-			return;
+		    clk->enable_bit == OMAP3430_EN_SSI_SHIFT) {
+
+			if (is_sil_rev_equal_to(OMAP3430_REV_ES1_0))
+				return;
+
+			idlest_bit = OMAP3430ES2_ST_SSI_IDLE;
+		}
 
 		/* DSS */
 		if (prcm_mod == OMAP34XX_CM_REGADDR(OMAP3430_DSS_MOD, 0)) {
@@ -272,38 +280,35 @@ static void omap2_clk_wait_ready(struct clk *clk)
 			 */
 			if (clk->enable_bit != OMAP3430_EN_DSS1_SHIFT)
 				return;
+
+			idlest_bit = OMAP3430ES2_ST_DSS_IDLE;
 		}
 
+		/* USBHOST */
+		if (is_sil_rev_greater_than(OMAP3430_REV_ES1_0) &&
+		    prcm_mod == OMAP34XX_CM_REGADDR(OMAP3430ES2_USBHOST_MOD, 0)) {
+
+			/*
+			 * The 120MHz clock apparently has nothing to do with
+			 * USBHOST module accessibility
+			 */
+			if (clk->enable_bit == OMAP3430ES2_EN_USBHOST2_SHIFT)
+				return;
+
+			idlest_bit = OMAP3430ES2_ST_USBHOST_IDLE;
+
+		}
 	}
 
 	/* Check if both functional and interface clocks
 	 * are running. */
-	bit = 1 << clk->enable_bit;
-	if (!(__raw_readl((void __iomem *)other_reg) & bit))
+	if (!(__raw_readl((void __iomem *)other_reg) & other_bit))
 		return;
 
-	/*
-	 * OMAP3430ES2+ has target idlest bits at unusual offsets for
-	 * modules with both initiator and target agents
-	 */
-	if (cpu_is_omap34xx()) {
-
-		/* SSI */
-		if (prcm_mod == OMAP34XX_CM_REGADDR(CORE_MOD, 0) &&
-		    (reg & 0x0f) == 0 &&
-		    clk->enable_bit == OMAP3430_EN_SSI_SHIFT)
-			bit = OMAP3430ES2_ST_SSI_IDLE;
-
-		/* DSS */
-		if (prcm_mod == OMAP34XX_CM_REGADDR(OMAP3430_DSS_MOD, 0) &&
-		    clk->enable_bit == OMAP3430_EN_DSS1_SHIFT)
-			bit = OMAP3430ES2_ST_DSS_IDLE;
-
-	}
-
-	st_reg = ((other_reg & ~0xf0) | 0x20); /* CM_IDLEST* */
+	idlest_reg = ((other_reg & ~0xf0) | 0x20); /* CM_IDLEST* */
 
-	omap2_wait_clock_ready((void __iomem *)st_reg, bit, clk->name);
+	omap2_wait_clock_ready((void __iomem *)idlest_reg, idlest_bit,
+			       clk->name);
 }
 
 /* Enables clock without considering parent dependencies or use count
diff --git a/arch/arm/mach-omap2/cm-regbits-34xx.h b/arch/arm/mach-omap2/cm-regbits-34xx.h
index 07ab180..ffb695b 100644
--- a/arch/arm/mach-omap2/cm-regbits-34xx.h
+++ b/arch/arm/mach-omap2/cm-regbits-34xx.h
@@ -690,6 +690,8 @@
 #define OMAP3430ES2_EN_USBHOST_MASK			(1 << 0)
 
 /* CM_IDLEST_USBHOST */
+#define OMAP3430ES2_ST_USBHOST_IDLE			(1 << 1)
+#define OMAP3430ES2_ST_USBHOST_STDBY			(1 << 0)
 
 /* CM_AUTOIDLE_USBHOST */
 #define OMAP3430ES2_AUTO_USBHOST_SHIFT			0



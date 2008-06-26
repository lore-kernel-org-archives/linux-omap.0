From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 1/4] OMAP2/3 clock: clean up omap2_clk_wait_ready()
Date: Thu, 26 Jun 2008 01:09:08 -0600
Message-ID: <20080626070905.16555.45803.stgit@localhost.localdomain>
References: <20080626070305.16555.96759.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:42950 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752800AbYFZHLl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Jun 2008 03:11:41 -0400
In-Reply-To: <20080626070305.16555.96759.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: gadiyar@ti.com, k.kooi@student.utwente.nl, dirk.behme@googlemail.com, igor.stoppa@nokia.com, r-woodruff2@ti.com, jouni.hogander@nokia.com

Minor cleanup on omap2_clk_wait_ready() in preparation for DSS, SSI fix
patches.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---

 arch/arm/mach-omap2/clock.c |   26 ++++++++++++++------------
 1 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index ed15868..57e3217 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -222,20 +222,22 @@ int omap2_wait_clock_ready(void __iomem *reg, u32 mask, const char *name)
  */
 static void omap2_clk_wait_ready(struct clk *clk)
 {
-	u32 bit, reg, other_reg, st_reg;
+	u32 bit;
+	unsigned long reg, other_reg, st_reg, prcm_mod, prcm_regid;
 
-	reg = (__force u32)clk->enable_reg;
-	if (((reg & 0xff) >= CM_FCLKEN1) &&
-	    ((reg & 0xff) <= OMAP24XX_CM_FCLKEN2))
+	reg = (unsigned long)clk->enable_reg;
+	prcm_mod = reg & ~0xff;
+	prcm_regid = reg & 0xff;
+
+	if (prcm_regid >= CM_FCLKEN1 && prcm_regid <= OMAP24XX_CM_FCLKEN2)
 		other_reg = ((reg & ~0xf0) | 0x10); /* CM_ICLKEN* */
-	else if (((reg & 0xff) >= CM_ICLKEN1) &&
-		 ((reg & 0xff) <= OMAP24XX_CM_ICLKEN4))
+	else if (prcm_regid >= CM_ICLKEN1 && prcm_regid <= OMAP24XX_CM_ICLKEN4)
 		other_reg = ((reg & ~0xf0) | 0x00); /* CM_FCLKEN* */
 	else
 		return;
 
-	/* REVISIT: What are the appropriate exclusions for 34XX? */
-	/* No check for DSS or cam clocks */
+	/* No check for DSS or CAM clocks on 24xx */
+	/* REVISIT: This should check prcm_mod against CORE_MOD */
 	if (cpu_is_omap24xx() && (reg & 0x0f) == 0) { /* CM_{F,I}CLKEN1 */
 		if (clk->enable_bit == OMAP24XX_EN_DSS2_SHIFT ||
 		    clk->enable_bit == OMAP24XX_EN_DSS1_SHIFT ||
@@ -246,19 +248,19 @@ static void omap2_clk_wait_ready(struct clk *clk)
 	/* REVISIT: What are the appropriate exclusions for 34XX? */
 	/* OMAP3: ignore DSS-mod clocks */
 	if (cpu_is_omap34xx() &&
-	    ((reg & ~0xff) == (__force u32)OMAP34XX_CM_REGADDR(OMAP3430_DSS_MOD, 0) ||
-	     (((reg & ~0xff) == (__force u32)OMAP34XX_CM_REGADDR(CORE_MOD, 0)) &&
+	    (prcm_mod == OMAP34XX_CM_REGADDR(OMAP3430_DSS_MOD, 0) ||
+	     (prcm_mod == OMAP34XX_CM_REGADDR(CORE_MOD, 0) &&
 	      clk->enable_bit == OMAP3430_EN_SSI_SHIFT)))
 		return;
 
 	/* Check if both functional and interface clocks
 	 * are running. */
 	bit = 1 << clk->enable_bit;
-	if (!(__raw_readl((__force void __iomem *)other_reg) & bit))
+	if (!(__raw_readl((void __iomem *)other_reg) & bit))
 		return;
 	st_reg = ((other_reg & ~0xf0) | 0x20); /* CM_IDLEST* */
 
-	omap2_wait_clock_ready((__force void __iomem *)st_reg, bit, clk->name);
+	omap2_wait_clock_ready((void __iomem *)st_reg, bit, clk->name);
 }
 
 /* Enables clock without considering parent dependencies or use count



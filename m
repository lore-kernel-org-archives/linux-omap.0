From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH v2 07/11] OMAP2/3 clock: use prcm_mod field in
	omap2_clk_wait_ready()
Date: Thu, 18 Sep 2008 11:47:12 -0600
Message-ID: <20080918174709.7146.10499.stgit@localhost.localdomain>
References: <20080918174432.7146.21366.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:55113 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755271AbYIRRsI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Sep 2008 13:48:08 -0400
In-Reply-To: <20080918174432.7146.21366.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>

Use the newly-added clk.prcm_mod field in omap2_clk_wait_ready(),
removing some internal register arithmetic.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/clock.c |   17 +++++++++--------
 1 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index ebf2d7e..6433679 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -302,10 +302,13 @@ int omap2_wait_clock_ready(void __iomem *reg, u32 mask, const char *name)
 static void omap2_clk_wait_ready(struct clk *clk)
 {
 	u32 other_bit, idlest_bit;
-	unsigned long reg, other_reg, idlest_reg, prcm_mod, prcm_regid;
+	unsigned long reg, other_reg, idlest_reg, prcm_regid;
+
+	/* Only CM-controlled clocks affect module IDLEST */
+	if (clk->prcm_mod & ~PRCM_MOD_ADDR_MASK)
+		return;
 
 	reg = (unsigned long)clk->enable_reg;
-	prcm_mod = reg & ~0xff;
 	prcm_regid = reg & 0xff;
 
 	other_reg = reg & ~PRCM_REGTYPE_MASK;
@@ -321,9 +324,7 @@ static void omap2_clk_wait_ready(struct clk *clk)
 	idlest_bit = other_bit;
 
 	/* 24xx: DSS and CAM have no idlest bits for their target agents */
-	if (cpu_is_omap24xx() &&
-	    (prcm_mod == OMAP2420_CM_REGADDR(CORE_MOD, 0) ||
-	     prcm_mod == OMAP2430_CM_REGADDR(CORE_MOD, 0)) &&
+	if (cpu_is_omap24xx() && clk->prcm_mod == CORE_MOD &&
 	    (reg & 0x0f) == 0) { /* CM_{F,I}CLKEN1 */
 
 		if (clk->enable_bit == OMAP24XX_EN_DSS2_SHIFT ||
@@ -337,7 +338,7 @@ static void omap2_clk_wait_ready(struct clk *clk)
 	if (cpu_is_omap34xx()) {
 
 		/* SSI */
-		if (prcm_mod == OMAP34XX_CM_REGADDR(CORE_MOD, 0) &&
+		if (clk->prcm_mod == CORE_MOD &&
 		    (reg & 0x0f) == 0 &&
 		    clk->enable_bit == OMAP3430_EN_SSI_SHIFT) {
 
@@ -348,7 +349,7 @@ static void omap2_clk_wait_ready(struct clk *clk)
 		}
 
 		/* DSS */
-		if (prcm_mod == OMAP34XX_CM_REGADDR(OMAP3430_DSS_MOD, 0)) {
+		if (clk->prcm_mod == OMAP3430_DSS_MOD) {
 
 			/* 3430ES1 DSS has no target idlest bits */
 			if (system_rev == OMAP3430_REV_ES1_0)
@@ -366,7 +367,7 @@ static void omap2_clk_wait_ready(struct clk *clk)
 
 		/* USBHOST */
 		if (system_rev > OMAP3430_REV_ES1_0 &&
-		    prcm_mod == OMAP34XX_CM_REGADDR(OMAP3430ES2_USBHOST_MOD, 0)) {
+		    clk->prcm_mod == OMAP3430ES2_USBHOST_MOD) {
 
 			/*
 			 * The 120MHz clock apparently has nothing to do with



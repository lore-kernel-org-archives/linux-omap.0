From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH v2 06/11] OMAP2/3 clock: use symbolic constants in
	omap2_clk_wait_ready()
Date: Thu, 18 Sep 2008 11:47:09 -0600
Message-ID: <20080918174706.7146.13322.stgit@localhost.localdomain>
References: <20080918174432.7146.21366.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:55116 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755022AbYIRRsJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Sep 2008 13:48:09 -0400
In-Reply-To: <20080918174432.7146.21366.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>

Convert the bare constants in the register arithmetic in
omap2_clk_wait_ready() to use meaningful symbolic names.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/clock.c |   19 ++++++++++++++-----
 1 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index 2bdd587..ebf2d7e 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -65,6 +65,13 @@
 #define ST_CORE_CLK_REF			0x1
 #define ST_CORE_CLK_32K			0x3
 
+/* Bitmask to isolate the register type of clk.enable_reg */
+#define PRCM_REGTYPE_MASK		0xf0
+/* various CM register type options */
+#define CM_FCLKEN_REGTYPE		0x00
+#define CM_ICLKEN_REGTYPE		0x10
+#define CM_IDLEST_REGTYPE		0x20
+
 u8 cpu_mask;
 
 /*-------------------------------------------------------------------------
@@ -301,12 +308,13 @@ static void omap2_clk_wait_ready(struct clk *clk)
 	prcm_mod = reg & ~0xff;
 	prcm_regid = reg & 0xff;
 
+	other_reg = reg & ~PRCM_REGTYPE_MASK;
+
+	/* If we are enabling an fclk, also test the iclk; and vice versa */
 	if (prcm_regid >= CM_FCLKEN1 && prcm_regid <= OMAP24XX_CM_FCLKEN2)
-		other_reg = ((reg & ~0xf0) | 0x10); /* CM_ICLKEN* */
-	else if (prcm_regid >= CM_ICLKEN1 && prcm_regid <= OMAP24XX_CM_ICLKEN4)
-		other_reg = ((reg & ~0xf0) | 0x00); /* CM_FCLKEN* */
+		other_reg |= CM_ICLKEN_REGTYPE;
 	else
-		return;
+		other_reg |= CM_FCLKEN_REGTYPE;
 
 	/* Covers most of the cases - a few exceptions are below */
 	other_bit = 1 << clk->enable_bit;
@@ -377,7 +385,8 @@ static void omap2_clk_wait_ready(struct clk *clk)
 	if (!(__raw_readl((void __iomem *)other_reg) & other_bit))
 		return;
 
-	idlest_reg = ((other_reg & ~0xf0) | 0x20); /* CM_IDLEST* */
+	idlest_reg = other_reg & ~PRCM_REGTYPE_MASK;
+	idlest_reg |= CM_IDLEST_REGTYPE;
 
 	omap2_wait_clock_ready((void __iomem *)idlest_reg, idlest_bit,
 			       clk->name);



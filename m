From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 04/18] OMAP2 clock: move all static functions to the top of
	the file
Date: Fri, 15 Jan 2010 02:06:55 -0700
Message-ID: <20100115090654.30690.46792.stgit@localhost.localdomain>
References: <20100115090613.30690.49355.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:48721 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756281Ab0AOJIN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 Jan 2010 04:08:13 -0500
In-Reply-To: <20100115090613.30690.49355.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Move static functions to the top of the file and ensure that their names
are prefixed with an underscore to conform with the practice in the newer
OMAP clock code files.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/clock.c |   88 ++++++++++++++++++++++---------------------
 1 files changed, 46 insertions(+), 42 deletions(-)

diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index d3ebb74..0d54fde 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -42,6 +42,51 @@ u8 cpu_mask;
  * OMAP2/3/4 specific clock functions
  *-------------------------------------------------------------------------*/
 
+/* Private functions */
+
+/**
+ * _omap2_module_wait_ready - wait for an OMAP module to leave IDLE
+ * @clk: struct clk * belonging to the module
+ *
+ * If the necessary clocks for the OMAP hardware IP block that
+ * corresponds to clock @clk are enabled, then wait for the module to
+ * indicate readiness (i.e., to leave IDLE).  This code does not
+ * belong in the clock code and will be moved in the medium term to
+ * module-dependent code.  No return value.
+ */
+static void _omap2_module_wait_ready(struct clk *clk)
+{
+	void __iomem *companion_reg, *idlest_reg;
+	u8 other_bit, idlest_bit;
+
+	/* Not all modules have multiple clocks that their IDLEST depends on */
+	if (clk->ops->find_companion) {
+		clk->ops->find_companion(clk, &companion_reg, &other_bit);
+		if (!(__raw_readl(companion_reg) & (1 << other_bit)))
+			return;
+	}
+
+	clk->ops->find_idlest(clk, &idlest_reg, &idlest_bit);
+
+	omap2_cm_wait_idlest(idlest_reg, (1 << idlest_bit), clk->name);
+}
+
+/* Enables clock without considering parent dependencies or use count
+ * REVISIT: Maybe change this to use clk->enable like on omap1?
+ */
+static int _omap2_clk_enable(struct clk *clk)
+{
+	return clk->ops->enable(clk);
+}
+
+/* Disables clock without considering parent dependencies or use count */
+static void _omap2_clk_disable(struct clk *clk)
+{
+	clk->ops->disable(clk);
+}
+
+/* Public functions */
+
 /**
  * omap2xxx_clk_commit - commit clock parent/rate changes in hardware
  * @clk: struct clk *
@@ -149,33 +194,6 @@ void omap2_clk_dflt_find_idlest(struct clk *clk, void __iomem **idlest_reg,
 	*idlest_bit = clk->enable_bit;
 }
 
-/**
- * omap2_module_wait_ready - wait for an OMAP module to leave IDLE
- * @clk: struct clk * belonging to the module
- *
- * If the necessary clocks for the OMAP hardware IP block that
- * corresponds to clock @clk are enabled, then wait for the module to
- * indicate readiness (i.e., to leave IDLE).  This code does not
- * belong in the clock code and will be moved in the medium term to
- * module-dependent code.  No return value.
- */
-static void omap2_module_wait_ready(struct clk *clk)
-{
-	void __iomem *companion_reg, *idlest_reg;
-	u8 other_bit, idlest_bit;
-
-	/* Not all modules have multiple clocks that their IDLEST depends on */
-	if (clk->ops->find_companion) {
-		clk->ops->find_companion(clk, &companion_reg, &other_bit);
-		if (!(__raw_readl(companion_reg) & (1 << other_bit)))
-			return;
-	}
-
-	clk->ops->find_idlest(clk, &idlest_reg, &idlest_bit);
-
-	omap2_cm_wait_idlest(idlest_reg, (1 << idlest_bit), clk->name);
-}
-
 int omap2_dflt_clk_enable(struct clk *clk)
 {
 	u32 v;
@@ -195,7 +213,7 @@ int omap2_dflt_clk_enable(struct clk *clk)
 	v = __raw_readl(clk->enable_reg); /* OCP barrier */
 
 	if (clk->ops->find_idlest)
-		omap2_module_wait_ready(clk);
+		_omap2_module_wait_ready(clk);
 
 	return 0;
 }
@@ -235,20 +253,6 @@ const struct clkops clkops_omap2_dflt = {
 	.disable	= omap2_dflt_clk_disable,
 };
 
-/* Enables clock without considering parent dependencies or use count
- * REVISIT: Maybe change this to use clk->enable like on omap1?
- */
-static int _omap2_clk_enable(struct clk *clk)
-{
-	return clk->ops->enable(clk);
-}
-
-/* Disables clock without considering parent dependencies or use count */
-static void _omap2_clk_disable(struct clk *clk)
-{
-	clk->ops->disable(clk);
-}
-
 void omap2_clk_disable(struct clk *clk)
 {
 	if (clk->usecount > 0 && !(--clk->usecount)) {



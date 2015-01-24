From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 01/23] ARM: OMAP2+: clock: move clock provider infrastructure
 to clock driver
Date: Sat, 24 Jan 2015 21:51:03 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1501242142181.5450@utopia.booyaka.com>
References: <1417103514-17027-1-git-send-email-t-kristo@ti.com> <1417103514-17027-2-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:44610 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751095AbbAXVvF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 24 Jan 2015 16:51:05 -0500
In-Reply-To: <1417103514-17027-2-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org, nm@ti.com, tomi.valkeinen@ti.com, linux-arm-kernel@lists.infradead.org

+ Tomi 

On Thu, 27 Nov 2014, Tero Kristo wrote:

> Splits the clock provider init out of the PRM driver and moves it to
> clock driver. This is needed so that once the PRCM drivers are separated,
> they can logically just access the clock driver not needing to go through
> common PRM code. This would be wrong in the case of control module for
> example.
> 
> Signed-off-by: Tero Kristo <t-kristo@ti.com>

This patch moves things in the wrong direction (ie, rather than keeping 
the PRM register accesses in the PRM code, it moves PRM register accesses 
into the clock code).  But I see that a subsequent patch in this series 
moves them back.  So this change is temporary and that seems reasonable to 
me.

However, as long as the clock code wants to do low-level register accesses 
to PRM/CM/SCM registers, there needs to be some way to keep register 
updates originating from the clock code from racing with register updates 
coming from other code (e.g. non-clock-related PRM/CM/SCM accesses). So 
I've changed this patch to use regmap (as below), and the followup patch 
later in the series will be changed too.  Seems to work so far but let's 
see how things go with the rest of the series.


- Paul

---
 arch/arm/mach-omap2/clock.c       | 103 ++++++++++++++++++++++++++++++++++----
 arch/arm/mach-omap2/clock.h       |   4 +-
 arch/arm/mach-omap2/prcm-common.h |   2 +
 arch/arm/mach-omap2/prm_common.c  |  34 +------------
 4 files changed, 97 insertions(+), 46 deletions(-)

diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index 6ad5b4dbd33e..5fd03e17560f 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -24,6 +24,8 @@
 #include <linux/io.h>
 #include <linux/bitops.h>
 #include <linux/clk-private.h>
+#include <linux/of_address.h>
+#include <linux/regmap.h>
 #include <asm/cpu.h>
 
 #include <trace/events/power.h>
@@ -73,32 +75,111 @@ struct ti_clk_features ti_clk_features;
 static bool clkdm_control = true;
 
 static LIST_HEAD(clk_hw_omap_clocks);
-void __iomem *clk_memmaps[CLK_MAX_MEMMAPS];
+static struct regmap *clk_memmaps[CLK_MAX_MEMMAPS];
+
+static struct regmap_config prcm_regmap_config = {
+	.reg_bits	= 32,
+	.val_bits	= 32,
+	.reg_stride	= 4,
+	.fast_io	= 1,
+};
+
+static void clk_memmap_writel(u32 val, void __iomem *reg)
+{
+	struct clk_omap_reg *r = (struct clk_omap_reg *)&reg;
+
+	/*
+	 * XXX Can't really continue if an error occurred here, since
+	 * this function assumes that the write will always succeed
+	 */
+	if (regmap_write(clk_memmaps[r->index], r->offset, val)) {
+		WARN(1, "omap clock regmap write to %d %d failed\n",
+		     r->index, r->offset);
+		BUG();
+	}
+}
+
+static u32 clk_memmap_readl(void __iomem *reg)
+{
+	struct clk_omap_reg *r = (struct clk_omap_reg *)&reg;
+	unsigned int val = 0;
+
+	/*
+	 * XXX Can't really continue if an error occurred here, since
+	 * this function assumes that the read will always succeed
+	 */
+	if (regmap_read(clk_memmaps[r->index], r->offset, &val)) {
+		WARN(1, "omap clock regmap read from %d %d failed\n",
+		     r->index, r->offset);
+		BUG();
+	}
+
+	return val;
+}
 
 void omap2_clk_writel(u32 val, struct clk_hw_omap *clk, void __iomem *reg)
 {
-	if (clk->flags & MEMMAP_ADDRESSING) {
-		struct clk_omap_reg *r = (struct clk_omap_reg *)&reg;
-		writel_relaxed(val, clk_memmaps[r->index] + r->offset);
-	} else {
+	if (clk->flags & MEMMAP_ADDRESSING)
+		clk_memmap_writel(val, reg);
+	else
 		writel_relaxed(val, reg);
-	}
 }
 
 u32 omap2_clk_readl(struct clk_hw_omap *clk, void __iomem *reg)
 {
 	u32 val;
 
-	if (clk->flags & MEMMAP_ADDRESSING) {
-		struct clk_omap_reg *r = (struct clk_omap_reg *)&reg;
-		val = readl_relaxed(clk_memmaps[r->index] + r->offset);
-	} else {
+	if (clk->flags & MEMMAP_ADDRESSING)
+		val = clk_memmap_readl(reg);
+	else
 		val = readl_relaxed(reg);
-	}
 
 	return val;
 }
 
+static struct ti_clk_ll_ops omap_clk_ll_ops = {
+	.clk_readl = clk_memmap_readl,
+	.clk_writel = clk_memmap_writel,
+};
+
+/**
+ * omap2_clk_provider_init - initialize a clock provider
+ * @match_table: DT device table to match for devices to init
+ *
+ * Initializes a clock provider module (CM/PRM etc.), allocating the
+ * memory mapping, allocating the mapping index and initializing the
+ * low level driver infrastructure. Returns 0 in success, -ENOMEM in
+ * failure.
+ */
+int __init omap2_clk_provider_init(const struct of_device_id *match_table)
+{
+	struct device_node *np;
+	void __iomem *mem;
+	static int memmap_index;
+	struct regmap *regmap;
+
+	ti_clk_ll_ops = &omap_clk_ll_ops;
+
+	for_each_matching_node(np, match_table) {
+		mem = of_iomap(np, 0);
+		if (!mem)
+			return -ENOMEM;
+
+		regmap = regmap_init_mmio(NULL, mem, &prcm_regmap_config);
+		if (IS_ERR(regmap)) {
+			pr_err("omap2 clock: could not create regmap for %s\n",
+			       of_node_full_name(np));
+			continue;
+		}
+
+		clk_memmaps[memmap_index] = regmap;
+		ti_dt_clk_init_provider(np, memmap_index);
+		memmap_index++;
+	}
+
+	return 0;
+}
+
 /*
  * OMAP2+ specific clock functions
  */
diff --git a/arch/arm/mach-omap2/clock.h b/arch/arm/mach-omap2/clock.h
index 1cf9dd85248a..a3b634978a0f 100644
--- a/arch/arm/mach-omap2/clock.h
+++ b/arch/arm/mach-omap2/clock.h
@@ -267,12 +267,12 @@ extern const struct clksel_rate div_1_3_rates[];
 extern const struct clksel_rate div_1_4_rates[];
 extern const struct clksel_rate div31_1to31_rates[];
 
-extern void __iomem *clk_memmaps[];
-
 extern int omap2_clkops_enable_clkdm(struct clk_hw *hw);
 extern void omap2_clkops_disable_clkdm(struct clk_hw *hw);
 
 extern void omap_clocks_register(struct omap_clk *oclks, int cnt);
 
+int __init omap2_clk_provider_init(const struct of_device_id *match_table);
+
 void __init ti_clk_init_features(void);
 #endif
diff --git a/arch/arm/mach-omap2/prcm-common.h b/arch/arm/mach-omap2/prcm-common.h
index a8e4b582c527..22afef0a4794 100644
--- a/arch/arm/mach-omap2/prcm-common.h
+++ b/arch/arm/mach-omap2/prcm-common.h
@@ -517,6 +517,8 @@ struct omap_prcm_irq_setup {
 	.priority = _priority				\
 	}
 
+struct of_device_id;
+
 extern void omap_prcm_irq_cleanup(void);
 extern int omap_prcm_register_chain_handler(
 	struct omap_prcm_irq_setup *irq_setup);
diff --git a/arch/arm/mach-omap2/prm_common.c b/arch/arm/mach-omap2/prm_common.c
index 779940cb6e56..9f736d282303 100644
--- a/arch/arm/mach-omap2/prm_common.c
+++ b/arch/arm/mach-omap2/prm_common.c
@@ -590,41 +590,9 @@ static const struct of_device_id omap_prcm_dt_match_table[] = {
 	{ }
 };
 
-static struct clk_hw_omap memmap_dummy_ck = {
-	.flags = MEMMAP_ADDRESSING,
-};
-
-static u32 prm_clk_readl(void __iomem *reg)
-{
-	return omap2_clk_readl(&memmap_dummy_ck, reg);
-}
-
-static void prm_clk_writel(u32 val, void __iomem *reg)
-{
-	omap2_clk_writel(val, &memmap_dummy_ck, reg);
-}
-
-static struct ti_clk_ll_ops omap_clk_ll_ops = {
-	.clk_readl = prm_clk_readl,
-	.clk_writel = prm_clk_writel,
-};
-
 int __init of_prcm_init(void)
 {
-	struct device_node *np;
-	void __iomem *mem;
-	int memmap_index = 0;
-
-	ti_clk_ll_ops = &omap_clk_ll_ops;
-
-	for_each_matching_node(np, omap_prcm_dt_match_table) {
-		mem = of_iomap(np, 0);
-		clk_memmaps[memmap_index] = mem;
-		ti_dt_clk_init_provider(np, memmap_index);
-		memmap_index++;
-	}
-
-	return 0;
+	return omap2_clk_provider_init(omap_prcm_dt_match_table);
 }
 
 static int __init prm_late_init(void)
-- 
2.1.4


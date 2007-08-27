From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 07/27] omap2 clock: init clksel clock parents to hardware
	reality at clock init
Date: Mon, 27 Aug 2007 02:39:03 -0600
Message-ID: <20070827084122.756992676@pwsan.com>
References: <20070827083856.549249288@pwsan.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline; filename=add_init_clksel_parent.patch
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Source-selectable clksel clocks have a 'default parent' assigned to them
at compile-time.  This default parent may or may not match the reality 
that is configured in the hardware registers by the bootloader.  Clock tree
recalculations could be erratic if the struct clk parent field contents
don't match the hardware registers.

Resolve this by creating omap2_init_clksel_parent() to read the hardware
registers and update the struct clk parent field as appropriate for clksel
clocks.  Add an '.init' field to each source-selectable clk structure so
that the parent is fixed up when the clock is initially registered.  (We
don't do this for clksel clocks that are only rate-selectable, since they
only have one possible parent clock.)

Signed-off-by: Paul Walmsley <paul@pwsan.com>

---
 arch/arm/mach-omap2/clock.c |   59 ++++++++++++++++++++++++++++++++++++++++----
 arch/arm/mach-omap2/clock.h |   22 ++++++++++++++++
 2 files changed, 76 insertions(+), 5 deletions(-)

Index: linux-omap/arch/arm/mach-omap2/clock.c
===================================================================
--- linux-omap.orig/arch/arm/mach-omap2/clock.c	2007-08-27 00:37:39.000000000 -0600
+++ linux-omap/arch/arm/mach-omap2/clock.c	2007-08-27 00:37:46.000000000 -0600
@@ -93,6 +93,55 @@
  * Omap2 specific clock functions
  *-------------------------------------------------------------------------*/
 
+static inline u8 mask_to_shift(u32 mask)
+{
+	return ffs(mask) - 1;
+}
+
+/**
+ * omap2_init_clksel_parent - set a clksel clk's parent field from the hardware
+ * @clk: OMAP clock struct ptr to use
+ *
+ * Given a pointer to a source-selectable struct clk, read the hardware
+ * register and determine what its parent is currently set to.  Update the
+ * clk->parent field with the appropriate clk ptr.
+ */
+static void omap2_init_clksel_parent(struct clk *clk)
+{
+	const struct clksel *clks;
+	const struct clksel_rate *clkr;
+	u32 r, found = 0;
+
+	if (!clk->clksel)
+		return;
+
+	/* XXX Should be __raw_readl for non-CM 3430 clocks ? */
+	r = cm_read_reg(clk->clksel_reg) & clk->clksel_mask;
+	r >>= mask_to_shift(clk->clksel_mask);
+
+	for (clks = clk->clksel; clks->parent && !found; clks++) {
+		for (clkr = clks->rates; clkr->div && !found; clkr++) {
+			if ((clkr->flags & cpu_mask) && (clkr->val == r)) {
+				if (clk->parent != clks->parent) {
+					pr_debug("clock: inited %s parent "
+						 "to %s (was %s)\n",
+						 clk->name, clks->parent->name,
+						 ((clk->parent->name) ?
+						  clk->parent->name : "NULL"));
+					clk->parent = clks->parent;
+				};
+				found = 1;
+			}
+		}
+	}
+
+	if (!found)
+		printk(KERN_ERR "clock: init parent: could not find "
+		       "regval %0x for clock %s\n", r,  clk->name);
+
+	return;
+}
+
 /* Recalculate SYST_CLK */
 static void omap2_sys_clk_recalc(struct clk * clk)
 {
@@ -1193,6 +1242,11 @@
 	struct clk ** clkp;
 	u32 clkrate;
 
+	if (cpu_is_omap242x())
+		cpu_mask = RATE_IN_242X;
+	else if (cpu_is_omap2430())
+		cpu_mask = RATE_IN_243X;
+
 	clk_init(&omap2_clk_functions);
 	omap2_get_crystal_rate(&osc_ck, &sys_ck);
 
@@ -1210,11 +1264,6 @@
 		}
 	}
 
-	if (cpu_is_omap242x())
-		cpu_mask = RATE_IN_242X;
-	else if (cpu_is_omap2430())
-		cpu_mask = RATE_IN_243X;
-
 	/* Check the MPU rate set by bootloader */
 	clkrate = omap2_get_dpll_rate(&dpll_ck);
 	for (prcm = rate_table; prcm->mpu_speed; prcm++) {
Index: linux-omap/arch/arm/mach-omap2/clock.h
===================================================================
--- linux-omap.orig/arch/arm/mach-omap2/clock.h	2007-08-27 00:37:43.000000000 -0600
+++ linux-omap/arch/arm/mach-omap2/clock.h	2007-08-27 00:37:46.000000000 -0600
@@ -29,6 +29,7 @@
 static long omap2_round_to_table_rate(struct clk * clk, unsigned long rate);
 static void omap2_clk_disable(struct clk *clk);
 static void omap2_sys_clk_recalc(struct clk * clk);
+static void omap2_init_clksel_parent(struct clk *clk);
 static u32 omap2_clksel_to_divisor(u32 div_sel, u32 field_val);
 static u32 omap2_clksel_get_divisor(struct clk *clk);
 static void omap2_dpll_recalc(struct clk *clk);
@@ -690,6 +691,7 @@
 				RATE_FIXED | CM_PLL_SEL1 | RATE_PROPAGATES |
 				PARENT_CONTROLS_CLOCK,
 	.src_offset	= OMAP24XX_54M_SOURCE_SHIFT,
+	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_CLKSEL1),
 	.clksel_mask	= OMAP24XX_54M_SOURCE,
 	.clksel		= func_54m_clksel,
@@ -729,6 +731,7 @@
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
 				RATE_FIXED | RATE_PROPAGATES |
 				PARENT_CONTROLS_CLOCK,
+	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_CLKSEL1),
 	.clksel_mask	= OMAP2430_96M_SOURCE,
 	.clksel		= func_96m_clksel,
@@ -761,6 +764,7 @@
 				RATE_FIXED | CM_PLL_SEL1 | RATE_PROPAGATES |
 				PARENT_CONTROLS_CLOCK,
 	.src_offset	= OMAP24XX_48M_SOURCE_SHIFT,
+	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_CLKSEL1),
 	.clksel_mask	= OMAP24XX_48M_SOURCE,
 	.clksel		= func_48m_clksel,
@@ -830,6 +834,7 @@
 	.src_offset	= OMAP24XX_CLKOUT_SOURCE_SHIFT,
 	.enable_reg	= OMAP24XX_PRCM_CLKOUT_CTRL,
 	.enable_bit	= OMAP24XX_CLKOUT_EN_SHIFT,
+	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= OMAP24XX_PRCM_CLKOUT_CTRL,
 	.clksel_mask	= OMAP24XX_CLKOUT_SOURCE_MASK,
 	.clksel		= common_clkout_src_clksel,
@@ -872,6 +877,7 @@
 				RATE_PROPAGATES,
 	.enable_reg	= OMAP24XX_PRCM_CLKOUT_CTRL,
 	.enable_bit	= OMAP2420_CLKOUT2_EN_SHIFT,
+	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= OMAP24XX_PRCM_CLKOUT_CTRL,
 	.clksel_mask	= OMAP2420_CLKOUT2_SOURCE_MASK,
 	.clksel		= common_clkout_src_clksel,
@@ -937,6 +943,7 @@
 				ALWAYS_ENABLED | CM_MPU_SEL1 | DELAYED_APP |
 				CONFIG_PARTICIPANT | RATE_PROPAGATES,
 	.rate_offset	= OMAP24XX_CLKSEL_MPU_SHIFT,	/* bits 0-4 */
+	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= OMAP_CM_REGADDR(MPU_MOD, CM_CLKSEL),
 	.clksel_mask	= OMAP24XX_CLKSEL_MPU_MASK,
 	.clksel		= mpu_clksel,
@@ -1431,6 +1438,7 @@
 	.enable_bit	= OMAP24XX_EN_DSS1_SHIFT,
 	.rate_offset	= OMAP24XX_CLKSEL_DSS1_SHIFT,
 	.src_offset	= OMAP24XX_CLKSEL_DSS1_SHIFT,
+	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL1),
 	.clksel_mask	= OMAP24XX_CLKSEL_DSS1_MASK,
 	.clksel		= dss1_fck_clksel,
@@ -1462,6 +1470,7 @@
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP24XX_EN_DSS2_SHIFT,
 	.src_offset	= OMAP24XX_CLKSEL_DSS2_SHIFT,
+	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL1),
 	.clksel_mask	= OMAP24XX_CLKSEL_DSS2_MASK,
 	.clksel		= dss2_fck_clksel,
@@ -1522,6 +1531,7 @@
 	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, OMAP24XX_CM_FCLKEN),	/* Bit0 */
 	.enable_bit	= OMAP24XX_EN_GPT1_SHIFT,
 	.src_offset	= OMAP24XX_CLKSEL_GPT1_SHIFT,
+	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL2),
 	.clksel_mask	= OMAP24XX_CLKSEL_GPT1_MASK,
 	.clksel		= gpt_clksel,
@@ -1545,6 +1555,7 @@
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP24XX_EN_GPT2_SHIFT,
 	.src_offset	= OMAP24XX_CLKSEL_GPT2_SHIFT,
+	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL2),
 	.clksel_mask	= OMAP24XX_CLKSEL_GPT2_MASK,
 	.clksel		= gpt_clksel,
@@ -1568,6 +1579,7 @@
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP24XX_EN_GPT3_SHIFT,
 	.src_offset	= OMAP24XX_CLKSEL_GPT3_SHIFT,
+	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL2),
 	.clksel_mask	= OMAP24XX_CLKSEL_GPT3_MASK,
 	.clksel		= gpt_clksel,
@@ -1591,6 +1603,7 @@
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP24XX_EN_GPT4_SHIFT,
 	.src_offset	= OMAP24XX_CLKSEL_GPT4_SHIFT,
+	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL2),
 	.clksel_mask	= OMAP24XX_CLKSEL_GPT4_MASK,
 	.clksel		= gpt_clksel,
@@ -1614,6 +1627,7 @@
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP24XX_EN_GPT5_SHIFT,
 	.src_offset	= OMAP24XX_CLKSEL_GPT5_SHIFT,
+	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL2),
 	.clksel_mask	= OMAP24XX_CLKSEL_GPT5_MASK,
 	.clksel		= gpt_clksel,
@@ -1637,6 +1651,7 @@
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP24XX_EN_GPT6_SHIFT,
 	.src_offset	= OMAP24XX_CLKSEL_GPT6_SHIFT,
+	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL2),
 	.clksel_mask	= OMAP24XX_CLKSEL_GPT6_MASK,
 	.clksel		= gpt_clksel,
@@ -1660,6 +1675,7 @@
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP24XX_EN_GPT7_SHIFT,
 	.src_offset	= OMAP24XX_CLKSEL_GPT7_SHIFT,
+	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL2),
 	.clksel_mask	= OMAP24XX_CLKSEL_GPT7_MASK,
 	.clksel		= gpt_clksel,
@@ -1683,6 +1699,7 @@
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP24XX_EN_GPT8_SHIFT,
 	.src_offset	= OMAP24XX_CLKSEL_GPT8_SHIFT,
+	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL2),
 	.clksel_mask	= OMAP24XX_CLKSEL_GPT8_MASK,
 	.clksel		= gpt_clksel,
@@ -1706,6 +1723,7 @@
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP24XX_EN_GPT9_SHIFT,
 	.src_offset	= OMAP24XX_CLKSEL_GPT9_SHIFT,
+	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL2),
 	.clksel_mask	= OMAP24XX_CLKSEL_GPT9_MASK,
 	.clksel		= gpt_clksel,
@@ -1729,6 +1747,7 @@
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP24XX_EN_GPT10_SHIFT,
 	.src_offset	= OMAP24XX_CLKSEL_GPT10_SHIFT,
+	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL2),
 	.clksel_mask	= OMAP24XX_CLKSEL_GPT10_MASK,
 	.clksel		= gpt_clksel,
@@ -1752,6 +1771,7 @@
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP24XX_EN_GPT11_SHIFT,
 	.src_offset	= OMAP24XX_CLKSEL_GPT11_SHIFT,
+	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL2),
 	.clksel_mask	= OMAP24XX_CLKSEL_GPT11_MASK,
 	.clksel		= gpt_clksel,
@@ -1775,6 +1795,7 @@
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP24XX_EN_GPT12_SHIFT,
 	.src_offset	= OMAP24XX_CLKSEL_GPT12_SHIFT,
+	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL2),
 	.clksel_mask	= OMAP24XX_CLKSEL_GPT12_MASK,
 	.clksel		= gpt_clksel,
@@ -2308,6 +2329,7 @@
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP2420_EN_VLYNQ_SHIFT,
 	.src_offset	= OMAP2420_CLKSEL_VLYNQ_SHIFT,
+	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL1),
 	.clksel_mask	= OMAP2420_CLKSEL_VLYNQ_MASK,
 	.clksel		= vlynq_fck_clksel,

-- 

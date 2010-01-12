From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 4/5] OMAP clock: make the fixed divisor clock code available
	for all OMAPs
Date: Mon, 11 Jan 2010 17:46:28 -0700
Message-ID: <20100112004626.24684.78998.stgit@localhost.localdomain>
References: <20100112004326.24684.91321.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:55145 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753277Ab0ALArb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Jan 2010 19:47:31 -0500
In-Reply-To: <20100112004326.24684.91321.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

One of the OMAP1 clocks can use the fixed divisor recalculation code
introduced in the OMAP2 clock code, so rename the
omap2_fixed_divisor_recalc() function to omap_fixed_divisor_recalc()
and make it available to all OMAPs.  A followup patch converts the OMAP1
clock.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/clock.c             |   11 -----------
 arch/arm/mach-omap2/clock.h             |    1 -
 arch/arm/mach-omap2/clock2xxx_data.c    |    4 ++--
 arch/arm/mach-omap2/clock34xx_data.c    |    6 +++---
 arch/arm/plat-omap/clock.c              |   11 +++++++++++
 arch/arm/plat-omap/include/plat/clock.h |    3 ++-
 6 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index 759c72a..7565f8e 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -300,17 +300,6 @@ u32 omap2_get_dpll_rate(struct clk *clk)
 	return dpll_clk;
 }
 
-/*
- * Used for clocks that have the same value as the parent clock,
- * divided by some factor
- */
-unsigned long omap2_fixed_divisor_recalc(struct clk *clk)
-{
-	WARN_ON(!clk->fixed_div);
-
-	return clk->parent->rate / clk->fixed_div;
-}
-
 /**
  * omap2_clk_dflt_find_companion - find companion clock to @clk
  * @clk: struct clk * to find the companion clock of
diff --git a/arch/arm/mach-omap2/clock.h b/arch/arm/mach-omap2/clock.h
index 93c48df..0d70dc0 100644
--- a/arch/arm/mach-omap2/clock.h
+++ b/arch/arm/mach-omap2/clock.h
@@ -78,7 +78,6 @@ u32 omap2_clksel_round_rate_div(struct clk *clk, unsigned long target_rate,
 				u32 *new_div);
 u32 omap2_clksel_to_divisor(struct clk *clk, u32 field_val);
 u32 omap2_divisor_to_clksel(struct clk *clk, u32 div);
-unsigned long omap2_fixed_divisor_recalc(struct clk *clk);
 long omap2_clksel_round_rate(struct clk *clk, unsigned long target_rate);
 int omap2_clksel_set_rate(struct clk *clk, unsigned long rate);
 u32 omap2_get_dpll_rate(struct clk *clk);
diff --git a/arch/arm/mach-omap2/clock2xxx_data.c b/arch/arm/mach-omap2/clock2xxx_data.c
index 97dc7cf..402115f 100644
--- a/arch/arm/mach-omap2/clock2xxx_data.c
+++ b/arch/arm/mach-omap2/clock2xxx_data.c
@@ -261,7 +261,7 @@ static struct clk func_12m_ck = {
 	.parent		= &func_48m_ck,
 	.fixed_div	= 4,
 	.clkdm_name	= "wkup_clkdm",
-	.recalc		= &omap2_fixed_divisor_recalc,
+	.recalc		= &omap_fixed_divisor_recalc,
 };
 
 /* Secure timer, only available in secure mode */
@@ -557,7 +557,7 @@ static struct clk iva1_mpu_int_ifck = {
 	.enable_reg	= OMAP_CM_REGADDR(OMAP24XX_DSP_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP2420_EN_IVA_MPU_SHIFT,
 	.fixed_div	= 2,
-	.recalc		= &omap2_fixed_divisor_recalc,
+	.recalc		= &omap_fixed_divisor_recalc,
 };
 
 /*
diff --git a/arch/arm/mach-omap2/clock34xx_data.c b/arch/arm/mach-omap2/clock34xx_data.c
index 409d445..856b44c 100644
--- a/arch/arm/mach-omap2/clock34xx_data.c
+++ b/arch/arm/mach-omap2/clock34xx_data.c
@@ -736,7 +736,7 @@ static struct clk omap_12m_fck = {
 	.ops		= &clkops_null,
 	.parent		= &omap_48m_fck,
 	.fixed_div	= 4,
-	.recalc		= &omap2_fixed_divisor_recalc,
+	.recalc		= &omap_fixed_divisor_recalc,
 };
 
 /* This virstual clock is the source for dpll4_m4x2_ck */
@@ -1592,7 +1592,7 @@ static struct clk ssi_sst_fck_3430es1 = {
 	.ops		= &clkops_null,
 	.parent		= &ssi_ssr_fck_3430es1,
 	.fixed_div	= 2,
-	.recalc		= &omap2_fixed_divisor_recalc,
+	.recalc		= &omap_fixed_divisor_recalc,
 };
 
 static struct clk ssi_sst_fck_3430es2 = {
@@ -1600,7 +1600,7 @@ static struct clk ssi_sst_fck_3430es2 = {
 	.ops		= &clkops_null,
 	.parent		= &ssi_ssr_fck_3430es2,
 	.fixed_div	= 2,
-	.recalc		= &omap2_fixed_divisor_recalc,
+	.recalc		= &omap_fixed_divisor_recalc,
 };
 
 
diff --git a/arch/arm/plat-omap/clock.c b/arch/arm/plat-omap/clock.c
index d9f8c84..e0f72f4 100644
--- a/arch/arm/plat-omap/clock.c
+++ b/arch/arm/plat-omap/clock.c
@@ -199,6 +199,17 @@ unsigned long followparent_recalc(struct clk *clk)
 	return clk->parent->rate;
 }
 
+/*
+ * Used for clocks that have the same value as the parent clock,
+ * divided by some factor
+ */
+unsigned long omap_fixed_divisor_recalc(struct clk *clk)
+{
+	WARN_ON(!clk->fixed_div);
+
+	return clk->parent->rate / clk->fixed_div;
+}
+
 void clk_reparent(struct clk *child, struct clk *parent)
 {
 	list_del_init(&child->sibling);
diff --git a/arch/arm/plat-omap/include/plat/clock.h b/arch/arm/plat-omap/include/plat/clock.h
index 94fe2a0..896cedc 100644
--- a/arch/arm/plat-omap/include/plat/clock.h
+++ b/arch/arm/plat-omap/include/plat/clock.h
@@ -88,9 +88,9 @@ struct clk {
 	void			(*init)(struct clk *);
 	__u8			enable_bit;
 	__s8			usecount;
+	u8			fixed_div;
 #if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3) || \
 		defined(CONFIG_ARCH_OMAP4)
-	u8			fixed_div;
 	void __iomem		*clksel_reg;
 	u32			clksel_mask;
 	const struct clksel	*clksel;
@@ -134,6 +134,7 @@ extern void propagate_rate(struct clk *clk);
 extern void recalculate_root_clocks(void);
 extern unsigned long followparent_recalc(struct clk *clk);
 extern void clk_enable_init_clocks(void);
+unsigned long omap_fixed_divisor_recalc(struct clk *clk);
 #ifdef CONFIG_CPU_FREQ
 extern void clk_init_cpufreq_table(struct cpufreq_frequency_table **table);
 extern void clk_exit_cpufreq_table(struct cpufreq_frequency_table **table);



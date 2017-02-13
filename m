From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 15/15] clk: ti: convert to use proper register definition for all accesses
Date: Mon, 13 Feb 2017 11:35:11 +0200
Message-ID: <1486978511-29668-16-git-send-email-t-kristo@ti.com>
References: <1486978511-29668-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <1486978511-29668-1-git-send-email-t-kristo@ti.com>
Sender: linux-clk-owner@vger.kernel.org
To: linux-clk@vger.kernel.org, linux-omap@vger.kernel.org, tony@atomide.com, sboyd@codeaurora.org, mturquette@baylibre.com
Cc: linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Currently, TI clock driver uses an encapsulated struct that is cast into
a void pointer to store all register addresses. This can be considered
as rather nasty hackery, and prevents from expanding the register
address field also. Instead, replace all the code to use proper struct
in place for this, which contains all the previously used data.

This patch is rather large as it is touching multiple files, but this
can't be split up as we need to avoid any boot breakage.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/clkt2xxx_dpllcore.c |  3 +-
 arch/arm/mach-omap2/clock.c             |  2 +-
 arch/arm/mach-omap2/clock.h             |  2 ++
 arch/arm/mach-omap2/cm.h                |  5 +--
 arch/arm/mach-omap2/cm2xxx.c            |  9 ++---
 arch/arm/mach-omap2/cm3xxx.c            | 10 ++----
 arch/arm/mach-omap2/cm_common.c         |  2 +-
 drivers/clk/ti/apll.c                   | 47 ++++++++++++-------------
 drivers/clk/ti/autoidle.c               | 18 +++++-----
 drivers/clk/ti/clk-3xxx.c               | 55 +++++++++++++++--------------
 drivers/clk/ti/clk.c                    | 47 ++++++++++++-------------
 drivers/clk/ti/clkt_dflt.c              | 61 ++++++++++++---------------------
 drivers/clk/ti/clkt_dpll.c              |  6 ++--
 drivers/clk/ti/clkt_iclk.c              | 29 ++++++++--------
 drivers/clk/ti/clock.h                  | 11 +++---
 drivers/clk/ti/clockdomain.c            |  8 -----
 drivers/clk/ti/divider.c                | 24 +++++++------
 drivers/clk/ti/dpll.c                   | 48 ++++++++++----------------
 drivers/clk/ti/dpll3xxx.c               | 38 ++++++++++----------
 drivers/clk/ti/dpll44xx.c               | 14 ++++----
 drivers/clk/ti/gate.c                   | 32 ++++++++---------
 drivers/clk/ti/interface.c              | 22 ++++++------
 drivers/clk/ti/mux.c                    | 41 +++++++++-------------
 include/linux/clk/ti.h                  | 46 +++++++++++++------------
 24 files changed, 264 insertions(+), 316 deletions(-)

diff --git a/arch/arm/mach-omap2/clkt2xxx_dpllcore.c b/arch/arm/mach-omap2/clkt2xxx_dpllcore.c
index 59cf310..e8d4173 100644
--- a/arch/arm/mach-omap2/clkt2xxx_dpllcore.c
+++ b/arch/arm/mach-omap2/clkt2xxx_dpllcore.c
@@ -138,7 +138,8 @@ int omap2_reprogram_dpllcore(struct clk_hw *hw, unsigned long rate,
 		if (!dd)
 			return -EINVAL;
 
-		tmpset.cm_clksel1_pll = readl_relaxed(dd->mult_div1_reg);
+		tmpset.cm_clksel1_pll =
+			omap_clk_ll_ops.clk_readl(&dd->mult_div1_reg);
 		tmpset.cm_clksel1_pll &= ~(dd->mult_mask |
 					   dd->div1_mask);
 		div = ((curr_prcm_set->xtal_speed / 1000000) - 1);
diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index ce8e804..4c775cf 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -54,7 +54,7 @@
 #define OMAP3PLUS_DPLL_FINT_MIN		32000
 #define OMAP3PLUS_DPLL_FINT_MAX		52000000
 
-static struct ti_clk_ll_ops omap_clk_ll_ops = {
+struct ti_clk_ll_ops omap_clk_ll_ops = {
 	.clkdm_clk_enable = clkdm_clk_enable,
 	.clkdm_clk_disable = clkdm_clk_disable,
 	.clkdm_lookup = clkdm_lookup,
diff --git a/arch/arm/mach-omap2/clock.h b/arch/arm/mach-omap2/clock.h
index 67da640..9cb6f1a 100644
--- a/arch/arm/mach-omap2/clock.h
+++ b/arch/arm/mach-omap2/clock.h
@@ -64,6 +64,8 @@
 #define OMAP4XXX_EN_DPLL_FRBYPASS		0x6
 #define OMAP4XXX_EN_DPLL_LOCKED			0x7
 
+extern struct ti_clk_ll_ops omap_clk_ll_ops;
+
 void omap2_clk_print_new_rates(const char *hfclkin_ck_name,
 			       const char *core_ck_name,
 			       const char *mpu_ck_name);
diff --git a/arch/arm/mach-omap2/cm.h b/arch/arm/mach-omap2/cm.h
index 1fe3e6b..de75cbc 100644
--- a/arch/arm/mach-omap2/cm.h
+++ b/arch/arm/mach-omap2/cm.h
@@ -23,6 +23,7 @@
 #define MAX_MODULE_READY_TIME		2000
 
 # ifndef __ASSEMBLER__
+#include <linux/clk/ti.h>
 extern void __iomem *cm_base;
 extern void __iomem *cm2_base;
 extern void omap2_set_globals_cm(void __iomem *cm, void __iomem *cm2);
@@ -50,7 +51,7 @@
  * @module_disable: ptr to the SoC CM-specific module_disable impl
  */
 struct cm_ll_data {
-	int (*split_idlest_reg)(void __iomem *idlest_reg, s16 *prcm_inst,
+	int (*split_idlest_reg)(struct clk_omap_reg *idlest_reg, s16 *prcm_inst,
 				u8 *idlest_reg_id);
 	int (*wait_module_ready)(u8 part, s16 prcm_mod, u16 idlest_reg,
 				 u8 idlest_shift);
@@ -60,7 +61,7 @@ struct cm_ll_data {
 	void (*module_disable)(u8 part, u16 inst, u16 clkctrl_offs);
 };
 
-extern int cm_split_idlest_reg(void __iomem *idlest_reg, s16 *prcm_inst,
+extern int cm_split_idlest_reg(struct clk_omap_reg *idlest_reg, s16 *prcm_inst,
 			       u8 *idlest_reg_id);
 int omap_cm_wait_module_ready(u8 part, s16 prcm_mod, u16 idlest_reg,
 			      u8 idlest_shift);
diff --git a/arch/arm/mach-omap2/cm2xxx.c b/arch/arm/mach-omap2/cm2xxx.c
index 3e5fd35..cd90b4c 100644
--- a/arch/arm/mach-omap2/cm2xxx.c
+++ b/arch/arm/mach-omap2/cm2xxx.c
@@ -204,7 +204,7 @@ void omap2xxx_cm_apll96_disable(void)
  * XXX This function is only needed until absolute register addresses are
  * removed from the OMAP struct clk records.
  */
-static int omap2xxx_cm_split_idlest_reg(void __iomem *idlest_reg,
+static int omap2xxx_cm_split_idlest_reg(struct clk_omap_reg *idlest_reg,
 					s16 *prcm_inst,
 					u8 *idlest_reg_id)
 {
@@ -212,10 +212,7 @@ static int omap2xxx_cm_split_idlest_reg(void __iomem *idlest_reg,
 	u8 idlest_offs;
 	int i;
 
-	if (idlest_reg < cm_base || idlest_reg > (cm_base + 0x0fff))
-		return -EINVAL;
-
-	idlest_offs = (unsigned long)idlest_reg & 0xff;
+	idlest_offs = idlest_reg->offset & 0xff;
 	for (i = 0; i < ARRAY_SIZE(omap2xxx_cm_idlest_offs); i++) {
 		if (idlest_offs == omap2xxx_cm_idlest_offs[i]) {
 			*idlest_reg_id = i + 1;
@@ -226,7 +223,7 @@ static int omap2xxx_cm_split_idlest_reg(void __iomem *idlest_reg,
 	if (i == ARRAY_SIZE(omap2xxx_cm_idlest_offs))
 		return -EINVAL;
 
-	offs = idlest_reg - cm_base;
+	offs = idlest_reg->offset;
 	offs &= 0xff00;
 	*prcm_inst = offs;
 
diff --git a/arch/arm/mach-omap2/cm3xxx.c b/arch/arm/mach-omap2/cm3xxx.c
index d91ae82..55b046a 100644
--- a/arch/arm/mach-omap2/cm3xxx.c
+++ b/arch/arm/mach-omap2/cm3xxx.c
@@ -118,7 +118,7 @@ static int omap3xxx_cm_wait_module_ready(u8 part, s16 prcm_mod, u16 idlest_id,
  * XXX This function is only needed until absolute register addresses are
  * removed from the OMAP struct clk records.
  */
-static int omap3xxx_cm_split_idlest_reg(void __iomem *idlest_reg,
+static int omap3xxx_cm_split_idlest_reg(struct clk_omap_reg *idlest_reg,
 					s16 *prcm_inst,
 					u8 *idlest_reg_id)
 {
@@ -126,11 +126,7 @@ static int omap3xxx_cm_split_idlest_reg(void __iomem *idlest_reg,
 	u8 idlest_offs;
 	int i;
 
-	if (idlest_reg < (cm_base + OMAP3430_IVA2_MOD) ||
-	    idlest_reg > (cm_base + 0x1ffff))
-		return -EINVAL;
-
-	idlest_offs = (unsigned long)idlest_reg & 0xff;
+	idlest_offs = idlest_reg->offset & 0xff;
 	for (i = 0; i < ARRAY_SIZE(omap3xxx_cm_idlest_offs); i++) {
 		if (idlest_offs == omap3xxx_cm_idlest_offs[i]) {
 			*idlest_reg_id = i + 1;
@@ -141,7 +137,7 @@ static int omap3xxx_cm_split_idlest_reg(void __iomem *idlest_reg,
 	if (i == ARRAY_SIZE(omap3xxx_cm_idlest_offs))
 		return -EINVAL;
 
-	offs = idlest_reg - cm_base;
+	offs = idlest_reg->offset;
 	offs &= 0xff00;
 	*prcm_inst = offs;
 
diff --git a/arch/arm/mach-omap2/cm_common.c b/arch/arm/mach-omap2/cm_common.c
index 23e8bce..bbe41f4 100644
--- a/arch/arm/mach-omap2/cm_common.c
+++ b/arch/arm/mach-omap2/cm_common.c
@@ -65,7 +65,7 @@ void __init omap2_set_globals_cm(void __iomem *cm, void __iomem *cm2)
  * or 0 upon success.  XXX This function is only needed until absolute
  * register addresses are removed from the OMAP struct clk records.
  */
-int cm_split_idlest_reg(void __iomem *idlest_reg, s16 *prcm_inst,
+int cm_split_idlest_reg(struct clk_omap_reg *idlest_reg, s16 *prcm_inst,
 			u8 *idlest_reg_id)
 {
 	if (!cm_ll_data->split_idlest_reg) {
diff --git a/drivers/clk/ti/apll.c b/drivers/clk/ti/apll.c
index 5cba28c..06f486b 100644
--- a/drivers/clk/ti/apll.c
+++ b/drivers/clk/ti/apll.c
@@ -55,20 +55,20 @@ static int dra7_apll_enable(struct clk_hw *hw)
 	state <<= __ffs(ad->idlest_mask);
 
 	/* Check is already locked */
-	v = ti_clk_ll_ops->clk_readl(ad->idlest_reg);
+	v = ti_clk_ll_ops->clk_readl(&ad->idlest_reg);
 
 	if ((v & ad->idlest_mask) == state)
 		return r;
 
-	v = ti_clk_ll_ops->clk_readl(ad->control_reg);
+	v = ti_clk_ll_ops->clk_readl(&ad->control_reg);
 	v &= ~ad->enable_mask;
 	v |= APLL_FORCE_LOCK << __ffs(ad->enable_mask);
-	ti_clk_ll_ops->clk_writel(v, ad->control_reg);
+	ti_clk_ll_ops->clk_writel(v, &ad->control_reg);
 
 	state <<= __ffs(ad->idlest_mask);
 
 	while (1) {
-		v = ti_clk_ll_ops->clk_readl(ad->idlest_reg);
+		v = ti_clk_ll_ops->clk_readl(&ad->idlest_reg);
 		if ((v & ad->idlest_mask) == state)
 			break;
 		if (i > MAX_APLL_WAIT_TRIES)
@@ -99,10 +99,10 @@ static void dra7_apll_disable(struct clk_hw *hw)
 
 	state <<= __ffs(ad->idlest_mask);
 
-	v = ti_clk_ll_ops->clk_readl(ad->control_reg);
+	v = ti_clk_ll_ops->clk_readl(&ad->control_reg);
 	v &= ~ad->enable_mask;
 	v |= APLL_AUTO_IDLE << __ffs(ad->enable_mask);
-	ti_clk_ll_ops->clk_writel(v, ad->control_reg);
+	ti_clk_ll_ops->clk_writel(v, &ad->control_reg);
 }
 
 static int dra7_apll_is_enabled(struct clk_hw *hw)
@@ -113,7 +113,7 @@ static int dra7_apll_is_enabled(struct clk_hw *hw)
 
 	ad = clk->dpll_data;
 
-	v = ti_clk_ll_ops->clk_readl(ad->control_reg);
+	v = ti_clk_ll_ops->clk_readl(&ad->control_reg);
 	v &= ad->enable_mask;
 
 	v >>= __ffs(ad->enable_mask);
@@ -185,6 +185,7 @@ static void __init of_dra7_apll_setup(struct device_node *node)
 	struct clk_hw_omap *clk_hw = NULL;
 	struct clk_init_data *init = NULL;
 	const char **parent_names = NULL;
+	int ret;
 
 	ad = kzalloc(sizeof(*ad), GFP_KERNEL);
 	clk_hw = kzalloc(sizeof(*clk_hw), GFP_KERNEL);
@@ -212,10 +213,10 @@ static void __init of_dra7_apll_setup(struct device_node *node)
 
 	init->parent_names = parent_names;
 
-	ad->control_reg = ti_clk_get_reg_addr(node, 0);
-	ad->idlest_reg = ti_clk_get_reg_addr(node, 1);
+	ret = ti_clk_get_reg_addr(node, 0, &ad->control_reg);
+	ret |= ti_clk_get_reg_addr(node, 1, &ad->idlest_reg);
 
-	if (IS_ERR(ad->control_reg) || IS_ERR(ad->idlest_reg))
+	if (ret)
 		goto cleanup;
 
 	ad->idlest_mask = 0x1;
@@ -241,7 +242,7 @@ static int omap2_apll_is_enabled(struct clk_hw *hw)
 	struct dpll_data *ad = clk->dpll_data;
 	u32 v;
 
-	v = ti_clk_ll_ops->clk_readl(ad->control_reg);
+	v = ti_clk_ll_ops->clk_readl(&ad->control_reg);
 	v &= ad->enable_mask;
 
 	v >>= __ffs(ad->enable_mask);
@@ -267,13 +268,13 @@ static int omap2_apll_enable(struct clk_hw *hw)
 	u32 v;
 	int i = 0;
 
-	v = ti_clk_ll_ops->clk_readl(ad->control_reg);
+	v = ti_clk_ll_ops->clk_readl(&ad->control_reg);
 	v &= ~ad->enable_mask;
 	v |= OMAP2_EN_APLL_LOCKED << __ffs(ad->enable_mask);
-	ti_clk_ll_ops->clk_writel(v, ad->control_reg);
+	ti_clk_ll_ops->clk_writel(v, &ad->control_reg);
 
 	while (1) {
-		v = ti_clk_ll_ops->clk_readl(ad->idlest_reg);
+		v = ti_clk_ll_ops->clk_readl(&ad->idlest_reg);
 		if (v & ad->idlest_mask)
 			break;
 		if (i > MAX_APLL_WAIT_TRIES)
@@ -297,10 +298,10 @@ static void omap2_apll_disable(struct clk_hw *hw)
 	struct dpll_data *ad = clk->dpll_data;
 	u32 v;
 
-	v = ti_clk_ll_ops->clk_readl(ad->control_reg);
+	v = ti_clk_ll_ops->clk_readl(&ad->control_reg);
 	v &= ~ad->enable_mask;
 	v |= OMAP2_EN_APLL_STOPPED << __ffs(ad->enable_mask);
-	ti_clk_ll_ops->clk_writel(v, ad->control_reg);
+	ti_clk_ll_ops->clk_writel(v, &ad->control_reg);
 }
 
 static struct clk_ops omap2_apll_ops = {
@@ -315,10 +316,10 @@ static void omap2_apll_set_autoidle(struct clk_hw_omap *clk, u32 val)
 	struct dpll_data *ad = clk->dpll_data;
 	u32 v;
 
-	v = ti_clk_ll_ops->clk_readl(ad->autoidle_reg);
+	v = ti_clk_ll_ops->clk_readl(&ad->autoidle_reg);
 	v &= ~ad->autoidle_mask;
 	v |= val << __ffs(ad->autoidle_mask);
-	ti_clk_ll_ops->clk_writel(v, ad->control_reg);
+	ti_clk_ll_ops->clk_writel(v, &ad->control_reg);
 }
 
 #define OMAP2_APLL_AUTOIDLE_LOW_POWER_STOP	0x3
@@ -347,6 +348,7 @@ static void __init of_omap2_apll_setup(struct device_node *node)
 	struct clk *clk;
 	const char *parent_name;
 	u32 val;
+	int ret;
 
 	ad = kzalloc(sizeof(*ad), GFP_KERNEL);
 	clk_hw = kzalloc(sizeof(*clk_hw), GFP_KERNEL);
@@ -392,12 +394,11 @@ static void __init of_omap2_apll_setup(struct device_node *node)
 
 	ad->idlest_mask = 1 << val;
 
-	ad->control_reg = ti_clk_get_reg_addr(node, 0);
-	ad->autoidle_reg = ti_clk_get_reg_addr(node, 1);
-	ad->idlest_reg = ti_clk_get_reg_addr(node, 2);
+	ret = ti_clk_get_reg_addr(node, 0, &ad->control_reg);
+	ret |= ti_clk_get_reg_addr(node, 1, &ad->autoidle_reg);
+	ret |= ti_clk_get_reg_addr(node, 2, &ad->idlest_reg);
 
-	if (IS_ERR(ad->control_reg) || IS_ERR(ad->autoidle_reg) ||
-	    IS_ERR(ad->idlest_reg))
+	if (ret)
 		goto cleanup;
 
 	clk = clk_register(NULL, &clk_hw->hw);
diff --git a/drivers/clk/ti/autoidle.c b/drivers/clk/ti/autoidle.c
index 345af43..7bb9afb 100644
--- a/drivers/clk/ti/autoidle.c
+++ b/drivers/clk/ti/autoidle.c
@@ -25,7 +25,7 @@
 #include "clock.h"
 
 struct clk_ti_autoidle {
-	void __iomem		*reg;
+	struct clk_omap_reg	reg;
 	u8			shift;
 	u8			flags;
 	const char		*name;
@@ -73,28 +73,28 @@ static void _allow_autoidle(struct clk_ti_autoidle *clk)
 {
 	u32 val;
 
-	val = ti_clk_ll_ops->clk_readl(clk->reg);
+	val = ti_clk_ll_ops->clk_readl(&clk->reg);
 
 	if (clk->flags & AUTOIDLE_LOW)
 		val &= ~(1 << clk->shift);
 	else
 		val |= (1 << clk->shift);
 
-	ti_clk_ll_ops->clk_writel(val, clk->reg);
+	ti_clk_ll_ops->clk_writel(val, &clk->reg);
 }
 
 static void _deny_autoidle(struct clk_ti_autoidle *clk)
 {
 	u32 val;
 
-	val = ti_clk_ll_ops->clk_readl(clk->reg);
+	val = ti_clk_ll_ops->clk_readl(&clk->reg);
 
 	if (clk->flags & AUTOIDLE_LOW)
 		val |= (1 << clk->shift);
 	else
 		val &= ~(1 << clk->shift);
 
-	ti_clk_ll_ops->clk_writel(val, clk->reg);
+	ti_clk_ll_ops->clk_writel(val, &clk->reg);
 }
 
 /**
@@ -140,6 +140,7 @@ int __init of_ti_clk_autoidle_setup(struct device_node *node)
 {
 	u32 shift;
 	struct clk_ti_autoidle *clk;
+	int ret;
 
 	/* Check if this clock has autoidle support or not */
 	if (of_property_read_u32(node, "ti,autoidle-shift", &shift))
@@ -152,11 +153,10 @@ int __init of_ti_clk_autoidle_setup(struct device_node *node)
 
 	clk->shift = shift;
 	clk->name = node->name;
-	clk->reg = ti_clk_get_reg_addr(node, 0);
-
-	if (IS_ERR(clk->reg)) {
+	ret = ti_clk_get_reg_addr(node, 0, &clk->reg);
+	if (ret) {
 		kfree(clk);
-		return -EINVAL;
+		return ret;
 	}
 
 	if (of_property_read_bool(node, "ti,invert-autoidle-bit"))
diff --git a/drivers/clk/ti/clk-3xxx.c b/drivers/clk/ti/clk-3xxx.c
index 11d8aa3..b1251ca 100644
--- a/drivers/clk/ti/clk-3xxx.c
+++ b/drivers/clk/ti/clk-3xxx.c
@@ -52,14 +52,13 @@
  * @idlest_reg and @idlest_bit.  No return value.
  */
 static void omap3430es2_clk_ssi_find_idlest(struct clk_hw_omap *clk,
-					    void __iomem **idlest_reg,
+					    struct clk_omap_reg *idlest_reg,
 					    u8 *idlest_bit,
 					    u8 *idlest_val)
 {
-	u32 r;
-
-	r = (((__force u32)clk->enable_reg & ~0xf0) | 0x20);
-	*idlest_reg = (__force void __iomem *)r;
+	memcpy(idlest_reg, &clk->enable_reg, sizeof(*idlest_reg));
+	idlest_reg->offset &= ~0xf0;
+	idlest_reg->offset |= 0x20;
 	*idlest_bit = OMAP3430ES2_ST_SSI_IDLE_SHIFT;
 	*idlest_val = OMAP34XX_CM_IDLEST_VAL;
 }
@@ -85,15 +84,15 @@ static void omap3430es2_clk_ssi_find_idlest(struct clk_hw_omap *clk,
  * default find_idlest code assumes that they are at the same
  * position.)  No return value.
  */
-static void omap3430es2_clk_dss_usbhost_find_idlest(struct clk_hw_omap *clk,
-						    void __iomem **idlest_reg,
-						    u8 *idlest_bit,
-						    u8 *idlest_val)
+static void
+omap3430es2_clk_dss_usbhost_find_idlest(struct clk_hw_omap *clk,
+					struct clk_omap_reg *idlest_reg,
+					u8 *idlest_bit, u8 *idlest_val)
 {
-	u32 r;
+	memcpy(idlest_reg, &clk->enable_reg, sizeof(*idlest_reg));
 
-	r = (((__force u32)clk->enable_reg & ~0xf0) | 0x20);
-	*idlest_reg = (__force void __iomem *)r;
+	idlest_reg->offset &= ~0xf0;
+	idlest_reg->offset |= 0x20;
 	/* USBHOST_IDLE has same shift */
 	*idlest_bit = OMAP3430ES2_ST_DSS_IDLE_SHIFT;
 	*idlest_val = OMAP34XX_CM_IDLEST_VAL;
@@ -122,15 +121,15 @@ static void omap3430es2_clk_dss_usbhost_find_idlest(struct clk_hw_omap *clk,
  * shift from the CM_{I,F}CLKEN bit.  Pass back the correct info via
  * @idlest_reg and @idlest_bit.  No return value.
  */
-static void omap3430es2_clk_hsotgusb_find_idlest(struct clk_hw_omap *clk,
-						 void __iomem **idlest_reg,
-						 u8 *idlest_bit,
-						 u8 *idlest_val)
+static void
+omap3430es2_clk_hsotgusb_find_idlest(struct clk_hw_omap *clk,
+				     struct clk_omap_reg *idlest_reg,
+				     u8 *idlest_bit,
+				     u8 *idlest_val)
 {
-	u32 r;
-
-	r = (((__force u32)clk->enable_reg & ~0xf0) | 0x20);
-	*idlest_reg = (__force void __iomem *)r;
+	memcpy(idlest_reg, &clk->enable_reg, sizeof(*idlest_reg));
+	idlest_reg->offset &= ~0xf0;
+	idlest_reg->offset |= 0x20;
 	*idlest_bit = OMAP3430ES2_ST_HSOTGUSB_IDLE_SHIFT;
 	*idlest_val = OMAP34XX_CM_IDLEST_VAL;
 }
@@ -154,11 +153,11 @@ static void omap3430es2_clk_hsotgusb_find_idlest(struct clk_hw_omap *clk,
  * bit. A value of 1 indicates that clock is enabled.
  */
 static void am35xx_clk_find_idlest(struct clk_hw_omap *clk,
-				   void __iomem **idlest_reg,
+				   struct clk_omap_reg *idlest_reg,
 				   u8 *idlest_bit,
 				   u8 *idlest_val)
 {
-	*idlest_reg = (__force void __iomem *)(clk->enable_reg);
+	memcpy(idlest_reg, &clk->enable_reg, sizeof(*idlest_reg));
 	*idlest_bit = clk->enable_bit + AM35XX_IPSS_ICK_EN_ACK_OFFSET;
 	*idlest_val = AM35XX_IPSS_CLK_IDLEST_VAL;
 }
@@ -178,10 +177,10 @@ static void am35xx_clk_find_idlest(struct clk_hw_omap *clk,
  * avoid this issue, and remove the casts.  No return value.
  */
 static void am35xx_clk_find_companion(struct clk_hw_omap *clk,
-				      void __iomem **other_reg,
+				      struct clk_omap_reg *other_reg,
 				      u8 *other_bit)
 {
-	*other_reg = (__force void __iomem *)(clk->enable_reg);
+	memcpy(other_reg, &clk->enable_reg, sizeof(*other_reg));
 	if (clk->enable_bit & AM35XX_IPSS_ICK_MASK)
 		*other_bit = clk->enable_bit + AM35XX_IPSS_ICK_FCK_OFFSET;
 	else
@@ -205,14 +204,14 @@ static void am35xx_clk_find_companion(struct clk_hw_omap *clk,
  * and @idlest_bit.  No return value.
  */
 static void am35xx_clk_ipss_find_idlest(struct clk_hw_omap *clk,
-					void __iomem **idlest_reg,
+					struct clk_omap_reg *idlest_reg,
 					u8 *idlest_bit,
 					u8 *idlest_val)
 {
-	u32 r;
+	memcpy(idlest_reg, &clk->enable_reg, sizeof(*idlest_reg));
 
-	r = (((__force u32)clk->enable_reg & ~0xf0) | 0x20);
-	*idlest_reg = (__force void __iomem *)r;
+	idlest_reg->offset &= ~0xf0;
+	idlest_reg->offset |= 0x20;
 	*idlest_bit = AM35XX_ST_IPSS_SHIFT;
 	*idlest_val = OMAP34XX_CM_IDLEST_VAL;
 }
diff --git a/drivers/clk/ti/clk.c b/drivers/clk/ti/clk.c
index 024123f..ddbad7e 100644
--- a/drivers/clk/ti/clk.c
+++ b/drivers/clk/ti/clk.c
@@ -43,27 +43,29 @@ struct clk_iomap {
 
 static struct clk_iomap *clk_memmaps[CLK_MAX_MEMMAPS];
 
-static void clk_memmap_writel(u32 val, void __iomem *reg)
+static void clk_memmap_writel(u32 val, const struct clk_omap_reg *reg)
 {
-	struct clk_omap_reg *r = (struct clk_omap_reg *)&reg;
-	struct clk_iomap *io = clk_memmaps[r->index];
+	struct clk_iomap *io = clk_memmaps[reg->index];
 
-	if (io->regmap)
-		regmap_write(io->regmap, r->offset, val);
+	if (reg->ptr)
+		writel_relaxed(val, reg->ptr);
+	else if (io->regmap)
+		regmap_write(io->regmap, reg->offset, val);
 	else
-		writel_relaxed(val, io->mem + r->offset);
+		writel_relaxed(val, io->mem + reg->offset);
 }
 
-static u32 clk_memmap_readl(void __iomem *reg)
+static u32 clk_memmap_readl(const struct clk_omap_reg *reg)
 {
 	u32 val;
-	struct clk_omap_reg *r = (struct clk_omap_reg *)&reg;
-	struct clk_iomap *io = clk_memmaps[r->index];
+	struct clk_iomap *io = clk_memmaps[reg->index];
 
-	if (io->regmap)
-		regmap_read(io->regmap, r->offset, &val);
+	if (reg->ptr)
+		val = readl_relaxed(reg->ptr);
+	else if (io->regmap)
+		regmap_read(io->regmap, reg->offset, &val);
 	else
-		val = readl_relaxed(io->mem + r->offset);
+		val = readl_relaxed(io->mem + reg->offset);
 
 	return val;
 }
@@ -162,20 +164,18 @@ int __init ti_clk_retry_init(struct device_node *node, struct clk_hw *hw,
  * ti_clk_get_reg_addr - get register address for a clock register
  * @node: device node for the clock
  * @index: register index from the clock node
+ * @reg: pointer to target register struct
  *
- * Builds clock register address from device tree information. This
- * is a struct of type clk_omap_reg. Returns a pointer to the register
- * address, or a pointer error value in failure.
+ * Builds clock register address from device tree information, and returns
+ * the data via the provided output pointer @reg. Returns 0 on success,
+ * negative error value on failure.
  */
-void __iomem *ti_clk_get_reg_addr(struct device_node *node, int index)
+int ti_clk_get_reg_addr(struct device_node *node, int index,
+			struct clk_omap_reg *reg)
 {
-	struct clk_omap_reg *reg;
 	u32 val;
-	u32 tmp;
 	int i;
 
-	reg = (struct clk_omap_reg *)&tmp;
-
 	for (i = 0; i < CLK_MAX_MEMMAPS; i++) {
 		if (clocks_node_ptr[i] == node->parent)
 			break;
@@ -183,19 +183,20 @@ void __iomem *ti_clk_get_reg_addr(struct device_node *node, int index)
 
 	if (i == CLK_MAX_MEMMAPS) {
 		pr_err("clk-provider not found for %s!\n", node->name);
-		return IOMEM_ERR_PTR(-ENOENT);
+		return -ENOENT;
 	}
 
 	reg->index = i;
 
 	if (of_property_read_u32_index(node, "reg", index, &val)) {
 		pr_err("%s must have reg[%d]!\n", node->name, index);
-		return IOMEM_ERR_PTR(-EINVAL);
+		return -EINVAL;
 	}
 
 	reg->offset = val;
+	reg->ptr = NULL;
 
-	return (__force void __iomem *)tmp;
+	return 0;
 }
 
 /**
diff --git a/drivers/clk/ti/clkt_dflt.c b/drivers/clk/ti/clkt_dflt.c
index c6ae563..91751dd 100644
--- a/drivers/clk/ti/clkt_dflt.c
+++ b/drivers/clk/ti/clkt_dflt.c
@@ -55,7 +55,8 @@
  * elapsed.  XXX Deprecated - should be moved into drivers for the
  * individual IP block that the IDLEST register exists in.
  */
-static int _wait_idlest_generic(struct clk_hw_omap *clk, void __iomem *reg,
+static int _wait_idlest_generic(struct clk_hw_omap *clk,
+				struct clk_omap_reg *reg,
 				u32 mask, u8 idlest, const char *name)
 {
 	int i = 0, ena = 0;
@@ -91,7 +92,7 @@ static int _wait_idlest_generic(struct clk_hw_omap *clk, void __iomem *reg,
  */
 static void _omap2_module_wait_ready(struct clk_hw_omap *clk)
 {
-	void __iomem *companion_reg, *idlest_reg;
+	struct clk_omap_reg companion_reg, idlest_reg;
 	u8 other_bit, idlest_bit, idlest_val, idlest_reg_id;
 	s16 prcm_mod;
 	int r;
@@ -99,17 +100,17 @@ static void _omap2_module_wait_ready(struct clk_hw_omap *clk)
 	/* Not all modules have multiple clocks that their IDLEST depends on */
 	if (clk->ops->find_companion) {
 		clk->ops->find_companion(clk, &companion_reg, &other_bit);
-		if (!(ti_clk_ll_ops->clk_readl(companion_reg) &
+		if (!(ti_clk_ll_ops->clk_readl(&companion_reg) &
 		      (1 << other_bit)))
 			return;
 	}
 
 	clk->ops->find_idlest(clk, &idlest_reg, &idlest_bit, &idlest_val);
-	r = ti_clk_ll_ops->cm_split_idlest_reg(idlest_reg, &prcm_mod,
+	r = ti_clk_ll_ops->cm_split_idlest_reg(&idlest_reg, &prcm_mod,
 					       &idlest_reg_id);
 	if (r) {
 		/* IDLEST register not in the CM module */
-		_wait_idlest_generic(clk, idlest_reg, (1 << idlest_bit),
+		_wait_idlest_generic(clk, &idlest_reg, (1 << idlest_bit),
 				     idlest_val, clk_hw_get_name(&clk->hw));
 	} else {
 		ti_clk_ll_ops->cm_wait_module_ready(0, prcm_mod, idlest_reg_id,
@@ -139,17 +140,17 @@ static void _omap2_module_wait_ready(struct clk_hw_omap *clk)
  * avoid this issue, and remove the casts.  No return value.
  */
 void omap2_clk_dflt_find_companion(struct clk_hw_omap *clk,
-				   void __iomem **other_reg, u8 *other_bit)
+				   struct clk_omap_reg *other_reg,
+				   u8 *other_bit)
 {
-	u32 r;
+	memcpy(other_reg, &clk->enable_reg, sizeof(*other_reg));
 
 	/*
 	 * Convert CM_ICLKEN* <-> CM_FCLKEN*.  This conversion assumes
 	 * it's just a matter of XORing the bits.
 	 */
-	r = ((__force u32)clk->enable_reg ^ (CM_FCLKEN ^ CM_ICLKEN));
+	other_reg->offset ^= (CM_FCLKEN ^ CM_ICLKEN);
 
-	*other_reg = (__force void __iomem *)r;
 	*other_bit = clk->enable_bit;
 }
 
@@ -168,13 +169,14 @@ void omap2_clk_dflt_find_companion(struct clk_hw_omap *clk,
  * CM_IDLEST2).  This is not true for all modules.  No return value.
  */
 void omap2_clk_dflt_find_idlest(struct clk_hw_omap *clk,
-				void __iomem **idlest_reg, u8 *idlest_bit,
+				struct clk_omap_reg *idlest_reg, u8 *idlest_bit,
 				u8 *idlest_val)
 {
-	u32 r;
+	memcpy(idlest_reg, &clk->enable_reg, sizeof(*idlest_reg));
+
+	idlest_reg->offset &= ~0xf0;
+	idlest_reg->offset |= 0x20;
 
-	r = (((__force u32)clk->enable_reg & ~0xf0) | 0x20);
-	*idlest_reg = (__force void __iomem *)r;
 	*idlest_bit = clk->enable_bit;
 
 	/*
@@ -222,31 +224,19 @@ int omap2_dflt_clk_enable(struct clk_hw *hw)
 		}
 	}
 
-	if (IS_ERR(clk->enable_reg)) {
-		pr_err("%s: %s missing enable_reg\n", __func__,
-		       clk_hw_get_name(hw));
-		ret = -EINVAL;
-		goto err;
-	}
-
 	/* FIXME should not have INVERT_ENABLE bit here */
-	v = ti_clk_ll_ops->clk_readl(clk->enable_reg);
+	v = ti_clk_ll_ops->clk_readl(&clk->enable_reg);
 	if (clk->flags & INVERT_ENABLE)
 		v &= ~(1 << clk->enable_bit);
 	else
 		v |= (1 << clk->enable_bit);
-	ti_clk_ll_ops->clk_writel(v, clk->enable_reg);
-	v = ti_clk_ll_ops->clk_readl(clk->enable_reg); /* OCP barrier */
+	ti_clk_ll_ops->clk_writel(v, &clk->enable_reg);
+	v = ti_clk_ll_ops->clk_readl(&clk->enable_reg); /* OCP barrier */
 
 	if (clk->ops && clk->ops->find_idlest)
 		_omap2_module_wait_ready(clk);
 
 	return 0;
-
-err:
-	if (clkdm_control && clk->clkdm)
-		ti_clk_ll_ops->clkdm_clk_disable(clk->clkdm, hw->clk);
-	return ret;
 }
 
 /**
@@ -264,22 +254,13 @@ void omap2_dflt_clk_disable(struct clk_hw *hw)
 	u32 v;
 
 	clk = to_clk_hw_omap(hw);
-	if (IS_ERR(clk->enable_reg)) {
-		/*
-		 * 'independent' here refers to a clock which is not
-		 * controlled by its parent.
-		 */
-		pr_err("%s: independent clock %s has no enable_reg\n",
-		       __func__, clk_hw_get_name(hw));
-		return;
-	}
 
-	v = ti_clk_ll_ops->clk_readl(clk->enable_reg);
+	v = ti_clk_ll_ops->clk_readl(&clk->enable_reg);
 	if (clk->flags & INVERT_ENABLE)
 		v |= (1 << clk->enable_bit);
 	else
 		v &= ~(1 << clk->enable_bit);
-	ti_clk_ll_ops->clk_writel(v, clk->enable_reg);
+	ti_clk_ll_ops->clk_writel(v, &clk->enable_reg);
 	/* No OCP barrier needed here since it is a disable operation */
 
 	if (!(ti_clk_get_features()->flags & TI_CLK_DISABLE_CLKDM_CONTROL) &&
@@ -300,7 +281,7 @@ int omap2_dflt_clk_is_enabled(struct clk_hw *hw)
 	struct clk_hw_omap *clk = to_clk_hw_omap(hw);
 	u32 v;
 
-	v = ti_clk_ll_ops->clk_readl(clk->enable_reg);
+	v = ti_clk_ll_ops->clk_readl(&clk->enable_reg);
 
 	if (clk->flags & INVERT_ENABLE)
 		v ^= BIT(clk->enable_bit);
diff --git a/drivers/clk/ti/clkt_dpll.c b/drivers/clk/ti/clkt_dpll.c
index b919fdf..ce98da2 100644
--- a/drivers/clk/ti/clkt_dpll.c
+++ b/drivers/clk/ti/clkt_dpll.c
@@ -213,7 +213,7 @@ u8 omap2_init_dpll_parent(struct clk_hw *hw)
 	if (!dd)
 		return -EINVAL;
 
-	v = ti_clk_ll_ops->clk_readl(dd->control_reg);
+	v = ti_clk_ll_ops->clk_readl(&dd->control_reg);
 	v &= dd->enable_mask;
 	v >>= __ffs(dd->enable_mask);
 
@@ -249,14 +249,14 @@ unsigned long omap2_get_dpll_rate(struct clk_hw_omap *clk)
 		return 0;
 
 	/* Return bypass rate if DPLL is bypassed */
-	v = ti_clk_ll_ops->clk_readl(dd->control_reg);
+	v = ti_clk_ll_ops->clk_readl(&dd->control_reg);
 	v &= dd->enable_mask;
 	v >>= __ffs(dd->enable_mask);
 
 	if (_omap2_dpll_is_in_bypass(v))
 		return clk_hw_get_rate(dd->clk_bypass);
 
-	v = ti_clk_ll_ops->clk_readl(dd->mult_div1_reg);
+	v = ti_clk_ll_ops->clk_readl(&dd->mult_div1_reg);
 	dpll_mult = v & dd->mult_mask;
 	dpll_mult >>= __ffs(dd->mult_mask);
 	dpll_div = v & dd->div1_mask;
diff --git a/drivers/clk/ti/clkt_iclk.c b/drivers/clk/ti/clkt_iclk.c
index 38c3690..60b583d 100644
--- a/drivers/clk/ti/clkt_iclk.c
+++ b/drivers/clk/ti/clkt_iclk.c
@@ -31,28 +31,29 @@
 void omap2_clkt_iclk_allow_idle(struct clk_hw_omap *clk)
 {
 	u32 v;
-	void __iomem *r;
+	struct clk_omap_reg r;
 
-	r = (__force void __iomem *)
-		((__force u32)clk->enable_reg ^ (CM_AUTOIDLE ^ CM_ICLKEN));
+	memcpy(&r, &clk->enable_reg, sizeof(r));
+	r.offset ^= (CM_AUTOIDLE ^ CM_ICLKEN);
 
-	v = ti_clk_ll_ops->clk_readl(r);
+	v = ti_clk_ll_ops->clk_readl(&r);
 	v |= (1 << clk->enable_bit);
-	ti_clk_ll_ops->clk_writel(v, r);
+	ti_clk_ll_ops->clk_writel(v, &r);
 }
 
 /* XXX */
 void omap2_clkt_iclk_deny_idle(struct clk_hw_omap *clk)
 {
 	u32 v;
-	void __iomem *r;
+	struct clk_omap_reg r;
 
-	r = (__force void __iomem *)
-		((__force u32)clk->enable_reg ^ (CM_AUTOIDLE ^ CM_ICLKEN));
+	memcpy(&r, &clk->enable_reg, sizeof(r));
 
-	v = ti_clk_ll_ops->clk_readl(r);
+	r.offset ^= (CM_AUTOIDLE ^ CM_ICLKEN);
+
+	v = ti_clk_ll_ops->clk_readl(&r);
 	v &= ~(1 << clk->enable_bit);
-	ti_clk_ll_ops->clk_writel(v, r);
+	ti_clk_ll_ops->clk_writel(v, &r);
 }
 
 /**
@@ -68,14 +69,12 @@ void omap2_clkt_iclk_deny_idle(struct clk_hw_omap *clk)
  * modules.  No return value.
  */
 static void omap2430_clk_i2chs_find_idlest(struct clk_hw_omap *clk,
-					   void __iomem **idlest_reg,
+					   struct clk_omap_reg *idlest_reg,
 					   u8 *idlest_bit,
 					   u8 *idlest_val)
 {
-	u32 r;
-
-	r = ((__force u32)clk->enable_reg ^ (OMAP24XX_CM_FCLKEN2 ^ CM_IDLEST));
-	*idlest_reg = (__force void __iomem *)r;
+	memcpy(idlest_reg, &clk->enable_reg, sizeof(*idlest_reg));
+	idlest_reg->offset ^= (OMAP24XX_CM_FCLKEN2 ^ CM_IDLEST);
 	*idlest_bit = clk->enable_bit;
 	*idlest_val = OMAP24XX_CM_IDLEST_VAL;
 }
diff --git a/drivers/clk/ti/clock.h b/drivers/clk/ti/clock.h
index 2605e2b..f5b8dd2 100644
--- a/drivers/clk/ti/clock.h
+++ b/drivers/clk/ti/clock.h
@@ -20,7 +20,7 @@
 
 struct clk_omap_divider {
 	struct clk_hw		hw;
-	void __iomem		*reg;
+	struct clk_omap_reg	reg;
 	u8			shift;
 	u8			width;
 	u8			flags;
@@ -31,7 +31,7 @@ struct clk_omap_divider {
 
 struct clk_omap_mux {
 	struct clk_hw		hw;
-	void __iomem		*reg;
+	struct clk_omap_reg	reg;
 	u32			*table;
 	u32			mask;
 	u8			shift;
@@ -230,7 +230,8 @@ int ti_clk_parse_divider_data(int *div_table, int num_dividers, int max_div,
 struct clk *ti_clk_register_clk(struct ti_clk *setup);
 int ti_clk_register_legacy_clks(struct ti_clk_alias *clks);
 
-void __iomem *ti_clk_get_reg_addr(struct device_node *node, int index);
+int ti_clk_get_reg_addr(struct device_node *node, int index,
+			struct clk_omap_reg *reg);
 void ti_dt_clocks_register(struct ti_dt_clk *oclks);
 int ti_clk_retry_init(struct device_node *node, struct clk_hw *hw,
 		      ti_of_clk_init_cb_t func);
@@ -265,10 +266,10 @@ int ti_clk_retry_init(struct device_node *node, struct clk_hw *hw,
 void omap2_dflt_clk_disable(struct clk_hw *hw);
 int omap2_dflt_clk_is_enabled(struct clk_hw *hw);
 void omap2_clk_dflt_find_companion(struct clk_hw_omap *clk,
-				   void __iomem **other_reg,
+				   struct clk_omap_reg *other_reg,
 				   u8 *other_bit);
 void omap2_clk_dflt_find_idlest(struct clk_hw_omap *clk,
-				void __iomem **idlest_reg,
+				struct clk_omap_reg *idlest_reg,
 				u8 *idlest_bit, u8 *idlest_val);
 
 void omap2_clkt_iclk_allow_idle(struct clk_hw_omap *clk);
diff --git a/drivers/clk/ti/clockdomain.c b/drivers/clk/ti/clockdomain.c
index 704157d..fbedc6a 100644
--- a/drivers/clk/ti/clockdomain.c
+++ b/drivers/clk/ti/clockdomain.c
@@ -52,10 +52,6 @@ int omap2_clkops_enable_clkdm(struct clk_hw *hw)
 		return -EINVAL;
 	}
 
-	if (unlikely(clk->enable_reg))
-		pr_err("%s: %s: should use dflt_clk_enable ?!\n", __func__,
-		       clk_hw_get_name(hw));
-
 	if (ti_clk_get_features()->flags & TI_CLK_DISABLE_CLKDM_CONTROL) {
 		pr_err("%s: %s: clkfw-based clockdomain control disabled ?!\n",
 		       __func__, clk_hw_get_name(hw));
@@ -90,10 +86,6 @@ void omap2_clkops_disable_clkdm(struct clk_hw *hw)
 		return;
 	}
 
-	if (unlikely(clk->enable_reg))
-		pr_err("%s: %s: should use dflt_clk_disable ?!\n", __func__,
-		       clk_hw_get_name(hw));
-
 	if (ti_clk_get_features()->flags & TI_CLK_DISABLE_CLKDM_CONTROL) {
 		pr_err("%s: %s: clkfw-based clockdomain control disabled ?!\n",
 		       __func__, clk_hw_get_name(hw));
diff --git a/drivers/clk/ti/divider.c b/drivers/clk/ti/divider.c
index 219bd7c..a10fd6e 100644
--- a/drivers/clk/ti/divider.c
+++ b/drivers/clk/ti/divider.c
@@ -100,7 +100,7 @@ static unsigned long ti_clk_divider_recalc_rate(struct clk_hw *hw,
 	struct clk_omap_divider *divider = to_clk_omap_divider(hw);
 	unsigned int div, val;
 
-	val = ti_clk_ll_ops->clk_readl(divider->reg) >> divider->shift;
+	val = ti_clk_ll_ops->clk_readl(&divider->reg) >> divider->shift;
 	val &= div_mask(divider);
 
 	div = _get_div(divider, val);
@@ -228,11 +228,11 @@ static int ti_clk_divider_set_rate(struct clk_hw *hw, unsigned long rate,
 	if (divider->flags & CLK_DIVIDER_HIWORD_MASK) {
 		val = div_mask(divider) << (divider->shift + 16);
 	} else {
-		val = ti_clk_ll_ops->clk_readl(divider->reg);
+		val = ti_clk_ll_ops->clk_readl(&divider->reg);
 		val &= ~(div_mask(divider) << divider->shift);
 	}
 	val |= value << divider->shift;
-	ti_clk_ll_ops->clk_writel(val, divider->reg);
+	ti_clk_ll_ops->clk_writel(val, &divider->reg);
 
 	return 0;
 }
@@ -245,7 +245,8 @@ static int ti_clk_divider_set_rate(struct clk_hw *hw, unsigned long rate,
 
 static struct clk *_register_divider(struct device *dev, const char *name,
 				     const char *parent_name,
-				     unsigned long flags, void __iomem *reg,
+				     unsigned long flags,
+				     struct clk_omap_reg *reg,
 				     u8 shift, u8 width, u8 clk_divider_flags,
 				     const struct clk_div_table *table)
 {
@@ -274,7 +275,7 @@ static struct clk *_register_divider(struct device *dev, const char *name,
 	init.num_parents = (parent_name ? 1 : 0);
 
 	/* struct clk_divider assignments */
-	div->reg = reg;
+	memcpy(&div->reg, reg, sizeof(*reg));
 	div->shift = shift;
 	div->width = width;
 	div->flags = clk_divider_flags;
@@ -532,14 +533,15 @@ static int _get_divider_width(struct device_node *node,
 }
 
 static int __init ti_clk_divider_populate(struct device_node *node,
-	void __iomem **reg, const struct clk_div_table **table,
+	struct clk_omap_reg *reg, const struct clk_div_table **table,
 	u32 *flags, u8 *div_flags, u8 *width, u8 *shift)
 {
 	u32 val;
+	int ret;
 
-	*reg = ti_clk_get_reg_addr(node, 0);
-	if (IS_ERR(*reg))
-		return PTR_ERR(*reg);
+	ret = ti_clk_get_reg_addr(node, 0, reg);
+	if (ret)
+		return ret;
 
 	if (!of_property_read_u32(node, "ti,bit-shift", &val))
 		*shift = val;
@@ -578,7 +580,7 @@ static void __init of_ti_divider_clk_setup(struct device_node *node)
 {
 	struct clk *clk;
 	const char *parent_name;
-	void __iomem *reg;
+	struct clk_omap_reg reg;
 	u8 clk_divider_flags = 0;
 	u8 width = 0;
 	u8 shift = 0;
@@ -591,7 +593,7 @@ static void __init of_ti_divider_clk_setup(struct device_node *node)
 				    &clk_divider_flags, &width, &shift))
 		goto cleanup;
 
-	clk = _register_divider(NULL, node->name, parent_name, flags, reg,
+	clk = _register_divider(NULL, node->name, parent_name, flags, &reg,
 				shift, width, clk_divider_flags, table);
 
 	if (!IS_ERR(clk)) {
diff --git a/drivers/clk/ti/dpll.c b/drivers/clk/ti/dpll.c
index 778bc90..96d8488 100644
--- a/drivers/clk/ti/dpll.c
+++ b/drivers/clk/ti/dpll.c
@@ -203,17 +203,10 @@ static void __init _register_dpll(struct clk_hw *hw,
 }
 
 #if defined(CONFIG_ARCH_OMAP3) && defined(CONFIG_ATAGS)
-static void __iomem *_get_reg(u8 module, u16 offset)
+void _get_reg(u8 module, u16 offset, struct clk_omap_reg *reg)
 {
-	u32 reg;
-	struct clk_omap_reg *reg_setup;
-
-	reg_setup = (struct clk_omap_reg *)&reg;
-
-	reg_setup->index = module;
-	reg_setup->offset = offset;
-
-	return (void __iomem *)reg;
+	reg->index = module;
+	reg->offset = offset;
 }
 
 struct clk *ti_clk_register_dpll(struct ti_clk *setup)
@@ -255,10 +248,10 @@ struct clk *ti_clk_register_dpll(struct ti_clk *setup)
 	init.num_parents = dpll->num_parents;
 	init.parent_names = dpll->parents;
 
-	dd->control_reg = _get_reg(dpll->module, dpll->control_reg);
-	dd->idlest_reg = _get_reg(dpll->module, dpll->idlest_reg);
-	dd->mult_div1_reg = _get_reg(dpll->module, dpll->mult_div1_reg);
-	dd->autoidle_reg = _get_reg(dpll->module, dpll->autoidle_reg);
+	_get_reg(dpll->module, dpll->control_reg, &dd->control_reg);
+	_get_reg(dpll->module, dpll->idlest_reg, &dd->idlest_reg);
+	_get_reg(dpll->module, dpll->mult_div1_reg, &dd->mult_div1_reg);
+	_get_reg(dpll->module, dpll->autoidle_reg, &dd->autoidle_reg);
 
 	dd->modes = dpll->modes;
 	dd->div1_mask = dpll->div1_mask;
@@ -344,12 +337,9 @@ static void _register_dpll_x2(struct device_node *node,
 		ret = of_property_count_elems_of_size(node, "reg", 1);
 		if (ret <= 0) {
 			hw_ops = NULL;
-		} else {
-			clk_hw->clksel_reg = ti_clk_get_reg_addr(node, 0);
-			if (IS_ERR(clk_hw->clksel_reg)) {
-				kfree(clk_hw);
-				return;
-			}
+		} else if (ti_clk_get_reg_addr(node, 0, &clk_hw->clksel_reg)) {
+			kfree(clk_hw);
+			return;
 		}
 	}
 
@@ -412,7 +402,8 @@ static void __init of_ti_dpll_setup(struct device_node *node,
 
 	init->parent_names = parent_names;
 
-	dd->control_reg = ti_clk_get_reg_addr(node, 0);
+	if (ti_clk_get_reg_addr(node, 0, &dd->control_reg))
+		goto cleanup;
 
 	/*
 	 * Special case for OMAP2 DPLL, register order is different due to
@@ -420,25 +411,22 @@ static void __init of_ti_dpll_setup(struct device_node *node,
 	 * missing idlest_mask.
 	 */
 	if (!dd->idlest_mask) {
-		dd->mult_div1_reg = ti_clk_get_reg_addr(node, 1);
+		if (ti_clk_get_reg_addr(node, 1, &dd->mult_div1_reg))
+			goto cleanup;
 #ifdef CONFIG_ARCH_OMAP2
 		clk_hw->ops = &clkhwops_omap2xxx_dpll;
 		omap2xxx_clkt_dpllcore_init(&clk_hw->hw);
 #endif
 	} else {
-		dd->idlest_reg = ti_clk_get_reg_addr(node, 1);
-		if (IS_ERR(dd->idlest_reg))
+		if (ti_clk_get_reg_addr(node, 1, &dd->idlest_reg))
 			goto cleanup;
 
-		dd->mult_div1_reg = ti_clk_get_reg_addr(node, 2);
+		if (ti_clk_get_reg_addr(node, 2, &dd->mult_div1_reg))
+			goto cleanup;
 	}
 
-	if (IS_ERR(dd->control_reg) || IS_ERR(dd->mult_div1_reg))
-		goto cleanup;
-
 	if (dd->autoidle_mask) {
-		dd->autoidle_reg = ti_clk_get_reg_addr(node, 3);
-		if (IS_ERR(dd->autoidle_reg))
+		if (ti_clk_get_reg_addr(node, 3, &dd->autoidle_reg))
 			goto cleanup;
 	}
 
diff --git a/drivers/clk/ti/dpll3xxx.c b/drivers/clk/ti/dpll3xxx.c
index 4cdd28a..4534de2 100644
--- a/drivers/clk/ti/dpll3xxx.c
+++ b/drivers/clk/ti/dpll3xxx.c
@@ -54,10 +54,10 @@ static void _omap3_dpll_write_clken(struct clk_hw_omap *clk, u8 clken_bits)
 
 	dd = clk->dpll_data;
 
-	v = ti_clk_ll_ops->clk_readl(dd->control_reg);
+	v = ti_clk_ll_ops->clk_readl(&dd->control_reg);
 	v &= ~dd->enable_mask;
 	v |= clken_bits << __ffs(dd->enable_mask);
-	ti_clk_ll_ops->clk_writel(v, dd->control_reg);
+	ti_clk_ll_ops->clk_writel(v, &dd->control_reg);
 }
 
 /* _omap3_wait_dpll_status: wait for a DPLL to enter a specific state */
@@ -73,7 +73,7 @@ static int _omap3_wait_dpll_status(struct clk_hw_omap *clk, u8 state)
 
 	state <<= __ffs(dd->idlest_mask);
 
-	while (((ti_clk_ll_ops->clk_readl(dd->idlest_reg) & dd->idlest_mask)
+	while (((ti_clk_ll_ops->clk_readl(&dd->idlest_reg) & dd->idlest_mask)
 		!= state) && i < MAX_DPLL_WAIT_TRIES) {
 		i++;
 		udelay(1);
@@ -151,7 +151,7 @@ static int _omap3_noncore_dpll_lock(struct clk_hw_omap *clk)
 	state <<= __ffs(dd->idlest_mask);
 
 	/* Check if already locked */
-	if ((ti_clk_ll_ops->clk_readl(dd->idlest_reg) & dd->idlest_mask) ==
+	if ((ti_clk_ll_ops->clk_readl(&dd->idlest_reg) & dd->idlest_mask) ==
 	    state)
 		goto done;
 
@@ -317,14 +317,14 @@ static int omap3_noncore_dpll_program(struct clk_hw_omap *clk, u16 freqsel)
 	 * only since freqsel field is no longer present on other devices.
 	 */
 	if (ti_clk_get_features()->flags & TI_CLK_DPLL_HAS_FREQSEL) {
-		v = ti_clk_ll_ops->clk_readl(dd->control_reg);
+		v = ti_clk_ll_ops->clk_readl(&dd->control_reg);
 		v &= ~dd->freqsel_mask;
 		v |= freqsel << __ffs(dd->freqsel_mask);
-		ti_clk_ll_ops->clk_writel(v, dd->control_reg);
+		ti_clk_ll_ops->clk_writel(v, &dd->control_reg);
 	}
 
 	/* Set DPLL multiplier, divider */
-	v = ti_clk_ll_ops->clk_readl(dd->mult_div1_reg);
+	v = ti_clk_ll_ops->clk_readl(&dd->mult_div1_reg);
 
 	/* Handle Duty Cycle Correction */
 	if (dd->dcc_mask) {
@@ -370,11 +370,11 @@ static int omap3_noncore_dpll_program(struct clk_hw_omap *clk, u16 freqsel)
 		}
 	}
 
-	ti_clk_ll_ops->clk_writel(v, dd->mult_div1_reg);
+	ti_clk_ll_ops->clk_writel(v, &dd->mult_div1_reg);
 
 	/* Set 4X multiplier and low-power mode */
 	if (dd->m4xen_mask || dd->lpmode_mask) {
-		v = ti_clk_ll_ops->clk_readl(dd->control_reg);
+		v = ti_clk_ll_ops->clk_readl(&dd->control_reg);
 
 		if (dd->m4xen_mask) {
 			if (dd->last_rounded_m4xen)
@@ -390,7 +390,7 @@ static int omap3_noncore_dpll_program(struct clk_hw_omap *clk, u16 freqsel)
 				v &= ~dd->lpmode_mask;
 		}
 
-		ti_clk_ll_ops->clk_writel(v, dd->control_reg);
+		ti_clk_ll_ops->clk_writel(v, &dd->control_reg);
 	}
 
 	/* We let the clock framework set the other output dividers later */
@@ -652,10 +652,10 @@ static u32 omap3_dpll_autoidle_read(struct clk_hw_omap *clk)
 
 	dd = clk->dpll_data;
 
-	if (!dd->autoidle_reg)
+	if (!dd->autoidle_mask)
 		return -EINVAL;
 
-	v = ti_clk_ll_ops->clk_readl(dd->autoidle_reg);
+	v = ti_clk_ll_ops->clk_readl(&dd->autoidle_reg);
 	v &= dd->autoidle_mask;
 	v >>= __ffs(dd->autoidle_mask);
 
@@ -681,7 +681,7 @@ static void omap3_dpll_allow_idle(struct clk_hw_omap *clk)
 
 	dd = clk->dpll_data;
 
-	if (!dd->autoidle_reg)
+	if (!dd->autoidle_mask)
 		return;
 
 	/*
@@ -689,10 +689,10 @@ static void omap3_dpll_allow_idle(struct clk_hw_omap *clk)
 	 * by writing 0x5 instead of 0x1.  Add some mechanism to
 	 * optionally enter this mode.
 	 */
-	v = ti_clk_ll_ops->clk_readl(dd->autoidle_reg);
+	v = ti_clk_ll_ops->clk_readl(&dd->autoidle_reg);
 	v &= ~dd->autoidle_mask;
 	v |= DPLL_AUTOIDLE_LOW_POWER_STOP << __ffs(dd->autoidle_mask);
-	ti_clk_ll_ops->clk_writel(v, dd->autoidle_reg);
+	ti_clk_ll_ops->clk_writel(v, &dd->autoidle_reg);
 }
 
 /**
@@ -711,13 +711,13 @@ static void omap3_dpll_deny_idle(struct clk_hw_omap *clk)
 
 	dd = clk->dpll_data;
 
-	if (!dd->autoidle_reg)
+	if (!dd->autoidle_mask)
 		return;
 
-	v = ti_clk_ll_ops->clk_readl(dd->autoidle_reg);
+	v = ti_clk_ll_ops->clk_readl(&dd->autoidle_reg);
 	v &= ~dd->autoidle_mask;
 	v |= DPLL_AUTOIDLE_DISABLE << __ffs(dd->autoidle_mask);
-	ti_clk_ll_ops->clk_writel(v, dd->autoidle_reg);
+	ti_clk_ll_ops->clk_writel(v, &dd->autoidle_reg);
 }
 
 /* Clock control for DPLL outputs */
@@ -773,7 +773,7 @@ unsigned long omap3_clkoutx2_recalc(struct clk_hw *hw,
 
 	WARN_ON(!dd->enable_mask);
 
-	v = ti_clk_ll_ops->clk_readl(dd->control_reg) & dd->enable_mask;
+	v = ti_clk_ll_ops->clk_readl(&dd->control_reg) & dd->enable_mask;
 	v >>= __ffs(dd->enable_mask);
 	if ((v != OMAP3XXX_EN_DPLL_LOCKED) || (dd->flags & DPLL_J_TYPE))
 		rate = parent_rate;
diff --git a/drivers/clk/ti/dpll44xx.c b/drivers/clk/ti/dpll44xx.c
index 82c05b5..d7a3f7e 100644
--- a/drivers/clk/ti/dpll44xx.c
+++ b/drivers/clk/ti/dpll44xx.c
@@ -42,17 +42,17 @@ static void omap4_dpllmx_allow_gatectrl(struct clk_hw_omap *clk)
 	u32 v;
 	u32 mask;
 
-	if (!clk || !clk->clksel_reg)
+	if (!clk)
 		return;
 
 	mask = clk->flags & CLOCK_CLKOUTX2 ?
 			OMAP4430_DPLL_CLKOUTX2_GATE_CTRL_MASK :
 			OMAP4430_DPLL_CLKOUT_GATE_CTRL_MASK;
 
-	v = ti_clk_ll_ops->clk_readl(clk->clksel_reg);
+	v = ti_clk_ll_ops->clk_readl(&clk->clksel_reg);
 	/* Clear the bit to allow gatectrl */
 	v &= ~mask;
-	ti_clk_ll_ops->clk_writel(v, clk->clksel_reg);
+	ti_clk_ll_ops->clk_writel(v, &clk->clksel_reg);
 }
 
 static void omap4_dpllmx_deny_gatectrl(struct clk_hw_omap *clk)
@@ -60,17 +60,17 @@ static void omap4_dpllmx_deny_gatectrl(struct clk_hw_omap *clk)
 	u32 v;
 	u32 mask;
 
-	if (!clk || !clk->clksel_reg)
+	if (!clk)
 		return;
 
 	mask = clk->flags & CLOCK_CLKOUTX2 ?
 			OMAP4430_DPLL_CLKOUTX2_GATE_CTRL_MASK :
 			OMAP4430_DPLL_CLKOUT_GATE_CTRL_MASK;
 
-	v = ti_clk_ll_ops->clk_readl(clk->clksel_reg);
+	v = ti_clk_ll_ops->clk_readl(&clk->clksel_reg);
 	/* Set the bit to deny gatectrl */
 	v |= mask;
-	ti_clk_ll_ops->clk_writel(v, clk->clksel_reg);
+	ti_clk_ll_ops->clk_writel(v, &clk->clksel_reg);
 }
 
 const struct clk_hw_omap_ops clkhwops_omap4_dpllmx = {
@@ -128,7 +128,7 @@ unsigned long omap4_dpll_regm4xen_recalc(struct clk_hw *hw,
 	rate = omap2_get_dpll_rate(clk);
 
 	/* regm4xen adds a multiplier of 4 to DPLL calculations */
-	v = ti_clk_ll_ops->clk_readl(dd->control_reg);
+	v = ti_clk_ll_ops->clk_readl(&dd->control_reg);
 	if (v & OMAP4430_DPLL_REGM4XEN_MASK)
 		rate *= OMAP4430_REGM4XEN_MULT;
 
diff --git a/drivers/clk/ti/gate.c b/drivers/clk/ti/gate.c
index 77f0920..7151ec3 100644
--- a/drivers/clk/ti/gate.c
+++ b/drivers/clk/ti/gate.c
@@ -76,15 +76,15 @@ static int omap36xx_gate_clk_enable_with_hsdiv_restore(struct clk_hw *hw)
 
 	/* Restore the dividers */
 	if (!ret) {
-		orig_v = ti_clk_ll_ops->clk_readl(parent->reg);
+		orig_v = ti_clk_ll_ops->clk_readl(&parent->reg);
 		dummy_v = orig_v;
 
 		/* Write any other value different from the Read value */
 		dummy_v ^= (1 << parent->shift);
-		ti_clk_ll_ops->clk_writel(dummy_v, parent->reg);
+		ti_clk_ll_ops->clk_writel(dummy_v, &parent->reg);
 
 		/* Write the original divider */
-		ti_clk_ll_ops->clk_writel(orig_v, parent->reg);
+		ti_clk_ll_ops->clk_writel(orig_v, &parent->reg);
 	}
 
 	return ret;
@@ -92,7 +92,7 @@ static int omap36xx_gate_clk_enable_with_hsdiv_restore(struct clk_hw *hw)
 
 static struct clk *_register_gate(struct device *dev, const char *name,
 				  const char *parent_name, unsigned long flags,
-				  void __iomem *reg, u8 bit_idx,
+				  struct clk_omap_reg *reg, u8 bit_idx,
 				  u8 clk_gate_flags, const struct clk_ops *ops,
 				  const struct clk_hw_omap_ops *hw_ops)
 {
@@ -109,7 +109,7 @@ static struct clk *_register_gate(struct device *dev, const char *name,
 	init.name = name;
 	init.ops = ops;
 
-	clk_hw->enable_reg = reg;
+	memcpy(&clk_hw->enable_reg, reg, sizeof(*reg));
 	clk_hw->enable_bit = bit_idx;
 	clk_hw->ops = hw_ops;
 
@@ -133,8 +133,7 @@ struct clk *ti_clk_register_gate(struct ti_clk *setup)
 {
 	const struct clk_ops *ops = &omap_gate_clk_ops;
 	const struct clk_hw_omap_ops *hw_ops = NULL;
-	u32 reg;
-	struct clk_omap_reg *reg_setup;
+	struct clk_omap_reg reg;
 	u32 flags = 0;
 	u8 clk_gate_flags = 0;
 	struct ti_clk_gate *gate;
@@ -144,8 +143,6 @@ struct clk *ti_clk_register_gate(struct ti_clk *setup)
 	if (gate->flags & CLKF_INTERFACE)
 		return ti_clk_register_interface(setup);
 
-	reg_setup = (struct clk_omap_reg *)&reg;
-
 	if (gate->flags & CLKF_SET_RATE_PARENT)
 		flags |= CLK_SET_RATE_PARENT;
 
@@ -169,11 +166,12 @@ struct clk *ti_clk_register_gate(struct ti_clk *setup)
 	if (gate->flags & CLKF_AM35XX)
 		hw_ops = &clkhwops_am35xx_ipss_module_wait;
 
-	reg_setup->index = gate->module;
-	reg_setup->offset = gate->reg;
+	reg.index = gate->module;
+	reg.offset = gate->reg;
+	reg.ptr = NULL;
 
 	return _register_gate(NULL, setup->name, gate->parent, flags,
-			      (void __iomem *)reg, gate->bit_shift,
+			      &reg, gate->bit_shift,
 			      clk_gate_flags, ops, hw_ops);
 }
 
@@ -214,15 +212,14 @@ static void __init _of_ti_gate_clk_setup(struct device_node *node,
 {
 	struct clk *clk;
 	const char *parent_name;
-	void __iomem *reg = NULL;
+	struct clk_omap_reg reg;
 	u8 enable_bit = 0;
 	u32 val;
 	u32 flags = 0;
 	u8 clk_gate_flags = 0;
 
 	if (ops != &omap_gate_clkdm_clk_ops) {
-		reg = ti_clk_get_reg_addr(node, 0);
-		if (IS_ERR(reg))
+		if (ti_clk_get_reg_addr(node, 0, &reg))
 			return;
 
 		if (!of_property_read_u32(node, "ti,bit-shift", &val))
@@ -242,7 +239,7 @@ static void __init _of_ti_gate_clk_setup(struct device_node *node,
 	if (of_property_read_bool(node, "ti,set-bit-to-disable"))
 		clk_gate_flags |= INVERT_ENABLE;
 
-	clk = _register_gate(NULL, node->name, parent_name, flags, reg,
+	clk = _register_gate(NULL, node->name, parent_name, flags, &reg,
 			     enable_bit, clk_gate_flags, ops, hw_ops);
 
 	if (!IS_ERR(clk))
@@ -260,8 +257,7 @@ static void __init _of_ti_gate_clk_setup(struct device_node *node,
 	if (!gate)
 		return;
 
-	gate->enable_reg = ti_clk_get_reg_addr(node, 0);
-	if (IS_ERR(gate->enable_reg))
+	if (ti_clk_get_reg_addr(node, 0, &gate->enable_reg))
 		goto cleanup;
 
 	of_property_read_u32(node, "ti,bit-shift", &val);
diff --git a/drivers/clk/ti/interface.c b/drivers/clk/ti/interface.c
index 42d9fd4..62cf50c 100644
--- a/drivers/clk/ti/interface.c
+++ b/drivers/clk/ti/interface.c
@@ -34,7 +34,7 @@
 
 static struct clk *_register_interface(struct device *dev, const char *name,
 				       const char *parent_name,
-				       void __iomem *reg, u8 bit_idx,
+				       struct clk_omap_reg *reg, u8 bit_idx,
 				       const struct clk_hw_omap_ops *ops)
 {
 	struct clk_init_data init = { NULL };
@@ -47,7 +47,7 @@ static struct clk *_register_interface(struct device *dev, const char *name,
 
 	clk_hw->hw.init = &init;
 	clk_hw->ops = ops;
-	clk_hw->enable_reg = reg;
+	memcpy(&clk_hw->enable_reg, reg, sizeof(*reg));
 	clk_hw->enable_bit = bit_idx;
 
 	init.name = name;
@@ -71,14 +71,13 @@ static struct clk *_register_interface(struct device *dev, const char *name,
 struct clk *ti_clk_register_interface(struct ti_clk *setup)
 {
 	const struct clk_hw_omap_ops *ops = &clkhwops_iclk_wait;
-	u32 reg;
-	struct clk_omap_reg *reg_setup;
+	struct clk_omap_reg reg;
 	struct ti_clk_gate *gate;
 
 	gate = setup->data;
-	reg_setup = (struct clk_omap_reg *)&reg;
-	reg_setup->index = gate->module;
-	reg_setup->offset = gate->reg;
+	reg.index = gate->module;
+	reg.offset = gate->reg;
+	reg.ptr = NULL;
 
 	if (gate->flags & CLKF_NO_WAIT)
 		ops = &clkhwops_iclk;
@@ -96,7 +95,7 @@ struct clk *ti_clk_register_interface(struct ti_clk *setup)
 		ops = &clkhwops_am35xx_ipss_wait;
 
 	return _register_interface(NULL, setup->name, gate->parent,
-				   (void __iomem *)reg, gate->bit_shift, ops);
+				   &reg, gate->bit_shift, ops);
 }
 #endif
 
@@ -105,12 +104,11 @@ static void __init _of_ti_interface_clk_setup(struct device_node *node,
 {
 	struct clk *clk;
 	const char *parent_name;
-	void __iomem *reg;
+	struct clk_omap_reg reg;
 	u8 enable_bit = 0;
 	u32 val;
 
-	reg = ti_clk_get_reg_addr(node, 0);
-	if (IS_ERR(reg))
+	if (ti_clk_get_reg_addr(node, 0, &reg))
 		return;
 
 	if (!of_property_read_u32(node, "ti,bit-shift", &val))
@@ -122,7 +120,7 @@ static void __init _of_ti_interface_clk_setup(struct device_node *node,
 		return;
 	}
 
-	clk = _register_interface(NULL, node->name, parent_name, reg,
+	clk = _register_interface(NULL, node->name, parent_name, &reg,
 				  enable_bit, ops);
 
 	if (!IS_ERR(clk))
diff --git a/drivers/clk/ti/mux.c b/drivers/clk/ti/mux.c
index daa2dee..18c267b 100644
--- a/drivers/clk/ti/mux.c
+++ b/drivers/clk/ti/mux.c
@@ -39,7 +39,7 @@ static u8 ti_clk_mux_get_parent(struct clk_hw *hw)
 	 * OTOH, pmd_trace_clk_mux_ck uses a separate bit for each clock, so
 	 * val = 0x4 really means "bit 2, index starts at bit 0"
 	 */
-	val = ti_clk_ll_ops->clk_readl(mux->reg) >> mux->shift;
+	val = ti_clk_ll_ops->clk_readl(&mux->reg) >> mux->shift;
 	val &= mux->mask;
 
 	if (mux->table) {
@@ -81,11 +81,11 @@ static int ti_clk_mux_set_parent(struct clk_hw *hw, u8 index)
 	if (mux->flags & CLK_MUX_HIWORD_MASK) {
 		val = mux->mask << (mux->shift + 16);
 	} else {
-		val = ti_clk_ll_ops->clk_readl(mux->reg);
+		val = ti_clk_ll_ops->clk_readl(&mux->reg);
 		val &= ~(mux->mask << mux->shift);
 	}
 	val |= index << mux->shift;
-	ti_clk_ll_ops->clk_writel(val, mux->reg);
+	ti_clk_ll_ops->clk_writel(val, &mux->reg);
 
 	return 0;
 }
@@ -99,7 +99,7 @@ static int ti_clk_mux_set_parent(struct clk_hw *hw, u8 index)
 static struct clk *_register_mux(struct device *dev, const char *name,
 				 const char * const *parent_names,
 				 u8 num_parents, unsigned long flags,
-				 void __iomem *reg, u8 shift, u32 mask,
+				 struct clk_omap_reg *reg, u8 shift, u32 mask,
 				 u8 clk_mux_flags, u32 *table)
 {
 	struct clk_omap_mux *mux;
@@ -120,7 +120,7 @@ static struct clk *_register_mux(struct device *dev, const char *name,
 	init.num_parents = num_parents;
 
 	/* struct clk_mux assignments */
-	mux->reg = reg;
+	memcpy(&mux->reg, reg, sizeof(*reg));
 	mux->shift = shift;
 	mux->mask = mask;
 	mux->flags = clk_mux_flags;
@@ -140,12 +140,9 @@ struct clk *ti_clk_register_mux(struct ti_clk *setup)
 	struct ti_clk_mux *mux;
 	u32 flags;
 	u8 mux_flags = 0;
-	struct clk_omap_reg *reg_setup;
-	u32 reg;
+	struct clk_omap_reg reg;
 	u32 mask;
 
-	reg_setup = (struct clk_omap_reg *)&reg;
-
 	mux = setup->data;
 	flags = CLK_SET_RATE_NO_REPARENT;
 
@@ -154,8 +151,9 @@ struct clk *ti_clk_register_mux(struct ti_clk *setup)
 		mask--;
 
 	mask = (1 << fls(mask)) - 1;
-	reg_setup->index = mux->module;
-	reg_setup->offset = mux->reg;
+	reg.index = mux->module;
+	reg.offset = mux->reg;
+	reg.ptr = NULL;
 
 	if (mux->flags & CLKF_INDEX_STARTS_AT_ONE)
 		mux_flags |= CLK_MUX_INDEX_ONE;
@@ -164,7 +162,7 @@ struct clk *ti_clk_register_mux(struct ti_clk *setup)
 		flags |= CLK_SET_RATE_PARENT;
 
 	return _register_mux(NULL, setup->name, mux->parents, mux->num_parents,
-			     flags, (void __iomem *)reg, mux->bit_shift, mask,
+			     flags, &reg, mux->bit_shift, mask,
 			     mux_flags, NULL);
 }
 
@@ -177,7 +175,7 @@ struct clk *ti_clk_register_mux(struct ti_clk *setup)
 static void of_mux_clk_setup(struct device_node *node)
 {
 	struct clk *clk;
-	void __iomem *reg;
+	struct clk_omap_reg reg;
 	unsigned int num_parents;
 	const char **parent_names;
 	u8 clk_mux_flags = 0;
@@ -196,9 +194,7 @@ static void of_mux_clk_setup(struct device_node *node)
 
 	of_clk_parent_fill(node, parent_names, num_parents);
 
-	reg = ti_clk_get_reg_addr(node, 0);
-
-	if (IS_ERR(reg))
+	if (ti_clk_get_reg_addr(node, 0, &reg))
 		goto cleanup;
 
 	of_property_read_u32(node, "ti,bit-shift", &shift);
@@ -217,7 +213,7 @@ static void of_mux_clk_setup(struct device_node *node)
 	mask = (1 << fls(mask)) - 1;
 
 	clk = _register_mux(NULL, node->name, parent_names, num_parents,
-			    flags, reg, shift, mask, clk_mux_flags, NULL);
+			    flags, &reg, shift, mask, clk_mux_flags, NULL);
 
 	if (!IS_ERR(clk))
 		of_clk_add_provider(node, of_clk_src_simple_get, clk);
@@ -230,7 +226,6 @@ static void of_mux_clk_setup(struct device_node *node)
 struct clk_hw *ti_clk_build_component_mux(struct ti_clk_mux *setup)
 {
 	struct clk_omap_mux *mux;
-	struct clk_omap_reg *reg;
 	int num_parents;
 
 	if (!setup)
@@ -240,12 +235,10 @@ struct clk_hw *ti_clk_build_component_mux(struct ti_clk_mux *setup)
 	if (!mux)
 		return ERR_PTR(-ENOMEM);
 
-	reg = (struct clk_omap_reg *)&mux->reg;
-
 	mux->shift = setup->bit_shift;
 
-	reg->index = setup->module;
-	reg->offset = setup->reg;
+	mux->reg.index = setup->module;
+	mux->reg.offset = setup->reg;
 
 	if (setup->flags & CLKF_INDEX_STARTS_AT_ONE)
 		mux->flags |= CLK_MUX_INDEX_ONE;
@@ -268,9 +261,7 @@ static void __init of_ti_composite_mux_clk_setup(struct device_node *node)
 	if (!mux)
 		return;
 
-	mux->reg = ti_clk_get_reg_addr(node, 0);
-
-	if (IS_ERR(mux->reg))
+	if (ti_clk_get_reg_addr(node, 0, &mux->reg))
 		goto cleanup;
 
 	if (!of_property_read_u32(node, "ti,bit-shift", &val))
diff --git a/include/linux/clk/ti.h b/include/linux/clk/ti.h
index affdabd..d18da83 100644
--- a/include/linux/clk/ti.h
+++ b/include/linux/clk/ti.h
@@ -19,6 +19,18 @@
 #include <linux/clkdev.h>
 
 /**
+ * struct clk_omap_reg - OMAP register declaration
+ * @offset: offset from the master IP module base address
+ * @index: index of the master IP module
+ */
+struct clk_omap_reg {
+	void __iomem *ptr;
+	u16 offset;
+	u8 index;
+	u8 flags;
+};
+
+/**
  * struct dpll_data - DPLL registers and integration data
  * @mult_div1_reg: register containing the DPLL M and N bitfields
  * @mult_mask: mask of the DPLL M bitfield in @mult_div1_reg
@@ -67,12 +79,12 @@
  * can be placed into read-only space.
  */
 struct dpll_data {
-	void __iomem		*mult_div1_reg;
+	struct clk_omap_reg	mult_div1_reg;
 	u32			mult_mask;
 	u32			div1_mask;
 	struct clk_hw		*clk_bypass;
 	struct clk_hw		*clk_ref;
-	void __iomem		*control_reg;
+	struct clk_omap_reg	control_reg;
 	u32			enable_mask;
 	unsigned long		last_rounded_rate;
 	u16			last_rounded_m;
@@ -84,8 +96,8 @@ struct dpll_data {
 	u16			max_divider;
 	unsigned long		max_rate;
 	u8			modes;
-	void __iomem		*autoidle_reg;
-	void __iomem		*idlest_reg;
+	struct clk_omap_reg	autoidle_reg;
+	struct clk_omap_reg	idlest_reg;
 	u32			autoidle_mask;
 	u32			freqsel_mask;
 	u32			idlest_mask;
@@ -113,10 +125,10 @@ struct dpll_data {
  */
 struct clk_hw_omap_ops {
 	void	(*find_idlest)(struct clk_hw_omap *oclk,
-			       void __iomem **idlest_reg,
+			       struct clk_omap_reg *idlest_reg,
 			       u8 *idlest_bit, u8 *idlest_val);
 	void	(*find_companion)(struct clk_hw_omap *oclk,
-				  void __iomem **other_reg,
+				  struct clk_omap_reg *other_reg,
 				  u8 *other_bit);
 	void	(*allow_idle)(struct clk_hw_omap *oclk);
 	void	(*deny_idle)(struct clk_hw_omap *oclk);
@@ -139,10 +151,10 @@ struct clk_hw_omap {
 	struct list_head	node;
 	unsigned long		fixed_rate;
 	u8			fixed_div;
-	void __iomem		*enable_reg;
+	struct clk_omap_reg	enable_reg;
 	u8			enable_bit;
 	u8			flags;
-	void __iomem		*clksel_reg;
+	struct clk_omap_reg	clksel_reg;
 	struct dpll_data	*dpll_data;
 	const char		*clkdm_name;
 	struct clockdomain	*clkdm;
@@ -196,16 +208,6 @@ enum {
 };
 
 /**
- * struct clk_omap_reg - OMAP register declaration
- * @offset: offset from the master IP module base address
- * @index: index of the master IP module
- */
-struct clk_omap_reg {
-	u16 offset;
-	u16 index;
-};
-
-/**
  * struct ti_clk_ll_ops - low-level ops for clocks
  * @clk_readl: pointer to register read function
  * @clk_writel: pointer to register write function
@@ -222,16 +224,16 @@ struct clk_omap_reg {
  * operations not provided directly by clock drivers.
  */
 struct ti_clk_ll_ops {
-	u32	(*clk_readl)(void __iomem *reg);
-	void	(*clk_writel)(u32 val, void __iomem *reg);
+	u32	(*clk_readl)(const struct clk_omap_reg *reg);
+	void	(*clk_writel)(u32 val, const struct clk_omap_reg *reg);
 	int	(*clkdm_clk_enable)(struct clockdomain *clkdm, struct clk *clk);
 	int	(*clkdm_clk_disable)(struct clockdomain *clkdm,
 				     struct clk *clk);
 	struct clockdomain * (*clkdm_lookup)(const char *name);
 	int	(*cm_wait_module_ready)(u8 part, s16 prcm_mod, u16 idlest_reg,
 					u8 idlest_shift);
-	int	(*cm_split_idlest_reg)(void __iomem *idlest_reg, s16 *prcm_inst,
-				       u8 *idlest_reg_id);
+	int	(*cm_split_idlest_reg)(struct clk_omap_reg *idlest_reg,
+				       s16 *prcm_inst, u8 *idlest_reg_id);
 };
 
 #define to_clk_hw_omap(_hw) container_of(_hw, struct clk_hw_omap, hw)
-- 
1.9.1


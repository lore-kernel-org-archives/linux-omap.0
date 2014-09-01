From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 16/26] ARM: OMAP2+: PRM: add generic API for checking hardreset status
Date: Mon, 1 Sep 2014 21:09:05 +0300
Message-ID: <1409594955-1476-17-git-send-email-t-kristo@ti.com>
References: <1409594955-1476-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:37244 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754686AbaIASKN (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 1 Sep 2014 14:10:13 -0400
In-Reply-To: <1409594955-1476-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org

PRM driver now has a generic API for checking hardreset status. SoC
specific support functions are registered through the prm_ll_data.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c   |   18 +++++++++---------
 arch/arm/mach-omap2/prm.h          |    3 +++
 arch/arm/mach-omap2/prm2xxx.c      |    1 +
 arch/arm/mach-omap2/prm2xxx_3xxx.c |    6 ++++--
 arch/arm/mach-omap2/prm2xxx_3xxx.h |    2 +-
 arch/arm/mach-omap2/prm33xx.c      |    9 ++++++---
 arch/arm/mach-omap2/prm33xx.h      |    2 --
 arch/arm/mach-omap2/prm3xxx.c      |    1 +
 arch/arm/mach-omap2/prm44xx.c      |    1 +
 arch/arm/mach-omap2/prm_common.c   |   20 ++++++++++++++++++++
 10 files changed, 46 insertions(+), 17 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 57ff628..24d9599 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -2946,8 +2946,8 @@ static int _omap2_deassert_hardreset(struct omap_hwmod *oh,
 static int _omap2_is_hardreset_asserted(struct omap_hwmod *oh,
 					struct omap_hwmod_rst_info *ohri)
 {
-	return omap2_prm_is_hardreset_asserted(oh->prcm.omap2.module_offs,
-					       ohri->st_shift);
+	return prm_is_hardreset_asserted(ohri->st_shift, 0,
+					 oh->prcm.omap2.module_offs, 0);
 }
 
 /**
@@ -3019,10 +3019,10 @@ static int _omap4_is_hardreset_asserted(struct omap_hwmod *oh,
 	if (!oh->clkdm)
 		return -EINVAL;
 
-	return omap4_prminst_is_hardreset_asserted(ohri->rst_shift,
-				oh->clkdm->pwrdm.ptr->prcm_partition,
-				oh->clkdm->pwrdm.ptr->prcm_offs,
-				oh->prcm.omap4.rstctrl_offs);
+	return prm_is_hardreset_asserted(ohri->rst_shift,
+					 oh->clkdm->pwrdm.ptr->prcm_partition,
+					 oh->clkdm->pwrdm.ptr->prcm_offs,
+					 oh->prcm.omap4.rstctrl_offs);
 }
 
 /**
@@ -3082,9 +3082,9 @@ static int _am33xx_deassert_hardreset(struct omap_hwmod *oh,
 static int _am33xx_is_hardreset_asserted(struct omap_hwmod *oh,
 					struct omap_hwmod_rst_info *ohri)
 {
-	return am33xx_prm_is_hardreset_asserted(ohri->rst_shift,
-				oh->clkdm->pwrdm.ptr->prcm_offs,
-				oh->prcm.omap4.rstctrl_offs);
+	return prm_is_hardreset_asserted(ohri->rst_shift, 0,
+					 oh->clkdm->pwrdm.ptr->prcm_offs,
+					 oh->prcm.omap4.rstctrl_offs);
 }
 
 /* Public functions */
diff --git a/arch/arm/mach-omap2/prm.h b/arch/arm/mach-omap2/prm.h
index 790bb22..0dd8d83 100644
--- a/arch/arm/mach-omap2/prm.h
+++ b/arch/arm/mach-omap2/prm.h
@@ -142,6 +142,8 @@ struct prm_ll_data {
 	int (*assert_hardreset)(u8 shift, u8 part, s16 prm_mod, u16 offset);
 	int (*deassert_hardreset)(u8 shift, u8 st_shift, u8 part, s16 prm_mod,
 				  u16 offset, u16 st_offset);
+	int (*is_hardreset_asserted)(u8 shift, u8 part, s16 prm_mod,
+				     u16 offset);
 };
 
 extern int prm_register(struct prm_ll_data *pld);
@@ -150,6 +152,7 @@ extern int prm_unregister(struct prm_ll_data *pld);
 int prm_assert_hardreset(u8 shift, u8 part, s16 prm_mod, u16 offset);
 int prm_deassert_hardreset(u8 shift, u8 st_shift, u8 part, s16 prm_mod,
 			   u16 offset, u16 st_offset);
+int prm_is_hardreset_asserted(u8 shift, u8 part, s16 prm_mod, u16 offset);
 extern u32 prm_read_reset_sources(void);
 extern bool prm_was_any_context_lost_old(u8 part, s16 inst, u16 idx);
 extern void prm_clear_context_loss_flags_old(u8 part, s16 inst, u16 idx);
diff --git a/arch/arm/mach-omap2/prm2xxx.c b/arch/arm/mach-omap2/prm2xxx.c
index 343fc73..54ae555 100644
--- a/arch/arm/mach-omap2/prm2xxx.c
+++ b/arch/arm/mach-omap2/prm2xxx.c
@@ -214,6 +214,7 @@ static struct prm_ll_data omap2xxx_prm_ll_data = {
 	.read_reset_sources = &omap2xxx_prm_read_reset_sources,
 	.assert_hardreset = &omap2_prm_assert_hardreset,
 	.deassert_hardreset = &omap2_prm_deassert_hardreset,
+	.is_hardreset_asserted = &omap2_prm_is_hardreset_asserted,
 };
 
 int __init omap2xxx_prm_init(void)
diff --git a/arch/arm/mach-omap2/prm2xxx_3xxx.c b/arch/arm/mach-omap2/prm2xxx_3xxx.c
index 9466b1e..cc3341f 100644
--- a/arch/arm/mach-omap2/prm2xxx_3xxx.c
+++ b/arch/arm/mach-omap2/prm2xxx_3xxx.c
@@ -24,14 +24,16 @@
 /**
  * omap2_prm_is_hardreset_asserted - read the HW reset line state of
  * submodules contained in the hwmod module
- * @prm_mod: PRM submodule base (e.g. CORE_MOD)
  * @shift: register bit shift corresponding to the reset line to check
+ * @part: PRM partition, ignored for OMAP2
+ * @prm_mod: PRM submodule base (e.g. CORE_MOD)
+ * @offset: register offset, ignored for OMAP2
  *
  * Returns 1 if the (sub)module hardreset line is currently asserted,
  * 0 if the (sub)module hardreset line is not currently asserted, or
  * -EINVAL if called while running on a non-OMAP2/3 chip.
  */
-int omap2_prm_is_hardreset_asserted(s16 prm_mod, u8 shift)
+int omap2_prm_is_hardreset_asserted(u8 shift, u8 part, s16 prm_mod, u16 offset)
 {
 	return omap2_prm_read_mod_bits_shift(prm_mod, OMAP2_RM_RSTCTRL,
 				       (1 << shift));
diff --git a/arch/arm/mach-omap2/prm2xxx_3xxx.h b/arch/arm/mach-omap2/prm2xxx_3xxx.h
index 253d414..f57e29b 100644
--- a/arch/arm/mach-omap2/prm2xxx_3xxx.h
+++ b/arch/arm/mach-omap2/prm2xxx_3xxx.h
@@ -100,7 +100,7 @@ static inline u32 omap2_prm_clear_mod_reg_bits(u32 bits, s16 module, s16 idx)
 }
 
 /* These omap2_ PRM functions apply to both OMAP2 and 3 */
-extern int omap2_prm_is_hardreset_asserted(s16 prm_mod, u8 shift);
+int omap2_prm_is_hardreset_asserted(u8 shift, u8 part, s16 prm_mod, u16 offset);
 int omap2_prm_assert_hardreset(u8 shift, u8 part, s16 prm_mod,
 			       u16 offset);
 int omap2_prm_deassert_hardreset(u8 rst_shift, u8 st_shift, u8 part,
diff --git a/arch/arm/mach-omap2/prm33xx.c b/arch/arm/mach-omap2/prm33xx.c
index ea0fea6..3cbfb78 100644
--- a/arch/arm/mach-omap2/prm33xx.c
+++ b/arch/arm/mach-omap2/prm33xx.c
@@ -52,6 +52,7 @@ u32 am33xx_prm_rmw_reg_bits(u32 mask, u32 bits, s16 inst, s16 idx)
  * am33xx_prm_is_hardreset_asserted - read the HW reset line state of
  * submodules contained in the hwmod module
  * @shift: register bit shift corresponding to the reset line to check
+ * @part: PRM partition, ignored for AM33xx
  * @inst: CM instance register offset (*_INST macro)
  * @rstctrl_offs: RM_RSTCTRL register address offset for this module
  *
@@ -59,7 +60,8 @@ u32 am33xx_prm_rmw_reg_bits(u32 mask, u32 bits, s16 inst, s16 idx)
  * 0 if the (sub)module hardreset line is not currently asserted, or
  * -EINVAL upon parameter error.
  */
-int am33xx_prm_is_hardreset_asserted(u8 shift, s16 inst, u16 rstctrl_offs)
+static int am33xx_prm_is_hardreset_asserted(u8 shift, u8 part, s16 inst,
+					    u16 rstctrl_offs)
 {
 	u32 v;
 
@@ -121,7 +123,7 @@ static int am33xx_prm_deassert_hardreset(u8 shift, u8 st_shift, u8 part,
 	u32 mask = 1 << st_shift;
 
 	/* Check the current status to avoid  de-asserting the line twice */
-	if (am33xx_prm_is_hardreset_asserted(shift, inst, rstctrl_offs) == 0)
+	if (am33xx_prm_is_hardreset_asserted(shift, 0, inst, rstctrl_offs) == 0)
 		return -EEXIST;
 
 	/* Clear the reset status by writing 1 to the status bit */
@@ -133,7 +135,7 @@ static int am33xx_prm_deassert_hardreset(u8 shift, u8 st_shift, u8 part,
 	am33xx_prm_rmw_reg_bits(mask, 0, inst, rstctrl_offs);
 
 	/* wait the status to be set */
-	omap_test_timeout(am33xx_prm_is_hardreset_asserted(st_shift, inst,
+	omap_test_timeout(am33xx_prm_is_hardreset_asserted(st_shift, 0, inst,
 							   rstst_offs),
 			  MAX_MODULE_HARDRESET_WAIT, c);
 
@@ -351,6 +353,7 @@ struct pwrdm_ops am33xx_pwrdm_operations = {
 static struct prm_ll_data am33xx_prm_ll_data = {
 	.assert_hardreset		= am33xx_prm_assert_hardreset,
 	.deassert_hardreset		= am33xx_prm_deassert_hardreset,
+	.is_hardreset_asserted		= am33xx_prm_is_hardreset_asserted,
 };
 
 int __init am33xx_prm_init(void)
diff --git a/arch/arm/mach-omap2/prm33xx.h b/arch/arm/mach-omap2/prm33xx.h
index 6d483e0..49ad5b8 100644
--- a/arch/arm/mach-omap2/prm33xx.h
+++ b/arch/arm/mach-omap2/prm33xx.h
@@ -122,8 +122,6 @@ extern u32 am33xx_prm_read_reg(s16 inst, u16 idx);
 extern void am33xx_prm_write_reg(u32 val, s16 inst, u16 idx);
 extern u32 am33xx_prm_rmw_reg_bits(u32 mask, u32 bits, s16 inst, s16 idx);
 extern void am33xx_prm_global_warm_sw_reset(void);
-extern int am33xx_prm_is_hardreset_asserted(u8 shift, s16 inst,
-		u16 rstctrl_offs);
 int am33xx_prm_init(void);
 
 #endif /* ASSEMBLER */
diff --git a/arch/arm/mach-omap2/prm3xxx.c b/arch/arm/mach-omap2/prm3xxx.c
index e954195..5c1bb25 100644
--- a/arch/arm/mach-omap2/prm3xxx.c
+++ b/arch/arm/mach-omap2/prm3xxx.c
@@ -642,6 +642,7 @@ static struct prm_ll_data omap3xxx_prm_ll_data = {
 	.late_init = &omap3xxx_prm_late_init,
 	.assert_hardreset = &omap2_prm_assert_hardreset,
 	.deassert_hardreset = &omap2_prm_deassert_hardreset,
+	.is_hardreset_asserted = &omap2_prm_is_hardreset_asserted,
 };
 
 int __init omap3xxx_prm_init(void)
diff --git a/arch/arm/mach-omap2/prm44xx.c b/arch/arm/mach-omap2/prm44xx.c
index 0da2ba8..d357ca9 100644
--- a/arch/arm/mach-omap2/prm44xx.c
+++ b/arch/arm/mach-omap2/prm44xx.c
@@ -690,6 +690,7 @@ static struct prm_ll_data omap44xx_prm_ll_data = {
 	.late_init = &omap44xx_prm_late_init,
 	.assert_hardreset	= omap4_prminst_assert_hardreset,
 	.deassert_hardreset	= omap4_prminst_deassert_hardreset,
+	.is_hardreset_asserted	= omap4_prminst_is_hardreset_asserted,
 };
 
 int __init omap44xx_prm_init(void)
diff --git a/arch/arm/mach-omap2/prm_common.c b/arch/arm/mach-omap2/prm_common.c
index f5fa06e..f246bb4 100644
--- a/arch/arm/mach-omap2/prm_common.c
+++ b/arch/arm/mach-omap2/prm_common.c
@@ -467,6 +467,26 @@ int prm_deassert_hardreset(u8 shift, u8 st_shift, u8 part, s16 prm_mod,
 }
 
 /**
+ * prm_is_hardreset_asserted - check the hardreset status for an IP block
+ * @shift: register bit shift corresponding to the reset line
+ * @part: PRM partition
+ * @prm_mod: PRM submodule base or instance offset
+ * @offset: register offset
+ *
+ * Checks if a hardware reset line for an IP block is enabled or not.
+ */
+int prm_is_hardreset_asserted(u8 shift, u8 part, s16 prm_mod, u16 offset)
+{
+	if (!prm_ll_data->is_hardreset_asserted) {
+		WARN_ONCE(1, "prm: %s: no mapping function defined\n",
+			  __func__);
+		return -EINVAL;
+	}
+
+	return prm_ll_data->is_hardreset_asserted(shift, part, prm_mod, offset);
+}
+
+/**
  * prm_register - register per-SoC low-level data with the PRM
  * @pld: low-level per-SoC OMAP PRM data & function pointers to register
  *
-- 
1.7.9.5


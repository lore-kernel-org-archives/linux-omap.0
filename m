From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 14/26] ARM: OMAP2+: PRM: add generic API for asserting hardware reset
Date: Mon, 1 Sep 2014 21:09:03 +0300
Message-ID: <1409594955-1476-15-git-send-email-t-kristo@ti.com>
References: <1409594955-1476-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:34868 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754691AbaIASKP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Sep 2014 14:10:15 -0400
In-Reply-To: <1409594955-1476-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org

PRM driver now has a generic API for asserting hardware resets. SoC
specific support functions are registered through the prm_ll_data.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c   |   18 +++++++++---------
 arch/arm/mach-omap2/prm.h          |    3 +++
 arch/arm/mach-omap2/prm2xxx.c      |    1 +
 arch/arm/mach-omap2/prm2xxx_3xxx.c |    6 ++++--
 arch/arm/mach-omap2/prm2xxx_3xxx.h |    3 ++-
 arch/arm/mach-omap2/prm33xx.c      |    8 ++++++--
 arch/arm/mach-omap2/prm33xx.h      |    1 -
 arch/arm/mach-omap2/prm3xxx.c      |    1 +
 arch/arm/mach-omap2/prm44xx.c      |    1 +
 arch/arm/mach-omap2/prm_common.c   |   20 ++++++++++++++++++++
 10 files changed, 47 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index c52dc4c..9044ec2 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -2909,8 +2909,8 @@ static int _omap4_wait_target_ready(struct omap_hwmod *oh)
 static int _omap2_assert_hardreset(struct omap_hwmod *oh,
 				   struct omap_hwmod_rst_info *ohri)
 {
-	return omap2_prm_assert_hardreset(oh->prcm.omap2.module_offs,
-					  ohri->rst_shift);
+	return prm_assert_hardreset(ohri->rst_shift, 0,
+				    oh->prcm.omap2.module_offs, 0);
 }
 
 /**
@@ -2969,10 +2969,10 @@ static int _omap4_assert_hardreset(struct omap_hwmod *oh,
 	if (!oh->clkdm)
 		return -EINVAL;
 
-	return omap4_prminst_assert_hardreset(ohri->rst_shift,
-				oh->clkdm->pwrdm.ptr->prcm_partition,
-				oh->clkdm->pwrdm.ptr->prcm_offs,
-				oh->prcm.omap4.rstctrl_offs);
+	return prm_assert_hardreset(ohri->rst_shift,
+				    oh->clkdm->pwrdm.ptr->prcm_partition,
+				    oh->clkdm->pwrdm.ptr->prcm_offs,
+				    oh->prcm.omap4.rstctrl_offs);
 }
 
 /**
@@ -3042,9 +3042,9 @@ static int _am33xx_assert_hardreset(struct omap_hwmod *oh,
 				   struct omap_hwmod_rst_info *ohri)
 
 {
-	return am33xx_prm_assert_hardreset(ohri->rst_shift,
-				oh->clkdm->pwrdm.ptr->prcm_offs,
-				oh->prcm.omap4.rstctrl_offs);
+	return prm_assert_hardreset(ohri->rst_shift, 0,
+				    oh->clkdm->pwrdm.ptr->prcm_offs,
+				    oh->prcm.omap4.rstctrl_offs);
 }
 
 /**
diff --git a/arch/arm/mach-omap2/prm.h b/arch/arm/mach-omap2/prm.h
index 9f4d747..6eea160 100644
--- a/arch/arm/mach-omap2/prm.h
+++ b/arch/arm/mach-omap2/prm.h
@@ -128,6 +128,7 @@ struct prm_reset_src_map {
  * @was_any_context_lost_old: ptr to the SoC PRM context loss test fn
  * @clear_context_loss_flags_old: ptr to the SoC PRM context loss flag clear fn
  * @late_init: ptr to the late init function
+ * @assert_hardreset: ptr to the SoC PRM hardreset assert impl
  *
  * XXX @was_any_context_lost_old and @clear_context_loss_flags_old are
  * deprecated.
@@ -137,11 +138,13 @@ struct prm_ll_data {
 	bool (*was_any_context_lost_old)(u8 part, s16 inst, u16 idx);
 	void (*clear_context_loss_flags_old)(u8 part, s16 inst, u16 idx);
 	int (*late_init)(void);
+	int (*assert_hardreset)(u8 shift, u8 part, s16 prm_mod, u16 offset);
 };
 
 extern int prm_register(struct prm_ll_data *pld);
 extern int prm_unregister(struct prm_ll_data *pld);
 
+int prm_assert_hardreset(u8 shift, u8 part, s16 prm_mod, u16 offset);
 extern u32 prm_read_reset_sources(void);
 extern bool prm_was_any_context_lost_old(u8 part, s16 inst, u16 idx);
 extern void prm_clear_context_loss_flags_old(u8 part, s16 inst, u16 idx);
diff --git a/arch/arm/mach-omap2/prm2xxx.c b/arch/arm/mach-omap2/prm2xxx.c
index 8695805..fa4448b 100644
--- a/arch/arm/mach-omap2/prm2xxx.c
+++ b/arch/arm/mach-omap2/prm2xxx.c
@@ -212,6 +212,7 @@ struct pwrdm_ops omap2_pwrdm_operations = {
 
 static struct prm_ll_data omap2xxx_prm_ll_data = {
 	.read_reset_sources = &omap2xxx_prm_read_reset_sources,
+	.assert_hardreset = &omap2_prm_assert_hardreset,
 };
 
 int __init omap2xxx_prm_init(void)
diff --git a/arch/arm/mach-omap2/prm2xxx_3xxx.c b/arch/arm/mach-omap2/prm2xxx_3xxx.c
index c13b4e2..8758cd6 100644
--- a/arch/arm/mach-omap2/prm2xxx_3xxx.c
+++ b/arch/arm/mach-omap2/prm2xxx_3xxx.c
@@ -39,8 +39,10 @@ int omap2_prm_is_hardreset_asserted(s16 prm_mod, u8 shift)
 
 /**
  * omap2_prm_assert_hardreset - assert the HW reset line of a submodule
- * @prm_mod: PRM submodule base (e.g. CORE_MOD)
  * @shift: register bit shift corresponding to the reset line to assert
+ * @part: PRM partition, ignored for OMAP2
+ * @prm_mod: PRM submodule base (e.g. CORE_MOD)
+ * @offset: register offset, ignored for OMAP2
  *
  * Some IPs like dsp or iva contain processors that require an HW
  * reset line to be asserted / deasserted in order to fully enable the
@@ -49,7 +51,7 @@ int omap2_prm_is_hardreset_asserted(s16 prm_mod, u8 shift)
  * place the submodule into reset.  Returns 0 upon success or -EINVAL
  * upon an argument error.
  */
-int omap2_prm_assert_hardreset(s16 prm_mod, u8 shift)
+int omap2_prm_assert_hardreset(u8 shift, u8 part, s16 prm_mod, u16 offset)
 {
 	u32 mask;
 
diff --git a/arch/arm/mach-omap2/prm2xxx_3xxx.h b/arch/arm/mach-omap2/prm2xxx_3xxx.h
index 1a3a963..9674962 100644
--- a/arch/arm/mach-omap2/prm2xxx_3xxx.h
+++ b/arch/arm/mach-omap2/prm2xxx_3xxx.h
@@ -101,7 +101,8 @@ static inline u32 omap2_prm_clear_mod_reg_bits(u32 bits, s16 module, s16 idx)
 
 /* These omap2_ PRM functions apply to both OMAP2 and 3 */
 extern int omap2_prm_is_hardreset_asserted(s16 prm_mod, u8 shift);
-extern int omap2_prm_assert_hardreset(s16 prm_mod, u8 shift);
+int omap2_prm_assert_hardreset(u8 shift, u8 part, s16 prm_mod,
+			       u16 offset);
 extern int omap2_prm_deassert_hardreset(s16 prm_mod, u8 rst_shift, u8 st_shift);
 
 extern int omap2_pwrdm_set_next_pwrst(struct powerdomain *pwrdm, u8 pwrst);
diff --git a/arch/arm/mach-omap2/prm33xx.c b/arch/arm/mach-omap2/prm33xx.c
index f149e7c..992a40e 100644
--- a/arch/arm/mach-omap2/prm33xx.c
+++ b/arch/arm/mach-omap2/prm33xx.c
@@ -73,6 +73,7 @@ int am33xx_prm_is_hardreset_asserted(u8 shift, s16 inst, u16 rstctrl_offs)
 /**
  * am33xx_prm_assert_hardreset - assert the HW reset line of a submodule
  * @shift: register bit shift corresponding to the reset line to assert
+ * @part: CM partition, ignored for AM33xx
  * @inst: CM instance register offset (*_INST macro)
  * @rstctrl_reg: RM_RSTCTRL register address for this module
  *
@@ -83,7 +84,8 @@ int am33xx_prm_is_hardreset_asserted(u8 shift, s16 inst, u16 rstctrl_offs)
  * place the submodule into reset.  Returns 0 upon success or -EINVAL
  * upon an argument error.
  */
-int am33xx_prm_assert_hardreset(u8 shift, s16 inst, u16 rstctrl_offs)
+static int am33xx_prm_assert_hardreset(u8 shift, u8 part, s16 inst,
+				       u16 rstctrl_offs)
 {
 	u32 mask = 1 << shift;
 
@@ -343,7 +345,9 @@ struct pwrdm_ops am33xx_pwrdm_operations = {
 	.pwrdm_has_voltdm		= am33xx_check_vcvp,
 };
 
-static struct prm_ll_data am33xx_prm_ll_data;
+static struct prm_ll_data am33xx_prm_ll_data = {
+	.assert_hardreset		= am33xx_prm_assert_hardreset,
+};
 
 int __init am33xx_prm_init(void)
 {
diff --git a/arch/arm/mach-omap2/prm33xx.h b/arch/arm/mach-omap2/prm33xx.h
index 5cdfdc0..1d9aad8 100644
--- a/arch/arm/mach-omap2/prm33xx.h
+++ b/arch/arm/mach-omap2/prm33xx.h
@@ -124,7 +124,6 @@ extern u32 am33xx_prm_rmw_reg_bits(u32 mask, u32 bits, s16 inst, s16 idx);
 extern void am33xx_prm_global_warm_sw_reset(void);
 extern int am33xx_prm_is_hardreset_asserted(u8 shift, s16 inst,
 		u16 rstctrl_offs);
-extern int am33xx_prm_assert_hardreset(u8 shift, s16 inst, u16 rstctrl_offs);
 extern int am33xx_prm_deassert_hardreset(u8 shift, u8 st_shift, s16 inst,
 		u16 rstctrl_offs, u16 rstst_offs);
 int am33xx_prm_init(void);
diff --git a/arch/arm/mach-omap2/prm3xxx.c b/arch/arm/mach-omap2/prm3xxx.c
index e0088e0..fc01e52 100644
--- a/arch/arm/mach-omap2/prm3xxx.c
+++ b/arch/arm/mach-omap2/prm3xxx.c
@@ -640,6 +640,7 @@ static int omap3xxx_prm_late_init(void);
 static struct prm_ll_data omap3xxx_prm_ll_data = {
 	.read_reset_sources = &omap3xxx_prm_read_reset_sources,
 	.late_init = &omap3xxx_prm_late_init,
+	.assert_hardreset = &omap2_prm_assert_hardreset,
 };
 
 int __init omap3xxx_prm_init(void)
diff --git a/arch/arm/mach-omap2/prm44xx.c b/arch/arm/mach-omap2/prm44xx.c
index 76e75aa..1c86270 100644
--- a/arch/arm/mach-omap2/prm44xx.c
+++ b/arch/arm/mach-omap2/prm44xx.c
@@ -688,6 +688,7 @@ static struct prm_ll_data omap44xx_prm_ll_data = {
 	.was_any_context_lost_old = &omap44xx_prm_was_any_context_lost_old,
 	.clear_context_loss_flags_old = &omap44xx_prm_clear_context_loss_flags_old,
 	.late_init = &omap44xx_prm_late_init,
+	.assert_hardreset	= omap4_prminst_assert_hardreset,
 };
 
 int __init omap44xx_prm_init(void)
diff --git a/arch/arm/mach-omap2/prm_common.c b/arch/arm/mach-omap2/prm_common.c
index 76ca320..c5c4414 100644
--- a/arch/arm/mach-omap2/prm_common.c
+++ b/arch/arm/mach-omap2/prm_common.c
@@ -423,6 +423,26 @@ void prm_clear_context_loss_flags_old(u8 part, s16 inst, u16 idx)
 }
 
 /**
+ * prm_assert_hardreset - assert hardreset for an IP block
+ * @shift: register bit shift corresponding to the reset line
+ * @part: PRM partition
+ * @prm_mod: PRM submodule base or instance offset
+ * @offset: register offset
+ *
+ * Asserts a hardware reset line for an IP block.
+ */
+int prm_assert_hardreset(u8 shift, u8 part, s16 prm_mod, u16 offset)
+{
+	if (!prm_ll_data->assert_hardreset) {
+		WARN_ONCE(1, "prm: %s: no mapping function defined\n",
+			  __func__);
+		return -EINVAL;
+	}
+
+	return prm_ll_data->assert_hardreset(shift, part, prm_mod, offset);
+}
+
+/**
  * prm_register - register per-SoC low-level data with the PRM
  * @pld: low-level per-SoC OMAP PRM data & function pointers to register
  *
-- 
1.7.9.5


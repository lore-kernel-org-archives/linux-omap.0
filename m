From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 15/26] ARM: OMAP2+: PRM: add generic API for deasserting hardware reset
Date: Mon, 1 Sep 2014 21:09:04 +0300
Message-ID: <1409594955-1476-16-git-send-email-t-kristo@ti.com>
References: <1409594955-1476-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:34869 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754700AbaIASKQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Sep 2014 14:10:16 -0400
In-Reply-To: <1409594955-1476-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org

PRM driver now has a generic API for deasserting hardware resets. SoC
specific support functions are registered through the prm_ll_data.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c   |   22 ++++++++++------------
 arch/arm/mach-omap2/prm.h          |    5 +++++
 arch/arm/mach-omap2/prm2xxx.c      |    1 +
 arch/arm/mach-omap2/prm2xxx_3xxx.c |    7 ++++++-
 arch/arm/mach-omap2/prm2xxx_3xxx.h |    4 +++-
 arch/arm/mach-omap2/prm33xx.c      |    8 ++++++--
 arch/arm/mach-omap2/prm33xx.h      |    2 --
 arch/arm/mach-omap2/prm3xxx.c      |    1 +
 arch/arm/mach-omap2/prm44xx.c      |    1 +
 arch/arm/mach-omap2/prm_common.c   |   24 ++++++++++++++++++++++++
 arch/arm/mach-omap2/prminst44xx.c  |   10 +++++++---
 arch/arm/mach-omap2/prminst44xx.h  |    5 +++--
 12 files changed, 67 insertions(+), 23 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 9044ec2..57ff628 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -2927,9 +2927,8 @@ static int _omap2_assert_hardreset(struct omap_hwmod *oh,
 static int _omap2_deassert_hardreset(struct omap_hwmod *oh,
 				     struct omap_hwmod_rst_info *ohri)
 {
-	return omap2_prm_deassert_hardreset(oh->prcm.omap2.module_offs,
-					    ohri->rst_shift,
-					    ohri->st_shift);
+	return prm_deassert_hardreset(ohri->rst_shift, ohri->st_shift, 0,
+				      oh->prcm.omap2.module_offs, 0, 0);
 }
 
 /**
@@ -2996,10 +2995,10 @@ static int _omap4_deassert_hardreset(struct omap_hwmod *oh,
 	if (ohri->st_shift)
 		pr_err("omap_hwmod: %s: %s: hwmod data error: OMAP4 does not support st_shift\n",
 		       oh->name, ohri->name);
-	return omap4_prminst_deassert_hardreset(ohri->rst_shift,
-				oh->clkdm->pwrdm.ptr->prcm_partition,
-				oh->clkdm->pwrdm.ptr->prcm_offs,
-				oh->prcm.omap4.rstctrl_offs);
+	return prm_deassert_hardreset(ohri->rst_shift, 0,
+				      oh->clkdm->pwrdm.ptr->prcm_partition,
+				      oh->clkdm->pwrdm.ptr->prcm_offs,
+				      oh->prcm.omap4.rstctrl_offs, 0);
 }
 
 /**
@@ -3062,11 +3061,10 @@ static int _am33xx_assert_hardreset(struct omap_hwmod *oh,
 static int _am33xx_deassert_hardreset(struct omap_hwmod *oh,
 				     struct omap_hwmod_rst_info *ohri)
 {
-	return am33xx_prm_deassert_hardreset(ohri->rst_shift,
-				ohri->st_shift,
-				oh->clkdm->pwrdm.ptr->prcm_offs,
-				oh->prcm.omap4.rstctrl_offs,
-				oh->prcm.omap4.rstst_offs);
+	return prm_deassert_hardreset(ohri->rst_shift, ohri->st_shift, 0,
+				      oh->clkdm->pwrdm.ptr->prcm_offs,
+				      oh->prcm.omap4.rstctrl_offs,
+				      oh->prcm.omap4.rstst_offs);
 }
 
 /**
diff --git a/arch/arm/mach-omap2/prm.h b/arch/arm/mach-omap2/prm.h
index 6eea160..790bb22 100644
--- a/arch/arm/mach-omap2/prm.h
+++ b/arch/arm/mach-omap2/prm.h
@@ -129,6 +129,7 @@ struct prm_reset_src_map {
  * @clear_context_loss_flags_old: ptr to the SoC PRM context loss flag clear fn
  * @late_init: ptr to the late init function
  * @assert_hardreset: ptr to the SoC PRM hardreset assert impl
+ * @deassert_hardreset: ptr to the SoC PRM hardreset deassert impl
  *
  * XXX @was_any_context_lost_old and @clear_context_loss_flags_old are
  * deprecated.
@@ -139,12 +140,16 @@ struct prm_ll_data {
 	void (*clear_context_loss_flags_old)(u8 part, s16 inst, u16 idx);
 	int (*late_init)(void);
 	int (*assert_hardreset)(u8 shift, u8 part, s16 prm_mod, u16 offset);
+	int (*deassert_hardreset)(u8 shift, u8 st_shift, u8 part, s16 prm_mod,
+				  u16 offset, u16 st_offset);
 };
 
 extern int prm_register(struct prm_ll_data *pld);
 extern int prm_unregister(struct prm_ll_data *pld);
 
 int prm_assert_hardreset(u8 shift, u8 part, s16 prm_mod, u16 offset);
+int prm_deassert_hardreset(u8 shift, u8 st_shift, u8 part, s16 prm_mod,
+			   u16 offset, u16 st_offset);
 extern u32 prm_read_reset_sources(void);
 extern bool prm_was_any_context_lost_old(u8 part, s16 inst, u16 idx);
 extern void prm_clear_context_loss_flags_old(u8 part, s16 inst, u16 idx);
diff --git a/arch/arm/mach-omap2/prm2xxx.c b/arch/arm/mach-omap2/prm2xxx.c
index fa4448b..343fc73 100644
--- a/arch/arm/mach-omap2/prm2xxx.c
+++ b/arch/arm/mach-omap2/prm2xxx.c
@@ -213,6 +213,7 @@ struct pwrdm_ops omap2_pwrdm_operations = {
 static struct prm_ll_data omap2xxx_prm_ll_data = {
 	.read_reset_sources = &omap2xxx_prm_read_reset_sources,
 	.assert_hardreset = &omap2_prm_assert_hardreset,
+	.deassert_hardreset = &omap2_prm_deassert_hardreset,
 };
 
 int __init omap2xxx_prm_init(void)
diff --git a/arch/arm/mach-omap2/prm2xxx_3xxx.c b/arch/arm/mach-omap2/prm2xxx_3xxx.c
index 8758cd6..9466b1e 100644
--- a/arch/arm/mach-omap2/prm2xxx_3xxx.c
+++ b/arch/arm/mach-omap2/prm2xxx_3xxx.c
@@ -66,6 +66,10 @@ int omap2_prm_assert_hardreset(u8 shift, u8 part, s16 prm_mod, u16 offset)
  * @prm_mod: PRM submodule base (e.g. CORE_MOD)
  * @rst_shift: register bit shift corresponding to the reset line to deassert
  * @st_shift: register bit shift for the status of the deasserted submodule
+ * @part: PRM partition, not used for OMAP2
+ * @prm_mod: PRM submodule base (e.g. CORE_MOD)
+ * @rst_offset: reset register offset, not used for OMAP2
+ * @st_offset: reset status register offset, not used for OMAP2
  *
  * Some IPs like dsp or iva contain processors that require an HW
  * reset line to be asserted / deasserted in order to fully enable the
@@ -76,7 +80,8 @@ int omap2_prm_assert_hardreset(u8 shift, u8 part, s16 prm_mod, u16 offset)
  * -EINVAL upon an argument error, -EEXIST if the submodule was already out
  * of reset, or -EBUSY if the submodule did not exit reset promptly.
  */
-int omap2_prm_deassert_hardreset(s16 prm_mod, u8 rst_shift, u8 st_shift)
+int omap2_prm_deassert_hardreset(u8 rst_shift, u8 st_shift, u8 part,
+				 s16 prm_mod, u16 rst_offset, u16 st_offset)
 {
 	u32 rst, st;
 	int c;
diff --git a/arch/arm/mach-omap2/prm2xxx_3xxx.h b/arch/arm/mach-omap2/prm2xxx_3xxx.h
index 9674962..253d414 100644
--- a/arch/arm/mach-omap2/prm2xxx_3xxx.h
+++ b/arch/arm/mach-omap2/prm2xxx_3xxx.h
@@ -103,7 +103,9 @@ static inline u32 omap2_prm_clear_mod_reg_bits(u32 bits, s16 module, s16 idx)
 extern int omap2_prm_is_hardreset_asserted(s16 prm_mod, u8 shift);
 int omap2_prm_assert_hardreset(u8 shift, u8 part, s16 prm_mod,
 			       u16 offset);
-extern int omap2_prm_deassert_hardreset(s16 prm_mod, u8 rst_shift, u8 st_shift);
+int omap2_prm_deassert_hardreset(u8 rst_shift, u8 st_shift, u8 part,
+				 s16 prm_mod, u16 reset_offset,
+				 u16 st_offset);
 
 extern int omap2_pwrdm_set_next_pwrst(struct powerdomain *pwrdm, u8 pwrst);
 extern int omap2_pwrdm_read_next_pwrst(struct powerdomain *pwrdm);
diff --git a/arch/arm/mach-omap2/prm33xx.c b/arch/arm/mach-omap2/prm33xx.c
index 992a40e..ea0fea6 100644
--- a/arch/arm/mach-omap2/prm33xx.c
+++ b/arch/arm/mach-omap2/prm33xx.c
@@ -98,6 +98,8 @@ static int am33xx_prm_assert_hardreset(u8 shift, u8 part, s16 inst,
  * am33xx_prm_deassert_hardreset - deassert a submodule hardreset line and
  * wait
  * @shift: register bit shift corresponding to the reset line to deassert
+ * @st_shift: reset status register bit shift corresponding to the reset line
+ * @part: PRM partition, not used for AM33xx
  * @inst: CM instance register offset (*_INST macro)
  * @rstctrl_reg: RM_RSTCTRL register address for this module
  * @rstst_reg: RM_RSTST register address for this module
@@ -111,8 +113,9 @@ static int am33xx_prm_assert_hardreset(u8 shift, u8 part, s16 inst,
  * -EINVAL upon an argument error, -EEXIST if the submodule was already out
  * of reset, or -EBUSY if the submodule did not exit reset promptly.
  */
-int am33xx_prm_deassert_hardreset(u8 shift, u8 st_shift, s16 inst,
-		u16 rstctrl_offs, u16 rstst_offs)
+static int am33xx_prm_deassert_hardreset(u8 shift, u8 st_shift, u8 part,
+					 s16 inst, u16 rstctrl_offs,
+					 u16 rstst_offs)
 {
 	int c;
 	u32 mask = 1 << st_shift;
@@ -347,6 +350,7 @@ struct pwrdm_ops am33xx_pwrdm_operations = {
 
 static struct prm_ll_data am33xx_prm_ll_data = {
 	.assert_hardreset		= am33xx_prm_assert_hardreset,
+	.deassert_hardreset		= am33xx_prm_deassert_hardreset,
 };
 
 int __init am33xx_prm_init(void)
diff --git a/arch/arm/mach-omap2/prm33xx.h b/arch/arm/mach-omap2/prm33xx.h
index 1d9aad8..6d483e0 100644
--- a/arch/arm/mach-omap2/prm33xx.h
+++ b/arch/arm/mach-omap2/prm33xx.h
@@ -124,8 +124,6 @@ extern u32 am33xx_prm_rmw_reg_bits(u32 mask, u32 bits, s16 inst, s16 idx);
 extern void am33xx_prm_global_warm_sw_reset(void);
 extern int am33xx_prm_is_hardreset_asserted(u8 shift, s16 inst,
 		u16 rstctrl_offs);
-extern int am33xx_prm_deassert_hardreset(u8 shift, u8 st_shift, s16 inst,
-		u16 rstctrl_offs, u16 rstst_offs);
 int am33xx_prm_init(void);
 
 #endif /* ASSEMBLER */
diff --git a/arch/arm/mach-omap2/prm3xxx.c b/arch/arm/mach-omap2/prm3xxx.c
index fc01e52..e954195 100644
--- a/arch/arm/mach-omap2/prm3xxx.c
+++ b/arch/arm/mach-omap2/prm3xxx.c
@@ -641,6 +641,7 @@ static struct prm_ll_data omap3xxx_prm_ll_data = {
 	.read_reset_sources = &omap3xxx_prm_read_reset_sources,
 	.late_init = &omap3xxx_prm_late_init,
 	.assert_hardreset = &omap2_prm_assert_hardreset,
+	.deassert_hardreset = &omap2_prm_deassert_hardreset,
 };
 
 int __init omap3xxx_prm_init(void)
diff --git a/arch/arm/mach-omap2/prm44xx.c b/arch/arm/mach-omap2/prm44xx.c
index 1c86270..0da2ba8 100644
--- a/arch/arm/mach-omap2/prm44xx.c
+++ b/arch/arm/mach-omap2/prm44xx.c
@@ -689,6 +689,7 @@ static struct prm_ll_data omap44xx_prm_ll_data = {
 	.clear_context_loss_flags_old = &omap44xx_prm_clear_context_loss_flags_old,
 	.late_init = &omap44xx_prm_late_init,
 	.assert_hardreset	= omap4_prminst_assert_hardreset,
+	.deassert_hardreset	= omap4_prminst_deassert_hardreset,
 };
 
 int __init omap44xx_prm_init(void)
diff --git a/arch/arm/mach-omap2/prm_common.c b/arch/arm/mach-omap2/prm_common.c
index c5c4414..f5fa06e 100644
--- a/arch/arm/mach-omap2/prm_common.c
+++ b/arch/arm/mach-omap2/prm_common.c
@@ -443,6 +443,30 @@ int prm_assert_hardreset(u8 shift, u8 part, s16 prm_mod, u16 offset)
 }
 
 /**
+ * prm_deassert_hardreset - deassert hardreset for an IP block
+ * @shift: register bit shift corresponding to the reset line
+ * @st_shift: reset status bit shift corresponding to the reset line
+ * @part: PRM partition
+ * @prm_mod: PRM submodule base or instance offset
+ * @offset: register offset
+ * @st_offset: status register offset
+ *
+ * Deasserts a hardware reset line for an IP block.
+ */
+int prm_deassert_hardreset(u8 shift, u8 st_shift, u8 part, s16 prm_mod,
+			   u16 offset, u16 st_offset)
+{
+	if (!prm_ll_data->deassert_hardreset) {
+		WARN_ONCE(1, "prm: %s: no mapping function defined\n",
+			  __func__);
+		return -EINVAL;
+	}
+
+	return prm_ll_data->deassert_hardreset(shift, st_shift, part, prm_mod,
+					       offset, st_offset);
+}
+
+/**
  * prm_register - register per-SoC low-level data with the PRM
  * @pld: low-level per-SoC OMAP PRM data & function pointers to register
  *
diff --git a/arch/arm/mach-omap2/prminst44xx.c b/arch/arm/mach-omap2/prminst44xx.c
index 225e025..8adf7b1 100644
--- a/arch/arm/mach-omap2/prminst44xx.c
+++ b/arch/arm/mach-omap2/prminst44xx.c
@@ -148,8 +148,12 @@ int omap4_prminst_assert_hardreset(u8 shift, u8 part, s16 inst,
 /**
  * omap4_prminst_deassert_hardreset - deassert a submodule hardreset line and
  * wait
- * @rstctrl_reg: RM_RSTCTRL register address for this module
  * @shift: register bit shift corresponding to the reset line to deassert
+ * @st_shift: status bit offset, not used for OMAP4+
+ * @part: PRM partition
+ * @inst: PRM instance offset
+ * @rstctrl_offs: reset register offset
+ * @st_offs: reset status register offset, not used for OMAP4+
  *
  * Some IPs like dsp, ipu or iva contain processors that require an HW
  * reset line to be asserted / deasserted in order to fully enable the
@@ -160,8 +164,8 @@ int omap4_prminst_assert_hardreset(u8 shift, u8 part, s16 inst,
  * -EINVAL upon an argument error, -EEXIST if the submodule was already out
  * of reset, or -EBUSY if the submodule did not exit reset promptly.
  */
-int omap4_prminst_deassert_hardreset(u8 shift, u8 part, s16 inst,
-				     u16 rstctrl_offs)
+int omap4_prminst_deassert_hardreset(u8 shift, u8 st_shift, u8 part, s16 inst,
+				     u16 rstctrl_offs, u16 st_offs)
 {
 	int c;
 	u32 mask = 1 << shift;
diff --git a/arch/arm/mach-omap2/prminst44xx.h b/arch/arm/mach-omap2/prminst44xx.h
index 583aa37..fb1c9d7 100644
--- a/arch/arm/mach-omap2/prminst44xx.h
+++ b/arch/arm/mach-omap2/prminst44xx.h
@@ -30,8 +30,9 @@ extern int omap4_prminst_is_hardreset_asserted(u8 shift, u8 part, s16 inst,
 					       u16 rstctrl_offs);
 extern int omap4_prminst_assert_hardreset(u8 shift, u8 part, s16 inst,
 					  u16 rstctrl_offs);
-extern int omap4_prminst_deassert_hardreset(u8 shift, u8 part, s16 inst,
-					    u16 rstctrl_offs);
+int omap4_prminst_deassert_hardreset(u8 shift, u8 st_shift, u8 part,
+				     s16 inst, u16 rstctrl_offs,
+				     u16 rstst_offs);
 
 extern void omap_prm_base_init(void);
 
-- 
1.7.9.5


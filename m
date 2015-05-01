From: Dave Gerlach <d-gerlach@ti.com>
Subject: [PATCH] ARM: OMAP2+: PRM: Fix am437x module reset
Date: Fri, 1 May 2015 14:27:02 -0500
Message-ID: <1430508422-64913-1-git-send-email-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:42255 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750973AbbEAT1i (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 May 2015 15:27:38 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, Tero Kristo <t-kristo@ti.com>, Dave Gerlach <d-gerlach@ti.com>, Suman Anna <s-anna@ti.com>

When moving to using the OMAP4+ PRM driver on am437x, we switched
to using all omap4 ops for module reset management. However, reset
register layout on am437x is more similar to am335x than omap4 because
of the the need for an st_shift for the *_RST bits in certain *_RSTST
registers, like WKUP_PROC_LRST in the PRCM_RM_WKUP_RSTST. Without this
we cannot bring the Wakeup M3 IP out of reset.

Because of this, we must use the am33xx prm ops for the hardreset
functionality while continuing to use all other omap4 ops. To accomplish
this we split out the common portion of omap44xx_prm_init and add an
am437x_prm_init to register the prm_ll_data struct specific to am437x.

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
Signed-off-by: Suman Anna <s-anna@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c   |  6 +++---
 arch/arm/mach-omap2/prm33xx.c      | 14 +++++++-------
 arch/arm/mach-omap2/prm33xx.h      |  7 +++++++
 arch/arm/mach-omap2/prm44xx.c      | 32 +++++++++++++++++++++++++++++++-
 arch/arm/mach-omap2/prm44xx_54xx.h |  1 +
 arch/arm/mach-omap2/prm_common.c   |  2 +-
 6 files changed, 50 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 982380b..4b13882 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -3924,9 +3924,9 @@ void __init omap_hwmod_init(void)
 		soc_ops.enable_module = _omap4_enable_module;
 		soc_ops.disable_module = _omap4_disable_module;
 		soc_ops.wait_target_ready = _omap4_wait_target_ready;
-		soc_ops.assert_hardreset = _omap4_assert_hardreset;
-		soc_ops.deassert_hardreset = _omap4_deassert_hardreset;
-		soc_ops.is_hardreset_asserted = _omap4_is_hardreset_asserted;
+		soc_ops.assert_hardreset = _am33xx_assert_hardreset;
+		soc_ops.deassert_hardreset = _am33xx_deassert_hardreset;
+		soc_ops.is_hardreset_asserted = _am33xx_is_hardreset_asserted;
 		soc_ops.init_clkdm = _init_clkdm;
 	} else if (cpu_is_ti816x() || soc_is_am33xx()) {
 		soc_ops.enable_module = _omap4_enable_module;
diff --git a/arch/arm/mach-omap2/prm33xx.c b/arch/arm/mach-omap2/prm33xx.c
index dcb5001..0a43bfe 100644
--- a/arch/arm/mach-omap2/prm33xx.c
+++ b/arch/arm/mach-omap2/prm33xx.c
@@ -64,8 +64,8 @@ static u32 am33xx_prm_rmw_reg_bits(u32 mask, u32 bits, s16 inst, s16 idx)
  * 0 if the (sub)module hardreset line is not currently asserted, or
  * -EINVAL upon parameter error.
  */
-static int am33xx_prm_is_hardreset_asserted(u8 shift, u8 part, s16 inst,
-					    u16 rstctrl_offs)
+int am33xx_prm_is_hardreset_asserted(u8 shift, u8 part, s16 inst,
+				     u16 rstctrl_offs)
 {
 	u32 v;
 
@@ -90,8 +90,8 @@ static int am33xx_prm_is_hardreset_asserted(u8 shift, u8 part, s16 inst,
  * place the submodule into reset.  Returns 0 upon success or -EINVAL
  * upon an argument error.
  */
-static int am33xx_prm_assert_hardreset(u8 shift, u8 part, s16 inst,
-				       u16 rstctrl_offs)
+int am33xx_prm_assert_hardreset(u8 shift, u8 part, s16 inst,
+				u16 rstctrl_offs)
 {
 	u32 mask = 1 << shift;
 
@@ -119,9 +119,9 @@ static int am33xx_prm_assert_hardreset(u8 shift, u8 part, s16 inst,
  * -EINVAL upon an argument error, -EEXIST if the submodule was already out
  * of reset, or -EBUSY if the submodule did not exit reset promptly.
  */
-static int am33xx_prm_deassert_hardreset(u8 shift, u8 st_shift, u8 part,
-					 s16 inst, u16 rstctrl_offs,
-					 u16 rstst_offs)
+int am33xx_prm_deassert_hardreset(u8 shift, u8 st_shift, u8 part,
+				  s16 inst, u16 rstctrl_offs,
+				  u16 rstst_offs)
 {
 	int c;
 	u32 mask = 1 << st_shift;
diff --git a/arch/arm/mach-omap2/prm33xx.h b/arch/arm/mach-omap2/prm33xx.h
index 2bc4ec5..2754e9f 100644
--- a/arch/arm/mach-omap2/prm33xx.h
+++ b/arch/arm/mach-omap2/prm33xx.h
@@ -120,5 +120,12 @@
 #ifndef __ASSEMBLER__
 int am33xx_prm_init(const struct omap_prcm_init_data *data);
 
+int am33xx_prm_is_hardreset_asserted(u8 shift, u8 part, s16 inst,
+				     u16 rstctrl_offs);
+int am33xx_prm_assert_hardreset(u8 shift, u8 part, s16 inst,
+				u16 rstctrl_offs);
+int am33xx_prm_deassert_hardreset(u8 shift, u8 st_shift, u8 part,
+				  s16 inst, u16 rstctrl_offs,
+				  u16 rstst_offs);
 #endif /* ASSEMBLER */
 #endif
diff --git a/arch/arm/mach-omap2/prm44xx.c b/arch/arm/mach-omap2/prm44xx.c
index 4541700..3fc6971 100644
--- a/arch/arm/mach-omap2/prm44xx.c
+++ b/arch/arm/mach-omap2/prm44xx.c
@@ -24,6 +24,7 @@
 #include "iomap.h"
 #include "common.h"
 #include "vp.h"
+#include "prm33xx.h"
 #include "prm44xx.h"
 #include "prm-regbits-44xx.h"
 #include "prcm44xx.h"
@@ -705,7 +706,7 @@ static struct prm_ll_data omap44xx_prm_ll_data = {
 
 static const struct omap_prcm_init_data *prm_init_data;
 
-int __init omap44xx_prm_init(const struct omap_prcm_init_data *data)
+static void omap44xx_prm_init_common(const struct omap_prcm_init_data *data)
 {
 	omap_prm_base_init();
 
@@ -718,7 +719,11 @@ int __init omap44xx_prm_init(const struct omap_prcm_init_data *data)
 		prm_features |= PRM_HAS_VOLTAGE;
 
 	omap4_prminst_set_prm_dev_inst(data->device_inst_offset);
+}
 
+int __init omap44xx_prm_init(const struct omap_prcm_init_data *data)
+{
+	omap44xx_prm_init_common(data);
 	return prm_register(&omap44xx_prm_ll_data);
 }
 
@@ -762,3 +767,28 @@ static void __exit omap44xx_prm_exit(void)
 	prm_unregister(&omap44xx_prm_ll_data);
 }
 __exitcall(omap44xx_prm_exit);
+
+#ifdef CONFIG_SOC_AM43XX
+static struct prm_ll_data am43xx_prm_ll_data = {
+	.read_reset_sources = &omap44xx_prm_read_reset_sources,
+	.was_any_context_lost_old = &omap44xx_prm_was_any_context_lost_old,
+	.clear_context_loss_flags_old = &omap44xx_prm_clear_context_loss_flags_old,
+	.late_init = &omap44xx_prm_late_init,
+	.assert_hardreset	= am33xx_prm_assert_hardreset,
+	.deassert_hardreset	= am33xx_prm_deassert_hardreset,
+	.is_hardreset_asserted	= am33xx_prm_is_hardreset_asserted,
+	.reset_system		= omap4_prminst_global_warm_sw_reset,
+};
+
+int __init am43xx_prm_init(const struct omap_prcm_init_data *data)
+{
+	omap44xx_prm_init_common(data);
+	return prm_register(&am43xx_prm_ll_data);
+}
+
+static void __exit am43xx_prm_exit(void)
+{
+	prm_unregister(&am43xx_prm_ll_data);
+}
+__exitcall(am43xx_prm_exit);
+#endif /* CONFIG_SOC_AM43XX */
diff --git a/arch/arm/mach-omap2/prm44xx_54xx.h b/arch/arm/mach-omap2/prm44xx_54xx.h
index 3f139eb..3e90d6a 100644
--- a/arch/arm/mach-omap2/prm44xx_54xx.h
+++ b/arch/arm/mach-omap2/prm44xx_54xx.h
@@ -36,6 +36,7 @@ extern u32 omap4_prm_vcvp_read(u8 offset);
 extern void omap4_prm_vcvp_write(u32 val, u8 offset);
 extern u32 omap4_prm_vcvp_rmw(u32 mask, u32 bits, u8 offset);
 
+int __init am43xx_prm_init(const struct omap_prcm_init_data *data);
 int __init omap44xx_prm_init(const struct omap_prcm_init_data *data);
 
 #endif
diff --git a/arch/arm/mach-omap2/prm_common.c b/arch/arm/mach-omap2/prm_common.c
index 7add799..730fd24 100644
--- a/arch/arm/mach-omap2/prm_common.c
+++ b/arch/arm/mach-omap2/prm_common.c
@@ -694,7 +694,7 @@ static struct omap_prcm_init_data dra7_prm_data __initdata = {
 #ifdef CONFIG_SOC_AM43XX
 static struct omap_prcm_init_data am4_prm_data __initdata = {
 	.index = TI_CLKM_PRM,
-	.init = omap44xx_prm_init,
+	.init = am43xx_prm_init,
 	.device_inst_offset = AM43XX_PRM_DEVICE_INST,
 };
 #endif
-- 
2.3.6


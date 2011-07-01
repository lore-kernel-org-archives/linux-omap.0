From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH v3 07/13] OMAP4: prm: Replace warm reset API with the offset based version
Date: Fri, 1 Jul 2011 23:09:12 +0200
Message-ID: <1309554558-19819-8-git-send-email-b-cousson@ti.com>
References: <1309554558-19819-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:59306 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753288Ab1GAVJm (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 1 Jul 2011 17:09:42 -0400
In-Reply-To: <1309554558-19819-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com
Cc: rnayak@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Benoit Cousson <b-cousson@ti.com>

The warm reset function was still using the obsolete API.
Replace it by the new one and move the file to the proper c file.

Change the function names to stick to the file convention as
suggested by Paul Walmsley <paul@pwsan.com>:
prm_xxx -> prminst_xxx

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c  |    6 +++---
 arch/arm/mach-omap2/prcm.c        |    2 +-
 arch/arm/mach-omap2/prm44xx.c     |   15 ---------------
 arch/arm/mach-omap2/prm44xx.h     |    2 --
 arch/arm/mach-omap2/prminst44xx.c |   29 ++++++++++++++++++++++++-----
 arch/arm/mach-omap2/prminst44xx.h |   14 +++++++-------
 6 files changed, 35 insertions(+), 33 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 8d4129c..ebca866 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -1113,7 +1113,7 @@ static int _assert_hardreset(struct omap_hwmod *oh, const char *name)
 		return omap2_prm_assert_hardreset(oh->prcm.omap2.module_offs,
 						  ohri.rst_shift);
 	else if (cpu_is_omap44xx())
-		return omap4_prm_assert_hardreset(ohri.rst_shift,
+		return omap4_prminst_assert_hardreset(ohri.rst_shift,
 				  oh->clkdm->pwrdm.ptr->prcm_partition,
 				  oh->clkdm->pwrdm.ptr->prcm_offs,
 				  oh->prcm.omap4.rstctrl_offs);
@@ -1151,7 +1151,7 @@ static int _deassert_hardreset(struct omap_hwmod *oh, const char *name)
 		if (ohri.st_shift)
 			pr_err("omap_hwmod: %s: %s: hwmod data error: OMAP4 does not support st_shift\n",
 			       oh->name, name);
-		ret = omap4_prm_deassert_hardreset(ohri.rst_shift,
+		ret = omap4_prminst_deassert_hardreset(ohri.rst_shift,
 				  oh->clkdm->pwrdm.ptr->prcm_partition,
 				  oh->clkdm->pwrdm.ptr->prcm_offs,
 				  oh->prcm.omap4.rstctrl_offs);
@@ -1189,7 +1189,7 @@ static int _read_hardreset(struct omap_hwmod *oh, const char *name)
 		return omap2_prm_is_hardreset_asserted(oh->prcm.omap2.module_offs,
 						       ohri.st_shift);
 	} else if (cpu_is_omap44xx()) {
-		return omap4_prm_is_hardreset_asserted(ohri.rst_shift,
+		return omap4_prminst_is_hardreset_asserted(ohri.rst_shift,
 				  oh->clkdm->pwrdm.ptr->prcm_partition,
 				  oh->clkdm->pwrdm.ptr->prcm_offs,
 				  oh->prcm.omap4.rstctrl_offs);
diff --git a/arch/arm/mach-omap2/prcm.c b/arch/arm/mach-omap2/prcm.c
index 6be1438..2e40a5c 100644
--- a/arch/arm/mach-omap2/prcm.c
+++ b/arch/arm/mach-omap2/prcm.c
@@ -70,7 +70,7 @@ static void omap_prcm_arch_reset(char mode, const char *cmd)
 		prcm_offs = OMAP3430_GR_MOD;
 		omap3_ctrl_write_boot_mode((cmd ? (u8)*cmd : 0));
 	} else if (cpu_is_omap44xx()) {
-		omap4_prm_global_warm_sw_reset(); /* never returns */
+		omap4_prminst_global_warm_sw_reset(); /* never returns */
 	} else {
 		WARN_ON(1);
 	}
diff --git a/arch/arm/mach-omap2/prm44xx.c b/arch/arm/mach-omap2/prm44xx.c
index faec860..f815329 100644
--- a/arch/arm/mach-omap2/prm44xx.c
+++ b/arch/arm/mach-omap2/prm44xx.c
@@ -87,18 +87,3 @@ u32 omap4_prm_clear_inst_reg_bits(u32 bits, s16 inst, s16 reg)
 {
 	return omap4_prm_rmw_inst_reg_bits(bits, 0x0, inst, reg);
 }
-
-void omap4_prm_global_warm_sw_reset(void)
-{
-	u32 v;
-
-	v = omap4_prm_read_inst_reg(OMAP4430_PRM_DEVICE_INST,
-				    OMAP4_RM_RSTCTRL);
-	v |= OMAP4430_RST_GLOBAL_WARM_SW_MASK;
-	omap4_prm_write_inst_reg(v, OMAP4430_PRM_DEVICE_INST,
-				 OMAP4_RM_RSTCTRL);
-
-	/* OCP barrier */
-	v = omap4_prm_read_inst_reg(OMAP4430_PRM_DEVICE_INST,
-				    OMAP4_RM_RSTCTRL);
-}
diff --git a/arch/arm/mach-omap2/prm44xx.h b/arch/arm/mach-omap2/prm44xx.h
index 21b0240..a3887b8 100644
--- a/arch/arm/mach-omap2/prm44xx.h
+++ b/arch/arm/mach-omap2/prm44xx.h
@@ -691,8 +691,6 @@ extern u32 omap4_prm_set_inst_reg_bits(u32 bits, s16 inst, s16 idx);
 extern u32 omap4_prm_clear_inst_reg_bits(u32 bits, s16 inst, s16 idx);
 extern u32 omap4_prm_read_bits_shift(void __iomem *reg, u32 mask);
 
-extern void omap4_prm_global_warm_sw_reset(void);
-
 # endif
 
 #endif
diff --git a/arch/arm/mach-omap2/prminst44xx.c b/arch/arm/mach-omap2/prminst44xx.c
index 95fbbcf..2fd5802 100644
--- a/arch/arm/mach-omap2/prminst44xx.c
+++ b/arch/arm/mach-omap2/prminst44xx.c
@@ -82,7 +82,7 @@ u32 omap4_prminst_rmw_inst_reg_bits(u32 mask, u32 bits, u8 part, s16 inst,
  * 0 if the (sub)module hardreset line is not currently asserted, or
  * -EINVAL upon parameter error.
  */
-int omap4_prm_is_hardreset_asserted(u8 shift, u8 part, s16 inst,
+int omap4_prminst_is_hardreset_asserted(u8 shift, u8 part, s16 inst,
 				    u16 rstctrl_offs)
 {
 	u32 v;
@@ -106,7 +106,7 @@ int omap4_prm_is_hardreset_asserted(u8 shift, u8 part, s16 inst,
  * place the submodule into reset.  Returns 0 upon success or -EINVAL
  * upon an argument error.
  */
-int omap4_prm_assert_hardreset(u8 shift, u8 part, s16 inst,
+int omap4_prminst_assert_hardreset(u8 shift, u8 part, s16 inst,
 			       u16 rstctrl_offs)
 {
 	u32 mask = 1 << shift;
@@ -130,7 +130,7 @@ int omap4_prm_assert_hardreset(u8 shift, u8 part, s16 inst,
  * -EINVAL upon an argument error, -EEXIST if the submodule was already out
  * of reset, or -EBUSY if the submodule did not exit reset promptly.
  */
-int omap4_prm_deassert_hardreset(u8 shift, u8 part, s16 inst,
+int omap4_prminst_deassert_hardreset(u8 shift, u8 part, s16 inst,
 				 u16 rstctrl_offs)
 {
 	int c;
@@ -138,7 +138,7 @@ int omap4_prm_deassert_hardreset(u8 shift, u8 part, s16 inst,
 	u16 rstst_offs = rstctrl_offs + OMAP4_RST_CTRL_ST_OFFSET;
 
 	/* Check the current status to avoid de-asserting the line twice */
-	if (omap4_prm_is_hardreset_asserted(shift, part, inst, rstctrl_offs) == 0)
+	if (omap4_prminst_is_hardreset_asserted(shift, part, inst, rstctrl_offs) == 0)
 		return -EEXIST;
 
 	/* Clear the reset status by writing 1 to the status bit */
@@ -146,8 +146,27 @@ int omap4_prm_deassert_hardreset(u8 shift, u8 part, s16 inst,
 	/* de-assert the reset control line */
 	omap4_prminst_rmw_inst_reg_bits(mask, 0, part, inst, rstctrl_offs);
 	/* wait the status to be set */
-	omap_test_timeout(omap4_prm_is_hardreset_asserted(shift, part, inst, rstst_offs),
+	omap_test_timeout(omap4_prminst_is_hardreset_asserted(shift, part, inst, rstst_offs),
 			  MAX_MODULE_HARDRESET_WAIT, c);
 
 	return (c == MAX_MODULE_HARDRESET_WAIT) ? -EBUSY : 0;
 }
+
+
+void omap4_prminst_global_warm_sw_reset(void)
+{
+	u32 v;
+
+	v = omap4_prminst_read_inst_reg(OMAP4430_PRM_PARTITION,
+				    OMAP4430_PRM_DEVICE_INST,
+				    OMAP4_PRM_RSTCTRL_OFFSET);
+	v |= OMAP4430_RST_GLOBAL_WARM_SW_MASK;
+	omap4_prminst_write_inst_reg(v, OMAP4430_PRM_PARTITION,
+				 OMAP4430_PRM_DEVICE_INST,
+				 OMAP4_PRM_RSTCTRL_OFFSET);
+
+	/* OCP barrier */
+	v = omap4_prminst_read_inst_reg(OMAP4430_PRM_PARTITION,
+				    OMAP4430_PRM_DEVICE_INST,
+				    OMAP4_PRM_RSTCTRL_OFFSET);
+}
diff --git a/arch/arm/mach-omap2/prminst44xx.h b/arch/arm/mach-omap2/prminst44xx.h
index 80e930e..46f2efb 100644
--- a/arch/arm/mach-omap2/prminst44xx.h
+++ b/arch/arm/mach-omap2/prminst44xx.h
@@ -21,13 +21,13 @@ extern void omap4_prminst_write_inst_reg(u32 val, u8 part, s16 inst, u16 idx);
 extern u32 omap4_prminst_rmw_inst_reg_bits(u32 mask, u32 bits, u8 part,
 					   s16 inst, u16 idx);
 
-extern void omap4_prm_global_warm_sw_reset(void);
+extern void omap4_prminst_global_warm_sw_reset(void);
 
-extern int omap4_prm_is_hardreset_asserted(u8 shift, u8 part, s16 inst,
-					   u16 rstctrl_offs);
-extern int omap4_prm_assert_hardreset(u8 shift, u8 part, s16 inst,
-				      u16 rstctrl_offs);
-extern int omap4_prm_deassert_hardreset(u8 shift, u8 part, s16 inst,
-					u16 rstctrl_offs);
+extern int omap4_prminst_is_hardreset_asserted(u8 shift, u8 part, s16 inst,
+					       u16 rstctrl_offs);
+extern int omap4_prminst_assert_hardreset(u8 shift, u8 part, s16 inst,
+					  u16 rstctrl_offs);
+extern int omap4_prminst_deassert_hardreset(u8 shift, u8 part, s16 inst,
+					    u16 rstctrl_offs);
 
 #endif
-- 
1.7.0.4


From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 08/11] OMAP2/3: clockdomain: remove unneeded .clkstctrl_reg,
	remove some direct CM register accesses
Date: Tue, 07 Dec 2010 23:18:42 -0700
Message-ID: <20101208061841.30541.22825.stgit@twilight.localdomain>
References: <20101208061657.30541.79824.stgit@twilight.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:37199 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753230Ab0LHGT4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Dec 2010 01:19:56 -0500
In-Reply-To: <20101208061657.30541.79824.stgit@twilight.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Reverse some of the effects of commit
84c0c39aec31a09571fc08a752a2f4da0fe9fcf2 ("ARM: OMAP4: PM: Make OMAP3
Clock-domain framework compatible for OMAP4").  On OMAP2/3, the
CM_CLKSTCTRL register is at a constant offset from the powerdomain's
CM instance.

Also, remove some of the direct CM register access from the
clockdomain code, moving it to the OMAP2/3 CM code instead.  The
intention here is to simplify the clockdomain code.  (The long-term
goal is to move all direct CM register access across the OMAP core
code to the appropriate cm*.c file.)

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/clockdomain.c                |  135 +++++++---------------
 arch/arm/mach-omap2/clockdomains2xxx_3xxx_data.c |   40 -------
 arch/arm/mach-omap2/cm-regbits-24xx.h            |    5 +
 arch/arm/mach-omap2/cm2xxx_3xxx.c                |   68 +++++++++++
 arch/arm/mach-omap2/cm2xxx_3xxx.h                |    9 +
 arch/arm/plat-omap/include/plat/clockdomain.h    |    5 -
 6 files changed, 127 insertions(+), 135 deletions(-)

diff --git a/arch/arm/mach-omap2/clockdomain.c b/arch/arm/mach-omap2/clockdomain.c
index f83a1d4..84cdd1d 100644
--- a/arch/arm/mach-omap2/clockdomain.c
+++ b/arch/arm/mach-omap2/clockdomain.c
@@ -29,7 +29,7 @@
 #include "prm2xxx_3xxx.h"
 #include "prm-regbits-24xx.h"
 #include "cm2xxx_3xxx.h"
-#include "cm-regbits-34xx.h"
+#include "cm-regbits-24xx.h"
 #include "cminst44xx.h"
 #include "prcm44xx.h"
 
@@ -244,30 +244,18 @@ static void _clkdm_del_autodeps(struct clockdomain *clkdm)
  */
 static void _enable_hwsup(struct clockdomain *clkdm)
 {
-	u32 bits, v;
-
 	if (cpu_is_omap24xx())
-		bits = OMAP24XX_CLKSTCTRL_ENABLE_AUTO;
+		omap2xxx_cm_clkdm_enable_hwsup(clkdm->pwrdm.ptr->prcm_offs,
+					       clkdm->clktrctrl_mask);
 	else if (cpu_is_omap34xx())
-		bits = OMAP34XX_CLKSTCTRL_ENABLE_AUTO;
+		omap3xxx_cm_clkdm_enable_hwsup(clkdm->pwrdm.ptr->prcm_offs,
+					       clkdm->clktrctrl_mask);
 	else if (cpu_is_omap44xx())
 		return omap4_cminst_clkdm_enable_hwsup(clkdm->prcm_partition,
 						       clkdm->cm_inst,
 						       clkdm->clkdm_offs);
 	else
 		BUG();
-
-	bits = bits << __ffs(clkdm->clktrctrl_mask);
-
-	/*
-	 * XXX clkstctrl_reg is known on OMAP2 - this clkdm
-	 * field is not needed
-	 */
-	v = __raw_readl(clkdm->clkstctrl_reg);
-	v &= ~(clkdm->clktrctrl_mask);
-	v |= bits;
-	__raw_writel(v, clkdm->clkstctrl_reg);
-
 }
 
 /**
@@ -280,29 +268,18 @@ static void _enable_hwsup(struct clockdomain *clkdm)
  */
 static void _disable_hwsup(struct clockdomain *clkdm)
 {
-	u32 bits, v;
-
 	if (cpu_is_omap24xx())
-		bits = OMAP24XX_CLKSTCTRL_DISABLE_AUTO;
+		omap2xxx_cm_clkdm_disable_hwsup(clkdm->pwrdm.ptr->prcm_offs,
+						clkdm->clktrctrl_mask);
 	else if (cpu_is_omap34xx())
-		bits = OMAP34XX_CLKSTCTRL_DISABLE_AUTO;
+		omap3xxx_cm_clkdm_disable_hwsup(clkdm->pwrdm.ptr->prcm_offs,
+						clkdm->clktrctrl_mask);
 	else if (cpu_is_omap44xx())
 		return omap4_cminst_clkdm_disable_hwsup(clkdm->prcm_partition,
 							clkdm->cm_inst,
 							clkdm->clkdm_offs);
 	else
 		BUG();
-
-	bits = bits << __ffs(clkdm->clktrctrl_mask);
-
-	/*
-	 * XXX clkstctrl_reg is known on OMAP2 - this clkdm
-	 * field is not needed
-	 */
-	v = __raw_readl(clkdm->clkstctrl_reg);
-	v &= ~(clkdm->clktrctrl_mask);
-	v |= bits;
-	__raw_writel(v, clkdm->clkstctrl_reg);
 }
 
 /* Public functions */
@@ -731,34 +708,6 @@ int clkdm_clear_all_sleepdeps(struct clockdomain *clkdm)
 }
 
 /**
- * omap2_clkdm_clktrctrl_read - read the clkdm's current state transition mode
- * @clkdm: struct clkdm * of a clockdomain
- *
- * Return the clockdomain @clkdm current state transition mode from the
- * corresponding domain CM_CLKSTCTRL register.	Returns -EINVAL if @clkdm
- * is NULL or the current mode upon success.
- */
-static int omap2_clkdm_clktrctrl_read(struct clockdomain *clkdm)
-{
-	u32 v = 0;
-
-	if (!clkdm)
-		return -EINVAL;
-
-	if (cpu_is_omap24xx() || cpu_is_omap34xx()) {
-		v = __raw_readl(clkdm->clkstctrl_reg);
-		v &= clkdm->clktrctrl_mask;
-		v >>= __ffs(clkdm->clktrctrl_mask);
-	} else if (cpu_is_omap44xx()) {
-		pr_warn("OMAP4 clockdomain: missing wakeup/sleep deps\n");
-	} else {
-		BUG();
-	}
-
-	return v;
-}
-
-/**
  * omap2_clkdm_sleep - force clockdomain sleep transition
  * @clkdm: struct clockdomain *
  *
@@ -769,8 +718,6 @@ static int omap2_clkdm_clktrctrl_read(struct clockdomain *clkdm)
  */
 int omap2_clkdm_sleep(struct clockdomain *clkdm)
 {
-	u32 bits, v;
-
 	if (!clkdm)
 		return -EINVAL;
 
@@ -789,13 +736,8 @@ int omap2_clkdm_sleep(struct clockdomain *clkdm)
 
 	} else if (cpu_is_omap34xx()) {
 
-		bits = (OMAP34XX_CLKSTCTRL_FORCE_SLEEP <<
-			__ffs(clkdm->clktrctrl_mask));
-
-		v = __raw_readl(clkdm->clkstctrl_reg);
-		v &= ~(clkdm->clktrctrl_mask);
-		v |= bits;
-		__raw_writel(v, clkdm->clkstctrl_reg);
+		omap3xxx_cm_clkdm_force_sleep(clkdm->pwrdm.ptr->prcm_offs,
+					      clkdm->clktrctrl_mask);
 
 	} else if (cpu_is_omap44xx()) {
 
@@ -821,8 +763,6 @@ int omap2_clkdm_sleep(struct clockdomain *clkdm)
  */
 int omap2_clkdm_wakeup(struct clockdomain *clkdm)
 {
-	u32 bits, v;
-
 	if (!clkdm)
 		return -EINVAL;
 
@@ -841,13 +781,8 @@ int omap2_clkdm_wakeup(struct clockdomain *clkdm)
 
 	} else if (cpu_is_omap34xx()) {
 
-		bits = (OMAP34XX_CLKSTCTRL_FORCE_WAKEUP <<
-			__ffs(clkdm->clktrctrl_mask));
-
-		v = __raw_readl(clkdm->clkstctrl_reg);
-		v &= ~(clkdm->clktrctrl_mask);
-		v |= bits;
-		__raw_writel(v, clkdm->clkstctrl_reg);
+		omap3xxx_cm_clkdm_force_wakeup(clkdm->pwrdm.ptr->prcm_offs,
+					       clkdm->clktrctrl_mask);
 
 	} else if (cpu_is_omap44xx()) {
 
@@ -960,7 +895,7 @@ void omap2_clkdm_deny_idle(struct clockdomain *clkdm)
  */
 int omap2_clkdm_clk_enable(struct clockdomain *clkdm, struct clk *clk)
 {
-	int v;
+	bool hwsup = false;
 
 	/*
 	 * XXX Rewrite this code to maintain a list of enabled
@@ -978,13 +913,23 @@ int omap2_clkdm_clk_enable(struct clockdomain *clkdm, struct clk *clk)
 	pr_debug("clockdomain: clkdm %s: clk %s now enabled\n", clkdm->name,
 		 clk->name);
 
-	if (!clkdm->clkstctrl_reg)
-		return 0;
+	if (cpu_is_omap24xx() || cpu_is_omap34xx()) {
 
-	v = omap2_clkdm_clktrctrl_read(clkdm);
+		if (!clkdm->clktrctrl_mask)
+			return 0;
+
+		hwsup = omap2_cm_is_clkdm_in_hwsup(clkdm->pwrdm.ptr->prcm_offs,
+						   clkdm->clktrctrl_mask);
+
+	} else if (cpu_is_omap44xx()) {
+
+		hwsup = omap4_cminst_is_clkdm_in_hwsup(clkdm->prcm_partition,
+						       clkdm->cm_inst,
+						       clkdm->clkdm_offs);
 
-	if ((cpu_is_omap34xx() && v == OMAP34XX_CLKSTCTRL_ENABLE_AUTO) ||
-	    (cpu_is_omap24xx() && v == OMAP24XX_CLKSTCTRL_ENABLE_AUTO)) {
+	}
+
+	if (hwsup) {
 		/* Disable HW transitions when we are changing deps */
 		_disable_hwsup(clkdm);
 		_clkdm_add_autodeps(clkdm);
@@ -1015,7 +960,7 @@ int omap2_clkdm_clk_enable(struct clockdomain *clkdm, struct clk *clk)
  */
 int omap2_clkdm_clk_disable(struct clockdomain *clkdm, struct clk *clk)
 {
-	int v;
+	bool hwsup = false;
 
 	/*
 	 * XXX Rewrite this code to maintain a list of enabled
@@ -1040,13 +985,23 @@ int omap2_clkdm_clk_disable(struct clockdomain *clkdm, struct clk *clk)
 	pr_debug("clockdomain: clkdm %s: clk %s now disabled\n", clkdm->name,
 		 clk->name);
 
-	if (!clkdm->clkstctrl_reg)
-		return 0;
+	if (cpu_is_omap24xx() || cpu_is_omap34xx()) {
+
+		if (!clkdm->clktrctrl_mask)
+			return 0;
+
+		hwsup = omap2_cm_is_clkdm_in_hwsup(clkdm->pwrdm.ptr->prcm_offs,
+						   clkdm->clktrctrl_mask);
 
-	v = omap2_clkdm_clktrctrl_read(clkdm);
+	} else if (cpu_is_omap44xx()) {
+
+		hwsup = omap4_cminst_is_clkdm_in_hwsup(clkdm->prcm_partition,
+						       clkdm->cm_inst,
+						       clkdm->clkdm_offs);
+
+	}
 
-	if ((cpu_is_omap34xx() && v == OMAP34XX_CLKSTCTRL_ENABLE_AUTO) ||
-	    (cpu_is_omap24xx() && v == OMAP24XX_CLKSTCTRL_ENABLE_AUTO)) {
+	if (hwsup) {
 		/* Disable HW transitions when we are changing deps */
 		_disable_hwsup(clkdm);
 		_clkdm_del_autodeps(clkdm);
diff --git a/arch/arm/mach-omap2/clockdomains2xxx_3xxx_data.c b/arch/arm/mach-omap2/clockdomains2xxx_3xxx_data.c
index de1d3b7..6e9ec49 100644
--- a/arch/arm/mach-omap2/clockdomains2xxx_3xxx_data.c
+++ b/arch/arm/mach-omap2/clockdomains2xxx_3xxx_data.c
@@ -456,7 +456,6 @@ static struct clockdomain mpu_2420_clkdm = {
 	.name		= "mpu_clkdm",
 	.pwrdm		= { .name = "mpu_pwrdm" },
 	.flags		= CLKDM_CAN_HWSUP,
-	.clkstctrl_reg  = OMAP2420_CM_REGADDR(MPU_MOD, OMAP2_CM_CLKSTCTRL),
 	.wkdep_srcs	= mpu_24xx_wkdeps,
 	.clktrctrl_mask = OMAP24XX_AUTOSTATE_MPU_MASK,
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2420),
@@ -466,8 +465,6 @@ static struct clockdomain iva1_2420_clkdm = {
 	.name		= "iva1_clkdm",
 	.pwrdm		= { .name = "dsp_pwrdm" },
 	.flags		= CLKDM_CAN_HWSUP_SWSUP,
-	.clkstctrl_reg  = OMAP2420_CM_REGADDR(OMAP24XX_DSP_MOD,
-						 OMAP2_CM_CLKSTCTRL),
 	.dep_bit	= OMAP24XX_PM_WKDEP_MPU_EN_DSP_SHIFT,
 	.wkdep_srcs	= dsp_24xx_wkdeps,
 	.clktrctrl_mask = OMAP2420_AUTOSTATE_IVA_MASK,
@@ -478,8 +475,6 @@ static struct clockdomain dsp_2420_clkdm = {
 	.name		= "dsp_clkdm",
 	.pwrdm		= { .name = "dsp_pwrdm" },
 	.flags		= CLKDM_CAN_HWSUP_SWSUP,
-	.clkstctrl_reg  = OMAP2420_CM_REGADDR(OMAP24XX_DSP_MOD,
-						 OMAP2_CM_CLKSTCTRL),
 	.clktrctrl_mask = OMAP24XX_AUTOSTATE_DSP_MASK,
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2420),
 };
@@ -488,7 +483,6 @@ static struct clockdomain gfx_2420_clkdm = {
 	.name		= "gfx_clkdm",
 	.pwrdm		= { .name = "gfx_pwrdm" },
 	.flags		= CLKDM_CAN_HWSUP_SWSUP,
-	.clkstctrl_reg  = OMAP2420_CM_REGADDR(GFX_MOD, OMAP2_CM_CLKSTCTRL),
 	.wkdep_srcs	= gfx_sgx_wkdeps,
 	.clktrctrl_mask = OMAP24XX_AUTOSTATE_GFX_MASK,
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2420),
@@ -498,7 +492,6 @@ static struct clockdomain core_l3_2420_clkdm = {
 	.name		= "core_l3_clkdm",
 	.pwrdm		= { .name = "core_pwrdm" },
 	.flags		= CLKDM_CAN_HWSUP,
-	.clkstctrl_reg  = OMAP2420_CM_REGADDR(CORE_MOD, OMAP2_CM_CLKSTCTRL),
 	.wkdep_srcs	= core_24xx_wkdeps,
 	.clktrctrl_mask = OMAP24XX_AUTOSTATE_L3_MASK,
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2420),
@@ -508,7 +501,6 @@ static struct clockdomain core_l4_2420_clkdm = {
 	.name		= "core_l4_clkdm",
 	.pwrdm		= { .name = "core_pwrdm" },
 	.flags		= CLKDM_CAN_HWSUP,
-	.clkstctrl_reg  = OMAP2420_CM_REGADDR(CORE_MOD, OMAP2_CM_CLKSTCTRL),
 	.wkdep_srcs	= core_24xx_wkdeps,
 	.clktrctrl_mask = OMAP24XX_AUTOSTATE_L4_MASK,
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2420),
@@ -518,7 +510,6 @@ static struct clockdomain dss_2420_clkdm = {
 	.name		= "dss_clkdm",
 	.pwrdm		= { .name = "core_pwrdm" },
 	.flags		= CLKDM_CAN_HWSUP,
-	.clkstctrl_reg  = OMAP2420_CM_REGADDR(CORE_MOD, OMAP2_CM_CLKSTCTRL),
 	.clktrctrl_mask = OMAP24XX_AUTOSTATE_DSS_MASK,
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2420),
 };
@@ -536,8 +527,6 @@ static struct clockdomain mpu_2430_clkdm = {
 	.name		= "mpu_clkdm",
 	.pwrdm		= { .name = "mpu_pwrdm" },
 	.flags		= CLKDM_CAN_HWSUP_SWSUP,
-	.clkstctrl_reg  = OMAP2430_CM_REGADDR(MPU_MOD,
-						 OMAP2_CM_CLKSTCTRL),
 	.wkdep_srcs	= mpu_24xx_wkdeps,
 	.clktrctrl_mask = OMAP24XX_AUTOSTATE_MPU_MASK,
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2430),
@@ -548,8 +537,6 @@ static struct clockdomain mdm_clkdm = {
 	.name		= "mdm_clkdm",
 	.pwrdm		= { .name = "mdm_pwrdm" },
 	.flags		= CLKDM_CAN_HWSUP_SWSUP,
-	.clkstctrl_reg  = OMAP2430_CM_REGADDR(OMAP2430_MDM_MOD,
-						 OMAP2_CM_CLKSTCTRL),
 	.dep_bit	= OMAP2430_PM_WKDEP_MPU_EN_MDM_SHIFT,
 	.wkdep_srcs	= mdm_2430_wkdeps,
 	.clktrctrl_mask = OMAP2430_AUTOSTATE_MDM_MASK,
@@ -560,8 +547,6 @@ static struct clockdomain dsp_2430_clkdm = {
 	.name		= "dsp_clkdm",
 	.pwrdm		= { .name = "dsp_pwrdm" },
 	.flags		= CLKDM_CAN_HWSUP_SWSUP,
-	.clkstctrl_reg  = OMAP2430_CM_REGADDR(OMAP24XX_DSP_MOD,
-						 OMAP2_CM_CLKSTCTRL),
 	.dep_bit	= OMAP24XX_PM_WKDEP_MPU_EN_DSP_SHIFT,
 	.wkdep_srcs	= dsp_24xx_wkdeps,
 	.clktrctrl_mask = OMAP24XX_AUTOSTATE_DSP_MASK,
@@ -572,7 +557,6 @@ static struct clockdomain gfx_2430_clkdm = {
 	.name		= "gfx_clkdm",
 	.pwrdm		= { .name = "gfx_pwrdm" },
 	.flags		= CLKDM_CAN_HWSUP_SWSUP,
-	.clkstctrl_reg  = OMAP2430_CM_REGADDR(GFX_MOD, OMAP2_CM_CLKSTCTRL),
 	.wkdep_srcs	= gfx_sgx_wkdeps,
 	.clktrctrl_mask = OMAP24XX_AUTOSTATE_GFX_MASK,
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2430),
@@ -587,7 +571,6 @@ static struct clockdomain core_l3_2430_clkdm = {
 	.name		= "core_l3_clkdm",
 	.pwrdm		= { .name = "core_pwrdm" },
 	.flags		= CLKDM_CAN_HWSUP,
-	.clkstctrl_reg  = OMAP2430_CM_REGADDR(CORE_MOD, OMAP2_CM_CLKSTCTRL),
 	.dep_bit	= OMAP24XX_EN_CORE_SHIFT,
 	.wkdep_srcs	= core_24xx_wkdeps,
 	.clktrctrl_mask = OMAP24XX_AUTOSTATE_L3_MASK,
@@ -603,7 +586,6 @@ static struct clockdomain core_l4_2430_clkdm = {
 	.name		= "core_l4_clkdm",
 	.pwrdm		= { .name = "core_pwrdm" },
 	.flags		= CLKDM_CAN_HWSUP,
-	.clkstctrl_reg  = OMAP2430_CM_REGADDR(CORE_MOD, OMAP2_CM_CLKSTCTRL),
 	.dep_bit	= OMAP24XX_EN_CORE_SHIFT,
 	.wkdep_srcs	= core_24xx_wkdeps,
 	.clktrctrl_mask = OMAP24XX_AUTOSTATE_L4_MASK,
@@ -614,7 +596,6 @@ static struct clockdomain dss_2430_clkdm = {
 	.name		= "dss_clkdm",
 	.pwrdm		= { .name = "core_pwrdm" },
 	.flags		= CLKDM_CAN_HWSUP,
-	.clkstctrl_reg  = OMAP2430_CM_REGADDR(CORE_MOD, OMAP2_CM_CLKSTCTRL),
 	.clktrctrl_mask = OMAP24XX_AUTOSTATE_DSS_MASK,
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2430),
 };
@@ -632,7 +613,6 @@ static struct clockdomain mpu_3xxx_clkdm = {
 	.name		= "mpu_clkdm",
 	.pwrdm		= { .name = "mpu_pwrdm" },
 	.flags		= CLKDM_CAN_HWSUP | CLKDM_CAN_FORCE_WAKEUP,
-	.clkstctrl_reg	= OMAP34XX_CM_REGADDR(MPU_MOD, OMAP2_CM_CLKSTCTRL),
 	.dep_bit	= OMAP3430_EN_MPU_SHIFT,
 	.wkdep_srcs	= mpu_3xxx_wkdeps,
 	.clktrctrl_mask = OMAP3430_CLKTRCTRL_MPU_MASK,
@@ -643,8 +623,6 @@ static struct clockdomain neon_clkdm = {
 	.name		= "neon_clkdm",
 	.pwrdm		= { .name = "neon_pwrdm" },
 	.flags		= CLKDM_CAN_HWSUP_SWSUP,
-	.clkstctrl_reg	= OMAP34XX_CM_REGADDR(OMAP3430_NEON_MOD,
-						 OMAP2_CM_CLKSTCTRL),
 	.wkdep_srcs	= neon_wkdeps,
 	.clktrctrl_mask = OMAP3430_CLKTRCTRL_NEON_MASK,
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
@@ -654,8 +632,6 @@ static struct clockdomain iva2_clkdm = {
 	.name		= "iva2_clkdm",
 	.pwrdm		= { .name = "iva2_pwrdm" },
 	.flags		= CLKDM_CAN_HWSUP_SWSUP,
-	.clkstctrl_reg	= OMAP34XX_CM_REGADDR(OMAP3430_IVA2_MOD,
-						 OMAP2_CM_CLKSTCTRL),
 	.dep_bit	= OMAP3430_PM_WKDEP_MPU_EN_IVA2_SHIFT,
 	.wkdep_srcs	= iva2_wkdeps,
 	.clktrctrl_mask = OMAP3430_CLKTRCTRL_IVA2_MASK,
@@ -666,7 +642,6 @@ static struct clockdomain gfx_3430es1_clkdm = {
 	.name		= "gfx_clkdm",
 	.pwrdm		= { .name = "gfx_pwrdm" },
 	.flags		= CLKDM_CAN_HWSUP_SWSUP,
-	.clkstctrl_reg	= OMAP34XX_CM_REGADDR(GFX_MOD, OMAP2_CM_CLKSTCTRL),
 	.wkdep_srcs	= gfx_sgx_wkdeps,
 	.sleepdep_srcs	= gfx_sgx_sleepdeps,
 	.clktrctrl_mask = OMAP3430ES1_CLKTRCTRL_GFX_MASK,
@@ -677,8 +652,6 @@ static struct clockdomain sgx_clkdm = {
 	.name		= "sgx_clkdm",
 	.pwrdm		= { .name = "sgx_pwrdm" },
 	.flags		= CLKDM_CAN_HWSUP_SWSUP,
-	.clkstctrl_reg	= OMAP34XX_CM_REGADDR(OMAP3430ES2_SGX_MOD,
-						 OMAP2_CM_CLKSTCTRL),
 	.wkdep_srcs	= gfx_sgx_wkdeps,
 	.sleepdep_srcs	= gfx_sgx_sleepdeps,
 	.clktrctrl_mask = OMAP3430ES2_CLKTRCTRL_SGX_MASK,
@@ -696,7 +669,6 @@ static struct clockdomain d2d_clkdm = {
 	.name		= "d2d_clkdm",
 	.pwrdm		= { .name = "core_pwrdm" },
 	.flags		= CLKDM_CAN_HWSUP_SWSUP,
-	.clkstctrl_reg	= OMAP34XX_CM_REGADDR(CORE_MOD, OMAP2_CM_CLKSTCTRL),
 	.clktrctrl_mask = OMAP3430ES1_CLKTRCTRL_D2D_MASK,
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
 };
@@ -710,7 +682,6 @@ static struct clockdomain core_l3_3xxx_clkdm = {
 	.name		= "core_l3_clkdm",
 	.pwrdm		= { .name = "core_pwrdm" },
 	.flags		= CLKDM_CAN_HWSUP,
-	.clkstctrl_reg	= OMAP34XX_CM_REGADDR(CORE_MOD, OMAP2_CM_CLKSTCTRL),
 	.dep_bit	= OMAP3430_EN_CORE_SHIFT,
 	.clktrctrl_mask = OMAP3430_CLKTRCTRL_L3_MASK,
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
@@ -725,7 +696,6 @@ static struct clockdomain core_l4_3xxx_clkdm = {
 	.name		= "core_l4_clkdm",
 	.pwrdm		= { .name = "core_pwrdm" },
 	.flags		= CLKDM_CAN_HWSUP,
-	.clkstctrl_reg	= OMAP34XX_CM_REGADDR(CORE_MOD, OMAP2_CM_CLKSTCTRL),
 	.dep_bit	= OMAP3430_EN_CORE_SHIFT,
 	.clktrctrl_mask = OMAP3430_CLKTRCTRL_L4_MASK,
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
@@ -736,8 +706,6 @@ static struct clockdomain dss_3xxx_clkdm = {
 	.name		= "dss_clkdm",
 	.pwrdm		= { .name = "dss_pwrdm" },
 	.flags		= CLKDM_CAN_HWSUP_SWSUP,
-	.clkstctrl_reg	= OMAP34XX_CM_REGADDR(OMAP3430_DSS_MOD,
-						 OMAP2_CM_CLKSTCTRL),
 	.dep_bit	= OMAP3430_PM_WKDEP_MPU_EN_DSS_SHIFT,
 	.wkdep_srcs	= dss_wkdeps,
 	.sleepdep_srcs	= dss_sleepdeps,
@@ -749,8 +717,6 @@ static struct clockdomain cam_clkdm = {
 	.name		= "cam_clkdm",
 	.pwrdm		= { .name = "cam_pwrdm" },
 	.flags		= CLKDM_CAN_HWSUP_SWSUP,
-	.clkstctrl_reg	= OMAP34XX_CM_REGADDR(OMAP3430_CAM_MOD,
-						 OMAP2_CM_CLKSTCTRL),
 	.wkdep_srcs	= cam_wkdeps,
 	.sleepdep_srcs	= cam_sleepdeps,
 	.clktrctrl_mask = OMAP3430_CLKTRCTRL_CAM_MASK,
@@ -761,8 +727,6 @@ static struct clockdomain usbhost_clkdm = {
 	.name		= "usbhost_clkdm",
 	.pwrdm		= { .name = "usbhost_pwrdm" },
 	.flags		= CLKDM_CAN_HWSUP_SWSUP,
-	.clkstctrl_reg	= OMAP34XX_CM_REGADDR(OMAP3430ES2_USBHOST_MOD,
-						 OMAP2_CM_CLKSTCTRL),
 	.wkdep_srcs	= usbhost_wkdeps,
 	.sleepdep_srcs	= usbhost_sleepdeps,
 	.clktrctrl_mask = OMAP3430ES2_CLKTRCTRL_USBHOST_MASK,
@@ -773,8 +737,6 @@ static struct clockdomain per_clkdm = {
 	.name		= "per_clkdm",
 	.pwrdm		= { .name = "per_pwrdm" },
 	.flags		= CLKDM_CAN_HWSUP_SWSUP,
-	.clkstctrl_reg	= OMAP34XX_CM_REGADDR(OMAP3430_PER_MOD,
-						 OMAP2_CM_CLKSTCTRL),
 	.dep_bit	= OMAP3430_EN_PER_SHIFT,
 	.wkdep_srcs	= per_wkdeps,
 	.sleepdep_srcs	= per_sleepdeps,
@@ -790,8 +752,6 @@ static struct clockdomain emu_clkdm = {
 	.name		= "emu_clkdm",
 	.pwrdm		= { .name = "emu_pwrdm" },
 	.flags		= /* CLKDM_CAN_ENABLE_AUTO |  */CLKDM_CAN_SWSUP,
-	.clkstctrl_reg	= OMAP34XX_CM_REGADDR(OMAP3430_EMU_MOD,
-						 OMAP2_CM_CLKSTCTRL),
 	.clktrctrl_mask = OMAP3430_CLKTRCTRL_EMU_MASK,
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
 };
diff --git a/arch/arm/mach-omap2/cm-regbits-24xx.h b/arch/arm/mach-omap2/cm-regbits-24xx.h
index bab62ee..82286bc 100644
--- a/arch/arm/mach-omap2/cm-regbits-24xx.h
+++ b/arch/arm/mach-omap2/cm-regbits-24xx.h
@@ -430,4 +430,9 @@
 #define OMAP2430_AUTOSTATE_MDM_SHIFT			0
 #define OMAP2430_AUTOSTATE_MDM_MASK			(1 << 0)
 
+/* OMAP24XX CM_CLKSTCTRL_*.AUTOSTATE_* register bit values */
+#define OMAP24XX_CLKSTCTRL_DISABLE_AUTO		0x0
+#define OMAP24XX_CLKSTCTRL_ENABLE_AUTO		0x1
+
+
 #endif
diff --git a/arch/arm/mach-omap2/cm2xxx_3xxx.c b/arch/arm/mach-omap2/cm2xxx_3xxx.c
index e3d598a..96954aa 100644
--- a/arch/arm/mach-omap2/cm2xxx_3xxx.c
+++ b/arch/arm/mach-omap2/cm2xxx_3xxx.c
@@ -62,6 +62,74 @@ u32 omap2_cm_clear_mod_reg_bits(u32 bits, s16 module, s16 idx)
 	return omap2_cm_rmw_mod_reg_bits(bits, 0x0, module, idx);
 }
 
+/*
+ *
+ */
+
+static void _write_clktrctrl(u8 c, s16 module, u32 mask)
+{
+	u32 v;
+
+	v = omap2_cm_read_mod_reg(module, OMAP2_CM_CLKSTCTRL);
+	v &= ~mask;
+	v |= c << __ffs(mask);
+	omap2_cm_write_mod_reg(v, module, OMAP2_CM_CLKSTCTRL);
+}
+
+bool omap2_cm_is_clkdm_in_hwsup(s16 module, u32 mask)
+{
+	u32 v;
+	bool ret = 0;
+
+	BUG_ON(!cpu_is_omap24xx() && !cpu_is_omap34xx());
+
+	v = omap2_cm_read_mod_reg(module, OMAP2_CM_CLKSTCTRL);
+	v &= mask;
+	v >>= __ffs(mask);
+
+	if (cpu_is_omap24xx())
+		ret = (v == OMAP24XX_CLKSTCTRL_ENABLE_AUTO) ? 1 : 0;
+	else
+		ret = (v == OMAP34XX_CLKSTCTRL_ENABLE_AUTO) ? 1 : 0;
+
+	return ret;
+}
+
+void omap2xxx_cm_clkdm_enable_hwsup(s16 module, u32 mask)
+{
+	_write_clktrctrl(OMAP24XX_CLKSTCTRL_ENABLE_AUTO, module, mask);
+}
+
+void omap2xxx_cm_clkdm_disable_hwsup(s16 module, u32 mask)
+{
+	_write_clktrctrl(OMAP24XX_CLKSTCTRL_DISABLE_AUTO, module, mask);
+}
+
+void omap3xxx_cm_clkdm_enable_hwsup(s16 module, u32 mask)
+{
+	_write_clktrctrl(OMAP34XX_CLKSTCTRL_ENABLE_AUTO, module, mask);
+}
+
+void omap3xxx_cm_clkdm_disable_hwsup(s16 module, u32 mask)
+{
+	_write_clktrctrl(OMAP34XX_CLKSTCTRL_DISABLE_AUTO, module, mask);
+}
+
+void omap3xxx_cm_clkdm_force_sleep(s16 module, u32 mask)
+{
+	_write_clktrctrl(OMAP34XX_CLKSTCTRL_FORCE_SLEEP, module, mask);
+}
+
+void omap3xxx_cm_clkdm_force_wakeup(s16 module, u32 mask)
+{
+	_write_clktrctrl(OMAP34XX_CLKSTCTRL_FORCE_WAKEUP, module, mask);
+}
+
+
+/*
+ *
+ */
+
 /**
  * omap2_cm_wait_idlest_ready - wait for a module to leave idle or standby
  * @prcm_mod: PRCM module offset
diff --git a/arch/arm/mach-omap2/cm2xxx_3xxx.h b/arch/arm/mach-omap2/cm2xxx_3xxx.h
index ff24edf..5e9ea5b 100644
--- a/arch/arm/mach-omap2/cm2xxx_3xxx.h
+++ b/arch/arm/mach-omap2/cm2xxx_3xxx.h
@@ -113,6 +113,15 @@ extern int omap2_cm_wait_module_ready(s16 prcm_mod, u8 idlest_id,
 extern u32 omap2_cm_set_mod_reg_bits(u32 bits, s16 module, s16 idx);
 extern u32 omap2_cm_clear_mod_reg_bits(u32 bits, s16 module, s16 idx);
 
+extern bool omap2_cm_is_clkdm_in_hwsup(s16 module, u32 mask);
+extern void omap2xxx_cm_clkdm_enable_hwsup(s16 module, u32 mask);
+extern void omap2xxx_cm_clkdm_disable_hwsup(s16 module, u32 mask);
+
+extern void omap3xxx_cm_clkdm_enable_hwsup(s16 module, u32 mask);
+extern void omap3xxx_cm_clkdm_disable_hwsup(s16 module, u32 mask);
+extern void omap3xxx_cm_clkdm_force_sleep(s16 module, u32 mask);
+extern void omap3xxx_cm_clkdm_force_wakeup(s16 module, u32 mask);
+
 #endif
 
 /* CM register bits shared between 24XX and 3430 */
diff --git a/arch/arm/plat-omap/include/plat/clockdomain.h b/arch/arm/plat-omap/include/plat/clockdomain.h
index ec433c3..e91ae92 100644
--- a/arch/arm/plat-omap/include/plat/clockdomain.h
+++ b/arch/arm/plat-omap/include/plat/clockdomain.h
@@ -34,10 +34,6 @@
 #define CLKDM_CAN_SWSUP		(CLKDM_CAN_FORCE_SLEEP | CLKDM_CAN_FORCE_WAKEUP)
 #define CLKDM_CAN_HWSUP_SWSUP	(CLKDM_CAN_SWSUP | CLKDM_CAN_HWSUP)
 
-/* OMAP24XX CM_CLKSTCTRL_*.AUTOSTATE_* register bit values */
-#define OMAP24XX_CLKSTCTRL_DISABLE_AUTO		0x0
-#define OMAP24XX_CLKSTCTRL_ENABLE_AUTO		0x1
-
 /**
  * struct clkdm_autodep - clkdm deps to add when entering/exiting hwsup mode
  * @clkdm: clockdomain to add wkdep+sleepdep on - set name member only
@@ -110,7 +106,6 @@ struct clockdomain {
 		struct powerdomain *ptr;
 	} pwrdm;
 #if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
-	void __iomem *clkstctrl_reg;
 	const u16 clktrctrl_mask;
 #endif
 	const u8 flags;



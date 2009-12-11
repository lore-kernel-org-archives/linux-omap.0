From: Abhijit Pagare <abhijitpagare@ti.com>
Subject: [PATCH 1/5] ARM: OMAP4: PM: Make OMAP3 Clock-domain framework compatible for OMAP4.
Date: Fri, 11 Dec 2009 16:40:24 +0530
Message-ID: <1260529828-14862-1-git-send-email-abhijitpagare@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:60554 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762314AbZLKLKk (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 11 Dec 2009 06:10:40 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Abhijit Pagare <abhijitpagare@ti.com>, Paul Walmsley <paul@pwsan.com>, Benoit Cousson <b-cousson@ti.com>, Rajendra Nayak <rnayak@ti.com>

Here the ".clkstctrl_reg" field is added to the clockdomain stucture
as the module offsets for OMAP4 do not map one to one for powerdomains
and clockdomains as it used to for OMAP3. Hence we need to use absolute
addresses to access the control registers. Some of the clock domains have
modules falling in the address space of PRM partition. Hence  necessitating
the use of absolute adresses.

Signed-off-by: Abhijit Pagare <abhijitpagare@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/clockdomain.c             |   12 ++-
 arch/arm/mach-omap2/clockdomains.h            |  133 +++++++++++++++++++------
 arch/arm/mach-omap2/cm.h                      |    5 +-
 arch/arm/mach-omap2/pm-debug.c                |    4 +-
 arch/arm/plat-omap/include/plat/clockdomain.h |    3 +
 5 files changed, 119 insertions(+), 38 deletions(-)

diff --git a/arch/arm/mach-omap2/clockdomain.c b/arch/arm/mach-omap2/clockdomain.c
index e7a35eb..5c695b4 100644
--- a/arch/arm/mach-omap2/clockdomain.c
+++ b/arch/arm/mach-omap2/clockdomain.c
@@ -165,7 +165,7 @@ static void _omap2_clkdm_set_hwsup(struct clockdomain *clkdm, int enable)
 
 	cm_rmw_mod_reg_bits(clkdm->clktrctrl_mask,
 			    v << __ffs(clkdm->clktrctrl_mask),
-			    clkdm->pwrdm.ptr->prcm_offs, CM_CLKSTCTRL);
+			    clkdm->pwrdm.ptr->prcm_offs, OMAP2_CM_CLKSTCTRL);
 }
 
 static struct clockdomain *_clkdm_lookup(const char *name)
@@ -373,7 +373,7 @@ struct powerdomain *clkdm_get_pwrdm(struct clockdomain *clkdm)
  * @clk: struct clk * of a clockdomain
  *
  * Return the clockdomain's current state transition mode from the
- * corresponding domain CM_CLKSTCTRL register.	Returns -EINVAL if clk
+ * corresponding domain OMAP2_CM_CLKSTCTRL register.	Returns -EINVAL if clk
  * is NULL or the current mode upon success.
  */
 static int omap2_clkdm_clktrctrl_read(struct clockdomain *clkdm)
@@ -383,7 +383,7 @@ static int omap2_clkdm_clktrctrl_read(struct clockdomain *clkdm)
 	if (!clkdm)
 		return -EINVAL;
 
-	v = cm_read_mod_reg(clkdm->pwrdm.ptr->prcm_offs, CM_CLKSTCTRL);
+	v = cm_read_mod_reg(clkdm->pwrdm.ptr->prcm_offs, OMAP2_CM_CLKSTCTRL);
 	v &= clkdm->clktrctrl_mask;
 	v >>= __ffs(clkdm->clktrctrl_mask);
 
@@ -423,7 +423,8 @@ int omap2_clkdm_sleep(struct clockdomain *clkdm)
 			 __ffs(clkdm->clktrctrl_mask));
 
 		cm_rmw_mod_reg_bits(clkdm->clktrctrl_mask, v,
-				    clkdm->pwrdm.ptr->prcm_offs, CM_CLKSTCTRL);
+				    clkdm->pwrdm.ptr->prcm_offs,
+							 OMAP2_CM_CLKSTCTRL);
 
 	} else {
 		BUG();
@@ -465,7 +466,8 @@ int omap2_clkdm_wakeup(struct clockdomain *clkdm)
 			 __ffs(clkdm->clktrctrl_mask));
 
 		cm_rmw_mod_reg_bits(clkdm->clktrctrl_mask, v,
-				    clkdm->pwrdm.ptr->prcm_offs, CM_CLKSTCTRL);
+				    clkdm->pwrdm.ptr->prcm_offs,
+						 OMAP2_CM_CLKSTCTRL);
 
 	} else {
 		BUG();
diff --git a/arch/arm/mach-omap2/clockdomains.h b/arch/arm/mach-omap2/clockdomains.h
index c4ee076..0e61140 100644
--- a/arch/arm/mach-omap2/clockdomains.h
+++ b/arch/arm/mach-omap2/clockdomains.h
@@ -11,6 +11,8 @@
 #define __ARCH_ARM_MACH_OMAP2_CLOCKDOMAINS_H
 
 #include <plat/clockdomain.h>
+#include "cm.h"
+#include "prm44xx.h"
 
 /*
  * OMAP2/3-common clockdomains
@@ -50,6 +52,7 @@ static struct clockdomain mpu_2420_clkdm = {
 	.name		= "mpu_clkdm",
 	.pwrdm		= { .name = "mpu_pwrdm" },
 	.flags		= CLKDM_CAN_HWSUP,
+	.clkstctrl_reg  = OMAP2420_CM_REGADDR(MPU_MOD, OMAP2_CM_CLKSTCTRL),
 	.clktrctrl_mask = OMAP24XX_AUTOSTATE_MPU_MASK,
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2420),
 };
@@ -58,11 +61,59 @@ static struct clockdomain iva1_2420_clkdm = {
 	.name		= "iva1_clkdm",
 	.pwrdm		= { .name = "dsp_pwrdm" },
 	.flags		= CLKDM_CAN_HWSUP_SWSUP,
+	.clkstctrl_reg  = OMAP2420_CM_REGADDR(OMAP24XX_DSP_MOD,
+						 OMAP2_CM_CLKSTCTRL),
 	.clktrctrl_mask = OMAP2420_AUTOSTATE_IVA_MASK,
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2420),
 };
 
-#endif  /* CONFIG_ARCH_OMAP2420 */
+static struct clockdomain dsp_2420_clkdm = {
+	.name		= "dsp_clkdm",
+	.pwrdm		= { .name = "dsp_pwrdm" },
+	.flags		= CLKDM_CAN_HWSUP_SWSUP,
+	.clkstctrl_reg  = OMAP2420_CM_REGADDR(OMAP24XX_DSP_MOD,
+						 OMAP2_CM_CLKSTCTRL),
+	.clktrctrl_mask = OMAP24XX_AUTOSTATE_DSP_MASK,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2420),
+};
+
+static struct clockdomain gfx_2420_clkdm = {
+	.name		= "gfx_clkdm",
+	.pwrdm		= { .name = "gfx_pwrdm" },
+	.flags		= CLKDM_CAN_HWSUP_SWSUP,
+	.clkstctrl_reg  = OMAP2420_CM_REGADDR(GFX_MOD, OMAP2_CM_CLKSTCTRL),
+	.clktrctrl_mask = OMAP24XX_AUTOSTATE_GFX_MASK,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2420),
+};
+
+static struct clockdomain core_l3_2420_clkdm = {
+	.name		= "core_l3_clkdm",
+	.pwrdm		= { .name = "core_pwrdm" },
+	.flags		= CLKDM_CAN_HWSUP,
+	.clkstctrl_reg  = OMAP2420_CM_REGADDR(CORE_MOD, OMAP2_CM_CLKSTCTRL),
+	.clktrctrl_mask = OMAP24XX_AUTOSTATE_L3_MASK,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2420),
+};
+
+static struct clockdomain core_l4_2420_clkdm = {
+	.name		= "core_l4_clkdm",
+	.pwrdm		= { .name = "core_pwrdm" },
+	.flags		= CLKDM_CAN_HWSUP,
+	.clkstctrl_reg  = OMAP2420_CM_REGADDR(CORE_MOD, OMAP2_CM_CLKSTCTRL),
+	.clktrctrl_mask = OMAP24XX_AUTOSTATE_L4_MASK,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2420),
+};
+
+static struct clockdomain dss_2420_clkdm = {
+	.name		= "dss_clkdm",
+	.pwrdm		= { .name = "core_pwrdm" },
+	.flags		= CLKDM_CAN_HWSUP,
+	.clkstctrl_reg  = OMAP2420_CM_REGADDR(CORE_MOD, OMAP2_CM_CLKSTCTRL),
+	.clktrctrl_mask = OMAP24XX_AUTOSTATE_DSS_MASK,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2420),
+};
+
+#endif   /* CONFIG_ARCH_OMAP2420 */
 
 
 /*
@@ -75,6 +126,8 @@ static struct clockdomain mpu_2430_clkdm = {
 	.name		= "mpu_clkdm",
 	.pwrdm		= { .name = "mpu_pwrdm" },
 	.flags		= CLKDM_CAN_HWSUP_SWSUP,
+	.clkstctrl_reg  = OMAP2430_CM_REGADDR(MPU_MOD,
+						 OMAP2_CM_CLKSTCTRL),
 	.clktrctrl_mask = OMAP24XX_AUTOSTATE_MPU_MASK,
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2430),
 };
@@ -83,60 +136,59 @@ static struct clockdomain mdm_clkdm = {
 	.name		= "mdm_clkdm",
 	.pwrdm		= { .name = "mdm_pwrdm" },
 	.flags		= CLKDM_CAN_HWSUP_SWSUP,
+	.clkstctrl_reg  = OMAP2430_CM_REGADDR(OMAP2430_MDM_MOD,
+						 OMAP2_CM_CLKSTCTRL),
 	.clktrctrl_mask = OMAP2430_AUTOSTATE_MDM_MASK,
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2430),
 };
 
-#endif    /* CONFIG_ARCH_OMAP2430 */
-
-
-/*
- * 24XX-only clockdomains
- */
-
-#if defined(CONFIG_ARCH_OMAP24XX)
-
-static struct clockdomain dsp_clkdm = {
+static struct clockdomain dsp_2430_clkdm = {
 	.name		= "dsp_clkdm",
 	.pwrdm		= { .name = "dsp_pwrdm" },
 	.flags		= CLKDM_CAN_HWSUP_SWSUP,
+	.clkstctrl_reg  = OMAP2430_CM_REGADDR(OMAP24XX_DSP_MOD,
+						 OMAP2_CM_CLKSTCTRL),
 	.clktrctrl_mask = OMAP24XX_AUTOSTATE_DSP_MASK,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP24XX),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2430),
 };
 
-static struct clockdomain gfx_24xx_clkdm = {
+static struct clockdomain gfx_2430_clkdm = {
 	.name		= "gfx_clkdm",
 	.pwrdm		= { .name = "gfx_pwrdm" },
 	.flags		= CLKDM_CAN_HWSUP_SWSUP,
+	.clkstctrl_reg  = OMAP2430_CM_REGADDR(GFX_MOD, OMAP2_CM_CLKSTCTRL),
 	.clktrctrl_mask = OMAP24XX_AUTOSTATE_GFX_MASK,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP24XX),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2430),
 };
 
-static struct clockdomain core_l3_24xx_clkdm = {
+static struct clockdomain core_l3_2430_clkdm = {
 	.name		= "core_l3_clkdm",
 	.pwrdm		= { .name = "core_pwrdm" },
 	.flags		= CLKDM_CAN_HWSUP,
+	.clkstctrl_reg  = OMAP2430_CM_REGADDR(CORE_MOD, OMAP2_CM_CLKSTCTRL),
 	.clktrctrl_mask = OMAP24XX_AUTOSTATE_L3_MASK,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP24XX),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2430),
 };
 
-static struct clockdomain core_l4_24xx_clkdm = {
+static struct clockdomain core_l4_2430_clkdm = {
 	.name		= "core_l4_clkdm",
 	.pwrdm		= { .name = "core_pwrdm" },
 	.flags		= CLKDM_CAN_HWSUP,
+	.clkstctrl_reg  = OMAP2430_CM_REGADDR(CORE_MOD, OMAP2_CM_CLKSTCTRL),
 	.clktrctrl_mask = OMAP24XX_AUTOSTATE_L4_MASK,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP24XX),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2430),
 };
 
-static struct clockdomain dss_24xx_clkdm = {
+static struct clockdomain dss_2430_clkdm = {
 	.name		= "dss_clkdm",
 	.pwrdm		= { .name = "core_pwrdm" },
 	.flags		= CLKDM_CAN_HWSUP,
+	.clkstctrl_reg  = OMAP2430_CM_REGADDR(CORE_MOD, OMAP2_CM_CLKSTCTRL),
 	.clktrctrl_mask = OMAP24XX_AUTOSTATE_DSS_MASK,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP24XX),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2430),
 };
 
-#endif   /* CONFIG_ARCH_OMAP24XX */
+#endif    /* CONFIG_ARCH_OMAP2430 */
 
 
 /*
@@ -149,6 +201,7 @@ static struct clockdomain mpu_34xx_clkdm = {
 	.name		= "mpu_clkdm",
 	.pwrdm		= { .name = "mpu_pwrdm" },
 	.flags		= CLKDM_CAN_HWSUP | CLKDM_CAN_FORCE_WAKEUP,
+	.clkstctrl_reg	= OMAP34XX_CM_REGADDR(MPU_MOD, OMAP2_CM_CLKSTCTRL),
 	.clktrctrl_mask = OMAP3430_CLKTRCTRL_MPU_MASK,
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
 };
@@ -157,6 +210,8 @@ static struct clockdomain neon_clkdm = {
 	.name		= "neon_clkdm",
 	.pwrdm		= { .name = "neon_pwrdm" },
 	.flags		= CLKDM_CAN_HWSUP_SWSUP,
+	.clkstctrl_reg	= OMAP34XX_CM_REGADDR(OMAP3430_NEON_MOD,
+						 OMAP2_CM_CLKSTCTRL),
 	.clktrctrl_mask = OMAP3430_CLKTRCTRL_NEON_MASK,
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
 };
@@ -165,6 +220,8 @@ static struct clockdomain iva2_clkdm = {
 	.name		= "iva2_clkdm",
 	.pwrdm		= { .name = "iva2_pwrdm" },
 	.flags		= CLKDM_CAN_HWSUP_SWSUP,
+	.clkstctrl_reg	= OMAP34XX_CM_REGADDR(OMAP3430_IVA2_MOD,
+						 OMAP2_CM_CLKSTCTRL),
 	.clktrctrl_mask = OMAP3430_CLKTRCTRL_IVA2_MASK,
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
 };
@@ -173,6 +230,7 @@ static struct clockdomain gfx_3430es1_clkdm = {
 	.name		= "gfx_clkdm",
 	.pwrdm		= { .name = "gfx_pwrdm" },
 	.flags		= CLKDM_CAN_HWSUP_SWSUP,
+	.clkstctrl_reg	= OMAP34XX_CM_REGADDR(GFX_MOD, OMAP2_CM_CLKSTCTRL),
 	.clktrctrl_mask = OMAP3430ES1_CLKTRCTRL_GFX_MASK,
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430ES1),
 };
@@ -181,6 +239,8 @@ static struct clockdomain sgx_clkdm = {
 	.name		= "sgx_clkdm",
 	.pwrdm		= { .name = "sgx_pwrdm" },
 	.flags		= CLKDM_CAN_HWSUP_SWSUP,
+	.clkstctrl_reg	= OMAP34XX_CM_REGADDR(OMAP3430ES2_SGX_MOD,
+						 OMAP2_CM_CLKSTCTRL),
 	.clktrctrl_mask = OMAP3430ES2_CLKTRCTRL_SGX_MASK,
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_GE_OMAP3430ES2),
 };
@@ -196,6 +256,7 @@ static struct clockdomain d2d_clkdm = {
 	.name		= "d2d_clkdm",
 	.pwrdm		= { .name = "core_pwrdm" },
 	.flags		= CLKDM_CAN_HWSUP_SWSUP,
+	.clkstctrl_reg	= OMAP34XX_CM_REGADDR(CORE_MOD, OMAP2_CM_CLKSTCTRL),
 	.clktrctrl_mask = OMAP3430ES1_CLKTRCTRL_D2D_MASK,
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
 };
@@ -204,6 +265,7 @@ static struct clockdomain core_l3_34xx_clkdm = {
 	.name		= "core_l3_clkdm",
 	.pwrdm		= { .name = "core_pwrdm" },
 	.flags		= CLKDM_CAN_HWSUP,
+	.clkstctrl_reg	= OMAP34XX_CM_REGADDR(CORE_MOD, OMAP2_CM_CLKSTCTRL),
 	.clktrctrl_mask = OMAP3430_CLKTRCTRL_L3_MASK,
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
 };
@@ -212,6 +274,7 @@ static struct clockdomain core_l4_34xx_clkdm = {
 	.name		= "core_l4_clkdm",
 	.pwrdm		= { .name = "core_pwrdm" },
 	.flags		= CLKDM_CAN_HWSUP,
+	.clkstctrl_reg	= OMAP34XX_CM_REGADDR(CORE_MOD, OMAP2_CM_CLKSTCTRL),
 	.clktrctrl_mask = OMAP3430_CLKTRCTRL_L4_MASK,
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
 };
@@ -220,6 +283,8 @@ static struct clockdomain dss_34xx_clkdm = {
 	.name		= "dss_clkdm",
 	.pwrdm		= { .name = "dss_pwrdm" },
 	.flags		= CLKDM_CAN_HWSUP_SWSUP,
+	.clkstctrl_reg	= OMAP34XX_CM_REGADDR(OMAP3430_DSS_MOD,
+						 OMAP2_CM_CLKSTCTRL),
 	.clktrctrl_mask = OMAP3430_CLKTRCTRL_DSS_MASK,
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
 };
@@ -228,6 +293,8 @@ static struct clockdomain cam_clkdm = {
 	.name		= "cam_clkdm",
 	.pwrdm		= { .name = "cam_pwrdm" },
 	.flags		= CLKDM_CAN_HWSUP_SWSUP,
+	.clkstctrl_reg	= OMAP34XX_CM_REGADDR(OMAP3430_CAM_MOD,
+						 OMAP2_CM_CLKSTCTRL),
 	.clktrctrl_mask = OMAP3430_CLKTRCTRL_CAM_MASK,
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
 };
@@ -236,6 +303,8 @@ static struct clockdomain usbhost_clkdm = {
 	.name		= "usbhost_clkdm",
 	.pwrdm		= { .name = "usbhost_pwrdm" },
 	.flags		= CLKDM_CAN_HWSUP_SWSUP,
+	.clkstctrl_reg	= OMAP34XX_CM_REGADDR(OMAP3430ES2_USBHOST_MOD,
+						 OMAP2_CM_CLKSTCTRL),
 	.clktrctrl_mask = OMAP3430ES2_CLKTRCTRL_USBHOST_MASK,
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_GE_OMAP3430ES2),
 };
@@ -244,6 +313,8 @@ static struct clockdomain per_clkdm = {
 	.name		= "per_clkdm",
 	.pwrdm		= { .name = "per_pwrdm" },
 	.flags		= CLKDM_CAN_HWSUP_SWSUP,
+	.clkstctrl_reg	= OMAP34XX_CM_REGADDR(OMAP3430_PER_MOD,
+						 OMAP2_CM_CLKSTCTRL),
 	.clktrctrl_mask = OMAP3430_CLKTRCTRL_PER_MASK,
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
 };
@@ -256,6 +327,8 @@ static struct clockdomain emu_clkdm = {
 	.name		= "emu_clkdm",
 	.pwrdm		= { .name = "emu_pwrdm" },
 	.flags		= /* CLKDM_CAN_ENABLE_AUTO |  */CLKDM_CAN_SWSUP,
+	.clkstctrl_reg	= OMAP34XX_CM_REGADDR(OMAP3430_EMU_MOD,
+						 OMAP2_CM_CLKSTCTRL),
 	.clktrctrl_mask = OMAP3430_CLKTRCTRL_EMU_MASK,
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
 };
@@ -323,19 +396,21 @@ static struct clockdomain *clockdomains_omap[] = {
 #ifdef CONFIG_ARCH_OMAP2420
 	&mpu_2420_clkdm,
 	&iva1_2420_clkdm,
+	&dsp_2420_clkdm,
+	&gfx_2420_clkdm,
+	&core_l3_2420_clkdm,
+	&core_l4_2420_clkdm,
+	&dss_2420_clkdm,
 #endif
 
 #ifdef CONFIG_ARCH_OMAP2430
 	&mpu_2430_clkdm,
 	&mdm_clkdm,
-#endif
-
-#ifdef CONFIG_ARCH_OMAP24XX
-	&dsp_clkdm,
-	&gfx_24xx_clkdm,
-	&core_l3_24xx_clkdm,
-	&core_l4_24xx_clkdm,
-	&dss_24xx_clkdm,
+	&dsp_2430_clkdm,
+	&gfx_2430_clkdm,
+	&core_l3_2430_clkdm,
+	&core_l4_2430_clkdm,
+	&dss_2430_clkdm,
 #endif
 
 #ifdef CONFIG_ARCH_OMAP34XX
diff --git a/arch/arm/mach-omap2/cm.h b/arch/arm/mach-omap2/cm.h
index a2fcfcc..159dc2f 100644
--- a/arch/arm/mach-omap2/cm.h
+++ b/arch/arm/mach-omap2/cm.h
@@ -61,7 +61,8 @@
 #define CM_CLKSEL					0x0040
 #define CM_CLKSEL1					CM_CLKSEL
 #define CM_CLKSEL2					0x0044
-#define CM_CLKSTCTRL					0x0048
+#define OMAP2_CM_CLKSTCTRL				0x0048
+#define OMAP4_CM_CLKSTCTRL				0x0000
 
 
 /* Architecture-specific registers */
@@ -82,7 +83,7 @@
 #define OMAP3430_CM_CLKSEL1_PLL				CM_CLKSEL
 #define OMAP3430_CM_CLKSEL2_PLL				CM_CLKSEL2
 #define OMAP3430_CM_SLEEPDEP				CM_CLKSEL2
-#define OMAP3430_CM_CLKSEL3				CM_CLKSTCTRL
+#define OMAP3430_CM_CLKSEL3				OMAP2_CM_CLKSTCTRL
 #define OMAP3430_CM_CLKSTST				0x004c
 #define OMAP3430ES2_CM_CLKSEL4				0x004c
 #define OMAP3430ES2_CM_CLKSEL5				0x0050
diff --git a/arch/arm/mach-omap2/pm-debug.c b/arch/arm/mach-omap2/pm-debug.c
index 404bff2..8374abb 100644
--- a/arch/arm/mach-omap2/pm-debug.c
+++ b/arch/arm/mach-omap2/pm-debug.c
@@ -69,7 +69,7 @@ void omap2_pm_dump(int mode, int resume, unsigned int us)
 #if 0
 		/* MPU */
 		DUMP_PRM_MOD_REG(OCP_MOD, OMAP2_PRM_IRQENABLE_MPU_OFFSET);
-		DUMP_CM_MOD_REG(MPU_MOD, CM_CLKSTCTRL);
+		DUMP_CM_MOD_REG(MPU_MOD, OMAP2_CM_CLKSTCTRL);
 		DUMP_PRM_MOD_REG(MPU_MOD, OMAP2_PM_PWSTCTRL);
 		DUMP_PRM_MOD_REG(MPU_MOD, OMAP2_PM_PWSTST);
 		DUMP_PRM_MOD_REG(MPU_MOD, PM_WKDEP);
@@ -105,7 +105,7 @@ void omap2_pm_dump(int mode, int resume, unsigned int us)
 			DUMP_CM_MOD_REG(OMAP24XX_DSP_MOD, CM_IDLEST);
 			DUMP_CM_MOD_REG(OMAP24XX_DSP_MOD, CM_AUTOIDLE);
 			DUMP_CM_MOD_REG(OMAP24XX_DSP_MOD, CM_CLKSEL);
-			DUMP_CM_MOD_REG(OMAP24XX_DSP_MOD, CM_CLKSTCTRL);
+			DUMP_CM_MOD_REG(OMAP24XX_DSP_MOD, OMAP2_CM_CLKSTCTRL);
 			DUMP_PRM_MOD_REG(OMAP24XX_DSP_MOD, OMAP2_RM_RSTCTRL);
 			DUMP_PRM_MOD_REG(OMAP24XX_DSP_MOD, OMAP2_RM_RSTST);
 			DUMP_PRM_MOD_REG(OMAP24XX_DSP_MOD, OMAP2_PM_PWSTCTRL);
diff --git a/arch/arm/plat-omap/include/plat/clockdomain.h b/arch/arm/plat-omap/include/plat/clockdomain.h
index eb73482..4806e2c 100644
--- a/arch/arm/plat-omap/include/plat/clockdomain.h
+++ b/arch/arm/plat-omap/include/plat/clockdomain.h
@@ -74,6 +74,9 @@ struct clockdomain {
 		struct powerdomain *ptr;
 	} pwrdm;
 
+	/* CLKSTCTRL reg for the given clock domain*/
+	void __iomem *clkstctrl_reg;
+
 	/* CLKTRCTRL/AUTOSTATE field mask in CM_CLKSTCTRL reg */
 	const u16 clktrctrl_mask;
 
-- 
1.5.4.7


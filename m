From: abhijitpagare@ti.com
Subject: [PATCH 1/3] ARM: OMAP4: PM: Add power domain framework.
Date: Fri, 14 Aug 2009 16:36:27 +0530
Message-ID: <1250247987-23468-1-git-send-email-abhijitpagare@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57581 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754573AbZHNLGe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 Aug 2009 07:06:34 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id n7EB6TOP020595
	for <linux-omap@vger.kernel.org>; Fri, 14 Aug 2009 06:06:34 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Abhijit Pagare <abhijitpagare@ti.com>

From: Abhijit Pagare <abhijitpagare@ti.com>

This Patch Adds the new power domain framework for OMAP4 and introduces \
some MACROS for OMAP4 Support. It also takes care of the initialisations \
of the power domains based on the silicon.

[Reposting with Proper Patch Number]

Signed-off-by: Abhijit Pagare <abhijitpagare@ti.com>
---
 arch/arm/mach-omap2/io.c                      |    2 +-
 arch/arm/mach-omap2/powerdomain.c             |    3 +
 arch/arm/mach-omap2/powerdomains.h            |   53 +++---
 arch/arm/mach-omap2/powerdomains24xx.h        |   18 ++
 arch/arm/mach-omap2/powerdomains34xx.h        |   18 ++
 arch/arm/mach-omap2/powerdomains44xx.h        |  259 +++++++++++++++++++++++++
 arch/arm/mach-omap2/prcm.c                    |    2 +
 arch/arm/mach-omap2/prm.h                     |   24 ++-
 arch/arm/plat-omap/include/mach/cpu.h         |    4 +-
 arch/arm/plat-omap/include/mach/powerdomain.h |    4 +-
 10 files changed, 350 insertions(+), 37 deletions(-)
 create mode 100644 arch/arm/mach-omap2/powerdomains44xx.h

diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index dcd9e39..dd0c408 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -277,8 +277,8 @@ static int __init _omap2_init_reprogram_sdrc(void)
 void __init omap2_init_common_hw(struct omap_sdrc_params *sp)
 {
 	omap2_mux_init();
-#ifndef CONFIG_ARCH_OMAP4 /* FIXME: Remove this once the clkdm/pwrdm f/w is ready */
 	pwrdm_init(powerdomains_omap);
+#ifndef CONFIG_ARCH_OMAP4 /* FIXME: Remove it once clkdm/pwrdm f/w is ready */
 	clkdm_init(clockdomains_omap, clkdm_pwrdm_autodeps);
 	omap2_sdrc_init(sp);
 	_omap2_init_reprogram_sdrc();
diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
index 983f1cb..8f19c38 100644
--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -28,8 +28,11 @@
 
 #include "cm.h"
 #include "cm-regbits-34xx.h"
+#include "cm1-regbits-44xx.h"
+#include "cm2-regbits-44xx.h"
 #include "prm.h"
 #include "prm-regbits-34xx.h"
+#include "prm-regbits-44xx.h"
 
 #include <mach/cpu.h>
 #include <mach/powerdomain.h>
diff --git a/arch/arm/mach-omap2/powerdomains.h b/arch/arm/mach-omap2/powerdomains.h
index 691470e..7f1f270 100644
--- a/arch/arm/mach-omap2/powerdomains.h
+++ b/arch/arm/mach-omap2/powerdomains.h
@@ -76,6 +76,7 @@
  * 3430ES1 PM_WKDEP_GFX: adds IVA2, removes CORE
  * 3430ES2 PM_WKDEP_SGX: adds IVA2, removes CORE
  */
+#ifndef CONFIG_ARCH_OMAP4
 static struct pwrdm_dep gfx_sgx_wkdeps[] = {
 	{
 		.pwrdm_name = "core_pwrdm",
@@ -110,42 +111,22 @@ static struct pwrdm_dep cam_gfx_sleepdeps[] = {
 	},
 	{ NULL },
 };
-
+#endif
 
 #include "powerdomains24xx.h"
 #include "powerdomains34xx.h"
+#include "powerdomains44xx.h"
 
 
 /*
- * OMAP2/3 common powerdomains
+ * OMAP2/3/4 common powerdomains
  */
 
-/*
- * The GFX powerdomain is not present on 3430ES2, but currently we do not
- * have a macro to filter it out at compile-time.
- */
-static struct powerdomain gfx_pwrdm = {
-	.name		  = "gfx_pwrdm",
-	.prcm_offs	  = GFX_MOD,
-	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP24XX |
-					   CHIP_IS_OMAP3430ES1),
-	.wkdep_srcs	  = gfx_sgx_wkdeps,
-	.sleepdep_srcs	  = cam_gfx_sleepdeps,
-	.pwrsts		  = PWRSTS_OFF_RET_ON,
-	.pwrsts_logic_ret = PWRDM_POWER_RET,
-	.banks		  = 1,
-	.pwrsts_mem_ret	  = {
-		[0] = PWRDM_POWER_RET, /* MEMRETSTATE */
-	},
-	.pwrsts_mem_on	  = {
-		[0] = PWRDM_POWER_ON,  /* MEMONSTATE */
-	},
-};
-
 static struct powerdomain wkup_pwrdm = {
 	.name		= "wkup_pwrdm",
 	.prcm_offs	= WKUP_MOD,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP24XX | CHIP_IS_OMAP3430),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP24XX | CHIP_IS_OMAP3430 | \
+					CHIP_IS_OMAP4430),
 	.dep_bit	= OMAP_EN_WKUP_SHIFT,
 };
 
@@ -153,21 +134,22 @@ static struct powerdomain wkup_pwrdm = {
 
 /* As powerdomains are added or removed above, this list must also be changed */
 static struct powerdomain *powerdomains_omap[] __initdata = {
-
-	&gfx_pwrdm,
 	&wkup_pwrdm,
 
 #ifdef CONFIG_ARCH_OMAP24XX
+	&gfx_pwrdm,
 	&dsp_pwrdm,
 	&mpu_24xx_pwrdm,
 	&core_24xx_pwrdm,
 #endif
 
 #ifdef CONFIG_ARCH_OMAP2430
+	&gfx_pwrdm,
 	&mdm_pwrdm,
 #endif
 
 #ifdef CONFIG_ARCH_OMAP34XX
+	&gfx_pwrdm,
 	&iva2_pwrdm,
 	&mpu_34xx_pwrdm,
 	&neon_pwrdm,
@@ -186,6 +168,23 @@ static struct powerdomain *powerdomains_omap[] __initdata = {
 	&dpll5_pwrdm,
 #endif
 
+#ifdef CONFIG_ARCH_OMAP4
+	&dsp_44xx_pwrdm,
+	&std_efuse_44xx_pwrdm,
+	&mpu_44xx_pwrdm,
+	&pd_l4_per_44xx_pwrdm,
+	&pd_l3_init_44xx_pwrdm,
+	&ivahd_44xx_pwrdm,
+	&pd_sgx_44xx_pwrdm,
+	&pd_emu_44xx_pwrdm,
+	&pd_dss_44xx_pwrdm,
+	&pd_core_44xx_pwrdm,
+	&pd_cam_44xx_pwrdm,
+	&pd_audio_44xx_pwrdm,
+	&pd_alwon_mpu_44xx_pwrdm,
+	&pd_alwon_dsp_44xx_pwrdm,
+	&pd_alwon_core_44xx_pwrdm,
+#endif
 	NULL
 };
 
diff --git a/arch/arm/mach-omap2/powerdomains24xx.h b/arch/arm/mach-omap2/powerdomains24xx.h
index 9f08dc3..bc0ec51 100644
--- a/arch/arm/mach-omap2/powerdomains24xx.h
+++ b/arch/arm/mach-omap2/powerdomains24xx.h
@@ -110,6 +110,24 @@ static struct pwrdm_dep core_24xx_wkdeps[] = {
 
 /* Powerdomains */
 
+static struct powerdomain gfx_pwrdm = {
+	.name			= "gfx_pwrdm",
+	.prcm_offs		= GFX_MOD,
+	.omap_chip		= OMAP_CHIP_INIT(CHIP_IS_OMAP24XX | \
+					CHIP_IS_OMAP3430ES1),
+	.wkdep_srcs		= gfx_sgx_wkdeps,
+	.sleepdep_srcs		= cam_gfx_sleepdeps,
+	.pwrsts			= PWRSTS_OFF_RET_ON,
+	.pwrsts_logic_ret	= PWRDM_POWER_RET,
+	.banks			= 1,
+	.pwrsts_mem_ret		= {
+		[0] = PWRDM_POWER_RET, /* MEMRETSTATE */
+	},
+	.pwrsts_mem_on		= {
+		[0] = PWRDM_POWER_ON,  /* MEMONSTATE */
+	},
+};
+
 static struct powerdomain dsp_pwrdm = {
 	.name		  = "dsp_pwrdm",
 	.prcm_offs	  = OMAP24XX_DSP_MOD,
diff --git a/arch/arm/mach-omap2/powerdomains34xx.h b/arch/arm/mach-omap2/powerdomains34xx.h
index 4dcf94b..abc2bb4 100644
--- a/arch/arm/mach-omap2/powerdomains34xx.h
+++ b/arch/arm/mach-omap2/powerdomains34xx.h
@@ -159,6 +159,24 @@ static struct pwrdm_dep dss_per_usbhost_sleepdeps[] = {
  * Powerdomains
  */
 
+static struct powerdomain gfx_pwrdm = {
+	.name			= "gfx_pwrdm",
+	.prcm_offs		= GFX_MOD,
+	.omap_chip		= OMAP_CHIP_INIT(CHIP_IS_OMAP24XX | \
+					CHIP_IS_OMAP3430ES1),
+	.wkdep_srcs		= gfx_sgx_wkdeps,
+	.sleepdep_srcs		= cam_gfx_sleepdeps,
+	.pwrsts			= PWRSTS_OFF_RET_ON,
+	.pwrsts_logic_ret	= PWRDM_POWER_RET,
+	.banks			= 1,
+	.pwrsts_mem_ret		= {
+		[0] = PWRDM_POWER_RET,	/* MEMRETSTATE */
+	},
+	.pwrsts_mem_on		= {
+		[0] = PWRDM_POWER_ON,	/* MEMONSTATE */
+	},
+};
+
 static struct powerdomain iva2_pwrdm = {
 	.name		  = "iva2_pwrdm",
 	.prcm_offs	  = OMAP3430_IVA2_MOD,
diff --git a/arch/arm/mach-omap2/powerdomains44xx.h b/arch/arm/mach-omap2/powerdomains44xx.h
new file mode 100644
index 0000000..f0472e9
--- /dev/null
+++ b/arch/arm/mach-omap2/powerdomains44xx.h
@@ -0,0 +1,259 @@
+/*
+ * OMAP44XX powerdomain definitions
+ *
+ * Copyright (C) 2008-2009 Texas Instruments, Inc.
+ *
+ * Written by Abhijit Pagare(abhijitpagare@ti.com)
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef ARCH_ARM_MACH_OMAP2_POWERDOMAINS44XX
+#define ARCH_ARM_MACH_OMAP2_POWERDOMAINS44XX
+
+/*
+ * N.B. If powerdomains are added or removed from this file, update
+ * the array in mach-omap2/powerdomains.h.
+ */
+
+
+#include <mach/powerdomain.h>
+
+#include "prcm-common.h"
+#include "prm.h"
+#include "prm-regbits-44xx.h"
+#include "cm.h"
+#include "cm1-regbits-44xx.h"
+#include "cm2-regbits-44xx.h"
+
+/*
+ * 44XX-specific powerdomains, dependencies
+ */
+
+#ifdef CONFIG_ARCH_OMAP4
+
+/* Wakeup dependency for 44xx-specific pwrdm modules (to be populated later) */
+
+/* Sleep dependency for 44xx-specific pwrdm modules (to be populated later) */
+
+
+/*
+ * Powerdomains (without the dpendency parameter definitions)
+ */
+
+static struct powerdomain dsp_44xx_pwrdm = {
+	.name			= "dsp_pwrdm",
+	.prcm_offs		= OMAP4430_DSP_MOD,
+	.omap_chip		= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+	.pwrsts			= PWRSTS_OFF_RET_ON,
+	.pwrsts_logic_ret	= PWRSTS_OFF_RET,
+	.banks			= 3,
+	.pwrsts_mem_ret		= {
+		[0] = PWRDM_POWER_RET,
+		[1] = PWRSTS_OFF_RET,
+		[2] = PWRSTS_OFF_RET,
+	},
+	.pwrsts_mem_on		= {
+		[0] = PWRDM_POWER_ON,
+		[1] = PWRDM_POWER_ON,
+		[2] = PWRDM_POWER_ON,
+	},
+};
+
+static struct powerdomain std_efuse_44xx_pwrdm = {
+	.name			= "std_effuse_pwrdm",
+	.prcm_offs		= OMAP4430_CEFUSE_MOD,
+	.omap_chip		= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+};
+
+static struct powerdomain mpu_44xx_pwrdm = {
+	.name			= "mpu_pwrdm",
+	.prcm_offs		= OMAP4430_MPU_MOD,
+	.omap_chip		= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+	.pwrsts			= PWRSTS_OFF_RET_ON,
+	.pwrsts_logic_ret 	= PWRSTS_OFF_RET,
+	.banks			= 3,
+	.pwrsts_mem_ret		= {
+		[0] = PWRSTS_OFF_RET,
+		[1] = PWRSTS_OFF_RET,
+		[2] = PWRDM_POWER_RET,
+	},
+	.pwrsts_mem_on		= {
+		[0] = PWRDM_POWER_ON,
+		[1] = PWRDM_POWER_ON,
+		[2] = PWRDM_POWER_ON,
+	},
+};
+
+static struct powerdomain pd_l4_per_44xx_pwrdm = {
+	.name			= "pd_l4_per_pwrdm",
+	.prcm_offs		= OMAP4430_L4PER_MOD,
+	.omap_chip		= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+	.pwrsts			= PWRSTS_OFF_RET_ON,
+	.pwrsts_logic_ret	= PWRSTS_OFF_RET,
+	.banks			= 2,
+	.pwrsts_mem_ret		= {
+		[0] = PWRDM_POWER_OFF,
+		[1] = PWRDM_POWER_RET,
+	},
+	.pwrsts_mem_on		= {
+		[0] = PWRDM_POWER_ON,
+		[1] = PWRDM_POWER_ON,
+	},
+};
+
+static struct powerdomain pd_l3_init_44xx_pwrdm = {
+	.name			= "pd_l3_init_pwrdm",
+	.prcm_offs		= OMAP4430_L3INIT_MOD,
+	.omap_chip		= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+	.pwrsts			= PWRSTS_OFF_RET_ON,
+	.pwrsts_logic_ret	= PWRSTS_OFF_RET,
+	.banks			= 1,
+	.pwrsts_mem_ret		= {
+		[0] = PWRDM_POWER_OFF,
+	},
+	.pwrsts_mem_on		= {
+		[0] = PWRDM_POWER_ON,
+	},
+};
+
+static struct powerdomain ivahd_44xx_pwrdm = {
+	.name			= "ivahd_pwrdm",
+	.prcm_offs		= OMAP4430_IVAHD_MOD,
+	.omap_chip		= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+	.pwrsts			= PWRSTS_OFF_ON,
+	.banks			= 4,
+	.pwrsts_mem_ret		= {
+		[0] = PWRDM_POWER_OFF,
+		[1] = PWRSTS_OFF_RET,
+		[2] = PWRSTS_OFF_RET,
+		[3] = PWRSTS_OFF_RET,
+	},
+	.pwrsts_mem_on		= {
+		[0] = PWRDM_POWER_ON,
+		[1] = PWRDM_POWER_ON,
+		[2] = PWRDM_POWER_ON,
+		[3] = PWRDM_POWER_ON,
+	},
+};
+
+static struct powerdomain pd_sgx_44xx_pwrdm = {
+	.name			= "pd_sgx_pwrdm",
+	.prcm_offs		= OMAP4430_GFX_MOD,
+	.omap_chip		= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+	.pwrsts			= PWRSTS_OFF_ON,
+	.banks			= 1,
+	.pwrsts_mem_ret		= {
+		[0] = PWRDM_POWER_OFF,
+	},
+	.pwrsts_mem_on		= {
+		[0] = PWRDM_POWER_ON,
+	},
+};
+
+static struct powerdomain pd_emu_44xx_pwrdm = {
+	.name			= "pd_emu_pwrdm",
+	.prcm_offs		= OMAP4430_EMU_MOD,
+	.omap_chip		= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+	.pwrsts			= PWRSTS_OFF_ON,
+	.banks			= 1,
+	.pwrsts_mem_ret		= {
+		[0] = PWRDM_POWER_OFF,
+	},
+	.pwrsts_mem_on		= {
+		[0] = PWRDM_POWER_ON,
+	},
+};
+
+static struct powerdomain pd_dss_44xx_pwrdm = {
+	.name			= "pd_dss_pwrdm",
+	.prcm_offs		= OMAP4430_DSS_MOD,
+	.omap_chip		= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+	.pwrsts			= PWRSTS_OFF_RET_ON,
+	.pwrsts_logic_ret	= PWRSTS_OFF_RET,
+	.banks			= 1,
+	.pwrsts_mem_ret		= {
+		[0] = PWRDM_POWER_OFF,
+	},
+	.pwrsts_mem_on		= {
+		[0] = PWRDM_POWER_ON,
+	},
+};
+
+static struct powerdomain pd_core_44xx_pwrdm = {
+	.name			= "core_pwrdm",
+	.prcm_offs		= OMAP4430_CORE_MOD,
+	.omap_chip		= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+	.pwrsts			= PWRSTS_OFF_RET_ON,
+	.pwrsts_logic_ret	= PWRSTS_OFF_RET,
+	.banks			= 5,
+	.pwrsts_mem_ret		= {
+		[0]		= PWRDM_POWER_OFF,
+		[1]		= PWRSTS_OFF_RET,
+		[2]		= PWRDM_POWER_RET,
+		[3]		= PWRSTS_OFF_RET,
+		[4]		= PWRSTS_OFF_RET,
+	},
+	.pwrsts_mem_on		= {
+		[0]		= PWRDM_POWER_ON,
+		[1]		= PWRSTS_OFF_RET_ON,
+		[2]		= PWRDM_POWER_ON,
+		[3]		= PWRDM_POWER_ON,
+		[4]		= PWRDM_POWER_ON,
+	},
+};
+
+static struct powerdomain pd_cam_44xx_pwrdm = {
+	.name			= "pd_cam_pwrdm",
+	.prcm_offs		= OMAP4430_CAM_MOD,
+	.omap_chip		= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+	.pwrsts			= PWRSTS_OFF_ON,
+	.banks			= 1,
+	.pwrsts_mem_ret		= {
+		[0]		= PWRDM_POWER_OFF,
+	},
+	.pwrsts_mem_on		= {
+		[0]		= PWRDM_POWER_ON,
+	},
+};
+
+static struct powerdomain pd_audio_44xx_pwrdm = {
+	.name			= "pd_audio_pwrdm",
+	.prcm_offs		= OMAP4430_ABE_MOD,
+	.omap_chip		= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+	.pwrsts			= PWRSTS_OFF_ON,
+	.banks			= 2,
+	.pwrsts_mem_ret		= {
+		[0]		= PWRDM_POWER_RET,
+		[1]		= PWRDM_POWER_ON,
+	},
+	.pwrsts_mem_on		= {
+		[0]		= PWRDM_POWER_ON,
+		[1]		= PWRDM_POWER_ON,
+	},
+};
+
+static struct powerdomain pd_alwon_mpu_44xx_pwrdm = {
+	.name			= "pd_alwon_mpu_pwrdm",
+	.prcm_offs		= OMAP4430_ALWAYS_ON_MOD,
+	.omap_chip		= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+};
+
+static struct powerdomain pd_alwon_dsp_44xx_pwrdm = {
+	.name			= "pd_alwon_dsp_pwrdm",
+	.prcm_offs		= OMAP4430_ALWAYS_ON_MOD,
+	.omap_chip		= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+};
+
+static struct powerdomain pd_alwon_core_44xx_pwrdm = {
+	.name			= "pd_alwon_core_pwrdm",
+	.prcm_offs		= OMAP4430_ALWAYS_ON_MOD,
+	.omap_chip		= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+};
+
+#endif    /* CONFIG_ARCH_OMAP4 */
+
+#endif
diff --git a/arch/arm/mach-omap2/prcm.c b/arch/arm/mach-omap2/prcm.c
index de307fa..0077752 100644
--- a/arch/arm/mach-omap2/prcm.c
+++ b/arch/arm/mach-omap2/prcm.c
@@ -46,6 +46,8 @@ void omap_prcm_arch_reset(char mode)
 		prcm_offs = WKUP_MOD;
 	else if (cpu_is_omap34xx())
 		prcm_offs = OMAP3430_GR_MOD;
+	else if (cpu_is_omap44xx())
+		prcm_offs = OMAP4430_DEVICE_MOD;
 	else
 		WARN_ON(1);
 
diff --git a/arch/arm/mach-omap2/prm.h b/arch/arm/mach-omap2/prm.h
index bacfc97..5bab417 100644
--- a/arch/arm/mach-omap2/prm.h
+++ b/arch/arm/mach-omap2/prm.h
@@ -473,11 +473,17 @@
  *
  */
 
-/* Registers appearing on both 24xx and 34xx */
-
-#define RM_RSTCTRL					0x0050
-#define RM_RSTTIME					0x0054
-#define RM_RSTST					0x0058
+/* Registers appearing on 24xx and 34xx and 44xx */
+
+#ifdef CONFIG_ARCH_OMAP4
+#define RM_RSTCTRL					0x0000 /* OMAP4 */
+#define RM_RSTTIME					0x0004 /* OMAP4 */
+#define RM_RSTST					0x0008 /* OMAP4 */
+#else
+#define RM_RSTCTRL					0x0050 /* OMAP2 & 3 */
+#define RM_RSTTIME					0x0054 /* OMAP2 & 3 */
+#define RM_RSTST					0x0058 /* OMAP2 & 3 */
+#endif
 
 #define PM_WKEN						0x00a0
 #define PM_WKEN1					PM_WKEN
@@ -487,8 +493,14 @@
 #define PM_EVGENCTRL					0x00d4
 #define PM_EVGENONTIM					0x00d8
 #define PM_EVGENOFFTIM					0x00dc
-#define PM_PWSTCTRL					0x00e0
-#define PM_PWSTST					0x00e4
+
+#ifdef CONFIG_ARCH_OMAP4
+#define PM_PWSTCTRL					0x0000 /* OMAP4 */
+#define PM_PWSTST					0x0004 /* OMAP4 */
+#else
+#define PM_PWSTCTRL					0x00e0 /* OMAP2 & 3 */
+#define PM_PWSTST					0x00e4 /* OMAP2 & 3 */
+#endif
 
 /* Omap2 specific registers */
 #define OMAP24XX_PM_WKEN2				0x00a4
diff --git a/arch/arm/plat-omap/include/mach/cpu.h b/arch/arm/plat-omap/include/mach/cpu.h
index fc60c4e..4647f9a 100644
--- a/arch/arm/plat-omap/include/mach/cpu.h
+++ b/arch/arm/plat-omap/include/mach/cpu.h
@@ -253,6 +253,7 @@ IS_OMAP_SUBCLASS(343x, 0x343)
  * cpu_is_omap2423():	True for OMAP2423
  * cpu_is_omap2430():	True for OMAP2430
  * cpu_is_omap3430():	True for OMAP3430
+ * cpu_is_omap4430():	True for OMAP4430
  */
 #define GET_OMAP_TYPE	((omap_rev() >> 16) & 0xffff)
 
@@ -385,7 +386,7 @@ IS_OMAP_TYPE(3430, 0x3430)
 #define OMAP3430_REV_ES3_0	0x34303034
 #define OMAP3430_REV_ES3_1	0x34304034
 
-#define OMAP443X_CLASS		0x44300034
+#define OMAP443X_CLASS		0x44300044
 
 /*
  * omap_chip bits
@@ -408,6 +409,7 @@ IS_OMAP_TYPE(3430, 0x3430)
 #define CHIP_IS_OMAP3430ES2		(1 << 4)
 #define CHIP_IS_OMAP3430ES3_0		(1 << 5)
 #define CHIP_IS_OMAP3430ES3_1		(1 << 6)
+#define CHIP_IS_OMAP4430		(1 << 7)
 
 #define CHIP_IS_OMAP24XX		(CHIP_IS_OMAP2420 | CHIP_IS_OMAP2430)
 
diff --git a/arch/arm/plat-omap/include/mach/powerdomain.h b/arch/arm/plat-omap/include/mach/powerdomain.h
index 69c9e67..2742106 100644
--- a/arch/arm/plat-omap/include/mach/powerdomain.h
+++ b/arch/arm/plat-omap/include/mach/powerdomain.h
@@ -46,13 +46,13 @@
  * Number of memory banks that are power-controllable.	On OMAP3430, the
  * maximum is 4.
  */
-#define PWRDM_MAX_MEM_BANKS	4
+#define PWRDM_MAX_MEM_BANKS	5
 
 /*
  * Maximum number of clockdomains that can be associated with a powerdomain.
  * CORE powerdomain on OMAP3 is the worst case
  */
-#define PWRDM_MAX_CLKDMS	4
+#define PWRDM_MAX_CLKDMS	9
 
 /* XXX A completely arbitrary number. What is reasonable here? */
 #define PWRDM_TRANSITION_BAILOUT 100000
-- 
1.5.4.7


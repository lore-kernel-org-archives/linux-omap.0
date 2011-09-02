From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 4/4] OMAP: powerdomain: remove omap_chip bitmasks
Date: Thu, 01 Sep 2011 20:19:21 -0600
Message-ID: <20110902021917.8185.87157.stgit@dusk>
References: <20110902021321.8185.63172.stgit@dusk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:47543 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933123Ab1IBCbp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Sep 2011 22:31:45 -0400
In-Reply-To: <20110902021321.8185.63172.stgit@dusk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

At Tony's request, remove the omap_chip bitmasks from the powerdomain
definitions.  Instead, initialize powerdomains based on one or more
lists that are applicable to a particular SoC family, variant, and
silicon revision.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/io.c                         |    4 +
 arch/arm/mach-omap2/powerdomain-common.c         |    7 +-
 arch/arm/mach-omap2/powerdomain.c                |    3 -
 arch/arm/mach-omap2/powerdomain.h                |    5 +
 arch/arm/mach-omap2/powerdomains2xxx_3xxx_data.c |   19 -----
 arch/arm/mach-omap2/powerdomains2xxx_data.c      |   42 +++++++-----
 arch/arm/mach-omap2/powerdomains3xxx_data.c      |   79 +++++++++++++-=
--------
 arch/arm/mach-omap2/powerdomains44xx_data.c      |   16 ----
 8 files changed, 79 insertions(+), 96 deletions(-)

diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index d098c87..40b6d47 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -341,11 +341,11 @@ void __init omap2_init_common_infrastructure(void=
)
 	u8 postsetup_state;
=20
 	if (cpu_is_omap242x()) {
-		omap2xxx_powerdomains_init();
+		omap242x_powerdomains_init();
 		omap242x_clockdomains_init();
 		omap2420_hwmod_init();
 	} else if (cpu_is_omap243x()) {
-		omap2xxx_powerdomains_init();
+		omap243x_powerdomains_init();
 		omap243x_clockdomains_init();
 		omap2430_hwmod_init();
 	} else if (cpu_is_omap34xx()) {
diff --git a/arch/arm/mach-omap2/powerdomain-common.c b/arch/arm/mach-o=
map2/powerdomain-common.c
index 171fccd..f97afff 100644
--- a/arch/arm/mach-omap2/powerdomain-common.c
+++ b/arch/arm/mach-omap2/powerdomain-common.c
@@ -1,9 +1,8 @@
 /*
- *  linux/arch/arm/mach-omap2/powerdomain-common.c
- *  Contains common powerdomain framework functions
+ * Common powerdomain framework functions
  *
- *  Copyright (C) 2010 Texas Instruments, Inc.
- *  Copyright (C) 2010 Nokia Corporation
+ * Copyright (C) 2010-2011 Texas Instruments, Inc.
+ * Copyright (C) 2010 Nokia Corporation
  *
  * Derived from mach-omap2/powerdomain.c written by Paul Walmsley
  *
diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/po=
werdomain.c
index 3483537..896cb4c 100644
--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -81,9 +81,6 @@ static int _pwrdm_register(struct powerdomain *pwrdm)
 	if (!pwrdm || !pwrdm->name)
 		return -EINVAL;
=20
-	if (!omap_chip_is(pwrdm->omap_chip))
-		return -EINVAL;
-
 	if (cpu_is_omap44xx() &&
 	    pwrdm->prcm_partition =3D=3D OMAP4430_INVALID_PRCM_PARTITION) {
 		pr_err("powerdomain: %s: missing OMAP4 PRCM partition ID\n",
diff --git a/arch/arm/mach-omap2/powerdomain.h b/arch/arm/mach-omap2/po=
werdomain.h
index 489e1c5..8febd84 100644
--- a/arch/arm/mach-omap2/powerdomain.h
+++ b/arch/arm/mach-omap2/powerdomain.h
@@ -78,7 +78,6 @@ struct powerdomain;
 /**
  * struct powerdomain - OMAP powerdomain
  * @name: Powerdomain name
- * @omap_chip: represents the OMAP chip types containing this pwrdm
  * @prcm_offs: the address offset from CM_BASE/PRM_BASE
  * @prcm_partition: (OMAP4 only) the PRCM partition ID containing @prc=
m_offs
  * @pwrsts: Possible powerdomain power states
@@ -98,7 +97,6 @@ struct powerdomain;
  */
 struct powerdomain {
 	const char *name;
-	const struct omap_chip_id omap_chip;
 	const s16 prcm_offs;
 	const u8 pwrsts;
 	const u8 pwrsts_logic_ret;
@@ -212,7 +210,8 @@ int pwrdm_set_lowpwrstchange(struct powerdomain *pw=
rdm);
 u32 pwrdm_get_context_loss_count(struct powerdomain *pwrdm);
 bool pwrdm_can_ever_lose_context(struct powerdomain *pwrdm);
=20
-extern void omap2xxx_powerdomains_init(void);
+extern void omap242x_powerdomains_init(void);
+extern void omap243x_powerdomains_init(void);
 extern void omap3xxx_powerdomains_init(void);
 extern void omap44xx_powerdomains_init(void);
=20
diff --git a/arch/arm/mach-omap2/powerdomains2xxx_3xxx_data.c b/arch/ar=
m/mach-omap2/powerdomains2xxx_3xxx_data.c
index 4210c33..bf30483 100644
--- a/arch/arm/mach-omap2/powerdomains2xxx_3xxx_data.c
+++ b/arch/arm/mach-omap2/powerdomains2xxx_3xxx_data.c
@@ -1,7 +1,7 @@
 /*
  * OMAP2/3 common powerdomain definitions
  *
- * Copyright (C) 2007-2008 Texas Instruments, Inc.
+ * Copyright (C) 2007-2008, 2011 Texas Instruments, Inc.
  * Copyright (C) 2007-2011 Nokia Corporation
  *
  * Paul Walmsley, Jouni H=C3=B6gander
@@ -12,20 +12,6 @@
  */
=20
 /*
- * To Do List
- * -> Move the Sleep/Wakeup dependencies from Power Domain framework t=
o
- *    Clock Domain Framework
- */
-
-/*
- * This file contains all of the powerdomains that have some element
- * of software control for the OMAP24xx and OMAP34xx chips.
- *
- * This is not an exhaustive listing of powerdomains on the chips; onl=
y
- * powerdomains that can be controlled in software.
- */
-
-/*
  * The names for the DSP/IVA2 powerdomains are confusing.
  *
  * Most OMAP chips have an on-board DSP.
@@ -59,8 +45,6 @@
 struct powerdomain gfx_omap2_pwrdm =3D {
 	.name		  =3D "gfx_pwrdm",
 	.prcm_offs	  =3D GFX_MOD,
-	.omap_chip	  =3D OMAP_CHIP_INIT(CHIP_IS_OMAP24XX |
-					   CHIP_IS_OMAP3430ES1),
 	.pwrsts		  =3D PWRSTS_OFF_RET_ON,
 	.pwrsts_logic_ret =3D PWRSTS_RET,
 	.banks		  =3D 1,
@@ -75,6 +59,5 @@ struct powerdomain gfx_omap2_pwrdm =3D {
 struct powerdomain wkup_omap2_pwrdm =3D {
 	.name		=3D "wkup_pwrdm",
 	.prcm_offs	=3D WKUP_MOD,
-	.omap_chip	=3D OMAP_CHIP_INIT(CHIP_IS_OMAP24XX | CHIP_IS_OMAP3430),
 	.pwrsts		=3D PWRSTS_ON,
 };
diff --git a/arch/arm/mach-omap2/powerdomains2xxx_data.c b/arch/arm/mac=
h-omap2/powerdomains2xxx_data.c
index 71c4fd7..bb4394e 100644
--- a/arch/arm/mach-omap2/powerdomains2xxx_data.c
+++ b/arch/arm/mach-omap2/powerdomains2xxx_data.c
@@ -1,7 +1,7 @@
 /*
  * OMAP2XXX powerdomain definitions
  *
- * Copyright (C) 2007-2008 Texas Instruments, Inc.
+ * Copyright (C) 2007-2008, 2011 Texas Instruments, Inc.
  * Copyright (C) 2007-2011 Nokia Corporation
  *
  * Paul Walmsley, Jouni H=C3=B6gander
@@ -28,7 +28,6 @@
 static struct powerdomain dsp_pwrdm =3D {
 	.name		  =3D "dsp_pwrdm",
 	.prcm_offs	  =3D OMAP24XX_DSP_MOD,
-	.omap_chip	  =3D OMAP_CHIP_INIT(CHIP_IS_OMAP24XX),
 	.pwrsts		  =3D PWRSTS_OFF_RET_ON,
 	.pwrsts_logic_ret =3D PWRSTS_RET,
 	.banks		  =3D 1,
@@ -43,7 +42,6 @@ static struct powerdomain dsp_pwrdm =3D {
 static struct powerdomain mpu_24xx_pwrdm =3D {
 	.name		  =3D "mpu_pwrdm",
 	.prcm_offs	  =3D MPU_MOD,
-	.omap_chip	  =3D OMAP_CHIP_INIT(CHIP_IS_OMAP24XX),
 	.pwrsts		  =3D PWRSTS_OFF_RET_ON,
 	.pwrsts_logic_ret =3D PWRSTS_OFF_RET,
 	.banks		  =3D 1,
@@ -58,7 +56,6 @@ static struct powerdomain mpu_24xx_pwrdm =3D {
 static struct powerdomain core_24xx_pwrdm =3D {
 	.name		  =3D "core_pwrdm",
 	.prcm_offs	  =3D CORE_MOD,
-	.omap_chip	  =3D OMAP_CHIP_INIT(CHIP_IS_OMAP24XX),
 	.pwrsts		  =3D PWRSTS_OFF_RET_ON,
 	.banks		  =3D 3,
 	.pwrsts_mem_ret	  =3D {
@@ -78,14 +75,11 @@ static struct powerdomain core_24xx_pwrdm =3D {
  * 2430-specific powerdomains
  */
=20
-#ifdef CONFIG_SOC_OMAP2430
-
 /* XXX 2430 KILLDOMAINWKUP bit?  No current users apparently */
=20
 static struct powerdomain mdm_pwrdm =3D {
 	.name		  =3D "mdm_pwrdm",
 	.prcm_offs	  =3D OMAP2430_MDM_MOD,
-	.omap_chip	  =3D OMAP_CHIP_INIT(CHIP_IS_OMAP2430),
 	.pwrsts		  =3D PWRSTS_OFF_RET_ON,
 	.pwrsts_logic_ret =3D PWRSTS_RET,
 	.banks		  =3D 1,
@@ -97,29 +91,41 @@ static struct powerdomain mdm_pwrdm =3D {
 	},
 };
=20
-#endif     /* CONFIG_SOC_OMAP2430 */
-
-/* As powerdomains are added or removed above, this list must also be =
changed */
-static struct powerdomain *powerdomains_omap2xxx[] __initdata =3D {
+/*
+ *
+ */
=20
+static struct powerdomain *powerdomains_omap24xx[] __initdata =3D {
 	&wkup_omap2_pwrdm,
 	&gfx_omap2_pwrdm,
-
-#ifdef CONFIG_ARCH_OMAP2
 	&dsp_pwrdm,
 	&mpu_24xx_pwrdm,
 	&core_24xx_pwrdm,
-#endif
+	NULL
+};
=20
-#ifdef CONFIG_SOC_OMAP2430
+static struct powerdomain *powerdomains_omap2430[] __initdata =3D {
 	&mdm_pwrdm,
-#endif
 	NULL
 };
=20
-void __init omap2xxx_powerdomains_init(void)
+void __init omap242x_powerdomains_init(void)
 {
+	if (!cpu_is_omap2420())
+		return;
+
+	pwrdm_register_platform_funcs(&omap2_pwrdm_operations);
+	pwrdm_register_pwrdms(powerdomains_omap24xx);
+	pwrdm_complete_init();
+}
+
+void __init omap243x_powerdomains_init(void)
+{
+	if (!cpu_is_omap2430())
+		return;
+
 	pwrdm_register_platform_funcs(&omap2_pwrdm_operations);
-	pwrdm_register_pwrdms(powerdomains_omap2xxx);
+	pwrdm_register_pwrdms(powerdomains_omap24xx);
+	pwrdm_register_pwrdms(powerdomains_omap2430);
 	pwrdm_complete_init();
 }
diff --git a/arch/arm/mach-omap2/powerdomains3xxx_data.c b/arch/arm/mac=
h-omap2/powerdomains3xxx_data.c
index 9d355fc..ea3223c 100644
--- a/arch/arm/mach-omap2/powerdomains3xxx_data.c
+++ b/arch/arm/mach-omap2/powerdomains3xxx_data.c
@@ -1,7 +1,7 @@
 /*
  * OMAP3 powerdomain definitions
  *
- * Copyright (C) 2007-2008 Texas Instruments, Inc.
+ * Copyright (C) 2007-2008, 2011 Texas Instruments, Inc.
  * Copyright (C) 2007-2011 Nokia Corporation
  *
  * Paul Walmsley, Jouni H=C3=B6gander
@@ -14,6 +14,8 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
=20
+#include <plat/cpu.h>
+
 #include "powerdomain.h"
 #include "powerdomains2xxx_3xxx_data.h"
=20
@@ -27,8 +29,6 @@
  * 34XX-specific powerdomains, dependencies
  */
=20
-#ifdef CONFIG_ARCH_OMAP3
-
 /*
  * Powerdomains
  */
@@ -36,7 +36,6 @@
 static struct powerdomain iva2_pwrdm =3D {
 	.name		  =3D "iva2_pwrdm",
 	.prcm_offs	  =3D OMAP3430_IVA2_MOD,
-	.omap_chip	  =3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
 	.pwrsts		  =3D PWRSTS_OFF_RET_ON,
 	.pwrsts_logic_ret =3D PWRSTS_OFF_RET,
 	.banks		  =3D 4,
@@ -57,7 +56,6 @@ static struct powerdomain iva2_pwrdm =3D {
 static struct powerdomain mpu_3xxx_pwrdm =3D {
 	.name		  =3D "mpu_pwrdm",
 	.prcm_offs	  =3D MPU_MOD,
-	.omap_chip	  =3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
 	.pwrsts		  =3D PWRSTS_OFF_RET_ON,
 	.pwrsts_logic_ret =3D PWRSTS_OFF_RET,
 	.flags		  =3D PWRDM_HAS_MPU_QUIRK,
@@ -83,10 +81,6 @@ static struct powerdomain mpu_3xxx_pwrdm =3D {
 static struct powerdomain core_3xxx_pre_es3_1_pwrdm =3D {
 	.name		  =3D "core_pwrdm",
 	.prcm_offs	  =3D CORE_MOD,
-	.omap_chip	  =3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430ES1 |
-					   CHIP_IS_OMAP3430ES2 |
-					   CHIP_IS_OMAP3430ES3_0 |
-					   CHIP_IS_OMAP3630ES1),
 	.pwrsts		  =3D PWRSTS_OFF_RET_ON,
 	.pwrsts_logic_ret =3D PWRSTS_OFF_RET,
 	.banks		  =3D 2,
@@ -103,8 +97,6 @@ static struct powerdomain core_3xxx_pre_es3_1_pwrdm =
=3D {
 static struct powerdomain core_3xxx_es3_1_pwrdm =3D {
 	.name		  =3D "core_pwrdm",
 	.prcm_offs	  =3D CORE_MOD,
-	.omap_chip	  =3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430ES3_1 |
-					  CHIP_GE_OMAP3630ES1_1),
 	.pwrsts		  =3D PWRSTS_OFF_RET_ON,
 	.pwrsts_logic_ret =3D PWRSTS_OFF_RET,
 	/*
@@ -125,7 +117,6 @@ static struct powerdomain core_3xxx_es3_1_pwrdm =3D=
 {
=20
 static struct powerdomain dss_pwrdm =3D {
 	.name		  =3D "dss_pwrdm",
-	.omap_chip	  =3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
 	.prcm_offs	  =3D OMAP3430_DSS_MOD,
 	.pwrsts		  =3D PWRSTS_OFF_RET_ON,
 	.pwrsts_logic_ret =3D PWRSTS_RET,
@@ -146,7 +137,6 @@ static struct powerdomain dss_pwrdm =3D {
 static struct powerdomain sgx_pwrdm =3D {
 	.name		  =3D "sgx_pwrdm",
 	.prcm_offs	  =3D OMAP3430ES2_SGX_MOD,
-	.omap_chip	  =3D OMAP_CHIP_INIT(CHIP_GE_OMAP3430ES2),
 	/* XXX This is accurate for 3430 SGX, but what about GFX? */
 	.pwrsts		  =3D PWRSTS_OFF_ON,
 	.pwrsts_logic_ret =3D PWRSTS_RET,
@@ -161,7 +151,6 @@ static struct powerdomain sgx_pwrdm =3D {
=20
 static struct powerdomain cam_pwrdm =3D {
 	.name		  =3D "cam_pwrdm",
-	.omap_chip	  =3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
 	.prcm_offs	  =3D OMAP3430_CAM_MOD,
 	.pwrsts		  =3D PWRSTS_OFF_RET_ON,
 	.pwrsts_logic_ret =3D PWRSTS_RET,
@@ -177,7 +166,6 @@ static struct powerdomain cam_pwrdm =3D {
 static struct powerdomain per_pwrdm =3D {
 	.name		  =3D "per_pwrdm",
 	.prcm_offs	  =3D OMAP3430_PER_MOD,
-	.omap_chip	  =3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
 	.pwrsts		  =3D PWRSTS_OFF_RET_ON,
 	.pwrsts_logic_ret =3D PWRSTS_OFF_RET,
 	.banks		  =3D 1,
@@ -192,13 +180,11 @@ static struct powerdomain per_pwrdm =3D {
 static struct powerdomain emu_pwrdm =3D {
 	.name		=3D "emu_pwrdm",
 	.prcm_offs	=3D OMAP3430_EMU_MOD,
-	.omap_chip	=3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
 };
=20
 static struct powerdomain neon_pwrdm =3D {
 	.name		  =3D "neon_pwrdm",
 	.prcm_offs	  =3D OMAP3430_NEON_MOD,
-	.omap_chip	  =3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
 	.pwrsts		  =3D PWRSTS_OFF_RET_ON,
 	.pwrsts_logic_ret =3D PWRSTS_RET,
 };
@@ -206,7 +192,6 @@ static struct powerdomain neon_pwrdm =3D {
 static struct powerdomain usbhost_pwrdm =3D {
 	.name		  =3D "usbhost_pwrdm",
 	.prcm_offs	  =3D OMAP3430ES2_USBHOST_MOD,
-	.omap_chip	  =3D OMAP_CHIP_INIT(CHIP_GE_OMAP3430ES2),
 	.pwrsts		  =3D PWRSTS_OFF_RET_ON,
 	.pwrsts_logic_ret =3D PWRSTS_RET,
 	/*
@@ -228,62 +213,92 @@ static struct powerdomain usbhost_pwrdm =3D {
 static struct powerdomain dpll1_pwrdm =3D {
 	.name		=3D "dpll1_pwrdm",
 	.prcm_offs	=3D MPU_MOD,
-	.omap_chip	=3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
 };
=20
 static struct powerdomain dpll2_pwrdm =3D {
 	.name		=3D "dpll2_pwrdm",
 	.prcm_offs	=3D OMAP3430_IVA2_MOD,
-	.omap_chip	=3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
 };
=20
 static struct powerdomain dpll3_pwrdm =3D {
 	.name		=3D "dpll3_pwrdm",
 	.prcm_offs	=3D PLL_MOD,
-	.omap_chip	=3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
 };
=20
 static struct powerdomain dpll4_pwrdm =3D {
 	.name		=3D "dpll4_pwrdm",
 	.prcm_offs	=3D PLL_MOD,
-	.omap_chip	=3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
 };
=20
 static struct powerdomain dpll5_pwrdm =3D {
 	.name		=3D "dpll5_pwrdm",
 	.prcm_offs	=3D PLL_MOD,
-	.omap_chip	=3D OMAP_CHIP_INIT(CHIP_GE_OMAP3430ES2),
 };
=20
 /* As powerdomains are added or removed above, this list must also be =
changed */
-static struct powerdomain *powerdomains_omap3xxx[] __initdata =3D {
-
+static struct powerdomain *powerdomains_omap3430_common[] __initdata =3D=
 {
 	&wkup_omap2_pwrdm,
-	&gfx_omap2_pwrdm,
 	&iva2_pwrdm,
 	&mpu_3xxx_pwrdm,
 	&neon_pwrdm,
-	&core_3xxx_pre_es3_1_pwrdm,
-	&core_3xxx_es3_1_pwrdm,
 	&cam_pwrdm,
 	&dss_pwrdm,
 	&per_pwrdm,
 	&emu_pwrdm,
-	&sgx_pwrdm,
-	&usbhost_pwrdm,
 	&dpll1_pwrdm,
 	&dpll2_pwrdm,
 	&dpll3_pwrdm,
 	&dpll4_pwrdm,
+	NULL
+};
+
+static struct powerdomain *powerdomains_omap3430es1[] __initdata =3D {
+	&gfx_omap2_pwrdm,
+	&core_3xxx_pre_es3_1_pwrdm,
+	NULL
+};
+
+/* also includes 3630ES1.0 */
+static struct powerdomain *powerdomains_omap3430es2_es3_0[] __initdata=
 =3D {
+	&core_3xxx_pre_es3_1_pwrdm,
+	&sgx_pwrdm,
+	&usbhost_pwrdm,
 	&dpll5_pwrdm,
-#endif
 	NULL
 };
=20
+/* also includes 3630ES1.1+ */
+static struct powerdomain *powerdomains_omap3430es3_1plus[] __initdata=
 =3D {
+	&core_3xxx_es3_1_pwrdm,
+	&sgx_pwrdm,
+	&usbhost_pwrdm,
+	&dpll5_pwrdm,
+	NULL
+};
=20
 void __init omap3xxx_powerdomains_init(void)
 {
+	if (!cpu_is_omap3430())
+		return;
+
 	pwrdm_register_platform_funcs(&omap3_pwrdm_operations);
-	pwrdm_register_pwrdms(powerdomains_omap3xxx);
+	pwrdm_register_pwrdms(powerdomains_omap3430_common);
+
+	if (omap_rev() =3D=3D OMAP3430_REV_ES1_0)
+		pwrdm_register_pwrdms(powerdomains_omap3430es1);
+	else if (omap_rev() =3D=3D OMAP3430_REV_ES2_0 ||
+		 omap_rev() =3D=3D OMAP3430_REV_ES2_1 ||
+		 omap_rev() =3D=3D OMAP3430_REV_ES3_0 ||
+		 omap_rev() =3D=3D OMAP3630_REV_ES1_0)
+		pwrdm_register_pwrdms(powerdomains_omap3430es2_es3_0);
+	else if (omap_rev() =3D=3D OMAP3430_REV_ES3_1 ||
+		 omap_rev() =3D=3D OMAP3430_REV_ES3_1_2 ||
+		 omap_rev() & OMAP3505_REV(0) ||
+		 omap_rev() =3D=3D OMAP3630_REV_ES1_1 ||
+		 omap_rev() =3D=3D OMAP3630_REV_ES1_2)
+		pwrdm_register_pwrdms(powerdomains_omap3430es3_1plus);
+	else
+		WARN(1, "OMAP3 powerdomain init: unknown chip type\n");
+
 	pwrdm_complete_init();
 }
diff --git a/arch/arm/mach-omap2/powerdomains44xx_data.c b/arch/arm/mac=
h-omap2/powerdomains44xx_data.c
index 67ac24b..cbce0c9 100644
--- a/arch/arm/mach-omap2/powerdomains44xx_data.c
+++ b/arch/arm/mach-omap2/powerdomains44xx_data.c
@@ -35,7 +35,6 @@ static struct powerdomain core_44xx_pwrdm =3D {
 	.name		  =3D "core_pwrdm",
 	.prcm_offs	  =3D OMAP4430_PRM_CORE_INST,
 	.prcm_partition	  =3D OMAP4430_PRM_PARTITION,
-	.omap_chip	  =3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 	.pwrsts		  =3D PWRSTS_RET_ON,
 	.pwrsts_logic_ret =3D PWRSTS_OFF_RET,
 	.banks		  =3D 5,
@@ -61,7 +60,6 @@ static struct powerdomain gfx_44xx_pwrdm =3D {
 	.name		  =3D "gfx_pwrdm",
 	.prcm_offs	  =3D OMAP4430_PRM_GFX_INST,
 	.prcm_partition	  =3D OMAP4430_PRM_PARTITION,
-	.omap_chip	  =3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 	.pwrsts		  =3D PWRSTS_OFF_ON,
 	.banks		  =3D 1,
 	.pwrsts_mem_ret	=3D {
@@ -78,7 +76,6 @@ static struct powerdomain abe_44xx_pwrdm =3D {
 	.name		  =3D "abe_pwrdm",
 	.prcm_offs	  =3D OMAP4430_PRM_ABE_INST,
 	.prcm_partition	  =3D OMAP4430_PRM_PARTITION,
-	.omap_chip	  =3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 	.pwrsts		  =3D PWRSTS_OFF_RET_ON,
 	.pwrsts_logic_ret =3D PWRSTS_OFF,
 	.banks		  =3D 2,
@@ -98,7 +95,6 @@ static struct powerdomain dss_44xx_pwrdm =3D {
 	.name		  =3D "dss_pwrdm",
 	.prcm_offs	  =3D OMAP4430_PRM_DSS_INST,
 	.prcm_partition	  =3D OMAP4430_PRM_PARTITION,
-	.omap_chip	  =3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 	.pwrsts		  =3D PWRSTS_OFF_RET_ON,
 	.pwrsts_logic_ret =3D PWRSTS_OFF,
 	.banks		  =3D 1,
@@ -116,7 +112,6 @@ static struct powerdomain tesla_44xx_pwrdm =3D {
 	.name		  =3D "tesla_pwrdm",
 	.prcm_offs	  =3D OMAP4430_PRM_TESLA_INST,
 	.prcm_partition	  =3D OMAP4430_PRM_PARTITION,
-	.omap_chip	  =3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 	.pwrsts		  =3D PWRSTS_OFF_RET_ON,
 	.pwrsts_logic_ret =3D PWRSTS_OFF_RET,
 	.banks		  =3D 3,
@@ -138,7 +133,6 @@ static struct powerdomain wkup_44xx_pwrdm =3D {
 	.name		  =3D "wkup_pwrdm",
 	.prcm_offs	  =3D OMAP4430_PRM_WKUP_INST,
 	.prcm_partition	  =3D OMAP4430_PRM_PARTITION,
-	.omap_chip	  =3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 	.pwrsts		  =3D PWRSTS_ON,
 	.banks		  =3D 1,
 	.pwrsts_mem_ret	=3D {
@@ -154,7 +148,6 @@ static struct powerdomain cpu0_44xx_pwrdm =3D {
 	.name		  =3D "cpu0_pwrdm",
 	.prcm_offs	  =3D OMAP4430_PRCM_MPU_CPU0_INST,
 	.prcm_partition	  =3D OMAP4430_PRCM_MPU_PARTITION,
-	.omap_chip	  =3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 	.pwrsts		  =3D PWRSTS_OFF_RET_ON,
 	.pwrsts_logic_ret =3D PWRSTS_OFF_RET,
 	.banks		  =3D 1,
@@ -171,7 +164,6 @@ static struct powerdomain cpu1_44xx_pwrdm =3D {
 	.name		  =3D "cpu1_pwrdm",
 	.prcm_offs	  =3D OMAP4430_PRCM_MPU_CPU1_INST,
 	.prcm_partition	  =3D OMAP4430_PRCM_MPU_PARTITION,
-	.omap_chip	  =3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 	.pwrsts		  =3D PWRSTS_OFF_RET_ON,
 	.pwrsts_logic_ret =3D PWRSTS_OFF_RET,
 	.banks		  =3D 1,
@@ -188,7 +180,6 @@ static struct powerdomain emu_44xx_pwrdm =3D {
 	.name		  =3D "emu_pwrdm",
 	.prcm_offs	  =3D OMAP4430_PRM_EMU_INST,
 	.prcm_partition	  =3D OMAP4430_PRM_PARTITION,
-	.omap_chip	  =3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 	.pwrsts		  =3D PWRSTS_OFF_ON,
 	.banks		  =3D 1,
 	.pwrsts_mem_ret	=3D {
@@ -204,7 +195,6 @@ static struct powerdomain mpu_44xx_pwrdm =3D {
 	.name		  =3D "mpu_pwrdm",
 	.prcm_offs	  =3D OMAP4430_PRM_MPU_INST,
 	.prcm_partition	  =3D OMAP4430_PRM_PARTITION,
-	.omap_chip	  =3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 	.pwrsts		  =3D PWRSTS_RET_ON,
 	.pwrsts_logic_ret =3D PWRSTS_OFF_RET,
 	.banks		  =3D 3,
@@ -225,7 +215,6 @@ static struct powerdomain ivahd_44xx_pwrdm =3D {
 	.name		  =3D "ivahd_pwrdm",
 	.prcm_offs	  =3D OMAP4430_PRM_IVAHD_INST,
 	.prcm_partition	  =3D OMAP4430_PRM_PARTITION,
-	.omap_chip	  =3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 	.pwrsts		  =3D PWRSTS_OFF_RET_ON,
 	.pwrsts_logic_ret =3D PWRSTS_OFF,
 	.banks		  =3D 4,
@@ -249,7 +238,6 @@ static struct powerdomain cam_44xx_pwrdm =3D {
 	.name		  =3D "cam_pwrdm",
 	.prcm_offs	  =3D OMAP4430_PRM_CAM_INST,
 	.prcm_partition	  =3D OMAP4430_PRM_PARTITION,
-	.omap_chip	  =3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 	.pwrsts		  =3D PWRSTS_OFF_ON,
 	.banks		  =3D 1,
 	.pwrsts_mem_ret	=3D {
@@ -266,7 +254,6 @@ static struct powerdomain l3init_44xx_pwrdm =3D {
 	.name		  =3D "l3init_pwrdm",
 	.prcm_offs	  =3D OMAP4430_PRM_L3INIT_INST,
 	.prcm_partition	  =3D OMAP4430_PRM_PARTITION,
-	.omap_chip	  =3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 	.pwrsts		  =3D PWRSTS_RET_ON,
 	.pwrsts_logic_ret =3D PWRSTS_OFF_RET,
 	.banks		  =3D 1,
@@ -284,7 +271,6 @@ static struct powerdomain l4per_44xx_pwrdm =3D {
 	.name		  =3D "l4per_pwrdm",
 	.prcm_offs	  =3D OMAP4430_PRM_L4PER_INST,
 	.prcm_partition	  =3D OMAP4430_PRM_PARTITION,
-	.omap_chip	  =3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 	.pwrsts		  =3D PWRSTS_RET_ON,
 	.pwrsts_logic_ret =3D PWRSTS_OFF_RET,
 	.banks		  =3D 2,
@@ -307,7 +293,6 @@ static struct powerdomain always_on_core_44xx_pwrdm=
 =3D {
 	.name		  =3D "always_on_core_pwrdm",
 	.prcm_offs	  =3D OMAP4430_PRM_ALWAYS_ON_INST,
 	.prcm_partition	  =3D OMAP4430_PRM_PARTITION,
-	.omap_chip	  =3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 	.pwrsts		  =3D PWRSTS_ON,
 };
=20
@@ -316,7 +301,6 @@ static struct powerdomain cefuse_44xx_pwrdm =3D {
 	.name		  =3D "cefuse_pwrdm",
 	.prcm_offs	  =3D OMAP4430_PRM_CEFUSE_INST,
 	.prcm_partition	  =3D OMAP4430_PRM_PARTITION,
-	.omap_chip	  =3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 	.pwrsts		  =3D PWRSTS_OFF_ON,
 	.flags		  =3D PWRDM_HAS_LOWPOWERSTATECHANGE,
 };


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 4/4] OMAP: powerdomain: remove omap_chip bitmasks
Date: Sun, 4 Sep 2011 19:50:36 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1109041949280.9056@utopia.booyaka.com>
References: <20110902021321.8185.63172.stgit@dusk> <20110902021917.8185.87157.stgit@dusk>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-369907839-1315187436=:9056"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:46148 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754047Ab1IEBuh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 4 Sep 2011 21:50:37 -0400
In-Reply-To: <20110902021917.8185.87157.stgit@dusk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-369907839-1315187436=:9056
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 1 Sep 2011, Paul Walmsley wrote:

> At Tony's request, remove the omap_chip bitmasks from the powerdomain
> definitions.  Instead, initialize powerdomains based on one or more
> lists that are applicable to a particular SoC family, variant, and
> silicon revision.
>=20
> Signed-off-by: Paul Walmsley <paul@pwsan.com>

This patch had a similar problem; it didn't work as intended on OMAP3
chips that weren't OMAP34xx.  Updated version below.  The git branch
has been updated.


- Paul

From: Paul Walmsley <paul@pwsan.com>
Date: Thu, 1 Sep 2011 20:08:25 -0600
Subject: [PATCH] OMAP: powerdomain: remove omap_chip bitmasks

At Tony's request, remove the omap_chip bitmasks from the powerdomain
definitions.  Instead, initialize powerdomains based on one or more
lists that are applicable to a particular SoC family, variant, and
silicon revision.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/io.c                         |    4 +-
 arch/arm/mach-omap2/powerdomain-common.c         |    7 +-
 arch/arm/mach-omap2/powerdomain.c                |    3 -
 arch/arm/mach-omap2/powerdomain.h                |    5 +-
 arch/arm/mach-omap2/powerdomains2xxx_3xxx_data.c |   19 +-----
 arch/arm/mach-omap2/powerdomains2xxx_data.c      |   42 +++++++-----
 arch/arm/mach-omap2/powerdomains3xxx_data.c      |   79 +++++++++++++-----=
----
 arch/arm/mach-omap2/powerdomains44xx_data.c      |   16 -----
 8 files changed, 79 insertions(+), 96 deletions(-)

diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index d098c87..40b6d47 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -341,11 +341,11 @@ void __init omap2_init_common_infrastructure(void)
 =09u8 postsetup_state;
=20
 =09if (cpu_is_omap242x()) {
-=09=09omap2xxx_powerdomains_init();
+=09=09omap242x_powerdomains_init();
 =09=09omap242x_clockdomains_init();
 =09=09omap2420_hwmod_init();
 =09} else if (cpu_is_omap243x()) {
-=09=09omap2xxx_powerdomains_init();
+=09=09omap243x_powerdomains_init();
 =09=09omap243x_clockdomains_init();
 =09=09omap2430_hwmod_init();
 =09} else if (cpu_is_omap34xx()) {
diff --git a/arch/arm/mach-omap2/powerdomain-common.c b/arch/arm/mach-omap2=
/powerdomain-common.c
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
diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerd=
omain.c
index 3483537..896cb4c 100644
--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -81,9 +81,6 @@ static int _pwrdm_register(struct powerdomain *pwrdm)
 =09if (!pwrdm || !pwrdm->name)
 =09=09return -EINVAL;
=20
-=09if (!omap_chip_is(pwrdm->omap_chip))
-=09=09return -EINVAL;
-
 =09if (cpu_is_omap44xx() &&
 =09    pwrdm->prcm_partition =3D=3D OMAP4430_INVALID_PRCM_PARTITION) {
 =09=09pr_err("powerdomain: %s: missing OMAP4 PRCM partition ID\n",
diff --git a/arch/arm/mach-omap2/powerdomain.h b/arch/arm/mach-omap2/powerd=
omain.h
index 489e1c5..8febd84 100644
--- a/arch/arm/mach-omap2/powerdomain.h
+++ b/arch/arm/mach-omap2/powerdomain.h
@@ -78,7 +78,6 @@ struct powerdomain;
 /**
  * struct powerdomain - OMAP powerdomain
  * @name: Powerdomain name
- * @omap_chip: represents the OMAP chip types containing this pwrdm
  * @prcm_offs: the address offset from CM_BASE/PRM_BASE
  * @prcm_partition: (OMAP4 only) the PRCM partition ID containing @prcm_of=
fs
  * @pwrsts: Possible powerdomain power states
@@ -98,7 +97,6 @@ struct powerdomain;
  */
 struct powerdomain {
 =09const char *name;
-=09const struct omap_chip_id omap_chip;
 =09const s16 prcm_offs;
 =09const u8 pwrsts;
 =09const u8 pwrsts_logic_ret;
@@ -212,7 +210,8 @@ int pwrdm_set_lowpwrstchange(struct powerdomain *pwrdm)=
;
 u32 pwrdm_get_context_loss_count(struct powerdomain *pwrdm);
 bool pwrdm_can_ever_lose_context(struct powerdomain *pwrdm);
=20
-extern void omap2xxx_powerdomains_init(void);
+extern void omap242x_powerdomains_init(void);
+extern void omap243x_powerdomains_init(void);
 extern void omap3xxx_powerdomains_init(void);
 extern void omap44xx_powerdomains_init(void);
=20
diff --git a/arch/arm/mach-omap2/powerdomains2xxx_3xxx_data.c b/arch/arm/ma=
ch-omap2/powerdomains2xxx_3xxx_data.c
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
- * -> Move the Sleep/Wakeup dependencies from Power Domain framework to
- *    Clock Domain Framework
- */
-
-/*
- * This file contains all of the powerdomains that have some element
- * of software control for the OMAP24xx and OMAP34xx chips.
- *
- * This is not an exhaustive listing of powerdomains on the chips; only
- * powerdomains that can be controlled in software.
- */
-
-/*
  * The names for the DSP/IVA2 powerdomains are confusing.
  *
  * Most OMAP chips have an on-board DSP.
@@ -59,8 +45,6 @@
 struct powerdomain gfx_omap2_pwrdm =3D {
 =09.name=09=09  =3D "gfx_pwrdm",
 =09.prcm_offs=09  =3D GFX_MOD,
-=09.omap_chip=09  =3D OMAP_CHIP_INIT(CHIP_IS_OMAP24XX |
-=09=09=09=09=09   CHIP_IS_OMAP3430ES1),
 =09.pwrsts=09=09  =3D PWRSTS_OFF_RET_ON,
 =09.pwrsts_logic_ret =3D PWRSTS_RET,
 =09.banks=09=09  =3D 1,
@@ -75,6 +59,5 @@ struct powerdomain gfx_omap2_pwrdm =3D {
 struct powerdomain wkup_omap2_pwrdm =3D {
 =09.name=09=09=3D "wkup_pwrdm",
 =09.prcm_offs=09=3D WKUP_MOD,
-=09.omap_chip=09=3D OMAP_CHIP_INIT(CHIP_IS_OMAP24XX | CHIP_IS_OMAP3430),
 =09.pwrsts=09=09=3D PWRSTS_ON,
 };
diff --git a/arch/arm/mach-omap2/powerdomains2xxx_data.c b/arch/arm/mach-om=
ap2/powerdomains2xxx_data.c
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
 =09.name=09=09  =3D "dsp_pwrdm",
 =09.prcm_offs=09  =3D OMAP24XX_DSP_MOD,
-=09.omap_chip=09  =3D OMAP_CHIP_INIT(CHIP_IS_OMAP24XX),
 =09.pwrsts=09=09  =3D PWRSTS_OFF_RET_ON,
 =09.pwrsts_logic_ret =3D PWRSTS_RET,
 =09.banks=09=09  =3D 1,
@@ -43,7 +42,6 @@ static struct powerdomain dsp_pwrdm =3D {
 static struct powerdomain mpu_24xx_pwrdm =3D {
 =09.name=09=09  =3D "mpu_pwrdm",
 =09.prcm_offs=09  =3D MPU_MOD,
-=09.omap_chip=09  =3D OMAP_CHIP_INIT(CHIP_IS_OMAP24XX),
 =09.pwrsts=09=09  =3D PWRSTS_OFF_RET_ON,
 =09.pwrsts_logic_ret =3D PWRSTS_OFF_RET,
 =09.banks=09=09  =3D 1,
@@ -58,7 +56,6 @@ static struct powerdomain mpu_24xx_pwrdm =3D {
 static struct powerdomain core_24xx_pwrdm =3D {
 =09.name=09=09  =3D "core_pwrdm",
 =09.prcm_offs=09  =3D CORE_MOD,
-=09.omap_chip=09  =3D OMAP_CHIP_INIT(CHIP_IS_OMAP24XX),
 =09.pwrsts=09=09  =3D PWRSTS_OFF_RET_ON,
 =09.banks=09=09  =3D 3,
 =09.pwrsts_mem_ret=09  =3D {
@@ -78,14 +75,11 @@ static struct powerdomain core_24xx_pwrdm =3D {
  * 2430-specific powerdomains
  */
=20
-#ifdef CONFIG_SOC_OMAP2430
-
 /* XXX 2430 KILLDOMAINWKUP bit?  No current users apparently */
=20
 static struct powerdomain mdm_pwrdm =3D {
 =09.name=09=09  =3D "mdm_pwrdm",
 =09.prcm_offs=09  =3D OMAP2430_MDM_MOD,
-=09.omap_chip=09  =3D OMAP_CHIP_INIT(CHIP_IS_OMAP2430),
 =09.pwrsts=09=09  =3D PWRSTS_OFF_RET_ON,
 =09.pwrsts_logic_ret =3D PWRSTS_RET,
 =09.banks=09=09  =3D 1,
@@ -97,29 +91,41 @@ static struct powerdomain mdm_pwrdm =3D {
 =09},
 };
=20
-#endif     /* CONFIG_SOC_OMAP2430 */
-
-/* As powerdomains are added or removed above, this list must also be chan=
ged */
-static struct powerdomain *powerdomains_omap2xxx[] __initdata =3D {
+/*
+ *
+ */
=20
+static struct powerdomain *powerdomains_omap24xx[] __initdata =3D {
 =09&wkup_omap2_pwrdm,
 =09&gfx_omap2_pwrdm,
-
-#ifdef CONFIG_ARCH_OMAP2
 =09&dsp_pwrdm,
 =09&mpu_24xx_pwrdm,
 =09&core_24xx_pwrdm,
-#endif
+=09NULL
+};
=20
-#ifdef CONFIG_SOC_OMAP2430
+static struct powerdomain *powerdomains_omap2430[] __initdata =3D {
 =09&mdm_pwrdm,
-#endif
 =09NULL
 };
=20
-void __init omap2xxx_powerdomains_init(void)
+void __init omap242x_powerdomains_init(void)
 {
+=09if (!cpu_is_omap2420())
+=09=09return;
+
+=09pwrdm_register_platform_funcs(&omap2_pwrdm_operations);
+=09pwrdm_register_pwrdms(powerdomains_omap24xx);
+=09pwrdm_complete_init();
+}
+
+void __init omap243x_powerdomains_init(void)
+{
+=09if (!cpu_is_omap2430())
+=09=09return;
+
 =09pwrdm_register_platform_funcs(&omap2_pwrdm_operations);
-=09pwrdm_register_pwrdms(powerdomains_omap2xxx);
+=09pwrdm_register_pwrdms(powerdomains_omap24xx);
+=09pwrdm_register_pwrdms(powerdomains_omap2430);
 =09pwrdm_complete_init();
 }
diff --git a/arch/arm/mach-omap2/powerdomains3xxx_data.c b/arch/arm/mach-om=
ap2/powerdomains3xxx_data.c
index 9d355fc..219f770 100644
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
 =09.name=09=09  =3D "iva2_pwrdm",
 =09.prcm_offs=09  =3D OMAP3430_IVA2_MOD,
-=09.omap_chip=09  =3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
 =09.pwrsts=09=09  =3D PWRSTS_OFF_RET_ON,
 =09.pwrsts_logic_ret =3D PWRSTS_OFF_RET,
 =09.banks=09=09  =3D 4,
@@ -57,7 +56,6 @@ static struct powerdomain iva2_pwrdm =3D {
 static struct powerdomain mpu_3xxx_pwrdm =3D {
 =09.name=09=09  =3D "mpu_pwrdm",
 =09.prcm_offs=09  =3D MPU_MOD,
-=09.omap_chip=09  =3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
 =09.pwrsts=09=09  =3D PWRSTS_OFF_RET_ON,
 =09.pwrsts_logic_ret =3D PWRSTS_OFF_RET,
 =09.flags=09=09  =3D PWRDM_HAS_MPU_QUIRK,
@@ -83,10 +81,6 @@ static struct powerdomain mpu_3xxx_pwrdm =3D {
 static struct powerdomain core_3xxx_pre_es3_1_pwrdm =3D {
 =09.name=09=09  =3D "core_pwrdm",
 =09.prcm_offs=09  =3D CORE_MOD,
-=09.omap_chip=09  =3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430ES1 |
-=09=09=09=09=09   CHIP_IS_OMAP3430ES2 |
-=09=09=09=09=09   CHIP_IS_OMAP3430ES3_0 |
-=09=09=09=09=09   CHIP_IS_OMAP3630ES1),
 =09.pwrsts=09=09  =3D PWRSTS_OFF_RET_ON,
 =09.pwrsts_logic_ret =3D PWRSTS_OFF_RET,
 =09.banks=09=09  =3D 2,
@@ -103,8 +97,6 @@ static struct powerdomain core_3xxx_pre_es3_1_pwrdm =3D =
{
 static struct powerdomain core_3xxx_es3_1_pwrdm =3D {
 =09.name=09=09  =3D "core_pwrdm",
 =09.prcm_offs=09  =3D CORE_MOD,
-=09.omap_chip=09  =3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430ES3_1 |
-=09=09=09=09=09  CHIP_GE_OMAP3630ES1_1),
 =09.pwrsts=09=09  =3D PWRSTS_OFF_RET_ON,
 =09.pwrsts_logic_ret =3D PWRSTS_OFF_RET,
 =09/*
@@ -125,7 +117,6 @@ static struct powerdomain core_3xxx_es3_1_pwrdm =3D {
=20
 static struct powerdomain dss_pwrdm =3D {
 =09.name=09=09  =3D "dss_pwrdm",
-=09.omap_chip=09  =3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
 =09.prcm_offs=09  =3D OMAP3430_DSS_MOD,
 =09.pwrsts=09=09  =3D PWRSTS_OFF_RET_ON,
 =09.pwrsts_logic_ret =3D PWRSTS_RET,
@@ -146,7 +137,6 @@ static struct powerdomain dss_pwrdm =3D {
 static struct powerdomain sgx_pwrdm =3D {
 =09.name=09=09  =3D "sgx_pwrdm",
 =09.prcm_offs=09  =3D OMAP3430ES2_SGX_MOD,
-=09.omap_chip=09  =3D OMAP_CHIP_INIT(CHIP_GE_OMAP3430ES2),
 =09/* XXX This is accurate for 3430 SGX, but what about GFX? */
 =09.pwrsts=09=09  =3D PWRSTS_OFF_ON,
 =09.pwrsts_logic_ret =3D PWRSTS_RET,
@@ -161,7 +151,6 @@ static struct powerdomain sgx_pwrdm =3D {
=20
 static struct powerdomain cam_pwrdm =3D {
 =09.name=09=09  =3D "cam_pwrdm",
-=09.omap_chip=09  =3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
 =09.prcm_offs=09  =3D OMAP3430_CAM_MOD,
 =09.pwrsts=09=09  =3D PWRSTS_OFF_RET_ON,
 =09.pwrsts_logic_ret =3D PWRSTS_RET,
@@ -177,7 +166,6 @@ static struct powerdomain cam_pwrdm =3D {
 static struct powerdomain per_pwrdm =3D {
 =09.name=09=09  =3D "per_pwrdm",
 =09.prcm_offs=09  =3D OMAP3430_PER_MOD,
-=09.omap_chip=09  =3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
 =09.pwrsts=09=09  =3D PWRSTS_OFF_RET_ON,
 =09.pwrsts_logic_ret =3D PWRSTS_OFF_RET,
 =09.banks=09=09  =3D 1,
@@ -192,13 +180,11 @@ static struct powerdomain per_pwrdm =3D {
 static struct powerdomain emu_pwrdm =3D {
 =09.name=09=09=3D "emu_pwrdm",
 =09.prcm_offs=09=3D OMAP3430_EMU_MOD,
-=09.omap_chip=09=3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
 };
=20
 static struct powerdomain neon_pwrdm =3D {
 =09.name=09=09  =3D "neon_pwrdm",
 =09.prcm_offs=09  =3D OMAP3430_NEON_MOD,
-=09.omap_chip=09  =3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
 =09.pwrsts=09=09  =3D PWRSTS_OFF_RET_ON,
 =09.pwrsts_logic_ret =3D PWRSTS_RET,
 };
@@ -206,7 +192,6 @@ static struct powerdomain neon_pwrdm =3D {
 static struct powerdomain usbhost_pwrdm =3D {
 =09.name=09=09  =3D "usbhost_pwrdm",
 =09.prcm_offs=09  =3D OMAP3430ES2_USBHOST_MOD,
-=09.omap_chip=09  =3D OMAP_CHIP_INIT(CHIP_GE_OMAP3430ES2),
 =09.pwrsts=09=09  =3D PWRSTS_OFF_RET_ON,
 =09.pwrsts_logic_ret =3D PWRSTS_RET,
 =09/*
@@ -228,62 +213,92 @@ static struct powerdomain usbhost_pwrdm =3D {
 static struct powerdomain dpll1_pwrdm =3D {
 =09.name=09=09=3D "dpll1_pwrdm",
 =09.prcm_offs=09=3D MPU_MOD,
-=09.omap_chip=09=3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
 };
=20
 static struct powerdomain dpll2_pwrdm =3D {
 =09.name=09=09=3D "dpll2_pwrdm",
 =09.prcm_offs=09=3D OMAP3430_IVA2_MOD,
-=09.omap_chip=09=3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
 };
=20
 static struct powerdomain dpll3_pwrdm =3D {
 =09.name=09=09=3D "dpll3_pwrdm",
 =09.prcm_offs=09=3D PLL_MOD,
-=09.omap_chip=09=3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
 };
=20
 static struct powerdomain dpll4_pwrdm =3D {
 =09.name=09=09=3D "dpll4_pwrdm",
 =09.prcm_offs=09=3D PLL_MOD,
-=09.omap_chip=09=3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
 };
=20
 static struct powerdomain dpll5_pwrdm =3D {
 =09.name=09=09=3D "dpll5_pwrdm",
 =09.prcm_offs=09=3D PLL_MOD,
-=09.omap_chip=09=3D OMAP_CHIP_INIT(CHIP_GE_OMAP3430ES2),
 };
=20
 /* As powerdomains are added or removed above, this list must also be chan=
ged */
-static struct powerdomain *powerdomains_omap3xxx[] __initdata =3D {
-
+static struct powerdomain *powerdomains_omap3430_common[] __initdata =3D {
 =09&wkup_omap2_pwrdm,
-=09&gfx_omap2_pwrdm,
 =09&iva2_pwrdm,
 =09&mpu_3xxx_pwrdm,
 =09&neon_pwrdm,
-=09&core_3xxx_pre_es3_1_pwrdm,
-=09&core_3xxx_es3_1_pwrdm,
 =09&cam_pwrdm,
 =09&dss_pwrdm,
 =09&per_pwrdm,
 =09&emu_pwrdm,
-=09&sgx_pwrdm,
-=09&usbhost_pwrdm,
 =09&dpll1_pwrdm,
 =09&dpll2_pwrdm,
 =09&dpll3_pwrdm,
 =09&dpll4_pwrdm,
+=09NULL
+};
+
+static struct powerdomain *powerdomains_omap3430es1[] __initdata =3D {
+=09&gfx_omap2_pwrdm,
+=09&core_3xxx_pre_es3_1_pwrdm,
+=09NULL
+};
+
+/* also includes 3630ES1.0 */
+static struct powerdomain *powerdomains_omap3430es2_es3_0[] __initdata =3D=
 {
+=09&core_3xxx_pre_es3_1_pwrdm,
+=09&sgx_pwrdm,
+=09&usbhost_pwrdm,
 =09&dpll5_pwrdm,
-#endif
 =09NULL
 };
=20
+/* also includes 3630ES1.1+ */
+static struct powerdomain *powerdomains_omap3430es3_1plus[] __initdata =3D=
 {
+=09&core_3xxx_es3_1_pwrdm,
+=09&sgx_pwrdm,
+=09&usbhost_pwrdm,
+=09&dpll5_pwrdm,
+=09NULL
+};
=20
 void __init omap3xxx_powerdomains_init(void)
 {
+=09if (!cpu_is_omap34xx())
+=09=09return;
+
 =09pwrdm_register_platform_funcs(&omap3_pwrdm_operations);
-=09pwrdm_register_pwrdms(powerdomains_omap3xxx);
+=09pwrdm_register_pwrdms(powerdomains_omap3430_common);
+
+=09if (omap_rev() =3D=3D OMAP3430_REV_ES1_0)
+=09=09pwrdm_register_pwrdms(powerdomains_omap3430es1);
+=09else if (omap_rev() =3D=3D OMAP3430_REV_ES2_0 ||
+=09=09 omap_rev() =3D=3D OMAP3430_REV_ES2_1 ||
+=09=09 omap_rev() =3D=3D OMAP3430_REV_ES3_0 ||
+=09=09 omap_rev() =3D=3D OMAP3630_REV_ES1_0)
+=09=09pwrdm_register_pwrdms(powerdomains_omap3430es2_es3_0);
+=09else if (omap_rev() =3D=3D OMAP3430_REV_ES3_1 ||
+=09=09 omap_rev() =3D=3D OMAP3430_REV_ES3_1_2 ||
+=09=09 omap_rev() & OMAP3505_REV(0) ||
+=09=09 omap_rev() =3D=3D OMAP3630_REV_ES1_1 ||
+=09=09 omap_rev() =3D=3D OMAP3630_REV_ES1_2)
+=09=09pwrdm_register_pwrdms(powerdomains_omap3430es3_1plus);
+=09else
+=09=09WARN(1, "OMAP3 powerdomain init: unknown chip type\n");
+
 =09pwrdm_complete_init();
 }
diff --git a/arch/arm/mach-omap2/powerdomains44xx_data.c b/arch/arm/mach-om=
ap2/powerdomains44xx_data.c
index 67ac24b..cbce0c9 100644
--- a/arch/arm/mach-omap2/powerdomains44xx_data.c
+++ b/arch/arm/mach-omap2/powerdomains44xx_data.c
@@ -35,7 +35,6 @@ static struct powerdomain core_44xx_pwrdm =3D {
 =09.name=09=09  =3D "core_pwrdm",
 =09.prcm_offs=09  =3D OMAP4430_PRM_CORE_INST,
 =09.prcm_partition=09  =3D OMAP4430_PRM_PARTITION,
-=09.omap_chip=09  =3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 =09.pwrsts=09=09  =3D PWRSTS_RET_ON,
 =09.pwrsts_logic_ret =3D PWRSTS_OFF_RET,
 =09.banks=09=09  =3D 5,
@@ -61,7 +60,6 @@ static struct powerdomain gfx_44xx_pwrdm =3D {
 =09.name=09=09  =3D "gfx_pwrdm",
 =09.prcm_offs=09  =3D OMAP4430_PRM_GFX_INST,
 =09.prcm_partition=09  =3D OMAP4430_PRM_PARTITION,
-=09.omap_chip=09  =3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 =09.pwrsts=09=09  =3D PWRSTS_OFF_ON,
 =09.banks=09=09  =3D 1,
 =09.pwrsts_mem_ret=09=3D {
@@ -78,7 +76,6 @@ static struct powerdomain abe_44xx_pwrdm =3D {
 =09.name=09=09  =3D "abe_pwrdm",
 =09.prcm_offs=09  =3D OMAP4430_PRM_ABE_INST,
 =09.prcm_partition=09  =3D OMAP4430_PRM_PARTITION,
-=09.omap_chip=09  =3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 =09.pwrsts=09=09  =3D PWRSTS_OFF_RET_ON,
 =09.pwrsts_logic_ret =3D PWRSTS_OFF,
 =09.banks=09=09  =3D 2,
@@ -98,7 +95,6 @@ static struct powerdomain dss_44xx_pwrdm =3D {
 =09.name=09=09  =3D "dss_pwrdm",
 =09.prcm_offs=09  =3D OMAP4430_PRM_DSS_INST,
 =09.prcm_partition=09  =3D OMAP4430_PRM_PARTITION,
-=09.omap_chip=09  =3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 =09.pwrsts=09=09  =3D PWRSTS_OFF_RET_ON,
 =09.pwrsts_logic_ret =3D PWRSTS_OFF,
 =09.banks=09=09  =3D 1,
@@ -116,7 +112,6 @@ static struct powerdomain tesla_44xx_pwrdm =3D {
 =09.name=09=09  =3D "tesla_pwrdm",
 =09.prcm_offs=09  =3D OMAP4430_PRM_TESLA_INST,
 =09.prcm_partition=09  =3D OMAP4430_PRM_PARTITION,
-=09.omap_chip=09  =3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 =09.pwrsts=09=09  =3D PWRSTS_OFF_RET_ON,
 =09.pwrsts_logic_ret =3D PWRSTS_OFF_RET,
 =09.banks=09=09  =3D 3,
@@ -138,7 +133,6 @@ static struct powerdomain wkup_44xx_pwrdm =3D {
 =09.name=09=09  =3D "wkup_pwrdm",
 =09.prcm_offs=09  =3D OMAP4430_PRM_WKUP_INST,
 =09.prcm_partition=09  =3D OMAP4430_PRM_PARTITION,
-=09.omap_chip=09  =3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 =09.pwrsts=09=09  =3D PWRSTS_ON,
 =09.banks=09=09  =3D 1,
 =09.pwrsts_mem_ret=09=3D {
@@ -154,7 +148,6 @@ static struct powerdomain cpu0_44xx_pwrdm =3D {
 =09.name=09=09  =3D "cpu0_pwrdm",
 =09.prcm_offs=09  =3D OMAP4430_PRCM_MPU_CPU0_INST,
 =09.prcm_partition=09  =3D OMAP4430_PRCM_MPU_PARTITION,
-=09.omap_chip=09  =3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 =09.pwrsts=09=09  =3D PWRSTS_OFF_RET_ON,
 =09.pwrsts_logic_ret =3D PWRSTS_OFF_RET,
 =09.banks=09=09  =3D 1,
@@ -171,7 +164,6 @@ static struct powerdomain cpu1_44xx_pwrdm =3D {
 =09.name=09=09  =3D "cpu1_pwrdm",
 =09.prcm_offs=09  =3D OMAP4430_PRCM_MPU_CPU1_INST,
 =09.prcm_partition=09  =3D OMAP4430_PRCM_MPU_PARTITION,
-=09.omap_chip=09  =3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 =09.pwrsts=09=09  =3D PWRSTS_OFF_RET_ON,
 =09.pwrsts_logic_ret =3D PWRSTS_OFF_RET,
 =09.banks=09=09  =3D 1,
@@ -188,7 +180,6 @@ static struct powerdomain emu_44xx_pwrdm =3D {
 =09.name=09=09  =3D "emu_pwrdm",
 =09.prcm_offs=09  =3D OMAP4430_PRM_EMU_INST,
 =09.prcm_partition=09  =3D OMAP4430_PRM_PARTITION,
-=09.omap_chip=09  =3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 =09.pwrsts=09=09  =3D PWRSTS_OFF_ON,
 =09.banks=09=09  =3D 1,
 =09.pwrsts_mem_ret=09=3D {
@@ -204,7 +195,6 @@ static struct powerdomain mpu_44xx_pwrdm =3D {
 =09.name=09=09  =3D "mpu_pwrdm",
 =09.prcm_offs=09  =3D OMAP4430_PRM_MPU_INST,
 =09.prcm_partition=09  =3D OMAP4430_PRM_PARTITION,
-=09.omap_chip=09  =3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 =09.pwrsts=09=09  =3D PWRSTS_RET_ON,
 =09.pwrsts_logic_ret =3D PWRSTS_OFF_RET,
 =09.banks=09=09  =3D 3,
@@ -225,7 +215,6 @@ static struct powerdomain ivahd_44xx_pwrdm =3D {
 =09.name=09=09  =3D "ivahd_pwrdm",
 =09.prcm_offs=09  =3D OMAP4430_PRM_IVAHD_INST,
 =09.prcm_partition=09  =3D OMAP4430_PRM_PARTITION,
-=09.omap_chip=09  =3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 =09.pwrsts=09=09  =3D PWRSTS_OFF_RET_ON,
 =09.pwrsts_logic_ret =3D PWRSTS_OFF,
 =09.banks=09=09  =3D 4,
@@ -249,7 +238,6 @@ static struct powerdomain cam_44xx_pwrdm =3D {
 =09.name=09=09  =3D "cam_pwrdm",
 =09.prcm_offs=09  =3D OMAP4430_PRM_CAM_INST,
 =09.prcm_partition=09  =3D OMAP4430_PRM_PARTITION,
-=09.omap_chip=09  =3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 =09.pwrsts=09=09  =3D PWRSTS_OFF_ON,
 =09.banks=09=09  =3D 1,
 =09.pwrsts_mem_ret=09=3D {
@@ -266,7 +254,6 @@ static struct powerdomain l3init_44xx_pwrdm =3D {
 =09.name=09=09  =3D "l3init_pwrdm",
 =09.prcm_offs=09  =3D OMAP4430_PRM_L3INIT_INST,
 =09.prcm_partition=09  =3D OMAP4430_PRM_PARTITION,
-=09.omap_chip=09  =3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 =09.pwrsts=09=09  =3D PWRSTS_RET_ON,
 =09.pwrsts_logic_ret =3D PWRSTS_OFF_RET,
 =09.banks=09=09  =3D 1,
@@ -284,7 +271,6 @@ static struct powerdomain l4per_44xx_pwrdm =3D {
 =09.name=09=09  =3D "l4per_pwrdm",
 =09.prcm_offs=09  =3D OMAP4430_PRM_L4PER_INST,
 =09.prcm_partition=09  =3D OMAP4430_PRM_PARTITION,
-=09.omap_chip=09  =3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 =09.pwrsts=09=09  =3D PWRSTS_RET_ON,
 =09.pwrsts_logic_ret =3D PWRSTS_OFF_RET,
 =09.banks=09=09  =3D 2,
@@ -307,7 +293,6 @@ static struct powerdomain always_on_core_44xx_pwrdm =3D=
 {
 =09.name=09=09  =3D "always_on_core_pwrdm",
 =09.prcm_offs=09  =3D OMAP4430_PRM_ALWAYS_ON_INST,
 =09.prcm_partition=09  =3D OMAP4430_PRM_PARTITION,
-=09.omap_chip=09  =3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 =09.pwrsts=09=09  =3D PWRSTS_ON,
 };
=20
@@ -316,7 +301,6 @@ static struct powerdomain cefuse_44xx_pwrdm =3D {
 =09.name=09=09  =3D "cefuse_pwrdm",
 =09.prcm_offs=09  =3D OMAP4430_PRM_CEFUSE_INST,
 =09.prcm_partition=09  =3D OMAP4430_PRM_PARTITION,
-=09.omap_chip=09  =3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 =09.pwrsts=09=09  =3D PWRSTS_OFF_ON,
 =09.flags=09=09  =3D PWRDM_HAS_LOWPOWERSTATECHANGE,
 };
--=20
1.7.5.4

--155748971-369907839-1315187436=:9056--

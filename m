From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 04/10] ARM: OMAP: Powerdomain: Add OMAP3 powerdomains
Date: Tue, 19 Aug 2008 11:39:55 +0300
Message-ID: <1219135201-10282-5-git-send-email-tony@atomide.com>
References: <20080818163429.GF16455@flint.arm.linux.org.uk>
 <1219135201-10282-1-git-send-email-tony@atomide.com>
 <1219135201-10282-2-git-send-email-tony@atomide.com>
 <1219135201-10282-3-git-send-email-tony@atomide.com>
 <1219135201-10282-4-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:63458 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753416AbYHSIkT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Aug 2008 04:40:19 -0400
In-Reply-To: <1219135201-10282-4-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>

=46rom: Paul Walmsley <paul@pwsan.com>

Add OMAP3-specific powerdomains.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap2/powerdomains.h b/arch/arm/mach-omap2/p=
owerdomains.h
index 325e2ba..1e151fa 100644
--- a/arch/arm/mach-omap2/powerdomains.h
+++ b/arch/arm/mach-omap2/powerdomains.h
@@ -98,16 +98,28 @@ static struct pwrdm_dep gfx_sgx_wkdeps[] =3D {
 	{ NULL },
 };
=20
+/*
+ * 3430: CM_SLEEPDEP_CAM: MPU
+ * 3430ES1: CM_SLEEPDEP_GFX: MPU
+ * 3430ES2: CM_SLEEPDEP_SGX: MPU
+ */
+static struct pwrdm_dep cam_gfx_sleepdeps[] =3D {
+	{
+		.pwrdm_name =3D "mpu_pwrdm",
+		.omap_chip =3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
+	},
+	{ NULL },
+};
+
=20
 #include "powerdomains24xx.h"
+#include "powerdomains34xx.h"
=20
=20
 /*
  * OMAP2/3 common powerdomains
  */
=20
-/* XXX add sleepdeps for this powerdomain : 3430 */
-
 /*
  * The GFX powerdomain is not present on 3430ES2, but currently we do =
not
  * have a macro to filter it out at compile-time.
@@ -118,6 +130,7 @@ static struct powerdomain gfx_pwrdm =3D {
 	.omap_chip	  =3D OMAP_CHIP_INIT(CHIP_IS_OMAP24XX |
 					   CHIP_IS_OMAP3430ES1),
 	.wkdep_srcs	  =3D gfx_sgx_wkdeps,
+	.sleepdep_srcs	  =3D cam_gfx_sleepdeps,
 	.pwrsts		  =3D PWRSTS_OFF_RET_ON,
 	.pwrsts_logic_ret =3D PWRDM_POWER_RET,
 	.banks		  =3D 1,
@@ -154,6 +167,19 @@ static struct powerdomain *powerdomains_omap[] __i=
nitdata =3D {
 	&mdm_pwrdm,
 #endif
=20
+#ifdef CONFIG_ARCH_OMAP34XX
+	&iva2_pwrdm,
+	&mpu_34xx_pwrdm,
+	&neon_pwrdm,
+	&core_34xx_pwrdm,
+	&cam_pwrdm,
+	&dss_pwrdm,
+	&per_pwrdm,
+	&emu_pwrdm,
+	&sgx_pwrdm,
+	&usbhost_pwrdm,
+#endif
+
 	NULL
 };
=20
diff --git a/arch/arm/mach-omap2/powerdomains34xx.h b/arch/arm/mach-oma=
p2/powerdomains34xx.h
new file mode 100644
index 0000000..f573f71
--- /dev/null
+++ b/arch/arm/mach-omap2/powerdomains34xx.h
@@ -0,0 +1,327 @@
+/*
+ * OMAP34XX powerdomain definitions
+ *
+ * Copyright (C) 2007-2008 Texas Instruments, Inc.
+ * Copyright (C) 2007-2008 Nokia Corporation
+ *
+ * Written by Paul Walmsley
+ * Debugging and integration fixes by Jouni H=C3=B6gander
+ *
+ * This program is free software; you can redistribute it and/or modif=
y
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef ARCH_ARM_MACH_OMAP2_POWERDOMAINS34XX
+#define ARCH_ARM_MACH_OMAP2_POWERDOMAINS34XX
+
+/*
+ * N.B. If powerdomains are added or removed from this file, update
+ * the array in mach-omap2/powerdomains.h.
+ */
+
+#include <mach/powerdomain.h>
+
+#include "prcm-common.h"
+#include "prm.h"
+#include "prm-regbits-34xx.h"
+#include "cm.h"
+#include "cm-regbits-34xx.h"
+
+/*
+ * 34XX-specific powerdomains, dependencies
+ */
+
+#ifdef CONFIG_ARCH_OMAP34XX
+
+/*
+ * 3430: PM_WKDEP_{PER,USBHOST}: CORE, IVA2, MPU, WKUP
+ * (USBHOST is ES2 only)
+ */
+static struct pwrdm_dep per_usbhost_wkdeps[] =3D {
+	{
+		.pwrdm_name =3D "core_pwrdm",
+		.omap_chip =3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
+	},
+	{
+		.pwrdm_name =3D "iva2_pwrdm",
+		.omap_chip =3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
+	},
+	{
+		.pwrdm_name =3D "mpu_pwrdm",
+		.omap_chip =3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
+	},
+	{
+		.pwrdm_name =3D "wkup_pwrdm",
+		.omap_chip =3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
+	},
+	{ NULL },
+};
+
+/*
+ * 3430 PM_WKDEP_MPU: CORE, IVA2, DSS, PER
+ */
+static struct pwrdm_dep mpu_34xx_wkdeps[] =3D {
+	{
+		.pwrdm_name =3D "core_pwrdm",
+		.omap_chip =3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
+	},
+	{
+		.pwrdm_name =3D "iva2_pwrdm",
+		.omap_chip =3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
+	},
+	{
+		.pwrdm_name =3D "dss_pwrdm",
+		.omap_chip =3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
+	},
+	{
+		.pwrdm_name =3D "per_pwrdm",
+		.omap_chip =3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
+	},
+	{ NULL },
+};
+
+/*
+ * 3430 PM_WKDEP_IVA2: CORE, MPU, WKUP, DSS, PER
+ */
+static struct pwrdm_dep iva2_wkdeps[] =3D {
+	{
+		.pwrdm_name =3D "core_pwrdm",
+		.omap_chip =3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
+	},
+	{
+		.pwrdm_name =3D "mpu_pwrdm",
+		.omap_chip =3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
+	},
+	{
+		.pwrdm_name =3D "wkup_pwrdm",
+		.omap_chip =3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
+	},
+	{
+		.pwrdm_name =3D "dss_pwrdm",
+		.omap_chip =3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
+	},
+	{
+		.pwrdm_name =3D "per_pwrdm",
+		.omap_chip =3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
+	},
+	{ NULL },
+};
+
+
+/* 3430 PM_WKDEP_{CAM,DSS}: IVA2, MPU, WKUP */
+static struct pwrdm_dep cam_dss_wkdeps[] =3D {
+	{
+		.pwrdm_name =3D "iva2_pwrdm",
+		.omap_chip =3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
+	},
+	{
+		.pwrdm_name =3D "mpu_pwrdm",
+		.omap_chip =3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
+	},
+	{
+		.pwrdm_name =3D "wkup_pwrdm",
+		.omap_chip =3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
+	},
+	{ NULL },
+};
+
+/* 3430: PM_WKDEP_NEON: MPU */
+static struct pwrdm_dep neon_wkdeps[] =3D {
+	{
+		.pwrdm_name =3D "mpu_pwrdm",
+		.omap_chip =3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
+	},
+	{ NULL },
+};
+
+
+/* Sleep dependency source arrays for 34xx-specific pwrdms - 34XX only=
 */
+
+/*
+ * 3430: CM_SLEEPDEP_{DSS,PER}: MPU, IVA
+ * 3430ES2: CM_SLEEPDEP_USBHOST: MPU, IVA
+ */
+static struct pwrdm_dep dss_per_usbhost_sleepdeps[] =3D {
+	{
+		.pwrdm_name =3D "mpu_pwrdm",
+		.omap_chip =3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
+	},
+	{
+		.pwrdm_name =3D "iva2_pwrdm",
+		.omap_chip =3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
+	},
+	{ NULL },
+};
+
+
+/*
+ * Powerdomains
+ */
+
+static struct powerdomain iva2_pwrdm =3D {
+	.name		  =3D "iva2_pwrdm",
+	.prcm_offs	  =3D OMAP3430_IVA2_MOD,
+	.omap_chip	  =3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+	.dep_bit	  =3D OMAP3430_PM_WKDEP_MPU_EN_IVA2_SHIFT,
+	.wkdep_srcs	  =3D iva2_wkdeps,
+	.pwrsts		  =3D PWRSTS_OFF_RET_ON,
+	.pwrsts_logic_ret =3D PWRSTS_OFF_RET,
+	.banks		  =3D 4,
+	.pwrsts_mem_ret	  =3D {
+		[0] =3D PWRSTS_OFF_RET,
+		[1] =3D PWRSTS_OFF_RET,
+		[2] =3D PWRSTS_OFF_RET,
+		[3] =3D PWRSTS_OFF_RET,
+	},
+	.pwrsts_mem_on	  =3D {
+		[0] =3D PWRDM_POWER_ON,
+		[1] =3D PWRDM_POWER_ON,
+		[2] =3D PWRSTS_OFF_ON,
+		[3] =3D PWRDM_POWER_ON,
+	},
+};
+
+static struct powerdomain mpu_34xx_pwrdm =3D {
+	.name		  =3D "mpu_pwrdm",
+	.prcm_offs	  =3D MPU_MOD,
+	.omap_chip	  =3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+	.dep_bit	  =3D OMAP3430_EN_MPU_SHIFT,
+	.wkdep_srcs	  =3D mpu_34xx_wkdeps,
+	.pwrsts		  =3D PWRSTS_OFF_RET_ON,
+	.pwrsts_logic_ret =3D PWRSTS_OFF_RET,
+	.banks		  =3D 1,
+	.pwrsts_mem_ret	  =3D {
+		[0] =3D PWRSTS_OFF_RET,
+	},
+	.pwrsts_mem_on	  =3D {
+		[0] =3D PWRSTS_OFF_ON,
+	},
+};
+
+/* No wkdeps or sleepdeps for 34xx core apparently */
+static struct powerdomain core_34xx_pwrdm =3D {
+	.name		  =3D "core_pwrdm",
+	.prcm_offs	  =3D CORE_MOD,
+	.omap_chip	  =3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+	.pwrsts		  =3D PWRSTS_OFF_RET_ON,
+	.dep_bit	  =3D OMAP3430_EN_CORE_SHIFT,
+	.banks		  =3D 2,
+	.pwrsts_mem_ret	  =3D {
+		[0] =3D PWRSTS_OFF_RET,	 /* MEM1RETSTATE */
+		[1] =3D PWRSTS_OFF_RET,	 /* MEM2RETSTATE */
+	},
+	.pwrsts_mem_on	  =3D {
+		[0] =3D PWRSTS_OFF_RET_ON, /* MEM1ONSTATE */
+		[1] =3D PWRSTS_OFF_RET_ON, /* MEM2ONSTATE */
+	},
+};
+
+/* Another case of bit name collisions between several registers: EN_D=
SS */
+static struct powerdomain dss_pwrdm =3D {
+	.name		  =3D "dss_pwrdm",
+	.omap_chip	  =3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+	.prcm_offs	  =3D OMAP3430_DSS_MOD,
+	.dep_bit	  =3D OMAP3430_PM_WKDEP_MPU_EN_DSS_SHIFT,
+	.wkdep_srcs	  =3D cam_dss_wkdeps,
+	.sleepdep_srcs	  =3D dss_per_usbhost_sleepdeps,
+	.pwrsts		  =3D PWRSTS_OFF_RET_ON,
+	.pwrsts_logic_ret =3D PWRDM_POWER_RET,
+	.banks		  =3D 1,
+	.pwrsts_mem_ret	  =3D {
+		[0] =3D PWRDM_POWER_RET, /* MEMRETSTATE */
+	},
+	.pwrsts_mem_on	  =3D {
+		[0] =3D PWRDM_POWER_ON,  /* MEMONSTATE */
+	},
+};
+
+static struct powerdomain sgx_pwrdm =3D {
+	.name		  =3D "sgx_pwrdm",
+	.prcm_offs	  =3D OMAP3430ES2_SGX_MOD,
+	.omap_chip	  =3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430ES2),
+	.wkdep_srcs	  =3D gfx_sgx_wkdeps,
+	.sleepdep_srcs	  =3D cam_gfx_sleepdeps,
+	/* XXX This is accurate for 3430 SGX, but what about GFX? */
+	.pwrsts		  =3D PWRSTS_OFF_RET_ON,
+	.pwrsts_logic_ret =3D PWRDM_POWER_RET,
+	.banks		  =3D 1,
+	.pwrsts_mem_ret	  =3D {
+		[0] =3D PWRDM_POWER_RET, /* MEMRETSTATE */
+	},
+	.pwrsts_mem_on	  =3D {
+		[0] =3D PWRDM_POWER_ON,  /* MEMONSTATE */
+	},
+};
+
+static struct powerdomain cam_pwrdm =3D {
+	.name		  =3D "cam_pwrdm",
+	.omap_chip	  =3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+	.prcm_offs	  =3D OMAP3430_CAM_MOD,
+	.wkdep_srcs	  =3D cam_dss_wkdeps,
+	.sleepdep_srcs	  =3D cam_gfx_sleepdeps,
+	.pwrsts		  =3D PWRSTS_OFF_RET_ON,
+	.pwrsts_logic_ret =3D PWRDM_POWER_RET,
+	.banks		  =3D 1,
+	.pwrsts_mem_ret	  =3D {
+		[0] =3D PWRDM_POWER_RET, /* MEMRETSTATE */
+	},
+	.pwrsts_mem_on	  =3D {
+		[0] =3D PWRDM_POWER_ON,  /* MEMONSTATE */
+	},
+};
+
+static struct powerdomain per_pwrdm =3D {
+	.name		  =3D "per_pwrdm",
+	.prcm_offs	  =3D OMAP3430_PER_MOD,
+	.omap_chip	  =3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+	.dep_bit	  =3D OMAP3430_EN_PER_SHIFT,
+	.wkdep_srcs	  =3D per_usbhost_wkdeps,
+	.sleepdep_srcs	  =3D dss_per_usbhost_sleepdeps,
+	.pwrsts		  =3D PWRSTS_OFF_RET_ON,
+	.pwrsts_logic_ret =3D PWRSTS_OFF_RET,
+	.banks		  =3D 1,
+	.pwrsts_mem_ret	  =3D {
+		[0] =3D PWRDM_POWER_RET, /* MEMRETSTATE */
+	},
+	.pwrsts_mem_on	  =3D {
+		[0] =3D PWRDM_POWER_ON,  /* MEMONSTATE */
+	},
+};
+
+static struct powerdomain emu_pwrdm =3D {
+	.name		=3D "emu_pwrdm",
+	.prcm_offs	=3D OMAP3430_EMU_MOD,
+	.omap_chip	=3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+};
+
+static struct powerdomain neon_pwrdm =3D {
+	.name		  =3D "neon_pwrdm",
+	.prcm_offs	  =3D OMAP3430_NEON_MOD,
+	.omap_chip	  =3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+	.wkdep_srcs	  =3D neon_wkdeps,
+	.pwrsts		  =3D PWRSTS_OFF_RET_ON,
+	.pwrsts_logic_ret =3D PWRDM_POWER_RET,
+};
+
+static struct powerdomain usbhost_pwrdm =3D {
+	.name		  =3D "usbhost_pwrdm",
+	.prcm_offs	  =3D OMAP3430ES2_USBHOST_MOD,
+	.omap_chip	  =3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430ES2),
+	.wkdep_srcs	  =3D per_usbhost_wkdeps,
+	.sleepdep_srcs	  =3D dss_per_usbhost_sleepdeps,
+	.pwrsts		  =3D PWRSTS_OFF_RET_ON,
+	.pwrsts_logic_ret =3D PWRDM_POWER_RET,
+	.banks		  =3D 1,
+	.pwrsts_mem_ret	  =3D {
+		[0] =3D PWRDM_POWER_RET, /* MEMRETSTATE */
+	},
+	.pwrsts_mem_on	  =3D {
+		[0] =3D PWRDM_POWER_ON,  /* MEMONSTATE */
+	},
+};
+
+#endif    /* CONFIG_ARCH_OMAP34XX */
+
+
+#endif
diff --git a/arch/arm/mach-omap2/prcm-common.h b/arch/arm/mach-omap2/pr=
cm-common.h
index 54c32f4..4a32822 100644
--- a/arch/arm/mach-omap2/prcm-common.h
+++ b/arch/arm/mach-omap2/prcm-common.h
@@ -312,7 +312,8 @@
 #define OMAP3430_ST_GPT2				(1 << 3)
=20
 /* CM_SLEEPDEP_PER, PM_WKDEP_IVA2, PM_WKDEP_MPU, PM_WKDEP_PER shared b=
its */
-#define OMAP3430_EN_CORE				(1 << 0)
+#define OMAP3430_EN_CORE_SHIFT				0
+#define OMAP3430_EN_CORE_MASK				(1 << 0)
=20
 #endif
=20
diff --git a/arch/arm/mach-omap2/prm-regbits-34xx.h b/arch/arm/mach-oma=
p2/prm-regbits-34xx.h
index b4686bc..5b5ecfe 100644
--- a/arch/arm/mach-omap2/prm-regbits-34xx.h
+++ b/arch/arm/mach-omap2/prm-regbits-34xx.h
@@ -68,7 +68,8 @@
 #define OMAP3430_VPINIDLE				(1 << 0)
=20
 /* PM_WKDEP_IVA2, PM_WKDEP_MPU shared bits */
-#define OMAP3430_EN_PER					(1 << 7)
+#define OMAP3430_EN_PER_SHIFT				7
+#define OMAP3430_EN_PER_MASK				(1 << 7)
=20
 /* PM_PWSTCTRL_IVA2, PM_PWSTCTRL_MPU, PM_PWSTCTRL_CORE shared bits */
 #define OMAP3430_MEMORYCHANGE				(1 << 3)
@@ -77,7 +78,7 @@
 #define OMAP3430_LOGICSTATEST				(1 << 2)
=20
 /* PM_PREPWSTST_IVA2, PM_PREPWSTST_CORE shared bits */
-#define OMAP3430_LASTLOGICSTATEENTERED				(1 << 2)
+#define OMAP3430_LASTLOGICSTATEENTERED			(1 << 2)
=20
 /*
  * PM_PREPWSTST_IVA2, PM_PREPWSTST_MPU, PM_PREPWSTST_CORE,
@@ -278,8 +279,10 @@
 #define OMAP3430_EMULATION_MPU_RST			(1 << 11)
=20
 /* PM_WKDEP_MPU specific bits */
-#define OMAP3430_PM_WKDEP_MPU_EN_DSS			(1 << 5)
-#define OMAP3430_PM_WKDEP_MPU_EN_IVA2			(1 << 2)
+#define OMAP3430_PM_WKDEP_MPU_EN_DSS_SHIFT		5
+#define OMAP3430_PM_WKDEP_MPU_EN_DSS_MASK		(1 << 5)
+#define OMAP3430_PM_WKDEP_MPU_EN_IVA2_SHIFT		2
+#define OMAP3430_PM_WKDEP_MPU_EN_IVA2_MASK		(1 << 2)
=20
 /* PM_EVGENCTRL_MPU */
 #define OMAP3430_OFFLOADMODE_SHIFT			3
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

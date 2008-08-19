From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 03/10] ARM: OMAP2: Powerdomain: Add OMAP2 powerdomains
Date: Tue, 19 Aug 2008 11:39:54 +0300
Message-ID: <1219135201-10282-4-git-send-email-tony@atomide.com>
References: <20080818163429.GF16455@flint.arm.linux.org.uk>
 <1219135201-10282-1-git-send-email-tony@atomide.com>
 <1219135201-10282-2-git-send-email-tony@atomide.com>
 <1219135201-10282-3-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:63402 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753198AbYHSIkQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Aug 2008 04:40:16 -0400
In-Reply-To: <1219135201-10282-3-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>

=46rom: Paul Walmsley <paul@pwsan.com>

Add OMAP2-specific powerdomains.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap2/powerdomains.h b/arch/arm/mach-omap2/p=
owerdomains.h
index 1936df2..325e2ba 100644
--- a/arch/arm/mach-omap2/powerdomains.h
+++ b/arch/arm/mach-omap2/powerdomains.h
@@ -98,6 +98,10 @@ static struct pwrdm_dep gfx_sgx_wkdeps[] =3D {
 	{ NULL },
 };
=20
+
+#include "powerdomains24xx.h"
+
+
 /*
  * OMAP2/3 common powerdomains
  */
@@ -140,6 +144,16 @@ static struct powerdomain *powerdomains_omap[] __i=
nitdata =3D {
 	&gfx_pwrdm,
 	&wkup_pwrdm,
=20
+#ifdef CONFIG_ARCH_OMAP24XX
+	&dsp_pwrdm,
+	&mpu_24xx_pwrdm,
+	&core_24xx_pwrdm,
+#endif
+
+#ifdef CONFIG_ARCH_OMAP2430
+	&mdm_pwrdm,
+#endif
+
 	NULL
 };
=20
diff --git a/arch/arm/mach-omap2/powerdomains24xx.h b/arch/arm/mach-oma=
p2/powerdomains24xx.h
new file mode 100644
index 0000000..9f08dc3
--- /dev/null
+++ b/arch/arm/mach-omap2/powerdomains24xx.h
@@ -0,0 +1,200 @@
+/*
+ * OMAP24XX powerdomain definitions
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
+#ifndef ARCH_ARM_MACH_OMAP2_POWERDOMAINS24XX
+#define ARCH_ARM_MACH_OMAP2_POWERDOMAINS24XX
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
+#include "prm-regbits-24xx.h"
+#include "cm.h"
+#include "cm-regbits-24xx.h"
+
+/* 24XX powerdomains and dependencies */
+
+#ifdef CONFIG_ARCH_OMAP24XX
+
+
+/* Wakeup dependency source arrays */
+
+/*
+ * 2420/2430 PM_WKDEP_DSP: CORE, MPU, WKUP
+ * 2430 PM_WKDEP_MDM: same as above
+ */
+static struct pwrdm_dep dsp_mdm_24xx_wkdeps[] =3D {
+	{
+		.pwrdm_name =3D "core_pwrdm",
+		.omap_chip =3D OMAP_CHIP_INIT(CHIP_IS_OMAP24XX)
+	},
+	{
+		.pwrdm_name =3D "mpu_pwrdm",
+		.omap_chip =3D OMAP_CHIP_INIT(CHIP_IS_OMAP24XX)
+	},
+	{
+		.pwrdm_name =3D "wkup_pwrdm",
+		.omap_chip =3D OMAP_CHIP_INIT(CHIP_IS_OMAP24XX)
+	},
+	{ NULL },
+};
+
+/*
+ * 2420 PM_WKDEP_MPU: CORE, DSP, WKUP
+ * 2430 adds MDM
+ */
+static struct pwrdm_dep mpu_24xx_wkdeps[] =3D {
+	{
+		.pwrdm_name =3D "core_pwrdm",
+		.omap_chip =3D OMAP_CHIP_INIT(CHIP_IS_OMAP24XX)
+	},
+	{
+		.pwrdm_name =3D "dsp_pwrdm",
+		.omap_chip =3D OMAP_CHIP_INIT(CHIP_IS_OMAP24XX)
+	},
+	{
+		.pwrdm_name =3D "wkup_pwrdm",
+		.omap_chip =3D OMAP_CHIP_INIT(CHIP_IS_OMAP24XX)
+	},
+	{
+		.pwrdm_name =3D "mdm_pwrdm",
+		.omap_chip =3D OMAP_CHIP_INIT(CHIP_IS_OMAP2430)
+	},
+	{ NULL },
+};
+
+/*
+ * 2420 PM_WKDEP_CORE: DSP, GFX, MPU, WKUP
+ * 2430 adds MDM
+ */
+static struct pwrdm_dep core_24xx_wkdeps[] =3D {
+	{
+		.pwrdm_name =3D "dsp_pwrdm",
+		.omap_chip =3D OMAP_CHIP_INIT(CHIP_IS_OMAP24XX)
+	},
+	{
+		.pwrdm_name =3D "gfx_pwrdm",
+		.omap_chip =3D OMAP_CHIP_INIT(CHIP_IS_OMAP24XX)
+	},
+	{
+		.pwrdm_name =3D "mpu_pwrdm",
+		.omap_chip =3D OMAP_CHIP_INIT(CHIP_IS_OMAP24XX)
+	},
+	{
+		.pwrdm_name =3D "wkup_pwrdm",
+		.omap_chip =3D OMAP_CHIP_INIT(CHIP_IS_OMAP24XX)
+	},
+	{
+		.pwrdm_name =3D "mdm_pwrdm",
+		.omap_chip =3D OMAP_CHIP_INIT(CHIP_IS_OMAP2430)
+	},
+	{ NULL },
+};
+
+
+/* Powerdomains */
+
+static struct powerdomain dsp_pwrdm =3D {
+	.name		  =3D "dsp_pwrdm",
+	.prcm_offs	  =3D OMAP24XX_DSP_MOD,
+	.omap_chip	  =3D OMAP_CHIP_INIT(CHIP_IS_OMAP24XX),
+	.dep_bit	  =3D OMAP24XX_PM_WKDEP_MPU_EN_DSP_SHIFT,
+	.wkdep_srcs	  =3D dsp_mdm_24xx_wkdeps,
+	.pwrsts		  =3D PWRSTS_OFF_RET_ON,
+	.pwrsts_logic_ret =3D PWRDM_POWER_RET,
+	.banks		  =3D 1,
+	.pwrsts_mem_ret	  =3D {
+		[0] =3D PWRDM_POWER_RET,
+	},
+	.pwrsts_mem_on	  =3D {
+		[0] =3D PWRDM_POWER_ON,
+	},
+};
+
+static struct powerdomain mpu_24xx_pwrdm =3D {
+	.name		  =3D "mpu_pwrdm",
+	.prcm_offs	  =3D MPU_MOD,
+	.omap_chip	  =3D OMAP_CHIP_INIT(CHIP_IS_OMAP24XX),
+	.dep_bit	  =3D OMAP24XX_EN_MPU_SHIFT,
+	.wkdep_srcs	  =3D mpu_24xx_wkdeps,
+	.pwrsts		  =3D PWRSTS_OFF_RET_ON,
+	.pwrsts_logic_ret =3D PWRSTS_OFF_RET,
+	.banks		  =3D 1,
+	.pwrsts_mem_ret	  =3D {
+		[0] =3D PWRDM_POWER_RET,
+	},
+	.pwrsts_mem_on	  =3D {
+		[0] =3D PWRDM_POWER_ON,
+	},
+};
+
+static struct powerdomain core_24xx_pwrdm =3D {
+	.name		  =3D "core_pwrdm",
+	.prcm_offs	  =3D CORE_MOD,
+	.omap_chip	  =3D OMAP_CHIP_INIT(CHIP_IS_OMAP24XX),
+	.wkdep_srcs	  =3D core_24xx_wkdeps,
+	.pwrsts		  =3D PWRSTS_OFF_RET_ON,
+	.dep_bit	  =3D OMAP24XX_EN_CORE_SHIFT,
+	.banks		  =3D 3,
+	.pwrsts_mem_ret	  =3D {
+		[0] =3D PWRSTS_OFF_RET,	 /* MEM1RETSTATE */
+		[1] =3D PWRSTS_OFF_RET,	 /* MEM2RETSTATE */
+		[2] =3D PWRSTS_OFF_RET,	 /* MEM3RETSTATE */
+	},
+	.pwrsts_mem_on	  =3D {
+		[0] =3D PWRSTS_OFF_RET_ON, /* MEM1ONSTATE */
+		[1] =3D PWRSTS_OFF_RET_ON, /* MEM2ONSTATE */
+		[2] =3D PWRSTS_OFF_RET_ON, /* MEM3ONSTATE */
+	},
+};
+
+#endif	   /* CONFIG_ARCH_OMAP24XX */
+
+
+
+/*
+ * 2430-specific powerdomains
+ */
+
+#ifdef CONFIG_ARCH_OMAP2430
+
+/* XXX 2430 KILLDOMAINWKUP bit?  No current users apparently */
+
+/* Another case of bit name collisions between several registers: EN_M=
DM */
+static struct powerdomain mdm_pwrdm =3D {
+	.name		  =3D "mdm_pwrdm",
+	.prcm_offs	  =3D OMAP2430_MDM_MOD,
+	.omap_chip	  =3D OMAP_CHIP_INIT(CHIP_IS_OMAP2430),
+	.dep_bit	  =3D OMAP2430_PM_WKDEP_MPU_EN_MDM_SHIFT,
+	.wkdep_srcs	  =3D dsp_mdm_24xx_wkdeps,
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
+#endif     /* CONFIG_ARCH_OMAP2430 */
+
+
+#endif
diff --git a/arch/arm/mach-omap2/prm-regbits-24xx.h b/arch/arm/mach-oma=
p2/prm-regbits-24xx.h
index c6d17a3..4002051 100644
--- a/arch/arm/mach-omap2/prm-regbits-24xx.h
+++ b/arch/arm/mach-omap2/prm-regbits-24xx.h
@@ -29,8 +29,10 @@
 #define OMAP24XX_WKUP1_EN				(1 << 0)
=20
 /* PM_WKDEP_GFX, PM_WKDEP_MPU, PM_WKDEP_DSP, PM_WKDEP_MDM shared bits =
*/
-#define OMAP24XX_EN_MPU					(1 << 1)
-#define OMAP24XX_EN_CORE				(1 << 0)
+#define OMAP24XX_EN_MPU_SHIFT				1
+#define OMAP24XX_EN_MPU_MASK				(1 << 1)
+#define OMAP24XX_EN_CORE_SHIFT 				0
+#define OMAP24XX_EN_CORE_MASK				(1 << 0)
=20
 /*
  * PM_PWSTCTRL_MPU, PM_PWSTCTRL_GFX, PM_PWSTCTRL_DSP, PM_PWSTCTRL_MDM
@@ -140,8 +142,10 @@
 /* 2430 calls GLOBALWMPU_RST "GLOBALWARM_RST" instead */
=20
 /* PM_WKDEP_MPU specific bits */
-#define OMAP2430_PM_WKDEP_MPU_EN_MDM			(1 << 5)
-#define OMAP24XX_PM_WKDEP_MPU_EN_DSP			(1 << 2)
+#define OMAP2430_PM_WKDEP_MPU_EN_MDM_SHIFT		5
+#define OMAP2430_PM_WKDEP_MPU_EN_MDM_MASK		(1 << 5)
+#define OMAP24XX_PM_WKDEP_MPU_EN_DSP_SHIFT		2
+#define OMAP24XX_PM_WKDEP_MPU_EN_DSP_MASK		(1 << 2)
=20
 /* PM_EVGENCTRL_MPU specific bits */
=20
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

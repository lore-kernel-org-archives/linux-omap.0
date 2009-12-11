From: Abhijit Pagare <abhijitpagare@ti.com>
Subject: [PATCH 5/5] ARM: OMAP4: PM: Refine the APIs to support OMAP4 features.
Date: Fri, 11 Dec 2009 16:40:28 +0530
Message-ID: <1260529828-14862-5-git-send-email-abhijitpagare@ti.com>
References: <1260529828-14862-1-git-send-email-abhijitpagare@ti.com>
 <1260529828-14862-2-git-send-email-abhijitpagare@ti.com>
 <1260529828-14862-3-git-send-email-abhijitpagare@ti.com>
 <1260529828-14862-4-git-send-email-abhijitpagare@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:55597 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762303AbZLKLKf (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 11 Dec 2009 06:10:35 -0500
In-Reply-To: <1260529828-14862-4-git-send-email-abhijitpagare@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Abhijit Pagare <abhijitpagare@ti.com>, Paul Walmsley <paul@pwsan.com>, Benoit Cousson <b-cousson@ti.com>, Rajendra Nayak <rnayak@ti.com>

Port the APIs to support the OMAP4 clockdomain framework.
Also take care of the compiling requirements for the same.

Signed-off-by: Abhijit Pagare <abhijitpagare@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/Makefile      |    2 +-
 arch/arm/mach-omap2/clockdomain.c |   20 ++++++++++++--------
 arch/arm/mach-omap2/io.c          |    2 +-
 3 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefil=
e
index 8b351e3..7cd3366 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -11,7 +11,7 @@ clock-common				=3D clock.o clockdomain.o
=20
 obj-$(CONFIG_ARCH_OMAP2) +=3D $(omap-2-3-common) $(prcm-common) $(cloc=
k-common)
 obj-$(CONFIG_ARCH_OMAP3) +=3D $(omap-2-3-common) $(prcm-common) $(cloc=
k-common)
-obj-$(CONFIG_ARCH_OMAP4) +=3D $(prcm-common)
+obj-$(CONFIG_ARCH_OMAP4) +=3D $(prcm-common) $(clock-common)
=20
 obj-$(CONFIG_OMAP_MCBSP) +=3D mcbsp.o
=20
diff --git a/arch/arm/mach-omap2/clockdomain.c b/arch/arm/mach-omap2/cl=
ockdomain.c
index d51350c..aab11b0 100644
--- a/arch/arm/mach-omap2/clockdomain.c
+++ b/arch/arm/mach-omap2/clockdomain.c
@@ -1,10 +1,12 @@
 /*
- * OMAP2/3 clockdomain framework functions
+ * OMAP2/3/4 clockdomain framework functions
  *
  * Copyright (C) 2008 Texas Instruments, Inc.
  * Copyright (C) 2008 Nokia Corporation
  *
  * Written by Paul Walmsley and Jouni H=C3=83=C2=B6gander
+ * Added OMAP4 specific support by Abhijit Pagare <abhijitpagare@ti.co=
m>
+ *
  *
  * This program is free software; you can redistribute it and/or modif=
y
  * it under the terms of the GNU General Public License version 2 as
@@ -154,7 +156,7 @@ static void _omap2_clkdm_set_hwsup(struct clockdoma=
in *clkdm, int enable)
 			bits =3D OMAP24XX_CLKSTCTRL_ENABLE_AUTO;
 		else
 			bits =3D OMAP24XX_CLKSTCTRL_DISABLE_AUTO;
-	} else if (cpu_is_omap34xx()) {
+	} else if (cpu_is_omap34xx() | cpu_is_omap44xx()) {
 		if (enable)
 			bits =3D OMAP34XX_CLKSTCTRL_ENABLE_AUTO;
 		else
@@ -215,10 +217,12 @@ void clkdm_init(struct clockdomain **clkdms,
 		for (c =3D clkdms; *c; c++)
 			clkdm_register(*c);
=20
-	autodeps =3D init_autodeps;
-	if (autodeps)
-		for (autodep =3D autodeps; autodep->pwrdm.ptr; autodep++)
-			_autodep_lookup(autodep);
+	if (!cpu_is_omap44xx()) {
+		autodeps =3D init_autodeps;
+		if (autodeps)
+			for (autodep =3D autodeps; autodep->pwrdm.ptr; autodep++)
+				_autodep_lookup(autodep);
+	}
 }
=20
 /**
@@ -421,7 +425,7 @@ int omap2_clkdm_sleep(struct clockdomain *clkdm)
 		cm_set_mod_reg_bits(OMAP24XX_FORCESTATE,
 			    clkdm->pwrdm.ptr->prcm_offs, OMAP2_PM_PWSTCTRL);
=20
-	} else if (cpu_is_omap34xx()) {
+	} else if (cpu_is_omap34xx() | cpu_is_omap44xx()) {
=20
 		u32 bits =3D (OMAP34XX_CLKSTCTRL_FORCE_SLEEP <<
 			 __ffs(clkdm->clktrctrl_mask));
@@ -465,7 +469,7 @@ int omap2_clkdm_wakeup(struct clockdomain *clkdm)
 		cm_clear_mod_reg_bits(OMAP24XX_FORCESTATE,
 			      clkdm->pwrdm.ptr->prcm_offs, OMAP2_PM_PWSTCTRL);
=20
-	} else if (cpu_is_omap34xx()) {
+	} else if (cpu_is_omap34xx() | cpu_is_omap44xx()) {
=20
 		u32 bits =3D (OMAP34XX_CLKSTCTRL_FORCE_WAKEUP <<
 			 __ffs(clkdm->clktrctrl_mask));
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index aff5387..1064b23 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -314,12 +314,12 @@ void __init omap2_init_common_hw(struct omap_sdrc=
_params *sdrc_cs0,
 		hwmods =3D omap34xx_hwmods;
=20
 	pwrdm_init(powerdomains_omap);
+	clkdm_init(clockdomains_omap, clkdm_pwrdm_autodeps);
 #ifndef CONFIG_ARCH_OMAP4 /* FIXME: Remove this once the clkdev is rea=
dy */
 	/* The OPP tables have to be registered before a clk init */
 	omap_hwmod_init(hwmods);
 	omap2_mux_init();
 	omap_pm_if_early_init(mpu_opps, dsp_opps, l3_opps);
-	clkdm_init(clockdomains_omap, clkdm_pwrdm_autodeps);
 	omap2_clk_init();
 #endif
 	omap_serial_early_init();
--=20
1.5.4.7

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

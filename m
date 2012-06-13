From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 1/2] ARM: OMAP2+: hwmod data: Fix the wrong clkdm assigned
 to PRCM modules
Date: Wed, 13 Jun 2012 17:43:52 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1206131646420.30212@utopia.booyaka.com>
References: <1339433225-30042-1-git-send-email-b-cousson@ti.com> <1339433225-30042-2-git-send-email-b-cousson@ti.com> <alpine.DEB.2.00.1206111100130.5849@utopia.booyaka.com> <4FD65F12.2050805@ti.com> <4FD73847.5050205@ti.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-1447425969-1339631032=:30212"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:46926 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754912Ab2FMXnx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 Jun 2012 19:43:53 -0400
In-Reply-To: <4FD73847.5050205@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: "Cousson, Benoit" <b-cousson@ti.com>, tony@atomide.com

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-1447425969-1339631032=:30212
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE


Beno=EEt and I discussed this today, at length.  Our views still differ. =
=20

In an attempt to move on to more useful work, a compromise was agreed. =20
The following patch removes the requirement for hwmods to have a=20
clkdm_name, and removes the PRM and CM clockdomains from the data. =20
It is intended for 3.6.


- Paul

From: Paul Walmsley <paul@pwsan.com>
Date: Wed, 13 Jun 2012 17:16:05 -0600
Subject: [PATCH] ARM: OMAP2+: hwmod: remove prm_clkdm, cm_clkdm; allow hwmo=
ds
 to have no clockdomain

Remove prm_clkdm and cm_clkdm and allow hwmods to have no clockdomain.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Beno=EEt Cousson <b-cousson@ti.com>
---
 arch/arm/mach-omap2/Makefile                   |    1 -
 arch/arm/mach-omap2/clockdomain.h              |    2 --
 arch/arm/mach-omap2/clockdomains2420_data.c    |    2 --
 arch/arm/mach-omap2/clockdomains2430_data.c    |    2 --
 arch/arm/mach-omap2/clockdomains3xxx_data.c    |    2 --
 arch/arm/mach-omap2/clockdomains44xx_data.c    |    2 --
 arch/arm/mach-omap2/clockdomains_common_data.c |   24 --------------------=
----
 arch/arm/mach-omap2/omap_hwmod.c               |    9 ++++-----
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c     |    3 ---
 9 files changed, 4 insertions(+), 43 deletions(-)
 delete mode 100644 arch/arm/mach-omap2/clockdomains_common_data.c

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index fa742f3..bc7d239 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -116,7 +116,6 @@ obj-$(CONFIG_ARCH_OMAP4)=09=09+=3D powerdomains44xx_dat=
a.o
=20
 # PRCM clockdomain control
 clockdomain-common=09=09=09+=3D clockdomain.o
-clockdomain-common=09=09=09+=3D clockdomains_common_data.o
 obj-$(CONFIG_ARCH_OMAP2)=09=09+=3D $(clockdomain-common)
 obj-$(CONFIG_ARCH_OMAP2)=09=09+=3D clockdomain2xxx_3xxx.o
 obj-$(CONFIG_ARCH_OMAP2)=09=09+=3D clockdomains2xxx_3xxx_data.o
diff --git a/arch/arm/mach-omap2/clockdomain.h b/arch/arm/mach-omap2/clockd=
omain.h
index f7b5860..349dcbb 100644
--- a/arch/arm/mach-omap2/clockdomain.h
+++ b/arch/arm/mach-omap2/clockdomain.h
@@ -206,7 +206,5 @@ extern struct clkdm_ops omap4_clkdm_operations;
 extern struct clkdm_dep gfx_24xx_wkdeps[];
 extern struct clkdm_dep dsp_24xx_wkdeps[];
 extern struct clockdomain wkup_common_clkdm;
-extern struct clockdomain prm_common_clkdm;
-extern struct clockdomain cm_common_clkdm;
=20
 #endif
diff --git a/arch/arm/mach-omap2/clockdomains2420_data.c b/arch/arm/mach-om=
ap2/clockdomains2420_data.c
index 0ab8e46..5c74185 100644
--- a/arch/arm/mach-omap2/clockdomains2420_data.c
+++ b/arch/arm/mach-omap2/clockdomains2420_data.c
@@ -131,8 +131,6 @@ static struct clockdomain dss_2420_clkdm =3D {
=20
 static struct clockdomain *clockdomains_omap242x[] __initdata =3D {
 =09&wkup_common_clkdm,
-=09&cm_common_clkdm,
-=09&prm_common_clkdm,
 =09&mpu_2420_clkdm,
 =09&iva1_2420_clkdm,
 =09&dsp_2420_clkdm,
diff --git a/arch/arm/mach-omap2/clockdomains2430_data.c b/arch/arm/mach-om=
ap2/clockdomains2430_data.c
index 3645ed0..f096175 100644
--- a/arch/arm/mach-omap2/clockdomains2430_data.c
+++ b/arch/arm/mach-omap2/clockdomains2430_data.c
@@ -157,8 +157,6 @@ static struct clockdomain dss_2430_clkdm =3D {
=20
 static struct clockdomain *clockdomains_omap243x[] __initdata =3D {
 =09&wkup_common_clkdm,
-=09&cm_common_clkdm,
-=09&prm_common_clkdm,
 =09&mpu_2430_clkdm,
 =09&mdm_clkdm,
 =09&dsp_2430_clkdm,
diff --git a/arch/arm/mach-omap2/clockdomains3xxx_data.c b/arch/arm/mach-om=
ap2/clockdomains3xxx_data.c
index 6038adb..2cdc17c 100644
--- a/arch/arm/mach-omap2/clockdomains3xxx_data.c
+++ b/arch/arm/mach-omap2/clockdomains3xxx_data.c
@@ -347,8 +347,6 @@ static struct clkdm_autodep clkdm_autodeps[] =3D {
=20
 static struct clockdomain *clockdomains_omap3430_common[] __initdata =3D {
 =09&wkup_common_clkdm,
-=09&cm_common_clkdm,
-=09&prm_common_clkdm,
 =09&mpu_3xxx_clkdm,
 =09&neon_clkdm,
 =09&iva2_clkdm,
diff --git a/arch/arm/mach-omap2/clockdomains44xx_data.c b/arch/arm/mach-om=
ap2/clockdomains44xx_data.c
index c534258..bd7ed13 100644
--- a/arch/arm/mach-omap2/clockdomains44xx_data.c
+++ b/arch/arm/mach-omap2/clockdomains44xx_data.c
@@ -430,8 +430,6 @@ static struct clockdomain *clockdomains_omap44xx[] __in=
itdata =3D {
 =09&l4_wkup_44xx_clkdm,
 =09&emu_sys_44xx_clkdm,
 =09&l3_dma_44xx_clkdm,
-=09&prm_common_clkdm,
-=09&cm_common_clkdm,
 =09NULL
 };
=20
diff --git a/arch/arm/mach-omap2/clockdomains_common_data.c b/arch/arm/mach=
-omap2/clockdomains_common_data.c
deleted file mode 100644
index 615b1f0..0000000
--- a/arch/arm/mach-omap2/clockdomains_common_data.c
+++ /dev/null
@@ -1,24 +0,0 @@
-/*
- * OMAP2+-common clockdomain data
- *
- * Copyright (C) 2008-2012 Texas Instruments, Inc.
- * Copyright (C) 2008-2010 Nokia Corporation
- *
- * Paul Walmsley, Jouni H=F6gander
- */
-
-#include <linux/kernel.h>
-#include <linux/io.h>
-
-#include "clockdomain.h"
-
-/* These are implicit clockdomains - they are never defined as such in TRM=
 */
-struct clockdomain prm_common_clkdm =3D {
-=09.name=09=09=3D "prm_clkdm",
-=09.pwrdm=09=09=3D { .name =3D "wkup_pwrdm" },
-};
-
-struct clockdomain cm_common_clkdm =3D {
-=09.name=09=09=3D "cm_clkdm",
-=09.pwrdm=09=09=3D { .name =3D "core_pwrdm" },
-};
diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hw=
mod.c
index bf86f7e..3bba881 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -1285,23 +1285,22 @@ static struct omap_hwmod *_lookup(const char *name)
=20
 =09return oh;
 }
+
 /**
  * _init_clkdm - look up a clockdomain name, store pointer in omap_hwmod
  * @oh: struct omap_hwmod *
  *
  * Convert a clockdomain name stored in a struct omap_hwmod into a
  * clockdomain pointer, and save it into the struct omap_hwmod.
- * return -EINVAL if clkdm_name does not exist or if the lookup failed.
+ * Return -EINVAL if the clkdm_name lookup failed.
  */
 static int _init_clkdm(struct omap_hwmod *oh)
 {
 =09if (cpu_is_omap24xx() || cpu_is_omap34xx())
 =09=09return 0;
=20
-=09if (!oh->clkdm_name) {
-=09=09pr_warning("omap_hwmod: %s: no clkdm_name\n", oh->name);
-=09=09return -EINVAL;
-=09}
+=09if (!oh->clkdm_name)
+=09=09return 0;
=20
 =09oh->clkdm =3D clkdm_lookup(oh->clkdm_name);
 =09if (!oh->clkdm) {
diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-oma=
p2/omap_hwmod_44xx_data.c
index 950454a..e9e9ec0 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -2540,14 +2540,12 @@ static struct omap_hwmod omap44xx_prcm_mpu_hwmod =
=3D {
 static struct omap_hwmod omap44xx_cm_core_aon_hwmod =3D {
 =09.name=09=09=3D "cm_core_aon",
 =09.class=09=09=3D &omap44xx_prcm_hwmod_class,
-=09.clkdm_name=09=3D "cm_clkdm",
 };
=20
 /* cm_core */
 static struct omap_hwmod omap44xx_cm_core_hwmod =3D {
 =09.name=09=09=3D "cm_core",
 =09.class=09=09=3D &omap44xx_prcm_hwmod_class,
-=09.clkdm_name=09=3D "cm_clkdm",
 };
=20
 /* prm */
@@ -2564,7 +2562,6 @@ static struct omap_hwmod_rst_info omap44xx_prm_resets=
[] =3D {
 static struct omap_hwmod omap44xx_prm_hwmod =3D {
 =09.name=09=09=3D "prm",
 =09.class=09=09=3D &omap44xx_prcm_hwmod_class,
-=09.clkdm_name=09=3D "prm_clkdm",
 =09.mpu_irqs=09=3D omap44xx_prm_irqs,
 =09.rst_lines=09=3D omap44xx_prm_resets,
 =09.rst_lines_cnt=09=3D ARRAY_SIZE(omap44xx_prm_resets),
--=20
1.7.10

--155748971-1447425969-1339631032=:30212--

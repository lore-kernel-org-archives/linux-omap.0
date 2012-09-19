From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 1/5] ARM: OMAP2/3: hwmod: add RNG integration data
Date: Wed, 19 Sep 2012 01:13:41 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1209190110550.13435@utopia.booyaka.com>
References: <20120827232922.15045.56522.stgit@dusk.lan> <20120827233606.15045.59388.stgit@dusk.lan>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="843723315-1610042399-1348017221=:13435"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:55364 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751100Ab2ISBNm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 Sep 2012 21:13:42 -0400
In-Reply-To: <20120827233606.15045.59388.stgit@dusk.lan>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--843723315-1610042399-1348017221=:13435
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi

On Mon, 27 Aug 2012, Paul Walmsley wrote:

> Add integration data for the hardware random number generator IP block
> on some OMAP SoCs.  This appears to be present on OMAP2xxx and OMAP3xxx
> SoCs, although it is not so easy to tell.  It may also be present on
> other OMAP2+ SoCs.
>=20
> Signed-off-by: Paul Walmsley <paul@pwsan.com>

Found out what was causing the "omap_hwmod: rng: cannot be enabled for=20
reset (3)" messages; the CM code didn't recognize the CM_IDLEST4 register=
=20
as a valid idle status register, and returned an error.  Here's an updated=
=20
version of the patch that fixes the problem.


- Paul

From: Paul Walmsley <paul@pwsan.com>
Date: Tue, 18 Sep 2012 17:38:26 -0600
Subject: [PATCH] ARM: OMAP2xxx: hwmod/CM: add RNG integration data

Add integration data for the hardware random number generator IP block
on some OMAP SoCs.  This appears to be present on at least OMAP2xxx
and OMAP3xxx SoCs, although it is not so easy to tell.  It may also be
present on other OMAP2+ SoCs.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/cm2xxx_3xxx.c                  |    2 +-
 arch/arm/mach-omap2/cm2xxx_3xxx.h                  |    1 +
 arch/arm/mach-omap2/omap_hwmod_2420_data.c         |    1 +
 arch/arm/mach-omap2/omap_hwmod_2430_data.c         |    1 +
 .../mach-omap2/omap_hwmod_2xxx_interconnect_data.c |   17 +++++++++
 arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c |   37 ++++++++++++++++=
++++
 arch/arm/mach-omap2/omap_hwmod_common_data.h       |    5 +--
 7 files changed, 61 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/cm2xxx_3xxx.c b/arch/arm/mach-omap2/cm2xxx=
_3xxx.c
index 389f9f8..f01aa44 100644
--- a/arch/arm/mach-omap2/cm2xxx_3xxx.c
+++ b/arch/arm/mach-omap2/cm2xxx_3xxx.c
@@ -36,7 +36,7 @@
 #define OMAP2XXX_APLL_AUTOIDLE_LOW_POWER_STOP=09=090x3
=20
 static const u8 cm_idlest_offs[] =3D {
-=09CM_IDLEST1, CM_IDLEST2, OMAP2430_CM_IDLEST3
+=09CM_IDLEST1, CM_IDLEST2, OMAP2430_CM_IDLEST3, OMAP24XX_CM_IDLEST4
 };
=20
 u32 omap2_cm_read_mod_reg(s16 module, u16 idx)
diff --git a/arch/arm/mach-omap2/cm2xxx_3xxx.h b/arch/arm/mach-omap2/cm2xxx=
_3xxx.h
index 088bbad..57b2f3c 100644
--- a/arch/arm/mach-omap2/cm2xxx_3xxx.h
+++ b/arch/arm/mach-omap2/cm2xxx_3xxx.h
@@ -71,6 +71,7 @@
 #define OMAP24XX_CM_FCLKEN2=09=09=09=090x0004
 #define OMAP24XX_CM_ICLKEN4=09=09=09=090x001c
 #define OMAP24XX_CM_AUTOIDLE4=09=09=09=090x003c
+#define OMAP24XX_CM_IDLEST4=09=09=09=090x002c
=20
 #define OMAP2430_CM_IDLEST3=09=09=09=090x0028
=20
diff --git a/arch/arm/mach-omap2/omap_hwmod_2420_data.c b/arch/arm/mach-oma=
p2/omap_hwmod_2420_data.c
index 50cfab6..5a53287 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2420_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
@@ -587,6 +587,7 @@ static struct omap_hwmod_ocp_if *omap2420_hwmod_ocp_ifs=
[] __initdata =3D {
 =09&omap2420_l4_core__mcbsp1,
 =09&omap2420_l4_core__mcbsp2,
 =09&omap2420_l4_core__msdi1,
+=09&omap2xxx_l4_core__rng,
 =09&omap2420_l4_core__hdq1w,
 =09&omap2420_l4_wkup__counter_32k,
 =09NULL,
diff --git a/arch/arm/mach-omap2/omap_hwmod_2430_data.c b/arch/arm/mach-oma=
p2/omap_hwmod_2430_data.c
index 58b5bc1..256d8f6 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2430_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
@@ -947,6 +947,7 @@ static struct omap_hwmod_ocp_if *omap2430_hwmod_ocp_ifs=
[] __initdata =3D {
 =09&omap2430_l4_core__mcbsp4,
 =09&omap2430_l4_core__mcbsp5,
 =09&omap2430_l4_core__hdq1w,
+=09&omap2xxx_l4_core__rng,
 =09&omap2430_l4_wkup__counter_32k,
 =09NULL,
 };
diff --git a/arch/arm/mach-omap2/omap_hwmod_2xxx_interconnect_data.c b/arch=
/arm/mach-omap2/omap_hwmod_2xxx_interconnect_data.c
index 5178e40..14dc5ca 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2xxx_interconnect_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2xxx_interconnect_data.c
@@ -129,6 +129,15 @@ struct omap_hwmod_addr_space omap2xxx_mcbsp2_addrs[] =
=3D {
 =09{ }
 };
=20
+static struct omap_hwmod_addr_space omap2_rng_addr_space[] =3D {
+=09{
+=09=09.pa_start=09=3D 0x480a0000,
+=09=09.pa_end=09=09=3D 0x480a004f,
+=09=09.flags=09=09=3D ADDR_TYPE_RT
+=09},
+=09{ }
+};
+
 /*
  * Common interconnect data
  */
@@ -372,3 +381,11 @@ struct omap_hwmod_ocp_if omap2xxx_l4_core__dss_venc =
=3D {
 =09.user=09=09=3D OCP_USER_MPU | OCP_USER_SDMA,
 };
=20
+/* l4_core -> rng */
+struct omap_hwmod_ocp_if omap2xxx_l4_core__rng =3D {
+=09.master=09=09=3D &omap2xxx_l4_core_hwmod,
+=09.slave=09=09=3D &omap2xxx_rng_hwmod,
+=09.clk=09=09=3D "l4_ck",
+=09.addr=09=09=3D omap2_rng_addr_space,
+=09.user=09=09=3D OCP_USER_MPU | OCP_USER_SDMA,
+};
diff --git a/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c b/arch/arm/=
mach-omap2/omap_hwmod_2xxx_ipblock_data.c
index afad69c..06a37db 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c
@@ -745,3 +745,40 @@ struct omap_hwmod omap2xxx_counter_32k_hwmod =3D {
 =09},
 =09.class=09=09=3D &omap2xxx_counter_hwmod_class,
 };
+
+/* RNG */
+
+static struct omap_hwmod_class_sysconfig omap2_rng_sysc =3D {
+=09.rev_offs=09=3D 0x3c,
+=09.sysc_offs=09=3D 0x40,
+=09.syss_offs=09=3D 0x44,
+=09.sysc_flags=09=3D (SYSC_HAS_SOFTRESET | SYSC_HAS_AUTOIDLE |
+=09=09=09   SYSS_HAS_RESET_STATUS),
+=09.sysc_fields=09=3D &omap_hwmod_sysc_type1,
+};
+
+static struct omap_hwmod_class omap2_rng_hwmod_class =3D {
+=09.name=09=09=3D "rng",
+=09.sysc=09=09=3D &omap2_rng_sysc,
+};
+
+static struct omap_hwmod_irq_info omap2_rng_mpu_irqs[] =3D {
+=09{ .irq =3D 52 },
+=09{ .irq =3D -1 }
+};
+
+struct omap_hwmod omap2xxx_rng_hwmod =3D {
+=09.name=09=09=3D "rng",
+=09.mpu_irqs=09=3D omap2_rng_mpu_irqs,
+=09.main_clk=09=3D "l4_ck",
+=09.prcm=09=09=3D {
+=09=09.omap2 =3D {
+=09=09=09.module_offs =3D CORE_MOD,
+=09=09=09.prcm_reg_id =3D 4,
+=09=09=09.module_bit =3D OMAP24XX_EN_RNG_SHIFT,
+=09=09=09.idlest_reg_id =3D 4,
+=09=09=09.idlest_idle_bit =3D OMAP24XX_ST_RNG_SHIFT,
+=09=09},
+=09},
+=09.class=09=09=3D &omap2_rng_hwmod_class,
+};
diff --git a/arch/arm/mach-omap2/omap_hwmod_common_data.h b/arch/arm/mach-o=
map2/omap_hwmod_common_data.h
index e7e8eea..4363610 100644
--- a/arch/arm/mach-omap2/omap_hwmod_common_data.h
+++ b/arch/arm/mach-omap2/omap_hwmod_common_data.h
@@ -2,9 +2,8 @@
  * omap_hwmod_common_data.h - OMAP hwmod common macros and declarations
  *
  * Copyright (C) 2010-2011 Nokia Corporation
+ * Copyright (C) 2010-2012 Texas Instruments, Inc.
  * Paul Walmsley
- *
- * Copyright (C) 2010-2011 Texas Instruments, Inc.
  * Beno=C3=AEt Cousson
  *
  * This program is free software; you can redistribute it and/or modify
@@ -76,6 +75,7 @@ extern struct omap_hwmod omap2xxx_gpio4_hwmod;
 extern struct omap_hwmod omap2xxx_mcspi1_hwmod;
 extern struct omap_hwmod omap2xxx_mcspi2_hwmod;
 extern struct omap_hwmod omap2xxx_counter_32k_hwmod;
+extern struct omap_hwmod omap2xxx_rng_hwmod;
=20
 /* Common interface data across OMAP2xxx */
 extern struct omap_hwmod_ocp_if omap2xxx_l3_main__l4_core;
@@ -102,6 +102,7 @@ extern struct omap_hwmod_ocp_if omap2xxx_l4_core__dss;
 extern struct omap_hwmod_ocp_if omap2xxx_l4_core__dss_dispc;
 extern struct omap_hwmod_ocp_if omap2xxx_l4_core__dss_rfbi;
 extern struct omap_hwmod_ocp_if omap2xxx_l4_core__dss_venc;
+extern struct omap_hwmod_ocp_if omap2xxx_l4_core__rng;
=20
 /* Common IP block data */
 extern struct omap_hwmod_dma_info omap2_uart1_sdma_reqs[];
--=20
1.7.10.4

--843723315-1610042399-1348017221=:13435--

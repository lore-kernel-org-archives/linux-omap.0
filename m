From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCHv7 03/12] ARM: OMAP4: hwmod: flag hwmods/modules not
 supporting module level context status
Date: Wed, 12 Sep 2012 19:46:32 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1209121943390.17903@utopia.booyaka.com>
References: <1342704392-23657-1-git-send-email-t-kristo@ti.com> <1342704392-23657-4-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="843723315-327710853-1347479192=:17903"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:41144 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752801Ab2ILTqd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Sep 2012 15:46:33 -0400
In-Reply-To: <1342704392-23657-4-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, nm@ti.com, khilman@ti.com, rnayak@ti.com, linux-arm-kernel@lists.infradead.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--843723315-327710853-1347479192=:17903
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Tero,

On Thu, 19 Jul 2012, Tero Kristo wrote:

> On OMAP4 most modules/hwmods support module level context status. On
> OMAP3 and earlier, we relied on the power domain level context status.
> Identify all modules that don't support 'context_offs' by marking the
> offset as USHRT_MAX. Rest have a valid 'context_offs' populated in
> .prcm structure already.
>=20
> Signed-off-by: Tero Kristo <t-kristo@ti.com>

This one was changed here to use a separate flag rather than adding a=20
magic value to the context_offs field -- mostly because I've been burnt by=
=20
missing tests for those kinds of magic values in the past.  It should be=20
possible to roll the .modulemode field into this .flags field in a future=
=20
patch to eliminate any kernel object size changes. =20

The modified patch is below, queued for 3.7.


- Paul

From: Tero Kristo <t-kristo@ti.com>
Date: Wed, 12 Sep 2012 11:53:54 -0600
Subject: [PATCH] ARM: OMAP4: hwmod: flag hwmods/modules not supporting modu=
le
 level context status

On OMAP4 most modules/hwmods support module level context status. On
OMAP3 and earlier, we relied on the power domain level context status.
Identify all modules that don't support 'context_offs' by adding a
flag bit, HWMOD_OMAP4_NO_CONTEXT_LOSS_BIT.  Rest have a valid
'context_offs' populated in .prcm structure already.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
[paul@pwsan.com: add flag bit rather than overloading .context_offs;
 update changelog message]
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c   |   46 ++++++++++++++++++++++=
++++
 arch/arm/plat-omap/include/plat/omap_hwmod.h |   12 ++++++-
 2 files changed, 57 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-oma=
p2/omap_hwmod_44xx_data.c
index 242aee4..e4b0177 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -203,6 +203,7 @@ static struct omap_hwmod omap44xx_l4_abe_hwmod =3D {
 =09.prcm =3D {
 =09=09.omap4 =3D {
 =09=09=09.clkctrl_offs =3D OMAP4_CM1_ABE_L4ABE_CLKCTRL_OFFSET,
+=09=09=09.flags=09      =3D HWMOD_OMAP4_NO_CONTEXT_LOSS_BIT,
 =09=09},
 =09},
 };
@@ -259,6 +260,11 @@ static struct omap_hwmod omap44xx_mpu_private_hwmod =
=3D {
 =09.name=09=09=3D "mpu_private",
 =09.class=09=09=3D &omap44xx_mpu_bus_hwmod_class,
 =09.clkdm_name=09=3D "mpuss_clkdm",
+=09.prcm =3D {
+=09=09.omap4 =3D {
+=09=09=09.flags =3D HWMOD_OMAP4_NO_CONTEXT_LOSS_BIT,
+=09=09},
+=09},
 };
=20
 /*
@@ -447,6 +453,11 @@ static struct omap_hwmod omap44xx_ctrl_module_core_hwm=
od =3D {
 =09.class=09=09=3D &omap44xx_ctrl_module_hwmod_class,
 =09.clkdm_name=09=3D "l4_cfg_clkdm",
 =09.mpu_irqs=09=3D omap44xx_ctrl_module_core_irqs,
+=09.prcm =3D {
+=09=09.omap4 =3D {
+=09=09=09.flags =3D HWMOD_OMAP4_NO_CONTEXT_LOSS_BIT,
+=09=09},
+=09},
 };
=20
 /* ctrl_module_pad_core */
@@ -454,6 +465,11 @@ static struct omap_hwmod omap44xx_ctrl_module_pad_core=
_hwmod =3D {
 =09.name=09=09=3D "ctrl_module_pad_core",
 =09.class=09=09=3D &omap44xx_ctrl_module_hwmod_class,
 =09.clkdm_name=09=3D "l4_cfg_clkdm",
+=09.prcm =3D {
+=09=09.omap4 =3D {
+=09=09=09.flags =3D HWMOD_OMAP4_NO_CONTEXT_LOSS_BIT,
+=09=09},
+=09},
 };
=20
 /* ctrl_module_wkup */
@@ -461,6 +477,11 @@ static struct omap_hwmod omap44xx_ctrl_module_wkup_hwm=
od =3D {
 =09.name=09=09=3D "ctrl_module_wkup",
 =09.class=09=09=3D &omap44xx_ctrl_module_hwmod_class,
 =09.clkdm_name=09=3D "l4_wkup_clkdm",
+=09.prcm =3D {
+=09=09.omap4 =3D {
+=09=09=09.flags =3D HWMOD_OMAP4_NO_CONTEXT_LOSS_BIT,
+=09=09},
+=09},
 };
=20
 /* ctrl_module_pad_wkup */
@@ -468,6 +489,11 @@ static struct omap_hwmod omap44xx_ctrl_module_pad_wkup=
_hwmod =3D {
 =09.name=09=09=3D "ctrl_module_pad_wkup",
 =09.class=09=09=3D &omap44xx_ctrl_module_hwmod_class,
 =09.clkdm_name=09=3D "l4_wkup_clkdm",
+=09.prcm =3D {
+=09=09.omap4 =3D {
+=09=09=09.flags =3D HWMOD_OMAP4_NO_CONTEXT_LOSS_BIT,
+=09=09},
+=09},
 };
=20
 /*
@@ -2537,18 +2563,33 @@ static struct omap_hwmod omap44xx_prcm_mpu_hwmod =
=3D {
 =09.name=09=09=3D "prcm_mpu",
 =09.class=09=09=3D &omap44xx_prcm_hwmod_class,
 =09.clkdm_name=09=3D "l4_wkup_clkdm",
+=09.prcm =3D {
+=09=09.omap4 =3D {
+=09=09=09.flags =3D HWMOD_OMAP4_NO_CONTEXT_LOSS_BIT,
+=09=09},
+=09},
 };
=20
 /* cm_core_aon */
 static struct omap_hwmod omap44xx_cm_core_aon_hwmod =3D {
 =09.name=09=09=3D "cm_core_aon",
 =09.class=09=09=3D &omap44xx_prcm_hwmod_class,
+=09.prcm =3D {
+=09=09.omap4 =3D {
+=09=09=09.flags =3D HWMOD_OMAP4_NO_CONTEXT_LOSS_BIT,
+=09=09},
+=09},
 };
=20
 /* cm_core */
 static struct omap_hwmod omap44xx_cm_core_hwmod =3D {
 =09.name=09=09=3D "cm_core",
 =09.class=09=09=3D &omap44xx_prcm_hwmod_class,
+=09.prcm =3D {
+=09=09.omap4 =3D {
+=09=09=09.flags =3D HWMOD_OMAP4_NO_CONTEXT_LOSS_BIT,
+=09=09},
+=09},
 };
=20
 /* prm */
@@ -2584,6 +2625,11 @@ static struct omap_hwmod omap44xx_scrm_hwmod =3D {
 =09.name=09=09=3D "scrm",
 =09.class=09=09=3D &omap44xx_scrm_hwmod_class,
 =09.clkdm_name=09=3D "l4_wkup_clkdm",
+=09.prcm =3D {
+=09=09.omap4 =3D {
+=09=09=09.flags =3D HWMOD_OMAP4_NO_CONTEXT_LOSS_BIT,
+=09=09},
+=09},
 };
=20
 /*
diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/plat-o=
map/include/plat/omap_hwmod.h
index 6132972..fd038be 100644
--- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
+++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
@@ -2,7 +2,7 @@
  * omap_hwmod macros, structures
  *
  * Copyright (C) 2009-2011 Nokia Corporation
- * Copyright (C) 2011 Texas Instruments, Inc.
+ * Copyright (C) 2012 Texas Instruments, Inc.
  * Paul Walmsley
  *
  * Created in collaboration with (alphabetical order): Beno=EEt Cousson,
@@ -384,6 +384,14 @@ struct omap_hwmod_omap2_prcm {
 =09u8 idlest_stdby_bit;
 };
=20
+/*
+ * Possible values for struct omap_hwmod_omap4_prcm.flags
+ *
+ * HWMOD_OMAP4_NO_CONTEXT_LOSS_BIT: Some IP blocks don't have a PRCM
+ *     module-level context loss register associated with them; this
+ *     flag bit should be set in those cases
+ */
+#define HWMOD_OMAP4_NO_CONTEXT_LOSS_BIT=09=09(1 << 0)
=20
 /**
  * struct omap_hwmod_omap4_prcm - OMAP4-specific PRCM data
@@ -391,6 +399,7 @@ struct omap_hwmod_omap2_prcm {
  * @rstctrl_reg: address of the XXX_RSTCTRL register located in the PRM
  * @rstst_reg: (AM33XX only) address of the XXX_RSTST register in the PRM
  * @submodule_wkdep_bit: bit shift of the WKDEP range
+ * @flags: PRCM register capabilities for this IP block
  */
 struct omap_hwmod_omap4_prcm {
 =09u16=09=09clkctrl_offs;
@@ -399,6 +408,7 @@ struct omap_hwmod_omap4_prcm {
 =09u16=09=09context_offs;
 =09u8=09=09submodule_wkdep_bit;
 =09u8=09=09modulemode;
+=09u8=09=09flags;
 };
=20
=20
--=20
1.7.10.4

--843723315-327710853-1347479192=:17903--

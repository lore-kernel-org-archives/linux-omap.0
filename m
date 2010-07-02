From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v2 10/13] OMAP: create omap_devices for MPU, DSP, L3
Date: Fri, 2 Jul 2010 09:08:18 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1007020904420.13691@utopia.booyaka.com>
References: <1277423084-25528-1-git-send-email-khilman@deeprootsystems.com> <1277423084-25528-11-git-send-email-khilman@deeprootsystems.com> <87y6dxrblk.fsf@deeprootsystems.com> <alpine.DEB.2.00.1007020541081.13691@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-1440857109-1278083298=:13691"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:34430 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756158Ab0GBPIU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 2 Jul 2010 11:08:20 -0400
In-Reply-To: <alpine.DEB.2.00.1007020541081.13691@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-1440857109-1278083298=:13691
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi,

On Fri, 2 Jul 2010, Paul Walmsley wrote:

> On Tue, 29 Jun 2010, Kevin Hilman wrote:
>=20
> > Kevin Hilman <khilman@deeprootsystems.com> writes:
> >=20
> > > Create simple omap_devices for the main processors and busses.
> >=20
> > I've reworked this patch so that it is no longer using early devices,
> > updated version below.
>=20
> Thanks for these changes, this seems better than the early_platform_devic=
e=20
> approach.  I've made a few more changes:

Just FYI, after this patch, 2420 platforms (and presumably 2430 platforms=
=20
also) emit this warning on boot:

[    0.057067] WARNING: at arch/arm/mach-omap2/pm.c:53 _init_omap_device+0x=
80/0xa0()
[    0.057098] _init_omap_device: could not find omap_hwmod for iva
[    0.057128] Modules linked in:
[    0.057189] [<c002a580>] (unwind_backtrace+0x0/0xec) from [<c004a084>] (=
warn_slowpath_common+0x4c/0x64)
[    0.057250] [<c004a084>] (warn_slowpath_common+0x4c/0x64) from [<c004a11=
c>] (warn_slowpath_fmt+0x2c/0x3)
[    0.057342] [<c004a11c>] (warn_slowpath_fmt+0x2c/0x3c) from [<c002ef90>]=
 (_init_omap_device+0x80/0xa0)
[    0.057403] [<c002ef90>] (_init_omap_device+0x80/0xa0) from [<c000e360>]=
 (omap2_common_pm_init+0x20/0x4)
[    0.057495] [<c000e360>] (omap2_common_pm_init+0x20/0x48) from [<c002438=
4>] (do_one_initcall+0x5c/0x1b4)
[    0.057556] [<c0024384>] (do_one_initcall+0x5c/0x1b4) from [<c00083f8>] =
(kernel_init+0x90/0x144)
[    0.057647] [<c00083f8>] (kernel_init+0x90/0x144) from [<c0025dd0>] (ker=
nel_thread_exit+0x0/0x8)
[    0.057708] ---[ end trace dec6997083161631 ]---

This appears to be due to the lack of an IVA hwmod for 2420/2430, so I've=
=20
added one based on Beno=EEt's patch for 3xxx (below).  This fixes the=20
warnings.


- Paul


OMAP2: hwmod data: add IVA1 (2420), IVA2 (2430) hwmods

From: Paul Walmsley <paul@pwsan.com>

Add IVA1 hwmod data for OMAP2420 and IVA2 hwmod data for 2430.  The data
is based on Beno=EEt Cousson's hwmod data for the OMAP3 IVA blocks.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Beno=EEt Cousson <b-cousson@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/omap_hwmod_2420_data.c |   30 ++++++++++++++++++++++++=
++
 arch/arm/mach-omap2/omap_hwmod_2430_data.c |   32 ++++++++++++++++++++++++=
++--
 2 files changed, 60 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_2420_data.c b/arch/arm/mach-oma=
p2/omap_hwmod_2420_data.c
index 8c90b27..3cc768e 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2420_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
@@ -30,6 +30,7 @@
  */
=20
 static struct omap_hwmod omap2420_mpu_hwmod;
+static struct omap_hwmod omap2420_iva_hwmod;
 static struct omap_hwmod omap2420_l3_main_hwmod;
 static struct omap_hwmod omap2420_l4_core_hwmod;
=20
@@ -136,11 +137,40 @@ static struct omap_hwmod omap2420_mpu_hwmod =3D {
 =09.omap_chip=09=3D OMAP_CHIP_INIT(CHIP_IS_OMAP2420),
 };
=20
+/*
+ * IVA1 interface data
+ */
+
+/* IVA <- L3 interface */
+static struct omap_hwmod_ocp_if omap2420_l3__iva =3D {
+=09.master=09=09=3D &omap2420_l3_main_hwmod,
+=09.slave=09=09=3D &omap2420_iva_hwmod,
+=09.clk=09=09=3D "iva1_ifck",
+=09.user=09=09=3D OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+static struct omap_hwmod_ocp_if *omap2420_iva_masters[] =3D {
+=09&omap2420_l3__iva,
+};
+
+/*
+ * IVA2 (IVA2)
+ */
+
+static struct omap_hwmod omap2420_iva_hwmod =3D {
+=09.name=09=09=3D "iva",
+=09.class=09=09=3D &iva_hwmod_class,
+=09.masters=09=3D omap2420_iva_masters,
+=09.masters_cnt=09=3D ARRAY_SIZE(omap2420_iva_masters),
+=09.omap_chip=09=3D OMAP_CHIP_INIT(CHIP_IS_OMAP2420)
+};
+
 static __initdata struct omap_hwmod *omap2420_hwmods[] =3D {
 =09&omap2420_l3_main_hwmod,
 =09&omap2420_l4_core_hwmod,
 =09&omap2420_l4_wkup_hwmod,
 =09&omap2420_mpu_hwmod,
+=09&omap2420_iva_hwmod,
 =09NULL,
 };
=20
diff --git a/arch/arm/mach-omap2/omap_hwmod_2430_data.c b/arch/arm/mach-oma=
p2/omap_hwmod_2430_data.c
index c0f3311..4526628 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2430_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
@@ -30,6 +30,7 @@
  */
=20
 static struct omap_hwmod omap2430_mpu_hwmod;
+static struct omap_hwmod omap2430_iva_hwmod;
 static struct omap_hwmod omap2430_l3_main_hwmod;
 static struct omap_hwmod omap2430_l4_core_hwmod;
=20
@@ -70,8 +71,6 @@ static struct omap_hwmod omap2430_l3_main_hwmod =3D {
 };
=20
 static struct omap_hwmod omap2430_l4_wkup_hwmod;
-static struct omap_hwmod omap2430_mmc1_hwmod;
-static struct omap_hwmod omap2430_mmc2_hwmod;
=20
 /* L4_CORE -> L4_WKUP interface */
 static struct omap_hwmod_ocp_if omap2430_l4_core__l4_wkup =3D {
@@ -138,11 +137,40 @@ static struct omap_hwmod omap2430_mpu_hwmod =3D {
 =09.omap_chip=09=3D OMAP_CHIP_INIT(CHIP_IS_OMAP2430),
 };
=20
+/*
+ * IVA2_1 interface data
+ */
+
+/* IVA2 <- L3 interface */
+static struct omap_hwmod_ocp_if omap2430_l3__iva =3D {
+=09.master=09=09=3D &omap2430_l3_main_hwmod,
+=09.slave=09=09=3D &omap2430_iva_hwmod,
+=09.clk=09=09=3D "dsp_fck",
+=09.user=09=09=3D OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+static struct omap_hwmod_ocp_if *omap2430_iva_masters[] =3D {
+=09&omap2430_l3__iva,
+};
+
+/*
+ * IVA2 (IVA2)
+ */
+
+static struct omap_hwmod omap2430_iva_hwmod =3D {
+=09.name=09=09=3D "iva",
+=09.class=09=09=3D &iva_hwmod_class,
+=09.masters=09=3D omap2430_iva_masters,
+=09.masters_cnt=09=3D ARRAY_SIZE(omap2430_iva_masters),
+=09.omap_chip=09=3D OMAP_CHIP_INIT(CHIP_IS_OMAP2430)
+};
+
 static __initdata struct omap_hwmod *omap2430_hwmods[] =3D {
 =09&omap2430_l3_main_hwmod,
 =09&omap2430_l4_core_hwmod,
 =09&omap2430_l4_wkup_hwmod,
 =09&omap2430_mpu_hwmod,
+=09&omap2430_iva_hwmod,
 =09NULL,
 };
=20
--155748971-1440857109-1278083298=:13691--

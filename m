From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 16/20] OMAP2: hwmod data: add IVA1 (2420), IVA2 (2430) hwmods
Date: Fri, 02 Jul 2010 09:29:43 -0600
Message-ID: <20100702152939.6221.16377.stgit@localhost.localdomain>
References: <20100702152703.6221.33529.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:45304 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758820Ab0GBPbG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 2 Jul 2010 11:31:06 -0400
In-Reply-To: <20100702152703.6221.33529.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Kevin Hilman <khilman@deeprootsystems.com>, =?utf-8?q?Beno=C3=AEt?= Cousson <b-cousson@ti.com>

Add IVA1 hwmod data for OMAP2420 and IVA2 hwmod data for 2430.  The dat=
a
is based on Beno=C3=AEt Cousson's hwmod data for the OMAP3 IVA blocks.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Beno=C3=AEt Cousson <b-cousson@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/omap_hwmod_2420_data.c |   30 ++++++++++++++++++++=
++++++
 arch/arm/mach-omap2/omap_hwmod_2430_data.c |   32 ++++++++++++++++++++=
++++++--
 2 files changed, 60 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_2420_data.c b/arch/arm/mach=
-omap2/omap_hwmod_2420_data.c
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
 	.omap_chip	=3D OMAP_CHIP_INIT(CHIP_IS_OMAP2420),
 };
=20
+/*
+ * IVA1 interface data
+ */
+
+/* IVA <- L3 interface */
+static struct omap_hwmod_ocp_if omap2420_l3__iva =3D {
+	.master		=3D &omap2420_l3_main_hwmod,
+	.slave		=3D &omap2420_iva_hwmod,
+	.clk		=3D "iva1_ifck",
+	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+static struct omap_hwmod_ocp_if *omap2420_iva_masters[] =3D {
+	&omap2420_l3__iva,
+};
+
+/*
+ * IVA2 (IVA2)
+ */
+
+static struct omap_hwmod omap2420_iva_hwmod =3D {
+	.name		=3D "iva",
+	.class		=3D &iva_hwmod_class,
+	.masters	=3D omap2420_iva_masters,
+	.masters_cnt	=3D ARRAY_SIZE(omap2420_iva_masters),
+	.omap_chip	=3D OMAP_CHIP_INIT(CHIP_IS_OMAP2420)
+};
+
 static __initdata struct omap_hwmod *omap2420_hwmods[] =3D {
 	&omap2420_l3_main_hwmod,
 	&omap2420_l4_core_hwmod,
 	&omap2420_l4_wkup_hwmod,
 	&omap2420_mpu_hwmod,
+	&omap2420_iva_hwmod,
 	NULL,
 };
=20
diff --git a/arch/arm/mach-omap2/omap_hwmod_2430_data.c b/arch/arm/mach=
-omap2/omap_hwmod_2430_data.c
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
 	.omap_chip	=3D OMAP_CHIP_INIT(CHIP_IS_OMAP2430),
 };
=20
+/*
+ * IVA2_1 interface data
+ */
+
+/* IVA2 <- L3 interface */
+static struct omap_hwmod_ocp_if omap2430_l3__iva =3D {
+	.master		=3D &omap2430_l3_main_hwmod,
+	.slave		=3D &omap2430_iva_hwmod,
+	.clk		=3D "dsp_fck",
+	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+static struct omap_hwmod_ocp_if *omap2430_iva_masters[] =3D {
+	&omap2430_l3__iva,
+};
+
+/*
+ * IVA2 (IVA2)
+ */
+
+static struct omap_hwmod omap2430_iva_hwmod =3D {
+	.name		=3D "iva",
+	.class		=3D &iva_hwmod_class,
+	.masters	=3D omap2430_iva_masters,
+	.masters_cnt	=3D ARRAY_SIZE(omap2430_iva_masters),
+	.omap_chip	=3D OMAP_CHIP_INIT(CHIP_IS_OMAP2430)
+};
+
 static __initdata struct omap_hwmod *omap2430_hwmods[] =3D {
 	&omap2430_l3_main_hwmod,
 	&omap2430_l4_core_hwmod,
 	&omap2430_l4_wkup_hwmod,
 	&omap2430_mpu_hwmod,
+	&omap2430_iva_hwmod,
 	NULL,
 };
=20


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

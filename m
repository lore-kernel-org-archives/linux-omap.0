From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 11/15] ARM: OMAP4: hwmod data: add OCM RAM IP block
Date: Thu, 08 Mar 2012 03:51:35 -0700
Message-ID: <20120308105134.14753.63101.stgit@dusk>
References: <20120308104918.14753.69281.stgit@dusk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:47073 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752575Ab2CHKxh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Mar 2012 05:53:37 -0500
In-Reply-To: <20120308104918.14753.69281.stgit@dusk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: =?utf-8?q?Beno=C3=AEt?= Cousson <b-cousson@ti.com>

Add the OCM RAM IP block and interconnect data.  This is an oh-chip
block of SRAM connected directly to the L3 bus.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Beno=C3=AEt Cousson <b-cousson@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   32 ++++++++++++++++++++=
+++++++-
 1 files changed, 31 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach=
-omap2/omap_hwmod_44xx_data.c
index 968feb0..f48fe77 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -280,7 +280,6 @@ static struct omap_hwmod omap44xx_mpu_private_hwmod=
 =3D {
  *  efuse_ctrl_std
  *  mpu_c0
  *  mpu_c1
- *  ocmc_ram
  *  ocp_wp_noc
  *  prcm_mpu
  *  prm
@@ -2356,6 +2355,28 @@ static struct omap_hwmod omap44xx_mpu_hwmod =3D =
{
 };
=20
 /*
+ * 'ocmc_ram' class
+ * top-level core on-chip ram
+ */
+
+static struct omap_hwmod_class omap44xx_ocmc_ram_hwmod_class =3D {
+	.name	=3D "ocmc_ram",
+};
+
+/* ocmc_ram */
+static struct omap_hwmod omap44xx_ocmc_ram_hwmod =3D {
+	.name		=3D "ocmc_ram",
+	.class		=3D &omap44xx_ocmc_ram_hwmod_class,
+	.clkdm_name	=3D "l3_2_clkdm",
+	.prcm =3D {
+		.omap4 =3D {
+			.clkctrl_offs =3D OMAP4_CM_L3_2_OCMC_RAM_CLKCTRL_OFFSET,
+			.context_offs =3D OMAP4_RM_L3_2_OCMC_RAM_CONTEXT_OFFSET,
+		},
+	},
+};
+
+/*
  * 'ocp2scp' class
  * bridge to transform ocp interface protocol to scp (serial control p=
ort)
  * protocol
@@ -4923,6 +4944,14 @@ static struct omap_hwmod_ocp_if omap44xx_l4_per_=
_mmc5 =3D {
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
 };
=20
+/* l3_main_2 -> ocmc_ram */
+static struct omap_hwmod_ocp_if omap44xx_l3_main_2__ocmc_ram =3D {
+	.master		=3D &omap44xx_l3_main_2_hwmod,
+	.slave		=3D &omap44xx_ocmc_ram_hwmod,
+	.clk		=3D "l3_div_ck",
+	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
+};
+
 /* l4_cfg -> ocp2scp_usb_phy */
 static struct omap_hwmod_ocp_if omap44xx_l4_cfg__ocp2scp_usb_phy =3D {
 	.master		=3D &omap44xx_l4_cfg_hwmod,
@@ -5654,6 +5683,7 @@ static struct omap_hwmod_ocp_if *omap44xx_hwmod_o=
cp_ifs[] __initdata =3D {
 	&omap44xx_l4_per__mmc3,
 	&omap44xx_l4_per__mmc4,
 	&omap44xx_l4_per__mmc5,
+	&omap44xx_l3_main_2__ocmc_ram,
 	&omap44xx_l4_cfg__ocp2scp_usb_phy,
 	&omap44xx_l3_main_2__sl2if,
 	&omap44xx_l4_abe__slimbus1,


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

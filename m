From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 12/15] ARM: OMAP4: hwmod data: add the OCP-WP IP block
Date: Thu, 08 Mar 2012 03:51:35 -0700
Message-ID: <20120308105135.14753.5020.stgit@dusk>
References: <20120308104918.14753.69281.stgit@dusk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:47076 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753355Ab2CHKxh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Mar 2012 05:53:37 -0500
In-Reply-To: <20120308104918.14753.69281.stgit@dusk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: =?utf-8?q?Beno=C3=AEt?= Cousson <b-cousson@ti.com>

=46rom: Beno=C3=AEt Cousson <b-cousson@ti.com>

Add the OCP-WP hwmod and associated interconnect data.  The OCP-WP,
or OCP watchpoint, can be used to collect interconnect data and
transmit it via the STM port.

Signed-off-by: Beno=C3=AEt Cousson <b-cousson@ti.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   51 ++++++++++++++++++++=
+++++++-
 1 files changed, 50 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach=
-omap2/omap_hwmod_44xx_data.c
index f48fe77..5c89307 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -262,6 +262,28 @@ static struct omap_hwmod omap44xx_mpu_private_hwmo=
d =3D {
 };
=20
 /*
+ * 'ocp_wp_noc' class
+ * instance(s): ocp_wp_noc
+ */
+static struct omap_hwmod_class omap44xx_ocp_wp_noc_hwmod_class =3D {
+	.name	=3D "ocp_wp_noc",
+};
+
+/* ocp_wp_noc */
+static struct omap_hwmod omap44xx_ocp_wp_noc_hwmod =3D {
+	.name		=3D "ocp_wp_noc",
+	.class		=3D &omap44xx_ocp_wp_noc_hwmod_class,
+	.clkdm_name	=3D "l3_instr_clkdm",
+	.prcm =3D {
+		.omap4 =3D {
+			.clkctrl_offs =3D OMAP4_CM_L3INSTR_OCP_WP1_CLKCTRL_OFFSET,
+			.context_offs =3D OMAP4_RM_L3INSTR_OCP_WP1_CONTEXT_OFFSET,
+			.modulemode   =3D MODULEMODE_HWCTRL,
+		},
+	},
+};
+
+/*
  * Modules omap_hwmod structures
  *
  * The following IPs are excluded for the moment because:
@@ -280,7 +302,6 @@ static struct omap_hwmod omap44xx_mpu_private_hwmod=
 =3D {
  *  efuse_ctrl_std
  *  mpu_c0
  *  mpu_c1
- *  ocp_wp_noc
  *  prcm_mpu
  *  prm
  *  scrm
@@ -3494,6 +3515,14 @@ static struct omap_hwmod_ocp_if omap44xx_l3_main=
_3__l3_instr =3D {
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
 };
=20
+/* ocp_wp_noc -> l3_instr */
+static struct omap_hwmod_ocp_if omap44xx_ocp_wp_noc__l3_instr =3D {
+	.master		=3D &omap44xx_ocp_wp_noc_hwmod,
+	.slave		=3D &omap44xx_l3_instr_hwmod,
+	.clk		=3D "l3_div_ck",
+	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
+};
+
 /* dsp -> l3_main_1 */
 static struct omap_hwmod_ocp_if omap44xx_dsp__l3_main_1 =3D {
 	.master		=3D &omap44xx_dsp_hwmod,
@@ -3772,6 +3801,24 @@ static struct omap_hwmod_ocp_if omap44xx_mpu__mp=
u_private =3D {
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
 };
=20
+static struct omap_hwmod_addr_space omap44xx_ocp_wp_noc_addrs[] =3D {
+	{
+		.pa_start	=3D 0x4a102000,
+		.pa_end		=3D 0x4a10207f,
+		.flags		=3D ADDR_TYPE_RT
+	},
+	{ }
+};
+
+/* l4_cfg -> ocp_wp_noc */
+static struct omap_hwmod_ocp_if omap44xx_l4_cfg__ocp_wp_noc =3D {
+	.master		=3D &omap44xx_l4_cfg_hwmod,
+	.slave		=3D &omap44xx_ocp_wp_noc_hwmod,
+	.clk		=3D "l4_div_ck",
+	.addr		=3D omap44xx_ocp_wp_noc_addrs,
+	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
+};
+
 static struct omap_hwmod_addr_space omap44xx_aess_addrs[] =3D {
 	{
 		.pa_start	=3D 0x401f1000,
@@ -5584,6 +5631,7 @@ static struct omap_hwmod_ocp_if *omap44xx_hwmod_o=
cp_ifs[] __initdata =3D {
 	&omap44xx_l4_cfg__emif_fw,
 	&omap44xx_iva__l3_instr,
 	&omap44xx_l3_main_3__l3_instr,
+	&omap44xx_ocp_wp_noc__l3_instr,
 	&omap44xx_dsp__l3_main_1,
 	&omap44xx_dss__l3_main_1,
 	&omap44xx_l3_main_2__l3_main_1,
@@ -5615,6 +5663,7 @@ static struct omap_hwmod_ocp_if *omap44xx_hwmod_o=
cp_ifs[] __initdata =3D {
 	&omap44xx_l3_main_2__l4_per,
 	&omap44xx_l4_cfg__l4_wkup,
 	&omap44xx_mpu__mpu_private,
+	&omap44xx_l4_cfg__ocp_wp_noc,
 	&omap44xx_l4_abe__aess,
 	&omap44xx_l4_abe__aess_dma,
 	&omap44xx_l3_main_2__c2c,


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

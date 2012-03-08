From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 14/15] ARM: OMAP4: hwmod data: add PRCM and related IP blocks
Date: Thu, 08 Mar 2012 03:51:37 -0700
Message-ID: <20120308105136.14753.4296.stgit@dusk>
References: <20120308104918.14753.69281.stgit@dusk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:47082 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752630Ab2CHKxi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Mar 2012 05:53:38 -0500
In-Reply-To: <20120308104918.14753.69281.stgit@dusk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: =?utf-8?q?Beno=C3=AEt?= Cousson <b-cousson@ti.com>

Add the PRCM, CM, PRM, and related hwmod and associated interconnect
data.  These IP blocks handle most of the on-chip power, reset, and clo=
ck
control.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Beno=C3=AEt Cousson <b-cousson@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |  167 ++++++++++++++++++++=
+++++++-
 1 files changed, 162 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach=
-omap2/omap_hwmod_44xx_data.c
index ccc1249..a01d91f 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -291,16 +291,11 @@ static struct omap_hwmod omap44xx_ocp_wp_noc_hwmo=
d =3D {
  * - They still need to be validated with the driver
  *   properly adapted to omap_hwmod / omap_device
  *
- *  cm_core
- *  cm_core_aon
  *  debugss
  *  efuse_ctrl_cust
  *  efuse_ctrl_std
  *  mpu_c0
  *  mpu_c1
- *  prcm_mpu
- *  prm
- *  scrm
  *  usb_phy_cm
  *  usim
  */
@@ -2478,6 +2473,73 @@ static struct omap_hwmod omap44xx_ocp2scp_usb_ph=
y_hwmod =3D {
 };
=20
 /*
+ * 'prcm' class
+ * power and reset manager (part of the prcm infrastructure) + clock m=
anager 2
+ * + clock manager 1 (in always on power domain) + local prm in mpu
+ */
+
+static struct omap_hwmod_class omap44xx_prcm_hwmod_class =3D {
+	.name	=3D "prcm",
+};
+
+/* prcm_mpu */
+static struct omap_hwmod omap44xx_prcm_mpu_hwmod =3D {
+	.name		=3D "prcm_mpu",
+	.class		=3D &omap44xx_prcm_hwmod_class,
+	.clkdm_name	=3D "l4_wkup_clkdm",
+};
+
+/* cm_core_aon */
+static struct omap_hwmod omap44xx_cm_core_aon_hwmod =3D {
+	.name		=3D "cm_core_aon",
+	.class		=3D &omap44xx_prcm_hwmod_class,
+	.clkdm_name	=3D "cm_clkdm",
+};
+
+/* cm_core */
+static struct omap_hwmod omap44xx_cm_core_hwmod =3D {
+	.name		=3D "cm_core",
+	.class		=3D &omap44xx_prcm_hwmod_class,
+	.clkdm_name	=3D "cm_clkdm",
+};
+
+/* prm */
+static struct omap_hwmod_irq_info omap44xx_prm_irqs[] =3D {
+	{ .irq =3D 11 + OMAP44XX_IRQ_GIC_START },
+	{ .irq =3D -1 }
+};
+
+static struct omap_hwmod_rst_info omap44xx_prm_resets[] =3D {
+	{ .name =3D "rst_global_warm_sw", .rst_shift =3D 0 },
+	{ .name =3D "rst_global_cold_sw", .rst_shift =3D 1 },
+};
+
+static struct omap_hwmod omap44xx_prm_hwmod =3D {
+	.name		=3D "prm",
+	.class		=3D &omap44xx_prcm_hwmod_class,
+	.clkdm_name	=3D "prm_clkdm",
+	.mpu_irqs	=3D omap44xx_prm_irqs,
+	.rst_lines	=3D omap44xx_prm_resets,
+	.rst_lines_cnt	=3D ARRAY_SIZE(omap44xx_prm_resets),
+};
+
+/*
+ * 'scrm' class
+ * system clock and reset manager
+ */
+
+static struct omap_hwmod_class omap44xx_scrm_hwmod_class =3D {
+	.name	=3D "scrm",
+};
+
+/* scrm */
+static struct omap_hwmod omap44xx_scrm_hwmod =3D {
+	.name		=3D "scrm",
+	.class		=3D &omap44xx_scrm_hwmod_class,
+	.clkdm_name	=3D "l4_wkup_clkdm",
+};
+
+/*
  * 'sl2if' class
  * shared level 2 memory interface
  */
@@ -5129,6 +5191,96 @@ static struct omap_hwmod_ocp_if omap44xx_l4_cfg_=
_ocp2scp_usb_phy =3D {
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
 };
=20
+static struct omap_hwmod_addr_space omap44xx_prcm_mpu_addrs[] =3D {
+	{
+		.pa_start	=3D 0x48243000,
+		.pa_end		=3D 0x48243fff,
+		.flags		=3D ADDR_TYPE_RT
+	},
+	{ }
+};
+
+/* mpu_private -> prcm_mpu */
+static struct omap_hwmod_ocp_if omap44xx_mpu_private__prcm_mpu =3D {
+	.master		=3D &omap44xx_mpu_private_hwmod,
+	.slave		=3D &omap44xx_prcm_mpu_hwmod,
+	.clk		=3D "l3_div_ck",
+	.addr		=3D omap44xx_prcm_mpu_addrs,
+	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+static struct omap_hwmod_addr_space omap44xx_cm_core_aon_addrs[] =3D {
+	{
+		.pa_start	=3D 0x4a004000,
+		.pa_end		=3D 0x4a004fff,
+		.flags		=3D ADDR_TYPE_RT
+	},
+	{ }
+};
+
+/* l4_wkup -> cm_core_aon */
+static struct omap_hwmod_ocp_if omap44xx_l4_wkup__cm_core_aon =3D {
+	.master		=3D &omap44xx_l4_wkup_hwmod,
+	.slave		=3D &omap44xx_cm_core_aon_hwmod,
+	.clk		=3D "l4_wkup_clk_mux_ck",
+	.addr		=3D omap44xx_cm_core_aon_addrs,
+	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+static struct omap_hwmod_addr_space omap44xx_cm_core_addrs[] =3D {
+	{
+		.pa_start	=3D 0x4a008000,
+		.pa_end		=3D 0x4a009fff,
+		.flags		=3D ADDR_TYPE_RT
+	},
+	{ }
+};
+
+/* l4_cfg -> cm_core */
+static struct omap_hwmod_ocp_if omap44xx_l4_cfg__cm_core =3D {
+	.master		=3D &omap44xx_l4_cfg_hwmod,
+	.slave		=3D &omap44xx_cm_core_hwmod,
+	.clk		=3D "l4_div_ck",
+	.addr		=3D omap44xx_cm_core_addrs,
+	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+static struct omap_hwmod_addr_space omap44xx_prm_addrs[] =3D {
+	{
+		.pa_start	=3D 0x4a306000,
+		.pa_end		=3D 0x4a307fff,
+		.flags		=3D ADDR_TYPE_RT
+	},
+	{ }
+};
+
+/* l4_wkup -> prm */
+static struct omap_hwmod_ocp_if omap44xx_l4_wkup__prm =3D {
+	.master		=3D &omap44xx_l4_wkup_hwmod,
+	.slave		=3D &omap44xx_prm_hwmod,
+	.clk		=3D "l4_wkup_clk_mux_ck",
+	.addr		=3D omap44xx_prm_addrs,
+	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+static struct omap_hwmod_addr_space omap44xx_scrm_addrs[] =3D {
+	{
+		.pa_start	=3D 0x4a30a000,
+		.pa_end		=3D 0x4a30a7ff,
+		.flags		=3D ADDR_TYPE_RT
+	},
+	{ }
+};
+
+/* l4_wkup -> scrm */
+static struct omap_hwmod_ocp_if omap44xx_l4_wkup__scrm =3D {
+	.master		=3D &omap44xx_l4_wkup_hwmod,
+	.slave		=3D &omap44xx_scrm_hwmod,
+	.clk		=3D "l4_wkup_clk_mux_ck",
+	.addr		=3D omap44xx_scrm_addrs,
+	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
+};
+
 /* l3_main_2 -> sl2if */
 static struct omap_hwmod_ocp_if omap44xx_l3_main_2__sl2if =3D {
 	.master		=3D &omap44xx_l3_main_2_hwmod,
@@ -5860,6 +6012,11 @@ static struct omap_hwmod_ocp_if *omap44xx_hwmod_=
ocp_ifs[] __initdata =3D {
 	&omap44xx_l4_per__mmc5,
 	&omap44xx_l3_main_2__ocmc_ram,
 	&omap44xx_l4_cfg__ocp2scp_usb_phy,
+	&omap44xx_mpu_private__prcm_mpu,
+	&omap44xx_l4_wkup__cm_core_aon,
+	&omap44xx_l4_cfg__cm_core,
+	&omap44xx_l4_wkup__prm,
+	&omap44xx_l4_wkup__scrm,
 	&omap44xx_l3_main_2__sl2if,
 	&omap44xx_l4_abe__slimbus1,
 	&omap44xx_l4_abe__slimbus1_dma,


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

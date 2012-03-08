From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 15/15] ARM: OMAP4: hwmod data: add DEBUGSS skeleton
Date: Thu, 08 Mar 2012 03:51:37 -0700
Message-ID: <20120308105137.14753.19864.stgit@dusk>
References: <20120308104918.14753.69281.stgit@dusk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:47085 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752760Ab2CHKxi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Mar 2012 05:53:38 -0500
In-Reply-To: <20120308104918.14753.69281.stgit@dusk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: =?utf-8?q?Beno=C3=AEt?= Cousson <b-cousson@ti.com>

=46rom: Beno=C3=AEt Cousson <b-cousson@ti.com>

Add a skeleton hwmod for the DEBUGSS and associated interconnect data.
This is a basic set of data that will need further additions as
further DEBUGSS information becomes available.

Signed-off-by: Beno=C3=AEt Cousson <b-cousson@ti.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   59 ++++++++++++++++++++=
+++++---
 1 files changed, 52 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach=
-omap2/omap_hwmod_44xx_data.c
index a01d91f..2044c80 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -291,13 +291,7 @@ static struct omap_hwmod omap44xx_ocp_wp_noc_hwmod=
 =3D {
  * - They still need to be validated with the driver
  *   properly adapted to omap_hwmod / omap_device
  *
- *  debugss
- *  efuse_ctrl_cust
- *  efuse_ctrl_std
- *  mpu_c0
- *  mpu_c1
- *  usb_phy_cm
- *  usim
+ * usim
  */
=20
 /*
@@ -478,6 +472,29 @@ static struct omap_hwmod omap44xx_ctrl_module_pad_=
wkup_hwmod =3D {
 };
=20
 /*
+ * 'debugss' class
+ * debug and emulation sub system
+ */
+
+static struct omap_hwmod_class omap44xx_debugss_hwmod_class =3D {
+	.name	=3D "debugss",
+};
+
+/* debugss */
+static struct omap_hwmod omap44xx_debugss_hwmod =3D {
+	.name		=3D "debugss",
+	.class		=3D &omap44xx_debugss_hwmod_class,
+	.clkdm_name	=3D "emu_sys_clkdm",
+	.main_clk	=3D "trace_clk_div_ck",
+	.prcm =3D {
+		.omap4 =3D {
+			.clkctrl_offs =3D OMAP4_CM_EMU_DEBUGSS_CLKCTRL_OFFSET,
+			.context_offs =3D OMAP4_RM_EMU_DEBUGSS_CONTEXT_OFFSET,
+		},
+	},
+};
+
+/*
  * 'dma' class
  * dma controller for data exchange between memory to memory (i.e. int=
ernal or
  * external memory) and gp peripherals to memory or memory to gp perip=
herals
@@ -3709,6 +3726,14 @@ static struct omap_hwmod_ocp_if omap44xx_c2c_tar=
get_fw__l3_main_2 =3D {
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
 };
=20
+/* debugss -> l3_main_2 */
+static struct omap_hwmod_ocp_if omap44xx_debugss__l3_main_2 =3D {
+	.master		=3D &omap44xx_debugss_hwmod,
+	.slave		=3D &omap44xx_l3_main_2_hwmod,
+	.clk		=3D "dbgclk_mux_ck",
+	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
+};
+
 /* dma_system -> l3_main_2 */
 static struct omap_hwmod_ocp_if omap44xx_dma_system__l3_main_2 =3D {
 	.master		=3D &omap44xx_dma_system_hwmod,
@@ -4065,6 +4090,24 @@ static struct omap_hwmod_ocp_if omap44xx_l4_wkup=
__ctrl_module_pad_wkup =3D {
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
 };
=20
+static struct omap_hwmod_addr_space omap44xx_debugss_addrs[] =3D {
+	{
+		.pa_start	=3D 0x54160000,
+		.pa_end		=3D 0x54167fff,
+		.flags		=3D ADDR_TYPE_RT
+	},
+	{ }
+};
+
+/* l3_instr -> debugss */
+static struct omap_hwmod_ocp_if omap44xx_l3_instr__debugss =3D {
+	.master		=3D &omap44xx_l3_instr_hwmod,
+	.slave		=3D &omap44xx_debugss_hwmod,
+	.clk		=3D "l3_div_ck",
+	.addr		=3D omap44xx_debugss_addrs,
+	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
+};
+
 static struct omap_hwmod_addr_space omap44xx_dma_system_addrs[] =3D {
 	{
 		.pa_start	=3D 0x4a056000,
@@ -5914,6 +5957,7 @@ static struct omap_hwmod_ocp_if *omap44xx_hwmod_o=
cp_ifs[] __initdata =3D {
 	&omap44xx_mmc2__l3_main_1,
 	&omap44xx_mpu__l3_main_1,
 	&omap44xx_c2c_target_fw__l3_main_2,
+	&omap44xx_debugss__l3_main_2,
 	&omap44xx_dma_system__l3_main_2,
 	&omap44xx_fdif__l3_main_2,
 	&omap44xx_gpu__l3_main_2,
@@ -5946,6 +5990,7 @@ static struct omap_hwmod_ocp_if *omap44xx_hwmod_o=
cp_ifs[] __initdata =3D {
 	&omap44xx_l4_cfg__ctrl_module_pad_core,
 	&omap44xx_l4_wkup__ctrl_module_wkup,
 	&omap44xx_l4_wkup__ctrl_module_pad_wkup,
+	&omap44xx_l3_instr__debugss,
 	&omap44xx_l4_cfg__dma_system,
 	&omap44xx_l4_abe__dmic,
 	&omap44xx_l4_abe__dmic_dma,


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 10/15] ARM: OMAP4: hwmod data: add remaining USB-related IP
 blocks
Date: Thu, 08 Mar 2012 03:51:34 -0700
Message-ID: <20120308105133.14753.73322.stgit@dusk>
References: <20120308104918.14753.69281.stgit@dusk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:47069 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753339Ab2CHKxh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Mar 2012 05:53:37 -0500
In-Reply-To: <20120308104918.14753.69281.stgit@dusk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: =?utf-8?q?Beno=C3=AEt?= Cousson <b-cousson@ti.com>, Felipe Balbi <balbi@ti.com>

=46rom: Beno=C3=AEt Cousson <b-cousson@ti.com>

Add the OCP2SCP IP block and interconnect data.  The OCP2SCP can be
used in conjunction with the on-chip embedded USB PHY, associated with
the OTG controller.

Add the on-chip full-speed USB host controller IP block and
interconnect data.

Cc: Felipe Balbi <balbi@ti.com>
Signed-off-by: Beno=C3=AEt Cousson <b-cousson@ti.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |  120 ++++++++++++++++++++=
+++++++-
 1 files changed, 116 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach=
-omap2/omap_hwmod_44xx_data.c
index 8d3a7c1..968feb0 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -281,15 +281,11 @@ static struct omap_hwmod omap44xx_mpu_private_hwm=
od =3D {
  *  mpu_c0
  *  mpu_c1
  *  ocmc_ram
- *  ocp2scp_usb_phy
  *  ocp_wp_noc
  *  prcm_mpu
  *  prm
  *  scrm
- *  usb_host_fs
- *  usb_host_hs
  *  usb_phy_cm
- *  usb_tll_hs
  *  usim
  */
=20
@@ -2360,6 +2356,36 @@ static struct omap_hwmod omap44xx_mpu_hwmod =3D =
{
 };
=20
 /*
+ * 'ocp2scp' class
+ * bridge to transform ocp interface protocol to scp (serial control p=
ort)
+ * protocol
+ */
+
+static struct omap_hwmod_class omap44xx_ocp2scp_hwmod_class =3D {
+	.name	=3D "ocp2scp",
+};
+
+/* ocp2scp_usb_phy */
+static struct omap_hwmod_opt_clk ocp2scp_usb_phy_opt_clks[] =3D {
+	{ .role =3D "phy_48m", .clk =3D "ocp2scp_usb_phy_phy_48m" },
+};
+
+static struct omap_hwmod omap44xx_ocp2scp_usb_phy_hwmod =3D {
+	.name		=3D "ocp2scp_usb_phy",
+	.class		=3D &omap44xx_ocp2scp_hwmod_class,
+	.clkdm_name	=3D "l3_init_clkdm",
+	.prcm =3D {
+		.omap4 =3D {
+			.clkctrl_offs =3D OMAP4_CM_L3INIT_USBPHYOCP2SCP_CLKCTRL_OFFSET,
+			.context_offs =3D OMAP4_RM_L3INIT_USBPHYOCP2SCP_CONTEXT_OFFSET,
+			.modulemode   =3D MODULEMODE_HWCTRL,
+		},
+	},
+	.opt_clks	=3D ocp2scp_usb_phy_opt_clks,
+	.opt_clks_cnt	=3D ARRAY_SIZE(ocp2scp_usb_phy_opt_clks),
+};
+
+/*
  * 'sl2if' class
  * shared level 2 memory interface
  */
@@ -3042,6 +3068,55 @@ static struct omap_hwmod omap44xx_uart4_hwmod =3D=
 {
 };
=20
 /*
+ * 'usb_host_fs' class
+ * full-speed usb host controller
+ */
+
+/* The IP is not compliant to type1 / type2 scheme */
+static struct omap_hwmod_sysc_fields omap_hwmod_sysc_type_usb_host_fs =
=3D {
+	.midle_shift	=3D 4,
+	.sidle_shift	=3D 2,
+	.srst_shift	=3D 1,
+};
+
+static struct omap_hwmod_class_sysconfig omap44xx_usb_host_fs_sysc =3D=
 {
+	.rev_offs	=3D 0x0000,
+	.sysc_offs	=3D 0x0210,
+	.sysc_flags	=3D (SYSC_HAS_MIDLEMODE | SYSC_HAS_SIDLEMODE |
+			   SYSC_HAS_SOFTRESET),
+	.idlemodes	=3D (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART |
+			   SIDLE_SMART_WKUP),
+	.sysc_fields	=3D &omap_hwmod_sysc_type_usb_host_fs,
+};
+
+static struct omap_hwmod_class omap44xx_usb_host_fs_hwmod_class =3D {
+	.name	=3D "usb_host_fs",
+	.sysc	=3D &omap44xx_usb_host_fs_sysc,
+};
+
+/* usb_host_fs */
+static struct omap_hwmod_irq_info omap44xx_usb_host_fs_irqs[] =3D {
+	{ .name =3D "std", .irq =3D 89 + OMAP44XX_IRQ_GIC_START },
+	{ .name =3D "smi", .irq =3D 90 + OMAP44XX_IRQ_GIC_START },
+	{ .irq =3D -1 }
+};
+
+static struct omap_hwmod omap44xx_usb_host_fs_hwmod =3D {
+	.name		=3D "usb_host_fs",
+	.class		=3D &omap44xx_usb_host_fs_hwmod_class,
+	.clkdm_name	=3D "l3_init_clkdm",
+	.mpu_irqs	=3D omap44xx_usb_host_fs_irqs,
+	.main_clk	=3D "usb_host_fs_fck",
+	.prcm =3D {
+		.omap4 =3D {
+			.clkctrl_offs =3D OMAP4_CM_L3INIT_USB_HOST_FS_CLKCTRL_OFFSET,
+			.context_offs =3D OMAP4_RM_L3INIT_USB_HOST_FS_CONTEXT_OFFSET,
+			.modulemode   =3D MODULEMODE_SWCTRL,
+		},
+	},
+};
+
+/*
  * 'usb_host_hs' class
  * high-speed multi-port usb host controller
  */
@@ -3554,6 +3629,14 @@ static struct omap_hwmod_ocp_if omap44xx_l4_cfg_=
_l3_main_2 =3D {
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
 };
=20
+/* usb_host_fs -> l3_main_2 */
+static struct omap_hwmod_ocp_if omap44xx_usb_host_fs__l3_main_2 =3D {
+	.master		=3D &omap44xx_usb_host_fs_hwmod,
+	.slave		=3D &omap44xx_l3_main_2_hwmod,
+	.clk		=3D "l3_div_ck",
+	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
+};
+
 /* usb_host_hs -> l3_main_2 */
 static struct omap_hwmod_ocp_if omap44xx_usb_host_hs__l3_main_2 =3D {
 	.master		=3D &omap44xx_usb_host_hs_hwmod,
@@ -4840,6 +4923,14 @@ static struct omap_hwmod_ocp_if omap44xx_l4_per_=
_mmc5 =3D {
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
 };
=20
+/* l4_cfg -> ocp2scp_usb_phy */
+static struct omap_hwmod_ocp_if omap44xx_l4_cfg__ocp2scp_usb_phy =3D {
+	.master		=3D &omap44xx_l4_cfg_hwmod,
+	.slave		=3D &omap44xx_ocp2scp_usb_phy_hwmod,
+	.clk		=3D "l4_div_ck",
+	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
+};
+
 /* l3_main_2 -> sl2if */
 static struct omap_hwmod_ocp_if omap44xx_l3_main_2__sl2if =3D {
 	.master		=3D &omap44xx_l3_main_2_hwmod,
@@ -5316,6 +5407,24 @@ static struct omap_hwmod_ocp_if omap44xx_l4_per_=
_uart4 =3D {
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
 };
=20
+static struct omap_hwmod_addr_space omap44xx_usb_host_fs_addrs[] =3D {
+	{
+		.pa_start	=3D 0x4a0a9000,
+		.pa_end		=3D 0x4a0a93ff,
+		.flags		=3D ADDR_TYPE_RT
+	},
+	{ }
+};
+
+/* l4_cfg -> usb_host_fs */
+static struct omap_hwmod_ocp_if omap44xx_l4_cfg__usb_host_fs =3D {
+	.master		=3D &omap44xx_l4_cfg_hwmod,
+	.slave		=3D &omap44xx_usb_host_fs_hwmod,
+	.clk		=3D "l4_div_ck",
+	.addr		=3D omap44xx_usb_host_fs_addrs,
+	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
+};
+
 static struct omap_hwmod_addr_space omap44xx_usb_host_hs_addrs[] =3D {
 	{
 		.name		=3D "uhh",
@@ -5463,6 +5572,7 @@ static struct omap_hwmod_ocp_if *omap44xx_hwmod_o=
cp_ifs[] __initdata =3D {
 	&omap44xx_iva__l3_main_2,
 	&omap44xx_l3_main_1__l3_main_2,
 	&omap44xx_l4_cfg__l3_main_2,
+	&omap44xx_usb_host_fs__l3_main_2,
 	&omap44xx_usb_host_hs__l3_main_2,
 	&omap44xx_usb_otg_hs__l3_main_2,
 	&omap44xx_l3_main_1__l3_main_3,
@@ -5544,6 +5654,7 @@ static struct omap_hwmod_ocp_if *omap44xx_hwmod_o=
cp_ifs[] __initdata =3D {
 	&omap44xx_l4_per__mmc3,
 	&omap44xx_l4_per__mmc4,
 	&omap44xx_l4_per__mmc5,
+	&omap44xx_l4_cfg__ocp2scp_usb_phy,
 	&omap44xx_l3_main_2__sl2if,
 	&omap44xx_l4_abe__slimbus1,
 	&omap44xx_l4_abe__slimbus1_dma,
@@ -5571,6 +5682,7 @@ static struct omap_hwmod_ocp_if *omap44xx_hwmod_o=
cp_ifs[] __initdata =3D {
 	&omap44xx_l4_per__uart2,
 	&omap44xx_l4_per__uart3,
 	&omap44xx_l4_per__uart4,
+	&omap44xx_l4_cfg__usb_host_fs,
 	&omap44xx_l4_cfg__usb_host_hs,
 	&omap44xx_l4_cfg__usb_otg_hs,
 	&omap44xx_l4_cfg__usb_tll_hs,


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

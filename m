From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 02/15] ARM: OMAP4: hwmod data: introduce fdif(face detect
 module) hwmod
Date: Thu, 08 Mar 2012 03:51:27 -0700
Message-ID: <20120308105125.14753.82086.stgit@dusk>
References: <20120308104918.14753.69281.stgit@dusk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:47044 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752663Ab2CHKxf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Mar 2012 05:53:35 -0500
In-Reply-To: <20120308104918.14753.69281.stgit@dusk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Ming Lei <ming.lei@canonical.com>, =?utf-8?q?Beno=C3=AEt?= Cousson <b-cousson@ti.com>

=46rom: Ming Lei <ming.lei@canonical.com>

Add hwmod data for the OMAP4 FDIF IP block.

Signed-off-by: Ming Lei <ming.lei@canonical.com>
Acked-by: Beno=C3=AEt Cousson <b-cousson@ti.com>
[paul@pwsan.com: rearranged to match script output; fixed FDIF end addr=
ess to
 match script data; wrote trivial changelog]
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   70 ++++++++++++++++++++=
++++++++
 1 files changed, 69 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach=
-omap2/omap_hwmod_44xx_data.c
index 9180714..7f42431 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -262,7 +262,6 @@ static struct omap_hwmod omap44xx_mpu_private_hwmod=
 =3D {
  *  elm
  *  emif1
  *  emif2
- *  fdif
  *  gpmc
  *  gpu
  *  hdq1w
@@ -815,6 +814,47 @@ static struct omap_hwmod omap44xx_dss_venc_hwmod =3D=
 {
 };
=20
 /*
+ * 'fdif' class
+ * face detection hw accelerator module
+ */
+
+static struct omap_hwmod_class_sysconfig omap44xx_fdif_sysc =3D {
+	.rev_offs	=3D 0x0000,
+	.sysc_offs	=3D 0x0010,
+	.sysc_flags	=3D (SYSC_HAS_MIDLEMODE | SYSC_HAS_RESET_STATUS |
+			   SYSC_HAS_SIDLEMODE | SYSC_HAS_SOFTRESET),
+	.idlemodes	=3D (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART |
+			   MSTANDBY_FORCE | MSTANDBY_NO | MSTANDBY_SMART),
+	.sysc_fields	=3D &omap_hwmod_sysc_type2,
+};
+
+static struct omap_hwmod_class omap44xx_fdif_hwmod_class =3D {
+	.name	=3D "fdif",
+	.sysc	=3D &omap44xx_fdif_sysc,
+};
+
+/* fdif */
+static struct omap_hwmod_irq_info omap44xx_fdif_irqs[] =3D {
+	{ .irq =3D 69 + OMAP44XX_IRQ_GIC_START },
+	{ .irq =3D -1 }
+};
+
+static struct omap_hwmod omap44xx_fdif_hwmod =3D {
+	.name		=3D "fdif",
+	.class		=3D &omap44xx_fdif_hwmod_class,
+	.clkdm_name	=3D "iss_clkdm",
+	.mpu_irqs	=3D omap44xx_fdif_irqs,
+	.main_clk	=3D "fdif_fck",
+	.prcm =3D {
+		.omap4 =3D {
+			.clkctrl_offs =3D OMAP4_CM_CAM_FDIF_CLKCTRL_OFFSET,
+			.context_offs =3D OMAP4_RM_CAM_FDIF_CONTEXT_OFFSET,
+			.modulemode   =3D MODULEMODE_SWCTRL,
+		},
+	},
+};
+
+/*
  * 'gpio' class
  * general purpose io module
  */
@@ -2948,6 +2988,14 @@ static struct omap_hwmod_ocp_if omap44xx_dma_sys=
tem__l3_main_2 =3D {
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
 };
=20
+/* fdif -> l3_main_2 */
+static struct omap_hwmod_ocp_if omap44xx_fdif__l3_main_2 =3D {
+	.master		=3D &omap44xx_fdif_hwmod,
+	.slave		=3D &omap44xx_l3_main_2_hwmod,
+	.clk		=3D "l3_div_ck",
+	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
+};
+
 /* hsi -> l3_main_2 */
 static struct omap_hwmod_ocp_if omap44xx_hsi__l3_main_2 =3D {
 	.master		=3D &omap44xx_hsi_hwmod,
@@ -3498,6 +3546,24 @@ static struct omap_hwmod_ocp_if omap44xx_l4_per_=
_dss_venc =3D {
 	.user		=3D OCP_USER_MPU,
 };
=20
+static struct omap_hwmod_addr_space omap44xx_fdif_addrs[] =3D {
+	{
+		.pa_start	=3D 0x4a10a000,
+		.pa_end		=3D 0x4a10a1ff,
+		.flags		=3D ADDR_TYPE_RT
+	},
+	{ }
+};
+
+/* l4_cfg -> fdif */
+static struct omap_hwmod_ocp_if omap44xx_l4_cfg__fdif =3D {
+	.master		=3D &omap44xx_l4_cfg_hwmod,
+	.slave		=3D &omap44xx_fdif_hwmod,
+	.clk		=3D "l4_div_ck",
+	.addr		=3D omap44xx_fdif_addrs,
+	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
+};
+
 static struct omap_hwmod_addr_space omap44xx_gpio1_addrs[] =3D {
 	{
 		.pa_start	=3D 0x4a310000,
@@ -4655,6 +4721,7 @@ static struct omap_hwmod_ocp_if *omap44xx_hwmod_o=
cp_ifs[] __initdata =3D {
 	&omap44xx_mmc2__l3_main_1,
 	&omap44xx_mpu__l3_main_1,
 	&omap44xx_dma_system__l3_main_2,
+	&omap44xx_fdif__l3_main_2,
 	&omap44xx_hsi__l3_main_2,
 	&omap44xx_ipu__l3_main_2,
 	&omap44xx_iss__l3_main_2,
@@ -4696,6 +4763,7 @@ static struct omap_hwmod_ocp_if *omap44xx_hwmod_o=
cp_ifs[] __initdata =3D {
 	&omap44xx_l4_per__dss_rfbi,
 	&omap44xx_l3_main_2__dss_venc,
 	&omap44xx_l4_per__dss_venc,
+	&omap44xx_l4_cfg__fdif,
 	&omap44xx_l4_wkup__gpio1,
 	&omap44xx_l4_per__gpio2,
 	&omap44xx_l4_per__gpio3,


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 06/15] ARM: OMAP4: hwmod data: add GPU
Date: Thu, 08 Mar 2012 03:51:31 -0700
Message-ID: <20120308105130.14753.7993.stgit@dusk>
References: <20120308104918.14753.69281.stgit@dusk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:47057 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752948Ab2CHKxg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Mar 2012 05:53:36 -0500
In-Reply-To: <20120308104918.14753.69281.stgit@dusk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: =?utf-8?q?Beno=C3=AEt?= Cousson <b-cousson@ti.com>

Add the GPU hwmod and associated interconnect data.  The GPU is a
graphics accelerator.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Beno=C3=AEt Cousson <b-cousson@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   70 ++++++++++++++++++++=
++++++++
 1 files changed, 69 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach=
-omap2/omap_hwmod_44xx_data.c
index 812c990..adacc09 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -260,7 +260,6 @@ static struct omap_hwmod omap44xx_mpu_private_hwmod=
 =3D {
  *  efuse_ctrl_cust
  *  efuse_ctrl_std
  *  elm
- *  gpu
  *  mcasp
  *  mpu_c0
  *  mpu_c1
@@ -1158,6 +1157,47 @@ static struct omap_hwmod omap44xx_gpmc_hwmod =3D=
 {
 };
=20
 /*
+ * 'gpu' class
+ * 2d/3d graphics accelerator
+ */
+
+static struct omap_hwmod_class_sysconfig omap44xx_gpu_sysc =3D {
+	.rev_offs	=3D 0x1fc00,
+	.sysc_offs	=3D 0x1fc10,
+	.sysc_flags	=3D (SYSC_HAS_MIDLEMODE | SYSC_HAS_SIDLEMODE),
+	.idlemodes	=3D (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART |
+			   SIDLE_SMART_WKUP | MSTANDBY_FORCE | MSTANDBY_NO |
+			   MSTANDBY_SMART | MSTANDBY_SMART_WKUP),
+	.sysc_fields	=3D &omap_hwmod_sysc_type2,
+};
+
+static struct omap_hwmod_class omap44xx_gpu_hwmod_class =3D {
+	.name	=3D "gpu",
+	.sysc	=3D &omap44xx_gpu_sysc,
+};
+
+/* gpu */
+static struct omap_hwmod_irq_info omap44xx_gpu_irqs[] =3D {
+	{ .irq =3D 21 + OMAP44XX_IRQ_GIC_START },
+	{ .irq =3D -1 }
+};
+
+static struct omap_hwmod omap44xx_gpu_hwmod =3D {
+	.name		=3D "gpu",
+	.class		=3D &omap44xx_gpu_hwmod_class,
+	.clkdm_name	=3D "l3_gfx_clkdm",
+	.mpu_irqs	=3D omap44xx_gpu_irqs,
+	.main_clk	=3D "gpu_fck",
+	.prcm =3D {
+		.omap4 =3D {
+			.clkctrl_offs =3D OMAP4_CM_GFX_GFX_CLKCTRL_OFFSET,
+			.context_offs =3D OMAP4_RM_GFX_GFX_CONTEXT_OFFSET,
+			.modulemode   =3D MODULEMODE_SWCTRL,
+		},
+	},
+};
+
+/*
  * 'hdq1w' class
  * hdq / 1-wire serial interface controller
  */
@@ -3138,6 +3178,14 @@ static struct omap_hwmod_ocp_if omap44xx_fdif__l=
3_main_2 =3D {
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
 };
=20
+/* gpu -> l3_main_2 */
+static struct omap_hwmod_ocp_if omap44xx_gpu__l3_main_2 =3D {
+	.master		=3D &omap44xx_gpu_hwmod,
+	.slave		=3D &omap44xx_l3_main_2_hwmod,
+	.clk		=3D "l3_div_ck",
+	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
+};
+
 /* hsi -> l3_main_2 */
 static struct omap_hwmod_ocp_if omap44xx_hsi__l3_main_2 =3D {
 	.master		=3D &omap44xx_hsi_hwmod,
@@ -3868,6 +3916,24 @@ static struct omap_hwmod_ocp_if omap44xx_l3_main=
_2__gpmc =3D {
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
 };
=20
+static struct omap_hwmod_addr_space omap44xx_gpu_addrs[] =3D {
+	{
+		.pa_start	=3D 0x56000000,
+		.pa_end		=3D 0x5600ffff,
+		.flags		=3D ADDR_TYPE_RT
+	},
+	{ }
+};
+
+/* l3_main_2 -> gpu */
+static struct omap_hwmod_ocp_if omap44xx_l3_main_2__gpu =3D {
+	.master		=3D &omap44xx_l3_main_2_hwmod,
+	.slave		=3D &omap44xx_gpu_hwmod,
+	.clk		=3D "l3_div_ck",
+	.addr		=3D omap44xx_gpu_addrs,
+	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
+};
+
 static struct omap_hwmod_addr_space omap44xx_hdq1w_addrs[] =3D {
 	{
 		.pa_start	=3D 0x480b2000,
@@ -4936,6 +5002,7 @@ static struct omap_hwmod_ocp_if *omap44xx_hwmod_o=
cp_ifs[] __initdata =3D {
 	&omap44xx_mpu__l3_main_1,
 	&omap44xx_dma_system__l3_main_2,
 	&omap44xx_fdif__l3_main_2,
+	&omap44xx_gpu__l3_main_2,
 	&omap44xx_hsi__l3_main_2,
 	&omap44xx_ipu__l3_main_2,
 	&omap44xx_iss__l3_main_2,
@@ -4987,6 +5054,7 @@ static struct omap_hwmod_ocp_if *omap44xx_hwmod_o=
cp_ifs[] __initdata =3D {
 	&omap44xx_l4_per__gpio5,
 	&omap44xx_l4_per__gpio6,
 	&omap44xx_l3_main_2__gpmc,
+	&omap44xx_l3_main_2__gpu,
 	&omap44xx_l4_per__hdq1w,
 	&omap44xx_l4_cfg__hsi,
 	&omap44xx_l4_per__i2c1,


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

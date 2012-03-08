From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 04/15] ARM: OMAP4: hwmod data: add GPMC
Date: Thu, 08 Mar 2012 03:51:29 -0700
Message-ID: <20120308105129.14753.577.stgit@dusk>
References: <20120308104918.14753.69281.stgit@dusk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:47051 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752730Ab2CHKxf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Mar 2012 05:53:35 -0500
In-Reply-To: <20120308104918.14753.69281.stgit@dusk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: =?utf-8?q?Beno=C3=AEt?= Cousson <b-cousson@ti.com>

=46rom: Beno=C3=AEt Cousson <b-cousson@ti.com>

Add the GPMC hwmod and associated interconnect data.   The GPMC is a
programmable parallel-bus memory controller.

Signed-off-by: Beno=C3=AEt Cousson <b-cousson@ti.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   67 ++++++++++++++++++++=
++++++++
 1 files changed, 66 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach=
-omap2/omap_hwmod_44xx_data.c
index ae87401..6a7e26e 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -262,7 +262,6 @@ static struct omap_hwmod omap44xx_mpu_private_hwmod=
 =3D {
  *  elm
  *  emif1
  *  emif2
- *  gpmc
  *  gpu
  *  mcasp
  *  mpu_c0
@@ -1056,6 +1055,53 @@ static struct omap_hwmod omap44xx_gpio6_hwmod =3D=
 {
 };
=20
 /*
+ * 'gpmc' class
+ * general purpose memory controller
+ */
+
+static struct omap_hwmod_class_sysconfig omap44xx_gpmc_sysc =3D {
+	.rev_offs	=3D 0x0000,
+	.sysc_offs	=3D 0x0010,
+	.syss_offs	=3D 0x0014,
+	.sysc_flags	=3D (SYSC_HAS_AUTOIDLE | SYSC_HAS_SIDLEMODE |
+			   SYSC_HAS_SOFTRESET | SYSS_HAS_RESET_STATUS),
+	.idlemodes	=3D (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
+	.sysc_fields	=3D &omap_hwmod_sysc_type1,
+};
+
+static struct omap_hwmod_class omap44xx_gpmc_hwmod_class =3D {
+	.name	=3D "gpmc",
+	.sysc	=3D &omap44xx_gpmc_sysc,
+};
+
+/* gpmc */
+static struct omap_hwmod_irq_info omap44xx_gpmc_irqs[] =3D {
+	{ .irq =3D 20 + OMAP44XX_IRQ_GIC_START },
+	{ .irq =3D -1 }
+};
+
+static struct omap_hwmod_dma_info omap44xx_gpmc_sdma_reqs[] =3D {
+	{ .dma_req =3D 3 + OMAP44XX_DMA_REQ_START },
+	{ .dma_req =3D -1 }
+};
+
+static struct omap_hwmod omap44xx_gpmc_hwmod =3D {
+	.name		=3D "gpmc",
+	.class		=3D &omap44xx_gpmc_hwmod_class,
+	.clkdm_name	=3D "l3_2_clkdm",
+	.flags		=3D HWMOD_INIT_NO_IDLE | HWMOD_INIT_NO_RESET,
+	.mpu_irqs	=3D omap44xx_gpmc_irqs,
+	.sdma_reqs	=3D omap44xx_gpmc_sdma_reqs,
+	.prcm =3D {
+		.omap4 =3D {
+			.clkctrl_offs =3D OMAP4_CM_L3_2_GPMC_CLKCTRL_OFFSET,
+			.context_offs =3D OMAP4_RM_L3_2_GPMC_CONTEXT_OFFSET,
+			.modulemode   =3D MODULEMODE_HWCTRL,
+		},
+	},
+};
+
+/*
  * 'hdq1w' class
  * hdq / 1-wire serial interface controller
  */
@@ -3712,6 +3758,24 @@ static struct omap_hwmod_ocp_if omap44xx_l4_per_=
_gpio6 =3D {
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
 };
=20
+static struct omap_hwmod_addr_space omap44xx_gpmc_addrs[] =3D {
+	{
+		.pa_start	=3D 0x50000000,
+		.pa_end		=3D 0x500003ff,
+		.flags		=3D ADDR_TYPE_RT
+	},
+	{ }
+};
+
+/* l3_main_2 -> gpmc */
+static struct omap_hwmod_ocp_if omap44xx_l3_main_2__gpmc =3D {
+	.master		=3D &omap44xx_l3_main_2_hwmod,
+	.slave		=3D &omap44xx_gpmc_hwmod,
+	.clk		=3D "l3_div_ck",
+	.addr		=3D omap44xx_gpmc_addrs,
+	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
+};
+
 static struct omap_hwmod_addr_space omap44xx_hdq1w_addrs[] =3D {
 	{
 		.pa_start	=3D 0x480b2000,
@@ -4828,6 +4892,7 @@ static struct omap_hwmod_ocp_if *omap44xx_hwmod_o=
cp_ifs[] __initdata =3D {
 	&omap44xx_l4_per__gpio4,
 	&omap44xx_l4_per__gpio5,
 	&omap44xx_l4_per__gpio6,
+	&omap44xx_l3_main_2__gpmc,
 	&omap44xx_l4_per__hdq1w,
 	&omap44xx_l4_cfg__hsi,
 	&omap44xx_l4_per__i2c1,


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

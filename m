From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 08/15] ARM: OMAP4: hwmod data: add McASP
Date: Thu, 08 Mar 2012 03:51:33 -0700
Message-ID: <20120308105132.14753.91529.stgit@dusk>
References: <20120308104918.14753.69281.stgit@dusk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:47063 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753293Ab2CHKxg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Mar 2012 05:53:36 -0500
In-Reply-To: <20120308104918.14753.69281.stgit@dusk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: =?utf-8?q?Beno=C3=AEt?= Cousson <b-cousson@ti.com>

=46rom: Beno=C3=AEt Cousson <b-cousson@ti.com>

Add the McASP hwmod and associated interconnect data.  The McASP is a
general-purpose audio serial port.

Signed-off-by: Beno=C3=AEt Cousson <b-cousson@ti.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   91 ++++++++++++++++++++=
++++++++
 1 files changed, 90 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach=
-omap2/omap_hwmod_44xx_data.c
index 283c5b2..3be64f5 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -260,7 +260,6 @@ static struct omap_hwmod omap44xx_mpu_private_hwmod=
 =3D {
  *  efuse_ctrl_cust
  *  efuse_ctrl_std
  *  elm
- *  mcasp
  *  mpu_c0
  *  mpu_c1
  *  ocmc_ram
@@ -1669,6 +1668,58 @@ static struct omap_hwmod omap44xx_mailbox_hwmod =
=3D {
 };
=20
 /*
+ * 'mcasp' class
+ * multi-channel audio serial port controller
+ */
+
+/* The IP is not compliant to type1 / type2 scheme */
+static struct omap_hwmod_sysc_fields omap_hwmod_sysc_type_mcasp =3D {
+	.sidle_shift	=3D 0,
+};
+
+static struct omap_hwmod_class_sysconfig omap44xx_mcasp_sysc =3D {
+	.sysc_offs	=3D 0x0004,
+	.sysc_flags	=3D SYSC_HAS_SIDLEMODE,
+	.idlemodes	=3D (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART |
+			   SIDLE_SMART_WKUP),
+	.sysc_fields	=3D &omap_hwmod_sysc_type_mcasp,
+};
+
+static struct omap_hwmod_class omap44xx_mcasp_hwmod_class =3D {
+	.name	=3D "mcasp",
+	.sysc	=3D &omap44xx_mcasp_sysc,
+};
+
+/* mcasp */
+static struct omap_hwmod_irq_info omap44xx_mcasp_irqs[] =3D {
+	{ .name =3D "arevt", .irq =3D 108 + OMAP44XX_IRQ_GIC_START },
+	{ .name =3D "axevt", .irq =3D 109 + OMAP44XX_IRQ_GIC_START },
+	{ .irq =3D -1 }
+};
+
+static struct omap_hwmod_dma_info omap44xx_mcasp_sdma_reqs[] =3D {
+	{ .name =3D "axevt", .dma_req =3D 7 + OMAP44XX_DMA_REQ_START },
+	{ .name =3D "arevt", .dma_req =3D 10 + OMAP44XX_DMA_REQ_START },
+	{ .dma_req =3D -1 }
+};
+
+static struct omap_hwmod omap44xx_mcasp_hwmod =3D {
+	.name		=3D "mcasp",
+	.class		=3D &omap44xx_mcasp_hwmod_class,
+	.clkdm_name	=3D "abe_clkdm",
+	.mpu_irqs	=3D omap44xx_mcasp_irqs,
+	.sdma_reqs	=3D omap44xx_mcasp_sdma_reqs,
+	.main_clk	=3D "mcasp_fck",
+	.prcm =3D {
+		.omap4 =3D {
+			.clkctrl_offs =3D OMAP4_CM1_ABE_MCASP_CLKCTRL_OFFSET,
+			.context_offs =3D OMAP4_RM_ABE_MCASP_CONTEXT_OFFSET,
+			.modulemode   =3D MODULEMODE_SWCTRL,
+		},
+	},
+};
+
+/*
  * 'mcbsp' class
  * multi channel buffered serial port controller
  */
@@ -4224,6 +4275,42 @@ static struct omap_hwmod_ocp_if omap44xx_l4_cfg_=
_mailbox =3D {
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
 };
=20
+static struct omap_hwmod_addr_space omap44xx_mcasp_addrs[] =3D {
+	{
+		.pa_start	=3D 0x40128000,
+		.pa_end		=3D 0x401283ff,
+		.flags		=3D ADDR_TYPE_RT
+	},
+	{ }
+};
+
+/* l4_abe -> mcasp */
+static struct omap_hwmod_ocp_if omap44xx_l4_abe__mcasp =3D {
+	.master		=3D &omap44xx_l4_abe_hwmod,
+	.slave		=3D &omap44xx_mcasp_hwmod,
+	.clk		=3D "ocp_abe_iclk",
+	.addr		=3D omap44xx_mcasp_addrs,
+	.user		=3D OCP_USER_MPU,
+};
+
+static struct omap_hwmod_addr_space omap44xx_mcasp_dma_addrs[] =3D {
+	{
+		.pa_start	=3D 0x49028000,
+		.pa_end		=3D 0x490283ff,
+		.flags		=3D ADDR_TYPE_RT
+	},
+	{ }
+};
+
+/* l4_abe -> mcasp (dma) */
+static struct omap_hwmod_ocp_if omap44xx_l4_abe__mcasp_dma =3D {
+	.master		=3D &omap44xx_l4_abe_hwmod,
+	.slave		=3D &omap44xx_mcasp_hwmod,
+	.clk		=3D "ocp_abe_iclk",
+	.addr		=3D omap44xx_mcasp_dma_addrs,
+	.user		=3D OCP_USER_SDMA,
+};
+
 static struct omap_hwmod_addr_space omap44xx_mcbsp1_addrs[] =3D {
 	{
 		.name		=3D "mpu",
@@ -5222,6 +5309,8 @@ static struct omap_hwmod_ocp_if *omap44xx_hwmod_o=
cp_ifs[] __initdata =3D {
 	&omap44xx_l3_main_2__iva,
 	&omap44xx_l4_wkup__kbd,
 	&omap44xx_l4_cfg__mailbox,
+	&omap44xx_l4_abe__mcasp,
+	&omap44xx_l4_abe__mcasp_dma,
 	&omap44xx_l4_abe__mcbsp1,
 	&omap44xx_l4_abe__mcbsp1_dma,
 	&omap44xx_l4_abe__mcbsp2,


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

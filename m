From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 05/15] ARM: OMAP4: hwmod data: add EMIF1 and 2
Date: Thu, 08 Mar 2012 03:51:30 -0700
Message-ID: <20120308105129.14753.7319.stgit@dusk>
References: <20120308104918.14753.69281.stgit@dusk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:47054 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752851Ab2CHKxg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Mar 2012 05:53:36 -0500
In-Reply-To: <20120308104918.14753.69281.stgit@dusk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: =?utf-8?q?Beno=C3=AEt?= Cousson <b-cousson@ti.com>

Add the EMIF1 and 2 hwmods and associated interconnect data.  The EMIFs
are SDRAM interface IP blocks.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Beno=C3=AEt Cousson <b-cousson@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   98 ++++++++++++++++++++=
+++++++-
 1 files changed, 96 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach=
-omap2/omap_hwmod_44xx_data.c
index 6a7e26e..812c990 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -260,8 +260,6 @@ static struct omap_hwmod omap44xx_mpu_private_hwmod=
 =3D {
  *  efuse_ctrl_cust
  *  efuse_ctrl_std
  *  elm
- *  emif1
- *  emif2
  *  gpu
  *  mcasp
  *  mpu_c0
@@ -812,6 +810,64 @@ static struct omap_hwmod omap44xx_dss_venc_hwmod =3D=
 {
 };
=20
 /*
+ * 'emif' class
+ * external memory interface no1
+ */
+
+static struct omap_hwmod_class_sysconfig omap44xx_emif_sysc =3D {
+	.rev_offs	=3D 0x0000,
+};
+
+static struct omap_hwmod_class omap44xx_emif_hwmod_class =3D {
+	.name	=3D "emif",
+	.sysc	=3D &omap44xx_emif_sysc,
+};
+
+/* emif1 */
+static struct omap_hwmod_irq_info omap44xx_emif1_irqs[] =3D {
+	{ .irq =3D 110 + OMAP44XX_IRQ_GIC_START },
+	{ .irq =3D -1 }
+};
+
+static struct omap_hwmod omap44xx_emif1_hwmod =3D {
+	.name		=3D "emif1",
+	.class		=3D &omap44xx_emif_hwmod_class,
+	.clkdm_name	=3D "l3_emif_clkdm",
+	.flags		=3D HWMOD_INIT_NO_IDLE | HWMOD_INIT_NO_RESET,
+	.mpu_irqs	=3D omap44xx_emif1_irqs,
+	.main_clk	=3D "ddrphy_ck",
+	.prcm =3D {
+		.omap4 =3D {
+			.clkctrl_offs =3D OMAP4_CM_MEMIF_EMIF_1_CLKCTRL_OFFSET,
+			.context_offs =3D OMAP4_RM_MEMIF_EMIF_1_CONTEXT_OFFSET,
+			.modulemode   =3D MODULEMODE_HWCTRL,
+		},
+	},
+};
+
+/* emif2 */
+static struct omap_hwmod_irq_info omap44xx_emif2_irqs[] =3D {
+	{ .irq =3D 111 + OMAP44XX_IRQ_GIC_START },
+	{ .irq =3D -1 }
+};
+
+static struct omap_hwmod omap44xx_emif2_hwmod =3D {
+	.name		=3D "emif2",
+	.class		=3D &omap44xx_emif_hwmod_class,
+	.clkdm_name	=3D "l3_emif_clkdm",
+	.flags		=3D HWMOD_INIT_NO_IDLE | HWMOD_INIT_NO_RESET,
+	.mpu_irqs	=3D omap44xx_emif2_irqs,
+	.main_clk	=3D "ddrphy_ck",
+	.prcm =3D {
+		.omap4 =3D {
+			.clkctrl_offs =3D OMAP4_CM_MEMIF_EMIF_2_CLKCTRL_OFFSET,
+			.context_offs =3D OMAP4_RM_MEMIF_EMIF_2_CONTEXT_OFFSET,
+			.modulemode   =3D MODULEMODE_HWCTRL,
+		},
+	},
+};
+
+/*
  * 'fdif' class
  * face detection hw accelerator module
  */
@@ -3632,6 +3688,42 @@ static struct omap_hwmod_ocp_if omap44xx_l4_per_=
_dss_venc =3D {
 	.user		=3D OCP_USER_MPU,
 };
=20
+static struct omap_hwmod_addr_space omap44xx_emif1_addrs[] =3D {
+	{
+		.pa_start	=3D 0x4c000000,
+		.pa_end		=3D 0x4c0000ff,
+		.flags		=3D ADDR_TYPE_RT
+	},
+	{ }
+};
+
+/* emif_fw -> emif1 */
+static struct omap_hwmod_ocp_if omap44xx_emif_fw__emif1 =3D {
+	.master		=3D &omap44xx_emif_fw_hwmod,
+	.slave		=3D &omap44xx_emif1_hwmod,
+	.clk		=3D "l3_div_ck",
+	.addr		=3D omap44xx_emif1_addrs,
+	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+static struct omap_hwmod_addr_space omap44xx_emif2_addrs[] =3D {
+	{
+		.pa_start	=3D 0x4d000000,
+		.pa_end		=3D 0x4d0000ff,
+		.flags		=3D ADDR_TYPE_RT
+	},
+	{ }
+};
+
+/* emif_fw -> emif2 */
+static struct omap_hwmod_ocp_if omap44xx_emif_fw__emif2 =3D {
+	.master		=3D &omap44xx_emif_fw_hwmod,
+	.slave		=3D &omap44xx_emif2_hwmod,
+	.clk		=3D "l3_div_ck",
+	.addr		=3D omap44xx_emif2_addrs,
+	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
+};
+
 static struct omap_hwmod_addr_space omap44xx_fdif_addrs[] =3D {
 	{
 		.pa_start	=3D 0x4a10a000,
@@ -4885,6 +4977,8 @@ static struct omap_hwmod_ocp_if *omap44xx_hwmod_o=
cp_ifs[] __initdata =3D {
 	&omap44xx_l4_per__dss_rfbi,
 	&omap44xx_l3_main_2__dss_venc,
 	&omap44xx_l4_per__dss_venc,
+	&omap44xx_emif_fw__emif1,
+	&omap44xx_emif_fw__emif2,
 	&omap44xx_l4_cfg__fdif,
 	&omap44xx_l4_wkup__gpio1,
 	&omap44xx_l4_per__gpio2,


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

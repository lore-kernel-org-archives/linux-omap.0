From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 13/15] ARM: OMAP4: hwmod data: add System Control Module
Date: Thu, 08 Mar 2012 03:51:36 -0700
Message-ID: <20120308105135.14753.35011.stgit@dusk>
References: <20120308104918.14753.69281.stgit@dusk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:47079 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753770Ab2CHKxh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Mar 2012 05:53:37 -0500
In-Reply-To: <20120308104918.14753.69281.stgit@dusk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: =?utf-8?q?Beno=C3=AEt?= Cousson <b-cousson@ti.com>

Add the System Control Module hwmod and associated interconnect data.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Beno=C3=AEt Cousson <b-cousson@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |  134 ++++++++++++++++++++=
+++++++-
 1 files changed, 130 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach=
-omap2/omap_hwmod_44xx_data.c
index 5c89307..ccc1249 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -293,10 +293,6 @@ static struct omap_hwmod omap44xx_ocp_wp_noc_hwmod=
 =3D {
  *
  *  cm_core
  *  cm_core_aon
- *  ctrl_module_core
- *  ctrl_module_pad_core
- *  ctrl_module_pad_wkup
- *  ctrl_module_wkup
  *  debugss
  *  efuse_ctrl_cust
  *  efuse_ctrl_std
@@ -433,6 +429,60 @@ static struct omap_hwmod omap44xx_counter_32k_hwmo=
d =3D {
 };
=20
 /*
+ * 'ctrl_module' class
+ * attila core control module + core pad control module + wkup pad con=
trol
+ * module + attila wkup control module
+ */
+
+static struct omap_hwmod_class_sysconfig omap44xx_ctrl_module_sysc =3D=
 {
+	.rev_offs	=3D 0x0000,
+	.sysc_offs	=3D 0x0010,
+	.sysc_flags	=3D SYSC_HAS_SIDLEMODE,
+	.idlemodes	=3D (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART |
+			   SIDLE_SMART_WKUP),
+	.sysc_fields	=3D &omap_hwmod_sysc_type2,
+};
+
+static struct omap_hwmod_class omap44xx_ctrl_module_hwmod_class =3D {
+	.name	=3D "ctrl_module",
+	.sysc	=3D &omap44xx_ctrl_module_sysc,
+};
+
+/* ctrl_module_core */
+static struct omap_hwmod_irq_info omap44xx_ctrl_module_core_irqs[] =3D=
 {
+	{ .irq =3D 8 + OMAP44XX_IRQ_GIC_START },
+	{ .irq =3D -1 }
+};
+
+static struct omap_hwmod omap44xx_ctrl_module_core_hwmod =3D {
+	.name		=3D "ctrl_module_core",
+	.class		=3D &omap44xx_ctrl_module_hwmod_class,
+	.clkdm_name	=3D "l4_cfg_clkdm",
+	.mpu_irqs	=3D omap44xx_ctrl_module_core_irqs,
+};
+
+/* ctrl_module_pad_core */
+static struct omap_hwmod omap44xx_ctrl_module_pad_core_hwmod =3D {
+	.name		=3D "ctrl_module_pad_core",
+	.class		=3D &omap44xx_ctrl_module_hwmod_class,
+	.clkdm_name	=3D "l4_cfg_clkdm",
+};
+
+/* ctrl_module_wkup */
+static struct omap_hwmod omap44xx_ctrl_module_wkup_hwmod =3D {
+	.name		=3D "ctrl_module_wkup",
+	.class		=3D &omap44xx_ctrl_module_hwmod_class,
+	.clkdm_name	=3D "l4_wkup_clkdm",
+};
+
+/* ctrl_module_pad_wkup */
+static struct omap_hwmod omap44xx_ctrl_module_pad_wkup_hwmod =3D {
+	.name		=3D "ctrl_module_pad_wkup",
+	.class		=3D &omap44xx_ctrl_module_hwmod_class,
+	.clkdm_name	=3D "l4_wkup_clkdm",
+};
+
+/*
  * 'dma' class
  * dma controller for data exchange between memory to memory (i.e. int=
ernal or
  * external memory) and gp peripherals to memory or memory to gp perip=
herals
@@ -3881,6 +3931,78 @@ static struct omap_hwmod_ocp_if omap44xx_l4_wkup=
__counter_32k =3D {
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
 };
=20
+static struct omap_hwmod_addr_space omap44xx_ctrl_module_core_addrs[] =
=3D {
+	{
+		.pa_start	=3D 0x4a002000,
+		.pa_end		=3D 0x4a0027ff,
+		.flags		=3D ADDR_TYPE_RT
+	},
+	{ }
+};
+
+/* l4_cfg -> ctrl_module_core */
+static struct omap_hwmod_ocp_if omap44xx_l4_cfg__ctrl_module_core =3D =
{
+	.master		=3D &omap44xx_l4_cfg_hwmod,
+	.slave		=3D &omap44xx_ctrl_module_core_hwmod,
+	.clk		=3D "l4_div_ck",
+	.addr		=3D omap44xx_ctrl_module_core_addrs,
+	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+static struct omap_hwmod_addr_space omap44xx_ctrl_module_pad_core_addr=
s[] =3D {
+	{
+		.pa_start	=3D 0x4a100000,
+		.pa_end		=3D 0x4a1007ff,
+		.flags		=3D ADDR_TYPE_RT
+	},
+	{ }
+};
+
+/* l4_cfg -> ctrl_module_pad_core */
+static struct omap_hwmod_ocp_if omap44xx_l4_cfg__ctrl_module_pad_core =
=3D {
+	.master		=3D &omap44xx_l4_cfg_hwmod,
+	.slave		=3D &omap44xx_ctrl_module_pad_core_hwmod,
+	.clk		=3D "l4_div_ck",
+	.addr		=3D omap44xx_ctrl_module_pad_core_addrs,
+	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+static struct omap_hwmod_addr_space omap44xx_ctrl_module_wkup_addrs[] =
=3D {
+	{
+		.pa_start	=3D 0x4a30c000,
+		.pa_end		=3D 0x4a30c7ff,
+		.flags		=3D ADDR_TYPE_RT
+	},
+	{ }
+};
+
+/* l4_wkup -> ctrl_module_wkup */
+static struct omap_hwmod_ocp_if omap44xx_l4_wkup__ctrl_module_wkup =3D=
 {
+	.master		=3D &omap44xx_l4_wkup_hwmod,
+	.slave		=3D &omap44xx_ctrl_module_wkup_hwmod,
+	.clk		=3D "l4_wkup_clk_mux_ck",
+	.addr		=3D omap44xx_ctrl_module_wkup_addrs,
+	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+static struct omap_hwmod_addr_space omap44xx_ctrl_module_pad_wkup_addr=
s[] =3D {
+	{
+		.pa_start	=3D 0x4a31e000,
+		.pa_end		=3D 0x4a31e7ff,
+		.flags		=3D ADDR_TYPE_RT
+	},
+	{ }
+};
+
+/* l4_wkup -> ctrl_module_pad_wkup */
+static struct omap_hwmod_ocp_if omap44xx_l4_wkup__ctrl_module_pad_wkup=
 =3D {
+	.master		=3D &omap44xx_l4_wkup_hwmod,
+	.slave		=3D &omap44xx_ctrl_module_pad_wkup_hwmod,
+	.clk		=3D "l4_wkup_clk_mux_ck",
+	.addr		=3D omap44xx_ctrl_module_pad_wkup_addrs,
+	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
+};
+
 static struct omap_hwmod_addr_space omap44xx_dma_system_addrs[] =3D {
 	{
 		.pa_start	=3D 0x4a056000,
@@ -5668,6 +5790,10 @@ static struct omap_hwmod_ocp_if *omap44xx_hwmod_=
ocp_ifs[] __initdata =3D {
 	&omap44xx_l4_abe__aess_dma,
 	&omap44xx_l3_main_2__c2c,
 	&omap44xx_l4_wkup__counter_32k,
+	&omap44xx_l4_cfg__ctrl_module_core,
+	&omap44xx_l4_cfg__ctrl_module_pad_core,
+	&omap44xx_l4_wkup__ctrl_module_wkup,
+	&omap44xx_l4_wkup__ctrl_module_pad_wkup,
 	&omap44xx_l4_cfg__dma_system,
 	&omap44xx_l4_abe__dmic,
 	&omap44xx_l4_abe__dmic_dma,


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

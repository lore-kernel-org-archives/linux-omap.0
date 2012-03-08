From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 03/15] ARM: OMAP4: hwmod data: add HDQ/1-wire
Date: Thu, 08 Mar 2012 03:51:29 -0700
Message-ID: <20120308105127.14753.19376.stgit@dusk>
References: <20120308104918.14753.69281.stgit@dusk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:47048 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752679Ab2CHKxf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Mar 2012 05:53:35 -0500
In-Reply-To: <20120308104918.14753.69281.stgit@dusk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: =?utf-8?q?Beno=C3=AEt?= Cousson <b-cousson@ti.com>

Add the HDQ/1-wire hwmod and associated interconnect data.  The
HDQ/1-wire IP block is a low-speed serial interconnect.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Beno=C3=AEt Cousson <b-cousson@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   61 ++++++++++++++++++++=
++++++++
 1 files changed, 60 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach=
-omap2/omap_hwmod_44xx_data.c
index 7f42431..ae87401 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -264,7 +264,6 @@ static struct omap_hwmod omap44xx_mpu_private_hwmod=
 =3D {
  *  emif2
  *  gpmc
  *  gpu
- *  hdq1w
  *  mcasp
  *  mpu_c0
  *  mpu_c1
@@ -1057,6 +1056,47 @@ static struct omap_hwmod omap44xx_gpio6_hwmod =3D=
 {
 };
=20
 /*
+ * 'hdq1w' class
+ * hdq / 1-wire serial interface controller
+ */
+
+static struct omap_hwmod_class_sysconfig omap44xx_hdq1w_sysc =3D {
+	.rev_offs	=3D 0x0000,
+	.sysc_offs	=3D 0x0014,
+	.syss_offs	=3D 0x0018,
+	.sysc_flags	=3D (SYSC_HAS_AUTOIDLE | SYSC_HAS_SOFTRESET |
+			   SYSS_HAS_RESET_STATUS),
+	.sysc_fields	=3D &omap_hwmod_sysc_type1,
+};
+
+static struct omap_hwmod_class omap44xx_hdq1w_hwmod_class =3D {
+	.name	=3D "hdq1w",
+	.sysc	=3D &omap44xx_hdq1w_sysc,
+};
+
+/* hdq1w */
+static struct omap_hwmod_irq_info omap44xx_hdq1w_irqs[] =3D {
+	{ .irq =3D 58 + OMAP44XX_IRQ_GIC_START },
+	{ .irq =3D -1 }
+};
+
+static struct omap_hwmod omap44xx_hdq1w_hwmod =3D {
+	.name		=3D "hdq1w",
+	.class		=3D &omap44xx_hdq1w_hwmod_class,
+	.clkdm_name	=3D "l4_per_clkdm",
+	.flags		=3D HWMOD_INIT_NO_RESET, /* XXX temporary */
+	.mpu_irqs	=3D omap44xx_hdq1w_irqs,
+	.main_clk	=3D "hdq1w_fck",
+	.prcm =3D {
+		.omap4 =3D {
+			.clkctrl_offs =3D OMAP4_CM_L4PER_HDQ1W_CLKCTRL_OFFSET,
+			.context_offs =3D OMAP4_RM_L4PER_HDQ1W_CONTEXT_OFFSET,
+			.modulemode   =3D MODULEMODE_SWCTRL,
+		},
+	},
+};
+
+/*
  * 'hsi' class
  * mipi high-speed synchronous serial interface (multichannel and full=
-duplex
  * serial if)
@@ -3672,6 +3712,24 @@ static struct omap_hwmod_ocp_if omap44xx_l4_per_=
_gpio6 =3D {
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
 };
=20
+static struct omap_hwmod_addr_space omap44xx_hdq1w_addrs[] =3D {
+	{
+		.pa_start	=3D 0x480b2000,
+		.pa_end		=3D 0x480b201f,
+		.flags		=3D ADDR_TYPE_RT
+	},
+	{ }
+};
+
+/* l4_per -> hdq1w */
+static struct omap_hwmod_ocp_if omap44xx_l4_per__hdq1w =3D {
+	.master		=3D &omap44xx_l4_per_hwmod,
+	.slave		=3D &omap44xx_hdq1w_hwmod,
+	.clk		=3D "l4_div_ck",
+	.addr		=3D omap44xx_hdq1w_addrs,
+	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
+};
+
 static struct omap_hwmod_addr_space omap44xx_hsi_addrs[] =3D {
 	{
 		.pa_start	=3D 0x4a058000,
@@ -4770,6 +4828,7 @@ static struct omap_hwmod_ocp_if *omap44xx_hwmod_o=
cp_ifs[] __initdata =3D {
 	&omap44xx_l4_per__gpio4,
 	&omap44xx_l4_per__gpio5,
 	&omap44xx_l4_per__gpio6,
+	&omap44xx_l4_per__hdq1w,
 	&omap44xx_l4_cfg__hsi,
 	&omap44xx_l4_per__i2c1,
 	&omap44xx_l4_per__i2c2,


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

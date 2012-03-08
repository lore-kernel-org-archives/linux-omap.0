From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 07/15] ARM: OMAP4: hwmod data: add the Slimbus IP blocks
Date: Thu, 08 Mar 2012 03:51:32 -0700
Message-ID: <20120308105131.14753.60810.stgit@dusk>
References: <20120308104918.14753.69281.stgit@dusk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:47060 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753097Ab2CHKxg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Mar 2012 05:53:36 -0500
In-Reply-To: <20120308104918.14753.69281.stgit@dusk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: =?utf-8?q?Beno=C3=AEt?= Cousson <b-cousson@ti.com>

=46rom: Beno=C3=AEt Cousson <b-cousson@ti.com>

Add the Slimbus hwmods and associated interconnect data.  The Slimbus
IP blocks implement a two-wire serial interface.

Signed-off-by: Beno=C3=AEt Cousson <b-cousson@ti.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |  163 ++++++++++++++++++++=
++++++++
 1 files changed, 161 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach=
-omap2/omap_hwmod_44xx_data.c
index adacc09..283c5b2 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -270,8 +270,6 @@ static struct omap_hwmod omap44xx_mpu_private_hwmod=
 =3D {
  *  prm
  *  scrm
  *  sl2if
- *  slimbus1
- *  slimbus2
  *  usb_host_fs
  *  usb_host_hs
  *  usb_phy_cm
@@ -2219,6 +2217,110 @@ static struct omap_hwmod omap44xx_mpu_hwmod =3D=
 {
 };
=20
 /*
+ * 'slimbus' class
+ * bidirectional, multi-drop, multi-channel two-line serial interface =
between
+ * the device and external components
+ */
+
+static struct omap_hwmod_class_sysconfig omap44xx_slimbus_sysc =3D {
+	.rev_offs	=3D 0x0000,
+	.sysc_offs	=3D 0x0010,
+	.sysc_flags	=3D (SYSC_HAS_RESET_STATUS | SYSC_HAS_SIDLEMODE |
+			   SYSC_HAS_SOFTRESET),
+	.idlemodes	=3D (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART |
+			   SIDLE_SMART_WKUP),
+	.sysc_fields	=3D &omap_hwmod_sysc_type2,
+};
+
+static struct omap_hwmod_class omap44xx_slimbus_hwmod_class =3D {
+	.name	=3D "slimbus",
+	.sysc	=3D &omap44xx_slimbus_sysc,
+};
+
+/* slimbus1 */
+static struct omap_hwmod_irq_info omap44xx_slimbus1_irqs[] =3D {
+	{ .irq =3D 97 + OMAP44XX_IRQ_GIC_START },
+	{ .irq =3D -1 }
+};
+
+static struct omap_hwmod_dma_info omap44xx_slimbus1_sdma_reqs[] =3D {
+	{ .name =3D "tx0", .dma_req =3D 84 + OMAP44XX_DMA_REQ_START },
+	{ .name =3D "tx1", .dma_req =3D 85 + OMAP44XX_DMA_REQ_START },
+	{ .name =3D "tx2", .dma_req =3D 86 + OMAP44XX_DMA_REQ_START },
+	{ .name =3D "tx3", .dma_req =3D 87 + OMAP44XX_DMA_REQ_START },
+	{ .name =3D "rx0", .dma_req =3D 88 + OMAP44XX_DMA_REQ_START },
+	{ .name =3D "rx1", .dma_req =3D 89 + OMAP44XX_DMA_REQ_START },
+	{ .name =3D "rx2", .dma_req =3D 90 + OMAP44XX_DMA_REQ_START },
+	{ .name =3D "rx3", .dma_req =3D 91 + OMAP44XX_DMA_REQ_START },
+	{ .dma_req =3D -1 }
+};
+
+static struct omap_hwmod_opt_clk slimbus1_opt_clks[] =3D {
+	{ .role =3D "fclk_1", .clk =3D "slimbus1_fclk_1" },
+	{ .role =3D "fclk_0", .clk =3D "slimbus1_fclk_0" },
+	{ .role =3D "fclk_2", .clk =3D "slimbus1_fclk_2" },
+	{ .role =3D "slimbus_clk", .clk =3D "slimbus1_slimbus_clk" },
+};
+
+static struct omap_hwmod omap44xx_slimbus1_hwmod =3D {
+	.name		=3D "slimbus1",
+	.class		=3D &omap44xx_slimbus_hwmod_class,
+	.clkdm_name	=3D "abe_clkdm",
+	.mpu_irqs	=3D omap44xx_slimbus1_irqs,
+	.sdma_reqs	=3D omap44xx_slimbus1_sdma_reqs,
+	.prcm =3D {
+		.omap4 =3D {
+			.clkctrl_offs =3D OMAP4_CM1_ABE_SLIMBUS_CLKCTRL_OFFSET,
+			.context_offs =3D OMAP4_RM_ABE_SLIMBUS_CONTEXT_OFFSET,
+			.modulemode   =3D MODULEMODE_SWCTRL,
+		},
+	},
+	.opt_clks	=3D slimbus1_opt_clks,
+	.opt_clks_cnt	=3D ARRAY_SIZE(slimbus1_opt_clks),
+};
+
+/* slimbus2 */
+static struct omap_hwmod_irq_info omap44xx_slimbus2_irqs[] =3D {
+	{ .irq =3D 98 + OMAP44XX_IRQ_GIC_START },
+	{ .irq =3D -1 }
+};
+
+static struct omap_hwmod_dma_info omap44xx_slimbus2_sdma_reqs[] =3D {
+	{ .name =3D "tx0", .dma_req =3D 92 + OMAP44XX_DMA_REQ_START },
+	{ .name =3D "tx1", .dma_req =3D 93 + OMAP44XX_DMA_REQ_START },
+	{ .name =3D "tx2", .dma_req =3D 94 + OMAP44XX_DMA_REQ_START },
+	{ .name =3D "tx3", .dma_req =3D 95 + OMAP44XX_DMA_REQ_START },
+	{ .name =3D "rx0", .dma_req =3D 96 + OMAP44XX_DMA_REQ_START },
+	{ .name =3D "rx1", .dma_req =3D 97 + OMAP44XX_DMA_REQ_START },
+	{ .name =3D "rx2", .dma_req =3D 98 + OMAP44XX_DMA_REQ_START },
+	{ .name =3D "rx3", .dma_req =3D 99 + OMAP44XX_DMA_REQ_START },
+	{ .dma_req =3D -1 }
+};
+
+static struct omap_hwmod_opt_clk slimbus2_opt_clks[] =3D {
+	{ .role =3D "fclk_1", .clk =3D "slimbus2_fclk_1" },
+	{ .role =3D "fclk_0", .clk =3D "slimbus2_fclk_0" },
+	{ .role =3D "slimbus_clk", .clk =3D "slimbus2_slimbus_clk" },
+};
+
+static struct omap_hwmod omap44xx_slimbus2_hwmod =3D {
+	.name		=3D "slimbus2",
+	.class		=3D &omap44xx_slimbus_hwmod_class,
+	.clkdm_name	=3D "l4_per_clkdm",
+	.mpu_irqs	=3D omap44xx_slimbus2_irqs,
+	.sdma_reqs	=3D omap44xx_slimbus2_sdma_reqs,
+	.prcm =3D {
+		.omap4 =3D {
+			.clkctrl_offs =3D OMAP4_CM_L4PER_SLIMBUS2_CLKCTRL_OFFSET,
+			.context_offs =3D OMAP4_RM_L4PER_SLIMBUS2_CONTEXT_OFFSET,
+			.modulemode   =3D MODULEMODE_SWCTRL,
+		},
+	},
+	.opt_clks	=3D slimbus2_opt_clks,
+	.opt_clks_cnt	=3D ARRAY_SIZE(slimbus2_opt_clks),
+};
+
+/*
  * 'smartreflex' class
  * smartreflex module (monitor silicon performance and outputs a measu=
re of
  * performance error)
@@ -4452,6 +4554,60 @@ static struct omap_hwmod_ocp_if omap44xx_l4_per_=
_mmc5 =3D {
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
 };
=20
+static struct omap_hwmod_addr_space omap44xx_slimbus1_addrs[] =3D {
+	{
+		.pa_start	=3D 0x4012c000,
+		.pa_end		=3D 0x4012c3ff,
+		.flags		=3D ADDR_TYPE_RT
+	},
+	{ }
+};
+
+/* l4_abe -> slimbus1 */
+static struct omap_hwmod_ocp_if omap44xx_l4_abe__slimbus1 =3D {
+	.master		=3D &omap44xx_l4_abe_hwmod,
+	.slave		=3D &omap44xx_slimbus1_hwmod,
+	.clk		=3D "ocp_abe_iclk",
+	.addr		=3D omap44xx_slimbus1_addrs,
+	.user		=3D OCP_USER_MPU,
+};
+
+static struct omap_hwmod_addr_space omap44xx_slimbus1_dma_addrs[] =3D =
{
+	{
+		.pa_start	=3D 0x4902c000,
+		.pa_end		=3D 0x4902c3ff,
+		.flags		=3D ADDR_TYPE_RT
+	},
+	{ }
+};
+
+/* l4_abe -> slimbus1 (dma) */
+static struct omap_hwmod_ocp_if omap44xx_l4_abe__slimbus1_dma =3D {
+	.master		=3D &omap44xx_l4_abe_hwmod,
+	.slave		=3D &omap44xx_slimbus1_hwmod,
+	.clk		=3D "ocp_abe_iclk",
+	.addr		=3D omap44xx_slimbus1_dma_addrs,
+	.user		=3D OCP_USER_SDMA,
+};
+
+static struct omap_hwmod_addr_space omap44xx_slimbus2_addrs[] =3D {
+	{
+		.pa_start	=3D 0x48076000,
+		.pa_end		=3D 0x480763ff,
+		.flags		=3D ADDR_TYPE_RT
+	},
+	{ }
+};
+
+/* l4_per -> slimbus2 */
+static struct omap_hwmod_ocp_if omap44xx_l4_per__slimbus2 =3D {
+	.master		=3D &omap44xx_l4_per_hwmod,
+	.slave		=3D &omap44xx_slimbus2_hwmod,
+	.clk		=3D "l4_div_ck",
+	.addr		=3D omap44xx_slimbus2_addrs,
+	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
+};
+
 static struct omap_hwmod_addr_space omap44xx_smartreflex_core_addrs[] =
=3D {
 	{
 		.pa_start	=3D 0x4a0dd000,
@@ -5084,6 +5240,9 @@ static struct omap_hwmod_ocp_if *omap44xx_hwmod_o=
cp_ifs[] __initdata =3D {
 	&omap44xx_l4_per__mmc3,
 	&omap44xx_l4_per__mmc4,
 	&omap44xx_l4_per__mmc5,
+	&omap44xx_l4_abe__slimbus1,
+	&omap44xx_l4_abe__slimbus1_dma,
+	&omap44xx_l4_per__slimbus2,
 	&omap44xx_l4_cfg__smartreflex_core,
 	&omap44xx_l4_cfg__smartreflex_iva,
 	&omap44xx_l4_cfg__smartreflex_mpu,


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

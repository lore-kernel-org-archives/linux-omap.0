From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH 4/5] OMAP4: hwmod data: Add IVA and DSP
Date: Fri, 10 Dec 2010 00:33:34 +0100
Message-ID: <1291937615-18571-5-git-send-email-b-cousson@ti.com>
References: <1291937615-18571-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:47626 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756315Ab0LIXeh (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 9 Dec 2010 18:34:37 -0500
In-Reply-To: <1291937615-18571-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com, khilman@deeprootsystems.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Benoit Cousson <b-cousson@ti.com>

Add IVA and DSP hwmods in order to allow the pm code to
initialize properly the processors devices during
omap2_init_processor_devices.

It will avoid the following warnings.
_init_omap_device: could not find omap_hwmod for iva
_init_omap_device: could not find omap_hwmod for dsp

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |  243 +++++++++++++++++++++++++++-
 1 files changed, 241 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 7dccba3..102c76f 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -37,7 +37,9 @@
 
 /* Backward references (IPs with Bus Master capability) */
 static struct omap_hwmod omap44xx_dmm_hwmod;
+static struct omap_hwmod omap44xx_dsp_hwmod;
 static struct omap_hwmod omap44xx_emif_fw_hwmod;
+static struct omap_hwmod omap44xx_iva_hwmod;
 static struct omap_hwmod omap44xx_l3_instr_hwmod;
 static struct omap_hwmod omap44xx_l3_main_1_hwmod;
 static struct omap_hwmod omap44xx_l3_main_2_hwmod;
@@ -167,6 +169,14 @@ static struct omap_hwmod_class omap44xx_l3_hwmod_class = {
 };
 
 /* l3_instr interface data */
+/* iva -> l3_instr */
+static struct omap_hwmod_ocp_if omap44xx_iva__l3_instr = {
+	.master		= &omap44xx_iva_hwmod,
+	.slave		= &omap44xx_l3_instr_hwmod,
+	.clk		= "l3_div_ck",
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
 /* l3_main_3 -> l3_instr */
 static struct omap_hwmod_ocp_if omap44xx_l3_main_3__l3_instr = {
 	.master		= &omap44xx_l3_main_3_hwmod,
@@ -177,6 +187,7 @@ static struct omap_hwmod_ocp_if omap44xx_l3_main_3__l3_instr = {
 
 /* l3_instr slave ports */
 static struct omap_hwmod_ocp_if *omap44xx_l3_instr_slaves[] = {
+	&omap44xx_iva__l3_instr,
 	&omap44xx_l3_main_3__l3_instr,
 };
 
@@ -189,6 +200,14 @@ static struct omap_hwmod omap44xx_l3_instr_hwmod = {
 };
 
 /* l3_main_1 interface data */
+/* dsp -> l3_main_1 */
+static struct omap_hwmod_ocp_if omap44xx_dsp__l3_main_1 = {
+	.master		= &omap44xx_dsp_hwmod,
+	.slave		= &omap44xx_l3_main_1_hwmod,
+	.clk		= "l3_div_ck",
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
 /* l3_main_2 -> l3_main_1 */
 static struct omap_hwmod_ocp_if omap44xx_l3_main_2__l3_main_1 = {
 	.master		= &omap44xx_l3_main_2_hwmod,
@@ -215,6 +234,7 @@ static struct omap_hwmod_ocp_if omap44xx_mpu__l3_main_1 = {
 
 /* l3_main_1 slave ports */
 static struct omap_hwmod_ocp_if *omap44xx_l3_main_1_slaves[] = {
+	&omap44xx_dsp__l3_main_1,
 	&omap44xx_l3_main_2__l3_main_1,
 	&omap44xx_l4_cfg__l3_main_1,
 	&omap44xx_mpu__l3_main_1,
@@ -229,6 +249,14 @@ static struct omap_hwmod omap44xx_l3_main_1_hwmod = {
 };
 
 /* l3_main_2 interface data */
+/* iva -> l3_main_2 */
+static struct omap_hwmod_ocp_if omap44xx_iva__l3_main_2 = {
+	.master		= &omap44xx_iva_hwmod,
+	.slave		= &omap44xx_l3_main_2_hwmod,
+	.clk		= "l3_div_ck",
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
 /* l3_main_1 -> l3_main_2 */
 static struct omap_hwmod_ocp_if omap44xx_l3_main_1__l3_main_2 = {
 	.master		= &omap44xx_l3_main_1_hwmod,
@@ -247,6 +275,7 @@ static struct omap_hwmod_ocp_if omap44xx_l4_cfg__l3_main_2 = {
 
 /* l3_main_2 slave ports */
 static struct omap_hwmod_ocp_if *omap44xx_l3_main_2_slaves[] = {
+	&omap44xx_iva__l3_main_2,
 	&omap44xx_l3_main_1__l3_main_2,
 	&omap44xx_l4_cfg__l3_main_2,
 };
@@ -308,6 +337,14 @@ static struct omap_hwmod_class omap44xx_l4_hwmod_class = {
 };
 
 /* l4_abe interface data */
+/* dsp -> l4_abe */
+static struct omap_hwmod_ocp_if omap44xx_dsp__l4_abe = {
+	.master		= &omap44xx_dsp_hwmod,
+	.slave		= &omap44xx_l4_abe_hwmod,
+	.clk		= "ocp_abe_iclk",
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
 /* l3_main_1 -> l4_abe */
 static struct omap_hwmod_ocp_if omap44xx_l3_main_1__l4_abe = {
 	.master		= &omap44xx_l3_main_1_hwmod,
@@ -326,6 +363,7 @@ static struct omap_hwmod_ocp_if omap44xx_mpu__l4_abe = {
 
 /* l4_abe slave ports */
 static struct omap_hwmod_ocp_if *omap44xx_l4_abe_slaves[] = {
+	&omap44xx_dsp__l4_abe,
 	&omap44xx_l3_main_1__l4_abe,
 	&omap44xx_mpu__l4_abe,
 };
@@ -456,7 +494,6 @@ static struct omap_hwmod omap44xx_mpu_private_hwmod = {
  *  debugss
  *  dma_system
  *  dmic
- *  dsp
  *  dss
  *  dss_dispc
  *  dss_dsi1
@@ -476,7 +513,6 @@ static struct omap_hwmod omap44xx_mpu_private_hwmod = {
  *  hsi
  *  ipu
  *  iss
- *  iva
  *  kbd
  *  mailbox
  *  mcasp
@@ -530,6 +566,91 @@ static struct omap_hwmod omap44xx_mpu_private_hwmod = {
  */
 
 /*
+ * 'dsp' class
+ * dsp sub-system
+ */
+
+static struct omap_hwmod_class omap44xx_dsp_hwmod_class = {
+	.name = "dsp",
+};
+
+/* dsp */
+static struct omap_hwmod_irq_info omap44xx_dsp_irqs[] = {
+	{ .irq = 28 + OMAP44XX_IRQ_GIC_START },
+};
+
+static struct omap_hwmod_rst_info omap44xx_dsp_resets[] = {
+	{ .name = "mmu_cache", .rst_shift = 1 },
+};
+
+static struct omap_hwmod_rst_info omap44xx_dsp_c0_resets[] = {
+	{ .name = "dsp", .rst_shift = 0 },
+};
+
+/* dsp -> iva */
+static struct omap_hwmod_ocp_if omap44xx_dsp__iva = {
+	.master		= &omap44xx_dsp_hwmod,
+	.slave		= &omap44xx_iva_hwmod,
+	.clk		= "dpll_iva_m5x2_ck",
+};
+
+/* dsp master ports */
+static struct omap_hwmod_ocp_if *omap44xx_dsp_masters[] = {
+	&omap44xx_dsp__l3_main_1,
+	&omap44xx_dsp__l4_abe,
+	&omap44xx_dsp__iva,
+};
+
+/* l4_cfg -> dsp */
+static struct omap_hwmod_ocp_if omap44xx_l4_cfg__dsp = {
+	.master		= &omap44xx_l4_cfg_hwmod,
+	.slave		= &omap44xx_dsp_hwmod,
+	.clk		= "l4_div_ck",
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* dsp slave ports */
+static struct omap_hwmod_ocp_if *omap44xx_dsp_slaves[] = {
+	&omap44xx_l4_cfg__dsp,
+};
+
+/* Pseudo hwmod for reset control purpose only */
+static struct omap_hwmod omap44xx_dsp_c0_hwmod = {
+	.name		= "dsp_c0",
+	.class		= &omap44xx_dsp_hwmod_class,
+	.flags		= HWMOD_INIT_NO_RESET,
+	.rst_lines	= omap44xx_dsp_c0_resets,
+	.rst_lines_cnt	= ARRAY_SIZE(omap44xx_dsp_c0_resets),
+	.prcm = {
+		.omap4 = {
+			.rstctrl_reg = OMAP4430_RM_TESLA_RSTCTRL,
+		},
+	},
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+};
+
+static struct omap_hwmod omap44xx_dsp_hwmod = {
+	.name		= "dsp",
+	.class		= &omap44xx_dsp_hwmod_class,
+	.mpu_irqs	= omap44xx_dsp_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_dsp_irqs),
+	.rst_lines	= omap44xx_dsp_resets,
+	.rst_lines_cnt	= ARRAY_SIZE(omap44xx_dsp_resets),
+	.main_clk	= "dsp_fck",
+	.prcm = {
+		.omap4 = {
+			.clkctrl_reg = OMAP4430_CM_TESLA_TESLA_CLKCTRL,
+			.rstctrl_reg = OMAP4430_RM_TESLA_RSTCTRL,
+		},
+	},
+	.slaves		= omap44xx_dsp_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap44xx_dsp_slaves),
+	.masters	= omap44xx_dsp_masters,
+	.masters_cnt	= ARRAY_SIZE(omap44xx_dsp_masters),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+};
+
+/*
  * 'gpio' class
  * general purpose io module
  */
@@ -1096,6 +1217,115 @@ static struct omap_hwmod omap44xx_i2c4_hwmod = {
 };
 
 /*
+ * 'iva' class
+ * multi-standard video encoder/decoder hardware accelerator
+ */
+
+static struct omap_hwmod_class omap44xx_iva_hwmod_class = {
+	.name = "iva",
+};
+
+/* iva */
+static struct omap_hwmod_irq_info omap44xx_iva_irqs[] = {
+	{ .name = "sync_1", .irq = 103 + OMAP44XX_IRQ_GIC_START },
+	{ .name = "sync_0", .irq = 104 + OMAP44XX_IRQ_GIC_START },
+	{ .name = "mailbox_0", .irq = 107 + OMAP44XX_IRQ_GIC_START },
+};
+
+static struct omap_hwmod_rst_info omap44xx_iva_resets[] = {
+	{ .name = "logic", .rst_shift = 2 },
+};
+
+static struct omap_hwmod_rst_info omap44xx_iva_seq0_resets[] = {
+	{ .name = "seq0", .rst_shift = 0 },
+};
+
+static struct omap_hwmod_rst_info omap44xx_iva_seq1_resets[] = {
+	{ .name = "seq1", .rst_shift = 1 },
+};
+
+/* iva master ports */
+static struct omap_hwmod_ocp_if *omap44xx_iva_masters[] = {
+	&omap44xx_iva__l3_main_2,
+	&omap44xx_iva__l3_instr,
+};
+
+static struct omap_hwmod_addr_space omap44xx_iva_addrs[] = {
+	{
+		.pa_start	= 0x5a000000,
+		.pa_end		= 0x5a07ffff,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+
+/* l3_main_2 -> iva */
+static struct omap_hwmod_ocp_if omap44xx_l3_main_2__iva = {
+	.master		= &omap44xx_l3_main_2_hwmod,
+	.slave		= &omap44xx_iva_hwmod,
+	.clk		= "l3_div_ck",
+	.addr		= omap44xx_iva_addrs,
+	.addr_cnt	= ARRAY_SIZE(omap44xx_iva_addrs),
+	.user		= OCP_USER_MPU,
+};
+
+/* iva slave ports */
+static struct omap_hwmod_ocp_if *omap44xx_iva_slaves[] = {
+	&omap44xx_dsp__iva,
+	&omap44xx_l3_main_2__iva,
+};
+
+/* Pseudo hwmod for reset control purpose only */
+static struct omap_hwmod omap44xx_iva_seq0_hwmod = {
+	.name		= "iva_seq0",
+	.class		= &omap44xx_iva_hwmod_class,
+	.flags		= HWMOD_INIT_NO_RESET,
+	.rst_lines	= omap44xx_iva_seq0_resets,
+	.rst_lines_cnt	= ARRAY_SIZE(omap44xx_iva_seq0_resets),
+	.prcm = {
+		.omap4 = {
+			.rstctrl_reg = OMAP4430_RM_IVAHD_RSTCTRL,
+		},
+	},
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+};
+
+/* Pseudo hwmod for reset control purpose only */
+static struct omap_hwmod omap44xx_iva_seq1_hwmod = {
+	.name		= "iva_seq1",
+	.class		= &omap44xx_iva_hwmod_class,
+	.flags		= HWMOD_INIT_NO_RESET,
+	.rst_lines	= omap44xx_iva_seq1_resets,
+	.rst_lines_cnt	= ARRAY_SIZE(omap44xx_iva_seq1_resets),
+	.prcm = {
+		.omap4 = {
+			.rstctrl_reg = OMAP4430_RM_IVAHD_RSTCTRL,
+		},
+	},
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+};
+
+static struct omap_hwmod omap44xx_iva_hwmod = {
+	.name		= "iva",
+	.class		= &omap44xx_iva_hwmod_class,
+	.mpu_irqs	= omap44xx_iva_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_iva_irqs),
+	.rst_lines	= omap44xx_iva_resets,
+	.rst_lines_cnt	= ARRAY_SIZE(omap44xx_iva_resets),
+	.main_clk	= "iva_fck",
+	.prcm = {
+		.omap4 = {
+			.clkctrl_reg = OMAP4430_CM_IVAHD_IVAHD_CLKCTRL,
+			.rstctrl_reg = OMAP4430_RM_IVAHD_RSTCTRL,
+		},
+	},
+	.slaves		= omap44xx_iva_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap44xx_iva_slaves),
+	.masters	= omap44xx_iva_masters,
+	.masters_cnt	= ARRAY_SIZE(omap44xx_iva_masters),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+};
+
+/*
  * 'mpu' class
  * mpu sub-system
  */
@@ -1525,12 +1755,21 @@ static __initdata struct omap_hwmod *omap44xx_hwmods[] = {
 	&omap44xx_gpio5_hwmod,
 	&omap44xx_gpio6_hwmod,
 
+	/* dsp class */
+	&omap44xx_dsp_hwmod,
+	&omap44xx_dsp_c0_hwmod,
+
 	/* i2c class */
 	&omap44xx_i2c1_hwmod,
 	&omap44xx_i2c2_hwmod,
 	&omap44xx_i2c3_hwmod,
 	&omap44xx_i2c4_hwmod,
 
+	/* iva class */
+	&omap44xx_iva_hwmod,
+	&omap44xx_iva_seq0_hwmod,
+	&omap44xx_iva_seq1_hwmod,
+
 	/* mpu class */
 	&omap44xx_mpu_hwmod,
 
-- 
1.7.0.4


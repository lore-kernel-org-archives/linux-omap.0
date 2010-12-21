From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v1 06/10] OMAP4: hwmod data: Add McBSP
Date: Tue, 21 Dec 2010 13:10:26 +0530
Message-ID: <1292917231-13800-6-git-send-email-kishon@ti.com>
References: <1292917231-13800-1-git-send-email-kishon@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:43657 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757768Ab0LUHmB (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 21 Dec 2010 02:42:01 -0500
In-Reply-To: <1292917231-13800-1-git-send-email-kishon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: paul@pwsan.com, khilman@deeprootsystems.com, p-basak2@ti.com, b-cousson@ti.com, kishon@ti.com

From: Benoit Cousson <b-cousson@ti.com>

Add McBSP hwmod data for OMAP4.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |  320 ++++++++++++++++++++++++++++
 1 files changed, 320 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 0d5c6eb..e8e9c4b 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -1043,6 +1043,320 @@ static struct omap_hwmod omap44xx_uart4_hwmod = {
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
 
+/*
+ * 'mcbsp' class
+ * multi channel buffered serial port controller
+ */
+
+static struct omap_hwmod_class_sysconfig omap44xx_mcbsp_sysc = {
+	.sysc_offs	= 0x008c,
+	.sysc_flags	= (SYSC_HAS_CLOCKACTIVITY | SYSC_HAS_ENAWAKEUP |
+			   SYSC_HAS_SIDLEMODE | SYSC_HAS_SOFTRESET),
+	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
+	.sysc_fields	= &omap_hwmod_sysc_type1,
+};
+
+static struct omap_hwmod_class omap44xx_mcbsp_hwmod_class = {
+	.name = "mcbsp",
+	.sysc = &omap44xx_mcbsp_sysc,
+};
+
+/* mcbsp1 */
+static struct omap_hwmod omap44xx_mcbsp1_hwmod;
+static struct omap_hwmod_irq_info omap44xx_mcbsp1_irqs[] = {
+	{ .name = "tx", .irq = 17 + OMAP44XX_IRQ_GIC_START },
+	{ .name = "rx", .irq = 0 },
+};
+
+static struct omap_hwmod_dma_info omap44xx_mcbsp1_sdma_reqs[] = {
+	{ .name = "tx", .dma_req = 32 + OMAP44XX_DMA_REQ_START },
+	{ .name = "rx", .dma_req = 33 + OMAP44XX_DMA_REQ_START },
+};
+
+static struct omap_hwmod_addr_space omap44xx_mcbsp1_addrs[] = {
+	{
+		.name		= "mpu",
+		.pa_start	= 0x40122000,
+		.pa_end		= 0x401220ff,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+
+/* l4_abe -> mcbsp1 */
+static struct omap_hwmod_ocp_if omap44xx_l4_abe__mcbsp1 = {
+	.master		= &omap44xx_l4_abe_hwmod,
+	.slave		= &omap44xx_mcbsp1_hwmod,
+	.clk		= "ocp_abe_iclk",
+	.addr		= omap44xx_mcbsp1_addrs,
+	.addr_cnt	= ARRAY_SIZE(omap44xx_mcbsp1_addrs),
+	.user		= OCP_USER_MPU,
+};
+
+static struct omap_hwmod_addr_space omap44xx_mcbsp1_dma_addrs[] = {
+	{
+		.name		= "dma",
+		.pa_start	= 0x49022000,
+		.pa_end		= 0x490220ff,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+
+/* l4_abe -> mcbsp1 (dma) */
+static struct omap_hwmod_ocp_if omap44xx_l4_abe__mcbsp1_dma = {
+	.master		= &omap44xx_l4_abe_hwmod,
+	.slave		= &omap44xx_mcbsp1_hwmod,
+	.clk		= "ocp_abe_iclk",
+	.addr		= omap44xx_mcbsp1_dma_addrs,
+	.addr_cnt	= ARRAY_SIZE(omap44xx_mcbsp1_dma_addrs),
+	.user		= OCP_USER_SDMA,
+};
+
+/* mcbsp1 slave ports */
+static struct omap_hwmod_ocp_if *omap44xx_mcbsp1_slaves[] = {
+	&omap44xx_l4_abe__mcbsp1,
+	&omap44xx_l4_abe__mcbsp1_dma,
+};
+
+static struct omap_hwmod omap44xx_mcbsp1_hwmod = {
+	.name		= "mcbsp1",
+	.class		= &omap44xx_mcbsp_hwmod_class,
+	.mpu_irqs	= omap44xx_mcbsp1_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_mcbsp1_irqs),
+	.sdma_reqs	= omap44xx_mcbsp1_sdma_reqs,
+	.sdma_reqs_cnt	= ARRAY_SIZE(omap44xx_mcbsp1_sdma_reqs),
+	.main_clk	= "mcbsp1_fck",
+	.prcm = {
+		.omap4 = {
+			.clkctrl_reg = OMAP4430_CM1_ABE_MCBSP1_CLKCTRL,
+		},
+	},
+	.slaves		= omap44xx_mcbsp1_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap44xx_mcbsp1_slaves),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+};
+
+/* mcbsp2 */
+static struct omap_hwmod omap44xx_mcbsp2_hwmod;
+static struct omap_hwmod_irq_info omap44xx_mcbsp2_irqs[] = {
+	{ .name = "tx", .irq = 22 + OMAP44XX_IRQ_GIC_START },
+	{ .name = "rx", .irq = 0 },
+};
+
+static struct omap_hwmod_dma_info omap44xx_mcbsp2_sdma_reqs[] = {
+	{ .name = "tx", .dma_req = 16 + OMAP44XX_DMA_REQ_START },
+	{ .name = "rx", .dma_req = 17 + OMAP44XX_DMA_REQ_START },
+};
+
+static struct omap_hwmod_addr_space omap44xx_mcbsp2_addrs[] = {
+	{
+		.name		= "mpu",
+		.pa_start	= 0x40124000,
+		.pa_end		= 0x401240ff,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+
+/* l4_abe -> mcbsp2 */
+static struct omap_hwmod_ocp_if omap44xx_l4_abe__mcbsp2 = {
+	.master		= &omap44xx_l4_abe_hwmod,
+	.slave		= &omap44xx_mcbsp2_hwmod,
+	.clk		= "ocp_abe_iclk",
+	.addr		= omap44xx_mcbsp2_addrs,
+	.addr_cnt	= ARRAY_SIZE(omap44xx_mcbsp2_addrs),
+	.user		= OCP_USER_MPU,
+};
+
+static struct omap_hwmod_addr_space omap44xx_mcbsp2_dma_addrs[] = {
+	{
+		.name		= "dma",
+		.pa_start	= 0x49024000,
+		.pa_end		= 0x490240ff,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+
+/* l4_abe -> mcbsp2 (dma) */
+static struct omap_hwmod_ocp_if omap44xx_l4_abe__mcbsp2_dma = {
+	.master		= &omap44xx_l4_abe_hwmod,
+	.slave		= &omap44xx_mcbsp2_hwmod,
+	.clk		= "ocp_abe_iclk",
+	.addr		= omap44xx_mcbsp2_dma_addrs,
+	.addr_cnt	= ARRAY_SIZE(omap44xx_mcbsp2_dma_addrs),
+	.user		= OCP_USER_SDMA,
+};
+
+/* mcbsp2 slave ports */
+static struct omap_hwmod_ocp_if *omap44xx_mcbsp2_slaves[] = {
+	&omap44xx_l4_abe__mcbsp2,
+	&omap44xx_l4_abe__mcbsp2_dma,
+};
+
+static struct omap_hwmod omap44xx_mcbsp2_hwmod = {
+	.name		= "mcbsp2",
+	.class		= &omap44xx_mcbsp_hwmod_class,
+	.mpu_irqs	= omap44xx_mcbsp2_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_mcbsp2_irqs),
+	.sdma_reqs	= omap44xx_mcbsp2_sdma_reqs,
+	.sdma_reqs_cnt	= ARRAY_SIZE(omap44xx_mcbsp2_sdma_reqs),
+	.main_clk	= "mcbsp2_fck",
+	.prcm = {
+		.omap4 = {
+			.clkctrl_reg = OMAP4430_CM1_ABE_MCBSP2_CLKCTRL,
+		},
+	},
+	.slaves		= omap44xx_mcbsp2_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap44xx_mcbsp2_slaves),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+};
+
+/* mcbsp3 */
+static struct omap_hwmod omap44xx_mcbsp3_hwmod;
+static struct omap_hwmod_irq_info omap44xx_mcbsp3_irqs[] = {
+	{ .name = "tx", .irq = 23 + OMAP44XX_IRQ_GIC_START },
+	{ .name = "rx", .irq = 0 },
+};
+
+static struct omap_hwmod_dma_info omap44xx_mcbsp3_sdma_reqs[] = {
+	{ .name = "tx", .dma_req = 18 + OMAP44XX_DMA_REQ_START },
+	{ .name = "rx", .dma_req = 19 + OMAP44XX_DMA_REQ_START },
+};
+
+static struct omap_hwmod_addr_space omap44xx_mcbsp3_addrs[] = {
+	{
+		.name		= "mpu",
+		.pa_start	= 0x40126000,
+		.pa_end		= 0x401260ff,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+
+/* l4_abe -> mcbsp3 */
+static struct omap_hwmod_ocp_if omap44xx_l4_abe__mcbsp3 = {
+	.master		= &omap44xx_l4_abe_hwmod,
+	.slave		= &omap44xx_mcbsp3_hwmod,
+	.clk		= "ocp_abe_iclk",
+	.addr		= omap44xx_mcbsp3_addrs,
+	.addr_cnt	= ARRAY_SIZE(omap44xx_mcbsp3_addrs),
+	.user		= OCP_USER_MPU,
+};
+
+static struct omap_hwmod_addr_space omap44xx_mcbsp3_dma_addrs[] = {
+	{
+		.name		= "dma",
+		.pa_start	= 0x49026000,
+		.pa_end		= 0x490260ff,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+
+/* l4_abe -> mcbsp3 (dma) */
+static struct omap_hwmod_ocp_if omap44xx_l4_abe__mcbsp3_dma = {
+	.master		= &omap44xx_l4_abe_hwmod,
+	.slave		= &omap44xx_mcbsp3_hwmod,
+	.clk		= "ocp_abe_iclk",
+	.addr		= omap44xx_mcbsp3_dma_addrs,
+	.addr_cnt	= ARRAY_SIZE(omap44xx_mcbsp3_dma_addrs),
+	.user		= OCP_USER_SDMA,
+};
+
+/* mcbsp3 slave ports */
+static struct omap_hwmod_ocp_if *omap44xx_mcbsp3_slaves[] = {
+	&omap44xx_l4_abe__mcbsp3,
+	&omap44xx_l4_abe__mcbsp3_dma,
+};
+
+static struct omap_hwmod omap44xx_mcbsp3_hwmod = {
+	.name		= "mcbsp3",
+	.class		= &omap44xx_mcbsp_hwmod_class,
+	.mpu_irqs	= omap44xx_mcbsp3_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_mcbsp3_irqs),
+	.sdma_reqs	= omap44xx_mcbsp3_sdma_reqs,
+	.sdma_reqs_cnt	= ARRAY_SIZE(omap44xx_mcbsp3_sdma_reqs),
+	.main_clk	= "mcbsp3_fck",
+	.prcm = {
+		.omap4 = {
+			.clkctrl_reg = OMAP4430_CM1_ABE_MCBSP3_CLKCTRL,
+		},
+	},
+	.slaves		= omap44xx_mcbsp3_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap44xx_mcbsp3_slaves),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+};
+
+/* mcbsp4 */
+static struct omap_hwmod omap44xx_mcbsp4_hwmod;
+static struct omap_hwmod_irq_info omap44xx_mcbsp4_irqs[] = {
+	{ .name = "tx", .irq = 16 + OMAP44XX_IRQ_GIC_START },
+	{ .name = "rx", .irq = 0 },
+};
+
+static struct omap_hwmod_dma_info omap44xx_mcbsp4_sdma_reqs[] = {
+	{ .name = "tx", .dma_req = 30 + OMAP44XX_DMA_REQ_START },
+	{ .name = "rx", .dma_req = 31 + OMAP44XX_DMA_REQ_START },
+};
+
+static struct omap_hwmod_addr_space omap44xx_mcbsp4_addrs[] = {
+	{
+		.name		= "mpu",
+		.pa_start	= 0x48096000,
+		.pa_end		= 0x480960ff,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+
+/* l4_per -> mcbsp4 */
+static struct omap_hwmod_ocp_if omap44xx_l4_per__mcbsp4 = {
+	.master		= &omap44xx_l4_per_hwmod,
+	.slave		= &omap44xx_mcbsp4_hwmod,
+	.clk		= "l4_div_ck",
+	.addr		= omap44xx_mcbsp4_addrs,
+	.addr_cnt	= ARRAY_SIZE(omap44xx_mcbsp4_addrs),
+	.user		= OCP_USER_MPU,
+};
+
+static struct omap_hwmod_addr_space omap44xx_mcbsp4_dma_addrs[] = {
+	{
+		.name           = "dma",
+		.pa_start       = 0x48096000,
+		.pa_end         = 0x480960ff,
+		.flags          = ADDR_TYPE_RT
+	},
+};
+
+static struct omap_hwmod_ocp_if omap44xx_l4_per__mcbsp4_dma = {
+	.master         = &omap44xx_l4_per_hwmod,
+	.slave          = &omap44xx_mcbsp4_hwmod,
+	.clk            = "l4_div_ck",
+	.addr           = omap44xx_mcbsp4_dma_addrs,
+	.addr_cnt       = ARRAY_SIZE(omap44xx_mcbsp4_dma_addrs),
+	.user           = OCP_USER_SDMA,
+};
+
+/* mcbsp4 slave ports */
+static struct omap_hwmod_ocp_if *omap44xx_mcbsp4_slaves[] = {
+	&omap44xx_l4_per__mcbsp4,
+	&omap44xx_l4_per__mcbsp4_dma,
+};
+
+static struct omap_hwmod omap44xx_mcbsp4_hwmod = {
+	.name		= "mcbsp4",
+	.class		= &omap44xx_mcbsp_hwmod_class,
+	.mpu_irqs	= omap44xx_mcbsp4_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_mcbsp4_irqs),
+	.sdma_reqs	= omap44xx_mcbsp4_sdma_reqs,
+	.sdma_reqs_cnt	= ARRAY_SIZE(omap44xx_mcbsp4_sdma_reqs),
+	.main_clk	= "mcbsp4_fck",
+	.prcm = {
+		.omap4 = {
+			.clkctrl_reg = OMAP4430_CM_L4PER_MCBSP4_CLKCTRL,
+		},
+	},
+	.slaves		= omap44xx_mcbsp4_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap44xx_mcbsp4_slaves),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+};
+
+
 static __initdata struct omap_hwmod *omap44xx_hwmods[] = {
 	/* dmm class */
 	&omap44xx_dmm_hwmod,
@@ -1077,6 +1391,12 @@ static __initdata struct omap_hwmod *omap44xx_hwmods[] = {
 	&omap44xx_uart2_hwmod,
 	&omap44xx_uart3_hwmod,
 	&omap44xx_uart4_hwmod,
+
+	/* mcbsp class */
+	&omap44xx_mcbsp1_hwmod,
+	&omap44xx_mcbsp2_hwmod,
+	&omap44xx_mcbsp3_hwmod,
+	&omap44xx_mcbsp4_hwmod,
 	NULL,
 };
 
-- 
1.7.0.4


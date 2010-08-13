From: Charulatha V <charu@ti.com>
Subject: [PATCH 4/5] OMAP4 HWMOD: Add mcspi hwmods.
Date: Fri, 13 Aug 2010 19:35:22 +0530
Message-ID: <1281708323-18989-5-git-send-email-charu@ti.com>
References: <1281708323-18989-1-git-send-email-charu@ti.com>
 <1281708323-18989-2-git-send-email-charu@ti.com>
 <1281708323-18989-3-git-send-email-charu@ti.com>
 <1281708323-18989-4-git-send-email-charu@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:34391 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934415Ab0HMODM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 Aug 2010 10:03:12 -0400
In-Reply-To: <1281708323-18989-4-git-send-email-charu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, paul@pwsan.com, b-cousson@ti.com, tony@atomide.com, grant.likely@secretlab.ca, dbrownell@users.sourceforge.net, spi-devel-general@lists.sourceforge.net, rnayak@ti.com, p-basak2@ti.com, charu@ti.com, govindraj.raja@ti.com

From: Benoit Cousson <b-cousson@ti.com>

Update omap4 hwmod file with mcspi info.

This patch is extracted from the below patch sent by Benoit
OMAP4: hwmod: Add partial hwmod support for OMAP4430 ES1.0
https://patchwork.kernel.org/patch/99052/

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Signed-off-by: Charulatha V <charu@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |  244 ++++++++++++++++++++++++++++
 1 files changed, 244 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index e20b0ee..dd31cc1 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -452,6 +452,245 @@ static struct omap_hwmod omap44xx_mpu_hwmod = {
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
 
+/*
+ * 'mcspi' class
+ * multichannel serial port interface (mcspi) / master/slave synchronous serial
+ * bus
+ */
+
+static struct omap_hwmod_class_sysconfig omap44xx_mcspi_sysc = {
+	.rev_offs	= 0x0000,
+	.sysc_offs	= 0x0010,
+	.syss_offs	= 0x0114,
+	.sysc_flags	= (SYSC_HAS_SIDLEMODE | SYSC_HAS_EMUFREE |
+			   SYSC_HAS_SOFTRESET),
+	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
+	.sysc_fields	= &omap_hwmod_sysc_type2,
+};
+
+static struct omap_hwmod_class omap44xx_mcspi_hwmod_class = {
+	.name = "mcspi",
+	.sysc = &omap44xx_mcspi_sysc,
+};
+
+/* mcspi1 */
+static struct omap_hwmod omap44xx_mcspi1_hwmod;
+static struct omap_hwmod_irq_info omap44xx_mcspi1_irqs[] = {
+	{ .irq = 65 + OMAP44XX_IRQ_GIC_START },
+};
+
+static struct omap_hwmod_dma_info omap44xx_mcspi1_sdma_reqs[] = {
+	{ .name = "tx0", .dma_req = 34 + OMAP44XX_DMA_REQ_START },
+	{ .name = "rx0", .dma_req = 35 + OMAP44XX_DMA_REQ_START },
+	{ .name = "tx1", .dma_req = 36 + OMAP44XX_DMA_REQ_START },
+	{ .name = "rx1", .dma_req = 37 + OMAP44XX_DMA_REQ_START },
+	{ .name = "tx2", .dma_req = 38 + OMAP44XX_DMA_REQ_START },
+	{ .name = "rx2", .dma_req = 39 + OMAP44XX_DMA_REQ_START },
+	{ .name = "tx3", .dma_req = 40 + OMAP44XX_DMA_REQ_START },
+	{ .name = "rx3", .dma_req = 41 + OMAP44XX_DMA_REQ_START },
+};
+
+static struct omap_hwmod_addr_space omap44xx_mcspi1_addrs[] = {
+	{
+		.pa_start	= 0x48098000,
+		.pa_end		= 0x480981ff,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+
+/* l4_per -> mcspi1 */
+static struct omap_hwmod_ocp_if omap44xx_l4_per__mcspi1 = {
+	.master		= &omap44xx_l4_per_hwmod,
+	.slave		= &omap44xx_mcspi1_hwmod,
+	.clk		= "l4_div_ck",
+	.addr		= omap44xx_mcspi1_addrs,
+	.addr_cnt	= ARRAY_SIZE(omap44xx_mcspi1_addrs),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* mcspi1 slave ports */
+static struct omap_hwmod_ocp_if *omap44xx_mcspi1_slaves[] = {
+	&omap44xx_l4_per__mcspi1,
+};
+
+static struct omap_hwmod omap44xx_mcspi1_hwmod = {
+	.name		= "mcspi1",
+	.class		= &omap44xx_mcspi_hwmod_class,
+	.mpu_irqs	= omap44xx_mcspi1_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_mcspi1_irqs),
+	.sdma_reqs	= omap44xx_mcspi1_sdma_reqs,
+	.sdma_reqs_cnt	= ARRAY_SIZE(omap44xx_mcspi1_sdma_reqs),
+	.main_clk	= "mcspi1_fck",
+	.prcm = {
+		.omap4 = {
+			.clkctrl_reg = OMAP4430_CM_L4PER_MCSPI1_CLKCTRL,
+		},
+	},
+	.slaves		= omap44xx_mcspi1_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap44xx_mcspi1_slaves),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+};
+
+/* mcspi2 */
+static struct omap_hwmod omap44xx_mcspi2_hwmod;
+static struct omap_hwmod_irq_info omap44xx_mcspi2_irqs[] = {
+	{ .irq = 66 + OMAP44XX_IRQ_GIC_START },
+};
+
+static struct omap_hwmod_dma_info omap44xx_mcspi2_sdma_reqs[] = {
+	{ .name = "tx0", .dma_req = 42 + OMAP44XX_DMA_REQ_START },
+	{ .name = "rx0", .dma_req = 43 + OMAP44XX_DMA_REQ_START },
+	{ .name = "tx1", .dma_req = 44 + OMAP44XX_DMA_REQ_START },
+	{ .name = "rx1", .dma_req = 45 + OMAP44XX_DMA_REQ_START },
+};
+
+static struct omap_hwmod_addr_space omap44xx_mcspi2_addrs[] = {
+	{
+		.pa_start	= 0x4809a000,
+		.pa_end		= 0x4809a1ff,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+
+/* l4_per -> mcspi2 */
+static struct omap_hwmod_ocp_if omap44xx_l4_per__mcspi2 = {
+	.master		= &omap44xx_l4_per_hwmod,
+	.slave		= &omap44xx_mcspi2_hwmod,
+	.clk		= "l4_div_ck",
+	.addr		= omap44xx_mcspi2_addrs,
+	.addr_cnt	= ARRAY_SIZE(omap44xx_mcspi2_addrs),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* mcspi2 slave ports */
+static struct omap_hwmod_ocp_if *omap44xx_mcspi2_slaves[] = {
+	&omap44xx_l4_per__mcspi2,
+};
+
+static struct omap_hwmod omap44xx_mcspi2_hwmod = {
+	.name		= "mcspi2",
+	.class		= &omap44xx_mcspi_hwmod_class,
+	.mpu_irqs	= omap44xx_mcspi2_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_mcspi2_irqs),
+	.sdma_reqs	= omap44xx_mcspi2_sdma_reqs,
+	.sdma_reqs_cnt	= ARRAY_SIZE(omap44xx_mcspi2_sdma_reqs),
+	.main_clk	= "mcspi2_fck",
+	.prcm = {
+		.omap4 = {
+			.clkctrl_reg = OMAP4430_CM_L4PER_MCSPI2_CLKCTRL,
+		},
+	},
+	.slaves		= omap44xx_mcspi2_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap44xx_mcspi2_slaves),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+};
+
+/* mcspi3 */
+static struct omap_hwmod omap44xx_mcspi3_hwmod;
+static struct omap_hwmod_irq_info omap44xx_mcspi3_irqs[] = {
+	{ .irq = 91 + OMAP44XX_IRQ_GIC_START },
+};
+
+static struct omap_hwmod_dma_info omap44xx_mcspi3_sdma_reqs[] = {
+	{ .name = "tx0", .dma_req = 14 + OMAP44XX_DMA_REQ_START },
+	{ .name = "rx0", .dma_req = 15 + OMAP44XX_DMA_REQ_START },
+	{ .name = "tx1", .dma_req = 22 + OMAP44XX_DMA_REQ_START },
+	{ .name = "rx1", .dma_req = 23 + OMAP44XX_DMA_REQ_START },
+};
+
+static struct omap_hwmod_addr_space omap44xx_mcspi3_addrs[] = {
+	{
+		.pa_start	= 0x480b8000,
+		.pa_end		= 0x480b81ff,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+
+/* l4_per -> mcspi3 */
+static struct omap_hwmod_ocp_if omap44xx_l4_per__mcspi3 = {
+	.master		= &omap44xx_l4_per_hwmod,
+	.slave		= &omap44xx_mcspi3_hwmod,
+	.clk		= "l4_div_ck",
+	.addr		= omap44xx_mcspi3_addrs,
+	.addr_cnt	= ARRAY_SIZE(omap44xx_mcspi3_addrs),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* mcspi3 slave ports */
+static struct omap_hwmod_ocp_if *omap44xx_mcspi3_slaves[] = {
+	&omap44xx_l4_per__mcspi3,
+};
+
+static struct omap_hwmod omap44xx_mcspi3_hwmod = {
+	.name		= "mcspi3",
+	.class		= &omap44xx_mcspi_hwmod_class,
+	.mpu_irqs	= omap44xx_mcspi3_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_mcspi3_irqs),
+	.sdma_reqs	= omap44xx_mcspi3_sdma_reqs,
+	.sdma_reqs_cnt	= ARRAY_SIZE(omap44xx_mcspi3_sdma_reqs),
+	.main_clk	= "mcspi3_fck",
+	.prcm = {
+		.omap4 = {
+			.clkctrl_reg = OMAP4430_CM_L4PER_MCSPI3_CLKCTRL,
+		},
+	},
+	.slaves		= omap44xx_mcspi3_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap44xx_mcspi3_slaves),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+};
+
+/* mcspi4 */
+static struct omap_hwmod omap44xx_mcspi4_hwmod;
+static struct omap_hwmod_irq_info omap44xx_mcspi4_irqs[] = {
+	{ .irq = 48 + OMAP44XX_IRQ_GIC_START },
+};
+
+static struct omap_hwmod_dma_info omap44xx_mcspi4_sdma_reqs[] = {
+	{ .name = "tx0", .dma_req = 69 + OMAP44XX_DMA_REQ_START },
+	{ .name = "rx0", .dma_req = 70 + OMAP44XX_DMA_REQ_START },
+};
+
+static struct omap_hwmod_addr_space omap44xx_mcspi4_addrs[] = {
+	{
+		.pa_start	= 0x480ba000,
+		.pa_end		= 0x480ba1ff,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+
+/* l4_per -> mcspi4 */
+static struct omap_hwmod_ocp_if omap44xx_l4_per__mcspi4 = {
+	.master		= &omap44xx_l4_per_hwmod,
+	.slave		= &omap44xx_mcspi4_hwmod,
+	.clk		= "l4_div_ck",
+	.addr		= omap44xx_mcspi4_addrs,
+	.addr_cnt	= ARRAY_SIZE(omap44xx_mcspi4_addrs),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* mcspi4 slave ports */
+static struct omap_hwmod_ocp_if *omap44xx_mcspi4_slaves[] = {
+	&omap44xx_l4_per__mcspi4,
+};
+
+static struct omap_hwmod omap44xx_mcspi4_hwmod = {
+	.name		= "mcspi4",
+	.class		= &omap44xx_mcspi_hwmod_class,
+	.mpu_irqs	= omap44xx_mcspi4_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_mcspi4_irqs),
+	.sdma_reqs	= omap44xx_mcspi4_sdma_reqs,
+	.sdma_reqs_cnt	= ARRAY_SIZE(omap44xx_mcspi4_sdma_reqs),
+	.main_clk	= "mcspi4_fck",
+	.prcm = {
+		.omap4 = {
+			.clkctrl_reg = OMAP4430_CM_L4PER_MCSPI4_CLKCTRL,
+		},
+	},
+	.slaves		= omap44xx_mcspi4_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap44xx_mcspi4_slaves),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+};
+
 static __initdata struct omap_hwmod *omap44xx_hwmods[] = {
 	/* dmm class */
 	&omap44xx_dmm_hwmod,
@@ -472,6 +711,11 @@ static __initdata struct omap_hwmod *omap44xx_hwmods[] = {
 
 	/* mpu class */
 	&omap44xx_mpu_hwmod,
+	/* mcspi class */
+	&omap44xx_mcspi1_hwmod,
+	&omap44xx_mcspi2_hwmod,
+	&omap44xx_mcspi3_hwmod,
+	&omap44xx_mcspi4_hwmod,
 	NULL,
 };
 
-- 
1.6.3.3


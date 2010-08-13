From: Charulatha V <charu@ti.com>
Subject: [PATCH 3/5] OMAP3 HWMOD: Add mcspi hwmods.
Date: Fri, 13 Aug 2010 19:35:21 +0530
Message-ID: <1281708323-18989-4-git-send-email-charu@ti.com>
References: <1281708323-18989-1-git-send-email-charu@ti.com>
 <1281708323-18989-2-git-send-email-charu@ti.com>
 <1281708323-18989-3-git-send-email-charu@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:34380 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934411Ab0HMODK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 Aug 2010 10:03:10 -0400
In-Reply-To: <1281708323-18989-3-git-send-email-charu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, paul@pwsan.com, b-cousson@ti.com, tony@atomide.com, grant.likely@secretlab.ca, dbrownell@users.sourceforge.net, spi-devel-general@lists.sourceforge.net, rnayak@ti.com, p-basak2@ti.com, charu@ti.com, govindraj.raja@ti.com

Update omap3 hwmod file with mcspi info.

Signed-off-by: Charulatha V <charu@ti.com>
Signed-off-by: Partha Basak <p-basak2@ti.com>
Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |  252 ++++++++++++++++++++++++++++
 1 files changed, 252 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index 5d8eb58..88ba29e 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -17,6 +17,7 @@
 #include <mach/irqs.h>
 #include <plat/cpu.h>
 #include <plat/dma.h>
+#include <plat/mcspi.h>
 
 #include "omap_hwmod_common_data.h"
 
@@ -36,6 +37,10 @@ static struct omap_hwmod omap3xxx_iva_hwmod;
 static struct omap_hwmod omap3xxx_l3_main_hwmod;
 static struct omap_hwmod omap3xxx_l4_core_hwmod;
 static struct omap_hwmod omap3xxx_l4_per_hwmod;
+static struct omap_hwmod omap34xx_mcspi1;
+static struct omap_hwmod omap34xx_mcspi2;
+static struct omap_hwmod omap34xx_mcspi3;
+static struct omap_hwmod omap34xx_mcspi4;
 
 /* L3 -> L4_CORE interface */
 static struct omap_hwmod_ocp_if omap3xxx_l3_main__l4_core = {
@@ -197,6 +202,249 @@ static struct omap_hwmod omap3xxx_iva_hwmod = {
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
 };
 
+/* L4 CORE -> MCSPI1 interface */
+static struct omap_hwmod_addr_space omap34xx_mcspi1_addr_space[] = {
+	{
+		.pa_start	= 0x48098000,
+		.pa_end		= 0x480980ff,
+		.flags		= ADDR_TYPE_RT,
+	},
+};
+
+static struct omap_hwmod_ocp_if omap34xx_l4_core__mcspi1 = {
+	.master		= &omap3xxx_l4_core_hwmod,
+	.slave		= &omap34xx_mcspi1,
+	.clk		= "mcspi1_ick",
+	.addr		= omap34xx_mcspi1_addr_space,
+	.addr_cnt	= ARRAY_SIZE(omap34xx_mcspi1_addr_space),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* L4 CORE -> MCSPI2 interface */
+static struct omap_hwmod_addr_space omap34xx_mcspi2_addr_space[] = {
+	{
+		.pa_start	= 0x4809a000,
+		.pa_end		= 0x4809a0ff,
+		.flags		= ADDR_TYPE_RT,
+	},
+};
+
+static struct omap_hwmod_ocp_if omap34xx_l4_core__mcspi2 = {
+	.master		= &omap3xxx_l4_core_hwmod,
+	.slave		= &omap34xx_mcspi2,
+	.clk		= "mcspi2_ick",
+	.addr		= omap34xx_mcspi2_addr_space,
+	.addr_cnt	= ARRAY_SIZE(omap34xx_mcspi2_addr_space),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* L4 CORE -> MCSPI3 interface */
+static struct omap_hwmod_addr_space omap34xx_mcspi3_addr_space[] = {
+	{
+		.pa_start	= 0x480b8000,
+		.pa_end		= 0x480b80ff,
+		.flags		= ADDR_TYPE_RT,
+	},
+};
+
+static struct omap_hwmod_ocp_if omap34xx_l4_core__mcspi3 = {
+	.master		= &omap3xxx_l4_core_hwmod,
+	.slave		= &omap34xx_mcspi3,
+	.clk		= "mcspi3_ick",
+	.addr		= omap34xx_mcspi3_addr_space,
+	.addr_cnt	= ARRAY_SIZE(omap34xx_mcspi3_addr_space),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* L4 CORE -> MCSPI4 interface */
+static struct omap_hwmod_addr_space omap34xx_mcspi4_addr_space[] = {
+	{
+		.pa_start	= 0x480ba000,
+		.pa_end		= 0x480ba0ff,
+		.flags		= ADDR_TYPE_RT,
+	},
+};
+
+static struct omap_hwmod_ocp_if omap34xx_l4_core__mcspi4 = {
+	.master		= &omap3xxx_l4_core_hwmod,
+	.slave		= &omap34xx_mcspi4,
+	.clk		= "mcspi4_ick",
+	.addr		= omap34xx_mcspi4_addr_space,
+	.addr_cnt	= ARRAY_SIZE(omap34xx_mcspi4_addr_space),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* SPI common */
+static struct omap_hwmod_class_sysconfig omap34xx_mcspi_sysc = {
+	.rev_offs	= 0x0000,
+	.sysc_offs	= 0x0010,
+	.syss_offs	= 0x0014,
+	.sysc_flags	= (SYSC_HAS_CLOCKACTIVITY | SYSC_HAS_SIDLEMODE |
+				SYSC_HAS_ENAWAKEUP | SYSC_HAS_SOFTRESET |
+				SYSC_HAS_AUTOIDLE),
+	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
+	.sysc_fields    = &omap_hwmod_sysc_type1,
+};
+
+static struct omap_hwmod_class omap34xx_mcspi_class = {
+	.name = "mcspi",
+	.sysc = &omap34xx_mcspi_sysc,
+};
+
+/* SPI1 */
+static struct omap_hwmod_irq_info omap34xx_mcspi1_mpu_irqs[] = {
+	{ .name = "irq", .irq = INT_24XX_SPI1_IRQ }, /* 65 */
+};
+
+static struct omap_hwmod_dma_info omap34xx_mcspi1_sdma_reqs[] = {
+	{ .name = "tx0", .dma_req = OMAP24XX_DMA_SPI1_TX0 }, /* 34 */
+	{ .name = "tx2", .dma_req = OMAP24XX_DMA_SPI1_TX2 }, /* 38 */
+	{ .name = "rx1", .dma_req = OMAP24XX_DMA_SPI1_RX1 }, /* 37 */
+	{ .name = "tx1", .dma_req = OMAP24XX_DMA_SPI1_TX1 }, /* 36 */
+	{ .name = "rx0", .dma_req = OMAP24XX_DMA_SPI1_RX0 }, /* 35 */
+	{ .name = "rx2", .dma_req = OMAP24XX_DMA_SPI1_RX2 }, /* 39 */
+	{ .name = "rx3", .dma_req = OMAP24XX_DMA_SPI1_RX3 }, /* 41 */
+	{ .name = "tx3", .dma_req = OMAP24XX_DMA_SPI1_TX3 }, /* 40 */
+};
+
+static struct omap_hwmod_ocp_if *omap34xx_mcspi1_slaves[] = {
+	&omap34xx_l4_core__mcspi1,
+};
+
+static struct omap_hwmod omap34xx_mcspi1 = {
+	.name		= "mcspi1",
+	.mpu_irqs	= omap34xx_mcspi1_mpu_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap34xx_mcspi1_mpu_irqs),
+	.sdma_reqs	= omap34xx_mcspi1_sdma_reqs,
+	.sdma_reqs_cnt	= ARRAY_SIZE(omap34xx_mcspi1_sdma_reqs),
+	.main_clk	= "mcspi1_fck",
+	.prcm		= {
+		.omap2 = {
+			.module_offs = CORE_MOD,
+			.prcm_reg_id = 1,
+			.module_bit = OMAP3430_EN_MCSPI1_SHIFT,
+			.idlest_reg_id = 1,
+			.idlest_idle_bit = OMAP3430_EN_MCSPI1_SHIFT,
+		},
+	},
+	.slaves		= omap34xx_mcspi1_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap34xx_mcspi1_slaves),
+	.class		= &omap34xx_mcspi_class,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+};
+
+/* SPI2 */
+static struct omap_hwmod_irq_info omap34xx_mcspi2_mpu_irqs[] = {
+	{ .name = "irq", .irq = INT_24XX_SPI2_IRQ }, /* 66 */
+};
+
+static struct omap_hwmod_dma_info omap34xx_mcspi2_sdma_reqs[] = {
+	{ .name = "tx0", .dma_req = OMAP24XX_DMA_SPI2_TX0 }, /* 42 */
+	{ .name = "tx1", .dma_req = OMAP24XX_DMA_SPI2_TX1 }, /* 44 */
+	{ .name = "rx0", .dma_req = OMAP24XX_DMA_SPI2_RX0 }, /* 43 */
+	{ .name = "rx1", .dma_req = OMAP24XX_DMA_SPI2_RX1 }, /* 45 */
+};
+
+static struct omap_hwmod_ocp_if *omap34xx_mcspi2_slaves[] = {
+	&omap34xx_l4_core__mcspi2,
+};
+
+static struct omap_hwmod omap34xx_mcspi2 = {
+	.name		= "mcspi2",
+	.mpu_irqs	= omap34xx_mcspi2_mpu_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap34xx_mcspi2_mpu_irqs),
+	.sdma_reqs	= omap34xx_mcspi2_sdma_reqs,
+	.sdma_reqs_cnt	= ARRAY_SIZE(omap34xx_mcspi2_sdma_reqs),
+	.main_clk	= "mcspi2_fck",
+	.prcm		= {
+		.omap2 = {
+			.module_offs = CORE_MOD,
+			.prcm_reg_id = 1,
+			.module_bit = OMAP3430_EN_MCSPI2_SHIFT,
+			.idlest_reg_id = 1,
+			.idlest_idle_bit = OMAP3430_EN_MCSPI2_SHIFT,
+		},
+	},
+	.slaves		= omap34xx_mcspi2_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap34xx_mcspi2_slaves),
+	.class		= &omap34xx_mcspi_class,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+};
+
+/* SPI3 */
+static struct omap_hwmod_irq_info omap34xx_mcspi3_mpu_irqs[] = {
+	{ .name = "irq", .irq = INT_24XX_SPI3_IRQ }, /* 91 */
+};
+
+static struct omap_hwmod_dma_info omap34xx_mcspi3_sdma_reqs[] = {
+	{ .name = "tx0", .dma_req = OMAP24XX_DMA_SPI3_TX0 }, /* 14 */
+	{ .name = "tx1", .dma_req = OMAP24XX_DMA_SPI3_TX1 }, /* 22 */
+	{ .name = "rx0", .dma_req = OMAP24XX_DMA_SPI3_RX0 }, /* 15 */
+	{ .name = "rx1", .dma_req = OMAP24XX_DMA_SPI3_RX1 }, /* 23 */
+};
+
+static struct omap_hwmod_ocp_if *omap34xx_mcspi3_slaves[] = {
+	&omap34xx_l4_core__mcspi3,
+};
+
+static struct omap_hwmod omap34xx_mcspi3 = {
+	.name		= "mcspi3",
+	.mpu_irqs	= omap34xx_mcspi3_mpu_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap34xx_mcspi3_mpu_irqs),
+	.sdma_reqs	= omap34xx_mcspi3_sdma_reqs,
+	.sdma_reqs_cnt	= ARRAY_SIZE(omap34xx_mcspi3_sdma_reqs),
+	.main_clk	= "mcspi3_fck",
+	.prcm		= {
+		.omap2 = {
+			.module_offs = CORE_MOD,
+			.prcm_reg_id = 1,
+			.module_bit = OMAP3430_EN_MCSPI3_SHIFT,
+			.idlest_reg_id = 1,
+			.idlest_idle_bit = OMAP3430_EN_MCSPI3_SHIFT,
+		},
+	},
+	.slaves		= omap34xx_mcspi3_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap34xx_mcspi3_slaves),
+	.class		= &omap34xx_mcspi_class,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+};
+
+/* SPI4 */
+static struct omap_hwmod_irq_info omap34xx_mcspi4_mpu_irqs[] = {
+	{ .name = "irq", .irq = INT_34XX_SPI4_IRQ }, /* 48 */
+};
+
+static struct omap_hwmod_dma_info omap34xx_mcspi4_sdma_reqs[] = {
+	{ .name = "tx0", .dma_req = OMAP34XX_DMA_SPI4_TX0 }, /* 69 */
+	{ .name = "rx0", .dma_req = OMAP34XX_DMA_SPI4_RX0 }, /* 70 */
+};
+
+static struct omap_hwmod_ocp_if *omap34xx_mcspi4_slaves[] = {
+	&omap34xx_l4_core__mcspi4,
+};
+
+static struct omap_hwmod omap34xx_mcspi4 = {
+	.name		= "mcspi4",
+	.mpu_irqs	= omap34xx_mcspi4_mpu_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap34xx_mcspi4_mpu_irqs),
+	.sdma_reqs	= omap34xx_mcspi4_sdma_reqs,
+	.sdma_reqs_cnt	= ARRAY_SIZE(omap34xx_mcspi4_sdma_reqs),
+	.main_clk	= "mcspi4_fck",
+	.prcm		= {
+		.omap2 = {
+			.module_offs = CORE_MOD,
+			.prcm_reg_id = 1,
+			.module_bit = OMAP3430_EN_MCSPI4_SHIFT,
+			.idlest_reg_id = 1,
+			.idlest_idle_bit = OMAP3430_EN_MCSPI4_SHIFT,
+		},
+	},
+	.slaves		= omap34xx_mcspi4_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap34xx_mcspi4_slaves),
+	.class		= &omap34xx_mcspi_class,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+};
+
 static __initdata struct omap_hwmod *omap3xxx_hwmods[] = {
 	&omap3xxx_l3_main_hwmod,
 	&omap3xxx_l4_core_hwmod,
@@ -204,6 +452,10 @@ static __initdata struct omap_hwmod *omap3xxx_hwmods[] = {
 	&omap3xxx_l4_wkup_hwmod,
 	&omap3xxx_mpu_hwmod,
 	&omap3xxx_iva_hwmod,
+	&omap34xx_mcspi1,
+	&omap34xx_mcspi2,
+	&omap34xx_mcspi3,
+	&omap34xx_mcspi4,
 	NULL,
 };
 
-- 
1.6.3.3


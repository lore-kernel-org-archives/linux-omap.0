From: Charulatha V <charu@ti.com>
Subject: [PATCH 2/5] OMAP2430 : McSPI: Add mcspi hwmod data
Date: Fri, 13 Aug 2010 19:35:20 +0530
Message-ID: <1281708323-18989-3-git-send-email-charu@ti.com>
References: <1281708323-18989-1-git-send-email-charu@ti.com>
 <1281708323-18989-2-git-send-email-charu@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:34373 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934411Ab0HMODH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 Aug 2010 10:03:07 -0400
In-Reply-To: <1281708323-18989-2-git-send-email-charu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, paul@pwsan.com, b-cousson@ti.com, tony@atomide.com, grant.likely@secretlab.ca, dbrownell@users.sourceforge.net, spi-devel-general@lists.sourceforge.net, rnayak@ti.com, p-basak2@ti.com, charu@ti.com, govindraj.raja@ti.com

Update the 2430 hwmod dat file with McSPI info.

Signed-off-by: Charulatha V <charu@ti.com>
Signed-off-by: Partha Basak <p-basak2@ti.com>
Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_2430_data.c |  196 ++++++++++++++++++++++++++++
 1 files changed, 196 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_2430_data.c b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
index 4526628..52eeadd 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2430_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
@@ -15,6 +15,7 @@
 #include <mach/irqs.h>
 #include <plat/cpu.h>
 #include <plat/dma.h>
+#include <plat/mcspi.h>
 
 #include "omap_hwmod_common_data.h"
 
@@ -71,6 +72,9 @@ static struct omap_hwmod omap2430_l3_main_hwmod = {
 };
 
 static struct omap_hwmod omap2430_l4_wkup_hwmod;
+static struct omap_hwmod omap2430_mcspi1_hwmod;
+static struct omap_hwmod omap2430_mcspi2_hwmod;
+static struct omap_hwmod omap2430_mcspi3_hwmod;
 
 /* L4_CORE -> L4_WKUP interface */
 static struct omap_hwmod_ocp_if omap2430_l4_core__l4_wkup = {
@@ -110,6 +114,60 @@ static struct omap_hwmod_ocp_if *omap2430_l4_wkup_slaves[] = {
 static struct omap_hwmod_ocp_if *omap2430_l4_wkup_masters[] = {
 };
 
+/* L4 CORE -> MCSPI1 interface */
+static struct omap_hwmod_addr_space omap2430_mcspi1_addr_space[] = {
+	{
+		.pa_start	= 0x48098000,
+		.pa_end		= 0x480980ff,
+		.flags		= ADDR_TYPE_RT,
+	},
+};
+
+static struct omap_hwmod_ocp_if omap2430_l4_core__mcspi1 = {
+	.master		= &omap2430_l4_core_hwmod,
+	.slave		= &omap2430_mcspi1_hwmod,
+	.clk		= "mcspi1_ick",
+	.addr		= omap2430_mcspi1_addr_space,
+	.addr_cnt	= ARRAY_SIZE(omap2430_mcspi1_addr_space),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* L4 CORE -> MCSPI2 interface */
+static struct omap_hwmod_addr_space omap2430_mcspi2_addr_space[] = {
+	{
+		.pa_start	= 0x4809a000,
+		.pa_end		= 0x4809a0ff,
+		.flags		= ADDR_TYPE_RT,
+	},
+};
+
+static struct omap_hwmod_ocp_if omap2430_l4_core__mcspi2 = {
+	.master		= &omap2430_l4_core_hwmod,
+	.slave		= &omap2430_mcspi2_hwmod,
+	.clk		= "mcspi2_ick",
+	.addr		= omap2430_mcspi2_addr_space,
+	.addr_cnt	= ARRAY_SIZE(omap2430_mcspi2_addr_space),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* L4 CORE -> MCSPI3 interface */
+static struct omap_hwmod_addr_space omap2430_mcspi3_addr_space[] = {
+	{
+		.pa_start	= 0x480b8000,
+		.pa_end		= 0x480b80ff,
+		.flags		= ADDR_TYPE_RT,
+	},
+};
+
+static struct omap_hwmod_ocp_if omap2430_l4_core__mcspi3 = {
+	.master		= &omap2430_l4_core_hwmod,
+	.slave		= &omap2430_mcspi3_hwmod,
+	.clk		= "mcspi3_ick",
+	.addr		= omap2430_mcspi3_addr_space,
+	.addr_cnt	= ARRAY_SIZE(omap2430_mcspi3_addr_space),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
 /* L4 WKUP */
 static struct omap_hwmod omap2430_l4_wkup_hwmod = {
 	.name		= "l4_wkup",
@@ -165,12 +223,150 @@ static struct omap_hwmod omap2430_iva_hwmod = {
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2430)
 };
 
+/* SPI common */
+static struct omap_hwmod_class_sysconfig omap2430_mcspi_sysc = {
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
+static struct omap_hwmod_class omap2430_mcspi_class = {
+	.name = "mcspi",
+	.sysc = &omap2430_mcspi_sysc,
+};
+
+/* SPI1 */
+static struct omap_hwmod_irq_info omap2430_mcspi1_mpu_irqs[] = {
+	{ .irq = INT_24XX_SPI1_IRQ }, /* 65 */
+};
+
+static struct omap_hwmod_dma_info omap2430_mcspi1_sdma_reqs[] = {
+	{ .name = "rx0", .dma_req = OMAP24XX_DMA_SPI1_RX0 }, /* 35 */
+	{ .name = "rx1", .dma_req = OMAP24XX_DMA_SPI1_RX1 }, /* 37 */
+	{ .name = "rx2", .dma_req = OMAP24XX_DMA_SPI1_RX2 }, /* 39 */
+	{ .name = "rx3", .dma_req = OMAP24XX_DMA_SPI1_RX3 }, /* 41 */
+	{ .name = "tx0", .dma_req = OMAP24XX_DMA_SPI1_TX0 }, /* 34 */
+	{ .name = "tx1", .dma_req = OMAP24XX_DMA_SPI1_TX1 }, /* 36 */
+	{ .name = "tx2", .dma_req = OMAP24XX_DMA_SPI1_TX2 }, /* 38 */
+	{ .name = "tx3", .dma_req = OMAP24XX_DMA_SPI1_TX3 }, /* 40 */
+};
+
+static struct omap_hwmod_ocp_if *omap2430_mcspi1_slaves[] = {
+	&omap2430_l4_core__mcspi1,
+};
+
+static struct omap_hwmod omap2430_mcspi1_hwmod = {
+	.name		= "mcspi1_hwmod",
+	.mpu_irqs	= omap2430_mcspi1_mpu_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap2430_mcspi1_mpu_irqs),
+	.sdma_reqs	= omap2430_mcspi1_sdma_reqs,
+	.sdma_reqs_cnt	= ARRAY_SIZE(omap2430_mcspi1_sdma_reqs),
+	.main_clk	= "mcspi1_fck",
+	.prcm		= {
+		.omap2 = {
+			.module_offs = CORE_MOD,
+			.prcm_reg_id = 1,
+			.module_bit = OMAP24XX_EN_MCSPI1_SHIFT,
+			.idlest_reg_id = 1,
+			.idlest_idle_bit = OMAP24XX_EN_MCSPI1_SHIFT,
+		},
+	},
+	.slaves		= omap2430_mcspi1_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap2430_mcspi1_slaves),
+	.class		= &omap2430_mcspi_class,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2430),
+};
+
+/* SPI2 */
+static struct omap_hwmod_irq_info omap2430_mcspi2_mpu_irqs[] = {
+	{ .irq = INT_24XX_SPI2_IRQ }, /* 66 */
+};
+
+static struct omap_hwmod_dma_info omap2430_mcspi2_sdma_reqs[] = {
+	{ .name = "rx0", .dma_req = OMAP24XX_DMA_SPI2_RX0 }, /* 43 */
+	{ .name = "rx1", .dma_req = OMAP24XX_DMA_SPI2_RX1 }, /* 45 */
+	{ .name = "tx0", .dma_req = OMAP24XX_DMA_SPI2_TX0 }, /* 42 */
+	{ .name = "tx1", .dma_req = OMAP24XX_DMA_SPI2_TX1 }, /* 44 */
+};
+
+static struct omap_hwmod_ocp_if *omap2430_mcspi2_slaves[] = {
+	&omap2430_l4_core__mcspi2,
+};
+
+static struct omap_hwmod omap2430_mcspi2_hwmod = {
+	.name		= "mcspi2_hwmod",
+	.mpu_irqs	= omap2430_mcspi2_mpu_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap2430_mcspi2_mpu_irqs),
+	.sdma_reqs	= omap2430_mcspi2_sdma_reqs,
+	.sdma_reqs_cnt	= ARRAY_SIZE(omap2430_mcspi2_sdma_reqs),
+	.main_clk	= "mcspi2_fck",
+	.prcm		= {
+		.omap2 = {
+			.module_offs = CORE_MOD,
+			.prcm_reg_id = 1,
+			.module_bit = OMAP24XX_EN_MCSPI2_SHIFT,
+			.idlest_reg_id = 1,
+			.idlest_idle_bit = OMAP24XX_EN_MCSPI2_SHIFT,
+		},
+	},
+	.slaves		= omap2430_mcspi2_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap2430_mcspi2_slaves),
+	.class		= &omap2430_mcspi_class,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2430),
+};
+
+/* SPI3 */
+static struct omap_hwmod_irq_info omap2430_mcspi3_mpu_irqs[] = {
+	{ .irq = INT_24XX_SPI3_IRQ }, /* 91 */
+};
+
+static struct omap_hwmod_dma_info omap2430_mcspi3_sdma_reqs[] = {
+	{ .name = "rx0", .dma_req = OMAP24XX_DMA_SPI3_RX0 }, /* 15 */
+	{ .name = "rx1", .dma_req = OMAP24XX_DMA_SPI3_RX1 }, /* 23 */
+	{ .name = "tx0", .dma_req = OMAP24XX_DMA_SPI3_TX0 }, /* 14 */
+	{ .name = "tx1", .dma_req = OMAP24XX_DMA_SPI3_TX1 }, /* 22 */
+};
+
+static struct omap_hwmod_ocp_if *omap2430_mcspi3_slaves[] = {
+	&omap2430_l4_core__mcspi3,
+};
+
+static struct omap_hwmod omap2430_mcspi3_hwmod = {
+	.name		= "mcspi3_hwmod",
+	.mpu_irqs	= omap2430_mcspi3_mpu_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap2430_mcspi3_mpu_irqs),
+	.sdma_reqs	= omap2430_mcspi3_sdma_reqs,
+	.sdma_reqs_cnt	= ARRAY_SIZE(omap2430_mcspi3_sdma_reqs),
+	.main_clk	= "mcspi3_fck",
+	.prcm		= {
+		.omap2 = {
+			.module_offs = CORE_MOD,
+			.prcm_reg_id = 2,
+			.module_bit = OMAP2430_EN_MCSPI3_SHIFT,
+			.idlest_reg_id = 2,
+			.idlest_idle_bit = OMAP24XX_EN_MCSPI2_SHIFT,
+		},
+	},
+	.slaves		= omap2430_mcspi3_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap2430_mcspi3_slaves),
+	.class		= &omap2430_mcspi_class,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2430),
+};
+
 static __initdata struct omap_hwmod *omap2430_hwmods[] = {
 	&omap2430_l3_main_hwmod,
 	&omap2430_l4_core_hwmod,
 	&omap2430_l4_wkup_hwmod,
 	&omap2430_mpu_hwmod,
 	&omap2430_iva_hwmod,
+	&omap2430_mcspi1_hwmod,
+	&omap2430_mcspi2_hwmod,
+	&omap2430_mcspi3_hwmod,
 	NULL,
 };
 
-- 
1.6.3.3


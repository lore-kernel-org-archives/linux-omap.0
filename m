From: Charulatha V <charu@ti.com>
Subject: [PATCH 1/5] OMAP2420: McSPI: Add mcspi hwmod
Date: Fri, 13 Aug 2010 19:35:19 +0530
Message-ID: <1281708323-18989-2-git-send-email-charu@ti.com>
References: <1281708323-18989-1-git-send-email-charu@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:54832 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934404Ab0HMODF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Aug 2010 10:03:05 -0400
In-Reply-To: <1281708323-18989-1-git-send-email-charu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, paul@pwsan.com, b-cousson@ti.com, tony@atomide.com, grant.likely@secretlab.ca, dbrownell@users.sourceforge.net, spi-devel-general@lists.sourceforge.net, rnayak@ti.com, p-basak2@ti.com, charu@ti.com, govindraj.raja@ti.com

This patch updates the omap2420 hwmod data with the
McSPI info.

Signed-off-by: Charulatha V <charu@ti.com>
Signed-off-by: Partha Basak <p-basak2@ti.com>
Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_2420_data.c |  138 ++++++++++++++++++++++++++++
 1 files changed, 138 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_2420_data.c b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
index 3cc768e..7d1a0ff 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2420_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
@@ -15,6 +15,7 @@
 #include <mach/irqs.h>
 #include <plat/cpu.h>
 #include <plat/dma.h>
+#include <plat/mcspi.h>
 
 #include "omap_hwmod_common_data.h"
 
@@ -33,6 +34,8 @@ static struct omap_hwmod omap2420_mpu_hwmod;
 static struct omap_hwmod omap2420_iva_hwmod;
 static struct omap_hwmod omap2420_l3_main_hwmod;
 static struct omap_hwmod omap2420_l4_core_hwmod;
+static struct omap_hwmod omap2420_mcspi1_hwmod;
+static struct omap_hwmod omap2420_mcspi2_hwmod;
 
 /* L3 -> L4_CORE interface */
 static struct omap_hwmod_ocp_if omap2420_l3_main__l4_core = {
@@ -72,6 +75,42 @@ static struct omap_hwmod omap2420_l3_main_hwmod = {
 
 static struct omap_hwmod omap2420_l4_wkup_hwmod;
 
+/* L4 CORE -> MCSPI1 interface */
+static struct omap_hwmod_addr_space omap2420_mcspi1_addr_space[] = {
+	{
+		.pa_start	= 0x48098000,
+		.pa_end		= 0x480980ff,
+		.flags		= ADDR_TYPE_RT,
+	},
+};
+
+static struct omap_hwmod_ocp_if omap2420_l4_core__mcspi1 = {
+	.master		= &omap2420_l4_core_hwmod,
+	.slave		= &omap2420_mcspi1_hwmod,
+	.clk		= "mcspi1_ick",
+	.addr		= omap2420_mcspi1_addr_space,
+	.addr_cnt	= ARRAY_SIZE(omap2420_mcspi1_addr_space),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* L4 CORE -> MCSPI2 interface */
+static struct omap_hwmod_addr_space omap2420_mcspi2_addr_space[] = {
+	{
+		.pa_start	= 0x4809a000,
+		.pa_end		= 0x4809a0ff,
+		.flags		= ADDR_TYPE_RT,
+	},
+};
+
+static struct omap_hwmod_ocp_if omap2420_l4_core__mcspi2 = {
+	.master		= &omap2420_l4_core_hwmod,
+	.slave		= &omap2420_mcspi2_hwmod,
+	.clk		= "mcspi2_ick",
+	.addr		= omap2420_mcspi2_addr_space,
+	.addr_cnt	= ARRAY_SIZE(omap2420_mcspi2_addr_space),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
 /* L4_CORE -> L4_WKUP interface */
 static struct omap_hwmod_ocp_if omap2420_l4_core__l4_wkup = {
 	.master	= &omap2420_l4_core_hwmod,
@@ -165,12 +204,111 @@ static struct omap_hwmod omap2420_iva_hwmod = {
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2420)
 };
 
+/* SPI common */
+static struct omap_hwmod_class_sysconfig omap2420_mcspi_sysc = {
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
+static struct omap_hwmod_class omap2420_mcspi_class = {
+	.name = "mcspi",
+	.sysc = &omap2420_mcspi_sysc,
+};
+
+/* SPI1 */
+static struct omap_hwmod_irq_info omap2420_mcspi1_mpu_irqs[] = {
+	{ .irq = INT_24XX_SPI1_IRQ }, /* 65 */
+};
+
+static struct omap_hwmod_dma_info omap2420_mcspi1_sdma_reqs[] = {
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
+static struct omap_hwmod_ocp_if *omap2420_mcspi1_slaves[] = {
+	&omap2420_l4_core__mcspi1,
+};
+
+static struct omap_hwmod omap2420_mcspi1_hwmod = {
+	.name		= "mcspi1_hwmod",
+	.mpu_irqs	= omap2420_mcspi1_mpu_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap2420_mcspi1_mpu_irqs),
+	.sdma_reqs	= omap2420_mcspi1_sdma_reqs,
+	.sdma_reqs_cnt	= ARRAY_SIZE(omap2420_mcspi1_sdma_reqs),
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
+	.slaves		= omap2420_mcspi1_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap2420_mcspi1_slaves),
+	.class		= &omap2420_mcspi_class,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2420),
+};
+
+/* SPI2 */
+static struct omap_hwmod_irq_info omap2420_mcspi2_mpu_irqs[] = {
+	{ .irq = INT_24XX_SPI2_IRQ }, /* 66 */
+};
+
+static struct omap_hwmod_dma_info omap2420_mcspi2_sdma_reqs[] = {
+	{ .name = "rx0", .dma_req = OMAP24XX_DMA_SPI2_RX0 }, /* 43 */
+	{ .name = "rx1", .dma_req = OMAP24XX_DMA_SPI2_RX1 }, /* 45 */
+	{ .name = "tx0", .dma_req = OMAP24XX_DMA_SPI2_TX0 }, /* 42 */
+	{ .name = "tx1", .dma_req = OMAP24XX_DMA_SPI2_TX1 }, /* 44 */
+};
+
+static struct omap_hwmod_ocp_if *omap2420_mcspi2_slaves[] = {
+	&omap2420_l4_core__mcspi2,
+};
+
+static struct omap_hwmod omap2420_mcspi2_hwmod = {
+	.name		= "mcspi2_hwmod",
+	.mpu_irqs	= omap2420_mcspi2_mpu_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap2420_mcspi2_mpu_irqs),
+	.sdma_reqs	= omap2420_mcspi2_sdma_reqs,
+	.sdma_reqs_cnt	= ARRAY_SIZE(omap2420_mcspi2_sdma_reqs),
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
+	.slaves		= omap2420_mcspi2_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap2420_mcspi2_slaves),
+	.class		= &omap2420_mcspi_class,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2420),
+};
+
 static __initdata struct omap_hwmod *omap2420_hwmods[] = {
 	&omap2420_l3_main_hwmod,
 	&omap2420_l4_core_hwmod,
 	&omap2420_l4_wkup_hwmod,
 	&omap2420_mpu_hwmod,
 	&omap2420_iva_hwmod,
+	&omap2420_mcspi1_hwmod,
+	&omap2420_mcspi2_hwmod,
 	NULL,
 };
 
-- 
1.6.3.3


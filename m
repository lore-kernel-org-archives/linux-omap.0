From: "Govindraj.R" <govindraj.raja@ti.com>
Subject: [pm-wip/uart][PATCH 5/6] Serial: Add UART hwmod data for 2430.
Date: Thu, 20 May 2010 19:09:04 +0530 (IST)
Message-ID: <48729.192.168.10.88.1274362744.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:53233 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752794Ab0ETNjG (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 20 May 2010 09:39:06 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Kevin Hilman <khilman@deeprootsystems.com>


Add UART HWMOD data into 2430 hmwod data file.

Cc: Kevin Hilman <khilman@deeprootsystems.com>
Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_2430_data.c |  184 ++++++++++++++++++++++++++++
 1 files changed, 184 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_2430_data.c b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
index d9c92aa..3a02532 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2430_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
@@ -15,6 +15,7 @@
 #include <mach/irqs.h>
 #include <plat/cpu.h>
 #include <plat/dma.h>
+#include <plat/serial.h>
 #include <plat/mmc.h>

 #include "omap_hwmod_common_data.h"
@@ -73,6 +74,9 @@ static struct omap_hwmod omap2430_l3_hwmod = {
 static struct omap_hwmod omap2430_l4_wkup_hwmod;
 static struct omap_hwmod omap2430_mmc1_hwmod;
 static struct omap_hwmod omap2430_mmc2_hwmod;
+static struct omap_hwmod omap2430_uart1_hwmod;
+static struct omap_hwmod omap2430_uart2_hwmod;
+static struct omap_hwmod omap2430_uart3_hwmod;

 /* L4_CORE -> L4_WKUP interface */
 static struct omap_hwmod_ocp_if omap2430_l4_core__l4_wkup = {
@@ -118,6 +122,60 @@ static struct omap_hwmod_ocp_if omap2430_l4_core__mmc2 = {
 };


+/* L4 CORE -> UART1 interface */
+static struct omap_hwmod_addr_space omap2430_uart1_addr_space[] = {
+	{
+		.pa_start	= OMAP2_UART1_BASE,
+		.pa_end		= OMAP2_UART1_BASE + SZ_8K - 1,
+		.flags		= ADDR_MAP_ON_INIT | ADDR_TYPE_RT,
+	},
+};
+
+static struct omap_hwmod_ocp_if omap2_l4_core__uart1 = {
+	.master		= &omap2430_l4_core_hwmod,
+	.slave		= &omap2430_uart1_hwmod,
+	.clk		= "uart1_ick",
+	.addr		= omap2430_uart1_addr_space,
+	.addr_cnt	= ARRAY_SIZE(omap2430_uart1_addr_space),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* L4 CORE -> UART2 interface */
+static struct omap_hwmod_addr_space omap2430_uart2_addr_space[] = {
+	{
+		.pa_start	= OMAP2_UART2_BASE,
+		.pa_end		= OMAP2_UART2_BASE + SZ_1K - 1,
+		.flags		= ADDR_MAP_ON_INIT | ADDR_TYPE_RT,
+	},
+};
+
+static struct omap_hwmod_ocp_if omap2_l4_core__uart2 = {
+	.master		= &omap2430_l4_core_hwmod,
+	.slave		= &omap2430_uart2_hwmod,
+	.clk		= "uart2_ick",
+	.addr		= omap2430_uart2_addr_space,
+	.addr_cnt	= ARRAY_SIZE(omap2430_uart2_addr_space),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* L4 PER -> UART3 interface */
+static struct omap_hwmod_addr_space omap2430_uart3_addr_space[] = {
+	{
+		.pa_start	= OMAP2_UART3_BASE,
+		.pa_end		= OMAP2_UART3_BASE + SZ_1K - 1,
+		.flags		= ADDR_MAP_ON_INIT | ADDR_TYPE_RT,
+	},
+};
+
+static struct omap_hwmod_ocp_if omap2_l4_core__uart3 = {
+	.master		= &omap2430_l4_core_hwmod,
+	.slave		= &omap2430_uart3_hwmod,
+	.clk		= "uart3_ick",
+	.addr		= omap2430_uart3_addr_space,
+	.addr_cnt	= ARRAY_SIZE(omap2430_uart3_addr_space),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
 /* Slave interfaces on the L4_CORE interconnect */
 static struct omap_hwmod_ocp_if *omap2430_l4_core_slaves[] = {
 	&omap2430_l3__l4_core,
@@ -144,6 +202,9 @@ static struct omap_hwmod omap2430_l4_core_hwmod = {
 /* Slave interfaces on the L4_WKUP interconnect */
 static struct omap_hwmod_ocp_if *omap2430_l4_wkup_slaves[] = {
 	&omap2430_l4_core__l4_wkup,
+	&omap2_l4_core__uart1,
+	&omap2_l4_core__uart2,
+	&omap2_l4_core__uart3,
 };

 /* Master interfaces on the L4_WKUP interconnect */
@@ -283,11 +344,134 @@ static struct omap_hwmod omap2430_mmc2_hwmod = {
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2430),
 };

+/* UART */
+
+static struct omap_hwmod_class_sysconfig uart_sysc = {
+	.rev_offs	= 0x50,
+	.sysc_offs	= 0x54,
+	.syss_offs	= 0x58,
+	.sysc_flags	= (SYSC_HAS_SIDLEMODE |
+			   SYSC_HAS_ENAWAKEUP | SYSC_HAS_SOFTRESET |
+			   SYSC_HAS_AUTOIDLE),
+	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
+	.sysc_fields    = &omap_hwmod_sysc_type1,
+};
+
+static struct omap_hwmod_class uart_class = {
+	.name = "uart",
+	.sysc = &uart_sysc,
+};
+
+/* UART1 */
+
+static struct omap_hwmod_irq_info uart1_mpu_irqs[] = {
+	{ .irq = INT_24XX_UART1_IRQ, },
+};
+
+static struct omap_hwmod_dma_info uart1_sdma_chs[] = {
+	{ .name = "rx",	.dma_ch = OMAP24XX_DMA_UART1_RX, },
+	{ .name = "tx",	.dma_ch = OMAP24XX_DMA_UART1_TX, },
+};
+
+static struct omap_hwmod_ocp_if *omap2430_uart1_slaves[] = {
+	&omap2_l4_core__uart1,
+};
+
+static struct omap_hwmod omap2430_uart1_hwmod = {
+	.name		= "uart1",
+	.mpu_irqs	= uart1_mpu_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(uart1_mpu_irqs),
+	.sdma_chs	= uart1_sdma_chs,
+	.sdma_chs_cnt	= ARRAY_SIZE(uart1_sdma_chs),
+	.main_clk	= "uart1_fck",
+	.prcm		= {
+		.omap2 = {
+			.prcm_reg_id = 1,
+			.module_bit = OMAP24XX_EN_UART1_SHIFT,
+		},
+	},
+	.slaves		= omap2430_uart1_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap2430_uart1_slaves),
+	.class		= &uart_class,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2430),
+};
+
+/* UART2 */
+
+static struct omap_hwmod_irq_info uart2_mpu_irqs[] = {
+	{ .irq = INT_24XX_UART2_IRQ, },
+};
+
+static struct omap_hwmod_dma_info uart2_sdma_chs[] = {
+	{ .name = "rx",	.dma_ch = OMAP24XX_DMA_UART2_RX, },
+	{ .name = "tx",	.dma_ch = OMAP24XX_DMA_UART2_TX, },
+};
+
+static struct omap_hwmod_ocp_if *omap2430_uart2_slaves[] = {
+	&omap2_l4_core__uart2,
+};
+
+static struct omap_hwmod omap2430_uart2_hwmod = {
+	.name		= "uart2",
+	.mpu_irqs	= uart2_mpu_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(uart2_mpu_irqs),
+	.sdma_chs	= uart2_sdma_chs,
+	.sdma_chs_cnt	= ARRAY_SIZE(uart2_sdma_chs),
+	.main_clk	= "uart2_fck",
+	.prcm		= {
+		.omap2 = {
+			.prcm_reg_id = 1,
+			.module_bit = OMAP24XX_EN_UART2_SHIFT,
+		},
+	},
+	.slaves		= omap2430_uart2_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap2430_uart2_slaves),
+	.class		= &uart_class,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2430),
+};
+
+/* UART3 */
+
+static struct omap_hwmod_irq_info uart3_mpu_irqs[] = {
+	{ .irq = INT_24XX_UART3_IRQ, },
+};
+
+static struct omap_hwmod_dma_info uart3_sdma_chs[] = {
+	{ .name = "rx",	.dma_ch = OMAP24XX_DMA_UART3_RX, },
+	{ .name = "tx",	.dma_ch = OMAP24XX_DMA_UART3_TX, },
+};
+
+static struct omap_hwmod_ocp_if *omap2430_uart3_slaves[] = {
+	&omap2_l4_core__uart3,
+};
+
+static struct omap_hwmod omap2430_uart3_hwmod = {
+	.name		= "uart3",
+	.mpu_irqs	= uart3_mpu_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(uart3_mpu_irqs),
+	.sdma_chs	= uart3_sdma_chs,
+	.sdma_chs_cnt	= ARRAY_SIZE(uart3_sdma_chs),
+	.main_clk	= "uart3_fck",
+	.prcm		= {
+		.omap2 = {
+			.prcm_reg_id = 1,
+			.module_bit = OMAP24XX_EN_UART3_SHIFT,
+		},
+	},
+	.slaves		= omap2430_uart3_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap2430_uart3_slaves),
+	.class		= &uart_class,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2430),
+};
+
 static __initdata struct omap_hwmod *omap2430_hwmods[] = {
 	&omap2430_l3_hwmod,
 	&omap2430_l4_core_hwmod,
 	&omap2430_l4_wkup_hwmod,
 	&omap2430_mpu_hwmod,
+	&omap2430_uart1_hwmod,
+	&omap2430_uart2_hwmod,
+	&omap2430_uart3_hwmod,
 	NULL,
 };

-- 
1.6.3.3





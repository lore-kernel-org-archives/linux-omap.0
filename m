From: "Govindraj.R" <govindraj.raja@ti.com>
Subject: [pm-wip/uart][PATCH 2/6] Serial: Add UART4 hwmod data.
Date: Thu, 20 May 2010 19:08:24 +0530 (IST)
Message-ID: <47872.192.168.10.88.1274362704.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:36642 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753220Ab0ETNi0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 20 May 2010 09:38:26 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Kevin Hilman <khilman@deeprootsystems.com>


Introduce UART4 hwmod data for OMAP3630

Cc: Kevin Hilman <khilman@deeprootsystems.com>
Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   54 ++++++++++++++++++++++++++++
 arch/arm/mach-omap2/prcm-common.h          |    2 +
 arch/arm/plat-omap/include/plat/dma.h      |    2 +
 arch/arm/plat-omap/include/plat/irqs.h     |    2 +
 4 files changed, 60 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index 5f74c34..079a65e 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -86,6 +86,7 @@ static struct omap_hwmod omap3xxx_l4_wkup_hwmod;
 static struct omap_hwmod omap3xxx_uart1_hwmod;
 static struct omap_hwmod omap3xxx_uart2_hwmod;
 static struct omap_hwmod omap3xxx_uart3_hwmod;
+static struct omap_hwmod omap3xxx_uart4_hwmod;
 static struct omap_hwmod omap3xxx_mmc1_hwmod;
 static struct omap_hwmod omap3xxx_mmc2_hwmod;
 static struct omap_hwmod omap3xxx_mmc3_hwmod;
@@ -151,6 +152,24 @@ static struct omap_hwmod_ocp_if omap3_l4_per__uart3 = {
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };

+/* L4 PER -> UART4 interface */
+static struct omap_hwmod_addr_space omap3xxx_uart4_addr_space[] = {
+	{
+		.pa_start	= OMAP3_UART4_BASE,
+		.pa_end		= OMAP3_UART4_BASE + SZ_1K - 1,
+		.flags		= ADDR_MAP_ON_INIT | ADDR_TYPE_RT,
+	},
+};
+
+static struct omap_hwmod_ocp_if omap3_l4_per__uart4 = {
+	.master		= &omap3xxx_l4_per_hwmod,
+	.slave		= &omap3xxx_uart4_hwmod,
+	.clk		= "uart4_ick",
+	.addr		= omap3xxx_uart4_addr_space,
+	.addr_cnt	= ARRAY_SIZE(omap3xxx_uart4_addr_space),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
 /* L4 CORE -> MMC1 interface */
 static struct omap_hwmod_addr_space omap3xxx_mmc1_addr_space[] = {
 	{
@@ -257,6 +276,7 @@ static struct omap_hwmod_ocp_if *omap3xxx_l4_per_slaves[] = {
 /* Master interfaces on the L4_PER interconnect */
 static struct omap_hwmod_ocp_if *omap3xxx_l4_per_masters[] = {
 	&omap3_l4_per__uart3,
+	&omap3_l4_per__uart4,
 };

 /* L4 PER */
@@ -425,6 +445,40 @@ static struct omap_hwmod omap3xxx_uart3_hwmod = {
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
 };

+/* UART4 */
+
+static struct omap_hwmod_irq_info uart4_mpu_irqs[] = {
+	{ .irq = INT_36XX_UART4_IRQ, },
+};
+
+static struct omap_hwmod_dma_info uart4_sdma_chs[] = {
+	{ .name = "rx",	.dma_ch = OMAP36XX_DMA_UART4_RX, },
+	{ .name = "tx",	.dma_ch = OMAP36XX_DMA_UART4_TX, },
+};
+
+static struct omap_hwmod_ocp_if *omap3xxx_uart4_slaves[] = {
+	&omap3_l4_per__uart4,
+};
+
+static struct omap_hwmod omap3xxx_uart4_hwmod = {
+	.name		= "uart4",
+	.mpu_irqs	= uart4_mpu_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(uart4_mpu_irqs),
+	.sdma_chs	= uart4_sdma_chs,
+	.sdma_chs_cnt	= ARRAY_SIZE(uart4_sdma_chs),
+	.main_clk	= "uart4_fck",
+	.prcm		= {
+		.omap2 = {
+			.prcm_reg_id = 1,
+			.module_bit = OMAP3630_EN_UART4_SHIFT,
+		},
+	},
+	.slaves		= omap3xxx_uart4_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap3xxx_uart4_slaves),
+	.class		= &uart_class,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3630ES1),
+};
+
 /* MMC/SD/SDIO common */

 static struct omap_hwmod_class_sysconfig mmc_sysc = {
diff --git a/arch/arm/mach-omap2/prcm-common.h b/arch/arm/mach-omap2/prcm-common.h
index 90f603d..0fc20c9 100644
--- a/arch/arm/mach-omap2/prcm-common.h
+++ b/arch/arm/mach-omap2/prcm-common.h
@@ -390,6 +390,8 @@
 #define OMAP3430_EN_MPU_SHIFT				1

 /* CM_FCLKEN_PER, CM_ICLKEN_PER, PM_WKEN_PER shared bits */
+#define OMAP3630_EN_UART4				(1 << 18)
+#define OMAP3630_EN_UART4_SHIFT				18
 #define OMAP3430_EN_GPIO6				(1 << 17)
 #define OMAP3430_EN_GPIO6_SHIFT				17
 #define OMAP3430_EN_GPIO5				(1 << 16)
diff --git a/arch/arm/plat-omap/include/plat/dma.h b/arch/arm/plat-omap/include/plat/dma.h
index 02232ca..105bdb5 100644
--- a/arch/arm/plat-omap/include/plat/dma.h
+++ b/arch/arm/plat-omap/include/plat/dma.h
@@ -319,6 +319,8 @@
 #define OMAP34XX_DMA_USIM_TX		79	/* S_DMA_78 */
 #define OMAP34XX_DMA_USIM_RX		80	/* S_DMA_79 */

+#define OMAP36XX_DMA_UART4_TX		81	/* S_DMA_80 */
+#define OMAP36XX_DMA_UART4_RX		82	/* S_DMA_81 */
 /*----------------------------------------------------------------------------*/

 #define OMAP1_DMA_TOUT_IRQ		(1 << 0)
diff --git a/arch/arm/plat-omap/include/plat/irqs.h b/arch/arm/plat-omap/include/plat/irqs.h
index 4017019..1732cca 100644
--- a/arch/arm/plat-omap/include/plat/irqs.h
+++ b/arch/arm/plat-omap/include/plat/irqs.h
@@ -345,6 +345,8 @@
 #define INT_34XX_MMC3_IRQ	94
 #define INT_34XX_GPT12_IRQ	95

+#define INT_36XX_UART4_IRQ	80
+
 #define INT_35XX_HECC0_IRQ		24
 #define INT_35XX_HECC1_IRQ		28
 #define INT_35XX_EMAC_C0_RXTHRESH_IRQ	67
-- 
1.6.3.3





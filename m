From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 10/14] ARM: OMAP2+: Remove legacy data from hwmod for omap3
Date: Fri, 11 Nov 2016 11:17:07 -0800
Message-ID: <20161111191711.5079-11-tony@atomide.com>
References: <20161111191711.5079-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20161111191711.5079-1-tony@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

This data is now coming from device tree so we can remove the
duplicate data. Let's keep the DSS and DMA related things for now
until those have been converted to device tree completely.

While at it, let's also add the trailing commas to data structures
so further processing with scripts will be a bit easier.

Cc: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 .../omap_hwmod_2xxx_3xxx_interconnect_data.c       | 149 +---
 .../mach-omap2/omap_hwmod_2xxx_3xxx_ipblock_data.c | 201 +-----
 .../mach-omap2/omap_hwmod_2xxx_interconnect_data.c |   4 -
 arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c |   1 -
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         | 787 +--------------------
 arch/arm/mach-omap2/omap_hwmod_common_data.h       |  15 -
 6 files changed, 43 insertions(+), 1114 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_2xxx_3xxx_interconnect_data.c b/arch/arm/mach-omap2/omap_hwmod_2xxx_3xxx_interconnect_data.c
--- a/arch/arm/mach-omap2/omap_hwmod_2xxx_3xxx_interconnect_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2xxx_3xxx_interconnect_data.c
@@ -17,156 +17,11 @@
 
 #include "omap_hwmod_common_data.h"
 
-struct omap_hwmod_addr_space omap2430_mmc1_addr_space[] = {
-	{
-		.pa_start	= 0x4809c000,
-		.pa_end		= 0x4809c1ff,
-		.flags		= ADDR_TYPE_RT,
-	},
-	{ }
-};
-
-struct omap_hwmod_addr_space omap2430_mmc2_addr_space[] = {
-	{
-		.pa_start	= 0x480b4000,
-		.pa_end		= 0x480b41ff,
-		.flags		= ADDR_TYPE_RT,
-	},
-	{ }
-};
-
-struct omap_hwmod_addr_space omap2_i2c1_addr_space[] = {
-	{
-		.pa_start	= 0x48070000,
-		.pa_end		= 0x48070000 + SZ_128 - 1,
-		.flags		= ADDR_TYPE_RT,
-	},
-	{ }
-};
-
-struct omap_hwmod_addr_space omap2_i2c2_addr_space[] = {
-	{
-		.pa_start	= 0x48072000,
-		.pa_end		= 0x48072000 + SZ_128 - 1,
-		.flags		= ADDR_TYPE_RT,
-	},
-	{ }
-};
-
-struct omap_hwmod_addr_space omap2_dss_addrs[] = {
-	{
-		.pa_start	= 0x48050000,
-		.pa_end		= 0x48050000 + SZ_1K - 1,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
-
-struct omap_hwmod_addr_space omap2_dss_dispc_addrs[] = {
-	{
-		.pa_start	= 0x48050400,
-		.pa_end		= 0x48050400 + SZ_1K - 1,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
-
-struct omap_hwmod_addr_space omap2_dss_rfbi_addrs[] = {
-	{
-		.pa_start	= 0x48050800,
-		.pa_end		= 0x48050800 + SZ_1K - 1,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
-
-struct omap_hwmod_addr_space omap2_dss_venc_addrs[] = {
-	{
-		.pa_start	= 0x48050C00,
-		.pa_end		= 0x48050C00 + SZ_1K - 1,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
-
-struct omap_hwmod_addr_space omap2_timer10_addrs[] = {
-	{
-		.pa_start	= 0x48086000,
-		.pa_end		= 0x48086000 + SZ_1K - 1,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
-
-struct omap_hwmod_addr_space omap2_timer11_addrs[] = {
-	{
-		.pa_start	= 0x48088000,
-		.pa_end		= 0x48088000 + SZ_1K - 1,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
-
-struct omap_hwmod_addr_space omap2xxx_timer12_addrs[] = {
-	{
-		.pa_start	= 0x4808a000,
-		.pa_end		= 0x4808a000 + SZ_1K - 1,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
-
-struct omap_hwmod_addr_space omap2_mcspi1_addr_space[] = {
-	{
-		.pa_start	= 0x48098000,
-		.pa_end		= 0x48098000 + SZ_256 - 1,
-		.flags		= ADDR_TYPE_RT,
-	},
-	{ }
-};
-
-struct omap_hwmod_addr_space omap2_mcspi2_addr_space[] = {
-	{
-		.pa_start	= 0x4809a000,
-		.pa_end		= 0x4809a000 + SZ_256 - 1,
-		.flags		= ADDR_TYPE_RT,
-	},
-	{ }
-};
-
-struct omap_hwmod_addr_space omap2430_mcspi3_addr_space[] = {
-	{
-		.pa_start	= 0x480b8000,
-		.pa_end		= 0x480b8000 + SZ_256 - 1,
-		.flags		= ADDR_TYPE_RT,
-	},
-	{ }
-};
-
 struct omap_hwmod_addr_space omap2_dma_system_addrs[] = {
 	{
 		.pa_start	= 0x48056000,
 		.pa_end		= 0x48056000 + SZ_4K - 1,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
-
-struct omap_hwmod_addr_space omap2_mcbsp1_addrs[] = {
-	{
-		.name		= "mpu",
-		.pa_start	= 0x48074000,
-		.pa_end		= 0x480740ff,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
-
-struct omap_hwmod_addr_space omap2_hdq1w_addr_space[] = {
-	{
-		.pa_start       = 0x480b2000,
-		.pa_end         = 0x480b2fff,
-		.flags          = ADDR_TYPE_RT,
+		.flags		= ADDR_TYPE_RT,
 	},
-	{ }
+	{ },
 };
diff --git a/arch/arm/mach-omap2/omap_hwmod_2xxx_3xxx_ipblock_data.c b/arch/arm/mach-omap2/omap_hwmod_2xxx_3xxx_ipblock_data.c
--- a/arch/arm/mach-omap2/omap_hwmod_2xxx_3xxx_ipblock_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2xxx_3xxx_ipblock_data.c
@@ -45,204 +45,31 @@ struct omap_hwmod_class omap2_venc_hwmod_class = {
 	.name = "venc",
 };
 
-
-/* Common DMA request line data */
-struct omap_hwmod_dma_info omap2_uart1_sdma_reqs[] = {
-	{ .name = "rx", .dma_req = 50, },
-	{ .name = "tx", .dma_req = 49, },
-	{ .dma_req = -1 }
-};
-
-struct omap_hwmod_dma_info omap2_uart2_sdma_reqs[] = {
-	{ .name = "rx", .dma_req = 52, },
-	{ .name = "tx", .dma_req = 51, },
-	{ .dma_req = -1 }
-};
-
-struct omap_hwmod_dma_info omap2_uart3_sdma_reqs[] = {
-	{ .name = "rx", .dma_req = 54, },
-	{ .name = "tx", .dma_req = 53, },
-	{ .dma_req = -1 }
-};
-
-struct omap_hwmod_dma_info omap2_i2c1_sdma_reqs[] = {
-	{ .name = "tx", .dma_req = 27 },
-	{ .name = "rx", .dma_req = 28 },
-	{ .dma_req = -1 }
-};
-
-struct omap_hwmod_dma_info omap2_i2c2_sdma_reqs[] = {
-	{ .name = "tx", .dma_req = 29 },
-	{ .name = "rx", .dma_req = 30 },
-	{ .dma_req = -1 }
-};
-
-struct omap_hwmod_dma_info omap2_mcspi1_sdma_reqs[] = {
-	{ .name = "tx0", .dma_req = 35 }, /* DMA_SPI1_TX0 */
-	{ .name = "rx0", .dma_req = 36 }, /* DMA_SPI1_RX0 */
-	{ .name = "tx1", .dma_req = 37 }, /* DMA_SPI1_TX1 */
-	{ .name = "rx1", .dma_req = 38 }, /* DMA_SPI1_RX1 */
-	{ .name = "tx2", .dma_req = 39 }, /* DMA_SPI1_TX2 */
-	{ .name = "rx2", .dma_req = 40 }, /* DMA_SPI1_RX2 */
-	{ .name = "tx3", .dma_req = 41 }, /* DMA_SPI1_TX3 */
-	{ .name = "rx3", .dma_req = 42 }, /* DMA_SPI1_RX3 */
-	{ .dma_req = -1 }
-};
-
-struct omap_hwmod_dma_info omap2_mcspi2_sdma_reqs[] = {
-	{ .name = "tx0", .dma_req = 43 }, /* DMA_SPI2_TX0 */
-	{ .name = "rx0", .dma_req = 44 }, /* DMA_SPI2_RX0 */
-	{ .name = "tx1", .dma_req = 45 }, /* DMA_SPI2_TX1 */
-	{ .name = "rx1", .dma_req = 46 }, /* DMA_SPI2_RX1 */
-	{ .dma_req = -1 }
-};
-
-struct omap_hwmod_dma_info omap2_mcbsp1_sdma_reqs[] = {
-	{ .name = "rx", .dma_req = 32 },
-	{ .name = "tx", .dma_req = 31 },
-	{ .dma_req = -1 }
-};
-
-struct omap_hwmod_dma_info omap2_mcbsp2_sdma_reqs[] = {
-	{ .name = "rx", .dma_req = 34 },
-	{ .name = "tx", .dma_req = 33 },
-	{ .dma_req = -1 }
-};
-
-struct omap_hwmod_dma_info omap2_mcbsp3_sdma_reqs[] = {
-	{ .name = "rx", .dma_req = 18 },
-	{ .name = "tx", .dma_req = 17 },
-	{ .dma_req = -1 }
-};
-
-/* Other IP block data */
-
-
 /*
  * omap_hwmod class data
  */
 
 struct omap_hwmod_class l3_hwmod_class = {
-	.name = "l3"
+	.name = "l3",
 };
 
 struct omap_hwmod_class l4_hwmod_class = {
-	.name = "l4"
+	.name = "l4",
 };
 
 struct omap_hwmod_class mpu_hwmod_class = {
-	.name = "mpu"
+	.name = "mpu",
 };
 
 struct omap_hwmod_class iva_hwmod_class = {
-	.name = "iva"
+	.name = "iva",
 };
 
 /* Common MPU IRQ line data */
 
-struct omap_hwmod_irq_info omap2_timer1_mpu_irqs[] = {
-	{ .irq = 37 + OMAP_INTC_START, },
-	{ .irq = -1 },
-};
-
-struct omap_hwmod_irq_info omap2_timer2_mpu_irqs[] = {
-	{ .irq = 38 + OMAP_INTC_START, },
-	{ .irq = -1 },
-};
-
-struct omap_hwmod_irq_info omap2_timer3_mpu_irqs[] = {
-	{ .irq = 39 + OMAP_INTC_START, },
-	{ .irq = -1 },
-};
-
-struct omap_hwmod_irq_info omap2_timer4_mpu_irqs[] = {
-	{ .irq = 40 + OMAP_INTC_START, },
-	{ .irq = -1 },
-};
-
-struct omap_hwmod_irq_info omap2_timer5_mpu_irqs[] = {
-	{ .irq = 41 + OMAP_INTC_START, },
-	{ .irq = -1 },
-};
-
-struct omap_hwmod_irq_info omap2_timer6_mpu_irqs[] = {
-	{ .irq = 42 + OMAP_INTC_START, },
-	{ .irq = -1 },
-};
-
-struct omap_hwmod_irq_info omap2_timer7_mpu_irqs[] = {
-	{ .irq = 43 + OMAP_INTC_START, },
-	{ .irq = -1 },
-};
-
-struct omap_hwmod_irq_info omap2_timer8_mpu_irqs[] = {
-	{ .irq = 44 + OMAP_INTC_START, },
-	{ .irq = -1 },
-};
-
-struct omap_hwmod_irq_info omap2_timer9_mpu_irqs[] = {
-	{ .irq = 45 + OMAP_INTC_START, },
-	{ .irq = -1 },
-};
-
-struct omap_hwmod_irq_info omap2_timer10_mpu_irqs[] = {
-	{ .irq = 46 + OMAP_INTC_START, },
-	{ .irq = -1 },
-};
-
-struct omap_hwmod_irq_info omap2_timer11_mpu_irqs[] = {
-	{ .irq = 47 + OMAP_INTC_START, },
-	{ .irq = -1 },
-};
-
-struct omap_hwmod_irq_info omap2_uart1_mpu_irqs[] = {
-	{ .irq = 72 + OMAP_INTC_START, },
-	{ .irq = -1 },
-};
-
-struct omap_hwmod_irq_info omap2_uart2_mpu_irqs[] = {
-	{ .irq = 73 + OMAP_INTC_START, },
-	{ .irq = -1 },
-};
-
-struct omap_hwmod_irq_info omap2_uart3_mpu_irqs[] = {
-	{ .irq = 74 + OMAP_INTC_START, },
-	{ .irq = -1 },
-};
-
 struct omap_hwmod_irq_info omap2_dispc_irqs[] = {
 	{ .irq = 25 + OMAP_INTC_START, },
-	{ .irq = -1 },
-};
-
-struct omap_hwmod_irq_info omap2_i2c1_mpu_irqs[] = {
-	{ .irq = 56 + OMAP_INTC_START, },
-	{ .irq = -1 },
-};
-
-struct omap_hwmod_irq_info omap2_i2c2_mpu_irqs[] = {
-	{ .irq = 57 + OMAP_INTC_START, },
-	{ .irq = -1 },
-};
-
-struct omap_hwmod_irq_info omap2_gpio1_irqs[] = {
-	{ .irq = 29 + OMAP_INTC_START, }, /* INT_24XX_GPIO_BANK1 */
-	{ .irq = -1 },
-};
-
-struct omap_hwmod_irq_info omap2_gpio2_irqs[] = {
-	{ .irq = 30 + OMAP_INTC_START, }, /* INT_24XX_GPIO_BANK2 */
-	{ .irq = -1 },
-};
-
-struct omap_hwmod_irq_info omap2_gpio3_irqs[] = {
-	{ .irq = 31 + OMAP_INTC_START, }, /* INT_24XX_GPIO_BANK3 */
-	{ .irq = -1 },
-};
-
-struct omap_hwmod_irq_info omap2_gpio4_irqs[] = {
-	{ .irq = 32 + OMAP_INTC_START, }, /* INT_24XX_GPIO_BANK4 */
-	{ .irq = -1 },
+	{ .irq = -1, },
 };
 
 struct omap_hwmod_irq_info omap2_dma_system_irqs[] = {
@@ -250,17 +77,7 @@ struct omap_hwmod_irq_info omap2_dma_system_irqs[] = {
 	{ .name = "1", .irq = 13 + OMAP_INTC_START, }, /* INT_24XX_SDMA_IRQ1 */
 	{ .name = "2", .irq = 14 + OMAP_INTC_START, }, /* INT_24XX_SDMA_IRQ2 */
 	{ .name = "3", .irq = 15 + OMAP_INTC_START, }, /* INT_24XX_SDMA_IRQ3 */
-	{ .irq = -1 },
-};
-
-struct omap_hwmod_irq_info omap2_mcspi1_mpu_irqs[] = {
-	{ .irq = 65 + OMAP_INTC_START, },
-	{ .irq = -1 },
-};
-
-struct omap_hwmod_irq_info omap2_mcspi2_mpu_irqs[] = {
-	{ .irq = 66 + OMAP_INTC_START, },
-	{ .irq = -1 },
+	{ .irq = -1, },
 };
 
 struct omap_hwmod_class_sysconfig omap2_hdq1w_sysc = {
@@ -277,9 +94,3 @@ struct omap_hwmod_class omap2_hdq1w_class = {
 	.sysc	= &omap2_hdq1w_sysc,
 	.reset	= &omap_hdq1w_reset,
 };
-
-struct omap_hwmod_irq_info omap2_hdq1w_mpu_irqs[] = {
-	{ .irq = 58 + OMAP_INTC_START, },
-	{ .irq = -1 },
-};
-
diff --git a/arch/arm/mach-omap2/omap_hwmod_2xxx_interconnect_data.c b/arch/arm/mach-omap2/omap_hwmod_2xxx_interconnect_data.c
--- a/arch/arm/mach-omap2/omap_hwmod_2xxx_interconnect_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2xxx_interconnect_data.c
@@ -191,7 +191,6 @@ struct omap_hwmod_ocp_if omap2xxx_l4_core__dss = {
 	.master		= &omap2xxx_l4_core_hwmod,
 	.slave		= &omap2xxx_dss_core_hwmod,
 	.clk		= "dss_ick",
-	.addr		= omap2_dss_addrs,
 	.fw = {
 		.omap2 = {
 			.l4_fw_region  = OMAP2420_L4_CORE_FW_DSS_CORE_REGION,
@@ -206,7 +205,6 @@ struct omap_hwmod_ocp_if omap2xxx_l4_core__dss_dispc = {
 	.master		= &omap2xxx_l4_core_hwmod,
 	.slave		= &omap2xxx_dss_dispc_hwmod,
 	.clk		= "dss_ick",
-	.addr		= omap2_dss_dispc_addrs,
 	.fw = {
 		.omap2 = {
 			.l4_fw_region  = OMAP2420_L4_CORE_FW_DSS_DISPC_REGION,
@@ -221,7 +219,6 @@ struct omap_hwmod_ocp_if omap2xxx_l4_core__dss_rfbi = {
 	.master		= &omap2xxx_l4_core_hwmod,
 	.slave		= &omap2xxx_dss_rfbi_hwmod,
 	.clk		= "dss_ick",
-	.addr		= omap2_dss_rfbi_addrs,
 	.fw = {
 		.omap2 = {
 			.l4_fw_region  = OMAP2420_L4_CORE_FW_DSS_CORE_REGION,
@@ -236,7 +233,6 @@ struct omap_hwmod_ocp_if omap2xxx_l4_core__dss_venc = {
 	.master		= &omap2xxx_l4_core_hwmod,
 	.slave		= &omap2xxx_dss_venc_hwmod,
 	.clk		= "dss_ick",
-	.addr		= omap2_dss_venc_addrs,
 	.fw = {
 		.omap2 = {
 			.l4_fw_region  = OMAP2420_L4_CORE_FW_DSS_VENC_REGION,
diff --git a/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c b/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c
--- a/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c
@@ -569,7 +569,6 @@ struct omap_hwmod omap2xxx_dss_core_hwmod = {
 struct omap_hwmod omap2xxx_dss_dispc_hwmod = {
 	.name		= "dss_dispc",
 	.class		= &omap2_dispc_hwmod_class,
-	.mpu_irqs	= omap2_dispc_irqs,
 	.main_clk	= "dss1_fck",
 	.prcm		= {
 		.omap2 = {
diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -53,16 +53,10 @@
  */
 
 /* L3 */
-static struct omap_hwmod_irq_info omap3xxx_l3_main_irqs[] = {
-	{ .irq = 9 + OMAP_INTC_START, },
-	{ .irq = 10 + OMAP_INTC_START, },
-	{ .irq = -1 },
-};
 
 static struct omap_hwmod omap3xxx_l3_main_hwmod = {
 	.name		= "l3_main",
 	.class		= &l3_hwmod_class,
-	.mpu_irqs	= omap3xxx_l3_main_irqs,
 	.flags		= HWMOD_NO_IDLEST,
 };
 
@@ -95,14 +89,9 @@ static struct omap_hwmod omap3xxx_l4_sec_hwmod = {
 };
 
 /* MPU */
-static struct omap_hwmod_irq_info omap3xxx_mpu_irqs[] = {
-	{ .name = "pmu", .irq = 3 + OMAP_INTC_START },
-	{ .irq = -1 }
-};
 
 static struct omap_hwmod omap3xxx_mpu_hwmod = {
 	.name		= "mpu",
-	.mpu_irqs	= omap3xxx_mpu_irqs,
 	.class		= &mpu_hwmod_class,
 	.main_clk	= "arm_fck",
 };
@@ -128,7 +117,7 @@ static struct omap_hwmod omap3xxx_iva_hwmod = {
 			.module_bit = OMAP3430_CM_FCLKEN_IVA2_EN_IVA2_SHIFT,
 			.idlest_reg_id = 1,
 			.idlest_idle_bit = OMAP3430_ST_IVA2_SHIFT,
-		}
+		},
 	},
 };
 
@@ -197,7 +186,6 @@ static struct omap_timer_capability_dev_attr capability_dsp_pwm_dev_attr = {
 /* timer1 */
 static struct omap_hwmod omap3xxx_timer1_hwmod = {
 	.name		= "timer1",
-	.mpu_irqs	= omap2_timer1_mpu_irqs,
 	.main_clk	= "gpt1_fck",
 	.prcm		= {
 		.omap2 = {
@@ -216,7 +204,6 @@ static struct omap_hwmod omap3xxx_timer1_hwmod = {
 /* timer2 */
 static struct omap_hwmod omap3xxx_timer2_hwmod = {
 	.name		= "timer2",
-	.mpu_irqs	= omap2_timer2_mpu_irqs,
 	.main_clk	= "gpt2_fck",
 	.prcm		= {
 		.omap2 = {
@@ -234,7 +221,6 @@ static struct omap_hwmod omap3xxx_timer2_hwmod = {
 /* timer3 */
 static struct omap_hwmod omap3xxx_timer3_hwmod = {
 	.name		= "timer3",
-	.mpu_irqs	= omap2_timer3_mpu_irqs,
 	.main_clk	= "gpt3_fck",
 	.prcm		= {
 		.omap2 = {
@@ -252,7 +238,6 @@ static struct omap_hwmod omap3xxx_timer3_hwmod = {
 /* timer4 */
 static struct omap_hwmod omap3xxx_timer4_hwmod = {
 	.name		= "timer4",
-	.mpu_irqs	= omap2_timer4_mpu_irqs,
 	.main_clk	= "gpt4_fck",
 	.prcm		= {
 		.omap2 = {
@@ -270,7 +255,6 @@ static struct omap_hwmod omap3xxx_timer4_hwmod = {
 /* timer5 */
 static struct omap_hwmod omap3xxx_timer5_hwmod = {
 	.name		= "timer5",
-	.mpu_irqs	= omap2_timer5_mpu_irqs,
 	.main_clk	= "gpt5_fck",
 	.prcm		= {
 		.omap2 = {
@@ -289,7 +273,6 @@ static struct omap_hwmod omap3xxx_timer5_hwmod = {
 /* timer6 */
 static struct omap_hwmod omap3xxx_timer6_hwmod = {
 	.name		= "timer6",
-	.mpu_irqs	= omap2_timer6_mpu_irqs,
 	.main_clk	= "gpt6_fck",
 	.prcm		= {
 		.omap2 = {
@@ -308,7 +291,6 @@ static struct omap_hwmod omap3xxx_timer6_hwmod = {
 /* timer7 */
 static struct omap_hwmod omap3xxx_timer7_hwmod = {
 	.name		= "timer7",
-	.mpu_irqs	= omap2_timer7_mpu_irqs,
 	.main_clk	= "gpt7_fck",
 	.prcm		= {
 		.omap2 = {
@@ -327,7 +309,6 @@ static struct omap_hwmod omap3xxx_timer7_hwmod = {
 /* timer8 */
 static struct omap_hwmod omap3xxx_timer8_hwmod = {
 	.name		= "timer8",
-	.mpu_irqs	= omap2_timer8_mpu_irqs,
 	.main_clk	= "gpt8_fck",
 	.prcm		= {
 		.omap2 = {
@@ -346,7 +327,6 @@ static struct omap_hwmod omap3xxx_timer8_hwmod = {
 /* timer9 */
 static struct omap_hwmod omap3xxx_timer9_hwmod = {
 	.name		= "timer9",
-	.mpu_irqs	= omap2_timer9_mpu_irqs,
 	.main_clk	= "gpt9_fck",
 	.prcm		= {
 		.omap2 = {
@@ -365,7 +345,6 @@ static struct omap_hwmod omap3xxx_timer9_hwmod = {
 /* timer10 */
 static struct omap_hwmod omap3xxx_timer10_hwmod = {
 	.name		= "timer10",
-	.mpu_irqs	= omap2_timer10_mpu_irqs,
 	.main_clk	= "gpt10_fck",
 	.prcm		= {
 		.omap2 = {
@@ -384,7 +363,6 @@ static struct omap_hwmod omap3xxx_timer10_hwmod = {
 /* timer11 */
 static struct omap_hwmod omap3xxx_timer11_hwmod = {
 	.name		= "timer11",
-	.mpu_irqs	= omap2_timer11_mpu_irqs,
 	.main_clk	= "gpt11_fck",
 	.prcm		= {
 		.omap2 = {
@@ -401,14 +379,9 @@ static struct omap_hwmod omap3xxx_timer11_hwmod = {
 };
 
 /* timer12 */
-static struct omap_hwmod_irq_info omap3xxx_timer12_mpu_irqs[] = {
-	{ .irq = 95 + OMAP_INTC_START, },
-	{ .irq = -1 },
-};
 
 static struct omap_hwmod omap3xxx_timer12_hwmod = {
 	.name		= "timer12",
-	.mpu_irqs	= omap3xxx_timer12_mpu_irqs,
 	.main_clk	= "gpt12_fck",
 	.prcm		= {
 		.omap2 = {
@@ -485,8 +458,6 @@ static struct omap_hwmod omap3xxx_wd_timer2_hwmod = {
 /* UART1 */
 static struct omap_hwmod omap3xxx_uart1_hwmod = {
 	.name		= "uart1",
-	.mpu_irqs	= omap2_uart1_mpu_irqs,
-	.sdma_reqs	= omap2_uart1_sdma_reqs,
 	.main_clk	= "uart1_fck",
 	.flags		= DEBUG_TI81XXUART1_FLAGS | HWMOD_SWSUP_SIDLE,
 	.prcm		= {
@@ -504,8 +475,6 @@ static struct omap_hwmod omap3xxx_uart1_hwmod = {
 /* UART2 */
 static struct omap_hwmod omap3xxx_uart2_hwmod = {
 	.name		= "uart2",
-	.mpu_irqs	= omap2_uart2_mpu_irqs,
-	.sdma_reqs	= omap2_uart2_sdma_reqs,
 	.main_clk	= "uart2_fck",
 	.flags		= DEBUG_TI81XXUART2_FLAGS | HWMOD_SWSUP_SIDLE,
 	.prcm		= {
@@ -523,8 +492,6 @@ static struct omap_hwmod omap3xxx_uart2_hwmod = {
 /* UART3 */
 static struct omap_hwmod omap3xxx_uart3_hwmod = {
 	.name		= "uart3",
-	.mpu_irqs	= omap2_uart3_mpu_irqs,
-	.sdma_reqs	= omap2_uart3_sdma_reqs,
 	.main_clk	= "uart3_fck",
 	.flags		= DEBUG_OMAP3UART3_FLAGS | DEBUG_TI81XXUART3_FLAGS |
 				HWMOD_SWSUP_SIDLE,
@@ -541,21 +508,10 @@ static struct omap_hwmod omap3xxx_uart3_hwmod = {
 };
 
 /* UART4 */
-static struct omap_hwmod_irq_info uart4_mpu_irqs[] = {
-	{ .irq = 80 + OMAP_INTC_START, },
-	{ .irq = -1 },
-};
 
-static struct omap_hwmod_dma_info uart4_sdma_reqs[] = {
-	{ .name = "rx",	.dma_req = 82, },
-	{ .name = "tx",	.dma_req = 81, },
-	{ .dma_req = -1 }
-};
 
 static struct omap_hwmod omap36xx_uart4_hwmod = {
 	.name		= "uart4",
-	.mpu_irqs	= uart4_mpu_irqs,
-	.sdma_reqs	= uart4_sdma_reqs,
 	.main_clk	= "uart4_fck",
 	.flags		= DEBUG_OMAP3UART4_FLAGS | HWMOD_SWSUP_SIDLE,
 	.prcm		= {
@@ -570,16 +526,7 @@ static struct omap_hwmod omap36xx_uart4_hwmod = {
 	.class		= &omap2_uart_class,
 };
 
-static struct omap_hwmod_irq_info am35xx_uart4_mpu_irqs[] = {
-	{ .irq = 84 + OMAP_INTC_START, },
-	{ .irq = -1 },
-};
 
-static struct omap_hwmod_dma_info am35xx_uart4_sdma_reqs[] = {
-	{ .name = "rx", .dma_req = 55, },
-	{ .name = "tx", .dma_req = 54, },
-	{ .dma_req = -1 }
-};
 
 /*
  * XXX AM35xx UART4 cannot complete its softreset without uart1_fck or
@@ -597,8 +544,6 @@ static struct omap_hwmod_opt_clk am35xx_uart4_opt_clks[] = {
 
 static struct omap_hwmod am35xx_uart4_hwmod = {
 	.name		= "uart4",
-	.mpu_irqs	= am35xx_uart4_mpu_irqs,
-	.sdma_reqs	= am35xx_uart4_sdma_reqs,
 	.main_clk	= "uart4_fck",
 	.prcm		= {
 		.omap2 = {
@@ -625,7 +570,7 @@ static struct omap_hwmod_class i2c_class = {
 static struct omap_hwmod_dma_info omap3xxx_dss_sdma_chs[] = {
 	{ .name = "dispc", .dma_req = 5 },
 	{ .name = "dsi1", .dma_req = 74 },
-	{ .dma_req = -1 }
+	{ .dma_req = -1, },
 };
 
 /* dss */
@@ -714,7 +659,7 @@ static struct omap_hwmod omap3xxx_dss_dispc_hwmod = {
 		},
 	},
 	.flags		= HWMOD_NO_IDLEST,
-	.dev_attr	= &omap2_3_dss_dispc_dev_attr
+	.dev_attr	= &omap2_3_dss_dispc_dev_attr,
 };
 
 /*
@@ -738,11 +683,6 @@ static struct omap_hwmod_class omap3xxx_dsi_hwmod_class = {
 	.sysc	= &omap3xxx_dsi_sysc,
 };
 
-static struct omap_hwmod_irq_info omap3xxx_dsi1_irqs[] = {
-	{ .irq = 25 + OMAP_INTC_START, },
-	{ .irq = -1 },
-};
-
 /* dss_dsi1 */
 static struct omap_hwmod_opt_clk dss_dsi1_opt_clks[] = {
 	{ .role = "sys_clk", .clk = "dss2_alwon_fck" },
@@ -751,7 +691,6 @@ static struct omap_hwmod_opt_clk dss_dsi1_opt_clks[] = {
 static struct omap_hwmod omap3xxx_dss_dsi1_hwmod = {
 	.name		= "dss_dsi1",
 	.class		= &omap3xxx_dsi_hwmod_class,
-	.mpu_irqs	= omap3xxx_dsi1_irqs,
 	.main_clk	= "dss1_alwon_fck",
 	.prcm		= {
 		.omap2 = {
@@ -815,8 +754,6 @@ static struct omap_i2c_dev_attr i2c1_dev_attr = {
 static struct omap_hwmod omap3xxx_i2c1_hwmod = {
 	.name		= "i2c1",
 	.flags		= HWMOD_16BIT_REG | HWMOD_SET_DEFAULT_CLOCKACT,
-	.mpu_irqs	= omap2_i2c1_mpu_irqs,
-	.sdma_reqs	= omap2_i2c1_sdma_reqs,
 	.main_clk	= "i2c1_fck",
 	.prcm		= {
 		.omap2 = {
@@ -840,8 +777,6 @@ static struct omap_i2c_dev_attr i2c2_dev_attr = {
 static struct omap_hwmod omap3xxx_i2c2_hwmod = {
 	.name		= "i2c2",
 	.flags		= HWMOD_16BIT_REG | HWMOD_SET_DEFAULT_CLOCKACT,
-	.mpu_irqs	= omap2_i2c2_mpu_irqs,
-	.sdma_reqs	= omap2_i2c2_sdma_reqs,
 	.main_clk	= "i2c2_fck",
 	.prcm		= {
 		.omap2 = {
@@ -862,22 +797,11 @@ static struct omap_i2c_dev_attr i2c3_dev_attr = {
 	.flags = OMAP_I2C_FLAG_BUS_SHIFT_2,
 };
 
-static struct omap_hwmod_irq_info i2c3_mpu_irqs[] = {
-	{ .irq = 61 + OMAP_INTC_START, },
-	{ .irq = -1 },
-};
 
-static struct omap_hwmod_dma_info i2c3_sdma_reqs[] = {
-	{ .name = "tx", .dma_req = 25 },
-	{ .name = "rx", .dma_req = 26 },
-	{ .dma_req = -1 }
-};
 
 static struct omap_hwmod omap3xxx_i2c3_hwmod = {
 	.name		= "i2c3",
 	.flags		= HWMOD_16BIT_REG | HWMOD_SET_DEFAULT_CLOCKACT,
-	.mpu_irqs	= i2c3_mpu_irqs,
-	.sdma_reqs	= i2c3_sdma_reqs,
 	.main_clk	= "i2c3_fck",
 	.prcm		= {
 		.omap2 = {
@@ -928,7 +852,6 @@ static struct omap_hwmod_opt_clk gpio1_opt_clks[] = {
 static struct omap_hwmod omap3xxx_gpio1_hwmod = {
 	.name		= "gpio1",
 	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
-	.mpu_irqs	= omap2_gpio1_irqs,
 	.main_clk	= "gpio1_ick",
 	.opt_clks	= gpio1_opt_clks,
 	.opt_clks_cnt	= ARRAY_SIZE(gpio1_opt_clks),
@@ -953,7 +876,6 @@ static struct omap_hwmod_opt_clk gpio2_opt_clks[] = {
 static struct omap_hwmod omap3xxx_gpio2_hwmod = {
 	.name		= "gpio2",
 	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
-	.mpu_irqs	= omap2_gpio2_irqs,
 	.main_clk	= "gpio2_ick",
 	.opt_clks	= gpio2_opt_clks,
 	.opt_clks_cnt	= ARRAY_SIZE(gpio2_opt_clks),
@@ -978,7 +900,6 @@ static struct omap_hwmod_opt_clk gpio3_opt_clks[] = {
 static struct omap_hwmod omap3xxx_gpio3_hwmod = {
 	.name		= "gpio3",
 	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
-	.mpu_irqs	= omap2_gpio3_irqs,
 	.main_clk	= "gpio3_ick",
 	.opt_clks	= gpio3_opt_clks,
 	.opt_clks_cnt	= ARRAY_SIZE(gpio3_opt_clks),
@@ -1003,7 +924,6 @@ static struct omap_hwmod_opt_clk gpio4_opt_clks[] = {
 static struct omap_hwmod omap3xxx_gpio4_hwmod = {
 	.name		= "gpio4",
 	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
-	.mpu_irqs	= omap2_gpio4_irqs,
 	.main_clk	= "gpio4_ick",
 	.opt_clks	= gpio4_opt_clks,
 	.opt_clks_cnt	= ARRAY_SIZE(gpio4_opt_clks),
@@ -1021,10 +941,6 @@ static struct omap_hwmod omap3xxx_gpio4_hwmod = {
 };
 
 /* gpio5 */
-static struct omap_hwmod_irq_info omap3xxx_gpio5_irqs[] = {
-	{ .irq = 33 + OMAP_INTC_START, }, /* INT_34XX_GPIO_BANK5 */
-	{ .irq = -1 },
-};
 
 static struct omap_hwmod_opt_clk gpio5_opt_clks[] = {
 	{ .role = "dbclk", .clk = "gpio5_dbck", },
@@ -1033,7 +949,6 @@ static struct omap_hwmod_opt_clk gpio5_opt_clks[] = {
 static struct omap_hwmod omap3xxx_gpio5_hwmod = {
 	.name		= "gpio5",
 	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
-	.mpu_irqs	= omap3xxx_gpio5_irqs,
 	.main_clk	= "gpio5_ick",
 	.opt_clks	= gpio5_opt_clks,
 	.opt_clks_cnt	= ARRAY_SIZE(gpio5_opt_clks),
@@ -1051,10 +966,6 @@ static struct omap_hwmod omap3xxx_gpio5_hwmod = {
 };
 
 /* gpio6 */
-static struct omap_hwmod_irq_info omap3xxx_gpio6_irqs[] = {
-	{ .irq = 34 + OMAP_INTC_START, }, /* INT_34XX_GPIO_BANK6 */
-	{ .irq = -1 },
-};
 
 static struct omap_hwmod_opt_clk gpio6_opt_clks[] = {
 	{ .role = "dbclk", .clk = "gpio6_dbck", },
@@ -1063,7 +974,6 @@ static struct omap_hwmod_opt_clk gpio6_opt_clks[] = {
 static struct omap_hwmod omap3xxx_gpio6_hwmod = {
 	.name		= "gpio6",
 	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
-	.mpu_irqs	= omap3xxx_gpio6_irqs,
 	.main_clk	= "gpio6_ick",
 	.opt_clks	= gpio6_opt_clks,
 	.opt_clks_cnt	= ARRAY_SIZE(gpio6_opt_clks),
@@ -1156,18 +1066,10 @@ static struct omap_hwmod_opt_clk mcbsp234_opt_clks[] = {
 };
 
 /* mcbsp1 */
-static struct omap_hwmod_irq_info omap3xxx_mcbsp1_irqs[] = {
-	{ .name = "common", .irq = 16 + OMAP_INTC_START, },
-	{ .name = "tx", .irq = 59 + OMAP_INTC_START, },
-	{ .name = "rx", .irq = 60 + OMAP_INTC_START, },
-	{ .irq = -1 },
-};
 
 static struct omap_hwmod omap3xxx_mcbsp1_hwmod = {
 	.name		= "mcbsp1",
 	.class		= &omap3xxx_mcbsp_hwmod_class,
-	.mpu_irqs	= omap3xxx_mcbsp1_irqs,
-	.sdma_reqs	= omap2_mcbsp1_sdma_reqs,
 	.main_clk	= "mcbsp1_fck",
 	.prcm		= {
 		.omap2 = {
@@ -1183,12 +1085,6 @@ static struct omap_hwmod omap3xxx_mcbsp1_hwmod = {
 };
 
 /* mcbsp2 */
-static struct omap_hwmod_irq_info omap3xxx_mcbsp2_irqs[] = {
-	{ .name = "common", .irq = 17 + OMAP_INTC_START, },
-	{ .name = "tx", .irq = 62 + OMAP_INTC_START, },
-	{ .name = "rx", .irq = 63 + OMAP_INTC_START, },
-	{ .irq = -1 },
-};
 
 static struct omap_mcbsp_dev_attr omap34xx_mcbsp2_dev_attr = {
 	.sidetone	= "mcbsp2_sidetone",
@@ -1197,8 +1093,6 @@ static struct omap_mcbsp_dev_attr omap34xx_mcbsp2_dev_attr = {
 static struct omap_hwmod omap3xxx_mcbsp2_hwmod = {
 	.name		= "mcbsp2",
 	.class		= &omap3xxx_mcbsp_hwmod_class,
-	.mpu_irqs	= omap3xxx_mcbsp2_irqs,
-	.sdma_reqs	= omap2_mcbsp2_sdma_reqs,
 	.main_clk	= "mcbsp2_fck",
 	.prcm		= {
 		.omap2 = {
@@ -1215,12 +1109,6 @@ static struct omap_hwmod omap3xxx_mcbsp2_hwmod = {
 };
 
 /* mcbsp3 */
-static struct omap_hwmod_irq_info omap3xxx_mcbsp3_irqs[] = {
-	{ .name = "common", .irq = 22 + OMAP_INTC_START, },
-	{ .name = "tx", .irq = 89 + OMAP_INTC_START, },
-	{ .name = "rx", .irq = 90 + OMAP_INTC_START, },
-	{ .irq = -1 },
-};
 
 static struct omap_mcbsp_dev_attr omap34xx_mcbsp3_dev_attr = {
 	.sidetone	= "mcbsp3_sidetone",
@@ -1229,8 +1117,6 @@ static struct omap_mcbsp_dev_attr omap34xx_mcbsp3_dev_attr = {
 static struct omap_hwmod omap3xxx_mcbsp3_hwmod = {
 	.name		= "mcbsp3",
 	.class		= &omap3xxx_mcbsp_hwmod_class,
-	.mpu_irqs	= omap3xxx_mcbsp3_irqs,
-	.sdma_reqs	= omap2_mcbsp3_sdma_reqs,
 	.main_clk	= "mcbsp3_fck",
 	.prcm		= {
 		.omap2 = {
@@ -1247,24 +1133,11 @@ static struct omap_hwmod omap3xxx_mcbsp3_hwmod = {
 };
 
 /* mcbsp4 */
-static struct omap_hwmod_irq_info omap3xxx_mcbsp4_irqs[] = {
-	{ .name = "common", .irq = 23 + OMAP_INTC_START, },
-	{ .name = "tx", .irq = 54 + OMAP_INTC_START, },
-	{ .name = "rx", .irq = 55 + OMAP_INTC_START, },
-	{ .irq = -1 },
-};
 
-static struct omap_hwmod_dma_info omap3xxx_mcbsp4_sdma_chs[] = {
-	{ .name = "rx", .dma_req = 20 },
-	{ .name = "tx", .dma_req = 19 },
-	{ .dma_req = -1 }
-};
 
 static struct omap_hwmod omap3xxx_mcbsp4_hwmod = {
 	.name		= "mcbsp4",
 	.class		= &omap3xxx_mcbsp_hwmod_class,
-	.mpu_irqs	= omap3xxx_mcbsp4_irqs,
-	.sdma_reqs	= omap3xxx_mcbsp4_sdma_chs,
 	.main_clk	= "mcbsp4_fck",
 	.prcm		= {
 		.omap2 = {
@@ -1280,24 +1153,11 @@ static struct omap_hwmod omap3xxx_mcbsp4_hwmod = {
 };
 
 /* mcbsp5 */
-static struct omap_hwmod_irq_info omap3xxx_mcbsp5_irqs[] = {
-	{ .name = "common", .irq = 27 + OMAP_INTC_START, },
-	{ .name = "tx", .irq = 81 + OMAP_INTC_START, },
-	{ .name = "rx", .irq = 82 + OMAP_INTC_START, },
-	{ .irq = -1 },
-};
 
-static struct omap_hwmod_dma_info omap3xxx_mcbsp5_sdma_chs[] = {
-	{ .name = "rx", .dma_req = 22 },
-	{ .name = "tx", .dma_req = 21 },
-	{ .dma_req = -1 }
-};
 
 static struct omap_hwmod omap3xxx_mcbsp5_hwmod = {
 	.name		= "mcbsp5",
 	.class		= &omap3xxx_mcbsp_hwmod_class,
-	.mpu_irqs	= omap3xxx_mcbsp5_irqs,
-	.sdma_reqs	= omap3xxx_mcbsp5_sdma_chs,
 	.main_clk	= "mcbsp5_fck",
 	.prcm		= {
 		.omap2 = {
@@ -1325,29 +1185,19 @@ static struct omap_hwmod_class omap3xxx_mcbsp_sidetone_hwmod_class = {
 };
 
 /* mcbsp2_sidetone */
-static struct omap_hwmod_irq_info omap3xxx_mcbsp2_sidetone_irqs[] = {
-	{ .name = "irq", .irq = 4 + OMAP_INTC_START, },
-	{ .irq = -1 },
-};
 
 static struct omap_hwmod omap3xxx_mcbsp2_sidetone_hwmod = {
 	.name		= "mcbsp2_sidetone",
 	.class		= &omap3xxx_mcbsp_sidetone_hwmod_class,
-	.mpu_irqs	= omap3xxx_mcbsp2_sidetone_irqs,
 	.main_clk	= "mcbsp2_ick",
 	.flags		= HWMOD_NO_IDLEST,
 };
 
 /* mcbsp3_sidetone */
-static struct omap_hwmod_irq_info omap3xxx_mcbsp3_sidetone_irqs[] = {
-	{ .name = "irq", .irq = 5 + OMAP_INTC_START, },
-	{ .irq = -1 },
-};
 
 static struct omap_hwmod omap3xxx_mcbsp3_sidetone_hwmod = {
 	.name		= "mcbsp3_sidetone",
 	.class		= &omap3xxx_mcbsp_sidetone_hwmod_class,
-	.mpu_irqs	= omap3xxx_mcbsp3_sidetone_irqs,
 	.main_clk	= "mcbsp3_ick",
 	.flags		= HWMOD_NO_IDLEST,
 };
@@ -1394,10 +1244,6 @@ static struct omap_smartreflex_dev_attr sr1_dev_attr = {
 	.sensor_voltdm_name   = "mpu_iva",
 };
 
-static struct omap_hwmod_irq_info omap3_smartreflex_mpu_irqs[] = {
-	{ .irq = 18 + OMAP_INTC_START, },
-	{ .irq = -1 },
-};
 
 static struct omap_hwmod omap34xx_sr1_hwmod = {
 	.name		= "smartreflex_mpu_iva",
@@ -1413,7 +1259,6 @@ static struct omap_hwmod omap34xx_sr1_hwmod = {
 		},
 	},
 	.dev_attr	= &sr1_dev_attr,
-	.mpu_irqs	= omap3_smartreflex_mpu_irqs,
 	.flags		= HWMOD_SET_DEFAULT_CLOCKACT,
 };
 
@@ -1431,7 +1276,6 @@ static struct omap_hwmod omap36xx_sr1_hwmod = {
 		},
 	},
 	.dev_attr	= &sr1_dev_attr,
-	.mpu_irqs	= omap3_smartreflex_mpu_irqs,
 };
 
 /* SR2 */
@@ -1439,10 +1283,6 @@ static struct omap_smartreflex_dev_attr sr2_dev_attr = {
 	.sensor_voltdm_name	= "core",
 };
 
-static struct omap_hwmod_irq_info omap3_smartreflex_core_irqs[] = {
-	{ .irq = 19 + OMAP_INTC_START, },
-	{ .irq = -1 },
-};
 
 static struct omap_hwmod omap34xx_sr2_hwmod = {
 	.name		= "smartreflex_core",
@@ -1458,7 +1298,6 @@ static struct omap_hwmod omap34xx_sr2_hwmod = {
 		},
 	},
 	.dev_attr	= &sr2_dev_attr,
-	.mpu_irqs	= omap3_smartreflex_core_irqs,
 	.flags		= HWMOD_SET_DEFAULT_CLOCKACT,
 };
 
@@ -1476,7 +1315,6 @@ static struct omap_hwmod omap36xx_sr2_hwmod = {
 		},
 	},
 	.dev_attr	= &sr2_dev_attr,
-	.mpu_irqs	= omap3_smartreflex_core_irqs,
 };
 
 /*
@@ -1545,8 +1383,6 @@ static struct omap2_mcspi_dev_attr omap_mcspi1_dev_attr = {
 
 static struct omap_hwmod omap34xx_mcspi1 = {
 	.name		= "mcspi1",
-	.mpu_irqs	= omap2_mcspi1_mpu_irqs,
-	.sdma_reqs	= omap2_mcspi1_sdma_reqs,
 	.main_clk	= "mcspi1_fck",
 	.prcm		= {
 		.omap2 = {
@@ -1568,8 +1404,6 @@ static struct omap2_mcspi_dev_attr omap_mcspi2_dev_attr = {
 
 static struct omap_hwmod omap34xx_mcspi2 = {
 	.name		= "mcspi2",
-	.mpu_irqs	= omap2_mcspi2_mpu_irqs,
-	.sdma_reqs	= omap2_mcspi2_sdma_reqs,
 	.main_clk	= "mcspi2_fck",
 	.prcm		= {
 		.omap2 = {
@@ -1585,18 +1419,7 @@ static struct omap_hwmod omap34xx_mcspi2 = {
 };
 
 /* mcspi3 */
-static struct omap_hwmod_irq_info omap34xx_mcspi3_mpu_irqs[] = {
-	{ .name = "irq", .irq = 91 + OMAP_INTC_START, }, /* 91 */
-	{ .irq = -1 },
-};
 
-static struct omap_hwmod_dma_info omap34xx_mcspi3_sdma_reqs[] = {
-	{ .name = "tx0", .dma_req = 15 },
-	{ .name = "rx0", .dma_req = 16 },
-	{ .name = "tx1", .dma_req = 23 },
-	{ .name = "rx1", .dma_req = 24 },
-	{ .dma_req = -1 }
-};
 
 static struct omap2_mcspi_dev_attr omap_mcspi3_dev_attr = {
 	.num_chipselect = 2,
@@ -1604,8 +1427,6 @@ static struct omap2_mcspi_dev_attr omap_mcspi3_dev_attr = {
 
 static struct omap_hwmod omap34xx_mcspi3 = {
 	.name		= "mcspi3",
-	.mpu_irqs	= omap34xx_mcspi3_mpu_irqs,
-	.sdma_reqs	= omap34xx_mcspi3_sdma_reqs,
 	.main_clk	= "mcspi3_fck",
 	.prcm		= {
 		.omap2 = {
@@ -1621,16 +1442,7 @@ static struct omap_hwmod omap34xx_mcspi3 = {
 };
 
 /* mcspi4 */
-static struct omap_hwmod_irq_info omap34xx_mcspi4_mpu_irqs[] = {
-	{ .name = "irq", .irq = 48 + OMAP_INTC_START, },
-	{ .irq = -1 },
-};
 
-static struct omap_hwmod_dma_info omap34xx_mcspi4_sdma_reqs[] = {
-	{ .name = "tx0", .dma_req = 70 }, /* DMA_SPI4_TX0 */
-	{ .name = "rx0", .dma_req = 71 }, /* DMA_SPI4_RX0 */
-	{ .dma_req = -1 }
-};
 
 static struct omap2_mcspi_dev_attr omap_mcspi4_dev_attr = {
 	.num_chipselect = 1,
@@ -1638,8 +1450,6 @@ static struct omap2_mcspi_dev_attr omap_mcspi4_dev_attr = {
 
 static struct omap_hwmod omap34xx_mcspi4 = {
 	.name		= "mcspi4",
-	.mpu_irqs	= omap34xx_mcspi4_mpu_irqs,
-	.sdma_reqs	= omap34xx_mcspi4_sdma_reqs,
 	.main_clk	= "mcspi4_fck",
 	.prcm		= {
 		.omap2 = {
@@ -1673,16 +1483,9 @@ static struct omap_hwmod_class usbotg_class = {
 };
 
 /* usb_otg_hs */
-static struct omap_hwmod_irq_info omap3xxx_usbhsotg_mpu_irqs[] = {
-
-	{ .name = "mc", .irq = 92 + OMAP_INTC_START, },
-	{ .name = "dma", .irq = 93 + OMAP_INTC_START, },
-	{ .irq = -1 },
-};
 
 static struct omap_hwmod omap3xxx_usbhsotg_hwmod = {
 	.name		= "usb_otg_hs",
-	.mpu_irqs	= omap3xxx_usbhsotg_mpu_irqs,
 	.main_clk	= "hsotgusb_ick",
 	.prcm		= {
 		.omap2 = {
@@ -1691,7 +1494,7 @@ static struct omap_hwmod omap3xxx_usbhsotg_hwmod = {
 			.module_offs = CORE_MOD,
 			.idlest_reg_id = 1,
 			.idlest_idle_bit = OMAP3430ES2_ST_HSOTGUSB_IDLE_SHIFT,
-			.idlest_stdby_bit = OMAP3430ES2_ST_HSOTGUSB_STDBY_SHIFT
+			.idlest_stdby_bit = OMAP3430ES2_ST_HSOTGUSB_STDBY_SHIFT,
 		},
 	},
 	.class		= &usbotg_class,
@@ -1711,10 +1514,6 @@ static struct omap_hwmod omap3xxx_usbhsotg_hwmod = {
 };
 
 /* usb_otg_hs */
-static struct omap_hwmod_irq_info am35xx_usbhsotg_mpu_irqs[] = {
-	{ .name = "mc", .irq = 71 + OMAP_INTC_START, },
-	{ .irq = -1 },
-};
 
 static struct omap_hwmod_class am35xx_usbotg_class = {
 	.name = "am35xx_usbotg",
@@ -1722,7 +1521,6 @@ static struct omap_hwmod_class am35xx_usbotg_class = {
 
 static struct omap_hwmod am35xx_usbhsotg_hwmod = {
 	.name		= "am35x_otg_hs",
-	.mpu_irqs	= am35xx_usbhsotg_mpu_irqs,
 	.main_clk	= "hsotgusb_fck",
 	.class		= &am35xx_usbotg_class,
 	.flags		= HWMOD_NO_IDLEST,
@@ -1747,16 +1545,7 @@ static struct omap_hwmod_class omap34xx_mmc_class = {
 
 /* MMC/SD/SDIO1 */
 
-static struct omap_hwmod_irq_info omap34xx_mmc1_mpu_irqs[] = {
-	{ .irq = 83 + OMAP_INTC_START, },
-	{ .irq = -1 },
-};
 
-static struct omap_hwmod_dma_info omap34xx_mmc1_sdma_reqs[] = {
-	{ .name = "tx",	.dma_req = 61, },
-	{ .name = "rx",	.dma_req = 62, },
-	{ .dma_req = -1 }
-};
 
 static struct omap_hwmod_opt_clk omap34xx_mmc1_opt_clks[] = {
 	{ .role = "dbck", .clk = "omap_32k_fck", },
@@ -1774,8 +1563,6 @@ static struct omap_hsmmc_dev_attr mmc1_pre_es3_dev_attr = {
 
 static struct omap_hwmod omap3xxx_pre_es3_mmc1_hwmod = {
 	.name		= "mmc1",
-	.mpu_irqs	= omap34xx_mmc1_mpu_irqs,
-	.sdma_reqs	= omap34xx_mmc1_sdma_reqs,
 	.opt_clks	= omap34xx_mmc1_opt_clks,
 	.opt_clks_cnt	= ARRAY_SIZE(omap34xx_mmc1_opt_clks),
 	.main_clk	= "mmchs1_fck",
@@ -1794,8 +1581,6 @@ static struct omap_hwmod omap3xxx_pre_es3_mmc1_hwmod = {
 
 static struct omap_hwmod omap3xxx_es3plus_mmc1_hwmod = {
 	.name		= "mmc1",
-	.mpu_irqs	= omap34xx_mmc1_mpu_irqs,
-	.sdma_reqs	= omap34xx_mmc1_sdma_reqs,
 	.opt_clks	= omap34xx_mmc1_opt_clks,
 	.opt_clks_cnt	= ARRAY_SIZE(omap34xx_mmc1_opt_clks),
 	.main_clk	= "mmchs1_fck",
@@ -1814,16 +1599,7 @@ static struct omap_hwmod omap3xxx_es3plus_mmc1_hwmod = {
 
 /* MMC/SD/SDIO2 */
 
-static struct omap_hwmod_irq_info omap34xx_mmc2_mpu_irqs[] = {
-	{ .irq = 86 + OMAP_INTC_START, },
-	{ .irq = -1 },
-};
 
-static struct omap_hwmod_dma_info omap34xx_mmc2_sdma_reqs[] = {
-	{ .name = "tx",	.dma_req = 47, },
-	{ .name = "rx",	.dma_req = 48, },
-	{ .dma_req = -1 }
-};
 
 static struct omap_hwmod_opt_clk omap34xx_mmc2_opt_clks[] = {
 	{ .role = "dbck", .clk = "omap_32k_fck", },
@@ -1836,8 +1612,6 @@ static struct omap_hsmmc_dev_attr mmc2_pre_es3_dev_attr = {
 
 static struct omap_hwmod omap3xxx_pre_es3_mmc2_hwmod = {
 	.name		= "mmc2",
-	.mpu_irqs	= omap34xx_mmc2_mpu_irqs,
-	.sdma_reqs	= omap34xx_mmc2_sdma_reqs,
 	.opt_clks	= omap34xx_mmc2_opt_clks,
 	.opt_clks_cnt	= ARRAY_SIZE(omap34xx_mmc2_opt_clks),
 	.main_clk	= "mmchs2_fck",
@@ -1856,8 +1630,6 @@ static struct omap_hwmod omap3xxx_pre_es3_mmc2_hwmod = {
 
 static struct omap_hwmod omap3xxx_es3plus_mmc2_hwmod = {
 	.name		= "mmc2",
-	.mpu_irqs	= omap34xx_mmc2_mpu_irqs,
-	.sdma_reqs	= omap34xx_mmc2_sdma_reqs,
 	.opt_clks	= omap34xx_mmc2_opt_clks,
 	.opt_clks_cnt	= ARRAY_SIZE(omap34xx_mmc2_opt_clks),
 	.main_clk	= "mmchs2_fck",
@@ -1875,16 +1647,7 @@ static struct omap_hwmod omap3xxx_es3plus_mmc2_hwmod = {
 
 /* MMC/SD/SDIO3 */
 
-static struct omap_hwmod_irq_info omap34xx_mmc3_mpu_irqs[] = {
-	{ .irq = 94 + OMAP_INTC_START, },
-	{ .irq = -1 },
-};
 
-static struct omap_hwmod_dma_info omap34xx_mmc3_sdma_reqs[] = {
-	{ .name = "tx",	.dma_req = 77, },
-	{ .name = "rx",	.dma_req = 78, },
-	{ .dma_req = -1 }
-};
 
 static struct omap_hwmod_opt_clk omap34xx_mmc3_opt_clks[] = {
 	{ .role = "dbck", .clk = "omap_32k_fck", },
@@ -1892,8 +1655,6 @@ static struct omap_hwmod_opt_clk omap34xx_mmc3_opt_clks[] = {
 
 static struct omap_hwmod omap3xxx_mmc3_hwmod = {
 	.name		= "mmc3",
-	.mpu_irqs	= omap34xx_mmc3_mpu_irqs,
-	.sdma_reqs	= omap34xx_mmc3_sdma_reqs,
 	.opt_clks	= omap34xx_mmc3_opt_clks,
 	.opt_clks_cnt	= ARRAY_SIZE(omap34xx_mmc3_opt_clks),
 	.main_clk	= "mmchs3_fck",
@@ -1931,17 +1692,11 @@ static struct omap_hwmod_class omap3xxx_usb_host_hs_hwmod_class = {
 	.sysc = &omap3xxx_usb_host_hs_sysc,
 };
 
-static struct omap_hwmod_irq_info omap3xxx_usb_host_hs_irqs[] = {
-	{ .name = "ohci-irq", .irq = 76 + OMAP_INTC_START, },
-	{ .name = "ehci-irq", .irq = 77 + OMAP_INTC_START, },
-	{ .irq = -1 },
-};
 
 static struct omap_hwmod omap3xxx_usb_host_hs_hwmod = {
 	.name		= "usb_host_hs",
 	.class		= &omap3xxx_usb_host_hs_hwmod_class,
 	.clkdm_name	= "usbhost_clkdm",
-	.mpu_irqs	= omap3xxx_usb_host_hs_irqs,
 	.main_clk	= "usbhost_48m_fck",
 	.prcm = {
 		.omap2 = {
@@ -2015,16 +1770,11 @@ static struct omap_hwmod_class omap3xxx_usb_tll_hs_hwmod_class = {
 	.sysc = &omap3xxx_usb_tll_hs_sysc,
 };
 
-static struct omap_hwmod_irq_info omap3xxx_usb_tll_hs_irqs[] = {
-	{ .name = "tll-irq", .irq = 78 + OMAP_INTC_START, },
-	{ .irq = -1 },
-};
 
 static struct omap_hwmod omap3xxx_usb_tll_hs_hwmod = {
 	.name		= "usb_tll_hs",
 	.class		= &omap3xxx_usb_tll_hs_hwmod_class,
 	.clkdm_name	= "core_l4_clkdm",
-	.mpu_irqs	= omap3xxx_usb_tll_hs_irqs,
 	.main_clk	= "usbtll_fck",
 	.prcm = {
 		.omap2 = {
@@ -2039,7 +1789,6 @@ static struct omap_hwmod omap3xxx_usb_tll_hs_hwmod = {
 
 static struct omap_hwmod omap3xxx_hdq1w_hwmod = {
 	.name		= "hdq1w",
-	.mpu_irqs	= omap2_hdq1w_mpu_irqs,
 	.main_clk	= "hdq_fck",
 	.prcm		= {
 		.omap2 = {
@@ -2134,16 +1883,10 @@ static struct omap_hwmod_class omap3xxx_gpmc_hwmod_class = {
 	.sysc	= &omap3xxx_gpmc_sysc,
 };
 
-static struct omap_hwmod_irq_info omap3xxx_gpmc_irqs[] = {
-	{ .irq = 20 + OMAP_INTC_START, },
-	{ .irq = -1 }
-};
-
 static struct omap_hwmod omap3xxx_gpmc_hwmod = {
 	.name		= "gpmc",
 	.class		= &omap3xxx_gpmc_hwmod_class,
 	.clkdm_name	= "core_l3_clkdm",
-	.mpu_irqs	= omap3xxx_gpmc_irqs,
 	.main_clk	= "gpmc_fck",
 	/* Skip reset for CONFIG_OMAP_GPMC_DEBUG for bootloader timings */
 	.flags		= HWMOD_NO_IDLEST | DEBUG_OMAP_GPMC_HWMOD_FLAGS,
@@ -2167,37 +1910,19 @@ static struct omap_hwmod_ocp_if omap3xxx_l3_main__l4_per = {
 	.user	= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-static struct omap_hwmod_addr_space omap3xxx_l3_main_addrs[] = {
-	{
-		.pa_start	= 0x68000000,
-		.pa_end		= 0x6800ffff,
-		.flags		= ADDR_TYPE_RT,
-	},
-	{ }
-};
 
 /* MPU -> L3 interface */
 static struct omap_hwmod_ocp_if omap3xxx_mpu__l3_main = {
 	.master   = &omap3xxx_mpu_hwmod,
 	.slave    = &omap3xxx_l3_main_hwmod,
-	.addr     = omap3xxx_l3_main_addrs,
 	.user	= OCP_USER_MPU,
 };
 
-static struct omap_hwmod_addr_space omap3xxx_l4_emu_addrs[] = {
-	{
-		.pa_start	= 0x54000000,
-		.pa_end		= 0x547fffff,
-		.flags		= ADDR_TYPE_RT,
-	},
-	{ }
-};
 
 /* l3 -> debugss */
 static struct omap_hwmod_ocp_if omap3xxx_l3_main__l4_debugss = {
 	.master		= &omap3xxx_l3_main_hwmod,
 	.slave		= &omap3xxx_debugss_hwmod,
-	.addr		= omap3xxx_l4_emu_addrs,
 	.user		= OCP_USER_MPU,
 };
 
@@ -2215,7 +1940,7 @@ static struct omap_hwmod_ocp_if omap3xxx_dss__l3 = {
 		.omap2 = {
 			.l3_perm_bit  = OMAP3_L3_CORE_FW_INIT_ID_DSS,
 			.flags	= OMAP_FIREWALL_L3,
-		}
+		},
 	},
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
@@ -2256,18 +1981,16 @@ static struct omap_hwmod_ocp_if omap3xxx_l4_core__pre_es3_mmc1 = {
 	.master		= &omap3xxx_l4_core_hwmod,
 	.slave		= &omap3xxx_pre_es3_mmc1_hwmod,
 	.clk		= "mmchs1_ick",
-	.addr		= omap2430_mmc1_addr_space,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-	.flags		= OMAP_FIREWALL_L4
+	.flags		= OMAP_FIREWALL_L4,
 };
 
 static struct omap_hwmod_ocp_if omap3xxx_l4_core__es3plus_mmc1 = {
 	.master		= &omap3xxx_l4_core_hwmod,
 	.slave		= &omap3xxx_es3plus_mmc1_hwmod,
 	.clk		= "mmchs1_ick",
-	.addr		= omap2430_mmc1_addr_space,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-	.flags		= OMAP_FIREWALL_L4
+	.flags		= OMAP_FIREWALL_L4,
 };
 
 /* L4 CORE -> MMC2 interface */
@@ -2275,126 +1998,70 @@ static struct omap_hwmod_ocp_if omap3xxx_l4_core__pre_es3_mmc2 = {
 	.master		= &omap3xxx_l4_core_hwmod,
 	.slave		= &omap3xxx_pre_es3_mmc2_hwmod,
 	.clk		= "mmchs2_ick",
-	.addr		= omap2430_mmc2_addr_space,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-	.flags		= OMAP_FIREWALL_L4
+	.flags		= OMAP_FIREWALL_L4,
 };
 
 static struct omap_hwmod_ocp_if omap3xxx_l4_core__es3plus_mmc2 = {
 	.master		= &omap3xxx_l4_core_hwmod,
 	.slave		= &omap3xxx_es3plus_mmc2_hwmod,
 	.clk		= "mmchs2_ick",
-	.addr		= omap2430_mmc2_addr_space,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-	.flags		= OMAP_FIREWALL_L4
+	.flags		= OMAP_FIREWALL_L4,
 };
 
 /* L4 CORE -> MMC3 interface */
-static struct omap_hwmod_addr_space omap3xxx_mmc3_addr_space[] = {
-	{
-		.pa_start	= 0x480ad000,
-		.pa_end		= 0x480ad1ff,
-		.flags		= ADDR_TYPE_RT,
-	},
-	{ }
-};
 
 static struct omap_hwmod_ocp_if omap3xxx_l4_core__mmc3 = {
 	.master		= &omap3xxx_l4_core_hwmod,
 	.slave		= &omap3xxx_mmc3_hwmod,
 	.clk		= "mmchs3_ick",
-	.addr		= omap3xxx_mmc3_addr_space,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-	.flags		= OMAP_FIREWALL_L4
+	.flags		= OMAP_FIREWALL_L4,
 };
 
 /* L4 CORE -> UART1 interface */
-static struct omap_hwmod_addr_space omap3xxx_uart1_addr_space[] = {
-	{
-		.pa_start	= OMAP3_UART1_BASE,
-		.pa_end		= OMAP3_UART1_BASE + SZ_8K - 1,
-		.flags		= ADDR_MAP_ON_INIT | ADDR_TYPE_RT,
-	},
-	{ }
-};
 
 static struct omap_hwmod_ocp_if omap3_l4_core__uart1 = {
 	.master		= &omap3xxx_l4_core_hwmod,
 	.slave		= &omap3xxx_uart1_hwmod,
 	.clk		= "uart1_ick",
-	.addr		= omap3xxx_uart1_addr_space,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
 /* L4 CORE -> UART2 interface */
-static struct omap_hwmod_addr_space omap3xxx_uart2_addr_space[] = {
-	{
-		.pa_start	= OMAP3_UART2_BASE,
-		.pa_end		= OMAP3_UART2_BASE + SZ_1K - 1,
-		.flags		= ADDR_MAP_ON_INIT | ADDR_TYPE_RT,
-	},
-	{ }
-};
 
 static struct omap_hwmod_ocp_if omap3_l4_core__uart2 = {
 	.master		= &omap3xxx_l4_core_hwmod,
 	.slave		= &omap3xxx_uart2_hwmod,
 	.clk		= "uart2_ick",
-	.addr		= omap3xxx_uart2_addr_space,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
 /* L4 PER -> UART3 interface */
-static struct omap_hwmod_addr_space omap3xxx_uart3_addr_space[] = {
-	{
-		.pa_start	= OMAP3_UART3_BASE,
-		.pa_end		= OMAP3_UART3_BASE + SZ_1K - 1,
-		.flags		= ADDR_MAP_ON_INIT | ADDR_TYPE_RT,
-	},
-	{ }
-};
 
 static struct omap_hwmod_ocp_if omap3_l4_per__uart3 = {
 	.master		= &omap3xxx_l4_per_hwmod,
 	.slave		= &omap3xxx_uart3_hwmod,
 	.clk		= "uart3_ick",
-	.addr		= omap3xxx_uart3_addr_space,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
 /* L4 PER -> UART4 interface */
-static struct omap_hwmod_addr_space omap36xx_uart4_addr_space[] = {
-	{
-		.pa_start	= OMAP3_UART4_BASE,
-		.pa_end		= OMAP3_UART4_BASE + SZ_1K - 1,
-		.flags		= ADDR_MAP_ON_INIT | ADDR_TYPE_RT,
-	},
-	{ }
-};
 
 static struct omap_hwmod_ocp_if omap36xx_l4_per__uart4 = {
 	.master		= &omap3xxx_l4_per_hwmod,
 	.slave		= &omap36xx_uart4_hwmod,
 	.clk		= "uart4_ick",
-	.addr		= omap36xx_uart4_addr_space,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
 /* AM35xx: L4 CORE -> UART4 interface */
-static struct omap_hwmod_addr_space am35xx_uart4_addr_space[] = {
-	{
-		.pa_start	= OMAP3_UART4_AM35XX_BASE,
-		.pa_end		= OMAP3_UART4_AM35XX_BASE + SZ_1K - 1,
-		.flags		= ADDR_MAP_ON_INIT | ADDR_TYPE_RT,
-	},
-	{ }
-};
 
 static struct omap_hwmod_ocp_if am35xx_l4_core__uart4 = {
 	.master		= &omap3xxx_l4_core_hwmod,
 	.slave		= &am35xx_uart4_hwmod,
 	.clk		= "uart4_ick",
-	.addr		= am35xx_uart4_addr_space,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
@@ -2403,13 +2070,12 @@ static struct omap_hwmod_ocp_if omap3_l4_core__i2c1 = {
 	.master		= &omap3xxx_l4_core_hwmod,
 	.slave		= &omap3xxx_i2c1_hwmod,
 	.clk		= "i2c1_ick",
-	.addr		= omap2_i2c1_addr_space,
 	.fw = {
 		.omap2 = {
 			.l4_fw_region  = OMAP3_L4_CORE_FW_I2C1_REGION,
 			.l4_prot_group = 7,
 			.flags	= OMAP_FIREWALL_L4,
-		}
+		},
 	},
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
@@ -2419,57 +2085,38 @@ static struct omap_hwmod_ocp_if omap3_l4_core__i2c2 = {
 	.master		= &omap3xxx_l4_core_hwmod,
 	.slave		= &omap3xxx_i2c2_hwmod,
 	.clk		= "i2c2_ick",
-	.addr		= omap2_i2c2_addr_space,
 	.fw = {
 		.omap2 = {
 			.l4_fw_region  = OMAP3_L4_CORE_FW_I2C2_REGION,
 			.l4_prot_group = 7,
 			.flags = OMAP_FIREWALL_L4,
-		}
+		},
 	},
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
 /* L4 CORE -> I2C3 interface */
-static struct omap_hwmod_addr_space omap3xxx_i2c3_addr_space[] = {
-	{
-		.pa_start	= 0x48060000,
-		.pa_end		= 0x48060000 + SZ_128 - 1,
-		.flags		= ADDR_TYPE_RT,
-	},
-	{ }
-};
 
 static struct omap_hwmod_ocp_if omap3_l4_core__i2c3 = {
 	.master		= &omap3xxx_l4_core_hwmod,
 	.slave		= &omap3xxx_i2c3_hwmod,
 	.clk		= "i2c3_ick",
-	.addr		= omap3xxx_i2c3_addr_space,
 	.fw = {
 		.omap2 = {
 			.l4_fw_region  = OMAP3_L4_CORE_FW_I2C3_REGION,
 			.l4_prot_group = 7,
 			.flags = OMAP_FIREWALL_L4,
-		}
+		},
 	},
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
 /* L4 CORE -> SR1 interface */
-static struct omap_hwmod_addr_space omap3_sr1_addr_space[] = {
-	{
-		.pa_start	= OMAP34XX_SR1_BASE,
-		.pa_end		= OMAP34XX_SR1_BASE + SZ_1K - 1,
-		.flags		= ADDR_TYPE_RT,
-	},
-	{ }
-};
 
 static struct omap_hwmod_ocp_if omap34xx_l4_core__sr1 = {
 	.master		= &omap3xxx_l4_core_hwmod,
 	.slave		= &omap34xx_sr1_hwmod,
 	.clk		= "sr_l4_ick",
-	.addr		= omap3_sr1_addr_space,
 	.user		= OCP_USER_MPU,
 };
 
@@ -2477,25 +2124,15 @@ static struct omap_hwmod_ocp_if omap36xx_l4_core__sr1 = {
 	.master		= &omap3xxx_l4_core_hwmod,
 	.slave		= &omap36xx_sr1_hwmod,
 	.clk		= "sr_l4_ick",
-	.addr		= omap3_sr1_addr_space,
 	.user		= OCP_USER_MPU,
 };
 
 /* L4 CORE -> SR1 interface */
-static struct omap_hwmod_addr_space omap3_sr2_addr_space[] = {
-	{
-		.pa_start	= OMAP34XX_SR2_BASE,
-		.pa_end		= OMAP34XX_SR2_BASE + SZ_1K - 1,
-		.flags		= ADDR_TYPE_RT,
-	},
-	{ }
-};
 
 static struct omap_hwmod_ocp_if omap34xx_l4_core__sr2 = {
 	.master		= &omap3xxx_l4_core_hwmod,
 	.slave		= &omap34xx_sr2_hwmod,
 	.clk		= "sr_l4_ick",
-	.addr		= omap3_sr2_addr_space,
 	.user		= OCP_USER_MPU,
 };
 
@@ -2503,43 +2140,24 @@ static struct omap_hwmod_ocp_if omap36xx_l4_core__sr2 = {
 	.master		= &omap3xxx_l4_core_hwmod,
 	.slave		= &omap36xx_sr2_hwmod,
 	.clk		= "sr_l4_ick",
-	.addr		= omap3_sr2_addr_space,
 	.user		= OCP_USER_MPU,
 };
 
-static struct omap_hwmod_addr_space omap3xxx_usbhsotg_addrs[] = {
-	{
-		.pa_start	= OMAP34XX_HSUSB_OTG_BASE,
-		.pa_end		= OMAP34XX_HSUSB_OTG_BASE + SZ_4K - 1,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
 
 /* l4_core -> usbhsotg  */
 static struct omap_hwmod_ocp_if omap3xxx_l4_core__usbhsotg = {
 	.master		= &omap3xxx_l4_core_hwmod,
 	.slave		= &omap3xxx_usbhsotg_hwmod,
 	.clk		= "l4_ick",
-	.addr		= omap3xxx_usbhsotg_addrs,
 	.user		= OCP_USER_MPU,
 };
 
-static struct omap_hwmod_addr_space am35xx_usbhsotg_addrs[] = {
-	{
-		.pa_start	= AM35XX_IPSS_USBOTGSS_BASE,
-		.pa_end		= AM35XX_IPSS_USBOTGSS_BASE + SZ_4K - 1,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
 
 /* l4_core -> usbhsotg  */
 static struct omap_hwmod_ocp_if am35xx_l4_core__usbhsotg = {
 	.master		= &omap3xxx_l4_core_hwmod,
 	.slave		= &am35xx_usbhsotg_hwmod,
 	.clk		= "hsotgusb_ick",
-	.addr		= am35xx_usbhsotg_addrs,
 	.user		= OCP_USER_MPU,
 };
 
@@ -2558,165 +2176,84 @@ static struct omap_hwmod_ocp_if omap3xxx_l3__iva = {
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-static struct omap_hwmod_addr_space omap3xxx_timer1_addrs[] = {
-	{
-		.pa_start	= 0x48318000,
-		.pa_end		= 0x48318000 + SZ_1K - 1,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
 
 /* l4_wkup -> timer1 */
 static struct omap_hwmod_ocp_if omap3xxx_l4_wkup__timer1 = {
 	.master		= &omap3xxx_l4_wkup_hwmod,
 	.slave		= &omap3xxx_timer1_hwmod,
 	.clk		= "gpt1_ick",
-	.addr		= omap3xxx_timer1_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-static struct omap_hwmod_addr_space omap3xxx_timer2_addrs[] = {
-	{
-		.pa_start	= 0x49032000,
-		.pa_end		= 0x49032000 + SZ_1K - 1,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
 
 /* l4_per -> timer2 */
 static struct omap_hwmod_ocp_if omap3xxx_l4_per__timer2 = {
 	.master		= &omap3xxx_l4_per_hwmod,
 	.slave		= &omap3xxx_timer2_hwmod,
 	.clk		= "gpt2_ick",
-	.addr		= omap3xxx_timer2_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-static struct omap_hwmod_addr_space omap3xxx_timer3_addrs[] = {
-	{
-		.pa_start	= 0x49034000,
-		.pa_end		= 0x49034000 + SZ_1K - 1,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
 
 /* l4_per -> timer3 */
 static struct omap_hwmod_ocp_if omap3xxx_l4_per__timer3 = {
 	.master		= &omap3xxx_l4_per_hwmod,
 	.slave		= &omap3xxx_timer3_hwmod,
 	.clk		= "gpt3_ick",
-	.addr		= omap3xxx_timer3_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-static struct omap_hwmod_addr_space omap3xxx_timer4_addrs[] = {
-	{
-		.pa_start	= 0x49036000,
-		.pa_end		= 0x49036000 + SZ_1K - 1,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
 
 /* l4_per -> timer4 */
 static struct omap_hwmod_ocp_if omap3xxx_l4_per__timer4 = {
 	.master		= &omap3xxx_l4_per_hwmod,
 	.slave		= &omap3xxx_timer4_hwmod,
 	.clk		= "gpt4_ick",
-	.addr		= omap3xxx_timer4_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-static struct omap_hwmod_addr_space omap3xxx_timer5_addrs[] = {
-	{
-		.pa_start	= 0x49038000,
-		.pa_end		= 0x49038000 + SZ_1K - 1,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
 
 /* l4_per -> timer5 */
 static struct omap_hwmod_ocp_if omap3xxx_l4_per__timer5 = {
 	.master		= &omap3xxx_l4_per_hwmod,
 	.slave		= &omap3xxx_timer5_hwmod,
 	.clk		= "gpt5_ick",
-	.addr		= omap3xxx_timer5_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-static struct omap_hwmod_addr_space omap3xxx_timer6_addrs[] = {
-	{
-		.pa_start	= 0x4903A000,
-		.pa_end		= 0x4903A000 + SZ_1K - 1,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
 
 /* l4_per -> timer6 */
 static struct omap_hwmod_ocp_if omap3xxx_l4_per__timer6 = {
 	.master		= &omap3xxx_l4_per_hwmod,
 	.slave		= &omap3xxx_timer6_hwmod,
 	.clk		= "gpt6_ick",
-	.addr		= omap3xxx_timer6_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-static struct omap_hwmod_addr_space omap3xxx_timer7_addrs[] = {
-	{
-		.pa_start	= 0x4903C000,
-		.pa_end		= 0x4903C000 + SZ_1K - 1,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
 
 /* l4_per -> timer7 */
 static struct omap_hwmod_ocp_if omap3xxx_l4_per__timer7 = {
 	.master		= &omap3xxx_l4_per_hwmod,
 	.slave		= &omap3xxx_timer7_hwmod,
 	.clk		= "gpt7_ick",
-	.addr		= omap3xxx_timer7_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-static struct omap_hwmod_addr_space omap3xxx_timer8_addrs[] = {
-	{
-		.pa_start	= 0x4903E000,
-		.pa_end		= 0x4903E000 + SZ_1K - 1,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
 
 /* l4_per -> timer8 */
 static struct omap_hwmod_ocp_if omap3xxx_l4_per__timer8 = {
 	.master		= &omap3xxx_l4_per_hwmod,
 	.slave		= &omap3xxx_timer8_hwmod,
 	.clk		= "gpt8_ick",
-	.addr		= omap3xxx_timer8_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-static struct omap_hwmod_addr_space omap3xxx_timer9_addrs[] = {
-	{
-		.pa_start	= 0x49040000,
-		.pa_end		= 0x49040000 + SZ_1K - 1,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
 
 /* l4_per -> timer9 */
 static struct omap_hwmod_ocp_if omap3xxx_l4_per__timer9 = {
 	.master		= &omap3xxx_l4_per_hwmod,
 	.slave		= &omap3xxx_timer9_hwmod,
 	.clk		= "gpt9_ick",
-	.addr		= omap3xxx_timer9_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
@@ -2725,7 +2262,6 @@ static struct omap_hwmod_ocp_if omap3xxx_l4_core__timer10 = {
 	.master		= &omap3xxx_l4_core_hwmod,
 	.slave		= &omap3xxx_timer10_hwmod,
 	.clk		= "gpt10_ick",
-	.addr		= omap2_timer10_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
@@ -2734,43 +2270,24 @@ static struct omap_hwmod_ocp_if omap3xxx_l4_core__timer11 = {
 	.master		= &omap3xxx_l4_core_hwmod,
 	.slave		= &omap3xxx_timer11_hwmod,
 	.clk		= "gpt11_ick",
-	.addr		= omap2_timer11_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-static struct omap_hwmod_addr_space omap3xxx_timer12_addrs[] = {
-	{
-		.pa_start	= 0x48304000,
-		.pa_end		= 0x48304000 + SZ_1K - 1,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
 
 /* l4_core -> timer12 */
 static struct omap_hwmod_ocp_if omap3xxx_l4_sec__timer12 = {
 	.master		= &omap3xxx_l4_sec_hwmod,
 	.slave		= &omap3xxx_timer12_hwmod,
 	.clk		= "gpt12_ick",
-	.addr		= omap3xxx_timer12_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
 /* l4_wkup -> wd_timer2 */
-static struct omap_hwmod_addr_space omap3xxx_wd_timer2_addrs[] = {
-	{
-		.pa_start	= 0x48314000,
-		.pa_end		= 0x4831407f,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
 
 static struct omap_hwmod_ocp_if omap3xxx_l4_wkup__wd_timer2 = {
 	.master		= &omap3xxx_l4_wkup_hwmod,
 	.slave		= &omap3xxx_wd_timer2_hwmod,
 	.clk		= "wdt2_ick",
-	.addr		= omap3xxx_wd_timer2_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
@@ -2779,13 +2296,12 @@ static struct omap_hwmod_ocp_if omap3430es1_l4_core__dss = {
 	.master		= &omap3xxx_l4_core_hwmod,
 	.slave		= &omap3430es1_dss_core_hwmod,
 	.clk		= "dss_ick",
-	.addr		= omap2_dss_addrs,
 	.fw = {
 		.omap2 = {
 			.l4_fw_region  = OMAP3ES1_L4_CORE_FW_DSS_CORE_REGION,
 			.l4_prot_group = OMAP3_L4_CORE_FW_DSS_PROT_GROUP,
 			.flags	= OMAP_FIREWALL_L4,
-		}
+		},
 	},
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
@@ -2794,13 +2310,12 @@ static struct omap_hwmod_ocp_if omap3xxx_l4_core__dss = {
 	.master		= &omap3xxx_l4_core_hwmod,
 	.slave		= &omap3xxx_dss_core_hwmod,
 	.clk		= "dss_ick",
-	.addr		= omap2_dss_addrs,
 	.fw = {
 		.omap2 = {
 			.l4_fw_region  = OMAP3_L4_CORE_FW_DSS_CORE_REGION,
 			.l4_prot_group = OMAP3_L4_CORE_FW_DSS_PROT_GROUP,
 			.flags	= OMAP_FIREWALL_L4,
-		}
+		},
 	},
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
@@ -2810,38 +2325,27 @@ static struct omap_hwmod_ocp_if omap3xxx_l4_core__dss_dispc = {
 	.master		= &omap3xxx_l4_core_hwmod,
 	.slave		= &omap3xxx_dss_dispc_hwmod,
 	.clk		= "dss_ick",
-	.addr		= omap2_dss_dispc_addrs,
 	.fw = {
 		.omap2 = {
 			.l4_fw_region  = OMAP3_L4_CORE_FW_DSS_DISPC_REGION,
 			.l4_prot_group = OMAP3_L4_CORE_FW_DSS_PROT_GROUP,
 			.flags	= OMAP_FIREWALL_L4,
-		}
+		},
 	},
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-static struct omap_hwmod_addr_space omap3xxx_dss_dsi1_addrs[] = {
-	{
-		.pa_start	= 0x4804FC00,
-		.pa_end		= 0x4804FFFF,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
-
 /* l4_core -> dss_dsi1 */
 static struct omap_hwmod_ocp_if omap3xxx_l4_core__dss_dsi1 = {
 	.master		= &omap3xxx_l4_core_hwmod,
 	.slave		= &omap3xxx_dss_dsi1_hwmod,
 	.clk		= "dss_ick",
-	.addr		= omap3xxx_dss_dsi1_addrs,
 	.fw = {
 		.omap2 = {
 			.l4_fw_region  = OMAP3_L4_CORE_FW_DSS_DSI_REGION,
 			.l4_prot_group = OMAP3_L4_CORE_FW_DSS_PROT_GROUP,
 			.flags	= OMAP_FIREWALL_L4,
-		}
+		},
 	},
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
@@ -2851,13 +2355,12 @@ static struct omap_hwmod_ocp_if omap3xxx_l4_core__dss_rfbi = {
 	.master		= &omap3xxx_l4_core_hwmod,
 	.slave		= &omap3xxx_dss_rfbi_hwmod,
 	.clk		= "dss_ick",
-	.addr		= omap2_dss_rfbi_addrs,
 	.fw = {
 		.omap2 = {
 			.l4_fw_region  = OMAP3_L4_CORE_FW_DSS_RFBI_REGION,
 			.l4_prot_group = OMAP3_L4_CORE_FW_DSS_PROT_GROUP ,
 			.flags	= OMAP_FIREWALL_L4,
-		}
+		},
 	},
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
@@ -2867,66 +2370,38 @@ static struct omap_hwmod_ocp_if omap3xxx_l4_core__dss_venc = {
 	.master		= &omap3xxx_l4_core_hwmod,
 	.slave		= &omap3xxx_dss_venc_hwmod,
 	.clk		= "dss_ick",
-	.addr		= omap2_dss_venc_addrs,
 	.fw = {
 		.omap2 = {
 			.l4_fw_region  = OMAP3_L4_CORE_FW_DSS_VENC_REGION,
 			.l4_prot_group = OMAP3_L4_CORE_FW_DSS_PROT_GROUP,
 			.flags	= OMAP_FIREWALL_L4,
-		}
+		},
 	},
 	.flags		= OCPIF_SWSUP_IDLE,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
 /* l4_wkup -> gpio1 */
-static struct omap_hwmod_addr_space omap3xxx_gpio1_addrs[] = {
-	{
-		.pa_start	= 0x48310000,
-		.pa_end		= 0x483101ff,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
 
 static struct omap_hwmod_ocp_if omap3xxx_l4_wkup__gpio1 = {
 	.master		= &omap3xxx_l4_wkup_hwmod,
 	.slave		= &omap3xxx_gpio1_hwmod,
-	.addr		= omap3xxx_gpio1_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
 /* l4_per -> gpio2 */
-static struct omap_hwmod_addr_space omap3xxx_gpio2_addrs[] = {
-	{
-		.pa_start	= 0x49050000,
-		.pa_end		= 0x490501ff,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
 
 static struct omap_hwmod_ocp_if omap3xxx_l4_per__gpio2 = {
 	.master		= &omap3xxx_l4_per_hwmod,
 	.slave		= &omap3xxx_gpio2_hwmod,
-	.addr		= omap3xxx_gpio2_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
 /* l4_per -> gpio3 */
-static struct omap_hwmod_addr_space omap3xxx_gpio3_addrs[] = {
-	{
-		.pa_start	= 0x49052000,
-		.pa_end		= 0x490521ff,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
 
 static struct omap_hwmod_ocp_if omap3xxx_l4_per__gpio3 = {
 	.master		= &omap3xxx_l4_per_hwmod,
 	.slave		= &omap3xxx_gpio3_hwmod,
-	.addr		= omap3xxx_gpio3_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
@@ -3002,53 +2477,26 @@ static struct omap_hwmod omap3xxx_mmu_iva_hwmod = {
 };
 
 /* l4_per -> gpio4 */
-static struct omap_hwmod_addr_space omap3xxx_gpio4_addrs[] = {
-	{
-		.pa_start	= 0x49054000,
-		.pa_end		= 0x490541ff,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
 
 static struct omap_hwmod_ocp_if omap3xxx_l4_per__gpio4 = {
 	.master		= &omap3xxx_l4_per_hwmod,
 	.slave		= &omap3xxx_gpio4_hwmod,
-	.addr		= omap3xxx_gpio4_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
 /* l4_per -> gpio5 */
-static struct omap_hwmod_addr_space omap3xxx_gpio5_addrs[] = {
-	{
-		.pa_start	= 0x49056000,
-		.pa_end		= 0x490561ff,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
 
 static struct omap_hwmod_ocp_if omap3xxx_l4_per__gpio5 = {
 	.master		= &omap3xxx_l4_per_hwmod,
 	.slave		= &omap3xxx_gpio5_hwmod,
-	.addr		= omap3xxx_gpio5_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
 /* l4_per -> gpio6 */
-static struct omap_hwmod_addr_space omap3xxx_gpio6_addrs[] = {
-	{
-		.pa_start	= 0x49058000,
-		.pa_end		= 0x490581ff,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
 
 static struct omap_hwmod_ocp_if omap3xxx_l4_per__gpio6 = {
 	.master		= &omap3xxx_l4_per_hwmod,
 	.slave		= &omap3xxx_gpio6_hwmod,
-	.addr		= omap3xxx_gpio6_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
@@ -3064,9 +2512,9 @@ static struct omap_hwmod_addr_space omap3xxx_dma_system_addrs[] = {
 	{
 		.pa_start	= 0x48056000,
 		.pa_end		= 0x48056fff,
-		.flags		= ADDR_TYPE_RT
+		.flags		= ADDR_TYPE_RT,
 	},
-	{ }
+	{ },
 };
 
 /* l4_cfg -> dma_system */
@@ -3078,136 +2526,66 @@ static struct omap_hwmod_ocp_if omap3xxx_l4_core__dma_system = {
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-static struct omap_hwmod_addr_space omap3xxx_mcbsp1_addrs[] = {
-	{
-		.name		= "mpu",
-		.pa_start	= 0x48074000,
-		.pa_end		= 0x480740ff,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
 
 /* l4_core -> mcbsp1 */
 static struct omap_hwmod_ocp_if omap3xxx_l4_core__mcbsp1 = {
 	.master		= &omap3xxx_l4_core_hwmod,
 	.slave		= &omap3xxx_mcbsp1_hwmod,
 	.clk		= "mcbsp1_ick",
-	.addr		= omap3xxx_mcbsp1_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-static struct omap_hwmod_addr_space omap3xxx_mcbsp2_addrs[] = {
-	{
-		.name		= "mpu",
-		.pa_start	= 0x49022000,
-		.pa_end		= 0x490220ff,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
 
 /* l4_per -> mcbsp2 */
 static struct omap_hwmod_ocp_if omap3xxx_l4_per__mcbsp2 = {
 	.master		= &omap3xxx_l4_per_hwmod,
 	.slave		= &omap3xxx_mcbsp2_hwmod,
 	.clk		= "mcbsp2_ick",
-	.addr		= omap3xxx_mcbsp2_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-static struct omap_hwmod_addr_space omap3xxx_mcbsp3_addrs[] = {
-	{
-		.name		= "mpu",
-		.pa_start	= 0x49024000,
-		.pa_end		= 0x490240ff,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
 
 /* l4_per -> mcbsp3 */
 static struct omap_hwmod_ocp_if omap3xxx_l4_per__mcbsp3 = {
 	.master		= &omap3xxx_l4_per_hwmod,
 	.slave		= &omap3xxx_mcbsp3_hwmod,
 	.clk		= "mcbsp3_ick",
-	.addr		= omap3xxx_mcbsp3_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-static struct omap_hwmod_addr_space omap3xxx_mcbsp4_addrs[] = {
-	{
-		.name		= "mpu",
-		.pa_start	= 0x49026000,
-		.pa_end		= 0x490260ff,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
 
 /* l4_per -> mcbsp4 */
 static struct omap_hwmod_ocp_if omap3xxx_l4_per__mcbsp4 = {
 	.master		= &omap3xxx_l4_per_hwmod,
 	.slave		= &omap3xxx_mcbsp4_hwmod,
 	.clk		= "mcbsp4_ick",
-	.addr		= omap3xxx_mcbsp4_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-static struct omap_hwmod_addr_space omap3xxx_mcbsp5_addrs[] = {
-	{
-		.name		= "mpu",
-		.pa_start	= 0x48096000,
-		.pa_end		= 0x480960ff,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
 
 /* l4_core -> mcbsp5 */
 static struct omap_hwmod_ocp_if omap3xxx_l4_core__mcbsp5 = {
 	.master		= &omap3xxx_l4_core_hwmod,
 	.slave		= &omap3xxx_mcbsp5_hwmod,
 	.clk		= "mcbsp5_ick",
-	.addr		= omap3xxx_mcbsp5_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-static struct omap_hwmod_addr_space omap3xxx_mcbsp2_sidetone_addrs[] = {
-	{
-		.name		= "sidetone",
-		.pa_start	= 0x49028000,
-		.pa_end		= 0x490280ff,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
 
 /* l4_per -> mcbsp2_sidetone */
 static struct omap_hwmod_ocp_if omap3xxx_l4_per__mcbsp2_sidetone = {
 	.master		= &omap3xxx_l4_per_hwmod,
 	.slave		= &omap3xxx_mcbsp2_sidetone_hwmod,
 	.clk		= "mcbsp2_ick",
-	.addr		= omap3xxx_mcbsp2_sidetone_addrs,
 	.user		= OCP_USER_MPU,
 };
 
-static struct omap_hwmod_addr_space omap3xxx_mcbsp3_sidetone_addrs[] = {
-	{
-		.name		= "sidetone",
-		.pa_start	= 0x4902A000,
-		.pa_end		= 0x4902A0ff,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
 
 /* l4_per -> mcbsp3_sidetone */
 static struct omap_hwmod_ocp_if omap3xxx_l4_per__mcbsp3_sidetone = {
 	.master		= &omap3xxx_l4_per_hwmod,
 	.slave		= &omap3xxx_mcbsp3_sidetone_hwmod,
 	.clk		= "mcbsp3_ick",
-	.addr		= omap3xxx_mcbsp3_sidetone_addrs,
 	.user		= OCP_USER_MPU,
 };
 
@@ -3223,7 +2601,6 @@ static struct omap_hwmod_ocp_if omap34xx_l4_core__mcspi1 = {
 	.master		= &omap3xxx_l4_core_hwmod,
 	.slave		= &omap34xx_mcspi1,
 	.clk		= "mcspi1_ick",
-	.addr		= omap2_mcspi1_addr_space,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
@@ -3232,7 +2609,6 @@ static struct omap_hwmod_ocp_if omap34xx_l4_core__mcspi2 = {
 	.master		= &omap3xxx_l4_core_hwmod,
 	.slave		= &omap34xx_mcspi2,
 	.clk		= "mcspi2_ick",
-	.addr		= omap2_mcspi2_addr_space,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
@@ -3241,25 +2617,15 @@ static struct omap_hwmod_ocp_if omap34xx_l4_core__mcspi3 = {
 	.master		= &omap3xxx_l4_core_hwmod,
 	.slave		= &omap34xx_mcspi3,
 	.clk		= "mcspi3_ick",
-	.addr		= omap2430_mcspi3_addr_space,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
 /* l4 core -> mcspi4 interface */
-static struct omap_hwmod_addr_space omap34xx_mcspi4_addr_space[] = {
-	{
-		.pa_start	= 0x480ba000,
-		.pa_end		= 0x480ba0ff,
-		.flags		= ADDR_TYPE_RT,
-	},
-	{ }
-};
 
 static struct omap_hwmod_ocp_if omap34xx_l4_core__mcspi4 = {
 	.master		= &omap3xxx_l4_core_hwmod,
 	.slave		= &omap34xx_mcspi4,
 	.clk		= "mcspi4_ick",
-	.addr		= omap34xx_mcspi4_addr_space,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
@@ -3270,49 +2636,19 @@ static struct omap_hwmod_ocp_if omap3xxx_usb_host_hs__l3_main_2 = {
 	.user		= OCP_USER_MPU,
 };
 
-static struct omap_hwmod_addr_space omap3xxx_usb_host_hs_addrs[] = {
-	{
-		.name		= "uhh",
-		.pa_start	= 0x48064000,
-		.pa_end		= 0x480643ff,
-		.flags		= ADDR_TYPE_RT
-	},
-	{
-		.name		= "ohci",
-		.pa_start	= 0x48064400,
-		.pa_end		= 0x480647ff,
-	},
-	{
-		.name		= "ehci",
-		.pa_start	= 0x48064800,
-		.pa_end		= 0x48064cff,
-	},
-	{}
-};
 
 static struct omap_hwmod_ocp_if omap3xxx_l4_core__usb_host_hs = {
 	.master		= &omap3xxx_l4_core_hwmod,
 	.slave		= &omap3xxx_usb_host_hs_hwmod,
 	.clk		= "usbhost_ick",
-	.addr		= omap3xxx_usb_host_hs_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-static struct omap_hwmod_addr_space omap3xxx_usb_tll_hs_addrs[] = {
-	{
-		.name		= "tll",
-		.pa_start	= 0x48062000,
-		.pa_end		= 0x48062fff,
-		.flags		= ADDR_TYPE_RT
-	},
-	{}
-};
 
 static struct omap_hwmod_ocp_if omap3xxx_l4_core__usb_tll_hs = {
 	.master		= &omap3xxx_l4_core_hwmod,
 	.slave		= &omap3xxx_usb_tll_hs_hwmod,
 	.clk		= "usbtll_ick",
-	.addr		= omap3xxx_usb_tll_hs_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
@@ -3321,35 +2657,17 @@ static struct omap_hwmod_ocp_if omap3xxx_l4_core__hdq1w = {
 	.master		= &omap3xxx_l4_core_hwmod,
 	.slave		= &omap3xxx_hdq1w_hwmod,
 	.clk		= "hdq_ick",
-	.addr		= omap2_hdq1w_addr_space,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 	.flags		= OMAP_FIREWALL_L4 | OCPIF_SWSUP_IDLE,
 };
 
 /* l4_wkup -> 32ksync_counter */
-static struct omap_hwmod_addr_space omap3xxx_counter_32k_addrs[] = {
-	{
-		.pa_start	= 0x48320000,
-		.pa_end		= 0x4832001f,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
 
-static struct omap_hwmod_addr_space omap3xxx_gpmc_addrs[] = {
-	{
-		.pa_start	= 0x6e000000,
-		.pa_end		= 0x6e000fff,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
 
 static struct omap_hwmod_ocp_if omap3xxx_l4_wkup__counter_32k = {
 	.master		= &omap3xxx_l4_wkup_hwmod,
 	.slave		= &omap3xxx_counter_32k_hwmod,
 	.clk		= "omap_32ksync_ick",
-	.addr		= omap3xxx_counter_32k_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
@@ -3434,7 +2752,6 @@ static struct omap_hwmod_ocp_if omap3xxx_l3_main__gpmc = {
 	.master		= &omap3xxx_l3_main_hwmod,
 	.slave		= &omap3xxx_gpmc_hwmod,
 	.clk		= "core_l3_ick",
-	.addr		= omap3xxx_gpmc_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
@@ -3459,20 +2776,10 @@ static struct omap_hwmod_class omap3xxx_sham_class = {
 	.sysc	= &omap3_sham_sysc,
 };
 
-static struct omap_hwmod_irq_info omap3_sham_mpu_irqs[] = {
-	{ .irq = 49 + OMAP_INTC_START, },
-	{ .irq = -1 }
-};
 
-static struct omap_hwmod_dma_info omap3_sham_sdma_reqs[] = {
-	{ .name = "rx", .dma_req = 69, },
-	{ .dma_req = -1 }
-};
 
 static struct omap_hwmod omap3xxx_sham_hwmod = {
 	.name		= "sham",
-	.mpu_irqs	= omap3_sham_mpu_irqs,
-	.sdma_reqs	= omap3_sham_sdma_reqs,
 	.main_clk	= "sha12_ick",
 	.prcm		= {
 		.omap2 = {
@@ -3486,20 +2793,11 @@ static struct omap_hwmod omap3xxx_sham_hwmod = {
 	.class		= &omap3xxx_sham_class,
 };
 
-static struct omap_hwmod_addr_space omap3xxx_sham_addrs[] = {
-	{
-		.pa_start	= 0x480c3000,
-		.pa_end		= 0x480c3000 + 0x64 - 1,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
 
 static struct omap_hwmod_ocp_if omap3xxx_l4_core__sham = {
 	.master		= &omap3xxx_l4_core_hwmod,
 	.slave		= &omap3xxx_sham_hwmod,
 	.clk		= "sha12_ick",
-	.addr		= omap3xxx_sham_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
@@ -3525,15 +2823,9 @@ static struct omap_hwmod_class omap3xxx_aes_class = {
 	.sysc	= &omap3_aes_sysc,
 };
 
-static struct omap_hwmod_dma_info omap3_aes_sdma_reqs[] = {
-	{ .name = "tx", .dma_req = 65, },
-	{ .name = "rx", .dma_req = 66, },
-	{ .dma_req = -1 }
-};
 
 static struct omap_hwmod omap3xxx_aes_hwmod = {
 	.name		= "aes",
-	.sdma_reqs	= omap3_aes_sdma_reqs,
 	.main_clk	= "aes2_ick",
 	.prcm		= {
 		.omap2 = {
@@ -3547,20 +2839,11 @@ static struct omap_hwmod omap3xxx_aes_hwmod = {
 	.class		= &omap3xxx_aes_class,
 };
 
-static struct omap_hwmod_addr_space omap3xxx_aes_addrs[] = {
-	{
-		.pa_start	= 0x480c5000,
-		.pa_end		= 0x480c5000 + 0x50 - 1,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
 
 static struct omap_hwmod_ocp_if omap3xxx_l4_core__aes = {
 	.master		= &omap3xxx_l4_core_hwmod,
 	.slave		= &omap3xxx_aes_hwmod,
 	.clk		= "aes2_ick",
-	.addr		= omap3xxx_aes_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
@@ -3661,28 +2944,28 @@ static struct omap_hwmod_ocp_if *omap3xxx_hwmod_ocp_ifs[] __initdata = {
 /* GP-only hwmod links */
 static struct omap_hwmod_ocp_if *omap34xx_gp_hwmod_ocp_ifs[] __initdata = {
 	&omap3xxx_l4_sec__timer12,
-	NULL
+	NULL,
 };
 
 static struct omap_hwmod_ocp_if *omap36xx_gp_hwmod_ocp_ifs[] __initdata = {
 	&omap3xxx_l4_sec__timer12,
-	NULL
+	NULL,
 };
 
 static struct omap_hwmod_ocp_if *am35xx_gp_hwmod_ocp_ifs[] __initdata = {
 	&omap3xxx_l4_sec__timer12,
-	NULL
+	NULL,
 };
 
 /* crypto hwmod links */
 static struct omap_hwmod_ocp_if *omap34xx_sham_hwmod_ocp_ifs[] __initdata = {
 	&omap3xxx_l4_core__sham,
-	NULL
+	NULL,
 };
 
 static struct omap_hwmod_ocp_if *omap34xx_aes_hwmod_ocp_ifs[] __initdata = {
 	&omap3xxx_l4_core__aes,
-	NULL
+	NULL,
 };
 
 static struct omap_hwmod_ocp_if *omap36xx_sham_hwmod_ocp_ifs[] __initdata = {
@@ -3710,14 +2993,14 @@ static struct omap_hwmod_ocp_if *am35xx_sham_hwmod_ocp_ifs[] __initdata = {
 
 static struct omap_hwmod_ocp_if *am35xx_aes_hwmod_ocp_ifs[] __initdata = {
 	/* &omap3xxx_l4_core__aes, */
-	NULL
+	NULL,
 };
 
 /* 3430ES1-only hwmod links */
 static struct omap_hwmod_ocp_if *omap3430es1_hwmod_ocp_ifs[] __initdata = {
 	&omap3430es1_dss__l3,
 	&omap3430es1_l4_core__dss,
-	NULL
+	NULL,
 };
 
 /* 3430ES2+-only hwmod links */
@@ -3729,21 +3012,21 @@ static struct omap_hwmod_ocp_if *omap3430es2plus_hwmod_ocp_ifs[] __initdata = {
 	&omap3xxx_usb_host_hs__l3_main_2,
 	&omap3xxx_l4_core__usb_host_hs,
 	&omap3xxx_l4_core__usb_tll_hs,
-	NULL
+	NULL,
 };
 
 /* <= 3430ES3-only hwmod links */
 static struct omap_hwmod_ocp_if *omap3430_pre_es3_hwmod_ocp_ifs[] __initdata = {
 	&omap3xxx_l4_core__pre_es3_mmc1,
 	&omap3xxx_l4_core__pre_es3_mmc2,
-	NULL
+	NULL,
 };
 
 /* 3430ES3+-only hwmod links */
 static struct omap_hwmod_ocp_if *omap3430_es3plus_hwmod_ocp_ifs[] __initdata = {
 	&omap3xxx_l4_core__es3plus_mmc1,
 	&omap3xxx_l4_core__es3plus_mmc2,
-	NULL
+	NULL,
 };
 
 /* 34xx-only hwmod links (all ES revisions) */
@@ -3757,7 +3040,7 @@ static struct omap_hwmod_ocp_if *omap34xx_hwmod_ocp_ifs[] __initdata = {
 	&omap3xxx_l4_core__mmu_isp,
 	&omap3xxx_l3_main__mmu_iva,
 	&omap3xxx_l4_core__ssi,
-	NULL
+	NULL,
 };
 
 /* 36xx-only hwmod links (all ES revisions) */
@@ -3781,7 +3064,7 @@ static struct omap_hwmod_ocp_if *omap36xx_hwmod_ocp_ifs[] __initdata = {
 	&omap3xxx_l4_core__mmu_isp,
 	&omap3xxx_l3_main__mmu_iva,
 	&omap3xxx_l4_core__ssi,
-	NULL
+	NULL,
 };
 
 static struct omap_hwmod_ocp_if *am35xx_hwmod_ocp_ifs[] __initdata = {
@@ -3800,7 +3083,7 @@ static struct omap_hwmod_ocp_if *am35xx_hwmod_ocp_ifs[] __initdata = {
 	&am35xx_l4_core__mdio,
 	&am35xx_emac__l3,
 	&am35xx_l4_core__emac,
-	NULL
+	NULL,
 };
 
 static struct omap_hwmod_ocp_if *omap3xxx_dss_hwmod_ocp_ifs[] __initdata = {
@@ -3808,7 +3091,7 @@ static struct omap_hwmod_ocp_if *omap3xxx_dss_hwmod_ocp_ifs[] __initdata = {
 	&omap3xxx_l4_core__dss_dsi1,
 	&omap3xxx_l4_core__dss_rfbi,
 	&omap3xxx_l4_core__dss_venc,
-	NULL
+	NULL,
 };
 
 /**
diff --git a/arch/arm/mach-omap2/omap_hwmod_common_data.h b/arch/arm/mach-omap2/omap_hwmod_common_data.h
--- a/arch/arm/mach-omap2/omap_hwmod_common_data.h
+++ b/arch/arm/mach-omap2/omap_hwmod_common_data.h
@@ -19,22 +19,7 @@
 #include "display.h"
 
 /* Common address space across OMAP2xxx/3xxx */
-extern struct omap_hwmod_addr_space omap2_i2c1_addr_space[];
-extern struct omap_hwmod_addr_space omap2_i2c2_addr_space[];
-extern struct omap_hwmod_addr_space omap2_dss_addrs[];
-extern struct omap_hwmod_addr_space omap2_dss_dispc_addrs[];
-extern struct omap_hwmod_addr_space omap2_dss_rfbi_addrs[];
-extern struct omap_hwmod_addr_space omap2_dss_venc_addrs[];
-extern struct omap_hwmod_addr_space omap2_timer10_addrs[];
-extern struct omap_hwmod_addr_space omap2_timer11_addrs[];
-extern struct omap_hwmod_addr_space omap2430_mmc1_addr_space[];
-extern struct omap_hwmod_addr_space omap2430_mmc2_addr_space[];
-extern struct omap_hwmod_addr_space omap2_mcspi1_addr_space[];
-extern struct omap_hwmod_addr_space omap2_mcspi2_addr_space[];
-extern struct omap_hwmod_addr_space omap2430_mcspi3_addr_space[];
 extern struct omap_hwmod_addr_space omap2_dma_system_addrs[];
-extern struct omap_hwmod_addr_space omap2_mcbsp1_addrs[];
-extern struct omap_hwmod_addr_space omap2_hdq1w_addr_space[];
 
 /* Common IP block data across OMAP2xxx */
 extern struct omap_gpio_dev_attr omap2xxx_gpio_dev_attr;
-- 
2.10.2

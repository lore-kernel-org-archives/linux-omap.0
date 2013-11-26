From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 12/12] ARM: OMAP2+: Remove legacy data from hwmod for omap3
Date: Mon, 25 Nov 2013 16:14:27 -0800
Message-ID: <1385424867-27243-13-git-send-email-tony@atomide.com>
References: <1385424867-27243-1-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:30382 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753650Ab3KZAOl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 25 Nov 2013 19:14:41 -0500
In-Reply-To: <1385424867-27243-1-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>

This data is now coming from device tree so we can remove the
duplicate data. Let's keep the DSS and DMA related things for now
until those have been converted to device tree completely.

While at it, let's also add the trailing commas to data structures
so further processing with scripts will be a bit easier.

Cc: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 .../omap_hwmod_2xxx_3xxx_interconnect_data.c       | 134 +---
 .../mach-omap2/omap_hwmod_2xxx_3xxx_ipblock_data.c | 201 +----
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         | 833 +--------------------
 3 files changed, 49 insertions(+), 1119 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_2xxx_3xxx_interconnect_data.c b/arch/arm/mach-omap2/omap_hwmod_2xxx_3xxx_interconnect_data.c
index 0413dab..b58fe8f 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2xxx_3xxx_interconnect_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2xxx_3xxx_interconnect_data.c
@@ -17,165 +17,47 @@
 
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
 struct omap_hwmod_addr_space omap2_dss_addrs[] = {
 	{
 		.pa_start	= 0x48050000,
 		.pa_end		= 0x48050000 + SZ_1K - 1,
-		.flags		= ADDR_TYPE_RT
+		.flags		= ADDR_TYPE_RT,
 	},
-	{ }
+	{ },
 };
 
 struct omap_hwmod_addr_space omap2_dss_dispc_addrs[] = {
 	{
 		.pa_start	= 0x48050400,
 		.pa_end		= 0x48050400 + SZ_1K - 1,
-		.flags		= ADDR_TYPE_RT
+		.flags		= ADDR_TYPE_RT,
 	},
-	{ }
+	{ },
 };
 
 struct omap_hwmod_addr_space omap2_dss_rfbi_addrs[] = {
 	{
 		.pa_start	= 0x48050800,
 		.pa_end		= 0x48050800 + SZ_1K - 1,
-		.flags		= ADDR_TYPE_RT
+		.flags		= ADDR_TYPE_RT,
 	},
-	{ }
+	{ },
 };
 
 struct omap_hwmod_addr_space omap2_dss_venc_addrs[] = {
 	{
 		.pa_start	= 0x48050C00,
 		.pa_end		= 0x48050C00 + SZ_1K - 1,
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
 		.flags		= ADDR_TYPE_RT,
 	},
-	{ }
+	{ },
 };
 
 struct omap_hwmod_addr_space omap2_dma_system_addrs[] = {
 	{
 		.pa_start	= 0x48056000,
 		.pa_end		= 0x48056000 + SZ_4K - 1,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
-
-struct omap_hwmod_addr_space omap2_mailbox_addrs[] = {
-	{
-		.pa_start	= 0x48094000,
-		.pa_end		= 0x48094000 + SZ_512 - 1,
 		.flags		= ADDR_TYPE_RT,
 	},
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
-	},
-	{ }
+	{ },
 };
diff --git a/arch/arm/mach-omap2/omap_hwmod_2xxx_3xxx_ipblock_data.c b/arch/arm/mach-omap2/omap_hwmod_2xxx_3xxx_ipblock_data.c
index 5da7a42..b2b4f54 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2xxx_3xxx_ipblock_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2xxx_3xxx_ipblock_data.c
@@ -85,204 +85,31 @@ struct omap_hwmod_class omap2_venc_hwmod_class = {
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
@@ -290,17 +117,7 @@ struct omap_hwmod_irq_info omap2_dma_system_irqs[] = {
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
@@ -317,9 +134,3 @@ struct omap_hwmod_class omap2_hdq1w_class = {
 	.sysc	= &omap2_hdq1w_sysc,
 	.reset	= &omap_hdq1w_reset,
 };
-
-struct omap_hwmod_irq_info omap2_hdq1w_mpu_irqs[] = {
-	{ .irq = 58 + OMAP_INTC_START, },
-	{ .irq = -1 },
-};
-
diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index 9e56fab..9fbc3c1 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -55,16 +55,10 @@
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
 
@@ -97,14 +91,9 @@ static struct omap_hwmod omap3xxx_l4_sec_hwmod = {
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
@@ -130,7 +119,7 @@ static struct omap_hwmod omap3xxx_iva_hwmod = {
 			.module_bit = OMAP3430_CM_FCLKEN_IVA2_EN_IVA2_SHIFT,
 			.idlest_reg_id = 1,
 			.idlest_idle_bit = OMAP3430_ST_IVA2_SHIFT,
-		}
+		},
 	},
 };
 
@@ -199,7 +188,6 @@ static struct omap_timer_capability_dev_attr capability_dsp_pwm_dev_attr = {
 /* timer1 */
 static struct omap_hwmod omap3xxx_timer1_hwmod = {
 	.name		= "timer1",
-	.mpu_irqs	= omap2_timer1_mpu_irqs,
 	.main_clk	= "gpt1_fck",
 	.prcm		= {
 		.omap2 = {
@@ -218,7 +206,6 @@ static struct omap_hwmod omap3xxx_timer1_hwmod = {
 /* timer2 */
 static struct omap_hwmod omap3xxx_timer2_hwmod = {
 	.name		= "timer2",
-	.mpu_irqs	= omap2_timer2_mpu_irqs,
 	.main_clk	= "gpt2_fck",
 	.prcm		= {
 		.omap2 = {
@@ -236,7 +223,6 @@ static struct omap_hwmod omap3xxx_timer2_hwmod = {
 /* timer3 */
 static struct omap_hwmod omap3xxx_timer3_hwmod = {
 	.name		= "timer3",
-	.mpu_irqs	= omap2_timer3_mpu_irqs,
 	.main_clk	= "gpt3_fck",
 	.prcm		= {
 		.omap2 = {
@@ -254,7 +240,6 @@ static struct omap_hwmod omap3xxx_timer3_hwmod = {
 /* timer4 */
 static struct omap_hwmod omap3xxx_timer4_hwmod = {
 	.name		= "timer4",
-	.mpu_irqs	= omap2_timer4_mpu_irqs,
 	.main_clk	= "gpt4_fck",
 	.prcm		= {
 		.omap2 = {
@@ -272,7 +257,6 @@ static struct omap_hwmod omap3xxx_timer4_hwmod = {
 /* timer5 */
 static struct omap_hwmod omap3xxx_timer5_hwmod = {
 	.name		= "timer5",
-	.mpu_irqs	= omap2_timer5_mpu_irqs,
 	.main_clk	= "gpt5_fck",
 	.prcm		= {
 		.omap2 = {
@@ -291,7 +275,6 @@ static struct omap_hwmod omap3xxx_timer5_hwmod = {
 /* timer6 */
 static struct omap_hwmod omap3xxx_timer6_hwmod = {
 	.name		= "timer6",
-	.mpu_irqs	= omap2_timer6_mpu_irqs,
 	.main_clk	= "gpt6_fck",
 	.prcm		= {
 		.omap2 = {
@@ -310,7 +293,6 @@ static struct omap_hwmod omap3xxx_timer6_hwmod = {
 /* timer7 */
 static struct omap_hwmod omap3xxx_timer7_hwmod = {
 	.name		= "timer7",
-	.mpu_irqs	= omap2_timer7_mpu_irqs,
 	.main_clk	= "gpt7_fck",
 	.prcm		= {
 		.omap2 = {
@@ -329,7 +311,6 @@ static struct omap_hwmod omap3xxx_timer7_hwmod = {
 /* timer8 */
 static struct omap_hwmod omap3xxx_timer8_hwmod = {
 	.name		= "timer8",
-	.mpu_irqs	= omap2_timer8_mpu_irqs,
 	.main_clk	= "gpt8_fck",
 	.prcm		= {
 		.omap2 = {
@@ -348,7 +329,6 @@ static struct omap_hwmod omap3xxx_timer8_hwmod = {
 /* timer9 */
 static struct omap_hwmod omap3xxx_timer9_hwmod = {
 	.name		= "timer9",
-	.mpu_irqs	= omap2_timer9_mpu_irqs,
 	.main_clk	= "gpt9_fck",
 	.prcm		= {
 		.omap2 = {
@@ -367,7 +347,6 @@ static struct omap_hwmod omap3xxx_timer9_hwmod = {
 /* timer10 */
 static struct omap_hwmod omap3xxx_timer10_hwmod = {
 	.name		= "timer10",
-	.mpu_irqs	= omap2_timer10_mpu_irqs,
 	.main_clk	= "gpt10_fck",
 	.prcm		= {
 		.omap2 = {
@@ -386,7 +365,6 @@ static struct omap_hwmod omap3xxx_timer10_hwmod = {
 /* timer11 */
 static struct omap_hwmod omap3xxx_timer11_hwmod = {
 	.name		= "timer11",
-	.mpu_irqs	= omap2_timer11_mpu_irqs,
 	.main_clk	= "gpt11_fck",
 	.prcm		= {
 		.omap2 = {
@@ -403,14 +381,9 @@ static struct omap_hwmod omap3xxx_timer11_hwmod = {
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
@@ -487,8 +460,6 @@ static struct omap_hwmod omap3xxx_wd_timer2_hwmod = {
 /* UART1 */
 static struct omap_hwmod omap3xxx_uart1_hwmod = {
 	.name		= "uart1",
-	.mpu_irqs	= omap2_uart1_mpu_irqs,
-	.sdma_reqs	= omap2_uart1_sdma_reqs,
 	.main_clk	= "uart1_fck",
 	.flags		= DEBUG_TI81XXUART1_FLAGS | HWMOD_SWSUP_SIDLE_ACT,
 	.prcm		= {
@@ -506,8 +477,6 @@ static struct omap_hwmod omap3xxx_uart1_hwmod = {
 /* UART2 */
 static struct omap_hwmod omap3xxx_uart2_hwmod = {
 	.name		= "uart2",
-	.mpu_irqs	= omap2_uart2_mpu_irqs,
-	.sdma_reqs	= omap2_uart2_sdma_reqs,
 	.main_clk	= "uart2_fck",
 	.flags		= DEBUG_TI81XXUART2_FLAGS | HWMOD_SWSUP_SIDLE_ACT,
 	.prcm		= {
@@ -525,8 +494,6 @@ static struct omap_hwmod omap3xxx_uart2_hwmod = {
 /* UART3 */
 static struct omap_hwmod omap3xxx_uart3_hwmod = {
 	.name		= "uart3",
-	.mpu_irqs	= omap2_uart3_mpu_irqs,
-	.sdma_reqs	= omap2_uart3_sdma_reqs,
 	.main_clk	= "uart3_fck",
 	.flags		= DEBUG_OMAP3UART3_FLAGS | DEBUG_TI81XXUART3_FLAGS |
 				HWMOD_SWSUP_SIDLE_ACT,
@@ -543,21 +510,10 @@ static struct omap_hwmod omap3xxx_uart3_hwmod = {
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
 	.flags		= DEBUG_OMAP3UART4_FLAGS | HWMOD_SWSUP_SIDLE_ACT,
 	.prcm		= {
@@ -572,16 +528,7 @@ static struct omap_hwmod omap36xx_uart4_hwmod = {
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
@@ -599,8 +546,6 @@ static struct omap_hwmod_opt_clk am35xx_uart4_opt_clks[] = {
 
 static struct omap_hwmod am35xx_uart4_hwmod = {
 	.name		= "uart4",
-	.mpu_irqs	= am35xx_uart4_mpu_irqs,
-	.sdma_reqs	= am35xx_uart4_sdma_reqs,
 	.main_clk	= "uart4_fck",
 	.prcm		= {
 		.omap2 = {
@@ -627,7 +572,7 @@ static struct omap_hwmod_class i2c_class = {
 static struct omap_hwmod_dma_info omap3xxx_dss_sdma_chs[] = {
 	{ .name = "dispc", .dma_req = 5 },
 	{ .name = "dsi1", .dma_req = 74 },
-	{ .dma_req = -1 }
+	{ .dma_req = -1, },
 };
 
 /* dss */
@@ -716,7 +661,7 @@ static struct omap_hwmod omap3xxx_dss_dispc_hwmod = {
 		},
 	},
 	.flags		= HWMOD_NO_IDLEST,
-	.dev_attr	= &omap2_3_dss_dispc_dev_attr
+	.dev_attr	= &omap2_3_dss_dispc_dev_attr,
 };
 
 /*
@@ -730,7 +675,7 @@ static struct omap_hwmod_class omap3xxx_dsi_hwmod_class = {
 
 static struct omap_hwmod_irq_info omap3xxx_dsi1_irqs[] = {
 	{ .irq = 25 + OMAP_INTC_START, },
-	{ .irq = -1 },
+	{ .irq = -1, },
 };
 
 /* dss_dsi1 */
@@ -805,8 +750,6 @@ static struct omap_i2c_dev_attr i2c1_dev_attr = {
 static struct omap_hwmod omap3xxx_i2c1_hwmod = {
 	.name		= "i2c1",
 	.flags		= HWMOD_16BIT_REG | HWMOD_SET_DEFAULT_CLOCKACT,
-	.mpu_irqs	= omap2_i2c1_mpu_irqs,
-	.sdma_reqs	= omap2_i2c1_sdma_reqs,
 	.main_clk	= "i2c1_fck",
 	.prcm		= {
 		.omap2 = {
@@ -830,8 +773,6 @@ static struct omap_i2c_dev_attr i2c2_dev_attr = {
 static struct omap_hwmod omap3xxx_i2c2_hwmod = {
 	.name		= "i2c2",
 	.flags		= HWMOD_16BIT_REG | HWMOD_SET_DEFAULT_CLOCKACT,
-	.mpu_irqs	= omap2_i2c2_mpu_irqs,
-	.sdma_reqs	= omap2_i2c2_sdma_reqs,
 	.main_clk	= "i2c2_fck",
 	.prcm		= {
 		.omap2 = {
@@ -852,22 +793,11 @@ static struct omap_i2c_dev_attr i2c3_dev_attr = {
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
@@ -918,7 +848,6 @@ static struct omap_hwmod_opt_clk gpio1_opt_clks[] = {
 static struct omap_hwmod omap3xxx_gpio1_hwmod = {
 	.name		= "gpio1",
 	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
-	.mpu_irqs	= omap2_gpio1_irqs,
 	.main_clk	= "gpio1_ick",
 	.opt_clks	= gpio1_opt_clks,
 	.opt_clks_cnt	= ARRAY_SIZE(gpio1_opt_clks),
@@ -943,7 +872,6 @@ static struct omap_hwmod_opt_clk gpio2_opt_clks[] = {
 static struct omap_hwmod omap3xxx_gpio2_hwmod = {
 	.name		= "gpio2",
 	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
-	.mpu_irqs	= omap2_gpio2_irqs,
 	.main_clk	= "gpio2_ick",
 	.opt_clks	= gpio2_opt_clks,
 	.opt_clks_cnt	= ARRAY_SIZE(gpio2_opt_clks),
@@ -968,7 +896,6 @@ static struct omap_hwmod_opt_clk gpio3_opt_clks[] = {
 static struct omap_hwmod omap3xxx_gpio3_hwmod = {
 	.name		= "gpio3",
 	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
-	.mpu_irqs	= omap2_gpio3_irqs,
 	.main_clk	= "gpio3_ick",
 	.opt_clks	= gpio3_opt_clks,
 	.opt_clks_cnt	= ARRAY_SIZE(gpio3_opt_clks),
@@ -993,7 +920,6 @@ static struct omap_hwmod_opt_clk gpio4_opt_clks[] = {
 static struct omap_hwmod omap3xxx_gpio4_hwmod = {
 	.name		= "gpio4",
 	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
-	.mpu_irqs	= omap2_gpio4_irqs,
 	.main_clk	= "gpio4_ick",
 	.opt_clks	= gpio4_opt_clks,
 	.opt_clks_cnt	= ARRAY_SIZE(gpio4_opt_clks),
@@ -1011,10 +937,6 @@ static struct omap_hwmod omap3xxx_gpio4_hwmod = {
 };
 
 /* gpio5 */
-static struct omap_hwmod_irq_info omap3xxx_gpio5_irqs[] = {
-	{ .irq = 33 + OMAP_INTC_START, }, /* INT_34XX_GPIO_BANK5 */
-	{ .irq = -1 },
-};
 
 static struct omap_hwmod_opt_clk gpio5_opt_clks[] = {
 	{ .role = "dbclk", .clk = "gpio5_dbck", },
@@ -1023,7 +945,6 @@ static struct omap_hwmod_opt_clk gpio5_opt_clks[] = {
 static struct omap_hwmod omap3xxx_gpio5_hwmod = {
 	.name		= "gpio5",
 	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
-	.mpu_irqs	= omap3xxx_gpio5_irqs,
 	.main_clk	= "gpio5_ick",
 	.opt_clks	= gpio5_opt_clks,
 	.opt_clks_cnt	= ARRAY_SIZE(gpio5_opt_clks),
@@ -1041,10 +962,6 @@ static struct omap_hwmod omap3xxx_gpio5_hwmod = {
 };
 
 /* gpio6 */
-static struct omap_hwmod_irq_info omap3xxx_gpio6_irqs[] = {
-	{ .irq = 34 + OMAP_INTC_START, }, /* INT_34XX_GPIO_BANK6 */
-	{ .irq = -1 },
-};
 
 static struct omap_hwmod_opt_clk gpio6_opt_clks[] = {
 	{ .role = "dbclk", .clk = "gpio6_dbck", },
@@ -1053,7 +970,6 @@ static struct omap_hwmod_opt_clk gpio6_opt_clks[] = {
 static struct omap_hwmod omap3xxx_gpio6_hwmod = {
 	.name		= "gpio6",
 	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
-	.mpu_irqs	= omap3xxx_gpio6_irqs,
 	.main_clk	= "gpio6_ick",
 	.opt_clks	= gpio6_opt_clks,
 	.opt_clks_cnt	= ARRAY_SIZE(gpio6_opt_clks),
@@ -1146,18 +1062,10 @@ static struct omap_hwmod_opt_clk mcbsp234_opt_clks[] = {
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
@@ -1173,12 +1081,6 @@ static struct omap_hwmod omap3xxx_mcbsp1_hwmod = {
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
@@ -1187,8 +1089,6 @@ static struct omap_mcbsp_dev_attr omap34xx_mcbsp2_dev_attr = {
 static struct omap_hwmod omap3xxx_mcbsp2_hwmod = {
 	.name		= "mcbsp2",
 	.class		= &omap3xxx_mcbsp_hwmod_class,
-	.mpu_irqs	= omap3xxx_mcbsp2_irqs,
-	.sdma_reqs	= omap2_mcbsp2_sdma_reqs,
 	.main_clk	= "mcbsp2_fck",
 	.prcm		= {
 		.omap2 = {
@@ -1205,12 +1105,6 @@ static struct omap_hwmod omap3xxx_mcbsp2_hwmod = {
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
@@ -1219,8 +1113,6 @@ static struct omap_mcbsp_dev_attr omap34xx_mcbsp3_dev_attr = {
 static struct omap_hwmod omap3xxx_mcbsp3_hwmod = {
 	.name		= "mcbsp3",
 	.class		= &omap3xxx_mcbsp_hwmod_class,
-	.mpu_irqs	= omap3xxx_mcbsp3_irqs,
-	.sdma_reqs	= omap2_mcbsp3_sdma_reqs,
 	.main_clk	= "mcbsp3_fck",
 	.prcm		= {
 		.omap2 = {
@@ -1237,24 +1129,11 @@ static struct omap_hwmod omap3xxx_mcbsp3_hwmod = {
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
@@ -1270,24 +1149,11 @@ static struct omap_hwmod omap3xxx_mcbsp4_hwmod = {
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
@@ -1315,15 +1181,10 @@ static struct omap_hwmod_class omap3xxx_mcbsp_sidetone_hwmod_class = {
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
 	.main_clk	= "mcbsp2_fck",
 	.prcm		= {
 		.omap2 = {
@@ -1337,15 +1198,10 @@ static struct omap_hwmod omap3xxx_mcbsp2_sidetone_hwmod = {
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
 	.main_clk	= "mcbsp3_fck",
 	.prcm		= {
 		.omap2 = {
@@ -1400,10 +1256,6 @@ static struct omap_smartreflex_dev_attr sr1_dev_attr = {
 	.sensor_voltdm_name   = "mpu_iva",
 };
 
-static struct omap_hwmod_irq_info omap3_smartreflex_mpu_irqs[] = {
-	{ .irq = 18 + OMAP_INTC_START, },
-	{ .irq = -1 },
-};
 
 static struct omap_hwmod omap34xx_sr1_hwmod = {
 	.name		= "smartreflex_mpu_iva",
@@ -1419,7 +1271,6 @@ static struct omap_hwmod omap34xx_sr1_hwmod = {
 		},
 	},
 	.dev_attr	= &sr1_dev_attr,
-	.mpu_irqs	= omap3_smartreflex_mpu_irqs,
 	.flags		= HWMOD_SET_DEFAULT_CLOCKACT,
 };
 
@@ -1437,7 +1288,6 @@ static struct omap_hwmod omap36xx_sr1_hwmod = {
 		},
 	},
 	.dev_attr	= &sr1_dev_attr,
-	.mpu_irqs	= omap3_smartreflex_mpu_irqs,
 };
 
 /* SR2 */
@@ -1445,10 +1295,6 @@ static struct omap_smartreflex_dev_attr sr2_dev_attr = {
 	.sensor_voltdm_name	= "core",
 };
 
-static struct omap_hwmod_irq_info omap3_smartreflex_core_irqs[] = {
-	{ .irq = 19 + OMAP_INTC_START, },
-	{ .irq = -1 },
-};
 
 static struct omap_hwmod omap34xx_sr2_hwmod = {
 	.name		= "smartreflex_core",
@@ -1464,7 +1310,6 @@ static struct omap_hwmod omap34xx_sr2_hwmod = {
 		},
 	},
 	.dev_attr	= &sr2_dev_attr,
-	.mpu_irqs	= omap3_smartreflex_core_irqs,
 	.flags		= HWMOD_SET_DEFAULT_CLOCKACT,
 };
 
@@ -1482,7 +1327,6 @@ static struct omap_hwmod omap36xx_sr2_hwmod = {
 		},
 	},
 	.dev_attr	= &sr2_dev_attr,
-	.mpu_irqs	= omap3_smartreflex_core_irqs,
 };
 
 /*
@@ -1517,15 +1361,10 @@ static struct omap_mbox_pdata omap3xxx_mailbox_attrs = {
 	.info		= omap3xxx_mailbox_info,
 };
 
-static struct omap_hwmod_irq_info omap3xxx_mailbox_irqs[] = {
-	{ .irq = 26 + OMAP_INTC_START, },
-	{ .irq = -1 },
-};
 
 static struct omap_hwmod omap3xxx_mailbox_hwmod = {
 	.name		= "mailbox",
 	.class		= &omap3xxx_mailbox_hwmod_class,
-	.mpu_irqs	= omap3xxx_mailbox_irqs,
 	.main_clk	= "mailboxes_ick",
 	.prcm		= {
 		.omap2 = {
@@ -1569,8 +1408,6 @@ static struct omap2_mcspi_dev_attr omap_mcspi1_dev_attr = {
 
 static struct omap_hwmod omap34xx_mcspi1 = {
 	.name		= "mcspi1",
-	.mpu_irqs	= omap2_mcspi1_mpu_irqs,
-	.sdma_reqs	= omap2_mcspi1_sdma_reqs,
 	.main_clk	= "mcspi1_fck",
 	.prcm		= {
 		.omap2 = {
@@ -1592,8 +1429,6 @@ static struct omap2_mcspi_dev_attr omap_mcspi2_dev_attr = {
 
 static struct omap_hwmod omap34xx_mcspi2 = {
 	.name		= "mcspi2",
-	.mpu_irqs	= omap2_mcspi2_mpu_irqs,
-	.sdma_reqs	= omap2_mcspi2_sdma_reqs,
 	.main_clk	= "mcspi2_fck",
 	.prcm		= {
 		.omap2 = {
@@ -1609,18 +1444,7 @@ static struct omap_hwmod omap34xx_mcspi2 = {
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
@@ -1628,8 +1452,6 @@ static struct omap2_mcspi_dev_attr omap_mcspi3_dev_attr = {
 
 static struct omap_hwmod omap34xx_mcspi3 = {
 	.name		= "mcspi3",
-	.mpu_irqs	= omap34xx_mcspi3_mpu_irqs,
-	.sdma_reqs	= omap34xx_mcspi3_sdma_reqs,
 	.main_clk	= "mcspi3_fck",
 	.prcm		= {
 		.omap2 = {
@@ -1645,16 +1467,7 @@ static struct omap_hwmod omap34xx_mcspi3 = {
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
@@ -1662,8 +1475,6 @@ static struct omap2_mcspi_dev_attr omap_mcspi4_dev_attr = {
 
 static struct omap_hwmod omap34xx_mcspi4 = {
 	.name		= "mcspi4",
-	.mpu_irqs	= omap34xx_mcspi4_mpu_irqs,
-	.sdma_reqs	= omap34xx_mcspi4_sdma_reqs,
 	.main_clk	= "mcspi4_fck",
 	.prcm		= {
 		.omap2 = {
@@ -1697,16 +1508,9 @@ static struct omap_hwmod_class usbotg_class = {
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
@@ -1715,7 +1519,7 @@ static struct omap_hwmod omap3xxx_usbhsotg_hwmod = {
 			.module_offs = CORE_MOD,
 			.idlest_reg_id = 1,
 			.idlest_idle_bit = OMAP3430ES2_ST_HSOTGUSB_IDLE_SHIFT,
-			.idlest_stdby_bit = OMAP3430ES2_ST_HSOTGUSB_STDBY_SHIFT
+			.idlest_stdby_bit = OMAP3430ES2_ST_HSOTGUSB_STDBY_SHIFT,
 		},
 	},
 	.class		= &usbotg_class,
@@ -1735,10 +1539,6 @@ static struct omap_hwmod omap3xxx_usbhsotg_hwmod = {
 };
 
 /* usb_otg_hs */
-static struct omap_hwmod_irq_info am35xx_usbhsotg_mpu_irqs[] = {
-	{ .name = "mc", .irq = 71 + OMAP_INTC_START, },
-	{ .irq = -1 },
-};
 
 static struct omap_hwmod_class am35xx_usbotg_class = {
 	.name = "am35xx_usbotg",
@@ -1746,7 +1546,6 @@ static struct omap_hwmod_class am35xx_usbotg_class = {
 
 static struct omap_hwmod am35xx_usbhsotg_hwmod = {
 	.name		= "am35x_otg_hs",
-	.mpu_irqs	= am35xx_usbhsotg_mpu_irqs,
 	.main_clk	= "hsotgusb_fck",
 	.class		= &am35xx_usbotg_class,
 	.flags		= HWMOD_NO_IDLEST,
@@ -1771,16 +1570,7 @@ static struct omap_hwmod_class omap34xx_mmc_class = {
 
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
@@ -1798,8 +1588,6 @@ static struct omap_mmc_dev_attr mmc1_pre_es3_dev_attr = {
 
 static struct omap_hwmod omap3xxx_pre_es3_mmc1_hwmod = {
 	.name		= "mmc1",
-	.mpu_irqs	= omap34xx_mmc1_mpu_irqs,
-	.sdma_reqs	= omap34xx_mmc1_sdma_reqs,
 	.opt_clks	= omap34xx_mmc1_opt_clks,
 	.opt_clks_cnt	= ARRAY_SIZE(omap34xx_mmc1_opt_clks),
 	.main_clk	= "mmchs1_fck",
@@ -1818,8 +1606,6 @@ static struct omap_hwmod omap3xxx_pre_es3_mmc1_hwmod = {
 
 static struct omap_hwmod omap3xxx_es3plus_mmc1_hwmod = {
 	.name		= "mmc1",
-	.mpu_irqs	= omap34xx_mmc1_mpu_irqs,
-	.sdma_reqs	= omap34xx_mmc1_sdma_reqs,
 	.opt_clks	= omap34xx_mmc1_opt_clks,
 	.opt_clks_cnt	= ARRAY_SIZE(omap34xx_mmc1_opt_clks),
 	.main_clk	= "mmchs1_fck",
@@ -1838,16 +1624,7 @@ static struct omap_hwmod omap3xxx_es3plus_mmc1_hwmod = {
 
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
@@ -1860,8 +1637,6 @@ static struct omap_mmc_dev_attr mmc2_pre_es3_dev_attr = {
 
 static struct omap_hwmod omap3xxx_pre_es3_mmc2_hwmod = {
 	.name		= "mmc2",
-	.mpu_irqs	= omap34xx_mmc2_mpu_irqs,
-	.sdma_reqs	= omap34xx_mmc2_sdma_reqs,
 	.opt_clks	= omap34xx_mmc2_opt_clks,
 	.opt_clks_cnt	= ARRAY_SIZE(omap34xx_mmc2_opt_clks),
 	.main_clk	= "mmchs2_fck",
@@ -1880,8 +1655,6 @@ static struct omap_hwmod omap3xxx_pre_es3_mmc2_hwmod = {
 
 static struct omap_hwmod omap3xxx_es3plus_mmc2_hwmod = {
 	.name		= "mmc2",
-	.mpu_irqs	= omap34xx_mmc2_mpu_irqs,
-	.sdma_reqs	= omap34xx_mmc2_sdma_reqs,
 	.opt_clks	= omap34xx_mmc2_opt_clks,
 	.opt_clks_cnt	= ARRAY_SIZE(omap34xx_mmc2_opt_clks),
 	.main_clk	= "mmchs2_fck",
@@ -1899,16 +1672,7 @@ static struct omap_hwmod omap3xxx_es3plus_mmc2_hwmod = {
 
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
@@ -1916,8 +1680,6 @@ static struct omap_hwmod_opt_clk omap34xx_mmc3_opt_clks[] = {
 
 static struct omap_hwmod omap3xxx_mmc3_hwmod = {
 	.name		= "mmc3",
-	.mpu_irqs	= omap34xx_mmc3_mpu_irqs,
-	.sdma_reqs	= omap34xx_mmc3_sdma_reqs,
 	.opt_clks	= omap34xx_mmc3_opt_clks,
 	.opt_clks_cnt	= ARRAY_SIZE(omap34xx_mmc3_opt_clks),
 	.main_clk	= "mmchs3_fck",
@@ -1958,17 +1720,11 @@ static struct omap_hwmod_opt_clk omap3xxx_usb_host_hs_opt_clks[] = {
 	  { .role = "ehci_logic_fck", .clk = "usbhost_120m_fck", },
 };
 
-static struct omap_hwmod_irq_info omap3xxx_usb_host_hs_irqs[] = {
-	{ .name = "ohci-irq", .irq = 76 + OMAP_INTC_START, },
-	{ .name = "ehci-irq", .irq = 77 + OMAP_INTC_START, },
-	{ .irq = -1 },
-};
 
 static struct omap_hwmod omap3xxx_usb_host_hs_hwmod = {
 	.name		= "usb_host_hs",
 	.class		= &omap3xxx_usb_host_hs_hwmod_class,
 	.clkdm_name	= "l3_init_clkdm",
-	.mpu_irqs	= omap3xxx_usb_host_hs_irqs,
 	.main_clk	= "usbhost_48m_fck",
 	.prcm = {
 		.omap2 = {
@@ -2052,16 +1808,11 @@ static struct omap_hwmod_class omap3xxx_usb_tll_hs_hwmod_class = {
 	.sysc = &omap3xxx_usb_tll_hs_sysc,
 };
 
-static struct omap_hwmod_irq_info omap3xxx_usb_tll_hs_irqs[] = {
-	{ .name = "tll-irq", .irq = 78 + OMAP_INTC_START, },
-	{ .irq = -1 },
-};
 
 static struct omap_hwmod omap3xxx_usb_tll_hs_hwmod = {
 	.name		= "usb_tll_hs",
 	.class		= &omap3xxx_usb_tll_hs_hwmod_class,
 	.clkdm_name	= "l3_init_clkdm",
-	.mpu_irqs	= omap3xxx_usb_tll_hs_irqs,
 	.main_clk	= "usbtll_fck",
 	.prcm = {
 		.omap2 = {
@@ -2076,7 +1827,6 @@ static struct omap_hwmod omap3xxx_usb_tll_hs_hwmod = {
 
 static struct omap_hwmod omap3xxx_hdq1w_hwmod = {
 	.name		= "hdq1w",
-	.mpu_irqs	= omap2_hdq1w_mpu_irqs,
 	.main_clk	= "hdq_fck",
 	.prcm		= {
 		.omap2 = {
@@ -2171,16 +1921,11 @@ static struct omap_hwmod_class omap3xxx_gpmc_hwmod_class = {
 	.sysc	= &omap3xxx_gpmc_sysc,
 };
 
-static struct omap_hwmod_irq_info omap3xxx_gpmc_irqs[] = {
-	{ .irq = 20 },
-	{ .irq = -1 }
-};
 
 static struct omap_hwmod omap3xxx_gpmc_hwmod = {
 	.name		= "gpmc",
 	.class		= &omap3xxx_gpmc_hwmod_class,
 	.clkdm_name	= "core_l3_clkdm",
-	.mpu_irqs	= omap3xxx_gpmc_irqs,
 	.main_clk	= "gpmc_fck",
 	/*
 	 * XXX HWMOD_INIT_NO_RESET should not be needed for this IP
@@ -2212,37 +1957,19 @@ static struct omap_hwmod_ocp_if omap3xxx_l3_main__l4_per = {
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
 
@@ -2260,7 +1987,7 @@ static struct omap_hwmod_ocp_if omap3xxx_dss__l3 = {
 		.omap2 = {
 			.l3_perm_bit  = OMAP3_L3_CORE_FW_INIT_ID_DSS,
 			.flags	= OMAP_FIREWALL_L3,
-		}
+		},
 	},
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
@@ -2301,18 +2028,16 @@ static struct omap_hwmod_ocp_if omap3xxx_l4_core__pre_es3_mmc1 = {
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
@@ -2320,126 +2045,70 @@ static struct omap_hwmod_ocp_if omap3xxx_l4_core__pre_es3_mmc2 = {
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
 
@@ -2448,13 +2117,12 @@ static struct omap_hwmod_ocp_if omap3_l4_core__i2c1 = {
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
@@ -2464,57 +2132,38 @@ static struct omap_hwmod_ocp_if omap3_l4_core__i2c2 = {
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
 
@@ -2522,25 +2171,15 @@ static struct omap_hwmod_ocp_if omap36xx_l4_core__sr1 = {
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
 
@@ -2548,43 +2187,24 @@ static struct omap_hwmod_ocp_if omap36xx_l4_core__sr2 = {
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
 
@@ -2603,165 +2223,84 @@ static struct omap_hwmod_ocp_if omap3xxx_l3__iva = {
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
 
@@ -2770,7 +2309,6 @@ static struct omap_hwmod_ocp_if omap3xxx_l4_core__timer10 = {
 	.master		= &omap3xxx_l4_core_hwmod,
 	.slave		= &omap3xxx_timer10_hwmod,
 	.clk		= "gpt10_ick",
-	.addr		= omap2_timer10_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
@@ -2779,43 +2317,24 @@ static struct omap_hwmod_ocp_if omap3xxx_l4_core__timer11 = {
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
 
@@ -2830,7 +2349,7 @@ static struct omap_hwmod_ocp_if omap3430es1_l4_core__dss = {
 			.l4_fw_region  = OMAP3ES1_L4_CORE_FW_DSS_CORE_REGION,
 			.l4_prot_group = OMAP3_L4_CORE_FW_DSS_PROT_GROUP,
 			.flags	= OMAP_FIREWALL_L4,
-		}
+		},
 	},
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
@@ -2845,7 +2364,7 @@ static struct omap_hwmod_ocp_if omap3xxx_l4_core__dss = {
 			.l4_fw_region  = OMAP3_L4_CORE_FW_DSS_CORE_REGION,
 			.l4_prot_group = OMAP3_L4_CORE_FW_DSS_PROT_GROUP,
 			.flags	= OMAP_FIREWALL_L4,
-		}
+		},
 	},
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
@@ -2861,7 +2380,7 @@ static struct omap_hwmod_ocp_if omap3xxx_l4_core__dss_dispc = {
 			.l4_fw_region  = OMAP3_L4_CORE_FW_DSS_DISPC_REGION,
 			.l4_prot_group = OMAP3_L4_CORE_FW_DSS_PROT_GROUP,
 			.flags	= OMAP_FIREWALL_L4,
-		}
+		},
 	},
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
@@ -2870,9 +2389,9 @@ static struct omap_hwmod_addr_space omap3xxx_dss_dsi1_addrs[] = {
 	{
 		.pa_start	= 0x4804FC00,
 		.pa_end		= 0x4804FFFF,
-		.flags		= ADDR_TYPE_RT
+		.flags		= ADDR_TYPE_RT,
 	},
-	{ }
+	{ },
 };
 
 /* l4_core -> dss_dsi1 */
@@ -2886,7 +2405,7 @@ static struct omap_hwmod_ocp_if omap3xxx_l4_core__dss_dsi1 = {
 			.l4_fw_region  = OMAP3_L4_CORE_FW_DSS_DSI_REGION,
 			.l4_prot_group = OMAP3_L4_CORE_FW_DSS_PROT_GROUP,
 			.flags	= OMAP_FIREWALL_L4,
-		}
+		},
 	},
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
@@ -2902,7 +2421,7 @@ static struct omap_hwmod_ocp_if omap3xxx_l4_core__dss_rfbi = {
 			.l4_fw_region  = OMAP3_L4_CORE_FW_DSS_RFBI_REGION,
 			.l4_prot_group = OMAP3_L4_CORE_FW_DSS_PROT_GROUP ,
 			.flags	= OMAP_FIREWALL_L4,
-		}
+		},
 	},
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
@@ -2918,60 +2437,33 @@ static struct omap_hwmod_ocp_if omap3xxx_l4_core__dss_venc = {
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
 
@@ -3005,32 +2497,18 @@ static struct omap_mmu_dev_attr mmu_isp_dev_attr = {
 };
 
 static struct omap_hwmod omap3xxx_mmu_isp_hwmod;
-static struct omap_hwmod_irq_info omap3xxx_mmu_isp_irqs[] = {
-	{ .irq = 24 },
-	{ .irq = -1 }
-};
 
-static struct omap_hwmod_addr_space omap3xxx_mmu_isp_addrs[] = {
-	{
-		.pa_start	= 0x480bd400,
-		.pa_end		= 0x480bd47f,
-		.flags		= ADDR_TYPE_RT,
-	},
-	{ }
-};
 
 /* l4_core -> mmu isp */
 static struct omap_hwmod_ocp_if omap3xxx_l4_core__mmu_isp = {
 	.master		= &omap3xxx_l4_core_hwmod,
 	.slave		= &omap3xxx_mmu_isp_hwmod,
-	.addr		= omap3xxx_mmu_isp_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
 static struct omap_hwmod omap3xxx_mmu_isp_hwmod = {
 	.name		= "mmu_isp",
 	.class		= &omap3xxx_mmu_hwmod_class,
-	.mpu_irqs	= omap3xxx_mmu_isp_irqs,
 	.main_clk	= "cam_ick",
 	.dev_attr	= &mmu_isp_dev_attr,
 	.flags		= HWMOD_NO_IDLEST,
@@ -3047,36 +2525,22 @@ static struct omap_mmu_dev_attr mmu_iva_dev_attr = {
 };
 
 static struct omap_hwmod omap3xxx_mmu_iva_hwmod;
-static struct omap_hwmod_irq_info omap3xxx_mmu_iva_irqs[] = {
-	{ .irq = 28 },
-	{ .irq = -1 }
-};
 
 static struct omap_hwmod_rst_info omap3xxx_mmu_iva_resets[] = {
 	{ .name = "mmu", .rst_shift = 1, .st_shift = 9 },
 };
 
-static struct omap_hwmod_addr_space omap3xxx_mmu_iva_addrs[] = {
-	{
-		.pa_start	= 0x5d000000,
-		.pa_end		= 0x5d00007f,
-		.flags		= ADDR_TYPE_RT,
-	},
-	{ }
-};
 
 /* l3_main -> iva mmu */
 static struct omap_hwmod_ocp_if omap3xxx_l3_main__mmu_iva = {
 	.master		= &omap3xxx_l3_main_hwmod,
 	.slave		= &omap3xxx_mmu_iva_hwmod,
-	.addr		= omap3xxx_mmu_iva_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
 static struct omap_hwmod omap3xxx_mmu_iva_hwmod = {
 	.name		= "mmu_iva",
 	.class		= &omap3xxx_mmu_hwmod_class,
-	.mpu_irqs	= omap3xxx_mmu_iva_irqs,
 	.rst_lines	= omap3xxx_mmu_iva_resets,
 	.rst_lines_cnt	= ARRAY_SIZE(omap3xxx_mmu_iva_resets),
 	.main_clk	= "iva2_ck",
@@ -3092,53 +2556,26 @@ static struct omap_hwmod omap3xxx_mmu_iva_hwmod = {
 #endif
 
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
 
@@ -3154,9 +2591,9 @@ static struct omap_hwmod_addr_space omap3xxx_dma_system_addrs[] = {
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
@@ -3168,153 +2605,74 @@ static struct omap_hwmod_ocp_if omap3xxx_l4_core__dma_system = {
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
 
-static struct omap_hwmod_addr_space omap3xxx_mailbox_addrs[] = {
-	{
-		.pa_start	= 0x48094000,
-		.pa_end		= 0x480941ff,
-		.flags		= ADDR_TYPE_RT,
-	},
-	{ }
-};
 
 /* l4_core -> mailbox */
 static struct omap_hwmod_ocp_if omap3xxx_l4_core__mailbox = {
 	.master		= &omap3xxx_l4_core_hwmod,
 	.slave		= &omap3xxx_mailbox_hwmod,
-	.addr		= omap3xxx_mailbox_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
@@ -3323,7 +2681,6 @@ static struct omap_hwmod_ocp_if omap34xx_l4_core__mcspi1 = {
 	.master		= &omap3xxx_l4_core_hwmod,
 	.slave		= &omap34xx_mcspi1,
 	.clk		= "mcspi1_ick",
-	.addr		= omap2_mcspi1_addr_space,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
@@ -3332,7 +2689,6 @@ static struct omap_hwmod_ocp_if omap34xx_l4_core__mcspi2 = {
 	.master		= &omap3xxx_l4_core_hwmod,
 	.slave		= &omap34xx_mcspi2,
 	.clk		= "mcspi2_ick",
-	.addr		= omap2_mcspi2_addr_space,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
@@ -3341,25 +2697,15 @@ static struct omap_hwmod_ocp_if omap34xx_l4_core__mcspi3 = {
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
 
@@ -3370,49 +2716,19 @@ static struct omap_hwmod_ocp_if omap3xxx_usb_host_hs__l3_main_2 = {
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
 
@@ -3421,35 +2737,17 @@ static struct omap_hwmod_ocp_if omap3xxx_l4_core__hdq1w = {
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
 
@@ -3476,14 +2774,6 @@ static struct omap_hwmod_ocp_if am35xx_mdio__l3 = {
 	.user		= OCP_USER_MPU,
 };
 
-static struct omap_hwmod_addr_space am35xx_mdio_addrs[] = {
-	{
-		.pa_start	= AM35XX_IPSS_MDIO_BASE,
-		.pa_end		= AM35XX_IPSS_MDIO_BASE + SZ_4K - 1,
-		.flags		= ADDR_TYPE_RT,
-	},
-	{ }
-};
 
 /* l4_core -> davinci mdio  */
 /*
@@ -3495,17 +2785,9 @@ static struct omap_hwmod_ocp_if am35xx_l4_core__mdio = {
 	.master		= &omap3xxx_l4_core_hwmod,
 	.slave		= &am35xx_mdio_hwmod,
 	.clk		= "emac_fck",
-	.addr		= am35xx_mdio_addrs,
 	.user		= OCP_USER_MPU,
 };
 
-static struct omap_hwmod_irq_info am35xx_emac_mpu_irqs[] = {
-	{ .name = "rxthresh",	.irq = 67 + OMAP_INTC_START, },
-	{ .name = "rx_pulse",	.irq = 68 + OMAP_INTC_START, },
-	{ .name = "tx_pulse",	.irq = 69 + OMAP_INTC_START },
-	{ .name = "misc_pulse",	.irq = 70 + OMAP_INTC_START },
-	{ .irq = -1 },
-};
 
 static struct omap_hwmod_class am35xx_emac_class = {
 	.name = "davinci_emac",
@@ -3513,7 +2795,6 @@ static struct omap_hwmod_class am35xx_emac_class = {
 
 static struct omap_hwmod am35xx_emac_hwmod = {
 	.name		= "davinci_emac",
-	.mpu_irqs	= am35xx_emac_mpu_irqs,
 	.class		= &am35xx_emac_class,
 	/*
 	 * According to Mark Greer, the MPU will not return from WFI
@@ -3536,14 +2817,6 @@ static struct omap_hwmod_ocp_if am35xx_emac__l3 = {
 	.user		= OCP_USER_MPU,
 };
 
-static struct omap_hwmod_addr_space am35xx_emac_addrs[] = {
-	{
-		.pa_start	= AM35XX_IPSS_EMAC_BASE,
-		.pa_end		= AM35XX_IPSS_EMAC_BASE + 0x30000 - 1,
-		.flags		= ADDR_TYPE_RT,
-	},
-	{ }
-};
 
 /* l4_core -> davinci emac  */
 /*
@@ -3555,7 +2828,6 @@ static struct omap_hwmod_ocp_if am35xx_l4_core__emac = {
 	.master		= &omap3xxx_l4_core_hwmod,
 	.slave		= &am35xx_emac_hwmod,
 	.clk		= "emac_ick",
-	.addr		= am35xx_emac_addrs,
 	.user		= OCP_USER_MPU,
 };
 
@@ -3563,7 +2835,6 @@ static struct omap_hwmod_ocp_if omap3xxx_l3_main__gpmc = {
 	.master		= &omap3xxx_l3_main_hwmod,
 	.slave		= &omap3xxx_gpmc_hwmod,
 	.clk		= "core_l3_ick",
-	.addr		= omap3xxx_gpmc_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
@@ -3588,20 +2859,10 @@ static struct omap_hwmod_class omap3xxx_sham_class = {
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
@@ -3615,20 +2876,11 @@ static struct omap_hwmod omap3xxx_sham_hwmod = {
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
 
@@ -3654,15 +2906,9 @@ static struct omap_hwmod_class omap3xxx_aes_class = {
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
@@ -3676,20 +2922,11 @@ static struct omap_hwmod omap3xxx_aes_hwmod = {
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
 
@@ -3795,14 +3032,14 @@ static struct omap_hwmod_ocp_if *omap34xx_gp_hwmod_ocp_ifs[] __initdata = {
 	&omap3xxx_l4_sec__timer12,
 	&omap3xxx_l4_core__sham,
 	&omap3xxx_l4_core__aes,
-	NULL
+	NULL,
 };
 
 static struct omap_hwmod_ocp_if *omap36xx_gp_hwmod_ocp_ifs[] __initdata = {
 	&omap3xxx_l4_sec__timer12,
 	&omap3xxx_l4_core__sham,
 	&omap3xxx_l4_core__aes,
-	NULL
+	NULL,
 };
 
 static struct omap_hwmod_ocp_if *am35xx_gp_hwmod_ocp_ifs[] __initdata = {
@@ -3817,14 +3054,14 @@ static struct omap_hwmod_ocp_if *am35xx_gp_hwmod_ocp_ifs[] __initdata = {
 	 */
 	/* &omap3xxx_l4_core__sham, */
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
@@ -3836,21 +3073,21 @@ static struct omap_hwmod_ocp_if *omap3430es2plus_hwmod_ocp_ifs[] __initdata = {
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
@@ -3866,7 +3103,7 @@ static struct omap_hwmod_ocp_if *omap34xx_hwmod_ocp_ifs[] __initdata = {
 	&omap3xxx_l3_main__mmu_iva,
 #endif
 	&omap34xx_l4_core__ssi,
-	NULL
+	NULL,
 };
 
 /* 36xx-only hwmod links (all ES revisions) */
@@ -3891,7 +3128,7 @@ static struct omap_hwmod_ocp_if *omap36xx_hwmod_ocp_ifs[] __initdata = {
 #ifdef CONFIG_OMAP_IOMMU_IVA2
 	&omap3xxx_l3_main__mmu_iva,
 #endif
-	NULL
+	NULL,
 };
 
 static struct omap_hwmod_ocp_if *am35xx_hwmod_ocp_ifs[] __initdata = {
@@ -3910,7 +3147,7 @@ static struct omap_hwmod_ocp_if *am35xx_hwmod_ocp_ifs[] __initdata = {
 	&am35xx_l4_core__mdio,
 	&am35xx_emac__l3,
 	&am35xx_l4_core__emac,
-	NULL
+	NULL,
 };
 
 static struct omap_hwmod_ocp_if *omap3xxx_dss_hwmod_ocp_ifs[] __initdata = {
@@ -3918,7 +3155,7 @@ static struct omap_hwmod_ocp_if *omap3xxx_dss_hwmod_ocp_ifs[] __initdata = {
 	&omap3xxx_l4_core__dss_dsi1,
 	&omap3xxx_l4_core__dss_rfbi,
 	&omap3xxx_l4_core__dss_venc,
-	NULL
+	NULL,
 };
 
 int __init omap3xxx_hwmod_init(void)
-- 
1.8.1.1


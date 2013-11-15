From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 11/11] ARM: OMAP2+: Remove legacy hwmod entries for omap2
Date: Thu, 14 Nov 2013 16:09:58 -0800
Message-ID: <1384474198-20756-12-git-send-email-tony@atomide.com>
References: <1384474198-20756-1-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:42428 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754608Ab3KOAKL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 Nov 2013 19:10:11 -0500
In-Reply-To: <1384474198-20756-1-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>

These now come from device tree except for DSS and DMA that
still uses hwmod to initialize. That will get fixed when we
DSS gets device tree bindings and we move completely to the
dmaengine API.

Cc: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/omap_hwmod_2420_data.c         | 137 -----------
 arch/arm/mach-omap2/omap_hwmod_2430_data.c         | 266 ---------------------
 .../mach-omap2/omap_hwmod_2xxx_interconnect_data.c | 155 ------------
 arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c |  68 ------
 arch/arm/mach-omap2/omap_hwmod_common_data.h       |   5 -
 5 files changed, 631 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_2420_data.c b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
index d8b9d60..2f15979 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2420_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
@@ -108,8 +108,6 @@ static struct omap_i2c_dev_attr i2c_dev_attr = {
 /* I2C1 */
 static struct omap_hwmod omap2420_i2c1_hwmod = {
 	.name		= "i2c1",
-	.mpu_irqs	= omap2_i2c1_mpu_irqs,
-	.sdma_reqs	= omap2_i2c1_sdma_reqs,
 	.main_clk	= "i2c1_fck",
 	.prcm		= {
 		.omap2 = {
@@ -133,8 +131,6 @@ static struct omap_hwmod omap2420_i2c1_hwmod = {
 /* I2C2 */
 static struct omap_hwmod omap2420_i2c2_hwmod = {
 	.name		= "i2c2",
-	.mpu_irqs	= omap2_i2c2_mpu_irqs,
-	.sdma_reqs	= omap2_i2c2_sdma_reqs,
 	.main_clk	= "i2c2_fck",
 	.prcm		= {
 		.omap2 = {
@@ -179,16 +175,9 @@ static struct omap_mbox_pdata omap2420_mailbox_attrs = {
 	.info		= omap2420_mailbox_info,
 };
 
-static struct omap_hwmod_irq_info omap2420_mailbox_irqs[] = {
-	{ .name = "dsp", .irq = 26 + OMAP_INTC_START, },
-	{ .name = "iva", .irq = 34 + OMAP_INTC_START, },
-	{ .irq = -1 },
-};
-
 static struct omap_hwmod omap2420_mailbox_hwmod = {
 	.name		= "mailbox",
 	.class		= &omap2xxx_mailbox_hwmod_class,
-	.mpu_irqs	= omap2420_mailbox_irqs,
 	.main_clk	= "mailboxes_ick",
 	.prcm		= {
 		.omap2 = {
@@ -217,17 +206,9 @@ static struct omap_hwmod_opt_clk mcbsp_opt_clks[] = {
 };
 
 /* mcbsp1 */
-static struct omap_hwmod_irq_info omap2420_mcbsp1_irqs[] = {
-	{ .name = "tx", .irq = 59 + OMAP_INTC_START, },
-	{ .name = "rx", .irq = 60 + OMAP_INTC_START, },
-	{ .irq = -1 },
-};
-
 static struct omap_hwmod omap2420_mcbsp1_hwmod = {
 	.name		= "mcbsp1",
 	.class		= &omap2420_mcbsp_hwmod_class,
-	.mpu_irqs	= omap2420_mcbsp1_irqs,
-	.sdma_reqs	= omap2_mcbsp1_sdma_reqs,
 	.main_clk	= "mcbsp1_fck",
 	.prcm		= {
 		.omap2 = {
@@ -243,17 +224,9 @@ static struct omap_hwmod omap2420_mcbsp1_hwmod = {
 };
 
 /* mcbsp2 */
-static struct omap_hwmod_irq_info omap2420_mcbsp2_irqs[] = {
-	{ .name = "tx", .irq = 62 + OMAP_INTC_START, },
-	{ .name = "rx", .irq = 63 + OMAP_INTC_START, },
-	{ .irq = -1 },
-};
-
 static struct omap_hwmod omap2420_mcbsp2_hwmod = {
 	.name		= "mcbsp2",
 	.class		= &omap2420_mcbsp_hwmod_class,
-	.mpu_irqs	= omap2420_mcbsp2_irqs,
-	.sdma_reqs	= omap2_mcbsp2_sdma_reqs,
 	.main_clk	= "mcbsp2_fck",
 	.prcm		= {
 		.omap2 = {
@@ -283,22 +256,9 @@ static struct omap_hwmod_class omap2420_msdi_hwmod_class = {
 };
 
 /* msdi1 */
-static struct omap_hwmod_irq_info omap2420_msdi1_irqs[] = {
-	{ .irq = 83 + OMAP_INTC_START, },
-	{ .irq = -1 },
-};
-
-static struct omap_hwmod_dma_info omap2420_msdi1_sdma_reqs[] = {
-	{ .name = "tx", .dma_req = 61 }, /* OMAP24XX_DMA_MMC1_TX */
-	{ .name = "rx", .dma_req = 62 }, /* OMAP24XX_DMA_MMC1_RX */
-	{ .dma_req = -1 }
-};
-
 static struct omap_hwmod omap2420_msdi1_hwmod = {
 	.name		= "msdi1",
 	.class		= &omap2420_msdi_hwmod_class,
-	.mpu_irqs	= omap2420_msdi1_irqs,
-	.sdma_reqs	= omap2420_msdi1_sdma_reqs,
 	.main_clk	= "mmc_fck",
 	.prcm		= {
 		.omap2 = {
@@ -315,7 +275,6 @@ static struct omap_hwmod omap2420_msdi1_hwmod = {
 /* HDQ1W/1-wire */
 static struct omap_hwmod omap2420_hdq1w_hwmod = {
 	.name		= "hdq1w",
-	.mpu_irqs	= omap2_hdq1w_mpu_irqs,
 	.main_clk	= "hdq_fck",
 	.prcm		= {
 		.omap2 = {
@@ -338,7 +297,6 @@ static struct omap_hwmod_ocp_if omap2420_l4_core__i2c1 = {
 	.master		= &omap2xxx_l4_core_hwmod,
 	.slave		= &omap2420_i2c1_hwmod,
 	.clk		= "i2c1_ick",
-	.addr		= omap2_i2c1_addr_space,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
@@ -347,7 +305,6 @@ static struct omap_hwmod_ocp_if omap2420_l4_core__i2c2 = {
 	.master		= &omap2xxx_l4_core_hwmod,
 	.slave		= &omap2420_i2c2_hwmod,
 	.clk		= "i2c2_ick",
-	.addr		= omap2_i2c2_addr_space,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
@@ -367,111 +324,51 @@ static struct omap_hwmod_ocp_if omap2420_l3__dsp = {
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-static struct omap_hwmod_addr_space omap2420_timer1_addrs[] = {
-	{
-		.pa_start	= 0x48028000,
-		.pa_end		= 0x48028000 + SZ_1K - 1,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
-
 /* l4_wkup -> timer1 */
 static struct omap_hwmod_ocp_if omap2420_l4_wkup__timer1 = {
 	.master		= &omap2xxx_l4_wkup_hwmod,
 	.slave		= &omap2xxx_timer1_hwmod,
 	.clk		= "gpt1_ick",
-	.addr		= omap2420_timer1_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
 /* l4_wkup -> wd_timer2 */
-static struct omap_hwmod_addr_space omap2420_wd_timer2_addrs[] = {
-	{
-		.pa_start	= 0x48022000,
-		.pa_end		= 0x4802207f,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
-
 static struct omap_hwmod_ocp_if omap2420_l4_wkup__wd_timer2 = {
 	.master		= &omap2xxx_l4_wkup_hwmod,
 	.slave		= &omap2xxx_wd_timer2_hwmod,
 	.clk		= "mpu_wdt_ick",
-	.addr		= omap2420_wd_timer2_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
 /* l4_wkup -> gpio1 */
-static struct omap_hwmod_addr_space omap2420_gpio1_addr_space[] = {
-	{
-		.pa_start	= 0x48018000,
-		.pa_end		= 0x480181ff,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
-
 static struct omap_hwmod_ocp_if omap2420_l4_wkup__gpio1 = {
 	.master		= &omap2xxx_l4_wkup_hwmod,
 	.slave		= &omap2xxx_gpio1_hwmod,
 	.clk		= "gpios_ick",
-	.addr		= omap2420_gpio1_addr_space,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
 /* l4_wkup -> gpio2 */
-static struct omap_hwmod_addr_space omap2420_gpio2_addr_space[] = {
-	{
-		.pa_start	= 0x4801a000,
-		.pa_end		= 0x4801a1ff,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
-
 static struct omap_hwmod_ocp_if omap2420_l4_wkup__gpio2 = {
 	.master		= &omap2xxx_l4_wkup_hwmod,
 	.slave		= &omap2xxx_gpio2_hwmod,
 	.clk		= "gpios_ick",
-	.addr		= omap2420_gpio2_addr_space,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
 /* l4_wkup -> gpio3 */
-static struct omap_hwmod_addr_space omap2420_gpio3_addr_space[] = {
-	{
-		.pa_start	= 0x4801c000,
-		.pa_end		= 0x4801c1ff,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
-
 static struct omap_hwmod_ocp_if omap2420_l4_wkup__gpio3 = {
 	.master		= &omap2xxx_l4_wkup_hwmod,
 	.slave		= &omap2xxx_gpio3_hwmod,
 	.clk		= "gpios_ick",
-	.addr		= omap2420_gpio3_addr_space,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
 /* l4_wkup -> gpio4 */
-static struct omap_hwmod_addr_space omap2420_gpio4_addr_space[] = {
-	{
-		.pa_start	= 0x4801e000,
-		.pa_end		= 0x4801e1ff,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
-
 static struct omap_hwmod_ocp_if omap2420_l4_wkup__gpio4 = {
 	.master		= &omap2xxx_l4_wkup_hwmod,
 	.slave		= &omap2xxx_gpio4_hwmod,
 	.clk		= "gpios_ick",
-	.addr		= omap2420_gpio4_addr_space,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
@@ -496,7 +393,6 @@ static struct omap_hwmod_ocp_if omap2420_l4_core__dma_system = {
 static struct omap_hwmod_ocp_if omap2420_l4_core__mailbox = {
 	.master		= &omap2xxx_l4_core_hwmod,
 	.slave		= &omap2420_mailbox_hwmod,
-	.addr		= omap2_mailbox_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
@@ -505,7 +401,6 @@ static struct omap_hwmod_ocp_if omap2420_l4_core__mcbsp1 = {
 	.master		= &omap2xxx_l4_core_hwmod,
 	.slave		= &omap2420_mcbsp1_hwmod,
 	.clk		= "mcbsp1_ick",
-	.addr		= omap2_mcbsp1_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
@@ -514,25 +409,14 @@ static struct omap_hwmod_ocp_if omap2420_l4_core__mcbsp2 = {
 	.master		= &omap2xxx_l4_core_hwmod,
 	.slave		= &omap2420_mcbsp2_hwmod,
 	.clk		= "mcbsp2_ick",
-	.addr		= omap2xxx_mcbsp2_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-static struct omap_hwmod_addr_space omap2420_msdi1_addrs[] = {
-	{
-		.pa_start	= 0x4809c000,
-		.pa_end		= 0x4809c000 + SZ_128 - 1,
-		.flags		= ADDR_TYPE_RT,
-	},
-	{ }
-};
-
 /* l4_core -> msdi1 */
 static struct omap_hwmod_ocp_if omap2420_l4_core__msdi1 = {
 	.master		= &omap2xxx_l4_core_hwmod,
 	.slave		= &omap2420_msdi1_hwmod,
 	.clk		= "mmc_ick",
-	.addr		= omap2420_msdi1_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
@@ -541,36 +425,16 @@ static struct omap_hwmod_ocp_if omap2420_l4_core__hdq1w = {
 	.master		= &omap2xxx_l4_core_hwmod,
 	.slave		= &omap2420_hdq1w_hwmod,
 	.clk		= "hdq_ick",
-	.addr		= omap2_hdq1w_addr_space,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 	.flags		= OMAP_FIREWALL_L4 | OCPIF_SWSUP_IDLE,
 };
 
 
 /* l4_wkup -> 32ksync_counter */
-static struct omap_hwmod_addr_space omap2420_counter_32k_addrs[] = {
-	{
-		.pa_start	= 0x48004000,
-		.pa_end		= 0x4800401f,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
-
-static struct omap_hwmod_addr_space omap2420_gpmc_addrs[] = {
-	{
-		.pa_start	= 0x6800a000,
-		.pa_end		= 0x6800afff,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
-
 static struct omap_hwmod_ocp_if omap2420_l4_wkup__counter_32k = {
 	.master		= &omap2xxx_l4_wkup_hwmod,
 	.slave		= &omap2xxx_counter_32k_hwmod,
 	.clk		= "sync_32k_ick",
-	.addr		= omap2420_counter_32k_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
@@ -578,7 +442,6 @@ static struct omap_hwmod_ocp_if omap2420_l3__gpmc = {
 	.master		= &omap2xxx_l3_main_hwmod,
 	.slave		= &omap2xxx_gpmc_hwmod,
 	.clk		= "core_l3_ck",
-	.addr		= omap2420_gpmc_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
diff --git a/arch/arm/mach-omap2/omap_hwmod_2430_data.c b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
index 5b90834..6d1b609 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2430_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
@@ -86,8 +86,6 @@ static struct omap_i2c_dev_attr i2c_dev_attr = {
 static struct omap_hwmod omap2430_i2c1_hwmod = {
 	.name		= "i2c1",
 	.flags		= HWMOD_16BIT_REG,
-	.mpu_irqs	= omap2_i2c1_mpu_irqs,
-	.sdma_reqs	= omap2_i2c1_sdma_reqs,
 	.main_clk	= "i2chs1_fck",
 	.prcm		= {
 		.omap2 = {
@@ -114,8 +112,6 @@ static struct omap_hwmod omap2430_i2c1_hwmod = {
 static struct omap_hwmod omap2430_i2c2_hwmod = {
 	.name		= "i2c2",
 	.flags		= HWMOD_16BIT_REG,
-	.mpu_irqs	= omap2_i2c2_mpu_irqs,
-	.sdma_reqs	= omap2_i2c2_sdma_reqs,
 	.main_clk	= "i2chs2_fck",
 	.prcm		= {
 		.omap2 = {
@@ -131,15 +127,9 @@ static struct omap_hwmod omap2430_i2c2_hwmod = {
 };
 
 /* gpio5 */
-static struct omap_hwmod_irq_info omap243x_gpio5_irqs[] = {
-	{ .irq = 33 + OMAP_INTC_START, }, /* INT_24XX_GPIO_BANK5 */
-	{ .irq = -1 },
-};
-
 static struct omap_hwmod omap2430_gpio5_hwmod = {
 	.name		= "gpio5",
 	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
-	.mpu_irqs	= omap243x_gpio5_irqs,
 	.main_clk	= "gpio5_fck",
 	.prcm		= {
 		.omap2 = {
@@ -182,15 +172,9 @@ static struct omap_mbox_pdata omap2430_mailbox_attrs = {
 	.info		= omap2430_mailbox_info,
 };
 
-static struct omap_hwmod_irq_info omap2430_mailbox_irqs[] = {
-	{ .irq = 26 + OMAP_INTC_START, },
-	{ .irq = -1 },
-};
-
 static struct omap_hwmod omap2430_mailbox_hwmod = {
 	.name		= "mailbox",
 	.class		= &omap2xxx_mailbox_hwmod_class,
-	.mpu_irqs	= omap2430_mailbox_irqs,
 	.main_clk	= "mailboxes_ick",
 	.prcm		= {
 		.omap2 = {
@@ -205,27 +189,12 @@ static struct omap_hwmod omap2430_mailbox_hwmod = {
 };
 
 /* mcspi3 */
-static struct omap_hwmod_irq_info omap2430_mcspi3_mpu_irqs[] = {
-	{ .irq = 91 + OMAP_INTC_START, },
-	{ .irq = -1 },
-};
-
-static struct omap_hwmod_dma_info omap2430_mcspi3_sdma_reqs[] = {
-	{ .name = "tx0", .dma_req = 15 }, /* DMA_SPI3_TX0 */
-	{ .name = "rx0", .dma_req = 16 }, /* DMA_SPI3_RX0 */
-	{ .name = "tx1", .dma_req = 23 }, /* DMA_SPI3_TX1 */
-	{ .name = "rx1", .dma_req = 24 }, /* DMA_SPI3_RX1 */
-	{ .dma_req = -1 }
-};
-
 static struct omap2_mcspi_dev_attr omap_mcspi3_dev_attr = {
 	.num_chipselect = 2,
 };
 
 static struct omap_hwmod omap2430_mcspi3_hwmod = {
 	.name		= "mcspi3",
-	.mpu_irqs	= omap2430_mcspi3_mpu_irqs,
-	.sdma_reqs	= omap2430_mcspi3_sdma_reqs,
 	.main_clk	= "mcspi3_fck",
 	.prcm		= {
 		.omap2 = {
@@ -259,16 +228,8 @@ static struct omap_hwmod_class usbotg_class = {
 };
 
 /* usb_otg_hs */
-static struct omap_hwmod_irq_info omap2430_usbhsotg_mpu_irqs[] = {
-
-	{ .name = "mc", .irq = 92 + OMAP_INTC_START, },
-	{ .name = "dma", .irq = 93 + OMAP_INTC_START, },
-	{ .irq = -1 },
-};
-
 static struct omap_hwmod omap2430_usbhsotg_hwmod = {
 	.name		= "usb_otg_hs",
-	.mpu_irqs	= omap2430_usbhsotg_mpu_irqs,
 	.main_clk	= "usbhs_ick",
 	.prcm		= {
 		.omap2 = {
@@ -313,19 +274,9 @@ static struct omap_hwmod_opt_clk mcbsp_opt_clks[] = {
 };
 
 /* mcbsp1 */
-static struct omap_hwmod_irq_info omap2430_mcbsp1_irqs[] = {
-	{ .name = "tx",		.irq = 59 + OMAP_INTC_START, },
-	{ .name = "rx",		.irq = 60 + OMAP_INTC_START, },
-	{ .name = "ovr",	.irq = 61 + OMAP_INTC_START, },
-	{ .name = "common",	.irq = 64 + OMAP_INTC_START, },
-	{ .irq = -1 },
-};
-
 static struct omap_hwmod omap2430_mcbsp1_hwmod = {
 	.name		= "mcbsp1",
 	.class		= &omap2430_mcbsp_hwmod_class,
-	.mpu_irqs	= omap2430_mcbsp1_irqs,
-	.sdma_reqs	= omap2_mcbsp1_sdma_reqs,
 	.main_clk	= "mcbsp1_fck",
 	.prcm		= {
 		.omap2 = {
@@ -341,18 +292,9 @@ static struct omap_hwmod omap2430_mcbsp1_hwmod = {
 };
 
 /* mcbsp2 */
-static struct omap_hwmod_irq_info omap2430_mcbsp2_irqs[] = {
-	{ .name = "tx",		.irq = 62 + OMAP_INTC_START, },
-	{ .name = "rx",		.irq = 63 + OMAP_INTC_START, },
-	{ .name = "common",	.irq = 16 + OMAP_INTC_START, },
-	{ .irq = -1 },
-};
-
 static struct omap_hwmod omap2430_mcbsp2_hwmod = {
 	.name		= "mcbsp2",
 	.class		= &omap2430_mcbsp_hwmod_class,
-	.mpu_irqs	= omap2430_mcbsp2_irqs,
-	.sdma_reqs	= omap2_mcbsp2_sdma_reqs,
 	.main_clk	= "mcbsp2_fck",
 	.prcm		= {
 		.omap2 = {
@@ -368,18 +310,9 @@ static struct omap_hwmod omap2430_mcbsp2_hwmod = {
 };
 
 /* mcbsp3 */
-static struct omap_hwmod_irq_info omap2430_mcbsp3_irqs[] = {
-	{ .name = "tx",		.irq = 89 + OMAP_INTC_START, },
-	{ .name = "rx",		.irq = 90 + OMAP_INTC_START, },
-	{ .name = "common",	.irq = 17 + OMAP_INTC_START, },
-	{ .irq = -1 },
-};
-
 static struct omap_hwmod omap2430_mcbsp3_hwmod = {
 	.name		= "mcbsp3",
 	.class		= &omap2430_mcbsp_hwmod_class,
-	.mpu_irqs	= omap2430_mcbsp3_irqs,
-	.sdma_reqs	= omap2_mcbsp3_sdma_reqs,
 	.main_clk	= "mcbsp3_fck",
 	.prcm		= {
 		.omap2 = {
@@ -395,24 +328,9 @@ static struct omap_hwmod omap2430_mcbsp3_hwmod = {
 };
 
 /* mcbsp4 */
-static struct omap_hwmod_irq_info omap2430_mcbsp4_irqs[] = {
-	{ .name = "tx",		.irq = 54 + OMAP_INTC_START, },
-	{ .name = "rx",		.irq = 55 + OMAP_INTC_START, },
-	{ .name = "common",	.irq = 18 + OMAP_INTC_START, },
-	{ .irq = -1 },
-};
-
-static struct omap_hwmod_dma_info omap2430_mcbsp4_sdma_chs[] = {
-	{ .name = "rx", .dma_req = 20 },
-	{ .name = "tx", .dma_req = 19 },
-	{ .dma_req = -1 }
-};
-
 static struct omap_hwmod omap2430_mcbsp4_hwmod = {
 	.name		= "mcbsp4",
 	.class		= &omap2430_mcbsp_hwmod_class,
-	.mpu_irqs	= omap2430_mcbsp4_irqs,
-	.sdma_reqs	= omap2430_mcbsp4_sdma_chs,
 	.main_clk	= "mcbsp4_fck",
 	.prcm		= {
 		.omap2 = {
@@ -428,24 +346,9 @@ static struct omap_hwmod omap2430_mcbsp4_hwmod = {
 };
 
 /* mcbsp5 */
-static struct omap_hwmod_irq_info omap2430_mcbsp5_irqs[] = {
-	{ .name = "tx",		.irq = 81 + OMAP_INTC_START, },
-	{ .name = "rx",		.irq = 82 + OMAP_INTC_START, },
-	{ .name = "common",	.irq = 19 + OMAP_INTC_START, },
-	{ .irq = -1 },
-};
-
-static struct omap_hwmod_dma_info omap2430_mcbsp5_sdma_chs[] = {
-	{ .name = "rx", .dma_req = 22 },
-	{ .name = "tx", .dma_req = 21 },
-	{ .dma_req = -1 }
-};
-
 static struct omap_hwmod omap2430_mcbsp5_hwmod = {
 	.name		= "mcbsp5",
 	.class		= &omap2430_mcbsp_hwmod_class,
-	.mpu_irqs	= omap2430_mcbsp5_irqs,
-	.sdma_reqs	= omap2430_mcbsp5_sdma_chs,
 	.main_clk	= "mcbsp5_fck",
 	.prcm		= {
 		.omap2 = {
@@ -478,17 +381,6 @@ static struct omap_hwmod_class omap2430_mmc_class = {
 };
 
 /* MMC/SD/SDIO1 */
-static struct omap_hwmod_irq_info omap2430_mmc1_mpu_irqs[] = {
-	{ .irq = 83 + OMAP_INTC_START, },
-	{ .irq = -1 },
-};
-
-static struct omap_hwmod_dma_info omap2430_mmc1_sdma_reqs[] = {
-	{ .name = "tx",	.dma_req = 61 }, /* DMA_MMC1_TX */
-	{ .name = "rx",	.dma_req = 62 }, /* DMA_MMC1_RX */
-	{ .dma_req = -1 }
-};
-
 static struct omap_hwmod_opt_clk omap2430_mmc1_opt_clks[] = {
 	{ .role = "dbck", .clk = "mmchsdb1_fck" },
 };
@@ -500,8 +392,6 @@ static struct omap_mmc_dev_attr mmc1_dev_attr = {
 static struct omap_hwmod omap2430_mmc1_hwmod = {
 	.name		= "mmc1",
 	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
-	.mpu_irqs	= omap2430_mmc1_mpu_irqs,
-	.sdma_reqs	= omap2430_mmc1_sdma_reqs,
 	.opt_clks	= omap2430_mmc1_opt_clks,
 	.opt_clks_cnt	= ARRAY_SIZE(omap2430_mmc1_opt_clks),
 	.main_clk	= "mmchs1_fck",
@@ -519,17 +409,6 @@ static struct omap_hwmod omap2430_mmc1_hwmod = {
 };
 
 /* MMC/SD/SDIO2 */
-static struct omap_hwmod_irq_info omap2430_mmc2_mpu_irqs[] = {
-	{ .irq = 86 + OMAP_INTC_START, },
-	{ .irq = -1 },
-};
-
-static struct omap_hwmod_dma_info omap2430_mmc2_sdma_reqs[] = {
-	{ .name = "tx",	.dma_req = 47 }, /* DMA_MMC2_TX */
-	{ .name = "rx",	.dma_req = 48 }, /* DMA_MMC2_RX */
-	{ .dma_req = -1 }
-};
-
 static struct omap_hwmod_opt_clk omap2430_mmc2_opt_clks[] = {
 	{ .role = "dbck", .clk = "mmchsdb2_fck" },
 };
@@ -537,8 +416,6 @@ static struct omap_hwmod_opt_clk omap2430_mmc2_opt_clks[] = {
 static struct omap_hwmod omap2430_mmc2_hwmod = {
 	.name		= "mmc2",
 	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
-	.mpu_irqs	= omap2430_mmc2_mpu_irqs,
-	.sdma_reqs	= omap2430_mmc2_sdma_reqs,
 	.opt_clks	= omap2430_mmc2_opt_clks,
 	.opt_clks_cnt	= ARRAY_SIZE(omap2430_mmc2_opt_clks),
 	.main_clk	= "mmchs2_fck",
@@ -557,7 +434,6 @@ static struct omap_hwmod omap2430_mmc2_hwmod = {
 /* HDQ1W/1-wire */
 static struct omap_hwmod omap2430_hdq1w_hwmod = {
 	.name		= "hdq1w",
-	.mpu_irqs	= omap2_hdq1w_mpu_irqs,
 	.main_clk	= "hdq_fck",
 	.prcm		= {
 		.omap2 = {
@@ -589,7 +465,6 @@ static struct omap_hwmod_ocp_if omap2430_l4_core__i2c1 = {
 	.master		= &omap2xxx_l4_core_hwmod,
 	.slave		= &omap2430_i2c1_hwmod,
 	.clk		= "i2c1_ick",
-	.addr		= omap2_i2c1_addr_space,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
@@ -598,25 +473,14 @@ static struct omap_hwmod_ocp_if omap2430_l4_core__i2c2 = {
 	.master		= &omap2xxx_l4_core_hwmod,
 	.slave		= &omap2430_i2c2_hwmod,
 	.clk		= "i2c2_ick",
-	.addr		= omap2_i2c2_addr_space,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-static struct omap_hwmod_addr_space omap2430_usbhsotg_addrs[] = {
-	{
-		.pa_start	= OMAP243X_HS_BASE,
-		.pa_end		= OMAP243X_HS_BASE + SZ_4K - 1,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
-
 /*  l4_core ->usbhsotg  interface */
 static struct omap_hwmod_ocp_if omap2430_l4_core__usbhsotg = {
 	.master		= &omap2xxx_l4_core_hwmod,
 	.slave		= &omap2430_usbhsotg_hwmod,
 	.clk		= "usb_l4_ick",
-	.addr		= omap2430_usbhsotg_addrs,
 	.user		= OCP_USER_MPU,
 };
 
@@ -625,7 +489,6 @@ static struct omap_hwmod_ocp_if omap2430_l4_core__mmc1 = {
 	.master		= &omap2xxx_l4_core_hwmod,
 	.slave		= &omap2430_mmc1_hwmod,
 	.clk		= "mmchs1_ick",
-	.addr		= omap2430_mmc1_addr_space,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
@@ -634,7 +497,6 @@ static struct omap_hwmod_ocp_if omap2430_l4_core__mmc2 = {
 	.master		= &omap2xxx_l4_core_hwmod,
 	.slave		= &omap2430_mmc2_hwmod,
 	.clk		= "mmchs2_ick",
-	.addr		= omap2430_mmc2_addr_space,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
@@ -643,7 +505,6 @@ static struct omap_hwmod_ocp_if omap2430_l4_core__mcspi3 = {
 	.master		= &omap2xxx_l4_core_hwmod,
 	.slave		= &omap2430_mcspi3_hwmod,
 	.clk		= "mcspi3_ick",
-	.addr		= omap2430_mcspi3_addr_space,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
@@ -655,129 +516,59 @@ static struct omap_hwmod_ocp_if omap2430_l3__iva = {
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-static struct omap_hwmod_addr_space omap2430_timer1_addrs[] = {
-	{
-		.pa_start	= 0x49018000,
-		.pa_end		= 0x49018000 + SZ_1K - 1,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
-
 /* l4_wkup -> timer1 */
 static struct omap_hwmod_ocp_if omap2430_l4_wkup__timer1 = {
 	.master		= &omap2xxx_l4_wkup_hwmod,
 	.slave		= &omap2xxx_timer1_hwmod,
 	.clk		= "gpt1_ick",
-	.addr		= omap2430_timer1_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
 /* l4_wkup -> wd_timer2 */
-static struct omap_hwmod_addr_space omap2430_wd_timer2_addrs[] = {
-	{
-		.pa_start	= 0x49016000,
-		.pa_end		= 0x4901607f,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
-
 static struct omap_hwmod_ocp_if omap2430_l4_wkup__wd_timer2 = {
 	.master		= &omap2xxx_l4_wkup_hwmod,
 	.slave		= &omap2xxx_wd_timer2_hwmod,
 	.clk		= "mpu_wdt_ick",
-	.addr		= omap2430_wd_timer2_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
 /* l4_wkup -> gpio1 */
-static struct omap_hwmod_addr_space omap2430_gpio1_addr_space[] = {
-	{
-		.pa_start	= 0x4900C000,
-		.pa_end		= 0x4900C1ff,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
-
 static struct omap_hwmod_ocp_if omap2430_l4_wkup__gpio1 = {
 	.master		= &omap2xxx_l4_wkup_hwmod,
 	.slave		= &omap2xxx_gpio1_hwmod,
 	.clk		= "gpios_ick",
-	.addr		= omap2430_gpio1_addr_space,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
 /* l4_wkup -> gpio2 */
-static struct omap_hwmod_addr_space omap2430_gpio2_addr_space[] = {
-	{
-		.pa_start	= 0x4900E000,
-		.pa_end		= 0x4900E1ff,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
-
 static struct omap_hwmod_ocp_if omap2430_l4_wkup__gpio2 = {
 	.master		= &omap2xxx_l4_wkup_hwmod,
 	.slave		= &omap2xxx_gpio2_hwmod,
 	.clk		= "gpios_ick",
-	.addr		= omap2430_gpio2_addr_space,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
 /* l4_wkup -> gpio3 */
-static struct omap_hwmod_addr_space omap2430_gpio3_addr_space[] = {
-	{
-		.pa_start	= 0x49010000,
-		.pa_end		= 0x490101ff,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
-
 static struct omap_hwmod_ocp_if omap2430_l4_wkup__gpio3 = {
 	.master		= &omap2xxx_l4_wkup_hwmod,
 	.slave		= &omap2xxx_gpio3_hwmod,
 	.clk		= "gpios_ick",
-	.addr		= omap2430_gpio3_addr_space,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
 /* l4_wkup -> gpio4 */
-static struct omap_hwmod_addr_space omap2430_gpio4_addr_space[] = {
-	{
-		.pa_start	= 0x49012000,
-		.pa_end		= 0x490121ff,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
-
 static struct omap_hwmod_ocp_if omap2430_l4_wkup__gpio4 = {
 	.master		= &omap2xxx_l4_wkup_hwmod,
 	.slave		= &omap2xxx_gpio4_hwmod,
 	.clk		= "gpios_ick",
-	.addr		= omap2430_gpio4_addr_space,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
 /* l4_core -> gpio5 */
-static struct omap_hwmod_addr_space omap2430_gpio5_addr_space[] = {
-	{
-		.pa_start	= 0x480B6000,
-		.pa_end		= 0x480B61ff,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
-
 static struct omap_hwmod_ocp_if omap2430_l4_core__gpio5 = {
 	.master		= &omap2xxx_l4_core_hwmod,
 	.slave		= &omap2430_gpio5_hwmod,
 	.clk		= "gpio5_ick",
-	.addr		= omap2430_gpio5_addr_space,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
@@ -802,7 +593,6 @@ static struct omap_hwmod_ocp_if omap2430_l4_core__dma_system = {
 static struct omap_hwmod_ocp_if omap2430_l4_core__mailbox = {
 	.master		= &omap2xxx_l4_core_hwmod,
 	.slave		= &omap2430_mailbox_hwmod,
-	.addr		= omap2_mailbox_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
@@ -811,7 +601,6 @@ static struct omap_hwmod_ocp_if omap2430_l4_core__mcbsp1 = {
 	.master		= &omap2xxx_l4_core_hwmod,
 	.slave		= &omap2430_mcbsp1_hwmod,
 	.clk		= "mcbsp1_ick",
-	.addr		= omap2_mcbsp1_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
@@ -820,64 +609,30 @@ static struct omap_hwmod_ocp_if omap2430_l4_core__mcbsp2 = {
 	.master		= &omap2xxx_l4_core_hwmod,
 	.slave		= &omap2430_mcbsp2_hwmod,
 	.clk		= "mcbsp2_ick",
-	.addr		= omap2xxx_mcbsp2_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-static struct omap_hwmod_addr_space omap2430_mcbsp3_addrs[] = {
-	{
-		.name		= "mpu",
-		.pa_start	= 0x4808C000,
-		.pa_end		= 0x4808C0ff,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
-
 /* l4_core -> mcbsp3 */
 static struct omap_hwmod_ocp_if omap2430_l4_core__mcbsp3 = {
 	.master		= &omap2xxx_l4_core_hwmod,
 	.slave		= &omap2430_mcbsp3_hwmod,
 	.clk		= "mcbsp3_ick",
-	.addr		= omap2430_mcbsp3_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-static struct omap_hwmod_addr_space omap2430_mcbsp4_addrs[] = {
-	{
-		.name		= "mpu",
-		.pa_start	= 0x4808E000,
-		.pa_end		= 0x4808E0ff,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
-
 /* l4_core -> mcbsp4 */
 static struct omap_hwmod_ocp_if omap2430_l4_core__mcbsp4 = {
 	.master		= &omap2xxx_l4_core_hwmod,
 	.slave		= &omap2430_mcbsp4_hwmod,
 	.clk		= "mcbsp4_ick",
-	.addr		= omap2430_mcbsp4_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-static struct omap_hwmod_addr_space omap2430_mcbsp5_addrs[] = {
-	{
-		.name		= "mpu",
-		.pa_start	= 0x48096000,
-		.pa_end		= 0x480960ff,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
-
 /* l4_core -> mcbsp5 */
 static struct omap_hwmod_ocp_if omap2430_l4_core__mcbsp5 = {
 	.master		= &omap2xxx_l4_core_hwmod,
 	.slave		= &omap2430_mcbsp5_hwmod,
 	.clk		= "mcbsp5_ick",
-	.addr		= omap2430_mcbsp5_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
@@ -886,35 +641,15 @@ static struct omap_hwmod_ocp_if omap2430_l4_core__hdq1w = {
 	.master		= &omap2xxx_l4_core_hwmod,
 	.slave		= &omap2430_hdq1w_hwmod,
 	.clk		= "hdq_ick",
-	.addr		= omap2_hdq1w_addr_space,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 	.flags		= OMAP_FIREWALL_L4 | OCPIF_SWSUP_IDLE,
 };
 
 /* l4_wkup -> 32ksync_counter */
-static struct omap_hwmod_addr_space omap2430_counter_32k_addrs[] = {
-	{
-		.pa_start	= 0x49020000,
-		.pa_end		= 0x4902001f,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
-
-static struct omap_hwmod_addr_space omap2430_gpmc_addrs[] = {
-	{
-		.pa_start	= 0x6e000000,
-		.pa_end		= 0x6e000fff,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
-
 static struct omap_hwmod_ocp_if omap2430_l4_wkup__counter_32k = {
 	.master		= &omap2xxx_l4_wkup_hwmod,
 	.slave		= &omap2xxx_counter_32k_hwmod,
 	.clk		= "sync_32k_ick",
-	.addr		= omap2430_counter_32k_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
@@ -922,7 +657,6 @@ static struct omap_hwmod_ocp_if omap2430_l3__gpmc = {
 	.master		= &omap2xxx_l3_main_hwmod,
 	.slave		= &omap2xxx_gpmc_hwmod,
 	.clk		= "core_l3_ck",
-	.addr		= omap2430_gpmc_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
diff --git a/arch/arm/mach-omap2/omap_hwmod_2xxx_interconnect_data.c b/arch/arm/mach-omap2/omap_hwmod_2xxx_interconnect_data.c
index 5fd40d4..6c24f49 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2xxx_interconnect_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2xxx_interconnect_data.c
@@ -20,142 +20,6 @@
 
 #include "omap_hwmod_common_data.h"
 
-static struct omap_hwmod_addr_space omap2xxx_uart1_addr_space[] = {
-	{
-		.pa_start	= OMAP2_UART1_BASE,
-		.pa_end		= OMAP2_UART1_BASE + SZ_8K - 1,
-		.flags		= ADDR_MAP_ON_INIT | ADDR_TYPE_RT,
-	},
-	{ }
-};
-
-static struct omap_hwmod_addr_space omap2xxx_uart2_addr_space[] = {
-	{
-		.pa_start	= OMAP2_UART2_BASE,
-		.pa_end		= OMAP2_UART2_BASE + SZ_1K - 1,
-		.flags		= ADDR_MAP_ON_INIT | ADDR_TYPE_RT,
-	},
-	{ }
-};
-
-static struct omap_hwmod_addr_space omap2xxx_uart3_addr_space[] = {
-	{
-		.pa_start	= OMAP2_UART3_BASE,
-		.pa_end		= OMAP2_UART3_BASE + SZ_1K - 1,
-		.flags		= ADDR_MAP_ON_INIT | ADDR_TYPE_RT,
-	},
-	{ }
-};
-
-static struct omap_hwmod_addr_space omap2xxx_timer2_addrs[] = {
-	{
-		.pa_start	= 0x4802a000,
-		.pa_end		= 0x4802a000 + SZ_1K - 1,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
-
-static struct omap_hwmod_addr_space omap2xxx_timer3_addrs[] = {
-	{
-		.pa_start	= 0x48078000,
-		.pa_end		= 0x48078000 + SZ_1K - 1,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
-
-static struct omap_hwmod_addr_space omap2xxx_timer4_addrs[] = {
-	{
-		.pa_start	= 0x4807a000,
-		.pa_end		= 0x4807a000 + SZ_1K - 1,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
-
-static struct omap_hwmod_addr_space omap2xxx_timer5_addrs[] = {
-	{
-		.pa_start	= 0x4807c000,
-		.pa_end		= 0x4807c000 + SZ_1K - 1,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
-
-static struct omap_hwmod_addr_space omap2xxx_timer6_addrs[] = {
-	{
-		.pa_start	= 0x4807e000,
-		.pa_end		= 0x4807e000 + SZ_1K - 1,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
-
-static struct omap_hwmod_addr_space omap2xxx_timer7_addrs[] = {
-	{
-		.pa_start	= 0x48080000,
-		.pa_end		= 0x48080000 + SZ_1K - 1,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
-
-static struct omap_hwmod_addr_space omap2xxx_timer8_addrs[] = {
-	{
-		.pa_start	= 0x48082000,
-		.pa_end		= 0x48082000 + SZ_1K - 1,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
-
-static struct omap_hwmod_addr_space omap2xxx_timer9_addrs[] = {
-	{
-		.pa_start	= 0x48084000,
-		.pa_end		= 0x48084000 + SZ_1K - 1,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
-
-struct omap_hwmod_addr_space omap2xxx_mcbsp2_addrs[] = {
-	{
-		.name		= "mpu",
-		.pa_start	= 0x48076000,
-		.pa_end		= 0x480760ff,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
-
-static struct omap_hwmod_addr_space omap2_rng_addr_space[] = {
-	{
-		.pa_start	= 0x480a0000,
-		.pa_end		= 0x480a004f,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
-
-static struct omap_hwmod_addr_space omap2xxx_sham_addrs[] = {
-	{
-		.pa_start	= 0x480a4000,
-		.pa_end		= 0x480a4000 + 0x64 - 1,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
-
-static struct omap_hwmod_addr_space omap2xxx_aes_addrs[] = {
-	{
-		.pa_start	= 0x480a6000,
-		.pa_end		= 0x480a6000 + 0x50 - 1,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
-
 /*
  * Common interconnect data
  */
@@ -199,7 +63,6 @@ struct omap_hwmod_ocp_if omap2_l4_core__uart1 = {
 	.master		= &omap2xxx_l4_core_hwmod,
 	.slave		= &omap2xxx_uart1_hwmod,
 	.clk		= "uart1_ick",
-	.addr		= omap2xxx_uart1_addr_space,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
@@ -208,7 +71,6 @@ struct omap_hwmod_ocp_if omap2_l4_core__uart2 = {
 	.master		= &omap2xxx_l4_core_hwmod,
 	.slave		= &omap2xxx_uart2_hwmod,
 	.clk		= "uart2_ick",
-	.addr		= omap2xxx_uart2_addr_space,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
@@ -217,7 +79,6 @@ struct omap_hwmod_ocp_if omap2_l4_core__uart3 = {
 	.master		= &omap2xxx_l4_core_hwmod,
 	.slave		= &omap2xxx_uart3_hwmod,
 	.clk		= "uart3_ick",
-	.addr		= omap2xxx_uart3_addr_space,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
@@ -226,7 +87,6 @@ struct omap_hwmod_ocp_if omap2xxx_l4_core__mcspi1 = {
 	.master		= &omap2xxx_l4_core_hwmod,
 	.slave		= &omap2xxx_mcspi1_hwmod,
 	.clk		= "mcspi1_ick",
-	.addr		= omap2_mcspi1_addr_space,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
@@ -235,7 +95,6 @@ struct omap_hwmod_ocp_if omap2xxx_l4_core__mcspi2 = {
 	.master		= &omap2xxx_l4_core_hwmod,
 	.slave		= &omap2xxx_mcspi2_hwmod,
 	.clk		= "mcspi2_ick",
-	.addr		= omap2_mcspi2_addr_space,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
@@ -244,7 +103,6 @@ struct omap_hwmod_ocp_if omap2xxx_l4_core__timer2 = {
 	.master		= &omap2xxx_l4_core_hwmod,
 	.slave		= &omap2xxx_timer2_hwmod,
 	.clk		= "gpt2_ick",
-	.addr		= omap2xxx_timer2_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
@@ -253,7 +111,6 @@ struct omap_hwmod_ocp_if omap2xxx_l4_core__timer3 = {
 	.master		= &omap2xxx_l4_core_hwmod,
 	.slave		= &omap2xxx_timer3_hwmod,
 	.clk		= "gpt3_ick",
-	.addr		= omap2xxx_timer3_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
@@ -262,7 +119,6 @@ struct omap_hwmod_ocp_if omap2xxx_l4_core__timer4 = {
 	.master		= &omap2xxx_l4_core_hwmod,
 	.slave		= &omap2xxx_timer4_hwmod,
 	.clk		= "gpt4_ick",
-	.addr		= omap2xxx_timer4_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
@@ -271,7 +127,6 @@ struct omap_hwmod_ocp_if omap2xxx_l4_core__timer5 = {
 	.master		= &omap2xxx_l4_core_hwmod,
 	.slave		= &omap2xxx_timer5_hwmod,
 	.clk		= "gpt5_ick",
-	.addr		= omap2xxx_timer5_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
@@ -280,7 +135,6 @@ struct omap_hwmod_ocp_if omap2xxx_l4_core__timer6 = {
 	.master		= &omap2xxx_l4_core_hwmod,
 	.slave		= &omap2xxx_timer6_hwmod,
 	.clk		= "gpt6_ick",
-	.addr		= omap2xxx_timer6_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
@@ -289,7 +143,6 @@ struct omap_hwmod_ocp_if omap2xxx_l4_core__timer7 = {
 	.master		= &omap2xxx_l4_core_hwmod,
 	.slave		= &omap2xxx_timer7_hwmod,
 	.clk		= "gpt7_ick",
-	.addr		= omap2xxx_timer7_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
@@ -298,7 +151,6 @@ struct omap_hwmod_ocp_if omap2xxx_l4_core__timer8 = {
 	.master		= &omap2xxx_l4_core_hwmod,
 	.slave		= &omap2xxx_timer8_hwmod,
 	.clk		= "gpt8_ick",
-	.addr		= omap2xxx_timer8_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
@@ -307,7 +159,6 @@ struct omap_hwmod_ocp_if omap2xxx_l4_core__timer9 = {
 	.master		= &omap2xxx_l4_core_hwmod,
 	.slave		= &omap2xxx_timer9_hwmod,
 	.clk		= "gpt9_ick",
-	.addr		= omap2xxx_timer9_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
@@ -316,7 +167,6 @@ struct omap_hwmod_ocp_if omap2xxx_l4_core__timer10 = {
 	.master		= &omap2xxx_l4_core_hwmod,
 	.slave		= &omap2xxx_timer10_hwmod,
 	.clk		= "gpt10_ick",
-	.addr		= omap2_timer10_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
@@ -325,7 +175,6 @@ struct omap_hwmod_ocp_if omap2xxx_l4_core__timer11 = {
 	.master		= &omap2xxx_l4_core_hwmod,
 	.slave		= &omap2xxx_timer11_hwmod,
 	.clk		= "gpt11_ick",
-	.addr		= omap2_timer11_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
@@ -334,7 +183,6 @@ struct omap_hwmod_ocp_if omap2xxx_l4_core__timer12 = {
 	.master		= &omap2xxx_l4_core_hwmod,
 	.slave		= &omap2xxx_timer12_hwmod,
 	.clk		= "gpt12_ick",
-	.addr		= omap2xxx_timer12_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
@@ -404,7 +252,6 @@ struct omap_hwmod_ocp_if omap2xxx_l4_core__rng = {
 	.master		= &omap2xxx_l4_core_hwmod,
 	.slave		= &omap2xxx_rng_hwmod,
 	.clk		= "rng_ick",
-	.addr		= omap2_rng_addr_space,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
@@ -413,7 +260,6 @@ struct omap_hwmod_ocp_if omap2xxx_l4_core__sham = {
 	.master		= &omap2xxx_l4_core_hwmod,
 	.slave		= &omap2xxx_sham_hwmod,
 	.clk		= "sha_ick",
-	.addr		= omap2xxx_sham_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
@@ -422,6 +268,5 @@ struct omap_hwmod_ocp_if omap2xxx_l4_core__aes = {
 	.master		= &omap2xxx_l4_core_hwmod,
 	.slave		= &omap2xxx_aes_hwmod,
 	.clk		= "aes_ick",
-	.addr		= omap2xxx_aes_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
diff --git a/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c b/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c
index 56cebb0..2738876 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c
@@ -20,11 +20,6 @@
 #include "prm-regbits-24xx.h"
 #include "wd_timer.h"
 
-struct omap_hwmod_irq_info omap2xxx_timer12_mpu_irqs[] = {
-	{ .irq = 48 + OMAP_INTC_START, },
-	{ .irq = -1 },
-};
-
 struct omap_hwmod_dma_info omap2xxx_dss_sdma_chs[] = {
 	{ .name = "dispc", .dma_req = 5 },
 	{ .dma_req = -1 }
@@ -219,14 +214,8 @@ struct omap_hwmod omap2xxx_l4_wkup_hwmod = {
 };
 
 /* MPU */
-static struct omap_hwmod_irq_info omap2xxx_mpu_irqs[] = {
-	{ .name = "pmu", .irq = 3 + OMAP_INTC_START },
-	{ .irq = -1 }
-};
-
 struct omap_hwmod omap2xxx_mpu_hwmod = {
 	.name		= "mpu",
-	.mpu_irqs	= omap2xxx_mpu_irqs,
 	.class		= &mpu_hwmod_class,
 	.main_clk	= "mpu_ck",
 };
@@ -256,7 +245,6 @@ static struct omap_timer_capability_dev_attr capability_dsp_dev_attr = {
 
 struct omap_hwmod omap2xxx_timer1_hwmod = {
 	.name		= "timer1",
-	.mpu_irqs	= omap2_timer1_mpu_irqs,
 	.main_clk	= "gpt1_fck",
 	.prcm		= {
 		.omap2 = {
@@ -276,7 +264,6 @@ struct omap_hwmod omap2xxx_timer1_hwmod = {
 
 struct omap_hwmod omap2xxx_timer2_hwmod = {
 	.name		= "timer2",
-	.mpu_irqs	= omap2_timer2_mpu_irqs,
 	.main_clk	= "gpt2_fck",
 	.prcm		= {
 		.omap2 = {
@@ -295,7 +282,6 @@ struct omap_hwmod omap2xxx_timer2_hwmod = {
 
 struct omap_hwmod omap2xxx_timer3_hwmod = {
 	.name		= "timer3",
-	.mpu_irqs	= omap2_timer3_mpu_irqs,
 	.main_clk	= "gpt3_fck",
 	.prcm		= {
 		.omap2 = {
@@ -314,7 +300,6 @@ struct omap_hwmod omap2xxx_timer3_hwmod = {
 
 struct omap_hwmod omap2xxx_timer4_hwmod = {
 	.name		= "timer4",
-	.mpu_irqs	= omap2_timer4_mpu_irqs,
 	.main_clk	= "gpt4_fck",
 	.prcm		= {
 		.omap2 = {
@@ -333,7 +318,6 @@ struct omap_hwmod omap2xxx_timer4_hwmod = {
 
 struct omap_hwmod omap2xxx_timer5_hwmod = {
 	.name		= "timer5",
-	.mpu_irqs	= omap2_timer5_mpu_irqs,
 	.main_clk	= "gpt5_fck",
 	.prcm		= {
 		.omap2 = {
@@ -353,7 +337,6 @@ struct omap_hwmod omap2xxx_timer5_hwmod = {
 
 struct omap_hwmod omap2xxx_timer6_hwmod = {
 	.name		= "timer6",
-	.mpu_irqs	= omap2_timer6_mpu_irqs,
 	.main_clk	= "gpt6_fck",
 	.prcm		= {
 		.omap2 = {
@@ -373,7 +356,6 @@ struct omap_hwmod omap2xxx_timer6_hwmod = {
 
 struct omap_hwmod omap2xxx_timer7_hwmod = {
 	.name		= "timer7",
-	.mpu_irqs	= omap2_timer7_mpu_irqs,
 	.main_clk	= "gpt7_fck",
 	.prcm		= {
 		.omap2 = {
@@ -393,7 +375,6 @@ struct omap_hwmod omap2xxx_timer7_hwmod = {
 
 struct omap_hwmod omap2xxx_timer8_hwmod = {
 	.name		= "timer8",
-	.mpu_irqs	= omap2_timer8_mpu_irqs,
 	.main_clk	= "gpt8_fck",
 	.prcm		= {
 		.omap2 = {
@@ -413,7 +394,6 @@ struct omap_hwmod omap2xxx_timer8_hwmod = {
 
 struct omap_hwmod omap2xxx_timer9_hwmod = {
 	.name		= "timer9",
-	.mpu_irqs	= omap2_timer9_mpu_irqs,
 	.main_clk	= "gpt9_fck",
 	.prcm		= {
 		.omap2 = {
@@ -433,7 +413,6 @@ struct omap_hwmod omap2xxx_timer9_hwmod = {
 
 struct omap_hwmod omap2xxx_timer10_hwmod = {
 	.name		= "timer10",
-	.mpu_irqs	= omap2_timer10_mpu_irqs,
 	.main_clk	= "gpt10_fck",
 	.prcm		= {
 		.omap2 = {
@@ -453,7 +432,6 @@ struct omap_hwmod omap2xxx_timer10_hwmod = {
 
 struct omap_hwmod omap2xxx_timer11_hwmod = {
 	.name		= "timer11",
-	.mpu_irqs	= omap2_timer11_mpu_irqs,
 	.main_clk	= "gpt11_fck",
 	.prcm		= {
 		.omap2 = {
@@ -473,7 +451,6 @@ struct omap_hwmod omap2xxx_timer11_hwmod = {
 
 struct omap_hwmod omap2xxx_timer12_hwmod = {
 	.name		= "timer12",
-	.mpu_irqs	= omap2xxx_timer12_mpu_irqs,
 	.main_clk	= "gpt12_fck",
 	.prcm		= {
 		.omap2 = {
@@ -509,8 +486,6 @@ struct omap_hwmod omap2xxx_wd_timer2_hwmod = {
 
 struct omap_hwmod omap2xxx_uart1_hwmod = {
 	.name		= "uart1",
-	.mpu_irqs	= omap2_uart1_mpu_irqs,
-	.sdma_reqs	= omap2_uart1_sdma_reqs,
 	.main_clk	= "uart1_fck",
 	.flags		= DEBUG_OMAP2UART1_FLAGS | HWMOD_SWSUP_SIDLE_ACT,
 	.prcm		= {
@@ -529,8 +504,6 @@ struct omap_hwmod omap2xxx_uart1_hwmod = {
 
 struct omap_hwmod omap2xxx_uart2_hwmod = {
 	.name		= "uart2",
-	.mpu_irqs	= omap2_uart2_mpu_irqs,
-	.sdma_reqs	= omap2_uart2_sdma_reqs,
 	.main_clk	= "uart2_fck",
 	.flags		= DEBUG_OMAP2UART2_FLAGS | HWMOD_SWSUP_SIDLE_ACT,
 	.prcm		= {
@@ -549,8 +522,6 @@ struct omap_hwmod omap2xxx_uart2_hwmod = {
 
 struct omap_hwmod omap2xxx_uart3_hwmod = {
 	.name		= "uart3",
-	.mpu_irqs	= omap2_uart3_mpu_irqs,
-	.sdma_reqs	= omap2_uart3_sdma_reqs,
 	.main_clk	= "uart3_fck",
 	.flags		= DEBUG_OMAP2UART3_FLAGS | HWMOD_SWSUP_SIDLE_ACT,
 	.prcm		= {
@@ -657,7 +628,6 @@ struct omap_gpio_dev_attr omap2xxx_gpio_dev_attr = {
 struct omap_hwmod omap2xxx_gpio1_hwmod = {
 	.name		= "gpio1",
 	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
-	.mpu_irqs	= omap2_gpio1_irqs,
 	.main_clk	= "gpios_fck",
 	.prcm		= {
 		.omap2 = {
@@ -676,7 +646,6 @@ struct omap_hwmod omap2xxx_gpio1_hwmod = {
 struct omap_hwmod omap2xxx_gpio2_hwmod = {
 	.name		= "gpio2",
 	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
-	.mpu_irqs	= omap2_gpio2_irqs,
 	.main_clk	= "gpios_fck",
 	.prcm		= {
 		.omap2 = {
@@ -695,7 +664,6 @@ struct omap_hwmod omap2xxx_gpio2_hwmod = {
 struct omap_hwmod omap2xxx_gpio3_hwmod = {
 	.name		= "gpio3",
 	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
-	.mpu_irqs	= omap2_gpio3_irqs,
 	.main_clk	= "gpios_fck",
 	.prcm		= {
 		.omap2 = {
@@ -714,7 +682,6 @@ struct omap_hwmod omap2xxx_gpio3_hwmod = {
 struct omap_hwmod omap2xxx_gpio4_hwmod = {
 	.name		= "gpio4",
 	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
-	.mpu_irqs	= omap2_gpio4_irqs,
 	.main_clk	= "gpios_fck",
 	.prcm		= {
 		.omap2 = {
@@ -736,8 +703,6 @@ static struct omap2_mcspi_dev_attr omap_mcspi1_dev_attr = {
 
 struct omap_hwmod omap2xxx_mcspi1_hwmod = {
 	.name		= "mcspi1",
-	.mpu_irqs	= omap2_mcspi1_mpu_irqs,
-	.sdma_reqs	= omap2_mcspi1_sdma_reqs,
 	.main_clk	= "mcspi1_fck",
 	.prcm		= {
 		.omap2 = {
@@ -759,8 +724,6 @@ static struct omap2_mcspi_dev_attr omap_mcspi2_dev_attr = {
 
 struct omap_hwmod omap2xxx_mcspi2_hwmod = {
 	.name		= "mcspi2",
-	.mpu_irqs	= omap2_mcspi2_mpu_irqs,
-	.sdma_reqs	= omap2_mcspi2_sdma_reqs,
 	.main_clk	= "mcspi2_fck",
 	.prcm		= {
 		.omap2 = {
@@ -795,15 +758,9 @@ struct omap_hwmod omap2xxx_counter_32k_hwmod = {
 };
 
 /* gpmc */
-static struct omap_hwmod_irq_info omap2xxx_gpmc_irqs[] = {
-	{ .irq = 20 },
-	{ .irq = -1 }
-};
-
 struct omap_hwmod omap2xxx_gpmc_hwmod = {
 	.name		= "gpmc",
 	.class		= &omap2xxx_gpmc_hwmod_class,
-	.mpu_irqs	= omap2xxx_gpmc_irqs,
 	.main_clk	= "gpmc_fck",
 	/*
 	 * XXX HWMOD_INIT_NO_RESET should not be needed for this IP
@@ -840,14 +797,8 @@ static struct omap_hwmod_class omap2_rng_hwmod_class = {
 	.sysc		= &omap2_rng_sysc,
 };
 
-static struct omap_hwmod_irq_info omap2_rng_mpu_irqs[] = {
-	{ .irq = 52 },
-	{ .irq = -1 }
-};
-
 struct omap_hwmod omap2xxx_rng_hwmod = {
 	.name		= "rng",
-	.mpu_irqs	= omap2_rng_mpu_irqs,
 	.main_clk	= "l4_ck",
 	.prcm		= {
 		.omap2 = {
@@ -884,20 +835,8 @@ static struct omap_hwmod_class omap2xxx_sham_class = {
 	.sysc	= &omap2_sham_sysc,
 };
 
-static struct omap_hwmod_irq_info omap2_sham_mpu_irqs[] = {
-	{ .irq = 51 + OMAP_INTC_START, },
-	{ .irq = -1 }
-};
-
-static struct omap_hwmod_dma_info omap2_sham_sdma_chs[] = {
-	{ .name = "rx", .dma_req = 13 },
-	{ .dma_req = -1 }
-};
-
 struct omap_hwmod omap2xxx_sham_hwmod = {
 	.name		= "sham",
-	.mpu_irqs	= omap2_sham_mpu_irqs,
-	.sdma_reqs	= omap2_sham_sdma_chs,
 	.main_clk	= "l4_ck",
 	.prcm		= {
 		.omap2 = {
@@ -927,15 +866,8 @@ static struct omap_hwmod_class omap2xxx_aes_class = {
 	.sysc	= &omap2_aes_sysc,
 };
 
-static struct omap_hwmod_dma_info omap2_aes_sdma_chs[] = {
-	{ .name = "tx", .dma_req = 9 },
-	{ .name = "rx", .dma_req = 10 },
-	{ .dma_req = -1 }
-};
-
 struct omap_hwmod omap2xxx_aes_hwmod = {
 	.name		= "aes",
-	.sdma_reqs	= omap2_aes_sdma_chs,
 	.main_clk	= "l4_ck",
 	.prcm		= {
 		.omap2 = {
diff --git a/arch/arm/mach-omap2/omap_hwmod_common_data.h b/arch/arm/mach-omap2/omap_hwmod_common_data.h
index 6e04ff7..2c38c6b 100644
--- a/arch/arm/mach-omap2/omap_hwmod_common_data.h
+++ b/arch/arm/mach-omap2/omap_hwmod_common_data.h
@@ -18,9 +18,6 @@
 #include "common.h"
 #include "display.h"
 
-/* Common address space across OMAP2xxx */
-extern struct omap_hwmod_addr_space omap2xxx_mcbsp2_addrs[];
-
 /* Common address space across OMAP2xxx/3xxx */
 extern struct omap_hwmod_addr_space omap2_i2c1_addr_space[];
 extern struct omap_hwmod_addr_space omap2_i2c2_addr_space[];
@@ -41,8 +38,6 @@ extern struct omap_hwmod_addr_space omap2_mcbsp1_addrs[];
 extern struct omap_hwmod_addr_space omap2_hdq1w_addr_space[];
 
 /* Common IP block data across OMAP2xxx */
-extern struct omap_hwmod_irq_info omap2xxx_timer12_mpu_irqs[];
-extern struct omap_hwmod_dma_info omap2xxx_dss_sdma_chs[];
 extern struct omap_gpio_dev_attr omap2xxx_gpio_dev_attr;
 extern struct omap_hwmod omap2xxx_l3_main_hwmod;
 extern struct omap_hwmod omap2xxx_l4_core_hwmod;
-- 
1.8.1.1


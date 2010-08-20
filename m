From: "kishore kadiyala" <kishore.kadiyala@ti.com>
Subject: [PATCH 04/10] [PM-WIP-MMC] OMAP4 hwmod: Adding hwmod data for MMC
     controller
Date: Sat, 21 Aug 2010 01:40:45 +0530 (IST)
Message-ID: <16107.10.24.255.18.1282335045.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:49278 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751442Ab0HTUKs (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 20 Aug 2010 16:10:48 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, tony@atomide.com, b-cousson@ti.com

From: Benoit Cousson <b-cousson@ti.com>
Adding hwmod data for 5 MMC controllers on OMAP4.

Cc: Kevin Hilman <khilman@deeprootsystems.com>
Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Signed-off-by: Kishore Kadiyala <kishore.kadiyala@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |  320 +++++++++++++++++++++++++++-
 1 files changed, 319 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index e20b0ee..b7268f6 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -47,6 +47,8 @@ static struct omap_hwmod omap44xx_l4_per_hwmod;
 static struct omap_hwmod omap44xx_l4_wkup_hwmod;
 static struct omap_hwmod omap44xx_mpu_hwmod;
 static struct omap_hwmod omap44xx_mpu_private_hwmod;
+static struct omap_hwmod omap44xx_mmc1_hwmod;
+static struct omap_hwmod omap44xx_mmc2_hwmod;

 /*
  * Interconnects omap_hwmod structures
@@ -167,6 +169,22 @@ static struct omap_hwmod omap44xx_l3_instr_hwmod = {
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };

+/* mmc2 -> l3_main_1 */
+static struct omap_hwmod_ocp_if omap44xx_mmc2__l3_main_1 = {
+	.master		= &omap44xx_mmc2_hwmod,
+	.slave		= &omap44xx_l3_main_1_hwmod,
+	.clk		= "l3_div_ck",
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* mmc1 -> l3_main_1 */
+static struct omap_hwmod_ocp_if omap44xx_mmc1__l3_main_1 = {
+	.master		= &omap44xx_mmc1_hwmod,
+	.slave		= &omap44xx_l3_main_1_hwmod,
+	.clk		= "l3_div_ck",
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
 /* l3_main_2 -> l3_main_1 */
 static struct omap_hwmod_ocp_if omap44xx_l3_main_2__l3_main_1 = {
 	.master		= &omap44xx_l3_main_2_hwmod,
@@ -193,6 +211,8 @@ static struct omap_hwmod_ocp_if omap44xx_mpu__l3_main_1 = {

 /* l3_main_1 slave ports */
 static struct omap_hwmod_ocp_if *omap44xx_l3_main_1_slaves[] = {
+	&omap44xx_mmc2__l3_main_1,
+	&omap44xx_mmc1__l3_main_1,
 	&omap44xx_l3_main_2__l3_main_1,
 	&omap44xx_l4_cfg__l3_main_1,
 	&omap44xx_mpu__l3_main_1,
@@ -383,6 +403,299 @@ static struct omap_hwmod omap44xx_l4_wkup_hwmod = {
 };

 /*
+ * 'mmc' class
+ * multimedia card high-speed/sd/sdio (mmc/sd/sdio) host controller
+ */
+
+static struct omap_hwmod_class_sysconfig omap44xx_mmc_sysc = {
+	.rev_offs	= 0x0000,
+	.sysc_offs	= 0x0010,
+	.syss_offs	= 0x0114,
+	.sysc_flags	= (SYSC_HAS_SIDLEMODE | SYSC_HAS_EMUFREE |
+			   SYSC_HAS_SOFTRESET | SYSC_HAS_MIDLEMODE),
+	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART |
+			   MSTANDBY_FORCE | MSTANDBY_NO | MSTANDBY_SMART),
+	.sysc_fields	= &omap_hwmod_sysc_type2,
+};
+
+static struct omap_hwmod_class omap44xx_mmc_hwmod_class = {
+	.name = "mmc",
+	.sysc = &omap44xx_mmc_sysc,
+};
+
+/* mmc1 */
+static struct omap_hwmod_irq_info omap44xx_mmc1_irqs[] = {
+	{ .irq = 83 + OMAP44XX_IRQ_GIC_START },
+};
+
+static struct omap_hwmod_dma_info omap44xx_mmc1_sdma_reqs[] = {
+	{ .name = "tx", .dma_req = 60 + OMAP44XX_DMA_REQ_START },
+	{ .name = "rx", .dma_req = 61 + OMAP44XX_DMA_REQ_START },
+};
+
+/* mmc1 master ports */
+static struct omap_hwmod_ocp_if *omap44xx_mmc1_masters[] = {
+	&omap44xx_mmc1__l3_main_1,
+};
+
+static struct omap_hwmod_addr_space omap44xx_mmc1_addrs[] = {
+	{
+		.pa_start	= 0x4809c000,
+		.pa_end		= 0x4809c3ff,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+
+/* l4_per -> mmc1 */
+static struct omap_hwmod_ocp_if omap44xx_l4_per__mmc1 = {
+	.master		= &omap44xx_l4_per_hwmod,
+	.slave		= &omap44xx_mmc1_hwmod,
+	.clk		= "l4_div_ck",
+	.addr		= omap44xx_mmc1_addrs,
+	.addr_cnt	= ARRAY_SIZE(omap44xx_mmc1_addrs),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* mmc1 slave ports */
+static struct omap_hwmod_ocp_if *omap44xx_mmc1_slaves[] = {
+	&omap44xx_l4_per__mmc1,
+};
+
+static struct omap_hwmod omap44xx_mmc1_hwmod = {
+	.name		= "mmc1",
+	.class		= &omap44xx_mmc_hwmod_class,
+	.mpu_irqs	= omap44xx_mmc1_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_mmc1_irqs),
+	.sdma_reqs	= omap44xx_mmc1_sdma_reqs,
+	.sdma_reqs_cnt	= ARRAY_SIZE(omap44xx_mmc1_sdma_reqs),
+	.main_clk	= "mmc1_fck",
+	.prcm = {
+		.omap4 = {
+			.clkctrl_reg = OMAP4430_CM_L3INIT_MMC1_CLKCTRL,
+		},
+	},
+	.slaves		= omap44xx_mmc1_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap44xx_mmc1_slaves),
+	.masters	= omap44xx_mmc1_masters,
+	.masters_cnt	= ARRAY_SIZE(omap44xx_mmc1_masters),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+};
+
+/* mmc2 */
+static struct omap_hwmod_irq_info omap44xx_mmc2_irqs[] = {
+	{ .irq = 86 + OMAP44XX_IRQ_GIC_START },
+};
+
+static struct omap_hwmod_dma_info omap44xx_mmc2_sdma_reqs[] = {
+	{ .name = "tx", .dma_req = 46 + OMAP44XX_DMA_REQ_START },
+	{ .name = "rx", .dma_req = 47 + OMAP44XX_DMA_REQ_START },
+};
+
+/* mmc2 master ports */
+static struct omap_hwmod_ocp_if *omap44xx_mmc2_masters[] = {
+	&omap44xx_mmc2__l3_main_1,
+};
+
+static struct omap_hwmod_addr_space omap44xx_mmc2_addrs[] = {
+	{
+		.pa_start	= 0x480b4000,
+		.pa_end		= 0x480b43ff,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+
+/* l4_per -> mmc2 */
+static struct omap_hwmod_ocp_if omap44xx_l4_per__mmc2 = {
+	.master		= &omap44xx_l4_per_hwmod,
+	.slave		= &omap44xx_mmc2_hwmod,
+	.clk		= "l4_div_ck",
+	.addr		= omap44xx_mmc2_addrs,
+	.addr_cnt	= ARRAY_SIZE(omap44xx_mmc2_addrs),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* mmc2 slave ports */
+static struct omap_hwmod_ocp_if *omap44xx_mmc2_slaves[] = {
+	&omap44xx_l4_per__mmc2,
+};
+
+static struct omap_hwmod omap44xx_mmc2_hwmod = {
+	.name		= "mmc2",
+	.class		= &omap44xx_mmc_hwmod_class,
+	.mpu_irqs	= omap44xx_mmc2_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_mmc2_irqs),
+	.sdma_reqs	= omap44xx_mmc2_sdma_reqs,
+	.sdma_reqs_cnt	= ARRAY_SIZE(omap44xx_mmc2_sdma_reqs),
+	.main_clk	= "mmc2_fck",
+	.prcm = {
+		.omap4 = {
+			.clkctrl_reg = OMAP4430_CM_L3INIT_MMC2_CLKCTRL,
+		},
+	},
+	.slaves		= omap44xx_mmc2_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap44xx_mmc2_slaves),
+	.masters	= omap44xx_mmc2_masters,
+	.masters_cnt	= ARRAY_SIZE(omap44xx_mmc2_masters),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+};
+
+/* mmc3 */
+static struct omap_hwmod omap44xx_mmc3_hwmod;
+static struct omap_hwmod_irq_info omap44xx_mmc3_irqs[] = {
+	{ .irq = 94 + OMAP44XX_IRQ_GIC_START },
+};
+
+static struct omap_hwmod_dma_info omap44xx_mmc3_sdma_reqs[] = {
+	{ .name = "tx", .dma_req = 76 + OMAP44XX_DMA_REQ_START },
+	{ .name = "rx", .dma_req = 77 + OMAP44XX_DMA_REQ_START },
+};
+
+static struct omap_hwmod_addr_space omap44xx_mmc3_addrs[] = {
+	{
+		.pa_start	= 0x480ad000,
+		.pa_end		= 0x480ad3ff,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+
+/* l4_per -> mmc3 */
+static struct omap_hwmod_ocp_if omap44xx_l4_per__mmc3 = {
+	.master		= &omap44xx_l4_per_hwmod,
+	.slave		= &omap44xx_mmc3_hwmod,
+	.clk		= "l4_div_ck",
+	.addr		= omap44xx_mmc3_addrs,
+	.addr_cnt	= ARRAY_SIZE(omap44xx_mmc3_addrs),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* mmc3 slave ports */
+static struct omap_hwmod_ocp_if *omap44xx_mmc3_slaves[] = {
+	&omap44xx_l4_per__mmc3,
+};
+
+static struct omap_hwmod omap44xx_mmc3_hwmod = {
+	.name		= "mmc3",
+	.class		= &omap44xx_mmc_hwmod_class,
+	.mpu_irqs	= omap44xx_mmc3_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_mmc3_irqs),
+	.sdma_reqs	= omap44xx_mmc3_sdma_reqs,
+	.sdma_reqs_cnt	= ARRAY_SIZE(omap44xx_mmc3_sdma_reqs),
+	.main_clk	= "mmc3_fck",
+	.prcm = {
+		.omap4 = {
+			.clkctrl_reg = OMAP4430_CM_L4PER_MMCSD3_CLKCTRL,
+		},
+	},
+	.slaves		= omap44xx_mmc3_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap44xx_mmc3_slaves),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+};
+
+/* mmc4 */
+static struct omap_hwmod omap44xx_mmc4_hwmod;
+static struct omap_hwmod_irq_info omap44xx_mmc4_irqs[] = {
+	{ .irq = 96 + OMAP44XX_IRQ_GIC_START },
+};
+
+static struct omap_hwmod_dma_info omap44xx_mmc4_sdma_reqs[] = {
+	{ .name = "tx", .dma_req = 56 + OMAP44XX_DMA_REQ_START },
+	{ .name = "rx", .dma_req = 57 + OMAP44XX_DMA_REQ_START },
+};
+
+static struct omap_hwmod_addr_space omap44xx_mmc4_addrs[] = {
+	{
+		.pa_start	= 0x480d1000,
+		.pa_end		= 0x480d13ff,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+
+/* l4_per -> mmc4 */
+static struct omap_hwmod_ocp_if omap44xx_l4_per__mmc4 = {
+	.master		= &omap44xx_l4_per_hwmod,
+	.slave		= &omap44xx_mmc4_hwmod,
+	.clk		= "l4_div_ck",
+	.addr		= omap44xx_mmc4_addrs,
+	.addr_cnt	= ARRAY_SIZE(omap44xx_mmc4_addrs),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* mmc4 slave ports */
+static struct omap_hwmod_ocp_if *omap44xx_mmc4_slaves[] = {
+	&omap44xx_l4_per__mmc4,
+};
+
+static struct omap_hwmod omap44xx_mmc4_hwmod = {
+	.name		= "mmc4",
+	.class		= &omap44xx_mmc_hwmod_class,
+	.mpu_irqs	= omap44xx_mmc4_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_mmc4_irqs),
+	.sdma_reqs	= omap44xx_mmc4_sdma_reqs,
+	.sdma_reqs_cnt	= ARRAY_SIZE(omap44xx_mmc4_sdma_reqs),
+	.main_clk	= "mmc4_fck",
+	.prcm = {
+		.omap4 = {
+			.clkctrl_reg = OMAP4430_CM_L4PER_MMCSD4_CLKCTRL,
+		},
+	},
+	.slaves		= omap44xx_mmc4_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap44xx_mmc4_slaves),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+};
+
+/* mmc5 */
+static struct omap_hwmod omap44xx_mmc5_hwmod;
+static struct omap_hwmod_irq_info omap44xx_mmc5_irqs[] = {
+	{ .irq = 59 + OMAP44XX_IRQ_GIC_START },
+};
+
+static struct omap_hwmod_dma_info omap44xx_mmc5_sdma_reqs[] = {
+	{ .name = "tx", .dma_req = 58 + OMAP44XX_DMA_REQ_START },
+	{ .name = "rx", .dma_req = 59 + OMAP44XX_DMA_REQ_START },
+};
+
+static struct omap_hwmod_addr_space omap44xx_mmc5_addrs[] = {
+	{
+		.pa_start	= 0x480d5000,
+		.pa_end		= 0x480d53ff,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+
+/* l4_per -> mmc5 */
+static struct omap_hwmod_ocp_if omap44xx_l4_per__mmc5 = {
+	.master		= &omap44xx_l4_per_hwmod,
+	.slave		= &omap44xx_mmc5_hwmod,
+	.clk		= "l4_div_ck",
+	.addr		= omap44xx_mmc5_addrs,
+	.addr_cnt	= ARRAY_SIZE(omap44xx_mmc5_addrs),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* mmc5 slave ports */
+static struct omap_hwmod_ocp_if *omap44xx_mmc5_slaves[] = {
+	&omap44xx_l4_per__mmc5,
+};
+
+static struct omap_hwmod omap44xx_mmc5_hwmod = {
+	.name		= "mmc5",
+	.class		= &omap44xx_mmc_hwmod_class,
+	.mpu_irqs	= omap44xx_mmc5_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_mmc5_irqs),
+	.sdma_reqs	= omap44xx_mmc5_sdma_reqs,
+	.sdma_reqs_cnt	= ARRAY_SIZE(omap44xx_mmc5_sdma_reqs),
+	.main_clk	= "mmc5_fck",
+	.prcm = {
+		.omap4 = {
+			.clkctrl_reg = OMAP4430_CM_L4PER_MMCSD5_CLKCTRL,
+		},
+	},
+	.slaves		= omap44xx_mmc5_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap44xx_mmc5_slaves),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+};
+
+/*
  * 'mpu_bus' class
  * instance(s): mpu_private
  */
@@ -469,7 +782,12 @@ static __initdata struct omap_hwmod *omap44xx_hwmods[] = {
 	&omap44xx_l4_wkup_hwmod,
 	/* mpu_bus class */
 	&omap44xx_mpu_private_hwmod,
-
+	/* mmc class */
+	&omap44xx_mmc1_hwmod,
+	&omap44xx_mmc2_hwmod,
+	&omap44xx_mmc3_hwmod,
+	&omap44xx_mmc4_hwmod,
+	&omap44xx_mmc5_hwmod,
 	/* mpu class */
 	&omap44xx_mpu_hwmod,
 	NULL,
-- 
1.7.0.4



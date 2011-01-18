From: "Govindraj.R" <govindraj.raja@ti.com>
Subject: [PATCH v4 3/6] OMAP3: hwmod data: Add McSPI
Date: Tue, 18 Jan 2011 19:22:36 +0530
Message-ID: <1295358759-11731-4-git-send-email-govindraj.raja@ti.com>
References: <1295358759-11731-1-git-send-email-govindraj.raja@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:43584 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751018Ab1ARNhv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 Jan 2011 08:37:51 -0500
In-Reply-To: <1295358759-11731-1-git-send-email-govindraj.raja@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, spi-devel-general@lists.sourceforge.net, linux-arm-kernel@lists.infradead.org
Cc: grant.likely@secretlab.ca, charu@ti.com, b-cousson@ti.com, paul@pwsan.com, khilman@ti.com, tony@atomide.com, "Govindraj.R" <govindraj.raja@ti.com>

From: Charulatha V <charu@ti.com>

Update omap3 hwmod data file with McSPI info.

Signed-off-by: Charulatha V <charu@ti.com>
Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
Acked-by: Grant Likely <grant.likely@secretlab.ca>
---
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |  280 ++++++++++++++++++++++++++++
 1 files changed, 280 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index 8d81813..800eda4 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -22,6 +22,7 @@
 #include <plat/i2c.h>
 #include <plat/gpio.h>
 #include <plat/smartreflex.h>
+#include <plat/mcspi.h>
 
 #include "omap_hwmod_common_data.h"
 
@@ -55,6 +56,10 @@ static struct omap_hwmod omap3xxx_gpio5_hwmod;
 static struct omap_hwmod omap3xxx_gpio6_hwmod;
 static struct omap_hwmod omap34xx_sr1_hwmod;
 static struct omap_hwmod omap34xx_sr2_hwmod;
+static struct omap_hwmod omap34xx_mcspi1;
+static struct omap_hwmod omap34xx_mcspi2;
+static struct omap_hwmod omap34xx_mcspi3;
+static struct omap_hwmod omap34xx_mcspi4;
 
 static struct omap_hwmod omap3xxx_dma_system_hwmod;
 
@@ -1356,6 +1361,275 @@ static struct omap_hwmod omap36xx_sr2_hwmod = {
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3630ES1),
 };
 
+/* l4 core -> mcspi1 interface */
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
+/* l4 core -> mcspi2 interface */
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
+/* l4 core -> mcspi3 interface */
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
+/* l4 core -> mcspi4 interface */
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
+/*
+ * 'mcspi' class
+ * multichannel serial port interface (mcspi) / master/slave synchronous serial
+ * bus
+ */
+
+static struct omap_hwmod_class_sysconfig omap34xx_mcspi_sysc = {
+	.rev_offs	= 0x0000,
+	.sysc_offs	= 0x0010,
+	.syss_offs	= 0x0014,
+	.sysc_flags	= (SYSC_HAS_CLOCKACTIVITY | SYSC_HAS_SIDLEMODE |
+				SYSC_HAS_ENAWAKEUP | SYSC_HAS_SOFTRESET |
+				SYSC_HAS_AUTOIDLE | SYSS_HAS_RESET_STATUS),
+	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
+	.sysc_fields    = &omap_hwmod_sysc_type1,
+};
+
+static struct omap_hwmod_class omap34xx_mcspi_class = {
+	.name = "mcspi",
+	.sysc = &omap34xx_mcspi_sysc,
+	.rev = OMAP3_MCSPI_REV,
+};
+
+/* mcspi1 */
+static struct omap_hwmod_irq_info omap34xx_mcspi1_mpu_irqs[] = {
+	{ .name = "irq", .irq = 65 },
+};
+
+static struct omap_hwmod_dma_info omap34xx_mcspi1_sdma_reqs[] = {
+	{ .name = "tx0", .dma_req = 35 },
+	{ .name = "rx0", .dma_req = 36 },
+	{ .name = "tx1", .dma_req = 37 },
+	{ .name = "rx1", .dma_req = 38 },
+	{ .name = "tx2", .dma_req = 39 },
+	{ .name = "rx2", .dma_req = 40 },
+	{ .name = "tx3", .dma_req = 41 },
+	{ .name = "rx3", .dma_req = 42 },
+};
+
+static struct omap_hwmod_ocp_if *omap34xx_mcspi1_slaves[] = {
+	&omap34xx_l4_core__mcspi1,
+};
+
+static struct omap2_mcspi_dev_attr omap_mcspi1_dev_attr = {
+	.num_chipselect = 4,
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
+			.idlest_idle_bit = OMAP3430_ST_MCSPI1_SHIFT,
+		},
+	},
+	.slaves		= omap34xx_mcspi1_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap34xx_mcspi1_slaves),
+	.class		= &omap34xx_mcspi_class,
+	.dev_attr       = &omap_mcspi1_dev_attr,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+};
+
+/* mcspi2 */
+static struct omap_hwmod_irq_info omap34xx_mcspi2_mpu_irqs[] = {
+	{ .name = "irq", .irq = 66 },
+};
+
+static struct omap_hwmod_dma_info omap34xx_mcspi2_sdma_reqs[] = {
+	{ .name = "tx0", .dma_req = 43 },
+	{ .name = "rx0", .dma_req = 44 },
+	{ .name = "tx1", .dma_req = 45 },
+	{ .name = "rx1", .dma_req = 46 },
+};
+
+static struct omap_hwmod_ocp_if *omap34xx_mcspi2_slaves[] = {
+	&omap34xx_l4_core__mcspi2,
+};
+
+static struct omap2_mcspi_dev_attr omap_mcspi2_dev_attr = {
+	.num_chipselect = 2,
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
+			.idlest_idle_bit = OMAP3430_ST_MCSPI2_SHIFT,
+		},
+	},
+	.slaves		= omap34xx_mcspi2_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap34xx_mcspi2_slaves),
+	.class		= &omap34xx_mcspi_class,
+	.dev_attr       = &omap_mcspi2_dev_attr,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+};
+
+/* mcspi3 */
+static struct omap_hwmod_irq_info omap34xx_mcspi3_mpu_irqs[] = {
+	{ .name = "irq", .irq = 91 }, /* 91 */
+};
+
+static struct omap_hwmod_dma_info omap34xx_mcspi3_sdma_reqs[] = {
+	{ .name = "tx0", .dma_req = 15 },
+	{ .name = "rx0", .dma_req = 16 },
+	{ .name = "tx1", .dma_req = 23 },
+	{ .name = "rx1", .dma_req = 24 },
+};
+
+static struct omap_hwmod_ocp_if *omap34xx_mcspi3_slaves[] = {
+	&omap34xx_l4_core__mcspi3,
+};
+
+static struct omap2_mcspi_dev_attr omap_mcspi3_dev_attr = {
+	.num_chipselect = 2,
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
+			.idlest_idle_bit = OMAP3430_ST_MCSPI3_SHIFT,
+		},
+	},
+	.slaves		= omap34xx_mcspi3_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap34xx_mcspi3_slaves),
+	.class		= &omap34xx_mcspi_class,
+	.dev_attr       = &omap_mcspi3_dev_attr,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+};
+
+/* SPI4 */
+static struct omap_hwmod_irq_info omap34xx_mcspi4_mpu_irqs[] = {
+	{ .name = "irq", .irq = INT_34XX_SPI4_IRQ }, /* 48 */
+};
+
+static struct omap_hwmod_dma_info omap34xx_mcspi4_sdma_reqs[] = {
+	{ .name = "tx0", .dma_req = 70 }, /* DMA_SPI4_TX0 */
+	{ .name = "rx0", .dma_req = 71 }, /* DMA_SPI4_RX0 */
+};
+
+static struct omap_hwmod_ocp_if *omap34xx_mcspi4_slaves[] = {
+	&omap34xx_l4_core__mcspi4,
+};
+
+static struct omap2_mcspi_dev_attr omap_mcspi4_dev_attr = {
+	.num_chipselect = 1,
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
+			.idlest_idle_bit = OMAP3430_ST_MCSPI4_SHIFT,
+		},
+	},
+	.slaves		= omap34xx_mcspi4_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap34xx_mcspi4_slaves),
+	.class		= &omap34xx_mcspi_class,
+	.dev_attr       = &omap_mcspi4_dev_attr,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+};
+
 static __initdata struct omap_hwmod *omap3xxx_hwmods[] = {
 	&omap3xxx_l3_main_hwmod,
 	&omap3xxx_l4_core_hwmod,
@@ -1387,6 +1661,12 @@ static __initdata struct omap_hwmod *omap3xxx_hwmods[] = {
 
 	/* dma_system class*/
 	&omap3xxx_dma_system_hwmod,
+
+	/* mcspi class */
+	&omap34xx_mcspi1,
+	&omap34xx_mcspi2,
+	&omap34xx_mcspi3,
+	&omap34xx_mcspi4,
 	NULL,
 };
 
-- 
1.7.1


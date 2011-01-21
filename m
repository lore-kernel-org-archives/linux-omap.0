From: "Govindraj.R" <govindraj.raja@ti.com>
Subject: [PATCH v5 2/6] OMAP2430: hwmod data: Add McSPI
Date: Fri, 21 Jan 2011 18:25:43 +0530
Message-ID: <1295614547-1920-3-git-send-email-govindraj.raja@ti.com>
References: <1295614547-1920-1-git-send-email-govindraj.raja@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:38216 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754200Ab1AUMkR (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 21 Jan 2011 07:40:17 -0500
In-Reply-To: <1295614547-1920-1-git-send-email-govindraj.raja@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, spi-devel-general@lists.sourceforge.net, linux-arm-kernel@lists.infradead.org
Cc: Charulatha V <charu@ti.com>, Tony Lindgren <tony@atomide.com>, Grant Likely <grant.likely@secretlab.ca>, Benoit Cousson <b-cousson@ti.com>, Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, "Govindraj.R" <govindraj.raja@ti.com>

From: Charulatha V <charu@ti.com>

Update the 2430 hwmod data file with McSPI info.

Signed-off-by: Charulatha V <charu@ti.com>
Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
Acked-by: Grant Likely <grant.likely@secretlab.ca>
---
 arch/arm/mach-omap2/omap_hwmod_2430_data.c |  219 ++++++++++++++++++++++++++++
 1 files changed, 219 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_2430_data.c b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
index 8ecfbcd..60fe4aa 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2430_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
@@ -18,6 +18,7 @@
 #include <plat/serial.h>
 #include <plat/i2c.h>
 #include <plat/gpio.h>
+#include <plat/mcspi.h>
 
 #include "omap_hwmod_common_data.h"
 
@@ -45,6 +46,9 @@ static struct omap_hwmod omap2430_gpio3_hwmod;
 static struct omap_hwmod omap2430_gpio4_hwmod;
 static struct omap_hwmod omap2430_gpio5_hwmod;
 static struct omap_hwmod omap2430_dma_system_hwmod;
+static struct omap_hwmod omap2430_mcspi1_hwmod;
+static struct omap_hwmod omap2430_mcspi2_hwmod;
+static struct omap_hwmod omap2430_mcspi3_hwmod;
 
 /* L3 -> L4_CORE interface */
 static struct omap_hwmod_ocp_if omap2430_l3_main__l4_core = {
@@ -223,6 +227,60 @@ static struct omap_hwmod_ocp_if *omap2430_l4_wkup_slaves[] = {
 static struct omap_hwmod_ocp_if *omap2430_l4_wkup_masters[] = {
 };
 
+/* l4 core -> mcspi1 interface */
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
+/* l4 core -> mcspi2 interface */
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
+/* l4 core -> mcspi3 interface */
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
@@ -919,6 +977,162 @@ static struct omap_hwmod omap2430_dma_system_hwmod = {
 	.flags		= HWMOD_NO_IDLEST,
 };
 
+/*
+ * 'mcspi' class
+ * multichannel serial port interface (mcspi) / master/slave synchronous serial
+ * bus
+ */
+
+static struct omap_hwmod_class_sysconfig omap2430_mcspi_sysc = {
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
+static struct omap_hwmod_class omap2430_mcspi_class = {
+	.name = "mcspi",
+	.sysc = &omap2430_mcspi_sysc,
+	.rev = OMAP2_MCSPI_REV,
+};
+
+/* mcspi1 */
+static struct omap_hwmod_irq_info omap2430_mcspi1_mpu_irqs[] = {
+	{ .irq = 65 },
+};
+
+static struct omap_hwmod_dma_info omap2430_mcspi1_sdma_reqs[] = {
+	{ .name = "tx0", .dma_req = 35 }, /* DMA_SPI1_TX0 */
+	{ .name = "rx0", .dma_req = 36 }, /* DMA_SPI1_RX0 */
+	{ .name = "tx1", .dma_req = 37 }, /* DMA_SPI1_TX1 */
+	{ .name = "rx1", .dma_req = 38 }, /* DMA_SPI1_RX1 */
+	{ .name = "tx2", .dma_req = 39 }, /* DMA_SPI1_TX2 */
+	{ .name = "rx2", .dma_req = 40 }, /* DMA_SPI1_RX2 */
+	{ .name = "tx3", .dma_req = 41 }, /* DMA_SPI1_TX3 */
+	{ .name = "rx3", .dma_req = 42 }, /* DMA_SPI1_RX3 */
+};
+
+static struct omap_hwmod_ocp_if *omap2430_mcspi1_slaves[] = {
+	&omap2430_l4_core__mcspi1,
+};
+
+static struct omap2_mcspi_dev_attr omap_mcspi1_dev_attr = {
+	.num_chipselect = 4,
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
+			.idlest_idle_bit = OMAP24XX_ST_MCSPI1_SHIFT,
+		},
+	},
+	.slaves		= omap2430_mcspi1_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap2430_mcspi1_slaves),
+	.class		= &omap2430_mcspi_class,
+	.dev_attr       = &omap_mcspi1_dev_attr,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2430),
+};
+
+/* mcspi2 */
+static struct omap_hwmod_irq_info omap2430_mcspi2_mpu_irqs[] = {
+	{ .irq = 66 },
+};
+
+static struct omap_hwmod_dma_info omap2430_mcspi2_sdma_reqs[] = {
+	{ .name = "tx0", .dma_req = 43 }, /* DMA_SPI2_TX0 */
+	{ .name = "rx0", .dma_req = 44 }, /* DMA_SPI2_RX0 */
+	{ .name = "tx1", .dma_req = 45 }, /* DMA_SPI2_TX1 */
+	{ .name = "rx1", .dma_req = 46 }, /* DMA_SPI2_RX1 */
+};
+
+static struct omap_hwmod_ocp_if *omap2430_mcspi2_slaves[] = {
+	&omap2430_l4_core__mcspi2,
+};
+
+static struct omap2_mcspi_dev_attr omap_mcspi2_dev_attr = {
+	.num_chipselect = 2,
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
+			.idlest_idle_bit = OMAP24XX_ST_MCSPI2_SHIFT,
+		},
+	},
+	.slaves		= omap2430_mcspi2_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap2430_mcspi2_slaves),
+	.class		= &omap2430_mcspi_class,
+	.dev_attr       = &omap_mcspi2_dev_attr,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2430),
+};
+
+/* mcspi3 */
+static struct omap_hwmod_irq_info omap2430_mcspi3_mpu_irqs[] = {
+	{ .irq = 91 },
+};
+
+static struct omap_hwmod_dma_info omap2430_mcspi3_sdma_reqs[] = {
+	{ .name = "tx0", .dma_req = 15 }, /* DMA_SPI3_TX0 */
+	{ .name = "rx0", .dma_req = 16 }, /* DMA_SPI3_RX0 */
+	{ .name = "tx1", .dma_req = 23 }, /* DMA_SPI3_TX1 */
+	{ .name = "rx1", .dma_req = 24 }, /* DMA_SPI3_RX1 */
+};
+
+static struct omap_hwmod_ocp_if *omap2430_mcspi3_slaves[] = {
+	&omap2430_l4_core__mcspi3,
+};
+
+static struct omap2_mcspi_dev_attr omap_mcspi3_dev_attr = {
+	.num_chipselect = 2,
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
+			.idlest_idle_bit = OMAP2430_ST_MCSPI3_SHIFT,
+		},
+	},
+	.slaves		= omap2430_mcspi3_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap2430_mcspi3_slaves),
+	.class		= &omap2430_mcspi_class,
+	.dev_attr       = &omap_mcspi3_dev_attr,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2430),
+};
+
 static __initdata struct omap_hwmod *omap2430_hwmods[] = {
 	&omap2430_l3_main_hwmod,
 	&omap2430_l4_core_hwmod,
@@ -941,6 +1155,11 @@ static __initdata struct omap_hwmod *omap2430_hwmods[] = {
 
 	/* dma_system class*/
 	&omap2430_dma_system_hwmod,
+
+	/* mcspi class */
+	&omap2430_mcspi1_hwmod,
+	&omap2430_mcspi2_hwmod,
+	&omap2430_mcspi3_hwmod,
 	NULL,
 };
 
-- 
1.7.1


From: "Govindraj.R" <govindraj.raja@ti.com>
Subject: [PATCH 1/7 v2] OMAP2420: hwmod data: Add McSPI
Date: Wed, 1 Dec 2010 19:31:17 +0530 (IST)
Message-ID: <33230.10.24.255.18.1291212077.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:37605 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755158Ab0LAOBc (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 1 Dec 2010 09:01:32 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, spi-devel-general <spi-devel-general@lists.sourceforge.net>, linux-arm-kernel@lists.infradead.org
Cc: Charulatha V <charu@ti.com>, Cousson@dbdmail.itg.ti.com, Benoit <b-cousson@ti.com>

From: Charulatha V <charu@ti.com>

Update the omap2420 hwmod data with the McSPI info.
Add a device attribute structure which will be used
for passing number of chipselects from hwmod data.
Add revision macros to be passed from rev field from
hwmod.

Signed-off-by: Charulatha V <charu@ti.com>
Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_2420_data.c |  156 ++++++++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/mcspi.h    |    8 ++
 2 files changed, 164 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_2420_data.c b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
index a1a3dd6..ee90151 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2420_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
@@ -17,6 +17,7 @@
 #include <plat/dma.h>
 #include <plat/serial.h>
 #include <plat/i2c.h>
+#include <plat/mcspi.h>
 #include <plat/omap24xx.h>

 #include "omap_hwmod_common_data.h"
@@ -38,6 +39,8 @@ static struct omap_hwmod omap2420_iva_hwmod;
 static struct omap_hwmod omap2420_l3_main_hwmod;
 static struct omap_hwmod omap2420_l4_core_hwmod;
 static struct omap_hwmod omap2420_wd_timer2_hwmod;
+static struct omap_hwmod omap2420_mcspi1_hwmod;
+static struct omap_hwmod omap2420_mcspi2_hwmod;

 /* L3 -> L4_CORE interface */
 static struct omap_hwmod_ocp_if omap2420_l3_main__l4_core = {
@@ -82,6 +85,42 @@ static struct omap_hwmod omap2420_uart3_hwmod;
 static struct omap_hwmod omap2420_i2c1_hwmod;
 static struct omap_hwmod omap2420_i2c2_hwmod;

+/* l4 core -> mcspi1 interface */
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
+/* l4 core -> mcspi2 interface */
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
@@ -557,6 +596,119 @@ static struct omap_hwmod omap2420_i2c2_hwmod = {
 	.flags		= HWMOD_16BIT_REG,
 };

+/*
+ * 'mcspi' class
+ * multichannel serial port interface (mcspi) / master/slave synchronous serial
+ * bus
+ */
+
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
+	.rev = OMAP2_MCSPI_REV,
+};
+
+/* mcspi1 */
+static struct omap_hwmod_irq_info omap2420_mcspi1_mpu_irqs[] = {
+	{ .irq = 65 },
+};
+
+static struct omap_hwmod_dma_info omap2420_mcspi1_sdma_reqs[] = {
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
+static struct omap_hwmod_ocp_if *omap2420_mcspi1_slaves[] = {
+	&omap2420_l4_core__mcspi1,
+};
+
+static struct omap2_mcspi_dev_attr omap_mcspi1_dev_attr = {
+	.num_chipselect = 4,
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
+			.idlest_idle_bit = OMAP24XX_ST_MCSPI1_SHIFT,
+		},
+	},
+	.slaves		= omap2420_mcspi1_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap2420_mcspi1_slaves),
+	.class		= &omap2420_mcspi_class,
+	.dev_attr       = &omap_mcspi1_dev_attr,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2420),
+};
+
+/* mcspi2 */
+static struct omap_hwmod_irq_info omap2420_mcspi2_mpu_irqs[] = {
+	{ .irq = 66 },
+};
+
+static struct omap_hwmod_dma_info omap2420_mcspi2_sdma_reqs[] = {
+	{ .name = "tx0", .dma_req = 43 }, /* DMA_SPI2_TX0 */
+	{ .name = "rx0", .dma_req = 44 }, /* DMA_SPI2_RX0 */
+	{ .name = "tx1", .dma_req = 45 }, /* DMA_SPI2_TX1 */
+	{ .name = "rx1", .dma_req = 46 }, /* DMA_SPI2_RX1 */
+};
+
+static struct omap_hwmod_ocp_if *omap2420_mcspi2_slaves[] = {
+	&omap2420_l4_core__mcspi2,
+};
+
+static struct omap2_mcspi_dev_attr omap_mcspi2_dev_attr = {
+	.num_chipselect = 2,
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
+			.idlest_idle_bit = OMAP24XX_ST_MCSPI2_SHIFT,
+		},
+	},
+	.slaves		= omap2420_mcspi2_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap2420_mcspi2_slaves),
+	.class		= &omap2420_mcspi_class,
+	.dev_attr       = &omap_mcspi2_dev_attr,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2420),
+};
+
 static __initdata struct omap_hwmod *omap2420_hwmods[] = {
 	&omap2420_l3_main_hwmod,
 	&omap2420_l4_core_hwmod,
@@ -569,6 +721,10 @@ static __initdata struct omap_hwmod *omap2420_hwmods[] = {
 	&omap2420_uart3_hwmod,
 	&omap2420_i2c1_hwmod,
 	&omap2420_i2c2_hwmod,
+
+	/* mcspi class */
+	&omap2420_mcspi1_hwmod,
+	&omap2420_mcspi2_hwmod,
 	NULL,
 };

diff --git a/arch/arm/plat-omap/include/plat/mcspi.h b/arch/arm/plat-omap/include/plat/mcspi.h
index 1254e49..560e266 100644
--- a/arch/arm/plat-omap/include/plat/mcspi.h
+++ b/arch/arm/plat-omap/include/plat/mcspi.h
@@ -1,10 +1,18 @@
 #ifndef _OMAP2_MCSPI_H
 #define _OMAP2_MCSPI_H

+#define OMAP2_MCSPI_REV 0
+#define OMAP3_MCSPI_REV 1
+#define OMAP4_MCSPI_REV 2
+
 struct omap2_mcspi_platform_config {
 	unsigned short	num_cs;
 };

+struct omap2_mcspi_dev_attr {
+	unsigned short num_chipselect;
+};
+
 struct omap2_mcspi_device_config {
 	unsigned turbo_mode:1;

-- 
1.7.1



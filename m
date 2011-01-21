From: "Govindraj.R" <govindraj.raja@ti.com>
Subject: [PATCH v5 4/6] OMAP4: hwmod data: Add McSPI
Date: Fri, 21 Jan 2011 18:25:45 +0530
Message-ID: <1295614547-1920-5-git-send-email-govindraj.raja@ti.com>
References: <1295614547-1920-1-git-send-email-govindraj.raja@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:45984 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754403Ab1AUMkT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 Jan 2011 07:40:19 -0500
In-Reply-To: <1295614547-1920-1-git-send-email-govindraj.raja@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, spi-devel-general@lists.sourceforge.net, linux-arm-kernel@lists.infradead.org
Cc: Benoit Cousson <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, Grant Likely <grant.likely@secretlab.ca>, Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, Charulatha V <charu@ti.com>, "Govindraj.R" <govindraj.raja@ti.com>

From: Benoit Cousson <b-cousson@ti.com>

Update omap4 hwmod file with McSPI info.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Signed-off-by: Charulatha V <charu@ti.com>
Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
Acked-by: Grant Likely <grant.likely@secretlab.ca>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |  267 ++++++++++++++++++++++++++++
 1 files changed, 267 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index c2806bd..9554685 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -24,6 +24,7 @@
 #include <plat/cpu.h>
 #include <plat/gpio.h>
 #include <plat/dma.h>
+#include <plat/mcspi.h>
 
 #include "omap_hwmod_common_data.h"
 
@@ -1435,6 +1436,266 @@ static struct omap_hwmod omap44xx_iva_hwmod = {
 };
 
 /*
+ * 'mcspi' class
+ * multichannel serial port interface (mcspi) / master/slave synchronous serial
+ * bus
+ */
+
+static struct omap_hwmod_class_sysconfig omap44xx_mcspi_sysc = {
+	.rev_offs	= 0x0000,
+	.sysc_offs	= 0x0010,
+	.sysc_flags     = (SYSC_HAS_EMUFREE | SYSC_HAS_RESET_STATUS |
+			   SYSC_HAS_SIDLEMODE | SYSC_HAS_SOFTRESET),
+	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART |
+			   SIDLE_SMART_WKUP),
+	.sysc_fields	= &omap_hwmod_sysc_type2,
+};
+
+static struct omap_hwmod_class omap44xx_mcspi_hwmod_class = {
+	.name = "mcspi",
+	.sysc = &omap44xx_mcspi_sysc,
+	.rev = OMAP4_MCSPI_REV,
+};
+
+/* mcspi1 */
+static struct omap_hwmod omap44xx_mcspi1_hwmod;
+static struct omap_hwmod_irq_info omap44xx_mcspi1_irqs[] = {
+	{ .irq = 65 + OMAP44XX_IRQ_GIC_START },
+};
+
+static struct omap_hwmod_dma_info omap44xx_mcspi1_sdma_reqs[] = {
+	{ .name = "tx0", .dma_req = 34 + OMAP44XX_DMA_REQ_START },
+	{ .name = "rx0", .dma_req = 35 + OMAP44XX_DMA_REQ_START },
+	{ .name = "tx1", .dma_req = 36 + OMAP44XX_DMA_REQ_START },
+	{ .name = "rx1", .dma_req = 37 + OMAP44XX_DMA_REQ_START },
+	{ .name = "tx2", .dma_req = 38 + OMAP44XX_DMA_REQ_START },
+	{ .name = "rx2", .dma_req = 39 + OMAP44XX_DMA_REQ_START },
+	{ .name = "tx3", .dma_req = 40 + OMAP44XX_DMA_REQ_START },
+	{ .name = "rx3", .dma_req = 41 + OMAP44XX_DMA_REQ_START },
+};
+
+static struct omap_hwmod_addr_space omap44xx_mcspi1_addrs[] = {
+	{
+		.pa_start	= 0x48098000,
+		.pa_end		= 0x480981ff,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+
+/* l4_per -> mcspi1 */
+static struct omap_hwmod_ocp_if omap44xx_l4_per__mcspi1 = {
+	.master		= &omap44xx_l4_per_hwmod,
+	.slave		= &omap44xx_mcspi1_hwmod,
+	.clk		= "l4_div_ck",
+	.addr		= omap44xx_mcspi1_addrs,
+	.addr_cnt	= ARRAY_SIZE(omap44xx_mcspi1_addrs),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* mcspi1 slave ports */
+static struct omap_hwmod_ocp_if *omap44xx_mcspi1_slaves[] = {
+	&omap44xx_l4_per__mcspi1,
+};
+
+static struct omap2_mcspi_dev_attr omap_mcspi1_dev_attr = {
+	.num_chipselect = 4,
+};
+
+static struct omap_hwmod omap44xx_mcspi1_hwmod = {
+	.name		= "mcspi1",
+	.class		= &omap44xx_mcspi_hwmod_class,
+	.mpu_irqs	= omap44xx_mcspi1_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_mcspi1_irqs),
+	.sdma_reqs	= omap44xx_mcspi1_sdma_reqs,
+	.sdma_reqs_cnt	= ARRAY_SIZE(omap44xx_mcspi1_sdma_reqs),
+	.main_clk	= "mcspi1_fck",
+	.prcm = {
+		.omap4 = {
+			.clkctrl_reg = OMAP4430_CM_L4PER_MCSPI1_CLKCTRL,
+		},
+	},
+	.slaves		= omap44xx_mcspi1_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap44xx_mcspi1_slaves),
+	.dev_attr       = &omap_mcspi1_dev_attr,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+};
+
+/* mcspi2 */
+static struct omap_hwmod omap44xx_mcspi2_hwmod;
+static struct omap_hwmod_irq_info omap44xx_mcspi2_irqs[] = {
+	{ .irq = 66 + OMAP44XX_IRQ_GIC_START },
+};
+
+static struct omap_hwmod_dma_info omap44xx_mcspi2_sdma_reqs[] = {
+	{ .name = "tx0", .dma_req = 42 + OMAP44XX_DMA_REQ_START },
+	{ .name = "rx0", .dma_req = 43 + OMAP44XX_DMA_REQ_START },
+	{ .name = "tx1", .dma_req = 44 + OMAP44XX_DMA_REQ_START },
+	{ .name = "rx1", .dma_req = 45 + OMAP44XX_DMA_REQ_START },
+};
+
+static struct omap_hwmod_addr_space omap44xx_mcspi2_addrs[] = {
+	{
+		.pa_start	= 0x4809a000,
+		.pa_end		= 0x4809a1ff,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+
+/* l4_per -> mcspi2 */
+static struct omap_hwmod_ocp_if omap44xx_l4_per__mcspi2 = {
+	.master		= &omap44xx_l4_per_hwmod,
+	.slave		= &omap44xx_mcspi2_hwmod,
+	.clk		= "l4_div_ck",
+	.addr		= omap44xx_mcspi2_addrs,
+	.addr_cnt	= ARRAY_SIZE(omap44xx_mcspi2_addrs),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* mcspi2 slave ports */
+static struct omap_hwmod_ocp_if *omap44xx_mcspi2_slaves[] = {
+	&omap44xx_l4_per__mcspi2,
+};
+
+static struct omap2_mcspi_dev_attr omap_mcspi2_dev_attr = {
+	.num_chipselect = 2,
+};
+
+static struct omap_hwmod omap44xx_mcspi2_hwmod = {
+	.name		= "mcspi2",
+	.class		= &omap44xx_mcspi_hwmod_class,
+	.mpu_irqs	= omap44xx_mcspi2_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_mcspi2_irqs),
+	.sdma_reqs	= omap44xx_mcspi2_sdma_reqs,
+	.sdma_reqs_cnt	= ARRAY_SIZE(omap44xx_mcspi2_sdma_reqs),
+	.main_clk	= "mcspi2_fck",
+	.prcm = {
+		.omap4 = {
+			.clkctrl_reg = OMAP4430_CM_L4PER_MCSPI2_CLKCTRL,
+		},
+	},
+	.slaves		= omap44xx_mcspi2_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap44xx_mcspi2_slaves),
+	.dev_attr       = &omap_mcspi2_dev_attr,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+};
+
+/* mcspi3 */
+static struct omap_hwmod omap44xx_mcspi3_hwmod;
+static struct omap_hwmod_irq_info omap44xx_mcspi3_irqs[] = {
+	{ .irq = 91 + OMAP44XX_IRQ_GIC_START },
+};
+
+static struct omap_hwmod_dma_info omap44xx_mcspi3_sdma_reqs[] = {
+	{ .name = "tx0", .dma_req = 14 + OMAP44XX_DMA_REQ_START },
+	{ .name = "rx0", .dma_req = 15 + OMAP44XX_DMA_REQ_START },
+	{ .name = "tx1", .dma_req = 22 + OMAP44XX_DMA_REQ_START },
+	{ .name = "rx1", .dma_req = 23 + OMAP44XX_DMA_REQ_START },
+};
+
+static struct omap_hwmod_addr_space omap44xx_mcspi3_addrs[] = {
+	{
+		.pa_start	= 0x480b8000,
+		.pa_end		= 0x480b81ff,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+
+/* l4_per -> mcspi3 */
+static struct omap_hwmod_ocp_if omap44xx_l4_per__mcspi3 = {
+	.master		= &omap44xx_l4_per_hwmod,
+	.slave		= &omap44xx_mcspi3_hwmod,
+	.clk		= "l4_div_ck",
+	.addr		= omap44xx_mcspi3_addrs,
+	.addr_cnt	= ARRAY_SIZE(omap44xx_mcspi3_addrs),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* mcspi3 slave ports */
+static struct omap_hwmod_ocp_if *omap44xx_mcspi3_slaves[] = {
+	&omap44xx_l4_per__mcspi3,
+};
+
+static struct omap2_mcspi_dev_attr omap_mcspi3_dev_attr = {
+	.num_chipselect = 2,
+};
+
+static struct omap_hwmod omap44xx_mcspi3_hwmod = {
+	.name		= "mcspi3",
+	.class		= &omap44xx_mcspi_hwmod_class,
+	.mpu_irqs	= omap44xx_mcspi3_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_mcspi3_irqs),
+	.sdma_reqs	= omap44xx_mcspi3_sdma_reqs,
+	.sdma_reqs_cnt	= ARRAY_SIZE(omap44xx_mcspi3_sdma_reqs),
+	.main_clk	= "mcspi3_fck",
+	.prcm = {
+		.omap4 = {
+			.clkctrl_reg = OMAP4430_CM_L4PER_MCSPI3_CLKCTRL,
+		},
+	},
+	.slaves		= omap44xx_mcspi3_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap44xx_mcspi3_slaves),
+	.dev_attr       = &omap_mcspi3_dev_attr,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+};
+
+/* mcspi4 */
+static struct omap_hwmod omap44xx_mcspi4_hwmod;
+static struct omap_hwmod_irq_info omap44xx_mcspi4_irqs[] = {
+	{ .irq = 48 + OMAP44XX_IRQ_GIC_START },
+};
+
+static struct omap_hwmod_dma_info omap44xx_mcspi4_sdma_reqs[] = {
+	{ .name = "tx0", .dma_req = 69 + OMAP44XX_DMA_REQ_START },
+	{ .name = "rx0", .dma_req = 70 + OMAP44XX_DMA_REQ_START },
+};
+
+static struct omap_hwmod_addr_space omap44xx_mcspi4_addrs[] = {
+	{
+		.pa_start	= 0x480ba000,
+		.pa_end		= 0x480ba1ff,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+
+/* l4_per -> mcspi4 */
+static struct omap_hwmod_ocp_if omap44xx_l4_per__mcspi4 = {
+	.master		= &omap44xx_l4_per_hwmod,
+	.slave		= &omap44xx_mcspi4_hwmod,
+	.clk		= "l4_div_ck",
+	.addr		= omap44xx_mcspi4_addrs,
+	.addr_cnt	= ARRAY_SIZE(omap44xx_mcspi4_addrs),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* mcspi4 slave ports */
+static struct omap_hwmod_ocp_if *omap44xx_mcspi4_slaves[] = {
+	&omap44xx_l4_per__mcspi4,
+};
+
+static struct omap2_mcspi_dev_attr omap_mcspi4_dev_attr = {
+	.num_chipselect = 1,
+};
+
+static struct omap_hwmod omap44xx_mcspi4_hwmod = {
+	.name		= "mcspi4",
+	.class		= &omap44xx_mcspi_hwmod_class,
+	.mpu_irqs	= omap44xx_mcspi4_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_mcspi4_irqs),
+	.sdma_reqs	= omap44xx_mcspi4_sdma_reqs,
+	.sdma_reqs_cnt	= ARRAY_SIZE(omap44xx_mcspi4_sdma_reqs),
+	.main_clk	= "mcspi4_fck",
+	.prcm = {
+		.omap4 = {
+			.clkctrl_reg = OMAP4430_CM_L4PER_MCSPI4_CLKCTRL,
+		},
+	},
+	.slaves		= omap44xx_mcspi4_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap44xx_mcspi4_slaves),
+	.dev_attr       = &omap_mcspi4_dev_attr,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+};
+
+/*
  * 'mpu' class
  * mpu sub-system
  */
@@ -2050,6 +2311,12 @@ static __initdata struct omap_hwmod *omap44xx_hwmods[] = {
 	&omap44xx_iva_seq0_hwmod,
 	&omap44xx_iva_seq1_hwmod,
 
+	/* mcspi class */
+	&omap44xx_mcspi1_hwmod,
+	&omap44xx_mcspi2_hwmod,
+	&omap44xx_mcspi3_hwmod,
+	&omap44xx_mcspi4_hwmod,
+
 	/* mpu class */
 	&omap44xx_mpu_hwmod,
 
-- 
1.7.1


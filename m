From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH 2/5] OMAP2xxx: hwmod: add I2C hwmods for OMAP2420, 2430
Date: Mon,  9 Aug 2010 20:06:23 +0530
Message-ID: <1281364586-26323-2-git-send-email-rnayak@ti.com>
References: <1281364586-26323-1-git-send-email-rnayak@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:41368 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756684Ab0HIOge (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 9 Aug 2010 10:36:34 -0400
In-Reply-To: <1281364586-26323-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>, Rajendra Nayak <rnayak@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>

From: Paul Walmsley <paul@pwsan.com>

Add hwmod structures for I2C controllers on OMAP2420/2430.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/omap_hwmod_2420_data.c |  134 ++++++++++++++++++++++++++-
 arch/arm/mach-omap2/omap_hwmod_2430_data.c |  140 +++++++++++++++++++++++++++-
 2 files changed, 270 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_2420_data.c b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
index 3cc768e..892e733 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2420_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
@@ -15,9 +15,12 @@
 #include <mach/irqs.h>
 #include <plat/cpu.h>
 #include <plat/dma.h>
+#include <plat/i2c.h>
+#include <plat/omap24xx.h>
 
 #include "omap_hwmod_common_data.h"
 
+#include "cm-regbits-24xx.h"
 #include "prm-regbits-24xx.h"
 
 /*
@@ -71,6 +74,8 @@ static struct omap_hwmod omap2420_l3_main_hwmod = {
 };
 
 static struct omap_hwmod omap2420_l4_wkup_hwmod;
+static struct omap_hwmod omap2420_i2c1_hwmod;
+static struct omap_hwmod omap2420_i2c2_hwmod;
 
 /* L4_CORE -> L4_WKUP interface */
 static struct omap_hwmod_ocp_if omap2420_l4_core__l4_wkup = {
@@ -79,6 +84,45 @@ static struct omap_hwmod_ocp_if omap2420_l4_core__l4_wkup = {
 	.user	= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
+/* I2C IP block address space length (in bytes) */
+#define OMAP2_I2C_AS_LEN		128
+
+/* L4 CORE -> I2C1 interface */
+static struct omap_hwmod_addr_space omap2420_i2c1_addr_space[] = {
+	{
+		.pa_start	= 0x48070000,
+		.pa_end		= 0x48070000 + OMAP2_I2C_AS_LEN - 1,
+		.flags		= ADDR_TYPE_RT,
+	},
+};
+
+static struct omap_hwmod_ocp_if omap2420_l4_core__i2c1 = {
+	.master		= &omap2420_l4_core_hwmod,
+	.slave		= &omap2420_i2c1_hwmod,
+	.clk		= "i2c1_ick",
+	.addr		= omap2420_i2c1_addr_space,
+	.addr_cnt	= ARRAY_SIZE(omap2420_i2c1_addr_space),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* L4 CORE -> I2C2 interface */
+static struct omap_hwmod_addr_space omap2420_i2c2_addr_space[] = {
+	{
+		.pa_start	= 0x48072000,
+		.pa_end		= 0x48072000 + OMAP2_I2C_AS_LEN - 1,
+		.flags		= ADDR_TYPE_RT,
+	},
+};
+
+static struct omap_hwmod_ocp_if omap2420_l4_core__i2c2 = {
+	.master		= &omap2420_l4_core_hwmod,
+	.slave		= &omap2420_i2c2_hwmod,
+	.clk		= "i2c2_ick",
+	.addr		= omap2420_i2c2_addr_space,
+	.addr_cnt	= ARRAY_SIZE(omap2420_i2c2_addr_space),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
 /* Slave interfaces on the L4_CORE interconnect */
 static struct omap_hwmod_ocp_if *omap2420_l4_core_slaves[] = {
 	&omap2420_l3_main__l4_core,
@@ -87,6 +131,8 @@ static struct omap_hwmod_ocp_if *omap2420_l4_core_slaves[] = {
 /* Master interfaces on the L4_CORE interconnect */
 static struct omap_hwmod_ocp_if *omap2420_l4_core_masters[] = {
 	&omap2420_l4_core__l4_wkup,
+	&omap2420_l4_core__i2c1,
+	&omap2420_l4_core__i2c2
 };
 
 /* L4 CORE */
@@ -165,6 +211,92 @@ static struct omap_hwmod omap2420_iva_hwmod = {
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2420)
 };
 
+/* I2C common */
+static struct omap_hwmod_class_sysconfig i2c_sysc = {
+	.rev_offs	= 0x00,
+	.sysc_offs	= 0x20,
+	.syss_offs	= 0x10,
+	.sysc_flags	= SYSC_HAS_SOFTRESET,
+	.sysc_fields	= &omap_hwmod_sysc_type1,
+};
+
+static struct omap_hwmod_class i2c_class = {
+	.name		= "i2c",
+	.sysc		= &i2c_sysc,
+};
+
+static struct omap_i2c_dev_attr i2c_dev_attr;
+
+/* I2C1 */
+
+static struct omap_hwmod_irq_info i2c1_mpu_irqs[] = {
+	{ .irq = INT_24XX_I2C1_IRQ, },
+};
+
+static struct omap_hwmod_dma_info i2c1_sdma_chs[] = {
+	{ .name = "tx", .dma_ch = OMAP24XX_DMA_I2C1_TX },
+	{ .name = "rx", .dma_ch = OMAP24XX_DMA_I2C1_RX },
+};
+
+static struct omap_hwmod_ocp_if *omap2420_i2c1_slaves[] = {
+	&omap2420_l4_core__i2c1,
+};
+
+static struct omap_hwmod omap2420_i2c1_hwmod = {
+	.name		= "i2c1",
+	.mpu_irqs	= i2c1_mpu_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(i2c1_mpu_irqs),
+	.sdma_chs	= i2c1_sdma_chs,
+	.sdma_chs_cnt	= ARRAY_SIZE(i2c1_sdma_chs),
+	.main_clk	= "i2c1_fck",
+	.prcm		= {
+		.omap2 = {
+			.prcm_reg_id = 1,
+			.module_bit = OMAP2420_EN_I2C1_SHIFT,
+		},
+	},
+	.slaves		= omap2420_i2c1_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap2420_i2c1_slaves),
+	.class		= &i2c_class,
+	.dev_attr	= &i2c_dev_attr,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2420),
+};
+
+/* I2C2 */
+
+static struct omap_hwmod_irq_info i2c2_mpu_irqs[] = {
+	{ .irq = INT_24XX_I2C2_IRQ, },
+};
+
+static struct omap_hwmod_dma_info i2c2_sdma_chs[] = {
+	{ .name = "tx", .dma_ch = OMAP24XX_DMA_I2C2_TX },
+	{ .name = "rx", .dma_ch = OMAP24XX_DMA_I2C2_RX },
+};
+
+static struct omap_hwmod_ocp_if *omap2420_i2c2_slaves[] = {
+	&omap2420_l4_core__i2c2,
+};
+
+static struct omap_hwmod omap2420_i2c2_hwmod = {
+	.name		= "i2c2",
+	.mpu_irqs	= i2c2_mpu_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(i2c2_mpu_irqs),
+	.sdma_chs	= i2c2_sdma_chs,
+	.sdma_chs_cnt	= ARRAY_SIZE(i2c2_sdma_chs),
+	.main_clk	= "i2c2_fck",
+	.prcm		= {
+		.omap2 = {
+			.prcm_reg_id = 1,
+			.module_bit = OMAP2420_EN_I2C2_SHIFT,
+		},
+	},
+	.slaves		= omap2420_i2c2_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap2420_i2c2_slaves),
+	.class		= &i2c_class,
+	.dev_attr	= &i2c_dev_attr,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2420),
+};
+
 static __initdata struct omap_hwmod *omap2420_hwmods[] = {
 	&omap2420_l3_main_hwmod,
 	&omap2420_l4_core_hwmod,
@@ -178,5 +310,3 @@ int __init omap2420_hwmod_init(void)
 {
 	return omap_hwmod_init(omap2420_hwmods);
 }
-
-
diff --git a/arch/arm/mach-omap2/omap_hwmod_2430_data.c b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
index 4526628..1f75a21 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2430_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
@@ -15,10 +15,13 @@
 #include <mach/irqs.h>
 #include <plat/cpu.h>
 #include <plat/dma.h>
+#include <plat/i2c.h>
+#include <plat/omap24xx.h>
 
 #include "omap_hwmod_common_data.h"
 
 #include "prm-regbits-24xx.h"
+#include "cm-regbits-24xx.h"
 
 /*
  * OMAP2430 hardware module integration data
@@ -71,6 +74,47 @@ static struct omap_hwmod omap2430_l3_main_hwmod = {
 };
 
 static struct omap_hwmod omap2430_l4_wkup_hwmod;
+static struct omap_hwmod omap2430_i2c1_hwmod;
+static struct omap_hwmod omap2430_i2c2_hwmod;
+
+/* I2C IP block address space length (in bytes) */
+#define OMAP2_I2C_AS_LEN		128
+
+/* L4 CORE -> I2C1 interface */
+static struct omap_hwmod_addr_space omap2430_i2c1_addr_space[] = {
+	{
+		.pa_start	= 0x48070000,
+		.pa_end		= 0x48070000 + OMAP2_I2C_AS_LEN - 1,
+		.flags		= ADDR_TYPE_RT,
+	},
+};
+
+static struct omap_hwmod_ocp_if omap2430_l4_core__i2c1 = {
+	.master		= &omap2430_l4_core_hwmod,
+	.slave		= &omap2430_i2c1_hwmod,
+	.clk		= "i2c1_ick",
+	.addr		= omap2430_i2c1_addr_space,
+	.addr_cnt	= ARRAY_SIZE(omap2430_i2c1_addr_space),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* L4 CORE -> I2C2 interface */
+static struct omap_hwmod_addr_space omap2430_i2c2_addr_space[] = {
+	{
+		.pa_start	= 0x48072000,
+		.pa_end		= 0x48072000 + OMAP2_I2C_AS_LEN - 1,
+		.flags		= ADDR_TYPE_RT,
+	},
+};
+
+static struct omap_hwmod_ocp_if omap2430_l4_core__i2c2 = {
+	.master		= &omap2430_l4_core_hwmod,
+	.slave		= &omap2430_i2c2_hwmod,
+	.clk		= "i2c2_ick",
+	.addr		= omap2430_i2c2_addr_space,
+	.addr_cnt	= ARRAY_SIZE(omap2430_i2c2_addr_space),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
 
 /* L4_CORE -> L4_WKUP interface */
 static struct omap_hwmod_ocp_if omap2430_l4_core__l4_wkup = {
@@ -165,6 +209,100 @@ static struct omap_hwmod omap2430_iva_hwmod = {
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2430)
 };
 
+/* I2C common */
+static struct omap_hwmod_class_sysconfig i2c_sysc = {
+	.rev_offs	= 0x00,
+	.sysc_offs	= 0x20,
+	.syss_offs	= 0x10,
+	.sysc_flags	= (SYSC_HAS_SOFTRESET | SYSC_HAS_AUTOIDLE),
+	.sysc_fields	= &omap_hwmod_sysc_type1,
+};
+
+static struct omap_hwmod_class i2c_class = {
+	.name		= "i2c",
+	.sysc		= &i2c_sysc,
+};
+
+static struct omap_i2c_dev_attr i2c_dev_attr;
+
+/* I2C1 */
+
+static struct omap_i2c_dev_attr i2c1_dev_attr = {
+	.fifo_depth	= 8, /* bytes */
+};
+
+static struct omap_hwmod_irq_info i2c1_mpu_irqs[] = {
+	{ .irq = INT_24XX_I2C1_IRQ, },
+};
+
+static struct omap_hwmod_dma_info i2c1_sdma_chs[] = {
+	{ .name = "tx", .dma_ch = OMAP24XX_DMA_I2C1_TX },
+	{ .name = "rx", .dma_ch = OMAP24XX_DMA_I2C1_RX },
+};
+
+static struct omap_hwmod_ocp_if *omap2430_i2c1_slaves[] = {
+	&omap2430_l4_core__i2c1,
+};
+
+static struct omap_hwmod omap2430_i2c1_hwmod = {
+	.name		= "i2c1",
+	.mpu_irqs	= i2c1_mpu_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(i2c1_mpu_irqs),
+	.sdma_chs	= i2c1_sdma_chs,
+	.sdma_chs_cnt	= ARRAY_SIZE(i2c1_sdma_chs),
+	.main_clk	= "i2c1_fck",
+	.prcm		= {
+		.omap2 = {
+			.prcm_reg_id = 1,
+			.module_bit = OMAP2430_EN_I2CHS1_SHIFT,
+		},
+	},
+	.slaves		= omap2430_i2c1_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap2430_i2c1_slaves),
+	.class		= &i2c_class,
+	.dev_attr	= &i2c1_dev_attr,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2430),
+};
+
+/* I2C2 */
+
+static struct omap_i2c_dev_attr i2c2_dev_attr = {
+	.fifo_depth	= 8, /* bytes */
+};
+
+static struct omap_hwmod_irq_info i2c2_mpu_irqs[] = {
+	{ .irq = INT_24XX_I2C2_IRQ, },
+};
+
+static struct omap_hwmod_dma_info i2c2_sdma_chs[] = {
+	{ .name = "tx", .dma_ch = OMAP24XX_DMA_I2C2_TX },
+	{ .name = "rx", .dma_ch = OMAP24XX_DMA_I2C2_RX },
+};
+
+static struct omap_hwmod_ocp_if *omap2430_i2c2_slaves[] = {
+	&omap2430_l4_core__i2c2,
+};
+
+static struct omap_hwmod omap2430_i2c2_hwmod = {
+	.name		= "i2c2_hwmod",
+	.mpu_irqs	= i2c2_mpu_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(i2c2_mpu_irqs),
+	.sdma_chs	= i2c2_sdma_chs,
+	.sdma_chs_cnt	= ARRAY_SIZE(i2c2_sdma_chs),
+	.main_clk	= "i2c2_fck",
+	.prcm		= {
+		.omap2 = {
+			.prcm_reg_id = 1,
+			.module_bit = OMAP2430_EN_I2CHS2_SHIFT,
+		},
+	},
+	.slaves		= omap2430_i2c2_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap2430_i2c2_slaves),
+	.class		= &i2c_class,
+	.dev_attr	= &i2c2_dev_attr,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2430),
+};
+
 static __initdata struct omap_hwmod *omap2430_hwmods[] = {
 	&omap2430_l3_main_hwmod,
 	&omap2430_l4_core_hwmod,
@@ -178,5 +316,3 @@ int __init omap2430_hwmod_init(void)
 {
 	return omap_hwmod_init(omap2430_hwmods);
 }
-
-
-- 
1.5.4.7


From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH 2/6] OMAP2xxx: hwmod: add I2C hwmods for OMAP2420, 2430
Date: Fri, 19 Feb 2010 17:57:13 +0530
Message-ID: <1266582437-22398-2-git-send-email-rnayak@ti.com>
References: <1266582437-22398-1-git-send-email-rnayak@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:32818 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753288Ab0BSM12 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 19 Feb 2010 07:27:28 -0500
In-Reply-To: <1266582437-22398-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, khilman@ti.com
Cc: Paul Walmsley <paul@pwsan.com>, Rajendra Nayak <rnayak@ti.com>

From: Paul Walmsley <paul@pwsan.com>

Add hwmod structures for I2C controllers on OMAP2420/2430.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_2420.h |  134 +++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_2430.h |  140 ++++++++++++++++++++++++++++++++-
 2 files changed, 272 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_2420.h b/arch/arm/mach-omap2/omap_hwmod_2420.h
index a9ca1b9..4320deb 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2420.h
+++ b/arch/arm/mach-omap2/omap_hwmod_2420.h
@@ -20,6 +20,7 @@
 #include <mach/irqs.h>
 #include <plat/cpu.h>
 #include <plat/dma.h>
+#include <plat/i2c.h>
 
 #include "prm-regbits-24xx.h"
 
@@ -62,6 +63,8 @@ static struct omap_hwmod omap2420_l3_hwmod = {
 };
 
 static struct omap_hwmod omap2420_l4_wkup_hwmod;
+static struct omap_hwmod omap2420_i2c1_hwmod;
+static struct omap_hwmod omap2420_i2c2_hwmod;
 
 /* L4_CORE -> L4_WKUP interface */
 static struct omap_hwmod_ocp_if omap2420_l4_core__l4_wkup = {
@@ -70,6 +73,50 @@ static struct omap_hwmod_ocp_if omap2420_l4_core__l4_wkup = {
 	.user	= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
+#define OMAP2_I2C1_BASE			(L4_24XX_BASE + 0x70000)
+#define OMAP2_I2C2_BASE			(L4_24XX_BASE + 0x72000)
+
+/* I2C IP block address space length (in bytes) */
+#define OMAP2_I2C_AS_LEN		128
+
+/* L4 CORE -> I2C1 interface */
+static struct omap_hwmod_addr_space omap2420_i2c1_addr_space[] = {
+	{
+		.pa_start	= OMAP2_I2C1_BASE,
+		.pa_end		= OMAP2_I2C1_BASE + OMAP2_I2C_AS_LEN - 1,
+		.flags		= ADDR_TYPE_RT,
+	},
+};
+
+static struct omap_hwmod_ocp_if omap2420_l4_core__i2c1 = {
+	.master		= &omap2420_l4_core_hwmod,
+	.slave		= &omap2420_i2c1_hwmod,
+	.clkdev_dev_id	= "i2c_omap.1",
+	.clkdev_con_id	= "ick",
+	.addr		= omap2420_i2c1_addr_space,
+	.addr_cnt	= ARRAY_SIZE(omap2420_i2c1_addr_space),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* L4 CORE -> I2C2 interface */
+static struct omap_hwmod_addr_space omap2420_i2c2_addr_space[] = {
+	{
+		.pa_start	= OMAP2_I2C2_BASE,
+		.pa_end		= OMAP2_I2C2_BASE + OMAP2_I2C_AS_LEN - 1,
+		.flags		= ADDR_TYPE_RT,
+	},
+};
+
+static struct omap_hwmod_ocp_if omap2420_l4_core__i2c2 = {
+	.master		= &omap2420_l4_core_hwmod,
+	.slave		= &omap2420_i2c2_hwmod,
+	.clkdev_dev_id	= "i2c_omap.2",
+	.clkdev_con_id	= "ick",
+	.addr		= omap2420_i2c2_addr_space,
+	.addr_cnt	= ARRAY_SIZE(omap2420_i2c2_addr_space),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
 /* Slave interfaces on the L4_CORE interconnect */
 static struct omap_hwmod_ocp_if *omap2420_l4_core_slaves[] = {
 	&omap2420_l3__l4_core,
@@ -78,6 +125,8 @@ static struct omap_hwmod_ocp_if *omap2420_l4_core_slaves[] = {
 /* Master interfaces on the L4_CORE interconnect */
 static struct omap_hwmod_ocp_if *omap2420_l4_core_masters[] = {
 	&omap2420_l4_core__l4_wkup,
+	&omap2420_l4_core__i2c1,
+	&omap2420_l4_core__i2c2
 };
 
 /* L4 CORE */
@@ -124,11 +173,96 @@ static struct omap_hwmod omap2420_mpu_hwmod = {
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2420),
 };
 
+/* I2C common */
+static struct omap_hwmod_sysconfig i2c_if_ctrl = {
+	.rev_offs	= 0x00,
+	.sysc_offs	= 0x20,
+	.syss_offs	= 0x10,
+	.sysc_flags	= SYSC_HAS_SOFTRESET,
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
+	.name		= "i2c1_hwmod",
+	.mpu_irqs	= i2c1_mpu_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(i2c1_mpu_irqs),
+	.sdma_chs	= i2c1_sdma_chs,
+	.sdma_chs_cnt	= ARRAY_SIZE(i2c1_sdma_chs),
+	.clkdev_dev_id	= "i2c_omap.1",
+	.clkdev_con_id	= "fck",
+	.prcm		= {
+		.omap2 = {
+			.prcm_reg_id = 1,
+			.module_bit = OMAP2420_EN_I2C1_SHIFT,
+		},
+	},
+	.slaves		= omap2420_i2c1_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap2420_i2c1_slaves),
+	.sysconfig	= &i2c_if_ctrl,
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
+	.name		= "i2c2_hwmod",
+	.mpu_irqs	= i2c2_mpu_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(i2c2_mpu_irqs),
+	.sdma_chs	= i2c2_sdma_chs,
+	.sdma_chs_cnt	= ARRAY_SIZE(i2c2_sdma_chs),
+	.clkdev_dev_id	= "i2c_omap.2",
+	.clkdev_con_id	= "fck",
+	.prcm		= {
+		.omap2 = {
+			.prcm_reg_id = 1,
+			.module_bit = OMAP2420_EN_I2C2_SHIFT,
+		},
+	},
+	.slaves		= omap2420_i2c2_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap2420_i2c2_slaves),
+	.sysconfig	= &i2c_if_ctrl,
+	.dev_attr	= &i2c_dev_attr,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2420),
+};
+
+
 static __initdata struct omap_hwmod *omap2420_hwmods[] = {
 	&omap2420_l3_hwmod,
 	&omap2420_l4_core_hwmod,
 	&omap2420_l4_wkup_hwmod,
 	&omap2420_mpu_hwmod,
+	&omap2420_i2c1_hwmod,
+	&omap2420_i2c2_hwmod,
 	NULL,
 };
 
diff --git a/arch/arm/mach-omap2/omap_hwmod_2430.h b/arch/arm/mach-omap2/omap_hwmod_2430.h
index 2898749..97ed44b 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2430.h
+++ b/arch/arm/mach-omap2/omap_hwmod_2430.h
@@ -17,11 +17,11 @@
 #ifdef CONFIG_ARCH_OMAP2430
 
 #include <plat/omap_hwmod.h>
-#include <mach/irqs.h>
 #include <plat/cpu.h>
 #include <plat/dma.h>
-
+#include <plat/i2c.h>
 #include <plat/mmc.h>
+#include <mach/irqs.h>
 
 #include "cm-regbits-24xx.h"
 #include "prm-regbits-24xx.h"
@@ -67,6 +67,52 @@ static struct omap_hwmod omap2430_l3_hwmod = {
 static struct omap_hwmod omap2430_l4_wkup_hwmod;
 static struct omap_hwmod omap2430_mmc1_hwmod;
 static struct omap_hwmod omap2430_mmc2_hwmod;
+static struct omap_hwmod omap2430_i2c1_hwmod;
+static struct omap_hwmod omap2430_i2c2_hwmod;
+
+#define OMAP2_I2C1_BASE			(L4_24XX_BASE + 0x70000)
+#define OMAP2_I2C2_BASE			(L4_24XX_BASE + 0x72000)
+
+/* I2C IP block address space length (in bytes) */
+#define OMAP2_I2C_AS_LEN		128
+
+/* L4 CORE -> I2C1 interface */
+static struct omap_hwmod_addr_space omap2430_i2c1_addr_space[] = {
+	{
+		.pa_start	= OMAP2_I2C1_BASE,
+		.pa_end		= OMAP2_I2C1_BASE + OMAP2_I2C_AS_LEN - 1,
+		.flags		= ADDR_TYPE_RT,
+	},
+};
+
+static struct omap_hwmod_ocp_if omap2430_l4_core__i2c1 = {
+	.master		= &omap2430_l4_core_hwmod,
+	.slave		= &omap2430_i2c1_hwmod,
+	.clkdev_dev_id	= "i2c_omap.1",
+	.clkdev_con_id	= "ick",
+	.addr		= omap2430_i2c1_addr_space,
+	.addr_cnt	= ARRAY_SIZE(omap2430_i2c1_addr_space),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* L4 CORE -> I2C2 interface */
+static struct omap_hwmod_addr_space omap2430_i2c2_addr_space[] = {
+	{
+		.pa_start	= OMAP2_I2C2_BASE,
+		.pa_end		= OMAP2_I2C2_BASE + OMAP2_I2C_AS_LEN - 1,
+		.flags		= ADDR_TYPE_RT,
+	},
+};
+
+static struct omap_hwmod_ocp_if omap2430_l4_core__i2c2 = {
+	.master		= &omap2430_l4_core_hwmod,
+	.slave		= &omap2430_i2c2_hwmod,
+	.clkdev_dev_id	= "i2c_omap.2",
+	.clkdev_con_id	= "ick",
+	.addr		= omap2430_i2c2_addr_space,
+	.addr_cnt	= ARRAY_SIZE(omap2430_i2c2_addr_space),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
 
 /* L4_CORE -> L4_WKUP interface */
 static struct omap_hwmod_ocp_if omap2430_l4_core__l4_wkup = {
@@ -273,11 +319,101 @@ static struct omap_hwmod omap2430_mmc2_hwmod = {
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2430),
 };
 
+/* I2C common */
+static struct omap_hwmod_sysconfig i2c_if_ctrl = {
+	.rev_offs	= 0x00,
+	.sysc_offs	= 0x20,
+	.syss_offs	= 0x10,
+	.sysc_flags	= (SYSC_HAS_SOFTRESET | SYSC_HAS_AUTOIDLE),
+};
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
+	.name		= "i2c1_hwmod",
+	.mpu_irqs	= i2c1_mpu_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(i2c1_mpu_irqs),
+	.sdma_chs	= i2c1_sdma_chs,
+	.sdma_chs_cnt	= ARRAY_SIZE(i2c1_sdma_chs),
+	.clkdev_dev_id	= "i2c_omap.1",
+	.clkdev_con_id	= "fck",
+	.prcm		= {
+		.omap2 = {
+			.prcm_reg_id = 1,
+			.module_bit = OMAP2430_EN_I2CHS1_SHIFT,
+		},
+	},
+	.slaves		= omap2430_i2c1_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap2430_i2c1_slaves),
+	.sysconfig	= &i2c_if_ctrl,
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
+	.clkdev_dev_id	= "i2c_omap.2",
+	.clkdev_con_id	= "fck",
+	.prcm		= {
+		.omap2 = {
+			.prcm_reg_id = 1,
+			.module_bit = OMAP2430_EN_I2CHS2_SHIFT,
+		},
+	},
+	.slaves		= omap2430_i2c2_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap2430_i2c2_slaves),
+	.sysconfig	= &i2c_if_ctrl,
+	.dev_attr	= &i2c2_dev_attr,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2430),
+};
+
 static __initdata struct omap_hwmod *omap2430_hwmods[] = {
 	&omap2430_l3_hwmod,
 	&omap2430_l4_core_hwmod,
 	&omap2430_l4_wkup_hwmod,
 	&omap2430_mpu_hwmod,
+	&omap2430_i2c1_hwmod,
+	&omap2430_i2c2_hwmod,
 	NULL,
 };
 
-- 
1.5.4.7


From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH 2/4] OMAP3: hwmod: add I2C hwmods for OMAP3430
Date: Mon, 14 Dec 2009 14:42:37 +0530
Message-ID: <1260781959-28050-2-git-send-email-rnayak@ti.com>
References: <1260781959-28050-1-git-send-email-rnayak@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:37244 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753727AbZLNJMq (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 14 Dec 2009 04:12:46 -0500
In-Reply-To: <1260781959-28050-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Rajendra Nayak <rnayak@ti.com>, Paul Walmsley <paul@pwsan.com>

Add hwmod structures for I2C controllers on OMAP3430.

This patch was developed in collaboration with Paul Walmsley <paul@pwsan.com>.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/omap_hwmod_34xx.h     |  235 +++++++++++++++++++++++++++++
 arch/arm/mach-omap2/prm-regbits-34xx.h    |    9 +-
 arch/arm/plat-omap/include/plat/i2c.h     |   43 ++++++
 arch/arm/plat-omap/include/plat/l4_3xxx.h |   24 +++
 4 files changed, 308 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm/plat-omap/include/plat/i2c.h
 create mode 100644 arch/arm/plat-omap/include/plat/l4_3xxx.h

diff --git a/arch/arm/mach-omap2/omap_hwmod_34xx.h b/arch/arm/mach-omap2/omap_hwmod_34xx.h
index 8225bd3..80fa3cc 100644
--- a/arch/arm/mach-omap2/omap_hwmod_34xx.h
+++ b/arch/arm/mach-omap2/omap_hwmod_34xx.h
@@ -19,6 +19,8 @@
 #include <plat/cpu.h>
 #include <plat/dma.h>
 #include <plat/serial.h>
+#include <plat/l4_3xxx.h>
+#include <plat/i2c.h>
 
 #include "prm-regbits-34xx.h"
 
@@ -74,6 +76,9 @@ static struct omap_hwmod omap34xx_l4_wkup_hwmod;
 static struct omap_hwmod omap34xx_uart1_hwmod;
 static struct omap_hwmod omap34xx_uart2_hwmod;
 static struct omap_hwmod omap34xx_uart3_hwmod;
+static struct omap_hwmod omap34xx_i2c1_hwmod;
+static struct omap_hwmod omap34xx_i2c2_hwmod;
+static struct omap_hwmod omap34xx_i2c3_hwmod;
 
 /* L4_CORE -> L4_WKUP interface */
 static struct omap_hwmod_ocp_if omap34xx_l4_core__l4_wkup = {
@@ -139,6 +144,91 @@ static struct omap_hwmod_ocp_if omap3_l4_per__uart3 = {
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
+#define OMAP3_I2C1_BASE			(L4_34XX_BASE + 0x70000)
+#define OMAP3_I2C2_BASE			(L4_34XX_BASE + 0x72000)
+#define OMAP3_I2C3_BASE			(L4_34XX_BASE + 0x60000)
+
+/* I2C IP block address space length (in bytes) */
+#define OMAP2_I2C_AS_LEN		128
+
+/* L4 CORE -> I2C1 interface */
+static struct omap_hwmod_addr_space omap34xx_i2c1_addr_space[] = {
+	{
+		.pa_start	= OMAP3_I2C1_BASE,
+		.pa_end		= OMAP3_I2C1_BASE + OMAP2_I2C_AS_LEN - 1,
+		.flags		= ADDR_TYPE_RT,
+	},
+};
+
+static struct omap_hwmod_ocp_if omap34xx_l4_core__i2c1 = {
+	.master		= &omap34xx_l4_core_hwmod,
+	.slave		= &omap34xx_i2c1_hwmod,
+	.clkdev_dev_id	= "i2c_omap.1",
+	.clkdev_con_id  = "ick",
+	.addr		= omap34xx_i2c1_addr_space,
+	.addr_cnt	= ARRAY_SIZE(omap34xx_i2c1_addr_space),
+	.fw = {
+		.omap2 = {
+			.l4_fw_region  = OMAP3_L4_CORE_FW_I2C1_REGION,
+			.l4_prot_group = 7,
+		}
+	},
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+	.flags		= OMAP_FIREWALL_L4
+};
+
+/* L4 CORE -> I2C2 interface */
+static struct omap_hwmod_addr_space omap34xx_i2c2_addr_space[] = {
+	{
+		.pa_start	= OMAP3_I2C2_BASE,
+		.pa_end		= OMAP3_I2C2_BASE + OMAP2_I2C_AS_LEN - 1,
+		.flags		= ADDR_TYPE_RT,
+	},
+};
+
+static struct omap_hwmod_ocp_if omap34xx_l4_core__i2c2 = {
+	.master		= &omap34xx_l4_core_hwmod,
+	.slave		= &omap34xx_i2c2_hwmod,
+	.clkdev_dev_id	= "i2c_omap.2",
+	.clkdev_con_id  = "ick",
+	.addr		= omap34xx_i2c2_addr_space,
+	.addr_cnt	= ARRAY_SIZE(omap34xx_i2c2_addr_space),
+	.fw = {
+		.omap2 = {
+			.l4_fw_region  = OMAP3_L4_CORE_FW_I2C2_REGION,
+			.l4_prot_group = 7,
+		}
+	},
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+	.flags		= OMAP_FIREWALL_L4
+};
+
+/* L4 CORE -> I2C3 interface */
+static struct omap_hwmod_addr_space omap34xx_i2c3_addr_space[] = {
+	{
+		.pa_start	= OMAP3_I2C3_BASE,
+		.pa_end		= OMAP3_I2C3_BASE + OMAP2_I2C_AS_LEN - 1,
+		.flags		= ADDR_TYPE_RT,
+	},
+};
+
+static struct omap_hwmod_ocp_if omap34xx_l4_core__i2c3 = {
+	.master		= &omap34xx_l4_core_hwmod,
+	.slave		= &omap34xx_i2c3_hwmod,
+	.clkdev_dev_id	= "i2c_omap.3",
+	.clkdev_con_id  = "ick",
+	.addr		= omap34xx_i2c3_addr_space,
+	.addr_cnt	= ARRAY_SIZE(omap34xx_i2c3_addr_space),
+	.fw = {
+		.omap2 = {
+			.l4_fw_region  = OMAP3_L4_CORE_FW_I2C3_REGION,
+			.l4_prot_group = 7,
+		}
+	},
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+	.flags		= OMAP_FIREWALL_L4
+};
+
 /* Slave interfaces on the L4_CORE interconnect */
 /* KJH: OCP ifs where L4 CORE is the slave */
 static struct omap_hwmod_ocp_if *omap34xx_l4_core_slaves[] = {
@@ -151,6 +241,9 @@ static struct omap_hwmod_ocp_if *omap34xx_l4_core_masters[] = {
 	&omap34xx_l4_core__l4_wkup,
 	&omap3_l4_core__uart1,
 	&omap3_l4_core__uart2,
+	&omap34xx_l4_core__i2c1,
+	&omap34xx_l4_core__i2c2,
+	&omap34xx_l4_core__i2c3,
 };
 
 /* L4 CORE */
@@ -335,6 +428,145 @@ static struct omap_hwmod omap34xx_uart3_hwmod = {
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
 };
 
+/* I2C common */
+static struct omap_hwmod_sysconfig i2c_if_ctrl = {
+	.rev_offs	= 0x00,
+	.sysc_offs	= 0x20,
+	.syss_offs	= 0x10,
+	.sysc_flags	= (SYSC_HAS_CLOCKACTIVITY | SYSC_HAS_SIDLEMODE |
+			   SYSC_HAS_ENAWAKEUP | SYSC_HAS_SOFTRESET |
+			   SYSC_HAS_AUTOIDLE),
+	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
+};
+
+/* I2C1 */
+
+static struct omap_i2c_dev_attr i2c1_dev_attr = {
+	.fifo_depth	= 8, /* bytes */
+	.flags		= (OMAP_I2C_HAS_FIFO | OMAP_I2C_HAS_HIGH_SPEED |
+			   OMAP_I2C_HAS_8_BIT_DATA_REG),
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
+static struct omap_hwmod_ocp_if *omap34xx_i2c1_slaves[] = {
+	&omap34xx_l4_core__i2c1,
+};
+
+static struct omap_hwmod omap34xx_i2c1_hwmod = {
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
+			.module_bit = OMAP3430_GRPSEL_I2C1_SHIFT,
+		},
+	},
+	.slaves		= omap34xx_i2c1_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap34xx_i2c1_slaves),
+	.sysconfig	= &i2c_if_ctrl,
+	.dev_attr	= &i2c1_dev_attr,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+};
+
+/* I2C2 */
+
+static struct omap_i2c_dev_attr i2c2_dev_attr = {
+	.fifo_depth	= 8, /* bytes */
+	.flags		= (OMAP_I2C_HAS_3_WIRE_SCCB | OMAP_I2C_HAS_FIFO |
+			   OMAP_I2C_HAS_HIGH_SPEED |
+			   OMAP_I2C_HAS_8_BIT_DATA_REG),
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
+static struct omap_hwmod_ocp_if *omap34xx_i2c2_slaves[] = {
+	&omap34xx_l4_core__i2c2,
+};
+
+static struct omap_hwmod omap34xx_i2c2_hwmod = {
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
+			.module_bit = OMAP3430_GRPSEL_I2C2_SHIFT,
+		},
+	},
+	.slaves		= omap34xx_i2c2_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap34xx_i2c2_slaves),
+	.sysconfig	= &i2c_if_ctrl,
+	.dev_attr	= &i2c2_dev_attr,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+};
+
+/* I2C3 */
+
+static struct omap_i2c_dev_attr i2c3_dev_attr = {
+	.fifo_depth	= 64, /* bytes */
+	.flags		= (OMAP_I2C_HAS_3_WIRE_SCCB | OMAP_I2C_HAS_FIFO |
+			   OMAP_I2C_HAS_HIGH_SPEED |
+			   OMAP_I2C_HAS_8_BIT_DATA_REG),
+};
+
+static struct omap_hwmod_irq_info i2c3_mpu_irqs[] = {
+	{ .irq = INT_34XX_I2C3_IRQ, },
+};
+
+static struct omap_hwmod_dma_info i2c3_sdma_chs[] = {
+	{ .name = "tx", .dma_ch = OMAP34XX_DMA_I2C3_TX },
+	{ .name = "rx", .dma_ch = OMAP34XX_DMA_I2C3_RX },
+};
+
+static struct omap_hwmod_ocp_if *omap34xx_i2c3_slaves[] = {
+	&omap34xx_l4_core__i2c3,
+};
+
+static struct omap_hwmod omap34xx_i2c3_hwmod = {
+	.name		= "i2c3_hwmod",
+	.mpu_irqs	= i2c3_mpu_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(i2c3_mpu_irqs),
+	.sdma_chs	= i2c3_sdma_chs,
+	.sdma_chs_cnt	= ARRAY_SIZE(i2c3_sdma_chs),
+	.clkdev_dev_id	= "i2c_omap.3",
+	.clkdev_con_id	= "fck",
+	.prcm		= {
+		.omap2 = {
+			.prcm_reg_id = 1,
+			.module_bit = OMAP3430_GRPSEL_I2C3_SHIFT,
+		},
+	},
+	.slaves		= omap34xx_i2c3_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap34xx_i2c3_slaves),
+	.sysconfig	= &i2c_if_ctrl,
+	.dev_attr	= &i2c3_dev_attr,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+};
+
 static __initdata struct omap_hwmod *omap34xx_hwmods[] = {
 	&omap34xx_l3_hwmod,
 	&omap34xx_l4_core_hwmod,
@@ -344,6 +576,9 @@ static __initdata struct omap_hwmod *omap34xx_hwmods[] = {
 	&omap34xx_uart1_hwmod,
 	&omap34xx_uart2_hwmod,
 	&omap34xx_uart3_hwmod,
+	&omap34xx_i2c1_hwmod,
+	&omap34xx_i2c2_hwmod,
+	&omap34xx_i2c3_hwmod,
 	NULL,
 };
 
diff --git a/arch/arm/mach-omap2/prm-regbits-34xx.h b/arch/arm/mach-omap2/prm-regbits-34xx.h
index 0066693..386d1b2 100644
--- a/arch/arm/mach-omap2/prm-regbits-34xx.h
+++ b/arch/arm/mach-omap2/prm-regbits-34xx.h
@@ -101,9 +101,12 @@
 #define OMAP3430_GRPSEL_MCSPI3				(1 << 20)
 #define OMAP3430_GRPSEL_MCSPI2				(1 << 19)
 #define OMAP3430_GRPSEL_MCSPI1				(1 << 18)
-#define OMAP3430_GRPSEL_I2C3				(1 << 17)
-#define OMAP3430_GRPSEL_I2C2				(1 << 16)
-#define OMAP3430_GRPSEL_I2C1				(1 << 15)
+#define OMAP3430_GRPSEL_I2C3_SHIFT			17
+#define OMAP3430_GRPSEL_I2C3_MASK			(1 << 17)
+#define OMAP3430_GRPSEL_I2C2_SHIFT			16
+#define OMAP3430_GRPSEL_I2C2_MASK			(1 << 16)
+#define OMAP3430_GRPSEL_I2C1_SHIFT			15
+#define OMAP3430_GRPSEL_I2C1_MASK			(1 << 15)
 #define OMAP3430_GRPSEL_UART2				(1 << 14)
 #define OMAP3430_GRPSEL_UART1				(1 << 13)
 #define OMAP3430_GRPSEL_GPT11				(1 << 12)
diff --git a/arch/arm/plat-omap/include/plat/i2c.h b/arch/arm/plat-omap/include/plat/i2c.h
new file mode 100644
index 0000000..886ee5d
--- /dev/null
+++ b/arch/arm/plat-omap/include/plat/i2c.h
@@ -0,0 +1,43 @@
+/*
+ * i2c.h - common structures and macros for the OMAP I2C controller IP blocks
+ *
+ * Copyright (C) 2009 Nokia Corporation
+ * Paul Walmsley
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+#ifndef __ARCH_ARM_PLAT_OMAP_INCLUDE_MACH_OMAP_I2C_H
+#define __ARCH_ARM_PLAT_OMAP_INCLUDE_MACH_OMAP_I2C_H
+
+/*
+ * i2c_dev_attr.flags bits
+ *
+ * OMAP_I2C_HAS_3_WIRE_SCCB: does this controller support 3-wire SCCB mode?
+ * OMAP_I2C_HAS_FIFO: >= 2430.  does the I2C controller have a FIFO?
+ * OMAP_I2C_HAS_HIGH_SPEED: >= 2430.  XXX Should be possible to test
+ *     the I2C block revision register to detect this in the driver?
+ * OMAP_I2C_HAS_8_BIT_DATA_REG: >= 2430.  XXX Should be possible to test
+ *     the I2C block revision register to detect this in the driver?
+ */
+#define OMAP_I2C_HAS_3_WIRE_SCCB	(1 << 0)
+#define OMAP_I2C_HAS_FIFO		(1 << 1)
+#define OMAP_I2C_HAS_HIGH_SPEED		(1 << 2)
+#define OMAP_I2C_HAS_8_BIT_DATA_REG	(1 << 3)
+
+/**
+ * i2c_dev_attr - OMAP I2C controller device attributes for omap_hwmod
+ * @fifo_depth: total controller FIFO size (in bytes)
+ * @flags: differences in hardware support capability
+ *
+ * @fifo_depth represents what exists on the hardware, not what is
+ * actually configured at runtime by the device driver.
+ */
+struct omap_i2c_dev_attr {
+	u8	fifo_depth;
+	u8	flags;
+};
+
+#endif
diff --git a/arch/arm/plat-omap/include/plat/l4_3xxx.h b/arch/arm/plat-omap/include/plat/l4_3xxx.h
new file mode 100644
index 0000000..83a9550
--- /dev/null
+++ b/arch/arm/plat-omap/include/plat/l4_3xxx.h
@@ -0,0 +1,24 @@
+/*
+ * arch/arm/plat-omap/include/plat/l4_3xxx.h - L4 firewall definitions
+ *
+ * Copyright (C) 2009 Nokia Corporation
+ * Paul Walmsley
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ */
+#ifndef __ARCH_ARM_PLAT_OMAP_INCLUDE_MACH_L4_3XXX_H
+#define __ARCH_ARM_PLAT_OMAP_INCLUDE_MACH_L4_3XXX_H
+
+/* L4 CORE */
+#define OMAP3_L4_CORE_FW_I2C1_REGION				21
+#define OMAP3_L4_CORE_FW_I2C1_TA_REGION				22
+#define OMAP3_L4_CORE_FW_I2C2_REGION				23
+#define OMAP3_L4_CORE_FW_I2C2_TA_REGION				24
+#define OMAP3_L4_CORE_FW_I2C3_REGION				73
+#define OMAP3_L4_CORE_FW_I2C3_TA_REGION				74
+
+#endif
-- 
1.5.4.7


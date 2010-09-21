From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH v3 2/5] OMAP3: hwmod: add I2C hwmods for OMAP3430
Date: Tue, 21 Sep 2010 19:37:13 +0530
Message-ID: <1285078036-12789-3-git-send-email-rnayak@ti.com>
References: <1285078036-12789-1-git-send-email-rnayak@ti.com>
 <1285078036-12789-2-git-send-email-rnayak@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:59418 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755034Ab0IUOHy (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 21 Sep 2010 10:07:54 -0400
In-Reply-To: <1285078036-12789-2-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, ben-linux@fluff.org, khali@linux-fr.org, Rajendra Nayak <rnayak@ti.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@deeprootsystems.com>

Add hwmod structures for I2C controllers on OMAP3430.

This patch was developed in collaboration with Paul Walmsley <paul@pwsan.com>.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |  232 ++++++++++++++++++++++++++++
 arch/arm/mach-omap2/prm-regbits-34xx.h     |    3 +
 arch/arm/plat-omap/include/plat/i2c.h      |   16 ++
 arch/arm/plat-omap/include/plat/l4_3xxx.h  |   24 +++
 4 files changed, 275 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/plat-omap/include/plat/l4_3xxx.h

diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index 5d8eb58..a3ccab7 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -17,6 +17,9 @@
 #include <mach/irqs.h>
 #include <plat/cpu.h>
 #include <plat/dma.h>
+#include <plat/l4_3xxx.h>
+#include <plat/i2c.h>
+#include <plat/omap34xx.h>
 
 #include "omap_hwmod_common_data.h"
 
@@ -36,6 +39,9 @@ static struct omap_hwmod omap3xxx_iva_hwmod;
 static struct omap_hwmod omap3xxx_l3_main_hwmod;
 static struct omap_hwmod omap3xxx_l4_core_hwmod;
 static struct omap_hwmod omap3xxx_l4_per_hwmod;
+static struct omap_hwmod omap3xxx_i2c1_hwmod;
+static struct omap_hwmod omap3xxx_i2c2_hwmod;
+static struct omap_hwmod omap3xxx_i2c3_hwmod;
 
 /* L3 -> L4_CORE interface */
 static struct omap_hwmod_ocp_if omap3xxx_l3_main__l4_core = {
@@ -90,6 +96,85 @@ static struct omap_hwmod_ocp_if omap3xxx_l4_core__l4_wkup = {
 	.user	= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
+
+/* I2C IP block address space length (in bytes) */
+#define OMAP2_I2C_AS_LEN		128
+
+/* L4 CORE -> I2C1 interface */
+static struct omap_hwmod_addr_space omap3xxx_i2c1_addr_space[] = {
+	{
+		.pa_start	= 0x48070000,
+		.pa_end		= 0x48070000 + OMAP2_I2C_AS_LEN - 1,
+		.flags		= ADDR_TYPE_RT,
+	},
+};
+
+static struct omap_hwmod_ocp_if omap3_l4_core__i2c1 = {
+	.master		= &omap3xxx_l4_core_hwmod,
+	.slave		= &omap3xxx_i2c1_hwmod,
+	.clk		= "i2c1_ick",
+	.addr		= omap3xxx_i2c1_addr_space,
+	.addr_cnt	= ARRAY_SIZE(omap3xxx_i2c1_addr_space),
+	.fw = {
+		.omap2 = {
+			.l4_fw_region  = OMAP3_L4_CORE_FW_I2C1_REGION,
+			.l4_prot_group = 7,
+			.flags	= OMAP_FIREWALL_L4,
+		}
+	},
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* L4 CORE -> I2C2 interface */
+static struct omap_hwmod_addr_space omap3xxx_i2c2_addr_space[] = {
+	{
+		.pa_start	= 0x48072000,
+		.pa_end		= 0x48072000 + OMAP2_I2C_AS_LEN - 1,
+		.flags		= ADDR_TYPE_RT,
+	},
+};
+
+static struct omap_hwmod_ocp_if omap3_l4_core__i2c2 = {
+	.master		= &omap3xxx_l4_core_hwmod,
+	.slave		= &omap3xxx_i2c2_hwmod,
+	.clk		= "i2c2_ick",
+	.addr		= omap3xxx_i2c2_addr_space,
+	.addr_cnt	= ARRAY_SIZE(omap3xxx_i2c2_addr_space),
+	.fw = {
+		.omap2 = {
+			.l4_fw_region  = OMAP3_L4_CORE_FW_I2C2_REGION,
+			.l4_prot_group = 7,
+			.flags = OMAP_FIREWALL_L4,
+		}
+	},
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* L4 CORE -> I2C3 interface */
+static struct omap_hwmod_addr_space omap3xxx_i2c3_addr_space[] = {
+	{
+		.pa_start	= 0x48060000,
+		.pa_end		= 0x48060000 + OMAP2_I2C_AS_LEN - 1,
+		.flags		= ADDR_TYPE_RT,
+	},
+};
+
+static struct omap_hwmod_ocp_if omap3_l4_core__i2c3 = {
+	.master		= &omap3xxx_l4_core_hwmod,
+	.slave		= &omap3xxx_i2c3_hwmod,
+	.clk		= "i2c3_ick",
+	.addr		= omap3xxx_i2c3_addr_space,
+	.addr_cnt	= ARRAY_SIZE(omap3xxx_i2c3_addr_space),
+	.fw = {
+		.omap2 = {
+			.l4_fw_region  = OMAP3_L4_CORE_FW_I2C3_REGION,
+			.l4_prot_group = 7,
+			.flags = OMAP_FIREWALL_L4,
+		}
+	},
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
 /* Slave interfaces on the L4_CORE interconnect */
 static struct omap_hwmod_ocp_if *omap3xxx_l4_core_slaves[] = {
 	&omap3xxx_l3_main__l4_core,
@@ -98,6 +183,9 @@ static struct omap_hwmod_ocp_if *omap3xxx_l4_core_slaves[] = {
 /* Master interfaces on the L4_CORE interconnect */
 static struct omap_hwmod_ocp_if *omap3xxx_l4_core_masters[] = {
 	&omap3xxx_l4_core__l4_wkup,
+	&omap3_l4_core__i2c1,
+	&omap3_l4_core__i2c2,
+	&omap3_l4_core__i2c3,
 };
 
 /* L4 CORE */
@@ -197,6 +285,147 @@ static struct omap_hwmod omap3xxx_iva_hwmod = {
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
 };
 
+
+/* I2C common */
+static struct omap_hwmod_class_sysconfig i2c_sysc = {
+	.rev_offs	= 0x00,
+	.sysc_offs	= 0x20,
+	.syss_offs	= 0x10,
+	.sysc_flags	= (SYSC_HAS_CLOCKACTIVITY | SYSC_HAS_SIDLEMODE |
+			   SYSC_HAS_ENAWAKEUP | SYSC_HAS_SOFTRESET |
+			   SYSC_HAS_AUTOIDLE),
+	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
+	.sysc_fields    = &omap_hwmod_sysc_type1,
+};
+
+static struct omap_hwmod_class i2c_class = {
+	.name = "i2c",
+	.sysc = &i2c_sysc,
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
+static struct omap_hwmod_dma_info i2c1_sdma_reqs[] = {
+	{ .name = "tx", .dma_req = OMAP24XX_DMA_I2C1_TX },
+	{ .name = "rx", .dma_req = OMAP24XX_DMA_I2C1_RX },
+};
+
+static struct omap_hwmod_ocp_if *omap3xxx_i2c1_slaves[] = {
+	&omap3_l4_core__i2c1,
+};
+
+static struct omap_hwmod omap3xxx_i2c1_hwmod = {
+	.name		= "i2c1",
+	.mpu_irqs	= i2c1_mpu_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(i2c1_mpu_irqs),
+	.sdma_reqs	= i2c1_sdma_reqs,
+	.sdma_reqs_cnt	= ARRAY_SIZE(i2c1_sdma_reqs),
+	.main_clk	= "i2c1_fck",
+	.prcm		= {
+		.omap2 = {
+			.prcm_reg_id = 1,
+			.module_bit = OMAP3430_EN_I2C1_SHIFT,
+			.idlest_reg_id = 1,
+			.idlest_idle_bit = OMAP3430_ST_I2C1_SHIFT,
+		},
+	},
+	.slaves		= omap3xxx_i2c1_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap3xxx_i2c1_slaves),
+	.class		= &i2c_class,
+	.dev_attr	= &i2c1_dev_attr,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
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
+static struct omap_hwmod_dma_info i2c2_sdma_reqs[] = {
+	{ .name = "tx", .dma_req = OMAP24XX_DMA_I2C2_TX },
+	{ .name = "rx", .dma_req = OMAP24XX_DMA_I2C2_RX },
+};
+
+static struct omap_hwmod_ocp_if *omap3xxx_i2c2_slaves[] = {
+	&omap3_l4_core__i2c2,
+};
+
+static struct omap_hwmod omap3xxx_i2c2_hwmod = {
+	.name		= "i2c2",
+	.mpu_irqs	= i2c2_mpu_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(i2c2_mpu_irqs),
+	.sdma_reqs	= i2c2_sdma_reqs,
+	.sdma_reqs_cnt	= ARRAY_SIZE(i2c2_sdma_reqs),
+	.main_clk	= "i2c2_fck",
+	.prcm		= {
+		.omap2 = {
+			.prcm_reg_id = 1,
+			.module_bit = OMAP3430_EN_I2C2_SHIFT,
+			.idlest_reg_id = 1,
+			.idlest_idle_bit = OMAP3430_ST_I2C2_SHIFT,
+		},
+	},
+	.slaves		= omap3xxx_i2c2_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap3xxx_i2c2_slaves),
+	.class		= &i2c_class,
+	.dev_attr	= &i2c2_dev_attr,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+};
+
+/* I2C3 */
+
+static struct omap_i2c_dev_attr i2c3_dev_attr = {
+	.fifo_depth	= 64, /* bytes */
+};
+
+static struct omap_hwmod_irq_info i2c3_mpu_irqs[] = {
+	{ .irq = INT_34XX_I2C3_IRQ, },
+};
+
+static struct omap_hwmod_dma_info i2c3_sdma_reqs[] = {
+	{ .name = "tx", .dma_req = OMAP34XX_DMA_I2C3_TX },
+	{ .name = "rx", .dma_req = OMAP34XX_DMA_I2C3_RX },
+};
+
+static struct omap_hwmod_ocp_if *omap3xxx_i2c3_slaves[] = {
+	&omap3_l4_core__i2c3,
+};
+
+static struct omap_hwmod omap3xxx_i2c3_hwmod = {
+	.name		= "i2c3",
+	.mpu_irqs	= i2c3_mpu_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(i2c3_mpu_irqs),
+	.sdma_reqs	= i2c3_sdma_reqs,
+	.sdma_reqs_cnt	= ARRAY_SIZE(i2c3_sdma_reqs),
+	.main_clk	= "i2c3_fck",
+	.prcm		= {
+		.omap2 = {
+			.prcm_reg_id = 1,
+			.module_bit = OMAP3430_EN_I2C3_SHIFT,
+			.idlest_reg_id = 1,
+			.idlest_idle_bit = OMAP3430_ST_I2C3_SHIFT,
+		},
+	},
+	.slaves		= omap3xxx_i2c3_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap3xxx_i2c3_slaves),
+	.class		= &i2c_class,
+	.dev_attr	= &i2c3_dev_attr,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+};
+
 static __initdata struct omap_hwmod *omap3xxx_hwmods[] = {
 	&omap3xxx_l3_main_hwmod,
 	&omap3xxx_l4_core_hwmod,
@@ -204,6 +433,9 @@ static __initdata struct omap_hwmod *omap3xxx_hwmods[] = {
 	&omap3xxx_l4_wkup_hwmod,
 	&omap3xxx_mpu_hwmod,
 	&omap3xxx_iva_hwmod,
+	&omap3xxx_i2c1_hwmod,
+	&omap3xxx_i2c2_hwmod,
+	&omap3xxx_i2c3_hwmod,
 	NULL,
 };
 
diff --git a/arch/arm/mach-omap2/prm-regbits-34xx.h b/arch/arm/mach-omap2/prm-regbits-34xx.h
index 7fd6023..51c354e 100644
--- a/arch/arm/mach-omap2/prm-regbits-34xx.h
+++ b/arch/arm/mach-omap2/prm-regbits-34xx.h
@@ -101,8 +101,11 @@
 #define OMAP3430_GRPSEL_MCSPI3_MASK			(1 << 20)
 #define OMAP3430_GRPSEL_MCSPI2_MASK			(1 << 19)
 #define OMAP3430_GRPSEL_MCSPI1_MASK			(1 << 18)
+#define OMAP3430_GRPSEL_I2C3_SHIFT			17
 #define OMAP3430_GRPSEL_I2C3_MASK			(1 << 17)
+#define OMAP3430_GRPSEL_I2C2_SHIFT			16
 #define OMAP3430_GRPSEL_I2C2_MASK			(1 << 16)
+#define OMAP3430_GRPSEL_I2C1_SHIFT			15
 #define OMAP3430_GRPSEL_I2C1_MASK			(1 << 15)
 #define OMAP3430_GRPSEL_UART2_MASK			(1 << 14)
 #define OMAP3430_GRPSEL_UART1_MASK			(1 << 13)
diff --git a/arch/arm/plat-omap/include/plat/i2c.h b/arch/arm/plat-omap/include/plat/i2c.h
index 87f6bf2..86d0199 100644
--- a/arch/arm/plat-omap/include/plat/i2c.h
+++ b/arch/arm/plat-omap/include/plat/i2c.h
@@ -18,6 +18,8 @@
  * 02110-1301 USA
  *
  */
+#ifndef __ASM_ARCH_I2C_H
+#define __ASM_ARCH_I2C_H
 
 #include <linux/i2c.h>
 
@@ -34,5 +36,19 @@ static inline int omap_register_i2c_bus(int bus_id, u32 clkrate,
 }
 #endif
 
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
 void __init omap1_i2c_mux_pins(int bus_id);
 void __init omap2_i2c_mux_pins(int bus_id);
+#endif
diff --git a/arch/arm/plat-omap/include/plat/l4_3xxx.h b/arch/arm/plat-omap/include/plat/l4_3xxx.h
new file mode 100644
index 0000000..5e19493
--- /dev/null
+++ b/arch/arm/plat-omap/include/plat/l4_3xxx.h
@@ -0,0 +1,24 @@
+/*
+ * arch/arm/plat-omap/include/mach/l4_3xxx.h - L4 firewall definitions
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


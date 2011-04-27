From: Hemant Pedanekar <hemantp@ti.com>
Subject: [PATCH 1/2] TI816X: Add minimal hwmod data
Date: Wed, 27 Apr 2011 22:03:22 +0530
Message-ID: <1303922002-6946-1-git-send-email-hemantp@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:36204 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759416Ab1D0QeB (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 27 Apr 2011 12:34:01 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, linux@arm.linux.org.uk, b-cousson@ti.com, paul@pwsan.com, linux-arm-kernel@lists.infradead.org, Hemant Pedanekar <hemantp@ti.com>

This patch adds minimum required hwmod data (e.g., UARTs) for bootup of TI816X.

Signed-off-by: Hemant Pedanekar <hemantp@ti.com>
---
This patch depends on following patch set:
[PATCH 1/4] TI816X: prcm: Add module and register offsets
[PATCH 2/4] TI816X: clock: Add clock data
[PATCH 3/4] TI816X: clock: Add clockdomains and powerdomains data
[PATCH 4/4] clock: Integrate TI816X clock data into OMAP clock framework

 arch/arm/mach-omap2/omap_hwmod_816x_data.c |  636 ++++++++++++++++++++++++++++
 1 files changed, 636 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-omap2/omap_hwmod_816x_data.c

diff --git a/arch/arm/mach-omap2/omap_hwmod_816x_data.c b/arch/arm/mach-omap2/omap_hwmod_816x_data.c
new file mode 100644
index 0000000..edfa7f4
--- /dev/null
+++ b/arch/arm/mach-omap2/omap_hwmod_816x_data.c
@@ -0,0 +1,636 @@
+/*
+ * omap_hwmod_ti816x_data.c - hardware modules data for TI816X chips
+ *
+ * Copyright (C) 2010 Texas Instruments, Inc. - http://www.ti.com/
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation version 2.
+ *
+ * This program is distributed "as is" WITHOUT ANY WARRANTY of any
+ * kind, whether express or implied; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+#include <plat/omap_hwmod.h>
+#include <mach/irqs.h>
+#include <plat/cpu.h>
+#include <plat/dma.h>
+#include <plat/serial.h>
+#include <plat/l4_3xxx.h>
+#include <plat/ti816x.h>
+
+#include "omap_hwmod_common_data.h"
+
+#include "control.h"
+#include "cm816x.h"
+#include "cm-regbits-816x.h"
+
+/*
+ * TI816X hardware modules integration data
+ */
+
+static struct omap_hwmod ti816xx_mpu_hwmod;
+static struct omap_hwmod ti816x_l3_slow_hwmod;
+static struct omap_hwmod ti816x_l4_slow_hwmod;
+
+/* L3 SLOW -> L4_SLOW Peripheral interface */
+static struct omap_hwmod_ocp_if ti816x_l3_slow__l4_slow = {
+	.master	= &ti816x_l3_slow_hwmod,
+	.slave	= &ti816x_l4_slow_hwmod,
+	.user	= OCP_USER_MPU,
+};
+
+/* MPU -> L3 SLOW interface */
+static struct omap_hwmod_ocp_if ti816x_mpu__l3_slow = {
+	.master = &ti816xx_mpu_hwmod,
+	.slave	= &ti816x_l3_slow_hwmod,
+	.user	= OCP_USER_MPU,
+};
+
+/* Slave interfaces on the L3 SLOW interconnect */
+static struct omap_hwmod_ocp_if *ti816x_l3_slow_slaves[] = {
+	&ti816x_mpu__l3_slow,
+};
+
+/* Master interfaces on the L3 SLOW interconnect */
+static struct omap_hwmod_ocp_if *ti816x_l3_slow_masters[] = {
+	&ti816x_l3_slow__l4_slow,
+};
+
+/* L3 SLOW */
+static struct omap_hwmod ti816x_l3_slow_hwmod = {
+	.name		= "l3_slow",
+	.class		= &l3_hwmod_class,
+	.masters	= ti816x_l3_slow_masters,
+	.masters_cnt	= ARRAY_SIZE(ti816x_l3_slow_masters),
+	.slaves		= ti816x_l3_slow_slaves,
+	.slaves_cnt	= ARRAY_SIZE(ti816x_l3_slow_slaves),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_TI816X),
+	.flags		= HWMOD_NO_IDLEST,
+};
+
+static struct omap_hwmod ti816x_uart1_hwmod;
+static struct omap_hwmod ti816x_uart2_hwmod;
+static struct omap_hwmod ti816x_uart3_hwmod;
+
+/* L4 SLOW -> UART1 interface */
+static struct omap_hwmod_addr_space ti816x_uart1_addr_space[] = {
+	{
+		.pa_start	= TI816X_UART1_BASE,
+		.pa_end		= TI816X_UART1_BASE + SZ_8K - 1,
+		.flags		= ADDR_MAP_ON_INIT | ADDR_TYPE_RT,
+	},
+};
+
+static struct omap_hwmod_ocp_if ti816x_l4_slow__uart1 = {
+	.master		= &ti816x_l4_slow_hwmod,
+	.slave		= &ti816x_uart1_hwmod,
+	.clk		= "uart1_ick",
+	.addr		= ti816x_uart1_addr_space,
+	.addr_cnt	= ARRAY_SIZE(ti816x_uart1_addr_space),
+	.user		= OCP_USER_MPU,
+};
+
+/* L4 SLOW -> UART2 interface */
+static struct omap_hwmod_addr_space ti816x_uart2_addr_space[] = {
+	{
+		.pa_start	= TI816X_UART2_BASE,
+		.pa_end		= TI816X_UART2_BASE + SZ_8K - 1,
+		.flags		= ADDR_MAP_ON_INIT | ADDR_TYPE_RT,
+	},
+};
+
+static struct omap_hwmod_ocp_if ti816x_l4_slow__uart2 = {
+	.master		= &ti816x_l4_slow_hwmod,
+	.slave		= &ti816x_uart2_hwmod,
+	.clk		= "uart2_ick",
+	.addr		= ti816x_uart2_addr_space,
+	.addr_cnt	= ARRAY_SIZE(ti816x_uart2_addr_space),
+	.user		= OCP_USER_MPU,
+};
+
+/* L4 SLOW -> UART3 interface */
+static struct omap_hwmod_addr_space ti816x_uart3_addr_space[] = {
+	{
+		.pa_start	= TI816X_UART3_BASE,
+		.pa_end		= TI816X_UART3_BASE + SZ_8K - 1,
+		.flags		= ADDR_MAP_ON_INIT | ADDR_TYPE_RT,
+	},
+};
+
+static struct omap_hwmod_ocp_if ti816x_l4_slow__uart3 = {
+	.master		= &ti816x_l4_slow_hwmod,
+	.slave		= &ti816x_uart3_hwmod,
+	.clk		= "uart3_ick",
+	.addr		= ti816x_uart3_addr_space,
+	.addr_cnt	= ARRAY_SIZE(ti816x_uart3_addr_space),
+	.user		= OCP_USER_MPU,
+};
+
+static struct omap_hwmod ti816x_timer1_hwmod;
+static struct omap_hwmod ti816x_timer2_hwmod;
+static struct omap_hwmod ti816x_timer3_hwmod;
+static struct omap_hwmod ti816x_timer4_hwmod;
+static struct omap_hwmod ti816x_timer5_hwmod;
+static struct omap_hwmod ti816x_timer6_hwmod;
+static struct omap_hwmod ti816x_timer7_hwmod;
+
+/* L4 SLOW -> TIMER1 interface */
+static struct omap_hwmod_addr_space ti816x_timer1_addr_space[] = {
+	{
+		.pa_start	= 0x4802E000,
+		.pa_end		= 0x4802E000 + SZ_1K - 1,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+
+static struct omap_hwmod_ocp_if ti816x_l4_slow__timer1 = {
+	.master		= &ti816x_l4_slow_hwmod,
+	.slave		= &ti816x_timer1_hwmod,
+	.clk		= "gpt1_ick",
+	.addr		= ti816x_timer1_addr_space,
+	.addr_cnt	= ARRAY_SIZE(ti816x_timer1_addr_space),
+	.user		= OCP_USER_MPU,
+};
+
+/* L4 SLOW -> TIMER2 interface */
+static struct omap_hwmod_addr_space ti816x_timer2_addr_space[] = {
+	{
+		.pa_start	= 0x48040000,
+		.pa_end		= 0x48040000 + SZ_1K - 1,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+
+static struct omap_hwmod_ocp_if ti816x_l4_slow__timer2 = {
+	.master		= &ti816x_l4_slow_hwmod,
+	.slave		= &ti816x_timer2_hwmod,
+	.clk		= "gpt2_ick",
+	.addr		= ti816x_timer2_addr_space,
+	.addr_cnt	= ARRAY_SIZE(ti816x_timer2_addr_space),
+	.user		= OCP_USER_MPU,
+};
+
+/* L4 SLOW -> TIMER3 interface */
+static struct omap_hwmod_addr_space ti816x_timer3_addr_space[] = {
+	{
+		.pa_start	= 0x48042000,
+		.pa_end		= 0x48042000 + SZ_1K - 1,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+
+static struct omap_hwmod_ocp_if ti816x_l4_slow__timer3 = {
+	.master		= &ti816x_l4_slow_hwmod,
+	.slave		= &ti816x_timer3_hwmod,
+	.clk		= "gpt3_ick",
+	.addr		= ti816x_timer3_addr_space,
+	.addr_cnt	= ARRAY_SIZE(ti816x_timer3_addr_space),
+	.user		= OCP_USER_MPU,
+};
+
+/* L4 SLOW -> TIMER2 interface */
+static struct omap_hwmod_addr_space ti816x_timer4_addr_space[] = {
+	{
+		.pa_start	= 0x48044000,
+		.pa_end		= 0x48044000 + SZ_1K - 1,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+
+static struct omap_hwmod_ocp_if ti816x_l4_slow__timer4 = {
+	.master		= &ti816x_l4_slow_hwmod,
+	.slave		= &ti816x_timer4_hwmod,
+	.clk		= "gpt4_ick",
+	.addr		= ti816x_timer4_addr_space,
+	.addr_cnt	= ARRAY_SIZE(ti816x_timer4_addr_space),
+	.user		= OCP_USER_MPU,
+};
+
+/* L4 SLOW -> TIMER5 interface */
+static struct omap_hwmod_addr_space ti816x_timer5_addr_space[] = {
+	{
+		.pa_start	= 0x48046000,
+		.pa_end		= 0x48046000 + SZ_1K - 1,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+
+static struct omap_hwmod_ocp_if ti816x_l4_slow__timer5 = {
+	.master		= &ti816x_l4_slow_hwmod,
+	.slave		= &ti816x_timer5_hwmod,
+	.clk		= "gpt5_ick",
+	.addr		= ti816x_timer5_addr_space,
+	.addr_cnt	= ARRAY_SIZE(ti816x_timer5_addr_space),
+	.user		= OCP_USER_MPU,
+};
+
+/* L4 SLOW -> TIMER6 interface */
+static struct omap_hwmod_addr_space ti816x_timer6_addr_space[] = {
+	{
+		.pa_start	= 0x48048000,
+		.pa_end		= 0x48048000 + SZ_1K - 1,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+
+static struct omap_hwmod_ocp_if ti816x_l4_slow__timer6 = {
+	.master		= &ti816x_l4_slow_hwmod,
+	.slave		= &ti816x_timer6_hwmod,
+	.clk		= "gpt6_ick",
+	.addr		= ti816x_timer6_addr_space,
+	.addr_cnt	= ARRAY_SIZE(ti816x_timer6_addr_space),
+	.user		= OCP_USER_MPU,
+};
+
+/* L4 SLOW -> TIMER7 interface */
+static struct omap_hwmod_addr_space ti816x_timer7_addr_space[] = {
+	{
+		.pa_start	= 0x4804A000,
+		.pa_end		= 0x4804A000 + SZ_1K - 1,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+
+static struct omap_hwmod_ocp_if ti816x_l4_slow__timer7 = {
+	.master		= &ti816x_l4_slow_hwmod,
+	.slave		= &ti816x_timer7_hwmod,
+	.clk		= "gpt7_ick",
+	.addr		= ti816x_timer7_addr_space,
+	.addr_cnt	= ARRAY_SIZE(ti816x_timer7_addr_space),
+	.user		= OCP_USER_MPU,
+};
+
+/* Slave interfaces on the L4_SLOW interconnect */
+static struct omap_hwmod_ocp_if *ti816x_l4_slow_slaves[] = {
+	&ti816x_l3_slow__l4_slow,
+};
+
+/* Master interfaces on the L4_SLOW interconnect */
+static struct omap_hwmod_ocp_if *ti816x_l4_slow_masters[] = {
+	&ti816x_l4_slow__uart1,
+	&ti816x_l4_slow__uart2,
+	&ti816x_l4_slow__uart3,
+	&ti816x_l4_slow__timer1,
+	&ti816x_l4_slow__timer2,
+	&ti816x_l4_slow__timer3,
+	&ti816x_l4_slow__timer4,
+	&ti816x_l4_slow__timer5,
+	&ti816x_l4_slow__timer6,
+	&ti816x_l4_slow__timer7,
+};
+
+/* L4 SLOW */
+static struct omap_hwmod ti816x_l4_slow_hwmod = {
+	.name		= "l4_slow",
+	.class		= &l4_hwmod_class,
+	.masters	= ti816x_l4_slow_masters,
+	.masters_cnt	= ARRAY_SIZE(ti816x_l4_slow_masters),
+	.slaves		= ti816x_l4_slow_slaves,
+	.slaves_cnt	= ARRAY_SIZE(ti816x_l4_slow_slaves),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_TI816X),
+	.flags		= HWMOD_NO_IDLEST,
+};
+
+/* Master interfaces on the MPU device */
+static struct omap_hwmod_ocp_if *ti816x_mpu_masters[] = {
+	&ti816x_mpu__l3_slow,
+};
+
+/* MPU */
+static struct omap_hwmod ti816xx_mpu_hwmod = {
+	.name		= "mpu",
+	.class		= &mpu_hwmod_class,
+	.main_clk	= "mpu_ck",
+	.masters	= ti816x_mpu_masters,
+	.masters_cnt	= ARRAY_SIZE(ti816x_mpu_masters),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_TI816X),
+};
+
+/* UART common */
+static struct omap_hwmod_class_sysconfig uart_sysc = {
+	.rev_offs	= 0x50,
+	.sysc_offs	= 0x54,
+	.syss_offs	= 0x58,
+	.sysc_flags	= (SYSC_HAS_SIDLEMODE |
+			   SYSC_HAS_ENAWAKEUP | SYSC_HAS_SOFTRESET |
+			   SYSC_HAS_AUTOIDLE),
+	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
+	.sysc_fields    = &omap_hwmod_sysc_type1,
+};
+
+static struct omap_hwmod_class uart_class = {
+	.name = "uart",
+	.sysc = &uart_sysc,
+};
+
+/* UART1 */
+static struct omap_hwmod_irq_info uart1_mpu_irqs[] = {
+	{ .irq = 72, },
+};
+
+static struct omap_hwmod_dma_info uart1_edma_reqs[] = {
+	{ .name = "tx",	.dma_req = 26, },
+	{ .name = "rx",	.dma_req = 27, },
+};
+
+static struct omap_hwmod_ocp_if *ti816x_uart1_slaves[] = {
+	&ti816x_l4_slow__uart1,
+};
+
+static struct omap_hwmod ti816x_uart1_hwmod = {
+	.name		= "uart1",
+	.mpu_irqs	= uart1_mpu_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(uart1_mpu_irqs),
+	.sdma_reqs	= uart1_edma_reqs,
+	.sdma_reqs_cnt	= ARRAY_SIZE(uart1_edma_reqs),
+	.main_clk	= "uart1_fck",
+	.prcm		= {
+		.omap4 = {
+			.clkctrl_reg = TI816X_CM_ALWON_UART_0_CLKCTRL,
+		},
+	},
+	.slaves		= ti816x_uart1_slaves,
+	.slaves_cnt	= ARRAY_SIZE(ti816x_uart1_slaves),
+	.class		= &uart_class,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_TI816X),
+};
+
+/* UART2 */
+static struct omap_hwmod_irq_info uart2_mpu_irqs[] = {
+	{ .irq = 73, },
+};
+
+static struct omap_hwmod_dma_info uart2_edma_reqs[] = {
+	{ .name = "tx",	.dma_req = 28, },
+	{ .name = "rx",	.dma_req = 29, },
+};
+
+static struct omap_hwmod_ocp_if *ti816x_uart2_slaves[] = {
+	&ti816x_l4_slow__uart2,
+};
+
+static struct omap_hwmod ti816x_uart2_hwmod = {
+	.name		= "uart2",
+	.mpu_irqs	= uart2_mpu_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(uart2_mpu_irqs),
+	.sdma_reqs	= uart2_edma_reqs,
+	.sdma_reqs_cnt	= ARRAY_SIZE(uart2_edma_reqs),
+	.main_clk	= "uart2_fck",
+	.prcm		= {
+		.omap4 = {
+			.clkctrl_reg = TI816X_CM_ALWON_UART_1_CLKCTRL,
+		},
+	},
+	.slaves		= ti816x_uart2_slaves,
+	.slaves_cnt	= ARRAY_SIZE(ti816x_uart2_slaves),
+	.class		= &uart_class,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_TI816X),
+};
+
+/* UART3 */
+static struct omap_hwmod_irq_info uart3_mpu_irqs[] = {
+	{ .irq = 74, },
+};
+
+static struct omap_hwmod_dma_info uart3_edma_reqs[] = {
+	{ .name = "tx",	.dma_req = 30, },
+	{ .name = "rx",	.dma_req = 31, },
+};
+
+static struct omap_hwmod_ocp_if *ti816x_uart3_slaves[] = {
+	&ti816x_l4_slow__uart3,
+};
+
+static struct omap_hwmod ti816x_uart3_hwmod = {
+	.name		= "uart3",
+	.mpu_irqs	= uart3_mpu_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(uart3_mpu_irqs),
+	.sdma_reqs	= uart3_edma_reqs,
+	.sdma_reqs_cnt	= ARRAY_SIZE(uart3_edma_reqs),
+	.main_clk	= "uart3_fck",
+	.prcm		= {
+		.omap4 = {
+			.clkctrl_reg = TI816X_CM_ALWON_UART_2_CLKCTRL,
+		},
+	},
+	.slaves		= ti816x_uart3_slaves,
+	.slaves_cnt	= ARRAY_SIZE(ti816x_uart3_slaves),
+	.class		= &uart_class,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_TI816X),
+};
+
+/* Timers common */
+static struct omap_hwmod_class_sysconfig ti816x_timer_sysc = {
+	.rev_offs	= 0x0000,
+	.sysc_offs	= 0x0010,
+	.syss_offs	= 0x0010,
+	.sysc_flags	= (SYSC_HAS_SIDLEMODE | SYSC_HAS_SOFTRESET),
+	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
+	.sysc_fields	= &omap_hwmod_sysc_type2,
+};
+
+static struct omap_hwmod_class ti816x_timer_hwmod_class = {
+	.name = "timer",
+	.sysc = &ti816x_timer_sysc,
+};
+
+/* TIMER1 */
+static struct omap_hwmod_irq_info ti816x_timer1_mpu_irqs[] = {
+	{ .irq = 67, },
+};
+
+static struct omap_hwmod_ocp_if *ti816x_timer1_slaves[] = {
+	&ti816x_l4_slow__timer1,
+};
+
+static struct omap_hwmod ti816x_timer1_hwmod = {
+	.name		= "timer1",
+	.mpu_irqs	= ti816x_timer1_mpu_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(ti816x_timer1_mpu_irqs),
+	.main_clk	= "gpt1_fck",
+	.prcm		= {
+		.omap4 = {
+			.clkctrl_reg = TI816X_CM_ALWON_TIMER_1_CLKCTRL,
+		},
+	},
+	.slaves		= ti816x_timer1_slaves,
+	.slaves_cnt	= ARRAY_SIZE(ti816x_timer1_slaves),
+	.class		= &ti816x_timer_hwmod_class,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_TI816X)
+};
+
+/* TIMER2 */
+static struct omap_hwmod_irq_info ti816x_timer2_mpu_irqs[] = {
+	{ .irq = 68, },
+};
+
+static struct omap_hwmod_ocp_if *ti816x_timer2_slaves[] = {
+	&ti816x_l4_slow__timer2,
+};
+
+static struct omap_hwmod ti816x_timer2_hwmod = {
+	.name		= "timer2",
+	.mpu_irqs	= ti816x_timer2_mpu_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(ti816x_timer2_mpu_irqs),
+	.main_clk	= "gpt2_fck",
+	.prcm		= {
+		.omap4 = {
+			.clkctrl_reg = TI816X_CM_ALWON_TIMER_2_CLKCTRL,
+		},
+	},
+	.slaves		= ti816x_timer2_slaves,
+	.slaves_cnt	= ARRAY_SIZE(ti816x_timer2_slaves),
+	.class		= &ti816x_timer_hwmod_class,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_TI816X)
+};
+
+/* TIMER3 */
+static struct omap_hwmod_irq_info ti816x_timer3_mpu_irqs[] = {
+	{ .irq = 69, },
+};
+
+static struct omap_hwmod_ocp_if *ti816x_timer3_slaves[] = {
+	&ti816x_l4_slow__timer3,
+};
+
+static struct omap_hwmod ti816x_timer3_hwmod = {
+	.name		= "timer3",
+	.mpu_irqs	= ti816x_timer3_mpu_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(ti816x_timer3_mpu_irqs),
+	.main_clk	= "gpt3_fck",
+	.prcm		= {
+		.omap4 = {
+			.clkctrl_reg = TI816X_CM_ALWON_TIMER_3_CLKCTRL,
+		},
+	},
+	.slaves		= ti816x_timer3_slaves,
+	.slaves_cnt	= ARRAY_SIZE(ti816x_timer3_slaves),
+	.class		= &ti816x_timer_hwmod_class,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_TI816X)
+};
+
+/* TIMER4 */
+static struct omap_hwmod_irq_info ti816x_timer4_mpu_irqs[] = {
+	{ .irq = 92, },
+};
+
+static struct omap_hwmod_ocp_if *ti816x_timer4_slaves[] = {
+	&ti816x_l4_slow__timer4,
+};
+
+static struct omap_hwmod ti816x_timer4_hwmod = {
+	.name		= "timer4",
+	.mpu_irqs	= ti816x_timer4_mpu_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(ti816x_timer4_mpu_irqs),
+	.main_clk	= "gpt4_fck",
+	.prcm		= {
+		.omap4 = {
+			.clkctrl_reg = TI816X_CM_ALWON_TIMER_4_CLKCTRL,
+		},
+	},
+	.slaves		= ti816x_timer4_slaves,
+	.slaves_cnt	= ARRAY_SIZE(ti816x_timer4_slaves),
+	.class		= &ti816x_timer_hwmod_class,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_TI816X)
+};
+
+/* TIMER5 */
+static struct omap_hwmod_irq_info ti816x_timer5_mpu_irqs[] = {
+	{ .irq = 93, },
+};
+
+static struct omap_hwmod_ocp_if *ti816x_timer5_slaves[] = {
+	&ti816x_l4_slow__timer5,
+};
+
+static struct omap_hwmod ti816x_timer5_hwmod = {
+	.name		= "timer5",
+	.mpu_irqs	= ti816x_timer5_mpu_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(ti816x_timer5_mpu_irqs),
+	.main_clk	= "gpt5_fck",
+	.prcm		= {
+		.omap4 = {
+			.clkctrl_reg = TI816X_CM_ALWON_TIMER_5_CLKCTRL,
+		},
+	},
+	.slaves		= ti816x_timer5_slaves,
+	.slaves_cnt	= ARRAY_SIZE(ti816x_timer5_slaves),
+	.class		= &ti816x_timer_hwmod_class,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_TI816X)
+};
+
+/* TIMER6 */
+static struct omap_hwmod_irq_info ti816x_timer6_mpu_irqs[] = {
+	{ .irq = 94, },
+};
+
+static struct omap_hwmod_ocp_if *ti816x_timer6_slaves[] = {
+	&ti816x_l4_slow__timer6,
+};
+
+static struct omap_hwmod ti816x_timer6_hwmod = {
+	.name		= "timer6",
+	.mpu_irqs	= ti816x_timer6_mpu_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(ti816x_timer6_mpu_irqs),
+	.main_clk	= "gpt6_fck",
+	.prcm		= {
+		.omap4 = {
+			.clkctrl_reg = TI816X_CM_ALWON_TIMER_6_CLKCTRL,
+		},
+	},
+	.slaves		= ti816x_timer6_slaves,
+	.slaves_cnt	= ARRAY_SIZE(ti816x_timer6_slaves),
+	.class		= &ti816x_timer_hwmod_class,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_TI816X)
+};
+
+/* TIMER7 */
+static struct omap_hwmod_irq_info ti816x_timer7_mpu_irqs[] = {
+	{ .irq = 95, },
+};
+
+static struct omap_hwmod_ocp_if *ti816x_timer7_slaves[] = {
+	&ti816x_l4_slow__timer7,
+};
+
+static struct omap_hwmod ti816x_timer7_hwmod = {
+	.name		= "timer7",
+	.mpu_irqs	= ti816x_timer7_mpu_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(ti816x_timer7_mpu_irqs),
+	.main_clk	= "gpt7_fck",
+	.prcm		= {
+		.omap4 = {
+			.clkctrl_reg = TI816X_CM_ALWON_TIMER_7_CLKCTRL,
+		},
+	},
+	.slaves		= ti816x_timer7_slaves,
+	.slaves_cnt	= ARRAY_SIZE(ti816x_timer7_slaves),
+	.class		= &ti816x_timer_hwmod_class,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_TI816X)
+};
+
+
+static __initdata struct omap_hwmod *ti816x_hwmods[] = {
+	&ti816x_l3_slow_hwmod,
+	&ti816x_l4_slow_hwmod,
+	&ti816xx_mpu_hwmod,
+	&ti816x_uart1_hwmod,
+	&ti816x_uart2_hwmod,
+	&ti816x_uart3_hwmod,
+	&ti816x_timer1_hwmod,
+	&ti816x_timer2_hwmod,
+	&ti816x_timer3_hwmod,
+	&ti816x_timer4_hwmod,
+	&ti816x_timer5_hwmod,
+	&ti816x_timer6_hwmod,
+	&ti816x_timer7_hwmod,
+	NULL,
+};
+
+int __init ti816x_hwmod_init(void)
+{
+	return omap_hwmod_register(ti816x_hwmods);
+}
-- 
1.7.3.5


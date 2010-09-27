From: "Govindraj.R" <govindraj.raja@ti.com>
Subject: [PATCH 02/13 v3] OMAP2/3: UART: add omap_hwmod data for UARTs 1-4
Date: Mon, 27 Sep 2010 20:19:30 +0530 (IST)
Message-ID: <43452.10.24.255.17.1285598970.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Sender: linux-serial-owner@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, Kevin Hilman <khilman@deeprootsystems.com>, Tony Lindgren <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org

From: Kevin Hilman <khilman@deeprootsystems.com>

This patch adds omap_hwmod data for UARTs on OMAP2 and OMAP3
platforms.

UART4 support for 3630 and OMAP2 hwmod data added by Govindraj R.

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_2420_data.c |  193 +++++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_2430_data.c |  193 +++++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |  253 +++++++++++++++++++++++++++-
 arch/arm/mach-omap2/prcm-common.h          |    3 +
 arch/arm/plat-omap/include/plat/dma.h      |    2 +
 arch/arm/plat-omap/include/plat/irqs.h     |    2 +
 6 files changed, 644 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_2420_data.c b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
index 3cc768e..ba145f7 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2420_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
@@ -15,6 +15,7 @@
 #include <mach/irqs.h>
 #include <plat/cpu.h>
 #include <plat/dma.h>
+#include <plat/serial.h>

 #include "omap_hwmod_common_data.h"

@@ -71,6 +72,9 @@ static struct omap_hwmod omap2420_l3_main_hwmod = {
 };

 static struct omap_hwmod omap2420_l4_wkup_hwmod;
+static struct omap_hwmod omap2420_uart1_hwmod;
+static struct omap_hwmod omap2420_uart2_hwmod;
+static struct omap_hwmod omap2420_uart3_hwmod;

 /* L4_CORE -> L4_WKUP interface */
 static struct omap_hwmod_ocp_if omap2420_l4_core__l4_wkup = {
@@ -79,6 +83,60 @@ static struct omap_hwmod_ocp_if omap2420_l4_core__l4_wkup = {
 	.user	= OCP_USER_MPU | OCP_USER_SDMA,
 };

+/* L4 CORE -> UART1 interface */
+static struct omap_hwmod_addr_space omap2420_uart1_addr_space[] = {
+	{
+		.pa_start	= OMAP2_UART1_BASE,
+		.pa_end		= OMAP2_UART1_BASE + SZ_8K - 1,
+		.flags		= ADDR_MAP_ON_INIT | ADDR_TYPE_RT,
+	},
+};
+
+static struct omap_hwmod_ocp_if omap2_l4_core__uart1 = {
+	.master		= &omap2420_l4_core_hwmod,
+	.slave		= &omap2420_uart1_hwmod,
+	.clk		= "uart1_ick",
+	.addr		= omap2420_uart1_addr_space,
+	.addr_cnt	= ARRAY_SIZE(omap2420_uart1_addr_space),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* L4 CORE -> UART2 interface */
+static struct omap_hwmod_addr_space omap2420_uart2_addr_space[] = {
+	{
+		.pa_start	= OMAP2_UART2_BASE,
+		.pa_end		= OMAP2_UART2_BASE + SZ_1K - 1,
+		.flags		= ADDR_MAP_ON_INIT | ADDR_TYPE_RT,
+	},
+};
+
+static struct omap_hwmod_ocp_if omap2_l4_core__uart2 = {
+	.master		= &omap2420_l4_core_hwmod,
+	.slave		= &omap2420_uart2_hwmod,
+	.clk		= "uart2_ick",
+	.addr		= omap2420_uart2_addr_space,
+	.addr_cnt	= ARRAY_SIZE(omap2420_uart2_addr_space),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* L4 PER -> UART3 interface */
+static struct omap_hwmod_addr_space omap2420_uart3_addr_space[] = {
+	{
+		.pa_start	= OMAP2_UART3_BASE,
+		.pa_end		= OMAP2_UART3_BASE + SZ_1K - 1,
+		.flags		= ADDR_MAP_ON_INIT | ADDR_TYPE_RT,
+	},
+};
+
+static struct omap_hwmod_ocp_if omap2_l4_core__uart3 = {
+	.master		= &omap2420_l4_core_hwmod,
+	.slave		= &omap2420_uart3_hwmod,
+	.clk		= "uart3_ick",
+	.addr		= omap2420_uart3_addr_space,
+	.addr_cnt	= ARRAY_SIZE(omap2420_uart3_addr_space),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
 /* Slave interfaces on the L4_CORE interconnect */
 static struct omap_hwmod_ocp_if *omap2420_l4_core_slaves[] = {
 	&omap2420_l3_main__l4_core,
@@ -87,6 +145,9 @@ static struct omap_hwmod_ocp_if *omap2420_l4_core_slaves[] = {
 /* Master interfaces on the L4_CORE interconnect */
 static struct omap_hwmod_ocp_if *omap2420_l4_core_masters[] = {
 	&omap2420_l4_core__l4_wkup,
+	&omap2_l4_core__uart1,
+	&omap2_l4_core__uart2,
+	&omap2_l4_core__uart3,
 };

 /* L4 CORE */
@@ -165,12 +226,144 @@ static struct omap_hwmod omap2420_iva_hwmod = {
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2420)
 };

+/* UART */
+
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
+
+static struct omap_hwmod_irq_info uart1_mpu_irqs[] = {
+	{ .irq = INT_24XX_UART1_IRQ, },
+};
+
+static struct omap_hwmod_dma_info uart1_sdma_reqs[] = {
+	{ .name = "rx",	.dma_req = OMAP24XX_DMA_UART1_RX, },
+	{ .name = "tx",	.dma_req = OMAP24XX_DMA_UART1_TX, },
+};
+
+static struct omap_hwmod_ocp_if *omap2420_uart1_slaves[] = {
+	&omap2_l4_core__uart1,
+};
+
+static struct omap_hwmod omap2420_uart1_hwmod = {
+	.name		= "uart1",
+	.mpu_irqs	= uart1_mpu_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(uart1_mpu_irqs),
+	.sdma_reqs	= uart1_sdma_reqs,
+	.sdma_reqs_cnt	= ARRAY_SIZE(uart1_sdma_reqs),
+	.main_clk	= "uart1_fck",
+	.prcm		= {
+		.omap2 = {
+			.module_offs = CORE_MOD,
+			.prcm_reg_id = 1,
+			.module_bit = OMAP24XX_EN_UART1_SHIFT,
+			.idlest_reg_id = 1,
+			.idlest_idle_bit = OMAP24XX_EN_UART1_SHIFT,
+		},
+	},
+	.slaves		= omap2420_uart1_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap2420_uart1_slaves),
+	.class		= &uart_class,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2420),
+};
+
+/* UART2 */
+
+static struct omap_hwmod_irq_info uart2_mpu_irqs[] = {
+	{ .irq = INT_24XX_UART2_IRQ, },
+};
+
+static struct omap_hwmod_dma_info uart2_sdma_reqs[] = {
+	{ .name = "rx",	.dma_req = OMAP24XX_DMA_UART2_RX, },
+	{ .name = "tx",	.dma_req = OMAP24XX_DMA_UART2_TX, },
+};
+
+static struct omap_hwmod_ocp_if *omap2420_uart2_slaves[] = {
+	&omap2_l4_core__uart2,
+};
+
+static struct omap_hwmod omap2420_uart2_hwmod = {
+	.name		= "uart2",
+	.mpu_irqs	= uart2_mpu_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(uart2_mpu_irqs),
+	.sdma_reqs	= uart2_sdma_reqs,
+	.sdma_reqs_cnt	= ARRAY_SIZE(uart2_sdma_reqs),
+	.main_clk	= "uart2_fck",
+	.prcm		= {
+		.omap2 = {
+			.module_offs = CORE_MOD,
+			.prcm_reg_id = 1,
+			.module_bit = OMAP24XX_EN_UART2_SHIFT,
+			.idlest_reg_id = 1,
+			.idlest_idle_bit = OMAP24XX_EN_UART2_SHIFT,
+		},
+	},
+	.slaves		= omap2420_uart2_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap2420_uart2_slaves),
+	.class		= &uart_class,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2420),
+};
+
+/* UART3 */
+
+static struct omap_hwmod_irq_info uart3_mpu_irqs[] = {
+	{ .irq = INT_24XX_UART3_IRQ, },
+};
+
+static struct omap_hwmod_dma_info uart3_sdma_reqs[] = {
+	{ .name = "rx",	.dma_req = OMAP24XX_DMA_UART3_RX, },
+	{ .name = "tx",	.dma_req = OMAP24XX_DMA_UART3_TX, },
+};
+
+static struct omap_hwmod_ocp_if *omap2420_uart3_slaves[] = {
+	&omap2_l4_core__uart3,
+};
+
+static struct omap_hwmod omap2420_uart3_hwmod = {
+	.name		= "uart3",
+	.mpu_irqs	= uart3_mpu_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(uart3_mpu_irqs),
+	.sdma_reqs	= uart3_sdma_reqs,
+	.sdma_reqs_cnt	= ARRAY_SIZE(uart3_sdma_reqs),
+	.main_clk	= "uart3_fck",
+	.prcm		= {
+		.omap2 = {
+			.module_offs = CORE_MOD,
+			.prcm_reg_id = 2,
+			.module_bit = OMAP24XX_EN_UART3_SHIFT,
+			.idlest_reg_id = 2,
+			.idlest_idle_bit = OMAP24XX_EN_UART3_SHIFT,
+		},
+	},
+	.slaves		= omap2420_uart3_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap2420_uart3_slaves),
+	.class		= &uart_class,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2420),
+};
+
 static __initdata struct omap_hwmod *omap2420_hwmods[] = {
 	&omap2420_l3_main_hwmod,
 	&omap2420_l4_core_hwmod,
 	&omap2420_l4_wkup_hwmod,
 	&omap2420_mpu_hwmod,
 	&omap2420_iva_hwmod,
+	&omap2420_uart1_hwmod,
+	&omap2420_uart2_hwmod,
+	&omap2420_uart3_hwmod,
 	NULL,
 };

diff --git a/arch/arm/mach-omap2/omap_hwmod_2430_data.c b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
index 4526628..145f9ef 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2430_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
@@ -15,6 +15,7 @@
 #include <mach/irqs.h>
 #include <plat/cpu.h>
 #include <plat/dma.h>
+#include <plat/serial.h>

 #include "omap_hwmod_common_data.h"

@@ -71,6 +72,9 @@ static struct omap_hwmod omap2430_l3_main_hwmod = {
 };

 static struct omap_hwmod omap2430_l4_wkup_hwmod;
+static struct omap_hwmod omap2430_uart1_hwmod;
+static struct omap_hwmod omap2430_uart2_hwmod;
+static struct omap_hwmod omap2430_uart3_hwmod;

 /* L4_CORE -> L4_WKUP interface */
 static struct omap_hwmod_ocp_if omap2430_l4_core__l4_wkup = {
@@ -79,6 +83,60 @@ static struct omap_hwmod_ocp_if omap2430_l4_core__l4_wkup = {
 	.user	= OCP_USER_MPU | OCP_USER_SDMA,
 };

+/* L4 CORE -> UART1 interface */
+static struct omap_hwmod_addr_space omap2430_uart1_addr_space[] = {
+	{
+		.pa_start	= OMAP2_UART1_BASE,
+		.pa_end		= OMAP2_UART1_BASE + SZ_8K - 1,
+		.flags		= ADDR_MAP_ON_INIT | ADDR_TYPE_RT,
+	},
+};
+
+static struct omap_hwmod_ocp_if omap2_l4_core__uart1 = {
+	.master		= &omap2430_l4_core_hwmod,
+	.slave		= &omap2430_uart1_hwmod,
+	.clk		= "uart1_ick",
+	.addr		= omap2430_uart1_addr_space,
+	.addr_cnt	= ARRAY_SIZE(omap2430_uart1_addr_space),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* L4 CORE -> UART2 interface */
+static struct omap_hwmod_addr_space omap2430_uart2_addr_space[] = {
+	{
+		.pa_start	= OMAP2_UART2_BASE,
+		.pa_end		= OMAP2_UART2_BASE + SZ_1K - 1,
+		.flags		= ADDR_MAP_ON_INIT | ADDR_TYPE_RT,
+	},
+};
+
+static struct omap_hwmod_ocp_if omap2_l4_core__uart2 = {
+	.master		= &omap2430_l4_core_hwmod,
+	.slave		= &omap2430_uart2_hwmod,
+	.clk		= "uart2_ick",
+	.addr		= omap2430_uart2_addr_space,
+	.addr_cnt	= ARRAY_SIZE(omap2430_uart2_addr_space),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* L4 PER -> UART3 interface */
+static struct omap_hwmod_addr_space omap2430_uart3_addr_space[] = {
+	{
+		.pa_start	= OMAP2_UART3_BASE,
+		.pa_end		= OMAP2_UART3_BASE + SZ_1K - 1,
+		.flags		= ADDR_MAP_ON_INIT | ADDR_TYPE_RT,
+	},
+};
+
+static struct omap_hwmod_ocp_if omap2_l4_core__uart3 = {
+	.master		= &omap2430_l4_core_hwmod,
+	.slave		= &omap2430_uart3_hwmod,
+	.clk		= "uart3_ick",
+	.addr		= omap2430_uart3_addr_space,
+	.addr_cnt	= ARRAY_SIZE(omap2430_uart3_addr_space),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
 /* Slave interfaces on the L4_CORE interconnect */
 static struct omap_hwmod_ocp_if *omap2430_l4_core_slaves[] = {
 	&omap2430_l3_main__l4_core,
@@ -104,6 +162,9 @@ static struct omap_hwmod omap2430_l4_core_hwmod = {
 /* Slave interfaces on the L4_WKUP interconnect */
 static struct omap_hwmod_ocp_if *omap2430_l4_wkup_slaves[] = {
 	&omap2430_l4_core__l4_wkup,
+	&omap2_l4_core__uart1,
+	&omap2_l4_core__uart2,
+	&omap2_l4_core__uart3,
 };

 /* Master interfaces on the L4_WKUP interconnect */
@@ -165,12 +226,144 @@ static struct omap_hwmod omap2430_iva_hwmod = {
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2430)
 };

+/* UART */
+
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
+
+static struct omap_hwmod_irq_info uart1_mpu_irqs[] = {
+	{ .irq = INT_24XX_UART1_IRQ, },
+};
+
+static struct omap_hwmod_dma_info uart1_sdma_reqs[] = {
+	{ .name = "rx",	.dma_req = OMAP24XX_DMA_UART1_RX, },
+	{ .name = "tx",	.dma_req = OMAP24XX_DMA_UART1_TX, },
+};
+
+static struct omap_hwmod_ocp_if *omap2430_uart1_slaves[] = {
+	&omap2_l4_core__uart1,
+};
+
+static struct omap_hwmod omap2430_uart1_hwmod = {
+	.name		= "uart1",
+	.mpu_irqs	= uart1_mpu_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(uart1_mpu_irqs),
+	.sdma_reqs	= uart1_sdma_reqs,
+	.sdma_reqs_cnt	= ARRAY_SIZE(uart1_sdma_reqs),
+	.main_clk	= "uart1_fck",
+	.prcm		= {
+		.omap2 = {
+			.module_offs = CORE_MOD,
+			.prcm_reg_id = 1,
+			.module_bit = OMAP24XX_EN_UART1_SHIFT,
+			.idlest_reg_id = 1,
+			.idlest_idle_bit = OMAP24XX_EN_UART1_SHIFT,
+		},
+	},
+	.slaves		= omap2430_uart1_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap2430_uart1_slaves),
+	.class		= &uart_class,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2430),
+};
+
+/* UART2 */
+
+static struct omap_hwmod_irq_info uart2_mpu_irqs[] = {
+	{ .irq = INT_24XX_UART2_IRQ, },
+};
+
+static struct omap_hwmod_dma_info uart2_sdma_reqs[] = {
+	{ .name = "rx",	.dma_req = OMAP24XX_DMA_UART2_RX, },
+	{ .name = "tx",	.dma_req = OMAP24XX_DMA_UART2_TX, },
+};
+
+static struct omap_hwmod_ocp_if *omap2430_uart2_slaves[] = {
+	&omap2_l4_core__uart2,
+};
+
+static struct omap_hwmod omap2430_uart2_hwmod = {
+	.name		= "uart2",
+	.mpu_irqs	= uart2_mpu_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(uart2_mpu_irqs),
+	.sdma_reqs	= uart2_sdma_reqs,
+	.sdma_reqs_cnt	= ARRAY_SIZE(uart2_sdma_reqs),
+	.main_clk	= "uart2_fck",
+	.prcm		= {
+		.omap2 = {
+			.module_offs = CORE_MOD,
+			.prcm_reg_id = 1,
+			.module_bit = OMAP24XX_EN_UART2_SHIFT,
+			.idlest_reg_id = 1,
+			.idlest_idle_bit = OMAP24XX_EN_UART2_SHIFT,
+		},
+	},
+	.slaves		= omap2430_uart2_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap2430_uart2_slaves),
+	.class		= &uart_class,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2430),
+};
+
+/* UART3 */
+
+static struct omap_hwmod_irq_info uart3_mpu_irqs[] = {
+	{ .irq = INT_24XX_UART3_IRQ, },
+};
+
+static struct omap_hwmod_dma_info uart3_sdma_reqs[] = {
+	{ .name = "rx",	.dma_req = OMAP24XX_DMA_UART3_RX, },
+	{ .name = "tx",	.dma_req = OMAP24XX_DMA_UART3_TX, },
+};
+
+static struct omap_hwmod_ocp_if *omap2430_uart3_slaves[] = {
+	&omap2_l4_core__uart3,
+};
+
+static struct omap_hwmod omap2430_uart3_hwmod = {
+	.name		= "uart3",
+	.mpu_irqs	= uart3_mpu_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(uart3_mpu_irqs),
+	.sdma_reqs	= uart3_sdma_reqs,
+	.sdma_reqs_cnt	= ARRAY_SIZE(uart3_sdma_reqs),
+	.main_clk	= "uart3_fck",
+	.prcm		= {
+		.omap2 = {
+			.module_offs = CORE_MOD,
+			.prcm_reg_id = 1,
+			.module_bit = OMAP24XX_EN_UART3_SHIFT,
+			.idlest_reg_id = 1,
+			.idlest_idle_bit = OMAP24XX_EN_UART3_SHIFT,
+		},
+	},
+	.slaves		= omap2430_uart3_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap2430_uart3_slaves),
+	.class		= &uart_class,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2430),
+};
+
 static __initdata struct omap_hwmod *omap2430_hwmods[] = {
 	&omap2430_l3_main_hwmod,
 	&omap2430_l4_core_hwmod,
 	&omap2430_l4_wkup_hwmod,
 	&omap2430_mpu_hwmod,
 	&omap2430_iva_hwmod,
+	&omap2430_uart1_hwmod,
+	&omap2430_uart2_hwmod,
+	&omap2430_uart3_hwmod,
 	NULL,
 };

diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index 5d8eb58..5c9cb25 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -17,6 +17,7 @@
 #include <mach/irqs.h>
 #include <plat/cpu.h>
 #include <plat/dma.h>
+#include <plat/serial.h>

 #include "omap_hwmod_common_data.h"

@@ -82,6 +83,10 @@ static struct omap_hwmod omap3xxx_l3_main_hwmod = {
 };

 static struct omap_hwmod omap3xxx_l4_wkup_hwmod;
+static struct omap_hwmod omap3xxx_uart1_hwmod;
+static struct omap_hwmod omap3xxx_uart2_hwmod;
+static struct omap_hwmod omap3xxx_uart3_hwmod;
+static struct omap_hwmod omap3xxx_uart4_hwmod;

 /* L4_CORE -> L4_WKUP interface */
 static struct omap_hwmod_ocp_if omap3xxx_l4_core__l4_wkup = {
@@ -90,6 +95,78 @@ static struct omap_hwmod_ocp_if omap3xxx_l4_core__l4_wkup = {
 	.user	= OCP_USER_MPU | OCP_USER_SDMA,
 };

+/* L4 CORE -> UART1 interface */
+static struct omap_hwmod_addr_space omap3xxx_uart1_addr_space[] = {
+	{
+		.pa_start	= OMAP3_UART1_BASE,
+		.pa_end		= OMAP3_UART1_BASE + SZ_8K - 1,
+		.flags		= ADDR_MAP_ON_INIT | ADDR_TYPE_RT,
+	},
+};
+
+static struct omap_hwmod_ocp_if omap3_l4_core__uart1 = {
+	.master		= &omap3xxx_l4_core_hwmod,
+	.slave		= &omap3xxx_uart1_hwmod,
+	.clk		= "uart1_ick",
+	.addr		= omap3xxx_uart1_addr_space,
+	.addr_cnt	= ARRAY_SIZE(omap3xxx_uart1_addr_space),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* L4 CORE -> UART2 interface */
+static struct omap_hwmod_addr_space omap3xxx_uart2_addr_space[] = {
+	{
+		.pa_start	= OMAP3_UART2_BASE,
+		.pa_end		= OMAP3_UART2_BASE + SZ_1K - 1,
+		.flags		= ADDR_MAP_ON_INIT | ADDR_TYPE_RT,
+	},
+};
+
+static struct omap_hwmod_ocp_if omap3_l4_core__uart2 = {
+	.master		= &omap3xxx_l4_core_hwmod,
+	.slave		= &omap3xxx_uart2_hwmod,
+	.clk		= "uart2_ick",
+	.addr		= omap3xxx_uart2_addr_space,
+	.addr_cnt	= ARRAY_SIZE(omap3xxx_uart2_addr_space),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* L4 PER -> UART3 interface */
+static struct omap_hwmod_addr_space omap3xxx_uart3_addr_space[] = {
+	{
+		.pa_start	= OMAP3_UART3_BASE,
+		.pa_end		= OMAP3_UART3_BASE + SZ_1K - 1,
+		.flags		= ADDR_MAP_ON_INIT | ADDR_TYPE_RT,
+	},
+};
+
+static struct omap_hwmod_ocp_if omap3_l4_per__uart3 = {
+	.master		= &omap3xxx_l4_per_hwmod,
+	.slave		= &omap3xxx_uart3_hwmod,
+	.clk		= "uart3_ick",
+	.addr		= omap3xxx_uart3_addr_space,
+	.addr_cnt	= ARRAY_SIZE(omap3xxx_uart3_addr_space),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* L4 PER -> UART4 interface */
+static struct omap_hwmod_addr_space omap3xxx_uart4_addr_space[] = {
+	{
+		.pa_start	= OMAP3_UART4_BASE,
+		.pa_end		= OMAP3_UART4_BASE + SZ_1K - 1,
+		.flags		= ADDR_MAP_ON_INIT | ADDR_TYPE_RT,
+	},
+};
+
+static struct omap_hwmod_ocp_if omap3_l4_per__uart4 = {
+	.master		= &omap3xxx_l4_per_hwmod,
+	.slave		= &omap3xxx_uart4_hwmod,
+	.clk		= "uart4_ick",
+	.addr		= omap3xxx_uart4_addr_space,
+	.addr_cnt	= ARRAY_SIZE(omap3xxx_uart4_addr_space),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
 /* Slave interfaces on the L4_CORE interconnect */
 static struct omap_hwmod_ocp_if *omap3xxx_l4_core_slaves[] = {
 	&omap3xxx_l3_main__l4_core,
@@ -98,6 +175,8 @@ static struct omap_hwmod_ocp_if *omap3xxx_l4_core_slaves[] = {
 /* Master interfaces on the L4_CORE interconnect */
 static struct omap_hwmod_ocp_if *omap3xxx_l4_core_masters[] = {
 	&omap3xxx_l4_core__l4_wkup,
+	&omap3_l4_core__uart1,
+	&omap3_l4_core__uart2,
 };

 /* L4 CORE */
@@ -119,6 +198,8 @@ static struct omap_hwmod_ocp_if *omap3xxx_l4_per_slaves[] = {

 /* Master interfaces on the L4_PER interconnect */
 static struct omap_hwmod_ocp_if *omap3xxx_l4_per_masters[] = {
+	&omap3_l4_per__uart3,
+	&omap3_l4_per__uart4,
 };

 /* L4 PER */
@@ -197,6 +278,172 @@ static struct omap_hwmod omap3xxx_iva_hwmod = {
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
 };

+/* UART common */
+
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
+
+static struct omap_hwmod_irq_info uart1_mpu_irqs[] = {
+	{ .irq = INT_24XX_UART1_IRQ, },
+};
+
+static struct omap_hwmod_dma_info uart1_sdma_reqs[] = {
+	{ .name = "tx",	.dma_req = OMAP24XX_DMA_UART1_TX, },
+	{ .name = "rx",	.dma_req = OMAP24XX_DMA_UART1_RX, },
+};
+
+static struct omap_hwmod_ocp_if *omap3xxx_uart1_slaves[] = {
+	&omap3_l4_core__uart1,
+};
+
+static struct omap_hwmod omap3xxx_uart1_hwmod = {
+	.name		= "uart1",
+	.mpu_irqs	= uart1_mpu_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(uart1_mpu_irqs),
+	.sdma_reqs	= uart1_sdma_reqs,
+	.sdma_reqs_cnt	= ARRAY_SIZE(uart1_sdma_reqs),
+	.main_clk	= "uart1_fck",
+	.prcm		= {
+		.omap2 = {
+			.module_offs = CORE_MOD,
+			.prcm_reg_id = 1,
+			.module_bit = OMAP3430_EN_UART1_SHIFT,
+			.idlest_reg_id = 1,
+			.idlest_idle_bit = OMAP3430_EN_UART1_SHIFT,
+		},
+	},
+	.slaves		= omap3xxx_uart1_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap3xxx_uart1_slaves),
+	.class		= &uart_class,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+};
+
+/* UART2 */
+
+static struct omap_hwmod_irq_info uart2_mpu_irqs[] = {
+	{ .irq = INT_24XX_UART2_IRQ, },
+};
+
+static struct omap_hwmod_dma_info uart2_sdma_reqs[] = {
+	{ .name = "tx",	.dma_req = OMAP24XX_DMA_UART2_TX, },
+	{ .name = "rx",	.dma_req = OMAP24XX_DMA_UART2_RX, },
+};
+
+static struct omap_hwmod_ocp_if *omap3xxx_uart2_slaves[] = {
+	&omap3_l4_core__uart2,
+};
+
+static struct omap_hwmod omap3xxx_uart2_hwmod = {
+	.name		= "uart2",
+	.mpu_irqs	= uart2_mpu_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(uart2_mpu_irqs),
+	.sdma_reqs	= uart2_sdma_reqs,
+	.sdma_reqs_cnt	= ARRAY_SIZE(uart2_sdma_reqs),
+	.main_clk	= "uart2_fck",
+	.prcm		= {
+		.omap2 = {
+			.module_offs = CORE_MOD,
+			.prcm_reg_id = 1,
+			.module_bit = OMAP3430_EN_UART2_SHIFT,
+			.idlest_reg_id = 1,
+			.idlest_idle_bit = OMAP3430_EN_UART2_SHIFT,
+		},
+	},
+	.slaves		= omap3xxx_uart2_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap3xxx_uart2_slaves),
+	.class		= &uart_class,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+};
+
+/* UART3 */
+
+static struct omap_hwmod_irq_info uart3_mpu_irqs[] = {
+	{ .irq = INT_24XX_UART3_IRQ, },
+};
+
+static struct omap_hwmod_dma_info uart3_sdma_reqs[] = {
+	{ .name = "tx",	.dma_req = OMAP24XX_DMA_UART3_TX, },
+	{ .name = "rx",	.dma_req = OMAP24XX_DMA_UART3_RX, },
+};
+
+static struct omap_hwmod_ocp_if *omap3xxx_uart3_slaves[] = {
+	&omap3_l4_per__uart3,
+};
+
+static struct omap_hwmod omap3xxx_uart3_hwmod = {
+	.name		= "uart3",
+	.mpu_irqs	= uart3_mpu_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(uart3_mpu_irqs),
+	.sdma_reqs	= uart3_sdma_reqs,
+	.sdma_reqs_cnt	= ARRAY_SIZE(uart3_sdma_reqs),
+	.main_clk	= "uart3_fck",
+	.prcm		= {
+		.omap2 = {
+			.module_offs = OMAP3430_PER_MOD,
+			.prcm_reg_id = 1,
+			.module_bit = OMAP3430_EN_UART3_SHIFT,
+			.idlest_reg_id = 1,
+			.idlest_idle_bit = OMAP3430_EN_UART3_SHIFT,
+		},
+	},
+	.slaves		= omap3xxx_uart3_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap3xxx_uart3_slaves),
+	.class		= &uart_class,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+};
+
+/* UART4 */
+
+static struct omap_hwmod_irq_info uart4_mpu_irqs[] = {
+	{ .irq = INT_36XX_UART4_IRQ, },
+};
+
+static struct omap_hwmod_dma_info uart4_sdma_reqs[] = {
+	{ .name = "rx",	.dma_req = OMAP36XX_DMA_UART4_RX, },
+	{ .name = "tx",	.dma_req = OMAP36XX_DMA_UART4_TX, },
+};
+
+static struct omap_hwmod_ocp_if *omap3xxx_uart4_slaves[] = {
+	&omap3_l4_per__uart4,
+};
+
+static struct omap_hwmod omap3xxx_uart4_hwmod = {
+	.name		= "uart4",
+	.mpu_irqs	= uart4_mpu_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(uart4_mpu_irqs),
+	.sdma_reqs	= uart4_sdma_reqs,
+	.sdma_reqs_cnt	= ARRAY_SIZE(uart4_sdma_reqs),
+	.main_clk	= "uart4_fck",
+	.prcm		= {
+		.omap2 = {
+			.module_offs = OMAP3430_PER_MOD,
+			.prcm_reg_id = 1,
+			.module_bit = OMAP3630_EN_UART4_SHIFT,
+			.idlest_reg_id = 1,
+			.idlest_idle_bit = OMAP3630_EN_UART4_SHIFT,
+		},
+	},
+	.slaves		= omap3xxx_uart4_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap3xxx_uart4_slaves),
+	.class		= &uart_class,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3630ES1),
+};
+
 static __initdata struct omap_hwmod *omap3xxx_hwmods[] = {
 	&omap3xxx_l3_main_hwmod,
 	&omap3xxx_l4_core_hwmod,
@@ -204,6 +451,10 @@ static __initdata struct omap_hwmod *omap3xxx_hwmods[] = {
 	&omap3xxx_l4_wkup_hwmod,
 	&omap3xxx_mpu_hwmod,
 	&omap3xxx_iva_hwmod,
+	&omap3xxx_uart1_hwmod,
+	&omap3xxx_uart2_hwmod,
+	&omap3xxx_uart3_hwmod,
+	&omap3xxx_uart4_hwmod,
 	NULL,
 };

@@ -211,5 +462,3 @@ int __init omap3xxx_hwmod_init(void)
 {
 	return omap_hwmod_init(omap3xxx_hwmods);
 }
-
-
diff --git a/arch/arm/mach-omap2/prcm-common.h b/arch/arm/mach-omap2/prcm-common.h
index 995b7ed..86edcf9 100644
--- a/arch/arm/mach-omap2/prcm-common.h
+++ b/arch/arm/mach-omap2/prcm-common.h
@@ -382,6 +382,9 @@
 #define OMAP3430_EN_MPU_SHIFT				1

 /* CM_FCLKEN_PER, CM_ICLKEN_PER, PM_WKEN_PER shared bits */
+
+#define OMAP3630_EN_UART4_MASK				(1 << 18)
+#define OMAP3630_EN_UART4_SHIFT				18
 #define OMAP3430_EN_GPIO6_MASK				(1 << 17)
 #define OMAP3430_EN_GPIO6_SHIFT				17
 #define OMAP3430_EN_GPIO5_MASK				(1 << 16)
diff --git a/arch/arm/plat-omap/include/plat/dma.h b/arch/arm/plat-omap/include/plat/dma.h
index af3a039..098f154 100644
--- a/arch/arm/plat-omap/include/plat/dma.h
+++ b/arch/arm/plat-omap/include/plat/dma.h
@@ -319,6 +319,8 @@
 #define OMAP34XX_DMA_USIM_TX		79	/* S_DMA_78 */
 #define OMAP34XX_DMA_USIM_RX		80	/* S_DMA_79 */

+#define OMAP36XX_DMA_UART4_TX		81	/* S_DMA_80 */
+#define OMAP36XX_DMA_UART4_RX		82	/* S_DMA_81 */
 /*----------------------------------------------------------------------------*/

 #define OMAP1_DMA_TOUT_IRQ		(1 << 0)
diff --git a/arch/arm/plat-omap/include/plat/irqs.h b/arch/arm/plat-omap/include/plat/irqs.h
index c01d9f0..65e20a6 100644
--- a/arch/arm/plat-omap/include/plat/irqs.h
+++ b/arch/arm/plat-omap/include/plat/irqs.h
@@ -345,6 +345,8 @@
 #define INT_34XX_MMC3_IRQ	94
 #define INT_34XX_GPT12_IRQ	95

+#define INT_36XX_UART4_IRQ	80
+
 #define INT_35XX_HECC0_IRQ		24
 #define INT_35XX_HECC1_IRQ		28
 #define INT_35XX_EMAC_C0_RXTHRESH_IRQ	67
-- 
1.6.3.3



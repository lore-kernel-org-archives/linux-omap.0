From: Charulatha V <charu@ti.com>
Subject: [PATCH 07/11] OMAP: GPIO: add GPIO hwmods structures for OMAP242X
Date: Tue, 18 May 2010 20:20:56 +0530
Message-ID: <1274194260-16401-8-git-send-email-charu@ti.com>
References: <1274194260-16401-1-git-send-email-charu@ti.com>
 <1274194260-16401-2-git-send-email-charu@ti.com>
 <1274194260-16401-3-git-send-email-charu@ti.com>
 <1274194260-16401-4-git-send-email-charu@ti.com>
 <1274194260-16401-5-git-send-email-charu@ti.com>
 <1274194260-16401-6-git-send-email-charu@ti.com>
 <1274194260-16401-7-git-send-email-charu@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:52282 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757879Ab0EROty (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 May 2010 10:49:54 -0400
In-Reply-To: <1274194260-16401-7-git-send-email-charu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: rnayak@ti.com, paul@pwsan.com, tony@atomide.com, khilman@deeprootsystems.com, Charulatha V <charu@ti.com>

Add hwmod structures for GPIO module on OMAP242X

Signed-off-by: Charulatha V <charu@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_2420_data.c |  222 ++++++++++++++++++++++++++++
 1 files changed, 222 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_2420_data.c b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
index eb7ee24..4d05a9a 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2420_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
@@ -15,6 +15,7 @@
 #include <mach/irqs.h>
 #include <plat/cpu.h>
 #include <plat/dma.h>
+#include <plat/gpio.h>
 
 #include "omap_hwmod_common_data.h"
 
@@ -32,6 +33,10 @@
 static struct omap_hwmod omap2420_mpu_hwmod;
 static struct omap_hwmod omap2420_l3_hwmod;
 static struct omap_hwmod omap2420_l4_core_hwmod;
+static struct omap_hwmod omap2420_gpio1_hwmod;
+static struct omap_hwmod omap2420_gpio2_hwmod;
+static struct omap_hwmod omap2420_gpio3_hwmod;
+static struct omap_hwmod omap2420_gpio4_hwmod;
 
 /* L3 -> L4_CORE interface */
 static struct omap_hwmod_ocp_if omap2420_l3__l4_core = {
@@ -87,6 +92,78 @@ static struct omap_hwmod_ocp_if *omap2420_l4_core_masters[] = {
 	&omap2420_l4_core__l4_wkup,
 };
 
+/* L4 WKUP -> GPIO1 interface */
+static struct omap_hwmod_addr_space omap2420_gpio1_addr_space[] = {
+	{
+		.pa_start	= OMAP242X_GPIO1_BASE,
+		.pa_end		= OMAP242X_GPIO1_BASE + SZ_4K - 1,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+
+static struct omap_hwmod_ocp_if omap2420_l4_wkup__gpio1 = {
+	.master		= &omap2420_l4_wkup_hwmod,
+	.slave		= &omap2420_gpio1_hwmod,
+	.clk		= "gpios_ick",
+	.addr		= omap2420_gpio1_addr_space,
+	.addr_cnt	= ARRAY_SIZE(omap2420_gpio1_addr_space),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* L4 WKUP -> GPIO2 interface */
+static struct omap_hwmod_addr_space omap2420_gpio2_addr_space[] = {
+	{
+		.pa_start	= OMAP242X_GPIO2_BASE,
+		.pa_end		= OMAP242X_GPIO2_BASE + SZ_4K - 1,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+
+static struct omap_hwmod_ocp_if omap2420_l4_wkup__gpio2 = {
+	.master		= &omap2420_l4_wkup_hwmod,
+	.slave		= &omap2420_gpio2_hwmod,
+	.clk		= "gpios_ick",
+	.addr		= omap2420_gpio2_addr_space,
+	.addr_cnt	= ARRAY_SIZE(omap2420_gpio2_addr_space),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* L4 WKUP -> GPIO3 interface */
+static struct omap_hwmod_addr_space omap2420_gpio3_addr_space[] = {
+	{
+		.pa_start	= OMAP242X_GPIO3_BASE,
+		.pa_end		= OMAP242X_GPIO3_BASE + SZ_4K - 1,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+
+static struct omap_hwmod_ocp_if omap2420_l4_wkup__gpio3 = {
+	.master		= &omap2420_l4_wkup_hwmod,
+	.slave		= &omap2420_gpio3_hwmod,
+	.clk		= "gpios_ick",
+	.addr		= omap2420_gpio3_addr_space,
+	.addr_cnt	= ARRAY_SIZE(omap2420_gpio3_addr_space),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* L4 WKUP -> GPIO4 interface */
+static struct omap_hwmod_addr_space omap2420_gpio4_addr_space[] = {
+	{
+		.pa_start	= OMAP242X_GPIO4_BASE,
+		.pa_end		= OMAP242X_GPIO4_BASE + SZ_4K - 1,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+
+static struct omap_hwmod_ocp_if omap2420_l4_wkup__gpio4 = {
+	.master		= &omap2420_l4_wkup_hwmod,
+	.slave		= &omap2420_gpio4_hwmod,
+	.clk		= "gpios_ick",
+	.addr		= omap2420_gpio4_addr_space,
+	.addr_cnt	= ARRAY_SIZE(omap2420_gpio4_addr_space),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
 /* L4 CORE */
 static struct omap_hwmod omap2420_l4_core_hwmod = {
 	.name		= "l4_core_hwmod",
@@ -101,6 +178,10 @@ static struct omap_hwmod omap2420_l4_core_hwmod = {
 /* Slave interfaces on the L4_WKUP interconnect */
 static struct omap_hwmod_ocp_if *omap2420_l4_wkup_slaves[] = {
 	&omap2420_l4_core__l4_wkup,
+	&omap2420_l4_wkup__gpio1,
+	&omap2420_l4_wkup__gpio2,
+	&omap2420_l4_wkup__gpio3,
+	&omap2420_l4_wkup__gpio4,
 };
 
 /* Master interfaces on the L4_WKUP interconnect */
@@ -133,11 +214,152 @@ static struct omap_hwmod omap2420_mpu_hwmod = {
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2420),
 };
 
+/* GPIO common */
+
+static struct omap_gpio_dev_attr gpio_dev_attr = {
+	.gpio_bank_count = 4,
+	.gpio_bank_bits = 32,
+	.dbck_flag = false,
+	.fck_flag = true,
+};
+
+static struct omap_hwmod_class_sysconfig gpio_sysc = {
+	.rev_offs	= 0x0000,
+	.sysc_offs	= 0x0010,
+	.syss_offs	= 0x0014,
+	.sysc_flags	= (SYSC_HAS_SIDLEMODE |
+			   SYSC_HAS_ENAWAKEUP | SYSC_HAS_SOFTRESET |
+			   SYSC_HAS_AUTOIDLE),
+	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
+	.sysc_fields    = &omap_hwmod_sysc_type1,
+};
+
+static struct omap_hwmod_class gpio_class = {
+	.name = "gpio",
+	.sysc = &gpio_sysc,
+};
+
+/* GPIO1 */
+
+static struct omap_hwmod_irq_info gpio1_mpu_irqs[] = {
+	{ .name = "gpio_mpu_irq", .irq = INT_24XX_GPIO_BANK1 },
+};
+
+static struct omap_hwmod_ocp_if *omap2420_gpio1_slaves[] = {
+	&omap2420_l4_wkup__gpio1,
+};
+
+static struct omap_hwmod omap2420_gpio1_hwmod = {
+	.name		= "gpio1_hwmod",
+	.mpu_irqs	= gpio1_mpu_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(gpio1_mpu_irqs),
+	.main_clk	= "gpios_fck",
+	.prcm		= {
+		.omap2 = {
+			.prcm_reg_id = 1,
+			.module_bit = OMAP24XX_EN_GPIOS_SHIFT,
+		},
+	},
+	.slaves		= omap2420_gpio1_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap2420_gpio1_slaves),
+	.class		= &gpio_class,
+	.dev_attr	= &gpio_dev_attr,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2420),
+};
+
+/* GPIO2 */
+
+static struct omap_hwmod_irq_info gpio2_mpu_irqs[] = {
+	{ .name = "gpio_mpu_irq", .irq = INT_24XX_GPIO_BANK2 },
+};
+
+static struct omap_hwmod_ocp_if *omap2420_gpio2_slaves[] = {
+	&omap2420_l4_wkup__gpio2,
+};
+
+static struct omap_hwmod omap2420_gpio2_hwmod = {
+	.name		= "gpio2_hwmod",
+	.mpu_irqs	= gpio2_mpu_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(gpio2_mpu_irqs),
+	.main_clk	= "gpios_fck",
+	.prcm		= {
+		.omap2 = {
+			.prcm_reg_id = 1,
+			.module_bit = OMAP24XX_EN_GPIOS_SHIFT,
+		},
+	},
+	.slaves		= omap2420_gpio2_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap2420_gpio2_slaves),
+	.class		= &gpio_class,
+	.dev_attr	= &gpio_dev_attr,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2420),
+};
+
+/* GPIO3 */
+
+static struct omap_hwmod_irq_info gpio3_mpu_irqs[] = {
+	{ .name = "gpio_mpu_irq", .irq = INT_24XX_GPIO_BANK3 },
+};
+
+static struct omap_hwmod_ocp_if *omap2420_gpio3_slaves[] = {
+	&omap2420_l4_wkup__gpio3,
+};
+
+static struct omap_hwmod omap2420_gpio3_hwmod = {
+	.name		= "gpio3_hwmod",
+	.mpu_irqs	= gpio3_mpu_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(gpio3_mpu_irqs),
+	.main_clk	= "gpios_fck",
+	.prcm		= {
+		.omap2 = {
+			.prcm_reg_id = 1,
+			.module_bit = OMAP24XX_EN_GPIOS_SHIFT,
+		},
+	},
+	.slaves		= omap2420_gpio3_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap2420_gpio3_slaves),
+	.class		= &gpio_class,
+	.dev_attr	= &gpio_dev_attr,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2420),
+};
+
+/* GPIO4 */
+
+static struct omap_hwmod_irq_info gpio4_mpu_irqs[] = {
+	{ .name = "gpio_mpu_irq", .irq = INT_24XX_GPIO_BANK4 },
+};
+
+static struct omap_hwmod_ocp_if *omap2420_gpio4_slaves[] = {
+	&omap2420_l4_wkup__gpio4,
+};
+
+static struct omap_hwmod omap2420_gpio4_hwmod = {
+	.name		= "gpio4_hwmod",
+	.mpu_irqs	= gpio4_mpu_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(gpio4_mpu_irqs),
+	.main_clk	= "gpios_fck",
+	.prcm		= {
+		.omap2 = {
+			.prcm_reg_id = 1,
+			.module_bit = OMAP24XX_EN_GPIOS_SHIFT,
+		},
+	},
+	.slaves		= omap2420_gpio4_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap2420_gpio4_slaves),
+	.class		= &gpio_class,
+	.dev_attr	= &gpio_dev_attr,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2420),
+};
+
 static __initdata struct omap_hwmod *omap2420_hwmods[] = {
 	&omap2420_l3_hwmod,
 	&omap2420_l4_core_hwmod,
 	&omap2420_l4_wkup_hwmod,
 	&omap2420_mpu_hwmod,
+	&omap2420_gpio1_hwmod,
+	&omap2420_gpio2_hwmod,
+	&omap2420_gpio3_hwmod,
+	&omap2420_gpio4_hwmod,
 	NULL,
 };
 
-- 
1.6.3.3


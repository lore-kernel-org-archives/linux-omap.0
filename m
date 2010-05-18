From: Charulatha V <charu@ti.com>
Subject: [PATCH 06/11] OMAP: GPIO: add GPIO hwmods structures for OMAP3
Date: Tue, 18 May 2010 20:20:55 +0530
Message-ID: <1274194260-16401-7-git-send-email-charu@ti.com>
References: <1274194260-16401-1-git-send-email-charu@ti.com>
 <1274194260-16401-2-git-send-email-charu@ti.com>
 <1274194260-16401-3-git-send-email-charu@ti.com>
 <1274194260-16401-4-git-send-email-charu@ti.com>
 <1274194260-16401-5-git-send-email-charu@ti.com>
 <1274194260-16401-6-git-send-email-charu@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:52281 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757856Ab0EROty (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 May 2010 10:49:54 -0400
In-Reply-To: <1274194260-16401-6-git-send-email-charu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: rnayak@ti.com, paul@pwsan.com, tony@atomide.com, khilman@deeprootsystems.com, Charulatha V <charu@ti.com>

Add hwmod structures for GPIO module on OMAP3

Signed-off-by: Charulatha V <charu@ti.com>
Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |  357 +++++++++++++++++++++++++++-
 1 files changed, 356 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index 5f74c34..499be79 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -20,6 +20,7 @@
 #include <plat/serial.h>
 #include <plat/l4_3xxx.h>
 #include <plat/mmc.h>
+#include <plat/gpio.h>
 
 #include "omap_hwmod_common_data.h"
 
@@ -89,6 +90,12 @@ static struct omap_hwmod omap3xxx_uart3_hwmod;
 static struct omap_hwmod omap3xxx_mmc1_hwmod;
 static struct omap_hwmod omap3xxx_mmc2_hwmod;
 static struct omap_hwmod omap3xxx_mmc3_hwmod;
+static struct omap_hwmod omap3xxx_gpio1_hwmod;
+static struct omap_hwmod omap3xxx_gpio2_hwmod;
+static struct omap_hwmod omap3xxx_gpio3_hwmod;
+static struct omap_hwmod omap3xxx_gpio4_hwmod;
+static struct omap_hwmod omap3xxx_gpio5_hwmod;
+static struct omap_hwmod omap3xxx_gpio6_hwmod;
 
 /* L4_CORE -> L4_WKUP interface */
 static struct omap_hwmod_ocp_if omap3xxx_l4_core__l4_wkup = {
@@ -226,6 +233,114 @@ static struct omap_hwmod_ocp_if omap3xxx_l4_core__mmc3 = {
 	.flags		= OMAP_FIREWALL_L4
 };
 
+/* L4 WKUP -> GPIO1 interface */
+static struct omap_hwmod_addr_space omap3xxx_gpio1_addr_space[] = {
+	{
+		.pa_start	= OMAP34XX_GPIO1_BASE,
+		.pa_end		= OMAP34XX_GPIO1_BASE + SZ_4K - 1,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+
+static struct omap_hwmod_ocp_if omap3xxx_l4_wkup__gpio1 = {
+	.master		= &omap3xxx_l4_wkup_hwmod,
+	.slave		= &omap3xxx_gpio1_hwmod,
+	.clk		= "gpio1_ick",
+	.addr		= omap3xxx_gpio1_addr_space,
+	.addr_cnt	= ARRAY_SIZE(omap3xxx_gpio1_addr_space),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* L4 PER -> GPIO2 interface */
+static struct omap_hwmod_addr_space omap3xxx_gpio2_addr_space[] = {
+	{
+		.pa_start	= OMAP34XX_GPIO2_BASE,
+		.pa_end		= OMAP34XX_GPIO2_BASE + SZ_4K - 1,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+
+static struct omap_hwmod_ocp_if omap3xxx_l4_per__gpio2 = {
+	.master		= &omap3xxx_l4_per_hwmod,
+	.slave		= &omap3xxx_gpio2_hwmod,
+	.clk		= "gpio2_ick",
+	.addr		= omap3xxx_gpio2_addr_space,
+	.addr_cnt	= ARRAY_SIZE(omap3xxx_gpio2_addr_space),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* L4 PER -> GPIO3 interface */
+static struct omap_hwmod_addr_space omap3xxx_gpio3_addr_space[] = {
+	{
+		.pa_start	= OMAP34XX_GPIO3_BASE,
+		.pa_end		= OMAP34XX_GPIO3_BASE + SZ_4K - 1,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+
+static struct omap_hwmod_ocp_if omap3xxx_l4_per__gpio3 = {
+	.master		= &omap3xxx_l4_per_hwmod,
+	.slave		= &omap3xxx_gpio3_hwmod,
+	.clk		= "gpio3_ick",
+	.addr		= omap3xxx_gpio3_addr_space,
+	.addr_cnt	= ARRAY_SIZE(omap3xxx_gpio3_addr_space),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* L4 PER -> GPIO4 interface */
+static struct omap_hwmod_addr_space omap3xxx_gpio4_addr_space[] = {
+	{
+		.pa_start	= OMAP34XX_GPIO4_BASE,
+		.pa_end		= OMAP34XX_GPIO4_BASE + SZ_4K - 1,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+
+static struct omap_hwmod_ocp_if omap3xxx_l4_per__gpio4 = {
+	.master		= &omap3xxx_l4_per_hwmod,
+	.slave		= &omap3xxx_gpio4_hwmod,
+	.clk		= "gpio4_ick",
+	.addr		= omap3xxx_gpio4_addr_space,
+	.addr_cnt	= ARRAY_SIZE(omap3xxx_gpio4_addr_space),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* L4 PER -> GPIO5 interface */
+static struct omap_hwmod_addr_space omap3xxx_gpio5_addr_space[] = {
+	{
+		.pa_start	= OMAP34XX_GPIO5_BASE,
+		.pa_end		= OMAP34XX_GPIO5_BASE + SZ_4K - 1,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+
+static struct omap_hwmod_ocp_if omap3xxx_l4_per__gpio5 = {
+	.master		= &omap3xxx_l4_per_hwmod,
+	.slave		= &omap3xxx_gpio5_hwmod,
+	.clk		= "gpio5_ick",
+	.addr		= omap3xxx_gpio5_addr_space,
+	.addr_cnt	= ARRAY_SIZE(omap3xxx_gpio5_addr_space),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* L4 PER -> GPIO6 interface */
+static struct omap_hwmod_addr_space omap3xxx_gpio6_addr_space[] = {
+	{
+		.pa_start	= OMAP34XX_GPIO6_BASE,
+		.pa_end		= OMAP34XX_GPIO6_BASE + SZ_4K - 1,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+
+static struct omap_hwmod_ocp_if omap3xxx_l4_per__gpio6 = {
+	.master		= &omap3xxx_l4_per_hwmod,
+	.slave		= &omap3xxx_gpio6_hwmod,
+	.clk		= "gpio6_ick",
+	.addr		= omap3xxx_gpio6_addr_space,
+	.addr_cnt	= ARRAY_SIZE(omap3xxx_gpio6_addr_space),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
 /* Slave interfaces on the L4_CORE interconnect */
 static struct omap_hwmod_ocp_if *omap3xxx_l4_core_slaves[] = {
 	&omap3xxx_l3__l4_core,
@@ -252,6 +367,11 @@ static struct omap_hwmod omap3xxx_l4_core_hwmod = {
 /* Slave interfaces on the L4_PER interconnect */
 static struct omap_hwmod_ocp_if *omap3xxx_l4_per_slaves[] = {
 	&omap3xxx_l3__l4_per,
+	&omap3xxx_l4_per__gpio2,
+	&omap3xxx_l4_per__gpio3,
+	&omap3xxx_l4_per__gpio4,
+	&omap3xxx_l4_per__gpio5,
+	&omap3xxx_l4_per__gpio6,
 };
 
 /* Master interfaces on the L4_PER interconnect */
@@ -273,6 +393,7 @@ static struct omap_hwmod omap3xxx_l4_per_hwmod = {
 /* Slave interfaces on the L4_WKUP interconnect */
 static struct omap_hwmod_ocp_if *omap3xxx_l4_wkup_slaves[] = {
 	&omap3xxx_l4_core__l4_wkup,
+	&omap3xxx_l4_wkup__gpio1,
 };
 
 /* Master interfaces on the L4_WKUP interconnect */
@@ -442,7 +563,6 @@ static struct omap_hwmod_class mmc_class = {
 	.sysc = &mmc_sysc,
 };
 
-
 /* MMC/SD/SDIO1 */
 
 static struct mmc_dev_attr mmc1_dev_attr = {
@@ -576,6 +696,235 @@ static struct omap_hwmod omap3xxx_mmc3_hwmod = {
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
 };
 
+/* GPIO common */
+static struct omap_gpio_dev_attr gpio_dev_attr = {
+	.gpio_bank_count = 6,
+	.gpio_bank_bits = 32,
+	.dbck_flag = true,
+	.fck_flag = false,
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
+	{ .name = "gpio_mpu_irq", .irq = INT_34XX_GPIO_BANK1 },
+};
+
+static struct omap_hwmod_opt_clk gpio1_opt_clks[] = {
+	{ .role = "gpio1_dbclk", .clk = "gpio1_dbck", },
+};
+
+static struct omap_hwmod_ocp_if *omap3xxx_gpio1_slaves[] = {
+	&omap3xxx_l4_wkup__gpio1,
+};
+
+static struct omap_hwmod omap3xxx_gpio1_hwmod = {
+	.name		= "gpio1_hwmod",
+	.mpu_irqs	= gpio1_mpu_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(gpio1_mpu_irqs),
+	.main_clk	= NULL,
+	.opt_clks	= gpio1_opt_clks,
+	.opt_clks_cnt	= ARRAY_SIZE(gpio1_opt_clks),
+	.prcm		= {
+		.omap2 = {
+			.prcm_reg_id = 1,
+			.module_bit = OMAP3430_EN_GPIO1_SHIFT,
+		},
+	},
+	.slaves		= omap3xxx_gpio1_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap3xxx_gpio1_slaves),
+	.class		= &gpio_class,
+	.dev_attr	= &gpio_dev_attr,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+};
+
+/* GPIO2 */
+
+static struct omap_hwmod_irq_info gpio2_mpu_irqs[] = {
+	{ .name = "gpio_mpu_irq", .irq = INT_34XX_GPIO_BANK2 },
+};
+
+static struct omap_hwmod_opt_clk gpio2_opt_clks[] = {
+	{ .role = "gpio2_dbclk", .clk = "gpio2_dbck", },
+};
+
+static struct omap_hwmod_ocp_if *omap3xxx_gpio2_slaves[] = {
+	&omap3xxx_l4_per__gpio2,
+};
+
+static struct omap_hwmod omap3xxx_gpio2_hwmod = {
+	.name		= "gpio2_hwmod",
+	.mpu_irqs	= gpio2_mpu_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(gpio2_mpu_irqs),
+	.main_clk	= NULL,
+	.opt_clks	= gpio2_opt_clks,
+	.opt_clks_cnt	= ARRAY_SIZE(gpio2_opt_clks),
+	.prcm		= {
+		.omap2 = {
+			.prcm_reg_id = 1,
+			.module_bit = OMAP3430_EN_GPIO2_SHIFT,
+		},
+	},
+	.slaves		= omap3xxx_gpio2_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap3xxx_gpio2_slaves),
+	.class		= &gpio_class,
+	.dev_attr	= &gpio_dev_attr,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+};
+
+/* GPIO3 */
+
+static struct omap_hwmod_irq_info gpio3_mpu_irqs[] = {
+	{ .name = "gpio_mpu_irq", .irq = INT_34XX_GPIO_BANK3 },
+};
+
+static struct omap_hwmod_opt_clk gpio3_opt_clks[] = {
+	{ .role = "gpio3_dbclk", .clk = "gpio3_dbck", },
+};
+
+static struct omap_hwmod_ocp_if *omap3xxx_gpio3_slaves[] = {
+	&omap3xxx_l4_per__gpio3,
+};
+
+static struct omap_hwmod omap3xxx_gpio3_hwmod = {
+	.name		= "gpio3_hwmod",
+	.mpu_irqs	= gpio3_mpu_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(gpio3_mpu_irqs),
+	.main_clk	= NULL,
+	.opt_clks	= gpio3_opt_clks,
+	.opt_clks_cnt	= ARRAY_SIZE(gpio3_opt_clks),
+	.prcm		= {
+		.omap2 = {
+			.prcm_reg_id = 1,
+			.module_bit = OMAP3430_EN_GPIO3_SHIFT,
+		},
+	},
+	.slaves		= omap3xxx_gpio3_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap3xxx_gpio3_slaves),
+	.class		= &gpio_class,
+	.dev_attr	= &gpio_dev_attr,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+};
+
+/* GPIO4 */
+
+static struct omap_hwmod_irq_info gpio4_mpu_irqs[] = {
+	{ .name = "gpio_mpu_irq", .irq = INT_34XX_GPIO_BANK4 },
+};
+
+static struct omap_hwmod_opt_clk gpio4_opt_clks[] = {
+	{ .role = "gpio4_dbclk", .clk = "gpio4_dbck", },
+};
+
+static struct omap_hwmod_ocp_if *omap3xxx_gpio4_slaves[] = {
+	&omap3xxx_l4_per__gpio4,
+};
+
+static struct omap_hwmod omap3xxx_gpio4_hwmod = {
+	.name		= "gpio4_hwmod",
+	.mpu_irqs	= gpio4_mpu_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(gpio4_mpu_irqs),
+	.main_clk	= NULL,
+	.opt_clks	= gpio4_opt_clks,
+	.opt_clks_cnt	= ARRAY_SIZE(gpio4_opt_clks),
+	.prcm		= {
+		.omap2 = {
+			.prcm_reg_id = 1,
+			.module_bit = OMAP3430_EN_GPIO4_SHIFT,
+		},
+	},
+	.slaves		= omap3xxx_gpio4_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap3xxx_gpio4_slaves),
+	.class		= &gpio_class,
+	.dev_attr	= &gpio_dev_attr,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+};
+
+
+/* GPIO5 */
+
+static struct omap_hwmod_irq_info gpio5_mpu_irqs[] = {
+	{ .name = "gpio_mpu_irq", .irq = INT_34XX_GPIO_BANK5 },
+};
+
+static struct omap_hwmod_opt_clk gpio5_opt_clks[] = {
+	{ .role = "gpio5_dbclk", .clk = "gpio5_dbck", },
+};
+
+static struct omap_hwmod_ocp_if *omap3xxx_gpio5_slaves[] = {
+	&omap3xxx_l4_per__gpio5,
+};
+
+static struct omap_hwmod omap3xxx_gpio5_hwmod = {
+	.name		= "gpio5_hwmod",
+	.mpu_irqs	= gpio5_mpu_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(gpio5_mpu_irqs),
+	.main_clk	= NULL,
+	.opt_clks	= gpio5_opt_clks,
+	.opt_clks_cnt	= ARRAY_SIZE(gpio5_opt_clks),
+	.prcm		= {
+		.omap2 = {
+			.prcm_reg_id = 1,
+			.module_bit = OMAP3430_EN_GPIO5_SHIFT,
+		},
+	},
+	.slaves		= omap3xxx_gpio5_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap3xxx_gpio5_slaves),
+	.class		= &gpio_class,
+	.dev_attr	= &gpio_dev_attr,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+};
+
+/* GPIO6 */
+
+static struct omap_hwmod_irq_info gpio6_mpu_irqs[] = {
+	{ .name = "gpio_mpu_irq", .irq = INT_34XX_GPIO_BANK6 },
+};
+
+static struct omap_hwmod_opt_clk gpio6_opt_clks[] = {
+	{ .role = "gpio6_dbclk", .clk = "gpio6_dbck", },
+};
+
+static struct omap_hwmod_ocp_if *omap3xxx_gpio6_slaves[] = {
+	&omap3xxx_l4_per__gpio6,
+};
+
+static struct omap_hwmod omap3xxx_gpio6_hwmod = {
+	.name		= "gpio6_hwmod",
+	.mpu_irqs	= gpio6_mpu_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(gpio6_mpu_irqs),
+	.main_clk	= NULL,
+	.opt_clks	= gpio6_opt_clks,
+	.opt_clks_cnt	= ARRAY_SIZE(gpio6_opt_clks),
+	.prcm		= {
+		.omap2 = {
+			.prcm_reg_id = 1,
+			.module_bit = OMAP3430_EN_GPIO6_SHIFT,
+		},
+	},
+	.slaves		= omap3xxx_gpio6_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap3xxx_gpio6_slaves),
+	.class		= &gpio_class,
+	.dev_attr	= &gpio_dev_attr,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+};
+
 static __initdata struct omap_hwmod *omap3xxx_hwmods[] = {
 	&omap3xxx_l3_hwmod,
 	&omap3xxx_l4_core_hwmod,
@@ -588,6 +937,12 @@ static __initdata struct omap_hwmod *omap3xxx_hwmods[] = {
 	&omap3xxx_mmc1_hwmod,
 	&omap3xxx_mmc2_hwmod,
 	&omap3xxx_mmc3_hwmod,
+	&omap3xxx_gpio1_hwmod,
+	&omap3xxx_gpio2_hwmod,
+	&omap3xxx_gpio3_hwmod,
+	&omap3xxx_gpio4_hwmod,
+	&omap3xxx_gpio5_hwmod,
+	&omap3xxx_gpio6_hwmod,
 	NULL,
 };
 
-- 
1.6.3.3


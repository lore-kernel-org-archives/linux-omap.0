From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: [PATCH v6 07/13] OMAP3: hwmod data: Add GPIO
Date: Sat, 18 Sep 2010 19:45:47 +0530
Message-ID: <1284819353-8512-8-git-send-email-charu@ti.com>
References: <1284819353-8512-1-git-send-email-charu@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:56367 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755465Ab0IROQR (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 18 Sep 2010 10:16:17 -0400
In-Reply-To: <1284819353-8512-1-git-send-email-charu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, paul@pwsan.com, b-cousson@ti.com, rnayak@ti.com, p-basak2@ti.com, "Varadarajan, Charulatha" <charu@ti.com>

Add GPIO hwmod data for OMAP3 chip

Signed-off-by: Charulatha V <charu@ti.com>
Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |  364 ++++++++++++++++++++++++++++
 1 files changed, 364 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index 5d8eb58..43ed2ab 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -17,6 +17,7 @@
 #include <mach/irqs.h>
 #include <plat/cpu.h>
 #include <plat/dma.h>
+#include <plat/gpio.h>
 
 #include "omap_hwmod_common_data.h"
 
@@ -36,6 +37,12 @@ static struct omap_hwmod omap3xxx_iva_hwmod;
 static struct omap_hwmod omap3xxx_l3_main_hwmod;
 static struct omap_hwmod omap3xxx_l4_core_hwmod;
 static struct omap_hwmod omap3xxx_l4_per_hwmod;
+static struct omap_hwmod omap3xxx_gpio1_hwmod;
+static struct omap_hwmod omap3xxx_gpio2_hwmod;
+static struct omap_hwmod omap3xxx_gpio3_hwmod;
+static struct omap_hwmod omap3xxx_gpio4_hwmod;
+static struct omap_hwmod omap3xxx_gpio5_hwmod;
+static struct omap_hwmod omap3xxx_gpio6_hwmod;
 
 /* L3 -> L4_CORE interface */
 static struct omap_hwmod_ocp_if omap3xxx_l3_main__l4_core = {
@@ -197,6 +204,357 @@ static struct omap_hwmod omap3xxx_iva_hwmod = {
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
 };
 
+/* l4_wkup -> gpio1 */
+static struct omap_hwmod_addr_space omap3xxx_gpio1_addrs[] = {
+	{
+		.pa_start	= 0x48310000,
+		.pa_end		= 0x483101ff,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+
+static struct omap_hwmod_ocp_if omap3xxx_l4_wkup__gpio1 = {
+	.master		= &omap3xxx_l4_wkup_hwmod,
+	.slave		= &omap3xxx_gpio1_hwmod,
+	.clk		= "gpio1_ick",
+	.addr		= omap3xxx_gpio1_addrs,
+	.addr_cnt	= ARRAY_SIZE(omap3xxx_gpio1_addrs),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* l4_per -> gpio2 */
+static struct omap_hwmod_addr_space omap3xxx_gpio2_addrs[] = {
+	{
+		.pa_start	= 0x49050000,
+		.pa_end		= 0x490501ff,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+
+static struct omap_hwmod_ocp_if omap3xxx_l4_per__gpio2 = {
+	.master		= &omap3xxx_l4_per_hwmod,
+	.slave		= &omap3xxx_gpio2_hwmod,
+	.clk		= "gpio2_ick",
+	.addr		= omap3xxx_gpio2_addrs,
+	.addr_cnt	= ARRAY_SIZE(omap3xxx_gpio2_addrs),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* l4_per -> gpio3 */
+static struct omap_hwmod_addr_space omap3xxx_gpio3_addrs[] = {
+	{
+		.pa_start	= 0x49052000,
+		.pa_end		= 0x490521ff,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+
+static struct omap_hwmod_ocp_if omap3xxx_l4_per__gpio3 = {
+	.master		= &omap3xxx_l4_per_hwmod,
+	.slave		= &omap3xxx_gpio3_hwmod,
+	.clk		= "gpio3_ick",
+	.addr		= omap3xxx_gpio3_addrs,
+	.addr_cnt	= ARRAY_SIZE(omap3xxx_gpio3_addrs),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* l4_per -> gpio4 */
+static struct omap_hwmod_addr_space omap3xxx_gpio4_addrs[] = {
+	{
+		.pa_start	= 0x49054000,
+		.pa_end		= 0x490541ff,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+
+static struct omap_hwmod_ocp_if omap3xxx_l4_per__gpio4 = {
+	.master		= &omap3xxx_l4_per_hwmod,
+	.slave		= &omap3xxx_gpio4_hwmod,
+	.clk		= "gpio4_ick",
+	.addr		= omap3xxx_gpio4_addrs,
+	.addr_cnt	= ARRAY_SIZE(omap3xxx_gpio4_addrs),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* l4_per -> gpio5 */
+static struct omap_hwmod_addr_space omap3xxx_gpio5_addrs[] = {
+	{
+		.pa_start	= 0x49056000,
+		.pa_end		= 0x490561ff,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+
+static struct omap_hwmod_ocp_if omap3xxx_l4_per__gpio5 = {
+	.master		= &omap3xxx_l4_per_hwmod,
+	.slave		= &omap3xxx_gpio5_hwmod,
+	.clk		= "gpio5_ick",
+	.addr		= omap3xxx_gpio5_addrs,
+	.addr_cnt	= ARRAY_SIZE(omap3xxx_gpio5_addrs),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* l4_per -> gpio6 */
+static struct omap_hwmod_addr_space omap3xxx_gpio6_addrs[] = {
+	{
+		.pa_start	= 0x49058000,
+		.pa_end		= 0x490581ff,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+
+static struct omap_hwmod_ocp_if omap3xxx_l4_per__gpio6 = {
+	.master		= &omap3xxx_l4_per_hwmod,
+	.slave		= &omap3xxx_gpio6_hwmod,
+	.clk		= "gpio6_ick",
+	.addr		= omap3xxx_gpio6_addrs,
+	.addr_cnt	= ARRAY_SIZE(omap3xxx_gpio6_addrs),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/*
+ * 'gpio' class
+ * general purpose io module
+ */
+
+static struct omap_hwmod_class_sysconfig omap3xxx_gpio_sysc = {
+	.rev_offs	= 0x0000,
+	.sysc_offs	= 0x0010,
+	.syss_offs	= 0x0014,
+	.sysc_flags	= (SYSC_HAS_ENAWAKEUP | SYSC_HAS_SIDLEMODE |
+			   SYSC_HAS_SOFTRESET | SYSC_HAS_AUTOIDLE),
+	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
+	.sysc_fields    = &omap_hwmod_sysc_type1,
+};
+
+static struct omap_hwmod_class omap3xxx_gpio_hwmod_class = {
+	.name = "gpio",
+	.sysc = &omap3xxx_gpio_sysc,
+	.rev = 1,
+};
+
+/* gpio_dev_attr*/
+static struct omap_gpio_dev_attr gpio_dev_attr = {
+	.bank_width = 32,
+	.dbck_flag = true,
+};
+
+/* gpio1 */
+static struct omap_hwmod_irq_info omap3xxx_gpio1_irqs[] = {
+	{ .name = "gpio_mpu_irq", .irq = INT_34XX_GPIO_BANK1 },
+};
+
+static struct omap_hwmod_opt_clk gpio1_opt_clks[] = {
+	{ .role = "dbclk", .clk = "gpio1_dbck", },
+};
+
+static struct omap_hwmod_ocp_if *omap3xxx_gpio1_slaves[] = {
+	&omap3xxx_l4_wkup__gpio1,
+};
+
+static struct omap_hwmod omap3xxx_gpio1_hwmod = {
+	.name		= "gpio1",
+	.mpu_irqs	= omap3xxx_gpio1_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap3xxx_gpio1_irqs),
+	.main_clk	= NULL,
+	.opt_clks	= gpio1_opt_clks,
+	.opt_clks_cnt	= ARRAY_SIZE(gpio1_opt_clks),
+	.prcm		= {
+		.omap2 = {
+			.prcm_reg_id = 1,
+			.module_bit = OMAP3430_EN_GPIO1_SHIFT,
+			.module_offs = WKUP_MOD,
+			.idlest_reg_id = 1,
+			.idlest_idle_bit = OMAP3430_EN_GPIO1_SHIFT,
+		},
+	},
+	.slaves		= omap3xxx_gpio1_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap3xxx_gpio1_slaves),
+	.class		= &omap3xxx_gpio_hwmod_class,
+	.dev_attr	= &gpio_dev_attr,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+};
+
+/* gpio2 */
+static struct omap_hwmod_irq_info omap3xxx_gpio2_irqs[] = {
+	{ .name = "gpio_mpu_irq", .irq = INT_34XX_GPIO_BANK2 },
+};
+
+static struct omap_hwmod_opt_clk gpio2_opt_clks[] = {
+	{ .role = "dbclk", .clk = "gpio2_dbck", },
+};
+
+static struct omap_hwmod_ocp_if *omap3xxx_gpio2_slaves[] = {
+	&omap3xxx_l4_per__gpio2,
+};
+
+static struct omap_hwmod omap3xxx_gpio2_hwmod = {
+	.name		= "gpio2",
+	.mpu_irqs	= omap3xxx_gpio2_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap3xxx_gpio2_irqs),
+	.main_clk	= NULL,
+	.opt_clks	= gpio2_opt_clks,
+	.opt_clks_cnt	= ARRAY_SIZE(gpio2_opt_clks),
+	.prcm		= {
+		.omap2 = {
+			.prcm_reg_id = 1,
+			.module_bit = OMAP3430_EN_GPIO2_SHIFT,
+			.module_offs = OMAP3430_PER_MOD,
+			.idlest_reg_id = 1,
+			.idlest_idle_bit = OMAP3430_EN_GPIO2_SHIFT,
+		},
+	},
+	.slaves		= omap3xxx_gpio2_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap3xxx_gpio2_slaves),
+	.class		= &omap3xxx_gpio_hwmod_class,
+	.dev_attr	= &gpio_dev_attr,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+};
+
+/* gpio3 */
+static struct omap_hwmod_irq_info omap3xxx_gpio3_irqs[] = {
+	{ .name = "gpio_mpu_irq", .irq = INT_34XX_GPIO_BANK3 },
+};
+
+static struct omap_hwmod_opt_clk gpio3_opt_clks[] = {
+	{ .role = "dbclk", .clk = "gpio3_dbck", },
+};
+
+static struct omap_hwmod_ocp_if *omap3xxx_gpio3_slaves[] = {
+	&omap3xxx_l4_per__gpio3,
+};
+
+static struct omap_hwmod omap3xxx_gpio3_hwmod = {
+	.name		= "gpio3",
+	.mpu_irqs	= omap3xxx_gpio3_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap3xxx_gpio3_irqs),
+	.main_clk	= NULL,
+	.opt_clks	= gpio3_opt_clks,
+	.opt_clks_cnt	= ARRAY_SIZE(gpio3_opt_clks),
+	.prcm		= {
+		.omap2 = {
+			.prcm_reg_id = 1,
+			.module_bit = OMAP3430_EN_GPIO3_SHIFT,
+			.module_offs = OMAP3430_PER_MOD,
+			.idlest_reg_id = 1,
+			.idlest_idle_bit = OMAP3430_EN_GPIO3_SHIFT,
+		},
+	},
+	.slaves		= omap3xxx_gpio3_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap3xxx_gpio3_slaves),
+	.class		= &omap3xxx_gpio_hwmod_class,
+	.dev_attr	= &gpio_dev_attr,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+};
+
+/* gpio4 */
+static struct omap_hwmod_irq_info omap3xxx_gpio4_irqs[] = {
+	{ .name = "gpio_mpu_irq", .irq = INT_34XX_GPIO_BANK4 },
+};
+
+static struct omap_hwmod_opt_clk gpio4_opt_clks[] = {
+	{ .role = "dbclk", .clk = "gpio4_dbck", },
+};
+
+static struct omap_hwmod_ocp_if *omap3xxx_gpio4_slaves[] = {
+	&omap3xxx_l4_per__gpio4,
+};
+
+static struct omap_hwmod omap3xxx_gpio4_hwmod = {
+	.name		= "gpio4",
+	.mpu_irqs	= omap3xxx_gpio4_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap3xxx_gpio4_irqs),
+	.main_clk	= NULL,
+	.opt_clks	= gpio4_opt_clks,
+	.opt_clks_cnt	= ARRAY_SIZE(gpio4_opt_clks),
+	.prcm		= {
+		.omap2 = {
+			.prcm_reg_id = 1,
+			.module_bit = OMAP3430_EN_GPIO4_SHIFT,
+			.module_offs = OMAP3430_PER_MOD,
+			.idlest_reg_id = 1,
+			.idlest_idle_bit = OMAP3430_EN_GPIO4_SHIFT,
+		},
+	},
+	.slaves		= omap3xxx_gpio4_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap3xxx_gpio4_slaves),
+	.class		= &omap3xxx_gpio_hwmod_class,
+	.dev_attr	= &gpio_dev_attr,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+};
+
+/* gpio5 */
+static struct omap_hwmod_irq_info omap3xxx_gpio5_irqs[] = {
+	{ .name = "gpio_mpu_irq", .irq = INT_34XX_GPIO_BANK5 },
+};
+
+static struct omap_hwmod_opt_clk gpio5_opt_clks[] = {
+	{ .role = "dbclk", .clk = "gpio5_dbck", },
+};
+
+static struct omap_hwmod_ocp_if *omap3xxx_gpio5_slaves[] = {
+	&omap3xxx_l4_per__gpio5,
+};
+
+static struct omap_hwmod omap3xxx_gpio5_hwmod = {
+	.name		= "gpio5",
+	.mpu_irqs	= omap3xxx_gpio5_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap3xxx_gpio5_irqs),
+	.main_clk	= NULL,
+	.opt_clks	= gpio5_opt_clks,
+	.opt_clks_cnt	= ARRAY_SIZE(gpio5_opt_clks),
+	.prcm		= {
+		.omap2 = {
+			.prcm_reg_id = 1,
+			.module_bit = OMAP3430_EN_GPIO5_SHIFT,
+			.module_offs = OMAP3430_PER_MOD,
+			.idlest_reg_id = 1,
+			.idlest_idle_bit = OMAP3430_EN_GPIO5_SHIFT,
+		},
+	},
+	.slaves		= omap3xxx_gpio5_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap3xxx_gpio5_slaves),
+	.class		= &omap3xxx_gpio_hwmod_class,
+	.dev_attr	= &gpio_dev_attr,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+};
+
+/* gpio6 */
+static struct omap_hwmod_irq_info omap3xxx_gpio6_irqs[] = {
+	{ .name = "gpio_mpu_irq", .irq = INT_34XX_GPIO_BANK6 },
+};
+
+static struct omap_hwmod_opt_clk gpio6_opt_clks[] = {
+	{ .role = "dbclk", .clk = "gpio6_dbck", },
+};
+
+static struct omap_hwmod_ocp_if *omap3xxx_gpio6_slaves[] = {
+	&omap3xxx_l4_per__gpio6,
+};
+
+static struct omap_hwmod omap3xxx_gpio6_hwmod = {
+	.name		= "gpio6",
+	.mpu_irqs	= omap3xxx_gpio6_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap3xxx_gpio6_irqs),
+	.main_clk	= NULL,
+	.opt_clks	= gpio6_opt_clks,
+	.opt_clks_cnt	= ARRAY_SIZE(gpio6_opt_clks),
+	.prcm		= {
+		.omap2 = {
+			.prcm_reg_id = 1,
+			.module_bit = OMAP3430_EN_GPIO6_SHIFT,
+			.module_offs = OMAP3430_PER_MOD,
+			.idlest_reg_id = 1,
+			.idlest_idle_bit = OMAP3430_EN_GPIO6_SHIFT,
+		},
+	},
+	.slaves		= omap3xxx_gpio6_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap3xxx_gpio6_slaves),
+	.class		= &omap3xxx_gpio_hwmod_class,
+	.dev_attr	= &gpio_dev_attr,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+};
+
 static __initdata struct omap_hwmod *omap3xxx_hwmods[] = {
 	&omap3xxx_l3_main_hwmod,
 	&omap3xxx_l4_core_hwmod,
@@ -204,6 +562,12 @@ static __initdata struct omap_hwmod *omap3xxx_hwmods[] = {
 	&omap3xxx_l4_wkup_hwmod,
 	&omap3xxx_mpu_hwmod,
 	&omap3xxx_iva_hwmod,
+	&omap3xxx_gpio1_hwmod,
+	&omap3xxx_gpio2_hwmod,
+	&omap3xxx_gpio3_hwmod,
+	&omap3xxx_gpio4_hwmod,
+	&omap3xxx_gpio5_hwmod,
+	&omap3xxx_gpio6_hwmod,
 	NULL,
 };
 
-- 
1.7.0.4


From: Charulatha V <charu@ti.com>
Subject: [PATCH 07/13 v5] OMAP: GPIO: add GPIO hwmods structures for OMAP243X
Date: Fri,  6 Aug 2010 18:04:19 +0530
Message-ID: <1281098065-24177-8-git-send-email-charu@ti.com>
References: <1281098065-24177-1-git-send-email-charu@ti.com>
 <1281098065-24177-2-git-send-email-charu@ti.com>
 <1281098065-24177-3-git-send-email-charu@ti.com>
 <1281098065-24177-4-git-send-email-charu@ti.com>
 <1281098065-24177-5-git-send-email-charu@ti.com>
 <1281098065-24177-6-git-send-email-charu@ti.com>
 <1281098065-24177-7-git-send-email-charu@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:52298 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932824Ab0HFMbp (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 6 Aug 2010 08:31:45 -0400
In-Reply-To: <1281098065-24177-7-git-send-email-charu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: paul@pwsan.com, khilman@deeprootsystems.com, b-cousson@ti.com, rnayak@ti.com, Charulatha V <charu@ti.com>, "Basak, Partha" <p-basak2@ti.com>

Add hwmod structures for GPIO module on OMAP243X

Signed-off-by: Charulatha V <charu@ti.com>
Signed-off-by: Basak, Partha <p-basak2@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_2430_data.c |  290 ++++++++++++++++++++++++++++
 1 files changed, 290 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_2430_data.c b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
index 4526628..d3582e1 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2430_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
@@ -15,6 +15,7 @@
 #include <mach/irqs.h>
 #include <plat/cpu.h>
 #include <plat/dma.h>
+#include <plat/gpio.h>
 
 #include "omap_hwmod_common_data.h"
 
@@ -33,6 +34,11 @@ static struct omap_hwmod omap2430_mpu_hwmod;
 static struct omap_hwmod omap2430_iva_hwmod;
 static struct omap_hwmod omap2430_l3_main_hwmod;
 static struct omap_hwmod omap2430_l4_core_hwmod;
+static struct omap_hwmod omap2430_gpio1_hwmod;
+static struct omap_hwmod omap2430_gpio2_hwmod;
+static struct omap_hwmod omap2430_gpio3_hwmod;
+static struct omap_hwmod omap2430_gpio4_hwmod;
+static struct omap_hwmod omap2430_gpio5_hwmod;
 
 /* L3 -> L4_CORE interface */
 static struct omap_hwmod_ocp_if omap2430_l3_main__l4_core = {
@@ -165,12 +171,296 @@ static struct omap_hwmod omap2430_iva_hwmod = {
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2430)
 };
 
+/* L4 WKUP -> GPIO1 interface */
+
+static struct omap_hwmod_addr_space omap2430_gpio1_addr_space[] = {
+	{
+		.pa_start	= 0x4900C000,
+		.pa_end		= 0x4900C1ff,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+
+static struct omap_hwmod_ocp_if omap2430_l4_wkup__gpio1 = {
+	.master		= &omap2430_l4_wkup_hwmod,
+	.slave		= &omap2430_gpio1_hwmod,
+	.clk		= "gpios_ick",
+	.addr		= omap2430_gpio1_addr_space,
+	.addr_cnt	= ARRAY_SIZE(omap2430_gpio1_addr_space),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* L4 WKUP -> GPIO2 interface */
+
+static struct omap_hwmod_addr_space omap2430_gpio2_addr_space[] = {
+	{
+		.pa_start	= 0x4900E000,
+		.pa_end		= 0x4900E1ff,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+
+static struct omap_hwmod_ocp_if omap2430_l4_wkup__gpio2 = {
+	.master		= &omap2430_l4_wkup_hwmod,
+	.slave		= &omap2430_gpio2_hwmod,
+	.clk		= "gpios_ick",
+	.addr		= omap2430_gpio2_addr_space,
+	.addr_cnt	= ARRAY_SIZE(omap2430_gpio2_addr_space),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* L4 WKUP -> GPIO3 interface */
+
+static struct omap_hwmod_addr_space omap2430_gpio3_addr_space[] = {
+	{
+		.pa_start	= 0x49010000,
+		.pa_end		= 0x490101ff,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+
+static struct omap_hwmod_ocp_if omap2430_l4_wkup__gpio3 = {
+	.master		= &omap2430_l4_wkup_hwmod,
+	.slave		= &omap2430_gpio3_hwmod,
+	.clk		= "gpios_ick",
+	.addr		= omap2430_gpio3_addr_space,
+	.addr_cnt	= ARRAY_SIZE(omap2430_gpio3_addr_space),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* L4 WKUP -> GPIO4 interface */
+
+static struct omap_hwmod_addr_space omap2430_gpio4_addr_space[] = {
+	{
+		.pa_start	= 0x49012000,
+		.pa_end		= 0x490121ff,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+
+static struct omap_hwmod_ocp_if omap2430_l4_wkup__gpio4 = {
+	.master		= &omap2430_l4_wkup_hwmod,
+	.slave		= &omap2430_gpio4_hwmod,
+	.clk		= "gpios_ick",
+	.addr		= omap2430_gpio4_addr_space,
+	.addr_cnt	= ARRAY_SIZE(omap2430_gpio4_addr_space),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* L4 CORE -> GPIO5 interface */
+
+static struct omap_hwmod_addr_space omap2430_gpio5_addr_space[] = {
+	{
+		.pa_start	= 0x480B6000,
+		.pa_end		= 0x480B61ff,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+
+static struct omap_hwmod_ocp_if omap2430_l4_core__gpio5 = {
+	.master		= &omap2430_l4_core_hwmod,
+	.slave		= &omap2430_gpio5_hwmod,
+	.clk		= "gpio5_ick",
+	.addr		= omap2430_gpio5_addr_space,
+	.addr_cnt	= ARRAY_SIZE(omap2430_gpio5_addr_space),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* GPIO common */
+
+static struct omap_gpio_dev_attr gpio_dev_attr = {
+	.bank_width = 32,
+	.dbck_flag = false,
+	/*
+	 * off_mode is supported by GPIO, but it is not
+	 * supported by software due to leakage current problem.
+	 * Hence making off_mode_support flag as false
+	 */
+	.off_mode_support = false,
+};
+
+static struct omap_hwmod_class_sysconfig omap243x_gpio_sysc = {
+	.rev_offs	= 0x0000,
+	.sysc_offs	= 0x0010,
+	.syss_offs	= 0x0014,
+	.sysc_flags	= (SYSC_HAS_ENAWAKEUP | SYSC_HAS_SIDLEMODE |
+			   SYSC_HAS_SOFTRESET | SYSC_HAS_AUTOIDLE),
+	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
+	.sysc_fields    = &omap_hwmod_sysc_type1,
+};
+
+static struct omap_hwmod_class omap243x_gpio_hwmod_class = {
+	.name = "gpio",
+	.sysc = &omap243x_gpio_sysc,
+	.rev = 0,
+};
+
+/* GPIO1 */
+
+static struct omap_hwmod_irq_info omap243x_gpio1_irqs[] = {
+	{ .name = "gpio_mpu_irq", .irq = INT_24XX_GPIO_BANK1 },
+};
+
+static struct omap_hwmod_ocp_if *omap2430_gpio1_slaves[] = {
+	&omap2430_l4_wkup__gpio1,
+};
+
+static struct omap_hwmod omap2430_gpio1_hwmod = {
+	.name		= "gpio1",
+	.mpu_irqs	= omap243x_gpio1_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap243x_gpio1_irqs),
+	.main_clk	= "gpios_fck",
+	.prcm		= {
+		.omap2 = {
+			.prcm_reg_id = 1,
+			.module_bit = OMAP24XX_EN_GPIOS_SHIFT,
+			.module_offs = WKUP_MOD,
+			.idlest_reg_id = 1,
+			.idlest_idle_bit = OMAP24XX_EN_GPIOS_SHIFT,
+		},
+	},
+	.slaves		= omap2430_gpio1_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap2430_gpio1_slaves),
+	.class		= &omap243x_gpio_hwmod_class,
+	.dev_attr	= &gpio_dev_attr,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2430),
+};
+
+/* GPIO2 */
+
+static struct omap_hwmod_irq_info omap243x_gpio2_irqs[] = {
+	{ .name = "gpio_mpu_irq", .irq = INT_24XX_GPIO_BANK2 },
+};
+
+static struct omap_hwmod_ocp_if *omap2430_gpio2_slaves[] = {
+	&omap2430_l4_wkup__gpio2,
+};
+
+static struct omap_hwmod omap2430_gpio2_hwmod = {
+	.name		= "gpio2",
+	.mpu_irqs	= omap243x_gpio2_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap243x_gpio2_irqs),
+	.main_clk	= "gpios_fck",
+	.prcm		= {
+		.omap2 = {
+			.prcm_reg_id = 1,
+			.module_bit = OMAP24XX_EN_GPIOS_SHIFT,
+			.module_offs = WKUP_MOD,
+			.idlest_reg_id = 1,
+			.idlest_idle_bit = OMAP24XX_EN_GPIOS_SHIFT,
+		},
+	},
+	.slaves		= omap2430_gpio2_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap2430_gpio2_slaves),
+	.class		= &omap243x_gpio_hwmod_class,
+	.dev_attr	= &gpio_dev_attr,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2430),
+};
+
+/* GPIO3 */
+
+static struct omap_hwmod_irq_info omap243x_gpio3_irqs[] = {
+	{ .name = "gpio_mpu_irq", .irq = INT_24XX_GPIO_BANK3 },
+};
+
+static struct omap_hwmod_ocp_if *omap2430_gpio3_slaves[] = {
+	&omap2430_l4_wkup__gpio3,
+};
+
+static struct omap_hwmod omap2430_gpio3_hwmod = {
+	.name		= "gpio3",
+	.mpu_irqs	= omap243x_gpio3_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap243x_gpio3_irqs),
+	.main_clk	= "gpios_fck",
+	.prcm		= {
+		.omap2 = {
+			.prcm_reg_id = 1,
+			.module_bit = OMAP24XX_EN_GPIOS_SHIFT,
+			.module_offs = WKUP_MOD,
+			.idlest_reg_id = 1,
+			.idlest_idle_bit = OMAP24XX_EN_GPIOS_SHIFT,
+		},
+	},
+	.slaves		= omap2430_gpio3_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap2430_gpio3_slaves),
+	.class		= &omap243x_gpio_hwmod_class,
+	.dev_attr	= &gpio_dev_attr,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2430),
+};
+
+/* GPIO4 */
+
+static struct omap_hwmod_irq_info omap243x_gpio4_irqs[] = {
+	{ .name = "gpio_mpu_irq", .irq = INT_24XX_GPIO_BANK4 },
+};
+
+static struct omap_hwmod_ocp_if *omap2430_gpio4_slaves[] = {
+	&omap2430_l4_wkup__gpio4,
+};
+
+static struct omap_hwmod omap2430_gpio4_hwmod = {
+	.name		= "gpio4",
+	.mpu_irqs	= omap243x_gpio4_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap243x_gpio4_irqs),
+	.main_clk	= "gpios_fck",
+	.prcm		= {
+		.omap2 = {
+			.prcm_reg_id = 1,
+			.module_bit = OMAP24XX_EN_GPIOS_SHIFT,
+			.module_offs = WKUP_MOD,
+			.idlest_reg_id = 1,
+			.idlest_idle_bit = OMAP24XX_EN_GPIOS_SHIFT,
+		},
+	},
+	.slaves		= omap2430_gpio4_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap2430_gpio4_slaves),
+	.class		= &omap243x_gpio_hwmod_class,
+	.dev_attr	= &gpio_dev_attr,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2430),
+};
+
+/* GPIO5 */
+
+static struct omap_hwmod_irq_info omap243x_gpio5_irqs[] = {
+	{ .name = "gpio_mpu_irq", .irq = INT_24XX_GPIO_BANK5 },
+};
+
+static struct omap_hwmod_ocp_if *omap2430_gpio5_slaves[] = {
+	&omap2430_l4_core__gpio5,
+};
+
+static struct omap_hwmod omap2430_gpio5_hwmod = {
+	.name		= "gpio5",
+	.mpu_irqs	= omap243x_gpio5_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap243x_gpio5_irqs),
+	.main_clk	= "gpio5_fck",
+	.prcm		= {
+		.omap2 = {
+			.prcm_reg_id = 1,
+			.module_bit = OMAP2430_ST_GPIO5_SHIFT,
+			.module_offs = CORE_MOD,
+			.idlest_reg_id = 1,
+			.idlest_idle_bit = OMAP2430_ST_GPIO5_SHIFT,
+		},
+	},
+	.slaves		= omap2430_gpio5_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap2430_gpio5_slaves),
+	.class		= &omap243x_gpio_hwmod_class,
+	.dev_attr	= &gpio_dev_attr,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2430),
+};
+
 static __initdata struct omap_hwmod *omap2430_hwmods[] = {
 	&omap2430_l3_main_hwmod,
 	&omap2430_l4_core_hwmod,
 	&omap2430_l4_wkup_hwmod,
 	&omap2430_mpu_hwmod,
 	&omap2430_iva_hwmod,
+	&omap2430_gpio1_hwmod,
+	&omap2430_gpio2_hwmod,
+	&omap2430_gpio3_hwmod,
+	&omap2430_gpio4_hwmod,
+	&omap2430_gpio5_hwmod,
 	NULL,
 };
 
-- 
1.6.3.3


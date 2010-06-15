From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: [PATCH 08/13 v3] OMAP: GPIO: add GPIO hwmods structures for OMAP242X
Date: Tue, 15 Jun 2010 20:35:43 +0530
Message-ID: <1276614348-5201-9-git-send-email-charu@ti.com>
References: <1276614348-5201-1-git-send-email-charu@ti.com>
 <1276614348-5201-2-git-send-email-charu@ti.com>
 <1276614348-5201-3-git-send-email-charu@ti.com>
 <1276614348-5201-4-git-send-email-charu@ti.com>
 <1276614348-5201-5-git-send-email-charu@ti.com>
 <1276614348-5201-6-git-send-email-charu@ti.com>
 <1276614348-5201-7-git-send-email-charu@ti.com>
 <1276614348-5201-8-git-send-email-charu@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:51013 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758025Ab0FOPC1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 15 Jun 2010 11:02:27 -0400
In-Reply-To: <1276614348-5201-8-git-send-email-charu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: david-b@pacbell.net, broonie@opensource.wolfsonmicro.com, akpm@linux-foundation.org, linux-omap@vger.kernel.org
Cc: paul@pwsan.com, rnayak@ti.com, b-cousson@ti.com, khilman@deeprootsystems.com, tony@atomide.com, Charulatha V <charu@ti.com>

From: Charulatha V <charu@ti.com>

Add hwmod structures for GPIO module on OMAP242X

Signed-off-by: Charulatha V <charu@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_2420_data.c |  228 ++++++++++++++++++++++++++++
 1 files changed, 228 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_2420_data.c b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
index a8b57a6..8742707 100644
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
@@ -88,6 +93,78 @@ static struct omap_hwmod_ocp_if *omap2420_l4_core_masters[] = {
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
@@ -136,11 +213,162 @@ static struct omap_hwmod omap2420_mpu_hwmod = {
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2420),
 };
 
+/* GPIO common */
+
+static struct omap_gpio_dev_attr gpio_dev_attr = {
+	.gpio_bank_count = 4,
+	.gpio_bank_bits = 32,
+	.dbck_flag = false,
+};
+
+static struct omap_hwmod_class_sysconfig omap242x_gpio_sysc = {
+	.rev_offs	= 0x0000,
+	.sysc_offs	= 0x0010,
+	.syss_offs	= 0x0014,
+	.sysc_flags	= (SYSC_HAS_ENAWAKEUP | SYSC_HAS_SIDLEMODE |
+			   SYSC_HAS_SOFTRESET | SYSC_HAS_AUTOIDLE),
+	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
+	.sysc_fields    = &omap_hwmod_sysc_type1,
+};
+
+static struct omap_hwmod_class omap242x_gpio_hwmod_class = {
+	.name = "gpio",
+	.sysc = &omap242x_gpio_sysc,
+};
+
+/* GPIO1 */
+
+static struct omap_hwmod_irq_info omap242x_gpio1_irqs[] = {
+	{ .name = "gpio_mpu_irq", .irq = INT_24XX_GPIO_BANK1 },
+};
+
+static struct omap_hwmod_ocp_if *omap2420_gpio1_slaves[] = {
+	&omap2420_l4_wkup__gpio1,
+};
+
+static struct omap_hwmod omap2420_gpio1_hwmod = {
+	.name		= "gpio1",
+	.mpu_irqs	= omap242x_gpio1_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap242x_gpio1_irqs),
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
+	.slaves		= omap2420_gpio1_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap2420_gpio1_slaves),
+	.class		= &omap242x_gpio_hwmod_class,
+	.dev_attr	= &gpio_dev_attr,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2420),
+};
+
+/* GPIO2 */
+
+static struct omap_hwmod_irq_info omap242x_gpio2_irqs[] = {
+	{ .name = "gpio_mpu_irq", .irq = INT_24XX_GPIO_BANK2 },
+};
+
+static struct omap_hwmod_ocp_if *omap2420_gpio2_slaves[] = {
+	&omap2420_l4_wkup__gpio2,
+};
+
+static struct omap_hwmod omap2420_gpio2_hwmod = {
+	.name		= "gpio2",
+	.mpu_irqs	= omap242x_gpio2_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap242x_gpio2_irqs),
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
+	.slaves		= omap2420_gpio2_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap2420_gpio2_slaves),
+	.class		= &omap242x_gpio_hwmod_class,
+	.dev_attr	= &gpio_dev_attr,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2420),
+};
+
+/* GPIO3 */
+
+static struct omap_hwmod_irq_info omap242x_gpio3_irqs[] = {
+	{ .name = "gpio_mpu_irq", .irq = INT_24XX_GPIO_BANK3 },
+};
+
+static struct omap_hwmod_ocp_if *omap2420_gpio3_slaves[] = {
+	&omap2420_l4_wkup__gpio3,
+};
+
+static struct omap_hwmod omap2420_gpio3_hwmod = {
+	.name		= "gpio3",
+	.mpu_irqs	= omap242x_gpio3_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap242x_gpio3_irqs),
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
+	.slaves		= omap2420_gpio3_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap2420_gpio3_slaves),
+	.class		= &omap242x_gpio_hwmod_class,
+	.dev_attr	= &gpio_dev_attr,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2420),
+};
+
+/* GPIO4 */
+
+static struct omap_hwmod_irq_info omap242x_gpio4_irqs[] = {
+	{ .name = "gpio_mpu_irq", .irq = INT_24XX_GPIO_BANK4 },
+};
+
+static struct omap_hwmod_ocp_if *omap2420_gpio4_slaves[] = {
+	&omap2420_l4_wkup__gpio4,
+};
+
+static struct omap_hwmod omap2420_gpio4_hwmod = {
+	.name		= "gpio4",
+	.mpu_irqs	= omap242x_gpio4_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap242x_gpio4_irqs),
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
+	.slaves		= omap2420_gpio4_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap2420_gpio4_slaves),
+	.class		= &omap242x_gpio_hwmod_class,
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


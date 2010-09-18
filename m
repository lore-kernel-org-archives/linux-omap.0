From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: [PATCH v6 08/13] OMAP4: hwmod data: Add GPIO
Date: Sat, 18 Sep 2010 19:45:48 +0530
Message-ID: <1284819353-8512-9-git-send-email-charu@ti.com>
References: <1284819353-8512-1-git-send-email-charu@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:56368 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755467Ab0IROQR (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 18 Sep 2010 10:16:17 -0400
In-Reply-To: <1284819353-8512-1-git-send-email-charu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, paul@pwsan.com, b-cousson@ti.com, rnayak@ti.com, p-basak2@ti.com, Charulatha V <charu@ti.com>

From: Benoit Cousson <b-cousson@ti.com>

Add GPIO hwmod data for OMAP4 chip

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Signed-off-by: Charulatha V <charu@ti.com>
---
This patch is extracted from the below patch sent by Benoit
OMAP4: hwmod: Add partial hwmod support for OMAP4430 ES1.0
https://patchwork.kernel.org/patch/99052/

 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |  341 ++++++++++++++++++++++++++++
 1 files changed, 341 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index e20b0ee..a21ef9b 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -22,6 +22,7 @@
 
 #include <plat/omap_hwmod.h>
 #include <plat/cpu.h>
+#include <plat/gpio.h>
 
 #include "omap_hwmod_common_data.h"
 
@@ -452,6 +453,339 @@ static struct omap_hwmod omap44xx_mpu_hwmod = {
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
 
+/* gpio dev_attr*/
+static struct omap_gpio_dev_attr gpio_dev_attr = {
+	.bank_width = 32,
+	.dbck_flag = true,
+};
+
+/*
+ * 'gpio' class
+ * general purpose io module
+ */
+
+static struct omap_hwmod_class_sysconfig omap44xx_gpio_sysc = {
+	.rev_offs	= 0x0000,
+	.sysc_offs	= 0x0010,
+	.syss_offs	= 0x0114,
+	.sysc_flags	= (SYSC_HAS_ENAWAKEUP | SYSC_HAS_SIDLEMODE |
+			   SYSC_HAS_SOFTRESET | SYSC_HAS_AUTOIDLE),
+	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
+	.sysc_fields	= &omap_hwmod_sysc_type1,
+};
+
+static struct omap_hwmod_class omap44xx_gpio_hwmod_class = {
+	.name = "gpio",
+	.sysc = &omap44xx_gpio_sysc,
+	.rev = 2,
+};
+
+/* gpio1 */
+static struct omap_hwmod omap44xx_gpio1_hwmod;
+static struct omap_hwmod_irq_info omap44xx_gpio1_irqs[] = {
+	{ .irq = 29 + OMAP44XX_IRQ_GIC_START },
+};
+
+static struct omap_hwmod_addr_space omap44xx_gpio1_addrs[] = {
+	{
+		.pa_start	= 0x4a310000,
+		.pa_end		= 0x4a3101ff,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+
+/* l4_wkup -> gpio1 */
+static struct omap_hwmod_ocp_if omap44xx_l4_wkup__gpio1 = {
+	.master		= &omap44xx_l4_wkup_hwmod,
+	.slave		= &omap44xx_gpio1_hwmod,
+	.clk		= "gpio1_ick",
+	.addr		= omap44xx_gpio1_addrs,
+	.addr_cnt	= ARRAY_SIZE(omap44xx_gpio1_addrs),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* gpio1 slave ports */
+static struct omap_hwmod_ocp_if *omap44xx_gpio1_slaves[] = {
+	&omap44xx_l4_wkup__gpio1,
+};
+
+static struct omap_hwmod_opt_clk gpio1_opt_clks[] = {
+	{ .role = "dbclk", .clk = "sys_32k_ck" },
+};
+
+static struct omap_hwmod omap44xx_gpio1_hwmod = {
+	.name		= "gpio1",
+	.class		= &omap44xx_gpio_hwmod_class,
+	.mpu_irqs	= omap44xx_gpio1_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_gpio1_irqs),
+	.prcm = {
+		.omap4 = {
+			.clkctrl_reg = OMAP4430_CM_WKUP_GPIO1_CLKCTRL,
+		},
+	},
+	.opt_clks	= gpio1_opt_clks,
+	.opt_clks_cnt = ARRAY_SIZE(gpio1_opt_clks),
+	.dev_attr	= &gpio_dev_attr,
+	.slaves		= omap44xx_gpio1_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap44xx_gpio1_slaves),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+};
+
+/* gpio2 */
+static struct omap_hwmod omap44xx_gpio2_hwmod;
+static struct omap_hwmod_irq_info omap44xx_gpio2_irqs[] = {
+	{ .irq = 30 + OMAP44XX_IRQ_GIC_START },
+};
+
+static struct omap_hwmod_addr_space omap44xx_gpio2_addrs[] = {
+	{
+		.pa_start	= 0x48055000,
+		.pa_end		= 0x480551ff,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+
+/* l4_per -> gpio2 */
+static struct omap_hwmod_ocp_if omap44xx_l4_per__gpio2 = {
+	.master		= &omap44xx_l4_per_hwmod,
+	.slave		= &omap44xx_gpio2_hwmod,
+	.clk		= "gpio2_ick",
+	.addr		= omap44xx_gpio2_addrs,
+	.addr_cnt	= ARRAY_SIZE(omap44xx_gpio2_addrs),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* gpio2 slave ports */
+static struct omap_hwmod_ocp_if *omap44xx_gpio2_slaves[] = {
+	&omap44xx_l4_per__gpio2,
+};
+
+static struct omap_hwmod_opt_clk gpio2_opt_clks[] = {
+	{ .role = "dbclk", .clk = "sys_32k_ck" },
+};
+
+static struct omap_hwmod omap44xx_gpio2_hwmod = {
+	.name		= "gpio2",
+	.class		= &omap44xx_gpio_hwmod_class,
+	.mpu_irqs	= omap44xx_gpio2_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_gpio2_irqs),
+	.prcm = {
+		.omap4 = {
+			.clkctrl_reg = OMAP4430_CM_L4PER_GPIO2_CLKCTRL,
+		},
+	},
+	.opt_clks	= gpio2_opt_clks,
+	.opt_clks_cnt = ARRAY_SIZE(gpio2_opt_clks),
+	.dev_attr	= &gpio_dev_attr,
+	.slaves		= omap44xx_gpio2_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap44xx_gpio2_slaves),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+};
+
+/* gpio3 */
+static struct omap_hwmod omap44xx_gpio3_hwmod;
+static struct omap_hwmod_irq_info omap44xx_gpio3_irqs[] = {
+	{ .irq = 31 + OMAP44XX_IRQ_GIC_START },
+};
+
+static struct omap_hwmod_addr_space omap44xx_gpio3_addrs[] = {
+	{
+		.pa_start	= 0x48057000,
+		.pa_end		= 0x480571ff,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+
+/* l4_per -> gpio3 */
+static struct omap_hwmod_ocp_if omap44xx_l4_per__gpio3 = {
+	.master		= &omap44xx_l4_per_hwmod,
+	.slave		= &omap44xx_gpio3_hwmod,
+	.clk		= "gpio3_ick",
+	.addr		= omap44xx_gpio3_addrs,
+	.addr_cnt	= ARRAY_SIZE(omap44xx_gpio3_addrs),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* gpio3 slave ports */
+static struct omap_hwmod_ocp_if *omap44xx_gpio3_slaves[] = {
+	&omap44xx_l4_per__gpio3,
+};
+
+static struct omap_hwmod_opt_clk gpio3_opt_clks[] = {
+	{ .role = "dbclk", .clk = "sys_32k_ck" },
+};
+
+static struct omap_hwmod omap44xx_gpio3_hwmod = {
+	.name		= "gpio3",
+	.class		= &omap44xx_gpio_hwmod_class,
+	.mpu_irqs	= omap44xx_gpio3_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_gpio3_irqs),
+	.prcm = {
+		.omap4 = {
+			.clkctrl_reg = OMAP4430_CM_L4PER_GPIO3_CLKCTRL,
+		},
+	},
+	.opt_clks	= gpio3_opt_clks,
+	.opt_clks_cnt = ARRAY_SIZE(gpio3_opt_clks),
+	.dev_attr	= &gpio_dev_attr,
+	.slaves		= omap44xx_gpio3_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap44xx_gpio3_slaves),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+};
+
+/* gpio4 */
+static struct omap_hwmod omap44xx_gpio4_hwmod;
+static struct omap_hwmod_irq_info omap44xx_gpio4_irqs[] = {
+	{ .irq = 32 + OMAP44XX_IRQ_GIC_START },
+};
+
+static struct omap_hwmod_addr_space omap44xx_gpio4_addrs[] = {
+	{
+		.pa_start	= 0x48059000,
+		.pa_end		= 0x480591ff,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+
+/* l4_per -> gpio4 */
+static struct omap_hwmod_ocp_if omap44xx_l4_per__gpio4 = {
+	.master		= &omap44xx_l4_per_hwmod,
+	.slave		= &omap44xx_gpio4_hwmod,
+	.clk		= "gpio4_ick",
+	.addr		= omap44xx_gpio4_addrs,
+	.addr_cnt	= ARRAY_SIZE(omap44xx_gpio4_addrs),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* gpio4 slave ports */
+static struct omap_hwmod_ocp_if *omap44xx_gpio4_slaves[] = {
+	&omap44xx_l4_per__gpio4,
+};
+
+static struct omap_hwmod_opt_clk gpio4_opt_clks[] = {
+	{ .role = "dbclk", .clk = "sys_32k_ck" },
+};
+
+static struct omap_hwmod omap44xx_gpio4_hwmod = {
+	.name		= "gpio4",
+	.class		= &omap44xx_gpio_hwmod_class,
+	.mpu_irqs	= omap44xx_gpio4_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_gpio4_irqs),
+	.prcm = {
+		.omap4 = {
+			.clkctrl_reg = OMAP4430_CM_L4PER_GPIO4_CLKCTRL,
+		},
+	},
+	.opt_clks	= gpio4_opt_clks,
+	.opt_clks_cnt = ARRAY_SIZE(gpio4_opt_clks),
+	.dev_attr	= &gpio_dev_attr,
+	.slaves		= omap44xx_gpio4_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap44xx_gpio4_slaves),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+};
+
+/* gpio5 */
+static struct omap_hwmod omap44xx_gpio5_hwmod;
+static struct omap_hwmod_irq_info omap44xx_gpio5_irqs[] = {
+	{ .irq = 33 + OMAP44XX_IRQ_GIC_START },
+};
+
+static struct omap_hwmod_addr_space omap44xx_gpio5_addrs[] = {
+	{
+		.pa_start	= 0x4805b000,
+		.pa_end		= 0x4805b1ff,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+
+/* l4_per -> gpio5 */
+static struct omap_hwmod_ocp_if omap44xx_l4_per__gpio5 = {
+	.master		= &omap44xx_l4_per_hwmod,
+	.slave		= &omap44xx_gpio5_hwmod,
+	.clk		= "gpio5_ick",
+	.addr		= omap44xx_gpio5_addrs,
+	.addr_cnt	= ARRAY_SIZE(omap44xx_gpio5_addrs),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* gpio5 slave ports */
+static struct omap_hwmod_ocp_if *omap44xx_gpio5_slaves[] = {
+	&omap44xx_l4_per__gpio5,
+};
+
+static struct omap_hwmod_opt_clk gpio5_opt_clks[] = {
+	{ .role = "dbclk", .clk = "sys_32k_ck" },
+};
+
+static struct omap_hwmod omap44xx_gpio5_hwmod = {
+	.name		= "gpio5",
+	.class		= &omap44xx_gpio_hwmod_class,
+	.mpu_irqs	= omap44xx_gpio5_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_gpio5_irqs),
+	.prcm = {
+		.omap4 = {
+			.clkctrl_reg = OMAP4430_CM_L4PER_GPIO5_CLKCTRL,
+		},
+	},
+	.opt_clks	= gpio5_opt_clks,
+	.opt_clks_cnt = ARRAY_SIZE(gpio5_opt_clks),
+	.dev_attr	= &gpio_dev_attr,
+	.slaves		= omap44xx_gpio5_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap44xx_gpio5_slaves),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+};
+
+/* gpio6 */
+static struct omap_hwmod omap44xx_gpio6_hwmod;
+static struct omap_hwmod_irq_info omap44xx_gpio6_irqs[] = {
+	{ .irq = 34 + OMAP44XX_IRQ_GIC_START },
+};
+
+static struct omap_hwmod_addr_space omap44xx_gpio6_addrs[] = {
+	{
+		.pa_start	= 0x4805d000,
+		.pa_end		= 0x4805d1ff,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+
+/* l4_per -> gpio6 */
+static struct omap_hwmod_ocp_if omap44xx_l4_per__gpio6 = {
+	.master		= &omap44xx_l4_per_hwmod,
+	.slave		= &omap44xx_gpio6_hwmod,
+	.clk		= "gpio6_ick",
+	.addr		= omap44xx_gpio6_addrs,
+	.addr_cnt	= ARRAY_SIZE(omap44xx_gpio6_addrs),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* gpio6 slave ports */
+static struct omap_hwmod_ocp_if *omap44xx_gpio6_slaves[] = {
+	&omap44xx_l4_per__gpio6,
+};
+
+static struct omap_hwmod_opt_clk gpio6_opt_clks[] = {
+	{ .role = "dbclk", .clk = "sys_32k_ck" },
+};
+
+static struct omap_hwmod omap44xx_gpio6_hwmod = {
+	.name		= "gpio6",
+	.class		= &omap44xx_gpio_hwmod_class,
+	.mpu_irqs	= omap44xx_gpio6_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_gpio6_irqs),
+	.prcm = {
+		.omap4 = {
+			.clkctrl_reg = OMAP4430_CM_L4PER_GPIO6_CLKCTRL,
+		},
+	},
+	.opt_clks	= gpio6_opt_clks,
+	.opt_clks_cnt = ARRAY_SIZE(gpio6_opt_clks),
+	.dev_attr	= &gpio_dev_attr,
+	.slaves		= omap44xx_gpio6_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap44xx_gpio6_slaves),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+};
+
 static __initdata struct omap_hwmod *omap44xx_hwmods[] = {
 	/* dmm class */
 	&omap44xx_dmm_hwmod,
@@ -469,6 +803,13 @@ static __initdata struct omap_hwmod *omap44xx_hwmods[] = {
 	&omap44xx_l4_wkup_hwmod,
 	/* mpu_bus class */
 	&omap44xx_mpu_private_hwmod,
+	/* gpio class */
+	&omap44xx_gpio1_hwmod,
+	&omap44xx_gpio2_hwmod,
+	&omap44xx_gpio3_hwmod,
+	&omap44xx_gpio4_hwmod,
+	&omap44xx_gpio5_hwmod,
+	&omap44xx_gpio6_hwmod,
 
 	/* mpu class */
 	&omap44xx_mpu_hwmod,
-- 
1.7.0.4


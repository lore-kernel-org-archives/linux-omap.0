From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: [PATCH 1/2 RFC]OMAP3430: hwmod: add GPIO hwmods
Date: Fri, 12 Feb 2010 19:09:27 +0530
Message-ID: <1265981968-14696-2-git-send-email-charu@ti.com>
References: <1265981968-14696-1-git-send-email-charu@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:55115 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752670Ab0BLNj4 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 12 Feb 2010 08:39:56 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id o1CDdrNf007656
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 12 Feb 2010 07:39:55 -0600
In-Reply-To: <1265981968-14696-1-git-send-email-charu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Charulatha V <charu@ti.com>, Rajendra Nayak <rnayak@ti.com>

From: Charulatha V <charu@ti.com>

Add hwmod structures for GPIO module on OMAP3430.

Signed-off-by: Charulatha V <charu@ti.com>
Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_34xx.h |  410 +++++++++++++++++++++++++++++++++
 1 files changed, 410 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_34xx.h b/arch/arm/mach-omap2/omap_hwmod_34xx.h
index 2e629dc..b22b458 100644
--- a/arch/arm/mach-omap2/omap_hwmod_34xx.h
+++ b/arch/arm/mach-omap2/omap_hwmod_34xx.h
@@ -18,6 +18,7 @@
 #include <mach/irqs.h>
 #include <plat/cpu.h>
 #include <plat/dma.h>
+#include <plat/gpio.h>
 
 #include "prm-regbits-34xx.h"
 
@@ -25,6 +26,12 @@ static struct omap_hwmod omap34xx_mpu_hwmod;
 static struct omap_hwmod omap34xx_l3_hwmod;
 static struct omap_hwmod omap34xx_l4_core_hwmod;
 static struct omap_hwmod omap34xx_l4_per_hwmod;
+static struct omap_hwmod omap34xx_gpio1_hwmod;
+static struct omap_hwmod omap34xx_gpio2_hwmod;
+static struct omap_hwmod omap34xx_gpio3_hwmod;
+static struct omap_hwmod omap34xx_gpio4_hwmod;
+static struct omap_hwmod omap34xx_gpio5_hwmod;
+static struct omap_hwmod omap34xx_gpio6_hwmod;
 
 /* L3 -> L4_CORE interface */
 static struct omap_hwmod_ocp_if omap34xx_l3__l4_core = {
@@ -70,6 +77,168 @@ static struct omap_hwmod omap34xx_l3_hwmod = {
 
 static struct omap_hwmod omap34xx_l4_wkup_hwmod;
 
+/*
+ * GPIO1 interface data
+ */
+
+static struct omap_hwmod_addr_space omap34xx_gpio1_addr_space[] = {
+	{
+		.pa_start	= OMAP34XX_GPIO1_BASE,
+		.pa_end		= OMAP34XX_GPIO1_BASE + OMAP3_GPIO_AS_LEN - 1,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+
+/* GPIO1 <- L4_WKUP interface */
+static struct omap_hwmod_ocp_if omap34xx_l4_wkup__gpio1 = {
+	.master		= &omap34xx_l4_wkup_hwmod,
+	.slave		= &omap34xx_gpio1_hwmod,
+	.clkdev_dev_id	= NULL,
+	.clkdev_con_id	= "gpio1_ick",
+	.addr		= omap34xx_gpio1_addr_space,
+	.addr_cnt	= ARRAY_SIZE(omap34xx_gpio1_addr_space),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+static struct omap_hwmod_ocp_if *omap34xx_gpio1_slaves[] = {
+	&omap34xx_l4_wkup__gpio1,
+};
+
+/*
+ * GPIO2 interface data
+ */
+
+static struct omap_hwmod_addr_space omap34xx_gpio2_addr_space[] = {
+	{
+		.pa_start	= OMAP34XX_GPIO2_BASE,
+		.pa_end		= OMAP34XX_GPIO2_BASE + OMAP3_GPIO_AS_LEN - 1,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+
+/* GPIO2 <- L4_PER interface */
+static struct omap_hwmod_ocp_if omap34xx_l4_per__gpio2 = {
+	.master		= &omap34xx_l4_per_hwmod,
+	.slave		= &omap34xx_gpio2_hwmod,
+	.clkdev_dev_id	= NULL,
+	.clkdev_con_id	= "gpio2_ick",
+	.addr		= omap34xx_gpio2_addr_space,
+	.addr_cnt	= ARRAY_SIZE(omap34xx_gpio2_addr_space),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+static struct omap_hwmod_ocp_if *omap34xx_gpio2_slaves[] = {
+	&omap34xx_l4_per__gpio2,
+};
+
+/*
+ * GPIO3 interface data
+ */
+
+static struct omap_hwmod_addr_space omap34xx_gpio3_addr_space[] = {
+	{
+		.pa_start	= OMAP34XX_GPIO3_BASE,
+		.pa_end		= OMAP34XX_GPIO3_BASE + OMAP3_GPIO_AS_LEN - 1,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+
+/* GPIO3 <- L4_PER interface */
+static struct omap_hwmod_ocp_if omap34xx_l4_per__gpio3 = {
+	.master		= &omap34xx_l4_per_hwmod,
+	.slave		= &omap34xx_gpio3_hwmod,
+	.clkdev_dev_id	= NULL,
+	.clkdev_con_id	= "gpio3_ick",
+	.addr		= omap34xx_gpio3_addr_space,
+	.addr_cnt	= ARRAY_SIZE(omap34xx_gpio3_addr_space),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+static struct omap_hwmod_ocp_if *omap34xx_gpio3_slaves[] = {
+	&omap34xx_l4_per__gpio3,
+};
+
+/*
+ * GPIO4 interface data
+ */
+
+static struct omap_hwmod_addr_space omap34xx_gpio4_addr_space[] = {
+	{
+		.pa_start	= OMAP34XX_GPIO4_BASE,
+		.pa_end		= OMAP34XX_GPIO4_BASE + OMAP3_GPIO_AS_LEN - 1,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+
+/* GPIO4 <- L4_PER interface */
+static struct omap_hwmod_ocp_if omap34xx_l4_per__gpio4 = {
+	.master		= &omap34xx_l4_per_hwmod,
+	.slave		= &omap34xx_gpio4_hwmod,
+	.clkdev_dev_id	= NULL,
+	.clkdev_con_id	= "gpio4_ick",
+	.addr		= omap34xx_gpio4_addr_space,
+	.addr_cnt	= ARRAY_SIZE(omap34xx_gpio4_addr_space),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+static struct omap_hwmod_ocp_if *omap34xx_gpio4_slaves[] = {
+	&omap34xx_l4_per__gpio4,
+};
+
+/*
+ * GPIO5 interface data
+ */
+
+static struct omap_hwmod_addr_space omap34xx_gpio5_addr_space[] = {
+	{
+		.pa_start	= OMAP34XX_GPIO5_BASE,
+		.pa_end		= OMAP34XX_GPIO5_BASE + OMAP3_GPIO_AS_LEN - 1,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+
+/* GPIO5 <- L4_PER interface */
+static struct omap_hwmod_ocp_if omap34xx_l4_per__gpio5 = {
+	.master		= &omap34xx_l4_per_hwmod,
+	.slave		= &omap34xx_gpio5_hwmod,
+	.clkdev_dev_id	= NULL,
+	.clkdev_con_id	= "gpio5_ick",
+	.addr		= omap34xx_gpio5_addr_space,
+	.addr_cnt	= ARRAY_SIZE(omap34xx_gpio5_addr_space),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+static struct omap_hwmod_ocp_if *omap34xx_gpio5_slaves[] = {
+	&omap34xx_l4_per__gpio5,
+};
+
+/*
+ * GPIO6 interface data
+ */
+
+static struct omap_hwmod_addr_space omap34xx_gpio6_addr_space[] = {
+	{
+		.pa_start	= OMAP34XX_GPIO6_BASE,
+		.pa_end		= OMAP34XX_GPIO6_BASE + OMAP3_GPIO_AS_LEN - 1,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+
+/* GPIO6 <- L4_PER interface */
+static struct omap_hwmod_ocp_if omap34xx_l4_per__gpio6 = {
+	.master		= &omap34xx_l4_per_hwmod,
+	.slave		= &omap34xx_gpio6_hwmod,
+	.clkdev_dev_id	= NULL,
+	.clkdev_con_id	= "gpio6_ick",
+	.addr		= omap34xx_gpio6_addr_space,
+	.addr_cnt	= ARRAY_SIZE(omap34xx_gpio6_addr_space),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+static struct omap_hwmod_ocp_if *omap34xx_gpio6_slaves[] = {
+	&omap34xx_l4_per__gpio6,
+};
+
+
 /* L4_CORE -> L4_WKUP interface */
 static struct omap_hwmod_ocp_if omap34xx_l4_core__l4_wkup = {
 	.master	= &omap34xx_l4_core_hwmod,
@@ -104,6 +273,11 @@ static struct omap_hwmod_ocp_if *omap34xx_l4_per_slaves[] = {
 
 /* Master interfaces on the L4_PER interconnect */
 static struct omap_hwmod_ocp_if *omap34xx_l4_per_masters[] = {
+	&omap34xx_l4_per__gpio2,
+	&omap34xx_l4_per__gpio3,
+	&omap34xx_l4_per__gpio4,
+	&omap34xx_l4_per__gpio5,
+	&omap34xx_l4_per__gpio6,
 };
 
 /* L4 PER */
@@ -119,10 +293,12 @@ static struct omap_hwmod omap34xx_l4_per_hwmod = {
 /* Slave interfaces on the L4_WKUP interconnect */
 static struct omap_hwmod_ocp_if *omap34xx_l4_wkup_slaves[] = {
 	&omap34xx_l4_core__l4_wkup,
+	&omap34xx_l4_wkup__gpio1,
 };
 
 /* Master interfaces on the L4_WKUP interconnect */
 static struct omap_hwmod_ocp_if *omap34xx_l4_wkup_masters[] = {
+	&omap34xx_l4_wkup__gpio1,
 };
 
 /* L4 WKUP */
@@ -150,12 +326,246 @@ static struct omap_hwmod omap34xx_mpu_hwmod = {
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
 };
 
+/*
+ * GPIO1 (GPIO1)
+ */
+
+static struct omap_hwmod_sysconfig gpio_if_ctrl = {
+	.rev_offs	= 0x0000,
+	.sysc_offs	= 0x0010,
+	.syss_offs	= 0x0014,
+	.sysc_flags	= (SYSC_HAS_SIDLEMODE |
+			   SYSC_HAS_ENAWAKEUP | SYSC_HAS_SOFTRESET |
+			   SYSC_HAS_AUTOIDLE),
+	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
+};
+
+static struct omap_hwmod_irq_info omap34xx_gpio1_mpu_irqs[] = {
+	{ .name = "gpio_mpu_irq", .irq = INT_34XX_GPIO_BANK1 },
+};
+
+static struct omap_hwmod_opt_clk omap34xx_gpio1_opt_clk[] = {
+	{
+		.role = "gpio1_dbclk",
+		.clkdev_dev_id	= NULL,
+		.clkdev_con_id	= "gpio1_dbck",
+	},
+};
+
+static struct omap_hwmod omap34xx_gpio1_hwmod = {
+	.name		= "gpio1_hwmod",
+	.mpu_irqs	= omap34xx_gpio1_mpu_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap34xx_gpio1_mpu_irqs),
+	.clkdev_dev_id	= NULL,
+	.clkdev_con_id	= NULL,
+	.opt_clks	= omap34xx_gpio1_opt_clk,
+	.opt_clks_cnt	= ARRAY_SIZE(omap34xx_gpio1_opt_clk),
+	.prcm		= {
+		.omap2 = {
+			.prcm_reg_id = 1,
+			.module_bit = OMAP3430_EN_GPIO1_SHIFT,
+		},
+	},
+	.slaves		= omap34xx_gpio1_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap34xx_gpio1_slaves),
+	.sysconfig	= &gpio_if_ctrl,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+};
+
+/*
+ * GPIO2 (GPIO2)
+ */
+
+static struct omap_hwmod_irq_info omap34xx_gpio2_mpu_irqs[] = {
+	{ .name = "gpio_mpu_irq", .irq = INT_34XX_GPIO_BANK2 },
+};
+
+static struct omap_hwmod_opt_clk omap34xx_gpio2_opt_clk[] = {
+	{
+		.role = "gpio2_dbclk",
+		.clkdev_dev_id	= NULL,
+		.clkdev_con_id	= "gpio2_dbck",
+	},
+};
+
+static struct omap_hwmod omap34xx_gpio2_hwmod = {
+	.name		= "gpio2_hwmod",
+	.mpu_irqs	= omap34xx_gpio2_mpu_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap34xx_gpio2_mpu_irqs),
+	.clkdev_dev_id	= NULL,
+	.clkdev_con_id	= NULL,
+	.opt_clks	= omap34xx_gpio2_opt_clk,
+	.opt_clks_cnt	= ARRAY_SIZE(omap34xx_gpio2_opt_clk),
+	.prcm		= {
+		.omap2 = {
+			.prcm_reg_id = 1,
+			.module_bit = OMAP3430_EN_GPIO2_SHIFT,
+		},
+	},
+	.slaves		= omap34xx_gpio2_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap34xx_gpio2_slaves),
+	.sysconfig	= &gpio_if_ctrl,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+};
+
+/*
+ * GPIO3 (GPIO3)
+ */
+
+static struct omap_hwmod_irq_info omap34xx_gpio3_mpu_irqs[] = {
+	{ .name = "gpio_mpu_irq", .irq = INT_34XX_GPIO_BANK3 },
+};
+
+static struct omap_hwmod_opt_clk omap34xx_gpio3_opt_clk[] = {
+	{
+		.role = "gpio3_dbclk",
+		.clkdev_dev_id	= NULL,
+		.clkdev_con_id	= "gpio3_dbck",
+	},
+};
+
+static struct omap_hwmod omap34xx_gpio3_hwmod = {
+	.name		= "gpio3_hwmod",
+	.mpu_irqs	= omap34xx_gpio3_mpu_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap34xx_gpio3_mpu_irqs),
+	.clkdev_dev_id	= NULL,
+	.clkdev_con_id	= NULL,
+	.opt_clks	= omap34xx_gpio3_opt_clk,
+	.opt_clks_cnt	= ARRAY_SIZE(omap34xx_gpio3_opt_clk),
+	.prcm		= {
+		.omap2 = {
+			.prcm_reg_id = 1,
+			.module_bit = OMAP3430_EN_GPIO3_SHIFT,
+		},
+	},
+	.slaves		= omap34xx_gpio3_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap34xx_gpio3_slaves),
+	.sysconfig	= &gpio_if_ctrl,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+};
+
+
+/*
+ * GPIO4 (GPIO4)
+ */
+
+static struct omap_hwmod_irq_info omap34xx_gpio4_mpu_irqs[] = {
+	{ .name = "gpio_mpu_irq", .irq = INT_34XX_GPIO_BANK4 },
+};
+
+static struct omap_hwmod_opt_clk omap34xx_gpio4_opt_clk[] = {
+	{
+		.role = "gpio4_dbclk",
+		.clkdev_dev_id	= NULL,
+		.clkdev_con_id	= "gpio4_dbck",
+	},
+};
+
+static struct omap_hwmod omap34xx_gpio4_hwmod = {
+	.name		= "gpio4_hwmod",
+	.mpu_irqs	= omap34xx_gpio4_mpu_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap34xx_gpio4_mpu_irqs),
+	.clkdev_dev_id	= NULL,
+	.clkdev_con_id	= NULL,
+	.opt_clks	= omap34xx_gpio4_opt_clk,
+	.opt_clks_cnt	= ARRAY_SIZE(omap34xx_gpio4_opt_clk),
+	.prcm		= {
+		.omap2 = {
+			.prcm_reg_id = 1,
+			.module_bit = OMAP3430_EN_GPIO4_SHIFT,
+		},
+	},
+	.slaves		= omap34xx_gpio4_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap34xx_gpio4_slaves),
+	.sysconfig	= &gpio_if_ctrl,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+};
+
+
+/*
+ * GPIO5 (GPIO5)
+ */
+
+static struct omap_hwmod_irq_info omap34xx_gpio5_mpu_irqs[] = {
+	{ .name = "gpio_mpu_irq", .irq = INT_34XX_GPIO_BANK5 },
+};
+
+static struct omap_hwmod_opt_clk omap34xx_gpio5_opt_clk[] = {
+	{
+		.role = "gpio5_dbclk",
+		.clkdev_dev_id	= NULL,
+		.clkdev_con_id	= "gpio5_dbck",
+	},
+};
+
+static struct omap_hwmod omap34xx_gpio5_hwmod = {
+	.name		= "gpio5_hwmod",
+	.mpu_irqs	= omap34xx_gpio5_mpu_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap34xx_gpio5_mpu_irqs),
+	.clkdev_dev_id	= NULL,
+	.clkdev_con_id	= NULL,
+	.opt_clks	= omap34xx_gpio5_opt_clk,
+	.opt_clks_cnt	= ARRAY_SIZE(omap34xx_gpio5_opt_clk),
+	.prcm		= {
+		.omap2 = {
+			.prcm_reg_id = 1,
+			.module_bit = OMAP3430_EN_GPIO5_SHIFT,
+		},
+	},
+	.slaves		= omap34xx_gpio5_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap34xx_gpio5_slaves),
+	.sysconfig	= &gpio_if_ctrl,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+};
+
+/*
+ * GPIO6 (GPIO6)
+ */
+
+static struct omap_hwmod_irq_info omap34xx_gpio6_mpu_irqs[] = {
+	{ .name = "gpio_mpu_irq", .irq = INT_34XX_GPIO_BANK6 },
+};
+
+static struct omap_hwmod_opt_clk omap34xx_gpio6_opt_clk[] = {
+	{
+		.role = "gpio6_dbclk",
+		.clkdev_dev_id	= NULL,
+		.clkdev_con_id	= "gpio6_dbck",
+	},
+};
+
+static struct omap_hwmod omap34xx_gpio6_hwmod = {
+	.name		= "gpio6_hwmod",
+	.mpu_irqs	= omap34xx_gpio6_mpu_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap34xx_gpio6_mpu_irqs),
+	.clkdev_dev_id	= NULL,
+	.clkdev_con_id	= NULL,
+	.opt_clks	= omap34xx_gpio6_opt_clk,
+	.opt_clks_cnt	= ARRAY_SIZE(omap34xx_gpio6_opt_clk),
+	.prcm		= {
+		.omap2 = {
+			.prcm_reg_id = 1,
+			.module_bit = OMAP3430_EN_GPIO6_SHIFT,
+		},
+	},
+	.slaves		= omap34xx_gpio6_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap34xx_gpio6_slaves),
+	.sysconfig	= &gpio_if_ctrl,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+};
+
 static __initdata struct omap_hwmod *omap34xx_hwmods[] = {
 	&omap34xx_l3_hwmod,
 	&omap34xx_l4_core_hwmod,
 	&omap34xx_l4_per_hwmod,
 	&omap34xx_l4_wkup_hwmod,
 	&omap34xx_mpu_hwmod,
+	&omap34xx_gpio1_hwmod,
+	&omap34xx_gpio2_hwmod,
+	&omap34xx_gpio3_hwmod,
+	&omap34xx_gpio4_hwmod,
+	&omap34xx_gpio5_hwmod,
+	&omap34xx_gpio6_hwmod,
 	NULL,
 };
 
-- 
1.6.3.3


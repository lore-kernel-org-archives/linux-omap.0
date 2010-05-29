From: Thara Gopinath <thara@ti.com>
Subject: [PATCH 8/9] OMAP2: Add hwmod data for OMAP2430 dual mode timers.
Date: Sat, 29 May 2010 20:07:10 +0530
Message-ID: <1275143831-7629-9-git-send-email-thara@ti.com>
References: <1275143831-7629-1-git-send-email-thara@ti.com>
 <1275143831-7629-2-git-send-email-thara@ti.com>
 <1275143831-7629-3-git-send-email-thara@ti.com>
 <1275143831-7629-4-git-send-email-thara@ti.com>
 <1275143831-7629-5-git-send-email-thara@ti.com>
 <1275143831-7629-6-git-send-email-thara@ti.com>
 <1275143831-7629-7-git-send-email-thara@ti.com>
 <1275143831-7629-8-git-send-email-thara@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:35543 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755776Ab0E2OhU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 29 May 2010 10:37:20 -0400
In-Reply-To: <1275143831-7629-8-git-send-email-thara@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, tony@atomide.com, sawant@ti.com, Thara Gopinath <thara@ti.com>

This patch adds OMAP2430 dual mode timers hwmod structures.

Signed-off-by: Thara Gopinath <thara@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_2430_data.c |  619 +++++++++++++++++++++++++++-
 1 files changed, 618 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_2430_data.c b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
index 0852d95..56d9694 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2430_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
@@ -17,7 +17,7 @@
 #include <plat/dma.h>
 
 #include "omap_hwmod_common_data.h"
-
+#include "dmtimers.h"
 #include "prm-regbits-24xx.h"
 
 /*
@@ -32,6 +32,18 @@
 static struct omap_hwmod omap2430_mpu_hwmod;
 static struct omap_hwmod omap2430_l3_hwmod;
 static struct omap_hwmod omap2430_l4_core_hwmod;
+static struct omap_hwmod omap2430_gptimer1_hwmod;
+static struct omap_hwmod omap2430_gptimer2_hwmod;
+static struct omap_hwmod omap2430_gptimer3_hwmod;
+static struct omap_hwmod omap2430_gptimer4_hwmod;
+static struct omap_hwmod omap2430_gptimer5_hwmod;
+static struct omap_hwmod omap2430_gptimer6_hwmod;
+static struct omap_hwmod omap2430_gptimer7_hwmod;
+static struct omap_hwmod omap2430_gptimer8_hwmod;
+static struct omap_hwmod omap2430_gptimer9_hwmod;
+static struct omap_hwmod omap2430_gptimer10_hwmod;
+static struct omap_hwmod omap2430_gptimer11_hwmod;
+static struct omap_hwmod omap2430_gptimer12_hwmod;
 
 /* L3 -> L4_CORE interface */
 static struct omap_hwmod_ocp_if omap2430_l3__l4_core = {
@@ -79,6 +91,248 @@ static struct omap_hwmod_ocp_if omap2430_l4_core__l4_wkup = {
 	.user	= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
+/* GPTIMER2 <- L4_CORE interface */
+static struct omap_hwmod_addr_space omap2430_gptimer2_addrs[] = {
+	{
+		.pa_start	= OMAP24XX_GPTIMER2_BASE,
+		.pa_end		= OMAP24XX_GPTIMER2_BASE + SZ_1K - 1,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+
+static struct omap_hwmod_ocp_if omap2430_l4_core__gptimer2 = {
+	.master		= &omap2430_l4_core_hwmod,
+	.slave		= &omap2430_gptimer2_hwmod,
+	.clk		= "gpt2_ick",
+	.addr		= omap2430_gptimer2_addrs,
+	.addr_cnt	= ARRAY_SIZE(omap2430_gptimer2_addrs),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+static struct omap_hwmod_ocp_if *omap2430_gptimer2_slaves[] = {
+	&omap2430_l4_core__gptimer2,
+};
+
+/* GPTIMER3 <- L4_CORE interface */
+static struct omap_hwmod_addr_space omap2430_gptimer3_addrs[] = {
+	{
+		.pa_start	= OMAP24XX_GPTIMER3_BASE,
+		.pa_end		= OMAP24XX_GPTIMER3_BASE + SZ_1K - 1,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+
+static struct omap_hwmod_ocp_if omap2430_l4_core__gptimer3 = {
+	.master		= &omap2430_l4_core_hwmod,
+	.slave		= &omap2430_gptimer3_hwmod,
+	.clk		= "gpt3_ick",
+	.addr		= omap2430_gptimer3_addrs,
+	.addr_cnt	= ARRAY_SIZE(omap2430_gptimer3_addrs),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+static struct omap_hwmod_ocp_if *omap2430_gptimer3_slaves[] = {
+	&omap2430_l4_core__gptimer3,
+};
+
+/* GPTIMER4 <- L4_CORE interface */
+static struct omap_hwmod_addr_space omap2430_gptimer4_addrs[] = {
+	{
+		.pa_start	= OMAP24XX_GPTIMER4_BASE,
+		.pa_end		= OMAP24XX_GPTIMER4_BASE + SZ_1K - 1,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+
+static struct omap_hwmod_ocp_if omap2430_l4_core__gptimer4 = {
+	.master		= &omap2430_l4_core_hwmod,
+	.slave		= &omap2430_gptimer4_hwmod,
+	.clk		= "gpt4_ick",
+	.addr		= omap2430_gptimer4_addrs,
+	.addr_cnt	= ARRAY_SIZE(omap2430_gptimer4_addrs),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+static struct omap_hwmod_ocp_if *omap2430_gptimer4_slaves[] = {
+	&omap2430_l4_core__gptimer4,
+};
+
+/* GPTIMER5 <- L4_CORE interface */
+static struct omap_hwmod_addr_space omap2430_gptimer5_addrs[] = {
+	{
+		.pa_start	= OMAP24XX_GPTIMER5_BASE,
+		.pa_end		= OMAP24XX_GPTIMER5_BASE + SZ_1K - 1,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+
+static struct omap_hwmod_ocp_if omap2430_l4_core__gptimer5 = {
+	.master		= &omap2430_l4_core_hwmod,
+	.slave		= &omap2430_gptimer5_hwmod,
+	.clk		= "gpt5_ick",
+	.addr		= omap2430_gptimer5_addrs,
+	.addr_cnt	= ARRAY_SIZE(omap2430_gptimer5_addrs),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+static struct omap_hwmod_ocp_if *omap2430_gptimer5_slaves[] = {
+	&omap2430_l4_core__gptimer5,
+};
+
+/* GPTIMER6 <- L4_CORE interface */
+static struct omap_hwmod_addr_space omap2430_gptimer6_addrs[] = {
+	{
+		.pa_start	= OMAP24XX_GPTIMER6_BASE,
+		.pa_end		= OMAP24XX_GPTIMER6_BASE + SZ_1K - 1,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+
+static struct omap_hwmod_ocp_if omap2430_l4_core__gptimer6 = {
+	.master		= &omap2430_l4_core_hwmod,
+	.slave		= &omap2430_gptimer6_hwmod,
+	.clk		= "gpt6_ick",
+	.addr		= omap2430_gptimer6_addrs,
+	.addr_cnt	= ARRAY_SIZE(omap2430_gptimer6_addrs),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+static struct omap_hwmod_ocp_if *omap2430_gptimer6_slaves[] = {
+	&omap2430_l4_core__gptimer6,
+};
+
+/* GPTIMER7 <- L4_CORE interface */
+static struct omap_hwmod_addr_space omap2430_gptimer7_addrs[] = {
+	{
+		.pa_start	= OMAP24XX_GPTIMER7_BASE,
+		.pa_end		= OMAP24XX_GPTIMER7_BASE + SZ_1K - 1,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+
+static struct omap_hwmod_ocp_if omap2430_l4_core__gptimer7 = {
+	.master		= &omap2430_l4_core_hwmod,
+	.slave		= &omap2430_gptimer7_hwmod,
+	.clk		= "gpt7_ick",
+	.addr		= omap2430_gptimer7_addrs,
+	.addr_cnt	= ARRAY_SIZE(omap2430_gptimer7_addrs),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+static struct omap_hwmod_ocp_if *omap2430_gptimer7_slaves[] = {
+	&omap2430_l4_core__gptimer7,
+};
+
+/* GPTIMER8 <- L4_CORE interface */
+static struct omap_hwmod_addr_space omap2430_gptimer8_addrs[] = {
+	{
+		.pa_start	= OMAP24XX_GPTIMER8_BASE,
+		.pa_end		= OMAP24XX_GPTIMER8_BASE + SZ_1K - 1,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+
+static struct omap_hwmod_ocp_if omap2430_l4_core__gptimer8 = {
+	.master		= &omap2430_l4_core_hwmod,
+	.slave		= &omap2430_gptimer8_hwmod,
+	.clk		= "gpt8_ick",
+	.addr		= omap2430_gptimer8_addrs,
+	.addr_cnt	= ARRAY_SIZE(omap2430_gptimer8_addrs),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+static struct omap_hwmod_ocp_if *omap2430_gptimer8_slaves[] = {
+	&omap2430_l4_core__gptimer8,
+};
+
+/* GPTIMER9 <- L4_CORE interface */
+static struct omap_hwmod_addr_space omap2430_gptimer9_addrs[] = {
+	{
+		.pa_start	= OMAP24XX_GPTIMER9_BASE,
+		.pa_end		= OMAP24XX_GPTIMER9_BASE + SZ_1K - 1,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+
+static struct omap_hwmod_ocp_if omap2430_l4_core__gptimer9 = {
+	.master		= &omap2430_l4_core_hwmod,
+	.slave		= &omap2430_gptimer9_hwmod,
+	.clk		= "gpt9_ick",
+	.addr		= omap2430_gptimer9_addrs,
+	.addr_cnt	= ARRAY_SIZE(omap2430_gptimer9_addrs),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+static struct omap_hwmod_ocp_if *omap2430_gptimer9_slaves[] = {
+	&omap2430_l4_core__gptimer9,
+};
+
+/* GPTIMER10 <- L4_CORE interface */
+static struct omap_hwmod_addr_space omap2430_gptimer10_addrs[] = {
+	{
+		.pa_start	= OMAP24XX_GPTIMER10_BASE,
+		.pa_end		= OMAP24XX_GPTIMER10_BASE + SZ_1K - 1,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+
+static struct omap_hwmod_ocp_if omap2430_l4_core__gptimer10 = {
+	.master		= &omap2430_l4_core_hwmod,
+	.slave		= &omap2430_gptimer10_hwmod,
+	.clk		= "gpt10_ick",
+	.addr		= omap2430_gptimer10_addrs,
+	.addr_cnt	= ARRAY_SIZE(omap2430_gptimer10_addrs),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+static struct omap_hwmod_ocp_if *omap2430_gptimer10_slaves[] = {
+	&omap2430_l4_core__gptimer10,
+};
+
+/* GPTIMER11 <- L4_CORE interface */
+static struct omap_hwmod_addr_space omap2430_gptimer11_addrs[] = {
+	{
+		.pa_start	= OMAP24XX_GPTIMER11_BASE,
+		.pa_end		= OMAP24XX_GPTIMER11_BASE + SZ_1K - 1,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+
+static struct omap_hwmod_ocp_if omap2430_l4_core__gptimer11 = {
+	.master		= &omap2430_l4_core_hwmod,
+	.slave		= &omap2430_gptimer11_hwmod,
+	.clk		= "gpt11_ick",
+	.addr		= omap2430_gptimer11_addrs,
+	.addr_cnt	= ARRAY_SIZE(omap2430_gptimer11_addrs),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+static struct omap_hwmod_ocp_if *omap2430_gptimer11_slaves[] = {
+	&omap2430_l4_core__gptimer11,
+};
+
+/* GPTIMER12 <- L4_CORE interface */
+static struct omap_hwmod_addr_space omap2430_gptimer12_addrs[] = {
+	{
+		.pa_start	= OMAP24XX_GPTIMER12_BASE,
+		.pa_end		= OMAP24XX_GPTIMER12_BASE + SZ_1K - 1,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+
+static struct omap_hwmod_ocp_if omap2430_l4_core__gptimer12 = {
+	.master		= &omap2430_l4_core_hwmod,
+	.slave		= &omap2430_gptimer12_hwmod,
+	.clk		= "gpt12_ick",
+	.addr		= omap2430_gptimer12_addrs,
+	.addr_cnt	= ARRAY_SIZE(omap2430_gptimer12_addrs),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+static struct omap_hwmod_ocp_if *omap2430_gptimer12_slaves[] = {
+	&omap2430_l4_core__gptimer12,
+};
+
 /* Slave interfaces on the L4_CORE interconnect */
 static struct omap_hwmod_ocp_if *omap2430_l4_core_slaves[] = {
 	&omap2430_l3__l4_core,
@@ -87,6 +341,17 @@ static struct omap_hwmod_ocp_if *omap2430_l4_core_slaves[] = {
 /* Master interfaces on the L4_CORE interconnect */
 static struct omap_hwmod_ocp_if *omap2430_l4_core_masters[] = {
 	&omap2430_l4_core__l4_wkup,
+	&omap2430_l4_core__gptimer2,
+	&omap2430_l4_core__gptimer3,
+	&omap2430_l4_core__gptimer4,
+	&omap2430_l4_core__gptimer5,
+	&omap2430_l4_core__gptimer6,
+	&omap2430_l4_core__gptimer7,
+	&omap2430_l4_core__gptimer8,
+	&omap2430_l4_core__gptimer9,
+	&omap2430_l4_core__gptimer10,
+	&omap2430_l4_core__gptimer11,
+	&omap2430_l4_core__gptimer12,
 };
 
 /* L4 CORE */
@@ -100,6 +365,28 @@ static struct omap_hwmod omap2430_l4_core_hwmod = {
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2430)
 };
 
+/* GPTIMER1 <- L4_WKUP interface */
+static struct omap_hwmod_addr_space omap2430_gptimer1_addrs[] = {
+	{
+		.pa_start	= OMAP2430_GPTIMER1_BASE,
+		.pa_end		= OMAP2430_GPTIMER1_BASE + SZ_1K - 1,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+
+static struct omap_hwmod_ocp_if omap2430_l4_wkup__gptimer1 = {
+	.master		= &omap2430_l4_wkup_hwmod,
+	.slave		= &omap2430_gptimer1_hwmod,
+	.clk		= "gpt1_ick",
+	.addr		= omap2430_gptimer1_addrs,
+	.addr_cnt	= ARRAY_SIZE(omap2430_gptimer1_addrs),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+static struct omap_hwmod_ocp_if *omap2430_gptimer1_slaves[] = {
+	&omap2430_l4_wkup__gptimer1,
+};
+
 /* Slave interfaces on the L4_WKUP interconnect */
 static struct omap_hwmod_ocp_if *omap2430_l4_wkup_slaves[] = {
 	&omap2430_l4_core__l4_wkup,
@@ -107,6 +394,7 @@ static struct omap_hwmod_ocp_if *omap2430_l4_wkup_slaves[] = {
 
 /* Master interfaces on the L4_WKUP interconnect */
 static struct omap_hwmod_ocp_if *omap2430_l4_wkup_masters[] = {
+	&omap2430_l4_wkup__gptimer1,
 };
 
 /* L4 WKUP */
@@ -135,11 +423,340 @@ static struct omap_hwmod omap2430_mpu_hwmod = {
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2430),
 };
 
+/* Timer Common */
+static struct omap_hwmod_class_sysconfig omap2430_timer_sysc = {
+	.rev_offs	= 0x0000,
+	.sysc_offs	= 0x0010,
+	.syss_offs	= 0x0014,
+	.sysc_flags	= (SYSC_HAS_SIDLEMODE | SYSC_HAS_CLOCKACTIVITY |
+			   SYSC_HAS_ENAWAKEUP | SYSC_HAS_SOFTRESET |
+			   SYSC_HAS_AUTOIDLE),
+	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
+	.sysc_fields    = &omap_hwmod_sysc_type1,
+};
+
+static struct omap_hwmod_class omap2430_timer_hwmod_class = {
+	.name = "timer",
+	.sysc = &omap2430_timer_sysc,
+};
+
+/* TIMER 1 */
+static struct omap_hwmod_irq_info omap2430_gptimer1_mpu_irqs[] = {
+	{ .irq = INT_24XX_GPTIMER1, },
+};
+
+static struct omap_hwmod omap2430_gptimer1_hwmod = {
+	.name		= "timer1",
+	.mpu_irqs	= omap2430_gptimer1_mpu_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap2430_gptimer1_mpu_irqs),
+	.main_clk	= "gpt1_fck",
+	.prcm		= {
+		.omap2 = {
+			.prcm_reg_id = 1,
+			.module_bit = OMAP24XX_EN_GPT1_SHIFT,
+			.module_offs = WKUP_MOD,
+			.idlest_reg_id = 1,
+			.idlest_idle_bit = OMAP24XX_EN_GPT1_SHIFT,
+		},
+	},
+	.slaves		= omap2430_gptimer1_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap2430_gptimer1_slaves),
+	.class		= &omap2430_timer_hwmod_class,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2430)
+};
+
+/* TIMER 2 */
+static struct omap_hwmod_irq_info omap2430_gptimer2_mpu_irqs[] = {
+	{ .irq = INT_24XX_GPTIMER2, },
+};
+
+static struct omap_hwmod omap2430_gptimer2_hwmod = {
+	.name		= "timer2",
+	.mpu_irqs	= omap2430_gptimer2_mpu_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap2430_gptimer2_mpu_irqs),
+	.main_clk	= "gpt2_fck",
+	.prcm		= {
+		.omap2 = {
+			.prcm_reg_id = 1,
+			.module_bit = OMAP24XX_EN_GPT2_SHIFT,
+			.module_offs = CORE_MOD,
+			.idlest_reg_id = 1,
+			.idlest_idle_bit = OMAP24XX_EN_GPT2_SHIFT,
+		},
+	},
+	.slaves		= omap2430_gptimer2_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap2430_gptimer2_slaves),
+	.class		= &omap2430_timer_hwmod_class,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2430)
+};
+
+/* TIMER 3 */
+static struct omap_hwmod_irq_info omap2430_gptimer3_mpu_irqs[] = {
+	{ .irq = INT_24XX_GPTIMER3, },
+};
+
+static struct omap_hwmod omap2430_gptimer3_hwmod = {
+	.name		= "timer3",
+	.mpu_irqs	= omap2430_gptimer3_mpu_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap2430_gptimer3_mpu_irqs),
+	.main_clk	= "gpt3_fck",
+	.prcm		= {
+		.omap2 = {
+			.prcm_reg_id = 1,
+			.module_bit = OMAP24XX_EN_GPT3_SHIFT,
+			.module_offs = CORE_MOD,
+			.idlest_reg_id = 1,
+			.idlest_idle_bit = OMAP24XX_EN_GPT3_SHIFT,
+		},
+	},
+	.slaves		= omap2430_gptimer3_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap2430_gptimer3_slaves),
+	.class		= &omap2430_timer_hwmod_class,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2430)
+};
+
+/* TIMER 4 */
+static struct omap_hwmod_irq_info omap2430_gptimer4_mpu_irqs[] = {
+	{ .irq = INT_24XX_GPTIMER4, },
+};
+
+static struct omap_hwmod omap2430_gptimer4_hwmod = {
+	.name		= "timer4",
+	.mpu_irqs	= omap2430_gptimer4_mpu_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap2430_gptimer4_mpu_irqs),
+	.main_clk	= "gpt4_fck",
+	.prcm		= {
+		.omap2 = {
+			.prcm_reg_id = 1,
+			.module_bit = OMAP24XX_EN_GPT4_SHIFT,
+			.module_offs = CORE_MOD,
+			.idlest_reg_id = 1,
+			.idlest_idle_bit = OMAP24XX_EN_GPT4_SHIFT,
+		},
+	},
+	.slaves		= omap2430_gptimer4_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap2430_gptimer4_slaves),
+	.class		= &omap2430_timer_hwmod_class,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2430)
+};
+
+/* TIMER 5 */
+static struct omap_hwmod_irq_info omap2430_gptimer5_mpu_irqs[] = {
+	{ .irq = INT_24XX_GPTIMER5, },
+};
+
+static struct omap_hwmod omap2430_gptimer5_hwmod = {
+	.name		= "timer5",
+	.mpu_irqs	= omap2430_gptimer5_mpu_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap2430_gptimer5_mpu_irqs),
+	.main_clk	= "gpt5_fck",
+	.prcm		= {
+		.omap2 = {
+			.prcm_reg_id = 1,
+			.module_bit = OMAP24XX_EN_GPT5_SHIFT,
+			.module_offs = CORE_MOD,
+			.idlest_reg_id = 1,
+			.idlest_idle_bit = OMAP24XX_EN_GPT5_SHIFT,
+		},
+	},
+	.slaves		= omap2430_gptimer5_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap2430_gptimer5_slaves),
+	.class		= &omap2430_timer_hwmod_class,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2430)
+};
+
+/* TIMER 6 */
+static struct omap_hwmod_irq_info omap2430_gptimer6_mpu_irqs[] = {
+	{ .irq = INT_24XX_GPTIMER6, },
+};
+
+static struct omap_hwmod omap2430_gptimer6_hwmod = {
+	.name		= "timer6",
+	.mpu_irqs	= omap2430_gptimer6_mpu_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap2430_gptimer6_mpu_irqs),
+	.main_clk	= "gpt6_fck",
+	.prcm		= {
+		.omap2 = {
+			.prcm_reg_id = 1,
+			.module_bit = OMAP24XX_EN_GPT6_SHIFT,
+			.module_offs = CORE_MOD,
+			.idlest_reg_id = 1,
+			.idlest_idle_bit = OMAP24XX_EN_GPT6_SHIFT,
+		},
+	},
+	.slaves		= omap2430_gptimer6_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap2430_gptimer6_slaves),
+	.class		= &omap2430_timer_hwmod_class,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2430)
+};
+
+/* TIMER 7 */
+static struct omap_hwmod_irq_info omap2430_gptimer7_mpu_irqs[] = {
+	{ .irq = INT_24XX_GPTIMER7, },
+};
+
+static struct omap_hwmod omap2430_gptimer7_hwmod = {
+	.name		= "timer7",
+	.mpu_irqs	= omap2430_gptimer7_mpu_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap2430_gptimer7_mpu_irqs),
+	.main_clk	= "gpt7_fck",
+	.prcm		= {
+		.omap2 = {
+			.prcm_reg_id = 1,
+			.module_bit = OMAP24XX_EN_GPT7_SHIFT,
+			.module_offs = CORE_MOD,
+			.idlest_reg_id = 1,
+			.idlest_idle_bit = OMAP24XX_EN_GPT7_SHIFT,
+		},
+	},
+	.slaves		= omap2430_gptimer7_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap2430_gptimer7_slaves),
+	.class		= &omap2430_timer_hwmod_class,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2430)
+};
+
+/* TIMER 8 */
+static struct omap_hwmod_irq_info omap2430_gptimer8_mpu_irqs[] = {
+	{ .irq = INT_24XX_GPTIMER8, },
+};
+
+static struct omap_hwmod omap2430_gptimer8_hwmod = {
+	.name		= "timer8",
+	.mpu_irqs	= omap2430_gptimer8_mpu_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap2430_gptimer8_mpu_irqs),
+	.main_clk	= "gpt8_fck",
+	.prcm		= {
+		.omap2 = {
+			.prcm_reg_id = 1,
+			.module_bit = OMAP24XX_EN_GPT8_SHIFT,
+			.module_offs = CORE_MOD,
+			.idlest_reg_id = 1,
+			.idlest_idle_bit = OMAP24XX_EN_GPT8_SHIFT,
+		},
+	},
+	.slaves		= omap2430_gptimer8_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap2430_gptimer8_slaves),
+	.class		= &omap2430_timer_hwmod_class,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2430)
+};
+
+/* TIMER 9 */
+static struct omap_hwmod_irq_info omap2430_gptimer9_mpu_irqs[] = {
+	{ .irq = INT_24XX_GPTIMER9, },
+};
+
+static struct omap_hwmod omap2430_gptimer9_hwmod = {
+	.name		= "timer9",
+	.mpu_irqs	= omap2430_gptimer9_mpu_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap2430_gptimer9_mpu_irqs),
+	.main_clk	= "gpt9_fck",
+	.prcm		= {
+		.omap2 = {
+			.prcm_reg_id = 1,
+			.module_bit = OMAP24XX_EN_GPT9_SHIFT,
+			.module_offs = CORE_MOD,
+			.idlest_reg_id = 1,
+			.idlest_idle_bit = OMAP24XX_EN_GPT9_SHIFT,
+		},
+	},
+	.slaves		= omap2430_gptimer9_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap2430_gptimer9_slaves),
+	.class		= &omap2430_timer_hwmod_class,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2430)
+};
+
+/* TIMER 10 */
+static struct omap_hwmod_irq_info omap2430_gptimer10_mpu_irqs[] = {
+	{ .irq = INT_24XX_GPTIMER10, },
+};
+
+static struct omap_hwmod omap2430_gptimer10_hwmod = {
+	.name		= "timer10",
+	.mpu_irqs	= omap2430_gptimer10_mpu_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap2430_gptimer10_mpu_irqs),
+	.main_clk	= "gpt10_fck",
+	.prcm		= {
+		.omap2 = {
+			.prcm_reg_id = 1,
+			.module_bit = OMAP24XX_EN_GPT10_SHIFT,
+			.module_offs = CORE_MOD,
+			.idlest_reg_id = 1,
+			.idlest_idle_bit = OMAP24XX_EN_GPT10_SHIFT,
+		},
+	},
+	.slaves		= omap2430_gptimer10_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap2430_gptimer10_slaves),
+	.class		= &omap2430_timer_hwmod_class,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2430)
+};
+
+/* TIMER 11 */
+static struct omap_hwmod_irq_info omap2430_gptimer11_mpu_irqs[] = {
+	{ .irq = INT_24XX_GPTIMER11, },
+};
+
+static struct omap_hwmod omap2430_gptimer11_hwmod = {
+	.name		= "timer11",
+	.mpu_irqs	= omap2430_gptimer11_mpu_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap2430_gptimer11_mpu_irqs),
+	.main_clk	= "gpt11_fck",
+	.prcm		= {
+		.omap2 = {
+			.prcm_reg_id = 1,
+			.module_bit = OMAP24XX_EN_GPT11_SHIFT,
+			.module_offs = CORE_MOD,
+			.idlest_reg_id = 1,
+			.idlest_idle_bit = OMAP24XX_EN_GPT11_SHIFT,
+		},
+	},
+	.slaves		= omap2430_gptimer11_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap2430_gptimer11_slaves),
+	.class		= &omap2430_timer_hwmod_class,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2430)
+};
+
+/* TIMER 12 */
+static struct omap_hwmod_irq_info omap2430_gptimer12_mpu_irqs[] = {
+	{ .irq = INT_24XX_GPTIMER12, },
+};
+
+static struct omap_hwmod omap2430_gptimer12_hwmod = {
+	.name		= "timer12",
+	.mpu_irqs	= omap2430_gptimer12_mpu_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap2430_gptimer12_mpu_irqs),
+	.main_clk	= "gpt12_fck",
+	.prcm		= {
+		.omap2 = {
+			.prcm_reg_id = 1,
+			.module_bit = OMAP24XX_EN_GPT12_SHIFT,
+			.module_offs = CORE_MOD,
+			.idlest_reg_id = 1,
+			.idlest_idle_bit = OMAP24XX_EN_GPT12_SHIFT,
+		},
+	},
+	.slaves		= omap2430_gptimer12_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap2430_gptimer12_slaves),
+	.class		= &omap2430_timer_hwmod_class,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2430)
+};
+
 static __initdata struct omap_hwmod *omap2430_hwmods[] = {
 	&omap2430_l3_hwmod,
 	&omap2430_l4_core_hwmod,
 	&omap2430_l4_wkup_hwmod,
 	&omap2430_mpu_hwmod,
+	&omap2430_gptimer1_hwmod,
+	&omap2430_gptimer2_hwmod,
+	&omap2430_gptimer3_hwmod,
+	&omap2430_gptimer4_hwmod,
+	&omap2430_gptimer5_hwmod,
+	&omap2430_gptimer6_hwmod,
+	&omap2430_gptimer7_hwmod,
+	&omap2430_gptimer8_hwmod,
+	&omap2430_gptimer9_hwmod,
+	&omap2430_gptimer10_hwmod,
+	&omap2430_gptimer11_hwmod,
+	&omap2430_gptimer12_hwmod,
 	NULL,
 };
 
-- 
1.7.0.rc1.33.g07cf0f


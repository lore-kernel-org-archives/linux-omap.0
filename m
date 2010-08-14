From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCHv 2/13] dmtimer: hwmod: add omap3xxx database
Date: Sat, 14 Aug 2010 21:08:44 +0530
Message-ID: <1281800324-15235-1-git-send-email-tarun.kanti@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:45292 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932692Ab0HNEjb (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 14 Aug 2010 00:39:31 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Thara Gopinath <thara@ti.com>, Partha Basak <p-basak2@ti.com>, Tarun Kanti DebBarma <tarun.kanti@ti.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@deeprootsystems.com>, Tony Lindgren <tony@atomide.com>

From: Thara Gopinath <thara@ti.com>

This patch adds hwmod database for omap3xxx.

Signed-off-by: Partha Basak <p-basak2@ti.com>
Signed-off-by: Thara Gopinath <thara@ti.com>
Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |  671 ++++++++++++++++++++++++++++
 1 files changed, 671 insertions(+), 0 deletions(-)
 mode change 100644 => 100755 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c

diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
old mode 100644
new mode 100755
index 5d8eb58..6b9e7a1
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -100,6 +100,153 @@ static struct omap_hwmod_ocp_if *omap3xxx_l4_core_masters[] = {
 	&omap3xxx_l4_core__l4_wkup,
 };
 
+/* timer class */
+static struct omap_hwmod_class_sysconfig omap3xxx_timer_1ms_sysc = {
+	.rev_offs	= 0x0000,
+	.sysc_offs	= 0x0010,
+	.syss_offs	= 0x0014,
+	.sysc_flags	= (SYSC_HAS_SIDLEMODE | SYSC_HAS_CLOCKACTIVITY |
+				SYSC_HAS_ENAWAKEUP | SYSC_HAS_SOFTRESET |
+				SYSC_HAS_EMUFREE | SYSC_HAS_AUTOIDLE),
+	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
+	.sysc_fields	= &omap_hwmod_sysc_type1,
+};
+
+static struct omap_hwmod_class omap3xxx_timer_1ms_hwmod_class = {
+	.name = "timer_1ms",
+	.sysc = &omap3xxx_timer_1ms_sysc,
+};
+
+
+static struct omap_hwmod_class_sysconfig omap3xxx_timer_sysc = {
+	.rev_offs	= 0x0000,
+	.sysc_offs	= 0x0010,
+	.syss_offs	= 0x0014,
+	.sysc_flags	= (SYSC_HAS_SIDLEMODE | SYSC_HAS_ENAWAKEUP |
+			   SYSC_HAS_SOFTRESET | SYSC_HAS_AUTOIDLE),
+	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
+	.sysc_fields	= &omap_hwmod_sysc_type2,
+};
+
+static struct omap_hwmod_class omap3xxx_timer_hwmod_class = {
+	.name = "timer",
+	.sysc = &omap3xxx_timer_sysc,
+};
+
+/* timer10 */
+static struct omap_hwmod omap3xxx_timer10_hwmod;
+static struct omap_hwmod_irq_info omap3xxx_timer10_mpu_irqs[] = {
+	{ .irq = INT_24XX_GPTIMER10, },
+};
+
+static struct omap_hwmod_addr_space omap3xxx_timer10_addrs[] = {
+	{
+		.pa_start	= 0x48086000,
+		.pa_end		= 0x48086000 + SZ_1K - 1,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+
+/* l4_core -> timer10 */
+static struct omap_hwmod_ocp_if omap3xxx_l4_core__timer10 = {
+	.master		= &omap3xxx_l4_core_hwmod,
+	.slave		= &omap3xxx_timer10_hwmod,
+	.clk		= "gpt10_ick",
+	.addr		= omap3xxx_timer10_addrs,
+	.addr_cnt	= ARRAY_SIZE(omap3xxx_timer10_addrs),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* timer10 master port */
+static struct omap_hwmod_ocp_if *omap3xxx_timer10_masters[] = {
+	&omap3xxx_l4_core__timer10,
+};
+
+/* timer10 slave port */
+static struct omap_hwmod_ocp_if *omap3xxx_timer10_slaves[] = {
+	&omap3xxx_l4_core__timer10,
+};
+
+/* timer10 hwmod */
+static struct omap_hwmod omap3xxx_timer10_hwmod = {
+	.name		= "timer10",
+	.mpu_irqs	= omap3xxx_timer10_mpu_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap3xxx_timer10_mpu_irqs),
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
+	.masters	= omap3xxx_timer10_masters,
+	.masters_cnt	= ARRAY_SIZE(omap3xxx_timer10_masters),
+	.slaves		= omap3xxx_timer10_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap3xxx_timer10_slaves),
+	.class		= &omap3xxx_timer_1ms_hwmod_class,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
+};
+
+/* timer11 */
+static struct omap_hwmod omap3xxx_timer11_hwmod;
+static struct omap_hwmod_irq_info omap3xxx_timer11_mpu_irqs[] = {
+	{ .irq = INT_24XX_GPTIMER11, },
+};
+
+static struct omap_hwmod_addr_space omap3xxx_timer11_addrs[] = {
+	{
+		.pa_start	= 0x48088000,
+		.pa_end		= 0x48088000 + SZ_1K - 1,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+
+/* l4_core -> timer11 */
+static struct omap_hwmod_ocp_if omap3xxx_l4_core__timer11 = {
+	.master		= &omap3xxx_l4_core_hwmod,
+	.slave		= &omap3xxx_timer11_hwmod,
+	.clk		= "gpt11_ick",
+	.addr		= omap3xxx_timer11_addrs,
+	.addr_cnt	= ARRAY_SIZE(omap3xxx_timer11_addrs),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* timer11 master port */
+static struct omap_hwmod_ocp_if *omap3xxx_timer11_masters[] = {
+	&omap3xxx_l4_core__timer11,
+};
+
+/* timer11 slave port */
+static struct omap_hwmod_ocp_if *omap3xxx_timer11_slaves[] = {
+	&omap3xxx_l4_core__timer11,
+};
+
+/* timer11 hwmod */
+static struct omap_hwmod omap3xxx_timer11_hwmod = {
+	.name		= "timer11",
+	.mpu_irqs	= omap3xxx_timer11_mpu_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap3xxx_timer11_mpu_irqs),
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
+	.masters	= omap3xxx_timer11_masters,
+	.masters_cnt	= ARRAY_SIZE(omap3xxx_timer11_masters),
+	.slaves		= omap3xxx_timer11_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap3xxx_timer11_slaves),
+	.class		= &omap3xxx_timer_hwmod_class,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
+};
+
 /* L4 CORE */
 static struct omap_hwmod omap3xxx_l4_core_hwmod = {
 	.name		= "l4_core",
@@ -112,6 +259,462 @@ static struct omap_hwmod omap3xxx_l4_core_hwmod = {
 	.flags		= HWMOD_NO_IDLEST,
 };
 
+/* timer2 */
+static struct omap_hwmod omap3xxx_timer2_hwmod;
+static struct omap_hwmod_irq_info omap3xxx_timer2_mpu_irqs[] = {
+	{ .irq = INT_24XX_GPTIMER2, },
+};
+
+static struct omap_hwmod_addr_space omap3xxx_timer2_addrs[] = {
+	{
+		.pa_start	= 0x49032000,
+		.pa_end		= 0x49032000 + SZ_1K - 1,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+
+/* l4_per -> timer2 */
+static struct omap_hwmod_ocp_if omap3xxx_l4_per__timer2 = {
+	.master		= &omap3xxx_l4_per_hwmod,
+	.slave		= &omap3xxx_timer2_hwmod,
+	.clk		= "gpt2_ick",
+	.addr		= omap3xxx_timer2_addrs,
+	.addr_cnt	= ARRAY_SIZE(omap3xxx_timer2_addrs),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* timer2 master port */
+static struct omap_hwmod_ocp_if *omap3xxx_timer2_masters[] = {
+	&omap3xxx_l4_per__timer2,
+};
+
+/* timer2 slave port */
+static struct omap_hwmod_ocp_if *omap3xxx_timer2_slaves[] = {
+	&omap3xxx_l4_per__timer2,
+};
+
+/* timer2 hwmod */
+static struct omap_hwmod omap3xxx_timer2_hwmod = {
+	.name		= "timer2",
+	.mpu_irqs	= omap3xxx_timer2_mpu_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap3xxx_timer2_mpu_irqs),
+	.main_clk	= "gpt2_fck",
+	.prcm		= {
+		.omap2 = {
+			.prcm_reg_id = 1,
+			.module_bit = OMAP3430_EN_GPT2_SHIFT,
+			.module_offs = OMAP3430_PER_MOD,
+			.idlest_reg_id = 1,
+			.idlest_idle_bit = OMAP3430_EN_GPT2_SHIFT,
+		},
+	},
+	.masters	= omap3xxx_timer2_masters,
+	.masters_cnt	= ARRAY_SIZE(omap3xxx_timer2_masters),
+	.slaves		= omap3xxx_timer2_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap3xxx_timer2_slaves),
+	.class		= &omap3xxx_timer_1ms_hwmod_class,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
+};
+
+
+/* timer3 */
+static struct omap_hwmod omap3xxx_timer3_hwmod;
+static struct omap_hwmod_irq_info omap3xxx_timer3_mpu_irqs[] = {
+	{ .irq = INT_24XX_GPTIMER3, },
+};
+
+static struct omap_hwmod_addr_space omap3xxx_timer3_addrs[] = {
+	{
+		.pa_start	= 0x49034000,
+		.pa_end		= 0x49034000 + SZ_1K - 1,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+
+/* l4_per -> timer3 */
+static struct omap_hwmod_ocp_if omap3xxx_l4_per__timer3 = {
+	.master		= &omap3xxx_l4_per_hwmod,
+	.slave		= &omap3xxx_timer3_hwmod,
+	.clk		= "gpt3_ick",
+	.addr		= omap3xxx_timer3_addrs,
+	.addr_cnt	= ARRAY_SIZE(omap3xxx_timer3_addrs),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+/* timer3 master port */
+static struct omap_hwmod_ocp_if *omap3xxx_timer3_masters[] = {
+	&omap3xxx_l4_per__timer3,
+};
+
+/* timer3 slave port */
+static struct omap_hwmod_ocp_if *omap3xxx_timer3_slaves[] = {
+	&omap3xxx_l4_per__timer3,
+};
+
+/* timer3 hwmod */
+static struct omap_hwmod omap3xxx_timer3_hwmod = {
+	.name		= "timer3",
+	.mpu_irqs	= omap3xxx_timer3_mpu_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap3xxx_timer3_mpu_irqs),
+	.main_clk	= "gpt3_fck",
+	.prcm		= {
+		.omap2 = {
+			.prcm_reg_id = 1,
+			.module_bit = OMAP3430_EN_GPT3_SHIFT,
+			.module_offs = OMAP3430_PER_MOD,
+			.idlest_reg_id = 1,
+			.idlest_idle_bit = OMAP3430_EN_GPT3_SHIFT,
+		},
+	},
+	.masters	= omap3xxx_timer3_masters,
+	.masters_cnt	= ARRAY_SIZE(omap3xxx_timer3_masters),
+	.slaves		= omap3xxx_timer3_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap3xxx_timer3_slaves),
+	.class		= &omap3xxx_timer_hwmod_class,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
+};
+
+/* timer4 */
+static struct omap_hwmod omap3xxx_timer4_hwmod;
+static struct omap_hwmod_irq_info omap3xxx_timer4_mpu_irqs[] = {
+	{ .irq = INT_24XX_GPTIMER4, },
+};
+
+static struct omap_hwmod_addr_space omap3xxx_timer4_addrs[] = {
+	{
+		.pa_start	= 0x49036000,
+		.pa_end		= 0x49036000 + SZ_1K - 1,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+
+/* l4_per -> timer4 */
+static struct omap_hwmod_ocp_if omap3xxx_l4_per__timer4 = {
+	.master		= &omap3xxx_l4_per_hwmod,
+	.slave		= &omap3xxx_timer4_hwmod,
+	.clk		= "gpt4_ick",
+	.addr		= omap3xxx_timer4_addrs,
+	.addr_cnt	= ARRAY_SIZE(omap3xxx_timer4_addrs),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* timer4 master port */
+static struct omap_hwmod_ocp_if *omap3xxx_timer4_masters[] = {
+	&omap3xxx_l4_per__timer4,
+};
+
+/* timer4 slave port */
+static struct omap_hwmod_ocp_if *omap3xxx_timer4_slaves[] = {
+	&omap3xxx_l4_per__timer4,
+};
+
+/* timer4 hwmod */
+static struct omap_hwmod omap3xxx_timer4_hwmod = {
+	.name		= "timer4",
+	.mpu_irqs	= omap3xxx_timer4_mpu_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap3xxx_timer4_mpu_irqs),
+	.main_clk	= "gpt4_fck",
+	.prcm		= {
+		.omap2 = {
+			.prcm_reg_id = 1,
+			.module_bit = OMAP3430_EN_GPT4_SHIFT,
+			.module_offs = OMAP3430_PER_MOD,
+			.idlest_reg_id = 1,
+			.idlest_idle_bit = OMAP3430_EN_GPT4_SHIFT,
+		},
+	},
+	.masters	= omap3xxx_timer4_masters,
+	.masters_cnt	= ARRAY_SIZE(omap3xxx_timer4_masters),
+	.slaves		= omap3xxx_timer4_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap3xxx_timer4_slaves),
+	.class		= &omap3xxx_timer_hwmod_class,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
+};
+
+/* timer5 */
+static struct omap_hwmod omap3xxx_timer5_hwmod;
+static struct omap_hwmod_irq_info omap3xxx_timer5_mpu_irqs[] = {
+	{ .irq = INT_24XX_GPTIMER5, },
+};
+
+static struct omap_hwmod_addr_space omap3xxx_timer5_addrs[] = {
+	{
+		.pa_start	= 0x49038000,
+		.pa_end		= 0x49038000 + SZ_1K - 1,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+
+/* l4_per -> timer5 */
+static struct omap_hwmod_ocp_if omap3xxx_l4_per__timer5 = {
+	.master		= &omap3xxx_l4_per_hwmod,
+	.slave		= &omap3xxx_timer5_hwmod,
+	.clk		= "gpt5_ick",
+	.addr		= omap3xxx_timer5_addrs,
+	.addr_cnt	= ARRAY_SIZE(omap3xxx_timer5_addrs),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* timer5 master port */
+static struct omap_hwmod_ocp_if *omap3xxx_timer5_masters[] = {
+	&omap3xxx_l4_per__timer5,
+};
+
+/* timer5 slave port */
+static struct omap_hwmod_ocp_if *omap3xxx_timer5_slaves[] = {
+	&omap3xxx_l4_per__timer5,
+};
+
+/* timer5 hwmod */
+static struct omap_hwmod omap3xxx_timer5_hwmod = {
+	.name		= "timer5",
+	.mpu_irqs	= omap3xxx_timer5_mpu_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap3xxx_timer5_mpu_irqs),
+	.main_clk	= "gpt5_fck",
+	.prcm		= {
+		.omap2 = {
+			.prcm_reg_id = 1,
+			.module_bit = OMAP3430_EN_GPT5_SHIFT,
+			.module_offs = OMAP3430_PER_MOD,
+			.idlest_reg_id = 1,
+			.idlest_idle_bit = OMAP3430_EN_GPT5_SHIFT,
+		},
+	},
+	.masters	= omap3xxx_timer5_masters,
+	.masters_cnt	= ARRAY_SIZE(omap3xxx_timer5_masters),
+	.slaves		= omap3xxx_timer5_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap3xxx_timer5_slaves),
+	.class		= &omap3xxx_timer_hwmod_class,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
+};
+
+/* timer6 */
+static struct omap_hwmod omap3xxx_timer6_hwmod;
+static struct omap_hwmod_irq_info omap3xxx_timer6_mpu_irqs[] = {
+	{ .irq = INT_24XX_GPTIMER6, },
+};
+
+static struct omap_hwmod_addr_space omap3xxx_timer6_addrs[] = {
+	{
+		.pa_start	= 0x4903A000,
+		.pa_end		= 0x4903A000 + SZ_1K - 1,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+
+/* l4_per -> timer6 */
+static struct omap_hwmod_ocp_if omap3xxx_l4_per__timer6 = {
+	.master		= &omap3xxx_l4_per_hwmod,
+	.slave		= &omap3xxx_timer6_hwmod,
+	.clk		= "gpt6_ick",
+	.addr		= omap3xxx_timer6_addrs,
+	.addr_cnt	= ARRAY_SIZE(omap3xxx_timer6_addrs),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* timer6 master port */
+static struct omap_hwmod_ocp_if *omap3xxx_timer6_masters[] = {
+	&omap3xxx_l4_per__timer6,
+};
+/* timer6 slave port */
+static struct omap_hwmod_ocp_if *omap3xxx_timer6_slaves[] = {
+	&omap3xxx_l4_per__timer6,
+};
+
+/* timer6 hwmod */
+static struct omap_hwmod omap3xxx_timer6_hwmod = {
+	.name		= "timer6",
+	.mpu_irqs	= omap3xxx_timer6_mpu_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap3xxx_timer6_mpu_irqs),
+	.main_clk	= "gpt6_fck",
+	.prcm		= {
+		.omap2 = {
+			.prcm_reg_id = 1,
+			.module_bit = OMAP3430_EN_GPT6_SHIFT,
+			.module_offs = OMAP3430_PER_MOD,
+			.idlest_reg_id = 1,
+			.idlest_idle_bit = OMAP3430_EN_GPT6_SHIFT,
+		},
+	},
+	.masters	= omap3xxx_timer6_masters,
+	.masters_cnt	= ARRAY_SIZE(omap3xxx_timer6_masters),
+	.slaves		= omap3xxx_timer6_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap3xxx_timer6_slaves),
+	.class		= &omap3xxx_timer_hwmod_class,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
+};
+
+/* timer7 */
+static struct omap_hwmod omap3xxx_timer7_hwmod;
+static struct omap_hwmod_irq_info omap3xxx_timer7_mpu_irqs[] = {
+	{ .irq = INT_24XX_GPTIMER7, },
+};
+
+static struct omap_hwmod_addr_space omap3xxx_timer7_addrs[] = {
+	{
+		.pa_start	= 0x4903C000,
+		.pa_end		= 0x4903C000 + SZ_1K - 1,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+
+/* l4_per -> timer7 */
+static struct omap_hwmod_ocp_if omap3xxx_l4_per__timer7 = {
+	.master		= &omap3xxx_l4_per_hwmod,
+	.slave		= &omap3xxx_timer7_hwmod,
+	.clk		= "gpt7_ick",
+	.addr		= omap3xxx_timer7_addrs,
+	.addr_cnt	= ARRAY_SIZE(omap3xxx_timer7_addrs),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* timer7 master port */
+static struct omap_hwmod_ocp_if *omap3xxx_timer7_masters[] = {
+	&omap3xxx_l4_per__timer7,
+};
+
+/* timer7 slave port */
+static struct omap_hwmod_ocp_if *omap3xxx_timer7_slaves[] = {
+	&omap3xxx_l4_per__timer7,
+};
+
+/* timer7 hwmod */
+static struct omap_hwmod omap3xxx_timer7_hwmod = {
+	.name		= "timer7",
+	.mpu_irqs	= omap3xxx_timer7_mpu_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap3xxx_timer7_mpu_irqs),
+	.main_clk	= "gpt7_fck",
+	.prcm		= {
+		.omap2 = {
+			.prcm_reg_id = 1,
+			.module_bit = OMAP3430_EN_GPT7_SHIFT,
+			.module_offs = OMAP3430_PER_MOD,
+			.idlest_reg_id = 1,
+			.idlest_idle_bit = OMAP3430_EN_GPT7_SHIFT,
+		},
+	},
+	.masters	= omap3xxx_timer7_masters,
+	.masters_cnt	= ARRAY_SIZE(omap3xxx_timer7_masters),
+	.slaves		= omap3xxx_timer7_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap3xxx_timer7_slaves),
+	.class		= &omap3xxx_timer_hwmod_class,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
+};
+
+/* timer8 */
+static struct omap_hwmod omap3xxx_timer8_hwmod;
+static struct omap_hwmod_irq_info omap3xxx_timer8_mpu_irqs[] = {
+	{ .irq = INT_24XX_GPTIMER8, },
+};
+
+static struct omap_hwmod_addr_space omap3xxx_timer8_addrs[] = {
+	{
+		.pa_start	= 0x4903E000,
+		.pa_end		= 0x4903E000 + SZ_1K - 1,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+
+/* l4_per -> timer8 */
+static struct omap_hwmod_ocp_if omap3xxx_l4_per__timer8 = {
+	.master		= &omap3xxx_l4_per_hwmod,
+	.slave		= &omap3xxx_timer8_hwmod,
+	.clk		= "gpt8_ick",
+	.addr		= omap3xxx_timer8_addrs,
+	.addr_cnt	= ARRAY_SIZE(omap3xxx_timer8_addrs),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* timer8 master port */
+static struct omap_hwmod_ocp_if *omap3xxx_timer8_masters[] = {
+	&omap3xxx_l4_per__timer8,
+};
+
+/* timer8 slave port */
+static struct omap_hwmod_ocp_if *omap3xxx_timer8_slaves[] = {
+	&omap3xxx_l4_per__timer8,
+};
+
+/* timer8 hwmod */
+static struct omap_hwmod omap3xxx_timer8_hwmod = {
+	.name		= "timer8",
+	.mpu_irqs	= omap3xxx_timer8_mpu_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap3xxx_timer8_mpu_irqs),
+	.main_clk	= "gpt8_fck",
+	.prcm		= {
+		.omap2 = {
+			.prcm_reg_id = 1,
+			.module_bit = OMAP3430_EN_GPT8_SHIFT,
+			.module_offs = OMAP3430_PER_MOD,
+			.idlest_reg_id = 1,
+			.idlest_idle_bit = OMAP3430_EN_GPT8_SHIFT,
+		},
+	},
+	.masters	= omap3xxx_timer8_masters,
+	.masters_cnt	= ARRAY_SIZE(omap3xxx_timer8_masters),
+	.slaves		= omap3xxx_timer8_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap3xxx_timer8_slaves),
+	.class		= &omap3xxx_timer_hwmod_class,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
+};
+
+
+/* timer9 */
+static struct omap_hwmod omap3xxx_timer9_hwmod;
+static struct omap_hwmod_irq_info omap3xxx_timer9_mpu_irqs[] = {
+	{ .irq = INT_24XX_GPTIMER9, },
+};
+
+static struct omap_hwmod_addr_space omap3xxx_timer9_addrs[] = {
+	{
+		.pa_start	= 0x49040000,
+		.pa_end		= 0x49040000 + SZ_1K - 1,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+
+/* l4_per -> timer9 */
+static struct omap_hwmod_ocp_if omap3xxx_l4_per__timer9 = {
+	.master		= &omap3xxx_l4_per_hwmod,
+	.slave		= &omap3xxx_timer9_hwmod,
+	.clk		= "gpt9_ick",
+	.addr		= omap3xxx_timer9_addrs,
+	.addr_cnt	= ARRAY_SIZE(omap3xxx_timer9_addrs),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* timer9 master port */
+static struct omap_hwmod_ocp_if *omap3xxx_timer9_masters[] = {
+	&omap3xxx_l4_per__timer9,
+};
+
+/* timer9 slave port */
+static struct omap_hwmod_ocp_if *omap3xxx_timer9_slaves[] = {
+	&omap3xxx_l4_per__timer9,
+};
+
+/* timer9 hwmod */
+static struct omap_hwmod omap3xxx_timer9_hwmod = {
+	.name		= "timer9",
+	.mpu_irqs	= omap3xxx_timer9_mpu_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap3xxx_timer9_mpu_irqs),
+	.main_clk	= "gpt9_fck",
+	.prcm		= {
+		.omap2 = {
+			.prcm_reg_id = 1,
+			.module_bit = OMAP3430_EN_GPT9_SHIFT,
+			.module_offs = OMAP3430_PER_MOD,
+			.idlest_reg_id = 1,
+			.idlest_idle_bit = OMAP3430_EN_GPT9_SHIFT,
+		},
+	},
+	.masters	= omap3xxx_timer9_masters,
+	.masters_cnt	= ARRAY_SIZE(omap3xxx_timer9_masters),
+	.slaves		= omap3xxx_timer9_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap3xxx_timer9_slaves),
+	.class		= &omap3xxx_timer_hwmod_class,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
+};
+
 /* Slave interfaces on the L4_PER interconnect */
 static struct omap_hwmod_ocp_if *omap3xxx_l4_per_slaves[] = {
 	&omap3xxx_l3_main__l4_per,
@@ -133,6 +736,63 @@ static struct omap_hwmod omap3xxx_l4_per_hwmod = {
 	.flags		= HWMOD_NO_IDLEST,
 };
 
+/* timer1 */
+static struct omap_hwmod omap3xxx_timer1_hwmod;
+static struct omap_hwmod_irq_info omap3xxx_timer1_mpu_irqs[] = {
+	{ .irq = INT_24XX_GPTIMER1, },
+};
+
+static struct omap_hwmod_addr_space omap3xxx_timer1_addrs[] = {
+	{
+		.pa_start	= 0x48318000,
+		.pa_end		= 0x48318000 + SZ_1K - 1,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+
+/* l4_wkup -> timer1 */
+static struct omap_hwmod_ocp_if omap3xxx_l4_wkup__timer1 = {
+	.master		= &omap3xxx_l4_wkup_hwmod,
+	.slave		= &omap3xxx_timer1_hwmod,
+	.clk		= "gpt1_ick",
+	.addr		= omap3xxx_timer1_addrs,
+	.addr_cnt	= ARRAY_SIZE(omap3xxx_timer1_addrs),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* timer1 master port */
+static struct omap_hwmod_ocp_if *omap3xxx_timer1_masters[] = {
+	&omap3xxx_l4_wkup__timer1,
+};
+
+/* timer1 slave port */
+static struct omap_hwmod_ocp_if *omap3xxx_timer1_slaves[] = {
+	&omap3xxx_l4_wkup__timer1,
+};
+
+/* timer1 hwmod */
+static struct omap_hwmod omap3xxx_timer1_hwmod = {
+	.name		= "timer1",
+	.mpu_irqs	= omap3xxx_timer1_mpu_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap3xxx_timer1_mpu_irqs),
+	.main_clk	= "gpt1_fck",
+	.prcm		= {
+		.omap2 = {
+			.prcm_reg_id = 1,
+			.module_bit = OMAP3430_EN_GPT1_SHIFT,
+			.module_offs = WKUP_MOD,
+			.idlest_reg_id = 1,
+			.idlest_idle_bit = OMAP3430_EN_GPT1_SHIFT,
+		},
+	},
+	.masters	= omap3xxx_timer1_masters,
+	.masters_cnt	= ARRAY_SIZE(omap3xxx_timer1_masters),
+	.slaves		= omap3xxx_timer1_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap3xxx_timer1_slaves),
+	.class		= &omap3xxx_timer_1ms_hwmod_class,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
+};
+
 /* Slave interfaces on the L4_WKUP interconnect */
 static struct omap_hwmod_ocp_if *omap3xxx_l4_wkup_slaves[] = {
 	&omap3xxx_l4_core__l4_wkup,
@@ -204,6 +864,17 @@ static __initdata struct omap_hwmod *omap3xxx_hwmods[] = {
 	&omap3xxx_l4_wkup_hwmod,
 	&omap3xxx_mpu_hwmod,
 	&omap3xxx_iva_hwmod,
+	&omap3xxx_timer1_hwmod,
+	&omap3xxx_timer2_hwmod,
+	&omap3xxx_timer3_hwmod,
+	&omap3xxx_timer4_hwmod,
+	&omap3xxx_timer5_hwmod,
+	&omap3xxx_timer6_hwmod,
+	&omap3xxx_timer7_hwmod,
+	&omap3xxx_timer8_hwmod,
+	&omap3xxx_timer9_hwmod,
+	&omap3xxx_timer10_hwmod,
+	&omap3xxx_timer11_hwmod,
 	NULL,
 };
 
-- 
1.6.0.4


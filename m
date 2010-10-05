From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 2/7] [RFC] OMAP: MCBSP: hwmod database for 3xxx devices
Date: Tue,  5 Oct 2010 22:07:37 +0530
Message-ID: <1286296662-7639-2-git-send-email-kishon@ti.com>
References: <1286296662-7639-1-git-send-email-kishon@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:45609 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752070Ab0JEQjs (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 5 Oct 2010 12:39:48 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id o95GdjO2006494
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 5 Oct 2010 11:39:47 -0500
In-Reply-To: <1286296662-7639-1-git-send-email-kishon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: nskamat@ti.com, Charulatha V <charu@ti.com>, Kishon Vijay Abraham I <kishon@ti.com>, Shubhrajyoti D <shubhrajyoti@ti.com>, Partha Basak <p-basak2@ti.com>

From: Charulatha V <charu@ti.com>

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Charulatha V <charu@ti.com>
Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
Cc: Partha Basak <p-basak2@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |  426 ++++++++++++++++++++++++++++
 1 files changed, 426 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index cb97ecf..c399783 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -39,6 +39,13 @@ static struct omap_hwmod omap3xxx_l3_main_hwmod;
 static struct omap_hwmod omap3xxx_l4_core_hwmod;
 static struct omap_hwmod omap3xxx_l4_per_hwmod;
 static struct omap_hwmod omap3xxx_wd_timer2_hwmod;
+static struct omap_hwmod omap3xxx_mcbsp1_hwmod;
+static struct omap_hwmod omap3xxx_mcbsp2_hwmod;
+static struct omap_hwmod omap3xxx_mcbsp3_hwmod;
+static struct omap_hwmod omap3xxx_mcbsp4_hwmod;
+static struct omap_hwmod omap3xxx_mcbsp5_hwmod;
+static struct omap_hwmod omap3xxx_mcbsp2_sidetone_hwmod;
+static struct omap_hwmod omap3xxx_mcbsp3_sidetone_hwmod;
 
 /* L3 -> L4_CORE interface */
 static struct omap_hwmod_ocp_if omap3xxx_l3_main__l4_core = {
@@ -509,6 +516,418 @@ static struct omap_hwmod omap3xxx_uart4_hwmod = {
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3630ES1),
 };
 
+/*
+ * 'mcbsp' class
+ * multi channel buffered serial port controller
+ */
+
+static struct omap_hwmod_class_sysconfig omap3xxx_mcbsp_sysc = {
+	.sysc_offs	= 0x008c,
+	.sysc_flags	= (SYSC_HAS_ENAWAKEUP | SYSC_HAS_SIDLEMODE |
+			   SYSC_HAS_CLOCKACTIVITY | SYSC_HAS_SOFTRESET),
+	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
+	.sysc_fields	= &omap_hwmod_sysc_type1,
+	.clockact	= 0x2,
+};
+
+static struct omap_hwmod_class omap3xxx_mcbsp_hwmod_class = {
+	.name = "mcbsp",
+	.sysc = &omap3xxx_mcbsp_sysc,
+};
+
+/* mcbsp1 */
+static struct omap_hwmod_irq_info omap3xxx_mcbsp1_irqs[] = {
+	{ .name = "irq", .irq = 16 },
+	{ .name = "tx", .irq = 59 },
+	{ .name = "rx", .irq = 60 },
+};
+
+static struct omap_hwmod_dma_info omap3xxx_mcbsp1_sdma_chs[] = {
+	{ .name = "rx", .dma_req = 32 },
+	{ .name = "tx", .dma_req = 31 },
+};
+
+static struct omap_hwmod_addr_space omap3xxx_mcbsp1_addrs[] = {
+	{
+		.pa_start	= 0x48074000,
+		.pa_end		= 0x480740ff,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+
+/* l4_core -> mcbsp1 */
+static struct omap_hwmod_ocp_if omap3xxx_l4_core__mcbsp1 = {
+	.master		= &omap3xxx_l4_core_hwmod,
+	.slave		= &omap3xxx_mcbsp1_hwmod,
+	.clk		= "mcbsp1_ick",
+	.addr		= omap3xxx_mcbsp1_addrs,
+	.addr_cnt	= ARRAY_SIZE(omap3xxx_mcbsp1_addrs),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* mcbsp1 slave ports */
+static struct omap_hwmod_ocp_if *omap3xxx_mcbsp1_slaves[] = {
+	&omap3xxx_l4_core__mcbsp1,
+};
+
+static struct omap_hwmod omap3xxx_mcbsp1_hwmod = {
+	.name		= "mcbsp1",
+	.class		= &omap3xxx_mcbsp_hwmod_class,
+	.mpu_irqs	= omap3xxx_mcbsp1_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap3xxx_mcbsp1_irqs),
+	.sdma_reqs	= omap3xxx_mcbsp1_sdma_chs,
+	.sdma_reqs_cnt	= ARRAY_SIZE(omap3xxx_mcbsp1_sdma_chs),
+	.main_clk	= "mcbsp1_fck",
+	.prcm		= {
+		.omap2 = {
+			.prcm_reg_id = 1,
+			.module_bit = OMAP3430_EN_MCBSP1_SHIFT,
+			.module_offs = CORE_MOD,
+			.idlest_reg_id = 1,
+			.idlest_idle_bit = OMAP3430_EN_MCBSP1_SHIFT,
+		},
+	},
+	.slaves		= omap3xxx_mcbsp1_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap3xxx_mcbsp1_slaves),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+};
+
+/* mcbsp2 */
+static struct omap_hwmod_irq_info omap3xxx_mcbsp2_irqs[] = {
+	{ .name = "irq", .irq = 17 },
+	{ .name = "tx", .irq = 62 },
+	{ .name = "rx", .irq = 63 },
+};
+
+static struct omap_hwmod_dma_info omap3xxx_mcbsp2_sdma_chs[] = {
+	{ .name = "rx", .dma_req = 34 },
+	{ .name = "tx", .dma_req = 33 },
+};
+
+static struct omap_hwmod_addr_space omap3xxx_mcbsp2_addrs[] = {
+	{
+		.pa_start	= 0x49022000,
+		.pa_end		= 0x490220ff,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+
+/* l4_per -> mcbsp2 */
+static struct omap_hwmod_ocp_if omap3xxx_l4_per__mcbsp2 = {
+	.master		= &omap3xxx_l4_per_hwmod,
+	.slave		= &omap3xxx_mcbsp2_hwmod,
+	.clk		= "mcbsp2_ick",
+	.addr		= omap3xxx_mcbsp2_addrs,
+	.addr_cnt	= ARRAY_SIZE(omap3xxx_mcbsp2_addrs),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* mcbsp2 slave ports */
+static struct omap_hwmod_ocp_if *omap3xxx_mcbsp2_slaves[] = {
+	&omap3xxx_l4_per__mcbsp2,
+};
+
+static struct omap_hwmod omap3xxx_mcbsp2_hwmod = {
+	.name		= "mcbsp2",
+	.class		= &omap3xxx_mcbsp_hwmod_class,
+	.mpu_irqs	= omap3xxx_mcbsp2_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap3xxx_mcbsp2_irqs),
+	.sdma_reqs	= omap3xxx_mcbsp2_sdma_chs,
+	.sdma_reqs_cnt	= ARRAY_SIZE(omap3xxx_mcbsp2_sdma_chs),
+	.main_clk	= "mcbsp2_fck",
+	.prcm		= {
+		.omap2 = {
+			.prcm_reg_id = 1,
+			.module_bit = OMAP3430_EN_MCBSP2_SHIFT,
+			.module_offs = OMAP3430_PER_MOD,
+			.idlest_reg_id = 1,
+			.idlest_idle_bit = OMAP3430_EN_MCBSP2_SHIFT,
+		},
+	},
+	.slaves		= omap3xxx_mcbsp2_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap3xxx_mcbsp2_slaves),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+};
+
+/* mcbsp3 */
+static struct omap_hwmod_irq_info omap3xxx_mcbsp3_irqs[] = {
+	{ .name = "irq", .irq = 22 },
+	{ .name = "tx", .irq = 89 },
+	{ .name = "rx", .irq = 90 },
+};
+
+static struct omap_hwmod_dma_info omap3xxx_mcbsp3_sdma_chs[] = {
+	{ .name = "rx", .dma_req = 18 },
+	{ .name = "tx", .dma_req = 17 },
+};
+
+static struct omap_hwmod_addr_space omap3xxx_mcbsp3_addrs[] = {
+	{
+		.pa_start	= 0x49024000,
+		.pa_end		= 0x490240ff,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+
+/* l4_per -> mcbsp3 */
+static struct omap_hwmod_ocp_if omap3xxx_l4_per__mcbsp3 = {
+	.master		= &omap3xxx_l4_per_hwmod,
+	.slave		= &omap3xxx_mcbsp3_hwmod,
+	.clk		= "mcbsp3_ick",
+	.addr		= omap3xxx_mcbsp3_addrs,
+	.addr_cnt	= ARRAY_SIZE(omap3xxx_mcbsp3_addrs),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* mcbsp3 slave ports */
+static struct omap_hwmod_ocp_if *omap3xxx_mcbsp3_slaves[] = {
+	&omap3xxx_l4_per__mcbsp3,
+};
+
+static struct omap_hwmod omap3xxx_mcbsp3_hwmod = {
+	.name		= "mcbsp3",
+	.class		= &omap3xxx_mcbsp_hwmod_class,
+	.mpu_irqs	= omap3xxx_mcbsp3_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap3xxx_mcbsp3_irqs),
+	.sdma_reqs	= omap3xxx_mcbsp3_sdma_chs,
+	.sdma_reqs_cnt	= ARRAY_SIZE(omap3xxx_mcbsp3_sdma_chs),
+	.main_clk	= "mcbsp3_fck",
+	.prcm		= {
+		.omap2 = {
+			.prcm_reg_id = 1,
+			.module_bit = OMAP3430_EN_MCBSP3_SHIFT,
+			.module_offs = OMAP3430_PER_MOD,
+			.idlest_reg_id = 1,
+			.idlest_idle_bit = OMAP3430_EN_MCBSP3_SHIFT,
+		},
+	},
+	.slaves		= omap3xxx_mcbsp3_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap3xxx_mcbsp3_slaves),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+};
+
+/* mcbsp4 */
+static struct omap_hwmod_irq_info omap3xxx_mcbsp4_irqs[] = {
+	{ .name = "irq", .irq = 23 },
+	{ .name = "tx", .irq = 54 },
+	{ .name = "rx", .irq = 55 },
+};
+
+static struct omap_hwmod_dma_info omap3xxx_mcbsp4_sdma_chs[] = {
+	{ .name = "rx", .dma_req = 20 },
+	{ .name = "tx", .dma_req = 19 },
+};
+
+static struct omap_hwmod_addr_space omap3xxx_mcbsp4_addrs[] = {
+	{
+		.pa_start	= 0x49026000,
+		.pa_end		= 0x490260ff,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+
+/* l4_per -> mcbsp4 */
+static struct omap_hwmod_ocp_if omap3xxx_l4_per__mcbsp4 = {
+	.master		= &omap3xxx_l4_per_hwmod,
+	.slave		= &omap3xxx_mcbsp4_hwmod,
+	.clk		= "mcbsp4_ick",
+	.addr		= omap3xxx_mcbsp4_addrs,
+	.addr_cnt	= ARRAY_SIZE(omap3xxx_mcbsp4_addrs),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* mcbsp4 slave ports */
+static struct omap_hwmod_ocp_if *omap3xxx_mcbsp4_slaves[] = {
+	&omap3xxx_l4_per__mcbsp4,
+};
+
+static struct omap_hwmod omap3xxx_mcbsp4_hwmod = {
+	.name		= "mcbsp4",
+	.class		= &omap3xxx_mcbsp_hwmod_class,
+	.mpu_irqs	= omap3xxx_mcbsp4_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap3xxx_mcbsp4_irqs),
+	.sdma_reqs	= omap3xxx_mcbsp4_sdma_chs,
+	.sdma_reqs_cnt	= ARRAY_SIZE(omap3xxx_mcbsp4_sdma_chs),
+	.main_clk	= "mcbsp4_fck",
+	.prcm		= {
+		.omap2 = {
+			.prcm_reg_id = 1,
+			.module_bit = OMAP3430_EN_MCBSP4_SHIFT,
+			.module_offs = OMAP3430_PER_MOD,
+			.idlest_reg_id = 1,
+			.idlest_idle_bit = OMAP3430_EN_MCBSP4_SHIFT,
+		},
+	},
+	.slaves		= omap3xxx_mcbsp4_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap3xxx_mcbsp4_slaves),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+};
+
+/* mcbsp5 */
+static struct omap_hwmod_irq_info omap3xxx_mcbsp5_irqs[] = {
+	{ .name = "irq", .irq = 27 },
+	{ .name = "tx", .irq = 81 },
+	{ .name = "rx", .irq = 82 },
+};
+
+static struct omap_hwmod_dma_info omap3xxx_mcbsp5_sdma_chs[] = {
+	{ .name = "rx", .dma_req = 22 },
+	{ .name = "tx", .dma_req = 21 },
+};
+
+static struct omap_hwmod_addr_space omap3xxx_mcbsp5_addrs[] = {
+	{
+		.pa_start	= 0x48096000,
+		.pa_end		= 0x480960ff,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+
+/* l4_core -> mcbsp5 */
+static struct omap_hwmod_ocp_if omap3xxx_l4_core__mcbsp5 = {
+	.master		= &omap3xxx_l4_core_hwmod,
+	.slave		= &omap3xxx_mcbsp5_hwmod,
+	.clk		= "mcbsp5_ick",
+	.addr		= omap3xxx_mcbsp5_addrs,
+	.addr_cnt	= ARRAY_SIZE(omap3xxx_mcbsp5_addrs),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* mcbsp5 slave ports */
+static struct omap_hwmod_ocp_if *omap3xxx_mcbsp5_slaves[] = {
+	&omap3xxx_l4_core__mcbsp5,
+};
+
+static struct omap_hwmod omap3xxx_mcbsp5_hwmod = {
+	.name		= "mcbsp5",
+	.class		= &omap3xxx_mcbsp_hwmod_class,
+	.mpu_irqs	= omap3xxx_mcbsp5_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap3xxx_mcbsp5_irqs),
+	.sdma_reqs	= omap3xxx_mcbsp5_sdma_chs,
+	.sdma_reqs_cnt	= ARRAY_SIZE(omap3xxx_mcbsp5_sdma_chs),
+	.main_clk	= "mcbsp5_fck",
+	.prcm		= {
+		.omap2 = {
+			.prcm_reg_id = 1,
+			.module_bit = OMAP3430_EN_MCBSP5_SHIFT,
+			.module_offs = CORE_MOD,
+			.idlest_reg_id = 1,
+			.idlest_idle_bit = OMAP3430_EN_MCBSP5_SHIFT,
+		},
+	},
+	.slaves		= omap3xxx_mcbsp5_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap3xxx_mcbsp5_slaves),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+};
+/* 'mcbsp sidetone' class */
+
+static struct omap_hwmod_class_sysconfig omap3xxx_mcbsp_sidetone_sysc = {
+	.sysc_offs	= 0x0010,
+	.sysc_flags	= SYSC_HAS_AUTOIDLE,
+	.sysc_fields	= &omap_hwmod_sysc_type1,
+};
+
+static struct omap_hwmod_class omap3xxx_mcbsp_sidetone_hwmod_class = {
+	.name = "mcbsp_sidetone",
+	.sysc = &omap3xxx_mcbsp_sidetone_sysc,
+};
+
+/* mcbsp2_sidetone */
+static struct omap_hwmod_irq_info omap3xxx_mcbsp2_sidetone_irqs[] = {
+	{ .name = "irq", .irq = 4 },
+};
+
+static struct omap_hwmod_addr_space omap3xxx_mcbsp2_sidetone_addrs[] = {
+	{
+		.pa_start	= 0x49028000,
+		.pa_end		= 0x490280ff,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+
+/* l4_per -> mcbsp2_sidetone */
+static struct omap_hwmod_ocp_if omap3xxx_l4_per__mcbsp2_sidetone = {
+	.master		= &omap3xxx_l4_per_hwmod,
+	.slave		= &omap3xxx_mcbsp2_sidetone_hwmod,
+	.clk		= "mcbsp2_ick",
+	.addr		= omap3xxx_mcbsp2_sidetone_addrs,
+	.addr_cnt	= ARRAY_SIZE(omap3xxx_mcbsp2_sidetone_addrs),
+	.user		= OCP_USER_MPU,
+};
+
+/* mcbsp2_sidetone slave ports */
+static struct omap_hwmod_ocp_if *omap3xxx_mcbsp2_sidetone_slaves[] = {
+	&omap3xxx_l4_per__mcbsp2_sidetone,
+};
+
+static struct omap_hwmod omap3xxx_mcbsp2_sidetone_hwmod = {
+	.name		= "mcbsp2_sidetone",
+	.class		= &omap3xxx_mcbsp_sidetone_hwmod_class,
+	.mpu_irqs	= omap3xxx_mcbsp2_sidetone_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap3xxx_mcbsp2_sidetone_irqs),
+	.main_clk	= "mcbsp2_fck",
+	.prcm		= {
+		.omap2 = {
+			.prcm_reg_id = 1,
+			 .module_bit = OMAP3430_EN_MCBSP2_SHIFT,
+			.module_offs = OMAP3430_PER_MOD,
+			.idlest_reg_id = 1,
+			.idlest_idle_bit = OMAP3430_EN_MCBSP2_SHIFT,
+		},
+	},
+	.slaves		= omap3xxx_mcbsp2_sidetone_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap3xxx_mcbsp2_sidetone_slaves),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+};
+
+/* mcbsp3_sidetone */
+static struct omap_hwmod_irq_info omap3xxx_mcbsp3_sidetone_irqs[] = {
+	{ .name = "irq", .irq = 5 },
+};
+
+static struct omap_hwmod_addr_space omap3xxx_mcbsp3_sidetone_addrs[] = {
+	{
+		.pa_start	= 0x4902A000,
+		.pa_end		= 0x4902A0ff,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+
+/* l4_per -> mcbsp3_sidetone */
+static struct omap_hwmod_ocp_if omap3xxx_l4_per__mcbsp3_sidetone = {
+	.master		= &omap3xxx_l4_per_hwmod,
+	.slave		= &omap3xxx_mcbsp3_sidetone_hwmod,
+	.clk		= "mcbsp3_ick",
+	.addr		= omap3xxx_mcbsp3_sidetone_addrs,
+	.addr_cnt	= ARRAY_SIZE(omap3xxx_mcbsp3_sidetone_addrs),
+	.user		= OCP_USER_MPU,
+};
+
+/* mcbsp3_sidetone slave ports */
+static struct omap_hwmod_ocp_if *omap3xxx_mcbsp3_sidetone_slaves[] = {
+	&omap3xxx_l4_per__mcbsp3_sidetone,
+};
+
+static struct omap_hwmod omap3xxx_mcbsp3_sidetone_hwmod = {
+	.name		= "mcbsp3_sidetone",
+	.class		= &omap3xxx_mcbsp_sidetone_hwmod_class,
+	.mpu_irqs	= omap3xxx_mcbsp3_sidetone_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap3xxx_mcbsp3_sidetone_irqs),
+	.main_clk	= "mcbsp3_fck",
+	.prcm		= {
+		.omap2 = {
+			.prcm_reg_id = 1,
+			.module_bit = OMAP3430_EN_MCBSP3_SHIFT,
+			.module_offs = OMAP3430_PER_MOD,
+			.idlest_reg_id = 1,
+			.idlest_idle_bit = OMAP3430_EN_MCBSP3_SHIFT,
+		},
+	},
+	.slaves		= omap3xxx_mcbsp3_sidetone_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap3xxx_mcbsp3_sidetone_slaves),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+};
+
 static __initdata struct omap_hwmod *omap3xxx_hwmods[] = {
 	&omap3xxx_l3_main_hwmod,
 	&omap3xxx_l4_core_hwmod,
@@ -521,6 +940,13 @@ static __initdata struct omap_hwmod *omap3xxx_hwmods[] = {
 	&omap3xxx_uart2_hwmod,
 	&omap3xxx_uart3_hwmod,
 	&omap3xxx_uart4_hwmod,
+	&omap3xxx_mcbsp1_hwmod,
+	&omap3xxx_mcbsp2_hwmod,
+	&omap3xxx_mcbsp3_hwmod,
+	&omap3xxx_mcbsp4_hwmod,
+	&omap3xxx_mcbsp5_hwmod,
+	&omap3xxx_mcbsp2_sidetone_hwmod,
+	&omap3xxx_mcbsp3_sidetone_hwmod,
 	NULL,
 };
 
-- 
1.7.0.4


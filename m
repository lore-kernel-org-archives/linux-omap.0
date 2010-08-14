From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCHv2 11/13] dmtimer: hwmod: add omap2420 database
Date: Sat, 14 Aug 2010 21:05:18 +0530
Message-ID: <1281800118-15010-1-git-send-email-tarun.kanti@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:45207 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751031Ab0HNEgE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 14 Aug 2010 00:36:04 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Thara Gopinath <thara@ti.com>, Partha Basak <p-basak2@ti.com>, Tarun Kanti DebBarma <tarun.kanti@ti.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@deeprootsystems.com>, Tony Lindgren <tony@atomide.com>

From: Thara Gopinath <thara@ti.com>

This patch adds hwmod database for omap2420.

Signed-off-by: Partha Basak <p-basak2@ti.com>
Signed-off-by: Thara Gopinath <thara@ti.com>
Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/omap_hwmod_2420_data.c |  597 ++++++++++++++++++++++++++++
 1 files changed, 597 insertions(+), 0 deletions(-)
 mode change 100644 => 100755 arch/arm/mach-omap2/omap_hwmod_2420_data.c

diff --git a/arch/arm/mach-omap2/omap_hwmod_2420_data.c b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
old mode 100644
new mode 100755
index 3cc768e..7f87924
--- a/arch/arm/mach-omap2/omap_hwmod_2420_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
@@ -15,6 +15,7 @@
 #include <mach/irqs.h>
 #include <plat/cpu.h>
 #include <plat/dma.h>
+#include <plat/dmtimer.h>
 
 #include "omap_hwmod_common_data.h"
 
@@ -121,6 +122,590 @@ static struct omap_hwmod omap2420_l4_wkup_hwmod = {
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2420),
 	.flags		= HWMOD_NO_IDLEST,
 };
+/* Timer Common */
+static struct omap_hwmod_class_sysconfig omap2420_timer_sysc = {
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
+static struct omap_hwmod_class omap2420_timer_hwmod_class = {
+	.name = "timer",
+	.sysc = &omap2420_timer_sysc,
+	.rev = OMAP_TIMER_IP_LEGACY,
+};
+
+/* timer1 */
+static struct omap_hwmod omap2420_timer1_hwmod;
+static struct omap_hwmod_irq_info omap2420_timer1_mpu_irqs[] = {
+	{ .irq = INT_24XX_GPTIMER1, },
+};
+
+static struct omap_hwmod_addr_space omap2420_timer1_addrs[] = {
+	{
+		.pa_start	= 0x48028000,
+		.pa_end		= 0x48028000 + SZ_1K - 1,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+/* l4_wkup -> timer1 */
+static struct omap_hwmod_ocp_if omap2420_l4_wkup__timer1 = {
+	.master		= &omap2420_l4_wkup_hwmod,
+	.slave		= &omap2420_timer1_hwmod,
+	.clk		= "gpt1_ick",
+	.addr		= omap2420_timer1_addrs,
+	.addr_cnt	= ARRAY_SIZE(omap2420_timer1_addrs),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+/* timer1 slave port */
+static struct omap_hwmod_ocp_if *omap2420_timer1_slaves[] = {
+	&omap2420_l4_wkup__timer1,
+};
+/* timer1 hwmod */
+static struct omap_hwmod omap2420_timer1_hwmod = {
+	.name		= "timer1",
+	.mpu_irqs	= omap2420_timer1_mpu_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap2420_timer1_mpu_irqs),
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
+	.slaves		= omap2420_timer1_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap2420_timer1_slaves),
+	.class		= &omap2420_timer_hwmod_class,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2420)
+};
+
+
+/* timer2 */
+static struct omap_hwmod omap2420_timer2_hwmod;
+static struct omap_hwmod_irq_info omap2420_timer2_mpu_irqs[] = {
+	{ .irq = INT_24XX_GPTIMER2, },
+};
+
+static struct omap_hwmod_addr_space omap2420_timer2_addrs[] = {
+	{
+		.pa_start	= 0x4802a000,
+		.pa_end		= 0x4802a000 + SZ_1K - 1,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+/* l4_core -> timer2 */
+static struct omap_hwmod_ocp_if omap2420_l4_core__timer2 = {
+	.master		= &omap2420_l4_core_hwmod,
+	.slave		= &omap2420_timer2_hwmod,
+	.clk		= "gpt2_ick",
+	.addr		= omap2420_timer2_addrs,
+	.addr_cnt	= ARRAY_SIZE(omap2420_timer2_addrs),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+/* timer2 slave port */
+static struct omap_hwmod_ocp_if *omap2420_timer2_slaves[] = {
+	&omap2420_l4_core__timer2,
+};
+/* timer2 hwmod */
+static struct omap_hwmod omap2420_timer2_hwmod = {
+	.name		= "timer2",
+	.mpu_irqs	= omap2420_timer2_mpu_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap2420_timer2_mpu_irqs),
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
+	.slaves		= omap2420_timer2_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap2420_timer2_slaves),
+	.class		= &omap2420_timer_hwmod_class,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2420)
+};
+
+
+/* timer3 */
+static struct omap_hwmod omap2420_timer3_hwmod;
+static struct omap_hwmod_irq_info omap2420_timer3_mpu_irqs[] = {
+	{ .irq = INT_24XX_GPTIMER3, },
+};
+
+static struct omap_hwmod_addr_space omap2420_timer3_addrs[] = {
+	{
+		.pa_start	= 0x48078000,
+		.pa_end		= 0x48078000 + SZ_1K - 1,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+/* l4_core -> timer3 */
+static struct omap_hwmod_ocp_if omap2420_l4_core__timer3 = {
+	.master		= &omap2420_l4_core_hwmod,
+	.slave		= &omap2420_timer3_hwmod,
+	.clk		= "gpt3_ick",
+	.addr		= omap2420_timer3_addrs,
+	.addr_cnt	= ARRAY_SIZE(omap2420_timer3_addrs),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+/* timer3 slave port */
+static struct omap_hwmod_ocp_if *omap2420_timer3_slaves[] = {
+	&omap2420_l4_core__timer3,
+};
+/* timer3 hwmod */
+static struct omap_hwmod omap2420_timer3_hwmod = {
+	.name		= "timer3",
+	.mpu_irqs	= omap2420_timer3_mpu_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap2420_timer3_mpu_irqs),
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
+	.slaves		= omap2420_timer3_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap2420_timer3_slaves),
+	.class		= &omap2420_timer_hwmod_class,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2420)
+};
+
+/* timer4 */
+static struct omap_hwmod omap2420_timer4_hwmod;
+static struct omap_hwmod_irq_info omap2420_timer4_mpu_irqs[] = {
+	{ .irq = INT_24XX_GPTIMER4, },
+};
+static struct omap_hwmod_addr_space omap2420_timer4_addrs[] = {
+	{
+		.pa_start	= 0x4807a000,
+		.pa_end		= 0x4807a000 + SZ_1K - 1,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+/* l4_core -> timer4 */
+static struct omap_hwmod_ocp_if omap2420_l4_core__timer4 = {
+	.master		= &omap2420_l4_core_hwmod,
+	.slave		= &omap2420_timer4_hwmod,
+	.clk		= "gpt4_ick",
+	.addr		= omap2420_timer4_addrs,
+	.addr_cnt	= ARRAY_SIZE(omap2420_timer4_addrs),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+/* timer4 slave port */
+static struct omap_hwmod_ocp_if *omap2420_timer4_slaves[] = {
+	&omap2420_l4_core__timer4,
+};
+/* timer4 hwmod */
+static struct omap_hwmod omap2420_timer4_hwmod = {
+	.name		= "timer4",
+	.mpu_irqs	= omap2420_timer4_mpu_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap2420_timer4_mpu_irqs),
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
+	.slaves		= omap2420_timer4_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap2420_timer4_slaves),
+	.class		= &omap2420_timer_hwmod_class,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2420)
+};
+
+
+/* timer5 */
+static struct omap_hwmod omap2420_timer5_hwmod;
+static struct omap_hwmod_irq_info omap2420_timer5_mpu_irqs[] = {
+	{ .irq = INT_24XX_GPTIMER5, },
+};
+
+static struct omap_hwmod_addr_space omap2420_timer5_addrs[] = {
+	{
+		.pa_start	= 0x4807c000,
+		.pa_end		= 0x4807c000 + SZ_1K - 1,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+/* l4_core -> timer5 */
+static struct omap_hwmod_ocp_if omap2420_l4_core__timer5 = {
+	.master		= &omap2420_l4_core_hwmod,
+	.slave		= &omap2420_timer5_hwmod,
+	.clk		= "gpt5_ick",
+	.addr		= omap2420_timer5_addrs,
+	.addr_cnt	= ARRAY_SIZE(omap2420_timer5_addrs),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+/* timer5 slave port */
+static struct omap_hwmod_ocp_if *omap2420_timer5_slaves[] = {
+	&omap2420_l4_core__timer5,
+};
+/* timer5 hwmod */
+static struct omap_hwmod omap2420_timer5_hwmod = {
+	.name		= "timer5",
+	.mpu_irqs	= omap2420_timer5_mpu_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap2420_timer5_mpu_irqs),
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
+	.slaves		= omap2420_timer5_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap2420_timer5_slaves),
+	.class		= &omap2420_timer_hwmod_class,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2420)
+};
+
+
+/* timer6 */
+static struct omap_hwmod omap2420_timer6_hwmod;
+static struct omap_hwmod_irq_info omap2420_timer6_mpu_irqs[] = {
+	{ .irq = INT_24XX_GPTIMER6, },
+};
+
+static struct omap_hwmod_addr_space omap2420_timer6_addrs[] = {
+	{
+		.pa_start	= 0x4807e000,
+		.pa_end		= 0x4807e000 + SZ_1K - 1,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+/* l4_core -> timer6 */
+static struct omap_hwmod_ocp_if omap2420_l4_core__timer6 = {
+	.master		= &omap2420_l4_core_hwmod,
+	.slave		= &omap2420_timer6_hwmod,
+	.clk		= "gpt6_ick",
+	.addr		= omap2420_timer6_addrs,
+	.addr_cnt	= ARRAY_SIZE(omap2420_timer6_addrs),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+/* timer6 slave port */
+static struct omap_hwmod_ocp_if *omap2420_timer6_slaves[] = {
+	&omap2420_l4_core__timer6,
+};
+/* timer6 hwmod */
+static struct omap_hwmod omap2420_timer6_hwmod = {
+	.name		= "timer6",
+	.mpu_irqs	= omap2420_timer6_mpu_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap2420_timer6_mpu_irqs),
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
+	.slaves		= omap2420_timer6_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap2420_timer6_slaves),
+	.class		= &omap2420_timer_hwmod_class,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2420)
+};
+
+/* timer7 */
+static struct omap_hwmod omap2420_timer7_hwmod;
+static struct omap_hwmod_irq_info omap2420_timer7_mpu_irqs[] = {
+	{ .irq = INT_24XX_GPTIMER7, },
+};
+
+static struct omap_hwmod_addr_space omap2420_timer7_addrs[] = {
+	{
+		.pa_start	= 0x48080000,
+		.pa_end		= 0x48080000 + SZ_1K - 1,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+/* l4_core -> timer7 */
+static struct omap_hwmod_ocp_if omap2420_l4_core__timer7 = {
+	.master		= &omap2420_l4_core_hwmod,
+	.slave		= &omap2420_timer7_hwmod,
+	.clk		= "gpt7_ick",
+	.addr		= omap2420_timer7_addrs,
+	.addr_cnt	= ARRAY_SIZE(omap2420_timer7_addrs),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+/* timer7 slave port */
+static struct omap_hwmod_ocp_if *omap2420_timer7_slaves[] = {
+	&omap2420_l4_core__timer7,
+};
+/* timer7 hwmod */
+static struct omap_hwmod omap2420_timer7_hwmod = {
+	.name		= "timer7",
+	.mpu_irqs	= omap2420_timer7_mpu_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap2420_timer7_mpu_irqs),
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
+	.slaves		= omap2420_timer7_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap2420_timer7_slaves),
+	.class		= &omap2420_timer_hwmod_class,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2420)
+};
+
+/* timer8 */
+static struct omap_hwmod omap2420_timer8_hwmod;
+static struct omap_hwmod_irq_info omap2420_timer8_mpu_irqs[] = {
+	{ .irq = INT_24XX_GPTIMER8, },
+};
+
+static struct omap_hwmod_addr_space omap2420_timer8_addrs[] = {
+	{
+		.pa_start	= 0x48082000,
+		.pa_end		= 0x48082000 + SZ_1K - 1,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+/* l4_core -> timer8 */
+static struct omap_hwmod_ocp_if omap2420_l4_core__timer8 = {
+	.master		= &omap2420_l4_core_hwmod,
+	.slave		= &omap2420_timer8_hwmod,
+	.clk		= "gpt8_ick",
+	.addr		= omap2420_timer8_addrs,
+	.addr_cnt	= ARRAY_SIZE(omap2420_timer8_addrs),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+/* timer8 slave port */
+static struct omap_hwmod_ocp_if *omap2420_timer8_slaves[] = {
+	&omap2420_l4_core__timer8,
+};
+/* timer8 hwmod */
+static struct omap_hwmod omap2420_timer8_hwmod = {
+	.name		= "timer8",
+	.mpu_irqs	= omap2420_timer8_mpu_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap2420_timer8_mpu_irqs),
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
+	.slaves		= omap2420_timer8_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap2420_timer8_slaves),
+	.class		= &omap2420_timer_hwmod_class,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2420)
+};
+
+/* timer9 */
+static struct omap_hwmod omap2420_timer9_hwmod;
+static struct omap_hwmod_irq_info omap2420_timer9_mpu_irqs[] = {
+	{ .irq = INT_24XX_GPTIMER9, },
+};
+
+static struct omap_hwmod_addr_space omap2420_timer9_addrs[] = {
+	{
+		.pa_start	= 0x48084000,
+		.pa_end		= 0x48084000 + SZ_1K - 1,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+/* l4_core -> timer9 */
+static struct omap_hwmod_ocp_if omap2420_l4_core__timer9 = {
+	.master		= &omap2420_l4_core_hwmod,
+	.slave		= &omap2420_timer9_hwmod,
+	.clk		= "gpt9_ick",
+	.addr		= omap2420_timer9_addrs,
+	.addr_cnt	= ARRAY_SIZE(omap2420_timer9_addrs),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+/* timer9 slave port */
+static struct omap_hwmod_ocp_if *omap2420_timer9_slaves[] = {
+	&omap2420_l4_core__timer9,
+};
+/* timer9 hwmod */
+static struct omap_hwmod omap2420_timer9_hwmod = {
+	.name		= "timer9",
+	.mpu_irqs	= omap2420_timer9_mpu_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap2420_timer9_mpu_irqs),
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
+	.slaves		= omap2420_timer9_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap2420_timer9_slaves),
+	.class		= &omap2420_timer_hwmod_class,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2420)
+};
+
+/* timer10 */
+static struct omap_hwmod omap2420_timer10_hwmod;
+static struct omap_hwmod_irq_info omap2420_timer10_mpu_irqs[] = {
+	{ .irq = INT_24XX_GPTIMER10, },
+};
+
+static struct omap_hwmod_addr_space omap2420_timer10_addrs[] = {
+	{
+		.pa_start	= 0x48086000,
+		.pa_end		= 0x48086000 + SZ_1K - 1,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+/* l4_core -> timer10 */
+static struct omap_hwmod_ocp_if omap2420_l4_core__timer10 = {
+	.master		= &omap2420_l4_core_hwmod,
+	.slave		= &omap2420_timer10_hwmod,
+	.clk		= "gpt10_ick",
+	.addr		= omap2420_timer10_addrs,
+	.addr_cnt	= ARRAY_SIZE(omap2420_timer10_addrs),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+/* timer10 slave port */
+static struct omap_hwmod_ocp_if *omap2420_timer10_slaves[] = {
+	&omap2420_l4_core__timer10,
+};
+/* timer10 hwmod */
+static struct omap_hwmod omap2420_timer10_hwmod = {
+	.name		= "timer10",
+	.mpu_irqs	= omap2420_timer10_mpu_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap2420_timer10_mpu_irqs),
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
+	.slaves		= omap2420_timer10_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap2420_timer10_slaves),
+	.class		= &omap2420_timer_hwmod_class,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2420)
+};
+
+/* timer11 */
+static struct omap_hwmod omap2420_timer11_hwmod;
+static struct omap_hwmod_irq_info omap2420_timer11_mpu_irqs[] = {
+	{ .irq = INT_24XX_GPTIMER11, },
+};
+
+static struct omap_hwmod_addr_space omap2420_timer11_addrs[] = {
+	{
+		.pa_start	= 0x48088000,
+		.pa_end		= 0x48088000 + SZ_1K - 1,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+/* l4_core -> timer11 */
+static struct omap_hwmod_ocp_if omap2420_l4_core__timer11 = {
+	.master		= &omap2420_l4_core_hwmod,
+	.slave		= &omap2420_timer11_hwmod,
+	.clk		= "gpt11_ick",
+	.addr		= omap2420_timer11_addrs,
+	.addr_cnt	= ARRAY_SIZE(omap2420_timer11_addrs),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+/* timer11 slave port */
+static struct omap_hwmod_ocp_if *omap2420_timer11_slaves[] = {
+	&omap2420_l4_core__timer11,
+};
+/* timer11 hwmod */
+static struct omap_hwmod omap2420_timer11_hwmod = {
+	.name		= "timer11",
+	.mpu_irqs	= omap2420_timer11_mpu_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap2420_timer11_mpu_irqs),
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
+	.slaves		= omap2420_timer11_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap2420_timer11_slaves),
+	.class		= &omap2420_timer_hwmod_class,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2420)
+};
+
+/* timer12 */
+static struct omap_hwmod omap2420_timer12_hwmod;
+static struct omap_hwmod_irq_info omap2420_timer12_mpu_irqs[] = {
+	{ .irq = INT_24XX_GPTIMER12, },
+};
+
+static struct omap_hwmod_addr_space omap2420_timer12_addrs[] = {
+	{
+		.pa_start	= 0x4808a000,
+		.pa_end		= 0x4808a000 + SZ_1K - 1,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+/* l4_core -> timer12 */
+static struct omap_hwmod_ocp_if omap2420_l4_core__timer12 = {
+	.master		= &omap2420_l4_core_hwmod,
+	.slave		= &omap2420_timer12_hwmod,
+	.clk		= "gpt12_ick",
+	.addr		= omap2420_timer12_addrs,
+	.addr_cnt	= ARRAY_SIZE(omap2420_timer12_addrs),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+/* timer12 slave port */
+static struct omap_hwmod_ocp_if *omap2420_timer12_slaves[] = {
+	&omap2420_l4_core__timer12,
+};
+/* timer12 hwmod */
+static struct omap_hwmod omap2420_timer12_hwmod = {
+	.name		= "timer12",
+	.mpu_irqs	= omap2420_timer12_mpu_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap2420_timer12_mpu_irqs),
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
+	.slaves		= omap2420_timer12_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap2420_timer12_slaves),
+	.class		= &omap2420_timer_hwmod_class,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2420)
+};
 
 /* Master interfaces on the MPU device */
 static struct omap_hwmod_ocp_if *omap2420_mpu_masters[] = {
@@ -171,6 +756,18 @@ static __initdata struct omap_hwmod *omap2420_hwmods[] = {
 	&omap2420_l4_wkup_hwmod,
 	&omap2420_mpu_hwmod,
 	&omap2420_iva_hwmod,
+	&omap2420_timer1_hwmod,
+	&omap2420_timer2_hwmod,
+	&omap2420_timer3_hwmod,
+	&omap2420_timer4_hwmod,
+	&omap2420_timer5_hwmod,
+	&omap2420_timer6_hwmod,
+	&omap2420_timer7_hwmod,
+	&omap2420_timer8_hwmod,
+	&omap2420_timer9_hwmod,
+	&omap2420_timer10_hwmod,
+	&omap2420_timer11_hwmod,
+	&omap2420_timer12_hwmod,
 	NULL,
 };
 
-- 
1.6.0.4


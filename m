From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: [PATCH v7 4/6] OMAP4: hwmod data: Add watchdog timer
Date: Tue, 21 Sep 2010 19:07:06 +0530
Message-ID: <1285076228-24736-5-git-send-email-charu@ti.com>
References: <1285076228-24736-1-git-send-email-charu@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:57720 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755621Ab0IUNh2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 21 Sep 2010 09:37:28 -0400
In-Reply-To: <1285076228-24736-1-git-send-email-charu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, wim@iguana.be, linux-omap@vger.kernel.org, linux-watchdog@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: khilman@deeprootsystems.com, paul@pwsan.com, b-cousson@ti.com, rnayak@ti.com, p-basak2@ti.com, Charulatha V <charu@ti.com>

From: Benoit Cousson <b-cousson@ti.com>

Add watchdog timer hwmod data for OMAP4 chip

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Signed-off-by: Charulatha V <charu@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |  135 ++++++++++++++++++++++++++++
 1 files changed, 135 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index e20b0ee..8660fea 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -452,6 +452,136 @@ static struct omap_hwmod omap44xx_mpu_hwmod = {
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
 
+/*
+ * 'wd_timer' class
+ * 32-bit watchdog upward counter that generates a pulse on the reset pin on
+ * overflow condition
+ */
+
+static struct omap_hwmod_class_sysconfig omap44xx_wd_timer_sysc = {
+	.rev_offs	= 0x0000,
+	.sysc_offs	= 0x0010,
+	.syss_offs	= 0x0014,
+	.sysc_flags	= (SYSC_HAS_SIDLEMODE | SYSC_HAS_EMUFREE |
+			   SYSC_HAS_SOFTRESET),
+	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
+	.sysc_fields	= &omap_hwmod_sysc_type1,
+};
+
+static struct omap_hwmod_class omap44xx_wd_timer_hwmod_class = {
+	.name = "wd_timer",
+	.sysc = &omap44xx_wd_timer_sysc,
+};
+
+/* wd_timer2 */
+static struct omap_hwmod omap44xx_wd_timer2_hwmod;
+static struct omap_hwmod_irq_info omap44xx_wd_timer2_irqs[] = {
+	{ .irq = 80 + OMAP44XX_IRQ_GIC_START },
+};
+
+static struct omap_hwmod_addr_space omap44xx_wd_timer2_addrs[] = {
+	{
+		.pa_start	= 0x4a314000,
+		.pa_end		= 0x4a31407f,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+
+/* l4_wkup -> wd_timer2 */
+static struct omap_hwmod_ocp_if omap44xx_l4_wkup__wd_timer2 = {
+	.master		= &omap44xx_l4_wkup_hwmod,
+	.slave		= &omap44xx_wd_timer2_hwmod,
+	.clk		= "l4_wkup_clk_mux_ck",
+	.addr		= omap44xx_wd_timer2_addrs,
+	.addr_cnt	= ARRAY_SIZE(omap44xx_wd_timer2_addrs),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* wd_timer2 slave ports */
+static struct omap_hwmod_ocp_if *omap44xx_wd_timer2_slaves[] = {
+	&omap44xx_l4_wkup__wd_timer2,
+};
+
+static struct omap_hwmod omap44xx_wd_timer2_hwmod = {
+	.name		= "wd_timer2",
+	.class		= &omap44xx_wd_timer_hwmod_class,
+	.mpu_irqs	= omap44xx_wd_timer2_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_wd_timer2_irqs),
+	.main_clk	= "wd_timer2_fck",
+	.prcm = {
+		.omap4 = {
+			.clkctrl_reg = OMAP4430_CM_WKUP_WDT2_CLKCTRL,
+		},
+	},
+	.slaves		= omap44xx_wd_timer2_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap44xx_wd_timer2_slaves),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+};
+
+/* wd_timer3 */
+static struct omap_hwmod omap44xx_wd_timer3_hwmod;
+static struct omap_hwmod_irq_info omap44xx_wd_timer3_irqs[] = {
+	{ .irq = 36 + OMAP44XX_IRQ_GIC_START },
+};
+
+static struct omap_hwmod_addr_space omap44xx_wd_timer3_addrs[] = {
+	{
+		.pa_start	= 0x40130000,
+		.pa_end		= 0x4013007f,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+
+/* l4_abe -> wd_timer3 */
+static struct omap_hwmod_ocp_if omap44xx_l4_abe__wd_timer3 = {
+	.master		= &omap44xx_l4_abe_hwmod,
+	.slave		= &omap44xx_wd_timer3_hwmod,
+	.clk		= "ocp_abe_iclk",
+	.addr		= omap44xx_wd_timer3_addrs,
+	.addr_cnt	= ARRAY_SIZE(omap44xx_wd_timer3_addrs),
+	.user		= OCP_USER_MPU,
+};
+
+/* l4_abe -> wd_timer3 (dma) */
+static struct omap_hwmod_addr_space omap44xx_wd_timer3_dma_addrs[] = {
+	{
+		.pa_start	= 0x49030000,
+		.pa_end		= 0x4903007f,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+
+static struct omap_hwmod_ocp_if omap44xx_l4_abe__wd_timer3_dma = {
+	.master		= &omap44xx_l4_abe_hwmod,
+	.slave		= &omap44xx_wd_timer3_hwmod,
+	.clk		= "ocp_abe_iclk",
+	.addr		= omap44xx_wd_timer3_dma_addrs,
+	.addr_cnt	= ARRAY_SIZE(omap44xx_wd_timer3_dma_addrs),
+	.user		= OCP_USER_SDMA,
+};
+
+/* wd_timer3 slave ports */
+static struct omap_hwmod_ocp_if *omap44xx_wd_timer3_slaves[] = {
+	&omap44xx_l4_abe__wd_timer3,
+	&omap44xx_l4_abe__wd_timer3_dma,
+};
+
+static struct omap_hwmod omap44xx_wd_timer3_hwmod = {
+	.name		= "wd_timer3",
+	.class		= &omap44xx_wd_timer_hwmod_class,
+	.mpu_irqs	= omap44xx_wd_timer3_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_wd_timer3_irqs),
+	.main_clk	= "wd_timer3_fck",
+	.prcm = {
+		.omap4 = {
+			.clkctrl_reg = OMAP4430_CM1_ABE_WDT3_CLKCTRL,
+		},
+	},
+	.slaves		= omap44xx_wd_timer3_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap44xx_wd_timer3_slaves),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+};
+
 static __initdata struct omap_hwmod *omap44xx_hwmods[] = {
 	/* dmm class */
 	&omap44xx_dmm_hwmod,
@@ -472,6 +602,11 @@ static __initdata struct omap_hwmod *omap44xx_hwmods[] = {
 
 	/* mpu class */
 	&omap44xx_mpu_hwmod,
+	/* wd_timer class */
+	&omap44xx_wd_timer2_hwmod,
+
+	/* wd_timer3 not yet supported */
+/*	&omap44xx_wd_timer3_hwmod, */
 	NULL,
 };
 
-- 
1.7.0.4


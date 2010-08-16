From: Charulatha V <charu@ti.com>
Subject: [PATCH 3/5 v3] OMAP2430: WDT: Add watchdog timer HWMOD data for OMAP2430
Date: Mon, 16 Aug 2010 19:06:47 +0530
Message-ID: <1281965809-20585-4-git-send-email-charu@ti.com>
References: <1281965809-20585-1-git-send-email-charu@ti.com>
 <1281965809-20585-2-git-send-email-charu@ti.com>
 <1281965809-20585-3-git-send-email-charu@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:53773 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754087Ab0HPNeJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 16 Aug 2010 09:34:09 -0400
In-Reply-To: <1281965809-20585-3-git-send-email-charu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: wim@iguana.be, khilman@deeprootsystems.com, paul@pwsan.com, b-cousson@ti.com, rnayak@ti.com, p-basak2@ti.com, Charulatha V <charu@ti.com>

Add hwmod structures for Watchdog module on OMAP2430
HWMOD Databse

Signed-off-by: Charulatha V <charu@ti.com>
Signed-off-by: Basak, Partha <p-basak2@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_2430_data.c |   59 ++++++++++++++++++++++++++++
 1 files changed, 59 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_2430_data.c b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
index 4526628..f74fca0 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2430_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
@@ -33,6 +33,7 @@ static struct omap_hwmod omap2430_mpu_hwmod;
 static struct omap_hwmod omap2430_iva_hwmod;
 static struct omap_hwmod omap2430_l3_main_hwmod;
 static struct omap_hwmod omap2430_l4_core_hwmod;
+static struct omap_hwmod omap2430_wd_timer2_hwmod;
 
 /* L3 -> L4_CORE interface */
 static struct omap_hwmod_ocp_if omap2430_l3_main__l4_core = {
@@ -165,12 +166,70 @@ static struct omap_hwmod omap2430_iva_hwmod = {
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2430)
 };
 
+/* WDTIMER2 <- L4_WKUP interface */
+static struct omap_hwmod_addr_space omap2430_wd_timer2_addrs[] = {
+	{
+		.pa_start	= 0x49016000,
+		.pa_end		= 0x4901607f,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+
+static struct omap_hwmod_ocp_if omap2430_l4_wkup__wd_timer2 = {
+	.master		= &omap2430_l4_wkup_hwmod,
+	.slave		= &omap2430_wd_timer2_hwmod,
+	.clk		= "mpu_wdt_ick",
+	.addr		= omap2430_wd_timer2_addrs,
+	.addr_cnt	= ARRAY_SIZE(omap2430_wd_timer2_addrs),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* WDTIMER common */
+
+static struct omap_hwmod_class_sysconfig omap2430_wd_timer_sysc = {
+	.rev_offs	= 0x0,
+	.sysc_offs	= 0x0010,
+	.syss_offs	= 0x0014,
+	.sysc_flags	= (SYSC_HAS_EMUFREE | SYSC_HAS_SOFTRESET |
+			   SYSC_HAS_AUTOIDLE),
+	.sysc_fields    = &omap_hwmod_sysc_type1,
+};
+
+static struct omap_hwmod_class omap2430_wd_timer_hwmod_class = {
+	.name = "wd_timer",
+	.sysc = &omap2430_wd_timer_sysc,
+};
+
+/* WDTIMER2 */
+static struct omap_hwmod_ocp_if *omap2430_wd_timer2_slaves[] = {
+	&omap2430_l4_wkup__wd_timer2,
+};
+
+static struct omap_hwmod omap2430_wd_timer2_hwmod = {
+	.name		= "wd_timer2",
+	.class		= &omap2430_wd_timer_hwmod_class,
+	.main_clk	= "mpu_wdt_fck",
+	.prcm		= {
+		.omap2 = {
+			.prcm_reg_id = 1,
+			.module_bit = OMAP24XX_EN_WDT2_SHIFT,
+			.module_offs = WKUP_MOD,
+			.idlest_reg_id = 1,
+			.idlest_idle_bit = OMAP24XX_EN_WDT2_SHIFT,
+		},
+	},
+	.slaves		= omap2430_wd_timer2_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap2430_wd_timer2_slaves),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2430),
+};
+
 static __initdata struct omap_hwmod *omap2430_hwmods[] = {
 	&omap2430_l3_main_hwmod,
 	&omap2430_l4_core_hwmod,
 	&omap2430_l4_wkup_hwmod,
 	&omap2430_mpu_hwmod,
 	&omap2430_iva_hwmod,
+	&omap2430_wd_timer2_hwmod,
 	NULL,
 };
 
-- 
1.6.3.3


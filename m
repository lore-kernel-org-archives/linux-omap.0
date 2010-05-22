From: Charulatha V <charu@ti.com>
Subject: [PATCH 4/6] OMAP2430: WDT: Add watchdog timer HWMOD data for OMAP2430
Date: Sat, 22 May 2010 18:26:04 +0530
Message-ID: <1274532966-19916-5-git-send-email-charu@ti.com>
References: <1274532966-19916-1-git-send-email-charu@ti.com>
 <1274532966-19916-2-git-send-email-charu@ti.com>
 <1274532966-19916-3-git-send-email-charu@ti.com>
 <1274532966-19916-4-git-send-email-charu@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48448 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753723Ab0EVMyd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 22 May 2010 08:54:33 -0400
In-Reply-To: <1274532966-19916-4-git-send-email-charu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: wim@iguana.be, khilman@deeprootsystems.com, rnayak@ti.com, paul@pwsan.com, Charulatha V <charu@ti.com>

Add hwmod structures for Watchdog module on OMAP2430

Signed-off-by: Charulatha V <charu@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_2430_data.c |   56 ++++++++++++++++++++++++++++
 1 files changed, 56 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_2430_data.c b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
index 0852d95..b8a5b1d 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2430_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
@@ -71,6 +71,7 @@ static struct omap_hwmod omap2430_l3_hwmod = {
 static struct omap_hwmod omap2430_l4_wkup_hwmod;
 static struct omap_hwmod omap2430_mmc1_hwmod;
 static struct omap_hwmod omap2430_mmc2_hwmod;
+static struct omap_hwmod omap2430_wd_timer2_hwmod;
 
 /* L4_CORE -> L4_WKUP interface */
 static struct omap_hwmod_ocp_if omap2430_l4_core__l4_wkup = {
@@ -125,6 +126,60 @@ static struct omap_hwmod_ocp_if *omap2430_mpu_masters[] = {
 	&omap2430_mpu__l3,
 };
 
+/* WDTIMER2 <- L4_WKUP interface */
+static struct omap_hwmod_addr_space omap2430_wd_timer2_addrs[] = {
+	{
+		.pa_start	= 0x49016000,
+		.pa_end		= 0x49016000 + SZ_4K - 1,
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
+		},
+	},
+	.slaves		= omap2430_wd_timer2_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap2430_wd_timer2_slaves),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2430),
+};
+
 /* MPU */
 static struct omap_hwmod omap2430_mpu_hwmod = {
 	.name		= "mpu",
@@ -140,6 +195,7 @@ static __initdata struct omap_hwmod *omap2430_hwmods[] = {
 	&omap2430_l4_core_hwmod,
 	&omap2430_l4_wkup_hwmod,
 	&omap2430_mpu_hwmod,
+	&omap2430_wd_timer2_hwmod,
 	NULL,
 };
 
-- 
1.6.3.3


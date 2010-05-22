From: Charulatha V <charu@ti.com>
Subject: [PATCH 2/6] OMAP3: WDT: Add watchdog timer HWMOD data for OMAP3
Date: Sat, 22 May 2010 18:26:02 +0530
Message-ID: <1274532966-19916-3-git-send-email-charu@ti.com>
References: <1274532966-19916-1-git-send-email-charu@ti.com>
 <1274532966-19916-2-git-send-email-charu@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:39499 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751163Ab0EVMyb (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 22 May 2010 08:54:31 -0400
In-Reply-To: <1274532966-19916-2-git-send-email-charu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: wim@iguana.be, khilman@deeprootsystems.com, rnayak@ti.com, paul@pwsan.com, Charulatha V <charu@ti.com>

Add hwmod structures for Watchdog module on OMAP3

Signed-off-by: Charulatha V <charu@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   61 ++++++++++++++++++++++++++++
 1 files changed, 61 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index 39b0c0e..b651461 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -80,6 +80,7 @@ static struct omap_hwmod omap3xxx_l3_hwmod = {
 };
 
 static struct omap_hwmod omap3xxx_l4_wkup_hwmod;
+static struct omap_hwmod omap3xxx_wd_timer2_hwmod;
 
 /* L4_CORE -> L4_WKUP interface */
 static struct omap_hwmod_ocp_if omap3xxx_l4_core__l4_wkup = {
@@ -129,6 +130,24 @@ static struct omap_hwmod omap3xxx_l4_per_hwmod = {
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
 };
 
+/* WDTIMER2 <- L4_WKUP interface */
+static struct omap_hwmod_addr_space omap3xxx_wd_timer2_addrs[] = {
+	{
+		.pa_start	= 0x48314000,
+		.pa_end		= 0x48314000 + SZ_4K - 1,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+
+static struct omap_hwmod_ocp_if omap3xxx_l4_wkup__wd_timer2 = {
+	.master		= &omap3xxx_l4_wkup_hwmod,
+	.slave		= &omap3xxx_wd_timer2_hwmod,
+	.clk		= "wdt2_ick",
+	.addr		= omap3xxx_wd_timer2_addrs,
+	.addr_cnt	= ARRAY_SIZE(omap3xxx_wd_timer2_addrs),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
 /* Slave interfaces on the L4_WKUP interconnect */
 static struct omap_hwmod_ocp_if *omap3xxx_l4_wkup_slaves[] = {
 	&omap3xxx_l4_core__l4_wkup,
@@ -149,6 +168,47 @@ static struct omap_hwmod omap3xxx_l4_wkup_hwmod = {
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
 };
 
+/* WDTIMER common */
+
+static struct omap_hwmod_class_sysconfig omap3xxx_wd_timer_sysc = {
+	.rev_offs	= 0x0000,
+	.sysc_offs	= 0x0010,
+	.syss_offs	= 0x0014,
+	.sysc_flags	= (SYSC_HAS_SIDLEMODE | SYSC_HAS_EMUFREE |
+			   SYSC_HAS_ENAWAKEUP | SYSC_HAS_SOFTRESET |
+			   SYSC_HAS_AUTOIDLE),
+	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
+	.sysc_fields    = &omap_hwmod_sysc_type1,
+};
+
+static struct omap_hwmod_class omap3xxx_wd_timer_hwmod_class = {
+	.name = "wd_timer",
+	.sysc = &omap3xxx_wd_timer_sysc,
+};
+
+/* WDTIMER2 */
+static struct omap_hwmod_ocp_if *omap3xxx_wd_timer2_slaves[] = {
+	&omap3xxx_l4_wkup__wd_timer2,
+};
+
+static struct omap_hwmod omap3xxx_wd_timer2_hwmod = {
+	.name		= "wd_timer2",
+	.class		= &omap3xxx_wd_timer_hwmod_class,
+	.main_clk	= "wdt2_fck",
+	.prcm		= {
+		.omap2 = {
+			.prcm_reg_id = 1,
+			.module_bit = OMAP3430_EN_WDT2_SHIFT,
+			.module_offs = WKUP_MOD,
+			.idlest_reg_id = 1,
+			.idlest_idle_bit = 5,
+		},
+	},
+	.slaves		= omap3xxx_wd_timer2_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap3xxx_wd_timer2_slaves),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+};
+
 /* Master interfaces on the MPU device */
 static struct omap_hwmod_ocp_if *omap3xxx_mpu_masters[] = {
 	&omap3xxx_mpu__l3,
@@ -170,6 +230,7 @@ static __initdata struct omap_hwmod *omap3xxx_hwmods[] = {
 	&omap3xxx_l4_per_hwmod,
 	&omap3xxx_l4_wkup_hwmod,
 	&omap3xxx_mpu_hwmod,
+	&omap3xxx_wd_timer2_hwmod,
 	NULL,
 };
 
-- 
1.6.3.3


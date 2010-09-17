From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: [PATCH v6 2/7] OMAP3: hwmod data: Add watchdog timer
Date: Fri, 17 Sep 2010 19:48:51 +0530
Message-ID: <1284733136-20952-3-git-send-email-charu@ti.com>
References: <1284733136-20952-1-git-send-email-charu@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:39134 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752269Ab0IQOTV (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 17 Sep 2010 10:19:21 -0400
In-Reply-To: <1284733136-20952-1-git-send-email-charu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, wim@iguana.be, linux-watchdog@vger.kernel.org
Cc: khilman@deeprootsystems.com, paul@pwsan.com, b-cousson@ti.com, rnayak@ti.com, p-basak2@ti.com, linux-omap@vger.kernel.org, "Varadarajan, Charulatha" <charu@ti.com>

Add watchdog timer hwmod data for OMAP3 chip

Signed-off-by: Charulatha V <charu@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   65 ++++++++++++++++++++++++++++
 1 files changed, 65 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index 5d8eb58..2872430 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -36,6 +36,7 @@ static struct omap_hwmod omap3xxx_iva_hwmod;
 static struct omap_hwmod omap3xxx_l3_main_hwmod;
 static struct omap_hwmod omap3xxx_l4_core_hwmod;
 static struct omap_hwmod omap3xxx_l4_per_hwmod;
+static struct omap_hwmod omap3xxx_wd_timer2_hwmod;
 
 /* L3 -> L4_CORE interface */
 static struct omap_hwmod_ocp_if omap3xxx_l3_main__l4_core = {
@@ -197,6 +198,69 @@ static struct omap_hwmod omap3xxx_iva_hwmod = {
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
 };
 
+/* l4_wkup -> wd_timer2 */
+static struct omap_hwmod_addr_space omap3xxx_wd_timer2_addrs[] = {
+	{
+		.pa_start	= 0x48314000,
+		.pa_end		= 0x4831407f,
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
+/*
+ * 'wd_timer' class
+ * 32-bit watchdog upward counter that generates a pulse on the reset pin on
+ * overflow condition
+ */
+
+static struct omap_hwmod_class_sysconfig omap3xxx_wd_timer_sysc = {
+	.rev_offs	= 0x0000,
+	.sysc_offs	= 0x0010,
+	.syss_offs	= 0x0014,
+	.sysc_flags	= (SYSC_HAS_SIDLEMODE | SYSC_HAS_EMUFREE |
+			   SYSC_HAS_ENAWAKEUP | SYSC_HAS_SOFTRESET |
+			   SYSC_HAS_AUTOIDLE | SYSC_HAS_CLOCKACTIVITY),
+	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
+	.sysc_fields    = &omap_hwmod_sysc_type1,
+};
+
+static struct omap_hwmod_class omap3xxx_wd_timer_hwmod_class = {
+	.name = "wd_timer",
+	.sysc = &omap3xxx_wd_timer_sysc,
+};
+
+/* wd_timer2 */
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
+			.idlest_idle_bit = OMAP3430_EN_WDT2_SHIFT,
+		},
+	},
+	.slaves		= omap3xxx_wd_timer2_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap3xxx_wd_timer2_slaves),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+};
+
 static __initdata struct omap_hwmod *omap3xxx_hwmods[] = {
 	&omap3xxx_l3_main_hwmod,
 	&omap3xxx_l4_core_hwmod,
@@ -204,6 +268,7 @@ static __initdata struct omap_hwmod *omap3xxx_hwmods[] = {
 	&omap3xxx_l4_wkup_hwmod,
 	&omap3xxx_mpu_hwmod,
 	&omap3xxx_iva_hwmod,
+	&omap3xxx_wd_timer2_hwmod,
 	NULL,
 };
 
-- 
1.7.0.4


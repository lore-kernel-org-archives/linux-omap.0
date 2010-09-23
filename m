From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: [PATCH v8 2/6] OMAP2420: hwmod data: Add watchdog timer
Date: Thu, 23 Sep 2010 20:02:39 +0530
Message-ID: <1285252363-3630-3-git-send-email-charu@ti.com>
References: <1285252363-3630-1-git-send-email-charu@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:57602 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754697Ab0IWOd2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 23 Sep 2010 10:33:28 -0400
In-Reply-To: <1285252363-3630-1-git-send-email-charu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, wim@iguana.be, linux-omap@vger.kernel.org, linux-watchdog@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: khilman@deeprootsystems.com, paul@pwsan.com, b-cousson@ti.com, rnayak@ti.com, p-basak2@ti.com, "Varadarajan, Charulatha" <charu@ti.com>

Add watchdog timer hwmod data for OMAP2420 chip

Signed-off-by: Charulatha V <charu@ti.com>
Acked-by: Cousson, Benoit <b-cousson@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_2420_data.c |   64 ++++++++++++++++++++++++++++
 1 files changed, 64 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_2420_data.c b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
index 3cc768e..66678d9 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2420_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
@@ -19,6 +19,7 @@
 #include "omap_hwmod_common_data.h"
 
 #include "prm-regbits-24xx.h"
+#include "cm-regbits-24xx.h"
 
 /*
  * OMAP2420 hardware module integration data
@@ -33,6 +34,7 @@ static struct omap_hwmod omap2420_mpu_hwmod;
 static struct omap_hwmod omap2420_iva_hwmod;
 static struct omap_hwmod omap2420_l3_main_hwmod;
 static struct omap_hwmod omap2420_l4_core_hwmod;
+static struct omap_hwmod omap2420_wd_timer2_hwmod;
 
 /* L3 -> L4_CORE interface */
 static struct omap_hwmod_ocp_if omap2420_l3_main__l4_core = {
@@ -165,12 +167,74 @@ static struct omap_hwmod omap2420_iva_hwmod = {
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2420)
 };
 
+/* l4_wkup -> wd_timer2 */
+static struct omap_hwmod_addr_space omap2420_wd_timer2_addrs[] = {
+	{
+		.pa_start	= 0x48022000,
+		.pa_end		= 0x4802207f,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+
+static struct omap_hwmod_ocp_if omap2420_l4_wkup__wd_timer2 = {
+	.master		= &omap2420_l4_wkup_hwmod,
+	.slave		= &omap2420_wd_timer2_hwmod,
+	.clk		= "mpu_wdt_ick",
+	.addr		= omap2420_wd_timer2_addrs,
+	.addr_cnt	= ARRAY_SIZE(omap2420_wd_timer2_addrs),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/*
+ * 'wd_timer' class
+ * 32-bit watchdog upward counter that generates a pulse on the reset pin on
+ * overflow condition
+ */
+
+static struct omap_hwmod_class_sysconfig omap2420_wd_timer_sysc = {
+	.rev_offs	= 0x0000,
+	.sysc_offs	= 0x0010,
+	.syss_offs	= 0x0014,
+	.sysc_flags	= (SYSC_HAS_EMUFREE | SYSC_HAS_SOFTRESET |
+			   SYSC_HAS_AUTOIDLE),
+	.sysc_fields    = &omap_hwmod_sysc_type1,
+};
+
+static struct omap_hwmod_class omap2420_wd_timer_hwmod_class = {
+	.name = "wd_timer",
+	.sysc = &omap2420_wd_timer_sysc,
+};
+
+/* wd_timer2 */
+static struct omap_hwmod_ocp_if *omap2420_wd_timer2_slaves[] = {
+	&omap2420_l4_wkup__wd_timer2,
+};
+
+static struct omap_hwmod omap2420_wd_timer2_hwmod = {
+	.name		= "wd_timer2",
+	.class		= &omap2420_wd_timer_hwmod_class,
+	.main_clk	= "mpu_wdt_fck",
+	.prcm		= {
+		.omap2 = {
+			.prcm_reg_id = 1,
+			.module_bit = OMAP24XX_EN_MPU_WDT_SHIFT,
+			.module_offs = WKUP_MOD,
+			.idlest_reg_id = 1,
+			.idlest_idle_bit = OMAP24XX_ST_MPU_WDT_SHIFT,
+		},
+	},
+	.slaves		= omap2420_wd_timer2_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap2420_wd_timer2_slaves),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2420),
+};
+
 static __initdata struct omap_hwmod *omap2420_hwmods[] = {
 	&omap2420_l3_main_hwmod,
 	&omap2420_l4_core_hwmod,
 	&omap2420_l4_wkup_hwmod,
 	&omap2420_mpu_hwmod,
 	&omap2420_iva_hwmod,
+	&omap2420_wd_timer2_hwmod,
 	NULL,
 };
 
-- 
1.7.0.4


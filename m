From: Charulatha V <charu@ti.com>
Subject: [PATCH 1/5 v3] OMAP3: WDT: Add watchdog timer HWMOD data for OMAP3
Date: Mon, 16 Aug 2010 19:06:45 +0530
Message-ID: <1281965809-20585-2-git-send-email-charu@ti.com>
References: <1281965809-20585-1-git-send-email-charu@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:55818 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753822Ab0HPNeE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 16 Aug 2010 09:34:04 -0400
In-Reply-To: <1281965809-20585-1-git-send-email-charu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: wim@iguana.be, khilman@deeprootsystems.com, paul@pwsan.com, b-cousson@ti.com, rnayak@ti.com, p-basak2@ti.com, Charulatha V <charu@ti.com>

Add hwmod structures for Watchdog module on OMAP3 HWMOD database

Signed-off-by: Charulatha V <charu@ti.com>
Signed-off-by: Basak, Partha <p-basak2@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   61 ++++++++++++++++++++++++++++
 arch/arm/mach-omap2/prcm-common.h          |    4 ++
 2 files changed, 65 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index 5d8eb58..a9812a8 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -36,6 +36,7 @@ static struct omap_hwmod omap3xxx_iva_hwmod;
 static struct omap_hwmod omap3xxx_l3_main_hwmod;
 static struct omap_hwmod omap3xxx_l4_core_hwmod;
 static struct omap_hwmod omap3xxx_l4_per_hwmod;
+static struct omap_hwmod omap3xxx_wd_timer2_hwmod;
 
 /* L3 -> L4_CORE interface */
 static struct omap_hwmod_ocp_if omap3xxx_l3_main__l4_core = {
@@ -197,6 +198,65 @@ static struct omap_hwmod omap3xxx_iva_hwmod = {
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
 };
 
+/* WDTIMER2 <- L4_WKUP interface */
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
+/* WDTIMER common */
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
@@ -204,6 +264,7 @@ static __initdata struct omap_hwmod *omap3xxx_hwmods[] = {
 	&omap3xxx_l4_wkup_hwmod,
 	&omap3xxx_mpu_hwmod,
 	&omap3xxx_iva_hwmod,
+	&omap3xxx_wd_timer2_hwmod,
 	NULL,
 };
 
diff --git a/arch/arm/mach-omap2/prcm-common.h b/arch/arm/mach-omap2/prcm-common.h
index 995b7ed..e190c64 100644
--- a/arch/arm/mach-omap2/prcm-common.h
+++ b/arch/arm/mach-omap2/prcm-common.h
@@ -237,6 +237,8 @@
 #define OMAP24XX_ST_USB_MASK				(1 << 0)
 
 /* CM_FCLKEN_WKUP, CM_ICLKEN_WKUP, PM_WKEN_WKUP shared bits */
+#define OMAP24XX_EN_WDT2_SHIFT				3
+#define OMAP24XX_EN_WDT2_MASK				(1 << 3)
 #define OMAP24XX_EN_GPIOS_SHIFT				2
 #define OMAP24XX_EN_GPIOS_MASK				(1 << 2)
 #define OMAP24XX_EN_GPT1_SHIFT				0
@@ -344,6 +346,8 @@
 #define OMAP3430_ST_D2D_MASK				(1 << 3)
 
 /* CM_FCLKEN_WKUP, CM_ICLKEN_WKUP, PM_WKEN_WKUP shared bits */
+#define OMAP3430_EN_WDT2_SHIFT				5
+#define OMAP3430_EN_WDT2_MASK				(1 << 5)
 #define OMAP3430_EN_GPIO1_MASK				(1 << 3)
 #define OMAP3430_EN_GPIO1_SHIFT				3
 #define OMAP3430_EN_GPT12_MASK				(1 << 1)
-- 
1.6.3.3


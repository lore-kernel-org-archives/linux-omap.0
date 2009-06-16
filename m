From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH 04/04] OMAP3: PM: Update sleep/wakeup sequence and device grp associations
Date: Tue, 16 Jun 2009 17:22:34 +0530
Message-ID: <1245153154-1876-4-git-send-email-rnayak@ti.com>
References: <1245153154-1876-1-git-send-email-rnayak@ti.com>
 <1245153154-1876-2-git-send-email-rnayak@ti.com>
 <1245153154-1876-3-git-send-email-rnayak@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:44000 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753470AbZFPLwm (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 16 Jun 2009 07:52:42 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id n5GBqdui014439
	for <linux-omap@vger.kernel.org>; Tue, 16 Jun 2009 06:52:45 -0500
In-Reply-To: <1245153154-1876-3-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: dderrick@ti.com, r-woodruff2@ti.com, Rajendra Nayak <rnayak@ti.com>

This patch enables CONFIG_TWL4030_POWER in omap_3430sdp_pm_defconfig
and updates the sleep and wake sequence for 3430sdp.
Sleep sequence:
-1-Turn off HFCLKOUT
-2-Turn off Vdd1
-3-Turn off Vdd2
-4-Turn off VPLL1

Wakeup p3 sequence
-1-Turn on HFCLKOUT

Wakeup P12 sequence
-1-Turn on HFCLKOUT
-2-Turn on Vdd1
-3-Turn on Vdd2
-4-Turn on VPLL1

Also HFCLKOUT is associated to device group P3. This makes
sure sys clk from PMIC to OMAP is cut during RET as well as OFF.

VDD1 and VDD2 are associated to device group P1 so that they
are cut only during OFF.

CLKEN by default is assigned to all device groups and is left
unchanged. This makes sure the oscillator is not shutdown
in RET states.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/configs/omap_3430sdp_pm_defconfig |    2 +-
 arch/arm/mach-omap2/board-3430sdp.c        |   79 +++++++++++++++-------------
 2 files changed, 44 insertions(+), 37 deletions(-)

diff --git a/arch/arm/configs/omap_3430sdp_pm_defconfig b/arch/arm/configs/omap_3430sdp_pm_defconfig
index aefdb5b..8ec604c 100644
--- a/arch/arm/configs/omap_3430sdp_pm_defconfig
+++ b/arch/arm/configs/omap_3430sdp_pm_defconfig
@@ -777,7 +777,7 @@ CONFIG_SSB_POSSIBLE=y
 # CONFIG_HTC_PASIC3 is not set
 # CONFIG_TPS65010 is not set
 CONFIG_TWL4030_CORE=y
-# CONFIG_TWL4030_POWER is not set
+CONFIG_TWL4030_POWER=y
 # CONFIG_MFD_TMIO is not set
 # CONFIG_MFD_T7L66XB is not set
 # CONFIG_MFD_TC6387XB is not set
diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index 1f0aeb2..4587815 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -47,8 +47,6 @@
 #include "pm.h"
 #include "omap3-opp.h"
 
-#define CONFIG_DISABLE_HFCLK 1
-
 #define SDP3430_ETHR_START		DEBUG_BASE
 #define SDP3430_ETHR_GPIO_IRQ_SDPV1	29
 #define SDP3430_ETHR_GPIO_IRQ_SDPV2	6
@@ -412,18 +410,14 @@ static struct twl4030_madc_platform_data sdp3430_madc_data = {
 
 
 static struct twl4030_ins __initdata sleep_on_seq[] = {
-/*
- * Turn off VDD1 and VDD2.
- */
-	{MSG_SINGULAR(DEV_GRP_P1, 0xf, RES_STATE_OFF), 4},
+	/* Turn off HFCLKOUT */
+	{MSG_SINGULAR(DEV_GRP_P1, 0x19, RES_STATE_OFF), 2},
+	/* Turn OFF VDD1 */
+	{MSG_SINGULAR(DEV_GRP_P1, 0xf, RES_STATE_OFF), 2},
+	/* Turn OFF VDD2 */
 	{MSG_SINGULAR(DEV_GRP_P1, 0x10, RES_STATE_OFF), 2},
-#ifdef CONFIG_DISABLE_HFCLK
-/*
- * And also turn off the OMAP3 PLLs and the sysclk output.
- */
-	{MSG_SINGULAR(DEV_GRP_P1, 0x7, RES_STATE_OFF), 3},
-	{MSG_SINGULAR(DEV_GRP_P1, 0x19, RES_STATE_OFF), 3},
-#endif
+	/* Turn OFF VPLL1 */
+	{MSG_SINGULAR(DEV_GRP_P1, 0x7, RES_STATE_OFF), 2},
 };
 
 static struct twl4030_script sleep_on_script __initdata = {
@@ -432,30 +426,31 @@ static struct twl4030_script sleep_on_script __initdata = {
 	.flags	= TRITON_SLEEP_SCRIPT,
 };
 
-static struct twl4030_ins wakeup_seq[] __initdata = {
-#ifndef CONFIG_DISABLE_HFCLK
-/*
- * Wakeup VDD1 and VDD2.
- */
-	{MSG_SINGULAR(DEV_GRP_P1, 0xf, RES_STATE_ACTIVE), 4},
+static struct twl4030_ins wakeup_p12_seq[] __initdata = {
+	/* Turn on HFCLKOUT */
+	{MSG_SINGULAR(DEV_GRP_P1, 0x19, RES_STATE_ACTIVE), 2},
+	/* Turn ON VDD1 */
+	{MSG_SINGULAR(DEV_GRP_P1, 0xf, RES_STATE_ACTIVE), 2},
+	/* Turn ON VDD2 */
 	{MSG_SINGULAR(DEV_GRP_P1, 0x10, RES_STATE_ACTIVE), 2},
-#else
-/*
- * Reenable the OMAP3 PLLs.
- * Wakeup VDD1 and VDD2.
- * Reenable sysclk output.
- */
-	{MSG_SINGULAR(DEV_GRP_P1, 0x7, RES_STATE_ACTIVE), 0x30},
-	{MSG_SINGULAR(DEV_GRP_P1, 0xf, RES_STATE_ACTIVE), 0x30},
-	{MSG_SINGULAR(DEV_GRP_P1, 0x10, RES_STATE_ACTIVE), 0x37},
-	{MSG_SINGULAR(DEV_GRP_P1, 0x19, RES_STATE_ACTIVE), 3},
-#endif /* #ifndef CONFIG_DISABLE_HFCLK */
+	/* Turn ON VPLL1 */
+	{MSG_SINGULAR(DEV_GRP_P1, 0x7, RES_STATE_ACTIVE), 2},
 };
 
-static struct twl4030_script wakeup_script __initdata = {
-	.script	= wakeup_seq,
-	.size	= ARRAY_SIZE(wakeup_seq),
-	.flags	= TRITON_WAKEUP12_SCRIPT | TRITON_WAKEUP3_SCRIPT,
+static struct twl4030_script wakeup_p12_script __initdata = {
+	.script	= wakeup_p12_seq,
+	.size	= ARRAY_SIZE(wakeup_p12_seq),
+	.flags	= TRITON_WAKEUP12_SCRIPT,
+};
+
+static struct twl4030_ins wakeup_p3_seq[] __initdata = {
+	{MSG_SINGULAR(DEV_GRP_P1, 0x19, RES_STATE_ACTIVE), 2},
+};
+
+static struct twl4030_script wakeup_p3_script __initdata = {
+	.script = wakeup_p3_seq,
+	.size   = ARRAY_SIZE(wakeup_p3_seq),
+	.flags  = TRITON_WAKEUP3_SCRIPT,
 };
 
 static struct twl4030_ins wrst_seq[] __initdata = {
@@ -476,19 +471,31 @@ static struct twl4030_ins wrst_seq[] __initdata = {
 };
 static struct twl4030_script wrst_script __initdata = {
 	.script = wrst_seq,
-	.size   = ARRAY_SIZE(wakeup_seq),
+	.size   = ARRAY_SIZE(wrst_seq),
 	.flags  = TRITON_WRST_SCRIPT,
 };
 
 static struct twl4030_script *twl4030_scripts[] __initdata = {
 	&sleep_on_script,
-	&wakeup_script,
+	&wakeup_p12_script,
+	&wakeup_p3_script,
 	&wrst_script,
 };
 
+static struct twl4030_resconfig twl4030_rconfig[] = {
+	{ .resource = RES_HFCLKOUT, .devgroup = DEV_GRP_P3, .type = -1,
+		.type2 = -1 },
+	{ .resource = RES_VDD1, .devgroup = DEV_GRP_P1, .type = -1,
+		.type2 = -1 },
+	{ .resource = RES_VDD2, .devgroup = DEV_GRP_P1, .type = -1,
+		.type2 = -1 },
+	{ 0, 0},
+};
+
 static struct twl4030_power_data sdp3430_t2scripts_data __initdata = {
 	.scripts	= twl4030_scripts,
 	.size		= ARRAY_SIZE(twl4030_scripts),
+	.resource_config = twl4030_rconfig,
 };
 
 /*
-- 
1.5.4.7


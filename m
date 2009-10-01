From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 2/2] OMAP3: PM: 3430SDP: Update twl4030 power scripts and device groups
Date: Thu,  1 Oct 2009 11:54:22 -0700
Message-ID: <1254423262-25380-3-git-send-email-khilman@deeprootsystems.com>
References: <1254423262-25380-1-git-send-email-khilman@deeprootsystems.com>
 <1254423262-25380-2-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f177.google.com ([209.85.222.177]:64592 "EHLO
	mail-pz0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755927AbZJASy2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Oct 2009 14:54:28 -0400
Received: by mail-pz0-f177.google.com with SMTP id 7so351457pzk.33
        for <linux-omap@vger.kernel.org>; Thu, 01 Oct 2009 11:54:32 -0700 (PDT)
In-Reply-To: <1254423262-25380-2-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Rajendra Nayak <rnayak@ti.com>

From: Rajendra Nayak <rnayak@ti.com>

This patch updates the sleep and wake sequences and updates the
device group associations:

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
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/board-3430sdp.c |   79 +++++++++++++++++++----------------
 1 files changed, 43 insertions(+), 36 deletions(-)

diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index a610355..3ced0f8 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -44,8 +44,6 @@
 #include "sdram-qimonda-hyb18m512160af-6.h"
 #include "mmc-twl4030.h"
 
-#define CONFIG_DISABLE_HFCLK 1
-
 #define SDP3430_TS_GPIO_IRQ_SDPV1	3
 #define SDP3430_TS_GPIO_IRQ_SDPV2	2
 
@@ -280,18 +278,14 @@ static struct twl4030_madc_platform_data sdp3430_madc_data = {
 
 
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
@@ -300,30 +294,31 @@ static struct twl4030_script sleep_on_script __initdata = {
 	.flags	= TWL4030_SLEEP_SCRIPT,
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
-	.flags	= TWL4030_WAKEUP12_SCRIPT | TWL4030_WAKEUP3_SCRIPT,
+static struct twl4030_script wakeup_p12_script __initdata = {
+	.script	= wakeup_p12_seq,
+	.size	= ARRAY_SIZE(wakeup_p12_seq),
+	.flags	= TWL4030_WAKEUP12_SCRIPT,
+};
+
+static struct twl4030_ins wakeup_p3_seq[] __initdata = {
+	{MSG_SINGULAR(DEV_GRP_P1, 0x19, RES_STATE_ACTIVE), 2},
+};
+
+static struct twl4030_script wakeup_p3_script __initdata = {
+	.script = wakeup_p3_seq,
+	.size   = ARRAY_SIZE(wakeup_p3_seq),
+	.flags  = TWL4030_WAKEUP3_SCRIPT,
 };
 
 static struct twl4030_ins wrst_seq[] __initdata = {
@@ -344,19 +339,31 @@ static struct twl4030_ins wrst_seq[] __initdata = {
 };
 static struct twl4030_script wrst_script __initdata = {
 	.script = wrst_seq,
-	.size   = ARRAY_SIZE(wakeup_seq),
+	.size   = ARRAY_SIZE(wrst_seq),
 	.flags  = TWL4030_WRST_SCRIPT,
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
 	.num		= ARRAY_SIZE(twl4030_scripts),
+	.resource_config = twl4030_rconfig,
 };
 
 /*
-- 
1.6.4.3


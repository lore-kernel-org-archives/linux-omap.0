From: "Peter 'p2' De Schrijver" <peter.de-schrijver@nokia.com>
Subject: [PATCH 5/7] 3430sdp and ldp use custom twl4030 power scripts.
Date: Mon, 13 Oct 2008 18:44:10 +0300
Message-ID: <1223912652-24463-6-git-send-email-peter.de-schrijver@nokia.com>
References: <1223912652-24463-1-git-send-email-peter.de-schrijver@nokia.com>
 <1223912652-24463-2-git-send-email-peter.de-schrijver@nokia.com>
 <1223912652-24463-3-git-send-email-peter.de-schrijver@nokia.com>
 <1223912652-24463-4-git-send-email-peter.de-schrijver@nokia.com>
 <1223912652-24463-5-git-send-email-peter.de-schrijver@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:39540 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755371AbYJMPon (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 13 Oct 2008 11:44:43 -0400
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m9DFi3VT003901
	for <linux-omap@vger.kernel.org>; Mon, 13 Oct 2008 10:44:41 -0500
In-Reply-To: <1223912652-24463-5-git-send-email-peter.de-schrijver@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>

The TI 3430dsp and ldp boards have a custom power script to handle sleep and off modes.

Signed-off-by: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
---
 arch/arm/mach-omap2/board-3430sdp.c |   84 +++++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/board-ldp.c     |   84 +++++++++++++++++++++++++++++++++++
 2 files changed, 168 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index 56f28ae..bb591bb 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -47,6 +47,8 @@
 
 #include "sdram-qimonda-hyb18m512160af-6.h"
 
+#define CONFIG_DISABLE_HFCLK 1
+
 #define	SDP3430_SMC91X_CS	3
 
 #define ENABLE_VAUX3_DEDICATED	0x03
@@ -329,6 +331,87 @@ static struct twl4030_madc_platform_data sdp3430_madc_data = {
 	.irq_line	= 1,
 };
 
+
+static struct twl4030_ins __initdata sleep_on_seq[] = {
+/*
+ * Turn off VDD1 and VDD2.
+ */
+	{MSG_SINGULAR(DEV_GRP_P1, 0xf, RES_STATE_OFF), 4},
+	{MSG_SINGULAR(DEV_GRP_P1, 0x10, RES_STATE_OFF), 2},
+#ifdef CONFIG_DISABLE_HFCLK
+/*
+ * And also turn off the OMAP3 PLLs and the sysclk output.
+ */
+	{MSG_SINGULAR(DEV_GRP_P1, 0x7, RES_STATE_OFF), 3},
+	{MSG_SINGULAR(DEV_GRP_P1, 0x19, RES_STATE_OFF), 3},
+#endif
+};
+
+static struct twl4030_script sleep_on_script __initdata = {
+	.script	= sleep_on_seq,
+	.size	= ARRAY_SIZE(sleep_on_seq),
+	.flags	= TRITON_SLEEP_SCRIPT,
+};
+
+static struct twl4030_ins wakeup_seq[] __initdata = {
+#ifndef CONFIG_DISABLE_HFCLK
+/*
+ * Wakeup VDD1 and VDD2.
+ */
+	{MSG_SINGULAR(DEV_GRP_P1, 0xf, RES_STATE_ACTIVE), 4},
+	{MSG_SINGULAR(DEV_GRP_P1, 0x10, RES_STATE_ACTIVE), 2},
+#else
+/*
+ * Reenable the OMAP3 PLLs.
+ * Wakeup VDD1 and VDD2.
+ * Reenable sysclk output.
+ */
+	{MSG_SINGULAR(DEV_GRP_P1, 0x7, RES_STATE_ACTIVE), 0x30},
+	{MSG_SINGULAR(DEV_GRP_P1, 0xf, RES_STATE_ACTIVE), 0x30},
+	{MSG_SINGULAR(DEV_GRP_P1, 0x10, RES_STATE_ACTIVE), 0x37},
+	{MSG_SINGULAR(DEV_GRP_P1, 0x19, RES_STATE_ACTIVE), 3},
+#endif /* #ifndef CONFIG_DISABLE_HFCLK */
+};
+
+static struct twl4030_script wakeup_script __initdata = {
+	.script	= wakeup_seq,
+	.size	= ARRAY_SIZE(wakeup_seq),
+	.flags	= TRITON_WAKEUP12_SCRIPT | TRITON_WAKEUP3_SCRIPT,
+};
+
+static struct twl4030_ins wrst_seq[] __initdata = {
+/*
+ * Reset twl4030.
+ * Reset VDD1 regulator.
+ * Reset VDD2 regulator.
+ * Reset VPLL1 regulator.
+ * Enable sysclk output.
+ * Reenable twl4030.
+ */
+	{MSG_SINGULAR(DEV_GRP_NULL, 0x1b, RES_STATE_OFF), 2},
+	{MSG_SINGULAR(DEV_GRP_P1, 0xf, RES_STATE_WRST), 15},
+	{MSG_SINGULAR(DEV_GRP_P1, 0x10, RES_STATE_WRST), 15},
+	{MSG_SINGULAR(DEV_GRP_P1, 0x7, RES_STATE_WRST), 0x60},
+	{MSG_SINGULAR(DEV_GRP_P1, 0x19, RES_STATE_ACTIVE), 2},
+	{MSG_SINGULAR(DEV_GRP_NULL, 0x1b, RES_STATE_ACTIVE), 2},
+};
+static struct twl4030_script wrst_script __initdata = {
+	.script = wrst_seq,
+	.size   = ARRAY_SIZE(wakeup_seq),
+	.flags  = TRITON_WRST_SCRIPT,
+};
+
+static struct twl4030_script *twl4030_scripts[] __initdata = {
+	&sleep_on_script,
+	&wakeup_script,
+	&wrst_script,
+};
+
+static struct twl4030_power_data sdp3430_t2scripts_data __initdata = {
+	.scripts	= twl4030_scripts,
+	.size		= ARRAY_SIZE(twl4030_scripts),
+};
+
 static struct twl4030_platform_data sdp3430_twldata = {
 	.irq_base	= TWL4030_IRQ_BASE,
 	.irq_end	= TWL4030_IRQ_END,
@@ -338,6 +421,7 @@ static struct twl4030_platform_data sdp3430_twldata = {
 	.gpio		= &sdp3430_gpio_data,
 	.madc		= &sdp3430_madc_data,
 	.keypad		= &sdp3430_kp_data,
+	.power		= &sdp3430_t2scripts_data,
 	.usb		= &sdp3430_usb_data,
 };
 
diff --git a/arch/arm/mach-omap2/board-ldp.c b/arch/arm/mach-omap2/board-ldp.c
index 92710c3..d4d4e90 100644
--- a/arch/arm/mach-omap2/board-ldp.c
+++ b/arch/arm/mach-omap2/board-ldp.c
@@ -41,6 +41,8 @@
 #include <asm/delay.h>
 #include <mach/control.h>
 
+#define CONFIG_DISABLE_HFCLK 1
+
 #define ENABLE_VAUX1_DEDICATED	0x03
 #define ENABLE_VAUX1_DEV_GRP	0x20
 
@@ -195,6 +197,87 @@ static int ldp_batt_table[] = {
 4040,   3910,   3790,   3670,   3550
 };
 
+static struct twl4030_ins __initdata sleep_on_seq[] = {
+/*
+ * Turn off VDD1 and VDD2.
+ */
+	{MSG_SINGULAR(DEV_GRP_P1, 0xf, RES_STATE_OFF), 4},
+	{MSG_SINGULAR(DEV_GRP_P1, 0x10, RES_STATE_OFF), 2},
+#ifdef CONFIG_DISABLE_HFCLK
+/*
+ * And also turn off the OMAP3 PLLs and the sysclk output.
+ */
+	{MSG_SINGULAR(DEV_GRP_P1, 0x7, RES_STATE_OFF), 3},
+	{MSG_SINGULAR(DEV_GRP_P1, 0x19, RES_STATE_OFF), 3},
+#endif
+};
+
+static struct twl4030_script sleep_on_script __initdata = {
+	.script	= sleep_on_seq,
+	.size	= ARRAY_SIZE(sleep_on_seq),
+	.flags	= TRITON_SLEEP_SCRIPT,
+};
+
+static struct twl4030_ins wakeup_seq[] __initdata = {
+#ifndef CONFIG_DISABLE_HFCLK
+/*
+ * Wakeup VDD1 and VDD2.
+ */
+	{MSG_SINGULAR(DEV_GRP_P1, 0xf, RES_STATE_ACTIVE), 4},
+	{MSG_SINGULAR(DEV_GRP_P1, 0x10, RES_STATE_ACTIVE), 2},
+#else
+/*
+ * Reenable the OMAP3 PLLs.
+ * Wakeup VDD1 and VDD2.
+ * Reenable sysclk output.
+ */
+	{MSG_SINGULAR(DEV_GRP_P1, 0x7, RES_STATE_ACTIVE), 0x30},
+	{MSG_SINGULAR(DEV_GRP_P1, 0xf, RES_STATE_ACTIVE), 0x30},
+	{MSG_SINGULAR(DEV_GRP_P1, 0x10, RES_STATE_ACTIVE), 0x37},
+	{MSG_SINGULAR(DEV_GRP_P1, 0x19, RES_STATE_ACTIVE), 3},
+#endif /* #ifndef CONFIG_DISABLE_HFCLK */
+};
+
+static struct twl4030_script wakeup_script __initdata = {
+	.script	= wakeup_seq,
+	.size	= ARRAY_SIZE(wakeup_seq),
+	.flags	= TRITON_WAKEUP12_SCRIPT | TRITON_WAKEUP3_SCRIPT,
+};
+
+static struct twl4030_ins wrst_seq[] __initdata = {
+/*
+ * Reset twl4030.
+ * Reset VDD1 regulator.
+ * Reset VDD2 regulator.
+ * Reset VPLL1 regulator.
+ * Enable sysclk output.
+ * Reenable twl4030.
+ */
+	{MSG_SINGULAR(DEV_GRP_NULL, 0x1b, RES_STATE_OFF), 2},
+	{MSG_SINGULAR(DEV_GRP_P1, 0xf, RES_STATE_WRST), 15},
+	{MSG_SINGULAR(DEV_GRP_P1, 0x10, RES_STATE_WRST), 15},
+	{MSG_SINGULAR(DEV_GRP_P1, 0x7, RES_STATE_WRST), 0x60},
+	{MSG_SINGULAR(DEV_GRP_P1, 0x19, RES_STATE_ACTIVE), 2},
+	{MSG_SINGULAR(DEV_GRP_NULL, 0x1b, RES_STATE_ACTIVE), 2},
+};
+
+static struct twl4030_script wrst_script __initdata = {
+	.script = wrst_seq,
+	.size   = ARRAY_SIZE(wakeup_seq),
+	.flags  = TRITON_WRST_SCRIPT,
+};
+
+static struct twl4030_script *twl4030_scripts[] __initdata = {
+	&sleep_on_script,
+	&wakeup_script,
+	&wrst_script,
+};
+
+static struct twl4030_power_data sdp3430_t2scripts_data __initdata = {
+	.scripts	= twl4030_scripts,
+	.size		= ARRAY_SIZE(twl4030_scripts),
+};
+
 static struct twl4030_bci_platform_data ldp_bci_data = {
 	.battery_tmp_tbl	= ldp_batt_table,
 	.tblsize		= ARRAY_SIZE(ldp_batt_table),
@@ -222,6 +305,7 @@ static struct twl4030_platform_data ldp_twldata = {
 	.bci		= &ldp_bci_data,
 	.madc		= &ldp_madc_data,
 	.usb		= &ldp_usb_data,
+	.power		= &sdp3430_t2scripts_data,
 	.gpio		= &ldp_gpio_data,
 };
 
-- 
1.5.6.3


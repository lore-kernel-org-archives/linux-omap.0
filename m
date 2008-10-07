From: "Peter 'p2' De Schrijver" <peter.de-schrijver@nokia.com>
Subject: [PATCH 1/3] Add twl4030 scripts to 3430sdp platform data
Date: Tue,  7 Oct 2008 17:34:08 +0300
Message-ID: <1223390050-11499-2-git-send-email-peter.de-schrijver@nokia.com>
References: <1223390050-11499-1-git-send-email-peter.de-schrijver@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:53606 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751185AbYJGOeW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Oct 2008 10:34:22 -0400
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m97EY033019631
	for <linux-omap@vger.kernel.org>; Tue, 7 Oct 2008 17:34:20 +0300
In-Reply-To: <1223390050-11499-1-git-send-email-peter.de-schrijver@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>


Signed-off-by: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
---
 arch/arm/mach-omap2/board-3430sdp.c |   61 +++++++++++++++++++++++++++++++++++
 1 files changed, 61 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index 4264b68..c03a35f 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -48,6 +48,8 @@
 
 #include "sdram-qimonda-hyb18m512160af-6.h"
 
+#define CONFIG_DISABLE_HFCLK 1
+
 #define	SDP3430_SMC91X_CS	3
 
 #define ENABLE_VAUX3_DEDICATED	0x03
@@ -330,6 +332,64 @@ static struct twl4030_madc_platform_data sdp3430_madc_data = {
 	.irq_line	= 1,
 };
 
+static struct twl4030_ins __initdata sleep_on_seq[] = {
+	{MSG_SINGULAR(DEV_GRP_P1, 0xf, RES_STATE_OFF), 4},
+	{MSG_SINGULAR(DEV_GRP_P1, 0x10, RES_STATE_OFF), 2},
+#ifdef CONFIG_DISABLE_HFCLK
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
+	{MSG_SINGULAR(DEV_GRP_P1, 0xf, RES_STATE_ACTIVE), 4},
+	{MSG_SINGULAR(DEV_GRP_P1, 0x10, RES_STATE_ACTIVE), 2},
+#else
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
@@ -339,6 +399,7 @@ static struct twl4030_platform_data sdp3430_twldata = {
 	.gpio		= &sdp3430_gpio_data,
 	.madc		= &sdp3430_madc_data,
 	.keypad		= &sdp3430_kp_data,
+	.power		= &sdp3430_t2scripts_data,
 	.usb		= &sdp3430_usb_data,
 };
 
-- 
1.5.6.3


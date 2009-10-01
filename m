From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 1/2] OMAP3: PM: 3430SDP: add initial twl4030 power scripts
Date: Thu,  1 Oct 2009 11:54:21 -0700
Message-ID: <1254423262-25380-2-git-send-email-khilman@deeprootsystems.com>
References: <1254423262-25380-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f179.google.com ([209.85.216.179]:48643 "EHLO
	mail-px0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754791AbZJASy0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Oct 2009 14:54:26 -0400
Received: by pxi9 with SMTP id 9so465605pxi.4
        for <linux-omap@vger.kernel.org>; Thu, 01 Oct 2009 11:54:30 -0700 (PDT)
In-Reply-To: <1254423262-25380-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Now that twl4030 power support is upstream, add the original power
scripts for the 3430SDP to the board setup.

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/board-3430sdp.c |   82 +++++++++++++++++++++++++++++++++++
 1 files changed, 82 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index 2dfab17..a610355 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -278,6 +278,87 @@ static struct twl4030_madc_platform_data sdp3430_madc_data = {
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
+	.flags	= TWL4030_SLEEP_SCRIPT,
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
+	.flags	= TWL4030_WAKEUP12_SCRIPT | TWL4030_WAKEUP3_SCRIPT,
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
+	.flags  = TWL4030_WRST_SCRIPT,
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
+	.num		= ARRAY_SIZE(twl4030_scripts),
+};
+
 /*
  * Apply all the fixed voltages since most versions of U-Boot
  * don't bother with that initialization.
@@ -419,6 +500,7 @@ static struct twl4030_platform_data sdp3430_twldata = {
 	.gpio		= &sdp3430_gpio_data,
 	.madc		= &sdp3430_madc_data,
 	.keypad		= &sdp3430_kp_data,
+	.power		= &sdp3430_t2scripts_data,
 	.usb		= &sdp3430_usb_data,
 
 	.vaux1		= &sdp3430_vaux1,
-- 
1.6.4.3


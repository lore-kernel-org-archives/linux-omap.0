From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.29-rc8-omap] twl4030 power scripts, initsection fixups
Date: Fri, 13 Mar 2009 18:25:52 -0700
Message-ID: <200903131825.52114.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp125.sbc.mail.sp1.yahoo.com ([69.147.65.184]:29814 "HELO
	smtp125.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1760617AbZCNB0F (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 Mar 2009 21:26:05 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: OMAP <linux-omap@vger.kernel.org>

From: David Brownell <dbrownell@users.sourceforge.net>

Remove section mismatch warnings from twl4030 power script
declaration ... unfortunately, this use-once data can't live
in initdata sections (or initconst) until some driver stacks
(starting with I2C) have better support for non-hotpluggable
componentry.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
---
 arch/arm/mach-omap2/board-3430sdp.c           |   16 ++++++++--------
 arch/arm/mach-omap2/board-ldp.c               |   16 ++++++++--------
 arch/arm/mach-omap2/twl4030-generic-scripts.c |   12 ++++++------
 3 files changed, 22 insertions(+), 22 deletions(-)

--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -394,7 +394,7 @@ static struct twl4030_madc_platform_data
 };
 
 
-static struct twl4030_ins __initdata sleep_on_seq[] = {
+static struct twl4030_ins sleep_on_seq[] = {
 /*
  * Turn off VDD1 and VDD2.
  */
@@ -409,13 +409,13 @@ static struct twl4030_ins __initdata sle
 #endif
 };
 
-static struct twl4030_script sleep_on_script __initdata = {
+static struct twl4030_script sleep_on_script = {
 	.script	= sleep_on_seq,
 	.size	= ARRAY_SIZE(sleep_on_seq),
 	.flags	= TRITON_SLEEP_SCRIPT,
 };
 
-static struct twl4030_ins wakeup_seq[] __initdata = {
+static struct twl4030_ins wakeup_seq[] = {
 #ifndef CONFIG_DISABLE_HFCLK
 /*
  * Wakeup VDD1 and VDD2.
@@ -435,13 +435,13 @@ static struct twl4030_ins wakeup_seq[] _
 #endif /* #ifndef CONFIG_DISABLE_HFCLK */
 };
 
-static struct twl4030_script wakeup_script __initdata = {
+static struct twl4030_script wakeup_script = {
 	.script	= wakeup_seq,
 	.size	= ARRAY_SIZE(wakeup_seq),
 	.flags	= TRITON_WAKEUP12_SCRIPT | TRITON_WAKEUP3_SCRIPT,
 };
 
-static struct twl4030_ins wrst_seq[] __initdata = {
+static struct twl4030_ins wrst_seq[] = {
 /*
  * Reset twl4030.
  * Reset VDD1 regulator.
@@ -457,19 +457,19 @@ static struct twl4030_ins wrst_seq[] __i
 	{MSG_SINGULAR(DEV_GRP_P1, 0x19, RES_STATE_ACTIVE), 2},
 	{MSG_SINGULAR(DEV_GRP_NULL, 0x1b, RES_STATE_ACTIVE), 2},
 };
-static struct twl4030_script wrst_script __initdata = {
+static struct twl4030_script wrst_script = {
 	.script = wrst_seq,
 	.size   = ARRAY_SIZE(wakeup_seq),
 	.flags  = TRITON_WRST_SCRIPT,
 };
 
-static struct twl4030_script *twl4030_scripts[] __initdata = {
+static struct twl4030_script *twl4030_scripts[] = {
 	&sleep_on_script,
 	&wakeup_script,
 	&wrst_script,
 };
 
-static struct twl4030_power_data sdp3430_t2scripts_data __initdata = {
+static struct twl4030_power_data sdp3430_t2scripts_data = {
 	.scripts	= twl4030_scripts,
 	.size		= ARRAY_SIZE(twl4030_scripts),
 };
--- a/arch/arm/mach-omap2/board-ldp.c
+++ b/arch/arm/mach-omap2/board-ldp.c
@@ -374,7 +374,7 @@ static int ldp_batt_table[] = {
 4040,   3910,   3790,   3670,   3550
 };
 
-static struct twl4030_ins __initdata sleep_on_seq[] = {
+static struct twl4030_ins sleep_on_seq[] = {
 /*
  * Turn off VDD1 and VDD2.
  */
@@ -389,13 +389,13 @@ static struct twl4030_ins __initdata sle
 #endif
 };
 
-static struct twl4030_script sleep_on_script __initdata = {
+static struct twl4030_script sleep_on_script = {
 	.script	= sleep_on_seq,
 	.size	= ARRAY_SIZE(sleep_on_seq),
 	.flags	= TRITON_SLEEP_SCRIPT,
 };
 
-static struct twl4030_ins wakeup_seq[] __initdata = {
+static struct twl4030_ins wakeup_seq[] = {
 #ifndef CONFIG_DISABLE_HFCLK
 /*
  * Wakeup VDD1 and VDD2.
@@ -415,13 +415,13 @@ static struct twl4030_ins wakeup_seq[] _
 #endif /* #ifndef CONFIG_DISABLE_HFCLK */
 };
 
-static struct twl4030_script wakeup_script __initdata = {
+static struct twl4030_script wakeup_script = {
 	.script	= wakeup_seq,
 	.size	= ARRAY_SIZE(wakeup_seq),
 	.flags	= TRITON_WAKEUP12_SCRIPT | TRITON_WAKEUP3_SCRIPT,
 };
 
-static struct twl4030_ins wrst_seq[] __initdata = {
+static struct twl4030_ins wrst_seq[] = {
 /*
  * Reset twl4030.
  * Reset VDD1 regulator.
@@ -438,19 +438,19 @@ static struct twl4030_ins wrst_seq[] __i
 	{MSG_SINGULAR(DEV_GRP_NULL, 0x1b, RES_STATE_ACTIVE), 2},
 };
 
-static struct twl4030_script wrst_script __initdata = {
+static struct twl4030_script wrst_script = {
 	.script = wrst_seq,
 	.size   = ARRAY_SIZE(wakeup_seq),
 	.flags  = TRITON_WRST_SCRIPT,
 };
 
-static struct twl4030_script *twl4030_scripts[] __initdata = {
+static struct twl4030_script *twl4030_scripts[] = {
 	&sleep_on_script,
 	&wakeup_script,
 	&wrst_script,
 };
 
-static struct twl4030_power_data sdp3430_t2scripts_data __initdata = {
+static struct twl4030_power_data sdp3430_t2scripts_data = {
 	.scripts	= twl4030_scripts,
 	.size		= ARRAY_SIZE(twl4030_scripts),
 };
--- a/arch/arm/mach-omap2/twl4030-generic-scripts.c
+++ b/arch/arm/mach-omap2/twl4030-generic-scripts.c
@@ -35,14 +35,14 @@
  * resources to sleep and then all the other resources.
  */
 
-static struct twl4030_ins sleep_on_seq[] __initdata = {
+static struct twl4030_ins sleep_on_seq[] = {
 	{MSG_BROADCAST(DEV_GRP_NULL, RES_GRP_RC, RES_TYPE_ALL, RES_TYPE2_R0,
 			RES_STATE_SLEEP), 4},
 	{MSG_BROADCAST(DEV_GRP_NULL, RES_GRP_ALL, RES_TYPE_ALL, RES_TYPE2_R0,
 			RES_STATE_SLEEP), 4},
 };
 
-static struct twl4030_script sleep_on_script __initdata = {
+static struct twl4030_script sleep_on_script = {
 	.script = sleep_on_seq,
 	.size   = ARRAY_SIZE(sleep_on_seq),
 	.flags  = TRITON_SLEEP_SCRIPT,
@@ -53,7 +53,7 @@ static struct twl4030_script sleep_on_sc
  * regulators and then all other resources.
  */
 
-static struct twl4030_ins wakeup_seq[] __initdata = {
+static struct twl4030_ins wakeup_seq[] = {
 	{MSG_SINGULAR(DEV_GRP_NULL, 0x17, RES_STATE_ACTIVE), 0x30},
 	{MSG_BROADCAST(DEV_GRP_NULL, RES_GRP_PP_PR, RES_TYPE_ALL, RES_TYPE2_R0,
 			RES_STATE_ACTIVE), 0x37},
@@ -61,18 +61,18 @@ static struct twl4030_ins wakeup_seq[] _
 			RES_STATE_ACTIVE), 0x2},
 };
 
-static struct twl4030_script wakeup_script __initdata = {
+static struct twl4030_script wakeup_script = {
 	.script = wakeup_seq,
 	.size   = ARRAY_SIZE(wakeup_seq),
 	.flags  = TRITON_WAKEUP12_SCRIPT | TRITON_WAKEUP3_SCRIPT,
 };
 
-static struct twl4030_script *twl4030_scripts[] __initdata = {
+static struct twl4030_script *twl4030_scripts[] = {
 	&sleep_on_script,
 	&wakeup_script,
 };
 
-struct twl4030_power_data generic3430_t2scripts_data __initdata = {
+struct twl4030_power_data generic3430_t2scripts_data = {
 	.scripts        = twl4030_scripts,
 	.size           = ARRAY_SIZE(twl4030_scripts),
 };

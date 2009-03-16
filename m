From: Felipe Balbi <me@felipebalbi.com>
Subject: [PATCH] twl4030 power scripts, initsection fixups
Date: Mon, 16 Mar 2009 23:52:11 +0200
Message-ID: <1237240331-31140-1-git-send-email-me@felipebalbi.com>
References: <20090316214643.GG551@gandalf>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:44208 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754371AbZCPVwU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 Mar 2009 17:52:20 -0400
In-Reply-To: <20090316214643.GG551@gandalf>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: David Brownell <david-b@pacbell.net>, David Brownell <dbrownell@users.sourceforge.net>, Felipe Balbi <felipe.balbi@nokia.com>

From: David Brownell <dbrownell@users.sourceforge.net>

Remove section mismatch warnings from twl4030 power script
declaration ... unfortunately, this use-once data can't live
in initdata sections (or initconst) until some driver stacks
(starting with I2C) have better support for non-hotpluggable
componentry.

[felipe.balbi@nokia.com: updated twl4030-power.c]

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
This patch depends on patches [1] and [2]

[1] http://patchwork.kernel.org/patch/11961/
[2] http://patchwork.kernel.org/patch/11962/

 arch/arm/mach-omap2/board-3430sdp.c           |   16 ++++++++--------
 arch/arm/mach-omap2/board-ldp.c               |   16 ++++++++--------
 arch/arm/mach-omap2/twl4030-generic-scripts.c |   12 ++++++------
 drivers/mfd/twl4030-power.c                   |   18 +++++++++---------
 4 files changed, 31 insertions(+), 31 deletions(-)

diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index 08f0d41..557159f 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -394,7 +394,7 @@ static struct twl4030_madc_platform_data sdp3430_madc_data = {
 };
 
 
-static struct twl4030_ins __initdata sleep_on_seq[] = {
+static struct twl4030_ins sleep_on_seq[] = {
 /*
  * Turn off VDD1 and VDD2.
  */
@@ -409,13 +409,13 @@ static struct twl4030_ins __initdata sleep_on_seq[] = {
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
@@ -435,13 +435,13 @@ static struct twl4030_ins wakeup_seq[] __initdata = {
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
@@ -457,19 +457,19 @@ static struct twl4030_ins wrst_seq[] __initdata = {
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
diff --git a/arch/arm/mach-omap2/board-ldp.c b/arch/arm/mach-omap2/board-ldp.c
index 30926b0..3887629 100644
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
@@ -389,13 +389,13 @@ static struct twl4030_ins __initdata sleep_on_seq[] = {
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
@@ -415,13 +415,13 @@ static struct twl4030_ins wakeup_seq[] __initdata = {
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
@@ -438,19 +438,19 @@ static struct twl4030_ins wrst_seq[] __initdata = {
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
diff --git a/arch/arm/mach-omap2/twl4030-generic-scripts.c b/arch/arm/mach-omap2/twl4030-generic-scripts.c
index 4293752..abef1c8 100644
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
@@ -53,7 +53,7 @@ static struct twl4030_script sleep_on_script __initdata = {
  * regulators and then all other resources.
  */
 
-static struct twl4030_ins wakeup_seq[] __initdata = {
+static struct twl4030_ins wakeup_seq[] = {
 	{MSG_SINGULAR(DEV_GRP_NULL, 0x17, RES_STATE_ACTIVE), 0x30},
 	{MSG_BROADCAST(DEV_GRP_NULL, RES_GRP_PP_PR, RES_TYPE_ALL, RES_TYPE2_R0,
 			RES_STATE_ACTIVE), 0x37},
@@ -61,18 +61,18 @@ static struct twl4030_ins wakeup_seq[] __initdata = {
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
diff --git a/drivers/mfd/twl4030-power.c b/drivers/mfd/twl4030-power.c
index 9dc493b..8080b67 100644
--- a/drivers/mfd/twl4030-power.c
+++ b/drivers/mfd/twl4030-power.c
@@ -104,7 +104,7 @@ static u8 res_config_addrs[] = {
 	[RES_Main_Ref]	= 0x94,
 };
 
-static int __init twl4030_write_script_byte(u8 address, u8 byte)
+static int twl4030_write_script_byte(u8 address, u8 byte)
 {
 	int err;
 
@@ -116,7 +116,7 @@ static int __init twl4030_write_script_byte(u8 address, u8 byte)
 	return err;
 }
 
-static int __init twl4030_write_script_ins(u8 address, u16 pmb_message,
+static int twl4030_write_script_ins(u8 address, u16 pmb_message,
 						u8 delay, u8 next)
 {
 	int err = 0;
@@ -130,7 +130,7 @@ static int __init twl4030_write_script_ins(u8 address, u16 pmb_message,
 	return err;
 }
 
-static int __init twl4030_write_script(u8 address, struct twl4030_ins *script,
+static int twl4030_write_script(u8 address, struct twl4030_ins *script,
 					int len)
 {
 	int err = 0;
@@ -151,7 +151,7 @@ static int __init twl4030_write_script(u8 address, struct twl4030_ins *script,
 	return err;
 }
 
-static int __init config_wakeup3_sequence(u8 address)
+static int config_wakeup3_sequence(u8 address)
 {
 
 	int err = 0;
@@ -169,7 +169,7 @@ static int __init config_wakeup3_sequence(u8 address)
 	return err;
 }
 
-static int __init config_wakeup12_sequence(u8 address)
+static int config_wakeup12_sequence(u8 address)
 {
 	int err = 0;
 
@@ -200,7 +200,7 @@ static int __init config_wakeup12_sequence(u8 address)
 	return err;
 }
 
-static int __init config_sleep_sequence(u8 address)
+static int config_sleep_sequence(u8 address)
 {
 	int err = 0;
 
@@ -222,7 +222,7 @@ static int __init config_sleep_sequence(u8 address)
 	return err;
 }
 
-static int __init config_warmreset_sequence(u8 address)
+static int config_warmreset_sequence(u8 address)
 {
 
 	int err = 0;
@@ -304,7 +304,7 @@ void twl4030_configure_resource(struct twl4030_resconfig *rconfig)
 
 }
 
-static int __init load_triton_script(struct twl4030_script *tscript)
+static int load_triton_script(struct twl4030_script *tscript)
 {
 	u8 address = triton_next_free_address;
 	int err;
@@ -330,7 +330,7 @@ static int __init load_triton_script(struct twl4030_script *tscript)
 	return err;
 }
 
-void __init twl4030_power_init(struct twl4030_power_data *triton2_scripts)
+void twl4030_power_init(struct twl4030_power_data *triton2_scripts)
 {
 	int err = 0;
 	int i;
-- 
1.6.1.3


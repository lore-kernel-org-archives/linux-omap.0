From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [patch 2.6.29-rc8-omap] twl4030 power scripts, initsection
	fixups
Date: Mon, 16 Mar 2009 02:24:20 +0200
Message-ID: <20090316002419.GA551@gandalf>
References: <200903131825.52114.david-b@pacbell.net> <20090314105659.GA8832@gandalf> <200903141200.53768.david-b@pacbell.net>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:51041 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758808AbZCPAY2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 15 Mar 2009 20:24:28 -0400
Content-Disposition: inline
In-Reply-To: <200903141200.53768.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: me@felipebalbi.com, OMAP <linux-omap@vger.kernel.org>

On Sat, Mar 14, 2009 at 12:00:53PM -0700, David Brownell wrote:
> On Saturday 14 March 2009, Felipe Balbi wrote:
> > > 
> > > Remove section mismatch warnings from twl4030 power script
> > > declaration ... unfortunately, this use-once data can't live
> > > in initdata sections (or initconst) until some driver stacks
> > > (starting with I2C) have better support for non-hotpluggable
> > > componentry.
> > 
> > should you update this with the following ?
> 
> I didn't see any section mismatch warnings from this goofage.  ;)
> 
> But, yes this looks wrong too.  Resend with your s-o-b ...

how about applying this one instead ?

================ cut here ===================

>From 1ce7606214e9b3caad9ccd3cc356f905c7a5ee23 Mon Sep 17 00:00:00 2001
From: David Brownell <dbrownell@users.sourceforge.net>
Date: Fri, 13 Mar 2009 18:25:52 -0700
Subject: [PATCH] twl4030 power scripts, initsection fixups

Remove section mismatch warnings from twl4030 power script
declaration ... unfortunately, this use-once data can't live
in initdata sections (or initconst) until some driver stacks
(starting with I2C) have better support for non-hotpluggable
componentry.

[felipe.balbi@nokia.com: updated twl4030-power.c]

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 arch/arm/mach-omap2/board-3430sdp.c           |   16 ++++++++--------
 arch/arm/mach-omap2/board-ldp.c               |   16 ++++++++--------
 arch/arm/mach-omap2/twl4030-generic-scripts.c |   12 ++++++------
 drivers/mfd/twl4030-power.c                   |   18 +++++++++---------
 4 files changed, 31 insertions(+), 31 deletions(-)

diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index e9de795..f786ac4 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -388,7 +388,7 @@ static struct twl4030_madc_platform_data sdp3430_madc_data = {
 };
 
 
-static struct twl4030_ins __initdata sleep_on_seq[] = {
+static struct twl4030_ins sleep_on_seq[] = {
 /*
  * Turn off VDD1 and VDD2.
  */
@@ -403,13 +403,13 @@ static struct twl4030_ins __initdata sleep_on_seq[] = {
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
@@ -429,13 +429,13 @@ static struct twl4030_ins wakeup_seq[] __initdata = {
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
@@ -451,19 +451,19 @@ static struct twl4030_ins wrst_seq[] __initdata = {
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
index 1e1fd84..0176798 100644
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
index d9d1655..1f246e8 100644
--- a/drivers/mfd/twl4030-power.c
+++ b/drivers/mfd/twl4030-power.c
@@ -66,7 +66,7 @@ static u8 triton_next_free_address = 0x2b;
 #define KEY_1			0xC0
 #define KEY_2			0x0C
 
-static int __init twl4030_write_script_byte(u8 address, u8 byte)
+static int twl4030_write_script_byte(u8 address, u8 byte)
 {
 	int err;
 
@@ -78,7 +78,7 @@ static int __init twl4030_write_script_byte(u8 address, u8 byte)
 	return err;
 }
 
-static int __init twl4030_write_script_ins(u8 address, u16 pmb_message,
+static int twl4030_write_script_ins(u8 address, u16 pmb_message,
 						u8 delay, u8 next)
 {
 	int err = 0;
@@ -92,7 +92,7 @@ static int __init twl4030_write_script_ins(u8 address, u16 pmb_message,
 	return err;
 }
 
-static int __init twl4030_write_script(u8 address, struct twl4030_ins *script,
+static int twl4030_write_script(u8 address, struct twl4030_ins *script,
 					int len)
 {
 	int err = 0;
@@ -113,7 +113,7 @@ static int __init twl4030_write_script(u8 address, struct twl4030_ins *script,
 	return err;
 }
 
-static int __init config_wakeup3_sequence(u8 address)
+static int config_wakeup3_sequence(u8 address)
 {
 
 	int err = 0;
@@ -131,7 +131,7 @@ static int __init config_wakeup3_sequence(u8 address)
 	return err;
 }
 
-static int __init config_wakeup12_sequence(u8 address)
+static int config_wakeup12_sequence(u8 address)
 {
 	int err = 0;
 
@@ -162,7 +162,7 @@ static int __init config_wakeup12_sequence(u8 address)
 	return err;
 }
 
-static int __init config_sleep_sequence(u8 address)
+static int config_sleep_sequence(u8 address)
 {
 	int err = 0;
 
@@ -184,7 +184,7 @@ static int __init config_sleep_sequence(u8 address)
 	return err;
 }
 
-static int __init config_warmreset_sequence(u8 address)
+static int config_warmreset_sequence(u8 address)
 {
 
 	int err = 0;
@@ -219,7 +219,7 @@ static int __init config_warmreset_sequence(u8 address)
 	return err;
 }
 
-static int __init load_triton_script(struct twl4030_script *tscript)
+static int load_triton_script(struct twl4030_script *tscript)
 {
 	u8 address = triton_next_free_address;
 	int err;
@@ -245,7 +245,7 @@ static int __init load_triton_script(struct twl4030_script *tscript)
 	return err;
 }
 
-void __init twl4030_power_init(struct twl4030_power_data *triton2_scripts)
+void twl4030_power_init(struct twl4030_power_data *triton2_scripts)
 {
 	int err = 0;
 	int i;
-- 
1.6.1.3

-- 
balbi

From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [patch 2.6.29-rc8-omap] twl4030 power scripts, initsection
	fixups
Date: Sat, 14 Mar 2009 12:57:00 +0200
Message-ID: <20090314105659.GA8832@gandalf>
References: <200903131825.52114.david-b@pacbell.net>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:42520 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751867AbZCNK5N (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 14 Mar 2009 06:57:13 -0400
Content-Disposition: inline
In-Reply-To: <200903131825.52114.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: OMAP <linux-omap@vger.kernel.org>

On Fri, Mar 13, 2009 at 06:25:52PM -0700, David Brownell wrote:
> From: David Brownell <dbrownell@users.sourceforge.net>
> 
> Remove section mismatch warnings from twl4030 power script
> declaration ... unfortunately, this use-once data can't live
> in initdata sections (or initconst) until some driver stacks
> (starting with I2C) have better support for non-hotpluggable
> componentry.

should you update this with the following ?


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
balbi

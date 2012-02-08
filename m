From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [PATCH 07/16] ARM: omap: fix section mismatch errors in TWL PMIC
 driver
Date: Wed, 08 Feb 2012 16:38:09 +0000
Message-ID: <E1RvAX3-0006HF-Bf@rmk-PC.arm.linux.org.uk>
References: <20120208163546.GA15849@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:34987 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755839Ab2BHQiN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Feb 2012 11:38:13 -0500
In-Reply-To: <20120208163546.GA15849@n2100.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Samuel Ortiz <sameo@linux.intel.com>

WARNING: drivers/mfd/built-in.o(.devinit.text+0x258): Section mismatch in reference from the function twl_probe() to the function .init.text:twl4030_power_init()
The function __devinit twl_probe() references
a function __init twl4030_power_init().
If twl4030_power_init is only used by twl_probe then
annotate twl4030_power_init with a matching annotation.

twl4030_power_init() references other __init marked functions, so
these too must become __devinit.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/mfd/twl4030-power.c |   20 ++++++++++----------
 1 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/mfd/twl4030-power.c b/drivers/mfd/twl4030-power.c
index d905f51..79ca33d 100644
--- a/drivers/mfd/twl4030-power.c
+++ b/drivers/mfd/twl4030-power.c
@@ -124,7 +124,7 @@ static u8 res_config_addrs[] = {
 	[RES_MAIN_REF]	= 0x94,
 };
 
-static int __init twl4030_write_script_byte(u8 address, u8 byte)
+static int __devinit twl4030_write_script_byte(u8 address, u8 byte)
 {
 	int err;
 
@@ -138,7 +138,7 @@ static int __init twl4030_write_script_byte(u8 address, u8 byte)
 	return err;
 }
 
-static int __init twl4030_write_script_ins(u8 address, u16 pmb_message,
+static int __devinit twl4030_write_script_ins(u8 address, u16 pmb_message,
 					   u8 delay, u8 next)
 {
 	int err;
@@ -158,7 +158,7 @@ static int __init twl4030_write_script_ins(u8 address, u16 pmb_message,
 	return err;
 }
 
-static int __init twl4030_write_script(u8 address, struct twl4030_ins *script,
+static int __devinit twl4030_write_script(u8 address, struct twl4030_ins *script,
 				       int len)
 {
 	int err;
@@ -183,7 +183,7 @@ static int __init twl4030_write_script(u8 address, struct twl4030_ins *script,
 	return err;
 }
 
-static int __init twl4030_config_wakeup3_sequence(u8 address)
+static int __devinit twl4030_config_wakeup3_sequence(u8 address)
 {
 	int err;
 	u8 data;
@@ -208,7 +208,7 @@ static int __init twl4030_config_wakeup3_sequence(u8 address)
 	return err;
 }
 
-static int __init twl4030_config_wakeup12_sequence(u8 address)
+static int __devinit twl4030_config_wakeup12_sequence(u8 address)
 {
 	int err = 0;
 	u8 data;
@@ -262,7 +262,7 @@ static int __init twl4030_config_wakeup12_sequence(u8 address)
 	return err;
 }
 
-static int __init twl4030_config_sleep_sequence(u8 address)
+static int __devinit twl4030_config_sleep_sequence(u8 address)
 {
 	int err;
 
@@ -276,7 +276,7 @@ static int __init twl4030_config_sleep_sequence(u8 address)
 	return err;
 }
 
-static int __init twl4030_config_warmreset_sequence(u8 address)
+static int __devinit twl4030_config_warmreset_sequence(u8 address)
 {
 	int err;
 	u8 rd_data;
@@ -324,7 +324,7 @@ static int __init twl4030_config_warmreset_sequence(u8 address)
 	return err;
 }
 
-static int __init twl4030_configure_resource(struct twl4030_resconfig *rconfig)
+static int __devinit twl4030_configure_resource(struct twl4030_resconfig *rconfig)
 {
 	int rconfig_addr;
 	int err;
@@ -416,7 +416,7 @@ static int __init twl4030_configure_resource(struct twl4030_resconfig *rconfig)
 	return 0;
 }
 
-static int __init load_twl4030_script(struct twl4030_script *tscript,
+static int __devinit load_twl4030_script(struct twl4030_script *tscript,
 	       u8 address)
 {
 	int err;
@@ -527,7 +527,7 @@ void twl4030_power_off(void)
 		pr_err("TWL4030 Unable to power off\n");
 }
 
-void __init twl4030_power_init(struct twl4030_power_data *twl4030_scripts)
+void __devinit twl4030_power_init(struct twl4030_power_data *twl4030_scripts)
 {
 	int err = 0;
 	int i;
-- 
1.7.4.4


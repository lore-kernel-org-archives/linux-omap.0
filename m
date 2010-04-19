From: Lesly A M <leslyam@ti.com>
Subject: [PATCH v5 1/5] omap3: pm: fix for twl4030 script load
Date: Mon, 19 Apr 2010 17:13:00 +0530
Message-ID: <1271677380-2095-1-git-send-email-leslyam@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:32819 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754522Ab0DSLWG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 Apr 2010 07:22:06 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Lesly A M <x0080970@ti.com>, Nishanth Menon <nm@ti.com>, David Derrick <dderrick@ti.com>, Samuel Ortiz <sameo@linux.intel.com>

This patch will fix the TRITON sleep/wakeup sequence.

Since the function to populate the sleep script is getting called always
irrespective of the flag "TWL4030_SLEEP_SCRIPT", other scripts data
is getting over written by the sleep script.

Also removing the order checking while loading the scripts,
since the order doesn't matter. Only the values configured
in the register, which is pointing to the starting address
of each sequence should be correct.

Signed-off-by: Lesly A M <x0080970@ti.com>
Cc: Nishanth Menon <nm@ti.com>
Cc: David Derrick <dderrick@ti.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>
---
 drivers/mfd/twl4030-power.c |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/drivers/mfd/twl4030-power.c b/drivers/mfd/twl4030-power.c
index 7efa878..bd98733 100644
--- a/drivers/mfd/twl4030-power.c
+++ b/drivers/mfd/twl4030-power.c
@@ -423,7 +423,6 @@ static int __init load_twl4030_script(struct twl4030_script *tscript,
 	       u8 address)
 {
 	int err;
-	static int order;
 
 	/* Make sure the script isn't going beyond last valid address (0x3f) */
 	if ((address + tscript->size) > END_OF_SCRIPT) {
@@ -444,7 +443,6 @@ static int __init load_twl4030_script(struct twl4030_script *tscript,
 		err = twl4030_config_wakeup12_sequence(address);
 		if (err)
 			goto out;
-		order = 1;
 	}
 	if (tscript->flags & TWL4030_WAKEUP3_SCRIPT) {
 		err = twl4030_config_wakeup3_sequence(address);
@@ -452,10 +450,6 @@ static int __init load_twl4030_script(struct twl4030_script *tscript,
 			goto out;
 	}
 	if (tscript->flags & TWL4030_SLEEP_SCRIPT)
-		if (order)
-			pr_warning("TWL4030: Bad order of scripts (sleep "\
-					"script before wakeup) Leads to boot"\
-					"failure on some boards\n");
 		err = twl4030_config_sleep_sequence(address);
 out:
 	return err;
-- 
1.6.0.4


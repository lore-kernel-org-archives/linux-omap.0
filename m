From: Lesly A M <leslyam@ti.com>
Subject: [PATCH v6 1/7] omap3: pm: fix for twl4030 script load
Date: Tue, 18 May 2010 18:02:53 +0530
Message-ID: <1274185973-23839-1-git-send-email-leslyam@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:41459 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757262Ab0ERMdp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 May 2010 08:33:45 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Lesly A M <x0080970@ti.com>, Nishanth Menon <nm@ti.com>, David Derrick <dderrick@ti.com>, Samuel Ortiz <sameo@linux.intel.com>

This patch will fix the TRITON sleep/wakeup sequence.

Since the function to populate the sleep script is getting called always
irrespective of the flag "TWL4030_SLEEP_SCRIPT", other scripts data
is getting over written by the sleep script.

Print warning if the sleep script is loaded before wakeup script.
Because there is a chance that the Power chip may go to sleep before
the wakeup script is completely loaded, which can cause a system hang.

Signed-off-by: Lesly A M <x0080970@ti.com>
Cc: Nishanth Menon <nm@ti.com>
Cc: David Derrick <dderrick@ti.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>
---
 drivers/mfd/twl4030-power.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/twl4030-power.c b/drivers/mfd/twl4030-power.c
index 7efa878..b4fc190 100644
--- a/drivers/mfd/twl4030-power.c
+++ b/drivers/mfd/twl4030-power.c
@@ -451,12 +451,13 @@ static int __init load_twl4030_script(struct twl4030_script *tscript,
 		if (err)
 			goto out;
 	}
-	if (tscript->flags & TWL4030_SLEEP_SCRIPT)
-		if (order)
+	if (tscript->flags & TWL4030_SLEEP_SCRIPT) {
+		if (!order)
 			pr_warning("TWL4030: Bad order of scripts (sleep "\
 					"script before wakeup) Leads to boot"\
 					"failure on some boards\n");
 		err = twl4030_config_sleep_sequence(address);
+	}
 out:
 	return err;
 }
-- 
1.7.0.4


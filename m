From: Lesly A M <leslyam@ti.com>
Subject: [PATCH v7 1/8] omap3: pm: fix for twl4030 script load
Date: Thu,  1 Jul 2010 15:40:31 +0530
Message-ID: <1277979031-1908-1-git-send-email-leslyam@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:49308 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754063Ab0GAKOT (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 1 Jul 2010 06:14:19 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Lesly A M <leslyam@ti.com>, Nishanth Menon <nm@ti.com>, David Derrick <dderrick@ti.com>, Samuel Ortiz <sameo@linux.intel.com>

This patch will fix the TRITON sleep/wakeup sequence.

Since the function to populate the sleep script is getting called always
irrespective of the flag "TWL4030_SLEEP_SCRIPT", other scripts data
is getting over written by the sleep script.

Signed-off-by: Lesly A M <leslyam@ti.com>
Cc: Nishanth Menon <nm@ti.com>
Cc: David Derrick <dderrick@ti.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>
---
 drivers/mfd/twl4030-power.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/mfd/twl4030-power.c b/drivers/mfd/twl4030-power.c
index 7efa878..9ab5a20 100644
--- a/drivers/mfd/twl4030-power.c
+++ b/drivers/mfd/twl4030-power.c
@@ -451,12 +451,13 @@ static int __init load_twl4030_script(struct twl4030_script *tscript,
 		if (err)
 			goto out;
 	}
-	if (tscript->flags & TWL4030_SLEEP_SCRIPT)
+	if (tscript->flags & TWL4030_SLEEP_SCRIPT) {
 		if (order)
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


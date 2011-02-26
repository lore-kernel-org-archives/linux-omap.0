From: Lesly A M <leslyam@ti.com>
Subject: [PATCH 1/8] omap3: pm: Fix for the TRITON sleep/wakeup sequence
Date: Sat, 26 Feb 2011 17:55:32 +0530
Message-ID: <1298723139-1693-2-git-send-email-leslyam@ti.com>
References: <1298723139-1693-1-git-send-email-leslyam@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:51952 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752024Ab1BZMW3 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 26 Feb 2011 07:22:29 -0500
In-Reply-To: <1298723139-1693-1-git-send-email-leslyam@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Lesly A M <leslyam@ti.com>, Nishanth Menon <nm@ti.com>, David Derrick <dderrick@ti.com>, Samuel Ortiz <sameo@linux.intel.com>

Since the function to populate the sleep script is getting called always
irrespective of the flag "TWL4030_SLEEP_SCRIPT", other scripts data
is getting over written by the sleep script. Adding the missing brackets for
if statement to fix the issue.

Signed-off-by: Lesly A M <leslyam@ti.com>
Cc: Nishanth Menon <nm@ti.com>
Cc: David Derrick <dderrick@ti.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>
---
 drivers/mfd/twl4030-power.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/mfd/twl4030-power.c b/drivers/mfd/twl4030-power.c
index 16422de..2c0d4d1 100644
--- a/drivers/mfd/twl4030-power.c
+++ b/drivers/mfd/twl4030-power.c
@@ -447,12 +447,13 @@ static int __init load_twl4030_script(struct twl4030_script *tscript,
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


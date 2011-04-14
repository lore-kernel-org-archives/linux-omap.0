From: Lesly A M <leslyam@ti.com>
Subject: [PATCH v9 1/9] OMAP3: PM: Fix for the TWL4030 sleep/wakeup sequence
Date: Thu, 14 Apr 2011 17:57:49 +0530
Message-ID: <1302784077-16697-2-git-send-email-leslyam@ti.com>
References: <1302784077-16697-1-git-send-email-leslyam@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:55119 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757163Ab1DNM1w (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 14 Apr 2011 08:27:52 -0400
In-Reply-To: <1302784077-16697-1-git-send-email-leslyam@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Lesly A M <leslyam@ti.com>, Nishanth Menon <nm@ti.com>, David Derrick <dderrick@ti.com>, Samuel Ortiz <sameo@linux.intel.com>

Only configure sleep script when the flag is TWL4030_SLEEP_SCRIPT.

Adding the missing brackets for fixing the issue.

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
1.7.1


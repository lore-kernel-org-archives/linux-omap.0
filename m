From: Lesly A M <leslyam@ti.com>
Subject: [PATCH v10 2/7] MFD: TWL4030: Correct the warning print during script loading
Date: Fri, 6 May 2011 18:47:08 +0530
Message-ID: <1304687833-4578-3-git-send-email-leslyam@ti.com>
References: <1304687833-4578-1-git-send-email-leslyam@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:54024 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754893Ab1EFNRO (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 6 May 2011 09:17:14 -0400
In-Reply-To: <1304687833-4578-1-git-send-email-leslyam@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Lesly A M <leslyam@ti.com>, Nishanth Menon <nm@ti.com>, David Derrick <dderrick@ti.com>, Samuel Ortiz <sameo@linux.intel.com>

Correcting the if condition check for printing the warning,
if wakeup script is not updated before updating the sleep script.

Since the flag 'order' is set to '1' while updating the wakeup script for P1P2,
the condition checking for printing the warning should be if(!order)
(ie: print the warning if wakeup script is not updated before updating the sleep script)

Signed-off-by: Lesly A M <leslyam@ti.com>
Cc: Nishanth Menon <nm@ti.com>
Cc: David Derrick <dderrick@ti.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>
---
 drivers/mfd/twl4030-power.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mfd/twl4030-power.c b/drivers/mfd/twl4030-power.c
index 97f54ce..12ab2a6 100644
--- a/drivers/mfd/twl4030-power.c
+++ b/drivers/mfd/twl4030-power.c
@@ -448,7 +448,7 @@ static int __init load_twl4030_script(struct twl4030_script *tscript,
 			goto out;
 	}
 	if (tscript->flags & TWL4030_SLEEP_SCRIPT) {
-		if (order)
+		if (!order)
 			pr_warning("TWL4030: Bad order of scripts (sleep "\
 					"script before wakeup) Leads to boot"\
 					"failure on some boards\n");
-- 
1.7.1


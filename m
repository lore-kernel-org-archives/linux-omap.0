From: Lesly Arackal Manuel <leslyam@ti.com>
Subject: [PATCH 1/1] OMAP: twl4030-power: In remove script check the error condition after i2cwrite
Date: Wed, 4 May 2011 17:38:53 +0530
Message-ID: <1304510933-14488-1-git-send-email-leslyam@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:36566 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754519Ab1EDMJB (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 4 May 2011 08:09:01 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Lesly A M <leslyam@ti.com>, Samuel Ortiz <sameo@linux.intel.com>

From: Lesly A M <leslyam@ti.com>

Fixing the error condition check in twl4030 remove script function.
Due to some typo in commit ID: 11a441ce82d6ffecfd39b324024de0cd630b36c1

Signed-off-by: Lesly A M <leslyam@ti.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>
---
 drivers/mfd/twl4030-power.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mfd/twl4030-power.c b/drivers/mfd/twl4030-power.c
index 16422de..6fed964 100644
--- a/drivers/mfd/twl4030-power.c
+++ b/drivers/mfd/twl4030-power.c
@@ -484,9 +484,9 @@ int twl4030_remove_script(u8 flags)
 			return err;
 	}
 	if (flags & TWL4030_WAKEUP12_SCRIPT) {
-		if (err)
 		err = twl_i2c_write_u8(TWL4030_MODULE_PM_MASTER, END_OF_SCRIPT,
 				R_SEQ_ADD_S2A12);
+		if (err)
 			return err;
 	}
 	if (flags & TWL4030_WAKEUP3_SCRIPT) {
-- 
1.7.1


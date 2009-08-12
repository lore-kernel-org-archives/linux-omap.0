From: charu@ti.com
Subject: [RFC][PATCH 2/3] handling rtc platform data
Date: Wed, 12 Aug 2009 21:15:35 +0530
Message-ID: <1250091935-5432-1-git-send-email-charu@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:41115 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752707AbZHLPpr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Aug 2009 11:45:47 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, david-b@pacbell.net, sameo@linux.intel.com, p_gortmaker@yahoo.com, Charulatha V <charu@ti.com>

twl4030-core.c passes rtc platform data from board file to twl4030 rtc driver

Signed-off-by: Charulatha V <charu@ti.com>
---
 drivers/mfd/twl4030-core.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mfd/twl4030-core.c b/drivers/mfd/twl4030-core.c
index 96af2f5..a20ffd0 100644
--- a/drivers/mfd/twl4030-core.c
+++ b/drivers/mfd/twl4030-core.c
@@ -528,7 +528,7 @@ add_children(struct twl4030_platform_data *pdata, unsigned long features)
 		 * HW security concerns, and "least privilege".
 		 */
 		child = add_child(3, "twl4030_rtc",
-				NULL, 0,
+				pdata->rtc, sizeof(*pdata->rtc),
 				true, pdata->irq_base + 8 + 3, 0);
 		if (IS_ERR(child))
 			return PTR_ERR(child);
-- 
1.6.0.4


From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH] mfd: twl4030: Enabling twl4030_wdt and pwrbutton only for Triton
Date: Wed, 23 Feb 2011 16:26:54 +0530
Message-ID: <1298458614-22366-1-git-send-email-j-keerthy@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:44280 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753356Ab1BWK5R (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 23 Feb 2011 05:57:17 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: sameo@linux.intel.com
Cc: linux-omap@vger.kernel.org, j-keerthy@ti.com

Enabling twl4030_wdt and twl4030_pwrbutton only for Triton i.e for
TWL4030 and TWL5030. This is to be excluded for Phoenix TWL6030.
Tested OMAP4 blaze, OMAP2430, OMAP3630 boot up.

Signed-off-by: Keerthy <j-keerthy@ti.com>
Reviewed-by: Balaji T K <balajitk@ti.com>
---
 drivers/mfd/twl-core.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
index a35fa7d..8051346 100644
--- a/drivers/mfd/twl-core.c
+++ b/drivers/mfd/twl-core.c
@@ -721,13 +721,13 @@ add_children(struct twl4030_platform_data *pdata, unsigned long features)
 
 	}
 
-	if (twl_has_watchdog()) {
+	if (twl_has_watchdog() && twl_class_is_4030()) {
 		child = add_child(0, "twl4030_wdt", NULL, 0, false, 0, 0);
 		if (IS_ERR(child))
 			return PTR_ERR(child);
 	}
 
-	if (twl_has_pwrbutton()) {
+	if (twl_has_pwrbutton() && twl_class_is_4030()) {
 		child = add_child(1, "twl4030_pwrbutton",
 				NULL, 0, true, pdata->irq_base + 8 + 0, 0);
 		if (IS_ERR(child))
-- 
1.7.0.4


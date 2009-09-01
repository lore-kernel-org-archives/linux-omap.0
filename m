From: andy.shevchenko@gmail.com
Subject: [PATCH] dspbridge: Check pointer before usage
Date: Tue,  1 Sep 2009 11:11:21 +0300
Message-ID: <1251792681-14472-1-git-send-email-andy.shevchenko@gmail.com>
References: <1251791985-14412-1-git-send-email-andy.shevchenko@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:26157 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753191AbZIAILf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Sep 2009 04:11:35 -0400
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx03.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id n818BJtO010729
	for <linux-omap@vger.kernel.org>; Tue, 1 Sep 2009 11:11:28 +0300
In-Reply-To: <1251791985-14412-1-git-send-email-andy.shevchenko@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Andy Shevchenko <ext-andriy.shevchenko@nokia.com>

From: Andy Shevchenko <ext-andriy.shevchenko@nokia.com>

Check list pointer at every itteration because it could be deleted before we go
into the for loop.

Reworked version of the previous attempts.

Signed-off-by: Andy Shevchenko <ext-andriy.shevchenko@nokia.com>
---
 drivers/dsp/bridge/rmgr/drv.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/dsp/bridge/rmgr/drv.c b/drivers/dsp/bridge/rmgr/drv.c
index d21071c..7e41669 100644
--- a/drivers/dsp/bridge/rmgr/drv.c
+++ b/drivers/dsp/bridge/rmgr/drv.c
@@ -1543,8 +1543,9 @@ DSP_STATUS DRV_ReleaseResources(u32 dwContext, struct DRV_OBJECT *hDrvObject)
 	 *  The following will over write the status.
 	 */
 	for (pszdevNode = (struct DRV_EXT *)DRV_GetFirstDevExtension();
-	    pszdevNode != NULL; pszdevNode = (struct DRV_EXT *)
-	    DRV_GetNextDevExtension((u32)pszdevNode)) {
+	    pszdevNode != NULL && pDRVObject->devNodeString != NULL;
+	    pszdevNode = (struct DRV_EXT *)
+			  DRV_GetNextDevExtension((u32) pszdevNode)) {
 		if ((u32)pszdevNode == dwContext) {
 			/* Found it */
 			/* Delete from the Driver object list */
-- 
1.5.6.5


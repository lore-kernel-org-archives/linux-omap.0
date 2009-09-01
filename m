From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH] dspbridge: Check pointer before usage
Date: Tue,  1 Sep 2009 10:59:45 +0300
Message-ID: <1251791985-14412-1-git-send-email-andy.shevchenko@gmail.com>
References: <496565EC904933469F292DDA3F1663E602A5EF2E95@dlee06.ent.ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:34437 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752786AbZIAIAF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Sep 2009 04:00:05 -0400
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx06.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id n817xmjF022891
	for <linux-omap@vger.kernel.org>; Tue, 1 Sep 2009 10:59:52 +0300
In-Reply-To: <496565EC904933469F292DDA3F1663E602A5EF2E95@dlee06.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Andy Shevchenko <ext-andriy.shevchenko@nokia.com>

From: Andy Shevchenko <ext-andriy.shevchenko@nokia.com>

Theoretically list could be deleted before we go into the for loop.
Additionally we could delete list immediately if it becomes empty.

Signed-off-by: Andy Shevchenko <ext-andriy.shevchenko@nokia.com>
---
 drivers/dsp/bridge/rmgr/drv.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/dsp/bridge/rmgr/drv.c b/drivers/dsp/bridge/rmgr/drv.c
index d21071c..9f726a6 100644
--- a/drivers/dsp/bridge/rmgr/drv.c
+++ b/drivers/dsp/bridge/rmgr/drv.c
@@ -1545,18 +1545,23 @@ DSP_STATUS DRV_ReleaseResources(u32 dwContext, struct DRV_OBJECT *hDrvObject)
 	for (pszdevNode = (struct DRV_EXT *)DRV_GetFirstDevExtension();
 	    pszdevNode != NULL; pszdevNode = (struct DRV_EXT *)
 	    DRV_GetNextDevExtension((u32)pszdevNode)) {
+		if (!pDRVObject->devNodeString)
+			/* List already deleted */
+			break;
+
 		if ((u32)pszdevNode == dwContext) {
 			/* Found it */
 			/* Delete from the Driver object list */
 			LST_RemoveElem(pDRVObject->devNodeString,
-				      (struct LST_ELEM *)pszdevNode);
+				       (struct LST_ELEM *) pszdevNode);
 			MEM_Free((void *) pszdevNode);
-			break;
 		}
+
 		/* Delete the List if it is empty */
 		if (LST_IsEmpty(pDRVObject->devNodeString)) {
 			LST_Delete(pDRVObject->devNodeString);
 			pDRVObject->devNodeString = NULL;
+			break;
 		}
 	}
 	return status;
-- 
1.5.6.5


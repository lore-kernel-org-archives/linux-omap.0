From: Ameya Palande <ameya.palande@nokia.com>
Subject: [PATCH] DSPBRIDGE: Buffer size warning fixes
Date: Tue, 19 May 2009 16:19:29 +0530
Message-ID: <1242730169-14523-1-git-send-email-ameya.palande@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:46307 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751772AbZESKt4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 May 2009 06:49:56 -0400
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id n4JAngQQ003704
	for <linux-omap@vger.kernel.org>; Tue, 19 May 2009 13:49:53 +0300
Received: from localhost.localdomain (essapo-nirac253106.europe.nokia.com [10.162.253.106])
	by mgw-sa02.ext.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id n4JAnTOQ024815
	for <linux-omap@vger.kernel.org>; Tue, 19 May 2009 13:49:30 +0300
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: Ameya Palande <ameya.palande@nokia.com>

Signed-off-by: Ameya Palande <ameya.palande@nokia.com>
---
 drivers/dsp/bridge/pmgr/cod.c        |    2 +-
 drivers/dsp/bridge/rmgr/drv.c        |    2 +-
 drivers/dsp/bridge/services/regsup.c |    4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/dsp/bridge/pmgr/cod.c b/drivers/dsp/bridge/pmgr/cod.c
index 6363f1e..5094201 100644
--- a/drivers/dsp/bridge/pmgr/cod.c
+++ b/drivers/dsp/bridge/pmgr/cod.c
@@ -628,7 +628,7 @@ DSP_STATUS COD_OpenBase(struct COD_MANAGER *hMgr, IN char *pszCoffPath,
 	} else {
 		/* hang onto the library for subsequent sym table usage */
 		hMgr->baseLib = lib;
-               strncpy(hMgr->szZLFile, pszCoffPath, COD_MAXPATHLENGTH);
+		strncpy(hMgr->szZLFile, pszCoffPath, COD_MAXPATHLENGTH - 1);
 	}
 
 	return status;
diff --git a/drivers/dsp/bridge/rmgr/drv.c b/drivers/dsp/bridge/rmgr/drv.c
index 256ce12..60ca054 100644
--- a/drivers/dsp/bridge/rmgr/drv.c
+++ b/drivers/dsp/bridge/rmgr/drv.c
@@ -1510,7 +1510,7 @@ DSP_STATUS DRV_RequestResources(u32 dwContext, u32 *pDevNodeString)
 		if (pszdevNode) {
 			LST_InitElem(&pszdevNode->link);
                        strncpy((char *) pszdevNode->szString,
-				 (char *)dwContext, MAXREGPATHLENGTH);
+				 (char *)dwContext, MAXREGPATHLENGTH - 1);
 			/* Update the Driver Object List */
 			*pDevNodeString = (u32)pszdevNode->szString;
 			LST_PutTail(pDRVObject->devNodeString,
diff --git a/drivers/dsp/bridge/services/regsup.c b/drivers/dsp/bridge/services/regsup.c
index 5251b68..b0c6e00 100644
--- a/drivers/dsp/bridge/services/regsup.c
+++ b/drivers/dsp/bridge/services/regsup.c
@@ -238,8 +238,8 @@ DSP_STATUS regsupSetValue(char *valName, void *pBuf, u32 dataSize)
 		/*  No match, need to make a new entry  */
 		/*  First check to see if we can make any more entries.  */
 		if (pRegKey->numValueEntries < BRIDGE_MAX_NUM_REG_ENTRIES) {
-                       strncpy(pRegKey->values[pRegKey->numValueEntries].name,
-                               valName, BRIDGE_MAX_NAME_SIZE);
+			strncpy(pRegKey->values[pRegKey->numValueEntries].name,
+					valName, BRIDGE_MAX_NAME_SIZE - 1);
 			pRegKey->values[pRegKey->numValueEntries].pData =
 					MEM_Alloc(dataSize, MEM_NONPAGED);
 			if (pRegKey->values[pRegKey->numValueEntries].pData !=
-- 
1.6.2.4


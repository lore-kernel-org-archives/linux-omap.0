From: Ameya Palande <ameya.palande@nokia.com>
Subject: [PATCHv2] DSPBRIDGE: Buffer size warning fixes
Date: Fri,  5 Jun 2009 15:43:02 +0300
Message-ID: <1244205782-22610-1-git-send-email-ameya.palande@nokia.com>
References: <1242730169-14523-1-git-send-email-ameya.palande@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:44322 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750984AbZFEMnF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Jun 2009 08:43:05 -0400
In-Reply-To: <1242730169-14523-1-git-send-email-ameya.palande@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: x0095840@ti.com, h-kanigeri2@ti.com

Signed-off-by: Ameya Palande <ameya.palande@nokia.com>
---
 drivers/dsp/bridge/pmgr/cod.c        |    3 ++-
 drivers/dsp/bridge/rmgr/drv.c        |    5 +++--
 drivers/dsp/bridge/services/regsup.c |    6 ++++--
 3 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/dsp/bridge/pmgr/cod.c b/drivers/dsp/bridge/pmgr/cod.c
index 6363f1e..2da46bd 100644
--- a/drivers/dsp/bridge/pmgr/cod.c
+++ b/drivers/dsp/bridge/pmgr/cod.c
@@ -628,7 +628,8 @@ DSP_STATUS COD_OpenBase(struct COD_MANAGER *hMgr, IN char *pszCoffPath,
 	} else {
 		/* hang onto the library for subsequent sym table usage */
 		hMgr->baseLib = lib;
-               strncpy(hMgr->szZLFile, pszCoffPath, COD_MAXPATHLENGTH);
+		strncpy(hMgr->szZLFile, pszCoffPath, COD_MAXPATHLENGTH - 1);
+		hMgr->szZLFile[COD_MAXPATHLENGTH - 1] = '\0';
 	}
 
 	return status;
diff --git a/drivers/dsp/bridge/rmgr/drv.c b/drivers/dsp/bridge/rmgr/drv.c
index a1ba19e..66e4a4d 100644
--- a/drivers/dsp/bridge/rmgr/drv.c
+++ b/drivers/dsp/bridge/rmgr/drv.c
@@ -1508,8 +1508,9 @@ DSP_STATUS DRV_RequestResources(u32 dwContext, u32 *pDevNodeString)
 		pszdevNode = MEM_Calloc(sizeof(struct DRV_EXT), MEM_NONPAGED);
 		if (pszdevNode) {
 			LST_InitElem(&pszdevNode->link);
-                       strncpy((char *) pszdevNode->szString,
-				 (char *)dwContext, MAXREGPATHLENGTH);
+			strncpy(pszdevNode->szString,
+				 (char *)dwContext, MAXREGPATHLENGTH - 1);
+			pszdevNode->szString[MAXREGPATHLENGTH - 1] = '\0';
 			/* Update the Driver Object List */
 			*pDevNodeString = (u32)pszdevNode->szString;
 			LST_PutTail(pDRVObject->devNodeString,
diff --git a/drivers/dsp/bridge/services/regsup.c b/drivers/dsp/bridge/services/regsup.c
index 5251b68..5cba816 100644
--- a/drivers/dsp/bridge/services/regsup.c
+++ b/drivers/dsp/bridge/services/regsup.c
@@ -238,8 +238,10 @@ DSP_STATUS regsupSetValue(char *valName, void *pBuf, u32 dataSize)
 		/*  No match, need to make a new entry  */
 		/*  First check to see if we can make any more entries.  */
 		if (pRegKey->numValueEntries < BRIDGE_MAX_NUM_REG_ENTRIES) {
-                       strncpy(pRegKey->values[pRegKey->numValueEntries].name,
-                               valName, BRIDGE_MAX_NAME_SIZE);
+			strncpy(pRegKey->values[pRegKey->numValueEntries].name,
+					valName, BRIDGE_MAX_NAME_SIZE - 1);
+			pRegKey->values[pRegKey->numValueEntries].name[BRIDGE_MAX_NAME_SIZE - 1] =
+				'\0';
 			pRegKey->values[pRegKey->numValueEntries].pData =
 					MEM_Alloc(dataSize, MEM_NONPAGED);
 			if (pRegKey->values[pRegKey->numValueEntries].pData !=
-- 
1.6.2.4


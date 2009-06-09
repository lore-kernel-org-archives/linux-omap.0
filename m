From: "Guzman Lugo, Fernando" <x0095840@ti.com>
Subject: RE: [PATCHv3] DSPBRIDGE: Buffer size warning fixes
Date: Mon, 8 Jun 2009 19:54:11 -0500
Message-ID: <496565EC904933469F292DDA3F1663E602932D2147@dlee06.ent.ti.com>
References: <1244205782-22610-1-git-send-email-ameya.palande@nokia.com>
 <1244206994-25290-1-git-send-email-ameya.palande@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:42892 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752117AbZFIAyS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Jun 2009 20:54:18 -0400
In-Reply-To: <1244206994-25290-1-git-send-email-ameya.palande@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ameya Palande <ameya.palande@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Kanigeri, Hari" <h-kanigeri2@ti.com>



Hi Ameya,

	This patch looks good, Thanks.

Regards,
Fernando.

-----Original Message-----
From: Ameya Palande [mailto:ameya.palande@nokia.com] 
Sent: Friday, June 05, 2009 8:03 AM
To: linux-omap@vger.kernel.org
Cc: Guzman Lugo, Fernando; Kanigeri, Hari
Subject: [PATCHv3] DSPBRIDGE: Buffer size warning fixes

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
index 5251b68..bec8e92 100644
--- a/drivers/dsp/bridge/services/regsup.c
+++ b/drivers/dsp/bridge/services/regsup.c
@@ -238,8 +238,10 @@ DSP_STATUS regsupSetValue(char *valName, void *pBuf, u32 dataSize)
 		/*  No match, need to make a new entry  */
 		/*  First check to see if we can make any more entries.  */
 		if (pRegKey->numValueEntries < BRIDGE_MAX_NUM_REG_ENTRIES) {
-                       strncpy(pRegKey->values[pRegKey->numValueEntries].name,
-                               valName, BRIDGE_MAX_NAME_SIZE);
+			char *tmp_name =
+				pRegKey->values[pRegKey->numValueEntries].name;
+			strncpy(tmp_name, valName, BRIDGE_MAX_NAME_SIZE - 1);
+			tmp_name[BRIDGE_MAX_NAME_SIZE - 1] = '\0';
 			pRegKey->values[pRegKey->numValueEntries].pData =
 					MEM_Alloc(dataSize, MEM_NONPAGED);
 			if (pRegKey->values[pRegKey->numValueEntries].pData !=
-- 
1.6.2.4



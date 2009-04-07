From: "Ramirez Luna, Omar" <x00omar@ti.com>
Subject: [PATCH] DSPBRIDGE: Unused pointer causing Memory Leaks
Date: Tue, 7 Apr 2009 11:22:43 -0500
Message-ID: <27F9C60D11D683428E133F85D2BB4A53040492B51D@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:33375 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751792AbZDGQXR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Apr 2009 12:23:17 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, "felipe.contreras@gmail.com" <felipe.contreras@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

From: Omar Ramirez Luna <x00omar@ti.com>
Date: Tue, 7 Apr 2009 09:51:23 -0500
Subject: [PATCH] DSPBRIDGE: Unused pointer causing Memory Leaks

There are some memory leaks whenever a dsp library is loaded.

>From my testing I have seen ~160bytes for Audio,
~280 bytes for Audio+Video are being leaked.

Also removed the same name pointer in other functions as
it is not used anyway.

Signed-off-by Omar Ramirez Luna <x00omar@ti.com>
Acked-by: Hari Kanigeri <h-kanigeri2@ti.com>
---
 drivers/dsp/bridge/rmgr/dbdcd.c |   26 ++------------------------
 1 files changed, 2 insertions(+), 24 deletions(-)

diff --git a/drivers/dsp/bridge/rmgr/dbdcd.c b/drivers/dsp/bridge/rmgr/dbdcd.c
index ae7e641..c5ec8f9 100644
--- a/drivers/dsp/bridge/rmgr/dbdcd.c
+++ b/drivers/dsp/bridge/rmgr/dbdcd.c
@@ -478,9 +478,7 @@ DSP_STATUS DCD_GetObjectDef(IN struct DCD_MANAGER *hDcdMgr,
 	char *pszCoffBuf;
 	u32 dwKeyLen;		/* Len of REG key. */
 	char szObjType[MAX_INT2CHAR_LENGTH];	/* str. rep. of objType. */
-#ifdef _DB_TIOMAP
-	char *pTempCoffBuf;
-#endif
+
 	DBC_Require(cRefs > 0);
 	DBC_Require(pObjDef != NULL);
 	DBC_Require(pObjUuid != NULL);
@@ -570,8 +568,6 @@ DSP_STATUS DCD_GetObjectDef(IN struct DCD_MANAGER *hDcdMgr,
 	/* Allocate zeroed buffer. */
 	pszCoffBuf = MEM_Calloc(ulLen + 4, MEM_PAGED);
 #ifdef _DB_TIOMAP
-	pTempCoffBuf = MEM_Calloc(ulLen + 4, MEM_PAGED);
-
        if (strstr(szRegData, "iva") == NULL) {
 		/* Locate section by objectID and read its content. */
 		status = COD_ReadSection(lib, szSectName, pszCoffBuf, ulLen);
@@ -606,9 +602,6 @@ DSP_STATUS DCD_GetObjectDef(IN struct DCD_MANAGER *hDcdMgr,
 	}
 	/* Free the previously allocated dynamic buffer. */
 	MEM_Free(pszCoffBuf);
-#ifdef _DB_TIOMAP
-	MEM_Free(pTempCoffBuf);
-#endif
 func_end:
 	if (lib)
 		COD_Close(lib);
@@ -628,9 +621,6 @@ DSP_STATUS DCD_GetObjects(IN struct DCD_MANAGER *hDcdMgr, IN char *pszCoffPath,
 	DSP_STATUS status = DSP_SOK;
 	char *pszCoffBuf;
 	char *pszCur;
-#ifdef _DB_TIOMAP
-	char *pTempCoffBuf;
-#endif
 	struct COD_LIBRARYOBJ *lib = NULL;
 	u32 ulAddr = 0;	/* Used by COD_GetSection */
 	u32 ulLen = 0;	/* Used by COD_GetSection */
@@ -638,6 +628,7 @@ DSP_STATUS DCD_GetObjects(IN struct DCD_MANAGER *hDcdMgr, IN char *pszCoffPath,
 	char *pToken = NULL;
 	struct DSP_UUID dspUuid;
 	s32 cObjectType;
+
 	DBC_Require(cRefs > 0);
 	GT_1trace(curTrace, GT_ENTER,
 		 "DCD_GetObjects: hDcdMgr 0x%x\n", hDcdMgr);
@@ -667,7 +658,6 @@ DSP_STATUS DCD_GetObjects(IN struct DCD_MANAGER *hDcdMgr, IN char *pszCoffPath,
 	/* Allocate zeroed buffer. */
 	pszCoffBuf = MEM_Calloc(ulLen + 4, MEM_PAGED);
 #ifdef _DB_TIOMAP
-	pTempCoffBuf = MEM_Calloc(ulLen + 4, MEM_PAGED);
 	if (strstr(pszCoffPath, "iva") == NULL) {
 		/* Locate section by objectID and read its content. */
 		status = COD_ReadSection(lib, DCD_REGISTER_SECTION,
@@ -730,9 +720,6 @@ DSP_STATUS DCD_GetObjects(IN struct DCD_MANAGER *hDcdMgr, IN char *pszCoffPath,
 	}
 	/* Free the previously allocated dynamic buffer. */
 	MEM_Free(pszCoffBuf);
-#ifdef _DB_TIOMAP
-	MEM_Free(pTempCoffBuf);
-#endif
 func_cont:
 	if (lib)
 		COD_Close(lib);
@@ -1479,9 +1466,6 @@ static DSP_STATUS GetDepLibInfo(IN struct DCD_MANAGER *hDcdMgr,
 	char *pszCur;
 	char *pszFileName = NULL;
 	struct COD_LIBRARYOBJ *lib = NULL;
-#ifdef _DB_TIOMAP
-	char *pTempCoffBuf;
-#endif
 	u32 ulAddr = 0;	/* Used by COD_GetSection */
 	u32 ulLen = 0;	/* Used by COD_GetSection */
 	u32 dwDataSize = COD_MAXPATHLENGTH;
@@ -1540,12 +1524,6 @@ static DSP_STATUS GetDepLibInfo(IN struct DCD_MANAGER *hDcdMgr,
 	if (pszCoffBuf == NULL)
 		status = DSP_EMEMORY;
 
-#ifdef _DB_TIOMAP
-	pTempCoffBuf = MEM_Calloc(ulLen, MEM_PAGED);
-	if (pTempCoffBuf == NULL)
-		status = DSP_EMEMORY;
-
-#endif
 	/* Read section contents. */
 	status = COD_ReadSection(lib, DEPLIBSECT, pszCoffBuf, ulLen);
 	if (DSP_FAILED(status))
-- 
1.5.4.3

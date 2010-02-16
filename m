From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 03/18] DSPBRIDGE: Remove entry point custom debug statements for pmgr
Date: Tue, 16 Feb 2010 02:42:13 -0600
Message-ID: <1266309748-11714-4-git-send-email-omar.ramirez@ti.com>
References: <1266309748-11714-1-git-send-email-omar.ramirez@ti.com>
 <1266309748-11714-2-git-send-email-omar.ramirez@ti.com>
 <1266309748-11714-3-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41225 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755796Ab0BPIaL (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 16 Feb 2010 03:30:11 -0500
In-Reply-To: <1266309748-11714-3-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Ameya Palande <ameya.palande@nokia.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, Nishanth Menon <nm@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>

Remove statements using GT_ENTER custom bridge level which is
used to print entry and exit points from functions. Only COD,
DBLL and DMM meaningful prints were left for reference when
migrating to dev_dbg.

This changes are split to touch pmgr folder only.

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 drivers/dsp/bridge/pmgr/chnl.c |   20 ------
 drivers/dsp/bridge/pmgr/cmm.c  |   16 +----
 drivers/dsp/bridge/pmgr/cod.c  |   30 +---------
 drivers/dsp/bridge/pmgr/dbll.c |   17 +-----
 drivers/dsp/bridge/pmgr/dev.c  |  137 +++++----------------------------------
 drivers/dsp/bridge/pmgr/dmm.c  |   38 +-----------
 drivers/dsp/bridge/pmgr/io.c   |   21 ------
 drivers/dsp/bridge/pmgr/msg.c  |   13 +----
 drivers/dsp/bridge/pmgr/wcd.c  |  122 +----------------------------------
 9 files changed, 28 insertions(+), 386 deletions(-)

diff --git a/drivers/dsp/bridge/pmgr/chnl.c b/drivers/dsp/bridge/pmgr/chnl.c
index e7c39b6..66464c7 100644
--- a/drivers/dsp/bridge/pmgr/chnl.c
+++ b/drivers/dsp/bridge/pmgr/chnl.c
@@ -71,11 +71,6 @@ DSP_STATUS CHNL_Create(OUT struct CHNL_MGR **phChnlMgr,
 	DBC_Require(phChnlMgr != NULL);
 	DBC_Require(pMgrAttrs != NULL);
 
-	GT_3trace(CHNL_DebugMask, GT_ENTER,
-		  "Entered CHNL_Create: phChnlMgr: 0x%x\t"
-		  "hDevObject: 0x%x\tpMgrAttrs:0x%x\n",
-		  phChnlMgr, hDevObject, pMgrAttrs);
-
 	*phChnlMgr = NULL;
 
 	/* Validate args: */
@@ -122,9 +117,6 @@ DSP_STATUS CHNL_Create(OUT struct CHNL_MGR **phChnlMgr,
 		}
 	}
 
-	GT_2trace(CHNL_DebugMask, GT_ENTER,
-		  "Exiting CHNL_Create: pChnlMgr: 0x%x,"
-		  "status: 0x%x\n", pChnlMgr, status);
 	DBC_Ensure(DSP_FAILED(status) || CHNL_IsValidMgr(pChnlMgr));
 
 	return status;
@@ -143,8 +135,6 @@ DSP_STATUS CHNL_Destroy(struct CHNL_MGR *hChnlMgr)
 
 	DBC_Require(cRefs > 0);
 
-	GT_1trace(CHNL_DebugMask, GT_ENTER,
-		  "Entered CHNL_Destroy: hChnlMgr: 0x%x\n", hChnlMgr);
 	if (CHNL_IsValidMgr(pChnlMgr)) {
 		pIntfFxns = pChnlMgr->pIntfFxns;
 		/* Let WMD channel module destroy the CHNL_MGR: */
@@ -155,9 +145,6 @@ DSP_STATUS CHNL_Destroy(struct CHNL_MGR *hChnlMgr)
 		status = DSP_EHANDLE;
 	}
 
-	GT_2trace(CHNL_DebugMask, GT_ENTER,
-		  "Exiting CHNL_Destroy: pChnlMgr: 0x%x,"
-		  " status:0x%x\n", pChnlMgr, status);
 	DBC_Ensure(DSP_FAILED(status) || !CHNL_IsValidMgr(pChnlMgr));
 
 	return status;
@@ -174,9 +161,6 @@ void CHNL_Exit(void)
 
 	cRefs--;
 
-	GT_1trace(CHNL_DebugMask, GT_5CLASS,
-		  "Entered CHNL_Exit, ref count: 0x%x\n", cRefs);
-
 	DBC_Ensure(cRefs >= 0);
 }
 
@@ -200,10 +184,6 @@ bool CHNL_Init(void)
 	if (fRetval)
 		cRefs++;
 
-	GT_1trace(CHNL_DebugMask, GT_5CLASS,
-		  "Entered CHNL_Init, ref count: 0x%x\n",
-		  cRefs);
-
 	DBC_Ensure((fRetval && (cRefs > 0)) || (!fRetval && (cRefs >= 0)));
 
 	return fRetval;
diff --git a/drivers/dsp/bridge/pmgr/cmm.c b/drivers/dsp/bridge/pmgr/cmm.c
index 03d2e63..53855a9 100644
--- a/drivers/dsp/bridge/pmgr/cmm.c
+++ b/drivers/dsp/bridge/pmgr/cmm.c
@@ -261,9 +261,6 @@ DSP_STATUS CMM_Create(OUT struct CMM_OBJECT **phCmmMgr,
 	DBC_Require(cRefs > 0);
 	DBC_Require(phCmmMgr != NULL);
 
-	GT_3trace(CMM_debugMask, GT_ENTER,
-		  "CMM_Create: phCmmMgr: 0x%x\thDevObject: "
-		  "0x%x\tpMgrAttrs: 0x%x\n", phCmmMgr, hDevObject, pMgrAttrs);
 	*phCmmMgr = NULL;
 	/* create, zero, and tag a cmm mgr object */
 	MEM_AllocObject(pCmmObject, struct CMM_OBJECT, CMMSIGNATURE);
@@ -394,9 +391,6 @@ void CMM_Exit(void)
 	DBC_Require(cRefs > 0);
 
 	cRefs--;
-
-	GT_1trace(CMM_debugMask, GT_ENTER,
-		  "exiting CMM_Exit,ref count:0x%x\n", cRefs);
 }
 
 /*
@@ -414,7 +408,7 @@ DSP_STATUS CMM_FreeBuf(struct CMM_OBJECT *hCmmMgr, void *pBufPA, u32 ulSegId)
 
 	DBC_Require(cRefs > 0);
 	DBC_Require(pBufPA != NULL);
-	GT_1trace(CMM_debugMask, GT_ENTER, "CMM_FreeBuf pBufPA %x\n", pBufPA);
+
 	if (ulSegId == 0) {
 		pAttrs = &CMM_DFLTALCTATTRS;
 		ulSegId = pAttrs->ulSegId;
@@ -554,9 +548,6 @@ bool CMM_Init(void)
 	if (fRetval)
 		cRefs++;
 
-	GT_1trace(CMM_debugMask, GT_ENTER,
-		  "Entered CMM_Init,ref count:0x%x\n", cRefs);
-
 	DBC_Ensure((fRetval && (cRefs > 0)) || (!fRetval && (cRefs >= 0)));
 
 	return fRetval;
@@ -1012,10 +1003,7 @@ DSP_STATUS CMM_XlatorCreate(OUT struct CMM_XLATOROBJECT **phXlator,
 	DBC_Require(cRefs > 0);
 	DBC_Require(phXlator != NULL);
 	DBC_Require(hCmmMgr != NULL);
-	GT_3trace(CMM_debugMask, GT_ENTER,
-		  "CMM_XlatorCreate: phXlator: 0x%x\t"
-		  "phCmmMgr: 0x%x\tpXlAttrs: 0x%x\n", phXlator,
-		  hCmmMgr, pXlatorAttrs);
+
 	*phXlator = NULL;
 	if (pXlatorAttrs == NULL)
 		pXlatorAttrs = &CMM_DFLTXLATORATTRS;	/* set defaults */
diff --git a/drivers/dsp/bridge/pmgr/cod.c b/drivers/dsp/bridge/pmgr/cod.c
index 8a18ef9..6f659e5 100644
--- a/drivers/dsp/bridge/pmgr/cod.c
+++ b/drivers/dsp/bridge/pmgr/cod.c
@@ -232,10 +232,6 @@ DSP_STATUS COD_Create(OUT struct COD_MANAGER **phMgr, char *pstrDummyFile,
 	DBC_Require(cRefs > 0);
 	DBC_Require(phMgr != NULL);
 
-	GT_3trace(COD_debugMask, GT_ENTER,
-		  "Entered COD_Create, Args: \t\nphMgr: "
-		  "0x%x\t\npstrDummyFile: 0x%x\t\nattr: 0x%x\n",
-		  phMgr, pstrDummyFile, attrs);
 	/* assume failure */
 	*phMgr = NULL;
 
@@ -288,8 +284,7 @@ DSP_STATUS COD_Create(OUT struct COD_MANAGER **phMgr, char *pstrDummyFile,
 
 	/* return the new manager */
 	*phMgr = hMgrNew;
-	GT_1trace(COD_debugMask, GT_1CLASS,
-		  "COD_Create: Success CodMgr: 0x%x\n",	*phMgr);
+
 	return DSP_SOK;
 }
 
@@ -303,7 +298,6 @@ void COD_Delete(struct COD_MANAGER *hMgr)
 	DBC_Require(cRefs > 0);
 	DBC_Require(IsValid(hMgr));
 
-	GT_1trace(COD_debugMask, GT_ENTER, "COD_Delete:hMgr 0x%x\n", hMgr);
 	if (hMgr->baseLib) {
 		if (hMgr->fLoaded)
 			hMgr->fxns.unloadFxn(hMgr->baseLib, &hMgr->attrs);
@@ -330,9 +324,6 @@ void COD_Exit(void)
 
 	cRefs--;
 
-	GT_1trace(COD_debugMask, GT_ENTER,
-		  "Entered COD_Exit, ref count:  0x%x\n", cRefs);
-
 	DBC_Ensure(cRefs >= 0);
 }
 
@@ -389,9 +380,6 @@ DSP_STATUS COD_GetEntry(struct COD_MANAGER *hManager, u32 *pulEntry)
 
 	*pulEntry = hManager->ulEntry;
 
-	GT_1trace(COD_debugMask, GT_ENTER, "COD_GetEntry:ulEntr 0x%x\n",
-		  *pulEntry);
-
 	return DSP_SOK;
 }
 
@@ -433,10 +421,6 @@ DSP_STATUS COD_GetSection(struct COD_LIBRARYOBJ *lib, IN char *pstrSect,
 	DBC_Require(puAddr != NULL);
 	DBC_Require(puLen != NULL);
 
-	GT_4trace(COD_debugMask, GT_ENTER,
-		  "Entered COD_GetSection Args \t\n lib: "
-		  "0x%x\t\npstrsect: 0x%x\t\npuAddr: 0x%x\t\npuLen: 0x%x\n",
-		  lib, pstrSect, puAddr, puLen);
 	*puAddr = 0;
 	*puLen = 0;
 	if (lib != NULL) {
@@ -521,9 +505,6 @@ bool COD_Init(void)
 	if (fRetVal)
 		cRefs++;
 
-
-	GT_1trace(COD_debugMask, GT_1CLASS,
-		  "Entered COD_Init, ref count: 0x%x\n", cRefs);
 	DBC_Ensure((fRetVal && cRefs > 0) || (!fRetVal && cRefs >= 0));
 	return fRetVal;
 }
@@ -558,11 +539,6 @@ DSP_STATUS COD_LoadBase(struct COD_MANAGER *hMgr, u32 nArgc, char *aArgs[],
 	DBC_Require(pfnWrite != NULL);
 	DBC_Require(hMgr->baseLib != NULL);
 
-	GT_6trace(COD_debugMask, GT_ENTER,
-		 "Entered COD_LoadBase, hMgr:  0x%x\n \t"
-		 "nArgc:  0x%x\n\taArgs:  0x%x\n\tpfnWrite:  0x%x\n\tpArb:"
-		 " 0x%x\n \tenvp:  0x%x\n", hMgr, nArgc, aArgs, pfnWrite,
-		 pArb, envp);
 	/*
 	 *  Make sure every argv[] stated in argc has a value, or change argc to
 	 *  reflect true number in NULL terminated argv array.
@@ -711,10 +687,6 @@ DSP_STATUS COD_ReadSection(struct COD_LIBRARYOBJ *lib, IN char *pstrSect,
 	DBC_Require(pstrSect != NULL);
 	DBC_Require(pstrContent != NULL);
 
-	GT_4trace(COD_debugMask, GT_ENTER, "Entered COD_ReadSection Args: 0x%x,"
-		 " 0x%x, 0x%x, 0x%x\n", lib, pstrSect, pstrContent,
-		 cContentSize);
-
 	if (lib != NULL) {
 		status = lib->hCodMgr->fxns.readSectFxn(lib->dbllLib, pstrSect,
 							pstrContent,
diff --git a/drivers/dsp/bridge/pmgr/dbll.c b/drivers/dsp/bridge/pmgr/dbll.c
index af71212..22e08bd 100644
--- a/drivers/dsp/bridge/pmgr/dbll.c
+++ b/drivers/dsp/bridge/pmgr/dbll.c
@@ -220,7 +220,6 @@ void DBLL_close(struct DBLL_LibraryObj *zlLib)
 	DBC_Require(MEM_IsValidHandle(zlLib, DBLL_LIBSIGNATURE));
 	DBC_Require(zlLib->openRef > 0);
 	zlTarget = zlLib->pTarget;
-	GT_1trace(DBLL_debugMask, GT_ENTER, "DBLL_close: lib: 0x%x\n", zlLib);
 	zlLib->openRef--;
 	if (zlLib->openRef == 0) {
 		/* Remove library from list */
@@ -259,9 +258,6 @@ DSP_STATUS DBLL_create(struct DBLL_TarObj **pTarget, struct DBLL_Attrs *pAttrs)
 	DBC_Require(pAttrs != NULL);
 	DBC_Require(pTarget != NULL);
 
-	GT_2trace(DBLL_debugMask, GT_ENTER,
-		  "DBLL_create: pTarget: 0x%x pAttrs: "
-		  "0x%x\n", pTarget, pAttrs);
 	/* Allocate DBL target object */
 	MEM_AllocObject(pzlTarget, struct DBLL_TarObj, DBLL_TARGSIGNATURE);
 	if (pTarget != NULL) {
@@ -294,9 +290,6 @@ void DBLL_delete(struct DBLL_TarObj *target)
 	DBC_Require(cRefs > 0);
 	DBC_Require(MEM_IsValidHandle(zlTarget, DBLL_TARGSIGNATURE));
 
-	GT_1trace(DBLL_debugMask, GT_ENTER, "DBLL_delete: target: 0x%x\n",
-		 target);
-
 	if (zlTarget != NULL)
 		MEM_FreeObject(zlTarget);
 
@@ -312,9 +305,6 @@ void DBLL_exit(void)
 
 	cRefs--;
 
-	GT_1trace(DBLL_debugMask, GT_5CLASS, "DBLL_exit() ref count: 0x%x\n",
-		  cRefs);
-
 	if (cRefs == 0) {
 		GH_exit();
 #if GT_TRACE
@@ -476,9 +466,6 @@ bool DBLL_init(void)
 
 	cRefs++;
 
-	GT_1trace(DBLL_debugMask, GT_5CLASS, "DBLL_init(), ref count:  0x%x\n",
-		 cRefs);
-
 	return true;
 }
 
@@ -848,9 +835,7 @@ void DBLL_setAttrs(struct DBLL_TarObj *target, struct DBLL_Attrs *pAttrs)
 	DBC_Require(cRefs > 0);
 	DBC_Require(MEM_IsValidHandle(zlTarget, DBLL_TARGSIGNATURE));
 	DBC_Require(pAttrs != NULL);
-	GT_2trace(DBLL_debugMask, GT_ENTER,
-		 "DBLL_setAttrs: target: 0x%x pAttrs: "
-		 "0x%x\n", target, pAttrs);
+
 	if ((pAttrs != NULL) && (zlTarget != NULL))
 		zlTarget->attrs = *pAttrs;
 
diff --git a/drivers/dsp/bridge/pmgr/dev.c b/drivers/dsp/bridge/pmgr/dev.c
index d86bc9c..5719519 100644
--- a/drivers/dsp/bridge/pmgr/dev.c
+++ b/drivers/dsp/bridge/pmgr/dev.c
@@ -115,11 +115,6 @@ u32 DEV_BrdWriteFxn(void *pArb, u32 ulDspAddr, void *pHostBuf,
 
 	DBC_Require(cRefs > 0);
 	DBC_Require(pHostBuf != NULL);	/* Required of BrdWrite(). */
-	GT_5trace(debugMask, GT_ENTER,
-		"Entered DEV_BrdWriteFxn, pArb: 0x%x\n\t\t"
-		"ulDspAddr: 0x%x\n\t\tpHostBuf: 0x%x\n \t\tulNumBytes:  0x%x\n"
-		"\t\tnMemSpace:  0x%x\n", pArb, ulDspAddr, pHostBuf,
-		ulNumBytes, nMemSpace);
 	if (IsValidHandle(pDevObject)) {
 		/* Require of BrdWrite() */
 		DBC_Assert(pDevObject->hWmdContext != NULL);
@@ -133,8 +128,6 @@ u32 DEV_BrdWriteFxn(void *pArb, u32 ulDspAddr, void *pHostBuf,
 			ulWritten = ulNumBytes;
 
 	}
-	GT_1trace(debugMask, GT_ENTER, "Exit DEV_BrdWriteFxn ulWritten: 0x%x\n",
-		  ulWritten);
 	return ulWritten;
 }
 
@@ -164,11 +157,6 @@ DSP_STATUS DEV_CreateDevice(OUT struct DEV_OBJECT **phDevObject,
 	DBC_Require(pHostConfig != NULL);
 	DBC_Require(pDspConfig != NULL);
 
-	GT_5trace(debugMask, GT_ENTER,
-		  "Entered DEV_CreateDevice, phDevObject: 0x%x\n"
-		  "\t\tpstrWMDFileName:  0x%x\n\t\tpHostConfig:0x%x\n\t\t"
-		  "pDspConfig:  0x%x\n\t\tnhDevNode:  0x%x\n", phDevObject,
-		  pstrWMDFileName, pHostConfig, pDspConfig, hDevNode);
 	/*  Get the WMD interface functions*/
 	WMD_DRV_Entry(&pDrvFxns, pstrWMDFileName);
 	if (DSP_FAILED(CFG_GetObject((u32 *) &hDrvObject, REG_DRV_OBJECT))) {
@@ -309,8 +297,7 @@ DSP_STATUS DEV_CreateDevice(OUT struct DEV_OBJECT **phDevObject,
 		*phDevObject = NULL;
 		GT_0trace(debugMask, GT_7CLASS, "DEV_CreateDevice Failed\n");
 	}
-	GT_1trace(debugMask, GT_1CLASS, "Exiting DEV_Create: DevObject 0x%x\n",
-		 *phDevObject);
+
 	DBC_Ensure((DSP_SUCCEEDED(status) && IsValidHandle(*phDevObject)) ||
 		  (DSP_FAILED(status) && !*phDevObject));
 	return status;
@@ -331,8 +318,6 @@ DSP_STATUS DEV_Create2(struct DEV_OBJECT *hDevObject)
 	DBC_Require(cRefs > 0);
 	DBC_Require(IsValidHandle(hDevObject));
 
-	GT_1trace(debugMask, GT_ENTER,
-		 "Entered DEV_Create2, hDevObject: 0x%x\n", hDevObject);
 	/* There can be only one Node Manager per DEV object */
 	DBC_Assert(!pDevObject->hNodeMgr);
 	status = NODE_CreateMgr(&pDevObject->hNodeMgr, hDevObject);
@@ -345,9 +330,6 @@ DSP_STATUS DEV_Create2(struct DEV_OBJECT *hDevObject)
 	}
 	DBC_Ensure((DSP_SUCCEEDED(status) && pDevObject->hNodeMgr != NULL)
 		   || (DSP_FAILED(status) && pDevObject->hNodeMgr == NULL));
-	GT_2trace(debugMask, GT_ENTER,
-		  "Exiting DEV_Create2, hNodeMgr:  0x%x, status:"
-		  " 0x%x\n", pDevObject->hNodeMgr, status);
 	return status;
 }
 
@@ -364,9 +346,6 @@ DSP_STATUS DEV_Destroy2(struct DEV_OBJECT *hDevObject)
 	DBC_Require(cRefs > 0);
 	DBC_Require(IsValidHandle(hDevObject));
 
-	GT_1trace(debugMask, GT_ENTER,
-		 "Entered DEV_Destroy2, hDevObject: 0x%x\n",
-		 hDevObject);
 	if (pDevObject->hNodeMgr) {
 		if (DSP_FAILED(NODE_DeleteMgr(pDevObject->hNodeMgr)))
 			status = DSP_EFAIL;
@@ -379,9 +358,6 @@ DSP_STATUS DEV_Destroy2(struct DEV_OBJECT *hDevObject)
 
 	DBC_Ensure((DSP_SUCCEEDED(status) && pDevObject->hNodeMgr == NULL) ||
 		  DSP_FAILED(status));
-	GT_2trace(debugMask, GT_ENTER,
-		 "Exiting DEV_Destroy2, hNodeMgr: 0x%x, status"
-		 " = 0x%x\n", pDevObject->hNodeMgr, status);
 	return status;
 }
 
@@ -398,8 +374,6 @@ DSP_STATUS DEV_DestroyDevice(struct DEV_OBJECT *hDevObject)
 
 	DBC_Require(cRefs > 0);
 
-	GT_1trace(debugMask, GT_ENTER, "Entered DEV_DestroyDevice, hDevObject: "
-		 "0x%x\n", hDevObject);
 	if (IsValidHandle(hDevObject)) {
 		if (pDevObject->hCodMgr) {
 			COD_Delete(pDevObject->hCodMgr);
@@ -465,8 +439,7 @@ DSP_STATUS DEV_DestroyDevice(struct DEV_OBJECT *hDevObject)
 		GT_0trace(debugMask, GT_7CLASS, "DEV_Destroy: Invlaid handle");
 		status = DSP_EHANDLE;
 	}
-	GT_1trace(debugMask, GT_ENTER, "Exit DEV_destroy: status 0x%x\n",
-		 status);
+
 	return status;
 }
 
@@ -485,9 +458,6 @@ DSP_STATUS DEV_GetChnlMgr(struct DEV_OBJECT *hDevObject,
 	DBC_Require(cRefs > 0);
 	DBC_Require(phMgr != NULL);
 
-	GT_2trace(debugMask, GT_ENTER,
-		 "Entered DEV_GetChnlMgr, hDevObject: 0x%x\n\t"
-		 "\tphMgr: 0x%x\n", hDevObject, phMgr);
 	if (IsValidHandle(hDevObject)) {
 		*phMgr = pDevObject->hChnlMgr;
 	} else {
@@ -496,9 +466,7 @@ DSP_STATUS DEV_GetChnlMgr(struct DEV_OBJECT *hDevObject,
 		GT_0trace(debugMask, GT_7CLASS,
 			 "DEV_GetChnlMgr: Invalid handle");
 	}
-	GT_2trace(debugMask, GT_ENTER,
-		 "Exit DEV_GetChnlMgr: status 0x%x\t\n hMgr: "
-		 "0x%x\n", status, *phMgr);
+
 	DBC_Ensure(DSP_SUCCEEDED(status) || ((phMgr != NULL) &&
 		  (*phMgr == NULL)));
 	return status;
@@ -518,9 +486,7 @@ DSP_STATUS DEV_GetCmmMgr(struct DEV_OBJECT *hDevObject,
 
 	DBC_Require(cRefs > 0);
 	DBC_Require(phMgr != NULL);
-	GT_2trace(debugMask, GT_ENTER,
-		 "Entered DEV_GetCmmMgr, hDevObject:  0x%x\n\t"
-		 "\tphMgr:  0x%x\n", hDevObject, phMgr);
+
 	if (IsValidHandle(hDevObject)) {
 		*phMgr = pDevObject->hCmmMgr;
 	} else {
@@ -529,9 +495,7 @@ DSP_STATUS DEV_GetCmmMgr(struct DEV_OBJECT *hDevObject,
 		GT_0trace(debugMask, GT_7CLASS,
 			 "DEV_GetCmmMgr: Invalid handle");
 	}
-	GT_2trace(debugMask, GT_ENTER,
-		 "Exit DEV_GetCmmMgr: status 0x%x\t\nhMgr: "
-		 "0x%x\n", status, *phMgr);
+
 	DBC_Ensure(DSP_SUCCEEDED(status) || ((phMgr != NULL) &&
 		  (*phMgr == NULL)));
 	return status;
@@ -552,8 +516,6 @@ DSP_STATUS DEV_GetDmmMgr(struct DEV_OBJECT *hDevObject,
 	DBC_Require(cRefs > 0);
 	DBC_Require(phMgr != NULL);
 
-	GT_2trace(debugMask, GT_ENTER, "Entered DEV_GetDmmMgr, hDevObject: "
-		 "0x%x\n\t\tphMgr: 0x%x\n", hDevObject, phMgr);
 	if (IsValidHandle(hDevObject)) {
 		*phMgr = pDevObject->hDmmMgr;
 	} else {
@@ -562,9 +524,7 @@ DSP_STATUS DEV_GetDmmMgr(struct DEV_OBJECT *hDevObject,
 		GT_0trace(debugMask, GT_7CLASS,
 			 "DEV_GetDmmMgr: Invalid handle");
 	}
-	GT_2trace(debugMask, GT_ENTER,
-		 "Exit DEV_GetDmmMgr: status 0x%x\t\n hMgr: "
-		 "0x%x\n", status, *phMgr);
+
 	DBC_Ensure(DSP_SUCCEEDED(status) || ((phMgr != NULL) &&
 		  (*phMgr == NULL)));
 	return status;
@@ -584,9 +544,6 @@ DSP_STATUS DEV_GetCodMgr(struct DEV_OBJECT *hDevObject,
 	DBC_Require(cRefs > 0);
 	DBC_Require(phCodMgr != NULL);
 
-	GT_2trace(debugMask, GT_ENTER,
-		 "Entered DEV_GetCodMgr, hDevObject: 0x%x\n\t\t"
-		 "phCodMgr: 0x%x\n", hDevObject, phCodMgr);
 	if (IsValidHandle(hDevObject)) {
 		*phCodMgr = pDevObject->hCodMgr;
 	} else {
@@ -596,9 +553,7 @@ DSP_STATUS DEV_GetCodMgr(struct DEV_OBJECT *hDevObject,
 			 "DEV_GetCodMgr, invalid handle:  0x%x\n",
 			 hDevObject);
 	}
-	GT_2trace(debugMask, GT_ENTER,
-		 "Exit DEV_GetCodMgr: status 0x%x\t\n hCodMgr:"
-		 " 0x%x\n", status, *phCodMgr);
+
 	DBC_Ensure(DSP_SUCCEEDED(status) || ((phCodMgr != NULL) &&
 		  (*phCodMgr == NULL)));
 	return status;
@@ -640,9 +595,6 @@ DSP_STATUS DEV_GetDevNode(struct DEV_OBJECT *hDevObject,
 	DBC_Require(cRefs > 0);
 	DBC_Require(phDevNode != NULL);
 
-	GT_2trace(debugMask, GT_ENTER,
-		 "Entered DEV_GetDevNode, hDevObject: 0x%x\n\t"
-		 "\tphDevNode: 0x%x\n", hDevObject, phDevNode);
 	if (IsValidHandle(hDevObject)) {
 		*phDevNode = pDevObject->hDevNode;
 	} else {
@@ -651,9 +603,7 @@ DSP_STATUS DEV_GetDevNode(struct DEV_OBJECT *hDevObject,
 		GT_0trace(debugMask, GT_7CLASS,
 			 "DEV_GetDevNode: Invalid handle");
 	}
-	GT_2trace(debugMask, GT_ENTER,
-		 "Exit DEV_GetDevNode: status 0x%x\t\nhDevNode:"
-		 "0x%x\n", status, *phDevNode);
+
 	DBC_Ensure(DSP_SUCCEEDED(status) || ((phDevNode != NULL) &&
 		  (*phDevNode == NULL)));
 	return status;
@@ -691,9 +641,6 @@ DSP_STATUS DEV_GetIntfFxns(struct DEV_OBJECT *hDevObject,
 	DBC_Require(cRefs > 0);
 	DBC_Require(ppIntfFxns != NULL);
 
-	GT_2trace(debugMask, GT_ENTER,
-		 "Entered DEV_GetIntfFxns, hDevObject: 0x%x\n\t"
-		 "\tppIntfFxns: 0x%x\n", hDevObject, ppIntfFxns);
 	if (IsValidHandle(hDevObject)) {
 		*ppIntfFxns = &pDevObject->intfFxns;
 	} else {
@@ -702,8 +649,7 @@ DSP_STATUS DEV_GetIntfFxns(struct DEV_OBJECT *hDevObject,
 		GT_0trace(debugMask, GT_7CLASS,
 			  "DEV_GetIntDxns: Invalid handle");
 	}
-	GT_2trace(debugMask, GT_ENTER, "Exit DEV_GetIntFxns: status 0x%x\t\n"
-		 "ppIntFxns: 0x%x\n", status, *ppIntfFxns);
+
 	DBC_Ensure(DSP_SUCCEEDED(status) || ((ppIntfFxns != NULL) &&
 		  (*ppIntfFxns == NULL)));
 	return status;
@@ -778,9 +724,6 @@ DSP_STATUS DEV_GetNodeManager(struct DEV_OBJECT *hDevObject,
 	DBC_Require(cRefs > 0);
 	DBC_Require(phNodeMgr != NULL);
 
-	GT_2trace(debugMask, GT_ENTER,
-		 "Entered DEV_GetNodeManager, hDevObject: 0x%x"
-		 "\n\t\tphNodeMgr: 0x%x\n", hDevObject, phNodeMgr);
 	if (IsValidHandle(hDevObject)) {
 		*phNodeMgr = pDevObject->hNodeMgr;
 	} else {
@@ -790,9 +733,7 @@ DSP_STATUS DEV_GetNodeManager(struct DEV_OBJECT *hDevObject,
 			 "DEV_GetNodeManager, invalid handle: 0x"
 			 "%x\n", hDevObject);
 	}
-	GT_2trace(debugMask, GT_ENTER,
-		 "Exit DEV_GetNodeManager: status 0x%x\t\nhMgr:"
-		 " 0x%x\n", status, *phNodeMgr);
+
 	DBC_Ensure(DSP_SUCCEEDED(status) || ((phNodeMgr != NULL) &&
 		  (*phNodeMgr == NULL)));
 	return status;
@@ -810,10 +751,6 @@ DSP_STATUS DEV_GetSymbol(struct DEV_OBJECT *hDevObject,
 	DBC_Require(cRefs > 0);
 	DBC_Require(pstrSym != NULL && pulValue != NULL);
 
-	GT_3trace(debugMask, GT_ENTER,
-		 "Entered DEV_GetSymbol, hDevObject: 0x%x\n\t\t"
-		 "pstrSym: 0x%x\n\t\tpulValue: 0x%x\n", hDevObject, pstrSym,
-		 pulValue);
 	if (IsValidHandle(hDevObject)) {
 		status = DEV_GetCodMgr(hDevObject, &hCodMgr);
 		if (DSP_SUCCEEDED(status)) {
@@ -826,8 +763,7 @@ DSP_STATUS DEV_GetSymbol(struct DEV_OBJECT *hDevObject,
 		GT_0trace(debugMask, GT_7CLASS,
 			 "DEV_GetSymbol: Invalid handle");
 	}
-	GT_2trace(debugMask, GT_ENTER, "Exit DEV_GetSymbol: status 0x%x\t\n"
-		 "hWmdContext: 0x%x\n", status, *pulValue);
+
 	return status;
 }
 
@@ -844,9 +780,7 @@ DSP_STATUS DEV_GetWMDContext(struct DEV_OBJECT *hDevObject,
 
 	DBC_Require(cRefs > 0);
 	DBC_Require(phWmdContext != NULL);
-	GT_2trace(debugMask, GT_ENTER,
-		  "Entered DEV_GetWMDContext, hDevObject: 0x%x\n"
-		  "\t\tphWmdContext: 0x%x\n", hDevObject, phWmdContext);
+
 	if (IsValidHandle(hDevObject)) {
 		*phWmdContext = pDevObject->hWmdContext;
 	} else {
@@ -856,9 +790,6 @@ DSP_STATUS DEV_GetWMDContext(struct DEV_OBJECT *hDevObject,
 			 "DEV_GetWMDContext: Invalid handle");
 	}
 
-	GT_2trace(debugMask, GT_ENTER,
-		 "Exit DEV_GetWMDContext: status 0x%x\t\n"
-		 "hWmdContext: 0x%x\n", status, *phWmdContext);
 	DBC_Ensure(DSP_SUCCEEDED(status) || ((phWmdContext != NULL) &&
 		  (*phWmdContext == NULL)));
 	return status;
@@ -881,9 +812,6 @@ void DEV_Exit(void)
 		DMM_Exit();
 	}
 
-	GT_1trace(debugMask, GT_5CLASS, "Entered DEV_Exit, ref count: 0x%x\n",
-		 cRefs);
-
 	DBC_Ensure(cRefs >= 0);
 }
 
@@ -921,10 +849,6 @@ bool DEV_Init(void)
 	if (fRetval)
 		cRefs++;
 
-
-	GT_1trace(debugMask, GT_5CLASS, "Entered DEV_Init, ref count: 0x%x\n",
-		 cRefs);
-
 	DBC_Ensure((fRetval && (cRefs > 0)) || (!fRetval && (cRefs >= 0)));
 
 	return fRetval;
@@ -942,9 +866,6 @@ DSP_STATUS DEV_NotifyClients(struct DEV_OBJECT *hDevObject, u32 ulStatus)
 	struct DEV_OBJECT *pDevObject = hDevObject;
 	DSP_HPROCESSOR hProcObject;
 
-	GT_2trace(debugMask, GT_ENTER,
-		 "Entered DEV_NotifyClients, hDevObject: 0x%x\n"
-		 "\t\tulStatus: 0x%x\n", hDevObject, ulStatus);
 	for (hProcObject = (DSP_HPROCESSOR)LST_First(pDevObject->procList);
 		hProcObject != NULL;
 		hProcObject = (DSP_HPROCESSOR)LST_Next(pDevObject->procList,
@@ -963,8 +884,6 @@ DSP_STATUS DEV_RemoveDevice(struct CFG_DEVNODE *hDevNode)
 	DSP_STATUS status = DSP_SOK;
 	struct DEV_OBJECT *pDevObject;
 
-	GT_1trace(debugMask, GT_ENTER,
-		 "Entered DEV_RemoveDevice, hDevNode:  0x%x\n", hDevNode);
 	/* Retrieve the device object handle originaly stored with
 	 * the DevNode: */
 	status = CFG_GetDevObject(hDevNode, (u32 *)&hDevObject);
@@ -979,8 +898,7 @@ DSP_STATUS DEV_RemoveDevice(struct CFG_DEVNODE *hDevNode)
 				 "DEV_RemoveDevice, success");
 		}
 	}
-	GT_1trace(debugMask, GT_ENTER, "Exit DEV_RemoveDevice, status: 0x%x\n",
-		  status);
+
 	return status;
 }
 
@@ -996,9 +914,6 @@ DSP_STATUS DEV_SetChnlMgr(struct DEV_OBJECT *hDevObject, struct CHNL_MGR *hMgr)
 
 	DBC_Require(cRefs > 0);
 
-	GT_2trace(debugMask, GT_ENTER,
-		 "Entered DEV_SetChnlMgr, hDevObject: 0x%x\n\t"
-		 "\thMgr:0x%x\n", hDevObject, hMgr);
 	if (IsValidHandle(hDevObject)) {
 		pDevObject->hChnlMgr = hMgr;
 	} else {
@@ -1019,9 +934,7 @@ void DEV_SetMsgMgr(struct DEV_OBJECT *hDevObject, struct MSG_MGR *hMgr)
 {
 	DBC_Require(cRefs > 0);
 	DBC_Require(IsValidHandle(hDevObject));
-	GT_2trace(debugMask, GT_ENTER,
-		 "Entered DEV_SetMsgMgr, hDevObject: 0x%x\n\t\t"
-		 "hMgr: 0x%x\n", hDevObject, hMgr);
+
 	hDevObject->hMsgMgr = hMgr;
 }
 
@@ -1041,8 +954,6 @@ DSP_STATUS DEV_StartDevice(struct CFG_DEVNODE *hDevNode)
 
 	DBC_Require(cRefs > 0);
 
-	GT_1trace(debugMask, GT_ENTER,
-		 "Entered DEV_StartDevice, hDevObject: 0x%x\n", hDevNode);
 		status = CFG_GetHostResources(hDevNode, &hostRes);
 		if (DSP_SUCCEEDED(status)) {
 			/* Get DSP resources of device from Registry: */
@@ -1094,8 +1005,7 @@ DSP_STATUS DEV_StartDevice(struct CFG_DEVNODE *hDevNode)
 		/* Ensure the device extension is NULL */
 		CFG_SetDevObject(hDevNode, 0L);
 	}
-	GT_1trace(debugMask, GT_ENTER, "Exiting DEV_StartDevice status 0x%x\n",
-		 status);
+
 	return status;
 }
 
@@ -1159,11 +1069,9 @@ static DSP_STATUS InitCodMgr(struct DEV_OBJECT *pDevObject)
 	DBC_Require(cRefs > 0);
 	DBC_Require(!IsValidHandle(pDevObject) ||
 		   (pDevObject->hCodMgr == NULL));
-	GT_1trace(debugMask, GT_ENTER, "Entering InitCodMgr pDevObject: 0x%x",
-		 pDevObject);
+
 	status = COD_Create(&pDevObject->hCodMgr, szDummyFile, NULL);
-	GT_1trace(debugMask, GT_ENTER, "Exiting InitCodMgr status 0x%x\n ",
-		 status);
+
 	return status;
 }
 
@@ -1193,9 +1101,6 @@ DSP_STATUS DEV_InsertProcObject(struct DEV_OBJECT *hDevObject,
 	DSP_STATUS status = DSP_SOK;
 	struct DEV_OBJECT *pDevObject = (struct DEV_OBJECT *)hDevObject;
 
-	GT_2trace(debugMask, GT_ENTER,
-		 "Entering DEV_InsetProcObject pProcObject 0x%x"
-		 "pDevObject 0x%x\n", hProcObject, hDevObject);
 	DBC_Require(cRefs > 0);
 	DBC_Require(IsValidHandle(pDevObject));
 	DBC_Require(hProcObject != 0);
@@ -1207,8 +1112,6 @@ DSP_STATUS DEV_InsertProcObject(struct DEV_OBJECT *hDevObject,
 	/* Add DevObject to tail. */
 	LST_PutTail(pDevObject->procList, (struct list_head *)hProcObject);
 
-	GT_1trace(debugMask, GT_ENTER,
-		 "Exiting DEV_InsetProcObject status 0x%x\n", status);
 	DBC_Ensure(DSP_SUCCEEDED(status) && !LST_IsEmpty(pDevObject->procList));
 
 	return status;
@@ -1244,9 +1147,6 @@ DSP_STATUS DEV_RemoveProcObject(struct DEV_OBJECT *hDevObject,
 	DBC_Require(pDevObject->procList != NULL);
 	DBC_Require(!LST_IsEmpty(pDevObject->procList));
 
-	GT_1trace(debugMask, GT_ENTER,
-		 "Entering DEV_RemoveProcObject hDevObject "
-		 "0x%x\n", hDevObject);
 	/* Search list for pDevObject: */
 	for (pCurElem = LST_First(pDevObject->procList); pCurElem != NULL;
 	    pCurElem = LST_Next(pDevObject->procList, pCurElem)) {
@@ -1257,8 +1157,7 @@ DSP_STATUS DEV_RemoveProcObject(struct DEV_OBJECT *hDevObject,
 			break;
 		}
 	}
-	GT_1trace(debugMask, GT_ENTER, "DEV_RemoveProcObject returning 0x%x\n",
-		 status);
+
 	return status;
 }
 
diff --git a/drivers/dsp/bridge/pmgr/dmm.c b/drivers/dsp/bridge/pmgr/dmm.c
index 2425f0f..8dbcb77 100644
--- a/drivers/dsp/bridge/pmgr/dmm.c
+++ b/drivers/dsp/bridge/pmgr/dmm.c
@@ -102,9 +102,6 @@ DSP_STATUS DMM_CreateTables(struct DMM_OBJECT *hDmmMgr, u32 addr, u32 size)
 	struct DMM_OBJECT *pDmmObj = (struct DMM_OBJECT *)hDmmMgr;
 	DSP_STATUS status = DSP_SOK;
 
-	GT_3trace(DMM_debugMask, GT_ENTER,
-		 "Entered DMM_CreateTables () hDmmMgr %x, addr"
-		 " %x, size %x\n", hDmmMgr, addr, size);
 	status = DMM_DeleteTables(pDmmObj);
 	if (DSP_SUCCEEDED(status)) {
 		SYNC_EnterCS(pDmmObj->hDmmLock);
@@ -128,8 +125,6 @@ DSP_STATUS DMM_CreateTables(struct DMM_OBJECT *hDmmMgr, u32 addr, u32 size)
 			 "DMM_CreateTables: DMM_DeleteTables"
 			 "Failure\n");
 
-	GT_1trace(DMM_debugMask, GT_4CLASS, "Leaving DMM_CreateTables status"
-							"0x%x\n", status);
 	return status;
 }
 
@@ -147,9 +142,6 @@ DSP_STATUS DMM_Create(OUT struct DMM_OBJECT **phDmmMgr,
 	DBC_Require(cRefs > 0);
 	DBC_Require(phDmmMgr != NULL);
 
-	GT_3trace(DMM_debugMask, GT_ENTER,
-		 "DMM_Create: phDmmMgr: 0x%x hDevObject: "
-		 "0x%x pMgrAttrs: 0x%x\n", phDmmMgr, hDevObject, pMgrAttrs);
 	*phDmmMgr = NULL;
 	/* create, zero, and tag a cmm mgr object */
 	MEM_AllocObject(pDmmObject, struct DMM_OBJECT, DMMSIGNATURE);
@@ -165,9 +157,6 @@ DSP_STATUS DMM_Create(OUT struct DMM_OBJECT **phDmmMgr,
 			 "Failure(DMM Object)\n");
 		status = DSP_EMEMORY;
 	}
-	GT_2trace(DMM_debugMask, GT_4CLASS,
-			"Leaving DMM_Create status %x pDmmObject %x\n",
-			status, pDmmObject);
 
 	return status;
 }
@@ -182,8 +171,6 @@ DSP_STATUS DMM_Destroy(struct DMM_OBJECT *hDmmMgr)
 	struct DMM_OBJECT *pDmmObj = (struct DMM_OBJECT *)hDmmMgr;
 	DSP_STATUS status = DSP_SOK;
 
-	GT_1trace(DMM_debugMask, GT_ENTER,
-		"Entered DMM_Destroy () hDmmMgr %x\n", hDmmMgr);
 	DBC_Require(cRefs > 0);
 	if (MEM_IsValidHandle(hDmmMgr, DMMSIGNATURE)) {
 		status = DMM_DeleteTables(pDmmObj);
@@ -197,8 +184,7 @@ DSP_STATUS DMM_Destroy(struct DMM_OBJECT *hDmmMgr)
 			 "Failure\n");
 	} else
 		status = DSP_EHANDLE;
-	GT_1trace(DMM_debugMask, GT_4CLASS, "Leaving DMM_Destroy status %x\n",
-								status);
+
 	return status;
 }
 
@@ -213,8 +199,6 @@ DSP_STATUS DMM_DeleteTables(struct DMM_OBJECT *hDmmMgr)
 	struct DMM_OBJECT *pDmmObj = (struct DMM_OBJECT *)hDmmMgr;
 	DSP_STATUS status = DSP_SOK;
 
-	GT_1trace(DMM_debugMask, GT_ENTER,
-		"Entered DMM_DeleteTables () hDmmMgr %x\n", hDmmMgr);
 	DBC_Require(cRefs > 0);
 	if (MEM_IsValidHandle(hDmmMgr, DMMSIGNATURE)) {
 		/* Delete all DMM tables */
@@ -225,8 +209,6 @@ DSP_STATUS DMM_DeleteTables(struct DMM_OBJECT *hDmmMgr)
 		SYNC_LeaveCS(pDmmObj->hDmmLock);
 	} else
 		status = DSP_EHANDLE;
-	GT_1trace(DMM_debugMask, GT_4CLASS,
-		"Leaving DMM_DeleteTables status %x\n", status);
 	return status;
 }
 
@@ -244,9 +226,6 @@ void DMM_Exit(void)
 	DBC_Require(cRefs > 0);
 
 	cRefs--;
-
-	GT_1trace(DMM_debugMask, GT_ENTER,
-		 "exiting DMM_Exit, ref count:0x%x\n", cRefs);
 }
 
 /*
@@ -261,9 +240,6 @@ DSP_STATUS DMM_GetHandle(DSP_HPROCESSOR hProcessor,
 	DSP_STATUS status = DSP_SOK;
 	struct DEV_OBJECT *hDevObject;
 
-	GT_2trace(DMM_debugMask, GT_ENTER,
-		 "DMM_GetHandle: hProcessor %x, phDmmMgr"
-		 "%x\n", hProcessor, phDmmMgr);
 	DBC_Require(cRefs > 0);
 	DBC_Require(phDmmMgr != NULL);
 	if (hProcessor != NULL)
@@ -274,8 +250,6 @@ DSP_STATUS DMM_GetHandle(DSP_HPROCESSOR hProcessor,
 	if (DSP_SUCCEEDED(status))
 		status = DEV_GetDmmMgr(hDevObject, phDmmMgr);
 
-	GT_2trace(DMM_debugMask, GT_4CLASS, "Leaving DMM_GetHandle status %x, "
-		 "*phDmmMgr %x\n", status, phDmmMgr ? *phDmmMgr : NULL);
 	return status;
 }
 
@@ -299,9 +273,6 @@ bool DMM_Init(void)
 	if (fRetval)
 		cRefs++;
 
-	GT_1trace(DMM_debugMask, GT_ENTER,
-		 "Entered DMM_Init, ref count:0x%x\n", cRefs);
-
 	DBC_Ensure((fRetval && (cRefs > 0)) || (!fRetval && (cRefs >= 0)));
 
 	pVirtualMappingTable = NULL ;
@@ -493,9 +464,6 @@ static struct MapPage *GetRegion(u32 aAddr)
 	struct MapPage *currRegion = NULL;
 	u32   i = 0;
 
-	GT_1trace(DMM_debugMask, GT_ENTER, "Entered GetRegion () "
-		" aAddr %x\n", aAddr);
-
 	if (pVirtualMappingTable != NULL) {
 		/* find page mapped by this address */
 		i = DMM_ADDR_TO_INDEX(aAddr);
@@ -519,8 +487,6 @@ static struct MapPage *GetFreeRegion(u32 aSize)
 	u32   i = 0;
 	u32   RegionSize = 0;
 	u32   nextI = 0;
-	GT_1trace(DMM_debugMask, GT_ENTER, "Entered GetFreeRegion () "
-		"aSize 0x%x\n", aSize);
 
 	if (pVirtualMappingTable == NULL)
 		return currRegion;
@@ -565,8 +531,6 @@ static struct MapPage *GetMappedRegion(u32 aAddr)
 {
 	u32   i = 0;
 	struct MapPage *currRegion = NULL;
-	GT_1trace(DMM_debugMask, GT_ENTER, "Entered GetMappedRegion () "
-						"aAddr 0x%x\n", aAddr);
 
 	if (pVirtualMappingTable == NULL)
 		return currRegion;
diff --git a/drivers/dsp/bridge/pmgr/io.c b/drivers/dsp/bridge/pmgr/io.c
index 5dbb784..3b1156a 100644
--- a/drivers/dsp/bridge/pmgr/io.c
+++ b/drivers/dsp/bridge/pmgr/io.c
@@ -65,10 +65,6 @@ DSP_STATUS IO_Create(OUT struct IO_MGR **phIOMgr, struct DEV_OBJECT *hDevObject,
 	DBC_Require(phIOMgr != NULL);
 	DBC_Require(pMgrAttrs != NULL);
 
-	GT_3trace(IO_DebugMask, GT_ENTER, "Entered IO_Create: phIOMgr: 0x%x\t "
-		 "hDevObject: 0x%x\tpMgrAttrs: 0x%x\n",
-		 phIOMgr, hDevObject, pMgrAttrs);
-
 	*phIOMgr = NULL;
 
 	/* A memory base of 0 implies no memory base:  */
@@ -104,10 +100,6 @@ DSP_STATUS IO_Create(OUT struct IO_MGR **phIOMgr, struct DEV_OBJECT *hDevObject,
 		}
 	}
 
-	GT_2trace(IO_DebugMask, GT_ENTER,
-		 "Exiting IO_Create: hIOMgr: 0x%x, status:"
-		 " 0x%x\n", hIOMgr, status);
-
 	return status;
 }
 
@@ -124,17 +116,11 @@ DSP_STATUS IO_Destroy(struct IO_MGR *hIOMgr)
 
 	DBC_Require(cRefs > 0);
 
-	GT_1trace(IO_DebugMask, GT_ENTER, "Entered IO_Destroy: hIOMgr: 0x%x\n",
-		  hIOMgr);
-
 	pIntfFxns = pIOMgr->pIntfFxns;
 
 	/* Let WMD channel module destroy the IO_MGR: */
 	status = (*pIntfFxns->pfnIODestroy) (hIOMgr);
 
-	GT_2trace(IO_DebugMask, GT_ENTER,
-		 "Exiting IO_Destroy: pIOMgr: 0x%x, status:"
-		 " 0x%x\n", pIOMgr, status);
 	return status;
 }
 
@@ -149,9 +135,6 @@ void IO_Exit(void)
 
 	cRefs--;
 
-	GT_1trace(IO_DebugMask, GT_5CLASS,
-		 "Entered IO_Exit, ref count: 0x%x\n", cRefs);
-
 	DBC_Ensure(cRefs >= 0);
 }
 
@@ -174,10 +157,6 @@ bool IO_Init(void)
 	if (fRetval)
 		cRefs++;
 
-
-	GT_1trace(IO_DebugMask, GT_5CLASS,
-		 "Entered IO_Init, ref count: 0x%x\n", cRefs);
-
 	DBC_Ensure((fRetval && (cRefs > 0)) || (!fRetval && (cRefs >= 0)));
 
 	return fRetval;
diff --git a/drivers/dsp/bridge/pmgr/msg.c b/drivers/dsp/bridge/pmgr/msg.c
index 5cfeb5b..1ba1c88 100644
--- a/drivers/dsp/bridge/pmgr/msg.c
+++ b/drivers/dsp/bridge/pmgr/msg.c
@@ -66,10 +66,6 @@ DSP_STATUS MSG_Create(OUT struct MSG_MGR **phMsgMgr,
 	DBC_Require(msgCallback != NULL);
 	DBC_Require(hDevObject != NULL);
 
-	GT_3trace(MSG_debugMask, GT_ENTER, "MSG_Create: phMsgMgr: 0x%x\t"
-		 "hDevObject: 0x%x\tmsgCallback: 0x%x\n",
-		 phMsgMgr, hDevObject, msgCallback);
-
 	*phMsgMgr = NULL;
 
 	DEV_GetIntfFxns(hDevObject, &pIntfFxns);
@@ -106,9 +102,6 @@ void MSG_Delete(struct MSG_MGR *hMsgMgr)
 	DBC_Require(cRefs > 0);
 	DBC_Require(MEM_IsValidHandle(pMsgMgr, MSGMGR_SIGNATURE));
 
-	GT_1trace(MSG_debugMask, GT_ENTER, "MSG_Delete: hMsgMgr: 0x%x\n",
-		 hMsgMgr);
-
 	pIntfFxns = pMsgMgr->pIntfFxns;
 
 	/* Let WMD message module destroy the MSG_MGR: */
@@ -126,8 +119,7 @@ void MSG_Exit(void)
 {
 	DBC_Require(cRefs > 0);
 	cRefs--;
-	GT_1trace(MSG_debugMask, GT_5CLASS,
-		 "Entered MSG_Exit, ref count: 0x%x\n",	cRefs);
+
 	DBC_Ensure(cRefs >= 0);
 }
 
@@ -145,9 +137,6 @@ bool MSG_Init(void)
 
 	cRefs++;
 
-	GT_1trace(MSG_debugMask, GT_5CLASS, "MSG_Init(), ref count:  0x%x\n",
-		 cRefs);
-
 	DBC_Ensure(cRefs >= 0);
 
 	return true;
diff --git a/drivers/dsp/bridge/pmgr/wcd.c b/drivers/dsp/bridge/pmgr/wcd.c
index beea23b..9f2bdf5 100644
--- a/drivers/dsp/bridge/pmgr/wcd.c
+++ b/drivers/dsp/bridge/pmgr/wcd.c
@@ -279,8 +279,7 @@ void WCD_Exit(void)
 {
 	DBC_Require(WCD_cRefs > 0);
 	WCD_cRefs--;
-	GT_1trace(WCD_debugMask, GT_5CLASS,
-		 "Entered WCD_Exit, ref count:  0x%x\n", WCD_cRefs);
+
 	if (WCD_cRefs == 0) {
 		/* Release all WCD modules initialized in WCD_Init(). */
 		COD_Exit();
@@ -372,8 +371,6 @@ bool WCD_Init(void)
 	if (fInit)
 		WCD_cRefs++;
 
-	GT_1trace(WCD_debugMask, GT_5CLASS,
-		 "Entered WCD_Init, ref count: 0x%x\n",	WCD_cRefs);
 	return fInit;
 }
 
@@ -400,7 +397,7 @@ DSP_STATUS WCD_InitComplete2(void)
 	u32 devType;
 
 	DBC_Require(WCD_cRefs > 0);
-	GT_0trace(WCD_debugMask, GT_ENTER, "Entered WCD_InitComplete\n");
+
 	 /*  Walk the list of DevObjects, get each devnode, and attempting to
 	 *  autostart the board. Note that this requires COF loading, which
 	 *  requires KFILE.  */
@@ -424,8 +421,7 @@ DSP_STATUS WCD_InitComplete2(void)
 				 "Ignoring PROC_AutoStart "
 				 "for Device Type = 0x%x \n", devType);
 	}			/* End For Loop */
-	GT_1trace(WCD_debugMask, GT_ENTER,
-		 "Exiting WCD_InitComplete status 0x%x\n", status);
+
 	return status;
 }
 
@@ -441,14 +437,6 @@ u32 MGRWRAP_EnumNode_Info(union Trapped_Args *args, void *pr_ctxt)
 	DSP_STATUS status = DSP_SOK;
 	u32 size = args->ARGS_MGR_ENUMNODE_INFO.uNDBPropsSize;
 
-	GT_4trace(WCD_debugMask, GT_ENTER,
-		 "MGR_EnumNodeInfo: entered args:\n0x%x"
-		 " uNode: 0x%x\tpNDBProps: 0x%x\tuNDBPropsSize: "
-		 "0x%x\tpuNumNodes\n", args->ARGS_MGR_ENUMNODE_INFO.uNode,
-		 args->ARGS_MGR_ENUMNODE_INFO.pNDBProps,
-		 args->ARGS_MGR_ENUMNODE_INFO.uNDBPropsSize,
-		 args->ARGS_MGR_ENUMNODE_INFO.puNumNodes);
-
 	if (size < sizeof(struct DSP_NDBPROPS))
 		return DSP_ESIZE;
 
@@ -480,15 +468,6 @@ u32 MGRWRAP_EnumProc_Info(union Trapped_Args *args, void *pr_ctxt)
 	DSP_STATUS status = DSP_SOK;
 	u32 size = args->ARGS_MGR_ENUMPROC_INFO.uProcessorInfoSize;
 
-	GT_4trace(WCD_debugMask, GT_ENTER,
-		 "MGRWRAP_EnumProc_Info: entered args:\n"
-		 "0x%x uProcessor: 0x%x\tpProcessorInfo: 0x%x\t"
-		 "uProcessorInfoSize: 0x%x\tpuNumProcs \n",
-		 args->ARGS_MGR_ENUMPROC_INFO.uProcessor,
-		 args->ARGS_MGR_ENUMPROC_INFO.pProcessorInfo,
-		 args->ARGS_MGR_ENUMPROC_INFO.uProcessorInfoSize,
-		 args->ARGS_MGR_ENUMPROC_INFO.puNumProcs);
-
 	if (size < sizeof(struct DSP_PROCESSORINFO))
 		return DSP_ESIZE;
 
@@ -523,11 +502,6 @@ u32 MGRWRAP_RegisterObject(union Trapped_Args *args, void *pr_ctxt)
 	char *pszPathName = NULL;
 	DSP_STATUS status = DSP_SOK;
 
-
-	GT_1trace(WCD_debugMask, GT_ENTER,
-		 "MGRWRAP_RegisterObject: entered "
-		 "0x%x\n", args->ARGS_MGR_REGISTEROBJECT.pUuid);
-
 	cp_fm_usr(&pUuid, args->ARGS_MGR_REGISTEROBJECT.pUuid, status, 1);
 	if (DSP_FAILED(status))
 		goto func_end;
@@ -568,9 +542,6 @@ u32 MGRWRAP_UnregisterObject(union Trapped_Args *args, void *pr_ctxt)
 	if (DSP_FAILED(status))
 		goto func_end;
 
-	GT_1trace(WCD_debugMask, GT_ENTER,
-		 "MGRWRAP_UnregisterObject: entered pg2hMsg"
-		 " 0x%x\n", args->ARGS_MGR_UNREGISTEROBJECT.pUuid);
 	status = DCD_UnregisterObject(&pUuid,
 			args->ARGS_MGR_UNREGISTEROBJECT.objType);
 func_end:
@@ -589,9 +560,6 @@ u32 MGRWRAP_WaitForBridgeEvents(union Trapped_Args *args, void *pr_ctxt)
 	u32 uIndex, i;
 	u32 uCount = args->ARGS_MGR_WAIT.uCount;
 
-	GT_0trace(WCD_debugMask, GT_ENTER,
-		 "MGRWRAP_WaitForBridgeEvents: entered\n");
-
 	if (uCount > MAX_EVENTS)
 		status = DSP_EINVALIDARG;
 
@@ -635,12 +603,6 @@ u32 PROCWRAP_Attach(union Trapped_Args *args, void *pr_ctxt)
 	DSP_STATUS status = DSP_SOK;
 	struct DSP_PROCESSORATTRIN attrIn, *pAttrIn = NULL;
 
-	GT_3trace(WCD_debugMask, GT_ENTER,
-		 "PROCWRAP_Attach: entered args:\n" "0x%x"
-		 " uProcessor: 0x%x\tpAttrIn: 0x%x\tphProcessor \n",
-		 args->ARGS_PROC_ATTACH.uProcessor,
-		 args->ARGS_PROC_ATTACH.pAttrIn,
-		 args->ARGS_PROC_ATTACH.phProcessor);
 	/* Optional argument */
 	if (args->ARGS_PROC_ATTACH.pAttrIn) {
 		cp_fm_usr(&attrIn, args->ARGS_PROC_ATTACH.pAttrIn, status, 1);
@@ -668,12 +630,6 @@ u32 PROCWRAP_Ctrl(union Trapped_Args *args, void *pr_ctxt)
 	u8 *pArgs = NULL;
 	DSP_STATUS status = DSP_SOK;
 
-	GT_3trace(WCD_debugMask, GT_ENTER,
-		 "PROCWRAP_Ctrl: entered args:\n 0x%x"
-		 " uProcessor: 0x%x\tdwCmd: 0x%x\tpArgs \n",
-		 args->ARGS_PROC_CTRL.hProcessor,
-		 args->ARGS_PROC_CTRL.dwCmd,
-		 args->ARGS_PROC_CTRL.pArgs);
 	if (pSize) {
 		if (get_user(cbDataSize, pSize)) {
 			status = DSP_EFAIL;
@@ -721,16 +677,6 @@ u32 PROCWRAP_EnumNode_Info(union Trapped_Args *args, void *pr_ctxt)
 	u32 uNumNodes;
 	u32 uAllocated;
 
-	GT_5trace(WCD_debugMask, GT_ENTER,
-		 "PROCWRAP_EnumNode_Info:entered args:\n0x"
-		 "%xhProcessor:0x%x\taNodeTab:0x%x\tuNodeTabSize:"
-		 "%0x%x\tpuNumNodes%\n0x%x puAllocated: \n",
-		 args->ARGS_PROC_ENUMNODE_INFO.hProcessor,
-		 args->ARGS_PROC_ENUMNODE_INFO.aNodeTab,
-		 args->ARGS_PROC_ENUMNODE_INFO.uNodeTabSize,
-		 args->ARGS_PROC_ENUMNODE_INFO.puNumNodes,
-		 args->ARGS_PROC_ENUMNODE_INFO.puAllocated);
-
 	if (!args->ARGS_PROC_ENUMNODE_INFO.uNodeTabSize)
 		return DSP_ESIZE;
 
@@ -754,8 +700,6 @@ u32 PROCWRAP_FlushMemory(union Trapped_Args *args, void *pr_ctxt)
 {
 	DSP_STATUS status;
 
-	GT_0trace(WCD_debugMask, GT_ENTER, "PROCWRAP_FlushMemory: entered\n");
-
 	if (args->ARGS_PROC_FLUSHMEMORY.ulFlags >
 					 PROC_WRITEBACK_INVALIDATE_MEM)
 		return DSP_EINVALIDARG;
@@ -775,9 +719,6 @@ u32 PROCWRAP_InvalidateMemory(union Trapped_Args *args, void *pr_ctxt)
 {
 	DSP_STATUS status;
 
-	GT_0trace(WCD_debugMask, GT_ENTER,
-		 "PROCWRAP_InvalidateMemory:entered\n");
-
 	status = PROC_InvalidateMemory(
 				  args->ARGS_PROC_INVALIDATEMEMORY.hProcessor,
 				  args->ARGS_PROC_INVALIDATEMEMORY.pMpuAddr,
@@ -794,15 +735,6 @@ u32 PROCWRAP_EnumResources(union Trapped_Args *args, void *pr_ctxt)
 	DSP_STATUS status = DSP_SOK;
 	struct DSP_RESOURCEINFO pResourceInfo;
 
-	GT_4trace(WCD_debugMask, GT_ENTER,
-		 "PROCWRAP_EnumResources: entered args:\n"
-		 "0x%x hProcessor: 0x%x\tuResourceMask: 0x%x\tpResourceInfo"
-		 " 0x%x\tuResourceInfoSixe \n",
-		 args->ARGS_PROC_ENUMRESOURCES.hProcessor,
-		 args->ARGS_PROC_ENUMRESOURCES.uResourceType,
-		 args->ARGS_PROC_ENUMRESOURCES.pResourceInfo,
-		 args->ARGS_PROC_ENUMRESOURCES.uResourceInfoSize);
-
 	if (args->ARGS_PROC_ENUMRESOURCES.uResourceInfoSize <
 		sizeof(struct DSP_RESOURCEINFO))
 		return DSP_ESIZE;
@@ -826,7 +758,6 @@ u32 PROCWRAP_GetState(union Trapped_Args *args, void *pr_ctxt)
 {
 	DSP_STATUS status;
 	struct DSP_PROCESSORSTATE procStatus;
-	GT_0trace(WCD_debugMask, GT_ENTER, "PROCWRAP_GetState: entered\n");
 
 	if (args->ARGS_PROC_GETSTATE.uStateInfoSize <
 		sizeof(struct DSP_PROCESSORSTATE))
@@ -847,8 +778,6 @@ u32 PROCWRAP_GetTrace(union Trapped_Args *args, void *pr_ctxt)
 	DSP_STATUS status;
 	u8 *pBuf;
 
-	GT_0trace(WCD_debugMask, GT_ENTER, "PROCWRAP_GetTrace: entered\n");
-
 	if (args->ARGS_PROC_GETTRACE.uMaxSize > MAX_TRACEBUFLEN)
 		return DSP_ESIZE;
 
@@ -956,12 +885,7 @@ u32 PROCWRAP_Load(union Trapped_Args *args, void *pr_ctxt)
 			}
 		}
 	}
-	GT_5trace(WCD_debugMask, GT_ENTER,
-		"PROCWRAP_Load, hProcessor: 0x%x\n\tiArgc:"
-		"0x%x\n\taArgv: 0x%x\n\taArgv[0]: %s\n\taEnvp: 0x%0x\n",
-		args->ARGS_PROC_LOAD.hProcessor,
-		args->ARGS_PROC_LOAD.iArgc, args->ARGS_PROC_LOAD.aArgv,
-		argv[0], args->ARGS_PROC_LOAD.aEnvp);
+
 	if (DSP_SUCCEEDED(status)) {
 		status = PROC_Load(args->ARGS_PROC_LOAD.hProcessor,
 				args->ARGS_PROC_LOAD.iArgc,
@@ -995,8 +919,6 @@ u32 PROCWRAP_Map(union Trapped_Args *args, void *pr_ctxt)
 	DSP_STATUS status;
 	void *pMapAddr;
 
-	GT_0trace(WCD_debugMask, GT_ENTER, "PROCWRAP_Map: entered\n");
-
 	if (!args->ARGS_PROC_MAPMEM.ulSize)
 		return DSP_ESIZE;
 
@@ -1024,9 +946,6 @@ u32 PROCWRAP_RegisterNotify(union Trapped_Args *args, void *pr_ctxt)
 	DSP_STATUS status;
 	struct DSP_NOTIFICATION notification;
 
-	GT_0trace(WCD_debugMask, GT_ENTER,
-		 "PROCWRAP_RegisterNotify: entered\n");
-
 	/* Initialize the notification data structure  */
 	notification.psName = NULL;
 	notification.handle = NULL;
@@ -1052,7 +971,6 @@ u32 PROCWRAP_ReserveMemory(union Trapped_Args *args, void *pr_ctxt)
 		(args->ARGS_PROC_RSVMEM.ulSize & (PG_SIZE_4K - 1)) != 0)
 		return DSP_ESIZE;
 
-	GT_0trace(WCD_debugMask, GT_ENTER, "PROCWRAP_ReserveMemory: entered\n");
 	status = PROC_ReserveMemory(args->ARGS_PROC_RSVMEM.hProcessor,
 				   args->ARGS_PROC_RSVMEM.ulSize, &pRsvAddr);
 	if (DSP_SUCCEEDED(status)) {
@@ -1072,7 +990,6 @@ u32 PROCWRAP_Start(union Trapped_Args *args, void *pr_ctxt)
 {
 	u32 retVal;
 
-	GT_0trace(WCD_debugMask, GT_ENTER, "PROCWRAP_Start: entered\n");
 	retVal = PROC_Start(args->ARGS_PROC_START.hProcessor);
 	return retVal;
 }
@@ -1084,7 +1001,6 @@ u32 PROCWRAP_UnMap(union Trapped_Args *args, void *pr_ctxt)
 {
 	DSP_STATUS status;
 
-	GT_0trace(WCD_debugMask, GT_ENTER, "PROCWRAP_UnMap: entered\n");
 	status = PROC_UnMap(args->ARGS_PROC_UNMAPMEM.hProcessor,
 			   args->ARGS_PROC_UNMAPMEM.pMapAddr, pr_ctxt);
 	return status;
@@ -1097,8 +1013,6 @@ u32 PROCWRAP_UnReserveMemory(union Trapped_Args *args, void *pr_ctxt)
 {
 	DSP_STATUS status;
 
-	GT_0trace(WCD_debugMask, GT_ENTER,
-		 "PROCWRAP_UnReserveMemory: entered\n");
 	status = PROC_UnReserveMemory(args->ARGS_PROC_UNRSVMEM.hProcessor,
 				     args->ARGS_PROC_UNRSVMEM.pRsvAddr);
 	return status;
@@ -1111,7 +1025,6 @@ u32 PROCWRAP_Stop(union Trapped_Args *args, void *pr_ctxt)
 {
 	u32 retVal;
 
-	GT_0trace(WCD_debugMask, GT_ENTER, "PROCWRAP_Stop: entered\n");
 	retVal = PROC_Stop(args->ARGS_PROC_STOP.hProcessor);
 
 	return retVal;
@@ -1130,8 +1043,6 @@ u32 NODEWRAP_Allocate(union Trapped_Args *args, void *pr_ctxt)
 	struct DSP_NODEATTRIN attrIn, *pAttrIn = NULL;
 	struct NODE_OBJECT *hNode;
 
-	GT_0trace(WCD_debugMask, GT_ENTER, "NODEWRAP_Allocate: entered\n");
-
 	/* Optional argument */
 	if (pSize) {
 		if (get_user(cbDataSize, pSize))
@@ -1214,8 +1125,6 @@ u32 NODEWRAP_ChangePriority(union Trapped_Args *args, void *pr_ctxt)
 {
 	u32 retVal;
 
-	GT_0trace(WCD_debugMask, GT_ENTER,
-		 "NODEWRAP_ChangePriority: entered\n");
 	retVal = NODE_ChangePriority(args->ARGS_NODE_CHANGEPRIORITY.hNode,
 			args->ARGS_NODE_CHANGEPRIORITY.iPriority);
 
@@ -1234,8 +1143,6 @@ u32 NODEWRAP_Connect(union Trapped_Args *args, void *pr_ctxt)
 	u32 __user *pSize = (u32 __user *)args->ARGS_NODE_CONNECT.pConnParam;
 	u8 *pArgs = NULL;
 
-	GT_0trace(WCD_debugMask, GT_ENTER, "NODEWRAP_Connect: entered\n");
-
 	/* Optional argument */
 	if (pSize) {
 		if (get_user(cbDataSize, pSize))
@@ -1281,7 +1188,6 @@ u32 NODEWRAP_Create(union Trapped_Args *args, void *pr_ctxt)
 {
 	u32 retVal;
 
-	GT_0trace(WCD_debugMask, GT_ENTER, "NODEWRAP_Create: entered\n");
 	retVal = NODE_Create(args->ARGS_NODE_CREATE.hNode);
 
 	return retVal;
@@ -1294,7 +1200,6 @@ u32 NODEWRAP_Delete(union Trapped_Args *args, void *pr_ctxt)
 {
 	u32 retVal;
 
-	GT_0trace(WCD_debugMask, GT_ENTER, "NODEWRAP_Delete: entered\n");
 	retVal = NODE_Delete(args->ARGS_NODE_DELETE.hNode, pr_ctxt);
 
 	return retVal;
@@ -1335,8 +1240,6 @@ u32 NODEWRAP_GetAttr(union Trapped_Args *args, void *pr_ctxt)
 	DSP_STATUS status = DSP_SOK;
 	struct DSP_NODEATTR attr;
 
-	GT_0trace(WCD_debugMask, GT_ENTER, "NODEWRAP_GetAttr: entered\n");
-
 	status = NODE_GetAttr(args->ARGS_NODE_GETATTR.hNode, &attr,
 			     args->ARGS_NODE_GETATTR.uAttrSize);
 	cp_to_usr(args->ARGS_NODE_GETATTR.pAttr, &attr, status, 1);
@@ -1352,8 +1255,6 @@ u32 NODEWRAP_GetMessage(union Trapped_Args *args, void *pr_ctxt)
 	DSP_STATUS status;
 	struct DSP_MSG msg;
 
-	GT_0trace(WCD_debugMask, GT_ENTER, "NODEWRAP_GetMessage: entered\n");
-
 	status = NODE_GetMessage(args->ARGS_NODE_GETMESSAGE.hNode, &msg,
 				args->ARGS_NODE_GETMESSAGE.uTimeout);
 
@@ -1369,7 +1270,6 @@ u32 NODEWRAP_Pause(union Trapped_Args *args, void *pr_ctxt)
 {
 	u32 retVal;
 
-	GT_0trace(WCD_debugMask, GT_ENTER, "NODEWRAP_Pause: entered\n");
 	retVal = NODE_Pause(args->ARGS_NODE_PAUSE.hNode);
 
 	return retVal;
@@ -1383,8 +1283,6 @@ u32 NODEWRAP_PutMessage(union Trapped_Args *args, void *pr_ctxt)
 	DSP_STATUS status = DSP_SOK;
 	struct DSP_MSG msg;
 
-	GT_0trace(WCD_debugMask, GT_ENTER, "NODEWRAP_PutMessage: entered\n");
-
 	cp_fm_usr(&msg, args->ARGS_NODE_PUTMESSAGE.pMessage, status, 1);
 
 	if (DSP_SUCCEEDED(status)) {
@@ -1403,9 +1301,6 @@ u32 NODEWRAP_RegisterNotify(union Trapped_Args *args, void *pr_ctxt)
 	DSP_STATUS status = DSP_SOK;
 	struct DSP_NOTIFICATION notification;
 
-	GT_0trace(WCD_debugMask, GT_ENTER,
-		 "NODEWRAP_RegisterNotify: entered\n");
-
 	/* Initialize the notification data structure  */
 	notification.psName = NULL;
 	notification.handle = NULL;
@@ -1431,7 +1326,6 @@ u32 NODEWRAP_Run(union Trapped_Args *args, void *pr_ctxt)
 {
 	u32 retVal;
 
-	GT_0trace(WCD_debugMask, GT_ENTER, "NODEWRAP_Run: entered\n");
 	retVal = NODE_Run(args->ARGS_NODE_RUN.hNode);
 
 	return retVal;
@@ -1445,8 +1339,6 @@ u32 NODEWRAP_Terminate(union Trapped_Args *args, void *pr_ctxt)
 	DSP_STATUS status;
 	DSP_STATUS tempstatus;
 
-	GT_0trace(WCD_debugMask, GT_ENTER, "NODEWRAP_Terminate: entered\n");
-
 	status = NODE_Terminate(args->ARGS_NODE_TERMINATE.hNode, &tempstatus);
 
 	cp_to_usr(args->ARGS_NODE_TERMINATE.pStatus, &tempstatus, status, 1);
@@ -1464,9 +1356,6 @@ u32 NODEWRAP_GetUUIDProps(union Trapped_Args *args, void *pr_ctxt)
 	struct DSP_UUID nodeId;
 	struct DSP_NDBPROPS    *pnodeProps = NULL;
 
-	GT_0trace(WCD_debugMask, GT_ENTER,
-		 "NODEWRAP_GetUUIDPropste: entered\n");
-
 	cp_fm_usr(&nodeId, args->ARGS_NODE_GETUUIDPROPS.pNodeID, status, 1);
 	if (DSP_FAILED(status))
 		goto func_cont;
@@ -1684,9 +1573,6 @@ u32 STRMWRAP_RegisterNotify(union Trapped_Args *args, void *pr_ctxt)
 	DSP_STATUS status = DSP_SOK;
 	struct DSP_NOTIFICATION notification;
 
-	GT_0trace(WCD_debugMask, GT_ENTER,
-		 "NODEWRAP_RegisterNotify: entered\n");
-
 	/* Initialize the notification data structure  */
 	notification.psName = NULL;
 	notification.handle = NULL;
-- 
1.6.2.4


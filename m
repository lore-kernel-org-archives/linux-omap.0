From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 11/18] DSPBRIDGE: Remove excessive debug statements for pmgr
Date: Tue, 16 Feb 2010 02:42:21 -0600
Message-ID: <1266309748-11714-12-git-send-email-omar.ramirez@ti.com>
References: <1266309748-11714-1-git-send-email-omar.ramirez@ti.com>
 <1266309748-11714-2-git-send-email-omar.ramirez@ti.com>
 <1266309748-11714-3-git-send-email-omar.ramirez@ti.com>
 <1266309748-11714-4-git-send-email-omar.ramirez@ti.com>
 <1266309748-11714-5-git-send-email-omar.ramirez@ti.com>
 <1266309748-11714-6-git-send-email-omar.ramirez@ti.com>
 <1266309748-11714-7-git-send-email-omar.ramirez@ti.com>
 <1266309748-11714-8-git-send-email-omar.ramirez@ti.com>
 <1266309748-11714-9-git-send-email-omar.ramirez@ti.com>
 <1266309748-11714-10-git-send-email-omar.ramirez@ti.com>
 <1266309748-11714-11-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:54447 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755483Ab0BPIaK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 16 Feb 2010 03:30:10 -0500
In-Reply-To: <1266309748-11714-11-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Ameya Palande <ameya.palande@nokia.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, Nishanth Menon <nm@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>

Removed debug statements that print redundant errors where
returned statuses should be enough in case of failure.

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 drivers/dsp/bridge/pmgr/chnl.c |   20 +++------
 drivers/dsp/bridge/pmgr/cmm.c  |   58 ++------------------------
 drivers/dsp/bridge/pmgr/cod.c  |   57 +++++---------------------
 drivers/dsp/bridge/pmgr/dbll.c |   26 +----------
 drivers/dsp/bridge/pmgr/dev.c  |   88 +++------------------------------------
 drivers/dsp/bridge/pmgr/dmm.c  |    8 +---
 drivers/dsp/bridge/pmgr/io.c   |   10 +----
 drivers/dsp/bridge/pmgr/wcd.c  |   17 +------
 8 files changed, 37 insertions(+), 247 deletions(-)

diff --git a/drivers/dsp/bridge/pmgr/chnl.c b/drivers/dsp/bridge/pmgr/chnl.c
index 802f71c..14a060c 100644
--- a/drivers/dsp/bridge/pmgr/chnl.c
+++ b/drivers/dsp/bridge/pmgr/chnl.c
@@ -75,22 +75,16 @@ DSP_STATUS CHNL_Create(OUT struct CHNL_MGR **phChnlMgr,
 
 	/* Validate args: */
 	if ((0 < pMgrAttrs->cChannels) &&
-	   (pMgrAttrs->cChannels <= CHNL_MAXCHANNELS)) {
+	   (pMgrAttrs->cChannels <= CHNL_MAXCHANNELS))
 		status = DSP_SOK;
-	} else if (pMgrAttrs->cChannels == 0) {
+	else if (pMgrAttrs->cChannels == 0)
 		status = DSP_EINVALIDARG;
-		GT_0trace(CHNL_DebugMask, GT_7CLASS,
-			  "CHNL_Create:Invalid Args\n");
-	} else {
+	else
 		status = CHNL_E_MAXCHANNELS;
-		GT_0trace(CHNL_DebugMask, GT_7CLASS,
-			  "CHNL_Create:Error Max Channels\n");
-	}
-	if (pMgrAttrs->uWordSize == 0) {
+
+	if (pMgrAttrs->uWordSize == 0)
 		status = CHNL_E_INVALIDWORDSIZE;
-		GT_0trace(CHNL_DebugMask, GT_7CLASS,
-			  "CHNL_Create:Invalid Word size\n");
-	}
+
 	if (DSP_SUCCEEDED(status)) {
 		status = DEV_GetChnlMgr(hDevObject, &hChnlMgr);
 		if (DSP_SUCCEEDED(status) && hChnlMgr != NULL)
@@ -137,8 +131,6 @@ DSP_STATUS CHNL_Destroy(struct CHNL_MGR *hChnlMgr)
 		/* Let WMD channel module destroy the CHNL_MGR: */
 		status = (*pIntfFxns->pfnChnlDestroy)(hChnlMgr);
 	} else {
-		GT_0trace(CHNL_DebugMask, GT_7CLASS,
-			  "CHNL_Destroy:Invalid Handle\n");
 		status = DSP_EHANDLE;
 	}
 
diff --git a/drivers/dsp/bridge/pmgr/cmm.c b/drivers/dsp/bridge/pmgr/cmm.c
index e422dc5..56f97a7 100644
--- a/drivers/dsp/bridge/pmgr/cmm.c
+++ b/drivers/dsp/bridge/pmgr/cmm.c
@@ -276,9 +276,6 @@ DSP_STATUS CMM_Create(OUT struct CMM_OBJECT **phCmmMgr,
 		if (DSP_SUCCEEDED(status)) {
 			pCmmObject->dwPageSize = sysInfo.dwPageSize;
 		} else {
-			GT_0trace(CMM_debugMask, GT_7CLASS,
-				  "CMM_Create: failed to get system"
-				  "page size\n");
 			pCmmObject->dwPageSize = 0;
 			status = DSP_EFAIL;
 		}
@@ -288,14 +285,11 @@ DSP_STATUS CMM_Create(OUT struct CMM_OBJECT **phCmmMgr,
 			/* create node free list */
 			pCmmObject->pNodeFreeListHead = MEM_Calloc(sizeof(struct
 				LST_LIST), MEM_NONPAGED);
-			if (pCmmObject->pNodeFreeListHead == NULL) {
-				GT_0trace(CMM_debugMask, GT_7CLASS,
-					  "CMM_Create: Out of memory\n");
+			if (pCmmObject->pNodeFreeListHead == NULL)
 				status = DSP_EMEMORY;
-			} else {
+			else
 				INIT_LIST_HEAD(&pCmmObject->pNodeFreeListHead->
 					head);
-			}
 		}
 		if (DSP_SUCCEEDED(status))
 			status = SYNC_InitializeCS(&pCmmObject->hCmmLock);
@@ -306,9 +300,6 @@ DSP_STATUS CMM_Create(OUT struct CMM_OBJECT **phCmmMgr,
 			CMM_Destroy(pCmmObject, true);
 
 	} else {
-		GT_0trace(CMM_debugMask, GT_6CLASS,
-			  "CMM_Create: Object Allocation "
-			  "Failure(CMM Object)\n");
 		status = DSP_EMEMORY;
 	}
 	return status;
@@ -591,9 +582,6 @@ DSP_STATUS CMM_RegisterGPPSMSeg(struct CMM_OBJECT *hCmmMgr, u32 dwGPPBasePA,
 	/* Check if input ulSize is big enough to alloc at least one block */
 	if (DSP_SUCCEEDED(status)) {
 		if (ulSize < pCmmMgr->ulMinBlockSize) {
-			GT_0trace(CMM_debugMask, GT_7CLASS,
-				  "CMM_RegisterGPPSMSeg: "
-				  "ulSize too small\n");
 			status = DSP_EINVALIDARG;
 			goto func_end;
 		}
@@ -612,9 +600,6 @@ DSP_STATUS CMM_RegisterGPPSMSeg(struct CMM_OBJECT *hCmmMgr, u32 dwGPPBasePA,
 		pSMA->dwDSPBase = dwDSPBase;
 		pSMA->ulDSPSize = ulDSPSize;
 		if (pSMA->dwVmBase == 0) {
-			GT_0trace(CMM_debugMask, GT_7CLASS,
-				  "CMM_RegisterGPPSMSeg: Error"
-				  "MEM_LinearAddress()\n");
 			status = DSP_EFAIL;
 			goto func_end;
 		}
@@ -625,9 +610,6 @@ DSP_STATUS CMM_RegisterGPPSMSeg(struct CMM_OBJECT *hCmmMgr, u32 dwGPPBasePA,
 			pSMA->pFreeListHead = MEM_Calloc(sizeof(struct
 				LST_LIST), MEM_NONPAGED);
 			if (pSMA->pFreeListHead == NULL) {
-				GT_0trace(CMM_debugMask, GT_7CLASS,
-					  "CMM_RegisterGPPSMSeg: "
-					  "Out Of Memory 1\n");
 				status = DSP_EMEMORY;
 				goto func_end;
 			}
@@ -638,9 +620,6 @@ DSP_STATUS CMM_RegisterGPPSMSeg(struct CMM_OBJECT *hCmmMgr, u32 dwGPPBasePA,
 			pSMA->pInUseListHead = MEM_Calloc(sizeof(struct
 				LST_LIST), MEM_NONPAGED);
 			if (pSMA->pInUseListHead == NULL) {
-				GT_0trace(CMM_debugMask, GT_7CLASS,
-					  "CMM_RegisterGPPSMSeg: "
-					  "Out of memory 2\n");
 				status = DSP_EMEMORY;
 				goto func_end;
 			}
@@ -664,9 +643,6 @@ DSP_STATUS CMM_RegisterGPPSMSeg(struct CMM_OBJECT *hCmmMgr, u32 dwGPPBasePA,
 			UnRegisterGPPSMSeg(pSMA);
 		}
 	} else {
-		GT_0trace(CMM_debugMask, GT_6CLASS,
-			  "CMM_RegisterGPPSMSeg: SMA Object "
-			  "Allocation Failure\n");
 		status = DSP_EMEMORY;
 		goto func_end;
 	}
@@ -717,9 +693,6 @@ DSP_STATUS CMM_UnRegisterGPPSMSeg(struct CMM_OBJECT *hCmmMgr, u32 ulSegId)
 			}	/* end while */
 		} else {
 			status = DSP_EINVALIDARG;
-			GT_0trace(CMM_debugMask, GT_7CLASS,
-				  "CMM_UnRegisterGPPSMSeg: Bad "
-				  "segment Id\n");
 		}
 	} else {
 		status = DSP_EHANDLE;
@@ -791,12 +764,9 @@ static s32 GetSlot(struct CMM_OBJECT *pCmmMgr)
 			break;
 
 	}
-	if (nSlot == CMM_MAXGPPSEGS) {
-		GT_0trace(CMM_debugMask, GT_7CLASS,
-			  "CMM_RegisterGPPSMSeg: Allocator "
-			  "entry failure, max exceeded\n");
+	if (nSlot == CMM_MAXGPPSEGS)
 		nSlot = -1;	/* failed */
-	}
+
 	return nSlot;
 }
 
@@ -823,9 +793,7 @@ static struct CMM_MNODE *GetNode(struct CMM_OBJECT *pCmmMgr, u32 dwPA,
 		pNode = (struct CMM_MNODE *)LST_GetHead(pCmmMgr->
 			pNodeFreeListHead);
 	}
-	if (pNode == NULL) {
-		GT_0trace(CMM_debugMask, GT_7CLASS, "GetNode: Out Of Memory\n");
-	} else {
+	if (pNode) {
 		LST_InitElem((struct list_head *) pNode);	/* set self */
 		pNode->dwPA = dwPA;	/* Physical addr of start of block */
 		pNode->dwVA = dwVA;	/* Virtual   "            "        */
@@ -1007,9 +975,6 @@ DSP_STATUS CMM_XlatorCreate(OUT struct CMM_XLATOROBJECT **phXlator,
 		pXlatorObject->hCmmMgr = hCmmMgr;	/* ref back to CMM */
 		pXlatorObject->ulSegId = pXlatorAttrs->ulSegId;	/* SM segId */
 	} else {
-		GT_0trace(CMM_debugMask, GT_6CLASS,
-			  "CMM_XlatorCreate: Object Allocation"
-			  "Failure(CMM Xlator)\n");
 		status = DSP_EMEMORY;
 	}
 	if (DSP_SUCCEEDED(status))
@@ -1098,10 +1063,6 @@ DSP_STATUS CMM_XlatorFreeBuf(struct CMM_XLATOROBJECT *hXlator, void *pBufVa)
 			if (DSP_FAILED(status)) {
 				/* Uh oh, this shouldn't happen. Descriptor
 				 * gone! */
-				GT_2trace(CMM_debugMask, GT_7CLASS,
-					"Cannot free DMA/ZCPY buffer"
-					"not allocated by MPU. PA %x, VA %x\n",
-					pBufPa, pBufVa);
 				DBC_Assert(false);   /* CMM is leaking mem! */
 			}
 		}
@@ -1176,9 +1137,6 @@ void *CMM_XlatorTranslate(struct CMM_XLATOROBJECT *hXlator, void *pAddr,
 			   (dwAddrXlate >=
 			   (pXlator->dwVirtBase + pXlator->ulVirtSize))) {
 				dwAddrXlate = 0;	/* bad address */
-				GT_0trace(CMM_debugMask, GT_7CLASS,
-					  "CMM_XlatorTranslate: "
-					  "Virt addr out of range\n");
 			}
 		} else {
 			/* Gpp PA =  Gpp Base + offset */
@@ -1204,11 +1162,5 @@ void *CMM_XlatorTranslate(struct CMM_XLATOROBJECT *hXlator, void *pAddr,
 					  pAlctr->cFactor);
 	}
 loop_cont:
-	if (!dwAddrXlate) {
-		GT_2trace(CMM_debugMask, GT_7CLASS,
-			  "CMM_XlatorTranslate: Can't translate"
-			  " address: 0x%x xType %x\n", pAddr, xType);
-	}
-
 	return (void *)dwAddrXlate;
 }
diff --git a/drivers/dsp/bridge/pmgr/cod.c b/drivers/dsp/bridge/pmgr/cod.c
index 25921fb..eb74fb8 100644
--- a/drivers/dsp/bridge/pmgr/cod.c
+++ b/drivers/dsp/bridge/pmgr/cod.c
@@ -240,11 +240,8 @@ DSP_STATUS COD_Create(OUT struct COD_MANAGER **phMgr, char *pstrDummyFile,
 		return DSP_ENOTIMPL;
 
 	hMgrNew = MEM_Calloc(sizeof(struct COD_MANAGER), MEM_NONPAGED);
-	if (hMgrNew == NULL) {
-		GT_0trace(COD_debugMask, GT_7CLASS,
-			  "COD_Create: Out Of Memory\n");
+	if (hMgrNew == NULL)
 		return DSP_EMEMORY;
-	}
 
 	hMgrNew->ulMagic = MAGIC;
 
@@ -277,8 +274,6 @@ DSP_STATUS COD_Create(OUT struct COD_MANAGER **phMgr, char *pstrDummyFile,
 
 	if (DSP_FAILED(status)) {
 		COD_Delete(hMgrNew);
-		GT_1trace(COD_debugMask, GT_7CLASS,
-			  "COD_Create:ZL Create Failed: 0x%x\n", status);
 		return COD_E_ZLCREATEFAILED;
 	}
 
@@ -427,15 +422,8 @@ DSP_STATUS COD_GetSection(struct COD_LIBRARYOBJ *lib, IN char *pstrSect,
 		hManager = lib->hCodMgr;
 		status = hManager->fxns.getSectFxn(lib->dbllLib, pstrSect,
 						   puAddr, puLen);
-		if (DSP_FAILED(status)) {
-			GT_1trace(COD_debugMask, GT_7CLASS,
-				 "COD_GetSection: Section %s not"
-				 "found\n", pstrSect);
-		}
 	} else {
 		status = COD_E_NOSYMBOLSLOADED;
-		GT_0trace(COD_debugMask, GT_7CLASS,
-			  "COD_GetSection:No Symbols loaded\n");
 	}
 
 	DBC_Ensure(DSP_SUCCEEDED(status) || ((*puAddr == 0) && (*puLen == 0)));
@@ -467,16 +455,10 @@ DSP_STATUS COD_GetSymValue(struct COD_MANAGER *hMgr, char *pstrSym,
 	if (hMgr->baseLib) {
 		if (!hMgr->fxns.getAddrFxn(hMgr->baseLib, pstrSym, &pSym)) {
 			if (!hMgr->fxns.getCAddrFxn(hMgr->baseLib, pstrSym,
-			    &pSym)) {
-				GT_0trace(COD_debugMask, GT_7CLASS,
-					  "COD_GetSymValue: "
-					  "Symbols not found\n");
+			    &pSym))
 				return COD_E_SYMBOLNOTFOUND;
-			}
 		}
 	} else {
-		GT_0trace(COD_debugMask, GT_7CLASS, "COD_GetSymValue: "
-			 "No Symbols loaded\n");
 		return COD_E_NOSYMBOLSLOADED;
 	}
 
@@ -565,12 +547,9 @@ DSP_STATUS COD_LoadBase(struct COD_MANAGER *hMgr, u32 nArgc, char *aArgs[],
 	flags = DBLL_CODE | DBLL_DATA | DBLL_SYMB;
 	status = hMgr->fxns.loadFxn(hMgr->baseLib, flags, &newAttrs,
 		 &hMgr->ulEntry);
-	if (DSP_FAILED(status)) {
+	if (DSP_FAILED(status))
 		hMgr->fxns.closeFxn(hMgr->baseLib);
-		GT_1trace(COD_debugMask, GT_7CLASS,
-			  "COD_LoadBase: COD Load failed: "
-			  "0x%x\n", status);
-	}
+
 	if (DSP_SUCCEEDED(status))
 		hMgr->fLoaded = true;
 	else
@@ -602,22 +581,15 @@ DSP_STATUS COD_Open(struct COD_MANAGER *hMgr, IN char *pszCoffPath,
 	*pLib = NULL;
 
 	lib = MEM_Calloc(sizeof(struct COD_LIBRARYOBJ), MEM_NONPAGED);
-	if (lib == NULL) {
-		GT_0trace(COD_debugMask, GT_7CLASS,
-			 "COD_Open: Out Of Memory\n");
+	if (lib == NULL)
 		status = DSP_EMEMORY;
-	}
 
 	if (DSP_SUCCEEDED(status)) {
 		lib->hCodMgr = hMgr;
 		status = hMgr->fxns.openFxn(hMgr->target, pszCoffPath, flags,
 					   &lib->dbllLib);
-		if (DSP_FAILED(status)) {
-			GT_1trace(COD_debugMask, GT_7CLASS,
-				 "COD_Open failed: 0x%x\n", status);
-		} else {
+		if (DSP_SUCCEEDED(status))
 			*pLib = lib;
-		}
 	}
 
 	return status;
@@ -652,10 +624,7 @@ DSP_STATUS COD_OpenBase(struct COD_MANAGER *hMgr, IN char *pszCoffPath,
 		hMgr->baseLib = NULL;
 	}
 	status = hMgr->fxns.openFxn(hMgr->target, pszCoffPath, flags, &lib);
-	if (DSP_FAILED(status)) {
-		GT_0trace(COD_debugMask, GT_7CLASS,
-			 "COD_OpenBase: COD Open failed\n");
-	} else {
+	if (DSP_SUCCEEDED(status)) {
 		/* hang onto the library for subsequent sym table usage */
 		hMgr->baseLib = lib;
 		strncpy(hMgr->szZLFile, pszCoffPath, COD_MAXPATHLENGTH - 1);
@@ -681,19 +650,13 @@ DSP_STATUS COD_ReadSection(struct COD_LIBRARYOBJ *lib, IN char *pstrSect,
 	DBC_Require(pstrSect != NULL);
 	DBC_Require(pstrContent != NULL);
 
-	if (lib != NULL) {
+	if (lib != NULL)
 		status = lib->hCodMgr->fxns.readSectFxn(lib->dbllLib, pstrSect,
 							pstrContent,
 							cContentSize);
-		if (DSP_FAILED(status)) {
-			GT_1trace(COD_debugMask, GT_7CLASS,
-				 "COD_ReadSection failed: 0x%lx\n", status);
-		}
-	} else {
+	else
 		status = COD_E_NOSYMBOLSLOADED;
-		GT_0trace(COD_debugMask, GT_7CLASS,
-			  "COD_ReadSection: No Symbols loaded\n");
-	}
+
 	return status;
 }
 
diff --git a/drivers/dsp/bridge/pmgr/dbll.c b/drivers/dsp/bridge/pmgr/dbll.c
index 367597d..9b31f41 100644
--- a/drivers/dsp/bridge/pmgr/dbll.c
+++ b/drivers/dsp/bridge/pmgr/dbll.c
@@ -262,9 +262,6 @@ DSP_STATUS DBLL_create(struct DBLL_TarObj **pTarget, struct DBLL_Attrs *pAttrs)
 	MEM_AllocObject(pzlTarget, struct DBLL_TarObj, DBLL_TARGSIGNATURE);
 	if (pTarget != NULL) {
 		if (pzlTarget == NULL) {
-			GT_0trace(DBLL_debugMask, GT_6CLASS,
-				 "DBLL_create: Memory allocation"
-				 " failed\n");
 			*pTarget = NULL;
 			status = DSP_EMEMORY;
 		} else {
@@ -563,10 +560,6 @@ DSP_STATUS DBLL_load(struct DBLL_LibraryObj *lib, DBLL_Flags flags,
 			      &zlLib->mHandle);
 
 			if (err != 0) {
-				GT_1trace(DBLL_debugMask, GT_6CLASS,
-					 "DBLL_load: "
-					 "Dynamic_Load_Module failed: 0x%lx\n",
-					 err);
 				status = DSP_EDYNLOAD;
 			} else if (bRedefinedSymbol) {
 				zlLib->loadRef++;
@@ -635,8 +628,6 @@ DSP_STATUS DBLL_open(struct DBLL_TarObj *target, char *file, DBLL_Flags flags,
 		MEM_AllocObject(zlLib, struct DBLL_LibraryObj,
 				DBLL_LIBSIGNATURE);
 		if (zlLib == NULL) {
-			GT_0trace(DBLL_debugMask, GT_6CLASS,
-				 "DBLL_open: Memory allocation failed\n");
 			status = DSP_EMEMORY;
 		} else {
 			zlLib->ulPos = 0;
@@ -648,9 +639,6 @@ DSP_STATUS DBLL_open(struct DBLL_TarObj *target, char *file, DBLL_Flags flags,
 			zlLib->fileName = MEM_Calloc(strlen(file) + 1,
 							MEM_PAGED);
 			if (zlLib->fileName == NULL) {
-				GT_0trace(DBLL_debugMask, GT_6CLASS,
-					 "DBLL_open: Memory "
-					 "allocation failed\n");
 				status = DSP_EMEMORY;
 			} else {
 				strncpy(zlLib->fileName, file,
@@ -711,8 +699,6 @@ DSP_STATUS DBLL_open(struct DBLL_TarObj *target, char *file, DBLL_Flags flags,
 					&zlLib->init.dlInit, 0,
 					&zlLib->mHandle);
 		if (err != 0) {
-			GT_1trace(DBLL_debugMask, GT_6CLASS, "DBLL_open: "
-				 "Dynamic_Load_Module failed: 0x%lx\n", err);
 			status = DSP_EDYNLOAD;
 		} else {
 			/* Now that we have the symbol table, we can unload */
@@ -720,13 +706,9 @@ DSP_STATUS DBLL_open(struct DBLL_TarObj *target, char *file, DBLL_Flags flags,
 						   &zlLib->symbol.dlSymbol,
 						   &zlLib->allocate.dlAlloc,
 						   &zlLib->init.dlInit);
-			if (err != 0) {
-				GT_1trace(DBLL_debugMask, GT_6CLASS,
-					"DBLL_open: "
-					"Dynamic_Unload_Module failed: 0x%lx\n",
-					err);
+			if (err != 0)
 				status = DSP_EDYNLOAD;
-			}
+
 			zlLib->mHandle = NULL;
 		}
 	}
@@ -889,9 +871,7 @@ DSP_STATUS DBLL_unloadSect(struct DBLL_LibraryObj *lib, char *sectName,
 {
 	DBC_Require(cRefs > 0);
 	DBC_Require(sectName != NULL);
-	GT_2trace(DBLL_debugMask, GT_ENTER,
-		 "DBLL_unloadSect: lib: 0x%x sectName: "
-		 "%s\n", lib, sectName);
+
 	return DSP_ENOTIMPL;
 }
 
diff --git a/drivers/dsp/bridge/pmgr/dev.c b/drivers/dsp/bridge/pmgr/dev.c
index c6561a4..8ee6d69 100644
--- a/drivers/dsp/bridge/pmgr/dev.c
+++ b/drivers/dsp/bridge/pmgr/dev.c
@@ -161,8 +161,6 @@ DSP_STATUS DEV_CreateDevice(OUT struct DEV_OBJECT **phDevObject,
 	WMD_DRV_Entry(&pDrvFxns, pstrWMDFileName);
 	if (DSP_FAILED(CFG_GetObject((u32 *) &hDrvObject, REG_DRV_OBJECT))) {
 		/* don't propogate CFG errors from this PROC function */
-		GT_0trace(debugMask, GT_7CLASS,
-			  "Failed to get the DRV Object \n");
 		status = DSP_EFAIL;
 	}
 	/* Create the device object, and pass a handle to the WMD for
@@ -193,8 +191,6 @@ DSP_STATUS DEV_CreateDevice(OUT struct DEV_OBJECT **phDevObject,
 			DBC_Assert(DSP_FAILED(status) || (pDevObject->
 				   hWmdContext != NULL));
 		} else {
-			GT_0trace(debugMask, GT_7CLASS,
-				  "DEV_Create: Out Of Memory");
 			status = DSP_EMEMORY;
 		}
 	}
@@ -233,11 +229,6 @@ DSP_STATUS DEV_CreateDevice(OUT struct DEV_OBJECT **phDevObject,
 		/* Create CMM mgr even if Msg Mgr not impl.  */
 		status = CMM_Create(&pDevObject->hCmmMgr,
 				   (struct DEV_OBJECT *)pDevObject, NULL);
-		if (DSP_FAILED(status)) {
-			GT_0trace(debugMask, GT_7CLASS,
-				  "DEV_Create: Failed to Create SM "
-				  "Manager\n");
-		}
 		/* Only create IO manager if we have a channel manager */
 		if (DSP_SUCCEEDED(status) && pDevObject->hChnlMgr) {
 			status = IO_Create(&pDevObject->hIOMgr, pDevObject,
@@ -252,11 +243,6 @@ DSP_STATUS DEV_CreateDevice(OUT struct DEV_OBJECT **phDevObject,
 		/* Create DMM mgr .  */
 		status = DMM_Create(&pDevObject->hDmmMgr,
 				   (struct DEV_OBJECT *)pDevObject, NULL);
-		if (DSP_FAILED(status)) {
-			GT_0trace(debugMask, GT_7CLASS,
-				  "DEV_Create: Failed to Create DMM "
-				  "Manager\n");
-		}
 	}
 	/* Add the new DEV_Object to the global list: */
 	if (DSP_SUCCEEDED(status)) {
@@ -267,13 +253,10 @@ DSP_STATUS DEV_CreateDevice(OUT struct DEV_OBJECT **phDevObject,
 	if (DSP_SUCCEEDED(status)) {
 		pDevObject->procList = MEM_Calloc(sizeof(struct LST_LIST),
 			MEM_NONPAGED);
-		if (!(pDevObject->procList)) {
+		if (!(pDevObject->procList))
 			status = DSP_EFAIL;
-			GT_0trace(debugMask, GT_7CLASS, "DEV_Create: "
-				 "Failed to Create Proc List");
-		} else {
+		else
 			INIT_LIST_HEAD(&pDevObject->procList->head);
-		}
 	}
 	 /*  If all went well, return a handle to the dev object;
 	 *  else, cleanup and return NULL in the OUT parameter.  */
@@ -292,7 +275,6 @@ DSP_STATUS DEV_CreateDevice(OUT struct DEV_OBJECT **phDevObject,
 			MEM_FreeObject(pDevObject);
 
 		*phDevObject = NULL;
-		GT_0trace(debugMask, GT_7CLASS, "DEV_CreateDevice Failed\n");
 	}
 
 	DBC_Ensure((DSP_SUCCEEDED(status) && IsValidHandle(*phDevObject)) ||
@@ -318,13 +300,9 @@ DSP_STATUS DEV_Create2(struct DEV_OBJECT *hDevObject)
 	/* There can be only one Node Manager per DEV object */
 	DBC_Assert(!pDevObject->hNodeMgr);
 	status = NODE_CreateMgr(&pDevObject->hNodeMgr, hDevObject);
-	if (DSP_FAILED(status)) {
-		GT_1trace(debugMask, GT_7CLASS,
-			 "DEV_Create2: NODE_CreateMgr failed, "
-			 "0x%x!\n", status);
+	if (DSP_FAILED(status))
 		pDevObject->hNodeMgr = NULL;
-		GT_0trace(debugMask, GT_7CLASS, "DEV_Create2: Failed!!\n");
-	}
+
 	DBC_Ensure((DSP_SUCCEEDED(status) && pDevObject->hNodeMgr != NULL)
 		   || (DSP_FAILED(status) && pDevObject->hNodeMgr == NULL));
 	return status;
@@ -350,8 +328,6 @@ DSP_STATUS DEV_Destroy2(struct DEV_OBJECT *hDevObject)
 			pDevObject->hNodeMgr = NULL;
 
 	}
-	if (DSP_FAILED(status))
-		GT_0trace(debugMask, GT_7CLASS, "DEV_Destroy2 failed!!\n");
 
 	DBC_Ensure((DSP_SUCCEEDED(status) && pDevObject->hNodeMgr == NULL) ||
 		  DSP_FAILED(status));
@@ -433,7 +409,6 @@ DSP_STATUS DEV_DestroyDevice(struct DEV_OBJECT *hDevObject)
 			pDevObject = NULL;
 		}
 	} else {
-		GT_0trace(debugMask, GT_7CLASS, "DEV_Destroy: Invlaid handle");
 		status = DSP_EHANDLE;
 	}
 
@@ -460,8 +435,6 @@ DSP_STATUS DEV_GetChnlMgr(struct DEV_OBJECT *hDevObject,
 	} else {
 		*phMgr = NULL;
 		status = DSP_EHANDLE;
-		GT_0trace(debugMask, GT_7CLASS,
-			 "DEV_GetChnlMgr: Invalid handle");
 	}
 
 	DBC_Ensure(DSP_SUCCEEDED(status) || ((phMgr != NULL) &&
@@ -489,8 +462,6 @@ DSP_STATUS DEV_GetCmmMgr(struct DEV_OBJECT *hDevObject,
 	} else {
 		*phMgr = NULL;
 		status = DSP_EHANDLE;
-		GT_0trace(debugMask, GT_7CLASS,
-			 "DEV_GetCmmMgr: Invalid handle");
 	}
 
 	DBC_Ensure(DSP_SUCCEEDED(status) || ((phMgr != NULL) &&
@@ -518,8 +489,6 @@ DSP_STATUS DEV_GetDmmMgr(struct DEV_OBJECT *hDevObject,
 	} else {
 		*phMgr = NULL;
 		status = DSP_EHANDLE;
-		GT_0trace(debugMask, GT_7CLASS,
-			 "DEV_GetDmmMgr: Invalid handle");
 	}
 
 	DBC_Ensure(DSP_SUCCEEDED(status) || ((phMgr != NULL) &&
@@ -546,9 +515,6 @@ DSP_STATUS DEV_GetCodMgr(struct DEV_OBJECT *hDevObject,
 	} else {
 		*phCodMgr = NULL;
 		status = DSP_EHANDLE;
-		GT_1trace(debugMask, GT_7CLASS,
-			 "DEV_GetCodMgr, invalid handle:  0x%x\n",
-			 hDevObject);
 	}
 
 	DBC_Ensure(DSP_SUCCEEDED(status) || ((phCodMgr != NULL) &&
@@ -572,8 +538,6 @@ DSP_STATUS DEV_GetDehMgr(struct DEV_OBJECT *hDevObject,
 	} else {
 		*phDehMgr = NULL;
 		status = DSP_EHANDLE;
-		GT_0trace(debugMask, GT_7CLASS,
-			 "DEV_GetDehMgr: Invalid handle");
 	}
 	return status;
 }
@@ -597,8 +561,6 @@ DSP_STATUS DEV_GetDevNode(struct DEV_OBJECT *hDevObject,
 	} else {
 		*phDevNode = NULL;
 		status = DSP_EHANDLE;
-		GT_0trace(debugMask, GT_7CLASS,
-			 "DEV_GetDevNode: Invalid handle");
 	}
 
 	DBC_Ensure(DSP_SUCCEEDED(status) || ((phDevNode != NULL) &&
@@ -643,8 +605,6 @@ DSP_STATUS DEV_GetIntfFxns(struct DEV_OBJECT *hDevObject,
 	} else {
 		*ppIntfFxns = NULL;
 		status = DSP_EHANDLE;
-		GT_0trace(debugMask, GT_7CLASS,
-			  "DEV_GetIntDxns: Invalid handle");
 	}
 
 	DBC_Ensure(DSP_SUCCEEDED(status) || ((ppIntfFxns != NULL) &&
@@ -669,7 +629,6 @@ DSP_STATUS DEV_GetIOMgr(struct DEV_OBJECT *hDevObject,
 	} else {
 		*phIOMgr = NULL;
 		status = DSP_EHANDLE;
-		GT_0trace(debugMask, GT_7CLASS, "DEV_GetIOMgr: Invalid handle");
 	}
 
 	return status;
@@ -726,9 +685,6 @@ DSP_STATUS DEV_GetNodeManager(struct DEV_OBJECT *hDevObject,
 	} else {
 		*phNodeMgr = NULL;
 		status = DSP_EHANDLE;
-		GT_1trace(debugMask, GT_7CLASS,
-			 "DEV_GetNodeManager, invalid handle: 0x"
-			 "%x\n", hDevObject);
 	}
 
 	DBC_Ensure(DSP_SUCCEEDED(status) || ((phNodeMgr != NULL) &&
@@ -757,8 +713,6 @@ DSP_STATUS DEV_GetSymbol(struct DEV_OBJECT *hDevObject,
 		}
 	} else {
 		status = DSP_EHANDLE;
-		GT_0trace(debugMask, GT_7CLASS,
-			 "DEV_GetSymbol: Invalid handle");
 	}
 
 	return status;
@@ -783,8 +737,6 @@ DSP_STATUS DEV_GetWMDContext(struct DEV_OBJECT *hDevObject,
 	} else {
 		*phWmdContext = NULL;
 		status = DSP_EHANDLE;
-		GT_0trace(debugMask, GT_7CLASS,
-			 "DEV_GetWMDContext: Invalid handle");
 	}
 
 	DBC_Ensure(DSP_SUCCEEDED(status) || ((phWmdContext != NULL) &&
@@ -906,13 +858,11 @@ DSP_STATUS DEV_SetChnlMgr(struct DEV_OBJECT *hDevObject, struct CHNL_MGR *hMgr)
 
 	DBC_Require(cRefs > 0);
 
-	if (IsValidHandle(hDevObject)) {
+	if (IsValidHandle(hDevObject))
 		pDevObject->hChnlMgr = hMgr;
-	} else {
+	else
 		status = DSP_EHANDLE;
-		GT_0trace(debugMask, GT_7CLASS,
-			 "DEV_SetChnlMgr, Invalid handle\n");
-	}
+
 	DBC_Ensure(DSP_FAILED(status) || (pDevObject->hChnlMgr == hMgr));
 	return status;
 }
@@ -950,15 +900,6 @@ DSP_STATUS DEV_StartDevice(struct CFG_DEVNODE *hDevNode)
 		if (DSP_SUCCEEDED(status)) {
 			/* Get DSP resources of device from Registry: */
 			status = CFG_GetDSPResources(hDevNode, &dspRes);
-			if (DSP_FAILED(status)) {
-				GT_1trace(debugMask, GT_7CLASS,
-					 "Failed to get WMD DSP resources"
-					 " from registry: 0x%x ", status);
-			}
-		} else {
-			GT_1trace(debugMask, GT_7CLASS,
-				 "Failed to get WMD Host resources "
-				 "from registry: 0x%x ", status);
 		}
 	if (DSP_SUCCEEDED(status)) {
 		/* Given all resources, create a device object. */
@@ -969,16 +910,9 @@ DSP_STATUS DEV_StartDevice(struct CFG_DEVNODE *hDevNode)
 			status = CFG_SetDevObject(hDevNode, (u32)hDevObject);
 			if (DSP_FAILED(status)) {
 				/* Clean up */
-				GT_1trace(debugMask, GT_7CLASS,
-					 "Failed to set DevObject in the "
-					 "Registry: 0x%x", status);
 				DEV_DestroyDevice(hDevObject);
 				hDevObject = NULL;
 			}
-		} else {
-			GT_1trace(debugMask, GT_7CLASS,
-				 "Failed to Create Device: 0x%x",
-				 status);
 		}
 	}
 	if (DSP_SUCCEEDED(status)) {
@@ -986,11 +920,6 @@ DSP_STATUS DEV_StartDevice(struct CFG_DEVNODE *hDevNode)
 		status = MGR_Create(&hMgrObject, hDevNode);
 	}
 	if (DSP_FAILED(status)) {
-		GT_1trace(debugMask, GT_7CLASS, "Failed to MGR object: 0x%x",
-			 status);
-		status = DSP_EFAIL;
-	}
-	if (DSP_FAILED(status)) {
 		if (hDevObject)
 			DEV_DestroyDevice(hDevObject);
 
@@ -1012,9 +941,6 @@ DSP_STATUS DEV_StartDevice(struct CFG_DEVNODE *hDevNode)
  */
 static DSP_STATUS FxnNotImplemented(int arg, ...)
 {
-	DBG_Trace(DBG_LEVEL1,
-		 "WARNING: Calling a non-implemented WMD function.\n");
-
 	return DSP_ENOTIMPL;
 }
 
diff --git a/drivers/dsp/bridge/pmgr/dmm.c b/drivers/dsp/bridge/pmgr/dmm.c
index 8dbcb77..ebecc8b 100644
--- a/drivers/dsp/bridge/pmgr/dmm.c
+++ b/drivers/dsp/bridge/pmgr/dmm.c
@@ -152,9 +152,6 @@ DSP_STATUS DMM_Create(OUT struct DMM_OBJECT **phDmmMgr,
 		else
 			DMM_Destroy(pDmmObject);
 	} else {
-		GT_0trace(DMM_debugMask, GT_7CLASS,
-			 "DMM_Create: Object Allocation "
-			 "Failure(DMM Object)\n");
 		status = DSP_EMEMORY;
 	}
 
@@ -178,10 +175,7 @@ DSP_STATUS DMM_Destroy(struct DMM_OBJECT *hDmmMgr)
 			/* Delete CS & dmm mgr object */
 			SYNC_DeleteCS(pDmmObj->hDmmLock);
 			MEM_FreeObject(pDmmObj);
-		} else
-			GT_0trace(DMM_debugMask, GT_7CLASS,
-			 "DMM_Destroy: DMM_DeleteTables "
-			 "Failure\n");
+		}
 	} else
 		status = DSP_EHANDLE;
 
diff --git a/drivers/dsp/bridge/pmgr/io.c b/drivers/dsp/bridge/pmgr/io.c
index e83178b..c6a4168 100644
--- a/drivers/dsp/bridge/pmgr/io.c
+++ b/drivers/dsp/bridge/pmgr/io.c
@@ -68,17 +68,11 @@ DSP_STATUS IO_Create(OUT struct IO_MGR **phIOMgr, struct DEV_OBJECT *hDevObject,
 	*phIOMgr = NULL;
 
 	/* A memory base of 0 implies no memory base:  */
-	if ((pMgrAttrs->dwSMBase != 0) && (pMgrAttrs->uSMLength == 0)) {
+	if ((pMgrAttrs->dwSMBase != 0) && (pMgrAttrs->uSMLength == 0))
 		status = CHNL_E_INVALIDMEMBASE;
-		GT_0trace(IO_DebugMask, GT_7CLASS,
-			 "IO_Create:Invalid Mem Base\n");
-	}
 
-	if (pMgrAttrs->uWordSize == 0) {
+	if (pMgrAttrs->uWordSize == 0)
 		status = CHNL_E_INVALIDWORDSIZE;
-		GT_0trace(IO_DebugMask, GT_7CLASS,
-			 "IO_Create:Invalid Word size\n");
-	}
 
 	if (DSP_SUCCEEDED(status)) {
 		DEV_GetIntfFxns(hDevObject, &pIntfFxns);
diff --git a/drivers/dsp/bridge/pmgr/wcd.c b/drivers/dsp/bridge/pmgr/wcd.c
index 9f2bdf5..4b8ae3d 100644
--- a/drivers/dsp/bridge/pmgr/wcd.c
+++ b/drivers/dsp/bridge/pmgr/wcd.c
@@ -183,11 +183,8 @@ static inline void __cp_fm_usr(void *to, const void __user *from,
 		return;
 	}
 
-	if (unlikely(copy_from_user(to, from, bytes))) {
-		GT_2trace(WCD_debugMask, GT_7CLASS,
-			  "%s failed, from=0x%08x\n", __func__, from);
+	if (unlikely(copy_from_user(to, from, bytes)))
 		*err = DSP_EPOINTER;
-	}
 }
 #define cp_fm_usr(to, from, err, n)				\
 	__cp_fm_usr(to, from, &(err), (n) * sizeof(*(to)))
@@ -203,11 +200,8 @@ static inline void __cp_to_usr(void __user *to, const void *from,
 		return;
 	}
 
-	if (unlikely(copy_to_user(to, from, bytes))) {
-		GT_2trace(WCD_debugMask, GT_7CLASS,
-			  "%s failed, to=0x%08x\n", __func__, to);
+	if (unlikely(copy_to_user(to, from, bytes)))
 		*err = DSP_EPOINTER;
-	}
 }
 #define cp_to_usr(to, from, err, n)				\
 	__cp_to_usr(to, from, &(err), (n) * sizeof(*(from)))
@@ -411,15 +405,10 @@ DSP_STATUS WCD_InitComplete2(void)
 
 		if ((devType == DSP_UNIT) || (devType == IVA_UNIT)) {
 			if (DSP_FAILED(PROC_AutoStart(DevNode, hDevObject))) {
-				GT_0trace(WCD_debugMask, GT_1CLASS,
-					 "WCD_InitComplete2 Failed\n");
 				status = DSP_EFAIL;
 				/* break; */
 			}
-		} else
-			GT_1trace(WCD_debugMask, GT_ENTER,
-				 "Ignoring PROC_AutoStart "
-				 "for Device Type = 0x%x \n", devType);
+		}
 	}			/* End For Loop */
 
 	return status;
-- 
1.6.2.4


From: Ameya Palande <ameya.palande@nokia.com>
Subject: [PATCH 2/3] DSPBRIDGE: Get rid of MEM_Free()
Date: Thu,  4 Feb 2010 01:32:25 +0200
Message-ID: <b1cd4878f167765473cfd1cc1a1027a2d80ddc8e.1265239075.git.ameya.palande@nokia.com>
References: <cover.1265239075.git.ameya.palande@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:23028 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757884Ab0BCXck (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Feb 2010 18:32:40 -0500
In-Reply-To: <cover.1265239075.git.ameya.palande@nokia.com>
In-Reply-To: <cover.1265239075.git.ameya.palande@nokia.com>
References: <cover.1265239075.git.ameya.palande@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: omar.ramirez@ti.com, nm@ti.com, deepak.chitriki@ti.com

kfree() is NULL and ZERO pointer safe so MEM_Free() doesn't provide any
significant advantage. By getting rid of MEM_Free() and the NULL pointer
check associated with it, we can save on:
1. One level of indirection which translates to a function call cost.
2. NULL pointer checking cost.

Signed-off-by: Ameya Palande <ameya.palande@nokia.com>
---
 arch/arm/plat-omap/include/dspbridge/mem.h |   19 +------
 drivers/dsp/bridge/gen/gs.c                |    4 +-
 drivers/dsp/bridge/pmgr/cmm.c              |   12 ++--
 drivers/dsp/bridge/pmgr/cod.c              |    4 +-
 drivers/dsp/bridge/pmgr/dbll.c             |   15 +++---
 drivers/dsp/bridge/pmgr/dev.c              |   11 ++---
 drivers/dsp/bridge/pmgr/wcd.c              |   46 +++++++----------
 drivers/dsp/bridge/rmgr/dbdcd.c            |   13 ++---
 drivers/dsp/bridge/rmgr/disp.c             |    3 +-
 drivers/dsp/bridge/rmgr/drv.c              |   32 ++++++------
 drivers/dsp/bridge/rmgr/drv_interface.c    |    2 +-
 drivers/dsp/bridge/rmgr/nldr.c             |   52 +++++++------------
 drivers/dsp/bridge/rmgr/node.c             |   77 ++++++++++------------------
 drivers/dsp/bridge/rmgr/proc.c             |   11 ++--
 drivers/dsp/bridge/rmgr/rmm.c              |   18 +++---
 drivers/dsp/bridge/rmgr/strm.c             |    3 +-
 drivers/dsp/bridge/services/mem.c          |   17 ------
 drivers/dsp/bridge/services/ntfy.c         |    7 +--
 drivers/dsp/bridge/services/regsup.c       |   10 ++--
 drivers/dsp/bridge/services/sync.c         |    3 +-
 drivers/dsp/bridge/wmd/chnl_sm.c           |   11 ++--
 drivers/dsp/bridge/wmd/io_sm.c             |   12 ++---
 drivers/dsp/bridge/wmd/msg_sm.c            |    8 ++--
 drivers/dsp/bridge/wmd/tiomap3430.c        |   17 ++----
 drivers/dsp/bridge/wmd/ue_deh.c            |    2 +-
 25 files changed, 156 insertions(+), 253 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/mem.h b/arch/arm/plat-omap/include/dspbridge/mem.h
index 353ffb0..3b94c02 100644
--- a/arch/arm/plat-omap/include/dspbridge/mem.h
+++ b/arch/arm/plat-omap/include/dspbridge/mem.h
@@ -140,21 +140,6 @@
 	extern void MEM_FlushCache(void *pMemBuf, u32 cBytes, s32 FlushType);
 
 /*
- *  ======== MEM_Free ========
- *  Purpose:
- *      Free the given block of system memory.
- *  Parameters:
- *      pMemBuf:    Pointer to memory allocated by MEM_Calloc/Alloc().
- *  Returns:
- *  Requires:
- *      MEM initialized.
- *      pMemBuf is a valid memory address returned by MEM_Calloc/Alloc().
- *  Ensures:
- *      pMemBuf is no longer a valid pointer to memory.
- */
-	extern void MEM_Free(IN void *pMemBuf);
-
-/*
  *  ======== MEM_VFree ========
  *  Purpose:
  *      Free the given block of system memory in virtual space.
@@ -200,14 +185,14 @@
  *      pObj:   Pointer to the object to free.
  *  Returns:
  *  Requires:
- *      Same requirements as MEM_Free().
+ *      Same requirements as kfree().
  *  Ensures:
  *      A subsequent call to MEM_IsValidHandle() will fail for this object.
  */
 #define MEM_FreeObject(pObj)    \
 {                               \
     pObj->dwSignature = 0x00;   \
-    MEM_Free(pObj);             \
+    kfree(pObj);             \
 }
 
 /*
diff --git a/drivers/dsp/bridge/gen/gs.c b/drivers/dsp/bridge/gen/gs.c
index 1197829..05b2e56 100644
--- a/drivers/dsp/bridge/gen/gs.c
+++ b/drivers/dsp/bridge/gen/gs.c
@@ -62,7 +62,7 @@ void GS_exit(void)
  */
 void GS_free(void *ptr)
 {
-	MEM_Free(ptr);
+	kfree(ptr);
 	/* ack! no size info */
 	/* cumsize -= size; */
 }
@@ -74,7 +74,7 @@ void GS_free(void *ptr)
  */
 void GS_frees(void *ptr, u32 size)
 {
-	MEM_Free(ptr);
+	kfree(ptr);
 	cumsize -= size;
 }
 
diff --git a/drivers/dsp/bridge/pmgr/cmm.c b/drivers/dsp/bridge/pmgr/cmm.c
index 262f087..03d2e63 100644
--- a/drivers/dsp/bridge/pmgr/cmm.c
+++ b/drivers/dsp/bridge/pmgr/cmm.c
@@ -369,10 +369,10 @@ DSP_STATUS CMM_Destroy(struct CMM_OBJECT *hCmmMgr, bool bForce)
 		while (!LST_IsEmpty(pCmmMgr->pNodeFreeListHead)) {
 			pNode = (struct CMM_MNODE *)LST_GetHead(pCmmMgr->
 				 pNodeFreeListHead);
-			MEM_Free(pNode);
+			kfree(pNode);
 		}
 		/* delete NodeFreeList list */
-		MEM_Free(pCmmMgr->pNodeFreeListHead);
+		kfree(pCmmMgr->pNodeFreeListHead);
 	}
 	SYNC_LeaveCS(pCmmMgr->hCmmLock);
 	if (DSP_SUCCEEDED(status)) {
@@ -765,11 +765,11 @@ static void UnRegisterGPPSMSeg(struct CMM_ALLOCATOR *pSMA)
 				    (struct list_head *)pCurNode);
 			LST_RemoveElem(pSMA->pFreeListHead,
 				      (struct list_head *)pCurNode);
-			MEM_Free((void *) pCurNode);
+			kfree((void *) pCurNode);
 			/* next node. */
 			pCurNode = pNextNode;
 		}
-		MEM_Free(pSMA->pFreeListHead);		/* delete freelist */
+		kfree(pSMA->pFreeListHead);		/* delete freelist */
 		/* free nodes on InUse list */
 		pCurNode = (struct CMM_MNODE *)LST_First(pSMA->pInUseListHead);
 		while (pCurNode) {
@@ -778,11 +778,11 @@ static void UnRegisterGPPSMSeg(struct CMM_ALLOCATOR *pSMA)
 				    (struct list_head *)pCurNode);
 			LST_RemoveElem(pSMA->pInUseListHead,
 				      (struct list_head *)pCurNode);
-			MEM_Free((void *) pCurNode);
+			kfree((void *) pCurNode);
 			/* next node. */
 			pCurNode = pNextNode;
 		}
-		MEM_Free(pSMA->pInUseListHead);		/* delete InUse list */
+		kfree(pSMA->pInUseListHead);		/* delete InUse list */
 	}
 	if ((void *) pSMA->dwVmBase != NULL)
 		MEM_UnmapLinearAddress((void *) pSMA->dwVmBase);
diff --git a/drivers/dsp/bridge/pmgr/cod.c b/drivers/dsp/bridge/pmgr/cod.c
index bfbe107..8a18ef9 100644
--- a/drivers/dsp/bridge/pmgr/cod.c
+++ b/drivers/dsp/bridge/pmgr/cod.c
@@ -210,7 +210,7 @@ void COD_Close(struct COD_LIBRARYOBJ *lib)
 	hMgr = lib->hCodMgr;
 	hMgr->fxns.closeFxn(lib->dbllLib);
 
-	MEM_Free(lib);
+	kfree(lib);
 }
 
 /*
@@ -315,7 +315,7 @@ void COD_Delete(struct COD_MANAGER *hMgr)
 		hMgr->fxns.exitFxn();
 	}
 	hMgr->ulMagic = ~MAGIC;
-	MEM_Free(hMgr);
+	kfree(hMgr);
 }
 
 /*
diff --git a/drivers/dsp/bridge/pmgr/dbll.c b/drivers/dsp/bridge/pmgr/dbll.c
index 80ca4d4..82d07f4 100644
--- a/drivers/dsp/bridge/pmgr/dbll.c
+++ b/drivers/dsp/bridge/pmgr/dbll.c
@@ -235,8 +235,7 @@ void DBLL_close(struct DBLL_LibraryObj *zlLib)
 
 		/* Free DOF resources */
 		dofClose(zlLib);
-		if (zlLib->fileName)
-			MEM_Free(zlLib->fileName);
+		kfree(zlLib->fileName);
 
 		/* remove symbols from symbol table */
 		if (zlLib->symTab)
@@ -1009,7 +1008,7 @@ static void symDelete(void *value)
 {
 	struct Symbol *sp = (struct Symbol *)value;
 
-	MEM_Free(sp->name);
+	kfree(sp->name);
 }
 
 /*
@@ -1178,7 +1177,7 @@ static struct dynload_symbol *addToSymbolTable(struct Dynamic_Loader_Sym *this,
 		symPtr = (struct Symbol *)GH_insert(lib->symTab, (void *)name,
 			 (void *)&symbol);
 		if (symPtr == NULL)
-			MEM_Free(symbol.name);
+			kfree(symbol.name);
 
 	}
 	if (symPtr != NULL)
@@ -1234,7 +1233,7 @@ static void deallocate(struct Dynamic_Loader_Sym *this, void *memPtr)
 	lib = pSymbol->lib;
 	DBC_Require(MEM_IsValidHandle(lib, DBLL_LIBSIGNATURE));
 
-	MEM_Free(memPtr);
+	kfree(memPtr);
 }
 
 /*
@@ -1336,11 +1335,11 @@ static int rmmAlloc(struct Dynamic_Loader_Allocate *this,
 				 req, segId);
 		}
 	}
-	MEM_Free(szSectName);
+	kfree(szSectName);
 	szSectName = NULL;
-	MEM_Free(szLastToken);
+	kfree(szLastToken);
 	szLastToken = NULL;
-	MEM_Free(szSecLastToken);
+	kfree(szSecLastToken);
 	szSecLastToken = NULL;
 func_cont:
 	if (memType == DBLL_CODE)
diff --git a/drivers/dsp/bridge/pmgr/dev.c b/drivers/dsp/bridge/pmgr/dev.c
index 2b2d669..7338003 100644
--- a/drivers/dsp/bridge/pmgr/dev.c
+++ b/drivers/dsp/bridge/pmgr/dev.c
@@ -295,8 +295,8 @@ DSP_STATUS DEV_CreateDevice(OUT struct DEV_OBJECT **phDevObject,
 			 "DEV_CreateDevice Succeeded \nDevObject "
 			 "0x%x\n", pDevObject);
 	} else {
-		if (pDevObject && pDevObject->procList)
-			MEM_Free(pDevObject->procList);
+		if (pDevObject)
+			kfree(pDevObject->procList);
 
 		if (pDevObject && pDevObject->hCodMgr)
 			COD_Delete(pDevObject->hCodMgr);
@@ -451,11 +451,8 @@ DSP_STATUS DEV_DestroyDevice(struct DEV_OBJECT *hDevObject)
 		} else
 			status = DSP_EFAIL;
 		if (DSP_SUCCEEDED(status)) {
-			if (pDevObject->procList) {
-				MEM_Free(pDevObject->procList);
-				pDevObject->procList = NULL;
-			}
-
+			kfree(pDevObject->procList);
+			pDevObject->procList = NULL;
 			/* Remove this DEV_Object from the global list: */
 			DRV_RemoveDevObject(pDevObject->hDrvObject, pDevObject);
 			/* Free The library * LDR_FreeModule
diff --git a/drivers/dsp/bridge/pmgr/wcd.c b/drivers/dsp/bridge/pmgr/wcd.c
index 9e34af1..beea23b 100644
--- a/drivers/dsp/bridge/pmgr/wcd.c
+++ b/drivers/dsp/bridge/pmgr/wcd.c
@@ -465,8 +465,7 @@ u32 MGRWRAP_EnumNode_Info(union Trapped_Args *args, void *pr_ctxt)
 		 size);
 	cp_to_usr(args->ARGS_MGR_ENUMNODE_INFO.puNumNodes, &uNumNodes, status,
 		 1);
-	if (pNDBProps)
-		MEM_Free(pNDBProps);
+	kfree(pNDBProps);
 
 	return status;
 }
@@ -507,8 +506,7 @@ u32 MGRWRAP_EnumProc_Info(union Trapped_Args *args, void *pr_ctxt)
 		 status, size);
 	cp_to_usr(args->ARGS_MGR_ENUMPROC_INFO.puNumProcs, &uNumProcs,
 		 status, 1);
-	if (pProcessorInfo)
-		MEM_Free(pProcessorInfo);
+	kfree(pProcessorInfo);
 
 	return status;
 }
@@ -554,8 +552,7 @@ u32 MGRWRAP_RegisterObject(union Trapped_Args *args, void *pr_ctxt)
 				args->ARGS_MGR_REGISTEROBJECT.objType,
 				(char *)pszPathName);
 func_end:
-	if (pszPathName)
-		MEM_Free(pszPathName);
+	kfree(pszPathName);
 	return status;
 }
 
@@ -699,8 +696,7 @@ u32 PROCWRAP_Ctrl(union Trapped_Args *args, void *pr_ctxt)
 	}
 
 	/* cp_to_usr(args->ARGS_PROC_CTRL.pArgs, pArgs, status, 1);*/
-	if (pArgs)
-		MEM_Free(pArgs);
+	kfree(pArgs);
 func_end:
 	return status;
 }
@@ -865,8 +861,7 @@ u32 PROCWRAP_GetTrace(union Trapped_Args *args, void *pr_ctxt)
 	}
 	cp_to_usr(args->ARGS_PROC_GETTRACE.pBuf, pBuf, status,
 		 args->ARGS_PROC_GETTRACE.uMaxSize);
-	if (pBuf)
-		MEM_Free(pBuf);
+	kfree(pBuf);
 
 	return status;
 }
@@ -895,7 +890,7 @@ u32 PROCWRAP_Load(union Trapped_Args *args, void *pr_ctxt)
 
 	cp_fm_usr(argv, args->ARGS_PROC_LOAD.aArgv, status, count);
 	if (DSP_FAILED(status)) {
-		MEM_Free(argv);
+		kfree(argv);
 		argv = NULL;
 		goto func_cont;
 	}
@@ -911,7 +906,7 @@ u32 PROCWRAP_Load(union Trapped_Args *args, void *pr_ctxt)
 			if (argv[i]) {
 				cp_fm_usr(argv[i], temp, status, len);
 				if (DSP_FAILED(status)) {
-					MEM_Free(argv[i]);
+					kfree(argv[i]);
 					argv[i] = NULL;
 					goto func_cont;
 				}
@@ -937,7 +932,7 @@ u32 PROCWRAP_Load(union Trapped_Args *args, void *pr_ctxt)
 
 		cp_fm_usr(envp, args->ARGS_PROC_LOAD.aEnvp, status, count);
 		if (DSP_FAILED(status)) {
-			MEM_Free(envp);
+			kfree(envp);
 			envp = NULL;
 			goto func_cont;
 		}
@@ -951,7 +946,7 @@ u32 PROCWRAP_Load(union Trapped_Args *args, void *pr_ctxt)
 			if (envp[i]) {
 				cp_fm_usr(envp[i], temp, status, len);
 				if (DSP_FAILED(status)) {
-					MEM_Free(envp[i]);
+					kfree(envp[i]);
 					envp[i] = NULL;
 					goto func_cont;
 				}
@@ -976,17 +971,17 @@ func_cont:
 	if (envp) {
 		i = 0;
 		while (envp[i])
-			MEM_Free(envp[i++]);
+			kfree(envp[i++]);
 
-		MEM_Free(envp);
+		kfree(envp);
 	}
 
 	if (argv) {
 		count = args->ARGS_PROC_LOAD.iArgc;
 		for (i = 0; (i < count) && argv[i]; i++)
-			MEM_Free(argv[i]);
+			kfree(argv[i]);
 
-		MEM_Free(argv);
+		kfree(argv);
 	}
 
 	return status;
@@ -1177,8 +1172,7 @@ u32 NODEWRAP_Allocate(union Trapped_Args *args, void *pr_ctxt)
 		}
 	}
 func_cont:
-	if (pArgs)
-		MEM_Free(pArgs);
+	kfree(pArgs);
 
 	return status;
 }
@@ -1275,8 +1269,7 @@ u32 NODEWRAP_Connect(union Trapped_Args *args, void *pr_ctxt)
 				     pAttrs, (struct DSP_CBDATA *)pArgs);
 	}
 func_cont:
-	if (pArgs)
-		MEM_Free(pArgs);
+	kfree(pArgs);
 
 	return status;
 }
@@ -1487,8 +1480,7 @@ u32 NODEWRAP_GetUUIDProps(union Trapped_Args *args, void *pr_ctxt)
 	} else
 		status = DSP_EMEMORY;
 func_cont:
-	if (pnodeProps)
-		MEM_Free(pnodeProps);
+	kfree(pnodeProps);
 	return status;
 }
 
@@ -1519,8 +1511,7 @@ u32 STRMWRAP_AllocateBuffer(union Trapped_Args *args, void *pr_ctxt)
 				apBuffer, uNumBufs, pr_ctxt);
 		}
 	}
-	if (apBuffer)
-		MEM_Free(apBuffer);
+	kfree(apBuffer);
 
 	return status;
 }
@@ -1556,8 +1547,7 @@ u32 STRMWRAP_FreeBuffer(union Trapped_Args *args, void *pr_ctxt)
 	}
 	cp_to_usr(args->ARGS_STRM_FREEBUFFER.apBuffer, apBuffer, status,
 		 uNumBufs);
-	if (apBuffer)
-		MEM_Free(apBuffer);
+	kfree(apBuffer);
 
 	return status;
 }
diff --git a/drivers/dsp/bridge/rmgr/dbdcd.c b/drivers/dsp/bridge/rmgr/dbdcd.c
index caa57f1..9efb7dc 100644
--- a/drivers/dsp/bridge/rmgr/dbdcd.c
+++ b/drivers/dsp/bridge/rmgr/dbdcd.c
@@ -563,13 +563,12 @@ DSP_STATUS DCD_GetObjectDef(IN struct DCD_MANAGER *hDcdMgr,
 	}
 
 	/* Free the previously allocated dynamic buffer. */
-	MEM_Free(pszCoffBuf);
+	kfree(pszCoffBuf);
 func_end:
 	if (lib)
 		COD_Close(lib);
 
-	if (szUuid)
-		MEM_Free(szUuid);
+	kfree(szUuid);
 
 	return status;
 }
@@ -690,7 +689,7 @@ DSP_STATUS DCD_GetObjects(IN struct DCD_MANAGER *hDcdMgr, IN char *pszCoffPath,
 	}
 
 	/* Free the previously allocated dynamic buffer. */
-	MEM_Free(pszCoffBuf);
+	kfree(pszCoffBuf);
 func_cont:
 	if (lib)
 		COD_Close(lib);
@@ -1514,11 +1513,9 @@ func_cont:
 		COD_Close(lib);
 
 	/* Free previously allocated dynamic buffers. */
-	if (pszFileName)
-		MEM_Free(pszFileName);
+	kfree(pszFileName);
 
-	if (pszCoffBuf)
-		MEM_Free(pszCoffBuf);
+	kfree(pszCoffBuf);
 
 	return status;
 }
diff --git a/drivers/dsp/bridge/rmgr/disp.c b/drivers/dsp/bridge/rmgr/disp.c
index 949c5e3..e53b11f 100644
--- a/drivers/dsp/bridge/rmgr/disp.c
+++ b/drivers/dsp/bridge/rmgr/disp.c
@@ -726,8 +726,7 @@ static void DeleteDisp(struct DISP_OBJECT *hDisp)
 					 status);
 			}
 		}
-		if (hDisp->pBuf)
-			MEM_Free(hDisp->pBuf);
+		kfree(hDisp->pBuf);
 
 		MEM_FreeObject(hDisp);
 	}
diff --git a/drivers/dsp/bridge/rmgr/drv.c b/drivers/dsp/bridge/rmgr/drv.c
index 122727d..637372a 100644
--- a/drivers/dsp/bridge/rmgr/drv.c
+++ b/drivers/dsp/bridge/rmgr/drv.c
@@ -134,7 +134,7 @@ DSP_STATUS DRV_RemoveNodeResElement(HANDLE hNodeRes, HANDLE hPCtxt)
 			return DSP_ENOTFOUND;
 		pTempNode->next = pNodeRes->next;
 	}
-	MEM_Free(pNodeRes);
+	kfree(pNodeRes);
 	return DSP_SOK;
 }
 
@@ -236,7 +236,7 @@ DSP_STATUS DRV_RemoveDMMResElement(HANDLE hDMMRes, HANDLE hPCtxt)
 			return DSP_ENOTFOUND;
 		pTempDMMRes->next = pDMMRes->next;
 	}
-	MEM_Free(pDMMRes);
+	kfree(pDMMRes);
 	return DSP_SOK;
 }
 
@@ -302,7 +302,7 @@ DSP_STATUS DRV_RemoveAllDMMResElements(HANDLE hPCtxt)
 	while (pTempDMMRes != NULL) {
 		pTempDMMRes2 = pTempDMMRes;
 		pTempDMMRes = pTempDMMRes->next;
-		MEM_Free(pTempDMMRes2);
+		kfree(pTempDMMRes2);
 	}
 	pCtxt->pDMMList = NULL;
 	return status;
@@ -363,7 +363,7 @@ DSP_STATUS 	DRV_RemoveAllNodeResElements(HANDLE hPCtxt)
 	while (pTempNode != NULL) {
 		pTempNode2 = pTempNode;
 		pTempNode = pTempNode->next;
-		MEM_Free(pTempNode2);
+		kfree(pTempNode2);
 	}
 	pCtxt->pNodeList = NULL;
 	return status;
@@ -449,7 +449,7 @@ DSP_STATUS 	DRV_ProcRemoveSTRMResElement(HANDLE hSTRMRes, HANDLE hPCtxt)
 		pTempSTRMRes->next = pSTRMRes->next;
 	}
 
-	MEM_Free(pSTRMRes);
+	kfree(pSTRMRes);
 	return DSP_SOK;
 }
 
@@ -476,7 +476,7 @@ static DSP_STATUS  DRV_ProcFreeSTRMRes(HANDLE hPCtxt)
 					    sizeof(u8 *)), MEM_NONPAGED);
 			status = STRM_FreeBuffer(pSTRMRes->hStream, apBuffer,
 						pSTRMRes->uNumBufs, pCtxt);
-			MEM_Free(apBuffer);
+			kfree(apBuffer);
 		}
 		status = STRM_Close(pSTRMRes->hStream, pCtxt);
 		if (DSP_FAILED(status)) {
@@ -509,7 +509,7 @@ DSP_STATUS	DRV_RemoveAllSTRMResElements(HANDLE hPCtxt)
 	while (pTempSTRMRes != NULL) {
 		pTempSTRMRes2 = pTempSTRMRes;
 		pTempSTRMRes = pTempSTRMRes->next;
-		MEM_Free(pTempSTRMRes2);
+		kfree(pTempSTRMRes2);
 	}
 	pCtxt->pSTRMList = NULL;
 	return status;
@@ -606,7 +606,7 @@ DSP_STATUS DRV_Create(OUT struct DRV_OBJECT **phDRVObject)
 		*phDRVObject = pDRVObject;
 	} else {
 		/* Free the DRV Object */
-		MEM_Free(pDRVObject);
+		kfree(pDRVObject);
 		GT_0trace(curTrace, GT_7CLASS,
 			 "Failed to update the Registry with "
 				 "DRV Object ");
@@ -658,11 +658,11 @@ DSP_STATUS DRV_Destroy(struct DRV_OBJECT *hDRVObject)
 	 */
 	if (pDRVObject->devList) {
 		/* Could assert if the list is not empty  */
-		MEM_Free(pDRVObject->devList);
+		kfree(pDRVObject->devList);
 	}
 	if (pDRVObject->devNodeString) {
 		/* Could assert if the list is not empty */
-		MEM_Free(pDRVObject->devNodeString);
+		kfree(pDRVObject->devNodeString);
 	}
 	MEM_FreeObject(pDRVObject);
 	/* Update the DRV Object in Registry to be 0 */
@@ -902,7 +902,7 @@ DSP_STATUS DRV_RemoveDevObject(struct DRV_OBJECT *hDRVObject,
 	}
 	/* Remove list if empty. */
 	if (LST_IsEmpty(pDRVObject->devList)) {
-		MEM_Free(pDRVObject->devList);
+		kfree(pDRVObject->devList);
 		pDRVObject->devList = NULL;
 	}
 	DBC_Ensure((pDRVObject->devList == NULL) ||
@@ -1018,12 +1018,12 @@ DSP_STATUS DRV_ReleaseResources(u32 dwContext, struct DRV_OBJECT *hDrvObject)
 			/* Delete from the Driver object list */
 			LST_RemoveElem(pDRVObject->devNodeString,
 				      (struct list_head *)pszdevNode);
-			MEM_Free((void *) pszdevNode);
+			kfree((void *) pszdevNode);
 			break;
 		}
 		/* Delete the List if it is empty */
 		if (LST_IsEmpty(pDRVObject->devNodeString)) {
-			MEM_Free(pDRVObject->devNodeString);
+			kfree(pDRVObject->devNodeString);
 			pDRVObject->devNodeString = NULL;
 		}
 	}
@@ -1125,7 +1125,7 @@ static DSP_STATUS RequestBridgeResources(u32 dwContext, s32 bRequest)
 			status = REG_SetValue(CURRENTCONFIG, (u8 *)pResources,
 				 (u32)dwBuffSize);
 			/*  Set all the other entries to NULL */
-			MEM_Free(pResources);
+			kfree(pResources);
 		} else {
 			status = DSP_EMEMORY;
 		}
@@ -1186,7 +1186,7 @@ static DSP_STATUS RequestBridgeResources(u32 dwContext, s32 bRequest)
 				 " Failed to set the registry "
 				 "value for CURRENTCONFIG\n");
 		}
-		MEM_Free(pResources);
+		kfree(pResources);
 	}
 	/* End Mem alloc */
 	return status;
@@ -1309,7 +1309,7 @@ static DSP_STATUS RequestBridgeResourcesDSP(u32 dwContext, s32 bRequest)
 					 " for CURRENTCONFIG\n");
 			}
 		}
-		MEM_Free(pResources);
+		kfree(pResources);
 	}
 	/* End Mem alloc */
 	return status;
diff --git a/drivers/dsp/bridge/rmgr/drv_interface.c b/drivers/dsp/bridge/rmgr/drv_interface.c
index 6fe6cbe..767c066 100644
--- a/drivers/dsp/bridge/rmgr/drv_interface.c
+++ b/drivers/dsp/bridge/rmgr/drv_interface.c
@@ -540,7 +540,7 @@ static int bridge_release(struct inode *ip, struct file *filp)
 	flush_signals(current);
 	DRV_RemoveAllResources(pr_ctxt);
 	PROC_Detach(pr_ctxt);
-	MEM_Free(pr_ctxt);
+	kfree(pr_ctxt);
 
 	filp->private_data = NULL;
 
diff --git a/drivers/dsp/bridge/rmgr/nldr.c b/drivers/dsp/bridge/rmgr/nldr.c
index bdf7622..8422a2b 100644
--- a/drivers/dsp/bridge/rmgr/nldr.c
+++ b/drivers/dsp/bridge/rmgr/nldr.c
@@ -589,11 +589,9 @@ DSP_STATUS NLDR_Create(OUT struct NLDR_OBJECT **phNldr,
 		pNldr->writeFxn = pAttrs->pfnWrite;
 		pNldr->dbllAttrs = newAttrs;
 	}
-	if (rmmSegs)
-		MEM_Free(rmmSegs);
+	kfree(rmmSegs);
 
-	if (pszCoffBuf)
-		MEM_Free(pszCoffBuf);
+	kfree(pszCoffBuf);
 
 	/* Get overlay nodes */
 	if (DSP_SUCCEEDED(status)) {
@@ -656,8 +654,7 @@ void NLDR_Delete(struct NLDR_OBJECT *hNldr)
 	if (hNldr->rmm)
 		RMM_delete(hNldr->rmm);
 
-	if (hNldr->segTable)
-		MEM_Free(hNldr->segTable);
+	kfree(hNldr->segTable);
 
 	if (hNldr->hDcdMgr)
 		DCD_DestroyManager(hNldr->hDcdMgr);
@@ -668,29 +665,29 @@ void NLDR_Delete(struct NLDR_OBJECT *hNldr)
 			pSect = hNldr->ovlyTable[i].pCreateSects;
 			while (pSect) {
 				pNext = pSect->pNextSect;
-				MEM_Free(pSect);
+				kfree(pSect);
 				pSect = pNext;
 			}
 			pSect = hNldr->ovlyTable[i].pDeleteSects;
 			while (pSect) {
 				pNext = pSect->pNextSect;
-				MEM_Free(pSect);
+				kfree(pSect);
 				pSect = pNext;
 			}
 			pSect = hNldr->ovlyTable[i].pExecuteSects;
 			while (pSect) {
 				pNext = pSect->pNextSect;
-				MEM_Free(pSect);
+				kfree(pSect);
 				pSect = pNext;
 			}
 			pSect = hNldr->ovlyTable[i].pOtherSects;
 			while (pSect) {
 				pNext = pSect->pNextSect;
-				MEM_Free(pSect);
+				kfree(pSect);
 				pSect = pNext;
 			}
 		}
-		MEM_Free(hNldr->ovlyTable);
+		kfree(hNldr->ovlyTable);
 	}
 	MEM_FreeObject(hNldr);
 	DBC_Ensure(!MEM_IsValidHandle(hNldr, NLDR_SIGNATURE));
@@ -1088,17 +1085,13 @@ static DSP_STATUS AddOvlyNode(struct DSP_UUID *pUuid,
 		}
 	}
 	/* These were allocated in DCD_GetObjectDef */
-	if (objDef.objData.nodeObj.pstrCreatePhaseFxn)
-		MEM_Free(objDef.objData.nodeObj.pstrCreatePhaseFxn);
+	kfree(objDef.objData.nodeObj.pstrCreatePhaseFxn);
 
-	if (objDef.objData.nodeObj.pstrExecutePhaseFxn)
-		MEM_Free(objDef.objData.nodeObj.pstrExecutePhaseFxn);
+	kfree(objDef.objData.nodeObj.pstrExecutePhaseFxn);
 
-	if (objDef.objData.nodeObj.pstrDeletePhaseFxn)
-		MEM_Free(objDef.objData.nodeObj.pstrDeletePhaseFxn);
+	kfree(objDef.objData.nodeObj.pstrDeletePhaseFxn);
 
-	if (objDef.objData.nodeObj.pstrIAlgName)
-		MEM_Free(objDef.objData.nodeObj.pstrIAlgName);
+	kfree(objDef.objData.nodeObj.pstrIAlgName);
 
 func_end:
 	return status;
@@ -1317,8 +1310,7 @@ static DSP_STATUS LoadLib(struct NLDR_NODEOBJECT *hNldrNode,
 			 DBLL_NOLOAD, &root->lib);
 	}
 	/* Done with file name */
-	if (pszFileName)
-		MEM_Free(pszFileName);
+	kfree(pszFileName);
 
 	/* Check to see if library not already loaded */
 	if (DSP_SUCCEEDED(status) && rootPersistent) {
@@ -1467,15 +1459,11 @@ static DSP_STATUS LoadLib(struct NLDR_NODEOBJECT *hNldrNode,
 	/* Going up one node in the dependency tree */
 	depth--;
 
-	if (depLibUUIDs) {
-		MEM_Free(depLibUUIDs);
-		depLibUUIDs = NULL;
-	}
+	kfree(depLibUUIDs);
+	depLibUUIDs = NULL;
 
-	if (persistentDepLibs) {
-		MEM_Free(persistentDepLibs);
-		persistentDepLibs = NULL;
-	}
+	kfree(persistentDepLibs);
+	persistentDepLibs = NULL;
 
 	return status;
 }
@@ -1796,10 +1784,8 @@ static void UnloadLib(struct NLDR_NODEOBJECT *hNldrNode, struct LibNode *root)
 	}
 
 	/* Free dependent library list */
-	if (root->pDepLibs) {
-		MEM_Free(root->pDepLibs);
-		root->pDepLibs = NULL;
-	}
+	kfree(root->pDepLibs);
+	root->pDepLibs = NULL;
 }
 
 /*
diff --git a/drivers/dsp/bridge/rmgr/node.c b/drivers/dsp/bridge/rmgr/node.c
index 6b33662..2cedbc7 100644
--- a/drivers/dsp/bridge/rmgr/node.c
+++ b/drivers/dsp/bridge/rmgr/node.c
@@ -1008,11 +1008,9 @@ DSP_STATUS NODE_Connect(struct NODE_OBJECT *hNode1, u32 uStream1,
 			if (pOutput->szDevice == NULL ||
 			   pInput->szDevice == NULL) {
 				/* Undo the connection */
-				if (pOutput->szDevice)
-					MEM_Free(pOutput->szDevice);
+				kfree(pOutput->szDevice);
 
-				if (pInput->szDevice)
-					MEM_Free(pInput->szDevice);
+				kfree(pInput->szDevice);
 
 				pOutput->szDevice = NULL;
 				pInput->szDevice = NULL;
@@ -2670,8 +2668,7 @@ static void DeleteNode(struct NODE_OBJECT *hNode,
 	nodeType = NODE_GetType(hNode);
 	if (nodeType != NODE_DEVICE) {
 		msgArgs = hNode->createArgs.asa.msgArgs;
-		if (msgArgs.pData)
-			MEM_Free(msgArgs.pData);
+		kfree(msgArgs.pData);
 
 		/* Free MSG queue */
 		if (hNode->hMsgQueue) {
@@ -2688,7 +2685,7 @@ static void DeleteNode(struct NODE_OBJECT *hNode,
 				stream = hNode->inputs[i];
 				FreeStream(hNodeMgr, stream);
 			}
-			MEM_Free(hNode->inputs);
+			kfree(hNode->inputs);
 			hNode->inputs = NULL;
 		}
 		if (hNode->outputs) {
@@ -2696,30 +2693,30 @@ static void DeleteNode(struct NODE_OBJECT *hNode,
 				stream = hNode->outputs[i];
 				FreeStream(hNodeMgr, stream);
 			}
-			MEM_Free(hNode->outputs);
+			kfree(hNode->outputs);
 			hNode->outputs = NULL;
 		}
 		taskArgs = hNode->createArgs.asa.taskArgs;
 		if (taskArgs.strmInDef) {
 			for (i = 0; i < MaxInputs(hNode); i++) {
 				if (taskArgs.strmInDef[i].szDevice) {
-					MEM_Free(taskArgs.strmInDef[i].
+					kfree(taskArgs.strmInDef[i].
 						szDevice);
 					taskArgs.strmInDef[i].szDevice = NULL;
 				}
 			}
-			MEM_Free(taskArgs.strmInDef);
+			kfree(taskArgs.strmInDef);
 			taskArgs.strmInDef = NULL;
 		}
 		if (taskArgs.strmOutDef) {
 			for (i = 0; i < MaxOutputs(hNode); i++) {
 				if (taskArgs.strmOutDef[i].szDevice) {
-					MEM_Free(taskArgs.strmOutDef[i].
+					kfree(taskArgs.strmOutDef[i].
 						szDevice);
 					taskArgs.strmOutDef[i].szDevice = NULL;
 				}
 			}
-			MEM_Free(taskArgs.strmOutDef);
+			kfree(taskArgs.strmOutDef);
 			taskArgs.strmOutDef = NULL;
 		}
 		if (taskArgs.uDSPHeapResAddr) {
@@ -2754,15 +2751,11 @@ static void DeleteNode(struct NODE_OBJECT *hNode,
 		}
 	}
 	if (nodeType != NODE_MESSAGE) {
-		if (hNode->streamConnect) {
-			MEM_Free(hNode->streamConnect);
-			hNode->streamConnect = NULL;
-		}
-	}
-	if (hNode->pstrDevName) {
-		MEM_Free(hNode->pstrDevName);
-		hNode->pstrDevName = NULL;
+		kfree(hNode->streamConnect);
+		hNode->streamConnect = NULL;
 	}
+	kfree(hNode->pstrDevName);
+	hNode->pstrDevName = NULL;
 
 	if (hNode->hNtfy) {
 		NTFY_Delete(hNode->hNtfy);
@@ -2770,25 +2763,17 @@ static void DeleteNode(struct NODE_OBJECT *hNode,
 	}
 
 	/* These were allocated in DCD_GetObjectDef (via NODE_Allocate) */
-	if (hNode->dcdProps.objData.nodeObj.pstrCreatePhaseFxn) {
-		MEM_Free(hNode->dcdProps.objData.nodeObj.pstrCreatePhaseFxn);
-		hNode->dcdProps.objData.nodeObj.pstrCreatePhaseFxn = NULL;
-	}
+	kfree(hNode->dcdProps.objData.nodeObj.pstrCreatePhaseFxn);
+	hNode->dcdProps.objData.nodeObj.pstrCreatePhaseFxn = NULL;
 
-	if (hNode->dcdProps.objData.nodeObj.pstrExecutePhaseFxn) {
-		MEM_Free(hNode->dcdProps.objData.nodeObj.pstrExecutePhaseFxn);
-		hNode->dcdProps.objData.nodeObj.pstrExecutePhaseFxn = NULL;
-	}
+	kfree(hNode->dcdProps.objData.nodeObj.pstrExecutePhaseFxn);
+	hNode->dcdProps.objData.nodeObj.pstrExecutePhaseFxn = NULL;
 
-	if (hNode->dcdProps.objData.nodeObj.pstrDeletePhaseFxn) {
-		MEM_Free(hNode->dcdProps.objData.nodeObj.pstrDeletePhaseFxn);
-		hNode->dcdProps.objData.nodeObj.pstrDeletePhaseFxn = NULL;
-	}
+	kfree(hNode->dcdProps.objData.nodeObj.pstrDeletePhaseFxn);
+	hNode->dcdProps.objData.nodeObj.pstrDeletePhaseFxn = NULL;
 
-	if (hNode->dcdProps.objData.nodeObj.pstrIAlgName) {
-		MEM_Free(hNode->dcdProps.objData.nodeObj.pstrIAlgName);
-		hNode->dcdProps.objData.nodeObj.pstrIAlgName = NULL;
-	}
+	kfree(hNode->dcdProps.objData.nodeObj.pstrIAlgName);
+	hNode->dcdProps.objData.nodeObj.pstrIAlgName = NULL;
 
 	/* Free all SM address translator resources */
 	if (hXlator) {
@@ -2796,10 +2781,8 @@ static void DeleteNode(struct NODE_OBJECT *hNode,
 		hXlator = NULL;
 	}
 
-	if (hNode->hNldrNode) {
-		MEM_Free(hNode->hNldrNode);
-		hNode->hNldrNode = NULL;
-	}
+	kfree(hNode->hNldrNode);
+	hNode->hNldrNode = NULL;
 	hNode->hNodeMgr = NULL;
 	MEM_FreeObject(hNode);
 	hNode = NULL;
@@ -2829,7 +2812,7 @@ static void DeleteNodeMgr(struct NODE_MGR *hNodeMgr)
 					DeleteNode(hNode, NULL);
 
 			DBC_Assert(LST_IsEmpty(hNodeMgr->nodeList));
-			MEM_Free(hNodeMgr->nodeList);
+			kfree(hNodeMgr->nodeList);
 		}
 		if (hNodeMgr->hNtfy)
 			NTFY_Delete(hNodeMgr->hNtfy);
@@ -3253,17 +3236,13 @@ DSP_STATUS NODE_GetUUIDProps(DSP_HPROCESSOR hProcessor,
 				(struct DCD_GENERICOBJ *) &dcdNodeProps);
 		if (DSP_SUCCEEDED(status)) {
 			*pNodeProps = dcdNodeProps.ndbProps;
-			if (dcdNodeProps.pstrCreatePhaseFxn)
-				MEM_Free(dcdNodeProps.pstrCreatePhaseFxn);
+			kfree(dcdNodeProps.pstrCreatePhaseFxn);
 
-			if (dcdNodeProps.pstrExecutePhaseFxn)
-				MEM_Free(dcdNodeProps.pstrExecutePhaseFxn);
+			kfree(dcdNodeProps.pstrExecutePhaseFxn);
 
-			if (dcdNodeProps.pstrDeletePhaseFxn)
-				MEM_Free(dcdNodeProps.pstrDeletePhaseFxn);
+			kfree(dcdNodeProps.pstrDeletePhaseFxn);
 
-			if (dcdNodeProps.pstrIAlgName)
-				MEM_Free(dcdNodeProps.pstrIAlgName);
+			kfree(dcdNodeProps.pstrIAlgName);
 		}
 		/*  Leave the critical section, we're done.  */
 		(void)SYNC_LeaveCS(hNodeMgr->hSync);
diff --git a/drivers/dsp/bridge/rmgr/proc.c b/drivers/dsp/bridge/rmgr/proc.c
index e50eb52..9c3ace7 100644
--- a/drivers/dsp/bridge/rmgr/proc.c
+++ b/drivers/dsp/bridge/rmgr/proc.c
@@ -503,10 +503,9 @@ DSP_STATUS PROC_Detach(struct PROCESS_CONTEXT *pr_ctxt)
 		if (pProcObject->hNtfy)
 			NTFY_Delete(pProcObject->hNtfy);
 
-		if (pProcObject->g_pszLastCoff) {
-			MEM_Free(pProcObject->g_pszLastCoff);
-			pProcObject->g_pszLastCoff = NULL;
-		}
+		kfree(pProcObject->g_pszLastCoff);
+		pProcObject->g_pszLastCoff = NULL;
+
 		/* Remove the Proc from the DEV List */
 		(void)DEV_RemoveProcObject(pProcObject->hDevObject,
 			(u32)pProcObject);
@@ -1071,7 +1070,7 @@ DSP_STATUS PROC_Load(DSP_HPROCESSOR hProcessor, IN CONST s32 iArgc,
 					/* Regardless of auto unregister status,
 					 *  free previously allocated
 					 *  memory.  */
-					MEM_Free(pProcObject->g_pszLastCoff);
+					kfree(pProcObject->g_pszLastCoff);
 					pProcObject->g_pszLastCoff = NULL;
 				}
 			}
@@ -1233,7 +1232,7 @@ DSP_STATUS PROC_Load(DSP_HPROCESSOR hProcessor, IN CONST s32 iArgc,
 		}
 	}
 	/* Restore the original argv[0] */
-	MEM_Free(newEnvp);
+	kfree(newEnvp);
 	aArgv[0] = pargv0;
 #ifdef CONFIG_BRIDGE_DEBUG
 	if (DSP_SUCCEEDED(status)) {
diff --git a/drivers/dsp/bridge/rmgr/rmm.c b/drivers/dsp/bridge/rmgr/rmm.c
index 5c484bc..b4c5fa2 100644
--- a/drivers/dsp/bridge/rmgr/rmm.c
+++ b/drivers/dsp/bridge/rmgr/rmm.c
@@ -296,15 +296,15 @@ void RMM_delete(struct RMM_TargetObj *target)
 	GT_1trace(RMM_debugMask, GT_ENTER, "RMM_delete(0x%lx)\n", target);
 
 	if (target->segTab != NULL)
-		MEM_Free(target->segTab);
+		kfree(target->segTab);
 
 	if (target->ovlyList) {
 		while ((pSect = (struct RMM_OvlySect *)LST_GetHead
 		      (target->ovlyList))) {
-			MEM_Free(pSect);
+			kfree(pSect);
 		}
 		DBC_Assert(LST_IsEmpty(target->ovlyList));
-		MEM_Free(target->ovlyList);
+		kfree(target->ovlyList);
 	}
 
 	if (target->freeList != NULL) {
@@ -314,10 +314,10 @@ void RMM_delete(struct RMM_TargetObj *target)
 			while (next) {
 				hptr = next;
 				next = hptr->next;
-				MEM_Free(hptr);
+				kfree(hptr);
 			}
 		}
-		MEM_Free(target->freeList);
+		kfree(target->freeList);
 	}
 
 	MEM_FreeObject(target);
@@ -375,7 +375,7 @@ bool RMM_free(struct RMM_TargetObj *target, u32 segid, u32 addr, u32 size,
 				/* Remove from list */
 				LST_RemoveElem(target->ovlyList,
 					      (struct list_head *)sect);
-				MEM_Free(sect);
+				kfree(sect);
 				break;
 			}
 			sect = (struct RMM_OvlySect *)LST_Next(target->ovlyList,
@@ -494,7 +494,7 @@ static bool allocBlock(struct RMM_TargetObj *target, u32 segid, u32 size,
 		if (hsize >= allocsize) {	/* big enough */
 			if (hsize == allocsize && prevhead != NULL) {
 				prevhead->next = next;
-				MEM_Free(head);
+				kfree(head);
 			} else {
 				head->size = hsize - allocsize;
 				head->addr += allocsize;
@@ -563,7 +563,7 @@ static bool freeBlock(struct RMM_TargetObj *target, u32 segid, u32 addr,
 			head->next = rhead->next;
 			thead->size = size + thead->size;
 			thead->addr = addr;
-			MEM_Free(rhead);
+			kfree(rhead);
 			rhead = thead;
 		}
 
@@ -571,7 +571,7 @@ static bool freeBlock(struct RMM_TargetObj *target, u32 segid, u32 addr,
 		if ((head->addr + head->size) == rhead->addr) {
 			head->next = rhead->next;
 			head->size = head->size + rhead->size;
-			MEM_Free(rhead);
+			kfree(rhead);
 		}
 	}
 
diff --git a/drivers/dsp/bridge/rmgr/strm.c b/drivers/dsp/bridge/rmgr/strm.c
index 6be8083..1b24f08 100644
--- a/drivers/dsp/bridge/rmgr/strm.c
+++ b/drivers/dsp/bridge/rmgr/strm.c
@@ -873,8 +873,7 @@ DSP_STATUS STRM_Select(IN struct STRM_OBJECT **aStrmTab, u32 nStrms,
 		}
 	}
 func_end:
-	if (hSyncEvents)
-		MEM_Free(hSyncEvents);
+	kfree(hSyncEvents);
 
 	DBC_Ensure((DSP_SUCCEEDED(status) && (*pMask != 0 || uTimeout == 0)) ||
 		  (DSP_FAILED(status) && *pMask == 0));
diff --git a/drivers/dsp/bridge/services/mem.c b/drivers/dsp/bridge/services/mem.c
index c4b1fe1..614396e 100644
--- a/drivers/dsp/bridge/services/mem.c
+++ b/drivers/dsp/bridge/services/mem.c
@@ -309,23 +309,6 @@ void MEM_VFree(IN void *pMemBuf)
 }
 
 /*
- *  ======== MEM_Free ========
- *  Purpose:
- *      Free the given block of system memory.
- */
-void MEM_Free(IN void *pMemBuf)
-{
-	DBC_Require(pMemBuf != NULL);
-
-	GT_1trace(MEM_debugMask, GT_ENTER, "MEM_Free: pMemBufs 0x%x\n",
-		  pMemBuf);
-
-	if (pMemBuf) {
-		kfree(pMemBuf);
-	}
-}
-
-/*
  *  ======== MEM_FreePhysMem ========
  *  Purpose:
  *      Free the given block of physically contiguous memory.
diff --git a/drivers/dsp/bridge/services/ntfy.c b/drivers/dsp/bridge/services/ntfy.c
index 539cbae..53a6974 100644
--- a/drivers/dsp/bridge/services/ntfy.c
+++ b/drivers/dsp/bridge/services/ntfy.c
@@ -133,7 +133,7 @@ void NTFY_Delete(struct NTFY_OBJECT *hNtfy)
 			DeleteNotify(pNotify);
 		}
 		DBC_Assert(LST_IsEmpty(hNtfy->notifyList));
-		MEM_Free(hNtfy->notifyList);
+		kfree(hNtfy->notifyList);
 	}
 	if (hNtfy->hSync)
 		(void)SYNC_DeleteCS(hNtfy->hSync);
@@ -299,9 +299,8 @@ static void DeleteNotify(struct NOTIFICATION *pNotify)
 	if (pNotify->hSync)
 		(void) SYNC_CloseEvent(pNotify->hSync);
 
-	if (pNotify->pstrName)
-		MEM_Free(pNotify->pstrName);
+	kfree(pNotify->pstrName);
 
-	MEM_Free(pNotify);
+	kfree(pNotify);
 }
 
diff --git a/drivers/dsp/bridge/services/regsup.c b/drivers/dsp/bridge/services/regsup.c
index 19700a4..0c77fb2 100644
--- a/drivers/dsp/bridge/services/regsup.c
+++ b/drivers/dsp/bridge/services/regsup.c
@@ -72,8 +72,8 @@ void regsupExit(void)
 	while (!LST_IsEmpty(pRegKey)) {
 		rv = (struct RegValue *) LST_GetHead(pRegKey);
 
-		MEM_Free(rv->pData);
-		MEM_Free(rv);
+		kfree(rv->pData);
+		kfree(rv);
 	}
 }
 
@@ -135,7 +135,7 @@ DSP_STATUS regsupSetValue(char *valName, void *pBuf, u32 dataSize)
 			/*  Make sure the new data size is the same.  */
 			if (dataSize != rv->dataSize) {
 				/*  The caller needs a different data size!  */
-				MEM_Free(rv->pData);
+				kfree(rv->pData);
 				rv->pData = MEM_Alloc(dataSize, MEM_NONPAGED);
 				if (rv->pData == NULL)
 					break;
@@ -238,8 +238,8 @@ DSP_STATUS regsupDeleteValue(IN CONST char *pstrValue)
 			 * key.
 			 */
 			LST_RemoveElem(pRegKey, (struct list_head *)rv);
-			MEM_Free(rv->pData);
-			MEM_Free(rv);
+			kfree(rv->pData);
+			kfree(rv);
 
 			/*  Set our status to good and exit...  */
 			retVal = DSP_SOK;
diff --git a/drivers/dsp/bridge/services/sync.c b/drivers/dsp/bridge/services/sync.c
index 8ff35f2..7fb5553 100644
--- a/drivers/dsp/bridge/services/sync.c
+++ b/drivers/dsp/bridge/services/sync.c
@@ -375,8 +375,7 @@ DSP_STATUS SYNC_WaitOnMultipleEvents(struct SYNC_OBJECT **hSyncEvents,
 			  "SYNC:Signaling Event NULL!!!(:-\n");
 		status = DSP_ETIMEOUT;
 	}
-	if (Wp)
-		MEM_Free(Wp);
+	kfree(Wp);
 	return status;
 }
 
diff --git a/drivers/dsp/bridge/wmd/chnl_sm.c b/drivers/dsp/bridge/wmd/chnl_sm.c
index b64e7c0..585c004 100644
--- a/drivers/dsp/bridge/wmd/chnl_sm.c
+++ b/drivers/dsp/bridge/wmd/chnl_sm.c
@@ -159,7 +159,7 @@ DSP_STATUS WMD_CHNL_AddIOReq(struct CHNL_OBJECT *hChnl, void *pHostBuf,
 					 "Error copying user buffer to "
 					 "kernel, %d bytes remaining.\n",
 					 status);
-				MEM_Free(pHostSysBuf);
+				kfree(pHostSysBuf);
 				pHostSysBuf = NULL;
 				status = DSP_EPOINTER;
 				goto func_end;
@@ -466,8 +466,7 @@ DSP_STATUS WMD_CHNL_Destroy(struct CHNL_MGR *hChnlMgr)
 			SYNC_DeleteCS(pChnlMgr->hCSObj);
 
 		/* Free channel manager object: */
-		if (pChnlMgr->apChannel)
-			MEM_Free(pChnlMgr->apChannel);
+		kfree(pChnlMgr->apChannel);
 
 		/* Set hChnlMgr to NULL in device object. */
 		DEV_SetChnlMgr(pChnlMgr->hDevObject, NULL);
@@ -711,7 +710,7 @@ DSP_STATUS WMD_CHNL_GetIOC(struct CHNL_OBJECT *hChnl, u32 dwTimeOut,
 			status = DSP_EPOINTER;
 		}
 func_cont1:
-		MEM_Free(pHostSysBuf);
+		kfree(pHostSysBuf);
 	}
 func_cont:
 	/* Update User's IOC block: */
@@ -970,9 +969,9 @@ static void FreeChirpList(struct LST_LIST *pChirpList)
 	DBC_Require(pChirpList != NULL);
 
 	while (!LST_IsEmpty(pChirpList))
-		MEM_Free(LST_GetHead(pChirpList));
+		kfree(LST_GetHead(pChirpList));
 
-	MEM_Free(pChirpList);
+	kfree(pChirpList);
 }
 
 /*
diff --git a/drivers/dsp/bridge/wmd/io_sm.c b/drivers/dsp/bridge/wmd/io_sm.c
index 39b37a6..a25cfd6 100644
--- a/drivers/dsp/bridge/wmd/io_sm.c
+++ b/drivers/dsp/bridge/wmd/io_sm.c
@@ -323,8 +323,7 @@ DSP_STATUS WMD_IO_Destroy(struct IO_MGR *hIOMgr)
 		DBG_Trace(GT_2CLASS, "DPC_Destroy: SUCCESS\n");
 
 #ifndef DSP_TRACEBUF_DISABLED
-		if (hIOMgr->pMsg)
-			MEM_Free(hIOMgr->pMsg);
+		kfree(hIOMgr->pMsg);
 #endif
 		SYNC_DeleteCS(hIOMgr->hCSObj); 	/* Leak Fix. */
 		/* Free this IO manager object */
@@ -816,8 +815,7 @@ DSP_STATUS WMD_IO_OnLoaded(struct IO_MGR *hIOMgr)
 	hIOMgr->ulTraceBufferCurrent = (ulGppVa + ulSeg1Size + ulPadSize) +
 				(hIOMgr->ulTraceBufferCurrent - ulDspVa);
 	/* Calculate the size of trace buffer */
-	if (hIOMgr->pMsg)
-		MEM_Free(hIOMgr->pMsg);
+	kfree(hIOMgr->pMsg);
 	hIOMgr->pMsg = MEM_Alloc(((hIOMgr->ulTraceBufferEnd -
 				hIOMgr->ulTraceBufferBegin) *
 				hIOMgr->uWordSize) + 2, MEM_NONPAGED);
@@ -1994,7 +1992,7 @@ static DSP_STATUS PackTraceBuffer(char *lpBuf, u32 nBytes, u32 ulNumWords)
 		strncpy(lpBufStart, lpTmpStart, nBytes);
 		/* Make sure output is null terminated */
 		lpBufStart[nBytes - 1] = '\0';
-		MEM_Free(lpTmpStart);
+		kfree(lpTmpStart);
 	}
 
 	return status;
@@ -2101,8 +2099,8 @@ DSP_STATUS PrintDspTraceBuffer(struct WMD_DEV_CONTEXT *hWmdContext)
 				GT_1trace(dsp_trace_mask, GT_1CLASS,
 					"DSP Trace Buffer:\n%s\n", pszBuf);
 			}
-			MEM_Free(pszBuf);
-			MEM_Free(lpszBuf);
+			kfree(pszBuf);
+			kfree(lpszBuf);
 		} else {
 			  GT_0trace(dsp_trace_mask, GT_2CLASS,
 				"PrintDspTraceBuffer: Failed to "
diff --git a/drivers/dsp/bridge/wmd/msg_sm.c b/drivers/dsp/bridge/wmd/msg_sm.c
index 50201e5..e9e47bf 100644
--- a/drivers/dsp/bridge/wmd/msg_sm.c
+++ b/drivers/dsp/bridge/wmd/msg_sm.c
@@ -559,7 +559,7 @@ static void DeleteMsgMgr(struct MSG_MGR *hMsgMgr)
 
 	if (hMsgMgr->queueList) {
 		if (LST_IsEmpty(hMsgMgr->queueList)) {
-			MEM_Free(hMsgMgr->queueList);
+			kfree(hMsgMgr->queueList);
 			hMsgMgr->queueList = NULL;
 		}
 	}
@@ -606,7 +606,7 @@ static void DeleteMsgQueue(struct MSG_QUEUE *hMsgQueue, u32 uNumToDSP)
 		if (!LST_IsEmpty(hMsgMgr->msgFreeList)) {
 			pMsg = (struct MSG_FRAME *)LST_GetHead(hMsgMgr->
 				msgFreeList);
-			MEM_Free(pMsg);
+			kfree(pMsg);
 		} else {
 			/* Cannot free all of the message frames */
 			break;
@@ -653,11 +653,11 @@ static void FreeMsgList(struct LST_LIST *msgList)
 		goto func_end;
 
 	while ((pMsg = (struct MSG_FRAME *)LST_GetHead(msgList)) != NULL)
-		MEM_Free(pMsg);
+		kfree(pMsg);
 
 	DBC_Assert(LST_IsEmpty(msgList));
 
-	MEM_Free(msgList);
+	kfree(msgList);
 func_end:
 	return;
 }
diff --git a/drivers/dsp/bridge/wmd/tiomap3430.c b/drivers/dsp/bridge/wmd/tiomap3430.c
index 2411917..7c1f59a 100644
--- a/drivers/dsp/bridge/wmd/tiomap3430.c
+++ b/drivers/dsp/bridge/wmd/tiomap3430.c
@@ -1142,8 +1142,7 @@ static DSP_STATUS WMD_DEV_Create(OUT struct WMD_DEV_CONTEXT **ppDevContext,
 			if (pPtAttrs->hCSObj)
 				SYNC_DeleteCS(pPtAttrs->hCSObj);
 
-			if (pPtAttrs->pgInfo)
-				MEM_Free(pPtAttrs->pgInfo);
+			kfree(pPtAttrs->pgInfo);
 
 			if (pPtAttrs->L2TblAllocVa) {
 				MEM_FreePhysMem((void *)pPtAttrs->L2TblAllocVa,
@@ -1156,11 +1155,9 @@ static DSP_STATUS WMD_DEV_Create(OUT struct WMD_DEV_CONTEXT **ppDevContext,
 						pPtAttrs->L1TblAllocSz);
 			}
 		}
-		if (pPtAttrs)
-			MEM_Free(pPtAttrs);
+		kfree(pPtAttrs);
 
-		if (pDevContext)
-			MEM_Free(pDevContext);
+		kfree(pDevContext);
 
 		DBG_Trace(DBG_LEVEL7,
 			 "WMD_DEV_Create Error Device  not created\n");
@@ -1257,8 +1254,7 @@ static DSP_STATUS WMD_DEV_Destroy(struct WMD_DEV_CONTEXT *hDevContext)
 		if (pPtAttrs->hCSObj)
 			SYNC_DeleteCS(pPtAttrs->hCSObj);
 
-		if (pPtAttrs->pgInfo)
-			MEM_Free(pPtAttrs->pgInfo);
+		kfree(pPtAttrs->pgInfo);
 
 		if (pPtAttrs->L2TblAllocVa) {
 			MEM_FreePhysMem((void *)pPtAttrs->L2TblAllocVa,
@@ -1270,12 +1266,11 @@ static DSP_STATUS WMD_DEV_Destroy(struct WMD_DEV_CONTEXT *hDevContext)
 					pPtAttrs->L1TblAllocPa, pPtAttrs->
 					L1TblAllocSz);
 		}
-		if (pPtAttrs)
-			MEM_Free(pPtAttrs);
+		kfree(pPtAttrs);
 
 	}
 	/* Free the driver's device context: */
-	MEM_Free((void *) hDevContext);
+	kfree((void *) hDevContext);
 	return status;
 }
 
diff --git a/drivers/dsp/bridge/wmd/ue_deh.c b/drivers/dsp/bridge/wmd/ue_deh.c
index 2c3a2cd..78a4860 100644
--- a/drivers/dsp/bridge/wmd/ue_deh.c
+++ b/drivers/dsp/bridge/wmd/ue_deh.c
@@ -339,7 +339,7 @@ DSP_STATUS WMD_DEH_GetInfo(struct DEH_MGR *hDehMgr,
 void WMD_DEH_ReleaseDummyMem(void)
 {
 	if (dummyVaAddr) {
-		MEM_Free((void *)dummyVaAddr);
+		kfree((void *)dummyVaAddr);
 		dummyVaAddr = 0;
 	}
 }
-- 
1.6.3.3


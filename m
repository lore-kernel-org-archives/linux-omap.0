From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 04/12] DSPBRIDGE: Change custom GT_trace for dev_dbg in pmgr
Date: Thu, 18 Feb 2010 15:37:55 -0600
Message-ID: <1266529083-2358-5-git-send-email-omar.ramirez@ti.com>
References: <1266529083-2358-1-git-send-email-omar.ramirez@ti.com>
 <1266529083-2358-2-git-send-email-omar.ramirez@ti.com>
 <1266529083-2358-3-git-send-email-omar.ramirez@ti.com>
 <1266529083-2358-4-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:54599 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755369Ab0BRVZ2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Feb 2010 16:25:28 -0500
In-Reply-To: <1266529083-2358-4-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Ameya Palande <ameya.palande@nokia.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, Nishanth Menon <nm@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>

Remove GT_Trace custom debugging mechanism and use dev_dbg.

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 drivers/dsp/bridge/pmgr/cmm.c  |    9 +++---
 drivers/dsp/bridge/pmgr/cod.c  |    5 +--
 drivers/dsp/bridge/pmgr/dbll.c |   59 +++++++++++++++++++---------------------
 drivers/dsp/bridge/pmgr/dmm.c  |   47 +++++++++++++-------------------
 drivers/dsp/bridge/pmgr/msg.c  |    4 +-
 5 files changed, 55 insertions(+), 69 deletions(-)

diff --git a/drivers/dsp/bridge/pmgr/cmm.c b/drivers/dsp/bridge/pmgr/cmm.c
index 56f97a7..b30b724 100644
--- a/drivers/dsp/bridge/pmgr/cmm.c
+++ b/drivers/dsp/bridge/pmgr/cmm.c
@@ -562,11 +562,10 @@ DSP_STATUS CMM_RegisterGPPSMSeg(struct CMM_OBJECT *hCmmMgr, u32 dwGPPBasePA,
 	DBC_Require(dwGPPBaseVA != 0);
 	DBC_Require((cFactor <= CMM_ADDTODSPPA) &&
 		   (cFactor >= CMM_SUBFROMDSPPA));
-	GT_6trace(CMM_debugMask, GT_ENTER,
-		  "CMM_RegisterGPPSMSeg dwGPPBasePA %x "
-		  "ulSize %x dwDSPAddrOffset %x dwDSPBase %x ulDSPSize %x "
-		  "dwGPPBaseVA %x\n", dwGPPBasePA, ulSize, dwDSPAddrOffset,
-		  dwDSPBase, ulDSPSize, dwGPPBaseVA);
+	dev_dbg(bridge, "%s: dwGPPBasePA %x ulSize %x dwDSPAddrOffset %x "
+			"dwDSPBase %x ulDSPSize %x dwGPPBaseVA %x\n", __func__,
+			dwGPPBasePA, ulSize, dwDSPAddrOffset, dwDSPBase,
+			ulDSPSize, dwGPPBaseVA);
 	if (!MEM_IsValidHandle(hCmmMgr, CMMSIGNATURE)) {
 		status = DSP_EHANDLE;
 		return status;
diff --git a/drivers/dsp/bridge/pmgr/cod.c b/drivers/dsp/bridge/pmgr/cod.c
index 541503c..62629e1 100644
--- a/drivers/dsp/bridge/pmgr/cod.c
+++ b/drivers/dsp/bridge/pmgr/cod.c
@@ -449,9 +449,8 @@ DSP_STATUS COD_GetSymValue(struct COD_MANAGER *hMgr, char *pstrSym,
 	DBC_Require(pstrSym != NULL);
 	DBC_Require(pulValue != NULL);
 
-	GT_3trace(COD_debugMask, GT_ENTER, "Entered COD_GetSymValue Args \t\n"
-		  "hMgr: 0x%x\t\npstrSym: 0x%x\t\npulValue: 0x%x\n",
-		  hMgr, pstrSym, pulValue);
+	dev_dbg(bridge, "%s: hMgr: %p pstrSym: %s pulValue: %p\n",
+					__func__, hMgr, pstrSym, pulValue);
 	if (hMgr->baseLib) {
 		if (!hMgr->fxns.getAddrFxn(hMgr->baseLib, pstrSym, &pSym)) {
 			if (!hMgr->fxns.getCAddrFxn(hMgr->baseLib, pstrSym,
diff --git a/drivers/dsp/bridge/pmgr/dbll.c b/drivers/dsp/bridge/pmgr/dbll.c
index 9b31f41..86832a3 100644
--- a/drivers/dsp/bridge/pmgr/dbll.c
+++ b/drivers/dsp/bridge/pmgr/dbll.c
@@ -328,14 +328,14 @@ bool DBLL_getAddr(struct DBLL_LibraryObj *zlLib, char *name,
 	DBC_Require(ppSym != NULL);
 	DBC_Require(zlLib->symTab != NULL);
 
-	GT_3trace(DBLL_debugMask, GT_ENTER,
-		 "DBLL_getAddr: lib: 0x%x name: %s pAddr:"
-		 " 0x%x\n", zlLib, name, ppSym);
 	sym = (struct Symbol *)GH_find(zlLib->symTab, name);
 	if (sym != NULL) {
 		*ppSym = &sym->value;
 		status = true;
 	}
+
+	dev_dbg(bridge, "%s: lib: %p name: %s pAddr: %p, status 0x%x\n",
+					 __func__, zlLib, name, ppSym, status);
 	return status;
 }
 
@@ -408,9 +408,6 @@ DSP_STATUS DBLL_getSect(struct DBLL_LibraryObj *lib, char *name, u32 *pAddr,
 	DBC_Require(pSize != NULL);
 	DBC_Require(MEM_IsValidHandle(zlLib, DBLL_LIBSIGNATURE));
 
-	GT_4trace(DBLL_debugMask, GT_ENTER,
-		 "DBLL_getSect: lib: 0x%x name: %s pAddr:"
-		 " 0x%x pSize: 0x%x\n", lib, name, pAddr, pSize);
 	/* If DOFF file is not open, we open it. */
 	if (zlLib != NULL) {
 		if (zlLib->fp == NULL) {
@@ -445,6 +442,9 @@ DSP_STATUS DBLL_getSect(struct DBLL_LibraryObj *lib, char *name, u32 *pAddr,
 		fOpenedDoff = false;
 	}
 
+	dev_dbg(bridge, "%s: lib: %p name: %s pAddr: %p pSize: %p, "
+		"status 0x%x\n", __func__, lib, name, pAddr, pSize, status);
+
 	return status;
 }
 
@@ -483,9 +483,6 @@ DSP_STATUS DBLL_load(struct DBLL_LibraryObj *lib, DBLL_Flags flags,
 	DBC_Require(pEntry != NULL);
 	DBC_Require(attrs != NULL);
 
-	GT_4trace(DBLL_debugMask, GT_ENTER,
-		 "DBLL_load: lib: 0x%x flags: 0x%x pEntry:"
-		 " 0x%x\n", lib, flags, attrs, pEntry);
 	/*
 	 *  Load if not already loaded.
 	 */
@@ -579,6 +576,10 @@ DSP_STATUS DBLL_load(struct DBLL_LibraryObj *lib, DBLL_Flags flags,
 		dofClose(zlLib);
 
 	DBC_Ensure(DSP_FAILED(status) || zlLib->loadRef > 0);
+
+	dev_dbg(bridge, "%s: lib: %p flags: 0x%x pEntry: %p, status 0x%x\n",
+			__func__, lib, flags, pEntry, status);
+
 	return status;
 }
 
@@ -611,9 +612,6 @@ DSP_STATUS DBLL_open(struct DBLL_TarObj *target, char *file, DBLL_Flags flags,
 	DBC_Require(file != NULL);
 	DBC_Require(pLib != NULL);
 
-	GT_3trace(DBLL_debugMask, GT_ENTER,
-		 "DBLL_open: target: 0x%x file: %s pLib:"
-		 " 0x%x\n", target, file, pLib);
 	zlLib = zlTarget->head;
 	while (zlLib != NULL) {
 		if (strcmp(zlLib->fileName, file) == 0) {
@@ -733,6 +731,10 @@ func_cont:
 	DBC_Ensure((DSP_SUCCEEDED(status) && (zlLib->openRef > 0) &&
 		  MEM_IsValidHandle(((struct DBLL_LibraryObj *)(*pLib)),
 		  DBLL_LIBSIGNATURE)) || (DSP_FAILED(status) && *pLib == NULL));
+
+	dev_dbg(bridge, "%s: target: %p file: %s pLib: %p, status 0x%x\n",
+					 __func__, target, file, pLib, status);
+
 	return status;
 }
 
@@ -756,9 +758,6 @@ DSP_STATUS DBLL_readSect(struct DBLL_LibraryObj *lib, char *name,
 	DBC_Require(pContent != NULL);
 	DBC_Require(size != 0);
 
-	GT_4trace(DBLL_debugMask, GT_ENTER,
-		 "DBLL_readSect: lib: 0x%x name: %s "
-		 "pContent: 0x%x size: 0x%x\n", lib, name, pContent, size);
 	/* If DOFF file is not open, we open it. */
 	if (zlLib != NULL) {
 		if (zlLib->fp == NULL) {
@@ -804,6 +803,9 @@ func_cont:
 		dofClose(zlLib);
 		fOpenedDoff = false;
 	}
+
+	dev_dbg(bridge, "%s: lib: %p name: %s pContent: %p size: 0x%x, "
+		"status 0x%x\n", __func__, lib, name, pContent, size, status);
 	return status;
 }
 
@@ -834,7 +836,7 @@ void DBLL_unload(struct DBLL_LibraryObj *lib, struct DBLL_Attrs *attrs)
 	DBC_Require(cRefs > 0);
 	DBC_Require(MEM_IsValidHandle(zlLib, DBLL_LIBSIGNATURE));
 	DBC_Require(zlLib->loadRef > 0);
-	GT_1trace(DBLL_debugMask, GT_ENTER, "DBLL_unload: lib: 0x%x\n", lib);
+	dev_dbg(bridge, "%s: lib: %p\n", __func__, lib);
 	zlLib->loadRef--;
 	/* Unload only if reference count is 0 */
 	if (zlLib->loadRef != 0)
@@ -846,8 +848,7 @@ void DBLL_unload(struct DBLL_LibraryObj *lib, struct DBLL_Attrs *attrs)
 			&zlLib->symbol.dlSymbol,
 			&zlLib->allocate.dlAlloc, &zlLib->init.dlInit);
 		if (err != 0) {
-			GT_1trace(DBLL_debugMask, GT_5CLASS,
-				 "Dynamic_Unload_Module failed: 0x%x\n", err);
+			dev_dbg(bridge, "%s: failed: 0x%x\n", __func__, err);
 		}
 	}
 	/* remove symbols from symbol table */
@@ -1062,8 +1063,7 @@ static struct dynload_symbol *findSymbol(struct Dynamic_Loader_Sym *this,
 	}
 
 	if (!status && bGblSearch) {
-		GT_1trace(DBLL_debugMask, GT_6CLASS,
-			 "findSymbol: Symbol not found: %s\n", name);
+		dev_dbg(bridge, "%s: Symbol not found: %s\n", __func__, name);
 	}
 
 	DBC_Assert((status && (pSym != NULL)) || (!status && (pSym == NULL)));
@@ -1121,9 +1121,8 @@ static struct dynload_symbol *addToSymbolTable(struct Dynamic_Loader_Sym *this,
 		bGblSearch = true;
 		if (pSym) {
 			bRedefinedSymbol = true;
-			GT_1trace(DBLL_debugMask, GT_6CLASS,
-				 "Symbol already defined in "
-				 "symbol table: %s\n", name);
+			dev_dbg(bridge, "%s already defined in symbol table\n",
+									name);
 			return NULL;
 		}
 	}
@@ -1215,7 +1214,7 @@ static void errorReport(struct Dynamic_Loader_Sym *this, const char *errstr,
 	lib = pSymbol->lib;
 	DBC_Require(MEM_IsValidHandle(lib, DBLL_LIBSIGNATURE));
 	vsnprintf((char *)tempBuf, MAXEXPR, (char *)errstr, args);
-	GT_1trace(DBLL_debugMask, GT_5CLASS, "%s\n", tempBuf);
+	dev_dbg(bridge, "%s\n", tempBuf);
 }
 
 /* Dynamic_Loader_Allocate */
@@ -1324,13 +1323,11 @@ func_cont:
 		if (!runAddrFlag)
 			info->run_addr = info->load_addr;
 		info->context = (u32)rmmAddr.segid;
-		GT_3trace(DBLL_debugMask, GT_5CLASS,
-			 "Remote alloc: %s  base = 0x%lx len"
-			 "= 0x%lx\n", info->name, info->load_addr / DSPWORDSIZE,
-			 info->size / DSPWORDSIZE);
-		GT_2trace(DBLL_debugMask, GT_5CLASS,
-			 "info->run_addr = 0x%x, info->load_addr= 0x%x\n",
-			 info->run_addr, info->load_addr);
+		dev_dbg(bridge, "%s: %s base = 0x%x len = 0x%x, "
+			"info->run_addr 0x%x, info->load_addr 0x%x\n",
+			__func__, info->name, info->load_addr / DSPWORDSIZE,
+			info->size / DSPWORDSIZE, info->run_addr,
+			info->load_addr);
 	}
 	return retVal;
 }
diff --git a/drivers/dsp/bridge/pmgr/dmm.c b/drivers/dsp/bridge/pmgr/dmm.c
index 2840674..098743f 100644
--- a/drivers/dsp/bridge/pmgr/dmm.c
+++ b/drivers/dsp/bridge/pmgr/dmm.c
@@ -289,9 +289,6 @@ DSP_STATUS DMM_MapMemory(struct DMM_OBJECT *hDmmMgr, u32 addr, u32 size)
 	struct MapPage *chunk;
 	DSP_STATUS status = DSP_SOK;
 
-	GT_3trace(DMM_debugMask, GT_ENTER,
-		 "Entered DMM_MapMemory () hDmmMgr %x, "
-		 "addr %x, size %x\n", hDmmMgr, addr, size);
 	SYNC_EnterCS(pDmmObj->hDmmLock);
 	/* Find the Reserved memory chunk containing the DSP block to
 	 * be mapped */
@@ -303,9 +300,10 @@ DSP_STATUS DMM_MapMemory(struct DMM_OBJECT *hDmmMgr, u32 addr, u32 size)
 	} else
 		status = DSP_ENOTFOUND;
 	SYNC_LeaveCS(pDmmObj->hDmmLock);
-	GT_2trace(DMM_debugMask, GT_4CLASS,
-		 "Leaving DMM_MapMemory status %x, chunk %x\n",
-		status, chunk);
+
+	dev_dbg(bridge, "%s hDmmMgr %p, addr %x, size %x\n\tstatus %x, "
+		"chunk %p", __func__, hDmmMgr, addr, size, status, chunk);
+
 	return status;
 }
 
@@ -323,9 +321,6 @@ DSP_STATUS DMM_ReserveMemory(struct DMM_OBJECT *hDmmMgr, u32 size,
 	u32 rsvAddr = 0;
 	u32 rsvSize = 0;
 
-	GT_3trace(DMM_debugMask, GT_ENTER,
-		 "Entered DMM_ReserveMemory () hDmmMgr %x, "
-		 "size %x, pRsvAddr %x\n", hDmmMgr, size, pRsvAddr);
 	SYNC_EnterCS(pDmmObj->hDmmLock);
 
 	/* Try to get a DSP chunk from the free list */
@@ -355,9 +350,11 @@ DSP_STATUS DMM_ReserveMemory(struct DMM_OBJECT *hDmmMgr, u32 size,
 		status = DSP_EMEMORY;
 
 	SYNC_LeaveCS(pDmmObj->hDmmLock);
-	GT_3trace(DMM_debugMask, GT_4CLASS,
-		 "Leaving ReserveMemory status %x, rsvAddr"
-		 " %x, rsvSize %x\n", status, rsvAddr, rsvSize);
+
+	dev_dbg(bridge, "%s hDmmMgr %p, size %x, pRsvAddr %p\n\tstatus %x, "
+			"rsvAddr %x, rsvSize %x\n", __func__, hDmmMgr, size,
+			pRsvAddr, status, rsvAddr, rsvSize);
+
 	return status;
 }
 
@@ -373,9 +370,6 @@ DSP_STATUS DMM_UnMapMemory(struct DMM_OBJECT *hDmmMgr, u32 addr, u32 *pSize)
 	struct MapPage *chunk;
 	DSP_STATUS status = DSP_SOK;
 
-	GT_3trace(DMM_debugMask, GT_ENTER,
-		 "Entered DMM_UnMapMemory () hDmmMgr %x, "
-		 "addr %x, pSize %x\n", hDmmMgr, addr, pSize);
 	SYNC_EnterCS(pDmmObj->hDmmLock);
 	chunk = GetMappedRegion(addr) ;
 	if (chunk == NULL)
@@ -388,9 +382,9 @@ DSP_STATUS DMM_UnMapMemory(struct DMM_OBJECT *hDmmMgr, u32 addr, u32 *pSize)
 		chunk->MappedSize = 0;
 	}
 	SYNC_LeaveCS(pDmmObj->hDmmLock);
-	GT_3trace(DMM_debugMask, GT_ENTER,
-		 "Leaving DMM_UnMapMemory status %x, chunk"
-		 " %x,  *pSize %x\n", status, chunk, *pSize);
+
+	dev_dbg(bridge, "%s: hDmmMgr %p, addr %x, pSize %p\n\tstatus %x, "
+		"chunk %p\n", __func__, hDmmMgr, addr, pSize, status, chunk);
 
 	return status;
 }
@@ -408,10 +402,6 @@ DSP_STATUS DMM_UnReserveMemory(struct DMM_OBJECT *hDmmMgr, u32 rsvAddr)
 	DSP_STATUS status = DSP_SOK;
 	u32 chunkSize;
 
-	GT_2trace(DMM_debugMask, GT_ENTER,
-		 "Entered DMM_UnReserveMemory () hDmmMgr "
-		 "%x, rsvAddr %x\n", hDmmMgr, rsvAddr);
-
 	SYNC_EnterCS(pDmmObj->hDmmLock);
 
 	/* Find the chunk containing the reserved address */
@@ -441,9 +431,10 @@ DSP_STATUS DMM_UnReserveMemory(struct DMM_OBJECT *hDmmMgr, u32 rsvAddr)
 		 */
 	}
 	SYNC_LeaveCS(pDmmObj->hDmmLock);
-	GT_2trace(DMM_debugMask, GT_ENTER,
-		 "Leaving DMM_UnReserveMemory status %x"
-		 " chunk %x\n", status, chunk);
+
+	dev_dbg(bridge, "%s: hDmmMgr %p, rsvAddr %x\n\tstatus %x chunk %p",
+			__func__, hDmmMgr, rsvAddr, status, chunk);
+
 	return status;
 }
 
@@ -464,9 +455,9 @@ static struct MapPage *GetRegion(u32 aAddr)
 		if (i < TableSize)
 			currRegion = pVirtualMappingTable + i;
 	}
-	GT_3trace(DMM_debugMask, GT_4CLASS,
-	       "Leaving GetRegion currRegion %x, iFreeRegion %d\n,"
-	       "iFreeSize %d\n", currRegion, iFreeRegion, iFreeSize) ;
+
+	dev_dbg(bridge, "%s: currRegion %p, iFreeRegion %d, iFreeSize %d\n",
+			__func__, currRegion, iFreeRegion, iFreeSize);
 	return currRegion;
 }
 
diff --git a/drivers/dsp/bridge/pmgr/msg.c b/drivers/dsp/bridge/pmgr/msg.c
index 69f39a8..34bac4e 100644
--- a/drivers/dsp/bridge/pmgr/msg.c
+++ b/drivers/dsp/bridge/pmgr/msg.c
@@ -106,8 +106,8 @@ void MSG_Delete(struct MSG_MGR *hMsgMgr)
 	(*pIntfFxns->pfnMsgDelete)(hMsgMgr);
 
 	if (MEM_IsValidHandle(pMsgMgr, MSGMGR_SIGNATURE))
-		GT_1trace(MSG_debugMask, GT_7CLASS, "MSG_Delete: Error hMsgMgr "
-					"Valid Handle: 0x%x\n", hMsgMgr);
+		dev_dbg(bridge, "%s: Error hMsgMgr handle: %p\n",
+						__func__, hMsgMgr);
 }
 
 /*
-- 
1.6.2.4


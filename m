From: "Ramirez Luna, Omar" <x00omar@ti.com>
Subject: [PATCH 1/2][GIT 3/4+] fixed some cosmetic warnings from checkpatch
Date: Fri, 15 Aug 2008 17:09:27 -0500
Message-ID: <27F9C60D11D683428E133F85D2BB4A530825E2F6@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from soda.ext.ti.com ([198.47.26.145]:42826 "EHLO soda.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752883AbYHOWJg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 Aug 2008 18:09:36 -0400
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by soda.ext.ti.com (8.13.7/8.13.7) with ESMTP id m7FM9Ud7024176
	for <linux-omap@vger.kernel.org>; Fri, 15 Aug 2008 17:09:35 -0500
Received: from dlee74.ent.ti.com (localhost [127.0.0.1])
	by dlep34.itg.ti.com (8.13.7/8.13.7) with ESMTP id m7FM9TAJ008436
	for <linux-omap@vger.kernel.org>; Fri, 15 Aug 2008 17:09:30 -0500 (CDT)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Fixed cosmetic changes reported from checkpatch

Signed-off-by: Omar Ramirez Luna <x00omar@ti.com>
Acked-by: Hari Kanigeri <h-kanigeri2@ti.com>
---

Index: omapkernel/drivers/dsp/bridge/gen/gs.c
===================================================================
--- omapkernel.orig/drivers/dsp/bridge/gen/gs.c 2008-08-15 13:05:51.000000000 -0500
+++ omapkernel/drivers/dsp/bridge/gen/gs.c      2008-08-15 13:05:53.000000000 -0500
@@ -98,7 +98,7 @@
  */
 void GS_init(void)
 {
-       static bool curInit = false;
+       static bool curInit;

        if (curInit == false) {
                curInit = true;
Index: omapkernel/drivers/dsp/bridge/gen/gt.c
===================================================================
--- omapkernel.orig/drivers/dsp/bridge/gen/gt.c 2008-08-15 13:05:51.000000000 -0500
+++ omapkernel/drivers/dsp/bridge/gen/gt.c      2008-08-15 13:05:53.000000000 -0500
@@ -55,7 +55,7 @@

 static unsigned char *GT_tMask[GT_BOUND];

-static bool curInit = false;
+static bool curInit;
 static char *separator;
 static unsigned char tabMem[GT_BOUND][sizeof(unsigned char) * GT_BOUND];

Index: omapkernel/drivers/dsp/bridge/pmgr/dbll.c
===================================================================
--- omapkernel.orig/drivers/dsp/bridge/pmgr/dbll.c      2008-08-15 13:05:51.000000000 -0500
+++ omapkernel/drivers/dsp/bridge/pmgr/dbll.c   2008-08-15 13:05:53.000000000 -0500
@@ -221,13 +221,13 @@
 static void symDelete(void *sp);

 #if GT_TRACE
-static struct GT_Mask DBLL_debugMask = { NULL, NULL };     /* GT trace variable */
+static struct GT_Mask DBLL_debugMask = { NULL, NULL };  /* GT trace variable */
 #endif

 static u32 cRefs;              /* module reference count */

 /* Symbol Redefinition */
-static int bRedefinedSymbol = 0;
+static int bRedefinedSymbol;
 static int bGblSearch = 1;

 /*
Index: omapkernel/drivers/dsp/bridge/pmgr/dev.c
===================================================================
--- omapkernel.orig/drivers/dsp/bridge/pmgr/dev.c       2008-08-15 13:05:51.000000000 -0500
+++ omapkernel/drivers/dsp/bridge/pmgr/dev.c    2008-08-15 13:05:53.000000000 -0500
@@ -899,7 +899,8 @@
                status = DEV_GetCodMgr(hDevObject, &hCodMgr);
                if (DSP_SUCCEEDED(status)) {
                        DBC_Assert(hCodMgr != NULL);
-                       status = COD_GetSymValue(hCodMgr, (char *)pstrSym, pulValue);
+                       status = COD_GetSymValue(hCodMgr, (char *)pstrSym,
+                                pulValue);
                }
        } else {
                status = DSP_EHANDLE;
Index: omapkernel/drivers/dsp/bridge/pmgr/wcd.c
===================================================================
--- omapkernel.orig/drivers/dsp/bridge/pmgr/wcd.c       2008-08-15 13:05:51.000000000 -0500
+++ omapkernel/drivers/dsp/bridge/pmgr/wcd.c    2008-08-15 13:05:53.000000000 -0500
@@ -174,7 +174,9 @@
 } ;

 /*  ----------------------------------- Globals */
+#if GT_TRACE
 static struct GT_Mask WCD_debugMask = { NULL, NULL };  /* Core VxD Mask */
+#endif
 static u32 WCD_cRefs;

 /*
Index: omapkernel/drivers/dsp/bridge/rmgr/drv.c
===================================================================
--- omapkernel.orig/drivers/dsp/bridge/rmgr/drv.c       2008-08-15 13:05:51.000000000 -0500
+++ omapkernel/drivers/dsp/bridge/rmgr/drv.c    2008-08-15 13:05:53.000000000 -0500
@@ -425,7 +425,7 @@
 }

 /* Actual Node De-Allocation */
-DSP_STATUS DRV_ProcFreeNodeRes(HANDLE hPCtxt)
+static DSP_STATUS DRV_ProcFreeNodeRes(HANDLE hPCtxt)
 {
        struct PROCESS_CONTEXT *pCtxt = (struct PROCESS_CONTEXT *)hPCtxt;
        DSP_STATUS status = DSP_SOK;
Index: omapkernel/drivers/dsp/bridge/rmgr/drv_interface.c
===================================================================
--- omapkernel.orig/drivers/dsp/bridge/rmgr/drv_interface.c     2008-08-15 13:05:51.000000000 -0500
+++ omapkernel/drivers/dsp/bridge/rmgr/drv_interface.c  2008-08-15 13:05:53.000000000 -0500
@@ -138,7 +138,7 @@
 #if !defined(CONFIG_ARCH_OMAP2430) && !defined(CONFIG_ARCH_OMAP3430)
 static int tc_wordswapon = 1;  /* Default value is always TRUE */
 #else
-static int tc_wordswapon = 0;  /* Default value is always true */
+static int tc_wordswapon;      /* Default value is always true */
 #endif


@@ -586,7 +586,7 @@
                        DRV_RemoveAllResources(pCtxtclosed);
                        if (pCtxtclosed->hProcessor != NULL) {
                                DRV_GetProcCtxtList(&pCtxttraverse,
-                                                   (struct DRV_OBJECT *)hDrvObject);
+                                           (struct DRV_OBJECT *)hDrvObject);
                                if (pCtxttraverse->next == NULL) {
                                        PROC_Detach(pCtxtclosed->hProcessor);
                                } else {
@@ -615,8 +615,9 @@
                                }
                        }
                        pTmp = pCtxtclosed->next;
-                       DRV_RemoveProcContext((struct DRV_OBJECT *)hDrvObject, pCtxtclosed,
-                                             (void *)pCtxtclosed->pid);
+                       DRV_RemoveProcContext((struct DRV_OBJECT *)hDrvObject,
+                                            pCtxtclosed,
+                                            (void *)pCtxtclosed->pid);
                } else {
                        pTmp = pCtxtclosed->next;
                }
@@ -625,7 +626,8 @@
 func_cont:
        dsp_status = CFG_GetObject((u32 *)&hDrvObject, REG_DRV_OBJECT);
        if (DSP_SUCCEEDED(dsp_status))
-               dsp_status = DRV_InsertProcContext((struct DRV_OBJECT *)hDrvObject, &pPctxt);
+               dsp_status = DRV_InsertProcContext(
+                               (struct DRV_OBJECT *)hDrvObject, &pPctxt);

        if (pPctxt != NULL) {
                PRCS_GetCurrentHandle(&hProcess);
Index: omapkernel/drivers/dsp/bridge/rmgr/node.c
===================================================================
--- omapkernel.orig/drivers/dsp/bridge/rmgr/node.c      2008-08-15 13:05:51.000000000 -0500
+++ omapkernel/drivers/dsp/bridge/rmgr/node.c   2008-08-15 13:05:53.000000000 -0500
@@ -776,10 +776,13 @@
                res_status = CFG_GetObject((u32 *)&hDrvObject,
                                          REG_DRV_OBJECT);
                if (DSP_SUCCEEDED(res_status)) {
-                       DRV_GetProcContext((u32)hProcess, (struct DRV_OBJECT *)hDrvObject, &pPctxt,
-                                        *phNode, 0);
+                       DRV_GetProcContext((u32)hProcess,
+                                        (struct DRV_OBJECT *)hDrvObject,
+                                        &pPctxt, *phNode, 0);
                        if (pPctxt == NULL) {
-                               DRV_InsertProcContext((struct DRV_OBJECT *)hDrvObject, &pPctxt);
+                               DRV_InsertProcContext(
+                                       (struct DRV_OBJECT *)hDrvObject,
+                                       &pPctxt);
                                if (pPctxt != NULL) {
                                        DRV_ProcUpdatestate(pPctxt,
                                                        PROC_RES_ALLOCATED);
@@ -795,8 +798,9 @@
                res_status = CFG_GetObject((u32 *)&hDrvObject,
                                        REG_DRV_OBJECT);
                if (DSP_SUCCEEDED(res_status)) {
-                       DRV_GetProcContext((u32)hProcess, (struct DRV_OBJECT *)hDrvObject, &pPctxt,
-                                        *phNode, 0);
+                       DRV_GetProcContext((u32)hProcess,
+                                        (struct DRV_OBJECT *)hDrvObject,
+                                        &pPctxt, *phNode, 0);
                        if (pPctxt != NULL) {
                                DRV_InsertNodeResElement(*phNode, &nodeRes,
                                                         pPctxt);
@@ -1775,7 +1779,8 @@
        if (!DSP_SUCCEEDED(res_status))
                goto func_cont;

-       DRV_GetProcContext((u32)hProcess, (struct DRV_OBJECT *)hDrvObject, &pCtxt, hNode, 0);
+       DRV_GetProcContext((u32)hProcess, (struct DRV_OBJECT *)hDrvObject,
+                        &pCtxt, hNode, 0);
        if (pCtxt == NULL)
                goto func_cont;

Index: omapkernel/drivers/dsp/bridge/rmgr/proc.c
===================================================================
--- omapkernel.orig/drivers/dsp/bridge/rmgr/proc.c      2008-08-15 13:05:51.000000000 -0500
+++ omapkernel/drivers/dsp/bridge/rmgr/proc.c   2008-08-15 13:05:53.000000000 -0500
@@ -365,7 +365,8 @@
        if (!DSP_SUCCEEDED(res_status))
                goto func_cont;

-       DRV_GetProcContext((u32)hProcess, (struct DRV_OBJECT *)hDRVObject, &pPctxt, NULL, 0);
+       DRV_GetProcContext((u32)hProcess, (struct DRV_OBJECT *)hDRVObject,
+                        &pPctxt, NULL, 0);
        if (pPctxt == NULL) {
                DRV_InsertProcContext((struct DRV_OBJECT *)hDRVObject, &pPctxt);
                if (pPctxt != NULL) {
@@ -377,7 +378,9 @@
        PRCS_GetCurrentHandle(&hProcess);
        res_status = CFG_GetObject((u32 *)&hDRVObject, REG_DRV_OBJECT);
        if (DSP_SUCCEEDED(res_status)) {
-               DRV_GetProcContext((u32)hProcess, (struct DRV_OBJECT *)hDRVObject, &pPctxt, NULL, 0);
+               DRV_GetProcContext((u32)hProcess,
+                                (struct DRV_OBJECT *)hDRVObject, &pPctxt,
+                                NULL, 0);
                if (pPctxt != NULL)
                        pPctxt->hProcessor = (DSP_HPROCESSOR)*phProcessor;

@@ -634,7 +637,9 @@
        res_status = CFG_GetObject((u32 *)&hDRVObject, REG_DRV_OBJECT);
        /* res_status = CFG_GetObject(REG_DRV_OBJECT, (u32*)&hDRVObject); */
        if (DSP_SUCCEEDED(res_status)) {
-               DRV_GetProcContext((u32)hProcess, (struct DRV_OBJECT *)hDRVObject, &pPctxt, NULL, 0);
+               DRV_GetProcContext((u32)hProcess,
+                                (struct DRV_OBJECT *)hDRVObject, &pPctxt,
+                                NULL, 0);
                if (pPctxt != NULL)
                        pPctxt->hProcessor = NULL;
        }
@@ -1383,8 +1388,9 @@
                res_status = CFG_GetObject((u32 *)&hDrvObject,
                                          REG_DRV_OBJECT);
                if (DSP_SUCCEEDED(res_status)) {
-                       if (DRV_GetProcContext((u32)hProcess, (struct DRV_OBJECT *)hDrvObject, &pCtxt,
-                          NULL, (u32)pMpuAddr) != DSP_ENOTFOUND) {
+                       if (DRV_GetProcContext((u32)hProcess,
+                          (struct DRV_OBJECT *)hDrvObject, &pCtxt, NULL,
+                          (u32)pMpuAddr) != DSP_ENOTFOUND) {
                                DRV_InsertDMMResElement(&dmmRes, pCtxt);
                                DRV_UpdateDMMResElement(dmmRes, (u32)pMpuAddr,
                                                ulSize, (u32)pReqAddr,
@@ -1737,7 +1743,8 @@
        if (!DSP_SUCCEEDED(res_status))
                goto func_end;

-       DRV_GetProcContext((u32)hProcess, (struct DRV_OBJECT *)hDrvObject, &pCtxt, NULL, (u32)pMapAddr);
+       DRV_GetProcContext((u32)hProcess, (struct DRV_OBJECT *)hDrvObject,
+                        &pCtxt, NULL, (u32)pMapAddr);
        if (pCtxt != NULL) {
                if (DRV_GetDMMResElement((u32)pMapAddr, &dmmRes, pCtxt) !=
                   DSP_ENOTFOUND)
Index: omapkernel/drivers/dsp/bridge/rmgr/strm.c
===================================================================
--- omapkernel.orig/drivers/dsp/bridge/rmgr/strm.c      2008-08-15 13:05:51.000000000 -0500
+++ omapkernel/drivers/dsp/bridge/rmgr/strm.c   2008-08-15 13:05:53.000000000 -0500
@@ -209,7 +209,8 @@
        if (!DSP_SUCCEEDED(res_status))
                goto func_end;

-       DRV_GetProcContext((u32)hProcess, (struct DRV_OBJECT *)hDrvObject, &pCtxt, NULL, 0);
+       DRV_GetProcContext((u32)hProcess, (struct DRV_OBJECT *)hDrvObject,
+                        &pCtxt, NULL, 0);
        if (pCtxt != NULL) {
                if (DRV_GetSTRMResElement(hStrm, &hSTRMRes, pCtxt) !=
                   DSP_ENOTFOUND) {
@@ -280,7 +281,8 @@
        if (!DSP_SUCCEEDED(res_status))
                goto func_end;

-       DRV_GetProcContext((u32)hProcess, (struct DRV_OBJECT *)hDrvObject, &pCtxt, NULL, 0);
+       DRV_GetProcContext((u32)hProcess, (struct DRV_OBJECT *)hDrvObject,
+                        &pCtxt, NULL, 0);
        if (pCtxt != NULL) {
                if (DRV_GetSTRMResElement(hStrm, &hSTRMRes, pCtxt) !=
                   DSP_ENOTFOUND) {
@@ -428,7 +430,9 @@
        PRCS_GetCurrentHandle(&hProcess);
        res_status = CFG_GetObject((u32 *)&hDrvObject, REG_DRV_OBJECT);
        if (DSP_SUCCEEDED(res_status)) {
-               DRV_GetProcContext((u32)hProcess, (struct DRV_OBJECT *)hDrvObject, &pCtxt, NULL, 0);
+               DRV_GetProcContext((u32)hProcess,
+                                (struct DRV_OBJECT *)hDrvObject, &pCtxt,
+                                NULL, 0);
                if (pCtxt != NULL) {
                        if (DRV_GetSTRMResElement(hStrm, hSTRMRes, pCtxt) !=
                           DSP_ENOTFOUND) {
@@ -773,7 +777,9 @@
        PRCS_GetCurrentHandle(&hProcess);
        res_status = CFG_GetObject((u32 *)&hDrvObject, REG_DRV_OBJECT);
        if (DSP_SUCCEEDED(res_status)) {
-               DRV_GetProcContext((u32)hProcess, (struct DRV_OBJECT *)hDrvObject, &pCtxt, hNode, 0);
+               DRV_GetProcContext((u32)hProcess,
+                                (struct DRV_OBJECT *)hDrvObject, &pCtxt,
+                                hNode, 0);
                if (pCtxt != NULL)
                        DRV_ProcInsertSTRMResElement(*phStrm, &hSTRMRes, pCtxt);

Index: omapkernel/drivers/dsp/bridge/services/cfg.c
===================================================================
--- omapkernel.orig/drivers/dsp/bridge/services/cfg.c   2008-08-15 13:05:51.000000000 -0500
+++ omapkernel/drivers/dsp/bridge/services/cfg.c        2008-08-15 13:05:53.000000000 -0500
@@ -99,7 +99,7 @@

 /*  ----------------------------------- Globals */
 #if GT_TRACE
-static struct GT_Mask CFG_debugMask = { NULL, NULL };  /* CFG debug Mask           */
+static struct GT_Mask CFG_debugMask = { NULL, NULL };  /* CFG debug Mask */
 #endif

 /*
Index: omapkernel/drivers/dsp/bridge/services/mem.c
===================================================================
--- omapkernel.orig/drivers/dsp/bridge/services/mem.c   2008-08-15 13:05:51.000000000 -0500
+++ omapkernel/drivers/dsp/bridge/services/mem.c        2008-08-15 13:05:53.000000000 -0500
@@ -82,7 +82,7 @@

 static u32 cRefs;              /* module reference count */

-static bool extPhysMemPoolEnabled = false;
+static bool extPhysMemPoolEnabled;

 struct extPhysMemPool {
        u32 physMemBase;
Index: omapkernel/drivers/dsp/bridge/services/ntfy.c
===================================================================
--- omapkernel.orig/drivers/dsp/bridge/services/ntfy.c  2008-08-15 13:05:51.000000000 -0500
+++ omapkernel/drivers/dsp/bridge/services/ntfy.c       2008-08-15 13:05:53.000000000 -0500
@@ -92,7 +92,7 @@

 /*  ----------------------------------- Globals */
 #if GT_TRACE
-static struct GT_Mask NTFY_debugMask = { NULL, NULL };    /* GT trace variable */
+static struct GT_Mask NTFY_debugMask = { NULL, NULL };  /* GT trace variable */
 #endif

 /*  ----------------------------------- Function Prototypes */
Index: omapkernel/drivers/dsp/bridge/services/services.c
===================================================================
--- omapkernel.orig/drivers/dsp/bridge/services/services.c      2008-08-15 13:05:51.000000000 -0500
+++ omapkernel/drivers/dsp/bridge/services/services.c   2008-08-15 13:05:53.000000000 -0500
@@ -63,7 +63,7 @@

 /*  ----------------------------------- Globals */
 #if GT_TRACE
-static struct GT_Mask SERVICES_debugMask = { NULL, NULL };     /* GT trace var. */
+static struct GT_Mask SERVICES_debugMask = { NULL, NULL };  /* GT trace var. */
 #endif

 static u32 cRefs;              /* SERVICES module reference count */
Index: omapkernel/drivers/dsp/bridge/services/sync.c
===================================================================
--- omapkernel.orig/drivers/dsp/bridge/services/sync.c  2008-08-15 13:05:51.000000000 -0500
+++ omapkernel/drivers/dsp/bridge/services/sync.c       2008-08-15 13:05:53.000000000 -0500
@@ -108,7 +108,7 @@

 /*  ----------------------------------- Globals */
 #if GT_TRACE
-static struct GT_Mask SYNC_debugMask = { NULL, NULL };     /* GT trace variable */
+static struct GT_Mask SYNC_debugMask = { NULL, NULL };  /* GT trace variable */
 #endif

 static int test_and_set(volatile void *ptr, int val)
Index: omapkernel/drivers/dsp/bridge/wmd/ue_deh.c
===================================================================
--- omapkernel.orig/drivers/dsp/bridge/wmd/ue_deh.c     2008-08-15 13:05:51.000000000 -0500
+++ omapkernel/drivers/dsp/bridge/wmd/ue_deh.c  2008-08-15 13:05:53.000000000 -0500
@@ -69,7 +69,8 @@
 #include "_deh.h"
 #include <_tiomap_mmu.h>

-static struct HW_MMUMapAttrs_t  mapAttrs = { HW_LITTLE_ENDIAN, HW_ELEM_SIZE_16BIT,
+static struct HW_MMUMapAttrs_t  mapAttrs = { HW_LITTLE_ENDIAN,
+                                       HW_ELEM_SIZE_16BIT,
                                        HW_MMU_CPUES} ;
 #define VirtToPhys(x)       ((x) - PAGE_OFFSET + PHYS_OFFSET)
 /*
@@ -405,7 +406,8 @@
                case DSP_MMUFAULT:
                        /* MMU fault routine should have set err info
                         * structure */
-                       pDevContext = (struct WMD_DEV_CONTEXT *)pDehMgr->hWmdContext;
+                       pDevContext = (struct WMD_DEV_CONTEXT *)pDehMgr->
+                                       hWmdContext;
                        pDehMgr->errInfo.dwErrMask = DSP_MMUFAULT;
                        printk(KERN_INFO "WMD_DEH_Notify: DSP_MMUFAULT,"
                                "errInfo = 0x%x\n", dwErrInfo);
Index: omapkernel/include/asm-arm/arch-omap/bridge/resourcecleanup.h
===================================================================
--- omapkernel.orig/include/asm-arm/arch-omap/bridge/resourcecleanup.h  2008-08-15 13:05:51.000000000 -0500
+++ omapkernel/include/asm-arm/arch-omap/bridge/resourcecleanup.h       2008-08-15 13:05:53.000000000 -0500
@@ -23,7 +23,8 @@
 extern DSP_STATUS DRV_GetProcCtxtList(struct PROCESS_CONTEXT **pPctxt,
                                struct DRV_OBJECT *hDrvObject);

-extern DSP_STATUS DRV_InsertProcContext(struct DRV_OBJECT *hDrVObject, HANDLE hPCtxt);
+extern DSP_STATUS DRV_InsertProcContext(struct DRV_OBJECT *hDrVObject,
+                                       HANDLE hPCtxt);

 extern DSP_STATUS DRV_RemoveAllDMMResElements(HANDLE pCtxt);

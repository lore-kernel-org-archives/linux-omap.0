From: "Ramirez Luna, Omar" <x00omar@ti.com>
Subject: [PATCH 3/7][OMAP 3/4+] BRIDGE GT mask for DSP traces
Date: Fri, 12 Sep 2008 23:03:45 -0500
Message-ID: <27F9C60D11D683428E133F85D2BB4A5344A4F04C@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48790 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750755AbYIMEDx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 13 Sep 2008 00:03:53 -0400
Received: from dlep95.itg.ti.com ([157.170.170.107])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id m8D43lYf027385
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 12 Sep 2008 23:03:52 -0500
Received: from dlee74.ent.ti.com (localhost [127.0.0.1])
	by dlep95.itg.ti.com (8.13.8/8.13.8) with ESMTP id m8D43lkF009344
	for <linux-omap@vger.kernel.org>; Fri, 12 Sep 2008 23:03:47 -0500 (CDT)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pandita, Vikram" <vikram.pandita@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Date: Fri, 12 Sep 2008 18:50:10 -0500
Subject: [PATCH] BRIDGE GT mask for DSP traces

Separate GT trace option provided to monitor DSP sys traces

Signed-off-by: Omar Ramirez Luna <x00omar@ti.com>
---
 arch/arm/plat-omap/include/mach/bridge/io_sm.h |    9 +
 drivers/dsp/bridge/wmd/io_sm.c                 |  204 +++++++++++++++++++++++-
 drivers/dsp/bridge/wmd/mmu_fault.c             |    1 -
 drivers/dsp/bridge/wmd/mmu_fault.h             |    7 -
 drivers/dsp/bridge/wmd/tiomap3430.c            |    2 +
 drivers/dsp/bridge/wmd/ue_deh.c                |  190 +---------------------
 6 files changed, 215 insertions(+), 198 deletions(-)

diff --git a/arch/arm/plat-omap/include/mach/bridge/io_sm.h b/arch/arm/plat-omap/include/mach/bridge/io_sm.h
index 892c06a..b881475 100644
--- a/arch/arm/plat-omap/include/mach/bridge/io_sm.h
+++ b/arch/arm/plat-omap/include/mach/bridge/io_sm.h
@@ -326,4 +326,13 @@

        extern void IO_IntrDSP2(IN struct IO_MGR *pIOMgr, IN u16 wMbVal);

+       extern void IO_SM_init(void);
+
+/*
+ *  ========PrintDspTraceBuffer ========
+ *      Print DSP tracebuffer.
+ */
+       extern DSP_STATUS PrintDspTraceBuffer(struct WMD_DEV_CONTEXT
+                                               *hWmdContext);
+
 #endif                         /* IOSM_ */
diff --git a/drivers/dsp/bridge/wmd/io_sm.c b/drivers/dsp/bridge/wmd/io_sm.c
index 09ea3b1..2e6a401 100644
--- a/drivers/dsp/bridge/wmd/io_sm.c
+++ b/drivers/dsp/bridge/wmd/io_sm.c
@@ -165,6 +165,7 @@
 /*  ----------------------------------- This */
 #include <io_sm.h>
 #include "_msg_sm.h"
+#include <gt.h>

 /*  ----------------------------------- Defines, Data Structures, Typedefs */
 #define OUTPUTNOTREADY  0xffff
@@ -260,6 +261,11 @@ extern struct constraint_handle *dsp_constraint_handle;
 #endif
 #endif
 #endif
+
+#if GT_TRACE
+static struct GT_Mask dsp_trace_mask = { NULL, NULL }; /* GT trace variable */
+#endif
+
 /*
  *  ======== WMD_IO_Create ========
  *      Create an IO manager object.
@@ -1796,6 +1802,8 @@ void PrintDSPDebugTrace(struct IO_MGR *hIOMgr)
 {
        u32 ulNewMessageLength = 0, ulGPPCurPointer;

+       GT_0trace(dsp_trace_mask, GT_ENTER, "Entering PrintDSPDebugTrace\n");
+
        while (true) {
                /* Get the DSP current pointer */
                ulGPPCurPointer = *(u32 *) (hIOMgr->ulTraceBufferCurrent);
@@ -1818,8 +1826,7 @@ void PrintDSPDebugTrace(struct IO_MGR *hIOMgr)
                         * pointer */
                        hIOMgr->ulGPPReadPointer += ulNewMessageLength;
                        /* Print the trace messages */
-                       DBG_Trace(DBG_LEVEL3, "hIOMgr->pMsg=0x%x",
-                                hIOMgr->pMsg);
+                       GT_0trace(dsp_trace_mask, GT_1CLASS, hIOMgr->pMsg);
                }
                /* Handle trace buffer wraparound */
                else if (ulGPPCurPointer < hIOMgr->ulGPPReadPointer) {
@@ -1840,10 +1847,199 @@ void PrintDSPDebugTrace(struct IO_MGR *hIOMgr)
                        hIOMgr->ulGPPReadPointer = hIOMgr->ulTraceBufferBegin +
                                                   ulNewMessageLength;
                        /* Print the trace messages */
-                       DBG_Trace(DBG_LEVEL3, "hIOMgr->pMsg=0x%x",
-                                hIOMgr->pMsg);
+                       GT_0trace(dsp_trace_mask, GT_1CLASS, hIOMgr->pMsg);
                }
        }
 }
 #endif

+/*
+ *  ======== PackTraceBuffer ========
+ *      Removes extra nulls from the trace buffer returned from the DSP.
+ *      Works even on buffers that already are packed (null removed); but has
+ *      one bug in that case -- loses the last character (replaces with '\0').
+ *      Continues through conversion for full set of nBytes input characters.
+ *  Parameters:
+ *    lpBuf:            Pointer to input/output buffer
+ *    nBytes:           Number of characters in the buffer
+ *    ulNumWords:       Number of DSP words in the buffer.  Indicates potential
+ *                      number of extra carriage returns to generate.
+ *  Returns:
+ *      DSP_SOK:        Success.
+ *      DSP_EMEMORY:    Unable to allocate memory.
+ *  Requires:
+ *      lpBuf must be a fully allocated writable block of at least nBytes.
+ *      There are no more than ulNumWords extra characters needed (the number of
+ *      linefeeds minus the number of NULLS in the input buffer).
+ */
+#if ((defined DEBUG) || (defined DDSP_DEBUG_PRODUCT))\
+       && GT_TRACE
+static DSP_STATUS PackTraceBuffer(char *lpBuf, u32 nBytes, u32 ulNumWords)
+{
+       DSP_STATUS status = DSP_SOK;
+
+       char *lpTmpBuf;
+       char *lpBufStart;
+       char *lpTmpStart;
+       u32 nCnt;
+       char thisChar;
+
+       /* tmp workspace, 1 KB longer than input buf */
+       lpTmpBuf = MEM_Calloc((nBytes + ulNumWords), MEM_PAGED);
+       if (lpTmpBuf == NULL) {
+               DBG_Trace(DBG_LEVEL7, "PackTrace buffer:OutofMemory \n");
+               status = DSP_EMEMORY;
+       }
+
+       if (DSP_SUCCEEDED(status)) {
+               lpBufStart = lpBuf;
+               lpTmpStart = lpTmpBuf;
+               for (nCnt = nBytes; nCnt > 0; nCnt--) {
+                       thisChar = *lpBuf++;
+                       switch (thisChar) {
+                       case '\0':      /* Skip null bytes */
+                               break;
+                       case '\n':      /* Convert \n to \r\n */
+                               /* NOTE: do not reverse order; Some OS */
+                               /* editors control doesn't understand "\n\r" */
+                               *lpTmpBuf++ = '\r';
+                               *lpTmpBuf++ = '\n';
+                               break;
+                       default:        /* Copy in the actual ascii byte */
+                               *lpTmpBuf++ = thisChar;
+                               break;
+                       }
+               }
+               *lpTmpBuf = '\0';    /* Make sure tmp buf is null terminated */
+               /* Cut output down to input buf size */
+               strncpy(lpBufStart, lpTmpStart, nBytes);
+               /*Make sure output is null terminated */
+               lpBufStart[nBytes - 1] = '\0';
+               MEM_Free(lpTmpStart);
+       }
+
+       return status;
+}
+#endif    /* ((defined DEBUG) || (defined DDSP_DEBUG_PRODUCT)) && GT_TRACE */
+
+/*
+ *  ======== PrintDspTraceBuffer ========
+ *      Prints the trace buffer returned from the DSP (if DBG_Trace is enabled).
+ *  Parameters:
+ *    hDehMgr:          Handle to DEH manager object
+ *                      number of extra carriage returns to generate.
+ *  Returns:
+ *      DSP_SOK:        Success.
+ *      DSP_EMEMORY:    Unable to allocate memory.
+ *  Requires:
+ *      hDehMgr muse be valid. Checked in WMD_DEH_Notify.
+ */
+DSP_STATUS PrintDspTraceBuffer(struct WMD_DEV_CONTEXT *hWmdContext)
+{
+       DSP_STATUS status = DSP_SOK;
+
+#if ((defined DEBUG) || (defined DDSP_DEBUG_PRODUCT))\
+       && GT_TRACE
+
+       struct COD_MANAGER *hCodMgr;
+       u32 ulTraceEnd;
+       u32 ulTraceBegin;
+       u32 ulNumBytes = 0;
+       u32 ulNumWords = 0;
+       u32 ulWordSize = 2;
+       CONST u32 uMaxSize = 512;
+       char *pszBuf;
+       u16 *lpszBuf;
+
+       struct WMD_DEV_CONTEXT *pWmdContext = (struct WMD_DEV_CONTEXT *)
+                                                       hWmdContext;
+       struct WMD_DRV_INTERFACE *pIntfFxns;
+       struct DEV_OBJECT *pDevObject = (struct DEV_OBJECT *)
+                                               pWmdContext->hDevObject;
+
+       status = DEV_GetCodMgr(pDevObject, &hCodMgr);
+       if (DSP_FAILED(status))
+               GT_0trace(dsp_trace_mask, GT_2CLASS,
+                        "PrintDspTraceBuffer: Failed on DEV_GetCodMgr.\n");
+
+       if (DSP_SUCCEEDED(status)) {
+               /* Look for SYS_PUTCBEG/SYS_PUTCEND: */
+               status = COD_GetSymValue(hCodMgr, COD_TRACEBEG, &ulTraceBegin);
+               GT_1trace(dsp_trace_mask, GT_2CLASS,
+                        "PrintDspTraceBuffer: ulTraceBegin Value 0x%x\n",
+                        ulTraceBegin);
+               if (DSP_FAILED(status))
+                       GT_0trace(dsp_trace_mask, GT_2CLASS,
+                                "PrintDspTraceBuffer: Failed on "
+                                "COD_GetSymValue.\n");
+
+       }
+       if (DSP_SUCCEEDED(status)) {
+               status = COD_GetSymValue(hCodMgr, COD_TRACEEND, &ulTraceEnd);
+               GT_1trace(dsp_trace_mask, GT_2CLASS,
+                        "PrintDspTraceBuffer: ulTraceEnd Value 0x%x\n",
+                        ulTraceEnd);
+               if (DSP_FAILED(status))
+                       GT_0trace(dsp_trace_mask, GT_2CLASS,
+                                "PrintDspTraceBuffer: Failed on "
+                                "COD_GetSymValue.\n");
+
+       }
+       if (DSP_SUCCEEDED(status)) {
+               ulNumBytes = (ulTraceEnd - ulTraceBegin) * ulWordSize;
+                /*  If the chip type is 55 then the addresses will be
+                *  byte addresses; convert them to word addresses.  */
+               if (ulNumBytes > uMaxSize)
+                       ulNumBytes = uMaxSize;
+
+               /* make sure the data we request fits evenly */
+               ulNumBytes = (ulNumBytes / ulWordSize) * ulWordSize;
+               GT_1trace(dsp_trace_mask, GT_2CLASS, "PrintDspTraceBuffer: "
+                        "ulNumBytes 0x%x\n", ulNumBytes);
+               ulNumWords = ulNumBytes * ulWordSize;
+               GT_1trace(dsp_trace_mask, GT_2CLASS, "PrintDspTraceBuffer: "
+                        "ulNumWords 0x%x\n", ulNumWords);
+               status = DEV_GetIntfFxns(pDevObject, &pIntfFxns);
+       }
+
+       if (DSP_SUCCEEDED(status)) {
+               pszBuf = MEM_Calloc(uMaxSize, MEM_NONPAGED);
+               lpszBuf = MEM_Calloc(ulNumBytes * 2, MEM_NONPAGED);
+               if (pszBuf != NULL) {
+                       /* Read bytes from the DSP trace buffer... */
+                       status = (*pIntfFxns->pfnBrdRead)(hWmdContext,
+                                (u8 *)pszBuf, (u32)ulTraceBegin,
+                                ulNumBytes, 0);
+                       if (DSP_FAILED(status))
+                               GT_0trace(dsp_trace_mask, GT_2CLASS,
+                                        "PrintDspTraceBuffer: "
+                                        "Failed to Read Trace Buffer.\n");
+
+                       if (DSP_SUCCEEDED(status)) {
+                               /* Pack and do newline conversion */
+                               GT_0trace(dsp_trace_mask, GT_2CLASS,
+                                        "PrintDspTraceBuffer: "
+                                        "before pack and unpack.\n");
+                               PackTraceBuffer(pszBuf, ulNumBytes, ulNumWords);
+                               GT_1trace(dsp_trace_mask, GT_1CLASS,
+                                        "DSP Trace Buffer:\n%s\n", pszBuf);
+                       }
+                       MEM_Free(pszBuf);
+                       MEM_Free(lpszBuf);
+               } else {
+                       GT_0trace(dsp_trace_mask, GT_2CLASS,
+                                "PrintDspTraceBuffer: Failed to "
+                                "allocate trace buffer.\n");
+                       status = DSP_EMEMORY;
+               }
+       }
+#endif
+       return status;
+}
+
+void IO_SM_init(void)
+{
+
+       GT_create(&dsp_trace_mask, "DT"); /* DSP Trace Mask */
+
+}
diff --git a/drivers/dsp/bridge/wmd/mmu_fault.c b/drivers/dsp/bridge/wmd/mmu_fault.c
index 936af22..683d0b2 100644
--- a/drivers/dsp/bridge/wmd/mmu_fault.c
+++ b/drivers/dsp/bridge/wmd/mmu_fault.c
@@ -137,7 +137,6 @@ irqreturn_t  MMU_FaultIsr(int irq, IN void *pRefData)
                        HW_MMU_EventDisable(resources.dwDmmuBase,
                                            HW_MMU_ALL_INTERRUPTS);
                }
-               PrintDspTraceBuffer(pDehMgr);
        }
        return IRQ_HANDLED;
 }
diff --git a/drivers/dsp/bridge/wmd/mmu_fault.h b/drivers/dsp/bridge/wmd/mmu_fault.h
index 009382a..e05e475 100644
--- a/drivers/dsp/bridge/wmd/mmu_fault.h
+++ b/drivers/dsp/bridge/wmd/mmu_fault.h
@@ -41,12 +41,5 @@
  */
 irqreturn_t  MMU_FaultIsr(int irq, IN void *pRefData);

-/*
- *  ========PrintDspTraceBuffer ========
- *      Print DSP tracebuffer.
- */
-
-extern DSP_STATUS  PrintDspTraceBuffer(struct DEH_MGR *hDehMgr);
-
 #endif                         /* MMU_FAULT_ */

diff --git a/drivers/dsp/bridge/wmd/tiomap3430.c b/drivers/dsp/bridge/wmd/tiomap3430.c
index b850f23..e5c235d 100644
--- a/drivers/dsp/bridge/wmd/tiomap3430.c
+++ b/drivers/dsp/bridge/wmd/tiomap3430.c
@@ -246,6 +246,8 @@ void WMD_DRV_Entry(OUT struct WMD_DRV_INTERFACE **ppDrvInterface,
        DBC_Require(pstrWMDFileName != NULL);
        DBG_Trace(DBG_ENTER, "In the WMD_DRV_Entry \n");

+       IO_SM_init(); /* Initialization of io_sm module */
+
        if (strcmp(pstrWMDFileName, "UMA") == 0)
                *ppDrvInterface = &drvInterfaceFxns;
        else
diff --git a/drivers/dsp/bridge/wmd/ue_deh.c b/drivers/dsp/bridge/wmd/ue_deh.c
index 665304f..b2a85e2 100644
--- a/drivers/dsp/bridge/wmd/ue_deh.c
+++ b/drivers/dsp/bridge/wmd/ue_deh.c
@@ -67,6 +67,7 @@
 #include "_tiomap.h"
 #include "_deh.h"
 #include <_tiomap_mmu.h>
+#include <io_sm.h>

 static struct HW_MMUMapAttrs_t  mapAttrs = { HW_LITTLE_ENDIAN,
                                        HW_ELEM_SIZE_16BIT,
@@ -186,186 +187,6 @@ DSP_STATUS WMD_DEH_RegisterNotify(struct DEH_MGR *hDehMgr, u32 uEventMask,


 /*
- *  ======== PackTraceBuffer ========
- *      Removes extra nulls from the trace buffer returned from the DSP.
- *      Works even on buffers that already are packed (null removed); but has
- *      one bug in that case -- loses the last character (replaces with '\0').
- *      Continues through conversion for full set of nBytes input characters.
- *  Parameters:
- *    lpBuf:            Pointer to input/output buffer
- *    nBytes:           Number of characters in the buffer
- *    ulNumWords:       Number of DSP words in the buffer.  Indicates potential
- *                      number of extra carriage returns to generate.
- *  Returns:
- *      DSP_SOK:        Success.
- *      DSP_EMEMORY:    Unable to allocate memory.
- *  Requires:
- *      lpBuf must be a fully allocated writable block of at least nBytes.
- *      There are no more than ulNumWords extra characters needed (the number of
- *      linefeeds minus the number of NULLS in the input buffer).
- */
-#if ((defined DEBUG) || (defined DDSP_DEBUG_PRODUCT))\
-       && GT_TRACE
-static DSP_STATUS PackTraceBuffer(char *lpBuf, u32 nBytes, u32 ulNumWords)
-{
-       DSP_STATUS status = DSP_SOK;
-
-       char *lpTmpBuf;
-       char *lpBufStart;
-       char *lpTmpStart;
-       u32 nCnt;
-       char thisChar;
-
-       /* tmp workspace, 1 KB longer than input buf */
-       lpTmpBuf = MEM_Calloc((nBytes + ulNumWords), MEM_PAGED);
-       if (lpTmpBuf == NULL) {
-               DBG_Trace(DBG_LEVEL7, "PackTrace buffer:OutofMemory \n");
-               status = DSP_EMEMORY;
-       }
-
-       if (DSP_SUCCEEDED(status)) {
-               lpBufStart = lpBuf;
-               lpTmpStart = lpTmpBuf;
-               for (nCnt = nBytes; nCnt > 0; nCnt--) {
-                       thisChar = *lpBuf++;
-                       switch (thisChar) {
-                       case '\0':      /* Skip null bytes */
-                               break;
-                       case '\n':      /* Convert \n to \r\n */
-                               /* NOTE: do not reverse order; Some OS */
-                               /* editors control doesn't understand "\n\r" */
-                               *lpTmpBuf++ = '\r';
-                               *lpTmpBuf++ = '\n';
-                               break;
-                       default:        /* Copy in the actual ascii byte */
-                               *lpTmpBuf++ = thisChar;
-                               break;
-                       }
-               }
-               *lpTmpBuf = '\0';    /* Make sure tmp buf is null terminated */
-               /* Cut output down to input buf size */
-               strncpy(lpBufStart, lpTmpStart, nBytes);
-               /*Make sure output is null terminated */
-               lpBufStart[nBytes - 1] = '\0';
-               MEM_Free(lpTmpStart);
-       }
-
-       return status;
-}
-#endif    /* ((defined DEBUG) || (defined DDSP_DEBUG_PRODUCT)) && GT_TRACE */
-
-/*
- *  ======== PrintDspTraceBuffer ========
- *      Prints the trace buffer returned from the DSP (if DBG_Trace is enabled).
- *  Parameters:
- *    hDehMgr:          Handle to DEH manager object
- *                      number of extra carriage returns to generate.
- *  Returns:
- *      DSP_SOK:        Success.
- *      DSP_EMEMORY:    Unable to allocate memory.
- *  Requires:
- *      hDehMgr muse be valid. Checked in WMD_DEH_Notify.
- */
-DSP_STATUS PrintDspTraceBuffer(struct DEH_MGR *hDehMgr)
-{
-       DSP_STATUS status = DSP_SOK;
-
-#if ((defined DEBUG) || (defined DDSP_DEBUG_PRODUCT))\
-       && GT_TRACE
-
-       struct COD_MANAGER *hCodMgr;
-       u32 ulTraceEnd;
-       u32 ulTraceBegin;
-       u32 ulNumBytes = 0;
-       u32 ulNumWords = 0;
-       u32 ulWordSize = 2;
-       CONST u32 uMaxSize = 512;
-       char *pszBuf;
-       u16 *lpszBuf;
-       struct WMD_DRV_INTERFACE *pIntfFxns;
-       struct DEH_MGR *pDehMgr = (struct DEH_MGR *)hDehMgr;
-       struct DEV_OBJECT *hDevObject = ((struct WMD_DEV_CONTEXT *)
-                                       pDehMgr->hWmdContext)->hDevObject;
-
-       status = DEV_GetCodMgr(hDevObject, &hCodMgr);
-       if (DSP_FAILED(status)) {
-               DBG_Trace(DBG_LEVEL7,
-                        "PrintDspTraceBuffer: Failed on DEV_GetCodMgr.\n");
-       }
-
-       if (DSP_SUCCEEDED(status)) {
-               /* Look for SYS_PUTCBEG/SYS_PUTCEND: */
-               status = COD_GetSymValue(hCodMgr, COD_TRACEBEG, &ulTraceBegin);
-               DBG_Trace(DBG_LEVEL1,
-                        "PrintDspTraceBuffer: ulTraceBegin Value 0x%x\n",
-                        ulTraceBegin);
-               if (DSP_FAILED(status)) {
-                       DBG_Trace(DBG_LEVEL7, "PrintDspTraceBuffer: Failed on "
-                                "COD_GetSymValue.\n");
-               }
-       }
-       if (DSP_SUCCEEDED(status)) {
-               status = COD_GetSymValue(hCodMgr, COD_TRACEEND, &ulTraceEnd);
-               DBG_Trace(DBG_LEVEL1,
-                        "PrintDspTraceBuffer: ulTraceEnd Value 0x%x\n",
-                        ulTraceEnd);
-               if (DSP_FAILED(status)) {
-                       DBG_Trace(DBG_LEVEL7, "PrintDspTraceBuffer: Failed on "
-                                "COD_GetSymValue.\n");
-               }
-       }
-       if (DSP_SUCCEEDED(status)) {
-               ulNumBytes = (ulTraceEnd - ulTraceBegin) * ulWordSize;
-                /*  If the chip type is 55 then the addresses will be
-                *  byte addresses; convert them to word addresses.  */
-               if (ulNumBytes > uMaxSize)
-                       ulNumBytes = uMaxSize;
-
-               /* make sure the data we request fits evenly */
-               ulNumBytes = (ulNumBytes / ulWordSize) * ulWordSize;
-               DBG_Trace(DBG_LEVEL1, "PrintDspTraceBuffer: ulNumBytes 0x%x\n",
-                        ulNumBytes);
-               ulNumWords = ulNumBytes * ulWordSize;
-               DBG_Trace(DBG_LEVEL1, "PrintDspTraceBuffer: ulNumWords 0x%x\n",
-                        ulNumWords);
-               status = DEV_GetIntfFxns(hDevObject, &pIntfFxns);
-       }
-
-
-       if (DSP_SUCCEEDED(status)) {
-               pszBuf = MEM_Calloc(uMaxSize, MEM_NONPAGED);
-               lpszBuf = MEM_Calloc(ulNumBytes * 2, MEM_NONPAGED);
-               if (pszBuf != NULL) {
-                       /* Read bytes from the DSP trace buffer... */
-                       status = (*pIntfFxns->pfnBrdRead)(pDehMgr->hWmdContext,
-                                (u8 *)pszBuf, (u32)ulTraceBegin,
-                                ulNumBytes, 0);
-                       if (DSP_FAILED(status)) {
-                               DBG_Trace(DBG_LEVEL7, "PrintDspTraceBuffer: "
-                                        "Failed to Read Trace Buffer.\n");
-                       }
-                       if (DSP_SUCCEEDED(status)) {
-                               /* Pack and do newline conversion */
-                               DBG_Trace(DBG_LEVEL1, "PrintDspTraceBuffer: "
-                                        "before pack and unpack.\n");
-                               PackTraceBuffer(pszBuf, ulNumBytes, ulNumWords);
-                               DBG_Trace(DBG_LEVEL7, "DSP Trace Buffer:\n%s\n",
-                                        pszBuf);
-                       }
-                       MEM_Free(pszBuf);
-                       MEM_Free(lpszBuf);
-               } else {
-                       DBG_Trace(DBG_LEVEL7, "PrintDspTraceBuffer: Failed to "
-                                "allocate trace buffer.\n");
-                       status = DSP_EMEMORY;
-               }
-       }
-#endif
-       return status;
-}
-
-
-/*
  *  ======== WMD_DEH_Notify ========
  *      DEH error notification function. Informs user about the error.
  */
@@ -456,11 +277,6 @@ void WMD_DEH_Notify(struct DEH_MGR *hDehMgr, u32 ulEventMask,
                        /* Clear MMU interrupt */
                        HW_MMU_EventAck(resources.dwDmmuBase,
                                         HW_MMU_TRANSLATION_FAULT);
-                       DBG_Trace(DBG_LEVEL6,
-                                "***** PrintDspTraceBuffer: before\n");
-                       PrintDspTraceBuffer(hDehMgr);
-                       DBG_Trace(DBG_LEVEL6,
-                                "***** PrintDspTraceBuffer: after \n");
                        break;
                default:
                        DBG_Trace(DBG_LEVEL6,
@@ -468,6 +284,9 @@ void WMD_DEH_Notify(struct DEH_MGR *hDehMgr, u32 ulEventMask,
                                 "0x%x\n", dwErrInfo);
                        break;
                }
+               /* Call DSP Trace Buffer */
+               PrintDspTraceBuffer(hDehMgr->hWmdContext);
+
                /* Signal DSP error/exception event. */
                NTFY_Notify(pDehMgr->hNtfy, ulEventMask);
        }
@@ -503,4 +322,3 @@ DSP_STATUS WMD_DEH_GetInfo(struct DEH_MGR *hDehMgr,

        return status;
 }
-
--
1.5.5.4


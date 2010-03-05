From: "Ramos Falcon, Ernesto" <ernesto@ti.com>
Subject: PATCH] DSPBRIDGE: MMU-Fault debugging enhancements
Date: Thu, 4 Mar 2010 18:39:15 -0600
Message-ID: <B852767254C5C94EBB1040EE0EFA060091FBE92D@dlee01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:46442 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756389Ab0CEAjc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Mar 2010 19:39:32 -0500
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Ameya Palande <ameya.palande@nokia.com>, "Doyu Hiroshi (Nokia-D/Helsinki)" <hiroshi.doyu@nokia.com>, "Contreras Felipe (Nokia-D/Helsinki)" <felipe.contreras@nokia.com>

>From 1d7f5d634176be558d5a60e26ee2bdeddffd7d3b Mon Sep 17 00:00:00 2001
From: Cris Jansson <cjansson@ti.com>
Date: Thu, 25 Feb 2010 11:38:23 -0600
Subject: [PATCH] DSPBRIDGE: MMU-Fault debugging enhancements

These changes allow for DSP task information to be printed
by the MPU dspbridge when DSP MMU fault ocurrs.

Signed-off-by: Cris Jansson <cjansson@ti.com>
[change to open soutce coding style]
Signed-off-by: Ernesto Ramos <ernesto@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/dbll.h  |    3 +
 arch/arm/plat-omap/include/dspbridge/gh.h    |    3 +
 arch/arm/plat-omap/include/dspbridge/io_sm.h |    5 +
 arch/arm/plat-omap/include/dspbridge/nldr.h  |    3 +
 arch/arm/plat-omap/include/dspbridge/node.h  |   12 +
 drivers/dsp/bridge/Makefile                  |    1 +
 drivers/dsp/bridge/gen/gh.c                  |   22 ++
 drivers/dsp/bridge/pmgr/dbll.c               |   62 +++
 drivers/dsp/bridge/rmgr/nldr.c               |   71 ++++
 drivers/dsp/bridge/rmgr/node.c               |   31 ++
 drivers/dsp/bridge/wmd/io_sm.c               |  515 ++++++++++++++++++++------
 drivers/dsp/bridge/wmd/ue_deh.c              |   67 +++-
 12 files changed, 680 insertions(+), 115 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/dbll.h b/arch/arm/plat-omap/include/dspbridge/dbll.h
index 8c6eea7..3443f09 100644
--- a/arch/arm/plat-omap/include/dspbridge/dbll.h
+++ b/arch/arm/plat-omap/include/dspbridge/dbll.h
@@ -56,6 +56,9 @@
        extern DSP_STATUS DBLL_unloadSect(struct DBLL_LibraryObj *lib,
                                          char *sectName,
                                          struct DBLL_Attrs *attrs);
+       bool dbll_find_symbol(struct DBLL_LibraryObj *zl_lib, u32 address,
+               u32 offset_range, u32 *sym_addr_output, char *name_output);
+

 #endif                         /* DBLL_ */

diff --git a/arch/arm/plat-omap/include/dspbridge/gh.h b/arch/arm/plat-omap/include/dspbridge/gh.h
index 8bff0b4..c19c242 100644
--- a/arch/arm/plat-omap/include/dspbridge/gh.h
+++ b/arch/arm/plat-omap/include/dspbridge/gh.h
@@ -26,4 +26,7 @@ extern void GH_exit(void);
 extern void *GH_find(struct GH_THashTab *hashTab, void *key);
 extern void GH_init(void);
 extern void *GH_insert(struct GH_THashTab *hashTab, void *key, void *value);
+void gh_iterate(struct GH_THashTab *hash_tab,
+                       void (*callback)(void *, void *), void *user_data);
+
 #endif                         /* GH_ */
diff --git a/arch/arm/plat-omap/include/dspbridge/io_sm.h b/arch/arm/plat-omap/include/dspbridge/io_sm.h
index cc365ec..dfb431d 100644
--- a/arch/arm/plat-omap/include/dspbridge/io_sm.h
+++ b/arch/arm/plat-omap/include/dspbridge/io_sm.h
@@ -296,4 +296,9 @@
        extern DSP_STATUS PrintDspTraceBuffer(struct WMD_DEV_CONTEXT
                                                *hWmdContext);

+       DSP_STATUS dump_dsp_stack(struct WMD_DEV_CONTEXT *wmd_context);
+
+       void dump_dl_modules(struct WMD_DEV_CONTEXT *wmd_context);
+
+
 #endif                         /* IOSM_ */
diff --git a/arch/arm/plat-omap/include/dspbridge/nldr.h b/arch/arm/plat-omap/include/dspbridge/nldr.h
index 4f0639a..0f82a69 100644
--- a/arch/arm/plat-omap/include/dspbridge/nldr.h
+++ b/arch/arm/plat-omap/include/dspbridge/nldr.h
@@ -51,5 +51,8 @@
                                    enum NLDR_PHASE phase);
        extern DSP_STATUS NLDR_Unload(struct NLDR_NODEOBJECT *hNldrNode,
                                    enum NLDR_PHASE phase);
+       DSP_STATUS nldr_find_addr(
+                       struct NLDR_NODEOBJECT *nldr_node, u32 sym_addr,
+                       u32 offset_range, void *offset_output, char *sym_name);

 #endif                         /* NLDR_ */
diff --git a/arch/arm/plat-omap/include/dspbridge/node.h b/arch/arm/plat-omap/include/dspbridge/node.h
index 2a45fc0..0b2ed79 100644
--- a/arch/arm/plat-omap/include/dspbridge/node.h
+++ b/arch/arm/plat-omap/include/dspbridge/node.h
@@ -575,4 +575,16 @@
                                            OUT struct DSP_NDBPROPS
                                            *pNodeProps);

+
+/*
+ *     ======== node_find_addr ========
+ *     Purpose:
+ *             Find the closest symbol to the given address.
+ *     Parameters:
+ *
+ */
+       DSP_STATUS node_find_addr(struct NODE_MGR *node_mgr,
+                               u32 sym_addr, u32 offset_range,
+                               void *sym_addr_output, char *sym_name);
+
 #endif                         /* NODE_ */
diff --git a/drivers/dsp/bridge/Makefile b/drivers/dsp/bridge/Makefile
index 8ae4d21..ca6af08 100644
--- a/drivers/dsp/bridge/Makefile
+++ b/drivers/dsp/bridge/Makefile
@@ -35,5 +35,6 @@ ccflags-y += -Idrivers/dsp/bridge/services
 ccflags-y += -Idrivers/dsp/bridge/wmd
 ccflags-y += -Idrivers/dsp/bridge/pmgr
 ccflags-y += -Idrivers/dsp/bridge/rmgr
+ccflags-y += -Idrivers/dsp/bridge/dynload
 ccflags-y += -Idrivers/dsp/bridge/hw
 ccflags-y += -Iarch/arm
diff --git a/drivers/dsp/bridge/gen/gh.c b/drivers/dsp/bridge/gen/gh.c
index 252efaf..dd16144 100644
--- a/drivers/dsp/bridge/gen/gh.c
+++ b/drivers/dsp/bridge/gen/gh.c
@@ -184,3 +184,25 @@ static void myfree(void *ptr, s32 size)
 {
        GS_free(ptr);
 }
+
+
+/*
+ *  ======== gh_iterate ========
+ */
+void gh_iterate(struct GH_THashTab *hash_tab,
+                       void (*callback)(void *, void *), void *user_data)
+{
+       struct Elem *elem;
+       u32 i;
+
+       if (hash_tab && hash_tab->buckets)
+               for (i = 0; i < hash_tab->maxBucket; i++) {
+                       elem = hash_tab->buckets[i];
+                       while (elem) {
+                               callback(&elem->data, user_data);
+                               elem = elem->next;
+                       }
+               }
+}
+
+
diff --git a/drivers/dsp/bridge/pmgr/dbll.c b/drivers/dsp/bridge/pmgr/dbll.c
index e3f771c..2197506 100644
--- a/drivers/dsp/bridge/pmgr/dbll.c
+++ b/drivers/dsp/bridge/pmgr/dbll.c
@@ -1544,3 +1544,65 @@ static void release(struct Dynamic_Loader_Initialize *this)
 {
 }

+/*
+ *  ======== dbll_find_symbol ========
+ */
+struct find_symbol_context {
+       /* input */
+       u32 address;
+       u32 offset_range;
+       /* state */
+       u32 cur_best_offset;
+       /* output */
+       u32 sym_addr;
+       char name[120];
+};
+
+void find_symbol_callback(void *elem, void *user_data)
+{
+       struct Symbol *symbol = (struct Symbol *)elem;
+       struct find_symbol_context *context =
+                               (struct find_symbol_context *)user_data;
+       u32 symbol_addr = symbol->value.value;
+       u32 offset = context->address - symbol_addr;
+
+       /*
+        * Address given should be greater than symbol address,
+        * symbol address should be  within specified range
+        * and the offset should be better than previous one
+        */
+       if (context->address >= symbol_addr && symbol_addr < (u32)-1 &&
+               offset < context->cur_best_offset) {
+               context->cur_best_offset = offset;
+               context->sym_addr = symbol_addr;
+               strncpy(context->name, symbol->name, sizeof(context->name));
+       }
+
+       return;
+}
+
+
+bool dbll_find_symbol(struct DBLL_LibraryObj *zl_lib, u32 address,
+                               u32 offset_range, u32 *sym_addr_output,
+                               char *name_output)
+{
+       bool status = false;
+       struct find_symbol_context context;
+
+       context.address = address;
+       context.offset_range = offset_range;
+       context.cur_best_offset = offset_range;
+       context.sym_addr = 0;
+       context.name[0] = '\0';
+
+       gh_iterate(zl_lib->symTab, find_symbol_callback, &context);
+
+       if (context.name[0]) {
+               status = true;
+               strcpy(name_output, context.name);
+               *sym_addr_output = context.sym_addr;
+       }
+
+       return status;
+}
+
diff --git a/drivers/dsp/bridge/rmgr/nldr.c b/drivers/dsp/bridge/rmgr/nldr.c
index 1e9eb07..bbf80aa 100644
--- a/drivers/dsp/bridge/rmgr/nldr.c
+++ b/drivers/dsp/bridge/rmgr/nldr.c
@@ -1913,3 +1913,74 @@ static u32 findGcf(u32 a, u32 b)
        return b;
 }

+
+/*
+ *  ======== nldr_find_addr ========
+ */
+DSP_STATUS nldr_find_addr(struct NLDR_NODEOBJECT *nldr_node, u32 sym_addr,
+                       u32 offset_range, void *offset_output, char *sym_name)
+{
+       DSP_STATUS status = DSP_SOK;
+       bool status1 = false;
+       s32 i = 0;
+       struct LibNode root = { NULL, 0, NULL };
+       DBC_Require(cRefs > 0);
+       DBC_Require(MEM_IsValidHandle(nldr_node, NLDR_NODESIGNATURE));
+       DBC_Require(offset_output != NULL);
+       DBC_Require(sym_name != NULL);
+       pr_debug("%s(0x%x, 0x%x, 0x%x, 0x%x,  %s)\n", __func__, (u32) nldr_node,
+                       sym_addr, offset_range, (u32) offset_output, sym_name);
+
+       if (nldr_node->fDynamic && *nldr_node->pfPhaseSplit) {
+               switch (nldr_node->phase) {
+               case NLDR_CREATE:
+                       root = nldr_node->createLib;
+                       break;
+               case NLDR_EXECUTE:
+                       root = nldr_node->executeLib;
+                       break;
+               case NLDR_DELETE:
+                       root = nldr_node->deleteLib;
+                       break;
+               default:
+                       DBC_Assert(false);
+                       break;
+               }
+       } else {
+               /* for Overlay nodes or non-split Dynamic nodes */
+               root = nldr_node->root;
+       }
+
+       status1 = dbll_find_symbol(root.lib, sym_addr,
+                       offset_range, offset_output, sym_name);
+
+       /* If symbol not found, check dependent libraries */
+       if (!status1)
+               for (i = 0; i < root.nDepLibs; i++) {
+                       status1 = dbll_find_symbol(
+                               root.pDepLibs[i].lib, sym_addr,
+                               offset_range, offset_output, sym_name);
+                       if (status1)
+                               /* Symbol found */
+                               break;
+               }
+       /* Check persistent libraries */
+       if (!status1)
+               for (i = 0; i < nldr_node->nPersLib; i++) {
+                       status1 = dbll_find_symbol(
+                               nldr_node->persLib[i].lib, sym_addr,
+                               offset_range, offset_output, sym_name);
+                       if (status1)
+                               /* Symbol found */
+                               break;
+               }
+
+       if (status1 == false) {
+               pr_debug("%s: Address 0x%x not found in range %d.\n",
+                               __func__, sym_addr, offset_range);
+               status = DSP_ESYMBOL;
+       }
+
+       return status;
+}
+
diff --git a/drivers/dsp/bridge/rmgr/node.c b/drivers/dsp/bridge/rmgr/node.c
index 0c5bb33..e19f81a 100644
--- a/drivers/dsp/bridge/rmgr/node.c
+++ b/drivers/dsp/bridge/rmgr/node.c
@@ -3337,3 +3337,34 @@ static u32 Write(void *pPrivRef, u32 ulDspAddr, void *pBuf,
        return ulNumBytes;
 }

+
+/*
+ *  ======== node_find_addr ========
+ */
+DSP_STATUS node_find_addr(struct NODE_MGR *node_mgr, u32 sym_addr,
+                       u32 offset_range, void *sym_addr_output, char *sym_name)
+{
+       struct NODE_OBJECT *node_obj;
+       DSP_STATUS status = DSP_ENOTFOUND;
+       u32 n;
+
+       pr_debug("%s(0x%x, 0x%x, 0x%x, 0x%x,  %s)\n", __func__,
+                       (unsigned int) node_mgr,
+                       sym_addr, offset_range,
+                       (unsigned int) sym_addr_output, sym_name);
+
+       node_obj = (struct NODE_OBJECT *)(node_mgr->nodeList->head.next);
+
+       for (n = 0; n < node_mgr->uNumNodes; n++) {
+               status = nldr_find_addr(node_obj->hNldrNode, sym_addr,
+                               offset_range, sym_addr_output, sym_name);
+
+               if (DSP_SUCCEEDED(status))
+                       break;
+
+               node_obj = (struct NODE_OBJECT *) (node_obj->listElem.next);
+       }
+
+       return status;
+}
+
diff --git a/drivers/dsp/bridge/wmd/io_sm.c b/drivers/dsp/bridge/wmd/io_sm.c
index 7c712ed..b3b5560 100644
--- a/drivers/dsp/bridge/wmd/io_sm.c
+++ b/drivers/dsp/bridge/wmd/io_sm.c
@@ -62,6 +62,7 @@

 /* Platform Manager */
 #include <dspbridge/cod.h>
+#include <dspbridge/node.h>
 #include <dspbridge/dev.h>

 /* Others */
@@ -74,6 +75,7 @@
 #include <dspbridge/io_sm.h>
 #include "_msg_sm.h"
 #include <dspbridge/gt.h>
+#include "module_list.h"

 /* Defines, Data Structures, Typedefs */
 #define OUTPUTNOTREADY  0xffff
@@ -86,6 +88,11 @@

 #define MAX_PM_REQS 32

+#define MMU_FAULT_HEAD1 0xa5a5a5a5
+#define MMU_FAULT_HEAD2 0x96969696
+#define POLL_MAX 1000
+#define MAX_MMU_DBGBUFF 10240
+
 /* IO Manager: only one created per board */
 struct IO_MGR {
        /* These four fields must be the first fields in a IO_MGR_ struct */
@@ -955,9 +962,13 @@ void IO_DPC(IN OUT unsigned long pRefData)
                if ((pIOMgr->wIntrVal > DEH_BASE) &&
                   (pIOMgr->wIntrVal < DEH_LIMIT)) {
                        /* Notify DSP/BIOS exception */
-                       if (hDehMgr)
+                       if (hDehMgr) {
+#ifndef DSP_TRACEBUF_DISABLED
+                               PrintDSPDebugTrace(pIOMgr);
+#endif
                                WMD_DEH_Notify(hDehMgr, DSP_SYSERROR,
                                                pIOMgr->wIntrVal);
+                       }
                }
                IO_DispatchChnl(pIOMgr, NULL, IO_SERVICE);
 #ifdef CHNL_MESSAGES
@@ -1895,75 +1906,6 @@ void PrintDSPDebugTrace(struct IO_MGR *hIOMgr)
 #endif

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
-#if (defined(CONFIG_BRIDGE_DEBUG) || defined(DDSP_DEBUG_PRODUCT)) && GT_TRACE
-static DSP_STATUS PackTraceBuffer(char *lpBuf, u32 nBytes, u32 ulNumWords)
-{
-       DSP_STATUS status = DSP_SOK;
-       char *lpTmpBuf;
-       char *lpBufStart;
-       char *lpTmpStart;
-       u32 nCnt;
-       char thisChar;
-
-       /* Tmp workspace, 1 KB longer than input buf */
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
-                               /*
-                                * NOTE: do not reverse order; Some OS
-                                * editors control doesn't understand "\n\r"
-                                */
-                               *lpTmpBuf++ = '\r';
-                               *lpTmpBuf++ = '\n';
-                               break;
-                       default:         /* Copy in the actual ascii byte */
-                               *lpTmpBuf++ = thisChar;
-                               break;
-                       }
-               }
-               *lpTmpBuf = '\0';    /* Make sure tmp buf is null terminated */
-               /* Cut output down to input buf size */
-               strncpy(lpBufStart, lpTmpStart, nBytes);
-               /* Make sure output is null terminated */
-               lpBufStart[nBytes - 1] = '\0';
-               MEM_Free(lpTmpStart);
-       }
-
-       return status;
-}
-#endif    /* (defined(CONFIG_BRIDGE_DEBUG) || defined(DDSP_DEBUG_PRODUCT)) && GT_TRACE */
-
-/*
  *  ======== PrintDspTraceBuffer ========
  *      Prints the trace buffer returned from the DSP (if DBG_Trace is enabled).
  *  Parameters:
@@ -1986,9 +1928,11 @@ DSP_STATUS PrintDspTraceBuffer(struct WMD_DEV_CONTEXT *hWmdContext)
        u32 ulNumBytes = 0;
        u32 ulNumWords = 0;
        u32 ulWordSize = 2;
-       CONST u32 uMaxSize = 512;
        char *pszBuf;
-       u16 *lpszBuf;
+       char *str_beg;
+       char *buf_end;
+       char *new_line;
+

        struct WMD_DEV_CONTEXT *pWmdContext = (struct WMD_DEV_CONTEXT *)
                                                     hWmdContext;
@@ -2023,16 +1967,8 @@ DSP_STATUS PrintDspTraceBuffer(struct WMD_DEV_CONTEXT *hWmdContext)
                                "COD_GetSymValue.\n");
        }
        if (DSP_SUCCEEDED(status)) {
-               ulNumBytes = (ulTraceEnd - ulTraceBegin) * ulWordSize;
-               /*
-                * If the chip type is 55 then the addresses will be
-                * byte addresses; convert them to word addresses.
-                */
-               if (ulNumBytes > uMaxSize)
-                       ulNumBytes = uMaxSize;
+               ulNumBytes = (ulTraceEnd - ulTraceBegin);

-               /* Make sure the data we request fits evenly */
-               ulNumBytes = (ulNumBytes / ulWordSize) * ulWordSize;
                GT_1trace(dsp_trace_mask, GT_2CLASS, "PrintDspTraceBuffer: "
                        "ulNumBytes 0x%x\n", ulNumBytes);
                ulNumWords = ulNumBytes * ulWordSize;
@@ -2041,37 +1977,78 @@ DSP_STATUS PrintDspTraceBuffer(struct WMD_DEV_CONTEXT *hWmdContext)
                status = DEV_GetIntfFxns(pDevObject, &pIntfFxns);
        }

-       if (DSP_SUCCEEDED(status)) {
-               pszBuf = MEM_Calloc(uMaxSize, MEM_NONPAGED);
-               lpszBuf = MEM_Calloc(ulNumBytes * 2, MEM_NONPAGED);
-               if (pszBuf != NULL) {
-                       /* Read bytes from the DSP trace buffer... */
-                       status = (*pIntfFxns->pfnBrdRead)(hWmdContext,
-                               (u8 *)pszBuf, (u32)ulTraceBegin,
-                               ulNumBytes, 0);
-                       if (DSP_FAILED(status))
-                               GT_0trace(dsp_trace_mask, GT_2CLASS,
-                                       "PrintDspTraceBuffer: "
-                                       "Failed to Read Trace Buffer.\n");
-
-                       if (DSP_SUCCEEDED(status)) {
-                               /* Pack and do newline conversion */
-                               GT_0trace(dsp_trace_mask, GT_2CLASS,
-                                       "PrintDspTraceBuffer: "
-                                       "before pack and unpack.\n");
-                               PackTraceBuffer(pszBuf, ulNumBytes, ulNumWords);
-                               GT_1trace(dsp_trace_mask, GT_1CLASS,
-                                       "DSP Trace Buffer:\n%s\n", pszBuf);
+       if (DSP_FAILED(status))
+               goto func_end;
+
+       pszBuf = MEM_Calloc(ulNumBytes+2, MEM_NONPAGED);
+       if (pszBuf != NULL) {
+               /* Read bytes from the DSP trace buffer... */
+               status = (*pIntfFxns->pfnBrdRead)(hWmdContext,
+                       (u8 *)pszBuf, (u32)ulTraceBegin,
+                       ulNumBytes, 0);
+               if (DSP_FAILED(status))
+                       GT_0trace(dsp_trace_mask, GT_2CLASS,
+                               "PrintDspTraceBuffer: "
+                               "Failed to Read Trace Buffer.\n");
+
+               if (DSP_SUCCEEDED(status)) {
+                       /* Pack and do newline conversion */
+                       GT_0trace(dsp_trace_mask, GT_2CLASS,
+                               "PrintDspTraceBuffer: "
+                               "before pack and unpack.\n");
+                       pr_debug("%s: DSP Trace Buffer Begin:\n"
+                               "=======================\n%s\n",
+                               __func__, pszBuf);
+
+                       if (ulNumBytes) {
+                               /*
+                                * The buffer is not full, find the end of the
+                                * data -- buf_end will be >= pszBuf after
+                                * while.
+                                */
+                               buf_end = &pszBuf[ulNumBytes];
+                               while (*buf_end == '\0' && buf_end > pszBuf)
+                                       buf_end--;
+                               /* one past last char */
+                               buf_end++;
+
+                               /*
+                                * Search buffer for a new_line and replace it
+                                * with '\0', then print as string.
+                                * Continue until buffer is exhausted.
+                                */
+                               str_beg = pszBuf;
+                               ulNumBytes = buf_end - str_beg;
+
+                               while (str_beg < buf_end) {
+                                       new_line = strnchr(str_beg, ulNumBytes,
+                                                                       '\n');
+                                       if (new_line && new_line < buf_end) {
+                                               *new_line = 0;
+                                               pr_debug("%s\n", str_beg);
+                                               str_beg = ++new_line;
+                                               ulNumBytes = buf_end - str_beg;
+                                       } else {
+                                               str_beg[ulNumBytes] = 0;
+                                               pr_debug("%s\n", str_beg);
+                                               str_beg = buf_end;
+                                               ulNumBytes = 0;
+                                       }
+                               }
                        }
-                       MEM_Free(pszBuf);
-                       MEM_Free(lpszBuf);
-               } else {
-                         GT_0trace(dsp_trace_mask, GT_2CLASS,
-                               "PrintDspTraceBuffer: Failed to "
-                               "allocate trace buffer.\n");
-                         status = DSP_EMEMORY;
+
+                       pr_debug("\n=======================\n"
+                               "DSP Trace Buffer End:\n");
                }
+               MEM_Free(pszBuf);
+       } else {
+                 GT_0trace(dsp_trace_mask, GT_2CLASS,
+                       "PrintDspTraceBuffer: Failed to "
+                       "allocate trace buffer.\n");
+                 status = DSP_EMEMORY;
        }
+
+func_end:
 #endif
        return status;
 }
@@ -2080,3 +2057,323 @@ void IO_SM_init(void)
 {
        GT_create(&dsp_trace_mask, "DT"); /* DSP Trace Mask */
 }
+DSP_STATUS dump_dsp_stack(struct WMD_DEV_CONTEXT *wmd_context)
+{
+       DSP_STATUS status = DSP_SOK;
+
+       struct COD_MANAGER *code_mgr;
+       struct NODE_MGR *node_mgr;
+       u32 trace_begin;
+       char name[256];
+       struct {
+               u32 head[2];
+               u32 size;
+       } mmu_fault_dbg_info;
+       u32 *buffer;
+       u32 *buffer_end;
+       u32 exc_type;
+       u32 i;
+       u32 offset_output;
+       u32 total_size;
+       u32 poll_cnt;
+       const char *dsp_regs[] = {"EFR", "IERR", "ITSR", "NTSR",
+                               "IRP", "NRP", "AMR", "SSR",
+                               "ILC", "RILC", "IER", "CSR"};
+
+       struct WMD_DRV_INTERFACE *intf_fxns;
+       struct DEV_OBJECT *dev_object = wmd_context->hDevObject;
+
+       status = DEV_GetCodMgr(dev_object, &code_mgr);
+       if (DSP_FAILED(status))
+               pr_debug("%s: Failed on DEV_GetCodMgr.\n", __func__);
+
+       if (DSP_SUCCEEDED(status)) {
+               status = DEV_GetNodeManager(dev_object, &node_mgr);
+               if (DSP_FAILED(status))
+                       pr_debug("%s: Failed on DEV_GetNodeManager.\n",
+                                                               __func__);
+       }
+
+       if (DSP_SUCCEEDED(status)) {
+               /* Look for SYS_PUTCBEG/SYS_PUTCEND: */
+               status = COD_GetSymValue(code_mgr, COD_TRACEBEG, &trace_begin);
+               pr_debug("%s: trace_begin Value 0x%x\n",
+                       __func__, trace_begin);
+               if (DSP_FAILED(status))
+                       pr_debug("%s: Failed on COD_GetSymValue.\n", __func__);
+       }
+       if (DSP_SUCCEEDED(status))
+               status = DEV_GetIntfFxns(dev_object, &intf_fxns);
+
+       /* Check for the "magic number" in the trace buffer.  If it has   */
+       /* yet to appear then poll the trace buffer to wait for it.  Its  */
+       /* appearance signals that the DSP has finished dumping its state.*/
+       mmu_fault_dbg_info.head[0] = 0;
+       mmu_fault_dbg_info.head[1] = 0;
+       if (DSP_SUCCEEDED(status)) {
+               poll_cnt = 0;
+               while ((mmu_fault_dbg_info.head[0] != MMU_FAULT_HEAD1 ||
+                       mmu_fault_dbg_info.head[1] != MMU_FAULT_HEAD2) &&
+                       poll_cnt < POLL_MAX) {
+
+                       /* Read DSP dump size from the DSP trace buffer... */
+                       status = (*intf_fxns->pfnBrdRead)(wmd_context,
+                               (u8 *)&mmu_fault_dbg_info, (u32)trace_begin,
+                               sizeof(mmu_fault_dbg_info), 0);
+
+                       if (DSP_FAILED(status))
+                               break;
+
+                       poll_cnt++;
+               }
+
+               if (mmu_fault_dbg_info.head[0] != MMU_FAULT_HEAD1 &&
+                       mmu_fault_dbg_info.head[1] != MMU_FAULT_HEAD2) {
+                       status = DSP_ETIMEOUT;
+                       pr_err("%s:No DSP MMU-Fault information available.\n",
+                                                       __func__);
+               }
+       }
+
+       if (DSP_SUCCEEDED(status)) {
+               total_size = mmu_fault_dbg_info.size;
+               /* Limit the size in case DSP went crazy */
+               if (total_size > MAX_MMU_DBGBUFF)
+                       total_size = MAX_MMU_DBGBUFF;
+
+               buffer = MEM_Calloc(total_size, MEM_NONPAGED);
+               buffer_end =  buffer + total_size / 4;
+
+               if (!buffer) {
+                       status = DSP_EMEMORY;
+                       pr_debug("%s: Failed to "
+                               "allocate stack dump buffer.\n", __func__);
+                       goto func_end;
+               }
+
+               /* Read bytes from the DSP trace buffer... */
+               status = (*intf_fxns->pfnBrdRead)(wmd_context,
+                               (u8 *)buffer, (u32)trace_begin,
+                               total_size, 0);
+               if (DSP_FAILED(status)) {
+                       pr_debug("%s: Failed to Read Trace Buffer.\n",
+                                               __func__);
+                       goto func_end;
+               }
+
+               pr_err("Aproximate Crash Position:\n");
+               pr_err("--------------------------\n");
+
+               exc_type = buffer[3];
+               if (!exc_type)
+                       i = buffer[79];         /* IRP */
+               else
+                       i = buffer[80];         /* NRP */
+
+               if ((*buffer > 0x01000000) && (node_find_addr(node_mgr, i,
+                       0x1000, &offset_output, name) == DSP_SOK))
+                       pr_err("0x%-8x [\"%s\" + 0x%x]\n", i, name,
+                               i - offset_output);
+               else
+                       pr_err("0x%-8x [Unable to match to a symbol.]\n", i);
+
+
+               pr_err("Execution Info:\n");
+               pr_err("---------------\n");
+
+               for (i = 0; i < 32; i++) {
+                       if (i == 4 || i == 6 || i == 8)
+                               pr_err("A%d 0x%-8x [Function Argument %d]\n",
+                                               i, *buffer++, i-3);
+                       else if (i == 15)
+                               pr_err("A15 0x%-8x [Frame Pointer]\n",
+                                                       *buffer++);
+                       else
+                               pr_err("A%d 0x%x\n", i, *buffer++);
+               }
+
+               pr_err("\nB0 0x%x\n", *buffer++);
+               pr_err("B1 0x%x\n", *buffer++);
+               pr_err("B2 0x%x\n", *buffer++);
+
+               if ((*buffer > 0x01000000) && (node_find_addr(node_mgr, *buffer,
+                       0x1000, &offset_output, name) == DSP_SOK))
+
+                       pr_err("B3 0x%-8x [Function Return Pointer:"
+                               " \"%s\" + 0x%x]\n", *buffer, name,
+                               *buffer - offset_output);
+               else
+                       pr_err("B3 0x%-8x [Function Return Pointer:"
+                               "Unable to match to a symbol.]\n", *buffer);
+
+               buffer++;
+
+               for (i = 4; i < 32; i++) {
+                       if (i == 4 || i == 6 || i == 8)
+                               pr_err("B%d 0x%-8x [Function Argument %d]\n",
+                                               i, *buffer++, i-2);
+                       else if (i == 15)
+                               pr_err("B14 0x%-8x [Data Page Pointer]\n",
+                                                       *buffer++);
+                       else
+                               pr_err("B%d 0x%x\n", i, *buffer++);
+
+               }
+
+               for (i = 0; i < ARRAY_SIZE(dsp_regs); i++)
+                       pr_err("%s 0x%x\n", dsp_regs[i], *buffer++);
+
+               for (i = 0; buffer < buffer_end; i++, buffer++) {
+                       if ((*buffer > 0x01000000) && (node_find_addr(node_mgr,
+                               *buffer , 0x600, &offset_output, name) ==
+                               DSP_SOK))
+                               pr_err("[%d] 0x%-8x [\"%s\" + 0x%x]\n",
+                                       i, *buffer, name,
+                                       *buffer - offset_output);
+                       else
+                               pr_err("[%d] 0x%x\n", i, *buffer);
+               }
+
+               MEM_Free(buffer - total_size / 4);
+       }
+func_end:
+       return status;
+}
+
+
+
+void dump_dl_modules(struct WMD_DEV_CONTEXT *wmd_context)
+{
+       struct COD_MANAGER *code_mgr;
+       struct WMD_DRV_INTERFACE *intf_fxns;
+       struct WMD_DEV_CONTEXT *wmd_ctxt =
+                               (struct WMD_DEV_CONTEXT *) wmd_context;
+       struct DEV_OBJECT *dev_object =
+                               (struct DEV_OBJECT *) wmd_ctxt->hDevObject;
+
+       struct modules_header modules_hdr;
+       struct dll_module *module_struct = NULL;
+       u32 module_dsp_addr;
+       u32 module_size;
+       u32 module_struct_size = 0;
+       u32 sect_ndx;
+       char *sect_str ;
+       DSP_STATUS status = DSP_SOK;
+
+       status = DEV_GetIntfFxns(dev_object, &intf_fxns);
+       if (DSP_FAILED(status)) {
+               pr_debug("%s: Failed on DEV_GetIntfFxns.\n", __func__);
+               goto func_end;
+       }
+
+       status = DEV_GetCodMgr(dev_object, &code_mgr);
+       if (DSP_FAILED(status)) {
+               pr_debug("%s: Failed on DEV_GetCodMgr.\n", __func__);
+               goto func_end;
+       }
+
+       /* Lookup  the address of the modules_header structure */
+       status = COD_GetSymValue(code_mgr, "_DLModules", &module_dsp_addr);
+       if (DSP_FAILED(status)) {
+               pr_debug("%s: Failed on COD_GetSymValue for _DLModules.\n",
+                               __func__);
+               goto func_end;
+       }
+
+       pr_debug("%s: _DLModules at 0x%x\n", __func__, module_dsp_addr);
+
+       /* Copy the modules_header structure from DSP memory. */
+       status = (*intf_fxns->pfnBrdRead)(wmd_context, (u8 *) &modules_hdr,
+                               (u32) module_dsp_addr, sizeof(modules_hdr), 0);
+
+       if (DSP_FAILED(status)) {
+               pr_debug("%s: Failed failed to read modules header.\n",
+                       __func__);
+               goto func_end;
+       }
+
+       module_dsp_addr = modules_hdr.first_module;
+       module_size = modules_hdr.first_module_size;
+
+       pr_debug("%s: dll_module_header 0x%x %d\n", __func__, module_dsp_addr,
+                                                               module_size);
+
+       pr_err("%s: \nDynamically Loaded Modules:\n"
+               "---------------------------\n", __func__);
+
+       /* For each dll_module structure in the list... */
+       while (module_size) {
+
+               /*
+                * Allocate/re-allocate memory to hold the dll_module
+                * structure. The memory is re-allocated only if the existing
+                * allocation is too small.
+                */
+               if (module_size > module_struct_size) {
+
+                       MEM_Free(module_struct);
+
+                       module_struct = MEM_Calloc(module_size+128,
+                                                       MEM_NONPAGED);
+                       module_struct_size = module_size+128;
+                       pr_debug("%s: allocated module struct %p %d\n",
+                               __func__, module_struct, module_struct_size);
+                       if (!module_struct)
+                               goto func_end;
+               }
+               /* Copy the dll_module structure from DSP memory */
+               status = (*intf_fxns->pfnBrdRead)(wmd_context,
+                       (u8 *)module_struct, module_dsp_addr, module_size, 0);
+
+               if (DSP_FAILED(status)) {
+                       pr_debug(
+                       "%s: Failed to read dll_module stuct for 0x%x.\n",
+                       __func__, module_dsp_addr);
+                       break;
+               }
+
+               /* Update info regarding the _next_ module in the list. */
+               module_dsp_addr = module_struct->next_module;
+               module_size = module_struct->next_module_size;
+
+               pr_debug("%s: next module 0x%x %d, this module num sects %d\n",
+                       __func__, module_dsp_addr, module_size,
+                       module_struct->num_sects);
+
+               /*
+                * The section name strings start immedialty following
+                * the array of dll_sect structures.
+                */
+               sect_str = (char *) &module_struct->
+                                       sects[module_struct->num_sects];
+
+               pr_err("%s\n", sect_str);
+
+               /*
+                * Advance to the first section name string.
+                * Each string follows the one before.
+                */
+               sect_str += strlen(sect_str) + 1;
+
+               /* Access each dll_sect structure and its name string. */
+               for (sect_ndx = 0;
+                       sect_ndx < module_struct->num_sects; sect_ndx++) {
+                       pr_err("    Section: 0x%x ",
+                               module_struct->sects[sect_ndx].sect_load_adr);
+
+                       if (((u32) sect_str - (u32) module_struct) <
+                               module_struct_size) {
+                               pr_err("%s\n", sect_str);
+                               /* Each string follows the one before. */
+                               sect_str += strlen(sect_str)+1;
+                       } else {
+                               pr_err("<string error>\n");
+                               pr_debug("%s: section name sting address "
+                                       "is invalid %p\n", __func__, sect_str);
+                       }
+               }
+       }
+func_end:
+       MEM_Free(module_struct);
+
+}
diff --git a/drivers/dsp/bridge/wmd/ue_deh.c b/drivers/dsp/bridge/wmd/ue_deh.c
index c0ff956..d2fd403 100644
--- a/drivers/dsp/bridge/wmd/ue_deh.c
+++ b/drivers/dsp/bridge/wmd/ue_deh.c
@@ -53,12 +53,23 @@
 #include "_tiomap_pwr.h"
 #include <dspbridge/io_sm.h>

+#include <mach/dmtimer.h>
+
+/* GP Timer number to trigger interrupt for MMU-fault ISR on DSP */
+#define GPTIMER_FOR_DSP_MMU_FAULT      8
+/* Bit mask to enable overflow interrupt */
+#define GPTIMER_IRQ_OVERFLOW           2
+/* Max time to check for GP Timer IRQ */
+#define GPTIMER_IRQ_WAIT_MAX_CNT       1000
+
 static struct HW_MMUMapAttrs_t  mapAttrs = { HW_LITTLE_ENDIAN,
                                        HW_ELEM_SIZE_16BIT,
                                        HW_MMU_CPUES} ;
 #define VirtToPhys(x)       ((x) - PAGE_OFFSET + PHYS_OFFSET)

 static u32 dummyVaAddr;
+
+static         struct omap_dm_timer *timer;
 /*
  *  ======== WMD_DEH_Create ========
  *      Creates DEH manager object.
@@ -117,6 +128,8 @@ DSP_STATUS WMD_DEH_Create(OUT struct DEH_MGR **phDehMgr,
                WMD_DEH_Destroy((struct DEH_MGR *)pDehMgr);
                *phDehMgr = NULL;
        } else {
+               timer = omap_dm_timer_request_specific(
+                                       GPTIMER_FOR_DSP_MMU_FAULT);
                *phDehMgr = (struct DEH_MGR *)pDehMgr;
                DBG_Trace(DBG_LEVEL1, "ISR_IRQ Object 0x%x \n", pDehMgr);
        }
@@ -149,6 +162,8 @@ DSP_STATUS WMD_DEH_Destroy(struct DEH_MGR *hDehMgr)

                /* Deallocate the DEH manager object */
                MEM_FreeObject(pDehMgr);
+               /* The GPTimer is no longer needed */
+               omap_dm_timer_free(timer);
        }
        DBG_Trace(DBG_LEVEL1, "Exiting DEH_Destroy.\n");
        return status;
@@ -189,6 +204,7 @@ void WMD_DEH_Notify(struct DEH_MGR *hDehMgr, u32 ulEventMask,
        u32 memPhysical = 0;
        u32 HW_MMU_MAX_TLB_COUNT = 31;
        extern u32 faultAddr;
+       u32 cnt = 0;

        DBG_Trace(DBG_LEVEL1, "Entering WMD_DEH_Notify: 0x%x, 0x%x\n", pDehMgr,
                 ulEventMask);
@@ -207,6 +223,10 @@ void WMD_DEH_Notify(struct DEH_MGR *hDehMgr, u32 ulEventMask,
                        pDehMgr->errInfo.dwVal1 = dwErrInfo;
                        printk(KERN_ERR "WMD_DEH_Notify: DSP_SYSERROR, errInfo "
                                "= 0x%x\n", dwErrInfo);
+
+                       dump_dl_modules(pDevContext);
+                       dump_dsp_stack(pDevContext);
+
                        break;
                case DSP_MMUFAULT:
                        /* MMU fault routine should have set err info
@@ -222,11 +242,15 @@ void WMD_DEH_Notify(struct DEH_MGR *hDehMgr, u32 ulEventMask,
                                (unsigned int)pDehMgr->errInfo.dwVal2);
                        printk(KERN_INFO "WMD_DEH_Notify: DSP_MMUFAULT, fault "
                                "address = 0x%x\n", (unsigned int)faultAddr);
+
+                       PrintDspTraceBuffer(pDevContext);
+                       dump_dl_modules(pDevContext);
+
                        dummyVaAddr = (u32)MEM_Calloc(sizeof(char) * 0x1000,
                                        MEM_PAGED);
                        memPhysical  = VirtToPhys(PG_ALIGN_LOW((u32)dummyVaAddr,
                                                                PG_SIZE_4K));
-DBG_Trace(DBG_LEVEL6, "WMD_DEH_Notify: DSP_MMUFAULT, "
+                       DBG_Trace(DBG_LEVEL6, "WMD_DEH_Notify: DSP_MMUFAULT, "
                                 "mem Physical= 0x%x\n", memPhysical);
                        pDevContext = (struct WMD_DEV_CONTEXT *)
                                                pDehMgr->hWmdContext;
@@ -247,12 +271,45 @@ DBG_Trace(DBG_LEVEL6, "WMD_DEH_Notify: DSP_MMUFAULT, "
                                memPhysical, faultAddr, HW_PAGE_SIZE_4KB, 1,
                                &mapAttrs, HW_SET, HW_SET);

-                       /* send an interrupt to DSP */
-                       omap_mbox_msg_send(pDevContext->mbox,
-                                       MBX_DEH_CLASS | MBX_DEH_EMMU, NULL);
+                       /*
+                        * Send a GP Timer interrupt to DSP
+                        * The DSP expects a GP timer interrupt after an
+                        * MMU-Fault Request GPTimer
+                        */
+
+                       if (timer) {
+                               /* Enable overflow interrupt */
+                               omap_dm_timer_set_int_enable(timer,
+                                               GPTIMER_IRQ_OVERFLOW);
+                               /*
+                                * Set counter value to overflow counter after
+                                * one tick and start timer
+                                */
+                               omap_dm_timer_set_load_start(timer, 0,
+                                                       0xfffffffe);
+
+                               /* Wait 80us for timer to overflow */
+                               udelay(80);
+
+                               /* Check interrupt status and */
+                               /* wait for interrupt */
+                               cnt = 0;
+                               while (!(omap_dm_timer_read_status(timer) &
+                                       GPTIMER_IRQ_OVERFLOW)) {
+                                       if (cnt++ >=
+                                               GPTIMER_IRQ_WAIT_MAX_CNT) {
+                                               pr_err("%s: GPTimer interrupt"
+                                                       " failed\n", __func__);
+                                               break;
+                                       }
+                               }
+                       }
+
                        /* Clear MMU interrupt */
                        HW_MMU_EventAck(pDevContext->dwDSPMmuBase,
                                         HW_MMU_TRANSLATION_FAULT);
+
+                       dump_dsp_stack(hDehMgr->hWmdContext);
                        break;
 #ifdef CONFIG_BRIDGE_NTFY_PWRERR
                case DSP_PWRERROR:
@@ -285,8 +342,6 @@ DBG_Trace(DBG_LEVEL6, "WMD_DEH_Notify: DSP_MMUFAULT, "
                pDevContext->dwBrdState = BRD_ERROR;
                /* Disable all the clocks that were enabled by DSP */
                (void)DSP_PeripheralClocks_Disable(pDevContext, NULL);
-               /* Call DSP Trace Buffer */
-               PrintDspTraceBuffer(hDehMgr->hWmdContext);

        }
        DBG_Trace(DBG_LEVEL1, "Exiting WMD_DEH_Notify\n");
--
1.5.4.5


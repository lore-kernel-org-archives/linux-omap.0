From: "Ramirez Luna, Omar" <x00omar@ti.com>
Subject: [PATCH 02/07][GIT 3/4+] Fixing driver compilation warnings
Date: Mon, 4 Aug 2008 09:54:54 -0500
Message-ID: <27F9C60D11D683428E133F85D2BB4A530804B510@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from calf.ext.ti.com ([198.47.26.144]:33801 "EHLO calf.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758464AbYHDOzC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Aug 2008 10:55:02 -0400
Received: from dlep95.itg.ti.com ([157.170.170.107])
	by calf.ext.ti.com (8.13.7/8.13.7) with ESMTP id m74EsuP0000401
	for <linux-omap@vger.kernel.org>; Mon, 4 Aug 2008 09:55:01 -0500
Received: from dlee73.ent.ti.com (localhost [127.0.0.1])
	by dlep95.itg.ti.com (8.13.8/8.13.8) with ESMTP id m74EstVq024508
	for <linux-omap@vger.kernel.org>; Mon, 4 Aug 2008 09:54:55 -0500 (CDT)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Code cleanup minor changes to fix some compilation warnings.
        - Indent style changes
        - Fixed undefined LEAD3 compilation flag
        - Fixed ISO C90 forbids mixed declarations and code
        - Fixed unused variables
---

Index: omapkernel/drivers/dsp/dspbridge/mpu_driver/src/dynload/cload.c
===================================================================
--- omapkernel.orig/drivers/dsp/dspbridge/mpu_driver/src/dynload/cload.c        2008-07-29 23:52:26.000000000 -0500
+++ omapkernel/drivers/dsp/dspbridge/mpu_driver/src/dynload/cload.c     2008-07-29 23:52:46.000000000 -0500
@@ -41,12 +41,6 @@
 #if BITS_PER_AU > BITS_PER_BYTE
 static char *unpack_name(struct dload_state *dlthis, u32 soffset);
 #endif
-#if LEAD3
-static boolean chk_revision_mix(struct dload_state *dlthis, const char *sname);
-static boolean chk_memmodel_mix(struct dload_state *dlthis,
-               const struct doff_syment_t *sym, const struct dynload_symbol
-               *defSym, const char *sname);
-#endif

 static const char CINITNAME[] = { ".cinit" };
 static const char LOADER_DLLVIEW_ROOT[] = { "?DLModules?" };
@@ -832,13 +826,6 @@
                                        }
                                        val += delta;
                                }
-#if LEAD3
-                               if (is_data_scn_num(sp->secnn)) {
-                                       /* adjust for 16-bit data addresses */
-                                       delta >>= 1;
-                                       val >>= 1;
-                               }
-#endif
                                goto loop_itr;
                        }
                        /* This symbol is an absolute symbol */
@@ -847,28 +834,9 @@
                                struct dynload_symbol *symp;
                                symp = dlthis->mysym->Find_Matching_Symbol
                                                      (dlthis->mysym, sname);
-                               if (!symp) {
-#if LEAD3
-                                       /* This absolute symbol is not already
-                                        * defined. Check for revision clash
-                                        * before proceeding.           */
-                                       if (chk_revision_mix(dlthis, sname)) {
-                                               /* If revision IDs are mixed,
-                                                * return */
-                                               return;
-                                       }
-#endif
+                               if (!symp)
                                        goto loop_itr;
-                               }
                                /* This absolute symbol is already defined.  */
-#if LEAD3
-                               /* Check for memory model mixing */
-                               if (chk_memmodel_mix(dlthis, input_sym,
-                                   symp, sname)) {
-                                       /* If memory models are mixed, return */
-                                       return;
-                               }
-#endif
                                if (symp->value == input_sym->dn_value) {
                                        /* If symbol values are equal, continue
                                         * but don't add to the global symbol
@@ -1165,15 +1133,9 @@
                        s32 nip;
                        LDR_ADDR image_offset = 0;
                        /* set relocation info for this section */
-                       if (curr_sect < dlthis->allocated_secn_count) {
+                       if (curr_sect < dlthis->allocated_secn_count)
                                dlthis->delta_runaddr = sptr->ds_paddr;
-#if LEAD3
-                               if (is_data_scn(lptr)) {
-                                       /* word-addressed data */
-                                       dlthis->delta_runaddr >>= 1;
-                               }
-#endif
-                       } else {
+                       else {
                                lptr = DOFFSEC_IS_LDRSEC(sptr);
                                dlthis->delta_runaddr = 0;
                        }
@@ -1658,18 +1620,8 @@
        dbsec = dbmod->sects;
        for (curr_sect = dlthis->allocated_secn_count;
             curr_sect > 0; curr_sect -= 1) {
-#if LEAD3
-#define LEAD3_DATA_FLAG (3UL << 30)
-               if (is_data_scn(asecs)) {
-                       dbsec->sect_load_adr = asecs->load_addr >> 1;
-                       dbsec->sect_run_adr = (asecs->run_addr >> 1) |
-                                              LEAD3_DATA_FLAG;
-               } else
-#endif
-               {
-                       dbsec->sect_load_adr = asecs->load_addr;
-                       dbsec->sect_run_adr = asecs->run_addr;
-               }
+               dbsec->sect_load_adr = asecs->load_addr;
+               dbsec->sect_run_adr = asecs->run_addr;
                dbsec += 1;
                asecs += 1;
        }
@@ -1913,86 +1865,3 @@
        return dlthis->str_temp;
 }                              /* unpack_name */
 #endif
-
-#if LEAD3
-/*************************************************************************
- * Procedure chk_revision_mix
- *
- * Parameters:
- *  sname: Name of absolute symbol
- *
- * Effect:
- *  Given a symbol name, determine whether it reflects a CPU revision ID.
- *  If  it does, determine whether a different revision ID has already been
- *  defined.  If so, this would indicate that there is a CPU revision
- *  conflict, so produce an error and return TRUE.  Otherwise, there is no
- *  conflict,  return FALSE.
- ************************************************************************/
-static boolean chk_revision_mix(struct dload_state *dlthis, const char *sname)
-{
-       char *filename;
-       struct dynload_symbol *symp;
-#if BITS_PER_AU > BITS_PER_BYTE
-       filename = unpack_name(dlthis, 0);
-#else
-       filename = dlthis->str_head + BYTE_TO_HOST(0);
-#endif
-       if (DL_STRCMP(sname, TI_C55X_REV2) == 0) {
-               symp = dlthis->mysym->Find_Matching_Symbol(dlthis->mysym,
-                                                          TI_C55X_REV3);
-               if (symp) {
-                       DL_ERROR("CPU rev 3 required, but %s forbids rev 3",
-                                filename);
-                       return TRUE;
-               }
-       } else if (DL_STRCMP(sname, TI_C55X_REV3) == 0) {
-               symp = dlthis->mysym->Find_Matching_Symbol(dlthis->mysym,
-                                                       TI_C55X_REV2);
-               if (symp) {
-                       DL_ERROR("CPU rev 2 required, but %s forbids rev 2",
-                                filename);
-                       return TRUE;
-               }
-       }
-       return FALSE;
-}
-
-/************************************************************************
- * Procedure chk_memmodel_mix
- *
- * Parameters:
- *     sname: Name of absolute symbol
- *
- * Effect:
- *  Given an old memory model symbol definition and new memory model
- *  symbol definition, evaluate whether the memory models are equal.
- *  If they aren't, produce error message and return TRUE.
- *  If they are, return  FALSE.
- ************************************************************************/
-static boolean chk_memmodel_mix(struct dload_state *dlthis,
-                               const struct doff_syment_t *sym,
-                               const struct dynload_symbol *defSym,
-                               const char *sname)
-{
-       char *filename;
-       const char *mem_model_names[] = { "?", "small", "large", "?"/* 0-3 */
-                   "reserved", "?", "?", "?",  /* 4-7 */
-               "huge"          /*  8  */
-       };
-       if (DL_STRCMP(sname, TI_C55X_MEM_MODEL) == 0) {
-#if BITS_PER_AU > BITS_PER_BYTE
-               filename = unpack_name(dlthis, 0);
-#else
-               filename = dlthis->str_head + BYTE_TO_HOST(0);
-#endif
-               if (defSym->value != sym->dn_value) {
-                       dload_error(dlthis,
-                                   "%s is %s model, but CPU defines %s model",
-                                   filename, mem_model_names[sym->dn_value],
-                                   mem_model_names[defSym->value]);
-                       return TRUE;
-               }
-       }
-       return FALSE;
-}
-#endif
Index: omapkernel/drivers/dsp/dspbridge/mpu_driver/src/dynload/header.h
===================================================================
--- omapkernel.orig/drivers/dsp/dspbridge/mpu_driver/src/dynload/header.h       2008-07-29 23:44:28.000000000 -0500
+++ omapkernel/drivers/dsp/dspbridge/mpu_driver/src/dynload/header.h    2008-07-29 23:52:46.000000000 -0500
@@ -41,12 +41,6 @@
 #include "dload_internal.h"
 #include "reloc_table.h"

-#if LEAD3
-#define TI_C55X_REV2 "$TI_capability_requires_rev2"
-#define TI_C55X_REV3 "$TI_capability_requires_rev3"
-#define TI_C55X_MEM_MODEL "$TI_capability$C5500$MemoryModel"
-#endif
-
 /*
  * Plausibility limits
  *
Index: omapkernel/drivers/dsp/dspbridge/mpu_driver/src/dynload/reloc.c
===================================================================
--- omapkernel.orig/drivers/dsp/dspbridge/mpu_driver/src/dynload/reloc.c        2008-07-29 23:52:26.000000000 -0500
+++ omapkernel/drivers/dsp/dspbridge/mpu_driver/src/dynload/reloc.c     2008-07-29 23:52:46.000000000 -0500
@@ -21,14 +21,8 @@
 static const char BSSSYMBOL[] = {".bss"};
 #endif

-#if LEAD3
-#include "reloc_table_c5500.c"
-#elif LEAD
-#include "reloc_table_c5400.c"
-#elif TMS32060
+#if TMS32060
 #include "reloc_table_c6000.c"
-#elif TMS470
-#include "reloc_table_arm.c"
 #endif

 #if TMS32060
@@ -245,12 +239,10 @@
                fieldsz = RFV_WIDTH(reloc_action);
                if (fieldsz) {  /* field info from table */
                        offset = RFV_POSN(reloc_action);
-#if !LEAD3
                        if (TARGET_BIG_ENDIAN)
                                /* make sure r_vaddr is the lowest target
                                 * address containing bits */
                                rp->r_vaddr += RFV_BIGOFF(reloc_info);
-#endif
                } else {        /* field info from relocation op */
                        fieldsz = rp->r_fieldsz; offset = rp->r_offset;
                        if (TARGET_BIG_ENDIAN)
Index: omapkernel/drivers/dsp/dspbridge/mpu_driver/src/dynload/reloc_table.h
===================================================================
--- omapkernel.orig/drivers/dsp/dspbridge/mpu_driver/src/dynload/reloc_table.h  2008-07-29 23:44:28.000000000 -0500
+++ omapkernel/drivers/dsp/dspbridge/mpu_driver/src/dynload/reloc_table.h       2008-07-29 23:52:46.000000000 -0500
@@ -96,7 +96,7 @@
 #define RFV_STK(iii) (((iii) >> 6) & 0x3)
 #define RFV_ACCS(iii) ((iii) & 0x3)

-#if (TMS32060) || (TMS470) || (LEAD)
+#if (TMS32060)
 #define RFV_SCALE(iii) ((iii) >> 11)
 #define RFV_BIGOFF(iii) (((iii) >> 8) & 0x7)
 #else
Index: omapkernel/drivers/dsp/dspbridge/mpu_driver/src/rmgr/node.c
===================================================================
--- omapkernel.orig/drivers/dsp/dspbridge/mpu_driver/src/rmgr/node.c    2008-07-29 23:52:26.000000000 -0500
+++ omapkernel/drivers/dsp/dspbridge/mpu_driver/src/rmgr/node.c 2008-07-29 23:52:46.000000000 -0500
@@ -472,9 +472,8 @@
                if (pAttrIn) {
                        /* Check if pAttrIn->iPriority is within range */
                        if (pAttrIn->iPriority < hNodeMgr->nMinPri ||
-                          pAttrIn->iPriority > hNodeMgr->nMaxPri) {
+                          pAttrIn->iPriority > hNodeMgr->nMaxPri)
                                status = DSP_ERANGE;
-                       }
                }
        }
 func_cont:
@@ -615,9 +614,8 @@
                        if ((MaxInputs(pNode) > 0 && (pNode->inputs == NULL ||
                           ptaskArgs->strmInDef == NULL)) ||
                           (MaxOutputs(pNode) > 0 && (pNode->outputs == NULL ||
-                          ptaskArgs->strmOutDef == NULL))) {
+                          ptaskArgs->strmOutDef == NULL)))
                                status = DSP_EMEMORY;
-                       }
                }
        }
        if (DSP_SUCCEEDED(status) && (nodeType != NODE_DEVICE)) {
@@ -791,7 +789,7 @@
                                DRV_InsertProcContext(hDrvObject, &pPctxt);
                                if (pPctxt != NULL) {
                                        DRV_ProcUpdatestate(pPctxt,
-                                                          PROC_RES_ALLOCATED);
+                                                       PROC_RES_ALLOCATED);
                                        DRV_ProcSetPID(pPctxt, (s32) hProcess);
                                        pPctxt->hProcessor =
                                                 (DSP_HPROCESSOR)hProcessor;
@@ -805,7 +803,7 @@
                                        REG_DRV_OBJECT);
                if (DSP_SUCCEEDED(res_status)) {
                        DRV_GetProcContext(hProcess, hDrvObject, &pPctxt,
-                                       *phNode, 0);
+                                        *phNode, 0);
                        if (pPctxt != NULL) {
                                DRV_InsertNodeResElement(*phNode, &nodeRes,
                                                         pPctxt);
@@ -945,16 +943,12 @@
        } else {
                hNodeMgr = hNode->hNodeMgr;
                nodeType = NODE_GetType(hNode);
-               if (nodeType != NODE_TASK && nodeType != NODE_DAISSOCKET) {
+               if (nodeType != NODE_TASK && nodeType != NODE_DAISSOCKET)
                        status = DSP_ENODETYPE;
-               } else {
-                       if (nPriority < hNodeMgr->nMinPri ||
-                          nPriority > hNodeMgr->nMaxPri) {
+               else if (nPriority < hNodeMgr->nMinPri ||
+                               nPriority > hNodeMgr->nMaxPri)
                                status = DSP_ERANGE;
-                       }
-               }
        }
-
        if (!DSP_SUCCEEDED(status))
                goto func_end;

@@ -1028,17 +1022,15 @@
                if ((hNode1 != (struct NODE_OBJECT *) DSP_HGPPNODE &&
                   !MEM_IsValidHandle(hNode1, NODE_SIGNATURE)) ||
                   (hNode2 != (struct NODE_OBJECT *) DSP_HGPPNODE &&
-                  !MEM_IsValidHandle(hNode2, NODE_SIGNATURE))) {
+                  !MEM_IsValidHandle(hNode2, NODE_SIGNATURE)))
                        status = DSP_EHANDLE;
-               }
        }
        if (DSP_SUCCEEDED(status)) {
                /* The two nodes must be on the same processor */
                if (hNode1 != (struct NODE_OBJECT *)DSP_HGPPNODE &&
                   hNode2 != (struct NODE_OBJECT *)DSP_HGPPNODE &&
-                  hNode1->hNodeMgr != hNode2->hNodeMgr) {
+                  hNode1->hNodeMgr != hNode2->hNodeMgr)
                        status = DSP_EFAIL;
-               }
                /* Cannot connect a node to itself */
                if (hNode1 == hNode2)
                        status = DSP_EFAIL;
@@ -1052,9 +1044,8 @@
        /* Check stream indices ranges */
                if ((node1Type != NODE_GPP && node1Type != NODE_DEVICE &&
                   uStream1 >= MaxOutputs(hNode1)) || (node2Type != NODE_GPP &&
-                  node2Type != NODE_DEVICE && uStream2 >= MaxInputs(hNode2))) {
+                  node2Type != NODE_DEVICE && uStream2 >= MaxInputs(hNode2)))
                        status = DSP_EVALUE;
-               }
        }
        if (DSP_SUCCEEDED(status)) {
                /*
@@ -1068,9 +1059,8 @@
                 */
                if (node1Type == NODE_MESSAGE || node2Type == NODE_MESSAGE ||
                    (node1Type != NODE_TASK && node1Type != NODE_DAISSOCKET &&
-                    node2Type != NODE_TASK && node2Type != NODE_DAISSOCKET)) {
+                    node2Type != NODE_TASK && node2Type != NODE_DAISSOCKET))
                        status = DSP_EFAIL;
-               }
        }
        /*
         * Check stream mode. Default is STRMMODE_PROCCOPY.
@@ -1910,7 +1900,7 @@
  *  Purpose:
  *      Frees the message buffer.
  */
-extern DSP_STATUS NODE_FreeMsgBuf(struct NODE_OBJECT *hNode, IN u8 *pBuffer,
+DSP_STATUS NODE_FreeMsgBuf(struct NODE_OBJECT *hNode, IN u8 *pBuffer,
                                 OPTIONAL struct DSP_BUFFERATTR *pAttr)
 {
        struct NODE_OBJECT *pNode = (struct NODE_OBJECT *)hNode;
@@ -1984,9 +1974,8 @@
                        pAttr->inNodeAttrIn.uTimeout = hNode->uTimeout;
                        pAttr->inNodeAttrIn.uHeapSize =
                                hNode->createArgs.asa.taskArgs.uHeapSize;
-                       pAttr->inNodeAttrIn.pGPPVirtAddr =
-                               (void *)hNode->createArgs.asa.taskArgs.
-                                       uGPPHeapAddr;
+                       pAttr->inNodeAttrIn.pGPPVirtAddr = (void *)
+                               hNode->createArgs.asa.taskArgs.uGPPHeapAddr;
                        pAttr->uInputs = hNode->uNumGPPInputs;
                        pAttr->uOutputs = hNode->uNumGPPOutputs;
                        /* DSP_NODEINFO */
@@ -2343,15 +2332,14 @@
        GT_3trace(NODE_debugMask, GT_ENTER,
                 "NODE_PutMessage: hNode: 0x%x\tpMsg: "
                 "0x%x\tuTimeout: 0x%x\n", hNode, pMsg, uTimeout);
-       if (!MEM_IsValidHandle(hNode, NODE_SIGNATURE)) {
+       if (!MEM_IsValidHandle(hNode, NODE_SIGNATURE))
                status = DSP_EHANDLE;
-       } else {
+       else {
                hNodeMgr = hNode->hNodeMgr;
                nodeType = NODE_GetType(hNode);
                if (nodeType != NODE_MESSAGE && nodeType != NODE_TASK &&
-                   nodeType != NODE_DAISSOCKET) {
+                   nodeType != NODE_DAISSOCKET)
                        status = DSP_ENODETYPE;
-               }
        }
        if (DSP_SUCCEEDED(status)) {
                /*  Check node state. Can't send messages to a node after
@@ -2436,9 +2424,9 @@
        } else {
                /* Check if event mask is a valid node related event */
                if (uEventMask & ~(DSP_NODESTATECHANGE |
-                  DSP_NODEMESSAGEREADY)) {
+                  DSP_NODEMESSAGEREADY))
                        status = DSP_EVALUE;
-               }
+
                /* Check if notify type is valid */
                if (uNotifyType != DSP_SIGNALEVENT)
                        status = DSP_EVALUE;
@@ -2446,9 +2434,8 @@
                /* Only one Notification can be registered at a
                 * time - Limitation */
                if (uEventMask == (DSP_NODESTATECHANGE |
-                  DSP_NODEMESSAGEREADY)) {
+                  DSP_NODEMESSAGEREADY))
                        status = DSP_EVALUE;
-               }
        }
        if (DSP_SUCCEEDED(status)) {
                if (uEventMask == DSP_NODESTATECHANGE) {
@@ -2605,14 +2592,13 @@
        if (DSP_SUCCEEDED(status)) {
                hNodeMgr = hNode->hNodeMgr;

-               if (!MEM_IsValidHandle(hNode, NODE_SIGNATURE)) {
+               if (!MEM_IsValidHandle(hNode, NODE_SIGNATURE))
                        status = DSP_EHANDLE;
-               } else {
+               else {
                        nodeType = NODE_GetType(hNode);
                        if (nodeType != NODE_TASK && nodeType !=
-                          NODE_DAISSOCKET) {
+                          NODE_DAISSOCKET)
                                status = DSP_ENODETYPE;
-                       }
                }
        }
        if (DSP_SUCCEEDED(status)) {
@@ -2856,10 +2842,10 @@
                /* Remove any elements remaining in lists */
                if (hNodeMgr->nodeList) {
                        while ((hNode =
-                             (struct NODE_OBJECT *)LST_GetHead(hNodeMgr->
-                             nodeList))) {
-                               DeleteNode(hNode);
-                       }
+                               (struct NODE_OBJECT *)LST_GetHead(hNodeMgr->
+                               nodeList)))
+                                       DeleteNode(hNode);
+
                        DBC_Assert(LST_IsEmpty(hNodeMgr->nodeList));
                        LST_Delete(hNodeMgr->nodeList);
                }
@@ -2914,54 +2900,54 @@
                             u32 uStream1, u32 uStream2)
 {
        u32 uStrmIndex;
-    struct DSP_STREAMCONNECT *pStrm1;
-    struct DSP_STREAMCONNECT *pStrm2;
-    enum NODE_TYPE node1Type = NODE_TASK;
-    enum NODE_TYPE node2Type = NODE_TASK;
-
-    node1Type = NODE_GetType(hNode1);
-    node2Type = NODE_GetType(hNode2);
-    if (hNode1 != (struct NODE_OBJECT *)DSP_HGPPNODE) {
+       struct DSP_STREAMCONNECT *pStrm1 = NULL;
+       struct DSP_STREAMCONNECT *pStrm2 = NULL;
+       enum NODE_TYPE node1Type = NODE_TASK;
+       enum NODE_TYPE node2Type = NODE_TASK;
+
+       node1Type = NODE_GetType(hNode1);
+       node2Type = NODE_GetType(hNode2);
+       if (hNode1 != (struct NODE_OBJECT *)DSP_HGPPNODE) {
+
                if (node1Type != NODE_DEVICE) {
                        uStrmIndex = hNode1->uNumInputs +
                                     hNode1->uNumOutputs - 1;
-           pStrm1 = &(hNode1->streamConnect[uStrmIndex]);
-           pStrm1->cbStruct = sizeof(struct DSP_STREAMCONNECT);
-           pStrm1->uThisNodeStreamIndex = uStream1;
-       }
-       if (hNode2 != (struct NODE_OBJECT *)DSP_HGPPNODE) {
-                       /* NODE == > NODE */
+                       pStrm1 = &(hNode1->streamConnect[uStrmIndex]);
+                       pStrm1->cbStruct = sizeof(struct DSP_STREAMCONNECT);
+                       pStrm1->uThisNodeStreamIndex = uStream1;
+               }
+
+               if (hNode2 != (struct NODE_OBJECT *)DSP_HGPPNODE) {
+                               /* NODE == > NODE */
                        if (node1Type != NODE_DEVICE) {
                                pStrm1->hConnectedNode = hNode2;
-               pStrm1->uiConnectedNodeID = hNode2->nodeId;
-               pStrm1->uConnectedNodeStreamIndex = uStream2;
-               pStrm1->lType = CONNECTTYPE_NODEOUTPUT;
+                               pStrm1->uiConnectedNodeID = hNode2->nodeId;
+                               pStrm1->uConnectedNodeStreamIndex = uStream2;
+                               pStrm1->lType = CONNECTTYPE_NODEOUTPUT;
                        }
                        if (node2Type != NODE_DEVICE) {
                                uStrmIndex = hNode2->uNumInputs +
-                                            hNode2->uNumOutputs - 1;
-               pStrm2 = &(hNode2->streamConnect[uStrmIndex]);
-               pStrm2->cbStruct = sizeof(struct DSP_STREAMCONNECT);
-               pStrm2->uThisNodeStreamIndex = uStream2;
-               pStrm2->hConnectedNode = hNode1;
-               pStrm2->uiConnectedNodeID = hNode1->nodeId;
-               pStrm2->uConnectedNodeStreamIndex = uStream1;
-               pStrm2->lType = CONNECTTYPE_NODEINPUT;
+                                               hNode2->uNumOutputs - 1;
+                               pStrm2 = &(hNode2->streamConnect[uStrmIndex]);
+                               pStrm2->cbStruct =
+                                       sizeof(struct DSP_STREAMCONNECT);
+                               pStrm2->uThisNodeStreamIndex = uStream2;
+                               pStrm2->hConnectedNode = hNode1;
+                               pStrm2->uiConnectedNodeID = hNode1->nodeId;
+                               pStrm2->uConnectedNodeStreamIndex = uStream1;
+                               pStrm2->lType = CONNECTTYPE_NODEINPUT;
                        }
-       } else {
-                       /* NODE == > GPP */
-                       if (node1Type != NODE_DEVICE)
+               } else if (node1Type != NODE_DEVICE)
                                pStrm1->lType = CONNECTTYPE_GPPOUTPUT;
-       }
-    } else {
+       } else {
                /* GPP == > NODE */
                DBC_Assert(hNode2 != (struct NODE_OBJECT *)DSP_HGPPNODE);
-       uStrmIndex = hNode2->uNumInputs + hNode2->uNumOutputs - 1;
-       pStrm2 = &(hNode2->streamConnect[uStrmIndex]);
-       pStrm2->cbStruct = sizeof(struct DSP_STREAMCONNECT);
-       pStrm2->uThisNodeStreamIndex = uStream2;
-       pStrm2->lType = CONNECTTYPE_GPPINPUT;
-    }
+               uStrmIndex = hNode2->uNumInputs + hNode2->uNumOutputs - 1;
+               pStrm2 = &(hNode2->streamConnect[uStrmIndex]);
+               pStrm2->cbStruct = sizeof(struct DSP_STREAMCONNECT);
+               pStrm2->uThisNodeStreamIndex = uStream2;
+               pStrm2->lType = CONNECTTYPE_GPPINPUT;
+       }
 }

 /*
@@ -3253,12 +3239,11 @@
                dcdNodeProps.pstrIAlgName = NULL;

                status = DCD_GetObjectDef(hNodeMgr->hDcdMgr,
-                       (CONST struct DSP_UUID *) pNodeId, DSP_DCDNODETYPE,
-                       (struct DCD_GENERICOBJ *) &dcdNodeProps);
-
+                               (CONST struct DSP_UUID *) pNodeId,
+                               DSP_DCDNODETYPE,
+                               (struct DCD_GENERICOBJ *) &dcdNodeProps);
                if (DSP_SUCCEEDED(status)) {
                        *pNodeProps = dcdNodeProps.ndbProps;
-
                        if (dcdNodeProps.pstrCreatePhaseFxn)
                                MEM_Free(dcdNodeProps.pstrCreatePhaseFxn);

@@ -3271,7 +3256,6 @@
                        if (dcdNodeProps.pstrIAlgName)
                                MEM_Free(dcdNodeProps.pstrIAlgName);
                }
-
        }

        return status;
Index: omapkernel/drivers/dsp/dspbridge/mpu_driver/src/wmd/3430/tiomap.c
===================================================================
--- omapkernel.orig/drivers/dsp/dspbridge/mpu_driver/src/wmd/3430/tiomap.c      2008-07-29 23:52:26.000000000 -0500
+++ omapkernel/drivers/dsp/dspbridge/mpu_driver/src/wmd/3430/tiomap.c   2008-07-29 23:52:46.000000000 -0500
@@ -1318,7 +1318,9 @@
        struct HW_MMUMapAttrs_t hwAttrs;
        u32 numOfActualTabEntries;
        u32 temp = 0;
-       u32 *pPhysAddrPageTbl;
+       u32 *pPhysAddrPageTbl = NULL;
+       struct vm_area_struct *vma;
+       struct mm_struct *mm = current->mm;

        DBG_Trace(DBG_ENTER, "> WMD_BRD_MemMap hDevContext %x, pa %x, va %x, "
                 "size %x, ulMapAttr %x\n", hDevContext, ulMpuAddr, ulVirtAddr,
@@ -1376,8 +1378,6 @@
                goto func_cont;
        }

-       struct vm_area_struct *vma;
-       struct mm_struct *mm = current->mm;
        /* Important Note: ulMpuAddr is mapped from user application process
         * to current process - it must lie completely within the current
         * virtual memory address space in order to be of use to us here!  */
@@ -1415,10 +1415,10 @@
        status = TIOMAP_VirtToPhysical(mm, ulMpuAddr, ulNumBytes,
                                &numOfActualTabEntries, pPhysAddrPageTbl);
        if (DSP_FAILED(status)) {
-                       DBG_Trace(DBG_LEVEL7,
-                                "WMD_BRD_MemMap: TIOMAP_VirtToPhysical",
-                                " failed\n");
-                       return DSP_EFAIL;
+               DBG_Trace(DBG_LEVEL7,
+                        "WMD_BRD_MemMap: TIOMAP_VirtToPhysical",
+                        " failed\n");
+               return DSP_EFAIL;
        }
        temp = 0;
        DBG_Trace(DBG_LEVEL4, "WMD_BRD_MemMap: numOfActualTabEntries=%d, "
@@ -1613,7 +1613,8 @@

        DBG_Trace(DBG_ENTER, "TIOMAP_VirtToPhysical: START:ulMpuAddr=%x, "
                  "ulNumBytes=%x\n", ulMpuAddr, ulNumBytes);
-
+       if (physicalAddrTable == NULL)
+               return DSP_EMEMORY;
        while (ulNumBytes) {
                DBG_Trace(DBG_LEVEL4, "TIOMAP_VirtToPhysical:Read the next PGD "
                          "and PMD entry\n");
@@ -1970,6 +1971,13 @@
        struct WMD_DEV_CONTEXT *pDevContext = hDevContext;
        struct HW_MMUMapAttrs_t hwAttrs;
        struct page *pPage[1];
+       u32 i;
+       u32 paCurr;
+       u32 paNext;
+       u32 vaCurr;
+       u32 sizeCurr;
+       u32 numPages;
+
        DBG_Trace(DBG_ENTER, "> MemMapVmalloc hDevContext %x, pa %x, va %x, "
                  "size %x, ulMapAttr %x\n", hDevContext, ulMpuAddr,
                  ulVirtAddr, ulNumBytes, ulMapAttr);
@@ -2006,12 +2014,7 @@
         /* Do Kernel va to pa translation.
         * Combine physically contiguous regions to reduce TLBs.
         * Pass the translated pa to PteUpdate.  */
-       u32 i;
-       u32 paCurr;
-       u32 paNext;
-       u32 vaCurr;
-       u32 sizeCurr;
-       u32 numPages = ulNumBytes / PAGE_SIZE; /* PAGE_SIZE = OS page size */
+       numPages = ulNumBytes / PAGE_SIZE; /* PAGE_SIZE = OS page size */
        if (!DSP_SUCCEEDED(status))
                goto func_cont;

Index: omapkernel/drivers/dsp/dspbridge/mpu_driver/src/wmd/3430/tiomap_pwr.c
===================================================================
--- omapkernel.orig/drivers/dsp/dspbridge/mpu_driver/src/wmd/3430/tiomap_pwr.c  2008-07-29 23:52:26.000000000 -0500
+++ omapkernel/drivers/dsp/dspbridge/mpu_driver/src/wmd/3430/tiomap_pwr.c       2008-07-29 23:52:46.000000000 -0500
@@ -106,10 +106,9 @@
                         "handle_constraints_set: Constraint set failed\n");
                return DSP_EFAIL;
        }
-#else
-       return DSP_SOK;
 #endif /*#ifndef DISABLE_BRIDGE_DVFS*/
 #endif /*#ifndef DISABLE_BRIDGE_PM*/
+       return DSP_SOK;
 }

 /*
@@ -456,10 +455,9 @@
                          " state in wrong state");
                return DSP_EFAIL;
        }
-#else
-       return DSP_SOK;
- #endif /*#ifndef DISABLE_BRIDGE_DVFS*/
+#endif /*#ifndef DISABLE_BRIDGE_DVFS*/
 #endif  /*#ifndef DISABLE_BRIDGE_PM */
+       return DSP_SOK;
 }

 /*
@@ -507,10 +505,9 @@
                          "in wrong state");
                return DSP_EFAIL;
        }
-#else
-       return DSP_SOK;
 #endif /*#ifndef DISABLE_BRIDGE_DVFS*/
 #endif /*#ifndef DISABLE_BRIDGE_PM*/
+       return DSP_SOK;
 }

 /*
Index: omapkernel/drivers/dsp/dspbridge/mpu_driver/src/wmd/tiomap_io.c
===================================================================
--- omapkernel.orig/drivers/dsp/dspbridge/mpu_driver/src/wmd/tiomap_io.c        2008-07-29 23:52:26.000000000 -0500
+++ omapkernel/drivers/dsp/dspbridge/mpu_driver/src/wmd/tiomap_io.c     2008-07-29 23:52:46.000000000 -0500
@@ -268,7 +268,7 @@
                          u32 ulMemType, BOOL bDynamicLoad)
 {
        u32 dwBaseAddr = pDevContext->dwDspExtBaseAddr;
-       u32 dwOffset;
+       u32 dwOffset = 0;
        u8 bTempByte1, bTempByte2;
        u8 remainByte[4];
        s32 i;
Index: omapkernel/drivers/dsp/dspbridge/mpu_driver/src/wmd/tiomap_sm.c
===================================================================
--- omapkernel.orig/drivers/dsp/dspbridge/mpu_driver/src/wmd/tiomap_sm.c        2008-07-29 23:44:28.000000000 -0500
+++ omapkernel/drivers/dsp/dspbridge/mpu_driver/src/wmd/tiomap_sm.c     2008-07-29 23:52:46.000000000 -0500
@@ -185,7 +185,11 @@
 #ifndef DEBUG
        u32 usCount = LOOP_COUNT;
 #endif
+#ifndef DISABLE_BRIDGE_PM
+#ifndef DISABLE_BRIDGE_DVFS
        u32 opplevel;
+#endif
+#endif
        HW_STATUS hwStatus;
        u32 mbxFull;
        struct CFG_HOSTRES resources;
Index: omapkernel/drivers/dsp/dspbridge/mpu_driver/src/wmd/ue_deh.c
===================================================================
--- omapkernel.orig/drivers/dsp/dspbridge/mpu_driver/src/wmd/ue_deh.c   2008-07-29 23:52:26.000000000 -0500
+++ omapkernel/drivers/dsp/dspbridge/mpu_driver/src/wmd/ue_deh.c        2008-07-29 23:52:46.000000000 -0500
@@ -435,6 +435,8 @@
                        memPhysical  = VirtToPhys(dummyVaAddr);
                        DBG_Trace(DBG_LEVEL6, "WMD_DEH_Notify: DSP_MMUFAULT, "
                                 "mem Physical= 0x%x\n", memPhysical);
+                       pDevContext = (struct WMD_DEV_CONTEXT *)
+                                               pDehMgr->hWmdContext;
                        /* Reset the dynamic mmu index to fixed count if it
                         * exceeds 31. So that the dynmmuindex is always
                         * between the range of standard/fixed entries
Index: omapkernel/drivers/dsp/dspbridge/mpu_driver/src/wmd/wmdchnl/io_sm.c
===================================================================
--- omapkernel.orig/drivers/dsp/dspbridge/mpu_driver/src/wmd/wmdchnl/io_sm.c    2008-07-29 23:52:26.000000000 -0500
+++ omapkernel/drivers/dsp/dspbridge/mpu_driver/src/wmd/wmdchnl/io_sm.c 2008-07-29 23:52:46.000000000 -0500
@@ -415,11 +415,11 @@
        u32 ulMsgLimit;
        u32 ulMsgLength = -1;
        u32 ulExtEnd;
-       u32 ulGppPa;
+       u32 ulGppPa = 0;
        u32 ulGppVa = 0;
-       u32 ulDspVa;
-       u32 ulSegSize;
-       u32 ulPadSize;
+       u32 ulDspVa = 0;
+       u32 ulSegSize = 0;
+       u32 ulPadSize = 0;
        u32 i;
        DSP_STATUS status = DSP_SOK;
        u32 uNumProcs = 0;
@@ -431,6 +431,13 @@
        u32 ulShm0End;
        u32 ulDynExtBase;
        u32 ulSeg1Size;
+       u32 paCurr = 0;
+       u32 vaCurr = 0;
+       u32 gppVaCurr = 0;
+       u32 numBytes = 0;
+       u32 allBits = 0;
+       u32 pgSize[] = { HW_PAGE_SIZE_16MB, HW_PAGE_SIZE_1MB,
+                          HW_PAGE_SIZE_64KB, HW_PAGE_SIZE_4KB };

        status = DEV_GetCodMgr(hIOMgr->hDevObject, &hCodMan);
        DBC_Assert(DSP_SUCCEEDED(status));
@@ -566,13 +573,11 @@
        if (!DSP_SUCCEEDED(status))
                goto func_cont;

-       u32 paCurr = ulGppPa;
-       u32 vaCurr = ulDynExtBase * hIOMgr->uWordSize;
-       u32 gppVaCurr = ulGppVa;
-       u32 numBytes = ulSeg1Size;
-       u32 allBits;
-       u32 pgSize[] = { HW_PAGE_SIZE_16MB, HW_PAGE_SIZE_1MB,
-                          HW_PAGE_SIZE_64KB, HW_PAGE_SIZE_4KB };
+       paCurr = ulGppPa;
+       vaCurr = ulDynExtBase * hIOMgr->uWordSize;
+       gppVaCurr = ulGppVa;
+       numBytes = ulSeg1Size;
+
        /*
         * Try to fit into TLB entries. If not possible, push them to page
         * tables. It is quite possible that if sections are not on
@@ -1747,10 +1752,10 @@
 DSP_STATUS IO_SHMsetting(IN struct IO_MGR *hIOMgr, IN enum SHM_DESCTYPE desc,
                         IN void *pArgs)
 {
-       u32 i;
-
 #ifndef DISABLE_BRIDGE_PM
 #ifndef DISABLE_BRIDGE_DVFS
+       u32 i;
+
        switch (desc) {
        case SHM_CURROPP:
                /* Update the shared memory with requested OPP information */

---

Regards,

omar

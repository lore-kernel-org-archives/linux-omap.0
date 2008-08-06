From: "Ramirez Luna, Omar" <x00omar@ti.com>
Subject: [PATCH][GIT 3/4+] Remove build warnings from dspbridge code
Date: Wed, 6 Aug 2008 11:26:10 -0500
Message-ID: <27F9C60D11D683428E133F85D2BB4A53081F1BC1@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:59663 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757869AbYHFQ0R convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Aug 2008 12:26:17 -0400
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id m76GQC9A013948
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 6 Aug 2008 11:26:17 -0500
Received: from dlee74.ent.ti.com (localhost [127.0.0.1])
	by dlep36.itg.ti.com (8.13.8/8.13.8) with ESMTP id m76GQAj4001054
	for <linux-omap@vger.kernel.org>; Wed, 6 Aug 2008 11:26:11 -0500 (CDT)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

The following patch fixes warnings present at building stages.

Cleaning up the code to remove minor issues and an unnecessary header file.

Placed under:
http://omapzoom.org/gf/project/omapbridge/frs/?action=FrsReleaseBrowse&frs_package_id=16

Named: BRD010-ARM-OMAP-cleanup_warnings.patch

- omar


---
Index: omapkernel/drivers/dsp/dspbridge/mpu_driver/inc/dbc.h
===================================================================
--- omapkernel.orig/drivers/dsp/dspbridge/mpu_driver/inc/dbc.h  2008-08-06 09:49:03.000000000 -0500
+++ omapkernel/drivers/dsp/dspbridge/mpu_driver/inc/dbc.h       2008-08-06 09:59:14.000000000 -0500
@@ -39,6 +39,10 @@
 #ifndef DBC_
 #define DBC_

+#ifndef GT_TRACE
+#define GT_TRACE 0         /* 0 = "trace compiled out"; 1 = "trace active" */
+#endif
+
 /* Assertion Macros: */
 #if GT_TRACE

Index: omapkernel/drivers/dsp/dspbridge/mpu_driver/inc/dbtype.h
===================================================================
--- omapkernel.orig/drivers/dsp/dspbridge/mpu_driver/inc/dbtype.h       2008-08-06 09:49:03.000000000 -0500
+++ omapkernel/drivers/dsp/dspbridge/mpu_driver/inc/dbtype.h    2008-08-06 09:59:14.000000000 -0500
@@ -87,7 +87,6 @@

 #ifndef OMAPBRIDGE_TYPES
 #define OMAPBRIDGE_TYPES
-typedef int BOOL;              /* f    */
 typedef volatile unsigned short REG_UWORD16;
 #endif

Index: omapkernel/drivers/dsp/dspbridge/mpu_driver/inc/dynamic_loader.h
===================================================================
--- omapkernel.orig/drivers/dsp/dspbridge/mpu_driver/inc/dynamic_loader.h       2008-08-06 09:49:03.000000000 -0500
+++ omapkernel/drivers/dsp/dspbridge/mpu_driver/inc/dynamic_loader.h    2008-08-06 09:59:14.000000000 -0500
@@ -18,7 +18,7 @@

 #ifndef _DYNAMIC_LOADER_H_
 #define _DYNAMIC_LOADER_H_
-#include <stdarg.h>
+#include <linux/kernel.h>
 #include <linux/types.h>

 /*
Index: omapkernel/drivers/dsp/dspbridge/mpu_driver/inc/gp.h
===================================================================
--- omapkernel.orig/drivers/dsp/dspbridge/mpu_driver/inc/gp.h   2008-08-06 09:49:03.000000000 -0500
+++ /dev/null   1970-01-01 00:00:00.000000000 +0000
@@ -1,33 +0,0 @@
-/*
- * dspbridge/mpu_driver/inc/gp.h
- *
- * DSP-BIOS Bridge driver support functions for TI OMAP processors.
- *
- * Copyright (C) 2005-2006 Texas Instruments, Inc.
- *
- * This package is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * THIS PACKAGE IS PROVIDED ``AS IS'' AND WITHOUT ANY EXPRESS OR
- * IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED
- * WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.
- */
-
-/*
- *  ======== gp.h ========
- *! Revision History
- *! ================
- */
-
-#ifndef GP_
-#define GP_
-
-#include <stdarg.h>
-
-/*
- *  ======== GP_snprintf ========
- */
-#define GP_snprintf snprintf
-
-#endif
Index: omapkernel/drivers/dsp/dspbridge/mpu_driver/inc/io_sm.h
===================================================================
--- omapkernel.orig/drivers/dsp/dspbridge/mpu_driver/inc/io_sm.h        2008-08-06 09:49:03.000000000 -0500
+++ omapkernel/drivers/dsp/dspbridge/mpu_driver/inc/io_sm.h     2008-08-06 09:59:14.000000000 -0500
@@ -115,24 +115,6 @@
        extern void IO_DPC(IN OUT void *pRefData);

 /*
- *  ======== IO_IVADPC ========
- *  Purpose:
- *      Deferred procedure call for shared memory channel driver ISR.  Carries
- *      out the dispatch of I/O.
- *  Parameters:
- *      pRefData:   Pointer to reference data registered via a call to
- *                  DPC_Create().
- *  Returns:
- *  Requires:
- *      Must not block.
- *      Must not acquire resources.
- *      All data touched must be locked in memory if running in kernel mode.
- *  Ensures:
- *      Non-preemptible (but interruptible).
- */
-       extern void IO_IVADPC(IN OUT void *pRefData);
-
-/*
  *  ======== IO_ISR ========
  *  Purpose:
  *      Main interrupt handler for the shared memory WMD channel manager.
@@ -153,26 +135,6 @@
        extern bool IO_ISR(IN void *pRefData);

 /*
- *  ======== IO_IVAISR ========
- *  Purpose:
- *      Main interrupt handler for the shared memory WMD channel manager.
- *      Calls the WMD's CHNLSM_ISR to determine if this interrupt is ours, then
- *      schedules a DPC to dispatch I/O..
- *  Parameters:
- *      pRefData:   Pointer to the channel manager object for this board.
- *                  Set in an initial call to ISR_Install().
- *  Returns:
- *      TRUE if interrupt handled; FALSE otherwise.
- *  Requires:
- *      Must be in locked memory if executing in kernel mode.
- *      Must only call functions which are in locked memory if Kernel mode.
- *      Must only call asynchronous services.
- *      Interrupts are disabled and EOI for this interrupt has been sent.
- *  Ensures:
- */
-       extern BOOL IO_IVAISR(IN void *pRefData);
-
-/*
  *  ======== IO_RequestChnl ========
  *  Purpose:
  *      Request I/O from the DSP. Sets flags in shared memory, then interrupts
Index: omapkernel/drivers/dsp/dspbridge/mpu_driver/inc/isr.h
===================================================================
--- omapkernel.orig/drivers/dsp/dspbridge/mpu_driver/inc/isr.h  2008-08-06 09:23:46.000000000 -0500
+++ omapkernel/drivers/dsp/dspbridge/mpu_driver/inc/isr.h       2008-08-06 09:59:14.000000000 -0500
@@ -77,7 +77,7 @@
  *      This routine must not affect the state of the physical PIC.
  *      (i.e.; don't send an EOI).
  */
-       typedef BOOL(CDECL *ISR_PROC) (void *pRefData);
+       typedef bool (CDECL *ISR_PROC) (void *pRefData);

 /*
  *  ======== ISR_Disable ========
Index: omapkernel/drivers/dsp/dspbridge/mpu_driver/inc/resourcecleanup.h
===================================================================
--- omapkernel.orig/drivers/dsp/dspbridge/mpu_driver/inc/resourcecleanup.h      2008-08-06 09:49:03.000000000 -0500
+++ omapkernel/drivers/dsp/dspbridge/mpu_driver/inc/resourcecleanup.h   2008-08-06 09:59:14.000000000 -0500
@@ -54,7 +54,7 @@

 extern DSP_STATUS DRV_ProcNodeUpdateStreamStatus(HANDLE nodeRes, int status);

-extern DSP_STATUS DRV_RemoveNodeResElement(HANDLE nodeRes, int status);
+extern DSP_STATUS DRV_RemoveNodeResElement(HANDLE nodeRes, HANDLE status);

 extern DSP_STATUS DRV_ProcNodeUpdateStatus(HANDLE nodeRes, int status);

Index: omapkernel/drivers/dsp/dspbridge/mpu_driver/src/dynload/cload.c
===================================================================
--- omapkernel.orig/drivers/dsp/dspbridge/mpu_driver/src/dynload/cload.c        2008-08-06 09:49:03.000000000 -0500
+++ omapkernel/drivers/dsp/dspbridge/mpu_driver/src/dynload/cload.c     2008-08-06 09:59:14.000000000 -0500
@@ -401,11 +401,6 @@
                            dlthis->dfile_hdr.df_no_scns);
                return;
        }
-       if (dlthis->dfile_hdr.df_no_syms > MAX_REASONABLE_SYMBOLS) {
-               dload_error(dlthis, "Excessive symbol count " FMT_UI32,
-                           dlthis->dfile_hdr.df_no_syms);
-               return;
-       }
 #ifndef TARGET_ENDIANNESS
        /*
         * Check that endianness does not disagree with explicit specification
@@ -708,6 +703,8 @@
        u32 s_count, siz, dsiz, symbols_left;
        u32 checks;
        struct Local_Symbol *sp;
+       struct dynload_symbol *symp;
+       struct dynload_symbol *newsym;

        s_count = dlthis->dfile_hdr.df_no_syms;
        if (s_count == 0)
@@ -786,7 +783,6 @@
                                if (input_sym->dn_sclass != DN_EXT)
                                        goto loop_cont;

-                               struct dynload_symbol *symp;
                                /* try to define symbol from previously
                                 * loaded images                          */
                                symp = dlthis->mysym->Find_Matching_Symbol
@@ -860,7 +856,6 @@
                                if (!sname)
                                        goto loop_cont;

-                               struct dynload_symbol *newsym;
                                newsym = dlthis->mysym->Add_To_Symbol_Table
                                                    (dlthis->mysym, sname,
                                                    (unsigned)dlthis->myhandle);
@@ -1714,6 +1709,8 @@
        struct my_handle *hndl;
        struct dbg_mirror_root *root;
        unsigned errcount = 0;
+       struct LDR_SECTION_INFO dllview_info = DLLVIEW_INFO_INIT;
+       struct modules_header mhdr;

        hndl = (struct my_handle *)mhandle;
        if (!hndl)
@@ -1743,14 +1740,12 @@
        if (!hndl->dm.dbthis) { /* target-side dllview record exists */
                goto loop_end;
        }
-       struct LDR_SECTION_INFO dllview_info = DLLVIEW_INFO_INIT;
        /* Retrieve memory context in which .dllview was allocated */
        dllview_info.context = hndl->dm.context;
        if (hndl->dm.hprev == hndl)
                goto exitunltgt;

        /* target-side dllview record is in list */
-       struct modules_header mhdr;
        /* dequeue this record from our GPP-side mirror list */
        hndl->dm.hprev->dm.hnext = hndl->dm.hnext;
        if (hndl->dm.hnext)
Index: omapkernel/drivers/dsp/dspbridge/mpu_driver/src/dynload/reloc.c
===================================================================
--- omapkernel.orig/drivers/dsp/dspbridge/mpu_driver/src/dynload/reloc.c        2008-08-06 09:49:03.000000000 -0500
+++ omapkernel/drivers/dsp/dspbridge/mpu_driver/src/dynload/reloc.c     2008-08-06 09:59:14.000000000 -0500
@@ -165,14 +165,18 @@
 void dload_relocate(struct dload_state *dlthis, TgtAU_t *data,
                    struct reloc_record_t *rp)
 {
-       RVALUE val, reloc_amt;
-       unsigned fieldsz = 0, offset = 0, reloc_info, reloc_action;
-       register int rx;
+       RVALUE val = 0;
+       RVALUE reloc_amt = 0;
+       unsigned int fieldsz = 0;
+       unsigned int offset = 0;
+       unsigned int reloc_info = 0;
+       unsigned int reloc_action = 0;
+       register int rx = 0;
        RVALUE    *stackp = NULL;
        int top;
        struct Local_Symbol *svp = NULL;
 #ifdef RFV_SCALE
-       unsigned scale;
+       unsigned int scale = 0;
 #endif

        rx = HASH_FUNC(rp->r_type);
@@ -402,20 +406,6 @@
                                rp->r_vaddr + dlthis->image_offset);
                break;
 #endif
-#if TMS470
-       case RACT_PCR23T:
-               /* ARM encodes Thumb long-branch as two 16-bit branches,
-                * first containing 11 MSBs, second containing 11 LSBs of
-                * a 23-bit short-aligned field */
-               if (rp->r_symndx == -1)
-                       reloc_amt = 0;
-               val += dload_unpack(dlthis, data + sizeof(uint16_t)/
-                      sizeof(TgtAU_t), 11, 0, ROP_UNS) << 1;   /* grab LSBs */
-               val += reloc_amt - dlthis->delta_runaddr;
-               dload_repack(dlthis, val >> 1, data + sizeof(uint16_t)/
-                      sizeof(TgtAU_t), 11, 0, ROP_UNS);       /* store LSBs */
-               break;
-#endif
        }       /* relocation actions */
        /* * Put back result as required */
        if (reloc_info & ROP_W) {       /* relocation writes image value */
Index: omapkernel/drivers/dsp/dspbridge/mpu_driver/src/gen/_gt_para.c
===================================================================
--- omapkernel.orig/drivers/dsp/dspbridge/mpu_driver/src/gen/_gt_para.c 2008-08-06 09:49:03.000000000 -0500
+++ omapkernel/drivers/dsp/dspbridge/mpu_driver/src/gen/_gt_para.c      2008-08-06 09:59:14.000000000 -0500
@@ -42,7 +42,6 @@

 /*  ----------------------------------- Trace & Debug */
 #include <gt.h>
-#include <gp.h>

 /*  ----------------------------------- Function Prototypes */
 static void error(char *msg, ...);
Index: omapkernel/drivers/dsp/dspbridge/mpu_driver/src/gen/gt.c
===================================================================
--- omapkernel.orig/drivers/dsp/dspbridge/mpu_driver/src/gen/gt.c       2008-08-06 09:49:03.000000000 -0500
+++ omapkernel/drivers/dsp/dspbridge/mpu_driver/src/gen/gt.c    2008-08-06 09:59:14.000000000 -0500
@@ -126,7 +126,7 @@
                case (s32) GT_SEP:
                        maskValid = false;
                        sep = separator;
-                       while (*str != '\0') {
+                       while (*sep != '\0') {
                                if (*str == *sep) {
                                        str++;
                                        break;
@@ -134,7 +134,7 @@
                                        sep++;
                                }
                        }
-                       if (*str != '\0')
+                       if (*sep == '\0')
                                state = GT_FIRST;

                        break;
Index: omapkernel/drivers/dsp/dspbridge/mpu_driver/src/gen/uuidutil.c
===================================================================
--- omapkernel.orig/drivers/dsp/dspbridge/mpu_driver/src/gen/uuidutil.c 2008-08-06 09:49:03.000000000 -0500
+++ omapkernel/drivers/dsp/dspbridge/mpu_driver/src/gen/uuidutil.c      2008-08-06 09:59:14.000000000 -0500
@@ -60,7 +60,7 @@
        DBC_Require(pUuid && pszUuid);

        i = snprintf(pszUuid, size,
-                    "%.8lX_%.4X_%.4X_%.2X%.2X_%.2X%.2X%.2X%.2X%.2X%.2X",
+                    "%.8X_%.4X_%.4X_%.2X%.2X_%.2X%.2X%.2X%.2X%.2X%.2X",
                     pUuid->ulData1, pUuid->usData2, pUuid->usData3,
                     pUuid->ucData4, pUuid->ucData5, pUuid->ucData6[0],
                     pUuid->ucData6[1], pUuid->ucData6[2], pUuid->ucData6[3],
Index: omapkernel/drivers/dsp/dspbridge/mpu_driver/src/pmgr/dbll.c
===================================================================
--- omapkernel.orig/drivers/dsp/dspbridge/mpu_driver/src/pmgr/dbll.c    2008-08-06 09:49:03.000000000 -0500
+++ omapkernel/drivers/dsp/dspbridge/mpu_driver/src/pmgr/dbll.c 2008-08-06 09:59:14.000000000 -0500
@@ -1481,7 +1481,7 @@
        struct DBLL_LibraryObj *lib;
        struct DBLL_SectInfo sectInfo;
        u32 memType;
-       bool retVal;
+       bool retVal = true;

        DBC_Require(this != NULL);
        lib = pInit->lib;
@@ -1529,7 +1529,7 @@
            memory. This is a trick to just get the start address, there is no
            writing taking place with this Writemem
        */
-       if ((lib->pTarget->attrs.write) != NoOp)
+       if ((lib->pTarget->attrs.write) != (DBLL_WriteFxn)NoOp)
                writeMem(this, &pBuf, addr, info, 0);
        if (pBuf)
                memset(pBuf, val, nBytes);
Index: omapkernel/drivers/dsp/dspbridge/mpu_driver/src/pmgr/dev.c
===================================================================
--- omapkernel.orig/drivers/dsp/dspbridge/mpu_driver/src/pmgr/dev.c     2008-08-06 09:49:03.000000000 -0500
+++ omapkernel/drivers/dsp/dspbridge/mpu_driver/src/pmgr/dev.c  2008-08-06 09:59:14.000000000 -0500
@@ -123,7 +123,6 @@
 /*  ----------------------------------- Trace & Debug */
 #include <dbc.h>
 #include <dbg.h>
-#include <gp.h>
 #include <gt.h>

 /*  ----------------------------------- OS Adaptation Layer */
@@ -900,7 +899,7 @@
                status = DEV_GetCodMgr(hDevObject, &hCodMgr);
                if (DSP_SUCCEEDED(status)) {
                        DBC_Assert(hCodMgr != NULL);
-                       status = COD_GetSymValue(hCodMgr, pstrSym, pulValue);
+                       status = COD_GetSymValue(hCodMgr, (char *)pstrSym, pulValue);
                }
        } else {
                status = DSP_EHANDLE;
Index: omapkernel/drivers/dsp/dspbridge/mpu_driver/src/pmgr/dmm.c
===================================================================
--- omapkernel.orig/drivers/dsp/dspbridge/mpu_driver/src/pmgr/dmm.c     2008-08-06 09:49:03.000000000 -0500
+++ omapkernel/drivers/dsp/dspbridge/mpu_driver/src/pmgr/dmm.c  2008-08-06 09:59:14.000000000 -0500
@@ -121,7 +121,6 @@
 static struct MapPage *GetRegion(u32 addr);
 static struct MapPage *GetFreeRegion(u32 aSize);
 static struct MapPage *GetMappedRegion(u32 aAddr);
-static u32 *GetPhysicalAddrTable(void);

 /*  ======== DMM_CreateTables ========
  *  Purpose:
Index: omapkernel/drivers/dsp/dspbridge/mpu_driver/src/rmgr/drv.c
===================================================================
--- omapkernel.orig/drivers/dsp/dspbridge/mpu_driver/src/rmgr/drv.c     2008-08-06 09:49:03.000000000 -0500
+++ omapkernel/drivers/dsp/dspbridge/mpu_driver/src/rmgr/drv.c  2008-08-06 09:59:14.000000000 -0500
@@ -100,7 +100,6 @@

 /*  ----------------------------------- Trace & Debug */
 #include <dbc.h>
-#include <gp.h>
 #include <gt.h>

 /*  ----------------------------------- OS Adaptation Layer */
@@ -273,12 +272,12 @@
 /* Add a new process context to process context list */
 DSP_STATUS DRV_InsertProcContext(struct DRV_OBJECT *hDrVObject, HANDLE hPCtxt)
 {
-       GT_0trace(curTrace, GT_ENTER, "\n In DRV_InsertProcContext\n");
        struct PROCESS_CONTEXT **pCtxt = (struct PROCESS_CONTEXT **)hPCtxt;
        DSP_STATUS status = DSP_SOK;
        struct PROCESS_CONTEXT *pCtxtList = NULL;
        struct DRV_OBJECT            *hDRVObject;

+       GT_0trace(curTrace, GT_ENTER, "\n In DRV_InsertProcContext\n");
        status = CFG_GetObject((u32 *)&hDRVObject, REG_DRV_OBJECT);
        DBC_Assert(hDRVObject != NULL);
        *pCtxt = MEM_Calloc(1 * sizeof(struct PROCESS_CONTEXT), MEM_PAGED);
Index: omapkernel/drivers/dsp/dspbridge/mpu_driver/src/rmgr/drv_interface.c
===================================================================
--- omapkernel.orig/drivers/dsp/dspbridge/mpu_driver/src/rmgr/drv_interface.c   2008-08-06 09:49:03.000000000 -0500
+++ omapkernel/drivers/dsp/dspbridge/mpu_driver/src/rmgr/drv_interface.c        2008-08-06 09:59:14.000000000 -0500
@@ -554,7 +554,6 @@
 int bridge_open(struct inode *ip, struct file *filp)
 {
        int status = 0;
-       GT_0trace(driverTrace, GT_ENTER, "-> driver_open\n");
 #ifndef RES_CLEANUP_DISABLE
        HANDLE       hProcess;
        DSP_STATUS dsp_status = DSP_SOK;
@@ -564,6 +563,7 @@
        struct PROCESS_CONTEXT    *pCtxtclosed = NULL;
        struct PROCESS_CONTEXT    *pCtxttraverse = NULL;
        struct task_struct *tsk = NULL;
+       GT_0trace(driverTrace, GT_ENTER, "-> driver_open\n");
        dsp_status = CFG_GetObject((u32 *)&hDrvObject, REG_DRV_OBJECT);

        /* Checking weather task structure for all process existing
@@ -708,7 +708,9 @@
 /* This function maps kernel space memory to user space memory. */
 int bridge_mmap(struct file *filp, struct vm_area_struct *vma)
 {
+#if GT_TRACE
        u32 offset = vma->vm_pgoff << PAGE_SHIFT;
+#endif
        u32 status;

        DBC_Assert(vma->vm_start < vma->vm_end);
Index: omapkernel/drivers/dsp/dspbridge/mpu_driver/src/rmgr/dspdrv.c
===================================================================
--- omapkernel.orig/drivers/dsp/dspbridge/mpu_driver/src/rmgr/dspdrv.c  2008-08-06 09:49:03.000000000 -0500
+++ omapkernel/drivers/dsp/dspbridge/mpu_driver/src/rmgr/dspdrv.c       2008-08-06 09:59:14.000000000 -0500
@@ -101,7 +101,6 @@

 /*  ----------------------------------- Trace & Debug */
 #include <dbc.h>
-#include <gp.h>
 #include <gt.h>

 /*  ----------------------------------- OS Adaptation Layer */
Index: omapkernel/drivers/dsp/dspbridge/mpu_driver/src/rmgr/nldr.c
===================================================================
--- omapkernel.orig/drivers/dsp/dspbridge/mpu_driver/src/rmgr/nldr.c    2008-08-06 09:49:03.000000000 -0500
+++ omapkernel/drivers/dsp/dspbridge/mpu_driver/src/rmgr/nldr.c 2008-08-06 09:59:14.000000000 -0500
@@ -776,7 +776,7 @@
        DSP_STATUS status = DSP_SOK;
        bool status1 = false;
        s32 i = 0;
-       struct LibNode root;
+       struct LibNode root = { NULL, 0, NULL };
        DBC_Require(cRefs > 0);
        DBC_Require(MEM_IsValidHandle(hNldrNode, NLDR_NODESIGNATURE));
        DBC_Require(pulAddr != NULL);
@@ -1683,7 +1683,7 @@
        struct NLDR_OBJECT *hNldr;
        struct RMM_TargetObj *rmm;
        u16 memPhaseBit = MAXFLAGS;
-       u16 segid;
+       u16 segid = 0;
        u16 i;
        u16 memType;
        u32 nWords;
Index: omapkernel/drivers/dsp/dspbridge/mpu_driver/src/rmgr/node.c
===================================================================
--- omapkernel.orig/drivers/dsp/dspbridge/mpu_driver/src/rmgr/node.c    2008-08-06 09:49:03.000000000 -0500
+++ omapkernel/drivers/dsp/dspbridge/mpu_driver/src/rmgr/node.c 2008-08-06 09:59:14.000000000 -0500
@@ -1644,7 +1644,7 @@
        HANDLE          hProcess;
        HANDLE          nodeRes;
        HANDLE          hDrvObject;
-       struct PROCESS_CONTEXT     *pCtxt = NULL;
+       struct PROCESS_CONTEXT *pCtxt = NULL;
        DSP_STATUS res_status = DSP_SOK;
 #endif

@@ -1791,7 +1791,7 @@
        if (DSP_SUCCEEDED(status)) {
                GT_0trace(NODE_debugMask, GT_5CLASS, "\nNODE_Delete2:\n ");
                if (pCtxt != NULL)
-                       DRV_RemoveNodeResElement(nodeRes, pCtxt);
+                       DRV_RemoveNodeResElement(nodeRes, (HANDLE)pCtxt);

        }
 #endif
@@ -3226,7 +3226,7 @@
                dcdNodeProps.pstrIAlgName = NULL;

                status = DCD_GetObjectDef(hNodeMgr->hDcdMgr,
-                               (CONST struct DSP_UUID *) pNodeId,
+                               (struct DSP_UUID *) pNodeId,
                                DSP_DCDNODETYPE,
                                (struct DCD_GENERICOBJ *) &dcdNodeProps);
                if (DSP_SUCCEEDED(status)) {
Index: omapkernel/drivers/dsp/dspbridge/mpu_driver/src/rmgr/proc.c
===================================================================
--- omapkernel.orig/drivers/dsp/dspbridge/mpu_driver/src/rmgr/proc.c    2008-08-06 09:49:03.000000000 -0500
+++ omapkernel/drivers/dsp/dspbridge/mpu_driver/src/rmgr/proc.c 2008-08-06 09:59:14.000000000 -0500
@@ -110,7 +110,6 @@

 /*  ----------------------------------- Trace & Debug */
 #include <dbc.h>
-#include <gp.h>
 #include <gt.h>

 /*  ----------------------------------- OS Adaptation Layer */
@@ -608,17 +607,15 @@
 {
        DSP_STATUS status = DSP_SOK;
        struct PROC_OBJECT *pProcObject = (struct PROC_OBJECT *)hProcessor;
-
+#ifndef RES_CLEANUP_DISABLE
+       HANDLE hDRVObject;
+       HANDLE hProcess;
+       DSP_STATUS res_status = DSP_SOK;
+       struct PROCESS_CONTEXT   *pPctxt = NULL;
+#endif
        DBC_Require(cRefs > 0);
-
        GT_1trace(PROC_DebugMask, GT_ENTER, "Entered PROC_Detach, args:\n\t"
                 "hProcessor:  0x%x\n", hProcessor);
-#ifndef RES_CLEANUP_DISABLE
-    HANDLE          hDRVObject;
-    HANDLE          hProcess;
-    DSP_STATUS res_status = DSP_SOK;
-    struct PROCESS_CONTEXT   *pPctxt = NULL;
-#endif

        if (MEM_IsValidHandle(pProcObject, PROC_SIGNATURE)) {
                /* Notify the Client */
@@ -1069,7 +1066,7 @@
        cNewEnvp = (cEnvp ? (cEnvp + 1) : (cEnvp + 2));
        newEnvp = MEM_Calloc(cNewEnvp * sizeof(char **), MEM_PAGED);
        if (newEnvp) {
-               status = GP_snprintf(szProcID, MAXPROCIDLEN, PROC_ENVPROCID,
+               status = snprintf(szProcID, MAXPROCIDLEN, PROC_ENVPROCID,
                                    nProcID);
                if (status == -1) {
                        GT_0trace(PROC_DebugMask, GT_7CLASS, "PROC_Load: "
@@ -1699,19 +1696,16 @@
        struct DMM_OBJECT *hDmmMgr;
        u32 vaAlign;
        u32 sizeAlign;
-
+#ifndef RES_CLEANUP_DISABLE
+       HANDLE        hProcess;
+       HANDLE        pCtxt = NULL;
+       HANDLE        hDrvObject;
+       HANDLE        dmmRes;
+       DSP_STATUS res_status = DSP_SOK;
+#endif
        GT_2trace(PROC_DebugMask, GT_ENTER,
                 "Entered PROC_UnMap, args:\n\thProcessor:"
                 "0x%x pMapAddr: 0x%x\n", hProcessor, pMapAddr);
-       #ifndef RES_CLEANUP_DISABLE
-               HANDLE        hProcess;
-               HANDLE        pCtxt = NULL;
-               HANDLE        hDrvObject;
-               HANDLE        dmmRes;
-               DSP_STATUS res_status = DSP_SOK;
-       #endif
-
-

        vaAlign = PG_ALIGN_LOW((u32) pMapAddr, PG_SIZE_4K);

Index: omapkernel/drivers/dsp/dspbridge/mpu_driver/src/rmgr/strm.c
===================================================================
--- omapkernel.orig/drivers/dsp/dspbridge/mpu_driver/src/rmgr/strm.c    2008-08-06 09:49:03.000000000 -0500
+++ omapkernel/drivers/dsp/dspbridge/mpu_driver/src/rmgr/strm.c 2008-08-06 09:59:14.000000000 -0500
@@ -392,14 +392,14 @@
                          u32 uNumBufs)
 {
        DSP_STATUS status = DSP_SOK;
-       u32 i;
+       u32 i = 0;

        #ifndef RES_CLEANUP_DISABLE
        DSP_STATUS res_status = DSP_SOK;
        HANDLE       hProcess;
        HANDLE       pCtxt = NULL;
        HANDLE       hDrvObject;
-       HANDLE              hSTRMRes;
+       HANDLE              hSTRMRes = NULL;
        #endif
        DBC_Require(cRefs > 0);
        DBC_Require(apBuffer != NULL);
Index: omapkernel/drivers/dsp/dspbridge/mpu_driver/src/services/cfg.c
===================================================================
--- omapkernel.orig/drivers/dsp/dspbridge/mpu_driver/src/services/cfg.c 2008-08-06 09:49:03.000000000 -0500
+++ omapkernel/drivers/dsp/dspbridge/mpu_driver/src/services/cfg.c      2008-08-06 09:59:14.000000000 -0500
@@ -79,7 +79,6 @@

 /*  ----------------------------------- Trace & Debug */
 #include <dbc.h>
-#include <gp.h>
 #include <gt.h>

 /*  ----------------------------------- OS Adaptation Layer */
Index: omapkernel/drivers/dsp/dspbridge/mpu_driver/src/services/clk.c
===================================================================
--- omapkernel.orig/drivers/dsp/dspbridge/mpu_driver/src/services/clk.c 2008-08-06 09:49:03.000000000 -0500
+++ omapkernel/drivers/dsp/dspbridge/mpu_driver/src/services/clk.c      2008-08-06 09:59:14.000000000 -0500
@@ -269,9 +269,9 @@
 {
        DSP_STATUS status = DSP_SOK;
        struct clk *pClk;
-       DBC_Require(clk_id < SERVICESCLK_NOT_DEFINED);
        s32 clkUseCnt;

+       DBC_Require(clk_id < SERVICESCLK_NOT_DEFINED);
        GT_1trace(CLK_debugMask, GT_6CLASS,
                  "CLK_Disable: CLK Id = 0x%x \n", clk_id);

Index: omapkernel/drivers/dsp/dspbridge/mpu_driver/src/services/dbg.c
===================================================================
--- omapkernel.orig/drivers/dsp/dspbridge/mpu_driver/src/services/dbg.c 2008-08-06 09:49:03.000000000 -0500
+++ omapkernel/drivers/dsp/dspbridge/mpu_driver/src/services/dbg.c      2008-08-06 09:59:14.000000000 -0500
@@ -52,7 +52,6 @@

 /*  ----------------------------------- Trace & Debug */
 #include <dbc.h>
-#include <gp.h>
 #include <gt.h>

 /*  ----------------------------------- This */
Index: omapkernel/drivers/dsp/dspbridge/mpu_driver/src/services/dpc.c
===================================================================
--- omapkernel.orig/drivers/dsp/dspbridge/mpu_driver/src/services/dpc.c 2008-08-06 09:49:03.000000000 -0500
+++ omapkernel/drivers/dsp/dspbridge/mpu_driver/src/services/dpc.c      2008-08-06 09:59:14.000000000 -0500
@@ -54,7 +54,6 @@

 /*  ----------------------------------- Trace & Debug */
 #include <dbc.h>
-#include <gp.h>
 #include <gt.h>

 /*  ----------------------------------- OS Adaptation Layer */
@@ -89,7 +88,7 @@
 #endif

 /*  ----------------------------------- Function Prototypes */
-static void DPC_DeferredProcedure(IN u32 pDeferredContext);
+static void DPC_DeferredProcedure(IN unsigned long pDeferredContext);

 /*
  *  ======== DPC_Create ========
@@ -244,7 +243,7 @@
  *      Main DPC routine.  This is called by host OS DPC callback
  *      mechanism with interrupts enabled.
  */
-static void DPC_DeferredProcedure(IN u32 pDeferredContext)
+static void DPC_DeferredProcedure(IN unsigned long pDeferredContext)
 {
        struct DPC_OBJECT *pDPCObject = (struct DPC_OBJECT *)pDeferredContext;
        /* read numRequested in local variable */
Index: omapkernel/drivers/dsp/dspbridge/mpu_driver/src/services/isr.c
===================================================================
--- omapkernel.orig/drivers/dsp/dspbridge/mpu_driver/src/services/isr.c 2008-08-06 09:49:03.000000000 -0500
+++ omapkernel/drivers/dsp/dspbridge/mpu_driver/src/services/isr.c      2008-08-06 09:59:14.000000000 -0500
@@ -66,7 +66,6 @@

 /*  ----------------------------------- Trace & Debug */
 #include <dbc.h>
-#include <gp.h>
 #include <gt.h>

 /*  ----------------------------------- OS Adaptation Layer */
Index: omapkernel/drivers/dsp/dspbridge/mpu_driver/src/services/kfile.c
===================================================================
--- omapkernel.orig/drivers/dsp/dspbridge/mpu_driver/src/services/kfile.c       2008-08-06 09:49:03.000000000 -0500
+++ omapkernel/drivers/dsp/dspbridge/mpu_driver/src/services/kfile.c    2008-08-06 09:59:14.000000000 -0500
@@ -51,7 +51,6 @@

 /*  ----------------------------------- Trace & Debug */
 #include <dbc.h>
-#include <gp.h>
 #include <gt.h>

 /*  ----------------------------------- OS Adaptation Layer */
@@ -177,7 +176,7 @@
                        status = DSP_EFILE;
                } else {
                        hFile->fileDesc = fileDesc;
-                       hFile->fileName = pszFileName;
+                       hFile->fileName = (char *)pszFileName;
                        hFile->isOpen      = true;
                        hFile->curPos   = 0;
                        hFile->size = fileDesc->f_op->llseek(fileDesc, 0,
Index: omapkernel/drivers/dsp/dspbridge/mpu_driver/src/services/reg.c
===================================================================
--- omapkernel.orig/drivers/dsp/dspbridge/mpu_driver/src/services/reg.c 2008-08-06 09:49:03.000000000 -0500
+++ omapkernel/drivers/dsp/dspbridge/mpu_driver/src/services/reg.c      2008-08-06 09:59:14.000000000 -0500
@@ -143,7 +143,7 @@
        /*  We need to use regsup calls...  */
        /*  ...for now we don't need the key handle or  */
        /*  the subkey, all we need is the value to lookup.  */
-       if (regsupGetValue(pstrValue, pbData, pdwDataSize) == DSP_SOK)
+       if (regsupGetValue((char *)pstrValue, pbData, pdwDataSize) == DSP_SOK)
                status = DSP_SOK;
        else
                status = DSP_EFAIL;
@@ -186,7 +186,7 @@
        /*  We need to use regsup calls...  */
        /*  ...for now we don't need the key handle or  */
        /*  the subkey, all we need is the value to lookup.  */
-       if (regsupSetValue(pstrValue, pbData, dwDataSize) == DSP_SOK)
+       if (regsupSetValue((char *)pstrValue, pbData, dwDataSize) == DSP_SOK)
                status = DSP_SOK;
        else
                status = DSP_EFAIL;
Index: omapkernel/drivers/dsp/dspbridge/mpu_driver/src/wmd/3430/tiomap.c
===================================================================
--- omapkernel.orig/drivers/dsp/dspbridge/mpu_driver/src/wmd/3430/tiomap.c      2008-08-06 09:49:03.000000000 -0500
+++ omapkernel/drivers/dsp/dspbridge/mpu_driver/src/wmd/3430/tiomap.c   2008-08-06 09:59:14.000000000 -0500
@@ -1299,7 +1299,7 @@
        DSP_STATUS status = DSP_SOK;
        struct WMD_DEV_CONTEXT *pDevContext = hDevContext;
        struct HW_MMUMapAttrs_t hwAttrs;
-       u32 numOfActualTabEntries;
+       u32 numOfActualTabEntries = 0;
        u32 temp = 0;
        u32 *pPhysAddrPageTbl = NULL;
        struct vm_area_struct *vma;
Index: omapkernel/drivers/dsp/dspbridge/mpu_driver/src/wmd/tiomap_sm.c
===================================================================
--- omapkernel.orig/drivers/dsp/dspbridge/mpu_driver/src/wmd/tiomap_sm.c        2008-08-06 09:49:03.000000000 -0500
+++ omapkernel/drivers/dsp/dspbridge/mpu_driver/src/wmd/tiomap_sm.c     2008-08-06 09:59:14.000000000 -0500
@@ -168,9 +168,7 @@
 {
        DSP_STATUS status = DSP_SOK;
        struct WMD_DEV_CONTEXT *pDevContext = hDevContext;
-#ifndef DEBUG
-       u32 usCount = LOOP_COUNT;
-#endif
+
 #ifndef DISABLE_BRIDGE_PM
 #ifndef DISABLE_BRIDGE_DVFS
        u32 opplevel;
Index: omapkernel/drivers/dsp/dspbridge/mpu_driver/src/wmd/ue_deh.c
===================================================================
--- omapkernel.orig/drivers/dsp/dspbridge/mpu_driver/src/wmd/ue_deh.c   2008-08-06 09:49:03.000000000 -0500
+++ omapkernel/drivers/dsp/dspbridge/mpu_driver/src/wmd/ue_deh.c        2008-08-06 09:59:14.000000000 -0500
@@ -201,13 +201,12 @@
  *      There are no more than ulNumWords extra characters needed (the number of
  *      linefeeds minus the number of NULLS in the input buffer).
  */
+#if ((defined DEBUG) || (defined DDSP_DEBUG_PRODUCT))\
+       && GT_TRACE
 static DSP_STATUS PackTraceBuffer(char *lpBuf, u32 nBytes, u32 ulNumWords)
 {
        DSP_STATUS status = DSP_SOK;

-#if ((defined DEBUG) || (defined DDSP_DEBUG_PRODUCT))\
-       && GT_TRACE
-
        char *lpTmpBuf;
        char *lpBufStart;
        char *lpTmpStart;
@@ -247,9 +246,10 @@
                lpBufStart[nBytes - 1] = '\0';
                MEM_Free(lpTmpStart);
        }
-#endif
+
        return status;
 }
+#endif    /* ((defined DEBUG) || (defined DDSP_DEBUG_PRODUCT)) && GT_TRACE */

 /*
  *  ======== PrintDspTraceBuffer ========
@@ -375,7 +375,6 @@
        u32 memPhysical = 0;
        u32 HW_MMU_MAX_TLB_COUNT = 31;
        u32 extern faultAddr;
-       u32 sizeTlb;
        struct CFG_HOSTRES resources;
        u32 dummyVaAddr;
        HW_STATUS hwStatus;
Index: omapkernel/drivers/dsp/dspbridge/mpu_driver/src/wmd/wmdchnl/chnl_sm.c
===================================================================
--- omapkernel.orig/drivers/dsp/dspbridge/mpu_driver/src/wmd/wmdchnl/chnl_sm.c  2008-08-06 09:49:03.000000000 -0500
+++ omapkernel/drivers/dsp/dspbridge/mpu_driver/src/wmd/wmdchnl/chnl_sm.c       2008-08-06 09:59:14.000000000 -0500
@@ -653,7 +653,7 @@
        struct CHNL_IRP *pChirp;
        DSP_STATUS statSync;
        bool fDequeueIOC = true;
-       struct CHNL_IOC ioc;
+       struct CHNL_IOC ioc = { NULL, 0, 0, 0, 0 };
        u8 *pHostSysBuf = NULL;

        DBG_Trace(DBG_ENTER, "> WMD_CHNL_GetIOC pChnl %p CHNL_IsOutput %x "
Index: omapkernel/drivers/dsp/dspbridge/mpu_driver/src/wmd/wmdchnl/io_sm.c
===================================================================
--- omapkernel.orig/drivers/dsp/dspbridge/mpu_driver/src/wmd/wmdchnl/io_sm.c    2008-08-06 09:49:03.000000000 -0500
+++ omapkernel/drivers/dsp/dspbridge/mpu_driver/src/wmd/wmdchnl/io_sm.c 2008-08-06 09:59:14.000000000 -0500
@@ -426,7 +426,7 @@
        u32 mapAttrs;
        u32 ulShm0End;
        u32 ulDynExtBase;
-       u32 ulSeg1Size;
+       u32 ulSeg1Size = 0;
        u32 paCurr = 0;
        u32 vaCurr = 0;
        u32 gppVaCurr = 0;
---

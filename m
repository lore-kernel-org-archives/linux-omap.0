From: "Ramirez Luna, Omar" <x00omar@ti.com>
Subject: [PATCH 03/07][GIT 3/4+] Removed bridge unused files
Date: Mon, 4 Aug 2008 09:55:24 -0500
Message-ID: <27F9C60D11D683428E133F85D2BB4A530804B512@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:33591 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754996AbYHDOzh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Aug 2008 10:55:37 -0400
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id m74EtU8U008489
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 4 Aug 2008 09:55:36 -0500
Received: from dlee74.ent.ti.com (localhost [127.0.0.1])
	by dlep36.itg.ti.com (8.13.8/8.13.8) with ESMTP id m74EtUuA021433
	for <linux-omap@vger.kernel.org>; Mon, 4 Aug 2008 09:55:30 -0500 (CDT)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Deleted unused headers, updating include references to avoid compilation errors.
Deleted c files and moving their functions to a more proper location.
Updating Kbuild file with these changes.

---
Index: omapkernel/drivers/dsp/dspbridge/mpu_driver/inc/cfg.h
===================================================================
--- omapkernel.orig/drivers/dsp/dspbridge/mpu_driver/inc/cfg.h  2008-07-29 23:44:28.000000000 -0500
+++ omapkernel/drivers/dsp/dspbridge/mpu_driver/inc/cfg.h       2008-07-29 23:52:55.000000000 -0500
@@ -65,7 +65,6 @@
 #ifndef CFG_
 #define CFG_

-#include <dspapi.h>
 #include <cfgdefs.h>
 #include <linux/types.h>

Index: omapkernel/drivers/dsp/dspbridge/mpu_driver/inc/clk.h
===================================================================
--- omapkernel.orig/drivers/dsp/dspbridge/mpu_driver/inc/clk.h  2008-07-29 23:52:26.000000000 -0500
+++ omapkernel/drivers/dsp/dspbridge/mpu_driver/inc/clk.h       2008-07-29 23:52:55.000000000 -0500
@@ -26,8 +26,6 @@
 #ifndef _CLK_H
 #define _CLK_H

-#include <dspapi.h>
-
        /* Generic TIMER object: */
        /*typedef struct TIMER_OBJECT *TIMER_HOBJECT;*/
        struct TIMER_OBJECT;
Index: omapkernel/drivers/dsp/dspbridge/mpu_driver/inc/cmm.h
===================================================================
--- omapkernel.orig/drivers/dsp/dspbridge/mpu_driver/inc/cmm.h  2008-07-29 23:52:26.000000000 -0500
+++ omapkernel/drivers/dsp/dspbridge/mpu_driver/inc/cmm.h       2008-07-29 23:52:55.000000000 -0500
@@ -68,7 +68,6 @@
 #define CMM_

 #include <devdefs.h>
-#include <dspapi.h>

 #include <cmmdefs.h>

Index: omapkernel/drivers/dsp/dspbridge/mpu_driver/inc/csl.h
===================================================================
--- omapkernel.orig/drivers/dsp/dspbridge/mpu_driver/inc/csl.h  2008-07-29 23:44:28.000000000 -0500
+++ omapkernel/drivers/dsp/dspbridge/mpu_driver/inc/csl.h       2008-07-29 23:52:55.000000000 -0500
@@ -56,10 +56,8 @@
 #ifndef CSL_
 #define CSL_

-#include <dspapi.h>
 #include <linux/types.h>

-
 /*
  *  ======== CSL_Atoi ========
  *  Purpose:
Index: omapkernel/drivers/dsp/dspbridge/mpu_driver/inc/dbapi.h
===================================================================
--- omapkernel.orig/drivers/dsp/dspbridge/mpu_driver/inc/dbapi.h        2008-07-29 23:44:28.000000000 -0500
+++ /dev/null   1970-01-01 00:00:00.000000000 +0000
@@ -1,48 +0,0 @@
-/*
- * dspbridge/mpu_driver/inc/dbapi.h
- *
- * DSP-BIOS Bridge driver support functions for TI OMAP processors.
- *
- * Copyright (C) 2008 Texas Instruments, Inc.
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
- *  ======== dbapi.h ========
- *  Description:
- *      Top level header file for GPP side DSP/BIOS Bridge APIs.
- *
- *! Revision History:
- *! ================
- *! 22-Nov-2002 gp  Cleaned up comments, formatting.
- *! 13-Feb-2001 kc: Name changed from ddspapi.h to dbapi.h.
- *! 27-Jun-2000 rr: Name changed to ddspapi.h. Broken into various h files.
- *! 12-May-2000 gp: Removed PROC_UNKNOWN state.  Moved OEM DSPProcessor_ fxns
- *!                 to ddspoem.h. Changed DDSP_MSG to be fixed length;
- *!                 Changed DDSPStream_Issue/Reclaim to take u32 dwArg.
- *! 11-May-2000 gp: Reformatted; converted tabs to spaces; changed NODEHANDLE
- *!                 to HNODE; changed GUID to UUID; added "Detail" sections
- *!                 documenting differences from DDSP API spec. (ver. 0.6);
- *!                 enhanced comments.
- *! 19-Apr-2000 ww: Updated based on code review.
- *! 12-Apr-2000 ww: Created based on DSP/BIOS Bridge API specification, Ver 0.6.
- */
-
-#ifndef DBAPI_
-#define DBAPI_
-
-#include <dbdefs.h>    /* DSP/BIOS Bridge global definitions and constants */
-#include <errbase.h>           /* DSP/BIOS Bridge status and error codes   */
-#include <DSPManager.h>                /* DSP/BIOS Bridge Manager APIs             */
-#include <DSPProcessor.h>      /* DSP/BIOS Bridge Processor APIs           */
-#include <DSPNode.h>           /* DSP/BIOS Bridge Node APIs                */
-#include <DSPStream.h>         /* DSP/BIOS Bridge Stream APIs              */
-
-#endif                         /* DBAPI_ */
Index: omapkernel/drivers/dsp/dspbridge/mpu_driver/inc/dbg.h
===================================================================
--- omapkernel.orig/drivers/dsp/dspbridge/mpu_driver/inc/dbg.h  2008-07-29 23:44:28.000000000 -0500
+++ omapkernel/drivers/dsp/dspbridge/mpu_driver/inc/dbg.h       2008-07-29 23:52:55.000000000 -0500
@@ -40,7 +40,6 @@
 #ifndef DBG_
 #define DBG_

-#include <dspapi.h>
 #include <linux/types.h>

 /* Levels of trace debug messages: */
Index: omapkernel/drivers/dsp/dspbridge/mpu_driver/inc/ddmatypes.h
===================================================================
--- omapkernel.orig/drivers/dsp/dspbridge/mpu_driver/inc/ddmatypes.h    2008-07-29 23:44:28.000000000 -0500
+++ /dev/null   1970-01-01 00:00:00.000000000 +0000
@@ -1,36 +0,0 @@
-/*
- * dspbridge/mpu_driver/inc/ddmatypes.h
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
-
-/*
- *  ======== ddmatypes.h ========
- *  Description:
- *      DSP/BIOS Bridge DSP-DMA(DDMA) shared data type definitions.
- *
- *! Revision History
- *! ================
- *! 24-Jan-2001 ag  Initial.
- */
-
-#ifndef DDMATYPES_
-#define DDMATYPES_
-
-/* DSP-side definitions */
-typedef u32 DDMA_DWORD;
-typedef u32 DDMA_WORD;
-typedef u32 DDMA_STATUS;
-
-#endif                         /* DDMATYPES_ */
Index: omapkernel/drivers/dsp/dspbridge/mpu_driver/inc/kfile.h
===================================================================
--- omapkernel.orig/drivers/dsp/dspbridge/mpu_driver/inc/kfile.h        2008-07-29 23:44:28.000000000 -0500
+++ omapkernel/drivers/dsp/dspbridge/mpu_driver/inc/kfile.h     2008-07-29 23:52:55.000000000 -0500
@@ -52,8 +52,6 @@
 #ifndef KFILE_
 #define KFILE_

-#include <dspapi.h>
-
 /*
  *  Constants for KFILE_Seek.  Note that these MUST be the same definitions as
  *  those defined for fseek.
Index: omapkernel/drivers/dsp/dspbridge/mpu_driver/inc/ldr.h
===================================================================
--- omapkernel.orig/drivers/dsp/dspbridge/mpu_driver/inc/ldr.h  2008-07-29 23:44:28.000000000 -0500
+++ omapkernel/drivers/dsp/dspbridge/mpu_driver/inc/ldr.h       2008-07-29 23:52:55.000000000 -0500
@@ -45,8 +45,6 @@
 #ifndef LDR_
 #define LDR_

-#include <dspapi.h>
-
 /* Loader objects: */
        struct LDR_MODULE;

Index: omapkernel/drivers/dsp/dspbridge/mpu_driver/inc/list.h
===================================================================
--- omapkernel.orig/drivers/dsp/dspbridge/mpu_driver/inc/list.h 2008-07-29 23:44:28.000000000 -0500
+++ omapkernel/drivers/dsp/dspbridge/mpu_driver/inc/list.h      2008-07-29 23:52:55.000000000 -0500
@@ -50,7 +50,6 @@
 #ifndef LIST_
 #define LIST_

-#include <dspapi.h>
 #include <linux/types.h>

 #define LST_IsEmpty(l)      (((l)->head.next == &(l)->head))
Index: omapkernel/drivers/dsp/dspbridge/mpu_driver/inc/mem.h
===================================================================
--- omapkernel.orig/drivers/dsp/dspbridge/mpu_driver/inc/mem.h  2008-07-29 23:52:26.000000000 -0500
+++ omapkernel/drivers/dsp/dspbridge/mpu_driver/inc/mem.h       2008-07-29 23:52:55.000000000 -0500
@@ -68,8 +68,6 @@
 #ifndef MEM_
 #define MEM_

-#include <dspapi.h>
-
 #include <memdefs.h>

 /*
Index: omapkernel/drivers/dsp/dspbridge/mpu_driver/inc/memry.h
===================================================================
--- omapkernel.orig/drivers/dsp/dspbridge/mpu_driver/inc/memry.h        2008-07-29 23:52:55.000000000 -0500
+++ /dev/null   1970-01-01 00:00:00.000000000 +0000
@@ -1,94 +0,0 @@
-/*
- * dspbridge/mp_driver/inc/memry.h
- *
- * DSP-BIOS Bridge driver support functions for TI OMAP processors.
- *
- * Copyright (C) 2008 Texas Instruments, Inc.
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
- *  ======== memry.h ========
- *  Purpose:
- *      Functional interface for the memory manager, exported by the DSP
- *      system API DLL.  This interface is not publicly documented.
- *
- *  Public Functions:
- *      MEMRY_Alloc
- *      MEMRY_BindMem
- *      MEMRY_Calloc
- *      MEMRY_Free
- *      MEMRY_FreeVM
- *      MEMRY_LinearAddress
- *      MEMRY_ReserveVM
- *      MEMRY_PageLock
- *      MEMRY_PageUnlock
- *      MEMRY_UnMapLinearAddress
- *
- *! Revision History:
- *! ================
- *! 01-Sep-2001 ag: Added MEMRY_[UnMap]LinearAddress.
- *! 11-Oct-2000 ag: Added MEMRY_Reserve[Free]VM() & MEMRY_BindMem().
- *! 12-Nov-1999 kc: Updated for WinCE.
- *!
- */
-
-#ifndef MEMRY_
-#define MEMRY_
-
-#include <memdefs.h>
-
-/*
- *  MEMRY_[GET]SET]VIRTUALSEGID is used by Node & Strm to access virtual
- *  address space in the correct client process context. The virtual to
- *  physical mapping is done in the client process context.
- */
-#define MEMRY_SETVIRTUALSEGID   MEM_SETVIRTUALSEGID
-#define MEMRY_GETVIRTUALSEGID   MEM_GETVIRTUALSEGID
-#define MEMRY_MASKVIRTUALSEGID  MEM_MASKVIRTUALSEGID
-
-/*
- *  ======== MEMRY_LinearAddress ========
- *  Purpose:
- *      Get the linear address corresponding to the given physical address.
- *  Parameters:
- *      pPhysAddr:      Physical address to be mapped.
- *      cBytes:         Number of bytes in physical range to map.
- *  Returns:
- *      The corresponding linear address, or NULL if unsuccessful.
- *  Requires:
- *     PhysAddr != 0
- *  Ensures:
- *  Notes:
- *      If valid linear address is returned, be sure to call
- *      MEMRY_UnMapLinearAddress().
- */
-       extern inline void *MEMRY_LinearAddress(void *pPhyAddr, u32 cBytes)
-       {
-               return pPhyAddr;
-       }
-
-/*
- *  ======== MEMRY_UnMapLinearAddress ========
- *  Purpose:
- *      Unmap the linear address mapped in MEMRY_LinearAddress.
- *  Parameters:
- *      pBaseAddr:  Ptr to mapped memory (as returned by MEMRY_LinearAddress()).
- *  Returns:
- *  Requires:
- *      - pBaseAddr is a valid linear address mapped in MEMRY_LinearAddress.
- *  Ensures:
- *      - pBaseAddr no longer points to a valid linear address.
- */
-       extern inline void MEMRY_UnMapLinearAddress(void *pBaseAddr)
-       {
-       }
-
-#endif                         /* MEMRY_ */
Index: omapkernel/drivers/dsp/dspbridge/mpu_driver/inc/prcs.h
===================================================================
--- omapkernel.orig/drivers/dsp/dspbridge/mpu_driver/inc/prcs.h 2008-07-29 23:44:28.000000000 -0500
+++ omapkernel/drivers/dsp/dspbridge/mpu_driver/inc/prcs.h      2008-07-29 23:52:55.000000000 -0500
@@ -38,8 +38,6 @@
 #ifndef _PRCS_H
 #define _PRCS_H

-#include <dspapi.h>
-
 /*
  *  ======== PRCS_Exit ========
  *  Purpose:
Index: omapkernel/drivers/dsp/dspbridge/mpu_driver/inc/reg.h
===================================================================
--- omapkernel.orig/drivers/dsp/dspbridge/mpu_driver/inc/reg.h  2008-07-29 23:44:28.000000000 -0500
+++ omapkernel/drivers/dsp/dspbridge/mpu_driver/inc/reg.h       2008-07-29 23:52:55.000000000 -0500
@@ -51,7 +51,6 @@
 #ifndef _REG_H
 #define _REG_H

-#include <dspapi.h>
 #include <linux/types.h>

 /*  ------------------------- Defines, Data Structures, Typedefs for Linux */
Index: omapkernel/drivers/dsp/dspbridge/mpu_driver/inc/services.h
===================================================================
--- omapkernel.orig/drivers/dsp/dspbridge/mpu_driver/inc/services.h     2008-07-29 23:44:28.000000000 -0500
+++ omapkernel/drivers/dsp/dspbridge/mpu_driver/inc/services.h  2008-07-29 23:52:55.000000000 -0500
@@ -32,8 +32,6 @@
 #ifndef SERVICES_
 #define SERVICES_

-#include <dspapi.h>
-
 /*
  *  ======== SERVICES_Exit ========
  *  Purpose:
Index: omapkernel/drivers/dsp/dspbridge/mpu_driver/inc/sync.h
===================================================================
--- omapkernel.orig/drivers/dsp/dspbridge/mpu_driver/inc/sync.h 2008-07-29 23:44:28.000000000 -0500
+++ omapkernel/drivers/dsp/dspbridge/mpu_driver/inc/sync.h      2008-07-29 23:52:55.000000000 -0500
@@ -55,8 +55,6 @@
 #ifndef _SYNC_H
 #define _SYNC_H

-#include <dspapi.h>
-
 /* Special timeout value indicating an infinite wait: */
 #define SYNC_INFINITE  0xffffffff

Index: omapkernel/drivers/dsp/dspbridge/mpu_driver/inc/util.h
===================================================================
--- omapkernel.orig/drivers/dsp/dspbridge/mpu_driver/inc/util.h 2008-07-29 23:44:28.000000000 -0500
+++ omapkernel/drivers/dsp/dspbridge/mpu_driver/inc/util.h      2008-07-29 23:52:55.000000000 -0500
@@ -52,7 +52,6 @@

 #include <linux/delay.h>
 #include <linux/sched.h>
-#include <dspapi.h>

 #include <utildefs.h>

Index: omapkernel/drivers/dsp/dspbridge/mpu_driver/src/Kbuild
===================================================================
--- omapkernel.orig/drivers/dsp/dspbridge/mpu_driver/src/Kbuild 2008-07-29 23:44:28.000000000 -0500
+++ omapkernel/drivers/dsp/dspbridge/mpu_driver/src/Kbuild      2008-07-29 23:52:55.000000000 -0500
@@ -7,9 +7,8 @@
                services/regsup.o services/prcs.o services/ntfy.o \
                services/dbg.o services/services.o
 libwmd = wmd/wmdchnl/chnl_sm.o wmd/wmdchnl/msg_sm.o wmd/wmdchnl/io_sm.o \
-               wmd/3430/tiomap.o wmd/3430/tiomap_pwr.o wmd/tiomap_mmu.o \
-               wmd/tiomap_sm.o wmd/tiomap_io.o wmd/tiomap_util.o \
-               wmd/mmu_fault.o wmd/ue_deh.o
+               wmd/3430/tiomap.o wmd/3430/tiomap_pwr.o wmd/tiomap_sm.o \
+               wmd/tiomap_io.o wmd/mmu_fault.o wmd/ue_deh.o
 libpmgr = pmgr/chnl.o pmgr/io.o pmgr/msg.o pmgr/cod.o pmgr/dev.o pmgr/wcd.o \
                pmgr/dmm.o pmgr/cmm.o pmgr/dbll.o
 librmgr = rmgr/dbdcd.o rmgr/disp.o rmgr/drv.o rmgr/mgr.o rmgr/node.o \
Index: omapkernel/drivers/dsp/dspbridge/mpu_driver/src/hw/dspss/IVA2RegAcM.h
===================================================================
--- omapkernel.orig/drivers/dsp/dspbridge/mpu_driver/src/hw/dspss/IVA2RegAcM.h  2008-07-29 23:44:28.000000000 -0500
+++ omapkernel/drivers/dsp/dspbridge/mpu_driver/src/hw/dspss/IVA2RegAcM.h       2008-07-29 23:52:55.000000000 -0500
@@ -21,7 +21,6 @@

 #include <GlobalTypes.h>
 #include <EasiGlobal.h>
-#include <EasiBase.h>

 #define SYSC_IVA2BOOTMOD_OFFSET            0x404
 #define SYSC_IVA2BOOTADDR_OFFSET           0x400
Index: omapkernel/drivers/dsp/dspbridge/mpu_driver/src/hw/inc/EasiBase.h
===================================================================
--- omapkernel.orig/drivers/dsp/dspbridge/mpu_driver/src/hw/inc/EasiBase.h      2008-07-29 23:44:28.000000000 -0500
+++ /dev/null   1970-01-01 00:00:00.000000000 +0000
@@ -1,179 +0,0 @@
-/*
- * dspbridge/src/hw/omap3/inc/EasiBase.h
- *
- * DSP-BIOS Bridge driver support functions for TI OMAP processors.
- *
- * Copyright (C) 2007 Texas Instruments, Inc.
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
-#ifndef __EASIBASE_H
-#define __EASIBASE_H
-
-/* ----------------------------------------------------------------------------
-* DEFINE:        ****_BASE_ID
-*
-* DESCRIPTION:  These are registser BASE IDs that will be used to identify
-*               errors when doing the EASI-Checker register tests
-*
-* NOTE:         The values of these defines will be defined at a later stage.
-*              TBD
-*
-* -----------------------------------------------------------------------------
-*/
-
-#define OSPL1_BASE_ID 0
-#define D3D1_BASE_ID 0
-#define MBSP1_BASE_ID 0
-#define MBSP2_BASE_ID 0
-#define MSDI1_BASE_ID 0
-#define RNG1_BASE_ID 0
-#define SHAM1_BASE_ID 0
-#define RFBI1_BASE_ID 0
-#define DISC1_BASE_ID 0
-#define DSS1_BASE_ID 0
-#define MLB1_BASE_ID 0
-#define IPI1_BASE_ID 0
-#define PDMA1_BASE_ID 0
-#define PRCM_BASE_ID 0
-#define SDMA1_BASE_ID 0
-#define SDRC1_BASE_ID 0
-#define ST1_BASE_ID 0
-#define SMS1_BASE_ID 0
-#define WDT1_BASE_ID 0
-#define WDT2_BASE_ID 0
-#define WDT3_BASE_ID 0
-#define WDT4_BASE_ID 0
-#define INTC1_BASE_ID 0
-#define INTC2_BASE_ID 0
-#define MMU1_BASE_ID 0
-#define GPMC1_BASE_ID 0
-#define GPT1_BASE_ID 0
-#define GPT2_BASE_ID 0
-#define GPT3_BASE_ID 0
-#define GPT4_BASE_ID 0
-#define GPT5_BASE_ID 0
-#define GPT6_BASE_ID 0
-#define GPT7_BASE_ID 0
-#define GPT8_BASE_ID 0
-#define GPT9_BASE_ID 0
-#define GPT10_BASE_ID 0
-#define GPT11_BASE_ID 0
-#define GPT12_BASE_ID 0
-#define WTR1_BASE_ID 0
-#define WTR2_BASE_ID 0
-#define WTR3_BASE_ID 0
-#define WTR4_BASE_ID 0
-#define I2C1_BASE_ID 0
-#define I2C2_BASE_ID 0
-#define T32K1_BASE_ID 0
-#define PRCM1_BASE_ID 0
-
-#define AES1_BASE_ID 0
-#define C2CF1_BASE_ID 0
-#define DSPF1_BASE_ID 0
-#define FAC1_BASE_ID 0
-#define GPMF1_BASE_ID 0
-#define GPIO1_BASE_ID 0
-#define GPIO2_BASE_ID 0
-#define GPIO3_BASE_ID 0
-#define GPIO4_BASE_ID 0
-#define HDQW1_BASE_ID 0
-#define PKA1_BASE_ID 0
-
-#define IM1_BASE_ID 0
-#define IM2_BASE_ID 0
-#define IM3_BASE_ID 0
-#define IM4_BASE_ID 0
-#define IM5_BASE_ID 0
-#define IM6_BASE_ID 0
-#define IM7_BASE_ID 0
-#define IM8_BASE_ID 0
-#define IMA1_BASE_ID 0
-#define IMTM1_BASE_ID 0
-#define IVAF1_BASE_ID 0
-#define LRCR1_BASE_ID 0
-#define LRCR2_BASE_ID 0
-#define LRCS1_BASE_ID 0
-#define LRCS2_BASE_ID 0
-#define RAMF1_BASE_ID 0
-#define ROMF1_BASE_ID 0
-#define TM1_BASE_ID 0
-#define TML1_BASE_ID 0
-#define TML2_BASE_ID 0
-#define TML3_BASE_ID 0
-#define TML4_BASE_ID 0
-#define TML5_BASE_ID 0
-#define TML6_BASE_ID 0
-
-
-
-/* ----------------------------------------------------------------------------
-* DEFINE: ***_BASE_EASIL1
-*
-* DESCRIPTION:  These are registser BASE EASIl1 numbers that can be used to
-*               identify what EASI C functions have been called.
-*
-* NOTE:         The values of these defines will be defined at a later stage.
-*              TBD
-*
-* -----------------------------------------------------------------------------
-*/
-
-#define OSPL1_BASE_EASIL1 0
-#define D3D_BASE_EASIL1 0
-#define MBSP_BASE_EASIL1 0
-#define MSDI_BASE_EASIL1 0
-#define RNG_BASE_EASIL1 0
-#define SHAM_BASE_EASIL1 0
-#define RFBI_BASE_EASIL1 0
-#define DISC_BASE_EASIL1 0
-#define DSS_BASE_EASIL1 0
-#define MLB_BASE_EASIL1 0
-#define IPI_BASE_EASIL1 0
-#define PDMA_BASE_EASIL1 0
-#define SDMA_BASE_EASIL1 0
-#define SDRC_BASE_EASIL1 0
-#define ST_BASE_EASIL1 0
-#define SMS_BASE_EASIL1 0
-#define WDT1_BASE_EASIL1 0
-#define INTC1_BASE_EASIL1 0
-#define INTC2_BASE_EASIL1 0
-#define MMU1_BASE_EASIL1 0
-#define GPMC_BASE_EASIL1 0
-#define GPT_BASE_EASIL1 0
-#define WTR_BASE_EASIL1 0
-#define MBSP2_BASE_EASIL1 0
-#define I2C1_BASE_EASIL1 0
-#define I2C2_BASE_EASIL1 0
-#define T32K1_BASE_EASIL1 0
-#define PRCM1_BASE_EASIL1 0
-
-#define AES1_BASE_EASIL1 0
-#define C2CF1_BASE_EASIL1 0
-#define DSPF1_BASE_EASIL1 0
-#define FAC1_BASE_EASIL1 0
-#define GPMF1_BASE_EASIL1 0
-#define GPIO1_BASE_EASIL1 0
-#define HDQW1_BASE_EASIL1 0
-#define PKA1_BASE_EASIL1 0
-
-#define IMA_BASE_EASIL1  0
-#define IM_BASE_EASIL1  0
-#define IMTM_BASE_EASIL1  0
-#define IVAF_BASE_EASIL1  0
-#define LRCR_BASE_EASIL1  0
-#define LRCS_BASE_EASIL1  0
-#define RAMF_BASE_EASIL1  0
-#define ROMF_BASE_EASIL1  0
-#define TML_BASE_EASIL1  0
-#define TM_BASE_EASIL1  0
-
-#endif /* __EASIBASE_H */
Index: omapkernel/drivers/dsp/dspbridge/mpu_driver/src/hw/mbox/MLBRegAcM.h
===================================================================
--- omapkernel.orig/drivers/dsp/dspbridge/mpu_driver/src/hw/mbox/MLBRegAcM.h    2008-07-29 23:44:28.000000000 -0500
+++ omapkernel/drivers/dsp/dspbridge/mpu_driver/src/hw/mbox/MLBRegAcM.h 2008-07-29 23:52:55.000000000 -0500
@@ -19,7 +19,6 @@

 #include <GlobalTypes.h>
 #include <EasiGlobal.h>
-#include <EasiBase.h>
 #include "MLBAccInt.h"

 #if defined(USE_LEVEL_1_MACROS)
Index: omapkernel/drivers/dsp/dspbridge/mpu_driver/src/hw/mmu/MMURegAcM.h
===================================================================
--- omapkernel.orig/drivers/dsp/dspbridge/mpu_driver/src/hw/mmu/MMURegAcM.h     2008-07-29 23:44:28.000000000 -0500
+++ omapkernel/drivers/dsp/dspbridge/mpu_driver/src/hw/mmu/MMURegAcM.h  2008-07-29 23:52:55.000000000 -0500
@@ -21,7 +21,6 @@
 #include <GlobalTypes.h>

 #include <EasiGlobal.h>
-#include <EasiBase.h>

 #include "MMUAccInt.h"

Index: omapkernel/drivers/dsp/dspbridge/mpu_driver/src/hw/prcm/PRCMRegAcM.h
===================================================================
--- omapkernel.orig/drivers/dsp/dspbridge/mpu_driver/src/hw/prcm/PRCMRegAcM.h   2008-07-29 23:44:28.000000000 -0500
+++ omapkernel/drivers/dsp/dspbridge/mpu_driver/src/hw/prcm/PRCMRegAcM.h        2008-07-29 23:52:55.000000000 -0500
@@ -20,7 +20,6 @@
 #include <GlobalTypes.h>

 #include <EasiGlobal.h>
-#include <EasiBase.h>

 #include "PRCMAccInt.h"

Index: omapkernel/drivers/dsp/dspbridge/mpu_driver/src/wmd/3430/tiomap.c
===================================================================
--- omapkernel.orig/drivers/dsp/dspbridge/mpu_driver/src/wmd/3430/tiomap.c      2008-07-29 23:52:46.000000000 -0500
+++ omapkernel/drivers/dsp/dspbridge/mpu_driver/src/wmd/3430/tiomap.c   2008-07-29 23:52:55.000000000 -0500
@@ -76,8 +76,6 @@
 #include "_tiomap_mmu.h"
 #include "_tiomap_util.h"
 #include "tiomap_io.h"
-#include "_tiomap_api.h"
-#include "_tiomap_clk.h"

 /* Offset in shared mem to write to in order to synchronize start with DSP */
 #define SHMSYNCOFFSET 4                /* GPP byte offset */
@@ -2145,3 +2143,50 @@
           DBG_Trace(DBG_LEVEL6, "CM_ICLKEN1_CORE = 0x%x \n", temp);
 }

+/*
+ *  ======== configureDspMmu ========
+ *      Make DSP MMU page table entries.
+ */
+void configureDspMmu(struct WMD_DEV_CONTEXT *pDevContext, u32 dataBasePhys,
+                   u32 dspBaseVirt, u32 sizeInBytes, s32 nEntryStart,
+                   enum HW_Endianism_t endianism,
+                   enum HW_ElementSize_t elemSize,
+                   enum HW_MMUMixedSize_t mixedSize)
+{
+       struct CFG_HOSTRES resources;
+       struct HW_MMUMapAttrs_t mapAttrs = { endianism, elemSize, mixedSize };
+       DSP_STATUS status = DSP_SOK;
+
+       DBC_Require(sizeInBytes > 0);
+       DBG_Trace(DBG_LEVEL1,
+                "configureDspMmu entry %x pa %x, va %x, bytes %x ",
+                nEntryStart, dataBasePhys, dspBaseVirt, sizeInBytes);
+
+       DBG_Trace(DBG_LEVEL1, "endianism %x, elemSize %x, mixedSize %x\n",
+                endianism, elemSize, mixedSize);
+       status = CFG_GetHostResources(
+                (struct CFG_DEVNODE *)DRV_GetFirstDevExtension(), &resources);
+       status = HW_MMU_TLBAdd(pDevContext->dwDSPMmuBase, dataBasePhys,
+                               dspBaseVirt, sizeInBytes, nEntryStart,
+                               &mapAttrs, HW_SET, HW_SET);
+}
+
+/*
+ *  ======== WaitForStart ========
+ *      Wait for the singal from DSP that it has started, or time out.
+ */
+BOOL WaitForStart(struct WMD_DEV_CONTEXT *pDevContext, u32 dwSyncAddr)
+{
+       u16 usCount = TIHELEN_ACKTIMEOUT;
+
+       /*  Wait for response from board */
+       while (*((volatile u16 *)dwSyncAddr) && --usCount)
+               UTIL_Wait(TIHELEN_WRITE_DELAY);
+
+       /*  If timed out: return FALSE */
+       if (!usCount) {
+               DBG_Trace(DBG_LEVEL7, "Timed out Waiting for DSP to Start\n");
+               return FALSE;
+       }
+       return TRUE;
+}
Index: omapkernel/drivers/dsp/dspbridge/mpu_driver/src/wmd/3430/tiomap_pwr.c
===================================================================
--- omapkernel.orig/drivers/dsp/dspbridge/mpu_driver/src/wmd/3430/tiomap_pwr.c  2008-07-29 23:52:46.000000000 -0500
+++ omapkernel/drivers/dsp/dspbridge/mpu_driver/src/wmd/3430/tiomap_pwr.c       2008-07-29 23:52:55.000000000 -0500
@@ -59,10 +59,8 @@

 /*  ----------------------------------- specific to this file */
 #include "_tiomap.h"
-#include "_tiomap_clk.h"
 #include "_tiomap_pwr.h"
 #include "_tiomap_util.h"
-#include "_tiomap_api.h"
 #ifndef DISABLE_BRIDGE_PM
 #ifndef DISABLE_BRIDGE_DVFS
 #include <asm/arch/resource.h>
Index: omapkernel/drivers/dsp/dspbridge/mpu_driver/src/wmd/_tiomap_mmu.h
===================================================================
--- omapkernel.orig/drivers/dsp/dspbridge/mpu_driver/src/wmd/_tiomap_mmu.h      2008-07-29 23:52:26.000000000 -0500
+++ omapkernel/drivers/dsp/dspbridge/mpu_driver/src/wmd/_tiomap_mmu.h   2008-07-29 23:52:55.000000000 -0500
@@ -33,57 +33,6 @@

 #include "_tiomap.h"

-#define ARM_DSP_MMU_START               0xfffed200
-#define ARM_DSP_MMU_LENGTH              0xff
-
-/* Size in bytes of DSP MMU PAGES */
-#define TIHEL_SMALLPAGESIZE             0x1000 /* 4Kb  */
-#define TIHEL_LARGEPAGESIZE             0x10000        /* 64Kb */
-#define TIHEL_SECTION                   0x100000       /* 1Mb  */
-
-/* DSP MMU related */
-#define CNTL_REG_OFFSET                 0x08
-#define MMU_FAULT_AD_H_REG_OFFSET       0x0c
-#define MMU_FAULT_AD_L_REG_OFFSET       0x10
-#define MMU_F_ST_REG_OFFSET             0x14
-#define MMU_IT_ACK_REG_OFFSET           0x18
-#define LOCK_REG_OFFSET                 0x24
-#define LD_TLB_REG_OFFSET               0x28
-#define CAM_H_REG_OFFSET                0x2C
-#define CAM_L_REG_OFFSET                0x30
-#define RAM_H_REG_OFFSET                0x34
-#define RAM_L_REG_OFFSET                0x38
-#define FLUSH_ENTRY_REG_OFFSET          0x40
-
-#define MMU_IT_ACK_MASK                 0x01
-
-/* Control Register */
-#define RESET_SW_MMU_MASK               0x0001
-#define MMU_ENABLE_MASK                 0x0002
-#define WTL_ENABLE_MASK                 0x0004
-#define STREAMING_BUFF_EN_MASK          0x0010
-#define ENDIANISM_EN_MASK               0x0020
-#define BURST_16MNGT_EN_MASK            0x0040
-
-enum SLST_t {
-       SECTION = 0,
-       LARGE_PAGE = 1,
-       SMALL_PAGE = 2,
-       TINY_PAGE = 3
-} ;
-
-enum PRESERVED_t {
-       ENTRY_NOT_PRESERVED = 0,
-       ENTRY_PRESERVED = 1
-} ;
-
-enum AP_t {
-       NOT_ACCESSIBLE = 0,
-       READ_ONLY = 2,
-       FULL_ACCESS = 3
-} ;
-
-/* Function prototypes */
 /*
  *  ======== configureDspMmu ========
  *
Index: omapkernel/drivers/dsp/dspbridge/mpu_driver/src/wmd/tiomap_mmu.c
===================================================================
--- omapkernel.orig/drivers/dsp/dspbridge/mpu_driver/src/wmd/tiomap_mmu.c       2008-07-29 23:52:26.000000000 -0500
+++ /dev/null   1970-01-01 00:00:00.000000000 +0000
@@ -1,82 +0,0 @@
-/*
- * dspbridge/src/wmd/linux/omap/2430/tiomap_mmu.c
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
-
-/*
- *  ======== _tiomap_mmu.c ========
- *  Description:
- *      Implementation of the  DSP MMU modules.
- *
- *! Revision History
- *! ================
- *! 19-Apr-2004 sb:  configureDspMmu calls HW_MMU_TLBAdd directly now.
- *! 05-Jan-2004 vp:  Moved to platform specific folder and updated for the 24xx
- *!                                    platform
- *! 21-Mar-2003 sb:  Support 64 KB DSP MMU entries
- *! 19-Feb-2003 vp:  Ported to Linux platform.
- *! 08-Oct-2002 rr:  Created.
- */
-#include <host_os.h>
-/*  ----------------------------------- DSP/BIOS Bridge */
-#include <dbdefs.h>
-#include <errbase.h>
-#include <cfgdefs.h>
-/*  ----------------------------------- Trace & Debug */
-#include <dbc.h>
-#include <dbg.h>
-
-/*  ----------------------------------- OS Adaptation Layer */
-#include <mem.h>
-#include <util.h>
-#include <cfg.h>
-#include <drv.h>
-
-/* ------------------------------------ Hardware Abstraction Layer */
-#include <hw_defs.h>
-#include <hw_mmu.h>
-
-/*  ----------------------------------- Local Headers */
-#include "_tiomap.h"
-#include "_tiomap_mmu.h"
-
-/*
- *  ======== configureDspMmu ========
- *  Purpose:
- *      Make DSP MMU page table entries.
- */
-void configureDspMmu(struct WMD_DEV_CONTEXT *pDevContext, u32 dataBasePhys,
-                   u32 dspBaseVirt, u32 sizeInBytes, s32 nEntryStart,
-                   enum HW_Endianism_t endianism,
-                   enum HW_ElementSize_t elemSize,
-                   enum HW_MMUMixedSize_t mixedSize)
-{
-       struct CFG_HOSTRES resources;
-       struct HW_MMUMapAttrs_t mapAttrs = { endianism, elemSize, mixedSize };
-       DSP_STATUS status = DSP_SOK;
-
-       DBC_Require(sizeInBytes > 0);
-       DBG_Trace(DBG_LEVEL1,
-                "configureDspMmu entry %x pa %x, va %x, bytes %x ",
-                nEntryStart, dataBasePhys, dspBaseVirt, sizeInBytes);
-
-       DBG_Trace(DBG_LEVEL1, "endianism %x, elemSize %x, mixedSize %x\n",
-                endianism, elemSize, mixedSize);
-       status = CFG_GetHostResources(
-                (struct CFG_DEVNODE *)DRV_GetFirstDevExtension(), &resources);
-       status = HW_MMU_TLBAdd(pDevContext->dwDSPMmuBase, dataBasePhys,
-                               dspBaseVirt, sizeInBytes, nEntryStart,
-                               &mapAttrs, HW_SET, HW_SET);
-}
Index: omapkernel/drivers/dsp/dspbridge/mpu_driver/src/wmd/tiomap_util.c
===================================================================
--- omapkernel.orig/drivers/dsp/dspbridge/mpu_driver/src/wmd/tiomap_util.c      2008-07-29 23:44:28.000000000 -0500
+++ /dev/null   1970-01-01 00:00:00.000000000 +0000
@@ -1,65 +0,0 @@
-/*
- * dspbridge/src/wmd/linux/omap/common/tiomap_util.c
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
-
-/*
- *  ======== _tiomap_util.c ========
- *  Description:
- *      Implementation for the utility routines.
- *
- *! Revision History
- *! ================
- *! 05-Jan-2004 vp:  Updated for 24xx platform.
- *! 08-Oct-2002 rr:  Created.
- */
-
-/*  ----------------------------------- DSP/BIOS Bridge */
-#include <dbdefs.h>
-#include <errbase.h>
-
-/*  ----------------------------------- Trace & Debug */
-#include <dbg.h>
-
-/*  ----------------------------------- OS Adaptation Layer */
-#include <mem.h>
-#include <util.h>
-
-/*  ----------------------------------- Local */
-#include "_tiomap.h"
-#include "_tiomap_api.h"
-#include "_tiomap_util.h"
-
-/*
- *  ======== WaitForStart ========
- *  purpose:
- *      Wait for the singal from DSP that it has started, or time out.
- */
-BOOL WaitForStart(struct WMD_DEV_CONTEXT *pDevContext, u32 dwSyncAddr)
-{
-       u16 usCount = TIHELEN_ACKTIMEOUT;
-
-       /*  Wait for response from board */
-       while (*((volatile u16 *)dwSyncAddr) && --usCount)
-               UTIL_Wait(TIHELEN_WRITE_DELAY);
-
-       /*  If timed out: return FALSE */
-       if (!usCount) {
-               DBG_Trace(DBG_LEVEL7, "Timed out Waiting for DSP to Start\n");
-               return FALSE;
-       }
-       return TRUE;
-}
-
Index: omapkernel/drivers/dsp/dspbridge/mpu_driver/inc/ddma_sh.h
===================================================================
--- omapkernel.orig/drivers/dsp/dspbridge/mpu_driver/inc/ddma_sh.h      2008-07-25 18:44:39.000000000 -0500
+++ /dev/null   1970-01-01 00:00:00.000000000 +0000
@@ -1,95 +0,0 @@
-/*
- * dspbridge/mpu_driver/inc/ddma_sh.h
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
-
-/*
- *  ======== ddma_sh.h ========
- *
- *  DSP/BIOS Bridge DSP-DMA(DDMA) shared definitions.
- *  (used on both GPP and DSP sides).
- *
- *
- *! Revision History
- *! ================
- *! 12-Jan-2001 ag  Added Zero-copy channel descriptor
- *!                    and #ifdef CHNL_DDMA for GPP-side build.
- *! 05-Jan-2002 ag  Made chnl buf desc ndxs private.
- *! 07-Dec-2001 ag  DDMA_DSPDESCDONE value changed.
- *! 24-Jan-2001 ag  Initial.
- */
-
-#ifndef DDMA_SH_
-#define DDMA_SH_
-
-#include <ddmatypes.h>
-
-/* Max # of DDSP DMA channels allowed */
-#define DDMA_MAXZCPYCHNLS   16
-#define DDMA_MAXDDMACHNLS   16
-
-/* descriptor status */
-#define DDMA_SOK            0x0        /* transfer ok */
-#define DDMA_SCANCELED      0x1        /* I/O request canceled */
-#define DDMA_SBUFMISMATCH   0x2        /* Src Buf larger than dst. Data clipped */
-
-/* descriptor errors */
-#define DDMA_ERRDMA         0x8000  /* DMA error(s) occured */
-#define DDMA_ERRILLDESC            0x800   /* Illegal desc format */
-#define DDMA_ERRTIMEOUT            0x400   /* DMA timeout occured on this descriptor */
-#define DDMA_ERRALIGN       0x200   /* Bad SM buffer alignment */
-
-/* cmd codes (workReq field)*/
-#define DDMA_WORKREQ        1  /* Channel work requested by Gpp */
-#define DDMA_WORKREQCLEAR   2  /* Work requested Cleared by Dsp */
-#define DDMA_DSPDESCDONE    2  /* DSP completed DDMA descr proc'ing */
-
-/*
- * DSP-DMA GPP<->DSP structures
- */
-
-/* SM buffer descriptor structure */
-struct DDMA_BUFDESC {
-       DDMA_DWORD workReq;     /* Requesting work(DSP-DMA) to be performed */
-       DDMA_DWORD status;      /* Desc completion status  */
-       DDMA_DWORD bufPaDsp;    /* DSP address of SM buffer. */
-       DDMA_DWORD xferSize;    /* Size of transfer request in Gpp bytes */
-       DDMA_DWORD bufArg;      /* Optional argument associated with buffer */
-} ;
-
-/* bridge channel descriptor ctrl */
-struct DDMA_CHNLDESC {
-       DDMA_WORD numBufDesc;   /* # of SM buf descriptors for this channel */
-       DDMA_DWORD descPaDsp;   /* DSP address of base SM descriptor. */
-} ;
-
-/*
- * Zero-copy channel descriptor(SM buffer swap)
- */
-struct DDMA_ZCPYCHNLDESC {
-       /* DSP-Side */
-       DDMA_DWORD inBuf;       /* address of input buffer */
-       DDMA_DWORD inDataSize;  /* Data size of inBuf  (DSP MAUs) */
-       DDMA_DWORD inBufSize;   /* Actual buffer size of inBuf  (DSP MAUs) */
-       DDMA_DWORD inUserArg;   /* Optional in user argument */
-
-       DDMA_DWORD outBuf;      /* address of output buffer  */
-       DDMA_DWORD outDataSize; /* Data size of outBuf  (DSP MAUs) */
-       DDMA_DWORD outBufSize;  /* Actual buffer size of outBuf  (DSP MAUs) */
-       DDMA_DWORD outUserArg;  /* Optional out user argument */
-       } ;
-
-#endif                         /* DDMA_SH_ */
-
Index: omapkernel/drivers/dsp/dspbridge/mpu_driver/inc/dspapi.h
===================================================================
--- omapkernel.orig/drivers/dsp/dspbridge/mpu_driver/inc/dspapi.h       2008-07-29 23:44:26.000000000 -0500
+++ /dev/null   1970-01-01 00:00:00.000000000 +0000
@@ -1,50 +0,0 @@
-/*
- * dspbridge/mpu_driver/inc/dspapi.h
- *
- * DSP-BIOS Bridge driver support functions for TI OMAP processors.
- *
- * Copyright (C) 2008 Texas Instruments, Inc.
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
-
-/*
- *  ======== dspapi.h ========
- *  Purpose:
- *      Defines function type modifiers used in all DSPSYS public header
- *      files.
- *
- *  Notes:
- *      Provides __stdcall (required by VB 4.0) and __declspec(dllimport)
- *      function modifiers for fast dyna-linking.
- *
- *! Revision History:
- *! =================
- *! 23-Dec-1997 cr: Added WBKERNEL_API definition.
- *! 11-Oct-1996 gp: Created.
- */
-
-#ifndef DSPAPI_
-#define DSPAPI_
-
-/* Define API decoration for direct importing of DLL references. */
-#if !defined(_DSPSYSDLL32_)
-#define DSPAPIDLL __declspec(dllimport)
-#else
-#define DSPAPIDLL
-#endif
-
-/* Full export modifier: */
-#define DSPAPI DSPAPIDLL DSP_STATUS WINAPI
-
-/* Explicitly define class driver calling conventions */
-#define WBKERNEL_API CDECL
-
-#endif                         /* DSPAPI_ */
Index: omapkernel/drivers/dsp/dspbridge/mpu_driver/src/wmd/_tiomap_api.h
===================================================================
--- omapkernel.orig/drivers/dsp/dspbridge/mpu_driver/src/wmd/_tiomap_api.h      2008-07-29 23:52:26.000000000 -0500
+++ /dev/null   1970-01-01 00:00:00.000000000 +0000
@@ -1,182 +0,0 @@
-/*
- * dspbridge/src/wmd/linux/omap/common/_tiomap_api.h
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
-
-/*
- *  ======== _tiomap_api.h ========
- *  Description:
- *      Definitions, types and function prototypes for the API module.
- *
- *! Revision History
- *! ================
- *! 27-Mar-2003 vp:  Updated for Power Management
- *!                 - Added setAPI function
- *!                 - Added API_DSP_BOOT_IDLE enumeration
- *!                 - Modified setDSPBootMode function to take boot mode option
- *! 19-Feb-2003 vp:  Ported to Linux platform.
- *! 08-Oct-2002 rr:  Created.
- */
-
-#ifndef _TIOMAP_API_
-#define _TIOMAP_API_
-
-/* I/O ARM Memory Mapping and ARM Peripheral mapping */
-#define ARM_API_START                   0xfffec900
-#define ARM_API_LENGTH                  0xff
-
-/* API I/F Registers */
-#define API_CTRL_OFFSET                 0x0000 /* 32 bit control register   */
-#define API_STATUS_OFFSET               0x0010 /* 16 bit status register(RO) */
-#define API_DSP_STATUS_OFFSET           0x0014 /* 16 bit DSP status register */
-#define API_DSP_BOOT_OFFSET             0x0018 /* 16 bit Boot configuration
-                                                * register
-                                                */
-#define API_SIZE                        0x001c
-#define API_DSP_API_OFFSET              0x0020 /* 16 bit API Configuration
-                                                * register
-                                                */
-
-/* API_DSP_STATUS_REG related */
-#define API_DSP_STATUS_HOM_MODE         0x0c00 /* HOM Mode bits - set if HOM */
-
-/* SAM/HOM bit in API_DSP_STATUS register value */
-#define SAM_BIT                         0x0400
-
-/*  Define position bit fields */
-#define API_HIGH_FREQ_POSBIT            0
-#define API_TIMEOUT_EN_POSBIT           1
-#define API_API_ERR_EN_POSBIT           3
-#define API_ACCESS_FACTOR_POSBIT        4
-#define API_TIMEOUT_POSBIT              8
-#define API_ENDIANISM_POSBIT            16
-#define API_ACCESS_PRIORITY_POSBIT      18
-
-enum API_HighFreq_t {
-       API_HIGH_FREQ_LOW = 0,
-       API_HIGH_FREQ_HIGH = 1
-} ;
-
-enum API_TimeoutEn_t {
-       API_TIMEOUT_DIS = 0,
-       API_TIMEOUT_EN = 1
-} ;
-
-enum API_ApiErrEn_t {
-       API_API_ERR_DIS = 0,
-       API_API_ERR_EN = 1
-} ;
-
-enum API_AccessFactor_t {
-       API_ACCESS_FACTOR_0 = 0,
-       API_ACCESS_FACTOR_1,
-       API_ACCESS_FACTOR_2,
-       API_ACCESS_FACTOR_3,
-       API_ACCESS_FACTOR_4,
-       API_ACCESS_FACTOR_5,
-       API_ACCESS_FACTOR_6,
-       API_ACCESS_FACTOR_7,
-       API_ACCESS_FACTOR_8,
-       API_ACCESS_FACTOR_9,
-       API_ACCESS_FACTOR_10,
-       API_ACCESS_FACTOR_11,
-       API_ACCESS_FACTOR_12,
-       API_ACCESS_FACTOR_13,
-       API_ACCESS_FACTOR_14,
-       API_ACCESS_FACTOR_15
-} ;
-
-enum API_Timeout_t {
-       API_TIMEOUT_MIN = 0,
-       API_TIMEOUT_MAX = 255
-} ;
-
-enum API_Endianism_t {
-       API_ENDIANISM_NO_CONVERT = 0,
-       API_ENDIANISM_CONVERT_ALL_ACCESS = 2,
-       API_ENDIANISM_CONVERT_API_MEM_ONLY = 3
-} ;
-
-enum API_AccessPriority_t {
-       API_ACCESS_PRIORITY_ARM_DMA_HSAB = 0,
-       API_ACCESS_PRIORITY_ARM_HSAB_DMA,
-       API_ACCESS_PRIORITY_DMA_ARM_HSAB,
-       API_ACCESS_PRIORITY_HSAB_ARM_DMA,
-       API_ACCESS_PRIORITY_DMA_HSAB_ARM,
-       API_ACCESS_PRIORITY_HSAB_DMA_ARM
-} ;
-
-enum API_DSPBootMode_t {
-       API_DSP_BOOT_INTERNAL = 5,
-       API_DSP_BOOT_EXTERNAL = 4,
-       API_DSP_BOOT_EMIF16 = 3,
-       API_DSP_BOOT_IDLE = 2,
-       API_DSP_BOOT_PSEUDO_EXT = 1,
-       API_DSP_BOOT_MPNMC = 0
-} ;
-
-/* Function prototypes */
-
-/*
- *  ======== setAPIsize ========
- *  Configures the SARAM blocks which can be accessed in the HOM mode
- *  Register 0xfffe:c900 offset 0x1c.
- */
-extern void setAPIsize(struct WMD_DEV_CONTEXT *pDevContext, u16 size);
-
-/*
- *  ======== setDspBootModeAPI ========
- *  Sets up the DSP boot mode
- *  Register 0xfffe:c900 offset 18.
- *  Boot mode is set API_DSP_BOOT_INTERNAL; DSP will start executing from
- *  SARAM location 0x10000 byte address.
- */
-extern void setDspBootModeAPI(struct WMD_DEV_CONTEXT *pDevContext,
-                             enum API_DSPBootMode_t dsp_boot_mode);
-
-/*
- *  ======== setAPI ========
- *  Configures the API interface.
- *  Register 0xfffe:c900 offset 0x0.
- *      -   Set the API access priority to ARM-DMA-HSAB
- *      -   Sets the no byte swap
- *      -   Time out is set to MAX
- *      -   Access factor is 4
- *      -   Enable the time out
- *      -   Set it to high frequency mode
- */
-extern void setAPI(struct WMD_DEV_CONTEXT *pDevContext,
-                  enum API_HighFreq_t high_freq,
-                  enum API_TimeoutEn_t timeout_en,
-                  enum API_ApiErrEn_t api_err_en,
-                  enum API_AccessFactor_t access_factor,
-                  enum API_Timeout_t timeout,
-                  enum API_Endianism_t endianism,
-                  enum API_AccessPriority_t access_priority);
-
-/*
- *  ======== setupAPI ========
- *  Configures the API interface.
- *  Register 0xfffe:c900 offset 0x0.
- *      -   Set the API access priority to ARM-DMA-HSAB
- *      -   Sets the no byte swap
- *      -   Time out is set to MAX
- *      -   Access factor is 4
- *      -   Enable the time out
- *      -   Set it to high frequency mode
- */
-extern void setupAPI(struct WMD_DEV_CONTEXT *pDevContext);
-
-#endif                         /* _TIOMAP_API_ */
Index: omapkernel/drivers/dsp/dspbridge/mpu_driver/src/wmd/_tiomap_clk.h
===================================================================
--- omapkernel.orig/drivers/dsp/dspbridge/mpu_driver/src/wmd/_tiomap_clk.h      2008-07-25 18:44:39.000000000 -0500
+++ /dev/null   1970-01-01 00:00:00.000000000 +0000
@@ -1,123 +0,0 @@
-/*
- * dspbridge/src/wmd/linux/omap/common/_tiomap_clk.h
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
-
-/*
- *  ======== _tiomap_clk.h ========
- *  Description:
- *      Definitions and types for the CLOCK and RESET modules. This
- *  includes enabling/disabling peripheral clocks,reseting and releasing
- *  the DSP.
- *! Revision History
- *! ================
- *! 08-Oct-2002 rr:  Created.
- */
-
-#ifndef _TIOMAP_CLK_
-#define _TIOMAP_CLK_
-
-#include "_tiomap.h"
-
-/* ARM CLK Module */
-#define ARM_CLKM_START                  0xfffece00
-#define ARM_CLKM_LENGTH                 0xff
-#define ARM_SYSST_OFFSET                0x18
-#define IDLE_DSP_MASK                   0x40
-
-/* DSP CLK Module */
-#define DSP_CLKM2_BASE                  0xe1008000
-#define DSP_CLKM2_LENGTH                0xff
-#define DSP_IDLECT2_OFFSET              0x8    /* Clock domain control */
-
-/* CLK related defines */
-/*  ARM_CKCTL */
-#define ARM_CKCTL_OFFEST                0x0
-
-#define EN_DSPCK_POS                    13
-#define EN_DSPCK_NUMB                   1
-
-/*  ARM_RSTCT1 */
-#define ARM_RSTCT1_OFFSET               0x10
-
-#define DSP_RST_POS                     2
-#define DSP_RST_NUMB                    1
-#define DSP_EN_POS                      1
-#define DSP_EN_NUMB                     1
-
-/*  ARM_IDLECT2 */
-#define ARM_IDLECT2_OFFSET              0x8
-
-#define EN_APICK_POS                    6
-#define EN_APICK_NUMB                   1
-
-/* Function prototypes */
-/*
- *  ======== dspPeripheralClockDisable ========
- *  Disables the clock for the DSP external periperal clock (DSPPER_CK)
- *  Register 0xe100:8000 offset 0x8 bit position 1 is set to zero.
- */
-extern void dspPeripheralClockDisable(struct WMD_DEV_CONTEXT *pDevContext);
-
-/*
- *  ======== dspPeripheralClockEnable ========
- * Enables the clock for DSP external refernce clock, periperal clock, USART clk
- *  GPIO clk and GPIO peripheral clock.
- *  Register 0xe100:8000 offset 0x8 bit position 0,1,2,3,4 and 5 are set to 1.
- */
-extern void dspPeripheralClockEnable(struct WMD_DEV_CONTEXT *pDevContext);
-
-/*
- *  ======== releaseDSP ========
- *  Releases the DSP from reset. Th DSP starts running.from whatever
- *  boot mode is set to. If it is set to internal boot mode, the DSP
- *  starts executing from location 0x10000 byte address.
- *  0xfffe:ce00 bit postion 1 is set to one.
- */
-extern DSP_STATUS releaseDSP(struct WMD_DEV_CONTEXT *pDevContext,
-                            BOOL fCheckForSAM);
-
-/*
- *  ======== releaseDspInterFace ========
- *  Enables the pritoiry registers, EMIF configuration registers and
- *  the API control logic in the DSP subsystem so that they can be programmed.
- *  0xfffe:ce00 bit postion 2 is set to one.
- */
-extern void releaseDSPInterface(struct WMD_DEV_CONTEXT *pDevContext);
-
-/*
- *  ======== resetDSP ========
- *  Resets the DSP. This stops the DSP from running.
- *  0xfffe:ce00 bit postion 1 is set to zero
- */
-extern void resetDSP(struct WMD_DEV_CONTEXT *pDevContext);
-
-/*
- *  ======== resetDSPInterface ========
- *  Resets the pritoiry registers, EMIF configuration registers and
- *  the API control logic in the DSP subsystem. This is required to configure
- *  the API and MMU.
- *  0xfffe:ce00 bit postion 2 is set to zero.
- */
-extern void resetDSPInterface(struct WMD_DEV_CONTEXT *pDevContext);
-
- /*
-  *  ======== setTCEndianism =========
-  *  Sets the endianism register.
-  */
-extern void setTCEndianism(struct WMD_DEV_CONTEXT *pDevContext, u32 value);
-
-#endif                         /* _TIOMAP_CLK_ */
-

---

Regards,

omar

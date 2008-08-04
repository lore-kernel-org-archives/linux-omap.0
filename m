From: "Ramirez Luna, Omar" <x00omar@ti.com>
Subject: [PATCH 04/07][GIT 3/4+] Removed bridge obsolete code
Date: Mon, 4 Aug 2008 09:55:38 -0500
Message-ID: <27F9C60D11D683428E133F85D2BB4A530804B514@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from calf.ext.ti.com ([198.47.26.144]:33886 "EHLO calf.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753624AbYHDOzp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Aug 2008 10:55:45 -0400
Received: from dlep35.itg.ti.com ([157.170.170.118])
	by calf.ext.ti.com (8.13.7/8.13.7) with ESMTP id m74EteEP000744
	for <linux-omap@vger.kernel.org>; Mon, 4 Aug 2008 09:55:45 -0500
Received: from dlee74.ent.ti.com (localhost [127.0.0.1])
	by dlep35.itg.ti.com (8.13.7/8.13.7) with ESMTP id m74EtdG9010531
	for <linux-omap@vger.kernel.org>; Mon, 4 Aug 2008 09:55:40 -0500 (CDT)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

This patch removes the code that is not used by any component of bridge driver.

---
Index: omapkernel/drivers/dsp/dspbridge/mpu_driver/inc/brddefs.h
===================================================================
--- omapkernel.orig/drivers/dsp/dspbridge/mpu_driver/inc/brddefs.h      2008-07-29 23:44:27.000000000 -0500
+++ omapkernel/drivers/dsp/dspbridge/mpu_driver/inc/brddefs.h   2008-07-29 23:53:12.000000000 -0500
@@ -46,12 +46,6 @@
 #define BRD_RETENTION     0x8       /* Retention mode */
 #define BRD_DSP_HIBERNATION     0x9       /* DSP initiated hibernation */

-/* platform access options */
-#define BRD_ACCMODIFY    0x1   /* modify the board's state */
-#define BRD_ACCSTATUS    0x2   /* monitor changes in board status */
-#define BRD_ACCEXCLUSIVE 0x80  /* exclusive ownership of board */
-#define BRD_ACCMASK    (~0x83)
-
        typedef u32 BRD_STATUS;

 /* BRD Object */
Index: omapkernel/drivers/dsp/dspbridge/mpu_driver/inc/dev.h
===================================================================
--- omapkernel.orig/drivers/dsp/dspbridge/mpu_driver/inc/dev.h  2008-07-29 23:52:26.000000000 -0500
+++ omapkernel/drivers/dsp/dspbridge/mpu_driver/inc/dev.h       2008-07-29 23:53:12.000000000 -0500
@@ -791,27 +791,6 @@
                                        struct MSG_MGR *hMgr);

 /*
- *  ======== DEV_SetLockOwner ========
- *  Purpose:
- *      Sets the lock owner to a particular board interface.
- *  Parameters:
- *      hDevObject:     Handle to device object created with
- *                      DEV_CreateDevice().
- *      hBrdObject:     Board interface which owns exclusive modify access to
- *                      the board.
- *  Returns:
- *      DSP_SOK:        Success.
- *      DSP_EHANDLE:    hDevObject was invalid.
- *  Requires:
- *      DEV Initialized.
- *  Ensures:
- *      DSP_SOK: Device lock is set.  Only this registered board interface
- *      can alter the device state.
- */
-       extern DSP_STATUS CDECL DEV_SetLockOwner(struct DEV_OBJECT *hDevObject,
-                                                struct BRD_OBJECT *hBrdObject);
-
-/*
  *  ======== DEV_StartDevice ========
  *  Purpose:
  *      Initializes the new device with the WinBRIDGE environment.  This
@@ -829,23 +808,4 @@
  */
        extern DSP_STATUS CDECL DEV_StartDevice(struct CFG_DEVNODE *hDevNode);

-/*
- *  ======== DEV_StartIVADevice ========
- *  Purpose:
- *      Initializes the new device with the WinBRIDGE environment.  This
- *      involves querying CM for allocated resources, querying the registry
- *      for necessary IVA resources, and using
- *      this information to create a WinBRIDGE device object.
- *  Parameters:
- *      hDevNode:       Device node as it is known to OS.
- *  Returns:
- *      DSP_SOK:        If success;
- *      <error code>    Otherwise.
- *  Requires:
- *      DEV initialized.
- *  Ensures:
- */
-       extern DSP_STATUS CDECL DEV_StartIVADevice(struct CFG_DEVNODE*
-                                                  hDevNode);
-
 #endif                         /* DEV_ */
Index: omapkernel/drivers/dsp/dspbridge/mpu_driver/inc/wcdioctl.h
===================================================================
--- omapkernel.orig/drivers/dsp/dspbridge/mpu_driver/inc/wcdioctl.h     2008-07-29 23:52:26.000000000 -0500
+++ omapkernel/drivers/dsp/dspbridge/mpu_driver/inc/wcdioctl.h  2008-07-29 23:53:12.000000000 -0500
@@ -515,21 +515,4 @@
 #define CMD_CMM_GETINFO_OFFSET   (CMD_CMM_BASE_OFFSET + 3)
 #define CMD_CMM_END_OFFSET           CMD_CMM_GETINFO_OFFSET

-/* MEMRY module offsets */
-#define CMD_MEM_BASE_OFFSET         (CMD_CMM_END_OFFSET + 1)
-#define CMD_MEM_ALLOC_OFFSET       (CMD_MEM_BASE_OFFSET + 0)
-#define CMD_MEM_CALLOC_OFFSET     (CMD_MEM_BASE_OFFSET + 1)
-#define CMD_MEM_FREE_OFFSET         (CMD_MEM_BASE_OFFSET + 2)
-#define CMD_MEM_PAGELOCK_OFFSET         (CMD_MEM_BASE_OFFSET + 3)
-#define CMD_MEM_PAGEUNLOCK_OFFSET       (CMD_MEM_BASE_OFFSET + 4)
-#define CMD_MEM_END_OFFSET           CMD_MEM_PAGEUNLOCK_OFFSET
-
-/* UTIL module */
-#define CMD_UTIL_BASE_OFFSET       (CMD_MEM_END_OFFSET + 1)
-#define CMD_UTIL_TESTDLL_OFFSET         (CMD_UTIL_BASE_OFFSET + 0)
-#define CMD_UTIL_END_OFFSET         CMD_UTIL_TESTDLL_OFFSET
-
-/* !!! place all command modules before CMD_BASE_END_OFFSET */
-#define CMD_BASE_END_OFFSET         CMD_UTIL_END_OFFSET
-
 #endif                         /* WCDIOCTL_ */
Index: omapkernel/drivers/dsp/dspbridge/mpu_driver/inc/wmdioctl.h
===================================================================
--- omapkernel.orig/drivers/dsp/dspbridge/mpu_driver/inc/wmdioctl.h     2008-07-29 23:52:26.000000000 -0500
+++ omapkernel/drivers/dsp/dspbridge/mpu_driver/inc/wmdioctl.h  2008-07-29 23:53:12.000000000 -0500
@@ -47,7 +47,6 @@

 /* Any IOCTLS at or above this value are reserved for standard WMD interfaces.*/
 #define WMDIOCTL_RESERVEDBASE       0x8000
-#define WMDIOCTL_BIOSSCOPEBASE      (WMDIOCTL_RESERVEDBASE + 0x100)

 #define WMDIOCTL_CHNLREAD           (WMDIOCTL_RESERVEDBASE + 0x10)
 #define WMDIOCTL_CHNLWRITE          (WMDIOCTL_RESERVEDBASE + 0x20)
@@ -67,8 +66,6 @@
 #define WMDIOCTL_WAKEUP             (WMDIOCTL_PWRCONTROL + 0x2)
 #define WMDIOCTL_PWRENABLE          (WMDIOCTL_PWRCONTROL + 0x3)
 #define WMDIOCTL_PWRDISABLE         (WMDIOCTL_PWRCONTROL + 0x4)
-#define WMDIOCTL_INACTTIMER_START   (WMDIOCTL_PWRCONTROL + 0x5)
-#define WMDIOCTL_INACTTIMER_STOP    (WMDIOCTL_PWRCONTROL + 0x6)
 #define WMDIOCTL_CLK_CTRL                  (WMDIOCTL_PWRCONTROL + 0x7)
 #define WMDIOCTL_PWR_HIBERNATE (WMDIOCTL_PWRCONTROL + 0x8) /*DSP Initiated
                                                            * Hibernate*/
@@ -76,26 +73,6 @@
 #define WMDIOCTL_POSTSCALE_NOTIFY (WMDIOCTL_PWRCONTROL + 0xA)
 #define WMDIOCTL_CONSTRAINT_REQUEST (WMDIOCTL_PWRCONTROL + 0xB)

-
-/* These ioctls are reserved for BIOS/SPOX Scope */
-#define WMDIOCTL_START              (WMDIOCTL_BIOSSCOPEBASE + 0x0)
-#define WMDIOCTL_RECV               (WMDIOCTL_BIOSSCOPEBASE + 0x1)
-#define WMDIOCTL_SEND               (WMDIOCTL_BIOSSCOPEBASE + 0x2)
-#define WMDIOCTL_INITLD             (WMDIOCTL_BIOSSCOPEBASE + 0x3)
-
-/*
- * The following ioctls are currently used by the TIEVM6x board.
- */
-#define WMDIOCTL_JTAGSELECT         (WMDIOCTL_BIOSSCOPEBASE + 0x4)
-#define WMDIOCTL_MAPTBC             (WMDIOCTL_BIOSSCOPEBASE + 0x5)
-#define WMDIOCTL_UNMAPTBC           (WMDIOCTL_BIOSSCOPEBASE + 0x6)
-#define WMDIOCTL_GETCONFIGURATION   (WMDIOCTL_BIOSSCOPEBASE + 0x7)
-#define WMDIOCTL_ENBLEXTMEM         (WMDIOCTL_BIOSSCOPEBASE + 0x8)
-#define WMDIOCTL_ASSERTSIG          (WMDIOCTL_BIOSSCOPEBASE + 0x9)
-#define WMDIOCTL_RESETDSP           (WMDIOCTL_BIOSSCOPEBASE + 0xA)
-#define WMDIOCTL_UNRESETDSP         (WMDIOCTL_BIOSSCOPEBASE + 0xB)
-#define WMDIOCTL_INITIALIZECARD     (WMDIOCTL_BIOSSCOPEBASE + 0xC)
-
 /* Number of actual DSP-MMU TLB entrries */
 #define WMDIOCTL_NUMOFMMUTLB        32

@@ -110,68 +87,5 @@
        enum HW_ElementSize_t elemSize;
 };

-struct WMDIOCTL_CHNLRW_ARGS {
-       u8 *pHostBuf;
-       u32 dwDSPAddr;
-       u32 ulNumBytes;
-} ;
-
-struct WMDIOCTL_INTRCOUNT_ARGS {
-       u32 ulIntsRecvd;
-       u32 ulIntsSent;
-} ;
-
-/*
- *  These ioctl args allow scope to communicate with a WinConnex board
- *  through a BHW driver.
- */
-struct WMDIOCTL_BHW_ARGS {
-       union {
-               struct {
-                       void *pBootRec;
-               } initLdArgs;
-
-               struct {
-                       u32 dwEntry;
-               } startArgs;
-
-               struct {
-                       void *ptr;
-                       u32 ulNwords;
-               } recvArgs;
-
-               struct {
-                       void *ptr;
-                       u32 ulNwords;
-               } sendArgs;
-       } ctrlArgs;
-} ;
-
-/* EVM 6x specific GTI support ioctl args*/
-struct WMDIOCTL_GTIEVM_ARGS {
-       union {
-               struct {
-                       u32 *pMapAddr;
-                       u32 *pLength;
-               } mapAddrArgs;
-
-               struct {
-                       u32 dwBootMask;
-               } resetDspArgs;
-
-               struct {
-                       u32 dwMask;
-               } assertSigArgs;
-
-               struct {
-                       u32 *pDeviceID;
-                       u32 *pVendorID;
-                       u32 *pClassCode;
-                       u32 *pRevID;    /* need EVM Rev for SCIF READ MEM */
-               } evmConfigArgs;
-
-       } ctrlArgs;
-} ;
-
 #endif                         /* WMDIOCTL_ */

Index: omapkernel/drivers/dsp/dspbridge/mpu_driver/src/hw/inc/EasiGlobal.h
===================================================================
--- omapkernel.orig/drivers/dsp/dspbridge/mpu_driver/src/hw/inc/EasiGlobal.h    2008-07-29 23:52:26.000000000 -0500
+++ omapkernel/drivers/dsp/dspbridge/mpu_driver/src/hw/inc/EasiGlobal.h 2008-07-29 23:53:12.000000000 -0500
@@ -32,127 +32,6 @@
 #define WRITE_ONLY   2
 #define READ_WRITE   3

-/*
- * EXPORTED TYPES
- *
- */
-
-/* ----------------------------------------------------------------------------
-* TYPE:        regEnum
-*
-* DESCRIPTION:  regtypes are used to switch to correct test function
-*               there are as many regtypes as there are data definitions
-*
-* NOTE:         None
-*
-* -----------------------------------------------------------------------------
-*/
-enum regEnum {
-    ACC_32BIT,
-    ACC_16BIT,
-    ACC_8BIT
-} ;
-
-/* ----------------------------------------------------------------------------
-* TYPE:        registerPORStruct
-*
-* DESCRIPTION:  all required register data held in an array of structure for
-*               power on reset tests.
-*
-* NOTE:         None
-*
-* -----------------------------------------------------------------------------
-*/
-struct registerPORStruct {
-    u32    ID;
-    u32    address;
-    u32    powerOnValue;
-    u32    powerOnMask;
-    enum regEnum    regType;
-} ;
-
-/* ----------------------------------------------------------------------------
-* TYPE:        registerIntegrityStruct
-*
-* DESCRIPTION:  all required register data held in an array of structure for
-*               integrity tests.
-*
-* NOTE:         None
-*
-* -----------------------------------------------------------------------------
-*/
-struct registerIntegrityStruct {
-    u32    ID;
-    u32    address;
-    u32    readMask;
-    u32    powerOnValue;
-    u32    includeMask;
-    u8     regType;
-} ;
-
-/* ----------------------------------------------------------------------------
-* TYPE:        registerROWOStruct
-*
-* DESCRIPTION:  all required register data held in an array of structure for
-*               read only/write only register tests.
-*
-* NOTE:         None
-*
-* -----------------------------------------------------------------------------
-*/
-struct registerROWOStruct {
-    u32    ID;
-    u32    address;
-    u32    readMask;
-    u32    powerOnValue;
-    u32    includeMask;
-    u8     regType;
-} ;
-
-/* ----------------------------------------------------------------------------
-* TYPE:        registerExclusivityStruct
-*
-* DESCRIPTION:  all required register data held in an array of structure for
-*               exclusivity tests.
-*
-* NOTE:         None
-*
-* -----------------------------------------------------------------------------
-*/
-struct registerExclusivityStruct {
-    u32    ID;
-    u8     IOstatus;
-    u32    address;
-    u32    powerOnValue;
-    u32    powerOnMask;
-    u32    readMask;
-    u32    includeMask;
-    u8     regType;
-} ;
-
-/*
- * EXPORTED VARIABLES
- *
- */
-
-/* ----------------------------------------------------------------------------
-* VARIABLE:     EASIDummy
-*
-* DESCRIPTION:  A dummy variable used to such that macro _DEBUG_LEVEL_1_EASI
-*               compiles when used as an expression inside a macro with the
-*               comma operator.
-*
-* NOTE:         None
-*
-* -----------------------------------------------------------------------------
-*/
-extern u32 EASIDummy;
-
-/*
- * EXPORTED FUNCTIONS/MACROS
- *
- */
-
 /* ----------------------------------------------------------------------------
 * MACRO:        _DEBUG_LEVEL_1_EASI
 *
Index: omapkernel/drivers/dsp/dspbridge/mpu_driver/src/hw/inc/hw_mmu.h
===================================================================
--- omapkernel.orig/drivers/dsp/dspbridge/mpu_driver/src/hw/inc/hw_mmu.h        2008-07-29 23:52:26.000000000 -0500
+++ omapkernel/drivers/dsp/dspbridge/mpu_driver/src/hw/inc/hw_mmu.h     2008-07-29 23:53:12.000000000 -0500
@@ -36,11 +36,7 @@
 *
 * DESCRIPTION:  Bitmasks for interrupt sources
 */
-#define HW_MMU_TLB_MISS            0x1
 #define HW_MMU_TRANSLATION_FAULT   0x2
-#define HW_MMU_EMU_MISS            0x4
-#define HW_MMU_TABLE_WALK_FAULT    0x8
-#define HW_MMU_MULTI_HIT_FAULT     0x10
 #define HW_MMU_ALL_INTERRUPTS      0x1F

 #define HW_MMU_COARSE_PAGE_SIZE 0x400
Index: omapkernel/drivers/dsp/dspbridge/mpu_driver/src/hw/inc/hw_prcm.h
===================================================================
--- omapkernel.orig/drivers/dsp/dspbridge/mpu_driver/src/hw/inc/hw_prcm.h       2008-07-29 23:52:26.000000000 -0500
+++ omapkernel/drivers/dsp/dspbridge/mpu_driver/src/hw/inc/hw_prcm.h    2008-07-29 23:53:12.000000000 -0500
@@ -114,22 +114,6 @@
 } ;

 /*
-* TYPE:         HW_RstCause
-*
-* DESCRIPTION:  Enumerated Type used to specify the cause of the reset
-*/
-/* TBD */
-enum RstCause {
-    HW_RSTCAUSE_DSP1_UMA_DMA,
-    HW_RSTCAUSE_DSP2_IPI_MMU,
-    HW_RSTCAUSE_IVA,
-    HW_RSTCAUSE_UMA,
-    HW_RSTCAUSE_CORE,
-    HW_RSTCAUSE_MPU,
-    HW_RSTCAUSE_GLOBALWARM
-} ;
-
-/*
 * TYPE:         HW_PwrModule
 *
 * DESCRIPTION:  Enumerated Type used to specify the power domain
Index: omapkernel/drivers/dsp/dspbridge/mpu_driver/src/pmgr/wcd.c
===================================================================
--- omapkernel.orig/drivers/dsp/dspbridge/mpu_driver/src/pmgr/wcd.c     2008-07-29 23:52:26.000000000 -0500
+++ omapkernel/drivers/dsp/dspbridge/mpu_driver/src/pmgr/wcd.c  2008-07-29 23:53:12.000000000 -0500
@@ -243,15 +243,7 @@
        {CMMWRAP_CallocBuf, CMD_CMM_ALLOCBUF_OFFSET},
        {CMMWRAP_FreeBuf, CMD_CMM_FREEBUF_OFFSET},
        {CMMWRAP_GetHandle, CMD_CMM_GETHANDLE_OFFSET},
-       {CMMWRAP_GetInfo, CMD_CMM_GETINFO_OFFSET},
-       /* MEM module: */
-       {MEMWRAP_Alloc, CMD_MEM_ALLOC_OFFSET},
-       {MEMWRAP_Calloc, CMD_MEM_CALLOC_OFFSET},
-       {MEMWRAP_Free, CMD_MEM_FREE_OFFSET},
-       {MEMWRAP_PageLock, CMD_MEM_PAGELOCK_OFFSET},
-       {MEMWRAP_PageUnlock, CMD_MEM_PAGEUNLOCK_OFFSET},
-       /* UTIL module */
-       {UTILWRAP_TestDll, CMD_UTIL_TESTDLL_OFFSET},  /* for PM test harness */
+       {CMMWRAP_GetInfo, CMD_CMM_GETINFO_OFFSET}
 };

 /*
@@ -1647,53 +1639,3 @@

        return status;
 }
-
-/*
- *  ======== MEMWRAP_Alloc ========
- */
-u32 MEMWRAP_Alloc(union Trapped_Args *args)
-{
-       return DSP_ENOTIMPL;
-
-}
-
-/*
- *  ======== MEMWRAP_Calloc ========
- */
-u32 MEMWRAP_Calloc(union Trapped_Args *args)
-{
-       return DSP_ENOTIMPL;
-}
-
-/*
- *  ======== MEMWRAP_Free ========
- */
-u32 MEMWRAP_Free(union Trapped_Args *args)
-{
-       return DSP_ENOTIMPL;
-}
-
-/*
- *  ======== MEMWRAP_PageLock ========
- */
-u32 MEMWRAP_PageLock(union Trapped_Args *args)
-{
-       return DSP_ENOTIMPL;
-}
-
-/*
- *  ======== MEMWRAP_PageUnlock ========
- */
-u32 MEMWRAP_PageUnlock(union Trapped_Args *args)
-{
-       return DSP_ENOTIMPL;
-}
-
-/*
- * ======== UTILWRAP_TestDll ========
- */
-u32 UTILWRAP_TestDll(union Trapped_Args *args)
-{
-       return DSP_ENOTIMPL;
-}
-
Index: omapkernel/drivers/dsp/dspbridge/mpu_driver/src/services/clk.c
===================================================================
--- omapkernel.orig/drivers/dsp/dspbridge/mpu_driver/src/services/clk.c 2008-07-29 23:52:26.000000000 -0500
+++ omapkernel/drivers/dsp/dspbridge/mpu_driver/src/services/clk.c      2008-07-29 23:53:12.000000000 -0500
@@ -57,65 +57,10 @@

 typedef volatile unsigned long  REG_UWORD32;

-#define CM_AUTOIDLE1_CORE 0x48004A30
-#define CM_AUTOIDLE1_SIZE  0x20
-#define CM_AUTOIDLE2_CORE 0x48004A34
-#define CM_AUTOIDLE2_SIZE  0x20
-
-#define SYSCONFIG_SIZE 0x1000
-#define IVA2_SYSC_BASE                 0x48002000 /*0x01C20000*/
-#define IVA2_WUGEN_BSAE        0x01C21000
-#define IVA2_IVLCD_BASE        0x00080000
-#define IVA2_SEQ_BASE          0x00090000
-#define IVA2_VIDEO_BASE        0x0009C000
-#define IVA2_IME_BASE          0x000A0000
-#define IVA2_ILF_BASE          0x000A1000
-
-#define CM_IDLEST_PER          0x48005020
-
-#define MAILBOX_Base 0x48094000
-#define GPT_Timer1_Base 0x48318000
-#define GPT_Timer2_Base 0x49032000
-#define GPT_Timer5_Base 0x49038000
-#define GPT_Timer6_Base 0x4903A000
-#define GPT_Timer7_Base  0x4903C000
-#define GPT_Timer8_Base 0x4903E000
-
-#define McBSP1_Base 0x48074000
-#define McBSP2_Base 0x49022000
-#define McBSP3_Base 0x49024000
-#define McBSP4_Base 0x49026000
-#define McBSP5_Base 0x48096000
-
-#define WDT3_Base 0x49030000
-#define GRPSEL_Base 0x48307000
-#define PER_PRM_Base 0x48307000
 #define SSI_Base        0x48058000

-#define MCBSP1_BASE           IO_ADDRESS(McBSP1_Base)
-#define MCBSP2_BASE           IO_ADDRESS(McBSP2_Base)
-#define MCBSP3_BASE           IO_ADDRESS(McBSP3_Base)
-#define MCBSP4_BASE           IO_ADDRESS(McBSP4_Base)
-#define MCBSP5_BASE           IO_ADDRESS(McBSP5_Base)
-#define GPT1_BASE                      IO_ADDRESS(GPT_Timer1_Base)
-#define GPT2_BASE                      IO_ADDRESS(GPT_Timer2_Base)
-#define GPT5_BASE                      IO_ADDRESS(GPT_Timer5_Base)
-#define GPT6_BASE                      IO_ADDRESS(GPT_Timer6_Base)
-#define GPT7_BASE                      IO_ADDRESS(GPT_Timer7_Base)
-#define GPT8_BASE                      IO_ADDRESS(GPT_Timer8_Base)
-#define WDT3_BASE                      IO_ADDRESS(WDT3_Base)
-#define MBX_BASE                       IO_ADDRESS(MAILBOX_Base)
-#define IVA2_BASE                      IO_ADDRESS(IVA2_SYSC_BASE)
-#define GRPSEL_BASE            IO_ADDRESS(GRPSEL_Base)
-#define PER_PRM_BASE           IO_ADDRESS(PER_PRM_Base)
 #define SSI_BASE                     IO_ADDRESS(SSI_Base)

-#define GRP_MPU_MASK           0x3effe
-#define GRP_IVA_MASK           0x00001
-
-
-#define LEVEL1  0
-#define LEVEL2  1

 struct SERVICES_Clk_t {
        struct clk *clk_handle;
---

Regards,

omar

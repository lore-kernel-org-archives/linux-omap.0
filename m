From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 10/10] DSPBRIDGE: trivial cleanup for io_sm
Date: Fri, 15 Jan 2010 15:28:41 -0600
Message-ID: <1263590921-24357-11-git-send-email-omar.ramirez@ti.com>
References: <1263590921-24357-1-git-send-email-omar.ramirez@ti.com>
 <1263590921-24357-2-git-send-email-omar.ramirez@ti.com>
 <1263590921-24357-3-git-send-email-omar.ramirez@ti.com>
 <1263590921-24357-4-git-send-email-omar.ramirez@ti.com>
 <1263590921-24357-5-git-send-email-omar.ramirez@ti.com>
 <1263590921-24357-6-git-send-email-omar.ramirez@ti.com>
 <1263590921-24357-7-git-send-email-omar.ramirez@ti.com>
 <1263590921-24357-8-git-send-email-omar.ramirez@ti.com>
 <1263590921-24357-9-git-send-email-omar.ramirez@ti.com>
 <1263590921-24357-10-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:38525 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758288Ab0AOVS7 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 15 Jan 2010 16:18:59 -0500
In-Reply-To: <1263590921-24357-10-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Ameya Palande <ameya.palande@nokia.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, Nishanth Menon <nm@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>

- Removed duplicate set of braces from if statement
- Placed braces for single (if or else) statements when
  their counter part is a multiline block.
- Reduce indentation
- Removed a preprocessor block statement affecting
  DSP trace buffer and reduced condition as MBX_DBG_CLASS
  and MBX_DBG_SYSPRINTF have the same value
- Fix multiline comments according to Documentation/CodingStyle

Functions comments will be addressed in a different patch.

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 drivers/dsp/bridge/wmd/io_sm.c |  503 ++++++++++++++++++++++------------------
 1 files changed, 275 insertions(+), 228 deletions(-)

diff --git a/drivers/dsp/bridge/wmd/io_sm.c b/drivers/dsp/bridge/wmd/io_sm.c
index e37d447..3a35378 100644
--- a/drivers/dsp/bridge/wmd/io_sm.c
+++ b/drivers/dsp/bridge/wmd/io_sm.c
@@ -17,14 +17,14 @@
  */
 
 /*
- *  Channel Invariant:
- *      There is an important invariant condition which must be maintained per
- *      channel outside of WMD_CHNL_GetIOC() and IO_Dispatch(), violation of
- *      which may cause timeouts and/or failure of the SYNC_WaitOnEvent
- *      function.
+ * Channel Invariant:
+ * There is an important invariant condition which must be maintained per
+ * channel outside of WMD_CHNL_GetIOC() and IO_Dispatch(), violation of
+ * which may cause timeouts and/or failure of the SYNC_WaitOnEvent
+ * function.
  */
 
-/*  ----------------------------------- Host OS */
+/* Host OS */
 #include <dspbridge/host_os.h>
 #include <linux/workqueue.h>
 
@@ -33,11 +33,11 @@
 #include <dspbridge/dbdefs.h>
 #include <dspbridge/errbase.h>
 
-/*  ----------------------------------- Trace & Debug */
+/* Trace & Debug */
 #include <dspbridge/dbc.h>
 #include <dspbridge/dbg.h>
 
-/*  ----------------------------------- OS Adaptation Layer */
+/* Services Layer */
 #include <dspbridge/cfg.h>
 #include <dspbridge/dpc.h>
 #include <dspbridge/mem.h>
@@ -45,11 +45,11 @@
 #include <dspbridge/sync.h>
 #include <dspbridge/reg.h>
 
-/* ------------------------------------ Hardware Abstraction Layer */
+/* Hardware Abstraction Layer */
 #include <hw_defs.h>
 #include <hw_mmu.h>
 
-/*  ----------------------------------- Mini Driver */
+/* Mini Driver */
 #include <dspbridge/wmddeh.h>
 #include <dspbridge/wmdio.h>
 #include <dspbridge/wmdioctl.h>
@@ -57,25 +57,25 @@
 #include <tiomap_io.h>
 #include <_tiomap_pwr.h>
 
-/*  ----------------------------------- Platform Manager */
+/* Platform Manager */
 #include <dspbridge/cod.h>
 #include <dspbridge/dev.h>
 #include <dspbridge/chnl_sm.h>
 
-/*  ----------------------------------- Others */
+/* Others */
 #include <dspbridge/rms_sh.h>
 #include <dspbridge/mgr.h>
 #include <dspbridge/drv.h>
 #include "_cmm.h"
 
-/*  ----------------------------------- This */
+/* This */
 #include <dspbridge/io_sm.h>
 #include "_msg_sm.h"
 #include <dspbridge/gt.h>
 
-/*  ----------------------------------- Defines, Data Structures, Typedefs */
+/* Defines, Data Structures, Typedefs */
 #define OUTPUTNOTREADY  0xffff
-#define NOTENABLED      0xffff	/* channel(s) not enabled */
+#define NOTENABLED      0xffff	/* Channel(s) not enabled */
 
 #define EXTEND      "_EXT_END"
 
@@ -84,34 +84,34 @@
 
 #define MAX_PM_REQS 32
 
-/* IO Manager: only one created per board: */
+/* IO Manager: only one created per board */
 struct IO_MGR {
-	/* These four fields must be the first fields in a IO_MGR_ struct: */
-	u32 dwSignature; 	/* Used for object validation   */
-	struct WMD_DEV_CONTEXT *hWmdContext; 	/* WMD device context  */
+	/* These four fields must be the first fields in a IO_MGR_ struct */
+	u32 dwSignature; 	/* Used for object validation */
+	struct WMD_DEV_CONTEXT *hWmdContext; 	/* WMD device context */
 	struct WMD_DRV_INTERFACE *pIntfFxns; 	/* Function interface to WMD */
 	struct DEV_OBJECT *hDevObject; 	/* Device this board represents */
 
-	/* These fields initialized in WMD_IO_Create():    */
+	/* These fields initialized in WMD_IO_Create() */
 	struct CHNL_MGR *hChnlMgr;
-	struct SHM *pSharedMem; 	/* Shared Memory control	*/
-	u8 *pInput; 		/* Address of input channel     */
-	u8 *pOutput; 		/* Address of output channel    */
+	struct SHM *pSharedMem; 	/* Shared Memory control */
+	u8 *pInput; 		/* Address of input channel */
+	u8 *pOutput; 		/* Address of output channel */
 	struct MSG_MGR *hMsgMgr; 	/* Message manager */
 	struct MSG *pMsgInputCtrl; 	/* Msg control for from DSP messages */
 	struct MSG *pMsgOutputCtrl; 	/* Msg control for to DSP messages */
-	u8 *pMsgInput; 	/* Address of input messages    */
-	u8 *pMsgOutput; 	/* Address of output messages   */
+	u8 *pMsgInput; 	/* Address of input messages */
+	u8 *pMsgOutput; 	/* Address of output messages */
 	u32 uSMBufSize; 	/* Size of a shared memory I/O channel */
-	bool fSharedIRQ; 	/* Is this IRQ shared?	  */
-	struct DPC_OBJECT *hDPC; 	/* DPC object handle	    */
+	bool fSharedIRQ; 	/* Is this IRQ shared? */
+	struct DPC_OBJECT *hDPC; 	/* DPC object handle */
 	struct SYNC_CSOBJECT *hCSObj; 	/* Critical section object handle */
-	u32 uWordSize; 	/* Size in bytes of DSP word    */
-	u16 wIntrVal; 		/* interrupt value	      */
-	/* private extnd proc info; mmu setup */
+	u32 uWordSize; 	/* Size in bytes of DSP word */
+	u16 wIntrVal; 		/* Interrupt value */
+	/* Private extnd proc info; mmu setup */
 	struct MGR_PROCESSOREXTINFO extProcInfo;
-	struct CMM_OBJECT *hCmmMgr; 	/* Shared Mem Mngr	      */
-       struct work_struct io_workq;     /*workqueue */
+	struct CMM_OBJECT *hCmmMgr; 	/* Shared Mem Mngr */
+	struct work_struct io_workq;     /* workqueue */
 	u32 dQuePowerMbxVal[MAX_PM_REQS];
 	u32 iQuePowerHead;
 	u32 iQuePowerTail;
@@ -126,7 +126,7 @@ struct IO_MGR {
 #endif
 } ;
 
-/*  ----------------------------------- Function Prototypes */
+/* Function Prototypes */
 static void IO_DispatchChnl(IN struct IO_MGR *pIOMgr,
 			   IN OUT struct CHNL_OBJECT *pChnl, u32 iMode);
 static void IO_DispatchMsg(IN struct IO_MGR *pIOMgr, struct MSG_MGR *hMsgMgr);
@@ -150,7 +150,7 @@ static struct workqueue_struct *bridge_workqueue;
 void PrintDSPDebugTrace(struct IO_MGR *hIOMgr);
 #endif
 
-/* Bus Addr (cached kernel)*/
+/* Bus Addr (cached kernel) */
 static DSP_STATUS registerSHMSegs(struct IO_MGR *hIOMgr,
 				  struct COD_MANAGER *hCodMan,
 				  u32 dwGPPBasePA);
@@ -181,9 +181,9 @@ DSP_STATUS WMD_IO_Create(OUT struct IO_MGR **phIOMgr,
 	struct CFG_HOSTRES hostRes;
 	struct CFG_DEVNODE *hDevNode;
 	struct CHNL_MGR *hChnlMgr;
-       static int ref_count;
+	static int ref_count;
 	u32 devType;
-	/* Check requirements:  */
+	/* Check requirements */
 	if (!phIOMgr || !pMgrAttrs || pMgrAttrs->uWordSize == 0) {
 		status = DSP_EHANDLE;
 		goto func_end;
@@ -193,26 +193,28 @@ DSP_STATUS WMD_IO_Create(OUT struct IO_MGR **phIOMgr,
 		status = DSP_EHANDLE;
 		goto func_end;
 	}
-	 /*  Message manager will be created when a file is loaded, since
-	 *  size of message buffer in shared memory is configurable in
-	 *  the base image.  */
+	/*
+	 * Message manager will be created when a file is loaded, since
+	 * size of message buffer in shared memory is configurable in
+	 * the base image.
+	 */
 	DEV_GetWMDContext(hDevObject, &hWmdContext);
 	if (!hWmdContext) {
 		status = DSP_EHANDLE;
 		goto func_end;
 	}
 	DEV_GetDevType(hDevObject, &devType);
-	/*  DSP shared memory area will get set properly when
-	 *  a program is loaded. They are unknown until a COFF file is
-	 *  loaded. I chose the value -1 because it was less likely to be
-	 *  a valid address than 0.  */
+	/*
+	 * DSP shared memory area will get set properly when
+	 * a program is loaded. They are unknown until a COFF file is
+	 * loaded. I chose the value -1 because it was less likely to be
+	 * a valid address than 0.
+	 */
 	pSharedMem = (struct SHM *) -1;
 	if (DSP_FAILED(status))
 		goto func_cont;
 
-	/*
-	 * Create a Single Threaded Work Queue
-	 */
+	/* Create a Single Threaded Work Queue */
 	if (ref_count == 0)
 		bridge_workqueue = create_workqueue("bridge_work-queue");
 
@@ -220,13 +222,13 @@ DSP_STATUS WMD_IO_Create(OUT struct IO_MGR **phIOMgr,
 		DBG_Trace(DBG_LEVEL1, "Workque Create failed 0x%d \n",
 						bridge_workqueue);
 
-	/* Allocate IO manager object: */
+	/* Allocate IO manager object */
 	MEM_AllocObject(pIOMgr, struct IO_MGR, IO_MGRSIGNATURE);
 	if (pIOMgr == NULL) {
 		status = DSP_EMEMORY;
 		goto func_cont;
 	}
-	/*Intializing Work Element*/
+	/* Intializing Work Element */
 	if (ref_count == 0) {
 		INIT_WORK(&pIOMgr->io_workq, (void *)IO_DispatchPM);
 		ref_count = 1;
@@ -234,7 +236,7 @@ DSP_STATUS WMD_IO_Create(OUT struct IO_MGR **phIOMgr,
 		PREPARE_WORK(&pIOMgr->io_workq, (void *)IO_DispatchPM);
 	}
 
-	/* Initialize CHNL_MGR object:    */
+	/* Initialize CHNL_MGR object */
 #ifndef DSP_TRACEBUF_DISABLED
 	pIOMgr->pMsg = NULL;
 #endif
@@ -245,7 +247,7 @@ DSP_STATUS WMD_IO_Create(OUT struct IO_MGR **phIOMgr,
 		status = SYNC_InitializeCS(&pIOMgr->hCSObj);
 
 	if (devType == DSP_UNIT) {
-		/* Create a DPC object: */
+		/* Create a DPC object */
 		status = DPC_Create(&pIOMgr->hDPC, IO_DPC, (void *)pIOMgr);
 		if (DSP_SUCCEEDED(status))
 			status = DEV_GetDevNode(hDevObject, &hDevNode);
@@ -263,7 +265,7 @@ DSP_STATUS WMD_IO_Create(OUT struct IO_MGR **phIOMgr,
 		IO_DisableInterrupt(hWmdContext);
 		if (devType == DSP_UNIT) {
 			HW_MBOX_initSettings(hostRes.dwMboxBase);
-			/* Plug the channel ISR:. */
+			/* Plug the channel ISR */
 			if ((request_irq(INT_MAIL_MPU_IRQ, IO_ISR, 0,
 			  "DspBridge\tmailbox", (void *)pIOMgr)) == 0) {
 				status = DSP_SOK;
@@ -278,7 +280,7 @@ DSP_STATUS WMD_IO_Create(OUT struct IO_MGR **phIOMgr,
 	}
 func_cont:
 	if (DSP_FAILED(status)) {
-		/* Cleanup: */
+		/* Cleanup */
 		WMD_IO_Destroy(pIOMgr);
 		*phIOMgr = NULL;
 	} else {
@@ -300,8 +302,7 @@ DSP_STATUS WMD_IO_Destroy(struct IO_MGR *hIOMgr)
 	DSP_STATUS status = DSP_SOK;
 	struct WMD_DEV_CONTEXT *hWmdContext;
 	if (MEM_IsValidHandle(hIOMgr, IO_MGRSIGNATURE)) {
-		/* Unplug IRQ:    */
-		/* Disable interrupts from the board:  */
+		/* Disable interrupts from the board */
 		status = DEV_GetWMDContext(hIOMgr->hDevObject, &hWmdContext);
 		if (DSP_SUCCEEDED(status))
 			(void)CHNLSM_DisableInterrupt(hWmdContext);
@@ -316,10 +317,11 @@ DSP_STATUS WMD_IO_Destroy(struct IO_MGR *hIOMgr)
 			MEM_Free(hIOMgr->pMsg);
 #endif
 		SYNC_DeleteCS(hIOMgr->hCSObj); 	/* Leak Fix. */
-		/* Free this IO manager object: */
+		/* Free this IO manager object */
 		MEM_FreeObject(hIOMgr);
-       } else
+	} else {
 		status = DSP_EHANDLE;
+	}
 
 	return status;
 }
@@ -373,7 +375,7 @@ DSP_STATUS WMD_IO_OnLoaded(struct IO_MGR *hIOMgr)
 	if (DSP_FAILED(status))
 		goto func_end;
 	hChnlMgr = hIOMgr->hChnlMgr;
-	 /*  The message manager is destroyed when the board is stopped.  */
+	/* The message manager is destroyed when the board is stopped. */
 	DEV_GetMsgMgr(hIOMgr->hDevObject, &hIOMgr->hMsgMgr);
 	hMsgMgr = hIOMgr->hMsgMgr;
 	if (!MEM_IsValidHandle(hChnlMgr, CHNL_MGRSIGNATURE) ||
@@ -400,7 +402,7 @@ DSP_STATUS WMD_IO_OnLoaded(struct IO_MGR *hIOMgr)
 	if (ulShmLimit <= ulShmBase) {
 		status = CHNL_E_INVALIDMEMBASE;
 	} else {
-		/* get total length in bytes */
+		/* Get total length in bytes */
 		ulShmLength = (ulShmLimit - ulShmBase + 1) * hIOMgr->uWordSize;
 		/* Calculate size of a PROCCOPY shared memory region */
 		DBG_Trace(DBG_LEVEL7,
@@ -420,12 +422,16 @@ func_cont1:
 			if (ulMsgLimit <= ulMsgBase) {
 				status = CHNL_E_INVALIDMEMBASE;
 			} else {
-				/* Length (bytes) of messaging part of shared
-				 * memory */
+				/*
+				 * Length (bytes) of messaging part of shared
+				 * memory.
+				 */
 				ulMsgLength = (ulMsgLimit - ulMsgBase + 1) *
 					      hIOMgr->uWordSize;
-				/* Total length (bytes) of shared memory:
-				 * chnl + msg */
+				/*
+				 * Total length (bytes) of shared memory:
+				 * chnl + msg.
+				 */
 				ulMemLength = ulShmLength + ulMsgLength;
 			}
 		} else {
@@ -444,19 +450,16 @@ func_cont1:
 #endif
 		if (DSP_FAILED(status))
 			status = CHNL_E_NOMEMMAP;
-
 	}
 	if (DSP_SUCCEEDED(status)) {
 		status = COD_GetSymValue(hCodMan, DYNEXTBASE, &ulDynExtBase);
 		if (DSP_FAILED(status))
 			status = CHNL_E_NOMEMMAP;
-
 	}
 	if (DSP_SUCCEEDED(status)) {
 		status = COD_GetSymValue(hCodMan, EXTEND, &ulExtEnd);
 		if (DSP_FAILED(status))
 			status = CHNL_E_NOMEMMAP;
-
 	}
 	if (DSP_SUCCEEDED(status)) {
 		/* Get memory reserved in host resources */
@@ -470,7 +473,7 @@ func_cont1:
 		ndx = 0;
 		ulGppPa = hostRes.dwMemPhys[1];
 		ulGppVa = hostRes.dwMemBase[1];
-		/* THIS IS THE VIRTUAL UNCACHED IOREMAPPED ADDRESS !!! */
+		/* This is the virtual uncached ioremapped address!!! */
 		/* Why can't we directly take the DSPVA from the symbols? */
 		ulDspVa = hIOMgr->extProcInfo.tyTlb[0].ulDspVirt;
 		ulSegSize = (ulShm0End - ulDspVa) * hIOMgr->uWordSize;
@@ -522,8 +525,10 @@ func_cont1:
 	mapAttrs |= DSP_MAPDONOTLOCK;
 
 	while (numBytes && DSP_SUCCEEDED(status)) {
-		/* To find the max. page size with which both PA & VA are
-		 * aligned */
+		/*
+		 * To find the max. page size with which both PA & VA are
+		 * aligned.
+		 */
 		allBits = paCurr | vaCurr;
 		DBG_Trace(DBG_LEVEL1, "allBits %x, paCurr %x, vaCurr %x, "
 			 "numBytes %x\n", allBits, paCurr, vaCurr, numBytes);
@@ -539,9 +544,11 @@ func_cont1:
 				vaCurr += pgSize[i];
 				gppVaCurr += pgSize[i];
 				numBytes -= pgSize[i];
-				/* Don't try smaller sizes. Hopefully we have
+				/*
+				 * Don't try smaller sizes. Hopefully we have
 				 * reached an address aligned to a bigger page
-				 * size*/
+				 * size.
+				 */
 				break;
 			}
 		}
@@ -550,13 +557,15 @@ func_cont1:
 	vaCurr += ulPadSize;
 	gppVaCurr += ulPadSize;
 
-	/* configure the TLB entries for the next cacheable segment */
+	/* Configure the TLB entries for the next cacheable segment */
 	numBytes = ulSegSize;
 	vaCurr = ulDspVa * hIOMgr->uWordSize;
 	allBits = 0x0;
 	while (numBytes && DSP_SUCCEEDED(status)) {
-		/* To find the max. page size with which both PA & VA are
-		 * aligned*/
+		/*
+		 * To find the max. page size with which both PA & VA are
+		 * aligned.
+		 */
 		allBits = paCurr | vaCurr;
 		DBG_Trace(DBG_LEVEL1, "allBits for Seg1 %x, paCurr %x, "
 			 "vaCurr %x, numBytes %x\n", allBits, paCurr, vaCurr,
@@ -566,11 +575,15 @@ func_cont1:
 			   !((allBits & (pgSize[i]-1)) == 0))
 				continue;
 			if (ndx < MAX_LOCK_TLB_ENTRIES) {
-				/* This is the physical address written to
-				 * DSP MMU */
+				/*
+				 * This is the physical address written to
+				 * DSP MMU.
+				 */
 				aEProc[ndx].ulGppPa = paCurr;
-				/* THIS IS THE VIRTUAL UNCACHED IOREMAPPED
-				 * ADDRESS!!! */
+				/*
+				 * This is the virtual uncached ioremapped
+				 * address!!!
+				 */
 				aEProc[ndx].ulGppVa = gppVaCurr;
 				aEProc[ndx].ulDspVa = vaCurr / hIOMgr->
 						      uWordSize;
@@ -603,14 +616,18 @@ func_cont1:
 			vaCurr += pgSize[i];
 			gppVaCurr += pgSize[i];
 			numBytes -= pgSize[i];
-			/* Don't try smaller sizes. Hopefully we have reached
-			 an address aligned to a bigger page size*/
+			/*
+			 * Don't try smaller sizes. Hopefully we have reached
+			 * an address aligned to a bigger page size.
+			 */
 			break;
 		}
 	}
 
-	 /* Copy remaining entries from CDB. All entries are 1 MB and should not
-	 * conflict with SHM entries on MPU or DSP side */
+	/*
+	 * Copy remaining entries from CDB. All entries are 1 MB and
+	 * should not conflict with SHM entries on MPU or DSP side.
+	 */
 	for (i = 3; i < 7 && ndx < WMDIOCTL_NUMOFMMUTLB &&
 	    DSP_SUCCEEDED(status); i++) {
 		if (hIOMgr->extProcInfo.tyTlb[i].ulGppPhys == 0)
@@ -637,8 +654,8 @@ func_cont1:
 				aEProc[ndx].ulGppPa = hIOMgr->extProcInfo.
 					tyTlb[i].ulGppPhys;
 				aEProc[ndx].ulGppVa = 0;
-				/* Can't convert, so set to zero*/
-				aEProc[ndx].ulSize = 0x100000; 	/* 1 MB*/
+				/* Can't convert, so set to zero */
+				aEProc[ndx].ulSize = 0x100000; 	/* 1 MB */
 				DBG_Trace(DBG_LEVEL1, "SHM MMU entry PA %x "
 					 "DSP_VA 0x%x\n", aEProc[ndx].ulGppPa,
 					aEProc[ndx].ulDspVa);
@@ -653,7 +670,7 @@ func_cont1:
 		}
 	}
 	if (i < 7 && DSP_SUCCEEDED(status)) {
-		/* All CDB entries could not be made*/
+		/* All CDB entries could not be made */
 		status = DSP_EFAIL;
 	}
 func_cont:
@@ -682,15 +699,19 @@ func_cont:
 			aEProc[i].ulGppVa = 0;
 			aEProc[i].ulSize = 0;
 		}
-		/* Set the SHM physical address entry (grayed out in CDB file)
+		/*
+		 * Set the SHM physical address entry (grayed out in CDB file)
 		 * to the virtual uncached ioremapped address of SHM reserved
-		 * on MPU */
+		 * on MPU.
+		 */
 		hIOMgr->extProcInfo.tyTlb[0].ulGppPhys = (ulGppVa + ulSeg1Size +
 							 ulPadSize);
 		DBG_Trace(DBG_LEVEL1, "*********extProcInfo *********%x \n",
 			  hIOMgr->extProcInfo.tyTlb[0].ulGppPhys);
-		/* Need SHM Phys addr. IO supports only one DSP for now:
-		 * uNumProcs=1 */
+		/*
+		 * Need SHM Phys addr. IO supports only one DSP for now:
+		 * uNumProcs = 1.
+		 */
 		if ((hIOMgr->extProcInfo.tyTlb[0].ulGppPhys == 0) ||
 		   (uNumProcs != 1)) {
 			status = CHNL_E_NOMEMMAP;
@@ -703,10 +724,12 @@ func_cont:
 			/* ulShmBase may not be at ulDspVa address */
 			ulShmBaseOffset = (ulShmBase - aEProc[0].ulDspVa) *
 			    hIOMgr->uWordSize;
-			 /* WMD_BRD_Ctrl() will set dev context dsp-mmu info. In
-			 *   _BRD_Start() the MMU will be re-programed with MMU
-			 *   DSPVa-GPPPa pair info while DSP is in a known
-			 *   (reset) state.  */
+			/*
+			 * WMD_BRD_Ctrl() will set dev context dsp-mmu info. In
+			 * _BRD_Start() the MMU will be re-programed with MMU
+			 * DSPVa-GPPPa pair info while DSP is in a known
+			 * (reset) state.
+			 */
 			if (!hIOMgr->pIntfFxns || !hIOMgr->hWmdContext)	{
 				status = DSP_EHANDLE;
 				goto func_end;
@@ -726,9 +749,9 @@ func_cont:
 			}
 			DBC_Assert(ulShmBase != 0);
 			if (DSP_SUCCEEDED(status)) {
+				/* Register SM */
 				status = registerSHMSegs(hIOMgr, hCodMan,
 					 aEProc[0].ulGppPa);
-				/* Register SM */
 			}
 		}
 	}
@@ -746,7 +769,7 @@ func_cont:
 			 "pSharedMem %p uSMBufSize %x sizeof(SHM) %x\n",
 			 hIOMgr->pSharedMem, hIOMgr->uSMBufSize,
 			 sizeof(struct SHM));
-		 /*  Set up Shared memory addresses for messaging. */
+		/* Set up Shared memory addresses for messaging. */
 		hIOMgr->pMsgInputCtrl = (struct MSG *)((u8 *)
 					hIOMgr->pSharedMem +
 					ulShmLength);
@@ -780,7 +803,6 @@ func_cont:
 				 &hIOMgr->ulTraceBufferBegin);
 			if (DSP_FAILED(status))
 				status = CHNL_E_NOMEMMAP;
-
 		}
 		hIOMgr->ulGPPReadPointer = hIOMgr->ulTraceBufferBegin =
 			(ulGppVa + ulSeg1Size + ulPadSize) +
@@ -791,7 +813,6 @@ func_cont:
 				 &hIOMgr->ulTraceBufferEnd);
 			if (DSP_FAILED(status))
 				status = CHNL_E_NOMEMMAP;
-
 		}
 		hIOMgr->ulTraceBufferEnd = (ulGppVa + ulSeg1Size + ulPadSize) +
 					   (hIOMgr->ulTraceBufferEnd - ulDspVa);
@@ -802,7 +823,6 @@ func_cont:
 				 &hIOMgr->ulTraceBufferCurrent);
 			if (DSP_FAILED(status))
 				status = CHNL_E_NOMEMMAP;
-
 		}
 		hIOMgr->ulTraceBufferCurrent = (ulGppVa + ulSeg1Size +
 						ulPadSize) + (hIOMgr->
@@ -851,7 +871,7 @@ void IO_CancelChnl(struct IO_MGR *hIOMgr, u32 ulChnl)
 		goto func_end;
 	sm = hIOMgr->pSharedMem;
 
-	/* Inform DSP that we have no more buffers on this channel:  */
+	/* Inform DSP that we have no more buffers on this channel */
 	IO_AndValue(pIOMgr->hWmdContext, struct SHM, sm, hostFreeMask,
 		   (~(1 << ulChnl)));
 
@@ -872,11 +892,11 @@ static void IO_DispatchChnl(IN struct IO_MGR *pIOMgr,
 
 	DBG_Trace(DBG_LEVEL3, "Entering IO_DispatchChnl \n");
 
-	/* See if there is any data available for transfer: */
+	/* See if there is any data available for transfer */
 	if (iMode != IO_SERVICE)
 		goto func_end;
 
-	/* Any channel will do for this mode: */
+	/* Any channel will do for this mode */
 	InputChnl(pIOMgr, pChnl, iMode);
 	OutputChnl(pIOMgr, pChnl, iMode);
 func_end:
@@ -894,7 +914,7 @@ static void IO_DispatchMsg(IN struct IO_MGR *pIOMgr, struct MSG_MGR *hMsgMgr)
 
 	DBG_Trace(DBG_LEVEL3, "Entering IO_DispatchMsg \n");
 
-	/*  We are performing both input and output processing. */
+	/* We are performing both input and output processing. */
 	InputMsg(pIOMgr, hMsgMgr);
 	OutputMsg(pIOMgr, hMsgMgr);
 func_end:
@@ -953,13 +973,11 @@ static void IO_DispatchPM(struct work_struct *work)
 					 *pArg);
 			}
 		}
-		/* increment the tail count here */
+		/* Increment the tail count here */
 		pIOMgr->iQuePowerTail++;
 		if (pIOMgr->iQuePowerTail >= MAX_PM_REQS)
 			pIOMgr->iQuePowerTail = 0;
-
 	}
-
 }
 
 /*
@@ -985,10 +1003,9 @@ void IO_DPC(IN OUT void *pRefData)
 	DBG_Trace(DBG_LEVEL7, "Entering IO_DPC(0x%x)\n", pRefData);
 	/* Check value of interrupt register to ensure it is a valid error */
 	if ((pIOMgr->wIntrVal > DEH_BASE) && (pIOMgr->wIntrVal < DEH_LIMIT)) {
-		/* notify DSP/BIOS exception */
+		/* Notify DSP/BIOS exception */
 		if (hDehMgr)
 			WMD_DEH_Notify(hDehMgr, DSP_SYSERROR, pIOMgr->wIntrVal);
-
 	}
 	IO_DispatchChnl(pIOMgr, NULL, IO_SERVICE);
 #ifdef CHNL_MESSAGES
@@ -996,21 +1013,15 @@ void IO_DPC(IN OUT void *pRefData)
 		IO_DispatchMsg(pIOMgr, pMsgMgr);
 #endif
 #ifndef DSP_TRACEBUF_DISABLED
-	if (pIOMgr->wIntrVal & MBX_DBG_CLASS) {
-		/* notify DSP Trace message */
-		if (pIOMgr->wIntrVal & MBX_DBG_SYSPRINTF)
-			PrintDSPDebugTrace(pIOMgr);
+	if (pIOMgr->wIntrVal & MBX_DBG_SYSPRINTF) {
+		/* Notify DSP Trace message */
+		PrintDSPDebugTrace(pIOMgr);
 	}
 #endif
-
-#ifndef DSP_TRACEBUF_DISABLED
-	PrintDSPDebugTrace(pIOMgr);
-#endif
 func_end:
 	return;
 }
 
-
 /*
  *  ======== IO_ISR ========
  *      Main interrupt handler for the shared memory IO manager.
@@ -1028,29 +1039,29 @@ irqreturn_t IO_ISR(int irq, IN void *pRefData)
 
 	/* Call WMD's CHNLSM_ISR() to see if interrupt is ours, and process. */
 	if (IO_CALLISR(hIOMgr->hWmdContext, &fSchedDPC, &hIOMgr->wIntrVal)) {
-		{
-			DBG_Trace(DBG_LEVEL3, "IO_ISR %x\n", hIOMgr->wIntrVal);
-			if (hIOMgr->wIntrVal & MBX_PM_CLASS) {
-				hIOMgr->dQuePowerMbxVal[hIOMgr->iQuePowerHead] =
-					hIOMgr->wIntrVal;
-				hIOMgr->iQuePowerHead++;
-				if (hIOMgr->iQuePowerHead >= MAX_PM_REQS)
-					hIOMgr->iQuePowerHead = 0;
-
-				queue_work(bridge_workqueue, &hIOMgr->io_workq);
-			}
-			if (hIOMgr->wIntrVal == MBX_DEH_RESET) {
-				DBG_Trace(DBG_LEVEL6, "*** DSP RESET ***\n");
-				hIOMgr->wIntrVal = 0;
-			} else if (fSchedDPC) {
-				/* PROC-COPY defer i/o  */
-				DPC_Schedule(hIOMgr->hDPC);
-			}
+		DBG_Trace(DBG_LEVEL3, "IO_ISR %x\n", hIOMgr->wIntrVal);
+		if (hIOMgr->wIntrVal & MBX_PM_CLASS) {
+			hIOMgr->dQuePowerMbxVal[hIOMgr->iQuePowerHead] =
+				hIOMgr->wIntrVal;
+			hIOMgr->iQuePowerHead++;
+			if (hIOMgr->iQuePowerHead >= MAX_PM_REQS)
+				hIOMgr->iQuePowerHead = 0;
+
+			queue_work(bridge_workqueue, &hIOMgr->io_workq);
+		}
+		if (hIOMgr->wIntrVal == MBX_DEH_RESET) {
+			DBG_Trace(DBG_LEVEL6, "*** DSP RESET ***\n");
+			hIOMgr->wIntrVal = 0;
+		} else if (fSchedDPC) {
+			/* PROC-COPY defer i/o */
+			DPC_Schedule(hIOMgr->hDPC);
 		}
-       } else
+	} else {
 		/* Ensure that, if WMD didn't claim it, the IRQ is shared. */
 		DBC_Ensure(hIOMgr->fSharedIRQ);
-       return IRQ_HANDLED;
+	}
+
+	return IRQ_HANDLED;
 }
 
 /*
@@ -1070,21 +1081,27 @@ void IO_RequestChnl(struct IO_MGR *pIOMgr, struct CHNL_OBJECT *pChnl,
 	pChnlMgr = pIOMgr->hChnlMgr;
 	sm = pIOMgr->pSharedMem;
 	if (iMode == IO_INPUT) {
-		/*  Assertion fires if CHNL_AddIOReq() called on a stream
-		 * which was cancelled, or attached to a dead board: */
+		/*
+		 * Assertion fires if CHNL_AddIOReq() called on a stream
+		 * which was cancelled, or attached to a dead board.
+		 */
 		DBC_Assert((pChnl->dwState == CHNL_STATEREADY) ||
 			  (pChnl->dwState == CHNL_STATEEOS));
-		/* Indicate to the DSP we have a buffer available for input: */
+		/* Indicate to the DSP we have a buffer available for input */
 		IO_OrValue(pIOMgr->hWmdContext, struct SHM, sm, hostFreeMask,
 			  (1 << pChnl->uId));
 		*pwMbVal = MBX_PCPY_CLASS;
 	} else if (iMode == IO_OUTPUT) {
-		/*  This assertion fails if CHNL_AddIOReq() was called on a
-		 * stream which was cancelled, or attached to a dead board: */
+		/*
+		 * This assertion fails if CHNL_AddIOReq() was called on a
+		 * stream which was cancelled, or attached to a dead board.
+		 */
 		DBC_Assert((pChnl->dwState & ~CHNL_STATEEOS) ==
 			  CHNL_STATEREADY);
-		/* Record the fact that we have a buffer available for
-		 * output: */
+		/*
+		 * Record the fact that we have a buffer available for
+		 * output.
+		 */
 		pChnlMgr->dwOutputMask |= (1 << pChnl->uId);
 	} else {
 		DBC_Assert(iMode); 	/* Shouldn't get here. */
@@ -1131,7 +1148,6 @@ static u32 FindReadyOutput(struct CHNL_MGR *pChnlMgr,
 				uRetval = id;
 				if (pChnl == NULL)
 					pChnlMgr->dwLastOutput = id;
-
 				break;
 			}
 			id = id + 1;
@@ -1164,7 +1180,7 @@ static void InputChnl(struct IO_MGR *pIOMgr, struct CHNL_OBJECT *pChnl,
 
 	DBG_Trace(DBG_LEVEL3, "> InputChnl\n");
 
-	/* Attempt to perform input.... */
+	/* Attempt to perform input */
 	if (!IO_GetValue(pIOMgr->hWmdContext, struct SHM, sm, inputFull))
 		goto func_end;
 
@@ -1182,17 +1198,19 @@ static void InputChnl(struct IO_MGR *pIOMgr, struct CHNL_OBJECT *pChnl,
 		if ((pChnl->dwState & ~CHNL_STATEEOS) == CHNL_STATEREADY) {
 			if (!pChnl->pIORequests)
 				goto func_end;
-			/* Get the I/O request, and attempt a transfer:  */
+			/* Get the I/O request, and attempt a transfer */
 			pChirp = (struct CHNL_IRP *)LST_GetHead(pChnl->
 				 pIORequests);
 			if (pChirp) {
 				pChnl->cIOReqs--;
 				if (pChnl->cIOReqs < 0)
 					goto func_end;
-				/* Ensure we don't overflow the client's
-				 * buffer: */
+				/*
+				 * Ensure we don't overflow the client's
+				 * buffer.
+				 */
 				uBytes = min(uBytes, pChirp->cBytes);
-				/* Transfer buffer from DSP side: */
+				/* Transfer buffer from DSP side */
 				uBytes = ReadData(pIOMgr->hWmdContext,
 						pChirp->pHostSysBuf,
 						pIOMgr->pInput, uBytes);
@@ -1204,24 +1222,30 @@ static void InputChnl(struct IO_MGR *pIOMgr, struct CHNL_OBJECT *pChnl,
 					 "\n", *((RMS_WORD *)(pChirp->
 					 pHostSysBuf)));
 				if (uBytes == 0) {
-					/* This assertion fails if the DSP
+					/*
+					 * This assertion fails if the DSP
 					 * sends EOS more than once on this
-					 * channel: */
+					 * channel.
+					 */
 					if (pChnl->dwState & CHNL_STATEEOS)
 						goto func_end;
-					 /* Zero bytes indicates EOS. Update
-					  * IOC status for this chirp, and also
-					  * the channel state: */
+					/*
+					 * Zero bytes indicates EOS. Update
+					 * IOC status for this chirp, and also
+					 * the channel state.
+					 */
 					pChirp->status |= CHNL_IOCSTATEOS;
 					pChnl->dwState |= CHNL_STATEEOS;
-					/* Notify that end of stream has
-					 * occurred */
+					/*
+					 * Notify that end of stream has
+					 * occurred.
+					 */
 					NTFY_Notify(pChnl->hNtfy,
 						   DSP_STREAMDONE);
 					DBG_Trace(DBG_LEVEL7, "Input Chnl NTFY "
 						 "chnl = 0x%x\n", pChnl);
 				}
-				/* Tell DSP if no more I/O buffers available: */
+				/* Tell DSP if no more I/O buffers available */
 				if (!pChnl->pIORequests)
 					goto func_end;
 				if (LST_IsEmpty(pChnl->pIORequests)) {
@@ -1232,27 +1256,29 @@ static void InputChnl(struct IO_MGR *pIOMgr, struct CHNL_OBJECT *pChnl,
 				fClearChnl = true;
 				fNotifyClient = true;
 			} else {
-				/* Input full for this channel, but we have no
+				/*
+				 * Input full for this channel, but we have no
 				 * buffers available.  The channel must be
 				 * "idling". Clear out the physical input
-				 * channel.  */
+				 * channel.
+				 */
 				fClearChnl = true;
 			}
 		} else {
-			/* Input channel cancelled:  clear input channel.  */
+			/* Input channel cancelled: clear input channel */
 			fClearChnl = true;
 		}
 	} else {
-		/* DPC fired after host closed channel: clear input channel. */
+		/* DPC fired after host closed channel: clear input channel */
 		fClearChnl = true;
 	}
 	if (fClearChnl) {
-		/* Indicate to the DSP we have read the input: */
+		/* Indicate to the DSP we have read the input */
 		IO_SetValue(pIOMgr->hWmdContext, struct SHM, sm, inputFull, 0);
 		CHNLSM_InterruptDSP2(pIOMgr->hWmdContext, MBX_PCPY_CLASS);
 	}
 	if (fNotifyClient) {
-		/* Notify client with IO completion record:  */
+		/* Notify client with IO completion record */
 		NotifyChnlComplete(pChnl, pChirp);
 	}
 func_end:
@@ -1276,7 +1302,7 @@ static void InputMsg(struct IO_MGR *pIOMgr, struct MSG_MGR *hMsgMgr)
 	u32 addr;
 
 	pCtrl = pIOMgr->pMsgInputCtrl;
-	/* Get the number of input messages to be read. */
+	/* Get the number of input messages to be read */
 	fInputEmpty = IO_GetValue(pIOMgr->hWmdContext, struct MSG, pCtrl,
 				 bufEmpty);
 	uMsgs = IO_GetValue(pIOMgr->hWmdContext, struct MSG, pCtrl, size);
@@ -1303,9 +1329,11 @@ static void InputMsg(struct IO_MGR *pIOMgr, struct MSG_MGR *hMsgMgr)
 		DBG_Trace(DBG_LEVEL7, "InputMsg RECVD: dwCmd=0x%x dwArg1=0x%x "
 			 "dwArg2=0x%x dwId=0x%x \n", msg.msg.dwCmd,
 			 msg.msg.dwArg1, msg.msg.dwArg2, msg.dwId);
-		/*  Interrupt may occur before shared memory and message
-		 *  input locations have been set up. If all nodes were
-		 *  cleaned up, hMsgMgr->uMaxMsgs should be 0.  */
+		/*
+		 * Interrupt may occur before shared memory and message
+		 * input locations have been set up. If all nodes were
+		 * cleaned up, hMsgMgr->uMaxMsgs should be 0.
+		 */
 		if (hMsgQueue && uMsgs > hMsgMgr->uMaxMsgs)
 			goto func_end;
 
@@ -1313,15 +1341,18 @@ static void InputMsg(struct IO_MGR *pIOMgr, struct MSG_MGR *hMsgMgr)
 			if (msg.dwId == hMsgQueue->dwId) {
 				/* Found it */
 				if (msg.msg.dwCmd == RMS_EXITACK) {
-					/* The exit message does not get
-					 * queued */
-					/* Call the node exit notification */
-					/* Node handle */ /* status */
+					/*
+					 * Call the node exit notification.
+					 * The exit message does not get
+					 * queued.
+					 */
 					(*hMsgMgr->onExit)((HANDLE)hMsgQueue->
 						hArg, msg.msg.dwArg1);
 				} else {
-					/* Not an exit acknowledgement, queue
-					 * the message */
+					/*
+					 * Not an exit acknowledgement, queue
+					 * the message.
+					 */
 					if (!hMsgQueue->msgFreeList)
 						goto func_end;
 					pMsg = (struct MSG_FRAME *)LST_GetHead
@@ -1336,8 +1367,10 @@ static void InputMsg(struct IO_MGR *pIOMgr, struct MSG_MGR *hMsgMgr)
 						SYNC_SetEvent(hMsgQueue->
 							hSyncEvent);
 					} else {
-						/* No free frame to copy the
-						 * message into */
+						/*
+						 * No free frame to copy the
+						 * message into.
+						 */
 						DBG_Trace(DBG_LEVEL7, "NO FREE "
 							"MSG FRAMES, DISCARDING"
 							" MESSAGE\n");
@@ -1362,8 +1395,7 @@ static void InputMsg(struct IO_MGR *pIOMgr, struct MSG_MGR *hMsgMgr)
 		CHNLSM_InterruptDSP2(pIOMgr->hWmdContext, MBX_PCPY_CLASS);
 	}
 func_end:
-       return;
-
+	return;
 }
 
 /*
@@ -1380,18 +1412,20 @@ static void NotifyChnlComplete(struct CHNL_OBJECT *pChnl,
 	   !pChnl->pIOCompletions || !pChirp)
 		goto func_end;
 
-	 /*  Note: we signal the channel event only if the queue of IO
-	  *  completions is empty.  If it is not empty, the event is sure to be
-	  *  signalled by the only IO completion list consumer:
-	  *  WMD_CHNL_GetIOC().  */
+	/*
+	 * Note: we signal the channel event only if the queue of IO
+	 * completions is empty.  If it is not empty, the event is sure to be
+	 * signalled by the only IO completion list consumer:
+	 * WMD_CHNL_GetIOC().
+	 */
 	fSignalEvent = LST_IsEmpty(pChnl->pIOCompletions);
-	/* Enqueue the IO completion info for the client: */
+	/* Enqueue the IO completion info for the client */
 	LST_PutTail(pChnl->pIOCompletions, (struct LST_ELEM *) pChirp);
 	pChnl->cIOCs++;
 
 	if (pChnl->cIOCs > pChnl->cChirps)
 		goto func_end;
-	/* Signal the channel event (if not already set) that IO is complete: */
+	/* Signal the channel event (if not already set) that IO is complete */
 	if (fSignalEvent)
 		SYNC_SetEvent(pChnl->hSyncEvent);
 
@@ -1418,14 +1452,14 @@ static void OutputChnl(struct IO_MGR *pIOMgr, struct CHNL_OBJECT *pChnl,
 	pChnlMgr = pIOMgr->hChnlMgr;
 	sm = pIOMgr->pSharedMem;
 	DBG_Trace(DBG_LEVEL3, "> OutputChnl\n");
-	/* Attempt to perform output: */
+	/* Attempt to perform output */
 	if (IO_GetValue(pIOMgr->hWmdContext, struct SHM, sm, outputFull))
 		goto func_end;
 
 	if (pChnl && !((pChnl->dwState & ~CHNL_STATEEOS) == CHNL_STATEREADY))
 		goto func_end;
 
-	/* Look to see if both a PC and DSP output channel are ready: */
+	/* Look to see if both a PC and DSP output channel are ready */
 	dwDspFMask = IO_GetValue(pIOMgr->hWmdContext, struct SHM, sm,
 				 dspFreeMask);
 	chnlId = FindReadyOutput(pChnlMgr, pChnl, (pChnlMgr->dwOutputMask &
@@ -1434,11 +1468,11 @@ static void OutputChnl(struct IO_MGR *pIOMgr, struct CHNL_OBJECT *pChnl,
 		goto func_end;
 
 	pChnl = pChnlMgr->apChannel[chnlId];
-       if (!pChnl || !pChnl->pIORequests) {
-		/* Shouldn't get here: */
+	if (!pChnl || !pChnl->pIORequests) {
+		/* Shouldn't get here */
 		goto func_end;
 	}
-	/* Get the I/O request, and attempt a transfer:  */
+	/* Get the I/O request, and attempt a transfer */
 	pChirp = (struct CHNL_IRP *)LST_GetHead(pChnl->pIORequests);
 	if (!pChirp)
 		goto func_end;
@@ -1447,11 +1481,11 @@ static void OutputChnl(struct IO_MGR *pIOMgr, struct CHNL_OBJECT *pChnl,
 	if (pChnl->cIOReqs < 0 || !pChnl->pIORequests)
 		goto func_end;
 
-	/* Record fact that no more I/O buffers available:  */
+	/* Record fact that no more I/O buffers available */
 	if (LST_IsEmpty(pChnl->pIORequests))
 		pChnlMgr->dwOutputMask &= ~(1 << chnlId);
 
-	/* Transfer buffer to DSP side: */
+	/* Transfer buffer to DSP side */
 	pChirp->cBytes = WriteData(pIOMgr->hWmdContext, pIOMgr->pOutput,
 			pChirp->pHostSysBuf, min(pIOMgr->uSMBufSize, pChirp->
 			cBytes));
@@ -1471,7 +1505,7 @@ static void OutputChnl(struct IO_MGR *pIOMgr, struct CHNL_OBJECT *pChnl,
 		   uWordSize);
 #endif
 	IO_SetValue(pIOMgr->hWmdContext, struct SHM, sm, outputFull, 1);
-	/* Indicate to the DSP we have written the output: */
+	/* Indicate to the DSP we have written the output */
 	CHNLSM_InterruptDSP2(pIOMgr->hWmdContext, MBX_PCPY_CLASS);
 	/* Notify client with IO completion record (keep EOS) */
 	pChirp->status &= CHNL_IOCSTATEOS;
@@ -1571,8 +1605,7 @@ static void OutputMsg(struct IO_MGR *pIOMgr, struct MSG_MGR *hMsgMgr)
 		}
 	}
 func_end:
-       return;
-
+	return;
 }
 
 /*
@@ -1594,8 +1627,10 @@ static DSP_STATUS registerSHMSegs(struct IO_MGR *hIOMgr,
 	u32 ulShmSegId0 = 0;
 	u32 dwOffset, dwGPPBaseVA, ulDSPSize;
 
-	/* Read address and size info for first SM region.*/
-	/* Get start of 1st SM Heap region */
+	/*
+	 * Read address and size info for first SM region.
+	 * Get start of 1st SM Heap region.
+	 */
 	status = COD_GetSymValue(hCodMan, SHM0_SHARED_BASE_SYM, &ulShm0_Base);
 	if (ulShm0_Base == 0) {
 		status = DSP_EFAIL;
@@ -1611,7 +1646,7 @@ static DSP_STATUS registerSHMSegs(struct IO_MGR *hIOMgr,
 			goto func_end;
 		}
 	}
-	/* start of Gpp reserved region */
+	/* Start of Gpp reserved region */
 	if (DSP_SUCCEEDED(status)) {
 		/* Get start and length of message part of shared memory */
 		status = COD_GetSymValue(hCodMan, SHM0_SHARED_RESERVED_BASE_SYM,
@@ -1640,27 +1675,29 @@ static DSP_STATUS registerSHMSegs(struct IO_MGR *hIOMgr,
 	}
 	/* Register new SM region(s) */
 	if (DSP_SUCCEEDED(status) && (ulShm0_End - ulShm0_Base) > 0) {
-		/* calc size (bytes) of SM the GPP can alloc from */
+		/* Calc size (bytes) of SM the GPP can alloc from */
 		ulRsrvdSize = (ulShm0_End - ulShm0_RsrvdStart + 1) * hIOMgr->
 			      uWordSize;
 		if (ulRsrvdSize <= 0) {
 			status = DSP_EFAIL;
 			goto func_end;
 		}
-		/* calc size of SM DSP can alloc from */
+		/* Calc size of SM DSP can alloc from */
 		ulDSPSize = (ulShm0_RsrvdStart - ulShm0_Base) * hIOMgr->
 			uWordSize;
 		if (ulDSPSize <= 0) {
 			status = DSP_EFAIL;
 			goto func_end;
 		}
-		/*  First TLB entry reserved for Bridge SM use.*/
+		/* First TLB entry reserved for Bridge SM use.*/
 		ulGppPhys = hIOMgr->extProcInfo.tyTlb[0].ulGppPhys;
-		/* get size in bytes */
+		/* Get size in bytes */
 		ulDspVirt = hIOMgr->extProcInfo.tyTlb[0].ulDspVirt * hIOMgr->
 			uWordSize;
-		 /* Calc byte offset used to convert GPP phys <-> DSP byte
-		  * address.*/
+		/*
+		 * Calc byte offset used to convert GPP phys <-> DSP byte
+		 * address.
+		 */
 		if (dwGPPBasePA > ulDspVirt)
 			dwOffset = dwGPPBasePA - ulDspVirt;
 		else
@@ -1670,15 +1707,19 @@ static DSP_STATUS registerSHMSegs(struct IO_MGR *hIOMgr,
 			status = DSP_EFAIL;
 			goto func_end;
 		}
-		/* calc Gpp phys base of SM region */
-		/* Linux - this is actually uncached kernel virtual address*/
+		/*
+		 * Calc Gpp phys base of SM region.
+		 * This is actually uncached kernel virtual address.
+		 */
 		dwGPPBaseVA = ulGppPhys + ulShm0_RsrvdStart * hIOMgr->uWordSize
 				- ulDspVirt;
-		/* calc Gpp phys base of SM region */
-		/* Linux - this is the physical address*/
+		/*
+		 * Calc Gpp phys base of SM region.
+		 * This is the physical address.
+		 */
 		dwGPPBasePA = dwGPPBasePA + ulShm0_RsrvdStart * hIOMgr->
 			      uWordSize - ulDspVirt;
-		 /* Register SM Segment 0.*/
+		/* Register SM Segment 0.*/
 		status = CMM_RegisterGPPSMSeg(hIOMgr->hCmmMgr, dwGPPBasePA,
 			 ulRsrvdSize, dwOffset, (dwGPPBasePA > ulDspVirt) ?
 			 CMM_ADDTODSPPA : CMM_SUBFROMDSPPA,
@@ -1688,7 +1729,7 @@ static DSP_STATUS registerSHMSegs(struct IO_MGR *hIOMgr,
 			DBG_Trace(DBG_LEVEL7, "ERROR - Failed to register SM "
 				 "Seg 0 \n");
 		}
-		/* first SM region is segId = 1 */
+		/* First SM region is segId = 1 */
 		if (ulShmSegId0 != 1)
 			status = DSP_EFAIL;
 	}
@@ -1712,7 +1753,7 @@ static u32 ReadData(struct WMD_DEV_CONTEXT *hDevContext, void *pDest,
  *      Copies buffers from the host side buffer to the shared memory.
  */
 static u32 WriteData(struct WMD_DEV_CONTEXT *hDevContext, void *pDest,
-		       void *pSrc, u32 uSize)
+			void *pSrc, u32 uSize)
 {
 	memcpy(pDest, pSrc, uSize);
 	return uSize;
@@ -1746,8 +1787,10 @@ DSP_STATUS IO_SHMsetting(IN struct IO_MGR *hIOMgr, IN enum SHM_DESCTYPE desc,
 			return DSP_EFAIL;
 		break;
 	case SHM_OPPINFO:
-		/* Update the shared memory with the voltage, frequency,
-				   min and max frequency values for an OPP */
+		/*
+		 * Update the shared memory with the voltage, frequency,
+		 * min and max frequency values for an OPP.
+		 */
 		for (i = 0; i <= dsp_max_opps; i++) {
 			hIOMgr->pSharedMem->oppTableStruct.oppPoint[i].voltage =
 				vdd1_dsp_freq[i][0];
@@ -1815,7 +1858,7 @@ void PrintDSPDebugTrace(struct IO_MGR *hIOMgr)
 {
 	u32 ulNewMessageLength = 0, ulGPPCurPointer;
 
-       GT_0trace(dsp_trace_mask, GT_ENTER, "Entering PrintDSPDebugTrace\n");
+	GT_0trace(dsp_trace_mask, GT_ENTER, "Entering PrintDSPDebugTrace\n");
 
 	while (true) {
 		/* Get the DSP current pointer */
@@ -1824,25 +1867,25 @@ void PrintDSPDebugTrace(struct IO_MGR *hIOMgr)
 				  hIOMgr->ulDspVa);
 
 		/* No new debug messages available yet */
-		if (ulGPPCurPointer == hIOMgr->ulGPPReadPointer)
+		if (ulGPPCurPointer == hIOMgr->ulGPPReadPointer) {
 			break;
-
-		/* Continuous data */
-		else if (ulGPPCurPointer > hIOMgr->ulGPPReadPointer) {
+		} else if (ulGPPCurPointer > hIOMgr->ulGPPReadPointer) {
+			/* Continuous data */
 			ulNewMessageLength = ulGPPCurPointer - hIOMgr->
 					     ulGPPReadPointer;
 
 			memcpy(hIOMgr->pMsg, (char *)hIOMgr->ulGPPReadPointer,
-			       ulNewMessageLength);
+				ulNewMessageLength);
 			hIOMgr->pMsg[ulNewMessageLength] = '\0';
-			/* Advance the GPP trace pointer to DSP current
-			 * pointer */
+			/*
+			 * Advance the GPP trace pointer to DSP current
+			 * pointer.
+			 */
 			hIOMgr->ulGPPReadPointer += ulNewMessageLength;
 			/* Print the trace messages */
 			GT_0trace(dsp_trace_mask, GT_1CLASS, hIOMgr->pMsg);
-		}
-		/* Handle trace buffer wraparound */
-		else if (ulGPPCurPointer < hIOMgr->ulGPPReadPointer) {
+		} else if (ulGPPCurPointer < hIOMgr->ulGPPReadPointer) {
+			/* Handle trace buffer wraparound */
 			memcpy(hIOMgr->pMsg, (char *)hIOMgr->ulGPPReadPointer,
 				hIOMgr->ulTraceBufferEnd -
 				hIOMgr->ulGPPReadPointer);
@@ -1855,8 +1898,10 @@ void PrintDSPDebugTrace(struct IO_MGR *hIOMgr)
 			hIOMgr->pMsg[hIOMgr->ulTraceBufferEnd -
 				hIOMgr->ulGPPReadPointer +
 				ulNewMessageLength] = '\0';
-			/* Advance the GPP trace pointer to DSP current
-			 * pointer */
+			/*
+			 * Advance the GPP trace pointer to DSP current
+			 * pointer.
+			 */
 			hIOMgr->ulGPPReadPointer = hIOMgr->ulTraceBufferBegin +
 						   ulNewMessageLength;
 			/* Print the trace messages */
@@ -1895,7 +1940,7 @@ static DSP_STATUS PackTraceBuffer(char *lpBuf, u32 nBytes, u32 ulNumWords)
 	u32 nCnt;
 	char thisChar;
 
-	/* tmp workspace, 1 KB longer than input buf */
+	/* Tmp workspace, 1 KB longer than input buf */
 	lpTmpBuf = MEM_Calloc((nBytes + ulNumWords), MEM_PAGED);
 	if (lpTmpBuf == NULL) {
 		DBG_Trace(DBG_LEVEL7, "PackTrace buffer:OutofMemory \n");
@@ -1911,8 +1956,10 @@ static DSP_STATUS PackTraceBuffer(char *lpBuf, u32 nBytes, u32 ulNumWords)
 			case '\0':      /* Skip null bytes */
 				break;
 			case '\n':      /* Convert \n to \r\n */
-				/* NOTE: do not reverse order; Some OS */
-				/* editors control doesn't understand "\n\r" */
+				/*
+				 * NOTE: do not reverse order; Some OS
+				 * editors control doesn't understand "\n\r"
+				 */
 				*lpTmpBuf++ = '\r';
 				*lpTmpBuf++ = '\n';
 				break;
@@ -1924,7 +1971,7 @@ static DSP_STATUS PackTraceBuffer(char *lpBuf, u32 nBytes, u32 ulNumWords)
 		*lpTmpBuf = '\0';    /* Make sure tmp buf is null terminated */
 		/* Cut output down to input buf size */
 		strncpy(lpBufStart, lpTmpStart, nBytes);
-		/*Make sure output is null terminated */
+		/* Make sure output is null terminated */
 		lpBufStart[nBytes - 1] = '\0';
 		MEM_Free(lpTmpStart);
 	}
@@ -1972,7 +2019,7 @@ DSP_STATUS PrintDspTraceBuffer(struct WMD_DEV_CONTEXT *hWmdContext)
 			"PrintDspTraceBuffer: Failed on DEV_GetCodMgr.\n");
 
 	if (DSP_SUCCEEDED(status)) {
-		/* Look for SYS_PUTCBEG/SYS_PUTCEND: */
+		/* Look for SYS_PUTCBEG/SYS_PUTCEND */
 		status = COD_GetSymValue(hCodMgr, COD_TRACEBEG, &ulTraceBegin);
 		GT_1trace(dsp_trace_mask, GT_2CLASS,
 			"PrintDspTraceBuffer: ulTraceBegin Value 0x%x\n",
-- 
1.6.2.4


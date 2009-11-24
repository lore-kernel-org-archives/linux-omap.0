From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 5/9] DSPBRIDGE: trivial cleanup and indentation for io_sm
Date: Mon, 23 Nov 2009 18:50:26 -0600
Message-ID: <1259023830-7557-6-git-send-email-omar.ramirez@ti.com>
References: <1259023830-7557-1-git-send-email-omar.ramirez@ti.com>
 <1259023830-7557-2-git-send-email-omar.ramirez@ti.com>
 <1259023830-7557-3-git-send-email-omar.ramirez@ti.com>
 <1259023830-7557-4-git-send-email-omar.ramirez@ti.com>
 <1259023830-7557-5-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:51705 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757339AbZKXApI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 23 Nov 2009 19:45:08 -0500
In-Reply-To: <1259023830-7557-5-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Artem Bityutskiy <dedekind1@gmail.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Omar Ramirez Luna <omar.ramirez@ti.com>

Remove duplicate set of braces from if statement and reduce
indentation.

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 drivers/dsp/bridge/wmd/io_sm.c |   96 +++++++++++++++++-----------------------
 1 files changed, 40 insertions(+), 56 deletions(-)

diff --git a/drivers/dsp/bridge/wmd/io_sm.c b/drivers/dsp/bridge/wmd/io_sm.c
index af31831..96a5aa6 100644
--- a/drivers/dsp/bridge/wmd/io_sm.c
+++ b/drivers/dsp/bridge/wmd/io_sm.c
@@ -115,7 +115,7 @@ struct IO_MGR {
 	/* private extnd proc info; mmu setup */
 	struct MGR_PROCESSOREXTINFO extProcInfo;
 	struct CMM_OBJECT *hCmmMgr; 	/* Shared Mem Mngr	      */
-       struct work_struct io_workq;     /*workqueue */
+	struct work_struct io_workq;     /*workqueue */
 	u32 dQuePowerMbxVal[MAX_PM_REQS];
 	u32 iQuePowerHead;
 	u32 iQuePowerTail;
@@ -185,7 +185,7 @@ DSP_STATUS WMD_IO_Create(OUT struct IO_MGR **phIOMgr,
 	struct CFG_HOSTRES hostRes;
 	struct CFG_DEVNODE *hDevNode;
 	struct CHNL_MGR *hChnlMgr;
-       static int ref_count;
+	static int ref_count;
 	u32 devType;
 	/* Check requirements:  */
 	if (!phIOMgr || !pMgrAttrs || pMgrAttrs->uWordSize == 0) {
@@ -197,9 +197,10 @@ DSP_STATUS WMD_IO_Create(OUT struct IO_MGR **phIOMgr,
 		status = DSP_EHANDLE;
 		goto func_end;
 	}
-	 /*  Message manager will be created when a file is loaded, since
+	/*  Message manager will be created when a file is loaded, since
 	 *  size of message buffer in shared memory is configurable in
-	 *  the base image.  */
+	 *  the base image.
+	 */
 	DEV_GetWMDContext(hDevObject, &hWmdContext);
 	if (!hWmdContext) {
 		status = DSP_EHANDLE;
@@ -209,7 +210,8 @@ DSP_STATUS WMD_IO_Create(OUT struct IO_MGR **phIOMgr,
 	/*  DSP shared memory area will get set properly when
 	 *  a program is loaded. They are unknown until a COFF file is
 	 *  loaded. I chose the value -1 because it was less likely to be
-	 *  a valid address than 0.  */
+	 *  a valid address than 0.
+	 */
 	pSharedMem = (struct SHM *) -1;
 	if (DSP_FAILED(status))
 		goto func_cont;
@@ -230,7 +232,7 @@ DSP_STATUS WMD_IO_Create(OUT struct IO_MGR **phIOMgr,
 		status = DSP_EMEMORY;
 		goto func_cont;
 	}
-	/*Intializing Work Element*/
+	/* Intializing Work Element */
 	if (ref_count == 0) {
 		INIT_WORK(&pIOMgr->io_workq, (void *)IO_DispatchPM);
 		ref_count = 1;
@@ -319,7 +321,7 @@ DSP_STATUS WMD_IO_Destroy(struct IO_MGR *hIOMgr)
 		SYNC_DeleteCS(hIOMgr->hCSObj); 	/* Leak Fix. */
 		/* Free this IO manager object: */
 		MEM_FreeObject(hIOMgr);
-       } else
+	} else
 		status = DSP_EHANDLE;
 
 	return status;
@@ -445,19 +447,16 @@ func_cont1:
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
@@ -609,7 +608,7 @@ func_cont1:
 		}
 	}
 
-	 /* Copy remaining entries from CDB. All entries are 1 MB and should not
+	/* Copy remaining entries from CDB. All entries are 1 MB and should not
 	 * conflict with SHM entries on MPU or DSP side */
 	for (i = 3; i < 7 && ndx < WMDIOCTL_NUMOFMMUTLB &&
 	    DSP_SUCCEEDED(status); i++) {
@@ -726,9 +725,9 @@ func_cont:
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
@@ -780,7 +779,6 @@ func_cont:
 				 &hIOMgr->ulTraceBufferBegin);
 			if (DSP_FAILED(status))
 				status = CHNL_E_NOMEMMAP;
-
 		}
 		hIOMgr->ulGPPReadPointer = hIOMgr->ulTraceBufferBegin =
 			(ulGppVa + ulSeg1Size + ulPadSize) +
@@ -791,7 +789,6 @@ func_cont:
 				 &hIOMgr->ulTraceBufferEnd);
 			if (DSP_FAILED(status))
 				status = CHNL_E_NOMEMMAP;
-
 		}
 		hIOMgr->ulTraceBufferEnd = (ulGppVa + ulSeg1Size + ulPadSize) +
 					   (hIOMgr->ulTraceBufferEnd - ulDspVa);
@@ -802,7 +799,6 @@ func_cont:
 				 &hIOMgr->ulTraceBufferCurrent);
 			if (DSP_FAILED(status))
 				status = CHNL_E_NOMEMMAP;
-
 		}
 		hIOMgr->ulTraceBufferCurrent = (ulGppVa + ulSeg1Size +
 						ulPadSize) + (hIOMgr->
@@ -957,9 +953,7 @@ static void IO_DispatchPM(struct work_struct *work)
 		pIOMgr->iQuePowerTail++;
 		if (pIOMgr->iQuePowerTail >= MAX_PM_REQS)
 			pIOMgr->iQuePowerTail = 0;
-
 	}
-
 }
 
 /*
@@ -988,7 +982,6 @@ void IO_DPC(IN OUT void *pRefData)
 		/* notify DSP/BIOS exception */
 		if (hDehMgr)
 			WMD_DEH_Notify(hDehMgr, DSP_SYSERROR, pIOMgr->wIntrVal);
-
 	}
 	IO_DispatchChnl(pIOMgr, NULL, IO_SERVICE);
 #ifdef CHNL_MESSAGES
@@ -1002,15 +995,10 @@ void IO_DPC(IN OUT void *pRefData)
 			PrintDSPDebugTrace(pIOMgr);
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
@@ -1028,29 +1016,28 @@ irqreturn_t IO_ISR(int irq, IN void *pRefData)
 
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
+			/* PROC-COPY defer i/o  */
+			DPC_Schedule(hIOMgr->hDPC);
 		}
-       } else
+	} else
 		/* Ensure that, if WMD didn't claim it, the IRQ is shared. */
 		DBC_Ensure(hIOMgr->fSharedIRQ);
-       return IRQ_HANDLED;
+
+	return IRQ_HANDLED;
 }
 
 /*
@@ -1131,7 +1118,6 @@ static u32 FindReadyOutput(struct CHNL_MGR *pChnlMgr,
 				uRetval = id;
 				if (pChnl == NULL)
 					pChnlMgr->dwLastOutput = id;
-
 				break;
 			}
 			id = id + 1;
@@ -1362,8 +1348,7 @@ static void InputMsg(struct IO_MGR *pIOMgr, struct MSG_MGR *hMsgMgr)
 		CHNLSM_InterruptDSP2(pIOMgr->hWmdContext, MBX_PCPY_CLASS);
 	}
 func_end:
-       return;
-
+	return;
 }
 
 /*
@@ -1380,10 +1365,10 @@ static void NotifyChnlComplete(struct CHNL_OBJECT *pChnl,
 	   !pChnl->pIOCompletions || !pChirp)
 		goto func_end;
 
-	 /*  Note: we signal the channel event only if the queue of IO
-	  *  completions is empty.  If it is not empty, the event is sure to be
-	  *  signalled by the only IO completion list consumer:
-	  *  WMD_CHNL_GetIOC().  */
+	/*  Note: we signal the channel event only if the queue of IO
+	 *  completions is empty.  If it is not empty, the event is sure to be
+	 *  signalled by the only IO completion list consumer:
+	 *  WMD_CHNL_GetIOC().  */
 	fSignalEvent = LST_IsEmpty(pChnl->pIOCompletions);
 	/* Enqueue the IO completion info for the client: */
 	LST_PutTail(pChnl->pIOCompletions, (struct LST_ELEM *) pChirp);
@@ -1434,7 +1419,7 @@ static void OutputChnl(struct IO_MGR *pIOMgr, struct CHNL_OBJECT *pChnl,
 		goto func_end;
 
 	pChnl = pChnlMgr->apChannel[chnlId];
-       if (!pChnl || !pChnl->pIORequests) {
+	if (!pChnl || !pChnl->pIORequests) {
 		/* Shouldn't get here: */
 		goto func_end;
 	}
@@ -1570,8 +1555,7 @@ static void OutputMsg(struct IO_MGR *pIOMgr, struct MSG_MGR *hMsgMgr)
 		}
 	}
 func_end:
-       return;
-
+	return;
 }
 
 /*
@@ -1711,7 +1695,7 @@ static u32 ReadData(struct WMD_DEV_CONTEXT *hDevContext, void *pDest,
  *      Copies buffers from the host side buffer to the shared memory.
  */
 static u32 WriteData(struct WMD_DEV_CONTEXT *hDevContext, void *pDest,
-		       void *pSrc, u32 uSize)
+			void *pSrc, u32 uSize)
 {
 	memcpy(pDest, pSrc, uSize);
 	return uSize;
@@ -1814,7 +1798,7 @@ void PrintDSPDebugTrace(struct IO_MGR *hIOMgr)
 {
 	u32 ulNewMessageLength = 0, ulGPPCurPointer;
 
-       GT_0trace(dsp_trace_mask, GT_ENTER, "Entering PrintDSPDebugTrace\n");
+	GT_0trace(dsp_trace_mask, GT_ENTER, "Entering PrintDSPDebugTrace\n");
 
 	while (true) {
 		/* Get the DSP current pointer */
@@ -1832,7 +1816,7 @@ void PrintDSPDebugTrace(struct IO_MGR *hIOMgr)
 					     ulGPPReadPointer;
 
 			memcpy(hIOMgr->pMsg, (char *)hIOMgr->ulGPPReadPointer,
-			       ulNewMessageLength);
+				ulNewMessageLength);
 			hIOMgr->pMsg[ulNewMessageLength] = '\0';
 			/* Advance the GPP trace pointer to DSP current
 			 * pointer */
-- 
1.6.2.4


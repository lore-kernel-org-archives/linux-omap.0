From: "Guzman Lugo, Fernando" <x0095840@ti.com>
Subject: PATCH] DSPBRIDGE: return right error codes wmd directory
Date: Wed, 16 Dec 2009 15:54:15 -0600
Message-ID: <496565EC904933469F292DDA3F1663E602A9ADCC11@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:58638 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757281AbZLPVyS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 Dec 2009 16:54:18 -0500
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id nBGLsIwh026153
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 16 Dec 2009 15:54:18 -0600
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep34.itg.ti.com (8.13.7/8.13.7) with ESMTP id nBGLsH2T020410
	for <linux-omap@vger.kernel.org>; Wed, 16 Dec 2009 15:54:17 -0600 (CST)
Received: from dsbe71.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id nBGLsHWv015134
	for <linux-omap@vger.kernel.org>; Wed, 16 Dec 2009 15:54:17 -0600 (CST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

>From 1eff8623eafbff7dd187a3e226442d5650adf7c3 Mon Sep 17 00:00:00 2001
From: Fernando Guzman Lugo <x0095840@ti.com>
Date: Wed, 16 Dec 2009 14:53:53 -0600
Subject: [PATCH] DSPBRIDGE: return right error codes wmd directory

This patch fixes the bad error codes returned by some functions,
also it is taking cafe about some status returned by
functions which were not checked before and removing unused check
or status variables.

Signed-off-by: Fernando Guzman Lugo <x0095840@ti.com>
---
 drivers/dsp/bridge/wmd/chnl_sm.c        |  226 ++++++++++------------
 drivers/dsp/bridge/wmd/io_sm.c          |  319 ++++++++++++++----------------
 drivers/dsp/bridge/wmd/mmu_fault.c      |   18 +--
 drivers/dsp/bridge/wmd/msg_sm.c         |   45 +++--
 drivers/dsp/bridge/wmd/tiomap3430.c     |   28 +--
 drivers/dsp/bridge/wmd/tiomap3430_pwr.c |   12 +-
 drivers/dsp/bridge/wmd/tiomap_io.c      |   10 +-
 drivers/dsp/bridge/wmd/tiomap_sm.c      |    2 -
 drivers/dsp/bridge/wmd/ue_deh.c         |   38 +---
 9 files changed, 311 insertions(+), 387 deletions(-)

diff --git a/drivers/dsp/bridge/wmd/chnl_sm.c b/drivers/dsp/bridge/wmd/chnl_sm.c
index 462fc58..fb1c8ba 100644
--- a/drivers/dsp/bridge/wmd/chnl_sm.c
+++ b/drivers/dsp/bridge/wmd/chnl_sm.c
@@ -109,7 +109,32 @@ DSP_STATUS WMD_CHNL_AddIOReq(struct CHNL_OBJECT *hChnl, void *pHostBuf,
                  "%x Id %d\n", pChnl, CHNL_IsOutput(pChnl->uMode),
                  pChnl->uChnlType, pChnl->uId);

-       fIsEOS = (cBytes == 0) ? true : false;
+       /* Validate args:  */
+       if (pHostBuf == NULL) {
+               status = DSP_EPOINTER;
+       } else if (!MEM_IsValidHandle(pChnl, CHNL_SIGNATURE)) {
+               status = DSP_EHANDLE;
+       } else if (fIsEOS && CHNL_IsInput(pChnl->uMode)) {
+               status = CHNL_E_NOEOS;
+       } else {
+               /* Check the channel state: only queue chirp if channel state
+                * allows */
+               dwState = pChnl->dwState;
+               if (dwState != CHNL_STATEREADY) {
+                       if (dwState & CHNL_STATECANCEL)
+                               status = CHNL_E_CANCELLED;
+                       else if ((dwState & CHNL_STATEEOS)
+                                  && CHNL_IsOutput(pChnl->uMode))
+                               status = CHNL_E_EOS;
+                       else
+                               /* No other possible states left: */
+                               DBC_Assert(0);
+               }
+       }
+       if (DSP_FAILED(status))
+               goto func_end;
+
+       fIsEOS = (cBytes == 0);

        if (pChnl->uChnlType == CHNL_PCPY && pChnl->uId > 1 && pHostBuf) {
                if (!(pHostBuf < (void *)USERMODE_ADDR)) {
@@ -122,7 +147,7 @@ DSP_STATUS WMD_CHNL_AddIOReq(struct CHNL_OBJECT *hChnl, void *pHostBuf,
                        status = DSP_EMEMORY;
                        DBG_Trace(DBG_LEVEL7,
                                 "No memory to allocate kernel buffer\n");
-                       goto func_cont;
+                       goto func_end;
                }
                if (CHNL_IsOutput(pChnl->uMode)) {
                        status = copy_from_user(pHostSysBuf, pHostBuf,
@@ -135,33 +160,11 @@ DSP_STATUS WMD_CHNL_AddIOReq(struct CHNL_OBJECT *hChnl, void *pHostBuf,
                                MEM_Free(pHostSysBuf);
                                pHostSysBuf = NULL;
                                status = DSP_EPOINTER;
+                               goto func_end;
                        }
                }
        }
 func_cont:
-       /* Validate args:  */
-       if (pHostBuf == NULL) {
-               status = DSP_EPOINTER;
-       } else if (!MEM_IsValidHandle(pChnl, CHNL_SIGNATURE)) {
-               status = DSP_EHANDLE;
-       } else if (fIsEOS && CHNL_IsInput(pChnl->uMode)) {
-               status = CHNL_E_NOEOS;
-       } else {
-               /* Check the channel state: only queue chirp if channel state
-                * allows */
-               dwState = pChnl->dwState;
-               if (dwState != CHNL_STATEREADY) {
-                       if (dwState & CHNL_STATECANCEL) {
-                               status = CHNL_E_CANCELLED;
-                       } else if ((dwState & CHNL_STATEEOS)
-                                  && CHNL_IsOutput(pChnl->uMode)) {
-                               status = CHNL_E_EOS;
-                       } else {
-                               /* No other possible states left: */
-                               DBC_Assert(0);
-                       }
-               }
-       }
        /* Mailbox IRQ is disabled to avoid race condition with DMA/ZCPY
         * channels. DPCCS is held to avoid race conditions with PCPY channels.
         * If DPC is scheduled in process context (IO_Schedule) and any
@@ -191,47 +194,47 @@ func_cont:
                if (pChnl->uChnlType == CHNL_PCPY && pChnl->uId > 1)
                        pChirp->pHostSysBuf = pHostSysBuf;

-               if (DSP_SUCCEEDED(status)) {
-                       /* Note: for dma chans dwDspAddr contains dsp address
-                        * of SM buffer.*/
-                       DBC_Assert(pChnlMgr->uWordSize != 0);
-                       /* DSP address */
-                       pChirp->uDspAddr = dwDspAddr / pChnlMgr->uWordSize;
-                       pChirp->cBytes = cBytes;
-                       pChirp->cBufSize = cBufSize;
-                       /* Only valid for output channel */
-                       pChirp->dwArg = dwArg;
-                       pChirp->status = (fIsEOS ? CHNL_IOCSTATEOS :
-                                        CHNL_IOCSTATCOMPLETE);
-                       LST_PutTail(pChnl->pIORequests, (struct LST_ELEM *)
-                                  pChirp);
-                       pChnl->cIOReqs++;
-                       DBC_Assert(pChnl->cIOReqs <= pChnl->cChirps);
-                       /* If end of stream, update the channel state to prevent
-                        * more IOR's: */
-                       if (fIsEOS)
-                               pChnl->dwState |= CHNL_STATEEOS;
+               /*
+                * Note: for dma chans dwDspAddr contains dsp address
+                * of SM buffer.
+                */
+               DBC_Assert(pChnlMgr->uWordSize != 0);
+               /* DSP address */
+               pChirp->uDspAddr = dwDspAddr / pChnlMgr->uWordSize;
+               pChirp->cBytes = cBytes;
+               pChirp->cBufSize = cBufSize;
+               /* Only valid for output channel */
+               pChirp->dwArg = dwArg;
+               pChirp->status = (fIsEOS ? CHNL_IOCSTATEOS :
+                                               CHNL_IOCSTATCOMPLETE);
+               LST_PutTail(pChnl->pIORequests, (struct LST_ELEM *)pChirp);
+               pChnl->cIOReqs++;
+               DBC_Assert(pChnl->cIOReqs <= pChnl->cChirps);
+               /* If end of stream, update the channel state to prevent
+                * more IOR's: */
+               if (fIsEOS)
+                       pChnl->dwState |= CHNL_STATEEOS;
+
+               /* Legacy DSM Processor-Copy */
+               DBC_Assert(pChnl->uChnlType == CHNL_PCPY);
+               /* Request IO from the DSP */
+               IO_RequestChnl(pChnlMgr->hIOMgr, pChnl,
+                       (CHNL_IsInput(pChnl->uMode) ? IO_INPUT : IO_OUTPUT),
+                                                               &wMbVal);
+               fSchedDPC = true;
+

-                       {
-                               /* Legacy DSM Processor-Copy */
-                               DBC_Assert(pChnl->uChnlType == CHNL_PCPY);
-                               /* Request IO from the DSP */
-                               IO_RequestChnl(pChnlMgr->hIOMgr, pChnl,
-                                       (CHNL_IsInput(pChnl->uMode) ?
-                                       IO_INPUT : IO_OUTPUT), &wMbVal);
-                               fSchedDPC = true;
-                       }
-               }
        }
        enable_irq(MAILBOX_IRQ);
        SYNC_LeaveCS(pChnlMgr->hCSObj);
        if (wMbVal != 0)
                IO_IntrDSP2(pChnlMgr->hIOMgr, wMbVal);

-       if (fSchedDPC == true) {
-               /* Schedule a DPC, to do the actual data transfer: */
+       /* Schedule a DPC, to do the actual data transfer: */
+       if (fSchedDPC)
                IO_Schedule(pChnlMgr->hIOMgr);
-       }
+
+func_end:
        DBG_Trace(DBG_ENTER, "< WMD_CHNL_AddIOReq pChnl %p\n", pChnl);
        return status;
 }
@@ -382,58 +385,48 @@ DSP_STATUS WMD_CHNL_Create(OUT struct CHNL_MGR **phChnlMgr,
        DSP_STATUS status = DSP_SOK;
        struct CHNL_MGR *pChnlMgr = NULL;
        s32 cChannels;
-#ifdef CONFIG_BRIDGE_DEBUG
-       struct CHNL_MGR *hChnlMgr;
-#endif
+
        /* Check DBC requirements:  */
        DBC_Require(phChnlMgr != NULL);
        DBC_Require(pMgrAttrs != NULL);
        DBC_Require(pMgrAttrs->cChannels > 0);
        DBC_Require(pMgrAttrs->cChannels <= CHNL_MAXCHANNELS);
        DBC_Require(pMgrAttrs->uWordSize != 0);
-#ifdef CONFIG_BRIDGE_DEBUG
-       /* This for the purposes of DBC_Require: */
-       status = DEV_GetChnlMgr(hDevObject, &hChnlMgr);
-       DBC_Require(status != DSP_EHANDLE);
-       DBC_Require(hChnlMgr == NULL);
-#endif
-       if (DSP_SUCCEEDED(status)) {
-               /* Allocate channel manager object: */
-               MEM_AllocObject(pChnlMgr, struct CHNL_MGR, CHNL_MGRSIGNATURE);
-               if (pChnlMgr) {
-                       /* The cChannels attr must equal the # of supported
-                        * chnls for each transport(# chnls for PCPY = DDMA =
-                        * ZCPY): i.e. pMgrAttrs->cChannels = CHNL_MAXCHANNELS =
-                        * DDMA_MAXDDMACHNLS = DDMA_MAXZCPYCHNLS.  */
-                       DBC_Assert(pMgrAttrs->cChannels == CHNL_MAXCHANNELS);
-                       cChannels = (CHNL_MAXCHANNELS + (CHNL_MAXCHANNELS *
-                                   CHNL_PCPY));
-                       /* Create array of channels: */
-                       pChnlMgr->apChannel = MEM_Calloc(
-                                               sizeof(struct CHNL_OBJECT *) *
-                                               cChannels, MEM_NONPAGED);
-                       if (pChnlMgr->apChannel) {
-                               /* Initialize CHNL_MGR object: */
-                               /* Shared memory driver. */
-                               pChnlMgr->dwType = CHNL_TYPESM;
-                               pChnlMgr->uWordSize = pMgrAttrs->uWordSize;
-                               /* total # chnls supported */
-                               pChnlMgr->cChannels = cChannels;
-                               pChnlMgr->cOpenChannels = 0;
-                               pChnlMgr->dwOutputMask = 0;
-                               pChnlMgr->dwLastOutput = 0;
-                               pChnlMgr->hDevObject = hDevObject;
-                               if (DSP_SUCCEEDED(status)) {
-                                       status = SYNC_InitializeDPCCS
-                                               (&pChnlMgr->hCSObj);
-                               }
-                       } else {
-                               status = DSP_EMEMORY;
-                       }
+
+       /* Allocate channel manager object: */
+       MEM_AllocObject(pChnlMgr, struct CHNL_MGR, CHNL_MGRSIGNATURE);
+       if (pChnlMgr) {
+               /* The cChannels attr must equal the # of supported
+                * chnls for each transport(# chnls for PCPY = DDMA =
+                * ZCPY): i.e. pMgrAttrs->cChannels = CHNL_MAXCHANNELS =
+                * DDMA_MAXDDMACHNLS = DDMA_MAXZCPYCHNLS.  */
+               DBC_Assert(pMgrAttrs->cChannels == CHNL_MAXCHANNELS);
+               cChannels = CHNL_MAXCHANNELS + CHNL_MAXCHANNELS * CHNL_PCPY;
+               /* Create array of channels: */
+               pChnlMgr->apChannel = MEM_Calloc(
+                               sizeof(struct CHNL_OBJECT *) *
+                               cChannels, MEM_NONPAGED);
+               if (pChnlMgr->apChannel) {
+                       /* Initialize CHNL_MGR object: */
+                       /* Shared memory driver. */
+                       pChnlMgr->dwType = CHNL_TYPESM;
+                       pChnlMgr->uWordSize = pMgrAttrs->uWordSize;
+                       /* total # chnls supported */
+                       pChnlMgr->cChannels = cChannels;
+                       pChnlMgr->cOpenChannels = 0;
+                       pChnlMgr->dwOutputMask = 0;
+                       pChnlMgr->dwLastOutput = 0;
+                       pChnlMgr->hDevObject = hDevObject;
+                       if (DSP_SUCCEEDED(status))
+                               status = SYNC_InitializeDPCCS(
+                                                       &pChnlMgr->hCSObj);
                } else {
                        status = DSP_EMEMORY;
                }
+       } else {
+               status = DSP_EMEMORY;
        }
+
        if (DSP_FAILED(status)) {
                WMD_CHNL_Destroy(pChnlMgr);
                *phChnlMgr = NULL;
@@ -458,10 +451,10 @@ DSP_STATUS WMD_CHNL_Destroy(struct CHNL_MGR *hChnlMgr)
        if (MEM_IsValidHandle(hChnlMgr, CHNL_MGRSIGNATURE)) {
                /* Close all open channels: */
                for (iChnl = 0; iChnl < pChnlMgr->cChannels; iChnl++) {
-                       if (DSP_SUCCEEDED
-                           (WMD_CHNL_Close(pChnlMgr->apChannel[iChnl]))) {
-                               DBC_Assert(pChnlMgr->apChannel[iChnl] == NULL);
-                       }
+                       status = WMD_CHNL_Close(pChnlMgr->apChannel[iChnl]);
+                       if (DSP_FAILED(status))
+                               DBG_Trace(DBG_LEVEL7, "Error in CHNL_Close "
+                                               "status 0x%x\n", status);
                }
                /* release critical section */
                if (pChnlMgr->hCSObj)
@@ -804,6 +797,7 @@ DSP_STATUS WMD_CHNL_Open(OUT struct CHNL_OBJECT **phChnl,
        /* Ensure DBC requirements:  */
        DBC_Require(phChnl != NULL);
        DBC_Require(pAttrs != NULL);
+       DBC_Require(hChnlMgr != NULL);
        *phChnl = NULL;
        /* Validate Args:  */
        if (pAttrs->uIOReqs == 0) {
@@ -813,12 +807,11 @@ DSP_STATUS WMD_CHNL_Open(OUT struct CHNL_OBJECT **phChnl,
                        status = DSP_EHANDLE;
                } else {
                        if (uChnlId != CHNL_PICKFREE) {
-                               if (uChnlId >= pChnlMgr->cChannels) {
+                               if (uChnlId >= pChnlMgr->cChannels)
                                        status = CHNL_E_BADCHANID;
-                               } else if (pChnlMgr->apChannel[uChnlId] !=
-                                         NULL) {
+                               else if (pChnlMgr->apChannel[uChnlId] !=
+                                         NULL)
                                        status = CHNL_E_CHANBUSY;
-                               }
                        } else {
                                /* Check for free channel */
                                status = SearchFreeChannel(pChnlMgr, &uChnlId);
@@ -833,7 +826,7 @@ DSP_STATUS WMD_CHNL_Open(OUT struct CHNL_OBJECT **phChnl,
        MEM_AllocObject(pChnl, struct CHNL_OBJECT, 0x0000);
        if (!pChnl) {
                status = DSP_EMEMORY;
-               goto func_cont;
+               goto func_end;
        }
        /* Protect queues from IO_DPC: */
        pChnl->dwState = CHNL_STATECANCEL;
@@ -845,13 +838,9 @@ DSP_STATUS WMD_CHNL_Open(OUT struct CHNL_OBJECT **phChnl,
        pChnl->cIOCs = 0;
        pChnl->cIOReqs = 0;
        status = SYNC_OpenEvent(&hSyncEvent, pSyncAttrs);
-       if (DSP_SUCCEEDED(status)) {
+       if (DSP_SUCCEEDED(status))
                status = NTFY_Create(&pChnl->hNtfy);
-               if (DSP_FAILED(status)) {
-                       /* The only failure that could have occurred */
-                       status = DSP_EMEMORY;
-               }
-       }
+
        if (DSP_SUCCEEDED(status)) {
                if (pChnl->pIOCompletions && pChnl->pIORequests &&
                   pChnl->pFreeList) {
@@ -870,9 +859,8 @@ DSP_STATUS WMD_CHNL_Open(OUT struct CHNL_OBJECT **phChnl,
                } else {
                        status = DSP_EMEMORY;
                }
-       } else {
-               status = DSP_EINVALIDARG;
        }
+
        if (DSP_FAILED(status)) {
                /* Free memory */
                if (pChnl->pIOCompletions) {
@@ -897,9 +885,7 @@ DSP_STATUS WMD_CHNL_Open(OUT struct CHNL_OBJECT **phChnl,
                        pChnl->hNtfy = NULL;
                }
                MEM_FreeObject(pChnl);
-       }
-func_cont:
-       if (DSP_SUCCEEDED(status)) {
+       } else {
                /* Insert channel object in channel manager: */
                pChnlMgr->apChannel[pChnl->uId] = pChnl;
                SYNC_EnterCS(pChnlMgr->hCSObj);
diff --git a/drivers/dsp/bridge/wmd/io_sm.c b/drivers/dsp/bridge/wmd/io_sm.c
index 34eb802..208ee29 100644
--- a/drivers/dsp/bridge/wmd/io_sm.c
+++ b/drivers/dsp/bridge/wmd/io_sm.c
@@ -196,8 +196,8 @@ DSP_STATUS WMD_IO_Create(OUT struct IO_MGR **phIOMgr,
                status = DSP_EHANDLE;
                goto func_end;
        }
-       status = DEV_GetChnlMgr(hDevObject, &hChnlMgr);
-       if (status == DSP_EHANDLE || !hChnlMgr || hChnlMgr->hIOMgr) {
+       DEV_GetChnlMgr(hDevObject, &hChnlMgr);
+       if (!hChnlMgr || hChnlMgr->hIOMgr) {
                status = DSP_EHANDLE;
                goto func_end;
        }
@@ -217,8 +217,6 @@ DSP_STATUS WMD_IO_Create(OUT struct IO_MGR **phIOMgr,
         *  a valid address than 0.
         */
        pSharedMem = (struct SHM *) -1;
-       if (DSP_FAILED(status))
-               goto func_cont;

        /*
         * Create a Single Threaded Work Queue
@@ -234,7 +232,7 @@ DSP_STATUS WMD_IO_Create(OUT struct IO_MGR **phIOMgr,
        MEM_AllocObject(pIOMgr, struct IO_MGR, IO_MGRSIGNATURE);
        if (pIOMgr == NULL) {
                status = DSP_EMEMORY;
-               goto func_cont;
+               goto func_end;
        }
        /* Intializing Work Element */
        if (ref_count == 0) {
@@ -281,26 +279,26 @@ DSP_STATUS WMD_IO_Create(OUT struct IO_MGR **phIOMgr,
                        HW_MBOX_initSettings(hostRes.dwMboxBase);
                        /* Plug the channel ISR:. */
                        if ((request_irq(INT_MAIL_MPU_IRQ, IO_ISR, 0,
-                         "DspBridge\tmailbox", (void *)pIOMgr)) == 0) {
-                               status = DSP_SOK;
+                         "DspBridge\tmailbox", (void *)pIOMgr)) == 0)
                                DBG_Trace(DBG_LEVEL1, "ISR_IRQ Object 0x%x \n",
                                                pIOMgr);
-                       } else
+                       else
                                status = CHNL_E_ISR;
                }
-       } else
+       } else {
                status = CHNL_E_ISR;
-func_cont:
+       }
+func_end:
        if (DSP_FAILED(status)) {
                /* Cleanup: */
                WMD_IO_Destroy(pIOMgr);
-               *phIOMgr = NULL;
+               if (phIOMgr)
+                       *phIOMgr = NULL;
        } else {
                /* Return IO manager object to caller... */
                hChnlMgr->hIOMgr = pIOMgr;
                *phIOMgr = pIOMgr;
        }
-func_end:
        return status;
 }

@@ -395,7 +393,7 @@ DSP_STATUS WMD_IO_OnLoaded(struct IO_MGR *hIOMgr)
        hMsgMgr = hIOMgr->hMsgMgr;
        if (!MEM_IsValidHandle(hChnlMgr, CHNL_MGRSIGNATURE) ||
           !MEM_IsValidHandle(hMsgMgr, MSGMGR_SIGNATURE)) {
-               status = DSP_EMEMORY;
+               status = DSP_EHANDLE;
                goto func_end;
        }
        if (hIOMgr->pSharedMem)
@@ -406,25 +404,25 @@ DSP_STATUS WMD_IO_OnLoaded(struct IO_MGR *hIOMgr)
                                 &ulShmBase);
        if (DSP_FAILED(status)) {
                status = CHNL_E_NOMEMMAP;
-               goto func_cont1;
+               goto func_end;
        }
        status = COD_GetSymValue(hCodMan, CHNL_SHARED_BUFFER_LIMIT_SYM,
                                &ulShmLimit);
        if (DSP_FAILED(status)) {
                status = CHNL_E_NOMEMMAP;
-               goto func_cont1;
+               goto func_end;
        }
        if (ulShmLimit <= ulShmBase) {
                status = CHNL_E_INVALIDMEMBASE;
-       } else {
-               /* get total length in bytes */
-               ulShmLength = (ulShmLimit - ulShmBase + 1) * hIOMgr->uWordSize;
-               /* Calculate size of a PROCCOPY shared memory region */
-               DBG_Trace(DBG_LEVEL7,
-                        "**(proc)PROCCOPY SHMMEM SIZE: 0x%x bytes\n",
-                         (ulShmLength - sizeof(struct SHM)));
+               goto func_end;
        }
-func_cont1:
+       /* get total length in bytes */
+       ulShmLength = (ulShmLimit - ulShmBase + 1) * hIOMgr->uWordSize;
+       /* Calculate size of a PROCCOPY shared memory region */
+       DBG_Trace(DBG_LEVEL7,
+                "**(proc)PROCCOPY SHMMEM SIZE: 0x%x bytes\n",
+                 (ulShmLength - sizeof(struct SHM)));
+
        if (DSP_SUCCEEDED(status)) {
                /* Get start and length of message part of shared memory */
                status = COD_GetSymValue(hCodMan, MSG_SHARED_BUFFER_BASE_SYM,
@@ -448,6 +446,8 @@ func_cont1:
                } else {
                        status = CHNL_E_NOMEMMAP;
                }
+       } else {
+               status = CHNL_E_NOMEMMAP;
        }
        if (DSP_SUCCEEDED(status)) {
 #ifndef DSP_TRACEBUF_DISABLED
@@ -516,7 +516,7 @@ func_cont1:
                }
        }
        if (DSP_FAILED(status))
-               goto func_cont;
+               goto func_end;

        paCurr = ulGppPa;
        vaCurr = ulDynExtBase * hIOMgr->uWordSize;
@@ -535,7 +535,7 @@ func_cont1:
        mapAttrs |= DSP_MAPELEMSIZE32;
        mapAttrs |= DSP_MAPDONOTLOCK;

-       while (numBytes && DSP_SUCCEEDED(status)) {
+       while (numBytes) {
                /* To find the max. page size with which both PA & VA are
                 * aligned */
                allBits = paCurr | vaCurr;
@@ -567,8 +567,7 @@ func_cont1:
        /* configure the TLB entries for the next cacheable segment */
        numBytes = ulSegSize;
        vaCurr = ulDspVa * hIOMgr->uWordSize;
-       allBits = 0x0;
-       while (numBytes && DSP_SUCCEEDED(status)) {
+       while (numBytes) {
                /* To find the max. page size with which both PA & VA are
                 * aligned*/
                allBits = paCurr | vaCurr;
@@ -624,8 +623,7 @@ func_cont1:

        /* Copy remaining entries from CDB. All entries are 1 MB and should not
         * conflict with SHM entries on MPU or DSP side */
-       for (i = 3; i < 7 && ndx < WMDIOCTL_NUMOFMMUTLB &&
-           DSP_SUCCEEDED(status); i++) {
+       for (i = 3; i < 7 && ndx < WMDIOCTL_NUMOFMMUTLB; i++) {
                if (hIOMgr->extProcInfo.tyTlb[i].ulGppPhys == 0)
                        continue;

@@ -664,12 +662,10 @@ func_cont1:
                                        0x100000, mapAttrs);
                        }
                }
+               if (DSP_FAILED(status))
+                       goto func_end;
        }
-       if (i < 7 && DSP_SUCCEEDED(status)) {
-               /* All CDB entries could not be made*/
-               status = DSP_EFAIL;
-       }
-func_cont:
+
        mapAttrs = 0x00000000;
        mapAttrs = DSP_MAPLITTLEENDIAN;
        mapAttrs |= DSP_MAPPHYSICALADDR;
@@ -678,158 +674,141 @@ func_cont:

        /* Map the L4 peripherals */
        i = 0;
-       while (L4PeripheralTable[i].physAddr && DSP_SUCCEEDED(status)) {
+       while (L4PeripheralTable[i].physAddr) {
                status = hIOMgr->pIntfFxns->pfnBrdMemMap
                        (hIOMgr->hWmdContext, L4PeripheralTable[i].physAddr,
                        L4PeripheralTable[i].dspVirtAddr, HW_PAGE_SIZE_4KB,
                        mapAttrs);
                if (DSP_FAILED(status))
-                       break;
+                       goto func_end;
                i++;
        }

-       if (DSP_SUCCEEDED(status)) {
-               for (i = ndx; i < WMDIOCTL_NUMOFMMUTLB; i++) {
-                       aEProc[i].ulDspVa = 0;
-                       aEProc[i].ulGppPa = 0;
-                       aEProc[i].ulGppVa = 0;
-                       aEProc[i].ulSize = 0;
+
+       for (i = ndx; i < WMDIOCTL_NUMOFMMUTLB; i++) {
+               aEProc[i].ulDspVa = 0;
+               aEProc[i].ulGppPa = 0;
+               aEProc[i].ulGppVa = 0;
+               aEProc[i].ulSize = 0;
+       }
+       /* Set the SHM physical address entry (grayed out in CDB file)
+        * to the virtual uncached ioremapped address of SHM reserved
+        * on MPU */
+       hIOMgr->extProcInfo.tyTlb[0].ulGppPhys = (ulGppVa + ulSeg1Size +
+                                                ulPadSize);
+       DBG_Trace(DBG_LEVEL1, "*********extProcInfo *********%x \n",
+                 hIOMgr->extProcInfo.tyTlb[0].ulGppPhys);
+       /* Need SHM Phys addr. IO supports only one DSP for now:
+        * uNumProcs=1 */
+       if (!hIOMgr->extProcInfo.tyTlb[0].ulGppPhys || uNumProcs != 1) {
+               status = CHNL_E_NOMEMMAP;
+               goto func_end;
+       } else {
+               if (aEProc[0].ulDspVa > ulShmBase) {
+                       status = DSP_EFAIL;
+                       goto func_end;
                }
-               /* Set the SHM physical address entry (grayed out in CDB file)
-                * to the virtual uncached ioremapped address of SHM reserved
-                * on MPU */
-               hIOMgr->extProcInfo.tyTlb[0].ulGppPhys = (ulGppVa + ulSeg1Size +
-                                                        ulPadSize);
-               DBG_Trace(DBG_LEVEL1, "*********extProcInfo *********%x \n",
-                         hIOMgr->extProcInfo.tyTlb[0].ulGppPhys);
-               /* Need SHM Phys addr. IO supports only one DSP for now:
-                * uNumProcs=1 */
-               if ((hIOMgr->extProcInfo.tyTlb[0].ulGppPhys == 0) ||
-                  (uNumProcs != 1)) {
-                       status = CHNL_E_NOMEMMAP;
+               /* ulShmBase may not be at ulDspVa address */
+               ulShmBaseOffset = (ulShmBase - aEProc[0].ulDspVa) *
+                               hIOMgr->uWordSize;
+               /*
+                * WMD_BRD_Ctrl() will set dev context dsp-mmu info. In
+                * _BRD_Start() the MMU will be re-programed with MMU
+                * DSPVa-GPPPa pair info while DSP is in a known
+                * (reset) state.
+                */
+
+               status = hIOMgr->pIntfFxns->pfnDevCntrl(hIOMgr->hWmdContext,
+                                               WMDIOCTL_SETMMUCONFIG, aEProc);
+               if (DSP_FAILED(status))
                        goto func_end;
-               } else {
-                       if (aEProc[0].ulDspVa > ulShmBase) {
-                               status = DSP_EFAIL;
-                               goto func_end;
-                       }
-                       /* ulShmBase may not be at ulDspVa address */
-                       ulShmBaseOffset = (ulShmBase - aEProc[0].ulDspVa) *
-                           hIOMgr->uWordSize;
-                        /* WMD_BRD_Ctrl() will set dev context dsp-mmu info. In
-                        *   _BRD_Start() the MMU will be re-programed with MMU
-                        *   DSPVa-GPPPa pair info while DSP is in a known
-                        *   (reset) state.  */
-                       if (!hIOMgr->pIntfFxns || !hIOMgr->hWmdContext) {
-                               status = DSP_EHANDLE;
-                               goto func_end;
-                       }
-                       status = hIOMgr->pIntfFxns->pfnDevCntrl(hIOMgr->
-                                hWmdContext, WMDIOCTL_SETMMUCONFIG, aEProc);
-                       ulShmBase = hIOMgr->extProcInfo.tyTlb[0].ulGppPhys;
-                       DBG_Trace(DBG_LEVEL1, "extProcInfo.tyTlb[0].ulGppPhys "
-                                "%x \n ", hIOMgr->extProcInfo.tyTlb[0].
-                                ulGppPhys);
-                       ulShmBase += ulShmBaseOffset;
-                       ulShmBase = (u32)MEM_LinearAddress((void *)ulShmBase,
+               ulShmBase = hIOMgr->extProcInfo.tyTlb[0].ulGppPhys;
+               DBG_Trace(DBG_LEVEL1, "extProcInfo.tyTlb[0].ulGppPhys %x \n ",
+                               hIOMgr->extProcInfo.tyTlb[0].ulGppPhys);
+               ulShmBase += ulShmBaseOffset;
+               ulShmBase = (u32)MEM_LinearAddress((void *)ulShmBase,
                                    ulMemLength);
-                       if (ulShmBase == 0) {
-                               status = DSP_EFAIL;
-                               goto func_end;
-                       }
-                       DBC_Assert(ulShmBase != 0);
-                       if (DSP_SUCCEEDED(status)) {
-                               /* Register SM */
-                               status = registerSHMSegs(hIOMgr, hCodMan,
-                                        aEProc[0].ulGppPa);
-                       }
+               if (ulShmBase == 0) {
+                       status = DSP_EPOINTER;
+                       goto func_end;
                }
+               /* Register SM */
+               status = registerSHMSegs(hIOMgr, hCodMan, aEProc[0].ulGppPa);
        }
-       if (DSP_SUCCEEDED(status)) {
-               hIOMgr->pSharedMem = (struct SHM *)ulShmBase;
-               hIOMgr->pInput = (u8 *)hIOMgr->pSharedMem +
-                                sizeof(struct SHM);
-               hIOMgr->pOutput = hIOMgr->pInput + (ulShmLength -
-                                 sizeof(struct SHM))/2;
-               hIOMgr->uSMBufSize = hIOMgr->pOutput - hIOMgr->pInput;
-               DBG_Trace(DBG_LEVEL3,
-                        "hIOMgr: pInput %p pOutput %p ulShmLength %x\n",
-                        hIOMgr->pInput, hIOMgr->pOutput, ulShmLength);
-               DBG_Trace(DBG_LEVEL3,
-                        "pSharedMem %p uSMBufSize %x sizeof(SHM) %x\n",
-                        hIOMgr->pSharedMem, hIOMgr->uSMBufSize,
-                        sizeof(struct SHM));
-                /*  Set up Shared memory addresses for messaging. */
-               hIOMgr->pMsgInputCtrl = (struct MSG *)((u8 *)
-                                       hIOMgr->pSharedMem +
-                                       ulShmLength);
-               hIOMgr->pMsgInput = (u8 *)hIOMgr->pMsgInputCtrl +
-                                   sizeof(struct MSG);
-               hIOMgr->pMsgOutputCtrl = (struct MSG *)((u8 *)hIOMgr->
-                                        pMsgInputCtrl + ulMsgLength / 2);
-               hIOMgr->pMsgOutput = (u8 *)hIOMgr->pMsgOutputCtrl +
-                                    sizeof(struct MSG);
-               hMsgMgr->uMaxMsgs = ((u8 *)hIOMgr->pMsgOutputCtrl -
-                                   hIOMgr->pMsgInput) /
-                                   sizeof(struct MSG_DSPMSG);
-               DBG_Trace(DBG_LEVEL7, "IO MGR SHM details : pSharedMem 0x%x, "
-                        "pInput 0x%x, pOutput 0x%x, pMsgInputCtrl 0x%x, "
-                        "pMsgInput 0x%x, pMsgOutputCtrl 0x%x, pMsgOutput "
-                        "0x%x \n", (u8 *)hIOMgr->pSharedMem,
-                        (u8 *)hIOMgr->pInput, (u8 *)hIOMgr->pOutput,
-                        (u8 *)hIOMgr->pMsgInputCtrl,
-                        (u8 *)hIOMgr->pMsgInput,
-                        (u8 *)hIOMgr->pMsgOutputCtrl,
-                        (u8 *)hIOMgr->pMsgOutput);
-               DBG_Trace(DBG_LEVEL7, "** (proc) MAX MSGS IN SHARED MEMORY: "
-                        "0x%x\n", hMsgMgr->uMaxMsgs);
-               memset((void *) hIOMgr->pSharedMem, 0, sizeof(struct SHM));
-       }
+
+       hIOMgr->pSharedMem = (struct SHM *)ulShmBase;
+       hIOMgr->pInput = (u8 *)hIOMgr->pSharedMem + sizeof(struct SHM);
+       hIOMgr->pOutput = hIOMgr->pInput + (ulShmLength -
+                                               sizeof(struct SHM)) / 2;
+       hIOMgr->uSMBufSize = hIOMgr->pOutput - hIOMgr->pInput;
+       DBG_Trace(DBG_LEVEL3, "hIOMgr: pInput %p pOutput %p ulShmLength %x\n",
+                                hIOMgr->pInput, hIOMgr->pOutput, ulShmLength);
+       DBG_Trace(DBG_LEVEL3, "pSharedMem %p uSMBufSize %x sizeof(SHM) %x\n",
+                hIOMgr->pSharedMem, hIOMgr->uSMBufSize, sizeof(struct SHM));
+        /*  Set up Shared memory addresses for messaging. */
+       hIOMgr->pMsgInputCtrl = (struct MSG *)((u8 *)hIOMgr->pSharedMem
+                                                       + ulShmLength);
+       hIOMgr->pMsgInput = (u8 *)hIOMgr->pMsgInputCtrl + sizeof(struct MSG);
+       hIOMgr->pMsgOutputCtrl = (struct MSG *)((u8 *)hIOMgr->pMsgInputCtrl
+                                                       + ulMsgLength / 2);
+       hIOMgr->pMsgOutput = (u8 *)hIOMgr->pMsgOutputCtrl + sizeof(struct MSG);
+       hMsgMgr->uMaxMsgs = ((u8 *)hIOMgr->pMsgOutputCtrl - hIOMgr->pMsgInput)
+                                               / sizeof(struct MSG_DSPMSG);
+       DBG_Trace(DBG_LEVEL7, "IO MGR SHM details : pSharedMem 0x%x, "
+               "pInput 0x%x, pOutput 0x%x, pMsgInputCtrl 0x%x, "
+               "pMsgInput 0x%x, pMsgOutputCtrl 0x%x, pMsgOutput "
+               "0x%x \n", (u8 *)hIOMgr->pSharedMem, (u8 *)hIOMgr->pInput,
+               (u8 *)hIOMgr->pOutput, (u8 *)hIOMgr->pMsgInputCtrl,
+               (u8 *)hIOMgr->pMsgInput, (u8 *)hIOMgr->pMsgOutputCtrl,
+               (u8 *)hIOMgr->pMsgOutput);
+       DBG_Trace(DBG_LEVEL7, "** (proc) MAX MSGS IN SHARED MEMORY: "
+                                       "0x%x\n", hMsgMgr->uMaxMsgs);
+       memset((void *) hIOMgr->pSharedMem, 0, sizeof(struct SHM));
+
 #ifndef DSP_TRACEBUF_DISABLED
-       if (DSP_SUCCEEDED(status)) {
-               /* Get the start address of trace buffer */
-               if (DSP_SUCCEEDED(status)) {
-                       status = COD_GetSymValue(hCodMan, SYS_PUTCBEG,
+       /* Get the start address of trace buffer */
+       status = COD_GetSymValue(hCodMan, SYS_PUTCBEG,
                                 &hIOMgr->ulTraceBufferBegin);
-                       if (DSP_FAILED(status))
-                               status = CHNL_E_NOMEMMAP;
-               }
-               hIOMgr->ulGPPReadPointer = hIOMgr->ulTraceBufferBegin =
-                       (ulGppVa + ulSeg1Size + ulPadSize) +
-                       (hIOMgr->ulTraceBufferBegin - ulDspVa);
-               /* Get the end address of trace buffer */
-               if (DSP_SUCCEEDED(status)) {
-                       status = COD_GetSymValue(hCodMan, SYS_PUTCEND,
-                                &hIOMgr->ulTraceBufferEnd);
-                       if (DSP_FAILED(status))
-                               status = CHNL_E_NOMEMMAP;
-               }
-               hIOMgr->ulTraceBufferEnd = (ulGppVa + ulSeg1Size + ulPadSize) +
-                                          (hIOMgr->ulTraceBufferEnd - ulDspVa);
-               /* Get the current address of DSP write pointer */
-               if (DSP_SUCCEEDED(status)) {
-                       status = COD_GetSymValue(hCodMan,
-                                BRIDGE_SYS_PUTC_current,
-                                &hIOMgr->ulTraceBufferCurrent);
-                       if (DSP_FAILED(status))
-                               status = CHNL_E_NOMEMMAP;
-               }
-               hIOMgr->ulTraceBufferCurrent = (ulGppVa + ulSeg1Size +
-                                               ulPadSize) + (hIOMgr->
-                                               ulTraceBufferCurrent - ulDspVa);
-               /* Calculate the size of trace buffer */
-               if (hIOMgr->pMsg)
-                       MEM_Free(hIOMgr->pMsg);
-               hIOMgr->pMsg = MEM_Alloc(((hIOMgr->ulTraceBufferEnd -
-                                       hIOMgr->ulTraceBufferBegin) *
-                                       hIOMgr->uWordSize) + 2, MEM_NONPAGED);
-               if (!hIOMgr->pMsg)
-                       status = DSP_EMEMORY;
+       if (DSP_FAILED(status)) {
+               status = CHNL_E_NOMEMMAP;
+               goto func_end;
+       }
+
+       hIOMgr->ulGPPReadPointer = hIOMgr->ulTraceBufferBegin =
+               (ulGppVa + ulSeg1Size + ulPadSize) +
+               (hIOMgr->ulTraceBufferBegin - ulDspVa);
+       /* Get the end address of trace buffer */
+
+       status = COD_GetSymValue(hCodMan, SYS_PUTCEND,
+                                               &hIOMgr->ulTraceBufferEnd);
+       if (DSP_FAILED(status)) {
+               status = CHNL_E_NOMEMMAP;
+               goto func_end;
+       }
+       hIOMgr->ulTraceBufferEnd = (ulGppVa + ulSeg1Size + ulPadSize) +
+                                  (hIOMgr->ulTraceBufferEnd - ulDspVa);
+       /* Get the current address of DSP write pointer */
+       status = COD_GetSymValue(hCodMan, BRIDGE_SYS_PUTC_current,
+                                        &hIOMgr->ulTraceBufferCurrent);
+       if (DSP_FAILED(status)) {
+               status = CHNL_E_NOMEMMAP;
+               goto func_end;
+       }
+       hIOMgr->ulTraceBufferCurrent = (ulGppVa + ulSeg1Size + ulPadSize) +
+                               (hIOMgr->ulTraceBufferCurrent - ulDspVa);
+       /* Calculate the size of trace buffer */
+       if (hIOMgr->pMsg)
+               MEM_Free(hIOMgr->pMsg);
+       hIOMgr->pMsg = MEM_Alloc(((hIOMgr->ulTraceBufferEnd -
+                               hIOMgr->ulTraceBufferBegin) *
+                               hIOMgr->uWordSize) + 2, MEM_NONPAGED);
+       if (!hIOMgr->pMsg)
+               status = DSP_EMEMORY;
+
+       DBG_Trace(DBG_LEVEL1, "** hIOMgr->pMsg: 0x%x\n", hIOMgr->pMsg);
+       hIOMgr->ulDspVa = ulDspVa;
+       hIOMgr->ulGppVa = (ulGppVa + ulSeg1Size + ulPadSize);

-               DBG_Trace(DBG_LEVEL1, "** hIOMgr->pMsg: 0x%x\n", hIOMgr->pMsg);
-               hIOMgr->ulDspVa = ulDspVa;
-               hIOMgr->ulGppVa = (ulGppVa + ulSeg1Size + ulPadSize);
-    }
 #endif
        IO_EnableInterrupt(hIOMgr->hWmdContext);
 func_end:
diff --git a/drivers/dsp/bridge/wmd/mmu_fault.c b/drivers/dsp/bridge/wmd/mmu_fault.c
index b184250..2477f2e 100644
--- a/drivers/dsp/bridge/wmd/mmu_fault.c
+++ b/drivers/dsp/bridge/wmd/mmu_fault.c
@@ -73,19 +73,15 @@ irqreturn_t  MMU_FaultIsr(int irq, IN void *pRefData)
 {
        struct DEH_MGR *pDehMgr = (struct DEH_MGR *)pRefData;
        struct WMD_DEV_CONTEXT *pDevContext;
-       DSP_STATUS status = DSP_SOK;

        DBG_Trace(DBG_LEVEL1, "Entering DEH_DspMmuIsr: 0x%x\n", pRefData);
-       DBC_Require(irq == INT_DSP_MMU_IRQ);
+       DBC_Require(irq == INT_DSP_MMU_IRQ);
        DBC_Require(MEM_IsValidHandle(pDehMgr, SIGNATURE));

        if (MEM_IsValidHandle(pDehMgr, SIGNATURE)) {

                pDevContext = (struct WMD_DEV_CONTEXT *)pDehMgr->hWmdContext;
-               if (DSP_FAILED(status))
-                       DBG_Trace(DBG_LEVEL7,
-                                "**Failed to get Host Resources "
-                                "in MMU ISR **\n");
+
                if (MMU_CheckIfFault(pDevContext)) {
                        printk(KERN_INFO "***** DSPMMU FAULT ***** IRQStatus "
                                "0x%x\n", dmmuEventMask);
@@ -115,7 +111,7 @@ irqreturn_t  MMU_FaultIsr(int irq, IN void *pRefData)
                                            HW_MMU_ALL_INTERRUPTS);
                }
        }
-       return IRQ_HANDLED;
+       return IRQ_HANDLED;
 }


@@ -129,14 +125,8 @@ static bool MMU_CheckIfFault(struct WMD_DEV_CONTEXT *pDevContext)


        bool retVal = false;
-       DSP_STATUS status = DSP_SOK;
-       HW_STATUS hwStatus;
-
-       if (DSP_FAILED(status))
-               DBG_Trace(DBG_LEVEL7, "**Failed to get Host Resources in "
-                        "MMU_CheckIfFault **\n");

-       hwStatus = HW_MMU_EventStatus(pDevContext->dwDSPMmuBase,
+       HW_MMU_EventStatus(pDevContext->dwDSPMmuBase,
                                        &dmmuEventMask);
        if (dmmuEventMask  ==  HW_MMU_TRANSLATION_FAULT) {
                HW_MMU_FaultAddrRead(pDevContext->dwDSPMmuBase, &faultAddr);
diff --git a/drivers/dsp/bridge/wmd/msg_sm.c b/drivers/dsp/bridge/wmd/msg_sm.c
index 8e0aa9d..edc891e 100644
--- a/drivers/dsp/bridge/wmd/msg_sm.c
+++ b/drivers/dsp/bridge/wmd/msg_sm.c
@@ -87,7 +87,7 @@ DSP_STATUS WMD_MSG_Create(OUT struct MSG_MGR **phMsgMgr,
                    pMsgMgr->msgFreeList == NULL ||
                    pMsgMgr->msgUsedList == NULL)
                        status = DSP_EMEMORY;
-               if (DSP_SUCCEEDED(status))
+               else
                        status = SYNC_InitializeDPCCS(&pMsgMgr->hSyncCS);

                 /*  Create an event to be used by WMD_MSG_Put() in waiting
@@ -414,6 +414,8 @@ DSP_STATUS WMD_MSG_Put(struct MSG_QUEUE *hMsgQueue,
                hSyncs[1] = hMsgQueue->hSyncDone;
                status = SYNC_WaitOnMultipleEvents(hSyncs, 2, uTimeout,
                         &uIndex);
+               if (DSP_FAILED(status))
+                       goto func_end;
                /* Enter critical section */
                (void)SYNC_EnterCS(hMsgMgr->hSyncCS);
                if (hMsgQueue->fDone) {
@@ -425,29 +427,28 @@ DSP_STATUS WMD_MSG_Put(struct MSG_QUEUE *hMsgQueue,
                        (void)SYNC_SetEvent(hMsgQueue->hSyncDoneAck);
                        status = DSP_EFAIL;
                } else {
-                       if (DSP_SUCCEEDED(status)) {
-                               if (LST_IsEmpty(hMsgMgr->msgFreeList)) {
-                                       status = DSP_EPOINTER;
-                                       goto func_cont;
-                               }
-                               /* Get msg from free list */
-                               pMsgFrame = (struct MSG_FRAME *)
+                       if (LST_IsEmpty(hMsgMgr->msgFreeList)) {
+                               status = DSP_EPOINTER;
+                               goto func_cont;
+                       }
+                       /* Get msg from free list */
+                       pMsgFrame = (struct MSG_FRAME *)
                                            LST_GetHead(hMsgMgr->msgFreeList);
-                               /* Copy message into pMsg and put frame on the
-                                * used list */
-                               if (pMsgFrame != NULL) {
-                                       pMsgFrame->msgData.msg = *pMsg;
-                                       pMsgFrame->msgData.dwId =
-                                               hMsgQueue->dwId;
-                                       LST_PutTail(hMsgMgr->msgUsedList,
-                                                  (struct LST_ELEM *)
-                                                  pMsgFrame);
-                                       hMsgMgr->uMsgsPending++;
-                                       /* Schedule a DPC, to do the actual
-                                        * data transfer: */
-                                       IO_Schedule(hMsgMgr->hIOMgr);
-                               }
+                       /*
+                        * Copy message into pMsg and put frame on the
+                        * used list
+                        */
+                       if (pMsgFrame) {
+                               pMsgFrame->msgData.msg = *pMsg;
+                               pMsgFrame->msgData.dwId = hMsgQueue->dwId;
+                               LST_PutTail(hMsgMgr->msgUsedList,
+                                          (struct LST_ELEM *)pMsgFrame);
+                               hMsgMgr->uMsgsPending++;
+                               /* Schedule a DPC, to do the actual
+                                * data transfer: */
+                               IO_Schedule(hMsgMgr->hIOMgr);
                        }
+
                        hMsgQueue->refCount--;
                        /* Reset event if there are still frames available */
                        if (!LST_IsEmpty(hMsgMgr->msgFreeList))
diff --git a/drivers/dsp/bridge/wmd/tiomap3430.c b/drivers/dsp/bridge/wmd/tiomap3430.c
index cfa8868..6c57427 100644
--- a/drivers/dsp/bridge/wmd/tiomap3430.c
+++ b/drivers/dsp/bridge/wmd/tiomap3430.c
@@ -586,13 +586,11 @@ static DSP_STATUS WMD_BRD_Start(struct WMD_DEV_CONTEXT *hDevContext,
                                }
                        }

-                       if (clkIdIndex < MBX_PM_MAX_RESOURCES)
+                       if (clkIdIndex < MBX_PM_MAX_RESOURCES) {
                                status =
                                    CLK_Set_32KHz(BPWR_Clks[clkIdIndex].funClk);
-                       else
+                       } else {
                                status = DSP_EFAIL;
-
-                       if (DSP_FAILED(status)) {
                                DBG_Trace(DBG_LEVEL7, " Error while setting"
                                                        "LM Timer  to 32KHz\n");
                        }
@@ -628,13 +626,11 @@ static DSP_STATUS WMD_BRD_Start(struct WMD_DEV_CONTEXT *hDevContext,
                                }
                        }

-                       if (clkIdIndex < MBX_PM_MAX_RESOURCES)
+                       if (clkIdIndex < MBX_PM_MAX_RESOURCES) {
                                status = CLK_Set_32KHz(
                                                BPWR_Clks[clkIdIndex].funClk);
-                       else
+                       } else {
                                status = DSP_EFAIL;
-
-                       if (DSP_FAILED(status)) {
                                DBG_Trace(DBG_LEVEL7,
                                " Error while setting BIOS Timer  to 32KHz\n");
                        }
@@ -703,9 +699,7 @@ static DSP_STATUS WMD_BRD_Start(struct WMD_DEV_CONTEXT *hDevContext,
                /* Enable Mailbox events and also drain any pending
                 * stale messages */
                (void)CHNLSM_EnableInterrupt(pDevContext);
-       }

-       if (DSP_SUCCEEDED(status)) {
                HW_RSTCTRL_RegGet(pDevContext->prmbase, HW_RST1_IVA2, &temp);
                DBG_Trace(DBG_LEVEL7, "BRD_Start: RM_RSTCTRL_DSP = 0x%x \n",
                                temp);
@@ -742,10 +736,8 @@ static DSP_STATUS WMD_BRD_Start(struct WMD_DEV_CONTEXT *hDevContext,
                                dwDSPAddr);
                if (dsp_debug)
                        while (*((volatile u16 *)dwSyncAddr))
-                               ;;
-       }
+                               ;

-       if (DSP_SUCCEEDED(status)) {
                /* Wait for DSP to clear word in shared memory */
                /* Read the Location */
                if (!WaitForStart(pDevContext, dwSyncAddr)) {
@@ -762,8 +754,7 @@ static DSP_STATUS WMD_BRD_Start(struct WMD_DEV_CONTEXT *hDevContext,
                         * completion of OPP table update to DSP
                         */
                        *((volatile u32 *)dwSyncAddr) = 0XCAFECAFE;
-               }
-               if (DSP_SUCCEEDED(status)) {
+
                        /* update board state */
                        pDevContext->dwBrdState = BRD_RUNNING;
                        /* (void)CHNLSM_EnableInterrupt(pDevContext);*/
@@ -2059,9 +2050,7 @@ void configureDspMmu(struct WMD_DEV_CONTEXT *pDevContext, u32 dataBasePhys,
                    enum HW_ElementSize_t elemSize,
                    enum HW_MMUMixedSize_t mixedSize)
 {
-       struct CFG_HOSTRES resources;
        struct HW_MMUMapAttrs_t mapAttrs = { endianism, elemSize, mixedSize };
-       DSP_STATUS status = DSP_SOK;

        DBC_Require(sizeInBytes > 0);
        DBG_Trace(DBG_LEVEL1,
@@ -2070,9 +2059,8 @@ void configureDspMmu(struct WMD_DEV_CONTEXT *pDevContext, u32 dataBasePhys,

        DBG_Trace(DBG_LEVEL1, "endianism %x, elemSize %x, mixedSize %x\n",
                 endianism, elemSize, mixedSize);
-       status = CFG_GetHostResources(
-                (struct CFG_DEVNODE *)DRV_GetFirstDevExtension(), &resources);
-       status = HW_MMU_TLBAdd(pDevContext->dwDSPMmuBase, dataBasePhys,
+
+       HW_MMU_TLBAdd(pDevContext->dwDSPMmuBase, dataBasePhys,
                                dspBaseVirt, sizeInBytes, nEntryStart,
                                &mapAttrs, HW_SET, HW_SET);
 }
diff --git a/drivers/dsp/bridge/wmd/tiomap3430_pwr.c b/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
index f5eb21c..11bc84b 100644
--- a/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
+++ b/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
@@ -136,7 +136,7 @@ DSP_STATUS handle_hibernation_fromDSP(struct WMD_DEV_CONTEXT *pDevContext)
                status = WMD_E_TIMEOUT;
        } else {
                /* Save mailbox settings */
-               status = HW_MBOX_saveSettings(pDevContext->dwMailBoxBase);
+               HW_MBOX_saveSettings(pDevContext->dwMailBoxBase);
                DBG_Trace(DBG_LEVEL6, "MailBoxSettings: SYSCONFIG = 0x%x\n",
                         mboxsetting.sysconfig);
                DBG_Trace(DBG_LEVEL6, "MailBoxSettings: IRQENABLE0 = 0x%x\n",
@@ -489,13 +489,15 @@ DSP_STATUS PreScale_DSP(struct WMD_DEV_CONTEXT *pDevContext, IN void *pArgs)
  */
 DSP_STATUS PostScale_DSP(struct WMD_DEV_CONTEXT *pDevContext, IN void *pArgs)
 {
+       DSP_STATUS status = DSP_SOK;
 #ifdef CONFIG_BRIDGE_DVFS
        u32 level;
        u32 voltage_domain;
        struct IO_MGR *hIOMgr;
-       DSP_STATUS status = DSP_SOK;

        status = DEV_GetIOMgr(pDevContext->hDevObject, &hIOMgr);
+       if (!hIOMgr)
+               return DSP_EHANDLE;

        voltage_domain = *((u32 *)pArgs);
        level = *((u32 *)pArgs + 1);
@@ -511,7 +513,6 @@ DSP_STATUS PostScale_DSP(struct WMD_DEV_CONTEXT *pDevContext, IN void *pArgs)
                DBG_Trace(DBG_LEVEL7,
                         "PostScale_DSP: IVA in sleep. Wrote to shared "
                         "memory \n");
-               return DSP_SOK;
        } else  if ((pDevContext->dwBrdState == BRD_RUNNING)) {
                /* Update the OPP value in shared memory */
                IO_SHMsetting(hIOMgr, SHM_CURROPP, &level);
@@ -520,14 +521,13 @@ DSP_STATUS PostScale_DSP(struct WMD_DEV_CONTEXT *pDevContext, IN void *pArgs)
                DBG_Trace(DBG_LEVEL7,
                        "PostScale_DSP: Wrote to shared memory Sent post"
                        " notification to DSP\n");
-               return DSP_SOK;
        } else {
                DBG_Trace(DBG_LEVEL7, "PostScale_DSP: Failed - DSP BRD state "
                        "in wrong state");
-               return DSP_EFAIL;
+               status = DSP_EFAIL;
        }
 #endif /* #ifdef CONFIG_BRIDGE_DVFS */
-       return DSP_SOK;
+       return status;
 }

 /*
diff --git a/drivers/dsp/bridge/wmd/tiomap_io.c b/drivers/dsp/bridge/wmd/tiomap_io.c
index 33cf876..f60b8db 100644
--- a/drivers/dsp/bridge/wmd/tiomap_io.c
+++ b/drivers/dsp/bridge/wmd/tiomap_io.c
@@ -78,7 +78,7 @@ DSP_STATUS ReadExtDspData(struct WMD_DEV_CONTEXT *hDevContext,
        DBC_Assert(ulShmBaseVirt != 0);

        /* Check if it is a read of Trace section */
-       if (!ulTraceSecBeg) {
+       if (DSP_SUCCEEDED(status) && !ulTraceSecBeg) {
                status = DEV_GetSymbol(pDevContext->hDevObject,
                DSP_TRACESEC_BEG, &ulTraceSecBeg);
        }
@@ -100,7 +100,7 @@ DSP_STATUS ReadExtDspData(struct WMD_DEV_CONTEXT *hDevContext,
        }

        /* If reading from TRACE, force remap/unmap */
-       if ((bTraceRead) && dwBaseAddr) {
+       if (bTraceRead && dwBaseAddr) {
                dwBaseAddr = 0;
                pDevContext->dwDspExtBaseAddr = 0;
        }
@@ -212,6 +212,9 @@ DSP_STATUS WriteDspData(struct WMD_DEV_CONTEXT *hDevContext, IN u8 *pbHostBuf,
        status =  CFG_GetHostResources(
                 (struct CFG_DEVNODE *)DRV_GetFirstDevExtension(), &resources);

+       if (DSP_FAILED(status))
+               return status;
+
        offset = dwDSPAddr - hDevContext->dwDSPStartAdd;
        if (offset < base1) {
                dwBaseAddr = MEM_LinearAddress(resources.dwMemBase[2],
@@ -226,8 +229,7 @@ DSP_STATUS WriteDspData(struct WMD_DEV_CONTEXT *hDevContext, IN u8 *pbHostBuf,
                                                resources.dwMemLength[4]);
                offset = offset - base3;
        } else{
-               status = DSP_EFAIL;
-               return status;
+               return DSP_EFAIL;
        }
        if (ulNumBytes)
                memcpy((u8 *) (dwBaseAddr+offset), pbHostBuf, ulNumBytes);
diff --git a/drivers/dsp/bridge/wmd/tiomap_sm.c b/drivers/dsp/bridge/wmd/tiomap_sm.c
index b74ce68..d86dcc1 100644
--- a/drivers/dsp/bridge/wmd/tiomap_sm.c
+++ b/drivers/dsp/bridge/wmd/tiomap_sm.c
@@ -39,14 +39,12 @@ DSP_STATUS CHNLSM_EnableInterrupt(struct WMD_DEV_CONTEXT *pDevContext)
        u32 numMbxMsg;
        u32 mbxValue;
        u32 devType;
-       struct IO_MGR *hIOMgr;

        DBG_Trace(DBG_ENTER, "CHNLSM_EnableInterrupt(0x%x)\n", pDevContext);

        /* Read the messages in the mailbox until the message queue is empty */

        DEV_GetDevType(pDevContext->hDevObject, &devType);
-       status = DEV_GetIOMgr(pDevContext->hDevObject, &hIOMgr);
        if (devType == DSP_UNIT) {
                HW_MBOX_NumMsgGet(pDevContext->dwMailBoxBase,
                                  MBOX_DSP2ARM, &numMbxMsg);
diff --git a/drivers/dsp/bridge/wmd/ue_deh.c b/drivers/dsp/bridge/wmd/ue_deh.c
index 6a1314f..046a6c8 100644
--- a/drivers/dsp/bridge/wmd/ue_deh.c
+++ b/drivers/dsp/bridge/wmd/ue_deh.c
@@ -86,8 +86,7 @@ DSP_STATUS WMD_DEH_Create(OUT struct DEH_MGR **phDehMgr,
                status = DSP_EMEMORY;
        } else {
                /* Create an NTFY object to manage notifications */
-               if (DSP_SUCCEEDED(status))
-                       status = NTFY_Create(&pDehMgr->hNtfy);
+               status = NTFY_Create(&pDehMgr->hNtfy);

                /* Create a MMUfault DPC */
                tasklet_init(&pDehMgr->dpc_tasklet, MMU_FaultDpc, (u32)pDehMgr);
@@ -187,16 +186,10 @@ void WMD_DEH_Notify(struct DEH_MGR *hDehMgr, u32 ulEventMask,
 {
        struct DEH_MGR *pDehMgr = (struct DEH_MGR *)hDehMgr;
        struct WMD_DEV_CONTEXT *pDevContext;
-       DSP_STATUS status = DSP_SOK;
-       DSP_STATUS status1 = DSP_EFAIL;
        u32 memPhysical = 0;
        u32 HW_MMU_MAX_TLB_COUNT = 31;
        u32 extern faultAddr;
-       HW_STATUS hwStatus;

-       if (DSP_FAILED(status))
-               DBG_Trace(DBG_LEVEL7,
-                        "**Failed to get Host Resources in MMU ISR **\n");

        DBG_Trace(DBG_LEVEL1, "Entering WMD_DEH_Notify: 0x%x, 0x%x\n", pDehMgr,
                 ulEventMask);
@@ -250,13 +243,11 @@ DBG_Trace(DBG_LEVEL6, "WMD_DEH_Notify: DSP_MMUFAULT, "
                        DBG_Trace(DBG_LEVEL6, "Adding TLB Entry %d: VA: 0x%x, "
                                 "PA: 0x%x\n", pDevContext->
                                numTLBEntries, faultAddr, memPhysical);
-                       if (DSP_SUCCEEDED(status)) {
-                               hwStatus =
-                                       HW_MMU_TLBAdd(pDevContext->dwDSPMmuBase,
-                                               memPhysical, faultAddr,
-                                               HW_PAGE_SIZE_4KB, 1, &mapAttrs,
-                                               HW_SET, HW_SET);
-                       }
+
+                       HW_MMU_TLBAdd(pDevContext->dwDSPMmuBase,
+                               memPhysical, faultAddr, HW_PAGE_SIZE_4KB, 1,
+                               &mapAttrs, HW_SET, HW_SET);
+
                        /* send an interrupt to DSP */
                        HW_MBOX_MsgWrite(pDevContext->dwMailBoxBase,
                                        MBOX_ARM2DSP,
@@ -285,16 +276,8 @@ DBG_Trace(DBG_LEVEL6, "WMD_DEH_Notify: DSP_MMUFAULT, "
                }

                /* Filter subsequent notifications when an error occurs */
-               if (pDevContext->dwBrdState != BRD_ERROR) {
-                       /* Use it as a flag to send notifications the
-                        * first time and error occurred, next time
-                        * state will be BRD_ERROR */
-                       status1 = DSP_EFAIL;
-               }
-
-               /* Filter subsequent notifications when an error occurs */
                if (pDevContext->dwBrdState != BRD_ERROR)
-                       status1 = DSP_SOK;
+                       NTFY_Notify(pDehMgr->hNtfy, ulEventMask);

                /* Set the Board state as ERROR */
                pDevContext->dwBrdState = BRD_ERROR;
@@ -303,11 +286,6 @@ DBG_Trace(DBG_LEVEL6, "WMD_DEH_Notify: DSP_MMUFAULT, "
                /* Call DSP Trace Buffer */
                PrintDspTraceBuffer(hDehMgr->hWmdContext);

-               if (DSP_SUCCEEDED(status1)) {
-                       /* Signal DSP error/exception event. */
-                       NTFY_Notify(pDehMgr->hNtfy, ulEventMask);
-               }
-
        }
        DBG_Trace(DBG_LEVEL1, "Exiting WMD_DEH_Notify\n");

@@ -335,6 +313,8 @@ DSP_STATUS WMD_DEH_GetInfo(struct DEH_MGR *hDehMgr,
                pErrInfo->dwVal1 = pDehMgr->errInfo.dwVal1;
                pErrInfo->dwVal2 = pDehMgr->errInfo.dwVal2;
                pErrInfo->dwVal3 = pDehMgr->errInfo.dwVal3;
+       } else {
+               status = DSP_EHANDLE;
        }

        DBG_Trace(DBG_LEVEL1, "Exiting WMD_DEH_GetInfo\n");
--
1.6.0.4


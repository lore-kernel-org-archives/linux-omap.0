From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/3][OMAP 3/4] likely/unlikely for status checking
Date: Tue, 2 Sep 2008 15:44:18 -0700
Message-ID: <20080902224418.GJ23085@atomide.com>
References: <27F9C60D11D683428E133F85D2BB4A534486D6A3@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:52022 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751439AbYIBWoW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Sep 2008 18:44:22 -0400
Content-Disposition: inline
In-Reply-To: <27F9C60D11D683428E133F85D2BB4A534486D6A3@dlee03.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Ramirez Luna, Omar" <x00omar@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

* Ramirez Luna, Omar <x00omar@ti.com> [080828 18:28]:
> This patch was made by Hiroshi Doyu, I don't deserve any kind of credit for this.

You can keep the original author by adding a second From: field to the
top of the message like this:

From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

That way git-am will credit it the right way.

Tony


> For better performance, using likely/unlikely for branch prediction optimizations
> 
> Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
> ---
> 
> Index: omapkernel/drivers/dsp/bridge/pmgr/chnl.c
> ===================================================================
> --- omapkernel.orig/drivers/dsp/bridge/pmgr/chnl.c      2008-08-22 19:03:10.000000000 -0500
> +++ omapkernel/drivers/dsp/bridge/pmgr/chnl.c   2008-08-22 19:19:19.000000000 -0500
> @@ -166,16 +166,16 @@
>         }
>         if (DSP_SUCCEEDED(GetNumOpenChannels(hChnlMgr, &cOpenChannels)) &&
>                          (cOpenChannels > 0)) {
> -               if (!DSP_SUCCEEDED(GetNumChannels(hChnlMgr, &cTotalChnls)))
> +               if (DSP_FAILED(GetNumChannels(hChnlMgr, &cTotalChnls)))
>                         goto func_end;
> 
>                 /* For each channel (except for RMS), get process handle: */
>                 for (uChnlID = 2; uChnlID < cTotalChnls; uChnlID++) {
> -                       if (!DSP_SUCCEEDED(CHNL_GetHandle(hChnlMgr, uChnlID,
> +                       if (DSP_FAILED(CHNL_GetHandle(hChnlMgr, uChnlID,
>                             &hChnl))) {
>                                 continue;
>                         }
> -                       if (!DSP_SUCCEEDED(CHNL_GetProcessHandle(hChnl,
> +                       if (DSP_FAILED(CHNL_GetProcessHandle(hChnl,
>                             &hProc))) {
>                                 continue;
>                         }
> Index: omapkernel/drivers/dsp/bridge/pmgr/dbll.c
> ===================================================================
> --- omapkernel.orig/drivers/dsp/bridge/pmgr/dbll.c      2008-08-22 19:18:30.000000000 -0500
> +++ omapkernel/drivers/dsp/bridge/pmgr/dbll.c   2008-08-22 19:19:19.000000000 -0500
> @@ -708,7 +708,7 @@
>         /*
>          *  Set up objects needed by the dynamic loader
>          */
> -       if (!DSP_SUCCEEDED(status))
> +       if (DSP_FAILED(status))
>                 goto func_cont;
> 
>         /* Stream */
> @@ -836,7 +836,7 @@
>                 }
>         }
> 
> -       if (!DSP_SUCCEEDED(status))
> +       if (DSP_FAILED(status))
>                 goto func_cont;
> 
>         uByteSize = 1;
> Index: omapkernel/drivers/dsp/bridge/pmgr/dev.c
> ===================================================================
> --- omapkernel.orig/drivers/dsp/bridge/pmgr/dev.c       2008-08-22 19:18:30.000000000 -0500
> +++ omapkernel/drivers/dsp/bridge/pmgr/dev.c    2008-08-22 19:19:19.000000000 -0500
> @@ -343,7 +343,7 @@
>                 /* Create CMM mgr even if Msg Mgr not impl.  */
>                 status = CMM_Create(&pDevObject->hCmmMgr,
>                                    (struct DEV_OBJECT *)pDevObject, NULL);
> -               if (!DSP_SUCCEEDED(status)) {
> +               if (DSP_FAILED(status)) {
>                         GT_0trace(debugMask, GT_7CLASS,
>                                   "DEV_Create: Failed to Create SM "
>                                   "Manager\n");
> @@ -362,7 +362,7 @@
>                 /* Create DMM mgr .  */
>                 status = DMM_Create(&pDevObject->hDmmMgr,
>                                    (struct DEV_OBJECT *)pDevObject, NULL);
> -               if (!DSP_SUCCEEDED(status)) {
> +               if (DSP_FAILED(status)) {
>                         GT_0trace(debugMask, GT_7CLASS,
>                                   "DEV_Create: Failed to Create DMM "
>                                   "Manager\n");
> @@ -432,7 +432,7 @@
>         /* There can be only one Node Manager per DEV object */
>         DBC_Assert(!pDevObject->hNodeMgr);
>         status = NODE_CreateMgr(&pDevObject->hNodeMgr, hDevObject);
> -       if (!DSP_SUCCEEDED(status)) {
> +       if (DSP_FAILED(status)) {
>                 GT_1trace(debugMask, GT_7CLASS,
>                          "DEV_Create2: NODE_CreateMgr failed, "
>                          "0x%x!\n", status);
> Index: omapkernel/drivers/dsp/bridge/pmgr/wcd.c
> ===================================================================
> --- omapkernel.orig/drivers/dsp/bridge/pmgr/wcd.c       2008-08-22 19:18:30.000000000 -0500
> +++ omapkernel/drivers/dsp/bridge/pmgr/wcd.c    2008-08-22 19:19:58.000000000 -0500
> @@ -149,8 +149,8 @@
> 
>  #define cp_fm_usr(dest, src, status, elements)    \
>      if (DSP_SUCCEEDED(status)) {\
> -       if ((src == NULL) || \
> -          copy_from_user(dest, src, elements * sizeof(*(dest)))) {\
> +           if (unlikely(src == NULL) ||                                \
> +               unlikely(copy_from_user(dest, src, elements * sizeof(*(dest))))) { \
>                 GT_1trace(WCD_debugMask, GT_7CLASS, \
>                 "copy_from_user failed, src=0x%x\n", src);  \
>                 status = DSP_EPOINTER ; \
> @@ -159,8 +159,8 @@
> 
>  #define cp_to_usr(dest, src, status, elements)    \
>      if (DSP_SUCCEEDED(status)) {\
> -       if ((dest == NULL) || \
> -          copy_to_user(dest, src, elements * sizeof(*(src)))) { \
> +           if (unlikely(dest == NULL) ||                               \
> +               unlikely(copy_to_user(dest, src, elements * sizeof(*(src))))) { \
>                 GT_1trace(WCD_debugMask, GT_7CLASS, \
>                 "copy_to_user failed, dest=0x%x\n", dest); \
>                 status = DSP_EPOINTER ;\
> @@ -416,10 +416,10 @@
>          *  requires KFILE.  */
>         for (hDevObject = DEV_GetFirst(); hDevObject != NULL;
>              hDevObject = DEV_GetNext(hDevObject)) {
> -               if (!DSP_SUCCEEDED(DEV_GetDevNode(hDevObject, &DevNode)))
> +               if (DSP_FAILED(DEV_GetDevNode(hDevObject, &DevNode)))
>                         continue;
> 
> -               if (!DSP_SUCCEEDED(DEV_GetDevType(hDevObject, &devType)))
> +               if (DSP_FAILED(DEV_GetDevType(hDevObject, &devType)))
>                         continue;
> 
>                 if ((devType == DSP_UNIT) || (devType == IVA_UNIT)) {
> Index: omapkernel/drivers/dsp/bridge/rmgr/dbdcd.c
> ===================================================================
> --- omapkernel.orig/drivers/dsp/bridge/rmgr/dbdcd.c     2008-08-22 19:03:10.000000000 -0500
> +++ omapkernel/drivers/dsp/bridge/rmgr/dbdcd.c  2008-08-22 19:19:19.000000000 -0500
> @@ -540,7 +540,7 @@
>                 status = REG_GetValue(NULL, szRegKey, szRegKey, (u8 *)szRegData,
>                                      &dwBufSize);
>         }
> -       if (!DSP_SUCCEEDED(status)) {
> +       if (DSP_FAILED(status)) {
>                 status = DSP_EUUID;
>                 GT_0trace(curTrace, GT_6CLASS, "DCD_GetObjectDef: "
>                          "REG_GetValue() failed\n");
> @@ -548,7 +548,7 @@
>         }
>         /* Open COFF file. */
>         status = COD_Open(pDcdMgr->hCodMgr, szRegData, COD_NOLOAD, &lib);
> -       if (!DSP_SUCCEEDED(status)) {
> +       if (DSP_FAILED(status)) {
>                 status = DSP_EDCDLOADBASE;
>                 GT_0trace(curTrace, GT_6CLASS, "DCD_GetObjectDef: "
>                          "COD_OpenBase() failed\n");
> @@ -563,7 +563,7 @@
>         CSL_Strncat(szSectName, szUuid, CSL_Strlen(szUuid));
>         /* Get section information. */
>         status = COD_GetSection(lib, szSectName, &ulAddr, &ulLen);
> -       if (!DSP_SUCCEEDED(status)) {
> +       if (DSP_FAILED(status)) {
>                 status = DSP_EDCDGETSECT;
>                 GT_0trace(curTrace, GT_6CLASS, "DCD_GetObjectDef:"
>                          " COD_GetSection() failed\n");
> @@ -651,7 +651,7 @@
>         }
>         /* Open DSP coff file, don't load symbols. */
>         status = COD_Open(pDcdMgr->hCodMgr, pszCoffPath, COD_NOLOAD, &lib);
> -       if (!DSP_SUCCEEDED(status)) {
> +       if (DSP_FAILED(status)) {
>                 status = DSP_EDCDLOADBASE;
>                 GT_0trace(curTrace, GT_6CLASS,
>                          "DCD_AutoRegister: COD_Open() failed\n");
> @@ -659,7 +659,7 @@
>         }
>         /* Get DCD_RESIGER_SECTION section information. */
>         status = COD_GetSection(lib, DCD_REGISTER_SECTION, &ulAddr, &ulLen);
> -       if (!DSP_SUCCEEDED(status) ||  !(ulLen > 0)) {
> +       if (DSP_FAILED(status) ||  !(ulLen > 0)) {
>                 status = DSP_EDCDNOAUTOREGISTER;
>                 GT_0trace(curTrace, GT_6CLASS,
>                          "DCD_GetObjects: COD_GetSection() "
> @@ -1534,7 +1534,7 @@
>                 }
>         }
> 
> -       if (!DSP_SUCCEEDED(status) || !(ulLen > 0))
> +       if (DSP_FAILED(status) || !(ulLen > 0))
>                 goto func_cont;
> 
>         /* Allocate zeroed buffer. */
> @@ -1550,7 +1550,7 @@
>  #endif
>         /* Read section contents. */
>         status = COD_ReadSection(lib, DEPLIBSECT, pszCoffBuf, ulLen);
> -       if (!DSP_SUCCEEDED(status))
> +       if (DSP_FAILED(status))
>                 goto func_cont;
> 
>         /* Compress and format DSP buffer to conform to PC format. */
> Index: omapkernel/drivers/dsp/bridge/rmgr/disp.c
> ===================================================================
> --- omapkernel.orig/drivers/dsp/bridge/rmgr/disp.c      2008-08-22 19:03:10.000000000 -0500
> +++ omapkernel/drivers/dsp/bridge/rmgr/disp.c   2008-08-22 19:19:19.000000000 -0500
> @@ -175,13 +175,13 @@
> 
>         /* check device type and decide if streams or messag'ing is used for
>          * RMS/EDS */
> -       if (!DSP_SUCCEEDED(status))
> +       if (DSP_FAILED(status))
>                 goto func_cont;
> 
>         status = DEV_GetDevType(hDevObject, &devType);
>         GT_1trace(DISP_DebugMask, GT_6CLASS, "DISP_Create: Creating DISP for "
>                  "device = 0x%x\n", devType);
> -       if (!DSP_SUCCEEDED(status))
> +       if (DSP_FAILED(status))
>                 goto func_cont;
> 
>         if (devType != DSP_UNIT) {
> @@ -387,7 +387,7 @@
>         GT_1trace(DISP_DebugMask, GT_6CLASS, "DISP_Create: Creating DISP "
>                  "for device = 0x%x\n", devType);
> 
> -       if (!DSP_SUCCEEDED(status))
> +       if (DSP_FAILED(status))
>                 goto func_end;
> 
>         if (devType != DSP_UNIT) {
> @@ -480,7 +480,7 @@
>                 memcpy(pdwBuf + total, msgArgs.pData, msgArgs.uArgLength);
>                 total += dwLength;
>         }
> -       if (!DSP_SUCCEEDED(status))
> +       if (DSP_FAILED(status))
>                 goto func_end;
> 
>         /* If node is a task node, copy task create arguments into  buffer */
> @@ -845,7 +845,7 @@
>         status = (*pIntfFxns->pfnChnlAddIOReq) (hChnl, pBuf, ulBytes, 0,
>                  0L, dwArg);
> 
> -       if (!DSP_SUCCEEDED(status)) {
> +       if (DSP_FAILED(status)) {
>                 GT_1trace(DISP_DebugMask, GT_6CLASS,
>                          "SendMessage: Channel AddIOReq to"
>                          " RMS failed! Status = 0x%x\n", status);
> @@ -871,14 +871,14 @@
>         }
>  func_cont:
>         /* Get the reply */
> -       if (!DSP_SUCCEEDED(status))
> +       if (DSP_FAILED(status))
>                 goto func_end;
> 
>         hChnl = hDisp->hChnlFromDsp;
>         ulBytes = REPLYSIZE;
>         status = (*pIntfFxns->pfnChnlAddIOReq)(hChnl, pBuf, ulBytes,
>                  0, 0L, dwArg);
> -       if (!DSP_SUCCEEDED(status)) {
> +       if (DSP_FAILED(status)) {
>                 GT_1trace(DISP_DebugMask, GT_6CLASS,
>                          "SendMessage: Channel AddIOReq "
>                          "from RMS failed! Status = 0x%x\n", status);
> Index: omapkernel/drivers/dsp/bridge/rmgr/drv.c
> ===================================================================
> --- omapkernel.orig/drivers/dsp/bridge/rmgr/drv.c       2008-08-22 19:18:30.000000000 -0500
> +++ omapkernel/drivers/dsp/bridge/rmgr/drv.c    2008-08-22 19:19:19.000000000 -0500
> @@ -788,7 +788,7 @@
>                         MEM_Free(apBuffer);
>                 }
>                 status = STRM_Close(pSTRMRes->hStream);
> -               if (!DSP_SUCCEEDED(status)) {
> +               if (DSP_FAILED(status)) {
>                         if (status == DSP_EPENDING) {
>                                 status = STRM_Reclaim(pSTRMRes->hStream,
>                                                      &pBufPtr, &ulBytes,
> Index: omapkernel/drivers/dsp/bridge/rmgr/drv_interface.c
> ===================================================================
> --- omapkernel.orig/drivers/dsp/bridge/rmgr/drv_interface.c     2008-08-22 19:18:30.000000000 -0500
> +++ omapkernel/drivers/dsp/bridge/rmgr/drv_interface.c  2008-08-22 19:19:19.000000000 -0500
> @@ -571,7 +571,7 @@
> 
>         /* Checking weather task structure for all process existing
>          * in the process context list If not removing those processes*/
> -       if (!DSP_SUCCEEDED(dsp_status))
> +       if (DSP_FAILED(dsp_status))
>                 goto func_cont;
> 
>         DRV_GetProcCtxtList(&pCtxtclosed, (struct DRV_OBJECT *)hDrvObject);
> Index: omapkernel/drivers/dsp/bridge/rmgr/dspdrv.c
> ===================================================================
> --- omapkernel.orig/drivers/dsp/bridge/rmgr/dspdrv.c    2008-08-22 19:03:56.000000000 -0500
> +++ omapkernel/drivers/dsp/bridge/rmgr/dspdrv.c 2008-08-22 19:19:19.000000000 -0500
> @@ -143,11 +143,11 @@
> 
>         GT_0trace(curTrace, GT_ENTER, "Entering DSP_Init \r\n");
> 
> -       if (!DSP_SUCCEEDED(WCD_Init())) {
> +       if (DSP_FAILED(WCD_Init())) {
>                 GT_0trace(curTrace, GT_7CLASS, "DSP_Init Failed \n");
>                 goto func_cont;
>         }                       /* End WCD_Exit */
> -       if (!DSP_SUCCEEDED(DRV_Create(&drvObject))) {
> +       if (DSP_FAILED(DRV_Create(&drvObject))) {
>                 GT_0trace(curTrace, GT_7CLASS, "DSP_Init:DRV_Create Failed \n");
>                 WCD_Exit();
>                 goto func_cont;
> Index: omapkernel/drivers/dsp/bridge/rmgr/mgr.c
> ===================================================================
> --- omapkernel.orig/drivers/dsp/bridge/rmgr/mgr.c       2008-08-22 19:03:10.000000000 -0500
> +++ omapkernel/drivers/dsp/bridge/rmgr/mgr.c    2008-08-22 19:19:19.000000000 -0500
> @@ -192,7 +192,7 @@
>                  uNDBPropsSize, puNumNodes);
>         *puNumNodes = 0;
>         /* Get The Manager Object from the Registry */
> -       if (!DSP_SUCCEEDED(CFG_GetObject((u32 *)&pMgrObject,
> +       if (DSP_FAILED(CFG_GetObject((u32 *)&pMgrObject,
>            REG_MGR_OBJECT))) {
>                 GT_0trace(MGR_DebugMask, GT_7CLASS,
>                          "Manager_EnumNodeInfo:Failed To Get"
> @@ -309,11 +309,11 @@
>                         }
>                 }
>         }
> -       if (!DSP_SUCCEEDED(status))
> +       if (DSP_FAILED(status))
>                 goto func_end;
> 
>         /* Get The Manager Object from the Registry */
> -       if (!DSP_SUCCEEDED(CFG_GetObject((u32 *)&pMgrObject,
> +       if (DSP_FAILED(CFG_GetObject((u32 *)&pMgrObject,
>            REG_MGR_OBJECT))) {
>                 GT_0trace(MGR_DebugMask, GT_7CLASS,
>                          "Manager_EnumProcessorInfo: "
> Index: omapkernel/drivers/dsp/bridge/rmgr/nldr.c
> ===================================================================
> --- omapkernel.orig/drivers/dsp/bridge/rmgr/nldr.c      2008-08-22 19:03:56.000000000 -0500
> +++ omapkernel/drivers/dsp/bridge/rmgr/nldr.c   2008-08-22 19:19:19.000000000 -0500
> @@ -1110,7 +1110,7 @@
>                 goto func_end;
> 
>         status = DCD_GetObjectDef(hNldr->hDcdMgr, pUuid, objType, &objDef);
> -       if (!DSP_SUCCEEDED(status))
> +       if (DSP_FAILED(status))
>                 goto func_end;
> 
>         /* If overlay node, add to the list */
> @@ -1583,7 +1583,7 @@
>         }
> 
>         DBC_Assert(pRefCount != NULL);
> -       if (!DSP_SUCCEEDED(status))
> +       if (DSP_FAILED(status))
>                 goto func_end;
> 
>         if (pRefCount == NULL)
> Index: omapkernel/drivers/dsp/bridge/rmgr/node.c
> ===================================================================
> --- omapkernel.orig/drivers/dsp/bridge/rmgr/node.c      2008-08-22 19:18:30.000000000 -0500
> +++ omapkernel/drivers/dsp/bridge/rmgr/node.c   2008-08-22 19:19:19.000000000 -0500
> @@ -451,7 +451,7 @@
>         if (procId != DSP_UNIT)
>                 goto func_cont;
> 
> -       if (!DSP_SUCCEEDED(status))
> +       if (DSP_FAILED(status))
>                 goto func_cont;
> 
>         /* Assuming that 0 is not a valid function address */
> @@ -471,7 +471,7 @@
>         }
>  func_cont:
>         /* Allocate node object and fill in */
> -       if (!DSP_SUCCEEDED(status))
> +       if (DSP_FAILED(status))
>                 goto func_cont2;
> 
>         MEM_AllocObject(pNode, struct NODE_OBJECT, NODE_SIGNATURE);
> @@ -488,7 +488,7 @@
>         /* Get DSP_NDBPROPS from node database */
>         status = GetNodeProps(hNodeMgr->hDcdMgr, pNode, pNodeId,
>                              &(pNode->dcdProps));
> -       if (!DSP_SUCCEEDED(status))
> +       if (DSP_FAILED(status))
>                 goto func_cont3;
> 
>         pNode->nodeId = *pNodeId;
> @@ -522,7 +522,7 @@
>                 pNode->createArgs.asa.taskArgs.uGPPHeapAddr =
>                                                  (u32)pAttrIn->pGPPVirtAddr;
>         }
> -       if (!DSP_SUCCEEDED(status))
> +       if (DSP_FAILED(status))
>                 goto func_cont3;
> 
>         status = PROC_ReserveMemory(hProcessor,
> @@ -538,7 +538,7 @@
>                          "NODE_Allocate: DSPProcessor_Reserve"
>                          " Memory successful: 0x%x\n", status);
>         }
> -       if (!DSP_SUCCEEDED(status))
> +       if (DSP_FAILED(status))
>                 goto func_cont3;
> 
>         mapAttrs |= DSP_MAPLITTLEENDIAN;
> @@ -690,7 +690,7 @@
>                                      ndbProps.uStackSegName, label) == 0) {
>                         status = hNodeMgr->nldrFxns.pfnGetFxnAddr(pNode->
>                                  hNldrNode, "DYNEXT_BEG", &dynextBase);
> -                       if (!DSP_SUCCEEDED(status)) {
> +                       if (DSP_FAILED(status)) {
>                                 GT_1trace(NODE_debugMask, GT_5CLASS,
>                                 "NODE_Allocate: Failed to get Address for "
>                                 "DYNEXT_BEG: 0x%x\n", status);
> @@ -699,7 +699,7 @@
>                         status = hNodeMgr->nldrFxns.pfnGetFxnAddr(pNode->
>                                  hNldrNode, "L1DSRAM_HEAP", &pulValue);
> 
> -                       if (!DSP_SUCCEEDED(status)) {
> +                       if (DSP_FAILED(status)) {
>                                 GT_1trace(NODE_debugMask, GT_5CLASS,
>                                 "NODE_Allocate: Failed to get Address for "
>                                 "L1DSRAM_HEAP: 0x%x\n", status);
> @@ -847,7 +847,7 @@
>         if (NODE_GetType(pNode) == NODE_DEVICE)
>                 status = DSP_ENODETYPE;
> 
> -       if (!DSP_SUCCEEDED(status))
> +       if (DSP_FAILED(status))
>                 goto func_end;
> 
>         if (pAttr == NULL)
> @@ -946,12 +946,12 @@
>                                 nPriority > hNodeMgr->nMaxPri)
>                                 status = DSP_ERANGE;
>         }
> -       if (!DSP_SUCCEEDED(status))
> +       if (DSP_FAILED(status))
>                 goto func_end;
> 
>         /* Enter critical section */
>         status = SYNC_EnterCS(hNodeMgr->hSync);
> -       if (!DSP_SUCCEEDED(status))
> +       if (DSP_FAILED(status))
>                 goto func_cont;
> 
>         state = NODE_GetState(hNode);
> @@ -1067,7 +1067,7 @@
>                         status = DSP_ESTRMMODE; /* illegal stream mode */
> 
>         }
> -       if (!DSP_SUCCEEDED(status))
> +       if (DSP_FAILED(status))
>                 goto func_end;
> 
>         if (node1Type != NODE_GPP) {
> @@ -1078,7 +1078,7 @@
>         }
>         /* Enter critical section */
>         status = SYNC_EnterCS(hNodeMgr->hSync);
> -       if (!DSP_SUCCEEDED(status))
> +       if (DSP_FAILED(status))
>                 goto func_cont;
> 
>         /* Nodes must be in the allocated state */
> @@ -1332,7 +1332,7 @@
>         pIntfFxns = hNodeMgr->pIntfFxns;
>         /* Get access to node dispatcher */
>         status = SYNC_EnterCS(hNodeMgr->hSync);
> -       if (!DSP_SUCCEEDED(status))
> +       if (DSP_FAILED(status))
>                 goto func_cont;
> 
>         /* Check node state */
> @@ -1342,7 +1342,7 @@
>         if (DSP_SUCCEEDED(status))
>                 status = PROC_GetProcessorId(pNode->hProcessor, &procId);
> 
> -       if (!DSP_SUCCEEDED(status))
> +       if (DSP_FAILED(status))
>                 goto func_cont2;
> 
>         if (procId != DSP_UNIT)
> @@ -1668,7 +1668,7 @@
>         pIntfFxns = hNodeMgr->pIntfFxns;
>         /* Enter critical section */
>         status = SYNC_EnterCS(hNodeMgr->hSync);
> -       if (!DSP_SUCCEEDED(status))
> +       if (DSP_FAILED(status))
>                 goto func_end;
> 
>         state = NODE_GetState(hNode);
> @@ -1680,7 +1680,7 @@
>         if (!(state == NODE_ALLOCATED && hNode->nodeEnv == (u32)NULL) &&
>            nodeType != NODE_DEVICE) {
>                 status = PROC_GetProcessorId(pNode->hProcessor, &procId);
> -               if (!DSP_SUCCEEDED(status))
> +               if (DSP_FAILED(status))
>                         goto func_cont1;
> 
>                 if (procId == DSP_UNIT || procId == IVA_UNIT) {
> @@ -1770,13 +1770,13 @@
>          /*  Free host-side resources allocated by NODE_Create()
>          *  DeleteNode() fails if SM buffers not freed by client!  */
>  #ifndef RES_CLEANUP_DISABLE
> -       if (!DSP_SUCCEEDED(status))
> +       if (DSP_FAILED(status))
>                 goto func_cont;
> 
>         /* Update the node and stream resource status */
>         PRCS_GetCurrentHandle(&hProcess);
>         res_status = CFG_GetObject((u32 *)&hDrvObject, REG_DRV_OBJECT);
> -       if (!DSP_SUCCEEDED(res_status))
> +       if (DSP_FAILED(res_status))
>                 goto func_cont;
> 
>         DRV_GetProcContext((u32)hProcess, (struct DRV_OBJECT *)hDrvObject,
> @@ -2067,7 +2067,7 @@
>         pIntfFxns = hNodeMgr->pIntfFxns;
>         status = (*pIntfFxns->pfnMsgGet)(hNode->hMsgQueue, pMsg, uTimeout);
>         /* Check if message contains SM descriptor */
> -       if (!DSP_SUCCEEDED(status) ||  !(pMsg->dwCmd & DSP_RMSBUFDESC))
> +       if (DSP_FAILED(status) ||  !(pMsg->dwCmd & DSP_RMSBUFDESC))
>                 goto func_end;
> 
>          /* Translate DSP byte addr to GPP Va.  */
> @@ -2354,7 +2354,7 @@
>                 /* end of SYNC_EnterCS */
>                 (void)SYNC_LeaveCS(hNodeMgr->hSync);
>         }
> -       if (!DSP_SUCCEEDED(status))
> +       if (DSP_FAILED(status))
>                 goto func_end;
> 
>         /* assign pMsg values to new msg  */
> @@ -2477,14 +2477,14 @@
>                 if (nodeType == NODE_DEVICE)
>                         status = DSP_ENODETYPE;
>         }
> -       if (!DSP_SUCCEEDED(status))
> +       if (DSP_FAILED(status))
>                 goto func_end;
> 
>         hNodeMgr = hNode->hNodeMgr;
>         pIntfFxns = hNodeMgr->pIntfFxns;
>         /* Enter critical section */
>         status = SYNC_EnterCS(hNodeMgr->hSync);
> -       if (!DSP_SUCCEEDED(status))
> +       if (DSP_FAILED(status))
>                 goto func_cont;
> 
>         state = NODE_GetState(hNode);
> @@ -2494,7 +2494,7 @@
>         if (DSP_SUCCEEDED(status))
>                 status = PROC_GetProcessorId(pNode->hProcessor, &procId);
> 
> -       if (!DSP_SUCCEEDED(status))
> +       if (DSP_FAILED(status))
>                 goto func_cont1;
> 
>         if ((procId != DSP_UNIT) && (procId != IVA_UNIT))
> Index: omapkernel/drivers/dsp/bridge/rmgr/proc.c
> ===================================================================
> --- omapkernel.orig/drivers/dsp/bridge/rmgr/proc.c      2008-08-22 19:18:30.000000000 -0500
> +++ omapkernel/drivers/dsp/bridge/rmgr/proc.c   2008-08-22 19:19:19.000000000 -0500
> @@ -269,7 +269,7 @@
>                                  " DevType, 0x%x!\n", status);
>                 }
>         }
> -       if (!DSP_SUCCEEDED(status))
> +       if (DSP_FAILED(status))
>                 goto func_end;
> 
>         /* If we made it this far, create the Proceesor object: */
> @@ -307,7 +307,7 @@
>                          " the DEV_ Interface fxns.\n", status);
>                 MEM_FreeObject(pProcObject);
>         }
> -       if (!DSP_SUCCEEDED(status))
> +       if (DSP_FAILED(status))
>                 goto func_end;
> 
>         /* Create the Notification Object */
> @@ -357,12 +357,12 @@
>         }
>  func_end:
>  #ifndef RES_CLEANUP_DISABLE
> -       if (!DSP_SUCCEEDED(status))
> +       if (DSP_FAILED(status))
>                 goto func_cont;
> 
>         PRCS_GetCurrentHandle(&hProcess);
>         res_status = CFG_GetObject((u32 *)&hDRVObject, REG_DRV_OBJECT);
> -       if (!DSP_SUCCEEDED(res_status))
> +       if (DSP_FAILED(res_status))
>                 goto func_cont;
> 
>         DRV_GetProcContext((u32)hProcess, (struct DRV_OBJECT *)hDRVObject,
> @@ -451,7 +451,7 @@
>                  "Entered PROC_AutoStart, args:\n\t"
>                  "hDevNode: 0x%x\thDevObject: 0x%x\n", hDevNode, hDevObject);
>         /* Create a Dummy PROC Object */
> -       if (!DSP_SUCCEEDED(CFG_GetObject((u32 *)&hMgrObject,
> +       if (DSP_FAILED(CFG_GetObject((u32 *)&hMgrObject,
>            REG_MGR_OBJECT))) {
>                 GT_0trace(PROC_DebugMask, GT_7CLASS,
>                          "PROC_AutoStart: DSP_FAILED to "
> @@ -486,12 +486,12 @@
>                          "PROC_AutoStart: Failed to "
>                          "get IntFxns \n");
>         }
> -       if (!DSP_SUCCEEDED(status))
> +       if (DSP_FAILED(status))
>                 goto func_end;
> 
>         /* Stop the Device, put it into standby mode */
>         status = PROC_Stop(hProcObject);
> -       if (!DSP_SUCCEEDED(CFG_GetAutoStart(hDevNode, &dwAutoStart)) ||
> +       if (DSP_FAILED(CFG_GetAutoStart(hDevNode, &dwAutoStart)) ||
>                            !dwAutoStart) {
>                 status = DSP_EFAIL;
>                 /* DSP_FAILED to Get s32 Fxn or Wmd Context */
> @@ -787,7 +787,7 @@
>         case DSP_RESOURCE_DYNSARAM:
>         case DSP_RESOURCE_DYNEXTERNAL:
>         case DSP_RESOURCE_DYNSRAM:
> -               if (!DSP_SUCCEEDED(DEV_GetNodeManager(pProcObject->hDevObject,
> +               if (DSP_FAILED(DEV_GetNodeManager(pProcObject->hDevObject,
>                    &hNodeMgr)))
>                         goto func_end;
> 
> @@ -918,7 +918,7 @@
>                 if (DSP_SUCCEEDED(status) && hDehMgr) {
>                         status = (*pProcObject->pIntfFxns->pfnDehGetInfo)
>                                  (hDehMgr, &(pProcStatus->errInfo));
> -                       if (!DSP_SUCCEEDED(status)) {
> +                       if (DSP_FAILED(status)) {
>                                 GT_0trace(PROC_DebugMask, GT_7CLASS,
>                                          "PROC_GetState: Failed "
>                                          "retrieve exception info.\n");
> @@ -1041,14 +1041,14 @@
>                          "Client is already attached status 0x%x \n", status);
>                 goto func_end;
>         }
> -       if (!DSP_SUCCEEDED(DEV_GetCodMgr(pProcObject->hDevObject, &hCodMgr))) {
> +       if (DSP_FAILED(DEV_GetCodMgr(pProcObject->hDevObject, &hCodMgr))) {
>                 status = DSP_EFAIL;
>                 GT_1trace(PROC_DebugMask, GT_7CLASS, "PROC_Load: DSP_FAILED in "
>                          "DEV_GetCodMgr status 0x%x \n", status);
>                 goto func_end;
>         }
>         status = PROC_Stop(hProcessor);
> -       if (!DSP_SUCCEEDED(status)) {
> +       if (DSP_FAILED(status)) {
>                 GT_1trace(PROC_DebugMask, GT_7CLASS,
>                          "PROC_Load: DSP_FAILED to Place the"
>                          " Processor in Stop Mode(PROC_STOP) status 0x%x \n",
> @@ -1057,7 +1057,7 @@
>         }
>         /* Place the board in the monitor state. */
>         status = PROC_Monitor(hProcessor);
> -       if (!DSP_SUCCEEDED(status)) {
> +       if (DSP_FAILED(status)) {
>                 GT_1trace(PROC_DebugMask, GT_7CLASS,
>                          "PROC_Load: DSP_FAILED to Place the"
>                          " Processor in Monitor Mode(PROC_IDLE) status 0x%x\n",
> @@ -1476,7 +1476,7 @@
>                         status = (*pProcObject->pIntfFxns->pfnDehRegisterNotify)
>                                  (hDehMgr, uEventMask, uNotifyType,
>                                  hNotification);
> -                       if (!DSP_SUCCEEDED(status))
> +                       if (DSP_FAILED(status))
>                                 status = DSP_EFAIL;
> 
>                 }
> @@ -1544,7 +1544,7 @@
>                 goto func_end;
>         }
>         status = DEV_GetCodMgr(pProcObject->hDevObject, &hCodMgr);
> -       if (!DSP_SUCCEEDED(status)) {
> +       if (DSP_FAILED(status)) {
>                 status = DSP_EFAIL;
>                 GT_1trace(PROC_DebugMask, GT_7CLASS,
>                          "Processor Start DSP_FAILED "
> @@ -1552,7 +1552,7 @@
>                 goto func_cont;
>         }
>         status = COD_GetEntry(hCodMgr, &dwDspAddr);
> -       if (!DSP_SUCCEEDED(status)) {
> +       if (DSP_FAILED(status)) {
>                 status = DSP_EFAIL;
>                 GT_1trace(PROC_DebugMask, GT_7CLASS,
>                          "Processor Start  DSP_FAILED in "
> @@ -1561,7 +1561,7 @@
>         }
>         status = (*pProcObject->pIntfFxns->pfnBrdStart)
>                  (pProcObject->hWmdContext, dwDspAddr);
> -       if (!DSP_SUCCEEDED(status)) {
> +       if (DSP_FAILED(status)) {
>                 status = DSP_EFAIL;
>                 GT_0trace(PROC_DebugMask, GT_7CLASS,
>                          "PROC_Start Failed to Start the board\n");
> @@ -1734,13 +1734,13 @@
>         GT_1trace(PROC_DebugMask, GT_ENTER,
>                    "PROC_UnMap DRV_GetDMMResElement "
>                    "pMapAddr:[0x%x]", pMapAddr);
> -       if (!DSP_SUCCEEDED(status))
> +       if (DSP_FAILED(status))
>                 goto func_end;
> 
>         /* Update the node and stream resource status */
>         PRCS_GetCurrentHandle(&hProcess);
>         res_status = CFG_GetObject((u32 *)&hDrvObject, REG_DRV_OBJECT);
> -       if (!DSP_SUCCEEDED(res_status))
> +       if (DSP_FAILED(res_status))
>                 goto func_end;
> 
>         DRV_GetProcContext((u32)hProcess, (struct DRV_OBJECT *)hDrvObject,
> Index: omapkernel/drivers/dsp/bridge/rmgr/pwr.c
> ===================================================================
> --- omapkernel.orig/drivers/dsp/bridge/rmgr/pwr.c       2008-08-22 19:03:56.000000000 -0500
> +++ omapkernel/drivers/dsp/bridge/rmgr/pwr.c    2008-08-22 19:19:19.000000000 -0500
> @@ -65,11 +65,11 @@
>                         hDevObject =
>                                 (struct DEV_OBJECT *)DRV_GetNextDevObject
>                                 ((u32)hDevObject)) {
> -               if (!DSP_SUCCEEDED(DEV_GetWMDContext(hDevObject,
> +               if (DSP_FAILED(DEV_GetWMDContext(hDevObject,
>                    (struct WMD_DEV_CONTEXT **)&dwContext))) {
>                         continue;
>                 }
> -               if (!DSP_SUCCEEDED(DEV_GetIntfFxns(hDevObject,
> +               if (DSP_FAILED(DEV_GetIntfFxns(hDevObject,
>                    (struct WMD_DRV_INTERFACE **)&pIntfFxns))) {
>                         continue;
>                 }
> Index: omapkernel/drivers/dsp/bridge/rmgr/rmm.c
> ===================================================================
> --- omapkernel.orig/drivers/dsp/bridge/rmgr/rmm.c       2008-08-22 19:03:41.000000000 -0500
> +++ omapkernel/drivers/dsp/bridge/rmgr/rmm.c    2008-08-22 19:19:19.000000000 -0500
> @@ -216,7 +216,7 @@
>                          "RMM_create: Memory allocation failed\n");
>                 status = DSP_EMEMORY;
>         }
> -       if (!DSP_SUCCEEDED(status))
> +       if (DSP_FAILED(status))
>                 goto func_cont;
> 
>         target->numSegs = numSegs;
> Index: omapkernel/drivers/dsp/bridge/rmgr/strm.c
> ===================================================================
> --- omapkernel.orig/drivers/dsp/bridge/rmgr/strm.c      2008-08-22 19:18:30.000000000 -0500
> +++ omapkernel/drivers/dsp/bridge/rmgr/strm.c   2008-08-22 19:19:19.000000000 -0500
> @@ -181,7 +181,7 @@
>                         status = DSP_ESIZE;
> 
>         }
> -       if (!DSP_SUCCEEDED(status)) {
> +       if (DSP_FAILED(status)) {
>                 status = DSP_EHANDLE;
>                 goto func_end;
>         }
> @@ -201,12 +201,12 @@
>                 STRM_FreeBuffer(hStrm, apBuffer, uAllocated);
> 
>  #ifndef RES_CLEANUP_DISABLE
> -       if (!DSP_SUCCEEDED(status))
> +       if (DSP_FAILED(status))
>                 goto func_end;
> 
>         PRCS_GetCurrentHandle(&hProcess);
>         res_status = CFG_GetObject((u32 *)&hDrvObject, REG_DRV_OBJECT);
> -       if (!DSP_SUCCEEDED(res_status))
> +       if (DSP_FAILED(res_status))
>                 goto func_end;
> 
>         DRV_GetProcContext((u32)hProcess, (struct DRV_OBJECT *)hDrvObject,
> @@ -272,13 +272,13 @@
>                 }
>         }
>  #ifndef RES_CLEANUP_DISABLE
> -       if (!DSP_SUCCEEDED(status))
> +       if (DSP_FAILED(status))
>                 goto func_end;
> 
>         /* Update the node and stream resource status */
>         PRCS_GetCurrentHandle(&hProcess);
>         res_status = CFG_GetObject((u32 *)&hDrvObject, REG_DRV_OBJECT);
> -       if (!DSP_SUCCEEDED(res_status))
> +       if (DSP_FAILED(res_status))
>                 goto func_end;
> 
>         DRV_GetProcContext((u32)hProcess, (struct DRV_OBJECT *)hDrvObject,
> @@ -474,12 +474,12 @@
>                         status = DSP_ESIZE;
>                 }
>         }
> -       if (!DSP_SUCCEEDED(status))
> +       if (DSP_FAILED(status))
>                 goto func_end;
> 
>         pIntfFxns = hStrm->hStrmMgr->pIntfFxns;
>         status = (*pIntfFxns->pfnChnlGetInfo) (hStrm->hChnl, &chnlInfo);
> -       if (!DSP_SUCCEEDED(status))
> +       if (DSP_FAILED(status))
>                 goto func_end;
> 
>         if (hStrm->hXlator) {
> @@ -702,7 +702,7 @@
> 
>                 }
>         }
> -       if (!DSP_SUCCEEDED(status))
> +       if (DSP_FAILED(status))
>                 goto func_cont;
> 
>         if ((pAttr->pVirtBase == NULL) || !(pAttr->ulVirtSize > 0))
> @@ -954,7 +954,7 @@
>                         break;
>                 }
>         }
> -       if (!DSP_SUCCEEDED(status))
> +       if (DSP_FAILED(status))
>                 goto func_end;
> 
>         /* Determine which channels have IO ready */
> Index: omapkernel/drivers/dsp/bridge/services/kfile.c
> ===================================================================
> --- omapkernel.orig/drivers/dsp/bridge/services/kfile.c 2008-08-22 19:03:10.000000000 -0500
> +++ omapkernel/drivers/dsp/bridge/services/kfile.c      2008-08-22 19:19:19.000000000 -0500
> @@ -186,7 +186,7 @@
>                         status = DSP_SOK;
>                 }
>                 set_fs(fs);
> -               if (!DSP_SUCCEEDED(status)) {
> +               if (DSP_FAILED(status)) {
>                         /* free memory, and clear handle */
>                         MEM_FreeObject(hFile);
>                         hFile = NULL;
> Index: omapkernel/drivers/dsp/bridge/services/ntfy.c
> ===================================================================
> --- omapkernel.orig/drivers/dsp/bridge/services/ntfy.c  2008-08-22 19:18:30.000000000 -0500
> +++ omapkernel/drivers/dsp/bridge/services/ntfy.c       2008-08-22 19:19:19.000000000 -0500
> @@ -250,7 +250,7 @@
> 
>         }
> 
> -       if (!DSP_SUCCEEDED(status))
> +       if (DSP_FAILED(status))
>                 return status;
> 
>         (void)SYNC_EnterCS(hNtfy->hSync);
> Index: omapkernel/drivers/dsp/bridge/wmd/chnl_sm.c
> ===================================================================
> --- omapkernel.orig/drivers/dsp/bridge/wmd/chnl_sm.c    2008-08-22 19:03:10.000000000 -0500
> +++ omapkernel/drivers/dsp/bridge/wmd/chnl_sm.c 2008-08-22 19:19:19.000000000 -0500
> @@ -335,7 +335,7 @@
>         } else {
>                 status = DSP_EHANDLE;
>         }
> -       if (!DSP_SUCCEEDED(status))
> +       if (DSP_FAILED(status))
>                 goto func_end;
> 
>          /*  Mark this channel as cancelled, to prevent further IORequests or
> @@ -589,7 +589,7 @@
>                               DSP_SUCCEEDED(status)) {
>                                 status = WMD_CHNL_GetIOC(hChnl, dwTimeOut,
>                                                          &chnlIOC);
> -                               if (!DSP_SUCCEEDED(status))
> +                               if (DSP_FAILED(status))
>                                         continue;
> 
>                                 if (chnlIOC.status & CHNL_IOCSTATTIMEOUT)
> @@ -669,7 +669,7 @@
>                         status = CHNL_E_NOIOC;
> 
>         }
> -       if (!DSP_SUCCEEDED(status))
> +       if (DSP_FAILED(status))
>                 goto func_end;
> 
>         ioc.status = CHNL_IOCSTATCOMPLETE;
> @@ -898,7 +898,7 @@
>                         }
>                 }
>         }
> -       if (!DSP_SUCCEEDED(status))
> +       if (DSP_FAILED(status))
>                 goto func_end;
> 
>         DBC_Assert(uChnlId < pChnlMgr->cChannels);
> Index: omapkernel/drivers/dsp/bridge/wmd/io_sm.c
> ===================================================================
> --- omapkernel.orig/drivers/dsp/bridge/wmd/io_sm.c      2008-08-22 19:03:56.000000000 -0500
> +++ omapkernel/drivers/dsp/bridge/wmd/io_sm.c   2008-08-22 19:19:19.000000000 -0500
> @@ -291,7 +291,7 @@
>          *  loaded. I chose the value -1 because it was less likely to be
>          *  a valid address than 0.  */
>         pSharedMem = (struct SHM *) -1;
> -       if (!DSP_SUCCEEDED(status))
> +       if (DSP_FAILED(status))
>                 goto func_cont;
> 
>         /* Allocate IO manager object: */
> @@ -447,13 +447,13 @@
>         /* Get start and length of channel part of shared memory */
>         status = COD_GetSymValue(hCodMan, CHNL_SHARED_BUFFER_BASE_SYM,
>                                  &ulShmBase);
> -       if (!DSP_SUCCEEDED(status)) {
> +       if (DSP_FAILED(status)) {
>                 status = CHNL_E_NOMEMMAP;
>                 goto func_cont1;
>         }
>         status = COD_GetSymValue(hCodMan, CHNL_SHARED_BUFFER_LIMIT_SYM,
>                                 &ulShmLimit);
> -       if (!DSP_SUCCEEDED(status)) {
> +       if (DSP_FAILED(status)) {
>                 status = CHNL_E_NOMEMMAP;
>                 goto func_cont1;
>         }
> @@ -561,7 +561,7 @@
>                         status = DSP_EMEMORY;
>                 }
>         }
> -       if (!DSP_SUCCEEDED(status))
> +       if (DSP_FAILED(status))
>                 goto func_cont;
> 
>         paCurr = ulGppPa;
> Index: omapkernel/drivers/dsp/bridge/wmd/mmu_fault.c
> ===================================================================
> --- omapkernel.orig/drivers/dsp/bridge/wmd/mmu_fault.c  2008-08-22 19:03:56.000000000 -0500
> +++ omapkernel/drivers/dsp/bridge/wmd/mmu_fault.c       2008-08-22 19:19:19.000000000 -0500
> @@ -103,7 +103,7 @@
>                 status = CFG_GetHostResources(
>                          (struct CFG_DEVNODE *)DRV_GetFirstDevExtension(),
>                          &resources);
> -               if (!DSP_SUCCEEDED(status))
> +               if (DSP_FAILED(status))
>                         DBG_Trace(DBG_LEVEL7,
>                                  "**Failed to get Host Resources "
>                                  "in MMU ISR **\n");
> @@ -156,7 +156,7 @@
>         struct CFG_HOSTRES resources;
>         status = CFG_GetHostResources(
>                 (struct CFG_DEVNODE *)DRV_GetFirstDevExtension(), &resources);
> -       if (!DSP_SUCCEEDED(status))
> +       if (DSP_FAILED(status))
>                 DBG_Trace(DBG_LEVEL7, "**Failed to get Host Resources in "
>                          "MMU_CheckIfFault **\n");
> 
> Index: omapkernel/drivers/dsp/bridge/wmd/tiomap3430.c
> ===================================================================
> --- omapkernel.orig/drivers/dsp/bridge/wmd/tiomap3430.c 2008-08-22 19:18:24.000000000 -0500
> +++ omapkernel/drivers/dsp/bridge/wmd/tiomap3430.c      2008-08-22 19:19:19.000000000 -0500
> @@ -550,7 +550,7 @@
>                         else
>                                 status = DSP_EFAIL;
> 
> -                       if (!DSP_SUCCEEDED(status)) {
> +                       if (DSP_FAILED(status)) {
>                                 DBG_Trace(DBG_LEVEL7, " Error while setting"
>                                                         "LM Timer  to 32KHz\n");
>                         }
> @@ -592,7 +592,7 @@
>                         else
>                                 status = DSP_EFAIL;
> 
> -                       if (!DSP_SUCCEEDED(status)) {
> +                       if (DSP_FAILED(status)) {
>                                 DBG_Trace(DBG_LEVEL7,
>                                 " Error while setting BIOS Timer  to 32KHz\n");
>                         }
> @@ -725,7 +725,7 @@
>         status = CFG_GetHostResources(
>                         (struct CFG_DEVNODE *)DRV_GetFirstDevExtension(),
>                         &resources);
> -       if (!DSP_SUCCEEDED(status)) {
> +       if (DSP_FAILED(status)) {
>                 DBG_Trace(DBG_LEVEL7,
>                           "WMD_BRD_Stop: Get Host resources failed \n");
>                 DBG_Trace(DBG_LEVEL1, "Device Stopp failed \n ");
> @@ -747,7 +747,7 @@
>                 udelay(50);
> 
>                 clk_status = CLK_Disable(SERVICESCLK_iva2_ck);
> -               if (!DSP_SUCCEEDED(clk_status)) {
> +               if (DSP_FAILED(clk_status)) {
>                         DBG_Trace(DBG_LEVEL6,
>                                  "\n WMD_BRD_Stop: CLK_Disable failed "
>                                  "for iva2_fck\n");
> @@ -764,7 +764,7 @@
>                                            HW_SW_SUP_SLEEP);
>         } else {
>                 clk_status = CLK_Disable(SERVICESCLK_iva2_ck);
> -               if (!DSP_SUCCEEDED(clk_status)) {
> +               if (DSP_FAILED(clk_status)) {
>                         DBG_Trace(DBG_LEVEL6,
>                                  "\n WMD_BRD_Stop: Else loop CLK_Disable failed"
>                                  " for iva2_fck\n");
> @@ -824,7 +824,7 @@
>          * IVA2 */
>         status = CFG_GetHostResources(
>                 (struct CFG_DEVNODE *)DRV_GetFirstDevExtension(), &resources);
> -       if (!DSP_SUCCEEDED(status)) {
> +       if (DSP_FAILED(status)) {
>                 DBG_Trace(DBG_LEVEL7,
>                          "WMD_BRD_Stop: Get Host resources failed \n");
>                 DBG_Trace(DBG_LEVEL1, "Device Delete failed \n ");
> @@ -832,7 +832,7 @@
>         }
>         status = SleepDSP(pDevContext, PWR_EMERGENCYDEEPSLEEP, NULL);
>         clk_status = CLK_Disable(SERVICESCLK_iva2_ck);
> -       if (!DSP_SUCCEEDED(clk_status)) {
> +       if (DSP_FAILED(clk_status)) {
>                 DBG_Trace(DBG_LEVEL6, "\n WMD_BRD_Stop: CLK_Disable failed for"
>                           " iva2_fck\n");
>         }
> @@ -936,7 +936,7 @@
>         }
>         status = CFG_GetHostResources(
>                 (struct CFG_DEVNODE *)DRV_GetFirstDevExtension(), &resources);
> -       if (!DSP_SUCCEEDED(status)) {
> +       if (DSP_FAILED(status)) {
>                 DBG_Trace(DBG_ENTER, "Failed to get host resources   \n");
>                 status = DSP_EMEMORY;
>                 goto func_end;
> @@ -1052,7 +1052,7 @@
>                 DBG_Trace(DBG_LEVEL7, "WMD_DEV_create:Reset mail box and "
>                           "enable the clock \n");
>                 status = CLK_Enable(SERVICESCLK_mailbox_ick);
> -               if (!DSP_SUCCEEDED(status)) {
> +               if (DSP_FAILED(status)) {
>                         DBG_Trace(DBG_LEVEL7,
>                                  "WMD_DEV_create:Reset mail box and "
>                                  "enable the clock Fail\n");
> @@ -1384,7 +1384,7 @@
>                           "MPU Buffer !!! \n");
>                 status = DSP_EINVALIDARG;
>         }
> -       if (!DSP_SUCCEEDED(status))
> +       if (DSP_FAILED(status))
>                 goto func_cont;
>         pPhysAddrPageTbl = DMM_GetPhysicalAddrTable();
>         /* Build the array with virtual to physical translations */
> @@ -1988,7 +1988,7 @@
>          * Combine physically contiguous regions to reduce TLBs.
>          * Pass the translated pa to PteUpdate.  */
>         numPages = ulNumBytes / PAGE_SIZE; /* PAGE_SIZE = OS page size */
> -       if (!DSP_SUCCEEDED(status))
> +       if (DSP_FAILED(status))
>                 goto func_cont;
> 
>         i = 0;
> @@ -2064,7 +2064,7 @@
>                 HW_PWR_IVA2StateGet(prm_base, HW_PWR_DOMAIN_DSP, &pwrState);
>         }
>         clk_status = CLK_Disable(SERVICESCLK_iva2_ck);
> -       if (!DSP_SUCCEEDED(clk_status)) {
> +       if (DSP_FAILED(clk_status)) {
>                 DBG_Trace(DBG_LEVEL6, "CLK_Disbale failed for clk = 0x%x \n",
>                           SERVICESCLK_iva2_ck);
>         }
> @@ -2075,7 +2075,7 @@
>         /* set the SYSC for Idle Boot */
>         *((REG_UWORD32 *)((u32)(sysctrl_base) + 0x404)) = (u32)0x01;
>         clk_status = CLK_Enable(SERVICESCLK_iva2_ck);
> -       if (!DSP_SUCCEEDED(clk_status)) {
> +       if (DSP_FAILED(clk_status)) {
>                 DBG_Trace(DBG_LEVEL6, "CLK_Enable failed for clk = 0x%x \n",
>                           SERVICESCLK_iva2_ck);
>         }
> Index: omapkernel/drivers/dsp/bridge/wmd/ue_deh.c
> ===================================================================
> --- omapkernel.orig/drivers/dsp/bridge/wmd/ue_deh.c     2008-08-22 19:18:30.000000000 -0500
> +++ omapkernel/drivers/dsp/bridge/wmd/ue_deh.c  2008-08-22 19:19:19.000000000 -0500
> @@ -383,7 +383,7 @@
>         status = CFG_GetHostResources(
>                         (struct CFG_DEVNODE *)DRV_GetFirstDevExtension(),
>                         &resources);
> -       if (!DSP_SUCCEEDED(status))
> +       if (DSP_FAILED(status))
>                 DBG_Trace(DBG_LEVEL7,
>                          "**Failed to get Host Resources in MMU ISR **\n");
> 
> Index: omapkernel/arch/arm/plat-omap/include/mach/bridge/dbdefs.h
> ===================================================================
> --- omapkernel.orig/arch/arm/plat-omap/include/mach/bridge/dbdefs.h     2008-08-22 19:03:10.000000000 -0500
> +++ omapkernel/arch/arm/plat-omap/include/mach/bridge/dbdefs.h  2008-08-22 19:20:05.000000000 -0500
> @@ -140,8 +140,8 @@
>  #define DSPWORDSIZE     sizeof(DSPWORD)
> 
>  /* Success & Failure macros  */
> -#define DSP_SUCCEEDED(Status)      ((s32)(Status) >= 0)
> -#define DSP_FAILED(Status)         ((s32)(Status) < 0)
> +#define DSP_SUCCEEDED(Status)      likely((s32)(Status) >= 0)
> +#define DSP_FAILED(Status)         unlikely((s32)(Status) < 0)
> 
>  /* Power control enumerations */
>  #define PROC_PWRCONTROL             0x8070
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: "Hebbar, Shivananda" <x0hebbar@ti.com>
Subject: Patch [1/2] DSPBRIDGE: Execessive u32 Cleanup(u32->short int)
Date: Fri, 19 Feb 2010 00:54:00 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044D71B419@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:42947 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751002Ab0BRTYG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Feb 2010 14:24:06 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id o1IJO3bb023215
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 18 Feb 2010 13:24:05 -0600
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id o1IJO2cC027770
	for <linux-omap@vger.kernel.org>; Fri, 19 Feb 2010 00:54:02 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>


>From 9c472382f598ed86fa2fe3f83dd064323918ff5e Mon Sep 17 00:00:00 2001
From: Shivananda Hebbar <x0hebbar@ti.com>
Date: Thu, 28 Jan 2010 18:22:56 -0600
Subject: [PATCH] DSPBRIDGE: Execessive u32 Cleanup(u32->short int)

This patch removes execessive u32's used in bridge.
As part of this, u32 types is changed to short int.

Signed-off-by: Shivananda Hebbar <x0hebbar@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/_chnl_sm.h |   10 ++++----
 arch/arm/plat-omap/include/dspbridge/cfg.h      |    4 +-
 arch/arm/plat-omap/include/dspbridge/cfgdefs.h  |    8 +++---
 arch/arm/plat-omap/include/dspbridge/chnlpriv.h |   12 +++++-----
 arch/arm/plat-omap/include/dspbridge/io_sm.h    |    2 +-
 drivers/dsp/bridge/pmgr/dev.c                   |    2 +-
 drivers/dsp/bridge/pmgr/wcd.c                   |    2 +-
 drivers/dsp/bridge/rmgr/mgr.c                   |    4 +-
 drivers/dsp/bridge/rmgr/node.c                  |    6 ++--
 drivers/dsp/bridge/services/cfg.c               |    4 +-
 drivers/dsp/bridge/wmd/chnl_sm.c                |    2 +-
 drivers/dsp/bridge/wmd/io_sm.c                  |   26 +++++++++++-----------
 12 files changed, 41 insertions(+), 41 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/_chnl_sm.h b/arch/arm/plat-omap/include/dspbridge/_chnl_sm.h
index eb5adc2..a581349 100644
--- a/arch/arm/plat-omap/include/dspbridge/_chnl_sm.h
+++ b/arch/arm/plat-omap/include/dspbridge/_chnl_sm.h
@@ -119,10 +119,10 @@ struct loadMonStruct {
 		/* Critical section object handle */
 		struct SYNC_CSOBJECT *hCSObj;
 		u32 uWordSize;	/* Size in bytes of DSP word */
-		u32 cChannels;	/* Total number of channels */
-		u32 cOpenChannels;	/* Total number of open channels */
+		short int cChannels;		/* Total number of channels */
+		short int cOpenChannels;/* Total number of open channels */
 		struct CHNL_OBJECT **apChannel;	/* Array of channels */
-		u32 dwType;	/* Type of channel class library */
+		short int dwType;	/* Type of channel class library */
 		/* If no SHM syms, return for CHNL_Open */
 		DSP_STATUS chnlOpenStatus;
 	} ;
@@ -136,8 +136,8 @@ struct loadMonStruct {
 		/* Pointer back to channel manager */
 		struct CHNL_MGR *pChnlMgr;
 		u32 uId;	/* Channel id */
-		u32 dwState;	/* Current channel state */
-		u32 uMode;	/* Chnl mode and attributes */
+		short int dwState;	/* Current channel state */
+		short int uMode;	/* Chnl mode and attributes */
 		/* Chnl I/O completion event (user mode) */
 		HANDLE hUserEvent;
 		/* Abstract syncronization object */
diff --git a/arch/arm/plat-omap/include/dspbridge/cfg.h b/arch/arm/plat-omap/include/dspbridge/cfg.h
index 62cb6df..a186bd6 100644
--- a/arch/arm/plat-omap/include/dspbridge/cfg.h
+++ b/arch/arm/plat-omap/include/dspbridge/cfg.h
@@ -176,7 +176,7 @@
  *      DSP_SOK:    *pdwValue is set to the retrieved u32(non-Zero).
  *      else:       *pdwValue is set to 0L.
  */
-	extern DSP_STATUS CFG_GetObject(OUT u32 *pdwValue, u32 dwType);
+	extern DSP_STATUS CFG_GetObject(OUT u32 *pdwValue, short int dwType);
 
 /*
  *  ======== CFG_GetPerfValue ========
@@ -288,6 +288,6 @@
  *  Ensures:
  *      DSP_SOK:        The Private u32 was successfully set.
  */
-	extern DSP_STATUS CFG_SetObject(IN u32 dwValue, IN u32 dwType);
+	extern DSP_STATUS CFG_SetObject(IN u32 dwValue, short int dwType);
 
 #endif				/* CFG_ */
diff --git a/arch/arm/plat-omap/include/dspbridge/cfgdefs.h b/arch/arm/plat-omap/include/dspbridge/cfgdefs.h
index 55c6634..4c612c2 100644
--- a/arch/arm/plat-omap/include/dspbridge/cfgdefs.h
+++ b/arch/arm/plat-omap/include/dspbridge/cfgdefs.h
@@ -45,7 +45,7 @@
  *  Host resource structure.
  */
 	struct CFG_HOSTRES {
-		u32 wNumMemWindows;	/* Set to default */
+		short int wNumMemWindows;	/* Set to default */
 		/* This is the base.memory */
 		u32 dwMemBase[CFG_MAXMEMREGISTERS];  /* SHM virtual address */
 		u32 dwMemLength[CFG_MAXMEMREGISTERS]; /* Length of the Base */
@@ -63,7 +63,7 @@
 	 */
 		u32 dwChnlOffset;
 		u32 dwChnlBufSize;
-		u32 dwNumChnls;
+		short int NumChnls;
 		void __iomem *dwPrmBase;
 		void __iomem *dwCmBase;
 		void __iomem *dwPerBase;
@@ -84,8 +84,8 @@
 	struct CFG_DSPRES {
 		u32 uChipType;	/* DSP chip type.               */
 		u32 uWordSize;	/* Number of bytes in a word    */
-		u32 cChips;	/* Number of chips.             */
-		u32 cMemTypes;	/* Types of memory.             */
+		short int cChips;	/* Number of chips.             */
+		short int cMemTypes;	/* Types of memory.             */
 		struct CFG_DSPMEMDESC aMemDesc[CFG_DSPMAXMEMTYPES];
 		/* DSP Memory types */
 	} ;
diff --git a/arch/arm/plat-omap/include/dspbridge/chnlpriv.h b/arch/arm/plat-omap/include/dspbridge/chnlpriv.h
index 2eadfa0..c7a9b25 100644
--- a/arch/arm/plat-omap/include/dspbridge/chnlpriv.h
+++ b/arch/arm/plat-omap/include/dspbridge/chnlpriv.h
@@ -78,8 +78,8 @@
 		HANDLE hEvent;	/* Channel I/O completion event.          */
 		/*Abstraction of I/O completion event.*/
 		struct SYNC_OBJECT *hSyncEvent;
-		u32 dwMode;	/* Channel mode.                          */
-		u32 dwState;	/* Current channel state.                 */
+		short int uMode;	/* Channel mode. */
+		short int dwState;	/* Current channel state.*/
 		u32 cPosition;	/* Total bytes transferred.        */
 		u32 cIOCs;	/* Number of IOCs in queue.               */
 		u32 cIOReqs;	/* Number of IO Requests in queue.        */
@@ -92,17 +92,17 @@
 
 /* Channel manager info: */
 	struct CHNL_MGRINFO {
-		u32 dwType;	/* Type of channel class library.         */
+		short int dwType;	/* Type of channel class library. */
 		/* Channel handle, given the channel id. */
 		struct CHNL_OBJECT *hChnl;
-		u32 cOpenChannels;	/* Number of open channels.     */
-		u32 cChannels;	/* total # of chnls supported */
+		short int cOpenChannels;	/* Number of open channels. */
+		short int cChannels;	/* total # of chnls supported */
 	} ;
 
 /* Channel Manager Attrs: */
 	struct CHNL_MGRATTRS {
 		/* Max number of channels this manager can use. */
-		u32 cChannels;
+		short int cChannels;
 		u32 uWordSize;	/* DSP Word size.                       */
 	} ;
 
diff --git a/arch/arm/plat-omap/include/dspbridge/io_sm.h b/arch/arm/plat-omap/include/dspbridge/io_sm.h
index 67e3834..7d0bd92 100644
--- a/arch/arm/plat-omap/include/dspbridge/io_sm.h
+++ b/arch/arm/plat-omap/include/dspbridge/io_sm.h
@@ -114,7 +114,7 @@
  */
 	extern void IO_RequestChnl(struct IO_MGR *hIOMgr,
 				   struct CHNL_OBJECT *pChnl,
-				   u32 iMode, OUT u16 *pwMbVal);
+				   short int iMode, OUT u16 *pwMbVal);
 
 /*
  *  ======== IO_Schedule ========
diff --git a/drivers/dsp/bridge/pmgr/dev.c b/drivers/dsp/bridge/pmgr/dev.c
index 5c5e056..71fccf5 100644
--- a/drivers/dsp/bridge/pmgr/dev.c
+++ b/drivers/dsp/bridge/pmgr/dev.c
@@ -155,7 +155,7 @@ DSP_STATUS DEV_CreateDevice(OUT struct DEV_OBJECT **phDevObject,
 	struct DEV_OBJECT *pDevObject = NULL;
 	struct CHNL_MGRATTRS mgrAttrs;
 	struct IO_ATTRS ioMgrAttrs;
-	u32 uNumWindows;
+	short int uNumWindows;
 	struct DRV_OBJECT *hDrvObject = NULL;
 	DSP_STATUS status = DSP_SOK;
 	DBC_Require(cRefs > 0);
diff --git a/drivers/dsp/bridge/pmgr/wcd.c b/drivers/dsp/bridge/pmgr/wcd.c
index 962cac6..88dc3df 100644
--- a/drivers/dsp/bridge/pmgr/wcd.c
+++ b/drivers/dsp/bridge/pmgr/wcd.c
@@ -494,7 +494,7 @@ u32 MGRWRAP_EnumNode_Info(union Trapped_Args *args, void *pr_ctxt)
 u32 MGRWRAP_EnumProc_Info(union Trapped_Args *args, void *pr_ctxt)
 {
 	u8 *pProcessorInfo;
-	u32 uNumProcs;
+	short int uNumProcs;
 	DSP_STATUS status = DSP_SOK;
 	u32 size = args->ARGS_MGR_ENUMPROC_INFO.uProcessorInfoSize;
 
diff --git a/drivers/dsp/bridge/rmgr/mgr.c b/drivers/dsp/bridge/rmgr/mgr.c
index 4562157..120657f 100644
--- a/drivers/dsp/bridge/rmgr/mgr.c
+++ b/drivers/dsp/bridge/rmgr/mgr.c
@@ -237,8 +237,8 @@ DSP_STATUS MGR_EnumProcessorInfo(u32 uProcessor,
 	DSP_STATUS status1 = DSP_SOK;
 	DSP_STATUS status2 = DSP_SOK;
 	struct DSP_UUID uTempUuid;
-	u32 uTempIndex = 0;
-	u32 uProcIndex = 0;
+	short int uTempIndex = 0;
+	short int uProcIndex = 0;
 	struct DCD_GENERICOBJ GenObj;
 	struct MGR_OBJECT *pMgrObject = NULL;
 	struct MGR_PROCESSOREXTINFO *pExtInfo;
diff --git a/drivers/dsp/bridge/rmgr/node.c b/drivers/dsp/bridge/rmgr/node.c
index 336abea..a380766 100644
--- a/drivers/dsp/bridge/rmgr/node.c
+++ b/drivers/dsp/bridge/rmgr/node.c
@@ -1695,7 +1695,7 @@ DSP_STATUS NODE_EnumNodes(struct NODE_MGR *hNodeMgr, IN DSP_HNODE *aNodeTab,
 			 OUT u32 *puAllocated)
 {
 	struct NODE_OBJECT *hNode;
-	u32 i;
+	short int i;
 	DSP_STATUS status = DSP_SOK;
 	DBC_Require(cRefs > 0);
 	DBC_Require(aNodeTab != NULL || uNodeTabSize == 0);
@@ -2662,7 +2662,7 @@ static void DeleteNode(struct NODE_OBJECT *hNode,
 	struct NODE_MGR *hNodeMgr;
 	struct CMM_XLATOROBJECT *hXlator;
 	struct WMD_DRV_INTERFACE *pIntfFxns;
-	u32 i;
+	short int i;
 	enum NODE_TYPE nodeType;
 	struct STREAM stream;
 	struct NODE_MSGARGS msgArgs;
@@ -3048,7 +3048,7 @@ static DSP_STATUS GetFxnAddress(struct NODE_OBJECT *hNode, u32 *pulFxnAddr,
  */
 void GetNodeInfo(struct NODE_OBJECT *hNode, struct DSP_NODEINFO *pNodeInfo)
 {
-	u32 i;
+	short int i;
 
 	DBC_Require(MEM_IsValidHandle(hNode, NODE_SIGNATURE));
 	DBC_Require(pNodeInfo != NULL);
diff --git a/drivers/dsp/bridge/services/cfg.c b/drivers/dsp/bridge/services/cfg.c
index 6f55496..213cd54 100644
--- a/drivers/dsp/bridge/services/cfg.c
+++ b/drivers/dsp/bridge/services/cfg.c
@@ -264,7 +264,7 @@ DSP_STATUS CFG_GetHostResources(struct CFG_DEVNODE *hDevNode,
  *  Purpose:
  *      Retrieve the Object handle from the Registry
  */
-DSP_STATUS CFG_GetObject(OUT u32 *pdwValue, u32 dwType)
+DSP_STATUS CFG_GetObject(OUT u32 *pdwValue, short int dwType)
 {
 	DSP_STATUS status = DSP_EINVALIDARG;
 	u32 dwBufSize;
@@ -377,7 +377,7 @@ DSP_STATUS CFG_SetDevObject(struct CFG_DEVNODE *hDevNode, u32 dwValue)
  *  Purpose:
  *      Store the Driver Object handle
  */
-DSP_STATUS CFG_SetObject(u32 dwValue, u32 dwType)
+DSP_STATUS CFG_SetObject(u32 dwValue, short int dwType)
 {
 	DSP_STATUS status = DSP_EINVALIDARG;
 	u32 dwBuffSize;
diff --git a/drivers/dsp/bridge/wmd/chnl_sm.c b/drivers/dsp/bridge/wmd/chnl_sm.c
index ca5662d..82df8d6 100644
--- a/drivers/dsp/bridge/wmd/chnl_sm.c
+++ b/drivers/dsp/bridge/wmd/chnl_sm.c
@@ -97,7 +97,7 @@ DSP_STATUS WMD_CHNL_AddIOReq(struct CHNL_OBJECT *hChnl, void *pHostBuf,
 	DSP_STATUS status = DSP_SOK;
 	struct CHNL_OBJECT *pChnl = (struct CHNL_OBJECT *)hChnl;
 	struct CHNL_IRP *pChirp = NULL;
-	u32 dwState;
+	short int dwState;
 	bool fIsEOS;
 	struct CHNL_MGR *pChnlMgr = pChnl->pChnlMgr;
 	u8 *pHostSysBuf = NULL;
diff --git a/drivers/dsp/bridge/wmd/io_sm.c b/drivers/dsp/bridge/wmd/io_sm.c
index bc2b3e5..6ce08b9 100644
--- a/drivers/dsp/bridge/wmd/io_sm.c
+++ b/drivers/dsp/bridge/wmd/io_sm.c
@@ -136,15 +136,15 @@ struct IO_MGR {
 
 /* Function Prototypes */
 static void IO_DispatchChnl(IN struct IO_MGR *pIOMgr,
-			   IN OUT struct CHNL_OBJECT *pChnl, u32 iMode);
+			   IN OUT struct CHNL_OBJECT *pChnl, short int iMode);
 static void IO_DispatchMsg(IN struct IO_MGR *pIOMgr, struct MSG_MGR *hMsgMgr);
 static void IO_DispatchPM(struct work_struct *work);
 static void NotifyChnlComplete(struct CHNL_OBJECT *pChnl,
 				struct CHNL_IRP *pChirp);
 static void InputChnl(struct IO_MGR *pIOMgr, struct CHNL_OBJECT *pChnl,
-			u32 iMode);
+			short int iMode);
 static void OutputChnl(struct IO_MGR *pIOMgr, struct CHNL_OBJECT *pChnl,
-			u32 iMode);
+			short int iMode);
 static void InputMsg(struct IO_MGR *pIOMgr, struct MSG_MGR *hMsgMgr);
 static void OutputMsg(struct IO_MGR *pIOMgr, struct MSG_MGR *hMsgMgr);
 static u32 FindReadyOutput(struct CHNL_MGR *pChnlMgr,
@@ -359,9 +359,9 @@ DSP_STATUS WMD_IO_OnLoaded(struct IO_MGR *hIOMgr)
 	u32 ulDspVa = 0;
 	u32 ulSegSize = 0;
 	u32 ulPadSize = 0;
-	u32 i;
+	short int i;
 	DSP_STATUS status = DSP_SOK;
-	u32 uNumProcs = 0;
+	short int uNumProcs = 0;
 	s32 ndx = 0;
 	/* DSP MMU setup table */
 	struct WMDIOCTL_EXTPROC aEProc[WMDIOCTL_NUMOFMMUTLB];
@@ -870,7 +870,7 @@ func_end:
  *      Proc-copy chanl dispatch.
  */
 static void IO_DispatchChnl(IN struct IO_MGR *pIOMgr,
-			   IN OUT struct CHNL_OBJECT *pChnl, u32 iMode)
+			   IN OUT struct CHNL_OBJECT *pChnl, short int iMode)
 {
 	if (!MEM_IsValidHandle(pIOMgr, IO_MGRSIGNATURE))
 		goto func_end;
@@ -1082,7 +1082,7 @@ irqreturn_t IO_ISR(int irq, IN void *pRefData)
  *      interrupts the DSP.
  */
 void IO_RequestChnl(struct IO_MGR *pIOMgr, struct CHNL_OBJECT *pChnl,
-		   u32 iMode, OUT u16 *pwMbVal)
+		   short int iMode, OUT u16 *pwMbVal)
 {
 	struct CHNL_MGR *pChnlMgr;
 	struct SHM *sm;
@@ -1183,7 +1183,7 @@ func_end:
  *      Dispatch a buffer on an input channel.
  */
 static void InputChnl(struct IO_MGR *pIOMgr, struct CHNL_OBJECT *pChnl,
-		      u32 iMode)
+		      short int iMode)
 {
 	struct CHNL_MGR *pChnlMgr;
 	struct SHM *sm;
@@ -1310,8 +1310,8 @@ func_end:
  */
 static void InputMsg(struct IO_MGR *pIOMgr, struct MSG_MGR *hMsgMgr)
 {
-	u32 uMsgs;
-	u32 i;
+	short int uMsgs;
+	short int i;
 	u8 *pMsgInput;
 	struct MSG_QUEUE *hMsgQueue;
 	struct MSG_FRAME *pMsg;
@@ -1457,7 +1457,7 @@ func_end:
  *      Dispatch a buffer on an output channel.
  */
 static void OutputChnl(struct IO_MGR *pIOMgr, struct CHNL_OBJECT *pChnl,
-			u32 iMode)
+			short int iMode)
 {
 	struct CHNL_MGR *pChnlMgr;
 	struct SHM *sm;
@@ -1539,8 +1539,8 @@ func_end:
  */
 static void OutputMsg(struct IO_MGR *pIOMgr, struct MSG_MGR *hMsgMgr)
 {
-	u32 uMsgs = 0;
-	u32 i;
+	short int uMsgs = 0;
+	short int i;
 	u8 *pMsgOutput;
 	struct MSG_FRAME *pMsg;
 	struct MSG *pCtrl;
-- 
1.6.0.4

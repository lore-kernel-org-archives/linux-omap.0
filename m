From: "Hebbar, Shivananda" <x0hebbar@ti.com>
Subject: Patch [2/2]: DSPBRIDGE: Execessive u32 Cleanup(u32->int)
Date: Fri, 19 Feb 2010 00:54:12 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044D71B41A@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:40933 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751002Ab0BRTYT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Feb 2010 14:24:19 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id o1IJOFl1019438
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 18 Feb 2010 13:24:17 -0600
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id o1IJOEZk027798
	for <linux-omap@vger.kernel.org>; Fri, 19 Feb 2010 00:54:14 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>

>From 8884e6d372daa1ab2e5d3822ec6aa450ebcd0c47 Mon Sep 17 00:00:00 2001
From: Shivananda Hebbar <x0hebbar@ti.com>
Date: Mon, 1 Feb 2010 15:27:42 -0600
Subject: [PATCH] DSPBRIDGE: Execessive u32 Cleanup(u32->int)

This patch removes execessive u32 types and replaces it
with normal int type.

Signed-off-by: Shivananda Hebbar <x0hebbar@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/cfgdefs.h  |    2 +-
 arch/arm/plat-omap/include/dspbridge/chnlpriv.h |    4 ++--
 arch/arm/plat-omap/include/dspbridge/dbdefs.h   |    2 +-
 arch/arm/plat-omap/include/dspbridge/drv.h      |    2 +-
 arch/arm/plat-omap/include/dspbridge/nodepriv.h |    2 +-
 arch/arm/plat-omap/include/dspbridge/strm.h     |    2 +-
 arch/arm/plat-omap/include/dspbridge/wcdioctl.h |    2 +-
 drivers/dsp/bridge/pmgr/chnl.c                  |    2 +-
 drivers/dsp/bridge/pmgr/cmm.c                   |    2 +-
 drivers/dsp/bridge/pmgr/cod.c                   |    2 +-
 drivers/dsp/bridge/pmgr/dbll.c                  |    4 ++--
 drivers/dsp/bridge/pmgr/dev.c                   |    6 +++---
 drivers/dsp/bridge/pmgr/dmm.c                   |    2 +-
 drivers/dsp/bridge/pmgr/io.c                    |    2 +-
 drivers/dsp/bridge/pmgr/wcd.c                   |    6 +++---
 drivers/dsp/bridge/rmgr/dbdcd.c                 |    4 ++--
 drivers/dsp/bridge/rmgr/disp.c                  |   15 ++++++---------
 drivers/dsp/bridge/rmgr/drv.c                   |    2 +-
 drivers/dsp/bridge/rmgr/drv_interface.c         |    2 +-
 drivers/dsp/bridge/rmgr/mgr.c                   |    2 +-
 drivers/dsp/bridge/rmgr/nldr.c                  |    2 +-
 drivers/dsp/bridge/rmgr/node.c                  |    6 +++---
 drivers/dsp/bridge/rmgr/proc.c                  |    4 ++--
 drivers/dsp/bridge/rmgr/rmm.c                   |    2 +-
 drivers/dsp/bridge/rmgr/strm.c                  |    8 ++++----
 drivers/dsp/bridge/services/mem.c               |    2 +-
 drivers/dsp/bridge/wmd/_tiomap.h                |    2 +-
 drivers/dsp/bridge/wmd/io_sm.c                  |    2 +-
 drivers/dsp/bridge/wmd/msg_sm.c                 |    4 ++--
 29 files changed, 48 insertions(+), 51 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/cfgdefs.h b/arch/arm/plat-omap/include/dspbridge/cfgdefs.h
index 4c612c2..5e8c3c8 100644
--- a/arch/arm/plat-omap/include/dspbridge/cfgdefs.h
+++ b/arch/arm/plat-omap/include/dspbridge/cfgdefs.h
@@ -82,7 +82,7 @@
        } ;

        struct CFG_DSPRES {
-               u32 uChipType;  /* DSP chip type.               */
+               int uChipType;  /* DSP chip type.               */
                u32 uWordSize;  /* Number of bytes in a word    */
                short int cChips;       /* Number of chips.             */
                short int cMemTypes;    /* Types of memory.             */
diff --git a/arch/arm/plat-omap/include/dspbridge/chnlpriv.h b/arch/arm/plat-omap/include/dspbridge/chnlpriv.h
index c7a9b25..fd0ad8f 100644
--- a/arch/arm/plat-omap/include/dspbridge/chnlpriv.h
+++ b/arch/arm/plat-omap/include/dspbridge/chnlpriv.h
@@ -81,8 +81,8 @@
                short int uMode;        /* Channel mode. */
                short int dwState;      /* Current channel state.*/
                u32 cPosition;  /* Total bytes transferred.        */
-               u32 cIOCs;      /* Number of IOCs in queue.               */
-               u32 cIOReqs;    /* Number of IO Requests in queue.        */
+               int cIOCs;      /* Number of IOCs in queue.               */
+               int cIOReqs;    /* Number of IO Requests in queue.        */
                u32 hProcess;   /* Process owning this channel.     */
                /*
                 * Name of channel I/O completion event. Not required in Linux
diff --git a/arch/arm/plat-omap/include/dspbridge/dbdefs.h b/arch/arm/plat-omap/include/dspbridge/dbdefs.h
index fc9fdc8..32a677e 100644
--- a/arch/arm/plat-omap/include/dspbridge/dbdefs.h
+++ b/arch/arm/plat-omap/include/dspbridge/dbdefs.h
@@ -421,7 +421,7 @@
                u32 uClockRate;
                u32 ulInternalMemSize;
                u32 ulExternalMemSize;
-               u32 uProcessorID;
+               int uProcessorID;
                DSP_RTOSTYPE tyRunningRTOS;
                s32 nNodeMinPriority;
                s32 nNodeMaxPriority;
diff --git a/arch/arm/plat-omap/include/dspbridge/drv.h b/arch/arm/plat-omap/include/dspbridge/drv.h
index e4e91f3..03b58ed 100644
--- a/arch/arm/plat-omap/include/dspbridge/drv.h
+++ b/arch/arm/plat-omap/include/dspbridge/drv.h
@@ -261,7 +261,7 @@ struct PROCESS_CONTEXT{
  *      DSP_SOK:        *phDevObject != NULL
  *      DSP_EFAIL:      *phDevObject = NULL
  */
-       extern DSP_STATUS DRV_GetDevObject(u32 uIndex,
+       extern DSP_STATUS DRV_GetDevObject(int uIndex,
                                           struct DRV_OBJECT *hDrvObject,
                                           struct DEV_OBJECT **phDevObject);

diff --git a/arch/arm/plat-omap/include/dspbridge/nodepriv.h b/arch/arm/plat-omap/include/dspbridge/nodepriv.h
index cc74318..67c058c 100644
--- a/arch/arm/plat-omap/include/dspbridge/nodepriv.h
+++ b/arch/arm/plat-omap/include/dspbridge/nodepriv.h
@@ -103,7 +103,7 @@
  */
        extern DSP_STATUS NODE_GetChannelId(struct NODE_OBJECT *hNode,
                                            u32 uDir,
-                                           u32 uIndex, OUT u32 *pulId);
+                                           int uIndex, OUT u32 *pulId);

 /*
  *  ======== NODE_GetStrmMgr ========
diff --git a/arch/arm/plat-omap/include/dspbridge/strm.h b/arch/arm/plat-omap/include/dspbridge/strm.h
index a26abc3..a303b0f 100644
--- a/arch/arm/plat-omap/include/dspbridge/strm.h
+++ b/arch/arm/plat-omap/include/dspbridge/strm.h
@@ -273,7 +273,7 @@
  *      error:          *phStrm == NULL.
  */
        extern DSP_STATUS STRM_Open(struct NODE_OBJECT *hNode, u32 uDir,
-                                   u32 uIndex, IN struct STRM_ATTR *pAttr,
+                                   int uIndex, IN struct STRM_ATTR *pAttr,
                                    OUT struct STRM_OBJECT **phStrm,
                                    struct PROCESS_CONTEXT *pr_ctxt);

diff --git a/arch/arm/plat-omap/include/dspbridge/wcdioctl.h b/arch/arm/plat-omap/include/dspbridge/wcdioctl.h
index 0dcbef7..5efae83 100644
--- a/arch/arm/plat-omap/include/dspbridge/wcdioctl.h
+++ b/arch/arm/plat-omap/include/dspbridge/wcdioctl.h
@@ -305,7 +305,7 @@ union Trapped_Args {
        struct {
                DSP_HNODE hNode;
                u32 uDirection;
-               u32 uIndex;
+               int uIndex;
                struct STRM_ATTR __user *pAttrIn;
                DSP_HSTREAM __user *phStream;
        } ARGS_STRM_OPEN;
diff --git a/drivers/dsp/bridge/pmgr/chnl.c b/drivers/dsp/bridge/pmgr/chnl.c
index fd487f0..4e4e070 100644
--- a/drivers/dsp/bridge/pmgr/chnl.c
+++ b/drivers/dsp/bridge/pmgr/chnl.c
@@ -47,7 +47,7 @@
 #include <dspbridge/chnl.h>

 /*  ----------------------------------- Globals */
-static u32 cRefs;
+static int cRefs;
 #if GT_TRACE
 static struct GT_Mask CHNL_DebugMask = { NULL, NULL }; /* WCD CHNL Mask */
 #endif
diff --git a/drivers/dsp/bridge/pmgr/cmm.c b/drivers/dsp/bridge/pmgr/cmm.c
index 63d1dec..9f2c116 100644
--- a/drivers/dsp/bridge/pmgr/cmm.c
+++ b/drivers/dsp/bridge/pmgr/cmm.c
@@ -149,7 +149,7 @@ struct CMM_MNODE {
 static struct GT_Mask CMM_debugMask = { NULL, NULL };  /* GT trace variable */
 #endif

-static u32 cRefs;              /* module reference count */
+static int cRefs;              /* module reference count */

 /*  ----------------------------------- Function Prototypes */
 static void AddToFreeList(struct CMM_ALLOCATOR *pAllocator,
diff --git a/drivers/dsp/bridge/pmgr/cod.c b/drivers/dsp/bridge/pmgr/cod.c
index bfbe107..28588a7 100644
--- a/drivers/dsp/bridge/pmgr/cod.c
+++ b/drivers/dsp/bridge/pmgr/cod.c
@@ -74,7 +74,7 @@ struct COD_LIBRARYOBJ {
        struct COD_MANAGER *hCodMgr;
 } ;

-static u32 cRefs = 0L;
+static int cRefs;

 #if GT_TRACE
 static struct GT_Mask COD_debugMask = { NULL, NULL };
diff --git a/drivers/dsp/bridge/pmgr/dbll.c b/drivers/dsp/bridge/pmgr/dbll.c
index 5422d21..ed57726 100644
--- a/drivers/dsp/bridge/pmgr/dbll.c
+++ b/drivers/dsp/bridge/pmgr/dbll.c
@@ -134,7 +134,7 @@ struct DBLLInit {
        u32 openRef;            /* Number of times opened */
        u32 loadRef;            /* Number of times loaded */
        struct GH_THashTab *symTab;     /* Hash table of symbols */
-       u32 ulPos;
+       int ulPos;
 } ;

 /*
@@ -203,7 +203,7 @@ static void symDelete(void *sp);
 static struct GT_Mask DBLL_debugMask = { NULL, NULL };  /* GT trace variable */
 #endif

-static u32 cRefs;              /* module reference count */
+static int cRefs;              /* module reference count */

 /* Symbol Redefinition */
 static int bRedefinedSymbol;
diff --git a/drivers/dsp/bridge/pmgr/dev.c b/drivers/dsp/bridge/pmgr/dev.c
index 71fccf5..28a924e 100644
--- a/drivers/dsp/bridge/pmgr/dev.c
+++ b/drivers/dsp/bridge/pmgr/dev.c
@@ -66,7 +66,7 @@
 struct DEV_OBJECT {
        /* LST requires "link" to be first field!                        */
        struct LST_ELEM link;           /* Link to next DEV_OBJECT.      */
-       u32 devType;            /* Device Type */
+       int devType;            /* Device Type */
        u32 dwSignature;        /* Used for object validation.   */
        struct CFG_DEVNODE *hDevNode;   /* Platform specific device id   */
        struct WMD_DEV_CONTEXT *hWmdContext;    /* WMD Context Handle        */
@@ -88,7 +88,7 @@ struct DEV_OBJECT {
 } ;

 /*  ----------------------------------- Globals */
-static u32 cRefs;              /* Module reference count */
+static int cRefs;              /* Module reference count */
 #if GT_TRACE
 static struct GT_Mask debugMask = { NULL, NULL };      /* For debugging */
 #endif
@@ -1262,7 +1262,7 @@ DSP_STATUS DEV_RemoveProcObject(struct DEV_OBJECT *hDevObject,
        return status;
 }

-DSP_STATUS DEV_GetDevType(struct DEV_OBJECT *hdevObject, u32 *devType)
+DSP_STATUS DEV_GetDevType(struct DEV_OBJECT *hdevObject, int *devType)
 {
        DSP_STATUS status = DSP_SOK;
        struct DEV_OBJECT *pDevObject = (struct DEV_OBJECT *)hdevObject;
diff --git a/drivers/dsp/bridge/pmgr/dmm.c b/drivers/dsp/bridge/pmgr/dmm.c
index cefb520..9304c38 100644
--- a/drivers/dsp/bridge/pmgr/dmm.c
+++ b/drivers/dsp/bridge/pmgr/dmm.c
@@ -68,7 +68,7 @@ struct DMM_OBJECT {
 static struct GT_Mask DMM_debugMask = { NULL, NULL };  /* GT trace variable */
 #endif

-static u32 cRefs;              /* module reference count */
+static int cRefs;              /* module reference count */
 struct MapPage {
        u32   RegionSize:15;
        u32   MappedSize:15;
diff --git a/drivers/dsp/bridge/pmgr/io.c b/drivers/dsp/bridge/pmgr/io.c
index 5dbb784..8edab99 100644
--- a/drivers/dsp/bridge/pmgr/io.c
+++ b/drivers/dsp/bridge/pmgr/io.c
@@ -41,7 +41,7 @@
 #include <dspbridge/io.h>

 /*  ----------------------------------- Globals */
-static u32 cRefs;
+static int cRefs;

 #if GT_TRACE
 static struct GT_Mask IO_DebugMask = { NULL, NULL };   /* WCD IO Mask */
diff --git a/drivers/dsp/bridge/pmgr/wcd.c b/drivers/dsp/bridge/pmgr/wcd.c
index 88dc3df..25dbd9e 100644
--- a/drivers/dsp/bridge/pmgr/wcd.c
+++ b/drivers/dsp/bridge/pmgr/wcd.c
@@ -83,7 +83,7 @@ struct WCD_Cmd {
 #if GT_TRACE
 static struct GT_Mask WCD_debugMask = { NULL, NULL };  /* Core VxD Mask */
 #endif
-static u32 WCD_cRefs;
+static int WCD_cRefs;

 /*
  *  Function tables.
@@ -606,8 +606,8 @@ u32 MGRWRAP_WaitForBridgeEvents(union Trapped_Args *args, void *pr_ctxt)
        DSP_STATUS status = DSP_SOK, real_status = DSP_SOK;
        struct DSP_NOTIFICATION *aNotifications[MAX_EVENTS];
        struct DSP_NOTIFICATION notifications[MAX_EVENTS];
-       u32 uIndex, i;
-       u32 uCount = args->ARGS_MGR_WAIT.uCount;
+       int uIndex, i;
+       int uCount = args->ARGS_MGR_WAIT.uCount;

        GT_0trace(WCD_debugMask, GT_ENTER,
                 "MGRWRAP_WaitForBridgeEvents: entered\n");
diff --git a/drivers/dsp/bridge/rmgr/dbdcd.c b/drivers/dsp/bridge/rmgr/dbdcd.c
index 3d50952..1e43be0 100644
--- a/drivers/dsp/bridge/rmgr/dbdcd.c
+++ b/drivers/dsp/bridge/rmgr/dbdcd.c
@@ -64,8 +64,8 @@ struct DCD_MANAGER {
 };

 /* Global reference variables. */
-static u32 cRefs;
-static u32 cEnumRefs;
+static int cRefs;
+static int cEnumRefs;

 extern struct GT_Mask curTrace;

diff --git a/drivers/dsp/bridge/rmgr/disp.c b/drivers/dsp/bridge/rmgr/disp.c
index 949c5e3..03ff8d1 100644
--- a/drivers/dsp/bridge/rmgr/disp.c
+++ b/drivers/dsp/bridge/rmgr/disp.c
@@ -79,7 +79,7 @@ struct DISP_OBJECT {
        u32 uDataMauSize;       /* Size of DSP Data MAU */
 };

-static u32 cRefs;
+static int cRefs;

 /* Debug msgs: */
 #if GT_TRACE
@@ -106,8 +106,7 @@ DSP_STATUS DISP_Create(OUT struct DISP_OBJECT **phDispObject,
        u32 ulChnlId;
        struct CHNL_ATTRS chnlAttrs;
        DSP_STATUS status = DSP_SOK;
-       u32 devType;
-
+       int devType;
        DBC_Require(cRefs > 0);
        DBC_Require(phDispObject != NULL);
        DBC_Require(pDispAttrs != NULL);
@@ -324,7 +323,7 @@ DSP_STATUS DISP_NodeCreate(struct DISP_OBJECT *hDisp, struct NODE_OBJECT *hNode,
        u32 dwLength;
        RMS_WORD *pdwBuf = NULL;
        u32 ulBytes;
-       u32 i;
+       int i;
        u32 total;
        u32 uCharsInRMSWord;
        s32 taskArgsOffset;
@@ -337,7 +336,7 @@ DSP_STATUS DISP_NodeCreate(struct DISP_OBJECT *hDisp, struct NODE_OBJECT *hNode,
        u32 max;
        DSP_STATUS status = DSP_SOK;
        struct DSP_NODEINFO nodeInfo;
-       u32 devType;
+       int devType;

        DBC_Require(cRefs > 0);
        DBC_Require(MEM_IsValidHandle(hDisp, DISP_SIGNATURE));
@@ -575,12 +574,10 @@ DSP_STATUS DISP_NodeDelete(struct DISP_OBJECT *hDisp, struct NODE_OBJECT *hNode,
        u32 dwArg;
        struct RMS_Command *pCommand;
        DSP_STATUS status = DSP_SOK;
-       u32 devType;
-
+       int devType;
        DBC_Require(cRefs > 0);
        DBC_Require(MEM_IsValidHandle(hDisp, DISP_SIGNATURE));
        DBC_Require(hNode != NULL);
-
        GT_5trace(DISP_DebugMask, GT_ENTER,
                 "DISP_NodeDelete: hDisp: 0x%xthNode: "
                 "0x%x\tulRMSFxn: 0x%x\tulDeleteFxn: 0x%x\tnodeEnv: 0x%x\n",
@@ -640,7 +637,7 @@ DSP_STATUS DISP_NodeRun(struct DISP_OBJECT *hDisp, struct NODE_OBJECT *hNode,
        u32 dwArg;
        struct RMS_Command *pCommand;
        DSP_STATUS status = DSP_SOK;
-       u32 devType;
+       int devType;
        DBC_Require(cRefs > 0);
        DBC_Require(MEM_IsValidHandle(hDisp, DISP_SIGNATURE));
        DBC_Require(hNode != NULL);
diff --git a/drivers/dsp/bridge/rmgr/drv.c b/drivers/dsp/bridge/rmgr/drv.c
index 96314a2..b47181a 100644
--- a/drivers/dsp/bridge/rmgr/drv.c
+++ b/drivers/dsp/bridge/rmgr/drv.c
@@ -718,7 +718,7 @@ DSP_STATUS DRV_GetDevObject(u32 uIndex, struct DRV_OBJECT *hDrvObject,
        struct DRV_OBJECT *pDrvObject = (struct DRV_OBJECT *)hDrvObject;
 #endif
        struct DEV_OBJECT *pDevObject;
-       u32 i;
+       int i;
        DBC_Require(MEM_IsValidHandle(pDrvObject, SIGNATURE));
        DBC_Require(phDevObject != NULL);
        DBC_Require(uIndex >= 0);
diff --git a/drivers/dsp/bridge/rmgr/drv_interface.c b/drivers/dsp/bridge/rmgr/drv_interface.c
index 301aea1..663a75f 100644
--- a/drivers/dsp/bridge/rmgr/drv_interface.c
+++ b/drivers/dsp/bridge/rmgr/drv_interface.c
@@ -587,7 +587,7 @@ static int bridge_mmap(struct file *filp, struct vm_area_struct *vma)
 #if GT_TRACE
        u32 offset = vma->vm_pgoff << PAGE_SHIFT;
 #endif
-       u32 status;
+       int status;

        DBC_Assert(vma->vm_start < vma->vm_end);

diff --git a/drivers/dsp/bridge/rmgr/mgr.c b/drivers/dsp/bridge/rmgr/mgr.c
index 120657f..e749fbc 100644
--- a/drivers/dsp/bridge/rmgr/mgr.c
+++ b/drivers/dsp/bridge/rmgr/mgr.c
@@ -54,7 +54,7 @@ struct MGR_OBJECT {
 static struct GT_Mask MGR_DebugMask = { NULL, NULL };
 #endif

-static u32 cRefs;
+static int cRefs;

 /*
  *  ========= MGR_Create =========
diff --git a/drivers/dsp/bridge/rmgr/nldr.c b/drivers/dsp/bridge/rmgr/nldr.c
index 4d38419..05213e3 100644
--- a/drivers/dsp/bridge/rmgr/nldr.c
+++ b/drivers/dsp/bridge/rmgr/nldr.c
@@ -293,7 +293,7 @@ static struct DBLL_Fxns dbllFxns = {
 };

 static struct GT_Mask NLDR_debugMask = { NULL, NULL }; /* GT trace variable */
-static u32 cRefs;              /* module reference count */
+static int cRefs;              /* module reference count */

 static DSP_STATUS AddOvlyInfo(void *handle, struct DBLL_SectInfo *sectInfo,
                             u32 addr, u32 nBytes);
diff --git a/drivers/dsp/bridge/rmgr/node.c b/drivers/dsp/bridge/rmgr/node.c
index a380766..387e964 100644
--- a/drivers/dsp/bridge/rmgr/node.c
+++ b/drivers/dsp/bridge/rmgr/node.c
@@ -276,7 +276,7 @@ static struct GT_Mask NODE_debugMask = { NULL, NULL };  /* GT trace variable */
 extern u32 DMM_MemMapDump(struct DMM_OBJECT *hDmmMgr);
 #endif

-static u32 cRefs;              /* module reference count */
+static int cRefs;              /* module reference count */

 /* Dynamic loader functions. */
 static struct NLDR_FXNS nldrFxns = {
@@ -1369,7 +1369,7 @@ DSP_STATUS NODE_CreateMgr(OUT struct NODE_MGR **phNodeMgr,
        char *szZLFile = "";
        struct NLDR_ATTRS nldrAttrs;
        DSP_STATUS status = DSP_SOK;
-       u32 devType;
+       int devType;
        DBC_Require(cRefs > 0);
        DBC_Require(phNodeMgr != NULL);
        DBC_Require(hDevObject != NULL);
@@ -1850,7 +1850,7 @@ DSP_STATUS NODE_GetAttr(struct NODE_OBJECT *hNode,
  *      Get the channel index reserved for a stream connection between the
  *      host and a node.
  */
-DSP_STATUS NODE_GetChannelId(struct NODE_OBJECT *hNode, u32 uDir, u32 uIndex,
+DSP_STATUS NODE_GetChannelId(struct NODE_OBJECT *hNode, u32 uDir, int uIndex,
                            OUT u32 *pulId)
 {
        enum NODE_TYPE nodeType;
diff --git a/drivers/dsp/bridge/rmgr/proc.c b/drivers/dsp/bridge/rmgr/proc.c
index cd32561..f01ec99 100644
--- a/drivers/dsp/bridge/rmgr/proc.c
+++ b/drivers/dsp/bridge/rmgr/proc.c
@@ -101,7 +101,7 @@ struct PROC_OBJECT {
        struct list_head proc_object;
 };

-static u32 cRefs;
+static int cRefs;

 struct SYNC_CSOBJECT *hProcLock;       /* For critical sections */

@@ -126,7 +126,7 @@ PROC_Attach(u32 uProcessor, OPTIONAL CONST struct DSP_PROCESSORATTRIN *pAttrIn,
        struct PROC_OBJECT *pProcObject = NULL;
        struct MGR_OBJECT *hMgrObject = NULL;
        struct DRV_OBJECT *hDrvObject = NULL;
-       u32 devType;
+       int devType;

        DBC_Require(cRefs > 0);
        DBC_Require(phProcessor != NULL);
diff --git a/drivers/dsp/bridge/rmgr/rmm.c b/drivers/dsp/bridge/rmgr/rmm.c
index 43f78f0..86a2a43 100644
--- a/drivers/dsp/bridge/rmgr/rmm.c
+++ b/drivers/dsp/bridge/rmgr/rmm.c
@@ -91,7 +91,7 @@ struct RMM_TargetObj {
 static struct GT_Mask RMM_debugMask = { NULL, NULL };  /* GT trace variable */
 #endif

-static u32 cRefs;              /* module reference count */
+static int cRefs;              /* module reference count */

 static bool allocBlock(struct RMM_TargetObj *target, u32 segid, u32 size,
                      u32 align, u32 *dspAddr);
diff --git a/drivers/dsp/bridge/rmgr/strm.c b/drivers/dsp/bridge/rmgr/strm.c
index febb6c2..330c219 100644
--- a/drivers/dsp/bridge/rmgr/strm.c
+++ b/drivers/dsp/bridge/rmgr/strm.c
@@ -96,7 +96,7 @@ struct STRM_MGR {
 #if GT_TRACE
 static struct GT_Mask STRM_debugMask = { NULL, NULL }; /* GT trace variable */
 #endif
-static u32 cRefs;              /* module reference count */
+static int cRefs;              /* module reference count */

 /*  ----------------------------------- Function Prototypes */
 static DSP_STATUS DeleteStrm(struct STRM_OBJECT *hStrm);
@@ -113,7 +113,7 @@ DSP_STATUS STRM_AllocateBuffer(struct STRM_OBJECT *hStrm, u32 uSize,
 {
        DSP_STATUS status = DSP_SOK;
        u32 uAllocated = 0;
-       u32 i;
+       int i;
 #ifndef RES_CLEANUP_DISABLE
        HANDLE hSTRMRes;
 #endif
@@ -515,7 +515,7 @@ DSP_STATUS STRM_Issue(struct STRM_OBJECT *hStrm, IN u8 *pBuf, u32 ulBytes,
  *      Open a stream for sending/receiving data buffers to/from a task or
  *      XDAIS socket node on the DSP.
  */
-DSP_STATUS STRM_Open(struct NODE_OBJECT *hNode, u32 uDir, u32 uIndex,
+DSP_STATUS STRM_Open(struct NODE_OBJECT *hNode, u32 uDir, int uIndex,
                IN struct STRM_ATTR *pAttr,
                OUT struct STRM_OBJECT **phStrm,
                struct PROCESS_CONTEXT *pr_ctxt)
@@ -815,7 +815,7 @@ DSP_STATUS STRM_RegisterNotify(struct STRM_OBJECT *hStrm, u32 uEventMask,
 DSP_STATUS STRM_Select(IN struct STRM_OBJECT **aStrmTab, u32 nStrms,
                      OUT u32 *pMask, u32 uTimeout)
 {
-       u32 uIndex;
+       int uIndex;
        struct CHNL_INFO chnlInfo;
        struct WMD_DRV_INTERFACE *pIntfFxns;
        struct SYNC_OBJECT **hSyncEvents = NULL;
diff --git a/drivers/dsp/bridge/services/mem.c b/drivers/dsp/bridge/services/mem.c
index 2aff2d2..ac6246c 100644
--- a/drivers/dsp/bridge/services/mem.c
+++ b/drivers/dsp/bridge/services/mem.c
@@ -45,7 +45,7 @@
 static struct GT_Mask MEM_debugMask = { NULL, NULL };  /* GT trace variable */
 #endif

-static u32 cRefs;              /* module reference count */
+static int cRefs;              /* module reference count */

 static bool extPhysMemPoolEnabled;

diff --git a/drivers/dsp/bridge/wmd/_tiomap.h b/drivers/dsp/bridge/wmd/_tiomap.h
index 343c894..3e0ac3a 100644
--- a/drivers/dsp/bridge/wmd/_tiomap.h
+++ b/drivers/dsp/bridge/wmd/_tiomap.h
@@ -353,7 +353,7 @@ struct WMD_DEV_CONTEXT {
         */
        /* DMMU TLB entries */
        struct WMDIOCTL_EXTPROC aTLBEntry[WMDIOCTL_NUMOFMMUTLB];
-       u32 dwBrdState;                 /* Last known board state. */
+       int dwBrdState;                 /* Last known board state. */
        u32 ulIntMask;                  /* int mask */
        u16 ioBase;                     /* Board I/O base */
        u32 numTLBEntries;              /* DSP MMU TLB entry counter */
diff --git a/drivers/dsp/bridge/wmd/io_sm.c b/drivers/dsp/bridge/wmd/io_sm.c
index 6ce08b9..7458d8e 100644
--- a/drivers/dsp/bridge/wmd/io_sm.c
+++ b/drivers/dsp/bridge/wmd/io_sm.c
@@ -183,7 +183,7 @@ DSP_STATUS WMD_IO_Create(OUT struct IO_MGR **phIOMgr,
        struct CFG_DEVNODE *hDevNode;
        struct CHNL_MGR *hChnlMgr;
        static int ref_count;
-       u32 devType;
+       int devType;
        /* Check requirements */
        if (!phIOMgr || !pMgrAttrs || pMgrAttrs->uWordSize == 0) {
                status = DSP_EHANDLE;
diff --git a/drivers/dsp/bridge/wmd/msg_sm.c b/drivers/dsp/bridge/wmd/msg_sm.c
index a323310..07114b4 100644
--- a/drivers/dsp/bridge/wmd/msg_sm.c
+++ b/drivers/dsp/bridge/wmd/msg_sm.c
@@ -262,7 +262,7 @@ DSP_STATUS WMD_MSG_Get(struct MSG_QUEUE *hMsgQueue,
        struct MSG_MGR *hMsgMgr;
        bool fGotMsg = false;
        struct SYNC_OBJECT *hSyncs[2];
-       u32 uIndex;
+       int uIndex;
        DSP_STATUS status = DSP_SOK;

        if (!MEM_IsValidHandle(hMsgQueue, MSGQ_SIGNATURE) || pMsg == NULL) {
@@ -364,7 +364,7 @@ DSP_STATUS WMD_MSG_Put(struct MSG_QUEUE *hMsgQueue,
        struct MSG_MGR *hMsgMgr;
        bool fPutMsg = false;
        struct SYNC_OBJECT *hSyncs[2];
-       u32 uIndex;
+       int uIndex;
        DSP_STATUS status = DSP_SOK;

        if (!MEM_IsValidHandle(hMsgQueue, MSGQ_SIGNATURE) || !pMsg ||
--
1.6.0.4

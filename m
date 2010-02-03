From: "Hebbar, Shivananda" <x0hebbar@ti.com>
Subject: [Patch 6/8] DSPBRIDGE: typedef cleanup -DSP_HNODE
Date: Wed, 3 Feb 2010 06:14:04 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044A6B9676@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:58351 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756056Ab0BCAoK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Feb 2010 19:44:10 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id o130i7r8005124
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 2 Feb 2010 18:44:09 -0600
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id o130i6Pl009257
	for <linux-omap@vger.kernel.org>; Wed, 3 Feb 2010 06:14:06 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>

>From b90284e0c81aa983ee60ce1fee8d69beba4061a6 Mon Sep 17 00:00:00 2001
From: Shivananda Hebbar <x0hebbar@ti.com>
Date: Thu, 28 Jan 2010 20:22:04 -0600
Subject: [PATCH] DSPBRIDGE: Remove typedef for the node handle and replace it with the C normal type.

Signed-off-by: Shivananda Hebbar <x0hebbar@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/dbdefs.h   |    6 +---
 arch/arm/plat-omap/include/dspbridge/drv.h      |    2 +-
 arch/arm/plat-omap/include/dspbridge/node.h     |    2 +-
 arch/arm/plat-omap/include/dspbridge/proc.h     |    2 +-
 arch/arm/plat-omap/include/dspbridge/wcdioctl.h |   34 +++++++++++-----------
 drivers/dsp/bridge/pmgr/wcd.c                   |    2 +-
 drivers/dsp/bridge/rmgr/node.c                  |    4 +-
 drivers/dsp/bridge/rmgr/proc.c                  |    4 +-
 8 files changed, 27 insertions(+), 29 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/dbdefs.h b/arch/arm/plat-omap/include/dspbridge/dbdefs.h
index e3be0fc..472b62f 100644
--- a/arch/arm/plat-omap/include/dspbridge/dbdefs.h
+++ b/arch/arm/plat-omap/include/dspbridge/dbdefs.h
@@ -109,8 +109,6 @@
 /* Types defined for 'Bridge API */
  typedef u32 DSP_STATUS; /* API return code type         */
 
- typedef HANDLE DSP_HNODE; /* Handle to a DSP Node object  */
-
 /* Handy Macros */
 #define IsValidProcEvent(x) (((x) == 0) || (((x) & (DSP_PROCESSORSTATECHANGE | \
         DSP_PROCESSORATTACH | \
@@ -318,7 +316,7 @@
   u32 cbStruct;
   enum DSP_CONNECTTYPE lType;
   u32 uThisNodeStreamIndex;
-  DSP_HNODE hConnectedNode;
+  void *hConnectedNode;
   struct DSP_UUID uiConnectedNodeID;
   u32 uConnectedNodeStreamIndex;
  } ;
@@ -368,7 +366,7 @@
   struct DSP_NDBPROPS nbNodeDatabaseProps;
   u32 uExecutionPriority;
   enum NODE_STATE nsExecutionState;
-  DSP_HNODE hDeviceOwner;
+  void *hDeviceOwner;
   u32 uNumberStreams;
   struct DSP_STREAMCONNECT scStreamConnection[16];
   u32 uNodeEnv;
diff --git a/arch/arm/plat-omap/include/dspbridge/drv.h b/arch/arm/plat-omap/include/dspbridge/drv.h
index c6d4626..b31c8e3 100644
--- a/arch/arm/plat-omap/include/dspbridge/drv.h
+++ b/arch/arm/plat-omap/include/dspbridge/drv.h
@@ -84,7 +84,7 @@
 
 /* New structure (member of process context) abstracts NODE resource info */  struct NODE_RES_OBJECT {
- DSP_HNODE       hNode;
+ void *hNode;
  s32            nodeAllocated; /* Node status */
  s32            heapAllocated; /* Heap status */
  s32            streamsAllocated; /* Streams status */
diff --git a/arch/arm/plat-omap/include/dspbridge/node.h b/arch/arm/plat-omap/include/dspbridge/node.h
index 9f0110a..2a45fc0 100644
--- a/arch/arm/plat-omap/include/dspbridge/node.h
+++ b/arch/arm/plat-omap/include/dspbridge/node.h
@@ -308,7 +308,7 @@
  *        (*puAllocated == *puNumNodes)
  */
  extern DSP_STATUS NODE_EnumNodes(struct NODE_MGR *hNodeMgr,
-      IN DSP_HNODE *aNodeTab,
+      void **aNodeTab,
       u32 uNodeTabSize,
       OUT u32 *puNumNodes,
       OUT u32 *puAllocated);
diff --git a/arch/arm/plat-omap/include/dspbridge/proc.h b/arch/arm/plat-omap/include/dspbridge/proc.h
index bbb089e..d5edbd5 100644
--- a/arch/arm/plat-omap/include/dspbridge/proc.h
+++ b/arch/arm/plat-omap/include/dspbridge/proc.h
@@ -153,7 +153,7 @@
  *  Details:
  */
  extern DSP_STATUS PROC_EnumNodes(void *hProcessor,
-      IN DSP_HNODE *aNodeTab,
+      void **aNodeTab,
       IN u32 uNodeTabSize,
       OUT u32 *puNumNodes,
       OUT u32 *puAllocated);
diff --git a/arch/arm/plat-omap/include/dspbridge/wcdioctl.h b/arch/arm/plat-omap/include/dspbridge/wcdioctl.h
index 4f5a274..eccda18 100644
--- a/arch/arm/plat-omap/include/dspbridge/wcdioctl.h
+++ b/arch/arm/plat-omap/include/dspbridge/wcdioctl.h
@@ -79,7 +79,7 @@ union Trapped_Args {
 
  struct {
   void *hProcessor;
-  DSP_HNODE __user *aNodeTab;
+  void *__user *aNodeTab;
   u32 uNodeTabSize;
   u32 __user *puNumNodes;
   u32 __user *puAllocated;
@@ -177,79 +177,79 @@ union Trapped_Args {
   struct DSP_UUID __user *pNodeID;
   struct DSP_CBDATA __user *pArgs;
   struct DSP_NODEATTRIN __user *pAttrIn;
-  DSP_HNODE __user *phNode;
+  void *__user *phNode;
  } ARGS_NODE_ALLOCATE;
 
  struct {
-  DSP_HNODE hNode;
+  void *hNode;
   u32 uSize;
   struct DSP_BUFFERATTR __user *pAttr;
   u8 *__user *pBuffer;
  } ARGS_NODE_ALLOCMSGBUF;
 
  struct {
-  DSP_HNODE hNode;
+  void *hNode;
   s32 iPriority;
  } ARGS_NODE_CHANGEPRIORITY;
 
  struct {
-  DSP_HNODE hNode;
+  void *hNode;
   u32 uStream;
-  DSP_HNODE hOtherNode;
+  void *hOtherNode;
   u32 uOtherStream;
   struct DSP_STRMATTR __user *pAttrs;
   struct DSP_CBDATA __user *pConnParam;
  } ARGS_NODE_CONNECT;
 
  struct {
-  DSP_HNODE hNode;
+  void *hNode;
  } ARGS_NODE_CREATE;
 
  struct {
-  DSP_HNODE hNode;
+  void *hNode;
  } ARGS_NODE_DELETE;
 
  struct {
-  DSP_HNODE hNode;
+  void *hNode;
   struct DSP_BUFFERATTR __user *pAttr;
   u8 *pBuffer;
  } ARGS_NODE_FREEMSGBUF;
 
  struct {
-  DSP_HNODE hNode;
+  void *hNode;
   struct DSP_NODEATTR __user *pAttr;
   u32 uAttrSize;
  } ARGS_NODE_GETATTR;
 
  struct {
-  DSP_HNODE hNode;
+  void *hNode;
   struct DSP_MSG __user *pMessage;
   u32 uTimeout;
  } ARGS_NODE_GETMESSAGE;
 
  struct {
-  DSP_HNODE hNode;
+  void *hNode;
  } ARGS_NODE_PAUSE;
 
  struct {
-  DSP_HNODE hNode;
+  void *hNode;
   struct DSP_MSG __user *pMessage;
   u32 uTimeout;
  } ARGS_NODE_PUTMESSAGE;
 
  struct {
-  DSP_HNODE hNode;
+  void *hNode;
   u32 uEventMask;
   u32 uNotifyType;
   struct DSP_NOTIFICATION __user *hNotification;
  } ARGS_NODE_REGISTERNOTIFY;
 
  struct {
-  DSP_HNODE hNode;
+  void *hNode;
  } ARGS_NODE_RUN;
 
  struct {
-  DSP_HNODE hNode;
+  void *hNode;
   DSP_STATUS __user *pStatus;
  } ARGS_NODE_TERMINATE;
 
@@ -303,7 +303,7 @@ union Trapped_Args {
  } ARGS_STRM_ISSUE;
 
  struct {
-  DSP_HNODE hNode;
+  void *hNode;
   u32 uDirection;
   u32 uIndex;
   struct STRM_ATTR __user *pAttrIn;
diff --git a/drivers/dsp/bridge/pmgr/wcd.c b/drivers/dsp/bridge/pmgr/wcd.c index fa4ba47..f31cc4b 100644
--- a/drivers/dsp/bridge/pmgr/wcd.c
+++ b/drivers/dsp/bridge/pmgr/wcd.c
@@ -740,7 +740,7 @@ u32 __deprecated PROCWRAP_Detach(union Trapped_Args *args, void *pr_ctxt)
 u32 PROCWRAP_EnumNode_Info(union Trapped_Args *args, void *pr_ctxt)  {
  DSP_STATUS status;
- DSP_HNODE aNodeTab[MAX_NODES];
+ void *aNodeTab[MAX_NODES];
  u32 uNumNodes;
  u32 uAllocated;
 
diff --git a/drivers/dsp/bridge/rmgr/node.c b/drivers/dsp/bridge/rmgr/node.c index aa2a687..812099c 100644
--- a/drivers/dsp/bridge/rmgr/node.c
+++ b/drivers/dsp/bridge/rmgr/node.c
@@ -218,7 +218,7 @@ struct NODE_OBJECT {
  s32 nExitStatus; /* execute function return status */
 
  /* Information needed for NODE_GetAttr() */
- DSP_HNODE hDeviceOwner; /* If dev node, task that owns it */
+ void *hDeviceOwner; /* If dev node, task that owns it */
  u32 uNumGPPInputs; /* Current # of from GPP streams */
  u32 uNumGPPOutputs; /* Current # of to GPP streams */
  /* Current stream connections */
@@ -1690,7 +1690,7 @@ DSP_STATUS NODE_DeleteMgr(struct NODE_MGR *hNodeMgr)
  *  Purpose:
  *      Enumerate currently allocated nodes.
  */
-DSP_STATUS NODE_EnumNodes(struct NODE_MGR *hNodeMgr, IN DSP_HNODE *aNodeTab,
+DSP_STATUS NODE_EnumNodes(struct NODE_MGR *hNodeMgr, void **aNodeTab,
     u32 uNodeTabSize, OUT u32 *puNumNodes,
     OUT u32 *puAllocated)
 {
diff --git a/drivers/dsp/bridge/rmgr/proc.c b/drivers/dsp/bridge/rmgr/proc.c index ae2364a..439dbe8 100644
--- a/drivers/dsp/bridge/rmgr/proc.c
+++ b/drivers/dsp/bridge/rmgr/proc.c
@@ -532,7 +532,7 @@ DSP_STATUS PROC_Detach(struct PROCESS_CONTEXT *pr_ctxt)
  *      Enumerate and get configuration information about nodes allocated
  *      on a DSP processor.
  */
-DSP_STATUS PROC_EnumNodes(void *hProcessor, OUT DSP_HNODE *aNodeTab,
+DSP_STATUS PROC_EnumNodes(void *hProcessor, void **aNodeTab,
   IN u32 uNodeTabSize, OUT u32 *puNumNodes,
   OUT u32 *puAllocated)
 {
@@ -1534,7 +1534,7 @@ DSP_STATUS PROC_Stop(void *hProcessor)
  struct PROC_OBJECT *pProcObject = (struct PROC_OBJECT *)hProcessor;
  struct MSG_MGR *hMsgMgr;
  struct NODE_MGR *hNodeMgr;
- DSP_HNODE hNode;
+ void *hNode;
  u32 uNodeTabSize = 1;
  u32 uNumNodes = 0;
  u32 uNodesAllocated = 0;
--
1.6.0.4

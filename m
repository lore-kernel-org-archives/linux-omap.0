From: "Ramirez Luna, Omar" <x00omar@ti.com>
Subject: [PATCH 02/06][omapzoom] BRIDGE: Sparse warnings cleanup
Date: Fri, 19 Sep 2008 21:07:09 -0500
Message-ID: <27F9C60D11D683428E133F85D2BB4A5344B3DCD4@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:49581 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752719AbYITCHQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Sep 2008 22:07:16 -0400
Received: from dlep95.itg.ti.com ([157.170.170.107])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id m8K27AJw018608
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 19 Sep 2008 21:07:15 -0500
Received: from dlee74.ent.ti.com (localhost [127.0.0.1])
	by dlep95.itg.ti.com (8.13.8/8.13.8) with ESMTP id m8K27Afq016165
	for <linux-omap@vger.kernel.org>; Fri, 19 Sep 2008 21:07:10 -0500 (CDT)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pandita, Vikram" <vikram.pandita@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

From: Fernando Guzman Lugo <x0095840@ti.com>
Date: Fri, 19 Sep 2008 11:25:36 -0500
Subject: [PATCH] BRIDGE: Sparse warnings cleanup

This patch removes some sparse warnings about the following:

Different Node enum type, static variables, __user references,
unused variable in drv_interface.c, DRV object incompatible types

Signed-off-by: Fernando Guzman Lugo <x0095840@ti.com>
---
 arch/arm/plat-omap/include/mach/bridge/dbdefs.h   |   30 +++++++++++++-----
 arch/arm/plat-omap/include/mach/bridge/kfile.h    |    2 +-
 arch/arm/plat-omap/include/mach/bridge/nodepriv.h |   35 ---------------------
 drivers/dsp/bridge/rmgr/drv_interface.c           |   18 +++--------
 drivers/dsp/bridge/rmgr/dspdrv.c                  |    4 +-
 drivers/dsp/bridge/rmgr/proc.c                    |    4 +-
 drivers/dsp/bridge/services/kfile.c               |    3 +-
 drivers/dsp/bridge/services/mem.c                 |    2 +-
 drivers/dsp/bridge/wmd/tiomap3430.c               |    1 -
 9 files changed, 35 insertions(+), 64 deletions(-)

diff --git a/arch/arm/plat-omap/include/mach/bridge/dbdefs.h b/arch/arm/plat-omap/include/mach/bridge/dbdefs.h
index e92c24f..b8350ec 100644
--- a/arch/arm/plat-omap/include/mach/bridge/dbdefs.h
+++ b/arch/arm/plat-omap/include/mach/bridge/dbdefs.h
@@ -225,21 +225,35 @@
 		PROC_ERROR
 	} ;
 
-/* Node types */
-	enum DSP_NODETYPE {
+/*
+ *  Node types: Message node, task node, xDAIS socket node, and
+ *  device node. _NODE_GPP is used when defining a stream connection
+ *  between a task or socket node and the GPP.
+ *
+ */
+	enum NODE_TYPE {
 		NODE_DEVICE,
 		NODE_TASK,
 		NODE_DAISSOCKET,
-		NODE_MESSAGE
+		NODE_MESSAGE,
+		NODE_GPP
 	} ;
 
-/* Node states */
-	enum DSP_NODESTATE {
+/*
+ *  ======== NODE_STATE ========
+ *  Internal node states.
+ */
+	enum NODE_STATE {
 		NODE_ALLOCATED,
 		NODE_CREATED,
 		NODE_RUNNING,
 		NODE_PAUSED,
-		NODE_DONE
+		NODE_DONE,
+		NODE_CREATING,
+		NODE_STARTING,
+		NODE_PAUSING,
+		NODE_TERMINATING,
+		NODE_DELETING,
 	} ;
 
 /* Stream states */
@@ -370,7 +384,7 @@
 		u32 cbStruct;
 		struct DSP_UUID uiNodeID;
 		char acName[DSP_MAXNAMELEN];
-		enum DSP_NODETYPE uNodeType;
+		enum NODE_TYPE uNodeType;
 		u32 bCacheOnGPP;
 		struct DSP_RESOURCEREQMTS dspResourceReqmts;
 		s32 iPriority;
@@ -405,7 +419,7 @@
 		u32 cbStruct;
 		struct DSP_NDBPROPS nbNodeDatabaseProps;
 		u32 uExecutionPriority;
-		enum DSP_NODESTATE nsExecutionState;
+		enum NODE_STATE nsExecutionState;
 		DSP_HNODE hDeviceOwner;
 		u32 uNumberStreams;
 		struct DSP_STREAMCONNECT scStreamConnection[16];
diff --git a/arch/arm/plat-omap/include/mach/bridge/kfile.h b/arch/arm/plat-omap/include/mach/bridge/kfile.h
index f5fe88a..9a741be 100644
--- a/arch/arm/plat-omap/include/mach/bridge/kfile.h
+++ b/arch/arm/plat-omap/include/mach/bridge/kfile.h
@@ -143,7 +143,7 @@
  *      pBuffer is a valid pointer.
  *  Ensures:
  */
-	extern s32 KFILE_Read(OUT void *buffer,
+	extern s32 KFILE_Read(OUT void __user*buffer,
 			      IN s32 size, IN s32 count,
 			      IN struct KFILE_FileObj *hFile);
 
diff --git a/arch/arm/plat-omap/include/mach/bridge/nodepriv.h b/arch/arm/plat-omap/include/mach/bridge/nodepriv.h
index 51cf0bc..0e8d909 100644
--- a/arch/arm/plat-omap/include/mach/bridge/nodepriv.h
+++ b/arch/arm/plat-omap/include/mach/bridge/nodepriv.h
@@ -97,41 +97,6 @@
 	} ;
 
 /*
- *  Node types: Message node, task node, xDAIS socket node, and
- *  device node. _NODE_GPP is used when defining a stream connection
- *  between a task or socket node and the GPP.
- *
- *  ~~~~~~~~~~~~~~
- *  TO DO:
- *  Clean up when Node Manager uses only one critical section.
- *  ~~~~~~~~~~~~~~
- */
-	enum NODE_TYPE {
-		_NODE_DEVICE = NODE_DEVICE,
-		_NODE_TASK = NODE_TASK,
-		_NODE_DAISSOCKET = NODE_DAISSOCKET,
-		_NODE_MESSAGE = NODE_MESSAGE,
-		NODE_GPP
-	} ;
-
-/*
- *  ======== NODE_STATE ========
- *  Internal node states.
- */
-	enum NODE_STATE {
-		_NODE_ALLOCATED = NODE_ALLOCATED,
-		_NODE_CREATED = NODE_CREATED,
-		_NODE_RUNNING = NODE_RUNNING,
-		_NODE_PAUSED = NODE_PAUSED,
-		_NODE_DONE = NODE_DONE,
-		NODE_CREATING,
-		NODE_STARTING,
-		NODE_PAUSING,
-		NODE_TERMINATING,
-		NODE_DELETING,
-	} ;
-
-/*
  *  ======== NODE_GetChannelId ========
  *  Purpose:
  *      Get the channel index reserved for a stream connection between the
diff --git a/drivers/dsp/bridge/rmgr/drv_interface.c b/drivers/dsp/bridge/rmgr/drv_interface.c
index e17ee70..e3dd595 100644
--- a/drivers/dsp/bridge/rmgr/drv_interface.c
+++ b/drivers/dsp/bridge/rmgr/drv_interface.c
@@ -164,8 +164,8 @@ struct omap34xx_bridge_suspend_data {
 
 static struct omap34xx_bridge_suspend_data bridge_suspend_data;
 
-int omap34xxbridge_suspend_lockout(struct omap34xx_bridge_suspend_data *s,
-				  struct file *f)
+static int omap34xxbridge_suspend_lockout(
+		struct omap34xx_bridge_suspend_data *s, struct file *f)
 {
 	if ((s)->suspended) {
 		if ((f)->f_flags & O_NONBLOCK)
@@ -227,7 +227,7 @@ static struct file_operations bridge_fops = {
 };
 
 #ifndef CONFIG_DISABLE_BRIDGE_PM
-u32 timeOut = 1000;
+static u32 timeOut = 1000;
 
 static int bridge_suspend(struct platform_device *pdev, pm_message_t state);
 static int bridge_resume(struct platform_device *pdev);
@@ -354,9 +354,6 @@ static int __init bridge_init(void)
 	u32 temp;
 	dev_t   dev = 0 ;
 	int     result;
-#ifndef CONFIG_OMAP3_PM
-	u32 retvalue = 0;
-#endif
 
 	/* use 2.6 device model */
 	if (driver_major) {
@@ -510,8 +507,7 @@ static int __init bridge_init(void)
 			GT_0trace(driverTrace, GT_7CLASS,
 			"clk_get PASS to get iva2_ck \n");
 		}
-		retvalue = clk_notifier_register(clk_handle, &iva_clk_notifier);
-		if (!retvalue) {
+		if (!clk_notifier_register(clk_handle, &iva_clk_notifier)) {
 			GT_0trace(driverTrace, GT_7CLASS,
 			"clk_notifier_register PASS for iva2_ck \n");
 		} else {
@@ -548,17 +544,13 @@ static void __exit bridge_exit(void)
 {
 	dev_t devno;
 	bool ret;
-#ifndef CONFIG_OMAP3_PM
-	u32 retvalue = 0;
-#endif
 	GT_0trace(driverTrace, GT_ENTER, "-> driver_exit\n");
 
 #ifndef CONFIG_DISABLE_BRIDGE_PM
 #ifndef CONFIG_DISABLE_BRIDGE_DVFS
 	/* remove the constraints */
 #ifndef CONFIG_OMAP3_PM
-	retvalue = clk_notifier_unregister(clk_handle, &iva_clk_notifier);
-	if (!retvalue) {
+	if (!clk_notifier_unregister(clk_handle, &iva_clk_notifier)) {
 		GT_0trace(driverTrace, GT_7CLASS,
 		"clk_notifier_unregister PASS for iva2_ck \n");
 	} else {
diff --git a/drivers/dsp/bridge/rmgr/dspdrv.c b/drivers/dsp/bridge/rmgr/dspdrv.c
index eb5a8d7..77a4f49 100644
--- a/drivers/dsp/bridge/rmgr/dspdrv.c
+++ b/drivers/dsp/bridge/rmgr/dspdrv.c
@@ -211,8 +211,8 @@ func_cont:
 	} else {
 		GT_0trace(curTrace, GT_7CLASS, "DSP_Init Failed\n");
 	}			/* End WCD_InitComplete2 */
-	DBC_Ensure((DSP_SUCCEEDED(status) && drvObject > 0) ||
-		  (DSP_FAILED(status) && drvObject == 0));
+	DBC_Ensure((DSP_SUCCEEDED(status) && drvObject != NULL) ||
+		  (DSP_FAILED(status) && drvObject == NULL));
 	*initStatus = status;
 	/* Return the Driver Object */
 	return (u32)drvObject;
diff --git a/drivers/dsp/bridge/rmgr/proc.c b/drivers/dsp/bridge/rmgr/proc.c
index 9fe9edd..e8de8a1 100644
--- a/drivers/dsp/bridge/rmgr/proc.c
+++ b/drivers/dsp/bridge/rmgr/proc.c
@@ -876,8 +876,8 @@ DSP_STATUS PROC_GetDevObject(DSP_HPROCESSOR hProcessor,
 		*phDevObject = NULL;
 	}
 
-	DBC_Ensure((DSP_SUCCEEDED(status) && *phDevObject > 0) ||
-		   (DSP_FAILED(status) && *phDevObject == 0));
+	DBC_Ensure((DSP_SUCCEEDED(status) && *phDevObject != NULL) ||
+		   (DSP_FAILED(status) && *phDevObject == NULL));
 
 	return status;
 }
diff --git a/drivers/dsp/bridge/services/kfile.c b/drivers/dsp/bridge/services/kfile.c
index eb1a2de..d839aab 100644
--- a/drivers/dsp/bridge/services/kfile.c
+++ b/drivers/dsp/bridge/services/kfile.c
@@ -206,7 +206,8 @@ struct KFILE_FileObj *KFILE_Open(CONST char *pszFileName, CONST char *pszMode)
  *      Reads a specified number of bytes into a buffer.
  */
 s32
-KFILE_Read(void *pBuffer, s32 cSize, s32 cCount, struct KFILE_FileObj *hFile)
+KFILE_Read(void __user*pBuffer, s32 cSize, s32 cCount,
+			struct KFILE_FileObj *hFile)
 {
 	u32 dwBytesRead = 0;
 	s32 cRetVal = 0;
diff --git a/drivers/dsp/bridge/services/mem.c b/drivers/dsp/bridge/services/mem.c
index 83ad452..a01a058 100644
--- a/drivers/dsp/bridge/services/mem.c
+++ b/drivers/dsp/bridge/services/mem.c
@@ -137,7 +137,7 @@ static inline void MLST_RemoveElem(struct LST_LIST *pList,
 	pCurElem->prev = NULL;
 }
 
-void MEM_Check(void)
+static void MEM_Check(void)
 {
 	struct memInfo *pMem;
 	struct LST_ELEM *last = &mMan.lst.head;
diff --git a/drivers/dsp/bridge/wmd/tiomap3430.c b/drivers/dsp/bridge/wmd/tiomap3430.c
index 5ff3670..44a65b9 100644
--- a/drivers/dsp/bridge/wmd/tiomap3430.c
+++ b/drivers/dsp/bridge/wmd/tiomap3430.c
@@ -707,7 +707,6 @@ static DSP_STATUS WMD_BRD_Stop(struct WMD_DEV_CONTEXT *hDevContext)
 	struct CFG_HOSTRES resources;
 	struct PgTableAttrs *pPtAttrs;
 	u32 dspPwrState;
-	enum HW_PwrState_t pwrState;
 	DSP_STATUS clk_status;
 
 	DBG_Trace(DBG_ENTER, "Entering WMD_BRD_Stop:\nhDevContext: 0x%x\n",
-- 
1.6.0


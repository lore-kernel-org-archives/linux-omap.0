From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 2/2] DSPBRIDGE: Various compile warning fixes
Date: Sat, 23 Jan 2010 12:19:46 +0200
Message-ID: <1264241986-29071-3-git-send-email-felipe.contreras@gmail.com>
References: <1264241986-29071-1-git-send-email-felipe.contreras@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f227.google.com ([209.85.218.227]:37353 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754319Ab0AWKUK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 23 Jan 2010 05:20:10 -0500
Received: by bwz27 with SMTP id 27so1661481bwz.21
        for <linux-omap@vger.kernel.org>; Sat, 23 Jan 2010 02:20:09 -0800 (PST)
In-Reply-To: <1264241986-29071-1-git-send-email-felipe.contreras@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>, Mika Kukkonen <mika.kukkonen@nokia.com>, Ameya Palande <ameya.palande@nokia.com>

From: Mika Kukkonen <mika.kukkonen@nokia.com>

This patch contains indentation fixes and cleans up various warnings
uncovered with extra warning flags:
  - empty if() bodies
  - incorrect use of unsigned variables
  - bad comparison of pointer value
  - pointless check of unsigned value being smaller than zero
  - keyword 'extern' has to be first one in variable declaration

Signed-off-by: Mika Kukkonen <mika.kukkonen@nokia.com>
Signed-off-by: Ameya Palande <ameya.palande@nokia.com>
---
 arch/arm/plat-omap/include/dspbridge/dbc.h |    6 +++---
 arch/arm/plat-omap/include/dspbridge/dbg.h |    4 ++--
 arch/arm/plat-omap/include/dspbridge/gt.h  |   16 +++++++++-------
 arch/arm/plat-omap/include/dspbridge/mem.h |    2 +-
 drivers/dsp/bridge/wmd/io_sm.c             |    5 ++---
 drivers/dsp/bridge/wmd/ue_deh.c            |    2 +-
 6 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/dbc.h b/arch/arm/plat-omap/include/dspbridge/dbc.h
index ac5d178..1b3ac44 100644
--- a/arch/arm/plat-omap/include/dspbridge/dbc.h
+++ b/arch/arm/plat-omap/include/dspbridge/dbc.h
@@ -43,9 +43,9 @@
 
 #else
 
-#define DBC_Assert(exp)
-#define DBC_Require(exp)
-#define DBC_Ensure(exp)
+#define DBC_Assert(exp) {}
+#define DBC_Require(exp) {}
+#define DBC_Ensure(exp) {}
 
 #endif				/* DEBUG */
 
diff --git a/arch/arm/plat-omap/include/dspbridge/dbg.h b/arch/arm/plat-omap/include/dspbridge/dbg.h
index 2f61dab..4d01eca 100644
--- a/arch/arm/plat-omap/include/dspbridge/dbg.h
+++ b/arch/arm/plat-omap/include/dspbridge/dbg.h
@@ -80,9 +80,9 @@
 	extern DSP_STATUS DBG_Trace(IN u8 bLevel, IN char *pstrFormat, ...);
 #else
 
-#define DBG_Exit(void)
+#define DBG_Exit(void) do {} while (0)
 #define DBG_Init(void) true
-#define DBG_Trace(bLevel, pstrFormat, args...)
+#define DBG_Trace(bLevel, pstrFormat, args...) do {} while (0)
 
 #endif	/* (CONFIG_BRIDGE_DEBUG || DDSP_DEBUG_PRODUCT) && GT_TRACE */
 
diff --git a/arch/arm/plat-omap/include/dspbridge/gt.h b/arch/arm/plat-omap/include/dspbridge/gt.h
index 6082d15..9097910 100644
--- a/arch/arm/plat-omap/include/dspbridge/gt.h
+++ b/arch/arm/plat-omap/include/dspbridge/gt.h
@@ -252,13 +252,15 @@ extern struct GT_Config _GT_params;
 
 #define GT_query(mask, class)     false
 
-#define GT_0trace(mask, class, format)
-#define GT_1trace(mask, class, format, arg1)
-#define GT_2trace(mask, class, format, arg1, arg2)
-#define GT_3trace(mask, class, format, arg1, arg2, arg3)
-#define GT_4trace(mask, class, format, arg1, arg2, arg3, arg4)
-#define GT_5trace(mask, class, format, arg1, arg2, arg3, arg4, arg5)
-#define GT_6trace(mask, class, format, arg1, arg2, arg3, arg4, arg5, arg6)
+#define GT_0trace(mask, class, format) do {} while (0)
+#define GT_1trace(mask, class, format, arg1) do {} while (0)
+#define GT_2trace(mask, class, format, arg1, arg2) do {} while (0)
+#define GT_3trace(mask, class, format, arg1, arg2, arg3) do {} while (0)
+#define GT_4trace(mask, class, format, arg1, arg2, arg3, arg4) do {} while (0)
+#define GT_5trace(mask, class, format, arg1, arg2, arg3, arg4, arg5) \
+	do {} while (0)
+#define GT_6trace(mask, class, format, arg1, arg2, arg3, arg4, arg5, arg6) \
+	do {} while (0)
 
 #else				/* GT_TRACE == 1 */
 
diff --git a/arch/arm/plat-omap/include/dspbridge/mem.h b/arch/arm/plat-omap/include/dspbridge/mem.h
index 03b419a..353ffb0 100644
--- a/arch/arm/plat-omap/include/dspbridge/mem.h
+++ b/arch/arm/plat-omap/include/dspbridge/mem.h
@@ -286,7 +286,7 @@
  *  Ensures:
  *      - pBaseAddr no longer points to a valid linear address.
  */
-#define MEM_UnmapLinearAddress(pBaseAddr)
+#define MEM_UnmapLinearAddress(pBaseAddr) {}
 
 /*
  *  ======== MEM_ExtPhysPoolInit ========
diff --git a/drivers/dsp/bridge/wmd/io_sm.c b/drivers/dsp/bridge/wmd/io_sm.c
index e35ce57..587dc6c 100644
--- a/drivers/dsp/bridge/wmd/io_sm.c
+++ b/drivers/dsp/bridge/wmd/io_sm.c
@@ -221,8 +221,7 @@ DSP_STATUS WMD_IO_Create(OUT struct IO_MGR **phIOMgr,
 		bridge_workqueue = create_workqueue("bridge_work-queue");
 
 	if (bridge_workqueue <= 0)
-		DBG_Trace(DBG_LEVEL1, "Workque Create failed 0x%d \n",
-						bridge_workqueue);
+		DBG_Trace(DBG_LEVEL1, "Workqueue creation failed!\n");
 
 	/* Allocate IO manager object */
 	MEM_AllocObject(pIOMgr, struct IO_MGR, IO_MGRSIGNATURE);
@@ -1210,7 +1209,7 @@ static void InputChnl(struct IO_MGR *pIOMgr, struct CHNL_OBJECT *pChnl,
 			    pChnlMgr->uWordSize;
 	chnlId = IO_GetValue(pIOMgr->hWmdContext, struct SHM, sm, inputId);
 	dwArg = IO_GetLong(pIOMgr->hWmdContext, struct SHM, sm, arg);
-	if (!(chnlId >= 0) || !(chnlId < CHNL_MAXCHANNELS)) {
+	if (chnlId >= CHNL_MAXCHANNELS) {
 		/* Shouldn't be here: would indicate corrupted SHM. */
 		DBC_Assert(chnlId);
 		goto func_end;
diff --git a/drivers/dsp/bridge/wmd/ue_deh.c b/drivers/dsp/bridge/wmd/ue_deh.c
index 6166d97..2c3a2cd 100644
--- a/drivers/dsp/bridge/wmd/ue_deh.c
+++ b/drivers/dsp/bridge/wmd/ue_deh.c
@@ -189,7 +189,7 @@ void WMD_DEH_Notify(struct DEH_MGR *hDehMgr, u32 ulEventMask,
 	DSP_STATUS status = DSP_SOK;
 	u32 memPhysical = 0;
 	u32 HW_MMU_MAX_TLB_COUNT = 31;
-	u32 extern faultAddr;
+	extern u32 faultAddr;
 	struct CFG_HOSTRES resources;
 	HW_STATUS hwStatus;
 
-- 
1.6.6.1


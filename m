From: Omar Ramirez Luna <x00omar@ti.com>
Subject: [PATCH 11/14] DSPBRIDGE: New PWRERROR event notification
Date: Wed, 20 May 2009 00:02:17 -0500
Message-ID: <1242795740-21535-11-git-send-email-x00omar@ti.com>
References: <1242795740-21535-1-git-send-email-x00omar@ti.com>
 <1242795740-21535-2-git-send-email-x00omar@ti.com>
 <1242795740-21535-3-git-send-email-x00omar@ti.com>
 <1242795740-21535-4-git-send-email-x00omar@ti.com>
 <1242795740-21535-5-git-send-email-x00omar@ti.com>
 <1242795740-21535-6-git-send-email-x00omar@ti.com>
 <1242795740-21535-7-git-send-email-x00omar@ti.com>
 <1242795740-21535-8-git-send-email-x00omar@ti.com>
 <1242795740-21535-9-git-send-email-x00omar@ti.com>
 <1242795740-21535-10-git-send-email-x00omar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:39058 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752319AbZETE6e (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 20 May 2009 00:58:34 -0400
In-Reply-To: <1242795740-21535-10-git-send-email-x00omar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Hiroshi.DOYU@nokia.com, ameya.palande@nokia.com, Omar Ramirez Luna <omar.ramirez@ti.com>, Hari Kanigeri <h-kanigeri2@ti.com>

From: Omar Ramirez Luna <omar.ramirez@ti.com>

This patch defines a new DSP_PWRERROR event which can be
registered for notification. It uses the same mechanism
as MMUFAULT or SYSERROR. And will notify to ayn client registered
if there was any error when entering forced sleep state.

Signed-off-by: Hari Kanigeri <h-kanigeri2@ti.com>
Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/dbdefs.h |    7 +++++--
 drivers/dsp/bridge/rmgr/proc.c                |   11 ++++++-----
 drivers/dsp/bridge/wmd/tiomap3430_pwr.c       |    6 ++++++
 drivers/dsp/bridge/wmd/ue_deh.c               |   10 ++++++++++
 4 files changed, 27 insertions(+), 7 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/dbdefs.h b/arch/arm/plat-omap/include/dspbridge/dbdefs.h
index 9782693..78be880 100644
--- a/arch/arm/plat-omap/include/dspbridge/dbdefs.h
+++ b/arch/arm/plat-omap/include/dspbridge/dbdefs.h
@@ -101,6 +101,7 @@
 #define DSP_MMUFAULT                0x00000010
 #define DSP_SYSERROR                0x00000020
 #define DSP_EXCEPTIONABORT          0x00000300
+#define DSP_PWRERROR                0x00000080
 
 /* IVA exception events (IVA MMU fault) */
 #define IVA_MMUFAULT                0x00000040
@@ -174,7 +175,8 @@
 				    DSP_STREAMDONE | \
 				    DSP_STREAMIOCOMPLETION | \
 				    DSP_MMUFAULT | \
-				    DSP_SYSERROR)) && \
+				    DSP_SYSERROR | \
+				    DSP_PWRERROR)) && \
 				!((x) & ~(DSP_PROCESSORSTATECHANGE | \
 				    DSP_PROCESSORATTACH | \
 				    DSP_PROCESSORDETACH | \
@@ -183,7 +185,8 @@
 				    DSP_STREAMDONE | \
 				    DSP_STREAMIOCOMPLETION | \
 				    DSP_MMUFAULT | \
-				    DSP_SYSERROR))))
+				    DSP_SYSERROR | \
+				    DSP_PWRERROR))))
 
 #define IsValidNodeEvent(x)    (((x) == 0) || (((x) & (DSP_NODESTATECHANGE | \
 				DSP_NODEMESSAGEREADY)) && \
diff --git a/drivers/dsp/bridge/rmgr/proc.c b/drivers/dsp/bridge/rmgr/proc.c
index bb8cff3..8a5dfa7 100644
--- a/drivers/dsp/bridge/rmgr/proc.c
+++ b/drivers/dsp/bridge/rmgr/proc.c
@@ -1499,7 +1499,7 @@ DSP_STATUS PROC_RegisterNotify(DSP_HPROCESSOR hProcessor, u32 uEventMask,
 	/* Check if event mask is a valid processor related event */
 	if (uEventMask & ~(DSP_PROCESSORSTATECHANGE | DSP_PROCESSORATTACH |
 	   DSP_PROCESSORDETACH | DSP_PROCESSORRESTART | DSP_MMUFAULT |
-	   DSP_SYSERROR))
+	   DSP_SYSERROR | DSP_PWRERROR))
 		status = DSP_EVALUE;
 
 	/* Check if notify type is valid */
@@ -1507,12 +1507,13 @@ DSP_STATUS PROC_RegisterNotify(DSP_HPROCESSOR hProcessor, u32 uEventMask,
 		status = DSP_EVALUE;
 
 	if (DSP_SUCCEEDED(status)) {
-		/* * If event mask is not DSP_SYSERROR or DSP_MMUFAULT,
-		 * then register event immediately.  */
-		if (uEventMask & ~(DSP_SYSERROR | DSP_MMUFAULT)) {
+		/* If event mask is not DSP_SYSERROR, DSP_MMUFAULT,
+		 * or DSP_PWRERROR then register event immediately. */
+		if (uEventMask &
+		    ~(DSP_SYSERROR | DSP_MMUFAULT | DSP_PWRERROR)) {
 			status = NTFY_Register(pProcObject->hNtfy,
 				 hNotification,	uEventMask, uNotifyType);
-			/* * Special case alert, special case alert!
+			/* Special case alert, special case alert!
 			 * If we're trying to *deregister* (i.e. uEventMask
 			 * is 0), a DSP_SYSERROR or DSP_MMUFAULT notification,
 			 * we have to deregister with the DEH manager.
diff --git a/drivers/dsp/bridge/wmd/tiomap3430_pwr.c b/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
index d9ee480..a651963 100644
--- a/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
+++ b/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
@@ -57,6 +57,9 @@
 
 #include <dspbridge/pwr_sh.h>
 
+/*  ----------------------------------- Mini Driver */
+#include <dspbridge/wmddeh.h>
+
 /*  ----------------------------------- specific to this file */
 #include "_tiomap.h"
 #include "_tiomap_pwr.h"
@@ -188,6 +191,7 @@ DSP_STATUS SleepDSP(struct WMD_DEV_CONTEXT *pDevContext, IN u32 dwCmd,
 	DSP_STATUS status = DSP_SOK;
 #ifdef CONFIG_PM
 	struct CFG_HOSTRES resources;
+	struct DEH_MGR *hDehMgr;
 	u16 usCount = TIHELEN_ACKTIMEOUT;
 	enum HW_PwrState_t pwrState;
 	enum HW_PwrState_t targetPwrState;
@@ -257,6 +261,8 @@ DSP_STATUS SleepDSP(struct WMD_DEV_CONTEXT *pDevContext, IN u32 dwCmd,
 	if (usCount == 0) {
 		DBG_Trace(DBG_LEVEL7, "SleepDSP: Timed out Waiting for DSP"
 			 " STANDBY %x \n", pwrState);
+		DEV_GetDehMgr(pDevContext->hDevObject, &hDehMgr);
+		WMD_DEH_Notify(hDehMgr, DSP_PWRERROR, 0);
 		return WMD_E_TIMEOUT;
 	} else {
 		DBG_Trace(DBG_LEVEL7, "SleepDSP: DSP STANDBY Pwr state %x \n",
diff --git a/drivers/dsp/bridge/wmd/ue_deh.c b/drivers/dsp/bridge/wmd/ue_deh.c
index b7fd795..dcb44dd 100644
--- a/drivers/dsp/bridge/wmd/ue_deh.c
+++ b/drivers/dsp/bridge/wmd/ue_deh.c
@@ -281,6 +281,16 @@ DBG_Trace(DBG_LEVEL6, "WMD_DEH_Notify: DSP_MMUFAULT, "
 			HW_MMU_EventAck(resources.dwDmmuBase,
 					 HW_MMU_TRANSLATION_FAULT);
 			break;
+		case DSP_PWRERROR:
+			/* reset errInfo structure before use */
+			pDehMgr->errInfo.dwErrMask = DSP_PWRERROR;
+			pDehMgr->errInfo.dwVal1 = 0L;
+			pDehMgr->errInfo.dwVal2 = 0L;
+			pDehMgr->errInfo.dwVal3 = 0L;
+			pDehMgr->errInfo.dwVal1 = dwErrInfo;
+			printk(KERN_ERR "WMD_DEH_Notify: DSP_PWRERROR, errInfo "
+					"= 0x%x\n", dwErrInfo);
+			break;
 		default:
 			DBG_Trace(DBG_LEVEL6,
 				 "WMD_DEH_Notify: Unknown Error, errInfo = "
-- 
1.6.2.4


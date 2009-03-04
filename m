From: Fernando Guzman Lugo <x0095840@ti.com>
Subject: [PATCH] DSPBRIDGE: cleanup of HW_MBOX_IsFull function
Date: Wed,  4 Mar 2009 12:11:35 -0600
Message-ID: <1236190296-21667-5-git-send-email-x0095840@ti.com>
References: <1236190296-21667-1-git-send-email-x0095840@ti.com>
 <1236190296-21667-2-git-send-email-x0095840@ti.com>
 <1236190296-21667-3-git-send-email-x0095840@ti.com>
 <1236190296-21667-4-git-send-email-x0095840@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:46044 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753353AbZCDSLr (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 4 Mar 2009 13:11:47 -0500
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id n24IBfRZ015323
	for <linux-omap@vger.kernel.org>; Wed, 4 Mar 2009 12:11:46 -0600
In-Reply-To: <1236190296-21667-4-git-send-email-x0095840@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: leed.aguilar@ti.com, vikram.pandita@ti.com, h-kanigeri2@ti.com, linux-omap@vger.kernel.org
Cc: Fernando Guzman Lugo <x0095840@ti.com>

This patch does a cleanup of the HW_MBOX_IsFull function; removing some
unnecessary checks and changing the returned value to bool because the status
value is not needed.

Signed-off-by: Fernando Guzman Lugo <x0095840@ti.com>
Reviewed-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 drivers/dsp/bridge/hw/hw_mbox.c    |   25 -------------------------
 drivers/dsp/bridge/hw/hw_mbox.h    |   14 ++++++++------
 drivers/dsp/bridge/wmd/tiomap_sm.c |   12 +++---------
 3 files changed, 11 insertions(+), 40 deletions(-)

diff --git a/drivers/dsp/bridge/hw/hw_mbox.c b/drivers/dsp/bridge/hw/hw_mbox.c
index 0c0f721..ee79032
--- a/drivers/dsp/bridge/hw/hw_mbox.c
+++ b/drivers/dsp/bridge/hw/hw_mbox.c
@@ -104,31 +104,6 @@ HW_STATUS HW_MBOX_MsgWrite(const void __iomem *baseAddress,
 	return status;
 }
 
-/* Reads the full status register for mailbox. */
-HW_STATUS HW_MBOX_IsFull(const void __iomem *baseAddress,
-	const HW_MBOX_Id_t mailBoxId, u32 *const pIsFull)
-{
-	HW_STATUS status = RET_OK;
-	u32 fullStatus;
-
-	/* Check input parameters */
-	CHECK_INPUT_PARAM(baseAddress, 0, RET_BAD_NULL_PARAM, RES_MBOX_BASE +
-			RES_INVALID_INPUT_PARAM);
-	CHECK_INPUT_PARAM(pIsFull,  NULL, RET_BAD_NULL_PARAM, RES_MBOX_BASE +
-			RES_INVALID_INPUT_PARAM);
-	CHECK_INPUT_RANGE_MIN0(mailBoxId, HW_MBOX_ID_MAX, RET_INVALID_ID,
-			RES_MBOX_BASE + RES_INVALID_INPUT_PARAM);
-
-	/* read the is full status parameter for Mailbox */
-	fullStatus = MLBMAILBOX_FIFOSTATUS___0_15FifoFullMBmRead32(baseAddress,
-							(u32)mailBoxId);
-
-	/* fill in return parameter */
-	*pIsFull = (fullStatus & 0xFF);
-
-	return status;
-}
-
 /* Gets number of messages in a specified mailbox. */
 HW_STATUS HW_MBOX_NumMsgGet(const void __iomem *baseAddress,
 	const HW_MBOX_Id_t mailBoxId, u32 *const pNumMsg)
diff --git a/drivers/dsp/bridge/hw/hw_mbox.h b/drivers/dsp/bridge/hw/hw_mbox.h
index 5d3d18f..341b58a
--- a/drivers/dsp/bridge/hw/hw_mbox.h
+++ b/drivers/dsp/bridge/hw/hw_mbox.h
@@ -26,6 +26,8 @@
 #ifndef __MBOX_H
 #define __MBOX_H
 
+#include "MLBRegAcM.h"
+
 /* Bitmasks for Mailbox interrupt sources */
 #define HW_MBOX_INT_NEW_MSG    0x1
 #define HW_MBOX_INT_NOT_FULL   0x2
@@ -158,12 +160,12 @@ extern HW_STATUS HW_MBOX_MsgWrite(
 *
 * PURPOSE:      : this function reads the full status register for mailbox.
 */
-extern HW_STATUS HW_MBOX_IsFull(
-		      const void __iomem *baseAddress,
-		      const HW_MBOX_Id_t   mailBoxId,
-		      u32 *const	pIsFull
-		  );
-
+static inline bool HW_MBOX_IsFull(const void __iomem *baseAddress,
+	const HW_MBOX_Id_t mailBoxId)
+{
+	return MLBMAILBOX_FIFOSTATUS___0_15FifoFullMBmRead32(baseAddress,
+							(u32)mailBoxId);
+}
 /*
 * FUNCTION      : HW_MBOX_NumMsgGet
 *
diff --git a/drivers/dsp/bridge/wmd/tiomap_sm.c b/drivers/dsp/bridge/wmd/tiomap_sm.c
index edc3bcf..f8496cf
--- a/drivers/dsp/bridge/wmd/tiomap_sm.c
+++ b/drivers/dsp/bridge/wmd/tiomap_sm.c
@@ -178,7 +178,6 @@ DSP_STATUS CHNLSM_InterruptDSP(struct WMD_DEV_CONTEXT *hDevContext)
 #endif
 #endif
 	HW_STATUS hwStatus;
-	u32 mbxFull;
 	struct CFG_HOSTRES resources;
 	u16 cnt = 10;
 	u32 temp;
@@ -241,14 +240,9 @@ DSP_STATUS CHNLSM_InterruptDSP(struct WMD_DEV_CONTEXT *hDevContext)
 
 		pDevContext->dwBrdState = BRD_RUNNING;
 	}
-	while (--cnt) {
-		hwStatus = HW_MBOX_IsFull(resources.dwMboxBase,
-					   MBOX_ARM2DSP, &mbxFull);
-		if (mbxFull)
-			UTIL_Wait(1000);	/* wait for 1 ms)      */
-		else
-			break;
-	}
+	while (--cnt && HW_MBOX_IsFull(resources.dwMboxBase, MBOX_ARM2DSP))
+		mdelay(1);
+
 	if (!cnt) {
 		DBG_Trace(DBG_LEVEL7, "Timed out waiting for DSP mailbox \n");
 		status = WMD_E_TIMEOUT;
-- 
1.5.6.4


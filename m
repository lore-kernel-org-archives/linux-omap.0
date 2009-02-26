From: "Guzman Lugo, Fernando" <x0095840@ti.com>
Subject: [UPDATE][PATCH][OMAPZOOM] DSPBRIDGE: Remove unnecessary checks in
 HW_MBOX_IsFull function
Date: Wed, 25 Feb 2009 19:42:46 -0600
Message-ID: <496565EC904933469F292DDA3F1663E60287751A02@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:41359 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753121AbZBZBmy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Feb 2009 20:42:54 -0500
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Felipe Contreras <felipe.contreras@gmail.com>


Hi,
	
	I have updated the patch base on Felipe's patches.

>From db89674b7316d7490e71c131091758eb7ef0eca2 Mon Sep 17 00:00:00 2001
From: Fernando Guzman Lugo <x0095840@ti.com>
Date: Wed, 25 Feb 2009 19:27:41 -0600
Subject: [PATCH] DSPBRIDGE: Remove unnecessary checks in HW_MBOX_IsFull function

This patch removes some unnecesarry checks in HW_MBOX_IsFull
function
Signed-off-by: Guzman Lugo Fernando <x0095840@ti.com>
---
 drivers/dsp/bridge/hw/hw_mbox.c    |   22 ++--------------------
 drivers/dsp/bridge/hw/hw_mbox.h    |    6 ++----
 drivers/dsp/bridge/wmd/tiomap_sm.c |   14 ++++----------
 3 files changed, 8 insertions(+), 34 deletions(-)

diff --git a/drivers/dsp/bridge/hw/hw_mbox.c b/drivers/dsp/bridge/hw/hw_mbox.c
index bc61d64..3a539f5
--- a/drivers/dsp/bridge/hw/hw_mbox.c
+++ b/drivers/dsp/bridge/hw/hw_mbox.c
@@ -105,28 +105,10 @@ HW_STATUS HW_MBOX_MsgWrite(const u32 baseAddress, const HW_MBOX_Id_t mailBoxId,
 }
 
 /* Reads the full status register for mailbox. */
-HW_STATUS HW_MBOX_IsFull(const u32 baseAddress, const HW_MBOX_Id_t mailBoxId,
-			u32 *const pIsFull)
+inline bool HW_MBOX_IsFull(const u32 baseAddress, const HW_MBOX_Id_t mailBoxId)
 {
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
+	return MLBMAILBOX_FIFOSTATUS___0_15FifoFullMBmRead32(baseAddress,
 							(u32)mailBoxId);
-
-	/* fill in return parameter */
-	*pIsFull = (fullStatus & 0xFF);
-
-	return status;
 }
 
 /* Gets number of messages in a specified mailbox. */
diff --git a/drivers/dsp/bridge/hw/hw_mbox.h b/drivers/dsp/bridge/hw/hw_mbox.h
index 225fb40..50a3746
--- a/drivers/dsp/bridge/hw/hw_mbox.h
+++ b/drivers/dsp/bridge/hw/hw_mbox.h
@@ -158,11 +158,9 @@ extern HW_STATUS HW_MBOX_MsgWrite(
 *
 * PURPOSE:      : this function reads the full status register for mailbox.
 */
-extern HW_STATUS HW_MBOX_IsFull(
+extern inline bool HW_MBOX_IsFull(
 		      const u32	 baseAddress,
-		      const HW_MBOX_Id_t   mailBoxId,
-		      u32 *const	pIsFull
-		  );
+		      const HW_MBOX_Id_t   mailBoxId);
 
 /*
 * FUNCTION      : HW_MBOX_NumMsgGet
diff --git a/drivers/dsp/bridge/wmd/tiomap_sm.c b/drivers/dsp/bridge/wmd/tiomap_sm.c
index edc3bcf..2843788
--- a/drivers/dsp/bridge/wmd/tiomap_sm.c
+++ b/drivers/dsp/bridge/wmd/tiomap_sm.c
@@ -178,9 +178,8 @@ DSP_STATUS CHNLSM_InterruptDSP(struct WMD_DEV_CONTEXT *hDevContext)
 #endif
 #endif
 	HW_STATUS hwStatus;
-	u32 mbxFull;
 	struct CFG_HOSTRES resources;
-	u16 cnt = 10;
+	u16 cnt = 1000;
 	u32 temp;
 	/* We are waiting indefinitely here. This needs to be fixed in the
 	 * second phase */
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
+		udelay(1);
+
 	if (!cnt) {
 		DBG_Trace(DBG_LEVEL7, "Timed out waiting for DSP mailbox \n");
 		status = WMD_E_TIMEOUT;
-- 
1.5.6.4

From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH A 09/15] tidspbridge: cleanup and remove HW_MBOX_IsFull
Date: Wed, 18 Mar 2009 03:23:05 +0200
Message-ID: <1237339391-20543-10-git-send-email-felipe.contreras@gmail.com>
References: <1237339391-20543-1-git-send-email-felipe.contreras@gmail.com>
 <1237339391-20543-2-git-send-email-felipe.contreras@gmail.com>
 <1237339391-20543-3-git-send-email-felipe.contreras@gmail.com>
 <1237339391-20543-4-git-send-email-felipe.contreras@gmail.com>
 <1237339391-20543-5-git-send-email-felipe.contreras@gmail.com>
 <1237339391-20543-6-git-send-email-felipe.contreras@gmail.com>
 <1237339391-20543-7-git-send-email-felipe.contreras@gmail.com>
 <1237339391-20543-8-git-send-email-felipe.contreras@gmail.com>
 <1237339391-20543-9-git-send-email-felipe.contreras@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f169.google.com ([209.85.218.169]:49404 "EHLO
	mail-bw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756568AbZCRBY0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Mar 2009 21:24:26 -0400
Received: by bwz17 with SMTP id 17so321651bwz.37
        for <linux-omap@vger.kernel.org>; Tue, 17 Mar 2009 18:24:23 -0700 (PDT)
In-Reply-To: <1237339391-20543-9-git-send-email-felipe.contreras@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Hari Kanigeri <h-kanigeri2@ti.com>, Hiroshi DOYU <hiroshi.doyu@nokia.com>, Ameya Palande <ameya.palande@nokia.com>, Fernando Guzman Lugo <x0095840@ti.com>, Felipe Contreras <felipe.contreras@nokia.com>

From: Felipe Contreras <felipe.contreras@nokia.com>

HW_MBOX_IsFull has many convoluted macros and is used only once. Clean
it up so it's easier to see what it's actually doing.

Signed-off-by: Felipe Contreras <felipe.contreras@nokia.com>
---
 drivers/dsp/bridge/hw/hw_mbox.c    |   25 -------------------------
 drivers/dsp/bridge/hw/hw_mbox.h    |   35 -----------------------------------
 drivers/dsp/bridge/wmd/tiomap_sm.c |   25 +++++++++++++------------
 3 files changed, 13 insertions(+), 72 deletions(-)

diff --git a/drivers/dsp/bridge/hw/hw_mbox.c b/drivers/dsp/bridge/hw/hw_mbox.c
index 2c14ade..31b890a 100644
--- a/drivers/dsp/bridge/hw/hw_mbox.c
+++ b/drivers/dsp/bridge/hw/hw_mbox.c
@@ -104,31 +104,6 @@ HW_STATUS HW_MBOX_MsgWrite(const u32 baseAddress, const HW_MBOX_Id_t mailBoxId,
 	return status;
 }
 
-/* Reads the full status register for mailbox. */
-HW_STATUS HW_MBOX_IsFull(const u32 baseAddress, const HW_MBOX_Id_t mailBoxId,
-			u32 *const pIsFull)
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
 HW_STATUS HW_MBOX_NumMsgGet(const u32 baseAddress, const HW_MBOX_Id_t mailBoxId,
 				u32 *const pNumMsg)
diff --git a/drivers/dsp/bridge/hw/hw_mbox.h b/drivers/dsp/bridge/hw/hw_mbox.h
index 225fb40..d2981d3 100644
--- a/drivers/dsp/bridge/hw/hw_mbox.h
+++ b/drivers/dsp/bridge/hw/hw_mbox.h
@@ -130,41 +130,6 @@ extern HW_STATUS HW_MBOX_MsgWrite(
 		  );
 
 /*
-* FUNCTION      : HW_MBOX_IsFull
-*
-* INPUTS:
-*
-*   Identifier  : baseAddress
-*   Type	: const u32
-*   Description : Base Address of instance of Mailbox module
-*
-*   Identifier  : mailBoxId
-*   Type	: const HW_MBOX_Id_t
-*   Description : Mail Box Sub module Id to check
-*
-* OUTPUTS:
-*
-*   Identifier  : pIsFull
-*   Type	: u32 *const
-*   Description : false means mail box not Full
-*		 true means mailbox full.
-*
-* RETURNS:
-*
-*   Type	: ReturnCode_t
-*   Description : RET_OK	      No errors occured
-*		 RET_BAD_NULL_PARAM  Address/pointer Paramater was set to 0/NULL
-*		 RET_INVALID_ID      Invalid Id used
-*
-* PURPOSE:      : this function reads the full status register for mailbox.
-*/
-extern HW_STATUS HW_MBOX_IsFull(
-		      const u32	 baseAddress,
-		      const HW_MBOX_Id_t   mailBoxId,
-		      u32 *const	pIsFull
-		  );
-
-/*
 * FUNCTION      : HW_MBOX_NumMsgGet
 *
 * INPUTS:
diff --git a/drivers/dsp/bridge/wmd/tiomap_sm.c b/drivers/dsp/bridge/wmd/tiomap_sm.c
index 574cf28..658064f 100644
--- a/drivers/dsp/bridge/wmd/tiomap_sm.c
+++ b/drivers/dsp/bridge/wmd/tiomap_sm.c
@@ -28,6 +28,13 @@
 extern struct platform_device omap_dspbridge_dev;
 #endif
 
+#define MAILBOX_FIFOSTATUS(m) (0x80 + 4 * (m))
+
+static inline unsigned int fifo_full(void __iomem *mbox_base, int mbox_id)
+{
+	return __raw_readb(mbox_base + MAILBOX_FIFOSTATUS(mbox_id)) & 0x1;
+}
+
 DSP_STATUS CHNLSM_EnableInterrupt(struct WMD_DEV_CONTEXT *pDevContext)
 {
 	DSP_STATUS status = DSP_SOK;
@@ -97,7 +104,6 @@ DSP_STATUS CHNLSM_InterruptDSP(struct WMD_DEV_CONTEXT *pDevContext)
 		omap_dspbridge_dev.dev.platform_data;
 	u32 opplevel = 0;
 #endif
-	u32 mbxFull;
 	struct CFG_HOSTRES resources;
 	u16 cnt = 10;
 	u32 temp;
@@ -137,17 +143,12 @@ DSP_STATUS CHNLSM_InterruptDSP(struct WMD_DEV_CONTEXT *pDevContext)
 
 		pDevContext->dwBrdState = BRD_RUNNING;
 	}
-	while (--cnt) {
-		HW_MBOX_IsFull(resources.dwMboxBase,
-			       MBOX_ARM2DSP, &mbxFull);
-		if (mbxFull)
-			mdelay(1);
-		else
-			break;
-	}
-	if (!cnt) {
-		DBG_Trace(DBG_LEVEL7, "Timed out waiting for DSP mailbox \n");
-		return WMD_E_TIMEOUT;
+	while (fifo_full((void __iomem *) resources.dwMboxBase, 0)) {
+		if (--cnt == 0) {
+			DBG_Trace(DBG_LEVEL7, "Timed out waiting for DSP mailbox \n");
+			return WMD_E_TIMEOUT;
+		}
+		mdelay(1);
 	}
 	DBG_Trace(DBG_LEVEL3, "writing %x to Mailbox\n",
 		  pDevContext->wIntrVal2Dsp);
-- 
1.6.2.1.287.g9a8be


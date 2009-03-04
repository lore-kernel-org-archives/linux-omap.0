From: Fernando Guzman Lugo <x0095840@ti.com>
Subject: [PATCH] DSPBRIDGE: wait less and check the mailbox more.
Date: Wed,  4 Mar 2009 12:11:36 -0600
Message-ID: <1236190296-21667-6-git-send-email-x0095840@ti.com>
References: <1236190296-21667-1-git-send-email-x0095840@ti.com>
 <1236190296-21667-2-git-send-email-x0095840@ti.com>
 <1236190296-21667-3-git-send-email-x0095840@ti.com>
 <1236190296-21667-4-git-send-email-x0095840@ti.com>
 <1236190296-21667-5-git-send-email-x0095840@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:59027 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753446AbZCDSLx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Mar 2009 13:11:53 -0500
In-Reply-To: <1236190296-21667-5-git-send-email-x0095840@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: leed.aguilar@ti.com, vikram.pandita@ti.com, h-kanigeri2@ti.com, linux-omap@vger.kernel.org
Cc: Fernando Guzman Lugo <x0095840@ti.com>, Felipe Contreras <felipe.contreras@nokia.com>

Performance is increased if we wait less and check the mailbox more when it's
full.

Signed-off-by: Felipe Contreras <felipe.contreras@nokia.com>
Signed-off-by: Fernando Guzman Lugo <x0095840@ti.com>
---
 drivers/dsp/bridge/wmd/tiomap_sm.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dsp/bridge/wmd/tiomap_sm.c b/drivers/dsp/bridge/wmd/tiomap_sm.c
index f8496cf..2843788
--- a/drivers/dsp/bridge/wmd/tiomap_sm.c
+++ b/drivers/dsp/bridge/wmd/tiomap_sm.c
@@ -179,7 +179,7 @@ DSP_STATUS CHNLSM_InterruptDSP(struct WMD_DEV_CONTEXT *hDevContext)
 #endif
 	HW_STATUS hwStatus;
 	struct CFG_HOSTRES resources;
-	u16 cnt = 10;
+	u16 cnt = 1000;
 	u32 temp;
 	/* We are waiting indefinitely here. This needs to be fixed in the
 	 * second phase */
@@ -241,7 +241,7 @@ DSP_STATUS CHNLSM_InterruptDSP(struct WMD_DEV_CONTEXT *hDevContext)
 		pDevContext->dwBrdState = BRD_RUNNING;
 	}
 	while (--cnt && HW_MBOX_IsFull(resources.dwMboxBase, MBOX_ARM2DSP))
-		mdelay(1);
+		udelay(1);
 
 	if (!cnt) {
 		DBG_Trace(DBG_LEVEL7, "Timed out waiting for DSP mailbox \n");
-- 
1.5.6.4


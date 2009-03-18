From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH A 10/15] tidspbridge: remove udelay and use time_after instead
Date: Wed, 18 Mar 2009 03:23:06 +0200
Message-ID: <1237339391-20543-11-git-send-email-felipe.contreras@gmail.com>
References: <1237339391-20543-1-git-send-email-felipe.contreras@gmail.com>
 <1237339391-20543-2-git-send-email-felipe.contreras@gmail.com>
 <1237339391-20543-3-git-send-email-felipe.contreras@gmail.com>
 <1237339391-20543-4-git-send-email-felipe.contreras@gmail.com>
 <1237339391-20543-5-git-send-email-felipe.contreras@gmail.com>
 <1237339391-20543-6-git-send-email-felipe.contreras@gmail.com>
 <1237339391-20543-7-git-send-email-felipe.contreras@gmail.com>
 <1237339391-20543-8-git-send-email-felipe.contreras@gmail.com>
 <1237339391-20543-9-git-send-email-felipe.contreras@gmail.com>
 <1237339391-20543-10-git-send-email-felipe.contreras@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f158.google.com ([209.85.220.158]:63018 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756270AbZCRBY1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Mar 2009 21:24:27 -0400
Received: by mail-fx0-f158.google.com with SMTP id 2so304246fxm.37
        for <linux-omap@vger.kernel.org>; Tue, 17 Mar 2009 18:24:25 -0700 (PDT)
In-Reply-To: <1237339391-20543-10-git-send-email-felipe.contreras@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Hari Kanigeri <h-kanigeri2@ti.com>, Hiroshi DOYU <hiroshi.doyu@nokia.com>, Ameya Palande <ameya.palande@nokia.com>, Fernando Guzman Lugo <x0095840@ti.com>, Felipe Contreras <felipe.contreras@nokia.com>

From: Felipe Contreras <felipe.contreras@nokia.com>

As suggested by Juha Yrjola.

Signed-off-by: Felipe Contreras <felipe.contreras@nokia.com>
---
 drivers/dsp/bridge/wmd/tiomap_sm.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/dsp/bridge/wmd/tiomap_sm.c b/drivers/dsp/bridge/wmd/tiomap_sm.c
index 658064f..735f8e9 100644
--- a/drivers/dsp/bridge/wmd/tiomap_sm.c
+++ b/drivers/dsp/bridge/wmd/tiomap_sm.c
@@ -105,7 +105,7 @@ DSP_STATUS CHNLSM_InterruptDSP(struct WMD_DEV_CONTEXT *pDevContext)
 	u32 opplevel = 0;
 #endif
 	struct CFG_HOSTRES resources;
-	u16 cnt = 10;
+	unsigned long timeout;
 	u32 temp;
 	/* We are waiting indefinitely here. This needs to be fixed in the
 	 * second phase */
@@ -143,12 +143,12 @@ DSP_STATUS CHNLSM_InterruptDSP(struct WMD_DEV_CONTEXT *pDevContext)
 
 		pDevContext->dwBrdState = BRD_RUNNING;
 	}
+	timeout = jiffies + msecs_to_jiffies(10);
 	while (fifo_full((void __iomem *) resources.dwMboxBase, 0)) {
-		if (--cnt == 0) {
+		if (time_after(jiffies, timeout)) {
 			DBG_Trace(DBG_LEVEL7, "Timed out waiting for DSP mailbox \n");
 			return WMD_E_TIMEOUT;
 		}
-		mdelay(1);
 	}
 	DBG_Trace(DBG_LEVEL3, "writing %x to Mailbox\n",
 		  pDevContext->wIntrVal2Dsp);
-- 
1.6.2.1.287.g9a8be


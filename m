From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 05/17] DSPBRIDGE: Enable peripheral clocks on wake up
Date: Tue, 15 Dec 2009 00:19:46 -0600
Message-ID: <1260857998-19349-6-git-send-email-omar.ramirez@ti.com>
References: <1260857998-19349-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:45442 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753168AbZLOGMx (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 15 Dec 2009 01:12:53 -0500
In-Reply-To: <1260857998-19349-1-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Ameya Palande <ameya.palande@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, Fernando Guzman <x0095840@ti.com>, Ernesto Ramos <ernesto@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>

If enable_off_mode is not set bridge target state going into
suspend will be retention, on this path the peripheral clocks
will be disabled but not enabled again when waking the dsp up.

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 drivers/dsp/bridge/wmd/tiomap_sm.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/dsp/bridge/wmd/tiomap_sm.c b/drivers/dsp/bridge/wmd/tiomap_sm.c
index 7d389e3..fe4d8b0 100644
--- a/drivers/dsp/bridge/wmd/tiomap_sm.c
+++ b/drivers/dsp/bridge/wmd/tiomap_sm.c
@@ -148,7 +148,9 @@ DSP_STATUS CHNLSM_InterruptDSP2(struct WMD_DEV_CONTEXT *pDevContext,
 		temp = *(REG_UWORD32 *)(resources.dwDmmuBase + 0x10);
 
 		pDevContext->dwBrdState = BRD_RUNNING;
-	}
+	} else if (pDevContext->dwBrdState == BRD_RETENTION)
+		/* Restart the peripheral clocks */
+		DSP_PeripheralClocks_Enable(pDevContext, NULL);
 
 	timeout = jiffies + msecs_to_jiffies(1);
 	while (fifo_full((void __iomem *) resources.dwMboxBase, 0)) {
-- 
1.6.2.4


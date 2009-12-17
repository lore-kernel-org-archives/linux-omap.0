From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCHv2 07/18] DSPBRIDGE: Enable peripheral clocks on wake up
Date: Wed, 16 Dec 2009 20:15:52 -0600
Message-ID: <1261016163-11091-8-git-send-email-omar.ramirez@ti.com>
References: <1261016163-11091-1-git-send-email-omar.ramirez@ti.com>
 <1261016163-11091-2-git-send-email-omar.ramirez@ti.com>
 <1261016163-11091-3-git-send-email-omar.ramirez@ti.com>
 <1261016163-11091-4-git-send-email-omar.ramirez@ti.com>
 <1261016163-11091-5-git-send-email-omar.ramirez@ti.com>
 <1261016163-11091-6-git-send-email-omar.ramirez@ti.com>
 <1261016163-11091-7-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:43911 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763901AbZLQCIs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 Dec 2009 21:08:48 -0500
In-Reply-To: <1261016163-11091-7-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Ameya Palande <ameya.palande@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, Fernando Guzman <x0095840@ti.com>, Ernesto Ramos <ernesto@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>

While suspending bridge disables peripheral clocks, but those
are not enabled again if the power state is configured to be
retention, which leaves the dsp not functional after suspend.

This patch re-enables the clocks on wakeup for off/ret power
states.

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 drivers/dsp/bridge/wmd/tiomap_sm.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/dsp/bridge/wmd/tiomap_sm.c b/drivers/dsp/bridge/wmd/tiomap_sm.c
index 7d389e3..84e10ea 100644
--- a/drivers/dsp/bridge/wmd/tiomap_sm.c
+++ b/drivers/dsp/bridge/wmd/tiomap_sm.c
@@ -148,6 +148,9 @@ DSP_STATUS CHNLSM_InterruptDSP2(struct WMD_DEV_CONTEXT *pDevContext,
 		temp = *(REG_UWORD32 *)(resources.dwDmmuBase + 0x10);
 
 		pDevContext->dwBrdState = BRD_RUNNING;
+	} else if (pDevContext->dwBrdState == BRD_RETENTION) {
+		/* Restart the peripheral clocks */
+		DSP_PeripheralClocks_Enable(pDevContext, NULL);
 	}
 
 	timeout = jiffies + msecs_to_jiffies(1);
-- 
1.6.2.4


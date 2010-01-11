From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 4/6] DSPBRIDGE: remove ioctl runtime check
Date: Mon, 11 Jan 2010 14:12:44 -0600
Message-ID: <1263240766-13000-5-git-send-email-omar.ramirez@ti.com>
References: <1263240766-13000-1-git-send-email-omar.ramirez@ti.com>
 <1263240766-13000-2-git-send-email-omar.ramirez@ti.com>
 <1263240766-13000-3-git-send-email-omar.ramirez@ti.com>
 <1263240766-13000-4-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:32991 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754020Ab0AKUDU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 Jan 2010 15:03:20 -0500
In-Reply-To: <1263240766-13000-4-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>, Nishant Menon <nm@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>

This patch removes the runtime check of device
ioctl array.

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
CC: Nishant Menon <nm@ti.com>
CC: Felipe Contreras <felipe.contreras@gmail.com>
---
 drivers/dsp/bridge/pmgr/wcd.c |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/drivers/dsp/bridge/pmgr/wcd.c b/drivers/dsp/bridge/pmgr/wcd.c
index f95980b..960b3cb 100644
--- a/drivers/dsp/bridge/pmgr/wcd.c
+++ b/drivers/dsp/bridge/pmgr/wcd.c
@@ -321,13 +321,7 @@ bool WCD_Init(void)
 	bool fInit = true;
 	bool fDRV, fDEV, fCOD, fSERVICES, fCHNL, fMSG, fIO;
 	bool fMGR, fPROC, fNODE, fDISP, fNTFY, fSTRM, fRMM;
-#ifdef DEBUG
-	/* runtime check of Device IOCtl array. */
-	u32 i;
-	for (i = 1; i < ARRAY_SIZE(WCD_cmdTable); i++)
-		DBC_Assert(WCD_cmdTable[i - 1].dwIndex == i);
 
-#endif
 	if (WCD_cRefs == 0) {
 		/* initialize all SERVICES modules */
 		fSERVICES = SERVICES_Init();
-- 
1.6.2.4


From: "Guzman Lugo, Fernando" <x0095840@ti.com>
Subject: [PATCH 4/5] DSPBRIDGE: Remove variables not used in cfgdefs.h
Date: Mon, 2 Mar 2009 18:02:44 -0600
Message-ID: <496565EC904933469F292DDA3F1663E60287B84DB9@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:34582 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756779AbZCCACy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Mar 2009 19:02:54 -0500
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Ameya Palande <2ameya@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

From: Fernando Guzman Lugo <x0095840@ti.com>
Date: Wed, 25 Feb 2009 10:19:12 -0600
Subject: [PATCH] DSPBRIDGE: Remove variables not used in cfgdefs.h

This patch removes some variable that are not used.
Signed-off-by: Guzman Lugo Fernando <x0095840@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/cfgdefs.h |   10 ----------
 drivers/dsp/bridge/rmgr/drv.c                  |    2 --
 2 files changed, 0 insertions(+), 12 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/cfgdefs.h b/arch/arm/plat-omap/include/dspbridge/cfgdefs.h
index e7633b5..34a28f8
--- a/arch/arm/plat-omap/include/dspbridge/cfgdefs.h
+++ b/arch/arm/plat-omap/include/dspbridge/cfgdefs.h
@@ -77,15 +77,6 @@
 		u8 bIRQAttrib;	/* IRQ Attribute */
 		u32 dwOffsetForMonitor;	/* The Shared memory starts from
 					 * dwMemBase + this offset */
-		u32 dwBusType;	/* Bus type for this device */
-		u32 dwProgBase;	/* DSP ProgBase */
-		u32 dwProgLength;	/* DSP ProgBase Length */
-		u32 dwRegBase;	/* DSP memory mapped register base */
-		u32 dwRegLength;	/* DSP Register Base Length */
-		u32 ClientHandle;	/* Client Handle */
-		u32 SocketHandle;	/* Socket and Function Pair */
-		u32 CardInfo;	/* This will be used as a context data in
-				 * in the CardRequestIRQ */
 	/*
 	 *  Info needed by NODE for allocating channels to communicate with RMS:
 	 *      dwChnlOffset:       Offset of RMS channels. Lower channels are
@@ -102,7 +93,6 @@
 		void __iomem *dwWdTimerDspBase;
 		void __iomem *dwMboxBase;
 		void __iomem *dwDmmuBase;
-		u32 *dwDipiBase;
 		void __iomem *dwSysCtrlBase;
 	} ;
 
diff --git a/drivers/dsp/bridge/rmgr/drv.c b/drivers/dsp/bridge/rmgr/drv.c
index 2241f48..160d730
--- a/drivers/dsp/bridge/rmgr/drv.c
+++ b/drivers/dsp/bridge/rmgr/drv.c
@@ -1733,7 +1733,6 @@ static DSP_STATUS RequestBridgeResources(u32 dwContext, s32 bRequest)
 		/* Second window is for DSP external memory shared with MPU */
 		if (DSP_SUCCEEDED(status)) {
 			/* for Linux, these are hard-coded values */
-			pResources->dwBusType = 0;
 			pResources->bIRQRegisters = 0;
 			pResources->bIRQAttrib = 0;
 			pResources->dwOffsetForMonitor = 0;
@@ -1856,7 +1855,6 @@ static DSP_STATUS RequestBridgeResourcesDSP(u32 dwContext, s32 bRequest)
 		}
 		if (DSP_SUCCEEDED(status)) {
 			/* for Linux, these are hard-coded values */
-			pResources->dwBusType = 0;
 			pResources->bIRQRegisters = 0;
 			pResources->bIRQAttrib = 0;
 			pResources->dwOffsetForMonitor = 0;
-- 
1.5.6.4


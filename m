From: Omar Ramirez Luna <x00omar@ti.com>
Subject: [PATCH 06/14] DSPBRIDGE: Remove variables not used in cfgdefs.h
Date: Wed, 20 May 2009 00:02:12 -0500
Message-ID: <1242795740-21535-6-git-send-email-x00omar@ti.com>
References: <1242795740-21535-1-git-send-email-x00omar@ti.com>
 <1242795740-21535-2-git-send-email-x00omar@ti.com>
 <1242795740-21535-3-git-send-email-x00omar@ti.com>
 <1242795740-21535-4-git-send-email-x00omar@ti.com>
 <1242795740-21535-5-git-send-email-x00omar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:59986 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752136AbZETE6d (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 20 May 2009 00:58:33 -0400
In-Reply-To: <1242795740-21535-5-git-send-email-x00omar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Hiroshi.DOYU@nokia.com, ameya.palande@nokia.com, Guzman Lugo Fernando <x0095840@ti.com>, Omar Ramirez Luna <x00omar@ti.com>

From: Guzman Lugo Fernando <x0095840@ti.com>

This patch removes some variables that are not used.

Signed-off-by: Guzman Lugo Fernando <x0095840@ti.com>
Signed-off-by: Omar Ramirez Luna <x00omar@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/cfgdefs.h |   10 ----------
 drivers/dsp/bridge/rmgr/drv.c                  |    2 --
 2 files changed, 0 insertions(+), 12 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/cfgdefs.h b/arch/arm/plat-omap/include/dspbridge/cfgdefs.h
index a2115f6..0155e13 100644
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
@@ -104,7 +95,6 @@
 		void __iomem *dwWdTimerDspBase;
 		void __iomem *dwMboxBase;
 		void __iomem *dwDmmuBase;
-		u32 *dwDipiBase;
 		void __iomem *dwSysCtrlBase;
 	} ;
 
diff --git a/drivers/dsp/bridge/rmgr/drv.c b/drivers/dsp/bridge/rmgr/drv.c
index ae6ea7f..e7da578 100644
--- a/drivers/dsp/bridge/rmgr/drv.c
+++ b/drivers/dsp/bridge/rmgr/drv.c
@@ -1736,7 +1736,6 @@ static DSP_STATUS RequestBridgeResources(u32 dwContext, s32 bRequest)
 		/* Second window is for DSP external memory shared with MPU */
 		if (DSP_SUCCEEDED(status)) {
 			/* for Linux, these are hard-coded values */
-			pResources->dwBusType = 0;
 			pResources->bIRQRegisters = 0;
 			pResources->bIRQAttrib = 0;
 			pResources->dwOffsetForMonitor = 0;
@@ -1863,7 +1862,6 @@ static DSP_STATUS RequestBridgeResourcesDSP(u32 dwContext, s32 bRequest)
 		}
 		if (DSP_SUCCEEDED(status)) {
 			/* for Linux, these are hard-coded values */
-			pResources->dwBusType = 0;
 			pResources->bIRQRegisters = 0;
 			pResources->bIRQAttrib = 0;
 			pResources->dwOffsetForMonitor = 0;
-- 
1.6.2.4


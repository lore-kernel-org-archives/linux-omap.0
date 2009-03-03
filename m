From: "Guzman Lugo, Fernando" <x0095840@ti.com>
Subject: [OMAPZOOM][PATCH 4/5] DSPBRIDGE: Remove variables not used in
 cfgdefs.h
Date: Mon, 2 Mar 2009 19:35:14 -0600
Message-ID: <496565EC904933469F292DDA3F1663E60287B84DFB@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:34600 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752918AbZCCBfU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Mar 2009 20:35:20 -0500
Received: from dlep95.itg.ti.com ([157.170.170.107])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id n231ZE11006129
	for <linux-omap@vger.kernel.org>; Mon, 2 Mar 2009 19:35:19 -0600
Received: from dlee73.ent.ti.com (localhost [127.0.0.1])
	by dlep95.itg.ti.com (8.13.8/8.13.8) with ESMTP id n231ZEUs001907
	for <linux-omap@vger.kernel.org>; Mon, 2 Mar 2009 19:35:14 -0600 (CST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pandita, Vikram" <vikram.pandita@ti.com>, "Kanigeri, Hari" <h-kanigeri2@ti.com>
Cc: "Aguilar Pena, Leed" <leed.aguilar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

>From d3aeedc4677ebe6fdfb7f9f68b72ad5dc96463f0 Mon Sep 17 00:00:00 2001
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


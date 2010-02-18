From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 07/12] DSPBRIDGE: Remove GT_trace variables for wmd
Date: Thu, 18 Feb 2010 15:37:58 -0600
Message-ID: <1266529083-2358-8-git-send-email-omar.ramirez@ti.com>
References: <1266529083-2358-1-git-send-email-omar.ramirez@ti.com>
 <1266529083-2358-2-git-send-email-omar.ramirez@ti.com>
 <1266529083-2358-3-git-send-email-omar.ramirez@ti.com>
 <1266529083-2358-4-git-send-email-omar.ramirez@ti.com>
 <1266529083-2358-5-git-send-email-omar.ramirez@ti.com>
 <1266529083-2358-6-git-send-email-omar.ramirez@ti.com>
 <1266529083-2358-7-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:46718 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755195Ab0BRVZ1 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 18 Feb 2010 16:25:27 -0500
In-Reply-To: <1266529083-2358-7-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Ameya Palande <ameya.palande@nokia.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, Nishanth Menon <nm@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>

This patch removes variables used to store masks and flags
used for the previous debug implementation.

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 drivers/dsp/bridge/wmd/io_sm.c |    6 +-----
 1 files changed, 1 insertions(+), 5 deletions(-)

diff --git a/drivers/dsp/bridge/wmd/io_sm.c b/drivers/dsp/bridge/wmd/io_sm.c
index 00262db..967fb17 100644
--- a/drivers/dsp/bridge/wmd/io_sm.c
+++ b/drivers/dsp/bridge/wmd/io_sm.c
@@ -166,10 +166,6 @@ extern s32 dsp_max_opps;
 extern u32 vdd1_dsp_freq[6][4] ;
 #endif
 
-#if GT_TRACE
-static struct GT_Mask dsp_trace_mask = { NULL, NULL }; /* GT trace variable */
-#endif
-
 /*
  *  ======== WMD_IO_Create ========
  *      Create an IO manager object.
@@ -2012,5 +2008,5 @@ DSP_STATUS PrintDspTraceBuffer(struct WMD_DEV_CONTEXT *hWmdContext)
 
 void IO_SM_init(void)
 {
-	GT_create(&dsp_trace_mask, "DT"); /* DSP Trace Mask */
+	/* Do nothing */
 }
-- 
1.6.2.4


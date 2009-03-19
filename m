From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: [PATCH 1/1] DSPBRIDGE: Set __GFP_RECLAIMABLE for reloading bridge module
Date: Thu, 19 Mar 2009 11:37:56 +0200
Message-ID: <1237455476-29196-1-git-send-email-Hiroshi.DOYU@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:52706 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752571AbZCSJii (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Mar 2009 05:38:38 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: h-kanigeri2@ti.com
Cc: x0095840@ti.com, ameya.palande@nokia.com, nm@ti.com, grgupta@ti.com, linux-omap@vger.kernel.org, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

To restart DSP system after DSP crash, reloading bridge module is
necessary and a high order page allocation may fail after long use
time because of memory fragmentation. To avoid this, mark it as
reclaimable for immediate reloading.

Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
---
 drivers/dsp/bridge/services/mem.c |   11 ++++++++---
 1 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/dsp/bridge/services/mem.c b/drivers/dsp/bridge/services/mem.c
index 0a10304..3661fb1 100644
--- a/drivers/dsp/bridge/services/mem.c
+++ b/drivers/dsp/bridge/services/mem.c
@@ -357,9 +357,14 @@ void *MEM_AllocPhysMem(u32 cBytes, u32 ulAlign, OUT u32 *pPhysicalAddress)
 		if (extPhysMemPoolEnabled) {
 			pVaMem = MEM_ExtPhysMemAlloc(cBytes, ulAlign,
 						    (u32 *)&paMem);
-		} else
-			pVaMem = dma_alloc_coherent(NULL, cBytes, &paMem,
-                                              (in_atomic()) ? GFP_ATOMIC : GFP_KERNEL);
+		} else {
+			gfp_t gfp = (in_atomic()) ? GFP_ATOMIC : GFP_KERNEL;
+
+			/* To ensure allocation at immediate reloading */
+			gfp |= __GFP_RECLAIMABLE;
+
+			pVaMem = dma_alloc_coherent(NULL, cBytes, &paMem, gfp);
+		}
 		if (pVaMem == NULL) {
 			*pPhysicalAddress = 0;
 			GT_1trace(MEM_debugMask, GT_6CLASS,
-- 
1.5.6.3


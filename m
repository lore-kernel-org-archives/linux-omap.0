From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 03/17] OMAPFB1: remove a non-used table
Date: Wed,  5 Sep 2012 11:25:41 +0300
Message-ID: <1346833555-31258-4-git-send-email-tomi.valkeinen@ti.com>
References: <1346833555-31258-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog136.obsmtp.com ([74.125.149.85]:45350 "EHLO
	na3sys009aog136.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756559Ab2IEI0U (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Sep 2012 04:26:20 -0400
Received: by lagy9 with SMTP id y9so139289lag.19
        for <linux-omap@vger.kernel.org>; Wed, 05 Sep 2012 01:26:17 -0700 (PDT)
In-Reply-To: <1346833555-31258-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, archit@ti.com
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

The old omapfb driver contains a table for DMA element types, which is
not used. Remove it.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap/omapfb_main.c |    9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/video/omap/omapfb_main.c b/drivers/video/omap/omapfb_main.c
index f54b463..4351c43 100644
--- a/drivers/video/omap/omapfb_main.c
+++ b/drivers/video/omap/omapfb_main.c
@@ -131,15 +131,6 @@ static void omapfb_rqueue_unlock(struct omapfb_device *fbdev)
  * LCD controller and LCD DMA
  * ---------------------------------------------------------------------------
  */
-/* Lookup table to map elem size to elem type. */
-static const int dma_elem_type[] = {
-	0,
-	OMAP_DMA_DATA_TYPE_S8,
-	OMAP_DMA_DATA_TYPE_S16,
-	0,
-	OMAP_DMA_DATA_TYPE_S32,
-};
-
 /*
  * Allocate resources needed for LCD controller and LCD DMA operations. Video
  * memory is allocated from system memory according to the virtual display
-- 
1.7.9.5


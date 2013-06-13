From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH v2 2/3] ARM: OMAP: dma: Fix the dma_chan_link_map init order
Date: Thu, 13 Jun 2013 19:47:10 +0530
Message-ID: <1371133031-29229-3-git-send-email-rnayak@ti.com>
References: <1371133031-29229-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:40120 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755225Ab3FMORy (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 13 Jun 2013 10:17:54 -0400
In-Reply-To: <1371133031-29229-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, R Sricharan <r.sricharan@ti.com>

From: R Sricharan <r.sricharan@ti.com>

Init dma_chan_link_map[lch] *after* its memset to 0.

Signed-off-by: R Sricharan <r.sricharan@ti.com>
---
 arch/arm/plat-omap/dma.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
index 2f99331..8a71f75 100644
--- a/arch/arm/plat-omap/dma.c
+++ b/arch/arm/plat-omap/dma.c
@@ -894,11 +894,12 @@ void omap_start_dma(int lch)
 		int next_lch, cur_lch;
 		char dma_chan_link_map[MAX_LOGICAL_DMA_CH_COUNT];
 
-		dma_chan_link_map[lch] = 1;
 		/* Set the link register of the first channel */
 		enable_lnk(lch);
 
 		memset(dma_chan_link_map, 0, sizeof(dma_chan_link_map));
+		dma_chan_link_map[lch] = 1;
+
 		cur_lch = dma_chan[lch].next_lch;
 		do {
 			next_lch = dma_chan[cur_lch].next_lch;
-- 
1.7.9.5


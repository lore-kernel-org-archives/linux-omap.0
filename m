From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH] OMAP: add deprecation message for legacy omap DMA API
Date: Fri, 13 Jun 2014 11:34:48 +0100
Message-ID: <E1WvOoq-0002cL-Q0@rmk-PC.arm.linux.org.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:56613 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752368AbaFMKew (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 Jun 2014 06:34:52 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/plat-omap/dma.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
index b5608b1f9fbd..1c98659bbf89 100644
--- a/arch/arm/plat-omap/dma.c
+++ b/arch/arm/plat-omap/dma.c
@@ -698,6 +698,8 @@ int omap_request_dma(int dev_id, const char *dev_name,
 	unsigned long flags;
 	struct omap_dma_lch *chan;
 
+	WARN(strcmp(dev_name, "DMA engine"), "Using deprecated platform DMA API - please update to DMA engine");
+
 	spin_lock_irqsave(&dma_chan_lock, flags);
 	for (ch = 0; ch < dma_chan_count; ch++) {
 		if (free_ch == -1 && dma_chan[ch].dev_id == -1) {
-- 
1.8.3.1


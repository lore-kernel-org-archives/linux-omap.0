From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH 1/7] arm: plat-omap: dma: make omap_dma_in_1510_mode() static
Date: Tue, 18 Jan 2011 09:52:39 +0200
Message-ID: <1295337165-22934-2-git-send-email-aaro.koskinen@iki.fi>
References: <1295337165-22934-1-git-send-email-aaro.koskinen@iki.fi>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from filtteri2.pp.htv.fi ([213.243.153.185]:37517 "EHLO
	filtteri2.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752446Ab1ARIAG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 Jan 2011 03:00:06 -0500
In-Reply-To: <1295337165-22934-1-git-send-email-aaro.koskinen@iki.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Eliminates the following sparse warning:

	arch/arm/plat-omap/dma.c:137:5: warning: symbol 'omap_dma_in_1510_mode' was not declared. Should it be static?

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 arch/arm/plat-omap/dma.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
index c4b2b47..28cdac2 100644
--- a/arch/arm/plat-omap/dma.c
+++ b/arch/arm/plat-omap/dma.c
@@ -134,7 +134,7 @@ static inline void omap_enable_channel_irq(int lch);
 
 #ifdef CONFIG_ARCH_OMAP15XX
 /* Returns 1 if the DMA module is in OMAP1510-compatible mode, 0 otherwise */
-int omap_dma_in_1510_mode(void)
+static int omap_dma_in_1510_mode(void)
 {
 	return enable_1510_mode;
 }
-- 
1.5.6.5


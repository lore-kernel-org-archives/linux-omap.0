From: Manjunatha GK <manjugk@ti.com>
Subject: [PATCH] OMAP: DMA: Init CDAC to Zero
Date: Wed,  3 Mar 2010 15:25:18 +0530
Message-ID: <1267610118-30748-1-git-send-email-manjugk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48779 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754359Ab0CCJgx (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 3 Mar 2010 04:36:53 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Manjunatha GK <manjugk@ti.com>, Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Govindraj R <govindraj.raja@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>

The register DMA4_CDAC needs to be initialized to zero
before starting DMA transfer.

Cc: Tony Lindgren <tony@atomide.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Govindraj R <govindraj.raja@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Reported-by:S, Venkatraman <svenkatr@ti.com>
Signed-off-by: Manjunatha GK <manjugk@ti.com>
---
It was aligned to reset CDAC to zero in omap_start_dma(int lch)
instead of creating new API for accessing CDAC register.

Discussion thread is at:
http://patchwork.kernel.org/patch/83176/
http://patchwork.kernel.org/patch/82948/


 arch/arm/plat-omap/dma.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
index 2ab224c..96741d4 100644
--- a/arch/arm/plat-omap/dma.c
+++ b/arch/arm/plat-omap/dma.c
@@ -936,6 +936,14 @@ void omap_start_dma(int lch)
 {
 	u32 l;
 
+	/* CPC/CDAC register needs to be initialized to zero
+	 * before starting dma transfer.
+	 */
+	if (cpu_is_omap15xx())
+		dma_write(0, CPC(lch));
+	else
+		dma_write(0, CDAC(lch));
+
 	if (!omap_dma_in_1510_mode() && dma_chan[lch].next_lch != -1) {
 		int next_lch, cur_lch;
 		char dma_chan_link_map[OMAP_DMA4_LOGICAL_DMA_CH_COUNT];
-- 
1.6.0.4


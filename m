From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 1/2] OMAP2+: DMA: Workaround for invalid source position
Date: Mon,  7 Nov 2011 11:33:06 +0200
Message-ID: <1320658387-21067-2-git-send-email-peter.ujfalusi@ti.com>
References: <1320658387-21067-1-git-send-email-peter.ujfalusi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:42112 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751894Ab1KGJdZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Nov 2011 04:33:25 -0500
Received: by bke11 with SMTP id 11so4540987bke.5
        for <linux-omap@vger.kernel.org>; Mon, 07 Nov 2011 01:33:23 -0800 (PST)
In-Reply-To: <1320658387-21067-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Jarkko Nikula <jarkko.nikula@bitmer.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

If the DMA source position has been asked before the
first actual data transfer has been done, the CSAC
register does not contain valid information.
We can identify this situation by checking the CDAC
register:
CDAC != 0 indicates that the DMA transfer on the channel has
been started already.
When CDAC == 0 we can not trust the CSAC value since it has
not been updated, and can contain random number.
Return the start address in case the DMA has not jet started.

Note: The CDAC register has been initialized to 0 at dma_start
time.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/plat-omap/dma.c |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
index c22217c..a9983b6 100644
--- a/arch/arm/plat-omap/dma.c
+++ b/arch/arm/plat-omap/dma.c
@@ -1034,6 +1034,18 @@ dma_addr_t omap_get_dma_src_pos(int lch)
 	if (IS_DMA_ERRATA(DMA_ERRATA_3_3) && offset == 0)
 		offset = p->dma_read(CSAC, lch);
 
+	if (!cpu_is_omap15xx()) {
+		/*
+		 * CDAC == 0 indicates that the DMA transfer on the channel has
+		 * not been started (no data has been transferred so far).
+		 * Return the programmed source start address in this case.
+		 */
+		if (likely(p->dma_read(CDAC, lch)))
+			offset = p->dma_read(CSAC, lch);
+		else
+			offset = p->dma_read(CSSA, lch);
+	}
+
 	if (cpu_class_is_omap1())
 		offset |= (p->dma_read(CSSA, lch) & 0xFFFF0000);
 
-- 
1.7.7.2


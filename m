From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 2/2] OMAP2+: DMA: Workaround for invalid destination position
Date: Mon,  7 Nov 2011 11:33:07 +0200
Message-ID: <1320658387-21067-3-git-send-email-peter.ujfalusi@ti.com>
References: <1320658387-21067-1-git-send-email-peter.ujfalusi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog122.obsmtp.com ([74.125.149.147]:41867 "EHLO
	na3sys009aog122.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752374Ab1KGJd1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Nov 2011 04:33:27 -0500
Received: by bkbzt4 with SMTP id zt4so4827377bkb.1
        for <linux-omap@vger.kernel.org>; Mon, 07 Nov 2011 01:33:24 -0800 (PST)
In-Reply-To: <1320658387-21067-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Jarkko Nikula <jarkko.nikula@bitmer.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

If the DMA destination position has been asked before the
first actual data transfer has been done, the CDAC
register still contains 0 (it is initialized to 0 at
omsp_dma_start).
If CDAC == 0, return the programmed start address.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/plat-omap/dma.c |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
index a9983b6..002fb4d 100644
--- a/arch/arm/plat-omap/dma.c
+++ b/arch/arm/plat-omap/dma.c
@@ -1074,8 +1074,16 @@ dma_addr_t omap_get_dma_dst_pos(int lch)
 	 * omap 3.2/3.3 erratum: sometimes 0 is returned if CSAC/CDAC is
 	 * read before the DMA controller finished disabling the channel.
 	 */
-	if (!cpu_is_omap15xx() && offset == 0)
+	if (!cpu_is_omap15xx() && offset == 0) {
 		offset = p->dma_read(CDAC, lch);
+		/*
+		 * CDAC == 0 indicates that the DMA transfer on the channel has
+		 * not been started (no data has been transferred so far).
+		 * Return the programmed destination start address in this case.
+		 */
+		if (unlikely(!offset))
+			offset = p->dma_read(CDSA, lch);
+	}
 
 	if (cpu_class_is_omap1())
 		offset |= (p->dma_read(CDSA, lch) & 0xFFFF0000);
-- 
1.7.7.2


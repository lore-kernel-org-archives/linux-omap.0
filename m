From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 1/2] OMAP2+: DMA: Workaround for invalid source position
Date: Mon, 31 Oct 2011 16:20:16 +0200
Message-ID: <1320070817-9638-2-git-send-email-peter.ujfalusi@ti.com>
References: <1320070817-9638-1-git-send-email-peter.ujfalusi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:33914 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754949Ab1JaOUt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 31 Oct 2011 10:20:49 -0400
Received: by mail-fx0-f54.google.com with SMTP id r19so7815587faa.41
        for <linux-omap@vger.kernel.org>; Mon, 31 Oct 2011 07:20:48 -0700 (PDT)
In-Reply-To: <1320070817-9638-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Jarkko Nikula <jarkko.nikula@bitmer.com>, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org

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
 arch/arm/plat-omap/dma.c |   15 +++++++++++++--
 1 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
index c22217c..38b0d44 100644
--- a/arch/arm/plat-omap/dma.c
+++ b/arch/arm/plat-omap/dma.c
@@ -1024,12 +1024,23 @@ EXPORT_SYMBOL(omap_set_dma_callback);
  */
 dma_addr_t omap_get_dma_src_pos(int lch)
 {
+	u32 cdac;
 	dma_addr_t offset = 0;
 
 	if (cpu_is_omap15xx())
 		offset = p->dma_read(CPC, lch);
-	else
-		offset = p->dma_read(CSAC, lch);
+	else {
+		/*
+		 * CDAC == 0 indicates that the DMA transfer on the channel has
+		 * not been started (no data has been transferred so far).
+		 * Return the programmed source start address in this case.
+		 */
+		cdac = p->dma_read(CDAC, lch);
+		if (likely(cdac))
+			offset = p->dma_read(CSAC, lch);
+		else
+			offset = p->dma_read(CSSA, lch);
+	}
 
 	if (IS_DMA_ERRATA(DMA_ERRATA_3_3) && offset == 0)
 		offset = p->dma_read(CSAC, lch);
-- 
1.7.7.1


From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 2/2] OMAP2+: DMA: Workaround for invalid destination position
Date: Mon, 31 Oct 2011 16:20:17 +0200
Message-ID: <1320070817-9638-3-git-send-email-peter.ujfalusi@ti.com>
References: <1320070817-9638-1-git-send-email-peter.ujfalusi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog119.obsmtp.com ([74.125.149.246]:41137 "EHLO
	na3sys009aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754949Ab1JaOUw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 31 Oct 2011 10:20:52 -0400
Received: by faaf16 with SMTP id f16so7491779faa.36
        for <linux-omap@vger.kernel.org>; Mon, 31 Oct 2011 07:20:50 -0700 (PDT)
In-Reply-To: <1320070817-9638-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Jarkko Nikula <jarkko.nikula@bitmer.com>, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org

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
index 38b0d44..9186491 100644
--- a/arch/arm/plat-omap/dma.c
+++ b/arch/arm/plat-omap/dma.c
@@ -1066,8 +1066,16 @@ dma_addr_t omap_get_dma_dst_pos(int lch)
 
 	if (cpu_is_omap15xx())
 		offset = p->dma_read(CPC, lch);
-	else
+	else {
 		offset = p->dma_read(CDAC, lch);
+		/*
+		 * CDAC == 0 indicates that the DMA transfer on the channel has
+		 * not been started (no data has been transferred so far).
+		 * Return the programmed destination start address in this case.
+		 */
+		if (unlikely(!offset))
+			offset = p->dma_read(CDSA, lch);
+	}
 
 	/*
 	 * omap 3.2/3.3 erratum: sometimes 0 is returned if CSAC/CDAC is
-- 
1.7.7.1


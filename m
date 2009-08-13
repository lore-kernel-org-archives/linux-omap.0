From: Eduardo Valentin <eduardo.valentin@nokia.com>
Subject: [PATCHv3 16/20] ASoC: OMAP: Enable DMA burst mode
Date: Thu, 13 Aug 2009 17:35:29 +0300
Message-ID: <1250174133-451-17-git-send-email-eduardo.valentin@nokia.com>
References: <1250174133-451-1-git-send-email-eduardo.valentin@nokia.com>
 <1250174133-451-2-git-send-email-eduardo.valentin@nokia.com>
 <1250174133-451-3-git-send-email-eduardo.valentin@nokia.com>
 <1250174133-451-4-git-send-email-eduardo.valentin@nokia.com>
 <1250174133-451-5-git-send-email-eduardo.valentin@nokia.com>
 <1250174133-451-6-git-send-email-eduardo.valentin@nokia.com>
 <1250174133-451-7-git-send-email-eduardo.valentin@nokia.com>
 <1250174133-451-8-git-send-email-eduardo.valentin@nokia.com>
 <1250174133-451-9-git-send-email-eduardo.valentin@nokia.com>
 <1250174133-451-10-git-send-email-eduardo.valentin@nokia.com>
 <1250174133-451-11-git-send-email-eduardo.valentin@nokia.com>
 <1250174133-451-12-git-send-email-eduardo.valentin@nokia.com>
 <1250174133-451-13-git-send-email-eduardo.valentin@nokia.com>
 <1250174133-451-14-git-send-email-eduardo.valentin@nokia.com>
 <1250174133-451-15-git-send-email-eduardo.valentin@nokia.com>
 <1250174133-451-16-git-send-email-eduardo.valentin@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:57810 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754044AbZHMOsu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Aug 2009 10:48:50 -0400
In-Reply-To: <1250174133-451-16-git-send-email-eduardo.valentin@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux-OMAP <linux-omap@vger.kernel.org>, ALSA-Devel <alsa-devel@vger.kernel.org>
Cc: Jarkko Nikula <jhnikula@gmail.com>, "\\\"Ujfalusi Peter (Nokia-D/Tampere)\\\"" <peter.ujfalusi@nokia.com>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>, Eduardo Valentin <eduardo.valentin@nokia.com>

Signed-off-by: Eduardo Valentin <eduardo.valentin@nokia.com>
---
 sound/soc/omap/omap-pcm.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/sound/soc/omap/omap-pcm.c b/sound/soc/omap/omap-pcm.c
index 2422a42..5d41371 100644
--- a/sound/soc/omap/omap-pcm.c
+++ b/sound/soc/omap/omap-pcm.c
@@ -176,6 +176,9 @@ static int omap_pcm_prepare(struct snd_pcm_substream *substream)
 
 	omap_enable_dma_irq(prtd->dma_ch, OMAP_DMA_FRAME_IRQ);
 
+	omap_set_dma_src_burst_mode(prtd->dma_ch, OMAP_DMA_DATA_BURST_16);
+	omap_set_dma_dest_burst_mode(prtd->dma_ch, OMAP_DMA_DATA_BURST_16);
+
 	return 0;
 }
 
-- 
1.6.2.GIT


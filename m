From: Eduardo Valentin <eduardo.valentin@nokia.com>
Subject: [PATCHv2 18/20] ASoC: OMAP: Enable DMA burst mode
Date: Tue, 11 Aug 2009 16:05:29 +0300
Message-ID: <1249995931-26015-19-git-send-email-eduardo.valentin@nokia.com>
References: <1249995931-26015-1-git-send-email-eduardo.valentin@nokia.com>
 <1249995931-26015-2-git-send-email-eduardo.valentin@nokia.com>
 <1249995931-26015-3-git-send-email-eduardo.valentin@nokia.com>
 <1249995931-26015-4-git-send-email-eduardo.valentin@nokia.com>
 <1249995931-26015-5-git-send-email-eduardo.valentin@nokia.com>
 <1249995931-26015-6-git-send-email-eduardo.valentin@nokia.com>
 <1249995931-26015-7-git-send-email-eduardo.valentin@nokia.com>
 <1249995931-26015-8-git-send-email-eduardo.valentin@nokia.com>
 <1249995931-26015-9-git-send-email-eduardo.valentin@nokia.com>
 <1249995931-26015-10-git-send-email-eduardo.valentin@nokia.com>
 <1249995931-26015-11-git-send-email-eduardo.valentin@nokia.com>
 <1249995931-26015-12-git-send-email-eduardo.valentin@nokia.com>
 <1249995931-26015-13-git-send-email-eduardo.valentin@nokia.com>
 <1249995931-26015-14-git-send-email-eduardo.valentin@nokia.com>
 <1249995931-26015-15-git-send-email-eduardo.valentin@nokia.com>
 <1249995931-26015-16-git-send-email-eduardo.valentin@nokia.com>
 <1249995931-26015-17-git-send-email-eduardo.valentin@nokia.com>
 <1249995931-26015-18-git-send-email-eduardo.valentin@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:19812 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754413AbZHKNSn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 Aug 2009 09:18:43 -0400
In-Reply-To: <1249995931-26015-18-git-send-email-eduardo.valentin@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux-OMAP <linux-omap@vger.kernel.org>, ALSA-Devel <alsa-devel@vger.kernel.org>
Cc: Jarkko Nikula <jhnikula@gmail.com>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>, "\\\"Ujfalusi Peter (Nokia-D/Tampere)\\\"" <peter.ujfalusi@nokia.com>, Eduardo Valentin <eduardo.valentin@nokia.com>

From: Eduardo Valentin <eduardo.valentin@nokia.com>

Signed-off-by: Eduardo Valentin <eduardo.valentin@nokia.com>
---
 sound/soc/omap/omap-pcm.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/sound/soc/omap/omap-pcm.c b/sound/soc/omap/omap-pcm.c
index b41a18b..4506603 100644
--- a/sound/soc/omap/omap-pcm.c
+++ b/sound/soc/omap/omap-pcm.c
@@ -185,6 +185,9 @@ static int omap_pcm_prepare(struct snd_pcm_substream *substream)
 
 	omap_enable_dma_irq(prtd->dma_ch, OMAP_DMA_FRAME_IRQ);
 
+	omap_set_dma_src_burst_mode(prtd->dma_ch, OMAP_DMA_DATA_BURST_16);
+	omap_set_dma_dest_burst_mode(prtd->dma_ch, OMAP_DMA_DATA_BURST_16);
+
 	return 0;
 }
 
-- 
1.6.2.GIT


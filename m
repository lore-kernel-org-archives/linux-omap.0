From: Eduardo Valentin <eduardo.valentin@nokia.com>
Subject: [PATCHv4 16/20] ASoC: OMAP: Enable DMA burst mode
Date: Mon, 17 Aug 2009 14:51:15 +0300
Message-ID: <1250509879-6703-17-git-send-email-eduardo.valentin@nokia.com>
References: <1250509879-6703-1-git-send-email-eduardo.valentin@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:23230 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757903AbZHQMFW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Aug 2009 08:05:22 -0400
In-Reply-To: <1250509879-6703-1-git-send-email-eduardo.valentin@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Linux-OMAP <linux-omap@vger.kernel.org>, ALSA-Devel <alsa-devel@vger.kernel.org>, Jarkko Nikula <jhnikula@gmail.com>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>, "Ujfalusi Peter (Nokia-D/Tampere)" <peter.ujfalusi@nokia.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Eduardo Valentin <eduardo.valentin@nokia.com>

From: Eduardo Valentin <eduardo.valentin@nokia.com>

Signed-off-by: Eduardo Valentin <eduardo.valentin@nokia.com>
---
 sound/soc/omap/omap-pcm.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/sound/soc/omap/omap-pcm.c b/sound/soc/omap/omap-pcm.c
index f769a52..f037db0 100644
--- a/sound/soc/omap/omap-pcm.c
+++ b/sound/soc/omap/omap-pcm.c
@@ -193,6 +193,9 @@ static int omap_pcm_prepare(struct snd_pcm_substream *substream)
 	omap_enable_dma_irq(prtd->dma_ch, OMAP_DMA_FRAME_IRQ |
 				(cpu_is_omap1510() ? OMAP_DMA_LAST_IRQ : 0));
 
+	omap_set_dma_src_burst_mode(prtd->dma_ch, OMAP_DMA_DATA_BURST_16);
+	omap_set_dma_dest_burst_mode(prtd->dma_ch, OMAP_DMA_DATA_BURST_16);
+
 	return 0;
 }
 
-- 
1.6.2.GIT


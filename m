From: Eduardo Valentin <eduardo.valentin@nokia.com>
Subject: [PATCH 18/20] ASoC: OMAP: Enable DMA burst mode
Date: Thu, 30 Jul 2009 15:49:41 +0300
Message-ID: <1248958183-15015-19-git-send-email-eduardo.valentin@nokia.com>
References: <1248958183-15015-1-git-send-email-eduardo.valentin@nokia.com>
 <1248958183-15015-2-git-send-email-eduardo.valentin@nokia.com>
 <1248958183-15015-3-git-send-email-eduardo.valentin@nokia.com>
 <1248958183-15015-4-git-send-email-eduardo.valentin@nokia.com>
 <1248958183-15015-5-git-send-email-eduardo.valentin@nokia.com>
 <1248958183-15015-6-git-send-email-eduardo.valentin@nokia.com>
 <1248958183-15015-7-git-send-email-eduardo.valentin@nokia.com>
 <1248958183-15015-8-git-send-email-eduardo.valentin@nokia.com>
 <1248958183-15015-9-git-send-email-eduardo.valentin@nokia.com>
 <1248958183-15015-10-git-send-email-eduardo.valentin@nokia.com>
 <1248958183-15015-11-git-send-email-eduardo.valentin@nokia.com>
 <1248958183-15015-12-git-send-email-eduardo.valentin@nokia.com>
 <1248958183-15015-13-git-send-email-eduardo.valentin@nokia.com>
 <1248958183-15015-14-git-send-email-eduardo.valentin@nokia.com>
 <1248958183-15015-15-git-send-email-eduardo.valentin@nokia.com>
 <1248958183-15015-16-git-send-email-eduardo.valentin@nokia.com>
 <1248958183-15015-17-git-send-email-eduardo.valentin@nokia.com>
 <1248958183-15015-18-git-send-email-eduardo.valentin@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:37378 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751198AbZG3NBE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 30 Jul 2009 09:01:04 -0400
In-Reply-To: <1248958183-15015-18-git-send-email-eduardo.valentin@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, alsa-devel@vger.kernel.org
Cc: Jarkko Nikula <jhnikula@gmail.com>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, Eduardo Valentin <eduardo.valentin@nokia.com>

Signed-off-by: Eduardo Valentin <eduardo.valentin@nokia.com>
---
 sound/soc/omap/omap-pcm.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/sound/soc/omap/omap-pcm.c b/sound/soc/omap/omap-pcm.c
index a18b3bf..a30e7a0 100644
--- a/sound/soc/omap/omap-pcm.c
+++ b/sound/soc/omap/omap-pcm.c
@@ -184,6 +184,9 @@ static int omap_pcm_prepare(struct snd_pcm_substream *substream)
 
 	omap_enable_dma_irq(prtd->dma_ch, OMAP_DMA_FRAME_IRQ);
 
+	omap_set_dma_src_burst_mode(prtd->dma_ch, OMAP_DMA_DATA_BURST_16);
+	omap_set_dma_dest_burst_mode(prtd->dma_ch, OMAP_DMA_DATA_BURST_16);
+
 	return 0;
 }
 
-- 
1.6.2.GIT


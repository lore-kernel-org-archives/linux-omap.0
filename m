From: "Arun KS" <arunks@mistralsolutions.com>
Subject: [PATCH 4/5 v1] ASoC adds destination and source port for dma
Date: Tue, 30 Sep 2008 15:35:16 +0530
Message-ID: <dfeb90390809300305o69fc4c20wc54b0dfa27b84fd9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.225]:36349 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751446AbYI3KFT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 30 Sep 2008 06:05:19 -0400
Received: by rv-out-0506.google.com with SMTP id k40so2789370rvb.1
        for <linux-omap@vger.kernel.org>; Tue, 30 Sep 2008 03:05:19 -0700 (PDT)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>, Jarkko Nikula <jarkko.nikula@nokia.com>, felipe.balbi@nokia.com

Adds destination and source port for dma in platform driver as
required by OMAP1

Signed-off-by: Arun KS <arunks@mistralsolutions.com>
---
 sound/soc/omap/omap-pcm.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/sound/soc/omap/omap-pcm.c b/sound/soc/omap/omap-pcm.c
index 690bfea..e9084fd 100644
--- a/sound/soc/omap/omap-pcm.c
+++ b/sound/soc/omap/omap-pcm.c
@@ -97,7 +97,7 @@ static int omap_pcm_hw_params(struct
snd_pcm_substream *substream,
 	prtd->dma_data = dma_data;
 	err = omap_request_dma(dma_data->dma_req, dma_data->name,
 			       omap_pcm_dma_irq, substream, &prtd->dma_ch);
-	if (!cpu_is_omap1510()) {
+	if (!err & !cpu_is_omap1510()) {
 		/*
 		 * Link channel with itself so DMA doesn't need any
 		 * reprogramming while looping the buffer
@@ -147,12 +147,14 @@ static int omap_pcm_prepare(struct
snd_pcm_substream *substream)
 		dma_params.src_or_dst_synch	= OMAP_DMA_DST_SYNC;
 		dma_params.src_start		= runtime->dma_addr;
 		dma_params.dst_start		= dma_data->port_addr;
+		dma_params.dst_port		= OMAP_DMA_PORT_MPUI;
 	} else {
 		dma_params.src_amode		= OMAP_DMA_AMODE_CONSTANT;
 		dma_params.dst_amode		= OMAP_DMA_AMODE_POST_INC;
 		dma_params.src_or_dst_synch	= OMAP_DMA_SRC_SYNC;
 		dma_params.src_start		= dma_data->port_addr;
 		dma_params.dst_start		= runtime->dma_addr;
+		dma_params.src_port		= OMAP_DMA_PORT_MPUI;
 	}
 	/*
 	 * Set DMA transfer frame size equal to ALSA period size and frame
-- 
1.5.3.4

From: "Arun KS" <arunks@mistralsolutions.com>
Subject: [PATCH 4/5] [RFC] ALSA ASOC adds destination and source port for dma
Date: Mon, 29 Sep 2008 15:23:52 +0530
Message-ID: <dfeb90390809290253kdf153b6p9993882e495f5e5c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.237]:39922 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752252AbYI2Jxw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Sep 2008 05:53:52 -0400
Received: by rv-out-0506.google.com with SMTP id k40so2167163rvb.1
        for <linux-omap@vger.kernel.org>; Mon, 29 Sep 2008 02:53:52 -0700 (PDT)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>, alsa-devel@vger.kernel.org
Cc: Jarkko Nikula <jarkko.nikula@nokia.com>, felipe.balbi@nokia.com

Adds destination and source ports for dma which is required for OMAP1

Signed-off-by: Arun KS <arunks@mistralsolutions.com>
---
 sound/soc/omap/omap-pcm.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/sound/soc/omap/omap-pcm.c b/sound/soc/omap/omap-pcm.c
index 690bfea..9e670ef 100644
--- a/sound/soc/omap/omap-pcm.c
+++ b/sound/soc/omap/omap-pcm.c
@@ -97,6 +97,7 @@ static int omap_pcm_hw_params(struct
snd_pcm_substream *substream,
 	prtd->dma_data = dma_data;
 	err = omap_request_dma(dma_data->dma_req, dma_data->name,
 			       omap_pcm_dma_irq, substream, &prtd->dma_ch);
+
 	if (!cpu_is_omap1510()) {
 		/*
 		 * Link channel with itself so DMA doesn't need any
@@ -147,12 +148,14 @@ static int omap_pcm_prepare(struct
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

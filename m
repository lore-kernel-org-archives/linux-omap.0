From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: Calling omap_pcm_prepare() results in BUG() on OMAP1
Date: Wed, 21 Oct 2009 05:11:06 +0200
Message-ID: <200910210511.08263.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from d1.icnet.pl ([212.160.220.21]:37370 "EHLO d1.icnet.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751438AbZJUDLb (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 20 Oct 2009 23:11:31 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,
After DMA burst mode has been introduced in sound/soc/omap/omap-pcm.c, 
omap_pcm_prepare() unconditionally calls:

	omap_set_dma_src_burst_mode(prtd->dma_ch, OMAP_DMA_DATA_BURST_16);
	omap_set_dma_dest_burst_mode(prtd->dma_ch, OMAP_DMA_DATA_BURST_16);

AFAICS, current implementation of those two functions found in 
arch/arm/plat-ompa/dma.c doesn't support OMAP_DMA_DATA_BURST_16 on OMAP1 at 
all, so they both end with BUG() on that machine. That seems to result in 
ASoC being completely unusable, at least on my OMAP5910 based Amstrad Delta.

Is calling BUG() for OMAP1 from those functions intentional?

If not intentional, can those be corrected by simply putting break; before 
defalut:?

If intentional, can those function calls be conditionally omited, at least for 
OMAP1510, in sound/soc/omap/omap-pcm.c?

Thanks,
Janusz

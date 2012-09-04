From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [RFC update 0/2] dmaengine/ASoC: omap: Enable element mode in cyclic DMA
Date: Tue,  4 Sep 2012 15:08:00 +0300
Message-ID: <1346760482-12794-1-git-send-email-peter.ujfalusi@ti.com>
References: <E1T8a09-0002vz-Bl@rmk-PC.arm.linux.org.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog136.obsmtp.com ([74.125.149.85]:39738 "EHLO
	na3sys009aog136.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756818Ab2IDMH5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 4 Sep 2012 08:07:57 -0400
Received: by obbuo13 with SMTP id uo13so10750055obb.19
        for <linux-omap@vger.kernel.org>; Tue, 04 Sep 2012 05:07:56 -0700 (PDT)
In-Reply-To: <E1T8a09-0002vz-Bl@rmk-PC.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King <rmk+kernel@arm.linux.org.uk>, Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

Hi Russell,

Enable the element mode (thus allowing mono playback and probably unblocking
OMAP1, OMAP2420) in OMAP dmaengine and omap-pcm.

Janusz: would it be possible for you to test Russell's series plus this on
OMAP1 to make sure that we do not broke it?

Russell: we should wait for Janusz to test this on OMAP1. Based on the feedback
we can plan on how to proceed with the dmaengine for OMAP audio.

Regards,
Peter
---
Peter Ujfalusi (2):
  dmaengine: omap: Support for element mode in cyclic DMA
  ASoC: omap-pcm: Do not check DMA sync_mode

 drivers/dma/omap-dma.c    |  5 ++++-
 sound/soc/omap/omap-pcm.c | 10 ----------
 2 files changed, 4 insertions(+), 11 deletions(-)

-- 
1.7.12


From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [RFC 2/3] Fix "ASoC: dmaengine: Don't use runtime private data for
 dmaengine data"
Date: Mon, 03 Sep 2012 17:59:33 +0100
Message-ID: <E1T8Zzp-0002vv-7e@rmk-PC.arm.linux.org.uk>
References: <20120903165832.GA31511@n2100.arm.linux.org.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:50994 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756418Ab2ICQ7h (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 Sep 2012 12:59:37 -0400
In-Reply-To: <20120903165832.GA31511@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org

The above commit was not initializing the correct substream runtime
member with the ASoC DMA engine runtime data.  Fix that.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 sound/soc/soc-dmaengine-pcm.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/soc-dmaengine-pcm.c b/sound/soc/soc-dmaengine-pcm.c
index 27fa5ad..6fb9a2a 100644
--- a/sound/soc/soc-dmaengine-pcm.c
+++ b/sound/soc/soc-dmaengine-pcm.c
@@ -293,7 +293,7 @@ int snd_dmaengine_pcm_open(struct snd_pcm_substream *substream,
 		return ret;
 	}
 
-	substream->runtime->private_data = prtd;
+	substream->runtime->dmaengine_data = prtd;
 
 	return 0;
 }
-- 
1.7.4.4


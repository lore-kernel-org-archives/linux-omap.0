From: Liam Girdwood <lrg@ti.com>
Subject: [RFC 1/3] ASoC: dmaengine: Don't use runtime private data for
 dmaengine data
Date: Mon, 03 Sep 2012 17:59:13 +0100
Message-ID: <E1T8ZzV-0002vp-2j@rmk-PC.arm.linux.org.uk>
References: <20120903165832.GA31511@n2100.arm.linux.org.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:50986 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756495Ab2ICQ7T (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 Sep 2012 12:59:19 -0400
In-Reply-To: <20120903165832.GA31511@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org

Use a dedicated member to store dmaengine data so that drivers can
use private data for their own purposes.

Signed-off-by: Liam Girdwood <lrg@ti.com>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 include/sound/pcm.h           |    2 ++
 sound/soc/soc-dmaengine-pcm.c |    2 +-
 2 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/include/sound/pcm.h b/include/sound/pcm.h
index cdca2ab..f9e4909 100644
--- a/include/sound/pcm.h
+++ b/include/sound/pcm.h
@@ -269,6 +269,7 @@ struct snd_pcm_hw_constraint_list {
 };
 
 struct snd_pcm_hwptr_log;
+struct dmaengine_pcm_runtime_data;
 
 struct snd_pcm_runtime {
 	/* -- Status -- */
@@ -345,6 +346,7 @@ struct snd_pcm_runtime {
 	unsigned char *dma_area;	/* DMA area */
 	dma_addr_t dma_addr;		/* physical bus address (not accessible from main CPU) */
 	size_t dma_bytes;		/* size of DMA area */
+	struct dmaengine_pcm_runtime_data *dmaengine_data;
 
 	struct snd_dma_buffer *dma_buffer_p;	/* allocated buffer */
 
diff --git a/sound/soc/soc-dmaengine-pcm.c b/sound/soc/soc-dmaengine-pcm.c
index 5df529e..27fa5ad 100644
--- a/sound/soc/soc-dmaengine-pcm.c
+++ b/sound/soc/soc-dmaengine-pcm.c
@@ -40,7 +40,7 @@ struct dmaengine_pcm_runtime_data {
 static inline struct dmaengine_pcm_runtime_data *substream_to_prtd(
 	const struct snd_pcm_substream *substream)
 {
-	return substream->runtime->private_data;
+	return substream->runtime->dmaengine_data;
 }
 
 /**
-- 
1.7.4.4


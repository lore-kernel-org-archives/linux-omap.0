From: "J.D. Schroeder" <Linux.HWI@garmin.com>
Subject: [PATCH] ASoC: omap-pcm: Initialize DMA configuration
Date: Mon, 25 Apr 2016 11:10:07 -0500
Message-ID: <1461600607-19582-1-git-send-email-Linux.HWI@garmin.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, peter.ujfalusi@ti.com, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, jarkko.nikula@bitmer.com, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org
Cc: Jim Lodes <jim.lodes@garmin.com>, "J.D. Schroeder" <jay.schroeder@garmin.com>
List-Id: linux-omap@vger.kernel.org

From: Jim Lodes <jim.lodes@garmin.com>

Initialize the dma_slave_config for PCM DMA transfers,
instead of leaving it uninitialized. Keeps previous data on
the stack from giving us invalid values in uninitialized
members of the config structure.

Signed-off-by: Jim Lodes <jim.lodes@garmin.com>
Signed-off-by: J.D. Schroeder <jay.schroeder@garmin.com>
---
 sound/soc/omap/omap-pcm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/omap/omap-pcm.c b/sound/soc/omap/omap-pcm.c
index 99381a2..a84f677 100644
--- a/sound/soc/omap/omap-pcm.c
+++ b/sound/soc/omap/omap-pcm.c
@@ -82,6 +82,8 @@ static int omap_pcm_hw_params(struct snd_pcm_substream *substream,
 	struct dma_chan *chan;
 	int err = 0;
 
+	memset(&config, 0x00, sizeof(config));
+
 	dma_data = snd_soc_dai_get_dma_data(rtd->cpu_dai, substream);
 
 	/* return if this is a bufferless transfer e.g.
-- 
1.9.1

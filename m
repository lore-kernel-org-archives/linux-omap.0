From: Eduardo Valentin <eduardo.valentin@nokia.com>
Subject: [PATCHv4 15/20] ASoC: OMAP: Make DMA 64 aligned
Date: Mon, 17 Aug 2009 17:35:19 +0300
Message-ID: <1250519719-14690-1-git-send-email-eduardo.valentin@nokia.com>
References: <20090817140055.GX7278@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20090817140055.GX7278@atomide.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>, Eduardo Valentin <eduardo.valentin@nokia.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "Ujfalusi Peter (Nokia-D/Tampere)" <peter.ujfalusi@nokia.com>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>, Linux-OMAP <linux-omap@vger.kernel.org>, ALSA-Devel <alsa-devel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

From: Eduardo Valentin <eduardo.valentin@nokia.com>

Align DMA address to DMA burst transaction sizes.

Signed-off-by: Eduardo Valentin <eduardo.valentin@nokia.com>
---
 sound/soc/omap/omap-pcm.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/omap/omap-pcm.c b/sound/soc/omap/omap-pcm.c
index dd9e728..f769a52 100644
--- a/sound/soc/omap/omap-pcm.c
+++ b/sound/soc/omap/omap-pcm.c
@@ -305,7 +305,7 @@ static struct snd_pcm_ops omap_pcm_ops = {
 	.mmap		= omap_pcm_mmap,
 };
 
-static u64 omap_pcm_dmamask = DMA_BIT_MASK(32);
+static u64 omap_pcm_dmamask = DMA_BIT_MASK(64);
 
 static int omap_pcm_preallocate_dma_buffer(struct snd_pcm *pcm,
 	int stream)
@@ -355,7 +355,7 @@ static int omap_pcm_new(struct snd_card *card, struct snd_soc_dai *dai,
 	if (!card->dev->dma_mask)
 		card->dev->dma_mask = &omap_pcm_dmamask;
 	if (!card->dev->coherent_dma_mask)
-		card->dev->coherent_dma_mask = DMA_BIT_MASK(32);
+		card->dev->coherent_dma_mask = DMA_BIT_MASK(64);
 
 	if (dai->playback.channels_min) {
 		ret = omap_pcm_preallocate_dma_buffer(pcm,
-- 
1.6.2.GIT


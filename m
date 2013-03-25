From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] ASoC: omap: Call omap_mcbsp_set_threshold()
	from mcbsp hw_params
Date: Mon, 25 Mar 2013 16:58:16 +0100
Message-ID: <1364227096-12232-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: linux-omap@vger.kernel.org

The omap PCM driver provides a set_threshold callback which gets called by the
PCM driver when either playback or capture is started. The only DAI driver which
sets this callback is the mcbsp driver. This patch removes the callback from the
PCM driver and moves the invocation of the omap_mcbsp_set_threshold() function
to the mcbsp hw_params callback since this is the only place where the threshold
size can change. Doing so allows us to use the default dmaengine PCM trigger
callback in the omap PCM driver.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>

---
Only compile tested, but I don't see why it should not work

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/omap/omap-mcbsp.c | 12 +++++-------
 sound/soc/omap/omap-pcm.c   | 33 +--------------------------------
 sound/soc/omap/omap-pcm.h   |  1 -
 3 files changed, 6 insertions(+), 40 deletions(-)

diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
index 8d2defd..406fc87 100644
--- a/sound/soc/omap/omap-mcbsp.c
+++ b/sound/soc/omap/omap-mcbsp.c
@@ -62,24 +62,22 @@ enum {
  * Stream DMA parameters. DMA request line and port address are set runtime
  * since they are different between OMAP1 and later OMAPs
  */
-static void omap_mcbsp_set_threshold(struct snd_pcm_substream *substream)
+static void omap_mcbsp_set_threshold(struct snd_pcm_substream *substream,
+		unsigned int packet_size)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 	struct omap_mcbsp *mcbsp = snd_soc_dai_get_drvdata(cpu_dai);
-	struct omap_pcm_dma_data *dma_data;
 	int words;
 
-	dma_data = snd_soc_dai_get_dma_data(rtd->cpu_dai, substream);
-
 	/*
 	 * Configure McBSP threshold based on either:
 	 * packet_size, when the sDMA is in packet mode, or based on the
 	 * period size in THRESHOLD mode, otherwise use McBSP threshold = 1
 	 * for mono streams.
 	 */
-	if (dma_data->packet_size)
-		words = dma_data->packet_size;
+	if (packet_size)
+		words = packet_size;
 	else
 		words = 1;
 
@@ -245,7 +243,6 @@ static int omap_mcbsp_dai_hw_params(struct snd_pcm_substream *substream,
 		return -EINVAL;
 	}
 	if (mcbsp->pdata->buffer_size) {
-		dma_data->set_threshold = omap_mcbsp_set_threshold;
 		if (mcbsp->dma_op_mode == MCBSP_DMA_MODE_THRESHOLD) {
 			int period_words, max_thrsh;
 			int divider = 0;
@@ -276,6 +273,7 @@ static int omap_mcbsp_dai_hw_params(struct snd_pcm_substream *substream,
 			/* Use packet mode for non mono streams */
 			pkt_size = channels;
 		}
+		omap_mcbsp_set_threshold(substream, pkt_size);
 	}
 
 	dma_data->packet_size = pkt_size;
diff --git a/sound/soc/omap/omap-pcm.c b/sound/soc/omap/omap-pcm.c
index c722c2e..1626fb7 100644
--- a/sound/soc/omap/omap-pcm.c
+++ b/sound/soc/omap/omap-pcm.c
@@ -129,37 +129,6 @@ static int omap_pcm_hw_free(struct snd_pcm_substream *substream)
 	return 0;
 }
 
-static int omap_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
-{
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct omap_pcm_dma_data *dma_data;
-	int ret = 0;
-
-	dma_data = snd_soc_dai_get_dma_data(rtd->cpu_dai, substream);
-
-	switch (cmd) {
-	case SNDRV_PCM_TRIGGER_START:
-	case SNDRV_PCM_TRIGGER_RESUME:
-	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
-		/* Configure McBSP internal buffer usage */
-		if (dma_data->set_threshold)
-			dma_data->set_threshold(substream);
-		break;
-
-	case SNDRV_PCM_TRIGGER_STOP:
-	case SNDRV_PCM_TRIGGER_SUSPEND:
-	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
-		break;
-	default:
-		ret = -EINVAL;
-	}
-
-	if (ret == 0)
-		ret = snd_dmaengine_pcm_trigger(substream, cmd);
-
-	return ret;
-}
-
 static snd_pcm_uframes_t omap_pcm_pointer(struct snd_pcm_substream *substream)
 {
 	snd_pcm_uframes_t offset;
@@ -208,7 +177,7 @@ static struct snd_pcm_ops omap_pcm_ops = {
 	.ioctl		= snd_pcm_lib_ioctl,
 	.hw_params	= omap_pcm_hw_params,
 	.hw_free	= omap_pcm_hw_free,
-	.trigger	= omap_pcm_trigger,
+	.trigger	= snd_dmaengine_pcm_trigger,
 	.pointer	= omap_pcm_pointer,
 	.mmap		= omap_pcm_mmap,
 };
diff --git a/sound/soc/omap/omap-pcm.h b/sound/soc/omap/omap-pcm.h
index cabe74c..39e6e45 100644
--- a/sound/soc/omap/omap-pcm.h
+++ b/sound/soc/omap/omap-pcm.h
@@ -31,7 +31,6 @@ struct omap_pcm_dma_data {
 	char		*name;		/* stream identifier */
 	int		dma_req;	/* DMA request line */
 	unsigned long	port_addr;	/* transmit/receive register */
-	void (*set_threshold)(struct snd_pcm_substream *substream);
 	int		data_type;	/* 8, 16, 32 (bits) or 0 to let omap-pcm
 					 * to decide the sDMA data type */
 	int		packet_size;	/* packet size only in PACKET mode */
-- 
1.8.0

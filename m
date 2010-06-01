From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH v4 5/5] ASoC: omap-mcbsp: Place correct
	constraints for streams
Date: Tue,  1 Jun 2010 15:33:22 +0300
Message-ID: <1275395602-29261-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org
Cc: tony@atomide.com, broonie@opensource.wolfsonmicro.com, eduardo.valentin@nokia.com, ext-eero.nurkkala@nokia.com, lrg@slimlogic.co.uk
List-Id: linux-omap@vger.kernel.org

OMAP McBSP FIFO is word structured:
McBSP2 has 1024 + 256 = 1280 word long buffer,
McBSP1,3,4,5 has 128 word long buffer

This means, that the size of the FIFO
depends on the McBSP word size configuration.
For example on McBSP3:
16bit samples: size is 128 * 2 = 256 bytes
32bit samples: size is 128 * 4 = 512 bytes
It is simpler to place constraint for buffer and period based on channels.
McBSP3 as example again (16 or 32 bit samples):
1 channel (mono): size is 128 frames (128 words)
2 channels (stereo): size is 128 / 2 = 64 frames (2 * 64 words)
4 channels: size is 128 / 4 = 32 frames (4 * 32 words)

Use the second method to place hw_rule on buffer size, and in threshold
mode to period size.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
Hello,

The only change since v3 is the removal of blank line from the end of
omap_mcbsp_hwrule_min_buffersize function.
This patch should replace the one in the v3 series.

Peter


 sound/soc/omap/omap-mcbsp.c |   98 +++++++++++++++++++++++++++++++++---------
 1 files changed, 77 insertions(+), 21 deletions(-)

diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
index b06d8f1..aebd3af 100644
--- a/sound/soc/omap/omap-mcbsp.c
+++ b/sound/soc/omap/omap-mcbsp.c
@@ -173,6 +173,50 @@ static void omap_mcbsp_set_threshold(struct snd_pcm_substream *substream)
 		omap_mcbsp_set_rx_threshold(mcbsp_data->bus_id, words);
 }

+static int omap_mcbsp_hwrule_min_buffersize(struct snd_pcm_hw_params *params,
+				    struct snd_pcm_hw_rule *rule)
+{
+	struct snd_interval *buffer_size = hw_param_interval(params,
+					SNDRV_PCM_HW_PARAM_BUFFER_SIZE);
+	struct snd_interval *channels = hw_param_interval(params,
+					SNDRV_PCM_HW_PARAM_CHANNELS);
+	struct omap_mcbsp_data *mcbsp_data = rule->private;
+	struct snd_interval frames;
+	int size;
+
+	snd_interval_any(&frames);
+	size = omap_mcbsp_get_fifo_size(mcbsp_data->bus_id);
+
+	frames.min = size / channels->min;
+	frames.integer = 1;
+	return snd_interval_refine(buffer_size, &frames);
+}
+
+static int omap_mcbsp_hwrule_max_periodsize(struct snd_pcm_hw_params *params,
+				    struct snd_pcm_hw_rule *rule)
+{
+	struct snd_interval *period_size = hw_param_interval(params,
+					SNDRV_PCM_HW_PARAM_PERIOD_SIZE);
+	struct snd_interval *channels = hw_param_interval(params,
+					SNDRV_PCM_HW_PARAM_CHANNELS);
+	struct snd_pcm_substream *substream = rule->private;
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
+	struct omap_mcbsp_data *mcbsp_data = to_mcbsp(cpu_dai->private_data);
+	struct snd_interval frames;
+	int size;
+
+	snd_interval_any(&frames);
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		size = omap_mcbsp_get_max_tx_threshold(mcbsp_data->bus_id);
+	else
+		size = omap_mcbsp_get_max_rx_threshold(mcbsp_data->bus_id);
+
+	frames.max = size / channels->min;
+	frames.integer = 1;
+	return snd_interval_refine(period_size, &frames);
+}
+
 static int omap_mcbsp_dai_startup(struct snd_pcm_substream *substream,
 				  struct snd_soc_dai *dai)
 {
@@ -185,33 +229,45 @@ static int omap_mcbsp_dai_startup(struct snd_pcm_substream *substream,
 	if (!cpu_dai->active)
 		err = omap_mcbsp_request(bus_id);

+	/*
+	 * OMAP3 McBSP FIFO is word structured.
+	 * McBSP2 has 1024 + 256 = 1280 word long buffer,
+	 * McBSP1,3,4,5 has 128 word long buffer
+	 * This means that the size of the FIFO depends on the sample format.
+	 * For example on McBSP3:
+	 * 16bit samples: size is 128 * 2 = 256 bytes
+	 * 32bit samples: size is 128 * 4 = 512 bytes
+	 * It is simpler to place constraint for buffer and period based on
+	 * channels.
+	 * McBSP3 as example again (16 or 32 bit samples):
+	 * 1 channel (mono): size is 128 frames (128 words)
+	 * 2 channels (stereo): size is 128 / 2 = 64 frames (2 * 64 words)
+	 * 4 channels: size is 128 / 4 = 32 frames (4 * 32 words)
+	 */
 	if (cpu_is_omap343x()) {
 		int dma_op_mode = omap_mcbsp_get_dma_op_mode(bus_id);
-		int max_period;

 		/*
-		 * McBSP2 in OMAP3 has 1024 * 32-bit internal audio buffer.
-		 * Set constraint for minimum buffer size to the same than FIFO
-		 * size in order to avoid underruns in playback startup because
-		 * HW is keeping the DMA request active until FIFO is filled.
-		 */
-		if (bus_id == 1)
-			snd_pcm_hw_constraint_minmax(substream->runtime,
-					SNDRV_PCM_HW_PARAM_BUFFER_BYTES,
-					4096, UINT_MAX);
-
-		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-			max_period = omap_mcbsp_get_max_tx_threshold(bus_id);
-		else
-			max_period = omap_mcbsp_get_max_rx_threshold(bus_id);
-
-		max_period++;
-		max_period <<= 1;
+		* The first rule is for the buffer size, we should not allow
+		* smaller buffer than the FIFO size to avoid underruns
+		*/
+		snd_pcm_hw_rule_add(substream->runtime, 0,
+				    SNDRV_PCM_HW_PARAM_CHANNELS,
+				    omap_mcbsp_hwrule_min_buffersize,
+				    mcbsp_data,
+				    SNDRV_PCM_HW_PARAM_BUFFER_SIZE, -1);

+		/*
+		 * In case of threshold mode, the rule will ensure, that the
+		 * period size is not bigger than the maximum allowed threshold
+		 * value.
+		 */
 		if (dma_op_mode == MCBSP_DMA_MODE_THRESHOLD)
-			snd_pcm_hw_constraint_minmax(substream->runtime,
-						SNDRV_PCM_HW_PARAM_PERIOD_BYTES,
-						32, max_period);
+			snd_pcm_hw_rule_add(substream->runtime, 0,
+					    SNDRV_PCM_HW_PARAM_CHANNELS,
+					    omap_mcbsp_hwrule_max_periodsize,
+					    substream,
+					    SNDRV_PCM_HW_PARAM_PERIOD_SIZE, -1);
 	}

 	return err;
--
1.7.1

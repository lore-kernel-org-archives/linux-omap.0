From: Matt Ranostay <matt@ranostay.consulting>
Subject: [PATCH v8] ASoC: omap-mcbsp: Add PM QoS support for
	McBSP to prevent glitches
Date: Tue, 17 Jan 2017 23:26:00 -0800
Message-ID: <20170118072600.15239-1-matt@ranostay.consulting>
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
To: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Matt Ranostay <matt@ranostay.consulting>
List-Id: linux-omap@vger.kernel.org

We can get audio errors if hitting deeper idle states on omaps:

[alsa.c:230] error: Fatal problem with alsa output, error -5.
[audio.c:614] error: Error in writing audio (Input/output error?)!

This seems to happen with off mode idle enabled as power for the
whole SoC may get cut off between filling the McBSP fifo using DMA.
While active DMA blocks deeper idle states in hardware, McBSP
activity does not seem to do so.

Basing the QoS latency calculation on the FIFO size, threshold,
sample rate, and channels.

Based on the original patch by Tony Lindgren
Link: https://patchwork.kernel.org/patch/9305867/

Cc: Tony Lindgren <tony@atomide.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Matt Ranostay <matt@ranostay.consulting>
---
Changes from v1:
* add calculations for latency per number of FIFO locations

Changes from v2:
* add missing mcbsp.h header change

Changes from v3:
* base the latency calculations on threshold, buffer size, sample
  rate, and channels

Changes from v4:
* using Peter Ujfalusi's suggestions for restoring a higher latency on
  audio stream completion, or if not applicable remove the QoS request

Changes from v5:
* clean up latency checking logic
* move logic to .prepare and .shutdown to avoid functions that can sleep

Changes from v6:
* move QoS removal to asoc_mcbsp_remove from omap_mcbsp_cleanup
* also remove header include that is unneeded

Changes from v7:
* fix issue reported by Tony Lindgreen that a player application could close the
  card after hw_params, and cause an invalid pm_qos_remove_request()

 sound/soc/omap/mcbsp.h      |  3 +++
 sound/soc/omap/omap-mcbsp.c | 48 ++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 50 insertions(+), 1 deletion(-)

diff --git a/sound/soc/omap/mcbsp.h b/sound/soc/omap/mcbsp.h
index 61e93b1c185d..46ae1269a698 100644
--- a/sound/soc/omap/mcbsp.h
+++ b/sound/soc/omap/mcbsp.h
@@ -323,8 +323,11 @@ struct omap_mcbsp {
 
 	unsigned int fmt;
 	unsigned int in_freq;
+	unsigned int latency[2];
 	int clk_div;
 	int wlen;
+
+	struct pm_qos_request pm_qos_req;
 };
 
 void omap_mcbsp_config(struct omap_mcbsp *mcbsp,
diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
index d018e966e533..6b40bdbef336 100644
--- a/sound/soc/omap/omap-mcbsp.c
+++ b/sound/soc/omap/omap-mcbsp.c
@@ -157,6 +157,17 @@ static void omap_mcbsp_dai_shutdown(struct snd_pcm_substream *substream,
 				    struct snd_soc_dai *cpu_dai)
 {
 	struct omap_mcbsp *mcbsp = snd_soc_dai_get_drvdata(cpu_dai);
+	int tx = (substream->stream == SNDRV_PCM_STREAM_PLAYBACK);
+	int stream1 = tx ? SNDRV_PCM_STREAM_PLAYBACK : SNDRV_PCM_STREAM_CAPTURE;
+	int stream2 = tx ? SNDRV_PCM_STREAM_CAPTURE : SNDRV_PCM_STREAM_PLAYBACK;
+
+	if (mcbsp->latency[stream2])
+		pm_qos_update_request(&mcbsp->pm_qos_req,
+				      mcbsp->latency[stream2]);
+	else if (mcbsp->latency[stream1])
+		pm_qos_remove_request(&mcbsp->pm_qos_req);
+
+	mcbsp->latency[stream1] = 0;
 
 	if (!cpu_dai->active) {
 		omap_mcbsp_free(mcbsp);
@@ -164,6 +175,28 @@ static void omap_mcbsp_dai_shutdown(struct snd_pcm_substream *substream,
 	}
 }
 
+static int omap_mcbsp_dai_prepare(struct snd_pcm_substream *substream,
+				  struct snd_soc_dai *cpu_dai)
+{
+	struct omap_mcbsp *mcbsp = snd_soc_dai_get_drvdata(cpu_dai);
+	struct pm_qos_request *pm_qos_req = &mcbsp->pm_qos_req;
+	int tx = (substream->stream == SNDRV_PCM_STREAM_PLAYBACK);
+	int stream1 = tx ? SNDRV_PCM_STREAM_PLAYBACK : SNDRV_PCM_STREAM_CAPTURE;
+	int stream2 = tx ? SNDRV_PCM_STREAM_CAPTURE : SNDRV_PCM_STREAM_PLAYBACK;
+	int latency = mcbsp->latency[stream2];
+
+	/* Prevent omap hardware from hitting off between FIFO fills */
+	if (!latency || mcbsp->latency[stream1] < latency)
+		latency = mcbsp->latency[stream1];
+
+	if (pm_qos_request_active(pm_qos_req))
+		pm_qos_update_request(pm_qos_req, latency);
+	else if (latency)
+		pm_qos_add_request(pm_qos_req, PM_QOS_CPU_DMA_LATENCY, latency);
+
+	return 0;
+}
+
 static int omap_mcbsp_dai_trigger(struct snd_pcm_substream *substream, int cmd,
 				  struct snd_soc_dai *cpu_dai)
 {
@@ -226,6 +259,7 @@ static int omap_mcbsp_dai_hw_params(struct snd_pcm_substream *substream,
 	int wlen, channels, wpf;
 	int pkt_size = 0;
 	unsigned int format, div, framesize, master;
+	unsigned int buffer_size = mcbsp->pdata->buffer_size;
 
 	dma_data = snd_soc_dai_get_dma_data(cpu_dai, substream);
 	channels = params_channels(params);
@@ -240,7 +274,9 @@ static int omap_mcbsp_dai_hw_params(struct snd_pcm_substream *substream,
 	default:
 		return -EINVAL;
 	}
-	if (mcbsp->pdata->buffer_size) {
+	if (buffer_size) {
+		int latency;
+
 		if (mcbsp->dma_op_mode == MCBSP_DMA_MODE_THRESHOLD) {
 			int period_words, max_thrsh;
 			int divider = 0;
@@ -271,6 +307,12 @@ static int omap_mcbsp_dai_hw_params(struct snd_pcm_substream *substream,
 			/* Use packet mode for non mono streams */
 			pkt_size = channels;
 		}
+
+		latency = ((((buffer_size - pkt_size) / channels) * 1000)
+				 / (params->rate_num / params->rate_den));
+
+		mcbsp->latency[substream->stream] = latency;
+
 		omap_mcbsp_set_threshold(substream, pkt_size);
 	}
 
@@ -554,6 +596,7 @@ static int omap_mcbsp_dai_set_dai_sysclk(struct snd_soc_dai *cpu_dai,
 static const struct snd_soc_dai_ops mcbsp_dai_ops = {
 	.startup	= omap_mcbsp_dai_startup,
 	.shutdown	= omap_mcbsp_dai_shutdown,
+	.prepare	= omap_mcbsp_dai_prepare,
 	.trigger	= omap_mcbsp_dai_trigger,
 	.delay		= omap_mcbsp_dai_delay,
 	.hw_params	= omap_mcbsp_dai_hw_params,
@@ -835,6 +878,9 @@ static int asoc_mcbsp_remove(struct platform_device *pdev)
 	if (mcbsp->pdata->ops && mcbsp->pdata->ops->free)
 		mcbsp->pdata->ops->free(mcbsp->id);
 
+	if (pm_qos_request_active(&mcbsp->pm_qos_req))
+		pm_qos_remove_request(&mcbsp->pm_qos_req);
+
 	omap_mcbsp_cleanup(mcbsp);
 
 	clk_put(mcbsp->fclk);
-- 
2.10.2

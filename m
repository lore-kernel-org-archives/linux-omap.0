From: Matt Ranostay <matt@ranostay.consulting>
Subject: [PATCH v5] ASoC: omap-mcbsp: Add PM QoS support for
	McBSP to prevent glitches
Date: Wed,  4 Jan 2017 17:59:18 -0800
Message-ID: <20170105015918.21621-1-matt@ranostay.consulting>
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

 sound/soc/omap/mcbsp.c      | 37 +++++++++++++++++++++++++++++++++++++
 sound/soc/omap/mcbsp.h      |  3 +++
 sound/soc/omap/omap-mcbsp.c | 11 ++++++++++-
 3 files changed, 50 insertions(+), 1 deletion(-)

diff --git a/sound/soc/omap/mcbsp.c b/sound/soc/omap/mcbsp.c
index 06fec5699cc8..f079650b71e3 100644
--- a/sound/soc/omap/mcbsp.c
+++ b/sound/soc/omap/mcbsp.c
@@ -25,6 +25,7 @@
 #include <linux/io.h>
 #include <linux/slab.h>
 #include <linux/pm_runtime.h>
+#include <linux/pm_qos.h>
 
 #include <linux/platform_data/asoc-ti-mcbsp.h>
 
@@ -640,9 +641,28 @@ void omap_mcbsp_free(struct omap_mcbsp *mcbsp)
  */
 void omap_mcbsp_start(struct omap_mcbsp *mcbsp, int tx, int rx)
 {
+	struct pm_qos_request *pm_qos_req = &mcbsp->pm_qos_req;
+	int stream1 = tx ? SNDRV_PCM_STREAM_PLAYBACK : SNDRV_PCM_STREAM_CAPTURE;
+	int stream2 = tx ? SNDRV_PCM_STREAM_CAPTURE : SNDRV_PCM_STREAM_PLAYBACK;
 	int enable_srg = 0;
+	int latency;
 	u16 w;
 
+	/* Prevent omap hardware from hitting off between FIFO fills */
+	if (!mcbsp->latency[stream2] ||
+			mcbsp->latency[stream1] < mcbsp->latency[stream2])
+		latency = mcbsp->latency[stream1];
+	else
+		latency = mcbsp->latency[stream2];
+
+	if (latency) {
+		if (pm_qos_request_active(pm_qos_req))
+			pm_qos_update_request(pm_qos_req, latency);
+		else
+			pm_qos_add_request(pm_qos_req, PM_QOS_CPU_DMA_LATENCY,
+					   latency);
+	}
+
 	if (mcbsp->st_data)
 		omap_st_start(mcbsp);
 
@@ -731,6 +751,20 @@ void omap_mcbsp_stop(struct omap_mcbsp *mcbsp, int tx, int rx)
 
 	if (mcbsp->st_data)
 		omap_st_stop(mcbsp);
+
+	if (pm_qos_request_active(&mcbsp->pm_qos_req)) {
+		int stream1 = tx ? SNDRV_PCM_STREAM_PLAYBACK :
+			SNDRV_PCM_STREAM_CAPTURE;
+		int stream2 = tx ? SNDRV_PCM_STREAM_CAPTURE :
+			SNDRV_PCM_STREAM_PLAYBACK;
+
+		mcbsp->latency[stream1] = 0;
+		if (mcbsp->latency[stream2])
+			pm_qos_update_request(&mcbsp->pm_qos_req,
+					      mcbsp->latency[stream2]);
+		else
+			pm_qos_remove_request(&mcbsp->pm_qos_req);
+	}
 }
 
 int omap2_mcbsp_set_clks_src(struct omap_mcbsp *mcbsp, u8 fck_src_id)
@@ -1098,6 +1132,9 @@ int omap_mcbsp_init(struct platform_device *pdev)
 
 void omap_mcbsp_cleanup(struct omap_mcbsp *mcbsp)
 {
+	if (pm_qos_request_active(&mcbsp->pm_qos_req))
+		pm_qos_remove_request(&mcbsp->pm_qos_req);
+
 	if (mcbsp->pdata->buffer_size)
 		sysfs_remove_group(&mcbsp->dev->kobj, &additional_attr_group);
 
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
index d018e966e533..7e00938271c6 100644
--- a/sound/soc/omap/omap-mcbsp.c
+++ b/sound/soc/omap/omap-mcbsp.c
@@ -226,6 +226,7 @@ static int omap_mcbsp_dai_hw_params(struct snd_pcm_substream *substream,
 	int wlen, channels, wpf;
 	int pkt_size = 0;
 	unsigned int format, div, framesize, master;
+	unsigned int buffer_size = mcbsp->pdata->buffer_size;
 
 	dma_data = snd_soc_dai_get_dma_data(cpu_dai, substream);
 	channels = params_channels(params);
@@ -240,7 +241,9 @@ static int omap_mcbsp_dai_hw_params(struct snd_pcm_substream *substream,
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
@@ -271,6 +274,12 @@ static int omap_mcbsp_dai_hw_params(struct snd_pcm_substream *substream,
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
 
-- 
2.10.2

From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v3 4/8] ASoC: omap-mcbsp: Simplify the
	mcbsp_start/_stop function parameters
Date: Thu, 8 Nov 2018 09:29:56 +0200
Message-ID: <20181108073000.21114-5-peter.ujfalusi@ti.com>
References: <20181108073000.21114-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20181108073000.21114-1-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, jarkko.nikula@bitmer.com
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

We either start/stop TX or RX, never both. Move the tx/rx direction
selection within the functions.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Acked-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
---
 sound/soc/omap/mcbsp.c      | 8 ++++++--
 sound/soc/omap/mcbsp.h      | 4 ++--
 sound/soc/omap/omap-mcbsp.c | 9 ++++-----
 3 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/sound/soc/omap/mcbsp.c b/sound/soc/omap/mcbsp.c
index fca0b0e9186b..7ff22561f00f 100644
--- a/sound/soc/omap/mcbsp.c
+++ b/sound/soc/omap/mcbsp.c
@@ -637,8 +637,10 @@ void omap_mcbsp_free(struct omap_mcbsp *mcbsp)
  * If no transmitter or receiver is active prior calling, then sample-rate
  * generator and frame sync are started.
  */
-void omap_mcbsp_start(struct omap_mcbsp *mcbsp, int tx, int rx)
+void omap_mcbsp_start(struct omap_mcbsp *mcbsp, int stream)
 {
+	int tx = (stream == SNDRV_PCM_STREAM_PLAYBACK);
+	int rx = !tx;
 	int enable_srg = 0;
 	u16 w;
 
@@ -694,8 +696,10 @@ void omap_mcbsp_start(struct omap_mcbsp *mcbsp, int tx, int rx)
 	omap_mcbsp_dump_reg(mcbsp);
 }
 
-void omap_mcbsp_stop(struct omap_mcbsp *mcbsp, int tx, int rx)
+void omap_mcbsp_stop(struct omap_mcbsp *mcbsp, int stream)
 {
+	int tx = (stream == SNDRV_PCM_STREAM_PLAYBACK);
+	int rx = !tx;
 	int idle;
 	u16 w;
 
diff --git a/sound/soc/omap/mcbsp.h b/sound/soc/omap/mcbsp.h
index 46ae1269a698..92472c6ef358 100644
--- a/sound/soc/omap/mcbsp.h
+++ b/sound/soc/omap/mcbsp.h
@@ -339,8 +339,8 @@ u16 omap_mcbsp_get_rx_delay(struct omap_mcbsp *mcbsp);
 int omap_mcbsp_get_dma_op_mode(struct omap_mcbsp *mcbsp);
 int omap_mcbsp_request(struct omap_mcbsp *mcbsp);
 void omap_mcbsp_free(struct omap_mcbsp *mcbsp);
-void omap_mcbsp_start(struct omap_mcbsp *mcbsp, int tx, int rx);
-void omap_mcbsp_stop(struct omap_mcbsp *mcbsp, int tx, int rx);
+void omap_mcbsp_start(struct omap_mcbsp *mcbsp, int stream);
+void omap_mcbsp_stop(struct omap_mcbsp *mcbsp, int stream);
 
 /* McBSP functional clock source changing function */
 int omap2_mcbsp_set_clks_src(struct omap_mcbsp *mcbsp, u8 fck_src_id);
diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
index caa24c463b3e..a18b7ecc3a2e 100644
--- a/sound/soc/omap/omap-mcbsp.c
+++ b/sound/soc/omap/omap-mcbsp.c
@@ -201,27 +201,26 @@ static int omap_mcbsp_dai_trigger(struct snd_pcm_substream *substream, int cmd,
 				  struct snd_soc_dai *cpu_dai)
 {
 	struct omap_mcbsp *mcbsp = snd_soc_dai_get_drvdata(cpu_dai);
-	int err = 0, play = (substream->stream == SNDRV_PCM_STREAM_PLAYBACK);
 
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
 	case SNDRV_PCM_TRIGGER_RESUME:
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
 		mcbsp->active++;
-		omap_mcbsp_start(mcbsp, play, !play);
+		omap_mcbsp_start(mcbsp, substream->stream);
 		break;
 
 	case SNDRV_PCM_TRIGGER_STOP:
 	case SNDRV_PCM_TRIGGER_SUSPEND:
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
-		omap_mcbsp_stop(mcbsp, play, !play);
+		omap_mcbsp_stop(mcbsp, substream->stream);
 		mcbsp->active--;
 		break;
 	default:
-		err = -EINVAL;
+		return -EINVAL;
 	}
 
-	return err;
+	return 0;
 }
 
 static snd_pcm_sframes_t omap_mcbsp_dai_delay(
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

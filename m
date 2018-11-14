From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 3/3] ASoC: omap-dmic: Add pm_qos handling to
	avoid overruns with CPU_IDLE
Date: Wed, 14 Nov 2018 13:06:23 +0200
Message-ID: <20181114110623.30932-4-peter.ujfalusi@ti.com>
References: <20181114110623.30932-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20181114110623.30932-1-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, jarkko.nikula@bitmer.com, tony@atomide.com
Cc: kernel@pyra-handheld.com, hns@goldelico.com, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, matt@ranostay.consulting
List-Id: linux-omap@vger.kernel.org

We need to block sleep states which would require longer time to leave than
the time the DMA must react to the DMA request in order to keep the FIFO
serviced without overrun.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/omap/omap-dmic.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sound/soc/omap/omap-dmic.c b/sound/soc/omap/omap-dmic.c
index fe966272bd0c..cba9645b6487 100644
--- a/sound/soc/omap/omap-dmic.c
+++ b/sound/soc/omap/omap-dmic.c
@@ -48,6 +48,8 @@ struct omap_dmic {
 	struct device *dev;
 	void __iomem *io_base;
 	struct clk *fclk;
+	struct pm_qos_request pm_qos_req;
+	int latency;
 	int fclk_freq;
 	int out_freq;
 	int clk_div;
@@ -124,6 +126,8 @@ static void omap_dmic_dai_shutdown(struct snd_pcm_substream *substream,
 
 	mutex_lock(&dmic->mutex);
 
+	pm_qos_remove_request(&dmic->pm_qos_req);
+
 	if (!dai->active)
 		dmic->active = 0;
 
@@ -228,6 +232,8 @@ static int omap_dmic_dai_hw_params(struct snd_pcm_substream *substream,
 	/* packet size is threshold * channels */
 	dma_data = snd_soc_dai_get_dma_data(dai, substream);
 	dma_data->maxburst = dmic->threshold * channels;
+	dmic->latency = (OMAP_DMIC_THRES_MAX - dmic->threshold) * USEC_PER_SEC /
+			params_rate(params);
 
 	return 0;
 }
@@ -238,6 +244,9 @@ static int omap_dmic_dai_prepare(struct snd_pcm_substream *substream,
 	struct omap_dmic *dmic = snd_soc_dai_get_drvdata(dai);
 	u32 ctrl;
 
+	if (pm_qos_request_active(&dmic->pm_qos_req))
+		pm_qos_update_request(&dmic->pm_qos_req, dmic->latency);
+
 	/* Configure uplink threshold */
 	omap_dmic_write(dmic, OMAP_DMIC_FIFO_CTRL_REG, dmic->threshold);
 
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

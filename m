From: Grazvydas Ignotas <notasas@gmail.com>
Subject: [PATCH] ASoC: pandora: switch clock back to internal
	on stop
Date: Sun, 19 Feb 2012 00:39:55 +0200
Message-ID: <1329604795-24509-1-git-send-email-notasas@gmail.com>
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
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Grazvydas Ignotas <notasas@gmail.com>, linux-omap@vger.kernel.org, Liam Girdwood <lrg@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: linux-omap@vger.kernel.org

For some reason, OMAP doesn't enter lower power states with functional
clock (CLKS) source set to external, so switch it back to internal when
done playing.

Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
---
 sound/soc/omap/omap3pandora.c |   22 ++++++++++++++++++++++
 1 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/sound/soc/omap/omap3pandora.c b/sound/soc/omap/omap3pandora.c
index 07794bd..1be26df 100644
--- a/sound/soc/omap/omap3pandora.c
+++ b/sound/soc/omap/omap3pandora.c
@@ -77,6 +77,27 @@ static int omap3pandora_hw_params(struct snd_pcm_substream *substream,
 	return 0;
 }
 
+static int omap3pandora_hw_free(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
+	int ret;
+
+	/*
+	 * For some reason, if we don't set clock back to internal, OMAP power
+	 * saving features don't work properly (per power domain doesn't enter
+	 * lower power states). Switch it back until better solution is found.
+	 */
+	ret = snd_soc_dai_set_sysclk(cpu_dai, OMAP_MCBSP_SYSCLK_CLKS_FCLK,
+				     0, SND_SOC_CLOCK_IN);
+	if (ret < 0) {
+		pr_err(PREFIX "can't set cpu system clock\n");
+		return ret;
+	}
+
+	return 0;
+}
+
 static int omap3pandora_dac_event(struct snd_soc_dapm_widget *w,
 	struct snd_kcontrol *k, int event)
 {
@@ -201,6 +222,7 @@ static int omap3pandora_in_init(struct snd_soc_pcm_runtime *rtd)
 
 static struct snd_soc_ops omap3pandora_ops = {
 	.hw_params = omap3pandora_hw_params,
+	.hw_free = omap3pandora_hw_free,
 };
 
 /* Digital audio interface glue - connects codec <--> CPU */
-- 
1.7.0.4

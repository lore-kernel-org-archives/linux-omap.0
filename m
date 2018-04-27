From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 5/6] ASoC: omap: n810: HS mic is not working,
	add a widget for it with comment
Date: Fri, 27 Apr 2018 11:17:14 +0300
Message-ID: <20180427081715.28791-6-peter.ujfalusi@ti.com>
References: <20180427081715.28791-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20180427081715.28791-1-peter.ujfalusi@ti.com>
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
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, aaro.koskinen@iki.fi
List-Id: linux-omap@vger.kernel.org

The bias for the analog HS microphone is coming from Retu/Vilma chip and
we do not have control over it, yet.

For clarity, add a new DAPM_MIC widget for the HS mic and document the
current state.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/omap/n810.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/sound/soc/omap/n810.c b/sound/soc/omap/n810.c
index 3a2c448a26dd..9cfefe44a75f 100644
--- a/sound/soc/omap/n810.c
+++ b/sound/soc/omap/n810.c
@@ -80,9 +80,9 @@ static void n810_ext_control(struct snd_soc_dapm_context *dapm)
 	else
 		snd_soc_dapm_disable_pin_unlocked(dapm, "Headphone Jack");
 	if (line1l)
-		snd_soc_dapm_enable_pin_unlocked(dapm, "LINE1L");
+		snd_soc_dapm_enable_pin_unlocked(dapm, "HS Mic");
 	else
-		snd_soc_dapm_disable_pin_unlocked(dapm, "LINE1L");
+		snd_soc_dapm_disable_pin_unlocked(dapm, "HS Mic");
 
 	if (n810_dmic_func)
 		snd_soc_dapm_enable_pin_unlocked(dapm, "DMic");
@@ -222,6 +222,7 @@ static const struct snd_soc_dapm_widget aic33_dapm_widgets[] = {
 	SND_SOC_DAPM_SPK("Ext Spk", n810_spk_event),
 	SND_SOC_DAPM_HP("Headphone Jack", n810_jack_event),
 	SND_SOC_DAPM_MIC("DMic", NULL),
+	SND_SOC_DAPM_MIC("HS Mic", NULL),
 };
 
 static const struct snd_soc_dapm_route audio_map[] = {
@@ -233,6 +234,12 @@ static const struct snd_soc_dapm_route audio_map[] = {
 
 	{"DMic Rate 64", NULL, "DMic"},
 	{"DMic", NULL, "Mic Bias"},
+
+	/*
+	 * Note that the mic bias is coming from Retu/Vilma and we don't have
+	 * control over it atm. The analog HS mic is not working. <- TODO
+	 */
+	{"LINE1L", NULL, "HS Mic"},
 };
 
 static const char *spk_function[] = {"Off", "On"};
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

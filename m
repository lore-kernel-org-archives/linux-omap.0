From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: omap: n810: HS mic is not working,
	add a widget for it with comment" to the asoc tree
Date: Fri, 27 Apr 2018 11:59:37 +0100
Message-ID: <E1fC16H-0003yc-7f@debutante>
References: <20180427081715.28791-6-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20180427081715.28791-6-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, aaro.koskinen@iki.fi, tony@atomide.com, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linux-omap@vger.kernel.org, jarkko.nikula@bitmer.com
List-Id: linux-omap@vger.kernel.org

The patch

   ASoC: omap: n810: HS mic is not working, add a widget for it with comment

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 9652bb7dbbe46bf244e3dda54ce027a359b524a4 Mon Sep 17 00:00:00 2001
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Date: Fri, 27 Apr 2018 11:17:14 +0300
Subject: [PATCH] ASoC: omap: n810: HS mic is not working, add a widget for it
 with comment

The bias for the analog HS microphone is coming from Retu/Vilma chip and
we do not have control over it, yet.

For clarity, add a new DAPM_MIC widget for the HS mic and document the
current state.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
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
2.17.0

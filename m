From: Sebastian Reichel <sre@kernel.org>
Subject: [PATCHv2 7/9] ASoC: omap: rx51: Add some error messages
Date: Mon, 28 Apr 2014 16:07:25 +0200
Message-ID: <1398694047-28596-8-git-send-email-sre@kernel.org>
References: <1398694047-28596-1-git-send-email-sre@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1398694047-28596-1-git-send-email-sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@ring0.de>, Mark Brown <broonie@kernel.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Tony Lindgren <tony@atomide.com>, Liam Girdwood <lgirdwood@gmail.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, Sebastian Reichel <sre@kernel.org>
List-Id: linux-omap@vger.kernel.org

Add more error messages making it easier to identify problems.

Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
 sound/soc/omap/rx51.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/sound/soc/omap/rx51.c b/sound/soc/omap/rx51.c
index 30cfac0..110deca 100644
--- a/sound/soc/omap/rx51.c
+++ b/sound/soc/omap/rx51.c
@@ -298,20 +298,26 @@ static int rx51_aic34_init(struct snd_soc_pcm_runtime *rtd)
 	snd_soc_dapm_nc_pin(dapm, "LINE1R");
 
 	err = tpa6130a2_add_controls(codec);
-	if (err < 0)
+	if (err < 0) {
+		dev_err(card->dev, "Failed to add TPA6130A2 controls\n");
 		return err;
+	}
 	snd_soc_limit_volume(codec, "TPA6130A2 Headphone Playback Volume", 42);
 
 	err = omap_mcbsp_st_add_controls(rtd, 2);
-	if (err < 0)
+	if (err < 0) {
+		dev_err(card->dev, "Failed to add MCBSP controls\n");
 		return err;
+	}
 
 	/* AV jack detection */
 	err = snd_soc_jack_new(codec, "AV Jack",
 			       SND_JACK_HEADSET | SND_JACK_VIDEOOUT,
 			       &rx51_av_jack);
-	if (err)
+	if (err) {
+		dev_err(card->dev, "Failed to add AV Jack\n");
 		return err;
+	}
 
 	/* prepare gpio for snd_soc_jack_add_gpios */
 	rx51_av_jack_gpios[0].gpio = desc_to_gpio(pdata->jack_detection_gpio);
@@ -320,6 +326,10 @@ static int rx51_aic34_init(struct snd_soc_pcm_runtime *rtd)
 	err = snd_soc_jack_add_gpios(&rx51_av_jack,
 				     ARRAY_SIZE(rx51_av_jack_gpios),
 				     rx51_av_jack_gpios);
+	if (err) {
+		dev_err(card->dev, "Failed to add GPIOs\n");
+		return err;
+	}
 
 	return err;
 }
-- 
1.9.2

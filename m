From: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: [PATCH] ASoC: rx51: do not fail if could not get jack detection gpio
Date: Mon, 26 Jan 2015 21:51:47 +0100
Message-ID: <1422305507-10533-1-git-send-email-pali.rohar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f175.google.com ([74.125.82.175]:34898 "EHLO
	mail-we0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754058AbbAZUxK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 26 Jan 2015 15:53:10 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>
Cc: linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, Sebastian Reichel <sre@debian.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>

qemu does not emulate it

Signed-off-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>
---
 sound/soc/omap/rx51.c |   45 +++++++++++++++++++++++++----------------=
----
 1 file changed, 25 insertions(+), 20 deletions(-)

diff --git a/sound/soc/omap/rx51.c b/sound/soc/omap/rx51.c
index 04896d6..a689021 100644
--- a/sound/soc/omap/rx51.c
+++ b/sound/soc/omap/rx51.c
@@ -310,25 +310,27 @@ static int rx51_aic34_init(struct snd_soc_pcm_run=
time *rtd)
 		return err;
 	}
=20
-	/* AV jack detection */
-	err =3D snd_soc_jack_new(codec, "AV Jack",
-			       SND_JACK_HEADSET | SND_JACK_VIDEOOUT,
-			       &rx51_av_jack);
-	if (err) {
-		dev_err(card->dev, "Failed to add AV Jack\n");
-		return err;
-	}
+	if (!IS_ERR(pdata->jack_detection_gpio)) {
+		/* AV jack detection */
+		err =3D snd_soc_jack_new(codec, "AV Jack",
+				       SND_JACK_HEADSET | SND_JACK_VIDEOOUT,
+				       &rx51_av_jack);
+		if (err) {
+			dev_err(card->dev, "Failed to add AV Jack\n");
+			return err;
+		}
=20
-	/* prepare gpio for snd_soc_jack_add_gpios */
-	rx51_av_jack_gpios[0].gpio =3D desc_to_gpio(pdata->jack_detection_gpi=
o);
-	devm_gpiod_put(card->dev, pdata->jack_detection_gpio);
+		/* prepare gpio for snd_soc_jack_add_gpios */
+		rx51_av_jack_gpios[0].gpio =3D desc_to_gpio(pdata->jack_detection_gp=
io);
+		devm_gpiod_put(card->dev, pdata->jack_detection_gpio);
=20
-	err =3D snd_soc_jack_add_gpios(&rx51_av_jack,
-				     ARRAY_SIZE(rx51_av_jack_gpios),
-				     rx51_av_jack_gpios);
-	if (err) {
-		dev_err(card->dev, "Failed to add GPIOs\n");
-		return err;
+		err =3D snd_soc_jack_add_gpios(&rx51_av_jack,
+					     ARRAY_SIZE(rx51_av_jack_gpios),
+					     rx51_av_jack_gpios);
+		if (err) {
+			dev_err(card->dev, "Failed to add GPIOs\n");
+			return err;
+		}
 	}
=20
 	return err;
@@ -336,8 +338,11 @@ static int rx51_aic34_init(struct snd_soc_pcm_runt=
ime *rtd)
=20
 static int rx51_card_remove(struct snd_soc_card *card)
 {
-	snd_soc_jack_free_gpios(&rx51_av_jack, ARRAY_SIZE(rx51_av_jack_gpios)=
,
-				rx51_av_jack_gpios);
+	struct rx51_audio_pdata *pdata =3D snd_soc_card_get_drvdata(card);
+
+	if (!IS_ERR(pdata->jack_detection_gpio))
+		snd_soc_jack_free_gpios(&rx51_av_jack, ARRAY_SIZE(rx51_av_jack_gpios=
),
+					rx51_av_jack_gpios);
=20
 	return 0;
 }
@@ -470,8 +475,8 @@ static int rx51_soc_probe(struct platform_device *p=
dev)
 	pdata->jack_detection_gpio =3D devm_gpiod_get(card->dev,
 						    "jack-detection");
 	if (IS_ERR(pdata->jack_detection_gpio)) {
+		/* Do not fail, qemu does not emulate jack detection gpio */
 		dev_err(card->dev, "could not get jack detection gpio\n");
-		return PTR_ERR(pdata->jack_detection_gpio);
 	}
=20
 	pdata->eci_sw_gpio =3D devm_gpiod_get(card->dev, "eci-switch");
--=20
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

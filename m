From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH] ASoC: rx51: use flags argument of devm_gpiod_get to set direction
Date: Tue, 19 May 2015 09:48:08 +0200
Message-ID: <1432021688-25830-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:38969 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753281AbbESHsU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 May 2015 03:48:20 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: Sebastian Reichel <sre@kernel.org>, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, kernel@pengutronix.de, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>

Since 39b2bbe3d715 (gpio: add flags argument to gpiod_get*() functions)
which appeared in v3.17-rc1, the gpiod_get* functions take an additiona=
l
parameter that allows to specify direction and initial value for output=
=2E

Use this to simplify the driver. Furthermore this is one caller less
that stops us making the flags argument to gpiod_get*() mandatory.

=46ixes: 386e81ab3b4d ("ASoC: omap: rx51: get GPIO numbers via gpiod AP=
I")
Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
---
 sound/soc/omap/rx51.c | 30 ++++++++----------------------
 1 file changed, 8 insertions(+), 22 deletions(-)

diff --git a/sound/soc/omap/rx51.c b/sound/soc/omap/rx51.c
index c2ddf0fbfa28..fded99362d39 100644
--- a/sound/soc/omap/rx51.c
+++ b/sound/soc/omap/rx51.c
@@ -455,50 +455,36 @@ static int rx51_soc_probe(struct platform_device =
*pdev)
 	snd_soc_card_set_drvdata(card, pdata);
=20
 	pdata->tvout_selection_gpio =3D devm_gpiod_get(card->dev,
-						     "tvout-selection");
+						     "tvout-selection",
+						     GPIOD_OUT_LOW);
 	if (IS_ERR(pdata->tvout_selection_gpio)) {
 		dev_err(card->dev, "could not get tvout selection gpio\n");
 		return PTR_ERR(pdata->tvout_selection_gpio);
 	}
=20
-	err =3D gpiod_direction_output(pdata->tvout_selection_gpio, 0);
-	if (err) {
-		dev_err(card->dev, "could not setup tvout selection gpio\n");
-		return err;
-	}
-
 	pdata->jack_detection_gpio =3D devm_gpiod_get(card->dev,
-						    "jack-detection");
+						    "jack-detection",
+						    GPIOD_ASIS);
 	if (IS_ERR(pdata->jack_detection_gpio)) {
 		dev_err(card->dev, "could not get jack detection gpio\n");
 		return PTR_ERR(pdata->jack_detection_gpio);
 	}
=20
-	pdata->eci_sw_gpio =3D devm_gpiod_get(card->dev, "eci-switch");
+	pdata->eci_sw_gpio =3D devm_gpiod_get(card->dev, "eci-switch",
+					    GPIOD_OUT_HIGH);
 	if (IS_ERR(pdata->eci_sw_gpio)) {
 		dev_err(card->dev, "could not get eci switch gpio\n");
 		return PTR_ERR(pdata->eci_sw_gpio);
 	}
=20
-	err =3D gpiod_direction_output(pdata->eci_sw_gpio, 1);
-	if (err) {
-		dev_err(card->dev, "could not setup eci switch gpio\n");
-		return err;
-	}
-
 	pdata->speaker_amp_gpio =3D devm_gpiod_get(card->dev,
-						 "speaker-amplifier");
+						 "speaker-amplifier",
+						 GPIOD_OUT_LOW);
 	if (IS_ERR(pdata->speaker_amp_gpio)) {
 		dev_err(card->dev, "could not get speaker enable gpio\n");
 		return PTR_ERR(pdata->speaker_amp_gpio);
 	}
=20
-	err =3D gpiod_direction_output(pdata->speaker_amp_gpio, 0);
-	if (err) {
-		dev_err(card->dev, "could not setup speaker enable gpio\n");
-		return err;
-	}
-
 	err =3D devm_snd_soc_register_card(card->dev, card);
 	if (err) {
 		dev_err(&pdev->dev, "snd_soc_register_card failed (%d)\n", err);
--=20
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

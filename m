From: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: [PATCH 1/2] ASoC: omap: rx51: Use snd_soc_register_card and add module alias for autoloading driver
Date: Sun, 20 Jan 2013 04:04:29 +0100
Message-ID: <1358651070-30029-2-git-send-email-pali.rohar@gmail.com>
References: <1358651070-30029-1-git-send-email-pali.rohar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1358651070-30029-1-git-send-email-pali.rohar@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
List-Id: linux-omap@vger.kernel.org

Signed-off-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>
---
 sound/soc/omap/rx51.c |   50 +++++++++++++++++++++++++++++------------=
--------
 1 file changed, 30 insertions(+), 20 deletions(-)

diff --git a/sound/soc/omap/rx51.c b/sound/soc/omap/rx51.c
index d921ddb..82e3aae 100644
--- a/sound/soc/omap/rx51.c
+++ b/sound/soc/omap/rx51.c
@@ -391,10 +391,9 @@ static struct snd_soc_card rx51_sound_card =3D {
 	.num_configs =3D ARRAY_SIZE(rx51_codec_conf),
 };
=20
-static struct platform_device *rx51_snd_device;
-
-static int __init rx51_soc_init(void)
+static int rx51_soc_probe(struct platform_device *pdev)
 {
+	struct snd_soc_card *card =3D &rx51_sound_card;
 	int err;
=20
 	if (!machine_is_nokia_rx51())
@@ -409,22 +408,18 @@ static int __init rx51_soc_init(void)
 	if (err)
 		goto err_gpio_eci_sw;
=20
-	rx51_snd_device =3D platform_device_alloc("soc-audio", -1);
-	if (!rx51_snd_device) {
-		err =3D -ENOMEM;
-		goto err1;
-	}
-
-	platform_set_drvdata(rx51_snd_device, &rx51_sound_card);
+	card->dev =3D &pdev->dev;
=20
-	err =3D platform_device_add(rx51_snd_device);
-	if (err)
-		goto err2;
+	err =3D snd_soc_register_card(card);
+	if (err) {
+		dev_err(&pdev->dev, "snd_soc_register_card failed (%d)\n", err);
+		goto err_snd;
+	}
=20
 	return 0;
-err2:
-	platform_device_put(rx51_snd_device);
-err1:
+
+err_snd:
+	card->dev =3D NULL;
 	gpio_free(RX51_ECI_SW_GPIO);
 err_gpio_eci_sw:
 	gpio_free(RX51_TVOUT_SEL_GPIO);
@@ -433,19 +428,34 @@ err_gpio_tvout_sel:
 	return err;
 }
=20
-static void __exit rx51_soc_exit(void)
+static int rx51_soc_remove(struct platform_device *pdev)
 {
+	struct snd_soc_card *card =3D platform_get_drvdata(pdev);
+
 	snd_soc_jack_free_gpios(&rx51_av_jack, ARRAY_SIZE(rx51_av_jack_gpios)=
,
 				rx51_av_jack_gpios);
=20
-	platform_device_unregister(rx51_snd_device);
+	snd_soc_unregister_card(card);
+	card->dev =3D NULL;
+
 	gpio_free(RX51_ECI_SW_GPIO);
 	gpio_free(RX51_TVOUT_SEL_GPIO);
+
+	return 0;
 }
=20
-module_init(rx51_soc_init);
-module_exit(rx51_soc_exit);
+static struct platform_driver rx51_soc_driver =3D {
+	.driver =3D {
+		.name =3D "rx51-audio",
+		.owner =3D THIS_MODULE,
+	},
+	.probe =3D rx51_soc_probe,
+	.remove =3D rx51_soc_remove,
+};
+
+module_platform_driver(rx51_soc_driver);
=20
 MODULE_AUTHOR("Nokia Corporation");
 MODULE_DESCRIPTION("ALSA SoC Nokia RX-51");
 MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:rx51-audio");
--=20
1.7.10.4

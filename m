From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: tpa6130a2: Remove goto err_gpio" to the asoc tree
Date: Sun, 26 Jun 2016 13:02:42 +0100
Message-ID: <E1bH8lu-0002Pt-2f@debutante>
References: <903012887a1b2f8f59e44b1cfb472c9362fd964f.1466441036.git.helen.koike@collabora.co.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <903012887a1b2f8f59e44b1cfb472c9362fd964f.1466441036.git.helen.koike@collabora.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Helen Koike <helen.koike@collabora.co.uk>
Cc: Sebastian Reichel <sre@kernel.org>, Mark Brown <broonie@kernel.org>Sebastian Reichel <sre@kernel.org>, k.kozlowski@samsung.com, lars@metafoo.de, alsa-devel@alsa-project.org, tiwai@suse.com, lgirdwood@gmail.com, linux-kernel@vger.kernel.org, peter.ujfalusi@ti.combroonie@kernel.org, cphealy@gmail.com, linux-omap@vger.kernel.org, jarkko.nikula@bitmer.com
List-Id: linux-omap@vger.kernel.org

The patch

   ASoC: tpa6130a2: Remove goto err_gpio

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 39088c251c69d3b7b288e30228aed06e1d339da5 Mon Sep 17 00:00:00 2001
From: Helen Koike <helen.koike@collabora.co.uk>
Date: Thu, 23 Jun 2016 16:23:14 -0300
Subject: [PATCH] ASoC: tpa6130a2: Remove goto err_gpio

Replace goto err_gpio by return ret

Signed-off-by: Helen Koike <helen.koike@collabora.co.uk>
Tested-by: Sebastian Reichel <sre@kernel.org>
Reviewed-by: Sebastian Reichel <sre@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/tpa6130a2.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/tpa6130a2.c b/sound/soc/codecs/tpa6130a2.c
index 9da1dd12f839..f1ea052a822e 100644
--- a/sound/soc/codecs/tpa6130a2.c
+++ b/sound/soc/codecs/tpa6130a2.c
@@ -256,7 +256,7 @@ static int tpa6130a2_probe(struct i2c_client *client,
 		if (ret < 0) {
 			dev_err(dev, "Failed to request power GPIO (%d)\n",
 				data->power_gpio);
-			goto err_gpio;
+			return ret;
 		}
 		gpio_direction_output(data->power_gpio, 0);
 	}
@@ -277,12 +277,12 @@ static int tpa6130a2_probe(struct i2c_client *client,
 	if (IS_ERR(data->supply)) {
 		ret = PTR_ERR(data->supply);
 		dev_err(dev, "Failed to request supply: %d\n", ret);
-		goto err_gpio;
+		return ret;
 	}
 
 	ret = tpa6130a2_power(data, true);
 	if (ret != 0)
-		goto err_gpio;
+		return ret;
 
 
 	/* Read version */
@@ -294,13 +294,10 @@ static int tpa6130a2_probe(struct i2c_client *client,
 	/* Disable the chip */
 	ret = tpa6130a2_power(data, false);
 	if (ret != 0)
-		goto err_gpio;
+		return ret;
 
 	return devm_snd_soc_register_component(&client->dev,
 			&tpa6130a2_component_driver, NULL, 0);
-
-err_gpio:
-	return ret;
 }
 
 static const struct i2c_device_id tpa6130a2_id[] = {
-- 
2.8.1

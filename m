From: Helen Koike <helen.koike@collabora.co.uk>
Subject: [PATCH v3 2/2] ASoC: tpa6130a2: Remove goto err_gpio
Date: Thu, 23 Jun 2016 16:23:14 -0300
Message-ID: <a1b8846a7221bd5bb6c1beb98802e7502d1dacd5.1466709086.git.helen.koike@collabora.co.uk>
References: <cover.1466441036.git.helen.koike@collabora.co.uk>
 <cover.1466709086.git.helen.koike@collabora.co.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1466709086.git.helen.koike@collabora.co.uk>
In-Reply-To: <cover.1466709086.git.helen.koike@collabora.co.uk>
References: <cover.1466709086.git.helen.koike@collabora.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: lgirdwood@gmail.com, broonie@kernel.org, peter.ujfalusi@ti.com, jarkko.nikula@bitmer.com, lars@metafoo.de, k.kozlowski@samsung.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, perex@perex.cz, tiwai@suse.com, cphealy@gmail.com, Helen Koike <helen.koike@collabora.co.uk>
List-Id: linux-omap@vger.kernel.org

Replace goto err_gpio by return ret

Signed-off-by: Helen Koike <helen.koike@collabora.co.uk>
Tested-by: Sebastian Reichel <sre@kernel.org>
Reviewed-by: Sebastian Reichel <sre@kernel.org>

---
Changes since v1:
- this is a new patch in the series

Changes since v2:
- Add tested-by and reviewed-by from Sebastian

 sound/soc/codecs/tpa6130a2.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/tpa6130a2.c b/sound/soc/codecs/tpa6130a2.c
index 9da1dd1..f1ea052 100644
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
1.9.1

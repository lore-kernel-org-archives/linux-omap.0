From: Helen Koike <helen.koike@collabora.co.uk>
Subject: [PATCH v2 5/5] ASoC: tpa6130a2: Remove goto err_gpio
Date: Mon, 20 Jun 2016 14:12:33 -0300
Message-ID: <903012887a1b2f8f59e44b1cfb472c9362fd964f.1466441036.git.helen.koike@collabora.co.uk>
References: <20160618104038.GB31665@earth>
 <cover.1466441036.git.helen.koike@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <cover.1466441036.git.helen.koike@collabora.co.uk>
In-Reply-To: <cover.1466441036.git.helen.koike@collabora.co.uk>
References: <cover.1466441036.git.helen.koike@collabora.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sebastian Reichel <sre@kernel.org>
Cc: k.kozlowski@samsung.com, lars@metafoo.de, alsa-devel@alsa-project.org, tiwai@suse.com, lgirdwood@gmail.com, linux-kernel@vger.kernel.org, peter.ujfalusi@ti.com, broonie@kernel.org, cphealy@gmail.com, Helen Koike <helen.koike@collabora.co.uk>, linux-omap@vger.kernel.org, jarkko.nikula@bitmer.com
List-Id: linux-omap@vger.kernel.org

Replace goto err_gpio by return ret

Signed-off-by: Helen Koike <helen.koike@collabora.co.uk>

---

Changes since v1:
- this is a new patch in the series

 sound/soc/codecs/tpa6130a2.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/tpa6130a2.c b/sound/soc/codecs/tpa6130a2.c
index cc83870..a919308 100644
--- a/sound/soc/codecs/tpa6130a2.c
+++ b/sound/soc/codecs/tpa6130a2.c
@@ -255,7 +255,7 @@ static int tpa6130a2_probe(struct i2c_client *client,
 		if (ret < 0) {
 			dev_err(dev, "Failed to request power GPIO (%d)\n",
 				data->power_gpio);
-			goto err_gpio;
+			return ret;
 		}
 		gpio_direction_output(data->power_gpio, 0);
 	}
@@ -276,12 +276,12 @@ static int tpa6130a2_probe(struct i2c_client *client,
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
@@ -293,13 +293,10 @@ static int tpa6130a2_probe(struct i2c_client *client,
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

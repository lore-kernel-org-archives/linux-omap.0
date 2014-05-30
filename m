From: Stephen Warren <swarren@wwwdotorg.org>
Subject: [PATCH] ASoC: free jack GPIOs before the sound card is freed
Date: Fri, 30 May 2014 12:42:57 -0600
Message-ID: <1401475377-12123-1-git-send-email-swarren@wwwdotorg.org>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Stephen Warren <swarren@nvidia.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Philipp Zabel <philipp.zabel@gmail.com>, Paul Parsons <lost.distance@yahoo.com>, Eric Miao <eric.y.miao@gmail.com>, Russell King <linux@arm.linux.org.uk>, Haojian Zhuang <haojian.zhuang@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, Sangbeom Kim <sbkim73@samsung.com>, "open list:OMAP AUDIO SUPPORT" <linux-omap@vger.kernel.org>, "moderated list:ARM/SAMSUNG ARM A..." <linux-samsung-soc@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

From: Stephen Warren <swarren@nvidia.com>

This is the same change as commit fb6b8e71448a "ASoC: tegra: free jack
GPIOs before the sound card is freed", but applied to all other ASoC
machine drivers where code inspection indicates the same problem exists.

That commit's description is:
==========
snd_soc_jack_add_gpios() schedules a work queue item to poll the GPIO to
generate an initial jack status report. If sound card initialization
fails, that work item needs to be cancelled, so it doesn't run after the
card has been freed. Specifically, freeing the card calls
snd_jack_dev_free() which calls snd_jack_dev_disconnect() which sets
jack->input_dev = NULL, and input_dev is used by snd_jack_report(), which
is called from the work queue item.

snd_soc_jack_free_gpios() cancels the work item. The Tegra ASoC machine
drivers do call this function in the platform driver remove() callback.
However, this happens after the sound card is freed, at least when the
card is freed due to errors late during snd_soc_instantiate_card(). This
leaves a window where the work item can execute after the card is freed.
In next-20140522, sound card initialization does fail for unrelated
reasons, and hits the problem described above.

To solve this, fix the Tegra ASoC machine drivers to clean up the Jack
GPIOs during the snd_soc_card's .remove() callback, which is executed
before the overall card object is freed. also, guard the cleanup call
based on whether we actually setup up the GPIOs in the first place.
Ideally, we'd do the cleanup in a struct snd_soc_dai_link .fini/remove
function to match where the GPIOs get set up. However, there is no such
callback.
==========

Note that I have not even compile-tested this in most cases, since most
of the drivers rely on specific mach-* support I don't have enabled, and
don't support COMPILE_TEST. Testing by the relevant board maintainers
would be useful.

Cc: Peter Ujfalusi <peter.ujfalusi@ti.com> (maintainer:OMAP AUDIO SUPPORT)
Cc: Jarkko Nikula <jarkko.nikula@bitmer.com> (maintainer:OMAP AUDIO SUPPORT)
Cc: Philipp Zabel <philipp.zabel@gmail.com> (maintainer:ARM/H4700 (HP IPA...)
Cc: Paul Parsons <lost.distance@yahoo.com> (maintainer:ARM/H4700 (HP IPA...)
Cc: Eric Miao <eric.y.miao@gmail.com> (maintainer:PXA2xx/PXA3xx SUP...)
Cc: Russell King <linux@arm.linux.org.uk> (maintainer:PXA2xx/PXA3xx SUP...)
Cc: Haojian Zhuang <haojian.zhuang@gmail.com> (maintainer:PXA2xx/PXA3xx SUP...)
Cc: Ben Dooks <ben-linux@fluff.org> (maintainer:ARM/SAMSUNG ARM A...)
Cc: Kukjin Kim <kgene.kim@samsung.com> (maintainer:ARM/SAMSUNG ARM A...)
Cc: Sangbeom Kim <sbkim73@samsung.com> (supporter:SAMSUNG AUDIO (AS...)
Cc: linux-omap@vger.kernel.org (open list:OMAP AUDIO SUPPORT)
Cc: linux-samsung-soc@vger.kernel.org (moderated list:ARM/SAMSUNG ARM A...)
Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
Mark, do you need this patch split up by architecture for topic branches?
I assume not if you've already sent your pull requests. This applies fine
on top of tag asoc-v3.16.
---
 sound/soc/omap/ams-delta.c         | 14 ++++++++++----
 sound/soc/omap/omap-twl4030.c      | 28 ++++++++++++++--------------
 sound/soc/omap/rx51.c              | 18 +++++++++---------
 sound/soc/pxa/hx4700.c             |  9 ++++++++-
 sound/soc/samsung/h1940_uda1380.c  | 11 +++++++++--
 sound/soc/samsung/rx1950_uda1380.c | 12 ++++++++++--
 sound/soc/samsung/smartq_wm8987.c  | 11 +++++++++--
 7 files changed, 69 insertions(+), 34 deletions(-)

diff --git a/sound/soc/omap/ams-delta.c b/sound/soc/omap/ams-delta.c
index bb243c663e6b..1f41951d8b7f 100644
--- a/sound/soc/omap/ams-delta.c
+++ b/sound/soc/omap/ams-delta.c
@@ -527,6 +527,15 @@ static int ams_delta_cx20442_init(struct snd_soc_pcm_runtime *rtd)
 	return 0;
 }
 
+static int ams_delta_card_remove(struct snd_soc_pcm_runtime *rtd)
+{
+	snd_soc_jack_free_gpios(&ams_delta_hook_switch,
+			ARRAY_SIZE(ams_delta_hook_switch_gpios),
+			ams_delta_hook_switch_gpios);
+
+	return 0;
+}
+
 /* DAI glue - connects codec <--> CPU */
 static struct snd_soc_dai_link ams_delta_dai_link = {
 	.name = "CX20442",
@@ -543,6 +552,7 @@ static struct snd_soc_dai_link ams_delta_dai_link = {
 static struct snd_soc_card ams_delta_audio_card = {
 	.name = "AMS_DELTA",
 	.owner = THIS_MODULE,
+	.remove = ams_delta_card_remove,
 	.dai_link = &ams_delta_dai_link,
 	.num_links = 1,
 
@@ -579,10 +589,6 @@ static int ams_delta_remove(struct platform_device *pdev)
 		dev_warn(&pdev->dev,
 			"failed to unregister V253 line discipline\n");
 
-	snd_soc_jack_free_gpios(&ams_delta_hook_switch,
-			ARRAY_SIZE(ams_delta_hook_switch_gpios),
-			ams_delta_hook_switch_gpios);
-
 	snd_soc_unregister_card(card);
 	card->dev = NULL;
 	return 0;
diff --git a/sound/soc/omap/omap-twl4030.c b/sound/soc/omap/omap-twl4030.c
index 64141db311b2..b4e282871658 100644
--- a/sound/soc/omap/omap-twl4030.c
+++ b/sound/soc/omap/omap-twl4030.c
@@ -231,6 +231,19 @@ static int omap_twl4030_init(struct snd_soc_pcm_runtime *rtd)
 	return ret;
 }
 
+static int omap_twl4030_card_remove(struct snd_soc_pcm_runtime *rtd)
+{
+	struct snd_soc_card *card = rtd->card;
+	struct omap_twl4030 *priv = snd_soc_card_get_drvdata(card);
+
+	if (priv->jack_detect > 0)
+		snd_soc_jack_free_gpios(&priv->hs_jack,
+					ARRAY_SIZE(hs_jack_gpios),
+					hs_jack_gpios);
+
+	return 0;
+}
+
 /* Digital audio interface glue - connects codec <--> CPU */
 static struct snd_soc_dai_link omap_twl4030_dai_links[] = {
 	{
@@ -258,6 +271,7 @@ static struct snd_soc_dai_link omap_twl4030_dai_links[] = {
 /* Audio machine driver */
 static struct snd_soc_card omap_twl4030_card = {
 	.owner = THIS_MODULE,
+	.remove = omap_twl4030_card_remove,
 	.dai_link = omap_twl4030_dai_links,
 	.num_links = ARRAY_SIZE(omap_twl4030_dai_links),
 
@@ -353,19 +367,6 @@ static int omap_twl4030_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int omap_twl4030_remove(struct platform_device *pdev)
-{
-	struct snd_soc_card *card = platform_get_drvdata(pdev);
-	struct omap_twl4030 *priv = snd_soc_card_get_drvdata(card);
-
-	if (priv->jack_detect > 0)
-		snd_soc_jack_free_gpios(&priv->hs_jack,
-					ARRAY_SIZE(hs_jack_gpios),
-					hs_jack_gpios);
-
-	return 0;
-}
-
 static const struct of_device_id omap_twl4030_of_match[] = {
 	{.compatible = "ti,omap-twl4030", },
 	{ },
@@ -380,7 +381,6 @@ static struct platform_driver omap_twl4030_driver = {
 		.of_match_table = omap_twl4030_of_match,
 	},
 	.probe = omap_twl4030_probe,
-	.remove = omap_twl4030_remove,
 };
 
 module_platform_driver(omap_twl4030_driver);
diff --git a/sound/soc/omap/rx51.c b/sound/soc/omap/rx51.c
index 6951dc812055..47a10290535b 100644
--- a/sound/soc/omap/rx51.c
+++ b/sound/soc/omap/rx51.c
@@ -334,6 +334,14 @@ static int rx51_aic34_init(struct snd_soc_pcm_runtime *rtd)
 	return err;
 }
 
+static int rx51_card_remove(struct snd_soc_pcm_runtime *rtd)
+{
+	snd_soc_jack_free_gpios(&rx51_av_jack, ARRAY_SIZE(rx51_av_jack_gpios),
+				rx51_av_jack_gpios);
+
+	return 0;
+}
+
 /* Digital audio interface glue - connects codec <--> CPU */
 static struct snd_soc_dai_link rx51_dai[] = {
 	{
@@ -368,6 +376,7 @@ static struct snd_soc_codec_conf rx51_codec_conf[] = {
 static struct snd_soc_card rx51_sound_card = {
 	.name = "RX-51",
 	.owner = THIS_MODULE,
+	.remove = rx51_card_remove,
 	.dai_link = rx51_dai,
 	.num_links = ARRAY_SIZE(rx51_dai),
 	.aux_dev = rx51_aux_dev,
@@ -499,14 +508,6 @@ static int rx51_soc_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int rx51_soc_remove(struct platform_device *pdev)
-{
-	snd_soc_jack_free_gpios(&rx51_av_jack, ARRAY_SIZE(rx51_av_jack_gpios),
-				rx51_av_jack_gpios);
-
-	return 0;
-}
-
 #if defined(CONFIG_OF)
 static const struct of_device_id rx51_audio_of_match[] = {
 	{ .compatible = "nokia,n900-audio", },
@@ -522,7 +523,6 @@ static struct platform_driver rx51_soc_driver = {
 		.of_match_table = of_match_ptr(rx51_audio_of_match),
 	},
 	.probe = rx51_soc_probe,
-	.remove = rx51_soc_remove,
 };
 
 module_platform_driver(rx51_soc_driver);
diff --git a/sound/soc/pxa/hx4700.c b/sound/soc/pxa/hx4700.c
index dcc9b04bd92c..6b81acaffddd 100644
--- a/sound/soc/pxa/hx4700.c
+++ b/sound/soc/pxa/hx4700.c
@@ -152,6 +152,13 @@ static int hx4700_ak4641_init(struct snd_soc_pcm_runtime *rtd)
 	return err;
 }
 
+static int hx4700_card_remove(struct snd_soc_pcm_runtime *rtd)
+{
+	snd_soc_jack_free_gpios(&hs_jack, 1, &hs_jack_gpio);
+
+	return 0;
+}
+
 /* hx4700 digital audio interface glue - connects codec <--> CPU */
 static struct snd_soc_dai_link hx4700_dai = {
 	.name = "ak4641",
@@ -170,6 +177,7 @@ static struct snd_soc_dai_link hx4700_dai = {
 static struct snd_soc_card snd_soc_card_hx4700 = {
 	.name			= "iPAQ hx4700",
 	.owner			= THIS_MODULE,
+	.remove			= hx4700_card_remove,
 	.dai_link		= &hx4700_dai,
 	.num_links		= 1,
 	.dapm_widgets		= hx4700_dapm_widgets,
@@ -206,7 +214,6 @@ static int hx4700_audio_probe(struct platform_device *pdev)
 
 static int hx4700_audio_remove(struct platform_device *pdev)
 {
-	snd_soc_jack_free_gpios(&hs_jack, 1, &hs_jack_gpio);
 	snd_soc_unregister_card(&snd_soc_card_hx4700);
 
 	gpio_set_value(GPIO92_HX4700_HP_DRIVER, 0);
diff --git a/sound/soc/samsung/h1940_uda1380.c b/sound/soc/samsung/h1940_uda1380.c
index 9f2fb69dbaae..720357f11a7f 100644
--- a/sound/soc/samsung/h1940_uda1380.c
+++ b/sound/soc/samsung/h1940_uda1380.c
@@ -189,6 +189,14 @@ static int h1940_uda1380_init(struct snd_soc_pcm_runtime *rtd)
 	return 0;
 }
 
+static int h1940_uda1380_card_remove(struct snd_soc_pcm_runtime *rtd)
+{
+	snd_soc_jack_free_gpios(&hp_jack, ARRAY_SIZE(hp_jack_gpios),
+		hp_jack_gpios);
+
+	return 0;
+}
+
 /* s3c24xx digital audio interface glue - connects codec <--> CPU */
 static struct snd_soc_dai_link h1940_uda1380_dai[] = {
 	{
@@ -206,6 +214,7 @@ static struct snd_soc_dai_link h1940_uda1380_dai[] = {
 static struct snd_soc_card h1940_asoc = {
 	.name = "h1940",
 	.owner = THIS_MODULE,
+	.remove = h1940_uda1380_card_remove,
 	.dai_link = h1940_uda1380_dai,
 	.num_links = ARRAY_SIZE(h1940_uda1380_dai),
 
@@ -257,8 +266,6 @@ err_out:
 static void __exit h1940_exit(void)
 {
 	platform_device_unregister(s3c24xx_snd_device);
-	snd_soc_jack_free_gpios(&hp_jack, ARRAY_SIZE(hp_jack_gpios),
-		hp_jack_gpios);
 	gpio_free(S3C_GPIO_END + 9);
 }
 
diff --git a/sound/soc/samsung/rx1950_uda1380.c b/sound/soc/samsung/rx1950_uda1380.c
index 5b3e504d3a32..192aa9fc102f 100644
--- a/sound/soc/samsung/rx1950_uda1380.c
+++ b/sound/soc/samsung/rx1950_uda1380.c
@@ -31,6 +31,7 @@
 #include "s3c24xx-i2s.h"
 
 static int rx1950_uda1380_init(struct snd_soc_pcm_runtime *rtd);
+static int rx1950_uda1380_card_remove(struct snd_soc_pcm_runtime *rtd);
 static int rx1950_startup(struct snd_pcm_substream *substream);
 static int rx1950_hw_params(struct snd_pcm_substream *substream,
 				struct snd_pcm_hw_params *params);
@@ -116,6 +117,7 @@ static const struct snd_soc_dapm_route audio_map[] = {
 static struct snd_soc_card rx1950_asoc = {
 	.name = "rx1950",
 	.owner = THIS_MODULE,
+	.remove = rx1950_uda1380_card_remove,
 	.dai_link = rx1950_uda1380_dai,
 	.num_links = ARRAY_SIZE(rx1950_uda1380_dai),
 
@@ -234,6 +236,14 @@ static int rx1950_uda1380_init(struct snd_soc_pcm_runtime *rtd)
 	return 0;
 }
 
+static int rx1950_uda1380_card_remove(struct snd_soc_pcm_runtime *rtd)
+{
+	snd_soc_jack_free_gpios(&hp_jack, ARRAY_SIZE(hp_jack_gpios),
+		hp_jack_gpios);
+
+	return 0;
+}
+
 static int __init rx1950_init(void)
 {
 	int ret;
@@ -278,8 +288,6 @@ err_gpio:
 static void __exit rx1950_exit(void)
 {
 	platform_device_unregister(s3c24xx_snd_device);
-	snd_soc_jack_free_gpios(&hp_jack, ARRAY_SIZE(hp_jack_gpios),
-		hp_jack_gpios);
 	gpio_free(S3C2410_GPA(1));
 }
 
diff --git a/sound/soc/samsung/smartq_wm8987.c b/sound/soc/samsung/smartq_wm8987.c
index df55db5d3554..271a904277a1 100644
--- a/sound/soc/samsung/smartq_wm8987.c
+++ b/sound/soc/samsung/smartq_wm8987.c
@@ -182,6 +182,14 @@ static int smartq_wm8987_init(struct snd_soc_pcm_runtime *rtd)
 	return err;
 }
 
+static int smartq_wm8987_card_remove(struct snd_soc_pcm_runtime *rtd)
+{
+	snd_soc_jack_free_gpios(&smartq_jack, ARRAY_SIZE(smartq_jack_gpios),
+				smartq_jack_gpios);
+
+	return 0;
+}
+
 static struct snd_soc_dai_link smartq_dai[] = {
 	{
 		.name		= "wm8987",
@@ -198,6 +206,7 @@ static struct snd_soc_dai_link smartq_dai[] = {
 static struct snd_soc_card snd_soc_smartq = {
 	.name = "SmartQ",
 	.owner = THIS_MODULE,
+	.remove = smartq_wm8987_card_remove,
 	.dai_link = smartq_dai,
 	.num_links = ARRAY_SIZE(smartq_dai),
 
@@ -259,8 +268,6 @@ err_unregister_device:
 static void __exit smartq_exit(void)
 {
 	gpio_free(S3C64XX_GPK(12));
-	snd_soc_jack_free_gpios(&smartq_jack, ARRAY_SIZE(smartq_jack_gpios),
-				smartq_jack_gpios);
 
 	platform_device_unregister(smartq_snd_device);
 }
-- 
1.8.1.5

From: "Lopez Cruz, Misael" <x0052729@ti.com>
Subject: [PATCH] SoC: Move headset jack registration to device
 initialization for SDP3430
Date: Thu, 12 Mar 2009 21:45:27 -0500
Message-ID: <2C7D3DF36ADFFC479B44490D912B616705ECF129A3@dlee07.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Mark Brown <broonie@sirena.org.uk>
List-Id: linux-omap@vger.kernel.org

Move headset jack registration to the codec/machine specific
initialization. Having the jack registration in machine init
causes that the jack device gets initialized but not registered
since the sound card is registered before the jack. Moving jack
registration to device initialization will register the jack
device along with all other devices associated to the card when
the card is registed. As a consequence of jack device registered
properly, the jack is detected as an input device.

Signed-off-by: Misael Lopez Cruz <x0052729@ti.com>
---
 sound/soc/omap/sdp3430.c |   74 ++++++++++++++++++++++++---------------------
 1 files changed, 39 insertions(+), 35 deletions(-)

diff --git a/sound/soc/omap/sdp3430.c b/sound/soc/omap/sdp3430.c
index 715c648..0a41de6 100644
--- a/sound/soc/omap/sdp3430.c
+++ b/sound/soc/omap/sdp3430.c
@@ -39,6 +39,8 @@
 #include "omap-pcm.h"
 #include "../codecs/twl4030.h"
 
+static struct snd_soc_card snd_soc_sdp3430;
+
 static int sdp3430_hw_params(struct snd_pcm_substream *substream,
 	struct snd_pcm_hw_params *params)
 {
@@ -82,6 +84,27 @@ static struct snd_soc_ops sdp3430_ops = {
 	.hw_params = sdp3430_hw_params,
 };
 
+/* Headset jack */
+static struct snd_soc_jack hs_jack;
+
+/* Headset jack detection DAPM pins */
+static struct snd_soc_jack_pin hs_jack_pins[] = {
+	{
+		.pin = "Headset Jack",
+		.mask = SND_JACK_HEADSET,
+	},
+};
+
+/* Headset jack detection gpios */
+static struct snd_soc_jack_gpio hs_jack_gpios[] = {
+	{
+		.gpio = (OMAP_MAX_GPIO_LINES + 2),
+		.name = "hsdet-gpio",
+		.report = SND_JACK_HEADSET,
+		.debounce_time = 200,
+	},
+};
+
 /* SDP3430 machine DAPM */
 static const struct snd_soc_dapm_widget sdp3430_twl4030_dapm_widgets[] = {
 	SND_SOC_DAPM_MIC("Ext Mic", NULL),
@@ -141,30 +164,25 @@ static int sdp3430_twl4030_init(struct snd_soc_codec *codec)
 	snd_soc_dapm_nc_pin(codec, "CARKITR");
 
 	ret = snd_soc_dapm_sync(codec);
+	if (ret)
+		return ret;
 
-	return ret;
-}
+	/* Headset jack detection */
+	ret = snd_soc_jack_new(&snd_soc_sdp3430, "Headset Jack",
+				SND_JACK_HEADSET, &hs_jack);
+	if (ret)
+		return ret;
 
-/* Headset jack */
-static struct snd_soc_jack hs_jack;
+	ret = snd_soc_jack_add_pins(&hs_jack, ARRAY_SIZE(hs_jack_pins),
+				hs_jack_pins);
+	if (ret)
+		return ret;
 
-/* Headset jack detection DAPM pins */
-static struct snd_soc_jack_pin hs_jack_pins[] = {
-	{
-		.pin = "Headset Jack",
-		.mask = SND_JACK_HEADSET,
-	},
-};
+	ret = snd_soc_jack_add_gpios(&hs_jack, ARRAY_SIZE(hs_jack_gpios),
+				hs_jack_gpios);
 
-/* Headset jack detection gpios */
-static struct snd_soc_jack_gpio hs_jack_gpios[] = {
-	{
-		.gpio = (OMAP_MAX_GPIO_LINES + 2),
-		.name = "hsdet-gpio",
-		.report = SND_JACK_HEADSET,
-		.debounce_time = 200,
-	},
-};
+	return ret;
+}
 
 /* Digital audio interface glue - connects codec <--> CPU */
 static struct snd_soc_dai_link sdp3430_dai = {
@@ -216,21 +234,7 @@ static int __init sdp3430_soc_init(void)
 	if (ret)
 		goto err1;
 
-	/* Headset jack detection */
-	ret = snd_soc_jack_new(&snd_soc_sdp3430, "SDP3430 headset jack",
-				SND_JACK_HEADSET, &hs_jack);
-	if (ret)
-		return ret;
-
-	ret = snd_soc_jack_add_pins(&hs_jack, ARRAY_SIZE(hs_jack_pins),
-				hs_jack_pins);
-	if (ret)
-		return ret;
-
-	ret = snd_soc_jack_add_gpios(&hs_jack, ARRAY_SIZE(hs_jack_gpios),
-				hs_jack_gpios);
-
-	return ret;
+	return 0;
 
 err1:
 	printk(KERN_ERR "Unable to add platform device\n");
-- 
1.5.4.3

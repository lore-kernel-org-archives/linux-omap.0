From: "Lopez Cruz, Misael" <x0052729@ti.com>
Subject: [PATCH 2/2] ASoC: Add headset jack detection for
 SDP3430 machine driver
Date: Wed, 4 Mar 2009 11:39:12 -0600
Message-ID: <2C7D3DF36ADFFC479B44490D912B616705ECD6E1B6@dlee07.ent.ti.com>
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
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Mark Brown <broonie@sirena.org.uk>
List-Id: linux-omap@vger.kernel.org

Add headset jack detection for SDP3430 boards using SoC jack
reporting interface. Headset detection on SDP3430 board is
achieved through TWL4030 GPIO_2 pin.

Signed-off-by: Misael Lopez Cruz <x0052729@ti.com>
---
 sound/soc/omap/sdp3430.c |   49 ++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 47 insertions(+), 2 deletions(-)

diff --git a/sound/soc/omap/sdp3430.c b/sound/soc/omap/sdp3430.c
index 4eab4b4..b595aa4 100644
--- a/sound/soc/omap/sdp3430.c
+++ b/sound/soc/omap/sdp3430.c
@@ -28,6 +28,7 @@
 #include <sound/pcm.h>
 #include <sound/soc.h>
 #include <sound/soc-dapm.h>
+#include <sound/jack.h>
 
 #include <asm/mach-types.h>
 #include <mach/hardware.h>
@@ -122,7 +123,7 @@ static int sdp3430_twl4030_init(struct snd_soc_codec *codec)
 	/* SDP3430 connected pins */
 	snd_soc_dapm_enable_pin(codec, "Ext Mic");
 	snd_soc_dapm_enable_pin(codec, "Ext Spk");
-	snd_soc_dapm_enable_pin(codec, "Headset Jack");
+	snd_soc_dapm_disable_pin(codec, "Headset Jack");
 
 	/* TWL4030 not connected pins */
 	snd_soc_dapm_nc_pin(codec, "AUXL");
@@ -144,6 +145,29 @@ static int sdp3430_twl4030_init(struct snd_soc_codec *codec)
 	return ret;
 }
 
+/* Headset jack */
+struct snd_soc_jack *hs_jack;
+
+/* Headset jack DAPM pins */
+struct snd_soc_jack_pin hs_jack_pins[] = {
+	{
+		.pin = "Headset Jack",
+		.mask = SND_JACK_HEADSET,
+		.invert = 0,
+	},
+};
+
+/* Headset jack gpios */
+struct snd_soc_jack_gpio hs_jack_gpios[] = {
+	{
+		.gpio = (OMAP_MAX_GPIO_LINES + 2),
+		.name = "hsdet-gpio",
+		.report = SND_JACK_HEADSET,
+		.invert = 0,
+		.debounce_time = 200,
+	},
+};
+
 /* Digital audio interface glue - connects codec <--> CPU */
 static struct snd_soc_dai_link sdp3430_dai = {
 	.name = "TWL4030",
@@ -194,8 +218,25 @@ static int __init sdp3430_soc_init(void)
 	if (ret)
 		goto err1;
 
-	return 0;
+	/* Headset jack detection */
+	hs_jack = kzalloc(sizeof(struct snd_soc_jack), GFP_KERNEL);
+	if (!hs_jack)
+		return -ENOMEM;
+
+	ret = snd_soc_jack_new(&snd_soc_sdp3430, "SDP3430 headset jack",
+				SND_JACK_HEADSET, hs_jack);
+	if (ret)
+		return ret;
+
+	ret = snd_soc_jack_add_pins(hs_jack, ARRAY_SIZE(hs_jack_pins),
+				hs_jack_pins);
+	if (ret)
+		return ret;
+
+	ret = snd_soc_jack_add_gpios(hs_jack, ARRAY_SIZE(hs_jack_gpios),
+				hs_jack_gpios);
 
+	return ret;
 err1:
 	printk(KERN_ERR "Unable to add platform device\n");
 	platform_device_put(sdp3430_snd_device);
@@ -206,6 +247,10 @@ module_init(sdp3430_soc_init);
 
 static void __exit sdp3430_soc_exit(void)
 {
+	snd_soc_jack_free_gpios(hs_jack, ARRAY_SIZE(hs_jack_gpios),
+				hs_jack_gpios);
+	kfree(hs_jack);
+
 	platform_device_unregister(sdp3430_snd_device);
 }
 module_exit(sdp3430_soc_exit);
-- 
1.5.4.3

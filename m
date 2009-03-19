From: "Lopez Cruz, Misael" <x0052729@ti.com>
Subject: [PATCH] ASoC: Declare Headset as Mic and Headphone
 widgets for SDP3430
Date: Thu, 19 Mar 2009 01:07:34 -0500
Message-ID: <2C7D3DF36ADFFC479B44490D912B616705ECF95F43@dlee07.ent.ti.com>
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

Headset was declared previously as a Headphone widget connecting
HSMIC and HSOL/HSOR pins of TWL4030 codec in SDP430 machine driver.
The capture path becomes invalid as the Headphone widget is not a
valid input endpoint.

Instead of that, the Headset is declared as separate Microphone
and Headphone widgets. Current patch modifies audio map:

- Headset Mic: HSMIC with bias
- Headset Stereophone: HSOL, HSOR

Signed-off-by: Misael Lopez Cruz <x0052729@ti.com>
---
 sound/soc/omap/sdp3430.c |   24 ++++++++++++++++--------
 1 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/sound/soc/omap/sdp3430.c b/sound/soc/omap/sdp3430.c
index 0a41de6..10f1c86 100644
--- a/sound/soc/omap/sdp3430.c
+++ b/sound/soc/omap/sdp3430.c
@@ -90,8 +90,12 @@ static struct snd_soc_jack hs_jack;
 /* Headset jack detection DAPM pins */
 static struct snd_soc_jack_pin hs_jack_pins[] = {
 	{
-		.pin = "Headset Jack",
-		.mask = SND_JACK_HEADSET,
+		.pin = "Headset Mic",
+		.mask = SND_JACK_MICROPHONE,
+	},
+	{
+		.pin = "Headset Stereophone",
+		.mask = SND_JACK_HEADPHONE,
 	},
 };
 
@@ -109,7 +113,8 @@ static struct snd_soc_jack_gpio hs_jack_gpios[] = {
 static const struct snd_soc_dapm_widget sdp3430_twl4030_dapm_widgets[] = {
 	SND_SOC_DAPM_MIC("Ext Mic", NULL),
 	SND_SOC_DAPM_SPK("Ext Spk", NULL),
-	SND_SOC_DAPM_HP("Headset Jack", NULL),
+	SND_SOC_DAPM_MIC("Headset Mic", NULL),
+	SND_SOC_DAPM_HP("Headset Stereophone", NULL),
 };
 
 static const struct snd_soc_dapm_route audio_map[] = {
@@ -123,11 +128,13 @@ static const struct snd_soc_dapm_route audio_map[] = {
 	{"Ext Spk", NULL, "HFL"},
 	{"Ext Spk", NULL, "HFR"},
 
-	/* Headset: HSMIC (with bias), HSOL, HSOR */
-	{"Headset Jack", NULL, "HSOL"},
-	{"Headset Jack", NULL, "HSOR"},
+	/* Headset Mic: HSMIC with bias */
 	{"HSMIC", NULL, "Headset Mic Bias"},
-	{"Headset Mic Bias", NULL, "Headset Jack"},
+	{"Headset Mic Bias", NULL, "Headset Mic"},
+
+	/* Headset Stereophone (Headphone): HSOL, HSOR */
+	{"Headset Stereophone", NULL, "HSOL"},
+	{"Headset Stereophone", NULL, "HSOR"},
 };
 
 static int sdp3430_twl4030_init(struct snd_soc_codec *codec)
@@ -146,7 +153,8 @@ static int sdp3430_twl4030_init(struct snd_soc_codec *codec)
 	/* SDP3430 connected pins */
 	snd_soc_dapm_enable_pin(codec, "Ext Mic");
 	snd_soc_dapm_enable_pin(codec, "Ext Spk");
-	snd_soc_dapm_disable_pin(codec, "Headset Jack");
+	snd_soc_dapm_disable_pin(codec, "Headset Mic");
+	snd_soc_dapm_disable_pin(codec, "Headset Stereophone");
 
 	/* TWL4030 not connected pins */
 	snd_soc_dapm_nc_pin(codec, "AUXL");
-- 
1.5.4.3

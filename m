From: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 1/8] ASoC: twl4030: Correct the support for Voice port
Date: Mon, 31 Dec 2012 11:51:42 +0100
Message-ID: <1356951109-4286-2-git-send-email-peter.ujfalusi@ti.com>
References: <1356951109-4286-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1356951109-4286-1-git-send-email-peter.ujfalusi-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Liam Girdwood <lrg-l0cyMroinI0@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Cc: NeilBrown <neilb-l3A5Bk7waGM@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org

In order to be able to use the Voice port of twl4030 three bits need to be
handled in VOICE_IF register:
VIF_EN: to enable the voice port (needed for both playback and capture)
VIF_DIN_EN: Need to be enabled for playback only (input to the codec)
VIF_DOUT_EN: Need to be enabled for capture only (output from codec)

Use DAPM_SUPPLY for the VIF_EN bit and add DAPM_AIF_IO/OUT widget to handle
the playback/capture bit.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
---
 sound/soc/codecs/twl4030.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index 63b280b..79b2f86 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -1306,6 +1306,9 @@ static const struct snd_soc_dapm_widget twl4030_dapm_widgets[] = {
 	SND_SOC_DAPM_DAC("DAC Left2", NULL, SND_SOC_NOPM, 0, 0),
 	SND_SOC_DAPM_DAC("DAC Voice", NULL, SND_SOC_NOPM, 0, 0),
 
+	SND_SOC_DAPM_AIF_IN("VAIFIN", "Voice Playback", 0,
+			    TWL4030_REG_VOICE_IF, 6, 0),
+
 	/* Analog bypasses */
 	SND_SOC_DAPM_SWITCH("Right1 Analog Loopback", SND_SOC_NOPM, 0, 0,
 			&twl4030_dapm_abypassr1_control),
@@ -1438,6 +1441,9 @@ static const struct snd_soc_dapm_widget twl4030_dapm_widgets[] = {
 	SND_SOC_DAPM_ADC("ADC Virtual Left2", NULL, SND_SOC_NOPM, 0, 0),
 	SND_SOC_DAPM_ADC("ADC Virtual Right2", NULL, SND_SOC_NOPM, 0, 0),
 
+	SND_SOC_DAPM_AIF_OUT("VAIFOUT", "Voice Capture", 0,
+			     TWL4030_REG_VOICE_IF, 5, 0),
+
 	/* Analog/Digital mic path selection.
 	   TX1 Left/Right: either analog Left/Right or Digimic0
 	   TX2 Left/Right: either analog Left/Right or Digimic1 */
@@ -1477,6 +1483,7 @@ static const struct snd_soc_dapm_widget twl4030_dapm_widgets[] = {
 	SND_SOC_DAPM_MICBIAS("Mic Bias 2", TWL4030_REG_MICBIAS_CTL, 1, 0),
 	SND_SOC_DAPM_MICBIAS("Headset Mic Bias", TWL4030_REG_MICBIAS_CTL, 2, 0),
 
+	SND_SOC_DAPM_SUPPLY("VIF Enable", TWL4030_REG_VOICE_IF, 0, 0, NULL, 0),
 };
 
 static const struct snd_soc_dapm_route intercon[] = {
@@ -1485,17 +1492,16 @@ static const struct snd_soc_dapm_route intercon[] = {
 	{"DAC Left1", NULL, "HiFi Playback"},
 	{"DAC Right2", NULL, "HiFi Playback"},
 	{"DAC Left2", NULL, "HiFi Playback"},
-	{"DAC Voice", NULL, "Voice Playback"},
+	{"DAC Voice", NULL, "VAIFIN"},
 
 	/* ADC -> Stream mapping */
 	{"HiFi Capture", NULL, "ADC Virtual Left1"},
 	{"HiFi Capture", NULL, "ADC Virtual Right1"},
 	{"HiFi Capture", NULL, "ADC Virtual Left2"},
 	{"HiFi Capture", NULL, "ADC Virtual Right2"},
-	{"Voice Capture", NULL, "ADC Virtual Left1"},
-	{"Voice Capture", NULL, "ADC Virtual Right1"},
-	{"Voice Capture", NULL, "ADC Virtual Left2"},
-	{"Voice Capture", NULL, "ADC Virtual Right2"},
+	{"VAIFOUT", NULL, "ADC Virtual Left2"},
+	{"VAIFOUT", NULL, "ADC Virtual Right2"},
+	{"VAIFOUT", NULL, "VIF Enable"},
 
 	{"Digital L1 Playback Mixer", NULL, "DAC Left1"},
 	{"Digital R1 Playback Mixer", NULL, "DAC Right1"},
@@ -1510,6 +1516,7 @@ static const struct snd_soc_dapm_route intercon[] = {
 	{"DAC Right1", NULL, "AIF Enable"},
 	{"DAC Left2", NULL, "AIF Enable"},
 	{"DAC Right1", NULL, "AIF Enable"},
+	{"DAC Voice", NULL, "VIF Enable"},
 
 	{"Digital R2 Playback Mixer", NULL, "AIF Enable"},
 	{"Digital L2 Playback Mixer", NULL, "AIF Enable"},
-- 
1.8.0.2

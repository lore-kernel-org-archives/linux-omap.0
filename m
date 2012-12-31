From: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 4/8] ASoC: twl4030: Convert MICBIAS to SUPPLY widget
Date: Mon, 31 Dec 2012 11:51:45 +0100
Message-ID: <1356951109-4286-5-git-send-email-peter.ujfalusi@ti.com>
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

In order to avoid breakage update the machine drivers at the same time using
twl4030: omap3pandora, sdp3430 and zoom2

Signed-off-by: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
---
 sound/soc/codecs/twl4030.c    | 10 +++++++---
 sound/soc/omap/omap3pandora.c |  8 ++++----
 sound/soc/omap/sdp3430.c      | 14 +++++++-------
 sound/soc/omap/zoom2.c        | 14 +++++++-------
 4 files changed, 25 insertions(+), 21 deletions(-)

diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index 79b2f86..5dd7c81 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -1479,9 +1479,13 @@ static const struct snd_soc_dapm_widget twl4030_dapm_widgets[] = {
 	SND_SOC_DAPM_SUPPLY("micbias2 select", TWL4030_REG_MICBIAS_CTL, 6, 0,
 			    NULL, 0),
 
-	SND_SOC_DAPM_MICBIAS("Mic Bias 1", TWL4030_REG_MICBIAS_CTL, 0, 0),
-	SND_SOC_DAPM_MICBIAS("Mic Bias 2", TWL4030_REG_MICBIAS_CTL, 1, 0),
-	SND_SOC_DAPM_MICBIAS("Headset Mic Bias", TWL4030_REG_MICBIAS_CTL, 2, 0),
+	/* Microphone bias */
+	SND_SOC_DAPM_SUPPLY("Mic Bias 1",
+			    TWL4030_REG_MICBIAS_CTL, 0, 0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY("Mic Bias 2",
+			    TWL4030_REG_MICBIAS_CTL, 1, 0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY("Headset Mic Bias",
+			    TWL4030_REG_MICBIAS_CTL, 2, 0, NULL, 0),
 
 	SND_SOC_DAPM_SUPPLY("VIF Enable", TWL4030_REG_VOICE_IF, 0, 0, NULL, 0),
 };
diff --git a/sound/soc/omap/omap3pandora.c b/sound/soc/omap/omap3pandora.c
index 43d950a..805512f 100644
--- a/sound/soc/omap/omap3pandora.c
+++ b/sound/soc/omap/omap3pandora.c
@@ -144,11 +144,11 @@ static const struct snd_soc_dapm_route omap3pandora_in_map[] = {
 	{"AUXL", NULL, "Line In"},
 	{"AUXR", NULL, "Line In"},
 
-	{"MAINMIC", NULL, "Mic Bias 1"},
-	{"Mic Bias 1", NULL, "Mic (internal)"},
+	{"MAINMIC", NULL, "Mic (internal)"},
+	{"Mic (internal)", NULL, "Mic Bias 1"},
 
-	{"SUBMIC", NULL, "Mic Bias 2"},
-	{"Mic Bias 2", NULL, "Mic (external)"},
+	{"SUBMIC", NULL, "Mic (external)"},
+	{"Mic (external)", NULL, "Mic Bias 2"},
 };
 
 static int omap3pandora_out_init(struct snd_soc_pcm_runtime *rtd)
diff --git a/sound/soc/omap/sdp3430.c b/sound/soc/omap/sdp3430.c
index 86e77e9..f2e2651 100644
--- a/sound/soc/omap/sdp3430.c
+++ b/sound/soc/omap/sdp3430.c
@@ -104,19 +104,19 @@ static const struct snd_soc_dapm_widget sdp3430_twl4030_dapm_widgets[] = {
 };
 
 static const struct snd_soc_dapm_route audio_map[] = {
-	/* External Mics: MAINMIC, SUBMIC with bias*/
-	{"MAINMIC", NULL, "Mic Bias 1"},
-	{"SUBMIC", NULL, "Mic Bias 2"},
-	{"Mic Bias 1", NULL, "Ext Mic"},
-	{"Mic Bias 2", NULL, "Ext Mic"},
+	/* External Mics: MAINMIC, SUBMIC with bias */
+	{"MAINMIC", NULL, "Ext Mic"},
+	{"SUBMIC", NULL, "Ext Mic"},
+	{"Ext Mic", NULL, "Mic Bias 1"},
+	{"Ext Mic", NULL, "Mic Bias 2"},
 
 	/* External Speakers: HFL, HFR */
 	{"Ext Spk", NULL, "HFL"},
 	{"Ext Spk", NULL, "HFR"},
 
 	/* Headset Mic: HSMIC with bias */
-	{"HSMIC", NULL, "Headset Mic Bias"},
-	{"Headset Mic Bias", NULL, "Headset Mic"},
+	{"HSMIC", NULL, "Headset Mic"},
+	{"Headset Mic", NULL, "Headset Mic Bias"},
 
 	/* Headset Stereophone (Headphone): HSOL, HSOR */
 	{"Headset Stereophone", NULL, "HSOL"},
diff --git a/sound/soc/omap/zoom2.c b/sound/soc/omap/zoom2.c
index 5845d48..62a6b02 100644
--- a/sound/soc/omap/zoom2.c
+++ b/sound/soc/omap/zoom2.c
@@ -69,11 +69,11 @@ static const struct snd_soc_dapm_widget zoom2_twl4030_dapm_widgets[] = {
 };
 
 static const struct snd_soc_dapm_route audio_map[] = {
-	/* External Mics: MAINMIC, SUBMIC with bias*/
-	{"MAINMIC", NULL, "Mic Bias 1"},
-	{"SUBMIC", NULL, "Mic Bias 2"},
-	{"Mic Bias 1", NULL, "Ext Mic"},
-	{"Mic Bias 2", NULL, "Ext Mic"},
+	/* External Mics: MAINMIC, SUBMIC with bias */
+	{"MAINMIC", NULL, "Ext Mic"},
+	{"SUBMIC", NULL, "Ext Mic"},
+	{"Ext Mic", NULL, "Mic Bias 1"},
+	{"Ext Mic", NULL, "Mic Bias 2"},
 
 	/* External Speakers: HFL, HFR */
 	{"Ext Spk", NULL, "HFL"},
@@ -84,8 +84,8 @@ static const struct snd_soc_dapm_route audio_map[] = {
 	{"Headset Stereophone", NULL, "HSOR"},
 
 	/* Headset Mic: HSMIC with bias */
-	{"HSMIC", NULL, "Headset Mic Bias"},
-	{"Headset Mic Bias", NULL, "Headset Mic"},
+	{"HSMIC", NULL, "Headset Mic"},
+	{"Headset Mic", NULL, "Headset Mic Bias"},
 
 	/* Aux In: AUXL, AUXR */
 	{"Aux In", NULL, "AUXL"},
-- 
1.8.0.2

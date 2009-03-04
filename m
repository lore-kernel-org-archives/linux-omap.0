From: "Lopez Cruz, Misael" <x0052729@ti.com>
Subject: [PATCH 1/2] ASoC: Add DAPM machine widgets to SDP3430
	driver
Date: Wed, 4 Mar 2009 11:39:07 -0600
Message-ID: <2C7D3DF36ADFFC479B44490D912B616705ECD6E1B5@dlee07.ent.ti.com>
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

Add DAPM machine domain widgets to SDP3430 machine driver.
Interconnection:
* Ext Mic: MAINMIC, SUBMIC
* Ext Spk: HFL, HFR
* Headset Jack: HSMIC, HSOL, HSOR

Signed-off-by: Misael Lopez Cruz <x0052729@ti.com>
---
 sound/soc/omap/sdp3430.c |   64 ++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 64 insertions(+), 0 deletions(-)

diff --git a/sound/soc/omap/sdp3430.c b/sound/soc/omap/sdp3430.c
index e226fa7..4eab4b4 100644
--- a/sound/soc/omap/sdp3430.c
+++ b/sound/soc/omap/sdp3430.c
@@ -81,12 +81,76 @@ static struct snd_soc_ops sdp3430_ops = {
 	.hw_params = sdp3430_hw_params,
 };
 
+/* SDP3430 machine DAPM */
+static const struct snd_soc_dapm_widget sdp3430_twl4030_dapm_widgets[] = {
+	SND_SOC_DAPM_MIC("Ext Mic", NULL),
+	SND_SOC_DAPM_SPK("Ext Spk", NULL),
+	SND_SOC_DAPM_HP("Headset Jack", NULL),
+};
+
+static const struct snd_soc_dapm_route audio_map[] = {
+	/* External Mics: MAINMIC, SUBMIC with bias*/
+	{"MAINMIC", NULL, "Mic Bias 1"},
+	{"SUBMIC", NULL, "Mic Bias 2"},
+	{"Mic Bias 1", NULL, "Ext Mic"},
+	{"Mic Bias 2", NULL, "Ext Mic"},
+
+	/* External Speakers: HFL, HFR */
+	{"Ext Spk", NULL, "HFL"},
+	{"Ext Spk", NULL, "HFR"},
+
+	/* Headset: HSMIC (with bias), HSOL, HSOR */
+	{"Headset Jack", NULL, "HSOL"},
+	{"Headset Jack", NULL, "HSOR"},
+	{"HSMIC", NULL, "Headset Mic Bias"},
+	{"Headset Mic Bias", NULL, "Headset Jack"},
+};
+
+static int sdp3430_twl4030_init(struct snd_soc_codec *codec)
+{
+	int ret;
+
+	/* Add SDP3430 specific widgets */
+	ret = snd_soc_dapm_new_controls(codec, sdp3430_twl4030_dapm_widgets,
+				ARRAY_SIZE(sdp3430_twl4030_dapm_widgets));
+	if (ret)
+		return ret;
+
+	/* Set up SDP3430 specific audio path audio_map */
+	snd_soc_dapm_add_routes(codec, audio_map, ARRAY_SIZE(audio_map));
+
+	/* SDP3430 connected pins */
+	snd_soc_dapm_enable_pin(codec, "Ext Mic");
+	snd_soc_dapm_enable_pin(codec, "Ext Spk");
+	snd_soc_dapm_enable_pin(codec, "Headset Jack");
+
+	/* TWL4030 not connected pins */
+	snd_soc_dapm_nc_pin(codec, "AUXL");
+	snd_soc_dapm_nc_pin(codec, "AUXR");
+	snd_soc_dapm_nc_pin(codec, "CARKITMIC");
+	snd_soc_dapm_nc_pin(codec, "DIGIMIC0");
+	snd_soc_dapm_nc_pin(codec, "DIGIMIC1");
+
+	snd_soc_dapm_nc_pin(codec, "OUTL");
+	snd_soc_dapm_nc_pin(codec, "OUTR");
+	snd_soc_dapm_nc_pin(codec, "EARPIECE");
+	snd_soc_dapm_nc_pin(codec, "PREDRIVEL");
+	snd_soc_dapm_nc_pin(codec, "PREDRIVER");
+	snd_soc_dapm_nc_pin(codec, "CARKITL");
+	snd_soc_dapm_nc_pin(codec, "CARKITR");
+
+	ret = snd_soc_dapm_sync(codec);
+
+	return ret;
+}
+
 /* Digital audio interface glue - connects codec <--> CPU */
 static struct snd_soc_dai_link sdp3430_dai = {
 	.name = "TWL4030",
 	.stream_name = "TWL4030",
 	.cpu_dai = &omap_mcbsp_dai[0],
 	.codec_dai = &twl4030_dai,
+	.init = sdp3430_twl4030_init,
 	.ops = &sdp3430_ops,
 };
 
-- 
1.5.4.3

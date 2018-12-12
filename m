From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/2] Graph fixes for using multiple endpoints per port
Date: Tue, 11 Dec 2018 16:43:20 -0800
Message-ID: <20181212004320.GY6707@atomide.com>
References: <20181211020557.61783-1-tony@atomide.com>
 <8736r4bvf3.wl-kuninori.morimoto.gx@renesas.com>
 <20181211045220.GI6707@atomide.com>
 <871s6obqkb.wl-kuninori.morimoto.gx@renesas.com>
 <20181211053536.GJ6707@atomide.com>
 <87wooga9an.wl-kuninori.morimoto.gx@renesas.com>
 <20181211141649.GL6707@atomide.com>
 <87ftv33bpg.wl-kuninori.morimoto.gx@renesas.com>
 <87efan393s.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87efan393s.wl-kuninori.morimoto.gx@renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Sebastian Reichel <sre@kernel.org>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>
List-Id: linux-omap@vger.kernel.org

* Kuninori Morimoto <kuninori.morimoto.gx@renesas.com> [181212 00:12]:
> 
> Hi Tony, again
> 
> > > The issue I have with that it does not then follow the binding doc :)
> > > 
> > > See this part in Documentation/devicetree/bindings/graph.txt:
> > > 
> > >  "If a single port is connected to more than one remote device, an
> > >  'endpoint' child node must be provided for each link."
> 
> My understanding is that 1 "port" is for 1 "physical interface".

Yes I agree.

> In sound case, it is 1 "DAI".
> And, 1 "endpoint" is for 1 "connection".

Yes. So I have 1 physical port (mcbsp) TDM split between
two codecs (cpcap and mdm).

> 	"If a single port is connected to more than one remote device, an
> 	'endpoint' child node must be provided for each link."
> 
> This meanns, "If 1 DAI (*1) is connected to multiple remote DAIs(*2),
> this connection is indicated by multiple "endpoint"" or something like that.
> 
> (*2)
> DAIA-endpoint---endpoint--\
> DAIB-endpoint---endpoint-----DAI (*1)
> DAIC-endpoint---endpoint--/

Yeah. So the only thing missing is parsing multiple endpoints
at the DAI end :) And that's why the two patches I posted.

> > > Isn't the I2C TDM case the same as "single port connecected to
> > > more than one remote device" rather than multiple ports?
> 
> I re-checked https://lkml.org/lkml/2018/3/28/405.
> Are MDM6600 / OMAP4 CPU portion, and are CPCAP / WL1285 Codec portion ?

MDM6600 is a Qualcomm modem running Motorola custom firmware
CPCAP is a Motorola custom PMIC for omap4430 SoC
WL128 is a WLAN and Bluetooth chip

So following your drawing above:

There are two separate McBSP instances, here's the one
in question:

MDM6600 modem-----endpoint--\
CPCAP PMIC codec2-endpoint----McBSP3 on SoC
WL1285 Bluetooth--endpoint--/

The other McBSP instance is dedicated for SoC audio:

CPCAP PMIC codec1-endpoint---McBSP3 on SoC

> Then, it is not yet supported (on ALSA SoC level?).

Only the cpcap codec is in the mainline currently, the mdm
codec driver has not yet been posted as it depends on some
ts 27.010 serdev patches.

> If my memory was correct, Lars-Peter had some idea for Mux,
> But, not yet implemented I think.

Hmm well I don't think much else is needed currently, we
already have everything needed at the ASoC level. See yet
another WIP patch configuring the TDM for mdm codec voice
call by the existing cpcap codec driver below just by
implementing .set_tdm_slot function.

> audio-graph[-scu] / simple-card[-scu] are supporting DPCM,
> but it is for multiple CPU - single Codec.

Well with my patches I certainly have the above configuration
working just fine with two audio-graph-card instances connected
to a single physical McBSP port.

Regards,

Tony

8< --------------------
diff --git a/sound/soc/codecs/cpcap.c b/sound/soc/codecs/cpcap.c
--- a/sound/soc/codecs/cpcap.c
+++ b/sound/soc/codecs/cpcap.c
@@ -16,6 +16,14 @@
 #include <sound/soc.h>
 #include <sound/tlv.h>
 
+/* Register 512 CPCAP_REG_VAUDIOC --- Audio Regulator and Bias Voltage */
+#define CPCAP_BIT_AUDIO_LOW_PWR           6
+#define CPCAP_BIT_AUD_LOWPWR_SPEED        5
+#define CPCAP_BIT_VAUDIOPRISTBY           4
+#define CPCAP_BIT_VAUDIO_MODE1            2
+#define CPCAP_BIT_VAUDIO_MODE0            1
+#define CPCAP_BIT_V_AUDIO_EN              0
+
 /* Register 513 CPCAP_REG_CC     --- CODEC */
 #define CPCAP_BIT_CDC_CLK2                15
 #define CPCAP_BIT_CDC_CLK1                14
@@ -251,6 +259,8 @@ struct cpcap_audio {
 	int codec_clk_id;
 	int codec_freq;
 	int codec_format;
+
+	unsigned int voice_call:1;
 };
 
 static int cpcap_st_workaround(struct snd_soc_dapm_widget *w,
@@ -1370,6 +1380,114 @@ static int cpcap_voice_set_dai_fmt(struct snd_soc_dai *codec_dai,
 	return 0;
 }
 
+/*
+ * Configure voice call if cpcap->voice_call is set.
+ *
+ * We can configure most with snd_soc_dai_set_sysclk(), snd_soc_dai_set_fmt()
+ * and snd_soc_dai_set_tdm_slot(). This function configures the rest of the
+ * cpcap related hardware piceses as CPU is not involved in the voice call.
+ */
+static int cpcap_voice_call(struct snd_soc_dai *dai)
+{
+	struct snd_soc_component *component = dai->component;
+	struct cpcap_audio *cpcap = snd_soc_component_get_drvdata(component);
+	int mask, err;
+
+	/* Maybe enable modem to codec VAUDIO_MODE1? */
+	mask = BIT(CPCAP_BIT_VAUDIO_MODE1);
+	err = regmap_update_bits(cpcap->regmap, CPCAP_REG_VAUDIOC,
+				 mask, cpcap->voice_call ? mask : 0);
+	if (err)
+		return err;
+
+	/* Maybe clear MIC1_MUX? */
+	mask = BIT(CPCAP_BIT_MIC1_MUX);
+	err = regmap_update_bits(cpcap->regmap, CPCAP_REG_TXI,
+				 mask, cpcap->voice_call ? 0 : mask);
+	if (err)
+		return err;
+
+	/* Maybe set MIC2_MUX? */
+	mask = BIT(CPCAP_BIT_MB_ON1L) | BIT(CPCAP_BIT_MB_ON1R) |
+		BIT(CPCAP_BIT_MIC2_MUX) | BIT(CPCAP_BIT_MIC2_PGA_EN);
+	err = regmap_update_bits(cpcap->regmap, CPCAP_REG_TXI,
+				 mask, cpcap->voice_call ? mask : 0);
+	if (err)
+		return err;
+
+	/* Maybe enable LDSP? */
+	mask = BIT(CPCAP_BIT_A2_LDSP_L_EN) | BIT(CPCAP_BIT_A2_LDSP_R_EN);
+	err = regmap_update_bits(cpcap->regmap, CPCAP_REG_RXOA,
+				 mask, cpcap->voice_call ? mask : 0);
+	if (err)
+		return err;
+
+	/* Maybe enable CPCAP_BIT_PGA_CDC_EN for call? */
+	mask = BIT(CPCAP_BIT_PGA_CDC_EN);
+	err = regmap_update_bits(cpcap->regmap, CPCAP_REG_RXCOA,
+				 mask, cpcap->voice_call ? mask : 0);
+	if (err)
+		return err;
+
+	/* Maybe unmute voice? */
+	err = snd_soc_dai_digital_mute(dai, !cpcap->voice_call,
+				       SNDRV_PCM_STREAM_PLAYBACK);
+	if (err)
+		return err;
+
+	/* Maybe enable modem to codec mic CDC and HPF? */
+	mask = BIT(CPCAP_BIT_MIC2_CDC_EN) | BIT(CPCAP_BIT_CDC_EN_RX) |
+	       BIT(CPCAP_BIT_AUDOHPF_1) | BIT(CPCAP_BIT_AUDOHPF_0) |
+	       BIT(CPCAP_BIT_AUDIHPF_1) | BIT(CPCAP_BIT_AUDIHPF_0);
+	err = regmap_update_bits(cpcap->regmap, CPCAP_REG_CC,
+				 mask, cpcap->voice_call ? mask : 0);
+	if (err)
+		return err;
+
+	/* Maybe enable modem to codec CDC? */
+	mask = BIT(CPCAP_BIT_CDC_CLK_EN);
+	err = regmap_update_bits(cpcap->regmap, CPCAP_REG_CDI,
+				 mask, cpcap->voice_call ? mask : 0);
+
+	return err;
+}
+
+static int cpcap_voice_set_tdm_slot(struct snd_soc_dai *dai,
+				    unsigned int tx_mask, unsigned int rx_mask,
+				    int slots, int slot_width)
+{
+	struct snd_soc_component *component = dai->component;
+	struct cpcap_audio *cpcap = snd_soc_component_get_drvdata(component);
+	int err, ts_mask, mask;
+
+	/* Modem to codec audio with no CPU involved? */
+	if (tx_mask == 0 && rx_mask == 1 && slot_width == 8)
+		cpcap->voice_call = true;
+	else
+		cpcap->voice_call = false;
+
+	ts_mask = 0x7 << CPCAP_BIT_MIC2_TIMESLOT0;
+	ts_mask |= 0x7 << CPCAP_BIT_MIC1_RX_TIMESLOT0;
+
+	mask = (tx_mask & 0x7) << CPCAP_BIT_MIC2_TIMESLOT0;
+	mask |= (rx_mask & 0x7) << CPCAP_BIT_MIC1_RX_TIMESLOT0;
+
+	err = regmap_update_bits(cpcap->regmap, CPCAP_REG_CDI,
+				 ts_mask, mask);
+	if (err)
+		return err;
+
+	err = cpcap_set_samprate(cpcap, CPCAP_DAI_VOICE, slot_width * 1000);
+	if (err)
+		return err;
+
+	err = cpcap_voice_call(dai);
+	if (err)
+		return err;
+
+	return 0;
+}
+
 static int cpcap_voice_set_mute(struct snd_soc_dai *dai, int mute)
 {
 	struct snd_soc_component *component = dai->component;
@@ -1391,6 +1509,7 @@ static const struct snd_soc_dai_ops cpcap_dai_voice_ops = {
 	.hw_params	= cpcap_voice_hw_params,
 	.set_sysclk	= cpcap_voice_set_dai_sysclk,
 	.set_fmt	= cpcap_voice_set_dai_fmt,
+	.set_tdm_slot	= cpcap_voice_set_tdm_slot,
 	.digital_mute	= cpcap_voice_set_mute,
 };
 

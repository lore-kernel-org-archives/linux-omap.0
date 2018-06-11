From: Pavel Machek <pavel@ucw.cz>
Subject: handling voice calls in ALSA soc (on Droid 4)
Date: Mon, 11 Jun 2018 12:25:30 +0200
Message-ID: <20180611102529.GA1272@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="zYM0uCDKw75PZbzx"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, sre@kernel.org, nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org, alsa-devel@alsa-project.org, tiwai@suse.com, perex@perex.cz, broonie@kernel.org, lgirdwood@gmail.com
List-Id: linux-omap@vger.kernel.org


--zYM0uCDKw75PZbzx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

During voice call, I need audio components to be active "as if" aplay
or arecord was running, because modem needs to comunicate with speaker
and microphone.

I hacked something up, but... I believe I'll need help here. Look at
"enable_call" for "interesting" stuff I had to do.

=2E..and also. What is right interface for this? Mixer component that
says if voice call is active or not?

Any ideas?

Thanks,
									Pavel

(edited).
+++ b/sound/soc/codecs/cpcap.c
@@ -330,6 +330,10 @@ static const char * const cpcap_in_left_mux_texts[] =
=3D {
 	"Off", "Mic 2", "Ext Left"
 };
=20
+static const char * const cpcap_mode_texts[] =3D {
+	"Normal", "Handsfree", "Call",
+};
+
 /*
  * input muxes use unusual register layout, so that we need to use custom
  * getter/setter methods
@@ -354,6 +358,8 @@ static SOC_ENUM_SINGLE_DECL(cpcap_hs_l_mux_enum, 0, 6, =
cpcap_out_mux_texts);
 static SOC_ENUM_SINGLE_DECL(cpcap_emu_l_mux_enum, 0, 7, cpcap_out_mux_text=
s);
 static SOC_ENUM_SINGLE_DECL(cpcap_emu_r_mux_enum, 0, 8, cpcap_out_mux_text=
s);
=20
+static SOC_ENUM_SINGLE_DECL(cpcap_mode_enum, 0, 9, cpcap_mode_texts);
+
 static int cpcap_output_mux_get_enum(struct snd_kcontrol *kcontrol,
 				     struct snd_ctl_elem_value *ucontrol)
 {
@@ -442,6 +448,211 @@ static int cpcap_output_mux_put_enum(struct snd_kcont=
rol *kcontrol,
 	return 0;
 }
=20
+static int mode;
+
+static int cpcap_mode_get_enum(struct snd_kcontrol *kcontrol,
+				     struct snd_ctl_elem_value *ucontrol)
+{
+	ucontrol->value.enumerated.item[0] =3D mode;
+
+	return 0;
+}
+
+static struct snd_soc_dai *voice_codec_dai_hack;
+
+static int enable_call(struct snd_soc_component *component, int on)
+{
+	struct cpcap_audio *cpcap =3D snd_soc_component_get_drvdata(component);

+		struct snd_soc_pcm_runtime *rt;
+
+		rt =3D snd_soc_get_pcm_runtime(component->card, "40126000.mcbsp-cpcap-vo=
ice");
+		printk("num_dai: %d, got runtime %lx\n", component->num_dai, rt);
+
+		if (rt) {
+		snd_soc_dapm_stream_event(rt, SNDRV_PCM_STREAM_PLAYBACK, SND_SOC_DAPM_ST=
REAM_START);
+		snd_soc_dapm_stream_event(rt, SNDRV_PCM_STREAM_CAPTURE, SND_SOC_DAPM_STR=
EAM_START);
+		}
+
+		cpcap_set_sysclk(cpcap, CPCAP_DAI_VOICE, 1, 19200000);
+		cpcap_set_samprate(cpcap, CPCAP_DAI_VOICE, 8000);
+	=09
+		cpcap_voice_set_dai_fmt(voice_codec_dai_hack,
+					SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBM_CFM );
+
+	return 0;
+}
+
+static int cpcap_mode_put_enum(struct snd_kcontrol *kcontrol,
+				     struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component =3D snd_soc_dapm_kcontrol_component(k=
control);
+	struct cpcap_audio *cpcap =3D snd_soc_component_get_drvdata(component);
+	unsigned int muxval =3D ucontrol->value.enumerated.item[0];
+
+	printk("Requested mode %d\n", muxval);
+
+	mode =3D muxval;
+
+	switch (muxval) {
+	case 1:
+		enable_call(component, 1);
+		break;
+	case 2:
+		enable_call(component, 1);
+
+		regmap_assert(cpcap, CPCAP_REG_TXI, 0xffff, 0x0cc6);
		...
+		break;
+	=09
+	default:
+		break;
+	}
+
+	return 0;
+}
+
 static int cpcap_input_right_mux_get_enum(struct snd_kcontrol *kcontrol,
 					  struct snd_ctl_elem_value *ucontrol)
 {
@@ -630,6 +841,10 @@ static const struct snd_kcontrol_new cpcap_earpiece_mu=
x =3D
 	SOC_DAPM_ENUM_EXT("Earpiece", cpcap_earpiece_mux_enum,
 			  cpcap_output_mux_get_enum, cpcap_output_mux_put_enum);
=20
+static const struct snd_kcontrol_new cpcap_mode =3D
+	SOC_DAPM_ENUM_EXT("Mode", cpcap_mode_enum,
+			  cpcap_mode_get_enum, cpcap_mode_put_enum);
+
 static const struct snd_kcontrol_new cpcap_hifi_mono_mixer_controls[] =3D {
 	SOC_DAPM_SINGLE("HiFi Mono Playback Switch",
 		CPCAP_REG_RXSDOA, CPCAP_BIT_MONO_DAC1, 1, 0),
@@ -771,6 +986,9 @@ static const struct snd_soc_dapm_widget cpcap_dapm_widg=
ets[] =3D {
 	SND_SOC_DAPM_MUX("EMU Left Playback Route", SND_SOC_NOPM, 0, 0,
 		&cpcap_emu_left_mux),
=20
+	SND_SOC_DAPM_MUX("Mode", SND_SOC_NOPM, 0, 0,
+		&cpcap_mode),
+=09
 	/* Output Amplifier */
 	SND_SOC_DAPM_PGA("Earpiece PGA",
 		CPCAP_REG_RXOA, CPCAP_BIT_A1_EAR_EN, 0, NULL, 0),
@@ -791,7 +1009,7 @@ static const struct snd_soc_dapm_widget cpcap_dapm_wid=
gets[] =3D {
 	SND_SOC_DAPM_PGA("EMU Left PGA",
 		CPCAP_REG_RXOA, CPCAP_BIT_EMU_SPKR_L_EN, 0, NULL, 0),
=20
-	/* Headet Charge Pump */
+	/* Headset Charge Pump */
 	SND_SOC_DAPM_SUPPLY("Headset Charge Pump",
 		CPCAP_REG_RXOA, CPCAP_BIT_ST_HS_CP_EN, 0, NULL, 0),
=20
@@ -1304,6 +1525,7 @@ static int cpcap_voice_set_dai_fmt(struct snd_soc_dai=
 *codec_dai,
 	u16 val =3D 0x0000;
 	int err;
=20
+	voice_codec_dai_hack =3D codec_dai;
 	dev_dbg(component->dev, "Voice setup dai format (%08x)", fmt);
=20
 	/*
@@ -1343,10 +1565,7 @@ static int cpcap_voice_set_dai_fmt(struct snd_soc_da=
i *codec_dai,
 		break;
 	}
=20
-	if (val & BIT(CPCAP_BIT_CLK_INV))
-		val &=3D ~BIT(CPCAP_BIT_CLK_INV);
-	else
-		val |=3D BIT(CPCAP_BIT_CLK_INV);
+	val ^=3D BIT(CPCAP_BIT_CLK_INV);
=20
 	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
 	case SND_SOC_DAIFMT_I2S:

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--zYM0uCDKw75PZbzx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlseThkACgkQMOfwapXb+vLMXQCgkFlHSaHC2Zi4EY8Dt2Wlp/ks
f8UAnjFDZjKdAFiuDkz5nm4Fnjfq8ynO
=6/sK
-----END PGP SIGNATURE-----

--zYM0uCDKw75PZbzx--

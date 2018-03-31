From: Pavel Machek <pavel@ucw.cz>
Subject: call/normal switch was Re: omap4-droid4: voice call
	support was
Date: Sat, 31 Mar 2018 16:55:32 +0200
Message-ID: <20180331145531.GA10404@amd>
References: <20180322234832.o24ut5ahon46mdu4@earth.universe>
 <20180323100930.GA21644@amd>
 <20180323103006.alymgb3ywftb4gek@earth.universe>
 <20180326141638.GB1450@amd>
 <20180326155828.ttnduivadob4iqmd@earth.universe>
 <20180327121441.GH29239@sirena.org.uk>
 <20180327222237.wcx2aqznvdrvbaa5@earth.universe>
 <20180328022910.GM29239@sirena.org.uk>
 <20180328140219.f6667up5evrrafkv@earth.universe>
 <20180329014507.GM5700@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0009823072416069732=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20180329014507.GM5700@atomide.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Tony Lindgren <tony@atomide.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, kernel@collabora.com, Dan Williams <dcbw@redhat.com>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@kernel.org>, Sebastian Reichel <sebastian.reichel@collabora.co.uk>, linux-omap@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
List-Id: linux-omap@vger.kernel.org


--===============0009823072416069732==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qDbXVdCdHGoSgWSk"
Content-Disposition: inline


--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Hmm well I got audio call hacked to work as a proof of concept hack,
> see below. Maybe it can be used to verify some of the assumptions
> above.
>=20
> Then.. To split the work a bit, can you guys maybe try to decode
> the cpcap register values and try to do a proper ASoC driver patch?

This is not proper patch yet, but it should be a step in that
direction...

If someone knows how to express cleanly "active support for modem is
the same as active audio playback", let me know....

Best regards,
								Pavel

diff --git a/sound/soc/codecs/cpcap.c b/sound/soc/codecs/cpcap.c
index 3b53bd0..7aaa4db 100644
--- a/sound/soc/codecs/cpcap.c
+++ b/sound/soc/codecs/cpcap.c
@@ -221,18 +221,18 @@ struct cpcap_reg_info {
 };
=20
 static const struct cpcap_reg_info cpcap_default_regs[] =3D {
-	{ CPCAP_REG_CC, 0xFFFF, 0x0000 },
-	{ CPCAP_REG_CC, 0xFFFF, 0x0000 },
-	{ CPCAP_REG_CDI, 0xBFFF, 0x0000 },
+	{ CPCAP_REG_CC, 0xFFFF, 0x60cf },
+	{ CPCAP_REG_CDI, 0xBFFF, 0xae0a },
 	{ CPCAP_REG_SDAC, 0x0FFF, 0x0000 },
 	{ CPCAP_REG_SDACDI, 0x3FFF, 0x0000 },
-	{ CPCAP_REG_TXI, 0x0FDF, 0x0000 },
-	{ CPCAP_REG_TXMP, 0x0FFF, 0x0400 },
-	{ CPCAP_REG_RXOA, 0x01FF, 0x0000 },
-	{ CPCAP_REG_RXVC, 0xFF3C, 0x0000 },
-	{ CPCAP_REG_RXCOA, 0x07FF, 0x0000 },
-	{ CPCAP_REG_RXSDOA, 0x1FFF, 0x0000 },
+	{ CPCAP_REG_TXI, 0x0FFF, 0x0CC0 },
+	{ CPCAP_REG_TXMP, 0x0FFF, 0x0610 },
+	{ CPCAP_REG_RXOA, 0x01FF, 0x0006 },
+	{ CPCAP_REG_RXVC, 0xFF3C, 0x0B2C },
+	{ CPCAP_REG_RXCOA, 0x07FF, 0x0606 },
+	{ CPCAP_REG_RXSDOA, 0x1FFF, 0x0600 },
 	{ CPCAP_REG_RXEPOA, 0x7FFF, 0x0000 },
+	{ CPCAP_REG_VAUDIOC, 0xFFFF, 0x0025 },
 	{ CPCAP_REG_A2LA, BIT(CPCAP_BIT_A2_FREE_RUN),
 	  BIT(CPCAP_BIT_A2_FREE_RUN) },
 };
@@ -330,6 +330,11 @@ static const char * const cpcap_in_left_mux_texts[] =
=3D {
 	"Off", "Mic 2", "Ext Left"
 };
=20
+static const char * const cpcap_mode_texts[] =3D {
+	"Normal", "Call"
+};
+
+
 /*
  * input muxes use unusual register layout, so that we need to use custom
  * getter/setter methods
@@ -354,6 +359,8 @@ static SOC_ENUM_SINGLE_DECL(cpcap_hs_l_mux_enum, 0, 6, =
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
@@ -442,6 +449,86 @@ static int cpcap_output_mux_put_enum(struct snd_kcontr=
ol *kcontrol,
 	return 0;
 }
=20
+static int mode;
+
+static int cpcap_mode_get_enum(struct snd_kcontrol *kcontrol,
+				     struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec =3D snd_soc_dapm_kcontrol_codec(kcontrol);
+	struct cpcap_audio *cpcap =3D snd_soc_codec_get_drvdata(codec);
+	struct soc_enum *e =3D (struct soc_enum *)kcontrol->private_value;
+	int err;
+
+	ucontrol->value.enumerated.item[0] =3D mode;
+
+	return 0;
+}
+
+static int cpcap_mode_put_enum(struct snd_kcontrol *kcontrol,
+				     struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec =3D snd_soc_dapm_kcontrol_codec(kcontrol);
+	struct cpcap_audio *cpcap =3D snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_dapm_context *dapm =3D
+		snd_soc_dapm_kcontrol_dapm(kcontrol);
+	struct soc_enum *e =3D (struct soc_enum *)kcontrol->private_value;
+	unsigned int muxval =3D ucontrol->value.enumerated.item[0];
+	unsigned int mask =3D BIT(e->shift_l);
+	int err;
+
+	printk("Requested mode %d\n", muxval);
+
+	mode =3D muxval;
+
+	switch (muxval) {
+	case 1:
+
+		err =3D regmap_update_bits(cpcap->regmap, CPCAP_REG_VAUDIOC,
+					 0xffff, 0x0025);	// OK
+		if (err)
+			goto out;
+		err =3D regmap_update_bits(cpcap->regmap, CPCAP_REG_CC,
+					 0xffff, 0x60cf);	// OK
+		if (err)
+			goto out;
+		err =3D regmap_update_bits(cpcap->regmap, CPCAP_REG_CDI,
+					 0xffff, 0xae0a);	// OK
+		if (err)
+			goto out;
+		err =3D regmap_update_bits(cpcap->regmap, CPCAP_REG_TXI,
+					 0xffff, 0x0cc0);
+		if (err)
+			goto out;
+	=09
+		mask =3D 1 << CPCAP_BIT_PGA_CDC_EN | 0x200;
+		err =3D regmap_update_bits(cpcap->regmap, CPCAP_REG_RXCOA,
+				   mask, mask);
+		if (err)
+			printk("error #3\n");
+
+		mask =3D 1 << CPCAP_BIT_A2_LDSP_L_EN | 1 << CPCAP_BIT_A2_LDSP_R_EN;
+		err =3D regmap_update_bits(cpcap->regmap, CPCAP_REG_RXOA,
+				   mask, mask);
+		if (err)
+			printk("error #2\n");
+	=09
+		err =3D regmap_update_bits(cpcap->regmap, 0x814,
+				   0x0400, 0x0400);
+		if (err)
+			printk("error #1\n");
+	=09
+	default:
+		break;
+	}
+
+	// FIXME
+//	snd_soc_dapm_mux_update_power(dapm, kcontrol, muxval, e, NULL);
+
+	return 0;
+out: printk("Something failed\n");
+	return -EINVAL;
+}
+
 static int cpcap_input_right_mux_get_enum(struct snd_kcontrol *kcontrol,
 					  struct snd_ctl_elem_value *ucontrol)
 {
@@ -630,6 +717,11 @@ static const struct snd_kcontrol_new cpcap_earpiece_mu=
x =3D
 	SOC_DAPM_ENUM_EXT("Earpiece", cpcap_earpiece_mux_enum,
 			  cpcap_output_mux_get_enum, cpcap_output_mux_put_enum);
=20
+static const struct snd_kcontrol_new cpcap_mode =3D
+	SOC_DAPM_ENUM_EXT("Mode", cpcap_mode_enum,
+			  cpcap_mode_get_enum, cpcap_mode_put_enum);
+
+
 static const struct snd_kcontrol_new cpcap_hifi_mono_mixer_controls[] =3D {
 	SOC_DAPM_SINGLE("HiFi Mono Playback Switch",
 		CPCAP_REG_RXSDOA, CPCAP_BIT_MONO_DAC1, 1, 0),
@@ -771,6 +863,10 @@ static const struct snd_soc_dapm_widget cpcap_dapm_wid=
gets[] =3D {
 	SND_SOC_DAPM_MUX("EMU Left Playback Route", SND_SOC_NOPM, 0, 0,
 		&cpcap_emu_left_mux),
=20
+
+	SND_SOC_DAPM_MUX("Mode", SND_SOC_NOPM, 0, 0,
+		&cpcap_mode),
+=09
 	/* Output Amplifier */
 	SND_SOC_DAPM_PGA("Earpiece PGA",
 		CPCAP_REG_RXOA, CPCAP_BIT_A1_EAR_EN, 0, NULL, 0),
@@ -816,6 +912,9 @@ static const struct snd_soc_dapm_route intercon[] =3D {
 	{"Microphone 1 PGA", NULL, "VAUDIO"},
 	{"Microphone 2 PGA", NULL, "VAUDIO"},
=20
+	/* FIXME */
+	{"Mode", NULL, "Voice TX"},
+
 	/* Stream -> AIF */
 	{"HiFi RX", NULL, "HiFi Playback"},
 	{"Voice RX", NULL, "Voice Playback"},



--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--qDbXVdCdHGoSgWSk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlq/oWMACgkQMOfwapXb+vKrEgCffQ5gAH4mNGSZevLA0Oc4iEIX
xioAnRYG8nJuNbNQN/W7BSdThzKP7yny
=MoyO
-----END PGP SIGNATURE-----

--qDbXVdCdHGoSgWSk--

--===============0009823072416069732==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0009823072416069732==--

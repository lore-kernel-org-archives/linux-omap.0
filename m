From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: omap4-droid4: voice call support was Re: [PATCHv5,5/5] ARM: dts:
 omap4-droid4: add soundcard
Date: Mon, 26 Mar 2018 17:58:28 +0200
Message-ID: <20180326155828.ttnduivadob4iqmd@earth.universe>
References: <20180223200254.25685-6-sebastian.reichel@collabora.co.uk>
 <20180322204804.GA26871@amd>
 <20180322234832.o24ut5ahon46mdu4@earth.universe>
 <20180323100930.GA21644@amd>
 <20180323103006.alymgb3ywftb4gek@earth.universe>
 <20180326141638.GB1450@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5wulg47r2vfac65g"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180326141638.GB1450@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>, Lee Jones <lee.jones@linaro.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@collabora.com
List-Id: linux-omap@vger.kernel.org


--5wulg47r2vfac65g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Mar 26, 2018 at 04:16:38PM +0200, Pavel Machek wrote:
> Do you have any ideas what needs to be done for voice calls
> support?

Sure.

> I can talk to the modem and start a call.

Doing an AT query is the easy part :)

> Then something like this (untested!) is certainly needed.
> Probably more...

I intentionally left this part out. The CPCAP codec has two DAIs
and not 3+. The code you just added is a hack from Motorola. Their
driver is full of hacks and it's obvious its author(s) did not
fully understand the ASoC APIs.

My understanding is, that we only need to replace the audio-graph-card
driver to something more complex. The VOICE DAI needs to be configured
differently based on the use case:

call:
	* mode=3Di2s
	* freq=3D26000000
	* samprate=3D16000 or samprate=3D8000

bt voice:
	* mode=3D"4 timeslots network"
	* freq=3D26000000
	* samprate=3D8000
	* CPCAP_BIT_MIC2_TIMESLOT1

bt call:
	* mode=3D"4 timeslots network"
	* freq=3D19200000
	* samprate=3D8000
	* CPCAP_BIT_MIC2_TIMESLOT1

"audio-graph-card" is not capable of doing this. I was planning to
try "audio-graph-scu-card" in combination with adding codecs for the
modem and BT to DT. If that does not work we need a Droid 4 specific
soundcard driver.

Either way "audio-graph-card" is not the correct driver for D4. I
added it nevertheless, since it gets audio working for now and there
is no risk of DT breakage. Old *.dtb will continue to work with the
"audio-graph-card" even after we switch to something else.

-- Sebastian

> Thanks,
> 									Pavel
>=20
> diff --git a/sound/soc/codecs/cpcap.c b/sound/soc/codecs/cpcap.c
> index aedb267..7646f68 100644
> --- a/sound/soc/codecs/cpcap.c
> +++ b/sound/soc/codecs/cpcap.c
> @@ -1280,6 +1280,60 @@ static int cpcap_voice_hw_params(struct snd_pcm_su=
bstream *substream,
>  	return 0;
>  }
> =20
> +static int cpcap_incall_hw_params(struct snd_pcm_substream *substream,
> +				 struct snd_pcm_hw_params *params,
> +				 struct snd_soc_dai *dai)
> +{
> +	struct snd_soc_codec *codec =3D dai->codec;
> +	struct device *dev =3D codec->dev;
> +	struct cpcap_audio *cpcap =3D snd_soc_codec_get_drvdata(codec);
> +	static const u16 reg_cdi =3D CPCAP_REG_CDI;
> +	int rate =3D params_rate(params);
> +	int channels =3D params_channels(params);
> +	int direction =3D substream->stream;
> +	u16 val, mask;
> +	int err;
> +
> +	dev_dbg(dev, "Incall setup HW params: rate=3D%d, direction=3D%d, chan=
=3D%d",
> +		rate, direction, channels);
> +
> +	/* codec, 1 in original code is CPCAP_REG_CC
> +	   codec, 2 is CPCAP_REG_CDI
> +	   codec, 5 is CPCAP_REG_TXI */
> +
> +	if (/* cpcap->codec_strm_cnt =3D=3D */ 1) {
> +		/*
> +		if (pdata->voice_type !=3D VOICE_TYPE_QC)
> +			printk("FIXME: Only MDM6600 support is implemented here.\n");
> +		*/
> +
> +		err =3D regmap_update_bits(cpcap->regmap, CPCAP_REG_CDI, 0xffff, 0xAE0=
2);
> +		if (err) printk("cpcap error %d\n", __LINE__);
> +
> +		err =3D regmap_update_bits(cpcap->regmap, CPCAP_REG_CC, 0xffff, 0x6120=
);
> +		if (err) printk("cpcap error %d\n", __LINE__);
> +
> +		err =3D cpcap_set_samprate(cpcap, CPCAP_DAI_VOICE, rate);
> +		printk("Configured stream\n");
> +	}
> +
> +	/* (direction =3D=3D SNDRV_PCM_STREAM_CAPTURE) ?? */
> +	if (substream->stream) { /* up link */
> +		unsigned int set =3D  CPCAP_BIT_AUDIHPF_1 | CPCAP_BIT_AUDIHPF_0;
> +		err =3D regmap_update_bits(cpcap->regmap, CPCAP_REG_CC, set, set);
> +		if (err) printk("cpcap error %d\n", __LINE__);
> +
> +		set =3D CPCAP_BIT_MB_ON1L | CPCAP_BIT_MB_ON1R;
> +		err =3D regmap_update_bits(cpcap->regmap, CPCAP_REG_TXI, set, set);
> +	} else { /* down link */
> +		unsigned int set =3D  CPCAP_BIT_AUDOHPF_1 | CPCAP_BIT_AUDOHPF_0;
> +		err =3D regmap_update_bits(cpcap->regmap, CPCAP_REG_CC, set, set);
> +		if (err) printk("cpcap error %d\n", __LINE__);
> +	}
> +
> +	return err;
> +}
> +
>  static int cpcap_voice_set_dai_sysclk(struct snd_soc_dai *codec_dai, int=
 clk_id,
>  				      unsigned int freq, int dir)
>  {
> @@ -1394,6 +1448,14 @@ static const struct snd_soc_dai_ops cpcap_dai_voic=
e_ops =3D {
>  	.digital_mute	=3D cpcap_voice_set_mute,
>  };
> =20
> +static const struct snd_soc_dai_ops cpcap_dai_incall_ops =3D {
> +	/* FIXME */
> +	.hw_params	=3D cpcap_incall_hw_params,
> +	.set_sysclk	=3D cpcap_voice_set_dai_sysclk,
> +	.set_fmt	=3D cpcap_voice_set_dai_fmt,
> +	.digital_mute	=3D cpcap_voice_set_mute,
> +};
> +
>  static struct snd_soc_dai_driver cpcap_dai[] =3D {
>  {
>  	.id =3D 0,
> @@ -1426,6 +1488,26 @@ static struct snd_soc_dai_driver cpcap_dai[] =3D {
>  	},
>  	.ops =3D &cpcap_dai_voice_ops,
>  },
> +{
> +	.id =3D 2,
> +	.name =3D "cpcap in-call",
> +	.playback =3D {
> +		.stream_name =3D "InCall DL",
> +		.channels_min =3D 1,
> +		.channels_max =3D 2,
> +		.rates =3D SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_16000,
> +		.formats =3D SNDRV_PCM_FMTBIT_S16_LE,
> +	},
> +	.capture =3D {
> +		.stream_name =3D "Capture",
> +		.channels_min =3D 1,
> +		.channels_max =3D 2,
> +		.rates =3D SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_16000,
> +		.formats =3D SNDRV_PCM_FMTBIT_S16_LE,
> +	},
> +	.ops =3D &cpcap_dai_incall_ops,
> +},
> +/* FIXME: this misses bt-call, cpcap bt, BPvoice, FM */
>  };
> =20
>  static int cpcap_dai_mux(struct cpcap_audio *cpcap, bool swap_dai_config=
uration)
>=20
>=20
>=20
>=20
>=20
>=20
> --=20
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/b=
log.html



--5wulg47r2vfac65g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlq5GKEACgkQ2O7X88g7
+poUQQ/9H5ot8ZvaaQSYVSfppYGp2KXCjmHw80G1ZphKz6iemTNAliFqiLMo4uJx
XKjaIaIUyBrs/CQYQ6WpeTFKygF0sp1FzxcSlL4KODicom7QCJVYRmV9ZN/111y0
hvC6Ay83QD5VrEsti5kz85bwb+go/XA/s5XoJoOBl9SFOew3iXbMvgMNc4nqw8XT
vUfT2rcGUP44xZf/Ov/bl7gzTx7namk81TdCCA1lC9IC9ryyLnWEBV09Vn7pvr+B
wT8ZxTtNZNJQIb5avTsVhyy39IydETLHlyhix+ceZ6CpCgS4MFhJmuDnWmWqxpd0
5bjdA/okqj78M8f+oA5Fj3ERA2nHhYjSkkRgHrVC9+zxBXEHyMQ6yZSzqGH0KtVt
IrOav7awXTndT63a+VGMB8syDPI8tFIOqOz6/EeXA6nOu5chWfEuWgaL7KIL9744
X56m2gWbgfxXjMuV3LXm4aWb4hIxCkpIuHIKVfqi2EKIc9n/HEsrgjtgJQ37XhfW
7I+P9cBrR8C6a853YX0DWsIpJRQqAI2zhO+KGn/w9DIfLwJ1Fdgmfd+cvF9Q5bfs
lqnfRIHVtS6hQXDX5SX9r1bwML8gE/b91JrWMOoc4DWFtNDclfgY3PJBhsTmzZA4
qUqOrBwMN7xC7WPV0ojU044WsPhOAVs9AmknBl5JvyZ/mZ0a1qA=
=6Xq4
-----END PGP SIGNATURE-----

--5wulg47r2vfac65g--

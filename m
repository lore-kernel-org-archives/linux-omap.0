From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: omap4-droid4: voice call support was Re: [PATCHv5,5/5] ARM: dts:
 omap4-droid4: add soundcard
Date: Thu, 29 Mar 2018 15:36:13 +0200
Message-ID: <20180329133613.khldv72w3zj63vsk@earth.universe>
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
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2ibx24c7rwzjej7z"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180329014507.GM5700@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Mark Brown <broonie@kernel.org>, Pavel Machek <pavel@ucw.cz>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, Lee Jones <lee.jones@linaro.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@collabora.com, Dan Williams <dcbw@redhat.com>
List-Id: linux-omap@vger.kernel.org


--2ibx24c7rwzjej7z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Mar 28, 2018 at 06:45:07PM -0700, Tony Lindgren wrote:
> Hi,
>=20
> * Sebastian Reichel <sebastian.reichel@collabora.co.uk> [180328 14:03]:
> > Hi,
> >=20
> > On Wed, Mar 28, 2018 at 10:29:10AM +0800, Mark Brown wrote:
> > > On Wed, Mar 28, 2018 at 12:22:37AM +0200, Sebastian Reichel wrote:
> > > > On Tue, Mar 27, 2018 at 08:14:41PM +0800, Mark Brown wrote:
> > >=20
> > > > > No, this is exactly the sort of use case with multiple DAIs that =
the
> > > > > graph card is intended to enable over the old simple-card.
> > >=20
> > > > +----------+         +-------------+
> > > > | OMAP4    |         | CPCAP       |
> > > > |          |         |             |
> > > > | [McBSP2] | <-----> | [HiFi DAI]  |
> > > > |          |         |             |
> > > > | [McBSP3] | <--+--> | [Voice DAI] |
> > > > |          |    |    |             |
> > > > +----------+    |    +-------------+
> > > >                 |
> > > > +----------+    |    +-------------+
> > > > | MDM6600  |    |    | WL1285      |
> > > > |          |    |    |             |
> > > > |    [DAI] | <--+--> | [DAI]       |
> > > > |          |         |             |
> > > > +----------+         +-------------+
> > >=20
> > > > Legend:
> > > >     OMAP4   =3D SoC running Linux
> > > >     CPCAP   =3D Audio codec
> > > >     MDM6600 =3D Baseband
> > > >     WL1285  =3D Bluetooth
> > >=20
> > > > Re-reading the audio-graph-card binding document I still don't see
> > > > how the network (OMAP.McBSP3, CPCAP.Voice, MDM6600, WL1285) is
> > > > supposed to look like. It seems to expect point-to-point DAI
> > > > connections.
> > >=20
> > > Ugh, a TDM mux?
> >=20
> > Yes, at least that's how I understood Motorola's code.
>=20
> Hmm is there some active component doing the muxing then?
> Maybe the "AT+CMUT=3D0" part below?

I don't think, that there is a special hardware mux. I think each
device is configured to use a proper timeslot and/or is being used
exclusively.

> > > That's really unusual and not particularly supported yet, you'd
> > > need to extend the graph card to do it.  It's where things should
> > > end up for a generic card though.
> >=20
> > Motorola's driver provided the following modes:
> >=20
> > OMAP4 <-> CPCAP      (voice recording)
> > MDM6600 <-> CPCAP    (voice call, CPU not involved)
> > OMAP4 <-> WL1285     (bluetooth HFP/HSP)
> > MDM6600 <-> WL1285   (bluetooth voice call)
> >=20
> > In case of the last two variants, the bus clock is provided by
> > CPCAP, so it needs to be enabled for any audio stream. I suppose
> > the codec <-> codec as part of TDM is out of scope for the graph
> > card and we need a Droid 4 specific card driver?
>=20
> Hmm well I got audio call hacked to work as a proof of concept hack,
> see below. Maybe it can be used to verify some of the assumptions
> above.

Your proof of concept verifies the assumption, that the modem is
connected to the CPCAP voice DAI. This patchset is a proof, that the
voice DAI is connected to OMAP. So we can tell for sure, that this
is not a common direct DAI-to-DAI connection.

> Then.. To split the work a bit, can you guys maybe try to decode
> the cpcap register values and try to do a proper ASoC driver patch?
>
> Meanwhile, I can try to make voice calls more reproducable with
> qmi or MM for example instead of just n_gsm.. And then I'll try
> to fix my n_gsm pile of hacks for posting..
>=20
> Cheers,
>=20
> Tony
>=20
> 8< --------------------------
> From tony Mon Sep 17 00:00:00 2001
> From: Tony Lindgren <tony@atomide.com>
> Date: Wed, 28 Mar 2018 08:29:38 -0700
> Subject: [PATCH] NOT FOR MERGING: Quick hack for droid 4 mdm6600 voice
>  call
>=20
> Here's quick hack to allow making a voice call on mdm6600 based on
> diffing the cpcap registers in Android. The patch just keeps overwriting
> the cpcap values every second so it's nowhere near usable for merging,
> just a test patch.
>=20
> Looks like the cpcap register changes during a speaker phone audio call a=
re:
>=20
> @@ -510,17 +510,17 @@
>  07f4: 0000
>  07f8: 0000
>  07fc: 0000
> -0800: 0065
> -0804: 0000
> -0808: 0040
> +0800: 0025     # CPCAP_REG_VAUDIOC     VAUDIO Control

enable vaudio (obviously required :))

> +0804: 60cf     # CPCAP_REG_CC          Codec Control, moto cpcap.c:1337 =
sets 0x0093?

0x6000 =3D> clkfreq=3D19200000

The following bits are automatically set via DAPM by cpcap codec,
once it is used:

0x00c0 =3D> "ADC Left" + "DAC Voice"
0x000f =3D> "Highpass Filter TX" + "Highpass Filter RX"

> +0808: ae0a     # CPCAP_REG_CDI         Codec Digital Interface

0xa000 =3D> enable PLL & use clock 1

This should be used by default for VOICE DAI.

0x0e00 =3D> "Voice DAI Clock"=3D1 (handled by DAPM) , mode=3DI2S
0x000a =3D> CPCAP_BIT_CLK_INV | CPCAP_BIT_MIC1_RX_TIMESLOT0

>  080c: 0000
>  0810: 0004
> -0814: 0804
> -0818: 079c
> -081c: 0000
> -0820: 0924
> -0824: 0000
> -0828: 0000
> +0814: 0cc0     # CPCAP_REG_TXI         TX Inputs, moto cpcap.c:1340 sets=
 0x0CC6?
> +0818: 0610     # CPCAP_REG_TXMP        TX MIC PGA's, moto cpcap.c:1343 s=
ets 0x0273?
> +081c: 0006     # CPCAP_REG_RXOA        RX Output Amplifiers
> +0820: 0b2c     # CPCAP_REG_RXVC        RX Volume Control
> +0824: 0606     # CPCAP_REG_RXCOA       RX Codec to Output Amps
> +0828: 0600     # CPCAP_REG_RXSDOA      RX Stereo DAC to Output Amps

This configures the loudspeaker, mics and volume and enables the
required clocks/DACs/... This is already covered by the cpcap codec
driver. You just need to configure everything correctly in
alsamixer.

>  082c: 0400
>  0830: 0000
>  0834: 0030
>=20
> I wonder if mdm6600 is the i2s master during the voice call?

I think cpcap is always the clock and frame master, but I think
mdm6600 is the remote side and OMAP is not involved at all.

-- Sebastian

> Then using the n_gsm ts 27.010 uart mux, I dial:
>=20
> ./ngsm-rw 1 "AT+CFUN=3D1"		# connect to network
> U0001+CFUN:OK
> ./ngsm-rw 2 "AT+CMUT=3D0"		# unmute speaker over ch2, do this over qmi?
> U0001+CMUT:OK
> ./ngsm-rw 1 "ATD#123"		# dial number
> U0001D:OK
>=20
> And I do hear a voice talking over the speakerphone :) Sorry have not tes=
ted the
> mic yet..
>=20
> FYI, the ngsm-rw script I use is just:
>=20
> #!/bin/sh
>=20
> if [ "${1}" =3D=3D "" ]; then
>         echo "Usage: $0 port command"
>         exit 1
> fi
>=20
> port=3D${1}
> command=3D${2}
>=20
> exec 3<>/dev/gsmtty${port}
> printf "U0001%s\r\0" ${command} >&3
> read result <&3
> exec 3>&-
> exec 3<&-
>=20
> echo ${result}
>=20
> My n_gsm patches are not quite ready yet sorry.. But meanwhile hopefully =
this
> can be somehow also done using qmi. At least "AT+CMUT=3D0" fails over tty=
USB4.
> ---
>  sound/soc/codecs/cpcap.c | 70 ++++++++++++++++++++++++++++++++++++++++++=
+++++-
>  1 file changed, 69 insertions(+), 1 deletion(-)
>=20
> diff --git a/sound/soc/codecs/cpcap.c b/sound/soc/codecs/cpcap.c
> --- a/sound/soc/codecs/cpcap.c
> +++ b/sound/soc/codecs/cpcap.c
> @@ -251,6 +251,8 @@ struct cpcap_audio {
>  	int codec_clk_id;
>  	int codec_freq;
>  	int codec_format;
> +
> +	struct delayed_work work;
>  };
> =20
>  static int cpcap_st_workaround(struct snd_soc_dapm_widget *w,
> @@ -1500,6 +1502,57 @@ static int cpcap_audio_reset(struct snd_soc_compon=
ent *component,
>  	return 0;
>  }
> =20
> +static void cpcap_soc_work(struct work_struct *work)
> +{
> +	struct cpcap_audio *cpcap =3D container_of(work,
> +						 struct cpcap_audio,
> +						 work.work);
> +	struct device *dev =3D cpcap->component->dev;
> +	int error;
> +
> +	dev_info(dev, "Somebody do a proper driver please %s\n", __func__);
> +
> +	error =3D regmap_update_bits(cpcap->regmap, CPCAP_REG_VAUDIOC,
> +				   0xffff, 0x0025);
> +	if (error)
> +		goto out;
> +	error =3D regmap_update_bits(cpcap->regmap, CPCAP_REG_CC,
> +				   0xffff, 0x60cf);
> +	if (error)
> +		goto out;
> +	error =3D regmap_update_bits(cpcap->regmap, CPCAP_REG_CDI,
> +				   0xffff, 0xae0a);
> +	if (error)
> +		goto out;
> +	error =3D regmap_update_bits(cpcap->regmap, CPCAP_REG_TXI,
> +				   0xffff, 0x0cc0);
> +	if (error)
> +		goto out;
> +	error =3D regmap_update_bits(cpcap->regmap, CPCAP_REG_TXMP,
> +				   0xffff, 0x0610);
> +	if (error)
> +		goto out;
> +	error =3D regmap_update_bits(cpcap->regmap, CPCAP_REG_RXOA,
> +				   0xffff, 0x0006);
> +	if (error)
> +		goto out;
> +	error =3D regmap_update_bits(cpcap->regmap, CPCAP_REG_RXVC,
> +				   0xffff, 0x0b2c);
> +	if (error)
> +		goto out;
> +	error =3D regmap_update_bits(cpcap->regmap, CPCAP_REG_RXCOA,
> +				   0xffff, 0x0606);
> +	if (error)
> +		goto out;
> +	error =3D regmap_update_bits(cpcap->regmap, CPCAP_REG_RXSDOA,
> +				   0xffff, 0x0600);
> +	if (error)
> +		goto out;
> +
> +out:
> +	schedule_delayed_work(&cpcap->work, msecs_to_jiffies(1000));
> +}
> +
>  static int cpcap_soc_probe(struct snd_soc_component *component)
>  {
>  	struct cpcap_audio *cpcap;
> @@ -1520,11 +1573,26 @@ static int cpcap_soc_probe(struct snd_soc_compone=
nt *component)
>  	if (err)
>  		return err;
> =20
> -	return cpcap_audio_reset(component, false);
> +	err =3D cpcap_audio_reset(component, false);
> +	if (err)
> +		return err;
> +
> +	INIT_DELAYED_WORK(&cpcap->work, cpcap_soc_work);
> +	schedule_delayed_work(&cpcap->work, msecs_to_jiffies(1000));
> +
> +	return 0;
> +}
> +
> +static void cpcap_soc_remove(struct snd_soc_component *component)
> +{
> +	struct cpcap_audio *cpcap =3D snd_soc_component_get_drvdata(component);
> +
> +	cancel_delayed_work_sync(&cpcap->work);
>  }
> =20
>  static struct snd_soc_component_driver soc_codec_dev_cpcap =3D {
>  	.probe			=3D cpcap_soc_probe,
> +	.remove			=3D cpcap_soc_remove,
>  	.controls		=3D cpcap_snd_controls,
>  	.num_controls		=3D ARRAY_SIZE(cpcap_snd_controls),
>  	.dapm_widgets		=3D cpcap_dapm_widgets,
> --=20
> 2.16.3

--2ibx24c7rwzjej7z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlq868oACgkQ2O7X88g7
+pr93A/9GmCEQPjDT9Q/JFcCPBGtEgQAqJWEjdh05rDPKVdgJj7uAibpjgdD+UQg
H34Rf3yiadRcn+A8Rg8uHL8rWkQg+Ng1Xhg9JKuoeBxhxn70rwSpM2r5O0IIfPGh
JFr+1kzBoJecIyW563ZWU/Kpi/K3vu4UOfgRBIJACnIgZ4HWxbDLtiLAr6dob0Cu
PG1YCybjMx5e3IwZnfyJFegoQjG+/tSM88k3oL+btK5elIEOGf45QsK5LQ0QMh41
w96SLIVsPWB8Q/VkGwHVz6G6bSp1s13NJ0uDYKMz5zZ6xfOCET59jjCBvkgUhfIv
hukN4hGlgIpyG9bP3A4chGW0pw6Y6suYzwWQ/jHLkA4JVclm1vL+m6TlwDGyKnmx
GjAeEs221oZIQ36sS4r8IxOeHd2H45CF1xY/S+NYVAd1P/2rQp1ZbDRtti1YzBU6
7bEmflBD6kpjdbkohDTKB2BxPoJdpUuJIWzaBO8fgwIbzlUMUxjnc8RorBtUyA/N
mbocnKxLgXl9mKhudt3Yt6OQWzKxYNKmVvRcb3Pn8VCPflfNnajyjgNfb679I9Mr
nA92kfQ3wRV8LPFmoMHAmKdOTTVVQLBcC++qpitscRsgBFnd9vBjj+S+B8WfBBka
eLcOqGHsQox+GlunKJyLVfvdfYv2Xt1WVfgaCS4KH3tU791xU7w=
=6Hf+
-----END PGP SIGNATURE-----

--2ibx24c7rwzjej7z--

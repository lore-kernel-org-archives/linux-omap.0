From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 1/4] ASoC: tpa6130a2: Register component
Date: Sun, 19 Jun 2016 00:28:36 +0200
Message-ID: <20160618222836.GC5510@earth>
References: <cover.1466218805.git.helen.koike@collabora.co.uk>
 <ab4a503a44da58b65c3d56bf86e8e2949a4d3cab.1466218805.git.helen.koike@collabora.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="DSayHWYpDlRfCAAQ"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <ab4a503a44da58b65c3d56bf86e8e2949a4d3cab.1466218805.git.helen.koike@collabora.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Helen Koike <helen.koike@collabora.co.uk>
Cc: lgirdwood@gmail.com, broonie@kernel.org, peter.ujfalusi@ti.com, jarkko.nikula@bitmer.com, lars@metafoo.de, k.kozlowski@samsung.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, perex@perex.cz, tiwai@suse.com
List-Id: linux-omap@vger.kernel.org


--DSayHWYpDlRfCAAQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Helen,

On Sat, Jun 18, 2016 at 12:26:28AM -0300, Helen Koike wrote:
> Add tpa6130a2 controls by the component API and update rx51 accordingly
>=20
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> [koike: port for upstream]
> Signed-off-by: Helen Koike <helen.koike@collabora.co.uk>
> ---
>  sound/soc/codecs/tpa6130a2.c | 26 +++++++++++++-------------
>  sound/soc/codecs/tpa6130a2.h |  1 -
>  sound/soc/omap/rx51.c        | 23 ++++++++++++-----------
>  3 files changed, 25 insertions(+), 25 deletions(-)
>=20
> diff --git a/sound/soc/codecs/tpa6130a2.c b/sound/soc/codecs/tpa6130a2.c
> index 11d85c5..f700d92 100644
> --- a/sound/soc/codecs/tpa6130a2.c
> +++ b/sound/soc/codecs/tpa6130a2.c
> @@ -348,23 +348,22 @@ int tpa6130a2_stereo_enable(struct snd_soc_codec *c=
odec, int enable)
>  }
>  EXPORT_SYMBOL_GPL(tpa6130a2_stereo_enable);
> =20
> -int tpa6130a2_add_controls(struct snd_soc_codec *codec)
> +static int tpa6130a2_component_probe(struct snd_soc_component *component)
>  {
> -	struct	tpa6130a2_data *data;
> -
> -	if (tpa6130a2_client =3D=3D NULL)
> -		return -ENODEV;
> -
> -	data =3D i2c_get_clientdata(tpa6130a2_client);
> +	struct tpa6130a2_data *data =3D snd_soc_component_get_drvdata(component=
);
> =20
>  	if (data->id =3D=3D TPA6140A2)
> -		return snd_soc_add_codec_controls(codec, tpa6140a2_controls,
> -						ARRAY_SIZE(tpa6140a2_controls));
> +		return snd_soc_add_component_controls(component,
> +			tpa6140a2_controls, ARRAY_SIZE(tpa6140a2_controls));
>  	else
> -		return snd_soc_add_codec_controls(codec, tpa6130a2_controls,
> -						ARRAY_SIZE(tpa6130a2_controls));
> +		return snd_soc_add_component_controls(component,
> +			tpa6130a2_controls, ARRAY_SIZE(tpa6130a2_controls));
>  }
> -EXPORT_SYMBOL_GPL(tpa6130a2_add_controls);
> +
> +struct snd_soc_component_driver tpa6130a2_component_driver =3D {
> +	.name =3D "tpa6130a2",
> +	.probe =3D tpa6130a2_component_probe,
> +};
> =20
>  static int tpa6130a2_probe(struct i2c_client *client,
>  			   const struct i2c_device_id *id)
> @@ -451,7 +450,8 @@ static int tpa6130a2_probe(struct i2c_client *client,
>  	if (ret !=3D 0)
>  		goto err_gpio;
> =20
> -	return 0;
> +	return devm_snd_soc_register_component(&client->dev,
> +			&tpa6130a2_component_driver, NULL, 0);
> =20
>  err_gpio:
>  	tpa6130a2_client =3D NULL;
> diff --git a/sound/soc/codecs/tpa6130a2.h b/sound/soc/codecs/tpa6130a2.h
> index 4174440..78ee723 100644
> --- a/sound/soc/codecs/tpa6130a2.h
> +++ b/sound/soc/codecs/tpa6130a2.h
> @@ -56,7 +56,6 @@
>  /* TPA6130A2_REG_VERSION (0x04) */
>  #define TPA6130A2_VERSION_MASK		(0x0f)
> =20
> -extern int tpa6130a2_add_controls(struct snd_soc_codec *codec);
>  extern int tpa6130a2_stereo_enable(struct snd_soc_codec *codec, int enab=
le);
> =20
>  #endif /* __TPA6130A2_H__ */
> diff --git a/sound/soc/omap/rx51.c b/sound/soc/omap/rx51.c
> index 5494924..b59cf89 100644
> --- a/sound/soc/omap/rx51.c
> +++ b/sound/soc/omap/rx51.c
> @@ -286,16 +286,10 @@ static const struct snd_kcontrol_new aic34_rx51_con=
trols[] =3D {
> =20
>  static int rx51_aic34_init(struct snd_soc_pcm_runtime *rtd)
>  {
> -	struct snd_soc_codec *codec =3D rtd->codec;
>  	struct snd_soc_card *card =3D rtd->card;
>  	struct rx51_audio_pdata *pdata =3D snd_soc_card_get_drvdata(card);
>  	int err;
> =20
> -	err =3D tpa6130a2_add_controls(codec);
> -	if (err < 0) {
> -		dev_err(card->dev, "Failed to add TPA6130A2 controls\n");
> -		return err;
> -	}
>  	snd_soc_limit_volume(card, "TPA6130A2 Headphone Playback Volume", 42);
> =20
>  	err =3D omap_mcbsp_st_add_controls(rtd, 2);
> @@ -357,6 +351,10 @@ static struct snd_soc_aux_dev rx51_aux_dev[] =3D {
>  		.name =3D "TLV320AIC34b",
>  		.codec_name =3D "tlv320aic3x-codec.2-0019",
>  	},
> +	{
> +		.name =3D "TPA61320A2",
> +		.codec_name =3D "tpa6130a2.2-0060",
> +	},
>  };
> =20
>  static struct snd_soc_codec_conf rx51_codec_conf[] =3D {
> @@ -364,6 +362,10 @@ static struct snd_soc_codec_conf rx51_codec_conf[] =
=3D {
>  		.dev_name =3D "tlv320aic3x-codec.2-0019",
>  		.name_prefix =3D "b",
>  	},
> +	{
> +		.dev_name =3D "tpa6130a2.2-0060",
> +		.name_prefix =3D "TPA6130A2",

This results in the control being named "TPA6130A2 TPA6130A2
Headphone Playback Volume", which is too long, so its shortened to
"TPA6130A2 TPA6130A2 Headphone Playback Volu".  That in turn results
in incorrect detection making it playback + capture and the
snd_soc_limit_volume() from above does not work.

I suggest to keep the name_prefix here and remove it in the codec
instead, so that other boards (esp. those with more than one TPA)
can choose another prefix.

> +	},
>  };
> =20
>  /* Audio card */
> @@ -435,11 +437,10 @@ static int rx51_soc_probe(struct platform_device *p=
dev)
>  			dev_err(&pdev->dev, "Headphone amplifier node is not provided\n");
>  			return -EINVAL;
>  		}
> -
> -		/* TODO: tpa6130a2a driver supports only a single instance, so
> -		 * this driver ignores the headphone-amplifier node for now.
> -		 * It's already mandatory in the DT binding to be future proof.
> -		 */
> +		rx51_aux_dev[1].codec_name =3D NULL;
> +		rx51_aux_dev[1].codec_of_node =3D dai_node;
> +		rx51_codec_conf[1].dev_name =3D NULL;
> +		rx51_codec_conf[1].of_node =3D dai_node;
>  	}
> =20
>  	pdata =3D devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);

If you fix the double prefix the patch is

Tested-By: Sebastian Reichel <sre@kernel.org>
Reviewed-By: Sebastian Reichel <sre@kernel.org>

-- Sebastian

--DSayHWYpDlRfCAAQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJXZcsSAAoJENju1/PIO/qaqM8P/iN7rA3S5cvk9elvwvDyA8K7
u2I3roQLojEljKjskwhXXAy7xOaXV47BiZjxaYLlLg37SV1ShQ0pe4wia+ljMJqy
SP06d4XsHJdPH+vn1F7EigR5iKJgrwjvhHGo1tgXHZSrwiqLmOhtvBL7fcjQJu+f
gI/Ll/SvE5LjMVjveQfcE76/NOQYZM5ZUkAASL3AKncXqseC7UqnKYl87mSh/WVQ
HTjSuNj4XnYoWWUkATtPsUW5AAfxDMrJ7COEBUHvdW87BgM/kmrfQn4kgxK2zeaA
Bs+rt0k+BO33QfT1EfTOOrnTcNuL1lT19aOV5PftWYc8cEA1BfOd2G5Oua/qpLgj
mMF5zDIdeAlCnDgWbsq/87vjw2EI4ZhSTEeM01eBV8lugiaVFxw4zr9r7h7tXVn/
24ckOtj+T1tiqXy1t+1g6twRI6j5MxPFvCbnPrpEhkZV3PEEhxpfKKNY3FQ2jNMw
26G2PD5vzylZlLvqg/thWtF4ICwwUC2zbyP88JEt24qgEOjAqkfr/W7/TUhlw+qK
UVR64z7Xds+i3SiTY/YbhNwPiPKnQFG+8oJgjIdQJ1asOpuwsroRsHGox57jbjxe
1jnl8imX0QyUMX/Jk4UXixOkSE+zQLHydM3BVrrjovhiAjtmKS2oXIDWv2zhbD8h
BeNWNizWnBW6lldk9Lgs
=5TEW
-----END PGP SIGNATURE-----

--DSayHWYpDlRfCAAQ--

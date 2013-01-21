From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 1/2] ASoC: omap: rx51: Use snd_soc_register_card and add
 module alias for autoloading driver
Date: Mon, 21 Jan 2013 09:47:20 +0100
Message-ID: <50FD0098.4070407@ti.com>
References: <1358651070-30029-1-git-send-email-pali.rohar@gmail.com> <1358651070-30029-2-git-send-email-pali.rohar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1358651070-30029-2-git-send-email-pali.rohar@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?B?UGFsaSBSb2jDoXI=?= <pali.rohar@gmail.com>
Cc: Jarkko Nikula <jarkko.nikula@bitmer.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

On 01/20/2013 04:04 AM, Pali Roh=C3=A1r wrote:
> Signed-off-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>

This is really welcome.
It would be even better if we would have commit message...
Also for ASoC patches please CC alsa-devel and the maintainers so they =
will
also have a chance to review.

There are still couple of things which can improve the rx51 machine dri=
ver:
- Switch to use devm_gpio_request_one() so we can remove the failure ha=
ndling.
- I would introduce platform data for this driver to pass the GPIO numb=
ers.
This is especially important for the RX51_SPEAKER_AMP_TWL_GPIO since it=
 is in
twl4030 and the GPIO range now allocated dynamically so the (192 + 7) m=
ight
not be valid anymore.

--=20
P=C3=A9ter

> ---
>  sound/soc/omap/rx51.c |   50 +++++++++++++++++++++++++++++----------=
----------
>  1 file changed, 30 insertions(+), 20 deletions(-)
>=20
> diff --git a/sound/soc/omap/rx51.c b/sound/soc/omap/rx51.c
> index d921ddb..82e3aae 100644
> --- a/sound/soc/omap/rx51.c
> +++ b/sound/soc/omap/rx51.c
> @@ -391,10 +391,9 @@ static struct snd_soc_card rx51_sound_card =3D {
>  	.num_configs =3D ARRAY_SIZE(rx51_codec_conf),
>  };
> =20
> -static struct platform_device *rx51_snd_device;
> -
> -static int __init rx51_soc_init(void)
> +static int rx51_soc_probe(struct platform_device *pdev)
>  {
> +	struct snd_soc_card *card =3D &rx51_sound_card;
>  	int err;
> =20
>  	if (!machine_is_nokia_rx51())
> @@ -409,22 +408,18 @@ static int __init rx51_soc_init(void)
>  	if (err)
>  		goto err_gpio_eci_sw;
> =20
> -	rx51_snd_device =3D platform_device_alloc("soc-audio", -1);
> -	if (!rx51_snd_device) {
> -		err =3D -ENOMEM;
> -		goto err1;
> -	}
> -
> -	platform_set_drvdata(rx51_snd_device, &rx51_sound_card);
> +	card->dev =3D &pdev->dev;
> =20
> -	err =3D platform_device_add(rx51_snd_device);
> -	if (err)
> -		goto err2;
> +	err =3D snd_soc_register_card(card);
> +	if (err) {
> +		dev_err(&pdev->dev, "snd_soc_register_card failed (%d)\n", err);
> +		goto err_snd;
> +	}
> =20
>  	return 0;
> -err2:
> -	platform_device_put(rx51_snd_device);
> -err1:
> +
> +err_snd:
> +	card->dev =3D NULL;
>  	gpio_free(RX51_ECI_SW_GPIO);
>  err_gpio_eci_sw:
>  	gpio_free(RX51_TVOUT_SEL_GPIO);
> @@ -433,19 +428,34 @@ err_gpio_tvout_sel:
>  	return err;
>  }
> =20
> -static void __exit rx51_soc_exit(void)
> +static int rx51_soc_remove(struct platform_device *pdev)
>  {
> +	struct snd_soc_card *card =3D platform_get_drvdata(pdev);
> +
>  	snd_soc_jack_free_gpios(&rx51_av_jack, ARRAY_SIZE(rx51_av_jack_gpio=
s),
>  				rx51_av_jack_gpios);
> =20
> -	platform_device_unregister(rx51_snd_device);
> +	snd_soc_unregister_card(card);
> +	card->dev =3D NULL;
> +
>  	gpio_free(RX51_ECI_SW_GPIO);
>  	gpio_free(RX51_TVOUT_SEL_GPIO);
> +
> +	return 0;
>  }
> =20
> -module_init(rx51_soc_init);
> -module_exit(rx51_soc_exit);
> +static struct platform_driver rx51_soc_driver =3D {
> +	.driver =3D {
> +		.name =3D "rx51-audio",
> +		.owner =3D THIS_MODULE,
> +	},
> +	.probe =3D rx51_soc_probe,
> +	.remove =3D rx51_soc_remove,
> +};
> +
> +module_platform_driver(rx51_soc_driver);
> =20
>  MODULE_AUTHOR("Nokia Corporation");
>  MODULE_DESCRIPTION("ALSA SoC Nokia RX-51");
>  MODULE_LICENSE("GPL");
> +MODULE_ALIAS("platform:rx51-audio");
>=20

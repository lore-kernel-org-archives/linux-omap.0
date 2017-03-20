From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] ASoC: omap: constify snd_soc_ops structures
Date: Mon, 20 Mar 2017 01:53:26 +0100
Message-ID: <20170320005326.7gkckcy4rbgqij3h@earth>
References: <1489845851-25364-1-git-send-email-bhumirks@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ytm2ahlf4y2rom4v"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1489845851-25364-1-git-send-email-bhumirks@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bhumika Goyal <bhumirks@gmail.com>
Cc: julia.lawall@lip6.fr, peter.ujfalusi@ti.com, jarkko.nikula@bitmer.com, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--ytm2ahlf4y2rom4v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Mar 18, 2017 at 07:34:11PM +0530, Bhumika Goyal wrote:
> Declare snd_soc_ops structures as const as they are only stored
> in the ops field of a snd_soc_dai_link structure. This field is
> of type const, so snd_soc_ops structures having this property
> can be made const too.
>=20
> Cross compiled the .o files for arm architecture.
>=20
> Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>

I actually noticed this while working on Droid 4's sound support and
added this to my TODO list - stroking it off again now :)

Reviewed-by: Sebastian Reichel <sre@kernel.org>

>  sound/soc/omap/am3517evm.c        | 2 +-
>  sound/soc/omap/n810.c             | 2 +-
>  sound/soc/omap/omap-abe-twl6040.c | 2 +-
>  sound/soc/omap/omap-twl4030.c     | 2 +-
>  sound/soc/omap/omap3pandora.c     | 2 +-
>  sound/soc/omap/osk5912.c          | 2 +-
>  sound/soc/omap/rx51.c             | 2 +-
>  7 files changed, 7 insertions(+), 7 deletions(-)
>=20
> diff --git a/sound/soc/omap/am3517evm.c b/sound/soc/omap/am3517evm.c
> index 25a33e9..d565102 100644
> --- a/sound/soc/omap/am3517evm.c
> +++ b/sound/soc/omap/am3517evm.c
> @@ -49,7 +49,7 @@ static int am3517evm_hw_params(struct snd_pcm_substream=
 *substream,
>  	return ret;
>  }
> =20
> -static struct snd_soc_ops am3517evm_ops =3D {
> +static const struct snd_soc_ops am3517evm_ops =3D {
>  	.hw_params =3D am3517evm_hw_params,
>  };
> =20
> diff --git a/sound/soc/omap/n810.c b/sound/soc/omap/n810.c
> index fdecb70..71e5f31 100644
> --- a/sound/soc/omap/n810.c
> +++ b/sound/soc/omap/n810.c
> @@ -124,7 +124,7 @@ static int n810_hw_params(struct snd_pcm_substream *s=
ubstream,
>  	return err;
>  }
> =20
> -static struct snd_soc_ops n810_ops =3D {
> +static const struct snd_soc_ops n810_ops =3D {
>  	.startup =3D n810_startup,
>  	.hw_params =3D n810_hw_params,
>  	.shutdown =3D n810_shutdown,
> diff --git a/sound/soc/omap/omap-abe-twl6040.c b/sound/soc/omap/omap-abe-=
twl6040.c
> index 89fe95e..614b18d 100644
> --- a/sound/soc/omap/omap-abe-twl6040.c
> +++ b/sound/soc/omap/omap-abe-twl6040.c
> @@ -70,7 +70,7 @@ static int omap_abe_hw_params(struct snd_pcm_substream =
*substream,
>  	return ret;
>  }
> =20
> -static struct snd_soc_ops omap_abe_ops =3D {
> +static const struct snd_soc_ops omap_abe_ops =3D {
>  	.hw_params =3D omap_abe_hw_params,
>  };
> =20
> diff --git a/sound/soc/omap/omap-twl4030.c b/sound/soc/omap/omap-twl4030.c
> index 7431314..a24b0de 100644
> --- a/sound/soc/omap/omap-twl4030.c
> +++ b/sound/soc/omap/omap-twl4030.c
> @@ -73,7 +73,7 @@ static int omap_twl4030_hw_params(struct snd_pcm_substr=
eam *substream,
>  	return snd_soc_runtime_set_dai_fmt(rtd, fmt);
>  }
> =20
> -static struct snd_soc_ops omap_twl4030_ops =3D {
> +static const struct snd_soc_ops omap_twl4030_ops =3D {
>  	.hw_params =3D omap_twl4030_hw_params,
>  };
> =20
> diff --git a/sound/soc/omap/omap3pandora.c b/sound/soc/omap/omap3pandora.c
> index 732e749..4e3de71 100644
> --- a/sound/soc/omap/omap3pandora.c
> +++ b/sound/soc/omap/omap3pandora.c
> @@ -184,7 +184,7 @@ static int omap3pandora_in_init(struct snd_soc_pcm_ru=
ntime *rtd)
>  	return 0;
>  }
> =20
> -static struct snd_soc_ops omap3pandora_ops =3D {
> +static const struct snd_soc_ops omap3pandora_ops =3D {
>  	.hw_params =3D omap3pandora_hw_params,
>  };
> =20
> diff --git a/sound/soc/omap/osk5912.c b/sound/soc/omap/osk5912.c
> index aa4053b..e409677 100644
> --- a/sound/soc/omap/osk5912.c
> +++ b/sound/soc/omap/osk5912.c
> @@ -68,7 +68,7 @@ static int osk_hw_params(struct snd_pcm_substream *subs=
tream,
>  	return err;
>  }
> =20
> -static struct snd_soc_ops osk_ops =3D {
> +static const struct snd_soc_ops osk_ops =3D {
>  	.startup =3D osk_startup,
>  	.hw_params =3D osk_hw_params,
>  	.shutdown =3D osk_shutdown,
> diff --git a/sound/soc/omap/rx51.c b/sound/soc/omap/rx51.c
> index a768457..66ac358 100644
> --- a/sound/soc/omap/rx51.c
> +++ b/sound/soc/omap/rx51.c
> @@ -123,7 +123,7 @@ static int rx51_hw_params(struct snd_pcm_substream *s=
ubstream,
>  				      SND_SOC_CLOCK_IN);
>  }
> =20
> -static struct snd_soc_ops rx51_ops =3D {
> +static const struct snd_soc_ops rx51_ops =3D {
>  	.startup =3D rx51_startup,
>  	.hw_params =3D rx51_hw_params,
>  };
> --=20
> 2.7.4
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--ytm2ahlf4y2rom4v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAljPKAYACgkQ2O7X88g7
+pp5yRAAhyy7O4On0obdIBmN01Q8jznwinsFUhQvRnHI/ZLmGrZ0pP5GJm9yB4vQ
AessxVly7IrlUKx+E+Gs3mVPCn3wsxhjx9fxRrdYlKBMEmgz0PjdWuSrX3tIEWJF
ay1uK3jZtiYsF+OkNOcdT0HAd8b8CI+OczQMODq/QxQYCkubTsLgqhBXAfqIqV84
U1MeBO7wJNiXNj3Xbe4F2VvT2qWYJF0SzzBx1053QgjdgJ28TcHo0KIKSFe7h9i0
NtjviO+VsId82xyYt6iZ+5f8YF4++8VyFiBFtb4wjNO3CSSyTyUZDGJXb6EWvhhT
TtIu06NEZXcTiXtId2dFBqZNYOO4ytjDMRGVCLCiJ1Q2sEKJhB3q+89noKdjUql5
HccHnKbpIUxaXz/TPl0eVv31YO1yr1sQxsfLlKclNzpesTQQw6Sgl90/i/XGStmy
b1uJEPT/jW1lRwgZz1m0VXF0spgjGnrKMQ7x7Ht6wSUDbnWeUsAR/UHSFIyZZ1ya
UxxfICBlY+wXQF+kDltVmVJebOsisGPmWp+pI5c5iE/bbZ+krqpcQcE9tYWW/8kv
Iq40L2+Ty94S5GmyJcLtsJ/fpP7KYTc+fz2JFN6zK1Oi6iRZVnLYxqrYbqECHoBB
VMQJi5CRB5MpfW4F8t7REs0wofvNrCu5RJB0B8oQwEUVfED6JdM=
=Nbbv
-----END PGP SIGNATURE-----

--ytm2ahlf4y2rom4v--

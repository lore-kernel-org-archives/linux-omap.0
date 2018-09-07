From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] mfd: ti-lmu: constify mfd_cell tables
Date: Fri, 7 Sep 2018 11:39:54 +0200
Message-ID: <20180907093954.GA26364@amd>
References: <20180829093108.GB22065@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="jI8keyz6grp/JLjh"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180829093108.GB22065@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, sre@kernel.org, nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org, lee.jones@linaro.org
List-Id: linux-omap@vger.kernel.org


--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2018-08-29 11:31:08, Pavel Machek wrote:
> From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
>=20
> mfd: ti-lmu: constify mfd_cell tables
>    =20
> Add const attribute to all mfd_cell structures.
>    =20
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
> Signed-off-by: Pavel Machek <pavel@ucw.cz>

Lee, I guess this is for you to apply. Any news there?

There are more patches ready,

https://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap.git/log/?=
h=3Ddroid4-pending-v4.19

and it would be good to get them in. (Alternatively, you can just
cherry-pick them from droid4-pending-v4.19).

Thanks,
							Pavel
						=09

> diff --git a/drivers/mfd/ti-lmu.c b/drivers/mfd/ti-lmu.c
> index cfb411c..990437e 100644
> --- a/drivers/mfd/ti-lmu.c
> +++ b/drivers/mfd/ti-lmu.c
> @@ -25,7 +25,7 @@
>  #include <linux/slab.h>
> =20
>  struct ti_lmu_data {
> -	struct mfd_cell *cells;
> +	const struct mfd_cell *cells;
>  	int num_cells;
>  	unsigned int max_register;
>  };
> @@ -63,7 +63,7 @@ static void ti_lmu_disable_hw(struct ti_lmu *lmu)
>  		gpio_set_value(lmu->en_gpio, 0);
>  }
> =20
> -static struct mfd_cell lm3532_devices[] =3D {
> +static const struct mfd_cell lm3532_devices[] =3D {
>  	{
>  		.name          =3D "ti-lmu-backlight",
>  		.id            =3D LM3532,
> @@ -78,7 +78,7 @@ static struct mfd_cell lm3532_devices[] =3D {
>  	.of_compatible =3D "ti,lm363x-regulator",	\
>  }						\
> =20
> -static struct mfd_cell lm3631_devices[] =3D {
> +static const struct mfd_cell lm3631_devices[] =3D {
>  	LM363X_REGULATOR(LM3631_BOOST),
>  	LM363X_REGULATOR(LM3631_LDO_CONT),
>  	LM363X_REGULATOR(LM3631_LDO_OREF),
> @@ -91,7 +91,7 @@ static struct mfd_cell lm3631_devices[] =3D {
>  	},
>  };
> =20
> -static struct mfd_cell lm3632_devices[] =3D {
> +static const struct mfd_cell lm3632_devices[] =3D {
>  	LM363X_REGULATOR(LM3632_BOOST),
>  	LM363X_REGULATOR(LM3632_LDO_POS),
>  	LM363X_REGULATOR(LM3632_LDO_NEG),
> @@ -102,7 +102,7 @@ static struct mfd_cell lm3632_devices[] =3D {
>  	},
>  };
> =20
> -static struct mfd_cell lm3633_devices[] =3D {
> +static const struct mfd_cell lm3633_devices[] =3D {
>  	{
>  		.name          =3D "ti-lmu-backlight",
>  		.id            =3D LM3633,
> @@ -120,7 +120,7 @@ static struct mfd_cell lm3633_devices[] =3D {
>  	},
>  };
> =20
> -static struct mfd_cell lm3695_devices[] =3D {
> +static const struct mfd_cell lm3695_devices[] =3D {
>  	{
>  		.name          =3D "ti-lmu-backlight",
>  		.id            =3D LM3695,
> @@ -128,7 +128,7 @@ static struct mfd_cell lm3695_devices[] =3D {
>  	},
>  };
> =20
> -static struct mfd_cell lm3697_devices[] =3D {
> +static const struct mfd_cell lm3697_devices[] =3D {
>  	{
>  		.name          =3D "ti-lmu-backlight",
>  		.id            =3D LM3697,
>=20



--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--jI8keyz6grp/JLjh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAluSR2oACgkQMOfwapXb+vJc9gCeJhEmRkDU4AdGI802/qa9KRTN
fJsAoLPQds2zvCk12tH5nNicLUlbMjq/
=ncb4
-----END PGP SIGNATURE-----

--jI8keyz6grp/JLjh--

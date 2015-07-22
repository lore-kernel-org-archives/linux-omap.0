From: Sebastian Reichel <sre@kernel.org>
Subject: Re: linux 4.2-rc1 broken Nokia N900
Date: Wed, 22 Jul 2015 04:03:07 +0200
Message-ID: <20150722020306.GA8379@earth>
References: <201507111405.06048@pali>
 <201507132234.22082@pali>
 <20150713215232.GA22584@deathray>
 <201507140002.44119@pali>
 <20150713223607.GA23001@deathray>
 <20150714071412.GA12844@pali>
 <20150720204647.GA11931@deathstar>
 <20150721093441.GA23241@amd>
 <20150722001741.GA7950@deathstar>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="LQksG6bCIzRHxTLp"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150722001741.GA7950@deathstar>
Sender: linux-kernel-owner@vger.kernel.org
To: Michael Welling <mwelling@ieee.org>
Cc: Pavel Machek <pavel@ucw.cz>, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Tony Lindgren <tony@atomide.com>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Nishanth Menon <nm@ti.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jul 21, 2015 at 07:17:41PM -0500, Michael Welling wrote:
> On Tue, Jul 21, 2015 at 11:34:41AM +0200, Pavel Machek wrote:
>=20
> This code has my head spinning.
>=20
> I found that the errors do not occur when the driver is built into the ke=
rnel.
>=20
> I also found that with the patch below the errors go away.
>=20
> Not sure if it is acceptible but see if it fixes things on your side.
>=20
>=20
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index cf8b91b..3164d13 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -1801,11 +1801,11 @@ int spi_setup(struct spi_device *spi)
>  	if (!spi->max_speed_hz)
>  		spi->max_speed_hz =3D spi->master->max_speed_hz;
> =20
> -	spi_set_cs(spi, false);
> -
>  	if (spi->master->setup)
>  		status =3D spi->master->setup(spi);
> =20
> +	spi_set_cs(spi, false);
> +
>  	dev_dbg(&spi->dev, "setup mode %d, %s%s%s%s%u bits/w, %u Hz max --> %d\=
n",
>  			(int) (spi->mode & (SPI_CPOL | SPI_CPHA)),
>  			(spi->mode & SPI_CS_HIGH) ? "cs_high, " : "",

mh. maybe a runtime PM issue?

 * external abort on non-linefetch: address cannot be accessed,
   since the module's clocks are disabled
 * built-in works, module not: built-in is probably a little bit
   faster (module must not be loaded from filesystem), so that
   the device has not yet been suspended
 * Before 4.2, omap2_mcspi_set_cs() was called in the setup
   routine, which acquired runtime PM
 * In 4.2, omap2_mcspi_set_cs() seems to be called without a
   prior pm_runtime_get_sync()
 * With your workaround, the device has not yet returned to
   suspend after the runtime PM acquisition in setup()

So I suggest trying the following (compile tested only) patch:

-- Sebastian

diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index 5867384..f7d9ffd 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -245,6 +245,7 @@ static void omap2_mcspi_set_enable(const struct spi_dev=
ice *spi, int enable)
=20
 static void omap2_mcspi_set_cs(struct spi_device *spi, bool enable)
 {
+       struct omap2_mcspi *mcspi =3D spi_master_get_devdata(spi->master);
        u32 l;
=20
        /* The controller handles the inverted chip selects
@@ -255,6 +256,8 @@ static void omap2_mcspi_set_cs(struct spi_device *spi, =
bool enable)
                enable =3D !enable;
=20
        if (spi->controller_state) {
+               pm_runtime_get_sync(mcspi->dev);
+
                l =3D mcspi_cached_chconf0(spi);
=20
                if (enable)
@@ -263,6 +266,9 @@ static void omap2_mcspi_set_cs(struct spi_device *spi, =
bool enable)
                        l |=3D OMAP2_MCSPI_CHCONF_FORCE;
=20
                mcspi_write_chconf0(spi, l);
+
+               pm_runtime_mark_last_busy(mcspi->dev);
+               pm_runtime_put_autosuspend(mcspi->dev);
        }
 }
=20

--LQksG6bCIzRHxTLp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVrvnXAAoJENju1/PIO/qah7sP/2uMyVL9yPrqmQ0gbonrRUYW
IOm3w1xwJppYOAWkeqZu9jolcgNybsTFha3YOkSEJa5EX+OJQQJMkl3P1xPxwJjT
QcyOR0WxcfvgTu48kIarnpZUmWqDPBf47j9xVlVADfUxeqvr+dZOtEzNd/f3o/2S
2knlbbyHXl7PL1Ve5UEZmJqAeGP0s3riO91cqqT958ULiSCXMM6dD+A/+YBZwx1N
qeEvzRGZSmS3Z71uzJq6uAXjDPoLP74f8Afixyn21qlOQ691GmLDi5AxRLdZ551o
zahL+BsZTzSJnVnu5TAdMQR1SWLr/7cWJn/OsKpyKyfjgVQoQ6NSnmyCjuh5jXVv
eS+Da/ZUNQviSB3sEwN6nzT4uBYU60GHqp6RgseGn75X6BYMCNkN+LwT5+ga7+Tj
KGy+uOArN86SFquI9UXbWCYa9q2FmYFaACdX6tTkaL1DpO3Qw50Zj0XxPZhh+hzG
P4W9iCwU/oBk2p+4+DcdiJNtXKthgu0PFJ1eEZE4gT8wnR16BEfp1FnmPCgbFMPg
tD1vARCz2JixCRpCVQ7UUh1zsLqqiXaBbCQkscLmLYKX8O3R/qrWv3m3HJ3yvdfz
TtZTWQPnnYIhoV2XBlPZFmB61CaDeExGOe2/pwevjPg37XbJeRqs/SfyNyAvadlZ
uWuZF8oi29y9oAwkxCHU
=jnld
-----END PGP SIGNATURE-----

--LQksG6bCIzRHxTLp--

From: Felipe Balbi <balbi@ti.com>
Subject: Re: [RFC/PATCH 3/3] driver: spi: Add quad spi read support
Date: Mon, 8 Jul 2013 17:36:51 +0300
Message-ID: <20130708143651.GH31221@arwen.pp.htv.fi>
References: <1373290980-17883-1-git-send-email-sourav.poddar@ti.com>
 <1373290980-17883-4-git-send-email-sourav.poddar@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VbfcI4OLZ4XW0yH2"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1373290980-17883-4-git-send-email-sourav.poddar@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sourav Poddar <sourav.poddar@ti.com>
Cc: broonie@kernel.org, spi-devel-general@lists.sourceforge.net, grant.likely@linaro.org, balbi@ti.com, rnayak@ti.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--VbfcI4OLZ4XW0yH2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 08, 2013 at 07:13:00PM +0530, Sourav Poddar wrote:
> Since, qspi controller uses quad read.
>=20
> Configuring the command register, if the transfer of data needs
> quad lines.
>=20
> This patch has been done on top of the following patch[1], which is still
> under review/comments.
> This patch will also go changes, as the parent patch[1] does.
>=20
> [1]: http://comments.gmane.org/gmane.linux.kernel.spi.devel/14047
>=20
> Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>
> ---
>  drivers/spi/spi-ti-qspi.c |    8 ++++++--
>  1 files changed, 6 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/spi/spi-ti-qspi.c b/drivers/spi/spi-ti-qspi.c
> index 430de9c..307cbed 100644
> --- a/drivers/spi/spi-ti-qspi.c
> +++ b/drivers/spi/spi-ti-qspi.c
> @@ -258,8 +258,12 @@ static int qspi_read_msg(struct dra7xxx_qspi *qspi, =
struct spi_transfer *t)
>  			qspi->cmd | QSPI_RD_SNGL, qspi->dc);
>  		dra7xxx_writel(qspi, QSPI_WC_INT_EN, QSPI_INTR_ENABLE_SET_REG);
>  		dra7xxx_writel(qspi, qspi->dc, QSPI_SPI_DC_REG);
> -		dra7xxx_writel(qspi, qspi->cmd | QSPI_RD_SNGL,
> -			QSPI_SPI_CMD_REG);
> +		if (t->bitwidth =3D=3D SPI_BITWIDTH_QUAD)
> +			dra7xxx_writel(qspi, qspi->cmd | QSPI_RD_QUAD,
> +				QSPI_SPI_CMD_REG);
> +		else
> +			dra7xxx_writel(qspi, qspi->cmd | QSPI_RD_SNGL,
> +				QSPI_SPI_CMD_REG);

we also have read dual, in order to make this code a little better you
could:

	unsigned cmd =3D qspi->cmd;

	switch (t->bitwidth)
	case SPI_BITWIDTH_QUAD:
		cmd |=3D QSPI_RD_QUAD;
		break;
	case SPI_BITWIDTH_DUAL:
		cmd |=3D QSPI_RD_DUAL;
		break;
	case SPI_BITWIDTH_SINGLE:
	default:
		cmd |=3D QSPI_RD_SNGL;
	}

	dra7xx_writel(qspi, cmd, QSPI_SPI_CMD_REG);

--=20
balbi

--VbfcI4OLZ4XW0yH2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJR2s6DAAoJEIaOsuA1yqRE2BsQAJW+05dztetj0tVqUtHAwz/S
LGBd1ke63nBFMKsieKJzGRxsD7lRV3L2STzljIajvVfehhUuEab8xXIQ8tZNY2+m
gNftfX9JFM59D3LFjHaKeLA2vKpPe8A/JEL+BZcwm35vyTRKTW5W++OS7cjp1dHV
nsULDWeI89zzbEI0lFalyFvn4k9/YBQqKccfld/lTCHO8js7ctcbVEdZQW7I2EgE
fH9z2nz7fby6xo3TWnR/+kACz/gKHMqBZZsSPdSOcvQfcKEtttgS4kEzOtivKkp/
CPftx7FUiahR/ORAbhvc5ov5OjWV7E179EiW9XX6Dfd4qzsZOIroFcpPUnMPFFcI
oEP0LfUkMKqAVTkACWdwSU5zPFo8HhcuJr1vI36/zTtdcolrKX+EXCjiNuj/IJ5f
Nwtu8M4FEvIn2mG6VPjy5kO7fZw2bEacO3XEuy8bDXvGh1DYG+otlpgqFfwgWAAn
GQJtqQ122woYESPUjfFBg8WmQHfBC0vjHVJ26PXetVwNhFNJ+7k6SiT+yf6cq2MJ
WKp0pBQ6cMrMciWkWt999A9exSTsVuTZWsDAZmoI78cxJa4mhQ8BnwVJbGdzP4Of
FY1DiG/pATVucaL/NQSa0EfEPKlWgZas8fE4QTtMF+oxowS3rQGFBMxwlBCpIq9f
pFTY2G6aEJ4A5Lqk/0l1
=UlaK
-----END PGP SIGNATURE-----

--VbfcI4OLZ4XW0yH2--

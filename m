From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCHv10] drivers: spi: Add qspi flash controller
Date: Tue, 20 Aug 2013 08:14:29 -0500
Message-ID: <20130820131429.GB26587@radagast>
References: <1377003925-6284-1-git-send-email-sourav.poddar@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3T9UM0G5oz8hnqz/"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:59541 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750907Ab3HTNPL (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 20 Aug 2013 09:15:11 -0400
Content-Disposition: inline
In-Reply-To: <1377003925-6284-1-git-send-email-sourav.poddar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sourav Poddar <sourav.poddar@ti.com>
Cc: broonie@kernel.org, spi-devel-general@lists.sourceforge.net, grant.likely@linaro.org, balbi@ti.com, linux-omap@vger.kernel.org

--3T9UM0G5oz8hnqz/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Aug 20, 2013 at 06:35:25PM +0530, Sourav Poddar wrote:
> +static int qspi_transfer_msg(struct ti_qspi *qspi, struct spi_transfer *=
t)
> +{
> +	int ret;
> +
> +	if (t->tx_buf) {
> +		ret =3D qspi_write_msg(qspi, t);
> +		if (ret) {
> +			dev_dbg(qspi->dev, "Error while writing\n");
> +			return ret;
> +		}
> +	}
> +
> +	if (t->rx_buf) {
> +		ret =3D qspi_read_msg(qspi, t);
> +		if (ret) {
> +			dev_dbg(qspi->dev, "Error while writing\n");

*READING*

other than that:

Acked-by: Felipe Balbi <balbi@ti.com>
Reviewed-by: Felipe Balbi <balbi@ti.com>

--=20
balbi

--3T9UM0G5oz8hnqz/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJSE2u1AAoJEIaOsuA1yqREd4sP/j0l4Lo3LiauKccCpGXQEhkD
aHtR7ktLopqGkXPhOxPhPiz0l4bkoqtQGDLhsSvU2Q+rFc2MrlbpUzryVKWex60K
l8WUBEIscQXH8VE3VMILyc/YyS1cJCKIwrRLOPlZMdovi+qBdgtLJ7s21Ow6toiB
HEBbcYII210Ail9WGXxdRo9xRNMzl35aA1zlQTlQgGyKwAkg+Frq1AsEVU/L1ixk
mj3iNB++VsCtPelvBWqnq7Zj+KE39XPbQ9z2B0EWq8Y9wr9MyUzm7Cvq+mIl+t/L
iDTbn71FP6rvrBzI5RWel7eJewlKmwJlJSQQL77+ym08T8RVPmIlnVzqzVOucocd
eHtISCqY/zLnd+bWqdFsBU2i2r84cmCQ8fEm4wGgG1XRoUcnfRzyxhfcpKGdU9az
Zeg6StL+Diu5jii0639G3j6T3rqymVWj2G1wJgLG7qUc5NVuXvUtbyCZoUPAsrpS
5fHduE1GJCto10+DeAvbwtzhLQLtDpyUvjh0ZXeVwEI31CMfCISbTn+AOdk2594q
BYX/hl4Fr1fxiY66JvS9jhPGGBPPOpBcch7NlZD451bRZJihy8bbYQBf7zUwoq+4
DSzFA3H29EtRsAUhdMrljEFxI4koOTo3ngtU+u+C2a3gu0wseWKtaM6Xsyhk0Sx4
OI7+SoHA24qtaOlUsDlT
=QBj/
-----END PGP SIGNATURE-----

--3T9UM0G5oz8hnqz/--

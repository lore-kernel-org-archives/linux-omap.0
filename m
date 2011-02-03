From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCHv2 2/2] Input: ads7846 - configure pendown gpio as input
Date: Thu, 3 Feb 2011 11:10:33 +0100
Message-ID: <20110203100528.GA6508@pengutronix.de>
References: <1296726530-32199-1-git-send-email-sourav.poddar@ti.com>
 <20110203095845.GK23561@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cmJC7u66zC7hs+87"
Return-path: <linux-input-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20110203095845.GK23561@legolas.emea.dhcp.ti.com>
Sender: linux-input-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Sourav Poddar <sourav.poddar@ti.com>, dmitry.torokhov@gmail.com, charu@ti.com, linux-input@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, gadiyar@ti.com
List-Id: linux-omap@vger.kernel.org


--cmJC7u66zC7hs+87
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 03, 2011 at 11:58:45AM +0200, Felipe Balbi wrote:
> On Thu, Feb 03, 2011 at 03:18:50PM +0530, Sourav Poddar wrote:
> > The ads7846 driver requests a gpio to detect pendown events,
> > but does not configure its direction. Configure this gpio
> > as an input after requesting it.
> >=20
> > Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>
> > ---
> > changes between v2 and v1: Added return error support in v2.=20
> > =20
> > drivers/input/touchscreen/ads7846.c |    7 +++++++
> > 1 files changed, 7 insertions(+), 0 deletions(-)
> >=20
> > diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchs=
creen/ads7846.c
> > index 036f245..f30768b 100644
> > --- a/drivers/input/touchscreen/ads7846.c
> > +++ b/drivers/input/touchscreen/ads7846.c
> > @@ -962,6 +962,13 @@ static int __devinit ads7846_setup_pendown(struct =
spi_device *spi, struct ads784
> >  		return err;
> >  	}
> > =20
> > +	err =3D gpio_direction_input(pdata->gpio_pendown);
> > +	if (err) {
> > +		dev_err(&spi->dev, "failed to configure pendown GPIO input direction=
 %d\n",
> > +			pdata->gpio_pendown);
> > +		return err;
>=20
> and now you miss a gpio_free().

Better use gpio_request_one()?

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--cmJC7u66zC7hs+87
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEUEARECAAYFAk1KfxkACgkQD27XaX1/VRtQUwCfSwaOdhF/I8/+fQebPvrGnFNJ
vsEAlR/etvSdcf/IlV4SPVOkjAkNnPc=
=oByj
-----END PGP SIGNATURE-----

--cmJC7u66zC7hs+87--

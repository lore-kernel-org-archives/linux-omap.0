From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH v3 2/2] Input: ads7846: use gpio_request_one to
 configure pendown_gpio
Date: Thu, 3 Feb 2011 23:12:07 +0100
Message-ID: <20110203221207.GA1437@pengutronix.de>
References: <1296746506-12221-1-git-send-email-sourav.poddar@ti.com>
 <20110203165405.GB12802@core.coreip.homeip.net>
 <20110203171953.GA13997@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8t9RHnE3ZwKMSgU+"
Return-path: <linux-input-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20110203171953.GA13997@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Sourav Poddar <sourav.poddar@ti.com>, balbi@ti.com, charu@ti.com, grinberg@compulab.co.il, linux-input@vger.kernel.org, linux-omap@vger.kernel.org, LW@karo-electronics.de, linux-arm-kernel@lists.infradead.org, gadiyar@ti.com
List-Id: linux-omap@vger.kernel.org


--8t9RHnE3ZwKMSgU+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 03, 2011 at 09:19:53AM -0800, Dmitry Torokhov wrote:
> On Thu, Feb 03, 2011 at 08:54:05AM -0800, Dmitry Torokhov wrote:
> > On Thu, Feb 03, 2011 at 08:51:46PM +0530, Sourav Poddar wrote:
> > > The ads7846 driver requests a gpio but does not currently
> > > configure it explicitly as an input. Use gpio_request_one
> > > to request and configure it at one shot.
> > >=20
> > > Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>
> > > Cc: Dmitry Torokhov <dtor@mail.ru>
> >=20
> > Will apply this one, the other one is a bit messy IMO, will have to
> > think about it.
> >=20
>=20
> Something like below should do I think.

Yeah, that was what I was suggesting, too

Acked-by: Wolfram Sang <w.sang@pengutronix.de>

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--8t9RHnE3ZwKMSgU+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAk1LKDcACgkQD27XaX1/VRsTBgCgpmNTxEDcvug/ol5r38B/UWS9
aF4AnRVTPRD1cmCTNp2io1eTjzO/KyA0
=fY9g
-----END PGP SIGNATURE-----

--8t9RHnE3ZwKMSgU+--

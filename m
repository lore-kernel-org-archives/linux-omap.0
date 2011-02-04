From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH v3 2/2] Input: ads7846: use gpio_request_one to
 configure pendown_gpio
Date: Fri, 4 Feb 2011 15:54:38 +0100
Message-ID: <20110204145438.GB3178@pengutronix.de>
References: <1296746506-12221-1-git-send-email-sourav.poddar@ti.com>
 <20110203165405.GB12802@core.coreip.homeip.net>
 <20110203171953.GA13997@core.coreip.homeip.net>
 <20110204133250.GB2070@m-desktop>
 <20110204140847.GA3178@pengutronix.de>
 <20110204141618.GE2070@m-desktop>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/NkBOFFp2J2Af1nK"
Return-path: <linux-input-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20110204141618.GE2070@m-desktop>
Sender: linux-input-owner@vger.kernel.org
To: "G, Manjunath Kondaiah" <manjugk@ti.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, balbi@ti.com, charu@ti.com, grinberg@compulab.co.il, linux-input@vger.kernel.org, Sourav Poddar <sourav.poddar@ti.com>, linux-omap@vger.kernel.org, LW@karo-electronics.de, linux-arm-kernel@lists.infradead.org, gadiyar@ti.com
List-Id: linux-omap@vger.kernel.org


--/NkBOFFp2J2Af1nK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 04, 2011 at 07:46:18PM +0530, G, Manjunath Kondaiah wrote:
> On Fri, Feb 04, 2011 at 03:08:47PM +0100, Wolfram Sang wrote:
> > On Fri, Feb 04, 2011 at 07:02:50PM +0530, G, Manjunath Kondaiah wrote:
> > > On Thu, Feb 03, 2011 at 09:19:53AM -0800, Dmitry Torokhov wrote:
> > > > On Thu, Feb 03, 2011 at 08:54:05AM -0800, Dmitry Torokhov wrote:
> > > > > On Thu, Feb 03, 2011 at 08:51:46PM +0530, Sourav Poddar wrote:
> > > > > > The ads7846 driver requests a gpio but does not currently
> > > > > > configure it explicitly as an input. Use gpio_request_one
> > > > > > to request and configure it at one shot.
> > > > > >=20
> > > > > > Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>
> > > > > > Cc: Dmitry Torokhov <dtor@mail.ru>
> > > > >=20
> > > > > Will apply this one, the other one is a bit messy IMO, will have =
to
> > > > > think about it.
> > > > >=20
> > > >=20
> > > > Something like below should do I think.
> > > Patch looks good but it applies only on top of previous patch:
> > > https://patchwork.kernel.org/patch/529941/
> > >=20
> > > Why to have two patches for this fix?
> >=20
> > http://www.spinics.net/lists/linux-omap/msg45167.html
> My point here is:=20
> 1. The first patch only replaces gpio_request with gpio_request_one
> 2. Rest of the things are handled in 2nd patch posted by dmitry

I understood. Exactly this is discussed in the first paragraph of that
link.

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--/NkBOFFp2J2Af1nK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk1MEy4ACgkQD27XaX1/VRtiVACcDoWIy9Gda2qLd9JHCzyOCiPV
r+UAoMku62VU4nuHXXlziHdJNBoqfAqL
=kzJA
-----END PGP SIGNATURE-----

--/NkBOFFp2J2Af1nK--

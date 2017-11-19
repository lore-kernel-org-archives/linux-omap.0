From: Pavel Machek <pavel@ucw.cz>
Subject: Re: bh1770 hacks: get it to work on n950
Date: Sun, 19 Nov 2017 13:41:50 +0100
Message-ID: <20171119124150.GA25154@amd>
References: <20171116115703.GA26735@amd>
 <20171117113540.3bapqvq6mfuovxuw@earth>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="ZGiS0Q5IWpPtfppv"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171117113540.3bapqvq6mfuovxuw@earth>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: pali.rohar@gmail.com, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com, clayton@craftyguy.net, martijn@brixit.nl, sakari.ailus@linux.intel.com, arnd@arndb.de, Filip =?utf-8?Q?Matijevi=C4=87?= <filip.matijevic.pz@gmail.com>
List-Id: linux-omap@vger.kernel.org


--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2017-11-17 12:35:40, Sebastian Reichel wrote:
> Hi,
>=20
> On Thu, Nov 16, 2017 at 12:57:03PM +0100, Pavel Machek wrote:
> > Hi!
> >=20
> > Ok, not for application, but I can get light sensor to work.
> >=20
> > Signed-off-by: Pavel Machek <pavel@ucw.cz>
>=20
> There is no mainline user of this driver and it has a custom API, so
> I think the driver should be dropped and an IIO based one should be
> created instead.

While I agree IIO interface might be better, and would welcome
patches, I don't think that dropping the driver is right action at
this point.
								Pavel
							=09

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--ZGiS0Q5IWpPtfppv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAloRfA4ACgkQMOfwapXb+vKXUACgscrDkM5vsxEZHkOBAe5k+2Vz
mX0An1pYgwPJ1mNUavmHnprxq9uwkJ14
=J2vR
-----END PGP SIGNATURE-----

--ZGiS0Q5IWpPtfppv--

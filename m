From: Pavel Machek <pavel@ucw.cz>
Subject: Re: bh1770 hacks: get it to work on n950
Date: Sun, 19 Nov 2017 16:07:30 +0100
Message-ID: <20171119150730.GA2366@amd>
References: <20171116115703.GA26735@amd>
 <20171117113540.3bapqvq6mfuovxuw@earth>
 <20171119124150.GA25154@amd>
 <20171119141213.my7dnc77xbun3gfj@lenoch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="fdj2RfSjLxBAspz7"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171119141213.my7dnc77xbun3gfj@lenoch>
Sender: linux-kernel-owner@vger.kernel.org
To: Ladislav Michl <ladis@linux-mips.org>
Cc: Sebastian Reichel <sre@kernel.org>, pali.rohar@gmail.com, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com, clayton@craftyguy.net, martijn@brixit.nl, sakari.ailus@linux.intel.com, arnd@arndb.de, Filip =?utf-8?Q?Matijevi=C4=87?= <filip.matijevic.pz@gmail.com>
List-Id: linux-omap@vger.kernel.org


--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun 2017-11-19 15:12:13, Ladislav Michl wrote:
> On Sun, Nov 19, 2017 at 01:41:50PM +0100, Pavel Machek wrote:
> > On Fri 2017-11-17 12:35:40, Sebastian Reichel wrote:
> > > Hi,
> > >=20
> > > On Thu, Nov 16, 2017 at 12:57:03PM +0100, Pavel Machek wrote:
> > > > Hi!
> > > >=20
> > > > Ok, not for application, but I can get light sensor to work.
> > > >=20
> > > > Signed-off-by: Pavel Machek <pavel@ucw.cz>
> > >=20
> > > There is no mainline user of this driver and it has a custom API, so
> > > I think the driver should be dropped and an IIO based one should be
> > > created instead.
> >=20
> > While I agree IIO interface might be better, and would welcome
> > patches, I don't think that dropping the driver is right action at
> > this point.
>=20
> That's the most elegant solution at all. How would you later motivate
> people to try and test IIO driver? Let's pretend this patch have never
> existed until someone notices and starts playing "you broke kernel ABI"
> game.

I'm using the driver; I'm even interested in fixing it. Please try not
to make my job any harder than it needs to be, and I'll try to break
ABI.

That goes to Sebastian, too.

If you want to convert the driver to IIO, please do so, I can test the patc=
hes.

Thank you,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--fdj2RfSjLxBAspz7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAloRnjIACgkQMOfwapXb+vKfAACfcF4sk6o+9lH028HBJmHwl+FY
wmoAn3qrnegb8VND+13RN7cKfnuQ//RP
=chFW
-----END PGP SIGNATURE-----

--fdj2RfSjLxBAspz7--

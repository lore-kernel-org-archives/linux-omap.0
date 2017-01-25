From: Pavel Machek <pavel@ucw.cz>
Subject: Re: v4.10-rc4 to v4.10-rc5: battery regression on Nokia N900
Date: Wed, 25 Jan 2017 11:17:21 +0100
Message-ID: <20170125101721.GA3912@amd>
References: <20170123232654.GA19342@amd>
 <20170123234912.GA2460@roeck-us.net>
 <20170124070639.GA5068@rzhang1-surface>
 <20170124073720.GB5603@amd>
 <88c94ea6-abe2-0f20-337e-e9ee00c883d8@roeck-us.net>
 <20170124175800.GA15070@amd>
 <20170124184526.GA25056@roeck-us.net>
 <20170124224610.GA27340@amd>
 <CAOMZO5AFZy6YFrE0P-xDXX5BCfWYHAC34VyyX85H5Wr+1O59jA@mail.gmail.com>
 <1485322192.2461.4.camel@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="ikeVEW9yuYc//A+q"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1485322192.2461.4.camel@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Fabio Estevam <festevam@gmail.com>, Guenter Roeck <linux@roeck-us.net>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Kevin Hilman <khilman@kernel.org>, Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, kernel list <linux-kernel@vger.kernel.org>, Sebastian Reichel <sre@kernel.org>, abcloriens@gmail.com, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Fabio Estevam <fabio.estevam@nxp.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, patrikbachan@gmail.com, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, serge@hallyn.com
List-Id: linux-omap@vger.kernel.org


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2017-01-25 13:29:52, Zhang Rui wrote:
> On Tue, 2017-01-24 at 21:07 -0200, Fabio Estevam wrote:
> > On Tue, Jan 24, 2017 at 8:46 PM, Pavel Machek <pavel@ucw.cz> wrote:
> >=20
> > >=20
> > > It is an ugly regression and it is -rc5 time. Actually not your
> > > problem, but Fabio Estevam or Zhang Rui has to deal with it soon.
> > I have already sent the revert and it was acked-by you and Guenter.
>=20
> Revert patch has been applied and queued for next -rc.

Thanks!
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--ikeVEW9yuYc//A+q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAliIezEACgkQMOfwapXb+vKhUACeK243wGH5KfxUM02BUmVHCklL
kGoAn3C2QkhOIVdGcaMhsBenVgOIXuNk
=ICp/
-----END PGP SIGNATURE-----

--ikeVEW9yuYc//A+q--

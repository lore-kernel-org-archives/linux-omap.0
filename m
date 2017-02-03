From: Pavel Machek <pavel@ucw.cz>
Subject: Re: v4.9 to v4.10 regression: oops when USB cable is plugged in.
Date: Fri, 3 Feb 2017 08:59:07 +0100
Message-ID: <20170203075907.GA21338@amd>
References: <20170123222537.GA11543@amd>
 <20170123224454.GY7403@atomide.com>
 <20170124091817.GA29246@amd>
 <20170124100133.GA21079@pali>
 <20170124145127.GC7403@atomide.com>
 <20170127215512.GG20571@amd>
 <20170127234832.cte4ki4ajwme2b2j@earth>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="C7zPtVaVf+AK4Oqc"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170127234832.cte4ki4ajwme2b2j@earth>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com, b-liu@ti.com, linux-usb@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> On Fri, Jan 27, 2017 at 10:55:12PM +0100, Pavel Machek wrote:
> > Ok, I can try. But so far even -rc1 is a lot of fun. But... I consider
> > phone calls core feature of a phone. I'd very much like to get that to
> > work. Unfortunately, that means real-time audio, and a lot of
> > fun. Plus, as it is touchscreen device, it needs a GUI.=20
>=20
> Talking about testing - kernelci's n900 is broken?
>=20
> https://kernelci.org/boot/omap3-n900/

The N900 regressions are now more of "audio mixers no longer work"
than "it fails to boot" kind -- thus difficult to test automatically,
I'm afraid.
									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--C7zPtVaVf+AK4Oqc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAliUOEsACgkQMOfwapXb+vLKbgCeKPAElcWFZyQagZ4CdMecctNH
jfYAn3tjYUlgA7Y9kpjsu2FckygubpCT
=GBTv
-----END PGP SIGNATURE-----

--C7zPtVaVf+AK4Oqc--

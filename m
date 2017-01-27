From: Pavel Machek <pavel@ucw.cz>
Subject: Re: v4.10-rc4 to v4.10-rc5: battery regression on Nokia N900
Date: Fri, 27 Jan 2017 12:16:26 +0100
Message-ID: <20170127111626.GB5335@amd>
References: <20170124073720.GB5603@amd>
 <88c94ea6-abe2-0f20-337e-e9ee00c883d8@roeck-us.net>
 <20170124175800.GA15070@amd>
 <20170124184526.GA25056@roeck-us.net>
 <20170125111233.GB3912@amd>
 <20170125120918.GA7936@pali>
 <1485481030.2469.15.camel@intel.com>
 <a6ce0873-9164-a965-a3e1-9eaaaec2201f@roeck-us.net>
 <1485488382.2469.27.camel@intel.com>
 <9146145b-7e21-c4de-a9cd-dad7bc74ee7a@roeck-us.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="2B/JsCI69OhZNC5r"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <9146145b-7e21-c4de-a9cd-dad7bc74ee7a@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: Zhang Rui <rui.zhang@intel.com>, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com, fabio.estevam@nxp.com
List-Id: linux-omap@vger.kernel.org


--2B/JsCI69OhZNC5r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> >>That sounds like fun. Changing bq27200-0 to bq27200_0 is Forbidden by
> >>the ABI Police, but taking the entire device away is ok.

Changing bq27200-0 to bq27200_0 is forbidden in -rc6 time. If you
believe noone depends on the name, argue your case, and it might be
possible to change it in -rc0.

If someone uses the name, they care about the device, and you can't
take it away.

> >No. IMO, it depends on if the interface is used or not.
> >If hwmon I/F is used, we can not take it away, nor change its name.
>=20
> Even if the use doesn't depend on that name ?

If the use doesn't depend on the name, you may get away with changing
the name. (But not in -rc6.)

> >If thermal zone I/F is used, we can not change it's 'type' name to be
> >compatible with new hwmon API.
>=20
> You mean you can not fix the name to be compatible with libsensors.
>=20
> Makes me wonder if there shouldn't be a rule that exploits must not
> be fixed if already exploited.

That is not useful argumentation.
									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--2B/JsCI69OhZNC5r
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAliLLAoACgkQMOfwapXb+vKSXwCglSkXi4dpxH2esWUTYWrMpOZ4
R5AAn3jnC2XEf/B4vC3rm/3oiXv27HK3
=yLyd
-----END PGP SIGNATURE-----

--2B/JsCI69OhZNC5r--

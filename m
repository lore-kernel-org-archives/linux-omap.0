From: Pavel Machek <pavel@ucw.cz>
Subject: Re: v4.17-rc1: regressions on N900, N950
Date: Thu, 24 May 2018 11:47:05 +0200
Message-ID: <20180524094705.GA16705@amd>
References: <20180422074213.GA12428@amd>
 <20180423202940.ig6iud5lrbgnu35a@darkstar.musicnaut.iki.fi>
 <20180521213952.GA11596@amd>
 <20180522080250.4fzyvqrgw5oigexn@pali>
 <20180522194139.GB2299@darkstar.musicnaut.iki.fi>
 <20180522205824.GA24927@amd>
 <20180522215638.GC2299@darkstar.musicnaut.iki.fi>
 <20180523140615.GA27180@amd>
 <20180523201208.GA31731@amd>
 <20180523220456.GY98604@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="9amGYk9869ThD9tj"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180523220456.GY98604@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, khilman@kernel.org, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com, clayton@craftyguy.net, martijn@brixit.nl, sakari.ailus@linux.intel.com, Filip =?utf-8?Q?Matijevi=C4=87?= <filip.matijevic.pz@gmail.com>, Thorsten Leemhuis <regressions@leemhuis.info>
List-Id: linux-omap@vger.kernel.org


--9amGYk9869ThD9tj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > So... I did some experiments on v4.16.
> > >=20
> > > Swapping tsc2005@0 and lcd: acx565akm@2 entries in the dts does break
> > > stuff.
> > >=20
> > > I thought it might be due to vio regulator, but it does not appear
> > > so... screen still works with tsc2005 driver disabled in .config. (so
> > > there's noone to enable vio regulator).
> >=20
> > Deleting tsc2005@0 entry also breaks screen.
> >=20
> > Replacing tsc2005@0 entry with=20
> >=20
> >         foobar@0 {
> > 	               compatible =3D "not really with anything";
> >  		       spi-max-frequency =3D <6000000>;
> >  		       reg =3D <0>;
> >  };
> >=20
> > still results in working touchscreen, removing any of the three fields
> > breaks it again.
>=20
> I bisected one regression down, see "omapdrm regression in v4.17-rc serie=
s"
> not sure if it covers all the issues being discussed here though.

Reverting 24aac6011f70 fixes screen on n900 in v4.17-rc for me. (But
strange dependency on tsc2005@0 is still there).

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--9amGYk9869ThD9tj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlsGihkACgkQMOfwapXb+vJ0rgCglJW7XtpGu4tG1Z6c0yqPXNAm
Y0MAnj2+L76ZZfueUH00t5AKakHguU8Q
=wIst
-----END PGP SIGNATURE-----

--9amGYk9869ThD9tj--

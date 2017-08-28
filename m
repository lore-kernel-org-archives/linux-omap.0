From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] nokia n900: update dts with camera support
Date: Mon, 28 Aug 2017 15:59:59 +0200
Message-ID: <20170828135959.GA32560@amd>
References: <20170810204923.GA18442@amd>
 <20170814201950.sbtyuksn3ntuigyp@valkosipuli.retiisi.org.uk>
 <20170815220349.GA15441@amd>
 <20170816205332.rqcuenvuxfs5jvuw@earth>
 <20170816205915.GA5386@atrey.karlin.mff.cuni.cz>
 <20170816212343.hfd4azb4dq2qrlkc@valkosipuli.retiisi.org.uk>
 <20170817000845.agkcuvqaheejm33j@earth>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="u3/rZRmxL6MmkK24"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170817000845.agkcuvqaheejm33j@earth>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Sakari Ailus <sakari.ailus@iki.fi>, pali.rohar@gmail.com, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com
List-Id: linux-omap@vger.kernel.org


--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > Well, strobe property above already uses =3D <0>/<1> format, as do
> > > others.
> >
> > > Problem with "false =3D property does not exist" is that you don't kn=
ow
> > > if it is "someone forgot to define it" or "someone made a typo" or
> > > "dts is too old to know about this property" or "the property indeed
> > > should be false"...
> >
> > As this is an established practice, I think we should follow it for bool
> > properties.
>=20
> Yes it's common practice, there is also device_property_read_bool()
> to get the value.
>=20
> > We could change the existing ones, too, and leave some extra checks in
> > place to handle old dtbs.
>=20
> The following should be downward compatible:
>=20
> var =3D read_bool();
> if (var && !read_int())
>     var =3D false;
>=20
> Btw. DT people should be CC'd for DT binding additions/changes.

Ok, so for now we do crc=3D1 by default. Now we'd like to have crc
support configurable in the dts. But if we just introduce "crc;"
option, it will break old dts users. We could introduce "no-crc;" and
that would work in this particular case, but will break when we want
different defaults at different devices.

Anyway, introducing "no-crc;" seems pretty ugly to me. I'd rather do
"crc=3D<0>;", in a similar way we handle other options now.

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--u3/rZRmxL6MmkK24
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlmkId8ACgkQMOfwapXb+vJ4kwCgmcEntH1DY8oxUIU5JpfKS/JW
IgIAoLo0g4+aPmNkY5/QRQHvcmw9GHmz
=Mv5B
-----END PGP SIGNATURE-----

--u3/rZRmxL6MmkK24--

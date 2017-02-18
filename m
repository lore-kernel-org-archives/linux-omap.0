From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v9 1/8] drivers:input:tsc2007: add new common binding
 names, pre-calibration, flipping and rotation
Date: Sat, 18 Feb 2017 23:54:35 +0100
Message-ID: <20170218225435.GA4693@amd>
References: <cover.1482936802.git.hns@goldelico.com>
 <9830dd21e6425e3a866fac6ed4cc73ddd58b719f.1482936802.git.hns@goldelico.com>
 <20170128193342.GB38136@dtor-ws>
 <1F6355E1-A5E3-41A6-908F-619A15581BEF@goldelico.com>
 <20170217204041.GE13050@dtor-ws>
 <20170218091526.GC8937@amd>
 <61F3C580-4BF2-4EE6-9DEC-FB8634434EC0@goldelico.com>
 <20170218180811.GB9377@amd>
 <27287BC5-E4E2-4F50-B140-C74D3CADED5B@goldelico.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="EeQfGwPcQSOJBaQU"
Return-path: <linux-input-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <27287BC5-E4E2-4F50-B140-C74D3CADED5B@goldelico.com>
Sender: linux-input-owner@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sebastian Reichel <sre@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Michael Welling <mwelling@ieee.org>, Mika =?iso-8859-1?Q?Penttil=E4?= <mika.penttila@nextfour.com>, Javier Martinez Canillas <javier@osg.samsung.com>, Igor Grinberg <grinberg@compulab.co.il>, "Andrew F. Davis" <afd@ti.com>, Mark Brown <broonie@kernel.org>, Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh+dt@kernel.org>, Alexander Stein <alexander.stein@systec-electronic.com>, Eric Engestrom <eric@engestrom.ch>, Hans de Goede <hdegoede@redhat.com>Benjamin Tissoires <be>
List-Id: linux-omap@vger.kernel.org


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat 2017-02-18 20:17:09, H. Nikolaus Schaller wrote:
>=20
> > Am 18.02.2017 um 19:08 schrieb Pavel Machek <pavel@ucw.cz>:
> >=20
> >>> And I agree that kernel should _not_ attempt rescaling itself, as it
> >>> would lose precision.
> >>=20
> >> With an almost 1:1 mapping you won't loose precision.
> >=20
> > How do you propose to do that?
>=20
> something like
>=20
> xinput --set-prop --type=3Dfloat "TSC200X touchscreen" "Coordinate Transf=
ormation Matrix"  1.00 0.00 0.00  0.00 1.00 0.00  0.00 0.00 1.00
>=20
> but I think it is the default of X11 if you use no coordinate transformat=
ion at all.
> And having the kernel to properly scale from ADC values to screen coordin=
ates.
>=20

No. How do you propose doing rescaling in the kernel without loosing
precision?
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--EeQfGwPcQSOJBaQU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlio0KsACgkQMOfwapXb+vKsYACff6JGCY0zAbp5649bNBUcEY6L
vWEAoJFUan3+xi8HWWuWXl18BkBKTbzn
=kABD
-----END PGP SIGNATURE-----

--EeQfGwPcQSOJBaQU--

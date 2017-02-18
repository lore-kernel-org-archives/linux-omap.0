From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v9 1/8] drivers:input:tsc2007: add new common binding
 names, pre-calibration, flipping and rotation
Date: Sat, 18 Feb 2017 10:15:27 +0100
Message-ID: <20170218091526.GC8937@amd>
References: <cover.1482936802.git.hns@goldelico.com>
 <9830dd21e6425e3a866fac6ed4cc73ddd58b719f.1482936802.git.hns@goldelico.com>
 <20170128193342.GB38136@dtor-ws>
 <1F6355E1-A5E3-41A6-908F-619A15581BEF@goldelico.com>
 <20170217204041.GE13050@dtor-ws>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="3siQDZowHQqNOShm"
Return-path: <linux-input-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170217204041.GE13050@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "H. Nikolaus Schaller" <hns@goldelico.com>, Sebastian Reichel <sre@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Michael Welling <mwelling@ieee.org>, Mika =?iso-8859-1?Q?Penttil=E4?= <mika.penttila@nextfour.com>, Javier Martinez Canillas <javier@osg.samsung.com>, Igor Grinberg <grinberg@compulab.co.il>, "Andrew F. Davis" <afd@ti.com>, Mark Brown <broonie@kernel.org>, Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh+dt@kernel.org>, Alexander Stein <alexander.stein@systec-electronic.com>, Eric Engestrom <eric@engestrom.ch>, Hans de Goede <hdegoede@redhat.com>, Benjamin Tissoires <ben>
List-Id: linux-omap@vger.kernel.org


--3siQDZowHQqNOShm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > Well, there is some historic confusion wether this driver reports resis=
tance
> > or pressure.
> >=20
> > The unpatched tsc2007 driver does it wrong (please test!) and we fix it=
 on
> > the fly (because a separate patch is much more complex than doing it ri=
ght
> > immediately).
> >=20
> > This ti,report-resistance property is a means to get the old (wrong) me=
aning back
> > in case someone urgently needs it and can't fix the user-space workarou=
nd which
> > he must be using.
> >
> >=20
> > AFAIK there is no mainline board using the DT except ours (and the upco=
ming
> > OMAP5-Pyra), so we shouldn't care too much. If you prefer, you can remo=
ve this
> > compatibility property. We don't need it for our devices.

N900 is mainline and uses DT.

> > That the function name is wrong is a second issue and this double negat=
ion might
> > confuse a litte.
> >=20
> > Please test on a real device if the patched driver reports pressure now=
 (unless
> > ti,report-resistance is specified).
>=20
> I unfortunately can not test this driver as I do not have the hardware.
> So all my observations are from code and data sheets.
>=20
> That said, what is the values emitted as ABS_PRESSURE when finger is not
> touching the device, barely touching the device, or pressing firmly?
> It seems that between TSC2007, TSC2004, TSC2005, and ADS7846, we have
> confusion as to what is being reported.
>=20
> I am adding a few more folks to the CC so we can try and soft this out.
> Sebastian, Pali, Pavel, any input here?

X work ok on N900. Nikolaus wrote rather long email, but I'm not what
the meaning is and what is supposed to be broken there.

I do this on X startup:

xinput --set-prop --type=3Dfloat "TSC200X touchscreen" "Coordinate Transfor=
mation Matrix"  1.10 0.00 -0.05  0.00 1.18 -0.10  0.00 0.00 1.00
xinput --set-prop --type=3Dint "TSC200X touchscreen" "Evdev Axis Inversion"=
 0 1
xinput --set-prop --type=3Dfloat "TSC2005 touchscreen" "Coordinate Transfor=
mation Matrix"  1\
=2E10 0.00 -0.05  0.00 1.18 -0.10  0.00 0.00 1.00
xinput --set-prop --type=3Dint "TSC2005 touchscreen" "Evdev Axis Inversion"=
 0 1

And I agree that kernel should _not_ attempt rescaling itself, as it
would lose precision. Providing default calibration info is ok.

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--3siQDZowHQqNOShm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlioEK4ACgkQMOfwapXb+vKpyACfVORDGZIe8LFLqpcy4ViME8aF
za0An3DrjLBBeFbg4YG9+FIWuGTMguag
=4nCp
-----END PGP SIGNATURE-----

--3siQDZowHQqNOShm--

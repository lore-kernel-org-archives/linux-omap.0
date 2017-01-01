From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Nokia N900 sound driver and ECI GPIOs
Date: Sun, 1 Jan 2017 23:36:39 +0100
Message-ID: <20170101223639.GA13868@amd>
References: <201701012054.54505@pali>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="PEIAKu/WMn1b1Hv9"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201701012054.54505@pali>
Sender: linux-kernel-owner@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Jarkko Nikula <jarkko.nikula@bitmer.com>, Tony Lindgren <tony@atomide.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Eduardo Valentin <edubezval@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>, Aaro Koskinen <aaro.koskinen@iki.fi>, Nishanth Menon <nm@ti.com>, Sebastian Reichel <sre@kernel.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, joerg Reisenweber <joerg@openmoko.org>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> I'm looking at original Maemo N900 2.6.28 sound driver and GPIOs which
> controls A/V jack detection.
>=20
> For reference source code of that driver can be found e.g. at alsa-devel
> ML [1] [2] or in my linux-n900 git tree, branch v2.6.28-nokia [3].
>=20
> In that sound/soc/omap/rx51.c code is function rx51_set_eci_switches()
> which configures 2 gpios: RX51_ECI_SWITCH_1_GPIO =3D gpio 178 and
> RX51_ECI_SWITCH_2_GPIO =3D gpio 182 based on "eci mode" input parameter.
>=20
> But in mainline kernel code [4] [5] there is no information about gpio 178
> (as RX51_ECI_SWITCH_1_GPIO) and gpio 182 is called as just "eci-switch".
> More interesting part is that "eci-switch" gpio is not used in whole
> mainline code. It is just referenced in Nokia N900 DTS [4]. Looks like
> sound driver in mainline kernel is incomplete.
>=20
> Jarkko, you are listed as original author of that driver. Do you (or
> anybody else) remember what that rx51_set_eci_switches() function is
> doing? And what gpio 178 controls? I was even not able to find gpio 178
> in RX-51 Schematics [6].
>=20
> And do you know something about Nokia ECI headsets supports for Nokia
> N900. Looks like there is already some kernel code but support for ECI
> bus or multibuttons headset is missing.

What does "ECI" mean?

I'd like to get detection of headset button presses to work in recent
kernels, but could not figure it out :-(.

Are there multi-button headsets compatible with N900?

Best regards,
									Pavel


--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--PEIAKu/WMn1b1Hv9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlhphHcACgkQMOfwapXb+vLRVwCfVdUsGHxI5RL3iaziQW5A6uBn
C3EAoJiI6RTu+PNeE/S+6hkFmowVZC2i
=umkw
-----END PGP SIGNATURE-----

--PEIAKu/WMn1b1Hv9--

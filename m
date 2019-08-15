From: Pavel Machek <pavel@denx.de>
Subject: Re: [PATCHv2] USB: serial: option: Add Motorola modem UARTs
Date: Thu, 15 Aug 2019 11:49:22 +0200
Message-ID: <20190815094922.GB11427@amd>
References: <20190815082602.51765-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="rS8CxjVDS/+yyDmU"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190815082602.51765-1-tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Johan Hovold <johan@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, =?iso-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>, Dan Williams <dan.j.williams@intel.com>, Lars Melin <larsm17@gmail.com>, Marcel Partap <mpartap@gmx.net>, Merlijn Wajer <merlijn@wizzup.org>, Michael Scott <hashcode0f@gmail.com>, NeKit <nekit1000@gmail.com>, Sebastian Reichel <sre@kernel.org>
List-Id: linux-omap@vger.kernel.org


--rS8CxjVDS/+yyDmU
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu 2019-08-15 01:26:02, Tony Lindgren wrote:
> On Motorola Mapphone devices such as Droid 4 there are five USB ports
> that do not use the same layout as Gobi 1K/2K/etc devices listed in
> qcserial.c. So we should use qcaux.c or option.c as noted by
> Dan Williams <dan.j.williams@intel.com>.
>=20
> As the Motorola USB serial ports have an interrupt endpoint as shown
> with lsusb -v, we should use option.c instead of qcaux.c as pointed out
> by Johan Hovold <johan@kernel.org>.
>=20
> The ff/ff/ff interfaces seem to always be UARTs on Motorola devices.
> For the other interfaces, class 0x0a (CDC Data) should not in general
> be added as they are typically part of a multi-interface function as
> noted earlier by Bj=F8rn Mork <bjorn@mork.no>.

Acked-by: Pavel Machek <pavel@ucw.cz>
> Cc: Sebastian Reichel <sre@kernel.org>
> Tested-by: Pavel Machek <pavel@ucw.cz>
> Signed-off-by: Tony Lingren <tony@atomide.com>

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--rS8CxjVDS/+yyDmU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl1VKqIACgkQMOfwapXb+vJ+YwCeOiINkTCJCV7hE+8e3sPOiUW8
Y5QAoIYZz3Ln70nhSt3ikoVxqRegCq93
=k4Po
-----END PGP SIGNATURE-----

--rS8CxjVDS/+yyDmU--

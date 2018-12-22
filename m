From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 07/14] media: wl128x-radio: convert to platform device
Date: Sat, 22 Dec 2018 20:17:48 +0100
Message-ID: <20181222191747.GC9203@amd>
References: <20181221011752.25627-1-sre@kernel.org>
 <20181221011752.25627-8-sre@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="wxDdMuZNg1r63Hyj"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181221011752.25627-8-sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-bluetooth@vger.kernel.org, linux-media@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Sebastian Reichel <sebastian.reichel@collabora.com>
List-Id: linux-omap@vger.kernel.org


--wxDdMuZNg1r63Hyj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2018-12-21 02:17:45, Sebastian Reichel wrote:
> From: Sebastian Reichel <sebastian.reichel@collabora.com>
>=20
> This converts the wl128x FM radio module into a platform device.
> It's a preparation for using it from hci_ll Bluetooth driver instead
> of TI_ST.
>=20
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Acked-by: Pavel Machek <pavel@ucw.cz>

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--wxDdMuZNg1r63Hyj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlwejdsACgkQMOfwapXb+vLhCwCfSqcxpD/SphSBqw4XIF0tmSHz
hKcAoKY0aajgBSIlFCHu1S/NU0BWir5E
=kcYT
-----END PGP SIGNATURE-----

--wxDdMuZNg1r63Hyj--

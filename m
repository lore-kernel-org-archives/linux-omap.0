From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 05/14] media: wl128x-radio: remove global
 radio_disconnected
Date: Sat, 22 Dec 2018 20:10:49 +0100
Message-ID: <20181222191049.GA9203@amd>
References: <20181221011752.25627-1-sre@kernel.org>
 <20181221011752.25627-6-sre@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="jRHKVT23PllUwdXP"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181221011752.25627-6-sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-bluetooth@vger.kernel.org, linux-media@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Sebastian Reichel <sebastian.reichel@collabora.com>
List-Id: linux-omap@vger.kernel.org


--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2018-12-21 02:17:43, Sebastian Reichel wrote:
> From: Sebastian Reichel <sebastian.reichel@collabora.com>
>=20
> Move global radio_disconnected into device structure to
> prepare converting this driver into a normal platform
> device driver supporting multiple instances.
>=20
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Acked-by: Pavel Machek <pavel@ucw.cz>

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--jRHKVT23PllUwdXP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlwejDkACgkQMOfwapXb+vJBQgCdEsNKIPHRE0ATb/tUDCdeynP0
xp4AoKz8uyM6NcsropZ0eUaYpd48GLD1
=0LUz
-----END PGP SIGNATURE-----

--jRHKVT23PllUwdXP--

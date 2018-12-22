From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 08/14] media: wl128x-radio: use device managed memory
 allocation
Date: Sat, 22 Dec 2018 20:20:19 +0100
Message-ID: <20181222192019.GD9203@amd>
References: <20181221011752.25627-1-sre@kernel.org>
 <20181221011752.25627-9-sre@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="Q0rSlbzrZN6k9QnT"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181221011752.25627-9-sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-bluetooth@vger.kernel.org, linux-media@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Sebastian Reichel <sebastian.reichel@collabora.com>
List-Id: linux-omap@vger.kernel.org


--Q0rSlbzrZN6k9QnT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2018-12-21 02:17:46, Sebastian Reichel wrote:
> From: Sebastian Reichel <sebastian.reichel@collabora.com>
>=20
> This simplifies memory allocation and removes a few useless
> errors in case of -ENOMEM errors.
>=20
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Acked-by: Pavel Machek <pavel@ucw.cz>

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--Q0rSlbzrZN6k9QnT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlwejnIACgkQMOfwapXb+vLGvACfYzeXCaKcJBlVmoVZ7HUTXhRs
M0QAn3qMNcX2QTXmaZPpnoPGPtJyvS5E
=mLNB
-----END PGP SIGNATURE-----

--Q0rSlbzrZN6k9QnT--

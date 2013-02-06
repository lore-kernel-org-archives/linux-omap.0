From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] ARM: OMAP: Clear GPMC bits when applying new setting
Date: Wed, 6 Feb 2013 16:32:17 +0200
Message-ID: <20130206143217.GB6773@arwen.pp.htv.fi>
References: <51126586.9030308@mimc.co.uk>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5I6of5zJg18YgZEa"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:35466 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751294Ab3BFOcY (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 6 Feb 2013 09:32:24 -0500
Content-Disposition: inline
In-Reply-To: <51126586.9030308@mimc.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Jackson <mpfj-list@mimc.co.uk>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

--5I6of5zJg18YgZEa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 06, 2013 at 02:15:34PM +0000, Mark Jackson wrote:
> When setting the GPMC device type, make sure any previous
> bits are cleared down, before applying the new setting.
>=20
> Signed-off-by: Mark Jackson <mpfj@newflow.co.uk>

looks alright:

Reviewed-of-by: Felipe Balbi <balbi@ti.com>

--=20
balbi

--5I6of5zJg18YgZEa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJREmlxAAoJEIaOsuA1yqREMBQP/0oqvJ6OzRiD8yQOM6RKeroI
+TH1TORqgD1RzFYwte7faZdin+ZOFa3RHbVa+XJcri3MyBf5apsbo91yxRUlGrJs
g6cLkjp5eH2wid8282vGKLERdbh6hJxCAD0lMoogmlOWlVQg7KJff8Fvt2XrZVtj
tf4EZLnoEZdN74wS8GGzE8wmLq/skeQHo9RyVp5lHxsxdedMh9R+GohNPcw3T6cP
t4ya0y/dwfINZgJKGcCRVhSy9EtGgDSAj8uP2kK03Dl1jgtD9+aZl5q1IrmGjN0a
BqUwRvbTh4oe+zrTYoMnAw/wv4Wczv/CBNEp5HZrt0QCokc6F8041bKkt3u492BY
O5dABMjpC6+NBMNLjsf3FCyNo8yhmm3vaiA5QKh4k8EJwdBJbg1uKKlWj2eidYqK
GvJjXFkydgJz88O4pr0k7tH8VALhpAOv4oOCbbhnV4Mg13zrddwRu/WQal9yhGTt
iDsxwM51AQfO3flOq7n40fYci57nvMJTte0ak3Nb1xiWEbBBJc7XTOrSxyON33sh
h/CMpDCkeau0Li5T857z/U0ordqF+5EDAe9298jE5zR/mu/GNqZzaUcNVcUm9AKM
dvxNDNEV44+gmL5oETa9NeIit2h7jb/uZVVPqjY5KYEr0MJGABXwu+h4GV177Mbr
nb29Zqs3tXtH4oHqwnzy
=aYtr
-----END PGP SIGNATURE-----

--5I6of5zJg18YgZEa--

From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 2/6] gpio/omap: remove saved_wakeup field from struct
 gpio_bank
Date: Thu, 23 Feb 2012 14:28:46 +0200
Message-ID: <20120223122846.GF18463@legolas.emea.dhcp.ti.com>
References: <1329999031-6914-1-git-send-email-tarun.kanti@ti.com>
 <1329999031-6914-3-git-send-email-tarun.kanti@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MFsiPQgyXjZUSlqD"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1329999031-6914-3-git-send-email-tarun.kanti@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, grant.likely@secretlab.ca, khilman@ti.com, tony@atomide.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org


--MFsiPQgyXjZUSlqD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 23, 2012 at 05:40:27PM +0530, Tarun Kanti DebBarma wrote:
> There is no more need to have saved_wakeup. Instead we can use
> context.wake_en which holds the current wakeup enable register
> context. This also means that the read from wakeup enable register
> is not needed.
>=20
> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>

Likewise:

Acked-by: Felipe Balbi <balbi@ti.com>

--=20
balbi

--MFsiPQgyXjZUSlqD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPRjD9AAoJEIaOsuA1yqREQ20P/jZOwLQOcuhpqkNF+pBXfBah
2xIvQ5r9/jUWnZ5Fowjv8g1FaeCOARjeKZYVar7Xd17pnbD/O4mj3r5G9OZO40hK
Ftxqhif6zAKx8ME/qSquiBFO8kh8ytFl7Jfkf1FE/S07GaKH4Ig/8GKupK560qO5
uonaTyu4t9DIFfFi+lGI5K5/S3tLxrhRg+DmR81V3yWiHbVuD1l2ktS43fQ5yeRE
m4X3+edE7dUF61UVVcIFSO+XQQJC5oPO8xCijYzTs0KvUJC4uvjCsbmpo/DhjxyT
ORpil7KXHOEvphLttJBXqGwmsxB75tVkp0h96//467AWtv19Z6zb9dOguZk3EOlu
0YaJznHgqRQVNO1dVlpG+2LqgJJtgU32uerZmhfeMTA/pwRHJfzoELbozsRXjdB7
YYH6S2++Bj1fwU3eiAe1LSAlKDZ8Vq0iQm47ST2mlYqZiyMcZ4Q/W8gbaBzDij82
7UvoGP9S61tH2Yfg9ndZm2n1+SHzuBs7oC6Aef9GTd1329sFBSq/x94Nq4ofJ/p6
z26r5EMe16KK1cK3GHsIxQkOXwhn91ynjtRFPZ+UfgazP2C4gPYZnKbRz8nIx4fO
FSxj5JhRj3uhRrV3G6BfS433zDbvK5lQTaiX0sxGHPcmZAAx/CGazRYC7TkRKiJr
ioFMzzWmpukzpJZhuDTg
=hlK3
-----END PGP SIGNATURE-----

--MFsiPQgyXjZUSlqD--

From: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org
Subject: Re: [PATCH v4] i2c: omap: Add calls for pinctrl state select
Date: Tue, 12 May 2015 17:47:37 +0200
Message-ID: <20150512154737.GA4448@schokonusskuchen.bad>
References: <1430917624-18164-1-git-send-email-pascal.huerst@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bg08WKrSYDhXBjb5"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1430917624-18164-1-git-send-email-pascal.huerst-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: pascal.huerst-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 06, 2015 at 03:07:04PM +0200, pascal.huerst-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org wrote:
> From: Pascal Huerst <pascal.huerst-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>=20
> This adds calls to pinctrl subsystem in order to switch pin states
> on suspend/resume if you provide a "sleep" state in DT.
>=20
> If no "sleep" state is provided in the DT, these calls turn
> to NOPs, so we don't need error checking here.
>=20
> Signed-off-by: Pascal Huerst <pascal.huerst-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Reviewed-by: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>

Applied to for-next, thanks!

The mail header does not contain your full name, you might want to fix
that...


--bg08WKrSYDhXBjb5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJVUiCZAAoJEBQN5MwUoCm2x0IP/j+TkTsbGeRa0PArOZuQpnMD
Re5qUdKXGGJpgFtbimu1KQz3hbhmjf1pIWcL04uv36dOVdvIy3CLM2tY/L45JoG7
RzApHWf2xyCmTOKzOiaUFeLkEqmqtMeR/BjY3oSKXiDz9VsUZeNqa/Fy1nC+i733
h8Py0JjEqPprQv+tmGy3bn/agPjllC7yLyO+O5kfmLlibLIO7EsfgXvjYf7Qy4pu
kh09EoaHpXiQbHUXIjf4fGwE/o/B1FfuS/76bm4c06O7fbXUqmraEHogz12ZI7Oz
UDTGHRC8KeK9lafeDDAemch3pgNOLn3e/1qNeBkgVR41NH42zinIwgKttg3B4qJ9
omKXTGoA3Stthei3dm8RerH3lh8YK7PV2pECgobqo+iTWQo4YS4xL2Ek/dzQJmHY
ZRvbEpKj+qLnHqL3rM9QQmbA20OjeVYWv7zy48t4rt3vBeQ0cu87de4Pv+7DzCS9
lwoJYBi+qy8R1wngQTzqPj3n6DjO4S0yDDtiClaw/yFjuP8+xIEwVXT2ZonqlkGI
76UQjCrHieVf06+enQc4lDL7wOygHuWccrn5k9EU/70HXHaMbGY6ijlUNb5cxUB7
jYldi529PvvgD3nI4LmDpQar1M4tRua1GFpHPPj/aeQRiRCYmV87J6ikktquRFy0
A54Bql4RLJ0VxeKOmhex
=ccbg
-----END PGP SIGNATURE-----

--bg08WKrSYDhXBjb5--

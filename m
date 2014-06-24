From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] regulator: palmas: fix typo in enable_reg calculation
Date: Tue, 24 Jun 2014 12:01:36 +0100
Message-ID: <20140624110136.GJ23300@sirena.org.uk>
References: <1403556805-22824-1-git-send-email-swarren@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Z8yxTSU1mh2gsre7"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1403556805-22824-1-git-send-email-swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Cc: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Alex Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--Z8yxTSU1mh2gsre7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 23, 2014 at 02:53:25PM -0600, Stephen Warren wrote:
> From: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
>=20
> When setting up .enable_reg for an SMPS regulator, presumably we should
> call PALMAS_BASE_TO_REG(PALMAS_SMPS_BASE, ...) rather than using
> LDO_BASE. This change makes the LCD panel and HDMI work again on the
> NVIDIA Dalmore board anyway.

Applied, thanks.

--Z8yxTSU1mh2gsre7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTqVqNAAoJELSic+t+oim9WA4P/iiRFO2DcyLsf2kXeve75xXW
RA4TyjYs0oLnpYymayeEnfXT/w6Hm2moTJGGuk81MxQRauTHaFKc1DwSRaXK/JMg
WBfytAkTezbsOc8mvAiaRixlvRdGyg4jvbi2Y9gMWa6eJn9pMxtRCTwxsbLecnWJ
ws6zO9pDQkM4ien10rpkaE+KZlJYWMFa2tEn3KT7gJhfO5RWJ9A7fIl9VW4DneAD
0dNH8ujcC/LnuCLxnzLo6urrRCZkItjJe+oVsy9FKEMeGzTWRKtfDiviJBJirvxh
+jHiIkoVGknArfg0el904a6ZNnBx26kM3cFk6Ee8Wp67dzaoDYbRNrEuYk0SJMn0
6Pc+9rjyNB68QEacxstgwYXHJFPMmO1LHX6xKhA50MoEoah7dHONx9Kolmr5jwu5
hZ9qLE3TiWUal+N1sji26sX3aLrw6ZQYjSY8ij/kQ3jV4RuVke5p3/hfqHFgS0cF
mZu2oRfT4+vw3oVlAO3e24mpwGzx/AVsUoyG34HImlFrxpHmGtM3/MS8myRmL1vl
nnWcCR4GSjQ3AHJvP8zvXgr0HStcfdBKxKzeIdQqzm00GaAZLLUx8AHGsJQEoPNc
D6MUZj31aurA1ZuZQ5BIFD4ugBktXh/3l0y2ise/b8WTma4ZCRjJKVqz9HJ54fBD
SuRoXZqfJlIsNv1F7HeU
=Ef3O
-----END PGP SIGNATURE-----

--Z8yxTSU1mh2gsre7--

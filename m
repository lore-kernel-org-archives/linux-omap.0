From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 2/5] OMAPFB: simplify locking
Date: Thu, 13 Dec 2012 13:17:17 +0200
Message-ID: <50C9B93D.3020601@ti.com>
References: <1354881309-17625-1-git-send-email-tomi.valkeinen@ti.com> <1354881309-17625-2-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigDF4604781B1EA6A4BF396589"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:50758 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753337Ab2LMLRU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Dec 2012 06:17:20 -0500
In-Reply-To: <1354881309-17625-2-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>

--------------enigDF4604781B1EA6A4BF396589
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 2012-12-07 13:55, Tomi Valkeinen wrote:
> Kernel lock verification code has lately detected possible circular
> locking in omapfb. The exact problem is unclear, but omapfb's current
> locking seems to be overly complex.
>=20
> This patch simplifies the locking in the following ways:
>=20
> - Remove explicit omapfb mem region locking. I couldn't figure out the
>   need for this, as long as we take care to take omapfb lock.
>=20
> - Get omapfb lock always, even if the operation is possibly only relate=
d
>   to one fb_info. Better safe than sorry, and normally there's only one=

>   user for the fb so this shouldn't matter.
>=20
> - Make sure fb_info lock is taken first, then omapfb lock.
>=20
> With this patch the warnings about possible circular locking does not
> happen anymore.

I'm dropping this patch, for some reason it causes huge latencies with
two processes using separate fbs. I guess there's need for the more
precise locking, after all.

 Tomi



--------------enigDF4604781B1EA6A4BF396589
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJQybk9AAoJEPo9qoy8lh715cgP/1jNDA2HFPrBAadV1lOQjtbe
wyvp/bCN5wH3OY4yrOI2A/bNL/3dV9wY6s81FQt9awqNCGX6xRjmHi+qvr8JQRia
vXEz0fakPUPQz0ybXiUuT/37UkVgQjoakdmgRYfvs1nBXv5MT8XgFo2BlJrI9pfP
KVzTY1QF1BDOm7P69DaCLhH3TZUJNZ9p6Zv6HnZ/rwMfOGYcL12fiHo9VcCeAxqP
Fuzi4sAHTblJKAbS/yviW+8hRB7jRP1ardaT8YVd6ORsr38kOdtXQA0yzGS7c2Kf
z6A/qsBIy0POTvL0kSm6UnAYmbowqzv4TgdXrA4CvoWLZ83gEp6cdKkZqqef+GUS
9WXMj41CR/j3LPvDS5I3HoX4YNRZL32E4zljPOUr2gL37gkFOKu21pQ40mJVJKxD
wFkN5vZum5+vhXzPyUNUI/HPfah38jO6EpisZA+YN0xdpCXJ/fdRxK9No5j1gKiG
JWcGPY0o4CJlYg4zKgJK79A111iGoZyQZoG8JJajH4LEni3ws5vqGMR41hsQ3/E6
rTS0AaQ0aUHv1cV0g6y1z/gvxXaBsp/paCZPadZXYzlwmjVL+clPOgk0UIJAjvCD
MBbFM1pLVgmg6az1z12GMDmnDZZiYuC+XcKfkABILB7+4JCikeXIG4BCErRwM9cu
yWJGzLTKrghKU7/p/9JW
=30ny
-----END PGP SIGNATURE-----

--------------enigDF4604781B1EA6A4BF396589--

From: Sebastian Reichel <sre@debian.org>
Subject: Re: RX-51: Platform support for lp5523
Date: Tue, 29 Mar 2011 20:16:15 +0200
Message-ID: <20110329181615.GA20371@earth.universe>
References: <20110329172922.GA19494@earth.universe>
 <20110329173647.GK4016@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ew6BAiZeqk4r7MaW"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comu.ring0.de ([46.4.151.82]:40223 "EHLO smtp.ring0.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751459Ab1C2SQR (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 29 Mar 2011 14:16:17 -0400
Content-Disposition: inline
In-Reply-To: <20110329173647.GK4016@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Ameya Palande <ameya.palande@nokia.com>


--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 29, 2011 at 10:36:47AM -0700, Tony Lindgren wrote:
> * Sebastian Reichel <sre@debian.org> [110329 10:26]:
> > Is there any reason, that the rx51 platform code does not support
> > the lp5523 chip? The chip driver itself is in the mainline kernel
> > since 2.6.37-rc2.
>=20
> Got a patch for that? As always, patches related to blinking leds
> have a special high priority here! :)

Ameya Palande has written one, which is available at [0]. I added
him to CC, so that he can comment on mainline inclusion.

[0] http://gitorious.org/nokia-n900-kernel/nokia-n900-kernel/commit/54caed7=
bdc7e9f5aa84fe50f3bc321fc1ef600ad?format=3Dpatch

-- Sebastian

--ew6BAiZeqk4r7MaW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBCAAGBQJNkiHvAAoJENju1/PIO/qaNnAP/jjRaho9fHK5b5aQXhqBUHVh
g5YQBPxq8Owo0gATtd8qXP86VL2XvBrEEhT3gKVZ8AWhAwTAKer5jtuqfq5L4zcE
TZMP95i2id4i+I+NOpLaBPjZ46WX/JT8TkzIWF0ZGJWyCpiEj9v3qhktU47mB7cx
gN+PP1KTnbppTkWQfc5tJQodNyomGlxUoalvmO4sYeBmC1bT6emnzqUZ5IckT3To
nJvL08QU4rbhxFv7tyL9hRI0XQmJiqItWTn0vC0bnWXOP+/pu/WS8PgTiBEAZFWw
6xXvTAx4/TQJBw4zppjDi35thkMFfv81NbR0DDL+O6mU3ymY13F4wKlbjI7YokOA
XuZIbtHdGAoHPpD9e0MQRiA8GqYDzZrj8Zj5zxFTv6WQl8Rt/kXGwoL4zbLyk3Dn
6kM+LkcCElzrf0zqsXUGv1+xxMfWlb6VYF9cC1WTLtcIizSvdY/3+/pvsIOnRJN9
GzHgDZsHFJwg/JSJOyE/FabBBSbfwFr0VgB2DyUwB7pWngJDnHNyCP+NyQph4VKW
8Bo0V4+u7KTNe7mMzSElHJycwzUKzqKLfC2suD4O8pU8dzNN86YFA34BVT64jvPs
w042vnNYpMbNKq83aUcv7ubtb1AHGSeWoYYpb+IkqPxplGwgEOaugqcIO9032NFa
bLpeBzPS+2MnuG8DdXbG
=cXnp
-----END PGP SIGNATURE-----

--ew6BAiZeqk4r7MaW--

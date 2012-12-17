From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 1/2] ARM: OMAP: Split vrfb.c to remove last remaining
 cpu_is_omap usage
Date: Mon, 17 Dec 2012 11:31:08 +0200
Message-ID: <50CEE65C.20009@ti.com>
References: <20121216200236.24238.38151.stgit@muffinssi.local> <20121216200314.24238.9481.stgit@muffinssi.local>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigB56BBD1ABECD6102E0185456"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:44379 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751682Ab2LQJbQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 17 Dec 2012 04:31:16 -0500
In-Reply-To: <20121216200314.24238.9481.stgit@muffinssi.local>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

--------------enigB56BBD1ABECD6102E0185456
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 2012-12-16 22:03, Tony Lindgren wrote:
> Looks like we missed plat-omap/fb.c for cpu_is_omap usage
> mach-omap2. This is the last user of cpu_is_omap, so let's
> quickly fix it up so we can finally remove plat/cpu.h for
> omap2lus.
>=20
> We want to limit cpu_is_omap macro usage to mach-omap2 only so
> we can make plat/cpu.h private. After this we can finally drop
> plat/cpu.h for omap2+.
>=20
> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  arch/arm/mach-omap1/Makefile |    2 +
>  arch/arm/mach-omap1/fb.c     |   80 ++++++++++++++++++++++++++++++++++=
++++++++
>  arch/arm/mach-omap2/Makefile |    2 +
>  arch/arm/mach-omap2/fb.c     |   50 +-------------------------
>  arch/arm/plat-omap/Makefile  |    2 +
>  5 files changed, 85 insertions(+), 51 deletions(-)
>  create mode 100644 arch/arm/mach-omap1/fb.c
>  rename arch/arm/{plat-omap/fb.c =3D> mach-omap2/fb.c} (76%)

Ok, I didn't realize that plat-omap cannot refer to cpu_is_omap either.
The patch looks fine, except the subject should say "split fb.c", not
"split vrfb.c".

 Tomi



--------------enigB56BBD1ABECD6102E0185456
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJQzuZcAAoJEPo9qoy8lh71bpYP/jeWcsZRcdObv7q+C4Krl+wq
NBUggw9EJyyXhyKoZtN69BDQVyUNEN7w6UU2W5pgEBk13ffXwfHPhcyRifuOaYNY
oZ1aPhuUed6RzEL6Y8lmCjoQ3zj3tgXmwdB53ajx1p5ZiFJ4KM910h6Rk5BswXbY
NGFabvIYvzVn436aH5ErIbQ3eQEa6L5AcvrRI9lL59X6k/XJbMGvkHO4wPnw4eFW
lkTNM4JrSjq5HJuhXlqLfIVab3iZabvH5GRy8xNKKf2zosY7zqPsD/N6WQTdxM9D
SP/C9H/H02EH4Ods7xXh03IBLVd8/EHtA4QD2GizbeA8oImJxA1fKD7t6cKJ34dy
aaOP8kT84ASDXRvTZ7nMFBPWnX9s54pyg0Q3bac/Olw2NG1PztkaDBcd21eyPUhn
iObksV51k8NeHm8O/nU/hKAMJNqUkLOiLPKryUD4XdhURRcV2fZTEuBLf115UC4p
Cib0f2/VUR8/R5DnA5sWTzjDbB5LpYnYZsjSe+G/luavA7COZZlPYV71uhBYwkKr
RGmhpHW/HBPTJC9Af4JLjwPKG4g9tQt985J74hVGh6zLGvNdApBeIluNV3TFKvr3
xHAJll7Gsmk8WdH8dEeYrG8MEjSw61sy//J3w2GDPL+gPhPjDQATehsMEXOAMoKW
MqYV1pgJy3qQMVvoZuKi
=45LG
-----END PGP SIGNATURE-----

--------------enigB56BBD1ABECD6102E0185456--

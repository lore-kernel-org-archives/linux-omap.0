From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] ARM: multi_v7: Enabled omap4430 sdp nfsroot
Date: Mon, 15 Jul 2013 16:23:26 +0300
Message-ID: <20130715132326.GA12025@arwen.pp.htv.fi>
References: <20130715075816.GN7656@atomide.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zYM0uCDKw75PZbzx"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:45862 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756480Ab3GONYW (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 15 Jul 2013 09:24:22 -0400
Content-Disposition: inline
In-Reply-To: <20130715075816.GN7656@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>

--zYM0uCDKw75PZbzx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 15, 2013 at 12:58:17AM -0700, Tony Lindgren wrote:
> Author: Tony Lindgren <tony@atomide.com>
> Date:   Mon Jul 15 00:39:41 2013 -0700
>=20
>     ARM: multi_v7: Enabled omap4430 sdp nfsroot
>    =20
>     By adding support for OCP2SCP, SPI and KS8851 I can also boot test
>     multi_v7_defconfig easily.
>    =20
>     Note that if using an older u-boot, CONFIG_ARM_ATAG_DTB_COMPAT=3Dy
>     may also be needed for the appended DTB based booting.
>    =20
>     Signed-off-by: Tony Lindgren <tony@atomide.com>

We will also use OCP2SCP driver to enable USB3 on OMAP5 uEVM, good it's
already enabled in multi_v7 after this patch.

Reviewed-by: Felipe Balbi <balbi@ti.com>

--=20
balbi

--zYM0uCDKw75PZbzx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJR4/fOAAoJEIaOsuA1yqRE4rQP/3nFvxbfkGFgJtf8puP3j+8n
g+r5J++k0tnq/xc2adZnUj3DDpzy6Hq+LFwoGDYhsLE4LWCyEqnk503XvYL3dKxx
iqQfIDWbVJekEIJI644cLLbb+FIDfrIsqhlQNPRLS+rEH5JdOtirS5ail/f5okHU
QaBTIKsJ9Xbjok7nkpZfnJaG6hPOIeJNmKL1usLjLzSoCZYl2S1sDsSJ3kBc2aJT
X0DRZyBmBZBm02gunejYuIR1wRBbiihL8L30ZK8iHfqsrNMjw3cYPSWvGLcx8+pt
O7hAsyYEO9p9QTwv3LHZLtprlutTUuLzpsB1oKK+J7JGQnf8eb8c4ikStodz6H2w
+PTud7CCvN3GfCzqtsl9lBby2Gsfe/an9LyNIlDWhk5XerV24IJeqeVopG6H4E60
zWdNbqhiI+FJ232hx//fw4kRpvh+n8h6ZeWyWQto1EIT5ry60h3tneoM5Tdkio3F
oMWH8x6NPrCTcrti+GGGp8R11osqRvFKWFXQHA4QWyu8h6EGj5uZSU18zQ10TtqG
1VCnsy3SqN56e8Q7CS5jWGPVec/lRuZQfPwZte1ZaWPtFDrUQ8bUKNXN2AGaLFlk
iymleTld2i0tw9CSkW25LaDfBM9IDCzpU+foqNO4lB9rfcsYnhGi+2ZfOYgreI90
Ii+syoULD7cT+NQFRqeQ
=CcSz
-----END PGP SIGNATURE-----

--zYM0uCDKw75PZbzx--

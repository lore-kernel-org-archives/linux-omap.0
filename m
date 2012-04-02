From: Artem Bityutskiy <dedekind1@gmail.com>
Subject: Re: [PATCH 0/5] mtd: plat_nand: Add default partition parser and
 use it
Date: Mon, 02 Apr 2012 14:08:45 +0300
Message-ID: <1333364925.5440.104.camel@sauron.fi.intel.com>
References: <201203281112.48788.hartleys@visionengravers.com>
Reply-To: dedekind1@gmail.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-tYG+VEjJEvHHNxPyqYt8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201203281112.48788.hartleys@visionengravers.com>
Sender: linux-kernel-owner@vger.kernel.org
To: H Hartley Sweeten <hartleys@visionengravers.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, linux-mtd@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, uclinux-dist-devel@blackfin.uclinux.org, linux-sh@vger.kernel.org, linux-mips@linux-mips.org
List-Id: linux-omap@vger.kernel.org


--=-tYG+VEjJEvHHNxPyqYt8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2012-03-28 at 11:12 -0700, H Hartley Sweeten wrote:
> This patch series adds cmdlinepart as the default partition parser for th=
e
> plat_nand driver and updates all the arch setup code to use it.
>=20
> Arch setup code that requires other partition parsers can still pass that
> information as chip.part_probe_types.
>=20
> Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>

Pushed the series to l2-mtd.git, thanks!

--=20
Best Regards,
Artem Bityutskiy

--=-tYG+VEjJEvHHNxPyqYt8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAABAgAGBQJPeYi9AAoJECmIfjd9wqK01TkQAMewuEX1gPp1EPSpGZQcSvXs
jsTvmYqJE6vhHRv8KlbN+bfz5Gjh4xsUyz63/QqILHv8ru3R3MypineF9tGlV+k+
fvWdcmMuXQ4VmkfsIKQIQ4Y51wWJG91J4QG5Va/Epk7yXzyvskINWN3YWKp0J0Mk
zePW7mBxEZFFRr45/sTK7Wx3Us8FU3NEV71cbXWjjw+AosLc4G92dIDXEie7BTUn
OqS2+oRbNyigsDSb9WPTAu4O9Ln5p7F99elipFtBP/OGuSVK9Q92ImUwPB6FJf6E
+rZs/PiYrfMxkyCUsIw/4FVT49PbRusDsVSKzIrTxzzZ/mjb6ANx3gRJBqDXNyvH
hdhzlacV4H4Id60jIuDeAocI95v39MPX5oQ075P4dNBDd06og9K0RGXvpFPXrVy5
ZUwfws9ltOEy1oo4Mg8FpJ6j2OWTK/9xc0jFHcLB8WrQ669W9ScM+xQNpki1eaJk
u5qPSAYr7mod3RLahiPytspkqGdXdtdK256ceUZ0c2u/Bc18mEtq27flRVA3/tc5
OiWFAS+8d/qCR8evTAn5PSJoGmZk0ZAldcoZ2IRimwEuz8aXZjdX0pkezc8yhulV
INJBhHNlei00Rop7Gq851ob32uUQrUO5DiPyhF/4WwIxMfeTQ3PsYjEI+j3IzfEF
DyRHjIGr/NVucPumONWe
=pJwc
-----END PGP SIGNATURE-----

--=-tYG+VEjJEvHHNxPyqYt8--

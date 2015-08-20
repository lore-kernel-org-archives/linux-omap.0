From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] Drop owner assignment from i2c_driver (and platform left-overs)
Date: Thu, 20 Aug 2015 11:07:30 +0300
Message-ID: <55D58AC2.3010907@ti.com>
References: <1436510250-5633-1-git-send-email-k.kozlowski@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="DJKdPW7ts0P1Vl0GWtx71H0AqrlcgUqQ3"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1436510250-5633-1-git-send-email-k.kozlowski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--DJKdPW7ts0P1Vl0GWtx71H0AqrlcgUqQ3
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable



On 10/07/15 09:37, Krzysztof Kozlowski wrote:
> Hi,
>=20
>=20
> The i2c drivers also do not have to set 'owner' field because
> i2c_register_driver() will do it instead.
>=20
> 'owner' is removed from i2c drivers, which I was able to compile
> with allyesconfig (arm, arm64, i386, x86_64, ppc64).
> Only compile-tested.
>=20
> The coccinelle script which generated the patch was sent here:
> http://www.spinics.net/lists/kernel/msg2029903.html
>=20
>=20
> Best regards,
> Krzysztof
>=20
>=20
> Krzysztof Kozlowski (2):
>   video: fbdev: Drop owner assignment from i2c_driver
>   video: fbdev: Drop owner assignment from platform_driver
>=20
>  drivers/video/fbdev/omap2/displays-new/encoder-opa362.c | 1 -
>  drivers/video/fbdev/ssd1307fb.c                         | 1 -
>  2 files changed, 2 deletions(-)
>=20

Thanks, queued for 4.3.

 Tomi


--DJKdPW7ts0P1Vl0GWtx71H0AqrlcgUqQ3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJV1YrCAAoJEPo9qoy8lh71onkP/iK+mF7DpFBWVx8IgPjmde/l
8uJjLSIfDSe0uD+5ERorSUn4hRjOAWhwbCMl4+9+PnXhbiVuG96iNuBObtEHkV9E
Gq+Njrh/ygiUnIHQAA1XTcklwwYYv4jLGXyPMSiHvTtbSd/JLM5dAZi5MGiFOnqK
nWorak/eFMu9kxOTYxcv9i6JR2o3XCvacbs9/hVwBt4Dsk1u+VMgi4AiCYH2esaZ
h0C8Hb93jYgcK2lOqNd/KVZWy5FPMEliWQU3Ib/+i/p9/oaVpPI8+XvrWkTGXn4v
6CjcrRDI6yQcsST0gIz+5a3T8RbXXG3LOTuENtAU34GvGReddJueL/sz/3TyD4lN
LHTHoxmD1qs73r3McXpjB6ktxei3DujuEMhL/MM/GtUSLfkZQW1dQ43W4sx5qkHr
Zqdg/y1NKNc99hfwlbhqdPcfEk1GB1gPrchuL034ucv+9hrecZIS9Zyr76Qc9bDS
nxClcFyaGqdCeG3oTwu9+6882VshMRu2mNpEvUlj3L+LWIX+JyY9aWES7sZ822KB
hvr7e8rUYmVJde7fOgKg7nGFi9RI+iXv55X7usHfL29z5DKIncaa1HeQEogJCwPe
ZYr7NQi8ljuLmIdlQ3r5fmfVL/78c00Y0srCvt6Vi39bvdQn1VUHq2NCV6yj1kCC
TQZbc66DJ9J/EyuasdDK
=u8Q9
-----END PGP SIGNATURE-----

--DJKdPW7ts0P1Vl0GWtx71H0AqrlcgUqQ3--

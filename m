From: Mark Brown <broonie@kernel.org>
Subject: Re: [RESEND PATCH v2 3/3] regulator: lp87565: Add 4-phase lp87561
 regulator support
Date: Thu, 13 Jun 2019 16:45:52 +0100
Message-ID: <20190613154552.GL5316@sirena.org.uk>
References: <20190612144620.28331-1-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="GeDkoc8jIzHasOdk"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190612144620.28331-1-j-keerthy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>
Cc: lee.jones@linaro.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, t-kristo@ti.com
List-Id: linux-omap@vger.kernel.org


--GeDkoc8jIzHasOdk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 12, 2019 at 08:16:20PM +0530, Keerthy wrote:

> patches 1/3 2/3 are already applied to linux-next.

This doesn't build without those patches:

  CC      drivers/regulator/lp87565-regulator.o
drivers/regulator/lp87565-regulator.c:156:32: error: =E2=80=98LP87565_BUCK_=
3210=E2=80=99 undeclared here (not in a function); did you mean =E2=80=98LP=
87565_BUCK_10=E2=80=99?
  LP87565_REGULATOR("BUCK3210", LP87565_BUCK_3210, "buck3210",
                                ^~~~~~~~~~~~~~~~~

--GeDkoc8jIzHasOdk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl0Cb68ACgkQJNaLcl1U
h9AUbgf6A+P+h4sdG/p+dyYpkKGR3cquJxOVi7Exm40YbqYaCWO0HY5QzQFIuW7J
gp1fNPT0jE9eSpfZFBDHxSJjBVsaQMBDLa5lxjZoxjR1s+TBCsb1KvZkNeUmqaq+
MFsy4b4R21CFzZa29LUKVF6d+OP8dror7J4Nrs+XS0qk9B2woSuvtH5XoNQ7blD6
cL6ibkfEWpaL/LZYpjbAHWdyUD9/xMPBd+3LR6N+FnsqcxdGsC/vExczha6DgWHo
8vEX3Upy/jAph3CAcBWTx6qmWmroonea5tLg02jqAha/Un+uvVRSSwsOQYiTxqm7
9ua7ffTjwmyDRxOFrLLz4b0Sb6GeIw==
=jcCU
-----END PGP SIGNATURE-----

--GeDkoc8jIzHasOdk--

From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/3] regulator: lp87565: Add 4-phase lp87561 regulator
 support
Date: Wed, 15 May 2019 12:08:51 +0100
Message-ID: <20190515110851.GD5613@sirena.org.uk>
References: <20190515100848.19560-1-j-keerthy@ti.com>
 <20190515100848.19560-4-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="q9KOos5vDmpwPx9o"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190515100848.19560-4-j-keerthy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>
Cc: lee.jones@linaro.org, robh+dt@kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, t-kristo@ti.com
List-Id: linux-omap@vger.kernel.org


--q9KOos5vDmpwPx9o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 15, 2019 at 03:38:48PM +0530, Keerthy wrote:

> @@ -172,6 +178,9 @@ static int lp87565_regulator_probe(struct platform_device *pdev)
>  	if (lp87565->dev_type == LP87565_DEVICE_TYPE_LP87565_Q1) {
>  		min_idx = LP87565_BUCK_10;
>  		max_idx = LP87565_BUCK_23;
> +	} else if (lp87565->dev_type == LP87565_DEVICE_TYPE_LP87561_Q1) {
> +		min_idx = LP87565_BUCK_3210;
> +		max_idx = LP87565_BUCK_3210;

This if/else chain should be a switch statement.

--q9KOos5vDmpwPx9o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzb80IACgkQJNaLcl1U
h9A6lAf/e30hsZKGBDMeaM6cCqdg269DLgcFARjKCZ3zp0sp3UYHDCU7I7eBAscT
wMqHKpBrhHVyS6swCG7Lbsy2xywm6b77fSxxvZiWPnsdgpDHjLrzbqu2nZvA8UpD
8eXgfB8yOY1Pqw0Z9zJ55C26c+sjROltuBsJ1fGLo2HcAlSAPZtFu+zehJYKRUVq
lrDGdgNGnXlxnZMVNnnAWNFCFZONW+rwZOVI9tdV8VqDX8g096T4/ZhFxVdTW3jU
yMTcqq/1o12IRB26NToSf262mMa0g5ppI0k/Gq9SOFwhsi4ssXsHik2yceV0jOcA
KadxC1Bmn6nfUWoNpZx2mjgylXOV8g==
=dLEO
-----END PGP SIGNATURE-----

--q9KOos5vDmpwPx9o--

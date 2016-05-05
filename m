From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/3] regulator: lp873x: Add support for lp873x PMIC
 regulators
Date: Thu, 5 May 2016 16:38:20 +0100
Message-ID: <20160505153820.GF6292@sirena.org.uk>
References: <1462425040-18566-1-git-send-email-j-keerthy@ti.com>
 <1462425040-18566-4-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="TUvp6TiFcfhGC84w"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1462425040-18566-4-git-send-email-j-keerthy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>
Cc: lgirdwood@gmail.com, lee.jones@linaro.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
List-Id: linux-omap@vger.kernel.org


--TUvp6TiFcfhGC84w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 05, 2016 at 10:40:40AM +0530, Keerthy wrote:

> +static const struct of_device_id of_lp873x_match_tbl[] = {
> +	{ .compatible = "ti,lp8733-regulators",},
> +	{ .compatible = "ti,lp8732-regulators",},
> +	{ .compatible = "ti,lp873x-regulators",},
> +	{},
> +};

There should be no need for compatible strings here, we already know
what device this is from the parent.  The way we split drivers up for
Linux is something that's internal to Linux and shouldn't be in the
device tree.  If we do have explicit compatible strings then they should
(as always) be specific to a device, no wildcards.

Otherwise this looks sensible.

--TUvp6TiFcfhGC84w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXK2jrAAoJECTWi3JdVIfQBSkH/RfOIGws1Q8B/TA6uqaCRx/7
sRc1M3AN20HLiRG4PnjT2yWutkvJBnLdYHfEft0nFLdpqQWAlOtWVeidgq9Pj42z
CWlOq2xqa9LVwFfaQuh53j8ksYCiIHsQp2omoIwVAPoadOBPCVz5+aNCLGdTImKK
5Xizcm7lrqzg/35kxsnJqUv7uriakaoKXD7k3QP/DtWMF0Ta5fTF49iPsbw4DoZT
T0kDhbDNRhvpBY4akO6lYfuMecQc1Cgxby9oWsIraiNSBKJrBgzkzdFvqD3JX/0V
IkppxNTF4H0qJ5ts5FnQMV5rKzTX8MMKoMkYma03YTe5K9XgaBNE19AheFoMT2M=
=1t3+
-----END PGP SIGNATURE-----

--TUvp6TiFcfhGC84w--

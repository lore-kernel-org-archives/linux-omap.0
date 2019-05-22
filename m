From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 3/3] regulator: lp87565: Add 4-phase lp87561 regulator
 support
Date: Wed, 22 May 2019 16:35:28 +0100
Message-ID: <20190522153528.GG8582@sirena.org.uk>
References: <20190516043218.8222-1-j-keerthy@ti.com>
 <20190516043218.8222-4-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="p7qwJlK53pWzbayA"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190516043218.8222-4-j-keerthy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>
Cc: lee.jones@linaro.org, robh+dt@kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, t-kristo@ti.com
List-Id: linux-omap@vger.kernel.org


--p7qwJlK53pWzbayA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 16, 2019 at 10:02:18AM +0530, Keerthy wrote:
> The LP8756x family has a single output 4-phase regulator
> configuration. Add support for the same. The control
> lies in the master buck which is buck0 for 4-phase
> configuration. Enable/disable/voltage set happen via
> buck0 registers.

Acked-by: Mark Brown <broonie@kernel.org>

--p7qwJlK53pWzbayA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzlbD8ACgkQJNaLcl1U
h9Alygf9F5WNeDtw1PhBSqAc0Si59+B44/gYO/ffBTyuP2A3hzVd3VvhrYSk1+gO
gGPdCGdyRMIcs83ijz02XKwWIDhrazQcDQhyVCd0QpbPAB6CpgJnj43DQMgFzAHS
2i5le6Ossnsc/aPGDgumb26OIL2v6H/mgmTSGEUynKl+0Z3M5MgQHgWmzTNMytLH
at5abgsiKSt8MCEXReN3AY83M6IdCew01AtsRUAklTLEkC8ggDXrTT8kAYn5mvb+
a0VpR9W2JNJ8Dxc3i82UY3vrQ35UnIP5/SnUH+apbWcVIcbO46RtXAkHC4yo8tZz
vBpiIoYfUBSL6hPKnfzob+ryXb8EFA==
=k1Kg
-----END PGP SIGNATURE-----

--p7qwJlK53pWzbayA--

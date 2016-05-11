From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 4/8] regulator: tps65218: Remove all the compatibles
Date: Wed, 11 May 2016 11:21:21 +0100
Message-ID: <20160511102121.GG6261@sirena.org.uk>
References: <1462945691-904-1-git-send-email-j-keerthy@ti.com>
 <1462945691-904-5-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="PyMzGVE0NRonI6bs"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1462945691-904-5-git-send-email-j-keerthy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>
Cc: tony@atomide.com, robh+dt@kernel.org, mark.rutland@arm.com, lee.jones@linaro.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nikita@compulab.co.il, nm@ti.com
List-Id: linux-omap@vger.kernel.org


--PyMzGVE0NRonI6bs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 11, 2016 at 11:18:07AM +0530, Keerthy wrote:
> Remove all the individual compatibles for all the regulators
> and introduce id_table and update the driver accordingly
> to parse device tree nodes using the regulator framework.

Acked-by: Mark Brown <broonie@kernel.org>

--PyMzGVE0NRonI6bs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXMwegAAoJECTWi3JdVIfQXtoH/0amJfRtlDhulkxoP/FwkpHI
Z8fVYBlbnnjPw+gju2FcsNRT6XtoZ/jCE9QNxumaaLAluOZ9CrQAOBAki2AfB1Tn
L1byvxFW81V2zcQgbH1aAsvJ9kEnYz24bIsbBFRfCWtE46WXhQ/D/VnXNRG0Qvlj
GyA0vOly0c874sQm340edssOgfT7JlDbhdAcL2spgK4V+ykeGKbqjidjkSqOR6qk
VBmaNWi9QHC4TFeGPqxNS6XhMrHOcePwv4LKDsM4NxGl0/dugZbnD7CB5AOrCM+M
xKPaV/lUVHVXs2q7nQDfbEJ1O1cX28ukxc3mYc7nLvJY+sTVopGuajeGIpbznCo=
=iLTu
-----END PGP SIGNATURE-----

--PyMzGVE0NRonI6bs--

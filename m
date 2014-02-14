From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 3/4] Regulators: TPS65218: Add Regulator driver for
 TPS65218 PMIC
Date: Fri, 14 Feb 2014 20:21:08 +0000
Message-ID: <20140214202108.GI4451@sirena.org.uk>
References: <1391665814-18814-1-git-send-email-j-keerthy@ti.com>
 <1391665814-18814-4-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6b3yLyRKT1M6kiA0"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1391665814-18814-4-git-send-email-j-keerthy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>
Cc: rob.herring@calxeda.com, pawel.moll@arm.com, mark.rutland@arm.com, swarren@wwwdotorg.org, ijc+devicetree@hellion.org.uk, rob@landley.net, sameo@linux.intel.com, lee.jones@linaro.org, grant.likely@linaro.org, lgirdwood@gmail.com, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--6b3yLyRKT1M6kiA0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 06, 2014 at 11:20:13AM +0530, Keerthy wrote:
> This patch adds support for TPS65218 PMIC regulators.
>=20
> The regulators set consists of 6 DCDCs and 1 LDO. The output
> voltages are configurable and are meant to supply power to the
> main processor and other components.

Applied, thanks.  Please use subject lines consistent with the
subsystem.

--6b3yLyRKT1M6kiA0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS/nqxAAoJELSic+t+oim9HuMQAJ1V+nCKHsVPaI/Gt13j4UI3
SupKWLr7jay5rtAPV5Yun7Lugdpua8q2PL3v2aWEEE//SkAxvINNyKvcJTbTyZuh
QzLJORzi4u4Zk/nb3jOfEZ/5LVI8mkZ3Danv4PlIUHzcoTLcfA7hF4UCX4le20WY
DGgj4xQZ/OVyRe0Lbdy7LukwTzeJ5WUJvos9l57QXItrazridd8jWsl3G/4iyKcH
xbYMxDgp1cdfH0JqWjIPjQFeXSa1RRotyo5ru0aeBqDiRZQHi7nPqsnnWfqdphTF
2Fy8KJrgnSpFXD9wGQr1jwc7kjQRhzZSHyPaBlEvK9DiFHg6rJt125SNRPXNzRHh
SQ0QGrVGB9tKAICWwz/bkT9Sx+7nebTLriBR/oUEodZmRvno3poSRlxbRPKnc3xN
ZES51spULEWwZIuV703sp+z8xieN5uh5V95zx11TxDJblyL/PFAwLhVsmWm6ZL29
AFwW9v1LD+47anX1IIcg25djdKFtRnkzCMdP90iG3xXMsqOGsal6qAt/JwRSt5xk
WPCY1C8pJp9FJZPtiMYbSXggTNh+t3ql6I/u47jxQTn3feB7TLneCNams+8tSp0M
qHHuieLP1krbON0kxLryVAXqPe9OiwCwNLjMQAzPZuTVMGxh+gqB6hCWHCCBq9YX
ezsjSO9p2Nianw6bOAFZ
=PXmD
-----END PGP SIGNATURE-----

--6b3yLyRKT1M6kiA0--

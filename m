From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v3 8/9] ARM: OMAP2+: McBSP: Do not create
 legacy devices when booting with DT data
Date: Wed, 22 Aug 2012 20:16:02 +0100
Message-ID: <20120822191601.GO7995@opensource.wolfsonmicro.com>
References: <1345124468-8876-1-git-send-email-peter.ujfalusi@ti.com>
 <1345124468-8876-9-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6677746822431185107=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1345124468-8876-9-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Benoit Cousson <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Liam Girdwood <lrg@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: linux-omap@vger.kernel.org


--===============6677746822431185107==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4QsEYJIjMB+yaydW"
Content-Disposition: inline


--4QsEYJIjMB+yaydW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 16, 2012 at 04:41:07PM +0300, Peter Ujfalusi wrote:
> Only create the devices in a legacy way if we do not have the DT data.

Applied, thanks.

--4QsEYJIjMB+yaydW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQNS/rAAoJEFJkBDiqVpZ4LNIQAL8cHsAiC44GFa/DS+dhZTAB
18DUdHDRZ6S7Xfm3x2UuRBHe55YOnhWy+a70FusyZCiubYqs9VFQUkqelIrz1AaU
gss+Q+2HGbmhKORrv0Mrhsw8+xfm0oejQ5yrncU4umRj9fpby9TiO9YrmEr7zmRl
jOWxJAYCr+xElxJUrlNeAvHm+qBfkaQWmBCVzf19wYQT64s0Rkr5xiJok7sxkqc4
hqWPmMvzfftYWD5Uh8Y7gKfcLBsyMLpH3zHG5lZD8pcdQSjuldhSUvVEn845Saf6
u6sajN09zMf7R03htW9tr6+eFY2JZQJJE+bVJwR6EQWgCGLY0p73ENrhxPerhT8A
LDJNWA8/QPf4aHrs4PXwJqbqKy3SOYQqpddt0ZxX7qG+d4ZPsMKrl+c1zqlkdO63
fTauRnwMRVYM+Tf7D/L1EyInrZQIiQLMp2FKy18MmWVCdlGJPaSHtRlvnM9oSCXs
jPg2R4YUADY2Pd9hgL+ayWUrIIC3vVTA3NN9vUrD9jJ5gApQtSSSUu8Y/zFju3Kj
hk9TU88E5sbDoGKwHwkgYvIlDXkXRJ3feAZd38fDQayb7Y1k/vZWuJVS1d+taf9J
f2/Lh+bqVo8lNgfRFf4x10vbxMgOYxU+xDbRxzRKDdu7CkAZvXppXCJo9u1o9iTB
Ha2mKI+tLaTOddkWmmsz
=/Jwp
-----END PGP SIGNATURE-----

--4QsEYJIjMB+yaydW--

--===============6677746822431185107==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6677746822431185107==--

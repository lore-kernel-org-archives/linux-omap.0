From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC 5/7] OMAP: sdp4430: Add fixed regulator for
	twl6040 needs
Date: Thu, 2 Feb 2012 12:40:25 +0000
Message-ID: <20120202124025.GF7428@opensource.wolfsonmicro.com>
References: <1328185019-29575-1-git-send-email-peter.ujfalusi@ti.com>
	<1328185019-29575-6-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4830933798494315922=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1328185019-29575-6-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Samuel Ortiz <sameo@linux.intel.com>, Tony Lindgren <tony@atomide.com>, Dmitry Torokhov <dtor@mail.ru>, linux-kernel@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Misael Lopez Cruz <misael.lopez@ti.com>, linux-omap@vger.kernel.org, Liam Girdwood <lrg@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org


--===============4830933798494315922==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Zs/RYxT/hKAHzkfQ"
Content-Disposition: inline


--Zs/RYxT/hKAHzkfQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 02, 2012 at 02:16:57PM +0200, Peter Ujfalusi wrote:
> The twl6040 VIO power is connected to SMPS V1V8, the
> V2V1 power is coming from SMPS V2V1 of twl6030.
> These are fixed, always on regulators.
> Create fixed voltage regulators for these supplies.

Shouldn't the PMIC be creating the relevant fixed voltage regulators?
It's a bit clearer given that the supplies actually come from the PMIC
and it would cut down a bit on the boilerplate in boards (though much
less so with device tree, sadly).

--Zs/RYxT/hKAHzkfQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPKoQzAAoJEBus8iNuMP3dK7sQAINNif96qMJcL2Mx7K0JhuAg
VPMrXsBVusY2fRoGOwzmxRgRb/pH9g17n/g9tuLfmOdx84gUT6gpkfJjbbEFLr+Q
UCT5OEBTtth8Cba55pqmcLFn+6l8C2wkeXbsNyErZlAdb3qX3SMywqmmWtEpT7Km
CYzPErwA7SaYb7/fCfvklEZJQKVlV0t3Ra59e5y958KMYOkEa39zscezLur/AgWv
S98zSUb9DSfnIDPNegAy1Fif9csAcXY96pIdwzLHnxsq51knU4RkjbK0jcC2eROp
1mxCZT6ZK8rW2E0VPQeldr8U2qhqf42kjBv5b+/ttGcSqZu6qXwH272//+Wcn3pW
EpdSgW2ajEwUTKWk9dO+jBYMQaez2oERcThE116/9wuoDTV6b50l1DyvgnnQiFgv
WgfDFHz115zHBC1+EttTb5BOyVww7V44Qp4Tb8V9+MJrERAUle3ke47ckYBd21so
9JIVX4QkvOBQ1Fii0vlf8xBXDGlOpkWGM+DRDotwVnVhAGiamUxslBmtlEzsET1V
osSol9FL6+qyeYErMHHNcpU045VnZpC/JlQ8Yyu2IkpMfvMkJe4HiuBkYp6iifFX
lqVIkAE2ZVVpCm+GAm6TKnu348zha2U6Av+khp9W+OvQmvfFDW50qgqnXPWrjVSC
+o/RsLPp5bSj4jEizLLo
=pA51
-----END PGP SIGNATURE-----

--Zs/RYxT/hKAHzkfQ--

--===============4830933798494315922==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4830933798494315922==--

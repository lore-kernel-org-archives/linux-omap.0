From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] regulator: twl: Provide of_map_mode for twl4030
Date: Mon, 4 Apr 2016 15:26:38 -0700
Message-ID: <20160404222638.GM2350@sirena.org.uk>
References: <20160328093938.GA2350@sirena.org.uk>
 <1459796234-2430-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="klUO3blZLrAR18XW"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1459796234-2430-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Cc: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, tony@atomide.com, lgirdwood@gmail.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--klUO3blZLrAR18XW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 04, 2016 at 09:57:14PM +0300, Ivaylo Dimitrov wrote:

> +For twl4030 regulators/LDOs:
> + - regulator-initial-mode:
> +  - 0x00 - Off mode, the output voltage is not maintained and voltage regulator
> +           power consumption is 0.

This isn't a mode, it's just the regulator being off.  Just drop it.

> +static inline unsigned int twl4030reg_map_mode(unsigned int mode)
> +{
> +	return mode == RES_STATE_ACTIVE ?
> +				REGULATOR_MODE_NORMAL : REGULATOR_MODE_STANDBY;
> +}

Please write normal if statements, the code should be readable.

--klUO3blZLrAR18XW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXAuoZAAoJECTWi3JdVIfQVfIH/R2li9V6BC6G3g25eNNE0G2C
tftACfc75RIb5J6Gfp/iPLNa+HEN3lcqq0uAKfBCbtPMPFFvL9a1nAwOxP6rAtli
EvVGZ30VYRtUUb6InQWbNaIt0aA8seFydmJOGcPqwbFNcdlQx4x08T1VIFTwlseC
YGe1UkdqCdouERC7v+hGJlkGz/xLV188UZVvXgBT9K28/3/qGxVJm38rzNw+2WKP
rF5pMnK3kMT65VsWEOjVR8E+aJIv+vAX6YYFFE7XZq+0e11TzU+Pg/EbaZaNKorq
Rnl9r0cqKKByUB/JhNfcHsznOaSDdo2b+yBSMdLTrSRy8LGvgVqr8fFEY1eTOoI=
=vUeL
-----END PGP SIGNATURE-----

--klUO3blZLrAR18XW--

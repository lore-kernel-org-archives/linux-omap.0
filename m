From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] regulator: twl: mark vdd1/2 as continuous on twl4030
Date: Mon, 17 Jun 2019 11:31:11 +0100
Message-ID: <20190617103111.GM5316@sirena.org.uk>
References: <20190615163314.28173-1-andreas@kemnade.info>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bNLLTo5eXWXFd6av"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190615163314.28173-1-andreas@kemnade.info>
Sender: linux-kernel-owner@vger.kernel.org
To: Andreas Kemnade <andreas@kemnade.info>
Cc: tony@atomide.com, lgirdwood@gmail.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, sboyd@kernel.org, nm@ti.com, vireshk@kernel.org, letux-kernel@openphoenux.org
List-Id: linux-omap@vger.kernel.org


--bNLLTo5eXWXFd6av
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jun 15, 2019 at 06:33:14PM +0200, Andreas Kemnade wrote:

> The VDD1/VDD2 regulators on twl4030 are neither defined with
> voltage lists nor with the continuous flag set, so
> regulator_is_supported_voltage() returns false and an error
> before above mentioned commit (which was considered success)
> The result is that after the above mentioned commit cpufreq
> does not work properly e.g. dm3730.

Why is this a good fix and not defining the supported voltages?  These
look like fairly standard linear range regulators.

--bNLLTo5eXWXFd6av
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl0Ha+sACgkQJNaLcl1U
h9CySgf/QMQ2EqpD1L/XFhmLo/ZBQ0MxTTbrhP3mxCoktiXaHq/8rC1GKin90FQ+
63Z79sD50NvjwOao024deSYu+7MVpCoojPdVwdizjH/B2meplYkB5fw3yhHKvsKc
+r1BYXVYODtZC590X8RcFCT4nO91acJoSbkA9dbHhp16+qnyjy/7sr9OmtDwTYkw
qVjma1T5nDgWfw1G9bQ6WAdQHSdZtuo7LYmPbrvpPXNAaTv2Va2YssbniIOWNgsW
sC/YRIuwWUztdeRwfhWIbyt3elAP0kUmoRVD1O3WzQx4STBpn97C++fDwjDwgn7H
F99QnvGMDroMdwasCwHr5TcSfoWAKQ==
=Awof
-----END PGP SIGNATURE-----

--bNLLTo5eXWXFd6av--

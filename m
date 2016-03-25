From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] regulator: twl: Enable regulators over the powerbus as
 well
Date: Fri, 25 Mar 2016 18:20:17 +0000
Message-ID: <20160325182017.GE5028@sirena.org.uk>
References: <1458760956-29892-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
 <20160325111757.GC2566@sirena.org.uk>
 <20160325150259.GA9372@earth>
 <20160325155419.GI2566@sirena.org.uk>
 <56F562B7.10107@gmail.com>
 <20160325161954.GA5028@sirena.org.uk>
 <56F56C4A.7070502@gmail.com>
 <20160325170558.GB5028@sirena.org.uk>
 <56F573E5.6030408@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="n+lFg1Zro7sl44OB"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <56F573E5.6030408@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Cc: Sebastian Reichel <sre@kernel.org>, tony@atomide.com, lgirdwood@gmail.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--n+lFg1Zro7sl44OB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 25, 2016 at 07:22:45PM +0200, Ivaylo Dimitrov wrote:

> On Nokia N900 regulators are left in the mode last set by the bootloader or
> by the stock kernel, depends on whether it is power-on or reboot from stock
> kernel to mainline. That leads to problem with devices connected to vmmc2
> regulator - when the device is rebooted from stock kernel vmmc2 is left in
> "sleep" mode (REGULATOR_STATUS_STANDBY in terms of regulator framework) and
> as noone in mainline kernel switches vmmc2 regulator to normal
> (REGULATOR_STATUS_NORMAL) mode, devices supplied by it does not get enough
> power to operate normally.

Then there is a constraint that the regulators must be in normal mode
and this needs to be expressed in the machine constraints.

--n+lFg1Zro7sl44OB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJW9YFfAAoJECTWi3JdVIfQtrgH/2i5TsWf5g5EbTyupDsP8XYe
svwh7I/sociQwnLdLRLsdHrFKm80D0zBGmidZSSJV9KNh72E4kspm8ucygrcdW9g
l5ruJGzcDUgBZgrmWdKcK2cJndfW2CgvoBxMMqsov1cxpJ8yGK86eZz4uGapwG6L
Yvc8kdJvIhrzbbgW33qfK4/Zt3M/nHc03DK+hNbRmp5IyuIPA/BFJyyrYJWdHtx7
1dmKPItNiBgkkc4TDM3hDvskejz0XKYe5xTCUi5+g3kwtZK9t4PvA6CihtvAgdlq
iu+BNZGs1a/bfQuARSDBdN+z5+l/RlSfXiVK4RIrJ+J6A9x7ZRcp0+2ChAVQyRk=
=Qb48
-----END PGP SIGNATURE-----

--n+lFg1Zro7sl44OB--

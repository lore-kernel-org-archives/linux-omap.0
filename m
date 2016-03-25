From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] regulator: twl: Enable regulators over the powerbus as
 well
Date: Fri, 25 Mar 2016 17:05:58 +0000
Message-ID: <20160325170558.GB5028@sirena.org.uk>
References: <1458760956-29892-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
 <20160325111757.GC2566@sirena.org.uk>
 <20160325150259.GA9372@earth>
 <20160325155419.GI2566@sirena.org.uk>
 <56F562B7.10107@gmail.com>
 <20160325161954.GA5028@sirena.org.uk>
 <56F56C4A.7070502@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="BwCQnh7xodEAoBMC"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <56F56C4A.7070502@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Cc: Sebastian Reichel <sre@kernel.org>, tony@atomide.com, lgirdwood@gmail.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--BwCQnh7xodEAoBMC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 25, 2016 at 06:50:18PM +0200, Ivaylo Dimitrov wrote:
> On 25.03.2016 18:19, Mark Brown wrote:

> >What makes you claim that this is a bug in the framework?  Does anything
> >in the machine configuration say that changing the modes is allowed?

> My understanding is that regulator core have to make sure an enabled
> regulator to be in REGULATOR_STATUS_NORMAL. Now it enables the regulator,

No, absolutely not.  Modes are completely orthogonal to enabling and
disabling the regulator - modes reflect an efficiency/accuracy tradeoff
in the regulation, they are nothing to do with the regulator being
enabled.  Setting a mode should not affect the regulator enable state
and enabling the regulator should not affect the mode.

> It might be that I am not getting the logic behind.

Yes, that seems to be the case.

--BwCQnh7xodEAoBMC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJW9W/1AAoJECTWi3JdVIfQvcgH/jr1se/zKraVavlHFmYLZUP/
aUpsdRkS/nMmPEMLj64CJQGrwUWxZY0cWUUNysdNw9YHkv/vDUtnQLeYMuoC5OSC
WNIVrGnALrw2yy94+4U0s9KJhfb5ZBo8wesuDINqAZ4JuOKvpPt5UtEXik9OmLcj
zyp6SDLc00bki4D3tLaY4JFJwOCcPB2dYCi2WhpCDiMG/kG2XrbbCPizKBC1/xYh
nMkfc0dTalH0awxgkfbljPdbz/2NBovArNriU1Yk7sLENoAsyU80JnyUY1mADxTR
dLdaRusXYEgtunD5Y1dOjZJTAvpxcFjzujAMmmc5x1QFk9DwHOgmMB5tZz1cly0=
=jvIB
-----END PGP SIGNATURE-----

--BwCQnh7xodEAoBMC--

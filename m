From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v6] ASoC: tlv320aic31xx: Fix unused variable warning from
 aic31xx_clk_off
Date: Thu, 13 Mar 2014 17:31:41 +0000
Message-ID: <20140313173141.GB366@sirena.org.uk>
References: <1394725072-10584-1-git-send-email-jsarha@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2bJ57vwr75KGnr5s"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:55824 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754213AbaCMRbr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Mar 2014 13:31:47 -0400
Content-Disposition: inline
In-Reply-To: <1394725072-10584-1-git-send-email-jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jyri Sarha <jsarha@ti.com>
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org


--2bJ57vwr75KGnr5s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 13, 2014 at 05:37:52PM +0200, Jyri Sarha wrote:
> Fix "warning: unused variable 'aic31xx'" from function 'aic31xx_clk_off'.

Applied, thanks.

--2bJ57vwr75KGnr5s
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTIet6AAoJELSic+t+oim9trIQAJ2fqQtatWQmNv7O7Iunx1kn
kTGfj26t0Qz2r67N0r43GxSAPmPTBr2fuOOaloeTevP8C3gxNT3LjTg0mv73ZwCP
BszcUY0jDD/LLY2QtVq6l8vUSbnVGR8eZCqbBgT/DOlN6W7/Bba3WAp5tGivgzFx
aP8Y8KRnY/pK8nGjDdluB6/lti5yjMglLZZA+7YUxmXY0hN+2EXtm8C81ibNGM/k
8JdshYZ9i4CEsaSzmxwLkgGe2ePuOggqvxEHhvqIkt6K5jdkZbPBVDYhbHR/IoAB
j5nFNX4hI2Vm6j6BDwVlfWDpGjvhYZ3Fjo8FXuaPgGip1XL2GRMbjNCzgZaqMQfz
Y6oSwASNmgEWSX8bmPMBAwvGboPv2aJ9+TXb/aiIJXyTO3D6L8Nl4POw1h66hDrP
cJIjBiX6VX1hGNOatebSV8zAAmZdrejcHHHGiqtjQKJAQ9ctRxMi8LXmtJSZFdLe
VwfqboKs1F5iyEgJ9ykIV8Xfu3Y/iGBUDHXJ0G45Ll8+HMGEXYbKAm/f2JSX6ZxZ
KlthkRPdNShnvlljOb6b5BkVRaT4kWiU/r6iYmpb8H0n47xm0mOfKTqPnaQR2zSW
joRhUyVKdJff0Is7uODT4uG5/X5kGzJf3+kuUu1HouRiNeMu7jreusXPLioJWffi
5VTCp8Z8Y7fQ/OVgvhlS
=eGLn
-----END PGP SIGNATURE-----

--2bJ57vwr75KGnr5s--

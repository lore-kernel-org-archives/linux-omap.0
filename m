From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v5 03/12] ASoC: davinci-mcasp: Add location for data port
 registers to DT
Date: Tue, 22 Oct 2013 12:04:54 +0100
Message-ID: <20131022110454.GB9388@sirena.org.uk>
References: <cover.1382110089.git.jsarha@ti.com>
 <2d590a299670bb4f39251a95d7f4898034109bd7.1382110090.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NDin8bjvE/0mNLFQ"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:43468 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751950Ab3JVLFN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Oct 2013 07:05:13 -0400
Content-Disposition: inline
In-Reply-To: <2d590a299670bb4f39251a95d7f4898034109bd7.1382110090.git.jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jyri Sarha <jsarha@ti.com>
Cc: alsa-devel@alsa-project.org, devicetree@vger.kernel.org, bcousson@baylibre.com, mark.rutland@arm.com, linux-omap@vger.kernel.org, joelf@ti.com, "Hebbar, Gururaja" <gururaja.hebbar@ti.com>, Darren Etheridge <detheridge@ti.com>


--NDin8bjvE/0mNLFQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 18, 2013 at 06:37:42PM +0300, Jyri Sarha wrote:
> This patch adds a separate register location for data port registers to
> mcasp DT bindings. On am33xx SoCs the McASP registers are mapped
> trough L4 interconnect, but data port registers are also mapped trough
> L3 bus to a different memory location.

Applied, thanks.

--NDin8bjvE/0mNLFQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSZlvSAAoJELSic+t+oim9IL0P/0vXy3T9PNCDwg13Ufmd7s9s
G8wZEl094+CX13av5IN240n40xl/GkgRzFYuD5xZu33dLAGaP9khTeobxWJko8mf
cBSjaM7aAS0vEs62/fqQhTkKPwKaN2Pduom4RrsJmr7BkKpHHKsSTUJ6cHHqInnO
GnwhBhTSSrzpf2aJSuQL7lm7ZOKGT/fik1rt4CkIgI2y9bVg/RLybTQM4apMTVVJ
lYTgbs3yAxb+p5k75I2+pfjtXWZ0cC2/wo9693VFlLDASgAvW5MtisWRvPRO0iPk
HegspbTEwUTLCrUdB1/ezVvrw6UzKPP8oYuTrP0afdgkT5aLqfZ2fZT9fWJSeIfD
TQZdt76gBjsfXnvovjS+b0yBzqspNi1ok6jUXums1yHCxGnpqjwboyVAuOuCCdvJ
tSNumJ7t9GdnRwr0jQOeFa287NHCIkrqp/CJdPie9vi3uCyPGUAzF2vy030RN1wG
gjLnKMVnSAwcBjyb7LBDdiV3vJ3rnzLs/u8S67Jvw0IQ6PMufug8ge99CyV+pLsS
RLMqR0eDJPsFU2ZHzhNRQTE+KrvNzO5m7uElqo/NHWZQ3W4rOfjrSr2p4BuxGSi2
REVO6Zf+LDbGefKoi1/Kj6MCXahquu0fb/8BeiI3ctgAl3j8/3hiViEL8azTJyc1
tnaRCpCM4omD7w7vNzDC
=BIoO
-----END PGP SIGNATURE-----

--NDin8bjvE/0mNLFQ--

From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC 0/3] Add cyclic DMA support to OMAP DMA engine driver
Date: Fri, 22 Jun 2012 17:11:56 +0100
Message-ID: <20120622161155.GM4037@opensource.wolfsonmicro.com>
References: <20120622085911.GA19026@n2100.arm.linux.org.uk>
 <20120622123013.GA7586@sirena.org.uk>
 <20120622131750.GB19226@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Zqu75NDXmDJGUu04"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:52231 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755686Ab2FVQL6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 22 Jun 2012 12:11:58 -0400
Content-Disposition: inline
In-Reply-To: <20120622131750.GB19226@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Vinod Koul <vinod.koul@intel.com>, Dan Williams <dan.j.williams@intel.com>, Liam Girdwood <lrg@ti.com>


--Zqu75NDXmDJGUu04
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 22, 2012 at 02:17:51PM +0100, Russell King - ARM Linux wrote:

> I suspect the key difference is I run the uImage kernels on the SDP4430
> without a DT blob.  I suspect it's the DT conversion of sound/soc/omap
> that's buggered it up.

This sounds like the most likely explanation.  There's not that many
commits, would it be possible for you to try bisecting them (or just
reverting them one at a time)?  The most salient ones should be:

356bccbea17988bd32a016ada867dd6a53ba2796 ASoC: omap-abe-twl6040: Introduce driver data for runtime parameters
7d09f9e98956b29755f20d830252dec9300e7044 ASoC: omap-abe-twl6040: Move Digital Mic widget into dapm table
c2f98956e3635a897737cc08a60539752aa00dd7 ASoC: omap-abe-twl6040: Keep only one snd_soc_dai_link structure

though it looks like a bisect of sound/soc/omap should be about as fast.
Like I say if we're talking late July or August there's a very good
chance that 3.5 will be broken so we should at least revert but it'd be
a shame to loose the HDMI stuff, I'd really expect that to be unrelated.

--Zqu75NDXmDJGUu04
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP5JlEAAoJEBus8iNuMP3d46sP/Amom1KMjfFiPz60UheArSS2
lJG4QAx6m+ObQTSxSh641YTyosl6AB+JDjCwovpsr7xRmp//q3+YbNafa2PCPOZa
OY7FlpLCaXhTuZ3DUkKGGbFL7vDGo6Qrl7Sx5JlPBRw/GkltxmW3xh6haaXyv9dQ
YD0QCGXgZehb1zKgUMT1kC0rE4svtsy/uWJe0s9MaBu3nNvFPGoNymEHBMiJl7KT
5phgx015w6W8fjotmHb5rGHo63lymcBfKXcffL75BnsveM6l9FPihCwYAyafVKl0
uwRDxsCZT4F/Dut+fukiAuXNf2+VpaN5GsUuU3rlKRbGIXGCJCjiBrNiRkJnIdLN
LMbUm0Lu0O82udkIeBEOPlIaXZAa7mi5EUX8VHeEPOZmkhmIEghzKiMoIUeECNnx
987BXEOnS9gFpshmT/O+S54AwK1NgTyC69fJHgiHDEiPar2Oyhy1Sjafr3+xxSm5
dCfjcjDnMGOlbeOYd9oi3EL/ur6n8PEVgAGUM1/r/Way74KTYheJX7dC5oI9dTTn
2mLQeGfmOS9XCIVF9tjOnSgaaXW8uEJgMGyR6ZfI8zheTwvcTavYJb11G/IlsBUS
9dcffZpjY/KOMlCIRrK7bVJxMTUgjJK5n96+NwKLVWLTbHR4pLZCG8c4MfgrLLN2
qt5mmrxysY6HwVX8r0b0
=U3QI
-----END PGP SIGNATURE-----

--Zqu75NDXmDJGUu04--

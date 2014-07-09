From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH V2] ASoC: omap-mcbsp: Use devm_snd_soc_register_component
Date: Wed, 9 Jul 2014 10:15:39 +0200
Message-ID: <20140709081539.GH30458@sirena.org.uk>
References: <1404836723-4779-1-git-send-email-badarkhe.manish@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XSfi1pJWPNAvuBPy"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:54399 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751574AbaGIIRq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Jul 2014 04:17:46 -0400
Content-Disposition: inline
In-Reply-To: <1404836723-4779-1-git-send-email-badarkhe.manish@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Manish Badarkhe <badarkhe.manish@gmail.com>
Cc: linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, peter.ujfalusi@ti.com


--XSfi1pJWPNAvuBPy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 08, 2014 at 09:55:23PM +0530, Manish Badarkhe wrote:
> Replaced snd_soc_register_component with its devres equivalent,
> devm_snd_soc_register_component.

Applied, thanks.

--XSfi1pJWPNAvuBPy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTvPooAAoJELSic+t+oim9h2gP/1nzcJjFzy3oL/pgM9tm60l9
61M/XoZmE5bsUt4q4rsRUTzRduC874nml+ayYdIwIO5MeeacQjHFKWOZBSKsS89Y
W4niD2zn2zP4yAPxgVDvviaffFVMwz7xGR8SwuZqQjZ/lwG1iH9akhNdm4Y2C2gl
H3m9KOsGUXmZymJ8OziI6u8qLCON1NFpAyxwg7m3EAKU+sd1zM6YAbidsJA88Y//
eVKZBupFmVxhQXuUjSdaUAMruBlguIcLe32V0nqNtpA+Bliqwtr7+EZpUkfRdAPA
wh+R6mDpLd5LOttTe0gRGo8cn6PKnHXGAYtpdKjMpw9r9lx+/X8/m9w5+TekYWfS
bYvn/DxQNUK+NjF0uwc+gTurD8UDWgITWZuWRkNPqF+NFSyvQsfdLRhw5daOJ6yS
1MN4H5LzYXFZwMQu2GTkOZUGhJo/uXB4jqot2Eam2wzzNfx1aDE7/TXfqAiauhvw
gXH0U1Jc89PFWvaZf4GyEfCIx44pmq+CJ992JPQ618z9/dFwyomGD7kbeInghfSL
3H28FwHhg3vhlf02sbX0TEbnVviiI+stu8lZ5mXm5LmuSFyNLI1xc095b9Bb6Uxh
wGKhTBoRamL7SV/CuwQl85SAfqVAcemcJgjDdpayPBnmUEujFW3kUQReciSiWQiO
iK0WW735xw+xQXUdYdIR
=l/Do
-----END PGP SIGNATURE-----

--XSfi1pJWPNAvuBPy--

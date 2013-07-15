From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: omap: Enable COMPILE_TEST build for DT platforms
Date: Mon, 15 Jul 2013 17:26:05 +0100
Message-ID: <20130715162605.GS11538@sirena.org.uk>
References: <1373903876-26370-1-git-send-email-broonie@kernel.org>
 <20130715160045.GG32035@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dQ2XShfnd5GHxhN7"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:58344 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932905Ab3GOQ0N (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Jul 2013 12:26:13 -0400
Content-Disposition: inline
In-Reply-To: <20130715160045.GG32035@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org


--dQ2XShfnd5GHxhN7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 15, 2013 at 07:00:45PM +0300, Felipe Balbi wrote:
> On Mon, Jul 15, 2013 at 04:57:56PM +0100, Mark Brown wrote:
> > @@ -26,7 +26,7 @@ config SND_OMAP_SOC_N810

> >  config SND_OMAP_SOC_RX51
> >  	tristate "SoC Audio support for Nokia RX-51"
> > -	depends on SND_OMAP_SOC && MACH_NOKIA_RX51
> > +	depends on SND_OMAP_SOC && (MACH_NOKIA_RX51 || COMPILE_TEST)

> RX51 is OMAP3, and that's DT at all. This is likely just a case of
> updating commit log.

Sentence parse grammar not.

However...  if you look at the driver it actually does have DT support
in there, it checks for the machine type or for compatibility with n900.
Probably needs an ARM dependency which I'll add due to the machine type
check.

--dQ2XShfnd5GHxhN7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR5CKaAAoJELSic+t+oim93HIP/2N6D9X4wyOH+3Rwo29ogyuM
Rhv0g8UhNFI2GuNcCW8p63qnvY5vLIzSod/RIAvC4MBGYTVF74eAb7uPF2eV3eyk
UGg99af+ZoPmNQ8IH3TQydtufb2nBPFh/vwz7nNAD9wtnShAu4OHNxUoUn20r583
v0jaYQuYxlIF2j+8rE0ySBqFq09Tq14EFTRMjjF7CV3nlWCjePdHSahXNsha009d
kY31xTHppERAjtlqoD3wno6txZsIOLvn0vCaR/0HjqWgRBMVl6EHK3sBOZBN6YUe
9VlcavFmbMPPuGE/fPOV4Z61wE9/yu3bZ89hFhrjZobgHhqUCwr552WgzxojhLAr
VZjAn3jcKrgZ7TqRPgZnCQD1IoNA8hPtyznhiBcpZb10KYBQq5JWUYlnx8jUHZcj
YbPxrJ1DbOUNOxzPV9qH/e0krmuRqRor50O16kfdzKnOi8oq76xP0cebH1AbERi8
kNhern3StV7Uo9jjZilxt3KEBgeXrTg0kt+Y6AOxxCmwu5qQUHZLqKI22Mcd/naz
rHhkobk4TpNngfHH6S5f8F2HeuDPhRsqC6i/I0U8iy4WBkUp+UBjPMluiSHY0wc4
PpwIHNh1B81H6brFIWn3aLNDKziWk4arShJVNqVC/S4q9jpD68RZKWYCsBbGOzM1
0QiP7OFNprdULLauEWJv
=3hG3
-----END PGP SIGNATURE-----

--dQ2XShfnd5GHxhN7--

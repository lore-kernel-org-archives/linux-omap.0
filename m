From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 RESEND] ASoC: OMAP: mcbsp: ensure that CLKX and CLKR
 are not used as ouput pins when they are used as input clock for the SRG.
Date: Thu, 26 Feb 2015 11:52:19 +0900
Message-ID: <20150226025219.GL6236@finisterre.sirena.org.uk>
References: <1424538689-6330-1-git-send-email-niederp@physik.uni-kl.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qqPjTi0+PkGx+WSu"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:54923 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752535AbbBZCxc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Feb 2015 21:53:32 -0500
Content-Disposition: inline
In-Reply-To: <1424538689-6330-1-git-send-email-niederp@physik.uni-kl.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thomas =?iso-8859-1?Q?Niederpr=FCm?= <niederp@physik.uni-kl.de>
Cc: peter.ujfalusi@ti.com, jarkko.nikula@bitmer.com, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org


--qqPjTi0+PkGx+WSu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 21, 2015 at 06:11:29PM +0100, Thomas Niederpr=FCm wrote:
> This patch fixes faulty behaviour in a setup where the input clock for the
> SRG is fed through the CLKR/CLKX pin but the McBSP is configured to be
> master (SND_SOC_DAIFMT_CBS_CFS). In that case of course CLKR/CLKX must
> not be configured as output pin. Otherwise the input clock is messed up
> horribly.

Applied, but please as covered in SubmittingPatches word wrap your
changelog entries to less than 80 columns - this is especially important
for the subject line.  Please also remember to CC maintainers on
patches, the reason you've had to resend this patch is that you didn't
originally send it to me (which means the RESEND tag both makes the
subject line even longer and makes me a bit grumpy).

--qqPjTi0+PkGx+WSu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU7opjAAoJECTWi3JdVIfQWw8H/jNL8F+zXrCUQJic4qVZ67Sg
5jNiTYE33eFzlVhL7/eR3Inah4hvxD8q8R+md9GUwXRRYImlVSdakUeCXqG4EMks
2Rre6KEvaw+MLcIqlzN00yx4B6ITLB4yAbaYe4j9JH7+QN34NUxWDOSxv3YFQx+i
Um+BQhO+Xl6/AjeAOLg7v1Y1MR5gvcZGy7NBtllkIq9RbmbjEs+1JPNRj031Vwsf
WnL7iykWkazJMB754yy2/B57txINZ+cBNzRkHtaiB6/BiVY7RyNn1iZcN9L13pnn
SJT0rFsIm3zvmw9alxoC+J4AIxoGmoN6sh+JXHqGIdEbQIqS1XvQU6Qa83ymCXI=
=9tcw
-----END PGP SIGNATURE-----

--qqPjTi0+PkGx+WSu--

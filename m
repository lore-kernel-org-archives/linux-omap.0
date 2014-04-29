From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/5] ASoC: Add support for machine specific trigger
 callback
Date: Tue, 29 Apr 2014 12:05:02 -0700
Message-ID: <20140429190502.GL15125@sirena.org.uk>
References: <1398687476-10829-1-git-send-email-sr@denx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="m0XfRaZG5aslkcJX"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:49711 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751149AbaD2TFV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 Apr 2014 15:05:21 -0400
Content-Disposition: inline
In-Reply-To: <1398687476-10829-1-git-send-email-sr@denx.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Stefan Roese <sr@denx.de>
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, Jarkko Nikula <jarkko.nikula@bitmer.com>


--m0XfRaZG5aslkcJX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 28, 2014 at 02:17:52PM +0200, Stefan Roese wrote:
> From: Jarkko Nikula <jarkko.nikula@bitmer.com>
>=20
> Machine specific trigger callback allows to do final stream start/stop
> related operations in a machine driver after setting up the codec, DMA and
> DAI.

Applied, thanks.

--m0XfRaZG5aslkcJX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTX/faAAoJELSic+t+oim9y+YP/j2ayqxKRbco3DKRa5pxD/vI
VLudsrUlSINsscCTrHqeYIWQIqGAfZz8WqC/ZEupRhU3jy4msEFkSGlT7lxTVLXq
3ta6Exptje63wXPfZ4qhPhNtu6Hiy/T8s4NTdB6bMN+c6UJpCwVa7WrRJI42LLd5
2FnrhUJ6tL1WGOBcz4AdO+D49GlVit2krdS8BIfpRAIR1/4NzWW6HLFA0HvWfURb
9/zK8W8zDlTfcIGAZmdh8voLOnp7cD7VmAAqk+kUBAp/adepv4Jy8jQFl3CtZqsf
jKIXiC1N37RfavRadSAOMw4hIKTpdzAJB+heMfwOVQd9N/ygqyMUAzXVxU7Uc8ys
cmWcPSmuKWnWAgzsm0VRZkR4wMPfjpS99MLqbqypf46ErNJWhgr5R4vmJ/Cks+jO
VeMuWOy1jS3B3nYBUke8Q3Wqxv9l2vRjsFdOcNedoAJbc23DcSq1Prz132msP4iD
inwrYPho1ZgowVKvwWrYRj4k71dm7Jk2kJmm9SjvzaD27cmOLLwTMU52noduW+Sl
qZGEJEq31j/c2ov8NM8W+iO5KPPNhDk9N+yPrf+DIpclSfTp10LhwG7kFP82ODKH
byGyQiGyadfqWTxyatnLUtvnjpUkWZIyEXg5Hk1CQNzTu9ufabiy9i3vbrabst21
3AI4uUzUVpQ2ZscM474i
=vXty
-----END PGP SIGNATURE-----

--m0XfRaZG5aslkcJX--

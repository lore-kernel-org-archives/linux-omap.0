From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH V2 2/2] ASoC: OMAP2+: Move McBSP, DMIC and McPDM to
 generic DMA DT binding
Date: Wed, 13 Mar 2013 10:36:48 +0000
Message-ID: <20130313103648.GE25610@opensource.wolfsonmicro.com>
References: <1362988223-22455-1-git-send-email-s-guiriec@ti.com>
 <1362988223-22455-3-git-send-email-s-guiriec@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zjcmjzIkjQU2rmur"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:54894 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756279Ab3CMKgw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 13 Mar 2013 06:36:52 -0400
Content-Disposition: inline
In-Reply-To: <1362988223-22455-3-git-send-email-s-guiriec@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastien Guiriec <s-guiriec@ti.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, Liam Girdwood <lgirdwood@gmail.com>, =?iso-8859-1?Q?Beno=EEt?= Cousson <b-cousson@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org


--zjcmjzIkjQU2rmur
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 11, 2013 at 08:50:22AM +0100, Sebastien Guiriec wrote:
> Update OMAP2+ driver in order to use OMAP DMA DT binding for OMAP2+.
> In case of DT boot snd_dmaengine_generic_pcm_open function is used.
>=20
> Signed-off-by: Sebastien Guiriec <s-guiriec@ti.com>

Discarded since it breaks the build as a result of depending on unmerged
patches.

--zjcmjzIkjQU2rmur
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRQFa3AAoJELSic+t+oim9iEgQAIUvX0F2PWh9PmcTULj8kr6q
oxDE9jnqXGP1b9CdwWMtxwIecv/STKE+5AwOYZGrXlKyauBbzdakYhWS6Yy0SJHh
vIXCYX/BPPS3LxHnJKPEZOBhI+L7UNAJFJMIeyiHUq+7OOcYzTBLfuDMu1Qmb202
WaFvhOBiEy1llbjkwzfCFD8oiPo1bXvXenyWKDVr4rvJKX4qo/iL8+P9k82u/1oD
DBD8utP61w+W5Skj0boREFWwvDrlEcvNlCct+ZPg4BeWDCPik1PAx6E5//7BV9pp
XwC8UtuK5izkWFORbAXSla6mWduqasjXe3z8H4h+9dJZmGGEHbXY+qo34oNO9+5K
Up+UNfAAb7hj3IS2m0zWbbjPPjhV+J1G/SIGY6uLWOHJ7TLvF5fazb75V6BZC9OU
jEFWOSe+zt20mrgNFvhpvpnVXvlWuM6PLZjK4oFbYKw6jdgJpUcJxe1xTtMNCfWK
I7EgfdGDSC1d3NrvckuInlHhtzYY4M4AdOgI9xpMyTAmq+izO6PK90UvoJLeVbbO
e5uB2hS4PhSpBMtiG/IrkgM361mcY9bqKI1kgsQWyBOcRdP1HwQIU89/O/E6NeqI
ov/N/g/4TlbvE58bCBdhIKCJSQLDzioVxE0+BDA8Nlb29xQcou6k43aAYrQuxnjl
Y7Aqd8/6NNpR3cLve/kq
=mRDZ
-----END PGP SIGNATURE-----

--zjcmjzIkjQU2rmur--

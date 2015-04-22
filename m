From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 4/5] ASoC: omap-hdmi-audio: Force channel allocation only
 for OMAP4
Date: Wed, 22 Apr 2015 20:32:48 +0100
Message-ID: <20150422193248.GG22845@sirena.org.uk>
References: <cover.1429705991.git.jsarha@ti.com>
 <24329adf0076ff2ac004817a602c12db2ccc477d.1429705991.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="boT9Oj39GmgPxYhu"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:52654 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756668AbbDVTcz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 Apr 2015 15:32:55 -0400
Content-Disposition: inline
In-Reply-To: <24329adf0076ff2ac004817a602c12db2ccc477d.1429705991.git.jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jyri Sarha <jsarha@ti.com>
Cc: alsa-devel@alsa-project.org, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, peter.ujfalusi@ti.com, liam.r.girdwood@linux.intel.com, tomi.valkeinen@ti.com, misael.lopez@ti.com


--boT9Oj39GmgPxYhu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 22, 2015 at 04:23:00PM +0300, Jyri Sarha wrote:
> From: Misael Lopez Cruz <misael.lopez@ti.com>
>=20
> There is a constraint in the OMAP4 HDMI IP that requires to use
> the 8-channel code when transmitting more than two channels.

Acked-by: Mark Brown <broonie@kernel.org>

--boT9Oj39GmgPxYhu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVN/dfAAoJECTWi3JdVIfQz84H/jQCRRjilDh3qMk/b1vW/mmq
tG9+pWC/5WqVtgujeJY1E9f/wCi8o1DSa8oTSnYBHh1XI+sEwnM3aeNOnUrvLLNT
9PkvGvARM5GuJzZi/1G0/hY2gXY/eeD05gLVuseWLzQ3+ljurW2BIPfX9N3tG+Rb
K4ySrTnjrvolEn6CZWfk2WVxX6nPAja/X07r3no1yZclUxyhQwtZM88qVSG+E3wi
gC3unjZ2uuxBbdHbDayBpWp4ux/+gsqUeXGyPIKzRzOABvBxrvV7y3wR92wrQehg
bGdp0rFqvoOI9NT7BDsUmMTymSTGvfknvwHCt5eY9cnkPHU1hK5NXkQbmmh/Nmw=
=RMXA
-----END PGP SIGNATURE-----

--boT9Oj39GmgPxYhu--

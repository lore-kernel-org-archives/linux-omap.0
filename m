From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v5 07/12] ASoC: davinci-mcasp: Remove redundant
 num-serializer DT parameter
Date: Wed, 23 Oct 2013 12:15:43 +0100
Message-ID: <20131023111543.GM9388@sirena.org.uk>
References: <cover.1382110089.git.jsarha@ti.com>
 <1a9937bd0cad470b43e41a7fc537b354e2795535.1382110090.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pFpMklMRdxwSC3Yi"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:41798 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752425Ab3JWLQJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Oct 2013 07:16:09 -0400
Content-Disposition: inline
In-Reply-To: <1a9937bd0cad470b43e41a7fc537b354e2795535.1382110090.git.jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jyri Sarha <jsarha@ti.com>
Cc: alsa-devel@alsa-project.org, devicetree@vger.kernel.org, bcousson@baylibre.com, mark.rutland@arm.com, linux-omap@vger.kernel.org, joelf@ti.com, Peter Ujfalusi <peter.ujfalusi@ti.com>


--pFpMklMRdxwSC3Yi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 18, 2013 at 06:37:46PM +0300, Jyri Sarha wrote:
> From: Peter Ujfalusi <peter.ujfalusi@ti.com>
>=20
> The serial-dir array gives this information so there is no need to have t=
he
> num-serializer property in DT description.
> Just ignore the property in the driver the DTS files can be updated
> separately without regression.
> Update the documentation at the same time for davinci-mcasp

Applied, thanks.

--pFpMklMRdxwSC3Yi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSZ6/cAAoJELSic+t+oim9+ycP/RM0DthBmcs2ynQnuHKL8K60
d7job/Vwev+8DGPr1TIyxwW8QGs9HUP1uTRzxz/x43k15j8CCEJChaAm6dZRDDSh
1bEsKGa8OeOGJZebOWsdKs2WMg+GerCINqktbJCA0XWrWHM/cIhxLweITHZN3+2V
FUXQyTdOLeuovj3YgCrUA/DOCjuVkxS/uR2Jx4p9Sxj1EUDZiddJo2UW8ct6dup6
kbLT0rdzC2Ot4TEBgN8TZd9ApPzUMJy+HPfR3CZEMhnCpxRN0l+EioKhwezdInak
6r1rKeaNM60Ctmdcm6dtozzZ9K/fWwvAl2jm3vS7cub80rKC3BZuXTkWid/z5zX+
s+dPQAjmTolabShc1ULohK02gKzXgr+OVuVW6MHuK3ip86FhI7IXE3tOoI8CqTZv
NM8wuSQISvpvPyyeJD9XiJpLqi+SyzFRt5agqsETURLqFdLtTONnXvmyjcG66jgV
n0Cp5NeT867bhj6omuOQ17F84H7PZwu9HBm/eM1aRRDY5U9PR0NU9W2Q8WF2OFyR
D4s43QwNraib4q8JoCG/d0PTGdYetvQfQFkcGMuYbItR27841tWi7MM4BVXP8EXd
leoYxU60N0irDMMzrTk+hx6PN+WlAvxqyom2dr4jGNe+vVaknS97w9e1fv2IccaZ
2cYOBnb5kdmwsnn8XLti
=ZKCw
-----END PGP SIGNATURE-----

--pFpMklMRdxwSC3Yi--

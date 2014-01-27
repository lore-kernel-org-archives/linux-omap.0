From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH RFC v3 2/8] ASoC: davinci-evm: Add named clock reference
 to DT bindings
Date: Mon, 27 Jan 2014 18:10:40 +0000
Message-ID: <20140127181040.GA11841@sirena.org.uk>
References: <cover.1390836773.git.jsarha@ti.com>
 <a16e2a877740942c1742ac0da403013c72ae3727.1390836773.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vkogqOf2sHV7VnPd"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:60073 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753675AbaA0SKu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 27 Jan 2014 13:10:50 -0500
Content-Disposition: inline
In-Reply-To: <a16e2a877740942c1742ac0da403013c72ae3727.1390836773.git.jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jyri Sarha <jsarha@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org, peter.ujfalusi@ti.com, detheridge@ti.com, bcousson@baylibre.com


--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 27, 2014 at 05:37:51PM +0200, Jyri Sarha wrote:
> The referenced clock is used to get codec clock rate and the clock is
> disabled and enabled in startup and shutdown snd_soc_ops call
> backs. The change is also documented in DT bindigs document.

Applied, thanks.

--vkogqOf2sHV7VnPd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS5qEdAAoJELSic+t+oim9WWoP/0SM6K3pHlki2OWVZcgFCV/Z
xrL4ldRa5X/48PpIeH3ejs7VdrsPcOR7L73YOj+wQBWxOHF4/fCRTi/h2cslbQsG
tAqS/1DTrTKc5OoKwIlVbQPzsqeoNH7xD4wiDT2C6nE+kT7qKZXfIzKWvs5cwPD+
1TDQTxP/ZO5xJQdOjhy1g2B9SDmWHOHKTQUTUGQTVI+Xttr0vUrWRr0kn0VM0t6L
U+Mq50aS90pQZTxSTVN79Wbwc6dHi9NvlGGreKSu8FhySLEOJnnIs/WPfUC4Neg9
b/OZw5PQmj0DECPDsIIcG8BY/gbbZhUnaKYdB2Mi2wkyI1TGT1cNYZvLBRGRI8VH
BG4ZjqQEIrBe2y/b76G67MIY5AiJYO8wgof0v9W7IV/IkkhrOwNf70oGbfLNkx54
WHfJKHlwfxnvzlV71wvbrFeqXkWqzNuIWF9umaaV9qyJQFFxkUZe9gfGDgbLvq5u
4Ui5xGniO5zWFl7UEnlwTgZL4JjJ0OO4SGTmYiwo1FZuKt3iL/Vs+/PWc0SUeekV
3MwJjs6SyRRUIf5NyP9g7e+X4L92PFoD0hugjPAJEAJ/Tcl/Z5ukwc4T/RN88OZ4
PGR19VnrLUzVxV4/FultliQaZE35zLeJeLAo+aYDcglprhy1zgYuJ+BWc+EBfJqn
Av+NbHQPwtkPo5Bmf6vs
=MTS3
-----END PGP SIGNATURE-----

--vkogqOf2sHV7VnPd--

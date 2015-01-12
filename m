From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] can: c_can: use regmap_update_bits() to modify RAMINIT
 register
Date: Mon, 12 Jan 2015 12:05:41 +0000
Message-ID: <20150112120541.GD4160@sirena.org.uk>
References: <1420641162-8634-1-git-send-email-rogerq@ti.com>
 <54AFDCB0.5060908@ti.com>
 <54B39A8E.4090006@ti.com>
 <54B39BAD.4070604@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="T6xhMxlHU34Bk0ad"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:52680 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750927AbbALMFz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 Jan 2015 07:05:55 -0500
Content-Disposition: inline
In-Reply-To: <54B39BAD.4070604@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, mkl@pengutronix.de, linux-can@vger.kernel.org, wsa@the-dreams.de, kernel@pengutronix.de, linux-omap@vger.kernel.org


--T6xhMxlHU34Bk0ad
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 12, 2015 at 12:02:21PM +0200, Roger Quadros wrote:
> +Mark with correct id.

Please fix your mail client to word wrap within paragraphs, it amkes
your mail more legible.

> > The problem here is we can't use regmap_update_bits() because we need t=
o write a 1 to the DONE bit to clear it and _regmap_update_bits() doesn't a=
llow us to do that because of commit
> > d91e8db2c3bb regmap: Suppress noop writes in regmap_update_bits()
> >=20
> > Is reverting it going to cause other issues? If yes then can we have a =
flag to specify forced update?

The usual thing to do here is an explicit write clearing the latch,
either immediately after setting it or immediately before setting it.
If the register is marked as volatile and the hardware doesn't read back
the latched state that also does the trick.

--T6xhMxlHU34Bk0ad
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUs7iUAAoJECTWi3JdVIfQ1rcH/Rv/lZZU21G/vMYLWHT8Ug9s
sfrX37ho0UCgyhxNF9OoeZzD7b828cv9DWqT9domzLY8GZfsFthaoKdp/wrqC8Zs
+4K6yjIhJ3tQYcfEFV9gUkpqb5+ojgpxgU+ea4FNCaO3WWKkvdpDsd+E2jY4hCX/
cSMx8U8H+8AcTqr373qia5YNTs+vKM64cSP8COh0nDSTXht6Br3gfmPPT1RlLM27
v6fmFlbWdnzpLaWbcgOeeDkxjIizPeecev+mS+dPgm3yCaWeZrJ69qwSeAKo2NYo
oXsKtAeweXSQjgN77OprT+2AL80NOc5PnFtxqhYlb6lop83E7xGrsQdAEn95n60=
=XizS
-----END PGP SIGNATURE-----

--T6xhMxlHU34Bk0ad--

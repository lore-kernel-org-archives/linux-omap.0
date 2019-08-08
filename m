From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 07/22] ARM: omap1: move perseus spi pinconf to board file
Date: Thu, 8 Aug 2019 23:24:08 +0100
Message-ID: <20190808222408.GS3795@sirena.co.uk>
References: <20190808212234.2213262-1-arnd@arndb.de>
 <20190808212234.2213262-8-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kVhvBuyIzNBvw9vr"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190808212234.2213262-8-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Boris Brezillon <bbrezillon@kernel.org>, linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--kVhvBuyIzNBvw9vr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 08, 2019 at 11:22:16PM +0200, Arnd Bergmann wrote:
> The driver has always had a FIXME about this, and it seems
> like this trivial code move avoids a mach header inclusion,
> so just do it.

This appears to be part of a series but I've no cover letter or anything
else from it.  What's the story for dependencies and merging?

--kVhvBuyIzNBvw9vr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1MoQcACgkQJNaLcl1U
h9BTcwf+PZNQyv2QwRk6+uATv2Z/5jBqf59MD6hu+nPG7ZvewRhifHBZ0Wn0oGIy
LKuN77ve2quiHJEaXWc+6uMdkTKzHf0dq7PXzkSHvdGpKY8oXpfv+JxIP1fbvLU2
LjgoKVq4QXXKOwQKuPuBt6G5MFmPXLsTLnxo0C2CA8bBYHUhY1YNpslOiDbmN7kY
si0Og/am+P+msK+XEDu2s2waVhOEA9JhUJzNBSLvqdZnVrbKflMnJ1f+lqGPtJuf
G249qyMoeuoQoq7XX2OmvHk6MPxgjyFnANG88Pmz7kITgyC7M8cQbeMDsox6X5Wf
yZd+9ZI1XiupoEyUNs+MRVRuLA77Dg==
=Q0wr
-----END PGP SIGNATURE-----

--kVhvBuyIzNBvw9vr--

From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 02/17] spi/spi.h: Add configure from slave support.
Date: Tue, 26 Nov 2013 12:21:59 +0000
Message-ID: <20131126122159.GB14725@sirena.org.uk>
References: <1385451313-1875-1-git-send-email-sourav.poddar@ti.com>
 <1385451313-1875-3-git-send-email-sourav.poddar@ti.com>
 <20131126102951.GX14725@sirena.org.uk>
 <52948451.3060706@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ATpkSYPIqF1Y+gtT"
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <52948451.3060706-l0cyMroinI0@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>
Cc: computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--ATpkSYPIqF1Y+gtT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 26, 2013 at 04:51:53PM +0530, Sourav Poddar wrote:
> On Tuesday 26 November 2013 03:59 PM, Mark Brown wrote:

> >>+	void	(*configure_from_slave)(struct spi_device *spi, u8 *val);

> >Clearly this is far too unstructured to be useful, this is only ever
> >going to work with one specific combination of slave and master since
> >there's absolutely no semantics defined.

> I thought "val" might be good enuf, and this can be filled with whatever
> data that need to be used from slave into master(irrespective of
> slave and master?).

The name isn't the issue, it's the fact that you're passing a completely
unspecified blob of data.

--ATpkSYPIqF1Y+gtT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSlJJkAAoJELSic+t+oim9VXcQAIhBXc/XHSYdXg2Y3nKvxfgQ
HxzIioI22qfif8bxGUYVykYSUFL0RT2NSDYaCHq9U1xRarInqNm7q4DsOspcHF92
oax813MDaUBdShbRrk4WP8Yv2clWHZdXoHzyw+9hvH6OH64Xw02UnUALC662QXsX
jTq1ssAujINDtRQZQ8bbGFwwQRq/08nEyVDzb0uEgYwg8ogRUxhy+dvf3+7jZAEq
wc7NfAjfzADZAI5oh8aLjK66RyKTN1+7tho1E6VV0D5QIorRsSpYAE2jdtaM397s
d6HQV8h4Ele/cokKuUkrwmjx1goef6077z9tBFPChCZInn7f2/ZCRr/HCmlm/sqV
xuwD1yQtxbEc9wuvx2Eu4Jl+G5ZlNRAqyaP62vZb5CRasQuHTXQi0Bj2ybA6n374
LkzHToU/eee6fQkUM3+/W1xOfLwL3U0jJirM4yT62U+FkVy30dhZlmLLdKxG+Ag/
pqnbfsdi98RaN7MPFF32+n5QfX+bxtqTiZttL1mDWCmqGkMVnawg+MQV9qaftcpv
pqAP0pZTOSscmjfUWjKL7ieEClvwPB6ujF2CTTD7td6z8S/OnxcUUNFXEpqSzzEO
ja44xcvTLLgOK6fOr9JwkqT+QKgwuQHlMuNTYvlLmhM7z2hj06E93RJJN2vZByaa
b9NH1V/e7xt9XaXd5AY3
=XzZy
-----END PGP SIGNATURE-----

--ATpkSYPIqF1Y+gtT--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

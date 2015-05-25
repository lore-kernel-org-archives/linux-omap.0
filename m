From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 0/4] spi: omap2-mcspi: Fixes for recent updates
Date: Mon, 25 May 2015 13:00:12 +0100
Message-ID: <20150525120012.GH21391@sirena.org.uk>
References: <20150522122544.GL21391@sirena.org.uk>
 <1432433625-23407-1-git-send-email-mwelling@ieee.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="gX7DG0PufVj3JKBt"
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1432433625-23407-1-git-send-email-mwelling-EkmVulN54Sk@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michael Welling <mwelling-EkmVulN54Sk@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-next-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--gX7DG0PufVj3JKBt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, May 23, 2015 at 09:13:41PM -0500, Michael Welling wrote:
> The recent update of the OMAP2 McSPI driver left some unresolved issues.
> These patches should take care them and again allow for GPIO chip selects
> and native chip selects.

Applied all, thanks.

--gX7DG0PufVj3JKBt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVYw7LAAoJECTWi3JdVIfQEb4H/3aLrFvnA/3E2vbMxqTyKDV7
8vGlQbXVSuePP/Zvzy1EmTQoTwH0+GnJEDdbHek5EmFz6NSpQm0vcSIBRzsiC12H
FZhoMcIpCSSw3OYNnYGgchrY3ekMzT2+/yQiQTsCo7xE/Mari4QMZp8NnvfqlgPT
mXrDpO8VDduk5c8/l/N03En+ZeDVRTBEGdla7G8MO9Toea8Iuvt//tGq1gl+srXc
r9WuB5ODoNBiOmjvFg6AeJfYI15fTS2UkY3c10nbur/Gzk+APD3nNIAQ4JdcXmbc
l0yDJR21+gIB4qhCVbRjSPrFBdSh6JrPlyAzi0PnLKX10xhPHAozuTfOiSS8gaU=
=1S5v
-----END PGP SIGNATURE-----

--gX7DG0PufVj3JKBt--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

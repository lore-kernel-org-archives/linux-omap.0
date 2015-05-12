From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: omap2-mcspi: Fix native cs with new set_cs
Date: Tue, 12 May 2015 20:19:05 +0100
Message-ID: <20150512191905.GY3066@sirena.org.uk>
References: <1431452337-19280-1-git-send-email-mwelling@ieee.org>
 <55524D20.2050203@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="gu8wNMO+QVC0jLZM"
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <55524D20.2050203-l0cyMroinI0@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Cc: Michael Welling <mwelling-EkmVulN54Sk@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-next-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--gu8wNMO+QVC0jLZM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 12, 2015 at 01:57:36PM -0500, Nishanth Menon wrote:
> On 05/12/2015 12:38 PM, Michael Welling wrote:
> > GPIO chip select patch series appears to have broken the native chip select
> > support. This patch pulls the manual native chip select toggling out of
> > the transfer_one routine and adds a set_cs routine.

Please remember to delete unneeded context from your replies, the reader
shouldn't need to page through the entire patch to find out you reviewed
it.

--gu8wNMO+QVC0jLZM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVUlIpAAoJECTWi3JdVIfQEE8H/R7r+NNIRpsTNNhbK03r42gz
SdEx4o8oUb2LRf/1j7SAFCw2jWqsoqCr+WzxSd1sq0pZFJqRTRfs3ySUy7MP+yed
wrXcn5IsFw2s06YI9zP7ioYj/ny8SdqAJJItbcvnwR1Skj4f5W+KeRimj1ZBJ1FG
209TiNBNiUGvpGbhG1tLbNgKqsLGp1UjZ+r9inrO8B45kp+6sGJGQ/FDCplcJUKr
Xkij8/KbPWkVmBragBNtY0V2MOzZDTt/t7tbFt40wOJDnLXn1pnRKLFyaN8p3F9k
iQ7veaaE4DMW11AUun7eFf+nj3bEmRdvK7Ia6lgvUqp7X8HAHJJ2ozp6mvALUzw=
=cH+s
-----END PGP SIGNATURE-----

--gu8wNMO+QVC0jLZM--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

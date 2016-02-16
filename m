From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v5 3/5] mtd: devices: m25p80: add support for mmap read
 request
Date: Tue, 16 Feb 2016 12:38:54 +0000
Message-ID: <20160216123854.GJ18327@sirena.org.uk>
References: <1449807000-6457-1-git-send-email-vigneshr@ti.com>
 <1449807000-6457-4-git-send-email-vigneshr@ti.com>
 <20160209193616.GN13270@sirena.org.uk>
 <56BC1D3E.5020203@ti.com>
 <20160212223711.GD18988@sirena.org.uk>
 <56C2D731.6050306@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="HSQ3hISbU3Um6hch"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <56C2D731.6050306-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, "hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


--HSQ3hISbU3Um6hch
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 16, 2016 at 01:30:49PM +0530, Vignesh R wrote:
> On 02/13/2016 04:07 AM, Mark Brown wrote:
> > On Thu, Feb 11, 2016 at 11:03:50AM +0530, Vignesh R wrote:
> >> On 02/10/2016 01:06 AM, Mark Brown wrote:

> >>> Looking at this I can't help but think that spi_flash_read() ought to
> >>> have the stub in rather than the caller.  But given that we're pretty
> >>> much only ever expecting one user I'm not 100% sure it actually matters.

> >> Well, my initial patch set passed long list of arguments to
> >> spi_flash_read(), but Brian suggested to use struct[1] in order to avoid
> >> unnecessary churn when things need changed in the API.

> > I don't see what that has to do with my point?

> AFAIU, your previous comment was to move initialization of
> spi_flash_read_message struct to spi_flash_read(). This would mean

No, not at all.  I'm talking about how we handle the case where we don't
have hardware support for this and need to implement it in software -
currently that's in a separate place to the place where we call the
driver.

--HSQ3hISbU3Um6hch
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWwxhUAAoJECTWi3JdVIfQVM0H/j64x3bLpAv0cTZC+2n0VAOm
5oSygJJOfQqjzFBhmpPdJfd1BvVzJnSb7Lh42eGLlehbABTwyHc5upivQNti/D5H
FYwmZDhCge7Ewj0YDB9Q2StXsUKw1X0QMFFlRXMZlB06TkBIKYMfp04jorAs9ZdI
osCAbMdjt/bZ9EqMxEcR+Mief5y1BYEVZS3ridmPtBazefEhNBkQ43yvwXNIPdkw
yRxBFlDLteJO1E1+bUbumGFj8cb1jC2DvuG6PjuQUJ14g+gZ+f02FHQ5XH+uuAGu
0RPS4Jqm6YM0Nv00H8rRj8PWYglqqLwUcHT4gNcW6vOtgu/6AX04dcVuak0zY2w=
=m7oA
-----END PGP SIGNATURE-----

--HSQ3hISbU3Um6hch--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

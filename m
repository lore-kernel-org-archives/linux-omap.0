From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 09/17] spi/spi.h: Add "mem" variable in spi master.
Date: Tue, 26 Nov 2013 13:20:51 +0000
Message-ID: <20131126132051.GO14725@sirena.org.uk>
References: <1385451313-1875-1-git-send-email-sourav.poddar@ti.com>
 <1385451313-1875-10-git-send-email-sourav.poddar@ti.com>
 <20131126130119.GH14725@sirena.org.uk>
 <52949C9F.10008@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qYpwwOSOoAAr8PNn"
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <52949C9F.10008-l0cyMroinI0@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>
Cc: computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--qYpwwOSOoAAr8PNn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 26, 2013 at 06:35:35PM +0530, Sourav Poddar wrote:
> On Tuesday 26 November 2013 06:31 PM, Mark Brown wrote:

> >Is this really generic enough to put here rather than in the driver
> >data?

> The thought behind this was that if a master controller supports
> memory mapped operation and slave wants to use memcpy in his
> driver(bypassing spi ), then we should have a mean to communicate
> between the
> master and the slave. So, 'spi_master' seems to be the place for me
> for this data,
> which could be parsed in the slave side also.

I would have expected that the address would be returned by the function
that maps the buffer in rather than stored permanently in the master.

--qYpwwOSOoAAr8PNn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSlKAvAAoJELSic+t+oim9w4QP/16Y18APhav+poBt0dc+Q5IN
WeVvrv16jzZ+tqNCox+MdLDQsl20CGiPlq/pBwVXYm8fZetkajh5a/h2oofIqqy3
tqYfaFg5u3aYBd6iCdKCm3hJyY29LKCu7ecpo4iPic9riP0ErUUtag4qKhXRkZB0
GkHdBv61oBK1nFLnu24Ke6JCS3BuYl9t5MtkyvTi8cGhGZbNjD4B7as9jo5MMXPq
FITMgmRjMSQV0VfUvWLnjC1F97TCA6g/7tIYrGuh+3yBJrV4kX+qKRcuBXMCCp7J
cEtChhpseTGEQ+r+zbFaDzngE3i+xy4IncoFlDKCfRnO4CXsWP7bbQHHOoKSdrM+
lZaWnRVAVBGb6fiVgDQ5BPDyUDWj9jJWp6s+EurymGwNtiMCKnkZDj+1EA12vOnZ
kk6NMhYGxBgJ0kYD89bebqrI+CF1fCEoo/20wdgfH7z1uTQf0i7pkHG5lz7EUwKo
hYQUxA/8l1bwy+ojy2KgeidDp/VV/ENBvCp76cnOnziGqzXolg3d+kLTB3RoJcKm
h6WCSBlvdDQkyKJ7CwBOdsec5J2la4CF1zSe8T+wIBMcRTA/rjgAWqEhsMOSCIKg
AjwGJ52C+e4r2vdO1aZ4T1d0/zrW7HKGotualIC5P6tbujgGtZM9tdv/cROVOHzb
MgC1oQMrSoEN3M+tCgsy
=aoaK
-----END PGP SIGNATURE-----

--qYpwwOSOoAAr8PNn--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

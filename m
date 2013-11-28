From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 03/17] spi/qspi: parse register by name.
Date: Thu, 28 Nov 2013 10:54:23 +0000
Message-ID: <20131128105423.GL14725@sirena.org.uk>
References: <1385451313-1875-1-git-send-email-sourav.poddar@ti.com>
 <1385451313-1875-4-git-send-email-sourav.poddar@ti.com>
 <20131126103029.GY14725@sirena.org.uk>
 <5294835D.5090902@ti.com>
 <20131126122442.GC14725@sirena.org.uk>
 <5296CA5A.90304@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="68RnY3phKFzO6ir9"
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5296CA5A.90304-l0cyMroinI0@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>
Cc: computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--68RnY3phKFzO6ir9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 28, 2013 at 10:15:14AM +0530, Sourav Poddar wrote:
> On Tuesday 26 November 2013 05:54 PM, Mark Brown wrote:

> >Do device tree binding changes early on in the series rather than at the
> >end, one of the things that gets reviewed for is binding updates.

> >Your code should also cope with the existing bindings, falling back on
> >the current behaviour if it can't get the names or the extra resources.

> My current code only has a single resouce, hence "*_byname* variants
> was not used. With extra resources, I am switching to "byname" variants,
> So, if a particular resource name is not found, it should just
> bypass that, thinking
> the resource is not required and should not resort to existing bindings..

That means that if you switch all resources to _byname then the driver
won't find any resources at all and will fail.  This will in turn mean
that any device trees that work with the current code wil start failing,
breaking compatibility.

--68RnY3phKFzO6ir9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSlyDcAAoJELSic+t+oim91+4P/jM06YP0DjMjcHcJ5d2+Rhwk
Nq0wjmsFp7UrOfZTJ51+FdP7jX/NOxWujBfLmzBuCTOBgcOkGnhrOnSlFdoI1WmB
8hc7R4aNJtG6IScvzX1h5v8AgAQ583UkxgmaelLDwOqYnxfN+5vLlc38h8kzaYS2
1BaAF9X2OBTEDks7BQR7ULUitylpvBuVdSUNHZVV1mOaDeiVSHJwBj2euwT+0zNj
PQq5N6hjPjryHak59jbVyEZK1nWmmOTZxtPpLwDodnuiUKcbgzz7gosRsPFnIlBf
DEOx8N7+qqtKjqtbCnocBn1bzFj7pdZu/9jSavMomLW/DsVuQs5l37XMad+MTdEA
T4uTCmGPe/Xjt6CA9F6jwAiKRIvLFXMr4g1VM8J0HDuDdOF1b9LhaKHaRaOZTGxD
wPwgpsJsnXbeULwwEMHsQKz2mRR67WedkhfxcLLJS0iCYPdDuAx95FUvKmy01b/Z
53pa5HDioHT8qwgWhfYI5WglZjlS9O2ts/0LMpRqT0pOyIXUKu1Yd6O8TTSDdsvV
o7gSQkbFZTQEDDq8gdVaxlIkxCPX31p3DBfsPZTfZIuYOPQDFSWDGEgdGMvjOlDT
haEM8jYKWhMs9UIOUnpLdCQEUIy0daJJP6Hs3NKLhDG948WeTSEDo/DI7VBAOH1y
djmRvEbZ2qrCzxvf0dGi
=JSk2
-----END PGP SIGNATURE-----

--68RnY3phKFzO6ir9--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

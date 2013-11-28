From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 03/17] spi/qspi: parse register by name.
Date: Thu, 28 Nov 2013 11:11:52 +0000
Message-ID: <20131128111152.GN14725@sirena.org.uk>
References: <1385451313-1875-1-git-send-email-sourav.poddar@ti.com>
 <1385451313-1875-4-git-send-email-sourav.poddar@ti.com>
 <20131126103029.GY14725@sirena.org.uk>
 <5294835D.5090902@ti.com>
 <20131126122442.GC14725@sirena.org.uk>
 <5296CA5A.90304@ti.com>
 <20131128105423.GL14725@sirena.org.uk>
 <529721BF.4010902@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NRam5+CokH1YmQkV"
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <529721BF.4010902-l0cyMroinI0@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>
Cc: computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--NRam5+CokH1YmQkV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 28, 2013 at 04:28:07PM +0530, Sourav Poddar wrote:
> On Thursday 28 November 2013 04:24 PM, Mark Brown wrote:

> >That means that if you switch all resources to _byname then the driver
> >won't find any resources at all and will fail.  This will in turn mean
> >that any device trees that work with the current code wil start failing,
> >breaking compatibility.

> I am changing my code to use *byname for all resources. There is no
> dts available now in mainline using this code. I have added the dts file
> as patch 15, 16 of this series to take care of this.

We're now aiming for DT to be a stable interface and the existing
binding has been included in a release so you really ought to be keeping
compatiblity.

--NRam5+CokH1YmQkV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSlyT1AAoJELSic+t+oim9YmoP/2RBtxLNwr9hc9Sk6IPY3zNm
Ye1vErbzXwh84BQsYy0hExjXvqqyjTT5iugsY4qBTt9iQ66QqAd4bxyc5aj/YboF
U46yX8t8omiZoMpsjZZWGiYKSeitoTGHeQxQHXyKm7kjXfcME/MrgC/vMrRT6amK
J73W7dfBQBGZXD5m8a0+8COhuzAQPxMk96H4C+YSMKZrKKpQQ/Aapo5Hn06GTb1c
txzTTIFZ+FszsTalvOjcdHQ7wuCIV3NoST5OXEB5DLsPtU3Ha2NMY/f1SYKPBWYx
uAK0AVtL8PW/Jg68uinGQ+RZxFGaoZpWV4TW1NvkPtrRtAn/Ia+9lrlqh3X+Z9pR
amNXtUZJlewnzLpbrjWL19X4W4xQGrO5DiKJE1P+N1XU5PFNC7waq2ZzgZlrrazO
tBx+J02S2zaOFSwAdGA3NJj9l07AJyR/g6sktifScxh1b14Q6v2VC2fLGyGTv9xd
b7Ae2/V0sK/D9xxINj89Cp9clAjkh/lDj+oViVdUahT9jHBqxUj0csIw+7NjcRqb
eIhc3R6b7aN7gU3+gHrANvmvgvwCRj5DWxB4RmAeA1CN0t/RFqg6ytk9TE6bJ3e+
zBXGNAP0kYZWZR5xX7cazglpcTvCoIej6m5yMwbS1Hu7ckxfci29SqV9cZ6mEMDm
xhyfGL2yS6WFZJUpCx9i
=5gwB
-----END PGP SIGNATURE-----

--NRam5+CokH1YmQkV--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

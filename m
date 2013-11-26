From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 01/17] spi/spi.h: Add get_buf/put_buf support in spi
 master..
Date: Tue, 26 Nov 2013 12:38:14 +0000
Message-ID: <20131126123814.GE14725@sirena.org.uk>
References: <1385451313-1875-1-git-send-email-sourav.poddar@ti.com>
 <1385451313-1875-2-git-send-email-sourav.poddar@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qvqe4mReYAfpWQmG"
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1385451313-1875-2-git-send-email-sourav.poddar-l0cyMroinI0@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>
Cc: computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--qvqe4mReYAfpWQmG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 26, 2013 at 01:04:57PM +0530, Sourav Poddar wrote:

> Add get_buf, put_buf api support in spi master.
> This can be used in a scenario where spi controller

I would expect that while the buffer is mapped the controller would be
unavailable for normal SPI API use so I'd expect some code that checks a
flag while a mapping is in place and errors out on normal SPI operations
during that time as well as the operations themselves.

--qvqe4mReYAfpWQmG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSlJYzAAoJELSic+t+oim9BzYP/1ga7pIG7+8CG5+n2KG0w0S6
7YN4dRfqF8RKGISWaAQpjEvVKdZbHez6s1OXhnCzUv2duORyrZZIpFJRGM049P8M
xszuw5Go10phl+IaWlIYRQl5CMZe1ObUsKJNCBlkCL3ZMmvvEaiSK+T28e5MXEan
82ZlgW1j+ZX+rBPNOGmeEzyaa1AKmYVj9/9fUrUVzl+dEQjeHC2CfrOd8UJuv7JX
79wgV9zrm8IkttkylDTrt+mM4qoxvBiAmIu+EM6A8HDlYUiKEVLN8iGDn4Cshrnb
zfuKGxntuDDDVvyK4yMaQMfbeLs6Ku2YCeZ5WyO34M0a/7gskC/lfAM+Ppb7rn47
LszJw1mFVwGn+JOJOVpHb0J1md79K7WQvYF05fFv5Kw+xaEcPMD2g7flwhMTnmlj
MBKlkQmAuZAkHFFLBTb/yNAc7v8eDmpDFV1meHfLF2N1eTc3lIP50rtY71gk1vKp
eKwGjCX1GxHpV4QvHm1nQ18JjJB1IQelAQGY7DVPLPU3ljSoCE7ToX0W6/CjmAJT
z71X4J+/qwz6Qpg5nBkbZVBvLsYX+33pJ4WRppDjFK54TLGM8SZiZ4oubTDRAuv6
0NwdAIieorOF767T0QCPJL+um9timylrnEkSeyqLVkDIAX26OtHJChUHXcmLsr6S
CBmp1M0ObDFltQ6XNVrU
=peMD
-----END PGP SIGNATURE-----

--qvqe4mReYAfpWQmG--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 12/17] spi/qspi: convert driver to enable/disable memory
 mapped.
Date: Thu, 28 Nov 2013 11:59:34 +0000
Message-ID: <20131128115934.GE27568@sirena.org.uk>
References: <1385451313-1875-1-git-send-email-sourav.poddar@ti.com>
 <1385451313-1875-13-git-send-email-sourav.poddar@ti.com>
 <20131126131138.GJ14725@sirena.org.uk>
 <5296D37C.2020003@ti.com>
 <20131128104922.GK14725@sirena.org.uk>
 <5297242B.3040807@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Rgf3q3z9SdmXC6oT"
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5297242B.3040807-l0cyMroinI0@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>
Cc: computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--Rgf3q3z9SdmXC6oT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 28, 2013 at 04:38:27PM +0530, Sourav Poddar wrote:
> On Thursday 28 November 2013 04:19 PM, Mark Brown wrote:

> >Removing the mapping isn't going to stop another context which has
> >obtained a handle on the map trying to look at the mapping.

> hmm..so the  'memcpy' part should be made atomic.(if possible?).

Or holding the memory region should prevent normal SPI use (so any users
ought to drop the memory region when they don't need it).

I'm still a bit surprised there's no DMA controllers for this...

--Rgf3q3z9SdmXC6oT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSlzAjAAoJELSic+t+oim9mWgP/1oKd71Ma/FCU/BgwqSdb15o
jNR1cYzey+ee20vaJ57iWrH7Pdb/+wQPOYacGp/wt3TL/1ijP4/2YxyJS5fAGaD6
nt1ExAB6G1wKI2sf1D9u5CdwSwbZqfb7BlS1S6TIT1YQ73GaT0tTLZz4iausJy0E
yzYp6ygnxT/JFOitDYzlGo2pDb2QIzfIuHxwMQur5cGj7TrX+wyuLJF91QGqpL5O
v3E0HPm9h6c0YYQ64j9ckC2Jsj6qmEJ6rhDUa2YfWW1sj3ooAykpG86VRI65NXvJ
mtELJH9lKWOJQIWhQLhacCKG2wZQZq8zHgKg06YOnlLtghaZseJDnRorKJj1Jbgy
P5LIQfUbMNgU0TAjP2UaElFi58sQmqrr/GskESE4PD8Ui2HIOfxeTRAkbZ9q+vAo
Y5Dowi6+cTAVpK3cfiUC+MPVg+Avmoms7DhQCLaxq6k08yzp9lYK58/HHCvsuq0u
96ZxJy7uzoTZwiDU2oKDIfHdEKptRoC9lvmQ3QOLXSmK65FGU323S4j4Jh/2xdUL
3W/0g8O8qvaD1PwxrBHiQLGM4EhVbemEms32BUa3QUrbfFO7DKh4SBp2Wx2v1Nal
L/AzkFiPOwMNAvBLQIHfASt8lUcj7+MCAiuRgV1rPifzv/mGWrgJx3KgRRzjeiw9
XTea0S2RC6sT0gLpT5Xn
=RrTP
-----END PGP SIGNATURE-----

--Rgf3q3z9SdmXC6oT--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

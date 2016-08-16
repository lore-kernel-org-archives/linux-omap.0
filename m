From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v5] spi: spi-ti-qspi: Add DMA support for QSPI mmap read
Date: Tue, 16 Aug 2016 19:42:53 +0100
Message-ID: <20160816184253.GC9347@sirena.org.uk>
References: <20160809110311.13521-1-vigneshr@ti.com>
 <20160809113329.GA9347@sirena.org.uk>
 <13e676c2-7e2f-d1c5-5312-bc2e11a6b6a1@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="bS87dHSPlkoPpvQ6"
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <13e676c2-7e2f-d1c5-5312-bc2e11a6b6a1-l0cyMroinI0@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--bS87dHSPlkoPpvQ6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 09, 2016 at 06:20:01PM +0530, Vignesh R wrote:
>=20
>=20

> According to this thread[1], converting virtual address
> pointer into scatterlist which is then DMA mapped is unsafe on systems
> with certain cache architecture. Hence, I added code to handle kmap
> buffers inside the driver rather than updating generic spi-core code.

That's saying that things that aren't covered aren't DMAable safely at
all which is a more general issue...

> If its okay to update the spi_map_buf() to handle kmap buffers as above
> then I can submit the patch accordingly.

Yes, the whole point is that this is all in generic code so drivers
don't need to worry about it.

--bS87dHSPlkoPpvQ6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXs16sAAoJECTWi3JdVIfQZiwH/RtMuJba3YSE2zXr3uWKoi/7
6AIQtUwq0nVQmTkZm53C5WNIz5AdPEcdNu6VabdUXLn9KkjT46UX92bTfvYsfo6D
c8bsAvP/FEZ6hRJOxHyRxb2yqpE3qXiWtdwM1su+5UBPmNV7YJPDSRtA/V4MP97y
kLwla79M056k+T+BHIT9MB9yq8oWAZTIDWXoYdkN8JKVroryLOfkPfQegGN1Gxem
YQKhxKpY3zvH14h6mdC+Xjar9hoLtGQ2EnitBSpwiG+zj0Xm5ZPNJFGf79foj28Y
Dn+oHlfXxSJwSsVex9WJurx3RA4VndCVqJY3w1G8kulhpFXh7NnOHhk8XVzH8ZA=
=H0d3
-----END PGP SIGNATURE-----

--bS87dHSPlkoPpvQ6--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

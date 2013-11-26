From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 11/17] spi/qspi: set "mmap" flag to true.
Date: Tue, 26 Nov 2013 13:10:29 +0000
Message-ID: <20131126131029.GI14725@sirena.org.uk>
References: <1385451313-1875-1-git-send-email-sourav.poddar@ti.com>
 <1385451313-1875-12-git-send-email-sourav.poddar@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Hv6+fPJLRRhGCb8a"
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1385451313-1875-12-git-send-email-sourav.poddar-l0cyMroinI0@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>
Cc: computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--Hv6+fPJLRRhGCb8a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 26, 2013 at 01:05:07PM +0530, Sourav Poddar wrote:
> Set mmap flag to true to indicate that the qspi controller
> supports memory mapped operations.

Please combine some of these patches - adding the mmap support and then
separately adding this flag isn't really helping bisection, just have
one patch enabling support for mmap in the driver.  Similarly adding
internal functions to the driver with no users and then separately
adding the users isn't really adding much.

--Hv6+fPJLRRhGCb8a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSlJ3CAAoJELSic+t+oim9qTAP/3HF2Dvj+nrz1AAfzimO/Tpw
enPY+0BiL+GEvILe2n4yZMGu+HTlHW5hHw8qCtYcYnAa0z4kuQ6K9d799KO+j6PN
mqPet1yMdlo+XK5rl5bDFrMyDPrEn6GbagTDDzjckmky8smcJwUigX44gnD9vePT
Skq9I8gN7giMRkSfZZZ1a7gqtGr+0sodsowRtfPgRakX6ypSEanX6iwpvfE/xvmx
4uFeM3epJ6nzkPdQsEcTViIrN0Hnv8oN+/NA07rXOj7JugpEkXGtYkRxOfdDjkdv
eW4zgYYvdyt8EMGk+UUuWFzDLrg3E9HIrTvJcijj5LDwWPk7e7/Bx90sazTy5hYZ
8TmIiU3BR6uhA/PenjiUeBrhxHNx5MJTrPqAax8sc8JI29FePvClfGBdy6Gos6lU
FplHwE0tMC4x2v2QGXHYC4nSxuO1iwjuCSR9p81AD2qVoCt6W3TclpJ7QLkSkleO
v1TzpwuHl29VSv8qi80dvX5cszjkhvArrcOU7G9w1UOdfDK4rg6fYQV1BuoaRm0x
iTYwtmgOwRdLYfqhboGY+wrMiNJ1C6uk2Ff0FY8e+Oh9XHJG6xmDm5+D29FVxiXZ
PW5X383CaG6Ep02iM9dngrQa/8S+R3a/AwOkwGxtl8xfu7HyWDb4ggawQg+f0GCj
gKa1wom/rMk4/gh/zgOi
=OYKO
-----END PGP SIGNATURE-----

--Hv6+fPJLRRhGCb8a--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 2/5] spi: spi-ti-qspi: add mmap mode read support
Date: Wed, 4 Nov 2015 14:41:12 +0000
Message-ID: <20151104144112.GJ1717@sirena.org.uk>
References: <1446545174-14193-1-git-send-email-vigneshr@ti.com>
 <1446545174-14193-3-git-send-email-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="J2uG6jHjFLimDtBY"
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1446545174-14193-3-git-send-email-vigneshr-l0cyMroinI0@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--J2uG6jHjFLimDtBY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 03, 2015 at 03:36:11PM +0530, Vignesh R wrote:

> +	ti_qspi_enable_memory_map(spi);
> +	ti_qspi_setup_mmap_read(spi, read_opcode, addr_width,
> +				dummy_bytes);
> +	memcpy_fromio(buf, qspi->mmap_base + from, len);
> +	*retlen = len;
> +	ti_qspi_disable_memory_map(spi);

We'll be constantly enabling and disabling memory mapping with this.
I'm not sure that's a meaningful cost given that it doesn't actually
remap anything but rather just switches hardware modes, we can always
optimise it later if it is.

--J2uG6jHjFLimDtBY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWOhkHAAoJECTWi3JdVIfQrmcH/RSv12IrXq3lgkOLUxuYhAZj
YOjt8j86vy59wUu+5W/9xdgcAnrL3mOWhJowkBCgY6108OkKhlgxBgnvmqGbQu8V
Qu2sKe4sPQp/rnajAKPL8epEjegIkeE3mumUKN9tbKxraf8uVVS7thibwPPY0qwm
m/OFxiu6+9RLHJ+Q1iBXHDV7ePbJU+eRl6+BKaWYMjHfgW9gw8ktZFX6hjnTG0vC
6FcOCp1kdcgOn5GDwUthIyQOzHqtLv7qL+SkSLEeMdFG12FPyX5sN/k/c0WakBIw
qC2rWHcTTfRHy/o1XZ/oM6osCtkRBaglWeUpXXVg5KTMZHgONyume4GHLMIVAAc=
=vwZN
-----END PGP SIGNATURE-----

--J2uG6jHjFLimDtBY--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v5 3/5] mtd: devices: m25p80: add support for mmap read
 request
Date: Tue, 9 Feb 2016 19:36:16 +0000
Message-ID: <20160209193616.GN13270@sirena.org.uk>
References: <1449807000-6457-1-git-send-email-vigneshr@ti.com>
 <1449807000-6457-4-git-send-email-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Ie5iOtK4e9kgqh2F"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1449807000-6457-4-git-send-email-vigneshr-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--Ie5iOtK4e9kgqh2F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 11, 2015 at 09:39:58AM +0530, Vignesh R wrote:

> +	if (spi_flash_read_supported(spi)) {
> +		struct spi_flash_read_message msg;
> +		int ret;
> +
> +		msg.buf = buf;
> +		msg.from = from;
> +		msg.len = len;
> +		msg.read_opcode = nor->read_opcode;
> +		msg.addr_width = nor->addr_width;
> +		msg.dummy_bytes = dummy;
> +		/* TODO: Support other combinations */
> +		msg.opcode_nbits = SPI_NBITS_SINGLE;
> +		msg.addr_nbits = SPI_NBITS_SINGLE;
> +		msg.data_nbits = m25p80_rx_nbits(nor);
> +
> +		ret = spi_flash_read(spi, &msg);
> +		*retlen = msg.retlen;
> +		return ret;

Looking at this I can't help but think that spi_flash_read() ought to
have the stub in rather than the caller.  But given that we're pretty
much only ever expecting one user I'm not 100% sure it actually matters.
Anyway, I applied the first two patches.

--Ie5iOtK4e9kgqh2F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWuj+wAAoJECTWi3JdVIfQ1X8H/2RT2Qyt7866DsiogZkzSEDL
KBGCrfAapFj8N21nCesp/ap88F+iCqSCyRB8W8xAtNEawl23/71tY8G5aEqfJbCW
FWnJrddQk1wdJj93uxbZFIdj1Dgqn1savkFr+nuTVjLCLdPYlJWK+G4a2ZkSXdj5
qMJDvlPDUJgO6P7OYIh/DETPtwcPVVTe9DPMboZBetGLiVXfgBrWwHhyddkt3VTb
OmqoZ4W9m2AUwbZ5PVv1EWOzZlAXGh6vhNS57LlGAA/OcoQGEZKzq8Qmjp+G1whg
A4KmvHz8xzZJnv6hiDETBWWqivrRCUltZGB4k6HphFR2CJdhLMopj7+E1xHY0lY=
=DJI7
-----END PGP SIGNATURE-----

--Ie5iOtK4e9kgqh2F--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

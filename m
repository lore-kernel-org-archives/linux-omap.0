From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/2] spi: Add DMA support for spi_flash_read()
Date: Tue, 12 Apr 2016 05:31:15 +0100
Message-ID: <20160412043115.GV3351@sirena.org.uk>
References: <1459828192-5531-1-git-send-email-vigneshr@ti.com>
 <1459828192-5531-2-git-send-email-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="gPQW1Pk7T/0rhUBV"
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1459828192-5531-2-git-send-email-vigneshr-l0cyMroinI0@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--gPQW1Pk7T/0rhUBV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 05, 2016 at 09:19:51AM +0530, Vignesh R wrote:

>  	mutex_lock(&master->bus_lock_mutex);
> +	if (master->dma_rx) {
> +		rx_dev = master->dma_rx->device->dev;
> +		ret = spi_map_buf(master, rx_dev, &msg->rx_sg,
> +				  msg->buf, msg->len,
> +				  DMA_FROM_DEVICE);
> +		if (ret != 0)
> +			goto  err;
> +	}

This is unconditionally DMA mapping the buffer if DMA is supported.
That's going to be common but I'm not sure it'll be universal, we need
to think of something better here.  I'm not immediately seeing what
though.  Possibly a flag...

--gPQW1Pk7T/0rhUBV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXDHoSAAoJECTWi3JdVIfQ7gUH/iASryu9N/Ltr463xmf0o3+4
F80vdBVApn0n4QzOCzt4nQ5A4drvf+C9neWAFWHFGdHmW9pysx4cRc+FPnsAVc1Q
W15QKlqQhxC7KHAr16KScTJuLwT9/EH9WYDMwk+I+a+4OE+COEWJi/XPjwn3Jl6J
Fwdppq0PNkNr5DTBi2AOYufErk7WWcJAB8uQ+3Dn+w+PL1CtQ6zQ7iTGJ67MZ9yj
cqhZ+gQTsWBrBcePrmEX0NmHp6Y13dzVOAu9v7SjYT3n/0CaAuBtj7ec3yg4FxJF
AlPWSMREqe9hZndHQ1ONuYrjw/gQP5TAL1vFrEZRMfBN6zggd2sCSytL56vQtb0=
=SQHo
-----END PGP SIGNATURE-----

--gPQW1Pk7T/0rhUBV--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

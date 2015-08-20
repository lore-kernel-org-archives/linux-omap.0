From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] spi: ti-qspi: use 128 bit transfer mode for writing to
 flash
Date: Thu, 20 Aug 2015 10:55:14 -0700
Message-ID: <20150820175514.GG12027@sirena.org.uk>
References: <1440066659-5356-1-git-send-email-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="bFsKbPszpzYNtEU6"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1440066659-5356-1-git-send-email-vigneshr@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vignesh R <vigneshr@ti.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--bFsKbPszpzYNtEU6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 20, 2015 at 04:00:59PM +0530, Vignesh R wrote:

> -			writeb(*txbuf, qspi->base + QSPI_SPI_DATA_REG);
> +			if (count >= QSPI_WLEN_MAX_BYTES) {
> +				u32 *txp = (u32 *)txbuf;
> +
> +				data = cpu_to_be32(*txp++);
> +				writel(data, qspi->base +
> +				       QSPI_SPI_DATA_REG_3);
> +				data = cpu_to_be32(*txp++);
> +				writel(data, qspi->base +
> +				       QSPI_SPI_DATA_REG_2);
> +				data = cpu_to_be32(*txp++);
> +				writel(data, qspi->base +
> +				       QSPI_SPI_DATA_REG_1);
> +				data = cpu_to_be32(*txp++);
> +				writel(data, qspi->base +
> +				       QSPI_SPI_DATA_REG);
> +				xfer_len = QSPI_WLEN_MAX_BYTES;
> +				cmd |= QSPI_WLEN(QSPI_WLEN_MAX_BITS);
> +			} else {
> +				writeb(*txbuf, qspi->base + QSPI_SPI_DATA_REG);
> +				cmd = qspi->cmd | QSPI_WR_SNGL;
> +				xfer_len = wlen;
> +				cmd |= QSPI_WLEN(wlen);
> +			}

It's a bit sad that this isn't able to do a Duff's device type thing and
only kicks in for the full 128 bit FIFO size, it looks like it could do
any number of words.

--bFsKbPszpzYNtEU6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV1hSCAAoJECTWi3JdVIfQRXYH/iI7LZuKRZcpcs1MGs/YjXEU
09E7wf8vNwRKaa+X3j2hTFiZi9deXyBeYzHYIrFpAbSyI33vZeF4P5IoEmRUMG6s
zrVfh9KLl23Lrl5lCbx1ZeJ+0R9GrBQFPtR28U+bCjnvrexMD3oSKQ9u06Mmu3Hw
YndZK2VK9j2wc4BiBJUYVOjbDSUY25CcaNIzrjpRcERuwHj+IYPe4fsSJL6jrQEW
mwZ/XqpH4xDCr9BQ0SzSZ1YhLrNswXvvAy/fBQHUCqFmAE8B/mhic4Gs9UQ4sRQF
V4rD4FgGuUC329w7tg4r4mvVtKN8I0e5+ZnAI8VpSK9K7dDBhTc3LQAUhCBW6iM=
=o2kQ
-----END PGP SIGNATURE-----

--bFsKbPszpzYNtEU6--

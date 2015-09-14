From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/5] spi: spi-ti-qspi: add mmap mode read support
Date: Mon, 14 Sep 2015 19:26:00 +0100
Message-ID: <20150914182600.GC12027@sirena.org.uk>
References: <1441355402-6837-1-git-send-email-vigneshr@ti.com>
 <1441355402-6837-3-git-send-email-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="hr8bQwfI8oPfWpHR"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1441355402-6837-3-git-send-email-vigneshr@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vignesh R <vigneshr@ti.com>
Cc: Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, hramrach@gmail.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--hr8bQwfI8oPfWpHR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 04, 2015 at 01:59:59PM +0530, Vignesh R wrote:

> +static int ti_qspi_spi_mtd_mmap_read(struct  spi_device *spi,
> +				     loff_t from, size_t len,
> +				     size_t *retlen, u_char *buf,
> +				     u8 read_opcode, u8 addr_width,
> +				     u8 dummy_bytes)
> +{
> +	struct ti_qspi *qspi = spi_master_get_devdata(spi->master);
> +	int ret = 0;
> +
> +	spi_bus_lock(qspi->master);

I suspect I'm going to see the answer to this in another patch but the
fact that we're having to take this lock in a driver when it's an op the
core should be calling.

> +	ret = pm_runtime_get_sync(qspi->dev);
> +	if (ret < 0) {
> +		dev_err(qspi->dev, "pm_runtime_get_sync() failed\n");
> +		return ret;
> +	}

This would be better outside the lock, there's no need to have the lock
before we power on and this fixes the fact that you don't release the
lock here.

> +	memcpy(buf, (__force void *)(qspi->mmap_base + from), len);

The fact that you're having to cast here should be a warning that
there's someting wrong here.  I think you're looking for
memcpy_fromio().

> @@ -479,6 +576,7 @@ static int ti_qspi_probe(struct platform_device *pdev)
>  	master->setup = ti_qspi_setup;
>  	master->auto_runtime_pm = true;
>  	master->transfer_one_message = ti_qspi_start_transfer_one;
> +	master->spi_mtd_mmap_read = ti_qspi_spi_mtd_mmap_read;
>  	master->dev.of_node = pdev->dev.of_node;
>  	master->bits_per_word_mask = SPI_BPW_MASK(32) | SPI_BPW_MASK(16) |
>  				     SPI_BPW_MASK(8);

Don't we need to map a resource somewhere?

--hr8bQwfI8oPfWpHR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV9xE3AAoJECTWi3JdVIfQfbIH/jkoRH8R/Fd2x7/W2yvrG7Q2
V/kCmfMV3VnopEYY2NrjsdUNdxqi+vObifrhOytPmF9nRbKWU7m52WQjTSMCoWbQ
PdaRXdJN0Jbpx7iEmCjXPefTjekiYJ/Tk6S4N/Scr/GC6ekEuiA8kPos9Y6nNhtc
XWsdcPDOhQBLLmD6OHI5OQ+sg2THAbTsHRMjr2KlSq2wR64kaj2zAOTRMx7n2P1z
h3NWJF57RuhNIsT+34bg55Y5pS4mr5T7d0gAS/QME0Ej1NvH9Wv/1I1UVqm5qjyL
HRDgbrMZpKFukWivMMx2FHriuYZs7rNYPFXI/x++sunI7/5NWxyirdO7RvrzuDc=
=gYMN
-----END PGP SIGNATURE-----

--hr8bQwfI8oPfWpHR--

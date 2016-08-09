From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v5] spi: spi-ti-qspi: Add DMA support for QSPI mmap read
Date: Tue, 9 Aug 2016 12:33:29 +0100
Message-ID: <20160809113329.GA9347@sirena.org.uk>
References: <20160809110311.13521-1-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qDbXVdCdHGoSgWSk"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160809110311.13521-1-vigneshr@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vignesh R <vigneshr@ti.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 09, 2016 at 04:33:11PM +0530, Vignesh R wrote:

> +static int ti_qspi_map_buf(struct ti_qspi *qspi, void *buf,
> +			   unsigned int len, struct sg_table *sgt)
> +{
> +	unsigned int max_seg_size =
> +		dma_get_max_seg_size(qspi->rx_chan->device->dev);
> +	unsigned int desc_len = min_t(int, max_seg_size, PAGE_SIZE);
> +	int sgs = DIV_ROUND_UP(len + offset_in_page(buf), desc_len);
> +	struct page *vm_page;
> +	size_t min;
> +	int i, ret;
> +
> +	ret = sg_alloc_table(sgt, sgs, GFP_KERNEL);
> +	if (ret)
> +		return ret;
> +
> +	for (i = 0; i < sgs; i++) {
> +		min = min_t(size_t, len, desc_len -
> +			    offset_in_page(buf));
> +		vm_page = kmap_to_page(buf);
> +		if (!vm_page) {
> +			sg_free_table(sgt);
> +			return -ENOMEM;
> +		}
> +		sg_set_page(&sgt->sgl[i], vm_page, min,
> +			    offset_in_page(buf));
> +		buf += min;
> +		len -= min;

This looks a lot like the core code for mapping the buffers - why is
this open coded rather than reused?

--qDbXVdCdHGoSgWSk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXqb+IAAoJECTWi3JdVIfQvxgH/17pZtV583l7jw7L9Rri4i94
/cDiBCWEUgtyQHxYTd2bu+tSTZNeMEWrhnWwotOesZQfLwiiKM4Y7GgIhhaS+F6y
2wU/22M2JLdpVSPl17V1U178m3uXCg5KluIxH+u8mgdyxoWn9XH1fBGFJNkNw8v8
5fuuIdOcEpY9x1WMPQPqdBNvAovRs/lU0E1PXgSgeIxMtuSMwWr5pxqwMzxIHyGL
7yMAXysMe2G/GxQWRWpb/bnVIHFWe1of8gbqv2fhKlgFj5FC3uVZuTUOV2Cg3K0C
pi0ALKr0M5cV45bilPYpNlqQ/Tn1B7wGhwpC9lOp1f/N1DuW8XEVSrIfOdRj/xE=
=/Cfu
-----END PGP SIGNATURE-----

--qDbXVdCdHGoSgWSk--

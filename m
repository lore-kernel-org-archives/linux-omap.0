From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 2/2] spi: spi-ti-qspi: Use bounce buffer if read
 buffer is not DMA'ble
Date: Fri, 21 Apr 2017 18:06:55 +0100
Message-ID: <20170421170655.dpyxlwipfwnwjjwy@sirena.org.uk>
References: <20170411115225.31709-1-vigneshr@ti.com>
 <20170411115225.31709-3-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="sqh5x7s6lsyzwuuc"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170411115225.31709-3-vigneshr@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vignesh R <vigneshr@ti.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--sqh5x7s6lsyzwuuc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 11, 2017 at 05:22:25PM +0530, Vignesh R wrote:
> Flash filesystems like JFFS2, UBIFS and MTD block layer can provide
> vmalloc'd or kmap'd buffers that cannot be mapped using dma_map_sg() and
> can potentially be in memory region above 32bit addressable region(ie
> buffers belonging to memory region backed by LPAE) of DMA, implement
> spi_flash_can_dma() interface to inform SPI core not to map such
> buffers.

I'll apply this since it fixes bugs for your systems but it feels like
something that we should be moving further into the core since LPAE
isn't specific to your devices.  We should ideally have something
(possibly in the DMA mapping code even) which does the remapping without
the driver needing to know about it.

--sqh5x7s6lsyzwuuc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlj6PC4ACgkQJNaLcl1U
h9B3HAf/QylBiKOaMIzv0N7UKyM/s4kM3kkTFThTrLvyuhas9R5tuqrVKCJxq7Fs
SmfUcuYK8LGrWfHZ+ambPhKlOt/aur9WZe3DNjfdv1+9AnTD8K4icGae9V52r6/R
fXKPW8PBm3FJBoFqa0wvS9+PVCbEkNSdNNOB8edKoI2ycDRxQsElu6gbR/z60XJ/
P/b0eLm5hCtcgqM6ieTfLsPf/k5Xmq3c0InfunxJM0Jdsnm1SVwlwNY9oiWjoFiy
gKaL5lgHb9ZHFdedTu4Clf/g/lRt/MJHPyapA7rg4rKcpaXcjc63kQO7xuxlOrEE
pz+KusnYi+7RHE7ggPQBCUkMeLzyww==
=96Wu
-----END PGP SIGNATURE-----

--sqh5x7s6lsyzwuuc--

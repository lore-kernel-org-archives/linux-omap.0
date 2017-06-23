From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 2/2] spi: spi-ti-qspi: Use bounce buffer if read
 buffer is not DMA'ble
Date: Fri, 23 Jun 2017 13:12:21 +0100
Message-ID: <20170623121221.3zrxziqjuwb47cwq@sirena.org.uk>
References: <20170411115225.31709-1-vigneshr@ti.com>
 <20170411115225.31709-3-vigneshr@ti.com>
 <20170421170655.dpyxlwipfwnwjjwy@sirena.org.uk>
 <3955ad22-28a2-5222-4ae3-aa34dc69cde6@ti.com>
 <c9dbe3d1-549c-f510-fa76-8e326601ecdc@atmel.com>
 <faa7fdc4-25d1-aa9e-762b-25d5e89a771f@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="i5lubso6u3fjsmzh"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <faa7fdc4-25d1-aa9e-762b-25d5e89a771f@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vignesh R <vigneshr@ti.com>
Cc: Cyrille Pitchen <cyrille.pitchen@atmel.com>, "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Richard Weinberger <richard@nod.at>, Boris BREZILLON <boris.brezillon@free-electrons.com>
List-Id: linux-omap@vger.kernel.org


--i5lubso6u3fjsmzh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 20, 2017 at 03:15:34PM +0530, Vignesh R wrote:
> On Friday 16 June 2017 09:24 PM, Cyrille Pitchen wrote:

> > Then in a new series, if nobody has started to work on this topic yet,
> > we could propose a generic solution using a bounce buffer at the SPI
> > core level. however we first need to think how we could do this.

> One of the questions that was hovering around when this issue was
> discussed last time around was where should the code to detect whether
> or not to use bounce buffer reside? Some extension to generic DMA APIs
> or SPI drivers or somewhere else?

It seems like it's a generic DMA thing - presumably it's going to be an
issue for other devices as well sometimes.

--i5lubso6u3fjsmzh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAllNBaQACgkQJNaLcl1U
h9B2RAf/dt+Z7PCBzfFRNjn1499OcyBSPIsVV381XJQl0e35HzXyPkI17i+icLdC
9wubJgD2PZplg32frF+pnfuLGAlsVUWkycxg5V9v9UvcXFU9cXZIa23Jv7joETus
yjyrVZ1boavUkwn8rj1LrzTG41sv6RVjLGRKOhnzIkh/+oQ8uSfDdSF6FYDnjhBj
4UE007dgacpFanYwfqqLLGHOCYK8+mvqp1hQNItQN1C5X7D83pmpWmg85Qj967i2
8BuvbK+HaN4kT3/EfmLPwcMLzIcLx9FRtvH+ByALzFycXRcgYE1adBqRlx8JHoQ4
wCLCF3ZlRkDSrR4AZNrjFEQ+vZMShg==
=vk8U
-----END PGP SIGNATURE-----

--i5lubso6u3fjsmzh--

From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v4 09/16] mtd: onenand: omap2: Unify OMAP2 and OMAP3 DMA
 implementation
Date: Wed, 15 Nov 2017 16:07:04 +0100
Message-ID: <20171115150704.gf3a77bfvvkda6nt@earth>
References: <20171111211206.465pgorrjp3eyix6@lenoch>
 <20171111212244.orvurxipakkywzde@lenoch>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7020436020434052935=="
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <20171111212244.orvurxipakkywzde@lenoch>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
To: Ladislav Michl <ladis@linux-mips.org>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>, Tony Lindgren <tony@atomide.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Kyungmin Park <kyungmin.park@samsung.com>, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org


--===============7020436020434052935==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5dqztoerqmy7oreu"
Content-Disposition: inline


--5dqztoerqmy7oreu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Nov 11, 2017 at 10:22:44PM +0100, Ladislav Michl wrote:
> Since the very first commit (36cd4fb5d277: "[MTD] [OneNAND] Add OMAP2 / O=
MAP3
> OneNAND driver") DMA is disabled for OMAP2. Later fixes thus went only in=
to
> OMAP3 specific DMA functions which turned out not to be so OMAP3 specific,
> so merge those two implementations.
>=20
> Signed-off-by: Ladislav Michl <ladis@linux-mips.org>

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>

-- Sebastian

> ---
>  Changes:
>  -v3: new patch
>  -v4: rebase on top of Peter's patch
>=20
>  drivers/mtd/onenand/omap2.c | 129 ++------------------------------------=
------
>  1 file changed, 4 insertions(+), 125 deletions(-)
>=20
> diff --git a/drivers/mtd/onenand/omap2.c b/drivers/mtd/onenand/omap2.c
> index d22163271dc9..36314124488d 100644
> --- a/drivers/mtd/onenand/omap2.c
> +++ b/drivers/mtd/onenand/omap2.c
> @@ -315,9 +315,7 @@ static inline int omap2_onenand_dma_transfer(struct o=
map2_onenand *c,
>  	return 0;
>  }
> =20
> -#if defined(CONFIG_ARCH_OMAP3) || defined(MULTI_OMAP2)
> -
> -static int omap3_onenand_read_bufferram(struct mtd_info *mtd, int area,
> +static int omap2_onenand_read_bufferram(struct mtd_info *mtd, int area,
>  					unsigned char *buffer, int offset,
>  					size_t count)
>  {
> @@ -379,7 +377,7 @@ static int omap3_onenand_read_bufferram(struct mtd_in=
fo *mtd, int area,
>  	return 0;
>  }
> =20
> -static int omap3_onenand_write_bufferram(struct mtd_info *mtd, int area,
> +static int omap2_onenand_write_bufferram(struct mtd_info *mtd, int area,
>  					 const unsigned char *buffer,
>  					 int offset, size_t count)
>  {
> @@ -434,120 +432,6 @@ static int omap3_onenand_write_bufferram(struct mtd=
_info *mtd, int area,
>  	return 0;
>  }
> =20
> -#else
> -
> -static int omap3_onenand_read_bufferram(struct mtd_info *mtd, int area,
> -					unsigned char *buffer, int offset,
> -					size_t count)
> -{
> -	return -ENOSYS;
> -}
> -
> -static int omap3_onenand_write_bufferram(struct mtd_info *mtd, int area,
> -					 const unsigned char *buffer,
> -					 int offset, size_t count)
> -{
> -	return -ENOSYS;
> -}
> -
> -#endif
> -
> -#if defined(CONFIG_ARCH_OMAP2) || defined(MULTI_OMAP2)
> -
> -static int omap2_onenand_read_bufferram(struct mtd_info *mtd, int area,
> -					unsigned char *buffer, int offset,
> -					size_t count)
> -{
> -	struct omap2_onenand *c =3D container_of(mtd, struct omap2_onenand, mtd=
);
> -	struct onenand_chip *this =3D mtd->priv;
> -	dma_addr_t dma_src, dma_dst;
> -	int bram_offset, ret;
> -
> -	bram_offset =3D omap2_onenand_bufferram_offset(mtd, area) + area + offs=
et;
> -	/* DMA is not used.  Revisit PM requirements before enabling it. */
> -	if (1 || (c->dma_channel < 0) ||
> -	    ((void *) buffer >=3D (void *) high_memory) || (bram_offset & 3) ||
> -	    (((unsigned int) buffer) & 3) || (count < 1024) || (count & 3)) {
> -		memcpy(buffer, (__force void *)(this->base + bram_offset),
> -		       count);
> -		return 0;
> -	}
> -
> -	dma_src =3D c->phys_base + bram_offset;
> -	dma_dst =3D dma_map_single(&c->pdev->dev, buffer, count,
> -				 DMA_FROM_DEVICE);
> -	if (dma_mapping_error(&c->pdev->dev, dma_dst)) {
> -		dev_err(&c->pdev->dev,
> -			"Couldn't DMA map a %d byte buffer\n",
> -			count);
> -		return -1;
> -	}
> -
> -	ret =3D omap2_onenand_dma_transfer(c, dma_src, dma_dst, count);
> -	dma_unmap_single(&c->pdev->dev, dma_dst, count, DMA_FROM_DEVICE);
> -
> -	if (ret)
> -		dev_err(&c->pdev->dev, "timeout waiting for DMA\n");
> -
> -	return ret;
> -}
> -
> -static int omap2_onenand_write_bufferram(struct mtd_info *mtd, int area,
> -					 const unsigned char *buffer,
> -					 int offset, size_t count)
> -{
> -	struct omap2_onenand *c =3D container_of(mtd, struct omap2_onenand, mtd=
);
> -	struct onenand_chip *this =3D mtd->priv;
> -	dma_addr_t dma_src, dma_dst;
> -	int bram_offset, ret;
> -
> -	bram_offset =3D omap2_onenand_bufferram_offset(mtd, area) + area + offs=
et;
> -	/* DMA is not used.  Revisit PM requirements before enabling it. */
> -	if (1 || (c->dma_channel < 0) ||
> -	    ((void *) buffer >=3D (void *) high_memory) || (bram_offset & 3) ||
> -	    (((unsigned int) buffer) & 3) || (count < 1024) || (count & 3)) {
> -		memcpy((__force void *)(this->base + bram_offset), buffer,
> -		       count);
> -		return 0;
> -	}
> -
> -	dma_src =3D dma_map_single(&c->pdev->dev, (void *) buffer, count,
> -				 DMA_TO_DEVICE);
> -	dma_dst =3D c->phys_base + bram_offset;
> -	if (dma_mapping_error(&c->pdev->dev, dma_src)) {
> -		dev_err(&c->pdev->dev,
> -			"Couldn't DMA map a %d byte buffer\n",
> -			count);
> -		return -1;
> -	}
> -
> -	ret =3D omap2_onenand_dma_transfer(c, dma_src, dma_dst, count);
> -	dma_unmap_single(&c->pdev->dev, dma_src, count, DMA_TO_DEVICE);
> -
> -	if (ret)
> -		dev_err(&c->pdev->dev, "timeout waiting for DMA\n");
> -
> -	return ret;
> -}
> -
> -#else
> -
> -static int omap2_onenand_read_bufferram(struct mtd_info *mtd, int area,
> -					unsigned char *buffer, int offset,
> -					size_t count)
> -{
> -	return -ENOSYS;
> -}
> -
> -static int omap2_onenand_write_bufferram(struct mtd_info *mtd, int area,
> -					 const unsigned char *buffer,
> -					 int offset, size_t count)
> -{
> -	return -ENOSYS;
> -}
> -
> -#endif
> -
>  static struct platform_driver omap2_onenand_driver;
> =20
>  static void omap2_onenand_shutdown(struct platform_device *pdev)
> @@ -671,13 +555,8 @@ static int omap2_onenand_probe(struct platform_devic=
e *pdev)
>  	this =3D &c->onenand;
>  	if (c->dma_channel >=3D 0) {
>  		this->wait =3D omap2_onenand_wait;
> -		if (c->flags & ONENAND_IN_OMAP34XX) {
> -			this->read_bufferram =3D omap3_onenand_read_bufferram;
> -			this->write_bufferram =3D omap3_onenand_write_bufferram;
> -		} else {
> -			this->read_bufferram =3D omap2_onenand_read_bufferram;
> -			this->write_bufferram =3D omap2_onenand_write_bufferram;
> -		}
> +		this->read_bufferram =3D omap2_onenand_read_bufferram;
> +		this->write_bufferram =3D omap2_onenand_write_bufferram;
>  	}
> =20
>  	if ((r =3D onenand_scan(&c->mtd, 1)) < 0)
> --=20
> 2.11.0
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--5dqztoerqmy7oreu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIyBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAloMWBcACgkQ2O7X88g7
+prWIQ/43x6C43/pQgQ9sF3kUIGYGaZAUVqwnzCtHj7vbPNkMv48eLiuMUun0iP4
VHf3ojV5BByH3DbgNTsA6Xa5V7/mS/QlsbQ2Y+mWPWm/ls2vWuNToyFX6B9PMR7d
ugB5MPNBOep4t3Z7QhH2R8iRbRXWNTl/ymgLY7xWDhoK2ELWfUitDicJxDquTlc2
KT8W7UvLU0XRkc13F5x17GBFxO9S2KHRGq8UUrGOcF4ekgk68H03ybuEaRG2jozS
Wm7pJnt/kKpji/7ECwBh6J7dOH5b9t1usVi9Hqiy0xrn/aUmxheGZ36g9t9fhLWt
+4TBEdXlrazT0S1zt4bUFovk2HJ9J6pQVEOHVdZAk2RcMWQgwnKpl4fXf9ICnum4
GzpB17k+BlsYf08XU7j5VVtfxO6xDmv4VlpwUHspqiuxSWlmmhnhlRAACx7Pgk4i
0AbwoUsELJoMRnmw9iqQDMtk+2RFlNh/mYX01Ma6I4K6zodd7aTntqzR+dhiDS4s
UiXx3dW60TyjHlzAs/wodkPt/z255pbCGjQpRt1m1n+qHdoontPGR93VOB823bRM
DewUT4yDUJsmgSMwtuPR1WQuyXQkaAb9RJ4GXB3pc8cKvES4BhCtSswoMnjktQZd
UUXpRI9uvZTDIfzeD0qIHLlrFstXLJj9USB6eoQRSus9ul1uNA==
=gvsx
-----END PGP SIGNATURE-----

--5dqztoerqmy7oreu--


--===============7020436020434052935==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/

--===============7020436020434052935==--

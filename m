From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v4 08/16] mtd: onenand: omap2: Simplify the DMA setup for
 various paths
Date: Wed, 15 Nov 2017 16:05:03 +0100
Message-ID: <20171115150503.qpl4mz724ghjyymr@earth>
References: <20171111211206.465pgorrjp3eyix6@lenoch>
 <20171111212153.ldift2s3ycchsc2e@lenoch>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3002989126782138964=="
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <20171111212153.ldift2s3ycchsc2e@lenoch>
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


--===============3002989126782138964==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="w2udrofugd3mnvkg"
Content-Disposition: inline


--w2udrofugd3mnvkg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Nov 11, 2017 at 10:21:53PM +0100, Ladislav Michl wrote:
> From: Peter Ujfalusi <peter.ujfalusi@ti.com>
>=20
> We have 4 functions containing almost identical DMA setup code. Create one
> function which can set up the DMA for both read and write and use this in
> place for the setup code in the driver.
> The new function will use wait_for_completion_io_timeout() and it will
> figure out the best data_type to be used for the transfer instead of
> hardwiring 32 or 16 bit data.
>=20
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
> ---

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>

-- Sebastian

>  Changes:
>  -v4: new patch
>=20
>  drivers/mtd/onenand/omap2.c | 109 ++++++++++++++++++--------------------=
------
>  1 file changed, 45 insertions(+), 64 deletions(-)
>=20
> diff --git a/drivers/mtd/onenand/omap2.c b/drivers/mtd/onenand/omap2.c
> index 0e7772e16d75..d22163271dc9 100644
> --- a/drivers/mtd/onenand/omap2.c
> +++ b/drivers/mtd/onenand/omap2.c
> @@ -288,6 +288,33 @@ static inline int omap2_onenand_bufferram_offset(str=
uct mtd_info *mtd, int area)
>  	return 0;
>  }
> =20
> +static inline int omap2_onenand_dma_transfer(struct omap2_onenand *c,
> +					     dma_addr_t src, dma_addr_t dst,
> +					     size_t count)
> +{
> +	int data_type =3D __ffs((src | dst | count));
> +
> +	if (data_type > OMAP_DMA_DATA_TYPE_S32)
> +		data_type =3D OMAP_DMA_DATA_TYPE_S32;
> +
> +	omap_set_dma_transfer_params(c->dma_channel, data_type,
> +				     count / BIT(data_type), 1, 0, 0, 0);
> +	omap_set_dma_src_params(c->dma_channel, 0, OMAP_DMA_AMODE_POST_INC,
> +				src, 0, 0);
> +	omap_set_dma_dest_params(c->dma_channel, 0, OMAP_DMA_AMODE_POST_INC,
> +				 dst, 0, 0);
> +
> +	reinit_completion(&c->dma_done);
> +	omap_start_dma(c->dma_channel);
> +	if (!wait_for_completion_io_timeout(&c->dma_done,
> +					    msecs_to_jiffies(20))) {
> +		omap_stop_dma(c->dma_channel);
> +		return -ETIMEDOUT;
> +	}
> +
> +	return 0;
> +}
> +
>  #if defined(CONFIG_ARCH_OMAP3) || defined(MULTI_OMAP2)
> =20
>  static int omap3_onenand_read_bufferram(struct mtd_info *mtd, int area,
> @@ -298,10 +325,9 @@ static int omap3_onenand_read_bufferram(struct mtd_i=
nfo *mtd, int area,
>  	struct onenand_chip *this =3D mtd->priv;
>  	dma_addr_t dma_src, dma_dst;
>  	int bram_offset;
> -	unsigned long timeout;
>  	void *buf =3D (void *)buffer;
>  	size_t xtra;
> -	volatile unsigned *done;
> +	int ret;
> =20
>  	bram_offset =3D omap2_onenand_bufferram_offset(mtd, area) + area + offs=
et;
>  	if (bram_offset & 3 || (size_t)buf & 3 || count < 384)
> @@ -338,25 +364,10 @@ static int omap3_onenand_read_bufferram(struct mtd_=
info *mtd, int area,
>  		goto out_copy;
>  	}
> =20
> -	omap_set_dma_transfer_params(c->dma_channel, OMAP_DMA_DATA_TYPE_S32,
> -				     count >> 2, 1, 0, 0, 0);
> -	omap_set_dma_src_params(c->dma_channel, 0, OMAP_DMA_AMODE_POST_INC,
> -				dma_src, 0, 0);
> -	omap_set_dma_dest_params(c->dma_channel, 0, OMAP_DMA_AMODE_POST_INC,
> -				 dma_dst, 0, 0);
> -
> -	reinit_completion(&c->dma_done);
> -	omap_start_dma(c->dma_channel);
> -
> -	timeout =3D jiffies + msecs_to_jiffies(20);
> -	done =3D &c->dma_done.done;
> -	while (time_before(jiffies, timeout))
> -		if (*done)
> -			break;
> -
> +	ret =3D omap2_onenand_dma_transfer(c, dma_src, dma_dst, count);
>  	dma_unmap_single(&c->pdev->dev, dma_dst, count, DMA_FROM_DEVICE);
> =20
> -	if (!*done) {
> +	if (ret) {
>  		dev_err(&c->pdev->dev, "timeout waiting for DMA\n");
>  		goto out_copy;
>  	}
> @@ -376,9 +387,8 @@ static int omap3_onenand_write_bufferram(struct mtd_i=
nfo *mtd, int area,
>  	struct onenand_chip *this =3D mtd->priv;
>  	dma_addr_t dma_src, dma_dst;
>  	int bram_offset;
> -	unsigned long timeout;
>  	void *buf =3D (void *)buffer;
> -	volatile unsigned *done;
> +	int ret;
> =20
>  	bram_offset =3D omap2_onenand_bufferram_offset(mtd, area) + area + offs=
et;
>  	if (bram_offset & 3 || (size_t)buf & 3 || count < 384)
> @@ -409,25 +419,10 @@ static int omap3_onenand_write_bufferram(struct mtd=
_info *mtd, int area,
>  		return -1;
>  	}
> =20
> -	omap_set_dma_transfer_params(c->dma_channel, OMAP_DMA_DATA_TYPE_S32,
> -				     count >> 2, 1, 0, 0, 0);
> -	omap_set_dma_src_params(c->dma_channel, 0, OMAP_DMA_AMODE_POST_INC,
> -				dma_src, 0, 0);
> -	omap_set_dma_dest_params(c->dma_channel, 0, OMAP_DMA_AMODE_POST_INC,
> -				 dma_dst, 0, 0);
> -
> -	reinit_completion(&c->dma_done);
> -	omap_start_dma(c->dma_channel);
> -
> -	timeout =3D jiffies + msecs_to_jiffies(20);
> -	done =3D &c->dma_done.done;
> -	while (time_before(jiffies, timeout))
> -		if (*done)
> -			break;
> -
> +	ret =3D omap2_onenand_dma_transfer(c, dma_src, dma_dst, count);
>  	dma_unmap_single(&c->pdev->dev, dma_src, count, DMA_TO_DEVICE);
> =20
> -	if (!*done) {
> +	if (ret) {
>  		dev_err(&c->pdev->dev, "timeout waiting for DMA\n");
>  		goto out_copy;
>  	}
> @@ -466,7 +461,7 @@ static int omap2_onenand_read_bufferram(struct mtd_in=
fo *mtd, int area,
>  	struct omap2_onenand *c =3D container_of(mtd, struct omap2_onenand, mtd=
);
>  	struct onenand_chip *this =3D mtd->priv;
>  	dma_addr_t dma_src, dma_dst;
> -	int bram_offset;
> +	int bram_offset, ret;
> =20
>  	bram_offset =3D omap2_onenand_bufferram_offset(mtd, area) + area + offs=
et;
>  	/* DMA is not used.  Revisit PM requirements before enabling it. */
> @@ -488,20 +483,13 @@ static int omap2_onenand_read_bufferram(struct mtd_=
info *mtd, int area,
>  		return -1;
>  	}
> =20
> -	omap_set_dma_transfer_params(c->dma_channel, OMAP_DMA_DATA_TYPE_S32,
> -				     count / 4, 1, 0, 0, 0);
> -	omap_set_dma_src_params(c->dma_channel, 0, OMAP_DMA_AMODE_POST_INC,
> -				dma_src, 0, 0);
> -	omap_set_dma_dest_params(c->dma_channel, 0, OMAP_DMA_AMODE_POST_INC,
> -				 dma_dst, 0, 0);
> -
> -	reinit_completion(&c->dma_done);
> -	omap_start_dma(c->dma_channel);
> -	wait_for_completion(&c->dma_done);
> -
> +	ret =3D omap2_onenand_dma_transfer(c, dma_src, dma_dst, count);
>  	dma_unmap_single(&c->pdev->dev, dma_dst, count, DMA_FROM_DEVICE);
> =20
> -	return 0;
> +	if (ret)
> +		dev_err(&c->pdev->dev, "timeout waiting for DMA\n");
> +
> +	return ret;
>  }
> =20
>  static int omap2_onenand_write_bufferram(struct mtd_info *mtd, int area,
> @@ -511,7 +499,7 @@ static int omap2_onenand_write_bufferram(struct mtd_i=
nfo *mtd, int area,
>  	struct omap2_onenand *c =3D container_of(mtd, struct omap2_onenand, mtd=
);
>  	struct onenand_chip *this =3D mtd->priv;
>  	dma_addr_t dma_src, dma_dst;
> -	int bram_offset;
> +	int bram_offset, ret;
> =20
>  	bram_offset =3D omap2_onenand_bufferram_offset(mtd, area) + area + offs=
et;
>  	/* DMA is not used.  Revisit PM requirements before enabling it. */
> @@ -533,20 +521,13 @@ static int omap2_onenand_write_bufferram(struct mtd=
_info *mtd, int area,
>  		return -1;
>  	}
> =20
> -	omap_set_dma_transfer_params(c->dma_channel, OMAP_DMA_DATA_TYPE_S16,
> -				     count / 2, 1, 0, 0, 0);
> -	omap_set_dma_src_params(c->dma_channel, 0, OMAP_DMA_AMODE_POST_INC,
> -				dma_src, 0, 0);
> -	omap_set_dma_dest_params(c->dma_channel, 0, OMAP_DMA_AMODE_POST_INC,
> -				 dma_dst, 0, 0);
> -
> -	reinit_completion(&c->dma_done);
> -	omap_start_dma(c->dma_channel);
> -	wait_for_completion(&c->dma_done);
> -
> +	ret =3D omap2_onenand_dma_transfer(c, dma_src, dma_dst, count);
>  	dma_unmap_single(&c->pdev->dev, dma_src, count, DMA_TO_DEVICE);
> =20
> -	return 0;
> +	if (ret)
> +		dev_err(&c->pdev->dev, "timeout waiting for DMA\n");
> +
> +	return ret;
>  }
> =20
>  #else
> --=20
> 2.11.0
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--w2udrofugd3mnvkg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAloMV58ACgkQ2O7X88g7
+prDzg/+MfemzzwtTuWnJWViw/kUWk3mOBwWUb62aEqfQi/vTDalCH8Lul9JkXko
yVufADlaBMblKirKqexk1kuFX5Nlit4KiDB4cA9dDY4O54Xnfr9lGfcSLHnxPM6M
nmakxRkx2SkDdUkn5YX2bZh/qH0V7efW3DoSv8TNyvDiMBWme1gwupNfeUX0kFzo
XqKropTkXV1J07o44hKBVmME1rmn3b0u7TpWisHOY6rMdILzh57NRrOxBjm2jPCU
ZRpZ35V+s6sPHSNrKi+1uD6bmZ4dnf4NVcMtWOD/794VoeVZIuql3tTTs2bIumKx
PnuM3P2dMFieBv0uJ8c/kFPWW9QK895+sbYlLEMSK6ktg1B4gaX5bgCE50a3WVjB
H9/x3zsk+CjNMciNAiyvNUVKjaK19jBuMhBKs57P4dgo1VkKLPpUDxyr8GP6YQ+U
V4rKmFuw2MTHFCX8hnp6Aerzfn4jGkyDzm06/kJiTnAsdXWL3KV7vXMOLtAkTMhP
WGul0yBUCZxrtqbCLPqMcq5Ca+ykrbU15U2q3hIO6sdKK2PQ3+wwBpMaSJS/Wd2I
GPgMZ58tuMOztik2N+cgXr0s/4OiNvtn/4Vsq4ii7hN57zu/pIW3xD3/brYAgp4l
O+1dPJI4OLyqdzYTRN0j0a8paPRuc3tnXV2zQihBEKh7chouJGs=
=g6P9
-----END PGP SIGNATURE-----

--w2udrofugd3mnvkg--


--===============3002989126782138964==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/

--===============3002989126782138964==--

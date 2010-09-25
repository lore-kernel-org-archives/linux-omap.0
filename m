From: "Ghorai, Sukumar" <s-ghorai@ti.com>
Subject: RE: [PATCH] nand: omap2: Missing arg to gpmc_prefetch_reset()
Date: Sat, 25 Sep 2010 11:56:03 +0530
Message-ID: <2A3DCF3DA181AD40BDE86A3150B27B6B035609826B@dbde02.ent.ti.com>
References: <1285364702-13922-1-git-send-email-loic.minier@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:44781 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751396Ab0IYG0N convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 25 Sep 2010 02:26:13 -0400
In-Reply-To: <1285364702-13922-1-git-send-email-loic.minier@linaro.org>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?iso-8859-1?Q?Lo=EFc_Minier?= <loic.minier@linaro.org>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Tony Lindgren <tony@atomide.com>



> -----Original Message-----
> From: Lo=EFc Minier [mailto:loic.minier@linaro.org]
> Sent: Saturday, September 25, 2010 3:15 AM
> To: linux-mtd@lists.infradead.org; linux-omap@vger.kernel.org
> Cc: Tony Lindgren; Ghorai, Sukumar; Lo=EFc Minier
> Subject: [PATCH] nand: omap2: Missing arg to gpmc_prefetch_reset()
>=20
> Fix missing cs arg to gpmc_prefetch_reset() when
> CONFIG_MTD_NAND_OMAP_PREFETCH_DMA=3Dy which caused a build failure si=
nce
> 948d38e799f0ab87cf8ed9113fcdaaee61acf321:
> drivers/mtd/nand/omap2.c: In function 'omap_nand_dma_transfer':
> drivers/mtd/nand/omap2.c:416: error: too few arguments to function
> 'gpmc_prefetch_reset'
>=20
> Signed-off-by: Lo=EFc Minier <loic.minier@linaro.org>
> ---
>  drivers/mtd/nand/omap2.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>=20
> diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
> index 133d515..513e0a7 100644
> --- a/drivers/mtd/nand/omap2.c
> +++ b/drivers/mtd/nand/omap2.c
> @@ -413,7 +413,7 @@ static inline int omap_nand_dma_transfer(struct
> mtd_info *mtd, void *addr,
>  		prefetch_status =3D gpmc_read_status(GPMC_PREFETCH_COUNT);
>  	} while (prefetch_status);
>  	/* disable and stop the PFPW engine */
> -	gpmc_prefetch_reset();
> +	gpmc_prefetch_reset(info->gpmc_cs);
>=20
>  	dma_unmap_single(&info->pdev->dev, dma_addr, len, dir);
>  	return 0;
> --
> 1.7.1
[Ghorai] Acked-by: Sukumar Ghorai <s-ghorai@ti.com>

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

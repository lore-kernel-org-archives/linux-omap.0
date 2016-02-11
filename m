From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] dmaengine: omap-dma: Implement device_synchronize
 callback
Date: Thu, 11 Feb 2016 11:00:47 +0200
Message-ID: <56BC4DBF.8080605@ti.com>
References: <1455180894-2672-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1455180894-2672-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: vinod.koul@intel.com
Cc: linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nsekhar@ti.com, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 02/11/2016 10:54 AM, Peter Ujfalusi wrote:
> We need the callback to support the dmaengine_terminate_sync().

I have made some typos and I only compiled the kernel after sending the=
 patch..
Resending.

> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>  drivers/dma/omap-dma.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/drivers/dma/omap-dma.c b/drivers/dma/omap-dma.c
> index e691f48f9d73..7c6a300b6b57 100644
> --- a/drivers/dma/omap-dma.c
> +++ b/drivers/dma/omap-dma.c
> @@ -1007,6 +1007,13 @@ static int omap_dma_terminate_all(struct dma_c=
han *chan)
>  	return 0;
>  }
> =20
> +static void omap_dma_synchronize(struct dma_chan *c)
> +{
> +	struct omap_chan *c =3D to_omap_dma_chan(chan);
> +
> +	vchan_synchronize(&c->vc);
> +}
> +
>  static int omap_dma_pause(struct dma_chan *chan)
>  {
>  	struct omap_chan *c =3D to_omap_dma_chan(chan);
> @@ -1110,6 +1117,7 @@ static int omap_dma_probe(struct platform_devic=
e *pdev)
>  	od->ddev.device_pause =3D omap_dma_pause;
>  	od->ddev.device_resume =3D omap_dma_resume;
>  	od->ddev.device_terminate_all =3D omap_dma_terminate_all;
> +	od-ddev.device_synchronize =3D omap_dma_synchronize;
>  	od->ddev.src_addr_widths =3D OMAP_DMA_BUSWIDTHS;
>  	od->ddev.dst_addr_widths =3D OMAP_DMA_BUSWIDTHS;
>  	od->ddev.directions =3D BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV);
>=20


--=20
P=E9ter

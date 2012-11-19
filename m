From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [RFC] dmaengine: omap-dma: Allow DMA controller to prefetch data
Date: Mon, 19 Nov 2012 11:01:44 +0100
Message-ID: <50AA0388.4020803@ti.com>
References: <20121018222046.GA28541@animalcreek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20121018222046.GA28541@animalcreek.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Mark A. Greer" <mgreer@animalcreek.com>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi,

On 10/19/2012 12:20 AM, Mark A. Greer wrote:
> Enable DMA prefetching by setting the 'OMAP_DMA_DST_SYNC_PREFETCH'
> flag whenever there is a destination synchronized DMA transfer.
> Prefetching is not allowed on source synchronized DMA transfers.
> =

> Enabling prefetch significantly improves DMA performance.
> For example, running 'modprobe tcrypt sec=3D2 mode=3D403' which
> exercises the omap-sham driver on an am37x EVM yeilds the
> following results:

>  drivers/dma/omap-dma.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> =

> diff --git a/drivers/dma/omap-dma.c b/drivers/dma/omap-dma.c
> index bb2d8e7..aadddb2 100644
> --- a/drivers/dma/omap-dma.c
> +++ b/drivers/dma/omap-dma.c
> @@ -310,7 +310,7 @@ static struct dma_async_tx_descriptor *omap_dma_prep_=
slave_sg(
>  		dev_addr =3D c->cfg.dst_addr;
>  		dev_width =3D c->cfg.dst_addr_width;
>  		burst =3D c->cfg.dst_maxburst;
> -		sync_type =3D OMAP_DMA_DST_SYNC;
> +		sync_type =3D OMAP_DMA_DST_SYNC | OMAP_DMA_DST_SYNC_PREFETCH;

This should be:
 -		sync_type =3D OMAP_DMA_DST_SYNC;
 +		sync_type =3D OMAP_DMA_DST_SYNC_PREFETCH;


>  	} else {
>  		dev_err(chan->device->dev, "%s: bad direction?\n", __func__);
>  		return NULL;
> @@ -387,7 +387,7 @@ static struct dma_async_tx_descriptor *omap_dma_prep_=
dma_cyclic(
>  		dev_addr =3D c->cfg.dst_addr;
>  		dev_width =3D c->cfg.dst_addr_width;
>  		burst =3D c->cfg.dst_maxburst;
> -		sync_type =3D OMAP_DMA_DST_SYNC;
> +		sync_type =3D OMAP_DMA_DST_SYNC | OMAP_DMA_DST_SYNC_PREFETCH;

We should not enable the prefetch for cyclic right now. We will investigate=
 it
more.

>  	} else {
>  		dev_err(chan->device->dev, "%s: bad direction?\n", __func__);
>  		return NULL;
> =


-- =

P=E9ter

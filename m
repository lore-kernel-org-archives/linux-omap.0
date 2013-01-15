From: "Mark A. Greer" <mgreer@animalcreek.com>
Subject: Re: [PATCH] dmaengine: omap-dma: Allow DMA controller to prefetch data
Date: Tue, 15 Jan 2013 11:52:14 -0700
Message-ID: <20130115185214.GA3165@animalcreek.com>
References: <20121119163727.GB9758@animalcreek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20121119163727.GB9758@animalcreek.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: =?iso-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@ti.com>, Russell King <rmk+kernel@arm.linux.org.uk>
List-Id: linux-omap@vger.kernel.org

On Mon, Nov 19, 2012 at 09:37:27AM -0700, Mark A. Greer wrote:
> From: "Mark A. Greer" <mgreer@animalcreek.com>
> =

> Enable DMA prefetching for non-cyclic DMAs by setting the
> 'OMAP_DMA_DST_SYNC_PREFETCH' flag when there is a destination
> synchronized DMA transfer.  Prefetching is not allowed on
> source synchronized DMA transfers.  It is not allowed on
> cyclic DMAs either since that can cause issues with some
> users (e.g., suspending/resuming audio).
> =

> CC: Russell King <rmk+kernel@arm.linux.org.uk>
> CC: P=E9ter Ujfalusi <peter.ujfalusi@ti.com>
> Signed-off-by: Mark A. Greer <mgreer@animalcreek.com>
> ---
>  drivers/dma/omap-dma.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> =

> diff --git a/drivers/dma/omap-dma.c b/drivers/dma/omap-dma.c
> index bb2d8e7..3932eab 100644
> --- a/drivers/dma/omap-dma.c
> +++ b/drivers/dma/omap-dma.c
> @@ -310,7 +310,7 @@ static struct dma_async_tx_descriptor *omap_dma_prep_=
slave_sg(
>  		dev_addr =3D c->cfg.dst_addr;
>  		dev_width =3D c->cfg.dst_addr_width;
>  		burst =3D c->cfg.dst_maxburst;
> -		sync_type =3D OMAP_DMA_DST_SYNC;
> +		sync_type =3D OMAP_DMA_DST_SYNC_PREFETCH;
>  	} else {
>  		dev_err(chan->device->dev, "%s: bad direction?\n", __func__);
>  		return NULL;
> -- =

> 1.7.12

Ping?

From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [RFC v2] dmaengine: omap-dma: Start DMA without delay for cyclic
 channels
Date: Mon, 8 Apr 2013 09:11:04 +0200
Message-ID: <51626D88.8020809@ti.com>
References: <1364987862-14597-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:55153 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932092Ab3DHHMO (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 8 Apr 2013 03:12:14 -0400
In-Reply-To: <1364987862-14597-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>, Vinod Koul <vinod.koul@intel.com>, Dan Williams <djbw@fb.com>
Cc: Tony Lindgren <tony@atomide.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Felipe Balbi <balbi@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Peter Meerwald <pmeerw@pmeerw.net>

Russell,

On 04/03/2013 01:17 PM, Peter Ujfalusi wrote:
> cyclic DMA is only used by audio which needs DMA to be started withou=
t a
> delay.
> If the DMA for audio is started using the tasklet we experience rando=
m
> channel switch (to be more precise: channel shift).
>=20
> Reported-by: Peter Meerwald <pmeerw@pmeerw.net>
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
> Hi Russell,
>=20
> Instead of removing the tasklet we can identify the DMA channel used =
by audio
> based on the cyclic flag of the channel.
> I think this can be used as a short term solution to fix the audio ch=
annel shift
> issue and later when we have the dynamic DMA channel allocation we ca=
n adjust
> the code.

Could you, please look at this patch?

Thank you,
P=E9ter

> Regards,
> Peter
>=20
>  drivers/dma/omap-dma.c | 20 ++++++++++++++------
>  1 file changed, 14 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/dma/omap-dma.c b/drivers/dma/omap-dma.c
> index 2ea3d7e..ec3fc4f 100644
> --- a/drivers/dma/omap-dma.c
> +++ b/drivers/dma/omap-dma.c
> @@ -282,12 +282,20 @@ static void omap_dma_issue_pending(struct dma_c=
han *chan)
> =20
>  	spin_lock_irqsave(&c->vc.lock, flags);
>  	if (vchan_issue_pending(&c->vc) && !c->desc) {
> -		struct omap_dmadev *d =3D to_omap_dma_dev(chan->device);
> -		spin_lock(&d->lock);
> -		if (list_empty(&c->node))
> -			list_add_tail(&c->node, &d->pending);
> -		spin_unlock(&d->lock);
> -		tasklet_schedule(&d->task);
> +		/*
> +		 * c->cyclic is used only by audio and in this case the DMA need
> +		 * to be started without delay.
> +		 */
> +		if (!c->cyclic) {
> +			struct omap_dmadev *d =3D to_omap_dma_dev(chan->device);
> +			spin_lock(&d->lock);
> +			if (list_empty(&c->node))
> +				list_add_tail(&c->node, &d->pending);
> +			spin_unlock(&d->lock);
> +			tasklet_schedule(&d->task);
> +		} else {
> +			omap_dma_start_desc(c);
> +		}
>  	}
>  	spin_unlock_irqrestore(&c->vc.lock, flags);
>  }
>=20

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

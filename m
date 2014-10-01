From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 09/13] dmaengine: edma: check for echan->edesc => NULL
 in edma_dma_pause()
Date: Wed, 1 Oct 2014 15:00:53 +0300
Message-ID: <542BECF5.2090700@ti.com>
References: <1412014009-13315-1-git-send-email-bigeasy@linutronix.de> <1412014009-13315-10-git-send-email-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <1412014009-13315-10-git-send-email-bigeasy@linutronix.de>
Sender: linux-serial-owner@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, balbi@ti.com, gregkh@linuxfoundation.org, vinod.koul@intel.com
List-Id: linux-omap@vger.kernel.org

On 09/29/2014 09:06 PM, Sebastian Andrzej Siewior wrote:
> I added book keeping of whether or not the 8250-dma driver has an RX
> transfer pending or not so we don't BUG here if it calls
> dmaengine_pause() on a channel which has not a pending transfer. Gues=
s
> what, this is not enough.
> The following can be triggered with a busy RX channel and hackbench i=
n
> background:
> - DMA transfer completes. The callback is delayed via
>   vchan_cookie_complete() into a tasklet so it das not happen asap.
> - hackbench keeps the system busy so the tasklet does not run "soon".
> - the UART collected enough data and generates an "timeout"-interrupt=
=2E
>   Since 8250-dma *thinks* the DMA-transfer is still pending it tries =
to
>   cancel it via invoking dmaengine_pause() first. This causes the seg=
fault
>   because echan->edesc is NULL now that the transfer completed (howev=
er
>   the callback did not run yet).
>=20
> With this patch we don't BUG in the scenario described.

Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

>=20
> Cc: vinod.koul@intel.com
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  drivers/dma/edma.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/dma/edma.c b/drivers/dma/edma.c
> index 7b65633f495e..123f578d6dd3 100644
> --- a/drivers/dma/edma.c
> +++ b/drivers/dma/edma.c
> @@ -288,7 +288,7 @@ static int edma_slave_config(struct edma_chan *ec=
han,
>  static int edma_dma_pause(struct edma_chan *echan)
>  {
>  	/* Pause/Resume only allowed with cyclic mode */
> -	if (!echan->edesc->cyclic)
> +	if (!echan->edesc || !echan->edesc->cyclic)
>  		return -EINVAL;
> =20
>  	edma_pause(echan->ch_num);
>=20


--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

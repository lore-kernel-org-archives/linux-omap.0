From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [RFC] ARM: edma: unconditionally ack the error interrupt
Date: Thu, 18 Sep 2014 12:42:24 +0300
Message-ID: <541AA900.4080506@ti.com>
References: <1410377960-26921-1-git-send-email-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:43280 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755203AbaIRJnA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Sep 2014 05:43:00 -0400
In-Reply-To: <1410377960-26921-1-git-send-email-bigeasy@linutronix.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org

On 09/10/2014 10:39 PM, Sebastian Andrzej Siewior wrote:
> With 8250-dma, 8250-omap and am335x I observe the following:
>=20
> - start a RX transfer which will finish once the FIFO has enough data
> - The TX side starts a large TX transfer, say 1244 bytes. It takes ap=
prox
>   102ms for the transfer to complete
> - cancel the RX transfer & start the RX transfer a few times
> - the TX transfer completes. dma_irq_handler() notices this and
>   schedules the completion callback
> - dma_ccerr_handler() is invoked. It returns IRQ_NONE because all fou=
r
>   checked registers return 0.
> - the last irq handler is repeated a few times until the irq core shu=
ts it
>   down.
>=20
> I see the above describes pattern also without dma_ccerr_handler()
> beeing invoked. But if it is invoked, it always _after_ the dma inter=
rupt
> handler for the TX handler was handled. If I disable TX-DMA for the U=
ART
> then I don't see this dma_ccerr_handler() at all.
>=20
> Testing longer I see two addition scenarios of dma_ccerr_handler():
> - EDMA_EMR0 reports 0x04000000 (the channel used by TX-UART).
>   edma_callback() reports "looks like slot is null". Looks harmless.
> - EDMA_EMR0 reports the same values but later in the loop where a mat=
ch
>   search again EDMA_EMR0 reports 0 and so thing is done.
>=20
> Since it looks like the EDMA_EMR0 is loosing its content before the
> dma_ccerr_handler() is invoked, I suggest to unconditionally ack the
> interrupt so the irq core does not shut it down.

It is reasonable to ack the error interrupt unconditionally.
My hunch on what could be causing this that we might have unhandled dma=
 event
and another comes. This will flag the EDMA_EMR register. Any change in =
this
register will assert error interrupt which can only be cleared by writi=
ng to
EDMA_EMRC register.
The EDMA_EMRC register bits also cleared on edma_start(), edma_stop() a=
nd
edma_clean_channel() apart from the error interrupt handler.
So it is possible that we have missed event on one of the channels but =
a stop
might clear the event so in the interrupt hander we do not see this.
I think it would be good to understand what is going on the backround..=
=2E
Can you print out the EDMA_EMCR just before we clear it in the places I=
 have
mentioned? We might get better understanding on which stage we clear it=
 and
probably we can understand how to fix this properly so we are not going=
 to
have missed events on channels.

Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

>=20
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  arch/arm/common/edma.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/arm/common/edma.c b/arch/arm/common/edma.c
> index 88099175fc56..b31f3b7b3851 100644
> --- a/arch/arm/common/edma.c
> +++ b/arch/arm/common/edma.c
> @@ -432,8 +432,10 @@ static irqreturn_t dma_ccerr_handler(int irq, vo=
id *data)
>  	if ((edma_read_array(ctlr, EDMA_EMR, 0) =3D=3D 0) &&
>  	    (edma_read_array(ctlr, EDMA_EMR, 1) =3D=3D 0) &&
>  	    (edma_read(ctlr, EDMA_QEMR) =3D=3D 0) &&
> -	    (edma_read(ctlr, EDMA_CCERR) =3D=3D 0))
> +	    (edma_read(ctlr, EDMA_CCERR) =3D=3D 0)) {
> +		edma_write(ctlr, EDMA_EEVAL, 1);
>  		return IRQ_NONE;
> +	}
> =20
>  	while (1) {
>  		int j =3D -1;
>=20


--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

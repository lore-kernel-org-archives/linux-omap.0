From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 1/7] dmaengine: edma: fix two faults which happen with
 the 8250_dma user
Date: Tue, 19 Aug 2014 20:42:16 +0530
Message-ID: <20140819151216.GO13288@intel.com>
References: <1406660344-25307-1-git-send-email-bigeasy@linutronix.de>
 <1406660344-25307-2-git-send-email-bigeasy@linutronix.de>
 <20140731121702.GU8181@intel.com>
 <20140808162950.GA12080@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140808162950.GA12080@linutronix.de>
Sender: linux-serial-owner@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, balbi@ti.com, Joel Fernandes <joelf@ti.com>, Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Fri, Aug 08, 2014 at 06:29:50PM +0200, Sebastian Andrzej Siewior wro=
te:
> * Vinod Koul | 2014-07-31 17:47:02 [+0530]:
>=20
> >On Tue, Jul 29, 2014 at 08:58:58PM +0200, Sebastian Andrzej Siewior =
wrote:
> >> The rx path of the 8250_dma user in the RX-timeout case:
> >> - it starts the RX transfer
> >> - if the rx-timeout interrupt occures, it dmaengine_pause() the tr=
ansfer
> >> - step two is dmaengine_terminate_all() on this channel.
> >Okay after this whole channel needs to be reset, which means all the
> >descriptors are discared.
>=20
> >> To make the upper case work better, this patch adds dma_cookie_com=
plete()
> >> to complete the cookie. Also it adds is an additional check for ec=
han->edesc
> >> in case the channel has no descriptor assigned.
> >I think we are fixing the behvaiour rather than cause. terminate_all=
(()
> >needs to do a proper cleanup of the channel
>=20
> In case you are not ignoring me but $reason here is an example that d=
oes
> not work (with both drivers);
Sorry This seems to have slipped thru, wasn't intentional!
>=20
>     desc =3D dmaengine_prep_slave_single(rxchan, =E2=80=A6);
>     rx_cookie =3D dmaengine_submit(desc);
>     dma_async_issue_pending(rxchan);
>=20
>     ssleep(2);
>     /* Now assume that the transfer did not start */
>     st =3D dmaengine_tx_status(rxchan, rx_cookie, NULL);
>     /* st is now DMA_IN_PROGRESS as expected */
>=20
>     dmaengine_terminate_all(rxchan);
>     st =3D dmaengine_tx_status(rxchan, rx_cookie, NULL);
and here is the culprit. You have terminated the channel. This means th=
at
dmaengine driver is free to clean up all the allocated descriptors on t=
he
channels and do whatever it decides to do with them.

You have already terminated the channel so what is the point in queryin=
g the
status of the cookie, which you shouldn't use anyway after invoking
terminate_all() as its result is not correct.

>     /* st is still DMA_IN_PROGRESS but _I_ expect DMA_COMPLETE becaus=
e
>      * it has been terminated / canceled
>      */
>=20
> Both dma driver clean up all / terminate all descriptors as required =
but
> _none_ of them completes the cookie. As a result dma_cookie_status()
> still thinks that the transfer is in progress.

Btw how does it matter in the driver here if the transaction completed =
or
not after terminate_all() was invoked. What is the purpose of querying
status.

Thanks
--=20
~Vinod
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

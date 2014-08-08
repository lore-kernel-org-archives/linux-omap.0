From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 1/7] dmaengine: edma: fix two faults which happen with
 the 8250_dma user
Date: Fri, 8 Aug 2014 18:29:50 +0200
Message-ID: <20140808162950.GA12080@linutronix.de>
References: <1406660344-25307-1-git-send-email-bigeasy@linutronix.de>
 <1406660344-25307-2-git-send-email-bigeasy@linutronix.de>
 <20140731121702.GU8181@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140731121702.GU8181@intel.com>
Sender: linux-serial-owner@vger.kernel.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, balbi@ti.com, Joel Fernandes <joelf@ti.com>, Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Vinod Koul | 2014-07-31 17:47:02 [+0530]:

>On Tue, Jul 29, 2014 at 08:58:58PM +0200, Sebastian Andrzej Siewior wr=
ote:
>> The rx path of the 8250_dma user in the RX-timeout case:
>> - it starts the RX transfer
>> - if the rx-timeout interrupt occures, it dmaengine_pause() the tran=
sfer
>> - step two is dmaengine_terminate_all() on this channel.
>Okay after this whole channel needs to be reset, which means all the
>descriptors are discared.

>> To make the upper case work better, this patch adds dma_cookie_compl=
ete()
>> to complete the cookie. Also it adds is an additional check for echa=
n->edesc
>> in case the channel has no descriptor assigned.
>I think we are fixing the behvaiour rather than cause. terminate_all((=
)
>needs to do a proper cleanup of the channel

In case you are not ignoring me but $reason here is an example that doe=
s
not work (with both drivers);

    desc =3D dmaengine_prep_slave_single(rxchan, =E2=80=A6);
    rx_cookie =3D dmaengine_submit(desc);
    dma_async_issue_pending(rxchan);

    ssleep(2);
    /* Now assume that the transfer did not start */
    st =3D dmaengine_tx_status(rxchan, rx_cookie, NULL);
    /* st is now DMA_IN_PROGRESS as expected */

    dmaengine_terminate_all(rxchan);
    st =3D dmaengine_tx_status(rxchan, rx_cookie, NULL);
    /* st is still DMA_IN_PROGRESS but _I_ expect DMA_COMPLETE because
     * it has been terminated / canceled
     */

Both dma driver clean up all / terminate all descriptors as required bu=
t
_none_ of them completes the cookie. As a result dma_cookie_status()
still thinks that the transfer is in progress.

Sebastian
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 1/7] dmaengine: edma: fix two faults which happen with
 the 8250_dma user
Date: Thu, 21 Aug 2014 15:09:12 +0200
Message-ID: <53F5EF78.2050800@linutronix.de>
References: <1406660344-25307-1-git-send-email-bigeasy@linutronix.de> <1406660344-25307-2-git-send-email-bigeasy@linutronix.de> <20140731121702.GU8181@intel.com> <20140808162950.GA12080@linutronix.de> <20140819151216.GO13288@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <20140819151216.GO13288@intel.com>
Sender: linux-serial-owner@vger.kernel.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, balbi@ti.com, Joel Fernandes <joelf@ti.com>, Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 08/19/2014 05:12 PM, Vinod Koul wrote:
>>
>>     desc =3D dmaengine_prep_slave_single(rxchan, =E2=80=A6);
>>     rx_cookie =3D dmaengine_submit(desc);
>>     dma_async_issue_pending(rxchan);
>>
>>     ssleep(2);
>>     /* Now assume that the transfer did not start */
>>     st =3D dmaengine_tx_status(rxchan, rx_cookie, NULL);
>>     /* st is now DMA_IN_PROGRESS as expected */
>>
>>     dmaengine_terminate_all(rxchan);
>>     st =3D dmaengine_tx_status(rxchan, rx_cookie, NULL);
> and here is the culprit. You have terminated the channel. This means =
that
> dmaengine driver is free to clean up all the allocated descriptors on=
 the
> channels and do whatever it decides to do with them.

descriptors, yes.

> You have already terminated the channel so what is the point in query=
ing the
> status of the cookie, which you shouldn't use anyway after invoking
> terminate_all() as its result is not correct.

The point is to check (later, after terminate_all()) if there is an
outstanding DMA transfer or not _and_ how much data was really
transfered. Looking at edma it does not really support the latter if
the transfer is already completed. On the plus side the HW does not
support partly transfers :)

But where is it written that the life time of the cookie is limited?
Looking at the "cooking check" code there is no such thing. It is
simply compare of completed vs passed number but okay, this is an
implementation detail.
=46rom [0] it says under "4. Submit the transaction":

| This returns a cookie can be used to check the progress of DMA engine
| activity via other DMA engine calls not covered in this document.

no life time limit mentioned here. Which brings to the question: Why is
it okay to use the cookie after the transaction "terminated" normally
but not if it has been canceled?

And from [0] the API explanation  "4. =E2=80=A6 dma_async_is_tx_complet=
e()":

|Note:
|    Not all DMA engine drivers can return reliable information for
|    a running DMA channel.  It is recommended that DMA engine users
|    pause or stop (via dmaengine_terminate_all) the channel before
|    using this API.

So the documentation says to use the cookie with
dma_async_is_tx_complete() and before doing so it is recommended that
the transfer should be paused or stopped. _Exactly_ what is done here.

>>     /* st is still DMA_IN_PROGRESS but _I_ expect DMA_COMPLETE becau=
se
>>      * it has been terminated / canceled
>>      */
>>
>> Both dma driver clean up all / terminate all descriptors as required=
 but
>> _none_ of them completes the cookie. As a result dma_cookie_status()
>> still thinks that the transfer is in progress.
>=20
> Btw how does it matter in the driver here if the transaction complete=
d or
> not after terminate_all() was invoked. What is the purpose of queryin=
g
> status.

In the RX interrupt (of the 8250 unit), the code checks if the transfer
has been already started or not via querying the status. So if it
returns DMA_COMPLETE then a new transfer will be started. If it returns
DMA_IN_PROGRESS then the code returns doing nothing because the DMA
engine should start moving data anytime now so the RX interrupt goes
away.

That means: If the transfer is canceled then it won't be started again.

Btw: the current (probably only) dma driver that is used by 8250-dma is
dw/core.c. That one does cookie complete on terminate:
 dwc_control(DMA_TERMINATE_ALL) -> dwc_descriptor_complete() ->
 dma_cookie_complete().

That is why it works for them=E2=80=A6

[0] Documentation/dmaengine.txt

>=20
> Thanks
>=20

Sebastian
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

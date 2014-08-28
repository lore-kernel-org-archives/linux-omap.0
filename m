From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 1/7] dmaengine: edma: fix two faults which happen with
 the 8250_dma user
Date: Thu, 28 Aug 2014 12:36:11 +0530
Message-ID: <20140828070611.GI13288@intel.com>
References: <1406660344-25307-1-git-send-email-bigeasy@linutronix.de>
 <1406660344-25307-2-git-send-email-bigeasy@linutronix.de>
 <20140731121702.GU8181@intel.com>
 <20140808162950.GA12080@linutronix.de>
 <20140819151216.GO13288@intel.com>
 <53F5EF78.2050800@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <53F5EF78.2050800@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, balbi@ti.com, Joel Fernandes <joelf@ti.com>, Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Thu, Aug 21, 2014 at 03:09:12PM +0200, Sebastian Andrzej Siewior wro=
te:
> On 08/19/2014 05:12 PM, Vinod Koul wrote:
> >>
> >>     desc =3D dmaengine_prep_slave_single(rxchan, =E2=80=A6);
> >>     rx_cookie =3D dmaengine_submit(desc);
> >>     dma_async_issue_pending(rxchan);
> >>
> >>     ssleep(2);
> >>     /* Now assume that the transfer did not start */
> >>     st =3D dmaengine_tx_status(rxchan, rx_cookie, NULL);
> >>     /* st is now DMA_IN_PROGRESS as expected */
> >>
> >>     dmaengine_terminate_all(rxchan);
> >>     st =3D dmaengine_tx_status(rxchan, rx_cookie, NULL);
> > and here is the culprit. You have terminated the channel. This mean=
s that
> > dmaengine driver is free to clean up all the allocated descriptors =
on the
> > channels and do whatever it decides to do with them.
>=20
> descriptors, yes.
and by that logic when you query the driver would have freed up!

> > You have already terminated the channel so what is the point in que=
rying the
> > status of the cookie, which you shouldn't use anyway after invoking
> > terminate_all() as its result is not correct.
>=20
> The point is to check (later, after terminate_all()) if there is an
> outstanding DMA transfer or not _and_ how much data was really
> transfered. Looking at edma it does not really support the latter if
> the transfer is already completed. On the plus side the HW does not
> support partly transfers :)
well that can be achieved properly and differently!
Why don't we pause the channel, get the residue, status and then
terminate.

> But where is it written that the life time of the cookie is limited?
> Looking at the "cooking check" code there is no such thing. It is
> simply compare of completed vs passed number but okay, this is an
> implementation detail.
> From [0] it says under "4. Submit the transaction":
>=20
> | This returns a cookie can be used to check the progress of DMA engi=
ne
> | activity via other DMA engine calls not covered in this document.
>=20
> no life time limit mentioned here. Which brings to the question: Why =
is
> it okay to use the cookie after the transaction "terminated" normally
> but not if it has been canceled?
Due to the special nature of terminate. The point here is that you don'=
t
terminate a transaction but channel operation

> And from [0] the API explanation  "4. =E2=80=A6 dma_async_is_tx_compl=
ete()":


>=20
> |Note:
> |    Not all DMA engine drivers can return reliable information for
> |    a running DMA channel.  It is recommended that DMA engine users
> |    pause or stop (via dmaengine_terminate_all) the channel before
> |    using this API.
>=20
> So the documentation says to use the cookie with
> dma_async_is_tx_complete() and before doing so it is recommended that
> the transfer should be paused or stopped. _Exactly_ what is done here=
=2E
>=20
> >>     /* st is still DMA_IN_PROGRESS but _I_ expect DMA_COMPLETE bec=
ause
> >>      * it has been terminated / canceled
> >>      */
> >>
> >> Both dma driver clean up all / terminate all descriptors as requir=
ed but
> >> _none_ of them completes the cookie. As a result dma_cookie_status=
()
> >> still thinks that the transfer is in progress.
> >=20
> > Btw how does it matter in the driver here if the transaction comple=
ted or
> > not after terminate_all() was invoked. What is the purpose of query=
ing
> > status.
>=20
> In the RX interrupt (of the 8250 unit), the code checks if the transf=
er
> has been already started or not via querying the status. So if it
> returns DMA_COMPLETE then a new transfer will be started. If it retur=
ns
> DMA_IN_PROGRESS then the code returns doing nothing because the DMA
> engine should start moving data anytime now so the RX interrupt goes
> away.
>=20
> That means: If the transfer is canceled then it won't be started agai=
n.
>=20
> Btw: the current (probably only) dma driver that is used by 8250-dma =
is
> dw/core.c. That one does cookie complete on terminate:
>  dwc_control(DMA_TERMINATE_ALL) -> dwc_descriptor_complete() ->
>  dma_cookie_complete().
Yes but would above flow work for you :)

--=20
~Vinod

>=20
> That is why it works for them=E2=80=A6
>=20
> [0] Documentation/dmaengine.txt
>=20
> >=20
> > Thanks
> >=20
>=20
> Sebastian

--=20

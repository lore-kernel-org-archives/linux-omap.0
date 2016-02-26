From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] dmaengine: omap-dma: Do not call omap_dma_callback() from
 tx_status()
Date: Fri, 26 Feb 2016 15:53:18 +0200
Message-ID: <56D058CE.5050205@ti.com>
References: <1456388939-15722-1-git-send-email-peter.ujfalusi@ti.com>
 <20160226010658.GN5783@n2100.arm.linux.org.uk> <56D0279F.2050703@ti.com>
 <20160226112524.GP5783@n2100.arm.linux.org.uk> <56D048EA.2000604@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <56D048EA.2000604@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: vinod.koul@intel.com, dmaengine@vger.kernel.org, linux-omap@vger.kernel.org, nsekhar@ti.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 2016-02-26 14:45, Peter Ujfalusi wrote:
> On 2016-02-26 13:25, Russell King - ARM Linux wrote:
>>>> Your original commit adding the original hack that you're now remo=
ving
>>>> above says that this is to support polled operation: I'm not aware=
 of
>>>> DMA engine supporting such a mode.  DMA_PREP_INTERRUPT is a mechan=
ism
>>>> where requests can be queued without an interrupt to allow batchin=
g.
>>>
>>> Also it is used to suppress DMA interrupts during audio playback fo=
r example.
>>> In this case we will run w/o interrupts and the position is polled.
>>>
>>>> See the raid5/async_tx code, which queues a set of operations with=
out
>>>> DMA_PREP_INTERRUPT, with the final operation with DMA_PREP_INTERRU=
PT
>>>> set.
>>>
>>> We only allow the interrupts to be disabled in cyclic or memcpy mod=
e. With
>>> slave_sg we have interrupts as it is needed to move to the next SG.
>>>
>>>> As the driver is reliant on interrupts to move to the next transfe=
r,
>>>> the patch which causes DMA_PREP_INTERRUPT to influence whether
>>>> interrupts are sent is actually buggy, and will prevent several
>>>> queued DMA operations to fail.
>>>
>>> Yes, the omap-dma only allows the interrupts to be actually disable=
d when it
>>> is save to do so. slave_sg can not work w/o interrupts so there we =
don't
>>> disable them.
>>
>> I get the impression that you haven't taken in what I've said, becau=
se
>> each fragment of your reply is just repeating what the previous frag=
ment
>> said.
>=20
> Sorry about that. I got it.
>=20
>> Let me state that I don't believe you need any hacks here, and this =
patch
>> is not necessary: the final operation in a set of chained memcpy()s =
should
>> have DMA_PREP_INTERRUPT set.
>=20
> calling the omap_dma_callback() from the tx_status() was a bad idea, =
this is
> why I'm fixing it.

The reason that we need to be able to determine if the channel is done =
with
the copy by polling the tx_status is: we need to read and write tiler
registers with DMA on dra7 as per one ERRATA document. This read/write =
can be
executed in interrupt context so we can not rely on DMA callback to be
notified about the completion of the read/write.

> As for the DMA_PREP_INTERRUPT not enabling interrupt was introduced b=
y:
> 4ce98c0a20bef (dmaengine: omap-dma: Add support for memcpy)
>=20
> While we do not have users submitting multiple descriptors I agree th=
at this
> is a possibility and the driver should not fail in such a case.
> I can send a followup patch to fix the omap_dma_prep_dma_memcpy()

With the updated patch based on your comments I can fix the polling in =
the
tx_status callback and with a separate patch I can address your concern
regarding to multiple transfers queued with only the last one having
DMA_PREP_INTERRUPT (and callback provided).

--=20
P=E9ter

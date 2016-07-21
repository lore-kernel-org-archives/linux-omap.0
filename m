From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 2/7] dmaengine: omap-dma: Complete the cookie first on
 transfer completion
Date: Thu, 21 Jul 2016 12:33:12 +0300
Message-ID: <f18ced07-39e4-c336-b788-254c2c130f82@ti.com>
References: <20160714124242.7579-1-peter.ujfalusi@ti.com>
 <20160714124242.7579-3-peter.ujfalusi@ti.com>
 <20160718103409.GH5783@n2100.arm.linux.org.uk>
 <923b54d6-c7fc-66c2-1c20-d8d74ebed912@ti.com> <877fcg25c4.fsf@belgarion.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <877fcg25c4.fsf@belgarion.home>
Sender: linux-kernel-owner@vger.kernel.org
To: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: Russell King - ARM Linux <linux@armlinux.org.uk>, vinod.koul@intel.com, linux-kernel@vger.kernel.org, tony@atomide.com, dmaengine@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 07/20/16 09:26, Robert Jarzmik wrote:
> Peter Ujfalusi <peter.ujfalusi@ti.com> writes:
>=20
>> On 07/18/16 13:34, Russell King - ARM Linux wrote:
>>> On Thu, Jul 14, 2016 at 03:42:37PM +0300, Peter Ujfalusi wrote:
>>>> Before looking for the next descriptor to start, complete the just=
 finished
>>>> cookie.
>>>
>>> This change will reduce performance as we no longer have an overlap
>>> between the next request starting to be dealt with in the hardware
>>> vs the previous request being completed.
>>
>> vchan_cookie_complete() will only mark the cookie completed, adds th=
e vd to
>> the desc_completed list (it was deleted from desc_issued list when i=
t was
>> started by omap_dma_start_desc) and schedule the tasklet to deal wit=
h the real
>> completion later.
>> Marking the just finished descriptor/cookie done first then looking =
for
>> possible descriptors in the queue to start feels like a better seque=
nce.
>>
>> After a quick grep in the kernel source: only omap-dma.c was startin=
g the next
>> transfer before marking the current completed descriptor/cookie done=
=2E
>=20
> Euh actually I think it's done in other drivers as well :
>  - Documentation/dmaengine/pxa_dma.txt (chapter "Transfers hot-chaini=
ng)
>  - drivers/dma/pxa_dma.c
>    =3D> look for pxad_try_hotchain() and it's impact on pxad_chan_han=
dler() which
>    will mark the completion while the next transfer is already pumped=
 by the
>    hardware.

The 'hot-chaining' is a bit different then what omap-dma is doing. If I=
 got it
right. When the DMA is running and a new request comes the driver will =
append
the new transfer to the list used by the HW. This way there will be no =
stop
and restart needed, the DMA is running w/o interruption.

> Speaking of which, from a purely design point of view, as long as you=
 think
> beforehand what is your sequence, ie. what is the sequence of your li=
nk
> chaining, completion handling, etc ..., both marking before or after =
next tx
> start should be fine IMHO.

Yes, it might be a bit better from performance point of view if we firs=
t start
the pending descriptor (if there is one) then do the vchan_cookie_compl=
ete().
On the other hand if we care more about latency and accuracy we should
complete the transfer first then look for pending descriptors. But sinc=
e
virt_dma is using a tasklet for the real completion, the latency is alw=
ays
going to be when the tasklet is given the chance to execute.

> So in your quest for the "better sequence" the pxa driver's one might=
 give you
> some perspective :)

I did thought about similar 'hot-chaining' for TI's eDMA and sDMA. Espe=
cially
eDMA would benefit from it, but so far I see too many race conditions t=
o
overcome to be brave enough to write something to test it. and I don't =
have
time for it atm ;)

--=20
P=E9ter

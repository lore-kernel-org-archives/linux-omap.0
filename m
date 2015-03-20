From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: Serious memory leak in TI EDMA driver (drivers/dma/edma.c)
Date: Fri, 20 Mar 2015 15:59:31 +0200
Message-ID: <550C27C3.10406@ti.com>
References: <55072E56.7050802@barix.com> <5508205D.7010106@ti.com> <55087A3A.6070300@barix.com> <55098414.9020301@ti.com> <5509EF23.8080404@barix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:45800 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750990AbbCTN7f (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 20 Mar 2015 09:59:35 -0400
In-Reply-To: <5509EF23.8080404@barix.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Petr Kulhavy <petr@barix.com>, linux-omap@vger.kernel.org

Petr,

On 03/18/2015 11:33 PM, Petr Kulhavy wrote:
> Hi Peter,
>=20
> Yes, we do not use DT.
> Our board design is very close to the da850evm reference board. So if=
 you have
> a chance of getting hold of it you could try on that one.

I have been trying to reproduce this on my OMAP-L138-EVM (da850evm) but=
 was
not able.

There is a big difference in your an my setup: the MMC on my EVM is con=
nected
to MMC/SD0 interface while in your setup it seams to be connected to MM=
C/SD1.
The DMA requests for MMC/SD0 is eDMA CC0 16/17, while the MMC/SD1 is eD=
MA CC1
28/29.
So they are handled by different channel controllers. I would not rule =
out
that the support for the second CC has issues.
The information from you logs just points to this direction also:
You are writing to the MMC, so CC1 ch29 is active most of the time.
In your log the channel number sometimes 65565 ((1 << 16) | 29) sometim=
es it
is 29. In my case it is 17 every time.
I think there is something funny regarding to how these channels on CC1=
 are
working and this might be causing the leak for you.

Unfortunately I do not have HW where I could use any channel on CC1 so =
I can
not debug this further, but I'll look at the code to see if anything ob=
vious
stands out.
And something does stand out:
arch/arm/common/edma.c: dma_irq_handler()
It calls the callback with a wrong interrupt number since it does not t=
ake
into account the different CC.
Can you try something similar to see if it helps:

diff --git a/arch/arm/common/edma.c b/arch/arm/common/edma.c
index 6c49887d326e..e1d413c61e9e 100644
--- a/arch/arm/common/edma.c
+++ b/arch/arm/common/edma.c
@@ -405,7 +405,8 @@ static irqreturn_t dma_irq_handler(int irq, void *d=
ata)
 					BIT(slot));
 			if (edma_cc[ctlr]->intr_data[channel].callback)
 				edma_cc[ctlr]->intr_data[channel].callback(
-					channel, EDMA_DMA_COMPLETE,
+					EDMA_CTLR_CHAN(ctlr, channel),
+					EDMA_DMA_COMPLETE,
 					edma_cc[ctlr]->intr_data[channel].data);
 		}
 	} while (sh_ipr);

--=20
P=E9ter

> The "wrong" channel number justmeans that it's on the second controll=
er
> (pdev->id is 1), the debug is just printing the compound number
> channel+controller.
>=20
> I believe that the problem is in edma_terminate_all(), the active ede=
sc is not
> freed by the vchan_dma_desc_free_list() according to the below debug =
trace.
> The first alloc/free pair is correct, the other alloc has no free - s=
ee the
> "Terminate all" line. I also enabled debug in common/edma.c and virt-=
dma.c.
> Note that the "Terminate all" message is printed at the end of
> edma_terminate_all() function just before return. Printing it earlier=
 was
> disturbing my test.
>=20
> So the critical sequence is:
> - submit transaction
> - issue pending
> - IRQ handler (int 3 ???) - doesn't seem to be relevant
> - terminate all transfers -> dma stop - this doesn't free
> - IRQ handler (int 29) -> callback - probably harmless
>=20
> The issue is that edma_execute() calls vchan_next_desc()  which remov=
es the=20
> request from vc->dest_issued list
> and while the transaction is being processed it's not on any list and
> terminate_all_transfers calling vchan_get_all_descriptors doesn't fin=
d it and
> therefore doesn't free it.
>=20
> Is that a plausible explanation?
>=20
> Cheers
> Petr
>=20
>=20
>=20
> Mar 18 20:38:09 barix user.debug kernel: edma-dma-engine edma-dma-eng=
ine.1:
> ALLOC edesc: 0xc34d5b80 (channel: 65565, sg_len: 9)
> Mar 18 20:38:09 barix user.debug kernel: edma-dma-engine edma-dma-eng=
ine.1:
> vchan c781bc70: txd c34d5b80[1c91]: submitted
> Mar 18 20:38:09 barix user.debug kernel: edma-dma-engine edma-dma-eng=
ine.1:
> first transfer starting on channel 65565
> Mar 18 20:38:09 barix user.debug kernel: EDMA: ER0 00000000
> Mar 18 20:38:09 barix user.debug kernel: EDMA: EER0 20000000
> Mar 18 20:38:09 barix user.debug kernel: edma edma: dma_irq_handler
> Mar 18 20:38:09 barix user.debug kernel: edma edma: IPR0 00000008
> Mar 18 20:38:09 barix user.debug kernel: edma edma: dma_irq_handler
> Mar 18 20:38:09 barix user.debug kernel: edma edma: IPR0 20000000
> Mar 18 20:38:09 barix user.debug kernel: edma-dma-engine edma-dma-eng=
ine.1:
> Edma callback: edesc 0xc34d5b80
> Mar 18 20:38:09 barix user.debug kernel: edma-dma-engine edma-dma-eng=
ine.1:
> Pausing channel 29
> Mar 18 20:38:09 barix user.debug kernel: edma-dma-engine edma-dma-eng=
ine.1:
> Transfer complete, stopping channel 29
> Mar 18 20:38:09 barix user.debug kernel: EDMA: EER0 00000000
> Mar 18 20:38:09 barix user.debug kernel: edma-dma-engine edma-dma-eng=
ine.1:
> Setting edesc 0xc34d5b80 to NULL
> Mar 18 20:38:09 barix user.debug kernel: edma-dma-engine edma-dma-eng=
ine.1:
> txd c34d5b80: freeing
> Mar 18 20:38:09 barix user.debug kernel: edma-dma-engine edma-dma-eng=
ine.1:
> FREE edesc: 0xc34d5b80 (channel: 65565)
> Mar 18 20:38:09 barix user.debug kernel: edma-dma-engine edma-dma-eng=
ine.1:
> ALLOC edesc: 0xc2f53900 (channel: 65565, sg_len: 15)
> Mar 18 20:38:09 barix user.debug kernel: edma-dma-engine edma-dma-eng=
ine.1:
> vchan c781bc70: txd c2f53900[1c92]: submitted
> Mar 18 20:38:09 barix user.debug kernel: edma-dma-engine edma-dma-eng=
ine.1:
> first transfer starting on channel 65565
> Mar 18 20:38:09 barix user.debug kernel: EDMA: ER0 00000000
> Mar 18 20:38:09 barix user.debug kernel: EDMA: EER0 20000000
> Mar 18 20:38:09 barix user.debug kernel: edma edma: dma_irq_handler
> Mar 18 20:38:09 barix user.debug kernel: edma edma: IPR0 00000008
> Mar 18 20:38:09 barix user.debug kernel: EDMA: EER0 00000000
> Mar 18 20:38:09 barix user.debug kernel: edma-dma-engine edma-dma-eng=
ine.1:
> Terminate all, setting edesc 0xc2f53900 to NULL
> Mar 18 20:38:09 barix user.debug kernel: edma edma: dma_irq_handler
> Mar 18 20:38:09 barix user.debug kernel: edma edma: IPR0 20000000
> Mar 18 20:38:09 barix user.debug kernel: edma-dma-engine edma-dma-eng=
ine.1:
> Edma callback: edesc 0x  (null)
> Mar 18 20:38:09 barix user.debug kernel: edma-dma-engine edma-dma-eng=
ine.1:
> Pausing channel 29
> Mar 18 20:38:09 barix user.debug kernel: edma-dma-engine edma-dma-eng=
ine.1:
> ALLOC edesc: 0xc2f52140 (channel: 65565, sg_len: 16)
> Mar 18 20:38:09 barix user.debug kernel: edma-dma-engine edma-dma-eng=
ine.1:
> vchan c781bc70: txd c2f52140[1c93]: submitted
>=20
>=20
>=20
> On 18.03.2015 14:56, Peter Ujfalusi wrote:
>> Petr,
>>
>> On 03/17/2015 09:02 PM, Petr Kulhavy wrote:
>>> Hi Peter,
>>>
>>> thanks a lot for the details.
>>> I believe it's not an Ethernet issue, it's really related to the SD=
 card. If
>>> we use the USB storage instead of the SD card on our device we don'=
t see the
>>> leaks.
>> I believe you are not booting with DT. The two eDMA is only supporte=
d when
>> booting in legacy mode.
>>
>>> I enabled the dynamic debug and added a debug message for the kzall=
oc() in
>>> edma_prep_slave_sg() and for the kfree() in the edma_desc_free() bo=
th to print
>>> the pointer address. And it gives an interesting result, see below.
>>>
>>> You can see that after every alloc (i.e.edma_prep_slave_sg()) edma_=
execute()
>>> is called ("file transfer starting..."), however not all of them en=
d with
>>> "Transfer complete". And exactly those are also not freed.
>> I did the same on am335x-evmsk and I don't see the same issue (linux=
-next). It
>> does not mean that we do not have the issue you describe, but someho=
w it is
>> not that easy to reproduce. I will try my OMAP-L138 board, which is =
closer to
>> AM1808 than AM335x.
>>
>>> Unfortunately I do not know how exactly the edma mechanism works wi=
th all the
>>> callbacks, states, etc.
>>> But does it make any sense for you? Can you help me to debug more?
>> Not sure at the moment, but I would try to print also in the error c=
ases in
>> the callback and track the edesc pointer in every prints to see wher=
e the code
>> goes. I would enable the prints in the edma_execute as well to see w=
hat is
>> going on there.
>>
>> For reference I have these prints:
>> [  924.127638] ALLOC edesc: 0xcd948c40 (channel: 25, sg_len: 1, roun=
ds: 1)
>> [  924.134598] first transfer starting on channel 25 (edesc: 0xcd948=
c40)
>> [  924.145505] Transfer complete, stopping channel: 25 (edesc: 0xcd9=
48c40)
>> [  924.152561] FREE edesc: 0xcd948c40 (channel: 25)
>> [  924.159223] ALLOC edesc: 0xc916f800 (channel: 25, sg_len: 30, rou=
nds: 2)
>> [  924.166611] first transfer starting on channel 25 (edesc: 0xc916f=
800)
>> [  924.180541] Intermediate transfer complete on channel: 25 (edesc:
>> 0xc916f800)
>> [  924.188054] chan: 25: completed 30 elements, resuming (edesc: 0xc=
916f800)
>> [  924.195208] Error occurred on channel: 25 (edesc: 0xc916f800), TR=
IGGERING
>> [  924.204117] Transfer complete, stopping channel: 25 (edesc: 0xc91=
6f800)
>> [  924.211158] FREE edesc: 0xc916f800 (channel: 25)
>> [  924.218407] ALLOC edesc: 0xc6cbce00 (channel: 25, sg_len: 8, roun=
ds: 1)
>> [  924.225396] first transfer starting on channel 25 (edesc: 0xc6cbc=
e00)
>> [  924.236530] Transfer complete, stopping channel: 25 (edesc: 0xc6c=
bce00)
>> [  924.243506] FREE edesc: 0xc6cbce00 (channel: 25)
>> [  924.248817] ALLOC edesc: 0xcaa5ec00 (channel: 25, sg_len: 12, rou=
nds: 1)
>> [  924.256068] first transfer starting on channel 25 (edesc: 0xcaa5e=
c00)
>> [  924.268277] Transfer complete, stopping channel: 25 (edesc: 0xcaa=
5ec00)
>> [  924.275265] FREE edesc: 0xcaa5ec00 (channel: 25)
>>
>>
>>
>>> Thanks
>>> Petr
>>>
>>> ALLOC edesc c65d5c80
>>> first transfer starting on channel 65565
>> The channel number does not seams right here.
>>
>>> ALLOC edesc c5b69640
>> Would be nice to see the channel as well here. But sure the FREE for=
 c65d5c80
>> is missing. Strange, I don't see how this happens.
>> I have enabled PREEMPT and still can not reproduce - this was my fir=
st idea.
>>
>>> first transfer starting on channel 65565
>>> Transfer complete, stopping channel 29
>>> FREE edesc c5b69640
>>> ALLOC edesc c58ec580
>>> first transfer starting on channel 65565
>>> Transfer complete, stopping channel 29
>>> FREE edesc c58ec580
>>> ALLOC edesc c5103d80
>>> first transfer starting on channel 65565
>>> ALLOC edesc c61e78c0
>>> first transfer starting on channel 65565
>>> ALLOC edesc c65d6f80
>>> first transfer starting on channel 65565
>>> Transfer complete, stopping channel 29
>>> FREE edesc c65d6f80
>>> ALLOC edesc c5b698c0
>>> first transfer starting on channel 65565
>>> Transfer complete, stopping channel 29
>>> FREE edesc c5b698c0
>>> ALLOC edesc c52244c0
>>> first transfer starting on channel 65565
>>> Transfer complete, stopping channel 29
>>> FREE edesc c52244c0
>>> ALLOC edesc c52244c0
>>> first transfer starting on channel 65565
>>> Transfer complete, stopping channel 29
>>> FREE edesc c52244c0
>>> ALLOC edesc c52244c0
>>> first transfer starting on channel 65565
>>> Transfer complete, stopping channel 29
>>> FREE edesc c52244c0
>>> ALLOC edesc c52244c0
>>> first transfer starting on channel 65565
>>> Transfer complete, stopping channel 29
>>> FREE edesc c52244c0
>>> ALLOC edesc c58ec580
>>> first transfer starting on channel 65565
>>> ALLOC edesc c5b698c0
>>> first transfer starting on channel 65565
>>> ALLOC edesc c5103480
>>> first transfer starting on channel 65565
>>> Transfer complete, stopping channel 29
>>> FREE edesc c5103480
>>> ALLOC edesc c5b69640
>>> first transfer starting on channel 65565
>>> Transfer complete, stopping channel 29
>>> FREE edesc c5b69640
>>> ALLOC edesc c61e62c0
>>> first transfer starting on channel 65565
>>> Transfer complete, stopping channel 29
>>> FREE edesc c61e62c0
>>> ALLOC edesc c5227440
>>> first transfer starting on channel 65565
>>> Transfer complete, stopping channel 29
>>> FREE edesc c5227440
>>> ALLOC edesc c5b69640
>>> first transfer starting on channel 65565
>>> ALLOC edesc c5b69b40
>>> first transfer starting on channel 65565
>>> ALLOC edesc c5233000
>>> first transfer starting on channel 65565
>>> ALLOC edesc c5233dc0
>>> first transfer starting on channel 65565
>>> ALLOC edesc c5233140
>>> first transfer starting on channel 65565
>>> Transfer complete, stopping channel 29
>>> FREE edesc c5233140
>>> ALLOC edesc c5233140
>>> first transfer starting on channel 65565
>>> ALLOC edesc c5233280
>>> first transfer starting on channel 65565
>>> Transfer complete, stopping channel 29
>>> FREE edesc c5233280
>>>
>=20

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

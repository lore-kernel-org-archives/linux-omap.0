From: Petr Kulhavy <petr@barix.com>
Subject: Re: Serious memory leak in TI EDMA driver (drivers/dma/edma.c)
Date: Wed, 18 Mar 2015 22:33:23 +0100
Message-ID: <5509EF23.8080404@barix.com>
References: <55072E56.7050802@barix.com> <5508205D.7010106@ti.com> <55087A3A.6070300@barix.com> <55098414.9020301@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:36537 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757062AbbCRVd1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Mar 2015 17:33:27 -0400
Received: by wibg7 with SMTP id g7so101431162wib.1
        for <linux-omap@vger.kernel.org>; Wed, 18 Mar 2015 14:33:26 -0700 (PDT)
In-Reply-To: <55098414.9020301@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>, linux-omap@vger.kernel.org

Hi Peter,

Yes, we do not use DT.
Our board design is very close to the da850evm reference board. So if 
you have a chance of getting hold of it you could try on that one.

The "wrong" channel number justmeans that it's on the second controller 
(pdev->id is 1), the debug is just printing the compound number 
channel+controller.

I believe that the problem is in edma_terminate_all(), the active edesc 
is not freed by the vchan_dma_desc_free_list() according to the below 
debug trace. The first alloc/free pair is correct, the other alloc has 
no free - see the "Terminate all" line. I also enabled debug in 
common/edma.c and virt-dma.c. Note that the "Terminate all" message is 
printed at the end of edma_terminate_all() function just before return. 
Printing it earlier was disturbing my test.

So the critical sequence is:
- submit transaction
- issue pending
- IRQ handler (int 3 ???) - doesn't seem to be relevant
- terminate all transfers -> dma stop - this doesn't free
- IRQ handler (int 29) -> callback - probably harmless

The issue is that edma_execute() calls vchan_next_desc()  which removes 
the  request from vc->dest_issued list
and while the transaction is being processed it's not on any list and 
terminate_all_transfers calling vchan_get_all_descriptors doesn't find 
it and therefore doesn't free it.

Is that a plausible explanation?

Cheers
Petr



Mar 18 20:38:09 barix user.debug kernel: edma-dma-engine 
edma-dma-engine.1: ALLOC edesc: 0xc34d5b80 (channel: 65565, sg_len: 9)
Mar 18 20:38:09 barix user.debug kernel: edma-dma-engine 
edma-dma-engine.1: vchan c781bc70: txd c34d5b80[1c91]: submitted
Mar 18 20:38:09 barix user.debug kernel: edma-dma-engine 
edma-dma-engine.1: first transfer starting on channel 65565
Mar 18 20:38:09 barix user.debug kernel: EDMA: ER0 00000000
Mar 18 20:38:09 barix user.debug kernel: EDMA: EER0 20000000
Mar 18 20:38:09 barix user.debug kernel: edma edma: dma_irq_handler
Mar 18 20:38:09 barix user.debug kernel: edma edma: IPR0 00000008
Mar 18 20:38:09 barix user.debug kernel: edma edma: dma_irq_handler
Mar 18 20:38:09 barix user.debug kernel: edma edma: IPR0 20000000
Mar 18 20:38:09 barix user.debug kernel: edma-dma-engine 
edma-dma-engine.1: Edma callback: edesc 0xc34d5b80
Mar 18 20:38:09 barix user.debug kernel: edma-dma-engine 
edma-dma-engine.1: Pausing channel 29
Mar 18 20:38:09 barix user.debug kernel: edma-dma-engine 
edma-dma-engine.1: Transfer complete, stopping channel 29
Mar 18 20:38:09 barix user.debug kernel: EDMA: EER0 00000000
Mar 18 20:38:09 barix user.debug kernel: edma-dma-engine 
edma-dma-engine.1: Setting edesc 0xc34d5b80 to NULL
Mar 18 20:38:09 barix user.debug kernel: edma-dma-engine 
edma-dma-engine.1: txd c34d5b80: freeing
Mar 18 20:38:09 barix user.debug kernel: edma-dma-engine 
edma-dma-engine.1: FREE edesc: 0xc34d5b80 (channel: 65565)
Mar 18 20:38:09 barix user.debug kernel: edma-dma-engine 
edma-dma-engine.1: ALLOC edesc: 0xc2f53900 (channel: 65565, sg_len: 15)
Mar 18 20:38:09 barix user.debug kernel: edma-dma-engine 
edma-dma-engine.1: vchan c781bc70: txd c2f53900[1c92]: submitted
Mar 18 20:38:09 barix user.debug kernel: edma-dma-engine 
edma-dma-engine.1: first transfer starting on channel 65565
Mar 18 20:38:09 barix user.debug kernel: EDMA: ER0 00000000
Mar 18 20:38:09 barix user.debug kernel: EDMA: EER0 20000000
Mar 18 20:38:09 barix user.debug kernel: edma edma: dma_irq_handler
Mar 18 20:38:09 barix user.debug kernel: edma edma: IPR0 00000008
Mar 18 20:38:09 barix user.debug kernel: EDMA: EER0 00000000
Mar 18 20:38:09 barix user.debug kernel: edma-dma-engine 
edma-dma-engine.1: Terminate all, setting edesc 0xc2f53900 to NULL
Mar 18 20:38:09 barix user.debug kernel: edma edma: dma_irq_handler
Mar 18 20:38:09 barix user.debug kernel: edma edma: IPR0 20000000
Mar 18 20:38:09 barix user.debug kernel: edma-dma-engine 
edma-dma-engine.1: Edma callback: edesc 0x  (null)
Mar 18 20:38:09 barix user.debug kernel: edma-dma-engine 
edma-dma-engine.1: Pausing channel 29
Mar 18 20:38:09 barix user.debug kernel: edma-dma-engine 
edma-dma-engine.1: ALLOC edesc: 0xc2f52140 (channel: 65565, sg_len: 16)
Mar 18 20:38:09 barix user.debug kernel: edma-dma-engine 
edma-dma-engine.1: vchan c781bc70: txd c2f52140[1c93]: submitted



On 18.03.2015 14:56, Peter Ujfalusi wrote:
> Petr,
>
> On 03/17/2015 09:02 PM, Petr Kulhavy wrote:
>> Hi Peter,
>>
>> thanks a lot for the details.
>> I believe it's not an Ethernet issue, it's really related to the SD card. If
>> we use the USB storage instead of the SD card on our device we don't see the
>> leaks.
> I believe you are not booting with DT. The two eDMA is only supported when
> booting in legacy mode.
>
>> I enabled the dynamic debug and added a debug message for the kzalloc() in
>> edma_prep_slave_sg() and for the kfree() in the edma_desc_free() both to print
>> the pointer address. And it gives an interesting result, see below.
>>
>> You can see that after every alloc (i.e.edma_prep_slave_sg()) edma_execute()
>> is called ("file transfer starting..."), however not all of them end with
>> "Transfer complete". And exactly those are also not freed.
> I did the same on am335x-evmsk and I don't see the same issue (linux-next). It
> does not mean that we do not have the issue you describe, but somehow it is
> not that easy to reproduce. I will try my OMAP-L138 board, which is closer to
> AM1808 than AM335x.
>
>> Unfortunately I do not know how exactly the edma mechanism works with all the
>> callbacks, states, etc.
>> But does it make any sense for you? Can you help me to debug more?
> Not sure at the moment, but I would try to print also in the error cases in
> the callback and track the edesc pointer in every prints to see where the code
> goes. I would enable the prints in the edma_execute as well to see what is
> going on there.
>
> For reference I have these prints:
> [  924.127638] ALLOC edesc: 0xcd948c40 (channel: 25, sg_len: 1, rounds: 1)
> [  924.134598] first transfer starting on channel 25 (edesc: 0xcd948c40)
> [  924.145505] Transfer complete, stopping channel: 25 (edesc: 0xcd948c40)
> [  924.152561] FREE edesc: 0xcd948c40 (channel: 25)
> [  924.159223] ALLOC edesc: 0xc916f800 (channel: 25, sg_len: 30, rounds: 2)
> [  924.166611] first transfer starting on channel 25 (edesc: 0xc916f800)
> [  924.180541] Intermediate transfer complete on channel: 25 (edesc: 0xc916f800)
> [  924.188054] chan: 25: completed 30 elements, resuming (edesc: 0xc916f800)
> [  924.195208] Error occurred on channel: 25 (edesc: 0xc916f800), TRIGGERING
> [  924.204117] Transfer complete, stopping channel: 25 (edesc: 0xc916f800)
> [  924.211158] FREE edesc: 0xc916f800 (channel: 25)
> [  924.218407] ALLOC edesc: 0xc6cbce00 (channel: 25, sg_len: 8, rounds: 1)
> [  924.225396] first transfer starting on channel 25 (edesc: 0xc6cbce00)
> [  924.236530] Transfer complete, stopping channel: 25 (edesc: 0xc6cbce00)
> [  924.243506] FREE edesc: 0xc6cbce00 (channel: 25)
> [  924.248817] ALLOC edesc: 0xcaa5ec00 (channel: 25, sg_len: 12, rounds: 1)
> [  924.256068] first transfer starting on channel 25 (edesc: 0xcaa5ec00)
> [  924.268277] Transfer complete, stopping channel: 25 (edesc: 0xcaa5ec00)
> [  924.275265] FREE edesc: 0xcaa5ec00 (channel: 25)
>
>
>
>> Thanks
>> Petr
>>
>> ALLOC edesc c65d5c80
>> first transfer starting on channel 65565
> The channel number does not seams right here.
>
>> ALLOC edesc c5b69640
> Would be nice to see the channel as well here. But sure the FREE for c65d5c80
> is missing. Strange, I don't see how this happens.
> I have enabled PREEMPT and still can not reproduce - this was my first idea.
>
>> first transfer starting on channel 65565
>> Transfer complete, stopping channel 29
>> FREE edesc c5b69640
>> ALLOC edesc c58ec580
>> first transfer starting on channel 65565
>> Transfer complete, stopping channel 29
>> FREE edesc c58ec580
>> ALLOC edesc c5103d80
>> first transfer starting on channel 65565
>> ALLOC edesc c61e78c0
>> first transfer starting on channel 65565
>> ALLOC edesc c65d6f80
>> first transfer starting on channel 65565
>> Transfer complete, stopping channel 29
>> FREE edesc c65d6f80
>> ALLOC edesc c5b698c0
>> first transfer starting on channel 65565
>> Transfer complete, stopping channel 29
>> FREE edesc c5b698c0
>> ALLOC edesc c52244c0
>> first transfer starting on channel 65565
>> Transfer complete, stopping channel 29
>> FREE edesc c52244c0
>> ALLOC edesc c52244c0
>> first transfer starting on channel 65565
>> Transfer complete, stopping channel 29
>> FREE edesc c52244c0
>> ALLOC edesc c52244c0
>> first transfer starting on channel 65565
>> Transfer complete, stopping channel 29
>> FREE edesc c52244c0
>> ALLOC edesc c52244c0
>> first transfer starting on channel 65565
>> Transfer complete, stopping channel 29
>> FREE edesc c52244c0
>> ALLOC edesc c58ec580
>> first transfer starting on channel 65565
>> ALLOC edesc c5b698c0
>> first transfer starting on channel 65565
>> ALLOC edesc c5103480
>> first transfer starting on channel 65565
>> Transfer complete, stopping channel 29
>> FREE edesc c5103480
>> ALLOC edesc c5b69640
>> first transfer starting on channel 65565
>> Transfer complete, stopping channel 29
>> FREE edesc c5b69640
>> ALLOC edesc c61e62c0
>> first transfer starting on channel 65565
>> Transfer complete, stopping channel 29
>> FREE edesc c61e62c0
>> ALLOC edesc c5227440
>> first transfer starting on channel 65565
>> Transfer complete, stopping channel 29
>> FREE edesc c5227440
>> ALLOC edesc c5b69640
>> first transfer starting on channel 65565
>> ALLOC edesc c5b69b40
>> first transfer starting on channel 65565
>> ALLOC edesc c5233000
>> first transfer starting on channel 65565
>> ALLOC edesc c5233dc0
>> first transfer starting on channel 65565
>> ALLOC edesc c5233140
>> first transfer starting on channel 65565
>> Transfer complete, stopping channel 29
>> FREE edesc c5233140
>> ALLOC edesc c5233140
>> first transfer starting on channel 65565
>> ALLOC edesc c5233280
>> first transfer starting on channel 65565
>> Transfer complete, stopping channel 29
>> FREE edesc c5233280
>>


From: Petr Kulhavy <petr@barix.com>
Subject: Re: Serious memory leak in TI EDMA driver (drivers/dma/edma.c)
Date: Tue, 17 Mar 2015 20:02:18 +0100
Message-ID: <55087A3A.6070300@barix.com>
References: <55072E56.7050802@barix.com> <5508205D.7010106@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:38430 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932107AbbCQTCW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Mar 2015 15:02:22 -0400
Received: by wifj2 with SMTP id j2so19286596wif.1
        for <linux-omap@vger.kernel.org>; Tue, 17 Mar 2015 12:02:21 -0700 (PDT)
In-Reply-To: <5508205D.7010106@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>, linux-omap@vger.kernel.org

Hi Peter,

thanks a lot for the details.
I believe it's not an Ethernet issue, it's really related to the SD 
card. If we use the USB storage instead of the SD card on our device we 
don't see the leaks.

I enabled the dynamic debug and added a debug message for the kzalloc() 
in edma_prep_slave_sg() and for the kfree() in the edma_desc_free() both 
to print the pointer address. And it gives an interesting result, see below.

You can see that after every alloc (i.e.edma_prep_slave_sg()) 
edma_execute() is called ("file transfer starting..."), however not all 
of them end with "Transfer complete". And exactly those are also not freed.

Unfortunately I do not know how exactly the edma mechanism works with 
all the callbacks, states, etc.
But does it make any sense for you? Can you help me to debug more?

Thanks
Petr

ALLOC edesc c65d5c80
first transfer starting on channel 65565
ALLOC edesc c5b69640
first transfer starting on channel 65565
Transfer complete, stopping channel 29
FREE edesc c5b69640
ALLOC edesc c58ec580
first transfer starting on channel 65565
Transfer complete, stopping channel 29
FREE edesc c58ec580
ALLOC edesc c5103d80
first transfer starting on channel 65565
ALLOC edesc c61e78c0
first transfer starting on channel 65565
ALLOC edesc c65d6f80
first transfer starting on channel 65565
Transfer complete, stopping channel 29
FREE edesc c65d6f80
ALLOC edesc c5b698c0
first transfer starting on channel 65565
Transfer complete, stopping channel 29
FREE edesc c5b698c0
ALLOC edesc c52244c0
first transfer starting on channel 65565
Transfer complete, stopping channel 29
FREE edesc c52244c0
ALLOC edesc c52244c0
first transfer starting on channel 65565
Transfer complete, stopping channel 29
FREE edesc c52244c0
ALLOC edesc c52244c0
first transfer starting on channel 65565
Transfer complete, stopping channel 29
FREE edesc c52244c0
ALLOC edesc c52244c0
first transfer starting on channel 65565
Transfer complete, stopping channel 29
FREE edesc c52244c0
ALLOC edesc c58ec580
first transfer starting on channel 65565
ALLOC edesc c5b698c0
first transfer starting on channel 65565
ALLOC edesc c5103480
first transfer starting on channel 65565
Transfer complete, stopping channel 29
FREE edesc c5103480
ALLOC edesc c5b69640
first transfer starting on channel 65565
Transfer complete, stopping channel 29
FREE edesc c5b69640
ALLOC edesc c61e62c0
first transfer starting on channel 65565
Transfer complete, stopping channel 29
FREE edesc c61e62c0
ALLOC edesc c5227440
first transfer starting on channel 65565
Transfer complete, stopping channel 29
FREE edesc c5227440
ALLOC edesc c5b69640
first transfer starting on channel 65565
ALLOC edesc c5b69b40
first transfer starting on channel 65565
ALLOC edesc c5233000
first transfer starting on channel 65565
ALLOC edesc c5233dc0
first transfer starting on channel 65565
ALLOC edesc c5233140
first transfer starting on channel 65565
Transfer complete, stopping channel 29
FREE edesc c5233140
ALLOC edesc c5233140
first transfer starting on channel 65565
ALLOC edesc c5233280
first transfer starting on channel 65565
Transfer complete, stopping channel 29
FREE edesc c5233280




On 17.03.2015 13:38, Peter Ujfalusi wrote:
> Hi,
>
> On 03/16/2015 09:26 PM, Petr Kulhavy wrote:
>> Hi,
>>
>> I have found a memory leak in the TI EDMA driver, which happens every time a
>> DMA transfer is performed.
>> The leak is in kernel 3.17, however the same problem seems to exist also in 3.19.
> I have issues booting the 3.17, 3.18 and 3.19 on my am335x-evmsk so I could
> only test this with 4.0-rc4 and linux-next.
>
>> In particular this was found on our custom TI AM1808 based hardware while
>> accessing the MMC/SD card interface.
>> When extensively using the SD card (e.g. downloading files to it) you can
>> virtually see the "SUnreclaim" memory in /proc/meminfo growing few kB every
>> few seconds.
> I've done the test dd-ing to/from the mmc, running a recursive grep on the
> filesystem on the mmc. This should have generated enough edma requests.
>
>> After few days of operation a device with 128MB of RAM renders unusable (lack
>> of memory, system slow, processes being killed, etc.), the unreclaimed SLAB
>> memory is over 50MB.
>>
>> The kernel memory leak debug mechanism revealed the leak to happen in
>> edma_prep_slave_sg(), however the same pattern repeats all over the edma.c
>> file (see below).
>>
>> unreferenced object 0xc5abe3c0 (size 128):
>>    comm "mmcqd/0", pid 1099, jiffies 4294948151 (age 5865.330s)
>>    hex dump (first 32 bytes):
>>      b7 02 00 00 03 00 00 00 00 00 00 00 80 bb 81 c7  ................
>>      18 b4 23 c0 00 00 00 00 00 00 00 00 00 00 00 00  ..#.............
>>    backtrace:
>>      [<c023c8d0>] edma_prep_slave_sg+0x98/0x344
>>      [<c030b350>] mmc_davinci_request+0x3d4/0x53c
>>      [<c02f86c8>] mmc_start_request+0xc4/0xe8
>>      [<c02f9654>] mmc_start_req+0x18c/0x354
>>      [<c0307c84>] mmc_blk_issue_rw_rq+0xc0/0xc94
>>      [<c0308a0c>] mmc_blk_issue_rq+0x1b4/0x4f4
>>      [<c0309648>] mmc_queue_thread+0xb8/0x168
>>      [<c0034930>] kthread+0xb4/0xd0
>>      [<c0009730>] ret_from_fork+0x14/0x24
>>      [<ffffffff>] 0xffffffff
> But I have not seen a single report from kmemleak suggesting edma.
>
>> The structure edma_desc is allocated using kzalloc in the edma_prep_slave_sg()
>> function, then a pointer to a member of its substructure
>> (dma_async_tx_descriptor) is returned.
>> Therefore the edma_desc structure cannot be freed since the allocated address
>> is nowhere stored and therefore lost.
> the allocated edesc is freed up in edma_desc_free(), which is going to be
> called either from vchan_dma_desc_free_list() or vchan_cookie_complete() when
> we terminate the dma transfer or when the transfer is completed.
>
>> I also haven't found that the dma_async_tx_descriptor would be freed, but not
>> sure whether the kernel does this in some other place?
> It is freed when the edesc is freed up since the dma_async_tx_descriptor is
> part of the edma_desc :
>
> struct edma_desc {
> 	struct virt_dma_desc		vdesc;
> ...
> };
>
> struct virt_dma_desc {
> 	struct dma_async_tx_descriptor tx;
> 	/* protected by vc.lock */
> 	struct list_head node;
> };
>
> and the &vdesc->tx is returned from vchan_tx_prep().
>
>> Basically every time there is edma_prep_slave_sg 128 bytes of memory is
>> allocated but it's never freed.
>> I'm not sure what is the right way to fix this issue, but it seems to me that
>> the driver needs a more significant change to keep e.g. a pool of resources
>> which is reused and eventually freed, like some other EDMA drivers do.
>>
>> Could you please advise what to do.
> I can not reproduce the leak from edma driver, but I could get leaks from the
> ethernet:
> unreferenced object 0xcbe2f400 (size 176):
>    comm "softirq", pid 0, jiffies 358465 (age 84.320s)
>    hex dump (first 32 bytes):
>      00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>      00 00 00 00 00 98 99 cb 00 00 00 00 00 00 00 00  ................
>    backtrace:
>      [<c04fc4c8>] __alloc_rx_skb+0x58/0xdc
>      [<c04fc564>] __netdev_alloc_skb+0x18/0x40
>      [<c045c750>] cpsw_rx_handler+0x70/0x1c0
>      [<c04599f8>] __cpdma_chan_process+0xf0/0x130
>      [<c0459a74>] cpdma_chan_process+0x3c/0x5c
>      [<c045bd20>] cpsw_poll+0x28/0xd8
>      [<c050ce34>] net_rx_action+0x1d4/0x334
>      [<c0042404>] __do_softirq+0xd4/0x348
>      [<c0042998>] irq_exit+0xbc/0x130
>      [<c0090b10>] __handle_domain_irq+0x6c/0xe0
>      [<c00086fc>] omap_intc_handle_irq+0xb4/0xc4
>      [<c05e3724>] __irq_svc+0x44/0x5c
>      [<c05e2f0c>] _raw_spin_unlock_irqrestore+0x34/0x44
>      [<c05e2f0c>] _raw_spin_unlock_irqrestore+0x34/0x44
>      [<c014fe94>] scan_gray_list+0x150/0x18c
>      [<c01500ec>] kmemleak_scan+0x21c/0x4d8
>
> by just pinging the board (ping -s 2000 192.168.1.120).
>
> It might be possible that you are seeing this cpdma leak in the edma driver.
> If you download and store it to mmc, this might be something which is plausible.
>


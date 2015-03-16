From: Tony Lindgren <tony@atomide.com>
Subject: Re: Serious memory leak in TI EDMA driver (drivers/dma/edma.c)
Date: Mon, 16 Mar 2015 12:27:24 -0700
Message-ID: <20150316192724.GX5264@atomide.com>
References: <55072E56.7050802@barix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:37738 "EHLO muru.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932427AbbCPTcO (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 16 Mar 2015 15:32:14 -0400
Content-Disposition: inline
In-Reply-To: <55072E56.7050802@barix.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Petr Kulhavy <petr@barix.com>
Cc: linux-omap@vger.kernel.org, Peter Ujfalusi <peter.ujfalusi@ti.com>

Hi,

* Petr Kulhavy <petr@barix.com> [150316 12:26]:
> Hi,
> 
> I have found a memory leak in the TI EDMA driver, which happens every time a
> DMA transfer is performed.
> The leak is in kernel 3.17, however the same problem seems to exist also in
> 3.19.
> 
> In particular this was found on our custom TI AM1808 based hardware while
> accessing the MMC/SD card interface.
> When extensively using the SD card (e.g. downloading files to it) you can
> virtually see the "SUnreclaim" memory in /proc/meminfo growing few kB every
> few seconds.
> After few days of operation a device with 128MB of RAM renders unusable
> (lack of memory, system slow, processes being killed, etc.), the unreclaimed
> SLAB memory is over 50MB.
> 
> The kernel memory leak debug mechanism revealed the leak to happen in
> edma_prep_slave_sg(), however the same pattern repeats all over the edma.c
> file (see below).
> 
> unreferenced object 0xc5abe3c0 (size 128):
>   comm "mmcqd/0", pid 1099, jiffies 4294948151 (age 5865.330s)
>   hex dump (first 32 bytes):
>     b7 02 00 00 03 00 00 00 00 00 00 00 80 bb 81 c7  ................
>     18 b4 23 c0 00 00 00 00 00 00 00 00 00 00 00 00  ..#.............
>   backtrace:
>     [<c023c8d0>] edma_prep_slave_sg+0x98/0x344
>     [<c030b350>] mmc_davinci_request+0x3d4/0x53c
>     [<c02f86c8>] mmc_start_request+0xc4/0xe8
>     [<c02f9654>] mmc_start_req+0x18c/0x354
>     [<c0307c84>] mmc_blk_issue_rw_rq+0xc0/0xc94
>     [<c0308a0c>] mmc_blk_issue_rq+0x1b4/0x4f4
>     [<c0309648>] mmc_queue_thread+0xb8/0x168
>     [<c0034930>] kthread+0xb4/0xd0
>     [<c0009730>] ret_from_fork+0x14/0x24
>     [<ffffffff>] 0xffffffff
> 
> 
> The structure edma_desc is allocated using kzalloc in the
> edma_prep_slave_sg() function, then a pointer to a member of its
> substructure (dma_async_tx_descriptor) is returned.
> Therefore the edma_desc structure cannot be freed since the allocated
> address is nowhere stored and therefore lost.
> I also haven't found that the dma_async_tx_descriptor would be freed, but
> not sure whether the kernel does this in some other place?
> 
> Basically every time there is edma_prep_slave_sg 128 bytes of memory is
> allocated but it's never freed.
> I'm not sure what is the right way to fix this issue, but it seems to me
> that the driver needs a more significant change to keep e.g. a pool of
> resources which is reused and eventually freed, like some other EDMA drivers
> do.
> 
> Could you please advise what to do.

Thanks for reporting it. This sounds like something for Peter to look at.

Regards,

Tony

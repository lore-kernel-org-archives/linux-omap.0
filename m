From: Petr Kulhavy <petr@barix.com>
Subject: Serious memory leak in TI EDMA driver (drivers/dma/edma.c)
Date: Mon, 16 Mar 2015 20:27:13 +0100
Message-ID: <55072E91.2010907@barix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:32833 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753753AbbCPT1R convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 Mar 2015 15:27:17 -0400
Received: by wixw10 with SMTP id w10so35399074wix.0
        for <linux-omap@vger.kernel.org>; Mon, 16 Mar 2015 12:27:16 -0700 (PDT)
Received: from [192.168.2.128] (84-72-111-243.dclient.hispeed.ch. [84.72.111.243])
        by mx.google.com with ESMTPSA id l6sm16693257wjx.33.2015.03.16.12.27.14
        for <linux-omap@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Mar 2015 12:27:15 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi,

I have found a memory leak in the TI EDMA driver, which happens every=20
time a DMA transfer is performed.
The leak is in kernel 3.17, however the same problem seems to exist als=
o=20
in 3.19.

In particular this was found on our custom TI AM1808 based hardware=20
while accessing the MMC/SD card interface.
When extensively using the SD card (e.g. downloading files to it) you=20
can virtually see the "SUnreclaim" memory in /proc/meminfo growing few=20
kB every few seconds.
After few days of operation a device with 128MB of RAM renders unusable=
=20
(lack of memory, system slow, processes being killed, etc.), the=20
unreclaimed SLAB memory is over 50MB.

The kernel memory leak debug mechanism revealed the leak to happen in=20
edma_prep_slave_sg(), however the same pattern repeats all over the=20
edma.c file (see below).

unreferenced object 0xc5abe3c0 (size 128):
   comm "mmcqd/0", pid 1099, jiffies 4294948151 (age 5865.330s)
   hex dump (first 32 bytes):
     b7 02 00 00 03 00 00 00 00 00 00 00 80 bb 81 c7  ................
     18 b4 23 c0 00 00 00 00 00 00 00 00 00 00 00 00  ..#.............
   backtrace:
     [<c023c8d0>] edma_prep_slave_sg+0x98/0x344
     [<c030b350>] mmc_davinci_request+0x3d4/0x53c
     [<c02f86c8>] mmc_start_request+0xc4/0xe8
     [<c02f9654>] mmc_start_req+0x18c/0x354
     [<c0307c84>] mmc_blk_issue_rw_rq+0xc0/0xc94
     [<c0308a0c>] mmc_blk_issue_rq+0x1b4/0x4f4
     [<c0309648>] mmc_queue_thread+0xb8/0x168
     [<c0034930>] kthread+0xb4/0xd0
     [<c0009730>] ret_from_fork+0x14/0x24
     [<ffffffff>] 0xffffffff


The structure edma_desc is allocated using kzalloc in the=20
edma_prep_slave_sg() function, then a pointer to a member of its=20
substructure (dma_async_tx_descriptor) is returned.
Therefore the edma_desc structure cannot be freed since the allocated=20
address is nowhere stored and therefore lost.
I also haven't found that the dma_async_tx_descriptor would be freed,=20
but not sure whether the kernel does this in some other place?

Basically every time there is edma_prep_slave_sg 128 bytes of memory is=
=20
allocated but it's never freed.
I'm not sure what is the right way to fix this issue, but it seems to m=
e=20
that the driver needs a more significant change to keep e.g. a pool of=20
resources which is reused and eventually freed, like some other EDMA=20
drivers do.

Could you please advise what to do.

Thank you
Petr


--=20
Petr Kulhavy, MSc
System Architect
Barix AG, Z=FCrich, Switzerland



--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

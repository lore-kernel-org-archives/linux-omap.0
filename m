From: Orjan Friberg <orjan.friberg@flatfrog.com>
Subject: copy_to_user speed from dma_alloc_coherent vs. kmalloc buffer
Date: Wed, 20 Apr 2011 17:12:48 +0200
Message-ID: <4DAEF7F0.4080207@flatfrog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from hd5b91d02.k46641.sta.perspektivbredband.net ([213.185.29.2]:50783
	"EHLO fg-dc1.flatfrog.local" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755147Ab1DTPSO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 20 Apr 2011 11:18:14 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

I have a driver where I do memory to memory DMA between GPMC and SDRAM. 
  Adding a read function, I found that copy_to_user from a 
dma_alloc_coherent buffer is significantly slower than from a kmalloc'd one.

Looking at arch/arm/include/asm/pgtable.h I suspect this difference in 
speed is due to the fact that the dma_alloc_coherent buffer is unbuffered.

What are my options (besides using mmap)?

* Reserve a portion of memory at boot time to be used as the DMA 
destination buffer, use ioremap_cached + manual cache flush as needed?
* Turn on buffering for the DMA destination buffer for the duration of 
the copy_to_user call, then turn it off again (and flush it from the cache)?
* Something else entirely?


This is on a 3730, on Linux 2.6.32.

Thanks,
Orjan

-- 
Orjan Friberg
FlatFrog Laboratories AB

From: Wang Diancheng <dcwang@redflag-linux.com>
Subject: omap24xxvout alloc DMA page failed when using openMAX
Date: Mon, 16 Feb 2009 17:14:34 +0800
Message-ID: <87fxien3ph.fsf@redflag-linux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.redflag-linux.com ([219.237.229.196]:49137 "EHLO
	mail.redflag-linux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752541AbZBPJsx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 Feb 2009 04:48:53 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.redflag-linux.com (redflag-mail - by redflag-linux.com) with ESMTP id 5675D1377A2
	for <linux-omap@vger.kernel.org>; Mon, 16 Feb 2009 17:05:51 +0800 (CST)
Received: from mail.redflag-linux.com ([127.0.0.1])
	by localhost (mail.redflag-linux.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id t6qAktsZ0HV7 for <linux-omap@vger.kernel.org>;
	Mon, 16 Feb 2009 17:05:51 +0800 (CST)
Received: from localhost (unknown [124.16.138.52])
	by mail.redflag-linux.com (redflag-mail - by redflag-linux.com) with ESMTP id 28F2413778F
	for <linux-omap@vger.kernel.org>; Mon, 16 Feb 2009 17:05:51 +0800 (CST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hey, I posted this independently, and someone suggested I should send
it to this mailing list.
I don't read the list, so I'm not sure if this is useful or on-topic
or what.  My apologies in advance if this is noise.
omap24xxvout alloc DMA page failed when I use openMAX on ZOOM2 board,
following is my test command and output:

 gst-launch videotestsrc ! goosink_pp
Setting pipeline to PAUSED ...
Pipeline is PREROLLING ...
^CVIDIOC_STREAMON: Cannot allocate memory
Caught interrupt -- handling interrupt.

root@omap-3430sdp:/mm/bin# gst-launch-0.10: page allocation failure. order:10, mode:0xd1

[<c0032348>] (dump_stack+0x0/0x14) from [<c009323c>] (__alloc_pages_internal+0x3ac/0x3c4)

[<c0092e90>] (__alloc_pages_internal+0x0/0x3c4) from [<c0033b58>] (__dma_alloc+0x160/0x3a0)

[<c00339f8>] (__dma_alloc+0x0/0x3a0) from [<c0033e20>] (dma_alloc_coherent+0x58/0x64)

[<c0033dc8>] (dma_alloc_coherent+0x0/0x64) from [<c01cf280>] (omap24xxvout_do_ioctl+0x10cc/0x1604)

 r7:c6465e38 r6:c7275c00 r5:c7275c00 r4:002d9000

[<c01ce1b4>] (omap24xxvout_do_ioctl+0x0/0x1604) from [<c01c66a4>] (video_usercopy+0x1b8/0x2b8)

[<c01c64ec>] (video_usercopy+0x0/0x2b8) from [<c01cf918>] (omap24xxvout_ioctl+0xdc/0xec)

[<c01cf83c>] (omap24xxvout_ioctl+0x0/0xec) from [<c00bb064>] (vfs_ioctl+0x68/0x78)

[<c00baffc>] (vfs_ioctl+0x0/0x78) from [<c00bb2e4>] (do_vfs_ioctl+0x270/0x280)

 r5:410bfc94 r4:c64f9440

[<c00bb074>] (do_vfs_ioctl+0x0/0x280) from [<c00bb334>] (sys_ioctl+0x40/0x64)

 r7:c64f9440 r6:40045612 r5:410bfc94 r4:00000010

[<c00bb2f4>] (sys_ioctl+0x0/0x64) from [<c002dbe0>] (ret_fast_syscall+0x0/0x2c)

 r7:00000036 r6:0009c2c0 r5:40896128 r4:410bfc94

Mem-info:

DMA per-cpu:

CPU    0: hi:   42, btch:   7 usd:   0

Active:8385 inactive:2703 dirty:0 writeback:0 unstable:0

 free:13840 slab:1054 mapped:3488 pagetables:174 bounce:0

DMA free:55360kB min:1440kB low:1800kB high:2160kB active:33540kB inactive:10812kB present:130048kB pages_scanned:0 al
l_unreclaimable? no

lowmem_reserve[]: 0 0 0

DMA: 264*4kB 160*8kB 100*16kB 169*32kB 87*64kB 30*128kB 21*256kB 19*512kB 9*1024kB 6*2048kB 0*4096kB = 55360kB

4351 total pagecache pages

0 pages in swap cache

Swap cache stats: add 0, delete 0, find 0/0

Free swap  = 0kB

Total swap = 0kB

32768 pages of RAM

14017 free pages

5862 reserved pages

1054 slab pages

4522 pages shared

0 pages swap cached

omap24xxfb_blank: vsyn wait failed



 Thanks .
All sounds from you will really be appreciated.

Best Regards.

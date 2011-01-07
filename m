From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: 4430SDP boot failure
Date: Fri, 7 Jan 2011 17:48:41 +0530
Message-ID: <729152acd9ee0c3e3e3cd505e84f8865@mail.gmail.com>
References: <20110106170805.GE1198@n2100.arm.linux.org.uk> <20110106180030.GA8249@n2100.arm.linux.org.uk>
 <20110106182023.GV7771@atomide.com> <20110106195225.GX7771@atomide.com>
 <20110106203431.GZ7771@atomide.com> <20110106205107.GI1198@n2100.arm.linux.org.uk>
 <20110106235203.GA14425@n2100.arm.linux.org.uk> <d540408e2df154cf13932e79d3a11ceb@mail.gmail.com>
 <20110107092800.GJ1198@n2100.arm.linux.org.uk> <86f60bc5418ca1d3e87db960e5e2c48f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:39632 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751583Ab1AGMSn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Jan 2011 07:18:43 -0500
Received: by mail-fx0-f52.google.com with SMTP id 5so16047762fxm.39
        for <linux-omap@vger.kernel.org>; Fri, 07 Jan 2011 04:18:42 -0800 (PST)
In-Reply-To: <86f60bc5418ca1d3e87db960e5e2c48f@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

> -----Original Message-----
> From: Santosh Shilimkar [mailto:santosh.shilimkar@ti.com]
> Sent: Friday, January 07, 2011 3:23 PM
Ruessell,


> To: Russell King - ARM Linux
> Cc: linux-omap@vger.kernel.org; Tony Lindgren
> Subject: RE: 4430SDP boot failure
>

[....]

> > BTW, if it makes any difference to the boot loader, please note
> that
> > I'm
> > still waiting for the upgrade for the SDP board.
> That means your board is with ES1.0. I shall try 2.6.37 on
> ES1.0

ES1.0 boot nicely on 2.6.37 and I guess I know why you are seeing an
issue. The console is changed to OMAP serial driver from 8250
driver.

Can you try "console=ttyO2" instead of existing ""console=ttyS2" ??

Will send you the latest boot-loader after doing a boot test.

----------------------------------------
## Booting image at 80300000 ...
   Image Name:   Linux-2.6.37
   Image Type:   ARM Linux Kernel Image (uncompressed)
   Data Size:    2898440 Bytes =  2.8 MB
   Load Address: 80008000
   Entry Point:  80008000
   Verifying Checksum ... OK
OK

Starting kernel ...

Uncompressing Linux... done, booting the kernel.
[    0.000000] Linux version 2.6.37 (a0393909@a0393909-desktop) (gcc
version 4.4.1 (Sourcery G++ Lite 2010q1-202) ) #6 SMP Fri Jan 7 17:12:26
IST 2011
[    0.000000] CPU: ARMv7 Processor [410fc091] revision 1 (ARMv7),
cr=10c53c7f
[    0.000000] CPU: VIPT nonaliasing data cache, VIPT aliasing instruction
cache
[    0.000000] Machine: OMAP4430 4430SDP board
[    0.000000] Memory policy: ECC disabled, Data cache writealloc
[    0.000000] OMAP4430 ES1.0
[    0.000000] SRAM: Mapped pa 0x40300000 to va 0xfe400000 size: 0xe000
[    0.000000] FIXME: omap44xx_sram_init not implemented
[    0.000000] PERCPU: Embedded 7 pages/cpu @c0f3d000 s6080 r8192 d14400
u32768
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.
Total pages: 130048
[    0.000000] Kernel command line: console=ttyO2,115200n8 noinitrd
root=/dev/nfs rw
nfsroot=172.24.190.46:/ubuntu/nfs-share/omap4_next/,nolock,tcp,rsize=1024,
wsize=1024 ip=dhcp
[    0.000000] PID hash table entries: 2048 (order: 1, 8192 bytes)
[    0.000000] Dentry cache hash table entries: 65536 (order: 6, 262144
bytes)
[    0.000000] Inode-cache hash table entries: 32768 (order: 5, 131072
bytes)
[    0.000000] Memory: 512MB = 512MB total
[    0.000000] Memory: 508228k/508228k available, 16060k reserved, 0K
highmem
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
[    0.000000]     DMA     : 0xffc00000 - 0xffe00000   (   2 MB)
[    0.000000]     vmalloc : 0xe0800000 - 0xf8000000   ( 376 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xe0000000   ( 512 MB)
[    0.000000]     modules : 0xbf000000 - 0xc0000000   (  16 MB)
[    0.000000]       .init : 0xc0008000 - 0xc004a000   ( 264 kB)
[    0.000000]       .text : 0xc004a000 - 0xc056904c   (5245 kB)
[    0.000000]       .data : 0xc056a000 - 0xc05dadc0   ( 452 kB)
[    0.000000] Hierarchical RCU implementation.

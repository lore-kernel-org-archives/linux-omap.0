From: Peter Tseng <tsenpet09@gmail.com>
Subject: Re: omap-pm: omap3_pm_defconfig no longer booting on Overo
Date: Fri, 30 Apr 2010 23:12:05 -0400
Message-ID: <4BDB9C05.5050307@gmail.com>
References: <4BD93413.6000409@gmail.com> <8739yckbyy.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020501060102040602070906"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:48409 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754973Ab0EADL6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 30 Apr 2010 23:11:58 -0400
Received: by vws19 with SMTP id 19so665890vws.19
        for <linux-omap@vger.kernel.org>; Fri, 30 Apr 2010 20:11:57 -0700 (PDT)
In-Reply-To: <8739yckbyy.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org

This is a multi-part message in MIME format.
--------------020501060102040602070906
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

On 04/30/2010 02:54 PM, Kevin Hilman wrote:
> Peter Tseng <tsenpet09@gmail.com> writes:
> 
>> Since the rc5 tag, omap3_pm_defconfig from the pm branch no longer boots
>> on the Gumstix Overo.
>> I am certain that a build back in the rc3 days worked. Unfortunately, I
>> don't know about rc4, or anything that happenend in the intervening time.
>>
>> Any clues on how to fix? If necessary, I'll provide what info I can to
>> help diagnose the issue if told what to do.
> 
> First step is to enable CONFIG_LL_DEBUG and CONFIG_EARLYPRINTK in the
> defconfig (I should have these enabled by default in omap3_pm_defconfig)
> 
> Then, boot adding 'earlyprintk' to your boot cmdline and post the
> resulting bootlog here.

Here it is. (Forgot to also send to mailing list the first time around)

Peter Tseng

--------------020501060102040602070906
Content-Type: text/plain;
 name="bootlog"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="bootlog"

reading uImage

2069060 bytes read
Booting from mmc ...
## Booting kernel from Legacy Image at 82000000 ...
   Image Name:   Linux-2.6.34-rc5-10043-g94e884a
   Image Type:   ARM Linux Kernel Image (uncompressed)
   Data Size:    2068996 Bytes =  2 MB
   Load Address: 80008000
   Entry Point:  80008000
   Verifying Checksum ... OK
   Loading Kernel Image ... OK
OK

Starting kernel ...

Uncompressing Linux... done, booting the kernel.
Linux version 2.6.34-rc5-10043-g94e884a (leftylink@lefty) (gcc version 4.4.1 (Sourcery G++ Lite 2009q3-67) ) #61 PREEMPT Fri Apr 30 23:00:48 EDT 2010
CPU: ARMv7 Processor [411fc083] revision 3 (ARMv7), cr=10c53c7f
CPU: VIPT nonaliasing data cache, VIPT nonaliasing instruction cache
Machine: Gumstix Overo
bootconsole [earlycon0] enabled
Memory policy: ECC disabled, Data cache writeback
OMAP3430/3530 ES3.1 (l2cache iva sgx neon isp )
SRAM: Mapped pa 0x40200000 to va 0xfe400000 size: 0x100000
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 65024
Kernel command line: console=ttyS2,115200n8 vram=12M omapfb.mode=dvi:1024x768MR-16@60 omapfb.debug=y omapdss.def_disp=dvi root=/dev/mmcblk0p2 rw rootfstype=ext3 rootwait earlyprintk
PID hash table entries: 1024 (order: 0, 4096 bytes)
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Memory: 128MB 128MB = 256MB total
Memory: 255540k/255540k available, 6604k reserved, 0K highmem
Virtual kernel memory layout:
    vector  : 0xffff0000 - 0xffff1000   (   4 kB)
    fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
    DMA     : 0xffc00000 - 0xffe00000   (   2 MB)
    vmalloc : 0xd0800000 - 0xf8000000   ( 632 MB)
    lowmem  : 0xc0000000 - 0xd0000000   ( 256 MB)
    modules : 0xbf000000 - 0xc0000000   (  16 MB)
      .init : 0xc0008000 - 0xc0035000   ( 180 kB)
      .text : 0xc0035000 - 0xc03da000   (3732 kB)
      .data : 0xc03da000 - 0xc041cf60   ( 268 kB)
SLUB: Genslabs=9, HWalign=64, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
Hierarchical RCU implementation.
NR_IRQS:402
Clocking rate (Crystal/Core/MPU): 26.0/331/500 MHz
kernel BUG at arch/arm/mach-omap2/resource34xx.c:229!
Unable to handle kernel NULL pointer dereference at virtual address 00000000
pgd = c0004000
[00000000] *pgd=00000000
Internal error: Oops: 805 [#1] PREEMPT
last sysfs file: 
Modules linked in:
CPU: 0    Not tainted  (2.6.34-rc5-10043-g94e884a #61)
PC is at __bug+0x20/0x2c
LR is at vprintk+0x394/0x404
pc : [<c00392ec>]    lr : [<c006442c>]    psr: 400001d3
sp : c03dbf18  ip : c03dbe68  fp : c03dbf24
r10: 0000001f  r9 : 411fc083  r8 : 80027764
r7 : c03de2d4  r6 : 00000000  r5 : c041dfa0  r4 : c03f3424
r3 : 00000000  r2 : c03dbe68  r1 : 800001d3  r0 : 0000003c
Flags: nZcv  IRQs off  FIQs off  Mode SVC_32  ISA ARM  Segment kernel
Control: 10c5387f  Table: 80004019  DAC: 00000017
Process swapper (pid: 0, stack limit = 0xc03da2e8)
Stack: (0xc03dbf18 to 0xc03dc000)
bf00:                                                       c03dbf4c c03dbf28
bf20: c004c9fc c00392d8 c005598c c01ce138 c03dbf4c c03f3424 c03fa128 00000000
bf40: c03dbf6c c03dbf50 c0055c7c c004c920 c03f3424 c0031a10 00000034 c002a014
bf60: c03dbf84 c03dbf70 c0055d08 c0055bf4 c03f40b0 c03f40b0 c03dbf94 c03dbf88
bf80: c0016114 c0055cb0 c03dbfac c03dbf98 c000e518 c001610c c041cf80 c002a018
bfa0: c03dbfbc c03dbfb0 c0012858 c000e43c c03dbfcc c03dbfc0 c000b458 c0012834
bfc0: c03dbff4 c03dbfd0 c0008a8c c000b42c c00086d8 00000000 00000000 c002a018
bfe0: 10c53c7d c041d320 00000000 c03dbff8 80008034 c0008934 00000000 00000000
Backtrace: 
[<c00392cc>] (__bug+0x0/0x2c) from [<c004c9fc>] (init_opp+0xe8/0x118)
[<c004c914>] (init_opp+0x0/0x118) from [<c0055c7c>] (resource_register+0x94/0xbc)
 r6:00000000 r5:c03fa128 r4:c03f3424
[<c0055be8>] (resource_register+0x0/0xbc) from [<c0055d08>] (resource_init+0x64/0x84)
 r6:c002a014 r5:00000034 r4:c0031a10 r3:c03f3424
[<c0055ca4>] (resource_init+0x0/0x84) from [<c0016114>] (omap_pm_if_init+0x14/0x20)
 r5:c03f40b0 r4:c03f40b0
[<c0016100>] (omap_pm_if_init+0x0/0x20) from [<c000e518>] (omap2_init_common_hw+0xe8/0x19c)
[<c000e430>] (omap2_init_common_hw+0x0/0x19c) from [<c0012858>] (overo_init_irq+0x30/0x4c)
 r5:c002a018 r4:c041cf80
[<c0012828>] (overo_init_irq+0x0/0x4c) from [<c000b458>] (init_IRQ+0x38/0x48)
[<c000b420>] (init_IRQ+0x0/0x48) from [<c0008a8c>] (start_kernel+0x164/0x2d0)
[<c0008928>] (start_kernel+0x0/0x2d0) from [<80008034>] (0x80008034)
 r5:c041d320 r4:10c53c7d
Code: e1a01000 e59f000c eb0b0474 e3a03000 (e5833000) 


--------------020501060102040602070906--

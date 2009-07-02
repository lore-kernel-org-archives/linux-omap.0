From: Raju Sana <venkat.rajuece@gmail.com>
Subject: 2.6.30 jiffies problem
Date: Thu, 2 Jul 2009 15:50:02 +0530
Message-ID: <256210ef0907020320i5127c8d8kcac8ac7d26a7dfeb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f193.google.com ([209.85.222.193]:36617 "EHLO
	mail-pz0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751906AbZGBKT7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Jul 2009 06:19:59 -0400
Received: by pzk31 with SMTP id 31so82664pzk.33
        for <linux-omap@vger.kernel.org>; Thu, 02 Jul 2009 03:20:02 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi all,

I have pulled kernel from linux-omap git's 2.6.30 branch (
http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap-2.6.git;a=shortlog;h=omap-2.6.30
) and trying to boot on my OMAP3 beagle board (Rev. B4). It got stuck
at Calibrating delay loop.....

>From the below log I found that the jiffies value is not getting
incremented and couldn't able to come out of the loop

I found that the OMAP_TICK_GPTIMER which is responsible for the system
tick from the arch/arm/plat-omap/Kconfig is missing in 2.6.30. Can you
guys put some light on what is going wrong ?

Thanks and Regards,
Venkat Raju.


Boot Log:-

Starting kernel ...

Uncompressing Linux...............................................................................................................
done, booting the kernel.
<5>Linux version 2.6.30-omap1-06025-g9474788
(root@ws124.idc.embinux.org) (gcc version 4.2.1 (CodeSourcery Sourcery
G++ Lite 2007q3-51)) #5 Thu Jul 2 10:22:30 IST 2009
CPU: ARMv7 Processor [411fc082] revision 2 (ARMv7), cr=10c5387f
CPU: VIPT nonaliasing data cache, VIPT nonaliasing instruction cache
Machine: OMAP3 Beagle Board
Memory policy: ECC disabled, Data cache writeback
<7>On node 0 totalpages: 32768
<7>free_area_init_node: node 0, pgdat c03677e0, node_mem_map c0383000
<7>  Normal zone: 256 pages used for memmap
<7>  Normal zone: 0 pages reserved
<7>  Normal zone: 32512 pages, LIFO batch:7
<6>OMAP3430 ES2.1
<6>SRAM: Mapped pa 0x40200000 to va 0xd7000000 size: 0x100000
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 32512
<5>Kernel command line: console=ttyS2,115200n8 noinitrd
root=/dev/mmcblk0p2 video=omapfb.mode=dvi:1280x720MR-24@50 init=/init
rootfstype=ext3 rw rootdelay=1 nohz=off androidboo2
<3>Unknown boot option `androidboot.console=ttyS2': ignoring
<6>NR_IRQS:368
<6>Clocking rate (Crystal/DPLL/ARM core): 26.0/332/500 MHz
<6>Reprogramming SDRC clock to 332000000 Hz
<6>GPMC revision 5.0
<6>IRQ: Found an INTC at 0xd8200000 (revision 4.0) with 96 interrupts
<6>Total of 96 interrupts on 1 active controller
<6>OMAP34xx GPIO hardware version 2.5
PID hash table entries: 512 (order: 9, 2048 bytes)
<6>OMAP clockevent source: GPTIMER12 at 32768 Hz
Console: colour dummy device 80x30
<6>Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
<6>Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
<6>Memory: 128MB = 128MB total
<5>Memory: 126192KB available (3056K code, 284K data, 112K init, 0K highmem)
<6>Calibrating delay loop...

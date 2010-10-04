From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: beagle hangs in uart3 disabling clocks
Date: Mon, 04 Oct 2010 08:25:21 -0700
Message-ID: <87k4ly2d5q.fsf@deeprootsystems.com>
References: <AANLkTi=9T=5swvF2UcrfDAL8cpHOcfpOU3Fi1O50Z6Tm@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:62719 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754791Ab0JDPZZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Oct 2010 11:25:25 -0400
Received: by pzk34 with SMTP id 34so1359340pzk.19
        for <linux-omap@vger.kernel.org>; Mon, 04 Oct 2010 08:25:25 -0700 (PDT)
In-Reply-To: <AANLkTi=9T=5swvF2UcrfDAL8cpHOcfpOU3Fi1O50Z6Tm@mail.gmail.com>
	(Ming Lei's message of "Sun, 3 Oct 2010 17:04:11 +0800")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ming Lei <tom.leiming@gmail.com>
Cc: linux-omap@vger.kernel.org

Ming Lei <tom.leiming@gmail.com> writes:

> I just tested pm branch of tony's linux-omap-2.6 tree, and found my
> beagle will hang in uart3 disabling clocks, follows the log info:

It greatly helps when you also state what defconfig you're using, and
what you've changed from the default defconfig.

... more below...

> Starting kernel ...
>
> Uncompressing Linux... done, booting the kernel.
> Linux version 2.6.36-rc6+ (tom@tom-lei) (gcc version 4.3.3 (Sourcery
> G++ Lite 2009q1-203) ) #320 PREEM
> PT Sun Oct 3 16:46:04 CST 2010
> CPU: ARMv7 Processor [411fc082] revision 2 (ARMv7), cr=10c53c7f
> CPU: VIPT nonaliasing data cache, VIPT nonaliasing instruction cache
> Machine: OMAP3 Beagle Board
> bootconsole [earlycon0] enabled
> Memory policy: ECC disabled, Data cache writeback
> OMAP3430/3530 ES2.1 (l2cache iva sgx neon isp )
> SRAM: Mapped pa 0x40200000 to va 0xfe400000 size: 0x10000
> On node 0 totalpages: 32768
> free_area_init_node: node 0, pgdat c04a1a00, node_mem_map c06b8000
>   Normal zone: 256 pages used for memmap
>   Normal zone: 0 pages reserved
>   Normal zone: 32512 pages, LIFO batch:7
> Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 32512
> Kernel command line: console=ttyO2,115200n8 root=/dev/mmcblk0p2 rw
> rootdelay=1 earlyprintk initcall_de
> bug=1 loglevel=8
> PID hash table entries: 512 (order: -1, 2048 bytes)
> Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
> Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
> Memory: 128MB = 128MB total
> Memory: 123068k/123068k available, 8004k reserved, 0K highmem
> Virtual kernel memory layout:
>     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
>     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
>     DMA     : 0xffc00000 - 0xffe00000   (   2 MB)
>     vmalloc : 0xc8800000 - 0xf8000000   ( 760 MB)
>     lowmem  : 0xc0000000 - 0xc8000000   ( 128 MB)
>     modules : 0xbf000000 - 0xc0000000   (  16 MB)
>       .init : 0xc0008000 - 0xc0034000   ( 176 kB)
>       .text : 0xc0034000 - 0xc046c000   (4320 kB)
>       .data : 0xc046c000 - 0xc04a2000   ( 216 kB)
> Preemptable hierarchical RCU implementation.
>         RCU-based detection of stalled CPUs is disabled.
>         Verbose stalled-CPUs detection is disabled.
> NR_IRQS:402
> omap_hwmod: l3_main: registering

You've manually done a '#define DEBUG' in omap_hwmod.c.  This does not
work well with UART hwmods, especially when using a UART console and
using DEBUG_LL + earlyprintk.

[...]

> omap_hwmod: uart2: idling
> omap_hwmod: uart2: disabling clocks
> omap_device: omap-hsuart: activating
> omap_hwmod: uart2: enabling
> omap_hwmod: uart2: enabling clocks
> omap_device: omap-hsuart: pm_lat 0: activate: elapsed time 0 nsec
> omap_device: omap-hsuart: deactivating
> omap_hwmod: uart2: idling
> omap_hwmod: uart2: disabling clocks
> omap_device: omap-hsuart: pm_lat 0: deactivate: elapsed time 0 nsec
> omap_device: omap-hsuart: activating
> omap_hwmod: uart2: enabling
> omap_hwmod: uart2: enabling clocks
> omap_device: omap-hsuart: pm_lat 0: activate: elapsed time 0 nsec
> omap_device: omap-hsuart: building with 1 hwmods
> omap_device: omap-hsuart: counted 4 total resources across 1 hwmods
> omap_device: omap-hsuart: registering
> Registering platform device 'omap-hsuart.2'. Parent at omap
> device: 'omap-hsuart.2': device_add
> bus: 'platform': add device omap-hsuart.2
> PM: Adding info for platform:omap-hsuart.2
> omap_hwmod: uart3: idling
> omap_hwmod: uart3: disabling clocks

Remember UART3 is your serial console.  

Basically, what is happening is that the hwmod is trying to print debug
messages for all hwmod changes.  As soon as UART3 is disabled, the
printing will fail since that is your console, so as soon as uart3
clocks are disabled, there is a fault when the polling-mode serial
driver (used for earlyprintk) tries to access the UART, and you hang.

Kevin




From: Paul Walmsley <paul@pwsan.com>
Subject: Re: n800 can't mount rootfs
Date: Fri, 24 Jul 2009 18:51:32 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0907241849550.2700@utopia.booyaka.com>
References: <87d49h4xj9.fsf@litku.valot.fi>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:49876 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755142AbZGYAvc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Jul 2009 20:51:32 -0400
In-Reply-To: <87d49h4xj9.fsf@litku.valot.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kalle Valo <kalle.valo@iki.fi>
Cc: linux-omap@vger.kernel.org

Hello Kalle,

On Sat, 6 Jun 2009, Kalle Valo wrote:

> I tested linux-omap (commit 151c7a7fc) on n800 and it can't mount rootfs
> anymore. Below is the full bootlog. 
> 
> Unfortunately I don't have time to debug this right now, but I can test
> patches if needed.
> 
> [    0.000000] Linux version 2.6.30-rc8-omap1 (kvalo@tikku) (gcc version
> 4.3.2 (Sourcery G++ Lite 2008q3-66) ) #2 Sat Jun 6 10:28:29 EEST 2009
> [    0.000000] CPU: ARMv6-compatible processor [4107b362] revision 2
> (ARMv6TEJ), cr=00c5387f
> [    0.000000] CPU: VIPT aliasing data cache, VIPT aliasing instruction
> cache
> [    0.000000] Machine: Nokia N800
> [    0.000000] Memory policy: ECC disabled, Data cache writeback
> [    0.000000] OMAP2420<6>
> [    0.000000] SRAM: Mapped pa 0x40200000 to va 0xe3000000 size:
> 0x100000
> [    0.000000] Built 1 zonelists in Zone order, mobility grouping on.
> Total pages: 32512
> [    0.000000] Kernel command line: root=1f03 rootfstype=jffs2
> [    0.000000] NR_IRQS:368
> [    0.000000] Clocking rate (Crystal/DPLL/MPU): 19.2/658/329 MHz
> [    0.000000] GPMC revision 2.0
> [    0.000000] IRQ: Found an INTC at 0xd80fe000 (revision 2.0) with 96
> interrupts
> [    0.000000] Total of 96 interrupts on 1 active controller
> [    0.000000] OMAP242x GPIO hardware version 1.8
> [    0.000000] PID hash table entries: 512 (order: 9, 2048 bytes)
> [    0.000000] OMAP clockevent source: GPTIMER1 at 32000 Hz
> [    0.000000] Console: colour dummy device 80x30
> [    0.000000] Dentry cache hash table entries: 16384 (order: 4, 65536
> bytes)
> [    0.000000] Inode-cache hash table entries: 8192 (order: 3, 32768
> bytes)
> [    0.000000] Memory: 64MB 64MB = 128MB total
> [    0.000000] Memory: 126392KB available (2896K code, 238K data, 120K
> init, 0K highmem)
> [    0.000000] Calibrating delay loop... 320.37 BogoMIPS (lpj=1253376)
> [    0.000000] Security Framework initialized
> [    0.000000] Mount-cache hash table entries: 512
> [    0.000000] CPU: Testing write buffer coherency: ok
> [    0.000000] net_namespace: 668 bytes
> [    0.000000] NET: Registered protocol family 16
> [    0.000000] TUSB 6010
> [    0.000000] kobject (c031e048): tried to init an initialized object,
> something is seriously wrong.
> [    0.000000] [<c002c674>] (unwind_backtrace+0x0/0xdc) from
> [<c0103654>] (kobject_init+0x38/0x70)
> [    0.000000] [<c0103654>] (kobject_init+0x38/0x70) from [<c013fbfc>]
> (device_initialize+0x20/0x70)
> [    0.000000] [<c013fbfc>] (device_initialize+0x20/0x70) from
> [<c0143408>] (platform_device_register+0x10/0x1c)
> [    0.000000] [<c0143408>] (platform_device_register+0x10/0x1c) from
> [<c000e7a0>] (gpmc_onenand_init+0x4c/0x74)
> [    0.000000] [<c000e7a0>] (gpmc_onenand_init+0x4c/0x74) from
> [<c000b13c>] (customize_machine+0x18/0x24)
> [    0.000000] [<c000b13c>] (customize_machine+0x18/0x24) from
> [<c00262bc>] (do_one_initcall+0x54/0x194)
> [    0.000000] [<c00262bc>] (do_one_initcall+0x54/0x194) from
> [<c00083b8>] (kernel_init+0x70/0xe4)
> [    0.000000] [<c00083b8>] (kernel_init+0x70/0xe4) from [<c004d498>]
> (do_exit+0x0/0x580)
> [    0.000000] [<c004d498>] (do_exit+0x0/0x580) from [<00000001>] (0x1)
> [    0.000000] ------------[ cut here ]------------

I get the same thing on N800 (compiling at 
7c5cb7862d32cb344be7831d466535d5255e35ac). 


- Paul

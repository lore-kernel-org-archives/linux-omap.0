From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: Trouble with newer kernels on Gumstix Overo boards
Date: Fri, 17 Jun 2011 19:33:05 +0530
Message-ID: <ADF30F4D7BDE934D9B632CE7D5C7ACA4047B99E7E7AD@dbde03.ent.ti.com>
References: <BANLkTimJTBpj30EKf_EucvOf2yCHHbRrkQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:56544 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759009Ab1FQOFn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Jun 2011 10:05:43 -0400
In-Reply-To: <BANLkTimJTBpj30EKf_EucvOf2yCHHbRrkQ@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Daniel Mack <zonque@gmail.com>, Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Daniel Mack wrote:
> 
> Hi Tony et al,
> 
> I'm having problems booting newer kernels on a Gumstix Overo board.
> 
> I enabled CONFIG_EARLY_PRINTK to see any messages at all, and see a
> number of warnings first and then lots of garbled binary junk once the
> UART is set up.
> 
> This is Linus' current master branch plus your latest fixes from
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git fixes
> 
> 
> Uncompressing Linux... done, booting the kernel.
> [    0.000000] Linux version 3.0.0-rc3-00209-g64db347-dirty
> (daniel@jup) (gcc version 4.4.5 (Buildroot 2010.11-git) ) #24 SMP Fri
> Jun 17 15:42:59 CEST 2011
> [    0.000000] CPU: ARMv7 Processor [411fc083] revision 3 (ARMv7), cr=10c53c7f
> [    0.000000] CPU: VIPT nonaliasing data cache, VIPT nonaliasing
> instruction cache
> [    0.000000] Machine: Gumstix Overo
> [    0.000000] Ignoring tag cmdline (using the default kernel command line)
> [    0.000000] bootconsole [earlycon0] enabled
> [    0.000000] Memory policy: ECC disabled, Data cache writeback
> [    0.000000] OMAP3503 ES3.1 (l2cache neon isp )
> [    0.000000] SRAM: Mapped pa 0x40200000 to va 0xfe400000 size: 0x10000
> [    0.000000] On node 0 totalpages: 65536
> [    0.000000] free_area_init_node: node 0, pgdat c065e9e0,
> node_mem_map c0bb5000
> [    0.000000]   Normal zone: 512 pages used for memmap
> [    0.000000]   Normal zone: 0 pages reserved
> [    0.000000]   Normal zone: 65024 pages, LIFO batch:15
> [    0.000000] Clocking rate (Crystal/Core/MPU): 26.0/331/500 MHz
> [    0.000000] Reprogramming SDRC clock to 331882352 Hz
> [    0.000000] PERCPU: Embedded 7 pages/cpu @c0dba000 s5952 r8192 d14528 u32768
> [    0.000000] pcpu-alloc: s5952 r8192 d14528 u32768 alloc=8*4096
> [    0.000000] pcpu-alloc: [0] 0
> [    0.000000] Built 1 zonelists in Zone order, mobility grouping on.
> Total pages: 65024
> [    0.000000] Kernel command line: debug earlyprintk
> console=ttyS2,115200 root=/dev/mmcblk0p2 rw rootfstype=ext3 rootwait

Here is your problem. We now use the OMAP-serial driver for the UARTs.

Change the ttyS2 to ttyO2 and you should be fine.

- Anand


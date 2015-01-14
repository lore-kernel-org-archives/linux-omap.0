From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: OMAP 4430 SDP: rather sick with recent kernels
Date: Wed, 14 Jan 2015 17:51:32 +0000
Message-ID: <20150114175132.GR11502@n2100.arm.linux.org.uk>
References: <20141217095252.GH11502@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:40171 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750920AbbANRvj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 14 Jan 2015 12:51:39 -0500
Content-Disposition: inline
In-Reply-To: <20141217095252.GH11502@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>

On Wed, Dec 17, 2014 at 09:52:52AM +0000, Russell King - ARM Linux wrote:
> The "combined" kernel boot follows a similar pattern, but yets a bit
> further before oopsing, with ASoC DAPM code printing random bits of
> kernel memory.

Note that the "combined" kernel (which is OMAP4 + Versatile Express)
has for a while now also spat out this:

WARNING: CPU: 0 PID: 1 at .../linux-build/drivers/bus/omap_l3_noc.c:147 l3_interrupt_handler+0x218/0x2f0()
44000000.ocp:L3 Custom Error: MASTER MPU TARGET L4CFG (Idle): Data Access in Supervisor mode during Functional access
Modules linked in:
CPU: 0 PID: 1 Comm: swapper/0 Not tainted 3.19.0-rc4+ #1
Hardware name: Generic OMAP4 (Flattened Device Tree)
Backtrace:
[<c0011bdc>] (dump_backtrace) from [<c0011e9c>] (show_stack+0x18/0x1c)
 r6:c04c073e r5:00000009 r4:00000000 r3:00200040
[<c0011e84>] (show_stack) from [<c0466380>] (dump_stack+0x78/0x94)
[<c0466308>] (dump_stack) from [<c00379ec>] (warn_slowpath_common+0x8c/0xb8)
 r4:ce461b38 r3:ce458000
[<c0037960>] (warn_slowpath_common) from [<c0037abc>] (warn_slowpath_fmt+0x38/0x40)
 r8:c04c06a6 r7:c04c094c r6:80080003 r5:ce54d218 r4:f8000400
[<c0037a88>] (warn_slowpath_fmt) from [<c02098f8>] (l3_interrupt_handler+0x218/0x2f0)
 r3:ce54ad40 r2:c04c0772
[<c02096e0>] (l3_interrupt_handler) from [<c0076444>] (handle_irq_event_percpu+0x38/0x13c)
 r10:ce440700 r9:c06e1c58 r8:ce5b1960 r7:00000000 r6:00000000 r5:00000013
 r4:ce54f480
[<c007640c>] (handle_irq_event_percpu) from [<c007658c>] (handle_irq_event+0x44/0x64)
 r10:00000000 r9:ce5b1938 r8:ce5b1960 r7:00000001 r6:ce54f480 r5:ce440760
 r4:ce440700
[<c0076548>] (handle_irq_event) from [<c00795f4>] (handle_fasteoi_irq+0xb0/0x128)
 r6:ce440760 r5:c06c5fec r4:ce440700 r3:00000000
[<c0079544>] (handle_fasteoi_irq) from [<c0075d60>] (generic_handle_irq+0x28/0x38)
 r6:ce408000 r5:00000000 r4:00000013 r3:c0079544
[<c0075d38>] (generic_handle_irq) from [<c0075ebc>] (__handle_domain_irq+0x90/0xb8)
 r4:00000000 r3:00000110
[<c0075e2c>] (__handle_domain_irq) from [<c0008858>] (gic_handle_irq+0x44/0x68)
 r7:ce461d0c r6:c068b34c r5:ce461cd8 r4:fa240100
[<c0008814>] (gic_handle_irq) from [<c00129c4>] (__irq_svc+0x44/0x5c)
Exception stack(0xce461cd8 to 0xce461d20)
1cc0:                                                       00000001 ce458508
1ce0: 00000000 00000000 60000113 ce5b1960 0000002c 00000000 ce5b1960 ce5b1938
1d00: 00000000 ce461d34 ce461cf0 ce461d20 c006d4f4 c046df64 20000113 ffffffff
 r6:ffffffff r5:20000113 r4:c046df64 r3:ce458000
[<c046df1c>] (_raw_spin_unlock_irqrestore) from [<c0077dd0>] (__setup_irq+0x3bc/0x4e4)
 r5:c06b7c00 r4:ce5b1900
[<c0077a14>] (__setup_irq) from [<c00780ec>] (setup_irq+0x50/0x90)
 r10:c06ea338 r9:20000113 r8:c06ea338 r7:ce67ec00 r6:c06b7c00 r5:0000002c
 r4:ce5b1900
[<c007809c>] (setup_irq) from [<c0032768>] (omap_system_dma_probe+0x20c/0x2a4)
 r6:ce67ec10 r5:0000002c r4:00000020 r3:00000002
[<c003255c>] (omap_system_dma_probe) from [<c0298788>] (platform_drv_probe+0x50/0x98)
 r10:c066d8b0 r9:00000000 r8:00000000 r7:c02971b8 r6:c06b7b94 r5:ffffffed
 r4:ce67ec10
[<c0298738>] (platform_drv_probe) from [<c0296fa8>] (driver_probe_device+0x13c/0x34c)
 r6:00000000 r5:c06b7b94 r4:ce67ec10 r3:c0298738
[<c0296e6c>] (driver_probe_device) from [<c0297230>] (__driver_attach+0x78/0x9c) r8:c0646228 r7:c02971b8 r6:c06b7b94 r5:ce67ec44 r4:ce67ec10
[<c02971b8>] (__driver_attach) from [<c0295424>] (bus_for_each_dev+0x5c/0x98)
 r6:c06b7b94 r5:ce461e48 r4:00000000 r3:c02971b8
[<c02953c8>] (bus_for_each_dev) from [<c02969c0>] (driver_attach+0x20/0x28)
 r7:00000000 r6:c06ce978 r5:ce61c100 r4:c06b7b94
[<c02969a0>] (driver_attach) from [<c02965ec>] (bus_add_driver+0xf8/0x1fc)
[<c02964f4>] (bus_add_driver) from [<c0297914>] (driver_register+0xa4/0xe8)
 r7:c06e9040 r6:c068d0e8 r5:c068d0e8 r4:c06b7b94
[<c0297870>] (driver_register) from [<c029861c>] (__platform_driver_register+0x50/0x64)
 r5:c068d0e8 r4:ce621f80
[<c02985cc>] (__platform_driver_register) from [<c0646240>] (omap_system_dma_init+0x18/0x20)
[<c0646228>] (omap_system_dma_init) from [<c0008c44>] (do_one_initcall+0x114/0x1e0)
[<c0008b30>] (do_one_initcall) from [<c0632e3c>] (kernel_init_freeable+0x110/0x1dc)
 r10:c066d8b0 r9:00000000 r8:0000007d r7:c06e9040 r6:c067ddf0 r5:c066d898
 r4:00000003
[<c0632d2c>] (kernel_init_freeable) from [<c0460840>] (kernel_init+0x10/0xec)
 r10:00000000 r8:00000000 r7:00000000 r6:00000000 r5:c0460830 r4:00000000
[<c0460830>] (kernel_init) from [<c000f0d0>] (ret_from_fork+0x14/0x24)
 r4:00000000 r3:00000000
---[ end trace bcb85e0273c31888 ]---
OMAP DMA hardware revision 0.0

This does not occur when booting the plain "omap4" kernel.

I thought it may be related to another error which people have been
reporting, but as it's still there, I thought I should report it.

To me, this suggests that Versatile Express code may be initialising
on non-Versatile Express hardware, possibly touching hardware, but
it looks like it's happening within the setup_irq() called from the
legacy OMAP DMA code, though it's possible that could be because
Versatile Express code could be hitting some register which causes
OMAP4 to later to wrong.

I think it's going to be particularly horrid to debug...

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.

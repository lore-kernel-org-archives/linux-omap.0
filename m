From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: Re: Git tree updated, clocks and PM code reset to mainline
Date: Fri, 3 Apr 2009 09:15:53 +0300
Message-ID: <20090403091553.82ceacf8.jarkko.nikula@nokia.com>
References: <20090403001333.GR32530@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:42829 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753366AbZDCGPj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Apr 2009 02:15:39 -0400
In-Reply-To: <20090403001333.GR32530@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Fri, 3 Apr 2009 02:13:33 +0200
ext Tony Lindgren <tony@atomide.com> wrote:

> This means that the PM and some clock features will be broken until
> we can merge in Paul's clock branch and Kevin's pm branch.
> 
> Please everybody take a look at the big commit that resets the code,
> it's commit eba05254cb561dc27d5664503f91f7c21954e648. I've made sure
> things build for all omap configs, and booted several boards. But I
> may have accidentally left out something critical too..
> 
Just a test report. N810 is not booting anymore due an oops and Beagle
hangs when calibrating the delay loop.

Both using their defconfigs + CONFIG_DEBUG_LL=y. N810 boot log below.


Jarkko

<1>Unable to handle kernel NULL pointer dereference at virtual address 00000000
<1>pgd = c0004000
<1>[00000000] *pgd=00000000
Internal error: Oops: 5 [#1]
Modules linked in:
CPU: 0    Not tainted  (2.6.29-omap1 #37)
PC is at propagate_rate+0x10/0x60
LR is at omap2_clk_init+0x30/0x218
pc : [<c0037378>]    lr : [<c000e4c8>]    psr: 400001d3
sp : c0335f90  ip : 00000003  fp : 00000000
r10: 80023f4c  r9 : 4107b362  r8 : 80023fe8
r7 : c0338f94  r6 : c0025eec  r5 : c0025ef0  r4 : ffffffe0
r3 : 0124f800  r2 : 00000000  r1 : 00000040  r0 : c033900c
Flags: nZcv  IRQs off  FIQs off  Mode SVC_32  ISA ARM  Segment kernel
Control: 00c5387f  Table: 80004000  DAC: 00000017
Process swapper (pid: 0, stack limit = 0xc0334260)
Stack: (0xc0335f90 to 0xc0336000)
5f80:                                     c047806a c0338ff4 c0025ef0 c000e4c8 
5fa0: c0337c60 80023fe8 00000000 c0025ef0 c0025eec c0337c60 80023fe8 c000dd48 
5fc0: c035c390 c000e6cc fffffed4 c000b5b4 00000000 c0008938 c0008450 00000000 
5fe0: 00000000 c0025ef0 00000000 00c5387d c035c420 80008034 00000000 00000000 
[<c0037378>] (propagate_rate+0x10/0x60) from [<c000e4c8>] (omap2_clk_init+0x30/0x218)
[<c000e4c8>] (omap2_clk_init+0x30/0x218) from [<c000dd48>] (omap2_init_common_hw+0x20/0x3c)
[<c000dd48>] (omap2_init_common_hw+0x20/0x3c) from [<c000e6cc>] (nokia_n800_init_irq+0x10/0x60)
[<c000e6cc>] (nokia_n800_init_irq+0x10/0x60) from [<c000b5b4>] (init_IRQ+0x34/0x44)
[<c000b5b4>] (init_IRQ+0x34/0x44) from [<c0008938>] (start_kernel+0x138/0x2bc)
[<c0008938>] (start_kernel+0x138/0x2bc) from [<80008034>] (0x80008034)
Code: e92d4030 e5b02018 e2424020 e24dd004 (e5943020) 
<4>---[ end trace 1b75b31a2719ed1c ]---
<0>Kernel panic - not syncing: Attempted to kill the idle task!
[<c002e6bc>] (unwind_backtrace+0x0/0xd4) from [<c004ef00>] (panic+0x38/0x11c)
[<c004ef00>] (panic+0x38/0x11c) from [<c00513f4>] (do_exit+0x204/0x65c)
[<c00513f4>] (do_exit+0x204/0x65c) from [<c002cc64>] (die+0x120/0x140)
[<c002cc64>] (die+0x120/0x140) from [<c002f5b4>] (__do_kernel_fault+0x68/0x80)
[<c002f5b4>] (__do_kernel_fault+0x68/0x80) from [<c002f8d4>] (do_page_fault+0x1f4/0x214)
[<c002f8d4>] (do_page_fault+0x1f4/0x214) from [<c00281f0>] (do_DataAbort+0x34/0x9c)
[<c00281f0>] (do_DataAbort+0x34/0x9c) from [<c002898c>] (__dabt_svc+0x4c/0x60)
Exception stack(0xc0335f48 to 0xc0335f90)
5f40:                   c033900c 00000040 00000000 0124f800 ffffffe0 c0025ef0 
5f60: c0025eec c0338f94 80023fe8 4107b362 80023f4c 00000000 00000003 c0335f90 
5f80: c000e4c8 c0037378 400001d3 ffffffff
[<c002898c>] (__dabt_svc+0x4c/0x60) from [<c000e4c8>] (omap2_clk_init+0x30/0x218)
[<c000e4c8>] (omap2_clk_init+0x30/0x218) from [<c0025ef0>] (command_line+0x0/0x400)
[<c0025ef0>] (command_line+0x0/0x400) from [<c0337c60>] (0xc0337c60)

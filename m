From: "Steve Sakoman" <sakoman@gmail.com>
Subject: Re: [patch 2.6.27-rc8-omap 0/7] resend of pending TWL patches
Date: Sat, 11 Oct 2008 21:33:54 -0700
Message-ID: <5e088bd90810112133ob4f0fa6v5bfe37aece35c98a@mail.gmail.com>
References: <200810030857.37888.david-b@pacbell.net>
	 <57969b5c0810031036q55075fdbw259159757f25c863@mail.gmail.com>
	 <57969b5c0810031038w34f02dafxbc664f58cf5965ba@mail.gmail.com>
	 <200810061626.33616.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.169]:34534 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750705AbYJLEdy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 12 Oct 2008 00:33:54 -0400
Received: by wf-out-1314.google.com with SMTP id 27so1220278wfd.4
        for <linux-omap@vger.kernel.org>; Sat, 11 Oct 2008 21:33:54 -0700 (PDT)
In-Reply-To: <200810061626.33616.david-b@pacbell.net>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Anand Gadiyar <gadiyar@gmail.com>, linux-omap@vger.kernel.org

On Mon, Oct 6, 2008 at 4:26 PM, David Brownell <david-b@pacbell.net> wrote:
>> >> Where I observed a new oddity:  the boot hung right after
>> >> listing the MTD partitions.  Which is where the EHCI code
>> >> would come up ... took that driver out of the build, and
>> >> the hang went away.  Clue, oh clue; where art thou?
>> >>
>> >
>> > Well... Any chance this bit of code here helps? This infinite loop
>> > shouldn't even have been here. Oh well.
>
> Didn't help.  :(
>
> This code has so many infinite loops for hardware handshaking
> (none with timeouts!) that it's hard to say which one might
> be causing this ... if indeed one of them is indeed the cause.

I put timeouts in all of the infinite loops to see which one was the culprit.

Turns out it is this one in omap_start_ehc:

	/* Wait for TLL to be Active */
	while ((cm_read_mod_reg(CORE_MOD, OMAP2430_CM_IDLEST3) &
		(1 << OMAP3430ES2_ST_USBTLL_SHIFT)));

If I allow it fall out of the loop after 100000 tries, I get:

Unhandled fault: external abort on non-linefetch (0x1028) at 0xd8062014
Internal error: : 1028 [#1]
Modules linked in:
CPU: 0    Not tainted  (2.6.27-omap1 #1)
PC is at ehci_hcd_omap_drv_probe+0x2c4/0x538
LR is at release_console_sem+0x188/0x19c
pc : [<c02dae78>]    lr : [<c010f060>]    psr: 80000013
sp : c781fe20  ip : c781fd50  fp : c781fe44
r10: c04f8c90  r9 : 00000000  r8 : c797ae20
r7 : 00000011  r6 : c797ac00  r5 : c04f8d24  r4 : 000186a1
r3 : d8062000  r2 : 00000002  r1 : 00000001  r0 : 0000000f
Flags: Nzcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
Control: 00c5387f  Table: 80004018  DAC: 00000017
Process swapper (pid: 1, stack limit = 0xc781e2e8)
Stack: (0xc781fe20 to 0xc7820000)
fe20: c04f8c98 c04f8d44 c050e710 c050e710 c050af80 c001e534 c781fe54 c781fe48
fe40: c0277298 c02dabc0 c781fe74 c781fe58 c0276530 c0277284 c04f8c98 c04f8d44
fe60: c050e710 c050e710 c781fe94 c781fe78 c0276628 c027646c 00000000 c781fe9c
fe80: c02765dc c050e710 c781fec4 c781fe98 c0275ba8 c02765e8 c051baa0 c7803c58
fea0: c7803c58 c04f8ce0 00000000 c050e710 c051baa0 c7b88a20 c781fed4 c781fec8
fec0: c0276378 c0275b68 c781ff04 c781fed8 c0276034 c0276364 c048fbbd c050e710
fee0: c051baa0 c05419c4 c050e710 c051baa0 00000000 00000000 c781ff2c c781ff08
ff00: c027681c c0275f98 c05419c4 c0026cf8 c051baa0 00000000 00000000 c001e534
ff20: c781ff3c c781ff30 c0277630 c0276790 c781ff5c c781ff40 c001e590 c02775c4
ff40: 000000a0 00000060 c0026fcc c0026cf8 c781ffdc c781ff60 c00ee298 c001e540
ff60: 0000015f c0533398 c781ff94 c781ff78 c0195800 c0195670 c781ff94 c7840260
ff80: c01959f8 c781ff9e c781ffc4 c781ff98 c0136844 c0195888 c781ffb4 35332618
ffa0: 00000031 00000000 00000192 c0026cf8 00000000 c0026fcc c0026cf8 00000000
ffc0: 00000000 00000000 00000000 00000000 c781fff4 c781ffe0 c0008734 c00ee254
ffe0: 00000000 00000000 00000000 c781fff8 c0111220 c00086d0 0084f950 492af4c0
Backtrace:
[<c02dabb4>] (ehci_hcd_omap_drv_probe+0x0/0x538) from [<c0277298>]
(platform_drv_probe+0x20/0x24)
[<c0277278>] (platform_drv_probe+0x0/0x24) from [<c0276530>]
(driver_probe_device+0xd0/0x17c)
[<c0276460>] (driver_probe_device+0x0/0x17c) from [<c0276628>]
(__driver_attach+0x4c/0x70)
 r7:c050e710 r6:c050e710 r5:c04f8d44 r4:c04f8c98
[<c02765dc>] (__driver_attach+0x0/0x70) from [<c0275ba8>]
(bus_for_each_dev+0x4c/0x84)
 r7:c050e710 r6:c02765dc r5:c781fe9c r4:00000000
[<c0275b5c>] (bus_for_each_dev+0x0/0x84) from [<c0276378>]
(driver_attach+0x20/0x28)
 r7:c7b88a20 r6:c051baa0 r5:c050e710 r4:00000000
[<c0276358>] (driver_attach+0x0/0x28) from [<c0276034>]
(bus_add_driver+0xa8/0x214)
[<c0275f8c>] (bus_add_driver+0x0/0x214) from [<c027681c>]
(driver_register+0x98/0x120)
 r8:00000000 r7:00000000 r6:c051baa0 r5:c050e710 r4:c05419c4
[<c0276784>] (driver_register+0x0/0x120) from [<c0277630>]
(platform_driver_register+0x78/0x94)
[<c02775b8>] (platform_driver_register+0x0/0x94) from [<c001e590>]
(ehci_hcd_init+0x5c/0x94)
[<c001e534>] (ehci_hcd_init+0x0/0x94) from [<c00ee298>]
(__exception_text_end+0x50/0x168)
 r5:c0026cf8 r4:c0026fcc
[<c00ee248>] (__exception_text_end+0x0/0x168) from [<c0008734>]
(kernel_init+0x70/0xdc)
[<c00086c4>] (kernel_init+0x0/0xdc) from [<c0111220>] (do_exit+0x0/0x6c0)
 r5:00000000 r4:00000000
Code: e30033e9 e1510003 0a000005 e59f3248 (e5933014)
---[ end trace 596e1d827138a4cc ]---
Kernel panic - not syncing: Attempted to kill init!

I'll keep digging, but I know next to nothing about the USB stack.
Perhaps this info will trigger an "ah ha" for someone with more
knowledge.

Steve

From: Felipe Balbi <balbi@ti.com>
Subject: NULL deref on sched_clock_poll()
Date: Tue, 18 Jan 2011 07:12:27 +0200
Message-ID: <20110118051227.GE2436@legolas.emea.dhcp.ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:44001 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751652Ab1ARFMd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 18 Jan 2011 00:12:33 -0500
Received: by mail-gw0-f44.google.com with SMTP id 17so2486521gwj.17
        for <linux-omap@vger.kernel.org>; Mon, 17 Jan 2011 21:12:33 -0800 (PST)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux OMAP Mailing List <linux-omap@vger.kernel.org>

Hi all,

with today's mainline plus Russell's v6k patchset, I can't get
pandaboard to boot with omap2plus_defconfig.

The problem is that noone seems to be setting sched_clock_update_fn(),
so we we call sched_clock_poll() we have a NULL pointer deref.

I have 32k counter enabled but after adding a printk() to
omap_init_clocksource_32k() I don't see that getting called at all :-(

Am I missing any patch on top of Linus' tree ?

Below is boot log.

[    0.000000] Unable to handle kernel NULL pointer dereference at virtual address 00000000
[    0.000000] pgd = c0004000
[    0.000000] [00000000] *pgd=00000000
[    0.000000] Internal error: Oops: 80000005 [#1] SMP
[    0.000000] last sysfs file: 
[    0.000000] Modules linked in:
[    0.000000] CPU: 0    Tainted: G        W    (2.6.37-08042-g51de493-dirty #10)
[    0.000000] PC is at 0x0
[    0.000000] LR is at sched_clock_poll+0x3c/0x64
[    0.000000] pc : [<00000000>]    lr : [<c005f360>]    psr: 600001d3
[    0.000000] sp : c05abfd0  ip : 00000000  fp : 00000000
[    0.000000] r10: 00000000  r9 : 411fc092  r8 : 80032754
[    0.000000] r7 : c05c0900  r6 : c00345f8  r5 : c05bc050  r4 : c0412170
[    0.000000] r3 : 00000000  r2 : c05abfc4  r1 : c0502f5e  r0 : 00000047
[    0.000000] Flags: nZCv  IRQs off  FIQs off  Mode SVC_32  ISA ARM  Segment kernel
[    0.000000] Control: 10c5387f  Table: 8000404a  DAC: 00000017
[    0.000000] Process swapper (pid: 0, stack limit = 0xc05aa2f8)
[    0.000000] Stack: (0xc05abfd0 to 0xc05ac000)
[    0.000000] bfc0:                                     10c5387d c0008c00 c0008834 00000000
[    0.000000] bfe0: 00000000 c00345fc 00000000 10c5387d c05bc050 80008038 00000000 00000000
[    0.000000] [<c005f360>] (sched_clock_poll+0x3c/0x64) from [<c0008c00>] (start_kernel+0xf4/0x244)
[    0.000000] [<c0008c00>] (start_kernel+0xf4/0x244) from [<80008038>] (0x80008038)
[    0.000000] Code: bad PC value
[    0.000000] ==> sched_clock_poll: using sched_clock_update_fn
[    0.000000] Unable to handle kernel NULL pointer dereference at virtual address 00000000
[    0.000000] pgd = c0004000
[    0.000000] [00000000] *pgd=00000000
[    0.000000] Internal error: Oops: 80000005 [#2] SMP
[    0.000000] last sysfs file: 
[    0.000000] Modules linked in:
[    0.000000] CPU: 0    Tainted: G      D W    (2.6.37-08042-g51de493-dirty #10)
[    0.000000] PC is at 0x0
[    0.000000] LR is at sched_clock_poll+0x3c/0x64
[    0.000000] pc : [<00000000>]    lr : [<c005f360>]    psr: 60000153
[    0.000000] sp : c05abd38  ip : 00000000  fp : 00000000
[    0.000000] r10: 00000001  r9 : 80000005  r8 : c005f324
[    0.000000] r7 : 00000000  r6 : c005f324  r5 : c05c0be0  r4 : c0412170
[    0.000000] r3 : 00000000  r2 : c05abd2c  r1 : c0502f5e  r0 : 00000047
[    0.000000] Flags: nZCv  IRQs on  FIQs off  Mode SVC_32  ISA ARM  Segment kernel
[    0.000000] Control: 10c5387f  Table: 8000404a  DAC: 00000017
[    0.000000] Process swapper (pid: 0, stack limit = 0xc05aa2f8)
[    0.000000] Stack: (0xc05abd38 to 0xc05ac000)
[    0.000000] bd20:                                                       00000100 c00a2238
[    0.000000] bd40: 00000002 00000000 c00a2194 00000001 c0503058 00000000 00000000 c0503058
[    0.000000] bd60: c05c0be0 c0632840 c05c0be0 00000045 00000000 c005f324 00000001 c00a24a8
[    0.000000] bd80: c05abd80 c05abd80 00000000 00000101 c05ac044 00000045 00000100 0000000a
[    0.000000] bda0: 00000001 c009bca0 c05aeca4 c05aecb4 00000000 c05aa000 00000000 00000045
[    0.000000] bdc0: 80000005 00000000 80000005 c05bf0b8 00000000 c009c224 00000045 c005008c
[    0.000000] bde0: c05bf0b8 ffffffff fa240100 c040bd1c c040b87c c05c0b18 c05abe28 00000000
[    0.000000] be00: c05c0b08 c05abf88 00000000 80000005 00000000 80000005 c05bf0b8 00000000
[    0.000000] be20: 00000000 c05abe38 c040b87c c040b880 60000153 ffffffff c05aa000 c005e768
[    0.000000] be40: c05abe3c 00000000 80000005 00000000 c05abf88 c0063d9c c05abf88 00000000
[    0.000000] be60: 00000001 00000000 80032754 c040dfd4 c05abe94 00000000 c05abea4 c005e06c
[    0.000000] be80: c06e299c c030f650 c05bf0b8 c005e0d8 00000000 00000000 c05bf0b8 00000000
[    0.000000] bea0: 00000000 c05bf530 c05bf0b8 00000025 c0a1ae30 c0a1bc54 00000001 00000000
[    0.000000] bec0: 00000000 c00c55b4 00000005 c05c0da0 00000000 c05abf88 80032754 200001d3
[    0.000000] bee0: 00000000 c005031c 0000111a 00000000 c05aa000 c05f5d18 600001d3 c040b3b4
[    0.000000] bf00: c05bf0b8 200001d3 c05f5d48 0000111a c05bf0b8 200001d3 c05f5d48 c040b8a8
[    0.000000] bf20: 200001d3 ffffeee6 200001d3 c0096264 00000047 c05abf65 c0622253 c05f5ca0
[    0.000000] bf40: 00000000 c0096608 00000001 600001d3 c0632850 205bf0b8 30202020 3030302e
[    0.000000] bf60: 5d303030 c00a0020 a00001d3 c00a2e44 c0632850 c05bbff0 c05abfbc c00345f8
[    0.000000] bf80: c05c0900 c040be78 00000047 c0502f5e c05abfc4 00000000 c0412170 c05bc050
[    0.000000] bfa0: c00345f8 c05c0900 80032754 411fc092 00000000 00000000 00000000 c05abfd0
[    0.000000] bfc0: c005f360 00000000 600001d3 ffffffff 10c5387d c0008c00 c0008834 00000000
[    0.000000] bfe0: 00000000 c00345fc 00000000 10c5387d c05bc050 80008038 00000000 00000000
[    0.000000] [<c005f360>] (sched_clock_poll+0x3c/0x64) from [<c00a2238>] (call_timer_fn+0xa4/0x178)
[    0.000000] [<c00a2238>] (call_timer_fn+0xa4/0x178) from [<c00a24a8>] (run_timer_softirq+0x19c/0x1f
4)
[    0.000000] [<c00a24a8>] (run_timer_softirq+0x19c/0x1f4) from [<c009bca0>] (__do_softirq+0xfc/0x208
)
[    0.000000] [<c009bca0>] (__do_softirq+0xfc/0x208) from [<c009c224>] (irq_exit+0x54/0x98)
[    0.000000] [<c009c224>] (irq_exit+0x54/0x98) from [<c005008c>] (asm_do_IRQ+0x8c/0xc8)
[    0.000000] [<c005008c>] (asm_do_IRQ+0x8c/0xc8) from [<c040bd1c>] (__irq_svc+0x3c/0xe0)
[    0.000000] Exception stack(0xc05abdf0 to 0xc05abe38)
[    0.000000] bde0:                                     c040b87c c05c0b18 c05abe28 00000000
[    0.000000] be00: c05c0b08 c05abf88 00000000 80000005 00000000 80000005 c05bf0b8 00000000
[    0.000000] be20: 00000000 c05abe38 c040b87c c040b880 60000153 ffffffff
[    0.000000] [<c040bd1c>] (__irq_svc+0x3c/0xe0) from [<c040b880>] (_raw_spin_unlock_irq+0x28/0x2c)
[    0.000000] [<c040b880>] (_raw_spin_unlock_irq+0x28/0x2c) from [<c005e768>] (die+0x94/0x100)
[    0.000000] [<c005e768>] (die+0x94/0x100) from [<c0063d9c>] (__do_kernel_fault+0x64/0x84)
[    0.000000] [<c0063d9c>] (__do_kernel_fault+0x64/0x84) from [<c040dfd4>] (do_page_fault+0x21c/0x24c
)
[    0.000000] [<c040dfd4>] (do_page_fault+0x21c/0x24c) from [<c005031c>] (do_PrefetchAbort+0x34/0x98)
[    0.000000] [<c005031c>] (do_PrefetchAbort+0x34/0x98) from [<c040be78>] (__pabt_svc+0x58/0xa0)
[    0.000000] Exception stack(0xc05abf88 to 0xc05abfd0)
[    0.000000] bf80:                   00000047 c0502f5e c05abfc4 00000000 c0412170 c05bc050
[    0.000000] bfa0: c00345f8 c05c0900 80032754 411fc092 00000000 00000000 00000000 c05abfd0
[    0.000000] bfc0: c005f360 00000000 600001d3 ffffffff
[    0.000000] [<c040be78>] (__pabt_svc+0x58/0xa0) from [<c005f360>] (sched_clock_poll+0x3c/0x64)
[    0.000000] [<c005f360>] (sched_clock_poll+0x3c/0x64) from [<c0008c00>] (start_kernel+0xf4/0x244)
[    0.000000] [<c0008c00>] (start_kernel+0xf4/0x244) from [<80008038>] (0x80008038)
[    0.000000] Code: bad PC value
[    0.000000] ---[ end trace 1b75b31a2719ed1d ]---

-- 
balbi

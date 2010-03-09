From: Sergey Lapin <slapinid@gmail.com>
Subject: MUSB crash on OMAP3 board with second load of gadget
Date: Tue, 9 Mar 2010 21:30:18 +0300
Message-ID: <48239d391003091030h54f608c2jfb3637eaf48bf4a6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f46.google.com ([74.125.82.46]:35137 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752341Ab0CISaU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Mar 2010 13:30:20 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <felipe.balbi@nokia.com>
Cc: linux-omap@vger.kernel.org, linux-usb@vger.kernel.org

Dear Felipe,

Bug I've reported earlier is still reproducible. Steps are within
earlier mail (one way is to insert USB cable,
use g_file/mass_storage, allow device to mount, rmmod it, load g_ether
get crash).

gnome5:~# insmod ./g_ether.ko
[ 1085.923736] g_ether gadget: using random self ethernet address
[ 1085.934234] g_ether gadget: using random host ethernet address
[ 1085.949768] usb0: MAC 1a:b9:8c:c5:b3:be
[ 1085.960449] usb0: HOST MAC a2:65:53:2b:4f:a4
[ 1085.967315] g_ether gadget: Ethernet Gadget, version: Memorial Day 2008
[ 1085.978851] g_ether gadget: g_ether ready
gnome5:~# [ 1097.059326] kernel BUG at arch/arm/mm/dma-mapping.c:426!
[ 1097.064697] Unable to handle kernel NULL pointer dereference at
virtual address 00000000
[ 1097.072845] pgd = c0004000
[ 1097.075561] [00000000] *pgd=00000000
[ 1097.079162] Internal error: Oops: 817 [#1] PREEMPT
[ 1097.083984] last sysfs file:
/sys/devices/platform/i2c_omap.1/i2c-1/1-0048/twl4030_usb/vbus
[ 1097.092376] Modules linked in: g_ether [last unloaded: g_mass_storage]
[ 1097.098968] CPU: 0    Not tainted  (2.6.33-11957-gdb0da96-dirty #5)
[ 1097.105285] PC is at __bug+0x18/0x24
[ 1097.108886] LR is at __bug+0x14/0x24
[ 1097.112487] pc : [<c003d88c>]    lr : [<c003d888>]    psr: 400001d3
[ 1097.112518] sp : c03d5e50  ip : 0002822b  fp : c7862048
[ 1097.124053] r10: fa0ab000  r9 : fa0ab100  r8 : fa0ab100
[ 1097.129302] r7 : 00000001  r6 : c7862064  r5 : 00000000  r4 : c8998000
[ 1097.135864] r3 : 00000000  r2 : c03d5e44  r1 : c0367391  r0 : 00000042
[ 1097.142456] Flags: nZcv  IRQs off  FIQs off  Mode SVC_32  ISA ARM
Segment kernel
[ 1097.149963] Control: 10c5387d  Table: 86c68019  DAC: 00000017
[ 1097.155761] Process swapper (pid: 0, stack limit = 0xc03d42e8)
[ 1097.161621] Stack: (0xc03d5e50 to 0xc03d6000)
[ 1097.166015] 5e40:                                     c8998000
c00413b8 c6d8de00 c02083a8
[ 1097.174255] 5e60: c03d5e9e c020615c c7862048 00000008 c03d5e9e
00000000 00000008 c7862000
[ 1097.182464] 5e80: 00000001 c0206d1c c009550c c7800ec0 c7805bc0
c58301f8 60000153 0680550c
[ 1097.190704] 5ea0: 00000100 c03f0040 c03f01e4 00000000 000000f0
c7862000 00000008 00000099
[ 1097.198944] 5ec0: c03d4000 0000001f 00000000 c0205e94 c7862000
00000008 fa0ab000 00000000
[ 1097.207183] 5ee0: c7862000 40000153 00000000 0000005c 00000001
c0205fcc c7932580 00000000
[ 1097.215423] 5f00: 00000000 c0091a04 c7932580 c03e80e8 0000005c
00000002 00000001 c0093998
[ 1097.223632] 5f20: 0000005c 00000000 c040bb14 c0039070 ffffffff
fa200000 c040bb14 c0039ac8
[ 1097.231872] 5f40: 001faa3b 00000000 001faa3b 00000000 c040bb14
00000003 c040bb14 c040bb14
[ 1097.240112] 5f60: c042df10 411fc082 0000001f 00000000 00000000
c03d5f88 c004b038 c004b044
[ 1097.248352] 5f80: 60000053 ffffffff 00000000 001faa3b 388e67b8
2535913a 388e67b8 2515e6ff
[ 1097.256561] 5fa0: c03dae18 c03d4000 c040b09c c03dae18 c03dad48
c0217d60 c03d4000 c040b09c
[ 1097.264801] 5fc0: c0028014 c03d7c1c 80026080 c003b4dc c0413d78
c000893c c000848c 00000000
[ 1097.273040] 5fe0: 00000000 c0028018 00000000 10c53c7d c040b1b0
80008034 00000000 00000000
[ 1097.281280] [<c003d88c>] (__bug+0x18/0x24) from [<c00413b8>]
(___dma_single_dev_to_cpu+0x38/0x68)
[ 1097.290222] [<c00413b8>] (___dma_single_dev_to_cpu+0x38/0x68) from
[<c02083a8>] (musb_g_giveback+0x80/0x164)
[ 1097.300140] [<c02083a8>] (musb_g_giveback+0x80/0x164) from
[<c0206d1c>] (musb_g_ep0_irq+0x32c/0x910)
[ 1097.309326] [<c0206d1c>] (musb_g_ep0_irq+0x32c/0x910) from
[<c0205e94>] (musb_interrupt+0x2fc/0x3d4)
[ 1097.318542] [<c0205e94>] (musb_interrupt+0x2fc/0x3d4) from
[<c0205fcc>] (generic_interrupt+0x60/0x94)
[ 1097.327819] [<c0205fcc>] (generic_interrupt+0x60/0x94) from
[<c0091a04>] (handle_IRQ_event+0x34/0xf4)
[ 1097.337127] [<c0091a04>] (handle_IRQ_event+0x34/0xf4) from
[<c0093998>] (handle_level_irq+0xc0/0x150)
[ 1097.346405] [<c0093998>] (handle_level_irq+0xc0/0x150) from
[<c0039070>] (asm_do_IRQ+0x70/0x90)
[ 1097.355163] [<c0039070>] (asm_do_IRQ+0x70/0x90) from [<c0039ac8>]
(__irq_svc+0x48/0xa8)
[ 1097.363220] Exception stack(0xc03d5f40 to 0xc03d5f88)
[ 1097.368316] 5f40: 001faa3b 00000000 001faa3b 00000000 c040bb14
00000003 c040bb14 c040bb14
[ 1097.376556] 5f60: c042df10 411fc082 0000001f 00000000 00000000
c03d5f88 c004b038 c004b044
[ 1097.384765] 5f80: 60000053 ffffffff
[ 1097.388305] [<c0039ac8>] (__irq_svc+0x48/0xa8) from [<c004b044>]
(omap3_enter_idle+0x104/0x134)
[ 1097.397064] [<c004b044>] (omap3_enter_idle+0x104/0x134) from
[<c0217d60>] (cpuidle_idle_call+0xa4/0x104)
[ 1097.406616] [<c0217d60>] (cpuidle_idle_call+0xa4/0x104) from
[<c003b4dc>] (cpu_idle+0x48/0x98)
[ 1097.415283] [<c003b4dc>] (cpu_idle+0x48/0x98) from [<c000893c>]
(start_kernel+0x26c/0x2cc)
[ 1097.423614] [<c000893c>] (start_kernel+0x26c/0x2cc) from
[<80008034>] (0x80008034)
[ 1097.431243] Code: e92d4010 e59f000c eb0a6c93 e3a03000 (e5833000)
[ 1097.437469] ---[ end trace a64ad4cab94f5387 ]---
[ 1097.442138] Kernel panic - not syncing: Fatal exception in interrupt
[ 1097.448608] [<c003f92c>] (unwind_backtrace+0x0/0xdc) from
[<c02d8a00>] (panic+0x48/0x120)
[ 1097.456878] [<c02d8a00>] (panic+0x48/0x120) from [<c003ddb4>]
(die+0x2a8/0x2f8)
[ 1097.464294] [<c003ddb4>] (die+0x2a8/0x2f8) from [<c0041c60>]
(__do_kernel_fault+0x64/0x84)
[ 1097.472625] [<c0041c60>] (__do_kernel_fault+0x64/0x84) from
[<c0041eb0>] (do_page_fault+0x230/0x24c)
[ 1097.481872] [<c0041eb0>] (do_page_fault+0x230/0x24c) from
[<c00392a8>] (do_DataAbort+0x34/0x94)
[ 1097.490661] [<c00392a8>] (do_DataAbort+0x34/0x94) from [<c0039a6c>]
(__dabt_svc+0x4c/0x60)
[ 1097.498992] Exception stack(0xc03d5e08 to 0xc03d5e50)
[ 1097.504119] 5e00:                   00000042 c0367391 c03d5e44
00000000 c8998000 00000000
[ 1097.512390] 5e20: c7862064 00000001 fa0ab100 fa0ab100 fa0ab000
c7862048 0002822b c03d5e50
[ 1097.520629] 5e40: c003d888 c003d88c 400001d3 ffffffff
[ 1097.525726] [<c0039a6c>] (__dabt_svc+0x4c/0x60) from [<c003d88c>]
(__bug+0x18/0x24)
[ 1097.533477] [<c003d88c>] (__bug+0x18/0x24) from [<c00413b8>]
(___dma_single_dev_to_cpu+0x38/0x68)
[ 1097.542449] [<c00413b8>] (___dma_single_dev_to_cpu+0x38/0x68) from
[<c02083a8>] (musb_g_giveback+0x80/0x164)
[ 1097.552398] [<c02083a8>] (musb_g_giveback+0x80/0x164) from
[<c0206d1c>] (musb_g_ep0_irq+0x32c/0x910)
[ 1097.561614] [<c0206d1c>] (musb_g_ep0_irq+0x32c/0x910) from
[<c0205e94>] (musb_interrupt+0x2fc/0x3d4)
[ 1097.570861] [<c0205e94>] (musb_interrupt+0x2fc/0x3d4) from
[<c0205fcc>] (generic_interrupt+0x60/0x94)
[ 1097.580169] [<c0205fcc>] (generic_interrupt+0x60/0x94) from
[<c0091a04>] (handle_IRQ_event+0x34/0xf4)
[ 1097.589477] [<c0091a04>] (handle_IRQ_event+0x34/0xf4) from
[<c0093998>] (handle_level_irq+0xc0/0x150)
[ 1097.598785] [<c0093998>] (handle_level_irq+0xc0/0x150) from
[<c0039070>] (asm_do_IRQ+0x70/0x90)
[ 1097.607604] [<c0039070>] (asm_do_IRQ+0x70/0x90) from [<c0039ac8>]
(__irq_svc+0x48/0xa8)
[ 1097.615661] Exception stack(0xc03d5f40 to 0xc03d5f88)
[ 1097.620788] 5f40: 001faa3b 00000000 001faa3b 00000000 c040bb14
00000003 c040bb14 c040bb14
[ 1097.629058] 5f60: c042df10 411fc082 0000001f 00000000 00000000
c03d5f88 c004b038 c004b044
[ 1097.637298] 5f80: 60000053 ffffffff
[ 1097.640838] [<c0039ac8>] (__irq_svc+0x48/0xa8) from [<c004b044>]
(omap3_enter_idle+0x104/0x134)
[ 1097.649627] [<c004b044>] (omap3_enter_idle+0x104/0x134) from
[<c0217d60>] (cpuidle_idle_call+0xa4/0x104)
[ 1097.659210] [<c0217d60>] (cpuidle_idle_call+0xa4/0x104) from
[<c003b4dc>] (cpu_idle+0x48/0x98)
[ 1097.667907] [<c003b4dc>] (cpu_idle+0x48/0x98) from [<c000893c>]
(start_kernel+0x26c/0x2cc)
[ 1097.676269] [<c000893c>] (start_kernel+0x26c/0x2cc) from
[<80008034>] (0x80008034)

Any news regarding this?
Thanks a lot,
S.

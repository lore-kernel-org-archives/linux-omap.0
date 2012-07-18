From: Yegor Yefremov <yegor_sub1@visionsystems.de>
Subject: am3517: issue with omap3_l3_app_irq during heavy USB load
Date: Wed, 18 Jul 2012 09:27:40 +0200
Message-ID: <5006656C.9010602@visionsystems.de>
Reply-To: yegor_sub1@visionsystems.de
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns.vscom.de ([62.145.30.242]:51816 "EHLO mail.visionsystems.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752774Ab2GRH15 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 18 Jul 2012 03:27:57 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Porter, Matt" <mporter@ti.com>, "Mark A. Greer" <mgreer@animalcreek.com>, grinberg@compulab.co.il

My system: am3517 based board with SMSC9514 attached to EHCI port 0 (not OTG), the rest of the USB ports are marked as disabled - OMAP_USBHS_PORT_MODE_UNUSED.
Kernel: 3.3-rc7 from linux-omap (so far the latest kernel, where all hardware is supported)

When performing network test only (nuttcp over SMSC9514's network interface) the system work reliably. But as soon as I start other USB activities (talking to a 3G modem/FTDI serial interfaces) I get following error:

irq 10: nobody cared (try booting with the "irqpoll" option)
[<c0019d34>] (unwind_backtrace+0x0/0x138) from [<c007c1d4>] (__report_bad_irq+0x24/0xc4)
[<c007c1d4>] (__report_bad_irq+0x24/0xc4) from [<c007c4a8>] (note_interrupt+0x1d4/0x230)
[<c007c4a8>] (note_interrupt+0x1d4/0x230) from [<c007a99c>] (handle_irq_event_percpu+0xa8/0x1a0)
[<c007a99c>] (handle_irq_event_percpu+0xa8/0x1a0) from [<c007aad0>] (handle_irq_event+0x3c/0x5c)
[<c007aad0>] (handle_irq_event+0x3c/0x5c) from [<c007cb98>] (handle_level_irq+0x8c/0x114)
[<c007cb98>] (handle_level_irq+0x8c/0x114) from [<c007a2e0>] (generic_handle_irq+0x30/0x44)
[<c007a2e0>] (generic_handle_irq+0x30/0x44) from [<c0014e6c>] (handle_IRQ+0x30/0x84)
[<c0014e6c>] (handle_IRQ+0x30/0x84) from [<c0008708>] (omap3_intc_handle_irq+0x48/0x4c)
[<c0008708>] (omap3_intc_handle_irq+0x48/0x4c) from [<c0013b84>] (__irq_svc+0x44/0x60)
Exception stack(0xcf0e7f08 to 0xcf0e7f50)
7f00:                   00000001 00000000 00000000 cf0e5640 00000040 c0730a44
7f20: cf0e6000 0000004e c0730a44 c0730a00 c06cfac8 0000000a 00000000 cf0e7f50
7f40: c0071020 c003e96c 60000113 ffffffff
[<c0013b84>] (__irq_svc+0x44/0x60) from [<c003e96c>] (__do_softirq+0x68/0x13c)
[<c003e96c>] (__do_softirq+0x68/0x13c) from [<c003ee7c>] (irq_exit+0x8c/0x94)
[<c003ee7c>] (irq_exit+0x8c/0x94) from [<c0014e70>] (handle_IRQ+0x34/0x84)
[<c0014e70>] (handle_IRQ+0x34/0x84) from [<c0008708>] (omap3_intc_handle_irq+0x48/0x4c)
[<c0008708>] (omap3_intc_handle_irq+0x48/0x4c) from [<c0013d1c>] (__irq_usr+0x3c/0x60)
Exception stack(0xcf0e7fb0 to 0xcf0e7ff8)
7fa0:                                     00080188 00000001 40000000 00000000
7fc0: b6f85258 00080188 00080180 0000004e 00002008 00000058 00001ffc 0006bcef
7fe0: b6f8400c be9e8bf8 b6eeecb9 b6ef9fa0 20000030 ffffffff
handlers:
[<c002d2dc>] omap3_l3_app_irq
Disabling IRQ #10

and after some time this one:

Unable to handle kernel NULL pointer dereference at virtual address 00000034
pgd = c0004000
[00000034] *pgd=00000000
Internal error: Oops: 17 [#1]
CPU: 0    Not tainted  (3.3.0-rc7-dirty #127)
PC is at usb_hcd_unlink_urb+0x48/0xc0
LR is at mark_held_locks+0x68/0x13c
pc : [<c0305560>]    lr : [<c0070ea4>]    psr: 20070013
sp : cf189ec8  ip : cf188000  fp : cf189f40
r10: cfba0540  r9 : cf1f7cc0  r8 : c0718660
r7 : 00000000  r6 : a0070013  r5 : cf1f7cc0  r4 : ffffff98
r3 : 00000000  r2 : ffffff98  r1 : cf1f7cc0  r0 : 00000001
Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
Control: 10c5387d  Table: 8f178019  DAC: 00000015
Process kworker/0:1 (pid: 797, stack limit = 0xcf1882f0)
Stack: (0xcf189ec8 to 0xcf18a000)
9ec0:                   c0718660 c04f614c cfba066c cfba0678 cfba066c c02fa22c
9ee0: cfba0540 cfba075c c06cecf4 cf820e00 00000000 00000002 cf188000 c02fb350
9f00: 00000000 cf194bc0 c06cecf4 cfba075c cf194bc0 c06cecf4 cf820e00 c004cb4c
9f20: 00000002 00000000 c004cad0 00000080 00000000 00000000 c02fb24c cf820e05
9f40: c0c48510 c07fc330 00000000 c060ef6c cf194bd0 cf194bc0 c06cecf4 c06ced14
9f60: cf194bd0 c0731c78 c06cecf0 cf188000 00000009 c004e02c 00000000 cf188038
9f80: 60000013 cf1c9ed0 cf189fb4 cf194bc0 c004ded0 00000000 00000000 00000000
9fa0: 00000000 c0052ae4 00000000 00000000 cf194bc0 00000000 00000001 dead4ead
9fc0: ffffffff ffffffff c0732220 00000000 00000000 c05d0af0 cf189fd8 cf189fd8
9fe0: cf1c9ed0 cf1c9ed0 c0052a58 c0014f50 00000013 c0014f50 00000000 00000000
[<c0305560>] (usb_hcd_unlink_urb+0x48/0xc0) from [<c02fa22c>] (unlink_urbs+0x4c/0xb4)
[<c02fa22c>] (unlink_urbs+0x4c/0xb4) from [<c02fb350>] (kevent+0x104/0x354)
[<c02fb350>] (kevent+0x104/0x354) from [<c004cb4c>] (process_one_work+0x190/0x448)
[<c004cb4c>] (process_one_work+0x190/0x448) from [<c004e02c>] (worker_thread+0x15c/0x350)
[<c004e02c>] (worker_thread+0x15c/0x350) from [<c0052ae4>] (kthread+0x8c/0x98)
[<c0052ae4>] (kthread+0x8c/0x98) from [<c0014f50>] (kernel_thread_exit+0x0/0x8)
Code: eb07c2f1 e5953028 e1a02004 e1a01005 (e5930034)
---[ end trace e4b7da5b6a7deeaf ]---
Unable to handle kernel paging request at virtual address fffffffc
pgd = c0004000
[fffffffc] *pgd=8fefe821, *pte=00000000, *ppte=00000000
Internal error: Oops: 17 [#2]
CPU: 0    Tainted: G      D       (3.3.0-rc7-dirty #127)
PC is at kthread_data+0x4/0xc
LR is at wq_worker_sleeping+0xc/0x98
pc : [<c0052b78>]    lr : [<c004e278>]    psr: 20070193
sp : cf189c28  ip : c06cf5e0  fp : cf189cc4
r10: c04fb1bc  r9 : cf1cc298  r8 : cf1cc314
r7 : cf188000  r6 : cf1cc0b8  r5 : c06cf5e0  r4 : 00000000
r3 : 00000000  r2 : c06cf5e0  r1 : 00000000  r0 : cf1cc0c0
Flags: nzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment user
Control: 10c5387d  Table: 8f178019  DAC: 00000015
Process kworker/0:1 (pid: 797, stack limit = 0xcf1882f0)
Stack: (0xcf189c28 to 0xcf18a000)
9c20:                   cf1cc0c0 c04f52e0 00000001 c003b324 cf1cc0c0 cf800cc0
9c40: cf1cc314 00000000 c06aa000 c003cd40 00000001 c003b324 cf1cc0c0 c04f6614
9c60: cf1cc0c0 c003b594 00000001 00000000 c003b324 c00721a8 00000002 00200200
9c80: 00000000 c003cc28 00000000 cf1cc9b4 cfba0540 00000000 c003cc28 cf1cc0b8
9ca0: cf1cca0c cf1cc0c0 00000001 cf1cc0b8 cf82b340 cf189ce4 cf1cc298 cf1cc298
9cc0: cf1cc298 c003cd40 c06cd598 cf189cdc cf188000 00000001 c003ad88 cf189cdc
9ce0: cf189cdc cf1cc2e0 cfba0540 cf189e80 cf188000 00000000 cf1cc0c0 00000017
9d00: cf1cc0c0 cfba0540 00000028 c0017c60 cf1882f0 0000000b cf189e80 00000034
9d20: 00000000 00000017 00000000 c001c624 00000017 00000000 cf188000 cf189e80
9d40: 00000034 c001c828 c0c48510 00000001 cf1cc0c0 00000002 c0b4a5b4 c07d66a0
9d60: 00000002 00000000 c07fc330 c0070ea4 0000000a c00721a8 00000002 cf188000
9d80: c04f614c cf1cc0c0 00000001 cf17c3c0 c0730a00 c06cfac8 c0c48510 00000001
9da0: cf1cc0c0 00000002 c0b4a5b4 c07d66a0 00000002 00000003 c07fc330 00000017
9dc0: 00000034 cf189e80 00000007 c06aef58 cf1f7cc0 cfba0540 cf189f40 c000856c
9de0: c0730a00 c06cfac8 0000000a c0071020 60070113 c0730a60 cf188000 00000100
9e00: c0c48510 00000001 cf1cc0c0 00000006 c0b4a5b4 c07d66a0 00000006 00000003
9e20: c07fc330 c0070ea4 cf188000 c003e880 cf1cc0c0 cf188000 c0013b88 cf1cc0c0
9e40: 00000001 c0718660 cf1f7cc0 cfba0540 cf189f40 c0071064 c04f6150 20070013
9e60: ffffffff cf189ea4 c0305560 20070013 ffffffff cf189eb4 c0718660 c0013b1c
9e80: 00000001 cf1f7cc0 ffffff98 00000000 ffffff98 cf1f7cc0 a0070013 00000000
9ea0: c0718660 cf1f7cc0 cfba0540 cf189f40 cf188000 cf189ec8 c0070ea4 c0305560
9ec0: 20070013 ffffffff c0718660 c04f614c cfba066c cfba0678 cfba066c c02fa22c
9ee0: cfba0540 cfba075c c06cecf4 cf820e00 00000000 00000002 cf188000 c02fb350
9f00: 00000000 cf194bc0 c06cecf4 cfba075c cf194bc0 c06cecf4 cf820e00 c004cb4c
9f20: 00000002 00000000 c004cad0 00000080 00000000 00000000 c02fb24c cf820e05
9f40: c0c48510 c07fc330 00000000 c060ef6c cf194bd0 cf194bc0 c06cecf4 c06ced14
9f60: cf194bd0 c0731c78 c06cecf0 cf188000 00000009 c004e02c 00000000 cf188038
9f80: 60000013 cf1c9ed0 cf189fb4 cf194bc0 c004ded0 00000000 00000000 00000000
9fa0: 00000000 c0052ae4 00000000 00000000 cf194bc0 00000001 00000001 dead4ead
9fc0: ffffffff ffffffff c0732220 00000000 00000000 c05d0af0 cf189fd8 cf189fd8
9fe0: cf1c9ed0 cf1c9ed0 c0052a58 c0014f50 00000013 c0014f50 00000000 00000000
[<c0052b78>] (kthread_data+0x4/0xc) from [<c004e278>] (wq_worker_sleeping+0xc/0x98)
[<c004e278>] (wq_worker_sleeping+0xc/0x98) from [<c04f52e0>] (__schedule+0x3a4/0x5c0)
[<c04f52e0>] (__schedule+0x3a4/0x5c0) from [<c003cd40>] (do_exit+0x4bc/0x6c4)
[<c003cd40>] (do_exit+0x4bc/0x6c4) from [<c0017c60>] (die+0x1c4/0x200)
[<c0017c60>] (die+0x1c4/0x200) from [<c001c624>] (__do_kernel_fault+0x64/0x84)
[<c001c624>] (__do_kernel_fault+0x64/0x84) from [<c001c828>] (do_page_fault+0x1e4/0x370)
[<c001c828>] (do_page_fault+0x1e4/0x370) from [<c000856c>] (do_DataAbort+0x30/0x9c)
[<c000856c>] (do_DataAbort+0x30/0x9c) from [<c0013b1c>] (__dabt_svc+0x3c/0x60)
Exception stack(0xcf189e80 to 0xcf189ec8)
9e80: 00000001 cf1f7cc0 ffffff98 00000000 ffffff98 cf1f7cc0 a0070013 00000000
9ea0: c0718660 cf1f7cc0 cfba0540 cf189f40 cf188000 cf189ec8 c0070ea4 c0305560
9ec0: 20070013 ffffffff
[<c0013b1c>] (__dabt_svc+0x3c/0x60) from [<c0305560>] (usb_hcd_unlink_urb+0x48/0xc0)
[<c0305560>] (usb_hcd_unlink_urb+0x48/0xc0) from [<c02fa22c>] (unlink_urbs+0x4c/0xb4)
[<c02fa22c>] (unlink_urbs+0x4c/0xb4) from [<c02fb350>] (kevent+0x104/0x354)
[<c02fb350>] (kevent+0x104/0x354) from [<c004cb4c>] (process_one_work+0x190/0x448)
[<c004cb4c>] (process_one_work+0x190/0x448) from [<c004e02c>] (worker_thread+0x15c/0x350)
[<c004e02c>] (worker_thread+0x15c/0x350) from [<c0052ae4>] (kthread+0x8c/0x98)
[<c0052ae4>] (kthread+0x8c/0x98) from [<c0014f50>] (kernel_thread_exit+0x0/0x8)
Code: e1a03000 eafffff0 c07323b8 e5903228 (e5130004)
BUG: spinlock lockup on CPU#0, kworker/0:1/797
 lock: c06cf5e0, .magic: dead4ead, .owner: kworker/0:1/797, .owner_cpu: 0
[<c0019d34>] (unwind_backtrace+0x0/0x138) from [<c022fce8>] (do_raw_spin_lock+0xe8/0x148)
[<c022fce8>] (do_raw_spin_lock+0xe8/0x148) from [<c005c2b8>] (scheduler_tick+0x18/0xf0)
[<c005c2b8>] (scheduler_tick+0x18/0xf0) from [<c0044be4>] (update_process_times+0x58/0x64)
[<c0044be4>] (update_process_times+0x58/0x64) from [<c006afbc>] (tick_sched_timer+0x70/0xbc)
[<c006afbc>] (tick_sched_timer+0x70/0xbc) from [<c00569e0>] (__run_hrtimer.clone.28+0x58/0x138)
[<c00569e0>] (__run_hrtimer.clone.28+0x58/0x138) from [<c00575b4>] (hrtimer_interrupt+0xf0/0x2d0)
[<c00575b4>] (hrtimer_interrupt+0xf0/0x2d0) from [<c00222f0>] (omap2_gp_timer_interrupt+0x2c/0x34)
[<c00222f0>] (omap2_gp_timer_interrupt+0x2c/0x34) from [<c007a944>] (handle_irq_event_percpu+0x50/0x1a0)
[<c007a944>] (handle_irq_event_percpu+0x50/0x1a0) from [<c007aad0>] (handle_irq_event+0x3c/0x5c)
[<c007aad0>] (handle_irq_event+0x3c/0x5c) from [<c007cb98>] (handle_level_irq+0x8c/0x114)
[<c007cb98>] (handle_level_irq+0x8c/0x114) from [<c007a2e0>] (generic_handle_irq+0x30/0x44)
[<c007a2e0>] (generic_handle_irq+0x30/0x44) from [<c0014e6c>] (handle_IRQ+0x30/0x84)
[<c0014e6c>] (handle_IRQ+0x30/0x84) from [<c0008708>] (omap3_intc_handle_irq+0x48/0x4c)
[<c0008708>] (omap3_intc_handle_irq+0x48/0x4c) from [<c0013b84>] (__irq_svc+0x44/0x60)
Exception stack(0xcf189978 to 0xcf1899c0)
9960:                                                       c003e954 00000000
9980: 00000001 00000000 00000240 c0730a44 cf188000 cf189a54 c0730a44 c0730a00
99a0: c06cfac8 0000000a cf188000 cf1899c0 c003e954 c003e95c 60070113 ffffffff
[<c0013b84>] (__irq_svc+0x44/0x60) from [<c003e95c>] (__do_softirq+0x58/0x13c)
[<c003e95c>] (__do_softirq+0x58/0x13c) from [<c003ee7c>] (irq_exit+0x8c/0x94)
[<c003ee7c>] (irq_exit+0x8c/0x94) from [<c0014e70>] (handle_IRQ+0x34/0x84)
[<c0014e70>] (handle_IRQ+0x34/0x84) from [<c0008708>] (omap3_intc_handle_irq+0x48/0x4c)
[<c0008708>] (omap3_intc_handle_irq+0x48/0x4c) from [<c0013b84>] (__irq_svc+0x44/0x60)
Exception stack(0xcf189a20 to 0xcf189a68)
9a20: c04f6184 00000001 cf1cc0c0 00000000 c06aeab0 cf188000 00000000 cf1cc0c0
9a40: 00000017 cf1cc0c0 c04fb1bc 00000028 00000000 cf189a68 c04f6184 c04f6188
9a60: 60070113 ffffffff
[<c0013b84>] (__irq_svc+0x44/0x60) from [<c04f6188>] (_raw_spin_unlock_irq+0x28/0x2c)
[<c04f6188>] (_raw_spin_unlock_irq+0x28/0x2c) from [<c0017b78>] (die+0xdc/0x200)[<c0017b78>] (die+0xdc/0x200) from [<c001c624>] (__do_kernel_fault+0x64/0x84)
[<c001c624>] (__do_kernel_fault+0x64/0x84) from [<c001c828>] (do_page_fault+0x1e4/0x370)
[<c001c828>] (do_page_fault+0x1e4/0x370) from [<c000856c>] (do_DataAbort+0x30/0x9c)
[<c000856c>] (do_DataAbort+0x30/0x9c) from [<c0013b1c>] (__dabt_svc+0x3c/0x60)
Exception stack(0xcf189be0 to 0xcf189c28)
9be0: cf1cc0c0 00000000 c06cf5e0 00000000 00000000 c06cf5e0 cf1cc0b8 cf188000
9c00: cf1cc314 cf1cc298 c04fb1bc cf189cc4 c06cf5e0 cf189c28 c004e278 c0052b78
9c20: 20070193 ffffffff
[<c0013b1c>] (__dabt_svc+0x3c/0x60) from [<c0052b78>] (kthread_data+0x4/0xc)
[<c0052b78>] (kthread_data+0x4/0xc) from [<c004e278>] (wq_worker_sleeping+0xc/0x98)
[<c004e278>] (wq_worker_sleeping+0xc/0x98) from [<c04f52e0>] (__schedule+0x3a4/0x5c0)
[<c04f52e0>] (__schedule+0x3a4/0x5c0) from [<c003cd40>] (do_exit+0x4bc/0x6c4)
[<c003cd40>] (do_exit+0x4bc/0x6c4) from [<c0017c60>] (die+0x1c4/0x200)
[<c0017c60>] (die+0x1c4/0x200) from [<c001c624>] (__do_kernel_fault+0x64/0x84)
[<c001c624>] (__do_kernel_fault+0x64/0x84) from [<c001c828>] (do_page_fault+0x1e4/0x370)
[<c001c828>] (do_page_fault+0x1e4/0x370) from [<c000856c>] (do_DataAbort+0x30/0x9c)
[<c000856c>] (do_DataAbort+0x30/0x9c) from [<c0013b1c>] (__dabt_svc+0x3c/0x60)
Exception stack(0xcf189e80 to 0xcf189ec8)
9e80: 00000001 cf1f7cc0 ffffff98 00000000 ffffff98 cf1f7cc0 a0070013 00000000
9ea0: c0718660 cf1f7cc0 cfba0540 cf189f40 cf188000 cf189ec8 c0070ea4 c0305560
9ec0: 20070013 ffffffff
[<c0013b1c>] (__dabt_svc+0x3c/0x60) from [<c0305560>] (usb_hcd_unlink_urb+0x48/0xc0)
[<c0305560>] (usb_hcd_unlink_urb+0x48/0xc0) from [<c02fa22c>] (unlink_urbs+0x4c/0xb4)
[<c02fa22c>] (unlink_urbs+0x4c/0xb4) from [<c02fb350>] (kevent+0x104/0x354)
[<c02fb350>] (kevent+0x104/0x354) from [<c004cb4c>] (process_one_work+0x190/0x448)
[<c004cb4c>] (process_one_work+0x190/0x448) from [<c004e02c>] (worker_thread+0x15c/0x350)
[<c004e02c>] (worker_thread+0x15c/0x350) from [<c0052ae4>] (kthread+0x8c/0x98)
[<c0052ae4>] (kthread+0x8c/0x98) from [<c0014f50>] (kernel_thread_exit+0x0/0x8)

Any idea?

Regards,
Yegor

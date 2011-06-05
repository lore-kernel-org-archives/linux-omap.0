From: Ming Lei <tom.leiming@gmail.com>
Subject: OMPA4: 3.0-rc1: Unhandled fault during insmod 'ohci-hcd.ko'
Date: Sun, 5 Jun 2011 10:06:07 +0800
Message-ID: <BANLkTinYcxJqUM4G2ERew3okUTdf0LOLGA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:46324 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753879Ab1FECGI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 4 Jun 2011 22:06:08 -0400
Received: by gyd10 with SMTP id 10so1144301gyd.19
        for <linux-omap@vger.kernel.org>; Sat, 04 Jun 2011 19:06:07 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@ti.com>
Cc: linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

Hi guys,

Seems omap4 is broken in my panda board on 3.0-rc1 and 3.0-rc1-next,
see the log below:


[    3.538848] udevd (567): /proc/567/oom_adj is deprecated, please
use /proc/567/oom_score_adj instead.
[    6.730438] usbcore: registered new interface driver usbfs
[    6.784637] usbcore: registered new interface driver hub
[    6.848205] usbcore: registered new device driver usb
[    6.992767] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    7.067779] Unhandled fault: imprecise external abort (0x1406) at 0x400b3070
[    7.075225] Internal error: : 1406 [#1] PREEMPT SMP
[    7.080383] Modules linked in: ohci_hcd(+) usbcore twl6030_usb(+)
[    7.086883] CPU: 0    Not tainted  (3.0.0-rc1-next-20110531+ #10)
[    7.093353] PC is at usbhs_enable+0x124/0x3a0
[    7.097991] LR is at _raw_spin_unlock_irqrestore+0x58/0x78
[    7.103790] pc : [<c04e547c>]    lr : [<c06affa0>]    psr: 80000093
[    7.103790] sp : ef2c5de0  ip : ef2c5da8  fp : ef2c5e04
[    7.115875] r10: 8000001c  r9 : ef2c4000  r8 : 80000013
[    7.121368] r7 : efaedd64  r6 : c08810b8  r5 : efaee408  r4 : efaedd20
[    7.128265] r3 : 00000000  r2 : 8000001c  r1 : 0005714d  r0 : 00000000
[    7.135131] Flags: Nzcv  IRQs off  FIQs on  Mode SVC_32  ISA ARM
Segment user
[    7.142730] Control: 10c5387d  Table: af3d004a  DAC: 00000015
[    7.148773] Process modprobe (pid: 718, stack limit = 0xef2c42f8)
[    7.155212] Stack: (0xef2c5de0 to 0xef2c6000)
[    7.159790] 5de0: efb22000 efaee408 ef9e46e0 fc064800 0000006c
00000000 ef2c5e14 ef2c5e08
[    7.168426] 5e00: c04e5714 c04e5364 ef2c5e3c ef2c5e18 bf048ac8
c04e5704 bf0489c0 efaee408
[    7.177032] 5e20: bf0498d4 bf0498d4 00000000 c01c7208 ef2c5e4c
ef2c5e40 c04d8eac bf0489cc
[    7.185638] 5e40: ef2c5e74 ef2c5e50 c04d78e8 c04d8e94 efaeb5e0
c06afef4 efaee408 efaee408
[    7.190673] omap_i2c omap_i2c.1: rpm_resume flags 0x4
[    7.190704] omap_i2c omap_i2c.1: rpm_resume returns 1
[    7.204956] 5e60: bf0498d4 bf0498d4 ef2c5e94 ef2c5e78 c04d7c24
c04d7820 bf049748 c01c7208
[    7.213592] 5e80: efaee408 efaee43c ef2c5eb4 ef2c5e98 c04d7cc0
c04d7bb0 c04d7c48 bf0498d4
[    7.222229] 5ea0: c04d7c48 00000000 ef2c5edc ef2c5eb8 c04d69e8
c04d7c54 ef8b3664 efaedc7c
[    7.230834] 5ec0: c045f014 bf0498d4 efb045e0 c089d6e8 ef2c5eec
ef2c5ee0 c04d76d4 c04d6998
[    7.239471] 5ee0: ef2c5f14 ef2c5ef0 c04d7354 c04d76b8 bf049748
c045f38c bf0498d4 c08b3b80
[    7.248077] 5f00: bf049a64 00000000 ef2c5f2c ef2c5f18 c04d8378
c04d72a0 00000000 c08b3b80
[    7.256683] 5f20: ef2c5f3c ef2c5f30 c04d91e4 c04d82d4 ef2c5f5c
ef2c5f40 bf04c070 c04d919c
[    7.265289] 5f40: 00000000 bf049910 c08b3b80 bf04c000 ef2c5f7c
ef2c5f60 c01bc71c bf04c00c
[    7.273925] 5f60: bf049910 00016258 00000000 0004764c ef2c5fa4
ef2c5f80 c02487ac c01bc6e4
[    7.282531] 5f80: c0238c70 c0238a28 00009720 00000000 00000000
00000080 00000000 ef2c5fa8
[    7.291137] 5fa0: c01c6fa0 c024872c 00009720 00000000 401df000
0004764c 00016258 00016258
[    7.299774] 5fc0: 00009720 00000000 00000000 00000080 00000000
00016154 00016148 00000000
[    7.308380] 5fe0: 000162a0 beb5c9f4 0000b180 4017a264 60000010
401df000 00000000 00000000
[    7.316986] Backtrace:
[    7.319580] [<c04e5358>] (usbhs_enable+0x0/0x3a0) from [<c04e5714>]
(omap_usbhs_enable+0x1c/0x20)
[    7.328948] [<c04e56f8>] (omap_usbhs_enable+0x0/0x20) from
[<bf048ac8>] (ohci_hcd_omap3_probe+0x108/0x1b0 [ohci
_hcd])
[    7.340148] [<bf0489c0>] (ohci_hcd_omap3_probe+0x0/0x1b0
[ohci_hcd]) from [<c04d8eac>] (platform_drv_probe+0x24
/0x28)
[    7.351318]  r8:c01c7208 r7:00000000 r6:bf0498d4 r5:bf0498d4 r4:efaee408
[    7.358215] r3:bf0489c0
[    7.360992] [<c04d8e88>] (platform_drv_probe+0x0/0x28) from
[<c04d78e8>] (really_probe+0xd4/0x1b8)
[    7.370452] [<c04d7814>] (really_probe+0x0/0x1b8) from [<c04d7c24>]
(driver_probe_device+0x80/0xa4)
[    7.379974]  r6:bf0498d4 r5:bf0498d4 r4:efaee408
[    7.384857] [<c04d7ba4>] (driver_probe_device+0x0/0xa4) from
[<c04d7cc0>] (__driver_attach+0x78/0x9c)
[    7.394561]  r5:efaee43c r4:efaee408
[    7.398345] [<c04d7c48>] (__driver_attach+0x0/0x9c) from
[<c04d69e8>] (bus_for_each_dev+0x5c/0x8c)
[    7.407775]  r6:00000000 r5:c04d7c48 r4:bf0498d4 r3:c04d7c48
[    7.413757] [<c04d698c>] (bus_for_each_dev+0x0/0x8c) from
[<c04d76d4>] (driver_attach+0x28/0x30)
[    7.423004]  r6:c089d6e8 r5:efb045e0 r4:bf0498d4
[    7.427917] [<c04d76ac>] (driver_attach+0x0/0x30) from [<c04d7354>]
(bus_add_driver+0xc0/0x1c4)
[    7.437072] [<c04d7294>] (bus_add_driver+0x0/0x1c4) from
[<c04d8378>] (driver_register+0xb0/0xe4)
[    7.446411]  r7:00000000 r6:bf049a64 r5:c08b3b80 r4:bf0498d4
[    7.452392] [<c04d82c8>] (driver_register+0x0/0xe4) from
[<c04d91e4>] (platform_driver_register+0x54/0x68)
[    7.462554]  r5:c08b3b80 r4:00000000
[    7.466339] [<c04d9190>] (platform_driver_register+0x0/0x68) from
[<bf04c070>] (ohci_hcd_mod_init+0x70/0xc0 [oh
ci_hcd])
[    7.477691] [<bf04c000>] (ohci_hcd_mod_init+0x0/0xc0 [ohci_hcd])
from [<c01bc71c>] (do_one_initcall+0x44/0x10c)
[    7.488311]  r6:bf04c000 r5:c08b3b80 r4:bf049910 r3:00000000
[    7.494323] [<c01bc6d8>] (do_one_initcall+0x0/0x10c) from
[<c02487ac>] (sys_init_module+0x8c/0x1ac)
[    7.503845]  r7:0004764c r6:00000000 r5:00016258 r4:bf049910
[    7.509826] [<c0248720>] (sys_init_module+0x0/0x1ac) from
[<c01c6fa0>] (ret_fast_syscall+0x0/0x3c)
[    7.519256]  r7:00000080 r6:00000000 r5:00000000 r4:00009720
[    7.525238] Code: e3530001 03caaa01 138aaa01 ea000056 (e59f2268)
[    7.531707] ------------[ cut here ]------------
[    7.536621] WARNING: at arch/arm/mach-omap2/omap_l3_noc.c:106
l3_interrupt_handler+0xf0/0x144()
[    7.545837] CUSTOM SRESP error with SOURCE:L4CFG
[    7.550720] Modules linked in: ohci_hcd(+) usbcore twl6030_usb(+)
[    7.557159] Backtrace:
[    7.559753] [<c01cb40c>] (dump_backtrace+0x0/0x100) from
[<c06ab794>] (dump_stack+0x20/0x24)
[    7.568664]  r6:c07d3333 r5:0000006a r4:ef2c5a88 r3:00000002
[    7.574645] [<c06ab774>] (dump_stack+0x0/0x24) from [<c01ffbe4>]
(warn_slowpath_common+0x5c/0x74)
[    7.584014] [<c01ffb88>] (warn_slowpath_common+0x0/0x74) from
[<c01ffcb8>] (warn_slowpath_fmt+0x40/0x48)
[    7.593963]  r8:00000000 r7:00000105 r6:80080003 r5:00000448 r4:f8000000
[    7.600860] r3:00000009
[    7.603637] [<c01ffc78>] (warn_slowpath_fmt+0x0/0x48) from
[<c01e2664>] (l3_interrupt_handler+0xf0/0x144)
[    7.613708]  r3:c07d33b4 r2:c07d3383
[    7.617523] [<c01e2574>] (l3_interrupt_handler+0x0/0x144) from
[<c024d360>] (handle_irq_event_percpu+0xc4/0x258
)
[    7.628204]  r6:ef919320 r5:0000002a r4:ef919320
[    7.633117] [<c024d29c>] (handle_irq_event_percpu+0x0/0x258) from
[<c024d540>] (handle_irq_event+0x4c/0x6c)
[    7.643371] [<c024d4f4>] (handle_irq_event+0x0/0x6c) from
[<c024fc78>] (handle_fasteoi_irq+0xd8/0x110)
[    7.653167]  r6:0000002a r5:c08566ac r4:c0856660 r3:00000000
[    7.659149] [<c024fba0>] (handle_fasteoi_irq+0x0/0x110) from
[<c024cc58>] (generic_handle_irq+0x30/0x40)
[    7.669128]  r5:ef2c5c58 r4:0000002a
[    7.672912] [<c024cc28>] (generic_handle_irq+0x0/0x40) from
[<c01bc2e8>] (asm_do_IRQ+0x88/0xc8)
[    7.682098]  r4:0000002a r3:0000019a
[    7.685882] [<c01bc260>] (asm_do_IRQ+0x0/0xc8) from [<c06b024c>]
(__irq_svc+0x4c/0xf0)
[    7.694213] Exception stack(0xef2c5b78 to 0xef2c5bc0)
[    7.699523] 5b60:
    c0207470 ef2c5b98
[    7.708160] 5b80: 00000000 00000000 00000082 c0207c0c c1757040
00000003 00000002 0000000a
[    7.716766] 5ba0: 8000001c ef2c5bfc ef2c5bb0 ef2c5bc0 c0238c70
c0207474 60000013 ffffffff
[    7.725372]  r5:fa240100 r4:ffffffff
[    7.729156] [<c02073f8>] (__do_softirq+0x0/0x298) from [<c0207c0c>]
(irq_exit+0x68/0xc0)
[    7.737701] [<c0207ba4>] (irq_exit+0x0/0xc0) from [<c01cd108>]
(ipi_timer+0x3c/0x48)
[    7.745849]  r4:c005a040 r3:00000000
[    7.749603] [<c01cd0cc>] (ipi_timer+0x0/0x48) from [<c01bc390>]
(do_local_timer+0x68/0x94)
[    7.758331]  r6:c09b6360 r5:00000000 r4:c01bafd8 r3:000005f7
[    7.764312] [<c01bc328>] (do_local_timer+0x0/0x94) from
[<c06b024c>] (__irq_svc+0x4c/0xf0)
[    7.773010] Exception stack(0xef2c5c58 to 0xef2c5ca0)
[    7.778350] 5c40:
    c06aff1c ef2c5c78
[    7.786956] 5c60: 00000000 00000000 c0870a50 ef2c5d98 00000001
00001406 ef2c5d98 00000093
[    7.795562] 5c80: 8000001c ef2c5cb4 ef2c5c90 ef2c5ca0 c0238c70
c06aff20 60000013 ffffffff
[    7.804168]  r6:0000001d r5:fa240100 r4:ffffffff r3:60000013
[    7.810150] [<c06afee8>] (_raw_spin_unlock_irq+0x0/0x60) from
[<c01cb9a4>] (die+0xa4/0x10c)
[    7.818969]  r4:ef2c4000 r3:c08b5a30
[    7.822753] [<c01cb900>] (die+0x0/0x10c) from [<c01cba68>]
(arm_notify_die+0x5c/0x60)
[    7.830963]  r7:c0870f88 r6:400b3070 r5:c08710e8 r4:00001406
[    7.836975] [<c01cba0c>] (arm_notify_die+0x0/0x60) from
[<c01bc1a0>] (do_DataAbort+0x94/0xa8)
[    7.845947] [<c01bc10c>] (do_DataAbort+0x0/0xa8) from [<c06b01d0>]
(__dabt_svc+0x70/0xa0)
[    7.854553] Exception stack(0xef2c5d98 to 0xef2c5de0)
[    7.859863] 5d80:
    00000000 0005714d
[    7.868499] 5da0: 8000001c 00000000 efaedd20 efaee408 c08810b8
efaedd64 80000013 ef2c4000
[    7.877105] 5dc0: 8000001c ef2c5e04 ef2c5da8 ef2c5de0 c06affa0
c04e547c 80000093 ffffffff
[    7.885711]  r8:80000013 r7:efaedd64 r6:c08810b8 r5:00000406 r4:0000040f
[    7.892822] [<c04e5358>] (usbhs_enable+0x0/0x3a0) from [<c04e5714>]
(omap_usbhs_enable+0x1c/0x20)
[    7.902191] [<c04e56f8>] (omap_usbhs_enable+0x0/0x20) from
[<bf048ac8>] (ohci_hcd_omap3_probe+0x108/0x1b0 [ohci
_hcd])
[    7.913360] [<bf0489c0>] (ohci_hcd_omap3_probe+0x0/0x1b0
[ohci_hcd]) from [<c04d8eac>] (platform_drv_probe+0x24
/0x28)
[    7.924560]  r8:c01c7208 r7:00000000 r6:bf0498d4 r5:bf0498d4 r4:efaee408
[    7.931457] r3:bf0489c0
[    7.934234] [<c04d8e88>] (platform_drv_probe+0x0/0x28) from
[<c04d78e8>] (really_probe+0xd4/0x1b8)
[    7.943664] [<c04d7814>] (really_probe+0x0/0x1b8) from [<c04d7c24>]
(driver_probe_device+0x80/0xa4)
[    7.953186]  r6:bf0498d4 r5:bf0498d4 r4:efaee408
[    7.958068] [<c04d7ba4>] (driver_probe_device+0x0/0xa4) from
[<c04d7cc0>] (__driver_attach+0x78/0x9c)
[    7.967773]  r5:efaee43c r4:efaee408
[    7.971557] [<c04d7c48>] (__driver_attach+0x0/0x9c) from
[<c04d69e8>] (bus_for_each_dev+0x5c/0x8c)
[    7.980987]  r6:00000000 r5:c04d7c48 r4:bf0498d4 r3:c04d7c48
[    7.986968] [<c04d698c>] (bus_for_each_dev+0x0/0x8c) from
[<c04d76d4>] (driver_attach+0x28/0x30)
[    7.996215]  r6:c089d6e8 r5:efb045e0 r4:bf0498d4
[    8.001098] [<c04d76ac>] (driver_attach+0x0/0x30) from [<c04d7354>]
(bus_add_driver+0xc0/0x1c4)
[    8.010253] [<c04d7294>] (bus_add_driver+0x0/0x1c4) from
[<c04d8378>] (driver_register+0xb0/0xe4)
[    8.019592]  r7:00000000 r6:bf049a64 r5:c08b3b80 r4:bf0498d4
[    8.025573] [<c04d82c8>] (driver_register+0x0/0xe4) from
[<c04d91e4>] (platform_driver_register+0x54/0x68)
[    8.035766]  r5:c08b3b80 r4:00000000
[    8.039550] [<c04d9190>] (platform_driver_register+0x0/0x68) from
[<bf04c070>] (ohci_hcd_mod_init+0x70/0xc0 [oh
ci_hcd])
[    8.050903] [<bf04c000>] (ohci_hcd_mod_init+0x0/0xc0 [ohci_hcd])
from [<c01bc71c>] (do_one_initcall+0x44/0x10c)
[    8.061523]  r6:bf04c000 r5:c08b3b80 r4:bf049910 r3:00000000
[    8.067535] [<c01bc6d8>] (do_one_initcall+0x0/0x10c) from
[<c02487ac>] (sys_init_module+0x8c/0x1ac)
[    8.077056]  r7:0004764c r6:00000000 r5:00016258 r4:bf049910
[    8.083038] [<c0248720>] (sys_init_module+0x0/0x1ac) from
[<c01c6fa0>] (ret_fast_syscall+0x0/0x3c)
[    8.092498]  r7:00000080 r6:00000000 r5:00000000 r4:00009720
[    8.098480] ---[ end trace 6663274d06549573 ]---
[    8.103485] ---[ end trace 6663274d06549574 ]---
[    8.103576] omap_i2c omap_i2c.1: rpm_resume flags 0x4
[    8.103576] omap_i2c omap_i2c.1: rpm_resume returns 1
[    8.119110] note: modprobe[718] exited with preempt_count 1
[    8.125061] BUG: sleeping function called from invalid context at
kernel/rwsem.c:21
[    8.133209] in_atomic(): 1, irqs_disabled(): 0, pid: 718, name: modprobe
[    8.133270] omap_i2c omap_i2c.1: rpm_resume flags 0x4
[    8.133270] omap_i2c omap_i2c.1: rpm_resume returns 1
[    8.151031] INFO: lockdep is turned off.
[    8.155212] Backtrace:
[    8.155242] omap_i2c omap_i2c.1: rpm_resume flags 0x4
[    8.155273] omap_i2c omap_i2c.1: rpm_resume returns 1
[    8.168487]
[    8.170135] [<c01cb40c>] (dump_backtrace+0x0/0x100) from
[<c06ab794>] (dump_stack+0x20/0x24)
[    8.179138]  r6:ef3e45a0
[    8.179260] omap_i2c omap_i2c.1: rpm_resume flags 0x4
[    8.179260] omap_i2c omap_i2c.1: rpm_resume returns 1
[    8.192443]  r5:ffff6e11 r4:ef2c4000
[    8.194976] omap_i2c omap_i2c.1: rpm_resume flags 0x4
[    8.195007] omap_i2c omap_i2c.1: rpm_resume returns 1
[    8.206878]  r3:20000013
[    8.209594] [<c06ab774>] (dump_stack+0x0/0x24) from [<c01f13a8>]
(__might_sleep+0x110/0x130)
[    8.209594] omap_i2c omap_i2c.1: rpm_resume flags 0x4
[    8.209625] omap_i2c omap_i2c.1: rpm_resume returns 1
[    8.229156] [<c01f1298>] (__might_sleep+0x0/0x130) from
[<c06ae748>] (down_read+0x34/0x90)
[    8.237884]  r5:ef3e45d8
[    8.237915] omap_i2c omap_i2c.1: rpm_resume flags 0x4
[    8.237915] omap_i2c omap_i2c.1: rpm_resume returns 1
[    8.251190]  r4:c024a8f0
[    8.253936] [<c06ae714>] (down_read+0x0/0x90) from [<c024a8f0>]
(acct_collect+0x50/0x1b4)
[    8.253936] omap_i2c omap_i2c.1: rpm_resume flags 0x4
[    8.253936] omap_i2c omap_i2c.1: rpm_resume returns 1
[    8.273193]  r6:0000000b r5:ef2c4000
[    8.275695] omap_i2c omap_i2c.1: rpm_resume flags 0x4
[    8.275726] omap_i2c omap_i2c.1: rpm_resume returns 1
[    8.287628]  r4:ef9d0ca0
[    8.290344] [<c024a8a0>] (acct_collect+0x0/0x1b4) from [<c0204048>]
(do_exit+0x1f8/0x384)
[    8.290344] omap_i2c omap_i2c.1: rpm_resume flags 0x4
[    8.290344] omap_i2c omap_i2c.1: rpm_resume returns 1
[    8.309600]  r8:ef2c5d98 r7:00001406 r6:00000001
[    8.313232] omap_i2c omap_i2c.1: rpm_resume flags 0x4
[    8.313232] omap_i2c omap_i2c.1: rpm_resume returns 1
[    8.325134]  r5:0000000b r4:ef99e0c0
[    8.328765] r3:000002ad
[    8.328765] omap_i2c omap_i2c.1: rpm_resume flags 0x4
[    8.328796] omap_i2c omap_i2c.1: rpm_resume returns 1
[    8.342163]
[    8.343780] [<c0203e50>] (do_exit+0x0/0x384) from [<c01cb9f8>]
(die+0xf8/0x10c)
[    8.343780] omap_i2c omap_i2c.1: rpm_resume flags 0x4
[    8.343811] omap_i2c omap_i2c.1: rpm_resume returns 1
[    8.362121]  r7:00001406 r3:00008001
[    8.364624] omap_i2c omap_i2c.1: rpm_resume flags 0x4
[    8.364654] omap_i2c omap_i2c.1: rpm_resume returns 1
[    8.376525]
[    8.378143] [<c01cb900>] (die+0x0/0x10c) from [<c01cba68>]
(arm_notify_die+0x5c/0x60)
[    8.378143] twl6030_usb twl6030_usb: Initialized TWL6030 USB module
[    8.378173] driver: 'twl6030_usb': driver_bound: bound to device
'twl6030_usb'
[    8.378173] bus: 'platform': really_probe: bound device twl6030_usb
to driver twl6030_usb
[    8.379577] omap_i2c omap_i2c.1: rpm_resume flags 0x4
[    8.379577] omap_i2c omap_i2c.1: rpm_resume returns 1
[    8.419860]  r7:c0870f88 r6:400b3070 r5:c08710e8
[    8.423553] omap_i2c omap_i2c.1: rpm_resume flags 0x4
[    8.423553] omap_i2c omap_i2c.1: rpm_resume returns 1
[    8.435394]  r4:00001406
[    8.438110] [<c01cba0c>] (arm_notify_die+0x0/0x60) from
[<c01bc1a0>] (do_DataAbort+0x94/0xa8)
[    8.438140] omap_i2c omap_i2c.1: rpm_resume flags 0x4
[    8.438140] omap_i2c omap_i2c.1: rpm_resume returns 1
[    8.457733] [<c01bc10c>] (do_DataAbort+0x0/0xa8) from [<c06b01d0>]
(__dabt_svc+0x70/0xa0)
[    8.466400] Exception stack(0xef2c5d98 to 0xef2c5de0)
[    8.466430] omap_i2c omap_i2c.1: rpm_resume flags 0x4
[    8.466430] omap_i2c omap_i2c.1: rpm_resume returns 1
[    8.482360] 5d80:
    00000000 0005714d
[    8.490997] 5da0: 8000001c 00000000 efaedd20 efaee408 c08810b8
efaedd64 80000013 ef2c4000
[    8.491027] omap_i2c omap_i2c.1: rpm_resume flags 0x4
[    8.491027] omap_i2c omap_i2c.1: rpm_resume returns 1
[    8.510284] 5dc0: 8000001c ef2c5e04 ef2c5da8 ef2c5de0 c06affa0
c04e547c 80000093 ffffffff
[    8.518920]  r8:80000013
[    8.518951] omap_i2c omap_i2c.1: rpm_resume flags 0x4
[    8.518951] omap_i2c omap_i2c.1: rpm_resume returns 1
[    8.532226]  r7:efaedd64 r6:c08810b8 r5:00000406 r4:0000040f
[    8.538269] [<c04e5358>] (usbhs_enable+0x0/0x3a0) from [<c04e5714>]
(omap_usbhs_enable+0x1c/0x20)
[    8.547668] [<c04e56f8>] (omap_usbhs_enable+0x0/0x20) from
[<bf048ac8>] (ohci_hcd_omap3_probe+0x108/0x1b0 [ohci
_hcd])
[    8.558868] [<bf0489c0>] (ohci_hcd_omap3_probe+0x0/0x1b0
[ohci_hcd]) from [<c04d8eac>] (platform_drv_probe+0x24
/0x28)
[    8.570037]  r8:c01c7208 r7:00000000 r6:bf0498d4 r5:bf0498d4 r4:efaee408
[    8.576965] r3:bf0489c0
[    8.579772] [<c04d8e88>] (platform_drv_probe+0x0/0x28) from
[<c04d78e8>] (really_probe+0xd4/0x1b8)
[    8.589233] [<c04d7814>] (really_probe+0x0/0x1b8) from [<c04d7c24>]
(driver_probe_device+0x80/0xa4)
[    8.598785]  r6:bf0498d4 r5:bf0498d4 r4:efaee408
[    8.603668] [<c04d7ba4>] (driver_probe_device+0x0/0xa4) from
[<c04d7cc0>] (__driver_attach+0x78/0x9c)
[    8.613403]  r5:efaee43c r4:efaee408
[    8.617187] [<c04d7c48>] (__driver_attach+0x0/0x9c) from
[<c04d69e8>] (bus_for_each_dev+0x5c/0x8c)
[    8.626647]  r6:00000000 r5:c04d7c48 r4:bf0498d4 r3:c04d7c48
[    8.632659] [<c04d698c>] (bus_for_each_dev+0x0/0x8c) from
[<c04d76d4>] (driver_attach+0x28/0x30)
[    8.641906]  r6:c089d6e8 r5:efb045e0 r4:bf0498d4
[    8.646820] [<c04d76ac>] (driver_attach+0x0/0x30) from [<c04d7354>]
(bus_add_driver+0xc0/0x1c4)
[    8.656005] [<c04d7294>] (bus_add_driver+0x0/0x1c4) from
[<c04d8378>] (driver_register+0xb0/0xe4)
[    8.665344]  r7:00000000 r6:bf049a64 r5:c08b3b80 r4:bf0498d4
[    8.671356] [<c04d82c8>] (driver_register+0x0/0xe4) from
[<c04d91e4>] (platform_driver_register+0x54/0x68)
[    8.681549]  r5:c08b3b80 r4:00000000
[    8.685363] [<c04d9190>] (platform_driver_register+0x0/0x68) from
[<bf04c070>] (ohci_hcd_mod_init+0x70/0xc0 [oh
ci_hcd])
[    8.696746] [<bf04c000>] (ohci_hcd_mod_init+0x0/0xc0 [ohci_hcd])
from [<c01bc71c>] (do_one_initcall+0x44/0x10c)
[    8.707397]  r6:bf04c000 r5:c08b3b80 r4:bf049910 r3:00000000
[    8.713409] [<c01bc6d8>] (do_one_initcall+0x0/0x10c) from
[<c02487ac>] (sys_init_module+0x8c/0x1ac)
[    8.722930]  r7:0004764c r6:00000000 r5:00016258 r4:bf049910
[    8.728942] [<c0248720>] (sys_init_module+0x0/0x1ac) from
[<c01c6fa0>] (ret_fast_syscall+0x0/0x3c)
[    8.738403]  r7:00000080 r6:00000000 r5:00000000 r4:00009720
[    8.744415] BUG: scheduling while atomic: modprobe/718/0x40000002
[    8.750854] INFO: lockdep is turned off.
[    8.754974] Modules linked in: ohci_hcd(+) usbcore twl6030_usb
[    8.761169] Backtrace:
[    8.763763] [<c01cb40c>] (dump_backtrace+0x0/0x100) from
[<c06ab794>] (dump_stack+0x20/0x24)
[    8.772644]  r6:00000000 r5:00000000 r4:ef99e0c0 r3:20000013
[    8.778656] [<c06ab774>] (dump_stack+0x0/0x24) from [<c01f1cf4>]
(__schedule_bug+0x84/0x94)
[    8.787506] [<c01f1c70>] (__schedule_bug+0x0/0x94) from
[<c06abe98>] (schedule+0x74/0x5e0)
[    8.796264]  r5:c18b8180 r4:ef99e0c0
[    8.800079] [<c06abe24>] (schedule+0x0/0x5e0) from [<c01f86cc>]
(__cond_resched+0x20/0x2c)
[    8.808837] [<c01f86ac>] (__cond_resched+0x0/0x2c) from
[<c06ac6c0>] (_cond_resched+0x40/0x50)
[    8.817932] [<c06ac680>] (_cond_resched+0x0/0x50) from [<c02a4550>]
(unmap_page_range+0x174/0x188)
[    8.827392] [<c02a43dc>] (unmap_page_range+0x0/0x188) from
[<c02a4aa0>] (unmap_vmas+0x88/0xb8)
[    8.836517] [<c02a4a18>] (unmap_vmas+0x0/0xb8) from [<c02a8edc>]
(exit_mmap+0x138/0x240)
[    8.845031] [<c02a8da4>] (exit_mmap+0x0/0x240) from [<c01fdde4>]
(mmput+0x60/0x120)
[    8.853118]  r6:ef99e4a0 r5:00000000 r4:ef3e4540
[    8.858032] [<c01fdd84>] (mmput+0x0/0x120) from [<c0202648>]
(exit_mm+0x14c/0x154)
[    8.865997]  r5:ef99e0c0 r4:ef3e4540
[    8.869812] [<c02024fc>] (exit_mm+0x0/0x154) from [<c0204054>]
(do_exit+0x204/0x384)
[    8.877960]  r7:00001406 r6:00000001 r5:0000000b r4:ef99e0c0
[    8.883972] [<c0203e50>] (do_exit+0x0/0x384) from [<c01cb9f8>]
(die+0xf8/0x10c)
[    8.891662]  r7:00001406 r3:00008001
[    8.895477] [<c01cb900>] (die+0x0/0x10c) from [<c01cba68>]
(arm_notify_die+0x5c/0x60)
[    8.903747]  r7:c0870f88 r6:400b3070 r5:c08710e8 r4:00001406
[    8.909759] [<c01cba0c>] (arm_notify_die+0x0/0x60) from
[<c01bc1a0>] (do_DataAbort+0x94/0xa8)
[    8.918762] [<c01bc10c>] (do_DataAbort+0x0/0xa8) from [<c06b01d0>]
(__dabt_svc+0x70/0xa0)
[    8.927368] Exception stack(0xef2c5d98 to 0xef2c5de0)
[    8.932708] 5d80:
    00000000 0005714d
[    8.941345] 5da0: 8000001c 00000000 efaedd20 efaee408 c08810b8
efaedd64 80000013 ef2c4000
[    8.949951] 5dc0: 8000001c ef2c5e04 ef2c5da8 ef2c5de0 c06affa0
c04e547c 80000093 ffffffff
[    8.958587]  r8:80000013 r7:efaedd64 r6:c08810b8 r5:00000406 r4:0000040f
[    8.965698] [<c04e5358>] (usbhs_enable+0x0/0x3a0) from [<c04e5714>]
(omap_usbhs_enable+0x1c/0x20)
[    8.975097] [<c04e56f8>] (omap_usbhs_enable+0x0/0x20) from
[<bf048ac8>] (ohci_hcd_omap3_probe+0x108/0x1b0 [ohci
_hcd])
[    8.986297] [<bf0489c0>] (ohci_hcd_omap3_probe+0x0/0x1b0
[ohci_hcd]) from [<c04d8eac>] (platform_drv_probe+0x24
/0x28)
[    8.997497]  r8:c01c7208 r7:00000000 r6:bf0498d4 r5:bf0498d4 r4:efaee408
[    9.004425] r3:bf0489c0
[    9.007202] [<c04d8e88>] (platform_drv_probe+0x0/0x28) from
[<c04d78e8>] (really_probe+0xd4/0x1b8)
[    9.016662] [<c04d7814>] (really_probe+0x0/0x1b8) from [<c04d7c24>]
(driver_probe_device+0x80/0xa4)
[    9.026214]  r6:bf0498d4 r5:bf0498d4 r4:efaee408
[    9.031097] [<c04d7ba4>] (driver_probe_device+0x0/0xa4) from
[<c04d7cc0>] (__driver_attach+0x78/0x9c)
[    9.040832]  r5:efaee43c r4:efaee408
[    9.044616] [<c04d7c48>] (__driver_attach+0x0/0x9c) from
[<c04d69e8>] (bus_for_each_dev+0x5c/0x8c)
[    9.054077]  r6:00000000 r5:c04d7c48 r4:bf0498d4 r3:c04d7c48
[    9.060089] [<c04d698c>] (bus_for_each_dev+0x0/0x8c) from
[<c04d76d4>] (driver_attach+0x28/0x30)
[    9.069335]  r6:c089d6e8 r5:efb045e0 r4:bf0498d4
[    9.074249] [<c04d76ac>] (driver_attach+0x0/0x30) from [<c04d7354>]
(bus_add_driver+0xc0/0x1c4)
[    9.083435] [<c04d7294>] (bus_add_driver+0x0/0x1c4) from
[<c04d8378>] (driver_register+0xb0/0xe4)
[    9.092803]  r7:00000000 r6:bf049a64 r5:c08b3b80 r4:bf0498d4
[    9.098815] [<c04d82c8>] (driver_register+0x0/0xe4) from
[<c04d91e4>] (platform_driver_register+0x54/0x68)
[    9.108978]  r5:c08b3b80 r4:00000000
[    9.112792] [<c04d9190>] (platform_driver_register+0x0/0x68) from
[<bf04c070>] (ohci_hcd_mod_init+0x70/0xc0 [oh
ci_hcd])
[    9.124176] [<bf04c000>] (ohci_hcd_mod_init+0x0/0xc0 [ohci_hcd])
from [<c01bc71c>] (do_one_initcall+0x44/0x10c)
[    9.134826]  r6:bf04c000 r5:c08b3b80 r4:bf049910 r3:00000000
[    9.140838] [<c01bc6d8>] (do_one_initcall+0x0/0x10c) from
[<c02487ac>] (sys_init_module+0x8c/0x1ac)
[    9.150390]  r7:0004764c r6:00000000 r5:00016258 r4:bf049910
[    9.156402] [<c0248720>] (sys_init_module+0x0/0x1ac) from
[<c01c6fa0>] (ret_fast_syscall+0x0/0x3c)
[    9.165863]  r7:00000080 r6:00000000 r5:00000000 r4:00009720
[    9.171905] BUG: sleeping function called from invalid context at
mm/memory.c:1238
[    9.179901] in_atomic(): 1, irqs_disabled(): 0, pid: 718, name: modprobe
[    9.186981] INFO: lockdep is turned off.
[    9.191101] Backtrace:
[    9.193695] [<c01cb40c>] (dump_backtrace+0x0/0x100) from
[<c06ab794>] (dump_stack+0x20/0x24)
[    9.202606]  r6:00000000 r5:ffff6e97 r4:ef2c4000 r3:20000113
[    9.208618] [<c06ab774>] (dump_stack+0x0/0x24) from [<c01f13a8>]
(__might_sleep+0x110/0x130)
[    9.217498] [<c01f1298>] (__might_sleep+0x0/0x130) from
[<c02a454c>] (unmap_page_range+0x170/0x188)
[    9.227050]  r5:ef3bcf40 r4:ef2c5bfc
[    9.230865] [<c02a43dc>] (unmap_page_range+0x0/0x188) from
[<c02a4aa0>] (unmap_vmas+0x88/0xb8)
[    9.239959] [<c02a4a18>] (unmap_vmas+0x0/0xb8) from [<c02a8edc>]
(exit_mmap+0x138/0x240)
[    9.248474] [<c02a8da4>] (exit_mmap+0x0/0x240) from [<c01fdde4>]
(mmput+0x60/0x120)
[    9.256561]  r6:ef99e4a0 r5:00000000 r4:ef3e4540
[    9.261474] [<c01fdd84>] (mmput+0x0/0x120) from [<c0202648>]
(exit_mm+0x14c/0x154)
[    9.269439]  r5:ef99e0c0 r4:ef3e4540
[    9.273223] [<c02024fc>] (exit_mm+0x0/0x154) from [<c0204054>]
(do_exit+0x204/0x384)
[    9.281402]  r7:00001406 r6:00000001 r5:0000000b r4:ef99e0c0
[    9.287414] [<c0203e50>] (do_exit+0x0/0x384) from [<c01cb9f8>]
(die+0xf8/0x10c)
[    9.295135]  r7:00001406 r3:00008001
[    9.295135] [<c01cb900>] (die+0x0/0x10c) from [<c01cba68>]
(arm_notify_die+0x5c/0x60)
[    9.295166]  r7:c0870f88 r6:400b3070 r5:c08710e8 r4:00001406
[    9.295166] [<c01cba0c>] (arm_notify_die+0x0/0x60) from
[<c01bc1a0>] (do_DataAbort+0x94/0xa8)
[    9.295196] [<c01bc10c>] (do_DataAbort+0x0/0xa8) from [<c06b01d0>]
(__dabt_svc+0x70/0xa0)
[    9.295196] Exception stack(0xef2c5d98 to 0xef2c5de0)
[    9.295227] 5d80:
    00000000 0005714d
[    9.295227] 5da0: 8000001c 00000000 efaedd20 efaee408 c08810b8
efaedd64 80000013 ef2c4000
[    9.295227] 5dc0: 8000001c ef2c5e04 ef2c5da8 ef2c5de0 c06affa0
c04e547c 80000093 ffffffff
[    9.295257]  r8:80000013 r7:efaedd64 r6:c08810b8 r5:00000406 r4:0000040f
[    9.295288] [<c04e5358>] (usbhs_enable+0x0/0x3a0) from [<c04e5714>]
(omap_usbhs_enable+0x1c/0x20)
[    9.295318] [<c04e56f8>] (omap_usbhs_enable+0x0/0x20) from
[<bf048ac8>] (ohci_hcd_omap3_probe+0x108/0x1b0 [ohci
_hcd])
[    9.295318] [<bf0489c0>] (ohci_hcd_omap3_probe+0x0/0x1b0
[ohci_hcd]) from [<c04d8eac>] (platform_drv_probe+0x24
/0x28)
[    9.295349]  r8:c01c7208 r7:00000000 r6:bf0498d4 r5:bf0498d4 r4:efaee408
[    9.295349] r3:bf0489c0
[    9.295379] [<c04d8e88>] (platform_drv_probe+0x0/0x28) from
[<c04d78e8>] (really_probe+0xd4/0x1b8)
[    9.295379] [<c04d7814>] (really_probe+0x0/0x1b8) from [<c04d7c24>]
(driver_probe_device+0x80/0xa4)
[    9.295410]  r6:bf0498d4 r5:bf0498d4 r4:efaee408
[    9.295410] [<c04d7ba4>] (driver_probe_device+0x0/0xa4) from
[<c04d7cc0>] (__driver_attach+0x78/0x9c)
[    9.295440]  r5:efaee43c r4:efaee408
[    9.295440] [<c04d7c48>] (__driver_attach+0x0/0x9c) from
[<c04d69e8>] (bus_for_each_dev+0x5c/0x8c)
[    9.295471]  r6:00000000 r5:c04d7c48 r4:bf0498d4 r3:c04d7c48
[    9.295471] [<c04d698c>] (bus_for_each_dev+0x0/0x8c) from
[<c04d76d4>] (driver_attach+0x28/0x30)
[    9.295501]  r6:c089d6e8 r5:efb045e0 r4:bf0498d4
[    9.295501] [<c04d76ac>] (driver_attach+0x0/0x30) from [<c04d7354>]
(bus_add_driver+0xc0/0x1c4)
[    9.295532] [<c04d7294>] (bus_add_driver+0x0/0x1c4) from
[<c04d8378>] (driver_register+0xb0/0xe4)
[    9.295532]  r7:00000000 r6:bf049a64 r5:c08b3b80 r4:bf0498d4
[    9.295562] [<c04d82c8>] (driver_register+0x0/0xe4) from
[<c04d91e4>] (platform_driver_register+0x54/0x68)
[    9.295562]  r5:c08b3b80 r4:00000000
[    9.295593] [<c04d9190>] (platform_driver_register+0x0/0x68) from
[<bf04c070>] (ohci_hcd_mod_init+0x70/0xc0 [oh
ci_hcd])
[    9.295623] [<bf04c000>] (ohci_hcd_mod_init+0x0/0xc0 [ohci_hcd])
from [<c01bc71c>] (do_one_initcall+0x44/0x10c)
[    9.295623]  r6:bf04c000 r5:c08b3b80 r4:bf049910 r3:00000000
[    9.295654] [<c01bc6d8>] (do_one_initcall+0x0/0x10c) from
[<c02487ac>] (sys_init_module+0x8c/0x1ac)
[    9.295654]  r7:0004764c r6:00000000 r5:00016258 r4:bf049910
[    9.295684] [<c0248720>] (sys_init_module+0x0/0x1ac) from
[<c01c6fa0>] (ret_fast_syscall+0x0/0x3c)
[    9.295684]  r7:00000080 r6:00000000 r5:00000000 r4:00009720
[    9.295715] BUG: scheduling while atomic: modprobe/718/0x40000002
[    9.295715] INFO: lockdep is turned off.
[    9.295715] Modules linked in: ohci_hcd(+) usbcore twl6030_usb
[    9.295745] Backtrace:
[    9.295745] [<c01cb40c>] (dump_backtrace+0x0/0x100) from
[<c06ab794>] (dump_stack+0x20/0x24)
[    9.295776]  r6:00000001 r5:00000000 r4:ef99e0c0 r3:20000113
[    9.295776] [<c06ab774>] (dump_stack+0x0/0x24) from [<c01f1cf4>]
(__schedule_bug+0x84/0x94)
[    9.295806] [<c01f1c70>] (__schedule_bug+0x0/0x94) from
[<c06abe98>] (schedule+0x74/0x5e0)
[    9.295806]  r5:c1a1f180 r4:ef99e0c0
[    9.295837] [<c06abe24>] (schedule+0x0/0x5e0) from [<c01f86cc>]
(__cond_resched+0x20/0x2c)
[    9.295837] [<c01f86ac>] (__cond_resched+0x0/0x2c) from
[<c06ac6c0>] (_cond_resched+0x40/0x50)
[    9.295867] [<c06ac680>] (_cond_resched+0x0/0x50) from [<c02a4550>]
(unmap_page_range+0x174/0x188)
[    9.295867] [<c02a43dc>] (unmap_page_range+0x0/0x188) from
[<c02a4aa0>] (unmap_vmas+0x88/0xb8)
[    9.295898] [<c02a4a18>] (unmap_vmas+0x0/0xb8) from [<c02a8edc>]
(exit_mmap+0x138/0x240)
[    9.295898] [<c02a8da4>] (exit_mmap+0x0/0x240) from [<c01fdde4>]
(mmput+0x60/0x120)
[    9.295928]  r6:ef99e4a0 r5:00000000 r4:ef3e4540
[    9.295928] [<c01fdd84>] (mmput+0x0/0x120) from [<c0202648>]
(exit_mm+0x14c/0x154)
[    9.295959]  r5:ef99e0c0 r4:ef3e4540
[    9.295959] [<c02024fc>] (exit_mm+0x0/0x154) from [<c0204054>]
(do_exit+0x204/0x384)
[    9.295959]  r7:00001406 r6:00000001 r5:0000000b r4:ef99e0c0
[    9.295989] [<c0203e50>] (do_exit+0x0/0x384) from [<c01cb9f8>]
(die+0xf8/0x10c)
[    9.295989]  r7:00001406 r3:00008001
[    9.296020] [<c01cb900>] (die+0x0/0x10c) from [<c01cba68>]
(arm_notify_die+0x5c/0x60)
[    9.296020]  r7:c0870f88 r6:400b3070 r5:c08710e8 r4:00001406
[    9.296051] [<c01cba0c>] (arm_notify_die+0x0/0x60) from
[<c01bc1a0>] (do_DataAbort+0x94/0xa8)
[    9.296051] [<c01bc10c>] (do_DataAbort+0x0/0xa8) from [<c06b01d0>]
(__dabt_svc+0x70/0xa0)
[    9.296081] Exception stack(0xef2c5d98 to 0xef2c5de0)
[    9.296081] 5d80:
    00000000 0005714d
[    9.296112] 5da0: 8000001c 00000000 efaedd20 efaee408 c08810b8
efaedd64 80000013 ef2c4000
[    9.296112] 5dc0: 8000001c ef2c5e04 ef2c5da8 ef2c5de0 c06affa0
c04e547c 80000093 ffffffff
[    9.296112]  r8:80000013 r7:efaedd64 r6:c08810b8 r5:00000406 r4:0000040f
[    9.296142] [<c04e5358>] (usbhs_enable+0x0/0x3a0) from [<c04e5714>]
(omap_usbhs_enable+0x1c/0x20)
[    9.296173] [<c04e56f8>] (omap_usbhs_enable+0x0/0x20) from
[<bf048ac8>] (ohci_hcd_omap3_probe+0x108/0x1b0 [ohci
_hcd])
[    9.296203] [<bf0489c0>] (ohci_hcd_omap3_probe+0x0/0x1b0
[ohci_hcd]) from [<c04d8eac>] (platform_drv_probe+0x24
/0x28)
[    9.296203]  r8:c01c7208 r7:00000000 r6:bf0498d4 r5:bf0498d4 r4:efaee408
[    9.296203] r3:bf0489c0
[    9.296234] [<c04d8e88>] (platform_drv_probe+0x0/0x28) from
[<c04d78e8>] (really_probe+0xd4/0x1b8)
[    9.296234] [<c04d7814>] (really_probe+0x0/0x1b8) from [<c04d7c24>]
(driver_probe_device+0x80/0xa4)
[    9.296264]  r6:bf0498d4 r5:bf0498d4 r4:efaee408
[    9.296264] [<c04d7ba4>] (driver_probe_device+0x0/0xa4) from
[<c04d7cc0>] (__driver_attach+0x78/0x9c)
[    9.296295]  r5:efaee43c r4:efaee408
[    9.296295] [<c04d7c48>] (__driver_attach+0x0/0x9c) from
[<c04d69e8>] (bus_for_each_dev+0x5c/0x8c)
[    9.296325]  r6:00000000 r5:c04d7c48 r4:bf0498d4 r3:c04d7c48
[    9.296325] [<c04d698c>] (bus_for_each_dev+0x0/0x8c) from
[<c04d76d4>] (driver_attach+0x28/0x30)
[    9.296356]  r6:c089d6e8 r5:efb045e0 r4:bf0498d4
[    9.296356] [<c04d76ac>] (driver_attach+0x0/0x30) from [<c04d7354>]
(bus_add_driver+0xc0/0x1c4)
[    9.296386] [<c04d7294>] (bus_add_driver+0x0/0x1c4) from
[<c04d8378>] (driver_register+0xb0/0xe4)
[    9.296386]  r7:00000000 r6:bf049a64 r5:c08b3b80 r4:bf0498d4
[    9.296417] [<c04d82c8>] (driver_register+0x0/0xe4) from
[<c04d91e4>] (platform_driver_register+0x54/0x68)
[    9.296417]  r5:c08b3b80 r4:00000000
[    9.296447] [<c04d9190>] (platform_driver_register+0x0/0x68) from
[<bf04c070>] (ohci_hcd_mod_init+0x70/0xc0 [oh
ci_hcd])
[    9.296478] [<bf04c000>] (ohci_hcd_mod_init+0x0/0xc0 [ohci_hcd])
from [<c01bc71c>] (do_one_initcall+0x44/0x10c)
[    9.296478]  r6:bf04c000 r5:c08b3b80 r4:bf049910 r3:00000000
[    9.296508] [<c01bc6d8>] (do_one_initcall+0x0/0x10c) from
[<c02487ac>] (sys_init_module+0x8c/0x1ac)
[    9.296508]  r7:0004764c r6:00000000 r5:00016258 r4:bf049910
[    9.296539] [<c0248720>] (sys_init_module+0x0/0x1ac) from
[<c01c6fa0>] (ret_fast_syscall+0x0/0x3c)
[    9.296539]  r7:00000080 r6:00000000 r5:00000000 r4:00009720
udevd-work[689]: '/sbin/modprobe -b platform:ohci-omap3' unexpected
exit with status 0x000b




thanks,
-- 
Ming Lei

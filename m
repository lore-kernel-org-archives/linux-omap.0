From: Tony Lindgren <tony@atomide.com>
Subject: Re: 4.13-rc0: stopped booting on Nokia N900
Date: Mon, 10 Jul 2017 03:02:50 -0700
Message-ID: <20170710100250.GR3730@atomide.com>
References: <20170710074610.GA22846@amd>
 <20170710081334.GA29726@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170710081334.GA29726@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>, Thomas Gleixner <tglx@linutronix.de>
Cc: pali.rohar@gmail.com, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com
List-Id: linux-omap@vger.kernel.org

* Pavel Machek <pavel@ucw.cz> [170710 01:14]:
> > I tested linux-next relatively recently, and it worked ok.
> 
> > af3c8d98508d37541d4bf57f13a984a7f73a328c is broken.
> > 650fc87 worked ok.
> 
> 2b97620 is broken.
> 
> commit a51166ce71844ffbb8f78d63647b44dd69e46cf1
>     Add linux-next specific files for 20170628
> 
> was ok.

Not sure if it's the same issue, but I bisected down an issue with commit
46e48e257360 ("genirq: Move irq resource handling out of spinlocked region"),
so adding Thomas.

Regards,

Tony

8< -------------------
Unhandled fault: external abort on non-linefetch (0x1028) at 0xfb050034
pgd = c0004000
[fb050034] *pgd=49011452(bad)
Internal error: : 1028 [#1] SMP ARM
Modules linked in:
CPU: 0 PID: 14 Comm: kworker/0:1 Tainted: G        W       4.12.0-01058-g46e48e257360 #238
Hardware name: Nokia RX-51 board
Workqueue: events deferred_probe_work_func
task: ce1d41c0 task.stack: ce1fc000
PC is at omap_gpio_get_direction+0x2c/0x44
LR is at _raw_spin_lock_irqsave+0x40/0x4c
pc : [<c0509258>]    lr : [<c08263c4>]    psr: 60000093
sp : ce1fdb78  ip : c0dce42c  fp : ce22d810
r10: ce22d800  r9 : 00000000  r8 : ce22d900
r7 : 00000016  r6 : ce223864  r5 : fb050034  r4 : 00000020
r3 : ce1d41c0  r2 : 00000000  r1 : a0000013  r0 : a0000013
Flags: nZCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment none
Control: 10c5387d  Table: 80004019  DAC: 00000051
Process kworker/0:1 (pid: 14, stack limit = 0xce1fc218)
Stack: (0xce1fdb78 to 0xce1fe000)
db60:                                                       00000020 ce2238a4
db80: ce223760 ce75c000 ce22d900 c0501efc ce2238a4 ce22d810 ce78e240 c05025b8
dba0: ce22d800 000000a6 ce78e240 c01a8010 ce0000c0 00000000 02000000 ce78e240
dbc0: 00000000 c063f3ec ce75c000 000000a6 00000000 ce22d800 ce22d810 c01a83dc
dbe0: 00000004 ce75c000 ce75c664 00000004 0000000e 00000002 0000000e 00000000
dc00: 02000000 c0640cb4 ce75c000 ce75c000 00003349 c0119a8c c0aedda8 00000000
dc20: ce798800 ce75c000 00000000 ce798800 00000004 d0194000 ce78e880 00000000
dc40: 02000000 c0641604 00000000 6a60556b 151193cc ce798810 c158dbb8 ce798810
dc60: ffffffed c0daf114 fffffdfb 00000000 00000002 c0584fe8 ce798810 c158dbb8
dc80: 00000000 c0daf114 00000000 c058308c 00000000 ce1fdcc8 c05831d8 00000001
dca0: 00000000 c158db74 00000000 c05815c4 ce09e8d4 ce6cc2d4 ce798810 ce798844
dcc0: c0da2510 c0582d48 ce798810 00000001 c158db74 ce798818 ce798810 c0da2510
dce0: 00000000 c05823c4 ce798818 ce27b410 ce798810 c0580768 00000000 00000000
dd00: 60000013 ce798800 ce798800 00000000 ce27b410 cfdeb7c0 00000000 ce6ef610
dd20: 00000f02 c069801c cfdeb770 00000000 ce27b410 00000000 c1590c7c c069d85c
dd40: 00000000 00000000 00000001 02000000 00000001 00000a00 00000000 00000000
dd60: 00000000 00000002 00000000 00000000 02000000 0200000e cfdeb7c8 00000200
dd80: 00000000 00000000 00000000 00000000 00000000 00000000 00000030 00000018
dda0: 00000000 00000000 00000000 00000000 00000000 00000000 0000000c 00000012
ddc0: 0000000c 00000030 00000000 00000000 00000000 0000002a 000000b4 000000b4
dde0: 00000000 00000000 00000000 00000000 00000000 0000000c 00000000 00000000
de00: a0000013 00000000 cfdeb770 ce6f82d0 fffffff6 c0ae84cc ce27b410 ce27b400
de20: c0ad3d8c c069e500 00000000 ce6ef610 00000004 ce6ef610 c1569128 00000000
de40: 0b2c9444 ce27b410 ffffffed c0db423c fffffdfb 00000000 00000001 c0dc5b54
de60: c0d509ae c0584fe8 ce27b410 c158dbb8 00000000 c0db423c 00000000 c058308c
de80: 00000000 ce1fdeb8 c05831d8 00000001 00000000 c0d0796c c0dc5b54 c05815c4
dea0: ce09e8d4 ce1de754 ce27b410 ce27b444 c0da2510 c0582d48 ce27b410 00000001
dec0: c0da2208 ce27b410 ce27b410 c0da2510 c0da2208 c05823c4 ce27b410 c0da21bc
dee0: c0da21bc c0582850 c0da2210 ce1ded00 cfd9ee00 ce1fdf20 cfda2200 c0155b14
df00: 00000001 00000000 c0155a5c 00000000 00000000 00000000 c0156be8 00000008
df20: c0da2210 c0f14a94 00000000 c0ad7054 ce1ded00 cfd9ee00 ce1ded18 00000008
df40: cfd9ee34 ce1fc000 c0d04900 cfd9ee00 ce1ded00 c0156d64 00000000 ce1eee00
df60: ffffe000 ce1dec80 00000000 ce1eee00 ce1fc000 ce1ded00 c0156b38 ce1decb8
df80: ce0bfe90 c015c760 ce1fc000 ce1eee00 c015c650 00000000 00000000 00000000
dfa0: 00000000 00000000 00000000 c01077d0 00000000 00000000 00000000 00000000
dfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
dfe0: 00000000 00000000 00000000 00000000 00000013 00000000 ffffffff ffffffff
[<c0509258>] (omap_gpio_get_direction) from [<c0501efc>] (gpiochip_lock_as_irq+0x98/0xe4)
[<c0501efc>] (gpiochip_lock_as_irq) from [<c05025b8>] (gpiochip_irq_reqres+0x2c/0x6c)
[<c05025b8>] (gpiochip_irq_reqres) from [<c01a8010>] (__setup_irq+0x46c/0x6e0)
[<c01a8010>] (__setup_irq) from [<c01a83dc>] (request_threaded_irq+0xcc/0x14c)
[<c01a83dc>] (request_threaded_irq) from [<c0640cb4>] (smc_probe+0x4c0/0xb58)
[<c0640cb4>] (smc_probe) from [<c0641604>] (smc_drv_probe+0x2b8/0x410)
[<c0641604>] (smc_drv_probe) from [<c0584fe8>] (platform_drv_probe+0x50/0xb0)
[<c0584fe8>] (platform_drv_probe) from [<c058308c>] (driver_probe_device+0x260/0x2e8)
[<c058308c>] (driver_probe_device) from [<c05815c4>] (bus_for_each_drv+0x64/0x98)
[<c05815c4>] (bus_for_each_drv) from [<c0582d48>] (__device_attach+0xb0/0x118)
[<c0582d48>] (__device_attach) from [<c05823c4>] (bus_probe_device+0x88/0x90)
[<c05823c4>] (bus_probe_device) from [<c0580768>] (device_add+0x3c8/0x57c)
[<c0580768>] (device_add) from [<c069801c>] (of_platform_device_create_pdata+0x70/0xa4)
[<c069801c>] (of_platform_device_create_pdata) from [<c069d85c>] (gpmc_probe_generic_child+0x98/0x8b4)
[<c069d85c>] (gpmc_probe_generic_child) from [<c069e500>] (gpmc_probe+0x488/0x644)
[<c069e500>] (gpmc_probe) from [<c0584fe8>] (platform_drv_probe+0x50/0xb0)
[<c0584fe8>] (platform_drv_probe) from [<c058308c>] (driver_probe_device+0x260/0x2e8)
[<c058308c>] (driver_probe_device) from [<c05815c4>] (bus_for_each_drv+0x64/0x98)
[<c05815c4>] (bus_for_each_drv) from [<c0582d48>] (__device_attach+0xb0/0x118)
[<c0582d48>] (__device_attach) from [<c05823c4>] (bus_probe_device+0x88/0x90)
[<c05823c4>] (bus_probe_device) from [<c0582850>] (deferred_probe_work_func+0x6c/0x9c)
[<c0582850>] (deferred_probe_work_func) from [<c0155b14>] (process_one_work+0x2b0/0x774)
[<c0155b14>] (process_one_work) from [<c0156d64>] (worker_thread+0x22c/0x540)
[<c0156d64>] (worker_thread) from [<c015c760>] (kthread+0x110/0x150)
[<c015c760>] (kthread) from [<c01077d0>] (ret_from_fork+0x14/0x24)
Code: e1a00006 e0855003 eb0c744b e1a01000 (e5954000)
---[ end trace ab200d44646e143a ]---
In-band Error seen by MPU  at address 0
------------[ cut here ]------------
WARNING: CPU: 0 PID: 14 at drivers/bus/omap_l3_smx.c:166 omap3_l3_app_irq+0xb4/0x11c
Modules linked in:
CPU: 0 PID: 14 Comm: kworker/0:1 Tainted: G      D W       4.12.0-01058-g46e48e257360 #238
Hardware name: Nokia RX-51 board
Workqueue: events deferred_probe_work_func
[<c0110220>] (unwind_backtrace) from [<c010c294>] (show_stack+0x10/0x14)
[<c010c294>] (show_stack) from [<c04c0068>] (dump_stack+0xac/0xe0)
[<c04c0068>] (dump_stack) from [<c01375f0>] (__warn+0xd8/0x104)
[<c01375f0>] (__warn) from [<c01376c8>] (warn_slowpath_null+0x20/0x28)
[<c01376c8>] (warn_slowpath_null) from [<c04f76f0>] (omap3_l3_app_irq+0xb4/0x11c)
[<c04f76f0>] (omap3_l3_app_irq) from [<c01a5e14>] (__handle_irq_event_percpu+0x48/0x3b4)
[<c01a5e14>] (__handle_irq_event_percpu) from [<c01a619c>] (handle_irq_event_percpu+0x1c/0x58)
[<c01a619c>] (handle_irq_event_percpu) from [<c01a6210>] (handle_irq_event+0x38/0x5c)
[<c01a6210>] (handle_irq_event) from [<c01a9674>] (handle_level_irq+0xbc/0x148)
[<c01a9674>] (handle_level_irq) from [<c01a5110>] (generic_handle_irq+0x20/0x34)
[<c01a5110>] (generic_handle_irq) from [<c01a5678>] (__handle_domain_irq+0x64/0xe0)
[<c01a5678>] (__handle_domain_irq) from [<c0826bf0>] (__irq_svc+0x70/0x98)
[<c0826bf0>] (__irq_svc) from [<c082652c>] (_raw_spin_unlock_irq+0x28/0x2c)
[<c082652c>] (_raw_spin_unlock_irq) from [<c013d898>] (do_exit+0x80c/0xbe4)
[<c013d898>] (do_exit) from [<c010c688>] (die+0x3f0/0x490)
[<c010c688>] (die) from [<c01013cc>] (do_DataAbort+0xa8/0xb8)
[<c01013cc>] (do_DataAbort) from [<c0826b44>] (__dabt_svc+0x64/0xa0)
Exception stack(0xce1fdb28 to 0xce1fdb70)
db20:                   a0000013 a0000013 00000000 ce1d41c0 00000020 fb050034
db40: ce223864 00000016 ce22d900 00000000 ce22d800 ce22d810 c0dce42c ce1fdb78
db60: c08263c4 c0509258 60000093 ffffffff
[<c0826b44>] (__dabt_svc) from [<c0509258>] (omap_gpio_get_direction+0x2c/0x44)
[<c0509258>] (omap_gpio_get_direction) from [<c0501efc>] (gpiochip_lock_as_irq+0x98/0xe4)
[<c0501efc>] (gpiochip_lock_as_irq) from [<c05025b8>] (gpiochip_irq_reqres+0x2c/0x6c)
[<c05025b8>] (gpiochip_irq_reqres) from [<c01a8010>] (__setup_irq+0x46c/0x6e0)
[<c01a8010>] (__setup_irq) from [<c01a83dc>] (request_threaded_irq+0xcc/0x14c)
[<c01a83dc>] (request_threaded_irq) from [<c0640cb4>] (smc_probe+0x4c0/0xb58)
[<c0640cb4>] (smc_probe) from [<c0641604>] (smc_drv_probe+0x2b8/0x410)
[<c0641604>] (smc_drv_probe) from [<c0584fe8>] (platform_drv_probe+0x50/0xb0)
[<c0584fe8>] (platform_drv_probe) from [<c058308c>] (driver_probe_device+0x260/0x2e8)
[<c058308c>] (driver_probe_device) from [<c05815c4>] (bus_for_each_drv+0x64/0x98)
[<c05815c4>] (bus_for_each_drv) from [<c0582d48>] (__device_attach+0xb0/0x118)
[<c0582d48>] (__device_attach) from [<c05823c4>] (bus_probe_device+0x88/0x90)
[<c05823c4>] (bus_probe_device) from [<c0580768>] (device_add+0x3c8/0x57c)
[<c0580768>] (device_add) from [<c069801c>] (of_platform_device_create_pdata+0x70/0xa4)
[<c069801c>] (of_platform_device_create_pdata) from [<c069d85c>] (gpmc_probe_generic_child+0x98/0x8b4)
[<c069d85c>] (gpmc_probe_generic_child) from [<c069e500>] (gpmc_probe+0x488/0x644)
[<c069e500>] (gpmc_probe) from [<c0584fe8>] (platform_drv_probe+0x50/0xb0)
[<c0584fe8>] (platform_drv_probe) from [<c058308c>] (driver_probe_device+0x260/0x2e8)
[<c058308c>] (driver_probe_device) from [<c05815c4>] (bus_for_each_drv+0x64/0x98)
[<c05815c4>] (bus_for_each_drv) from [<c0582d48>] (__device_attach+0xb0/0x118)
[<c0582d48>] (__device_attach) from [<c05823c4>] (bus_probe_device+0x88/0x90)
[<c05823c4>] (bus_probe_device) from [<c0582850>] (deferred_probe_work_func+0x6c/0x9c)
[<c0582850>] (deferred_probe_work_func) from [<c0155b14>] (process_one_work+0x2b0/0x774)
[<c0155b14>] (process_one_work) from [<c0156d64>] (worker_thread+0x22c/0x540)
[<c0156d64>] (worker_thread) from [<c015c760>] (kthread+0x110/0x150)
[<c015c760>] (kthread) from [<c01077d0>] (ret_from_fork+0x14/0x24)
---[ end trace ab200d44646e143b ]---

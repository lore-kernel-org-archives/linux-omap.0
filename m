From: Ming Lei <tom.leiming@gmail.com>
Subject: omap3: I2C: failure in wakeup from S2R
Date: Wed, 21 Sep 2011 15:15:58 +0800
Message-ID: <CACVXFVMREddue6siSBopiZ28M70FELJwLa90jG4oxXCBHDcyzw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gw0-f52.google.com ([74.125.83.52]:47200 "EHLO
	mail-gw0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752379Ab1IUHQA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 Sep 2011 03:16:00 -0400
Received: by gwb1 with SMTP id 1so1389402gwb.11
        for <linux-omap@vger.kernel.org>; Wed, 21 Sep 2011 00:15:59 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, Kevin Hilman <khilman@ti.com>
Cc: linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

Hi,

Looks like beagle xM can't wakeup from S2R, and the kernel is 3.1-rc4.

See dmesg below:

root@beagleboard:~#
root@beagleboard:~# echo 9 > /proc/sys/kernel/printk
root@beagleboard:~# echo platform > /sys/power/pm_test
root@beagleboard:~# echo mem > /sys/power/state
[   69.132354] PM: Syncing filesystems ... done.
[   78.607269] PM: Preparing system for mem sleep
[   78.631347] Freezing user space processes ... (elapsed 0.02 seconds) done.
[   78.664215] Freezing remaining freezable tasks ... (elapsed 0.02
seconds) done.
[   78.695129] PM: Entering mem sleep
[   78.712402] usb 1-2.1: usb suspend
[   78.739471] hub 1-2:1.0: hub_suspend
[   78.743652] usb 1-2: unlink qh256-0001/def54320 start 1 [1/0 us]
[   78.751007] usb 1-2: usb suspend
[   78.778625] hub 1-0:1.0: hub_suspend
[   78.782440] usb usb1: bus suspend
[   78.786163] ehci-omap ehci-omap.0: suspend root hub
[   78.916076] PM: suspend of devices complete after 206.665 msecs
[   78.928649] omap_device: omap_hsmmc.0: new worst case deactivate
latency 0: 152587
[   78.937438] omap_device: usbhs_omap.-1: new worst case deactivate
latency 0: 152587
[   78.946044] PM: late suspend of devices complete after 23.620 msecs
[   78.952728] suspend debug: Waiting for 5 seconds.
[   83.395080] PM: early resume of devices complete after 3.936 msecs
[   83.405548] ------------[ cut here ]------------
[   83.410430] WARNING: at arch/arm/mach-omap2/omap_l3_smx.c:162
omap3_l3_app_irq+0x114/0x15c()
[   83.419281] In-band Error seen by MPU  at address 0
[   83.424377] Modules linked in:
[   83.427612] [<c001ada8>] (unwind_backtrace+0x0/0x124) from
[<c004f1ac>] (warn_slowpath_common+0x54/0x6c)
[   83.437591] [<c004f1ac>] (warn_slowpath_common+0x54/0x6c) from
[<c004f25c>] (warn_slowpath_fmt+0x34/0x44)
[   83.447631] [<c004f25c>] (warn_slowpath_fmt+0x34/0x44) from
[<c0032298>] (omap3_l3_app_irq+0x114/0x15c)
[   83.457489] [<c0032298>] (omap3_l3_app_irq+0x114/0x15c) from
[<c0097c4c>] (handle_irq_event_percpu+0xb8/0x280)
[   83.467987] [<c0097c4c>] (handle_irq_event_percpu+0xb8/0x280) from
[<c0097e58>] (handle_irq_event+0x44/0x64)
[   83.478271] [<c0097e58>] (handle_irq_event+0x44/0x64) from
[<c009a2bc>] (handle_level_irq+0xe0/0x114)
[   83.487945] [<c009a2bc>] (handle_level_irq+0xe0/0x114) from
[<c0097678>] (generic_handle_irq+0x28/0x38)
[   83.497833] [<c0097678>] (generic_handle_irq+0x28/0x38) from
[<c0014098>] (handle_IRQ+0x80/0xc0)
[   83.507049] [<c0014098>] (handle_IRQ+0x80/0xc0) from [<c04072fc>]
(__irq_svc+0x3c/0x11c)
[   83.515563] [<c04072fc>] (__irq_svc+0x3c/0x11c) from [<c0319a80>]
(omap_i2c_unidle+0x1e8/0x2ac)
[   83.524688] [<c0319a80>] (omap_i2c_unidle+0x1e8/0x2ac) from
[<c031a144>] (omap_i2c_xfer+0x2c/0x36c)
[   83.534179] [<c031a144>] (omap_i2c_xfer+0x2c/0x36c) from
[<c0317cc4>] (i2c_transfer+0xc0/0x150)
[   83.543304] [<c0317cc4>] (i2c_transfer+0xc0/0x150) from
[<c02b2014>] (twl_i2c_write+0xcc/0x114)
[   83.552429] [<c02b2014>] (twl_i2c_write+0xcc/0x114) from
[<c02b255c>] (twl4030_sih_do_mask+0x6c/0x9c)
[   83.562103] [<c02b255c>] (twl4030_sih_do_mask+0x6c/0x9c) from
[<c0069b7c>] (process_one_work+0x2dc/0x500)
[   83.572174] [<c0069b7c>] (process_one_work+0x2dc/0x500) from
[<c006a2a8>] (worker_thread+0x1c0/0x2d8)
[   83.581848] [<c006a2a8>] (worker_thread+0x1c0/0x2d8) from
[<c006e0b0>] (kthread+0x8c/0x94)
[   83.590515] [<c006e0b0>] (kthread+0x8c/0x94) from [<c00142c0>]
(kernel_thread_exit+0x0/0x8)
[   83.599243] ---[ end trace 1b75b31a2719ed1e ]---
[   83.617126] ------------[ cut here ]------------
[   83.622009] WARNING: at arch/arm/mach-omap2/omap_l3_smx.c:162
omap3_l3_app_irq+0x114/0x15c()
[   83.630859] In-band Error seen by MPU  at address 0
[   83.635955] Modules linked in:
[   83.639190] [<c001ada8>] (unwind_backtrace+0x0/0x124) from
[<c004f1ac>] (warn_slowpath_common+0x54/0x6c)
[   83.649169] [<c004f1ac>] (warn_slowpath_common+0x54/0x6c) from
[<c004f25c>] (warn_slowpath_fmt+0x34/0x44)
[   83.659210] [<c004f25c>] (warn_slowpath_fmt+0x34/0x44) from
[<c0032298>] (omap3_l3_app_irq+0x114/0x15c)
[   83.669067] [<c0032298>] (omap3_l3_app_irq+0x114/0x15c) from
[<c0097c4c>] (handle_irq_event_percpu+0xb8/0x280)
[   83.679595] [<c0097c4c>] (handle_irq_event_percpu+0xb8/0x280) from
[<c0097e58>] (handle_irq_event+0x44/0x64)
[   83.689910] [<c0097e58>] (handle_irq_event+0x44/0x64) from
[<c009a2bc>] (handle_level_irq+0xe0/0x114)
[   83.699584] [<c009a2bc>] (handle_level_irq+0xe0/0x114) from
[<c0097678>] (generic_handle_irq+0x28/0x38)
[   83.709442] [<c0097678>] (generic_handle_irq+0x28/0x38) from
[<c0014098>] (handle_IRQ+0x80/0xc0)
[   83.718688] [<c0014098>] (handle_IRQ+0x80/0xc0) from [<c04072fc>]
(__irq_svc+0x3c/0x11c)
[   83.727203] [<c04072fc>] (__irq_svc+0x3c/0x11c) from [<c0319ac8>]
(omap_i2c_unidle+0x230/0x2ac)
[   83.736328] [<c0319ac8>] (omap_i2c_unidle+0x230/0x2ac) from
[<c031a144>] (omap_i2c_xfer+0x2c/0x36c)
[   83.745819] [<c031a144>] (omap_i2c_xfer+0x2c/0x36c) from
[<c0317cc4>] (i2c_transfer+0xc0/0x150)
[   83.754943] [<c0317cc4>] (i2c_transfer+0xc0/0x150) from
[<c02b2014>] (twl_i2c_write+0xcc/0x114)
[   83.764068] [<c02b2014>] (twl_i2c_write+0xcc/0x114) from
[<c02b255c>] (twl4030_sih_do_mask+0x6c/0x9c)
[   83.773742] [<c02b255c>] (twl4030_sih_do_mask+0x6c/0x9c) from
[<c0069b7c>] (process_one_work+0x2dc/0x500)
[   83.783813] [<c0069b7c>] (process_one_work+0x2dc/0x500) from
[<c006a2a8>] (worker_thread+0x1c0/0x2d8)
[   83.793487] [<c006a2a8>] (worker_thread+0x1c0/0x2d8) from
[<c006e0b0>] (kthread+0x8c/0x94)
[   83.802154] [<c006e0b0>] (kthread+0x8c/0x94) from [<c00142c0>]
(kernel_thread_exit+0x0/0x8)
[   83.810913] ---[ end trace 1b75b31a2719ed1f ]---
[   83.816131] ------------[ cut here ]------------
[   83.820983] WARNING: at arch/arm/mach-omap2/omap_l3_smx.c:162
omap3_l3_app_irq+0x114/0x15c()
[   83.829833] In-band Error seen by MPU  at address 0
[   83.834930] Modules linked in:
[   83.838165] [<c001ada8>] (unwind_backtrace+0x0/0x124) from
[<c004f1ac>] (warn_slowpath_common+0x54/0x6c)
[   83.848114] [<c004f1ac>] (warn_slowpath_common+0x54/0x6c) from
[<c004f25c>] (warn_slowpath_fmt+0x34/0x44)
[   83.858154] [<c004f25c>] (warn_slowpath_fmt+0x34/0x44) from
[<c0032298>] (omap3_l3_app_irq+0x114/0x15c)
[   83.868041] [<c0032298>] (omap3_l3_app_irq+0x114/0x15c) from
[<c0097c4c>] (handle_irq_event_percpu+0xb8/0x280)
[   83.878540] [<c0097c4c>] (handle_irq_event_percpu+0xb8/0x280) from
[<c0097e58>] (handle_irq_event+0x44/0x64)
[   83.888824] [<c0097e58>] (handle_irq_event+0x44/0x64) from
[<c009a2bc>] (handle_level_irq+0xe0/0x114)
[   83.898498] [<c009a2bc>] (handle_level_irq+0xe0/0x114) from
[<c0097678>] (generic_handle_irq+0x28/0x38)
[   83.908325] [<c0097678>] (generic_handle_irq+0x28/0x38) from
[<c0014098>] (handle_IRQ+0x80/0xc0)
[   83.917572] [<c0014098>] (handle_IRQ+0x80/0xc0) from [<c04072fc>]
(__irq_svc+0x3c/0x11c)
[   83.926055] [<c04072fc>] (__irq_svc+0x3c/0x11c) from [<c031a144>]
(omap_i2c_xfer+0x2c/0x36c)
[   83.934936] [<c031a144>] (omap_i2c_xfer+0x2c/0x36c) from
[<c0317cc4>] (i2c_transfer+0xc0/0x150)
[   83.944061] [<c0317cc4>] (i2c_transfer+0xc0/0x150) from
[<c02b2014>] (twl_i2c_write+0xcc/0x114)
[   83.953186] [<c02b2014>] (twl_i2c_write+0xcc/0x114) from
[<c02b255c>] (twl4030_sih_do_mask+0x6c/0x9c)
[   83.962829] [<c02b255c>] (twl4030_sih_do_mask+0x6c/0x9c) from
[<c0069b7c>] (process_one_work+0x2dc/0x500)
[   83.972900] [<c0069b7c>] (process_one_work+0x2dc/0x500) from
[<c006a2a8>] (worker_thread+0x1c0/0x2d8)
[   83.982543] [<c006a2a8>] (worker_thread+0x1c0/0x2d8) from
[<c006e0b0>] (kthread+0x8c/0x94)
[   83.991210] [<c006e0b0>] (kthread+0x8c/0x94) from [<c00142c0>]
(kernel_thread_exit+0x0/0x8)
[   83.999969] ---[ end trace 1b75b31a2719ed20 ]---
[   84.004974] Unhandled fault: external abort on non-linefetch
(0x1028) at 0xfa070008
[   84.013000] Internal error: : 1028 [#1] PREEMPT SMP
[   84.018127] Modules linked in:
[   84.021331] CPU: 0    Tainted: G        W    (3.1.0-rc4+ #226)
[   84.027435] PC is at omap_i2c_wait_for_bb+0x6c/0x84
[   84.032562] LR is at omap_i2c_wait_for_bb+0x20/0x84
[   84.037689] pc : [<c0319880>]    lr : [<c0319834>]    psr: 20000013
[   84.037689] sp : def43e80  ip : 00000000  fp : c0f6045c
[   84.049682] r10: 00000001  r9 : decee8b8  r8 : 00000001
[   84.055145] r7 : c0f605d8  r6 : decee800  r5 : ffff949d  r4 : decee800
[   84.061981] r3 : 00000008  r2 : fa070000  r1 : 83126e98  r0 : 00000080
[   84.068847] Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM
Segment kernel
[   84.076507] Control: 10c5387d  Table: 9e44c019  DAC: 00000015
[   84.082519] Process kworker/u:2 (pid: 480, stack limit = 0xdef422f8)
[   84.089172] Stack: (0xdef43e80 to 0xdef44000)
[   84.093749] 3e80: 0000001f decee868 c0f605d8 c031a14c 00000001
def42000 def43eac c04090cc
[   84.102355] 3ea0: c0f605f4 60000013 c0f6045c decee868 00000000
ffff93d0 c0f605d8 00000001
[   84.110900] 3ec0: 00000002 00000000 c0f6045c c0317cc4 decf7c00
def43f1c c0f605f0 0000002f
[   84.119476] 3ee0: c0f60454 00000174 c07c4c18 c02b2014 00000001
c043915f ded23bd0 c09e05c0
[   84.128051] 3f00: decf2400 00000000 00000000 00000002 c02b24f0
c02b255c ded23bd0 fffff22f
[   84.136627] 3f20: c07d5a24 deecb1e0 ded23bd0 c0069b7c 00000002
00000000 c0069a8c c0080a18
[   84.145202] 3f40: ded4a120 00000000 c0f606bc 00000000 00000000
c0545f89 00000000 00000000
[   84.153808] 3f60: 00000001 deecb1e0 c09e05c0 deecb1f0 c09e05c0
c09e05c0 00000000 00000089
[   84.162353] 3f80: 00000000 c006a2a8 00000000 dec81edc deecb1e0
c006a0e8 00000013 00000000
[   84.170928] 3fa0: 00000000 c006e0b0 00000000 deecb1e0 00000000
00000000 00000000 dead4ead
[   84.179504] 3fc0: ffffffff ffffffff c09e0bd8 00000000 00000000
c053aec3 00000000 00000000
[   84.188110] 3fe0: def43fe0 def43fe0 dec81edc c006e024 c00142c0
c00142c0 00000000 00000000
[   84.196685] [<c0319880>] (omap_i2c_wait_for_bb+0x6c/0x84) from
[<c031a14c>] (omap_i2c_xfer+0x34/0x36c)
[   84.206451] [<c031a14c>] (omap_i2c_xfer+0x34/0x36c) from
[<c0317cc4>] (i2c_transfer+0xc0/0x150)
[   84.215576] [<c0317cc4>] (i2c_transfer+0xc0/0x150) from
[<c02b2014>] (twl_i2c_write+0xcc/0x114)
[   84.224700] [<c02b2014>] (twl_i2c_write+0xcc/0x114) from
[<c02b255c>] (twl4030_sih_do_mask+0x6c/0x9c)
[   84.234374] [<c02b255c>] (twl4030_sih_do_mask+0x6c/0x9c) from
[<c0069b7c>] (process_one_work+0x2dc/0x500)
[   84.244415] [<c0069b7c>] (process_one_work+0x2dc/0x500) from
[<c006a2a8>] (worker_thread+0x1c0/0x2d8)
[   84.254089] [<c006a2a8>] (worker_thread+0x1c0/0x2d8) from
[<c006e0b0>] (kthread+0x8c/0x94)
[   84.262756] [<c006e0b0>] (kthread+0x8c/0x94) from [<c00142c0>]
(kernel_thread_exit+0x0/0x8)
[   84.271484] Code: e5d32002 e594300c e1a03312 e5942004 (e19200b3)
[   84.277893] ------------[ cut here ]------------
[   84.282745] WARNING: at arch/arm/mach-omap2/omap_l3_smx.c:162
omap3_l3_app_irq+0x114/0x15c()
[   84.291595] In-band Error seen by MPU  at address 0
[   84.296691] Modules linked in:
[   84.299926] [<c001ada8>] (unwind_backtrace+0x0/0x124) from
[<c004f1ac>] (warn_slowpath_common+0x54/0x6c)
[   84.309875] [<c004f1ac>] (warn_slowpath_common+0x54/0x6c) from
[<c004f25c>] (warn_slowpath_fmt+0x34/0x44)
[   84.319915] [<c004f25c>] (warn_slowpath_fmt+0x34/0x44) from
[<c0032298>] (omap3_l3_app_irq+0x114/0x15c)
[   84.329772] [<c0032298>] (omap3_l3_app_irq+0x114/0x15c) from
[<c0097c4c>] (handle_irq_event_percpu+0xb8/0x280)
[   84.340270] [<c0097c4c>] (handle_irq_event_percpu+0xb8/0x280) from
[<c0097e58>] (handle_irq_event+0x44/0x64)
[   84.350585] [<c0097e58>] (handle_irq_event+0x44/0x64) from
[<c009a2bc>] (handle_level_irq+0xe0/0x114)
[   84.360260] [<c009a2bc>] (handle_level_irq+0xe0/0x114) from
[<c0097678>] (generic_handle_irq+0x28/0x38)
[   84.370117] [<c0097678>] (generic_handle_irq+0x28/0x38) from
[<c0014098>] (handle_IRQ+0x80/0xc0)
[   84.379364] [<c0014098>] (handle_IRQ+0x80/0xc0) from [<c04072fc>]
(__irq_svc+0x3c/0x11c)
[   84.387847] [<c04072fc>] (__irq_svc+0x3c/0x11c) from [<c0407064>]
(_raw_spin_unlock_irq+0x34/0x58)
[   84.397247] [<c0407064>] (_raw_spin_unlock_irq+0x34/0x58) from
[<c00173d8>] (die+0x160/0x1e0)
[   84.406188] [<c00173d8>] (die+0x160/0x1e0) from [<c00088a0>]
(do_DataAbort+0x8c/0xa0)
[   84.414398] [<c00088a0>] (do_DataAbort+0x8c/0xa0) from [<c040729c>]
(__dabt_svc+0x3c/0x60)
[   84.423065] Exception stack(0xdef43e38 to 0xdef43e80)
[   84.428344] 3e20:
    00000080 83126e98
[   84.436920] 3e40: fa070000 00000008 decee800 ffff949d decee800
c0f605d8 00000001 decee8b8
[   84.445526] 3e60: 00000001 c0f6045c 00000000 def43e80 c0319834
c0319880 20000013 ffffffff
[   84.454101] [<c040729c>] (__dabt_svc+0x3c/0x60) from [<c0319880>]
(omap_i2c_wait_for_bb+0x6c/0x84)
[   84.463500] [<c0319880>] (omap_i2c_wait_for_bb+0x6c/0x84) from
[<c031a14c>] (omap_i2c_xfer+0x34/0x36c)
[   84.473266] [<c031a14c>] (omap_i2c_xfer+0x34/0x36c) from
[<c0317cc4>] (i2c_transfer+0xc0/0x150)
[   84.482391] [<c0317cc4>] (i2c_transfer+0xc0/0x150) from
[<c02b2014>] (twl_i2c_write+0xcc/0x114)
[   84.491485] [<c02b2014>] (twl_i2c_write+0xcc/0x114) from
[<c02b255c>] (twl4030_sih_do_mask+0x6c/0x9c)
[   84.501190] [<c02b255c>] (twl4030_sih_do_mask+0x6c/0x9c) from
[<c0069b7c>] (process_one_work+0x2dc/0x500)
[   84.511199] [<c0069b7c>] (process_one_work+0x2dc/0x500) from
[<c006a2a8>] (worker_thread+0x1c0/0x2d8)
[   84.520874] [<c006a2a8>] (worker_thread+0x1c0/0x2d8) from
[<c006e0b0>] (kthread+0x8c/0x94)
[   84.529541] [<c006e0b0>] (kthread+0x8c/0x94) from [<c00142c0>]
(kernel_thread_exit+0x0/0x8)
[   84.538299] ---[ end trace 1b75b31a2719ed21 ]---
[   84.543212] ---[ end trace 1b75b31a2719ed22 ]---
[   84.548309] Unable to handle kernel paging request at virtual
address fffffffc
[   84.555877] pgd = c0004000
[   84.558715] [fffffffc] *pgd=9f3fe821, *pte=00000000, *ppte=00000000
[   84.565307] Internal error: Oops: 17 [#2] PREEMPT SMP
[   84.570617] Modules linked in:
[   84.573822] CPU: 0    Tainted: G      D W    (3.1.0-rc4+ #226)
[   84.579956] PC is at kthread_data+0xc/0x14
[   84.584259] LR is at wq_worker_sleeping+0x14/0xb8
[   84.589172] pc : [<c006e3b0>]    lr : [<c006a414>]    psr: 00000193
[   84.589172] sp : def43cb0  ip : 00000000  fp : def43d4c
[   84.601226] r10: ded4a3a8  r9 : 00000000  r8 : ded4a32c
[   84.606689] r7 : 00000001  r6 : c14d5740  r5 : 00000000  r4 : c14d5740
[   84.613555] r3 : 00000000  r2 : 92696d3d  r1 : 00000000  r0 : ded4a120
[   84.620391] Flags: nzcv  IRQs off  FIQs on  Mode SVC_32  ISA ARM
Segment user
[   84.627960] Control: 10c5387d  Table: 9e44c019  DAC: 00000015
[   84.633972] Process kworker/u:2 (pid: 480, stack limit = 0xdef422f8)
[   84.640655] Stack: (0xdef43cb0 to 0xdef44000)
[   84.645202] 3ca0:                                     c14d5740
ded4a120 c14d5740 c04030bc
[   84.653808] 3cc0: c04070c4 c04070c4 c009d748 c009d748 c009d850
c00530f4 000005fe ded4af50
[   84.662384] 3ce0: c14d3bac c009d850 60000113 00000000 def050e4
c0083374 ded4af50 c14d3bac
[   84.670959] 3d00: c07ace00 c009d850 ded4a120 ded4a120 00000000
00000000 00000001 c0051aa8
[   84.679534] 3d20: 00000001 00000000 c0051760 ded4a120 00000001
dec40020 00000001 ded4a32c
[   84.688110] 3d40: ded4a118 00000001 c0f6045c c00530f4 def43d50
def43d50 def43e38 def42000
[   84.696685] 3d60: ded4a120 00000001 00001028 decee8b8 00000001
c001742c def422f8 0000000b
[   84.705291] 3d80: 00001028 c0784a30 fa070008 def43e38 c07849b0
c00088a0 00000000 00000001
[   84.713867] 3da0: 00000007 00000000 00000000 fa070008 00000009
c00834e8 00000000 c07ace00
[   84.722442] 3dc0: c005602c c005602c 00000001 ded4a120 def42000
c005602c 00000101 0000000a
[   84.731048] 3de0: c009e4d8 c009e4d8 def43e20 ded4a120 c00565dc
c00565dc c0407294 c0407294
[   84.739593] 3e00: def43e80 ded4a120 def42000 c0407294 def43e6c
00000001 decee8b8 00000001
[   84.748199] 3e20: c0319880 20000013 ffffffff def43e6c 00000001
c040729c 00000080 83126e98
[   84.756774] 3e40: fa070000 00000008 decee800 ffff949d decee800
c0f605d8 00000001 decee8b8
[   84.765350] 3e60: 00000001 c0f6045c 00000000 def43e80 c0319834
c0319880 20000013 ffffffff
[   84.773925] 3e80: 0000001f decee868 c0f605d8 c031a14c 00000001
def42000 def43eac c04090cc
[   84.782531] 3ea0: c0f605f4 60000013 c0f6045c decee868 00000000
ffff93d0 c0f605d8 00000001
[   84.791107] 3ec0: 00000002 00000000 c0f6045c c0317cc4 decf7c00
def43f1c c0f605f0 0000002f
[   84.799682] 3ee0: c0f60454 00000174 c07c4c18 c02b2014 00000001
c043915f ded23bd0 c09e05c0
[   84.808258] 3f00: decf2400 00000000 00000000 00000002 c02b24f0
c02b255c ded23bd0 fffff22f
[   84.816833] 3f20: c07d5a24 deecb1e0 ded23bd0 c0069b7c 00000002
00000000 c0069a8c c0080a18
[   84.825408] 3f40: ded4a120 00000000 c0f606bc 00000000 00000000
c0545f89 00000000 00000000
[   84.833984] 3f60: 00000001 deecb1e0 c09e05c0 deecb1f0 c09e05c0
c09e05c0 00000000 00000089
[   84.842559] 3f80: 00000000 c006a2a8 00000000 dec81edc deecb1e0
c006a0e8 00000013 00000000
[   84.851135] 3fa0: 00000000 c006e0b0 00000000 deecb1e0 00000001
00000000 00000000 dead4ead
[   84.859710] 3fc0: ffffffff ffffffff c09e0bd8 00000000 00000000
c053aec3 00000000 00000000
[   84.868286] 3fe0: def43fe0 def43fe0 dec81edc c006e024 c00142c0
c00142c0 00000000 00000000
[   84.876892] [<c006e3b0>] (kthread_data+0xc/0x14) from [<c006a414>]
(wq_worker_sleeping+0x14/0xb8)
[   84.886199] [<c006a414>] (wq_worker_sleeping+0x14/0xb8) from
[<c04030bc>] (schedule+0x13c/0x92c)
[   84.895416] [<c04030bc>] (schedule+0x13c/0x92c) from [<c00530f4>]
(do_exit+0x6b8/0x6f0)
[   84.903808] [<c00530f4>] (do_exit+0x6b8/0x6f0) from [<c001742c>]
(die+0x1b4/0x1e0)
[   84.911773] [<c001742c>] (die+0x1b4/0x1e0) from [<c00088a0>]
(do_DataAbort+0x8c/0xa0)
[   84.919982] [<c00088a0>] (do_DataAbort+0x8c/0xa0) from [<c040729c>]
(__dabt_svc+0x3c/0x60)
[   84.928649] Exception stack(0xdef43e38 to 0xdef43e80)
[   84.933929] 3e20:
    00000080 83126e98
[   84.942504] 3e40: fa070000 00000008 decee800 ffff949d decee800
c0f605d8 00000001 decee8b8
[   84.951080] 3e60: 00000001 c0f6045c 00000000 def43e80 c0319834
c0319880 20000013 ffffffff
[   84.959655] [<c040729c>] (__dabt_svc+0x3c/0x60) from [<c0319880>]
(omap_i2c_wait_for_bb+0x6c/0x84)
[   84.969055] [<c0319880>] (omap_i2c_wait_for_bb+0x6c/0x84) from
[<c031a14c>] (omap_i2c_xfer+0x34/0x36c)
[   84.978790] [<c031a14c>] (omap_i2c_xfer+0x34/0x36c) from
[<c0317cc4>] (i2c_transfer+0xc0/0x150)
[   84.987915] [<c0317cc4>] (i2c_transfer+0xc0/0x150) from
[<c02b2014>] (twl_i2c_write+0xcc/0x114)
[   84.997039] [<c02b2014>] (twl_i2c_write+0xcc/0x114) from
[<c02b255c>] (twl4030_sih_do_mask+0x6c/0x9c)
[   85.006713] [<c02b255c>] (twl4030_sih_do_mask+0x6c/0x9c) from
[<c0069b7c>] (process_one_work+0x2dc/0x500)
[   85.016754] [<c0069b7c>] (process_one_work+0x2dc/0x500) from
[<c006a2a8>] (worker_thread+0x1c0/0x2d8)
[   85.026428] [<c006a2a8>] (worker_thread+0x1c0/0x2d8) from
[<c006e0b0>] (kthread+0x8c/0x94)
[   85.035095] [<c006e0b0>] (kthread+0x8c/0x94) from [<c00142c0>]
(kernel_thread_exit+0x0/0x8)
[   85.043853] Code: c0411788 e52de004 e8bd4000 e590325c (e5130004)


-- 
Ming Lei

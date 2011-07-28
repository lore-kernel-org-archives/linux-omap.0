From: Cliff Brake <cliff.brake@gmail.com>
Subject: musb crash on suspend
Date: Thu, 28 Jul 2011 17:05:13 -0400
Message-ID: <CAOd_LFxPcid8rL8v_n6Q0E9u0iV9aKLmbYiVLFXQYoJfkUhB5Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yi0-f46.google.com ([209.85.218.46]:37031 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754678Ab1G1VFO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 Jul 2011 17:05:14 -0400
Received: by yia27 with SMTP id 27so2134337yia.19
        for <linux-omap@vger.kernel.org>; Thu, 28 Jul 2011 14:05:13 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux OMAP Mailing List <linux-omap@vger.kernel.org>

Hello, I'm running 2.6.39 on omap3530 with a number of patches and am
seeing the below crash on suspend.  Questions:

1) does anyone have musb suspending with 2.6.39?
2) are there any fixes or suggestions?

Thanks,
Cliff

musb-hdrc musb-hdrc: suspend
Unhandled fault: external abort on non-linefetch (0x1028) at 0xfa0ab00c
Internal error: : 1028 [#1] PREEMPT
last sysfs file: /sys/power/state
Modules linked in: mac80211 cfg80211
CPU: 0    Tainted: G        W    (2.6.39+ #182)
PC is at musb_save_context+0x14/0x150
LR is at musb_suspend+0x2c/0x60
pc : [<c02b18c8>]    lr : [<c02b1bd8>]    psr: 20000093
sp : cc26de48  ip : fb020000  fp : c05c34d8
r10: c06124d4  r9 : 00000000  r8 : 00000002
r7 : 00000000  r6 : 00000000  r5 : cc8d3e08  r4 : a0000013
r3 : 00000003  r2 : 00000001  r1 : fa0ab000  r0 : cc9380ec
Flags: nzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment user
Control: 10c5387d  Table: 8c014019  DAC: 00000015
Process sh (pid: 1884, stack limit = 0xcc26c2e8)
Stack: (0xcc26de48 to 0xcc26e000)
de40:                   a0000013 cc8d3e08 00000000 00000000 00000002 00000000
de60: c06124d4 c02b1bd8 cc842640 c023d948 cc842640 c0240a94 cc8d3e08 cc842640
de80: 00000000 00000000 cc8d3e08 00000002 00000000 cc8d3e3c c06124d4 c02414cc
dea0: cc8d3e08 00000002 cc8d3e08 00000000 cc8d3e68 00000002 c05e00d4 c0241918
dec0: 0bead162 00000007 0bead162 00000007 00000000 00000000 00000003 00000003
dee0: 00000004 c0413714 00000004 c0506ab1 000a3008 c0090ad4 c0506ab1 00000003
df00: 00000000 c0090d50 cc10f000 00000003 00000003 c0090364 cc812908 ccb3f818
df20: cc26df80 c042e650 ccb3f800 00000004 cc820b00 c01e00ec cc812908 c0118350
df40: 00000004 cc33db40 4006c000 cc26df80 00000004 cc26c000 00000000 c00c4a2c
df60: cc33db40 4006c000 cc33db40 4006c000 00000000 00000000 00000004 c00c4b60
df80: 00000000 00000000 00000004 00000000 00000004 4006c000 403525d0 00000004
dfa0: c003cf68 c003cdc0 00000004 4006c000 00000001 4006c000 00000004 00000000
dfc0: 00000004 4006c000 403525d0 00000004 00000004 000a33f0 00000001 000a3008
dfe0: 00000000 beff85c0 40290028 402e332c 60000010 00000001 80000801 10000500
[<c02b18c8>] (musb_save_context+0x14/0x150) from [<c02b1bd8>]
(musb_suspend+0x2c/0x60)
[<c02b1bd8>] (musb_suspend+0x2c/0x60) from [<c023d948>]
(platform_pm_suspend+0x2c/0x54)
[<c023d948>] (platform_pm_suspend+0x2c/0x54) from [<c0240a94>] (pm_op+0x4c/0xb4)
[<c0240a94>] (pm_op+0x4c/0xb4) from [<c02414cc>] (__device_suspend+0x134/0x1f0)
[<c02414cc>] (__device_suspend+0x134/0x1f0) from [<c0241918>]
(dpm_suspend_start+0x34c/0x458)
[<c0241918>] (dpm_suspend_start+0x34c/0x458) from [<c0090ad4>]
(suspend_devices_and_enter+0x3c/0x1f8)
[<c0090ad4>] (suspend_devices_and_enter+0x3c/0x1f8) from [<c0090d50>]
(enter_state+0xc0/0x128)
[<c0090d50>] (enter_state+0xc0/0x128) from [<c0090364>] (state_store+0xa0/0xb4)
[<c0090364>] (state_store+0xa0/0xb4) from [<c01e00ec>]
(kobj_attr_store+0x18/0x1c)
[<c01e00ec>] (kobj_attr_store+0x18/0x1c) from [<c0118350>]
(sysfs_write_file+0x108/0x13c)
[<c0118350>] (sysfs_write_file+0x108/0x13c) from [<c00c4a2c>]
(vfs_write+0xac/0x134)
[<c00c4a2c>] (vfs_write+0xac/0x134) from [<c00c4b60>] (sys_write+0x3c/0x68)
[<c00c4b60>] (sys_write+0x3c/0x68) from [<c003cdc0>] (ret_fast_syscall+0x0/0x30)
Code: e92d47f0 e3530002 e5901208 0a000005 (e1d130bc)
------------[ cut here ]------------
WARNING: at arch/arm/mach-omap2/omap_l3_smx.c:162 omap3_l3_app_irq+0xf8/0x150()
In-band Error Error seen by MPU  at address 0
Modules linked in: mac80211 cfg80211
[<c0041db0>] (unwind_backtrace+0x0/0xf0) from [<c0060e7c>]
(warn_slowpath_common+0x4c/0x64)
[<c0060e7c>] (warn_slowpath_common+0x4c/0x64) from [<c0060f14>]
(warn_slowpath_fmt+0x2c/0x3c)
[<c0060f14>] (warn_slowpath_fmt+0x2c/0x3c) from [<c00510cc>]
(omap3_l3_app_irq+0xf8/0x150)
[<c00510cc>] (omap3_l3_app_irq+0xf8/0x150) from [<c0092418>]
(handle_irq_event_percpu+0x30/0x180)
[<c0092418>] (handle_irq_event_percpu+0x30/0x180) from [<c00925c0>]
(handle_irq_event+0x58/0x80)
[<c00925c0>] (handle_irq_event+0x58/0x80) from [<c0094764>]
(handle_level_irq+0xd0/0x120)
[<c0094764>] (handle_level_irq+0xd0/0x120) from [<c0032074>]
(asm_do_IRQ+0x74/0x98)
[<c0032074>] (asm_do_IRQ+0x74/0x98) from [<c003c908>] (__irq_svc+0x48/0xb4)
Exception stack(0xcc26dca8 to 0xcc26dcf0)
dca0:                   00000000 c0602d88 cc26dcf0 00000080 c02b18ca cc26dd24
dcc0: c02b18cc 00000001 00000000 c04ff609 00000000 00000008 00000000 cc26dcf0
dce0: c0040270 c0040278 60000113 ffffffff
[<c003c908>] (__irq_svc+0x48/0xb4) from [<c0040278>] (die+0x224/0x2d8)
[<c0040278>] (die+0x224/0x2d8) from [<c0032310>] (do_DataAbort+0x80/0x94)
[<c0032310>] (do_DataAbort+0x80/0x94) from [<c003c8ac>] (__dabt_svc+0x4c/0x60)
Exception stack(0xcc26de00 to 0xcc26de48)
de00: cc9380ec fa0ab000 00000001 00000003 a0000013 cc8d3e08 00000000 00000000
de20: 00000002 00000000 c06124d4 c05c34d8 fb020000 cc26de48 c02b1bd8 c02b18c8
de40: 20000093 ffffffff
[<c003c8ac>] (__dabt_svc+0x4c/0x60) from [<c02b18c8>]
(musb_save_context+0x14/0x150)
[<c02b18c8>] (musb_save_context+0x14/0x150) from [<c02b1bd8>]
(musb_suspend+0x2c/0x60)
[<c02b1bd8>] (musb_suspend+0x2c/0x60) from [<c023d948>]
(platform_pm_suspend+0x2c/0x54)
[<c023d948>] (platform_pm_suspend+0x2c/0x54) from [<c0240a94>] (pm_op+0x4c/0xb4)
[<c0240a94>] (pm_op+0x4c/0xb4) from [<c02414cc>] (__device_suspend+0x134/0x1f0)
[<c02414cc>] (__device_suspend+0x134/0x1f0) from [<c0241918>]
(dpm_suspend_start+0x34c/0x458)
[<c0241918>] (dpm_suspend_start+0x34c/0x458) from [<c0090ad4>]
(suspend_devices_and_enter+0x3c/0x1f8)
[<c0090ad4>] (suspend_devices_and_enter+0x3c/0x1f8) from [<c0090d50>]
(enter_state+0xc0/0x128)
[<c0090d50>] (enter_state+0xc0/0x128) from [<c0090364>] (state_store+0xa0/0xb4)
[<c0090364>] (state_store+0xa0/0xb4) from [<c01e00ec>]
(kobj_attr_store+0x18/0x1c)
[<c01e00ec>] (kobj_attr_store+0x18/0x1c) from [<c0118350>]
(sysfs_write_file+0x108/0x13c)
[<c0118350>] (sysfs_write_file+0x108/0x13c) from [<c00c4a2c>]
(vfs_write+0xac/0x134)
[<c00c4a2c>] (vfs_write+0xac/0x134) from [<c00c4b60>] (sys_write+0x3c/0x68)
[<c00c4b60>] (sys_write+0x3c/0x68) from [<c003cdc0>] (ret_fast_syscall+0x0/0x30)
---[ end trace 1b75b31a2719ed1e ]---
---[ end trace 1b75b31a2719ed1f ]---
note: sh[1884] exited with preempt_count 1
BUG: scheduling while atomic: sh/1884/0x40000002
Modules linked in: mac80211 cfg80211
[<c0041db0>] (unwind_backtrace+0x0/0xf0) from [<c040d8cc>] (schedule+0x58/0x3c0)
[<c040d8cc>] (schedule+0x58/0x3c0) from [<c005b630>] (__cond_resched+0x24/0x34)
[<c005b630>] (__cond_resched+0x24/0x34) from [<c040dd58>]
(_cond_resched+0x30/0x40)
[<c040dd58>] (_cond_resched+0x30/0x40) from [<c00b0754>]
(unmap_vmas+0x6ac/0x770)
[<c00b0754>] (unmap_vmas+0x6ac/0x770) from [<c00b30a0>] (exit_mmap+0x114/0x274)
[<c00b30a0>] (exit_mmap+0x114/0x274) from [<c005ef74>] (mmput+0x34/0x108)
[<c005ef74>] (mmput+0x34/0x108) from [<c0062dd0>] (exit_mm+0x174/0x178)
[<c0062dd0>] (exit_mm+0x174/0x178) from [<c00648b4>] (do_exit+0x1d4/0x6a8)
[<c00648b4>] (do_exit+0x1d4/0x6a8) from [<c00402f0>] (die+0x29c/0x2d8)
[<c00402f0>] (die+0x29c/0x2d8) from [<c0032310>] (do_DataAbort+0x80/0x94)
[<c0032310>] (do_DataAbort+0x80/0x94) from [<c003c8ac>] (__dabt_svc+0x4c/0x60)
Exception stack(0xcc26de00 to 0xcc26de48)
de00: cc9380ec fa0ab000 00000001 00000003 a0000013 cc8d3e08 00000000 00000000
de20: 00000002 00000000 c06124d4 c05c34d8 fb020000 cc26de48 c02b1bd8 c02b18c8
de40: 20000093 ffffffff
[<c003c8ac>] (__dabt_svc+0x4c/0x60) from [<c02b18c8>]
(musb_save_context+0x14/0x150)
[<c02b18c8>] (musb_save_context+0x14/0x150) from [<c02b1bd8>]
(musb_suspend+0x2c/0x60)
[<c02b1bd8>] (musb_suspend+0x2c/0x60) from [<c023d948>]
(platform_pm_suspend+0x2c/0x54)
[<c023d948>] (platform_pm_suspend+0x2c/0x54) from [<c0240a94>] (pm_op+0x4c/0xb4)
[<c0240a94>] (pm_op+0x4c/0xb4) from [<c02414cc>] (__device_suspend+0x134/0x1f0)
[<c02414cc>] (__device_suspend+0x134/0x1f0) from [<c0241918>]
(dpm_suspend_start+0x34c/0x458)
[<c0241918>] (dpm_suspend_start+0x34c/0x458) from [<c0090ad4>]
(suspend_devices_and_enter+0x3c/0x1f8)
[<c0090ad4>] (suspend_devices_and_enter+0x3c/0x1f8) from [<c0090d50>]
(enter_state+0xc0/0x128)
[<c0090d50>] (enter_state+0xc0/0x128) from [<c0090364>] (state_store+0xa0/0xb4)
[<c0090364>] (state_store+0xa0/0xb4) from [<c01e00ec>]
(kobj_attr_store+0x18/0x1c)
[<c01e00ec>] (kobj_attr_store+0x18/0x1c) from [<c0118350>]
(sysfs_write_file+0x108/0x13c)
[<c0118350>] (sysfs_write_file+0x108/0x13c) from [<c00c4a2c>]
(vfs_write+0xac/0x134)
[<c00c4a2c>] (vfs_write+0xac/0x134) from [<c00c4b60>] (sys_write+0x3c/0x68)
[<c00c4b60>] (sys_write+0x3c/0x68) from [<c003cdc0>] (ret_fast_syscall+0x0/0x30)


-- 
=================
http://bec-systems.com

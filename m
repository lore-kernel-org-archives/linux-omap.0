From: "Joe Woodward" <jw@terrafix.co.uk>
Subject: OMAP3: PM/DSS2: Suspend broken with DSS2 in 3.1?
Date: Fri, 04 Nov 2011 13:17:34 +0000
Message-ID: <WC20111104131734.270227@terrafix.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp3.keele.netcentral.co.uk ([212.57.235.197]:60726 "EHLO
	smtp3.keele.netcentral.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751321Ab1KDOIF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Nov 2011 10:08:05 -0400
Received: from terrafix.co.uk (reverse.keele.netcentral.co.uk [212.57.249.250] (may be forged))
	by smtp3.keele.netcentral.co.uk (8.14.2/8.14.2) with ESMTP id pA4DHZmT007290
	for <linux-omap@vger.kernel.org>; Fri, 4 Nov 2011 13:17:40 GMT
Received: from WorldClient by terrafix.co.uk (MDaemon PRO v12.0.4)
	with ESMTP id md50002103982.msg
	for <linux-omap@vger.kernel.org>; Fri, 04 Nov 2011 13:17:35 +0000
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

I've just switched to the 3.1 mainline kernel from 3.0.4 and am noticing some problems.

I'm running a GUMSTIX Overo Fire (OMAP3530), with a GUMSTIX supplied PALO43 dev kit (to bring out 
USB/LAN/AUDIO/DISPLAY).

My config is roughly based on the omap2plus_defconfig with DSS2 built-in (rather than as a module).

When entering suspend with "echo mem > /sys/power/state" and waking by typing in to the terminal I get the 
following:

[   28.749542] PM: suspend of devices complete after 302.398 msecs
[   28.752655] omap_device: omap_hsmmc.1: new worst case deactivate latency 0: 152587
[   28.753448] PM: late suspend of devices complete after 3.845 msecs
[   28.754272] omap_device: omap_uart.1: new worst case deactivate latency 0: 61035
[   29.233276] omap_device: omap_uart.0: new worst case activate latency 0: 122070
[   29.233489] Successfully put all powerdomains to target state
[   29.233886] ------------[ cut here ]------------
[   29.233947] WARNING: at drivers/video/omap2/dss/dss.c:706 dss_runtime_get+0x60/0x64()
[   29.233978] Modules linked in:
[   29.234008] [<c0019958>] (unwind_backtrace+0x0/0xf8) from [<c003ddfc>] (warn_slowpath_common+0x54/0x64)
[   29.234069] [<c003ddfc>] (warn_slowpath_common+0x54/0x64) from [<c003de28>] (warn_slowpath_null+0x1c/0x24)
[   29.234100] [<c003de28>] (warn_slowpath_null+0x1c/0x24) from [<c01725ac>] (dss_runtime_get+0x60/0x64)
[   29.234130] [<c01725ac>] (dss_runtime_get+0x60/0x64) from [<c0172e10>] (dispc_runtime_resume+0x8/0xae0)
[   29.234161] [<c0172e10>] (dispc_runtime_resume+0x8/0xae0) from [<c01b8770>] 
(pm_generic_runtime_resume+0x2c/0x40)
[   29.234191] [<c01b8770>] (pm_generic_runtime_resume+0x2c/0x40) from [<c0030eb4>] (_od_resume_noirq+0x44/0x50)
[   29.234252] [<c0030eb4>] (_od_resume_noirq+0x44/0x50) from [<c01b93d0>] (pm_noirq_op.clone.5+0xa0/0x164)
[   29.234283] [<c01b93d0>] (pm_noirq_op.clone.5+0xa0/0x164) from [<c01b94ec>] (dpm_resume_noirq+0x58/0x17c)
[   29.234313] [<c01b94ec>] (dpm_resume_noirq+0x58/0x17c) from [<c0079dc8>] 
(suspend_devices_and_enter+0x100/0x230)
[   29.234344] [<c0079dc8>] (suspend_devices_and_enter+0x100/0x230) from [<c0079ffc>] (enter_state+0x104/0x124)
[   29.234374] [<c0079ffc>] (enter_state+0x104/0x124) from [<c0079578>] (state_store+0xd8/0x128)
[   29.234436] [<c0079578>] (state_store+0xd8/0x128) from [<c01476f4>] (kobj_attr_store+0x14/0x20)
[   29.234466] [<c01476f4>] (kobj_attr_store+0x14/0x20) from [<c01097c4>] (sysfs_write_file+0x100/0x180)
[   29.234497] [<c01097c4>] (sysfs_write_file+0x100/0x180) from [<c00be53c>] (vfs_write+0xb4/0x148)
[   29.234527] [<c00be53c>] (vfs_write+0xb4/0x148) from [<c00be7c4>] (sys_write+0x40/0x70)
[   29.234558] [<c00be7c4>] (sys_write+0x40/0x70) from [<c0013b80>] (ret_fast_syscall+0x0/0x3c)
[   29.234588] ---[ end trace 1b75b31a2719ed1e ]---
[   29.236511] PM: early resume of devices complete after 2.838 msecs

At which point the screen flickers for a second or so and I get the following:
[   30.069946] omapdss DISPC error: SYNC_LOST, disabling LCD
[   30.371978] omapdss DISPC error: SYNC_LOST, disabling LCD
[   30.711608] omapdss DISPC error: SYNC_LOST, disabling LCD
[   31.058898] omapdss DISPC error: SYNC_LOST, disabling LCD
[   31.406127] omapdss DISPC error: SYNC_LOST, disabling LCD
[   31.753448] omapdss DISPC error: SYNC_LOST, disabling LCD

Before the display normally (but not always) recovers.

Any subsequent suspends then also gives:
[   32.477813] PM: suspend of devices complete after 310.645 msecs
[   32.481323] Trying disable clock dss1_alwon_fck with 0 usecount
[   32.481323] ------------[ cut here ]------------
[   32.481384] WARNING: at arch/arm/plat-omap/clock.c:70 clk_disable+0x8c/0x94()
[   32.481384] Modules linked in:
[   32.481445] [<c0019958>] (unwind_backtrace+0x0/0xf8) from [<c003ddfc>] (warn_slowpath_common+0x54/0x64)
[   32.481506] [<c003ddfc>] (warn_slowpath_common+0x54/0x64) from [<c003de28>] (warn_slowpath_null+0x1c/0x24)
[   32.481536] [<c003de28>] (warn_slowpath_null+0x1c/0x24) from [<c002d500>] (clk_disable+0x8c/0x94)
[   32.481567] [<c002d500>] (clk_disable+0x8c/0x94) from [<c002368c>] (_disable_clocks+0x18/0x74)
[   32.481597] [<c002368c>] (_disable_clocks+0x18/0x74) from [<c002414c>] (_idle+0xcc/0x170)
[   32.481628] [<c002414c>] (_idle+0xcc/0x170) from [<c0024968>] (omap_hwmod_idle+0x24/0x40)
[   32.481658] [<c0024968>] (omap_hwmod_idle+0x24/0x40) from [<c003114c>] (omap_device_idle_hwmods+0x28/0x3c)
[   32.481689] [<c003114c>] (omap_device_idle_hwmods+0x28/0x3c) from [<c0030738>] 
(_omap_device_deactivate+0xc4/0x158)
[   32.481719] [<c0030738>] (_omap_device_deactivate+0xc4/0x158) from [<c0030ee0>] (omap_device_idle+0x20/0x6c)
[   32.481750] [<c0030ee0>] (omap_device_idle+0x20/0x6c) from [<c0030fa8>] (_od_suspend_noirq+0x58/0x68)
[   32.481811] [<c0030fa8>] (_od_suspend_noirq+0x58/0x68) from [<c01b93a4>] (pm_noirq_op.clone.5+0x74/0x164)
[   32.481842] [<c01b93a4>] (pm_noirq_op.clone.5+0x74/0x164) from [<c01b96f0>] (dpm_suspend_noirq+0xe0/0x1c4)
[   32.481872] [<c01b96f0>] (dpm_suspend_noirq+0xe0/0x1c4) from [<c0079d6c>] 
(suspend_devices_and_enter+0xa4/0x230)
[   32.481903] [<c0079d6c>] (suspend_devices_and_enter+0xa4/0x230) from [<c0079ffc>] (enter_state+0x104/0x124)
[   32.481933] [<c0079ffc>] (enter_state+0x104/0x124) from [<c0079578>] (state_store+0xd8/0x128)
[   32.481994] [<c0079578>] (state_store+0xd8/0x128) from [<c01476f4>] (kobj_attr_store+0x14/0x20)
[   32.482025] [<c01476f4>] (kobj_attr_store+0x14/0x20) from [<c01097c4>] (sysfs_write_file+0x100/0x180)
[   32.482055] [<c01097c4>] (sysfs_write_file+0x100/0x180) from [<c00be53c>] (vfs_write+0xb4/0x148)
[   32.482086] [<c00be53c>] (vfs_write+0xb4/0x148) from [<c00be7c4>] (sys_write+0x40/0x70)
[   32.482147] [<c00be7c4>] (sys_write+0x40/0x70) from [<c0013b80>] (ret_fast_syscall+0x0/0x3c)
[   32.482147] ---[ end trace 1b75b31a2719ed1f ]---
[   32.482299] omap_device: omapdss_dss.-1: new worst case deactivate latency 0: 976562
[   32.482513] PM: late suspend of devices complete after 4.669 msecs
[   32.688934] Successfully put all powerdomains to target state
[   32.689300] ------------[ cut here ]------------
[   32.689361] WARNING: at drivers/video/omap2/dss/dss.c:706 dss_runtime_get+0x60/0x64()
[   32.689361] Modules linked in:
[   32.689422] [<c0019958>] (unwind_backtrace+0x0/0xf8) from [<c003ddfc>] (warn_slowpath_common+0x54/0x64)
[   32.689453] [<c003ddfc>] (warn_slowpath_common+0x54/0x64) from [<c003de28>] (warn_slowpath_null+0x1c/0x24)
[   32.689483] [<c003de28>] (warn_slowpath_null+0x1c/0x24) from [<c01725ac>] (dss_runtime_get+0x60/0x64)
[   32.689514] [<c01725ac>] (dss_runtime_get+0x60/0x64) from [<c0172e10>] (dispc_runtime_resume+0x8/0xae0)
[   32.689544] [<c0172e10>] (dispc_runtime_resume+0x8/0xae0) from [<c01b8770>] 
(pm_generic_runtime_resume+0x2c/0x40)
[   32.689575] [<c01b8770>] (pm_generic_runtime_resume+0x2c/0x40) from [<c0030eb4>] (_od_resume_noirq+0x44/0x50)
[   32.689605] [<c0030eb4>] (_od_resume_noirq+0x44/0x50) from [<c01b93d0>] (pm_noirq_op.clone.5+0xa0/0x164)
[   32.689636] [<c01b93d0>] (pm_noirq_op.clone.5+0xa0/0x164) from [<c01b94ec>] (dpm_resume_noirq+0x58/0x17c)
[   32.689697] [<c01b94ec>] (dpm_resume_noirq+0x58/0x17c) from [<c0079dc8>] 
(suspend_devices_and_enter+0x100/0x230)
[   32.689727] [<c0079dc8>] (suspend_devices_and_enter+0x100/0x230) from [<c0079ffc>] (enter_state+0x104/0x124)
[   32.689758] [<c0079ffc>] (enter_state+0x104/0x124) from [<c0079578>] (state_store+0xd8/0x128)
[   32.689788] [<c0079578>] (state_store+0xd8/0x128) from [<c01476f4>] (kobj_attr_store+0x14/0x20)
[   32.689819] [<c01476f4>] (kobj_attr_store+0x14/0x20) from [<c01097c4>] (sysfs_write_file+0x100/0x180)
[   32.689849] [<c01097c4>] (sysfs_write_file+0x100/0x180) from [<c00be53c>] (vfs_write+0xb4/0x148)
[   32.689880] [<c00be53c>] (vfs_write+0xb4/0x148) from [<c00be7c4>] (sys_write+0x40/0x70)
[   32.689910] [<c00be7c4>] (sys_write+0x40/0x70) from [<c0013b80>] (ret_fast_syscall+0x0/0x3c)
[   32.689941] ---[ end trace 1b75b31a2719ed20 ]---
[   32.692016] PM: early resume of devices complete after 2.899 msecs
[   32.692108] ------------[ cut here ]------------
[   32.692138] WARNING: at arch/arm/mach-omap2/omap_l3_smx.c:162 omap3_l3_app_irq+0x128/0x164()
[   32.692169] In-band Error seen by MPU  at address 0
[   32.692169] Modules linked in:
[   32.692230] [<c0019958>] (unwind_backtrace+0x0/0xf8) from [<c003ddfc>] (warn_slowpath_common+0x54/0x64)
[   32.692260] [<c003ddfc>] (warn_slowpath_common+0x54/0x64) from [<c003dea0>] (warn_slowpath_fmt+0x30/0x40)
[   32.692291] [<c003dea0>] (warn_slowpath_fmt+0x30/0x40) from [<c002c58c>] (omap3_l3_app_irq+0x128/0x164)
[   32.692321] [<c002c58c>] (omap3_l3_app_irq+0x128/0x164) from [<c007b484>] (handle_irq_event_percpu+0x54/0x1a0)
[   32.692352] [<c007b484>] (handle_irq_event_percpu+0x54/0x1a0) from [<c007b60c>] (handle_irq_event+0x3c/0x5c)
[   32.692382] [<c007b60c>] (handle_irq_event+0x3c/0x5c) from [<c007cedc>] (handle_level_irq+0x90/0x10c)
[   32.692413] [<c007cedc>] (handle_level_irq+0x90/0x10c) from [<c007ae50>] (generic_handle_irq+0x34/0x44)
[   32.692474] [<c007ae50>] (generic_handle_irq+0x34/0x44) from [<c0014a54>] (handle_IRQ+0x38/0x84)
[   32.692504] [<c0014a54>] (handle_IRQ+0x38/0x84) from [<c0013738>] (__irq_svc+0x38/0x80)
[   32.692535] [<c0013738>] (__irq_svc+0x38/0x80) from [<c03487e4>] (_raw_spin_unlock_irqrestore+0x34/0x44)
[   32.692565] [<c03487e4>] (_raw_spin_unlock_irqrestore+0x34/0x44) from [<c007ecf0>] 
(resume_device_irqs+0x5c/0x7c)
[   32.692596] [<c007ecf0>] (resume_device_irqs+0x5c/0x7c) from [<c0079dc8>] 
(suspend_devices_and_enter+0x100/0x230)
[   32.692626] [<c0079dc8>] (suspend_devices_and_enter+0x100/0x230) from [<c0079ffc>] (enter_state+0x104/0x124)
[   32.692657] [<c0079ffc>] (enter_state+0x104/0x124) from [<c0079578>] (state_store+0xd8/0x128)
[   32.692687] [<c0079578>] (state_store+0xd8/0x128) from [<c01476f4>] (kobj_attr_store+0x14/0x20)
[   32.692718] [<c01476f4>] (kobj_attr_store+0x14/0x20) from [<c01097c4>] (sysfs_write_file+0x100/0x180)
[   32.692749] [<c01097c4>] (sysfs_write_file+0x100/0x180) from [<c00be53c>] (vfs_write+0xb4/0x148)
[   32.692779] [<c00be53c>] (vfs_write+0xb4/0x148) from [<c00be7c4>] (sys_write+0x40/0x70)
[   32.692810] [<c00be7c4>] (sys_write+0x40/0x70) from [<c0013b80>] (ret_fast_syscall+0x0/0x3c)
[   32.692840] ---[ end trace 1b75b31a2719ed21 ]---
[   33.045715] PM: resume of devices complete after 351.257 msecs

Has anyone else seen these problems?
I'm guessing there were some runtime PM changes for DSS2 between 3.0.4 and 3.1?

Cheers,
Joe



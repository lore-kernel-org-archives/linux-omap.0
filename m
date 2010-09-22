From: Laine Walker-Avina <lwalkera@pasco.com>
Subject: SYS_OFF_MODE signaling and CORE domain Transition to OFF Mode
Date: Wed, 22 Sep 2010 15:18:30 -0700
Message-ID: <AANLkTinmYY-tVqD77SMeE-YVZWuY-=yscaBNDSOYM=Ub@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:62880 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751818Ab0IVWSc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 Sep 2010 18:18:32 -0400
Received: by wwb34 with SMTP id 34so114284wwb.1
        for <linux-omap@vger.kernel.org>; Wed, 22 Sep 2010 15:18:30 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi all,

I'm having some troubles putting my OMAP3503(the one without the DSP
or SGX modules) board to sleep. I'm using the current master on the
l-o git repository.

This is the output from dmesg and the count file after suspending
twice. The first time it wakes immediately after going down, and the
second time stays asleep but says that the core domain didn't enter
OFF mode. In either case, the SYS_OFF_MODE signal never asserts. I
added some debug code into  map_sram_idle() to capture CM_CORE_IDLEST1
and 3 right before it jumps to the final sleep code in SRAM.

root@spark:~$ echo mem > /sys/power/state
[ =C2=A0530.299621] PM: Syncing filesystems ... done.
[ =C2=A0530.307556] PM: Preparing system for mem sleep
[ =C2=A0530.313995] PM: Adding info for No Bus:vcs63
[ =C2=A0530.317504] PM: Adding info for No Bus:vcsa63
[ =C2=A0530.353698] mmc0: card bed5 removed
[ =C2=A0530.357238] PM: Removing info for mmc:mmc0:bed5
[ =C2=A0530.369903] PM: Removing info for No Bus:mmcblk0p2
[ =C2=A0530.401275] PM: Removing info for No Bus:mmcblk0p1
[ =C2=A0530.409484] PM: Removing info for No Bus:179:0
[ =C2=A0530.445098] PM: Removing info for No Bus:mmcblk0
[ =C2=A0530.488220] ------------[ cut here ]------------
[ =C2=A0530.493255] WARNING: at drivers/regulator/core.c:1357
_regulator_disable+0x54/0x164()
[ =C2=A0530.501312] unbalanced disables for vMMC
[ =C2=A0530.505279] Modules linked in:
[ =C2=A0530.508605] [<c0237960>] (unwind_backtrace+0x0/0xf0) from
[<c025ae10>] (warn_slowpath_common+0x4c/0x64)
[ =C2=A0530.518310] [<c025ae10>] (warn_slowpath_common+0x4c/0x64) from
[<c025aea8>] (warn_slowpath_fmt+0x2c/0x3c)
[ =C2=A0530.528167] [<c025aea8>] (warn_slowpath_fmt+0x2c/0x3c) from
[<c03b9b40>] (_regulator_disable+0x54/0x164)
[ =C2=A0530.537902] [<c03b9b40>] (_regulator_disable+0x54/0x164) from
[<c03b9d3c>] (regulator_disable+0x20/0x34)
[ =C2=A0530.547668] [<c03b9d3c>] (regulator_disable+0x20/0x34) from
[<c042d158>] (omap_hsmmc_1_set_power+0x64/0xa0)
[ =C2=A0530.557678] [<c042d158>] (omap_hsmmc_1_set_power+0x64/0xa0) fro=
m
[<c042bd00>] (omap_hsmmc_set_ios+0x70/0x410)
[ =C2=A0530.567840] [<c042bd00>] (omap_hsmmc_set_ios+0x70/0x410) from
[<c0422144>] (mmc_power_off+0x50/0x54)
[ =C2=A0530.577270] [<c0422144>] (mmc_power_off+0x50/0x54) from
[<c0422b88>] (mmc_detach_bus+0x74/0xbc)
[ =C2=A0530.586212] [<c0422b88>] (mmc_detach_bus+0x74/0xbc) from
[<c04231d4>] (mmc_pm_notify+0x90/0xd8)
[ =C2=A0530.595184] [<c04231d4>] (mmc_pm_notify+0x90/0xd8) from
[<c0277954>] (notifier_call_chain+0x2c/0x70)
[ =C2=A0530.604614] [<c0277954>] (notifier_call_chain+0x2c/0x70) from
[<c0277db0>] (__blocking_notifier_call_chain+0x48/0x5c)
[ =C2=A0530.615509] [<c0277db0>] (__blocking_notifier_call_chain+0x48/0=
x5c)
from [<c0277dd8>] (blocking_notifier_call_chain+0x14/0x18)
[ =C2=A0530.627197] [<c0277dd8>] (blocking_notifier_call_chain+0x14/0x1=
8)
from [<c028ec1c>] (pm_notifier_call_chain+0x14/0x2c)
[ =C2=A0530.638183] [<c028ec1c>] (pm_notifier_call_chain+0x14/0x2c) fro=
m
[<c028f448>] (enter_state+0x7c/0x120)
[ =C2=A0530.647766] [<c028f448>] (enter_state+0x7c/0x120) from [<c028eb=
80>]
(state_store+0xa0/0xbc)
[ =C2=A0530.656402] [<c028eb80>] (state_store+0xa0/0xbc) from [<c0393e0=
8>]
(kobj_attr_store+0x18/0x1c)
[ =C2=A0530.665283] [<c0393e08>] (kobj_attr_store+0x18/0x1c) from
[<c0309244>] (sysfs_write_file+0x10c/0x140)
[ =C2=A0530.674774] [<c0309244>] (sysfs_write_file+0x10c/0x140) from
[<c02c09e4>] (vfs_write+0xac/0x134)
[ =C2=A0530.683837] [<c02c09e4>] (vfs_write+0xac/0x134) from [<c02c0b18=
>]
(sys_write+0x3c/0x68)
[ =C2=A0530.692077] [<c02c0b18>] (sys_write+0x3c/0x68) from [<c0231f40>=
]
(ret_fast_syscall+0x0/0x3c)
[ =C2=A0530.700744] ---[ end trace 7a172f77f33931a3 ]---
[ =C2=A0530.814514] Freezing user space processes ... (elapsed 0.01 sec=
onds) done.
[ =C2=A0530.839202] Freezing remaining freezable tasks ... (elapsed 0.0=
2
seconds) done.
[ =C2=A0530.870666] PM: Entering mem sleep
[ =C2=A0530.874908] Suspending console(s) (use no_console_suspend to de=
bug)
[ =C2=A0530.881652] platform reg-dummy: preparing suspend
[ =C2=A0530.881866] omapdss omapdss: preparing suspend
[ =C2=A0530.881927] reg-fixed-voltage reg-fixed-voltage.1: preparing su=
spend
[ =C2=A0530.881988] nop_usb_xceiv nop_usb_xceiv: preparing suspend
[ =C2=A0530.882049] serial8250 serial8250.0: preparing suspend
[ =C2=A0530.882110] serial8250 serial8250.1: preparing suspend
[ =C2=A0530.882141] serial8250 serial8250.2: preparing suspend
[ =C2=A0530.882202] musb_hdrc musb_hdrc: preparing suspend
[ =C2=A0530.882263] mmci-omap-hs mmci-omap-hs.0: preparing suspend
[ =C2=A0530.882324] mmci-omap-hs mmci-omap-hs.1: preparing suspend
[ =C2=A0530.882354] platform arm-pmu.0: preparing suspend
[ =C2=A0530.882415] omapfb omapfb: preparing suspend
[ =C2=A0530.884063] platform mpu.0: preparing suspend
[ =C2=A0530.884124] platform iva.0: preparing suspend
[ =C2=A0530.884185] platform l3_main.0: preparing suspend
[ =C2=A0530.884277] serial8250 serial8250: preparing suspend
[ =C2=A0530.885833] mmcblk mmc1:0001: legacy suspend
[ =C2=A0530.887176] serial8250 serial8250: suspend
[ =C2=A0530.887298] platform l3_main.0: suspend
[ =C2=A0530.887390] platform iva.0: suspend
[ =C2=A0530.887451] platform mpu.0: suspend
[ =C2=A0530.889007] omapfb omapfb: suspend
[ =C2=A0530.889068] platform arm-pmu.0: suspend
[ =C2=A0530.889129] mmci-omap-hs mmci-omap-hs.1: suspend
[ =C2=A0530.890258] ------------[ cut here ]------------
[ =C2=A0530.890350] WARNING: at drivers/regulator/core.c:1357
_regulator_disable+0x54/0x164()
[ =C2=A0530.890350] unbalanced disables for dummy
[ =C2=A0530.890380] Modules linked in:
[ =C2=A0530.890472] [<c0237960>] (unwind_backtrace+0x0/0xf0) from
[<c025ae10>] (warn_slowpath_common+0x4c/0x64)
[ =C2=A0530.890502] [<c025ae10>] (warn_slowpath_common+0x4c/0x64) from
[<c025aea8>] (warn_slowpath_fmt+0x2c/0x3c)
[ =C2=A0530.890563] [<c025aea8>] (warn_slowpath_fmt+0x2c/0x3c) from
[<c03b9b40>] (_regulator_disable+0x54/0x164)
[ =C2=A0530.890625] [<c03b9b40>] (_regulator_disable+0x54/0x164) from
[<c03b9d3c>] (regulator_disable+0x20/0x34)
[ =C2=A0530.890655] [<c03b9d3c>] (regulator_disable+0x20/0x34) from
[<c042d0b8>] (omap_hsmmc_23_set_power+0xb4/0xf0)
[ =C2=A0530.890686] [<c042d0b8>] (omap_hsmmc_23_set_power+0xb4/0xf0) fr=
om
[<c042bd00>] (omap_hsmmc_set_ios+0x70/0x410)
[ =C2=A0530.890930] [<c042bd00>] (omap_hsmmc_set_ios+0x70/0x410) from
[<c0422144>] (mmc_power_off+0x50/0x54)
[ =C2=A0530.890991] [<c0422144>] (mmc_power_off+0x50/0x54) from
[<c0422ad0>] (mmc_suspend_host+0x128/0x134)
[ =C2=A0530.891052] [<c0422ad0>] (mmc_suspend_host+0x128/0x134) from
[<c042b69c>] (omap_hsmmc_suspend+0x60/0x108)
[ =C2=A0530.891113] [<c042b69c>] (omap_hsmmc_suspend+0x60/0x108) from
[<c03dd21c>] (platform_pm_suspend+0x2c/0x54)
[ =C2=A0530.891143] [<c03dd21c>] (platform_pm_suspend+0x2c/0x54) from
[<c03df918>] (pm_op+0x4c/0xb4)
[ =C2=A0530.891204] [<c03df918>] (pm_op+0x4c/0xb4) from [<c03e0490>]
(__device_suspend+0x140/0x1c0)
[ =C2=A0530.891235] [<c03e0490>] (__device_suspend+0x140/0x1c0) from
[<c03e08c4>] (dpm_suspend_start+0x368/0x49c)
[ =C2=A0530.891296] [<c03e08c4>] (dpm_suspend_start+0x368/0x49c) from
[<c028f214>] (suspend_devices_and_enter+0x48/0x200)
[ =C2=A0530.891357] [<c028f214>] (suspend_devices_and_enter+0x48/0x200)
from [<c028f488>] (enter_state+0xbc/0x120)
[ =C2=A0530.891387] [<c028f488>] (enter_state+0xbc/0x120) from [<c028eb=
80>]
(state_store+0xa0/0xbc)
[ =C2=A0530.891448] [<c028eb80>] (state_store+0xa0/0xbc) from [<c0393e0=
8>]
(kobj_attr_store+0x18/0x1c)
[ =C2=A0530.891479] [<c0393e08>] (kobj_attr_store+0x18/0x1c) from
[<c0309244>] (sysfs_write_file+0x10c/0x140)
[ =C2=A0530.891540] [<c0309244>] (sysfs_write_file+0x10c/0x140) from
[<c02c09e4>] (vfs_write+0xac/0x134)
[ =C2=A0530.891571] [<c02c09e4>] (vfs_write+0xac/0x134) from [<c02c0b18=
>]
(sys_write+0x3c/0x68)
[ =C2=A0530.891632] [<c02c0b18>] (sys_write+0x3c/0x68) from [<c0231f40>=
]
(ret_fast_syscall+0x0/0x3c)
[ =C2=A0530.891662] ---[ end trace 7a172f77f33931a4 ]---
[ =C2=A0530.891815] mmci-omap-hs mmci-omap-hs.0: suspend
[ =C2=A0530.892517] musb_hdrc musb_hdrc: suspend
[ =C2=A0530.892852] serial8250 serial8250.2: suspend
[ =C2=A0530.893707] serial8250 serial8250.1: suspend
[ =C2=A0530.893829] serial8250 serial8250.0: suspend
[ =C2=A0530.893920] nop_usb_xceiv nop_usb_xceiv: suspend
[ =C2=A0530.893981] reg-fixed-voltage reg-fixed-voltage.1: suspend
[ =C2=A0530.894042] omapdss omapdss: suspend
[ =C2=A0530.907653] ------------[ cut here ]------------
[ =C2=A0530.907745] WARNING: at drivers/regulator/core.c:1357
_regulator_disable+0x54/0x164()
[ =C2=A0530.907745] unbalanced disables for dummy
[ =C2=A0530.907775] Modules linked in:
[ =C2=A0530.907836] [<c0237960>] (unwind_backtrace+0x0/0xf0) from
[<c025ae10>] (warn_slowpath_common+0x4c/0x64)
[ =C2=A0530.907897] [<c025ae10>] (warn_slowpath_common+0x4c/0x64) from
[<c025aea8>] (warn_slowpath_fmt+0x2c/0x3c)
[ =C2=A0530.907958] [<c025aea8>] (warn_slowpath_fmt+0x2c/0x3c) from
[<c03b9b40>] (_regulator_disable+0x54/0x164)
[ =C2=A0530.907989] [<c03b9b40>] (_regulator_disable+0x54/0x164) from
[<c03b9d3c>] (regulator_disable+0x20/0x34)
[ =C2=A0530.908050] [<c03b9d3c>] (regulator_disable+0x20/0x34) from
[<c03b2060>] (omapdss_dpi_display_disable+0x2c/0x3c)
[ =C2=A0530.908111] [<c03b2060>] (omapdss_dpi_display_disable+0x2c/0x3c=
)
from [<c03b769c>] (generic_panel_suspend+0xc/0x1c)
[ =C2=A0530.908142] [<c03b769c>] (generic_panel_suspend+0xc/0x1c) from
[<c03af0c0>] (dss_suspend_device+0x44/0x54)
[ =C2=A0530.908203] [<c03af0c0>] (dss_suspend_device+0x44/0x54) from
[<c03dbaa8>] (bus_for_each_dev+0x48/0x84)
[ =C2=A0530.908233] [<c03dbaa8>] (bus_for_each_dev+0x48/0x84) from
[<c03af21c>] (dss_suspend_all_devices+0x18/0x30)
[ =C2=A0530.908294] [<c03af21c>] (dss_suspend_all_devices+0x18/0x30) fr=
om
[<c03dd238>] (platform_pm_suspend+0x48/0x54)
[ =C2=A0530.908325] [<c03dd238>] (platform_pm_suspend+0x48/0x54) from
[<c03df918>] (pm_op+0x4c/0xb4)
[ =C2=A0530.908386] [<c03df918>] (pm_op+0x4c/0xb4) from [<c03e0490>]
(__device_suspend+0x140/0x1c0)
[ =C2=A0530.908416] [<c03e0490>] (__device_suspend+0x140/0x1c0) from
[<c03e08c4>] (dpm_suspend_start+0x368/0x49c)
[ =C2=A0530.908477] [<c03e08c4>] (dpm_suspend_start+0x368/0x49c) from
[<c028f214>] (suspend_devices_and_enter+0x48/0x200)
[ =C2=A0530.908538] [<c028f214>] (suspend_devices_and_enter+0x48/0x200)
from [<c028f488>] (enter_state+0xbc/0x120)
[ =C2=A0530.908569] [<c028f488>] (enter_state+0xbc/0x120) from [<c028eb=
80>]
(state_store+0xa0/0xbc)
[ =C2=A0530.908599] [<c028eb80>] (state_store+0xa0/0xbc) from [<c0393e0=
8>]
(kobj_attr_store+0x18/0x1c)
[ =C2=A0530.908660] [<c0393e08>] (kobj_attr_store+0x18/0x1c) from
[<c0309244>] (sysfs_write_file+0x10c/0x140)
[ =C2=A0530.908721] [<c0309244>] (sysfs_write_file+0x10c/0x140) from
[<c02c09e4>] (vfs_write+0xac/0x134)
[ =C2=A0530.908752] [<c02c09e4>] (vfs_write+0xac/0x134) from [<c02c0b18=
>]
(sys_write+0x3c/0x68)
[ =C2=A0530.908782] [<c02c0b18>] (sys_write+0x3c/0x68) from [<c0231f40>=
]
(ret_fast_syscall+0x0/0x3c)
[ =C2=A0530.908813] ---[ end trace 7a172f77f33931a5 ]---
[ =C2=A0530.909088] platform reg-dummy: suspend
[ =C2=A0530.909393] PM: suspend of devices complete after 23.890 msecs
[ =C2=A0530.910949] serial8250 serial8250: LATE suspend
[ =C2=A0530.910980] platform l3_main.0: LATE suspend
[ =C2=A0530.911010] platform iva.0: LATE suspend
[ =C2=A0530.911041] platform mpu.0: LATE suspend
[ =C2=A0530.911132] omapfb omapfb: LATE suspend
[ =C2=A0530.911163] platform arm-pmu.0: LATE suspend
[ =C2=A0530.911163] mmci-omap-hs mmci-omap-hs.1: LATE suspend
[ =C2=A0530.911193] mmci-omap-hs mmci-omap-hs.0: LATE suspend
[ =C2=A0530.911224] musb_hdrc musb_hdrc: LATE suspend
[ =C2=A0530.911224] serial8250 serial8250.2: LATE suspend
[ =C2=A0530.911254] serial8250 serial8250.1: LATE suspend
[ =C2=A0530.911285] serial8250 serial8250.0: LATE suspend
[ =C2=A0530.911285] nop_usb_xceiv nop_usb_xceiv: LATE suspend
[ =C2=A0530.911315] reg-fixed-voltage reg-fixed-voltage.1: LATE suspend
[ =C2=A0530.911346] omapdss omapdss: LATE suspend
[ =C2=A0530.911376] platform reg-dummy: LATE suspend
[ =C2=A0530.911407] PM: late suspend of devices complete after 1.983 ms=
ecs
[ =C2=A0530.918731] sdrc_pwr before:00000009 now:00000129
[ =C2=A0530.918792] core idlest1:ffffffbd idlest3:0000000d
[ =C2=A0530.918823] Successfully put all powerdomains to target state
[ =C2=A0530.919464] platform reg-dummy: EARLY resume
[ =C2=A0530.919555] omapdss omapdss: EARLY resume
[ =C2=A0530.919616] reg-fixed-voltage reg-fixed-voltage.1: EARLY resume
[ =C2=A0530.919647] nop_usb_xceiv nop_usb_xceiv: EARLY resume
[ =C2=A0530.919677] serial8250 serial8250.0: EARLY resume
[ =C2=A0530.919708] serial8250 serial8250.1: EARLY resume
[ =C2=A0530.919738] serial8250 serial8250.2: EARLY resume
[ =C2=A0530.919769] musb_hdrc musb_hdrc: EARLY resume
[ =C2=A0530.920104] mmci-omap-hs mmci-omap-hs.0: EARLY resume
[ =C2=A0530.920166] mmci-omap-hs mmci-omap-hs.1: EARLY resume
[ =C2=A0530.920196] platform arm-pmu.0: EARLY resume
[ =C2=A0530.920227] omapfb omapfb: EARLY resume
[ =C2=A0530.920440] platform mpu.0: EARLY resume
[ =C2=A0530.920471] platform iva.0: EARLY resume
[ =C2=A0530.920501] platform l3_main.0: EARLY resume
[ =C2=A0530.920562] serial8250 serial8250: EARLY resume
[ =C2=A0530.920745] PM: early resume of devices complete after 1.342 ms=
ecs
[ =C2=A0530.920898] irqstatus 00000200
[ =C2=A0530.921783] platform reg-dummy: resume
[ =C2=A0530.922119] omapdss omapdss: resume
[ =C2=A0530.924804] reg-fixed-voltage reg-fixed-voltage.1: resume
[ =C2=A0530.924926] nop_usb_xceiv nop_usb_xceiv: resume
[ =C2=A0530.925048] serial8250 serial8250.0: resume
[ =C2=A0530.925201] serial8250 serial8250.1: resume
[ =C2=A0530.925354] serial8250 serial8250.2: resume
[ =C2=A0530.929779] musb_hdrc musb_hdrc: resume
[ =C2=A0530.929901] mmci-omap-hs mmci-omap-hs.0: resume
[ =C2=A0530.930389] mmci-omap-hs mmci-omap-hs.1: resume
[ =C2=A0530.954437] sdrc_pwr before:00000129 now:00000169
[ =C2=A0530.954467] core idlest1:fcffff9d idlest3:0000000d
[ =C2=A0530.954772] irqstatus 00000001
[ =C2=A0530.977600] sdrc_pwr before:00000169 now:00000169
[ =C2=A0530.977630] core idlest1:fcffff9d idlest3:0000000d
[ =C2=A0530.977935] irqstatus 00000001
[ =C2=A0530.985565] sdrc_pwr before:00000169 now:00000129
[ =C2=A0530.985595] core idlest1:fcffff9d idlest3:0000000d
[ =C2=A0531.008850] sdrc_pwr before:00000129 now:00000169
[ =C2=A0531.008880] core idlest1:fcffff9d idlest3:0000000d
[ =C2=A0531.009185] irqstatus 00000001
[ =C2=A0531.013275] sdrc_pwr before:00000169 now:00000129
[ =C2=A0531.013336] core idlest1:fcffff9d idlest3:0000000d
[ =C2=A0531.032196] sdrc_pwr before:00000129 now:00000169
[ =C2=A0531.032257] core idlest1:fcffff9d idlest3:0000000d
[ =C2=A0531.032562] irqstatus 00000001
[ =C2=A0531.036834] sdrc_pwr before:00000169 now:00000129
[ =C2=A0531.036895] core idlest1:fdffff9d idlest3:0000000d
[ =C2=A0531.040924] sdrc_pwr before:00000129 now:00000129
[ =C2=A0531.040954] core idlest1:fdffff9d idlest3:0000000d
[ =C2=A0531.045043] sdrc_pwr before:00000129 now:00000129
[ =C2=A0531.045074] core idlest1:fdffff9d idlest3:0000000d
[ =C2=A0531.049133] sdrc_pwr before:00000129 now:00000129
[ =C2=A0531.049163] core idlest1:fdffff9d idlest3:0000000d
[ =C2=A0531.053253] sdrc_pwr before:00000129 now:00000129
[ =C2=A0531.053283] core idlest1:fdffff9d idlest3:0000000d
[ =C2=A0531.057312] sdrc_pwr before:00000129 now:00000129
[ =C2=A0531.057342] core idlest1:fdffff9d idlest3:0000000d
[ =C2=A0531.071166] sdrc_pwr before:00000129 now:00000169
[ =C2=A0531.071228] core idlest1:fdffff9d idlest3:0000000d
[ =C2=A0531.071533] irqstatus 00000001
[ =C2=A0531.075683] sdrc_pwr before:00000169 now:00000129
[ =C2=A0531.075744] core idlest1:fdffff9d idlest3:0000000d
[ =C2=A0531.076324] platform arm-pmu.0: resume
[ =C2=A0531.076477] omapfb omapfb: resume
[ =C2=A0531.078826] platform mpu.0: resume
[ =C2=A0531.078948] platform iva.0: resume
[ =C2=A0531.079040] platform l3_main.0: resume
[ =C2=A0531.079193] serial8250 serial8250: resume
[ =C2=A0531.080657] mmcblk mmc1:0001: legacy resume
[ =C2=A0531.081298] PM: resume of devices complete after 160.002 msecs
[ =C2=A0531.082885] serial8250 serial8250: completing resume
[ =C2=A0531.083007] platform l3_main.0: completing resume
[ =C2=A0531.083099] platform iva.0: completing resume
[ =C2=A0531.083160] platform mpu.0: completing resume
[ =C2=A0531.085083] omapfb omapfb: completing resume
[ =C2=A0531.085144] platform arm-pmu.0: completing resume
[ =C2=A0531.085235] mmci-omap-hs mmci-omap-hs.1: completing resume
[ =C2=A0531.085296] mmci-omap-hs mmci-omap-hs.0: completing resume
[ =C2=A0531.085388] musb_hdrc musb_hdrc: completing resume
[ =C2=A0531.085784] serial8250 serial8250.2: completing resume
[ =C2=A0531.085906] serial8250 serial8250.1: completing resume
[ =C2=A0531.085998] serial8250 serial8250.0: completing resume
[ =C2=A0531.086059] nop_usb_xceiv nop_usb_xceiv: completing resume
[ =C2=A0531.086151] reg-fixed-voltage reg-fixed-voltage.1: completing r=
esume
[ =C2=A0531.086212] omapdss omapdss: completing resume
[ =C2=A0531.086486] platform reg-dummy: completing resume
[ =C2=A0532.160278] PM: Finishing wakeup.
[ =C2=A0532.163970] Restarting tasks ... done.
root@spark:~$ [ =C2=A0532.402130] mmc0: host does not support reading
read-only switch. assuming write-enable.
[ =C2=A0532.410980] mmc0: new SD card at address bed5
[ =C2=A0532.416748] PM: Adding info for mmc:mmc0:bed5
[ =C2=A0532.430267] mmcblk0: mmc0:bed5 SU02G 1.84 GiB
[ =C2=A0532.436187] PM: Adding info for No Bus:mmcblk0
[ =C2=A0532.453125] =C2=A0mmcblk0: p1 p2
[ =C2=A0532.457611] PM: Adding info for No Bus:mmcblk0p1
[ =C2=A0532.464080] PM: Adding info for No Bus:mmcblk0p2
[ =C2=A0532.503845] PM: Adding info for No Bus:179:0
root@spark:~$ devmem 0x48307260
0x0000000C
root@spark:~$ echo mem > /sys/power/state
[ =C2=A0558.495269] PM: Syncing filesystems ... done.
[ =C2=A0558.500610] PM: Preparing system for mem sleep
[ =C2=A0558.506378] mmc0: card bed5 removed
[ =C2=A0558.510253] PM: Removing info for mmc:mmc0:bed5
[ =C2=A0558.516632] PM: Removing info for No Bus:mmcblk0p2
[ =C2=A0558.526306] PM: Removing info for No Bus:mmcblk0p1
[ =C2=A0558.547790] PM: Removing info for No Bus:179:0
[ =C2=A0558.579101] PM: Removing info for No Bus:mmcblk0
[ =C2=A0558.620605] ------------[ cut here ]------------
[ =C2=A0558.625854] WARNING: at drivers/regulator/core.c:1357
_regulator_disable+0x54/0x164()
[ =C2=A0558.634063] unbalanced disables for vMMC
[ =C2=A0558.638031] Modules linked in:
[ =C2=A0558.641540] [<c0237960>] (unwind_backtrace+0x0/0xf0) from
[<c025ae10>] (warn_slowpath_common+0x4c/0x64)
[ =C2=A0558.651397] [<c025ae10>] (warn_slowpath_common+0x4c/0x64) from
[<c025aea8>] (warn_slowpath_fmt+0x2c/0x3c)
[ =C2=A0558.661407] [<c025aea8>] (warn_slowpath_fmt+0x2c/0x3c) from
[<c03b9b40>] (_regulator_disable+0x54/0x164)
[ =C2=A0558.671386] [<c03b9b40>] (_regulator_disable+0x54/0x164) from
[<c03b9d3c>] (regulator_disable+0x20/0x34)
[ =C2=A0558.681304] [<c03b9d3c>] (regulator_disable+0x20/0x34) from
[<c042d158>] (omap_hsmmc_1_set_power+0x64/0xa0)
[ =C2=A0558.691467] [<c042d158>] (omap_hsmmc_1_set_power+0x64/0xa0) fro=
m
[<c042bd00>] (omap_hsmmc_set_ios+0x70/0x410)
[ =C2=A0558.701782] [<c042bd00>] (omap_hsmmc_set_ios+0x70/0x410) from
[<c0422144>] (mmc_power_off+0x50/0x54)
[ =C2=A0558.711364] [<c0422144>] (mmc_power_off+0x50/0x54) from
[<c0422b88>] (mmc_detach_bus+0x74/0xbc)
[ =C2=A0558.720550] [<c0422b88>] (mmc_detach_bus+0x74/0xbc) from
[<c04231d4>] (mmc_pm_notify+0x90/0xd8)
[ =C2=A0558.729705] [<c04231d4>] (mmc_pm_notify+0x90/0xd8) from
[<c0277954>] (notifier_call_chain+0x2c/0x70)
[ =C2=A0558.739318] [<c0277954>] (notifier_call_chain+0x2c/0x70) from
[<c0277db0>] (__blocking_notifier_call_chain+0x48/0x5c)
[ =C2=A0558.750396] [<c0277db0>] (__blocking_notifier_call_chain+0x48/0=
x5c)
from [<c0277dd8>] (blocking_notifier_call_chain+0x14/0x18)
[ =C2=A0558.762237] [<c0277dd8>] (blocking_notifier_call_chain+0x14/0x1=
8)
from [<c028ec1c>] (pm_notifier_call_chain+0x14/0x2c)
[ =C2=A0558.773406] [<c028ec1c>] (pm_notifier_call_chain+0x14/0x2c) fro=
m
[<c028f448>] (enter_state+0x7c/0x120)
[ =C2=A0558.783142] [<c028f448>] (enter_state+0x7c/0x120) from [<c028eb=
80>]
(state_store+0xa0/0xbc)
[ =C2=A0558.791931] [<c028eb80>] (state_store+0xa0/0xbc) from [<c0393e0=
8>]
(kobj_attr_store+0x18/0x1c)
[ =C2=A0558.800994] [<c0393e08>] (kobj_attr_store+0x18/0x1c) from
[<c0309244>] (sysfs_write_file+0x10c/0x140)
[ =C2=A0558.810638] [<c0309244>] (sysfs_write_file+0x10c/0x140) from
[<c02c09e4>] (vfs_write+0xac/0x134)
[ =C2=A0558.819854] [<c02c09e4>] (vfs_write+0xac/0x134) from [<c02c0b18=
>]
(sys_write+0x3c/0x68)
[ =C2=A0558.828277] [<c02c0b18>] (sys_write+0x3c/0x68) from [<c0231f40>=
]
(ret_fast_syscall+0x0/0x3c)
[ =C2=A0558.837097] ---[ end trace 7a172f77f33931a6 ]---
[ =C2=A0558.945281] Freezing user space processes ... (elapsed 0.01 sec=
onds) done.
[ =C2=A0558.971588] Freezing remaining freezable tasks ... (elapsed 0.0=
2
seconds) done.
[ =C2=A0559.002960] PM: Entering mem sleep
[ =C2=A0559.006591] Suspending console(s) (use no_console_suspend to de=
bug)
[ =C2=A0559.013366] platform reg-dummy: preparing suspend
[ =C2=A0559.013641] omapdss omapdss: preparing suspend
[ =C2=A0559.013732] reg-fixed-voltage reg-fixed-voltage.1: preparing su=
spend
[ =C2=A0559.013824] nop_usb_xceiv nop_usb_xceiv: preparing suspend
[ =C2=A0559.013916] serial8250 serial8250.0: preparing suspend
[ =C2=A0559.013977] serial8250 serial8250.1: preparing suspend
[ =C2=A0559.014068] serial8250 serial8250.2: preparing suspend
[ =C2=A0559.014129] musb_hdrc musb_hdrc: preparing suspend
[ =C2=A0559.014221] mmci-omap-hs mmci-omap-hs.0: preparing suspend
[ =C2=A0559.014282] mmci-omap-hs mmci-omap-hs.1: preparing suspend
[ =C2=A0559.014373] platform arm-pmu.0: preparing suspend
[ =C2=A0559.014465] omapfb omapfb: preparing suspend
[ =C2=A0559.016632] platform mpu.0: preparing suspend
[ =C2=A0559.016723] platform iva.0: preparing suspend
[ =C2=A0559.016815] platform l3_main.0: preparing suspend
[ =C2=A0559.016937] serial8250 serial8250: preparing suspend
[ =C2=A0559.018707] mmcblk mmc1:0001: legacy suspend
[ =C2=A0559.020141] serial8250 serial8250: suspend
[ =C2=A0559.020324] platform l3_main.0: suspend
[ =C2=A0559.020416] platform iva.0: suspend
[ =C2=A0559.020538] platform mpu.0: suspend
[ =C2=A0559.022460] omapfb omapfb: suspend
[ =C2=A0559.022552] platform arm-pmu.0: suspend
[ =C2=A0559.022644] mmci-omap-hs mmci-omap-hs.1: suspend
[ =C2=A0559.023406] ------------[ cut here ]------------
[ =C2=A0559.023498] WARNING: at drivers/regulator/core.c:1357
_regulator_disable+0x54/0x164()
[ =C2=A0559.023559] unbalanced disables for dummy
[ =C2=A0559.023559] Modules linked in:
[ =C2=A0559.023712] [<c0237960>] (unwind_backtrace+0x0/0xf0) from
[<c025ae10>] (warn_slowpath_common+0x4c/0x64)
[ =C2=A0559.023773] [<c025ae10>] (warn_slowpath_common+0x4c/0x64) from
[<c025aea8>] (warn_slowpath_fmt+0x2c/0x3c)
[ =C2=A0559.023834] [<c025aea8>] (warn_slowpath_fmt+0x2c/0x3c) from
[<c03b9b40>] (_regulator_disable+0x54/0x164)
[ =C2=A0559.023895] [<c03b9b40>] (_regulator_disable+0x54/0x164) from
[<c03b9d3c>] (regulator_disable+0x20/0x34)
[ =C2=A0559.023956] [<c03b9d3c>] (regulator_disable+0x20/0x34) from
[<c042d0b8>] (omap_hsmmc_23_set_power+0xb4/0xf0)
[ =C2=A0559.024017] [<c042d0b8>] (omap_hsmmc_23_set_power+0xb4/0xf0) fr=
om
[<c042bd00>] (omap_hsmmc_set_ios+0x70/0x410)
[ =C2=A0559.024078] [<c042bd00>] (omap_hsmmc_set_ios+0x70/0x410) from
[<c0422144>] (mmc_power_off+0x50/0x54)
[ =C2=A0559.024139] [<c0422144>] (mmc_power_off+0x50/0x54) from
[<c0422ad0>] (mmc_suspend_host+0x128/0x134)
[ =C2=A0559.024200] [<c0422ad0>] (mmc_suspend_host+0x128/0x134) from
[<c042b69c>] (omap_hsmmc_suspend+0x60/0x108)
[ =C2=A0559.024261] [<c042b69c>] (omap_hsmmc_suspend+0x60/0x108) from
[<c03dd21c>] (platform_pm_suspend+0x2c/0x54)
[ =C2=A0559.024322] [<c03dd21c>] (platform_pm_suspend+0x2c/0x54) from
[<c03df918>] (pm_op+0x4c/0xb4)
[ =C2=A0559.024383] [<c03df918>] (pm_op+0x4c/0xb4) from [<c03e0490>]
(__device_suspend+0x140/0x1c0)
[ =C2=A0559.024414] [<c03e0490>] (__device_suspend+0x140/0x1c0) from
[<c03e08c4>] (dpm_suspend_start+0x368/0x49c)
[ =C2=A0559.024505] [<c03e08c4>] (dpm_suspend_start+0x368/0x49c) from
[<c028f214>] (suspend_devices_and_enter+0x48/0x200)
[ =C2=A0559.024566] [<c028f214>] (suspend_devices_and_enter+0x48/0x200)
from [<c028f488>] (enter_state+0xbc/0x120)
[ =C2=A0559.024627] [<c028f488>] (enter_state+0xbc/0x120) from [<c028eb=
80>]
(state_store+0xa0/0xbc)
[ =C2=A0559.024688] [<c028eb80>] (state_store+0xa0/0xbc) from [<c0393e0=
8>]
(kobj_attr_store+0x18/0x1c)
[ =C2=A0559.024780] [<c0393e08>] (kobj_attr_store+0x18/0x1c) from
[<c0309244>] (sysfs_write_file+0x10c/0x140)
[ =C2=A0559.024841] [<c0309244>] (sysfs_write_file+0x10c/0x140) from
[<c02c09e4>] (vfs_write+0xac/0x134)
[ =C2=A0559.024902] [<c02c09e4>] (vfs_write+0xac/0x134) from [<c02c0b18=
>]
(sys_write+0x3c/0x68)
[ =C2=A0559.024963] [<c02c0b18>] (sys_write+0x3c/0x68) from [<c0231f40>=
]
(ret_fast_syscall+0x0/0x3c)
[ =C2=A0559.024993] ---[ end trace 7a172f77f33931a7 ]---
[ =C2=A0559.025268] mmci-omap-hs mmci-omap-hs.0: suspend
[ =C2=A0559.026031] musb_hdrc musb_hdrc: suspend
[ =C2=A0559.026245] serial8250 serial8250.2: suspend
[ =C2=A0559.026611] serial8250 serial8250.1: suspend
[ =C2=A0559.026794] serial8250 serial8250.0: suspend
[ =C2=A0559.026947] nop_usb_xceiv nop_usb_xceiv: suspend
[ =C2=A0559.027038] reg-fixed-voltage reg-fixed-voltage.1: suspend
[ =C2=A0559.027130] omapdss omapdss: suspend
[ =C2=A0559.033630] ------------[ cut here ]------------
[ =C2=A0559.033752] WARNING: at drivers/regulator/core.c:1357
_regulator_disable+0x54/0x164()
[ =C2=A0559.033782] unbalanced disables for dummy
[ =C2=A0559.033782] Modules linked in:
[ =C2=A0559.033935] [<c0237960>] (unwind_backtrace+0x0/0xf0) from
[<c025ae10>] (warn_slowpath_common+0x4c/0x64)
[ =C2=A0559.034027] [<c025ae10>] (warn_slowpath_common+0x4c/0x64) from
[<c025aea8>] (warn_slowpath_fmt+0x2c/0x3c)
[ =C2=A0559.034088] [<c025aea8>] (warn_slowpath_fmt+0x2c/0x3c) from
[<c03b9b40>] (_regulator_disable+0x54/0x164)
[ =C2=A0559.034149] [<c03b9b40>] (_regulator_disable+0x54/0x164) from
[<c03b9d3c>] (regulator_disable+0x20/0x34)
[ =C2=A0559.034240] [<c03b9d3c>] (regulator_disable+0x20/0x34) from
[<c03b2060>] (omapdss_dpi_display_disable+0x2c/0x3c)
[ =C2=A0559.034301] [<c03b2060>] (omapdss_dpi_display_disable+0x2c/0x3c=
)
from [<c03b769c>] (generic_panel_suspend+0xc/0x1c)
[ =C2=A0559.034362] [<c03b769c>] (generic_panel_suspend+0xc/0x1c) from
[<c03af0c0>] (dss_suspend_device+0x44/0x54)
[ =C2=A0559.034423] [<c03af0c0>] (dss_suspend_device+0x44/0x54) from
[<c03dbaa8>] (bus_for_each_dev+0x48/0x84)
[ =C2=A0559.034454] [<c03dbaa8>] (bus_for_each_dev+0x48/0x84) from
[<c03af21c>] (dss_suspend_all_devices+0x18/0x30)
[ =C2=A0559.034515] [<c03af21c>] (dss_suspend_all_devices+0x18/0x30) fr=
om
[<c03dd238>] (platform_pm_suspend+0x48/0x54)
[ =C2=A0559.034576] [<c03dd238>] (platform_pm_suspend+0x48/0x54) from
[<c03df918>] (pm_op+0x4c/0xb4)
[ =C2=A0559.034637] [<c03df918>] (pm_op+0x4c/0xb4) from [<c03e0490>]
(__device_suspend+0x140/0x1c0)
[ =C2=A0559.034698] [<c03e0490>] (__device_suspend+0x140/0x1c0) from
[<c03e08c4>] (dpm_suspend_start+0x368/0x49c)
[ =C2=A0559.034790] [<c03e08c4>] (dpm_suspend_start+0x368/0x49c) from
[<c028f214>] (suspend_devices_and_enter+0x48/0x200)
[ =C2=A0559.034851] [<c028f214>] (suspend_devices_and_enter+0x48/0x200)
from [<c028f488>] (enter_state+0xbc/0x120)
[ =C2=A0559.034912] [<c028f488>] (enter_state+0xbc/0x120) from [<c028eb=
80>]
(state_store+0xa0/0xbc)
[ =C2=A0559.034973] [<c028eb80>] (state_store+0xa0/0xbc) from [<c0393e0=
8>]
(kobj_attr_store+0x18/0x1c)
[ =C2=A0559.035034] [<c0393e08>] (kobj_attr_store+0x18/0x1c) from
[<c0309244>] (sysfs_write_file+0x10c/0x140)
[ =C2=A0559.035125] [<c0309244>] (sysfs_write_file+0x10c/0x140) from
[<c02c09e4>] (vfs_write+0xac/0x134)
[ =C2=A0559.035156] [<c02c09e4>] (vfs_write+0xac/0x134) from [<c02c0b18=
>]
(sys_write+0x3c/0x68)
[ =C2=A0559.035217] [<c02c0b18>] (sys_write+0x3c/0x68) from [<c0231f40>=
]
(ret_fast_syscall+0x0/0x3c)
[ =C2=A0559.035278] ---[ end trace 7a172f77f33931a8 ]---
[ =C2=A0559.035675] platform reg-dummy: suspend
[ =C2=A0559.035919] PM: suspend of devices complete after 17.486 msecs
[ =C2=A0559.037841] serial8250 serial8250: LATE suspend
[ =C2=A0559.037902] platform l3_main.0: LATE suspend
[ =C2=A0559.037933] platform iva.0: LATE suspend
[ =C2=A0559.037963] platform mpu.0: LATE suspend
[ =C2=A0559.038177] omapfb omapfb: LATE suspend
[ =C2=A0559.038208] platform arm-pmu.0: LATE suspend
[ =C2=A0559.038238] mmci-omap-hs mmci-omap-hs.1: LATE suspend
[ =C2=A0559.038269] mmci-omap-hs mmci-omap-hs.0: LATE suspend
[ =C2=A0559.038269] musb_hdrc musb_hdrc: LATE suspend
[ =C2=A0559.038299] serial8250 serial8250.2: LATE suspend
[ =C2=A0559.038330] serial8250 serial8250.1: LATE suspend
[ =C2=A0559.038360] serial8250 serial8250.0: LATE suspend
[ =C2=A0559.038391] nop_usb_xceiv nop_usb_xceiv: LATE suspend
[ =C2=A0559.038421] reg-fixed-voltage reg-fixed-voltage.1: LATE suspend
[ =C2=A0559.038452] omapdss omapdss: LATE suspend
[ =C2=A0559.038848] platform reg-dummy: LATE suspend
[ =C2=A0559.038940] PM: late suspend of devices complete after 2.960 ms=
ecs
[ =C2=A0568.066253] sdrc_pwr before:00000129 now:00000169
[ =C2=A0568.066284] core idlest1:ffffffbd idlest3:0000000d
[ =C2=A0568.066345] Powerdomain (core_pwrdm) didn't enter target state =
0
[ =C2=A0568.066375] Could not enter target state in pm_suspend
[ =C2=A0568.066711] platform reg-dummy: EARLY resume
[ =C2=A0568.066802] omapdss omapdss: EARLY resume
[ =C2=A0568.066833] reg-fixed-voltage reg-fixed-voltage.1: EARLY resume
[ =C2=A0568.066864] nop_usb_xceiv nop_usb_xceiv: EARLY resume
[ =C2=A0568.066894] serial8250 serial8250.0: EARLY resume
[ =C2=A0568.066925] serial8250 serial8250.1: EARLY resume
[ =C2=A0568.066955] serial8250 serial8250.2: EARLY resume
[ =C2=A0568.066986] musb_hdrc musb_hdrc: EARLY resume
[ =C2=A0568.067077] mmci-omap-hs mmci-omap-hs.0: EARLY resume
[ =C2=A0568.067108] mmci-omap-hs mmci-omap-hs.1: EARLY resume
[ =C2=A0568.067138] platform arm-pmu.0: EARLY resume
[ =C2=A0568.067169] omapfb omapfb: EARLY resume
[ =C2=A0568.067382] platform mpu.0: EARLY resume
[ =C2=A0568.067413] platform iva.0: EARLY resume
[ =C2=A0568.067443] platform l3_main.0: EARLY resume
[ =C2=A0568.067474] serial8250 serial8250: EARLY resume
[ =C2=A0568.067687] PM: early resume of devices complete after 1.007 ms=
ecs
[ =C2=A0568.067810] irqstatus 00000200
[ =C2=A0568.068420] platform reg-dummy: resume
[ =C2=A0568.068725] omapdss omapdss: resume
[ =C2=A0568.071411] reg-fixed-voltage reg-fixed-voltage.1: resume
[ =C2=A0568.071533] nop_usb_xceiv nop_usb_xceiv: resume
[ =C2=A0568.071624] serial8250 serial8250.0: resume
[ =C2=A0568.071807] serial8250 serial8250.1: resume
[ =C2=A0568.071929] serial8250 serial8250.2: resume
[ =C2=A0568.074096] musb_hdrc musb_hdrc: resume
[ =C2=A0568.074218] mmci-omap-hs mmci-omap-hs.0: resume
[ =C2=A0568.074707] mmci-omap-hs mmci-omap-hs.1: resume
[ =C2=A0568.098571] sdrc_pwr before:00000169 now:00000169
[ =C2=A0568.098602] core idlest1:fcffff9d idlest3:0000000d
[ =C2=A0568.098907] irqstatus 00000001
[ =C2=A0568.121948] sdrc_pwr before:00000169 now:00000169
[ =C2=A0568.121978] core idlest1:fcffff9d idlest3:0000000d
[ =C2=A0568.122314] irqstatus 00000001
[ =C2=A0568.129913] sdrc_pwr before:00000169 now:00000129
[ =C2=A0568.129974] core idlest1:fcffff9d idlest3:0000000d
[ =C2=A0568.153228] sdrc_pwr before:00000129 now:00000169
[ =C2=A0568.153259] core idlest1:fcffff9d idlest3:0000000d
[ =C2=A0568.153594] irqstatus 00000001
[ =C2=A0568.157714] sdrc_pwr before:00000169 now:00000129
[ =C2=A0568.157745] core idlest1:fcffff9d idlest3:0000000d
[ =C2=A0568.176605] sdrc_pwr before:00000129 now:00000169
[ =C2=A0568.176635] core idlest1:fcffff9d idlest3:0000000d
[ =C2=A0568.176940] irqstatus 00000001
[ =C2=A0568.181243] sdrc_pwr before:00000169 now:00000129
[ =C2=A0568.181274] core idlest1:fdffff9d idlest3:0000000d
[ =C2=A0568.185333] sdrc_pwr before:00000129 now:00000129
[ =C2=A0568.185363] core idlest1:fdffff9d idlest3:0000000d
[ =C2=A0568.189422] sdrc_pwr before:00000129 now:00000129
[ =C2=A0568.189453] core idlest1:fdffff9d idlest3:0000000d
[ =C2=A0568.193511] sdrc_pwr before:00000129 now:00000129
[ =C2=A0568.193542] core idlest1:fdffff9d idlest3:0000000d
[ =C2=A0568.197631] sdrc_pwr before:00000129 now:00000129
[ =C2=A0568.197692] core idlest1:fdffff9d idlest3:0000000d
[ =C2=A0568.201721] sdrc_pwr before:00000129 now:00000129
[ =C2=A0568.201751] core idlest1:fdffff9d idlest3:0000000d
[ =C2=A0568.205932] sdrc_pwr before:00000129 now:00000129
[ =C2=A0568.205963] core idlest1:fdffff9d idlest3:0000000d
[ =C2=A0568.206787] platform arm-pmu.0: resume
[ =C2=A0568.206939] omapfb omapfb: resume
[ =C2=A0568.208923] platform mpu.0: resume
[ =C2=A0568.209014] platform iva.0: resume
[ =C2=A0568.209106] platform l3_main.0: resume
[ =C2=A0568.209259] serial8250 serial8250: resume
[ =C2=A0568.210693] mmcblk mmc1:0001: legacy resume
[ =C2=A0568.211395] PM: resume of devices complete after 143.188 msecs
[ =C2=A0568.212982] serial8250 serial8250: completing resume
[ =C2=A0568.213134] platform l3_main.0: completing resume
[ =C2=A0568.213226] platform iva.0: completing resume
[ =C2=A0568.213287] platform mpu.0: completing resume
[ =C2=A0568.215515] omapfb omapfb: completing resume
[ =C2=A0568.215637] platform arm-pmu.0: completing resume
[ =C2=A0568.215698] mmci-omap-hs mmci-omap-hs.1: completing resume
[ =C2=A0568.215789] mmci-omap-hs mmci-omap-hs.0: completing resume
[ =C2=A0568.215881] musb_hdrc musb_hdrc: completing resume
[ =C2=A0568.215942] serial8250 serial8250.2: completing resume
[ =C2=A0568.216033] serial8250 serial8250.1: completing resume
[ =C2=A0568.216125] serial8250 serial8250.0: completing resume
[ =C2=A0568.216186] nop_usb_xceiv nop_usb_xceiv: completing resume
[ =C2=A0568.216247] reg-fixed-voltage reg-fixed-voltage.1: completing r=
esume
[ =C2=A0568.216339] omapdss omapdss: completing resume
[ =C2=A0568.216583] platform reg-dummy: completing resume
[ =C2=A0569.282806] PM: Finishing wakeup.
[ =C2=A0569.286468] Restarting tasks ... done.
root@spark:~$ [ =C2=A0569.522857] mmc0: host does not support reading
read-only switch. assuming write-enable.
[ =C2=A0569.531677] mmc0: new SD card at address bed5
[ =C2=A0569.537506] PM: Adding info for mmc:mmc0:bed5
[ =C2=A0569.551300] mmcblk0: mmc0:bed5 SU02G 1.84 GiB
[ =C2=A0569.557250] PM: Adding info for No Bus:mmcblk0
[ =C2=A0569.574157] =C2=A0mmcblk0: p1 p2
[ =C2=A0569.578369] PM: Adding info for No Bus:mmcblk0p1
[ =C2=A0569.584808] PM: Adding info for No Bus:mmcblk0p2
[ =C2=A0569.624908] PM: Adding info for No Bus:179:0

root@spark:~$ cat /debug/pm_debug/count
usbhost_pwrdm (OFF),OFF:1,RET:1,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1=
-OFF:0
sgx_pwrdm (OFF),OFF:1,RET:0,INA:0,ON:0,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF=
:0
per_pwrdm (ON),OFF:11,RET:0,INA:0,ON:12,RET-LOGIC-OFF:0,RET-MEMBANK1-OF=
=46:0
dss_pwrdm (ON),OFF:2,RET:3,INA:4,ON:9,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:=
0
cam_pwrdm (OFF),OFF:1,RET:1,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF=
:0
core_pwrdm (ON),OFF:1,RET:0,INA:0,ON:2,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF=
:0,RET-MEMBANK2-OFF:0
neon_pwrdm (ON),OFF:11,RET:0,INA:0,ON:12,RET-LOGIC-OFF:0
mpu_pwrdm (ON),OFF:11,RET:0,INA:0,ON:12,RET-LOGIC-OFF:0,RET-MEMBANK1-OF=
=46:0
iva2_pwrdm (OFF),OFF:1,RET:1,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OF=
=46:0,RET-MEMBANK2-OFF:0,RET-MEMBANK3-OFF:0,RET-MEMBANK4-OFF:0
per_clkdm->per_pwrdm (9)
usbhost_clkdm->usbhost_pwrdm (0)
cam_clkdm->cam_pwrdm (0)
dss_clkdm->dss_pwrdm (2)
core_l4_clkdm->core_pwrdm (9)
core_l3_clkdm->core_pwrdm (5)
d2d_clkdm->core_pwrdm (0)
sgx_clkdm->sgx_pwrdm (0)
iva2_clkdm->iva2_pwrdm (0)
neon_clkdm->neon_pwrdm (0)
mpu_clkdm->mpu_pwrdm (0)
prm_clkdm->wkup_pwrdm (0)
cm_clkdm->core_pwrdm (0)

Any ideas?

--=20
Laine Walker-Avina
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

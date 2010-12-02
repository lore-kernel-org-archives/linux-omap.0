From: Paul Walmsley <paul@pwsan.com>
Subject: Unbalanced IRQ wake disable during resume from static suspend
Date: Thu, 2 Dec 2010 01:05:16 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1012020057550.2515@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:40593 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755428Ab0LBIFS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Dec 2010 03:05:18 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, Govindraj <govindraj.ti@gmail.com>
Cc: khilman@deeprootsystems.com


Hi,

On current linux-omap master (commit 
7fd1cffc56ca9944fec583eb2ecda5ce88b36bff "Linux-omap rebuilt: Updated to 
-rc4"), when resuming from static suspend, several "Unbalanced IRQ 
wake disable" warnings are generated, one for each of the serial ports.
This is on Beagle 35xx rev C2.

Is anyone else seeing this?


- Paul

root@beagleboard:~# echo 1 > /debug/pm_debug/sleep_while_idle
root@beagleboard:~# echo 1 > /debug/pm_debug/enable_off_mode
root@beagleboard:~# echo 5 > /sys/devices/platform/omap/omap-hsuart.0/sleep_timeout
root@beagleboard:~# echo 5 > /sys/devices/platform/omap/omap-hsuart.1/sleep_timeout
root@beagleboard:~# echo 5 > /sys/devices/platform/omap/omap-hsuart.2/sleep_timeout
root@beagleboard:~# echo enabled > /sys/devices/platform/omap/omap-hsuart.0/tty/ttyO0/power/wakeup
root@beagleboard:~# echo enabled > /sys/devices/platform/omap/omap-hsuart.1/tty/ttyO1/power/wakeup
root@beagleboard:~# echo enabled > /sys/devices/platform/omap/omap-hsuart.2/tty/ttyO2/power/wakeup
root@beagleboard:~# 
root@beagleboard:~# 
root@beagleboard:~# 
root@beagleboard:~# echo mem > /sys/power/state 
[   29.023498] PM: Syncing filesystems ... done.
[   29.548889] PM: Preparing system for mem sleep
[   29.564788] Freezing user space processes ... (elapsed 0.01 seconds) done.
[   29.589416] Freezing remaining freezable tasks ... (elapsed 0.02 seconds) done.
[   29.620666] PM: Entering mem sleep
[   29.626098] Suspending console(s) (use no_console_suspend to debug)
[   29.752685] PM: suspend of devices complete after 115.386 msecs
[   29.756103] PM: late suspend of devices complete after 3.387 msecs
[   29.756195] Disabling non-boot CPUs ...
[   29.756896] Powerdomain (mpu_pwrdm) didn't enter target state 0
[   29.756927] Powerdomain (neon_pwrdm) didn't enter target state 0
[   29.756958] Powerdomain (core_pwrdm) didn't enter target state 0
[   29.756958] Powerdomain (per_pwrdm) didn't enter target state 0
[   29.756988] Could not enter target state in pm_suspend
[   29.759094] PM: early resume of devices complete after 1.922 msecs
[   29.759887] ------------[ cut here ]------------
[   29.759948] WARNING: at kernel/irq/manage.c:382 set_irq_wake+0x80/0xe4()
[   29.759948] Unbalanced IRQ 72 wake disable
[   29.759979] Modules linked in:
[   29.760009] [<c0062a28>] (unwind_backtrace+0x0/0xec) from [<c0092260>] (warn_slowpath_common+0x4c/0x64)
[   29.760070] [<c0092260>] (warn_slowpath_common+0x4c/0x64) from [<c00922f8>] (warn_slowpath_fmt+0x2c/0x3c
)
[   29.760101] [<c00922f8>] (warn_slowpath_fmt+0x2c/0x3c) from [<c00d3238>] (set_irq_wake+0x80/0xe4)
[   29.760131] [<c00d3238>] (set_irq_wake+0x80/0xe4) from [<c029dd60>] (uart_resume_port+0x84/0x248)
[   29.760192] [<c029dd60>] (uart_resume_port+0x84/0x248) from [<c02a2338>] (serial_omap_resume+0x20/0x2c)
[   29.760223] [<c02a2338>] (serial_omap_resume+0x20/0x2c) from [<c02a92d4>] (platform_pm_resume+0x48/0x54)
[   29.760253] [<c02a92d4>] (platform_pm_resume+0x48/0x54) from [<c02abd1c>] (pm_op+0x6c/0xac)
[   29.760284] [<c02abd1c>] (pm_op+0x6c/0xac) from [<c02ac0fc>] (device_resume+0x58/0x10c)
[   29.760314] [<c02ac0fc>] (device_resume+0x58/0x10c) from [<c02ac2ec>] (dpm_resume_end+0xf4/0x360)
[   29.760375] [<c02ac2ec>] (dpm_resume_end+0xf4/0x360) from [<c00cf58c>] (suspend_devices_and_enter+0x1ac/
0x200)
[   29.760406] [<c00cf58c>] (suspend_devices_and_enter+0x1ac/0x200) from [<c00cf6c0>] (enter_state+0xe0/0x1
38)
[   29.760437] [<c00cf6c0>] (enter_state+0xe0/0x138) from [<c00ced18>] (state_store+0x90/0xb8)
[   29.760498] [<c00ced18>] (state_store+0x90/0xb8) from [<c0243b98>] (kobj_attr_store+0x18/0x1c)
[   29.760528] [<c0243b98>] (kobj_attr_store+0x18/0x1c) from [<c0176128>] (sysfs_write_file+0x10c/0x144)
[   29.760589] [<c0176128>] (sysfs_write_file+0x10c/0x144) from [<c0125528>] (vfs_write+0xac/0x134)
[   29.760620] [<c0125528>] (vfs_write+0xac/0x134) from [<c012565c>] (sys_write+0x3c/0x68)
[   29.760650] [<c012565c>] (sys_write+0x3c/0x68) from [<c005bb00>] (ret_fast_syscall+0x0/0x3c)
[   29.760681] ---[ end trace 19fe50b7b47ba94f ]---
[   29.760742] ------------[ cut here ]------------
[   29.760772] WARNING: at kernel/irq/manage.c:382 set_irq_wake+0x80/0xe4()
[   29.760803] Unbalanced IRQ 73 wake disable
[   29.760803] Modules linked in:
[   29.760833] [<c0062a28>] (unwind_backtrace+0x0/0xec) from [<c0092260>] (warn_slowpath_common+0x4c/0x64)
[   29.760864] [<c0092260>] (warn_slowpath_common+0x4c/0x64) from [<c00922f8>] (warn_slowpath_fmt+0x2c/0x3c
)
[   29.760894] [<c00922f8>] (warn_slowpath_fmt+0x2c/0x3c) from [<c00d3238>] (set_irq_wake+0x80/0xe4)
[   29.760955] [<c00d3238>] (set_irq_wake+0x80/0xe4) from [<c029dd60>] (uart_resume_port+0x84/0x248)
[   29.760986] [<c029dd60>] (uart_resume_port+0x84/0x248) from [<c02a2338>] (serial_omap_resume+0x20/0x2c)
[   29.761016] [<c02a2338>] (serial_omap_resume+0x20/0x2c) from [<c02a92d4>] (platform_pm_resume+0x48/0x54)
[   29.761047] [<c02a92d4>] (platform_pm_resume+0x48/0x54) from [<c02abd1c>] (pm_op+0x6c/0xac)
[   29.761077] [<c02abd1c>] (pm_op+0x6c/0xac) from [<c02ac0fc>] (device_resume+0x58/0x10c)
[   29.761108] [<c02ac0fc>] (device_resume+0x58/0x10c) from [<c02ac2ec>] (dpm_resume_end+0xf4/0x360)
[   29.761138] [<c02ac2ec>] (dpm_resume_end+0xf4/0x360) from [<c00cf58c>] (suspend_devices_and_enter+0x1ac/
0x200)
[   29.761199] [<c00cf58c>] (suspend_devices_and_enter+0x1ac/0x200) from [<c00cf6c0>] (enter_state+0xe0/0x1
38)
[   29.761230] [<c00cf6c0>] (enter_state+0xe0/0x138) from [<c00ced18>] (state_store+0x90/0xb8)
[   29.761260] [<c00ced18>] (state_store+0x90/0xb8) from [<c0243b98>] (kobj_attr_store+0x18/0x1c)
[   29.761291] [<c0243b98>] (kobj_attr_store+0x18/0x1c) from [<c0176128>] (sysfs_write_file+0x10c/0x144)
[   29.761352] [<c0176128>] (sysfs_write_file+0x10c/0x144) from [<c0125528>] (vfs_write+0xac/0x134)
[   29.761383] [<c0125528>] (vfs_write+0xac/0x134) from [<c012565c>] (sys_write+0x3c/0x68)
[   29.761413] [<c012565c>] (sys_write+0x3c/0x68) from [<c005bb00>] (ret_fast_syscall+0x0/0x3c)
[   29.761444] ---[ end trace 19fe50b7b47ba950 ]---
[   29.761474] ------------[ cut here ]------------
[   29.761505] WARNING: at kernel/irq/manage.c:382 set_irq_wake+0x80/0xe4()
[   29.761535] Unbalanced IRQ 74 wake disable
[   29.761535] Modules linked in:
[   29.761566] [<c0062a28>] (unwind_backtrace+0x0/0xec) from [<c0092260>] (warn_slowpath_common+0x4c/0x64)
[   29.761596] [<c0092260>] (warn_slowpath_common+0x4c/0x64) from [<c00922f8>] (warn_slowpath_fmt+0x2c/0x3c
)
[   29.761657] [<c00922f8>] (warn_slowpath_fmt+0x2c/0x3c) from [<c00d3238>] (set_irq_wake+0x80/0xe4)
[   29.761688] [<c00d3238>] (set_irq_wake+0x80/0xe4) from [<c029dd60>] (uart_resume_port+0x84/0x248)
[   29.761718] [<c029dd60>] (uart_resume_port+0x84/0x248) from [<c02a2338>] (serial_omap_resume+0x20/0x2c)
[   29.761749] [<c02a2338>] (serial_omap_resume+0x20/0x2c) from [<c02a92d4>] (platform_pm_resume+0x48/0x54)
[   29.761779] [<c02a92d4>] (platform_pm_resume+0x48/0x54) from [<c02abd1c>] (pm_op+0x6c/0xac)
[   29.761810] [<c02abd1c>] (pm_op+0x6c/0xac) from [<c02ac0fc>] (device_resume+0x58/0x10c)
[   29.761840] [<c02ac0fc>] (device_resume+0x58/0x10c) from [<c02ac2ec>] (dpm_resume_end+0xf4/0x360)
[   29.761871] [<c02ac2ec>] (dpm_resume_end+0xf4/0x360) from [<c00cf58c>] (suspend_devices_and_enter+0x1ac/
0x200)
[   29.761932] [<c00cf58c>] (suspend_devices_and_enter+0x1ac/0x200) from [<c00cf6c0>] (enter_state+0xe0/0x1
38)
[   29.761962] [<c00cf6c0>] (enter_state+0xe0/0x138) from [<c00ced18>] (state_store+0x90/0xb8)
[   29.761993] [<c00ced18>] (state_store+0x90/0xb8) from [<c0243b98>] (kobj_attr_store+0x18/0x1c)
[   29.762023] [<c0243b98>] (kobj_attr_store+0x18/0x1c) from [<c0176128>] (sysfs_write_file+0x10c/0x144)
[   29.762054] [<c0176128>] (sysfs_write_file+0x10c/0x144) from [<c0125528>] (vfs_write+0xac/0x134)
[   29.762115] [<c0125528>] (vfs_write+0xac/0x134) from [<c012565c>] (sys_write+0x3c/0x68)
[   29.762145] [<c012565c>] (sys_write+0x3c/0x68) from [<c005bb00>] (ret_fast_syscall+0x0/0x3c)
[   29.762145] ---[ end trace 19fe50b7b47ba951 ]---
[   30.040374] PM: resume of devices complete after 280.883 msecs
[   30.044677] omap_device: i2c_omap.1: new worst case deactivate latency 0: 183105
[   30.663726] PM: Finishing wakeup.
[   30.667327] Restarting tasks ... done.
root@beagleboard:~#


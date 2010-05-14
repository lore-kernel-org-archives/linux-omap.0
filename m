From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: Ads7846 breaks suspend-to-ram on 3430SDP
Date: Fri, 14 May 2010 14:26:40 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB0322D7D778@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Looks like the ads7846 driver breaks suspend-to-ram at least on
the OMAP 3430SDP. On a kernel built with the omap3_defconfig, with
no_console_suspend, I see the log below.

Will investigate some time next week, unless someone already has a fix.

- Anand



# echo mem > /sys/power/state
[   73.199005] PM: Syncing filesystems ... done.
[   73.253479] Freezing user space processes ... (elapsed 0.01 seconds) done.
[   73.277984] Freezing remaining freezable tasks ... (elapsed 0.01 seconds) done.
[   73.321014] ------------[ cut here ]------------
[   73.325714] WARNING: at kernel/lockdep.c:2820 __lock_acquire+0x3e8/0x1780()
[   73.332702] Modules linked in:
[   73.335815] [<c0045380>] (unwind_backtrace+0x0/0xe4) from [<c0072ecc>] (warn_slowpath_common+0x48/0x60)
[   73.345306] [<c0072ecc>] (warn_slowpath_common+0x48/0x60) from [<c00981b0>] (__lock_acquire+0x3e8/0x1780)
[   73.354919] [<c00981b0>] (__lock_acquire+0x3e8/0x1780) from [<c00995a8>] (lock_acquire+0x60/0x74)
[   73.363861] [<c00995a8>] (lock_acquire+0x60/0x74) from [<c0414964>] (_raw_spin_lock_irq+0x38/0x70)
[   73.372894] [<c0414964>] (_raw_spin_lock_irq+0x38/0x70) from [<c02cd444>] (ads7846_suspend+0x18/0x48)
[   73.382202] [<c02cd444>] (ads7846_suspend+0x18/0x48) from [<c026c330>] (spi_suspend+0x28/0x34)
[   73.390869] [<c026c330>] (spi_suspend+0x28/0x34) from [<c02314fc>] (legacy_suspend+0x2c/0x64)
[   73.399444] [<c02314fc>] (legacy_suspend+0x2c/0x64) from [<c0231d78>] (__device_suspend+0xf0/0x128)
[   73.408569] [<c0231d78>] (__device_suspend+0xf0/0x128) from [<c02320cc>] (dpm_suspend_start+0x31c/0x454)
[   73.418121] [<c02320cc>] (dpm_suspend_start+0x31c/0x454) from [<c00a3d08>] (suspend_devices_and_enter+0x48/0x1d8)
[   73.428466] [<c00a3d08>] (suspend_devices_and_enter+0x48/0x1d8) from [<c00a3f54>] (enter_state+0xbc/0x120)
[   73.438171] [<c00a3f54>] (enter_state+0xbc/0x120) from [<c00a36a8>] (state_store+0xa4/0xb8)
[   73.446594] [<c00a36a8>] (state_store+0xa4/0xb8) from [<c01e4cd8>] (kobj_attr_store+0x18/0x1c)
[   73.455291] [<c01e4cd8>] (kobj_attr_store+0x18/0x1c) from [<c0125190>] (sysfs_write_file+0x10c/0x144)
[   73.464569] [<c0125190>] (sysfs_write_file+0x10c/0x144) from [<c00dbb30>] (vfs_write+0xb0/0x148)
[   73.473419] [<c00dbb30>] (vfs_write+0xb0/0x148) from [<c00dbc78>] (sys_write+0x3c/0x68)
[   73.481506] [<c00dbc78>] (sys_write+0x3c/0x68) from [<c003f920>] (ret_fast_syscall+0x0/0x3c)
[   73.489990] ---[ end trace 1b75b31a2719ed1f ]---
[   73.494995] Unable to handle kernel NULL pointer dereference at virtual address 00000073
[   73.503204] pgd = c7fb8000
[   73.505920] [00000073] *pgd=87f93031, *pte=00000000, *ppte=00000000
[   73.512298] Internal error: Oops: 17 [#1]
[   73.516357] last sysfs file: /sys/devices/virtual/vc/vcsa63/dev
[   73.522308] Modules linked in:
[   73.525390] CPU: 0    Tainted: G        W   (2.6.34-rc7-08103-g20124b7-dirty #3)
[   73.532836] PC is at ads7846_suspend+0x24/0x48
[   73.537322] LR is at _raw_spin_unlock_irq+0x24/0x2c
[   73.542236] pc : [<c02cd450>]    lr : [<c04150b8>]    psr: 60000013
[   73.542236] sp : c7fabe70  ip : 80000093  fp : 00000000
[   73.553771] r10: c7ccc47c  r9 : 00000049  r8 : c026c308
[   73.559051] r7 : 00000000  r6 : 00000000  r5 : c7eaa3e4  r4 : c7eaa000
[   73.565612] r3 : ffffffff  r2 : c7fabe58  r1 : 00000000  r0 : c04150b8
[   73.572174] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
[   73.579345] Control: 10c5387d  Table: 87fb8019  DAC: 00000015
[   73.585144] Process sh (pid: 632, stack limit = 0xc7faa2f0)
[   73.590759] Stack: (0xc7fabe70 to 0xc7fac000)
[   73.595153] be60:                                     c02cd42c 00000002 c7ccc400 c026c330
[   73.603363] be80: 00000000 c02314fc c7ccc400 00000002 00000000 00000000 c7ccc400 00000002
[   73.611602] bea0: c7ccc434 00000002 20507908 c0231d78 c7ccc400 00000002 00000000 00000000
[   73.619842] bec0: c7ccc400 00000000 00000002 c02320cc 20507908 00000049 c7ccc07c c7f9947c
[   73.628082] bee0: 00000000 003fffff 00000003 00000004 c05088e9 c0436d6c c7ed6358 c00a3d08
[   73.636322] bf00: c05088e9 00000003 00000000 c00a3f54 c7c6e000 00000003 00000003 c00a36a8
[   73.644531] bf20: c7c14ac8 c7fabf80 c7c01b00 c7ed6340 00000004 c01e4cd8 00000004 c0125190
[   73.652770] bf40: 00000004 c7edc080 4001f000 c7fabf80 00000000 00000000 00000000 c00dbb30
[   73.661010] bf60: c7edc080 4001f000 c7edc080 4001f000 00000004 00000004 00000000 c00dbc78
[   73.669250] bf80: 00000000 00000000 00000004 00000000 00000004 4001f000 401f95e8 c003fae8
[   73.677490] bfa0: c7faa000 c003f920 00000004 4001f000 00000001 4001f000 00000004 00000000
[   73.685699] bfc0: 00000004 4001f000 401f95e8 00000004 00000004 000dc2ac 00000000 00000000
[   73.693939] bfe0: 4001f000 bedde618 401396dc 40189fec 60000010 00000001 81ffe021 81ffe421
[   73.702178] [<c02cd450>] (ads7846_suspend+0x24/0x48) from [<c026c330>] (spi_suspend+0x28/0x34)
[   73.710876] [<c026c330>] (spi_suspend+0x28/0x34) from [<c02314fc>] (legacy_suspend+0x2c/0x64)
[   73.719451] [<c02314fc>] (legacy_suspend+0x2c/0x64) from [<c0231d78>] (__device_suspend+0xf0/0x128)
[   73.728576] [<c0231d78>] (__device_suspend+0xf0/0x128) from [<c02320cc>] (dpm_suspend_start+0x31c/0x454)
[   73.738128] [<c02320cc>] (dpm_suspend_start+0x31c/0x454) from [<c00a3d08>] (suspend_devices_and_enter+0x48/0x1d8)
[   73.748443] [<c00a3d08>] (suspend_devices_and_enter+0x48/0x1d8) from [<c00a3f54>] (enter_state+0xbc/0x120)
[   73.758178] [<c00a3f54>] (enter_state+0xbc/0x120) from [<c00a36a8>] (state_store+0xa4/0xb8)
[   73.766601] [<c00a36a8>] (state_store+0xa4/0xb8) from [<c01e4cd8>] (kobj_attr_store+0x18/0x1c)
[   73.775268] [<c01e4cd8>] (kobj_attr_store+0x18/0x1c) from [<c0125190>] (sysfs_write_file+0x10c/0x144)
[   73.784545] [<c0125190>] (sysfs_write_file+0x10c/0x144) from [<c00dbb30>] (vfs_write+0xb0/0x148)
[   73.793395] [<c00dbb30>] (vfs_write+0xb0/0x148) from [<c00dbc78>] (sys_write+0x3c/0x68)
[   73.801483] [<c00dbc78>] (sys_write+0x3c/0x68) from [<c003f920>] (ret_fast_syscall+0x0/0x3c)
[   73.809967] Code: eb051d39 e1a00005 eb051f11 e5943044 (e5d32074)
[   73.816375] ---[ end trace 1b75b31a2719ed20 ]
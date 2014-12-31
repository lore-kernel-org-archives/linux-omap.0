From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: N900 / v3.19-rc2: nokia-modem crash
Date: Wed, 31 Dec 2014 21:49:51 +0200
Message-ID: <20141231194951.GF582@fuloong-minipc.musicnaut.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from filtteri5.pp.htv.fi ([213.243.153.188]:59380 "EHLO
	filtteri5.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751466AbaLaTuA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 31 Dec 2014 14:50:00 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, linux-omap@vger.kernel.org

Hi,

The below crash seems to be easily reproducible on N900.

Just do: modprobe nokia-modem; modprobe -r nokia-modem; modprobe nokia-modem

[  139.990173] omap_ssi 48058000.ssi-controller: ssi controller 0 initialized (1 ports)!
[  140.022674] NET: Registered protocol family 35
[  140.048797] SSI protocol aka McSAAB added
[  160.323547] SSI protocol driver removed
[  160.462524] NET: Unregistered protocol family 35
[  178.334014] omap_ssi 48058000.ssi-controller: failed to create ssi controller port
[  178.354492] ------------[ cut here ]------------
[  178.365020] WARNING: CPU: 0 PID: 835 at /home/aaro/los/work/shared/linux-v3.19-rc2/fs/sysfs/group.c:219 sysfs_remove_group+0x9c/0xa0()
[  178.389068] sysfs group c0874fb4 not found for kobject 'port0'
[  178.401153] Modules linked in: omap_ssi(+) hsi usb_f_ecm g_ether u_ether libcomposite configfs [last unloaded: phonet]
[  178.425231] CPU: 0 PID: 835 Comm: modprobe Tainted: G        W      3.19.0-rc2-omap3-los_4583+ #1
[  178.441223] Hardware name: Generic OMAP3 (Flattened Device Tree)
[  178.454162] Backtrace: 
[  178.463256] [<c0011d58>] (dump_backtrace) from [<c0011f7c>] (show_stack+0x18/0x1c)
[  178.477966]  r6:c0141c50 r5:00000009 r4:00000000 r3:00000000
[  178.490661] [<c0011f64>] (show_stack) from [<c03d7a8c>] (dump_stack+0x24/0x28)
[  178.504974] [<c03d7a68>] (dump_stack) from [<c0036064>] (warn_slowpath_common+0x8c/0xb8)
[  178.520141] [<c0035fd8>] (warn_slowpath_common) from [<c00360c8>] (warn_slowpath_fmt+0x38/0x40)
[  178.536041]  r8:cfb4b400 r7:cf95b400 r6:cfb4b808 r5:c0874fb4 r4:c04bb964
[  178.549987] [<c0036094>] (warn_slowpath_fmt) from [<c0141c50>] (sysfs_remove_group+0x9c/0xa0)
[  178.565887]  r3:c0874fb4 r2:c04bb964
[  178.576416]  r4:00000000
[  178.585540] [<c0141bb4>] (sysfs_remove_group) from [<c025fc54>] (dpm_sysfs_remove+0x54/0x58)
[  178.601196]  r6:cfb4b800 r5:cfb4b808 r4:c0874fb4
[  178.612915] [<c025fc00>] (dpm_sysfs_remove) from [<c0255e2c>] (device_del+0x40/0x218)
[  178.628295]  r6:bf0593f0 r5:cfb4b800 r4:cfb4b800 r3:00000000
[  178.641479] [<c0255dec>] (device_del) from [<c0256018>] (device_unregister+0x14/0x28)
[  178.656951]  r8:ffffffed r7:cf95b400 r6:bf0593f0 r5:00000000 r4:cfb4b800
[  178.671386] [<c0256004>] (device_unregister) from [<bf059418>] (hsi_remove_port+0x28/0x30 [hsi])
[  178.687896]  r4:cfb4b800 r3:00000000
[  178.698730] [<bf0593f0>] (hsi_remove_port [hsi]) from [<c0255b34>] (device_for_each_child+0x58/0x84)
[  178.722534]  r4:00000000 r3:cfb4b800
[  178.733306] [<c0255adc>] (device_for_each_child) from [<bf0593e4>] (hsi_unregister_controller+0x20/0x2c [hsi])
[  178.757751]  r6:00000001 r5:cfceee10 r4:cfb4b400
[  178.769714] [<bf0593c4>] (hsi_unregister_controller [hsi]) from [<bf0633f4>] (ssi_probe+0x308/0x540 [omap_ssi])
[  178.794464]  r4:00000000 r3:00000002
[  178.805267] [<bf0630ec>] (ssi_probe [omap_ssi]) from [<c025b338>] (platform_drv_probe+0x4c/0xac)
[  178.821838]  r10:00000000 r9:cfb4c048 r8:0000002b r7:fffffdfb r6:bf060f14 r5:cf95b410
[  178.837677]  r4:c0999c74
[  178.847381] [<c025b2ec>] (platform_drv_probe) from [<c0259938>] (driver_probe_device+0x110/0x244)
[  178.864074]  r7:bf060f14 r6:00000000 r5:cf95b410 r4:c0999c74
[  178.877380] [<c0259828>] (driver_probe_device) from [<c0259b4c>] (__driver_attach+0x94/0x98)
[  178.893829]  r8:00000001 r7:00000000 r6:cf95b444 r5:bf060f14 r4:cf95b410 r3:00000000
[  178.909667] [<c0259ab8>] (__driver_attach) from [<c0257cec>] (bus_for_each_dev+0x74/0xa8)
[  178.925811]  r6:c0259ab8 r5:bf060f14 r4:00000000 r3:00000000
[  178.939331] [<c0257c78>] (bus_for_each_dev) from [<c025942c>] (driver_attach+0x24/0x28)
[  178.955322]  r6:c0874bf0 r5:cfb2c680 r4:bf060f14
[  178.967651] [<c0259408>] (driver_attach) from [<c02590d4>] (bus_add_driver+0x150/0x1f8)
[  178.983673] [<c0258f84>] (bus_add_driver) from [<c025a20c>] (driver_register+0x80/0x100)
[  178.999725]  r7:bf06362c r6:cfb4c440 r5:00000001 r4:bf060f14
[  179.013183] [<c025a18c>] (driver_register) from [<c025b27c>] (__platform_driver_register+0x5c/0x64)
[  179.037353]  r5:00000001 r4:bf060f00
[  179.048461] [<c025b220>] (__platform_driver_register) from [<c025b3d8>] (__platform_driver_probe+0x28/0xb8)
[  179.073364] [<c025b3b0>] (__platform_driver_probe) from [<bf063654>] (ssi_pdriver_init+0x28/0x2c [omap_ssi])
[  179.098724]  r6:cfb4c440 r5:c0851ba8 r4:c0851ba8 r3:00000000
[  179.112304] [<bf06362c>] (ssi_pdriver_init [omap_ssi]) from [<c00089f4>] (do_one_initcall+0x94/0x1dc)
[  179.137207] [<c0008960>] (do_one_initcall) from [<c0087bf0>] (load_module+0x15ec/0x1e18)
[  179.153533]  r10:bf060f58 r9:cfb4c048 r8:00000001 r7:cfb4c040 r6:00000001 r5:bf060f64
[  179.169708]  r4:cfb23f48
[  179.179931] [<c0086604>] (load_module) from [<c0088500>] (SyS_init_module+0xe4/0xf8)
[  179.195770]  r10:00000000 r9:cfb22000 r8:c000ed04 r7:00000080 r6:00089ab8 r5:000a34f8
[  179.211822]  r4:00003604
[  179.221923] [<c008841c>] (SyS_init_module) from [<c000eb60>] (ret_fast_syscall+0x0/0x30)
[  179.238067]  r6:00000000 r5:000a34f8 r4:000a3020
[  179.250488] ---[ end trace 3aad5213a8b0928b ]---
[  179.262817] Unable to handle kernel NULL pointer dereference at virtual address 00000044
[  179.278839] pgd = cfb54000
[  179.288909] [00000044] *pgd=8fb0f831, *pte=00000000, *ppte=00000000
[  179.302978] Internal error: Oops: 17 [#1] PREEMPT ARM
[  179.315460] Modules linked in: omap_ssi(+) hsi usb_f_ecm g_ether u_ether libcomposite configfs [last unloaded: phonet]
[  179.341308] CPU: 0 PID: 835 Comm: modprobe Tainted: G        W      3.19.0-rc2-omap3-los_4583+ #1
[  179.358154] Hardware name: Generic OMAP3 (Flattened Device Tree)
[  179.371826] task: cfb21000 ti: cfb22000 task.ti: cfb22000
[  179.384674] PC is at kernfs_find_ns+0x10/0xf8
[  179.396240] LR is at kernfs_find_and_get_ns+0x38/0x50
[  179.408294] pc : [<c013e360>]    lr : [<c013e480>]    psr: 60000013
[  179.408294] sp : cfb23bc0  ip : cfb23be8  fp : cfb23be4
[  179.433746] r10: cfb4b400  r9 : cf95b410  r8 : cfb4b600
[  179.445617] r7 : 00000000  r6 : c0404fa8  r5 : 00000000  r4 : c086cd18
[  179.458740] r3 : 00000000  r2 : 00000000  r1 : c0404fa8  r0 : 00000000
[  179.471740] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
[  179.485321] Control: 10c5387d  Table: 8fb54019  DAC: 00000015
[  179.497375] Process modprobe (pid: 835, stack limit = 0xcfb22238)
[  179.509735] Stack: (0xcfb23bc0 to 0xcfb24000)
[  179.520111] 3bc0: c02556b8 cfb4b824 c086cd18 00000000 c0404fa8 00000000 cfb23c04 cfb23be8
[  179.534729] 3be0: c013e480 c013e35c c0874fe4 cfb4b408 cfb4b400 cf95b400 cfb23c1c cfb23c08
[  179.549255] 3c00: c0141720 c013e454 c0874fb4 cfb4b408 cfb23c3c cfb23c20 c025fc28 c014170c
[  179.563751] 3c20: 00000000 cfb4b400 cfb4b400 00000001 cfb23c74 cfb23c40 c0255e2c c025fc0c
[  179.578124] 3c40: 00000000 00000000 bf0593f0 cf95b400 c02556b8 cfb4b400 cfceee10 00000001
[  179.592437] 3c60: cf95b400 ffffffed cfb23c8c cfb23c78 c0256018 c0255df8 c02556b8 cfb4b400
[  179.606811] 3c80: cfb23ca4 cfb23c90 bf0593ec c0256010 00000002 00000000 cfb23cec cfb23ca8
[  179.621154] 3ca0: bf0633f4 bf0593d0 bf060920 bf060dec cfb4b400 c013dda4 bf060dec cfb25790
[  179.635406] 3cc0: 00000000 c0999c74 cf95b410 bf060f14 fffffdfb 0000002b cfb4c048 00000000
[  179.649536] 3ce0: cfb23d0c cfb23cf0 c025b338 bf0630f8 c0999c74 cf95b410 00000000 bf060f14
[  179.663604] 3d00: cfb23d34 cfb23d10 c0259938 c025b2f8 00000000 cf95b410 bf060f14 cf95b444
[  179.677520] 3d20: 00000000 00000001 cfb23d54 cfb23d38 c0259b4c c0259834 00000000 00000000
[  179.691497] 3d40: bf060f14 c0259ab8 cfb23d7c cfb23d58 c0257cec c0259ac4 cf84104c cf9ad9b0
[  179.705444] 3d60: 00000000 bf060f14 cfb2c680 c0874bf0 cfb23d8c cfb23d80 c025942c c0257c84
[  179.719543] 3d80: cfb23db4 cfb23d90 c02590d4 c0259414 bf060ef4 cfb23da0 bf060f14 00000001
[  179.733642] 3da0: cfb4c440 bf06362c cfb23dcc cfb23db8 c025a20c c0258f90 bf060f00 00000001
[  179.747741] 3dc0: cfb23ddc cfb23dd0 c025b27c c025a198 cfb23dfc cfb23de0 c025b3d8 c025b22c
[  179.761932] 3de0: 00000000 c0851ba8 c0851ba8 cfb4c440 cfb23e0c cfb23e00 bf063654 c025b3bc
[  179.776214] 3e00: cfb23e8c cfb23e10 c00089f4 bf063638 c00d1c2c cf801f00 cfb22000 000040bc
[  179.790557] 3e20: cfb23e5c cfb23e30 c00debf4 c00de580 00000002 00000004 cfb48100 d0b48000
[  179.804840] 3e40: 00000001 00000001 cfb4c048 bf060f58 cfb23e7c cfb23e60 c00d1c2c c00deab0
[  179.819152] 3e60: cfb23f48 cfb23f48 bf060f64 00000001 cfb4c040 00000001 cfb4c048 bf060f58
[  179.833496] 3e80: cfb23f44 cfb23e90 c0087bf0 c000896c bf060f64 00007fff c00851ac c0007430
[  179.847839] 3ea0: 00000000 00000000 bf060f64 bf06107c d0b49d44 bf060f64 bf060f64 cfb23f48
[  179.862121] 3ec0: bf060fa0 00000000 cfb23eec cfb23ed8 c00d11e4 c00d0ff8 cfb48bc0 00000000
[  179.876434] 3ee0: 00000000 bf0608a0 00000001 00000000 00000000 00000000 00000000 00000000
[  179.890838] 3f00: 00000000 00000000 00000000 00000000 00000000 00000000 cfb23f44 00003604
[  179.905120] 3f20: 000a34f8 00089ab8 00000080 c000ed04 cfb22000 00000000 cfb23fa4 cfb23f48
[  179.919372] 3f40: c0088500 c0086610 d0b48000 00003604 d0b49984 d0b4988f d0b4a744 000010a8
[  179.933624] 3f60: 00001578 00000000 00000000 00000000 00000018 00000019 00000011 00000000
[  179.947845] 3f80: 0000000c 00000000 c0011a34 000a3020 000a34f8 00000000 00000000 cfb23fa8
[  179.961975] 3fa0: c000eb60 c0088428 000a3020 000a34f8 000a34f8 00003604 00089ab8 00000000
[  179.976043] 3fc0: 000a3020 000a34f8 00000000 00000080 00096290 000a2530 00000000 00095930
[  179.990051] 3fe0: 000934f8 befb2968 000142ec b6f266a0 60000010 000a34f8 8fefd821 8fefdc21
[  180.004119] Backtrace: 
[  180.011962] [<c013e350>] (kernfs_find_ns) from [<c013e480>] (kernfs_find_and_get_ns+0x38/0x50)
[  180.026672]  r7:00000000 r6:c0404fa8 r5:00000000 r4:c086cd18
[  180.038330] [<c013e448>] (kernfs_find_and_get_ns) from [<c0141720>] (sysfs_unmerge_group+0x20/0x60)
[  180.059265]  r7:cf95b400 r6:cfb4b400 r5:cfb4b408 r4:c0874fe4
[  180.071197] [<c0141700>] (sysfs_unmerge_group) from [<c025fc28>] (dpm_sysfs_remove+0x28/0x58)
[  180.086273]  r5:cfb4b408 r4:c0874fb4
[  180.096069] [<c025fc00>] (dpm_sysfs_remove) from [<c0255e2c>] (device_del+0x40/0x218)
[  180.110565]  r6:00000001 r5:cfb4b400 r4:cfb4b400 r3:00000000
[  180.122833] [<c0255dec>] (device_del) from [<c0256018>] (device_unregister+0x14/0x28)
[  180.137390]  r8:ffffffed r7:cf95b400 r6:00000001 r5:cfceee10 r4:cfb4b400
[  180.150939] [<c0256004>] (device_unregister) from [<bf0593ec>] (hsi_unregister_controller+0x28/0x2c [hsi])
[  180.173858]  r4:cfb4b400 r3:c02556b8
[  180.184020] [<bf0593c4>] (hsi_unregister_controller [hsi]) from [<bf0633f4>] (ssi_probe+0x308/0x540 [omap_ssi])
[  180.208068]  r4:00000000 r3:00000002
[  180.218566] [<bf0630ec>] (ssi_probe [omap_ssi]) from [<c025b338>] (platform_drv_probe+0x4c/0xac)
[  180.234832]  r10:00000000 r9:cfb4c048 r8:0000002b r7:fffffdfb r6:bf060f14 r5:cf95b410
[  180.250366]  r4:c0999c74
[  180.260070] [<c025b2ec>] (platform_drv_probe) from [<c0259938>] (driver_probe_device+0x110/0x244)
[  180.276855]  r7:bf060f14 r6:00000000 r5:cf95b410 r4:c0999c74
[  180.290344] [<c0259828>] (driver_probe_device) from [<c0259b4c>] (__driver_attach+0x94/0x98)
[  180.306762]  r8:00000001 r7:00000000 r6:cf95b444 r5:bf060f14 r4:cf95b410 r3:00000000
[  180.322601] [<c0259ab8>] (__driver_attach) from [<c0257cec>] (bus_for_each_dev+0x74/0xa8)
[  180.338714]  r6:c0259ab8 r5:bf060f14 r4:00000000 r3:00000000
[  180.352172] [<c0257c78>] (bus_for_each_dev) from [<c025942c>] (driver_attach+0x24/0x28)
[  180.368011]  r6:c0874bf0 r5:cfb2c680 r4:bf060f14
[  180.380279] [<c0259408>] (driver_attach) from [<c02590d4>] (bus_add_driver+0x150/0x1f8)
[  180.396179] [<c0258f84>] (bus_add_driver) from [<c025a20c>] (driver_register+0x80/0x100)
[  180.412139]  r7:bf06362c r6:cfb4c440 r5:00000001 r4:bf060f14
[  180.425506] [<c025a18c>] (driver_register) from [<c025b27c>] (__platform_driver_register+0x5c/0x64)
[  180.449707]  r5:00000001 r4:bf060f00
[  180.460693] [<c025b220>] (__platform_driver_register) from [<c025b3d8>] (__platform_driver_probe+0x28/0xb8)
[  180.485473] [<c025b3b0>] (__platform_driver_probe) from [<bf063654>] (ssi_pdriver_init+0x28/0x2c [omap_ssi])
[  180.510711]  r6:cfb4c440 r5:c0851ba8 r4:c0851ba8 r3:00000000
[  180.524200] [<bf06362c>] (ssi_pdriver_init [omap_ssi]) from [<c00089f4>] (do_one_initcall+0x94/0x1dc)
[  180.549011] [<c0008960>] (do_one_initcall) from [<c0087bf0>] (load_module+0x15ec/0x1e18)
[  180.565277]  r10:bf060f58 r9:cfb4c048 r8:00000001 r7:cfb4c040 r6:00000001 r5:bf060f64
[  180.581359]  r4:cfb23f48
[  180.591522] [<c0086604>] (load_module) from [<c0088500>] (SyS_init_module+0xe4/0xf8)
[  180.607330]  r10:00000000 r9:cfb22000 r8:c000ed04 r7:00000080 r6:00089ab8 r5:000a34f8
[  180.623321]  r4:00003604
[  180.633361] [<c008841c>] (SyS_init_module) from [<c000eb60>] (ret_fast_syscall+0x0/0x30)
[  180.649383]  r6:00000000 r5:000a34f8 r4:000a3020
[  180.661712] Code: e1a0c00d e92dd8f0 e24cb004 e24dd008 (e1d0c4b4) 
[  180.675659] ---[ end trace 3aad5213a8b0928c ]---
[  180.687774] Kernel panic - not syncing: Fatal exception
[  180.700439] ---[ end Kernel panic - not syncing: Fatal exception

A.

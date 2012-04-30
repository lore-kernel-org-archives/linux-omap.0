From: Enrico <ebutera@users.sourceforge.net>
Subject: "smsc911x: Add fixed board regulators" problem
Date: Mon, 30 Apr 2012 16:58:37 +0200
Message-ID: <CA+2YH7tPBeJARm=ipq=HTtqNH6pDu8yQKMRMgL1Cz9rkSpzRBQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:39150 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752230Ab2D3O6i (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 30 Apr 2012 10:58:38 -0400
Received: by vbbff1 with SMTP id ff1so2093265vbb.19
        for <linux-omap@vger.kernel.org>; Mon, 30 Apr 2012 07:58:37 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Russ Dill <Russ.Dill@ti.com>, Enric Balletbo i Serra <eballetbo@iseebcn.com>

Hi,

hi get this at boot on an IGEP board (igep0020), latest linux-omap
master (20 Apr):

[    0.047704] WARNING: at fs/sysfs/dir.c:508 sysfs_add_one+0x9c/0xac()
[    0.047712] sysfs: cannot create duplicate filename
'/devices/platform/reg-fixed-voltage.0'
[    0.047720] Modules linked in:
[    0.047754] [<c0012dd0>] (unwind_backtrace+0x0/0xf8) from
[<c002d694>] (warn_slowpath_common+0x54/0x64)
[    0.047772] [<c002d694>] (warn_slowpath_common+0x54/0x64) from
[<c002d738>] (warn_slowpath_fmt+0x30/0x40)
[    0.047788] [<c002d738>] (warn_slowpath_fmt+0x30/0x40) from
[<c01065e8>] (sysfs_add_one+0x9c/0xac)
[    0.047804] [<c01065e8>] (sysfs_add_one+0x9c/0xac) from
[<c01067c0>] (create_dir+0x60/0xb4)
[    0.047817] [<c01067c0>] (create_dir+0x60/0xb4) from [<c0106b2c>]
(sysfs_create_dir+0x90/0xe8)
[    0.047838] [<c0106b2c>] (sysfs_create_dir+0x90/0xe8) from
[<c0218c80>] (kobject_add_internal+0x88/0x200)
[    0.047856] [<c0218c80>] (kobject_add_internal+0x88/0x200) from
[<c02191c4>] (kobject_add+0x50/0x98)
[    0.047880] [<c02191c4>] (kobject_add+0x50/0x98) from [<c025dd74>]
(device_add+0xcc/0x5a4)
[    0.047900] [<c025dd74>] (device_add+0xcc/0x5a4) from [<c026195c>]
(platform_device_add+0x108/0x1b4)
[    0.047916] [<c026195c>] (platform_device_add+0x108/0x1b4) from
[<c0261b28>] (platform_add_devices+0x34/0x60)
[    0.047935] [<c0261b28>] (platform_add_devices+0x34/0x60) from
[<c056cdc0>] (igep_init+0x2ec/0x768)
[    0.047956] [<c056cdc0>] (igep_init+0x2ec/0x768) from [<c05635e0>]
(customize_machine+0x20/0x28)
[    0.047974] [<c05635e0>] (customize_machine+0x20/0x28) from
[<c00086e4>] (do_one_initcall+0x34/0x174)
[    0.047990] [<c00086e4>] (do_one_initcall+0x34/0x174) from
[<c05608d8>] (kernel_init+0x13c/0x1e8)
[    0.048009] [<c05608d8>] (kernel_init+0x13c/0x1e8) from
[<c000e80c>] (kernel_thread_exit+0x0/0x8)
[    0.048044] ---[ end trace 1b75b31a2719ed1c ]---
[    0.048055] ------------[ cut here ]------------
[    0.048066] WARNING: at lib/kobject.c:198 kobject_add_internal+0x1fc/0x200()
[    0.048075] kobject_add_internal failed for reg-fixed-voltage.0
with -EEXIST, don't try to register things with the same name in the
same directory.
[    0.048086] Modules linked in:
[    0.048099] [<c0012dd0>] (unwind_backtrace+0x0/0xf8) from
[<c002d694>] (warn_slowpath_common+0x54/0x64)
[    0.048116] [<c002d694>] (warn_slowpath_common+0x54/0x64) from
[<c002d738>] (warn_slowpath_fmt+0x30/0x40)
[    0.048132] [<c002d738>] (warn_slowpath_fmt+0x30/0x40) from
[<c0218df4>] (kobject_add_internal+0x1fc/0x200)
[    0.048148] [<c0218df4>] (kobject_add_internal+0x1fc/0x200) from
[<c02191c4>] (kobject_add+0x50/0x98)
[    0.048165] [<c02191c4>] (kobject_add+0x50/0x98) from [<c025dd74>]
(device_add+0xcc/0x5a4)
[    0.048181] [<c025dd74>] (device_add+0xcc/0x5a4) from [<c026195c>]
(platform_device_add+0x108/0x1b4)
[    0.048196] [<c026195c>] (platform_device_add+0x108/0x1b4) from
[<c0261b28>] (platform_add_devices+0x34/0x60)
[    0.048212] [<c0261b28>] (platform_add_devices+0x34/0x60) from
[<c056cdc0>] (igep_init+0x2ec/0x768)
[    0.048227] [<c056cdc0>] (igep_init+0x2ec/0x768) from [<c05635e0>]
(customize_machine+0x20/0x28)
[    0.048242] [<c05635e0>] (customize_machine+0x20/0x28) from
[<c00086e4>] (do_one_initcall+0x34/0x174)
[    0.048257] [<c00086e4>] (do_one_initcall+0x34/0x174) from
[<c05608d8>] (kernel_init+0x13c/0x1e8)
[    0.048273] [<c05608d8>] (kernel_init+0x13c/0x1e8) from
[<c000e80c>] (kernel_thread_exit+0x0/0x8)

and

[    2.430117] WARNING: at drivers/regulator/core.c:1551
_regulator_disable+0xfc/0x15c()
[    2.438316] unbalanced disables for dummy
[    2.442523] Modules linked in:
[    2.445747] [<c0012dd0>] (unwind_backtrace+0x0/0xf8) from
[<c002d694>] (warn_slowpath_common+0x54/0x64)
[    2.455607] [<c002d694>] (warn_slowpath_common+0x54/0x64) from
[<c002d738>] (warn_slowpath_fmt+0x30/0x40)
[    2.465647] [<c002d738>] (warn_slowpath_fmt+0x30/0x40) from
[<c0236fc4>] (_regulator_disable+0xfc/0x15c)
[    2.475596] [<c0236fc4>] (_regulator_disable+0xfc/0x15c) from
[<c0237040>] (regulator_disable+0x1c/0x48)
[    2.485552] [<c0237040>] (regulator_disable+0x1c/0x48) from
[<c02eb700>] (omap_hsmmc_set_power+0x90/0x118)
[    2.495689] [<c02eb700>] (omap_hsmmc_set_power+0x90/0x118) from
[<c03e8448>] (omap_hsmmc_probe+0x70c/0x9d0)
[    2.505914] [<c03e8448>] (omap_hsmmc_probe+0x70c/0x9d0) from
[<c0261408>] (platform_drv_probe+0x18/0x1c)
[    2.515860] [<c0261408>] (platform_drv_probe+0x18/0x1c) from
[<c0260230>] (driver_probe_device+0xa0/0x224)
[    2.525988] [<c0260230>] (driver_probe_device+0xa0/0x224) from
[<c0260440>] (__driver_attach+0x8c/0x90)
[    2.535842] [<c0260440>] (__driver_attach+0x8c/0x90) from
[<c025ec74>] (bus_for_each_dev+0x50/0x7c)
[    2.545331] [<c025ec74>] (bus_for_each_dev+0x50/0x7c) from
[<c025f95c>] (bus_add_driver+0xa4/0x23c)
[    2.554821] [<c025f95c>] (bus_add_driver+0xa4/0x23c) from
[<c0260968>] (driver_register+0x78/0x12c)
[    2.564310] [<c0260968>] (driver_register+0x78/0x12c) from
[<c00086e4>] (do_one_initcall+0x34/0x174)
[    2.573895] [<c00086e4>] (do_one_initcall+0x34/0x174) from
[<c05608d8>] (kernel_init+0x13c/0x1e8)
[    2.583208] [<c05608d8>] (kernel_init+0x13c/0x1e8) from
[<c000e80c>] (kernel_thread_exit+0x0/0x8)
[    2.592510] ---[ end trace 1b75b31a2719ed1e ]---
[    2.598821] omap_hsmmc omap_hsmmc.1: could not set regulator OCR (-22)


Reverting the patch in subject (commit
5b3689f4c16bc692a2e2b9808e5efc457aeae371) fixes it. In both cases
network works (it boots from nfs).

I doubt it's a proper fix, but i don't know where to look at...any ideas?

Enrico

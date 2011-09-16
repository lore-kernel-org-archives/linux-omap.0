From: Christian Gmeiner <christian.gmeiner@gmail.com>
Subject: Re: Problems with 3.1.0-rc6 on at3517evm
Date: Fri, 16 Sep 2011 16:10:20 +0200
Message-ID: <CAH9NwWd-+w5egW_L_c_LB=v8hQu0Ok1w6N36FCFOHHA=7YX1iA@mail.gmail.com>
References: <CAH9NwWdgzaowJ+3dUC2PHp2j7bmbaE0COsgngio=gz4q+KzchQ@mail.gmail.com>
 <FCCFB4CDC6E5564B9182F639FC356087037AF843E5@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:50749 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754019Ab1IPOKl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Sep 2011 10:10:41 -0400
Received: by iaqq3 with SMTP id q3so2288128iaq.19
        for <linux-omap@vger.kernel.org>; Fri, 16 Sep 2011 07:10:40 -0700 (PDT)
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC356087037AF843E5@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Koyamangalath, Abhilash" <abhilash.kv@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi

2011/9/16 Koyamangalath, Abhilash <abhilash.kv@ti.com>:
>
>
> On Fri, Sep 16, 2011 at 7:05 PM, Christian Gmeiner wrote:
>>
>>
>> Hi all,
>>
>> I am owning a ZOOM am3517evm evaluation board, where I want to run t=
he
>> latest linux kernel (mainline).
>> I am not able to boot this board. Are there any patches to fix this
>> issues? The deliverd kernel (2.6.32-psp09.00.01.06.sdk)
>> boots fine.
> [Abhilash =C2=A0K V] Can you try this patch-set to boot up ?
> http://marc.info/?l=3Dlinux-omap&m=3D131548349725176&w=3D2
>

Could you rebase your work to current git?

patching file arch/arm/mach-omap2/io.c
Hunk #1 succeeded at 239 with fuzz 1.
Hunk #2 FAILED at 437.
1 out of 2 hunks FAILED -- saving rejects to file arch/arm/mach-omap2/i=
o.c.rej
patching file arch/arm/mach-omap2/omap_hwmod.c
Hunk #1 FAILED at 1954.
1 out of 1 hunk FAILED -- saving rejects to file
arch/arm/mach-omap2/omap_hwmod.c.rej
patching file arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
Hunk #1 succeeded at 3281 with fuzz 1.
patching file arch/arm/plat-omap/include/plat/omap_hwmod.h
Hunk #1 FAILED at 398.
Hunk #2 FAILED at 408.
2 out of 3 hunks FAILED -- saving rejects to file
arch/arm/plat-omap/include/plat/omap_hwmod.h.rej



> Would it also be possible for you to test these other patches,
> which add support for the am35xx ?
> http://marc.info/?l=3Dlinux-kernel&m=3D131548606728209&w=3D2
> &
> http://marc.info/?l=3Dlinux-omap&m=3D131600817432044&w=3D2
>

I will test every patch... and will give my tested-by if every thing wo=
rks :)

>
> thanks and regards
> Abhilash


thanks,
--
Christian Gmeiner, MSc

>>
>> --
>> reading uImage
>>
>> 2136480 bytes read
>> Booting from mmc ...
>> ## Booting kernel from Legacy Image at 82000000 ...
>> =C2=A0Image Name: =C2=A0 Linux-3.1.0-rc6+
>> =C2=A0Image Type: =C2=A0 ARM Linux Kernel Image (uncompressed)
>> =C2=A0Data Size: =C2=A0 =C2=A02136416 Bytes =3D =C2=A02 MB
>> =C2=A0Load Address: 80008000
>> =C2=A0Entry Point: =C2=A080008000
>> =C2=A0Verifying Checksum ... OK
>> =C2=A0Loading Kernel Image ... OK
>> OK
>>
>> Starting kernel ...
>>
>> Uncompressing Linux... done, booting the kernel.
>> x60/0x98) from [<c0008734>] (do_one_initcall+0x90/0x160)
>> [<c0008734>] (do_one_initcall+0x90/0x160) from [<c03c6780>]
>> (kernel_init+0x74/0x118)
>> [<c03c6780>] (kernel_init+0x74/0x118) from [<c0013218>]
>> (kernel_thread_exit+0x0/0x8)
>> ---[ end trace 1b75b31a2719ed1c ]---
>> print_constraints: dummy:
>> NET: Registered protocol family 16
>> GPMC revision 5.0
>> ------------[ cut here ]------------
>> WARNING: at arch/arm/mach-omap2/omap_hwmod.c:1448 _enable+0x38/0x1d0=
()
>> omap_hwmod: gpio1: enabled state can only be entered from initialize=
d,
>> idle, or disabled state
>> Modules linked in:
>> [<c00171ec>] (unwind_backtrace+0x0/0xe0) from [<c00308c0>]
>> (warn_slowpath_common+0x4c/0x64)
>> [<c00308c0>] (warn_slowpath_common+0x4c/0x64) from [<c0030958>]
>> (warn_slowpath_fmt+0x2c/0x3c)
>> [<c0030958>] (warn_slowpath_fmt+0x2c/0x3c) from [<c001e3ac>]
>> (_enable+0x38/0x1d0)
>> [<c001e3ac>] (_enable+0x38/0x1d0) from [<c001eae4>]
>> (omap_hwmod_enable+0x18/0x28)
>> [<c001eae4>] (omap_hwmod_enable+0x18/0x28) from [<c0029014>]
>> (omap_device_enable_hwmods+0x20/0x34)
>> [<c0029014>] (omap_device_enable_hwmods+0x20/0x34) from [<c00287cc>]
>> (_omap_device_activate+0x5c/0x138)
>> [<c00287cc>] (_omap_device_activate+0x5c/0x138) from [<c0028d50>]
>> (omap_device_enable+0x54/0x80)
>> [<c0028d50>] (omap_device_enable+0x54/0x80) from [<c0028d8c>]
>> (_od_runtime_resume+0x10/0x1c)
>> [<c0028d8c>] (_od_runtime_resume+0x10/0x1c) from [<c01bc4b8>]
>> (rpm_callback+0x3c/0x58)
>> [<c01bc4b8>] (rpm_callback+0x3c/0x58) from [<c01bcfa0>] (rpm_resume+=
0x290/0x398)
>> [<c01bcfa0>] (rpm_resume+0x290/0x398) from [<c01bd288>]
>> (__pm_runtime_resume+0x30/0x48)
>> [<c01bd288>] (__pm_runtime_resume+0x30/0x48) from [<c02b4164>]
>> (omap_gpio_probe+0x16c/0x334)
>> [<c02b4164>] (omap_gpio_probe+0x16c/0x334) from [<c01b8058>]
>> (platform_drv_probe+0x14/0x18)
>> [<c01b8058>] (platform_drv_probe+0x14/0x18) from [<c01b6fc4>]
>> (driver_probe_device+0xc8/0x184)
>> [<c01b6fc4>] (driver_probe_device+0xc8/0x184) from [<c01b70e0>]
>> (__driver_attach+0x60/0x84)
>> [<c01b70e0>] (__driver_attach+0x60/0x84) from [<c01b6274>]
>> (bus_for_each_dev+0x4c/0x78)
>> [<c01b6274>] (bus_for_each_dev+0x4c/0x78) from [<c01b68e4>]
>> (bus_add_driver+0x98/0x210)
>> [<c01b68e4>] (bus_add_driver+0x98/0x210) from [<c01b75ec>]
>> (driver_register+0xa0/0x120)
>> [<c01b75ec>] (driver_register+0xa0/0x120) from [<c0008734>]
>> (do_one_initcall+0x90/0x160)
>> [<c0008734>] (do_one_initcall+0x90/0x160) from [<c03c6780>]
>> (kernel_init+0x74/0x118)
>> [<c03c6780>] (kernel_init+0x74/0x118) from [<c0013218>]
>> (kernel_thread_exit+0x0/0x8)
>> ---[ end trace 1b75b31a2719ed1d ]---
>> omap_device: omap_gpio.0: new worst case activate latency 0: 671386
>> OMAP GPIO hardware version 2.5
>> ------------[ cut here ]------------
>> WARNING: at arch/arm/mach-omap2/omap_hwmod.c:1448 _enable+0x38/0x1d0=
()
>> omap_hwmod: gpio2: enabled state can only be entered from initialize=
d,
>> idle, or disabled state
>> Modules linked in:
>> [<c00171ec>] (unwind_backtrace+0x0/0xe0) from [<c00308c0>]
>> (warn_slowpath_common+0x4c/0x64)
>> [<c00308c0>] (warn_slowpath_common+0x4c/0x64) from [<c0030958>]
>> (warn_slowpath_fmt+0x2c/0x3c)
>> [<c0030958>] (warn_slowpath_fmt+0x2c/0x3c) from [<c001e3ac>]
>> (_enable+0x38/0x1d0)
>> [<c001e3ac>] (_enable+0x38/0x1d0) from [<c001eae4>]
>> (omap_hwmod_enable+0x18/0x28)
>> [<c001eae4>] (omap_hwmod_enable+0x18/0x28) from [<c0029014>]
>> (omap_device_enable_hwmods+0x20/0x34)
>> [<c0029014>] (omap_device_enable_hwmods+0x20/0x34) from [<c00287cc>]
>> (_omap_device_activate+0x5c/0x138)
>> [<c00287cc>] (_omap_device_activate+0x5c/0x138) from [<c0028d50>]
>> (omap_device_enable+0x54/0x80)
>> [<c0028d50>] (omap_device_enable+0x54/0x80) from [<c0028d8c>]
>> (_od_runtime_resume+0x10/0x1c)
>> [<c0028d8c>] (_od_runtime_resume+0x10/0x1c) from [<c01bc4b8>]
>> (rpm_callback+0x3c/0x58)
>> [<c01bc4b8>] (rpm_callback+0x3c/0x58) from [<c01bcfa0>] (rpm_resume+=
0x290/0x398)
>> [<c01bcfa0>] (rpm_resume+0x290/0x398) from [<c01bd288>]
>> (__pm_runtime_resume+0x30/0x48)
>> [<c01bd288>] (__pm_runtime_resume+0x30/0x48) from [<c02b4164>]
>> (omap_gpio_probe+0x16c/0x334)
>> [<c02b4164>] (omap_gpio_probe+0x16c/0x334) from [<c01b8058>]
>> (platform_drv_probe+0x14/0x18)
>> [<c01b8058>] (platform_drv_probe+0x14/0x18) from [<c01b6fc4>]
>> (driver_probe_device+0xc8/0x184)
>> [<c01b6fc4>] (driver_probe_device+0xc8/0x184) from [<c01b70e0>]
>> (__driver_attach+0x60/0x84)
>> [<c01b70e0>] (__driver_attach+0x60/0x84) from [<c01b6274>]
>> (bus_for_each_dev+0x4c/0x78)
>> [<c01b6274>] (bus_for_each_dev+0x4c/0x78) from [<c01b68e4>]
>> (bus_add_driver+0x98/0x210)
>> [<c01b68e4>] (bus_add_driver+0x98/0x210) from [<c01b75ec>]
>> (driver_register+0xa0/0x120)
>> [<c01b75ec>] (driver_register+0xa0/0x120) from [<c0008734>]
>> (do_one_initcall+0x90/0x160)
>> [<c0008734>] (do_one_initcall+0x90/0x160) from [<c03c6780>]
>> (kernel_init+0x74/0x118)
>> [<c03c6780>] (kernel_init+0x74/0x118) from [<c0013218>]
>> (kernel_thread_exit+0x0/0x8)
>> ---[ end trace 1b75b31a2719ed1e ]---
>> ------------[ cut here ]------------
>> WARNING: at arch/arm/mach-omap2/omap_hwmod.c:1448 _enable+0x38/0x1d0=
()
>> omap_hwmod: gpio3: enabled state can only be entered from initialize=
d,
>> idle, or disabled state
>> Modules linked in:
>> [<c00171ec>] (unwind_backtrace+0x0/0xe0) from [<c00308c0>]
>> (warn_slowpath_common+0x4c/0x64)
>> [<c00308c0>] (warn_slowpath_common+0x4c/0x64) from [<c0030958>]
>> (warn_slowpath_fmt+0x2c/0x3c)
>> [<c0030958>] (warn_slowpath_fmt+0x2c/0x3c) from [<c001e3ac>]
>> (_enable+0x38/0x1d0)
>> [<c001e3ac>] (_enable+0x38/0x1d0) from [<c001eae4>]
>> (omap_hwmod_enable+0x18/0x28)
>> [<c001eae4>] (omap_hwmod_enable+0x18/0x28) from [<c0029014>]
>> (omap_device_enable_hwmods+0x20/0x34)
>> [<c0029014>] (omap_device_enable_hwmods+0x20/0x34) from [<c00287cc>]
>> (_omap_device_activate+0x5c/0x138)
>> [<c00287cc>] (_omap_device_activate+0x5c/0x138) from [<c0028d50>]
>> (omap_device_enable+0x54/0x80)
>> [<c0028d50>] (omap_device_enable+0x54/0x80) from [<c0028d8c>]
>> (_od_runtime_resume+0x10/0x1c)
>> [<c0028d8c>] (_od_runtime_resume+0x10/0x1c) from [<c01bc4b8>]
>> (rpm_callback+0x3c/0x58)
>> [<c01bc4b8>] (rpm_callback+0x3c/0x58) from [<c01bcfa0>] (rpm_resume+=
0x290/0x398)
>> [<c01bcfa0>] (rpm_resume+0x290/0x398) from [<c01bd288>]
>> (__pm_runtime_resume+0x30/0x48)
>> [<c01bd288>] (__pm_runtime_resume+0x30/0x48) from [<c02b4164>]
>> (omap_gpio_probe+0x16c/0x334)
>> [<c02b4164>] (omap_gpio_probe+0x16c/0x334) from [<c01b8058>]
>> (platform_drv_probe+0x14/0x18)
>> [<c01b8058>] (platform_drv_probe+0x14/0x18) from [<c01b6fc4>]
>> (driver_probe_device+0xc8/0x184)
>> [<c01b6fc4>] (driver_probe_device+0xc8/0x184) from [<c01b70e0>]
>> (__driver_attach+0x60/0x84)
>> [<c01b70e0>] (__driver_attach+0x60/0x84) from [<c01b6274>]
>> (bus_for_each_dev+0x4c/0x78)
>> [<c01b6274>] (bus_for_each_dev+0x4c/0x78) from [<c01b68e4>]
>> (bus_add_driver+0x98/0x210)
>> [<c01b68e4>] (bus_add_driver+0x98/0x210) from [<c01b75ec>]
>> (driver_register+0xa0/0x120)
>> [<c01b75ec>] (driver_register+0xa0/0x120) from [<c0008734>]
>> (do_one_initcall+0x90/0x160)
>> [<c0008734>] (do_one_initcall+0x90/0x160) from [<c03c6780>]
>> (kernel_init+0x74/0x118)
>> [<c03c6780>] (kernel_init+0x74/0x118) from [<c0013218>]
>> (kernel_thread_exit+0x0/0x8)
>> ---[ end trace 1b75b31a2719ed1f ]---
>> ------------[ cut here ]------------
>> WARNING: at arch/arm/mach-omap2/omap_hwmod.c:1448 _enable+0x38/0x1d0=
()
>> omap_hwmod: gpio4: enabled state can only be entered from initialize=
d,
>> idle, or disabled state
>> Modules linked in:
>> [<c00171ec>] (unwind_backtrace+0x0/0xe0) from [<c00308c0>]
>> (warn_slowpath_common+0x4c/0x64)
>> [<c00308c0>] (warn_slowpath_common+0x4c/0x64) from [<c0030958>]
>> (warn_slowpath_fmt+0x2c/0x3c)
>> [<c0030958>] (warn_slowpath_fmt+0x2c/0x3c) from [<c001e3ac>]
>> (_enable+0x38/0x1d0)
>> [<c001e3ac>] (_enable+0x38/0x1d0) from [<c001eae4>]
>> (omap_hwmod_enable+0x18/0x28)
>> [<c001eae4>] (omap_hwmod_enable+0x18/0x28) from [<c0029014>]
>> (omap_device_enable_hwmods+0x20/0x34)
>> [<c0029014>] (omap_device_enable_hwmods+0x20/0x34) from [<c00287cc>]
>> (_omap_device_activate+0x5c/0x138)
>> [<c00287cc>] (_omap_device_activate+0x5c/0x138) from [<c0028d50>]
>> (omap_device_enable+0x54/0x80)
>> [<c0028d50>] (omap_device_enable+0x54/0x80) from [<c0028d8c>]
>> (_od_runtime_resume+0x10/0x1c)
>> [<c0028d8c>] (_od_runtime_resume+0x10/0x1c) from [<c01bc4b8>]
>> (rpm_callback+0x3c/0x58)
>> [<c01bc4b8>] (rpm_callback+0x3c/0x58) from [<c01bcfa0>] (rpm_resume+=
0x290/0x398)
>> [<c01bcfa0>] (rpm_resume+0x290/0x398) from [<c01bd288>]
>> (__pm_runtime_resume+0x30/0x48)
>> [<c01bd288>] (__pm_runtime_resume+0x30/0x48) from [<c02b4164>]
>> (omap_gpio_probe+0x16c/0x334)
>> [<c02b4164>] (omap_gpio_probe+0x16c/0x334) from [<c01b8058>]
>> (platform_drv_probe+0x14/0x18)
>> [<c01b8058>] (platform_drv_probe+0x14/0x18) from [<c01b6fc4>]
>> (driver_probe_device+0xc8/0x184)
>> [<c01b6fc4>] (driver_probe_device+0xc8/0x184) from [<c01b70e0>]
>> (__driver_attach+0x60/0x84)
>> [<c01b70e0>] (__driver_attach+0x60/0x84) from [<c01b6274>]
>> (bus_for_each_dev+0x4c/0x78)
>> [<c01b6274>] (bus_for_each_dev+0x4c/0x78) from [<c01b68e4>]
>> (bus_add_driver+0x98/0x210)
>> [<c01b68e4>] (bus_add_driver+0x98/0x210) from [<c01b75ec>]
>> (driver_register+0xa0/0x120)
>> [<c01b75ec>] (driver_register+0xa0/0x120) from [<c0008734>]
>> (do_one_initcall+0x90/0x160)
>> [<c0008734>] (do_one_initcall+0x90/0x160) from [<c03c6780>]
>> (kernel_init+0x74/0x118)
>> [<c03c6780>] (kernel_init+0x74/0x118) from [<c0013218>]
>> (kernel_thread_exit+0x0/0x8)
>> ---[ end trace 1b75b31a2719ed20 ]---
>> ------------[ cut here ]------------
>> WARNING: at arch/arm/mach-omap2/omap_hwmod.c:1448 _enable+0x38/0x1d0=
()
>> omap_hwmod: gpio5: enabled state can only be entered from initialize=
d,
>> idle, or disabled state
>> Modules linked in:
>> [<c00171ec>] (unwind_backtrace+0x0/0xe0) from [<c00308c0>]
>> (warn_slowpath_common+0x4c/0x64)
>> [<c00308c0>] (warn_slowpath_common+0x4c/0x64) from [<c0030958>]
>> (warn_slowpath_fmt+0x2c/0x3c)
>> [<c0030958>] (warn_slowpath_fmt+0x2c/0x3c) from [<c001e3ac>]
>> (_enable+0x38/0x1d0)
>> [<c001e3ac>] (_enable+0x38/0x1d0) from [<c001eae4>]
>> (omap_hwmod_enable+0x18/0x28)
>> [<c001eae4>] (omap_hwmod_enable+0x18/0x28) from [<c0029014>]
>> (omap_device_enable_hwmods+0x20/0x34)
>> [<c0029014>] (omap_device_enable_hwmods+0x20/0x34) from [<c00287cc>]
>> (_omap_device_activate+0x5c/0x138)
>> [<c00287cc>] (_omap_device_activate+0x5c/0x138) from [<c0028d50>]
>> (omap_device_enable+0x54/0x80)
>> [<c0028d50>] (omap_device_enable+0x54/0x80) from [<c0028d8c>]
>> (_od_runtime_resume+0x10/0x1c)
>> [<c0028d8c>] (_od_runtime_resume+0x10/0x1c) from [<c01bc4b8>]
>> (rpm_callback+0x3c/0x58)
>> [<c01bc4b8>] (rpm_callback+0x3c/0x58) from [<c01bcfa0>] (rpm_resume+=
0x290/0x398)
>> [<c01bcfa0>] (rpm_resume+0x290/0x398) from [<c01bd288>]
>> (__pm_runtime_resume+0x30/0x48)
>> [<c01bd288>] (__pm_runtime_resume+0x30/0x48) from [<c02b4164>]
>> (omap_gpio_probe+0x16c/0x334)
>> [<c02b4164>] (omap_gpio_probe+0x16c/0x334) from [<c01b8058>]
>> (platform_drv_probe+0x14/0x18)
>> [<c01b8058>] (platform_drv_probe+0x14/0x18) from [<c01b6fc4>]
>> (driver_probe_device+0xc8/0x184)
>> [<c01b6fc4>] (driver_probe_device+0xc8/0x184) from [<c01b70e0>]
>> (__driver_attach+0x60/0x84)
>> [<c01b70e0>] (__driver_attach+0x60/0x84) from [<c01b6274>]
>> (bus_for_each_dev+0x4c/0x78)
>> [<c01b6274>] (bus_for_each_dev+0x4c/0x78) from [<c01b68e4>]
>> (bus_add_driver+0x98/0x210)
>> [<c01b68e4>] (bus_add_driver+0x98/0x210) from [<c01b75ec>]
>> (driver_register+0xa0/0x120)
>> [<c01b75ec>] (driver_register+0xa0/0x120) from [<c0008734>]
>> (do_one_initcall+0x90/0x160)
>> [<c0008734>] (do_one_initcall+0x90/0x160) from [<c03c6780>]
>> (kernel_init+0x74/0x118)
>> [<c03c6780>] (kernel_init+0x74/0x118) from [<c0013218>]
>> (kernel_thread_exit+0x0/0x8)
>> ---[ end trace 1b75b31a2719ed21 ]---
>> ------------[ cut here ]------------
>> WARNING: at arch/arm/mach-omap2/omap_hwmod.c:1448 _enable+0x38/0x1d0=
()
>> omap_hwmod: gpio6: enabled state can only be entered from initialize=
d,
>> idle, or disabled state
>> Modules linked in:
>> [<c00171ec>] (unwind_backtrace+0x0/0xe0) from [<c00308c0>]
>> (warn_slowpath_common+0x4c/0x64)
>> [<c00308c0>] (warn_slowpath_common+0x4c/0x64) from [<c0030958>]
>> (warn_slowpath_fmt+0x2c/0x3c)
>> [<c0030958>] (warn_slowpath_fmt+0x2c/0x3c) from [<c001e3ac>]
>> (_enable+0x38/0x1d0)
>> [<c001e3ac>] (_enable+0x38/0x1d0) from [<c001eae4>]
>> (omap_hwmod_enable+0x18/0x28)
>> [<c001eae4>] (omap_hwmod_enable+0x18/0x28) from [<c0029014>]
>> (omap_device_enable_hwmods+0x20/0x34)
>> [<c0029014>] (omap_device_enable_hwmods+0x20/0x34) from [<c00287cc>]
>> (_omap_device_activate+0x5c/0x138)
>> [<c00287cc>] (_omap_device_activate+0x5c/0x138) from [<c0028d50>]
>> (omap_device_enable+0x54/0x80)
>> [<c0028d50>] (omap_device_enable+0x54/0x80) from [<c0028d8c>]
>> (_od_runtime_resume+0x10/0x1c)
>> [<c0028d8c>] (_od_runtime_resume+0x10/0x1c) from [<c01bc4b8>]
>> (rpm_callback+0x3c/0x58)
>> [<c01bc4b8>] (rpm_callback+0x3c/0x58) from [<c01bcfa0>] (rpm_resume+=
0x290/0x398)
>> [<c01bcfa0>] (rpm_resume+0x290/0x398) from [<c01bd288>]
>> (__pm_runtime_resume+0x30/0x48)
>> [<c01bd288>] (__pm_runtime_resume+0x30/0x48) from [<c02b4164>]
>> (omap_gpio_probe+0x16c/0x334)
>> [<c02b4164>] (omap_gpio_probe+0x16c/0x334) from [<c01b8058>]
>> (platform_drv_probe+0x14/0x18)
>> [<c01b8058>] (platform_drv_probe+0x14/0x18) from [<c01b6fc4>]
>> (driver_probe_device+0xc8/0x184)
>> [<c01b6fc4>] (driver_probe_device+0xc8/0x184) from [<c01b70e0>]
>> (__driver_attach+0x60/0x84)
>> [<c01b70e0>] (__driver_attach+0x60/0x84) from [<c01b6274>]
>> (bus_for_each_dev+0x4c/0x78)
>> [<c01b6274>] (bus_for_each_dev+0x4c/0x78) from [<c01b68e4>]
>> (bus_add_driver+0x98/0x210)
>> [<c01b68e4>] (bus_add_driver+0x98/0x210) from [<c01b75ec>]
>> (driver_register+0xa0/0x120)
>> [<c01b75ec>] (driver_register+0xa0/0x120) from [<c0008734>]
>> (do_one_initcall+0x90/0x160)
>> [<c0008734>] (do_one_initcall+0x90/0x160) from [<c03c6780>]
>> (kernel_init+0x74/0x118)
>> [<c03c6780>] (kernel_init+0x74/0x118) from [<c0013218>]
>> (kernel_thread_exit+0x0/0x8)
>> ---[ end trace 1b75b31a2719ed22 ]---
>> omap_mux_init: Add partition: #1: core, flags: 0
>> omap_device: omap_uart.0: new worst case activate latency 0: 30517
>> omap_device: omap_uart.0: new worst case deactivate latency 0: 30517
>> omap_device: omap-mcbsp.2: alias fck already exists
>> omap_device: omap-mcbsp.3: alias fck already exists
>> OMAP DMA hardware revision 4.0
>> bio: create slab <bio-0> at 0
>> SCSI subsystem initialized
>> omap_device: omap_i2c.1: new worst case activate latency 0: 30517
>> omap_i2c omap_i2c.1: bus 1 rev3.12 at 400 kHz
>> omap_i2c omap_i2c.2: bus 2 rev3.12 at 400 kHz
>> pca953x 2-0021: interrupt support not compiled in
>> omap_i2c omap_i2c.3: bus 3 rev3.12 at 400 kHz
>> pca953x 3-0020: interrupt support not compiled in
>> pca953x 3-0021: interrupt support not compiled in
>> omap_device: omap_i2c.3: new worst case deactivate latency 0: 30517
>> Advanced Linux Sound Architecture Driver Version 1.0.24.
>> Switching to clocksource 32k_counter
>> Switched to NOHz mode on CPU #0
>> NET: Registered protocol family 2
>> IP route cache hash table entries: 2048 (order: 1, 8192 bytes)
>> TCP established hash table entries: 8192 (order: 4, 65536 bytes)
>> TCP bind hash table entries: 8192 (order: 3, 32768 bytes)
>> TCP: Hash tables configured (established 8192 bind 8192)
>> TCP reno registered
>> UDP hash table entries: 256 (order: 0, 4096 bytes)
>> UDP-Lite hash table entries: 256 (order: 0, 4096 bytes)
>> NET: Registered protocol family 1
>> RPC: Registered named UNIX socket transport module.
>> RPC: Registered udp transport module.
>> RPC: Registered tcp transport module.
>> RPC: Registered tcp NFSv4.1 backchannel transport module.
>> NetWinder Floating Point Emulator V0.97 (double precision)
>> VFS: Disk quotas dquot_6.5.2
>> Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
>> JFFS2 version 2.2. (NAND) (c) 2001-2006 Red Hat, Inc.
>> msgmni has been set to 491
>> io scheduler noop registered
>> io scheduler deadline registered
>> io scheduler cfq registered (default)
>> omap_device: omapdss_dss.-1: new worst case activate latency 0: 3051=
7
>> OMAP DSS rev 2.0
>> omapdss VENC error: can't get VDDA_DAC regulator
>> omapdss DISPLAY error: failed to init display tv
>> omap_device: omapdss_dss.-1: new worst case deactivate latency 0: 30=
517
>> Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
>> omap_uart.0: ttyO0 at MMIO 0x4806a000 (irq =3D 72) is a OMAP UART0
>> omap_uart.1: ttyO1 at MMIO 0x4806c000 (irq =3D 73) is a OMAP UART1
>> omap_uart.2: ttyO2 at MMIO 0x49020000 (irq =3D 74) is a OMAP UART2
>> console [ttyO2] enabled
>> brd: module loaded
>> loop: module loaded
>> omap2-nand driver initializing
>> davinci_mdio davinci_mdio.0: failed to get device clock
>> rtc-s35390a 1-0030: rtc core: registered rtc-s35390a as rtc0
>> omap_device: omap_wdt.-1: new worst case activate latency 0: 30517
>> OMAP Watchdog Timer Rev 0x31: initial timeout 60 sec
>> OMAP3517 / AM3517 EVM SoC init
>> AIC23 Audio Codec 0.1
>> asoc: tlv320aic23-hifi <-> omap-mcbsp-dai.0 mapping ok
>> ALSA device list:
>> =C2=A0#0: am3517evm
>> TCP cubic registered
>> NET: Registered protocol family 17
>> NET: Registered protocol family 15
>> Registering the dns_resolver key type
>> VFP support v0.3: implementor 41 architecture 3 part 30 variant c re=
v 1
>> Unable to handle kernel NULL pointer dereference at virtual address =
0000002a
>> pgd =3D c0004000
>> [0000002a] *pgd=3D00000000
>> Internal error: Oops: 5 [#1]
>> Modules linked in:
>> CPU: 0 =C2=A0 =C2=A0Tainted: G =C2=A0 =C2=A0 =C2=A0 =C2=A0W =C2=A0 =C2=
=A0(3.1.0-rc6+ #9)
>> PC is at twl_i2c_read+0x34/0x124
>> LR is at omap3_twl_set_sr_bit+0x34/0x9c
>> pc : [<c01c18e8>] =C2=A0 =C2=A0lr : [<c03cdac8>] =C2=A0 =C2=A0psr: 8=
0000013
>> sp : cf41df68 =C2=A0ip : 00000015 =C2=A0fp : 0000002a
>> r10: 00000000 =C2=A0r9 : 00000001 =C2=A0r8 : 00000000
>> r7 : c0430990 =C2=A0r6 : 00000006 =C2=A0r5 : cf41df9f =C2=A0r4 : c03=
ec388
>> r3 : 00000000 =C2=A0r2 : 00000006 =C2=A0r1 : cf41df9f =C2=A0r0 : 000=
00015
>> Flags: Nzcv =C2=A0IRQs on =C2=A0FIQs on =C2=A0Mode SVC_32 =C2=A0ISA =
ARM =C2=A0Segment kernel
>> Control: 10c5387d =C2=A0Table: 80004019 =C2=A0DAC: 00000015
>> Process swapper (pid: 1, stack limit =3D 0xcf41c2e8)
>> Stack: (0xcf41df68 to 0xcf41e000)
>> df60: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 00000015 cf41df9f 00000006 c03ec388 00000001 c0013218
>> df80: c03cd128 00000000 00000000 00000000 00000000 c03cdac8 00000001=
 0000f457
>> dfa0: 00000000 c03ec388 c03ec3d0 c03cdb7c cf41c000 c03cd130 c03ec388=
 c0008734
>> dfc0: c03cd128 0000f457 c0421a00 00000000 c03ec388 c03ec3d0 c0013218=
 00000013
>> dfe0: 00000000 c03c6780 00000000 00000000 c03c670c c0013218 ff7d6ff7=
 e79ef977
>> [<c01c18e8>] (twl_i2c_read+0x34/0x124) from [<c03cdac8>]
>> (omap3_twl_set_sr_bit+0x34/0x9c)
>> [<c03cdac8>] (omap3_twl_set_sr_bit+0x34/0x9c) from [<c03cdb7c>]
>> (omap3_twl_init+0x4c/0x88)
>> [<c03cdb7c>] (omap3_twl_init+0x4c/0x88) from [<c03cd130>]
>> (omap2_common_pm_late_init+0x8/0x50)
>> [<c03cd130>] (omap2_common_pm_late_init+0x8/0x50) from [<c0008734>]
>> (do_one_initcall+0x90/0x160)
>> [<c0008734>] (do_one_initcall+0x90/0x160) from [<c03c6780>]
>> (kernel_init+0x74/0x118)
>> [<c03c6780>] (kernel_init+0x74/0x118) from [<c0013218>]
>> (kernel_thread_exit+0x0/0x8)
>> Code: 8a000008 e59f70e8 e1a0b080 e59730ec (e7d32080)
>> ---[ end trace 1b75b31a2719ed23 ]---
>> Kernel panic - not syncing: Attempted to kill init!
>>
>>
>> Here is my currently used .config:
>>
>> #
>> # Automatically generated file; DO NOT EDIT.
>> # Linux/arm 3.1.0-rc6 Kernel Configuration
>> #
>> CONFIG_ARM=3Dy
>> CONFIG_SYS_SUPPORTS_APM_EMULATION=3Dy
>> CONFIG_HAVE_SCHED_CLOCK=3Dy
>> CONFIG_GENERIC_GPIO=3Dy
>> # CONFIG_ARCH_USES_GETTIMEOFFSET is not set
>> CONFIG_GENERIC_CLOCKEVENTS=3Dy
>> CONFIG_KTIME_SCALAR=3Dy
>> CONFIG_HAVE_PROC_CPU=3Dy
>> CONFIG_STACKTRACE_SUPPORT=3Dy
>> CONFIG_HAVE_LATENCYTOP_SUPPORT=3Dy
>> CONFIG_LOCKDEP_SUPPORT=3Dy
>> CONFIG_TRACE_IRQFLAGS_SUPPORT=3Dy
>> CONFIG_HARDIRQS_SW_RESEND=3Dy
>> CONFIG_GENERIC_IRQ_PROBE=3Dy
>> CONFIG_RWSEM_GENERIC_SPINLOCK=3Dy
>> CONFIG_ARCH_HAS_CPUFREQ=3Dy
>> CONFIG_ARCH_HAS_CPU_IDLE_WAIT=3Dy
>> CONFIG_GENERIC_HWEIGHT=3Dy
>> CONFIG_GENERIC_CALIBRATE_DELAY=3Dy
>> CONFIG_NEED_DMA_MAP_STATE=3Dy
>> CONFIG_VECTORS_BASE=3D0xffff0000
>> # CONFIG_ARM_PATCH_PHYS_VIRT is not set
>> CONFIG_DEFCONFIG_LIST=3D"/lib/modules/$UNAME_RELEASE/.config"
>> CONFIG_HAVE_IRQ_WORK=3Dy
>>
>> #
>> # General setup
>> #
>> CONFIG_EXPERIMENTAL=3Dy
>> CONFIG_BROKEN_ON_SMP=3Dy
>> CONFIG_INIT_ENV_ARG_LIMIT=3D32
>> CONFIG_CROSS_COMPILE=3D""
>> CONFIG_LOCALVERSION=3D""
>> # CONFIG_LOCALVERSION_AUTO is not set
>> CONFIG_HAVE_KERNEL_GZIP=3Dy
>> CONFIG_HAVE_KERNEL_LZMA=3Dy
>> CONFIG_HAVE_KERNEL_LZO=3Dy
>> CONFIG_KERNEL_GZIP=3Dy
>> # CONFIG_KERNEL_LZMA is not set
>> # CONFIG_KERNEL_LZO is not set
>> CONFIG_DEFAULT_HOSTNAME=3D"(none)"
>> CONFIG_SWAP=3Dy
>> CONFIG_SYSVIPC=3Dy
>> CONFIG_SYSVIPC_SYSCTL=3Dy
>> # CONFIG_POSIX_MQUEUE is not set
>> CONFIG_BSD_PROCESS_ACCT=3Dy
>> # CONFIG_BSD_PROCESS_ACCT_V3 is not set
>> # CONFIG_FHANDLE is not set
>> # CONFIG_TASKSTATS is not set
>> # CONFIG_AUDIT is not set
>> CONFIG_HAVE_GENERIC_HARDIRQS=3Dy
>>
>> #
>> # IRQ subsystem
>> #
>> CONFIG_GENERIC_HARDIRQS=3Dy
>> CONFIG_HAVE_SPARSE_IRQ=3Dy
>> CONFIG_GENERIC_IRQ_SHOW=3Dy
>> CONFIG_GENERIC_IRQ_CHIP=3Dy
>> # CONFIG_SPARSE_IRQ is not set
>>
>> #
>> # RCU Subsystem
>> #
>> CONFIG_TINY_RCU=3Dy
>> # CONFIG_PREEMPT_RCU is not set
>> # CONFIG_RCU_TRACE is not set
>> # CONFIG_TREE_RCU_TRACE is not set
>> CONFIG_IKCONFIG=3Dy
>> CONFIG_IKCONFIG_PROC=3Dy
>> CONFIG_LOG_BUF_SHIFT=3D14
>> # CONFIG_CGROUPS is not set
>> # CONFIG_NAMESPACES is not set
>> # CONFIG_SCHED_AUTOGROUP is not set
>> CONFIG_SYSFS_DEPRECATED=3Dy
>> CONFIG_SYSFS_DEPRECATED_V2=3Dy
>> # CONFIG_RELAY is not set
>> CONFIG_BLK_DEV_INITRD=3Dy
>> CONFIG_INITRAMFS_SOURCE=3D""
>> CONFIG_RD_GZIP=3Dy
>> # CONFIG_RD_BZIP2 is not set
>> # CONFIG_RD_LZMA is not set
>> # CONFIG_RD_XZ is not set
>> # CONFIG_RD_LZO is not set
>> CONFIG_CC_OPTIMIZE_FOR_SIZE=3Dy
>> CONFIG_SYSCTL=3Dy
>> CONFIG_ANON_INODES=3Dy
>> CONFIG_EXPERT=3Dy
>> CONFIG_UID16=3Dy
>> # CONFIG_SYSCTL_SYSCALL is not set
>> CONFIG_KALLSYMS=3Dy
>> # CONFIG_KALLSYMS_ALL is not set
>> CONFIG_HOTPLUG=3Dy
>> CONFIG_PRINTK=3Dy
>> CONFIG_BUG=3Dy
>> CONFIG_ELF_CORE=3Dy
>> CONFIG_BASE_FULL=3Dy
>> CONFIG_FUTEX=3Dy
>> CONFIG_EPOLL=3Dy
>> CONFIG_SIGNALFD=3Dy
>> CONFIG_TIMERFD=3Dy
>> CONFIG_EVENTFD=3Dy
>> CONFIG_SHMEM=3Dy
>> CONFIG_AIO=3Dy
>> CONFIG_EMBEDDED=3Dy
>> CONFIG_HAVE_PERF_EVENTS=3Dy
>> CONFIG_PERF_USE_VMALLOC=3Dy
>>
>> #
>> # Kernel Performance Events And Counters
>> #
>> # CONFIG_PERF_EVENTS is not set
>> # CONFIG_PERF_COUNTERS is not set
>> CONFIG_VM_EVENT_COUNTERS=3Dy
>> CONFIG_COMPAT_BRK=3Dy
>> CONFIG_SLAB=3Dy
>> # CONFIG_SLUB is not set
>> # CONFIG_SLOB is not set
>> # CONFIG_PROFILING is not set
>> CONFIG_HAVE_OPROFILE=3Dy
>> # CONFIG_KPROBES is not set
>> CONFIG_HAVE_KPROBES=3Dy
>> CONFIG_HAVE_KRETPROBES=3Dy
>> CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=3Dy
>> CONFIG_HAVE_CLK=3Dy
>> CONFIG_HAVE_DMA_API_DEBUG=3Dy
>>
>> #
>> # GCOV-based kernel profiling
>> #
>> CONFIG_HAVE_GENERIC_DMA_COHERENT=3Dy
>> CONFIG_SLABINFO=3Dy
>> CONFIG_RT_MUTEXES=3Dy
>> CONFIG_BASE_SMALL=3D0
>> CONFIG_MODULES=3Dy
>> # CONFIG_MODULE_FORCE_LOAD is not set
>> CONFIG_MODULE_UNLOAD=3Dy
>> # CONFIG_MODULE_FORCE_UNLOAD is not set
>> CONFIG_MODVERSIONS=3Dy
>> CONFIG_MODULE_SRCVERSION_ALL=3Dy
>> CONFIG_BLOCK=3Dy
>> CONFIG_LBDAF=3Dy
>> # CONFIG_BLK_DEV_BSG is not set
>> # CONFIG_BLK_DEV_BSGLIB is not set
>> # CONFIG_BLK_DEV_INTEGRITY is not set
>>
>> #
>> # IO Schedulers
>> #
>> CONFIG_IOSCHED_NOOP=3Dy
>> CONFIG_IOSCHED_DEADLINE=3Dy
>> CONFIG_IOSCHED_CFQ=3Dy
>> # CONFIG_DEFAULT_DEADLINE is not set
>> CONFIG_DEFAULT_CFQ=3Dy
>> # CONFIG_DEFAULT_NOOP is not set
>> CONFIG_DEFAULT_IOSCHED=3D"cfq"
>> # CONFIG_INLINE_SPIN_TRYLOCK is not set
>> # CONFIG_INLINE_SPIN_TRYLOCK_BH is not set
>> # CONFIG_INLINE_SPIN_LOCK is not set
>> # CONFIG_INLINE_SPIN_LOCK_BH is not set
>> # CONFIG_INLINE_SPIN_LOCK_IRQ is not set
>> # CONFIG_INLINE_SPIN_LOCK_IRQSAVE is not set
>> CONFIG_INLINE_SPIN_UNLOCK=3Dy
>> # CONFIG_INLINE_SPIN_UNLOCK_BH is not set
>> CONFIG_INLINE_SPIN_UNLOCK_IRQ=3Dy
>> # CONFIG_INLINE_SPIN_UNLOCK_IRQRESTORE is not set
>> # CONFIG_INLINE_READ_TRYLOCK is not set
>> # CONFIG_INLINE_READ_LOCK is not set
>> # CONFIG_INLINE_READ_LOCK_BH is not set
>> # CONFIG_INLINE_READ_LOCK_IRQ is not set
>> # CONFIG_INLINE_READ_LOCK_IRQSAVE is not set
>> CONFIG_INLINE_READ_UNLOCK=3Dy
>> # CONFIG_INLINE_READ_UNLOCK_BH is not set
>> CONFIG_INLINE_READ_UNLOCK_IRQ=3Dy
>> # CONFIG_INLINE_READ_UNLOCK_IRQRESTORE is not set
>> # CONFIG_INLINE_WRITE_TRYLOCK is not set
>> # CONFIG_INLINE_WRITE_LOCK is not set
>> # CONFIG_INLINE_WRITE_LOCK_BH is not set
>> # CONFIG_INLINE_WRITE_LOCK_IRQ is not set
>> # CONFIG_INLINE_WRITE_LOCK_IRQSAVE is not set
>> CONFIG_INLINE_WRITE_UNLOCK=3Dy
>> # CONFIG_INLINE_WRITE_UNLOCK_BH is not set
>> CONFIG_INLINE_WRITE_UNLOCK_IRQ=3Dy
>> # CONFIG_INLINE_WRITE_UNLOCK_IRQRESTORE is not set
>> # CONFIG_MUTEX_SPIN_ON_OWNER is not set
>> CONFIG_FREEZER=3Dy
>>
>> #
>> # System Type
>> #
>> CONFIG_MMU=3Dy
>> # CONFIG_ARCH_INTEGRATOR is not set
>> # CONFIG_ARCH_REALVIEW is not set
>> # CONFIG_ARCH_VERSATILE is not set
>> # CONFIG_ARCH_VEXPRESS is not set
>> # CONFIG_ARCH_AT91 is not set
>> # CONFIG_ARCH_BCMRING is not set
>> # CONFIG_ARCH_CLPS711X is not set
>> # CONFIG_ARCH_CNS3XXX is not set
>> # CONFIG_ARCH_GEMINI is not set
>> # CONFIG_ARCH_PRIMA2 is not set
>> # CONFIG_ARCH_EBSA110 is not set
>> # CONFIG_ARCH_EP93XX is not set
>> # CONFIG_ARCH_FOOTBRIDGE is not set
>> # CONFIG_ARCH_MXC is not set
>> # CONFIG_ARCH_MXS is not set
>> # CONFIG_ARCH_NETX is not set
>> # CONFIG_ARCH_H720X is not set
>> # CONFIG_ARCH_IOP13XX is not set
>> # CONFIG_ARCH_IOP32X is not set
>> # CONFIG_ARCH_IOP33X is not set
>> # CONFIG_ARCH_IXP23XX is not set
>> # CONFIG_ARCH_IXP2000 is not set
>> # CONFIG_ARCH_IXP4XX is not set
>> # CONFIG_ARCH_DOVE is not set
>> # CONFIG_ARCH_KIRKWOOD is not set
>> # CONFIG_ARCH_LPC32XX is not set
>> # CONFIG_ARCH_MV78XX0 is not set
>> # CONFIG_ARCH_ORION5X is not set
>> # CONFIG_ARCH_MMP is not set
>> # CONFIG_ARCH_KS8695 is not set
>> # CONFIG_ARCH_W90X900 is not set
>> # CONFIG_ARCH_NUC93X is not set
>> # CONFIG_ARCH_TEGRA is not set
>> # CONFIG_ARCH_PNX4008 is not set
>> # CONFIG_ARCH_PXA is not set
>> # CONFIG_ARCH_MSM is not set
>> # CONFIG_ARCH_SHMOBILE is not set
>> # CONFIG_ARCH_RPC is not set
>> # CONFIG_ARCH_SA1100 is not set
>> # CONFIG_ARCH_S3C2410 is not set
>> # CONFIG_ARCH_S3C64XX is not set
>> # CONFIG_ARCH_S5P64X0 is not set
>> # CONFIG_ARCH_S5PC100 is not set
>> # CONFIG_ARCH_S5PV210 is not set
>> # CONFIG_ARCH_EXYNOS4 is not set
>> # CONFIG_ARCH_SHARK is not set
>> # CONFIG_ARCH_TCC_926 is not set
>> # CONFIG_ARCH_U300 is not set
>> # CONFIG_ARCH_U8500 is not set
>> # CONFIG_ARCH_NOMADIK is not set
>> # CONFIG_ARCH_DAVINCI is not set
>> CONFIG_ARCH_OMAP=3Dy
>> # CONFIG_PLAT_SPEAR is not set
>> # CONFIG_ARCH_VT8500 is not set
>> # CONFIG_ARCH_ZYNQ is not set
>> CONFIG_GPIO_PCA953X=3Dy
>> # CONFIG_KEYBOARD_GPIO_POLLED is not set
>>
>> #
>> # TI OMAP Common Features
>> #
>> # CONFIG_ARCH_OMAP1 is not set
>> CONFIG_ARCH_OMAP2PLUS=3Dy
>>
>> #
>> # OMAP Feature Selections
>> #
>> # CONFIG_OMAP_SMARTREFLEX is not set
>> CONFIG_OMAP_RESET_CLOCKS=3Dy
>> CONFIG_OMAP_MUX=3Dy
>> # CONFIG_OMAP_MUX_DEBUG is not set
>> CONFIG_OMAP_MUX_WARNINGS=3Dy
>> CONFIG_OMAP_MCBSP=3Dy
>> # CONFIG_OMAP_MBOX_FWK is not set
>> CONFIG_OMAP_32K_TIMER=3Dy
>> # CONFIG_OMAP3_L2_AUX_SECURE_SAVE_RESTORE is not set
>> CONFIG_OMAP_32K_TIMER_HZ=3D128
>> CONFIG_OMAP_DM_TIMER=3Dy
>> CONFIG_OMAP_PM_NOOP=3Dy
>>
>> #
>> # TI OMAP2/3/4 Specific Features
>> #
>> CONFIG_ARCH_OMAP2PLUS_TYPICAL=3Dy
>> # CONFIG_ARCH_OMAP2 is not set
>> CONFIG_ARCH_OMAP3=3Dy
>> # CONFIG_ARCH_OMAP4 is not set
>> # CONFIG_SOC_OMAP3430 is not set
>> # CONFIG_SOC_OMAPTI816X is not set
>> CONFIG_OMAP_PACKAGE_CBB=3Dy
>>
>> #
>> # OMAP Board Type
>> #
>> # CONFIG_MACH_OMAP3_BEAGLE is not set
>> # CONFIG_MACH_DEVKIT8000 is not set
>> # CONFIG_MACH_OMAP_LDP is not set
>> # CONFIG_MACH_OMAP3530_LV_SOM is not set
>> # CONFIG_MACH_OMAP3_TORPEDO is not set
>> # CONFIG_MACH_OVERO is not set
>> # CONFIG_MACH_OMAP3EVM is not set
>> CONFIG_MACH_OMAP3517EVM=3Dy
>> # CONFIG_MACH_CRANEBOARD is not set
>> # CONFIG_MACH_OMAP3_PANDORA is not set
>> # CONFIG_MACH_OMAP3_TOUCHBOOK is not set
>> # CONFIG_MACH_OMAP_3430SDP is not set
>> # CONFIG_MACH_NOKIA_RM680 is not set
>> # CONFIG_MACH_NOKIA_RX51 is not set
>> # CONFIG_MACH_OMAP_ZOOM2 is not set
>> # CONFIG_MACH_OMAP_ZOOM3 is not set
>> # CONFIG_MACH_CM_T35 is not set
>> # CONFIG_MACH_CM_T3517 is not set
>> # CONFIG_MACH_IGEP0020 is not set
>> # CONFIG_MACH_IGEP0030 is not set
>> # CONFIG_MACH_SBC3530 is not set
>> # CONFIG_MACH_OMAP_3630SDP is not set
>> # CONFIG_OMAP3_EMU is not set
>> # CONFIG_OMAP3_SDRC_AC_TIMING is not set
>>
>> #
>> # System MMU
>> #
>>
>> #
>> # Processor Type
>> #
>> CONFIG_CPU_V7=3Dy
>> CONFIG_CPU_32v6K=3Dy
>> CONFIG_CPU_32v7=3Dy
>> CONFIG_CPU_ABRT_EV7=3Dy
>> CONFIG_CPU_PABRT_V7=3Dy
>> CONFIG_CPU_CACHE_V7=3Dy
>> CONFIG_CPU_CACHE_VIPT=3Dy
>> CONFIG_CPU_COPY_V6=3Dy
>> CONFIG_CPU_TLB_V7=3Dy
>> CONFIG_CPU_HAS_ASID=3Dy
>> CONFIG_CPU_CP15=3Dy
>> CONFIG_CPU_CP15_MMU=3Dy
>>
>> #
>> # Processor Features
>> #
>> CONFIG_ARM_THUMB=3Dy
>> # CONFIG_ARM_THUMBEE is not set
>> # CONFIG_SWP_EMULATE is not set
>> # CONFIG_CPU_ICACHE_DISABLE is not set
>> # CONFIG_CPU_DCACHE_DISABLE is not set
>> # CONFIG_CPU_BPREDICT_DISABLE is not set
>> CONFIG_ARM_L1_CACHE_SHIFT_6=3Dy
>> CONFIG_ARM_L1_CACHE_SHIFT=3D6
>> CONFIG_ARM_DMA_MEM_BUFFERABLE=3Dy
>> CONFIG_ARM_ERRATA_430973=3Dy
>> CONFIG_ARM_ERRATA_458693=3Dy
>> CONFIG_ARM_ERRATA_460075=3Dy
>> CONFIG_ARM_ERRATA_743622=3Dy
>> CONFIG_ARM_ERRATA_754322=3Dy
>>
>> #
>> # Bus support
>> #
>> # CONFIG_PCI_SYSCALL is not set
>> # CONFIG_ARCH_SUPPORTS_MSI is not set
>> # CONFIG_PCCARD is not set
>>
>> #
>> # Kernel Features
>> #
>> CONFIG_TICK_ONESHOT=3Dy
>> CONFIG_NO_HZ=3Dy
>> CONFIG_HIGH_RES_TIMERS=3Dy
>> CONFIG_GENERIC_CLOCKEVENTS_BUILD=3Dy
>> CONFIG_VMSPLIT_3G=3Dy
>> # CONFIG_VMSPLIT_2G is not set
>> # CONFIG_VMSPLIT_1G is not set
>> CONFIG_PAGE_OFFSET=3D0xC0000000
>> CONFIG_PREEMPT_NONE=3Dy
>> # CONFIG_PREEMPT_VOLUNTARY is not set
>> # CONFIG_PREEMPT is not set
>> CONFIG_HZ=3D128
>> # CONFIG_THUMB2_KERNEL is not set
>> CONFIG_AEABI=3Dy
>> CONFIG_OABI_COMPAT=3Dy
>> CONFIG_ARCH_HAS_HOLES_MEMORYMODEL=3Dy
>> # CONFIG_ARCH_SPARSEMEM_DEFAULT is not set
>> # CONFIG_ARCH_SELECT_MEMORY_MODEL is not set
>> CONFIG_HAVE_ARCH_PFN_VALID=3Dy
>> # CONFIG_HIGHMEM is not set
>> CONFIG_SELECT_MEMORY_MODEL=3Dy
>> CONFIG_FLATMEM_MANUAL=3Dy
>> CONFIG_FLATMEM=3Dy
>> CONFIG_FLAT_NODE_MEM_MAP=3Dy
>> CONFIG_HAVE_MEMBLOCK=3Dy
>> CONFIG_PAGEFLAGS_EXTENDED=3Dy
>> CONFIG_SPLIT_PTLOCK_CPUS=3D4
>> # CONFIG_COMPACTION is not set
>> # CONFIG_PHYS_ADDR_T_64BIT is not set
>> CONFIG_ZONE_DMA_FLAG=3D0
>> CONFIG_VIRT_TO_BUS=3Dy
>> # CONFIG_KSM is not set
>> CONFIG_DEFAULT_MMAP_MIN_ADDR=3D4096
>> CONFIG_NEED_PER_CPU_KM=3Dy
>> # CONFIG_CLEANCACHE is not set
>> CONFIG_FORCE_MAX_ZONEORDER=3D11
>> # CONFIG_LEDS is not set
>> CONFIG_ALIGNMENT_TRAP=3Dy
>> # CONFIG_UACCESS_WITH_MEMCPY is not set
>> # CONFIG_SECCOMP is not set
>> # CONFIG_CC_STACKPROTECTOR is not set
>> # CONFIG_DEPRECATED_PARAM_STRUCT is not set
>>
>> #
>> # Boot options
>> #
>> # CONFIG_USE_OF is not set
>> CONFIG_ZBOOT_ROM_TEXT=3D0x0
>> CONFIG_ZBOOT_ROM_BSS=3D0x0
>> CONFIG_CMDLINE=3D"root=3D/dev/nfs nfsroot=3D192.168.0.1:/home/user/b=
uildroot
>> ip=3D192.168.0.2:192.168.0.1:192.168.0.1:255.255.255.0:tgt:eth0:off =
rw
>> console=3DttyS2,115200n8"
>> CONFIG_CMDLINE_FROM_BOOTLOADER=3Dy
>> # CONFIG_CMDLINE_EXTEND is not set
>> # CONFIG_CMDLINE_FORCE is not set
>> # CONFIG_XIP_KERNEL is not set
>> # CONFIG_KEXEC is not set
>> # CONFIG_CRASH_DUMP is not set
>> # CONFIG_AUTO_ZRELADDR is not set
>>
>> #
>> # CPU Power Management
>> #
>>
>> #
>> # CPU Frequency scaling
>> #
>> # CONFIG_CPU_FREQ is not set
>> # CONFIG_CPU_IDLE is not set
>>
>> #
>> # Floating point emulation
>> #
>>
>> #
>> # At least one emulation must be selected
>> #
>> CONFIG_FPE_NWFPE=3Dy
>> # CONFIG_FPE_NWFPE_XP is not set
>> # CONFIG_FPE_FASTFPE is not set
>> CONFIG_VFP=3Dy
>> CONFIG_VFPv3=3Dy
>> CONFIG_NEON=3Dy
>>
>> #
>> # Userspace binary formats
>> #
>> CONFIG_BINFMT_ELF=3Dy
>> # CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
>> CONFIG_HAVE_AOUT=3Dy
>> # CONFIG_BINFMT_AOUT is not set
>> CONFIG_BINFMT_MISC=3Dy
>>
>> #
>> # Power management options
>> #
>> CONFIG_SUSPEND=3Dy
>> CONFIG_SUSPEND_FREEZER=3Dy
>> CONFIG_PM_SLEEP=3Dy
>> CONFIG_PM_RUNTIME=3Dy
>> CONFIG_PM=3Dy
>> CONFIG_PM_DEBUG=3Dy
>> # CONFIG_PM_ADVANCED_DEBUG is not set
>> # CONFIG_PM_TEST_SUSPEND is not set
>> CONFIG_CAN_PM_TRACE=3Dy
>> # CONFIG_APM_EMULATION is not set
>> CONFIG_ARCH_HAS_OPP=3Dy
>> CONFIG_PM_OPP=3Dy
>> CONFIG_PM_CLK=3Dy
>> CONFIG_ARCH_SUSPEND_POSSIBLE=3Dy
>> CONFIG_NET=3Dy
>>
>> #
>> # Networking options
>> #
>> CONFIG_PACKET=3Dy
>> CONFIG_UNIX=3Dy
>> CONFIG_XFRM=3Dy
>> # CONFIG_XFRM_USER is not set
>> # CONFIG_XFRM_SUB_POLICY is not set
>> # CONFIG_XFRM_MIGRATE is not set
>> # CONFIG_XFRM_STATISTICS is not set
>> CONFIG_NET_KEY=3Dy
>> # CONFIG_NET_KEY_MIGRATE is not set
>> CONFIG_INET=3Dy
>> # CONFIG_IP_MULTICAST is not set
>> # CONFIG_IP_ADVANCED_ROUTER is not set
>> CONFIG_IP_PNP=3Dy
>> CONFIG_IP_PNP_DHCP=3Dy
>> CONFIG_IP_PNP_BOOTP=3Dy
>> CONFIG_IP_PNP_RARP=3Dy
>> # CONFIG_NET_IPIP is not set
>> # CONFIG_NET_IPGRE_DEMUX is not set
>> # CONFIG_ARPD is not set
>> # CONFIG_SYN_COOKIES is not set
>> # CONFIG_INET_AH is not set
>> # CONFIG_INET_ESP is not set
>> # CONFIG_INET_IPCOMP is not set
>> # CONFIG_INET_XFRM_TUNNEL is not set
>> # CONFIG_INET_TUNNEL is not set
>> CONFIG_INET_XFRM_MODE_TRANSPORT=3Dy
>> CONFIG_INET_XFRM_MODE_TUNNEL=3Dy
>> CONFIG_INET_XFRM_MODE_BEET=3Dy
>> # CONFIG_INET_LRO is not set
>> CONFIG_INET_DIAG=3Dy
>> CONFIG_INET_TCP_DIAG=3Dy
>> # CONFIG_TCP_CONG_ADVANCED is not set
>> CONFIG_TCP_CONG_CUBIC=3Dy
>> CONFIG_DEFAULT_TCP_CONG=3D"cubic"
>> # CONFIG_TCP_MD5SIG is not set
>> # CONFIG_IPV6 is not set
>> # CONFIG_NETWORK_SECMARK is not set
>> # CONFIG_NETWORK_PHY_TIMESTAMPING is not set
>> # CONFIG_NETFILTER is not set
>> # CONFIG_IP_DCCP is not set
>> # CONFIG_IP_SCTP is not set
>> # CONFIG_RDS is not set
>> # CONFIG_TIPC is not set
>> # CONFIG_ATM is not set
>> # CONFIG_L2TP is not set
>> # CONFIG_BRIDGE is not set
>> # CONFIG_NET_DSA is not set
>> # CONFIG_VLAN_8021Q is not set
>> # CONFIG_DECNET is not set
>> # CONFIG_LLC2 is not set
>> # CONFIG_IPX is not set
>> # CONFIG_ATALK is not set
>> # CONFIG_X25 is not set
>> # CONFIG_LAPB is not set
>> # CONFIG_ECONET is not set
>> # CONFIG_WAN_ROUTER is not set
>> # CONFIG_PHONET is not set
>> # CONFIG_IEEE802154 is not set
>> # CONFIG_NET_SCHED is not set
>> # CONFIG_DCB is not set
>> CONFIG_DNS_RESOLVER=3Dy
>> # CONFIG_BATMAN_ADV is not set
>>
>> #
>> # Network testing
>> #
>> # CONFIG_NET_PKTGEN is not set
>> # CONFIG_HAMRADIO is not set
>> # CONFIG_CAN is not set
>> # CONFIG_IRDA is not set
>> # CONFIG_BT is not set
>> # CONFIG_AF_RXRPC is not set
>> CONFIG_WIRELESS=3Dy
>> # CONFIG_CFG80211 is not set
>> # CONFIG_LIB80211 is not set
>>
>> #
>> # CFG80211 needs to be enabled for MAC80211
>> #
>> # CONFIG_WIMAX is not set
>> # CONFIG_RFKILL is not set
>> # CONFIG_RFKILL_REGULATOR is not set
>> # CONFIG_NET_9P is not set
>> # CONFIG_CAIF is not set
>> # CONFIG_CEPH_LIB is not set
>> # CONFIG_NFC is not set
>>
>> #
>> # Device Drivers
>> #
>>
>> #
>> # Generic Driver Options
>> #
>> CONFIG_UEVENT_HELPER_PATH=3D"/sbin/hotplug"
>> # CONFIG_DEVTMPFS is not set
>> CONFIG_STANDALONE=3Dy
>> CONFIG_PREVENT_FIRMWARE_BUILD=3Dy
>> # CONFIG_FW_LOADER is not set
>> # CONFIG_DEBUG_DRIVER is not set
>> # CONFIG_DEBUG_DEVRES is not set
>> # CONFIG_SYS_HYPERVISOR is not set
>> CONFIG_REGMAP=3Dy
>> CONFIG_REGMAP_I2C=3Dy
>> # CONFIG_CONNECTOR is not set
>> CONFIG_MTD=3Dy
>> # CONFIG_MTD_DEBUG is not set
>> # CONFIG_MTD_TESTS is not set
>> # CONFIG_MTD_REDBOOT_PARTS is not set
>> CONFIG_MTD_CMDLINE_PARTS=3Dy
>> # CONFIG_MTD_AFS_PARTS is not set
>> # CONFIG_MTD_AR7_PARTS is not set
>>
>> #
>> # User Modules And Translation Layers
>> #
>> CONFIG_MTD_CHAR=3Dy
>> CONFIG_MTD_BLKDEVS=3Dy
>> CONFIG_MTD_BLOCK=3Dy
>> # CONFIG_FTL is not set
>> # CONFIG_NFTL is not set
>> # CONFIG_INFTL is not set
>> # CONFIG_RFD_FTL is not set
>> # CONFIG_SSFDC is not set
>> # CONFIG_SM_FTL is not set
>> # CONFIG_MTD_OOPS is not set
>> # CONFIG_MTD_SWAP is not set
>>
>> #
>> # RAM/ROM/Flash chip drivers
>> #
>> # CONFIG_MTD_CFI is not set
>> # CONFIG_MTD_JEDECPROBE is not set
>> CONFIG_MTD_MAP_BANK_WIDTH_1=3Dy
>> CONFIG_MTD_MAP_BANK_WIDTH_2=3Dy
>> CONFIG_MTD_MAP_BANK_WIDTH_4=3Dy
>> # CONFIG_MTD_MAP_BANK_WIDTH_8 is not set
>> # CONFIG_MTD_MAP_BANK_WIDTH_16 is not set
>> # CONFIG_MTD_MAP_BANK_WIDTH_32 is not set
>> CONFIG_MTD_CFI_I1=3Dy
>> CONFIG_MTD_CFI_I2=3Dy
>> # CONFIG_MTD_CFI_I4 is not set
>> # CONFIG_MTD_CFI_I8 is not set
>> # CONFIG_MTD_RAM is not set
>> # CONFIG_MTD_ROM is not set
>> # CONFIG_MTD_ABSENT is not set
>>
>> #
>> # Mapping drivers for chip access
>> #
>> # CONFIG_MTD_COMPLEX_MAPPINGS is not set
>> # CONFIG_MTD_PLATRAM is not set
>>
>> #
>> # Self-contained MTD device drivers
>> #
>> # CONFIG_MTD_SLRAM is not set
>> # CONFIG_MTD_PHRAM is not set
>> # CONFIG_MTD_MTDRAM is not set
>> # CONFIG_MTD_BLOCK2MTD is not set
>>
>> #
>> # Disk-On-Chip Device Drivers
>> #
>> # CONFIG_MTD_DOC2000 is not set
>> # CONFIG_MTD_DOC2001 is not set
>> # CONFIG_MTD_DOC2001PLUS is not set
>> CONFIG_MTD_NAND_ECC=3Dy
>> # CONFIG_MTD_NAND_ECC_SMC is not set
>> CONFIG_MTD_NAND=3Dy
>> # CONFIG_MTD_NAND_VERIFY_WRITE is not set
>> # CONFIG_MTD_NAND_ECC_BCH is not set
>> # CONFIG_MTD_SM_COMMON is not set
>> # CONFIG_MTD_NAND_MUSEUM_IDS is not set
>> # CONFIG_MTD_NAND_GPIO is not set
>> CONFIG_MTD_NAND_OMAP2=3Dy
>> CONFIG_MTD_NAND_IDS=3Dy
>> # CONFIG_MTD_NAND_DISKONCHIP is not set
>> # CONFIG_MTD_NAND_NANDSIM is not set
>> # CONFIG_MTD_NAND_PLATFORM is not set
>> # CONFIG_MTD_ONENAND is not set
>>
>> #
>> # LPDDR flash memory drivers
>> #
>> # CONFIG_MTD_LPDDR is not set
>> # CONFIG_MTD_UBI is not set
>> # CONFIG_PARPORT is not set
>> CONFIG_BLK_DEV=3Dy
>> # CONFIG_BLK_DEV_COW_COMMON is not set
>> CONFIG_BLK_DEV_LOOP=3Dy
>> CONFIG_BLK_DEV_LOOP_MIN_COUNT=3D8
>> # CONFIG_BLK_DEV_CRYPTOLOOP is not set
>>
>> #
>> # DRBD disabled because PROC_FS, INET or CONNECTOR not selected
>> #
>> # CONFIG_BLK_DEV_NBD is not set
>> CONFIG_BLK_DEV_RAM=3Dy
>> CONFIG_BLK_DEV_RAM_COUNT=3D16
>> CONFIG_BLK_DEV_RAM_SIZE=3D32768
>> # CONFIG_BLK_DEV_XIP is not set
>> # CONFIG_CDROM_PKTCDVD is not set
>> # CONFIG_ATA_OVER_ETH is not set
>> # CONFIG_MG_DISK is not set
>> # CONFIG_BLK_DEV_RBD is not set
>> # CONFIG_SENSORS_LIS3LV02D is not set
>> # CONFIG_MISC_DEVICES is not set
>> CONFIG_HAVE_IDE=3Dy
>> # CONFIG_IDE is not set
>>
>> #
>> # SCSI device support
>> #
>> CONFIG_SCSI_MOD=3Dy
>> # CONFIG_RAID_ATTRS is not set
>> CONFIG_SCSI=3Dy
>> CONFIG_SCSI_DMA=3Dy
>> # CONFIG_SCSI_TGT is not set
>> # CONFIG_SCSI_NETLINK is not set
>> CONFIG_SCSI_PROC_FS=3Dy
>>
>> #
>> # SCSI support type (disk, tape, CD-ROM)
>> #
>> CONFIG_BLK_DEV_SD=3Dy
>> # CONFIG_CHR_DEV_ST is not set
>> # CONFIG_CHR_DEV_OSST is not set
>> # CONFIG_BLK_DEV_SR is not set
>> # CONFIG_CHR_DEV_SG is not set
>> # CONFIG_CHR_DEV_SCH is not set
>> # CONFIG_SCSI_MULTI_LUN is not set
>> # CONFIG_SCSI_CONSTANTS is not set
>> # CONFIG_SCSI_LOGGING is not set
>> # CONFIG_SCSI_SCAN_ASYNC is not set
>> CONFIG_SCSI_WAIT_SCAN=3Dm
>>
>> #
>> # SCSI Transports
>> #
>> # CONFIG_SCSI_SPI_ATTRS is not set
>> # CONFIG_SCSI_FC_ATTRS is not set
>> # CONFIG_SCSI_ISCSI_ATTRS is not set
>> # CONFIG_SCSI_SAS_ATTRS is not set
>> # CONFIG_SCSI_SAS_LIBSAS is not set
>> # CONFIG_SCSI_SRP_ATTRS is not set
>> CONFIG_SCSI_LOWLEVEL=3Dy
>> # CONFIG_ISCSI_TCP is not set
>> # CONFIG_ISCSI_BOOT_SYSFS is not set
>> # CONFIG_LIBFC is not set
>> # CONFIG_LIBFCOE is not set
>> # CONFIG_SCSI_DEBUG is not set
>> # CONFIG_SCSI_DH is not set
>> # CONFIG_SCSI_OSD_INITIATOR is not set
>> # CONFIG_ATA is not set
>> # CONFIG_MD is not set
>> # CONFIG_TARGET_CORE is not set
>> CONFIG_NETDEVICES=3Dy
>> # CONFIG_DUMMY is not set
>> # CONFIG_BONDING is not set
>> # CONFIG_MACVLAN is not set
>> # CONFIG_EQUALIZER is not set
>> # CONFIG_TUN is not set
>> # CONFIG_VETH is not set
>> CONFIG_MII=3Dy
>> CONFIG_PHYLIB=3Dy
>>
>> #
>> # MII PHY device drivers
>> #
>> # CONFIG_MARVELL_PHY is not set
>> # CONFIG_DAVICOM_PHY is not set
>> # CONFIG_QSEMI_PHY is not set
>> # CONFIG_LXT_PHY is not set
>> # CONFIG_CICADA_PHY is not set
>> # CONFIG_VITESSE_PHY is not set
>> # CONFIG_SMSC_PHY is not set
>> # CONFIG_BROADCOM_PHY is not set
>> # CONFIG_ICPLUS_PHY is not set
>> # CONFIG_REALTEK_PHY is not set
>> # CONFIG_NATIONAL_PHY is not set
>> # CONFIG_STE10XP is not set
>> # CONFIG_LSI_ET1011C_PHY is not set
>> # CONFIG_MICREL_PHY is not set
>> # CONFIG_FIXED_PHY is not set
>> # CONFIG_MDIO_BITBANG is not set
>> CONFIG_NET_ETHERNET=3Dy
>> # CONFIG_AX88796 is not set
>> # CONFIG_SMC91X is not set
>> CONFIG_TI_DAVINCI_EMAC=3Dy
>> CONFIG_TI_DAVINCI_MDIO=3Dy
>> CONFIG_TI_DAVINCI_CPDMA=3Dy
>> # CONFIG_DM9000 is not set
>> # CONFIG_ETHOC is not set
>> # CONFIG_SMC911X is not set
>> # CONFIG_SMSC911X is not set
>> # CONFIG_DNET is not set
>> # CONFIG_IBM_NEW_EMAC_ZMII is not set
>> # CONFIG_IBM_NEW_EMAC_RGMII is not set
>> # CONFIG_IBM_NEW_EMAC_TAH is not set
>> # CONFIG_IBM_NEW_EMAC_EMAC4 is not set
>> # CONFIG_IBM_NEW_EMAC_NO_FLOW_CTRL is not set
>> # CONFIG_IBM_NEW_EMAC_MAL_CLR_ICINTSTAT is not set
>> # CONFIG_IBM_NEW_EMAC_MAL_COMMON_ERR is not set
>> # CONFIG_B44 is not set
>> # CONFIG_KS8851_MLL is not set
>> # CONFIG_FTMAC100 is not set
>> CONFIG_NETDEV_1000=3Dy
>> # CONFIG_STMMAC_ETH is not set
>> # CONFIG_FTGMAC100 is not set
>> CONFIG_NETDEV_10000=3Dy
>> CONFIG_WLAN=3Dy
>> # CONFIG_HOSTAP is not set
>>
>> #
>> # Enable WiMAX (Networking options) to see the WiMAX drivers
>> #
>> # CONFIG_WAN is not set
>>
>> #
>> # CAIF transport drivers
>> #
>> # CONFIG_PPP is not set
>> # CONFIG_SLIP is not set
>> # CONFIG_NETCONSOLE is not set
>> # CONFIG_NETPOLL is not set
>> # CONFIG_NET_POLL_CONTROLLER is not set
>> # CONFIG_ISDN is not set
>> # CONFIG_PHONE is not set
>>
>> #
>> # Input device support
>> #
>> CONFIG_INPUT=3Dy
>> # CONFIG_INPUT_FF_MEMLESS is not set
>> # CONFIG_INPUT_POLLDEV is not set
>> # CONFIG_INPUT_SPARSEKMAP is not set
>>
>> #
>> # Userland interfaces
>> #
>> # CONFIG_INPUT_MOUSEDEV is not set
>> # CONFIG_INPUT_JOYDEV is not set
>> CONFIG_INPUT_EVDEV=3Dy
>> # CONFIG_INPUT_EVBUG is not set
>>
>> #
>> # Input Device Drivers
>> #
>> CONFIG_INPUT_KEYBOARD=3Dy
>> # CONFIG_KEYBOARD_ADP5588 is not set
>> # CONFIG_KEYBOARD_ADP5589 is not set
>> CONFIG_KEYBOARD_ATKBD=3Dy
>> # CONFIG_KEYBOARD_QT1070 is not set
>> # CONFIG_KEYBOARD_QT2160 is not set
>> # CONFIG_KEYBOARD_LKKBD is not set
>> # CONFIG_KEYBOARD_GPIO is not set
>> CONFIG_KEYBOARD_TCA6416=3Dy
>> # CONFIG_KEYBOARD_MATRIX is not set
>> # CONFIG_KEYBOARD_MAX7359 is not set
>> # CONFIG_KEYBOARD_MCS is not set
>> # CONFIG_KEYBOARD_MPR121 is not set
>> # CONFIG_KEYBOARD_NEWTON is not set
>> # CONFIG_KEYBOARD_OPENCORES is not set
>> # CONFIG_KEYBOARD_STOWAWAY is not set
>> # CONFIG_KEYBOARD_SUNKBD is not set
>> # CONFIG_KEYBOARD_TWL4030 is not set
>> # CONFIG_KEYBOARD_XTKBD is not set
>> # CONFIG_INPUT_MOUSE is not set
>> # CONFIG_INPUT_JOYSTICK is not set
>> # CONFIG_INPUT_TABLET is not set
>> CONFIG_INPUT_TOUCHSCREEN=3Dy
>> # CONFIG_TOUCHSCREEN_AD7879 is not set
>> # CONFIG_TOUCHSCREEN_ATMEL_MXT is not set
>> # CONFIG_TOUCHSCREEN_BU21013 is not set
>> # CONFIG_TOUCHSCREEN_CY8CTMG110 is not set
>> # CONFIG_TOUCHSCREEN_DYNAPRO is not set
>> # CONFIG_TOUCHSCREEN_HAMPSHIRE is not set
>> # CONFIG_TOUCHSCREEN_EETI is not set
>> # CONFIG_TOUCHSCREEN_FUJITSU is not set
>> # CONFIG_TOUCHSCREEN_GUNZE is not set
>> # CONFIG_TOUCHSCREEN_ELO is not set
>> # CONFIG_TOUCHSCREEN_WACOM_W8001 is not set
>> # CONFIG_TOUCHSCREEN_MAX11801 is not set
>> # CONFIG_TOUCHSCREEN_MCS5000 is not set
>> # CONFIG_TOUCHSCREEN_MTOUCH is not set
>> # CONFIG_TOUCHSCREEN_INEXIO is not set
>> # CONFIG_TOUCHSCREEN_MK712 is not set
>> # CONFIG_TOUCHSCREEN_PENMOUNT is not set
>> # CONFIG_TOUCHSCREEN_TOUCHRIGHT is not set
>> # CONFIG_TOUCHSCREEN_TOUCHWIN is not set
>> # CONFIG_TOUCHSCREEN_TOUCHIT213 is not set
>> # CONFIG_TOUCHSCREEN_TSC2007 is not set
>> # CONFIG_TOUCHSCREEN_W90X900 is not set
>> # CONFIG_TOUCHSCREEN_ST1232 is not set
>> # CONFIG_TOUCHSCREEN_TPS6507X is not set
>> # CONFIG_INPUT_MISC is not set
>>
>> #
>> # Hardware I/O ports
>> #
>> CONFIG_SERIO=3Dy
>> CONFIG_SERIO_SERPORT=3Dy
>> CONFIG_SERIO_LIBPS2=3Dy
>> # CONFIG_SERIO_RAW is not set
>> # CONFIG_SERIO_ALTERA_PS2 is not set
>> # CONFIG_SERIO_PS2MULT is not set
>> # CONFIG_GAMEPORT is not set
>>
>> #
>> # Character devices
>> #
>> CONFIG_VT=3Dy
>> CONFIG_CONSOLE_TRANSLATIONS=3Dy
>> CONFIG_VT_CONSOLE=3Dy
>> CONFIG_HW_CONSOLE=3Dy
>> # CONFIG_VT_HW_CONSOLE_BINDING is not set
>> CONFIG_UNIX98_PTYS=3Dy
>> # CONFIG_DEVPTS_MULTIPLE_INSTANCES is not set
>> # CONFIG_LEGACY_PTYS is not set
>> # CONFIG_SERIAL_NONSTANDARD is not set
>> # CONFIG_N_GSM is not set
>> # CONFIG_TRACE_SINK is not set
>> CONFIG_DEVKMEM=3Dy
>>
>> #
>> # Serial drivers
>> #
>> CONFIG_SERIAL_8250=3Dy
>> CONFIG_SERIAL_8250_CONSOLE=3Dy
>> CONFIG_SERIAL_8250_NR_UARTS=3D32
>> CONFIG_SERIAL_8250_RUNTIME_UARTS=3D4
>> CONFIG_SERIAL_8250_EXTENDED=3Dy
>> CONFIG_SERIAL_8250_MANY_PORTS=3Dy
>> CONFIG_SERIAL_8250_SHARE_IRQ=3Dy
>> CONFIG_SERIAL_8250_DETECT_IRQ=3Dy
>> CONFIG_SERIAL_8250_RSA=3Dy
>>
>> #
>> # Non-8250 serial port support
>> #
>> CONFIG_SERIAL_CORE=3Dy
>> CONFIG_SERIAL_CORE_CONSOLE=3Dy
>> CONFIG_SERIAL_OMAP=3Dy
>> CONFIG_SERIAL_OMAP_CONSOLE=3Dy
>> # CONFIG_SERIAL_TIMBERDALE is not set
>> # CONFIG_SERIAL_ALTERA_JTAGUART is not set
>> # CONFIG_SERIAL_ALTERA_UART is not set
>> # CONFIG_SERIAL_XILINX_PS_UART is not set
>> # CONFIG_TTY_PRINTK is not set
>> # CONFIG_HVC_DCC is not set
>> # CONFIG_IPMI_HANDLER is not set
>> CONFIG_HW_RANDOM=3Dy
>> # CONFIG_HW_RANDOM_TIMERIOMEM is not set
>> # CONFIG_R3964 is not set
>> # CONFIG_RAW_DRIVER is not set
>> # CONFIG_TCG_TPM is not set
>> # CONFIG_RAMOOPS is not set
>> CONFIG_I2C=3Dy
>> CONFIG_I2C_BOARDINFO=3Dy
>> CONFIG_I2C_COMPAT=3Dy
>> # CONFIG_I2C_CHARDEV is not set
>> # CONFIG_I2C_MUX is not set
>> CONFIG_I2C_HELPER_AUTO=3Dy
>>
>> #
>> # I2C Hardware Bus support
>> #
>>
>> #
>> # I2C system bus drivers (mostly embedded / system-on-chip)
>> #
>> # CONFIG_I2C_DESIGNWARE is not set
>> # CONFIG_I2C_GPIO is not set
>> # CONFIG_I2C_OCORES is not set
>> CONFIG_I2C_OMAP=3Dy
>> # CONFIG_I2C_PCA_PLATFORM is not set
>> # CONFIG_I2C_PXA_PCI is not set
>> # CONFIG_I2C_SIMTEC is not set
>> # CONFIG_I2C_XILINX is not set
>>
>> #
>> # External I2C/SMBus adapter drivers
>> #
>> # CONFIG_I2C_PARPORT_LIGHT is not set
>> # CONFIG_I2C_TAOS_EVM is not set
>>
>> #
>> # Other I2C/SMBus bus drivers
>> #
>> # CONFIG_I2C_STUB is not set
>> # CONFIG_I2C_DEBUG_CORE is not set
>> # CONFIG_I2C_DEBUG_ALGO is not set
>> # CONFIG_I2C_DEBUG_BUS is not set
>> # CONFIG_SPI is not set
>>
>> #
>> # PPS support
>> #
>> # CONFIG_PPS is not set
>>
>> #
>> # PPS generators support
>> #
>>
>> #
>> # PTP clock support
>> #
>>
>> #
>> # Enable Device Drivers -> PPS to see the PTP clock options.
>> #
>> CONFIG_ARCH_REQUIRE_GPIOLIB=3Dy
>> CONFIG_GPIOLIB=3Dy
>> # CONFIG_DEBUG_GPIO is not set
>> CONFIG_GPIO_SYSFS=3Dy
>>
>> #
>> # Memory mapped GPIO drivers:
>> #
>> # CONFIG_GPIO_GENERIC_PLATFORM is not set
>> # CONFIG_GPIO_IT8761E is not set
>>
>> #
>> # I2C GPIO expanders:
>> #
>> # CONFIG_GPIO_MAX7300 is not set
>> # CONFIG_GPIO_MAX732X is not set
>> # CONFIG_GPIO_PCA953X_IRQ is not set
>> # CONFIG_GPIO_PCF857X is not set
>> # CONFIG_GPIO_SX150X is not set
>> # CONFIG_GPIO_TWL4030 is not set
>> # CONFIG_GPIO_ADP5588 is not set
>>
>> #
>> # PCI GPIO expanders:
>> #
>>
>> #
>> # SPI GPIO expanders:
>> #
>> # CONFIG_GPIO_MCP23S08 is not set
>>
>> #
>> # AC97 GPIO expanders:
>> #
>>
>> #
>> # MODULbus GPIO expanders:
>> #
>> # CONFIG_W1 is not set
>> # CONFIG_POWER_SUPPLY is not set
>> # CONFIG_HWMON is not set
>> # CONFIG_THERMAL is not set
>> CONFIG_WATCHDOG=3Dy
>> # CONFIG_WATCHDOG_CORE is not set
>> CONFIG_WATCHDOG_NOWAYOUT=3Dy
>>
>> #
>> # Watchdog Device Drivers
>> #
>> # CONFIG_SOFT_WATCHDOG is not set
>> # CONFIG_DW_WATCHDOG is not set
>> CONFIG_OMAP_WATCHDOG=3Dy
>> # CONFIG_TWL4030_WATCHDOG is not set
>> # CONFIG_MAX63XX_WATCHDOG is not set
>> CONFIG_SSB_POSSIBLE=3Dy
>>
>> #
>> # Sonics Silicon Backplane
>> #
>> # CONFIG_SSB is not set
>> CONFIG_BCMA_POSSIBLE=3Dy
>>
>> #
>> # Broadcom specific AMBA
>> #
>> # CONFIG_BCMA is not set
>> CONFIG_MFD_SUPPORT=3Dy
>> # CONFIG_MFD_CORE is not set
>> # CONFIG_MFD_88PM860X is not set
>> # CONFIG_MFD_SM501 is not set
>> # CONFIG_MFD_ASIC3 is not set
>> # CONFIG_HTC_EGPIO is not set
>> # CONFIG_HTC_PASIC3 is not set
>> # CONFIG_HTC_I2CPLD is not set
>> # CONFIG_TPS6105X is not set
>> # CONFIG_TPS65010 is not set
>> # CONFIG_TPS6507X is not set
>> # CONFIG_MFD_TPS6586X is not set
>> # CONFIG_MFD_TPS65910 is not set
>> # CONFIG_MFD_TPS65912_I2C is not set
>> CONFIG_TWL4030_CORE=3Dy
>> # CONFIG_TWL4030_MADC is not set
>> CONFIG_TWL4030_POWER=3Dy
>> # CONFIG_MFD_TWL4030_AUDIO is not set
>> # CONFIG_TWL6030_PWM is not set
>> # CONFIG_TWL6040_CORE is not set
>> # CONFIG_MFD_STMPE is not set
>> # CONFIG_MFD_TC3589X is not set
>> # CONFIG_MFD_TMIO is not set
>> # CONFIG_MFD_T7L66XB is not set
>> # CONFIG_MFD_TC6387XB is not set
>> # CONFIG_MFD_TC6393XB is not set
>> # CONFIG_PMIC_DA903X is not set
>> # CONFIG_PMIC_ADP5520 is not set
>> # CONFIG_MFD_MAX8925 is not set
>> # CONFIG_MFD_MAX8997 is not set
>> # CONFIG_MFD_MAX8998 is not set
>> # CONFIG_MFD_WM8400 is not set
>> # CONFIG_MFD_WM831X_I2C is not set
>> # CONFIG_MFD_WM8350_I2C is not set
>> # CONFIG_MFD_WM8994 is not set
>> # CONFIG_MFD_PCF50633 is not set
>> # CONFIG_ABX500_CORE is not set
>> # CONFIG_MFD_WL1273_CORE is not set
>> # CONFIG_MFD_AAT2870_CORE is not set
>> CONFIG_REGULATOR=3Dy
>> # CONFIG_REGULATOR_DEBUG is not set
>> # CONFIG_REGULATOR_DUMMY is not set
>> # CONFIG_REGULATOR_FIXED_VOLTAGE is not set
>> # CONFIG_REGULATOR_VIRTUAL_CONSUMER is not set
>> # CONFIG_REGULATOR_USERSPACE_CONSUMER is not set
>> # CONFIG_REGULATOR_BQ24022 is not set
>> # CONFIG_REGULATOR_MAX1586 is not set
>> # CONFIG_REGULATOR_MAX8649 is not set
>> # CONFIG_REGULATOR_MAX8660 is not set
>> # CONFIG_REGULATOR_MAX8952 is not set
>> # CONFIG_REGULATOR_TWL4030 is not set
>> # CONFIG_REGULATOR_LP3971 is not set
>> # CONFIG_REGULATOR_LP3972 is not set
>> CONFIG_REGULATOR_TPS65023=3Dy
>> # CONFIG_REGULATOR_TPS6507X is not set
>> # CONFIG_REGULATOR_ISL6271A is not set
>> # CONFIG_REGULATOR_AD5398 is not set
>> # CONFIG_MEDIA_SUPPORT is not set
>>
>> #
>> # Graphics support
>> #
>> # CONFIG_DRM is not set
>> # CONFIG_VGASTATE is not set
>> # CONFIG_VIDEO_OUTPUT_CONTROL is not set
>> CONFIG_FB=3Dy
>> # CONFIG_FIRMWARE_EDID is not set
>> # CONFIG_FB_DDC is not set
>> # CONFIG_FB_BOOT_VESA_SUPPORT is not set
>> CONFIG_FB_CFB_FILLRECT=3Dy
>> CONFIG_FB_CFB_COPYAREA=3Dy
>> CONFIG_FB_CFB_IMAGEBLIT=3Dy
>> # CONFIG_FB_CFB_REV_PIXELS_IN_BYTE is not set
>> # CONFIG_FB_SYS_FILLRECT is not set
>> # CONFIG_FB_SYS_COPYAREA is not set
>> # CONFIG_FB_SYS_IMAGEBLIT is not set
>> # CONFIG_FB_FOREIGN_ENDIAN is not set
>> # CONFIG_FB_SYS_FOPS is not set
>> # CONFIG_FB_WMT_GE_ROPS is not set
>> # CONFIG_FB_SVGALIB is not set
>> # CONFIG_FB_MACMODES is not set
>> # CONFIG_FB_BACKLIGHT is not set
>> # CONFIG_FB_MODE_HELPERS is not set
>> # CONFIG_FB_TILEBLITTING is not set
>>
>> #
>> # Frame buffer hardware drivers
>> #
>> # CONFIG_FB_S1D13XXX is not set
>> # CONFIG_FB_VIRTUAL is not set
>> # CONFIG_FB_METRONOME is not set
>> # CONFIG_FB_BROADSHEET is not set
>> # CONFIG_FB_OMAP_BOOTLOADER_INIT is not set
>> CONFIG_OMAP2_VRAM=3Dy
>> CONFIG_OMAP2_VRFB=3Dy
>> CONFIG_OMAP2_DSS=3Dy
>> CONFIG_OMAP2_VRAM_SIZE=3D4
>> # CONFIG_OMAP2_DSS_DEBUG_SUPPORT is not set
>> CONFIG_OMAP2_DSS_DPI=3Dy
>> # CONFIG_OMAP2_DSS_RFBI is not set
>> CONFIG_OMAP2_DSS_VENC=3Dy
>> # CONFIG_OMAP2_DSS_SDI is not set
>> CONFIG_OMAP2_DSS_DSI=3Dy
>> # CONFIG_OMAP2_DSS_FAKE_VSYNC is not set
>> CONFIG_OMAP2_DSS_MIN_FCK_PER_PCK=3D1
>> CONFIG_OMAP2_DSS_SLEEP_AFTER_VENC_RESET=3Dy
>> CONFIG_FB_OMAP2=3Dy
>> # CONFIG_FB_OMAP2_DEBUG_SUPPORT is not set
>> CONFIG_FB_OMAP2_NUM_FBS=3D1
>>
>> #
>> # OMAP2/3 Display Device Drivers
>> #
>> # CONFIG_PANEL_GENERIC_DPI is not set
>> # CONFIG_PANEL_SHARP_LS037V7DW01 is not set
>> # CONFIG_PANEL_NEC_NL8048HL11_01B is not set
>> # CONFIG_PANEL_TAAL is not set
>> # CONFIG_BACKLIGHT_LCD_SUPPORT is not set
>>
>> #
>> # Display device support
>> #
>> # CONFIG_DISPLAY_SUPPORT is not set
>>
>> #
>> # Console display driver support
>> #
>> CONFIG_DUMMY_CONSOLE=3Dy
>> # CONFIG_FRAMEBUFFER_CONSOLE is not set
>> CONFIG_LOGO=3Dy
>> CONFIG_LOGO_LINUX_MONO=3Dy
>> CONFIG_LOGO_LINUX_VGA16=3Dy
>> CONFIG_LOGO_LINUX_CLUT224=3Dy
>> CONFIG_SOUND=3Dy
>> # CONFIG_SOUND_OSS_CORE is not set
>> CONFIG_SND=3Dy
>> CONFIG_SND_TIMER=3Dy
>> CONFIG_SND_PCM=3Dy
>> CONFIG_SND_JACK=3Dy
>> # CONFIG_SND_SEQUENCER is not set
>> # CONFIG_SND_MIXER_OSS is not set
>> # CONFIG_SND_PCM_OSS is not set
>> # CONFIG_SND_HRTIMER is not set
>> # CONFIG_SND_DYNAMIC_MINORS is not set
>> CONFIG_SND_SUPPORT_OLD_API=3Dy
>> CONFIG_SND_VERBOSE_PROCFS=3Dy
>> # CONFIG_SND_VERBOSE_PRINTK is not set
>> # CONFIG_SND_DEBUG is not set
>> # CONFIG_SND_RAWMIDI_SEQ is not set
>> # CONFIG_SND_OPL3_LIB_SEQ is not set
>> # CONFIG_SND_OPL4_LIB_SEQ is not set
>> # CONFIG_SND_SBAWE_SEQ is not set
>> # CONFIG_SND_EMU10K1_SEQ is not set
>> # CONFIG_SND_DRIVERS is not set
>> # CONFIG_SND_ARM is not set
>> CONFIG_SND_SOC=3Dy
>> # CONFIG_SND_SOC_CACHE_LZO is not set
>> CONFIG_SND_OMAP_SOC=3Dy
>> CONFIG_SND_OMAP_SOC_MCBSP=3Dy
>> CONFIG_SND_OMAP_SOC_AM3517EVM=3Dy
>> CONFIG_SND_SOC_I2C_AND_SPI=3Dy
>> # CONFIG_SND_SOC_ALL_CODECS is not set
>> CONFIG_SND_SOC_TLV320AIC23=3Dy
>> # CONFIG_SOUND_PRIME is not set
>> CONFIG_HID_SUPPORT=3Dy
>> CONFIG_HID=3Dy
>> # CONFIG_HIDRAW is not set
>> # CONFIG_HID_PID is not set
>>
>> #
>> # Special HID drivers
>> #
>> # CONFIG_USB_SUPPORT is not set
>> CONFIG_USB_ARCH_HAS_EHCI=3Dy
>> CONFIG_MMC=3Dy
>> # CONFIG_MMC_DEBUG is not set
>> # CONFIG_MMC_UNSAFE_RESUME is not set
>> # CONFIG_MMC_CLKGATE is not set
>>
>> #
>> # MMC/SD/SDIO Card Drivers
>> #
>> CONFIG_MMC_BLOCK=3Dy
>> CONFIG_MMC_BLOCK_MINORS=3D8
>> CONFIG_MMC_BLOCK_BOUNCE=3Dy
>> # CONFIG_SDIO_UART is not set
>> # CONFIG_MMC_TEST is not set
>>
>> #
>> # MMC/SD/SDIO Host Controller Drivers
>> #
>> # CONFIG_MMC_SDHCI is not set
>> # CONFIG_MMC_SDHCI_PXAV3 is not set
>> # CONFIG_MMC_SDHCI_PXAV2 is not set
>> # CONFIG_MMC_OMAP is not set
>> CONFIG_MMC_OMAP_HS=3Dy
>> # CONFIG_MMC_DW is not set
>> # CONFIG_MEMSTICK is not set
>> # CONFIG_NEW_LEDS is not set
>> # CONFIG_ACCESSIBILITY is not set
>> CONFIG_RTC_LIB=3Dy
>> CONFIG_RTC_CLASS=3Dy
>> CONFIG_RTC_HCTOSYS=3Dy
>> CONFIG_RTC_HCTOSYS_DEVICE=3D"rtc0"
>> # CONFIG_RTC_DEBUG is not set
>>
>> #
>> # RTC interfaces
>> #
>> CONFIG_RTC_INTF_SYSFS=3Dy
>> CONFIG_RTC_INTF_PROC=3Dy
>> CONFIG_RTC_INTF_DEV=3Dy
>> # CONFIG_RTC_INTF_DEV_UIE_EMUL is not set
>> # CONFIG_RTC_DRV_TEST is not set
>>
>> #
>> # I2C RTC drivers
>> #
>> # CONFIG_RTC_DRV_DS1307 is not set
>> # CONFIG_RTC_DRV_DS1374 is not set
>> # CONFIG_RTC_DRV_DS1672 is not set
>> # CONFIG_RTC_DRV_DS3232 is not set
>> # CONFIG_RTC_DRV_MAX6900 is not set
>> # CONFIG_RTC_DRV_RS5C372 is not set
>> # CONFIG_RTC_DRV_ISL1208 is not set
>> # CONFIG_RTC_DRV_ISL12022 is not set
>> # CONFIG_RTC_DRV_X1205 is not set
>> # CONFIG_RTC_DRV_PCF8563 is not set
>> # CONFIG_RTC_DRV_PCF8583 is not set
>> # CONFIG_RTC_DRV_M41T80 is not set
>> # CONFIG_RTC_DRV_BQ32K is not set
>> # CONFIG_RTC_DRV_TWL4030 is not set
>> CONFIG_RTC_DRV_S35390A=3Dy
>> # CONFIG_RTC_DRV_FM3130 is not set
>> # CONFIG_RTC_DRV_RX8581 is not set
>> # CONFIG_RTC_DRV_RX8025 is not set
>> # CONFIG_RTC_DRV_EM3027 is not set
>> # CONFIG_RTC_DRV_RV3029C2 is not set
>>
>> #
>> # SPI RTC drivers
>> #
>>
>> #
>> # Platform RTC drivers
>> #
>> # CONFIG_RTC_DRV_CMOS is not set
>> # CONFIG_RTC_DRV_DS1286 is not set
>> # CONFIG_RTC_DRV_DS1511 is not set
>> # CONFIG_RTC_DRV_DS1553 is not set
>> # CONFIG_RTC_DRV_DS1742 is not set
>> # CONFIG_RTC_DRV_STK17TA8 is not set
>> # CONFIG_RTC_DRV_M48T86 is not set
>> # CONFIG_RTC_DRV_M48T35 is not set
>> # CONFIG_RTC_DRV_M48T59 is not set
>> # CONFIG_RTC_DRV_MSM6242 is not set
>> # CONFIG_RTC_DRV_BQ4802 is not set
>> # CONFIG_RTC_DRV_RP5C01 is not set
>> # CONFIG_RTC_DRV_V3020 is not set
>>
>> #
>> # on-CPU RTC drivers
>> #
>> # CONFIG_DMADEVICES is not set
>> # CONFIG_AUXDISPLAY is not set
>> # CONFIG_UIO is not set
>>
>> #
>> # Virtio drivers
>> #
>> # CONFIG_VIRTIO_BALLOON is not set
>> # CONFIG_STAGING is not set
>> CONFIG_CLKDEV_LOOKUP=3Dy
>> CONFIG_CLKSRC_MMIO=3Dy
>> CONFIG_IOMMU_SUPPORT=3Dy
>> # CONFIG_VIRT_DRIVERS is not set
>>
>> #
>> # File systems
>> #
>> CONFIG_EXT2_FS=3Dy
>> # CONFIG_EXT2_FS_XATTR is not set
>> # CONFIG_EXT2_FS_XIP is not set
>> CONFIG_EXT3_FS=3Dy
>> # CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
>> # CONFIG_EXT3_FS_XATTR is not set
>> # CONFIG_EXT4_FS is not set
>> CONFIG_JBD=3Dy
>> # CONFIG_REISERFS_FS is not set
>> # CONFIG_JFS_FS is not set
>> # CONFIG_XFS_FS is not set
>> # CONFIG_GFS2_FS is not set
>> # CONFIG_BTRFS_FS is not set
>> # CONFIG_NILFS2_FS is not set
>> # CONFIG_FS_POSIX_ACL is not set
>> CONFIG_FILE_LOCKING=3Dy
>> CONFIG_FSNOTIFY=3Dy
>> CONFIG_DNOTIFY=3Dy
>> CONFIG_INOTIFY_USER=3Dy
>> # CONFIG_FANOTIFY is not set
>> CONFIG_QUOTA=3Dy
>> # CONFIG_QUOTA_NETLINK_INTERFACE is not set
>> CONFIG_PRINT_QUOTA_WARNING=3Dy
>> # CONFIG_QUOTA_DEBUG is not set
>> CONFIG_QUOTA_TREE=3Dy
>> # CONFIG_QFMT_V1 is not set
>> CONFIG_QFMT_V2=3Dy
>> CONFIG_QUOTACTL=3Dy
>> # CONFIG_AUTOFS4_FS is not set
>> # CONFIG_FUSE_FS is not set
>>
>> #
>> # Caches
>> #
>> # CONFIG_FSCACHE is not set
>>
>> #
>> # CD-ROM/DVD Filesystems
>> #
>> # CONFIG_ISO9660_FS is not set
>> # CONFIG_UDF_FS is not set
>>
>> #
>> # DOS/FAT/NT Filesystems
>> #
>> CONFIG_FAT_FS=3Dy
>> CONFIG_MSDOS_FS=3Dy
>> CONFIG_VFAT_FS=3Dy
>> CONFIG_FAT_DEFAULT_CODEPAGE=3D437
>> CONFIG_FAT_DEFAULT_IOCHARSET=3D"iso8859-1"
>> # CONFIG_NTFS_FS is not set
>>
>> #
>> # Pseudo filesystems
>> #
>> CONFIG_PROC_FS=3Dy
>> CONFIG_PROC_SYSCTL=3Dy
>> CONFIG_PROC_PAGE_MONITOR=3Dy
>> CONFIG_SYSFS=3Dy
>> CONFIG_TMPFS=3Dy
>> # CONFIG_TMPFS_POSIX_ACL is not set
>> # CONFIG_TMPFS_XATTR is not set
>> # CONFIG_HUGETLB_PAGE is not set
>> # CONFIG_CONFIGFS_FS is not set
>> CONFIG_MISC_FILESYSTEMS=3Dy
>> # CONFIG_ADFS_FS is not set
>> # CONFIG_AFFS_FS is not set
>> # CONFIG_ECRYPT_FS is not set
>> # CONFIG_HFS_FS is not set
>> # CONFIG_HFSPLUS_FS is not set
>> # CONFIG_BEFS_FS is not set
>> # CONFIG_BFS_FS is not set
>> # CONFIG_EFS_FS is not set
>> CONFIG_JFFS2_FS=3Dy
>> CONFIG_JFFS2_FS_DEBUG=3D0
>> CONFIG_JFFS2_FS_WRITEBUFFER=3Dy
>> # CONFIG_JFFS2_FS_WBUF_VERIFY is not set
>> # CONFIG_JFFS2_SUMMARY is not set
>> # CONFIG_JFFS2_FS_XATTR is not set
>> CONFIG_JFFS2_COMPRESSION_OPTIONS=3Dy
>> CONFIG_JFFS2_ZLIB=3Dy
>> # CONFIG_JFFS2_LZO is not set
>> CONFIG_JFFS2_RTIME=3Dy
>> # CONFIG_JFFS2_RUBIN is not set
>> # CONFIG_JFFS2_CMODE_NONE is not set
>> CONFIG_JFFS2_CMODE_PRIORITY=3Dy
>> # CONFIG_JFFS2_CMODE_SIZE is not set
>> # CONFIG_JFFS2_CMODE_FAVOURLZO is not set
>> # CONFIG_LOGFS is not set
>> # CONFIG_CRAMFS is not set
>> # CONFIG_SQUASHFS is not set
>> # CONFIG_VXFS_FS is not set
>> # CONFIG_MINIX_FS is not set
>> # CONFIG_OMFS_FS is not set
>> # CONFIG_HPFS_FS is not set
>> # CONFIG_QNX4FS_FS is not set
>> # CONFIG_ROMFS_FS is not set
>> # CONFIG_PSTORE is not set
>> # CONFIG_SYSV_FS is not set
>> # CONFIG_UFS_FS is not set
>> CONFIG_NETWORK_FILESYSTEMS=3Dy
>> CONFIG_NFS_FS=3Dy
>> CONFIG_NFS_V3=3Dy
>> # CONFIG_NFS_V3_ACL is not set
>> CONFIG_NFS_V4=3Dy
>> # CONFIG_NFS_V4_1 is not set
>> CONFIG_ROOT_NFS=3Dy
>> # CONFIG_NFS_USE_LEGACY_DNS is not set
>> CONFIG_NFS_USE_KERNEL_DNS=3Dy
>> # CONFIG_NFS_USE_NEW_IDMAPPER is not set
>> # CONFIG_NFSD is not set
>> CONFIG_LOCKD=3Dy
>> CONFIG_LOCKD_V4=3Dy
>> CONFIG_NFS_COMMON=3Dy
>> CONFIG_SUNRPC=3Dy
>> CONFIG_SUNRPC_GSS=3Dy
>> # CONFIG_CEPH_FS is not set
>> # CONFIG_CIFS is not set
>> # CONFIG_NCP_FS is not set
>> # CONFIG_CODA_FS is not set
>> # CONFIG_AFS_FS is not set
>>
>> #
>> # Partition Types
>> #
>> CONFIG_PARTITION_ADVANCED=3Dy
>> # CONFIG_ACORN_PARTITION is not set
>> # CONFIG_OSF_PARTITION is not set
>> # CONFIG_AMIGA_PARTITION is not set
>> # CONFIG_ATARI_PARTITION is not set
>> # CONFIG_MAC_PARTITION is not set
>> CONFIG_MSDOS_PARTITION=3Dy
>> # CONFIG_BSD_DISKLABEL is not set
>> # CONFIG_MINIX_SUBPARTITION is not set
>> # CONFIG_SOLARIS_X86_PARTITION is not set
>> # CONFIG_UNIXWARE_DISKLABEL is not set
>> # CONFIG_LDM_PARTITION is not set
>> # CONFIG_SGI_PARTITION is not set
>> # CONFIG_ULTRIX_PARTITION is not set
>> # CONFIG_SUN_PARTITION is not set
>> # CONFIG_KARMA_PARTITION is not set
>> # CONFIG_EFI_PARTITION is not set
>> # CONFIG_SYSV68_PARTITION is not set
>> CONFIG_NLS=3Dy
>> CONFIG_NLS_DEFAULT=3D"iso8859-1"
>> CONFIG_NLS_CODEPAGE_437=3Dy
>> # CONFIG_NLS_CODEPAGE_737 is not set
>> # CONFIG_NLS_CODEPAGE_775 is not set
>> # CONFIG_NLS_CODEPAGE_850 is not set
>> # CONFIG_NLS_CODEPAGE_852 is not set
>> # CONFIG_NLS_CODEPAGE_855 is not set
>> # CONFIG_NLS_CODEPAGE_857 is not set
>> # CONFIG_NLS_CODEPAGE_860 is not set
>> # CONFIG_NLS_CODEPAGE_861 is not set
>> # CONFIG_NLS_CODEPAGE_862 is not set
>> # CONFIG_NLS_CODEPAGE_863 is not set
>> # CONFIG_NLS_CODEPAGE_864 is not set
>> # CONFIG_NLS_CODEPAGE_865 is not set
>> # CONFIG_NLS_CODEPAGE_866 is not set
>> # CONFIG_NLS_CODEPAGE_869 is not set
>> # CONFIG_NLS_CODEPAGE_936 is not set
>> # CONFIG_NLS_CODEPAGE_950 is not set
>> # CONFIG_NLS_CODEPAGE_932 is not set
>> # CONFIG_NLS_CODEPAGE_949 is not set
>> # CONFIG_NLS_CODEPAGE_874 is not set
>> # CONFIG_NLS_ISO8859_8 is not set
>> # CONFIG_NLS_CODEPAGE_1250 is not set
>> # CONFIG_NLS_CODEPAGE_1251 is not set
>> # CONFIG_NLS_ASCII is not set
>> CONFIG_NLS_ISO8859_1=3Dy
>> # CONFIG_NLS_ISO8859_2 is not set
>> # CONFIG_NLS_ISO8859_3 is not set
>> # CONFIG_NLS_ISO8859_4 is not set
>> # CONFIG_NLS_ISO8859_5 is not set
>> # CONFIG_NLS_ISO8859_6 is not set
>> # CONFIG_NLS_ISO8859_7 is not set
>> # CONFIG_NLS_ISO8859_9 is not set
>> # CONFIG_NLS_ISO8859_13 is not set
>> # CONFIG_NLS_ISO8859_14 is not set
>> # CONFIG_NLS_ISO8859_15 is not set
>> # CONFIG_NLS_KOI8_R is not set
>> # CONFIG_NLS_KOI8_U is not set
>> # CONFIG_NLS_UTF8 is not set
>>
>> #
>> # Kernel hacking
>> #
>> # CONFIG_PRINTK_TIME is not set
>> CONFIG_DEFAULT_MESSAGE_LOGLEVEL=3D4
>> CONFIG_ENABLE_WARN_DEPRECATED=3Dy
>> CONFIG_ENABLE_MUST_CHECK=3Dy
>> CONFIG_FRAME_WARN=3D1024
>> CONFIG_MAGIC_SYSRQ=3Dy
>> # CONFIG_STRIP_ASM_SYMS is not set
>> # CONFIG_UNUSED_SYMBOLS is not set
>> # CONFIG_DEBUG_FS is not set
>> # CONFIG_HEADERS_CHECK is not set
>> # CONFIG_DEBUG_SECTION_MISMATCH is not set
>> CONFIG_DEBUG_KERNEL=3Dy
>> # CONFIG_DEBUG_SHIRQ is not set
>> # CONFIG_LOCKUP_DETECTOR is not set
>> # CONFIG_HARDLOCKUP_DETECTOR is not set
>> CONFIG_DETECT_HUNG_TASK=3Dy
>> CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=3D120
>> # CONFIG_BOOTPARAM_HUNG_TASK_PANIC is not set
>> CONFIG_BOOTPARAM_HUNG_TASK_PANIC_VALUE=3D0
>> # CONFIG_SCHED_DEBUG is not set
>> # CONFIG_SCHEDSTATS is not set
>> # CONFIG_TIMER_STATS is not set
>> # CONFIG_DEBUG_OBJECTS is not set
>> # CONFIG_DEBUG_SLAB is not set
>> # CONFIG_DEBUG_KMEMLEAK is not set
>> # CONFIG_DEBUG_RT_MUTEXES is not set
>> # CONFIG_RT_MUTEX_TESTER is not set
>> # CONFIG_DEBUG_SPINLOCK is not set
>> CONFIG_DEBUG_MUTEXES=3Dy
>> # CONFIG_DEBUG_LOCK_ALLOC is not set
>> # CONFIG_PROVE_LOCKING is not set
>> # CONFIG_SPARSE_RCU_POINTER is not set
>> # CONFIG_LOCK_STAT is not set
>> # CONFIG_DEBUG_ATOMIC_SLEEP is not set
>> # CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
>> # CONFIG_DEBUG_STACK_USAGE is not set
>> # CONFIG_DEBUG_KOBJECT is not set
>> # CONFIG_DEBUG_BUGVERBOSE is not set
>> CONFIG_DEBUG_INFO=3Dy
>> # CONFIG_DEBUG_INFO_REDUCED is not set
>> # CONFIG_DEBUG_VM is not set
>> # CONFIG_DEBUG_WRITECOUNT is not set
>> # CONFIG_DEBUG_MEMORY_INIT is not set
>> # CONFIG_DEBUG_LIST is not set
>> # CONFIG_TEST_LIST_SORT is not set
>> # CONFIG_DEBUG_SG is not set
>> # CONFIG_DEBUG_NOTIFIERS is not set
>> # CONFIG_DEBUG_CREDENTIALS is not set
>> # CONFIG_BOOT_PRINTK_DELAY is not set
>> # CONFIG_RCU_TORTURE_TEST is not set
>> # CONFIG_BACKTRACE_SELF_TEST is not set
>> # CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
>> # CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
>> # CONFIG_FAULT_INJECTION is not set
>> # CONFIG_LATENCYTOP is not set
>> # CONFIG_SYSCTL_SYSCALL_CHECK is not set
>> # CONFIG_DEBUG_PAGEALLOC is not set
>> CONFIG_HAVE_FUNCTION_TRACER=3Dy
>> CONFIG_HAVE_FUNCTION_GRAPH_TRACER=3Dy
>> CONFIG_HAVE_DYNAMIC_FTRACE=3Dy
>> CONFIG_HAVE_FTRACE_MCOUNT_RECORD=3Dy
>> CONFIG_HAVE_C_RECORDMCOUNT=3Dy
>> CONFIG_TRACING_SUPPORT=3Dy
>> CONFIG_FTRACE=3Dy
>> # CONFIG_FUNCTION_TRACER is not set
>> # CONFIG_IRQSOFF_TRACER is not set
>> # CONFIG_SCHED_TRACER is not set
>> # CONFIG_ENABLE_DEFAULT_TRACERS is not set
>> CONFIG_BRANCH_PROFILE_NONE=3Dy
>> # CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
>> # CONFIG_PROFILE_ALL_BRANCHES is not set
>> # CONFIG_STACK_TRACER is not set
>> # CONFIG_BLK_DEV_IO_TRACE is not set
>> # CONFIG_DMA_API_DEBUG is not set
>> # CONFIG_ATOMIC64_SELFTEST is not set
>> # CONFIG_SAMPLES is not set
>> CONFIG_HAVE_ARCH_KGDB=3Dy
>> # CONFIG_KGDB is not set
>> # CONFIG_TEST_KSTRTOX is not set
>> # CONFIG_STRICT_DEVMEM is not set
>> CONFIG_ARM_UNWIND=3Dy
>> # CONFIG_DEBUG_USER is not set
>> CONFIG_DEBUG_LL=3Dy
>> # CONFIG_EARLY_PRINTK is not set
>> # CONFIG_DEBUG_ICEDCC is not set
>> # CONFIG_OC_ETM is not set
>>
>> #
>> # Security options
>> #
>> CONFIG_KEYS=3Dy
>> # CONFIG_KEYS_DEBUG_PROC_KEYS is not set
>> # CONFIG_SECURITY_DMESG_RESTRICT is not set
>> # CONFIG_SECURITY is not set
>> # CONFIG_SECURITYFS is not set
>> CONFIG_DEFAULT_SECURITY_DAC=3Dy
>> CONFIG_DEFAULT_SECURITY=3D""
>> CONFIG_CRYPTO=3Dy
>>
>> #
>> # Crypto core or helper
>> #
>> CONFIG_CRYPTO_ALGAPI=3Dy
>> CONFIG_CRYPTO_ALGAPI2=3Dy
>> CONFIG_CRYPTO_AEAD2=3Dy
>> CONFIG_CRYPTO_BLKCIPHER=3Dy
>> CONFIG_CRYPTO_BLKCIPHER2=3Dy
>> CONFIG_CRYPTO_HASH=3Dy
>> CONFIG_CRYPTO_HASH2=3Dy
>> CONFIG_CRYPTO_RNG2=3Dy
>> CONFIG_CRYPTO_PCOMP2=3Dy
>> CONFIG_CRYPTO_MANAGER=3Dy
>> CONFIG_CRYPTO_MANAGER2=3Dy
>> CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=3Dy
>> # CONFIG_CRYPTO_GF128MUL is not set
>> # CONFIG_CRYPTO_NULL is not set
>> CONFIG_CRYPTO_WORKQUEUE=3Dy
>> # CONFIG_CRYPTO_CRYPTD is not set
>> # CONFIG_CRYPTO_AUTHENC is not set
>> # CONFIG_CRYPTO_TEST is not set
>>
>> #
>> # Authenticated Encryption with Associated Data
>> #
>> # CONFIG_CRYPTO_CCM is not set
>> # CONFIG_CRYPTO_GCM is not set
>> # CONFIG_CRYPTO_SEQIV is not set
>>
>> #
>> # Block modes
>> #
>> CONFIG_CRYPTO_CBC=3Dy
>> # CONFIG_CRYPTO_CTR is not set
>> # CONFIG_CRYPTO_CTS is not set
>> CONFIG_CRYPTO_ECB=3Dm
>> # CONFIG_CRYPTO_LRW is not set
>> CONFIG_CRYPTO_PCBC=3Dm
>> # CONFIG_CRYPTO_XTS is not set
>>
>> #
>> # Hash modes
>> #
>> # CONFIG_CRYPTO_HMAC is not set
>> # CONFIG_CRYPTO_XCBC is not set
>> # CONFIG_CRYPTO_VMAC is not set
>>
>> #
>> # Digest
>> #
>> CONFIG_CRYPTO_CRC32C=3Dy
>> # CONFIG_CRYPTO_GHASH is not set
>> # CONFIG_CRYPTO_MD4 is not set
>> CONFIG_CRYPTO_MD5=3Dy
>> # CONFIG_CRYPTO_MICHAEL_MIC is not set
>> # CONFIG_CRYPTO_RMD128 is not set
>> # CONFIG_CRYPTO_RMD160 is not set
>> # CONFIG_CRYPTO_RMD256 is not set
>> # CONFIG_CRYPTO_RMD320 is not set
>> # CONFIG_CRYPTO_SHA1 is not set
>> # CONFIG_CRYPTO_SHA256 is not set
>> # CONFIG_CRYPTO_SHA512 is not set
>> # CONFIG_CRYPTO_TGR192 is not set
>> # CONFIG_CRYPTO_WP512 is not set
>>
>> #
>> # Ciphers
>> #
>> # CONFIG_CRYPTO_AES is not set
>> # CONFIG_CRYPTO_ANUBIS is not set
>> # CONFIG_CRYPTO_ARC4 is not set
>> # CONFIG_CRYPTO_BLOWFISH is not set
>> # CONFIG_CRYPTO_CAMELLIA is not set
>> # CONFIG_CRYPTO_CAST5 is not set
>> # CONFIG_CRYPTO_CAST6 is not set
>> CONFIG_CRYPTO_DES=3Dy
>> # CONFIG_CRYPTO_FCRYPT is not set
>> # CONFIG_CRYPTO_KHAZAD is not set
>> # CONFIG_CRYPTO_SALSA20 is not set
>> # CONFIG_CRYPTO_SEED is not set
>> # CONFIG_CRYPTO_SERPENT is not set
>> # CONFIG_CRYPTO_TEA is not set
>> # CONFIG_CRYPTO_TWOFISH is not set
>>
>> #
>> # Compression
>> #
>> # CONFIG_CRYPTO_DEFLATE is not set
>> # CONFIG_CRYPTO_ZLIB is not set
>> # CONFIG_CRYPTO_LZO is not set
>>
>> #
>> # Random Number Generation
>> #
>> # CONFIG_CRYPTO_ANSI_CPRNG is not set
>> # CONFIG_CRYPTO_USER_API_HASH is not set
>> # CONFIG_CRYPTO_USER_API_SKCIPHER is not set
>> CONFIG_CRYPTO_HW=3Dy
>> # CONFIG_CRYPTO_DEV_OMAP_SHAM is not set
>> # CONFIG_CRYPTO_DEV_OMAP_AES is not set
>> # CONFIG_BINARY_PRINTF is not set
>>
>> #
>> # Library routines
>> #
>> CONFIG_BITREVERSE=3Dy
>> CONFIG_CRC_CCITT=3Dy
>> # CONFIG_CRC16 is not set
>> # CONFIG_CRC_T10DIF is not set
>> # CONFIG_CRC_ITU_T is not set
>> CONFIG_CRC32=3Dy
>> # CONFIG_CRC7 is not set
>> CONFIG_LIBCRC32C=3Dy
>> # CONFIG_CRC8 is not set
>> CONFIG_ZLIB_INFLATE=3Dy
>> CONFIG_ZLIB_DEFLATE=3Dy
>> # CONFIG_XZ_DEC is not set
>> # CONFIG_XZ_DEC_BCJ is not set
>> CONFIG_DECOMPRESS_GZIP=3Dy
>> CONFIG_HAS_IOMEM=3Dy
>> CONFIG_HAS_IOPORT=3Dy
>> CONFIG_HAS_DMA=3Dy
>> CONFIG_NLATTR=3Dy
>> # CONFIG_AVERAGE is not set
>> # CONFIG_CORDIC is not set
>>
>>
>> thanks
>> --
>> Christian Gmeiner, MSc
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.h=
tml
>>
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: Yegor Yefremov <yegor_sub1@visionsystems.de>
Subject: Re: Trouble with newer kernels on Gumstix Overo boards
Date: Mon, 20 Jun 2011 15:31:55 +0200
Message-ID: <4DFF4BCB.1000206@visionsystems.de>
References: <BANLkTimJTBpj30EKf_EucvOf2yCHHbRrkQ@mail.gmail.com>	<ADF30F4D7BDE934D9B632CE7D5C7ACA4047B99E7E7AD@dbde03.ent.ti.com>
	<BANLkTimfeS1Xin779eg=8cdjqmqcQeB6HA@mail.gmail.com>
Reply-To: yegor_sub1@visionsystems.de
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <BANLkTimfeS1Xin779eg=8cdjqmqcQeB6HA@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Daniel Mack <zonque@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Gadiyar, Anand" <gadiyar@ti.com>
List-Id: linux-omap@vger.kernel.org

Am 17.06.2011 17:11, schrieb Daniel Mack:
> On Fri, Jun 17, 2011 at 4:03 PM, Gadiyar, Anand <gadiyar@ti.com> wrote:
>>> console=3DttyS2,115200 root=3D/dev/mmcblk0p2 rw rootfstype=3Dext3 rootw=
ait
>>
>> Here is your problem. We now use the OMAP-serial driver for the UARTs.
> =

> Which breaks backward-compatibility with bootloaders set up for older
> kernels. Now I have to deploy kernels with CONFIG_CMDLINE_FORCE=3Dy. Was
> that really necessary?
> =

>> Change the ttyS2 to ttyO2 and you should be fine.
> =

> You're right, that did the trick. Thanks a lot!

Are you using some extra patches? I have a custom board based on am3517 SoC=
 and I have much more errors during booting as I can see from your boot log=
. I have no problems booting 2.6.32/37 though. Any idea?

Linux version 3.0.0-rc3-11085-g0a28368 () (gcc version
 4.5.2 (Buildroot 2011.05-git-00157-gf4c06f4-dirty) ) #25 Mon Jun 20 15:24:=
30 CEST 2011
CPU: ARMv7 Processor [411fc087] revision 7 (ARMv7), cr=3D10c53c7f
CPU: VIPT nonaliasing data cache, VIPT nonaliasing instruction cache
Machine: OMAP3517/AM3517 EVM
Memory policy: ECC disabled, Data cache writeback
AM3517 ES1.1 (l2cache iva sgx neon isp )
SRAM: Mapped pa 0x40200000 to va 0xfe400000 size: 0x10000
Clocking rate (Crystal/Core/MPU): 26.0/332/500 MHz
Reprogramming SDRC clock to 332000000 Hz
dpll3_m2_clk rate change failed: -22
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 65024
Kernel command line: root=3D/dev/nfs nfsroot=3D192.168.1.127:/home/sp860dev=
/Projects/adlink/nfs/ ip=3D192.168.1.235:192.168.1.127:192.168.1.1:255.255.=
255.0::eth0:off
rw console=3DttyO2,115200n8
PID hash table entries: 1024 (order: 0, 4096 bytes)
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Memory: 256MB =3D 256MB total
Memory: 249556k/249556k available, 12588k reserved, 0K highmem
Virtual kernel memory layout:
    vector  : 0xffff0000 - 0xffff1000   (   4 kB)
    fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
    DMA     : 0xffc00000 - 0xffe00000   (   2 MB)
    vmalloc : 0xd0800000 - 0xf8000000   ( 632 MB)
    lowmem  : 0xc0000000 - 0xd0000000   ( 256 MB)
    modules : 0xbf000000 - 0xc0000000   (  16 MB)
      .init : 0xc0008000 - 0xc0033000   ( 172 kB)
      .text : 0xc0033000 - 0xc049c900   (4519 kB)
      .data : 0xc049e000 - 0xc04e3e00   ( 280 kB)
NR_IRQS:410
IRQ: Found an INTC at 0xfa200000 (revision 4.0) with 96 interrupts
Total of 96 interrupts on 1 active controller
OMAP clockevent source: GPTIMER1 at 32768 Hz
sched_clock: 32 bits at 32kHz, resolution 30517ns, wraps every 131071999ms
Console: colour dummy device 80x30
Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
... MAX_LOCKDEP_SUBCLASSES:  8
... MAX_LOCK_DEPTH:          48
... MAX_LOCKDEP_KEYS:        8191
... CLASSHASH_SIZE:          4096
... MAX_LOCKDEP_ENTRIES:     16384
... MAX_LOCKDEP_CHAINS:      32768
... CHAINHASH_SIZE:          16384
 memory used by lock dependency info: 3695 kB
 per task-struct memory footprint: 1152 bytes
Calibrating delay loop... 331.40 BogoMIPS (lpj=3D1296384)
pid_max: default: 32768 minimum: 301
Security Framework initialized
Mount-cache hash table entries: 512
CPU: Testing write buffer coherency: ok
omap_hwmod: _populate_mpu_rt_base found no _mpu_rt_va for l4_core
omap_hwmod: _populate_mpu_rt_base found no _mpu_rt_va for l4_per
omap_hwmod: _populate_mpu_rt_base found no _mpu_rt_va for l4_wkup
omap_hwmod: gpt12_fck: missing clockdomain for gpt12_fck.
omap_hwmod: sr1_hwmod: cannot clk_get main_clk sr1_fck
omap_hwmod: sr1_hwmod: cannot clk_get interface_clk sr_l4_ick
------------[ cut here ]------------
WARNING: at arch/arm/mach-omap2/omap_hwmod.c:1764 omap_hwmod_setup_all+0x60=
/0x98()
omap_hwmod: omap_hwmod_setup_all: _init_clocks failed
[<c0042764>] (unwind_backtrace+0x0/0xe4) from [<c0062c30>] (warn_slowpath_c=
ommon+0x48/0x60)
[<c0062c30>] (warn_slowpath_common+0x48/0x60) from [<c0062c8c>] (warn_slowp=
ath_fmt+0x2c/0x3c)
[<c0062c8c>] (warn_slowpath_fmt+0x2c/0x3c) from [<c00100e0>] (omap_hwmod_se=
tup_all+0x60/0x98)
[<c00100e0>] (omap_hwmod_setup_all+0x60/0x98) from [<c000894c>] (do_one_ini=
tcall+0x9c/0x170)
[<c000894c>] (do_one_initcall+0x9c/0x170) from [<c0008ab0>] (kernel_init+0x=
90/0x13c)
[<c0008ab0>] (kernel_init+0x90/0x13c) from [<c003e1b8>] (kernel_thread_exit=
+0x0/0x8)
---[ end trace 1b75b31a2719ed1c ]---
omap_hwmod: i2c1: softreset failed (waited 10000 usec)
omap_hwmod: i2c2: softreset failed (waited 10000 usec)
omap_hwmod: i2c3: softreset failed (waited 10000 usec)
print_constraints: dummy:
NET: Registered protocol family 16
GPMC revision 5.0
------------[ cut here ]------------
WARNING: at arch/arm/mach-omap2/omap_hwmod.c:1231 _enable+0x38/0x148()
omap_hwmod: gpio1: enabled state can only be entered from initialized, idle=
, or
disabled state
[<c0042764>] (unwind_backtrace+0x0/0xe4) from [<c0062c30>] (warn_slowpath_c=
ommon+0x48/0x60)
[<c0062c30>] (warn_slowpath_common+0x48/0x60) from [<c0062c8c>] (warn_slowp=
ath_fmt+0x2c/0x3c)
[<c0062c8c>] (warn_slowpath_fmt+0x2c/0x3c) from [<c004a8c8>] (_enable+0x38/=
0x148)
[<c004a8c8>] (_enable+0x38/0x148) from [<c004aedc>] (omap_hwmod_enable+0x28=
/0x40)
[<c004aedc>] (omap_hwmod_enable+0x28/0x40) from [<c0056bd4>] (omap_device_e=
nable_hwmods+0x20/0x34)
[<c0056bd4>] (omap_device_enable_hwmods+0x20/0x34) from [<c0056480>] (_omap=
_device_activate+0x6c/0x144)
[<c0056480>] (_omap_device_activate+0x6c/0x144) from [<c00569bc>] (omap_dev=
ice_enable+0x58/0x84)
[<c00569bc>] (omap_device_enable+0x58/0x84) from [<c00569f8>] (_od_runtime_=
resume+0x10/0x1c)
[<c00569f8>] (_od_runtime_resume+0x10/0x1c) from [<c02232c8>] (rpm_callback=
+0x4c/0x64)
[<c02232c8>] (rpm_callback+0x4c/0x64) from [<c0223860>] (rpm_resume+0x304/0=
x410)[<c0223860>] (rpm_resume+0x304/0x410) from [<c022417c>] (__pm_runtime_=
resume+0x48/0x60)
[<c022417c>] (__pm_runtime_resume+0x48/0x60) from [<c039c1fc>] (omap_gpio_p=
robe+0x154/0x308)
[<c039c1fc>] (omap_gpio_probe+0x154/0x308) from [<c0221390>] (platform_drv_=
probe+0x14/0x18)
[<c0221390>] (platform_drv_probe+0x14/0x18) from [<c0220418>] (driver_probe=
_device+0xc8/0x184)
[<c0220418>] (driver_probe_device+0xc8/0x184) from [<c022053c>] (__driver_a=
ttach+0x68/0x8c)
[<c022053c>] (__driver_attach+0x68/0x8c) from [<c021f498>] (bus_for_each_de=
v+0x4c/0x78)
[<c021f498>] (bus_for_each_dev+0x4c/0x78) from [<c021fa08>] (bus_add_driver=
+0x98/0x210)
[<c021fa08>] (bus_add_driver+0x98/0x210) from [<c0220b60>] (driver_register=
+0xa0/0x120)
[<c0220b60>] (driver_register+0xa0/0x120) from [<c000894c>] (do_one_initcal=
l+0x9c/0x170)
[<c000894c>] (do_one_initcall+0x9c/0x170) from [<c0008ab0>] (kernel_init+0x=
90/0x13c)
[<c0008ab0>] (kernel_init+0x90/0x13c) from [<c003e1b8>] (kernel_thread_exit=
+0x0/0x8)
---[ end trace 1b75b31a2719ed1d ]---
omap_device: omap_gpio.0: new worst case activate latency 0: 854492
OMAP GPIO hardware version 2.5
------------[ cut here ]------------
WARNING: at arch/arm/mach-omap2/omap_hwmod.c:1231 _enable+0x38/0x148()
omap_hwmod: gpio2: enabled state can only be entered from initialized, idle=
, or
disabled state
[<c0042764>] (unwind_backtrace+0x0/0xe4) from [<c0062c30>] (warn_slowpath_c=
ommon+0x48/0x60)
[<c0062c30>] (warn_slowpath_common+0x48/0x60) from [<c0062c8c>] (warn_slowp=
ath_fmt+0x2c/0x3c)
[<c0062c8c>] (warn_slowpath_fmt+0x2c/0x3c) from [<c004a8c8>] (_enable+0x38/=
0x148)
[<c004a8c8>] (_enable+0x38/0x148) from [<c004aedc>] (omap_hwmod_enable+0x28=
/0x40)
[<c004aedc>] (omap_hwmod_enable+0x28/0x40) from [<c0056bd4>] (omap_device_e=
nable_hwmods+0x20/0x34)
[<c0056bd4>] (omap_device_enable_hwmods+0x20/0x34) from [<c0056480>] (_omap=
_device_activate+0x6c/0x144)
[<c0056480>] (_omap_device_activate+0x6c/0x144) from [<c00569bc>] (omap_dev=
ice_enable+0x58/0x84)
[<c00569bc>] (omap_device_enable+0x58/0x84) from [<c00569f8>] (_od_runtime_=
resume+0x10/0x1c)
[<c00569f8>] (_od_runtime_resume+0x10/0x1c) from [<c02232c8>] (rpm_callback=
+0x4c/0x64)
[<c02232c8>] (rpm_callback+0x4c/0x64) from [<c0223860>] (rpm_resume+0x304/0=
x410)[<c0223860>] (rpm_resume+0x304/0x410) from [<c022417c>] (__pm_runtime_=
resume+0x48/0x60)
[<c022417c>] (__pm_runtime_resume+0x48/0x60) from [<c039c1fc>] (omap_gpio_p=
robe+0x154/0x308)
[<c039c1fc>] (omap_gpio_probe+0x154/0x308) from [<c0221390>] (platform_drv_=
probe+0x14/0x18)
[<c0221390>] (platform_drv_probe+0x14/0x18) from [<c0220418>] (driver_probe=
_device+0xc8/0x184)
[<c0220418>] (driver_probe_device+0xc8/0x184) from [<c022053c>] (__driver_a=
ttach+0x68/0x8c)
[<c022053c>] (__driver_attach+0x68/0x8c) from [<c021f498>] (bus_for_each_de=
v+0x4c/0x78)
[<c021f498>] (bus_for_each_dev+0x4c/0x78) from [<c021fa08>] (bus_add_driver=
+0x98/0x210)
[<c021fa08>] (bus_add_driver+0x98/0x210) from [<c0220b60>] (driver_register=
+0xa0/0x120)
[<c0220b60>] (driver_register+0xa0/0x120) from [<c000894c>] (do_one_initcal=
l+0x9c/0x170)
[<c000894c>] (do_one_initcall+0x9c/0x170) from [<c0008ab0>] (kernel_init+0x=
90/0x13c)
[<c0008ab0>] (kernel_init+0x90/0x13c) from [<c003e1b8>] (kernel_thread_exit=
+0x0/0x8)
---[ end trace 1b75b31a2719ed1e ]---
OMAP GPIO hardware version 2.5
------------[ cut here ]------------
WARNING: at arch/arm/mach-omap2/omap_hwmod.c:1231 _enable+0x38/0x148()
omap_hwmod: gpio3: enabled state can only be entered from initialized, idle=
, or
disabled state
[<c0042764>] (unwind_backtrace+0x0/0xe4) from [<c0062c30>] (warn_slowpath_c=
ommon+0x48/0x60)
[<c0062c30>] (warn_slowpath_common+0x48/0x60) from [<c0062c8c>] (warn_slowp=
ath_fmt+0x2c/0x3c)
[<c0062c8c>] (warn_slowpath_fmt+0x2c/0x3c) from [<c004a8c8>] (_enable+0x38/=
0x148)
[<c004a8c8>] (_enable+0x38/0x148) from [<c004aedc>] (omap_hwmod_enable+0x28=
/0x40)
[<c004aedc>] (omap_hwmod_enable+0x28/0x40) from [<c0056bd4>] (omap_device_e=
nable_hwmods+0x20/0x34)
[<c0056bd4>] (omap_device_enable_hwmods+0x20/0x34) from [<c0056480>] (_omap=
_device_activate+0x6c/0x144)
[<c0056480>] (_omap_device_activate+0x6c/0x144) from [<c00569bc>] (omap_dev=
ice_enable+0x58/0x84)
[<c00569bc>] (omap_device_enable+0x58/0x84) from [<c00569f8>] (_od_runtime_=
resume+0x10/0x1c)
[<c00569f8>] (_od_runtime_resume+0x10/0x1c) from [<c02232c8>] (rpm_callback=
+0x4c/0x64)
[<c02232c8>] (rpm_callback+0x4c/0x64) from [<c0223860>] (rpm_resume+0x304/0=
x410)[<c0223860>] (rpm_resume+0x304/0x410) from [<c022417c>] (__pm_runtime_=
resume+0x48/0x60)
[<c022417c>] (__pm_runtime_resume+0x48/0x60) from [<c039c1fc>] (omap_gpio_p=
robe+0x154/0x308)
[<c039c1fc>] (omap_gpio_probe+0x154/0x308) from [<c0221390>] (platform_drv_=
probe+0x14/0x18)
[<c0221390>] (platform_drv_probe+0x14/0x18) from [<c0220418>] (driver_probe=
_device+0xc8/0x184)
[<c0220418>] (driver_probe_device+0xc8/0x184) from [<c022053c>] (__driver_a=
ttach+0x68/0x8c)
[<c022053c>] (__driver_attach+0x68/0x8c) from [<c021f498>] (bus_for_each_de=
v+0x4c/0x78)
[<c021f498>] (bus_for_each_dev+0x4c/0x78) from [<c021fa08>] (bus_add_driver=
+0x98/0x210)
[<c021fa08>] (bus_add_driver+0x98/0x210) from [<c0220b60>] (driver_register=
+0xa0/0x120)
[<c0220b60>] (driver_register+0xa0/0x120) from [<c000894c>] (do_one_initcal=
l+0x9c/0x170)
[<c000894c>] (do_one_initcall+0x9c/0x170) from [<c0008ab0>] (kernel_init+0x=
90/0x13c)
[<c0008ab0>] (kernel_init+0x90/0x13c) from [<c003e1b8>] (kernel_thread_exit=
+0x0/0x8)
---[ end trace 1b75b31a2719ed1f ]---
OMAP GPIO hardware version 2.5
------------[ cut here ]------------
WARNING: at arch/arm/mach-omap2/omap_hwmod.c:1231 _enable+0x38/0x148()
omap_hwmod: gpio4: enabled state can only be entered from initialized, idle=
, or
disabled state
[<c0042764>] (unwind_backtrace+0x0/0xe4) from [<c0062c30>] (warn_slowpath_c=
ommon+0x48/0x60)
[<c0062c30>] (warn_slowpath_common+0x48/0x60) from [<c0062c8c>] (warn_slowp=
ath_fmt+0x2c/0x3c)
[<c0062c8c>] (warn_slowpath_fmt+0x2c/0x3c) from [<c004a8c8>] (_enable+0x38/=
0x148)
[<c004a8c8>] (_enable+0x38/0x148) from [<c004aedc>] (omap_hwmod_enable+0x28=
/0x40)
[<c004aedc>] (omap_hwmod_enable+0x28/0x40) from [<c0056bd4>] (omap_device_e=
nable_hwmods+0x20/0x34)
[<c0056bd4>] (omap_device_enable_hwmods+0x20/0x34) from [<c0056480>] (_omap=
_device_activate+0x6c/0x144)
[<c0056480>] (_omap_device_activate+0x6c/0x144) from [<c00569bc>] (omap_dev=
ice_enable+0x58/0x84)
[<c00569bc>] (omap_device_enable+0x58/0x84) from [<c00569f8>] (_od_runtime_=
resume+0x10/0x1c)
[<c00569f8>] (_od_runtime_resume+0x10/0x1c) from [<c02232c8>] (rpm_callback=
+0x4c/0x64)
[<c02232c8>] (rpm_callback+0x4c/0x64) from [<c0223860>] (rpm_resume+0x304/0=
x410)[<c0223860>] (rpm_resume+0x304/0x410) from [<c022417c>] (__pm_runtime_=
resume+0x48/0x60)
[<c022417c>] (__pm_runtime_resume+0x48/0x60) from [<c039c1fc>] (omap_gpio_p=
robe+0x154/0x308)
[<c039c1fc>] (omap_gpio_probe+0x154/0x308) from [<c0221390>] (platform_drv_=
probe+0x14/0x18)
[<c0221390>] (platform_drv_probe+0x14/0x18) from [<c0220418>] (driver_probe=
_device+0xc8/0x184)
[<c0220418>] (driver_probe_device+0xc8/0x184) from [<c022053c>] (__driver_a=
ttach+0x68/0x8c)
[<c022053c>] (__driver_attach+0x68/0x8c) from [<c021f498>] (bus_for_each_de=
v+0x4c/0x78)
[<c021f498>] (bus_for_each_dev+0x4c/0x78) from [<c021fa08>] (bus_add_driver=
+0x98/0x210)
[<c021fa08>] (bus_add_driver+0x98/0x210) from [<c0220b60>] (driver_register=
+0xa0/0x120)
[<c0220b60>] (driver_register+0xa0/0x120) from [<c000894c>] (do_one_initcal=
l+0x9c/0x170)
[<c000894c>] (do_one_initcall+0x9c/0x170) from [<c0008ab0>] (kernel_init+0x=
90/0x13c)
[<c0008ab0>] (kernel_init+0x90/0x13c) from [<c003e1b8>] (kernel_thread_exit=
+0x0/0x8)
---[ end trace 1b75b31a2719ed20 ]---
OMAP GPIO hardware version 2.5
------------[ cut here ]------------
WARNING: at arch/arm/mach-omap2/omap_hwmod.c:1231 _enable+0x38/0x148()
omap_hwmod: gpio5: enabled state can only be entered from initialized, idle=
, or
disabled state
[<c0042764>] (unwind_backtrace+0x0/0xe4) from [<c0062c30>] (warn_slowpath_c=
ommon+0x48/0x60)
[<c0062c30>] (warn_slowpath_common+0x48/0x60) from [<c0062c8c>] (warn_slowp=
ath_fmt+0x2c/0x3c)
[<c0062c8c>] (warn_slowpath_fmt+0x2c/0x3c) from [<c004a8c8>] (_enable+0x38/=
0x148)
[<c004a8c8>] (_enable+0x38/0x148) from [<c004aedc>] (omap_hwmod_enable+0x28=
/0x40)
[<c004aedc>] (omap_hwmod_enable+0x28/0x40) from [<c0056bd4>] (omap_device_e=
nable_hwmods+0x20/0x34)
[<c0056bd4>] (omap_device_enable_hwmods+0x20/0x34) from [<c0056480>] (_omap=
_device_activate+0x6c/0x144)
[<c0056480>] (_omap_device_activate+0x6c/0x144) from [<c00569bc>] (omap_dev=
ice_enable+0x58/0x84)
[<c00569bc>] (omap_device_enable+0x58/0x84) from [<c00569f8>] (_od_runtime_=
resume+0x10/0x1c)
[<c00569f8>] (_od_runtime_resume+0x10/0x1c) from [<c02232c8>] (rpm_callback=
+0x4c/0x64)
[<c02232c8>] (rpm_callback+0x4c/0x64) from [<c0223860>] (rpm_resume+0x304/0=
x410)[<c0223860>] (rpm_resume+0x304/0x410) from [<c022417c>] (__pm_runtime_=
resume+0x48/0x60)
[<c022417c>] (__pm_runtime_resume+0x48/0x60) from [<c039c1fc>] (omap_gpio_p=
robe+0x154/0x308)
[<c039c1fc>] (omap_gpio_probe+0x154/0x308) from [<c0221390>] (platform_drv_=
probe+0x14/0x18)
[<c0221390>] (platform_drv_probe+0x14/0x18) from [<c0220418>] (driver_probe=
_device+0xc8/0x184)
[<c0220418>] (driver_probe_device+0xc8/0x184) from [<c022053c>] (__driver_a=
ttach+0x68/0x8c)
[<c022053c>] (__driver_attach+0x68/0x8c) from [<c021f498>] (bus_for_each_de=
v+0x4c/0x78)
[<c021f498>] (bus_for_each_dev+0x4c/0x78) from [<c021fa08>] (bus_add_driver=
+0x98/0x210)
[<c021fa08>] (bus_add_driver+0x98/0x210) from [<c0220b60>] (driver_register=
+0xa0/0x120)
[<c0220b60>] (driver_register+0xa0/0x120) from [<c000894c>] (do_one_initcal=
l+0x9c/0x170)
[<c000894c>] (do_one_initcall+0x9c/0x170) from [<c0008ab0>] (kernel_init+0x=
90/0x13c)
[<c0008ab0>] (kernel_init+0x90/0x13c) from [<c003e1b8>] (kernel_thread_exit=
+0x0/0x8)
---[ end trace 1b75b31a2719ed21 ]---
OMAP GPIO hardware version 2.5
------------[ cut here ]------------
WARNING: at arch/arm/mach-omap2/omap_hwmod.c:1231 _enable+0x38/0x148()
omap_hwmod: gpio6: enabled state can only be entered from initialized, idle=
, or
disabled state
[<c0042764>] (unwind_backtrace+0x0/0xe4) from [<c0062c30>] (warn_slowpath_c=
ommon+0x48/0x60)
[<c0062c30>] (warn_slowpath_common+0x48/0x60) from [<c0062c8c>] (warn_slowp=
ath_fmt+0x2c/0x3c)
[<c0062c8c>] (warn_slowpath_fmt+0x2c/0x3c) from [<c004a8c8>] (_enable+0x38/=
0x148)
[<c004a8c8>] (_enable+0x38/0x148) from [<c004aedc>] (omap_hwmod_enable+0x28=
/0x40)
[<c004aedc>] (omap_hwmod_enable+0x28/0x40) from [<c0056bd4>] (omap_device_e=
nable_hwmods+0x20/0x34)
[<c0056bd4>] (omap_device_enable_hwmods+0x20/0x34) from [<c0056480>] (_omap=
_device_activate+0x6c/0x144)
[<c0056480>] (_omap_device_activate+0x6c/0x144) from [<c00569bc>] (omap_dev=
ice_enable+0x58/0x84)
[<c00569bc>] (omap_device_enable+0x58/0x84) from [<c00569f8>] (_od_runtime_=
resume+0x10/0x1c)
[<c00569f8>] (_od_runtime_resume+0x10/0x1c) from [<c02232c8>] (rpm_callback=
+0x4c/0x64)
[<c02232c8>] (rpm_callback+0x4c/0x64) from [<c0223860>] (rpm_resume+0x304/0=
x410)[<c0223860>] (rpm_resume+0x304/0x410) from [<c022417c>] (__pm_runtime_=
resume+0x48/0x60)
[<c022417c>] (__pm_runtime_resume+0x48/0x60) from [<c039c1fc>] (omap_gpio_p=
robe+0x154/0x308)
[<c039c1fc>] (omap_gpio_probe+0x154/0x308) from [<c0221390>] (platform_drv_=
probe+0x14/0x18)
[<c0221390>] (platform_drv_probe+0x14/0x18) from [<c0220418>] (driver_probe=
_device+0xc8/0x184)
[<c0220418>] (driver_probe_device+0xc8/0x184) from [<c022053c>] (__driver_a=
ttach+0x68/0x8c)
[<c022053c>] (__driver_attach+0x68/0x8c) from [<c021f498>] (bus_for_each_de=
v+0x4c/0x78)
[<c021f498>] (bus_for_each_dev+0x4c/0x78) from [<c021fa08>] (bus_add_driver=
+0x98/0x210)
[<c021fa08>] (bus_add_driver+0x98/0x210) from [<c0220b60>] (driver_register=
+0xa0/0x120)
[<c0220b60>] (driver_register+0xa0/0x120) from [<c000894c>] (do_one_initcal=
l+0x9c/0x170)
[<c000894c>] (do_one_initcall+0x9c/0x170) from [<c0008ab0>] (kernel_init+0x=
90/0x13c)
[<c0008ab0>] (kernel_init+0x90/0x13c) from [<c003e1b8>] (kernel_thread_exit=
+0x0/0x8)
---[ end trace 1b75b31a2719ed22 ]---
OMAP GPIO hardware version 2.5
omap_mux_init: Add partition: #1: core, flags: 0
omap_device: omap_uart.0: new worst case activate latency 0: 30517
omap_device: omap_uart.0: new worst case deactivate latency 0: 30517
hw-breakpoint: debug architecture 0x4 unsupported.
OMAP DMA hardware revision 4.0
bio: create slab <bio-0> at 0
SCSI subsystem initialized
omap_device: omap_i2c.1: new worst case activate latency 0: 30517
omap_i2c omap_i2c.1: bus 1 rev3.12 at 400 kHz
omap_i2c omap_i2c.2: bus 2 rev3.12 at 400 kHz
omap_device: omap_i2c.2: new worst case deactivate latency 0: 30517
omap_i2c omap_i2c.3: bus 3 rev3.12 at 400 kHz
Bluetooth: Core ver 2.16
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
cfg80211: Calling CRDA to update world regulatory domain
Switching to clocksource 32k_counter
Switched to NOHz mode on CPU #0
NET: Registered protocol family 2
IP route cache hash table entries: 2048 (order: 1, 8192 bytes)
TCP established hash table entries: 8192 (order: 4, 65536 bytes)
TCP bind hash table entries: 8192 (order: 6, 294912 bytes)
TCP: Hash tables configured (established 8192 bind 8192)
TCP reno registered
UDP hash table entries: 128 (order: 1, 10240 bytes)
UDP-Lite hash table entries: 128 (order: 1, 10240 bytes)
NET: Registered protocol family 1
RPC: Registered named UNIX socket transport module.
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
RPC: Registered tcp NFSv4.1 backchannel transport module.
NetWinder Floating Point Emulator V0.97 (double precision)
VFS: Disk quotas dquot_6.5.2
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
JFFS2 version 2.2. (NAND) (SUMMARY)  -=AC 2001-2006 Red Hat, Inc.
msgmni has been set to 487
io scheduler noop registered
io scheduler deadline registered
io scheduler cfq registered (default)
Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
omap_uart.0: ttyO0 at MMIO 0x4806a000 (irq =3D 72) is a OMAP UART0
omap_uart.1: ttyO1 at MMIO 0x4806c000 (irq =3D 73) is a OMAP UART1
omap_uart.2: ttyO2 at MMIO 0x49020000 (irq =3D 74) is a OMAP UART2
console [ttyO2] enabled
brd: module loaded
loop: module loaded
mtdoops: mtd device (mtddev=3Dname/number) must be supplied
omap2-nand driver initializing
OneNAND driver initializing
libertas_sdio: Libertas SDIO driver
libertas_sdio: Copyright Pierre Ossman
mousedev: PS/2 mouse device common for all mice
i2c /dev entries driver
Driver for 1-wire Dallas network protocol.
omap_device: omap_wdt.-1: new worst case activate latency 0: 30517
OMAP Watchdog Timer Rev 0x31: initial timeout 60 sec
omap_device: omap_wdt.-1: new worst case deactivate latency 0: 30517
Bluetooth: HCI UART driver ver 2.2
Bluetooth: HCI H4 protocol initialized
Bluetooth: HCI BCSP protocol initialized
Bluetooth: HCILL protocol initialized
oprofile: hardware counters not available
oprofile: using timer interrupt.
TCP cubic registered
Initializing XFRM netlink socket
NET: Registered protocol family 17
NET: Registered protocol family 15
lib80211: common routines for IEEE802.11 drivers
Registering the dns_resolver key type
VFP support v0.3: implementor 41 architecture 3 part 30 variant c rev 1
ThumbEE CPU extension supported.
Unable to handle kernel NULL pointer dereference at virtual address 0000002a
pgd =3D c0004000
[0000002a] *pgd=3D00000000
Internal error: Oops: 5 [#1]
CPU: 0    Tainted: G        W    (3.0.0-rc3-11085-g0a28368 #25)
PC is at twl_i2c_read+0x34/0x134
LR is at omap3_twl_set_sr_bit+0x34/0x9c
pc : [<c0228f4c>]    lr : [<c00103ec>]    psr: 80000013
sp : cf82df60  ip : 00000015  fp : 00000000
r10: 00000001  r9 : 0000002a  r8 : 00000000
r7 : c0a036ec  r6 : 00000006  r5 : 00000001  r4 : cf82df97
r3 : 00000000  r2 : 00000006  r1 : cf82df97  r0 : 00000015
Flags: Nzcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
Control: 10c5387d  Table: 80004019  DAC: 00000015
Process swapper (pid: 1, stack limit =3D 0xcf82c2f0)
Stack: (0xcf82df60 to 0xcf82e000)
df60: 00000015 cf82df97 00000006 c00295b0 00000001 c003e1b8 c000fa60 000000=
00
df80: 00000000 00000000 00000000 c00103ec 00000001 c03a5fd0 00000000 c00295=
b0
dfa0: c0029600 c00104a0 cf82c000 c000fa68 c00295b0 c000894c 00000000 c00300=
00
dfc0: 00000013 00000199 c04c4b20 c00295b0 c0029600 c003e1b8 00000013 000000=
00
dfe0: 00000000 c0008ab0 00000004 00000000 c0008a20 c003e1b8 20000193 ffffff=
ff
[<c0228f4c>] (twl_i2c_read+0x34/0x134) from [<c00103ec>] (omap3_twl_set_sr_=
bit+0x34/0x9c)
[<c00103ec>] (omap3_twl_set_sr_bit+0x34/0x9c) from [<c00104a0>] (omap3_twl_=
init+0x4c/0x88)
[<c00104a0>] (omap3_twl_init+0x4c/0x88) from [<c000fa68>] (omap2_common_pm_=
late_init+0x8/0x54)
[<c000fa68>] (omap2_common_pm_late_init+0x8/0x54) from [<c000894c>] (do_one=
_initcall+0x9c/0x170)
[<c000894c>] (do_one_initcall+0x9c/0x170) from [<c0008ab0>] (kernel_init+0x=
90/0x13c)
[<c0008ab0>] (kernel_init+0x90/0x13c) from [<c003e1b8>] (kernel_thread_exit=
+0x0/0x8)
Code: 8a000008 e59f70f8 e1a09080 e59731a8 (e7d32080)
---[ end trace 1b75b31a2719ed23 ]---
Kernel panic - not syncing: Attempted to kill init!

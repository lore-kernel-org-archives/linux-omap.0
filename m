From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: Re: GPIO abort on 3630/Zoom3
Date: Thu, 15 Mar 2012 08:43:54 +0530
Message-ID: <CAC83ZvLMWxxr7QSca0a9+wJR_gJ6-s6ddfUQdVqQ-XbWSoNa+w@mail.gmail.com>
References: <87d38eet48.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog122.obsmtp.com ([74.125.149.147]:46944 "EHLO
	na3sys009aog122.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754421Ab2CODN4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 14 Mar 2012 23:13:56 -0400
Received: by mail-yw0-f46.google.com with SMTP id m54so3167888yhm.5
        for <linux-omap@vger.kernel.org>; Wed, 14 Mar 2012 20:13:55 -0700 (PDT)
In-Reply-To: <87d38eet48.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-omap <linux-omap@vger.kernel.org>

On Thu, Mar 15, 2012 at 3:35 AM, Kevin Hilman <khilman@ti.com> wrote:
> Tarun,
>
> Can you investigate an abort during boot on 3630/Zoom3?
>
> Both Tony and I are seeing the abort below on 3630/Zoom3. =A0I'm usin=
g
> arm-soc/for-next and Tony is using linux-next, but we see the same ab=
ort.
The crash looks very similar to what we fixed yesterday. The problem wa=
s
basically due to usage of OMAP_GPIO_IRQ macro instead of gpio_to_irq()
which came as part of Benoit's dynamic irq allocation change. The fix i=
s to
replace those macros in the board files.
(The same problem is seen on OMAP3430 SDP as well.)
Anyways, I will confirm.

>
> Adding in your latest fixes series doesn't make the problem go away, =
but
> backing out the GPIO runtime PM series does make the problem go away.
Because of dynamic irq allocation we end up into wrong GPIO Bank unless
we use the new gpio_to_irq(). As a result _set_gpio_triggering() tries
to operate
on a GPIO Bank whose clock was not turned on using omap_gpio_request().
Probably, that is why we do not see the problem when the runtime PM ser=
ies
is removed because in this case all the GPIO banks are turned on.
--
Tarun

>
> Kevin
>
>
> Uncompressing Linux... done, booting the kernel.
> [ =A0 =A00.000000] Booting Linux on physical CPU 0
> [ =A0 =A00.000000] Linux version 3.3.0-rc7-pm+debug+initramfs-01079-g=
405139c (khilman@paris) (gcc version 4.6.1 (Ubuntu/Linaro 4.6.1-9ubuntu=
3) ) #15 SMP Wed Mar 14 13:06:34 PDT 2012
> [ =A0 =A00.000000] CPU: ARMv7 Processor [413fc082] revision 2 (ARMv7)=
, cr=3D10c53c7d
> [ =A0 =A00.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT alia=
sing instruction cache
> [ =A0 =A00.000000] Machine: OMAP Zoom3 board
> [ =A0 =A00.000000] bootconsole [earlycon0] enabled
> [ =A0 =A00.000000] Memory policy: ECC disabled, Data cache writeback
> [ =A0 =A00.000000] On node 0 totalpages: 32512
> [ =A0 =A00.000000] free_area_init_node: node 0, pgdat c094f580, node_=
mem_map c0ea7000
> [ =A0 =A00.000000] =A0 Normal zone: 256 pages used for memmap
> [ =A0 =A00.000000] =A0 Normal zone: 0 pages reserved
> [ =A0 =A00.000000] =A0 Normal zone: 32256 pages, LIFO batch:7
> [ =A0 =A00.000000] OMAP3630 ES1.0 (l2cache iva sgx neon isp 192mhz_cl=
k )
> [ =A0 =A00.000000] Clocking rate (Crystal/Core/MPU): 26.0/400/600 MHz
> [ =A0 =A00.000000] PERCPU: Embedded 9 pages/cpu @c0fab000 s12864 r819=
2 d15808 u36864
> [ =A0 =A00.000000] pcpu-alloc: s12864 r8192 d15808 u36864 alloc=3D9*4=
096
> [ =A0 =A00.000000] pcpu-alloc: [0] 0
> [ =A0 =A00.000000] Built 1 zonelists in Zone order, mobility grouping=
 on. =A0Total pages: 32256
> [ =A0 =A00.000000] Kernel command line: mem=3D128M console=3DttyS0,11=
5200n8 ip=3Ddhcp debug earlyprintk user_debug=3D0xffff
> [ =A0 =A00.000000] PID hash table entries: 512 (order: -1, 2048 bytes=
)
> [ =A0 =A00.000000] Dentry cache hash table entries: 16384 (order: 4, =
65536 bytes)
> [ =A0 =A00.000000] Inode-cache hash table entries: 8192 (order: 3, 32=
768 bytes)
> [ =A0 =A00.000000] Memory: 127MB =3D 127MB total
> [ =A0 =A00.000000] Memory: 113868k/113868k available, 17204k reserved=
, 0K highmem
> [ =A0 =A00.000000] Virtual kernel memory layout:
> [ =A0 =A00.000000] =A0 =A0 vector =A0: 0xffff0000 - 0xffff1000 =A0 ( =
=A0 4 kB)
> [ =A0 =A00.000000] =A0 =A0 fixmap =A0: 0xfff00000 - 0xfffe0000 =A0 ( =
896 kB)
> [ =A0 =A00.000000] =A0 =A0 vmalloc : 0xc8800000 - 0xff000000 =A0 ( 87=
2 MB)
> [ =A0 =A00.000000] =A0 =A0 lowmem =A0: 0xc0000000 - 0xc8000000 =A0 ( =
128 MB)
> [ =A0 =A00.000000] =A0 =A0 modules : 0xbf000000 - 0xc0000000 =A0 ( =A0=
16 MB)
> [ =A0 =A00.000000] =A0 =A0 =A0 .text : 0xc0008000 - 0xc0605560 =A0 (6=
134 kB)
> [ =A0 =A00.000000] =A0 =A0 =A0 .init : 0xc0606000 - 0xc08c2240 =A0 (2=
801 kB)
> [ =A0 =A00.000000] =A0 =A0 =A0 .data : 0xc08c4000 - 0xc0950ff0 =A0 ( =
564 kB)
> [ =A0 =A00.000000] =A0 =A0 =A0 =A0.bss : 0xc0951014 - 0xc0ea6c9c =A0 =
(5464 kB)
> [ =A0 =A00.000000] Hierarchical RCU implementation.
> [ =A0 =A00.000000] NR_IRQS:474
> [ =A0 =A00.000000] IRQ: Found an INTC at 0xfa200000 (revision 4.0) wi=
th 96 interrupts
> [ =A0 =A00.000000] Total of 96 interrupts on 1 active controller
> [ =A0 =A00.000000] OMAP clockevent source: GPTIMER1 at 32768 Hz
> [ =A0 =A00.000000] sched_clock: 32 bits at 32kHz, resolution 30517ns,=
 wraps every 131071999ms
> [ =A0 =A00.000000] Console: colour dummy device 80x30
> [ =A0 =A00.000000] Lock dependency validator: Copyright (c) 2006 Red =
Hat, Inc., Ingo Molnar
> [ =A0 =A00.000000] ... MAX_LOCKDEP_SUBCLASSES: =A08
> [ =A0 =A00.000000] ... MAX_LOCK_DEPTH: =A0 =A0 =A0 =A0 =A048
> [ =A0 =A00.000000] ... MAX_LOCKDEP_KEYS: =A0 =A0 =A0 =A08191
> [ =A0 =A00.000000] ... CLASSHASH_SIZE: =A0 =A0 =A0 =A0 =A04096
> [ =A0 =A00.000000] ... MAX_LOCKDEP_ENTRIES: =A0 =A0 16384
> [ =A0 =A00.000000] ... MAX_LOCKDEP_CHAINS: =A0 =A0 =A032768
> [ =A0 =A00.000000] ... CHAINHASH_SIZE: =A0 =A0 =A0 =A0 =A016384
> [ =A0 =A00.000000] =A0memory used by lock dependency info: 3695 kB
> [ =A0 =A00.000000] =A0per task-struct memory footprint: 1152 bytes
> [ =A0 =A00.056732] Calibrating delay loop... 597.64 BogoMIPS (lpj=3D2=
334720)
> [ =A0 =A00.098571] pid_max: default: 32768 minimum: 301
> [ =A0 =A00.104125] Security Framework initialized
> [ =A0 =A00.108673] Mount-cache hash table entries: 512
> [ =A0 =A00.118377] CPU: Testing write buffer coherency: ok
> [ =A0 =A00.124389] CPU0: thread -1, cpu 0, socket -1, mpidr 0
> [ =A0 =A00.129852] Setting up static identity map for 0x8043ac18 - 0x=
8043ac88
> [ =A0 =A00.138244] Brought up 1 CPUs
> [ =A0 =A00.141387] SMP: Total of 1 processors activated (597.64 BogoM=
IPS).
> [ =A0 =A00.170501] print_constraints: dummy:
> [ =A0 =A00.176666] NET: Registered protocol family 16
> [ =A0 =A00.182525] GPMC revision 5.0
> [ =A0 =A00.196075] gpiochip_add: registered GPIOs 0 to 31 on device: =
gpio
> [ =A0 =A00.203277] OMAP GPIO hardware version 2.5
> [ =A0 =A00.208831] gpiochip_add: registered GPIOs 32 to 63 on device:=
 gpio
> [ =A0 =A00.217071] gpiochip_add: registered GPIOs 64 to 95 on device:=
 gpio
> [ =A0 =A00.225128] gpiochip_add: registered GPIOs 96 to 127 on device=
: gpio
> [ =A0 =A00.233367] gpiochip_add: registered GPIOs 128 to 159 on devic=
e: gpio
> [ =A0 =A00.241546] gpiochip_add: registered GPIOs 160 to 191 on devic=
e: gpio
> [ =A0 =A00.254821] omap_mux_init: Add partition: #1: core, flags: 0
> [ =A0 =A00.267486] error setting wl12xx data: -38
> [ =A0 =A00.283905] Reprogramming SDRC clock to 400000000 Hz
> [ =A0 =A00.294250] hw-breakpoint: debug architecture 0x4 unsupported.
> [ =A0 =A00.319091] =A0omap-mcbsp.2: alias fck already exists
> [ =A0 =A00.325347] =A0omap-mcbsp.3: alias fck already exists
> [ =A0 =A00.336669] OMAP DMA hardware revision 5.0
> [ =A0 =A00.403747] bio: create slab <bio-0> at 0
> [ =A0 =A00.412170] print_constraints: gpmc_smsc911x: 3300 mV normal s=
tandby
> [ =A0 =A00.420104] print_constraints: vwl1271: 1800 mV
> [ =A0 =A00.430725] SCSI subsystem initialized
> [ =A0 =A00.445831] usbcore: registered new interface driver usbfs
> [ =A0 =A00.452697] usbcore: registered new interface driver hub
> [ =A0 =A00.459350] usbcore: registered new device driver usb
> [ =A0 =A00.479003] omap_i2c omap_i2c.1: bus 1 rev1.4.0 at 2400 kHz
> [ =A0 =A00.495117] twl4030: PIH (irq 7) chaining IRQs 368..401
> [ =A0 =A00.501190] twl4030: power (irq 373) chaining IRQs 402..409
> [ =A0 =A00.509429] twl4030: gpio (irq 368) chaining IRQs 410..427
> [ =A0 =A00.515319] ------------[ cut here ]------------
> [ =A0 =A00.520202] WARNING: at /work/kernel/omap/pm/drivers/gpio/gpio=
-twl4030.c:410 gpio_twl4030_probe+0x44/0x214()
> [ =A0 =A00.530395] Modules linked in:
> [ =A0 =A00.533691] [<c0014248>] (unwind_backtrace+0x0/0xf0) from [<c0=
039054>] (warn_slowpath_common+0x4c/0x64)
> [ =A0 =A00.543640] [<c0039054>] (warn_slowpath_common+0x4c/0x64) from=
 [<c0039088>] (warn_slowpath_null+0x1c/0x24)
> [ =A0 =A00.553680] [<c0039088>] (warn_slowpath_null+0x1c/0x24) from [=
<c04196f4>] (gpio_twl4030_probe+0x44/0x214)
> [ =A0 =A00.563629] [<c04196f4>] (gpio_twl4030_probe+0x44/0x214) from =
[<c028832c>] (platform_drv_probe+0x18/0x1c)
> [ =A0 =A00.573577] [<c028832c>] (platform_drv_probe+0x18/0x1c) from [=
<c0286fd4>] (really_probe+0x60/0x15c)
> [ =A0 =A00.583007] [<c0286fd4>] (really_probe+0x60/0x15c) from [<c028=
7214>] (driver_probe_device+0x48/0x60)
> [ =A0 =A00.592498] [<c0287214>] (driver_probe_device+0x48/0x60) from =
[<c0285af8>] (bus_for_each_drv+0x5c/0x88)
> [ =A0 =A00.602264] [<c0285af8>] (bus_for_each_drv+0x5c/0x88) from [<c=
028718c>] (device_attach+0x98/0xbc)
> [ =A0 =A00.611480] [<c028718c>] (device_attach+0x98/0xbc) from [<c028=
6844>] (bus_probe_device+0x88/0xac)
> [ =A0 =A00.620727] [<c0286844>] (bus_probe_device+0x88/0xac) from [<c=
0285160>] (device_add+0x278/0x358)
> [ =A0 =A00.629882] [<c0285160>] (device_add+0x278/0x358) from [<c0288=
7a8>] (platform_device_add+0xf8/0x1a4)
> [ =A0 =A00.639373] [<c02887a8>] (platform_device_add+0xf8/0x1a4) from=
 [<c042e4a0>] (add_numbered_child.constprop.0+0xb8/0xfc)
> [ =A0 =A00.650451] [<c042e4a0>] (add_numbered_child.constprop.0+0xb8/=
0xfc) from [<c042e5a4>] (add_children+0x44/0x6d0)
> [ =A0 =A00.660949] [<c042e5a4>] (add_children+0x44/0x6d0) from [<c041=
a8b8>] (twl_probe+0x354/0x3bc)
> [ =A0 =A00.669738] [<c041a8b8>] (twl_probe+0x354/0x3bc) from [<c0326c=
b0>] (i2c_device_probe+0xc0/0x100)
> [ =A0 =A00.678863] [<c0326cb0>] (i2c_device_probe+0xc0/0x100) from [<=
c0286fd4>] (really_probe+0x60/0x15c)
> [ =A0 =A00.688171] [<c0286fd4>] (really_probe+0x60/0x15c) from [<c028=
7214>] (driver_probe_device+0x48/0x60)
> [ =A0 =A00.697692] [<c0287214>] (driver_probe_device+0x48/0x60) from =
[<c0285af8>] (bus_for_each_drv+0x5c/0x88)
> [ =A0 =A00.707458] [<c0285af8>] (bus_for_each_drv+0x5c/0x88) from [<c=
028718c>] (device_attach+0x98/0xbc)
> [ =A0 =A00.716674] [<c028718c>] (device_attach+0x98/0xbc) from [<c028=
6844>] (bus_probe_device+0x88/0xac)
> [ =A0 =A00.725921] [<c0286844>] (bus_probe_device+0x88/0xac) from [<c=
0285160>] (device_add+0x278/0x358)
> [ =A0 =A00.735076] [<c0285160>] (device_add+0x278/0x358) from [<c0327=
410>] (i2c_new_device+0xec/0x160)
> [ =A0 =A00.744354] [<c0327410>] (i2c_new_device+0xec/0x160) from [<c0=
32781c>] (i2c_register_adapter+0x168/0x220)
> [ =A0 =A00.754302] [<c032781c>] (i2c_register_adapter+0x168/0x220) fr=
om [<c0327a40>] (i2c_add_numbered_adapter+0xd4/0xf0)
> [ =A0 =A00.765045] [<c0327a40>] (i2c_add_numbered_adapter+0xd4/0xf0) =
from [<c041f4c8>] (omap_i2c_probe+0x334/0x424)
> [ =A0 =A00.775268] [<c041f4c8>] (omap_i2c_probe+0x334/0x424) from [<c=
028832c>] (platform_drv_probe+0x18/0x1c)
> [ =A0 =A00.784942] [<c028832c>] (platform_drv_probe+0x18/0x1c) from [=
<c0286fd4>] (really_probe+0x60/0x15c)
> [ =A0 =A00.794342] [<c0286fd4>] (really_probe+0x60/0x15c) from [<c028=
7214>] (driver_probe_device+0x48/0x60)
> [ =A0 =A00.803863] [<c0287214>] (driver_probe_device+0x48/0x60) from =
[<c02872c0>] (__driver_attach+0x94/0x98)
> [ =A0 =A00.813537] [<c02872c0>] (__driver_attach+0x94/0x98) from [<c0=
285b74>] (bus_for_each_dev+0x50/0x7c)
> [ =A0 =A00.822937] [<c0285b74>] (bus_for_each_dev+0x50/0x7c) from [<c=
0286ad4>] (bus_add_driver+0x184/0x248)
> [ =A0 =A00.832427] [<c0286ad4>] (bus_add_driver+0x184/0x248) from [<c=
0287798>] (driver_register+0x78/0x12c)
> [ =A0 =A00.841949] [<c0287798>] (driver_register+0x78/0x12c) from [<c=
0008800>] (do_one_initcall+0x34/0x178)
> [ =A0 =A00.851440] [<c0008800>] (do_one_initcall+0x34/0x178) from [<c=
06068ac>] (kernel_init+0x8c/0x130)
> [ =A0 =A00.860565] [<c06068ac>] (kernel_init+0x8c/0x130) from [<c000e=
850>] (kernel_thread_exit+0x0/0x8)
> [ =A0 =A00.870117] ---[ end trace 1b75b31a2719ed1c ]---
> [ =A0 =A00.876403] gpiochip_add: registered GPIOs 192 to 209 on devic=
e: twl4030
> [ =A0 =A00.891571] print_constraints: vdd_mpu_iva: 600 <--> 1450 mV n=
ormal
> [ =A0 =A00.900726] print_constraints: vdd_core: 600 <--> 1450 mV norm=
al
> [ =A0 =A00.909454] print_constraints: VMMC1: 1850 <--> 3150 mV at 300=
0 mV normal standby
> [ =A0 =A00.919616] print_constraints: VDAC: 1800 mV normal standby
> [ =A0 =A00.927642] print_constraints: VPLL2: 1800 mV normal standby
> [ =A0 =A00.936065] print_constraints: VMMC2: 1850 mV normal standby
> [ =A0 =A00.944305] print_constraints: VSIM: 1800 <--> 3000 mV at 1800=
 mV normal standby
> [ =A0 =A00.963043] omap_i2c omap_i2c.2: bus 2 rev1.4.0 at 400 kHz
> [ =A0 =A00.978668] omap_i2c omap_i2c.3: bus 3 rev1.4.0 at 400 kHz
> [ =A0 =A00.992675] Switching to clocksource 32k_counter
> [ =A0 =A01.111755] NET: Registered protocol family 2
> [ =A0 =A01.117462] IP route cache hash table entries: 1024 (order: 0,=
 4096 bytes)
> [ =A0 =A01.126464] TCP established hash table entries: 4096 (order: 3=
, 32768 bytes)
> [ =A0 =A01.134155] TCP bind hash table entries: 4096 (order: 5, 14745=
6 bytes)
> [ =A0 =A01.143310] TCP: Hash tables configured (established 4096 bind=
 4096)
> [ =A0 =A01.150024] TCP reno registered
> [ =A0 =A01.153350] UDP hash table entries: 64 (order: 0, 5120 bytes)
> [ =A0 =A01.159698] UDP-Lite hash table entries: 64 (order: 0, 5120 by=
tes)
> [ =A0 =A01.167083] NET: Registered protocol family 1
> [ =A0 =A01.173034] RPC: Registered named UNIX socket transport module=
=2E
> [ =A0 =A01.179504] RPC: Registered udp transport module.
> [ =A0 =A01.184417] RPC: Registered tcp transport module.
> [ =A0 =A01.189392] RPC: Registered tcp NFSv4.1 backchannel transport =
module.
> [ =A0 =A01.438323] VFS: Disk quotas dquot_6.5.2
> [ =A0 =A01.442779] Dquot-cache hash table entries: 1024 (order 0, 409=
6 bytes)
> [ =A0 =A01.452575] JFFS2 version 2.2. (NAND) (SUMMARY) =A0=C2=A9 2001=
-2006 Red Hat, Inc.
> [ =A0 =A01.461120] msgmni has been set to 222
> [ =A0 =A01.468536] io scheduler noop registered
> [ =A0 =A01.472656] io scheduler deadline registered
> [ =A0 =A01.477447] io scheduler cfq registered (default)
> [ =A0 =A01.485046] Serial: 8250/16550 driver, 4 ports, IRQ sharing en=
abled
> [ =A0 =A01.522857] serial8250.0: ttyS0 at MMIO 0x10000000 (irq =3D 26=
2) is a ST16654
> [ =A0 =A01.530426] console [ttyS0] enabled, bootconsole disabled
> [ =A0 =A01.530426] console [ttyS0] enabled, bootconsole disabled
> [ =A0 =A01.544494] omap_uart.0: ttyO0 at MMIO 0x4806a000 (irq =3D 72)=
 is a OMAP UART0
> [ =A0 =A01.553680] omap_uart.1: ttyO1 at MMIO 0x4806c000 (irq =3D 73)=
 is a OMAP UART1
> [ =A0 =A01.562164] omap_uart.2: ttyO2 at MMIO 0x49020000 (irq =3D 74)=
 is a OMAP UART2
> [ =A0 =A01.570648] omap_uart.3: ttyO3 at MMIO 0x49042000 (irq =3D 80)=
 is a OMAP UART3
> [ =A0 =A01.612884] brd: module loaded
> [ =A0 =A01.636749] loop: module loaded
> [ =A0 =A01.648681] mtdoops: mtd device (mtddev=3Dname/number) must be=
 supplied
> [ =A0 =A01.656097] NAND device: Manufacturer ID: 0x2c, Chip ID: 0xbc =
(Micron NAND 512MiB 1,8V 16-bit)
> [ =A0 =A01.670745] Creating 7 MTD partitions on "omap2-nand.0":
> [ =A0 =A01.676086] 0x000000000000-0x000000080000 : "X-Loader-NAND"
> [ =A0 =A01.689300] 0x000000080000-0x0000001c0000 : "U-Boot-NAND"
> [ =A0 =A01.699920] 0x0000001c0000-0x000000200000 : "Boot Env-NAND"
> [ =A0 =A01.710144] 0x000000200000-0x000002000000 : "Kernel-NAND"
> [ =A0 =A01.733581] 0x000002000000-0x00001c000000 : "system"
> [ =A0 =A01.931427] 0x00001c000000-0x00001e000000 : "userdata"
> [ =A0 =A01.955413] 0x00001e000000-0x000020000000 : "cache"
> [ =A0 =A01.979888] OneNAND driver initializing
> [ =A0 =A01.990173] smsc911x: Driver version 2008-10-21
> [ =A0 =A02.006958] smsc911x-mdio: probed
> [ =A0 =A02.010528] smsc911x smsc911x.0: eth0: attached PHY driver [SM=
SC LAN8700] (mii_bus:phy_addr=3Dsmsc911x-0:01, irq=3D-1)
> [ =A0 =A02.021606] smsc911x smsc911x.0: eth0: MAC Address: 00:08:ee:0=
3:7e:07
> [ =A0 =A02.029602] usbcore: registered new interface driver asix
> [ =A0 =A02.035552] usbcore: registered new interface driver cdc_ether
> [ =A0 =A02.042053] usbcore: registered new interface driver net1080
> [ =A0 =A02.048309] usbcore: registered new interface driver cdc_subse=
t
> [ =A0 =A02.054809] usbcore: registered new interface driver zaurus
> [ =A0 =A02.061035] usbcore: registered new interface driver cdc_ncm
> [ =A0 =A02.068969] usbcore: registered new interface driver cdc_wdm
> [ =A0 =A02.074645] Initializing USB Mass Storage driver...
> [ =A0 =A02.080230] usbcore: registered new interface driver usb-stora=
ge
> [ =A0 =A02.086334] USB Mass Storage support registered.
> [ =A0 =A02.092285] usbcore: registered new interface driver libusual
> [ =A0 =A02.098602] usbcore: registered new interface driver usbtest
> [ =A0 =A02.106018] mousedev: PS/2 mouse device common for all mice
> [ =A0 =A02.114196] input: TWL4030 Keypad as /devices/platform/omap_i2=
c.1/i2c-1/1-004a/twl4030_keypad/input/input0
> [ =A0 =A02.130432] input: twl4030_pwrbutton as /devices/platform/omap=
_i2c.1/i2c-1/1-0049/twl4030_pwrbutton/input/input1
> [ =A0 =A02.146270] twl_rtc twl_rtc: rtc core: registered twl_rtc as r=
tc0
> [ =A0 =A02.153411] i2c /dev entries driver
> [ =A0 =A02.160797] Driver for 1-wire Dallas network protocol.
> [ =A0 =A02.169342] OMAP Watchdog Timer Rev 0x31: initial timeout 60 s=
ec
> [ =A0 =A02.176635] twl4030_wdt twl4030_wdt: Failed to register misc d=
evice
> [ =A0 =A02.183166] twl4030_wdt: probe of twl4030_wdt failed with erro=
r -16
> [ =A0 =A02.192077] cpuidle: using governor ladder
> [ =A0 =A02.196380] cpuidle: using governor menu
> [ =A0 =A02.397155] mmc0: new high speed MMC card at address 0001
> [ =A0 =A02.405548] mmcblk0: mmc0:0001 STM16G 14.8 GiB
> [ =A0 =A02.418579] =A0mmcblk0: unknown partition table
> [ =A0 =A02.501220] usbcore: registered new interface driver usbhid
> [ =A0 =A02.506927] usbhid: USB HID core driver
> [ =A0 =A02.510772] oprofile: hardware counters not available
> [ =A0 =A02.515899] oprofile: using timer interrupt.
> [ =A0 =A02.520904] TCP cubic registered
> [ =A0 =A02.524444] Initializing XFRM netlink socket
> [ =A0 =A02.528900] NET: Registered protocol family 17
> [ =A0 =A02.533508] NET: Registered protocol family 15
> [ =A0 =A02.538299] Registering the dns_resolver key type
> [ =A0 =A02.543579] VFP support v0.3: implementor 41 architecture 3 pa=
rt 30 variant c rev 3
> [ =A0 =A02.551452] ThumbEE CPU extension supported.
> [ =A0 =A02.570129] omap3_idle_init: core off state C7 disabled due to=
 i583
> [ =A0 =A02.577514] sr_init: No PMIC hook to init smartreflex
> [ =A0 =A02.582977] smartreflex smartreflex.0: omap_sr_probe: SmartRef=
lex driver initialized
> [ =A0 =A02.591522] smartreflex smartreflex.1: omap_sr_probe: SmartRef=
lex driver initialized
> [ =A0 =A02.600341] SmartReflex Class3 initialized
> [ =A0 =A02.638000] clock: disabling unused clocks to save power
> [ =A0 =A02.650909] mmc1: card claims to support voltages below the de=
fined range. These will be ignored.
> [ =A0 =A02.663513] twl_rtc twl_rtc: setting system clock to 2000-01-2=
8 00:58:30 UTC (949021110)
> [ =A0 =A02.674804] smsc911x smsc911x.0: eth0: SMSC911x/921x identifie=
d at 0xc8888000, IRQ: 254
> [ =A0 =A02.697235] mmc1: queuing unknown CIS tuple 0x91 (3 bytes)
> [ =A0 =A02.702880] Sending DHCP requests .
> [ =A0 =A02.709014] mmc1: new SDIO card at address 0001
> [ =A0 =A03.270294] mmc2: host does not support reading read-only swit=
ch. assuming write-enable.
> [ =A0 =A03.280944] mmc2: new high speed SD card at address 1234
> [ =A0 =A03.288391] mmcblk1: mmc2:1234 SA02G 1.83 GiB
> [ =A0 =A03.297149] =A0mmcblk1: p1 p2
> [ =A0 =A05.021850] ., OK
> [ =A0 =A05.061401] IP-Config: Got DHCP answer from 192.168.1.5, my ad=
dress is 192.168.1.151
> [ =A0 =A05.069763] IP-Config: Complete:
> [ =A0 =A05.072998] =A0 =A0 =A0device=3Deth0, addr=3D192.168.1.151, ma=
sk=3D255.255.255.0, gw=3D192.168.1.254,
> [ =A0 =A05.080841] =A0 =A0 =A0host=3Dzoom3, domain=3Dlan, nis-domain=3D=
(none),
> [ =A0 =A05.086456] =A0 =A0 =A0bootserver=3D192.168.1.5, rootserver=3D=
192.168.1.236, rootpath=3D/opt/kjh/rootfs/debian/armel,rsize=3D4096,wsi=
ze=3D4096,nfsvers=3D3
> [ =A0 =A05.101623] Unhandled fault: external abort on non-linefetch (=
0x1028) at 0xfb058040
> [ =A0 =A05.109283] Internal error: : 1028 [#1] SMP
> [ =A0 =A05.113494] Modules linked in:
> [ =A0 =A05.116546] CPU: 0 =A0 =A0Tainted: G =A0 =A0 =A0 =A0W =A0 =A0 =
(3.3.0-rc7-pm+debug+initramfs-01079-g405139c #15)
> [ =A0 =A05.125274] PC is at _set_gpio_triggering+0x34/0x260
> [ =A0 =A05.130249] LR is at gpio_irq_type+0x110/0x150
> [ =A0 =A05.134704] pc : [<c0244224>] =A0 =A0lr : [<c0244890>] =A0 =A0=
psr: 60000093
> [ =A0 =A05.134704] sp : c7825cc0 =A0ip : 00000001 =A0fp : 00000106
> [ =A0 =A05.146209] r10: 000000a6 =A0r9 : 00000106 =A0r8 : c7874c10
> [ =A0 =A05.151428] r7 : 20000093 =A0r6 : c7874c6c =A0r5 : 00000020 =A0=
r4 : fb058000
> [ =A0 =A05.157958] r3 : c7874c10 =A0r2 : 00000001 =A0r1 : 00000040 =A0=
r0 : 00000040
> [ =A0 =A05.164489] Flags: nZCv =A0IRQs off =A0FIQs on =A0Mode SVC_32 =
=A0ISA ARM =A0Segment kernel
> [ =A0 =A05.171905] Control: 10c5387d =A0Table: 872fc019 =A0DAC: 00000=
017
> [ =A0 =A05.177642] Process swapper/0 (pid: 1, stack limit =3D 0xc7824=
2f8)
> [ =A0 =A05.183654] Stack: (0xc7825cc0 to 0xc7826000)
> [ =A0 =A05.188049] 5cc0: 00000001 c08d2640 c7874c6c 20000093 c08d26e8=
 c08d2640 c0244780 00000000
> [ =A0 =A05.196228] 5ce0: c0932770 00000106 00000001 c00946e4 c08d26e8=
 c08d2640 c72f9a00 c08d2694
> [ =A0 =A05.204406] 5d00: 60000013 c08d2674 00000000 c0094b2c 000080d0=
 c00eeea0 60000093 c78233c0
> [ =A0 =A05.212615] 5d20: c0950244 c72f9a00 c08d2640 c72f99c0 00000081=
 c027adb0 00000106 00000000
> [ =A0 =A05.220794] 5d40: 00000000 c0094c98 c0e9a904 c72f99c0 00000000=
 00000006 c72f99cc 00000080
> [ =A0 =A05.228973] 5d60: c0e9cd30 c027afa0 c05679b4 c72f99c0 c0e9a904=
 00000002 20000013 00000002
> [ =A0 =A05.237182] 5d80: 00000000 c73a4800 00000002 c027c2d8 c0e9a904=
 c7980000 00000000 c73a4800
> [ =A0 =A05.245361] 5da0: 00000000 c02777d8 c73a4800 c73a4920 c7980000=
 00000000 c71ba2c0 c02787d8
> [ =A0 =A05.253570] 5dc0: 00000000 c7980000 c73a4800 c79800b0 c78d8cc0=
 c027908c c78d8cc0 00500001
> [ =A0 =A05.261749] 5de0: c0464158 c7824000 c71ba2c0 c0261288 c00f5e38=
 c75360f8 00000001 00000000
> [ =A0 =A05.269927] 5e00: c0e997a0 00000000 c0e997a0 00000000 c75360f8=
 00000000 00000000 c78d8cc0
> [ =A0 =A05.278137] 5e20: 00000000 c00f5ee8 c753620c 00000000 00000000=
 c78d8cc0 c75378e0 c75360f8
> [ =A0 =A05.286315] 5e40: c753620c 00000000 00000000 c7814b10 00000000=
 c00effd4 c00f5df8 c753792c
> [ =A0 =A05.294525] 5e60: 00000000 c781c840 00000000 c78d8cc0 c7825f38=
 00000000 00000000 00000000
> [ =A0 =A05.302703] 5e80: 00000000 c00f102c c781c840 00000002 00000000=
 c7825f38 00000002 00000000
> [ =A0 =A05.310882] 5ea0: 00000026 c00ff8b0 c7537a20 c00fe1c4 00000001=
 c75360f8 c00fe1a0 c7825f38
> [ =A0 =A05.319091] 5ec0: c7825fb8 00000000 c7825ef4 c7824000 00000000=
 00000000 00000000 c00ffb94
> [ =A0 =A05.327270] 5ee0: c7825f04 00000000 00000000 00000000 00000000=
 c7814b10 c75378e0 00000000
> [ =A0 =A05.335449] 5f00: c781eed0 00000000 00000000 c7825fb8 00000001=
 c7a35000 ffffff9c ffffff9c
> [ =A0 =A05.343658] 5f20: 00000000 00000000 00000000 c00fff80 00000041=
 c78233c0 c7814b10 c75378e0
> [ =A0 =A05.351837] 5f40: 05b6719b 00000007 c7a35005 00000000 c7401940=
 c75360f8 00000101 00000004
> [ =A0 =A05.360015] 5f60: 00000000 00000000 c781ee88 00000000 c781eec0=
 00000002 00000000 00000000
> [ =A0 =A05.368225] 5f80: 00000000 c781ee80 c781ee88 00000002 00000000=
 00000000 c000e850 c7a35000
> [ =A0 =A05.376403] 5fa0: 00000002 00000000 00000001 c00f1110 00000000=
 00000000 00000002 c0080000
> [ =A0 =A05.384613] 5fc0: 00000026 00000100 c0651bb4 c0651bb4 c0651bb4=
 c000e850 00000013 00000000
> [ =A0 =A05.392791] 5fe0: 00000000 c06068c4 00000000 00000000 c0606820=
 c000e850 df2b77da f7efed7e
> [ =A0 =A05.401000] [<c0244224>] (_set_gpio_triggering+0x34/0x260) fro=
m [<c08d26e8>] (irq_desc+0xc528/0x16380)
> [ =A0 =A05.410308] Code: 0a00004c e3a0c001 e3120008 e1a0111c (e794c00=
0)
> [ =A0 =A05.416442] ------------[ cut here ]------------
> [ =A0 =A05.421081] WARNING: at /work/kernel/omap/pm/arch/arm/mach-oma=
p2/omap_l3_smx.c:161 omap3_l3_app_irq+0xd0/0x128()
> [ =A0 =A05.431243] In-band Error seen by MPU =A0at address 0
> [ =A0 =A05.436126] Modules linked in:
> [ =A0 =A05.439208] [<c0014248>] (unwind_backtrace+0x0/0xf0) from [<c0=
039054>] (warn_slowpath_common+0x4c/0x64)
> [ =A0 =A05.448638] [<c0039054>] (warn_slowpath_common+0x4c/0x64) from=
 [<c0039100>] (warn_slowpath_fmt+0x30/0x40)
> [ =A0 =A05.458221] [<c0039100>] (warn_slowpath_fmt+0x30/0x40) from [<=
c002c0c0>] (omap3_l3_app_irq+0xd0/0x128)
> [ =A0 =A05.467559] [<c002c0c0>] (omap3_l3_app_irq+0xd0/0x128) from [<=
c0093460>] (handle_irq_event_percpu+0x58/0x244)
> [ =A0 =A05.477478] [<c0093460>] (handle_irq_event_percpu+0x58/0x244) =
from [<c0093688>] (handle_irq_event+0x3c/0x5c)
> [ =A0 =A05.487335] [<c0093688>] (handle_irq_event+0x3c/0x5c) from [<c=
0095c6c>] (handle_level_irq+0xac/0xfc)
> [ =A0 =A05.496490] [<c0095c6c>] (handle_level_irq+0xac/0xfc) from [<c=
0092cb8>] (generic_handle_irq+0x30/0x48)
> [ =A0 =A05.505828] [<c0092cb8>] (generic_handle_irq+0x30/0x48) from [=
<c000e5f8>] (handle_IRQ+0x4c/0xac)
> [ =A0 =A05.514617] [<c000e5f8>] (handle_IRQ+0x4c/0xac) from [<c000874=
4>] (omap3_intc_handle_irq+0x54/0x68)
> [ =A0 =A05.523681] [<c0008744>] (omap3_intc_handle_irq+0x54/0x68) fro=
m [<c0435964>] (__irq_svc+0x44/0x60)
> [ =A0 =A05.532653] Exception stack(0xc7825b70 to 0xc7825bb8)
> [ =A0 =A05.537719] 5b60: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 c0435688 00000001 00000000 00000080
> [ =A0 =A05.545898] 5b80: c08e1c6c c7824000 00000001 00001028 c7874c10=
 00000106 000000a6 00000106
> [ =A0 =A05.554107] 5ba0: 00000000 c7825bb8 c0435688 c043568c 60000113=
 ffffffff
> [ =A0 =A05.560729] [<c0435964>] (__irq_svc+0x44/0x60) from [<c043568c=
>] (_raw_spin_unlock_irq+0x28/0x2c)
> [ =A0 =A05.569610] [<c043568c>] (_raw_spin_unlock_irq+0x28/0x2c) from=
 [<c0011760>] (die+0x98/0x128)
> [ =A0 =A05.578063] [<c0011760>] (die+0x98/0x128) from [<c0008584>] (d=
o_DataAbort+0x8c/0x9c)
> [ =A0 =A05.585845] [<c0008584>] (do_DataAbort+0x8c/0x9c) from [<c0435=
8e4>] (__dabt_svc+0x44/0x80)
> [ =A0 =A05.594116] Exception stack(0xc7825c78 to 0xc7825cc0)
> [ =A0 =A05.599151] 5c60: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0000004=
0 00000040
> [ =A0 =A05.607360] 5c80: 00000001 c7874c10 fb058000 00000020 c7874c6c=
 20000093 c7874c10 00000106
> [ =A0 =A05.615539] 5ca0: 000000a6 00000106 00000001 c7825cc0 c0244890=
 c0244224 60000093 ffffffff
> [ =A0 =A05.623748] [<c04358e4>] (__dabt_svc+0x44/0x80) from [<c024422=
4>] (_set_gpio_triggering+0x34/0x260)
> [ =A0 =A05.632812] [<c0244224>] (_set_gpio_triggering+0x34/0x260) fro=
m [<c08d26e8>] (irq_desc+0xc528/0x16380)
> [ =A0 =A05.642120] ---[ end trace 1b75b31a2719ed1e ]---
> [ =A0 =A05.646820] ---[ end trace 1b75b31a2719ed1f ]---
> [ =A0 =A05.651489] Kernel panic - not syncing: Attempted to kill init=
!
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

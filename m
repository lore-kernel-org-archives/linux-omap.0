From: Javier Martinez Canillas <martinez.javier@gmail.com>
Subject: Re: omap DSS fails with tft410 driver panel?
Date: Tue, 18 Dec 2012 12:23:41 +0100
Message-ID: <CAAwP0s1JgN4tZjQ74-tmcGyJy9NFf=gPipP3VmqOCKJ6HdmrWg@mail.gmail.com>
References: <CAFqH_50PVJdbX0CMwo9t3RuAhzi3q6jcBwzq2R3UFighkrF7iw@mail.gmail.com>
 <CAGDS+nmx8qFSx932TudMN6ikmZ=OGkbvrZuCV=Ump+HETkU-tw@mail.gmail.com>
 <50ADE6A5.3030001@ti.com> <CAGDS+nm2YVNyq+eAF-VSq785KAKWC2GM4v5U7N1vLGTNNDfa7Q@mail.gmail.com>
 <50AF37EA.3080400@ti.com> <CAGDS+nncx71OL7tiwEot6RcyFxipj_SVg=z5Sg-Qdv2n4iyL2A@mail.gmail.com>
 <50B4A4D7.2070203@ti.com> <CAGDS+nmaGK1igkYnz0EQEycUU=LsD5yz9wxmipSnWohKvAPTXA@mail.gmail.com>
 <50B74592.3020308@ti.com> <CAGDS+n=oQYr+24mX6bdgtW=fzvfvfX5rAvNXXpxM4YKPxHDodQ@mail.gmail.com>
 <50B771D3.8050907@ti.com> <CAGDS+n=dbuEQgdw9nJ_mYQpuJr5huSgX6e3sBDcvy0+C6T5hFQ@mail.gmail.com>
 <50B777A3.1080803@ti.com> <CAAwP0s3hYiovSqRfBFDGVQCDVUqYKZrY9QXp+G-R707szdmVqA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-oa0-f45.google.com ([209.85.219.45]:35284 "EHLO
	mail-oa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754215Ab2LRLYD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 Dec 2012 06:24:03 -0500
Received: by mail-oa0-f45.google.com with SMTP id i18so476235oag.18
        for <linux-omap@vger.kernel.org>; Tue, 18 Dec 2012 03:24:02 -0800 (PST)
In-Reply-To: <CAAwP0s3hYiovSqRfBFDGVQCDVUqYKZrY9QXp+G-R707szdmVqA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Steve Sakoman <sakoman@gmail.com>, Enric Balletbo Serra <eballetbo@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Javier Martinez Canillas <javier@dowhile0.org>

On Tue, Dec 18, 2012 at 9:31 AM, Javier Martinez Canillas
<martinez.javier@gmail.com> wrote:
> On Thu, Nov 29, 2012 at 3:56 PM, Tomi Valkeinen <tomi.valkeinen@ti.co=
m> wrote:
>> On 2012-11-29 16:53, Steve Sakoman wrote:
>>> On Thu, Nov 29, 2012 at 6:31 AM, Tomi Valkeinen <tomi.valkeinen@ti.=
com> wrote:
>>>
>>>>> It is stock Linux 3.6 (i.e. commit a0d271cbfed1dd50278c6b06bead3d=
00ba0a88f9)
>>>>
>>>> Still can't reproduce. So does the null pointer deref happen at bo=
ot
>>>> time? What display related kernel boot options do you have? This l=
ooks
>>>> funny, considering lcd43 is a bit smaller lcd:
>>>
>>> Yes, it happens at boot time.
>>>
>>> The boot options:
>>>
>>> [    0.000000] Kernel command line: console=3DttyO2,115200n8 mpurat=
e=3D500
>>> vram=3D12M omapfb.mode=3Ddvi:1024x768MR-16@60 omapdss.def_disp=3Dlc=
d43
>>> root=3D/dev/mmcblk0p2 rw rootfstype=3Dext3 rootwait
>>
>> Ok, now I see it. It happens because DVI is not configured to be use=
d,
>> but you have DVI video mode specified in the command line.
>>
>> I'll study this further and make a fix.
>>
>>  Tomi
>>
>>
>>
>
> Hello folks,
>
> Did you find a solution for this?
>
> I still have the issue, when trying to start X I got:
>
> [   25.152160] OMAPFB: ioctl QUERY_PLANE
> [   25.156066] OMAPFB: ioctl SETUP_PLANE
> [   25.160095] OMAPFB: omapfb_setup_plane
> [   25.164093] omapdss OVERLAY error: check_overlay: paddr cannot be =
0
> [   25.170684] omapdss OVERLAY error: check_overlay: paddr cannot be =
0
> [   25.177337] omapfb omapfb: setup_plane failed
> [   25.181976] OMAPFB: ioctl failed: -22
>
> I'm using the arm-soc.git tree with the latest fixes and cleanups for
> v3.8 sent by Tony yesterday and Xorg 1.13.
>
> The latest commit id is:
>
> commit aad05c3602ba5c42ff8d0e572b2f614f25779ede
> Merge: eccf4b3 f64d204
> Author: Olof Johansson <olof@lixom.net>
> Date:   Mon Dec 17 18:44:26 2012 -0800
>
>     Merge branch 'late/omap-cleanup' into for-next
>
> I've CONFIG_OMAP2_DSS, CONFIG_FB_OMAP2 and CONFIG_PANEL_TFP410
> built-in and this is my kernel command line is:
>
> console=3DttyO2,115200n8 mpurate=3Dauto vram=3D12M
> omapfb.mode=3Ddvi:1024x768MR-16@60 omapfb.debug=3Dy omapdss.def_disp=3D=
dvi
> root=3D/dev/mmcblk0p2 rw rootfstype=3Dext4 rootwait
>
> Also I have this log about a locking dependency:
>
> [   24.690795]
> [   24.690826] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [   24.690826] [ INFO: possible circular locking dependency detected =
]
> [   24.690826] 3.7.0-00017-g6c2ecfb-dirty #144 Not tainted
> [   24.690826] ------------------------------------------------------=
-
> [   24.690826] Xorg/1259 is trying to acquire lock:
> [   24.690887]  ((fb_notifier_list).rwsem){.+.+.+}, at: [<c0068708>]
> __blocking_notifier_call_chain+0x30/0x60
> [   24.690887]
> [   24.690887] but task is already holding lock:
> [   24.690917]  (console_lock){+.+.+.}, at: [<c02cec98>] do_fb_ioctl+=
0x200/0x5d8
> [   24.690917]
> [   24.690917] which lock already depends on the new lock.
> [   24.690917]
> [   24.690917]
> [   24.690917] the existing dependency chain (in reverse order) is:
> [   24.690948]
> [   24.690948] -> #1 (console_lock){+.+.+.}:
> [   24.690979]        [<c00902a4>] lock_acquire+0x9c/0x124
> [   24.690979]        [<c0042b0c>] console_lock+0x50/0x64
> [   24.691009]        [<c0320bd0>] register_con_driver+0x38/0x134
> [   24.691009]        [<c03221a0>] take_over_console+0x18/0x44
> [   24.691040]        [<c02d7674>] fbcon_takeover+0x64/0xc8
> [   24.691070]        [<c04f4dd4>] notifier_call_chain+0x44/0x84
> [   24.691070]        [<c0068720>] __blocking_notifier_call_chain+0x4=
8/0x60
> [   24.691070]        [<c0068750>] blocking_notifier_call_chain+0x18/=
0x20
> [   24.691101]        [<c02cf654>] register_framebuffer+0x16c/0x23c
> [   24.691131]        [<c04ee990>] omapfb_create_framebuffers+0x520/0=
x700
> [   24.691131]        [<c0723480>] omapfb_probe+0x4e4/0x768
> [   24.691162]        [<c03399f8>] platform_drv_probe+0x18/0x1c
> [   24.691162]        [<c03387b4>] driver_probe_device+0x78/0x210
> [   24.691192]        [<c03389e0>] __driver_attach+0x94/0x98
> [   24.691192]        [<c03370b4>] bus_for_each_dev+0x50/0x7c
> [   24.691223]        [<c0337fe0>] bus_add_driver+0x178/0x240
> [   24.691223]        [<c0338eb0>] driver_register+0x78/0x144
> [   24.691253]        [<c0339be8>] platform_driver_probe+0x18/0x9c
> [   24.691253]        [<c0722f70>] omapfb_init+0x28/0x54
> [   24.691284]        [<c00086a4>] do_one_initcall+0x34/0x178
> [   24.691284]        [<c04e47ac>] kernel_init+0x100/0x2b4
> [   24.691314]        [<c0013170>] ret_from_fork+0x14/0x24
> [   24.691314]
> [   24.691314] -> #0 ((fb_notifier_list).rwsem){.+.+.+}:
> [   24.691345]        [<c008f85c>] __lock_acquire+0x15e4/0x1b00
> [   24.691345]        [<c00902a4>] lock_acquire+0x9c/0x124
> [   24.691375]        [<c04f0eb8>] down_read+0x2c/0x3c
> [   24.691375]        [<c0068708>] __blocking_notifier_call_chain+0x3=
0/0x60
> [   24.691406]        [<c0068750>] blocking_notifier_call_chain+0x18/=
0x20
> [   24.691406]        [<c02ce1c0>] fb_blank+0x34/0x98
> [   24.691436]        [<c02cecb0>] do_fb_ioctl+0x218/0x5d8
> [   24.691436]        [<c0114924>] do_vfs_ioctl+0x80/0x5f0
> [   24.691467]        [<c0114f04>] sys_ioctl+0x70/0x78
> [   24.691467]        [<c00130c0>] ret_fast_syscall+0x0/0x3c
> [   24.691467]
> [   24.691467] other info that might help us debug this:
> [   24.691467]
> [   24.691497]  Possible unsafe locking scenario:
> [   24.691497]
> [   24.691497]        CPU0                    CPU1
> [   24.691497]        ----                    ----
> [   24.691497]   lock(console_lock);
> [   24.691497]                                lock((fb_notifier_list)=
=2Erwsem);
> [   24.691528]                                lock(console_lock);
> [   24.691528]   lock((fb_notifier_list).rwsem);
> [   24.691528]
> [   24.691528]  *** DEADLOCK ***
> [   24.691528]
> [   24.691528] 2 locks held by Xorg/1259:
> [   24.691558]  #0:  (&fb_info->lock){+.+.+.}, at: [<c02cdf9c>]
> lock_fb_info+0x18/0x3c
> [   24.691589]  #1:  (console_lock){+.+.+.}, at: [<c02cec98>]
> do_fb_ioctl+0x200/0x5d8
> [   24.691589]
> [   24.691589] stack backtrace:
> [   24.691619] [<c001ac2c>] (unwind_backtrace+0x0/0xf0) from
> [<c04eb508>] (print_circular_bug+0x278/0x2c4)
> [   24.691650] [<c04eb508>] (print_circular_bug+0x278/0x2c4) from
> [<c008f85c>] (__lock_acquire+0x15e4/0x1b00)
> [   24.691650] [<c008f85c>] (__lock_acquire+0x15e4/0x1b00) from
> [<c00902a4>] (lock_acquire+0x9c/0x124)
> [   24.691680] [<c00902a4>] (lock_acquire+0x9c/0x124) from
> [<c04f0eb8>] (down_read+0x2c/0x3c)
> [   24.691711] [<c04f0eb8>] (down_read+0x2c/0x3c) from [<c0068708>]
> (__blocking_notifier_call_chain+0x30/0x60)
> [   24.691711] [<c0068708>] (__blocking_notifier_call_chain+0x30/0x60=
)
> from [<c0068750>] (blocking_notifier_call_chain+0x18/0x20)
> [   24.691741] [<c0068750>] (blocking_notifier_call_chain+0x18/0x20)
> from [<c02ce1c0>] (fb_blank+0x34/0x98)
> [   24.691741] [<c02ce1c0>] (fb_blank+0x34/0x98) from [<c02cecb0>]
> (do_fb_ioctl+0x218/0x5d8)
> [   24.691772] [<c02cecb0>] (do_fb_ioctl+0x218/0x5d8) from
> [<c0114924>] (do_vfs_ioctl+0x80/0x5f0)
> [   24.691772] [<c0114924>] (do_vfs_ioctl+0x80/0x5f0) from
> [<c0114f04>] (sys_ioctl+0x70/0x78)
> [   24.691802] [<c0114f04>] (sys_ioctl+0x70/0x78) from [<c00130c0>]
> (ret_fast_syscall+0x0/0x3c)
>
> I will look at this, but just wanted to ask first in case I missed
> some patches that already fix this.
>
> My complete .config [1], dmesg [2] and xorg.conf [3].
>
> Thanks a lot and best regards,
> Javier
>
> [1]: http://fpaste.org/DJgw/
> [2]: http://fpaste.org/XEs5/
> [3]: http://fpaste.org/dhWd/

I've confirmed that this is the same issue that Steve had
(dss_ovl_simple_check() failing due info->paddr =3D=3D 0), so I tried h=
is
patch to force dss_ovl_simple_check() to always succeed. The second
SETUP_PLANE ioctl doesn't fail anymore and I can see Xorg server is
running.

But still I don't have any output on the screen. Any hints will be appr=
eciated.

Here is my complete dmesg:

[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 3.7.0-00017-g6c2ecfb-dirty (javier@munra)
(gcc version 4.6.3 (crosstool-NG linaro-1.13.1+bzr2368 - Linaro GCC
2012.03) ) #155 SMP Tue Dec 18 12:14:19 CET 2012
[    0.000000] CPU: ARMv7 Processor [413fc082] revision 2 (ARMv7), cr=3D=
10c53c7d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing
instruction cache
[    0.000000] Machine: IGEP v2 board
[    0.000000] Memory policy: ECC disabled, Data cache writeback
[    0.000000] On node 0 totalpages: 130816
[    0.000000] free_area_init_node: node 0, pgdat c07e09c0,
node_mem_map c0d40000
[    0.000000]   Normal zone: 1024 pages used for memmap
[    0.000000]   Normal zone: 0 pages reserved
[    0.000000]   Normal zone: 129792 pages, LIFO batch:31
[    0.000000] OMAP3630 ES1.2 (l2cache iva sgx neon isp 192mhz_clk )
[    0.000000] Clocking rate (Crystal/Core/MPU): 26.0/400/600 MHz
[    0.000000] PERCPU: Embedded 9 pages/cpu @c1148000 s12992 r8192 d156=
80 u36864
[    0.000000] pcpu-alloc: s12992 r8192 d15680 u36864 alloc=3D9*4096
[    0.000000] pcpu-alloc: [0] 0
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.
Total pages: 129792
[    0.000000] Kernel command line: console=3DttyO2,115200n8
mpurate=3Dauto vram=3D12M omapfb.mode=3Ddvi:1024x768MR-16@60 omapfb.deb=
ug=3Dy
omapdss.def_disp=3Ddvi root=3D/dev/mmcblk0p2 rw rootfstype=3Dext4 rootw=
ait
[    0.000000] PID hash table entries: 2048 (order: 1, 8192 bytes)
[    0.000000] Dentry cache hash table entries: 65536 (order: 6, 262144=
 bytes)
[    0.000000] Inode-cache hash table entries: 32768 (order: 5, 131072 =
bytes)
[    0.000000] __ex_table already sorted, skipping sort
[    0.000000] Memory: 511MB =3D 511MB total
[    0.000000] Memory: 505132k/505132k available, 19156k reserved, 0K h=
ighmem
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
[    0.000000]     vmalloc : 0xe0800000 - 0xff000000   ( 488 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xe0000000   ( 512 MB)
[    0.000000]     pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
[    0.000000]     modules : 0xbf000000 - 0xbfe00000   (  14 MB)
[    0.000000]       .text : 0xc0008000 - 0xc06fc424   (7122 kB)
[    0.000000]       .init : 0xc06fd000 - 0xc07512c0   ( 337 kB)
[    0.000000]       .data : 0xc0752000 - 0xc07e3388   ( 581 kB)
[    0.000000]        .bss : 0xc07e33ac - 0xc0d3fab0   (5490 kB)
[    0.000000] Hierarchical RCU implementation.
[    0.000000] 	RCU restricting CPUs from NR_CPUS=3D2 to nr_cpu_ids=3D1=
=2E
[    0.000000] NR_IRQS:16 nr_irqs:16 16
[    0.000000] IRQ: Found an INTC at 0xfa200000 (revision 4.0) with 96
interrupts
[    0.000000] Total of 96 interrupts on 1 active controller
[    0.000000] OMAP clockevent source: GPTIMER1 at 32768 Hz
[    0.000000] sched_clock: 32 bits at 32kHz, resolution 30517ns,
wraps every 131071999ms
[    0.000000] OMAP clocksource: 32k_counter at 32768 Hz
[    0.000000] Console: colour dummy device 80x30
[    0.000000] Lock dependency validator: Copyright (c) 2006 Red Hat,
Inc., Ingo Molnar
[    0.000000] ... MAX_LOCKDEP_SUBCLASSES:  8
[    0.000000] ... MAX_LOCK_DEPTH:          48
[    0.000000] ... MAX_LOCKDEP_KEYS:        8191
[    0.000000] ... CLASSHASH_SIZE:          4096
[    0.000000] ... MAX_LOCKDEP_ENTRIES:     16384
[    0.000000] ... MAX_LOCKDEP_CHAINS:      32768
[    0.000000] ... CHAINHASH_SIZE:          16384
[    0.000000]  memory used by lock dependency info: 3695 kB
[    0.000000]  per task-struct memory footprint: 1152 bytes
[    0.001007] Calibrating delay loop... 397.57 BogoMIPS (lpj=3D1554432=
)
[    0.109374] pid_max: default: 32768 minimum: 301
[    0.109954] Security Framework initialized
[    0.110107] Mount-cache hash table entries: 512
[    0.114685] CPU: Testing write buffer coherency: ok
[    0.115509] CPU0: thread -1, cpu 0, socket -1, mpidr 0
[    0.115570] Setting up static identity map for 0x804f8070 - 0x804f80=
e0
[    0.118194] Brought up 1 CPUs
[    0.118225] SMP: Total of 1 processors activated (397.57 BogoMIPS).
[    0.121429] devtmpfs: initialized
[    0.178405] pinctrl core: initialized pinctrl subsystem
[    0.185058] regulator-dummy: no parameters
[    0.187011] NET: Registered protocol family 16
[    0.187896] DMA: preallocated 256 KiB pool for atomic coherent alloc=
ations
[    0.189819] omap-gpmc omap-gpmc: GPMC revision 5.0
[    0.200897] gpiochip_add: registered GPIOs 0 to 31 on device: gpio
[    0.201385] OMAP GPIO hardware version 2.5
[    0.203857] gpiochip_add: registered GPIOs 32 to 63 on device: gpio
[    0.206451] gpiochip_add: registered GPIOs 64 to 95 on device: gpio
[    0.208709] gpiochip_add: registered GPIOs 96 to 127 on device: gpio
[    0.211242] gpiochip_add: registered GPIOs 128 to 159 on device: gpi=
o
[    0.213562] gpiochip_add: registered GPIOs 160 to 191 on device: gpi=
o
[    0.220794] omap_mux_init: Add partition: #1: core, flags: 4
[    0.223358] IGEP2: Hardware Revision C (B-NON compatible)
[    0.230804] _omap_mux_get_by_name: Could not find signal uart4_rx.ua=
rt4_rx
[    0.239440] Reprogramming SDRC clock to 400000000 Hz
[    0.240264] IGEP: initializing NAND memory device
[    0.252227] hw-breakpoint: debug architecture 0x4 unsupported.
[    0.267913]  omap-mcbsp.2: alias fck already exists
[    0.268707]  omap-mcbsp.3: alias fck already exists
[    0.272338] OMAP DMA hardware revision 5.0
[    0.276702]  arm-pmu: alias fck already exists
[    0.342346] bio: create slab <bio-0> at 0
[    0.432434] omap-dma-engine omap-dma-engine: OMAP DMA engine driver
[    0.433410] fixed-dummy: no parameters
[    0.434448] vwlan: 3300 mV normal
[    0.441284] SCSI subsystem initialized
[    0.443695] usbcore: registered new interface driver usbfs
[    0.444213] usbcore: registered new interface driver hub
[    0.445007] usbcore: registered new device driver usb
[    0.450622] omap_i2c omap_i2c.3: bus 3 rev1.4.0 at 100 kHz
[    0.464324] twl 1-0048: PIH (irq 23) chaining IRQs 338..346
[    0.464965] twl 1-0048: power (irq 343) chaining IRQs 346..353
[    0.467926] twl4030_gpio twl4030_gpio: gpio (irq 338) chaining IRQs =
354..371
[    0.468353] gpiochip_find_base: found new base at 492
[    0.469909] gpiochip_add: registered GPIOs 492 to 511 on device: twl=
4030
[    0.480804] VIO: 1800 mV normal standby
[    0.483184] vdd_mpu_iva: 600 <--> 1450 mV normal
[    0.485565] vdd_core: 600 <--> 1450 mV normal
[    0.487762] VMMC1: 1850 <--> 3150 mV at 3150 mV normal standby
[    0.490661] VDVI: 1800 mV normal standby
[    0.491485] omap_i2c omap_i2c.1: bus 1 rev1.4.0 at 2600 kHz
[    0.499176] Switching to clocksource 32k_counter
[    0.643341] NET: Registered protocol family 2
[    0.645416] TCP established hash table entries: 4096 (order: 3, 3276=
8 bytes)
[    0.645721] TCP bind hash table entries: 4096 (order: 5, 147456 byte=
s)
[    0.647979] TCP: Hash tables configured (established 4096 bind 4096)
[    0.648681] TCP: reno registered
[    0.648712] UDP hash table entries: 256 (order: 2, 20480 bytes)
[    0.649047] UDP-Lite hash table entries: 256 (order: 2, 20480 bytes)
[    0.650085] NET: Registered protocol family 1
[    0.651397] RPC: Registered named UNIX socket transport module.
[    0.651428] RPC: Registered udp transport module.
[    0.651458] RPC: Registered tcp transport module.
[    0.651458] RPC: Registered tcp NFSv4.1 backchannel transport module=
=2E
[    0.652557] NetWinder Floating Point Emulator V0.97 (double precisio=
n)
[    0.652893] CPU PMU: probing PMU on CPU 0
[    0.652923] hw perfevents: enabled with ARMv7 Cortex-A8 PMU driver,
5 counters available
[    0.842712] VFS: Disk quotas dquot_6.5.2
[    0.843048] Dquot-cache hash table entries: 1024 (order 0, 4096 byte=
s)
[    0.846191] NFS: Registering the id_resolver key type
[    0.846679] Key type id_resolver registered
[    0.846710] Key type id_legacy registered
[    0.846862] jffs2: version 2.2. (NAND) (SUMMARY)  =C2=A9 2001-2006 R=
ed Hat, Inc.
[    0.847442] msgmni has been set to 986
[    0.851013] io scheduler noop registered
[    0.851043] io scheduler deadline registered
[    0.851135] io scheduler cfq registered (default)
[    0.855895] OMAP DSS rev 2.0
[    0.888336] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    0.896820] omap_uart.0: ttyO0 at MMIO 0x4806a000 (irq =3D 88) is a =
OMAP UART0
[    0.899444] omap_uart.1: ttyO1 at MMIO 0x4806c000 (irq =3D 89) is a =
OMAP UART1
[    0.901397] omap_uart.2: ttyO2 at MMIO 0x49020000 (irq =3D 90) is a =
OMAP UART2
[    1.611419] console [ttyO2] enabled
[    1.617340] omap_uart.3: ttyO3 at MMIO 0x49042000 (irq =3D 96) is a =
OMAP UART3
[    1.662353] brd: module loaded
[    1.687408] loop: module loaded
[    1.698608] mtdoops: mtd device (mtddev=3Dname/number) must be suppl=
ied
[    1.706298] NAND device: Manufacturer ID: 0x2c, Chip ID: 0xbc
(Micron NAND 512MiB 1,8V 16-bit), page size: 2048, OOB size: 64
[    1.718414] Creating 5 MTD partitions on "omap2-nand.0":
[    1.724029] 0x000000000000-0x000000080000 : "X-Loader"
[    1.737426] 0x000000080000-0x000000200000 : "U-Boot"
[    1.748809] 0x000000200000-0x000000280000 : "Environment"
[    1.760040] 0x000000280000-0x000000580000 : "Kernel"
[    1.772552] 0x000000580000-0x000020000000 : "File System"
[    2.223999] OneNAND driver initializing
[    2.238800] smsc911x: Driver version 2008-10-21
[    2.251861] libphy: smsc911x-mdio: probed
[    2.256439] smsc911x smsc911x.0 eth0: attached PHY driver [SMSC
LAN8700] (mii_bus:phy_addr=3Dsmsc911x-0:01, irq=3D-1)
[    2.268829] smsc911x smsc911x.0 eth0: MAC Address: 4e:5f:57:5d:d2:c5
[    2.277496] usbcore: registered new interface driver asix
[    2.283813] usbcore: registered new interface driver cdc_ether
[    2.290618] usbcore: registered new interface driver smsc95xx
[    2.297241] usbcore: registered new interface driver net1080
[    2.303680] usbcore: registered new interface driver cdc_subset
[    2.310485] usbcore: registered new interface driver zaurus
[    2.316955] usbcore: registered new interface driver cdc_ncm
[    2.325286] usbcore: registered new interface driver cdc_wdm
[    2.331359] Initializing USB Mass Storage driver...
[    2.337097] usbcore: registered new interface driver usb-storage
[    2.343505] USB Mass Storage support registered.
[    2.348937] usbcore: registered new interface driver usbtest
[    2.357238] mousedev: PS/2 mouse device common for all mice
[    2.365661] input: TWL4030 Keypad as
/devices/platform/omap_i2c.1/i2c-1/1-004a/twl4030_keypad/input/input0
[    2.384185] input: twl4030_pwrbutton as
/devices/platform/omap_i2c.1/i2c-1/1-004b/twl4030_pwrbutton/input/input=
1
[    2.397186] twl_rtc twl_rtc: Power up reset detected.
[    2.404022] twl_rtc twl_rtc: Enabling TWL-RTC
[    2.413330] twl_rtc twl_rtc: rtc core: registered twl_rtc as rtc0
[    2.421386] i2c /dev entries driver
[    2.428680] Driver for 1-wire Dallas network protocol.
[    2.438079] omap_wdt: OMAP Watchdog Timer Rev 0x31: initial timeout =
60 sec
[    2.446624] twl4030_wdt twl4030_wdt: Failed to register misc device
[    2.453460] twl4030_wdt: probe of twl4030_wdt failed with error -16
[    2.463409] omap-dma-engine omap-dma-engine: allocating channel for =
48
[    2.470550] omap-dma-engine omap-dma-engine: allocating channel for =
47
[    2.525421] omap-dma-engine omap-dma-engine: allocating channel for =
62
[    2.532470] omap-dma-engine omap-dma-engine: allocating channel for =
61
[    2.569366] mmc0: new SDIO card at address 0001
[    2.920196] usbcore: registered new interface driver usbhid
[    2.926239] usbhid: USB HID core driver
[    2.932037] oprofile: using arm/armv7
[    2.936737] TCP: cubic registered
[    2.940338] Initializing XFRM netlink socket
[    2.945068] NET: Registered protocol family 17
[    2.949859] NET: Registered protocol family 15
[    2.955017] Key type dns_resolver registered
[    2.959655] VFP support v0.3: implementor 41 architecture 3 part 30
variant c rev 3
[    2.978881] ThumbEE CPU extension supported.
[    2.991058] OMAPFB: omapfb_init
[    2.991302] OMAPFB: omapfb_probe
[    2.994323] fbcvt: 1024x768@60: CVT Name - .786M3-R
[    2.999938] OMAPFB: create 3 framebuffers
[    2.999999] OMAPFB: fb_infos allocated
[    2.999999] OMAPFB: allocating 1572864 bytes for fb 0
[    3.002807] OMAPFB: allocated VRAM paddr 9f600000, vaddr e090c000
[    3.002838] OMAPFB: region0 phys 9f600000 virt e090c000 size=3D15728=
64
[    3.002868] OMAPFB: region1 phys 00000000 virt   (null) size=3D0
[    3.002868] OMAPFB: region2 phys 00000000 virt   (null) size=3D0
[    3.002868] OMAPFB: fbmems allocated
[    3.003082] OMAPFB: check_fb_var 0
[    3.003082] OMAPFB: max frame size 1572864, line size 2048
[    3.003112] OMAPFB: xres =3D 1024, yres =3D 768, vxres =3D 1024, vyr=
es =3D 768
[    3.003143] OMAPFB: set_fb_fix
[    3.005126] OMAPFB: fb_infos initialized
[    3.010009] OMAPFB: set_par(0)
[    3.010070] OMAPFB: set_fb_fix
[    3.010070] OMAPFB: apply_changes, fb 0, ovl 0
[    3.010131] OMAPFB: setup_overlay 0, posx 0, posy 0, outw 1024, outh=
 768
[    3.010162] OMAPFB: paddr 9f600000
[    3.010314] OMAPFB: pan_display(0)
[    3.010314] OMAPFB: setcmap
[    3.010345] OMAPFB: setcmap
[    3.019195] Console: switching to colour frame buffer device 128x48
[    3.019195] OMAPFB: pan_display(0)
[    3.019195] OMAPFB: setcmap
[    3.027313] OMAPFB: setcmap
[    3.036560] OMAPFB: framebuffers registered
[    3.036590] OMAPFB: apply_changes, fb 0, ovl 0
[    3.036621] OMAPFB: setup_overlay 0, posx 0, posy 0, outw 1024, outh=
 768
[    3.036621] OMAPFB: paddr 9f600000
[    3.036682] OMAPFB: apply_changes, fb 1, ovl 1
[    3.036743] OMAPFB: apply_changes, fb 2, ovl 2
[    3.036834] OMAPFB: create_framebuffers done
[    3.036865] OMAPFB: mgr->apply'ed
[    3.039794] OMAPFB: create sysfs for fbs
[    3.039825] OMAPFB: create sysfs for fbs
[    3.041259] VDVI: incomplete constraints, leaving on
[    3.051971] twl_rtc twl_rtc: setting system clock to 2000-01-01
00:00:00 UTC (946684800)
[    3.065521] Waiting for root device /dev/mmcblk0p2...
[    3.222808] mmc1: host does not support reading read-only switch.
assuming write-enable.
[    3.231597] mmc1: new SDHC card at address e624
[    3.238830] mmcblk0: mmc1:e624 SU08G 7.40 GiB
[    3.255645]  mmcblk0: p1 p2
[    3.322967] EXT4-fs (mmcblk0p2): warning: maximal mount count
reached, running e2fsck is recommended
[    3.341094] EXT4-fs (mmcblk0p2): mounted filesystem with ordered
data mode. Opts: (null)
[    3.349884] VFS: Mounted root (ext4 filesystem) on device 179:2.
[    3.381835] devtmpfs: mounted
[    3.385833] Freeing init memory: 336K
[    4.150543] OMAPFB: pan_display(0)
[    4.150573] OMAPFB: setcmap
[    4.150573] OMAPFB: setcmap
[    4.161651] OMAPFB: user mmap region start 9f600000, len 1572864,
off 9f600000
>[    4.548126] udevd[780]: starting version 182
[    7.068847] omap-twl4030 omap-twl4030: ASoC: CPU DAI omap-mcbsp.2
not registered
[    7.076965] omap-twl4030 omap-twl4030: snd_soc_register_card() faile=
d: -517
[    7.084411] platform omap-twl4030: Driver omap-twl4030 requests
probe deferral
[    7.171356] omap-twl4030 omap-twl4030: ASoC: CODEC twl4030-codec
not registered
[    7.179565] omap-twl4030 omap-twl4030: snd_soc_register_card() faile=
d: -517
[    7.186950] platform omap-twl4030: Driver omap-twl4030 requests
probe deferral
[    7.387695] lib80211: common routines for IEEE802.11 drivers
[    7.394042] lib80211_crypt: registered algorithm 'NULL'
[    7.551940] omap-twl4030 omap-twl4030: ASoC: CODEC twl4030-codec
not registered
[    7.560028] omap-twl4030 omap-twl4030: snd_soc_register_card() faile=
d: -517
[    7.567504] platform omap-twl4030: Driver omap-twl4030 requests
probe deferral
[    8.216064] cfg80211: Calling CRDA to update world regulatory domain
[    8.364746] omap-twl4030 omap-twl4030:  twl4030-hifi <->
omap-mcbsp.2 mapping ok
[    8.573333] libertas_sdio: Libertas SDIO driver
[    8.578369] libertas_sdio: Copyright Pierre Ossman
[   11.256774] libertas_sdio: failed to find firmware (-2)
[   12.367126] EXT4-fs (mmcblk0p2): re-mounted. Opts: data=3Dordered
[   13.176910] smsc911x smsc911x.0 eth0: SMSC911x/921x identified at
0xe08c8000, IRQ: 290
[   24.423065] OMAPFB: check_var(0)
[   24.423156] OMAPFB: check_fb_var 0
[   24.423187] OMAPFB: max frame size 1572864, line size 2048
[   24.423187] OMAPFB: xres =3D 1024, yres =3D 768, vxres =3D 1024, vyr=
es =3D 768
[   24.423278] OMAPFB: set_par(0)
[   24.423278] OMAPFB: set_fb_fix
[   24.423278] OMAPFB: apply_changes, fb 0, ovl 0
[   24.423339] OMAPFB: setup_overlay 0, posx 0, posy 0, outw 1024, outh=
 768
[   24.423339] OMAPFB: paddr 9f600000
[   24.423858] OMAPFB: pan_display(0)
[   24.423858] OMAPFB: setcmap
[   24.423950] OMAPFB: pan_display(0)
[   24.423950] OMAPFB: setcmap
[   24.423950] OMAPFB: setcmap
[   24.433532] OMAPFB: setcmap
[   24.436462] OMAPFB: ioctl GET_CAPS
[   24.436676] OMAPFB: ioctl QUERY_MEM
[   24.445281] OMAPFB: user mmap region start 9f600000, len 1572864,
off 9f600000
[   24.547180] OMAPFB: ioctl QUERY_PLANE
[   24.547302] OMAPFB: ioctl SETUP_PLANE
[   24.547302] OMAPFB: omapfb_setup_plane
[   24.547424] OMAPFB: setup_overlay 0, posx 0, posy 0, outw 1024, outh=
 768
[   24.547424] OMAPFB: paddr 9f600000
[   24.547790]
[   24.547790] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[   24.547790] [ INFO: possible circular locking dependency detected ]
[   24.547821] 3.7.0-00017-g6c2ecfb-dirty #155 Not tainted
[   24.547821] -------------------------------------------------------
[   24.547821] Xorg/1277 is trying to acquire lock:
[   24.547882]  ((fb_notifier_list).rwsem){.+.+.+}, at: [<c0068708>]
__blocking_notifier_call_chain+0x30/0x60
[   24.547882]
[   24.547882] but task is already holding lock:
[   24.547912]  (console_lock){+.+.+.}, at: [<c02cec98>] do_fb_ioctl+0x=
200/0x5d8
[   24.547912]
[   24.547912] which lock already depends on the new lock.
[   24.547912]
[   24.547912]
[   24.547912] the existing dependency chain (in reverse order) is:
[   24.547943]
[   24.547943] -> #1 (console_lock){+.+.+.}:
[   24.547943]        [<c00902a4>] lock_acquire+0x9c/0x124
[   24.547973]        [<c0042b0c>] console_lock+0x50/0x64
[   24.548004]        [<c0320bcc>] register_con_driver+0x38/0x134
[   24.548004]        [<c032219c>] take_over_console+0x18/0x44
[   24.548034]        [<c02d7674>] fbcon_takeover+0x64/0xc8
[   24.548034]        [<c04f4dd4>] notifier_call_chain+0x44/0x84
[   24.548065]        [<c0068720>] __blocking_notifier_call_chain+0x48/=
0x60
[   24.548065]        [<c0068750>] blocking_notifier_call_chain+0x18/0x=
20
[   24.548095]        [<c02cf654>] register_framebuffer+0x16c/0x23c
[   24.548095]        [<c04ee990>] omapfb_create_framebuffers+0x520/0x7=
00
[   24.548126]        [<c0723480>] omapfb_probe+0x4e4/0x768
[   24.548126]        [<c03399f4>] platform_drv_probe+0x18/0x1c
[   24.548156]        [<c03387b0>] driver_probe_device+0x78/0x210
[   24.548187]        [<c03389dc>] __driver_attach+0x94/0x98
[   24.548187]        [<c03370b0>] bus_for_each_dev+0x50/0x7c
[   24.548187]        [<c0337fdc>] bus_add_driver+0x178/0x240
[   24.548217]        [<c0338eac>] driver_register+0x78/0x144
[   24.548217]        [<c0339be4>] platform_driver_probe+0x18/0x9c
[   24.548248]        [<c0722f70>] omapfb_init+0x28/0x54
[   24.548248]        [<c00086a4>] do_one_initcall+0x34/0x178
[   24.548278]        [<c04e47a8>] kernel_init+0x100/0x2b4
[   24.548309]        [<c0013170>] ret_from_fork+0x14/0x24
[   24.548309]
[   24.548309] -> #0 ((fb_notifier_list).rwsem){.+.+.+}:
[   24.548339]        [<c008f85c>] __lock_acquire+0x15e4/0x1b00
[   24.548339]        [<c00902a4>] lock_acquire+0x9c/0x124
[   24.548370]        [<c04f0eb8>] down_read+0x2c/0x3c
[   24.548370]        [<c0068708>] __blocking_notifier_call_chain+0x30/=
0x60
[   24.548370]        [<c0068750>] blocking_notifier_call_chain+0x18/0x=
20
[   24.548400]        [<c02ce1c0>] fb_blank+0x34/0x98
[   24.548400]        [<c02cecb0>] do_fb_ioctl+0x218/0x5d8
[   24.548431]        [<c0114924>] do_vfs_ioctl+0x80/0x5f0
[   24.548431]        [<c0114f04>] sys_ioctl+0x70/0x78
[   24.548461]        [<c00130c0>] ret_fast_syscall+0x0/0x3c
[   24.548461]
[   24.548461] other info that might help us debug this:
[   24.548461]
[   24.548461]  Possible unsafe locking scenario:
[   24.548461]
[   24.548461]        CPU0                    CPU1
[   24.548461]        ----                    ----
[   24.548492]   lock(console_lock);
[   24.548492]                                lock((fb_notifier_list).r=
wsem);
[   24.548492]                                lock(console_lock);
[   24.548522]   lock((fb_notifier_list).rwsem);
[   24.548522]
[   24.548522]  *** DEADLOCK ***
[   24.548522]
[   24.548522] 2 locks held by Xorg/1277:
[   24.548553]  #0:  (&fb_info->lock){+.+.+.}, at: [<c02cdf9c>]
lock_fb_info+0x18/0x3c
[   24.548583]  #1:  (console_lock){+.+.+.}, at: [<c02cec98>]
do_fb_ioctl+0x200/0x5d8
[   24.548583]
[   24.548583] stack backtrace:
[   24.548614] [<c001ac2c>] (unwind_backtrace+0x0/0xf0) from
[<c04eb508>] (print_circular_bug+0x278/0x2c4)
[   24.548614] [<c04eb508>] (print_circular_bug+0x278/0x2c4) from
[<c008f85c>] (__lock_acquire+0x15e4/0x1b00)
[   24.548645] [<c008f85c>] (__lock_acquire+0x15e4/0x1b00) from
[<c00902a4>] (lock_acquire+0x9c/0x124)
[   24.548675] [<c00902a4>] (lock_acquire+0x9c/0x124) from
[<c04f0eb8>] (down_read+0x2c/0x3c)
[   24.548675] [<c04f0eb8>] (down_read+0x2c/0x3c) from [<c0068708>]
(__blocking_notifier_call_chain+0x30/0x60)
[   24.548706] [<c0068708>] (__blocking_notifier_call_chain+0x30/0x60)
from [<c0068750>] (blocking_notifier_call_chain+0x18/0x20)
[   24.548706] [<c0068750>] (blocking_notifier_call_chain+0x18/0x20)
from [<c02ce1c0>] (fb_blank+0x34/0x98)
[   24.548736] [<c02ce1c0>] (fb_blank+0x34/0x98) from [<c02cecb0>]
(do_fb_ioctl+0x218/0x5d8)
[   24.548736] [<c02cecb0>] (do_fb_ioctl+0x218/0x5d8) from
[<c0114924>] (do_vfs_ioctl+0x80/0x5f0)
[   24.548767] [<c0114924>] (do_vfs_ioctl+0x80/0x5f0) from
[<c0114f04>] (sys_ioctl+0x70/0x78)
[   24.548797] [<c0114f04>] (sys_ioctl+0x70/0x78) from [<c00130c0>]
(ret_fast_syscall+0x0/0x3c)
[   25.008056] OMAPFB: ioctl QUERY_PLANE
[   25.011962] OMAPFB: ioctl SETUP_PLANE
[   25.015930] OMAPFB: omapfb_setup_plane
[   25.019897] omapdss OVERLAY error: check_overlay: paddr cannot be 0
[   25.026580] omapdss OVERLAY error: check_overlay: overlay 2 doesn't
support mode 0
[   25.034576] omapdss OVERLAY error: check_overlay: rotation type 0
not supported
[   25.044525] OMAPFB: ioctl QUERY_MEM
[   25.048339] OMAPFB: ioctl QUERY_PLANE
[   25.052215] OMAPFB: ioctl GET_CAPS
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

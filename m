From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] ARM: OMAP2+: clock: convert to common clock
 framework
Date: Tue, 13 Nov 2012 13:41:16 -0800
Message-ID: <20121113214115.GJ6801@atomide.com>
References: <alpine.DEB.2.00.1211131628410.22487@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="UfEAyuTBtIjiZzX6"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:59240 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751353Ab2KMVlT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Nov 2012 16:41:19 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1211131628410.22487@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org


--UfEAyuTBtIjiZzX6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Paul Walmsley <paul@pwsan.com> [121113 08:51]:
> Hi Tony
> 
> The following changes since commit c9d501e5cb0238910337213e12a09127221c35d8:
> 
>   Merge tag 'omap-cleanup-b2-for-3.8' of git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending into omap-for-v3.8/cleanup-prcm (2012-11-09 14:13:43 -0800)
> 
> are available in the git repository at:
> 
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending.git tags/omap-cleanup-c-for-3.8
> 
> for you to fetch changes up to f9ae32a74f0242cbef76d9baa10993d707be1714:
> 
>   ARM: OMAP2+: clock: Cleanup !CONFIG_COMMON_CLK parts (2012-11-12 19:18:51 -0700)
> 
> ----------------------------------------------------------------
> Convert the OMAP2+ clock code and data to rely on the common
> clock framework for internal bookkeeping and the driver API.

Thanks pulled into omap-for-v3.8/clock branch. I ended up pulling
it on top of a merge of omap-for-v3.8/cleanup-prcm and omap-for-v3.8/pm
as otherwise it would automatically resolve into a non-booting merge
with the pm branch as the smartreflex clocks were renamed.

Regards,

Tony

--UfEAyuTBtIjiZzX6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="zoom3.log"

Uncompressing Linux... done, booting the kernel.
[    0.000000] Booting Linux on physical CPU 0
[    0.000000] Linux version 3.7.0-rc2-00159-gd0bc267 (tmlind@muffinssi) (gcc version 4.3.5 (Debian 4.3.5-4) ) #408 SMP Tue Nov 13 10:25:19 PST 2012
[    0.000000] CPU: ARMv7 Processor [413fc082] revision 2 (ARMv7), cr=10c53c7d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
[    0.000000] Machine: OMAP Zoom3 board
[    0.000000] bootconsole [earlycon0] enabled
[    0.000000] Memory policy: ECC disabled, Data cache writeback
[    0.000000] On node 0 totalpages: 65280
[    0.000000] free_area_init_node: node 0, pgdat c077a200, node_mem_map c0cd6000
[    0.000000]   Normal zone: 512 pages used for memmap
[    0.000000]   Normal zone: 0 pages reserved
[    0.000000]   Normal zone: 64768 pages, LIFO batch:15
[    0.000000] OMAP3630 ES1.0 (l2cache iva sgx neon isp 192mhz_clk )
[    0.000000] Clocking rate (Crystal/Core/MPU): 26.0/400/600 MHz
[    0.000000] PERCPU: Embedded 9 pages/cpu @c0edc000 s12864 r8192 d15808 u36864
[    0.000000] pcpu-alloc: s12864 r8192 d15808 u36864 alloc=9*4096
[    0.000000] pcpu-alloc: [0] 0 
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 64768
[    0.000000] Kernel command line: console=ttyS0,115200n8 root=/dev/nfs ip=dhcp debug earlyprintk break=mount mem=256M
[    0.000000] PID hash table entries: 1024 (order: 0, 4096 bytes)
[    0.000000] Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
[    0.000000] Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
[    0.000000] Memory: 255MB = 255MB total
[    0.000000] Memory: 245664k/245664k available, 16480k reserved, 0K highmem
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
[    0.000000]     vmalloc : 0xd0800000 - 0xff000000   ( 744 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xd0000000   ( 256 MB)
[    0.000000]     pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
[    0.000000]     modules : 0xbf000000 - 0xbfe00000   (  14 MB)
[    0.000000]       .text : 0xc0008000 - 0xc0699be0   (6727 kB)
[    0.000000]       .init : 0xc069a000 - 0xc06ef240   ( 341 kB)
[    0.000000]       .data : 0xc06f0000 - 0xc077cd30   ( 564 kB)
[    0.000000]        .bss : 0xc077cd54 - 0xc0cd586c   (5475 kB)
[    0.000000] Hierarchical RCU implementation.
[    0.000000] 	RCU restricting CPUs from NR_CPUS=2 to nr_cpu_ids=1.
[    0.000000] NR_IRQS:16 nr_irqs:16 16
[    0.000000] IRQ: Found an INTC at 0xfa200000 (revision 4.0) with 96 interrupts
[    0.000000] Total of 96 interrupts on 1 active controller
[    0.000000] OMAP clockevent source: GPTIMER1 at 32768 Hz
[    0.000000] sched_clock: 32 bits at 32kHz, resolution 30517ns, wraps every 131071999ms
[    0.000000] OMAP clocksource: 32k_counter at 32768 Hz
[    0.000000] Console: colour dummy device 80x30
[    0.000000] Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
[    0.000000] ... MAX_LOCKDEP_SUBCLASSES:  8
[    0.000000] ... MAX_LOCK_DEPTH:          48
[    0.000000] ... MAX_LOCKDEP_KEYS:        8191
[    0.000000] ... CLASSHASH_SIZE:          4096
[    0.000000] ... MAX_LOCKDEP_ENTRIES:     16384
[    0.000000] ... MAX_LOCKDEP_CHAINS:      32768
[    0.000000] ... CHAINHASH_SIZE:          16384
[    0.000000]  memory used by lock dependency info: 3695 kB
[    0.000000]  per task-struct memory footprint: 1152 bytes
[    0.062255] Calibrating delay loop... 397.57 BogoMIPS (lpj=1554432)
[    0.129730] pid_max: default: 32768 minimum: 301
[    0.135162] Security Framework initialized
[    0.139617] Mount-cache hash table entries: 512
[    0.149383] CPU: Testing write buffer coherency: ok
[    0.155456] CPU0: thread -1, cpu 0, socket -1, mpidr 0
[    0.160919] Setting up static identity map for 0x804c01c8 - 0x804c0238
[    0.170471] Brought up 1 CPUs
[    0.173614] SMP: Total of 1 processors activated (397.57 BogoMIPS).
[    0.199127] omap_hwmod: mcbsp2: cannot be enabled for reset (3)
[    0.208557] pinctrl core: initialized pinctrl subsystem
[    0.221008] regulator-dummy: no parameters
[    0.227661] NET: Registered protocol family 16
[    0.233184] DMA: preallocated 256 KiB pool for atomic coherent allocations
[    0.242370] omap-gpmc omap-gpmc: GPMC revision 5.0
[    0.260070] gpiochip_add: registered GPIOs 0 to 31 on device: gpio
[    0.267059] OMAP GPIO hardware version 2.5
[    0.273895] gpiochip_add: registered GPIOs 32 to 63 on device: gpio
[    0.283050] gpiochip_add: registered GPIOs 64 to 95 on device: gpio
[    0.292480] gpiochip_add: registered GPIOs 96 to 127 on device: gpio
[    0.301574] gpiochip_add: registered GPIOs 128 to 159 on device: gpio
[    0.310821] gpiochip_add: registered GPIOs 160 to 191 on device: gpio
[    0.324798] omap_mux_init: Add partition: #1: core, flags: 0
[    0.340026] error setting wl12xx data: -38
[    0.355407] _omap_mux_get_by_name: Could not find signal uart4_rx.uart4_rx
[    0.371459] Reprogramming SDRC clock to 400000000 Hz
[    0.382690] hw-breakpoint: debug architecture 0x4 unsupported.
[    0.404510]  omap-mcbsp.2: alias fck already exists
[    0.410766]  omap-mcbsp.3: alias fck already exists
[    0.420166] OMAP DMA hardware revision 5.0
[    0.430084]  arm-pmu: alias fck already exists
[    0.512176] bio: create slab <bio-0> at 0
[    0.615173] omap-dma-engine omap-dma-engine: OMAP DMA engine driver
[    0.623229] fixed-dummy: no parameters
[    0.628784] vwl1271: 1800 mV 
[    0.638183] SCSI subsystem initialized
[    0.645019] usbcore: registered new interface driver usbfs
[    0.651611] usbcore: registered new interface driver hub
[    0.658020] usbcore: registered new device driver usb
[    0.695648] twl 1-0048: PIH (irq 23) chaining IRQs 338..346
[    0.702270] twl 1-0048: power (irq 343) chaining IRQs 346..353
[    0.711517] twl4030_gpio twl4030_gpio: gpio (irq 338) chaining IRQs 354..371
[    0.719635] gpiochip_find_base: found new base at 238
[    0.726226] gpiochip_add: registered GPIOs 238 to 255 on device: twl4030
[    0.734283] gpio_request: gpio-199 (lcd enable) status -517
[    0.740234] Failed to get LCD_PANEL_ENABLE_GPIO (gpio199).
[    0.746002] twl4030_gpio twl4030_gpio: setup --> -517
[    0.755157] VUSB1V5: 1500 mV normal standby
[    0.762237] VUSB1V8: 1800 mV normal standby
[    0.769104] VUSB3V1: 3100 mV normal standby
[    0.779663] twl4030_usb twl4030_usb: HW_CONDITIONS 0xe0/224; link 3
[    0.792327] twl4030_usb twl4030_usb: Initialized TWL4030 USB module
[    0.803314] vdd_mpu_iva: 600 <--> 1450 mV normal 
[    0.810638] vdd_core: 600 <--> 1450 mV normal 
[    0.818176] VMMC1: 1850 <--> 3150 mV at 3000 mV normal standby
[    0.827117] VDAC: 1800 mV normal standby
[    0.833923] VPLL2: 1800 mV normal standby
[    0.841491] VMMC2: 1850 mV normal standby
[    0.848663] VSIM: 1800 <--> 3000 mV at 1800 mV normal standby
[    0.855926] omap_i2c omap_i2c.1: bus 1 rev1.4.0 at 2400 kHz
[    0.878204] omap_i2c omap_i2c.2: bus 2 rev1.4.0 at 400 kHz
[    0.893768] omap_i2c omap_i2c.3: bus 3 rev1.4.0 at 400 kHz
[    0.907775] Switching to clocksource 32k_counter
[    1.032379] NET: Registered protocol family 2
[    1.039855] TCP established hash table entries: 8192 (order: 4, 65536 bytes)
[    1.047668] TCP bind hash table entries: 8192 (order: 6, 294912 bytes)
[    1.058593] TCP: Hash tables configured (established 8192 bind 8192)
[    1.065521] TCP: reno registered
[    1.068939] UDP hash table entries: 256 (order: 2, 20480 bytes)
[    1.075439] UDP-Lite hash table entries: 256 (order: 2, 20480 bytes)
[    1.083007] NET: Registered protocol family 1
[    1.089111] RPC: Registered named UNIX socket transport module.
[    1.095733] RPC: Registered udp transport module.
[    1.100646] RPC: Registered tcp transport module.
[    1.105621] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    1.112762] usbhs_omap usbhs_omap: xclk60mhsp2_ck set parentfailed error:-38
[    1.120544] ------------[ cut here ]------------
[    1.125396] WARNING: at drivers/clk/clk.c:512 __clk_enable+0x98/0xa4()
[    1.132171] Modules linked in:
[    1.135406] [<c001c3b0>] (unwind_backtrace+0x0/0xf4) from [<c004325c>] (warn_slowpath_common+0x4c/0x64)
[    1.145141] [<c004325c>] (warn_slowpath_common+0x4c/0x64) from [<c0043290>] (warn_slowpath_null+0x1c/0x24)
[    1.155120] [<c0043290>] (warn_slowpath_null+0x1c/0x24) from [<c03db4ac>] (__clk_enable+0x98/0xa4)
[    1.164428] [<c03db4ac>] (__clk_enable+0x98/0xa4) from [<c03db4d8>] (clk_enable+0x20/0x3c)
[    1.173004] [<c03db4d8>] (clk_enable+0x20/0x3c) from [<c02ef558>] (usbhs_runtime_resume+0x60/0xac)
[    1.182281] [<c02ef558>] (usbhs_runtime_resume+0x60/0xac) from [<c02da5ac>] (pm_generic_runtime_resume+0x30/0x40)
[    1.192901] [<c02da5ac>] (pm_generic_runtime_resume+0x30/0x40) from [<c02de818>] (__rpm_callback+0x60/0x80)
[    1.202972] [<c02de818>] (__rpm_callback+0x60/0x80) from [<c02df978>] (rpm_resume+0x3c4/0x638)
[    1.211883] [<c02df978>] (rpm_resume+0x3c4/0x638) from [<c02dfecc>] (__pm_runtime_resume+0x4c/0x68)
[    1.221252] [<c02dfecc>] (__pm_runtime_resume+0x4c/0x68) from [<c02ef6b4>] (omap_usbhs_init+0x58/0x278)
[    1.230987] [<c02ef6b4>] (omap_usbhs_init+0x58/0x278) from [<c04aa7c4>] (usbhs_omap_probe+0x2c4/0x458)
[    1.240631] [<c04aa7c4>] (usbhs_omap_probe+0x2c4/0x458) from [<c02d7588>] (platform_drv_probe+0x1c/0x24)
[    1.250457] [<c02d7588>] (platform_drv_probe+0x1c/0x24) from [<c02d6144>] (really_probe+0x60/0x1f4)
[    1.259826] [<c02d6144>] (really_probe+0x60/0x1f4) from [<c02d630c>] (driver_probe_device+0x34/0x50)
[    1.269287] [<c02d630c>] (driver_probe_device+0x34/0x50) from [<c02d63bc>] (__driver_attach+0x94/0x98)
[    1.278900] [<c02d63bc>] (__driver_attach+0x94/0x98) from [<c02d4968>] (bus_for_each_dev+0x60/0x8c)
[    1.288269] [<c02d4968>] (bus_for_each_dev+0x60/0x8c) from [<c02d5234>] (bus_add_driver+0x18c/0x254)
[    1.297729] [<c02d5234>] (bus_add_driver+0x18c/0x254) from [<c02d69b4>] (driver_register+0x5c/0x150)
[    1.307189] [<c02d69b4>] (driver_register+0x5c/0x150) from [<c02d7948>] (platform_driver_probe+0x1c/0xa4)
[    1.317108] [<c02d7948>] (platform_driver_probe+0x1c/0xa4) from [<c0008868>] (do_one_initcall+0x2c/0x178)
[    1.326995] [<c0008868>] (do_one_initcall+0x2c/0x178) from [<c069a2a0>] (do_basic_setup+0x94/0xd0)
[    1.336273] [<c069a2a0>] (do_basic_setup+0x94/0xd0) from [<c069a358>] (kernel_init_freeable+0x7c/0x124)
[    1.346008] [<c069a358>] (kernel_init_freeable+0x7c/0x124) from [<c04a4f4c>] (kernel_init+0x8/0x1a8)
[    1.355468] [<c04a4f4c>] (kernel_init+0x8/0x1a8) from [<c0014410>] (ret_from_fork+0x14/0x24)
[    1.364349] ---[ end trace 316da40a476f7d3c ]---
[    1.369171] ------------[ cut here ]------------
[    1.373992] WARNING: at drivers/clk/clk.c:512 __clk_enable+0x98/0xa4()
[    1.380767] Modules linked in:
[    1.384033] [<c001c3b0>] (unwind_backtrace+0x0/0xf4) from [<c004325c>] (warn_slowpath_common+0x4c/0x64)
[    1.393737] [<c004325c>] (warn_slowpath_common+0x4c/0x64) from [<c0043290>] (warn_slowpath_null+0x1c/0x24)
[    1.403747] [<c0043290>] (warn_slowpath_null+0x1c/0x24) from [<c03db4ac>] (__clk_enable+0x98/0xa4)
[    1.413024] [<c03db4ac>] (__clk_enable+0x98/0xa4) from [<c03db4d8>] (clk_enable+0x20/0x3c)
[    1.421569] [<c03db4d8>] (clk_enable+0x20/0x3c) from [<c02ef560>] (usbhs_runtime_resume+0x68/0xac)
[    1.430877] [<c02ef560>] (usbhs_runtime_resume+0x68/0xac) from [<c02da5ac>] (pm_generic_runtime_resume+0x30/0x40)
[    1.441467] [<c02da5ac>] (pm_generic_runtime_resume+0x30/0x40) from [<c02de818>] (__rpm_callback+0x60/0x80)
[    1.451568] [<c02de818>] (__rpm_callback+0x60/0x80) from [<c02df978>] (rpm_resume+0x3c4/0x638)
[    1.460479] [<c02df978>] (rpm_resume+0x3c4/0x638) from [<c02dfecc>] (__pm_runtime_resume+0x4c/0x68)
[    1.469848] [<c02dfecc>] (__pm_runtime_resume+0x4c/0x68) from [<c02ef6b4>] (omap_usbhs_init+0x58/0x278)
[    1.479583] [<c02ef6b4>] (omap_usbhs_init+0x58/0x278) from [<c04aa7c4>] (usbhs_omap_probe+0x2c4/0x458)
[    1.489227] [<c04aa7c4>] (usbhs_omap_probe+0x2c4/0x458) from [<c02d7588>] (platform_drv_probe+0x1c/0x24)
[    1.499023] [<c02d7588>] (platform_drv_probe+0x1c/0x24) from [<c02d6144>] (really_probe+0x60/0x1f4)
[    1.508392] [<c02d6144>] (really_probe+0x60/0x1f4) from [<c02d630c>] (driver_probe_device+0x34/0x50)
[    1.517852] [<c02d630c>] (driver_probe_device+0x34/0x50) from [<c02d63bc>] (__driver_attach+0x94/0x98)
[    1.527496] [<c02d63bc>] (__driver_attach+0x94/0x98) from [<c02d4968>] (bus_for_each_dev+0x60/0x8c)
[    1.536865] [<c02d4968>] (bus_for_each_dev+0x60/0x8c) from [<c02d5234>] (bus_add_driver+0x18c/0x254)
[    1.546325] [<c02d5234>] (bus_add_driver+0x18c/0x254) from [<c02d69b4>] (driver_register+0x5c/0x150)
[    1.555755] [<c02d69b4>] (driver_register+0x5c/0x150) from [<c02d7948>] (platform_driver_probe+0x1c/0xa4)
[    1.565673] [<c02d7948>] (platform_driver_probe+0x1c/0xa4) from [<c0008868>] (do_one_initcall+0x2c/0x178)
[    1.575561] [<c0008868>] (do_one_initcall+0x2c/0x178) from [<c069a2a0>] (do_basic_setup+0x94/0xd0)
[    1.584838] [<c069a2a0>] (do_basic_setup+0x94/0xd0) from [<c069a358>] (kernel_init_freeable+0x7c/0x124)
[    1.594573] [<c069a358>] (kernel_init_freeable+0x7c/0x124) from [<c04a4f4c>] (kernel_init+0x8/0x1a8)
[    1.604034] [<c04a4f4c>] (kernel_init+0x8/0x1a8) from [<c0014410>] (ret_from_fork+0x14/0x24)
[    1.612762] ---[ end trace 316da40a476f7d3d ]---
[    1.617706] ------------[ cut here ]------------
[    1.622528] WARNING: at drivers/clk/clk.c:471 clk_disable+0x20/0x34()
[    1.629211] Modules linked in:
[    1.632476] [<c001c3b0>] (unwind_backtrace+0x0/0xf4) from [<c004325c>] (warn_slowpath_common+0x4c/0x64)
[    1.642181] [<c004325c>] (warn_slowpath_common+0x4c/0x64) from [<c0043290>] (warn_slowpath_null+0x1c/0x24)
[    1.652191] [<c0043290>] (warn_slowpath_null+0x1c/0x24) from [<c03db400>] (clk_disable+0x20/0x34)
[    1.661376] [<c03db400>] (clk_disable+0x20/0x34) from [<c02ef5ec>] (usbhs_runtime_suspend+0x48/0xb8)
[    1.670837] [<c02ef5ec>] (usbhs_runtime_suspend+0x48/0xb8) from [<c02da56c>] (pm_generic_runtime_suspend+0x30/0x40)
[    1.681640] [<c02da56c>] (pm_generic_runtime_suspend+0x30/0x40) from [<c002c57c>] (_od_runtime_suspend+0x10/0x2c)
[    1.692230] [<c002c57c>] (_od_runtime_suspend+0x10/0x2c) from [<c02de818>] (__rpm_callback+0x60/0x80)
[    1.701782] [<c02de818>] (__rpm_callback+0x60/0x80) from [<c02deb6c>] (rpm_suspend+0xf0/0x5c8)
[    1.710723] [<c02deb6c>] (rpm_suspend+0xf0/0x5c8) from [<c02e015c>] (__pm_runtime_suspend+0x64/0x80)
[    1.720153] [<c02e015c>] (__pm_runtime_suspend+0x64/0x80) from [<c02dab00>] (pm_generic_runtime_idle+0x44/0x4c)
[    1.730590] [<c02dab00>] (pm_generic_runtime_idle+0x44/0x4c) from [<c02de818>] (__rpm_callback+0x60/0x80)
[    1.740509] [<c02de818>] (__rpm_callback+0x60/0x80) from [<c02df214>] (rpm_idle+0x164/0x21c)
[    1.749237] [<c02df214>] (rpm_idle+0x164/0x21c) from [<c02df3ac>] (__pm_runtime_idle+0x64/0x80)
[    1.758270] [<c02df3ac>] (__pm_runtime_idle+0x64/0x80) from [<c02ef714>] (omap_usbhs_init+0xb8/0x278)
[    1.767822] [<c02ef714>] (omap_usbhs_init+0xb8/0x278) from [<c04aa7c4>] (usbhs_omap_probe+0x2c4/0x458)
[    1.777435] [<c04aa7c4>] (usbhs_omap_probe+0x2c4/0x458) from [<c02d7588>] (platform_drv_probe+0x1c/0x24)
[    1.787261] [<c02d7588>] (platform_drv_probe+0x1c/0x24) from [<c02d6144>] (really_probe+0x60/0x1f4)
[    1.796630] [<c02d6144>] (really_probe+0x60/0x1f4) from [<c02d630c>] (driver_probe_device+0x34/0x50)
[    1.806091] [<c02d630c>] (driver_probe_device+0x34/0x50) from [<c02d63bc>] (__driver_attach+0x94/0x98)
[    1.815704] [<c02d63bc>] (__driver_attach+0x94/0x98) from [<c02d4968>] (bus_for_each_dev+0x60/0x8c)
[    1.825073] [<c02d4968>] (bus_for_each_dev+0x60/0x8c) from [<c02d5234>] (bus_add_driver+0x18c/0x254)
[    1.834533] [<c02d5234>] (bus_add_driver+0x18c/0x254) from [<c02d69b4>] (driver_register+0x5c/0x150)
[    1.843994] [<c02d69b4>] (driver_register+0x5c/0x150) from [<c02d7948>] (platform_driver_probe+0x1c/0xa4)
[    1.853881] [<c02d7948>] (platform_driver_probe+0x1c/0xa4) from [<c0008868>] (do_one_initcall+0x2c/0x178)
[    1.863800] [<c0008868>] (do_one_initcall+0x2c/0x178) from [<c069a2a0>] (do_basic_setup+0x94/0xd0)
[    1.873077] [<c069a2a0>] (do_basic_setup+0x94/0xd0) from [<c069a358>] (kernel_init_freeable+0x7c/0x124)
[    1.882812] [<c069a358>] (kernel_init_freeable+0x7c/0x124) from [<c04a4f4c>] (kernel_init+0x8/0x1a8)
[    1.892272] [<c04a4f4c>] (kernel_init+0x8/0x1a8) from [<c0014410>] (ret_from_fork+0x14/0x24)
[    1.901000] ---[ end trace 316da40a476f7d3e ]---
[    1.905822] ------------[ cut here ]------------
[    1.910644] WARNING: at drivers/clk/clk.c:471 clk_disable+0x20/0x34()
[    1.917327] Modules linked in:
[    1.920562] [<c001c3b0>] (unwind_backtrace+0x0/0xf4) from [<c004325c>] (warn_slowpath_common+0x4c/0x64)
[    1.930267] [<c004325c>] (warn_slowpath_common+0x4c/0x64) from [<c0043290>] (warn_slowpath_null+0x1c/0x24)
[    1.940277] [<c0043290>] (warn_slowpath_null+0x1c/0x24) from [<c03db400>] (clk_disable+0x20/0x34)
[    1.949462] [<c03db400>] (clk_disable+0x20/0x34) from [<c02ef5f4>] (usbhs_runtime_suspend+0x50/0xb8)
[    1.958923] [<c02ef5f4>] (usbhs_runtime_suspend+0x50/0xb8) from [<c02da56c>] (pm_generic_runtime_suspend+0x30/0x40)
[    1.969726] [<c02da56c>] (pm_generic_runtime_suspend+0x30/0x40) from [<c002c57c>] (_od_runtime_suspend+0x10/0x2c)
[    1.980316] [<c002c57c>] (_od_runtime_suspend+0x10/0x2c) from [<c02de818>] (__rpm_callback+0x60/0x80)
[    1.989868] [<c02de818>] (__rpm_callback+0x60/0x80) from [<c02deb6c>] (rpm_suspend+0xf0/0x5c8)
[    1.998809] [<c02deb6c>] (rpm_suspend+0xf0/0x5c8) from [<c02e015c>] (__pm_runtime_suspend+0x64/0x80)
[    2.008239] [<c02e015c>] (__pm_runtime_suspend+0x64/0x80) from [<c02dab00>] (pm_generic_runtime_idle+0x44/0x4c)
[    2.018676] [<c02dab00>] (pm_generic_runtime_idle+0x44/0x4c) from [<c02de818>] (__rpm_callback+0x60/0x80)
[    2.028594] [<c02de818>] (__rpm_callback+0x60/0x80) from [<c02df214>] (rpm_idle+0x164/0x21c)
[    2.037322] [<c02df214>] (rpm_idle+0x164/0x21c) from [<c02df3ac>] (__pm_runtime_idle+0x64/0x80)
[    2.046356] [<c02df3ac>] (__pm_runtime_idle+0x64/0x80) from [<c02ef714>] (omap_usbhs_init+0xb8/0x278)
[    2.055908] [<c02ef714>] (omap_usbhs_init+0xb8/0x278) from [<c04aa7c4>] (usbhs_omap_probe+0x2c4/0x458)
[    2.065521] [<c04aa7c4>] (usbhs_omap_probe+0x2c4/0x458) from [<c02d7588>] (platform_drv_probe+0x1c/0x24)
[    2.075347] [<c02d7588>] (platform_drv_probe+0x1c/0x24) from [<c02d6144>] (really_probe+0x60/0x1f4)
[    2.084716] [<c02d6144>] (really_probe+0x60/0x1f4) from [<c02d630c>] (driver_probe_device+0x34/0x50)
[    2.094177] [<c02d630c>] (driver_probe_device+0x34/0x50) from [<c02d63bc>] (__driver_attach+0x94/0x98)
[    2.103790] [<c02d63bc>] (__driver_attach+0x94/0x98) from [<c02d4968>] (bus_for_each_dev+0x60/0x8c)
[    2.113159] [<c02d4968>] (bus_for_each_dev+0x60/0x8c) from [<c02d5234>] (bus_add_driver+0x18c/0x254)
[    2.122619] [<c02d5234>] (bus_add_driver+0x18c/0x254) from [<c02d69b4>] (driver_register+0x5c/0x150)
[    2.132080] [<c02d69b4>] (driver_register+0x5c/0x150) from [<c02d7948>] (platform_driver_probe+0x1c/0xa4)
[    2.141998] [<c02d7948>] (platform_driver_probe+0x1c/0xa4) from [<c0008868>] (do_one_initcall+0x2c/0x178)
[    2.151885] [<c0008868>] (do_one_initcall+0x2c/0x178) from [<c069a2a0>] (do_basic_setup+0x94/0xd0)
[    2.161163] [<c069a2a0>] (do_basic_setup+0x94/0xd0) from [<c069a358>] (kernel_init_freeable+0x7c/0x124)
[    2.170898] [<c069a358>] (kernel_init_freeable+0x7c/0x124) from [<c04a4f4c>] (kernel_init+0x8/0x1a8)
[    2.180358] [<c04a4f4c>] (kernel_init+0x8/0x1a8) from [<c0014410>] (ret_from_fork+0x14/0x24)
[    2.189086] ---[ end trace 316da40a476f7d3f ]---
[    2.197967] NetWinder Floating Point Emulator V0.97 (double precision)
[    2.205230] CPU PMU: probing PMU on CPU 0
[    2.209594] hw perfevents: enabled with ARMv7 Cortex-A8 PMU driver, 5 counters available
[    2.404052] VFS: Disk quotas dquot_6.5.2
[    2.408660] Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
[    2.418060] NFS: Registering the id_resolver key type
[    2.424133] Key type id_resolver registered
[    2.428527] Key type id_legacy registered
[    2.432952] jffs2: version 2.2. (NAND) (SUMMARY)  
 2001-2006 Red Hat, Inc.
[    2.440979] msgmni has been set to 479
[    2.448974] io scheduler noop registered
[    2.453521] io scheduler deadline registered
[    2.458038] io scheduler cfq registered (default)
[    2.467285] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    2.505645] serial8250.0: ttyS0 at MMIO 0x10000000 (irq = 216) is a ST16654
[    2.513183] console [ttyS0] enabled, bootconsole disabled
[    2.513183] console [ttyS0] enabled, bootconsole disabled
[    2.527679] omap_uart.0: ttyO0 at MMIO 0x4806a000 (irq = 88) is a OMAP UART0
[    2.537017] omap_uart.1: ttyO1 at MMIO 0x4806c000 (irq = 89) is a OMAP UART1
[    2.545776] omap_uart.2: ttyO2 at MMIO 0x49020000 (irq = 90) is a OMAP UART2
[    2.554748] omap_uart.3: ttyO3 at MMIO 0x49042000 (irq = 96) is a OMAP UART3
[    2.598327] brd: module loaded
[    2.622497] loop: module loaded
[    2.634918] mtdoops: mtd device (mtddev=name/number) must be supplied
[    2.642333] NAND device: Manufacturer ID: 0x2c, Chip ID: 0xbc (Micron NAND 512MiB 1,8V 16-bit), page size: 2048, OOB size: 64
[    2.653808] Creating 7 MTD partitions on "omap2-nand.0":
[    2.659210] 0x000000000000-0x000000080000 : "X-Loader-NAND"
[    2.673370] 0x000000080000-0x0000001c0000 : "U-Boot-NAND"
[    2.684478] 0x0000001c0000-0x000000200000 : "Boot Env-NAND"
[    2.695251] 0x000000200000-0x000002000000 : "Kernel-NAND"
[    2.731567] 0x000002000000-0x00001c000000 : "system"
[    3.107940] 0x00001c000000-0x00001e000000 : "userdata"
[    3.145874] 0x00001e000000-0x000020000000 : "cache"
[    3.184326] OneNAND driver initializing
[    3.191589] omap-dma-engine omap-dma-engine: allocating channel for 40
[    3.198547] omap-dma-engine omap-dma-engine: allocating channel for 39
[    3.215881] smsc911x: Driver version 2008-10-21
[    3.229461] libphy: smsc911x-mdio: probed
[    3.234161] smsc911x smsc911x.0 eth0: attached PHY driver [SMSC LAN8700] (mii_bus:phy_addr=smsc911x-0:01, irq=-1)
[    3.244873] smsc911x smsc911x.0 eth0: MAC Address: 00:08:ee:03:7d:fb
[    3.252746] usbcore: registered new interface driver asix
[    3.258911] usbcore: registered new interface driver cdc_ether
[    3.265472] usbcore: registered new interface driver smsc95xx
[    3.271759] usbcore: registered new interface driver net1080
[    3.278228] usbcore: registered new interface driver cdc_subset
[    3.284942] usbcore: registered new interface driver zaurus
[    3.291320] usbcore: registered new interface driver cdc_ncm
[    3.298767] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    3.305480] ehci_hcd: block sizes: qh 60 qtd 96 itd 160 sitd 96
[    3.311950] ehci-omap ehci-omap.0: failed to get ehci port1 regulator
[    3.318542] ------------[ cut here ]------------
[    3.323181] WARNING: at drivers/clk/clk.c:512 __clk_enable+0x98/0xa4()
[    3.329711] Modules linked in:
[    3.332794] [<c001c3b0>] (unwind_backtrace+0x0/0xf4) from [<c004325c>] (warn_slowpath_common+0x4c/0x64)
[    3.342224] [<c004325c>] (warn_slowpath_common+0x4c/0x64) from [<c0043290>] (warn_slowpath_null+0x1c/0x24)
[    3.351867] [<c0043290>] (warn_slowpath_null+0x1c/0x24) from [<c03db4ac>] (__clk_enable+0x98/0xa4)
[    3.360870] [<c03db4ac>] (__clk_enable+0x98/0xa4) from [<c03db4d8>] (clk_enable+0x20/0x3c)
[    3.369140] [<c03db4d8>] (clk_enable+0x20/0x3c) from [<c02ef558>] (usbhs_runtime_resume+0x60/0xac)
[    3.378112] [<c02ef558>] (usbhs_runtime_resume+0x60/0xac) from [<c02da5ac>] (pm_generic_runtime_resume+0x30/0x40)
[    3.388397] [<c02da5ac>] (pm_generic_runtime_resume+0x30/0x40) from [<c02de818>] (__rpm_callback+0x60/0x80)
[    3.398162] [<c02de818>] (__rpm_callback+0x60/0x80) from [<c02df978>] (rpm_resume+0x3c4/0x638)
[    3.406768] [<c02df978>] (rpm_resume+0x3c4/0x638) from [<c02df8d0>] (rpm_resume+0x31c/0x638)
[    3.415222] [<c02df8d0>] (rpm_resume+0x31c/0x638) from [<c02dfecc>] (__pm_runtime_resume+0x4c/0x68)
[    3.424285] [<c02dfecc>] (__pm_runtime_resume+0x4c/0x68) from [<c0377020>] (ehci_hcd_omap_probe+0xfc/0x248)
[    3.434051] [<c0377020>] (ehci_hcd_omap_probe+0xfc/0x248) from [<c02d7588>] (platform_drv_probe+0x1c/0x24)
[    3.443725] [<c02d7588>] (platform_drv_probe+0x1c/0x24) from [<c02d6144>] (really_probe+0x60/0x1f4)
[    3.452789] [<c02d6144>] (really_probe+0x60/0x1f4) from [<c02d630c>] (driver_probe_device+0x34/0x50)
[    3.461914] [<c02d630c>] (driver_probe_device+0x34/0x50) from [<c02d63bc>] (__driver_attach+0x94/0x98)
[    3.471252] [<c02d63bc>] (__driver_attach+0x94/0x98) from [<c02d4968>] (bus_for_each_dev+0x60/0x8c)
[    3.480316] [<c02d4968>] (bus_for_each_dev+0x60/0x8c) from [<c02d5234>] (bus_add_driver+0x18c/0x254)
[    3.489440] [<c02d5234>] (bus_add_driver+0x18c/0x254) from [<c02d69b4>] (driver_register+0x5c/0x150)
[    3.498596] [<c02d69b4>] (driver_register+0x5c/0x150) from [<c06c4d7c>] (ehci_hcd_init+0xb0/0xfc)
[    3.507476] [<c06c4d7c>] (ehci_hcd_init+0xb0/0xfc) from [<c0008868>] (do_one_initcall+0x2c/0x178)
[    3.516357] [<c0008868>] (do_one_initcall+0x2c/0x178) from [<c069a2a0>] (do_basic_setup+0x94/0xd0)
[    3.525329] [<c069a2a0>] (do_basic_setup+0x94/0xd0) from [<c069a358>] (kernel_init_freeable+0x7c/0x124)
[    3.534759] [<c069a358>] (kernel_init_freeable+0x7c/0x124) from [<c04a4f4c>] (kernel_init+0x8/0x1a8)
[    3.543914] [<c04a4f4c>] (kernel_init+0x8/0x1a8) from [<c0014410>] (ret_from_fork+0x14/0x24)
[    3.552337] ---[ end trace 316da40a476f7d40 ]---
[    3.556976] ------------[ cut here ]------------
[    3.561584] WARNING: at drivers/clk/clk.c:512 __clk_enable+0x98/0xa4()
[    3.568115] Modules linked in:
[    3.571197] [<c001c3b0>] (unwind_backtrace+0x0/0xf4) from [<c004325c>] (warn_slowpath_common+0x4c/0x64)
[    3.580596] [<c004325c>] (warn_slowpath_common+0x4c/0x64) from [<c0043290>] (warn_slowpath_null+0x1c/0x24)
[    3.590270] [<c0043290>] (warn_slowpath_null+0x1c/0x24) from [<c03db4ac>] (__clk_enable+0x98/0xa4)
[    3.599243] [<c03db4ac>] (__clk_enable+0x98/0xa4) from [<c03db4d8>] (clk_enable+0x20/0x3c)
[    3.607543] [<c03db4d8>] (clk_enable+0x20/0x3c) from [<c02ef560>] (usbhs_runtime_resume+0x68/0xac)
[    3.616516] [<c02ef560>] (usbhs_runtime_resume+0x68/0xac) from [<c02da5ac>] (pm_generic_runtime_resume+0x30/0x40)
[    3.626770] [<c02da5ac>] (pm_generic_runtime_resume+0x30/0x40) from [<c02de818>] (__rpm_callback+0x60/0x80)
[    3.636535] [<c02de818>] (__rpm_callback+0x60/0x80) from [<c02df978>] (rpm_resume+0x3c4/0x638)
[    3.645141] [<c02df978>] (rpm_resume+0x3c4/0x638) from [<c02df8d0>] (rpm_resume+0x31c/0x638)
[    3.653594] [<c02df8d0>] (rpm_resume+0x31c/0x638) from [<c02dfecc>] (__pm_runtime_resume+0x4c/0x68)
[    3.662658] [<c02dfecc>] (__pm_runtime_resume+0x4c/0x68) from [<c0377020>] (ehci_hcd_omap_probe+0xfc/0x248)
[    3.672424] [<c0377020>] (ehci_hcd_omap_probe+0xfc/0x248) from [<c02d7588>] (platform_drv_probe+0x1c/0x24)
[    3.682098] [<c02d7588>] (platform_drv_probe+0x1c/0x24) from [<c02d6144>] (really_probe+0x60/0x1f4)
[    3.691131] [<c02d6144>] (really_probe+0x60/0x1f4) from [<c02d630c>] (driver_probe_device+0x34/0x50)
[    3.700286] [<c02d630c>] (driver_probe_device+0x34/0x50) from [<c02d63bc>] (__driver_attach+0x94/0x98)
[    3.709594] [<c02d63bc>] (__driver_attach+0x94/0x98) from [<c02d4968>] (bus_for_each_dev+0x60/0x8c)
[    3.718658] [<c02d4968>] (bus_for_each_dev+0x60/0x8c) from [<c02d5234>] (bus_add_driver+0x18c/0x254)
[    3.727813] [<c02d5234>] (bus_add_driver+0x18c/0x254) from [<c02d69b4>] (driver_register+0x5c/0x150)
[    3.736938] [<c02d69b4>] (driver_register+0x5c/0x150) from [<c06c4d7c>] (ehci_hcd_init+0xb0/0xfc)
[    3.745849] [<c06c4d7c>] (ehci_hcd_init+0xb0/0xfc) from [<c0008868>] (do_one_initcall+0x2c/0x178)
[    3.754730] [<c0008868>] (do_one_initcall+0x2c/0x178) from [<c069a2a0>] (do_basic_setup+0x94/0xd0)
[    3.763702] [<c069a2a0>] (do_basic_setup+0x94/0xd0) from [<c069a358>] (kernel_init_freeable+0x7c/0x124)
[    3.773101] [<c069a358>] (kernel_init_freeable+0x7c/0x124) from [<c04a4f4c>] (kernel_init+0x8/0x1a8)
[    3.782257] [<c04a4f4c>] (kernel_init+0x8/0x1a8) from [<c0014410>] (ret_from_fork+0x14/0x24)
[    3.790679] ---[ end trace 316da40a476f7d41 ]---
[    3.795440] ehci-omap ehci-omap.0: OMAP-EHCI Host Controller
[    3.804260] ehci-omap ehci-omap.0: new USB bus registered, assigned bus number 1
INFO: Turning off power...
[01;32m[
[01;33mlinux-2.6] $ 
[00m

--UfEAyuTBtIjiZzX6--

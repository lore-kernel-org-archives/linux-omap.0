From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH v2 00/26] Move OMAP2+ over to common clk framework
Date: Thu, 15 Nov 2012 01:57:19 +0100
Message-ID: <4680083.2GzMSfBq0I@avalon>
References: <1352337181-29427-1-git-send-email-mturquette@ti.com> <3718991.PIry3KaXBM@avalon> <20121113164323.20034.34462@nucleus>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="nextPart1559223.10XxXjCnj7"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:35245 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932299Ab2KOA4Z (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Nov 2012 19:56:25 -0500
In-Reply-To: <20121113164323.20034.34462@nucleus>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mike Turquette <mturquette@ti.com>
Cc: paul@pwsan.com, rnayak@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@vger.kernel.org, patches@linaro.org

This is a multi-part message in MIME format.

--nextPart1559223.10XxXjCnj7
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Mike,

On Tuesday 13 November 2012 08:43:23 Mike Turquette wrote:
> Quoting Laurent Pinchart (2012-11-13 05:42:35)
> > On Wednesday 07 November 2012 17:12:35 Mike Turquette wrote:
> > > From: Mike Turquette <mturquette@linaro.org>
> > > 
> > > Hi all,
> > > 
> > > This series is based on top of Paul's PRM/CM clean-up work.  It is a
> > > refresh of the patches Rajendra sent out a while back[1], with the
> > > addition of several fixes for PM regressions[2] across several
> > > platforms.
> > > 
> > > I have tested on OMAP4430 Panda including PRCM diffing against pre-CCF
> > > patches (delta is zero) and also suspend/resume.
> > > 
> > > I also tested on OMAP4460 Panda-ES.  Boot is fine and PRCM programming
> > > appears sane.  However Panda-ES never comes back from suspend/resume.
> > > This problem exists on the PRM/CM branch I based on and was not
> > > introduced by this series.  I am investigating that independently of
> > > this series.
> > > 
> > > Anyone wanting to pull the work can find it at:
> > > git://git.linaro.org/people/mturquette/linux.git clk-omap-3.8
> > > 
> > > [1] http://article.gmane.org/gmane.linux.ports.arm.omap/78771
> > > [2] http://article.gmane.org/gmane.linux.ports.arm.omap/84015
> > 
> > I've tested the whole series on a Beagleboard-xM. The kernel boots fine
> > but
> > spits a couple of WARN_ON due to missing clk_prepare in USB-related
> > drivers. I haven't noticed any regression in the OMAP3 ISP driver.
> 
> Those drivers need to be fixed.  Can you provide a log?

Complete boot log attached to this e-mail. My tree is based on your clk-
omap-3.8 branch in git://git.linaro.org/people/mturquette/linux.git. I haven't 
checked yet if patches for the following warnings have been posted to linux-
omap or other mailing lists.

> > I've also successfully tested rate back-propagation (CLK_SET_RATE_PARENT)
> > on the dpll4_m5x2_ck and cam_mclk clocks with the OMAP3 ISP driver. I'll
> > send a patch for that on top of your v3.
> 
> It is great to see this feature in action.  Do you think the OMAP3 ISP
> driver can have parent clock info removed?  The goal of the
> CLK_SET_RATE_PARENT flag is to make life easier for drivers by not
> having to know the details of the clock tree topology.

If you mean removing the explicit handling of dpll4_m5_ck and setting the 
cam_mclk rate directly then yes, that's the goal, and I'll submit patches for 
that when the successor to thiis patch series will reach mainline. If you mean 
something different please elaborate :-)

> > So,
> > 
> > Tested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> 
> Thanks for testing!

-- 
Regards,

Laurent Pinchart

--nextPart1559223.10XxXjCnj7
Content-Disposition: attachment; filename="clk-omap-3.8.log"
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-log; charset="UTF-8"; name="clk-omap-3.8.log"

[    0.000000] Booting Linux on physical CPU 0
[    0.000000] Linux version 3.7.0-rc2-00295-g2d0135b (laurent@avalon) =
(gcc version 4.4.1 ('cs2009q3-67-hard-sb4') ) #454 Thu Nov 15 01:52:32 =
CET 2012
[    0.000000] CPU: ARMv7 Processor [413fc082] revision 2 (ARMv7), cr=3D=
10c53c7d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing i=
nstruction cache
[    0.000000] Machine: OMAP3 Beagle Board
[    0.000000] Ignoring tag cmdline (using the default kernel command l=
ine)
[    0.000000] Reserving 16777216 bytes SDRAM for VRAM
[    0.000000] cma: CMA: reserved 16 MiB at 9dc00000
[    0.000000] Memory policy: ECC disabled, Data cache writeback
[    0.000000] OMAP3630 ES1.2 (l2cache iva sgx neon isp 192mhz_clk )
[    0.000000] Clocking rate (Crystal/Core/MPU): 26.0/332/600 MHz
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  =
Total pages: 125696
[    0.000000] Kernel command line: console=3DttyO2,115200 omapfb.mode=3D=
dvi:1024x768MR-32@60 omapdss.def_disp=3Ddvi
[    0.000000] PID hash table entries: 2048 (order: 1, 8192 bytes)
[    0.000000] Dentry cache hash table entries: 65536 (order: 6, 262144=
 bytes)
[    0.000000] Inode-cache hash table entries: 32768 (order: 5, 131072 =
bytes)
[    0.000000] Memory: 495MB =3D 495MB total
[    0.000000] Memory: 471724k/471724k available, 52564k reserved, 0K h=
ighmem
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
[    0.000000]     vmalloc : 0xe0800000 - 0xff000000   ( 488 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xe0000000   ( 512 MB)
[    0.000000]     pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
[    0.000000]     modules : 0xbf000000 - 0xbfe00000   (  14 MB)
[    0.000000]       .text : 0xc0008000 - 0xc0624dd0   (6260 kB)
[    0.000000]       .init : 0xc0625000 - 0xc065a300   ( 213 kB)
[    0.000000]       .data : 0xc065c000 - 0xc0815e50   (1768 kB)
[    0.000000]        .bss : 0xc0815e74 - 0xc0dd87c0   (5899 kB)
[    0.000000] NR_IRQS:16 nr_irqs:16 16
[    0.000000] IRQ: Found an INTC at 0xfa200000 (revision 4.0) with 96 =
interrupts
[    0.000000] Total of 96 interrupts on 1 active controller
[    0.000000] OMAP clockevent source: GPTIMER12 at 32768 Hz
[    0.000000] sched_clock: 32 bits at 32kHz, resolution 30517ns, wraps=
 every 131071999ms
[    0.000000] OMAP clocksource: 32k_counter at 32768 Hz
[    0.000000] Console: colour dummy device 80x30
[    0.000000] Lock dependency validator: Copyright (c) 2006 Red Hat, I=
nc., Ingo Molnar
[    0.000000] ... MAX_LOCKDEP_SUBCLASSES:  8
[    0.000000] ... MAX_LOCK_DEPTH:          48
[    0.000000] ... MAX_LOCKDEP_KEYS:        8191
[    0.000000] ... CLASSHASH_SIZE:          4096
[    0.000000] ... MAX_LOCKDEP_ENTRIES:     16384
[    0.000000] ... MAX_LOCKDEP_CHAINS:      32768
[    0.000000] ... CHAINHASH_SIZE:          16384
[    0.000000]  memory used by lock dependency info: 3951 kB
[    0.000000]  per task-struct memory footprint: 2304 bytes
[    0.001037] Calibrating delay loop... 309.35 BogoMIPS (lpj=3D1210368=
)
[    0.085479] pid_max: default: 32768 minimum: 301
[    0.085968] Security Framework initialized
[    0.086120] Mount-cache hash table entries: 512
[    0.091644] CPU: Testing write buffer coherency: ok
[    0.092742] Setting up static identity map for 0x80454970 - 0x804549=
c8
[    0.145568] pinctrl core: initialized pinctrl subsystem
[    0.154937] regulator-dummy: no parameters
[    0.158966] NET: Registered protocol family 16
[    0.167388] DMA: preallocated 256 KiB pool for atomic coherent alloc=
ations
[    0.170501] omap-gpmc omap-gpmc: GPMC revision 5.0
[    0.188903] OMAP GPIO hardware version 2.5
[    0.218780] omap_mux_init: Add partition: #1: core, flags: 0
[    0.222503] OMAP3 Beagle Rev: xM C
[    0.241485] _omap_mux_get_by_name: Could not find signal uart4_rx.ua=
rt4_rx
[    0.248382] Reprogramming SDRC clock to 332000000 Hz
[    0.254669] find_device_opp: Invalid parameters
[    0.254852] find_device_opp: Invalid parameters
[    0.254913] find_device_opp: Invalid parameters
[    0.254974] find_device_opp: Invalid parameters
[    0.255279] platform mpu.0: opp_set_availability: Device OPP not fou=
nd (-19)
[    0.255310] beagle_opp_init: failed to enable higher opp -19
[    0.255340] platform mpu.0: opp_set_availability: Device OPP not fou=
nd (-19)
[    0.255371] hw-breakpoint: debug architecture 0x4 unsupported.
[    0.282226] OMAP DMA hardware revision 5.0
[    0.290405]  arm-pmu: alias fck already exists
[    0.400115] bio: create slab <bio-0> at 0
[    0.544433] omap-dma-engine omap-dma-engine: OMAP DMA engine driver
[    0.553558] SCSI subsystem initialized
[    0.557891] usbcore: registered new interface driver usbfs
[    0.558776] usbcore: registered new interface driver hub
[    0.560089] usbcore: registered new device driver usb
[    0.562927] musb-omap2430 musb-omap2430: invalid resource
[    0.598785] twl 1-0048: PIH (irq 23) chaining IRQs 338..346
[    0.599578] twl 1-0048: power (irq 343) chaining IRQs 346..353
[    0.604217] twl4030_gpio twl4030_gpio: gpio (irq 338) chaining IRQs =
354..371
[    0.614929] VUSB1V5: 1500 mV normal standby
[    0.618560] VUSB1V8: 1800 mV normal standby
[    0.622131] VUSB3V1: 3100 mV normal standby
[    0.630798] twl4030_usb twl4030_usb: Initialized TWL4030 USB module
[    0.636505] vdd_mpu_iva: 600 <--> 1450 mV normal=20
[    0.639984] vdd_core: 600 <--> 1450 mV normal=20
[    0.644073] VMMC1: 1850 <--> 3150 mV at 3000 mV normal standby
[    0.647918] VDAC: 1800 mV normal standby
[    0.651733] VDVI: 1800 mV normal standby
[    0.656005] VSIM: 1800 <--> 3000 mV at 1800 mV normal standby
[    0.660705] VAUX3: 1800 mV normal standby
[    0.665435] VAUX4: 1800 mV normal standby
[    0.666839] omap_i2c omap_i2c.1: bus 1 rev1.4.0 at 2600 kHz
[    0.679962] omap_i2c omap_i2c.3: bus 3 rev1.4.0 at 100 kHz
[    0.681274] media: Linux media interface: v0.10
[    0.682159] Linux video capture interface: v2.00
[    0.688049] omap-iommu omap-iommu.0: isp registered
[    0.690521] Advanced Linux Sound Architecture Driver Initialized.
[    0.696594] Switching to clocksource 32k_counter
[    0.899322] NET: Registered protocol family 2
[    0.902099] TCP established hash table entries: 16384 (order: 5, 131=
072 bytes)
[    0.902862] TCP bind hash table entries: 16384 (order: 7, 720896 byt=
es)
[    0.912445] TCP: Hash tables configured (established 16384 bind 1638=
4)
[    0.912719] TCP: reno registered
[    0.912750] UDP hash table entries: 256 (order: 2, 24576 bytes)
[    0.913085] UDP-Lite hash table entries: 256 (order: 2, 24576 bytes)=

[    0.914337] NET: Registered protocol family 1
[    0.916259] RPC: Registered named UNIX socket transport module.
[    0.916290] RPC: Registered udp transport module.
[    0.916320] RPC: Registered tcp transport module.
[    0.916320] RPC: Registered tcp NFSv4.1 backchannel transport module=
.
[    0.916870] usbhs_omap usbhs_omap: xclk60mhsp2_ck set parentfailed e=
rror:-38
[    0.917388] ------------[ cut here ]------------
[    0.917419] WARNING: at drivers/clk/clk.c:512 __clk_enable+0x28/0x94=
()
[    0.917449] Modules linked in:
[    0.917480] [<c0018ac0>] (unwind_backtrace+0x0/0xec) from [<c0033e3c=
>] (warn_slowpath_common+0x4c/0x64)
[    0.917510] [<c0033e3c>] (warn_slowpath_common+0x4c/0x64) from [<c00=
33e6c>] (warn_slowpath_null+0x18/0x1c)
[    0.917541] [<c0033e6c>] (warn_slowpath_null+0x18/0x1c) from [<c0360=
6f4>] (__clk_enable+0x28/0x94)
[    0.917572] [<c03606f4>] (__clk_enable+0x28/0x94) from [<c0360780>] =
(clk_enable+0x20/0x3c)
[    0.917602] [<c0360780>] (clk_enable+0x20/0x3c) from [<c029f2b8>] (u=
sbhs_runtime_resume+0x74/0x90)
[    0.917633] [<c029f2b8>] (usbhs_runtime_resume+0x74/0x90) from [<c02=
8e8f0>] (pm_generic_runtime_resume+0x2c/0x38)
[    0.917663] [<c028e8f0>] (pm_generic_runtime_resume+0x2c/0x38) from =
[<c02922bc>] (__rpm_callback+0x30/0x58)
[    0.917663] [<c02922bc>] (__rpm_callback+0x30/0x58) from [<c02922fc>=
] (rpm_callback+0x18/0x28)
[    0.917694] [<c02922fc>] (rpm_callback+0x18/0x28) from [<c02931d8>] =
(rpm_resume+0x3b0/0x4cc)
[    0.917724] [<c02931d8>] (rpm_resume+0x3b0/0x4cc) from [<c0293558>] =
(__pm_runtime_resume+0x48/0x60)
[    0.917755] [<c0293558>] (__pm_runtime_resume+0x48/0x60) from [<c044=
5260>] (usbhs_omap_probe+0x3b4/0x810)
[    0.917785] [<c0445260>] (usbhs_omap_probe+0x3b4/0x810) from [<c028b=
e64>] (platform_drv_probe+0x18/0x1c)
[    0.917816] [<c028be64>] (platform_drv_probe+0x18/0x1c) from [<c028a=
ca4>] (driver_probe_device+0xb0/0x1e8)
[    0.917846] [<c028aca4>] (driver_probe_device+0xb0/0x1e8) from [<c02=
8ae44>] (__driver_attach+0x68/0x8c)
[    0.917846] [<c028ae44>] (__driver_attach+0x68/0x8c) from [<c0289728=
>] (bus_for_each_dev+0x44/0x74)
[    0.917877] [<c0289728>] (bus_for_each_dev+0x44/0x74) from [<c0289e1=
0>] (bus_add_driver+0xa0/0x218)
[    0.917907] [<c0289e10>] (bus_add_driver+0xa0/0x218) from [<c028b444=
>] (driver_register+0xa0/0x138)
[    0.917938] [<c028b444>] (driver_register+0xa0/0x138) from [<c028c12=
4>] (platform_driver_probe+0x18/0x8c)
[    0.917968] [<c028c124>] (platform_driver_probe+0x18/0x8c) from [<c0=
008840>] (do_one_initcall+0x94/0x168)
[    0.917968] [<c0008840>] (do_one_initcall+0x94/0x168) from [<c044074=
4>] (kernel_init+0xd8/0x2a0)
[    0.917999] [<c0440744>] (kernel_init+0xd8/0x2a0) from [<c0012a90>] =
(ret_from_fork+0x14/0x24)
[    0.918182] ---[ end trace 0eaa05360b28dfab ]---
[    0.918212] ------------[ cut here ]------------
[    0.918212] WARNING: at drivers/clk/clk.c:512 __clk_enable+0x28/0x94=
()
[    0.918243] Modules linked in:
[    0.918273] [<c0018ac0>] (unwind_backtrace+0x0/0xec) from [<c0033e3c=
>] (warn_slowpath_common+0x4c/0x64)
[    0.918273] [<c0033e3c>] (warn_slowpath_common+0x4c/0x64) from [<c00=
33e6c>] (warn_slowpath_null+0x18/0x1c)
[    0.918304] [<c0033e6c>] (warn_slowpath_null+0x18/0x1c) from [<c0360=
6f4>] (__clk_enable+0x28/0x94)
[    0.918334] [<c03606f4>] (__clk_enable+0x28/0x94) from [<c0360780>] =
(clk_enable+0x20/0x3c)
[    0.918365] [<c0360780>] (clk_enable+0x20/0x3c) from [<c029f2c0>] (u=
sbhs_runtime_resume+0x7c/0x90)
[    0.918395] [<c029f2c0>] (usbhs_runtime_resume+0x7c/0x90) from [<c02=
8e8f0>] (pm_generic_runtime_resume+0x2c/0x38)
[    0.918395] [<c028e8f0>] (pm_generic_runtime_resume+0x2c/0x38) from =
[<c02922bc>] (__rpm_callback+0x30/0x58)
[    0.918426] [<c02922bc>] (__rpm_callback+0x30/0x58) from [<c02922fc>=
] (rpm_callback+0x18/0x28)
[    0.918457] [<c02922fc>] (rpm_callback+0x18/0x28) from [<c02931d8>] =
(rpm_resume+0x3b0/0x4cc)
[    0.918487] [<c02931d8>] (rpm_resume+0x3b0/0x4cc) from [<c0293558>] =
(__pm_runtime_resume+0x48/0x60)
[    0.918518] [<c0293558>] (__pm_runtime_resume+0x48/0x60) from [<c044=
5260>] (usbhs_omap_probe+0x3b4/0x810)
[    0.918518] [<c0445260>] (usbhs_omap_probe+0x3b4/0x810) from [<c028b=
e64>] (platform_drv_probe+0x18/0x1c)
[    0.918548] [<c028be64>] (platform_drv_probe+0x18/0x1c) from [<c028a=
ca4>] (driver_probe_device+0xb0/0x1e8)
[    0.918579] [<c028aca4>] (driver_probe_device+0xb0/0x1e8) from [<c02=
8ae44>] (__driver_attach+0x68/0x8c)
[    0.918609] [<c028ae44>] (__driver_attach+0x68/0x8c) from [<c0289728=
>] (bus_for_each_dev+0x44/0x74)
[    0.918640] [<c0289728>] (bus_for_each_dev+0x44/0x74) from [<c0289e1=
0>] (bus_add_driver+0xa0/0x218)
[    0.918640] [<c0289e10>] (bus_add_driver+0xa0/0x218) from [<c028b444=
>] (driver_register+0xa0/0x138)
[    0.918670] [<c028b444>] (driver_register+0xa0/0x138) from [<c028c12=
4>] (platform_driver_probe+0x18/0x8c)
[    0.918701] [<c028c124>] (platform_driver_probe+0x18/0x8c) from [<c0=
008840>] (do_one_initcall+0x94/0x168)
[    0.918731] [<c0008840>] (do_one_initcall+0x94/0x168) from [<c044074=
4>] (kernel_init+0xd8/0x2a0)
[    0.918762] [<c0440744>] (kernel_init+0xd8/0x2a0) from [<c0012a90>] =
(ret_from_fork+0x14/0x24)
[    0.918762] ---[ end trace 0eaa05360b28dfac ]---
[    0.918823] ------------[ cut here ]------------
[    0.918853] WARNING: at drivers/clk/clk.c:471 clk_disable+0x20/0x34(=
)
[    0.918853] Modules linked in:
[    0.918884] [<c0018ac0>] (unwind_backtrace+0x0/0xec) from [<c0033e3c=
>] (warn_slowpath_common+0x4c/0x64)
[    0.918914] [<c0033e3c>] (warn_slowpath_common+0x4c/0x64) from [<c00=
33e6c>] (warn_slowpath_null+0x18/0x1c)
[    0.918945] [<c0033e6c>] (warn_slowpath_null+0x18/0x1c) from [<c0360=
6b8>] (clk_disable+0x20/0x34)
[    0.918945] [<c03606b8>] (clk_disable+0x20/0x34) from [<c029f32c>] (=
usbhs_runtime_suspend+0x58/0x90)
[    0.918975] [<c029f32c>] (usbhs_runtime_suspend+0x58/0x90) from [<c0=
28e8b8>] (pm_generic_runtime_suspend+0x2c/0x38)
[    0.919006] [<c028e8b8>] (pm_generic_runtime_suspend+0x2c/0x38) from=
 [<c00246b0>] (_od_runtime_suspend+0xc/0x24)
[    0.919036] [<c00246b0>] (_od_runtime_suspend+0xc/0x24) from [<c0292=
2bc>] (__rpm_callback+0x30/0x58)
[    0.919067] [<c02922bc>] (__rpm_callback+0x30/0x58) from [<c02922fc>=
] (rpm_callback+0x18/0x28)
[    0.919067] [<c02922fc>] (rpm_callback+0x18/0x28) from [<c02927a4>] =
(rpm_suspend+0x28c/0x45c)
[    0.919097] [<c02927a4>] (rpm_suspend+0x28c/0x45c) from [<c02937a4>]=
 (__pm_runtime_suspend+0x54/0x6c)
[    0.919128] [<c02937a4>] (__pm_runtime_suspend+0x54/0x6c) from [<c02=
8eda8>] (pm_generic_runtime_idle+0x44/0x4c)
[    0.919158] [<c028eda8>] (pm_generic_runtime_idle+0x44/0x4c) from [<=
c02922bc>] (__rpm_callback+0x30/0x58)
[    0.919189] [<c02922bc>] (__rpm_callback+0x30/0x58) from [<c0292b64>=
] (rpm_idle+0x184/0x208)
[    0.919189] [<c0292b64>] (rpm_idle+0x184/0x208) from [<c0292c9c>] (_=
_pm_runtime_idle+0x54/0x6c)
[    0.919219] [<c0292c9c>] (__pm_runtime_idle+0x54/0x6c) from [<c04453=
c4>] (usbhs_omap_probe+0x518/0x810)
[    0.919250] [<c04453c4>] (usbhs_omap_probe+0x518/0x810) from [<c028b=
e64>] (platform_drv_probe+0x18/0x1c)
[    0.919281] [<c028be64>] (platform_drv_probe+0x18/0x1c) from [<c028a=
ca4>] (driver_probe_device+0xb0/0x1e8)
[    0.919311] [<c028aca4>] (driver_probe_device+0xb0/0x1e8) from [<c02=
8ae44>] (__driver_attach+0x68/0x8c)
[    0.919311] [<c028ae44>] (__driver_attach+0x68/0x8c) from [<c0289728=
>] (bus_for_each_dev+0x44/0x74)
[    0.919342] [<c0289728>] (bus_for_each_dev+0x44/0x74) from [<c0289e1=
0>] (bus_add_driver+0xa0/0x218)
[    0.919372] [<c0289e10>] (bus_add_driver+0xa0/0x218) from [<c028b444=
>] (driver_register+0xa0/0x138)
[    0.919403] [<c028b444>] (driver_register+0xa0/0x138) from [<c028c12=
4>] (platform_driver_probe+0x18/0x8c)
[    0.919433] [<c028c124>] (platform_driver_probe+0x18/0x8c) from [<c0=
008840>] (do_one_initcall+0x94/0x168)
[    0.919433] [<c0008840>] (do_one_initcall+0x94/0x168) from [<c044074=
4>] (kernel_init+0xd8/0x2a0)
[    0.919464] [<c0440744>] (kernel_init+0xd8/0x2a0) from [<c0012a90>] =
(ret_from_fork+0x14/0x24)
[    0.919494] ---[ end trace 0eaa05360b28dfad ]---
[    0.919494] ------------[ cut here ]------------
[    0.919525] WARNING: at drivers/clk/clk.c:471 clk_disable+0x20/0x34(=
)
[    0.919525] Modules linked in:
[    0.919555] [<c0018ac0>] (unwind_backtrace+0x0/0xec) from [<c0033e3c=
>] (warn_slowpath_common+0x4c/0x64)
[    0.919586] [<c0033e3c>] (warn_slowpath_common+0x4c/0x64) from [<c00=
33e6c>] (warn_slowpath_null+0x18/0x1c)
[    0.919586] [<c0033e6c>] (warn_slowpath_null+0x18/0x1c) from [<c0360=
6b8>] (clk_disable+0x20/0x34)
[    0.919616] [<c03606b8>] (clk_disable+0x20/0x34) from [<c029f334>] (=
usbhs_runtime_suspend+0x60/0x90)
[    0.919647] [<c029f334>] (usbhs_runtime_suspend+0x60/0x90) from [<c0=
28e8b8>] (pm_generic_runtime_suspend+0x2c/0x38)
[    0.919677] [<c028e8b8>] (pm_generic_runtime_suspend+0x2c/0x38) from=
 [<c00246b0>] (_od_runtime_suspend+0xc/0x24)
[    0.919677] [<c00246b0>] (_od_runtime_suspend+0xc/0x24) from [<c0292=
2bc>] (__rpm_callback+0x30/0x58)
[    0.919708] [<c02922bc>] (__rpm_callback+0x30/0x58) from [<c02922fc>=
] (rpm_callback+0x18/0x28)
[    0.919738] [<c02922fc>] (rpm_callback+0x18/0x28) from [<c02927a4>] =
(rpm_suspend+0x28c/0x45c)
[    0.919769] [<c02927a4>] (rpm_suspend+0x28c/0x45c) from [<c02937a4>]=
 (__pm_runtime_suspend+0x54/0x6c)
[    0.919799] [<c02937a4>] (__pm_runtime_suspend+0x54/0x6c) from [<c02=
8eda8>] (pm_generic_runtime_idle+0x44/0x4c)
[    0.919799] [<c028eda8>] (pm_generic_runtime_idle+0x44/0x4c) from [<=
c02922bc>] (__rpm_callback+0x30/0x58)
[    0.919830] [<c02922bc>] (__rpm_callback+0x30/0x58) from [<c0292b64>=
] (rpm_idle+0x184/0x208)
[    0.919860] [<c0292b64>] (rpm_idle+0x184/0x208) from [<c0292c9c>] (_=
_pm_runtime_idle+0x54/0x6c)
[    0.919891] [<c0292c9c>] (__pm_runtime_idle+0x54/0x6c) from [<c04453=
c4>] (usbhs_omap_probe+0x518/0x810)
[    0.919921] [<c04453c4>] (usbhs_omap_probe+0x518/0x810) from [<c028b=
e64>] (platform_drv_probe+0x18/0x1c)
[    0.919921] [<c028be64>] (platform_drv_probe+0x18/0x1c) from [<c028a=
ca4>] (driver_probe_device+0xb0/0x1e8)
[    0.919952] [<c028aca4>] (driver_probe_device+0xb0/0x1e8) from [<c02=
8ae44>] (__driver_attach+0x68/0x8c)
[    0.919982] [<c028ae44>] (__driver_attach+0x68/0x8c) from [<c0289728=
>] (bus_for_each_dev+0x44/0x74)
[    0.920013] [<c0289728>] (bus_for_each_dev+0x44/0x74) from [<c0289e1=
0>] (bus_add_driver+0xa0/0x218)
[    0.920043] [<c0289e10>] (bus_add_driver+0xa0/0x218) from [<c028b444=
>] (driver_register+0xa0/0x138)
[    0.920043] [<c028b444>] (driver_register+0xa0/0x138) from [<c028c12=
4>] (platform_driver_probe+0x18/0x8c)
[    0.920074] [<c028c124>] (platform_driver_probe+0x18/0x8c) from [<c0=
008840>] (do_one_initcall+0x94/0x168)
[    0.920104] [<c0008840>] (do_one_initcall+0x94/0x168) from [<c044074=
4>] (kernel_init+0xd8/0x2a0)
[    0.920135] [<c0440744>] (kernel_init+0xd8/0x2a0) from [<c0012a90>] =
(ret_from_fork+0x14/0x24)
[    0.920135] ---[ end trace 0eaa05360b28dfae ]---
[    0.926208] NetWinder Floating Point Emulator V0.97 (double precisio=
n)
[    0.926727] CPU PMU: probing PMU on CPU 0
[    0.926910] hw perfevents: enabled with ARMv7 Cortex-A8 PMU driver, =
5 counters available
[    1.136230] VFS: Disk quotas dquot_6.5.2
[    1.136352] Dquot-cache hash table entries: 1024 (order 0, 4096 byte=
s)
[    1.139221] NFS: Registering the id_resolver key type
[    1.139862] Key type id_resolver registered
[    1.139892] Key type id_legacy registered
[    1.140136] jffs2: version 2.2. (NAND) (SUMMARY)  =EF=BF=BD=C2=A9 20=
01-2006 Red Hat, Inc.
[    1.140930] msgmni has been set to 953
[    1.149475] io scheduler noop registered
[    1.149505] io scheduler deadline registered
[    1.149658] io scheduler cfq registered (default)
[    1.158386] OMAP DSS rev 2.0
[    1.177276] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    1.188354] omap_uart.0: ttyO0 at MMIO 0x4806a000 (irq =3D 88) is a =
OMAP UART0
[    1.191680] omap_uart.2: ttyO2 at MMIO 0x49020000 (irq =3D 90) is a =
OMAP UART2
[    2.921600] console [ttyO2] enabled
[    2.928222] omap_uart.3: ttyO3 at MMIO 0x49042000 (irq =3D 96) is a =
OMAP UART3
[    2.987121] brd: module loaded
[    3.018829] loop: module loaded
[    3.028900] mtdoops: mtd device (mtddev=3Dname/number) must be suppl=
ied
[    3.036804] No NAND device found
[    3.040374] No NAND device found
[    3.045074] OneNAND driver initializing
[    3.066711] usbcore: registered new interface driver asix
[    3.073333] usbcore: registered new interface driver cdc_ether
[    3.080474] usbcore: registered new interface driver smsc95xx
[    3.087554] usbcore: registered new interface driver cdc_ncm
[    3.096282] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driv=
er
[    3.104125] ------------[ cut here ]------------
[    3.108978] WARNING: at drivers/clk/clk.c:512 __clk_enable+0x28/0x94=
()
[    3.115814] Modules linked in:
[    3.119018] [<c0018ac0>] (unwind_backtrace+0x0/0xec) from [<c0033e3c=
>] (warn_slowpath_common+0x4c/0x64)
[    3.128845] [<c0033e3c>] (warn_slowpath_common+0x4c/0x64) from [<c00=
33e6c>] (warn_slowpath_null+0x18/0x1c)
[    3.138946] [<c0033e6c>] (warn_slowpath_null+0x18/0x1c) from [<c0360=
6f4>] (__clk_enable+0x28/0x94)
[    3.148315] [<c03606f4>] (__clk_enable+0x28/0x94) from [<c0360780>] =
(clk_enable+0x20/0x3c)
[    3.156951] [<c0360780>] (clk_enable+0x20/0x3c) from [<c029f2b8>] (u=
sbhs_runtime_resume+0x74/0x90)
[    3.166320] [<c029f2b8>] (usbhs_runtime_resume+0x74/0x90) from [<c02=
8e8f0>] (pm_generic_runtime_resume+0x2c/0x38)
[    3.177062] [<c028e8f0>] (pm_generic_runtime_resume+0x2c/0x38) from =
[<c02922bc>] (__rpm_callback+0x30/0x58)
[    3.187225] [<c02922bc>] (__rpm_callback+0x30/0x58) from [<c02922fc>=
] (rpm_callback+0x18/0x28)
[    3.196258] [<c02922fc>] (rpm_callback+0x18/0x28) from [<c02931d8>] =
(rpm_resume+0x3b0/0x4cc)
[    3.205078] [<c02931d8>] (rpm_resume+0x3b0/0x4cc) from [<c0293104>] =
(rpm_resume+0x2dc/0x4cc)
[    3.213897] [<c0293104>] (rpm_resume+0x2dc/0x4cc) from [<c0293558>] =
(__pm_runtime_resume+0x48/0x60)
[    3.223358] [<c0293558>] (__pm_runtime_resume+0x48/0x60) from [<c030=
ad1c>] (ehci_hcd_omap_probe+0x194/0x220)
[    3.233642] [<c030ad1c>] (ehci_hcd_omap_probe+0x194/0x220) from [<c0=
28be64>] (platform_drv_probe+0x18/0x1c)
[    3.243835] [<c028be64>] (platform_drv_probe+0x18/0x1c) from [<c028a=
ca4>] (driver_probe_device+0xb0/0x1e8)
[    3.253906] [<c028aca4>] (driver_probe_device+0xb0/0x1e8) from [<c02=
8ae44>] (__driver_attach+0x68/0x8c)
[    3.263732] [<c028ae44>] (__driver_attach+0x68/0x8c) from [<c0289728=
>] (bus_for_each_dev+0x44/0x74)
[    3.273193] [<c0289728>] (bus_for_each_dev+0x44/0x74) from [<c0289e1=
0>] (bus_add_driver+0xa0/0x218)
[    3.282653] [<c0289e10>] (bus_add_driver+0xa0/0x218) from [<c028b444=
>] (driver_register+0xa0/0x138)
[    3.292114] [<c028b444>] (driver_register+0xa0/0x138) from [<c064429=
8>] (ehci_hcd_init+0xac/0x108)
[    3.301483] [<c0644298>] (ehci_hcd_init+0xac/0x108) from [<c0008840>=
] (do_one_initcall+0x94/0x168)
[    3.310852] [<c0008840>] (do_one_initcall+0x94/0x168) from [<c044074=
4>] (kernel_init+0xd8/0x2a0)
[    3.320037] [<c0440744>] (kernel_init+0xd8/0x2a0) from [<c0012a90>] =
(ret_from_fork+0x14/0x24)
[    3.328948] ---[ end trace 0eaa05360b28dfaf ]---
[    3.333770] ------------[ cut here ]------------
[    3.338592] WARNING: at drivers/clk/clk.c:512 __clk_enable+0x28/0x94=
()
[    3.345397] Modules linked in:
[    3.348602] [<c0018ac0>] (unwind_backtrace+0x0/0xec) from [<c0033e3c=
>] (warn_slowpath_common+0x4c/0x64)
[    3.358428] [<c0033e3c>] (warn_slowpath_common+0x4c/0x64) from [<c00=
33e6c>] (warn_slowpath_null+0x18/0x1c)
[    3.368530] [<c0033e6c>] (warn_slowpath_null+0x18/0x1c) from [<c0360=
6f4>] (__clk_enable+0x28/0x94)
[    3.377899] [<c03606f4>] (__clk_enable+0x28/0x94) from [<c0360780>] =
(clk_enable+0x20/0x3c)
[    3.386535] [<c0360780>] (clk_enable+0x20/0x3c) from [<c029f2c0>] (u=
sbhs_runtime_resume+0x7c/0x90)
[    3.395904] [<c029f2c0>] (usbhs_runtime_resume+0x7c/0x90) from [<c02=
8e8f0>] (pm_generic_runtime_resume+0x2c/0x38)
[    3.406616] [<c028e8f0>] (pm_generic_runtime_resume+0x2c/0x38) from =
[<c02922bc>] (__rpm_callback+0x30/0x58)
[    3.416809] [<c02922bc>] (__rpm_callback+0x30/0x58) from [<c02922fc>=
] (rpm_callback+0x18/0x28)
[    3.425811] [<c02922fc>] (rpm_callback+0x18/0x28) from [<c02931d8>] =
(rpm_resume+0x3b0/0x4cc)
[    3.434631] [<c02931d8>] (rpm_resume+0x3b0/0x4cc) from [<c0293104>] =
(rpm_resume+0x2dc/0x4cc)
[    3.443450] [<c0293104>] (rpm_resume+0x2dc/0x4cc) from [<c0293558>] =
(__pm_runtime_resume+0x48/0x60)
[    3.452911] [<c0293558>] (__pm_runtime_resume+0x48/0x60) from [<c030=
ad1c>] (ehci_hcd_omap_probe+0x194/0x220)
[    3.463195] [<c030ad1c>] (ehci_hcd_omap_probe+0x194/0x220) from [<c0=
28be64>] (platform_drv_probe+0x18/0x1c)
[    3.473358] [<c028be64>] (platform_drv_probe+0x18/0x1c) from [<c028a=
ca4>] (driver_probe_device+0xb0/0x1e8)
[    3.483459] [<c028aca4>] (driver_probe_device+0xb0/0x1e8) from [<c02=
8ae44>] (__driver_attach+0x68/0x8c)
[    3.493286] [<c028ae44>] (__driver_attach+0x68/0x8c) from [<c0289728=
>] (bus_for_each_dev+0x44/0x74)
[    3.502716] [<c0289728>] (bus_for_each_dev+0x44/0x74) from [<c0289e1=
0>] (bus_add_driver+0xa0/0x218)
[    3.512176] [<c0289e10>] (bus_add_driver+0xa0/0x218) from [<c028b444=
>] (driver_register+0xa0/0x138)
[    3.521636] [<c028b444>] (driver_register+0xa0/0x138) from [<c064429=
8>] (ehci_hcd_init+0xac/0x108)
[    3.531005] [<c0644298>] (ehci_hcd_init+0xac/0x108) from [<c0008840>=
] (do_one_initcall+0x94/0x168)
[    3.540374] [<c0008840>] (do_one_initcall+0x94/0x168) from [<c044074=
4>] (kernel_init+0xd8/0x2a0)
[    3.549560] [<c0440744>] (kernel_init+0xd8/0x2a0) from [<c0012a90>] =
(ret_from_fork+0x14/0x24)
[    3.558441] ---[ end trace 0eaa05360b28dfb0 ]---
[    3.563446] ehci-omap ehci-omap.0: OMAP-EHCI Host Controller
[    3.573059] ehci-omap ehci-omap.0: new USB bus registered, assigned =
bus number 1
[    4.618804] ehci-omap ehci-omap.0: irq 93, io mem 0x48064800
[    4.634338] ehci-omap ehci-omap.0: USB 2.0 started, EHCI 1.00
[    4.641845] usb usb1: New USB device found, idVendor=3D1d6b, idProdu=
ct=3D0002
[    4.649047] usb usb1: New USB device strings: Mfr=3D3, Product=3D2, =
SerialNumber=3D1
[    4.656677] usb usb1: Product: OMAP-EHCI Host Controller
[    4.662292] usb usb1: Manufacturer: Linux 3.7.0-rc2-00295-g2d0135b e=
hci_hcd
[    4.669647] usb usb1: SerialNumber: ehci-omap.0
[    4.680297] hub 1-0:1.0: USB hub found
[    4.684539] hub 1-0:1.0: 3 ports detected
[    4.692901] musb-hdrc: version 6.0, ?dma?, otg (peripheral+host)
[    4.719635] input: twl4030_pwrbutton as /devices/platform/omap_i2c.1=
/i2c-1/1-0049/twl4030_pwrbutton/input/input0
[    4.733947] twl_rtc twl_rtc: Enabling TWL-RTC
[    4.745208] twl_rtc twl_rtc: rtc core: registered twl_rtc as rtc0
[    4.753814] i2c /dev entries driver
[    4.764495] omap_wdt: OMAP Watchdog Timer Rev 0x31: initial timeout =
60 sec
[    4.773651] twl4030_wdt twl4030_wdt: Failed to register misc device
[    4.780364] twl4030_wdt: probe of twl4030_wdt failed with error -16
[    4.789031] cpu cpu0: opp_init_cpufreq_table: Device OPP not found (=
-19)
[    4.796478] cpu cpu0: omap_cpu_init: cpu0: failed creating freq tabl=
e[-19]
[    4.803894] cpuidle: using governor ladder
[    4.808319] cpuidle: using governor menu
[    4.818847] omap_hsmmc omap_hsmmc.0: Failed to get debounce clk
[    4.825256] omap-dma-engine omap-dma-engine: allocating channel for =
62
[    4.832244] omap-dma-engine omap-dma-engine: allocating channel for =
61
[    5.032897] usb 1-2: new high-speed USB device number 2 using ehci-o=
map
[    5.197692] usb 1-2: New USB device found, idVendor=3D0424, idProduc=
t=3D9514
[    5.204803] usb 1-2: New USB device strings: Mfr=3D0, Product=3D0, S=
erialNumber=3D0
[    5.224517] hub 1-2:1.0: USB hub found
[    5.230926] hub 1-2:1.0: 5 ports detected
[    5.253845] usbcore: registered new interface driver usbhid
[    5.259826] usbhid: USB HID core driver
[    5.275726] oprofile: using arm/armv7
[    5.280517] TCP: cubic registered
[    5.284118] Initializing XFRM netlink socket
[    5.288757] NET: Registered protocol family 17
[    5.293731] NET: Registered protocol family 15
[    5.299041] Key type dns_resolver registered
[    5.303680] VFP support v0.3: implementor 41 architecture 3 part 30 =
variant c rev 3
[    5.328308] omap2_set_init_voltage: unable to find boot up OPP for v=
dd_mpu_iva
[    5.335998] omap2_set_init_voltage: unable to set vdd_mpu_iva
[    5.359069] mmc0: host does not support reading read-only switch. as=
suming write-enable.
[    5.371734] mmc0: new high speed SDHC card at address 5ffa
[    5.383026] omap_i2c omap_i2c.2: bus 2 rev1.4.0 at 100 kHz
[    5.389923] mmcblk0: mmc0:5ffa SD04G 3.69 GiB=20
[    5.396697] ThumbEE CPU extension supported.
[    5.401672] SmartReflex Class3 initialized
[    5.412811]  mmcblk0: p1 p2 p3 p4
[    5.425964] fbcvt: 1024x768@60: CVT Name - .786M3-R
[    5.448333] VDVI: incomplete constraints, leaving on
[    5.453918] VDAC: incomplete constraints, leaving on
[    5.467254] input: gpio-keys as /devices/platform/gpio-keys/input/in=
put1
[    5.478210] twl_rtc twl_rtc: setting system clock to 2012-10-16 18:1=
7:33 UTC (1350411453)
[    5.487365] omap_vout omap_vout: Buffer Size =3D 3932160
[    5.496765] omap_vout omap_vout: : registered and initialized video =
device 0
[    5.504364] omap_vout omap_vout: Buffer Size =3D 3932160
[    5.512420] omap_vout omap_vout: : registered and initialized video =
device 1
[    5.521179] sr_init: No PMIC hook to init smartreflex
[    5.527221] smartreflex smartreflex.0: omap_sr_probe: SmartReflex dr=
iver initialized
[    5.536834] smartreflex smartreflex.1: omap_sr_probe: SmartReflex dr=
iver initialized
[    5.547363] ------------[ cut here ]------------
[    5.552246] WARNING: at arch/arm/mach-omap2/clockdomain.c:961 clkdm_=
clk_disable+0x70/0xd0()
[    5.560943] Modules linked in:
[    5.564178] [<c0018ac0>] (unwind_backtrace+0x0/0xec) from [<c0033e3c=
>] (warn_slowpath_common+0x4c/0x64)
[    5.574005] [<c0033e3c>] (warn_slowpath_common+0x4c/0x64) from [<c00=
33e6c>] (warn_slowpath_null+0x18/0x1c)
[    5.584106] [<c0033e6c>] (warn_slowpath_null+0x18/0x1c) from [<c0029=
dfc>] (clkdm_clk_disable+0x70/0xd0)
[    5.593933] [<c0029dfc>] (clkdm_clk_disable+0x70/0xd0) from [<c035fc=
94>] (clk_disable_unused_subtree+0x74/0x88)
[    5.604461] [<c035fc94>] (clk_disable_unused_subtree+0x74/0x88) from=
 [<c035fc40>] (clk_disable_unused_subtree+0x20/0x88)
[    5.615814] ---[ end trace 0eaa05360b28dfb2 ]---
[    5.621215] ------------[ cut here ]------------
[    5.626068] WARNING: at arch/arm/mach-omap2/clockdomain.c:961 clkdm_=
clk_disable+0x70/0xd0()
[    5.634765] Modules linked in:
[    5.637969] [<c0018ac0>] (unwind_backtrace+0x0/0xec) from [<c0033e3c=
>] (warn_slowpath_common+0x4c/0x64)
[    5.647796] [<c0033e3c>] (warn_slowpath_common+0x4c/0x64) from [<c00=
33e6c>] (warn_slowpath_null+0x18/0x1c)
[    5.657897] [<c0033e6c>] (warn_slowpath_null+0x18/0x1c) from [<c0029=
dfc>] (clkdm_clk_disable+0x70/0xd0)
[    5.667724] [<c0029dfc>] (clkdm_clk_disable+0x70/0xd0) from [<c035fc=
94>] (clk_disable_unused_subtree+0x74/0x88)
[    5.678253] [<c035fc94>] (clk_disable_unused_subtree+0x74/0x88) from=
 [<c035fc40>] (clk_disable_unused_subtree+0x20/0x88)
[    5.689605] ---[ end trace 0eaa05360b28dfb3 ]---
[    5.794860] usb 1-2.1: new high-speed USB device number 3 using ehci=
-omap
[    5.916992] usb 1-2.1: New USB device found, idVendor=3D0424, idProd=
uct=3Dec00
[    5.924255] usb 1-2.1: New USB device strings: Mfr=3D0, Product=3D0,=
 SerialNumber=3D0
[    5.938629] smsc95xx v1.0.4
[    6.039916] smsc95xx 1-2.1:1.0 eth0: register 'smsc95xx' at usb-ehci=
-omap.0-2.1, smsc95xx USB 2.0 Ethernet, ae:b1:2c:0c:25:0d
[    6.134948] usb 1-2.5: new low-speed USB device number 4 using ehci-=
omap
[    6.276367] usb 1-2.5: New USB device found, idVendor=3D045e, idProd=
uct=3D001e
[    6.283660] usb 1-2.5: New USB device strings: Mfr=3D1, Product=3D2,=
 SerialNumber=3D0
[    6.291381] usb 1-2.5: Product: Microsoft IntelliMouse=EF=BF=BD=C2=AE=
 Explorer
[    6.297790] usb 1-2.5: Manufacturer: Microsoft
[    6.322143] input: Microsoft Microsoft IntelliMouse=EF=BF=BD=C2=AE E=
xplorer as /devices/platform/usbhs_omap/ehci-omap.0/usb1/1-2/1-2.5/1-2.=
5:1.0/input/input2
[    6.335937] hid-generic 0003:045E:001E.0001: input: USB HID v1.00 Mo=
use [Microsoft Microsoft IntelliMouse=EF=BF=BD=C2=AE Explorer] on usb-e=
hci-omap.0-2.5/input0
[    8.332000] smsc95xx 1-2.1:1.0 eth0: link up, 100Mbps, full-duplex, =
lpa 0xCDE1

--nextPart1559223.10XxXjCnj7--


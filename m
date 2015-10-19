From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: [BISECTED] Nokia 770 framebuffer breakage
Date: Tue, 20 Oct 2015 01:24:13 +0300
Message-ID: <20151019222413.GG31069@blackmetal.musicnaut.iki.fi>
References: <20151019193759.GE31069@blackmetal.musicnaut.iki.fi>
 <20151019200522.GJ32536@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20151019200522.GJ32536@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Mon, Oct 19, 2015 at 09:05:22PM +0100, Russell King - ARM Linux wrote:
> On Mon, Oct 19, 2015 at 10:37:59PM +0300, Aaro Koskinen wrote:
> > Hi,
> > 
> > Somewhere between 4.1 .. 4.3-rc6 framebuffer on Nokia 770 stopped working.
> > 
> > Bisection points to:
> > 
> > commit 2568999835d7797afce3dcc3a3f368051ffcaf1f
> > Author: Russell King <rmk+kernel@arm.linux.org.uk>
> > Date:   Mon Mar 2 15:40:29 2015 +0000
> > 
> >     clkdev: add clkdev_create() helper
> > 
> > The commit cannot be reverted cleanly from current trees, but I re-tested
> > that commit 2568999835d7797afce3dcc3a3f368051ffcaf1f does not work and
> > commit 2568999835d7797afce3dcc3a3f368051ffcaf1f^1 indeed works.
> 
> Really need more information than that, like a kernel log or something.

This is a device with normal consumer electronics mechnics so serial
port access is PITA. However I managed to get a boot log, see below,
it's from commit 2568999835d7797afce3dcc3a3f368051ffcaf1f.

> Can you try this patch please?

Unfortunately with the patch it dies even earlier, without any output.

...

Uncompressing Linux... done, booting the kernel.
[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 4.1.0-rc1-770_tiny-los_350d5+-00006-g2568999 (aaro@amd-fx-6350) (gcc version 5.2.0 (GCC) ) #1 Tue Oct 20 00:41:44 EEST 2015
[    0.000000] CPU: ARM926EJ-S [41069263] revision 3 (ARMv5TEJ), cr=0005317f
[    0.000000] CPU: VIVT data cache, VIVT instruction cache
[    0.000000] Machine: Nokia 770
[    0.000000] Ignoring unrecognised tag 0x414f4d50
[    0.000000] earlycon: no match for ttyS0,115200
[    0.000000] Memory policy: Data cache writeback
[    0.000000] OMAP1710
[    0.000000]  revision 8 handled as 16xx id: 8b5f702f03330200
[    0.000000] Clocks: ARM_SYSST: 0x1000 DPLL_CTL: 0x2a93 ARM_CKCTL: 0x050e
[    0.000000] Clocking rate (xtal/DPLL1/MPU): 12.0/252.0/252.0 MHz
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 16256
[    0.000000] Kernel command line: mem=64M console=ttyS0,115200
[    0.000000] PID hash table entries: 256 (order: -2, 1024 bytes)
[    0.000000] Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
[    0.000000] Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
[    0.000000] Memory: 61296K/65536K available (1614K kernel code, 138K rwdata, 532K rodata, 1124K init, 178K bss, 4240K reserved, 0K cma-reserved)
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
[    0.000000]     vmalloc : 0xc4800000 - 0xff000000   ( 936 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xc4000000   (  64 MB)
[    0.000000]     modules : 0xbf000000 - 0xc0000000   (  16 MB)
[    0.000000]       .text : 0xc0008000 - 0xc0220d04   (2148 kB)
[    0.000000]       .init : 0xc0221000 - 0xc033a000   (1124 kB)
[    0.000000]       .data : 0xc033a000 - 0xc035c880   ( 139 kB)
[    0.000000]        .bss : 0xc035c880 - 0xc038914c   ( 179 kB)
[    0.000000] SLUB: HWalign=32, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
[    0.000000] NR_IRQS:368
[    0.000000] Total of 128 interrupts in 4 interrupt banks
[    0.000000] clocksource 32k_counter: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 58327039986419 ns
[    0.000030] sched_clock: 32 bits at 32kHz, resolution 30517ns, wraps every 65535999984741ns
[    0.000061] OMAP clocksource: 32k_counter at 32768 Hz
[    0.000610] Console: colour dummy device 80x30
[    0.000701] Calibrating delay loop... 125.33 BogoMIPS (lpj=626688)
[    0.090118] pid_max: default: 32768 minimum: 301
[    0.090423] Mount-cache hash table entries: 1024 (order: 0, 4096 bytes)
[    0.090484] Mountpoint-cache hash table entries: 1024 (order: 0, 4096 bytes)
[    0.092102] CPU: Testing write buffer coherency: ok
[    0.093048] Setting up static identity map for 0x10008400 - 0x1000843c
[    0.096374] devtmpfs: initialized
[    0.102111] clocksource jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
[    0.104034] DMA: preallocated 256 KiB pool for atomic coherent allocations
[    0.107269] omap_gpio omap_gpio.1: Could not get gpio dbck
[    0.107452] OMAP GPIO hardware version 1.1
[    0.107635] omap_gpio omap_gpio.2: Could not get gpio dbck
[    0.107940] omap_gpio omap_gpio.3: Could not get gpio dbck
[    0.108245] omap_gpio omap_gpio.4: Could not get gpio dbck
[    0.110229] MUX: initialized V6_USB0_TXD
[    0.110290] MUX: initialized W5_USB0_SE0
[    0.110321] MUX: initialized Y5_USB0_RCV
[    0.110351] MUX: initialized AA9_USB0_VP
[    0.110351] MUX: initialized R9_USB0_VM
[    0.110382] USB: hmc 16, usb0 6 wires, Mini-AB on usb0
[    0.110748] MUX: initialized W19_1610_MMC2_DATDIR1
[    0.112640] Clocking rate (xtal/DPLL1/MPU): 12.0/216.0/216.0 MHz
[    0.116882] OMAP DMA hardware version 1
[    0.116943] DMA capabilities: 0000000c:00000000:01ff:003f:007f
[    0.133392] omap-dma-engine omap-dma-engine: failed to get L1 IRQ: -6
[    0.170562] omap-dma-engine omap-dma-engine: OMAP DMA engine driver
[    0.172393] SCSI subsystem initialized
[    0.172668] omap_uwire omap_uwire: Runtime PM disabled, clock forced on.
[    0.174926] usbcore: registered new interface driver usbfs
[    0.175292] usbcore: registered new interface driver hub
[    0.175598] usbcore: registered new device driver usb
[    0.177124] Switched to clocksource 32k_counter
[    3.050994] OMAP OCPI interconnect driver loaded
[    3.078582] io scheduler noop registered (default)
[    3.079772] omapfb: lph8923 rev 92 LCD detected, 16 data lines
[    3.080444] omapfb: configured for panel lph8923
[    3.089508] omapfb: LCDC initialized
[    3.089660] omapfb omapfb: SoSSI version 1.21 initialized
[    3.089782] Division by zero in kernel.
[    3.089874] CPU: 0 PID: 1 Comm: swapper Not tainted 4.1.0-rc1-770_tiny-los_350d5+-00006-g2568999 #1
[    3.089904] Hardware name: Nokia 770
[    3.089935] Backtrace: 
[    3.090026] [<c000c9e4>] (dump_backtrace) from [<c000cc08>] (show_stack+0x18/0x1c)
[    3.090057]  r7:00005a69 r6:00001215 r5:00000001 r4:c0386c70
[    3.090179] [<c000cbf0>] (show_stack) from [<c019776c>] (dump_stack+0x20/0x28)
[    3.090270] [<c019774c>] (dump_stack) from [<c000cb70>] (__div0+0x18/0x20)
[    3.090362] [<c000cb58>] (__div0) from [<c00de018>] (Ldiv0+0x8/0x10)
[    3.090454] [<c010cff4>] (calc_extif_timings) from [<c010d370>] (hwa742_init+0xa8/0x510)
[    3.090484]  r10:00000000 r9:c035c880 r8:c3a0c228 r7:00000000 r6:c319d000 r5:00000000
[    3.090576]  r4:c0386c70
[    3.090667] [<c010d2c8>] (hwa742_init) from [<c010a154>] (omapfb_do_probe+0x238/0x710)
[    3.090698]  r10:00000000 r9:c035c880 r8:c3a0c228 r7:c0386b88 r6:c033fd00 r5:00000000
[    3.090789]  r4:c319d000
[    3.090881] [<c0109f1c>] (omapfb_do_probe) from [<c010a6dc>] (omapfb_register_panel+0x38/0x40)
[    3.090911]  r10:00000000 r9:c035c880 r8:c0351ed8 r7:00000000 r6:c0341738 r5:c3a0c228
[    3.091003]  r4:00000000
[    3.091064] [<c010a6a4>] (omapfb_register_panel) from [<c010dee0>] (mipid_spi_probe+0x120/0x158)
[    3.091156] [<c010ddc0>] (mipid_spi_probe) from [<c01546e4>] (spi_drv_probe+0x20/0x24)
[    3.091217]  r7:00000000 r6:c0351ed8 r5:c0388910 r4:c3869e00
[    3.091339] [<c01546c4>] (spi_drv_probe) from [<c0137e1c>] (driver_probe_device+0xe8/0x248)
[    3.091400] [<c0137d34>] (driver_probe_device) from [<c0138038>] (__driver_attach+0x70/0x94)
[    3.091430]  r9:c035c880 r8:c033c520 r7:c03579f4 r6:c0351ed8 r5:c3869e34 r4:c3869e00
[    3.091583] [<c0137fc8>] (__driver_attach) from [<c01365dc>] (bus_for_each_dev+0x74/0x98)
[    3.091613]  r7:c03579f4 r6:c0137fc8 r5:c0351ed8 r4:00000000
[    3.091735] [<c0136568>] (bus_for_each_dev) from [<c0137954>] (driver_attach+0x20/0x28)
[    3.091766]  r6:c3a244e0 r5:00000000 r4:c0351ed8
[    3.091857] [<c0137934>] (driver_attach) from [<c01375f8>] (bus_add_driver+0xe8/0x1d4)
[    3.091949] [<c0137510>] (bus_add_driver) from [<c0138474>] (driver_register+0xa4/0xe8)
[    3.091979]  r7:c033c520 r6:00000000 r5:c0230be8 r4:c0351ed8
[    3.092102] [<c01383d0>] (driver_register) from [<c0154bc4>] (spi_register_driver+0x4c/0x60)
[    3.092132]  r5:c0230be8 r4:c3a05860
[    3.092254] [<c0154b78>] (spi_register_driver) from [<c0230bfc>] (mipid_spi_driver_init+0x14/0x1c)
[    3.092346] [<c0230be8>] (mipid_spi_driver_init) from [<c000951c>] (do_one_initcall+0x10c/0x1c4)
[    3.092407] [<c0009410>] (do_one_initcall) from [<c0221dd4>] (kernel_init_freeable+0xfc/0x1c0)
[    3.092437]  r9:c035c880 r8:c035c880 r7:c0234ef0 r6:c0238270 r5:00000048 r4:00000006
[    3.092590] [<c0221cd8>] (kernel_init_freeable) from [<c0196750>] (kernel_init+0x10/0xec)
[    3.092620]  r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:c0196740 r4:00000000
[    3.092742] [<c0196740>] (kernel_init) from [<c000a0f8>] (ret_from_fork+0x14/0x3c)
[    3.092773]  r5:c0196740 r4:00000000
[    3.092834] Division by zero in kernel.
[    3.092895] CPU: 0 PID: 1 Comm: swapper Not tainted 4.1.0-rc1-770_tiny-los_350d5+-00006-g2568999 #1
[    3.092926] Hardware name: Nokia 770
[    3.092956] Backtrace: 
[    3.093017] [<c000c9e4>] (dump_backtrace) from [<c000cc08>] (show_stack+0x18/0x1c)
[    3.093078]  r7:00005a69 r6:000007d0 r5:00000001 r4:c0386c70
[    3.093170] [<c000cbf0>] (show_stack) from [<c019776c>] (dump_stack+0x20/0x28)
[    3.093231] [<c019774c>] (dump_stack) from [<c000cb70>] (__div0+0x18/0x20)
[    3.093322] [<c000cb58>] (__div0) from [<c00de018>] (Ldiv0+0x8/0x10)
[    3.093444] [<c010cff4>] (calc_extif_timings) from [<c010d370>] (hwa742_init+0xa8/0x510)
[    3.093475]  r10:00000000 r9:c035c880 r8:c3a0c228 r7:00000000 r6:c319d000 r5:00000000
[    3.093566]  r4:c0386c70
[    3.093627] [<c010d2c8>] (hwa742_init) from [<c010a154>] (omapfb_do_probe+0x238/0x710)
[    3.093658]  r10:00000000 r9:c035c880 r8:c3a0c228 r7:c0386b88 r6:c033fd00 r5:00000000
[    3.093749]  r4:c319d000
[    3.093841] [<c0109f1c>] (omapfb_do_probe) from [<c010a6dc>] (omapfb_register_panel+0x38/0x40)
[    3.093872]  r10:00000000 r9:c035c880 r8:c0351ed8 r7:00000000 r6:c0341738 r5:c3a0c228
[    3.093963]  r4:00000000
[    3.094055] [<c010a6a4>] (omapfb_register_panel) from [<c010dee0>] (mipid_spi_probe+0x120/0x158)
[    3.094146] [<c010ddc0>] (mipid_spi_probe) from [<c01546e4>] (spi_drv_probe+0x20/0x24)
[    3.094177]  r7:00000000 r6:c0351ed8 r5:c0388910 r4:c3869e00
[    3.094299] [<c01546c4>] (spi_drv_probe) from [<c0137e1c>] (driver_probe_device+0xe8/0x248)
[    3.094390] [<c0137d34>] (driver_probe_device) from [<c0138038>] (__driver_attach+0x70/0x94)
[    3.094421]  r9:c035c880 r8:c033c520 r7:c03579f4 r6:c0351ed8 r5:c3869e34 r4:c3869e00
[    3.094543] [<c0137fc8>] (__driver_attach) from [<c01365dc>] (bus_for_each_dev+0x74/0x98)
[    3.094573]  r7:c03579f4 r6:c0137fc8 r5:c0351ed8 r4:00000000
[    3.094696] [<c0136568>] (bus_for_each_dev) from [<c0137954>] (driver_attach+0x20/0x28)
[    3.094726]  r6:c3a244e0 r5:00000000 r4:c0351ed8
[    3.094818] [<c0137934>] (driver_attach) from [<c01375f8>] (bus_add_driver+0xe8/0x1d4)
[    3.094909] [<c0137510>] (bus_add_driver) from [<c0138474>] (driver_register+0xa4/0xe8)
[    3.094940]  r7:c033c520 r6:00000000 r5:c0230be8 r4:c0351ed8
[    3.095062] [<c01383d0>] (driver_register) from [<c0154bc4>] (spi_register_driver+0x4c/0x60)
[    3.095092]  r5:c0230be8 r4:c3a05860
[    3.095214] [<c0154b78>] (spi_register_driver) from [<c0230bfc>] (mipid_spi_driver_init+0x14/0x1c)
[    3.095306] [<c0230be8>] (mipid_spi_driver_init) from [<c000951c>] (do_one_initcall+0x10c/0x1c4)
[    3.095367] [<c0009410>] (do_one_initcall) from [<c0221dd4>] (kernel_init_freeable+0xfc/0x1c0)
[    3.095428]  r9:c035c880 r8:c035c880 r7:c0234ef0 r6:c0238270 r5:00000048 r4:00000006
[    3.095550] [<c0221cd8>] (kernel_init_freeable) from [<c0196750>] (kernel_init+0x10/0xec)
[    3.095581]  r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:c0196740 r4:00000000
[    3.095703] [<c0196740>] (kernel_init) from [<c000a0f8>] (ret_from_fork+0x14/0x3c)
[    3.095733]  r5:c0196740 r4:00000000
[    3.095886] Division by zero in kernel.
[    3.095947] CPU: 0 PID: 1 Comm: swapper Not tainted 4.1.0-rc1-770_tiny-los_350d5+-00006-g2568999 #1
[    3.095977] Hardware name: Nokia 770
[    3.096008] Backtrace: 
[    3.096069] [<c000c9e4>] (dump_backtrace) from [<c000cc08>] (show_stack+0x18/0x1c)
[    3.096099]  r7:00005a69 r6:00001215 r5:00000001 r4:c0386c70
[    3.096221] [<c000cbf0>] (show_stack) from [<c019776c>] (dump_stack+0x20/0x28)
[    3.096282] [<c019774c>] (dump_stack) from [<c000cb70>] (__div0+0x18/0x20)
[    3.096374] [<c000cb58>] (__div0) from [<c00de018>] (Ldiv0+0x8/0x10)
[    3.096466] [<c010cff4>] (calc_extif_timings) from [<c010d3e0>] (hwa742_init+0x118/0x510)
[    3.096527]  r10:00000000 r9:00000011 r8:c3a0c228 r7:0000008b r6:c319d000 r5:00000000
[    3.096618]  r4:c0386c70
[    3.096679] [<c010d2c8>] (hwa742_init) from [<c010a154>] (omapfb_do_probe+0x238/0x710)
[    3.096710]  r10:00000000 r9:c035c880 r8:c3a0c228 r7:c0386b88 r6:c033fd00 r5:00000000
[    3.096832]  r4:c319d000
[    3.096893] [<c0109f1c>] (omapfb_do_probe) from [<c010a6dc>] (omapfb_register_panel+0x38/0x40)
[    3.096923]  r10:00000000 r9:c035c880 r8:c0351ed8 r7:00000000 r6:c0341738 r5:c3a0c228
[    3.097015]  r4:00000000
[    3.097106] [<c010a6a4>] (omapfb_register_panel) from [<c010dee0>] (mipid_spi_probe+0x120/0x158)
[    3.097198] [<c010ddc0>] (mipid_spi_probe) from [<c01546e4>] (spi_drv_probe+0x20/0x24)
[    3.097381]  r7:00000000 r6:c0351ed8 r5:c0388910 r4:c3869e00
[    3.097503] [<c01546c4>] (spi_drv_probe) from [<c0137e1c>] (driver_probe_device+0xe8/0x248)
[    3.097595] [<c0137d34>] (driver_probe_device) from [<c0138038>] (__driver_attach+0x70/0x94)
[    3.097625]  r9:c035c880 r8:c033c520 r7:c03579f4 r6:c0351ed8 r5:c3869e34 r4:c3869e00
[    3.097747] [<c0137fc8>] (__driver_attach) from [<c01365dc>] (bus_for_each_dev+0x74/0x98)
[    3.097808]  r7:c03579f4 r6:c0137fc8 r5:c0351ed8 r4:00000000
[    3.097900] [<c0136568>] (bus_for_each_dev) from [<c0137954>] (driver_attach+0x20/0x28)
[    3.097930]  r6:c3a244e0 r5:00000000 r4:c0351ed8
[    3.098052] [<c0137934>] (driver_attach) from [<c01375f8>] (bus_add_driver+0xe8/0x1d4)
[    3.098114] [<c0137510>] (bus_add_driver) from [<c0138474>] (driver_register+0xa4/0xe8)
[    3.098144]  r7:c033c520 r6:00000000 r5:c0230be8 r4:c0351ed8
[    3.098266] [<c01383d0>] (driver_register) from [<c0154bc4>] (spi_register_driver+0x4c/0x60)
[    3.098297]  r5:c0230be8 r4:c3a05860
[    3.098419] [<c0154b78>] (spi_register_driver) from [<c0230bfc>] (mipid_spi_driver_init+0x14/0x1c)
[    3.098510] [<c0230be8>] (mipid_spi_driver_init) from [<c000951c>] (do_one_initcall+0x10c/0x1c4)
[    3.098602] [<c0009410>] (do_one_initcall) from [<c0221dd4>] (kernel_init_freeable+0xfc/0x1c0)
[    3.098632]  r9:c035c880 r8:c035c880 r7:c0234ef0 r6:c0238270 r5:00000048 r4:00000006
[    3.098754] [<c0221cd8>] (kernel_init_freeable) from [<c0196750>] (kernel_init+0x10/0xec)
[    3.098785]  r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:c0196740 r4:00000000
[    3.098907] [<c0196740>] (kernel_init) from [<c000a0f8>] (ret_from_fork+0x14/0x3c)
[    3.098937]  r5:c0196740 r4:00000000
[    3.098999] Division by zero in kernel.
[    3.099060] CPU: 0 PID: 1 Comm: swapper Not tainted 4.1.0-rc1-770_tiny-los_350d5+-00006-g2568999 #1
[    3.099090] Hardware name: Nokia 770
[    3.099121] Backtrace: 
[    3.099212] [<c000c9e4>] (dump_backtrace) from [<c000cc08>] (show_stack+0x18/0x1c)
[    3.099243]  r7:00005a69 r6:000007d0 r5:00000001 r4:c0386c70
[    3.099334] [<c000cbf0>] (show_stack) from [<c019776c>] (dump_stack+0x20/0x28)
[    3.099426] [<c019774c>] (dump_stack) from [<c000cb70>] (__div0+0x18/0x20)
[    3.099517] [<c000cb58>] (__div0) from [<c00de018>] (Ldiv0+0x8/0x10)
[    3.099609] [<c010cff4>] (calc_extif_timings) from [<c010d3e0>] (hwa742_init+0x118/0x510)
[    3.099639]  r10:00000000 r9:00000011 r8:c3a0c228 r7:0000008b r6:c319d000 r5:00000000
[    3.099731]  r4:c0386c70
[    3.099822] [<c010d2c8>] (hwa742_init) from [<c010a154>] (omapfb_do_probe+0x238/0x710)
[    3.099853]  r10:00000000 r9:c035c880 r8:c3a0c228 r7:c0386b88 r6:c033fd00 r5:00000000
[    3.099945]  r4:c319d000
[    3.100036] [<c0109f1c>] (omapfb_do_probe) from [<c010a6dc>] (omapfb_register_panel+0x38/0x40)
[    3.100067]  r10:00000000 r9:c035c880 r8:c0351ed8 r7:00000000 r6:c0341738 r5:c3a0c228
[    3.100158]  r4:00000000
[    3.100219] [<c010a6a4>] (omapfb_register_panel) from [<c010dee0>] (mipid_spi_probe+0x120/0x158)
[    3.100311] [<c010ddc0>] (mipid_spi_probe) from [<c01546e4>] (spi_drv_probe+0x20/0x24)
[    3.100341]  r7:00000000 r6:c0351ed8 r5:c0388910 r4:c3869e00
[    3.100494] [<c01546c4>] (spi_drv_probe) from [<c0137e1c>] (driver_probe_device+0xe8/0x248)
[    3.100555] [<c0137d34>] (driver_probe_device) from [<c0138038>] (__driver_attach+0x70/0x94)
[    3.100585]  r9:c035c880 r8:c033c520 r7:c03579f4 r6:c0351ed8 r5:c3869e34 r4:c3869e00
[    3.100738] [<c0137fc8>] (__driver_attach) from [<c01365dc>] (bus_for_each_dev+0x74/0x98)
[    3.100769]  r7:c03579f4 r6:c0137fc8 r5:c0351ed8 r4:00000000
[    3.100891] [<c0136568>] (bus_for_each_dev) from [<c0137954>] (driver_attach+0x20/0x28)
[    3.100921]  r6:c3a244e0 r5:00000000 r4:c0351ed8
[    3.101013] [<c0137934>] (driver_attach) from [<c01375f8>] (bus_add_driver+0xe8/0x1d4)
[    3.101074] [<c0137510>] (bus_add_driver) from [<c0138474>] (driver_register+0xa4/0xe8)
[    3.101135]  r7:c033c520 r6:00000000 r5:c0230be8 r4:c0351ed8
[    3.101226] [<c01383d0>] (driver_register) from [<c0154bc4>] (spi_register_driver+0x4c/0x60)
[    3.101287]  r5:c0230be8 r4:c3a05860
[    3.101379] [<c0154b78>] (spi_register_driver) from [<c0230bfc>] (mipid_spi_driver_init+0x14/0x1c)
[    3.101470] [<c0230be8>] (mipid_spi_driver_init) from [<c000951c>] (do_one_initcall+0x10c/0x1c4)
[    3.101562] [<c0009410>] (do_one_initcall) from [<c0221dd4>] (kernel_init_freeable+0xfc/0x1c0)
[    3.101593]  r9:c035c880 r8:c035c880 r7:c0234ef0 r6:c0238270 r5:00000048 r4:00000006
[    3.101715] [<c0221cd8>] (kernel_init_freeable) from [<c0196750>] (kernel_init+0x10/0xec)
[    3.101745]  r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:c0196740 r4:00000000
[    3.101867] [<c0196740>] (kernel_init) from [<c000a0f8>] (ret_from_fork+0x14/0x3c)
[    3.101928]  r5:c0196740 r4:00000000
[    3.102172] Division by zero in kernel.
[    3.102233] CPU: 0 PID: 1 Comm: swapper Not tainted 4.1.0-rc1-770_tiny-los_350d5+-00006-g2568999 #1
[    3.102264] Hardware name: Nokia 770
[    3.102294] Backtrace: 
[    3.102355] [<c000c9e4>] (dump_backtrace) from [<c000cc08>] (show_stack+0x18/0x1c)
[    3.102416]  r7:00000002 r6:c319d000 r5:c0386c70 r4:00000002
[    3.102508] [<c000cbf0>] (show_stack) from [<c019776c>] (dump_stack+0x20/0x28)
[    3.102600] [<c019774c>] (dump_stack) from [<c000cb70>] (__div0+0x18/0x20)
[    3.102691] [<c000cb58>] (__div0) from [<c00de018>] (Ldiv0+0x8/0x10)
[    3.102783] [<c010d2c8>] (hwa742_init) from [<c010a154>] (omapfb_do_probe+0x238/0x710)
[    3.102813]  r10:00000000 r9:c035c880 r8:c3a0c228 r7:c0386b88 r6:c033fd00 r5:00000000
[    3.102905]  r4:c319d000
[    3.102966] [<c0109f1c>] (omapfb_do_probe) from [<c010a6dc>] (omapfb_register_panel+0x38/0x40)
[    3.102996]  r10:00000000 r9:c035c880 r8:c0351ed8 r7:00000000 r6:c0341738 r5:c3a0c228
[    3.103088]  r4:00000000
[    3.103179] [<c010a6a4>] (omapfb_register_panel) from [<c010dee0>] (mipid_spi_probe+0x120/0x158)
[    3.103271] [<c010ddc0>] (mipid_spi_probe) from [<c01546e4>] (spi_drv_probe+0x20/0x24)
[    3.103302]  r7:00000000 r6:c0351ed8 r5:c0388910 r4:c3869e00
[    3.103424] [<c01546c4>] (spi_drv_probe) from [<c0137e1c>] (driver_probe_device+0xe8/0x248)
[    3.103515] [<c0137d34>] (driver_probe_device) from [<c0138038>] (__driver_attach+0x70/0x94)
[    3.103546]  r9:c035c880 r8:c033c520 r7:c03579f4 r6:c0351ed8 r5:c3869e34 r4:c3869e00
[    3.103698] [<c0137fc8>] (__driver_attach) from [<c01365dc>] (bus_for_each_dev+0x74/0x98)
[    3.103729]  r7:c03579f4 r6:c0137fc8 r5:c0351ed8 r4:00000000
[    3.103820] [<c0136568>] (bus_for_each_dev) from [<c0137954>] (driver_attach+0x20/0x28)
[    3.103851]  r6:c3a244e0 r5:00000000 r4:c0351ed8
[    3.103973] [<c0137934>] (driver_attach) from [<c01375f8>] (bus_add_driver+0xe8/0x1d4)
[    3.104034] [<c0137510>] (bus_add_driver) from [<c0138474>] (driver_register+0xa4/0xe8)
[    3.104064]  r7:c033c520 r6:00000000 r5:c0230be8 r4:c0351ed8
[    3.104187] [<c01383d0>] (driver_register) from [<c0154bc4>] (spi_register_driver+0x4c/0x60)
[    3.104217]  r5:c0230be8 r4:c3a05860
[    3.104339] [<c0154b78>] (spi_register_driver) from [<c0230bfc>] (mipid_spi_driver_init+0x14/0x1c)
[    3.104431] [<c0230be8>] (mipid_spi_driver_init) from [<c000951c>] (do_one_initcall+0x10c/0x1c4)
[    3.104492] [<c0009410>] (do_one_initcall) from [<c0221dd4>] (kernel_init_freeable+0xfc/0x1c0)
[    3.104553]  r9:c035c880 r8:c035c880 r7:c0234ef0 r6:c0238270 r5:00000048 r4:00000006
[    3.104675] [<c0221cd8>] (kernel_init_freeable) from [<c0196750>] (kernel_init+0x10/0xec)
[    3.104705]  r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:c0196740 r4:00000000
[    3.104827] [<c0196740>] (kernel_init) from [<c000a0f8>] (ret_from_fork+0x14/0x3c)
[    3.104858]  r5:c0196740 r4:00000000
[    3.104919] Division by zero in kernel.
[    3.104980] CPU: 0 PID: 1 Comm: swapper Not tainted 4.1.0-rc1-770_tiny-los_350d5+-00006-g2568999 #1
[    3.105010] Hardware name: Nokia 770
[    3.105010] Backtrace: 
[    3.105102] [<c000c9e4>] (dump_backtrace) from [<c000cc08>] (show_stack+0x18/0x1c)
[    3.105133]  r7:00000001 r6:c319d000 r5:c0386c70 r4:00000001
[    3.105255] [<c000cbf0>] (show_stack) from [<c019776c>] (dump_stack+0x20/0x28)
[    3.105316] [<c019774c>] (dump_stack) from [<c000cb70>] (__div0+0x18/0x20)
[    3.105407] [<c000cb58>] (__div0) from [<c00de018>] (Ldiv0+0x8/0x10)
[    3.105499] [<c010d2c8>] (hwa742_init) from [<c010a154>] (omapfb_do_probe+0x238/0x710)
[    3.105529]  r10:00000000 r9:c035c880 r8:c3a0c228 r7:c0386b88 r6:c033fd00 r5:00000000
[    3.105621]  r4:c319d000
[    3.105712] [<c0109f1c>] (omapfb_do_probe) from [<c010a6dc>] (omapfb_register_panel+0x38/0x40)
[    3.105743]  r10:00000000 r9:c035c880 r8:c0351ed8 r7:00000000 r6:c0341738 r5:c3a0c228
[    3.105834]  r4:00000000
[    3.105926] [<c010a6a4>] (omapfb_register_panel) from [<c010dee0>] (mipid_spi_probe+0x120/0x158)
[    3.106018] [<c010ddc0>] (mipid_spi_probe) from [<c01546e4>] (spi_drv_probe+0x20/0x24)
[    3.106048]  r7:00000000 r6:c0351ed8 r5:c0388910 r4:c3869e00
[    3.106170] [<c01546c4>] (spi_drv_probe) from [<c0137e1c>] (driver_probe_device+0xe8/0x248)
[    3.106231] [<c0137d34>] (driver_probe_device) from [<c0138038>] (__driver_attach+0x70/0x94)
[    3.106292]  r9:c035c880 r8:c033c520 r7:c03579f4 r6:c0351ed8 r5:c3869e34 r4:c3869e00
[    3.106414] [<c0137fc8>] (__driver_attach) from [<c01365dc>] (bus_for_each_dev+0x74/0x98)
[    3.106445]  r7:c03579f4 r6:c0137fc8 r5:c0351ed8 r4:00000000
[    3.106567] [<c0136568>] (bus_for_each_dev) from [<c0137954>] (driver_attach+0x20/0x28)
[    3.106597]  r6:c3a244e0 r5:00000000 r4:c0351ed8
[    3.106689] [<c0137934>] (driver_attach) from [<c01375f8>] (bus_add_driver+0xe8/0x1d4)
[    3.106781] [<c0137510>] (bus_add_driver) from [<c0138474>] (driver_register+0xa4/0xe8)
[    3.106811]  r7:c033c520 r6:00000000 r5:c0230be8 r4:c0351ed8
[    3.106933] [<c01383d0>] (driver_register) from [<c0154bc4>] (spi_register_driver+0x4c/0x60)
[    3.106964]  r5:c0230be8 r4:c3a05860
[    3.107055] [<c0154b78>] (spi_register_driver) from [<c0230bfc>] (mipid_spi_driver_init+0x14/0x1c)
[    3.107147] [<c0230be8>] (mipid_spi_driver_init) from [<c000951c>] (do_one_initcall+0x10c/0x1c4)
[    3.107238] [<c0009410>] (do_one_initcall) from [<c0221dd4>] (kernel_init_freeable+0xfc/0x1c0)
[    3.107391]  r9:c035c880 r8:c035c880 r7:c0234ef0 r6:c0238270 r5:00000048 r4:00000006
[    3.107543] [<c0221cd8>] (kernel_init_freeable) from [<c0196750>] (kernel_init+0x10/0xec)
[    3.107574]  r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:c0196740 r4:00000000
[    3.107696] [<c0196740>] (kernel_init) from [<c000a0f8>] (ret_from_fork+0x14/0x3c)
[    3.107727]  r5:c0196740 r4:00000000
[    3.107757] Division by zero in kernel.
[    3.107818] CPU: 0 PID: 1 Comm: swapper Not tainted 4.1.0-rc1-770_tiny-los_350d5+-00006-g2568999 #1
[    3.107849] Hardware name: Nokia 770
[    3.107879] Backtrace: 
[    3.107971] [<c000c9e4>] (dump_backtrace) from [<c000cc08>] (show_stack+0x18/0x1c)
[    3.108001]  r7:00000001 r6:c319d000 r5:c0386c70 r4:00000001
[    3.108093] [<c000cbf0>] (show_stack) from [<c019776c>] (dump_stack+0x20/0x28)
[    3.108184] [<c019774c>] (dump_stack) from [<c000cb70>] (__div0+0x18/0x20)
[    3.108276] [<c000cb58>] (__div0) from [<c00de018>] (Ldiv0+0x8/0x10)
[    3.108367] [<c010d2c8>] (hwa742_init) from [<c010a154>] (omapfb_do_probe+0x238/0x710)
[    3.108398]  r10:00000000 r9:c035c880 r8:c3a0c228 r7:c0386b88 r6:c033fd00 r5:00000000
[    3.108489]  r4:c319d000
[    3.108551] [<c0109f1c>] (omapfb_do_probe) from [<c010a6dc>] (omapfb_register_panel+0x38/0x40)
[    3.108612]  r10:00000000 r9:c035c880 r8:c0351ed8 r7:00000000 r6:c0341738 r5:c3a0c228
[    3.108703]  r4:00000000
[    3.108764] [<c010a6a4>] (omapfb_register_panel) from [<c010dee0>] (mipid_spi_probe+0x120/0x158)
[    3.108856] [<c010ddc0>] (mipid_spi_probe) from [<c01546e4>] (spi_drv_probe+0x20/0x24)
[    3.108917]  r7:00000000 r6:c0351ed8 r5:c0388910 r4:c3869e00
[    3.109039] [<c01546c4>] (spi_drv_probe) from [<c0137e1c>] (driver_probe_device+0xe8/0x248)
[    3.109100] [<c0137d34>] (driver_probe_device) from [<c0138038>] (__driver_attach+0x70/0x94)
[    3.109130]  r9:c035c880 r8:c033c520 r7:c03579f4 r6:c0351ed8 r5:c3869e34 r4:c3869e00
[    3.109283] [<c0137fc8>] (__driver_attach) from [<c01365dc>] (bus_for_each_dev+0x74/0x98)
[    3.109313]  r7:c03579f4 r6:c0137fc8 r5:c0351ed8 r4:00000000
[    3.109436] [<c0136568>] (bus_for_each_dev) from [<c0137954>] (driver_attach+0x20/0x28)
[    3.109466]  r6:c3a244e0 r5:00000000 r4:c0351ed8
[    3.109558] [<c0137934>] (driver_attach) from [<c01375f8>] (bus_add_driver+0xe8/0x1d4)
[    3.109649] [<c0137510>] (bus_add_driver) from [<c0138474>] (driver_register+0xa4/0xe8)
[    3.109680]  r7:c033c520 r6:00000000 r5:c0230be8 r4:c0351ed8
[    3.109802] [<c01383d0>] (driver_register) from [<c0154bc4>] (spi_register_driver+0x4c/0x60)
[    3.109832]  r5:c0230be8 r4:c3a05860
[    3.109924] [<c0154b78>] (spi_register_driver) from [<c0230bfc>] (mipid_spi_driver_init+0x14/0x1c)
[    3.110015] [<c0230be8>] (mipid_spi_driver_init) from [<c000951c>] (do_one_initcall+0x10c/0x1c4)
[    3.110107] [<c0009410>] (do_one_initcall) from [<c0221dd4>] (kernel_init_freeable+0xfc/0x1c0)
[    3.110137]  r9:c035c880 r8:c035c880 r7:c0234ef0 r6:c0238270 r5:00000048 r4:00000006
[    3.110290] [<c0221cd8>] (kernel_init_freeable) from [<c0196750>] (kernel_init+0x10/0xec)
[    3.110321]  r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:c0196740 r4:00000000
[    3.110443] [<c0196740>] (kernel_init) from [<c000a0f8>] (ret_from_fork+0x14/0x3c)
[    3.110473]  r5:c0196740 r4:00000000
[    3.110534] omapfb omapfb: HWA742: can't setup tearing synchronization
[    3.111389] omapfb omapfb: controller initialization failed (-33)
[    3.112152] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[    3.117492] console [ttyS0] disabled
[    3.137908] serial8250.0: ttyS0 at MMIO 0xfffb0000 (irq = 46, base_baud = 3000000) is a ST16654
[    5.482666] console [ttyS0] enabled
[    5.508422] serial8250.0: ttyS1 at MMIO 0xfffb0800 (irq = 47, base_baud = 3000000) is a ST16654
[    5.539245] serial8250.0: ttyS2 at MMIO 0xfffb9800 (irq = 15, base_baud = 3000000) is a ST16654
[    5.550994] usbcore: registered new interface driver usb-storage
[    5.558013] ads7846 spi2.0: touchscreen, irq 174
[    5.564147] input: ADS7846 Touchscreen as /devices/platform/omap_uwire/spi_master/spi2/spi2.0/input/input0
[    5.575653] retu-mfd 2-0001: Retu v3.2 found
[    5.582244] retu-mfd 2-0002: Tahvo v5.2 found
[    5.590454] mmci-omap mmci-omap.1: Runtime PM disabled, clock forced on.
[    5.597442] mmci-omap mmci-omap.1: Runtime PM disabled, clock forced on.
[    5.638610] usbcore: registered new interface driver usbhid
[    5.644256] usbhid: USB HID core driver
[    5.650604] mmci-omap mmci-omap.1: command timeout (CMD52)
[    5.657257] mmci-omap mmci-omap.1: command timeout (CMD52)
[    5.668060] mmci-omap mmci-omap.1: command timeout (CMD8)
[    5.674621] mmci-omap mmci-omap.1: command timeout (CMD5)
[    5.691864] Freeing unused kernel memory: 1124K (c0221000 - c033a000)
[    5.699554] mmci-omap mmci-omap.1: command timeout (CMD5)
[    5.705871] mmci-omap mmci-omap.1: command timeout (CMD5)
[    5.712860] mmci-omap mmci-omap.1: command timeout (CMD5)
[    5.719329] mmci-omap mmci-omap.1: command timeout (CMD55)
[    5.725799] mmci-omap mmci-omap.1: command timeout (CMD55)
[    5.732666] mmci-omap mmci-omap.1: command timeout (CMD55)
[    5.739227] mmci-omap mmci-omap.1: command timeout (CMD55)
[    6.205718] mmc0: new MMC card at address 0001
[    6.217559] mmcblk0: mmc0:0001 NCard  1.86 GiB 
[    6.225738] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    6.237121]  mmcblk0: p1 p2
[    6.263214] ohci-omap: OHCI OMAP driver
[    6.267608] ohci ohci: OMAP OHCI
[    6.271026] ohci ohci: new USB bus registered, assigned bus number 1
[    6.277984] ohci ohci: irq 38, io mem 0xfffba000
[    8.268981] hub 1-0:1.0: USB hub found
[    8.273010] hub 1-0:1.0: 3 ports detected
Waiting for kexec media to appear... Press ENTER to interrupt.
Found /dev/mmcblk0p1. Press ENTER to interrupt.
[   10.733978] EXT2-fs (mmcblk0p1): warning: mounting unchecked fs, running e2fsck is recommended
ifdown: socket: Function not implemented[   14.203186] kexec: Starting new kernel

[   14.207916] Bye!

A.

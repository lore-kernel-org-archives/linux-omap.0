From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: [BISECTED] Nokia 770 framebuffer breakage
Date: Tue, 20 Oct 2015 11:50:03 +0300
Message-ID: <20151020085003.GA16268@blackmetal.musicnaut.iki.fi>
References: <20151019193759.GE31069@blackmetal.musicnaut.iki.fi>
 <20151019200522.GJ32536@n2100.arm.linux.org.uk>
 <20151019222413.GG31069@blackmetal.musicnaut.iki.fi>
 <20151019225033.GK32536@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20151019225033.GK32536@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Mon, Oct 19, 2015 at 11:50:33PM +0100, Russell King - ARM Linux wrote:
> It shouldn't (I've been through the resulting assembly code.)  I wonder
> if this is fixing the problem, but it's now failing elsewhere instead.
> 
> What happens if you change it to:
> 
> 	l = clkdev_create(r, alias, alias_dev_name);
> 
> which should be 100% identical to how older kernels behaved

Ok, this and the earlier patch works on top of
2568999835d7797afce3dcc3a3f368051ffcaf1f, but not on 4.2 or newer - so
it fixes the clk_add_alias issue, and newer kernels have other issues...

> if that works, can you print out 'alias' and 'alias_dev_name' for
> every call to clk_add_alias() and send that please?

There is only one call:

arch/arm/mach-omap1/board-nokia770.c:   clk_add_alias("hwa_sys_ck", NULL, "bclk", NULL);

With newer kernels and this fix the kernel now hangs during FB
initialization. I tried to bisect it and it seemed to point to OMAP1
sparse IRQ changes. Unfortunately those are difficult to test because
e.g. commit 685e2d08c54b1a1bf31bbe6562f06db089d31c7b does not seem to
compile without some other changes...

Below is the boot log with 4.3-rc6 and clk_add_alias() fix:

Uncompressing Linux... done, booting the kernel.
[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 4.3.0-rc6-770_tiny-los_350d5+-dirty (aaro@amd-fx-6350) (gcc version 5.2.0 (GCC) ) #1 Tue Oct 20 11:32:43 EEST 2015
[    0.000000] CPU: ARM926EJ-S [41069263] revision 3 (ARMv5TEJ), cr=0005317f
[    0.000000] CPU: VIVT data cache, VIVT instruction cache
[    0.000000] Machine: Nokia 770
[    0.000000] Ignoring unrecognised tag 0x414f4d50
[    0.000000] debug: skip boot console de-registration.
[    0.000000] bootconsole [earlycon0] enabled
[    0.000000] Memory policy: Data cache writeback
[    0.000000] OMAP1710
[    0.000000]  revision 8 handled as 16xx id: 8b5f702f03330200
[    0.000000] Clocks: ARM_SYSST: 0x1000 DPLL_CTL: 0x2a93 ARM_CKCTL: 0x050e
[    0.000000] Clocking rate (xtal/DPLL1/MPU): 12.0/252.0/252.0 MHz
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 16256
[    0.000000] Kernel command line: mem=64M console=tty keep_bootcon=1 earlyprintk=1
[    0.000000] PID hash table entries: 256 (order: -2, 1024 bytes)
[    0.000000] Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
[    0.000000] Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
[    0.000000] Memory: 61528K/65536K available (1654K kernel code, 94K rwdata, 284K rodata, 1140K init, 184K bss, 4008K reserved, 0K cma-reserved)
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
[    0.000000]     vmalloc : 0xc4800000 - 0xff000000   ( 936 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xc4000000   (  64 MB)
[    0.000000]     modules : 0xbf000000 - 0xc0000000   (  16 MB)
[    0.000000]       .text : 0xc0008000 - 0xc01ecd0c   (1940 kB)
[    0.000000]       .init : 0xc01ed000 - 0xc030a000   (1140 kB)
[    0.000000]       .data : 0xc030a000 - 0xc03219e0   (  95 kB)
[    0.000000]        .bss : 0xc03219e0 - 0xc034fbd0   ( 185 kB)
[    0.000000] SLUB: HWalign=32, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
[    0.000000] NR_IRQS:16 nr_irqs:16 16
[    0.000000] Total of 128 interrupts in 4 interrupt banks
[    0.000000] clocksource: 32k_counter: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 58327039986419 ns
[    0.000030] sched_clock: 32 bits at 32kHz, resolution 30517ns, wraps every 65535999984741ns
[    0.008728] OMAP clocksource: 32k_counter at 32768 Hz
[    0.014556] Console: colour dummy device 80x30
[    0.019256] console [tty0] enabled
[    0.022918] Calibrating delay loop... 125.33 BogoMIPS (lpj=626688)
[    0.116790] pid_max: default: 32768 minimum: 301
[    0.122009] Mount-cache hash table entries: 1024 (order: 0, 4096 bytes)
[    0.129058] Mountpoint-cache hash table entries: 1024 (order: 0, 4096 bytes)
[    0.138214] CPU: Testing write buffer coherency: ok
[    0.144409] Setting up static identity map for 0x10008400 - 0x1000843c
[    0.155426] devtmpfs: initialized
[    0.164703] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
[    0.176940] DMA: preallocated 256 KiB pool for atomic coherent allocations
[    0.186126] irq: Cannot allocate irq_descs @ IRQ144, assuming pre-allocated
[    0.194061] irq: Cannot allocate irq_descs @ IRQ160, assuming pre-allocated
[    0.201599] OMAP GPIO hardware version 1.1
[    0.206298] irq: Cannot allocate irq_descs @ IRQ176, assuming pre-allocated
[    0.214202] irq: Cannot allocate irq_descs @ IRQ192, assuming pre-allocated
[    0.221984] irq: Cannot allocate irq_descs @ IRQ208, assuming pre-allocated
[    0.231140] MUX: initialized V6_USB0_TXD
[    0.235443] MUX: initialized W5_USB0_SE0
[    0.239624] MUX: initialized Y5_USB0_RCV
[    0.243835] MUX: initialized AA9_USB0_VP
[    0.248016] MUX: initialized R9_USB0_VM
[    0.252105] USB: hmc 16, usb0 6 wires, Mini-AB on usb0
[    0.257904] MUX: initialized W19_1610_MMC2_DATDIR1
[    0.264099] Clocking rate (xtal/DPLL1/MPU): 12.0/216.0/216.0 MHz
[    0.274444] OMAP DMA hardware version 1
[    0.278594] DMA capabilities: 0000000c:00000000:01ff:003f:007f
[    0.300109] omap-dma-engine omap-dma-engine: failed to get L1 IRQ: -6
[    0.315734] omap-dma-engine omap-dma-engine: OMAP DMA engine driver
[    0.324127] SCSI subsystem initialized
[    0.328460] omap_uwire omap_uwire: Runtime PM disabled, clock forced on.
[    0.338409] usbcore: registered new interface driver usbfs
[    0.344818] usbcore: registered new interface driver hub
[    0.350799] usbcore: registered new device driver usb
[    0.357635] clocksource: Switched to clocksource 32k_counter
[    3.221191] OMAP OCPI interconnect driver loaded
[    3.253540] io scheduler noop registered (default)
[    3.259918] omapfb: lph8923 rev 92 LCD detected, 16 data lines
[    3.266723] omapfb: configured for panel lph8923
[    3.280883] omapfb: LCDC initialized
[    3.284942] omapfb omapfb: SoSSI version 1.21 initialized
[    3.291442] omapfb omapfb: : Epson HWA742 LCD controller rev 1 initialized (CNF pins 7)
[    3.300231] omapfb omapfb: HWA742: setting update mode to auto

--> It hangs here until the watchdog turns off the power.

A.

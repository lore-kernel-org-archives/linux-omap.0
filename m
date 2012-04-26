From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH-V5 3/3] ARM: OMAP: Make OMAP clocksource source
 selection using kernel param
Date: Thu, 26 Apr 2012 16:20:10 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83E9FF78E@DBDE01.ent.ti.com>
References: <1335362340-14960-1-git-send-email-hvaibhav@ti.com>
 <1335362340-14960-4-git-send-email-hvaibhav@ti.com>
 <alpine.DEB.2.00.1204260904580.10308@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:48791 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757723Ab2DZQU1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Apr 2012 12:20:27 -0400
In-Reply-To: <alpine.DEB.2.00.1204260904580.10308@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "Hilman, Kevin" <khilman@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Balbi, Felipe" <balbi@ti.com>, "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>, Ming Lei <tom.leiming@gmail.com>

On Thu, Apr 26, 2012 at 20:40:34, Paul Walmsley wrote:
> Hi
> 
> a question
> 
> On Wed, 25 Apr 2012, Vaibhav Hiremath wrote:
> 
> > Current OMAP code supports couple of clocksource options based
> > on compilation flag (CONFIG_OMAP_32K_TIMER). The 32KHz sync-timer
> > and a gptimer which can run on 32KHz or system clock (e.g 38.4 MHz).
> > So there can be 3 options -
> > 
> > 1. 32KHz sync-timer
> > 2. Sys_clock based (e.g 13/19.2/26/38.4 MHz) gptimer
> > 3. 32KHz based gptimer.
> > 
> > The optional gptimer based clocksource was added so that it can
> > give the high precision than sync-timer, so expected usage was 2
> > and not 3.
> > Unfortunately option 2, clocksource doesn't meet the requirement of
> > free-running clock as per clocksource need. It stops in low power states
> > when sys_clock is cut. That makes gptimer based clocksource option
> > useless for OMAP2/3/4 devices with sys_clock as a clock input.
> > So, in order to use option 2, deeper idle state MUST be disabled.
> > 
> > Option 3 will still work but it is no better than 32K sync-timer
> > based clocksource.
> > 
> > We must support both sync timer and gptimer based clocksource as
> > some OMAP based derivative SoCs like AM33XX does not have the
> > sync timer.
> > 
> > Considering above, make sync-timer and gptimer clocksource runtime
> > selectable so that both OMAP and AMXXXX continue to use the same code.
> > 
> > Also, in order to precisely configure/setup sched_clock for given
> > clocksource, decision has to be made early enough in boot sequence.
> > 
> > So, the solution is,
> > 
> > Use standard kernel parameter ("clocksource=") to override
> > default 32k_sync-timer, in addition to this, we also use hwmod database
> > lookup mechanism, through which at run-time we can identify availability
> > of 32k-sync timer on the device, else fall back to gptimer.
> 
> ...
> 
> > -int __init omap_init_clocksource_32k(void)
> > +/**
> > + * omap_init_clocksource_32k - setup and register counter 32k as a
> > + * kernel clocksource
> > + * @pbase: base addr of counter_32k module
> > + * @size: size of counter_32k to map
> > + *
> > + * Returns 0 upon success or negative error code upon failure.
> > + *
> > + */
> > +int __init omap_init_clocksource_32k(u32 pbase, unsigned long size)
> >  {
> > -	static char err[] __initdata = KERN_ERR
> > -			"%s: can't register clocksource!\n";
> > -
> > -	if (cpu_is_omap16xx() || cpu_class_is_omap2()) {
> > -		u32 pbase;
> > -		unsigned long size = SZ_4K;
> > -		void __iomem *base;
> > -		struct clk *sync_32k_ick;
> > -
> > -		if (cpu_is_omap16xx()) {
> > -			pbase = OMAP16XX_TIMER_32K_SYNCHRONIZED;
> > -			size = SZ_1K;
> > -		} else if (cpu_is_omap2420())
> > -			pbase = OMAP2420_32KSYNCT_BASE + 0x10;
> > -		else if (cpu_is_omap2430())
> > -			pbase = OMAP2430_32KSYNCT_BASE + 0x10;
> > -		else if (cpu_is_omap34xx())
> > -			pbase = OMAP3430_32KSYNCT_BASE + 0x10;
> > -		else if (cpu_is_omap44xx())
> > -			pbase = OMAP4430_32KSYNCT_BASE + 0x10;
> > -		else
> > -			return -ENODEV;
> > -
> > -		/* For this to work we must have a static mapping in io.c for this area */
> > -		base = ioremap(pbase, size);
> > -		if (!base)
> > -			return -ENODEV;
> > -
> > -		sync_32k_ick = clk_get(NULL, "omap_32ksync_ick");
> > -		if (!IS_ERR(sync_32k_ick))
> > -			clk_enable(sync_32k_ick);
> > -
> > -		timer_32k_base = base;
> > -
> > -		/*
> > -		 * 120000 rough estimate from the calculations in
> > -		 * __clocksource_updatefreq_scale.
> > -		 */
> > -		clocks_calc_mult_shift(&persistent_mult, &persistent_shift,
> > -				32768, NSEC_PER_SEC, 120000);
> > -
> > -		if (clocksource_mmio_init(base, "32k_counter", 32768, 250, 32,
> > -					  clocksource_mmio_readl_up))
> > -			printk(err, "32k_counter");
> > -
> > -		setup_sched_clock(omap_32k_read_sched_clock, 32, 32768);
> > +	int ret;
> > +	void __iomem *base;
> > +	struct clk *sync32k_ick;
> > +
> > +	if (!pbase || !size)
> > +		return -ENODEV;
> > +	/*
> > +	 * For this to work we must have a static mapping in io.c
> > +	 * for this area
> > +	 */
> > +	base = ioremap(pbase, size);
> > +	if (!base) {
> > +		pr_err("32k_counter: failed to map base addr\n");
> > +		return -ENODEV;
> >  	}
> > -	return 0;
> > +
> > +	sync32k_ick = clk_get(NULL, "omap_32ksync_ick");
> > +	if (!IS_ERR(sync32k_ick))
> > +		clk_enable(sync32k_ick);
> 
> You've added hwmod data for this IP block, which is good.  This will 
> presumably cause the IP block to be idled on boot.  But you haven't 
> converted this code to use either the hwmod enable code -- just using 
> clk_get() isn't enough.  (Better would be to use a driver and the PM 
> runtime functions, of course, but maybe this runs too early?)

Yes, this runs very early in the boot sequence.

> 
> If the 32k sync timer is in OCP force-idle, then that might produce the 
> hangs you're seeing.
> 

Not really, I reverted all my patch-sets and just added changed for,

-----------------Change ontop of linux-omap/master--------

diff --git a/arch/arm/plat-omap/counter_32k.c b/arch/arm/plat-omap/counter_32k.c
index 5068fe5..12e5777 100644
--- a/arch/arm/plat-omap/counter_32k.c
+++ b/arch/arm/plat-omap/counter_32k.c
@@ -87,7 +87,7 @@ int __init omap_init_clocksource_32k(void)
                else if (cpu_is_omap2430())
                        pbase = OMAP2430_32KSYNCT_BASE + 0x10;
                else if (cpu_is_omap34xx())
-                       pbase = OMAP3430_32KSYNCT_BASE + 0x10;
+                       pbase = OMAP3430_32KSYNCT_BASE;
                else if (cpu_is_omap44xx())
                        pbase = OMAP4430_32KSYNCT_BASE + 0x10;
                else
@@ -102,7 +102,7 @@ int __init omap_init_clocksource_32k(void)
                if (!IS_ERR(sync_32k_ick))
                        clk_enable(sync_32k_ick);

-               timer_32k_base = base;
+               timer_32k_base = base + 0x10;

                /*
                 * 120000 rough estimate from the calculations in

---------------------------------------------

This itself results in kernel hang, means execution gets stuck in 
default_idle(),


Boot Log -
============================

Bytes transferred = 2022580 (1edcb4 hex)
## Booting kernel from Legacy Image at 81000000 ...
   Image Name:   Linux-3.4.0-rc3-11786-g1e32b7e-d
   Image Type:   ARM Linux Kernel Image (uncompressed)
   Data Size:    3391152 Bytes = 3.2 MiB
   Load Address: 80008000
   Entry Point:  80008000
   Verifying Checksum ... OK
   Loading Kernel Image ... OK
OK

Starting kernel ...

Uncompressing Linux... done, booting the kernel.
[    0.000000] Booting Linux on physical CPU 0
[    0.000000] Linux version 3.4.0-rc3-11786-g1e32b7e-dirty (a0393758@psplinux064) (gcc version 4.5.3 20110311 (prerelease) (GCC) ) #24 SMP Thu Apr 26 21:46:45 IST 2012
[    0.000000] CPU: ARMv7 Processor [413fc082] revision 2 (ARMv7), cr=10c53c7d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
[    0.000000] Machine: OMAP3 EVM
[    0.000000] Memory policy: ECC disabled, Data cache writeback
[    0.000000] OMAP3630 ES1.2 (l2cache iva sgx neon isp 192mhz_clk )
[    0.000000] Clocking rate (Crystal/Core/MPU): 26.0/400/600 MHz
[    0.000000] PERCPU: Embedded 8 pages/cpu @c0d1f000 s11456 r8192 d13120 u32768
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 32256
[    0.000000] Kernel command line: console=ttyO0,115200n8 mem=128M root=/dev/ram rw initrd=0x82000000,16MB ramdisk_size=65536 earlyprintk=serial
[    0.000000] PID hash table entries: 512 (order: -1, 2048 bytes)
[    0.000000] Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
[    0.000000] Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
[    0.000000] Memory: 127MB = 127MB total
[    0.000000] Memory: 100096k/100096k available, 30976k reserved, 0K highmem
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
[    0.000000]     vmalloc : 0xc8800000 - 0xff000000   ( 872 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xc8000000   ( 128 MB)
[    0.000000]     modules : 0xbf000000 - 0xc0000000   (  16 MB)
[    0.000000]       .text : 0xc0008000 - 0xc05e3ca0   (6000 kB)
[    0.000000]       .init : 0xc05e4000 - 0xc0631cc0   ( 312 kB)
[    0.000000]       .data : 0xc0632000 - 0xc06c6898   ( 595 kB)
[    0.000000]        .bss : 0xc06c68bc - 0xc0c1ac60   (5457 kB)
[    0.000000] Hierarchical RCU implementation.
[    0.000000] NR_IRQS:474
[    0.000000] IRQ: Found an INTC at 0xfa200000 (revision 4.0) with 96 interrupts
[    0.000000] Total of 96 interrupts on 1 active controller
[    0.000000] OMAP clockevent source: GPTIMER1 at 32768 Hz
[    0.000000] sched_clock: 32 bits at 32kHz, resolution 30517ns, wraps every 131071999ms
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
[    0.000885] Calibrating delay loop... 597.64 BogoMIPS (lpj=2334720)
[    0.085937] pid_max: default: 32768 minimum: 301
[    0.086669] Security Framework initialized
[    0.086944] Mount-cache hash table entries: 512
[    0.092224] CPU: Testing write buffer coherency: ok
[    0.093139] CPU0: thread -1, cpu 0, socket -1, mpidr 0
[    0.093200] Setting up static identity map for 0x80433d68 - 0x80433dd8
[    0.094909] Brought up 1 CPUs
[    0.094940] SMP: Total of 1 processors activated (597.64 BogoMIPS).
[    0.116607] dummy:
[    0.118927] NET: Registered protocol family 16
[    0.120208] GPMC revision 5.0
[    0.120452] gpmc: irq-20 could not claim: err -22
[    0.130798] gpiochip_add: registered GPIOs 0 to 31 on device: gpio
[    0.131347] OMAP GPIO hardware version 2.5
[    0.132415] gpiochip_add: registered GPIOs 32 to 63 on device: gpio
[    0.134368] gpiochip_add: registered GPIOs 64 to 95 on device: gpio
[    0.135833] gpiochip_add: registered GPIOs 96 to 127 on device: gpio
[    0.137298] gpiochip_add: registered GPIOs 128 to 159 on device: gpio
[    0.138732] gpiochip_add: registered GPIOs 160 to 191 on device: gpio
[    0.146514] omap_mux_init: Add partition: #1: core, flags: 0
[    0.168121] Reprogramming SDRC clock to 400000000 Hz
[    0.168151] dpll3_m2_clk rate change failed: -22
[    0.170196] hw-breakpoint: debug architecture 0x4 unsupported.
[    0.185394]  omap-mcbsp.2: alias fck already exists
[    0.186157]  omap-mcbsp.3: alias fck already exists
[    0.191101] OMAP DMA hardware revision 5.0
[    0.257019] bio: create slab <bio-0> at 0
[    0.261627] fixed-dummy:
[    0.267669] SCSI subsystem initialized
[    0.269744] omap2_mcspi omap2_mcspi.1: master is unqueued, this is deprecated
[    0.272705] omap2_mcspi omap2_mcspi.2: master is unqueued, this is deprecated
[    0.274291] omap2_mcspi omap2_mcspi.3: master is unqueued, this is deprecated
[    0.275451] omap2_mcspi omap2_mcspi.4: master is unqueued, this is deprecated
[    0.278686] usbcore: registered new interface driver usbfs
[    0.279724] usbcore: registered new interface driver hub
[    0.280426] usbcore: registered new device driver usb
[    0.297424] omap_i2c omap_i2c.1: bus 1 rev1.4.0 at 2600 kHz
[    0.307464] twl 1-0048: PIH (irq 7) chaining IRQs 320..328
[    0.308166] twl 1-0048: power (irq 325) chaining IRQs 328..335
[    0.310638] twl4030_gpio twl4030_gpio: gpio (irq 320) chaining IRQs 336..353
[    0.312103] gpiochip_add: registered GPIOs 192 to 211 on device: twl4030
[    0.323120] VIO: 1800 mV normal standby
[    0.325561] vdd_mpu_iva: 600 <--> 1450 mV normal
[    0.327758] vdd_core: 600 <--> 1450 mV normal
[    0.330444] VMMC1: 1850 <--> 3150 mV at 3000 mV normal standby
[    0.332885] VDAC: 1800 mV normal standby
[    0.335205] VPLL2: 1800 mV normal standby
[    0.337921] VSIM: 1800 <--> 3000 mV at 1800 mV normal standby
[    0.351806] omap_i2c omap_i2c.2: bus 2 rev1.4.0 at 400 kHz
[    0.367370] omap_i2c omap_i2c.3: bus 3 rev1.4.0 at 400 kHz
[    0.375946] Switching to clocksource 32k_counter
[    0.488311] NET: Registered protocol family 2
[    0.489227] IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
[    0.491394] TCP established hash table entries: 4096 (order: 3, 32768 bytes)
[    0.491699] TCP bind hash table entries: 4096 (order: 5, 147456 bytes)
[    0.493957] TCP: Hash tables configured (established 4096 bind 4096)
[    0.494049] TCP: reno registered
[    0.494079] UDP hash table entries: 64 (order: 0, 5120 bytes)
[    0.494445] UDP-Lite hash table entries: 64 (order: 0, 5120 bytes)
[    0.495422] NET: Registered protocol family 1
[    0.496978] RPC: Registered named UNIX socket transport module.
[    0.497009] RPC: Registered udp transport module.
[    0.497039] RPC: Registered tcp transport module.
[    0.497039] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.497924] Trying to unpack rootfs image as initramfs...
[    0.499999] rootfs image is not initramfs (no cpio magic); looks like an initrd
[    0.620941] Freeing initrd memory: 16384K
[    0.621124] NetWinder Floating Point Emulator V0.97 (double precision)
[    0.786560] VFS: Disk quotas dquot_6.5.2
[    0.786895] Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
[    0.788635] NFS: Registering the id_resolver key type
[    0.790588] jffs2: version 2.2. (NAND) (SUMMARY)  (c) 2001-2006 Red Hat, Inc.
[    0.791748] msgmni has been set to 227
[    0.795349] io scheduler noop registered
[    0.795379] io scheduler deadline registered
[    0.795623] io scheduler cfq registered (default)
[    0.798309] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    0.805297] omap_uart.0: ttyO0 at MMIO 0x4806a000 (irq = 72) is a OMAP UART0
[    1.511840] console [ttyO0] enabled
[    1.517364] omap_uart.1: ttyO1 at MMIO 0x4806c000 (irq = 73) is a OMAP UART1
[    1.526306] omap_uart.2: ttyO2 at MMIO 0x49020000 (irq = 74) is a OMAP UART2
[    1.535186] omap_uart.3: ttyO3 at MMIO 0x49042000 (irq = 80) is a OMAP UART3
[    1.575927] brd: module loaded
[    1.598480] loop: module loaded
[    1.609771] mtdoops: mtd device (mtddev=name/number) must be supplied
[    1.617431] OneNAND driver initializing
[    1.627929] smsc911x: Driver version 2008-10-21
[    1.641845] smsc911x-mdio: probed
[    1.645599] smsc911x smsc911x.0: eth0: attached PHY driver [SMSC LAN8700] (mii_bus:phy_addr=smsc911x-0:01, irq=-1)
[    1.656829] smsc911x smsc911x.0: eth0: MAC Address: 00:50:c2:7e:8f:d9
[    1.664978] usbcore: registered new interface driver asix
[    1.671203] usbcore: registered new interface driver cdc_ether
[    1.677947] usbcore: registered new interface driver net1080
[    1.684417] usbcore: registered new interface driver cdc_subset
[    1.691223] usbcore: registered new interface driver zaurus
[    1.697662] usbcore: registered new interface driver cdc_ncm
[    1.705780] usbcore: registered new interface driver cdc_wdm
[    1.711791] Initializing USB Mass Storage driver...
[    1.717529] usbcore: registered new interface driver usb-storage
[    1.723876] USB Mass Storage support registered.
[    1.729949] usbcore: registered new interface driver libusual
[    1.736663] usbcore: registered new interface driver usbtest
[    1.744323] mousedev: PS/2 mouse device common for all mice
[    1.752960] input: TWL4030 Keypad as /devices/platform/omap_i2c.1/i2c-1/1-004a/twl4030_keypad/input/input0
[    1.770904] ads7846 spi1.0: touchscreen, irq 271
[    1.778656] input: ADS7846 Touchscreen as /devices/platform/omap2_mcspi.1/spi_master/spi1/spi1.0/input/input1
[    1.793945] input: twl4030_pwrbutton as /devices/platform/omap_i2c.1/i2c-1/1-0049/twl4030_pwrbutton/input/input2
[    1.806579] twl_rtc twl_rtc: Power up reset detected.
[    1.812042] twl_rtc twl_rtc: Enabling TWL-RTC
[    1.820617] twl_rtc twl_rtc: rtc core: registered twl_rtc as rtc0
[    1.828491] i2c /dev entries driver
[    1.836090] Driver for 1-wire Dallas network protocol.
[    1.844848] omap_wdt: OMAP Watchdog Timer Rev 0x31: initial timeout 60 sec
[    1.853210] twl4030_wdt twl4030_wdt: Failed to register misc device
[    1.859863] twl4030_wdt: probe of twl4030_wdt failed with error -16

<Stuck in default idle>

Thanks,
Vaibhav

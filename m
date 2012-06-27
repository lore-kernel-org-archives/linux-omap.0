From: Kevin Hilman <khilman@ti.com>
Subject: Re: DM3730 without PMIC oops on idle
Date: Tue, 26 Jun 2012 21:58:39 -0500
Message-ID: <87ehp1tq8w.fsf@ti.com>
References: <CAGGh5h2PEpcZc-BRVb9UJD0VKLFBAktQ0r08T-0XAovZ1W7MZw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:45725 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755719Ab2F0C6d (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 26 Jun 2012 22:58:33 -0400
Received: by ghbg16 with SMTP id g16so618961ghb.31
        for <linux-omap@vger.kernel.org>; Tue, 26 Jun 2012 19:58:32 -0700 (PDT)
In-Reply-To: <CAGGh5h2PEpcZc-BRVb9UJD0VKLFBAktQ0r08T-0XAovZ1W7MZw@mail.gmail.com>
	(jean-philippe francois's message of "Fri, 22 Jun 2012 16:49:26
	+0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: jean-philippe francois <jp.francois@cynove.com>
Cc: linux-omap@vger.kernel.org

jean-philippe francois <jp.francois@cynove.com> writes:

> Hi,
>
> My board does not have any Power Management IC.
> Without the following patch, the bood ends with an oops.
> How can I further debug this, ie trace through the assembly
> in arch/arm/mach-omap2/sleep34xx.S ?

The assembly code that is faulting has nothing to do with interaction
with the PMIC.  

Some more comments below ...

> --
> Patch needed to boot to userspace :
>
> Index: linux-3.4.3/arch/arm/mach-omap2/pm34xx.c
> ===================================================================
> --- linux-3.4.3.orig/arch/arm/mach-omap2/pm34xx.c	2012-06-17
> 20:21:44.000000000 +0200
> +++ linux-3.4.3/arch/arm/mach-omap2/pm34xx.c	2012-06-22 16:26:38.000000000 +0200
> @@ -403,7 +403,7 @@
>  	trace_power_start(POWER_CSTATE, 1, smp_processor_id());
>  	trace_cpu_idle(1, smp_processor_id());
>
> -	omap_sram_idle();
> +	//	omap_sram_idle();

FYI... you can get the same effect without patching the kernel by adding
'nohlt' to the kernel command line.  That avoids entering the idle loop
alltogether.

>  	trace_power_end(smp_processor_id());
>  	trace_cpu_idle(PWR_EVENT_EXIT, smp_processor_id());
>
> --
> Bootlog without patch :
> Booting Linux on physical CPU 0
> Linux version 3.4.3 (cynove@jp) (gcc version 4.3.2 (Sourcery G++ Lite
> 2008q3-41) ) #2 PREEMPT Fri Jun 22 16:33:06 CEST 2012
> CPU: ARMv7 Processor [413fc082] revision 2 (ARMv7), cr=10c53c7d
> CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
> Machine: Cynove CYDM3730
> Reserving 4194304 bytes SDRAM for VRAM
> Memory policy: ECC disabled, Data cache writeback
> OMAP3630 ES1.2 (l2cache iva sgx neon isp 192mhz_clk )
> Clocking rate (Crystal/Core/MPU): 19.2/400/832 MHz
> Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 45056
> Kernel command line: console=ttyO2,115200n8 rdinit=/sbin/init
> initrd=0x83000000,1536k
> mtdparts=omap2-nand.0:1024k(bootloaders),3072k(linux),1536k(ramfs),-(usr)
> ubi.mtd=3,2048 mem=55M@0x80000000 mem=128M@0x88000000
> PID hash table entries: 1024 (order: 0, 4096 bytes)
> Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
> Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
> Memory: 55MB 123MB = 178MB total
> Memory: 174688k/174688k available, 12704k reserved, 0K highmem
> Virtual kernel memory layout:
>     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
>     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
>     vmalloc : 0xd0800000 - 0xff000000   ( 744 MB)
>     lowmem  : 0xc0000000 - 0xd0000000   ( 256 MB)
>     modules : 0xbf000000 - 0xc0000000   (  16 MB)
>       .text : 0xc0008000 - 0xc03c5080   (3829 kB)
>       .init : 0xc03c6000 - 0xc03ef000   ( 164 kB)
>       .data : 0xc03f0000 - 0xc042b6c8   ( 238 kB)
>        .bss : 0xc042b6ec - 0xc043bdc8   (  66 kB)
> NR_IRQS:440
> IRQ: Found an INTC at 0xfa200000 (revision 4.0) with 96 interrupts
> Total of 96 interrupts on 1 active controller
> OMAP clockevent source: GPTIMER1 at 32768 Hz
> sched_clock: 32 bits at 32kHz, resolution 30517ns, wraps every 131071999ms
> Console: colour dummy device 80x30
> Calibrating delay loop... 831.32 BogoMIPS (lpj=3246080)
> pid_max: default: 32768 minimum: 301
> Mount-cache hash table entries: 512
> CPU: Testing write buffer coherency: ok
> Setting up static identity map for 0x802ad4b0 - 0x802ad508
> devtmpfs: initialized
> dummy:
> NET: Registered protocol family 16
> GPMC revision 5.0
> gpiochip_add: registered GPIOs 0 to 31 on device: gpio
> OMAP GPIO hardware version 2.5
> gpiochip_add: registered GPIOs 32 to 63 on device: gpio
> gpiochip_add: registered GPIOs 64 to 95 on device: gpio
> gpiochip_add: registered GPIOs 96 to 127 on device: gpio
> gpiochip_add: registered GPIOs 128 to 159 on device: gpio
> gpiochip_add: registered GPIOs 160 to 191 on device: gpio
> omap_mux_init: Add partition: #1: core, flags: 0
> GPMC CS4: cs_on     :   2 ticks,  10 ns (was   1 ticks)  10 ns
> GPMC CS4: cs_rd_off :  12 ticks,  60 ns (was  16 ticks)  60 ns
> GPMC CS4: cs_wr_off :  12 ticks,  60 ns (was  16 ticks)  60 ns
> GPMC CS4: adv_on    :   0 ticks,   0 ns (was   1 ticks)   0 ns
> GPMC CS4: adv_rd_off:   0 ticks,   0 ns (was   2 ticks)   0 ns
> GPMC CS4: adv_wr_off:   0 ticks,   0 ns (was   2 ticks)   0 ns
> GPMC CS4: oe_on     :   2 ticks,  10 ns (was   3 ticks)  10 ns
> GPMC CS4: oe_off    :  12 ticks,  60 ns (was  16 ticks)  60 ns
> GPMC CS4: we_on     :   2 ticks,  10 ns (was   3 ticks)  10 ns
> GPMC CS4: we_off    :  12 ticks,  60 ns (was  16 ticks)  60 ns
> GPMC CS4: rd_cycle  :  14 ticks,  70 ns (was  17 ticks)  70 ns
> GPMC CS4: wr_cycle  :  14 ticks,  70 ns (was  17 ticks)  70 ns
> GPMC CS4: access    :  12 ticks,  60 ns (was  15 ticks)  60 ns
> GPMC CS4: page_burst_access:   0 ticks,   0 ns (was   1 ticks)   0 ns
> GPMC CS4: wr_data_mux_bus:   0 ticks,   0 ns (was   3 ticks)   0 ns
> GPMC CS4: wr_access :   2 ticks,  10 ns (was  15 ticks)  10 ns
> OMAP DMA hardware revision 5.0
> bio: create slab <bio-0> at 0
> SCSI subsystem initialized
> omap2_mcspi omap2_mcspi.1: master is unqueued, this is deprecated
> omap2_mcspi omap2_mcspi.2: master is unqueued, this is deprecated
> omap2_mcspi omap2_mcspi.3: master is unqueued, this is deprecated
> omap2_mcspi omap2_mcspi.4: master is unqueued, this is deprecated
> omap_i2c omap_i2c.1: bus 1 rev1.4.0 at 100 kHz
> Linux media interface: v0.10
> Linux video capture interface: v2.00
> omap-iommu omap-iommu.0: isp registered
> Switching to clocksource 32k_counter
> NET: Registered protocol family 2
> IP route cache hash table entries: 2048 (order: 1, 8192 bytes)
> TCP established hash table entries: 8192 (order: 4, 65536 bytes)
> TCP bind hash table entries: 8192 (order: 3, 32768 bytes)
> TCP: Hash tables configured (established 8192 bind 8192)
> TCP: reno registered
> UDP hash table entries: 256 (order: 0, 4096 bytes)
> UDP-Lite hash table entries: 256 (order: 0, 4096 bytes)
> NET: Registered protocol family 1
> Trying to unpack rootfs image as initramfs...
> Freeing initrd memory: 1536K
> msgmni has been set to 344
> io scheduler noop registered
> io scheduler deadline registered
> io scheduler cfq registered (default)
> OMAP DSS rev 2.0
> omapdss_venc supply vdda_dac not found, using dummy regulator
> omap_uart.0: ttyO0 at MMIO 0x4806a000 (irq = 72) is a OMAP UART0
> omap_uart.1: ttyO1 at MMIO 0x4806c000 (irq = 73) is a OMAP UART1
> omap_uart.2: ttyO2 at MMIO 0x49020000 (irq = 74) is a OMAP UART2
> console [ttyO2] enabled
> omap_uart.3: ttyO3 at MMIO 0x49042000 (irq = 80) is a OMAP UART3
> brd: module loaded
> loop: module loaded
> ONFI param page 0 valid
> ONFI flash detected
> NAND device: Manufacturer ID: 0x2c, Chip ID: 0xac (Micron omap2-nand.0)
> NAND bus width 8 instead 16 bit
> No NAND device found
> NAND device: Manufacturer ID: 0x2c, Chip ID: 0xac (Micron NAND 512MiB
> 1,8V 8-bit)
> 4 cmdlinepart partitions found on MTD device omap2-nand.0
> Creating 4 MTD partitions on "omap2-nand.0":
> 0x000000000000-0x000000100000 : "bootloaders"
> 0x000000100000-0x000000400000 : "linux"
> 0x000000400000-0x000000580000 : "ramfs"
> 0x000000580000-0x000020000000 : "usram"
> UBI: attaching mtd3 to ubi0
> UBI: physical eraseblock size:   131072 bytes (128 KiB)
> UBI: logical eraseblock size:    126976 bytes
> UBI: smallest flash I/O unit:    2048
> UBI: sub-page size:              512
> UBI: VID header offset:          2048 (aligned 2048)
> UBI: data offset:                4096
> UBI: max. sequence number:       369
> UBI: attached mtd3 to ubi0
> UBI: MTD device name:            "usr"
> UBI: MTD device size:            506 MiB
> UBI: number of good PEBs:        4029
> UBI: number of bad PEBs:         23
> UBI: number of corrupted PEBs:   0
> UBI: max. allowed volumes:       128
> UBI: wear-leveling threshold:    4096
> UBI: number of internal volumes: 1
> UBI: number of user volumes:     1
> UBI: available PEBs:             0
> UBI: total number of reserved PEBs: 4029
> UBI: number of PEBs reserved for bad PEB handling: 40
> UBI: max/mean erase counter: 1/0
> UBI: image sequence number:  809116472
> UBI: background thread "ubi_bgt0d" started, PID 372
> mousedev: PS/2 mouse device common for all mice
> i2c /dev entries driver
> omap_wdt: OMAP Watchdog Timer Rev 0x31: initial timeout 60 sec
> mpu.0 supply vcc not found, using dummy regulator
> omap_cpufreq_init: physical regulator not present for MPU
> omap_hsmmc.0 supply vmmc not found, using dummy regulator
> omap_hsmmc.0 supply vmmc_aux not found, using dummy regulator
> omap_hsmmc omap_hsmmc.0: could not set regulator OCR (-22)
> ------------[ cut here ]------------
> WARNING: at drivers/regulator/core.c:1554 _regulator_disable+0x30/0x10c()
> unbalanced disables for dummy

This looks like a bug in the MMC driver when dummy regulator is used,
but is not related to the idle bug below.

> Modules linked in:
> [<c0012fd8>] (unwind_backtrace+0x0/0x128) from [<c002cf24>]
> (warn_slowpath_common+0x4c/0x64)
> [<c002cf24>] (warn_slowpath_common+0x4c/0x64) from [<c002cfbc>]
> (warn_slowpath_fmt+0x2c/0x3c)
> [<c002cfbc>] (warn_slowpath_fmt+0x2c/0x3c) from [<c0183080>]
> (_regulator_disable+0x30/0x10c)
> [<c0183080>] (_regulator_disable+0x30/0x10c) from [<c0183178>]
> (regulator_disable+0x1c/0x48)
> [<c0183178>] (regulator_disable+0x1c/0x48) from [<c021d64c>]
> (omap_hsmmc_set_power+0xc0/0x11c)
> [<c021d64c>] (omap_hsmmc_set_power+0xc0/0x11c) from [<c021d564>]
> (omap_hsmmc_reg_get+0x174/0x19c)
> [<c021d564>] (omap_hsmmc_reg_get+0x174/0x19c) from [<c02aa720>]
> (omap_hsmmc_probe+0x408/0x6a0)
> [<c02aa720>] (omap_hsmmc_probe+0x408/0x6a0) from [<c01a89a8>]
> (platform_drv_probe+0x18/0x1c)
> [<c01a89a8>] (platform_drv_probe+0x18/0x1c) from [<c01a77f0>]
> (really_probe+0xdc/0x254)
> [<c01a77f0>] (really_probe+0xdc/0x254) from [<c01a79f0>]
> (driver_probe_device+0x88/0xb0)
> [<c01a79f0>] (driver_probe_device+0x88/0xb0) from [<c01a7a78>]
> (__driver_attach+0x60/0x84)
> [<c01a7a78>] (__driver_attach+0x60/0x84) from [<c01a5f14>]
> (bus_for_each_dev+0x44/0x74)
> [<c01a5f14>] (bus_for_each_dev+0x44/0x74) from [<c01a671c>]
> (bus_add_driver+0xc0/0x1bc)
> [<c01a671c>] (bus_add_driver+0xc0/0x1bc) from [<c01a7ef0>]
> (driver_register+0xa0/0xd4)
> [<c01a7ef0>] (driver_register+0xa0/0xd4) from [<c00086fc>]
> (do_one_initcall+0x34/0xf8)
> [<c00086fc>] (do_one_initcall+0x34/0xf8) from [<c03c62e0>]
> (do_initcall_level+0x60/0x98)
> [<c03c62e0>] (do_initcall_level+0x60/0x98) from [<c03c632c>]
> (do_initcalls+0x14/0x20)
> [<c03c632c>] (do_initcalls+0x14/0x20) from [<c03c6430>] (kernel_init+0x4c/0xe0)
> [<c03c6430>] (kernel_init+0x4c/0xe0) from [<c000f044>]
> (kernel_thread_exit+0x0/0x8)
> ---[ end trace a05bda6605792137 ]---
> omap_hsmmc omap_hsmmc.0: could not set regulator OCR (-22)
> TCP: cubic registered
> NET: Registered protocol family 17
> NET: Registered protocol family 15
> Registering the dns_resolver key type
> VFP support v0.3: implementor 41 architecture 3 part 30 variant c rev 3
> omap_vc_init_channel: No PMIC info for vdd_core
> omap_vp_init: No PMIC info for vdd_core
> omap_vc_init_channel: No PMIC info for vdd_mpu_iva
> omap_vp_init: No PMIC info for vdd_mpu_iva
> omap_vc_pre_scale: Insufficient pmic info to scale the vdd_mpu_iva
> omap_vc_pre_scale: Insufficient pmic info to scale the vdd_core

This all looks normal when no PMIC is registered.  The voltage layer is
basically disabling itself because it can't do anything without PMIC
info.  That's correct.

> clock: disabling unused clocks to save power
> Unable to handle kernel NULL pointer dereference at virtual address 00000000
> pgd = c0004000
> [00000000] *pgd=00000000
> Internal error: Oops: 80000005 [#1] PREEMPT ARM
> Modules linked in:
> CPU: 0    Tainted: G        W     (3.4.3 #2)
> PC is at 0x0
> LR is at omap34xx_do_sram_idle+0x8/0x10

This is a branch to 0x0, probably in omap34xx_cpu_suspend (in
sleep34xx.S) which was just called by omap34xx_do_sram_idle.

My first guess would be that the omap3_do_wfi_sram address is zero.  Can
you dump the value in omap_push_sram_idle()?  If that looks good, do you
have a debugger setup so you can single step into omap34xx_cpu_suspend()
to find out where this is failing?

If not, if you can send me a kernel binary (preferably with
CONFIG_DEBUG_INFO=y enabled) and a corresponding crash dump for that
kernel, I should be able to tell where the branch to zero is happening
and maybe get a better idea.

Kevin

> pc : [<00000000>]    lr : [<c001d2bc>]    psr: 600000d3
> sp : c03f1f74  ip : cf463a90  fp : 00000000
> r10: 00000000  r9 : 413fc082  r8 : 80004059
> r7 : 00000001  r6 : 00000000  r5 : 00000000  r4 : c042c20c
> r3 : 00003430  r2 : 00000010  r1 : c03fc108  r0 : 00000000
> Flags: nZCv  IRQs off  FIQs off  Mode SVC_32  ISA ARM  Segment kernel
> Control: 10c5387d  Table: 80004019  DAC: 00000015
> Process swapper (pid: 0, stack limit = 0xc03f02e8)
> Stack: (0xc03f1f74 to 0xc03f2000)
> 1f60:                                              00000001 00000000 00000000
> 1f80: 00000001 80004059 413fc082 00000000 00000000 c001d2bc 00000001 c001d434
> 1fa0: c03f0000 c042b780 c03e6560 c03faff4 80004059 c001d568 c03f0000 c000f154
> 1fc0: c03f0000 c000f6ac c03f8134 c03c68b4 ffffffff ffffffff c03c6574 00000000
> 1fe0: 00000000 c03e6564 00000000 10c53c7d c03f808c 8000803c 00000000 00000000
> [<c001d2bc>] (omap34xx_do_sram_idle+0x8/0x10) from [<00000000>] (  (null))
> Code: bad PC value
> ---[ end trace a05bda6605792139 ]---
> Kernel panic - not syncing: Attempted to kill the idle task!
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

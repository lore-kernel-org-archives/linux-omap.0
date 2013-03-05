From: Mark Jackson <mpfj-list@mimc.co.uk>
Subject: Re: [PATCH 11/14] ARM: OMAP2+: Add device-tree support for NOR flash
Date: Tue, 05 Mar 2013 14:34:25 +0000
Message-ID: <51360271.1030302@mimc.co.uk>
References: <1361899842-30303-1-git-send-email-jon-hunter@ti.com> <1361899842-30303-12-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mercuryimc.plus.com ([80.229.200.144]:36272 "EHLO
	centos1.newflow.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755203Ab3CEOe1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Mar 2013 09:34:27 -0500
In-Reply-To: <1361899842-30303-12-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>, device-tree <devicetree-discuss@lists.ozlabs.org>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Daniel Mack <zonque@gmail.com>

On 26/02/13 17:30, Jon Hunter wrote:
> NOR flash is not currently supported when booting with device-tree
> on OMAP2+ devices. Add support to detect and configure NOR devices
> when booting with device-tree.
> 
> Add documentation for the TI GPMC NOR binding.
> 
> Signed-off-by: Jon Hunter <jon-hunter@ti.com>

I'm trying to test this series, and am unable get my NOR device recognised.

If I remove all reference to NOR (and keep only my NAND device definition), then
everything seems to boot fine (so I'm assuming I've got at least the basics of
the patch set working).

My GPMC tree looks like this:-

gpmc: gpmc@50000000 {
	compatible = "ti,am3352-gpmc", "simple-bus";
	ti,hwmods = "gpmc";
	status = "okay";
	gpmc,num-waitpins = <2>;
	pinctrl-names = "default";
	pinctrl-0 = <&gpmc_pins>;

	#address-cells = <2>;
	#size-cells = <1>;
	ranges = <0 0 0x08000000 0x10000000>,	/* CS0: NAND 256M */
		 <3 0 0x1a000000 0x04000000>;	/* CS3: NOR 64M */

	nand@0,0 {
		linux,mtd-name= "micron,mt29f2g08abaea";
		reg = <0 0x00000000 0x10000000>; /* CS0, offset 0 */
		nand-bus-width = <8>;
		ti,nand-ecc-opt = "bch8";

		gpmc,device-nand;
		gpmc,device-width = <1>;
		gpmc,wait-pin = <0>;

		gpmc,sync-clk = <0>;
		gpmc,cs-on = <0>;
		gpmc,cs-rd-off = <44>;
		gpmc,cs-wr-off = <44>;
		gpmc,adv-on = <6>;
		gpmc,adv-rd-off = <34>;
		gpmc,adv-wr-off = <44>;
		gpmc,we-off = <40>;
		gpmc,oe-off = <54>;
		gpmc,access = <64>;
		gpmc,rd-cycle = <82>;
		gpmc,wr-cycle = <82>;
		gpmc,wr-access = <40>;
		gpmc,wr-data-mux-bus = <0>;

		#address-cells = <1>;
		#size-cells = <1>;
		elm_id = <&elm>;

		/*
		MTD partition table
		===================
		+------------+-->0x00000000-> SPL start         (SPL copy on 1st block)
		|            |
		|            |-->0x0001FFFF-> SPL end
		|            |-->0x00020000-> SPL.backup1 start (SPL copy on 2nd block)
		|            |
		|            |-->0x0003FFFF-> SPL.backup1 end
		|            |-->0x00040000-> SPL.backup2 start (SPL copy on 3rd block)
		|            |
		|            |-->0x0005FFFF-> SPL.backup2 end
		|            |-->0x00060000-> SPL.backup3 start (SPL copy on 4th block)
		|            |
		|            |-->0x0007FFFF-> SPL.backup3 end
		|            |-->0x00080000-> U-Boot start
		|            |                                    
		|            |-->0x001DFFFF-> U-Boot end
		|            |-->0x001E0000-> ENV start
		|            |
		|            |-->0x001FFFFF-> ENV end
		|            |-->0x00200000-> File system start
		|            |
		|            |-->0x041FFFFF-> File system end
		|            |-->0x04200000-> Data storage start
		|            |
		+------------+-->0x10000000-> NAND end (Free end)
		*/
		partition@0 {
			label = "spl1";
			reg = <0x00000000 0x00020000>; /* 128KB */
		};

		partition@1 {
			label = "spl2";
			reg = <0x00020000 0x00020000>; /* 128KB */
		};

		partition@2 {
			label = "spl3";
			reg = <0x00040000 0x00020000>; /* 128KB */
		};

		partition@3 {
			label = "spl4";
			reg = <0x00060000 0x00020000>; /* 128KB */
		};

		partition@4 {
			label = "boot";
			reg = <0x00080000 0x00160000>; /* 1408KB */
		};

		partition@5 {
			label = "env";
			reg = <0x001e0000 0x00020000>; /* 128KB */
		};

		partition@6 {
			label = "rootfs";
			reg = <0x00200000 0x04000000>; /* 64MB */
		};

		partition@7 {
			label = "data";
			reg = <0x04200000 0x0be00000>; /* 190MB */
		};
	};

	nor@1,0 {
		reg = <3 0x00000000 0x04000000>;
		compatible = "cfi-flash";
		linux,mtd-name = "spansion,s29gl064n90t";
		bank-width = <2>;

		gpmc,device-width = <1>;
		gpmc,mux-add-data;

		gpmc,sync-clk = <0>;
		gpmc,cs-on = <10>;
		gpmc,cs-rd-off = <150>;
		gpmc,cs-wr-off = <150>;
		gpmc,adv-on = <10>;
		gpmc,adv-rd-off = <10>;
		gpmc,adv-wr-off = <10>;
		gpmc,oe-on = <30>;
		gpmc,oe-off = <150>;
		gpmc,we-on = <30>;
		gpmc,we-off = <150>;
		gpmc,rd-cycle = <150>;
		gpmc,wr-cycle = <150>;
		gpmc,access = <130>;
		gpmc,page-burst-access = <10>;
		gpmc,cycle2cycle-diff = <1>;
		gpmc,cycle2cycle-same = <1>;
		gpmc,cycle2cycle-delay = <10>;
		gpmc,wr-data-mux-bus = <60>;

		#address-cells = <1>;
		#size-cells = <1>;
		elm_id = <&elm>;

		partition@0 {
			label = "data";
			reg = <0x00000000 0x04000000>; /* 64MB */
		};
	};
};

Booting with this NOR device produces the following oops:-

[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 3.9.0-rc1-12191-ga00d6d1-dirty (mpfj@mpfj-nanobone) (gcc version 4.5.4 (Buildroot 2012.11) ) #33 Tue Mar 5 13:08:25 GMT 2013
[    0.000000] CPU: ARMv7 Processor [413fc082] revision 2 (ARMv7), cr=10c53c7d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
[    0.000000] Machine: Generic AM33XX (Flattened Device Tree), model: TI AM335x BeagleBone
[    0.000000] Memory policy: ECC disabled, Data cache writeback
[    0.000000] CPU: All CPU(s) started in SVC mode.
[    0.000000] AM335X ES1.0 (neon )
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 64768
[    0.000000] Kernel command line: console=ttyO0,115200n8 noinitrd ip=off mem=256M rootwait=1 ubi.mtd=6,2048 rootfstype=ubifs root=ubi0:rootfs
[    0.000000] PID hash table entries: 1024 (order: 0, 4096 bytes)
[    0.000000] Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
[    0.000000] Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
[    0.000000] __ex_table already sorted, skipping sort
[    0.000000] Memory: 255MB = 255MB total
[    0.000000] Memory: 248068k/248068k available, 14076k reserved, 0K highmem
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
[    0.000000]     vmalloc : 0xd0800000 - 0xff000000   ( 744 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xd0000000   ( 256 MB)
[    0.000000]     pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
[    0.000000]       .text : 0xc0008000 - 0xc04d407c   (4913 kB)
[    0.000000]       .init : 0xc04d5000 - 0xc050593c   ( 195 kB)
[    0.000000]       .data : 0xc0506000 - 0xc0554e80   ( 316 kB)
[    0.000000]        .bss : 0xc0554e80 - 0xc0a76b60   (5256 kB)
[    0.000000] NR_IRQS:16 nr_irqs:16 16
[    0.000000] IRQ: Found an INTC at 0xfa200000 (revision 5.0) with 128 interrupts
[    0.000000] Total of 128 interrupts on 1 active controller
[    0.000000] OMAP clockevent source: GPTIMER1 at 26000000 Hz
[    0.000000] sched_clock: 32 bits at 26MHz, resolution 38ns, wraps every 165191ms
[    0.000000] OMAP clocksource: GPTIMER2 at 26000000 Hz
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
[    0.000845] Calibrating delay loop... 479.23 BogoMIPS (lpj=2396160)
[    0.109860] pid_max: default: 32768 minimum: 301
[    0.110128] Security Framework initialized
[    0.110234] Mount-cache hash table entries: 512
[    0.120373] CPU: Testing write buffer coherency: ok
[    0.121628] Setting up static identity map for 0xc03caf60 - 0xc03cafb8
[    0.125001] devtmpfs: initialized
[    0.186744] pinctrl core: initialized pinctrl subsystem
[    0.191942] regulator-dummy: no parameters
[    0.194142] NET: Registered protocol family 16
[    0.194891] DMA: preallocated 256 KiB pool for atomic coherent allocations
[    0.213783] OMAP GPIO hardware version 0.1
[    0.236730] omap-gpmc 50000000.gpmc: could not find pctldev for node /pinmux@44e10800/gpmc_pins, deferring probe
[    0.236781] platform 50000000.gpmc: Driver omap-gpmc requests probe deferral
[    0.237476] No ATAGs?
[    0.237494] hw-breakpoint: debug architecture 0x4 unsupported.
[    0.269694] bio: create slab <bio-0> at 0
[    0.335502] omap-dma-engine omap-dma-engine: OMAP DMA engine driver
[    0.342078] usbcore: registered new interface driver usbfs
[    0.342491] usbcore: registered new interface driver hub
[    0.343136] usbcore: registered new device driver usb
[    0.344082] omap_i2c 44e0b000.i2c: could not find pctldev for node /pinmux@44e10800/i2c1_pins, deferring probe
[    0.344128] platform 44e0b000.i2c: Driver omap_i2c requests probe deferral
[    0.351421] cfg80211: Calling CRDA to update world regulatory domain
[    0.353089] Switching to clocksource gp_timer
[    0.401911] NET: Registered protocol family 2
[    0.403612] TCP established hash table entries: 2048 (order: 2, 16384 bytes)
[    0.403822] TCP bind hash table entries: 2048 (order: 4, 73728 bytes)
[    0.404761] TCP: Hash tables configured (established 2048 bind 2048)
[    0.404941] TCP: reno registered
[    0.404969] UDP hash table entries: 256 (order: 2, 20480 bytes)
[    0.405226] UDP-Lite hash table entries: 256 (order: 2, 20480 bytes)
[    0.406010] NET: Registered protocol family 1
[    0.406917] NetWinder Floating Point Emulator V0.97 (double precision)
[    0.407357] CPU PMU: probing PMU on CPU 0
[    0.407384] hw perfevents: enabled with ARMv7 Cortex-A8 PMU driver, 5 counters available
[    0.418794] msgmni has been set to 484
[    0.423083] io scheduler noop registered
[    0.423107] io scheduler deadline registered
[    0.423300] io scheduler cfq registered (default)
[    0.424353] pinctrl-single 44e10800.pinmux: 142 pins at pa f9e10800 size 568
[    0.425948] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    0.433116] 44e09000.serial: ttyO0 at MMIO 0x44e09000 (irq = 88) is a OMAP UART0
[    0.954564] console [ttyO0] enabled
[    0.960651] 48022000.serial: ttyO1 at MMIO 0x48022000 (irq = 89) is a OMAP UART1
[    0.970290] 48024000.serial: ttyO2 at MMIO 0x48024000 (irq = 90) is a OMAP UART2
[    0.979840] 481a6000.serial: ttyO3 at MMIO 0x481a6000 (irq = 60) is a OMAP UART3
[    0.989314] 481a8000.serial: ttyO4 at MMIO 0x481a8000 (irq = 61) is a OMAP UART4
[    0.998713] 481aa000.serial: ttyO5 at MMIO 0x481aa000 (irq = 62) is a OMAP UART5
[    1.033299] brd: module loaded
[    1.052135] loop: module loaded
[    1.060341] Unhandled fault: external abort on non-linefetch (0x1028) at 0xd3000020
[    1.068463] Internal error: : 1028 [#1] ARM
[    1.072895] CPU: 0    Not tainted  (3.9.0-rc1-12191-ga00d6d1-dirty #33)
[    1.079903] PC is at cfi_qry_present+0x294/0x2c0
[    1.084785] LR is at cfi_qry_present+0x60/0x2c0
[    1.089576] pc : [<c0230c94>]    lr : [<c0230a60>]    psr: 60000113
[    1.089576] sp : cf04dd28  ip : 00000006  fp : 00000001
[    1.101716] r10: 00005151  r9 : 00000000  r8 : 00005959
[    1.107238] r7 : 00000002  r6 : 00000002  r5 : 00000008  r4 : cf28d95c
[    1.114140] r3 : 00005252  r2 : d3000020  r1 : 00000020  r0 : d3000000
[    1.121044] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
[    1.128772] Control: 10c5387d  Table: 80004019  DAC: 00000015
[    1.134849] Process swapper (pid: 1, stack limit = 0xcf04c238)
[    1.141018] Stack: (0xcf04dd28 to 0xcf04e000)
[    1.145627] dd20:                   00000000 cf28d95c cf04ddc4 00000000 c050e0a8 00000002
[    1.154277] dd40: 000000aa 00000008 00009898 c0230e38 cf04c000 00000001 cf04c000 00000000
[    1.162928] dd60: 00000000 cf04ddc4 cf28d95c 00000002 cf0bcc00 00000001 c04920a8 c022fe80
[    1.171576] dd80: cf04c000 cf04b7b0 cf04b340 00000000 00000001 000000d0 c06223ac 00000001
[    1.180228] dda0: cf28d95c c05440a0 cf04ddc4 00000002 cf0bcc00 00000001 c04920a8 c023a97c
[    1.188880] ddc0: cf04c000 00000000 00000000 00000002 00000001 00000000 00000000 00000000
[    1.197530] dde0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[    1.206182] de00: c054405c c0544094 c0544084 c054407c c04920a8 cf28d95c cf0bcc00 00000000
[    1.214833] de20: c04920a8 c022fde8 cf28d950 00000000 c0c81f60 cf28d950 04000000 c023b180
[    1.223483] de40: 00000000 22222222 cf0bcc10 cf294500 00000000 cf04de80 1a000000 1dffffff
[    1.232134] de60: c0c81f9c 00000200 00000000 00000000 00000000 c005a7ac 00000000 c00c3c50
[    1.240784] de80: c0a79aa4 00000001 c0a716b8 cf0bcc10 c0a716b8 c0a716c8 00000000 00000000
[    1.249434] dea0: c0505608 c0544210 00000000 c0213bb0 c0213b98 c0212b08 00000000 cf0bcc10
[    1.258085] dec0: c0544210 cf0bcc44 00000000 c04f16e4 0000005a c0212d30 c0544210 c0212c9c
[    1.266735] dee0: cf04dee8 c02112a8 cf0444a8 cf0af590 c04f16e4 c0544210 c0542430 cf28d9c0
[    1.275386] df00: 00000000 c0211b00 c04928b0 c0544210 c0544210 00000006 c04fcff4 00000000
[    1.284037] df20: c04f16e4 c02132fc 00000000 c04fd014 00000006 c04fcff4 00000000 c04f16e4
[    1.292688] df40: 0000005a c04d581c 00000006 00000006 60000113 c04fd010 c04fd014 00000006
[    1.301341] df60: c04fcff4 c0554e80 c04d5168 0000005a 00000000 c04d59d8 00000006 00000006
[    1.309990] df80: c04d5168 00000000 00000000 c03c6494 00000000 00000000 00000000 00000000
[    1.318640] dfa0: 00000000 c03c649c 00000000 c0013870 00000000 00000000 00000000 00000000
[    1.327291] dfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[    1.335943] dfe0: 00000000 00000000 00000000 00000000 00000013 00000000 ff99f7ff f7b97f3f
[    1.344601] [<c0230c94>] (cfi_qry_present+0x294/0x2c0) from [<c0230e38>] (cfi_qry_mode_on+0x178/0xfd8)
[    1.354449] [<c0230e38>] (cfi_qry_mode_on+0x178/0xfd8) from [<c022fe80>] (cfi_probe_chip+0x40/0xbc0)
[    1.364116] [<c022fe80>] (cfi_probe_chip+0x40/0xbc0) from [<c023a97c>] (mtd_do_chip_probe+0xa8/0x388)
[    1.373873] [<c023a97c>] (mtd_do_chip_probe+0xa8/0x388) from [<c022fde8>] (do_map_probe+0x6c/0x8c)
[    1.383354] [<c022fde8>] (do_map_probe+0x6c/0x8c) from [<c023b180>] (of_flash_probe+0x218/0x5a4)
[    1.392658] [<c023b180>] (of_flash_probe+0x218/0x5a4) from [<c0213bb0>] (platform_drv_probe+0x18/0x1c)
[    1.402506] [<c0213bb0>] (platform_drv_probe+0x18/0x1c) from [<c0212b08>] (driver_probe_device+0x94/0x228)
[    1.412720] [<c0212b08>] (driver_probe_device+0x94/0x228) from [<c0212d30>] (__driver_attach+0x94/0x98)
[    1.422671] [<c0212d30>] (__driver_attach+0x94/0x98) from [<c02112a8>] (bus_for_each_dev+0x68/0x8c)
[    1.432244] [<c02112a8>] (bus_for_each_dev+0x68/0x8c) from [<c0211b00>] (bus_add_driver+0x1b0/0x22c)
[    1.441908] [<c0211b00>] (bus_add_driver+0x1b0/0x22c) from [<c02132fc>] (driver_register+0x78/0x144)
[    1.451580] [<c02132fc>] (driver_register+0x78/0x144) from [<c04d581c>] (do_one_initcall+0x98/0x16c)
[    1.461245] [<c04d581c>] (do_one_initcall+0x98/0x16c) from [<c04d59d8>] (kernel_init_freeable+0xe8/0x1ac)
[    1.471369] [<c04d59d8>] (kernel_init_freeable+0xe8/0x1ac) from [<c03c649c>] (kernel_init+0x8/0xe4)
[    1.480956] [<c03c649c>] (kernel_init+0x8/0xe4) from [<c0013870>] (ret_from_fork+0x14/0x24)
[    1.489792] Code: e7d05001 e6ef5075 eaffffcb e0802002 (e1d2c0b0)
[    1.496294] ---[ end trace a9ca4747ade8eff8 ]---
[    1.501297] Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
[    1.501297]


Can anyone point out what I've got wrong ?

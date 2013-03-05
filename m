From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH 11/14] ARM: OMAP2+: Add device-tree support for NOR flash
Date: Tue, 5 Mar 2013 08:46:58 -0600
Message-ID: <51360562.20309@ti.com>
References: <1361899842-30303-1-git-send-email-jon-hunter@ti.com> <1361899842-30303-12-git-send-email-jon-hunter@ti.com> <51360271.1030302@mimc.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:54607 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755784Ab3CEOrO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Mar 2013 09:47:14 -0500
In-Reply-To: <51360271.1030302@mimc.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Jackson <mpfj-list@mimc.co.uk>
Cc: Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>, device-tree <devicetree-discuss@lists.ozlabs.org>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Daniel Mack <zonque@gmail.com>


On 03/05/2013 08:34 AM, Mark Jackson wrote:
> On 26/02/13 17:30, Jon Hunter wrote:
>> NOR flash is not currently supported when booting with device-tree
>> on OMAP2+ devices. Add support to detect and configure NOR devices
>> when booting with device-tree.
>>
>> Add documentation for the TI GPMC NOR binding.
>>
>> Signed-off-by: Jon Hunter <jon-hunter@ti.com>
> 
> I'm trying to test this series, and am unable get my NOR device recognised.
> 
> If I remove all reference to NOR (and keep only my NAND device definition), then
> everything seems to boot fine (so I'm assuming I've got at least the basics of
> the patch set working).
> 
> My GPMC tree looks like this:-
> 
> gpmc: gpmc@50000000 {
> 	compatible = "ti,am3352-gpmc", "simple-bus";
> 	ti,hwmods = "gpmc";
> 	status = "okay";
> 	gpmc,num-waitpins = <2>;
> 	pinctrl-names = "default";
> 	pinctrl-0 = <&gpmc_pins>;
> 
> 	#address-cells = <2>;
> 	#size-cells = <1>;
> 	ranges = <0 0 0x08000000 0x10000000>,	/* CS0: NAND 256M */
> 		 <3 0 0x1a000000 0x04000000>;	/* CS3: NOR 64M */
> 
> 	nand@0,0 {
> 		linux,mtd-name= "micron,mt29f2g08abaea";
> 		reg = <0 0x00000000 0x10000000>; /* CS0, offset 0 */
> 		nand-bus-width = <8>;
> 		ti,nand-ecc-opt = "bch8";
> 
> 		gpmc,device-nand;
> 		gpmc,device-width = <1>;
> 		gpmc,wait-pin = <0>;
> 
> 		gpmc,sync-clk = <0>;
> 		gpmc,cs-on = <0>;
> 		gpmc,cs-rd-off = <44>;
> 		gpmc,cs-wr-off = <44>;
> 		gpmc,adv-on = <6>;
> 		gpmc,adv-rd-off = <34>;
> 		gpmc,adv-wr-off = <44>;
> 		gpmc,we-off = <40>;
> 		gpmc,oe-off = <54>;
> 		gpmc,access = <64>;
> 		gpmc,rd-cycle = <82>;
> 		gpmc,wr-cycle = <82>;
> 		gpmc,wr-access = <40>;
> 		gpmc,wr-data-mux-bus = <0>;
> 
> 		#address-cells = <1>;
> 		#size-cells = <1>;
> 		elm_id = <&elm>;
> 
> 		/*
> 		MTD partition table
> 		===================
> 		+------------+-->0x00000000-> SPL start         (SPL copy on 1st block)
> 		|            |
> 		|            |-->0x0001FFFF-> SPL end
> 		|            |-->0x00020000-> SPL.backup1 start (SPL copy on 2nd block)
> 		|            |
> 		|            |-->0x0003FFFF-> SPL.backup1 end
> 		|            |-->0x00040000-> SPL.backup2 start (SPL copy on 3rd block)
> 		|            |
> 		|            |-->0x0005FFFF-> SPL.backup2 end
> 		|            |-->0x00060000-> SPL.backup3 start (SPL copy on 4th block)
> 		|            |
> 		|            |-->0x0007FFFF-> SPL.backup3 end
> 		|            |-->0x00080000-> U-Boot start
> 		|            |                                    
> 		|            |-->0x001DFFFF-> U-Boot end
> 		|            |-->0x001E0000-> ENV start
> 		|            |
> 		|            |-->0x001FFFFF-> ENV end
> 		|            |-->0x00200000-> File system start
> 		|            |
> 		|            |-->0x041FFFFF-> File system end
> 		|            |-->0x04200000-> Data storage start
> 		|            |
> 		+------------+-->0x10000000-> NAND end (Free end)
> 		*/
> 		partition@0 {
> 			label = "spl1";
> 			reg = <0x00000000 0x00020000>; /* 128KB */
> 		};
> 
> 		partition@1 {
> 			label = "spl2";
> 			reg = <0x00020000 0x00020000>; /* 128KB */
> 		};
> 
> 		partition@2 {
> 			label = "spl3";
> 			reg = <0x00040000 0x00020000>; /* 128KB */
> 		};
> 
> 		partition@3 {
> 			label = "spl4";
> 			reg = <0x00060000 0x00020000>; /* 128KB */
> 		};
> 
> 		partition@4 {
> 			label = "boot";
> 			reg = <0x00080000 0x00160000>; /* 1408KB */
> 		};
> 
> 		partition@5 {
> 			label = "env";
> 			reg = <0x001e0000 0x00020000>; /* 128KB */
> 		};
> 
> 		partition@6 {
> 			label = "rootfs";
> 			reg = <0x00200000 0x04000000>; /* 64MB */
> 		};
> 
> 		partition@7 {
> 			label = "data";
> 			reg = <0x04200000 0x0be00000>; /* 190MB */
> 		};
> 	};
> 
> 	nor@1,0 {
> 		reg = <3 0x00000000 0x04000000>;
> 		compatible = "cfi-flash";
> 		linux,mtd-name = "spansion,s29gl064n90t";
> 		bank-width = <2>;
> 
> 		gpmc,device-width = <1>;

Only bank-width should be necessary for NOR (per the binding
documentation). However, if you do specify both, then they should match.
Do you have two 8-bits devices? If so may be I need to update the
documentation to make it clear this is the total width of all devices
for a given chip-select.

> 		gpmc,mux-add-data;
> 
> 		gpmc,sync-clk = <0>;
> 		gpmc,cs-on = <10>;
> 		gpmc,cs-rd-off = <150>;
> 		gpmc,cs-wr-off = <150>;
> 		gpmc,adv-on = <10>;
> 		gpmc,adv-rd-off = <10>;
> 		gpmc,adv-wr-off = <10>;
> 		gpmc,oe-on = <30>;
> 		gpmc,oe-off = <150>;
> 		gpmc,we-on = <30>;
> 		gpmc,we-off = <150>;
> 		gpmc,rd-cycle = <150>;
> 		gpmc,wr-cycle = <150>;
> 		gpmc,access = <130>;
> 		gpmc,page-burst-access = <10>;
> 		gpmc,cycle2cycle-diff = <1>;
> 		gpmc,cycle2cycle-same = <1>;
> 		gpmc,cycle2cycle-delay = <10>;
> 		gpmc,wr-data-mux-bus = <60>;
> 
> 		#address-cells = <1>;
> 		#size-cells = <1>;
> 		elm_id = <&elm>;
> 
> 		partition@0 {
> 			label = "data";
> 			reg = <0x00000000 0x04000000>; /* 64MB */
> 		};
> 	};
> };
> 
> Booting with this NOR device produces the following oops:-
> 
> [    0.000000] Booting Linux on physical CPU 0x0
> [    0.000000] Linux version 3.9.0-rc1-12191-ga00d6d1-dirty (mpfj@mpfj-nanobone) (gcc version 4.5.4 (Buildroot 2012.11) ) #33 Tue Mar 5 13:08:25 GMT 2013
> [    0.000000] CPU: ARMv7 Processor [413fc082] revision 2 (ARMv7), cr=10c53c7d
> [    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
> [    0.000000] Machine: Generic AM33XX (Flattened Device Tree), model: TI AM335x BeagleBone
> [    0.000000] Memory policy: ECC disabled, Data cache writeback
> [    0.000000] CPU: All CPU(s) started in SVC mode.
> [    0.000000] AM335X ES1.0 (neon )
> [    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 64768
> [    0.000000] Kernel command line: console=ttyO0,115200n8 noinitrd ip=off mem=256M rootwait=1 ubi.mtd=6,2048 rootfstype=ubifs root=ubi0:rootfs
> [    0.000000] PID hash table entries: 1024 (order: 0, 4096 bytes)
> [    0.000000] Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
> [    0.000000] Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
> [    0.000000] __ex_table already sorted, skipping sort
> [    0.000000] Memory: 255MB = 255MB total
> [    0.000000] Memory: 248068k/248068k available, 14076k reserved, 0K highmem
> [    0.000000] Virtual kernel memory layout:
> [    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
> [    0.000000]     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
> [    0.000000]     vmalloc : 0xd0800000 - 0xff000000   ( 744 MB)
> [    0.000000]     lowmem  : 0xc0000000 - 0xd0000000   ( 256 MB)
> [    0.000000]     pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
> [    0.000000]       .text : 0xc0008000 - 0xc04d407c   (4913 kB)
> [    0.000000]       .init : 0xc04d5000 - 0xc050593c   ( 195 kB)
> [    0.000000]       .data : 0xc0506000 - 0xc0554e80   ( 316 kB)
> [    0.000000]        .bss : 0xc0554e80 - 0xc0a76b60   (5256 kB)
> [    0.000000] NR_IRQS:16 nr_irqs:16 16
> [    0.000000] IRQ: Found an INTC at 0xfa200000 (revision 5.0) with 128 interrupts
> [    0.000000] Total of 128 interrupts on 1 active controller
> [    0.000000] OMAP clockevent source: GPTIMER1 at 26000000 Hz
> [    0.000000] sched_clock: 32 bits at 26MHz, resolution 38ns, wraps every 165191ms
> [    0.000000] OMAP clocksource: GPTIMER2 at 26000000 Hz
> [    0.000000] Console: colour dummy device 80x30
> [    0.000000] Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
> [    0.000000] ... MAX_LOCKDEP_SUBCLASSES:  8
> [    0.000000] ... MAX_LOCK_DEPTH:          48
> [    0.000000] ... MAX_LOCKDEP_KEYS:        8191
> [    0.000000] ... CLASSHASH_SIZE:          4096
> [    0.000000] ... MAX_LOCKDEP_ENTRIES:     16384
> [    0.000000] ... MAX_LOCKDEP_CHAINS:      32768
> [    0.000000] ... CHAINHASH_SIZE:          16384
> [    0.000000]  memory used by lock dependency info: 3695 kB
> [    0.000000]  per task-struct memory footprint: 1152 bytes
> [    0.000845] Calibrating delay loop... 479.23 BogoMIPS (lpj=2396160)
> [    0.109860] pid_max: default: 32768 minimum: 301
> [    0.110128] Security Framework initialized
> [    0.110234] Mount-cache hash table entries: 512
> [    0.120373] CPU: Testing write buffer coherency: ok
> [    0.121628] Setting up static identity map for 0xc03caf60 - 0xc03cafb8
> [    0.125001] devtmpfs: initialized
> [    0.186744] pinctrl core: initialized pinctrl subsystem
> [    0.191942] regulator-dummy: no parameters
> [    0.194142] NET: Registered protocol family 16
> [    0.194891] DMA: preallocated 256 KiB pool for atomic coherent allocations
> [    0.213783] OMAP GPIO hardware version 0.1
> [    0.236730] omap-gpmc 50000000.gpmc: could not find pctldev for node /pinmux@44e10800/gpmc_pins, deferring probe
> [    0.236781] platform 50000000.gpmc: Driver omap-gpmc requests probe deferral

This look like your problem. I would figure out why this is failing and
try again.

Cheers
Jon

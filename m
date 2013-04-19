From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: ARM: dts: omap3: NAND support - how?
Date: Fri, 19 Apr 2013 07:57:30 -0500
Message-ID: <51713F3A.90905@ti.com>
References: <1366311829.4085.90.camel@mars>  <51704C05.4030200@ti.com>  <1366316595.4085.113.camel@mars>  <5170738F.8050305@ti.com>  <1366325282.4232.6.camel@lovely> <51708097.6070102@ti.com>  <51708131.2040208@ti.com> <1366362081.3928.18.camel@mars>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:53119 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030222Ab3DSM5f (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 19 Apr 2013 08:57:35 -0400
In-Reply-To: <1366362081.3928.18.camel@mars>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Christoph Fritz <chf.fritz@googlemail.com>
Cc: Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Daniel Mack <daniel@zonque.org>, linux-omap@vger.kernel.org


On 04/19/2013 04:01 AM, Christoph Fritz wrote:
> On Thu, 2013-04-18 at 18:26 -0500, Jon Hunter wrote:
>> On 04/18/2013 06:24 PM, Jon Hunter wrote:
> 
>>>> To get the values right for dt-GPMC-NAND-Config, here are the GPMC
>>>> config registers for chip-select 0, they are taken from u-boot
>>>> by doing "md 0x6E000060 7" on the u-boot shell:
>>>>
>>>> 	GPMC_CONFIG1: 0x6e000060: 0x00001800
>>>> 	GPMC_CONFIG2: 0x6e000064: 0x00141400
>>>> 	GPMC_CONFIG3: 0x6e000068: 0x00141400
>>>> 	GPMC_CONFIG4: 0x6e00006c: 0x0F010F01
>>>> 	GPMC_CONFIG5: 0x6e000070: 0x010C1414
>>>> 	GPMC_CONFIG6: 0x6e000074: 0x1F0F0A80
>>>> 	GPMC_CONFIG7: 0x6e000078: 0x00000870
>>
>>
>> I would advise you dump the gpmc registers at the end of the gpmc probe.
>> I am sure you will see something completely different to the above based
>> upon your dt configuration.
> 
> Thanks to your help this is my new gpmc dt config:
> 
> &gpmc {
> 	ranges = <0 0 0x30000000 0x1000000>;
> 	nand@0,0 {
> 		reg = <0 0 0x1000000>;
> 		nand-bus-width = <16>;
> 		ti,nand-ecc-opt = "hw";
> 		/* no elm on omap3 */
> 
> 		gpmc,mux-add-data = <0>;
> 		gpmc,device-nand;
> 		gpmc,device-width = <2>;
> 		gpmc,wait-pin = <0>;
> 		gpmc,wait-monitoring-ns = <0x0>;
> 		gpmc,burst-length= <4>;
> 		gpmc,cs-on-ns = <0>;
> 		gpmc,cs-rd-off-ns = <0x14>;
> 		gpmc,cs-wr-off-ns = <0x14>;
> 		gpmc,adv-on-ns = <0>;
> 		gpmc,adv-rd-off-ns = <0x14>;
> 		gpmc,adv-wr-off-ns = <0x14>;
> 		gpmc,oe-on-ns = <0x1>;
> 		gpmc,oe-off-ns = <0xf>;
> 		gpmc,we-on-ns = <0x1>;
> 		gpmc,we-off-ns = <0xf>;
> 		gpmc,rd-cycle-ns = <0x14>;
> 		gpmc,wr-cycle-ns = <0x14>;
> 		gpmc,access-ns = <0xc>;
> 		gpmc,page-burst-access-ns = <0x1>;
> 		gpmc,bus-turnaround-ns = <0x0>;
> 		gpmc,cycle2cycle-samecsen = <0x1>;
> 		gpmc,cycle2cycle-delay-ns = <0xa>;
> 		gpmc,wr-data-mux-bus-ns = <0xf>;
> 		gpmc,wr-access-ns = <0x1f>;

Please note that the above timings are in ns and the registers settings
are in gpmc_fclk ticks. So you need to convert to ns.

> 	};
> };
> 
> As suggested I added some printks to kernel gpmc-subsystem to compare
> the gpmc config registers.
> 
> [    0.000000] CPU: ARMv7 Processor [413fc082] revision 2 (ARMv7), cr=10c5387d
> [    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
> [    0.000000] Machine: Generic OMAP3 (Flattened Device Tree), model: INCOstartec LILLY-DBB056 (DM3730)
> [    0.000000] Memory policy: ECC disabled, Data cache writeback
> [    0.000000] CPU: All CPU(s) started in SVC mode.
> [    0.000000] OMAP3630 ES1.2 (l2cache iva neon isp 192mhz_clk )
> [    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 32256
> [    0.000000] Kernel command line: console=ttyO0,115200n8 vt.global_cursor_default=0 consoleblank=0 root=/dev/nfs ip=dhcp
> [    0.000000] PID hash table entries: 512 (order: -1, 2048 bytes)
> [    0.000000] Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
> [    0.000000] Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
> [    0.000000] Memory: 127MB = 127MB total
> [    0.000000] Memory: 116040k/116040k available, 15032k reserved, 0K highmem
> [    0.000000] Virtual kernel memory layout:
> [    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
> [    0.000000]     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
> [    0.000000]     vmalloc : 0xc8800000 - 0xff000000   ( 872 MB)
> [    0.000000]     lowmem  : 0xc0000000 - 0xc8000000   ( 128 MB)
> [    0.000000]     pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
> [    0.000000]     modules : 0xbf000000 - 0xbfe00000   (  14 MB)
> [    0.000000]       .text : 0xc0008000 - 0xc06a9fa8   (6792 kB)
> [    0.000000]       .init : 0xc06aa000 - 0xc06db9ec   ( 199 kB)
> [    0.000000]       .data : 0xc06dc000 - 0xc073bd20   ( 384 kB)
> [    0.000000]        .bss : 0xc073bd20 - 0xc0c7e414   (5386 kB)
> [    0.000000] NR_IRQS:16 nr_irqs:16 16
> [    0.000000] IRQ: Found an INTC at 0xfa200000 (revision 4.0) with 96 interrupts
> [    0.000000] Total of 96 interrupts on 1 active controller
> [    0.000000] Clocking rate (Crystal/Core/MPU): 26.0/400/600 MHz
> [    0.000000] OMAP clockevent source: timer1 at 32768 Hz
> [    0.000000] sched_clock: 32 bits at 32kHz, resolution 30517ns, wraps every 131071999ms
> [    0.000000] OMAP clocksource: 32k_counter at 32768 Hz
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
> [    0.001037] Calibrating delay loop... 398.13 BogoMIPS (lpj=1990656)
> [    0.119659] pid_max: default: 4096 minimum: 301
> [    0.119964] Security Framework initialized
> [    0.120086] Mount-cache hash table entries: 512
> [    0.135314] CPU: Testing write buffer coherency: ok
> [    0.136810] Setting up static identity map for 0xc04efee8 - 0xc04eff40
> [    0.141418] devtmpfs: initialized
> [    0.197814] pinctrl core: initialized pinctrl subsystem
> [    0.201232] regulator-dummy: no parameters
> [    0.202972] NET: Registered protocol family 16
> [    0.203704] DMA: preallocated 256 KiB pool for atomic coherent allocations
> [    0.211700] Reprogramming SDRC clock to 400000000 Hz
> [    0.229248] pinctrl-single 48002030.pinmux: 742 pins at pa fa002030 size 1484
> [    0.231140] pinctrl-single 48002a00.pinmux: 46 pins at pa fa002a00 size 92
> [    0.234588] OMAP GPIO hardware version 2.5
> [    0.252685] platform 49022000.mcbsp: alias fck already exists
> [    0.253540] platform 49024000.mcbsp: alias fck already exists
> [    0.261749] omap-gpmc 6e000000.gpmc: GPMC revision 5.0
> [    0.262084] gpmc_write_reg(), 176,
> [    0.262115] gpmc_ch_dump_reg, 1836, GPMC_CS_CONFIG1 0x00001800
> [    0.262115] gpmc_ch_dump_reg, 1838, GPMC_CS_CONFIG2 0x00141400
> [    0.262145] gpmc_ch_dump_reg, 1840, GPMC_CS_CONFIG3 0x00141400
> [    0.262145] gpmc_ch_dump_reg, 1842, GPMC_CS_CONFIG4 0x0f010f01
> [    0.262176] gpmc_ch_dump_reg, 1844, GPMC_CS_CONFIG5 0x010c1414
> [    0.262176] gpmc_ch_dump_reg, 1846, GPMC_CS_CONFIG6 0x1f0f0a80
> [    0.262207] gpmc_ch_dump_reg, 1848, GPMC_CS_CONFIG7 0x00000870
> [    0.262207] gpmc_write_reg(), 176,
> [    0.262237] gpmc_ch_dump_reg, 1836, GPMC_CS_CONFIG1 0x00001800
> [    0.262237] gpmc_ch_dump_reg, 1838, GPMC_CS_CONFIG2 0x00141400
> [    0.262237] gpmc_ch_dump_reg, 1840, GPMC_CS_CONFIG3 0x00141400
> [    0.262268] gpmc_ch_dump_reg, 1842, GPMC_CS_CONFIG4 0x0f010f01
> [    0.262268] gpmc_ch_dump_reg, 1844, GPMC_CS_CONFIG5 0x010c1414
> [    0.262298] gpmc_ch_dump_reg, 1846, GPMC_CS_CONFIG6 0x1f0f0a80
> [    0.262298] gpmc_ch_dump_reg, 1848, GPMC_CS_CONFIG7 0x00000870
> [    0.262695] gpmc_cs_enable_mem(), 433,
> [    0.262725] gpmc_ch_dump_reg, 1836, GPMC_CS_CONFIG1 0x00001800
> [    0.262756] gpmc_ch_dump_reg, 1838, GPMC_CS_CONFIG2 0x00141400
> [    0.262756] gpmc_ch_dump_reg, 1840, GPMC_CS_CONFIG3 0x00141400
> [    0.262786] gpmc_ch_dump_reg, 1842, GPMC_CS_CONFIG4 0x0f010f01
> [    0.262786] gpmc_ch_dump_reg, 1844, GPMC_CS_CONFIG5 0x010c1414
> [    0.262817] gpmc_ch_dump_reg, 1846, GPMC_CS_CONFIG6 0x1f0f0a80
> [    0.262817] gpmc_ch_dump_reg, 1848, GPMC_CS_CONFIG7 0x00000f70
> [    0.262878] GPMC CS0: cs_on     :   0 ticks,   0 ns (was   0 ticks)   0 ns
> [    0.262908] GPMC CS0: cs_rd_off :   4 ticks,  20 ns (was  20 ticks)  20 ns
> [    0.262939] GPMC CS0: cs_wr_off :   4 ticks,  20 ns (was  20 ticks)  20 ns
> [    0.262939] GPMC CS0: adv_on    :   0 ticks,   0 ns (was   0 ticks)   0 ns
> [    0.262969] GPMC CS0: adv_rd_off:   4 ticks,  20 ns (was  20 ticks)  20 ns
> [    0.263000] GPMC CS0: adv_wr_off:   4 ticks,  20 ns (was  20 ticks)  20 ns
> [    0.263031] GPMC CS0: oe_on     :   0 ticks,   0 ns (was   1 ticks)   0 ns
> [    0.263031] GPMC CS0: oe_off    :   3 ticks,  15 ns (was  15 ticks)  15 ns
> [    0.263061] GPMC CS0: we_on     :   0 ticks,   0 ns (was   1 ticks)   0 ns
> [    0.263092] GPMC CS0: we_off    :   3 ticks,  15 ns (was  15 ticks)  15 ns
> [    0.263122] GPMC CS0: rd_cycle  :   4 ticks,  20 ns (was  20 ticks)  20 ns
> [    0.263153] GPMC CS0: wr_cycle  :   4 ticks,  20 ns (was  20 ticks)  20 ns
> [    0.263183] GPMC CS0: access    :   3 ticks,  15 ns (was  12 ticks)  12 ns
> [    0.263183] GPMC CS0: page_burst_access:   0 ticks,   0 ns (was   1 ticks)   0 ns
> [    0.263214] GPMC CS0: bus_turnaround:   0 ticks,   0 ns (was   0 ticks)   0 ns
> [    0.263244] GPMC CS0: cycle2cycle_delay:   0 ticks,   0 ns (was  10 ticks)   0 ns
> [    0.263244] GPMC CS0: wait_monitoring:   0 ticks,   0 ns (was   0 ticks)   0 ns
> [    0.263275] GPMC CS0: clk_activation:   0 ticks,   0 ns (was   0 ticks)   0 ns
> [    0.263305] GPMC CS0: wr_data_mux_bus:   3 ticks,  15 ns (was  15 ticks)  15 ns
> [    0.263336] GPMC CS0: wr_access :   7 ticks,  35 ns (was  31 ticks)  31 ns

I think you need to convert the register settings to ns and put those
values in the dts file.

Cheers
Jon

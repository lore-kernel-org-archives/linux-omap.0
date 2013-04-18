From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: ARM: dts: omap3: NAND support - how?
Date: Thu, 18 Apr 2013 17:28:31 -0500
Message-ID: <5170738F.8050305@ti.com>
References: <1366311829.4085.90.camel@mars>  <51704C05.4030200@ti.com> <1366316595.4085.113.camel@mars>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:37753 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752782Ab3DRW2h (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 18 Apr 2013 18:28:37 -0400
In-Reply-To: <1366316595.4085.113.camel@mars>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Christoph Fritz <chf.fritz@googlemail.com>
Cc: Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Daniel Mack <daniel@zonque.org>, linux-omap@vger.kernel.org


On 04/18/2013 03:23 PM, Christoph Fritz wrote:
> Hi Jon
> 
> On Thu, 2013-04-18 at 14:39 -0500, Jon Hunter wrote:
>> On 04/18/2013 02:03 PM, Christoph Fritz wrote:
> 
>> I had put the complete size in here so ...
>>
>> +               reg = <0 0 0x1000000>;
> 
> Thanks.
> 
>>
>>> +               nand-bus-width = <16>;
>>> +               ti,nand-ecc-opt = "bch8";
>>> +               /* no elm on omap3 */
>>> +
>>> +               gpmc,time-para-granularity = <0>;
>>
>> This is a boolean parameter so you don't need the "= <0>".
> 
> When I want to disable this boolean I thought I need to add the
> "<0>" (or not defining at all) otherwise a single
> "gpmc,time-para-granularity" would be interpreted as enabled. 

If you don't want to enable it, just don't define it at all. The code
just checks for the presence of this property, so defining it as zero
means you will enable it.

>>
>>> +               gpmc,mux-add-data = <0>;
>>
>> This should be either 1 or 2.
> 
> In arch/arm/mach-omap2/gpmc.h it gets set by this:
>  #define GPMC_CONFIG1_MUXTYPE(val)       ((val & 3) << 8)
> 
> but the TRM for AM/DM37x as well as the TRM for Omap35x says:
> 
>  |9 MUXADDDATA Enables the Address and data multiplexed protocol (Reset RW 0x-
>  |             value is CS0MUXDEVICE input pin sampled at IC reset for
>  |             CS0 and 0 for CS1-7)
>  |             0x0: Non Multiplexed attached device
>  |             0x1: Address and data multiplexed attached device
> 
> From u-boot I got 0x00001800 for register GPMC_CONFIG1. So Bit 9 is 0.
> Why should I set it here to non zero?

It should be either 1 or 2, or you should not define it. So if the bit
is zero from the u-boot configuration, just leave it out this property.
Setting to 0 is probably ok if you don't want to have address-data
multiplexing, but it is also pointless.

>>> +               gpmc,device-nand = <1>;
>>
>> This is a boolean parameter so you don't need the "= <0>".
> 
> The nand here is attached by 16 lines. So I'm pretty sure I need the <1>
> or at least "gpmc,device-nand;" don't I?

This is a boolean property. You should just have "gpmc,device-nand".

>>> +
>>> +               #address-cells = <1>;   /* <- ? not sure about that */
>>> +               #size-cells = <1>;      /* <- ? not sure about that */
>>
>> This is just needed in case you wish to list partition info. Seeing as
>> you don't you can omit.
> 
> Thanks.
> 
>>
>> Can you include the complete boot log? I am wondering if there were any
>> errors seen during the gpmc probe.
> 
> U-Boot SPL 2013.04-rc2-08894-g33f264f-dirty (Apr 17 2013 - 23:00:59)
> 
> 
> U-Boot 2013.04-rc2-08894-g33f264f-dirty (Apr 17 2013 - 23:00:59)
> 
> OMAP36XX/37XX-GP ES1.2, CPU-OPP2, L3-165MHz, Max CPU Clock 1 Ghz
> OMAP3 EVM board + LPDDR/NAND
> I2C:   ready
> DRAM:  128 MiB
> NAND:  256 MiB
> MMC:   OMAP SD/MMC: 0
> In:    serial
> Out:   serial
> Err:   serial
> Read back SMSC id 0x92210000
> Die ID #017200029e38000001683b051201102a
> Net:   smc911x-0
> Hit any key to stop autoboot:  0
> OMAP3_EVM # md 0x6E000060 7
> 6e000060: 00001800 00141400 00141400 0f010f01    ................
> 6e000070: 010c1414 1f0f0a80 00000870             ........p...
> OMAP3_EVM # boot
> smc911x: detected LAN9221 controller
> smc911x: phy initialized
> smc911x: MAC 00:50:c2:0d:6a:63
> BOOTP broadcast 1
> BOOTP broadcast 2
> DHCP client bound to address 172.16.21.17
> Using smc911x-0 device
> TFTP from server 172.16.21.1; our IP address is 172.16.21.17
> Filename 'uImage-lil'.
> Load address: 0x82000000
> Loading: #################################################################
>          #################################################################
>          #################################################################
>          #################################################################
>          #################################################################
>          #################################################################
>          #################################################################
>          #################################################################
>          #################################################################
>          #################################################################
>          #################################################################
>          ####################################
>          2.8 MiB/s
> done
> Bytes transferred = 3841635 (3a9e63 hex)
> ## Booting kernel from Legacy Image at 82000000 ...
>    Image Name:   next-20130417-38-g03de9e2
>    Image Type:   ARM Linux Kernel Image (uncompressed)
>    Data Size:    3841571 Bytes = 3.7 MiB
>    Load Address: 80008000
>    Entry Point:  80008000
>    Verifying Checksum ... OK
>    Loading Kernel Image ... OK
> OK
> 
> Starting kernel ...
> 
> [    0.000000] Booting Linux on physical CPU 0x0
> [    0.000000] Linux version 3.9.0-rc7-next-20130417-00038-g03de9e2 (honschu@mars) (gcc version 4.4.5 (Debian 4.4.5-8) ) #374 PREEMPT Thu Apr 18 22:18:15 CEST 2013
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
> [    0.000000]       .text : 0xc0008000 - 0xc06a9f90   (6792 kB)
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
> [    0.001129] Calibrating delay loop... 398.13 BogoMIPS (lpj=1990656)
> [    0.119659] pid_max: default: 4096 minimum: 301
> [    0.120025] Security Framework initialized
> [    0.120147] Mount-cache hash table entries: 512
> [    0.136932] CPU: Testing write buffer coherency: ok
> [    0.138458] Setting up static identity map for 0xc04efb68 - 0xc04efbc0
> [    0.143096] devtmpfs: initialized
> [    0.199432] pinctrl core: initialized pinctrl subsystem
> [    0.202819] regulator-dummy: no parameters
> [    0.204528] NET: Registered protocol family 16
> [    0.205261] DMA: preallocated 256 KiB pool for atomic coherent allocations
> [    0.213256] Reprogramming SDRC clock to 400000000 Hz
> [    0.231018] pinctrl-single 48002030.pinmux: 742 pins at pa fa002030 size 1484
> [    0.232818] pinctrl-single 48002a00.pinmux: 46 pins at pa fa002a00 size 92
> [    0.236236] OMAP GPIO hardware version 2.5
> [    0.254028] platform 49022000.mcbsp: alias fck already exists
> [    0.254913] platform 49024000.mcbsp: alias fck already exists
> [    0.263214] omap-gpmc 6e000000.gpmc: GPMC revision 5.0
> [    0.270019] No ATAGs?
> [    0.270050] hw-breakpoint: debug architecture 0x4 unsupported.
> [    0.272705] OMAP DMA hardware revision 5.0
> [    0.286834] bio: create slab <bio-0> at 0
> [    0.289367] VCC3: 3300 mV
> [    0.292266] SCSI subsystem initialized
> [    0.292877] usbcore: registered new interface driver usbfs
> [    0.293029] usbcore: registered new interface driver hub
> [    0.293518] usbcore: registered new device driver usb
> [    0.295989] omap_i2c i2c.8: bus 0 rev4.4 at 2600 kHz
> [    0.307556] twl 0-0048: PIH (irq 23) chaining IRQs 338..346
> [    0.308135] twl 0-0048: power (irq 343) chaining IRQs 346..353
> [    0.311401] VDD1: 600 <--> 1450 mV at 1200 mV
> [    0.313507] VDAC: 1800 mV
> [    0.315582] VPLL2: 1800 mV
> [    0.317657] VMMC1: 1850 <--> 3150 mV at 3000 mV
> [    0.319427] VUSB1V5: failed to apply 1500000uV constraint
> [    0.322174] twl_reg regulator-vusb1v5.24: can't register VUSB1V5, -22
> [    0.322235] twl_reg: probe of regulator-vusb1v5.24 failed with error -22
> [    0.323425] VUSB1V8: failed to apply 1800000uV constraint
> [    0.323852] twl_reg regulator-vusb1v8.25: can't register VUSB1V8, -22
> [    0.323913] twl_reg: probe of regulator-vusb1v8.25 failed with error -22
> [    0.325103] VUSB3V1: failed to apply 3100000uV constraint
> [    0.325531] twl_reg regulator-vusb3v1.26: can't register VUSB3V1, -22
> [    0.325592] twl_reg: probe of regulator-vusb3v1.26 failed with error -22
> [    0.326690] VSIM: 1800 <--> 3000 mV at 1800 mV
> [    0.329071] twl4030_gpio gpio.28: gpio (irq 338) chaining IRQs 354..371
> [    0.333251] VIO: 1800 mV
> [    0.335571] VAUX2_4030: 2800 mV
> [    0.337371] VDD2: at 1200 mV
> [    0.339508] omap_i2c i2c.9: bus 1 rev4.4 at 2600 kHz
> [    0.340820] omap_i2c i2c.10: bus 2 rev4.4 at 2600 kHz
> [    0.341369] pps_core: LinuxPPS API ver. 1 registered
> [    0.341400] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
> [    0.341491] PTP clock support registered
> [    0.345855] cfg80211: Calling CRDA to update world regulatory domain
> [    0.346649] Switching to clocksource 32k_counter
> [    0.374969] NET: Registered protocol family 2
> [    0.377319] TCP established hash table entries: 1024 (order: 1, 8192 bytes)
> [    0.377532] TCP bind hash table entries: 1024 (order: 3, 36864 bytes)
> [    0.378112] TCP: Hash tables configured (established 1024 bind 1024)
> [    0.378326] TCP: reno registered
> [    0.378356] UDP hash table entries: 128 (order: 1, 10240 bytes)
> [    0.378540] UDP-Lite hash table entries: 128 (order: 1, 10240 bytes)
> [    0.379547] NET: Registered protocol family 1
> [    0.381042] RPC: Registered named UNIX socket transport module.
> [    0.381072] RPC: Registered udp transport module.
> [    0.381103] RPC: Registered tcp transport module.
> [    0.381103] RPC: Registered tcp NFSv4.1 backchannel transport module.
> [    0.381927] hw perfevents: enabled with ARMv7 Cortex-A8 PMU driver, 5 counters available
> [    0.391540] VFS: Disk quotas dquot_6.5.2
> [    0.391632] Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
> [    0.394287] NFS: Registering the id_resolver key type
> [    0.394866] Key type id_resolver registered
> [    0.394897] Key type id_legacy registered
> [    0.395050] fuse init (API version 7.21)
> [    0.396270] msgmni has been set to 226
> [    0.401031] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 250)
> [    0.401184] io scheduler noop registered
> [    0.401184] io scheduler deadline registered
> [    0.401245] io scheduler cfq registered (default)
> [    0.403167] OMAP DSS rev 2.0
> [    0.405731] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
> [    0.412078] serial.5: ttyO0 at MMIO 0x4806a000 (irq = 88) is a OMAP UART0
> [    1.136993] console [ttyO0] enabled
> [    1.142608] serial.6: ttyO1 at MMIO 0x4806c000 (irq = 89) is a OMAP UART1
> [    1.151550] serial.7: ttyO2 at MMIO 0x49020000 (irq = 90) is a OMAP UART2
> [    1.177642] brd: module loaded
> [    1.191802] loop: module loaded
> [    1.196746] mtdoops: mtd device (mtddev=name/number) must be supplied
> [    1.204925] Missing elm_id property, fall back to Software BCH
> [    1.213653] enabling NAND BCH ecc with 8-bit correction
> [    1.224304] Unhandled fault: external abort on non-linefetch (0x1008) at 0xc8852000
> [    1.232360] Internal error: : 1008 [#1] PREEMPT ARM
> [    1.237457] Modules linked in:
> [    1.240661] CPU: 0    Not tainted  (3.9.0-rc7-next-20130417-00038-g03de9e2 #374)
> [    1.248443] PC is at nand_read_byte16+0x8/0x1c
> [    1.253112] LR is at nand_command+0x174/0x1ec
> [    1.257659] pc : [<c032d9a0>]    lr : [<c0331704>]    psr: 60000113
> [    1.257659] sp : c7057de8  ip : c0331590  fp : 00000000
> [    1.269714] r10: c7057e4c  r9 : c7057e48  r8 : ffffffff
> [    1.275177] r7 : c72ce370  r6 : ffffffff  r5 : 000000ff  r4 : c72ce050
> [    1.282043] r3 : c8852000  r2 : 00000081  r1 : ffffffff  r0 : c72ce050
> [    1.288879] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
> [    1.296539] Control: 10c5387d  Table: 80004019  DAC: 00000015
> [    1.302581] Process swapper (pid: 1, stack limit = 0xc7056238)
> [    1.308685] Stack: (0xc7057de8 to 0xc7058000)
> [    1.313262] 7de0:                   00000000 c72ce370 c72ce050 00000000 c7057e18 c0331e74
> [    1.321807] 7e00: 00000001 00000000 c72c7b80 c72ce000 c72ce050 00000002 00000000 c0c74054
> [    1.330383] 7e20: c72ce370 c72ce050 00000000 00000001 00000002 0000008e c0702a20 c033242c
> [    1.338989] 7e40: c7057e48 00000000 c0637598 00000008 00000000 c72ce000 c72ce050 c700a690
> [    1.347564] 7e60: 00000000 c0c74054 0000008e c03360b8 00000000 c72c7f50 c7120ef0 00000000
> [    1.356140] 7e80: 00000000 c0702a20 c0702a28 c0c73628 c072a57c c0702a20 00000000 c072a57c
> [    1.364685] 7ea0: c06d12fc c02ef458 c0c73628 c02ee12c c0702a20 c072a57c c0702a54 00000000
> [    1.373260] 7ec0: c06c709c c02ee2e4 c0702a20 c072a57c c0702a54 c02ee390 c072a57c c02ee2fc
> [    1.381835] 7ee0: c7057ee8 c02eca5c c704b2a8 c7115690 c704b2d8 c072a57c c0723888 c72ba640
> [    1.390411] 7f00: 00000000 c02ed304 c05feb28 c072a57c c073bd40 c06d12f4 c072a57c c073bd40
> [    1.398986] 7f20: 00000000 c02ee980 c06d12f4 c06db898 c073bd40 00000000 c06c709c c000874c
> [    1.407562] 7f40: 00000000 c06d12f4 00000006 c073bd40 c06d12f4 c06db898 c073bd40 00000007
> [    1.416137] 7f60: c06aa3e8 c06aa2b0 00000006 00000006 c06aa3e8 00000000 c06db460 c06db460
> [    1.424713] 7f80: 00000000 00000000 00000000 00000000 00000000 c06aa350 00000000 c04eb2c8
> [    1.433288] 7fa0: 00000000 c04eb2d0 00000000 c0009ec8 00000000 00000000 00000000 00000000
> [    1.441833] 7fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> [    1.450408] 7fe0: 00000000 00000000 00000000 00000000 00000013 00000000 1051a000 04440800
> [    1.458984] [<c032d9a0>] (nand_read_byte16+0x8/0x1c) from [<c0331704>] (nand_command+0x174/0x1ec)
> [    1.468292] [<c0331704>] (nand_command+0x174/0x1ec) from [<c0331e74>] (nand_get_flash_type+0x4c/0x5b8)
> [    1.478057] [<c0331e74>] (nand_get_flash_type+0x4c/0x5b8) from [<c033242c>] (nand_scan_ident+0x4c/0x1a8)
> [    1.488006] [<c033242c>] (nand_scan_ident+0x4c/0x1a8) from [<c03360b8>] (omap_nand_probe+0x2dc/0x6dc)
> [    1.497680] [<c03360b8>] (omap_nand_probe+0x2dc/0x6dc) from [<c02ef458>] (platform_drv_probe+0x18/0x1c)
> [    1.507537] [<c02ef458>] (platform_drv_probe+0x18/0x1c) from [<c02ee12c>] (really_probe+0x70/0x1f8)
> [    1.517028] [<c02ee12c>] (really_probe+0x70/0x1f8) from [<c02ee2e4>] (driver_probe_device+0x30/0x48)
> [    1.526641] [<c02ee2e4>] (driver_probe_device+0x30/0x48) from [<c02ee390>] (__driver_attach+0x94/0x98)
> [    1.536407] [<c02ee390>] (__driver_attach+0x94/0x98) from [<c02eca5c>] (bus_for_each_dev+0x74/0x98)
> [    1.545898] [<c02eca5c>] (bus_for_each_dev+0x74/0x98) from [<c02ed304>] (bus_add_driver+0x1c8/0x234)
> [    1.555480] [<c02ed304>] (bus_add_driver+0x1c8/0x234) from [<c02ee980>] (driver_register+0x78/0x140)
> [    1.565063] [<c02ee980>] (driver_register+0x78/0x140) from [<c000874c>] (do_one_initcall+0xc0/0x134)
> [    1.574615] [<c000874c>] (do_one_initcall+0xc0/0x134) from [<c06aa2b0>] (do_basic_setup+0x84/0xc4)
> [    1.584014] [<c06aa2b0>] (do_basic_setup+0x84/0xc4) from [<c06aa350>] (kernel_init_freeable+0x60/0xf8)
> [    1.593780] [<c06aa350>] (kernel_init_freeable+0x60/0xf8) from [<c04eb2d0>] (kernel_init+0x8/0xe4)
> [    1.603179] [<c04eb2d0>] (kernel_init+0x8/0xe4) from [<c0009ec8>] (ret_from_fork+0x14/0x2c)
> [    1.611938] Code: f57ff04f e12fff1e e59030dc e5933000 (e1d300b0)
> [    1.618377] ---[ end trace 7ab5f8dfed0385fd ]---
> [    1.623229] ------------[ cut here ]------------
> [    1.628082] Kernel BUG at c0287d84 [verbose debug info unavailable]
> [    1.634643] Internal error: Oops - BUG: 0 [#2] PREEMPT ARM
> [    1.640380] Modules linked in:
> [    1.643585] CPU: 0    Tainted: G      D       (3.9.0-rc7-next-20130417-00038-g03de9e2 #374)
> [    1.652313] PC is at omap3_l3_app_irq+0xa4/0x128
> [    1.657165] LR is at handle_irq_event_percpu+0x50/0x1b4
> [    1.662628] pc : [<c0287d84>]    lr : [<c0082400>]    psr: 20000193
> [    1.662628] sp : c7057bd8  ip : c7057c08  fp : c073bc1e
> [    1.674652] r10: c70055b8  r9 : 3ccf0000  r8 : 0b6db6c3
> [    1.680114] r7 : 00000000  r6 : 00000000  r5 : 00020000  r4 : 00000000
> [    1.686950] r3 : 00020000  r2 : 00000004  r1 : f8000000  r0 : 00020000
> [    1.693786] Flags: nzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment user
> [    1.701354] Control: 10c5387d  Table: 80004019  DAC: 00000015
> [    1.707366] Process swapper (pid: 1, stack limit = 0xc7056238)
> [    1.713470] Stack: (0xc7057bd8 to 0xc7058000)
> [    1.718048] 7bc0:                                                       00000000 60000193
> [    1.726593] 7be0: 00000001 c7097a00 c7005590 00000000 00000000 0000001a c7005540 c70055b8
> [    1.735168] 7c00: c073bc1e c0082400 c7056000 00000000 60000193 c7005540 c7005590 c7097a00
> [    1.743713] 7c20: c073c814 ffffffff c7057e48 c7057e4c 00000000 c00825a0 c7005540 c7005590
> [    1.752288] 7c40: 00000000 c0084aec 0000001a 0000001a 00000000 c00823a0 c071c5c4 c000a69c
> [    1.760864] 7c60: fa200000 0000001a c7057c88 c0008538 c04ef830 60000113 ffffffff c7057cbc
> [    1.769439] 7c80: ffffffff c00099c4 00000001 00000001 c7055440 00000000 c06e803c c7056000
> [    1.778015] 7ca0: 0000000b 00000001 ffffffff c7057e48 c7057e4c 00000000 c7057ca8 c7057cd0
> [    1.786590] 7cc0: c04ef828 c04ef830 60000113 ffffffff c7055440 c0033e90 60000193 c06e8540
> [    1.795166] 7ce0: 0000000b c7057da0 ffffffff c000d3b0 00001008 c06e8fc4 c8852000 c00084c4
> [    1.803741] 7d00: 00000000 c006ad30 00000007 00000000 00000000 c8852000 00000001 c0035abc
> [    1.812286] 7d20: c7006a90 00000001 00000000 00000004 ffff8b4a 00200140 60000193 c7056000
> [    1.820861] 7d40: 00000035 00000000 01400000 c0087bd8 c071c5c4 00000006 00000000 c00099e8
> [    1.829437] 7d60: c7055440 00000001 c7057dc4 00000000 c7056000 00000000 00000000 c006ad80
> [    1.838043] 7d80: c0030afc 20000113 ffffffff c032d9a0 60000113 ffffffff c7057dd4 c000995c
> [    1.846588] 7da0: c72ce050 ffffffff 00000081 c8852000 c72ce050 000000ff ffffffff c72ce370
> [    1.855163] 7dc0: ffffffff c7057e48 c7057e4c 00000000 c0331590 c7057de8 c0331704 c032d9a0
> [    1.863739] 7de0: 60000113 ffffffff 00000000 c72ce370 c72ce050 00000000 c7057e18 c0331e74
> [    1.872314] 7e00: 00000001 00000000 c72c7b80 c72ce000 c72ce050 00000002 00000000 c0c74054
> [    1.880889] 7e20: c72ce370 c72ce050 00000000 00000001 00000002 0000008e c0702a20 c033242c
> [    1.889465] 7e40: c7057e48 00000000 c0637598 00000008 00000000 c72ce000 c72ce050 c700a690
> [    1.898040] 7e60: 00000000 c0c74054 0000008e c03360b8 00000000 c72c7f50 c7120ef0 00000000
> [    1.906646] 7e80: 00000000 c0702a20 c0702a28 c0c73628 c072a57c c0702a20 00000000 c072a57c
> [    1.915222] 7ea0: c06d12fc c02ef458 c0c73628 c02ee12c c0702a20 c072a57c c0702a54 00000000
> [    1.923797] 7ec0: c06c709c c02ee2e4 c0702a20 c072a57c c0702a54 c02ee390 c072a57c c02ee2fc
> [    1.932373] 7ee0: c7057ee8 c02eca5c c704b2a8 c7115690 c704b2d8 c072a57c c0723888 c72ba640
> [    1.940948] 7f00: 00000000 c02ed304 c05feb28 c072a57c c073bd40 c06d12f4 c072a57c c073bd40
> [    1.949523] 7f20: 00000000 c02ee980 c06d12f4 c06db898 c073bd40 00000000 c06c709c c000874c
> [    1.958068] 7f40: 00000000 c06d12f4 00000006 c073bd40 c06d12f4 c06db898 c073bd40 00000007
> [    1.966644] 7f60: c06aa3e8 c06aa2b0 00000006 00000006 c06aa3e8 00000000 c06db460 c06db460
> [    1.975219] 7f80: 00000000 00000000 00000000 00000000 00000000 c06aa350 00000000 c04eb2c8
> [    1.983795] 7fa0: 00000000 c04eb2d0 00000000 c0009ec8 00000000 00000000 00000000 00000000
> [    1.992370] 7fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> [    2.000946] 7fe0: 00000000 00000000 00000000 00000000 00000013 00000000 1051a000 04440800
> [    2.009521] [<c0287d84>] (omap3_l3_app_irq+0xa4/0x128) from [<c0082400>] (handle_irq_event_percpu+0x50/0x1b4)
> [    2.019897] [<c0082400>] (handle_irq_event_percpu+0x50/0x1b4) from [<c00825a0>] (handle_irq_event+0x3c/0x5c)
> [    2.030212] [<c00825a0>] (handle_irq_event+0x3c/0x5c) from [<c0084aec>] (handle_level_irq+0x8c/0x118)
> [    2.039886] [<c0084aec>] (handle_level_irq+0x8c/0x118) from [<c00823a0>] (generic_handle_irq+0x28/0x30)
> [    2.049713] [<c00823a0>] (generic_handle_irq+0x28/0x30) from [<c000a69c>] (handle_IRQ+0x30/0x84)
> [    2.058898] [<c000a69c>] (handle_IRQ+0x30/0x84) from [<c0008538>] (omap3_intc_handle_irq+0x64/0x74)
> [    2.068389] [<c0008538>] (omap3_intc_handle_irq+0x64/0x74) from [<c00099c4>] (__irq_svc+0x44/0x78)
> [    2.077758] Exception stack(0xc7057c88 to 0xc7057cd0)
> [    2.083038] 7c80:                   00000001 00000001 c7055440 00000000 c06e803c c7056000
> [    2.091613] 7ca0: 0000000b 00000001 ffffffff c7057e48 c7057e4c 00000000 c7057ca8 c7057cd0
> [    2.100189] 7cc0: c04ef828 c04ef830 60000113 ffffffff
> [    2.105468] [<c00099c4>] (__irq_svc+0x44/0x78) from [<c04ef830>] (_raw_spin_unlock_irq+0x2c/0x50)
> [    2.114776] [<c04ef830>] (_raw_spin_unlock_irq+0x2c/0x50) from [<c0033e90>] (do_exit+0x268/0x358)
> [    2.124084] [<c0033e90>] (do_exit+0x268/0x358) from [<c000d3b0>] (oops_end+0xb8/0xe8)
> [    2.132293] [<c000d3b0>] (oops_end+0xb8/0xe8) from [<c00084c4>] (do_DataAbort+0x88/0x98)
> [    2.140777] [<c00084c4>] (do_DataAbort+0x88/0x98) from [<c000995c>] (__dabt_svc+0x3c/0x60)
> [    2.149414] Exception stack(0xc7057da0 to 0xc7057de8)
> [    2.154693] 7da0: c72ce050 ffffffff 00000081 c8852000 c72ce050 000000ff ffffffff c72ce370
> [    2.163269] 7dc0: ffffffff c7057e48 c7057e4c 00000000 c0331590 c7057de8 c0331704 c032d9a0
> [    2.171844] 7de0: 60000113 ffffffff
> [    2.175506] [<c000995c>] (__dabt_svc+0x3c/0x60) from [<c032d9a0>] (nand_read_byte16+0x8/0x1c)
> [    2.184417] [<c032d9a0>] (nand_read_byte16+0x8/0x1c) from [<c0331704>] (nand_command+0x174/0x1ec)
> [    2.193725] [<c0331704>] (nand_command+0x174/0x1ec) from [<c0331e74>] (nand_get_flash_type+0x4c/0x5b8)
> [    2.203460] [<c0331e74>] (nand_get_flash_type+0x4c/0x5b8) from [<c033242c>] (nand_scan_ident+0x4c/0x1a8)
> [    2.213378] [<c033242c>] (nand_scan_ident+0x4c/0x1a8) from [<c03360b8>] (omap_nand_probe+0x2dc/0x6dc)
> [    2.223052] [<c03360b8>] (omap_nand_probe+0x2dc/0x6dc) from [<c02ef458>] (platform_drv_probe+0x18/0x1c)
> [    2.232879] [<c02ef458>] (platform_drv_probe+0x18/0x1c) from [<c02ee12c>] (really_probe+0x70/0x1f8)
> [    2.242370] [<c02ee12c>] (really_probe+0x70/0x1f8) from [<c02ee2e4>] (driver_probe_device+0x30/0x48)
> [    2.251953] [<c02ee2e4>] (driver_probe_device+0x30/0x48) from [<c02ee390>] (__driver_attach+0x94/0x98)
> [    2.261718] [<c02ee390>] (__driver_attach+0x94/0x98) from [<c02eca5c>] (bus_for_each_dev+0x74/0x98)
> [    2.271179] [<c02eca5c>] (bus_for_each_dev+0x74/0x98) from [<c02ed304>] (bus_add_driver+0x1c8/0x234)
> [    2.280761] [<c02ed304>] (bus_add_driver+0x1c8/0x234) from [<c02ee980>] (driver_register+0x78/0x140)
> [    2.290344] [<c02ee980>] (driver_register+0x78/0x140) from [<c000874c>] (do_one_initcall+0xc0/0x134)
> [    2.299926] [<c000874c>] (do_one_initcall+0xc0/0x134) from [<c06aa2b0>] (do_basic_setup+0x84/0xc4)
> [    2.309295] [<c06aa2b0>] (do_basic_setup+0x84/0xc4) from [<c06aa350>] (kernel_init_freeable+0x60/0xf8)
> [    2.319061] [<c06aa350>] (kernel_init_freeable+0x60/0xf8) from [<c04eb2d0>] (kernel_init+0x8/0xe4)
> [    2.328460] [<c04eb2d0>] (kernel_init+0x8/0xe4) from [<c0009ec8>] (ret_from_fork+0x14/0x2c)
> [    2.337219] Code: e5911008 e2813e53 e1c320d0 eaffffe8 (e7f001f2)
> [    2.343597] ---[ end trace 7ab5f8dfed0385fe ]---
> [    2.348419] Kernel panic - not syncing: Fatal exception in interrupt

I don't see any other errors in the log. So I am wondering if the
chip-select mapping is setup correctly. Can you share a dump of the gpmc
registers from u-boot?

Cheers
Jon

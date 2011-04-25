From: Steve Calfee <stevecalfee@gmail.com>
Subject: Re: [Regression?] Removed regulator support in ehci-omap
Date: Mon, 25 Apr 2011 10:23:11 -0700
Message-ID: <4DB5ADFF.5030502@gmail.com>
References: <20110411093214.GA18215@rainbow><4DA3350E.2060400@gmail.com><BANLkTinDMZ+CyGCmzZu8cSz1L_yFXxm+vg@mail.gmail.com><112ef82aebc719ef25cde126f2014ebc@mail.gmail.com><20110412040420.GB25239@rainbow><bcd954a468e6a07bd673b7d0731e9344@mail.gmail.com><4DB0D58E.4030508@signal11.us><8712165194c49f0b4d8c1bd1fe717b8a@mail.gmail.com><4DB58108.4040708@signal11.us> <BANLkTinn7C2gVKg4v8dbUxo7yYycdFM8PA@mail.gmail.com> <0e9c63ec5ebfd57af1ac3318e436efb9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:62026 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758629Ab1DYRXQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 25 Apr 2011 13:23:16 -0400
In-Reply-To: <0e9c63ec5ebfd57af1ac3318e436efb9@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Keshava Munegowda <keshava_mgowda@ti.com>
Cc: Steve Sakoman <sakoman@gmail.com>, Alan Ott <alan@signal11.us>, Dmitry Artamonow <mad_soft@inbox.ru>, Felipe Balbi <balbi@ti.com>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org

On 04/25/11 09:41, Keshava Munegowda wrote:
>> -----Original Message-----
>> From: Steve Sakoman [mailto:sakoman@gmail.com]
>> Sent: Monday, April 25, 2011 7:46 PM
>> To: Alan Ott
>> Cc: Keshava Munegowda; Dmitry Artamonow; Steve Calfee; Felipe Balbi;
> linux-usb@vger.kernel.org;
>> linux-omap@vger.kernel.org; linux-kernel@vger.kernel.org
>> Subject: Re: [Regression?] Removed regulator support in ehci-omap
>>
>> On Mon, Apr 25, 2011 at 7:11 AM, Alan Ott <alan@signal11.us> wrote:
>>> On 04/24/2011 02:37 AM, Keshava Munegowda wrote:
>>>>> -----Original Message-----
>>>>> From: Alan Ott [mailto:alan@signal11.us]
>>>>> Sent: Friday, April 22, 2011 6:41 AM
>>>>> To: Keshava Munegowda
>>>>> Cc: Dmitry Artamonow; Steve Sakoman; Steve Calfee; Felipe Balbi;
>>>> linux-usb@vger.kernel.org; linux-
>>>>> omap@vger.kernel.org; linux-kernel@vger.kernel.org
>>>>> Subject: Re: [Regression?] Removed regulator support in ehci-omap
>>>>>
>>>>> On 04/12/2011 12:20 PM, Keshava Munegowda wrote:
>>>>>>> Ah, so EHCI/OHCI common code was moved into drivers/mfd... Good.
>>>>>>> But seems regulators support was lost somewhere during transition
> -
>>>> the
>>>>>>> only mentioning about regulators in omap-usb-host.c is "#include"
> :
>>>>>>>
>>>>>>> mad@macmini:~/kernel-hack/linux-2.6(master)$ grep -i regulator
>>>>>> drivers/mfd/omap-usb-host.c
>>>>>> Thanks ! I will add some time next week!
>>>>> I have confirmed this on my BeagleBoard-xM. 2.6.38 works, but the
>>>>> 2.6.39-rc4+ head from yesterday did not. It seems that the regulator
>>>>> does not turn the power on for the USB hub which the ethernet is
>>>>> attached to.
>>>>>
>>>>> I connected this issue to bug 33092 in bugzilla[1].
>>>>>
>>>>> Alan.
>>>>>
>>>>> [1] https://bugzilla.kernel.org/show_bug.cgi?id=33092
>>>> I have posted the patches on April 22, 2011.
>>>> If possible I request you to test this.
>>>
>>> Hi Keshava,
>>>
>>> If you mean this patch[1], then I tested it against the head and it
>>> didn't fix my problem. I couldn't convince myself that your patch was
>>> supposed to be the whole fix to my problem (since it wasn't mentioned
> on
>>> this thread) so I didn't reply with my findings. Sorry about that.
>>
>> Same here.  The real issue (at least for Overo) turned out to be:
>>
>> https://lkml.org/lkml/2011/4/14/45
>>
>> Steve
> 
> But, I was not aware of the fix of the link:
> https://lkml.org/lkml/2011/4/14/45
> Sorry for this.
> Same fix works for beagle-XM and I have tested this.

I just tried your 3 patches on my beagleboardxm. It still fails to boot.
Maybe I have a different problem? Your fix did enable usb (at least it
found the hub and usbnet driver, but the smsc95xx driver may or may not
be working.

Here is my failed 2.6.39rc4 boot log. If I back up to 2.6.38 the kernel
does find the nfs server and starts.

Uncompressing Linux... done, booting the kernel.
[    0.000000] Linux version 2.6.39-rc4+ (calfee@Gracie) (gcc version
4.5.2 (Bu1
[    0.000000] CPU: ARMv7 Processor [413fc082] revision 2 (ARMv7),
cr=10c53c7f
[    0.000000] CPU: VIPT nonaliasing data cache, VIPT aliasing
instruction cache
[    0.000000] Machine: OMAP3 Beagle Board
[    0.000000] Memory policy: ECC disabled, Data cache writeback
[    0.000000] OMAP3630 ES1.1 (l2cache iva sgx neon isp 192mhz_clk )
[    0.000000] SRAM: Mapped pa 0x40200000 to va 0xfe400000 size: 0x10000
[    0.000000] Clocking rate (Crystal/Core/MPU): 26.0/332/600 MHz
[    0.000000] Reprogramming SDRC clock to 332000000 Hz
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.
Total pa8
[    0.000000] Kernel command line: console=tty0 console=ttyO2,115200n8
mpuratet
[    0.000000] PID hash table entries: 2048 (order: 1, 8192 bytes)
[    0.000000] Dentry cache hash table entries: 65536 (order: 6, 262144
bytes)
[    0.000000] Inode-cache hash table entries: 32768 (order: 5, 131072
bytes)
[    0.000000] Memory: 512MB = 512MB total
[    0.000000] Memory: 508416k/508416k available, 15872k reserved, 0K
highmem
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
[    0.000000]     DMA     : 0xffc00000 - 0xffe00000   (   2 MB)
[    0.000000]     vmalloc : 0xe0800000 - 0xf8000000   ( 376 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xe0000000   ( 512 MB)
[    0.000000]     modules : 0xbf000000 - 0xc0000000   (  16 MB)
[    0.000000]       .init : 0xc0008000 - 0xc0031000   ( 164 kB)
[    0.000000]       .text : 0xc0031000 - 0xc0408638   (3934 kB)
[    0.000000]       .data : 0xc040a000 - 0xc05b6500   (1714 kB)
[    0.000000] NR_IRQS:410
[    0.000000] IRQ: Found an INTC at 0xfa200000 (revision 4.0) with 96
interrups
[    0.000000] Total of 96 interrupts on 1 active controller
[    0.000000] omap_hwmod: gpt12_fck: missing clockdomain for gpt12_fck.
[    0.000000] OMAP clockevent source: GPTIMER12 at 32768 Hz
[    0.000000] sched_clock: 32 bits at 32kHz, resolution 30517ns, wraps
every 1s
[    0.000000] Console: colour dummy device 80x30
[    0.000000] console [tty0] enabled
[    0.000000] Lock dependency validator: Copyright (c) 2006 Red Hat,
Inc., Ingr
[    0.000000] ... MAX_LOCKDEP_SUBCLASSES:  8
[    0.000000] ... MAX_LOCK_DEPTH:          48
[    0.000000] ... MAX_LOCKDEP_KEYS:        8191
[    0.000000] ... CLASSHASH_SIZE:          4096
[    0.000000] ... MAX_LOCKDEP_ENTRIES:     16384
[    0.000000] ... MAX_LOCKDEP_CHAINS:      32768
[    0.000000] ... CHAINHASH_SIZE:          16384
[    0.000000]  memory used by lock dependency info: 3951 kB
[    0.000000]  per task-struct memory footprint: 2304 bytes
[    0.004119] Calibrating delay loop... 509.42 BogoMIPS (lpj=1990656)
[    0.080078] pid_max: default: 32768 minimum: 301
[    0.080596] Security Framework initialized
[    0.080871] Mount-cache hash table entries: 512
[    0.085083] CPU: Testing write buffer coherency: ok
[    0.089233] devtmpfs: initialized
[    0.098937] omap_hwmod: _populate_mpu_rt_base found no _mpu_rt_va for
l4_core
[    0.098999] omap_hwmod: _populate_mpu_rt_base found no _mpu_rt_va for
l4_per
[    0.099029] omap_hwmod: _populate_mpu_rt_base found no _mpu_rt_va for
l4_wkup
[    0.113677] omap_hwmod: i2c1: softreset failed (waited 10000 usec)
[    0.126312] omap_hwmod: i2c2: softreset failed (waited 10000 usec)
[    0.138977] omap_hwmod: i2c3: softreset failed (waited 10000 usec)
[    0.144317] print_constraints: dummy:
[    0.145507] NET: Registered protocol family 16
[    0.147155] GPMC revision 5.0
[    0.156372] omap_device: omap_gpio.0: new worst case activate latency
0: 9152
[    0.157562] OMAP GPIO hardware version 2.5
[    0.158660] OMAP GPIO hardware version 2.5
[    0.159667] OMAP GPIO hardware version 2.5
[    0.161102] OMAP GPIO hardware version 2.5
[    0.162139] OMAP GPIO hardware version 2.5
[    0.163177] OMAP GPIO hardware version 2.5
[    0.171203] omap_mux_init: Add partition: #1: core, flags: 0
[    0.174316] OMAP3 Beagle Rev: xM
[    0.175567] enable i2c bus 2
[    0.180664] omap_device: omap_uart.0: new worst case activate latency
0: 3057
[    0.181091] omap_device: omap_uart.0: new worst case deactivate
latency 0: 37
[    0.189422] Found NAND on CS0
[    0.189453] Registering NAND on CS0
[    0.190612] Unable to get DVI reset GPIO
[    0.190979] hw-breakpoint: debug architecture 0x4 unsupported.
[    0.246948] Switched to new clocking rate (Crystal/Core/MPU):
26.0/332/800 Mz
[    0.247680] OMAP DMA hardware revision 5.0
[    0.302856] bio: create slab <bio-0> at 0
[    0.309051] omap_device: omap2_mcspi.1: new worst case activate
latency 0: 37
[    0.310394] omap_device: omap2_mcspi.1: new worst case deactivate
latency 0:7
[    0.317077] usbcore: registered new interface driver usbfs
[    0.318389] usbcore: registered new interface driver hub
[    0.319305] usbcore: registered new device driver usb
[    0.321685] omap_device: omap_i2c.1: new worst case activate latency
0: 30517
[    0.321899] omap_i2c omap_i2c.1: bus 1 rev4.0 at 2600 kHz
[    0.331848] twl4030: PIH (irq 7) chaining IRQs 368..375
[    0.332092] twl4030: power (irq 373) chaining IRQs 376..383
[    0.334289] twl4030: gpio (irq 368) chaining IRQs 384..401
[    0.341613] print_constraints: VUSB1V5: 1500 mV normal standby
[    0.343658] print_constraints: VUSB1V8: 1800 mV normal standby
[    0.345703] print_constraints: VUSB3V1: 3100 mV normal standby
[    0.354644] twl4030_usb twl4030_usb: Initialized TWL4030 USB module
[    0.358551] print_constraints: VMMC1: 1850 <--> 3150 mV at 3000 mV
normal sty
[    0.360900] print_constraints: VDAC: 1800 mV normal standby
[    0.362976] print_constraints: VDVI: 1800 mV normal standby
[    0.365173] print_constraints: VSIM: 1800 <--> 3000 mV at 1800 mV
normal stay
[    0.365631] omap_device: omap_i2c.1: new worst case deactivate
latency 0: 307
[    0.365966] omap_i2c omap_i2c.2: bus 2 rev4.0 at 100 kHz
[    0.380065] omap_i2c omap_i2c.3: bus 3 rev4.0 at 100 kHz
[    0.386962] Advanced Linux Sound Architecture Driver Version 1.0.24.
[    0.390380] Switching to clocksource 32k_counter
[    0.393524] Switched to NOHz mode on CPU #0
[    0.468292] NET: Registered protocol family 2
[    0.469360] IP route cache hash table entries: 4096 (order: 2, 16384
bytes)
[    0.469848] IPv4 FIB: Using LC-trie version 0.409
[    0.470916] TCP established hash table entries: 16384 (order: 5,
131072 byte)
[    0.471435] TCP bind hash table entries: 16384 (order: 7, 720896 bytes)
[    0.478424] TCP: Hash tables configured (established 16384 bind 16384)
[    0.478515] TCP reno registered
[    0.478576] UDP hash table entries: 256 (order: 2, 24576 bytes)
[    0.478820] UDP-Lite hash table entries: 256 (order: 2, 24576 bytes)
[    0.479949] NET: Registered protocol family 1
[    0.481384] RPC: Registered udp transport module.
[    0.481445] RPC: Registered tcp transport module.
[    0.481445] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.571472] msgmni has been set to 993
[    0.576110] io scheduler noop registered
[    0.576232] io scheduler cfq registered (default)
[    0.577728] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    0.586456] omap_uart.0: ttyO0 at MMIO 0x4806a000 (irq = 72) is a
OMAP UART0
[    0.588439] omap_uart.1: ttyO1 at MMIO 0x4806c000 (irq = 73) is a
OMAP UART1
[    0.589843] omap_uart.2: ttyO2 at MMIO 0x49020000 (irq = 74) is a
OMAP UART2
[    1.304718] console [ttyO2] enabled
[    1.309814] omap_uart.3: ttyO3 at MMIO 0x49042000 (irq = 80) is a
OMAP UART3
[    1.355529] brd: module loaded
[    1.377014] loop: module loaded
[    1.380828] omap_device: omap_i2c.1: new worst case activate latency
0: 91552
[    1.394165] mtdoops: mtd device (mtddev=name/number) must be supplied
[    1.401580] omap2-nand driver initializing
[    1.406616] No NAND device found.
[    1.410339] No NAND device found.
[    1.414825] OneNAND driver initializing
[    1.423034] usbcore: registered new interface driver cdc_ether
[    1.430145] usbcore: registered new interface driver smsc95xx
[    1.436187] cdc_ncm: 7-Feb-2011
[    1.440185] usbcore: registered new interface driver cdc_ncm
[    1.446197] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    3.468749] ehci-omap ehci-omap.0: OMAP-EHCI Host Controller
[    3.476898] ehci-omap ehci-omap.0: new USB bus registered, assigned
bus numb1
[    3.485168] ehci-omap ehci-omap.0: irq 77, io mem 0x48064800
[    3.500061] ehci-omap ehci-omap.0: USB 2.0 started, EHCI 1.00
[    3.506896] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
[    3.514068] usb usb1: New USB device strings: Mfr=3, Product=2,
SerialNumber1
[    3.521697] usb usb1: Product: OMAP-EHCI Host Controller
[    3.527313] usb usb1: Manufacturer: Linux 2.6.39-rc4+ ehci_hcd
[    3.533447] usb usb1: SerialNumber: ehci-omap.0
[    3.543548] hub 1-0:1.0: USB hub found
[    3.547912] hub 1-0:1.0: 3 ports detected
[    3.586456] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    3.593322] ohci-omap3 ohci-omap3.0: OMAP3 OHCI Host Controller
[    3.599914] ohci-omap3 ohci-omap3.0: new USB bus registered, assigned
bus nu2
[    3.608062] ohci-omap3 ohci-omap3.0: irq 76, io mem 0x48064400
[    3.689575] usb usb2: New USB device found, idVendor=1d6b, idProduct=0001
[    3.696746] usb usb2: New USB device strings: Mfr=3, Product=2,
SerialNumber1
[    3.704376] usb usb2: Product: OMAP3 OHCI Host Controller
[    3.710021] usb usb2: Manufacturer: Linux 2.6.39-rc4+ ohci_hcd
[    3.716186] usb usb2: SerialNumber: ohci-omap3.0
[    3.724365] hub 2-0:1.0: USB hub found
[    3.728576] hub 2-0:1.0: 3 ports detected
[    3.736267] usbcore: registered new interface driver cdc_acm
[    3.742279] cdc_acm: v0.26:USB Abstract Control Model driver for USB
modems s
[    3.753234] usbcore: registered new interface driver libusual
[    3.760955] usbcore: registered new interface driver usbserial
[    3.767150] usbserial: USB Serial Driver core
[    3.772796] USB Serial support registered for FTDI USB Serial Device
[    3.780395] usbcore: registered new interface driver ftdi_sio
[    3.786499] ftdi_sio: v1.6.0:USB FTDI Serial Converters Driver
[    3.796661] twl_rtc twl_rtc: rtc core: registered twl_rtc as rtc0
[    3.805999] i2c /dev entries driver
[    3.814941] Driver for 1-wire Dallas network protocol.
[    3.822570] omap_device: omap_wdt.-1: new worst case activate latency
0: 3057
[    3.832275] OMAP Watchdog Timer Rev 0x31: initial timeout 60 sec
[    3.838684] omap_device: omap_wdt.-1: new worst case deactivate
latency 0: 37
[    3.847747] twl4030_wdt twl4030_wdt: Failed to register misc device
[    3.854553] twl4030_wdt: probe of twl4030_wdt failed with error -16
[    3.861968] cpuidle: using governor ladder
[    3.866302] cpuidle: using governor menu
[    3.875030] usb 1-2: new high speed USB device number 2 using ehci-omap
[    3.901672] ALSA device list:
[    3.904785]   No soundcards found.
[    3.908447] oprofile: hardware counters not available
[    3.913726] oprofile: using timer interrupt.
[    3.918823] TCP cubic registered
[    3.922302] Initializing XFRM netlink socket
[    3.926910] NET: Registered protocol family 17
[    3.931732] NET: Registered protocol family 15
[    3.936370] VFP support v0.3: implementor 41 architecture 3 part 30
variant 3
[    3.948028] omap_voltage_late_init: Unable to create voltage debugfs
main dir
[    3.955749] vdd_debugfs_init: Unable to create debugfs directory for
vdd_mpu
[    3.963439] vdd_debugfs_init: Unable to create debugfs directory for
vdd_core
[    3.971496] Power Management for TI OMAP3.
[    3.976135] omap_init_power_states: core off state C7 disabled due to
i583
[    3.992218] regulator_init_complete: VDVI: incomplete constraints,
leaving on
[    4.000122] regulator_init_complete: VDAC: incomplete constraints,
leaving on
[    4.009460] twl_rtc twl_rtc: setting system clock to 2000-01-01
00:45:24 UTC)
[    4.041259] usb 1-2: New USB device found, idVendor=0424, idProduct=9514
[    4.048370] usb 1-2: New USB device strings: Mfr=0, Product=0,
SerialNumber=0
[    4.061370] hub 1-2:1.0: USB hub found
[    4.066131] hub 1-2:1.0: 5 ports detected
[    4.290374] mmc0: host does not support reading read-only switch.
assuming w.
[    4.301788] mmc0: new high speed SDHC card at address 1234
[    4.310424] mmcblk0: mmc0:1234 SA04G 3.67 GiB
[    4.321441]  mmcblk0: p1 p2 p3
[    4.359619] usb 1-2.1: new high speed USB device number 3 using ehci-omap
[    4.485046] usb 1-2.1: New USB device found, idVendor=0424,
idProduct=ec00
[    4.492309] usb 1-2.1: New USB device strings: Mfr=0, Product=0,
SerialNumbe0
[    4.505432] smsc95xx v1.0.4
[    4.596130] smsc95xx 1-2.1:1.0: eth0: register 'smsc95xx' at
usb-ehci-omap.0d
[   16.620605] Root-NFS: no NFS server address
[   16.625122] VFS: Unable to mount root fs via NFS, trying floppy.
[   16.632354] List of all partitions:
[   16.636230] b300         3858432 mmcblk0  driver: mmcblk
[   16.641876]   b301         1020096 mmcblk0p1
00000000-0000-0000-0000-00000001
[   16.650634]   b302         1028160 mmcblk0p2
00000000-0000-0000-0000-00000002
[   16.659515]   b303         1807312 mmcblk0p3
00000000-0000-0000-0000-00000003
[   16.668243] No filesystem could mount root, tried:  nfs
[   16.673767] Kernel panic - not syncing: VFS: Unable to mount root fs
on unkn)


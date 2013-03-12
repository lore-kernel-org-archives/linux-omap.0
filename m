From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH 4/9] ARM: dts: OMAP3: Add support for OMAP3430 SDP board
Date: Tue, 12 Mar 2013 16:27:04 -0500
Message-ID: <513F9DA8.4090200@ti.com>
References: <1362763654-9660-1-git-send-email-jon-hunter@ti.com> <1362763654-9660-5-git-send-email-jon-hunter@ti.com> <CABYxbz7Bg3Uf2wkhH=4d6nEPUjyHF8BiixN6rGCOgEVG_us8Jw@mail.gmail.com> <513E1A1C.8070206@ti.com> <F3DBB1B3EF102E4994C89758CFCA32412CE371@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:52646 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932723Ab3CLV1P (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 Mar 2013 17:27:15 -0400
In-Reply-To: <F3DBB1B3EF102E4994C89758CFCA32412CE371@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Kumar, Anil" <anilkumar.v@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, device-tree <devicetree-discuss@lists.ozlabs.org>, linux-omap <linux-omap@vger.kernel.org>, "Cousson, Benoit" <b-cousson@ti.com>, linux-arm <linux-arm-kernel@lists.infradead.org>, Anil Kumar <anilk4.v@gmail.com>


On 03/11/2013 09:42 PM, Kumar, Anil wrote:
>=20
> On Mon, Mar 11, 2013 at 23:23:32, Hunter, Jon wrote:
>>
>> On 03/08/2013 08:25 PM, Anil Kumar wrote:
>>> Hi Jon,
>>>
>>> On Fri, Mar 8, 2013 at 10:57 PM, Jon Hunter <jon-hunter@ti.com> wro=
te:
>>>> Adds basic device-tree support for OMAP3430 SDP board which has 25=
6MB
>>>> of RAM and uses the TWL4030 power management IC.
>>>
>>> I think this board support should be in separate patch series with
>>> related patches.
>>
>> Well I wanted to keep them altogether so that I can send a pull requ=
est
>> to Benoit and Tony.
>=20
> Sorry, but can you please tell what makes you to think that you
> can send pull request only when they are altogether ?

That's not the point.
=20
> Is there any logical dependency with other patches except=20
> "[PATCH 6/9] ARM: dts: Add OMAP3430 SDP flash memory bindings" is on=20
> top of this patch ?

Per the $subject of the series these a various DT patches I have pendin=
g.
Yes I could break this series up into many separate series, one for PMU=
,
one for DMA, one for GPMC, one for OMAP3 SDP, but I thought it would be
easier for Tony and Benoit to pull as a single series.

If Tony or Benoit wish for me to separate these out, I will.=20
=20
>>
>>>>
>>>> Signed-off-by: Jon Hunter <jon-hunter@ti.com>
>>>> ---
>>>>  arch/arm/boot/dts/Makefile         |    1 +
>>>>  arch/arm/boot/dts/omap3430-sdp.dts |   46 +++++++++++++++++++++++=
+++++++++++++
>>>>  2 files changed, 47 insertions(+)
>>>>  create mode 100644 arch/arm/boot/dts/omap3430-sdp.dts
>>>>
>>>> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefi=
le
>>>> index 9c62558..89013ed 100644
>>>> --- a/arch/arm/boot/dts/Makefile
>>>> +++ b/arch/arm/boot/dts/Makefile
>>>> @@ -119,6 +119,7 @@ dtb-$(CONFIG_ARCH_OMAP2PLUS) +=3D omap2420-h4.=
dtb \
>>>>         omap3-beagle-xm.dtb \
>>>>         omap3-evm.dtb \
>>>>         omap3-tobi.dtb \
>>>> +       omap3430-sdp.dtb \
>>>>         omap4-panda.dtb \
>>>>         omap4-panda-a4.dtb \
>>>>         omap4-panda-es.dtb \
>>>> diff --git a/arch/arm/boot/dts/omap3430-sdp.dts b/arch/arm/boot/dt=
s/omap3430-sdp.dts
>>>> new file mode 100644
>>>> index 0000000..be0650d
>>>> --- /dev/null
>>>> +++ b/arch/arm/boot/dts/omap3430-sdp.dts
>>>> @@ -0,0 +1,46 @@
>>>> +/*
>>>> + * Copyright (C) 2013 Texas Instruments Incorporated - http://www=
=2Eti.com/
>>>> + *
>>>> + * This program is free software; you can redistribute it and/or =
modify
>>>> + * it under the terms of the GNU General Public License version 2=
 as
>>>> + * published by the Free Software Foundation.
>>>> + */
>>>> +/dts-v1/;
>>>> +
>>>> +/include/ "omap3.dtsi"
>>>> +
>>>> +/ {
>>>> +       model =3D "TI OMAP3430 SDP";
>>>> +       compatible =3D "ti,omap3430-sdp", "ti,omap3";
>>>
>>> I have not seen any related changes in "board-generic.c" for your b=
oard.
>>> So just wanted know, how this board is booting ?
>>
>> If you look at board-generic.c you will see that "ti,omap3" will mat=
ch
>> the OMAP3 generic machine. So you don't need to modify the board-gen=
eric.c.
>=20
> According to this omap3-beagle.dts and omap3-beagle-xm.dts are also=20
> booting in some way. So it is not clear to me, why there two
> "DT_MACHINE_START" for omap3. I have seen there is only one=20
> different in "init_time" for the same.=20

OMAP3 beagle uses the machine descriptor OMAP3_GP_DT where as OMAP3=20
beagle-xm (and OMAP3 SDP) use the machine descriptor OMAP3_DT. The
real difference in these machine descriptors is the init_time
function pointer.
=20
>>
>>>> +
>>>> +       memory {
>>>> +               device_type =3D "memory";
>>>> +               reg =3D <0x80000000 0x10000000>; /* 256 MB */
>>>> +       };
>>>> +};
>>>> +
>>>> +&i2c1 {
>>>> +       clock-frequency =3D <2600000>;
>>>> +
>>>> +       twl: twl@48 {
>>>> +               reg =3D <0x48>;
>>>> +               interrupts =3D <7>; /* SYS_NIRQ cascaded to intc *=
/
>>>> +               interrupt-parent =3D <&intc>;
>>>> +       };
>>>> +};
>>>> +
>>>> +/include/ "twl4030.dtsi"
>>>> +
>>>> +&mmc1 {
>>>> +       vmmc-supply =3D <&vmmc1>;
>>>> +       vmmc_aux-supply =3D <&vsim>;
>>>> +       bus-width =3D <8>;
>>>> +};
>>>> +
>>>> +&mmc2 {
>>>> +       status =3D "disabled";
>>>> +};
>>>> +
>>>> +&mmc3 {
>>>> +       status =3D "disabled";
>>>> +};
>>>
>>> I think you should disable modules those are not currently used
>>> as they are enabled by default in omap3.dtsi.
>>>
>>> exp:-
>>>
>>> &mcbsp2 {
>>>         status =3D "disabled";
>>> };
>>
>> Well may be we could do that in a follow-up patch. If you look at ot=
her
>> omap3 boards we have not gone through and disabled all unused module=
s
>> either. So although I agree, right now I just want to get minimal
>> support added.
>>
>=20
> Hmm... But it makes the kernel to call unused driver probe and get fa=
iled
> those required some platform date from DT? you can see the kernel boo=
t logs.

Here is the console output I see on the omap3 sdp. There are a few warn=
ings
around pin-mux settings but nothing major AFAICT ...

[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 3.9.0-rc2-39794-g1c71698 (jenkins@cfasvr1)=
 (gcc version 4.6.1 (Sourcery CodeBench Lite 2011.09-70) ) #4 SMP Tue M=
ar 12 15:59:47 CDT 2013
[    0.000000] CPU: ARMv7 Processor [411fc083] revision 3 (ARMv7), cr=3D=
10c53c7d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT nonaliasin=
g instruction cache
[    0.000000] Machine: Generic OMAP3 (Flattened Device Tree), model: T=
I OMAP3430 SDP
[    0.000000] cma: CMA: reserved 16 MiB at 8e800000
[    0.000000] Memory policy: ECC disabled, Data cache writeback
[    0.000000] CPU: All CPU(s) started in SVC mode.
[    0.000000] OMAP3430/3530 ES3.1 (l2cache iva sgx neon isp )
[    0.000000] Clocking rate (Crystal/Core/MPU): 26.0/332/600 MHz
[    0.000000] PERCPU: Embedded 9 pages/cpu @c14dc000 s13632 r8192 d150=
40 u36864
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  =
Total pages: 64768
[    0.000000] Kernel command line: console=3DttyO0,115200n8 ip=3Ddhcp =
earlyprintk
[    0.000000] PID hash table entries: 1024 (order: 0, 4096 bytes)
[    0.000000] Dentry cache hash table entries: 32768 (order: 5, 131072=
 bytes)
[    0.000000] Inode-cache hash table entries: 16384 (order: 4, 65536 b=
ytes)
[    0.000000] __ex_table already sorted, skipping sort
[    0.000000] Memory: 255MB =3D 255MB total
[    0.000000] Memory: 223080k/223080k available, 39064k reserved, 0K h=
ighmem
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
[    0.000000]     vmalloc : 0xd0800000 - 0xff000000   ( 744 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xd0000000   ( 256 MB)
[    0.000000]     pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
[    0.000000]     modules : 0xbf000000 - 0xbfe00000   (  14 MB)
[    0.000000]       .text : 0xc0008000 - 0xc075f8dc   (7519 kB)
[    0.000000]       .init : 0xc0760000 - 0xc0cda540   (5610 kB)
[    0.000000]       .data : 0xc0cdc000 - 0xc0d75820   ( 615 kB)
[    0.000000]        .bss : 0xc0d75820 - 0xc12d0a88   (5485 kB)
[    0.000000] Hierarchical RCU implementation.
[    0.000000] 	RCU restricting CPUs from NR_CPUS=3D2 to nr_cpu_ids=3D1=
=2E
[    0.000000] NR_IRQS:16 nr_irqs:16 16
[    0.000000] IRQ: Found an INTC at 0xfa200000 (revision 4.0) with 96 =
interrupts
[    0.000000] Total of 96 interrupts on 1 active controller
[    0.000000] OMAP clockevent source: timer1 at 32768 Hz
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
[    0.000000]  memory used by lock dependency info: 3695 kB
[    0.000000]  per task-struct memory footprint: 1152 bytes
[    0.001159] Calibrating delay loop... 395.67 BogoMIPS (lpj=3D1978368=
)
[    0.109649] pid_max: default: 32768 minimum: 301
[    0.110290] Security Framework initialized
[    0.110473] Mount-cache hash table entries: 512
[    0.126861] CPU: Testing write buffer coherency: ok
[    0.128692] CPU0: thread -1, cpu 0, socket -1, mpidr 0
[    0.128814] Setting up static identity map for 0xc055bc70 - 0xc055bc=
e0
[    0.132598] Brought up 1 CPUs
[    0.132629] SMP: Total of 1 processors activated (395.67 BogoMIPS).
[    0.132659] CPU: All CPU(s) started in SVC mode.
[    0.136352] devtmpfs: initialized
[    0.196838] pinctrl core: initialized pinctrl subsystem
[    0.204345] regulator-dummy: no parameters
[    0.208740] NET: Registered protocol family 16
[    0.219116] DMA: preallocated 256 KiB pool for atomic coherent alloc=
ations
[    0.239593] Reprogramming SDRC clock to 332000000 Hz
[    0.254455] OMAP GPIO hardware version 2.5
[    0.288085] platform 49022000.mcbsp: alias fck already exists
[    0.289916] platform 49024000.mcbsp: alias fck already exists
[    0.307922] omap-gpmc 6e000000.gpmc: GPMC revision 5.0
[    0.312744] No ATAGs?
[    0.312774] hw-breakpoint: debug architecture 0x4 unsupported.
[    0.318359] OMAP DMA hardware revision 4.0
[    0.320190] Serial: AMBA PL011 UART driver
[    0.401214] bio: create slab <bio-0> at 0
[    0.506225] omap-dma-engine 48056000.dma-controller: OMAP DMA engine=
 driver
[    0.517608] SCSI subsystem initialized
[    0.520904] usbcore: registered new interface driver usbfs
[    0.521545] usbcore: registered new interface driver hub
[    0.522277] usbcore: registered new device driver usb
[    0.525085] omap_i2c i2c.8: did not get pins for i2c error: -19
[    0.527038] omap_i2c i2c.8: bus 0 rev3.3 at 2600 kHz
[    0.542297] twl 0-0048: PIH (irq 23) chaining IRQs 338..346
[    0.542999] twl 0-0048: power (irq 343) chaining IRQs 346..353
[    0.550140] VDAC: 1800 mV=20
[    0.554077] VPLL2: 1800 mV=20
[    0.557281] VMMC1: 1850 <--> 3150 mV at 3150 mV=20
[    0.560607] VUSB1V5: 1500 mV=20
[    0.563232] VUSB1V8: 1800 mV=20
[    0.565734] VUSB3V1: 3100 mV=20
[    0.568542] VSIM: 1800 <--> 3000 mV at 1800 mV=20
[    0.572418] twl4030_gpio gpio.26: gpio (irq 338) chaining IRQs 354..=
371
[    0.575836] omap_i2c i2c.9: did not get pins for i2c error: -19
[    0.577331] omap_i2c i2c.9: bus 1 rev3.3 at 100 kHz
[    0.577636] omap_i2c i2c.10: did not get pins for i2c error: -19
[    0.579223] omap_i2c i2c.10: bus 2 rev3.3 at 100 kHz
[    0.589477] Switching to clocksource 32k_counter
[    0.758361] NET: Registered protocol family 2
[    0.761047] TCP established hash table entries: 2048 (order: 2, 1638=
4 bytes)
[    0.761322] TCP bind hash table entries: 2048 (order: 4, 73728 bytes=
)
[    0.762481] TCP: Hash tables configured (established 2048 bind 2048)
[    0.762786] TCP: reno registered
[    0.762817] UDP hash table entries: 256 (order: 2, 20480 bytes)
[    0.763153] UDP-Lite hash table entries: 256 (order: 2, 20480 bytes)
[    0.764404] NET: Registered protocol family 1
[    0.766204] RPC: Registered named UNIX socket transport module.
[    0.766235] RPC: Registered udp transport module.
[    0.766265] RPC: Registered tcp transport module.
[    0.766265] RPC: Registered tcp NFSv4.1 backchannel transport module=
=2E
[    0.886260] NetWinder Floating Point Emulator V0.97 (double precisio=
n)
[    0.886749] hw perfevents: enabled with ARMv7 Cortex-A8 PMU driver, =
5 counters available
[    1.083740] VFS: Disk quotas dquot_6.5.2
[    1.084136] Dquot-cache hash table entries: 1024 (order 0, 4096 byte=
s)
[    1.087951] NFS: Registering the id_resolver key type
[    1.088592] Key type id_resolver registered
[    1.088623] Key type id_legacy registered
[    1.088806] jffs2: version 2.2. (NAND) (SUMMARY)  =EF=BF=BD=EF=BF=BD=
 2001-2006 Red Hat, Inc.
[    1.089538] msgmni has been set to 467
[    1.095092] io scheduler noop registered
[    1.095123] io scheduler deadline registered
[    1.095214] io scheduler cfq registered (default)
[    1.098144] pinctrl-single 48002030.pinmux: 742 pins at pa fa002030 =
size 1484
[    1.099090] pinctrl-single 48002a58.pinmux: 46 pins at pa fa002a58 s=
ize 92
[    1.105224] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    1.114746] omap_uart serial.5: did not get pins for uart0 error: -1=
9
[    1.115478] serial.5: ttyO0 at MMIO 0x4806a000 (irq =3D 88) is a OMA=
P UART0
[    1.825805] console [ttyO0] enabled
[    1.832183] omap_uart serial.6: did not get pins for uart1 error: -1=
9
[    1.839385] serial.6: ttyO1 at MMIO 0x4806c000 (irq =3D 89) is a OMA=
P UART1
[    1.848999] omap_uart serial.7: did not get pins for uart2 error: -1=
9
[    1.856353] serial.7: ttyO2 at MMIO 0x49020000 (irq =3D 90) is a OMA=
P UART2
[    1.907745] brd: module loaded
[    1.936614] loop: module loaded
[    1.946990] mtdoops: mtd device (mtddev=3Dname/number) must be suppl=
ied
[    1.965362] intel,pf48f6000m0y1be: Found 1 x16 devices at 0x0 in 16-=
bit bank. Manufacturer ID 0x000089 Chip ID 0x0088b1
[    1.976928] Intel/Sharp Extended Query Table at 0x010A
[    1.982482] Intel/Sharp Extended Query Table at 0x010A
[    1.987915] Intel/Sharp Extended Query Table at 0x010A
[    1.993469] Intel/Sharp Extended Query Table at 0x010A
[    1.998901] Intel/Sharp Extended Query Table at 0x010A
[    2.004425] Using buffer write method
[    2.008300] Using auto-unlock on power-up/resume
[    2.013214] cfi_cmdset_0001: Erase suspend on write enabled
[    2.026824] 4 ofpart partitions found on MTD device intel,pf48f6000m=
0y1be
[    2.034118] Creating 4 MTD partitions on "intel,pf48f6000m0y1be":
[    2.041046] 0x000000000000-0x000000040000 : "bootloader-nor"
[    2.055450] 0x000000040000-0x000000080000 : "params-nor"
[    2.066467] 0x000000080000-0x000000280000 : "kernel-nor"
[    2.077606] 0x000000240000-0x000007fc0000 : "filesystem-nor"
[    2.100585] No NAND device found
[    2.104187] Trying ONFI probe in 16 bits mode, aborting !
[    2.109893] No NAND device found
[    2.114166] OneNAND driver initializing
[    2.118804] omap2-onenand omap2-onenand: initializing on CS2, phys b=
ase 0x20000000, virtual base d0880000, freq 0 MHz
[    2.130218] Muxed OneNAND 256MB 1.8V 16-bit (0x40)
[    2.135253] OneNAND version =3D 0x002c
[    2.140991] Scanning device for bad blocks
[    2.157745] OneNAND eraseblock 205 is an initial bad block
[    2.174102] OneNAND eraseblock 390 is an initial bad block
[    2.185363] OneNAND eraseblock 486 is an initial bad block
[    2.194702] OneNAND eraseblock 547 is an initial bad block
[    2.206329] OneNAND eraseblock 651 is an initial bad block
[    2.213439] OneNAND eraseblock 674 is an initial bad block
[    2.259613] OneNAND eraseblock 1398 is an initial bad block
[    2.301971] 5 ofpart partitions found on MTD device omap2-onenand
[    2.308380] Creating 5 MTD partitions on "omap2-onenand":
[    2.314147] 0x000000000000-0x000000080000 : "xloader-onenand"
[    2.325622] 0x000000080000-0x0000000c0000 : "bootloader-onenand"
[    2.337219] 0x0000000c0000-0x0000000e0000 : "params-onenand"
[    2.348480] 0x0000000e0000-0x0000002e0000 : "kernel-onenand"
[    2.360382] 0x0000002e0000-0x000010000000 : "filesystem-onenand"
[    2.384552] omap2_mcspi spi.11: pins are not configured from the dri=
ver
[    2.394165] omap2_mcspi spi.12: pins are not configured from the dri=
ver
[    2.403106] omap2_mcspi spi.13: pins are not configured from the dri=
ver
[    2.411834] omap2_mcspi spi.14: pins are not configured from the dri=
ver
[    2.428222] usbcore: registered new interface driver asix
[    2.434753] usbcore: registered new interface driver ax88179_178a
[    2.442382] usbcore: registered new interface driver cdc_ether
[    2.449188] usbcore: registered new interface driver smsc95xx
[    2.456024] usbcore: registered new interface driver net1080
[    2.462707] usbcore: registered new interface driver cdc_subset
[    2.469512] usbcore: registered new interface driver zaurus
[    2.476379] usbcore: registered new interface driver cdc_ncm
[    2.485351] usbcore: registered new interface driver cdc_wdm
[    2.491485] Initializing USB Mass Storage driver...
[    2.497375] usbcore: registered new interface driver usb-storage
[    2.503814] USB Mass Storage support registered.
[    2.509368] usbcore: registered new interface driver usbtest
[    2.518371] mousedev: PS/2 mouse device common for all mice
[    2.532562] twl_rtc rtc.17: Power up reset detected.
[    2.538726] twl_rtc rtc.17: Enabling TWL-RTC
[    2.548553] twl_rtc rtc.17: rtc core: registered rtc.17 as rtc0
[    2.557189] i2c /dev entries driver
[    2.566284] Driver for 1-wire Dallas network protocol.
[    2.577667] omap_wdt: OMAP Watchdog Timer Rev 0x31: initial timeout =
60 sec
[    2.592773] omap-dma-engine 48056000.dma-controller: allocating chan=
nel for 62
[    2.600738] omap-dma-engine 48056000.dma-controller: allocating chan=
nel for 61
[    2.612396] omap_hsmmc mmc.15: pins are not configured from the driv=
er
[    2.667449] ledtrig-cpu: registered to indicate activity on CPUs
[    2.676300] usbcore: registered new interface driver usbhid
[    2.682281] usbhid: USB HID core driver
[    2.690795] oprofile: using arm/armv7
[    2.695739] TCP: cubic registered
[    2.699249] Initializing XFRM netlink socket
[    2.704162] NET: Registered protocol family 17
[    2.708984] NET: Registered protocol family 15
[    2.714263] Key type dns_resolver registered
[    2.718872] VFP support v0.3: implementor 41 architecture 3 part 30 =
variant c rev 1
[    2.727172] ThumbEE CPU extension supported.
[    2.738586] VUSB3V1: disabling
[    2.742706] VUSB1V8: disabling
[    2.746582] VUSB1V5: disabling
[    2.750793] VPLL2: disabling
[    2.754699] VDAC: disabling
[    2.764526] mmc0: SD Status: Invalid Allocation Unit size.
[    2.772277] twl_rtc rtc.17: setting system clock to 2000-01-01 00:00=
:00 UTC (946684800)
[    2.782043] mmc0: host does not support reading read-only switch. as=
suming write-enable.
[    2.793182] mmc0: new high speed SD card at address b368
[    2.802612] mmcblk0: mmc0:b368 SD1GB 952 MiB=20
[    2.814208]  mmcblk0: p1 p2
[   14.917297] Freeing init memory: 5608K
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

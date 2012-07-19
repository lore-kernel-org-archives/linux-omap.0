From: Yegor Yefremov <yegor_sub1@visionsystems.de>
Subject: Re: am3517: geting MMC working
Date: Thu, 19 Jul 2012 10:15:17 +0200
Message-ID: <5007C215.7020904@visionsystems.de>
References: <5007A838.3040309@visionsystems.de> <CAMQu2gyGH2r1vqEx5DCiv8xr=Lp+p1_5nvrtQe9RdpnfecSoag@mail.gmail.com> <5007AF7C.1010902@visionsystems.de> <CAMQu2gx83tx66kQtF9v_v6yaw-L6v8QMc9u3bokX68ZhzC0tiA@mail.gmail.com> <5007B721.9070305@visionsystems.de> <CANfBPZ8tfApLcL2WGsP6jgwv7zafywJp7oHQ6E=xBYN8KYyeww@mail.gmail.com>
Reply-To: yegor_sub1@visionsystems.de
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from hhlx01.vscom.de ([62.145.30.242]:39203 "EHLO
	mail.visionsystems.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752417Ab2GSIPd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Jul 2012 04:15:33 -0400
In-Reply-To: <CANfBPZ8tfApLcL2WGsP6jgwv7zafywJp7oHQ6E=xBYN8KYyeww@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "S, Venkatraman" <svenkatr@ti.com>
Cc: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Mark A. Greer" <mgreer@animalcreek.com>, "Porter, Matt" <mporter@ti.com>, Balaji T Krishnamoorthy <balajitk@ti.com>

Am 19.07.2012 09:43, schrieb S, Venkatraman:
> On Thu, Jul 19, 2012 at 12:58 PM, Yegor Yefremov
> <yegor_sub1@visionsystems.de> wrote:
>> Am 19.07.2012 09:07, schrieb Shilimkar, Santosh:
>>> On Thu, Jul 19, 2012 at 12:25 PM, Yegor Yefremov
>>> <yegor_sub1@visionsystems.de> wrote:
>>>> Am 19.07.2012 08:34, schrieb Shilimkar, Santosh:
>>>>> On Thu, Jul 19, 2012 at 11:54 AM, Yegor Yefremov
>>>>> <yegor_sub1@visionsystems.de> wrote:
>>>>>> What patches do I need to get MMC working with linux-omap master=
?
>>>>>>
>>>>>> omap_hsmmc omap_hsmmc.0: Failed to get debounce clk
>>>>>> omap-dma-engine omap-dma-engine: allocating channel for 62
>>>>>> omap-dma-engine omap-dma-engine: allocating channel for 61
>>>>>> omap_hsmmc omap_hsmmc.1: Failed to get debounce clk
>>>>>> omap-dma-engine omap-dma-engine: allocating channel for 48
>>>>>> omap-dma-engine omap-dma-engine: allocating channel for 47
>>>>>>
>>>>>> I searched for this issue and saw some patches for common clock =
framework
>>>>>> that were scheduled for 3.6, but I'm not sure it's enough or wea=
ther they
>>>>>> are already incorporated in linux-omap.
>>>>>>
>>>>> I guess you need [1] to get around the issue.
>>>>>
>>>>> [1] http://www.spinics.net/lists/linux-omap/msg73965.html
>>>> though I haven't applied this patch I have DMA activated (CONFIG_D=
MADEVICES and CONFIG_DMA_OMAP). Found in some other thread [1]. As far =
as I can tell, debounce clk is the problem.
>>>>
>>> Sorry. I miss-read the message.
>> The whole log for reference:
>>
>> Booting Linux on physical CPU 0
>> Linux version 3.5.0-rc6-12227-g60701f4-dirty () (gcc version 4.5.3 (=
Buildroot 2012.05-rc2-00009-gfbd5a1d-dirty) ) #90 Thu Jul 19 09:23:31 C=
EST 2012
>> CPU: ARMv7 Processor [411fc087] revision 7 (ARMv7), cr=3D10c53c7d
>> CPU: PIPT / VIPT nonaliasing data cache, VIPT nonaliasing instructio=
n cache
>> Machine: OMAP3517/AM3517 EVM
>> Ignoring tag cmdline (using the default kernel command line)
>> bootconsole [earlycon0] enabled
>> Memory policy: ECC disabled, Data cache writeback
>> AM3517 ES1.1 (l2cache sgx neon )
>> Clocking rate (Crystal/Core/MPU): 26.0/332/500 MHz
>> Built 1 zonelists in Zone order, mobility grouping on.  Total pages:=
 64768
>> Kernel command line: root=3D/dev/mmcblk0p2 rootwait console=3DttyO2,=
115200 earlyprintk=3Dserial,ttyO2,115200
>> PID hash table entries: 1024 (order: 0, 4096 bytes)
>> Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
>> Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
>> Memory: 255MB =3D 255MB total
>> Memory: 247380k/247380k available, 14764k reserved, 0K highmem
>> Virtual kernel memory layout:
>>     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
>>     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
>>     vmalloc : 0xd0800000 - 0xff000000   ( 744 MB)
>>     lowmem  : 0xc0000000 - 0xd0000000   ( 256 MB)
>>     pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
>>       .text : 0xc0008000 - 0xc055e6a8   (5466 kB)
>>       .init : 0xc055f000 - 0xc0594874   ( 215 kB)
>>       .data : 0xc0596000 - 0xc05fccc0   ( 412 kB)
>>        .bss : 0xc05fcce4 - 0xc0b2a1e8   (5302 kB)
>> NR_IRQS:474
>> IRQ: Found an INTC at 0xfa200000 (revision 4.0) with 96 interrupts
>> Total of 96 interrupts on 1 active controller
>> OMAP clockevent source: GPTIMER1 at 32768 Hz
>> sched_clock: 32 bits at 32kHz, resolution 30517ns, wraps every 13107=
1999ms
>> OMAP clocksource: 32k_counter at 32768 Hz
>> Console: colour dummy device 80x30
>> Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Mo=
lnar
>> ... MAX_LOCKDEP_SUBCLASSES:  8
>> ... MAX_LOCK_DEPTH:          48
>> ... MAX_LOCKDEP_KEYS:        8191
>> ... CLASSHASH_SIZE:          4096
>> ... MAX_LOCKDEP_ENTRIES:     16384
>> ... MAX_LOCKDEP_CHAINS:      32768
>> ... CHAINHASH_SIZE:          16384
>>  memory used by lock dependency info: 3695 kB
>>  per task-struct memory footprint: 1152 bytes
>> Calibrating delay loop... 331.40 BogoMIPS (lpj=3D1296384)
>> pid_max: default: 32768 minimum: 301
>> Security Framework initialized
>> Mount-cache hash table entries: 512
>> CPU: Testing write buffer coherency: ok
>> Setting up static identity map for 0x80444ff0 - 0x80445048
>> devtmpfs: initialized
>> dummy:
>> NET: Registered protocol family 16
>> GPMC revision 5.0
>> gpmc: irq-20 could not claim: err -22
>> OMAP GPIO hardware version 2.5
>> omap_mux_init: Add partition: #1: core, flags: 0
>> _omap_mux_get_by_name: Could not find signal uart4_rx.uart4_rx
>> Reprogramming SDRC clock to 332000000 Hz
>> dpll3_m2_clk rate change failed: -22
>> hw-breakpoint: debug architecture 0x4 unsupported.
>> OMAP DMA hardware revision 4.0
>> bio: create slab <bio-0> at 0
>> omap-dma-engine omap-dma-engine: OMAP DMA engine driver
>> SCSI subsystem initialized
>> omap_i2c omap_i2c.1: bus 1 rev1.3.12 at 400 kHz
>> omap_i2c omap_i2c.2: bus 2 rev1.3.12 at 400 kHz
>> omap_i2c omap_i2c.3: bus 3 rev1.3.12 at 400 kHz
>> Bluetooth: Core ver 2.16
>> NET: Registered protocol family 31
>> Bluetooth: HCI device and connection manager initialized
>> Bluetooth: HCI socket layer initialized
>> Bluetooth: L2CAP socket layer initialized
>> Bluetooth: SCO socket layer initialized
>> cfg80211: Calling CRDA to update world regulatory domain
>> Switching to clocksource 32k_counter
>> NET: Registered protocol family 2
>> IP route cache hash table entries: 2048 (order: 1, 8192 bytes)
>> TCP established hash table entries: 8192 (order: 4, 65536 bytes)
>> TCP bind hash table entries: 8192 (order: 6, 294912 bytes)
>> TCP: Hash tables configured (established 8192 bind 8192)
>> TCP: reno registered
>> UDP hash table entries: 256 (order: 2, 20480 bytes)
>> UDP-Lite hash table entries: 256 (order: 2, 20480 bytes)
>> NET: Registered protocol family 1
>> RPC: Registered named UNIX socket transport module.
>> RPC: Registered udp transport module.
>> RPC: Registered tcp transport module.
>> RPC: Registered tcp NFSv4.1 backchannel transport module.
>> NetWinder Floating Point Emulator V0.97 (double precision)
>> VFS: Disk quotas dquot_6.5.2
>> Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
>> NFS: Registering the id_resolver key type
>> Key type id_resolver registered
>> jffs2: version 2.2. (NAND) (SUMMARY)  =A9 2001-2006 Red Hat, Inc.
>> msgmni has been set to 483
>> io scheduler noop registered
>> io scheduler deadline registered
>> io scheduler cfq registered (default)
>> Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
>> omap_uart.0: ttyO0 at MMIO 0x4806a000 (irq =3D 72) is a OMAP UART0
>> omap_uart.1: ttyO1 at MMIO 0x4806c000 (irq =3D 73) is a OMAP UART1
>> omap_uart.2: ttyO2 at MMIO 0x49020000 (irq =3D 74) is a OMAP UART2
>> console [ttyO2] enabled, bootconsole disabled
>> console [ttyO2] enabled, bootconsole disabled
>> omap_uart.3: ttyO3 at MMIO 0x4809e000 (irq =3D 84) is a OMAP UART3
>> brd: module loaded
>> loop: module loaded
>> mtdoops: mtd device (mtddev=3Dname/number) must be supplied
>> OneNAND driver initializing
>> davinci_mdio davinci_mdio.0: davinci mdio revision 1.5
>> davinci_mdio davinci_mdio.0: detected phy mask fffffffd
>> davinci_mdio.0: probed
>> davinci_mdio davinci_mdio.0: phy[1]: device davinci_mdio-0:01, drive=
r unknown
>> mousedev: PS/2 mouse device common for all mice
>> i2c /dev entries driver
>> omap_wdt: OMAP Watchdog Timer Rev 0x31: initial timeout 60 sec
>> Bluetooth: HCI UART driver ver 2.2
>> Bluetooth: HCI H4 protocol initialized
>> Bluetooth: HCI BCSP protocol initialized
>> Bluetooth: HCILL protocol initialized
>> omap_hsmmc omap_hsmmc.0: Failed to get debounce clk
>> omap-dma-engine omap-dma-engine: allocating channel for 62
>> omap-dma-engine omap-dma-engine: allocating channel for 61
>> omap_hsmmc omap_hsmmc.1: Failed to get debounce clk
>> omap-dma-engine omap-dma-engine: allocating channel for 48
>> omap-dma-engine omap-dma-engine: allocating channel for 47
>> oprofile: hardware counters not available
>> oprofile: using timer interrupt.
>> TCP: cubic registered
>> Initializing XFRM netlink socket
>> NET: Registered protocol family 17
>> NET: Registered protocol family 15
>> lib80211: common routines for IEEE802.11 drivers
>> Key type dns_resolver registered
>> VFP support v0.3: implementor 41 architecture 3 part 30 variant c re=
v 1
>> voltdm_scale: No voltage scale API registered for vdd_mpu_iva
>> voltdm_scale: No voltage scale API registered for vdd_core
>> PM: no software I/O chain control; some wakeups may be lost
>> ThumbEE CPU extension supported.
>> clock: disabling unused clocks to save power
>> davinci_emac davinci_emac.0: using random MAC addr: 9a:df:69:5d:52:e=
e
>> Waiting for root device /dev/mmcblk0p2...
>> mmc0: host does not support reading read-only switch. assuming write=
-enable.
>> --
> Debouce clocks failures are non fatal, and are present in OMAP2xxx on=
ly.
> (I don't know about AM35xx, but most likely its not present).

You're right:
http://old.nabble.com/-PATCH-V2--omap_hsmmc:-Fix-for-the-db-clock-failu=
re-message-td25047778.html

> The last 2 lines shows that mmc0 is enumerated, but the boot partitio=
n is not.
> If possible, can you please provide logs with MMC_DEBUG enabled at co=
mpile time
> and a verbose loglevel (loglevel=3D8) ?

Bluetooth: HCI UART driver ver 2.2
Bluetooth: HCI H4 protocol initialized
Bluetooth: HCI BCSP protocol initialized
Bluetooth: HCILL protocol initialized
omap_hsmmc omap_hsmmc.0: context was not lost
omap_hsmmc omap_hsmmc.0: enabled
omap_hsmmc omap_hsmmc.0: Failed to get debounce clk
omap-dma-engine omap-dma-engine: allocating channel for 62
omap-dma-engine omap-dma-engine: allocating channel for 61
mmc0: clock 0Hz busmode 2 powermode 1 cs 0 Vdd 19 width 0 timing 0
omap_hsmmc omap_hsmmc.0: Set clock to 0Hz
mmc0: clock 400000Hz busmode 2 powermode 2 cs 0 Vdd 19 width 0 timing 0
omap_hsmmc omap_hsmmc.0: Set clock to 400000Hz
omap_hsmmc omap_hsmmc.0: disabled
omap_hsmmc omap_hsmmc.1: context was not lost
omap_hsmmc omap_hsmmc.1: enabled
omap_hsmmc omap_hsmmc.1: Failed to get debounce clk
omap-dma-engine omap-dma-engine: allocating channel for 48
omap-dma-engine omap-dma-engine: allocating channel for 47
omap_hsmmc omap_hsmmc.0: context was not lost
omap_hsmmc omap_hsmmc.0: enabled
mmc0: mmc_rescan_try_freq: trying to init card at 400000 Hz
mmc0: starting CMD52 arg 00000c00 flags 00000195
omap_hsmmc omap_hsmmc.0: mmc0: CMD52, argument 0x00000c00
omap_hsmmc omap_hsmmc.0: IRQ Status is 18000
omap_hsmmc omap_hsmmc.0: MMC IRQ 0x18000 : ERRI CTO
mmc0: req done (CMD52): -110: 00000000 00000000 00000000 00000000
mmc1: clock 0Hz busmode 2 powermode 1 cs 0 Vdd 19 width 0 timing 0
omap_hsmmc omap_hsmmc.1: Set clock to 0Hz
mmc0: starting CMD52 arg 80000c08 flags 00000195
omap_hsmmc omap_hsmmc.0: mmc0: CMD52, argument 0x80000c08
omap_hsmmc omap_hsmmc.0: IRQ Status is 18000
omap_hsmmc omap_hsmmc.0: MMC IRQ 0x18000 : ERRI CTO
mmc0: req done (CMD52): -110: 00000000 00000000 00000000 00000000
mmc1: clock 400000Hz busmode 2 powermode 2 cs 0 Vdd 19 width 0 timing 0
omap_hsmmc omap_hsmmc.1: Set clock to 400000Hz
mmc0: clock 400000Hz busmode 2 powermode 2 cs 1 Vdd 19 width 0 timing 0
omap_hsmmc omap_hsmmc.0: Set clock to 400000Hz
mmc0: starting CMD0 arg 00000000 flags 000000c0
omap_hsmmc omap_hsmmc.0: mmc0: CMD0, argument 0x00000000
omap_hsmmc omap_hsmmc.0: IRQ Status is 1
mmc0: req done (CMD0): 0: 00000000 00000000 00000000 00000000
omap_hsmmc omap_hsmmc.1: disabled
mmc0: clock 400000Hz busmode 2 powermode 2 cs 0 Vdd 19 width 0 timing 0
omap_hsmmc omap_hsmmc.0: Set clock to 400000Hz
oprofile: hardware counters not available
oprofile: using timer interrupt.
TCP: cubic registered
Initializing XFRM netlink socket
NET: Registered protocol family 17
NET: Registered protocol family 15
lib80211: common routines for IEEE802.11 drivers
lib80211_crypt: registered algorithm 'NULL'
Key type dns_resolver registered
VFP support v0.3: implementor 41 architecture 3 part 30 variant c rev 1
voltdm_scale: No voltage scale API registered for vdd_mpu_iva
voltdm_scale: No voltage scale API registered for vdd_core
PM: no software I/O chain control; some wakeups may be lost
ThumbEE CPU extension supported.
clock: disabling unused clocks to save power
mmc0: starting CMD8 arg 000001aa flags 000002f5
omap_hsmmc omap_hsmmc.0: mmc0: CMD8, argument 0x000001aa
omap_hsmmc omap_hsmmc.0: IRQ Status is 1
mmc0: req done (CMD8): 0: 000001aa 00000000 00000000 00000000
mmc0: starting CMD5 arg 00000000 flags 000002e1
omap_hsmmc omap_hsmmc.0: mmc0: CMD5, argument 0x00000000
omap_hsmmc omap_hsmmc.0: IRQ Status is 18000
omap_hsmmc omap_hsmmc.0: MMC IRQ 0x18000 : ERRI CTO
mmc0: req failed (CMD5): -110, retrying...
omap_hsmmc omap_hsmmc.0: mmc0: CMD5, argument 0x00000000
omap_hsmmc omap_hsmmc.0: IRQ Status is 18000
omap_hsmmc omap_hsmmc.0: MMC IRQ 0x18000 : ERRI CTO
mmc0: req failed (CMD5): -110, retrying...
omap_hsmmc omap_hsmmc.0: mmc0: CMD5, argument 0x00000000
omap_hsmmc omap_hsmmc.0: IRQ Status is 18000
omap_hsmmc omap_hsmmc.0: MMC IRQ 0x18000 : ERRI CTO
davinci_emac davinci_emac.0: using random MAC addr: 0a:e0:2b:8a:d1:27
mmc0: req failed (CMD5): -110, retrying...
omap_hsmmc omap_hsmmc.0: mmc0: CMD5, argument 0x00000000
omap_hsmmc omap_hsmmc.0: IRQ Status is 18000
omap_hsmmc omap_hsmmc.0: MMC IRQ 0x18000 : ERRI CTO
mmc0: req done (CMD5): -110: 00000000 00000000 00000000 00000000
mmc0: starting CMD55 arg 00000000 flags 000000f5
omap_hsmmc omap_hsmmc.0: mmc0: CMD55, argument 0x00000000
omap_hsmmc omap_hsmmc.0: IRQ Status is 1
mmc0: req done (CMD55): 0: 00400120 00000000 00000000 00000000
mmc0: starting CMD41 arg 00000000 flags 000000e1
omap_hsmmc omap_hsmmc.0: mmc0: CMD41, argument 0x00000000
omap_hsmmc omap_hsmmc.0: IRQ Status is 1
mmc0: req done (CMD41): 0: 00ff8000 00000000 00000000 00000000
mmc0: clock 400000Hz busmode 2 powermode 2 cs 0 Vdd 15 width 0 timing 0
omap_hsmmc omap_hsmmc.0: Set clock to 400000Hz
mmc0: clock 400000Hz busmode 2 powermode 2 cs 1 Vdd 15 width 0 timing 0
omap_hsmmc omap_hsmmc.0: Set clock to 400000Hz
Waiting for root device /dev/mmcblk0p2...
mmc0: starting CMD0 arg 00000000 flags 000000c0
omap_hsmmc omap_hsmmc.0: mmc0: CMD0, argument 0x00000000

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

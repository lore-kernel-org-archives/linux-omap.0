From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: Booting hangs with updated linux-omap kernel on OMAP3EVM
Date: Mon, 29 Aug 2011 16:59:04 +0530
Message-ID: <CAAL8m4znh8KVbSiP4mpN73TcUdRBobo3N0h-Rg7aROcg56FArA@mail.gmail.com>
References: <ADF30F4D7BDE934D9B632CE7D5C7ACA4047C4D090808@dbde03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:57735 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752615Ab1H2L30 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Aug 2011 07:29:26 -0400
Received: by bke11 with SMTP id 11so4069433bke.19
        for <linux-omap@vger.kernel.org>; Mon, 29 Aug 2011 04:29:25 -0700 (PDT)
In-Reply-To: <ADF30F4D7BDE934D9B632CE7D5C7ACA4047C4D090808@dbde03.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Ravi, Deepthy" <deepthy.ravi@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Mon, Aug 29, 2011 at 4:18 PM, Ravi, Deepthy <deepthy.ravi@ti.com> wr=
ote:
> Hi,
> I tried booting OMAP3EVM with the updated linux-omap kernel .
> The last commit details on the kernel are :
> Author: Tony Lindgren <tony@atomide.com>
> commit b148d763841161894ed6629794064065a834aa2b
> Linux-omap rebuilt: Updated to use omap_sdrc_init
>

probably missing below commit from mainline,

http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3D=
commit;h=3D69dd3d8e29e294caaf63eb5e8a72d250279f9e5f

Try,

git revert f3637a5f2e2eb391ff5757bc83fb5de8f9726464

--
Thanks,
Govindraj.R


> It hangs at one point.
>
> Following is the boot log,
>
> Texas Instruments X-Loader 1.51 (May =C2=A03 2011 - 19:22:23)
> Starting X-loader on MMC
> Reading boot sector
>
> 220008 Bytes Read from MMC
> Starting OS Bootloader from MMC...
> Starting OS Bootloader...
>
>
> U-Boot 2010.06 (May 03 2011 - 19:23:34)
>
> OMAP3430/3530-GP ES3.1, CPU-OPP2 L3-165MHz
> OMAP3 EVM board + LPDDR/NAND
> I2C: =C2=A0 ready
> DRAM: =C2=A0128 MiB
> NAND: =C2=A0HW ECC [Kernel/FS layout] selected
> 256 MiB
> In: =C2=A0 =C2=A0serial
> Out: =C2=A0 serial
> Err: =C2=A0 serial
> Read back SMSC id 0x92200000
> Die ID #46a400040000000004032d460d01d014
> Net: =C2=A0 smc911x-0
> Hit any key to stop autoboot: =C2=A00
> OMAP3_EVM #
> OMAP3_EVM #
> OMAP3_EVM # run myboot
> smc911x: detected LAN9220 controller
> smc911x: phy initialized
> smc911x: MAC 00:50:c2:7e:93:73
> Using smc911x-0 device
> TFTP from server 192.168.1.79; our IP address is 192.168.1.123
> Filename 'uImage'.
> Load address: 0x80000000
> Loading: ############################################################=
#####
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 #########################################=
########################
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 #########################################=
########################
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 #########################################=
########################
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 #########################################=
########################
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 #########################################=
########################
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 #########################################=
########################
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 #########################################=
########################
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 #########################################=
########################
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 #########################################=
#################
> done
> Bytes transferred =3D 3287400 (322968 hex)
> mmc1 is available
> reading ramdisk.gz
>
> 2013059 bytes read
> ## Booting kernel from Legacy Image at 80000000 ...
> =C2=A0 Image Name: =C2=A0 Linux-3.1.0-rc3-11176-g2e5a5f9-d
> =C2=A0 Image Type: =C2=A0 ARM Linux Kernel Image (uncompressed)
> =C2=A0 Data Size: =C2=A0 =C2=A03287336 Bytes =3D 3.1 MiB
> =C2=A0 Load Address: 80008000
> =C2=A0 Entry Point: =C2=A080008000
> =C2=A0 Verifying Checksum ... OK
> =C2=A0 Loading Kernel Image ... OK
> OK
>
> Starting kernel ...
>
> Uncompressing Linux... done, booting the kernel.
> [ =C2=A0 =C2=A00.000000] Linux version 3.1.0-rc3-11176-g2e5a5f9-dirty=
 (x0157478@psplinux060) (gcc version 4.3.3 (GCC) ) #4 SMP Mon Aug 29 15=
:37:16 IST 2011
> [ =C2=A0 =C2=A00.000000] CPU: ARMv7 Processor [411fc083] revision 3 (=
ARMv7), cr=3D10c53c7f
> [ =C2=A0 =C2=A00.000000] CPU: VIPT nonaliasing data cache, VIPT nonal=
iasing instruction cache
> [ =C2=A0 =C2=A00.000000] Machine: OMAP3 EVM
> [ =C2=A0 =C2=A00.000000] Memory policy: ECC disabled, Data cache writ=
eback
> [ =C2=A0 =C2=A00.000000] OMAP3430/3530 ES3.1 (l2cache iva sgx neon is=
p )
> [ =C2=A0 =C2=A00.000000] SRAM: Mapped pa 0x40200000 to va 0xfe400000 =
size: 0x10000
> [ =C2=A0 =C2=A00.000000] Clocking rate (Crystal/Core/MPU): 26.0/332/5=
00 MHz
> [ =C2=A0 =C2=A00.000000] PERCPU: Embedded 8 pages/cpu @c0cef000 s1011=
2 r8192 d14464 u32768
> [ =C2=A0 =C2=A00.000000] Built 1 zonelists in Zone order, mobility gr=
ouping on. =C2=A0Total pages: 32512
> [ =C2=A0 =C2=A00.000000] Kernel command line: mem=3D128M console=3Dtt=
yO0,115200n8 root=3D/dev/ram0 initrd=3D0x82000000,40M ramdisk_size=3D32=
768 ip=3Ddhcp
> [ =C2=A0 =C2=A00.000000] PID hash table entries: 512 (order: -1, 2048=
 bytes)
> [ =C2=A0 =C2=A00.000000] Dentry cache hash table entries: 16384 (orde=
r: 4, 65536 bytes)
> [ =C2=A0 =C2=A00.000000] Inode-cache hash table entries: 8192 (order:=
 3, 32768 bytes)
> [ =C2=A0 =C2=A00.000000] Memory: 128MB =3D 128MB total
> [ =C2=A0 =C2=A00.000000] Memory: 76736k/76736k available, 54336k rese=
rved, 0K highmem
> [ =C2=A0 =C2=A00.000000] Virtual kernel memory layout:
> [ =C2=A0 =C2=A00.000000] =C2=A0 =C2=A0 vector =C2=A0: 0xffff0000 - 0x=
ffff1000 =C2=A0 ( =C2=A0 4 kB)
> [ =C2=A0 =C2=A00.000000] =C2=A0 =C2=A0 fixmap =C2=A0: 0xfff00000 - 0x=
fffe0000 =C2=A0 ( 896 kB)
> [ =C2=A0 =C2=A00.000000] =C2=A0 =C2=A0 DMA =C2=A0 =C2=A0 : 0xffc00000=
 - 0xffe00000 =C2=A0 ( =C2=A0 2 MB)
> [ =C2=A0 =C2=A00.000000] =C2=A0 =C2=A0 vmalloc : 0xc8800000 - 0xf8000=
000 =C2=A0 ( 760 MB)
> [ =C2=A0 =C2=A00.000000] =C2=A0 =C2=A0 lowmem =C2=A0: 0xc0000000 - 0x=
c8000000 =C2=A0 ( 128 MB)
> [ =C2=A0 =C2=A00.000000] =C2=A0 =C2=A0 modules : 0xbf000000 - 0xc0000=
000 =C2=A0 ( =C2=A016 MB)
> [ =C2=A0 =C2=A00.000000] =C2=A0 =C2=A0 =C2=A0 .text : 0xc0008000 - 0x=
c05c0d30 =C2=A0 (5860 kB)
> [ =C2=A0 =C2=A00.000000] =C2=A0 =C2=A0 =C2=A0 .init : 0xc05c1000 - 0x=
c060e780 =C2=A0 ( 310 kB)
> [ =C2=A0 =C2=A00.000000] =C2=A0 =C2=A0 =C2=A0 .data : 0xc0610000 - 0x=
c0695490 =C2=A0 ( 534 kB)
> [ =C2=A0 =C2=A00.000000] =C2=A0 =C2=A0 =C2=A0 =C2=A0.bss : 0xc06954b4=
 - 0xc0bea4f4 =C2=A0 (5461 kB)
> [ =C2=A0 =C2=A00.000000] Hierarchical RCU implementation.
> [ =C2=A0 =C2=A00.000000] NR_IRQS:410
> [ =C2=A0 =C2=A00.000000] IRQ: Found an INTC at 0xfa200000 (revision 4=
=2E0) with 96 interrupts
> [ =C2=A0 =C2=A00.000000] Total of 96 interrupts on 1 active controlle=
r
> [ =C2=A0 =C2=A00.000000] OMAP clockevent source: GPTIMER1 at 32768 Hz
> [ =C2=A0 =C2=A00.000000] sched_clock: 32 bits at 32kHz, resolution 30=
517ns, wraps every 131071999ms
> [ =C2=A0 =C2=A00.000000] Console: colour dummy device 80x30
> [ =C2=A0 =C2=A00.000000] Lock dependency validator: Copyright (c) 200=
6 Red Hat, Inc., Ingo Molnar
> [ =C2=A0 =C2=A00.000000] ... MAX_LOCKDEP_SUBCLASSES: =C2=A08
> [ =C2=A0 =C2=A00.000000] ... MAX_LOCK_DEPTH: =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A048
> [ =C2=A0 =C2=A00.000000] ... MAX_LOCKDEP_KEYS: =C2=A0 =C2=A0 =C2=A0 =C2=
=A08191
> [ =C2=A0 =C2=A00.000000] ... CLASSHASH_SIZE: =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A04096
> [ =C2=A0 =C2=A00.000000] ... MAX_LOCKDEP_ENTRIES: =C2=A0 =C2=A0 16384
> [ =C2=A0 =C2=A00.000000] ... MAX_LOCKDEP_CHAINS: =C2=A0 =C2=A0 =C2=A0=
32768
> [ =C2=A0 =C2=A00.000000] ... CHAINHASH_SIZE: =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A016384
> [ =C2=A0 =C2=A00.000000] =C2=A0memory used by lock dependency info: 3=
695 kB
> [ =C2=A0 =C2=A00.000000] =C2=A0per task-struct memory footprint: 1152=
 bytes
> [ =C2=A0 =C2=A00.001159] Calibrating delay loop... 497.82 BogoMIPS (l=
pj=3D1941504)
> [ =C2=A0 =C2=A00.093749] pid_max: default: 32768 minimum: 301
> [ =C2=A0 =C2=A00.094696] Security Framework initialized
> [ =C2=A0 =C2=A00.095092] Mount-cache hash table entries: 512
> [ =C2=A0 =C2=A00.100982] CPU: Testing write buffer coherency: ok
> [ =C2=A0 =C2=A00.104583] Brought up 1 CPUs
> [ =C2=A0 =C2=A00.104583] SMP: Total of 1 processors activated (497.82=
 BogoMIPS).
> [ =C2=A0 =C2=A00.119812] omap_hwmod: gpt12_fck: missing clockdomain f=
or gpt12_fck.
> [ =C2=A0 =C2=A00.122406] omap_hwmod: am35x_otg_hs: cannot be enabled =
(3)
> [ =C2=A0 =C2=A00.126739] print_constraints: dummy:
> [ =C2=A0 =C2=A00.128570] NET: Registered protocol family 16
> [ =C2=A0 =C2=A00.129302] GPMC revision 5.0
> [ =C2=A0 =C2=A00.133789] omap_device: omap_gpio.0: new worst case act=
ivate latency 0: 61035
> [ =C2=A0 =C2=A00.135772] OMAP GPIO hardware version 2.5
> [ =C2=A0 =C2=A00.144104] omap_mux_init: Add partition: #1: core, flag=
s: 0
> [ =C2=A0 =C2=A00.151336] omap_device: omap_uart.0: new worst case act=
ivate latency 0: 30517
> [ =C2=A0 =C2=A00.151824] omap_device: omap_uart.0: new worst case dea=
ctivate latency 0: 30517
> [ =C2=A0 =C2=A00.154479] Reprogramming SDRC clock to 332000000 Hz
> [ =C2=A0 =C2=A00.261108] hw-breakpoint: debug architecture 0x4 unsupp=
orted.
> [ =C2=A0 =C2=A00.275268] omap_device: omap-mcbsp.2: alias fck already=
 exists
> [ =C2=A0 =C2=A00.276336] omap_device: omap-mcbsp.3: alias fck already=
 exists
> [ =C2=A0 =C2=A00.283660] OMAP DMA hardware revision 4.0
> [ =C2=A0 =C2=A00.369995] bio: create slab <bio-0> at 0
> [ =C2=A0 =C2=A00.381835] SCSI subsystem initialized
> [ =C2=A0 =C2=A00.382568] omap_device: omap2_mcspi.1: new worst case a=
ctivate latency 0: 30517
> [ =C2=A0 =C2=A00.386871] omap_device: omap2_mcspi.1: new worst case d=
eactivate latency 0: 30517
> [ =C2=A0 =C2=A00.395294] usbcore: registered new interface driver usb=
fs
> [ =C2=A0 =C2=A00.396789] usbcore: registered new interface driver hub
> [ =C2=A0 =C2=A00.397979] usbcore: registered new device driver usb
> [ =C2=A0 =C2=A00.401397] omap_device: omap_i2c.1: new worst case acti=
vate latency 0: 61035
> [ =C2=A0 =C2=A00.414520] omap_i2c omap_i2c.1: bus 1 rev3.12 at 2600 k=
Hz
> [ =C2=A0 =C2=A00.427642] twl4030: PIH (irq 7) chaining IRQs 368..375
> [ =C2=A0 =C2=A00.427917] twl4030: power (irq 373) chaining IRQs 376..=
383
> [ =C2=A0 =C2=A00.430664] twl4030: gpio (irq 368) chaining IRQs 384..4=
01
> [ =C2=A0 =C2=A00.432861] _omap_mux_init_gpio: Could not set gpio192
> [ =C2=A0 =C2=A00.447387] print_constraints: VIO: 1800 mV normal stand=
by
> [ =C2=A0 =C2=A00.450561] print_constraints: VMMC1: 1850 <--> 3150 mV =
at 3000 mV normal standby
> [ =C2=A0 =C2=A00.453948] print_constraints: VDAC: 1800 mV normal stan=
dby
> [ =C2=A0 =C2=A00.456970] print_constraints: VPLL2: 1800 mV normal sta=
ndby
> [ =C2=A0 =C2=A00.459869] print_constraints: VSIM: 1800 <--> 3000 mV a=
t 1800 mV normal standby
> [ =C2=A0 =C2=A00.460601] omap_device: omap_i2c.1: new worst case deac=
tivate latency 0: 30517
> [ =C2=A0 =C2=A00.469146] omap_i2c omap_i2c.2: bus 2 rev3.12 at 400 kH=
z
> [ =C2=A0 =C2=A00.484619] omap_i2c omap_i2c.3: bus 3 rev3.12 at 400 kH=
z
> [ =C2=A0 =C2=A00.496002] Switching to clocksource 32k_counter
> [ =C2=A0 =C2=A00.500366] Switched to NOHz mode on CPU #0
> [ =C2=A0 =C2=A00.648468] NET: Registered protocol family 2
> [ =C2=A0 =C2=A00.649505] IP route cache hash table entries: 1024 (ord=
er: 0, 4096 bytes)
> [ =C2=A0 =C2=A00.651916] TCP established hash table entries: 4096 (or=
der: 3, 32768 bytes)
> [ =C2=A0 =C2=A00.652313] TCP bind hash table entries: 4096 (order: 5,=
 147456 bytes)
> [ =C2=A0 =C2=A00.655578] TCP: Hash tables configured (established 409=
6 bind 4096)
> [ =C2=A0 =C2=A00.655731] TCP reno registered
> [ =C2=A0 =C2=A00.655792] UDP hash table entries: 64 (order: 0, 5120 b=
ytes)
> [ =C2=A0 =C2=A00.656188] UDP-Lite hash table entries: 64 (order: 0, 5=
120 bytes)
> [ =C2=A0 =C2=A00.657409] NET: Registered protocol family 1
> [ =C2=A0 =C2=A00.659240] RPC: Registered named UNIX socket transport =
module.
> [ =C2=A0 =C2=A00.659271] RPC: Registered udp transport module.
> [ =C2=A0 =C2=A00.659301] RPC: Registered tcp transport module.
> [ =C2=A0 =C2=A00.659301] RPC: Registered tcp NFSv4.1 backchannel tran=
sport module.
> [ =C2=A0 =C2=A00.660522] Trying to unpack rootfs image as initramfs..=
=2E
> [ =C2=A0 =C2=A00.663604] rootfs image is not initramfs (no cpio magic=
); looks like an initrd
> [ =C2=A0 =C2=A01.100158] Freeing initrd memory: 40960K
> [ =C2=A0 =C2=A01.100189] NetWinder Floating Point Emulator V0.97 (dou=
ble precision)
> [ =C2=A0 =C2=A01.293945] VFS: Disk quotas dquot_6.5.2
> [ =C2=A0 =C2=A01.294403] Dquot-cache hash table entries: 1024 (order =
0, 4096 bytes)
> [ =C2=A0 =C2=A01.298278] JFFS2 version 2.2. (NAND) (SUMMARY) =C2=A0=EF=
=BF=BD=C2=A9 2001-2006 Red Hat, Inc.
> [ =C2=A0 =C2=A01.299865] msgmni has been set to 229
> [ =C2=A0 =C2=A01.305603] io scheduler noop registered
> [ =C2=A0 =C2=A01.305633] io scheduler deadline registered
> [ =C2=A0 =C2=A01.305938] io scheduler cfq registered (default)
> [ =C2=A0 =C2=A01.311401] Serial: 8250/16550 driver, 4 ports, IRQ shar=
ing enabled
> [ =C2=A0 =C2=A01.321380] omap_uart.0: ttyO0 at MMIO 0x4806a000 (irq =3D=
 72) is a OMAP UART0
> [ =C2=A0 =C2=A02.004119] console [ttyO0] enabled
> [ =C2=A0 =C2=A02.009979] omap_uart.1: ttyO1 at MMIO 0x4806c000 (irq =3D=
 73) is a OMAP UART1
> [ =C2=A0 =C2=A02.019348] omap_uart.2: ttyO2 at MMIO 0x49020000 (irq =3D=
 74) is a OMAP UART2
> [ =C2=A0 =C2=A02.073333] brd: module loaded
> [ =C2=A0 =C2=A02.104248] loop: module loaded
> [ =C2=A0 =C2=A02.117248] mtdoops: mtd device (mtddev=3Dname/number) m=
ust be supplied
> [ =C2=A0 =C2=A02.124542] omap2-nand driver initializing
> [ =C2=A0 =C2=A02.130157] OneNAND driver initializing
> [ =C2=A0 =C2=A02.143341] smsc911x: Driver version 2008-10-21
> [ =C2=A0 =C2=A02.157897] smsc911x-mdio: probed
> [ =C2=A0 =C2=A02.162200] smsc911x smsc911x.0: eth0: attached PHY driv=
er [SMSC LAN8700] (mii_bus:phy_addr=3D0:01, irq=3D-1)
> [ =C2=A0 =C2=A02.172760] smsc911x smsc911x.0: eth0: MAC Address: 00:5=
0:c2:7e:93:73
> [ =C2=A0 =C2=A02.181335] usbcore: registered new interface driver asi=
x
> [ =C2=A0 =C2=A02.188140] usbcore: registered new interface driver cdc=
_ether
> [ =C2=A0 =C2=A02.195220] usbcore: registered new interface driver net=
1080
> [ =C2=A0 =C2=A02.202087] usbcore: registered new interface driver cdc=
_subset
> [ =C2=A0 =C2=A02.209228] usbcore: registered new interface driver zau=
rus
> [ =C2=A0 =C2=A02.215179] cdc_ncm: 04-Aug-2011
> [ =C2=A0 =C2=A02.219482] usbcore: registered new interface driver cdc=
_ncm
> [ =C2=A0 =C2=A02.228881] usbcore: registered new interface driver cdc=
_wdm
> [ =C2=A0 =C2=A02.235046] Initializing USB Mass Storage driver...
> [ =C2=A0 =C2=A02.241119] usbcore: registered new interface driver usb=
-storage
> [ =C2=A0 =C2=A02.247680] USB Mass Storage support registered.
> [ =C2=A0 =C2=A02.254272] usbcore: registered new interface driver lib=
usual
> [ =C2=A0 =C2=A02.261352] usbcore: registered new interface driver usb=
test
> [ =C2=A0 =C2=A02.269836] mousedev: PS/2 mouse device common for all m=
ice
> [ =C2=A0 =C2=A02.279449] input: TWL4030 Keypad as /devices/platform/o=
map/omap_i2c.1/i2c-1/1-004a/twl4030_keypad/input/input0
> [ =C2=A0 =C2=A02.292724] omap_device: omap_i2c.1: new worst case acti=
vate latency 0: 122070
> [ =C2=A0 =C2=A02.309844] ads7846 spi1.0: touchscreen, irq 335
> [ =C2=A0 =C2=A02.316070] omap_device: omap2_mcspi.1: new worst case a=
ctivate latency 0: 61035
> [ =C2=A0 =C2=A02.326538] input: ADS7846 Touchscreen as /devices/platf=
orm/omap/omap2_mcspi.1/spi1.0/input/input1
> [ =C2=A0 =C2=A02.344512] input: twl4030_pwrbutton as /devices/platfor=
m/omap/omap_i2c.1/i2c-1/1-0049/twl4030_pwrbutton/input/input2
> [ =C2=A0 =C2=A02.362396] twl_rtc twl_rtc: rtc core: registered twl_rt=
c as rtc0
> [ =C2=A0 =C2=A02.369415] twl_rtc twl_rtc: Power up reset detected.
> [ =C2=A0 =C2=A02.375915] twl_rtc twl_rtc: Enabling TWL-RTC.
> [ =C2=A0 =C2=A02.382354] i2c /dev entries driver
> [ =C2=A0 =C2=A02.392242] Driver for 1-wire Dallas network protocol.
> [ =C2=A0 =C2=A02.400451] omap_device: omap_wdt.-1: new worst case act=
ivate latency 0: 30517
> [ =C2=A0 =C2=A02.410400] OMAP Watchdog Timer Rev 0x31: initial timeou=
t 60 sec
> [ =C2=A0 =C2=A02.417083] omap_device: omap_wdt.-1: new worst case dea=
ctivate latency 0: 30517
> [ =C2=A0 =C2=A02.426544] twl4030_wdt twl4030_wdt: Failed to register =
misc device
> [ =C2=A0 =C2=A02.433471] twl4030_wdt: probe of twl4030_wdt failed wit=
h error -16
> [ =C2=A0 =C2=A02.446990] omap_device: omap_hsmmc.0: new worst case ac=
tivate latency 0: 213623
> [ =C2=A0 =C2=A02.460815] omap_device: omap_hsmmc.0: new worst case de=
activate latency 0: 30517
> [ =C2=A0 =C2=A02.474273] omap_device: omap_hsmmc.0: new worst case ac=
tivate latency 0: 274658
> [ =C2=A0 =C2=A02.483215] usbcore: registered new interface driver usb=
hid
> [ =C2=A0 =C2=A02.489227] usbhid: USB HID core driver
> [ =C2=A0 =C2=A02.493286] oprofile: hardware counters not available
> [ =C2=A0 =C2=A02.498687] oprofile: using timer interrupt.
> [ =C2=A0 =C2=A02.503967] TCP cubic registered
> [ =C2=A0 =C2=A02.507507] Initializing XFRM netlink socket
> [ =C2=A0 =C2=A02.512207] NET: Registered protocol family 17
> [ =C2=A0 =C2=A02.517120] NET: Registered protocol family 15
> [ =C2=A0 =C2=A02.522277] Registering the dns_resolver key type
> [ =C2=A0 =C2=A02.528106] VFP support v0.3: implementor 41 architectur=
e 3 part 30 variant c rev 1
> [ =C2=A0 =C2=A02.536346] ThumbEE CPU extension supported.
> [ =C2=A0 =C2=A02.602478] clock: disabling unused clocks to save power
> [ =C2=A0 =C2=A02.617614] twl_rtc twl_rtc: setting system clock to 200=
0-01-01 00:00:00 UTC (946684800)
> [ =C2=A0 =C2=A02.629364] smsc911x smsc911x.0: eth0: SMSC911x/921x ide=
ntified at 0xc8878000, IRQ: 336
> [ =C2=A0 =C2=A02.660919] Sending DHCP requests .
> [ =C2=A0 =C2=A03.008392] mmc0: new high speed SD card at address b368
> [ =C2=A0 =C2=A03.018829] mmcblk0: mmc0:b368 SDC =C2=A0 958 MiB
> [ =C2=A0 =C2=A03.034332] =C2=A0mmcblk0: p1 p2
> [ =C2=A0 =C2=A03.138000] omap_device: omap_hsmmc.0: new worst case de=
activate latency 0: 91552
> [ =C2=A0 =C2=A05.645111] ., OK
> [ =C2=A0 =C2=A06.387817] IP-Config: Got DHCP answer from 0.0.0.0, my =
address is 192.168.1.57
> [ =C2=A0 =C2=A06.396301] IP-Config: Complete:
> [ =C2=A0 =C2=A06.399719] =C2=A0 =C2=A0 =C2=A0device=3Deth0, addr=3D19=
2.168.1.57, mask=3D255.255.255.0, gw=3D192.168.1.1,
> [ =C2=A0 =C2=A06.407775] =C2=A0 =C2=A0 =C2=A0host=3D192.168.1.57, dom=
ain=3Dpathpartner.com, nis-domain=3D(none),
> [ =C2=A0 =C2=A06.415496] =C2=A0 =C2=A0 =C2=A0bootserver=3D0.0.0.0, ro=
otserver=3D0.0.0.0, rootpath=3D
> [ =C2=A0 =C2=A06.426513] RAMDISK: gzip image found at block 0
> [ =C2=A0 =C2=A07.078247] VFS: Mounted root (ext2 filesystem) on devic=
e 1:0.
> [ =C2=A0 =C2=A07.085693] Freeing init memory: 308K
>
> It hangs after this. Did anyone face this issue?
>
>
> Thanks,
> Deepthy Ravi.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

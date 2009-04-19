From: "Eugeny S. Mints" <eugeny.mints@gmail.com>
Subject: Re: 2.6.30-rc1 and BeagleBoard: MMC card / Voltage Regulator issues
Date: Mon, 20 Apr 2009 01:37:39 +0400
Message-ID: <49EB99A3.4080705@gmail.com>
References: <200904151439.43195.tc@tomwinkler.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from postoffice.embeddedalley.com ([65.114.89.228]:36604 "HELO
	postoffice.embeddedalley.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750944AbZDSVoU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sun, 19 Apr 2009 17:44:20 -0400
In-Reply-To: <200904151439.43195.tc@tomwinkler.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tc@tomwinkler.net
Cc: linux-omap@vger.kernel.org

Hi Thomas,

in case it could help:

1) I'm getting the same kernel crash on the latest linux-omap tree

2) you may want to pull omap-2.6.29 if you're looking for somewhat=20
stable  - checkout
"Git tree updated, clocks and PM code reset to mainline" thread on this=
=20
list. omap-2.6.29
with default beagleboard config boots fine for me and mounts rootfs on =
SD.

Thanks,
Eugeny

Thomas Winkler wrote:
> Hello,
>
> I today pulled linux-omap 2.6.30-rc1 and compiled it to be used on my=
=20
> BeagleBoard. When booting the system I get the trace attached below. =
If I=20
> remove the voltage regulator settings fomr my kernel config, the kern=
el panic=20
> goes away but the system is unable to finde and mount the SD card whe=
re my=20
> root filesystem is located on. I'm not sure what to do about this and=
 would=20
> appreciate any hints.
>
> Thanks,
> Thomas
>
> Uncompressing=20
> Linux................................................................=
=2E...............................................=20
> done, booting the kernel.
> Linux version 2.6.30-rc1-omap1-05619-g1232332 (tom@cameranw) (gcc ver=
sion=20
> 4.3.2 (crosstool-NG-1.3.2) ) #2 Wed Apr 15 13:36:41 CEST 2009
> CPU: ARMv7 Processor [411fc083] revision 3 (ARMv7), cr=3D10c5387f
> CPU: VIPT nonaliasing data cache, VIPT nonaliasing instruction cache
> Machine: OMAP3 Beagle Board
> Memory policy: ECC disabled, Data cache writeback
> OMAP3430 ES3.0
> SRAM: Mapped pa 0x40200000 to va 0xd7000000 size: 0x100000
> Built 1 zonelists in Zone order, mobility grouping on.  Total pages: =
65024
> Kernel command line: console=3DttyS2,115200n8 console=3Dtty0 root=3D/=
dev/mmcblk0p2=20
> rootdelay=3D2 rootfstype=3Dext3 node_id=3Dpsc06
> NR_IRQS:402
> Clocking rate (Crystal/DPLL/ARM core): 26.0/332/500 MHz
> GPMC revision 5.0
> IRQ: Found an INTC at 0xd8200000 (revision 4.0) with 96 interrupts
> Total of 96 interrupts on 1 active controller
> OMAP34xx GPIO hardware version 2.5
> PID hash table entries: 1024 (order: 10, 4096 bytes)
> OMAP clockevent source: GPTIMER12 at 32768 Hz
> Console: colour dummy device 80x30
> console [tty0] enabled
> Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
> Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
> Memory: 128MB 128MB =3D 256MB total
> Memory: 256128KB available (3076K code, 280K data, 120K init, 0K high=
mem)
> Calibrating delay loop... 485.26 BogoMIPS (lpj=3D1896448)
> Mount-cache hash table entries: 512
> CPU: Testing write buffer coherency: ok
> net_namespace: 520 bytes
> regulator: core version 0.5
> NET: Registered protocol family 16
> Found NAND on CS0
> Registering NAND on CS0
> OMAP DMA hardware revision 4.0
> bio: create slab <bio-0> at 0
> i2c_omap i2c_omap.1: bus 1 rev3.12 at 2600 kHz
> twl4030: PIH (irq 7) chaining IRQs 368..375
> twl4030: power (irq 373) chaining IRQs 376..383
> twl4030_gpio: use which platform_data?
> twl4030: gpio (irq 368) chaining IRQs 384..401
> mmci-omap-hs.0: use which platform_data?
> twl4030_usb: use which platform_data?
> twl4030_reg.6: use which platform_data?
> regulator: VMMC1: 1850 <--> 3150 mV normal standby
> twl4030_reg.3: use which platform_data?
> regulator: VDAC: 1800 mV normal standby
> twl4030_reg.17: use which platform_data?
> set_machine_constraints: invalid 'VUSB1V5' voltage constraints
> twl4030_reg twl4030_reg.17: can't register VUSB1V5, -22
> twl4030_reg: probe of twl4030_reg.17 failed with error -22
> twl4030_reg.18: use which platform_data?
> set_machine_constraints: invalid 'VUSB1V8' voltage constraints
> twl4030_reg twl4030_reg.18: can't register VUSB1V8, -22
> twl4030_reg: probe of twl4030_reg.18 failed with error -22
> twl4030_reg.19: use which platform_data?
> set_machine_constraints: invalid 'VUSB3V1' voltage constraints
> twl4030_reg twl4030_reg.19: can't register VUSB3V1, -22
> twl4030_reg: probe of twl4030_reg.19 failed with error -22
> twl4030_reg.5: use which platform_data?
> regulator: VPLL2: 1800 mV normal standby
> twl4030_reg.8: use which platform_data?
> regulator: VSIM: 1800 <--> 3000 mV normal standby
> i2c_omap i2c_omap.3: bus 3 rev3.12 at 100 kHz
> SCSI subsystem initialized
> twl4030_usb twl4030_usb: ldo init failed
> usbcore: registered new interface driver usbfs
> usbcore: registered new interface driver hub
> usbcore: registered new device driver usb
> musb_hdrc: version 6.0, musb-dma, otg (peripheral+host), debug=3D0
> musb_core_init 1406: reconfigure software for static FIFOs
> musb_hdrc musb_hdrc: musb_init_controller failed with status -19
> NET: Registered protocol family 2
> IP route cache hash table entries: 2048 (order: 1, 8192 bytes)
> TCP established hash table entries: 8192 (order: 4, 65536 bytes)
> TCP bind hash table entries: 8192 (order: 3, 32768 bytes)
> TCP: Hash tables configured (established 8192 bind 8192)
> TCP reno registered
> NET: Registered protocol family 1
> NetWinder Floating Point Emulator V0.97 (double precision)
> VFS: Disk quotas dquot_6.5.2
> Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
> JFFS2 version 2.2. (NAND) =EF=BF=BD=C2=A9 2001-2006 Red Hat, Inc.
> msgmni has been set to 500
> alg: No test for stdrng (krng)
> io scheduler noop registered
> io scheduler anticipatory registered (default)
> io scheduler deadline registered
> io scheduler cfq registered
> Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
> serial8250.0: ttyS0 at MMIO 0x4806a000 (irq =3D 72) is a ST16654
> serial8250.0: ttyS1 at MMIO 0x4806c000 (irq =3D 73) is a ST16654
> serial8250.0: ttyS2 at MMIO 0x49020000 (irq =3D 74) is a ST16654
> console [ttyS2] enabled
> brd: module loaded
> loop: module loaded
> i2c /dev entries driver
> Driver 'sd' needs updating - please use bus_type methods
> omap2-nand driver initializing
> NAND device: Manufacturer ID: 0x2c, Chip ID: 0xba (Micron NAND 256MiB=
 1,8V=20
> 16-bit)
> cmdlinepart partition parsing not available
> Creating 5 MTD partitions on "omap2-nand":
> 0x000000000000-0x000000080000 : "X-Loader"
> 0x000000080000-0x000000260000 : "U-Boot"
> 0x000000260000-0x000000280000 : "U-Boot Env"
> 0x000000280000-0x000000680000 : "Kernel"
> 0x000000680000-0x000010000000 : "File System"
> usbmon: debugfs is not available
> twl4030_rtc twl4030_rtc: rtc core: registered twl4030_rtc as rtc0
> twl4030_rtc twl4030_rtc: Power up reset detected.
> twl4030_rtc twl4030_rtc: Enabling TWL4030-RTC.
> mmci-omap-hs mmci-omap-hs.0: Failed to get debounce clock
> Unable to handle kernel paging request at virtual address 70616d6f
> pgd =3D c0004000
> [70616d6f] *pgd=3D00000000
> Internal error: Oops: 5 [#1]
> Modules linked in:
> CPU: 0    Not tainted  (2.6.30-rc1-omap1-05619-g1232332 #2)
> PC is at regulator_get+0x90/0x29c
> LR is at regulator_get+0x50/0x29c
> pc : [<c0177cbc>]    lr : [<c0177c7c>]    psr: 20000013
> sp : cf81fe58  ip : 00000000  fp : cf842200
> r10: c02dee56  r9 : 00000053  r8 : c036f1cc
> r7 : c0362ac4  r6 : cf85d200  r5 : cf85b888  r4 : cf9bcfc0
> r3 : 00000000  r2 : 70616d6f  r1 : c02dee56  r0 : 00000000
> Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
> Control: 10c5387d  Table: 80004019  DAC: 00000017
> Process swapper (pid: 1, stack limit =3D 0xcf81e2e0)
> Stack: (0xcf81fe58 to 0xcf820000)
> fe40:                                                       cf85d638 =
c0269f88
> fe60: cf85d638 003010b0 cf85d600 c0176970 00636d6d 00000004 00070080 =
00000004
> fe80: 00000000 cf842200 c036f1cc cf85b888 c036f1cc 00000053 00000001 =
c003314c
> fea0: cf00d140 00000000 cf00d140 cf85b880 cf00d000 00000000 cf85b888 =
c001b684
> fec0: cf9dc580 cf00d140 cf9b62d8 cf9dc5a0 00000000 cf85b888 cf85b888 =
c0369ae4
> fee0: c0369ae4 c0366cd0 00000000 00000000 00000000 c0199588 c0369ae4 =
c0198748
> ff00: 00000000 cf85b888 cf85b8bc c0369ae4 cf81ff28 c0198878 00000000 =
c0198818
> ff20: c0369ae4 c0198050 cf8034d8 cf858ab0 c0366cd0 00000000 c0021260 =
c0369ae4
> ff40: cf90cae0 c01978fc c02de05e c0166818 c00211f4 c0021260 c0369ae4 =
c001b288
> ff60: 00000000 c0198b54 c00211f4 c0021260 00000000 c001b288 00000000 =
c0026288
> ff80: c0355d54 0000024e c0355d54 cf8370a0 c0355d00 0000015f c0376ea8 =
c00d3244
> ffa0: c006f7dc cf838680 cf81ffb6 c006f7fc c0021260 35330f60 00000031 =
00000000
> ffc0: 00000000 00000192 c034efa0 00000000 c00211f4 c0021260 00000000 =
00000000
> ffe0: 00000000 c0008390 00000000 00000000 00000000 c004bb30 68b3fc0c =
10b3ef4c
> [<c0177cbc>] (regulator_get+0x90/0x29c) from [<c003314c>]=20
> (twl_mmc_late_init+0xb4/0x190)
> [<c003314c>] (twl_mmc_late_init+0xb4/0x190) from [<c001b684>]=20
> (omap_mmc_probe+0x3f0/0x5dc)
> [<c001b684>] (omap_mmc_probe+0x3f0/0x5dc) from [<c0199588>]=20
> (platform_drv_probe+0x1c/0x24)
> [<c0199588>] (platform_drv_probe+0x1c/0x24) from [<c0198748>]=20
> (driver_probe_device+0xa8/0x178)
> [<c0198748>] (driver_probe_device+0xa8/0x178) from [<c0198878>]=20
> (__driver_attach+0x60/0x84)
> [<c0198878>] (__driver_attach+0x60/0x84) from [<c0198050>]=20
> (bus_for_each_dev+0x4c/0x8c)
> [<c0198050>] (bus_for_each_dev+0x4c/0x8c) from [<c01978fc>]=20
> (bus_add_driver+0xa0/0x204)
> [<c01978fc>] (bus_add_driver+0xa0/0x204) from [<c0198b54>]=20
> (driver_register+0xbc/0x144)
> [<c0198b54>] (driver_register+0xbc/0x144) from [<c0026288>]=20
> (do_one_initcall+0x50/0x190)
> [<c0026288>] (do_one_initcall+0x50/0x190) from [<c0008390>]=20
> (kernel_init+0x74/0xe8)
> [<c0008390>] (kernel_init+0x74/0xe8) from [<c004bb30>] (do_exit+0x0/0=
x564)
> [<c004bb30>] (do_exit+0x0/0x564) from [<cf8129a0>] (0xcf8129a0)
> Code: e59f01e8 eb03c8c7 e3e04012 ea000073 (e5923000)
> ---[ end trace 1c3d399addb1ecb9 ]---
> Kernel panic - not syncing: Attempted to kill init!
>
>
>  =20

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

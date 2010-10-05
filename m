From: Pramod <pramod.gurav@ti.com>
Subject: Re: beagle hangs in uart3 disabling clocks
Date: Tue, 5 Oct 2010 15:04:30 +0530
Message-ID: <4CAAF126.5080206@ti.com>
References: <AANLkTi=9T=5swvF2UcrfDAL8cpHOcfpOU3Fi1O50Z6Tm@mail.gmail.com> <B85A65D85D7EB246BE421B3FB0FBB593023412B5A0@dbde02.ent.ti.com> <4CA9C5F6.7060902@ti.com> <AANLkTi=C55AbJhCWkFAM06vL2c5UM=aH3z2r8i4_55Mk@mail.gmail.com> <AANLkTin++-F7dZWhqM6DG4v-95rfOpOwHSqj8xhTdS3k@mail.gmail.com> <87wrpy0xp3.fsf@deeprootsystems.com> <AANLkTi=k+aZ2t2ZgXMcwuoBVPEjzyiGov1ZmSxe+Pe4-@mail.gmail.com> <87iq1hzt3u.fsf@deeprootsystems.com> <AANLkTimtfm+Tq6y=Gv=-JWEZ-1CYUpsO71aE0AjkSbHQ@mail.gmail.com> <alpine.DEB.2.00.1010050013210.13816@utopia.booyaka.com> <4CAACFFF.9040702@ti.com> <alpine.DEB.2.00.1010050117390.13816@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:53721 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932314Ab0JEJe2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 5 Oct 2010 05:34:28 -0400
In-Reply-To: <alpine.DEB.2.00.1010050117390.13816@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Ming Lei <tom.leiming@gmail.com>, Kevin Hilman <khilman@deeprootsystems.com>, Govindraj <govindraj.ti@gmail.com>, "Premi, Sanjeev" <premi@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Tuesday 05 October 2010 12:49 PM, Paul Walmsley wrote:
> On Tue, 5 Oct 2010, Pramod wrote:
>
>> I applied this patch on my kernel which is based on android-2.6.32 e=
nabling
>> dynamic printks. I still see the console hang after enabling the log=
s in
>> hwmod.
>>
>> I am using zoom3 board. Can you please let me know which defconfig f=
rom lo
>> master branch can be used to test on zoom3? I would like to test thi=
s patch
>> with lo master branch and zoom3.
>
> Could you please paste your boot log messages here?
>
>
> - Paul

Hi paul,
These are the boot log messages.

Uncompressing=20
Linux..................................................................=
=2E....................................................................=
=2E......................
=2E............................................................. done,=20
booting the kernel.
Initializing cgroup subsys cpu
Linux version 2.6.32.9-00001-g8d10978-dirty (dw@dw-desktop) (gcc versio=
n=20
4.4.1 (Sourcery G++ Lite 2009q3-67) ) #23 PREEMPT Tue Oct 5 12:25:20 IS=
T=20
2010
CPU: ARMv7 Processor [413fc082] revision 2 (ARMv7), cr=3D10c53c7f
CPU: VIPT nonaliasing data cache, VIPT nonaliasing instruction cache
Machine: OMAP Zoom3 board
Memory policy: ECC disabled, Data cache writeback
On node 0 totalpages: 131072
free_area_init_node: node 0, pgdat c06c1968, node_mem_map c07cb000
   Normal zone: 1024 pages used for memmap
   Normal zone: 0 pages reserved
   Normal zone: 130048 pages, LIFO batch:31
DIE ID: 5C320000000000000156087C06005013
OMAP3630 ES1.0 (l2cache iva sgx neon isp 192mhz_clk )
omap_sam_base (VA) =3D=3D 0xfe400000
omap_sram_start (PA) =3D=3D 0x40200000
omap_sram_size (SIZE) =3D=3D 0x10000
SRAM: Mapped pa 0x40200000 to va 0xfe400000 size: 0x100000
Reserving 14745600 bytes SDRAM for VRAM
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 13=
0048
Kernel command line: console=3DttyO2,115200n8 root=3D/dev/nfs rw=20
nfsroot=3D172.24.137.0:/home/dw/l25.x/25.INC3.1/myfs,nolock,wsize=3D102=
4,rsize=3D1024=20
init=3D/init ip=3Ddhcp videoout=3Domap24xx
vout omap_vout.video1_numbuffers=3D6 omap_vout.vid1_static_vrfb_alloc=3D=
y=20
omapfb.vram=3D0:4M earlyprintk loglevel=3D8
PID hash table entries: 2048 (order: 1, 8192 bytes)
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 256MB 256MB =3D 512MB total
Memory: 491008KB available (6180K code, 1352K data, 224K init, 0K highm=
em)
Virtual kernel memory layout:
     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
     vmalloc : 0xe0800000 - 0xf8000000   ( 376 MB)
     lowmem  : 0xc0000000 - 0xe0000000   ( 512 MB)
     pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
     modules : 0xbf000000 - 0xbfe00000   (  14 MB)
       .init : 0xc0008000 - 0xc0040000   ( 224 kB)
       .text : 0xc0040000 - 0xc0649000   (6180 kB)
       .data : 0xc0674000 - 0xc06ce3d0   ( 361 kB)
Hierarchical RCU implementation.
NR_IRQS:402
IRQ: Found an INTC at 0xfa200000 (revision 4.0) with 96 interrupts
Total of 96 interrupts on 1 active controller
Clocking rate (Crystal/Core/MPU): 26.0/400/600 MHz
Reprogramming SDRC clock to 400000000 Hz
GPMC revision 5.0
OMAP GPIO hardware version 2.5
OMAP clockevent source: GPTIMER1 at 32768 Hz
Console: colour dummy device 80x30
Calibrating delay loop... 597.64 BogoMIPS (lpj=3D2334720)
Mount-cache hash table entries: 512
Initializing cgroup subsys debug
Initializing cgroup subsys cpuacct
Initializing cgroup subsys freezer
CPU: Testing write buffer coherency: ok
regulator: core version 0.5
NET: Registered protocol family 16
mux: Setting signal i2c2_scl.i2c2_scl 0x0118 -> 0x0100
mux: Setting signal i2c2_sda.i2c2_sda 0x0118 -> 0x0100
mux: Setting signal i2c3_scl.i2c3_scl 0x0118 -> 0x0100
mux: Setting signal i2c3_sda.i2c3_sda 0x0118 -> 0x0100
mux: Setting signal uart3_cts_rctx.gpio_163 0x0108 -> 0x011c
mux: Setting signal cam_xclka.gpio_96 0x0004 -> 0x0004
mux: Setting signal cam_wen.gpio_167 0x0004 -> 0x0004
mux: Setting signal mcspi1_cs2.mcspi1_cs2 0x0108 -> 0x0108
mux: Setting signal cam_hs.gpio_94 0x010c -> 0x0104
mux: Setting signal cam_xclka.gpio_96 0x0004 -> 0x0004
mux: Setting signal gpmc_ncs5.gpio_56 0x0004 -> 0x0004
mux: Setting signal cam_vs.gpio_95 0x0114 -> 0x0004
mux: Setting signal sys_nirq.sys_nirq 0x0118 -> 0x4118
mux: Setting signal cam_pclk.gpio_97 0x0114 -> 0x011c
mux: Setting signal cam_d2.gpio101 0x0104 -> 0x0004
mux: Setting signal mcbsp1_clkx.gpio162 0x011c -> 0x0104
mux: Setting signal etk_clk.etk_clk 0x001b -> 0x011a
mux: Setting signal mcspi1_cs1.mcspi1_cs1 0x000b -> 0x011b
mux: Setting signal etk_d4.etk_d4 0x0103 -> 0x011a
mux: Setting signal etk_d5.etk_d5 0x0103 -> 0x011a
mux: Setting signal etk_d6.etk_d6 0x0103 -> 0x011a
mux: Setting signal etk_d3.etk_d3 0x0103 -> 0x011a
(wl12xx):  Connectivity board init
(wl12xx):  Connectivity board init for OMAP3+WL127x
(wl12xx):  wl127x_vio_leakage_fix
(wl12xx):  Adding Connectivity platform device
(wl12xx):  Configuring Connectivity GPIOs
mux: Setting signal cam_d10.gpio109 0x0104 -> 0x0004
mux: Setting signal mcbsp1_fsx.gpio161 0x011c -> 0x0004
mux: Setting signal uart3_rts_sd.gpio164 0x0000 -> 0x0004
OMAP DMA hardware revision 5.0
bio: create slab <bio-0> at 0
SCSI subsystem initialized
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
i2c_omap i2c_omap.1: bus 1 rev4.0 at 100 kHz
twl4030: PIH (irq 7) chaining IRQs 368..375
twl4030: power (irq 373) chaining IRQs 376..383
twl4030: gpio (irq 368) chaining IRQs 384..401
mux: Setting signal sdmmc1_clk.sdmmc1_clk 0x0000 -> 0x0118
mux: Setting signal sdmmc1_cmd.sdmmc1_cmd 0x0118 -> 0x0118
mux: Setting signal sdmmc1_dat0.sdmmc1_dat0 0x0118 -> 0x0118
mux: Setting signal sdmmc1_dat1.sdmmc1_dat1 0x0118 -> 0x0118
mux: Setting signal sdmmc1_dat2.sdmmc1_dat2 0x0118 -> 0x0118
mux: Setting signal sdmmc1_dat3.sdmmc1_dat3 0x0118 -> 0x0118
regulator: VUSB1V5: 1500 mV normal standby
regulator: VUSB1V8: 1800 mV normal standby
regulator: VUSB3V1: 3100 mV normal standby
twl4030_usb twl4030_usb: HW_CONDITIONS 0x70/112; link 1
twl4030_usb twl4030_usb: Initialized TWL4030 USB module
regulator: VMMC1: 1850 <--> 3150 mV at 3000 mV normal standby
regulator: VDAC: 1800 mV normal standby
regulator: VPLL2: 1800 mV normal standby
regulator: VMMC2: 1850 mV normal standby
regulator: VSIM: 1800 <--> 3000 mV at 1800 mV normal standby
i2c_omap i2c_omap.2: bus 2 rev4.0 at 100 kHz
i2c_omap i2c_omap.3: bus 3 rev4.0 at 400 kHz
Sangoma WANPIPE Router v1.1 (c) 1995-2000 Sangoma Technologies Inc.
Bluetooth: Core ver 2.15
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
Switching to clocksource 32k_counter
musb_hdrc: version 6.0, musb-dma, otg (peripheral+host), debug=3D0
HS USB OTG: revision 0x40, sysconfig 0x2005, sysstatus 0x1, intrfsel=20
0x1, simenable  0x0
musb_hdrc: ConfigData=3D0xde (UTMI-8, dyn FIFOs, bulk combine (X), bulk=
=20
split (X), HB-ISO Rx, HB-ISO Tx, SoftConn)
musb_hdrc: MHDRC RTL version 1.800
musb_hdrc: setup fifo_mode 4
musb_hdrc: 28/31 max ep, 16384/16384 memory
musb_hdrc: USB OTG mode controller at fa0ab000 using DMA, IRQ 92
NET: Registered protocol family 2
IP route cache hash table entries: 4096 (order: 2, 16384 bytes)
TCP established hash table entries: 16384 (order: 5, 131072 bytes)
TCP bind hash table entries: 16384 (order: 4, 65536 bytes)
TCP: Hash tables configured (established 16384 bind 16384)
TCP reno registered
NET: Registered protocol family 1
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
RPC: Registered tcp NFSv4.1 backchannel transport module.
dspbridge_init: 600000 bytes @ 81a00000
zoom2_wifi_init: start
omap-iommu omap-iommu.0: isp registered
iovmm-omap initialized isp, major: 253, base-minor: 0
ashmem: initialized
VFS: Disk quotas dquot_6.5.2
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
JFFS2 version 2.2. (NAND) =EF=BF=BD=C2=A9 2001-2006 Red Hat, Inc.
yaffs Oct  5 2010 12:18:21 Installing.
msgmni has been set to 959
alg: No test for stdrng (krng)
io scheduler noop registered
io scheduler cfq registered (default)
OMAP DSS rev 2.0
OMAP DISPC rev 3.0
OMAP VENC rev 2
dsi_init calling
OMAP DSI rev 1.0
omap-hsuart.0: ttyO0 at MMIO 0x4806a000 (irq =3D 72) is a OMAP UART0
omap-hsuart.1: ttyO1 at MMIO 0x4806c000 (irq =3D 73) is a OMAP UART1
omap-hsuart.2: ttyO2 at MMIO 0x49020000 (irq =3D 74) is a OMAP UART2
console [ttyO2] enabled
omap-hsuart.3: ttyO3 at MMIO 0x10000000 (irq =3D 262) is a OMAP UART3
brd: module loaded
loop: module loaded
Android kernel panic handler initialized (bind=3Dkpanic)
<6>LIS331DLH accelerometer driver
omap2-nand driver initializing
omap2-nand: irqstatus set on cmd entry ff
NAND device: Manufacturer ID: 0x2c, Chip ID: 0xbc (Micron NAND 512MiB=20
1,8V 16-bit)
Creating 7 MTD partitions on "omap2-nand.0":
0x000000000000-0x000000080000 : "X-Loader-NAND"
0x000000080000-0x000000200000 : "U-Boot-NAND"
0x0000001c0000-0x000000200000 : "Boot Env-NAND"
0x000000200000-0x000001e00000 : "Kernel-NAND"
0x000002000000-0x00000d400000 : "system"
0x00000d400000-0x000011400000 : "userdata"
0x000011400000-0x000013400000 : "cache"
smsc911x: Driver version 2008-10-21.
smsc911x-mdio: probed
eth0: attached PHY driver [Generic PHY] (mii_bus:phy_addr=3Dffffffff:01=
,=20
irq=3D-1)
net eth0: MAC Address: 00:08:ee:03:2a:0d
Initializing USB Mass Storage driver...
usbcore: registered new interface driver usb-storage
USB Mass Storage support registered.
android init
android_probe pdata: c0684bb0
android_bind
android_usb gadget: adding config #1 'android'/c06ab104
android_bind_config
android_usb gadget: cfg 1/c06ab104 speeds:
android_usb gadget: android_usb ready
musb_hdrc musb_hdrc: MUSB HDRC host driver
drivers/usb/core/inode.c: creating file 'devices'
drivers/usb/core/inode.c: creating file '001'
musb_hdrc musb_hdrc: new USB bus registered, assigned bus number 1
usb usb1: default language 0x0409
usb usb1: udev 1, busnum 1, minor =3D 0
usb usb1: New USB device found, idVendor=3D1d6b, idProduct=3D0002
usb usb1: New USB device strings: Mfr=3D3, Product=3D2, SerialNumber=3D=
1
usb usb1: Product: MUSB HDRC host driver
usb usb1: Manufacturer: Linux 2.6.32.9-00001-g8d10978-dirty musb-hcd
usb usb1: SerialNumber: musb_hdrc
usb usb1: uevent
usb usb1: usb_probe_device
usb usb1: configuration #1 chosen from 1 choice
usb usb1: adding 1-0:1.0 (config #1, interface 0)
usb 1-0:1.0: uevent
hub 1-0:1.0: usb_probe_interface
hub 1-0:1.0: usb_probe_interface - got id
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 1 port detected
hub 1-0:1.0: standalone hub
hub 1-0:1.0: individual port power switching
hub 1-0:1.0: no over-current protection
hub 1-0:1.0: power on to power good time: 10ms
hub 1-0:1.0: 100mA bus power budget for each child
hub 1-0:1.0: local power source is good
hub 1-0:1.0: enabling power on all ports
drivers/usb/core/inode.c: creating file '001'
f_adb init
android_register_function adb
f_mass_storage init
android_register_function usb_mass_storage
f_rndis init
android_register_function rndis
rndis_function_bind_config MAC: 02:05:43:33:32:30
android_usb gadget: using random self ethernet address
android_usb gadget: using random host ethernet address
usb0: MAC 02:96:06:2f:1b:90
usb0: HOST MAC b6:86:7c:cf:72:ef
android_usb gadget: adding 'rndis'/dfae7cc0 to config 'android'/c06ab10=
4
rndis_register: configNr =3D 0
rndis_set_param_medium: 0 0
rndis_set_param_vendor:
android_usb gadget: RNDIS: dual speed IN/ep1in OUT/ep1out NOTIFY/ep2in
mass_storage_bind_config
android_usb gadget: adding 'usb_mass_storage'/dfa70a00 to config=20
'android'/c06ab104
android_usb gadget: fsg_function_bind
android_usb gadget: Number of LUNs=3D1
adb_bind_config
android_usb gadget: adding 'adb'/dfae79c0 to config 'android'/c06ab104
android_usb gadget: adb_function_bind dev: dfae79c0
android_usb gadget: create_bulk_endpoints dev: dfae79c0
android_usb gadget: usb_ep_autoconfig for ep_in got ep4in
android_usb gadget: usb_ep_autoconfig for adb ep_out got ep3out
android_usb gadget: dual speed adb: IN/ep4in, OUT/ep3out
hub 1-0:1.0: state 7 ports 1 chg 0000 evt 0000
input: twl4030-keypad as=20
/devices/platform/i2c_omap.1/i2c-1/1-004a/twl4030_keypad/input/input0
twl4030_usb twl4030_usb: HW_CONDITIONS 0xf0/240; link 2
synaptics_ts_probe: Product Major Version 1
synaptics_ts_probe: Product Minor Version 3
synaptics_ts_probe: product property 2
synaptics_ts_probe: device control 81
synaptics_ts_probe: interrupt enable 3
synaptics_ts_probe: 0xe0: 1 1 1 2 1 3 0 0
synaptics_ts_probe: Sensor properties 601
synaptics_ts_probe: max_x 7515, max_y 4667
synaptics_ts_probe: inactive_x 0 0, inactive_y 0 0
synaptics_ts_probe: snap_x 0-0 0-0, snap_y 0-0 0-0
input: synaptics-rmi-touchscreen as /devices/virtual/input/input1
synaptics_ts_probe: Start touchscreen synaptics-rmi-touchscreen in=20
interrupt mode
using rtc device, twl_rtc, for alarms
twl_rtc twl_rtc: rtc core: registered twl_rtc as rtc0
i2c /dev entries driver
Linux video capture interface: v2.00
omap-previewer omap-previewer: omap-previewer: Registered preview wrapp=
er
omap3isp omap3isp: Revision 15.0 found
omap-iommu omap-iommu.0: isp: version 1.1
Saving csi2 context
Restoring csi2 context
Saving csi2 context
Driver for 1-wire Dallas network protocol.
OMAP Watchdog Timer Rev 0x31: initial timeout 60 sec
Bluetooth: HCI UART driver ver 2.2
Bluetooth: HCI H4 protocol initialized
Bluetooth: HCILL protocol initialized
cpuidle: using governor ladder
cpuidle: using governor menu
usbcore: registered new interface driver usbhid
usbhid: v2.6:USB HID core driver
logger: created 64K log 'log_main'
logger: created 256K log 'log_events'
logger: created 64K log 'log_radio'
logger: created 64K log 'log_system'
Advanced Linux Sound Architecture Driver Version 1.0.21.
No device for DAI twl4030
No device for DAI twl4030 Voice
No device for DAI twl4030 Clock
No device for DAI omap-mcbsp-dai-0
No device for DAI omap-mcbsp-dai-1
No device for DAI omap-mcbsp-dai-2
No device for DAI omap-mcbsp-dai-3
No device for DAI omap-mcbsp-dai-4
Zoom2 SoC init
set mux for group mode =3D OMAP_MCBSP2_SLAVE
mux: Setting signal mcbsp2_fsx.mcbsp2_fsx 0x0100 -> 0x0100
mux: Setting signal mcbsp2_clkx.mcbsp2_clkx 0x0100 -> 0x0100
mux: Setting signal mcbsp2_dr.mcbsp2_dr 0x0100 -> 0x0100
mux: Setting signal mcbsp2_dx.mcbsp2_dx 0x0000 -> 0x0000
No device for DAI null
set mux for group mode =3D OMAP_MCBSP4_SLAVE
mux: Setting signal mcbsp4_fsx.mcbsp4_fsx 0x0004 -> 0x0100
mux: Setting signal gpmc_ncs4.gpmc_ncs4 0x0000 -> 0x0102
mux: Setting signal gpmc_ncs5.gpmc_ncs5 0x0004 -> 0x0102
mux: Setting signal gpmc_ncs6.gpmc_ncs6 0x0104 -> 0x0002
TWL4030 Audio Codec init
asoc: twl4030 <-> omap-mcbsp-dai-0 mapping ok
asoc: twl4030 Voice <-> omap-mcbsp-dai-1 mapping ok
asoc: null <-> omap-mcbsp-dai-1 mapping ok
asoc: null <-> omap-mcbsp-dai-2 mapping ok
ALSA device list:
   #0: Zoom2 (twl4030)
oprofile: using timer
Netfilter messages via NETLINK v0.30.
nf_conntrack version 0.5.0 (7676 buckets, 30704 max)
CONFIG_NF_CT_ACCT is deprecated and will be removed soon. Please use
nf_conntrack.acct=3D1 kernel parameter, acct=3D1 nf_conntrack module op=
tion or
sysctl net.netfilter.nf_conntrack_acct=3D1 to enable it.
ctnetlink v0.93: registering with nfnetlink.
xt_time: kernel timezone is -0000
ip_tables: (C) 2000-2006 Netfilter Core Team
arp_tables: (C) 2002 David S. Miller
TCP cubic registered
Initializing XFRM netlink socket
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
Mobile IPv6
IPv6 over IPv4 tunneling driver
sit0: Disabled Privacy Extensions
ip6tnl0: Disabled Privacy Extensions
NET: Registered protocol family 17
NET: Registered protocol family 15
Bluetooth: L2CAP ver 2.14
Bluetooth: L2CAP socket layer initialized
Bluetooth: SCO (Voice Link) ver 0.6
Bluetooth: SCO socket layer initialized
Bluetooth: RFCOMM TTY layer initialized
Bluetooth: RFCOMM socket layer initialized
Bluetooth: RFCOMM ver 1.11
Bluetooth: BNEP (Ethernet Emulation) ver 1.3
Bluetooth: HIDP (Human Interface Emulation) ver 1.2
Power Management for TI OMAP3.
sr1_opp_margin[1]=3D37500
sr1_opp_margin[2]=3D37500
sr1_opp_margin[3]=3D37500
sr1_opp_margin[4]=3D62500
steps added, volt will berecaliberated automatically
SR2:Fused Nvalues for VDD2OPP1 11192746
SmartReflex driver initialized
Disabling unused clock "gpio2_dbck"
Disabling unused clock "gpio3_dbck"
Disabling unused clock "gpio5_dbck"
Disabling unused clock "sad2d_ick"
Disabling unused clock "dpll4_m6x2_ck"
Disabling unused clock "dpll4_m5x2_ck"
Disabling unused clock "dpll3_m3x2_ck"
Disabling unused clock "sys_clkout1"
VFP support v0.3: implementor 41 architecture 3 part 30 variant c rev 3
rotation =3D 0, var->rotate =3D 0 Console: switching to colour frame bu=
ffer=20
device 100x30
OMAP DISPCONTROL read (stallmode)0
OMAP DISPCONTROL read (gpout)0
OMAP DISPCONTROL read (stallmode)0
omapdss DPI: Could not find exact pixel clock. Requested 21800 kHz, got=
=20
21600 kHz
sil9022 3-0039: <sil9022_set_cm_clkout_ctrl> sil9022 HDMI Chip version =
=3D b0
regulator_init_complete: incomplete constraints, leaving VPLL2 on
twl_rtc twl_rtc: setting system clock to 2000-02-24 20:28:34 UTC (95142=
4114)
lv8093 2-0072: Registered lv8093 as V4L2 device.
Registered lv8093 as i2c device.
lv8093_lens_power_set(ON)
lv8093 Lens HW detected
lv8093_lens_power_set(OFF)
Restoring csi2 context
imx046_sensor_power_set(ON)
Context config pixel format unsupported
imx046 2-001a: model id detected 0x46 mfr 0xb, rev# 0x2
imx046 2-001a: imx046 chip version 0x02 detected
imx046_sensor_power_set(OFF)
Saving csi2 context
Restoring csi2 context
omap3 omap3isp CSI memvs initted
Saving csi2 context
omap_vout: registered and initialized video device 3 [v4l2]
omap_vout: registered and initialized video device 4 [v4l2]
net eth0: SMSC911x/921x identified at 0xe08b4000, IRQ: 318
usb0: eth_open
ADDRCONF(NETDEV_UP): usb0: link is not ready
Sending DHCP requests .
hub 1-0:1.0: hub_suspend
usb usb1: bus auto-suspend
=2E, OK
IP-Config: Got DHCP answer from 0.0.0.0, my address is 172.24.137.179
usb0: stop stats: rx/tx 0/0, errs 0/0
IP-Config: Complete:
      device=3Deth0, addr=3D172.24.137.179, mask=3D255.255.254.0, gw=3D=
172.24.136.2,
      host=3D172.24.137.179, domain=3Dapr.dhcp.ti.com, nis-domain=3D(no=
ne),
      bootserver=3D0.0.0.0, rootserver=3D172.24.137.0, rootpath=3D
Looking up port of RPC 100003/2 on 172.24.137.0
Looking up port of RPC 100005/1 on 172.24.137.0
VFS: Mounted root (nfs filesystem) on device 0:13.
=46reeing init memory: 224K
Warning: unable to open an initial console.
usb usb1: uevent
usb 1-0:1.0: uevent
init: cannot open '/initlogo.rle'
init: cannot find '/system/bin/pvrsrvinit', disabling 'pvrsrvinit'
init: cannot find '/system/etc/install-recovery.sh', disabling=20
'flash_recovery'
init: cannot find '/system/bin/fw3a_core', disabling 'fw3a'
init: cannot find '/system/bin/playmp3', disabling 'bootsound'
twl4030_usb twl4030_usb: HW_CONDITIONS 0x70/112; link 1
proc_load: Processor Loaded /system/lib/dsp/baseimage.dof
omap mailbox rev 4.0
warning: `rild' uses 32-bit capabilities (legacy support in use)
proc_start: dsp in running state
procwrap_detach: deprecated dspbridge ioctl
/bin/sh: can't access tty; job control turned off
# eth0: no IPv6 routers present
    NFS: server 172.24.137.0 error: fileid changed
fsid 0:d: expected fileid 0xbe2e57, got 0xbe2e4a
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

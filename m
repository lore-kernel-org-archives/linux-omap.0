From: Bill Gatliff <bgat@billgatliff.com>
Subject: Re: Anyone using an ISP1505?
Date: Fri, 18 Dec 2009 13:13:59 -0600
Message-ID: <4B2BD477.4080105@billgatliff.com>
References: <4B2A7FFB.6090909@billgatliff.com> <20091217191005.GA30191@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f211.google.com ([209.85.217.211]:59904 "EHLO
	mail-gx0-f211.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753908AbZLRTNu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Dec 2009 14:13:50 -0500
Received: by gxk3 with SMTP id 3so2336827gxk.1
        for <linux-omap@vger.kernel.org>; Fri, 18 Dec 2009 11:13:49 -0800 (PST)
In-Reply-To: <20091217191005.GA30191@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: felipe.balbi@nokia.com
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "beagleboard@googlegroups.com" <beagleboard@googlegroups.com>

=46elipe Balbi wrote:
>
> is this with musb ? if it's musb, you need the nop transceiver. Do yo=
u
> have any boot logs which you could share ? Without information on the
> board, is a bit difficult :-(

Of course.  Here is an excerpt from my dmesg output:



Linux version 2.6.33-rc1-06888-g7fa9fb6-dirty (bgat@mercury) (gcc
version 4.3.2 (Debian 4.3.2-1.1) ) #22 Fri Dec 18 18:58:00 UTC
2009                                                                 =20
CPU: ARMv7 Processor [411fc083] revision 3 (ARMv7),
cr=3D10c53c7f                                   =20
CPU: VIPT nonaliasing data cache, VIPT nonaliasing instruction
cache                              =20
Machine: TBD
Memory policy: ECC disabled, Data cache
writeback                                                 =20
On node 0 totalpages:
32768                                                                  =
     =20

free_area_init_node: node 0, pgdat c0467a3c, node_mem_map
c0485000                                =20
  Normal zone: 256 pages used for
memmap                                                          =20
  Normal zone: 0 pages
reserved                                                               =
    =20

  Normal zone: 32512 pages, LIFO
batch:7                                                          =20
OMAP3430/3530 ES3.0 (l2cache iva sgx neon isp
)                                                   =20
SRAM: Mapped pa 0x40200000 to va 0xfe400000 size:
0x100000                                        =20
Built 1 zonelists in Zone order, mobility grouping on.  Total pages:
32512                        =20
Kernel command line: root=3Dnfs nfsroot=3D192.168.2.10:/exports/tbd rw
ip=3D192.168.2.168:192.168.2.10:192.168.2.1:255.255.255.0:tbd:eth0:off
console=3DttyS1,115200n8                                  =20
PID hash table entries: 512 (order: -1, 2048
bytes)                                               =20
Dentry cache hash table entries: 16384 (order: 4, 65536
bytes)                                    =20
Inode-cache hash table entries: 8192 (order: 3, 32768
bytes)                                      =20
Memory: 128MB =3D 128MB
total                                                                  =
     =20

Memory: 125168KB available (3992K code, 310K data, 164K init, 0K
highmem)                         =20
Hierarchical RCU
implementation.                                                        =
          =20

RCU-based detection of stalled CPUs is
enabled.                                                   =20
NR_IRQS:388                                                            =
                           =20

Clocking rate (Crystal/Core/MPU): 19.2/332/545
MHz                                                =20
Reprogramming SDRC clock to 332000000
Hz                                                          =20
GPMC revision
5.0                                                                    =
             =20

IRQ: Found an INTC at 0xfa200000 (revision 4.0) with 96
interrupts                                =20
Total of 96 interrupts on 1 active
controller                                                     =20
OMAP GPIO hardware version
2.5                                                                    =
=20
OMAP clockevent source: GPTIMER12 at 32768
Hz                                                     =20
Console: colour dummy device
80x30                                                                =20
Calibrating delay loop... 524.12 BogoMIPS
(lpj=3D2048000)                                           =20
Mount-cache hash table entries:
512                                                               =20
CPU: Testing write buffer coherency:
ok                                                           =20
NET: Registered protocol family
16                                                                =20
mux: Setting signal mcbsp_clks.mcbsp_clks 0x0100 ->
0x0100                                        =20
mux: Setting signal mcbsp2_fsx.mcbsp2_fsx 0x0018 ->
0x0100                                        =20
mux: Setting signal mcbsp2_clkx.mcbsp2_clkx 0x0018 ->
0x0100                                      =20
mux: Setting signal mcbsp2_dx.mcbsp2_dx 0x0018 ->
0x0000                                          =20
mux: Setting signal mcbsp2_dr.mcbsp2_dr 0x0100 ->
0x0100                                          =20
mux: Setting signal i2c1_scl.i2c1_scl 0x0118 ->
0x0118                                            =20
mux: Setting signal i2c1_sda.i2c1_sda 0x0118 ->
0x0118                                            =20
mux: Setting signal sys_clkout1.sys_clkout1 0x0100 ->
0x0000                                      =20
mux: Setting signal hsusb0_clk.hsusb0_clk 0x0100 ->
0x0000                                        =20
mux: Setting signal hsusb0_stp.hsusb0_stp 0x0018 ->
0x0000                                        =20
mux: Setting signal hsusb0_dir.hsusb0_dir 0x0100 ->
0x0100                                        =20
mux: Setting signal hsusb0_nxt.hsusb0_nxt 0x0100 ->
0x0100                                        =20
mux: Setting signal hsusb0_data0.hsusb0_data0 0x0100 ->
0x0100                                    =20
mux: Setting signal hsusb0_data1.hsusb0_data1 0x0100 ->
0x0100                                    =20
mux: Setting signal hsusb0_data2.hsusb0_data2 0x0100 ->
0x0100                                    =20
mux: Setting signal hsusb0_data3.hsusb0_data3 0x0100 ->
0x0100                                    =20
mux: Setting signal hsusb0_data4.hsusb0_data4 0x0100 ->
0x0100                                    =20
mux: Setting signal hsusb0_data5.hsusb0_data5 0x0100 ->
0x0100                                    =20
mux: Setting signal hsusb0_data6.hsusb0_data6 0x0100 ->
0x0100                                    =20
mux: Setting signal hsusb0_data7.hsusb0_data7 0x0100 ->
0x0100                                    =20
mux: Setting signal mcbsp3_dx.gpio140 0x0004 ->
0x0004                                            =20
mux: Setting signal etk_clk.hsusb1_stp 0x0018 ->
0x0003                                           =20
mux: Setting signal etk_ctl.hsusb1_clk 0x0000 ->
0x0003                                           =20
mux: Setting signal etk_d8.hsusb1_dir 0x0100 ->
0x010b                                            =20
mux: Setting signal etk_d9.hsusb1_nxt 0x0100 ->
0x010b                                            =20
mux: Setting signal etk_d0.hsusb1_data0 0x0100 ->
0x010b                                          =20
mux: Setting signal etk_d1.hsusb1_data1 0x0100 ->
0x010b                                          =20
mux: Setting signal etk_d2.hsusb1_data2 0x0108 ->
0x010b                                          =20
mux: Setting signal etk_d7.hsusb1_data3 0x0100 ->
0x010b                                          =20
mux: Setting signal etk_d4.hsusb1_data4 0x0100 ->
0x010b                                          =20
mux: Setting signal etk_d5.hsusb1_data5 0x0100 ->
0x010b                                          =20
mux: Setting signal etk_d6.hsusb1_data6 0x0100 ->
0x010b                                          =20
mux: Setting signal etk_d3.hsusb1_data7 0x0100 ->
0x010b                                          =20
mux: Setting signal etk_d11.hsusb2_stp 0x0100 ->
0x0003                                           =20
mux: Setting signal etk_d10.hsusb2_clk 0x0100 ->
0x0003                                           =20
mux: Setting signal etk_d12.hsusb2_dir 0x0100 ->
0x010b                                           =20
mux: Setting signal etk_d13.hsusb2_nxt 0x0100 ->
0x010b                                           =20
mux: Setting signal etk_d14.hsusb2_data0 0x0100 ->
0x010b                                         =20
mux: Setting signal etk_d15.hsusb2_data1 0x0100 ->
0x010b                                         =20
mux: Setting signal mcspi1_cs3.hsusb2_data2 0x011f ->
0x010b                                      =20
mux: Setting signal mcspi2_cs1.hsusb2_data3 0x011c ->
0x010b                                      =20
mux: Setting signal mcspi2_simo.hsusb2_data4 0x010f ->
0x010b                                     =20
mux: Setting signal mcspi2_somi.hsusb2_data5 0x010f ->
0x010b                                     =20
mux: Setting signal mcspi2_cs0.hsusb2_data6 0x011f ->
0x010b                                      =20
mux: Setting signal mcspi2_clk.hsusb2_data7 0x010f ->
0x010b                                      =20
OMAP DMA hardware revision
4.0                                                                    =
=20
bio: create slab <bio-0> at
0                                                                     =20
SCSI subsystem
initialized                                                            =
            =20

omap2_mcspi omap2_mcspi.1: registered master
spi1                                                 =20
omap2_mcspi omap2_mcspi.2: registered master
spi2                                                 =20
omap2_mcspi omap2_mcspi.3: registered master
spi3                                                 =20
omap2_mcspi omap2_mcspi.4: registered master
spi4                                                 =20
usbcore: registered new interface driver
usbfs                                                    =20
usbcore: registered new interface driver
hub                                                      =20
usbcore: registered new device driver
usb                                                         =20
i2c_omap i2c_omap.1: bus 1 rev3.12 at 100
kHz                                                     =20
Switching to clocksource
32k_counter                                                            =
  =20
musb_hdrc: version 6.0, musb-dma, host,
debug=3D0                                                   =20
musb_hdrc: ConfigData=3D0xde (UTMI-8, dyn FIFOs, bulk combine (X), bulk
split (X), HB-ISO Rx, HB-ISO Tx,
SoftConn)                                                              =
                        =20

musb_hdrc: MHDRC RTL version
1.400                                                                =20
musb_hdrc: setup fifo_mode
4                                                                      =
=20
musb_hdrc: 28/31 max ep, 16384/16384
memory                                                       =20
musb_hdrc: USB Host mode controller at fa0ab000 using DMA, IRQ
92                                 =20
musb_hdrc musb_hdrc: MUSB HDRC host
driver                                                        =20
musb_hdrc musb_hdrc: new USB bus registered, assigned bus number
1                                =20
usb usb1: default language
0x0409                                                                 =
=20
usb usb1: udev 1, busnum 1, minor =3D
0                                                             =20
usb usb1: New USB device found, idVendor=3D1d6b,
idProduct=3D0002                                     =20
usb usb1: New USB device strings: Mfr=3D3, Product=3D2,
SerialNumber=3D1                                =20
usb usb1: Product: MUSB HDRC host
driver                                                          =20
usb usb1: Manufacturer: Linux 2.6.33-rc1-06888-g7fa9fb6-dirty
musb-hcd                            =20
usb usb1: SerialNumber:
musb_hdrc                                                              =
   =20
usb usb1:
uevent                                                                 =
                 =20

usb usb1:
usb_probe_device                                                       =
                 =20

usb usb1: configuration #1 chosen from 1
choice                                                   =20
usb usb1: adding 1-0:1.0 (config #1, interface
0)                                                 =20
usb 1-0:1.0:
uevent                                                                 =
              =20

hub 1-0:1.0:
usb_probe_interface                                                    =
              =20

hub 1-0:1.0: usb_probe_interface - got
id                                                         =20
hub 1-0:1.0: USB hub
found                                                                  =
      =20

hub 1-0:1.0: 1 port
detected                                                               =
       =20

hub 1-0:1.0: standalone
hub                                                                    =
   =20
hub 1-0:1.0: individual port power
switching                                                      =20
hub 1-0:1.0: no over-current
protection                                                           =20
hub 1-0:1.0: power on to power good time:
10ms                                                    =20
hub 1-0:1.0: 100mA bus power budget for each
child                                                =20
hub 1-0:1.0: local power source is
good                                                           =20
hub 1-0:1.0: enabling power on all
ports                                                          =20
NET: Registered protocol family
2                                                                 =20
IP route cache hash table entries: 1024 (order: 0, 4096
bytes)                                    =20
TCP established hash table entries: 4096 (order: 3, 32768
bytes)                                  =20
TCP bind hash table entries: 4096 (order: 2, 16384
bytes)                                         =20
TCP: Hash tables configured (established 4096 bind
4096)                                          =20
TCP reno
registered                                                             =
                  =20

UDP hash table entries: 256 (order: 0, 4096
bytes)                                                =20
UDP-Lite hash table entries: 256 (order: 0, 4096
bytes)                                           =20
NET: Registered protocol family
1                                                                 =20
RPC: Registered udp transport
module.                                                             =20
RPC: Registered tcp transport
module.                                                             =20
RPC: Registered tcp NFSv4.1 backchannel transport
module.                                         =20
NetWinder Floating Point Emulator V0.97 (double
precision)                                        =20
VFS: Disk quotas
dquot_6.5.2                                                            =
          =20

Dquot-cache hash table entries: 1024 (order 0, 4096
bytes)                                        =20
JFFS2 version 2.2. (NAND) =A9 2001-2006 Red Hat,
Inc.                                               =20
msgmni has been set to
244                                                                    =
    =20

alg: No test for stdrng
(krng)                                                                 =
   =20
io scheduler noop
registered                                                             =
         =20

io scheduler deadline
registered                                                             =
     =20

io scheduler cfq registered
(default)                                                             =20
Serial: 8250/16550 driver, 4 ports, IRQ sharing
enabled                                           =20
serial8250.0: ttyS0 at MMIO 0x4806a000 (irq =3D 72) is a
ST16654                                    =20
serial8250.1: ttyS1 at MMIO 0x4806c000 (irq =3D 73) is a
ST16654                                    =20
console [ttyS1]
enabled                                                                =
           =20

hub 1-0:1.0: state 7 ports 1 chg 0000 evt
0000                                                    =20
serial8250.2: ttyS2 at MMIO 0x49020000 (irq =3D 74) is a
ST16654                                    =20
brd: module
loaded                                                                 =
               =20

loop: module
loaded                                                                 =
              =20

PPP generic driver version
2.4.2                                                                  =
=20
PPP Deflate Compression module
registered                                                         =20
PPP BSD Compression module
registered                                                             =
=20
NET: Registered protocol family
24                                                                =20
smsc911x: Driver version
2008-10-21.                                                            =
  =20
smsc911x-mdio:
probed                                                                 =
            =20

eth0: attached PHY driver [SMSC LAN8700] (mii_bus:phy_addr=3Dffffffff:0=
1,
irq=3D-1)                   =20
net eth0: MAC Address:
46:66:17:ff:76:af                                                      =
    =20

console [netcon0]
enabled                                                                =
         =20

netconsole: network logging
started                                                               =20
ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI)
Driver                                        =20
ehci_hcd: block sizes: qh 60 qtd 96 itd 160 sitd
96                                               =20
ehci-omap ehci-omap.0: starting TI EHCI USB
Controller                                            =20
ehci-omap ehci-omap.0: TLL RESET
DONE                                                             =20
ehci-omap ehci-omap.0: OMAP3 ES version >
ES2.1                                                   =20
ehci-omap ehci-omap.0: UHH setup done,
uhh_hostconfig=3D31c                                         =20
ehci-omap ehci-omap.0: OMAP-EHCI Host
Controller                                                  =20
ehci-omap ehci-omap.0: new USB bus registered, assigned bus number
2                              =20
ehci-omap ehci-omap.0: park
0                                                                     =20
ehci-omap ehci-omap.0: irq 77, io mem
0x48064800                                                  =20
ehci-omap ehci-omap.0: reset command 090b02 park=3D3 ithresh=3D9 period=
=3D1024
Reset HALT               =20
ehci-omap ehci-omap.0: init command 010009 (park)=3D0 ithresh=3D1 perio=
d=3D256
RUN                      =20
ehci-omap ehci-omap.0: USB 2.0 started, EHCI
1.00                                                 =20
usb usb2: default language
0x0409                                                                 =
=20
usb usb2: udev 1, busnum 2, minor =3D
128                                                           =20
usb usb2: New USB device found, idVendor=3D1d6b,
idProduct=3D0002                                     =20
usb usb2: New USB device strings: Mfr=3D3, Product=3D2,
SerialNumber=3D1                                =20
usb usb2: Product: OMAP-EHCI Host
Controller                                                      =20
usb usb2: Manufacturer: Linux 2.6.33-rc1-06888-g7fa9fb6-dirty
ehci_hcd                            =20
usb usb2: SerialNumber:
ehci-omap.0                                                            =
   =20
usb usb2:
uevent                                                                 =
                 =20

usb usb2:
usb_probe_device                                                       =
                 =20

usb usb2: configuration #1 chosen from 1
choice                                                   =20
usb usb2: adding 2-0:1.0 (config #1, interface
0)                                                 =20
usb 2-0:1.0:
uevent                                                                 =
              =20

hub 2-0:1.0:
usb_probe_interface                                                    =
              =20

hub 2-0:1.0: usb_probe_interface - got
id                                                         =20
hub 2-0:1.0: USB hub
found                                                                  =
      =20

hub 2-0:1.0: 3 ports
detected                                                               =
      =20

hub 2-0:1.0: standalone
hub                                                                    =
   =20
hub 2-0:1.0: individual port power
switching                                                      =20
hub 2-0:1.0: individual port over-current
protection                                              =20
hub 2-0:1.0: power on to power good time:
20ms                                                    =20
hub 2-0:1.0: local power source is
good                                                           =20
hub 2-0:1.0: enabling power on all ports
i2c /dev entries driver
OMAP Watchdog Timer Rev 0x31: initial timeout 60 sec
Advanced Linux Sound Architecture Driver Version 1.0.21.
No device for DAI omap-mcbsp-dai-0
No device for DAI omap-mcbsp-dai-1
No device for DAI omap-mcbsp-dai-2
No device for DAI omap-mcbsp-dai-3
No device for DAI omap-mcbsp-dai-4
asoc: WM8731 <-> omap-mcbsp-dai-0 mapping ok
ALSA device list:
  #0: tbd (WM8731)
TCP cubic registered
NET: Registered protocol family 17
NET: Registered protocol family 15
Power Management for TI OMAP3.
VFP support v0.3: implementor 41 architecture 3 part 30 variant c rev 1
drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
hub 2-0:1.0: state 7 ports 3 chg 0000 evt 0000
net eth0: SMSC911x/921x identified at 0xc88ae000, IRQ: 222
IP-Config: Complete:
     device=3Deth0, addr=3D192.168.2.168, mask=3D255.255.255.0, gw=3D19=
2.168.2.1,
     host=3Dtbd, domain=3D, nis-domain=3D(none),
     bootserver=3D192.168.2.10, rootserver=3D192.168.2.10, rootpath=3D
Looking up port of RPC 100003/2 on 192.168.2.10
hub 1-0:1.0: hub_suspend
usb usb1: bus auto-suspend
hub 2-0:1.0: hub_suspend
usb usb2: bus auto-suspend
ehci-omap ehci-omap.0: suspend root hub
Looking up port of RPC 100005/1 on 192.168.2.10
VFS: Mounted root (nfs filesystem) on device 0:12.
=46reeing init memory: 164K
usb usb2: uevent
usb 2-0:1.0: uevent
usb usb1: uevent
usb 1-0:1.0: uevent
usb usb1: uevent
usb usb2: uevent
usb usb2: uevent
usb 2-0:1.0: uevent
usb usb1: uevent
usb 1-0:1.0: uevent



--=20
Bill Gatliff
bgat@billgatliff.com

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

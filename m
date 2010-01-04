From: Kovacs Peter Tamas <p.kovacs@holografika.com>
Subject: PVR driver crash
Date: Mon, 04 Jan 2010 19:00:10 +0100
Message-ID: <4B422CAA.5030007@holografika.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail01d.mail.t-online.hu ([84.2.42.6]:54802 "EHLO
	mail01d.mail.t-online.hu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751551Ab0ADSLR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Jan 2010 13:11:17 -0500
Received: from holoiroda.com (holoiroda.com [81.182.243.140])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail01d.mail.t-online.hu (Postfix) with ESMTPSA id 99EC1758485
	for <linux-omap@vger.kernel.org>; Mon,  4 Jan 2010 18:58:09 +0100 (CET)
Received: from [192.168.0.129] (port=4426)
	by holoiroda.com with esmtpsa (Exim 4.69-NetSys #4)
	id 1NRrDu-00083O-Ro
	for linux-omap@vger.kernel.org; Mon, 04 Jan 2010 19:00:10 +0100
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>

Hi All,

did any of you run into such a crash with the PowerVR GFX drivers before?
(it's custom compiled, as the original one is not for this kernel version)

OMAP34XX LAB # bootm 80300000
## Booting image at 80300000 ...
   Image Name:   Linux-2.6.32-10567-g6833f1a-dirt
   Image Type:   ARM Linux Kernel Image (uncompressed)
   Data Size:    2022360 Bytes =  1.9 MB
   Load Address: 80008000
   Entry Point:  80008000
   Verifying Checksum ... OK
OK

Starting kernel ...

Uncompressing 
Linux..................................................................
Linux version 2.6.32-10567-g6833f1a-dirty (omap@omap-devel) (gcc version 
4.2.3 (Sour0
CPU: ARMv7 Processor [411fc082] revision 2 (ARMv7), cr=10c53c7f
CPU: VIPT nonaliasing data cache, VIPT nonaliasing instruction cache
Machine: OMAP LDP board
Memory policy: ECC disabled, Data cache writeback
OMAP3430/3530 ES2.1 (l2cache iva sgx neon isp )
SRAM: Mapped pa 0x40200000 to va 0xfe400000 size: 0x100000
Reserving 2097152 bytes SDRAM for VRAM
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 32512
Kernel command line: console=ttyS2,115200n8 noinitrd root=/dev/nfs rw 
nfsroot=192.16e
PID hash table entries: 512 (order: -1, 2048 bytes)
Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
Memory: 128MB = 128MB total
Memory: 123648KB available (3504K code, 309K data, 136K init, 0K highmem)
Hierarchical RCU implementation.
RCU-based detection of stalled CPUs is enabled.
NR_IRQS:402
Clocking rate (Crystal/Core/MPU): 26.0/332/500 MHz
Reprogramming SDRC clock to 332000000 Hz
dpll3_m2_clk rate change failed: -22
GPMC revision 5.0
IRQ: Found an INTC at 0xfa200000 (revision 4.0) with 96 interrupts
Total of 96 interrupts on 1 active controller
OMAP GPIO hardware version 2.5
OMAP clockevent source: GPTIMER1 at 32768 Hz
Console: colour dummy device 80x30
Calibrating delay loop... 499.92 BogoMIPS (lpj=1949696)
Mount-cache hash table entries: 512
CPU: Testing write buffer coherency: ok
NET: Registered protocol family 16
OMAP DMA hardware revision 4.0
bio: create slab <bio-0> at 0
SCSI subsystem initialized
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
i2c_omap i2c_omap.1: bus 1 rev3.12 at 2600 kHz
twl4030: PIH (irq 7) chaining IRQs 368..375
twl4030: power (irq 373) chaining IRQs 376..383
twl4030: gpio (irq 368) chaining IRQs 384..401
i2c_omap i2c_omap.2: bus 2 rev3.12 at 400 kHz
i2c_omap i2c_omap.3: bus 3 rev3.12 at 400 kHz
Switching to clocksource 32k_counter
NET: Registered protocol family 2
IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
TCP established hash table entries: 4096 (order: 3, 32768 bytes)
TCP bind hash table entries: 4096 (order: 2, 16384 bytes)
TCP: Hash tables configured (established 4096 bind 4096)
TCP reno registered
UDP hash table entries: 256 (order: 0, 4096 bytes)
UDP-Lite hash table entries: 256 (order: 0, 4096 bytes)
NET: Registered protocol family 1
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
RPC: Registered tcp NFSv4.1 backchannel transport module.
NetWinder Floating Point Emulator V0.97 (double precision)
VFS: Disk quotas dquot_6.5.2
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
msgmni has been set to 241
alg: No test for stdrng (krng)
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
OMAP DSS rev 2.0
OMAP DISPC rev 3.0
OMAP VENC rev 2
ldp_panel_init
ldp_panel_probe
Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
serial8250.0: ttyS0 at MMIO 0x4806a000 (irq = 72) is a ST16654
serial8250.1: ttyS1 at MMIO 0x4806c000 (irq = 73) is a ST16654
serial8250.2: ttyS2 at MMIO 0x49020000 (irq = 74) is a ST16654
console [ttyS2] enabled
brd: module loaded
loop: module loaded
smsc911x: Driver version 2008-10-21.
smsc911x-mdio: probed
eth0: attached PHY driver [SMSC LAN8700] (mii_bus:phy_addr=ffffffff:01, 
irq=-1)
net eth0: MAC Address: 00:08:ee:02:52:88
usbmon: debugfs is not available
ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
ads7846 spi1.0: touchscreen, irq 214
input: ADS7846 Touchscreen as 
/devices/platform/omap2_mcspi.1/spi1.0/input/input0
i2c /dev entries driver
Linux video capture interface: v2.00
usbcore: registered new interface driver uvcvideo
USB Video Class driver (v0.1.0)
Driver for 1-wire Dallas network protocol.
usbcore: registered new interface driver usbhid
usbhid: v2.6:USB HID core driver
Advanced Linux Sound Architecture Driver Version 1.0.21.
ALSA device list:
  No soundcards found.
TCP cubic registered
Initializing XFRM netlink socket
NET: Registered protocol family 17
NET: Registered protocol family 15
VFP support v0.3: implementor 41 architecture 3 part 30 variant c rev 1
Console: switching to colour frame buffer device 60x40
omapdss DPI: Could not find exact pixel clock. Requested 41700 kHz, got 
41142 kHz
ldp_panel_enable
ldp_panel_enable_lcd
drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
net eth0: SMSC911x/921x identified at 0xc8808000, IRQ: 312
IP-Config: Complete:
     device=eth0, addr=192.168.11.2, mask=255.255.255.0, gw=192.168.11.1,
     host=holomobile, domain=, nis-domain=(none),
     bootserver=192.168.11.1, rootserver=192.168.11.1, rootpath=
Looking up port of RPC 100003/2 on 192.168.11.1
Looking up port of RPC 100005/1 on 192.168.11.1
VFS: Mounted root (nfs filesystem) on device 0:11.
Freeing init memory: 136K

******************************************
Starting System Init for 23.11
Release: 23.11
******************************************
Saving kernel ring buffer : OK
Mounting devpts : OK
Setting up networking
Configuring lo : OK
Configuring eth0 : OK - 192.168.11.2
Starting telnetd : OK
Starting syslogd : OK
Starting klogd : OK
Mounting filesystems : OK
Setting environment : OK
Loading up Bridge: Launching X server : OK
/etc/init.d/rc.local: line 2: can't create /sys/power/fb_timeout_value: 
nonexistent y
setterm: setterm compiled with DIET_SETTERM only supports the linux console

Please press Enter to activate this console. InitConnectionLimits: 
MaxClients = 256
_XSERVTransSocketOpenCOTSServer: Unable to open socket for inet6
_XSERVTransOpen: transport open failed for inet6/23.11:0
_XSERVTransMakeAllCOTSServerListeners: failed to open listener for inet6
Sync Extension 3.0
[dix] Could not init font path element 
/home/omap/OMAP_src/x/omap/usr/lib/X11/fonts/!
[dix] Could not init font path element 
/home/omap/OMAP_src/x/omap/usr/lib/X11/fonts/!
[dix] Could not init font path element 
/home/omap/OMAP_src/x/omap/usr/lib/X11/fonts/!
[dix] Could not init font path element 
/home/omap/OMAP_src/x/omap/usr/lib/X11/fonts/!
[dix] Could not init font path element 
/home/omap/OMAP_src/x/omap/usr/lib/X11/fonts/!
Popen: `"/home/omap/OMAP_src/x/omap/usr/bin/xkbcomp" -w 1 
"-R/home/omap/OMAP_src/x/o8
Pclose: fp = 0x3309b8
Loaded XKB keymap 
/home/omap/OMAP_src/x/omap/usr/share/X11/xkb/compiled/server-0.xkmf
AllocNewConnection: client index = 1, socket fd = 7
AllocNewConnection: client index = 2, socket fd = 8
AllocNewConnection: client index = 3, socket fd = 9
matchbox: Cant find keysym for app
matchbox: ignoring key shortcut App=!mbcontrol -mbmenu

matchbox-desktop: loading //lib/matchbox/desktop/tasks.so with args ( None )
AllocNewConnection: client index = 4, socket fd = 10
matchbox-desktop: loading //lib/matchbox/desktop/dotdesktop.so with args 
( None )
user_overides is (nil)
mb-desktop-dotdesktop: failed to open /usr/share/applications
mb-desktop-dotdesktop: failed to open /usr/local/share/applications
mb-desktop-dotdesktop: failed to open //.applications
mb-applet-menu-launcher: failed to open /usr/share/applications
mb-applet-menu-launcher: failed to open /usr/local/share/applications
mb-applet-menu-launcher: failed to open //.applications
AllocNewConnection: client index = 5, socket fd = 11
mb-applet-menu-launcher: failed to open /usr/share/applications
mb-applet-menu-launcher: failed to open /usr/local/share/applications
mb-applet-menu-launcher: failed to open //.applications

#
# modprobe pvrsrvkm
y=BF03F8DC, v=0x0y=BF03F8DC, v=0x0v=0x4y=BF03F8DC, v=0x0
Unable to handle kernel paging request at virtual address 6e797320
pgd = c7a48000
[6e797320] *pgd=00000000
Internal error: Oops: 5 [#1]
last sysfs file: /sys/devices/virtual/vc/vcsa2/dev
Modules linked in: pvrsrvkm(+)
CPU: 0    Not tainted  (2.6.32-10567-g6833f1a-dirty #13)
PC is at strcpy+0x4/0x18
LR is at HAPFlagsToString+0x214/0x228 [pvrsrvkm]
pc : [<c01670f8>]    lr : [<bf01a134>]    psr: 80000013
sp : c7a2fd30  ip : 00000073  fp : 00000000
r10: 00000000  r9 : bf03f5a0  r8 : c03e7280
r7 : 00000000  r6 : bf03f558  r5 : c01ae6f4  r4 : bf03f598
r3 : 6e797320  r2 : bf03fb02  r1 : 6e797320  r0 : bf03fb02
Flags: Nzcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
Control: 10c5387d  Table: 87a48019  DAC: 00000015
Process modprobe (pid: 480, stack limit = 0xc7a2e2e8)
Stack: (0xc7a2fd30 to 0xc7a30000)
fd20:                                     00000010 000000d0 00000000 
00022000
fd40: bf03f598 6146203a 64656c69 6e797320 6e692063 61206f66 636f6c6c 
6e65706f
fd60: 74786520 616e7265 4344206c 00000022 00000000 00000002 c03e7280 
bf018e90
fd80: c03e7280 bf0180a0 00000000 00000004 00022000 c7b723c8 00002000 
c7876580
fda0: bf033a68 000000d0 00000010 48088028 00000008 fa088028 bf03f598 
bf0181ac
fdc0: 000002b6 00000059 00000000 00022000 00000004 48088028 c7b723c8 
fa088028
fde0: c7878c80 bf01e5fc 00000038 00000000 00020000 bf00d050 bf040628 
00022000
fe00: 00000004 48088028 bf0405d0 00000000 00000000 bf032358 bf040624 
c7a2fe2c
fe20: 00000000 bf0170c4 bf033a0c 48088028 00000003 00000000 c7a2fe4c 
bf03f8f6
fe40: 00000001 bf01b598 bf0405d0 00000000 00000001 bf01b5fc bf03f598 
00000000
fe60: 00000001 bf03f590 00000000 c7a2fe68 bf03f598 c01af2a0 bf03f598 
c01ae494
fe80: 00000000 c01ae6f4 bf03f598 00000000 c03e7280 c01ad670 c7803b08 
c7a223f4
fea0: bf03f598 bf03f5cc 00000000 c01ae638 00000000 bf03f598 00000000 
c01ad610
fec0: 00000000 c01ac224 000000d0 c03dc848 00000000 bf03f5a0 00000000 
c0163f94
fee0: 00000000 00000000 bf03f590 00000000 401f0008 c03e7280 00000000 
bf049000
ff00: 00000002 c01af644 00000000 bf03f64c 000cf1b2 401f0008 c03e7280 
bf0491a0
ff20: bf03f4dc bf049248 00000036 00000036 00000000 bf03f4dc bf033df0 
00000000
ff40: bf03e294 00000002 00000000 00000000 00000000 c002a344 bf049000 
00000000
ff60: 00000001 00000000 00000000 bf03f64c 000cf1b2 401f0008 c002af68 
c7a2e000
ff80: 00000000 c0073a5c 401f0008 0013ec61 000cf1b2 000e7600 401f0008 
000e76f0
ffa0: 00000080 c002adc0 000e7600 401f0008 401f0008 0013ec61 000cf1b2 
00000000
ffc0: 000e7600 401f0008 000e76f0 00000080 00000000 000000a4 00000000 
00000002
ffe0: 00000000 be8ae924 0001f250 4018e884 60000010 401f0008 8133df20 
04fbef0b
[<c01670f8>] (strcpy+0x4/0x18) from [<bf01a134>] 
(HAPFlagsToString+0x214/0x228 [pvrs)
[<bf01a134>] (HAPFlagsToString+0x214/0x228 [pvrsrvkm]) from [<bf018e90>] 
(DebugLinux)
[<bf018e90>] (DebugLinuxMemAreaRecordAdd+0x154/0x1b8 [pvrsrvkm]) from 
[<bf0181ac>] ()
[<bf0181ac>] (NewIORemapLinuxMemArea+0xbc/0xd4 [pvrsrvkm]) from 
[<bf01e5fc>] (OSRese)
[<bf01e5fc>] (OSReservePhys+0xd4/0x18c [pvrsrvkm]) from [<bf032358>] 
(SysInitialise+)
[<bf032358>] (SysInitialise+0x294/0x71c [pvrsrvkm]) from [<bf01b5fc>] 
(PVRSRVDriverP)
[<bf01b5fc>] (PVRSRVDriverProbe+0x80/0xb0 [pvrsrvkm]) from [<c01af2a0>] 
(platform_dr)
[<c01af2a0>] (platform_drv_probe+0x18/0x1c) from [<c01ae494>] 
(driver_probe_device+0)
[<c01ae494>] (driver_probe_device+0xa0/0x14c) from [<c01ad670>] 
(bus_for_each_drv+0x)
[<c01ad670>] (bus_for_each_drv+0x44/0x80) from [<c01ae638>] 
(device_attach+0x50/0x68)
[<c01ae638>] (device_attach+0x50/0x68) from [<c01ad610>] 
(bus_probe_device+0x24/0x40)
[<c01ad610>] (bus_probe_device+0x24/0x40) from [<c01ac224>] 
(device_add+0x2f8/0x450)
[<c01ac224>] (device_add+0x2f8/0x450) from [<c01af644>] 
(platform_device_add+0xf4/0x)
[<c01af644>] (platform_device_add+0xf4/0x150) from [<bf0491a0>] 
(PVRCore_Init+0x1a0/)
[<bf0491a0>] (PVRCore_Init+0x1a0/0x248 [pvrsrvkm]) from [<c002a344>] 
(do_one_initcal)
[<c002a344>] (do_one_initcall+0x54/0x190) from [<c0073a5c>] 
(sys_init_module+0xb8/0x)
[<c0073a5c>] (sys_init_module+0xb8/0x1e4) from [<c002adc0>] 
(ret_fast_syscall+0x0/0x)
Code: e8bd87f0 00100100 00200200 e1a02000 (e4d13001)
---[ end trace f9c506cb7cb4a23a ]---
Segmentation fault


Any help or suggestion is appreciated,
Peter

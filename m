From: Kan-Ru Chen <kanru@0xlab.org>
Subject: Re: [PATCH 00/14] Multiple fixes for Devkit8000
Date: Wed, 19 May 2010 12:02:43 +0800
Message-ID: <87vdakbkt8.fsf@anar.kanru.info>
References: <1274184335-29322-1-git-send-email-weber@corscience.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cp20.secserverpros.com ([67.220.217.187]:54310 "EHLO
	cp20.secserverpros.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750711Ab0ESEC3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 May 2010 00:02:29 -0400
Received: from 61-30-10-70.static.tfn.net.tw ([61.30.10.70] helo=kanru.info)
	by cp20.secserverpros.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <kanru@kanru.info>)
	id 1OEaUC-0008G7-2S
	for linux-omap@vger.kernel.org; Wed, 19 May 2010 04:02:27 +0000
In-Reply-To: <1274184335-29322-1-git-send-email-weber@corscience.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, Thomas Weber <weber@corscience.de>

--=-=-=

On Tue, 18 May 2010 14:05:21 +0200, Thomas Weber <weber@corscience.de> wrote:
> Some of these patches were submitted earlier but got no comments
> so I am sending them one more time. 
> 
> These patches correct errors that were done while using the board code
> from beagle board for Devkit8000. 
> 
> The Devkit8000 uses the TPS65930, an reduced version of the TWL4030. 
> So not all power supplies from the TWL4030 are available.
> There were also a wrong comment about the pins supported by the vmmc1. 
> The DSS2 do not need a VDVI any longer so it is removed. 
> The definition of the supplies are changed to use the new REGULATOR_SUPPLY macro.
> The pins for lcd and dvi powerdown are corrected.
> 
> 
> Kan-Ru Chen (1):
>   OMAP2: Devkit8000: Setup LCD reset
> 
> Thomas Weber (13):
>   OMAP2: Devkit8000: Cleanup for supplies
>   OMAP2: Devkit8000: change lcd panel to generic
>   OMAP2: Devkit8000: Enable DVI-D output
>   OMAP2: Devkit8000: Remove unneeded VDVI
>   OMAP2: Devkit8000: Remove nonexisting vsim
>   OMAP2: Devkit8000: Remove en-/disable for tv panel
>   OMAP2: Devkit8000: Use the REGULATOR_SUPPLY macro
>   OMAP2: Devkit8000: Fixing comment about pins used
>   OMAP2: Devkit8000: Fix whitespace with tab
>   OMAP2: Devkit8000: Fix comment
>   OMAP2: Devkit8000: Using gpio_is_valid
>   OMAP2: Devkit8000: Remove unused omap_board_config
>   OMAP2: Devkit8000: Correct regulator
> 
>  arch/arm/mach-omap2/board-devkit8000.c |  125 +++++++++++++++-----------------
>  1 files changed, 58 insertions(+), 67 deletions(-)
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Tested on Devkit8000 rev 1.

Boots fine, framebuffer failed due to recent LMB update.

Respect to the regulators there are some errors might be related:

<7>[    1.246459] ehci-omap ehci-omap.0: failed to get ehci port0 regulator
<4>[    1.662811] regulator_init_complete: incomplete constraints, leaving VDAC on

The usb port still works and is stable, but can't be probed after soft
reboot.

Otherwise looks good to me.

Tested-by: Kan-Ru Chen <kanru@0xlab.org>

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline; filename=dmesg
Content-Transfer-Encoding: quoted-printable
Content-Description: dmesg

<6>[    0.000000] Dentry cache hash table entries: 16384 (order: 4, 65536 b=
ytes)
<6>[    0.000000] Inode-cache hash table entries: 8192 (order: 3, 32768 byt=
es)
<6>[    0.000000] Memory: 128MB =3D 128MB total
<5>[    0.000000] Memory: 123860k/123860k available, 7212k reserved, 0K hig=
hmem
<5>[    0.000000] Virtual kernel memory layout:
<5>[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
<5>[    0.000000]     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
<5>[    0.000000]     DMA     : 0xffc00000 - 0xffe00000   (   2 MB)
<5>[    0.000000]     vmalloc : 0xc8800000 - 0xf8000000   ( 760 MB)
<5>[    0.000000]     lowmem  : 0xc0000000 - 0xc8000000   ( 128 MB)
<5>[    0.000000]     modules : 0xbf000000 - 0xc0000000   (  16 MB)
<5>[    0.000000]       .init : 0xc0008000 - 0xc017a000   (1480 kB)
<5>[    0.000000]       .text : 0xc017a000 - 0xc0579000   (4092 kB)
<5>[    0.000000]       .data : 0xc059a000 - 0xc05ce900   ( 211 kB)
<6>[    0.000000] Hierarchical RCU implementation.
<6>[    0.000000] NR_IRQS:402
<6>[    0.000000] Clocking rate (Crystal/Core/MPU): 26.0/266/500 MHz
<6>[    0.000000] Reprogramming SDRC clock to 266000000 Hz
<3>[    0.000000] dpll3_m2_clk rate change failed: -22
<6>[    0.000000] GPMC revision 5.0
<6>[    0.000000] IRQ: Found an INTC at 0xfa200000 (revision 4.0) with 96 i=
nterrupts
<6>[    0.000000] Total of 96 interrupts on 1 active controller
<6>[    0.000000] OMAP GPIO hardware version 2.5
<6>[    0.000000] OMAP clockevent source: GPTIMER12 at 32768 Hz
<4>[    0.000000] Console: colour dummy device 80x30
<6>[    0.000000] Calibrating delay loop... 504.17 BogoMIPS (lpj=3D1970176)
<4>[    0.000000] Mount-cache hash table entries: 512
<6>[    0.000000] CPU: Testing write buffer coherency: ok
<6>[    0.000000] regulator: core version 0.5
<6>[    0.000000] NET: Registered protocol family 16
<7>[    0.000000] mux: Setting signal i2c3_scl.i2c3_scl 0x0100 -> 0x0100
<7>[    0.000000] mux: Setting signal i2c3_sda.i2c3_sda 0x0100 -> 0x0100
<7>[    0.000000] mux: Setting signal etk_clk.hsusb1_stp 0x0003 -> 0x0003
<7>[    0.000000] mux: Setting signal etk_ctl.hsusb1_clk 0x0103 -> 0x0003
<7>[    0.000000] mux: Setting signal etk_d8.hsusb1_dir 0x0103 -> 0x010b
<7>[    0.000000] mux: Setting signal etk_d9.hsusb1_nxt 0x0103 -> 0x010b
<7>[    0.000000] mux: Setting signal etk_d0.hsusb1_data0 0x0103 -> 0x010b
<7>[    0.000000] mux: Setting signal etk_d1.hsusb1_data1 0x0103 -> 0x010b
<7>[    0.000000] mux: Setting signal etk_d2.hsusb1_data2 0x0103 -> 0x010b
<7>[    0.000000] mux: Setting signal etk_d7.hsusb1_data3 0x0103 -> 0x010b
<7>[    0.000000] mux: Setting signal etk_d4.hsusb1_data4 0x0103 -> 0x010b
<7>[    0.000000] mux: Setting signal etk_d5.hsusb1_data5 0x0103 -> 0x010b
<7>[    0.000000] mux: Setting signal etk_d6.hsusb1_data6 0x0103 -> 0x010b
<7>[    0.000000] mux: Setting signal etk_d3.hsusb1_data7 0x0103 -> 0x010b
<6>[    0.000000] Found NAND on CS0
<6>[    0.000000] Registering NAND on CS0
<7>[    0.000000] mux: Setting signal sdrc_cke0.sdrc_cke0 0x0118 -> 0x0000
<7>[    0.000000] mux: Setting signal sdrc_cke1.sdrc_cke1 0x0107 -> 0x0000
<6>[    0.000030] OMAP DMA hardware revision 4.0
<4>[    0.017486] bio: create slab <bio-0> at 0
<5>[    0.020843] SCSI subsystem initialized
<6>[    0.023376] usbcore: registered new interface driver usbfs
<6>[    0.023620] usbcore: registered new interface driver hub
<6>[    0.023895] usbcore: registered new device driver usb
<6>[    0.024780] i2c_omap i2c_omap.1: bus 1 rev3.12 at 2600 kHz
<6>[    0.028167] twl4030: PIH (irq 7) chaining IRQs 368..375
<6>[    0.028198] twl4030: power (irq 373) chaining IRQs 376..383
<6>[    0.028808] twl4030: gpio (irq 368) chaining IRQs 384..401
<7>[    0.029022] mux: Setting signal etk_d15.gpio29 0x011c -> 0x0104
<7>[    0.029083] mux: Setting signal etk_d15.gpio29 0x0104 -> 0x011c
<7>[    0.029296] mux: Setting signal sdmmc1_clk.sdmmc1_clk 0x0100 -> 0x0118
<7>[    0.029449] mux: Setting signal sdmmc1_cmd.sdmmc1_cmd 0x0100 -> 0x0118
<7>[    0.029571] mux: Setting signal sdmmc1_dat0.sdmmc1_dat0 0x0100 -> 0x0=
118
<7>[    0.029663] mux: Setting signal sdmmc1_dat1.sdmmc1_dat1 0x0100 -> 0x0=
118
<7>[    0.029785] mux: Setting signal sdmmc1_dat2.sdmmc1_dat2 0x0100 -> 0x0=
118
<7>[    0.029876] mux: Setting signal sdmmc1_dat3.sdmmc1_dat3 0x0100 -> 0x0=
118
<7>[    0.029968] mux: Setting signal sdmmc1_dat4.sdmmc1_dat4 0x0100 -> 0x0=
118
<7>[    0.030090] mux: Setting signal sdmmc1_dat5.sdmmc1_dat5 0x0100 -> 0x0=
118
<7>[    0.030181] mux: Setting signal sdmmc1_dat6.sdmmc1_dat6 0x0100 -> 0x0=
118
<7>[    0.030303] mux: Setting signal sdmmc1_dat7.sdmmc1_dat7 0x0100 -> 0x0=
118
<6>[    0.032287] regulator: VUSB1V5: 1500 mV normal standby
<6>[    0.032928] regulator: VUSB1V8: 1800 mV normal standby
<6>[    0.033569] regulator: VUSB3V1: 3100 mV normal standby
<7>[    0.035247] twl4030_usb twl4030_usb: HW_CONDITIONS 0xc0/192; link 1
<6>[    0.038208] twl4030_usb twl4030_usb: Initialized TWL4030 USB module
<6>[    0.039398] regulator: VPLL1: 1800 mV normal standby
<6>[    0.041320] regulator: VIO: 1800 mV normal standby
<6>[    0.042053] regulator: VMMC1: 1850 <--> 3150 mV at 3000 mV normal sta=
ndby
<6>[    0.042694] regulator: VDAC: 1800 mV normal standby
<6>[    0.042999] i2c_omap i2c_omap.3: bus 3 rev3.12 at 400 kHz
<6>[    0.044769] Advanced Linux Sound Architecture Driver Version 1.0.22.1.
<6>[    0.045654] NET: Registered protocol family 23
<6>[    0.045745] Bluetooth: Core ver 2.15
<6>[    0.046081] NET: Registered protocol family 31
<6>[    0.046081] Bluetooth: HCI device and connection manager initialized
<6>[    0.046112] Bluetooth: HCI socket layer initialized
<6>[    0.046142] Switching to clocksource 32k_counter
<6>[    0.048461] musb_hdrc: version 6.0, musb-dma, otg (peripheral+host), =
debug=3D0
<7>[    0.048614] HS USB OTG: revision 0x33, sysconfig 0x2010, sysstatus 0x=
1, intrfsel 0x1, simenable  0x0
<7>[    0.048675] musb_hdrc: ConfigData=3D0xde (UTMI-8, dyn FIFOs, bulk com=
bine, bulk split, HB-ISO Rx, HB-ISO Tx, SoftConn)
<7>[    0.048706] musb_hdrc: MHDRC RTL version 1.400=20
<7>[    0.048706] musb_hdrc: setup fifo_mode 4
<7>[    0.048736] musb_hdrc: 28/31 max ep, 16384/16384 memory
<6>[    0.048889] musb_hdrc musb_hdrc: USB OTG mode controller at fa0ab000 =
using DMA, IRQ 92
<6>[    0.049377] NET: Registered protocol family 2
<6>[    0.049591] IP route cache hash table entries: 1024 (order: 0, 4096 b=
ytes)
<6>[    0.050170] TCP established hash table entries: 4096 (order: 3, 32768=
 bytes)
<6>[    0.050292] TCP bind hash table entries: 4096 (order: 2, 16384 bytes)
<6>[    0.050354] TCP: Hash tables configured (established 4096 bind 4096)
<6>[    0.050384] TCP reno registered
<6>[    0.050384] UDP hash table entries: 256 (order: 0, 4096 bytes)
<6>[    0.050445] UDP-Lite hash table entries: 256 (order: 0, 4096 bytes)
<6>[    0.050689] NET: Registered protocol family 1
<6>[    0.051086] RPC: Registered udp transport module.
<6>[    0.051086] RPC: Registered tcp transport module.
<6>[    0.051116] RPC: Registered tcp NFSv4.1 backchannel transport module.
<4>[    0.065979] NetWinder Floating Point Emulator V0.97 (double precision)
<5>[    0.067993] VFS: Disk quotas dquot_6.5.2
<4>[    0.068115] Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
<6>[    0.069366] JFFS2 version 2.2. (NAND) =EF=BF=BD=EF=BF=BD 2001-2006 Re=
d Hat, Inc.
<6>[    0.070098] msgmni has been set to 241
<6>[    0.073669] alg: No test for stdrng (krng)
<6>[    0.073791] io scheduler noop registered
<6>[    0.073791] io scheduler deadline registered
<6>[    0.073974] io scheduler cfq registered (default)
<6>[    0.132751] OMAP DSS rev 2.0
<6>[    0.132873] OMAP DISPC rev 3.0
<6>[    0.132934] OMAP VENC rev 2
<6>[    0.481719] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
<6>[    0.504150] serial8250.0: ttyS0 at MMIO 0x4806a000 (irq =3D 72) is a =
ST16654
<6>[    0.525360] serial8250.1: ttyS1 at MMIO 0x4806c000 (irq =3D 73) is a =
ST16654
<6>[    0.546508] serial8250.2: ttyS2 at MMIO 0x49020000 (irq =3D 74) is a =
ST16654
<6>[    1.083068] console [ttyS2] enabled
<6>[    1.098815] brd: module loaded
<6>[    1.108245] loop: module loaded
<6>[    1.114044] omap2-nand driver initializing
<4>[    1.118469] omap2-nand: probe of omap2-nand failed with error -16
<6>[    1.125579] dm9000 Ethernet Driver, V1.31
<4>[    1.218383] dm9000 dm9000: eth%d: Invalid ethernet MAC address. Pleas=
e set using ifconfig
<6>[    1.227355] eth0: dm9000a at c88bc000,c88c0400 IRQ 185 MAC: 00:00:00:=
00:00:00 (chip)
<5>[    1.235443] usbmon: debugfs is not available
<6>[    1.239746] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
<7>[    1.246368] ehci_hcd: block sizes: qh 60 qtd 96 itd 160 sitd 96
<7>[    1.246459] ehci-omap ehci-omap.0: failed to get ehci port0 regulator
<7>[    1.246490] ehci-omap ehci-omap.0: starting TI EHCI USB Controller
<7>[    1.246704] ehci-omap ehci-omap.0: TLL RESET DONE
<7>[    1.246704] ehci-omap ehci-omap.0: OMAP3 ES version > ES2.1
<7>[    1.246734] ehci-omap ehci-omap.0: UHH setup done, uhh_hostconfig=3D1=
1c
<7>[    1.246765] ehci-omap ehci-omap.0: reset hcs_params 0x1313 dbg=3D0 cc=
=3D1 pcc=3D3 ordered ports=3D3
<7>[    1.246795] ehci-omap ehci-omap.0: reset hcc_params 0016 thresh 1 ufr=
ames 256/512/1024 park
<6>[    1.246795] ehci-omap ehci-omap.0: OMAP-EHCI Host Controller
<6>[    1.252563] ehci-omap ehci-omap.0: new USB bus registered, assigned b=
us number 1
<7>[    1.260192] ehci-omap ehci-omap.0: park 0
<6>[    1.260223] ehci-omap ehci-omap.0: irq 77, io mem 0x48064800
<7>[    1.265991] ehci-omap ehci-omap.0: reset command 080b02 park=3D3 ithr=
esh=3D8 period=3D1024 Reset HALT
<7>[    1.266021] ehci-omap ehci-omap.0: init command 010009 (park)=3D0 ith=
resh=3D1 period=3D256 RUN
<6>[    1.280761] ehci-omap ehci-omap.0: USB 2.0 started, EHCI 1.00
<7>[    1.286651] usb usb1: default language 0x0409
<7>[    1.286682] usb usb1: udev 1, busnum 1, minor =3D 0
<6>[    1.286712] usb usb1: New USB device found, idVendor=3D1d6b, idProduc=
t=3D0002
<6>[    1.293579] usb usb1: New USB device strings: Mfr=3D3, Product=3D2, S=
erialNumber=3D1
<6>[    1.300872] usb usb1: Product: OMAP-EHCI Host Controller
<6>[    1.306243] usb usb1: Manufacturer: Linux 2.6.34-08151-g1674c0c-dirty=
 ehci_hcd
<6>[    1.313537] usb usb1: SerialNumber: ehci-omap.0
<7>[    1.318634] usb usb1: usb_probe_device
<7>[    1.318664] usb usb1: configuration #1 chosen from 1 choice
<7>[    1.318725] usb usb1: adding 1-0:1.0 (config #1, interface 0)
<7>[    1.319091] hub 1-0:1.0: usb_probe_interface
<7>[    1.319091] hub 1-0:1.0: usb_probe_interface - got id
<6>[    1.319122] hub 1-0:1.0: USB hub found
<6>[    1.322967] hub 1-0:1.0: 3 ports detected
<7>[    1.327026] hub 1-0:1.0: standalone hub
<7>[    1.327026] hub 1-0:1.0: individual port power switching
<7>[    1.327026] hub 1-0:1.0: individual port over-current protection
<7>[    1.327056] hub 1-0:1.0: power on to power good time: 20ms
<7>[    1.327087] hub 1-0:1.0: local power source is good
<7>[    1.327117] hub 1-0:1.0: enabling power on all ports
<4>[    1.327697] g_ether gadget: using random self ethernet address
<4>[    1.333587] g_ether gadget: using random host ethernet address
<6>[    1.340148] usb0: MAC 9a:73:ca:93:bd:f3
<6>[    1.344085] usb0: HOST MAC 6a:c4:e3:40:3a:9d
<7>[    1.348388] g_ether gadget: adding config #1 'CDC Ethernet (ECM)'/c05=
c6c84
<7>[    1.348419] g_ether gadget: adding 'cdc_ethernet'/c7edf680 to config =
'CDC Ethernet (ECM)'/c05c6c84
<7>[    1.348449] g_ether gadget: CDC Ethernet: dual speed IN/ep1in OUT/ep1=
out NOTIFY/ep2in
<7>[    1.348480] g_ether gadget: cfg 1/c05c6c84 speeds: high full
<7>[    1.348480] g_ether gadget:   interface 0 =3D cdc_ethernet/c7edf680
<7>[    1.348510] g_ether gadget:   interface 1 =3D cdc_ethernet/c7edf680
<6>[    1.348541] g_ether gadget: Ethernet Gadget, version: Memorial Day 20=
08
<6>[    1.355224] g_ether gadget: g_ether ready
<6>[    1.359283] musb_hdrc musb_hdrc: MUSB HDRC host driver
<6>[    1.364501] musb_hdrc musb_hdrc: new USB bus registered, assigned bus=
 number 2
<7>[    1.371856] usb usb2: default language 0x0409
<7>[    1.371917] usb usb2: udev 1, busnum 2, minor =3D 128
<6>[    1.371917] usb usb2: New USB device found, idVendor=3D1d6b, idProduc=
t=3D0002
<6>[    1.378784] usb usb2: New USB device strings: Mfr=3D3, Product=3D2, S=
erialNumber=3D1
<6>[    1.386077] usb usb2: Product: MUSB HDRC host driver
<6>[    1.391082] usb usb2: Manufacturer: Linux 2.6.34-08151-g1674c0c-dirty=
 musb-hcd
<6>[    1.398376] usb usb2: SerialNumber: musb_hdrc
<7>[    1.403289] usb usb2: usb_probe_device
<7>[    1.403320] usb usb2: configuration #1 chosen from 1 choice
<7>[    1.403381] usb usb2: adding 2-0:1.0 (config #1, interface 0)
<7>[    1.403717] hub 2-0:1.0: usb_probe_interface
<7>[    1.403717] hub 2-0:1.0: usb_probe_interface - got id
<6>[    1.403747] hub 2-0:1.0: USB hub found
<6>[    1.407592] hub 2-0:1.0: 1 port detected
<7>[    1.411529] hub 2-0:1.0: standalone hub
<7>[    1.411560] hub 2-0:1.0: individual port power switching
<7>[    1.411560] hub 2-0:1.0: no over-current protection
<7>[    1.411590] hub 2-0:1.0: power on to power good time: 10ms
<7>[    1.411621] hub 2-0:1.0: 100mA bus power budget for each child
<7>[    1.411621] hub 2-0:1.0: local power source is good
<7>[    1.411651] hub 2-0:1.0: enabling power on all ports
<6>[    1.413177] input: TWL4030 Keypad as /devices/platform/i2c_omap.1/i2c=
-1/1-004a/twl4030_keypad/input/input0
<7>[    1.423309] hub 1-0:1.0: state 7 ports 3 chg 0000 evt 0000
<6>[    1.425048] ads7846 spi2.0: touchscreen, irq 187
<6>[    1.430603] input: ADS7846 Touchscreen as /devices/platform/omap2_mcs=
pi.2/spi2.0/input/input1
<6>[    1.440277] twl_rtc twl_rtc: rtc core: registered twl_rtc as rtc0
<4>[    1.446594] twl_rtc twl_rtc: Power up reset detected.
<6>[    1.452056] twl_rtc twl_rtc: Enabling TWL-RTC.
<6>[    1.457183] i2c /dev entries driver
<6>[    1.462158] sdhci: Secure Digital Host Controller Interface driver
<6>[    1.468444] sdhci: Copyright(c) Pierre Ossman
<7>[    1.475250] Registered led device: led1
<7>[    1.475616] Registered led device: led2
<7>[    1.476989] Registered led device: ledB
<7>[    1.477233] Registered led device: led3
<6>[    1.478332] usbcore: registered new interface driver usbhid
<6>[    1.484039] usbhid: USB HID core driver
<7>[    1.508728] hub 2-0:1.0: state 7 ports 1 chg 0000 evt 0000
<4>[    1.568145] No device for DAI omap-mcbsp-dai-0
<4>[    1.572662] No device for DAI omap-mcbsp-dai-1
<4>[    1.577117] No device for DAI omap-mcbsp-dai-2
<4>[    1.581634] No device for DAI omap-mcbsp-dai-3
<4>[    1.586120] No device for DAI omap-mcbsp-dai-4
<6>[    1.590606] OMAP3 Beagle/Devkit8000 SoC init
<6>[    1.596801] asoc: twl4030 <-> omap-mcbsp-dai-0 mapping ok
<6>[    1.606079] ALSA device list:
<6>[    1.609161]   #0: omap3beagle (twl4030)
<6>[    1.613281] TCP cubic registered
<6>[    1.616516] NET: Registered protocol family 17
<6>[    1.621124] NET: Registered protocol family 15
<3>[    1.626251] Power Management for TI OMAP3.
<6>[    1.630706] VFP support v0.3: implementor 41 architecture 3 part 30 v=
ariant c rev 1
<3>[    1.641723] omapfb omapfb: failed to allocate framebuffer
<3>[    1.647155] omapfb omapfb: failed to allocate fbmem
<3>[    1.652130] omapfb omapfb: failed to setup omapfb
<4>[    1.656921] omapfb: probe of omapfb failed with error -12
<4>[    1.662811] regulator_init_complete: incomplete constraints, leaving =
VDAC on
<6>[    1.671600] twl_rtc twl_rtc: setting system clock to 2000-01-01 00:00=
:00 UTC (946684800)
<6>[    1.695281] Freeing init memory: 1480K
<6>[    1.741821] mmc0: new high speed SD card at address 0002
<6>[    1.747894] mmcblk0: mmc0:0002 N/A   242 MiB=20
<6>[    1.752655]  mmcblk0: p1 p2
<6>[    1.848663] g_ether gadget: high speed config #1: CDC Ethernet (ECM)
<7>[    1.855072] musb_hdrc periph: enabled ep2in for int IN, dma, maxpacke=
t 16
<7>[    1.855102] g_ether gadget: init ecm
<7>[    1.855133] g_ether gadget: notify connect false
<7>[    1.855163] g_ether gadget: notify speed 425984000
<7>[    1.855682] g_ether gadget: activate ecm
<7>[    1.855712] musb_hdrc periph: enabled ep1in for bulk IN, dma, maxpack=
et 512
<7>[    1.855712] musb_hdrc periph: enabled ep1out for bulk OUT, dma, maxpa=
cket 512
<7>[    1.855743] usb0: qlen 10
<7>[    1.855773] g_ether gadget: ecm_close
<7>[    1.954254] g_ether gadget: notify connect false
<7>[    1.954284] g_ether gadget: notify speed 425984000

--=-=-=--

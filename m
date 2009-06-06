From: Kalle Valo <kalle.valo@iki.fi>
Subject: n800 can't mount rootfs
Date: Sat, 06 Jun 2009 10:43:54 +0300
Message-ID: <87d49h4xj9.fsf@litku.valot.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f213.google.com ([209.85.220.213]:39978 "EHLO
	mail-fx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750727AbZFFHn4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 6 Jun 2009 03:43:56 -0400
Received: by fxm9 with SMTP id 9so1026451fxm.37
        for <linux-omap@vger.kernel.org>; Sat, 06 Jun 2009 00:43:56 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hello,

I tested linux-omap (commit 151c7a7fc) on n800 and it can't mount rootf=
s
anymore. Below is the full bootlog.=20

Unfortunately I don't have time to debug this right now, but I can test
patches if needed.

[    0.000000] Linux version 2.6.30-rc8-omap1 (kvalo@tikku) (gcc versio=
n
4.3.2 (Sourcery G++ Lite 2008q3-66) ) #2 Sat Jun 6 10:28:29 EEST 2009
[    0.000000] CPU: ARMv6-compatible processor [4107b362] revision 2
(ARMv6TEJ), cr=3D00c5387f
[    0.000000] CPU: VIPT aliasing data cache, VIPT aliasing instruction
cache
[    0.000000] Machine: Nokia N800
[    0.000000] Memory policy: ECC disabled, Data cache writeback
[    0.000000] OMAP2420<6>
[    0.000000] SRAM: Mapped pa 0x40200000 to va 0xe3000000 size:
0x100000
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.
Total pages: 32512
[    0.000000] Kernel command line: root=3D1f03 rootfstype=3Djffs2
[    0.000000] NR_IRQS:368
[    0.000000] Clocking rate (Crystal/DPLL/MPU): 19.2/658/329 MHz
[    0.000000] GPMC revision 2.0
[    0.000000] IRQ: Found an INTC at 0xd80fe000 (revision 2.0) with 96
interrupts
[    0.000000] Total of 96 interrupts on 1 active controller
[    0.000000] OMAP242x GPIO hardware version 1.8
[    0.000000] PID hash table entries: 512 (order: 9, 2048 bytes)
[    0.000000] OMAP clockevent source: GPTIMER1 at 32000 Hz
[    0.000000] Console: colour dummy device 80x30
[    0.000000] Dentry cache hash table entries: 16384 (order: 4, 65536
bytes)
[    0.000000] Inode-cache hash table entries: 8192 (order: 3, 32768
bytes)
[    0.000000] Memory: 64MB 64MB =3D 128MB total
[    0.000000] Memory: 126392KB available (2896K code, 238K data, 120K
init, 0K highmem)
[    0.000000] Calibrating delay loop... 320.37 BogoMIPS (lpj=3D1253376=
)
[    0.000000] Security Framework initialized
[    0.000000] Mount-cache hash table entries: 512
[    0.000000] CPU: Testing write buffer coherency: ok
[    0.000000] net_namespace: 668 bytes
[    0.000000] NET: Registered protocol family 16
[    0.000000] TUSB 6010
[    0.000000] kobject (c031e048): tried to init an initialized object,
something is seriously wrong.
[    0.000000] [<c002c674>] (unwind_backtrace+0x0/0xdc) from
[<c0103654>] (kobject_init+0x38/0x70)
[    0.000000] [<c0103654>] (kobject_init+0x38/0x70) from [<c013fbfc>]
(device_initialize+0x20/0x70)
[    0.000000] [<c013fbfc>] (device_initialize+0x20/0x70) from
[<c0143408>] (platform_device_register+0x10/0x1c)
[    0.000000] [<c0143408>] (platform_device_register+0x10/0x1c) from
[<c000e7a0>] (gpmc_onenand_init+0x4c/0x74)
[    0.000000] [<c000e7a0>] (gpmc_onenand_init+0x4c/0x74) from
[<c000b13c>] (customize_machine+0x18/0x24)
[    0.000000] [<c000b13c>] (customize_machine+0x18/0x24) from
[<c00262bc>] (do_one_initcall+0x54/0x194)
[    0.000000] [<c00262bc>] (do_one_initcall+0x54/0x194) from
[<c00083b8>] (kernel_init+0x70/0xe4)
[    0.000000] [<c00083b8>] (kernel_init+0x70/0xe4) from [<c004d498>]
(do_exit+0x0/0x580)
[    0.000000] [<c004d498>] (do_exit+0x0/0x580) from [<00000001>] (0x1)
[    0.000000] ------------[ cut here ]------------
[    0.000000] WARNING: at fs/sysfs/dir.c:487 sysfs_add_one+0x68/0x90()
[    0.000000] sysfs: cannot create duplicate filename
'/devices/platform/omap2-onenand'
[    0.000000] Modules linked in:
[    0.000000] [<c002c674>] (unwind_backtrace+0x0/0xdc) from
[<c004a974>] (warn_slowpath_common+0x48/0x60)
[    0.000000] [<c004a974>] (warn_slowpath_common+0x48/0x60) from
[<c004a9c4>] (warn_slowpath_fmt+0x24/0x30)
[    0.000000] [<c004a9c4>] (warn_slowpath_fmt+0x24/0x30) from
[<c00cfd3c>] (sysfs_add_one+0x68/0x90)
[    0.000000] [<c00cfd3c>] (sysfs_add_one+0x68/0x90) from [<c00d02e4>]
(create_dir+0x48/0x98)
[    0.000000] [<c00d02e4>] (create_dir+0x48/0x98) from [<c00d036c>]
(sysfs_create_dir+0x38/0x54)
[    0.000000] [<c00d036c>] (sysfs_create_dir+0x38/0x54) from
[<c0103948>] (kobject_add_internal+0xb8/0x18c)
[    0.000000] [<c0103948>] (kobject_add_internal+0xb8/0x18c) from
[<c0103b94>] (kobject_add+0x4c/0x5c)
[    0.000000] [<c0103b94>] (kobject_add+0x4c/0x5c) from [<c013ffa4>]
(device_add+0xac/0x554)
[    0.000000] [<c013ffa4>] (device_add+0xac/0x554) from [<c01433a0>]
(platform_device_add+0xec/0x144)
[    0.000000] [<c01433a0>] (platform_device_add+0xec/0x144) from
[<c000e7a0>] (gpmc_onenand_init+0x4c/0x74)
[    0.000000] [<c000e7a0>] (gpmc_onenand_init+0x4c/0x74) from
[<c000b13c>] (customize_machine+0x18/0x24)
[    0.000000] [<c000b13c>] (customize_machine+0x18/0x24) from
[<c00262bc>] (do_one_initcall+0x54/0x194)
[    0.000000] [<c00262bc>] (do_one_initcall+0x54/0x194) from
[<c00083b8>] (kernel_init+0x70/0xe4)
[    0.000000] [<c00083b8>] (kernel_init+0x70/0xe4) from [<c004d498>]
(do_exit+0x0/0x580)
[    0.000000] [<c004d498>] (do_exit+0x0/0x580) from [<00000001>] (0x1)
[    0.000000] ---[ end trace 1b75b31a2719ed1c ]---
[    0.000000] kobject_add_internal failed for omap2-onenand with
-EEXIST, don't try to register things with the same name in the same
directory.
[    0.000000] [<c002c674>] (unwind_backtrace+0x0/0xdc) from
[<c01039d4>] (kobject_add_internal+0x144/0x18c)
[    0.000000] [<c01039d4>] (kobject_add_internal+0x144/0x18c) from
[<c0103b94>] (kobject_add+0x4c/0x5c)
[    0.000000] [<c0103b94>] (kobject_add+0x4c/0x5c) from [<c013ffa4>]
(device_add+0xac/0x554)
[    0.000000] [<c013ffa4>] (device_add+0xac/0x554) from [<c01433a0>]
(platform_device_add+0xec/0x144)
[    0.000000] [<c01433a0>] (platform_device_add+0xec/0x144) from
[<c000e7a0>] (gpmc_onenand_init+0x4c/0x74)
[    0.000000] [<c000e7a0>] (gpmc_onenand_init+0x4c/0x74) from
[<c000b13c>] (customize_machine+0x18/0x24)
[    0.000000] [<c000b13c>] (customize_machine+0x18/0x24) from
[<c00262bc>] (do_one_initcall+0x54/0x194)
[    0.000000] [<c00262bc>] (do_one_initcall+0x54/0x194) from
[<c00083b8>] (kernel_init+0x70/0xe4)
[    0.000000] [<c00083b8>] (kernel_init+0x70/0xe4) from [<c004d498>]
(do_exit+0x0/0x580)
[    0.000000] [<c004d498>] (do_exit+0x0/0x580) from [<00000001>] (0x1)
[    0.000000] Unable to register OneNAND device
[    3.734191] OMAP DMA hardware revision 2.0
[    3.775543] bio: create slab <bio-0> at 0
[    3.776977] Tahvo/Betty driver initialising
[    3.778106] Betty v2.1 found
[    3.778808] Retu/Vilma driver initialising
[    3.779998] Vilma v1.5 found
[    3.783935] OMAP STI support loaded (HW v1.0)
[    3.794067] i2c_omap i2c_omap.1: bus 1 rev3.4 at 400 kHz
[    3.809356] i2c_omap i2c_omap.2: bus 2 rev3.4 at 400 kHz
[    3.813385] SCSI subsystem initialized
[    3.818634] usbcore: registered new interface driver usbfs
[    3.819580] usbcore: registered new interface driver hub
[    3.820312] usbcore: registered new device driver usb
[    3.824432] Bluetooth: Core ver 2.15
[    3.825225] NET: Registered protocol family 31
[    3.825256] Bluetooth: HCI device and connection manager initialized
[    3.825286] Bluetooth: HCI socket layer initialized
[    3.830200] musb_hdrc: version 6.0, tusb-omap-dma, otg
(peripheral+host), debug=3D0
[    3.832275] Switched to NOHz mode on CPU #0
[    3.840057] tusb: prcm2.0 int2.0 gpio2.0 dma2.0 dieid0 rev2.0
[    3.840118] drivers/usb/musb/tusb6010.c musb_platform_disable: dma
still active
[    3.841156] musb_hdrc: USB OTG mode controller at c8808000 using DMA=
,
IRQ 218
[    3.842285] NET: Registered protocol family 2
[    3.842620] IP route cache hash table entries: 1024 (order: 0, 4096
bytes)
[    3.843475] TCP established hash table entries: 4096 (order: 3, 3276=
8
bytes)
[    3.843750] TCP bind hash table entries: 4096 (order: 2, 16384 bytes=
)
[    3.843994] TCP: Hash tables configured (established 4096 bind 4096)
[    3.844024] TCP reno registered
[    3.844390] NET: Registered protocol family 1
[    3.848571] NetWinder Floating Point Emulator V0.97 (double
precision)
[    3.852691] JFFS2 version 2.2. (NAND) (SUMMARY)  =C2=A9 2001-2006 Re=
d
Hat, Inc.
[    3.853881] msgmni has been set to 247
[    3.854187] io scheduler noop registered (default)
[    3.855072] omapfb: ls041y3 rev 87 LCD detected
[    3.855377] omapfb: configured for panel ls041y3
[    3.869232] omapfb: DISPC version 2.0 initialized
[    3.869354] omapfb: RFBI version 1.0 initialized
[    3.887237] omapfb: s1d13744 LCD controller rev 0 initialized (CNF
pins 3)
[    3.887390] omapfb omapfb: s1d1374x: setting update mode to manual
[    3.889587] omapfb: Framebuffer initialized. Total vram 2310144
planes 3
[    3.889648] omapfb: Pixclock 21940 kHz hfreq 24.9 kHz vfreq 51.0 Hz
[    3.928344] Retu power button driver initialized
[    3.928375] retu: Registering interrupt 0 for device PwrOnX
[    3.929351] input: retu-pwrbutton as /class/input/input0
[    3.930541] retu: Registering interrupt 2 for device RTCS
[    3.930694] retu: Registering interrupt 5 for device RTCA
[    3.932159] Retu watchdog driver initialized
[    3.932220] Retu/Vilma headset driver initializing
[    3.933166] input: retu-headset as /class/input/input1
[    3.933288] retu: Registering interrupt 6 for device hookdet
[    3.933990] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[    3.960388] serial8250.0: ttyS0 at MMIO 0x4806e000 (irq =3D 74) is a
ST16654
[    3.960479] console [ttyS0] enabled
[    4.768798] brd: module loaded
[    4.782043] loop: module loaded
[    4.786315] Menelaus rev 2.2
[    4.802490] Driver 'sd' needs updating - please use bus_type methods
[    4.809509] PPP generic driver version 2.4.2
[    4.814849] PPP Deflate Compression module registered
[    4.820037] PPP BSD Compression module registered
[    4.824829] tun: Universal TUN/TAP device driver, 1.6
[    4.829925] tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
[    4.837524] OneNAND driver initializing
[    4.842041] TSC2301 driver initializing
[    4.857147] input: Internal keypad as /class/input/input2
[    4.863983] input: TSC2301 touchscreen as /class/input/input3
[    4.870269] usbmon: debugfs is not available
[    4.874664] Initializing USB Mass Storage driver...
[    4.880187] usbcore: registered new interface driver usb-storage
[    4.886260] USB Mass Storage support registered.
[    4.891510] usbcore: registered new interface driver libusual
[    4.897949] usbcore: registered new interface driver usbtest
[    4.904357] mice: PS/2 mouse device common for all mice
[    4.912719] TSC2005 driver initializing
[    4.917083] Linux video capture interface: v2.00
[    4.924041] OMAP Watchdog Timer Rev 0x11: initial timeout 60 sec
[    5.005096] omap_pwm_led omap_pwm_led: OMAP PWM LED (keypad) at GP
timer 10/9
[    5.013275] Registered led device: keypad
[    5.030822] usbcore: registered new interface driver usbhid
[    5.036560] usbhid: v2.6:USB HID core driver
[    5.045349] Advanced Linux Sound Architecture Driver Version 1.0.20.
[    5.051849] mmci-omap mmci-omap.0: command timeout (CMD8)
[    5.057312] ALSA device list:
[    5.060424]   No soundcards found.
[    5.064178] ip_tables: (C) 2000-2006 Netfilter Core Team
[    5.069702] TCP cubic registered
[    5.072967] NET: Registered protocol family 17
[    5.077545] Bluetooth: L2CAP ver 2.13
[    5.081237] Bluetooth: L2CAP socket layer initialized
[    5.086395] Bluetooth: SCO (Voice Link) ver 0.6
[    5.091003] Bluetooth: SCO socket layer initialized
[    5.096191] Bluetooth: RFCOMM socket layer initialized
[    5.101440] mmci-omap mmci-omap.0: command timeout (CMD5)
[    5.106994] Bluetooth: RFCOMM TTY layer initialized
[    5.111938] mmci-omap mmci-omap.0: command timeout (CMD5)
[    5.117462] Bluetooth: RFCOMM ver 1.11
[    5.121307] mmci-omap mmci-omap.0: command timeout (CMD5)
[    5.126739] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[    5.132141] mmci-omap mmci-omap.0: command timeout (CMD5)
[    5.137634] Bluetooth: HIDP (Human Interface Emulation) ver 1.2
[    5.144348] Disabling unused clock "uart2_fck"
[    5.148925] mmci-omap mmci-omap.0: command timeout (CMD55)
[    5.154541] Disabling unused clock "uart2_ick"
[    5.159027] Disabling unused clock "uart1_fck"
[    5.163543] Disabling unused clock "uart1_ick"
[    5.168029] Disabling unused clock "gpt12_fck"
[    5.172546] Disabling unused clock "gpt12_ick"
[    5.177032] Disabling unused clock "gpt11_fck"
[    5.181518] Disabling unused clock "gpt11_ick"
[    5.186035] Disabling unused clock "gpt8_fck"
[    5.190429] Disabling unused clock "gpt8_ick"
[    5.194824] Disabling unused clock "gpt7_fck"
[    5.199218] Disabling unused clock "gpt7_ick"
[    5.203643] Disabling unused clock "gpt6_fck"
[    5.208068] Disabling unused clock "gpt6_ick"
[    5.212463] Disabling unused clock "gpt5_fck"
[    5.216857] Disabling unused clock "gpt5_ick"
[    5.221252] Disabling unused clock "gpt4_fck"
[    5.225677] Disabling unused clock "gpt4_ick"
[    5.230072] Disabling unused clock "gpt3_fck"
[    5.234466] Disabling unused clock "gpt3_ick"
[    5.238891] Disabling unused clock "gpt2_fck"
[    5.243286] Disabling unused clock "gpt2_ick"
[    5.247711] Disabling unused clock "dss2_fck"
[    5.252136] Bootup reason: pwr_key
[    5.255676] OMAP GPIO switch handler initializing
[    5.261688] mmci-omap mmci-omap.0: command timeout (CMD55)
[    5.268341] mmci-omap mmci-omap.0: command timeout (CMD55)
[    5.274780] mmci-omap mmci-omap.0: command timeout (CMD55)
[    5.281158] mmci-omap mmci-omap.0: command timeout (CMD1)
[    5.287536] headphone (GPIO 107) is now disconnected
[    5.292541] cam_turn (GPIO 12) is now inactive
[    5.297088] cam_act (GPIO 95) is now inactive
[    5.301605] bat_cover (GPIO 110) is now closed
[    5.306091] VFP support v0.3: implementor 41 architecture 1 part 20
variant b rev 2
[    5.391265] mmci-omap mmci-omap.0: command timeout (CMD8)
[    5.396759] mmci-omap mmci-omap.0: command timeout (CMD8)
[    5.402526] omap24xxcam omap24xxcam: sensor is tcm825x
[    5.407714] mmci-omap mmci-omap.0: command timeout (CMD5)
[    5.413848] mmci-omap mmci-omap.0: command timeout (CMD5)
[    5.419311] mmci-omap mmci-omap.0: command timeout (CMD5)
[    5.425415] mmci-omap mmci-omap.0: command timeout (CMD5)
[    5.431549] mmci-omap mmci-omap.0: command timeout (CMD5)
[    5.436981] mmci-omap mmci-omap.0: command timeout (CMD5)
[    5.443237] mmci-omap mmci-omap.0: command timeout (CMD55)
[    5.448760] mmci-omap mmci-omap.0: command timeout (CMD55)
[    5.454986] mmci-omap mmci-omap.0: command timeout (CMD55)
[    5.460540] mmci-omap mmci-omap.0: command timeout (CMD55)
[    5.466796] mmci-omap mmci-omap.0: command timeout (CMD55)
[    5.472320] mmci-omap mmci-omap.0: command timeout (CMD55)
[    5.478546] mmci-omap mmci-omap.0: command timeout (CMD55)
[    5.484100] mmci-omap mmci-omap.0: command timeout (CMD55)
[    5.490478] mmci-omap mmci-omap.0: command timeout (CMD1)
[    5.495941] mmci-omap mmci-omap.0: command timeout (CMD1)
[    5.520629] omap24xxcam omap24xxcam: registered device video0
[    5.527893] VFS: Cannot open root device "1f03" or
unknown-block(31,3)
[    5.534484] Please append a correct "root=3D" boot option; here are =
the
available partitions:
[    5.542999] Kernel panic - not syncing: VFS: Unable to mount root fs
on unknown-block(31,3)
[    5.551452] [<c002c674>] (unwind_backtrace+0x0/0xdc) from
[<c024e4f0>] (panic+0x40/0x108)
[    5.559814] [<c024e4f0>] (panic+0x40/0x108) from [<c0008e08>]
(mount_block_root+0x25c/0x2ac)
[    5.568420] [<c0008e08>] (mount_block_root+0x25c/0x2ac) from
[<c0009020>] (prepare_namespace+0x164/0x1bc)
[    5.578125] [<c0009020>] (prepare_namespace+0x164/0x1bc) from
[<c0008400>] (kernel_init+0xb8/0xe4)
[    5.587249] [<c0008400>] (kernel_init+0xb8/0xe4) from [<c004d498>]
(do_exit+0x0/0x580)
[    5.595306] [<c004d498>] (do_exit+0x0/0x580) from [<00000001>] (0x1)


--=20
Kalle Valo
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

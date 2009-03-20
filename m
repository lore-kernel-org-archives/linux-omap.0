From: Ashwin Bihari <abihari@gmail.com>
Subject: Re: mmc0 detection timing at kernel startup, linux-omap-2.6.27-omap1
Date: Fri, 20 Mar 2009 09:34:06 -0400
Message-ID: <1f11a5490903200634y57f91639r3aad815aa2ce5e92@mail.gmail.com>
References: <dbdb2ea60903200606y51d3fba0ia5c116a3c452c21a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.30]:34084 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752582AbZCTNeJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Mar 2009 09:34:09 -0400
Received: by yw-out-2324.google.com with SMTP id 5so973646ywb.1
        for <linux-omap@vger.kernel.org>; Fri, 20 Mar 2009 06:34:06 -0700 (PDT)
In-Reply-To: <dbdb2ea60903200606y51d3fba0ia5c116a3c452c21a@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: twebb <taliaferro62@gmail.com>
Cc: "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>

You need to add the Kernel option "rootdelay=3D1" to basically delay th=
e
Kernel for a moment while attempting to using the SDcard as the RFS
mount point.

-- Ashwin



On Fri, Mar 20, 2009 at 9:06 AM, twebb <taliaferro62@gmail.com> wrote:
> I'm using linux-omap-2.6.27-omap1 and am seeing an apparent timing
> issue at kernel startup. =A0The board is an OMAP 35x EVM and is
> configured to boot from the SDcard. =A0Everything works find IF a
> keyboard is connected to the USB port of the EVM - the kernel detects
> the mmcblk0 device (SDcard) and all it's partitions, and mounts
> mmcblk0p1 appropriately as root. =A0However, if the keyboard is not
> installed the SDcard is not recognized and the kernel panics. =A0Same
> kernel, same kernel args, save everything - just different response
> based on whether keyboard is attached or not. =A0Any ideas? =A0I'm
> including the good and bad kernel startup logs below...
>
> Thanks,
> twebb
>
> ***** Good *****
> Linux version 2.6.27-omap1 (jb@jb) (gcc version 4.2.1 (CodeSourcery S=
ource
> ry G++ Lite 2007q3-51)) #16 Thu Mar 19 16:59:31 EDT 2009
> CPU: ARMv7 Processor [411fc082] revision 2 (ARMv7), cr=3D00c5387f
> Machine: OMAP3 EVM
> Memory policy: ECC disabled, Data cache writeback
> OMAP3430 ES2.1
> SRAM: Mapped pa 0x40200000 to va 0xd7000000 size: 0x100000
> CPU0: L1 I VIPT cache. Caches unified at level 2, coherent at level 3
> CPU0: Level 1 cache is separate instruction and data
> CPU0: I cache: 16384 bytes, associativity 4, 64 byte lines, 64 sets,
> =A0 =A0 =A0supports RA
> CPU0: D cache: 16384 bytes, associativity 4, 64 byte lines, 64 sets,
> =A0 =A0 =A0supports RA WB WT
> CPU0: Level 2 cache is unified
> CPU0: unified cache: 262144 bytes, associativity 8, 64 byte lines, 51=
2 sets,
> =A0 =A0 =A0supports WA RA WB WT
> Built 1 zonelists in Zone order, mobility grouping on. =A0Total pages=
: 32512
> Kernel command line: mem=3D128M console=3DttyS2,115200e8 noinitrd ini=
t=3Dinit root=3D/de
> v/mmcblk0p2 rw rootfstype=3Dext3
> Clocking rate (Crystal/DPLL/ARM core): 26.0/166/500 MHz
> GPMC revision 5.0
> IRQ: Found an INTC at 0xd8200000 (revision 4.0) with 96 interrupts
> Total of 96 interrupts on 1 active controller
> OMAP34xx GPIO hardware version 2.5
> PID hash table entries: 512 (order: 9, 2048 bytes)
> OMAP clockevent source: GPTIMER1 at 32768 Hz
> Console: colour dummy device 80x30
> Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
> Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
> Memory: 128MB =3D 128MB total
> Memory: 126108KB available (3048K code, 447K data, 148K init)
> Calibrating delay loop... 499.92 BogoMIPS (lpj=3D1949696)
> Mount-cache hash table entries: 512
> CPU: Testing write buffer coherency: ok
> net_namespace: 288 bytes
> android_power_init
> android_power_init done
> NET: Registered protocol family 16
> MUX: setup J21_34XX_I2C1_SDA (0xd80021bc): 0x1718 -> 0x0118
> MUX: setup K21_34XX_I2C1_SCL (0xd80021ba): 0x1718 -> 0x0118
> MUX: setup AE15_34XX_I2C2_SDA (0xd80021c0): 0x1718 -> 0x0118
> MUX: setup AF15_34XX_I2C2_SCL (0xd80021be): 0x1718 -> 0x0118
> MUX: setup AG14_34XX_I2C3_SDA (0xd80021c4): 0x1718 -> 0x0118
> MUX: setup AF14_34XX_I2C3_SCL (0xd80021c2): 0x1718 -> 0x0118
> OMAP DMA hardware revision 4.0
> USB: No board-specific platform config found
> i2c_omap i2c_omap.1: bus 1 rev3.12 at 2600 kHz
> twl4030: PIH (irq 7) chaining IRQs 368..375
> twl4030: power (irq 373) chaining IRQs 376..383
> twl4030: gpio (irq 368) chaining IRQs 384..401
> i2c_omap i2c_omap.2: bus 2 rev3.12 at 400 kHz
> i2c_omap i2c_omap.3: bus 3 rev3.12 at 400 kHz
> twl4030_usb twl4030_usb: Initialized TWL4030 USB module
> SCSI subsystem initialized
> usbcore: registered new interface driver usbfs
> usbcore: registered new interface driver hub
> usbcore: registered new device driver usb
> musb_hdrc: version 6.0, musb-dma, otg (peripheral+host), debug=3D0
> musb_hdrc: USB OTG mode controller at d80ab000 using DMA, IRQ 92
> NET: Registered protocol family 2
> IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
> TCP established hash table entries: 4096 (order: 3, 32768 bytes)
> TCP bind hash table entries: 4096 (order: 2, 16384 bytes)
> TCP: Hash tables configured (established 4096 bind 4096)
> TCP reno registered
> NET: Registered protocol family 1
> NetWinder Floating Point Emulator V0.97 (double precision)
> ashmem: initialized
> VFS: Disk quotas dquot_6.5.1
> Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
> msgmni has been set to 246
> io scheduler noop registered
> io scheduler anticipatory registered (default)
> io scheduler deadline registered
> io scheduler cfq registered
> omapfb: configured for panel omap3edge
> omapfb: DISPC version 3.0 initialized
> Console: switching to colour frame buffer device 60x40
> omapfb: Framebuffer initialized. Total vram 1228800 planes 1
> omapfb: Pixclock 24000 kHz hfreq 45.2 kHz vfreq 70.3 Hz
> Serial: 8250/16550 driver4 ports, IRQ sharing enabled
> serial8250.0: ttyS0 at MMIO 0x4806a000 (irq =3D 72) is a ST16654
> serial8250.0: ttyS1 at MMIO 0x4806c000 (irq =3D 73) is a ST16654
> serial8250.0: ttyS2 at MMIO 0x49020000 (irq =3D 74) is a ST16654
> console [ttyS2] enabled
> brd: module loaded
> loop: module loaded
> i2c /dev entries driver
> Driver 'sd' needs updating - please use bus_type methods
> usbmon: debugfs is not available
> Initializing USB Mass Storage driver...
> usbcore: registered new interface driver usb-storage
> USB Mass Storage support registered.
> usbcore: registered new interface driver usbtest
> zero gadget: Gadget Zero, version: Cinco de Mayo 2008
> zero gadget: zero ready
> musb_hdrc musb_hdrc: MUSB HDRC host driver
> musb_hdrc musb_hdrc: new USB bus registered, assigned bus number 1
> usb usb1: configuration #1 chosen from 1 choice
> hub 1-0:1.0: USB hub found
> hub 1-0:1.0: 1 port detected
> usb usb1: New USB device found, idVendor=3D1d6b, idProduct=3D0002
> usb usb1: New USB device strings: Mfr=3D3, Product=3D2, SerialNumber=3D=
1
> usb usb1: Product: MUSB HDRC host driver
> usb usb1: Manufacturer: Linux 2.6.27-omap1-svn71 musb-hcd
> usb usb1: SerialNumber: musb_hdrc
> input: omap_twl4030keypad as /class/input/input0
> ads7846 spi1.0: touchscreen, irq 335
> input: ADS784x Touchscreen as /class/input/input1
> OMAP Watchdog Timer Rev 0x31: initial timeout 60 sec
> usb 1-1: new low speed USB device using musb_hdrc and address 2
> usb 1-1: device v04b4 p0101 is not supported
> usb 1-1: configuration #1 chosen from 1 choice
> usb 1-1: New USB device found, idVendor=3D04b4, idProduct=3D0101
> usb 1-1: New USB device strings: Mfr=3D1, Product=3D2, SerialNumber=3D=
0
> usb 1-1: Product: USB Portable Keyboard
> usb 1-1: Manufacturer: HOLTEK
> mmc0: host does not support reading read-only switch. assuming write-=
enable.
> mmc0: new SDHC card at address 8fe4
> mmcblk0: mmc0:8fe4 SD04G 3872256KiB
> =A0mmcblk0:<6>input: HOLTEK USB Portable Keyboard as /class/input/inp=
ut2
> =A0p1 p2 p3 p4 < p5 p6 >
> input: USB HID v1.10 Keyboard [HOLTEK USB Portable Keyboard] on usb-m=
usb_hdrc-1
> usbcore: registered new interface driver usbhid
> usbhid: v2.6:USB HID core driver
> logger: created 64K log 'log_main'
> logger: created 64K log 'log_events'
> logger: created 64K log 'log_radio'
> TCP cubic registered
> NET: Registered protocol family 17
> NET: Registered protocol family 15
> RPC: Registered udp transport module.
> RPC: Registered tcp transport module.
> Power Management for TI OMAP3.
> SmartReflex driver initialized
> Disabling unused clock "gpt2_ick"
> Disabling unused clock "gpt2_fck"
> Disabling unused clock "wdt2_ick"
> Disabling unused clock "wdt2_fck"
> Disabling unused clock "mmchs_ick"
> Disabling unused clock "mmchs_fck"
> Disabling unused clock "dpll5_ck"
> Disabling unused clock "dpll4_m6x2_ck"
> Disabling unused clock "dpll4_m5x2_ck"
> Disabling unused clock "dpll3_m3x2_ck"
> Disabling unused clock "sys_clkout1"
> VFP support v0.3: implementor 41 architecture 3 part 30 variant c rev=
 1
> drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
> kjournald starting. =A0Commit interval 5 seconds
> EXT3 FS on mmcblk0p2, internal journal
> EXT3-fs: mounted filesystem with ordered data mode.
> VFS: Mounted root (ext3 filesystem).
> Freeing init memory: 148K
> kjournald starting. =A0Commit interval 5 seconds
> EXT3 FS on mmcblk0p3, internal journal
> EXT3-fs: recovery complete.
> EXT3-fs: mounted filesystem with ordered data mode.
> kjournald starting. =A0Commit interval 5 seconds
> EXT3 FS on mmcblk0p5, internal journal
> EXT3-fs: recovery complete.
> EXT3-fs: mounted filesystem with ordered data mode.
> kjournald starting. =A0Commit interval 5 seconds
> EXT3 FS on mmcblk0p6, internal journal
> EXT3-fs: recovery complete.
> EXT3-fs: mounted filesystem with ordered data mode.
>
> ***** Bad *****
> Linux version 2.6.27-omap1 (jb@jb) (gcc version 4.2.1 (CodeSourcery S=
ource
> ry G++ Lite 2007q3-51)) #16 Thu Mar 19 16:59:31 EDT 2009
> CPU: ARMv7 Processor [411fc082] revision 2 (ARMv7), cr=3D00c5387f
> Machine: OMAP3 EVM
> Memory policy: ECC disabled, Data cache writeback
> OMAP3430 ES2.1
> SRAM: Mapped pa 0x40200000 to va 0xd7000000 size: 0x100000
> CPU0: L1 I VIPT cache. Caches unified at level 2, coherent at level 3
> CPU0: Level 1 cache is separate instruction and data
> CPU0: I cache: 16384 bytes, associativity 4, 64 byte lines, 64 sets,
> =A0 =A0 =A0supports RA
> CPU0: D cache: 16384 bytes, associativity 4, 64 byte lines, 64 sets,
> =A0 =A0 =A0supports RA WB WT
> CPU0: Level 2 cache is unified
> CPU0: unified cache: 262144 bytes, associativity 8, 64 byte lines, 51=
2 sets,
> =A0 =A0 =A0supports WA RA WB WT
> Built 1 zonelists in Zone order, mobility grouping on. =A0Total pages=
: 32512
> Kernel command line: mem=3D128M console=3DttyS2,115200e8 noinitrd ini=
t=3Dinit root=3D/de
> v/mmcblk0p2 rw rootfstype=3Dext3
> Clocking rate (Crystal/DPLL/ARM core): 26.0/166/500 MHz
> GPMC revision 5.0
> IRQ: Found an INTC at 0xd8200000 (revision 4.0) with 96 interrupts
> Total of 96 interrupts on 1 active controller
> OMAP34xx GPIO hardware version 2.5
> PID hash table entries: 512 (order: 9, 2048 bytes)
> OMAP clockevent source: GPTIMER1 at 32768 Hz
> Console: colour dummy device 80x30
> Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
> Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
> Memory: 128MB =3D 128MB total
> Memory: 126108KB available (3048K code, 447K data, 148K init)
> Calibrating delay loop... 499.92 BogoMIPS (lpj=3D1949696)
> Mount-cache hash table entries: 512
> CPU: Testing write buffer coherency: ok
> net_namespace: 288 bytes
> android_power_init
> android_power_init done
> NET: Registered protocol family 16
> MUX: setup J21_34XX_I2C1_SDA (0xd80021bc): 0x1718 -> 0x0118
> MUX: setup K21_34XX_I2C1_SCL (0xd80021ba): 0x1718 -> 0x0118
> MUX: setup AE15_34XX_I2C2_SDA (0xd80021c0): 0x1718 -> 0x0118
> MUX: setup AF15_34XX_I2C2_SCL (0xd80021be): 0x1718 -> 0x0118
> MUX: setup AG14_34XX_I2C3_SDA (0xd80021c4): 0x1718 -> 0x0118
> MUX: setup AF14_34XX_I2C3_SCL (0xd80021c2): 0x1718 -> 0x0118
> OMAP DMA hardware revision 4.0
> USB: No board-specific platform config found
> i2c_omap i2c_omap.1: bus 1 rev3.12 at 2600 kHz
> twl4030: PIH (irq 7) chaining IRQs 368..375
> twl4030: power (irq 373) chaining IRQs 376..383
> twl4030: gpio (irq 368) chaining IRQs 384..401
> i2c_omap i2c_omap.2: bus 2 rev3.12 at 400 kHz
> i2c_omap i2c_omap.3: bus 3 rev3.12 at 400 kHz
> twl4030_usb twl4030_usb: Initialized TWL4030 USB module
> SCSI subsystem initialized
> usbcore: registered new interface driver usbfs
> usbcore: registered new interface driver hub
> usbcore: registered new device driver usb
> musb_hdrc: version 6.0, musb-dma, otg (peripheral+host), debug=3D0
> musb_hdrc: USB OTG mode controller at d80ab000 using DMA, IRQ 92
> NET: Registered protocol family 2
> IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
> TCP established hash table entries: 4096 (order: 3, 32768 bytes)
> TCP bind hash table entries: 4096 (order: 2, 16384 bytes)
> TCP: Hash tables configured (established 4096 bind 4096)
> TCP reno registered
> NET: Registered protocol family 1
> NetWinder Floating Point Emulator V0.97 (double precision)
> ashmem: initialized
> VFS: Disk quotas dquot_6.5.1
> Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
> msgmni has been set to 246
> io scheduler noop registered
> io scheduler anticipatory registered (default)
> io scheduler deadline registered
> io scheduler cfq registered
> omapfb: configured for panel omap3edge
> omapfb: DISPC version 3.0 initialized
> Console: switching to colour frame buffer device 60x40
> omapfb: Framebuffer initialized. Total vram 1228800 planes 1
> omapfb: Pixclock 24000 kHz hfreq 45.2 kHz vfreq 70.3 Hz
> Serial: 8250/16550 driver4 ports, IRQ sharing enabled
> serial8250.0: ttyS0 at MMIO 0x4806a000 (irq =3D 72) is a ST16654
> serial8250.0: ttyS1 at MMIO 0x4806c000 (irq =3D 73) is a ST16654
> serial8250.0: ttyS2 at MMIO 0x49020000 (irq =3D 74) is a ST16654
> console [ttyS2] enabled
> brd: module loaded
> loop: module loaded
> i2c /dev entries driver
> Driver 'sd' needs updating - please use bus_type methods
> usbmon: debugfs is not available
> Initializing USB Mass Storage driver...
> usbcore: registered new interface driver usb-storage
> USB Mass Storage support registered.
> usbcore: registered new interface driver usbtest
> zero gadget: Gadget Zero, version: Cinco de Mayo 2008
> zero gadget: zero ready
> musb_hdrc musb_hdrc: MUSB HDRC host driver
> musb_hdrc musb_hdrc: new USB bus registered, assigned bus number 1
> usb usb1: configuration #1 chosen from 1 choice
> hub 1-0:1.0: USB hub found
> hub 1-0:1.0: 1 port detected
> usb usb1: New USB device found, idVendor=3D1d6b, idProduct=3D0002
> usb usb1: New USB device strings: Mfr=3D3, Product=3D2, SerialNumber=3D=
1
> usb usb1: Product: MUSB HDRC host driver
> usb usb1: Manufacturer: Linux 2.6.27-omap1-svn71 musb-hcd
> usb usb1: SerialNumber: musb_hdrc
> input: omap_twl4030keypad as /class/input/input0
> ads7846 spi1.0: touchscreen, irq 335
> input: ADS784x Touchscreen as /class/input/input1
> OMAP Watchdog Timer Rev 0x31: initial timeout 60 sec
> usb 1-1: new low speed USB device using musb_hdrc and address 2
> usb 1-1: device v04b4 p0101 is not supported
> usb 1-1: configuration #1 chosen from 1 choice
> usb 1-1: New USB device found, idVendor=3D04b4, idProduct=3D0101
> usb 1-1: New USB device strings: Mfr=3D1, Product=3D2, SerialNumber=3D=
0
> usb 1-1: Product: USB Portable Keyboard
> usb 1-1: Manufacturer: HOLTEK
> input: HOLTEK USB Portable Keyboard as /class/input/input2
> input: USB HID v1.10 Keyboard [HOLTEK USB Portable Keyboard] on usb-m=
usb_hdrc-1
> usbcore: registered new interface driver usbhid
> usbhid: v2.6:USB HID core driver
> logger: created 64K log 'log_main'
> logger: created 64K log 'log_events'
> logger: created 64K log 'log_radio'
> TCP cubic registered
> NET: Registered protocol family 17
> NET: Registered protocol family 15
> RPC: Registered udp transport module.
> RPC: Registered tcp transport module.
> Power Management for TI OMAP3.
> SmartReflex driver initialized
> Disabling unused clock "gpt2_ick"
> Disabling unused clock "gpt2_fck"
> Disabling unused clock "wdt2_ick"
> Disabling unused clock "wdt2_fck"
> Disabling unused clock "mmchs_ick"
> Disabling unused clock "mmchs_fck"
> Disabling unused clock "dpll5_ck"
> Disabling unused clock "dpll4_m6x2_ck"
> Disabling unused clock "dpll4_m5x2_ck"
> Disabling unused clock "dpll3_m3x2_ck"
> Disabling unused clock "sys_clkout1"
> VFP support v0.3: implementor 41 architecture 3 part 30 variant c rev=
 1
> drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
> Root-NFS: No NFS server available, giving up.
> VFS: Unable to mount root fs via NFS, trying floppy.
> VFS: Cannot open root device "mmcblk0p2" or unknown-block(2,0)
> Please append a correct "root=3D" boot option; here are the available=
 partitions:
> Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-b=
lock(2,0)
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

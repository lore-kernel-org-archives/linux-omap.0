From: Jose Manuel Cano Garcia <jcgarcia@uma.es>
Subject: Re: omap 5912 linux 2.6.15rc2
Date: Mon, 05 Dec 2005 15:29:37 +0100
Message-ID: <43944ED1.6050301@uma.es>
References: <20051205130456.26983.qmail@webmail43.rediffmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20051205130456.26983.qmail@webmail43.rediffmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Rahul <idea83@rediffmail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi Rahul,

Please, read the thread "OSK5912 USB Port Problem" in this mailing list 
(its quite recent, November 2005). I successfully tried a 2.6.15 kernel, 
but I have to use a patch Tony Lindgren recommended me on that thread. 
The problem was something related to the reset of the USB clock at boot. 
This problem affects kernel 2.6.12 and beyond.  Other possibility is to 
disable the CONFIG_OMAP_RESET_CLOCKS option when compiling the kernel.

This is the patch:

http://linux.omap.com/pipermail/linux-omap-open-source/2005-August/004818.html 


Best regards,

Jose


Rahul wrote:

>Hi group,
>
>I am presently working on omap5912 osk. First i used the linux from montavista i.e. 2.4.20 and was able to successfully mount and run the usb on it.
>
>But recently i have downloaded the latest kernel i.e. 2.6.15rc2.
>The problem is that i am unable to mount usb on it,though lot of drivers r detected if i dmesg like usb hub found, usb core found, udc driver found, mass storage initialized, scsi subsystem initialized, omap ohci...etc
>
>Please suggest something if someone has mounted usb successfully on 2.6.15.Do i need to apply some patch or add something..??
>
>I am attaching the message which i receive by dmesg
>
>Thanks 
>Rahul 
>
>
>  
>
>
>  
>
>------------------------------------------------------------------------
>
>
>U-Boot 1.1.2 (Oct 26 2005 - 16:18:08)
>
>U-Boot code: 11080000 -> 11096144  BSS: -> 1109A914
>RAM Configuration:
>Bank #0: 10000000 32 MB
>Micron StrataFlash MT28F128J3 device initialized
>Flash: 32 MB
>In:    serial
>Out:   serial
>Err:   serial
>OMAP5912 OSK # bootm 0x100000 ## Booting image at 00100000 ...
>   Image Name:   Linux-2.6.15-rc2-omap1-g0cab20fd
>   Image Type:   ARM Linux Kernel Image (uncompressed)
>   Data Size:    1389496 Bytes =  1.3 MB
>   Load Address: 10008000
>   Entry Point:  10008000
>   Verifying Checksum ... OK
>OK
>
>Starting kernel ...
>
>Uncompressing Linux............................................................................................. done, booting the kernel.
>
>Linux version 2.6.15-rc2-omap1-g0cab20fd (root@brahma) (gcc version 3.3.2) #2 Wed Nov 23 20:00:45 IST 2005
>
>CPU: ARM926EJ-Sid(wb) [41069263] revision 3 (ARMv5TEJ)
>
>Machine: TI-OSK
>
>Memory policy: ECC disabled, Data cache writeback
>
>OMAP1611b revision 2 handled as 16xx id: 5b058f7948871d18
>
>SRAM: Mapped pa 0x00020000 to va 0xd0000000 size: 0x3f000
>
>Clocks: ARM_SYSST: 0x0000 DPLL_CTL: 0x2833 ARM_CKCTL: 0x3000
>
>Clocking rate (xtal/DPLL1/MPU): 12.0/192.0/192.0 MHz
>
>CPU0: D VIVT write-back cache
>
>CPU0: I cache: 16384 bytes, associativity 4, 32 byte lines, 128 sets
>
>CPU0: D cache: 8192 bytes, associativity 4, 32 byte lines, 64 sets
>
>Built 1 zonelists
>
>Kernel command line: console=ttyS0,115200n8 noinitrd ip=10.64.42.25:10.64.12.95:10.64.1.1:255.255.0.0:osk:eth0:off root=/dev/nfs rw nfsroot=10.64.12.95:/data/rootfs2.6,nolock mem=32M
>
>Total of 128 interrupts in 4 interrupt banks
>
>OMAP GPIO hardware version 1.0
>
>MUX: initialized M7_1610_GPIO62
>
>PID hash table entries: 256 (order: 8, 4096 bytes)
>
>Console: colour dummy device 80x30
>
>Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
>
>Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
>
>Memory: 32MB = 32MB total
>
>Memory: 29328KB available (2378K code, 481K data, 120K init)
>
>Mount-cache hash table entries: 512
>
>CPU: Testing write buffer coherency: ok
>
>NET: Registered protocol family 16
>
>OMAP DMA hardware version 1
>
>DMA capabilities: 000c0000:00000000:01ff:003f:007f
>
>Initializing OMAP McBSP system
>
>USB: hmc 16, usb0 2 wires
>
>i2c_omap: bus 0 rev2.2 at 100 KHz
>
>tps65010: version 2 May 2005
>
>MUX: initialized N14_1610_UWIRE_CS0
>
>MUX: initialized P15_1610_UWIRE_CS3
>
>SCSI subsystem initialized
>
>usbcore: registered new driver usbfs
>
>usbcore: registered new driver hub
>
>NetWinder Floating Point Emulator V0.97 (double precision)
>
>OMAP OCPI interconnect driver loaded
>
>Power Management for TI OMAP.
>
>MUX: initialized T20_1610_LOW_PWR
>
>JFFS version 1.0, (C) 1999, 2000  Axis Communications AB
>
>JFFS2 version 2.2. (NAND) (C) 2001-2003 Red Hat, Inc.
>
>io scheduler noop registered
>
>io scheduler anticipatory registered
>
>io scheduler deadline registered
>
>io scheduler cfq registered
>
>omapfb: configured for panel osk
>
>omapfb-lcdc: init
>
>MUX: initialized PWL
>
>omapfb-lcdc: Pixel clock divider value is obsolete.
>
>omapfb-lcdc: Try to set pixel_clock to 8000 and pcd to 0 in drivers/video/omap/lcd_osk.c and submit a patch.
>
>Console: switching to colour frame buffer device 30x40
>
>omapfb: initialized vram=153600 pixclock 8000 kHz hfreq 20.1 kHz vfreq 63.3 Hz
>
>Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
>
>serial8250.0: ttyS0 at MMIO 0xfffb0000 (irq = 46) is a ST16654
>
>RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
>
>loop: loaded (max 8 devices)
>
>PPP generic driver version 2.4.2
>
>smc91x.c: v1.1, sep 22 2004 by Nicolas Pitre <nico@cam.org>
>
>eth0: SMC91C94 (rev 9) at c2852300 IRQ 160 [nowait]
>
>eth0: Ethernet addr: 00:0e:99:02:05:93
>
>i2c /dev entries driver
>
>omapflash.0: Found 1 x16 devices at 0x0 in 16-bit bank
>
>omapflash.0: Found 1 x16 devices at 0x1000000 in 16-bit bank
>
> Intel/Sharp Extended Query Table at 0x0031
>
>Using buffer write method
>
>cfi_cmdset_0001: Erase suspend on write enabled
>
>Creating 4 MTD partitions on "omapflash.0":
>
>0x00000000-0x00020000 : "bootloader"
>
>0x00020000-0x00040000 : "params"
>
>0x00040000-0x00240000 : "kernel"
>
>0x00240000-0x02000000 : "filesystem"
>
>MUX: initialized W11_1610_CF_CD1
>
>MUX: initialized P11_1610_CF_CD2
>
>MUX: initialized R11_1610_CF_IOIS16
>
>MUX: initialized V10_1610_CF_IREQ
>
>MUX: initialized W10_1610_CF_RESET
>
>omap_cf: cs2 on irq 222
>
>usbmon: debugfs is not available
>
>MUX: initialized W8_1610_GPIO9
>
>MUX: initialized W4_USB_HIGHZ
>
>ohci ohci: OMAP OHCI
>
>ohci ohci: new USB bus registered, assigned bus number 1
>
>ohci ohci: irq 38, io mem 0xfffba000
>
>hub 1-0:1.0: USB hub found
>
>hub 1-0:1.0: 3 ports detected
>
>Initializing USB Mass Storage driver...
>
>usbcore: registered new driver usb-storage
>
>USB Mass Storage support registered.
>
>mice: PS/2 mouse device common for all mice
>
>OMAP Keypad Driver
>
>input: device omap-keypad is statically allocated, will not register
>
>Please convert to input_allocate_device() or contact dtor_core@ameritech.net
>
>NET: Registered protocol family 2
>
>IP route cache hash table entries: 512 (order: -1, 2048 bytes)
>
>TCP established hash table entries: 2048 (order: 1, 8192 bytes)
>
>TCP bind hash table entries: 2048 (order: 1, 8192 bytes)
>
>TCP: Hash tables configured (established 2048 bind 2048)
>
>TCP reno registered
>
>TCP bic registered
>
>NET: Registered protocol family 1
>
>Disabling unused clock "usb_dc_ck"...  done
>
>FIXME: Clock "tc2_ck" seems unused
>
>Disabling unused clock "tc1_ck"...  done
>
>Skipping reset check for DSP domain clock "dsptim_ck"
>
>Skipping reset check for DSP domain clock "dspxor_ck"
>
>Skipping reset check for DSP domain clock "dspper_ck"
>
>eth0: link up
>
>IP-Config: Complete:
>
>      device=eth0, addr=10.64.42.25, mask=255.255.0.0, gw=10.64.1.1,
>
>     host=osk, domain=, nis-domain=(none),
>
>     bootserver=10.64.12.95, rootserver=10.64.12.95, rootpath=
>
>Looking up port of RPC 100003/2 on 10.64.12.95
>
>Looking up port of RPC 100005/1 on 10.64.12.95
>
>VFS: Mounted root (nfs filesystem).
>
>Freeing init memory: 120K
>
>
>init started:  BusyBox v1.00-pre8 (2004.03.05-22:18+0000) multi-call binary
>
>******************************************
>Starting System Init for OMAP5912OSK
>******************************************
>
>Please press Enter to activate this console. 
>
>
>BusyBox v1.00-pre8 (2004.03.05-22:18+0000) Built-in shell (ash)
>Enter 'help' for a list of built-in commands.
>
>-sh: can't access tty; job control turned off
>#  
>*********************************************************************************************************
>*********************************************************************************************************
>
>
>U-Boot 1.1.2 (Oct 26 2005 - 16:18:08)
>
>U-Boot code: 11080000 -> 11096144  BSS: -> 1109A914
>RAM Configuration:
>Bank #0: 10000000 32 MB
>Micron StrataFlash MT28F128J3 device initialized
>Flash: 32 MB
>In:    serial
>Out:   serial
>Err:   serial
>OMAP5912 OSK # bootm 0x100000 ## Booting image at 00100000 ...
>   Image Name:   Linux-2.6.15-rc2-omap1-g0cab20fd
>   Image Type:   ARM Linux Kernel Image (uncompressed)
>   Data Size:    1475388 Bytes =  1.4 MB
>   Load Address: 10008000
>   Entry Point:  10008000
>   Verifying Checksum ... OK
>OK
>
>Starting kernel ...
>
>Uncompressing Linux................................................................................................... done, booting the kernel.
>
>Linux version 2.6.15-rc2-omap1-g0cab20fd (root@brahma) (gcc version 3.3.2) #4 Thu Dec 1 17:36:52 IST 2005
>
>CPU: ARM926EJ-Sid(wb) [41069263] revision 3 (ARMv5TEJ)
>
>Machine: TI-OSK
>
>Memory policy: ECC disabled, Data cache writeback
>
>OMAP1611b revision 2 handled as 16xx id: 5b058f7948871d18
>
>SRAM: Mapped pa 0x00020000 to va 0xd0000000 size: 0x3f000
>
>Clocks: ARM_SYSST: 0x0000 DPLL_CTL: 0x2833 ARM_CKCTL: 0x3000
>
>Clocking rate (xtal/DPLL1/MPU): 12.0/192.0/192.0 MHz
>
>CPU0: D VIVT write-back cache
>
>CPU0: I cache: 16384 bytes, associativity 4, 32 byte lines, 128 sets
>
>CPU0: D cache: 8192 bytes, associativity 4, 32 byte lines, 64 sets
>
>Built 1 zonelists
>
>Kernel command line: console=ttyS0,115200n8 noinitrd rw ip=dhcp root=/dev/nfs nfsroot=10.64.12.95:/data/rootfs2.6,nolock mem=30M
>
>Total of 128 interrupts in 4 interrupt banks
>
>OMAP GPIO hardware version 1.0
>
>MUX: initialized M7_1610_GPIO62
>
>PID hash table entries: 128 (order: 7, 2048 bytes)
>
>Console: colour dummy device 80x30
>
>Dentry cache hash table entries: 4096 (order: 2, 16384 bytes)
>
>Inode-cache hash table entries: 2048 (order: 1, 8192 bytes)
>
>Memory: 30MB = 30MB total
>
>Memory: 27192KB available (2536K code, 495K data, 124K init)
>
>Mount-cache hash table entries: 512
>
>CPU: Testing write buffer coherency: ok
>
>NET: Registered protocol family 16
>
>OMAP DMA hardware version 1
>
>DMA capabilities: 000c0000:00000000:01ff:003f:007f
>
>Initializing OMAP McBSP system
>
>MUX: initialized W4_USB_PUEN
>
>USB: hmc 0, usb0 2 wires (dev)
>
>i2c_omap: bus 0 rev2.2 at 100 KHz
>
>tps65010: version 2 May 2005
>
>MUX: initialized N14_1610_UWIRE_CS0
>
>MUX: initialized P15_1610_UWIRE_CS3
>
>SCSI subsystem initialized
>
>usbcore: registered new driver usbfs
>
>usbcore: registered new driver hub
>
>NetWinder Floating Point Emulator V0.97 (double precision)
>
>OMAP OCPI interconnect driver loaded
>
>Power Management for TI OMAP.
>
>MUX: initialized T20_1610_LOW_PWR
>
>JFFS version 1.0, (C) 1999, 2000  Axis Communications AB
>
>JFFS2 version 2.2. (NAND) (C) 2001-2003 Red Hat, Inc.
>
>io scheduler noop registered
>
>io scheduler anticipatory registered
>
>io scheduler deadline registered
>
>io scheduler cfq registered
>
>omapfb: configured for panel osk
>
>omapfb-lcdc: init
>
>MUX: initialized PWL
>
>omapfb-lcdc: Pixel clock divider value is obsolete.
>
>omapfb-lcdc: Try to set pixel_clock to 8000 and pcd to 0 in drivers/video/omap/lcd_osk.c and submit a patch.
>
>Console: switching to colour frame buffer device 30x40
>
>omapfb: initialized vram=153600 pixclock 8000 kHz hfreq 20.1 kHz vfreq 63.3 Hz
>
>Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
>
>serial8250.0: ttyS0 at MMIO 0xfffb0000 (irq = 46) is a ST16654
>
>RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
>
>loop: loaded (max 8 devices)
>
>PPP generic driver version 2.4.2
>
>smc91x.c: v1.1, sep 22 2004 by Nicolas Pitre <nico@cam.org>
>
>eth0: SMC91C94 (rev 9) at c2052300 IRQ 160 [nowait]
>
>eth0: Ethernet addr: 00:0e:99:02:05:93
>
>i2c /dev entries driver
>
>omapflash.0: Found 1 x16 devices at 0x0 in 16-bit bank
>
>omapflash.0: Found 1 x16 devices at 0x1000000 in 16-bit bank
>
> Intel/Sharp Extended Query Table at 0x0031
>
>Using buffer write method
>
>cfi_cmdset_0001: Erase suspend on write enabled
>
>Creating 4 MTD partitions on "omapflash.0":
>
>0x00000000-0x00020000 : "bootloader"
>
>0x00020000-0x00040000 : "params"
>
>0x00040000-0x00240000 : "kernel"
>
>0x00240000-0x02000000 : "filesystem"
>
>MUX: initialized W11_1610_CF_CD1
>
>MUX: initialized P11_1610_CF_CD2
>
>MUX: initialized R11_1610_CF_IOIS16
>
>MUX: initialized V10_1610_CF_IREQ
>
>MUX: initialized W10_1610_CF_RESET
>
>omap_cf: cs2 on irq 222
>
>usbmon: debugfs is not available
>
>116x: driver isp116x-hcd, 05 Aug 2005
>
>sl811: driver sl811-hcd, 19 May 2005
>
>usbcore: registered new driver usblp
>
>drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
>
>Initializing USB Mass Storage driver...
>
>usbcore: registered new driver usb-storage
>
>USB Mass Storage support registered.
>
>usbcore: registered new driver usbhid
>
>drivers/usb/input/hid-core.c: v2.6:USB HID core driver
>
>usbcore: registered new driver asix
>
>usbcore: registered new driver cdc_ether
>
>usbcore: registered new driver net1080
>
>usbcore: registered new driver zaurus
>
>udc: OMAP UDC driver, version: 4 October 2004 (iso) (dma)
>
>udc: OMAP UDC rev 3.6
>
>udc: hmc mode 0, integrated transceiver
>
>udc: fifo mode 3, 392 bytes not used
>
>usb0: Ethernet Gadget, version: May Day 2005
>
>usb0: using omap_udc, OUT ep2out-bulk IN ep1in-bulk STATUS ep3in-int
>
>usb0: MAC 6e:d7:e8:91:90:93
>
>usb0: HOST MAC 8a:f0:df:c4:0f:b9
>
>usb0: RNDIS ready
>
>mice: PS/2 mouse device common for all mice
>
>OMAP Keypad Driver
>
>input: device omap-keypad is statically allocated, will not register
>
>Please convert to input_allocate_device() or contact dtor_core@ameritech.net
>
>NET: Registered protocol family 2
>
>IP route cache hash table entries: 256 (order: -2, 1024 bytes)
>
>TCP established hash table entries: 1024 (order: 0, 4096 bytes)
>
>TCP bind hash table entries: 1024 (order: 0, 4096 bytes)
>
>TCP: Hash tables configured (established 1024 bind 1024)
>
>TCP reno registered
>
>TCP bic registered
>
>NET: Registered protocol family 1
>
>Disabling unused clock "usb_dc_ck"...  done
>
>FIXME: Clock "tc2_ck" seems unused
>
>Disabling unused clock "tc1_ck"...  done
>
>Skipping reset check for DSP domain clock "dsptim_ck"
>
>Skipping reset check for DSP domain clock "dspxor_ck"
>
>Skipping reset check for DSP domain clock "dspper_ck"
>
>eth0: link up
>
>Sending DHCP requests ., OK
>
>IP-Config: Got DHCP answer from 10.64.2.1, my address is 10.64.12.234
>
>IP-Config: Complete:
>
>      device=eth0, addr=10.64.12.234, mask=255.255.0.0, gw=10.64.1.1,
>
>     host=10.64.12.234, domain=dhcpee.iitd.ac.in, nis-domain=(none),
>
>     bootserver=10.64.2.1, rootserver=10.64.12.95, rootpath=
>
>Looking up port of RPC 100003/2 on 10.64.12.95
>
>Looking up port of RPC 100005/1 on 10.64.12.95
>
>VFS: Mounted root (nfs filesystem).
>
>Freeing init memory: 124K
>
>
>init started:  BusyBox v1.00-pre8 (2004.03.05-22:18+0000) multi-call binary
>
>******************************************
>Starting System Init for OMAP5912OSK
>******************************************
>
>Please press Enter to activate this console. 
>
>
>BusyBox v1.00-pre8 (2004.03.05-22:18+0000) Built-in shell (ash)
>Enter 'help' for a list of built-in commands.
>
>-sh: can't access tty; job control turned off
># 
>
>------------------------------------------------------------------------
>
>_______________________________________________
>Linux-omap-open-source mailing list
>Linux-omap-open-source@linux.omap.com
>http://linux.omap.com/mailman/listinfo/linux-omap-open-source
>  
>

From: Kevin Hilman <khilman@ti.com>
Subject: Re: MFD USB host: prevents CORE retention in idle
Date: Wed, 23 May 2012 17:25:00 -0700
Message-ID: <4FBD7FDC.9050307@ti.com>
References: <87zk8yxx9l.fsf@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090102000803000404000302"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:47205 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750739Ab2EXAZE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 23 May 2012 20:25:04 -0400
Received: by dadz8 with SMTP id z8so13645585dad.35
        for <linux-omap@vger.kernel.org>; Wed, 23 May 2012 17:25:02 -0700 (PDT)
In-Reply-To: <87zk8yxx9l.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Keshava Munegowda <Keshava_mgowda@ti.com>, Felipe Balbi <balbi@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

This is a multi-part message in MIME format.
--------------090102000803000404000302
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On 05/23/2012 05:01 PM, Kevin Hilman wrote:
> Hi Keshava,
>
> Using current l-o master, I noticed that CORE was not hitting retention
> in idle on my 3530/Overo.  CORE hits retention on suspend just fine.
>
> Debugging this, I found that usbtll_fck was still enabled during idle,
> thus preventing CORE from hitting retention.
>
> To test, I disabled USB host (CONFIG_MFD_OMAP_USB_HOST=n in .config) and
> was then started seeing CORE hit retention in idle again.
>
> I have nothing plugged into the USB host port on this board, so I
> would've expected that runtime PM would've kicked in and shutdown this
> clock.
>
> Any ideas what's going on here?  Is this expected behavior?
>

If it helps, attached is a bootlog after enabling debug for 
mfd/omap-usb-host.c as well.  Notice there's a couple of clock-related 
warnings from this driver as well.  Not sure if they're relevant:

usbhs_omap: alias fck already exists
usbhs_omap usbhs_omap: xclk60mhsp2_ck set parentfailed error:-22

With debug enabled, I see the runtime resume during init followed by the 
runtime suspend.

[    0.936248] usbhs_omap usbhs_omap: xclk60mhsp2_ck set parentfailed 
error:-22
[    0.944152] usbhs_omap usbhs_omap: starting TI HSUSB Controller
[    0.944335] usbhs_omap usbhs_omap: usbhs_runtime_resume
[    0.944641] usbhs_omap usbhs_omap: OMAP UHH_REVISION 0x10
[    0.944641] usbhs_omap usbhs_omap: OMAP3 ES version > ES2.1
[    0.944671] usbhs_omap usbhs_omap: UHH setup done, 
uhh_hostconfig=8000121d
[    0.947082] usbhs_omap usbhs_omap: usbhs_runtime_suspend

However, later in the boot I see a runtime_resume and never see another 
suspend.  That seems to be the root cause of CORE not hitting retention.

 From the boot log:

[    2.018707] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    2.025787] ehci_hcd: block sizes: qh 64 qtd 96 itd 160 sitd 96
[    2.026306] ehci-omap ehci-omap.0: failed to get ehci port1 regulator
[    2.026519] usbhs_omap usbhs_omap: usbhs_runtime_resume
[    3.030639] ehci-omap ehci-omap.0: phy reset operation timed out
[    3.030700] ehci-omap ehci-omap.0: reset hcs_params 0x1313 dbg=0 cc=1 
pcc=3 ordered ports=3
[    3.030731] ehci-omap ehci-omap.0: reset hcc_params 0016 thresh 1 
uframes 256/512/1024 park
[    3.030761] ehci-omap ehci-omap.0: reset command 0080b02  park=3 
ithresh=8 period=1024 Reset HALT
[    3.030792] ehci-omap ehci-omap.0: OMAP-EHCI Host Controller

Since the only get/puts I see are in omap_usbhs_init(), I'm not sure how 
this driver is being runtime resumed.  Presumably it's due to how the 
rest of the USB stack works, which I'm not at all familiar with.

Hopefully, the above is enough to debug the problem,

Thanks,

Kevin

--------------090102000803000404000302
Content-Type: text/plain; charset=UTF-8;
 name="boot.txt"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
 filename="boot.txt"

[    0.000000] Booting Linux on physical CPU 0
[    0.000000] Linux version 3.4.0-rc7-pm+debug+initramfs-01073-g0ecc382-dirty (khilman@paris) (gcc version 4.6.3 (Ubuntu/Linaro 4.6.3-1ubuntu5) ) #20 SMP Wed May 23 17:10:56 PDT 2012
[    0.000000] CPU: ARMv7 Processor [411fc083] revision 3 (ARMv7), cr=10c53c7d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT nonaliasing instruction cache
[    0.000000] Machine: Gumstix Overo
[    0.000000] bootconsole [earlycon0] enabled
[    0.000000] Memory policy: ECC disabled, Data cache writeback
[    0.000000] On node 0 totalpages: 65280
[    0.000000] free_area_init_node: node 0, pgdat c09c0dc0, node_mem_map c0f1e000
[    0.000000]   Normal zone: 512 pages used for memmap
[    0.000000]   Normal zone: 0 pages reserved
[    0.000000]   Normal zone: 64768 pages, LIFO batch:15
[    0.000000] OMAP3430/3530 ES3.1 (l2cache iva sgx neon isp )
[    0.000000] Clocking rate (Crystal/Core/MPU): 26.0/331/500 MHz
[    0.000000] PERCPU: Embedded 9 pages/cpu @c1124000 s12992 r8192 d15680 u36864
[    0.000000] pcpu-alloc: s12992 r8192 d15680 u36864 alloc=9*4096
[    0.000000] pcpu-alloc: [0] 0 
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 64768
[    0.000000] Kernel command line: console=ttyO2,115200n8 earlyprintk ip=192.168.1.157:192.168.1.5:192.168.1.254:255.255.255.0:overo:eth0:none root=/dev/nfs nfsroot=192.168.1.236:/opt/kjh/rootfs/debian/armel,rsize=4096,wsize=409
[    0.000000] PID hash table entries: 1024 (order: 0, 4096 bytes)
[    0.000000] Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
[    0.000000] Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
[    0.000000] Memory: 255MB = 255MB total
[    0.000000] Memory: 243328k/243328k available, 18816k reserved, 0K highmem
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
[    0.000000]     vmalloc : 0xd0800000 - 0xff000000   ( 744 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xd0000000   ( 256 MB)
[    0.000000]     pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
[    0.000000]     modules : 0xbf000000 - 0xbfe00000   (  14 MB)
[    0.000000]       .text : 0xc0008000 - 0xc066da70   (6551 kB)
[    0.000000]       .init : 0xc066e000 - 0xc092b2c0   (2805 kB)
[    0.000000]       .data : 0xc092c000 - 0xc09c3530   ( 606 kB)
[    0.000000]        .bss : 0xc09c3554 - 0xc0f1d620   (5481 kB)
[    0.000000] Hierarchical RCU implementation.
[    0.000000] NR_IRQS:474
[    0.000000] IRQ: Found an INTC at 0xfa200000 (revision 4.0) with 96 interrupts
[    0.000000] Total of 96 interrupts on 1 active controller
[    0.000000] OMAP clockevent source: GPTIMER1 at 32768 Hz
[    0.000000] sched_clock: 32 bits at 32kHz, resolution 30517ns, wraps every 131071999ms
[    0.000000] OMAP clocksource: 32k_counter at 32768 Hz
[    0.000000] Console: colour dummy device 80x30
[    0.000000] Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
[    0.000000] ... MAX_LOCKDEP_SUBCLASSES:  8
[    0.000000] ... MAX_LOCK_DEPTH:          48
[    0.000000] ... MAX_LOCKDEP_KEYS:        8191
[    0.000000] ... CLASSHASH_SIZE:          4096
[    0.000000] ... MAX_LOCKDEP_ENTRIES:     16384
[    0.000000] ... MAX_LOCKDEP_CHAINS:      32768
[    0.000000] ... CHAINHASH_SIZE:          16384
[    0.000000]  memory used by lock dependency info: 3695 kB
[    0.000000]  per task-struct memory footprint: 1152 bytes
[    0.062866] Calibrating delay loop... 497.82 BogoMIPS (lpj=1941504)
[    0.106231] pid_max: default: 32768 minimum: 301
[    0.112091] Security Framework initialized
[    0.116760] Mount-cache hash table entries: 512
[    0.128845] CPU: Testing write buffer coherency: ok
[    0.135284] CPU0: thread -1, cpu 0, socket -1, mpidr 0
[    0.140777] Setting up static identity map for 0x8048cf58 - 0x8048cfc8
[    0.150268] Brought up 1 CPUs
[    0.153411] SMP: Total of 1 processors activated (497.82 BogoMIPS).
[    0.189422] dummy: 
[    0.194763] NET: Registered protocol family 16
[    0.201293] GPMC revision 5.0
[    0.204742] gpmc: irq-20 could not claim: err -22
[    0.224334] gpiochip_add: registered GPIOs 0 to 31 on device: gpio
[    0.231872] OMAP GPIO hardware version 2.5
[    0.237823] gpiochip_add: registered GPIOs 32 to 63 on device: gpio
[    0.246490] gpiochip_add: registered GPIOs 64 to 95 on device: gpio
[    0.255310] gpiochip_add: registered GPIOs 96 to 127 on device: gpio
[    0.264038] gpiochip_add: registered GPIOs 128 to 159 on device: gpio
[    0.272796] gpiochip_add: registered GPIOs 160 to 191 on device: gpio
[    0.289855] omap_mux_init: Add partition: #1: core, flags: 0
[    0.327178] Reprogramming SDRC clock to 331882352 Hz
[    0.332550] Found NAND on CS0
[    0.335693] Registering NAND on CS0
[    0.342926]  usbhs_omap: alias fck already exists
[    0.366394] hw-breakpoint: debug architecture 0x4 unsupported.
[    0.394683]  omap-mcbsp.2: alias fck already exists
[    0.401367]  omap-mcbsp.3: alias fck already exists
[    0.412933] OMAP DMA hardware revision 4.0
[    0.514068] bio: create slab <bio-0> at 0
[    0.524139] fixed-dummy: 
[    0.528808] vads7846: 3300 mV 
[    0.540191] SCSI subsystem initialized
[    0.547149] omap2_mcspi omap2_mcspi.1: master is unqueued, this is deprecated
[    0.559478] omap2_mcspi omap2_mcspi.2: master is unqueued, this is deprecated
[    0.568756] omap2_mcspi omap2_mcspi.3: master is unqueued, this is deprecated
[    0.578124] omap2_mcspi omap2_mcspi.4: master is unqueued, this is deprecated
[    0.590362] usbcore: registered new interface driver usbfs
[    0.597778] usbcore: registered new interface driver hub
[    0.604705] usbcore: registered new device driver usb
[    0.627441] omap_i2c omap_i2c.1: bus 1 rev1.3.12 at 2600 kHz
[    0.646484] twl 1-0048: PIH (irq 7) chaining IRQs 320..328
[    0.653320] twl 1-0048: power (irq 325) chaining IRQs 328..335
[    0.662628] twl4030_gpio twl4030_gpio: gpio (irq 320) chaining IRQs 336..353
[    0.672149] gpiochip_add: registered GPIOs 192 to 211 on device: twl4030
[    0.686859] vdd_mpu_iva: 600 <--> 1450 mV normal 
[    0.694915] vdd_core: 600 <--> 1450 mV normal 
[    0.703033] VMMC1: 1850 <--> 3150 mV at 3000 mV normal standby
[    0.712341] VDAC: 1800 mV normal standby
[    0.719696] VDVI: 1800 mV normal standby
[    0.725646] omap_i2c omap_i2c.3: bus 3 rev1.3.12 at 400 kHz
[    0.743560] Switching to clocksource 32k_counter
[    0.936248] usbhs_omap usbhs_omap: xclk60mhsp2_ck set parentfailed error:-22
[    0.944152] usbhs_omap usbhs_omap: starting TI HSUSB Controller
[    0.944335] usbhs_omap usbhs_omap: usbhs_runtime_resume
[    0.944641] usbhs_omap usbhs_omap: OMAP UHH_REVISION 0x10
[    0.944641] usbhs_omap usbhs_omap: OMAP3 ES version > ES2.1
[    0.944671] usbhs_omap usbhs_omap: UHH setup done, uhh_hostconfig=8000121d
[    0.947082] usbhs_omap usbhs_omap: usbhs_runtime_suspend
[    0.948974] NET: Registered protocol family 2
[    0.955230] IP route cache hash table entries: 2048 (order: 1, 8192 bytes)
[    0.965301] TCP established hash table entries: 8192 (order: 4, 65536 bytes)
[    0.973297] TCP bind hash table entries: 8192 (order: 6, 294912 bytes)
[    0.985870] TCP: Hash tables configured (established 8192 bind 8192)
[    0.992675] TCP: reno registered
[    0.996124] UDP hash table entries: 128 (order: 1, 10240 bytes)
[    1.002868] UDP-Lite hash table entries: 128 (order: 1, 10240 bytes)
[    1.010864] NET: Registered protocol family 1
[    1.017608] RPC: Registered named UNIX socket transport module.
[    1.024169] RPC: Registered udp transport module.
[    1.029113] RPC: Registered tcp transport module.
[    1.034118] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    1.367248] VFS: Disk quotas dquot_6.5.2
[    1.371856] Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
[    1.383026] NFS: Registering the id_resolver key type
[    1.391265] jffs2: version 2.2. (NAND) (SUMMARY)  © 2001-2006 Red Hat, Inc.
[    1.400390] msgmni has been set to 475
[    1.409515] io scheduler noop registered
[    1.413848] io scheduler deadline registered
[    1.418670] io scheduler cfq registered (default)
[    1.427276] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    1.443817] omap_uart.0: ttyO0 at MMIO 0x4806a000 (irq = 72) is a OMAP UART0
[    1.454162] omap_uart.1: ttyO1 at MMIO 0x4806c000 (irq = 73) is a OMAP UART1
[    1.463836] omap_uart.2: ttyO2 at MMIO 0x49020000 (irq = 74) is a OMAP UART2
[    1.471862] console [ttyO2] enabled, bootconsole disabled
[    1.534423] brd: module loaded
[    1.566497] loop: module loaded
[    1.581359] mtdoops: mtd device (mtddev=name/number) must be supplied
[    1.589569] NAND device: Manufacturer ID: 0x2c, Chip ID: 0xba (Micron NAND 256MiB 1,8V 16-bit)
[    1.607330] Creating 5 MTD partitions on "omap2-nand.0":
[    1.613189] 0x000000000000-0x000000080000 : "xloader"
[    1.628692] 0x000000080000-0x000000240000 : "uboot"
[    1.642272] 0x000000240000-0x000000280000 : "uboot environment"
[    1.654724] 0x000000280000-0x000000680000 : "linux"
[    1.669494] 0x000000680000-0x000010000000 : "rootfs"
[    1.901184] OneNAND driver initializing
[    1.914794] smsc911x: Driver version 2008-10-21
[    1.935760] smsc911x-mdio: probed
[    1.939971] smsc911x smsc911x.0: eth0: attached PHY driver [SMSC LAN8700] (mii_bus:phy_addr=smsc911x-0:01, irq=-1)
[    1.951568] smsc911x smsc911x.0: eth0: MAC Address: e6:ff:c8:7a:93:cd
[    1.958557] smsc911x: Driver version 2008-10-21
[    1.968933] usbcore: registered new interface driver asix
[    1.975402] usbcore: registered new interface driver cdc_ether
[    1.982574] usbcore: registered new interface driver smsc95xx
[    1.989593] usbcore: registered new interface driver net1080
[    1.996459] usbcore: registered new interface driver cdc_subset
[    2.003570] usbcore: registered new interface driver zaurus
[    2.010375] usbcore: registered new interface driver cdc_ncm
[    2.018707] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    2.025787] ehci_hcd: block sizes: qh 64 qtd 96 itd 160 sitd 96
[    2.026306] ehci-omap ehci-omap.0: failed to get ehci port1 regulator
[    2.026519] usbhs_omap usbhs_omap: usbhs_runtime_resume
[    3.030639] ehci-omap ehci-omap.0: phy reset operation timed out
[    3.030700] ehci-omap ehci-omap.0: reset hcs_params 0x1313 dbg=0 cc=1 pcc=3 ordered ports=3
[    3.030731] ehci-omap ehci-omap.0: reset hcc_params 0016 thresh 1 uframes 256/512/1024 park
[    3.030761] ehci-omap ehci-omap.0: reset command 0080b02  park=3 ithresh=8 period=1024 Reset HALT
[    3.030792] ehci-omap ehci-omap.0: OMAP-EHCI Host Controller
[    3.039276] /work/kernel/omap/pm/drivers/usb/core/inode.c: creating file 'devices'
[    3.039764] /work/kernel/omap/pm/drivers/usb/core/inode.c: creating file '001'
[    3.043609] ehci-omap ehci-omap.0: new USB bus registered, assigned bus number 1
[    3.052307] ehci-omap ehci-omap.0: park 0
[    3.052429] ehci-omap ehci-omap.0: irq 77, io mem 0x48064800
[    3.058532] ehci-omap ehci-omap.0: init command 0010005 (park)=0 ithresh=1 period=512 RUN
[    3.069946] ehci-omap ehci-omap.0: USB 2.0 started, EHCI 1.00
[    3.077667] usb usb1: default language 0x0409
[    3.077819] usb usb1: udev 1, busnum 1, minor = 0
[    3.077850] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
[    3.085021] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    3.092712] usb usb1: Product: OMAP-EHCI Host Controller
[    3.098388] usb usb1: Manufacturer: Linux 3.4.0-rc7-pm+debug+initramfs-01073-g0ecc382-dirty ehci_hcd
[    3.108093] usb usb1: SerialNumber: ehci-omap.0
[    3.115814] usb usb1: usb_probe_device
[    3.115844] usb usb1: configuration #1 chosen from 1 choice
[    3.117004] usb usb1: adding 1-0:1.0 (config #1, interface 0)
[    3.118804] hub 1-0:1.0: usb_probe_interface
[    3.118835] hub 1-0:1.0: usb_probe_interface - got id
[    3.118896] hub 1-0:1.0: USB hub found
[    3.123107] hub 1-0:1.0: 3 ports detected
[    3.127593] hub 1-0:1.0: standalone hub
[    3.127624] hub 1-0:1.0: individual port power switching
[    3.127624] hub 1-0:1.0: individual port over-current protection
[    3.127655] hub 1-0:1.0: power on to power good time: 20ms
[    3.128295] hub 1-0:1.0: local power source is good
[    3.128326] hub 1-0:1.0: enabling power on all ports
[    3.131164] /work/kernel/omap/pm/drivers/usb/core/inode.c: creating file '001'
[    3.132019] ehci-omap ehci-omap.0: ...powerup ports...
[    3.157348] usbcore: registered new interface driver cdc_wdm
[    3.163299] Initializing USB Mass Storage driver...
[    3.169464] usbcore: registered new interface driver usb-storage
[    3.175994] USB Mass Storage support registered.
[    3.182708] usbcore: registered new interface driver libusual
[    3.189819] usbcore: registered new interface driver usbtest
[    3.198333] mousedev: PS/2 mouse device common for all mice
[    3.211944] ads7846 spi1.0: touchscreen, irq 210
[    3.220855] input: ADS7846 Touchscreen as /devices/platform/omap2_mcspi.1/spi_master/spi1/spi1.0/input/input0
[    3.234436] hub 1-0:1.0: state 7 ports 3 chg 0000 evt 0000
[    3.241302] input: twl4030_pwrbutton as /devices/platform/omap_i2c.1/i2c-1/1-0049/twl4030_pwrbutton/input/input1
[    3.254791] twl_rtc twl_rtc: Power up reset detected.
[    3.260620] twl_rtc twl_rtc: Enabling TWL-RTC
[    3.270568] twl_rtc twl_rtc: rtc core: registered twl_rtc as rtc0
[    3.279052] i2c /dev entries driver
[    3.287353] Driver for 1-wire Dallas network protocol.
[    3.297821] omap_wdt: OMAP Watchdog Timer Rev 0x31: initial timeout 60 sec
[    3.306732] twl4030_wdt twl4030_wdt: Failed to register misc device
[    3.313629] twl4030_wdt: probe of twl4030_wdt failed with error -16
[    3.323944] cpuidle: using governor ladder
[    3.328491] cpuidle: using governor menu
[    3.566802] usbcore: registered new interface driver usbhid
[    3.572906] usbhid: USB HID core driver
[    3.576965] oprofile: hardware counters not available
[    3.582366] oprofile: using timer interrupt.
[    3.588195] TCP: cubic registered
[    3.591705] Initializing XFRM netlink socket
[    3.596557] NET: Registered protocol family 17
[    3.601470] NET: Registered protocol family 15
[    3.606628] Registering the dns_resolver key type
[    3.611907] VFP support v0.3: implementor 41 architecture 3 part 30 variant c rev 1
[    3.639282] ThumbEE CPU extension supported.
[    3.643981] sr_init: No PMIC hook to init smartreflex
[    3.649841] smartreflex smartreflex.0: omap_sr_probe: SmartReflex driver initialized
[    3.658996] smartreflex smartreflex.1: omap_sr_probe: SmartReflex driver initialized
[    3.668823] SmartReflex Class3 initialized
[    3.717376] clock: disabling unused clocks to save power
[    3.729797] VDVI: incomplete constraints, leaving on
[    3.735504] VDAC: incomplete constraints, leaving on
[    3.744567] input: gpio-keys as /devices/platform/gpio-keys/input/input2
[    3.756988] twl_rtc twl_rtc: setting system clock to 2000-01-01 00:00:00 UTC (946684800)
[    3.769744] smsc911x smsc911x.0: eth0: SMSC911x/921x identified at 0xd0888000, IRQ: 272
[    3.797485] IP-Config: Complete:
[    3.800903]      device=eth0, addr=192.168.1.157, mask=255.255.255.0, gw=192.168.1.254
[    3.809387]      host=overo, domain=, nis-domain=(none)
[    3.814971]      bootserver=192.168.1.5, rootserver=192.168.1.236, rootpath=
[    3.835144] Freeing init memory: 2804K
[    3.991333] mmc1: new SDIO card at address 0001
[    5.234283] hub 1-0:1.0: hub_suspend
[    5.234985] usb usb1: bus auto-suspend, wakeup 1
[    5.235015] ehci-omap ehci-omap.0: suspend root hub
/ # 

--------------090102000803000404000302--

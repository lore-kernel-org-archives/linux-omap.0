From: Sricharan R <r.sricharan@ti.com>
Subject: Re: [PATCH 2/6] ARM: OMAP2+: Remove board-omap4panda.c
Date: Mon, 17 Jun 2013 13:12:05 +0530
Message-ID: <51BEBDCD.3060104@ti.com>
References: <20130517191304.468.73487.stgit@localhost>
 <20130517191753.468.1734.stgit@localhost>
 <CACVXFVOp6n3RhZnWD_hRxqE8a8amPA5SRWfkVhz+yCGZTtGjvQ@mail.gmail.com>
 <20130612163124.GD8164@atomide.com> <20130612171407.GM8164@atomide.com>
 <51B98F1E.1000006@ti.com> <51B99B07.1050806@ti.com>
 <CACVXFVN3=hzWJEwHN5TXRoJ4mvVRVR+3=Tasw+gvLH3vsNHwUg@mail.gmail.com>
 <CACVXFVNzAMrkhrAMAmQ7ZdJdby2O4VdoD8BVHRF-O=rPKQMqbw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CACVXFVNzAMrkhrAMAmQ7ZdJdby2O4VdoD8BVHRF-O=rPKQMqbw@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ming Lei <tom.leiming@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Friday 14 June 2013 07:28 PM, Ming Lei wrote:
> On Fri, Jun 14, 2013 at 9:31 PM, Ming Lei <tom.leiming@gmail.com> wrote:
>> On Thu, Jun 13, 2013 at 6:12 PM, Sricharan R <r.sricharan@ti.com> wrote:
>>> On Thursday 13 June 2013 02:51 PM, Sricharan R wrote:
>>>> Hi Tony,
>>>> On Wednesday 12 June 2013 10:44 PM, Tony Lindgren wrote:
>>>>> * Tony Lindgren <tony@atomide.com> [130612 09:37]:
>>>>>> * Ming Lei <tom.leiming@gmail.com> [130603 08:34]:
>>>>>>> Hi,
>>>>>>>
>>>>>>> On Sat, May 18, 2013 at 3:17 AM, Tony Lindgren <tony@atomide.com> w=
rote:
>>>>>>>> We can now boot with device tree. If you don't want to update u-bo=
ot,
>>>>>>>> you can boot with appended DTB with the following instructions:
>>>>>>>>
>>>>>>>> 1. Make sure you have the appended DTB support in .config
>>>>>>>>
>>>>>>>>    CONFIG_ARM_APPENDED_DTB=3Dy
>>>>>>>>    CONFIG_ARM_ATAG_DTB_COMPAT=3Dy
>>>>>>>>    CONFIG_ARM_ATAG_DTB_COMPAT_CMDLINE_EXTEND=3Dy
>>>>>>>>
>>>>>>>> 2. Build the zImage
>>>>>>>>
>>>>>>>>    $ ARCH=3Darm CROSS_COMPILE=3D... make zImage
>>>>>>>>
>>>>>>>> 3. Build the device tree blobs
>>>>>>>>
>>>>>>>>    $ ARCH=3Darm CROSS_COMPILE=3D... make dtbs
>>>>>>>>
>>>>>>>> 4. Append the correct panda dtb to zImage
>>>>>>>>
>>>>>>>>    Depending on your hardware it's omap4-panda.dtb, omap4-panda-a4=
.dtb
>>>>>>>>    or omap4-panda-es.dtb.
>>>>>>>>
>>>>>>>>    $ cat arch/arm/boot/zImage arch/arm/boot/dts/omap4-panda-es.dtb=
 > /tmp/appended
>>>>>>>>
>>>>>>>> 5. Use mkimage to produce the appended device tree uImage
>>>>>>>>
>>>>>>>>    $ mkimage -A arm -O linux -T kernel -C none -a 0x80008000 -e 0x=
80008000 \
>>>>>>>>      -n "Linux" -d /tmp/appended /tmp/uImage
>>>>>>> I followed the above steps and tried devicetree on Pandaboard again=
st
>>>>>>> 3.10.0-rc3-next-20130528, and the board will hang during boot, but =
works
>>>>>>> well with legacy mode.
>>>>>>>
>>>>>>>          Hardware: Pandaboard A1
>>>>>>>          dtb: omap4-panda.dtb
>>>>>>>
>>>>>>> See 'dmesg' on below link:
>>>>>>>
>>>>>>>          http://kernel.ubuntu.com/~ming/up/panda-dts.dmesg
>>>>>>>
>>>>>> Hmm looks like it boots to init. Maybe add initcall_debug to the cmd=
line in
>>>>>> case there's some late_initcall that causes the issue. It's probably=
 some
>>>>>> trivial issue causing it.
>>>>> Sricharan, maybe give this a quick try if you have the original panda=
board?
>>>>> I only have pandaboard es.
>>>>>
>>>>> Regards,
>>>>>
>>>>> Tony
>>>> I tried your cleanup branch omap-for-v3.11/cleanup on panda board and =
it booted
>>>>  to prompt fine.
>>>>             Hardware: Pandaboard A1   dtb: omap4-panda.dtb
>>>>
>>>>   git pull on linux-next branch was not working though.
>>>>
>>>     Ok, tested in linux-next as well and it booted fine with DTB.
>>>      HW: OMAP4430ES2.1 PANDA A1 version DTB: OMAP4-PANDA.DTB
>>>
>>>     Booted with ramdisk and mmc FS
>>>
>>> commit c04efed734409f5a44715b54a6ca1b54b0ccf215
>>> Author: Stephen Rothwell <sfr@canb.auug.org.au>
>>> Date:   Fri Jun 7 16:40:02 2013 +1000
>>>
>>>     Add linux-next specific files for 20130607
>> Looks linux-next-20130607 is broken, see below:
>>
>>   LD [M]  drivers/usb/gadget/g_ncm.o
>> drivers/usb/musb/omap2430.c: In function 'omap2430_probe':
>> drivers/usb/musb/omap2430.c:571:2: error: 'musb_resources' undeclared
>> (first use in this function)
>> drivers/usb/musb/omap2430.c:571:2: note: each undeclared identifier is
>> reported only once for each function it appears in
>> drivers/usb/musb/omap2430.c:571:2: error: bit-field '<anonymous>'
>> width not an integer constant
>> drivers/usb/musb/omap2430.c:585:4: error: bit-field '<anonymous>'
>> width not an integer constant
>> make[3]: *** [drivers/usb/musb/omap2430.o] Error 1
>> make[3]: *** Waiting for unfinished jobs....
>> make[2]: *** [drivers/usb/musb] Error 2
>> make[2]: *** Waiting for unfinished jobs....
>> make[1]: *** [drivers/usb] Error 2
>> make: *** [drivers] Error 2
>> install kernel and modules
>>
>> DEPMOD  3.10.0-rc4-next-20130607+
> Even I disable musb so that kernel building is OK, but the kernel with dtb
> still can't boot, see attachment 'dmesg' and config.
>
>
> Thanks,
I am not sure how both of us are different. I was testing 20130607 with
 an omap2plusdefconfig. Also i was using a minimal busy box file system..

Is there anything specific FS that you want me to try ?
I am using the latest u-boot version.


U-Boot SPL 2013.07-rc1-00010-gdfdb3d3 (Jun 17 2013 - 13:09:51)
OMAP4430 ES2.1
OMAP SD/MMC: 0
reading u-boot.img
reading u-boot.img


U-Boot 2013.07-rc1-00010-gdfdb3d3 (Jun 17 2013 - 13:09:51)

CPU  : OMAP4430 ES2.1
Board: OMAP4 Panda
I2C:   ready
DRAM:  1 GiB
MMC:   OMAP SD/MMC: 0
Using default environment

In:    serial
Out:   serial
Err:   serial
Net:   No ethernet found.
Hit any key to stop autoboot:  0
Panda #
Panda # setenv bootargs root=3D/dev/ram0 rw console=3DttyO2,115200n8 initrd=
=3D0x81600000,20M ramdisk_size=3D20480 earlyprintk
Panda # mmc dev 0
mmc0 is current device
Panda # fatload mmc 0 0x80300000 uImage
reading uImage
4394007 bytes read in 300 ms (14 MiB/s)
Panda # fatload mmc 0 0x81600000 bb.raw
reading bb.raw
10240000 bytes read in 722 ms (13.5 MiB/s)
Panda # bootm 0x80300000
## Booting kernel from Legacy Image at 80300000 ...
   Image Name:   Linux
   Image Type:   ARM Linux Kernel Image (uncompressed)
   Data Size:    4393943 Bytes =3D 4.2 MiB
   Load Address: 80008000
   Entry Point:  80008000
   Verifying Checksum ... OK
   Loading Kernel Image ... OK
OK

Starting kernel ...

[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 3.10.0-rc4-next-20130607 (a0393807@uda0393807)=
 (gcc version 4.6.3 (Sourcery CodeBench Lite 2012.03-57) ) #18 SMP Mon Jun =
17 12:55:05 IST 2013
[    0.000000] CPU: ARMv7 Processor [411fc092] revision 2 (ARMv7), cr=3D10c=
53c7d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instr=
uction cache
[    0.000000] Machine: OMAP4 Panda board
[    0.000000] cma: CMA: reserved 16 MiB at ae800000
[    0.000000] Memory policy: ECC disabled, Data cache writealloc
[    0.000000] OMAP4430 ES2.1
[    0.000000] PERCPU: Embedded 9 pages/cpu @c15d5000 s13440 r8192 d15232 u=
36864
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Tota=
l pages: 260368
[    0.000000] Kernel command line: root=3D/dev/ram0 rw console=3DttyO2,115=
200n8 initrd=3D0x81600000,20M ramdisk_size=3D20480 earlyprintk
[    0.000000] PID hash table entries: 4096 (order: 2, 16384 bytes)
[    0.000000] Dentry cache hash table entries: 131072 (order: 7, 524288 by=
tes)
[    0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144 byte=
s)
[    0.000000] Memory: 987436K/1047552K available (5619K kernel code, 603K =
rwdata, 1908K rodata, 393K init, 5521K bss, 60116K reserved, 269312K highme=
m)
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
[    0.000000]     vmalloc : 0xf0000000 - 0xff000000   ( 240 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xef800000   ( 760 MB)
[    0.000000]     pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
[    0.000000]     modules : 0xbf000000 - 0xbfe00000   (  14 MB)
[    0.000000]       .text : 0xc0008000 - 0xc07620e8   (7529 kB)
[    0.000000]       .init : 0xc0763000 - 0xc07c5480   ( 394 kB)
[    0.000000]       .data : 0xc07c6000 - 0xc085ccc8   ( 604 kB)
[    0.000000]        .bss : 0xc085ccc8 - 0xc0dc10f0   (5522 kB)
[    0.000000] Hierarchical RCU implementation.
[    0.000000] NR_IRQS:16 nr_irqs:16 16
[    0.000000] OMAP clockevent source: timer1 at 32768 Hz
[    0.000000] sched_clock: 32 bits at 32kHz, resolution 30517ns, wraps eve=
ry 131071999ms
[    0.000000] OMAP clocksource: 32k_counter at 32768 Hz
[    0.000000] Console: colour dummy device 80x30
[    0.000000] Lock dependency validator: Copyright (c) 2006 Red Hat, Inc.,=
 Ingo Molnar
[    0.000000] ... MAX_LOCKDEP_SUBCLASSES:  8
[    0.000000] ... MAX_LOCK_DEPTH:          48
[    0.000000] ... MAX_LOCKDEP_KEYS:        8191
[    0.000000] ... CLASSHASH_SIZE:          4096
[    0.000000] ... MAX_LOCKDEP_ENTRIES:     16384
[    0.000000] ... MAX_LOCKDEP_CHAINS:      32768
[    0.000000] ... CHAINHASH_SIZE:          16384
[    0.000000]  memory used by lock dependency info: 3695 kB
[    0.000000]  per task-struct memory footprint: 1152 bytes
[    0.001403] Calibrating delay loop... 1191.11 BogoMIPS (lpj=3D5955584)
[    0.079742] pid_max: default: 32768 minimum: 301
[    0.080535] Security Framework initialized
[    0.080780] Mount-cache hash table entries: 512
[    0.085571] CPU: Testing write buffer coherency: ok
[    0.087493] CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
[    0.087829] Setting up static identity map for 0xc0556058 - 0xc05560c8
[    0.087890] L310 cache controller enabled
[    0.087921] l2x0: 16 ways, CACHE_ID 0x410000c4, AUX_CTRL 0x7e470000, Cac=
he size: 1048576 B
[    0.093048] CPU1: Booted secondary processor
[    0.177764] CPU1: thread -1, cpu 1, socket 0, mpidr 80000001
[    0.178283] Brought up 2 CPUs
[    0.178314] SMP: Total of 2 processors activated (2387.96 BogoMIPS).
[    0.178314] CPU: All CPU(s) started in SVC mode.
[    0.181152] devtmpfs: initialized
[    0.254455] pinctrl core: initialized pinctrl subsystem
[    0.258117] regulator-dummy: no parameters
[    0.261657] NET: Registered protocol family 16
[    0.270538] DMA: preallocated 256 KiB pool for atomic coherent allocatio=
ns
[    0.272033] omap-gpmc omap-gpmc: GPMC revision 6.0
[    0.281036] OMAP GPIO hardware version 0.1
[    0.295837] omap_mux_init: Add partition: #1: core, flags: 3
[    0.298095] omap_mux_init: Add partition: #2: wkup, flags: 3
[    0.298309] error setting wl12xx data: -38
[    0.298583] omap_mux_get_by_name: Could not find signal sys_nirq
[    0.303375] omap_mux_get_by_name: Could not find signal uart1_rx.uart1_rx
[    0.384521] hw-breakpoint: found 5 (+1 reserved) breakpoint and 1 watchp=
oint registers.
[    0.384521] hw-breakpoint: maximum watchpoint size is 4 bytes.
[    0.398803] OMAP DMA hardware revision 0.0
[    0.402832] ARM PMU: not yet supported on OMAP4430 due to missing CTI dr=
iver
[    0.449371] bio: create slab <bio-0> at 0
[    0.514038] omap-dma-engine omap-dma-engine: OMAP DMA engine driver
[    0.515258] vwl1271: 1800 mV
[    0.516174] hsusb1_reset: 3300 mV
[    0.516967] hsusb1_vcc: 3300 mV
[    0.522064] SCSI subsystem initialized
[    0.523773] usbcore: registered new interface driver usbfs
[    0.524139] usbcore: registered new interface driver hub
[    0.524658] usbcore: registered new device driver usb
[    0.528869] omap_i2c omap_i2c.1: bus 1 rev0.10 at 400 kHz
[    0.529907] omap_i2c omap_i2c.2: bus 2 rev0.10 at 400 kHz
[    0.531280] omap_i2c omap_i2c.3: bus 3 rev0.10 at 100 kHz
[    0.532226] omap_i2c omap_i2c.4: bus 4 rev0.10 at 400 kHz
[    0.538391] Switching to clocksource 32k_counter
[    0.655364] NET: Registered protocol family 2
[    0.657409] TCP established hash table entries: 8192 (order: 4, 65536 by=
tes)
[    0.657806] TCP bind hash table entries: 8192 (order: 6, 294912 bytes)
[    0.660980] TCP: Hash tables configured (established 8192 bind 8192)
[    0.661315] TCP: reno registered
[    0.661346] UDP hash table entries: 512 (order: 3, 40960 bytes)
[    0.661773] UDP-Lite hash table entries: 512 (order: 3, 40960 bytes)
[    0.663421] NET: Registered protocol family 1
[    0.664733] RPC: Registered named UNIX socket transport module.
[    0.664764] RPC: Registered udp transport module.
[    0.664764] RPC: Registered tcp transport module.
[    0.664764] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.665740] Trying to unpack rootfs image as initramfs...
[    0.666931] rootfs image is not initramfs (junk in compressed archive); =
looks like an initrd
[    0.819061] Freeing initrd memory: 20480K (c1600000 - c2a00000)
[    0.819183] NetWinder Floating Point Emulator V0.97 (double precision)
[    1.007995] bounce pool size: 64 pages
[    1.008575] VFS: Disk quotas dquot_6.5.2
[    1.009033] Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
[    1.011779] NFS: Registering the id_resolver key type
[    1.012207] Key type id_resolver registered
[    1.012237] Key type id_legacy registered
[    1.012390] jffs2: version 2.2. (NAND) (SUMMARY)  =A9 2001-2006 Red Hat,=
 Inc.
[    1.013031] msgmni has been set to 1474
[    1.016387] io scheduler noop registered
[    1.016418] io scheduler deadline registered
[    1.016510] io scheduler cfq registered (default)
[    1.020660] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    1.027069] omap_uart.0: ttyO0 at MMIO 0x4806a000 (irq =3D 104) is a OMA=
P UART0
[    1.029296] omap_uart.1: ttyO1 at MMIO 0x4806c000 (irq =3D 105) is a OMA=
P UART1
[    1.030670] omap_uart.2: ttyO2 at MMIO 0x48020000 (irq =3D 106) is a OMA=
P UART2
[    1.724426] console [ttyO2] enabled
[    1.729583] omap_uart.3: ttyO3 at MMIO 0x4806e000 (irq =3D 102) is a OMA=
P UART3
[    1.765686] brd: module loaded
[    1.784973] loop: module loaded
[    1.791503] Skipping twl internal clock init and using bootloader value =
(unknown osc rate)
[    1.802978] twl 1-0048: PIH (irq 39) chaining IRQs 418..438
[    1.811218] VUSB: 3300 mV normal standby
[    1.816864] vdd_mpu: 500 <--> 1500 mV normal
[    1.823730] vdd_iva: 500 <--> 1500 mV normal
[    1.829803] vdd_core: 500 <--> 1500 mV normal
[    1.836334] V1V8: 1800 mV normal standby
[    1.841979] V2V1: 2100 mV normal standby
[    1.847717] VMMC: 1200 <--> 3000 mV at 3000 mV normal standby
[    1.855773] VPP: 1800 <--> 2500 mV at 1900 mV normal standby
[    1.864196] VCXIO: 1800 mV normal standby
[    1.868499] VCXIO: supplied by V2V1
[    1.875030] VDAC: 1800 mV normal standby
[    1.879333] VDAC: supplied by V2V1
[    1.885223] VAUX2_6030: 1200 <--> 2800 mV at 1800 mV normal standby
[    1.893768] VAUX3_6030: 1000 <--> 3000 mV at 1200 mV normal standby
[    1.903076] VANA: 2100 mV normal standby
[    1.917877] mtdoops: mtd device (mtddev=3Dname/number) must be supplied
[    1.934997] usbcore: registered new interface driver asix
[    1.941284] usbcore: registered new interface driver ax88179_178a
[    1.948089] usbcore: registered new interface driver cdc_ether
[    1.954681] usbcore: registered new interface driver smsc95xx
[    1.961242] usbcore: registered new interface driver net1080
[    1.967559] usbcore: registered new interface driver cdc_subset
[    1.974243] usbcore: registered new interface driver zaurus
[    1.980621] usbcore: registered new interface driver cdc_ncm
[    1.988220] usbcore: registered new interface driver cdc_wdm
[    1.994659] usbcore: registered new interface driver usb-storage
[    2.001464] usbcore: registered new interface driver usbtest
[    2.009277] mousedev: PS/2 mouse device common for all mice
[    2.020721] twl_rtc twl_rtc: Enabling TWL-RTC
[    2.030181] twl_rtc twl_rtc: rtc core: registered twl_rtc as rtc0
[    2.059692] i2c /dev entries driver
[    2.067108] Driver for 1-wire Dallas network protocol.
[    2.076293] omap_wdt: OMAP Watchdog Timer Rev 0x00: initial timeout 60 s=
ec
[    2.086364] omap-dma-engine omap-dma-engine: allocating channel for 62
[    2.093414] omap-dma-engine omap-dma-engine: allocating channel for 61
[    2.139251] omap-dma-engine omap-dma-engine: allocating channel for 60
[    2.146209] omap-dma-engine omap-dma-engine: allocating channel for 59
[    2.262664] ledtrig-cpu: registered to indicate activity on CPUs
[    2.270233] usbcore: registered new interface driver usbhid
[    2.276153] usbhid: USB HID core driver
[    2.281402] oprofile: no performance counters
[    2.288024] oprofile: using timer interrupt.
[    2.293334] TCP: cubic registered
[    2.296844] Initializing XFRM netlink socket
[    2.301544] NET: Registered protocol family 17
[    2.306365] NET: Registered protocol family 15
[    2.311614] Key type dns_resolver registered
[    2.316284] VFP support v0.3: implementor 41 architecture 3 part 30 vari=
ant 9 rev 1
[    2.334320] Power Management for TI OMAP4.
[    2.338684] OMAP4 PM: u-boot >=3D v2012.07 is required for full PM suppo=
rt
[    2.346069] ThumbEE CPU extension supported.
[    2.354187] VANA: incomplete constraints, leaving on
[    2.361175] VDAC: incomplete constraints, leaving on
[    2.367614] VUSB: incomplete constraints, leaving on
[    2.377258] twl_rtc twl_rtc: setting system clock to 2000-01-01 00:03:17=
 UTC (946684997)
[    2.388793] RAMDISK: ext2 filesystem found at block 0
[    2.395324] RAMDISK: Loading 10000KiB [1 disk] into ram disk... [    2.4=
10461] mmc0: host does not support reading read-only switch. assuming write=
-enable.
[    2.424896] mmc0: new high speed SD card at address 0002
[    2.436248] mmcblk0: mmc0:0002 00000 1.86 GiB
[    2.455200]  mmcblk0: p1 p2
done.
[    2.858886] EXT2-fs (ram0): warning: mounting unchecked fs, running e2fs=
ck is recommended
[    2.858886] VFS: Mounted root (ext2 filesystem) on device 1:0.
[    2.874725] devtmpfs: mounted
[    2.879028] Freeing unused kernel memory: 392K (c0763000 - c07c5000)
Mounting proc : OK
Mounting sysfs : OK
Mounting /dev : OK
Creating local mdev devices
umount: can't umount /mnt/mmc: Invalid argument

******************************************
Starting System Init for 6430EVM-6430
Release: OpnSrc
******************************************
Saving kernel ring buffer : OK
Mounting devpts : OK
Setting up networking
Configuring lo : OK
Configuring eth0 : ifconfig: eth0: error fetching interface information: De=
vice not found
ifup: can't open '/etc/network/interfaces': No such file or directory
Failed
Starting syslogd : OK
Starting klogd : OK
Mounting filesystems : mount: according to /proc/mounts, none is already mo=
unted on /dev/pts
mount: according to /proc/mounts, /proc is already mounted on /proc
OK

Please press Enter to activate this console.
#


Regards,
 Sricharan

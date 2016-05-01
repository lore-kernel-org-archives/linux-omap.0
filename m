From: Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 00/10] Get MUSB PM runtime working again
Date: Sun, 1 May 2016 09:33:01 +0300
Message-ID: <5725A31D.8020508@gmail.com>
References: <1461864800-29979-1-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------050507090701030407030302"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1461864800-29979-1-git-send-email-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, George Cherian <george.cherian-l0cyMroinI0@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

This is a multi-part message in MIME format.
--------------050507090701030407030302
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit

Hi

On 28.04.2016 20:33, Tony Lindgren wrote:
> Hi all,
>
> Here's a series of fixes to get MUSB PM runtime working again.
>
> I can now test PM runtime with the 2430 glue layer with this set,
> so adding PM runtime support for other glue layers should be
> possible.
>
> Regards,
>
> Tony
>
>

Unfortunately that makes my n900 unbootable with USB cable detached, see 
the attached file (at [  152.121673]) when there is USB cable. I guess 
we're missing a couple of pm_runtime_get()/put() calls.

Ivo

--------------050507090701030407030302
Content-Type: text/x-log;
 name="dmesg.log"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="dmesg.log"

[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 4.6.0-rc4+ (ivo@ivo-H81M-S2PV) (gcc version =
4.7.2 20120701 (prerelease) (Linaro GCC 4.7-2012.07) ) #2 PREEMPT Sun May=
 1 08:43:54 EEST 2016
[    0.000000] CPU: ARMv7 Processor [411fc083] revision 3 (ARMv7), cr=3D1=
0c5387d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT nonaliasing =
instruction cache
[    0.000000] Machine model: Nokia N900
[    0.000000] omapfb: reserved 7340032 bytes at 0x8f800000
[    0.000000] Reserved memory: initialized node omapfb, compatible id ti=
,omapfb-memsize
[    0.000000] dsp: reserved 9437184 bytes at 0x8e000000
[    0.000000] Reserved memory: initialized node dsp, compatible id ti,ds=
p-memsize
[    0.000000] Memory policy: Data cache writeback
[    0.000000] On node 0 totalpages: 65280
[    0.000000] free_area_init_node: node 0, pgdat c093afdc, node_mem_map =
cf5f9000
[    0.000000]   Normal zone: 512 pages used for memmap
[    0.000000]   Normal zone: 0 pages reserved
[    0.000000]   Normal zone: 65280 pages, LIFO batch:15
[    0.000000] CPU: All CPU(s) started in SVC mode.
[    0.000000] OMAP3430/3530 ES3.1 (l2cache iva sgx neon isp )
[    0.000000] pcpu-alloc: s0 r0 d32768 u32768 alloc=3D1*32768
[    0.000000] pcpu-alloc: [0] 0=20
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  To=
tal pages: 64768
[    0.000000] Kernel command line: rootdelay root=3D/dev/ram0 mtdoops.mt=
ddev=3Dlog log_buf_len=3D1M
[    0.000000] log_buf_len: 1048576 bytes
[    0.000000] early log buf free: 64056(97%)
[    0.000000] PID hash table entries: 1024 (order: 0, 4096 bytes)
[    0.000000] Dentry cache hash table entries: 32768 (order: 5, 131072 b=
ytes)
[    0.000000] Inode-cache hash table entries: 16384 (order: 4, 65536 byt=
es)
[    0.000000] Memory: 219868K/261120K available (5296K kernel code, 238K=
 rwdata, 1648K rodata, 1024K init, 256K bss, 41252K reserved, 0K cma-rese=
rved, 0K highmem)
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
[    0.000000]     vmalloc : 0xd0800000 - 0xff800000   ( 752 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xd0000000   ( 256 MB)
[    0.000000]     pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
[    0.000000]     modules : 0xbf000000 - 0xbfe00000   (  14 MB)
[    0.000000]       .text : 0xc0008000 - 0xc07c80c4   (7937 kB)
[    0.000000]       .init : 0xc0800000 - 0xc0900000   (1024 kB)
[    0.000000]       .data : 0xc0900000 - 0xc093bb80   ( 239 kB)
[    0.000000]        .bss : 0xc093bb80 - 0xc097bb80   ( 256 kB)
[    0.000000] SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D1,=
 Nodes=3D1
[    0.000000] Preemptible hierarchical RCU implementation.
[    0.000000] 	Build-time adjustment of leaf fanout to 32.
[    0.000000] NR_IRQS:16 nr_irqs:16 16
[    0.000000] IRQ: Found an INTC at 0xfa200000 (revision 4.0) with 96 in=
terrupts
[    0.000000] Clocking rate (Crystal/Core/MPU): 19.2/332/500 MHz
[    0.000000] OMAP clockevent source: timer1 at 32768 Hz
[    0.000000] clocksource: 32k_counter: mask: 0xffffffff max_cycles: 0xf=
fffffff, max_idle_ns: 58327039986419 ns
[    0.000030] sched_clock: 32 bits at 32kHz, resolution 30517ns, wraps e=
very 65535999984741ns
[    0.000030] OMAP clocksource: 32k_counter at 32768 Hz
[    0.000579] Console: colour dummy device 80x30
[    0.002075] console [tty0] enabled
[    0.002136] Calibrating delay loop... 496.43 BogoMIPS (lpj=3D2482176)
[    0.048492] pid_max: default: 32768 minimum: 301
[    0.048645] Security Framework initialized
[    0.048767] Mount-cache hash table entries: 1024 (order: 0, 4096 bytes=
)
[    0.048828] Mountpoint-cache hash table entries: 1024 (order: 0, 4096 =
bytes)
[    0.050079] CPU: Testing write buffer coherency: ok
[    0.050750] Setting up static identity map for 0x80100000 - 0x80100058=

[    0.055541] devtmpfs: initialized
[    0.101013] VFP support v0.3: implementor 41 architecture 3 part 30 va=
riant c rev 1
[    0.101806] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xfffff=
fff, max_idle_ns: 19112604462750000 ns
[    0.102386] pinctrl core: initialized pinctrl subsystem
[    0.104370] NET: Registered protocol family 16
[    0.105987] DMA: preallocated 256 KiB pool for atomic coherent allocat=
ions
[    0.126647] omap_hwmod: mcbsp2_sidetone using broken dt data from mcbs=
p
[    0.127380] omap_hwmod: mcbsp3_sidetone using broken dt data from mcbs=
p
[    0.198150] cpuidle: using governor ladder
[    0.228088] cpuidle: using governor menu
[    0.228790] Reprogramming SDRC clock to 332000000 Hz
[    0.236907] OMAP GPIO hardware version 2.5
[    0.246704] irq: no irq domain found for /ocp/l4@48000000/scm@2000/pin=
mux@30 !
[    0.247436] irq: no irq domain found for /ocp/l4@48000000/scm@2000/pin=
mux@30 !
[    0.262664] omap-gpmc 6e000000.gpmc: could not find pctldev for node /=
ocp/l4@48000000/scm@2000/pinmux@30/pinmux_gpmc_pins, deferring probe
[    0.267913] RX-51: Add gpio switches
[    0.268066] RX-51: Enabling ARM errata 430973 workaround
[    0.269866] RX-51: Registering OMAP3 HWRNG device
[    0.274169] platform 48050000.dss: assigned reserved memory node omapf=
b
[    0.274505] hw-breakpoint: debug architecture 0x4 unsupported.
[    0.275543] Reserving DMA channels 0 and 1 for HS ROM code
[    0.275634] OMAP DMA hardware revision 4.0
[    0.297760] omap-dma-engine 48056000.dma-controller: OMAP DMA engine d=
river
[    0.303863] omap-iommu 480bd400.mmu: 480bd400.mmu registered
[    0.304199] omap-iommu 5d000000.mmu: 5d000000.mmu registered
[    0.304992] usbcore: registered new interface driver usbfs
[    0.305175] usbcore: registered new interface driver hub
[    0.305389] usbcore: registered new device driver usb
[    0.306549] omap_i2c 48070000.i2c: could not find pctldev for node /oc=
p/l4@48000000/scm@2000/pinmux@30/pinmux_i2c1_pins, deferring probe
[    0.306701] omap_i2c 48072000.i2c: could not find pctldev for node /oc=
p/l4@48000000/scm@2000/pinmux@30/pinmux_i2c2_pins, deferring probe
[    0.306854] omap_i2c 48060000.i2c: could not find pctldev for node /oc=
p/l4@48000000/scm@2000/pinmux@30/pinmux_i2c3_pins, deferring probe
[    0.308319] omap-mailbox 48094000.mailbox: omap mailbox rev 0x40
[    0.308990] Advanced Linux Sound Architecture Driver Initialized.
[    0.310821] clocksource: Switched to clocksource 32k_counter
[    0.311157] VFS: Disk quotas dquot_6.6.0
[    0.311309] VFS: Dquot-cache hash table entries: 1024 (order 0, 4096 b=
ytes)
[    0.331024] NET: Registered protocol family 2
[    0.332336] TCP established hash table entries: 2048 (order: 1, 8192 b=
ytes)
[    0.332458] TCP bind hash table entries: 2048 (order: 1, 8192 bytes)
[    0.332550] TCP: Hash tables configured (established 2048 bind 2048)
[    0.332733] UDP hash table entries: 256 (order: 0, 4096 bytes)
[    0.332824] UDP-Lite hash table entries: 256 (order: 0, 4096 bytes)
[    0.333129] NET: Registered protocol family 1
[    0.333679] Trying to unpack rootfs image as initramfs...
[    0.334228] rootfs image is not initramfs (junk in compressed archive)=
; looks like an initrd
[    0.439727] Freeing initrd memory: 12468K (ce900000 - cf52d000)
[    0.444152] futex hash table entries: 256 (order: -1, 3072 bytes)
[    0.445190] workingset: timestamp_bits=3D28 max_order=3D16 bucket_orde=
r=3D0
[    0.465332] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[    0.467803] io scheduler noop registered
[    0.467895] io scheduler deadline registered
[    0.468353] io scheduler cfq registered (default)
[    0.469818] pinctrl-single 48002030.pinmux: 284 pins at pa fa002030 si=
ze 568
[    0.470275] pinctrl-single 48002a00.pinmux: 46 pins at pa fa002a00 siz=
e 92
[    0.471252] pinctrl-single 480025d8.pinmux: 18 pins at pa fa0025d8 siz=
e 36
[    0.473754] 48050000.dss supply vdda_video not found, using dummy regu=
lator
[    0.474090] OMAP DSS rev 2.0
[    0.474426] omapdss_dss 48050000.dss: bound 48050400.dispc (ops dispc_=
component_ops)
[    0.474761] omapdss_dss 48050000.dss: bound 48050c00.encoder (ops venc=
_component_ops)
[    0.476135] omapfb omapfb: no displays
[    0.476348] omapfb omapfb: failed to setup omapfb
[    0.478881] 4806c000.serial: ttyO1 at MMIO 0x4806c000 (irq =3D 89, bas=
e_baud =3D 3000000) is a OMAP UART1
[    0.480072] 49020000.serial: ttyO2 at MMIO 0x49020000 (irq =3D 90, bas=
e_baud =3D 3000000) is a OMAP UART2
[    0.482025] omap3_rom_rng: initializing
[    0.511047] brd: module loaded
[    0.521209] acx565akm spi1.2: omapfb: acx565akm rev ad LCD detected
[    0.526031] HS USB OTG: no transceiver configured
[    0.526123] musb-hdrc musb-hdrc.0.auto: musb_init_controller failed wi=
th status -517
[    0.526550] udc-core: couldn't find an available UDC - added [g_nokia]=
 to list of pending drivers
[    0.527404] i2c /dev entries driver
[    0.528411] omap_hsmmc 4809c000.mmc: Got CD GPIO
[    0.585113] rx51-audio n900-audio: could not get speaker enable gpio
[    0.585968] Initializing XFRM netlink socket
[    0.586090] NET: Registered protocol family 17
[    0.586242] NET: Registered protocol family 15
[    0.586364] NET: Registered protocol family 35
[    0.586608] Key type dns_resolver registered
[    0.586914] omap2_set_init_voltage: unable to find boot up OPP for vdd=
_mpu_iva
[    0.587005] omap2_set_init_voltage: unable to set vdd_mpu_iva
[    0.587066] omap2_set_init_voltage: unable to find boot up OPP for vdd=
_core
[    0.587127] omap2_set_init_voltage: unable to set vdd_core
[    0.592559] ThumbEE CPU extension supported.
[    0.592651] SmartReflex Class3 initialized
[    0.593109] Bootup reason: pwr_key
[    0.593170] OMAP GPIO switch handler initializing
[    0.593933] gpio-switch: gpio_reguest failed for cam_focus 68
[    0.594238] gpio-switch: gpio_reguest failed for cam_launch 69
[    0.594512] gpio-switch: gpio_reguest failed for cam_shutter 110
[    0.596252] gpio-switch: gpio_reguest failed for headphone 177
[    0.596527] gpio-switch: gpio_reguest failed for kb_lock 113
[    0.596832] gpio-switch: gpio_reguest failed for proximity 89
[    0.597106] gpio-switch: gpio_reguest failed for sleep_ind 162
[    0.597381] gpio-switch: gpio_reguest failed for slide 71
[    0.597473] slide (GPIO 71) is now open
[    0.597534] proximity (GPIO 89) is now open
[    0.597564] kb_lock (GPIO 113) is now closed
[    0.597625] headphone (GPIO 177) is now connected
[    0.597656] cam_shutter (GPIO 110) is now closed
[    0.597717] cam_launch (GPIO 69) is now active
[    0.597747] cam_focus (GPIO 68) is now active
[    0.599151] registered taskstats version 1
[    0.601684] omap-gpmc 6e000000.gpmc: GPMC revision 5.0
[    0.601776] gpmc_mem_init: disabling cs 0 mapped at 0x0-0x1000000
[    0.602416] omap2-onenand omap2-onenand: initializing on CS0, phys bas=
e 0x01000000, virtual base d0940000, freq 83 MHz
[    0.602539] OneNAND Manufacturer: Numonyx (0x20)
[    0.602569] Muxed OneNAND 256MB 1.8V 16-bit (0x40)
[    0.602600] OneNAND version =3D 0x0031
[    0.602661] Chip support all block unlock
[    0.602661] Chip has 2 plane
[    0.604248] Scanning device for bad blocks
[    0.698455] 6 ofpart partitions found on MTD device omap2-onenand
[    0.698516] Creating 6 MTD partitions on "omap2-onenand":
[    0.698577] 0x000000000000-0x000000020000 : "bootloader"
[    0.699462] 0x000000020000-0x000000080000 : "config"
[    0.700195] 0x000000080000-0x0000000c0000 : "log"
[    0.702270] onenand_wait: ECC error =3D 0x4844
[    0.702331] mtdoops: read failure at 131072 (8 of 8 read), err -74
[    0.702423] onenand_wait: ECC error =3D 0x4848
[    0.702484] mtdoops: read failure at 135168 (8 of 8 read), err -74
[    0.702575] onenand_wait: correctable ECC error =3D 0x4444
[    0.702636] onenand_wait: ECC error =3D 0x8484
[    0.702667] mtdoops: read failure at 143360 (8 of 8 read), err -74
[    0.702758] onenand_wait: ECC error =3D 0x8884
[    0.702819] mtdoops: read failure at 147456 (8 of 8 read), err -74
[    0.702911] onenand_wait: ECC error =3D 0x8488
[    0.702941] mtdoops: read failure at 151552 (8 of 8 read), err -74
[    0.703033] onenand_wait: ECC error =3D 0x8884
[    0.703094] mtdoops: read failure at 155648 (8 of 8 read), err -74
[    0.703155] onenand_wait: ECC error =3D 0x4884
[    0.703216] mtdoops: read failure at 159744 (8 of 8 read), err -74
[    0.703308] onenand_wait: ECC error =3D 0x8848
[    0.703338] mtdoops: read failure at 163840 (8 of 8 read), err -74
[    0.703430] onenand_wait: ECC error =3D 0x8444
[    0.703491] mtdoops: read failure at 167936 (8 of 8 read), err -74
[    0.703582] onenand_wait: ECC error =3D 0x8884
[    0.703613] mtdoops: read failure at 172032 (8 of 8 read), err -74
[    0.703704] onenand_wait: ECC error =3D 0x8484
[    0.703765] mtdoops: read failure at 176128 (8 of 8 read), err -74
[    0.703857] onenand_wait: ECC error =3D 0x4844
[    0.703887] mtdoops: read failure at 180224 (8 of 8 read), err -74
[    0.703979] onenand_wait: ECC error =3D 0x8448
[    0.704040] mtdoops: read failure at 184320 (8 of 8 read), err -74
[    0.704132] onenand_wait: ECC error =3D 0x4888
[    0.704162] mtdoops: read failure at 188416 (8 of 8 read), err -74
[    0.704254] onenand_wait: ECC error =3D 0x8444
[    0.704315] mtdoops: read failure at 192512 (8 of 8 read), err -74
[    0.704406] onenand_wait: ECC error =3D 0x8884
[    0.704437] mtdoops: read failure at 196608 (8 of 8 read), err -74
[    0.704528] onenand_wait: ECC error =3D 0x8848
[    0.704589] mtdoops: read failure at 200704 (8 of 8 read), err -74
[    0.704650] onenand_wait: ECC error =3D 0x4884
[    0.704711] mtdoops: read failure at 204800 (8 of 8 read), err -74
[    0.704803] onenand_wait: ECC error =3D 0x8848
[    0.704864] mtdoops: read failure at 208896 (8 of 8 read), err -74
[    0.704925] onenand_wait: ECC error =3D 0x4484
[    0.704986] mtdoops: read failure at 212992 (8 of 8 read), err -74
[    0.705078] onenand_wait: ECC error =3D 0x8488
[    0.705108] mtdoops: read failure at 217088 (8 of 8 read), err -74
[    0.705200] onenand_wait: ECC error =3D 0x8484
[    0.705261] mtdoops: read failure at 221184 (8 of 8 read), err -74
[    0.705352] onenand_wait: ECC error =3D 0x8488
[    0.705383] mtdoops: read failure at 225280 (8 of 8 read), err -74
[    0.705474] onenand_wait: ECC error =3D 0x8884
[    0.705535] mtdoops: read failure at 229376 (8 of 8 read), err -74
[    0.705627] onenand_wait: ECC error =3D 0x8848
[    0.705657] mtdoops: read failure at 233472 (8 of 8 read), err -74
[    0.705749] onenand_wait: ECC error =3D 0x8444
[    0.705810] mtdoops: read failure at 237568 (8 of 8 read), err -74
[    0.705902] onenand_wait: ECC error =3D 0x8448
[    0.705932] mtdoops: read failure at 241664 (8 of 8 read), err -74
[    0.706024] onenand_wait: ECC error =3D 0x8444
[    0.706085] mtdoops: read failure at 245760 (8 of 8 read), err -74
[    0.706176] onenand_wait: ECC error =3D 0x4488
[    0.706207] mtdoops: read failure at 249856 (8 of 8 read), err -74
[    0.706298] onenand_wait: ECC error =3D 0x8484
[    0.706359] mtdoops: read failure at 253952 (8 of 8 read), err -74
[    0.706420] onenand_wait: ECC error =3D 0x8844
[    0.706481] mtdoops: read failure at 258048 (8 of 8 read), err -74
[    0.706542] mtdoops: ready 30, 31 (no erase)
[    0.706542] mtdoops: Attached to MTD device 2
[    0.706634] 0x0000000c0000-0x0000002c0000 : "kernel"
[    0.707397] 0x0000002c0000-0x0000004c0000 : "initfs"
[    0.708160] 0x0000004c0000-0x000010000000 : "rootfs"
[    1.031585] twl 1-0048: PIH (irq 23) chaining IRQs 340..348
[    1.031799] twl 1-0048: power (irq 345) chaining IRQs 348..355
[    1.073669] twl4030ldo_get_voltage_sel VAUX1 3
[    1.073913] twl4030reg_set_mode VAUX1 2
[    1.151367] twl4030reg_enable VAUX1 2e
[    1.192016] twl4030ldo_get_voltage_sel VAUX2_4030 5
[    1.192291] twl4030reg_set_mode VAUX2_4030 2
[    1.291961] twl4030ldo_get_voltage_sel VAUX3 4
[    1.292419] twl4030ldo_get_voltage_sel VAUX3 4
[    1.292480] twl4030reg_set_mode VAUX3 2
[    1.371368] twl4030ldo_get_voltage_sel VAUX3 4
[    1.391998] twl4030ldo_get_voltage_sel VAUX4 9
[    1.392242] twl4030reg_set_mode VAUX4 2
[    1.512023] twl4030ldo_get_voltage_sel VDAC 3
[    1.532012] twl4030ldo_get_voltage_sel VIO 0
[    1.532470] twl4030reg_enable VIO ae
[    1.572143] twl4030reg_enable VINTANA1 ae
[    1.612030] twl4030ldo_get_voltage_sel VINTANA2 1
[    1.612487] twl4030reg_enable VINTANA2 ae
[    1.652191] twl4030reg_enable VINTDIG ae
[    1.691986] twl4030ldo_get_voltage_sel VMMC1 3
[    1.692443] twl4030ldo_get_voltage_sel VMMC1 3
[    1.692504] twl4030reg_set_mode VMMC1 2
[    1.771362] twl4030ldo_get_voltage_sel VMMC1 3
[    1.792053] twl4030ldo_get_voltage_sel VMMC2 a
[    1.792510] twl4030ldo_get_voltage_sel VMMC2 a
[    1.792572] twl4030reg_set_mode VMMC2 2
[    1.871368] twl4030reg_enable VMMC2 8
[    1.891815] twl4030ldo_get_voltage_sel VMMC2 a
[    1.972045] twl4030ldo_get_voltage_sel VPLL1 3
[    1.972290] twl4030reg_set_mode VPLL1 2
[    2.051361] twl4030reg_enable VPLL1 ae
[    2.092071] twl4030ldo_get_voltage_sel VPLL2 5
[    2.092346] twl4030reg_set_mode VPLL2 2
[    2.171356] twl4030reg_enable VPLL2 2e
[    2.212066] twl4030ldo_get_voltage_sel VSIM 3
[    2.212341] twl4030reg_set_mode VSIM 2
[    2.311767] twl4030_gpio twl4030-gpio: gpio (irq 340) chaining IRQs 35=
6..373
[    2.511413] twl4030reg_is_enabled VUSB3V1 0
[    2.511657] twl4030reg_enable VUSB3V1 0
[    2.531860] twl4030reg_is_enabled VUSB1V8 0
[    2.532104] twl4030reg_enable VUSB1V8 0
[    2.571350] twl4030reg_is_enabled VUSB1V5 0
[    2.571594] twl4030reg_enable VUSB1V5 0
[    2.651550] twl4030_usb 48070000.i2c:twl@48:twl4030-usb: Initialized T=
WL4030 USB module
[    2.654266] input: twl4030_pwrbutton as /devices/platform/68000000.ocp=
/48070000.i2c/i2c-1/1-0048/48070000.i2c:twl@48:pwrbutton/input/input0
[    2.655914] input: TWL4030 Keypad as /devices/platform/68000000.ocp/48=
070000.i2c/i2c-1/1-0048/48070000.i2c:twl@48:keypad/input/input1
[    2.891204] 48070000.i2c:twl@48:madc supply vusb3v1 not found, using d=
ummy regulator
[    5.071624] twl4030reg_disable VUSB1V5 2e
[    5.091339] twl4030reg_disable VUSB1V8 2e
[    5.111267] twl4030reg_disable VUSB3V1 2e
[    6.771240] omap_i2c 48070000.i2c: bus 1 rev3.3 at 2200 kHz
[    6.774291] twl4030reg_is_enabled VMMC2 2e
[    6.774749] twl4030reg_is_enabled VMMC2 2e
[    6.776031] twl4030reg_is_enabled VMMC2 2e
[    6.776428] twl4030reg_is_enabled VMMC2 2e
[    6.778137] twl4030reg_is_enabled VMMC2 2e
[    6.782135] omap_i2c 48072000.i2c: bus 2 rev3.3 at 100 kHz
[    6.784271] omap_i2c 48060000.i2c: bus 3 rev3.3 at 400 kHz
[    6.785827] twl4030reg_is_enabled VAUX1 2e
[    6.808898] Console: switching to colour frame buffer device 100x30
[    6.881591] omapfb omapfb: using display 'lcd' mode 800x480
[    6.887939] twl4030reg_is_enabled VUSB3V1 e8
[    6.893737] twl4030reg_is_enabled VUSB1V8 0
[    6.899230] twl4030reg_enable VUSB1V8 0
[    6.941467] twl4030reg_is_enabled VUSB1V5 0
[    6.947021] twl4030reg_enable VUSB1V5 0
[    7.113586] using random self ethernet address
[    7.118927] using random host ethernet address
[    7.124206] Mass Storage Function, version: 2009/09/11
[    7.129425] LUN: removable file: (no medium)
[    7.134704] LUN: removable file: (no medium)
[    7.139556] LUN: removable file: (no medium)
[    7.144042] Number of LUNs=3D2
[    7.149444] g_nokia gadget: USB CDC Phonet function
[    7.153717] g_nokia gadget: using musb-hdrc, OUT ep1out, IN ep1in
[    7.158905] usb0: HOST MAC 6e:21:e6:ae:5c:ed
[    7.163055] usb0: MAC ea:25:e8:6e:72:d8
[    7.167266] g_nokia gadget: USB CDC Phonet function
[    7.171417] g_nokia gadget: using musb-hdrc, OUT ep1out, IN ep1in
[    7.175750] g_nokia gadget: N900 (PC-Suite Mode)
[    7.179870] g_nokia gadget: g_nokia ready
[    7.185119] omap_hsmmc 4809c000.mmc: Got CD GPIO
[    7.190490] twl4030reg_is_enabled VMMC1 ee
[    7.195312] twl4030reg_is_enabled VMMC1 ee
[    7.199951] twl4030reg_disable VMMC1 ee
[    7.221893] twl4030reg_is_enabled VMMC1 0
[    7.226501] twl4030ldo_get_voltage_sel VMMC1 3
[    7.230895] twl4030ldo_set_voltage_sel VMMC1 3
[    7.251495] twl4030reg_is_enabled VMMC1 0
[    7.255889] twl4030reg_enable VMMC1 0
[    7.316864] twl4030reg_is_enabled VAUX3 2e
[    7.321319] twl4030reg_is_enabled VAUX3 2e
[    7.325561] twl4030reg_disable VAUX3 2e
[    7.341369] twl4030reg_is_enabled VSIM 2e
[    7.345611] twl4030reg_is_enabled VSIM 2e
[    7.345672] twl4030reg_disable VMMC1 2e
[    7.353210] twl4030reg_disable VSIM 2e
[    7.371948] twl4030reg_is_enabled VAUX3 0
[    7.392578] twl4030ldo_get_voltage_sel VAUX3 4
[    7.396118] twl4030ldo_set_voltage_sel VAUX3 4
[    7.411499] twl4030reg_is_enabled VAUX3 0
[    7.415435] twl4030reg_enable VAUX3 0
[    7.432006] twl4030reg_is_enabled VSIM 0
[    7.435821] twl4030reg_enable VSIM 0
[    7.557281] rx51-audio n900-audio: tlv320aic3x-hifi <-> 49022000.mcbsp=
 mapping ok
[    7.571838] input: RX-51 AV Jack as /devices/platform/n900-audio/sound=
/card0/input2
[    7.578826] hctosys: unable to open rtc device (rtc0)
[    7.583068] sr_init: No PMIC hook to init smartreflex
[    7.587371] smartreflex smartreflex.0: omap_sr_probe: SmartReflex driv=
er initialized
[    7.592224] smartreflex smartreflex.1: omap_sr_probe: SmartReflex driv=
er initialized
[    7.613494] twl4030reg_is_enabled VAUX2_4030 2e
[    7.617706] VCSI: disabling
[    7.641906] twl4030reg_disable VAUX2_4030 2e
[    7.661376] twl4030reg_is_enabled VAUX4 0
[    7.665161] twl4030reg_is_enabled VDAC 2e
[    7.668518] VDAC: disabling
[    7.671997] twl4030reg_disable VDAC 2e
[    7.691253] twl4030reg_is_enabled VMMC1 0
[    7.694976] ALSA device list:
[    7.698455]   #0: RX-51
[    7.702545] RAMDISK: cramfs filesystem found at block 0
[    7.706237] RAMDISK: Loading 12468KiB [1 disk] into ram disk... |\x08/=
\x08-\x08\\x08|\x08/\x08-\x08\\x08|\x08/\x08-\x08\\x08|\x08/\x08-\x08\\x0=
8|\x08/\x08-\x08\\x08|\x08/\x08-\x08\\x08|\x08/\x08-\x08\\x08|\x08/\x08-\=
x08\\x08|\x08/\x08-\x08\\x08|\x08/\x08-\x08\\x08|\x08/\x08-\x08\\x08|\x08=
/\x08-\x08\\x08|\x08/\x08-\x08\\x08|\x08/\x08-\x08\\x08|\x08/\x08-\x08\\x=
08|\x08/\x08-\x08\\x08|\x08/\x08-\x08\\x08|\x08/\x08-\x08\\x08|\x08/\x08-=
\x08\\x08|\x08/\x08-\x08\\x08|\x08/\x08-\x08\\x08|\x08/\x08-\x08\\x08|\x0=
8/\x08-\x08\\x08|\x08/\x08-\x08\\x08|\x08/\x08-\x08\\x08|\x08/\x08-\x08\\=
x08|\x08/\x08-\x08\\x08|\x08/\x08-\x08\\x08|\x08/\x08-\x08\\x08|\x08/\x08=
-\x08\\x08|\x08/\x08-\x08\\x08|\x08/\x08-\x08\\x08|\x08/\x08-\x08\\x08|\x=
08/\x08-\x08\\x08|\x08/\x08-\x08\\x08|\x08/\x08-\x08\\x08|\x08/\x08-\x08\=
\x08|\x08/\x08-\x08\\x08|\x08
[    7.774993] mmc1: switch to bus width 8 failed
[    7.782714] /\x08-\x08\\x08|\x08/\x08-\x08\\x08|\x08/\x08-\x08\\x08|\x=
08/\x08-\x08\\x08|\x08/\x08-\x08\\x08|\x08/\x08
[    7.791687] mmc1: switch to bus width 4 failed
[    7.799468] mmc1: new high speed MMC card at address 0001
[    7.822143] -\x08\\x08|\x08/\x08-\x08\\x08|\x08/\x08-\x08\\x08|\x08/\x=
08-\x08\\x08|\x08/\x08-\x08\\x08|\x08/\x08-\x08\\x08|\x08/\x08-\x08\\x08|=
\x08/\x08-\x08\\x08|\x08/\x08-\x08\\x08|\x08/\x08-\x08\\x08|\x08/\x08-\x0=
8\\x08|\x08/\x08
[    7.822143] mmcblk1: mmc1:0001 MMC32G 29.8 GiB=20
[    7.831207] -\x08\\x08|\x08/\x08-\x08\\x08|\x08/\x08-\x08\\x08|\x08/\x=
08-\x08\\x08|\x08/\x08-\x08\\x08|\x08/\x08-\x08\\x08|\x08
[    7.841583] mmcblk1boot0: mmc1:0001 MMC32G partition 1 512 KiB
[    7.850982] /\x08-\x08\\x08|\x08/\x08-\x08\\x08|\x08/\x08-\x08\\x08|\x=
08/\x08-\x08\\x08|\x08/\x08-\x08\\x08|\x08/\x08-\x08\\x08
[    7.861145] mmcblk1boot1: mmc1:0001 MMC32G partition 2 512 KiB
[    7.871337] |\x08/\x08
[    7.872253]  mmcblk1: p1 p2 p3
[    7.881469] -\x08\\x08|\x08/\x08-\x08\\x08|\x08/\x08-\x08\\x08|\x08/\x=
08-\x08\\x08|\x08/\x08-\x08\\x08|\x08/\x08-\x08\\x08|\x08/\x08-\x08\\x08|=
\x08/\x08-\x08\\x08|\x08/\x08-\x08\\x08|\x08/\x08-\x08\\x08|\x08/\x08-\x0=
8\\x08|\x08/\x08-\x08\\x08|\x08/\x08-\x08\\x08|\x08/\x08-\x08\\x08|\x08/\=
x08-\x08\\x08|\x08/\x08-\x08\\x08|\x08/\x08-\x08\\x08|\x08/\x08-\x08\\x08=
|\x08/\x08-\x08\\x08|\x08/\x08-\x08\\x08|\x08/\x08-\x08\\x08|\x08/\x08-\x=
08\\x08|\x08/\x08-\x08\\x08|\x08/\x08-\x08\\x08|\x08/\x08-\x08\\x08|\x08/=
\x08-\x08\\x08|\x08/\x08-\x08\\x08|\x08/\x08-\x08\\x08|\x08/\x08-\x08\\x0=
8|\x08/\x08-\x08\\x08|\x08/\x08-\x08\\x08|\x08/\x08-\x08\\x08|\x08/\x08-\=
x08\\x08|\x08/\x08-\x08\\x08|\x08/\x08-\x08\\x08|\x08/\x08-\x08\\x08|\x08=
/\x08-\x08\\x08|\x08/\x08-\x08\\x08|\x08/\x08-\x08\\x08|\x08/\x08-\x08\\x=
08|\x08/\x08-\x08\\x08|\x08/\x08-\x08\\x08|\x08/\x08-\x08\\x08|\x08/\x08-=
\x08\\x08|\x08/\x08-\x08\\x08|\x08/\x08-\x08\\x08|\x08/\x08-\x08\\x08|\x0=
8/\x08-\x08\\x08|\x08/\x08-\x08\\x08|\x08/\x08-\x08\\x08|\x08/\x08-\x08\\=
x08|\x08/\x08-\x08\\x08|\x08/\x08-\x08\\x08|\x08/\x08-\x08\\x08|\x08/\x08=
-\x08\\x08|\x08/\x08-\x08\\x08|\x08/\x08-\x08\\x08|\x08/\x08-\x08\\x08|\x=
08/\x08-\x08\\x08|\x08/\x08-\x08\\x08|\x08/\x08-\x08\\x08|\x08/\x08-\x08\=
\x08|\x08/\x08-\x08\\x08|\x08/\x08-\x08\\x08|\x08/\x08-\x08\\x08|\x08/\x0=
8-\x08\\x08|\x08/\x08-\x08\\x08|\x08/\x08-\x08\\x08|\x08/\x08-\x08\\x08|\=
x08/\x08-\x08\\x08|\x08/\x08-\x08\\x08|\x08/\x08-\x08\\x08|\x08/\x08-\x08=
\\x08|\x08/\x08-\x08\\x08|\x08/\x08-\x08\\x08|\x08/\x08-\x08\\x08|\x08/\x=
08-\x08\\x08|\x08/\x08-\x08\\x08|\x08/\x08-\x08\\x08|\x08/\x08-\x08\\x08|=
\x08/\x08-\x08\\x08|\x08/\x08-\x08\\x08|\x08/\x08-\x08\\x08|\x08/\x08-\x0=
8\\x08|\x08/\x08-\x08\\x08|\x08/\x08-\x08\\x08|\x08/\x08-\x08\\x08|\x08/\=
x08-\x08\\x08|\x08/\x08-\x08\\x08|\x08/\x08-\x08\\x08|\x08/\x08-\x08\\x08=
|\x08/\x08-\x08\\x08|\x08/\x08-\x08\\x08|\x08/\x08-\x08\\x08|\x08/\x08-\x=
08\\x08|\x08/\x08-\x08\\x08|\x08/\x08-\x08\\x08|\x08/\x08-\x08\\x08|\x08/=
\x08-\x08\\x08|\x08/\x08-\x08\\x08|\x08/\x08-\x08\\x08|\x08/\x08-\x08\\x0=
8|\x08/\x08-\x08\\x08|\x08/\x08-\x08\\x08|\x08/\x08-\x08\\x08|\x08/\x08-\=
x08\\x08|\x08/\x08-\x08\\x08|\x08/\x08-\x08\\x08|\x08/\x08-\x08\\x08|\x08=
/\x08-\x08\\x08|\x08/\x08-\x08\\x08|\x08/\x08-\x08\\x08|\x08/\x08-\x08\\x=
08|\x08/\x08-\x08\\x08|\x08/\x08-\x08\\x08|\x08/\x08-\x08\\x08|\x08/\x08-=
\x08\\x08|\x08/\x08-\x08\\x08|\x08/\x08-\x08\\x08|\x08/\x08-\x08\\x08|\x0=
8/\x08-\x08\\x08|\x08/\x08-\x08\\x08|\x08/\x08-\x08\\x08|\x08/\x08-\x08\\=
x08|\x08/\x08-\x08\\x08|\x08/\x08-\x08\\x08|\x08/\x08-\x08\\x08|\x08/\x08=
-\x08\\x08|\x08/\x08-\x08\\x08done.
[    8.272094] VFS: Mounted root (cramfs filesystem) readonly on device 1=
:0.
[    8.279144] Freeing unused kernel memory: 1024K (c0800000 - c0900000)
[   21.321472] lirc_dev: IR Remote Control driver registered, major 247=20
[   21.594512] media: Linux media interface: v0.10
[   21.641723] Linux video capture interface: v2.00
[   21.936889] lirc_rx51 lirc-rx51: lirc_dev: driver lirc_rx51 registered=
 at minor =3D 0
[   27.362609] input: gpio_keys as /devices/platform/gpio_keys/input/inpu=
t3
[   43.492004] omap_wdt: OMAP Watchdog Timer Rev 0x31: initial timeout 60=
 sec
[   48.568511] omap-sham 480c3000.sham: hw accel on OMAP rev 0.9
[   48.581268] omap-sham 480c3000.sham: initialization failed.
[   48.586547] omap-sham: probe of 480c3000.sham failed with error -22
[   52.960998] random: nonblocking pool is initialized
[   53.671447] twl4030reg_is_enabled VIO ee
[   53.681152] input: TSC200X touchscreen as /devices/platform/68000000.o=
cp/48098000.spi/spi_master/spi1/spi1.0/input/input4
[   70.958587] input: twl4030:vibrator as /devices/platform/68000000.ocp/=
48070000.i2c/i2c-1/1-0048/48070000.i2c:twl@48:audio/input/input5
[   73.261169] twl_rtc 48070000.i2c:twl@48:rtc: Enabling TWL-RTC
[   73.303558] twl_rtc 48070000.i2c:twl@48:rtc: rtc core: registered 4807=
0000.i2c:twl@48 as rtc0
[  104.123199] smc91x: not found (-19).
[  109.191650] tsl2563 2-0029: model 7, rev. 6
[  110.541290] omap_i2c 48072000.i2c: controller timed out
[  110.650604] lp5523x 2-0032: lp5523 Programmable led chip found
[  111.091339] bq27xxx-battery 2-0055: support ver. 1.2.0 enabled
[  112.453948] twl4030reg_is_enabled VAUX1 2e
[  112.552795] si4713 2-0063: chip found @ 0xc6 (OMAP I2C adapter)
[  112.861175] bq2415x-charger 2-006b: automode supported, waiting for ev=
ents
[  112.885131] bq2415x-charger 2-006b: driver registered
[  118.961761] omap_ssi 48058000.ssi-controller: ssi controller 0 initial=
ized (1 ports)!
[  123.221252] ieee80211 phy0: Selected rate control algorithm 'minstrel'=

[  123.222686] wl1251: loaded
[  123.230346] wl1251: initialized
[  125.622589] ti-soc-thermal 48002524.bandgap: This OMAP thermal sensor =
is unreliable. You've been warned
[  125.651275] ti-soc-thermal 48002524.bandgap: Non-trimmed BGAP, Temp no=
t accurate
[  129.891326] twl4030reg_is_enabled VAUX1 2e
[  129.941467] lis3lv02d: 8 bits sensor found
[  130.001678] input: ST LIS3LV02DL Accelerometer as /devices/platform/li=
s3lv02d/input/input6
[  130.222473] et8ek8 3-003e: could not get clock
[  133.490234] omap3isp 480bc000.isp: parsing endpoint /ocp/isp@480bc000/=
ports/port@1/endpoint, interface 1
[  133.490295] omap3isp 480bc000.isp: clock lane polarity 0, pos 0
[  133.490295] omap3isp 480bc000.isp: data lane polarity 0, pos 1
[  133.490325] omap3isp 480bc000.isp: clock_inv 0 strobe 0 ccp2 1
[  133.490570] 480bc000.isp supply vdd-csiphy1 not found, using dummy reg=
ulator
[  133.508148] 480bc000.isp supply vdd-csiphy2 not found, using dummy reg=
ulator
[  133.521484] omap3isp 480bc000.isp: Revision 2.0 found
[  133.529022] iommu: Adding device 480bc000.isp to group 0
[  133.537811] omap-iommu 480bd400.mmu: 480bd400.mmu: version 1.1
[  133.545257] omap3isp 480bc000.isp: hist: using DMA channel dma0chan10
[  133.545318] omap3isp 480bc000.isp: Entity type for entity OMAP3 ISP CC=
P2 was not initialized!
[  133.552764] omap3isp 480bc000.isp: Entity type for entity OMAP3 ISP CS=
I2a was not initialized!
[  133.569793] omap3isp 480bc000.isp: Entity type for entity OMAP3 ISP CC=
DC was not initialized!
[  133.591857] omap3isp 480bc000.isp: Entity type for entity OMAP3 ISP pr=
eview was not initialized!
[  133.619537] omap3isp 480bc000.isp: Entity type for entity OMAP3 ISP re=
sizer was not initialized!
[  133.647277] omap3isp 480bc000.isp: Entity type for entity OMAP3 ISP AE=
WB was not initialized!
[  133.691162] omap3isp 480bc000.isp: Entity type for entity OMAP3 ISP AF=
 was not initialized!
[  133.697113] omap3isp 480bc000.isp: Entity type for entity OMAP3 ISP hi=
stogram was not initialized!
[  133.729797] omap3isp 480bc000.isp: Entity type for entity video-bus-sw=
itch was not initialized!
[  133.736206] video-bus-switch video-bus-switch: registered, init notifi=
er...
[  133.740386] omap3isp 480bc000.isp: Entity type for entity et8ek8 3-003=
e was not initialized!
[  133.851165] et8ek8 3-003e: registered!
[  133.851470] twl4030reg_is_enabled VAUX4 0
[  133.916717] twl4030reg_enable VAUX4 0
[  133.959014] omap3isp 480bc000.isp: isp_xclk_set_rate: cam_xclka set to=
 9600000 Hz (div 18)
[  133.977630] smia_reglist_import: meta_reglist version V14 03-June-2008=

[  133.991088] smia_reglist_import: type 10	w 2592	h 1968	fmt 30314442	iv=
al 100/1292	ptr bf1fae34
[  133.991119] smia_reglist_import: type 10	w 2592	h 1968	fmt 30314142	iv=
al 100/399	ptr bf1fb0a4
[  133.991149] smia_reglist_import: type 10	w 1296	h 984	fmt 30314142	iva=
l 100/501	ptr bf1fb1d4
[  133.991149] smia_reglist_import: type 10	w 1296	h 984	fmt 30314442	iva=
l 100/2500	ptr bf1fb270
[  133.991180] smia_reglist_import: type 10	w 1296	h 984	fmt 30314442	iva=
l 100/3000	ptr bf1faed0
[  133.991180] smia_reglist_import: type 10	w 864	h 656	fmt 30314142	ival=
 100/2988	ptr bf1faf6c
[  133.991210] smia_reglist_import: type 10	w 648	h 492	fmt 30314142	ival=
 100/499	ptr bf1fb138
[  133.991210] smia_reglist_import: type 10	w 648	h 492	fmt 30314142	ival=
 100/2993	ptr bf1fb008
[  133.991241] smia_reglist_import: type 1	w 2592	h 1968	fmt 30314142	iva=
l 100/1207	ptr bf1fac88
[  134.111450] twl4030reg_disable VAUX4 2e
[  134.121246] et8ek8 3-003e: initialized!
[  152.107238] isp1704_charger isp1707: init gpio 67
[  152.121673] Unhandled fault: external abort on non-linefetch (0x1028) =
at 0xfa0ab001
[  152.127746] pgd =3D cf2c0000
[  152.133392] [fa0ab001] *pgd=3D48011452(bad)
[  152.138946] Internal error: : 1028 [#1] PREEMPT ARM
[  152.144348] Modules linked in: isp1704_charger(+) omap3_isp videobuf2_=
v4l2 videobuf2_dma_contig videobuf2_memops videobuf2_core et8ek8 smiaregs=
 lis3lv02d_i2c lis3lv02d input_polldev ti_soc_thermal arc4 wl1251_spi wl1=
251 crc7 mac80211 cfg80211 omap_ssi hsi bq2415x_charger si4713 bq27xxx_ba=
ttery_i2c bq27xxx_battery leds_lp5523 leds_lp55xx_common adp1653 v4l2_com=
mon tsl2563 smc91x mii rtc_twl twl4030_vibra ff_memless twl4030_wdt tsc20=
05 tsc200x_core omap_sham omap_wdt gpio_keys rx51_battery pwm_omap_dmtime=
r video_bus_switch videodev media ir_rx51 lirc_dev rc_core
[  152.180358] CPU: 0 PID: 703 Comm: modprobe Not tainted 4.6.0-rc4+ #2
[  152.186614] Hardware name: Nokia RX-51 board
[  152.192810] task: cf2ae300 ti: cf3d0000 task.ti: cf3d0000
[  152.199005] PC is at musb_default_readb+0x0/0xc
[  152.205108] LR is at musb_ulpi_write+0x34/0xf8
[  152.211151] pc : [<c0401dc4>]    lr : [<c0402ce8>]    psr: 60000013
[  152.211151] sp : cf3d1d40  ip : 00000000  fp : c017637c
[  152.223541] r10: 00000001  r9 : 00000000  r8 : 00000016
[  152.229797] r7 : 000000aa  r6 : ccbdee10  r5 : c0976c84  r4 : fa0ab000=

[  152.236145] r3 : c0401dc4  r2 : 00000000  r1 : 00000001  r0 : fa0ab000=

[  152.242492] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segme=
nt none
[  152.249023] Control: 10c5387d  Table: 8f2c0019  DAC: 00000051
[  152.255401] Process modprobe (pid: 703, stack limit =3D 0xcf3d0210)
[  152.261688] Stack: (0xcf3d1d40 to 0xcf3d2000)
[  152.267974] 1d40: cd22db10 ccbdee10 cd9a9410 cd9a9400 cf5ef81c bf2471f=
8 00000000 00000000
[  152.274383] 1d60: 00000000 00000000 ffffffed cd9a9410 bf2481c0 0000004=
5 bf24a000 c03a4578
[  152.280883] 1d80: cd9a9410 00000000 bf2481c0 c03a2d64 00000000 cd9a941=
0 cd9a9444 bf2481c0
[  152.287414] 1da0: c03a2ef4 c03a2f74 00000000 cf3d1db8 bf2481c0 c03a14d=
4 cd84994c cd9a37b0
[  152.293914] 1dc0: bf2481c0 bf2481c0 cd22dd80 00000000 c09236c8 c03a244=
4 bf248158 bf248158
[  152.300506] 1de0: 00000000 bf2481c0 c0904e1c c0904e1c bf248288 c03a37e=
4 c03a409c cf3afc40
[  152.307037] 1e00: c0904e1c c0101668 cd801f00 cf339c40 00006f20 0040003=
e 00000000 0040003f
[  152.313568] 1e20: c0724798 cf7df1a0 00000000 c01a2d80 cf7df1a0 0040003=
e cd801f00 cd252500
[  152.320098] 1e40: 00006f20 c01ca820 0000001c cf79da40 cd801f00 cd25248=
0 bf248240 cf3d1f44
[  152.326751] 1e60: cf3af2c0 bf248288 cf3c1b00 0000001c 00000001 c019b6e=
8 bf248240 00000000
[  152.333282] 1e80: bf248240 cf3d1f44 00000001 c017904c bf24824c 00007ff=
f bf248240 c01769f0
[  152.339721] 1ea0: c01763f0 00000000 bf2483ec 00000062 c0606324 d0bb12c=
8 cf3d1ed4 000a80e6
[  152.346038] 1ec0: cd252500 c0777df0 00400000 024002c2 00000000 c01c9f1=
0 cd252480 00000000
[  152.352233] 1ee0: 00000000 00000000 00000000 00000000 00000000 0000000=
0 00000000 00000000
[  152.358276] 1f00: 00000000 00000000 00000000 00000000 00000000 0000000=
0 00000000 00003014
[  152.364044] 1f20: d0bb2014 00000000 000c639c 000a80e6 cf3d0000 0000005=
1 00000000 c0179444
[  152.369689] 1f40: cd7566e8 d0baf000 00003014 d0bb0e18 d0bb0ccb d0bb193=
8 00001400 00001610
[  152.375305] 1f60: 00000000 00000000 00000000 00000a68 0000001e 0000001=
f 00000016 00000013
[  152.380950] 1f80: 00000011 00000000 cf264600 000bc440 00000000 0000000=
0 00000080 c0107324
[  152.386566] 1fa0: 00000000 c0107160 000bc440 00000000 000c3388 0000301=
4 000a80e6 00000000
[  152.392272] 1fc0: 000bc440 00000000 00000000 00000080 000b6cc8 000a80e=
6 bef66e68 00000000
[  152.397918] 1fe0: b6eb5d0c bef66a54 00018204 b6eb5d1c a0000010 000c338=
8 00000000 00000000
[  152.403594] [<c0401dc4>] (musb_default_readb) from [<c0402ce8>] (musb_=
ulpi_write+0x34/0xf8)
[  152.409454] [<c0402ce8>] (musb_ulpi_write) from [<bf2471f8>] (isp1704_=
charger_probe+0x15c/0x4e0 [isp1704_charger])
[  152.421325] [<bf2471f8>] (isp1704_charger_probe [isp1704_charger]) fro=
m [<c03a4578>] (platform_drv_probe+0x58/0xa0)
[  152.433624] [<c03a4578>] (platform_drv_probe) from [<c03a2d64>] (drive=
r_probe_device+0x120/0x2b0)
[  152.440093] [<c03a2d64>] (driver_probe_device) from [<c03a2f74>] (__dr=
iver_attach+0x80/0xa4)
[  152.446624] [<c03a2f74>] (__driver_attach) from [<c03a14d4>] (bus_for_=
each_dev+0x50/0x88)
[  152.453155] [<c03a14d4>] (bus_for_each_dev) from [<c03a2444>] (bus_add=
_driver+0xc4/0x1e4)
[  152.459716] [<c03a2444>] (bus_add_driver) from [<c03a37e4>] (driver_re=
gister+0x9c/0xe0)
[  152.466247] [<c03a37e4>] (driver_register) from [<c0101668>] (do_one_i=
nitcall+0xf8/0x1c4)
[  152.472839] [<c0101668>] (do_one_initcall) from [<c019b6e8>] (do_init_=
module+0x54/0x1ac)
[  152.479400] [<c019b6e8>] (do_init_module) from [<c017904c>] (load_modu=
le+0x185c/0x1b14)
[  152.485961] [<c017904c>] (load_module) from [<c0179444>] (SyS_init_mod=
ule+0x140/0x158)
[  152.492553] [<c0179444>] (SyS_init_module) from [<c0107160>] (ret_fast=
_syscall+0x0/0x3c)
[  152.499145] Code: e12fff1e e2800010 e0810180 e12fff1e (e7d00001)=20
[  152.505767] ---[ end trace 713e393a1cd324be ]---
[  152.514312] In-band Error seen by MPU  at address 0
[  152.520874] ------------[ cut here ]------------
[  152.527282] WARNING: CPU: 0 PID: 703 at drivers/bus/omap_l3_smx.c:166 =
omap3_l3_app_irq+0xdc/0x124
[  152.533905] Modules linked in: isp1704_charger(+) omap3_isp videobuf2_=
v4l2 videobuf2_dma_contig videobuf2_memops videobuf2_core et8ek8 smiaregs=
 lis3lv02d_i2c lis3lv02d input_polldev ti_soc_thermal arc4 wl1251_spi wl1=
251 crc7 mac80211 cfg80211 omap_ssi hsi bq2415x_charger si4713 bq27xxx_ba=
ttery_i2c bq27xxx_battery leds_lp5523 leds_lp55xx_common adp1653 v4l2_com=
mon tsl2563 smc91x mii rtc_twl twl4030_vibra ff_memless twl4030_wdt tsc20=
05 tsc200x_core omap_sham omap_wdt gpio_keys rx51_battery pwm_omap_dmtime=
r video_bus_switch videodev media ir_rx51 lirc_dev rc_core
[  152.578277] CPU: 0 PID: 703 Comm: modprobe Tainted: G      D         4=
=2E6.0-rc4+ #2
[  152.586059] Hardware name: Nokia RX-51 board
[  152.593811] [<c010bc18>] (unwind_backtrace) from [<c0109f38>] (show_st=
ack+0x10/0x14)
[  152.601806] [<c0109f38>] (show_stack) from [<c0126c70>] (__warn+0xcc/0=
xf8)
[  152.609619] [<c0126c70>] (__warn) from [<c0126cb8>] (warn_slowpath_nul=
l+0x1c/0x20)
[  152.617462] [<c0126cb8>] (warn_slowpath_null) from [<c033260c>] (omap3=
_l3_app_irq+0xdc/0x124)
[  152.625305] [<c033260c>] (omap3_l3_app_irq) from [<c0154f50>] (handle_=
irq_event_percpu+0x34/0x138)
[  152.640502] [<c0154f50>] (handle_irq_event_percpu) from [<c01550b0>] (=
handle_irq_event+0x5c/0x88)
[  152.648254] [<c01550b0>] (handle_irq_event) from [<c0158020>] (handle_=
level_irq+0xcc/0x130)
[  152.655944] [<c0158020>] (handle_level_irq) from [<c0154930>] (generic=
_handle_irq+0x18/0x28)
[  152.663574] [<c0154930>] (generic_handle_irq) from [<c0154a50>] (__han=
dle_domain_irq+0x84/0xa8)
[  152.671234] [<c0154a50>] (__handle_domain_irq) from [<c054f914>] (__ir=
q_svc+0x54/0x90)
[  152.678924] [<c054f914>] (__irq_svc) from [<c017b16c>] (acct_collect+0=
x180/0x1b0)
[  152.686523] [<c017b16c>] (acct_collect) from [<c0128b4c>] (do_exit+0x1=
d8/0x920)
[  152.694183] [<c0128b4c>] (do_exit) from [<c010a294>] (die+0x358/0x3c0)=

[  152.701812] [<c010a294>] (die) from [<c01012ec>] (do_DataAbort+0xa0/0x=
b4)
[  152.709411] [<c01012ec>] (do_DataAbort) from [<c054f8a0>] (__dabt_svc+=
0x40/0x60)
[  152.716979] Exception stack(0xcf3d1cf0 to 0xcf3d1d38)
[  152.724456] 1ce0:                                     fa0ab000 0000000=
1 00000000 c0401dc4
[  152.732116] 1d00: fa0ab000 c0976c84 ccbdee10 000000aa 00000016 0000000=
0 00000001 c017637c
[  152.739807] 1d20: 00000000 cf3d1d40 c0402ce8 c0401dc4 60000013 fffffff=
f
[  152.747528] [<c054f8a0>] (__dabt_svc) from [<c0401dc4>] (musb_default_=
readb+0x0/0xc)
[  152.755218] [<c0401dc4>] (musb_default_readb) from [<c0402ce8>] (musb_=
ulpi_write+0x34/0xf8)
[  152.762878] [<c0402ce8>] (musb_ulpi_write) from [<bf2471f8>] (isp1704_=
charger_probe+0x15c/0x4e0 [isp1704_charger])
[  152.777801] [<bf2471f8>] (isp1704_charger_probe [isp1704_charger]) fro=
m [<c03a4578>] (platform_drv_probe+0x58/0xa0)
[  152.792694] [<c03a4578>] (platform_drv_probe) from [<c03a2d64>] (drive=
r_probe_device+0x120/0x2b0)
[  152.800262] [<c03a2d64>] (driver_probe_device) from [<c03a2f74>] (__dr=
iver_attach+0x80/0xa4)
[  152.807830] [<c03a2f74>] (__driver_attach) from [<c03a14d4>] (bus_for_=
each_dev+0x50/0x88)
[  152.815429] [<c03a14d4>] (bus_for_each_dev) from [<c03a2444>] (bus_add=
_driver+0xc4/0x1e4)
[  152.823028] [<c03a2444>] (bus_add_driver) from [<c03a37e4>] (driver_re=
gister+0x9c/0xe0)
[  152.830596] [<c03a37e4>] (driver_register) from [<c0101668>] (do_one_i=
nitcall+0xf8/0x1c4)
[  152.838165] [<c0101668>] (do_one_initcall) from [<c019b6e8>] (do_init_=
module+0x54/0x1ac)
[  152.845642] [<c019b6e8>] (do_init_module) from [<c017904c>] (load_modu=
le+0x185c/0x1b14)
[  152.853149] [<c017904c>] (load_module) from [<c0179444>] (SyS_init_mod=
ule+0x140/0x158)
[  152.860504] [<c0179444>] (SyS_init_module) from [<c0107160>] (ret_fast=
_syscall+0x0/0x3c)
[  152.867767] ---[ end trace 713e393a1cd324bf ]---
[  152.875610] mtdoops: ready 31, 32 (no erase)
[  257.091827] NET: Registered protocol family 10
[  258.270477] Unhandled fault: external abort on non-linefetch (0x1028) =
at 0xfa0ab060
[  258.272277] pgd =3D cd2b0000
[  258.272949] [fa0ab060] *pgd=3D48011452(bad)
[  258.274017] Internal error: : 1028 [#2] PREEMPT ARM
[  258.275115] Modules linked in: ipv6 isp1704_charger(+) omap3_isp video=
buf2_v4l2 videobuf2_dma_contig videobuf2_memops videobuf2_core et8ek8 smi=
aregs lis3lv02d_i2c lis3lv02d input_polldev ti_soc_thermal arc4 wl1251_sp=
i wl1251 crc7 mac80211 cfg80211 omap_ssi hsi bq2415x_charger si4713 bq27x=
xx_battery_i2c bq27xxx_battery leds_lp5523 leds_lp55xx_common adp1653 v4l=
2_common tsl2563 smc91x mii rtc_twl twl4030_vibra ff_memless twl4030_wdt =
tsc2005 tsc200x_core omap_sham omap_wdt gpio_keys rx51_battery pwm_omap_d=
mtimer video_bus_switch videodev media ir_rx51 lirc_dev rc_core
[  258.469055] CPU: 0 PID: 752 Comm: usbnetworking-e Tainted: G      D W =
      4.6.0-rc4+ #2
[  258.503784] Hardware name: Nokia RX-51 board
[  258.537963] task: cec27700 ti: cf3a8000 task.ti: cf3a8000
[  258.571868] PC is at musb_default_readb+0x0/0xc
[  258.605163] LR is at omap2430_musb_set_mode+0x1c/0x48
[  258.637817] pc : [<c0401dc4>]    lr : [<c040b558>]    psr: a0000093
[  258.637817] sp : cf3a9e98  ip : c074f3fc  fp : 00000000
[  258.701904] r10: cf3a9f80  r9 : 0000000b  r8 : cd2163cc
[  258.732910] r7 : a0000013  r6 : 0000000b  r5 : cd216340  r4 : cf038010=

[  258.763488] r3 : c0401dc4  r2 : c040b53c  r1 : 00000060  r0 : fa0ab000=

[  258.793395] Flags: NzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segm=
ent none
[  258.823089] Control: 10c5387d  Table: 8d2b0019  DAC: 00000051
[  258.852325] Process usbnetworking-e (pid: 752, stack limit =3D 0xcf3a8=
210)
[  258.881866] Stack: (0xcf3a9e98 to 0xcf3aa000)
[  258.911743] 9e80:                                                     =
  cf038010 c04030a8
[  258.942504] 9ea0: 0000000b cf028eb0 cd216340 cd216340 cd2163c0 c039ecb=
4 0000000b c0242cc0
[  258.973693] 9ec0: c0242c84 00000000 00000000 c0241ee8 00000000 0000000=
0 c0241db4 000c9c08
[  259.005523] 9ee0: cf32c540 cf3a9f80 0000000b cf3a8000 0000000b c01dbab=
c cf3a9fb0 10c53c7d
[  259.037475] 9f00: 00000000 00000000 cf32c540 00000002 00000000 0000000=
b 00000000 cf32c540
[  259.070007] 9f20: 0000000b c01dc30c 00000001 cf32c540 cf3a9f80 0000000=
b cc0eed74 c014d904
[  259.102020] 9f40: 000c9c08 cf3a9f80 cf32c540 cf32c540 cf32c540 c01dd0a=
4 cf32c540 000c9c08
[  259.133666] 9f60: 0000000b 00000000 00000000 cf32c540 cf32c540 0000000=
b 000c9c08 c01dd388
[  259.165527] 9f80: 00000000 00000000 0000000b b6f580e4 0000000b 000c9c0=
8 00000004 c0107324
[  259.197509] 9fa0: 00000000 c0107160 b6f580e4 0000000b 00000001 000c9c0=
8 0000000b b6f1d52c
[  259.228820] 9fc0: b6f580e4 0000000b 000c9c08 00000004 000cbdc8 0000000=
0 00000001 00000000
[  259.259338] 9fe0: 0000000b bef4d9d8 b6f1cb00 b6f4268c 60000010 0000000=
1 00000000 00000000
[  259.289215] [<c0401dc4>] (musb_default_readb) from [<c040b558>] (omap2=
430_musb_set_mode+0x1c/0x48)
[  259.346862] [<c040b558>] (omap2430_musb_set_mode) from [<c04030a8>] (m=
usb_mode_store+0x9c/0x128)
[  259.376678] [<c04030a8>] (musb_mode_store) from [<c039ecb4>] (dev_attr=
_store+0x18/0x24)
[  259.406158] [<c039ecb4>] (dev_attr_store) from [<c0242cc0>] (sysfs_kf_=
write+0x3c/0x48)
[  259.435638] [<c0242cc0>] (sysfs_kf_write) from [<c0241ee8>] (kernfs_fo=
p_write+0x134/0x198)
[  259.465270] [<c0241ee8>] (kernfs_fop_write) from [<c01dbabc>] (__vfs_w=
rite+0x2c/0xd4)
[  259.495086] [<c01dbabc>] (__vfs_write) from [<c01dd0a4>] (vfs_write+0x=
a0/0x18c)
[  259.525360] [<c01dd0a4>] (vfs_write) from [<c01dd388>] (SyS_write+0x3c=
/0x78)
[  259.555694] [<c01dd388>] (SyS_write) from [<c0107160>] (ret_fast_sysca=
ll+0x0/0x3c)
[  259.585968] Code: e12fff1e e2800010 e0810180 e12fff1e (e7d00001)=20
[  259.616485] ---[ end trace 713e393a1cd324c0 ]---
[  259.657867] note: usbnetworking-e[752] exited with preempt_count 1
[  259.689178] In-band Error seen by MPU  at address 0
[  259.720031] ------------[ cut here ]------------
[  259.750518] WARNING: CPU: 0 PID: 752 at drivers/bus/omap_l3_smx.c:166 =
omap3_l3_app_irq+0xdc/0x124
[  259.781951] Modules linked in: ipv6 isp1704_charger(+) omap3_isp video=
buf2_v4l2 videobuf2_dma_contig videobuf2_memops videobuf2_core et8ek8 smi=
aregs lis3lv02d_i2c lis3lv02d input_polldev ti_soc_thermal arc4 wl1251_sp=
i wl1251 crc7 mac80211 cfg80211 omap_ssi hsi bq2415x_charger si4713 bq27x=
xx_battery_i2c bq27xxx_battery leds_lp5523 leds_lp55xx_common adp1653 v4l=
2_common tsl2563 smc91x mii rtc_twl twl4030_vibra ff_memless twl4030_wdt =
tsc2005 tsc200x_core omap_sham omap_wdt gpio_keys rx51_battery pwm_omap_d=
mtimer video_bus_switch videodev media ir_rx51 lirc_dev rc_core
[  259.984832] CPU: 0 PID: 752 Comm: usbnetworking-e Tainted: G      D W =
      4.6.0-rc4+ #2
[  260.019744] Hardware name: Nokia RX-51 board
[  260.054412] [<c010bc18>] (unwind_backtrace) from [<c0109f38>] (show_st=
ack+0x10/0x14)
[  260.090179] [<c0109f38>] (show_stack) from [<c0126c70>] (__warn+0xcc/0=
xf8)
[  260.126129] [<c0126c70>] (__warn) from [<c0126cb8>] (warn_slowpath_nul=
l+0x1c/0x20)
[  260.162567] [<c0126cb8>] (warn_slowpath_null) from [<c033260c>] (omap3=
_l3_app_irq+0xdc/0x124)
[  260.199432] [<c033260c>] (omap3_l3_app_irq) from [<c0154f50>] (handle_=
irq_event_percpu+0x34/0x138)
[  260.272827] [<c0154f50>] (handle_irq_event_percpu) from [<c01550b0>] (=
handle_irq_event+0x5c/0x88)
[  260.310485] [<c01550b0>] (handle_irq_event) from [<c0158020>] (handle_=
level_irq+0xcc/0x130)
[  260.347564] [<c0158020>] (handle_level_irq) from [<c0154930>] (generic=
_handle_irq+0x18/0x28)
[  260.384094] [<c0154930>] (generic_handle_irq) from [<c0154a50>] (__han=
dle_domain_irq+0x84/0xa8)
[  260.420928] [<c0154a50>] (__handle_domain_irq) from [<c054f914>] (__ir=
q_svc+0x54/0x90)
[  260.457855] [<c054f914>] (__irq_svc) from [<c017b16c>] (acct_collect+0=
x180/0x1b0)
[  260.494598] [<c017b16c>] (acct_collect) from [<c0128b4c>] (do_exit+0x1=
d8/0x920)
[  260.531372] [<c0128b4c>] (do_exit) from [<c010a294>] (die+0x358/0x3c0)=

[  260.567901] [<c010a294>] (die) from [<c01012ec>] (do_DataAbort+0xa0/0x=
b4)
[  260.604827] [<c01012ec>] (do_DataAbort) from [<c054f8a0>] (__dabt_svc+=
0x40/0x60)
[  260.641540] Exception stack(0xcf3a9e48 to 0xcf3a9e90)
[  260.678009] 9e40:                   fa0ab000 00000060 c040b53c c0401dc=
4 cf038010 cd216340
[  260.715515] 9e60: 0000000b a0000013 cd2163cc 0000000b cf3a9f80 0000000=
0 c074f3fc cf3a9e98
[  260.753021] 9e80: c040b558 c0401dc4 a0000093 ffffffff
[  260.790588] [<c054f8a0>] (__dabt_svc) from [<c0401dc4>] (musb_default_=
readb+0x0/0xc)
[  260.828338] [<c0401dc4>] (musb_default_readb) from [<c040b558>] (omap2=
430_musb_set_mode+0x1c/0x48)
[  260.902191] [<c040b558>] (omap2430_musb_set_mode) from [<c04030a8>] (m=
usb_mode_store+0x9c/0x128)
[  260.939971] [<c04030a8>] (musb_mode_store) from [<c039ecb4>] (dev_attr=
_store+0x18/0x24)
[  260.977325] [<c039ecb4>] (dev_attr_store) from [<c0242cc0>] (sysfs_kf_=
write+0x3c/0x48)
[  261.014160] [<c0242cc0>] (sysfs_kf_write) from [<c0241ee8>] (kernfs_fo=
p_write+0x134/0x198)
[  261.050506] [<c0241ee8>] (kernfs_fop_write) from [<c01dbabc>] (__vfs_w=
rite+0x2c/0xd4)
[  261.086517] [<c01dbabc>] (__vfs_write) from [<c01dd0a4>] (vfs_write+0x=
a0/0x18c)
[  261.122406] [<c01dd0a4>] (vfs_write) from [<c01dd388>] (SyS_write+0x3c=
/0x78)
[  261.158172] [<c01dd388>] (SyS_write) from [<c0107160>] (ret_fast_sysca=
ll+0x0/0x3c)
[  261.193572] ---[ end trace 713e393a1cd324c1 ]---
[  261.232757] mtdoops: ready 32, 33
[  367.338836] ubi0: attaching mtd5
[  367.465057] ubi0: scanning is finished
[  367.474395] ubi0 warning: ubi_eba_init: cannot reserve enough PEBs for=
 bad PEB handling, reserved 20, need 40
[  367.483673] ubi0: attached mtd5 (name "rootfs", size 251 MiB)
[  367.487335] ubi0: PEB size: 131072 bytes (128 KiB), LEB size: 129024 b=
ytes
[  367.510803] ubi0: min./max. I/O unit sizes: 2048/2048, sub-page size 5=
12
[  367.526824] ubi0: VID header offset: 512 (aligned 512), data offset: 2=
048
[  367.530792] ubi0: good PEBs: 2010, bad PEBs: 0, corrupted PEBs: 0
[  367.538665] ubi0: user volume: 1, internal volumes: 1, max. volumes co=
unt: 128
[  367.543029] ubi0: max/mean erase counter: 83/37, WL threshold: 4096, i=
mage sequence number: 25
[  367.547393] ubi0: available PEBs: 0, total reserved PEBs: 2010, PEBs r=
eserved for bad PEB handling: 20
[  367.555938] ubi0: background thread "ubi_bgt0d" started, PID 878
[  367.601104] UBIFS (ubi0:0): background thread "ubifs_bgt0_0" started, =
PID 883
[  367.634307] UBIFS (ubi0:0): UBIFS: mounted UBI device 0, volume 0, nam=
e "rootfs"
[  367.640075] UBIFS (ubi0:0): LEB size: 129024 bytes (126 KiB), min./max=
=2E I/O unit sizes: 2048 bytes/2048 bytes
[  367.651916] UBIFS (ubi0:0): FS size: 254822400 bytes (243 MiB, 1975 LE=
Bs), journal size 9033728 bytes (8 MiB, 71 LEBs)
[  367.665130] UBIFS (ubi0:0): reserved for root: 4190434 bytes (4092 KiB=
)
[  367.671997] UBIFS (ubi0:0): media format: w4/r0 (latest is w4/r0), UUI=
D 274FF656-4762-4CA0-A373-7005B2003DFC, small LPT model

--------------050507090701030407030302--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

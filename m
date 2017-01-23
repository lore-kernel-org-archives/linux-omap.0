From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: v4.9 to v4.10 regression: oops when USB cable is plugged in.
Date: Mon, 23 Jan 2017 23:25:37 +0100
Message-ID: <20170123222537.GA11543@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="Q68bSM7Ycu6FN28Q"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, aaro.koskinen-X3B1VOXEql0@public.gmane.org, ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, patrikbachan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, serge-A9i7LUbDfNHQT0dZR+AlfA@public.gmane.org, abcloriens-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: b-liu-l0cyMroinI0@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

v4.9 was ok (this is annoying enought that I'd notice).

v4.10-rc5 is not. (And yes, I probably=20

[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 4.10.0-rc5-142127-g41f2839-dirty (pavel@amd) (=
gcc version 4.7.2 (GCC) ) #222 Mon Jan 23 15:13:11 CET 2017
[    0.000000] CPU: ARMv7 Processor [411fc083] revision 3 (ARMv7), cr=3D10c=
5387d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT nonaliasing in=
struction cache
[    0.000000] OF: fdt:Machine model: Nokia N900
[    0.000000] cma: Reserved 16 MiB at 0x8e800000
[    0.000000] Memory policy: Data cache writeback
[    0.000000] On node 0 totalpages: 65280
[    0.000000] free_area_init_node: node 0, pgdat c0b4b848, node_mem_map cf=
cf1000
[    0.000000]   Normal zone: 512 pages used for memmap
[    0.000000]   Normal zone: 0 pages reserved
[    0.000000]   Normal zone: 65280 pages, LIFO batch:15
[    0.000000] CPU: All CPU(s) started in SVC mode.
[    0.000000] OMAP3430/3530 ES3.1 (l2cache iva sgx neon isp)
[    0.000000] pcpu-alloc: s0 r0 d32768 u32768 alloc=3D1*32768
[    0.000000] pcpu-alloc: [0] 0=20
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Tota=
l pages: 64768
[    0.000000] Kernel command line: root=3D/dev/mmcblk0p1 rootwait no-omap-=
wd no-ext-wd
[    0.000000] PID hash table entries: 1024 (order: 0, 4096 bytes)
[    0.000000] Dentry cache hash table entries: 32768 (order: 5, 131072 byt=
es)
[    0.000000] Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
[    0.000000] Memory: 231196K/261120K available (6144K kernel code, 305K r=
wdata, 2048K rodata, 1024K init, 313K bss, 13540K reserved, 16384K cma-rese=
rved, 0K highmem)
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
[    0.000000]     vmalloc : 0xd0800000 - 0xff800000   ( 752 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xd0000000   ( 256 MB)
[    0.000000]     pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
[    0.000000]     modules : 0xbf000000 - 0xbfe00000   (  14 MB)
[    0.000000]       .text : 0xc0008000 - 0xc0700000   (7136 kB)
[    0.000000]       .init : 0xc0a00000 - 0xc0b00000   (1024 kB)
[    0.000000]       .data : 0xc0b00000 - 0xc0b4c480   ( 306 kB)
[    0.000000]        .bss : 0xc0b4e000 - 0xc0b9c5f4   ( 314 kB)
[    0.000000] NR_IRQS:16 nr_irqs:16 16
[    0.000000] IRQ: Found an INTC at 0xfa200000 (revision 4.0) with 96 inte=
rrupts
[    0.000000] Clocking rate (Crystal/Core/MPU): 19.2/332/500 MHz
[    0.000000] OMAP clockevent source: timer1 at 32768 Hz
[    0.000000] clocksource: 32k_counter: mask: 0xffffffff max_cycles: 0xfff=
fffff, max_idle_ns: 58327039986419 ns
[    0.000000] sched_clock: 32 bits at 32kHz, resolution 30517ns, wraps eve=
ry 65535999984741ns
[    0.000030] OMAP clocksource: 32k_counter at 32768 Hz
[    0.000885] Console: colour dummy device 80x30
[    0.001708] console [tty0] enabled
[    0.001770] Calibrating delay loop... 496.43 BogoMIPS (lpj=3D2482176)
[    0.047760] pid_max: default: 32768 minimum: 301
[    0.047943] Security Framework initialized
[    0.048065] Mount-cache hash table entries: 1024 (order: 0, 4096 bytes)
[    0.048126] Mountpoint-cache hash table entries: 1024 (order: 0, 4096 by=
tes)
[    0.049377] CPU: Testing write buffer coherency: ok
[    0.050384] Setting up static identity map for 0x80100000 - 0x80100070
[    0.054046] devtmpfs: initialized
[    0.092803] VFP support v0.3: implementor 41 architecture 3 part 30 vari=
ant c rev 1
[    0.093353] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xfffffff=
f, max_idle_ns: 19112604462750000 ns
[    0.094879] pinctrl core: initialized pinctrl subsystem
[    0.096954] NET: Registered protocol family 16
[    0.101165] DMA: preallocated 256 KiB pool for atomic coherent allocatio=
ns
[    0.128479] omap_hwmod: mcbsp2_sidetone using broken dt data from mcbsp
[    0.129394] omap_hwmod: mcbsp3_sidetone using broken dt data from mcbsp
[    0.175903] cpuidle: using governor menu
[    0.176574] Reprogramming SDRC clock to 332000000 Hz
[    0.182952] gpio gpiochip0: (gpio): added GPIO chardev (254:0)
[    0.183471] gpiochip_setup_dev: registered GPIOs 0 to 31 on device: gpio=
chip0 (gpio)
[    0.186126] OMAP GPIO hardware version 2.5
[    0.187164] gpio gpiochip1: (gpio): added GPIO chardev (254:1)
[    0.187927] gpiochip_setup_dev: registered GPIOs 32 to 63 on device: gpi=
ochip1 (gpio)
[    0.191314] gpio gpiochip2: (gpio): added GPIO chardev (254:2)
[    0.191925] gpiochip_setup_dev: registered GPIOs 64 to 95 on device: gpi=
ochip2 (gpio)
[    0.195404] gpio gpiochip3: (gpio): added GPIO chardev (254:3)
[    0.195922] gpiochip_setup_dev: registered GPIOs 96 to 127 on device: gp=
iochip3 (gpio)
[    0.199218] gpio gpiochip4: (gpio): added GPIO chardev (254:4)
[    0.199737] gpiochip_setup_dev: registered GPIOs 128 to 159 on device: g=
piochip4 (gpio)
[    0.203033] gpio gpiochip5: (gpio): added GPIO chardev (254:5)
[    0.203552] gpiochip_setup_dev: registered GPIOs 160 to 191 on device: g=
piochip5 (gpio)
[    0.206359] irq: no irq domain found for /ocp@68000000/l4@48000000/scm@2=
000/pinmux@30 !
[    0.207092] irq: no irq domain found for /ocp@68000000/l4@48000000/scm@2=
000/pinmux@30 !
[    0.221435] omap-gpmc 6e000000.gpmc: could not find pctldev for node /oc=
p@68000000/l4@48000000/scm@2000/pinmux@30/pinmux_gpmc_pins, deferring probe
[    0.225769] RX-51: Enabling ARM errata 430973 workaround
[    0.227722] RX-51: Registering OMAP3 HWRNG device
[    0.232666] Reserving DMA channels 0 and 1 for HS ROM code
[    0.232727] OMAP DMA hardware revision 4.0
[    0.266967] omap-dma-engine 48056000.dma-controller: OMAP DMA engine dri=
ver
[    0.273071] omap-iommu 480bd400.mmu: 480bd400.mmu registered
[    0.274078] SCSI subsystem initialized
[    0.274658] usbcore: registered new interface driver usbfs
[    0.274810] usbcore: registered new interface driver hub
[    0.274993] usbcore: registered new device driver usb
[    0.275573] omap_i2c 48070000.i2c: could not find pctldev for node /ocp@=
68000000/l4@48000000/scm@2000/pinmux@30/pinmux_i2c1_pins, deferring probe
[    0.275726] omap_i2c 48072000.i2c: could not find pctldev for node /ocp@=
68000000/l4@48000000/scm@2000/pinmux@30/pinmux_i2c2_pins, deferring probe
[    0.275848] omap_i2c 48060000.i2c: could not find pctldev for node /ocp@=
68000000/l4@48000000/scm@2000/pinmux@30/pinmux_i2c3_pins, deferring probe
[    0.276214] pps_core: LinuxPPS API ver. 1 registered
[    0.276275] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo =
Giometti <giometti-k2GhghHVRtY@public.gmane.org>
[    0.276367] PTP clock support registered
[    0.276885] Advanced Linux Sound Architecture Driver Initialized.
[    0.279327] clocksource: Switched to clocksource 32k_counter
[    0.297271] NET: Registered protocol family 2
[    0.298400] TCP established hash table entries: 2048 (order: 1, 8192 byt=
es)
[    0.298522] TCP bind hash table entries: 2048 (order: 3, 40960 bytes)
[    0.298675] TCP: Hash tables configured (established 2048 bind 2048)
[    0.298858] UDP hash table entries: 256 (order: 1, 12288 bytes)
[    0.298919] UDP-Lite hash table entries: 256 (order: 1, 12288 bytes)
[    0.299255] NET: Registered protocol family 1
[    0.300079] RPC: Registered named UNIX socket transport module.
[    0.300140] RPC: Registered udp transport module.
[    0.300170] RPC: Registered tcp transport module.
[    0.300231] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.303558] futex hash table entries: 256 (order: 0, 7168 bytes)
[    0.304168] workingset: timestamp_bits=3D30 max_order=3D16 bucket_order=
=3D0
[    0.305480] NFS: Registering the id_resolver key type
[    0.305572] Key type id_resolver registered
[    0.305633] Key type id_legacy registered
[    0.310150] jitterentropy: Initialization failed with host not compliant=
 with requirements: 2
[    0.310455] io scheduler noop registered
[    0.310516] io scheduler deadline registered
[    0.310607] io scheduler cfq registered (default)
[    0.312805] pinctrl-single 48002030.pinmux: 284 pins at pa fa002030 size=
 568
[    0.313293] pinctrl-single 48002a00.pinmux: 46 pins at pa fa002a00 size =
92
[    0.313934] pinctrl-single 480025d8.pinmux: 18 pins at pa fa0025d8 size =
36
[    0.316986] DSS: set fck to 172800000
[    0.317077] 48050000.dss supply vdda_video not found, using dummy regula=
tor
[    0.317260] DSS: dss_runtime_get
[    0.317382] DSS: dss_restore_context
[    0.317382] OMAP DSS rev 2.0
[    0.317443] DSS: dss_runtime_put
[    0.317565] DISPC: dispc_runtime_get
[    0.317626] DISPC: fifo(0) threshold (bytes), old 960/1023, new 960/1023
[    0.317626] DISPC: fifo(1) threshold (bytes), old 960/1023, new 960/1023
[    0.317626] DISPC: fifo(2) threshold (bytes), old 960/1023, new 960/1023
[    0.317657] DISPC: dispc_restore_context
[    0.317657] DISPC: fifo(0) threshold (bytes), old 960/1023, new 960/1023
[    0.317687] DISPC: fifo(1) threshold (bytes), old 960/1023, new 960/1023
[    0.317687] DISPC: fifo(2) threshold (bytes), old 960/1023, new 960/1023
[    0.317718] omapdss_dispc 48050400.dispc: OMAP DISPC rev 3.0
[    0.317718] DISPC: dispc_runtime_put
[    0.317718] DISPC: dispc_save_context
[    0.317810] DISPC: context saved
[    0.317871] omapdss_dss 48050000.dss: bound 48050400.dispc (ops dispc_co=
mponent_ops)
[    0.318054] VENC: venc_runtime_get
[    0.318084] DISPC: dispc_runtime_get
[    0.318115] omapdss_venc 48050c00.encoder: OMAP VENC rev 2
[    0.318115] VENC: venc_runtime_put
[    0.318145] DISPC: dispc_runtime_put
[    0.318145] DISPC: dispc_save_context
[    0.318206] DISPC: context saved
[    0.318267] omapdss_dss 48050000.dss: bound 48050c00.encoder (ops venc_c=
omponent_ops)
[    0.319763] DISPC: dispc_runtime_get
[    0.319824] DISPC: dispc_runtime_put
[    0.319854] DISPC: dispc_save_context
[    0.319915] DISPC: context saved
[    0.319946] omapfb omapfb: no displays
[    0.320129] omapfb omapfb: failed to setup omapfb
[    0.322113] DSS: dss_save_context
[    0.322143] DSS: context saved
[    0.322448] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    0.326141] of_get_named_gpiod_flags: can't parse 'rts-gpio' property of=
 node '/ocp@68000000/serial@4806c000[0]'
[    0.326385] 4806c000.serial: ttyO1 at MMIO 0x4806c000 (irq =3D 89, base_=
baud =3D 3000000) is a OMAP UART1
[    0.327392] of_get_named_gpiod_flags: can't parse 'rts-gpio' property of=
 node '/ocp@68000000/serial@49020000[0]'
[    0.327545] 49020000.serial: ttyO2 at MMIO 0x49020000 (irq =3D 90, base_=
baud =3D 3000000) is a OMAP UART2
[    0.329101] omap3_rom_rng: initializing
[    0.356689] brd: module loaded
[    0.368164] loop: module loaded
[    0.369873] mtdoops: mtd device (mtddev=3Dname/number) must be supplied
[    0.373474] of_get_named_gpiod_flags: parsed 'reset-gpios' property of n=
ode '/ocp@68000000/spi@48098000/acx565akm@2[0]' - status (0)
[    0.384094] acx565akm spi1.2: omapfb: acx565akm rev ab LCD detected
[    0.389404] omap_ssi 48058000.ssi-controller: ssi controller 0 initializ=
ed (1 ports)!
[    0.390197] omap_ssi_port 4805a000.ssi-port: GPIO lookup for consumer ti=
,ssi-cawake
[    0.390197] omap_ssi_port 4805a000.ssi-port: using device tree for GPIO =
lookup
[    0.390228] of_get_named_gpiod_flags: can't parse 'ti,ssi-cawake-gpios' =
property of node '/ocp@68000000/ssi-controller@48058000/ssi-port@4805a000[0=
]'
[    0.390319] of_get_named_gpiod_flags: parsed 'ti,ssi-cawake-gpio' proper=
ty of node '/ocp@68000000/ssi-controller@48058000/ssi-port@4805a000[0]' - s=
tatus (0)
[    0.391510] omap_ssi_port 4805a000.ssi-port: ssi port 0 successfully ini=
tialized
[    0.392181] nokia-modem n900-modem: GPIO lookup for consumer (null)
[    0.392211] nokia-modem n900-modem: using device tree for GPIO lookup
[    0.392242] of_get_named_gpiod_flags: parsed 'gpios' property of node '/=
ocp@68000000/ssi-controller@48058000/ssi-port@4805a000/hsi-client[0]' - sta=
tus (0)
[    0.392486] nokia-modem n900-modem: GPIO lookup for consumer (null)
[    0.392517] nokia-modem n900-modem: using device tree for GPIO lookup
[    0.392608] of_get_named_gpiod_flags: parsed 'gpios' property of node '/=
ocp@68000000/ssi-controller@48058000/ssi-port@4805a000/hsi-client[1]' - sta=
tus (0)
[    0.392791] nokia-modem n900-modem: GPIO lookup for consumer (null)
[    0.392791] nokia-modem n900-modem: using device tree for GPIO lookup
[    0.392913] of_get_named_gpiod_flags: parsed 'gpios' property of node '/=
ocp@68000000/ssi-controller@48058000/ssi-port@4805a000/hsi-client[2]' - sta=
tus (0)
[    0.393096] nokia-modem n900-modem: GPIO lookup for consumer (null)
[    0.393127] nokia-modem n900-modem: using device tree for GPIO lookup
[    0.393249] of_get_named_gpiod_flags: parsed 'gpios' property of node '/=
ocp@68000000/ssi-controller@48058000/ssi-port@4805a000/hsi-client[3]' - sta=
tus (0)
[    0.393432] nokia-modem n900-modem: GPIO lookup for consumer (null)
[    0.393463] nokia-modem n900-modem: using device tree for GPIO lookup
[    0.393615] of_get_named_gpiod_flags: parsed 'gpios' property of node '/=
ocp@68000000/ssi-controller@48058000/ssi-port@4805a000/hsi-client[4]' - sta=
tus (0)
[    0.394683] SSI protocol aka McSAAB added
[    0.394805] CMT speech driver added
[    0.395050] HSI/SSI char device loaded
[    0.395507] libphy: Fixed MDIO Bus: probed
[    0.395935] of_get_named_gpiod_flags: parsed 'ti,power-gpio' property of=
 node '/ocp@68000000/spi@480ba000/wl1251@0[0]' - status (0)
[    0.396179] wl1251: ERROR vio regulator missing: -517
[    0.398040] udc-core: couldn't find an available UDC - added [g_ether] t=
o list of pending drivers
[    0.398681] mousedev: PS/2 mouse device common for all mice
[    0.399597] tsc2005 spi1.0: GPIO lookup for consumer reset
[    0.399597] tsc2005 spi1.0: using device tree for GPIO lookup
[    0.399688] of_get_named_gpiod_flags: parsed 'reset-gpios' property of n=
ode '/ocp@68000000/spi@48098000/tsc2005@0[0]' - status (0)
[    0.399810] tsc2005 spi1.0: vio regulator missing (-517)
[    0.400787] i2c /dev entries driver
[    0.402374] ti-soc-thermal 48002524.bandgap: This OMAP thermal sensor is=
 unreliable. You've been warned
[    0.402526] ti-soc-thermal 48002524.bandgap: Non-trimmed BGAP, Temp not =
accurate
[    0.403808] omap_wdt: OMAP Watchdog Timer Rev 0x31: initial timeout 60 s=
ec
[    0.405670] omap_hsmmc 4809c000.mmc: GPIO lookup for consumer cd
[    0.405670] omap_hsmmc 4809c000.mmc: using device tree for GPIO lookup
[    0.405700] of_get_named_gpiod_flags: can't parse 'cd-gpios' property of=
 node '/ocp@68000000/mmc@4809c000[0]'
[    0.405700] of_get_named_gpiod_flags: can't parse 'cd-gpio' property of =
node '/ocp@68000000/mmc@4809c000[0]'
[    0.405700] omap_hsmmc 4809c000.mmc: using lookup tables for GPIO lookup
[    0.405731] omap_hsmmc 4809c000.mmc: lookup for GPIO cd failed
[    0.405731] omap_hsmmc 4809c000.mmc: GPIO lookup for consumer wp
[    0.405761] omap_hsmmc 4809c000.mmc: using device tree for GPIO lookup
[    0.405761] of_get_named_gpiod_flags: can't parse 'wp-gpios' property of=
 node '/ocp@68000000/mmc@4809c000[0]'
[    0.405761] of_get_named_gpiod_flags: can't parse 'wp-gpio' property of =
node '/ocp@68000000/mmc@4809c000[0]'
[    0.405792] omap_hsmmc 4809c000.mmc: using lookup tables for GPIO lookup
[    0.405792] omap_hsmmc 4809c000.mmc: lookup for GPIO wp failed
[    0.406829] omap_hsmmc 480b4000.mmc: GPIO lookup for consumer wp
[    0.406860] omap_hsmmc 480b4000.mmc: using device tree for GPIO lookup
[    0.406860] of_get_named_gpiod_flags: can't parse 'wp-gpios' property of=
 node '/ocp@68000000/mmc@480b4000[0]'
[    0.406890] of_get_named_gpiod_flags: can't parse 'wp-gpio' property of =
node '/ocp@68000000/mmc@480b4000[0]'
[    0.406890] omap_hsmmc 480b4000.mmc: using lookup tables for GPIO lookup
[    0.406890] omap_hsmmc 480b4000.mmc: lookup for GPIO wp failed
[    0.408111] of_get_named_gpiod_flags: parsed 'gpios' property of node '/=
leds/heartbeat[0]' - status (0)
[    0.408569] ledtrig-cpu: registered to indicate activity on CPUs
[    0.411773] rx51-audio n900-audio: GPIO lookup for consumer tvout-select=
ion
[    0.411804] rx51-audio n900-audio: using device tree for GPIO lookup
[    0.411865] of_get_named_gpiod_flags: parsed 'tvout-selection-gpios' pro=
perty of node '/n900-audio[0]' - status (0)
[    0.411956] rx51-audio n900-audio: GPIO lookup for consumer jack-detecti=
on
[    0.411956] rx51-audio n900-audio: using device tree for GPIO lookup
[    0.412017] of_get_named_gpiod_flags: parsed 'jack-detection-gpios' prop=
erty of node '/n900-audio[0]' - status (0)
[    0.412017] no flags found for jack-detection
[    0.412048] rx51-audio n900-audio: GPIO lookup for consumer eci-switch
[    0.412048] rx51-audio n900-audio: using device tree for GPIO lookup
[    0.412048] of_get_named_gpiod_flags: can't parse 'eci-switch-gpios' pro=
perty of node '/n900-audio[0]'
[    0.412078] of_get_named_gpiod_flags: can't parse 'eci-switch-gpio' prop=
erty of node '/n900-audio[0]'
[    0.412078] rx51-audio n900-audio: using lookup tables for GPIO lookup
[    0.412078] rx51-audio n900-audio: lookup for GPIO eci-switch failed
[    0.412109] rx51-audio n900-audio: could not get eci switch gpio, contin=
uing
[    0.412170] rx51-audio n900-audio: GPIO lookup for consumer speaker-ampl=
ifier
[    0.412170] rx51-audio n900-audio: using device tree for GPIO lookup
[    0.412231] rx51-audio n900-audio: lookup for GPIO speaker-amplifier fai=
led
[    0.412261] rx51-audio n900-audio: could not get speaker enable gpio
[    0.412872] Initializing XFRM netlink socket
[    0.412994] NET: Registered protocol family 17
[    0.413085] NET: Registered protocol family 15
[    0.413269] NET: Registered protocol family 35
[    0.413482] Key type dns_resolver registered
[    0.413726] omap2_set_init_voltage: unable to find boot up OPP for vdd_m=
pu_iva
[    0.413818] omap2_set_init_voltage: unable to set vdd_mpu_iva
[    0.413879] omap2_set_init_voltage: unable to find boot up OPP for vdd_c=
ore
[    0.413909] omap2_set_init_voltage: unable to set vdd_core
[    0.419647] ThumbEE CPU extension supported.
[    0.419738] Registering SWP/SWPB emulation handler
[    0.419769] SmartReflex Class3 initialized
[    0.440521] omap-gpmc 6e000000.gpmc: GPMC revision 5.0
[    0.440612] gpmc_mem_init: disabling cs 0 mapped at 0x0-0x1000000
[    0.440704] gpiochip_find_base: found new base at 508
[    0.440765] gpio gpiochip6: (omap-gpmc): added GPIO chardev (254:6)
[    0.441375] gpiochip_setup_dev: registered GPIOs 508 to 511 on device: g=
piochip6 (omap-gpmc)
[    0.441894] omap2-onenand omap2-onenand: initializing on CS0, phys base =
0x01000000, virtual base d0900000, freq 66 MHz
[    0.442016] OneNAND Manufacturer: Samsung (0xec)
[    0.442047] Muxed OneNAND 256MB 1.8V 16-bit (0x40)
[    0.442077] OneNAND version =3D 0x0121
[    0.442108] Chip support all block unlock
[    0.442108] Chip has 2 plane
[    0.444396] Scanning device for bad blocks
[    0.501159] onenand_bbt_wait: ecc 0x2222 ctrl 0x2400 intr 0x8080 addr1 0=
x451 addr8 0x0
[    0.501159] OneNAND eraseblock 1105 is an initial bad block
[    0.549468] 6 ofpart partitions found on MTD device omap2-onenand
[    0.549530] Creating 6 MTD partitions on "omap2-onenand":
[    0.549591] 0x000000000000-0x000000020000 : "bootloader"
[    0.551666] 0x000000020000-0x000000080000 : "config"
[    0.553527] 0x000000080000-0x0000000c0000 : "log"
[    0.555358] 0x0000000c0000-0x0000002c0000 : "kernel"
[    0.557220] 0x0000002c0000-0x0000004c0000 : "initfs"
[    0.559173] 0x0000004c0000-0x000010000000 : "rootfs"
[    0.575042] twl 1-0048: PIH (irq 23) chaining IRQs 338..346
[    0.575225] twl 1-0048: power (irq 343) chaining IRQs 346..353
[    0.577819] twl_rtc 48070000.i2c:twl@48:rtc: Enabling TWL-RTC
[    0.581726] twl_rtc 48070000.i2c:twl@48:rtc: rtc core: registered 480700=
00.i2c:twl@48 as rtc0
[    0.584564] twl4030_bci 48070000.i2c:twl@48:bci: could not request vac i=
io channel
[    0.593017] random: fast init done
[    0.644989] twl4030_gpio twl4030-gpio: gpio (irq 338) chaining IRQs 354.=
=2E371
[    0.645385] gpiochip_find_base: found new base at 490
[    0.645416] gpio gpiochip7: (twl4030): added GPIO chardev (254:7)
[    0.645935] gpiochip_setup_dev: registered GPIOs 490 to 507 on device: g=
piochip7 (twl4030)
[    0.720550] twl4030_usb 48070000.i2c:twl@48:twl4030-usb: Initialized TWL=
4030 USB module
[    0.723449] input: twl4030_pwrbutton as /devices/platform/68000000.ocp/4=
8070000.i2c/i2c-1/1-0048/48070000.i2c:twl@48:pwrbutton/input/input1
[    0.725006] input: TWL4030 Keypad as /devices/platform/68000000.ocp/4807=
0000.i2c/i2c-1/1-0048/48070000.i2c:twl@48:keypad/input/input2
[    0.730377] 48070000.i2c:twl@48:madc supply vusb3v1 not found, using dum=
my regulator
[    0.733489] input: twl4030:vibrator as /devices/platform/68000000.ocp/48=
070000.i2c/i2c-1/1-0048/48070000.i2c:twl@48:audio/twl4030-vibra/input/input3
[    0.813903] omap_i2c 48070000.i2c: bus 1 rev3.3 at 2200 kHz
[    0.816253] of_get_named_gpiod_flags: parsed 'gpio-reset' property of no=
de '/ocp@68000000/i2c@48072000/tlv320aic3x@18[0]' - status (0)
[    0.818450] of_get_named_gpiod_flags: parsed 'gpio-reset' property of no=
de '/ocp@68000000/i2c@48072000/tlv320aic3x@19[0]' - status (0)
[    0.822692] tsl2563 2-0029: model 7, rev. 0
[    0.826629] of_get_named_gpiod_flags: parsed 'enable-gpio' property of n=
ode '/ocp@68000000/i2c@48072000/lp5523@32[0]' - status (0)
[    1.839813] omap_i2c 48072000.i2c: controller timed out
[    1.976470] lp5523x 2-0032: lp5523 Programmable led chip found
[    1.983764] (NULL device *): hwmon_device_register() is deprecated. Plea=
se convert the driver to use hwmon_device_register_with_info().
[    1.984100] bq27xxx-battery 2-0055: support ver. 1.2.0 enabled
[    1.995971] of_get_named_gpiod_flags: parsed 'power-gpio' property of no=
de '/ocp@68000000/i2c@48072000/tpa6130a2@60[0]' - status (0)
[    2.024780] bq2415x-charger 2-006b: automode supported, waiting for even=
ts
[    2.026000] bq2415x-charger 2-006b: driver registered
[    2.026092] omap_i2c 48072000.i2c: bus 2 rev3.3 at 100 kHz
[    2.049987] lis3lv02d: 8 bits sensor found
[    2.120056] input: ST LIS3LV02DL Accelerometer as /devices/platform/lis3=
lv02d/input/input4
[    2.124176] omap_i2c 48060000.i2c: bus 3 rev3.3 at 400 kHz
[    2.124847] DISPC: dispc_runtime_get
[    2.124938] DSS: dss_restore_context
[    2.124938] DSS: context restored
[    2.124999] DISPC: dispc_runtime_put
[    2.125030] DISPC: dispc_save_context
[    2.125091] DISPC: context saved
[    2.125640] DISPC: dispc_runtime_get
[    2.125671] DISPC: dispc_runtime_put
[    2.125701] DISPC: dispc_save_context
[    2.125762] DISPC: context saved
[    2.125762] DISPC: dispc_runtime_get
[    2.125793] DISPC: dispc_runtime_put
[    2.125793] DISPC: dispc_save_context
[    2.125823] DISPC: context saved
[    2.125854] DISPC: dispc_runtime_get
[    2.125854] DISPC: dispc_runtime_put
[    2.125854] DISPC: dispc_save_context
[    2.125915] DISPC: context saved
[    2.137268] APPLY: omap_dss_mgr_apply(lcd)
[    2.149505] Console: switching to colour frame buffer device 100x30
[    2.170135] APPLY: omap_dss_mgr_apply(lcd)
[    2.170166] APPLY: omap_dss_mgr_apply(lcd)
[    2.170166] APPLY: omap_dss_mgr_apply(tv)
[    2.170166] DISPC: dispc_runtime_get
[    2.170227] DSS: set fck to 72000000
[    2.170288] DISPC: lck =3D 72000000 (1)
[    2.170288] DISPC: pck =3D 24000000 (3)
[    2.172393] APPLY: writing mgr 0 regs
[    2.172393] APPLY: writing ovl 0 regs
[    2.172424] DISPC: dispc_ovl_setup 0, pa 0x8e900000, pa_uv 0x00000000, s=
w 800, 0,0, 800x480 -> 800x480, cmode 80, rot 0, mir 0, chan 0 repl 0
[    2.172454] DISPC: calc_rot(0): scrw 800, 800x480
[    2.172454] DISPC: offset0 0, offset1 0, row_inc 1, pix_inc 1
[    2.172485] DISPC: 0,0 800x480 -> 800x480
[    2.172485] APPLY: writing ovl 0 regs extra
[    2.172485] DISPC: dispc_enable_plane 0, 1
[    2.172515] DISPC: fifo(0) threshold (bytes), old 960/1023, new 960/1023
[    2.172515] APPLY: writing ovl 1 regs
[    2.172515] APPLY: writing ovl 1 regs extra
[    2.172515] APPLY: writing ovl 2 regs
[    2.172546] APPLY: writing ovl 2 regs extra
[    2.172546] APPLY: writing mgr 0 regs extra
[    2.172546] DISPC: channel 0 xres 800 yres 480
[    2.172546] DISPC: pck 24000000
[    2.172576] DISPC: hsw 4 hfp 28 hbp 24 vsw 3 vfp 3 vbp 4
[    2.172576] DISPC: vsync_level 0 hsync_level 0 data_pclk_edge 1 de_level=
 1 sync_pclk_edge 1
[    2.172576] DISPC: hsync 28037Hz, vsync 57Hz
[    2.172576] DISPC: lck =3D 72000000 (1)
[    2.172607] DISPC: pck =3D 24000000 (3)
[    2.239837] omapfb omapfb: using display 'lcd' mode 800x480
[    2.248443] nokia-modem n900-modem: GPIO lookup for consumer (null)
[    2.248474] nokia-modem n900-modem: using device tree for GPIO lookup
[    2.248535] of_get_named_gpiod_flags: parsed 'gpios' property of node '/=
ocp@68000000/ssi-controller@48058000/ssi-port@4805a000/hsi-client[0]' - sta=
tus (0)
[    2.248809] nokia-modem n900-modem: GPIO lookup for consumer (null)
[    2.248809] nokia-modem n900-modem: using device tree for GPIO lookup
[    2.248901] of_get_named_gpiod_flags: parsed 'gpios' property of node '/=
ocp@68000000/ssi-controller@48058000/ssi-port@4805a000/hsi-client[1]' - sta=
tus (0)
[    2.249114] nokia-modem n900-modem: GPIO lookup for consumer (null)
[    2.249114] nokia-modem n900-modem: using device tree for GPIO lookup
[    2.249237] of_get_named_gpiod_flags: parsed 'gpios' property of node '/=
ocp@68000000/ssi-controller@48058000/ssi-port@4805a000/hsi-client[2]' - sta=
tus (0)
[    2.249511] nokia-modem n900-modem: GPIO lookup for consumer (null)
[    2.249511] nokia-modem n900-modem: using device tree for GPIO lookup
[    2.249664] of_get_named_gpiod_flags: parsed 'gpios' property of node '/=
ocp@68000000/ssi-controller@48058000/ssi-port@4805a000/hsi-client[3]' - sta=
tus (0)
[    2.249877] nokia-modem n900-modem: GPIO lookup for consumer (null)
[    2.249877] nokia-modem n900-modem: using device tree for GPIO lookup
[    2.250030] of_get_named_gpiod_flags: parsed 'gpios' property of node '/=
ocp@68000000/ssi-controller@48058000/ssi-port@4805a000/hsi-client[4]' - sta=
tus (0)
[    2.252014] nokia-modem n900-modem: Registered Nokia HSI modem
[    2.260528] of_get_named_gpiod_flags: parsed 'ti,power-gpio' property of=
 node '/ocp@68000000/spi@480ba000/wl1251@0[0]' - status (0)
[    2.261322] ieee80211 phy1: Selected rate control algorithm 'minstrel_ht'
[    2.262664] wl1251: loaded
[    2.271484] wl1251: initialized
[    2.280273]  musb-hdrc.0.auto: registering UDC driver [g_ether]
[    2.280334] using random self ethernet address
[    2.287963] using random host ethernet address
[    2.295288] g_ether gadget: adding config #1 'CDC Ethernet (ECM)'/c0b3e7=
d0
[    2.295318] g_ether gadget: adding 'cdc_ethernet'/ce574480 to config 'CD=
C Ethernet (ECM)'/c0b3e7d0
[    2.296295] usb0: HOST MAC 5a:f0:f2:e5:35:17
[    2.303558] usb0: MAC 22:a4:7b:10:28:d9
[    2.310516] g_ether gadget: CDC Ethernet: dual speed IN/ep1in OUT/ep1out=
 NOTIFY/ep2in
[    2.310516] g_ether gadget: cfg 1/c0b3e7d0 speeds: high full
[    2.310516] g_ether gadget:   interface 0 =3D cdc_ethernet/ce574480
[    2.310546] g_ether gadget:   interface 1 =3D cdc_ethernet/ce574480
[    2.310546] g_ether gadget: Ethernet Gadget, version: Memorial Day 2008
[    2.317504] g_ether gadget: g_ether ready
[    2.324829] tsc2005 spi1.0: GPIO lookup for consumer reset
[    2.324829] tsc2005 spi1.0: using device tree for GPIO lookup
[    2.324890] of_get_named_gpiod_flags: parsed 'reset-gpios' property of n=
ode '/ocp@68000000/spi@48098000/tsc2005@0[0]' - status (0)
[    2.326538] input: TSC2005 touchscreen as /devices/platform/68000000.ocp=
/48098000.spi/spi_master/spi1/spi1.0/input/input5
[    2.342590] (NULL device *): hwmon_device_register() is deprecated. Plea=
se convert the driver to use hwmon_device_register_with_info().
[    2.357788] omap_hsmmc 4809c000.mmc: GPIO lookup for consumer cd
[    2.357788] omap_hsmmc 4809c000.mmc: using device tree for GPIO lookup
[    2.357818] of_get_named_gpiod_flags: can't parse 'cd-gpios' property of=
 node '/ocp@68000000/mmc@4809c000[0]'
[    2.357818] of_get_named_gpiod_flags: can't parse 'cd-gpio' property of =
node '/ocp@68000000/mmc@4809c000[0]'
[    2.357849] omap_hsmmc 4809c000.mmc: using lookup tables for GPIO lookup
[    2.357849] omap_hsmmc 4809c000.mmc: lookup for GPIO cd failed
[    2.357849] omap_hsmmc 4809c000.mmc: GPIO lookup for consumer wp
[    2.357879] omap_hsmmc 4809c000.mmc: using device tree for GPIO lookup
[    2.357879] of_get_named_gpiod_flags: can't parse 'wp-gpios' property of=
 node '/ocp@68000000/mmc@4809c000[0]'
[    2.357879] of_get_named_gpiod_flags: can't parse 'wp-gpio' property of =
node '/ocp@68000000/mmc@4809c000[0]'
[    2.357910] omap_hsmmc 4809c000.mmc: using lookup tables for GPIO lookup
[    2.357910] omap_hsmmc 4809c000.mmc: lookup for GPIO wp failed
[    2.420623] omap_hsmmc 480b4000.mmc: GPIO lookup for consumer wp
[    2.420654] omap_hsmmc 480b4000.mmc: using device tree for GPIO lookup
[    2.420654] of_get_named_gpiod_flags: can't parse 'wp-gpios' property of=
 node '/ocp@68000000/mmc@480b4000[0]'
[    2.420654] of_get_named_gpiod_flags: can't parse 'wp-gpio' property of =
node '/ocp@68000000/mmc@480b4000[0]'
[    2.420684] omap_hsmmc 480b4000.mmc: using lookup tables for GPIO lookup
[    2.420684] omap_hsmmc 480b4000.mmc: lookup for GPIO wp failed
[    2.490447] rx51-audio n900-audio: GPIO lookup for consumer tvout-select=
ion
[    2.490447] rx51-audio n900-audio: using device tree for GPIO lookup
[    2.490509] of_get_named_gpiod_flags: parsed 'tvout-selection-gpios' pro=
perty of node '/n900-audio[0]' - status (0)
[    2.490539] rx51-audio n900-audio: GPIO lookup for consumer jack-detecti=
on
[    2.490570] rx51-audio n900-audio: using device tree for GPIO lookup
[    2.490600] of_get_named_gpiod_flags: parsed 'jack-detection-gpios' prop=
erty of node '/n900-audio[0]' - status (0)
[    2.490631] no flags found for jack-detection
[    2.490631] rx51-audio n900-audio: GPIO lookup for consumer eci-switch
[    2.490661] rx51-audio n900-audio: using device tree for GPIO lookup
[    2.490661] of_get_named_gpiod_flags: can't parse 'eci-switch-gpios' pro=
perty of node '/n900-audio[0]'
[    2.490661] of_get_named_gpiod_flags: can't parse 'eci-switch-gpio' prop=
erty of node '/n900-audio[0]'
[    2.490661] rx51-audio n900-audio: using lookup tables for GPIO lookup
[    2.490692] rx51-audio n900-audio: lookup for GPIO eci-switch failed
[    2.490692] rx51-audio n900-audio: could not get eci switch gpio, contin=
uing
[    2.498046] rx51-audio n900-audio: GPIO lookup for consumer speaker-ampl=
ifier
[    2.498077] rx51-audio n900-audio: using device tree for GPIO lookup
[    2.498138] of_get_named_gpiod_flags: parsed 'speaker-amplifier-gpios' p=
roperty of node '/n900-audio[0]' - status (0)
[    2.505157] rx51-audio n900-audio: tlv320aic3x-hifi <-> 49022000.mcbsp m=
apping ok
[    2.523529] input: RX-51 AV Jack as /devices/platform/n900-audio/sound/c=
ard0/input6
[    2.540069] of_get_named_gpiod_flags: parsed 'gpios' property of node '/=
gpio_keys/camera_lens_cover[0]' - status (0)
[    2.540283] of_get_named_gpiod_flags: parsed 'gpios' property of node '/=
gpio_keys/eci_switch[0]' - status (0)
[    2.540435] of_get_named_gpiod_flags: parsed 'gpios' property of node '/=
gpio_keys/lock_button[0]' - status (0)
[    2.540527] of_get_named_gpiod_flags: parsed 'gpios' property of node '/=
gpio_keys/keypad_slide[0]' - status (0)
[    2.540649] of_get_named_gpiod_flags: parsed 'gpios' property of node '/=
gpio_keys/proximity_sensor[0]' - status (0)
[    2.541107] input: gpio_keys as /devices/platform/gpio_keys/input/input7
[    2.556579] twl_rtc 48070000.i2c:twl@48:rtc: setting system clock to 201=
7-01-22 18:24:02 UTC (1485109442)
[    2.571350] sr_init: No PMIC hook to init smartreflex
[    2.578918] smartreflex smartreflex.0: invalid resource
[    2.586273] smartreflex smartreflex.0: omap_sr_probe: ioremap fail
[    2.593597] smartreflex: probe of smartreflex.0 failed with error -22
[    2.600982] smartreflex smartreflex.1: invalid resource
[    2.608245] smartreflex smartreflex.1: omap_sr_probe: ioremap fail
[    2.615386] smartreflex: probe of smartreflex.1 failed with error -22
[    2.622619] sr_init: platform driver register failed for SR
[    2.631408] VCSI: disabling
[    2.639617] ALSA device list:
[    2.646423]   #0: RX-51
[    2.653503] Waiting for root device /dev/mmcblk0p1...
[    2.669006] mmc0: host does not support reading read-only switch, assumi=
ng write-enable
[    2.681671] mmc0: new high speed SDHC card at address e624
[    2.690032] mmcblk0: mmc0:e624 SU16G 14.8 GiB=20
[    2.710052]  mmcblk0: p1 p2 p3 p4
[    2.721740] EXT4-fs (mmcblk0p1): couldn't mount as ext3 due to feature i=
ncompatibilities
[    2.746765] EXT4-fs (mmcblk0p1): mounted filesystem with ordered data mo=
de. Opts: (null)
[    2.754638] VFS: Mounted root (ext4 filesystem) readonly on device 179:1.
[    2.763916] devtmpfs: mounted
[    2.774566] Freeing unused kernel memory: 1024K
[    2.794219] g_ether gadget: high-speed config #1: CDC Ethernet (ECM)
[    2.801422] g_ether gadget: init ecm
[    2.801452] g_ether gadget: notify connect false
[    2.802093] g_ether gadget: activate ecm
[    2.802154] usb0: qlen 10
[    2.802154] g_ether gadget: ecm_close
[    2.802337] g_ether gadget: packet filter 0c
[    2.802368] g_ether gadget: ecm req21.43 v000c i0000 l0
[    2.803771] mmc1: switch to bus width 8 failed
[    2.811370] mmc1: switch to bus width 4 failed
[    2.818023] mmc1: new high speed MMC card at address 0001
[    2.826507] mmcblk1: mmc1:0001 MMC32G 29.8 GiB=20
[    2.835479] mmcblk1boot0: mmc1:0001 MMC32G partition 1 512 KiB
[    2.842681] mmcblk1boot1: mmc1:0001 MMC32G partition 2 512 KiB
[    2.851013]  mmcblk1: p1 p2 p3 p4
[    4.294433] udevd[215]: starting version 175
[   13.526641] EXT4-fs (mmcblk0p1): re-mounted. Opts: (null)
[   18.814849] random: crng init done
[   19.379791] EXT4-fs (mmcblk0p4): mounted filesystem with ordered data mo=
de. Opts: errors=3Dremount-ro
[   21.834289] usb0: eth_open
[   21.834320] usb0: eth_start
[   21.834411] g_ether gadget: ecm_open
[   47.596801] DISPC: dispc_runtime_put
[   47.596832] DISPC: dispc_save_context
[   47.596893] DISPC: context saved
[   47.597106] DSS: dss_save_context
[   47.597106] DSS: context saved
[   52.236755] DISPC: dispc_runtime_get
[   52.236846] DSS: dss_restore_context
[   52.236846] DSS: context restored
[   52.236907] DSS: set fck to 72000000
[   52.236907] DISPC: lck =3D 72000000 (1)
[   52.236907] DISPC: pck =3D 24000000 (3)
[   52.239044] APPLY: writing mgr 0 regs
[   52.239044] APPLY: writing ovl 0 regs
[   52.239044] APPLY: writing ovl 0 regs extra
[   52.239044] APPLY: writing ovl 1 regs
[   52.239044] APPLY: writing ovl 1 regs extra
[   52.239044] APPLY: writing ovl 2 regs
[   52.239044] APPLY: writing ovl 2 regs extra
[   52.239044] APPLY: writing mgr 0 regs extra
[   52.239074] DISPC: channel 0 xres 800 yres 480
[   52.239074] DISPC: pck 24000000
[   52.239074] DISPC: hsw 4 hfp 28 hbp 24 vsw 3 vfp 3 vbp 4
[   52.239105] DISPC: vsync_level 0 hsync_level 0 data_pclk_edge 1 de_level=
 1 sync_pclk_edge 1
[   52.239105] DISPC: hsync 28037Hz, vsync 57Hz
[   52.239105] DISPC: lck =3D 72000000 (1)
[   52.239105] DISPC: pck =3D 24000000 (3)
[   92.289611] wl1251: 151 tx blocks at 0x3b788, 35 rx blocks at 0x3a780
[   92.319610] wl1251: firmware booted (Rev 4.0.4.3.7)
[  112.532684] ssi-protocol ssi-protocol: WAKELINES TEST OK
[  225.296844] DISPC: dispc_runtime_put
[  225.296844] DISPC: dispc_save_context
[  225.296936] DISPC: context saved
[  225.296997] DSS: dss_save_context
[  225.296997] DSS: context saved
[  225.426971] DISPC: dispc_runtime_get
[  225.427062] DSS: dss_restore_context
[  225.427062] DSS: context restored
[  225.427124] DSS: set fck to 72000000
[  225.427124] DISPC: lck =3D 72000000 (1)
[  225.427124] DISPC: pck =3D 24000000 (3)
[  225.429229] APPLY: writing mgr 0 regs
[  225.429260] APPLY: writing ovl 0 regs
[  225.429260] APPLY: writing ovl 0 regs extra
[  225.429260] APPLY: writing ovl 1 regs
[  225.429260] APPLY: writing ovl 1 regs extra
[  225.429260] APPLY: writing ovl 2 regs
[  225.429260] APPLY: writing ovl 2 regs extra
[  225.429260] APPLY: writing mgr 0 regs extra
[  225.429290] DISPC: channel 0 xres 800 yres 480
[  225.429290] DISPC: pck 24000000
[  225.429290] DISPC: hsw 4 hfp 28 hbp 24 vsw 3 vfp 3 vbp 4
[  225.429321] DISPC: vsync_level 0 hsync_level 0 data_pclk_edge 1 de_level=
 1 sync_pclk_edge 1
[  225.429321] DISPC: hsync 28037Hz, vsync 57Hz
[  225.429321] DISPC: lck =3D 72000000 (1)
[  225.429321] DISPC: pck =3D 24000000 (3)
[  225.703247] APPLY: omap_dss_mgr_apply(lcd)
[  225.703277] APPLY: writing mgr 0 regs
[  225.703277] APPLY: writing ovl 0 regs
[  225.703308] DISPC: dispc_ovl_setup 0, pa 0x8e900000, pa_uv 0x00000000, s=
w 800, 0,0, 800x480 -> 800x480, cmode 80, rot 0, mir 0, chan 0 repl 0
[  225.703338] DISPC: calc_rot(0): scrw 800, 800x480
[  225.703338] DISPC: offset0 0, offset1 0, row_inc 1, pix_inc 1
[  225.703369] DISPC: 0,0 800x480 -> 800x480
[  225.703369] APPLY: writing ovl 0 regs extra
[  225.703369] APPLY: writing ovl 1 regs
[  225.703369] APPLY: writing ovl 1 regs extra
[  225.703369] APPLY: writing ovl 2 regs
[  225.703369] APPLY: writing ovl 2 regs extra
[  225.703399] APPLY: writing mgr 0 regs extra
[  225.703399] DISPC: GO LCD
[  225.709014] APPLY: writing mgr 0 regs
[  225.709014] APPLY: writing ovl 0 regs
[  225.709014] APPLY: writing ovl 0 regs extra
[  225.709014] APPLY: writing ovl 1 regs
[  225.709014] APPLY: writing ovl 1 regs extra
[  225.709014] APPLY: writing ovl 2 regs
[  225.709014] APPLY: writing ovl 2 regs extra
[  225.709045] APPLY: writing mgr 0 regs extra
[  226.289794] DISPC: dispc_runtime_put
[  226.289794] DISPC: dispc_save_context
[  226.289886] DISPC: context saved
[  226.289978] DSS: dss_save_context
[  226.290008] DSS: context saved
[ 1575.550720] g_ether gadget: suspend
[ 1575.572204] g_ether gadget: reset config
[ 1575.572204] g_ether gadget: ecm deactivated
[ 1575.572235] usb0: gether_disconnect
[ 1578.346954] DISPC: dispc_runtime_get
[ 1578.347045] DSS: dss_restore_context
[ 1578.347076] DSS: context restored
[ 1578.347106] DISPC: fifo(0) threshold (bytes), old 960/1023, new 960/1023
[ 1578.347137] DISPC: fifo(1) threshold (bytes), old 960/1023, new 960/1023
[ 1578.347137] DISPC: fifo(2) threshold (bytes), old 960/1023, new 960/1023
[ 1578.347167] DISPC: dispc_restore_context
[ 1578.347198] DISPC: context restored
[ 1578.347229] DSS: set fck to 72000000
[ 1578.347229] DISPC: lck =3D 72000000 (1)
[ 1578.347229] DISPC: pck =3D 24000000 (3)
[ 1578.349365] APPLY: writing mgr 0 regs
[ 1578.349365] APPLY: writing ovl 0 regs
[ 1578.349365] APPLY: writing ovl 0 regs extra
[ 1578.349365] APPLY: writing ovl 1 regs
[ 1578.349365] APPLY: writing ovl 1 regs extra
[ 1578.349365] APPLY: writing ovl 2 regs
[ 1578.349365] APPLY: writing ovl 2 regs extra
[ 1578.349395] APPLY: writing mgr 0 regs extra
[ 1578.349395] DISPC: channel 0 xres 800 yres 480
[ 1578.349395] DISPC: pck 24000000
[ 1578.349395] DISPC: hsw 4 hfp 28 hbp 24 vsw 3 vfp 3 vbp 4
[ 1578.349426] DISPC: vsync_level 0 hsync_level 0 data_pclk_edge 1 de_level=
 1 sync_pclk_edge 1
[ 1578.349426] DISPC: hsync 28037Hz, vsync 57Hz
[ 1578.349426] DISPC: lck =3D 72000000 (1)
[ 1578.349426] DISPC: pck =3D 24000000 (3)
[ 1583.597747] DISPC: dispc_runtime_put
[ 1583.597778] DISPC: dispc_save_context
[ 1583.597839] DISPC: context saved
[ 1583.597991] DSS: dss_save_context
[ 1583.597991] DSS: context saved
[ 1583.716522] DISPC: dispc_runtime_get
[ 1583.716613] DSS: dss_restore_context
[ 1583.716613] DSS: context restored
[ 1583.716674] DSS: set fck to 72000000
[ 1583.716674] DISPC: lck =3D 72000000 (1)
[ 1583.716674] DISPC: pck =3D 24000000 (3)
[ 1583.718780] APPLY: writing mgr 0 regs
[ 1583.718811] APPLY: writing ovl 0 regs
[ 1583.718811] APPLY: writing ovl 0 regs extra
[ 1583.718811] APPLY: writing ovl 1 regs
[ 1583.718811] APPLY: writing ovl 1 regs extra
[ 1583.718811] APPLY: writing ovl 2 regs
[ 1583.718811] APPLY: writing ovl 2 regs extra
[ 1583.718811] APPLY: writing mgr 0 regs extra
[ 1583.718841] DISPC: channel 0 xres 800 yres 480
[ 1583.718841] DISPC: pck 24000000
[ 1583.718841] DISPC: hsw 4 hfp 28 hbp 24 vsw 3 vfp 3 vbp 4
[ 1583.718872] DISPC: vsync_level 0 hsync_level 0 data_pclk_edge 1 de_level=
 1 sync_pclk_edge 1
[ 1583.718872] DISPC: hsync 28037Hz, vsync 57Hz
[ 1583.718872] DISPC: lck =3D 72000000 (1)
[ 1583.718872] DISPC: pck =3D 24000000 (3)
[ 1584.000427] APPLY: omap_dss_mgr_apply(lcd)
[ 1584.000457] APPLY: writing mgr 0 regs
[ 1584.000457] APPLY: writing ovl 0 regs
[ 1584.000488] DISPC: dispc_ovl_setup 0, pa 0x8e900000, pa_uv 0x00000000, s=
w 800, 0,0, 800x480 -> 800x480, cmode 80, rot 0, mir 0, chan 0 repl 0
[ 1584.000518] DISPC: calc_rot(0): scrw 800, 800x480
[ 1584.000518] DISPC: offset0 0, offset1 0, row_inc 1, pix_inc 1
[ 1584.000549] DISPC: 0,0 800x480 -> 800x480
[ 1584.000549] APPLY: writing ovl 0 regs extra
[ 1584.000549] APPLY: writing ovl 1 regs
[ 1584.000549] APPLY: writing ovl 1 regs extra
[ 1584.000579] APPLY: writing ovl 2 regs
[ 1584.000579] APPLY: writing ovl 2 regs extra
[ 1584.000579] APPLY: writing mgr 0 regs extra
[ 1584.000610] DISPC: GO LCD
[ 1584.016052] APPLY: writing mgr 0 regs
[ 1584.016082] APPLY: writing ovl 0 regs
[ 1584.016082] APPLY: writing ovl 0 regs extra
[ 1584.016082] APPLY: writing ovl 1 regs
[ 1584.016082] APPLY: writing ovl 1 regs extra
[ 1584.016082] APPLY: writing ovl 2 regs
[ 1584.016113] APPLY: writing ovl 2 regs extra
[ 1584.016113] APPLY: writing mgr 0 regs extra
[ 1584.599426] DISPC: dispc_runtime_put
[ 1584.599456] DISPC: dispc_save_context
[ 1584.599517] DISPC: context saved
[ 1584.599639] DSS: dss_save_context
[ 1584.599670] DSS: context saved
[25383.799652] DISPC: dispc_runtime_get
[25383.799743] DSS: dss_restore_context
[25383.799743] DSS: context restored
[25383.799804] DISPC: fifo(0) threshold (bytes), old 960/1023, new 960/1023
[25383.799804] DISPC: fifo(1) threshold (bytes), old 960/1023, new 960/1023
[25383.799804] DISPC: fifo(2) threshold (bytes), old 960/1023, new 960/1023
[25383.799835] DISPC: dispc_restore_context
[25383.799865] DISPC: context restored
[25383.799896] DSS: set fck to 72000000
[25383.799896] DISPC: lck =3D 72000000 (1)
[25383.799926] DISPC: pck =3D 24000000 (3)
[25383.802032] APPLY: writing mgr 0 regs
[25383.802032] APPLY: writing ovl 0 regs
[25383.802032] APPLY: writing ovl 0 regs extra
[25383.802032] APPLY: writing ovl 1 regs
[25383.802032] APPLY: writing ovl 1 regs extra
[25383.802062] APPLY: writing ovl 2 regs
[25383.802062] APPLY: writing ovl 2 regs extra
[25383.802062] APPLY: writing mgr 0 regs extra
[25383.802062] DISPC: channel 0 xres 800 yres 480
[25383.802062] DISPC: pck 24000000
[25383.802093] DISPC: hsw 4 hfp 28 hbp 24 vsw 3 vfp 3 vbp 4
[25383.802093] DISPC: vsync_level 0 hsync_level 0 data_pclk_edge 1 de_level=
 1 sync_pclk_edge 1
[25383.802093] DISPC: hsync 28037Hz, vsync 57Hz
[25383.802093] DISPC: lck =3D 72000000 (1)
[25383.802124] DISPC: pck =3D 24000000 (3)
[25392.239837] Unhandled fault: external abort on non-linefetch (0x1028) at=
 0xfa0ab060
[25392.239868] pgd =3D c0004000
[25392.239898] [fa0ab060] *pgd=3D48011452(bad)
[25392.239929] Internal error: : 1028 [#1] ARM
[25392.239929] Modules linked in:
[25392.239959] CPU: 0 PID: 24322 Comm: kworker/0:1 Not tainted 4.10.0-rc5-1=
42127-g41f2839-dirty #222
[25392.239990] Hardware name: Nokia RX-51 board
[25392.240020] Workqueue: events musb_irq_work
[25392.240051] task: cd44d5c0 task.stack: cd308000
[25392.240051] PC is at musb_default_readb+0x0/0xc
[25392.240081] LR is at musb_irq_work+0x1c/0x1b0
[25392.240112] pc : [<c04a0e2c>]    lr : [<c04a0ad8>]    psr: 60000153
[25392.240112] sp : cd309f30  ip : 00000000  fp : 00000005
[25392.240112] r10: 00000000  r9 : 00000000  r8 : cfcab200
[25392.240142] r7 : ce5d81e8  r6 : c0b17fcc  r5 : ce5d81e4  r4 : ce5d81e4
[25392.240142] r3 : c04a0e2c  r2 : cd44d5c0  r1 : 00000060  r0 : fa0ab000
[25392.240173] Flags: nZCv  IRQs on  FIQs off  Mode SVC_32  ISA ARM  Segmen=
t none
[25392.240173] Control: 10c5387d  Table: 8d4c0019  DAC: 00000051
[25392.240203] Process kworker/0:1 (pid: 24322, stack limit =3D 0xcd308210)
[25392.240203] Stack: (0xcd309f30 to 0xcd30a000)
[25392.240234] 9f20:                                     c9480e00 ce5d81e4 =
c0b17fcc c013a5cc
[25392.240264] 9f40: c0b17fcc c0b1cf00 c9480e00 c0b17ff0 c0b1cf00 c9480e18 =
00000008 c0b17fcc
[25392.240295] 9f60: c0b17fcc c013a990 cd44d5c0 c9480380 00000000 c91db300 =
c94803a8 c9480e00
[25392.240295] 9f80: cd6a3ee4 c013a828 00000000 c013fc20 c91db300 c013fb30 =
00000000 00000000
[25392.240325] 9fa0: 00000000 00000000 00000000 c01076d8 00000000 00000000 =
00000000 00000000
[25392.240356] 9fc0: 00000000 00000000 00000000 00000000 00000000 00000000 =
00000000 00000000
[25392.240386] 9fe0: 00000000 00000000 00000000 00000000 00000013 00000000 =
00020036 03009ae6
[25392.240417] [<c04a0e2c>] (musb_default_readb) from [<c04a0ad8>] (musb_ir=
q_work+0x1c/0x1b0)
[25392.240447] [<c04a0ad8>] (musb_irq_work) from [<c013a5cc>] (process_one_=
work+0x10c/0x330)
[25392.240478] [<c013a5cc>] (process_one_work) from [<c013a990>] (worker_th=
read+0x168/0x498)
[25392.240509] [<c013a990>] (worker_thread) from [<c013fc20>] (kthread+0xf0=
/0x12c)
[25392.240539] [<c013fc20>] (kthread) from [<c01076d8>] (ret_from_fork+0x14=
/0x3c)
[25392.240570] Code: e6ff0070 e12fff1e e7c02001 e12fff1e (e7d00001)=20
[25392.240600] ---[ end trace 71d84b58111f2904 ]---
[25392.240631] In-band Error seen by MPU  at address 0
[25392.240631] ------------[ cut here ]------------
[25392.240661] WARNING: CPU: 0 PID: 24322 at drivers/bus/omap_l3_smx.c:166 =
omap3_l3_app_irq+0xcc/0x124
[25392.240692] Modules linked in:
[25392.240722] CPU: 0 PID: 24322 Comm: kworker/0:1 Tainted: G      D       =
  4.10.0-rc5-142127-g41f2839-dirty #222
[25392.240722] Hardware name: Nokia RX-51 board
[25392.240753] Workqueue: events musb_irq_work
[25392.240783] [<c010c9a4>] (unwind_backtrace) from [<c010a240>] (show_stac=
k+0x10/0x14)
[25392.240814] [<c010a240>] (show_stack) from [<c0126d88>] (__warn+0xd4/0xf=
c)
[25392.240844] [<c0126d88>] (__warn) from [<c0126dd0>] (warn_slowpath_null+=
0x20/0x28)
[25392.240875] [<c0126dd0>] (warn_slowpath_null) from [<c034e970>] (omap3_l=
3_app_irq+0xcc/0x124)
[25392.240905] [<c034e970>] (omap3_l3_app_irq) from [<c0158b04>] (__handle_=
irq_event_percpu+0x58/0x14c)
[25392.240966] [<c0158b04>] (__handle_irq_event_percpu) from [<c0158c14>] (=
handle_irq_event_percpu+0x1c/0x58)
[25392.240966] [<c0158c14>] (handle_irq_event_percpu) from [<c0158c88>] (ha=
ndle_irq_event+0x38/0x5c)
[25392.240997] [<c0158c88>] (handle_irq_event) from [<c015b95c>] (handle_le=
vel_irq+0xa0/0x128)
[25392.241027] [<c015b95c>] (handle_level_irq) from [<c01583fc>] (generic_h=
andle_irq+0x18/0x28)
[25392.241058] [<c01583fc>] (generic_handle_irq) from [<c01584f0>] (__handl=
e_domain_irq+0x4c/0xa4)
[25392.241088] [<c01584f0>] (__handle_domain_irq) from [<c010adac>] (__irq_=
svc+0x6c/0x90)
[25392.241119] [<c010adac>] (__irq_svc) from [<c0695aa4>] (_raw_spin_unlock=
_irq+0xc/0x10)
[25392.241149] [<c0695aa4>] (_raw_spin_unlock_irq) from [<c0128af4>] (do_ex=
it+0x104/0x968)
[25392.241180] [<c0128af4>] (do_exit) from [<c010a5f4>] (die+0x3b0/0x404)
[25392.241210] [<c010a5f4>] (die) from [<c0101300>] (do_DataAbort+0xa4/0xb4)
[25392.241241] [<c0101300>] (do_DataAbort) from [<c010ad00>] (__dabt_svc+0x=
60/0xa0)
[25392.241241] Exception stack(0xcd309ee0 to 0xcd309f28)
[25392.241271] 9ee0: fa0ab000 00000060 cd44d5c0 c04a0e2c ce5d81e4 ce5d81e4 =
c0b17fcc ce5d81e8
[25392.241302] 9f00: cfcab200 00000000 00000000 00000005 00000000 cd309f30 =
c04a0ad8 c04a0e2c
[25392.241302] 9f20: 60000153 ffffffff
[25392.241333] [<c010ad00>] (__dabt_svc) from [<c04a0e2c>] (musb_default_re=
adb+0x0/0xc)
[25392.241363] [<c04a0e2c>] (musb_default_readb) from [<c04a0ad8>] (musb_ir=
q_work+0x1c/0x1b0)
[25392.241394] [<c04a0ad8>] (musb_irq_work) from [<c013a5cc>] (process_one_=
work+0x10c/0x330)
[25392.241424] [<c013a5cc>] (process_one_work) from [<c013a990>] (worker_th=
read+0x168/0x498)
[25392.241455] [<c013a990>] (worker_thread) from [<c013fc20>] (kthread+0xf0=
/0x12c)
[25392.241455] [<c013fc20>] (kthread) from [<c01076d8>] (ret_from_fork+0x14=
/0x3c)
[25392.241485] ---[ end trace 71d84b58111f2905 ]---

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--Q68bSM7Ycu6FN28Q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAliGguEACgkQMOfwapXb+vKQgQCffsQKaUdEAiXF0WjvQrnjp/KC
ojIAoIbrGqtYY80eLBthFRJqrHaI2U0G
=gKXq
-----END PGP SIGNATURE-----

--Q68bSM7Ycu6FN28Q--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

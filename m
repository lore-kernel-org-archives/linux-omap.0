From: Russ Dill <russ.dill@gmail.com>
Subject: Re: [PATCH-V4 3/3] ARM: OMAP: Make OMAP clocksource source selection
 using kernel param
Date: Wed, 25 Apr 2012 21:36:40 -0700
Message-ID: <CA+Bv8XYemH3zW48id_ZAvC2gU_uZMFei6dMO1GUog_YTvFBV2Q@mail.gmail.com>
References: <1335260749-25877-1-git-send-email-hvaibhav@ti.com>
	<1335260749-25877-4-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:43882 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751522Ab2DZEgp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Apr 2012 00:36:45 -0400
Received: by lbbgf7 with SMTP id gf7so667515lbb.19
        for <linux-omap@vger.kernel.org>; Wed, 25 Apr 2012 21:36:40 -0700 (PDT)
In-Reply-To: <1335260749-25877-4-git-send-email-hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vaibhav Hiremath <hvaibhav@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, khilman@ti.com, paul@pwsan.com, santosh.shilimkar@ti.com, b-cousson@ti.com, linux-arm-kernel@lists.infradead.org, Felipe Balbi <balbi@ti.com>, Tarun Kanti DebBarma <tarun.kanti@ti.com>, Ming Lei <tom.leiming@gmail.com>

On Tue, Apr 24, 2012 at 2:45 AM, Vaibhav Hiremath <hvaibhav@ti.com> wro=
te:
> Current OMAP code supports couple of clocksource options based
> on compilation flag (CONFIG_OMAP_32K_TIMER). The 32KHz sync-timer
> and a gptimer which can run on 32KHz or system clock (e.g 38.4 MHz).
> So there can be 3 options -
>
> 1. 32KHz sync-timer
> 2. Sys_clock based (e.g 13/19.2/26/38.4 MHz) gptimer
> 3. 32KHz based gptimer.
>
> The optional gptimer based clocksource was added so that it can
> give the high precision than sync-timer, so expected usage was 2
> and not 3.
> Unfortunately option 2, clocksource doesn't meet the requirement of
> free-running clock as per clocksource need. It stops in low power sta=
tes
> when sys_clock is cut. That makes gptimer based clocksource option
> useless for OMAP2/3/4 devices with sys_clock as a clock input.
> Option 3 will still work but it is no better than 32K sync-timer
> based clocksource.
>
> So ideally we can kill the gptimer based clocksource option but there
> are some OMAP based derivative SoCs like AM33XX which doesn't have
> 32K sync-timer hardware IP and need to fallback on 32KHz based gptime=
r
> clocksource.
> Considering above, make sync-timer and gptimer clocksource runtime
> selectable so that both OMAP and AMXXXX continue to use the same code=
=2E
>
> Also, in order to precisely configure/setup sched_clock for given
> clocksource, decision has to be made early enough in boot sequence.
>
> So, the solution is,
>
> Use kernel parameter ("clocksource=3D") to override
> default 32k_sync-timer, in addition to this, we also use hwmod databa=
se
> lookup mechanism, through which at run-time we can identify availabil=
ity
> of 32k-sync timer on the device, else fall back to gptimer.
>
> Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Kevin Hilman <khilman@ti.com>
> Cc: Benoit Cousson <b-cousson@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Tarun Kanti DebBarma <tarun.kanti@ti.com>
> Cc: Ming Lei <tom.leiming@gmail.com>

This fails to boot on my Mistral am37x-evm with omap2plus_defconfig

## Booting kernel from Legacy Image at 80007fc0 ...
   Image Name:   Linux-3.4.0-rc3-ktest-11789-gea1
   Image Type:   ARM Linux Kernel Image (uncompressed)
   Data Size:    3360576 Bytes =3D 3.2 MiB
   Load Address: 80008000
   Entry Point:  80008000
   Verifying Checksum ... OK
   XIP Kernel Image ... OK
OK

Starting kernel ...

Uncompressing Linux... done, booting the kernel.
[    0.000000] Booting Linux on physical CPU 0
[    0.000000] Linux version 3.4.0-rc3-ktest-11789-gea133e0
(russ@russ-laptop) (gcc version 4.6.3 (Ubuntu/Linaro 4.6.3-1ubuntu5) )
#9 SMP Wed Apr 25 21:13:16 MST 2012
[    0.000000] CPU: ARMv7 Processor [413fc082] revision 2 (ARMv7), cr=3D=
10c53c7d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing
instruction cache
[    0.000000] Machine: OMAP3 EVM
[    0.000000] Memory policy: ECC disabled, Data cache writeback
[    0.000000] OMAP3630 ES1.2 (l2cache iva sgx neon isp 192mhz_clk )
[    0.000000] Clocking rate (Crystal/Core/MPU): 26.0/400/1000 MHz
[    0.000000] PERCPU: Embedded 8 pages/cpu @c0e0c000 s11456 r8192 d131=
20 u32768
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.
Total pages: 64768
[    0.000000] Kernel command line: console=3DttyO0,115200n8
root=3D/dev/nfs nfsroot=3D192.168.1.143:/var/datastore/exports/192.168.=
1.20,nolock
rw ip=3Ddhcp
[    0.000000] PID hash table entries: 1024 (order: 0, 4096 bytes)
[    0.000000] Dentry cache hash table entries: 32768 (order: 5, 131072=
 bytes)
[    0.000000] Inode-cache hash table entries: 16384 (order: 4, 65536 b=
ytes)
[    0.000000] Memory: 255MB =3D 255MB total
[    0.000000] Memory: 246504k/246504k available, 15640k reserved, 0K h=
ighmem
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
[    0.000000]     vmalloc : 0xd0800000 - 0xff000000   ( 744 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xd0000000   ( 256 MB)
[    0.000000]     modules : 0xbf000000 - 0xc0000000   (  16 MB)
[    0.000000]       .text : 0xc0008000 - 0xc05cced4   (5908 kB)
[    0.000000]       .init : 0xc05cd000 - 0xc061acc0   ( 312 kB)
[    0.000000]       .data : 0xc061c000 - 0xc06b0cd8   ( 596 kB)
[    0.000000]        .bss : 0xc06b0cfc - 0xc0c050e0   (5457 kB)
[    0.000000] Hierarchical RCU implementation.
[    0.000000] NR_IRQS:474
[    0.000000] IRQ: Found an INTC at 0xfa200000 (revision 4.0) with 96
interrupts
[    0.000000] Total of 96 interrupts on 1 active controller
[    0.000000] OMAP clockevent source: GPTIMER1 at 32768 Hz
[    0.000000] sched_clock: 32 bits at 32kHz, resolution 30517ns,
wraps every 131071999ms
[    0.000000] OMAP clocksource: 32k_counter at 32768 Hz
[    0.000000] Console: colour dummy device 80x30
[    0.000000] Lock dependency validator: Copyright (c) 2006 Red Hat,
Inc., Ingo Molnar
[    0.000000] ... MAX_LOCKDEP_SUBCLASSES:  8
[    0.000000] ... MAX_LOCK_DEPTH:          48
[    0.000000] ... MAX_LOCKDEP_KEYS:        8191
[    0.000000] ... CLASSHASH_SIZE:          4096
[    0.000000] ... MAX_LOCKDEP_ENTRIES:     16384
[    0.000000] ... MAX_LOCKDEP_CHAINS:      32768
[    0.000000] ... CHAINHASH_SIZE:          16384
[    0.000000]  memory used by lock dependency info: 3695 kB
[    0.000000]  per task-struct memory footprint: 1152 bytes
[    0.000549] Calibrating delay loop... 996.74 BogoMIPS (lpj=3D3891200=
)
[    0.062561] pid_max: default: 32768 minimum: 301
[    0.062988] Security Framework initialized
[    0.063140] Mount-cache hash table entries: 512
[    0.066223] CPU: Testing write buffer coherency: ok
[    0.066772] CPU0: thread -1, cpu 0, socket -1, mpidr 0
[    0.066802] Setting up static identity map for 0x804220e0 - 0x804221=
50
[    0.067871] Brought up 1 CPUs
[    0.067871] SMP: Total of 1 processors activated (996.74 BogoMIPS).
[    0.080902] dummy:
[    0.082183] NET: Registered protocol family 16
[    0.082977] GPMC revision 5.0
[    0.083099] gpmc: irq-20 could not claim: err -22
[    0.089172] gpiochip_add: registered GPIOs 0 to 31 on device: gpio
[    0.089477] OMAP GPIO hardware version 2.5
[    0.090148] gpiochip_add: registered GPIOs 32 to 63 on device: gpio
[    0.091064] gpiochip_add: registered GPIOs 64 to 95 on device: gpio
[    0.091918] gpiochip_add: registered GPIOs 96 to 127 on device: gpio
[    0.092742] gpiochip_add: registered GPIOs 128 to 159 on device: gpi=
o
[    0.093566] gpiochip_add: registered GPIOs 160 to 191 on device: gpi=
o
[    0.098327] omap_mux_init: Add partition: #1: core, flags: 0
[    0.111450] Reprogramming SDRC clock to 400000000 Hz
[    0.111450] dpll3_m2_clk rate change failed: -22
[    0.113220] hw-breakpoint: debug architecture 0x4 unsupported.
[    0.121795]  omap-mcbsp.2: alias fck already exists
[    0.122253]  omap-mcbsp.3: alias fck already exists
[    0.124908] OMAP DMA hardware revision 5.0
[    0.164764] bio: create slab <bio-0> at 0
[    0.167022] fixed-dummy:
[    0.170562] SCSI subsystem initialized
[    0.171844] omap2_mcspi omap2_mcspi.1: master is unqueued, this is d=
eprecated
[    0.174468] omap2_mcspi omap2_mcspi.2: master is unqueued, this is d=
eprecated
[    0.175201] omap2_mcspi omap2_mcspi.3: master is unqueued, this is d=
eprecated
[    0.175872] omap2_mcspi omap2_mcspi.4: master is unqueued, this is d=
eprecated
[    0.177795] usbcore: registered new interface driver usbfs
[    0.178436] usbcore: registered new interface driver hub
[    0.178833] usbcore: registered new device driver usb
[    0.180572] omap_i2c omap_i2c.1: bus 1 rev1.4.0 at 2600 kHz
[    0.186676] twl 1-0048: PIH (irq 7) chaining IRQs 320..328
[    0.187042] twl 1-0048: power (irq 325) chaining IRQs 328..335
[    0.189025] twl4030_gpio twl4030_gpio: gpio (irq 320) chaining IRQs =
336..353
[    0.189971] gpiochip_add: registered GPIOs 192 to 211 on device: twl=
4030
[    0.196807] VIO: 1800 mV normal standby
[    0.198272] vdd_mpu_iva: 600 <--> 1450 mV normal
[    0.199584] vdd_core: 600 <--> 1450 mV normal
[    0.200836] VMMC1: 1850 <--> 3150 mV at 3000 mV normal standby
[    0.202392] VDAC: 1800 mV normal standby
[    0.204376] VPLL2: 1800 mV normal standby
[    0.205841] VSIM: 1800 <--> 3000 mV at 1800 mV normal standby
[    0.206573] omap_i2c omap_i2c.2: bus 2 rev1.4.0 at 400 kHz
[    0.219024] omap_i2c omap_i2c.3: bus 3 rev1.4.0 at 400 kHz
[    0.224121] Switching to clocksource 32k_counter
[    0.289855] NET: Registered protocol family 2
[    0.290496] IP route cache hash table entries: 2048 (order: 1, 8192 =
bytes)
[    0.291809] TCP established hash table entries: 8192 (order: 4, 6553=
6 bytes)
[    0.292083] TCP bind hash table entries: 8192 (order: 6, 294912 byte=
s)
[    0.294799] TCP: Hash tables configured (established 8192 bind 8192)
[    0.294860] TCP: reno registered
[    0.294860] UDP hash table entries: 128 (order: 1, 10240 bytes)
[    0.295074] UDP-Lite hash table entries: 128 (order: 1, 10240 bytes)
[    0.295684] NET: Registered protocol family 1
[    0.296600] RPC: Registered named UNIX socket transport module.
[    0.296630] RPC: Registered udp transport module.
[    0.296630] RPC: Registered tcp transport module.
[    0.296661] RPC: Registered tcp NFSv4.1 backchannel transport module=
=2E
[    0.297210] NetWinder Floating Point Emulator V0.97 (double precisio=
n)
[    0.395935] VFS: Disk quotas dquot_6.5.2
[    0.396148] Dquot-cache hash table entries: 1024 (order 0, 4096 byte=
s)
[    0.397125] NFS: Registering the id_resolver key type
[    0.398223] jffs2: version 2.2. (NAND) (SUMMARY)  =C2=A9 2001-2006 R=
ed Hat, Inc.
[    0.398895] msgmni has been set to 481
[    0.401031] io scheduler noop registered
[    0.401062] io scheduler deadline registered
[    0.401214] io scheduler cfq registered (default)
[    0.402923] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    0.407135] omap_uart.0: ttyO0 at MMIO 0x4806a000 (irq =3D 72) is a =
OMAP UART0
[    1.098785] console [ttyO0] enabled
[    1.103515] omap_uart.1: ttyO1 at MMIO 0x4806c000 (irq =3D 73) is a =
OMAP UART1
[    1.111846] omap_uart.2: ttyO2 at MMIO 0x49020000 (irq =3D 74) is a =
OMAP UART2
[    1.120056] omap_uart.3: ttyO3 at MMIO 0x49042000 (irq =3D 80) is a =
OMAP UART3
[    1.147613] brd: module loaded
[    1.162567] loop: module loaded
[    1.170898] mtdoops: mtd device (mtddev=3Dname/number) must be suppl=
ied
[    1.178222] OneNAND driver initializing
[    1.186126] smsc911x: Driver version 2008-10-21
[    1.196441] smsc911x-mdio: probed
[    1.200103] smsc911x smsc911x.0: eth0: attached PHY driver [SMSC
LAN8700] (mii_bus:phy_addr=3Dsmsc911x-0:01, irq=3D-1)
[    1.211242] smsc911x smsc911x.0: eth0: MAC Address: 00:50:c2:d9:d1:0=
9
[    1.218811] usbcore: registered new interface driver asix
[    1.224822] usbcore: registered new interface driver cdc_ether
[    1.231231] usbcore: registered new interface driver net1080
[    1.237487] usbcore: registered new interface driver cdc_subset
[    1.244018] usbcore: registered new interface driver zaurus
[    1.250244] usbcore: registered new interface driver cdc_ncm
[    1.257537] usbcore: registered new interface driver cdc_wdm
[    1.263519] Initializing USB Mass Storage driver...
[    1.268981] usbcore: registered new interface driver usb-storage
[    1.275299] USB Mass Storage support registered.
[    1.280853] usbcore: registered new interface driver libusual
[    1.287261] usbcore: registered new interface driver usbtest
[    1.294189] mousedev: PS/2 mouse device common for all mice
[    1.301727] input: TWL4030 Keypad as
/devices/platform/omap_i2c.1/i2c-1/1-004a/twl4030_keypad/input/input0
[    1.316802] ads7846 spi1.0: touchscreen, irq 271
[    1.323455] input: ADS7846 Touchscreen as
/devices/platform/omap2_mcspi.1/spi_master/spi1/spi1.0/input/input1
[    1.336853] input: twl4030_pwrbutton as
/devices/platform/omap_i2c.1/i2c-1/1-0049/twl4030_pwrbutton/input/input=
2
[    1.348815] twl_rtc twl_rtc: Enabling TWL-RTC
[    1.356140] twl_rtc twl_rtc: rtc core: registered twl_rtc as rtc0
[    1.363494] i2c /dev entries driver
[    1.369476] Driver for 1-wire Dallas network protocol.
[    1.376983] omap_wdt: OMAP Watchdog Timer Rev 0x31: initial timeout =
60 sec
[    1.384918] twl4030_wdt twl4030_wdt: Failed to register misc device
[    1.391510] twl4030_wdt: probe of twl4030_wdt failed with error -16
Timed out after 300 seconds


> ---
> =C2=A0arch/arm/mach-omap1/timer32k.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 | =C2=A0 =C2=A06 ++-
> =C2=A0arch/arm/mach-omap2/timer.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0| =C2=A0 99 +++++++++++++++++++++------
> =C2=A0arch/arm/plat-omap/counter_32k.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =
=C2=A0108 +++++++++++++++---------------
> =C2=A0arch/arm/plat-omap/include/plat/common.h | =C2=A0 =C2=A02 +-
> =C2=A04 files changed, 138 insertions(+), 77 deletions(-)
>
> diff --git a/arch/arm/mach-omap1/timer32k.c b/arch/arm/mach-omap1/tim=
er32k.c
> index 325b9a0..6262e11 100644
> --- a/arch/arm/mach-omap1/timer32k.c
> +++ b/arch/arm/mach-omap1/timer32k.c
> @@ -71,6 +71,7 @@
>
> =C2=A0/* 16xx specific defines */
> =C2=A0#define OMAP1_32K_TIMER_BASE =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 0xfffb9000
> +#define OMAP1_32KSYNC_TIMER_BASE =C2=A0 =C2=A0 =C2=A0 0xfffbc400
> =C2=A0#define OMAP1_32K_TIMER_CR =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 0x08
> =C2=A0#define OMAP1_32K_TIMER_TVR =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A00x00
> =C2=A0#define OMAP1_32K_TIMER_TCR =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A00x04
> @@ -184,7 +185,10 @@ static __init void omap_init_32k_timer(void)
> =C2=A0*/
> =C2=A0bool __init omap_32k_timer_init(void)
> =C2=A0{
> - =C2=A0 =C2=A0 =C2=A0 omap_init_clocksource_32k();
> + =C2=A0 =C2=A0 =C2=A0 u32 pbase;
> +
> + =C2=A0 =C2=A0 =C2=A0 pbase =3D cpu_is_omap16xx() ? OMAP1_32KSYNC_TI=
MER_BASE : NULL;
> + =C2=A0 =C2=A0 =C2=A0 omap_init_clocksource_32k(pbase, SZ_1K);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0omap_init_32k_timer();
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return true;
> diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.=
c
> index ecec873..2afc4ab 100644
> --- a/arch/arm/mach-omap2/timer.c
> +++ b/arch/arm/mach-omap2/timer.c
> @@ -243,22 +243,8 @@ static void __init omap2_gp_clockevent_init(int =
gptimer_id,
> =C2=A0}
>
> =C2=A0/* Clocksource code */
> -
> -#ifdef CONFIG_OMAP_32K_TIMER
> -/*
> - * When 32k-timer is enabled, don't use GPTimer for clocksource
> - * instead, just leave default clocksource which uses the 32k
> - * sync counter. =C2=A0See clocksource setup in plat-omap/counter_32=
k.c
> - */
> -
> -static void __init omap2_gp_clocksource_init(int unused, const char =
*dummy)
> -{
> - =C2=A0 =C2=A0 =C2=A0 omap_init_clocksource_32k();
> -}
> -
> -#else
> -
> =C2=A0static struct omap_dm_timer clksrc;
> +static bool use_gptimer_clksrc;
>
> =C2=A0/*
> =C2=A0* clocksource
> @@ -285,7 +271,33 @@ static u32 notrace dmtimer_read_sched_clock(void=
)
> =C2=A0}
>
> =C2=A0/* Setup free-running counter for clocksource */
> -static void __init omap2_gp_clocksource_init(int gptimer_id,
> +static int __init omap2_sync32k_clocksource_init(void)
> +{
> + =C2=A0 =C2=A0 =C2=A0 int ret;
> + =C2=A0 =C2=A0 =C2=A0 struct omap_hwmod *oh;
> + =C2=A0 =C2=A0 =C2=A0 struct resource res;
> + =C2=A0 =C2=A0 =C2=A0 const char *oh_name =3D "counter_32k";
> +
> + =C2=A0 =C2=A0 =C2=A0 oh =3D omap_hwmod_lookup(oh_name);
> + =C2=A0 =C2=A0 =C2=A0 if (!oh || oh->slaves_cnt =3D=3D 0)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -ENODEV;
> +
> + =C2=A0 =C2=A0 =C2=A0 ret =3D omap_hwmod_get_resource_byname(oh, IOR=
ESOURCE_MEM, NULL, &res);
> + =C2=A0 =C2=A0 =C2=A0 if (ret) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pr_warn("%s: faile=
d to get counter_32k resource (%d)\n",
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __func__, ret);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 ret =3D omap_init_clocksource_32k(res.start, r=
esource_size(&res));
> + =C2=A0 =C2=A0 =C2=A0 if (ret)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pr_warn("%s: faile=
d to initialize counter_32k (%d)\n",
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __func__, ret);
> +
> + =C2=A0 =C2=A0 =C2=A0 return ret;
> +}
> +
> +static void __init omap2_gptimer_clocksource_init(int gptimer_id,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0const char *fck_source)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0int res;
> @@ -293,9 +305,6 @@ static void __init omap2_gp_clocksource_init(int =
gptimer_id,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0res =3D omap_dm_timer_init_one(&clksrc, gp=
timer_id, fck_source);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0BUG_ON(res);
>
> - =C2=A0 =C2=A0 =C2=A0 pr_info("OMAP clocksource: GPTIMER%d at %lu Hz=
\n",
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gptimer_id, clksrc=
=2Erate);
> -
> =C2=A0 =C2=A0 =C2=A0 =C2=A0__omap_dm_timer_load_start(&clksrc,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0OMAP_TIMER_CTRL_ST | OMAP_TIMER_CTRL_AR, 0, 1);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0setup_sched_clock(dmtimer_read_sched_clock=
, 32, clksrc.rate);
> @@ -303,15 +312,36 @@ static void __init omap2_gp_clocksource_init(in=
t gptimer_id,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (clocksource_register_hz(&clocksource_g=
pt, clksrc.rate))
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pr_err("Could =
not register clocksource %s\n",
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0clocksource_gpt.name);
> + =C2=A0 =C2=A0 =C2=A0 else
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pr_info("OMAP cloc=
ksource: GPTIMER%d at %lu Hz\n",
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 gptimer_id, clksrc.rate);
> +}
> +
> +static void __init omap2_clocksource_init(int gptimer_id,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 const char *fck_source)
> +{
> + =C2=A0 =C2=A0 =C2=A0 /*
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* First give preference to kernel parame=
ter configuration
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* by user (clocksource=3D"gp timer").
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0*
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* In case of missing kernel parameter fo=
r clocksource,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* first check for availability for 32k-s=
ync timer, in case
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* of failure in finding 32k_counter modu=
le or registering
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* it as clocksource, execution will fall=
back to gp-timer.
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
> + =C2=A0 =C2=A0 =C2=A0 if (use_gptimer_clksrc =3D=3D true)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 omap2_gptimer_cloc=
ksource_init(gptimer_id, fck_source);
> + =C2=A0 =C2=A0 =C2=A0 else if (omap2_sync32k_clocksource_init())
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Fall back to gp=
-timer code */
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 omap2_gptimer_cloc=
ksource_init(gptimer_id, fck_source);
> =C2=A0}
> -#endif
>
> =C2=A0#define OMAP_SYS_TIMER_INIT(name, clkev_nr, clkev_src, =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0clksrc_nr, clksrc_src) =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\
> =C2=A0static void __init omap##name##_timer_init(void) =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \
> =C2=A0{ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\
> =C2=A0 =C2=A0 =C2=A0 =C2=A0omap2_gp_clockevent_init((clkev_nr), clkev=
_src); =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\
> - =C2=A0 =C2=A0 =C2=A0 omap2_gp_clocksource_init((clksrc_nr), clksrc_=
src); =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \
> + =C2=A0 =C2=A0 =C2=A0 omap2_clocksource_init((clksrc_nr), clksrc_src=
); =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\
> =C2=A0}
>
> =C2=A0#define OMAP_SYS_TIMER(name) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \
> @@ -342,7 +372,7 @@ static DEFINE_TWD_LOCAL_TIMER(twd_local_timer,
> =C2=A0static void __init omap4_timer_init(void)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0omap2_gp_clockevent_init(1, OMAP4_CLKEV_SO=
URCE);
> - =C2=A0 =C2=A0 =C2=A0 omap2_gp_clocksource_init(2, OMAP4_MPU_SOURCE)=
;
> + =C2=A0 =C2=A0 =C2=A0 omap2_clocksource_init(2, OMAP4_MPU_SOURCE);
> =C2=A0#ifdef CONFIG_LOCAL_TIMERS
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Local timers are not supprted on OMAP44=
30 ES1.0 */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (omap_rev() !=3D OMAP4430_REV_ES1_0) {
> @@ -510,3 +540,28 @@ static int __init omap2_dm_timer_init(void)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;
> =C2=A0}
> =C2=A0arch_initcall(omap2_dm_timer_init);
> +
> +/**
> + * omap2_override_clocksource - clocksource override with user confi=
guration
> + *
> + * Allows user to override default clocksource, using kernel paramet=
er
> + * =C2=A0 clocksource=3D"gp timer"
> + *
> + * Note that, here we are using same standard kernel parameter "cloc=
ksource=3D",
> + * and not introducing any OMAP specific interface.
> + */
> +static int __init omap2_override_clocksource(char *str)
> +{
> + =C2=A0 =C2=A0 =C2=A0 if (!str)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;
> + =C2=A0 =C2=A0 =C2=A0 /*
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* For OMAP architecture, we only have tw=
o options
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* =C2=A0 =C2=A0- sync_32k (default)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* =C2=A0 =C2=A0- gp timer
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
> + =C2=A0 =C2=A0 =C2=A0 if (!strcmp(str, "gp timer"))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 use_gptimer_clksrc=
 =3D true;
> +
> + =C2=A0 =C2=A0 =C2=A0 return 0;
> +}
> +early_param("clocksource", omap2_override_clocksource);
> diff --git a/arch/arm/plat-omap/counter_32k.c b/arch/arm/plat-omap/co=
unter_32k.c
> index 5068fe5..3e3cdab 100644
> --- a/arch/arm/plat-omap/counter_32k.c
> +++ b/arch/arm/plat-omap/counter_32k.c
> @@ -27,19 +27,20 @@
>
> =C2=A0#include <plat/clock.h>
>
> +/* OMAP2_32KSYNCNT_CR_OFF: offset of 32ksync counter register */
> +#define OMAP2_32KSYNCNT_CR_OFF =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x10
> +
> =C2=A0/*
> =C2=A0* 32KHz clocksource ... always available, on pretty most chips =
except
> =C2=A0* OMAP 730 and 1510. =C2=A0Other timers could be used as clocks=
ources, with
> =C2=A0* higher resolution in free-running counter modes (e.g. 12 MHz =
xtal),
> =C2=A0* but systems won't necessarily want to spend resources that wa=
y.
> =C2=A0*/
> -static void __iomem *timer_32k_base;
> -
> -#define OMAP16XX_TIMER_32K_SYNCHRONIZED =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A00xfffbc410
> +static void __iomem *sync32k_cnt_reg;
>
> =C2=A0static u32 notrace omap_32k_read_sched_clock(void)
> =C2=A0{
> - =C2=A0 =C2=A0 =C2=A0 return timer_32k_base ? __raw_readl(timer_32k_=
base) : 0;
> + =C2=A0 =C2=A0 =C2=A0 return sync32k_cnt_reg ? __raw_readl(sync32k_c=
nt_reg) : 0;
> =C2=A0}
>
> =C2=A0/**
> @@ -59,7 +60,7 @@ void read_persistent_clock(struct timespec *ts)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct timespec *tsp =3D &persistent_ts;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0last_cycles =3D cycles;
> - =C2=A0 =C2=A0 =C2=A0 cycles =3D timer_32k_base ? __raw_readl(timer_=
32k_base) : 0;
> + =C2=A0 =C2=A0 =C2=A0 cycles =3D sync32k_cnt_reg ? __raw_readl(sync3=
2k_cnt_reg) : 0;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0delta =3D cycles - last_cycles;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0nsecs =3D clocksource_cyc2ns(delta, persis=
tent_mult, persistent_shift);
> @@ -68,54 +69,55 @@ void read_persistent_clock(struct timespec *ts)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0*ts =3D *tsp;
> =C2=A0}
>
> -int __init omap_init_clocksource_32k(void)
> +/**
> + * omap_init_clocksource_32k - setup and register counter 32k as a
> + * kernel clocksource
> + * @pbase: base addr of counter_32k module
> + * @size: size of counter_32k to map
> + *
> + * Returns 0 upon success or negative error code upon failure.
> + *
> + */
> +int __init omap_init_clocksource_32k(u32 pbase, unsigned long size)
> =C2=A0{
> - =C2=A0 =C2=A0 =C2=A0 static char err[] __initdata =3D KERN_ERR
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 "%s: can't register clocksource!\n";
> -
> - =C2=A0 =C2=A0 =C2=A0 if (cpu_is_omap16xx() || cpu_class_is_omap2())=
 {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 u32 pbase;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned long size=
 =3D SZ_4K;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 void __iomem *base=
;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct clk *sync_3=
2k_ick;
> -
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (cpu_is_omap16x=
x()) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 pbase =3D OMAP16XX_TIMER_32K_SYNCHRONIZED;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 size =3D SZ_1K;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if (cpu_is_=
omap2420())
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 pbase =3D OMAP2420_32KSYNCT_BASE + 0x10;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else if (cpu_is_om=
ap2430())
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 pbase =3D OMAP2430_32KSYNCT_BASE + 0x10;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else if (cpu_is_om=
ap34xx())
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 pbase =3D OMAP3430_32KSYNCT_BASE + 0x10;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else if (cpu_is_om=
ap44xx())
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 pbase =3D OMAP4430_32KSYNCT_BASE + 0x10;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 return -ENODEV;
> -
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* For this to wor=
k we must have a static mapping in io.c for this area */
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 base =3D ioremap(p=
base, size);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!base)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 return -ENODEV;
> -
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sync_32k_ick =3D c=
lk_get(NULL, "omap_32ksync_ick");
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!IS_ERR(sync_3=
2k_ick))
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 clk_enable(sync_32k_ick);
> -
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 timer_32k_base =3D=
 base;
> -
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* 120000 rou=
gh estimate from the calculations in
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* __clocksou=
rce_updatefreq_scale.
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 clocks_calc_mult_s=
hift(&persistent_mult, &persistent_shift,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 32768, NSEC_PER_SEC, 120000);
> -
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (clocksource_mm=
io_init(base, "32k_counter", 32768, 250, 32,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
clocksource_mmio_readl_up))
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 printk(err, "32k_counter");
> -
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 setup_sched_clock(=
omap_32k_read_sched_clock, 32, 32768);
> + =C2=A0 =C2=A0 =C2=A0 int ret;
> + =C2=A0 =C2=A0 =C2=A0 void __iomem *base;
> + =C2=A0 =C2=A0 =C2=A0 struct clk *sync32k_ick;
> +
> + =C2=A0 =C2=A0 =C2=A0 if (!pbase || !size)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -ENODEV;
> + =C2=A0 =C2=A0 =C2=A0 /*
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* For this to work we must have a static=
 mapping in io.c
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* for this area
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
> + =C2=A0 =C2=A0 =C2=A0 base =3D ioremap(pbase, size);
> + =C2=A0 =C2=A0 =C2=A0 if (!base) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pr_err("32k_counte=
r: failed to map base addr\n");
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -ENODEV;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> - =C2=A0 =C2=A0 =C2=A0 return 0;
> +
> + =C2=A0 =C2=A0 =C2=A0 sync32k_ick =3D clk_get(NULL, "omap_32ksync_ic=
k");
> + =C2=A0 =C2=A0 =C2=A0 if (!IS_ERR(sync32k_ick))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 clk_enable(sync32k=
_ick);
> +
> + =C2=A0 =C2=A0 =C2=A0 sync32k_cnt_reg =3D base + OMAP2_32KSYNCNT_CR_=
OFF;
> +
> + =C2=A0 =C2=A0 =C2=A0 /*
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* 120000 rough estimate from the calcula=
tions in
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* __clocksource_updatefreq_scale.
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
> + =C2=A0 =C2=A0 =C2=A0 clocks_calc_mult_shift(&persistent_mult, &pers=
istent_shift,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 32768, NSEC_PER_SEC, 120000);
> +
> + =C2=A0 =C2=A0 =C2=A0 ret =3D clocksource_mmio_init(base, "32k_count=
er", 32768, 250, 32,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 clocksource_mmio_readl_up);
> + =C2=A0 =C2=A0 =C2=A0 if (ret) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pr_err("32k_counte=
r: can't register clocksource\n");
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 setup_sched_clock(omap_32k_read_sched_clock, 3=
2, 32768);
> + =C2=A0 =C2=A0 =C2=A0 pr_info("OMAP clocksource: 32k_counter at 3276=
8 Hz\n");
> +
> + =C2=A0 =C2=A0 =C2=A0 return ret;
> =C2=A0}
> diff --git a/arch/arm/plat-omap/include/plat/common.h b/arch/arm/plat=
-omap/include/plat/common.h
> index a557b84..eed5335 100644
> --- a/arch/arm/plat-omap/include/plat/common.h
> +++ b/arch/arm/plat-omap/include/plat/common.h
> @@ -30,7 +30,7 @@
> =C2=A0#include <plat/i2c.h>
> =C2=A0#include <plat/omap_hwmod.h>
>
> -extern int __init omap_init_clocksource_32k(void);
> +extern int __init omap_init_clocksource_32k(u32 pbase, unsigned long=
 size);
>
> =C2=A0extern void __init omap_check_revision(void);
>
> --
> 1.7.0.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

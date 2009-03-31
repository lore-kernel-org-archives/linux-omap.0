From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: PM branch rebased to 2.6.29
Date: Tue, 31 Mar 2009 16:33:51 -0700
Message-ID: <87iqlpuv1c.fsf@deeprootsystems.com>
References: <87bprz9zju.fsf@deeprootsystems.com>
	<87zlfaztcd.fsf@deeprootsystems.com>
	<1237925484.23022.133.camel@blackhole>
	<49C940CA.9070805@deeprootsystems.com>
	<f9d2a5e10903271350x2d534c76nc55c492b8acd1d4e@mail.gmail.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301CC5699A0@dbde02.ent.ti.com>
	<f9d2a5e10903301044u775edfdo7ac540b3e1bdc597@mail.gmail.com>
	<873acu26ms.fsf@deeprootsystems.com>
	<f9d2a5e10903301601q5fcd331bs44c81d854ad0082f@mail.gmail.com>
	<87myb1wnvc.fsf@deeprootsystems.com>
	<f9d2a5e10903311431r6f053f02l25aba8183233c2b9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.226]:9463 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765037AbZCaXeB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 31 Mar 2009 19:34:01 -0400
Received: by rv-out-0506.google.com with SMTP id f9so3275673rvb.1
        for <linux-omap@vger.kernel.org>; Tue, 31 Mar 2009 16:33:59 -0700 (PDT)
In-Reply-To: <f9d2a5e10903311431r6f053f02l25aba8183233c2b9@mail.gmail.com> (Russ Dill's message of "Tue\, 31 Mar 2009 14\:31\:15 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russ Dill <russ.dill@gmail.com>
Cc: "Premi, Sanjeev" <premi@ti.com>, Peter Barada <peterb@logicpd.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Russ Dill <russ.dill@gmail.com> writes:

>> Russ,
>>
>> With the dump below, what was the output after you resumed? =A0Which
>> powerdomains did not hit their target state? =A0It looks like PER an=
d
>> CORE did not hit target state.
>
> yes, yes, and yes.
>
>> Also, you didn't mention what hardware you're using or your .config =
or
>> your bootloader etc. =A0All of these play an important role.
>
> Beagleboard B7, X-Loader 1.41, U-Boot 1.3.3

Not familiar with the all u-boot versions for this board, but is this
u-boot out of Steve Sakoman's tree?  I had lots of problems with the
TI bootloader leaving Beagle in a strange state and switched to using
the one from Steve's tree.  I have X-Loader 1.41 and:

  U-Boot 2009.01-rc1-00067-g8c6db17 (Jan 15 2009 - 16:31:00)           =
          =20

>>
>> Here is at least one problem.
>>
>> Offset 0x40 is CM_CLKSEL_WKUP, and bit 0 shows which clock is the
>> source clock for GPTIMER1. =A0Here, bit 0 is 1 which means SYS_CLK
>> is used as the timer source.
>>
>> Based on this, you must have:
>>
>> =A0 System Type --> TI OMAP Implementations --> System Timer
>>
>> set to 'MPU timer'. =A0Please change to 32k timer. =A0Using MPU time=
r will
>> keep timers not in WKUP powerdomain (which is all of them except GPT=
1)
>> running across suspend, preventing PER from hitting RET.
>>
>> Using the 32k timer only uses GPT1 and sources it from the 32k clock=
, both
>> of which are in the WKUP powerdomain.
>
> Nope, I have the following kernel message:
>
> OMAP clockevent source: GPTIMER12 at 32768 Hz
>
> and the following Kconfig options (also see the attached .config)

Right, I forgot Beagle is using GPT12, not GPT1.  nevermind.

> Texas Instruments X-Loader 1.41
> Starting OS Bootloader...
>
>
> U-Boot 1.3.3 (Jul 10 2008 - 16:33:09)

=46irst recommendation is to upgrade your bootloder:

  http://elinux.org/BeagleBoard#U-Boot

The earlier bootloaders seem to be blindly enabling reserved bits in
some of the PM registers which can leave the chip in an undefined
state.

> OMAP3530-GP rev 2, CPU-OPP2 L3-165MHz
> OMAP3 Beagle Board + LPDDR/NAND
> DRAM:  128 MB
> NAND:  256 MiB
> In:    serial
> Out:   serial
> Err:   serial
> Audio Tone on Speakers  ... complete
> Hit any key to stop autoboot:  0
>
> NAND read: device 0 offset 0x280000, size 0x400000
>  4194304 bytes read: OK
> ## Booting kernel from Legacy Image at 80000000 ...
>    Image Name:   Linux-2.6.29-omap1-pm
>    Image Type:   ARM Linux Kernel Image (uncompressed)
>    Data Size:    1476992 Bytes =3D  1.4 MB
>    Load Address: 80008000
>    Entry Point:  80008000
>    Verifying Checksum ... OK
>    Loading Kernel Image ... OK
> OK
>
> Starting kernel ...
>
> Uncompressing Linux..................................................=
=2E.............................................
> done, booting the kern.
> Linux version 2.6.29-omap1-pm (russ@russ-laptop) (gcc version 4.3.1
> (GCC) ) #47 PREEMPT Tue Mar 31 14:13:51 MST 2009
> CPU: ARMv7 Processor [411fc083] revision 3 (ARMv7), cr=3D10c5387f
> CPU: VIPT nonaliasing data cache, VIPT nonaliasing instruction cache
> Machine: OMAP3 Beagle Board
> Memory policy: ECC disabled, Data cache writeback
> OMAP3430 ES3.0
> SRAM: Mapped pa 0x40200000 to va 0xd7000000 size: 0x100000
> Built 1 zonelists in Zone order, mobility grouping on.  Total pages: =
32512
> Kernel command line: console=3DttyS2,115200n8 root=3D/dev/mtdblock4
> rootfstype=3Djffs2 rw g_ether.host_addr=3DB6:A3:A1:7D:8F:F0
> omapfb.mode=3Ddvi:126
> Unknown boot option `g_ether.host_addr=3DB6:A3:A1:7D:8F:F0': ignoring
> Unknown boot option `omapfb.mode=3Ddvi:1280x720M-16': ignoring
> Clocking rate (Crystal/DPLL/ARM core): 26.0/332/500 MHz
> Reprogramming SDRC
> GPMC revision 5.0
> IRQ: Found an INTC at 0xd8200000 (revision 4.0) with 96 interrupts
> Total of 96 interrupts on 1 active controller
> OMAP34xx GPIO hardware version 2.5
> PID hash table entries: 512 (order: 9, 2048 bytes)
> OMAP clockevent source: GPTIMER12 at 32768 Hz
> Console: colour dummy device 80x30
> Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
> Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
> Memory: 128MB =3D 128MB total
> Memory: 126648KB available (2692K code, 299K data, 96K init)
> Calibrating delay loop... 491.57 BogoMIPS (lpj=3D1921024)
> Mount-cache hash table entries: 512
> CPU: Testing write buffer coherency: ok
> net_namespace: 544 bytes
> regulator: core version 0.5
> NET: Registered protocol family 16
> Found NAND on CS0
> Registering NAND on CS0
> OMAP DMA hardware revision 4.0
> bio: create slab <bio-0> at 0
> i2c_omap i2c_omap.1: bus 1 rev3.12 at 2600 kHz
> twl4030: PIH (irq 7) chaining IRQs 368..375
> twl4030: power (irq 373) chaining IRQs 376..383
> twl4030: gpio (irq 368) chaining IRQs 384..401
> beagle_twl_gpio_setup:145
> twl4030_mmc_init:324
> twl4030_mmc_init:339
> regulator: VMMC1: 1850 <--> 3150 mV normal standby
> regulator: VDAC: 1800 mV normal standby
> regulator: VUSB1V5: 1500 <--> 0 mV normal standby
> regulator: VUSB1V8: 1800 <--> 0 mV normal standby
> regulator: VUSB3V1: 3100 <--> 0 mV normal standby
> regulator: VPLL2: 1800 mV normal standby
> regulator: VSIM: 1800 <--> 3000 mV normal standby
> i2c_omap i2c_omap.3: bus 3 rev3.12 at 100 kHz
> SCSI subsystem initialized
> twl4030_usb twl4030_usb: Initialized TWL4030 USB module
> NET: Registered protocol family 2
> IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
> TCP established hash table entries: 4096 (order: 3, 32768 bytes)
> TCP bind hash table entries: 4096 (order: 2, 16384 bytes)
> TCP: Hash tables configured (established 4096 bind 4096)
> TCP reno registered
> NET: Registered protocol family 1
> VFS: Disk quotas dquot_6.5.2
> Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
> JFFS2 version 2.2. (NAND) =A9 2001-2006 Red Hat, Inc.
> msgmni has been set to 247
> alg: No test for stdrng (krng)
> io scheduler noop registered (default)
> omapfb: configured for panel omap3beagle
> omapfb: skipping hardware initialization
> omapfb: DISPC version 3.0 initialized
> Console: switching to colour frame buffer device 128x48
> omapfb: Framebuffer initialized. Total vram 1572864 planes 1
> omapfb: Pixclock 64000 kHz hfreq 59.0 kHz vfreq 76.9 Hz
> Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
> serial8250.0: ttyS0 at MMIO 0x4806a000 (irq =3D 72) is a ST16654
> serial8250.0: ttyS1 at MMIO 0x4806c000 (irq =3D 73) is a ST16654
> serial8250.0: ttyS2 at MMIO 0x49020000 (irq =3D 74) is a ST16654
> console [ttyS2] enabled
> i2c /dev entries driver
> Driver 'sd' needs updating - please use bus_type methods
> omap2-nand driver initializing
> NAND device: Manufacturer ID: 0x2c, Chip ID: 0xba (Micron NAND 256MiB
> 1,8V 16-bit)
> cmdlinepart partition parsing not available
> Creating 5 MTD partitions on "omap2-nand":
> 0x000000000000-0x000000080000 : "X-Loader"
> 0x000000080000-0x000000260000 : "U-Boot"
> 0x000000260000-0x000000280000 : "U-Boot Env"
> 0x000000280000-0x000000680000 : "Kernel"
> 0x000000680000-0x000010000000 : "File System"
> twl4030_rtc twl4030_rtc: rtc core: registered twl4030_rtc as rtc0
> cpuidle: using governor ladder
> cpuidle: using governor menu
> mmci-omap-hs mmci-omap-hs.0: Failed to get debounce clock
> TCP cubic registered
> NET: Registered protocol family 17
> NET: Registered protocol family 15
> Power Management for TI OMAP3.
> pm_dbg_init()
> Disabling unused clock "sr2_fck"
> Disabling unused clock "sr1_fck"
> Disabling unused clock "mcbsp_fck"
> Disabling unused clock "mcbsp_fck"
> Disabling unused clock "mcbsp_fck"
> Disabling unused clock "mcbsp_ick"
> Disabling unused clock "mcbsp_ick"
> Disabling unused clock "mcbsp_ick"
> Disabling unused clock "gpt2_ick"
> Disabling unused clock "gpt3_ick"
> Disabling unused clock "gpt4_ick"
> Disabling unused clock "gpt5_ick"
> Disabling unused clock "gpt6_ick"
> Disabling unused clock "gpt7_ick"
> Disabling unused clock "gpt8_ick"
> Disabling unused clock "gpt9_ick"
> Disabling unused clock "wdt3_ick"
> Disabling unused clock "wdt3_fck"
> Disabling unused clock "gpio2_dbck"
> Disabling unused clock "gpio3_dbck"
> Disabling unused clock "gpio4_dbck"
> Disabling unused clock "gpio5_dbck"
> Disabling unused clock "gpio6_dbck"
> Disabling unused clock "gpt9_fck"
> Disabling unused clock "gpt8_fck"
> Disabling unused clock "gpt7_fck"
> Disabling unused clock "gpt6_fck"
> Disabling unused clock "gpt5_fck"
> Disabling unused clock "gpt4_fck"
> Disabling unused clock "gpt3_fck"
> Disabling unused clock "gpt2_fck"
> Disabling unused clock "gpt1_ick"
> Disabling unused clock "wdt1_ick"
> Disabling unused clock "wdt2_ick"
> Disabling unused clock "wdt2_fck"
> Disabling unused clock "gpio1_dbck"
> Disabling unused clock "gpt1_fck"
> Disabling unused clock "cam_ick"
> Disabling unused clock "cam_mclk"
> Disabling unused clock "dss_96m_fck"
> Disabling unused clock "des1_ick"
> Disabling unused clock "sha11_ick"
> Disabling unused clock "rng_ick"
> Disabling unused clock "aes1_ick"
> Disabling unused clock "ssi_ick"
> Disabling unused clock "mailboxes_ick"
> Disabling unused clock "mcbsp_ick"
> Disabling unused clock "mcbsp_ick"
> Disabling unused clock "gpt10_ick"
> Disabling unused clock "gpt11_ick"
> Disabling unused clock "i2c_ick"
> Disabling unused clock "mcspi_ick"
> Disabling unused clock "mcspi_ick"
> Disabling unused clock "mcspi_ick"
> Disabling unused clock "mcspi_ick"
> Disabling unused clock "hdq_ick"
> Disabling unused clock "mspro_ick"
> Disabling unused clock "des2_ick"
> Disabling unused clock "sha12_ick"
> Disabling unused clock "aes2_ick"
> Disabling unused clock "icr_ick"
> Disabling unused clock "pka_ick"
> Disabling unused clock "hsotgusb_ick"
> Disabling unused clock "ssi_ssr_fck"
> Disabling unused clock "hdq_fck"
> Disabling unused clock "mcspi_fck"
> Disabling unused clock "mcspi_fck"
> Disabling unused clock "mcspi_fck"
> Disabling unused clock "mcspi_fck"
> Disabling unused clock "mcbsp_fck"
> Disabling unused clock "mcbsp_fck"
> Disabling unused clock "i2c_fck"
> Disabling unused clock "mspro_fck"
> Disabling unused clock "gpt11_fck"
> Disabling unused clock "gpt10_fck"
> Disabling unused clock "sad2d_ick"
> Disabling unused clock "dpll5_ck"
> clock: dpll5_ck failed transition to 'locked'
> Disabling unused clock "dpll4_m6x2_ck"
> Disabling unused clock "dpll4_m3x2_ck"
> Disabling unused clock "dpll3_m3x2_ck"
> Disabling unused clock "sys_clkout1"
> VFP support v0.3: implementor 41 architecture 3 part 30 variant c rev=
 1
> twl4030_rtc twl4030_rtc: setting system clock to 2009-02-28 14:45:54
> UTC (1235832354)
> Empty flash at 0x014d884c ends at 0x014d9000
> Empty flash at 0x0365d678 ends at 0x0365d800
> Empty flash at 0x03d4b128 ends at 0x03d4b800
> Empty flash at 0x065f2240 ends at 0x065f2800
> Empty flash at 0x081d3c08 ends at 0x081d4000
> jffs2_scan_dirent_node(): Node CRC failed on node at 0x082bdfe4: Read
> 0xffffffff, calculated 0x8bd04d99
> Empty flash at 0x082be01c ends at 0x082be800
> Empty flash at 0x0ee1e7cc ends at 0x0ee1e800
> JFFS2 error: (1) jffs2_build_inode_pass1: child dir "players" (ino
> #35930) of dir ino #35929 appears to be a hard link
> VFS: Mounted root (jffs2 filesystem) on device 31:4.
> Freeing init memory: 96K
> INIT: version 2.86 booting

Hmm, you have rootfs on NAND.  I haven't tested NAND to know if that
driver might prevent RET.  It "should" be fine, but I am not sure. I
know that OneNAND doesn't, and MMC doesn't.  Any chance you could try
with rootfs on MMC?

I also recommend you boot with minimal rootfs by appending 'init=3D/bin=
/sh'
to the commandline.   That elminates any userspace stuff for now that m=
ight
be interfering as well.

> Please wait: booting...
> Starting udevudevd version 124 started
>
> Remounting root file system...
> uncorrectable error : <3>uncorrectable error : <3>end_request: I/O
> error, dev mtdblock0, sector 0
> Buffer I/O error on device mtdblock0, logical block 0
> uncorrectable error : <3>end_request: I/O error, dev mtdblock0, secto=
r 8
> Buffer I/O error on device mtdblock0, logical block 1
> uncorrectable error : <3>end_request: I/O error, dev mtdblock0, secto=
r 16
> Buffer I/O error on device mtdblock0, logical block 2
> uncorrectable error : <3>end_request: I/O error, dev mtdblock0, secto=
r 24
> Buffer I/O error on device mtdblock0, logical block 3
> uncorrectable error : <3>uncorrectable error : <3>end_request: I/O
> error, dev mtdblock0, sector 0
> Buffer I/O error on device mtdblock0, logical block 0
> logger: mount: mount point /proc/bus/usb does not exist
> ALSA: Restoring mixer settings...
> Configuring network interfaces... done.
> Starting portmap daemon: portmap.
> net.ipv4.conf.default.rp_filter =3D 1
> net.ipv4.conf.all.rp_filter =3D 1
> /usr/sbin/alsactl: load_state:1616: No soundcards found...
> INIT: Entering runlevel: 5
> No LEDs detected
> Starting Dropbear SSH server: dropbear.
> Starting advanced power management daemon: No APM support in kernel
> (failed.)
> Starting system message bus: dbus.
> Starting Hardware abstraction layer hald
> Starting syslogd/klogd: done
>  * Starting Avahi mDNS/DNS-SD Daemon: avahi-daemon
> [ ok ]
> Starting Bluetooth subsystem: hcid hid2hci.
> Starting hidd...
> Can't open HIDP control socket: Address family not supported by proto=
col
> Starting pand...
> Failed to open control socket: Address family not supported by protoc=
ol
> Running ntpdate to synchronize clockError : Temporary failure in name=
 resolution
> .
> ERROR: Module omaplfb does not exist in /proc/modules
> ERROR: Module pvrsrvkm does not exist in /proc/modules
> Usage: insmod filename [args]
> FATAL: Module omaplfb not found.
> mknod: missing operand after `0'
> Try `mknod --help' for more information.
> chmod: cannot access `/dev/pvrsrvkm': No such file or directory
> /dev/mem opened.
> Memory mapped at address 0x4001f000.
> Value at address 0x48004B40 (0x4001fb40): 0x2
> Written 0x0; readback 0x0
> Starting GPE display manager: gpe-dm
>
> .-------.
> |       |                  .-.
> |   |   |-----.-----.-----.| |   .----..-----.-----.
> |       |     | __  |  ---'| '--.|  .-'|     |     |
> |   |   |  |  |     |---  ||  --'|  |  |  '  | | | |
> '---'---'--'--'--.  |-----''----''--'  '-----'-'-'-'
>                 -'  |
>                 '---'
>
> The Angstrom Distribution beagleboard ttyS2
>
> Angstrom 2009.X-test-20090309 beagleboard ttyS2
>
> beagleboard login: root
> root@beagleboard:~# mount /debug/
> root@beagleboard:~# cd /sys/power/
> root@beagleboard:/sys/power# echo 1 > clocks_off_while_idle
> root@beagleboard:/sys/power# dmesg -n 8
> root@beagleboard:/sys/power# echo mem > state
> PM: Syncing filesystems ... done.
> PM: Preparing system for mem sleep
> Freezing user space processes ... (elapsed 0.00 seconds) done.
> Freezing remaining freezable tasks ... (elapsed 0.00 seconds) done.
> PM: Entering mem sleep
> Suspending console(s) (use no_console_suspend to debug)
> omapfb omapfb: timeout waiting for FRAME DONE
> clockdomain: clkdm per_clkdm: removing clk uart3_ick
> clockdomain: clkdm per_clkdm: removing clk per_48m_fck
> clockdomain: clkdm per_clkdm: removing clk uart3_fck
> clockdomain: clkdm per_clkdm: adding clk uart3_ick
> clockdomain: clkdm per_clkdm: adding clk uart3_fck
> clockdomain: clkdm per_clkdm: adding clk per_48m_fck
> Powerdomain (core_pwrdm) didn't enter target state 1
> Powerdomain (per_pwrdm) didn't enter target state 1
> Could not enter target state in pm_suspend
> PM: Finishing wakeup.
> Restarting tasks ... done.
> root@beagleboard:/sys/power# cat /debug/pm_debug/count
> usbhost_pwrdm (RET),OFF:0,RET:1,INA:0,ON:1
> sgx_pwrdm (OFF),OFF:1,RET:0,INA:0,ON:1
> per_pwrdm (ON),OFF:0,RET:0,INA:0,ON:1
> dss_pwrdm (ON),OFF:0,RET:1,INA:0,ON:2
> cam_pwrdm (RET),OFF:0,RET:1,INA:0,ON:1
> core_pwrdm (ON),OFF:0,RET:0,INA:0,ON:1
> neon_pwrdm (ON),OFF:0,RET:1,INA:958,ON:960
> mpu_pwrdm (ON),OFF:0,RET:1,INA:958,ON:960
> iva2_pwrdm (RET),OFF:0,RET:1,INA:0,ON:1
> per_clkdm->per_pwrdm (9)
> usbhost_clkdm->usbhost_pwrdm (0)
> cam_clkdm->cam_pwrdm (0)
> dss_clkdm->dss_pwrdm (2)
> core_l4_clkdm->core_pwrdm (11)
> core_l3_clkdm->core_pwrdm (4)
> d2d_clkdm->core_pwrdm (0)
> sgx_clkdm->sgx_pwrdm (0)
> iva2_clkdm->iva2_pwrdm (0)
> neon_clkdm->neon_pwrdm (0)
> mpu_clkdm->mpu_pwrdm (0)
> virt_opp_clkdm->wkup_pwrdm (0)
> prm_clkdm->wkup_pwrdm (10)
> cm_clkdm->core_pwrdm (4)
> root@beagleboard:/sys/power# cat /debug/pm_debug/registers/1
> MOD: CM_IVA2 (48014000)
>   04 =3D> 00000037  20 =3D> 00000001  34 =3D> 00000001  40 =3D> 00096=
80c
>   44 =3D> 00000001  48 =3D> 00000003
> MOD: CM_OCP (48004800)
>   00 =3D> 00000010  10 =3D> 00000001
> MOD: CM_MPU (48004900)
>   04 =3D> 00000037  24 =3D> 00000001  34 =3D> 00000001  40 =3D> 0011f=
40c
>   44 =3D> 00000001  48 =3D> 00000003  4c =3D> 00000001
> MOD: CM_CORE (48004a00)
>   10 =3D> 00000042  20 =3D> ffffffbd  24 =3D> 0000001f  28 =3D> 00000=
00d
>   30 =3D> fffffed9  34 =3D> 0000001f  38 =3D> 0000000c  40 =3D> 00000=
30a
>   48 =3D> 0000003f  4c =3D> 00000003
> MOD: CM_SGX (48004b00)
>   20 =3D> 00000001  48 =3D> 00000003
> MOD: CM_WKUP (48004c00)
>   10 =3D> 0000000e  20 =3D> 000002f1  30 =3D> 0000003f  40 =3D> 00000=
015
> MOD: CM_CCR (48004d00)
>   00 =3D> f8311037  04 =3D> 00000017  20 =3D> 00000201  30 =3D> 00000=
009
>   34 =3D> 00000001  40 =3D> 094c0c00  44 =3D> 0001b00c  48 =3D> 00000=
009
>   50 =3D> 00000001  70 =3D> 00000003
> MOD: CM_DSS (48004e00)
>   20 =3D> 00000003  30 =3D> 00000001  40 =3D> 00001006  48 =3D> 00000=
003
> MOD: CM_CAM (48004f00)
>   20 =3D> 00000001  30 =3D> 00000001  40 =3D> 00000004  48 =3D> 00000=
003
> MOD: CM_PER (48005000)
>   10 =3D> 0003e000  20 =3D> 00001fff  30 =3D> 0003ffff  40 =3D> 00000=
0ff
>   44 =3D> 00000006  48 =3D> 00000003  4c =3D> 00000001
> MOD: CM_EMU (48005100)
>   40 =3D> 03020a50  48 =3D> 00000001
> MOD: CM_NEON (48005300)
>   48 =3D> 00000003
> MOD: CM_USB (48005400)
>   20 =3D> 00000003  30 =3D> 00000001  48 =3D> 00000003
> MOD: PRM_IVA2 (48316000)
>   50 =3D> 00000007  e0 =3D> 00ff0f05  e4 =3D> 00000555  e8 =3D> 00000=
555
>   f8 =3D> 00000005
> MOD: PRM_OCP (48306800)
>   04 =3D> 00000010  14 =3D> 00000001  1c =3D> 00000201
> MOD: PRM_MPU (48306900)
>   58 =3D> 00000001  d4 =3D> 00000012  e0 =3D> 00030105  e4 =3D> 00000=
0c7
>   e8 =3D> 000000c7
> MOD: PRM_CORE (48306a00)
>   58 =3D> 00000301  a0 =3D> c33ffe18  a4 =3D> c33ffe18  a8 =3D> c33ff=
e18
>   e0 =3D> 000f0305  e4 =3D> 000000f7  e8 =3D> 000000f7  f0 =3D> 00000=
004
>   f4 =3D> 00000004  f8 =3D> 00000004
> MOD: PRM_SGX (48306b00)
>   e0 =3D> 00030104
> MOD: PRM_WKUP (48306c00)
>   a0 =3D> 0000010b  a4 =3D> 0000010b
> MOD: PRM_CCR (48306d00)
>   40 =3D> 00000003
> MOD: PRM_DSS (48306e00)
>   58 =3D> 00000001  a0 =3D> 00000001  e0 =3D> 00030105  e4 =3D> 00000=
001
>   e8 =3D> 00000001
> MOD: PRM_CAM (48306f00)
>   58 =3D> 00000001  e0 =3D> 00030105  e4 =3D> 00000001  e8 =3D> 00000=
001
> MOD: PRM_PER (48307000)
>   58 =3D> 00000001  a0 =3D> 0003efff  a4 =3D> 0003efff  a8 =3D> 0003e=
fff
>   c8 =3D> 00000007  e0 =3D> 00030105  e4 =3D> 00000007  e8 =3D> 00000=
007
> MOD: PRM_EMU (48307100)
>   58 =3D> 00000001  e4 =3D> 00000100
> MOD: PRM_GLBL (48307200)
>   20 =3D> 00120012  24 =3D> 00010000  2c =3D> 301e1e30  30 =3D> 2c1e1=
e2c
>   34 =3D> 00120000  38 =3D> 00000018  54 =3D> 00001006  58 =3D> 00000=
001
>   60 =3D> 00000002  64 =3D> 00000050  70 =3D> 00000088  90 =3D> 0fff0=
fff
>   94 =3D> 000000ff  98 =3D> 000000ff  9c =3D> 00000002  a0 =3D> 00000=
0ff
>   c4 =3D> 00000001  e4 =3D> 00000001
> MOD: PRM_NEON (48307300)
>   58 =3D> 00000001  c8 =3D> 00000002  e0 =3D> 00000005  e4 =3D> 00000=
003
>   e8 =3D> 00000003
> MOD: PRM_USB (48307400)
>   58 =3D> 00000001  a0 =3D> 00000001  a4 =3D> 00000001  a8 =3D> 00000=
001
>   e0 =3D> 00030105  e4 =3D> 00000001  e8 =3D> 00000001
> root@beagleboard:/sys/power#

The main thing that I see in this dump is that some of the bits marked
reserved in the TRM (such as SSI, SDMA etc.) are not auto-idled.  The
kernel isn't currently taking care of these corner cases and relies on
the bootloader not to blindly enable things.

After you update bootloaders, could you post the same results?

Thanks,

Kevin

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

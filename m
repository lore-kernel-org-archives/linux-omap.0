From: Francisco Alecrim <alecrim@gmail.com>
Subject: problem with n810 boot up
Date: Tue, 05 Jan 2010 19:24:56 -0400
Message-ID: <4B43CA48.3070009@gmail.com>
References: <200912290152.16357.luke@dashjr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f188.google.com ([209.85.210.188]:62843 "EHLO
	mail-yx0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753276Ab0AEXZE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Jan 2010 18:25:04 -0500
Received: by yxe26 with SMTP id 26so16145228yxe.4
        for <linux-omap@vger.kernel.org>; Tue, 05 Jan 2010 15:25:03 -0800 (PST)
In-Reply-To: <200912290152.16357.luke@dashjr.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Luke-Jr <luke@dashjr.org>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi@nokia.com>, Kalle Valo <kalle.valo@iki.fi>

Luke-Jr wrote:
>
> Tested on Nokia N810 in Linux-OMAP tree. Mainline is not bootable yet=
=2E
>


Hi Luke,

I'm with some problems to boot-up latest l-o(commit
abb74381235a05f15a3b07e9e3831034942c67fb) with n810. The error message
can be found below and full boot output in the end of email.

dsme: No correct bootreason found, entering the malfunction state

I'm not sure if it's related with kernel or rootfs. I tried different
distros(Maemo,Angstrom,Mamona and Mer) and I got the same problem using
this kernel.

What rootfs do you use? Did you change initfs?

Any idea/help?

Thanks in advance,
Alecrim.

PS: 2.6.30-rc8 is the last kernel version that I got working
(http://www.natisbad.org/N810/index.html)



Uncompressing
Linux..................................................................=
=2E...........
done, booting the kernel.
[    0.000000] Linux version 2.6.33-rc2-06901-gabb7438 (alecrim@alecrim=
)
(gcc version 4.3.2 (Sourcery G++ Lite 2008q3-72) ) #53 Tue Jan 5
18:35:16 AMT 2010
[    0.000000] CPU: ARMv6-compatible processor [4107b362] revision 2
(ARMv6TEJ), cr=3D00c5387f
[    0.000000] CPU: VIPT aliasing data cache, VIPT aliasing instruction
cache
[    0.000000] Machine: Nokia N810
[    0.000000] Ignoring unrecognised tag 0x414f4d50
[    0.000000] Memory policy: ECC disabled, Data cache writeback
[    0.000000] OMAP2420
[    0.000000]
[    0.000000] SRAM: Mapped pa 0x40200000 to va 0xfe400000 size: 0x1000=
00
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.
Total pages: 32512
[    0.000000] Kernel command line: root=3D1f03 rootfstype=3Djffs2
console=3DttyS2,115200
[    0.000000] PID hash table entries: 512 (order: -1, 2048 bytes)
[    0.000000] Dentry cache hash table entries: 16384 (order: 4, 65536
bytes)
[    0.000000] Inode-cache hash table entries: 8192 (order: 3, 32768 by=
tes)
[    0.000000] Memory: 64MB 64MB =3D 128MB total
[    0.000000] Memory: 127316KB available (2088K code, 184K data, 96K
init, 0K highmem)
[    0.000000] SLUB: Genslabs=3D11, HWalign=3D32, Order=3D0-3, MinObjec=
ts=3D0,
CPUs=3D1, Nodes=3D1
[    0.000000] Hierarchical RCU implementation.
[    0.000000] NR_IRQS:368
[    0.000000] Clocking rate (Crystal/DPLL/MPU): 19.2/658/329 MHz
[    0.000000] GPMC revision 2.0
[    0.000000] IRQ: Found an INTC at 0xfa0fe000 (revision 2.0) with 96
interrupts
[    0.000000] Total of 96 interrupts on 1 active controller
[    0.000000] OMAP GPIO hardware version 1.8
[    0.000000] OMAP clockevent source: GPTIMER1 at 32000 Hz
[    0.000000] Console: colour dummy device 80x30
[    0.000000] Calibrating delay loop... 320.37 BogoMIPS (lpj=3D1253376=
)
[    0.000000] Mount-cache hash table entries: 512
[    0.000000] CPU: Testing write buffer coherency: ok
[    0.000000] NET: Registered protocol family 16
[  307.198364] OMAP DMA hardware revision 2.0
[  307.216583] bio: create slab <bio-0> at 0
[  307.221252] usbcore: registered new interface driver usbfs
[  307.222290] usbcore: registered new interface driver hub
[  307.222869] usbcore: registered new device driver usb
[  307.225250] Switching to clocksource 32k_counter
[  307.229980] musb_hdrc: version 6.0, tusb-omap-dma, peripheral, debug=
=3D0
[  307.230895] NET: Registered protocol family 2
[  307.231140] IP route cache hash table entries: 1024 (order: 0, 4096
bytes)
[  307.231597] TCP established hash table entries: 4096 (order: 3, 3276=
8
bytes)
[  307.231872] TCP bind hash table entries: 4096 (order: 2, 16384 bytes=
)
[  307.232116] TCP: Hash tables configured (established 4096 bind 4096)
[  307.232147] TCP reno registered
[  307.232177] UDP hash table entries: 256 (order: 0, 4096 bytes)
[  307.232238] UDP-Lite hash table entries: 256 (order: 0, 4096 bytes)
[  307.232513] NET: Registered protocol family 1
[  307.234924] NetWinder Floating Point Emulator V0.97 (double precisio=
n)
[  307.267059] JFFS2 version 2.2. (NAND) (SUMMARY)  =A9 2001-2006 Red H=
at,
Inc.
[  307.269897] msgmni has been set to 248
[  307.270019] io scheduler noop registered
[  307.271697] io scheduler cfq registered (default)
[  307.310852] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[  307.334625] serial8250.0: ttyS0 at MMIO 0x4806a000 (irq =3D 72) is a
ST16654
[  307.355895] serial8250.1: ttyS1 at MMIO 0x4806c000 (irq =3D 73) is a
ST16654
[  307.376953] serial8250.2: ttyS2 at MMIO 0x4806e000 (irq =3D 74) is a
ST16654
[  307.685607] console [ttyS2] enabled
[  307.712738] brd: module loaded
[  307.716278] OneNAND driver initializing
[  307.720794] omap2-onenand omap2-onenand: initializing on CS0, phys
base 0x04000000, virtual base c8880000
[  307.730560] Muxed OneNAND 256MB 1.8V 16-bit (0x40)
[  307.735382] OneNAND version =3D 0x0022
[  307.740570] Scanning device for bad blocks
[  307.754882] onenand_bbt_wait: ecc error =3D 0x2222, controller error=
 0x2440
[  307.761840] Bad eraseblock 183 at 0x016e0000
[  307.836791] onenand_bbt_wait: ecc error =3D 0x2222, controller error=
 0x2440
[  307.843658] Bad eraseblock 1461 at 0x0b6a0000
[  307.880462] Creating 5 MTD partitions on "omap2-onenand":
[  307.885925] 0x000000000000-0x000000020000 : "bootloader"
[  307.891998] 0x000000020000-0x000000080000 : "config"
[  307.897674] 0x000000080000-0x000000280000 : "kernel"
[  307.903442] 0x000000280000-0x000000680000 : "initfs"
[  307.909149] 0x000000680000-0x000010000000 : "rootfs"
[  307.917602] mice: PS/2 mouse device common for all mice
[  307.923004] TCP cubic registered
[  307.927215] VFP support v0.3: implementor 41 architecture 1 part 20
variant b rev 2
[  308.001525] VFS: Mounted root (jffs2 filesystem) on device 31:3.
[  308.007781] Freeing init memory: 96K
BusyBox v1.00 (2008.10.21-06:19+0000) multi-call binary

Usage: mknod [OPTIONS] NAME TYPE MAJOR MINOR

Create a special file (block, character, or pipe).

Options:
        -m      create the special file using the specified mode
(default a=3Drw)

TYPEs include:
        b:      Make a block (buffered) device.
        c or u: Make a character (un-buffered) device.
        p:      Make a named pipe. MAJOR and MINOR are ignored for name=
d
pipes.

BusyBox v1.00 (2008.10.21-06:19+0000) multi-call binary

Usage: mknod [OPTIONS] NAME TYPE MAJOR MINOR

Create a special file (block, character, or pipe).

Options:
        -m      create the special file using the specified mode
(default a=3Drw)

TYPEs include:
        b:      Make a block (buffered) device.
        c or u: Make a character (un-buffered) device.
        p:      Make a named pipe. MAJOR and MINOR are ignored for name=
d
pipes.

Enabling core dumps to /media/mmc1/core-dumps/...done.
Starting DSME... done.
dsme: reading bootreason from /proc/bootreason
dsme: No correct bootreason found, entering the malfunction state
dsme: bootreason read **
dsme: bootreason was other than mbus, let's wait for the battery type
Wait for DSME socket to appear
grep: /proc/component_version: No such file or directory
fopen: Bad file descriptor
cal_read_block(r&d_mode): size zero, block not found?
Kicker: error reading R&D mode flags, both watchdogs enabledreceived st=
ate:8
Kicker: Error initialising OMAP watchdogKicker: failed to init WDs,
exiting...DSME: process '/usr/sbin/kicker' with pid 330 exited with
return value: 1
DSME: process '/usr/sbin/kicker' exited
 and restarted with pid 340
cal_read_block(r&d_mode): size zero, block not found?
Kicker: error reading R&D mode flags, both watchdogs enabledKicker:
Error initialising OMAP watchdogKicker: failed to init WDs,
exiting...DSME: process '/usr/sbin/kicker' with pid 340 exited with
return value: 1
DSME: process '/usr/sbin/kicker' exited
 and restarted with pid 352
Entering state 'MALF'.
cal_read_block(r&d_mode): size zero, block not found?
Kicker: error reading R&D mode flags, both watchdogs enabledHouston, we
have a problem, powering off...
Kicker: Error initialising OMAP watchdogKicker: failed to init WDs,
exiting...DSME: process '/usr/sbin/kicker' with pid 352 exited with
return value: 1
DSME: process '/usr/sbin/kicker' exited
 and restarted with pid 364

The system is going down NOW !!
Sending SIGTERM to all processes.
Sending SIGKILL to all processes.
[  311.089965] System halted.
grep: /proc/component_version: No such file or directory
Loading WLAN module...
[  311.293212] umac: version magic '2.6.21-omap1 mod_unload ARMv6 '
should be '2.6.33-rc2-06901-gabb7438 mod_unload ARMv6 '
insmod: cannot insert `/lib/modules/current/umac.ko': Invalid module
format (-1): Exec format error
[  311.337249] cx3110x: version magic '2.6.21-omap1 mod_unload ARMv6 '
should be '2.6.33-rc2-06901-gabb7438 mod_unload ARMv6 '
insmod: cannot insert `/lib/modules/current/cx3110x.ko': Invalid module
format (-1): Exec format error
Pushing the WLAN tuned values
cal_init: dsmesock_connect failedPushing default country...cal_init fai=
led
[FAILED]
cal_init: dsmesock_connect failedPushing MAC address...cal_init failed
bad CAL (0,28), Using default Nokia MAC Couldn't open
/sys/devices/platform/wlan-omap/cal_mac_address
[FAILED]
cal_init: dsmesock_connect failedPushing IQ tuned values...cal_init fai=
led
Got 0 bytes while expecting 108
[FAILED]
cal_init: dsmesock_connect failedPushing TX tuned values...cal_init fai=
led
(default values)Couldn't open
/sys/devices/platform/wlan-omap/cal_pa_curve_data
[FAILED]
Pushing TX limits...Couldn't open
/sys/devices/platform/wlan-omap/cal_output_limits
[FAILED]
Pushing RX tuned values...Using default values Couldn't open
/sys/devices/platform/wlan-omap/cal_rssi
[FAILED]
real    0m 0.64s
user    0m 0.00s
sys     0m 0.63s
dsmesock_connect: Connection refused
dsmesock_connect
Entering state 'MALF'.
Houston, we have a problem, powering off...
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

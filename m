From: Francisco Alecrim <alecrim@gmail.com>
Subject: N810: problem with watchdog
Date: Wed, 11 Nov 2009 19:39:06 -0400
Message-ID: <309201e0911111539u571fb7afm24be27fdb98a342a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f227.google.com ([209.85.218.227]:50004 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759603AbZKKXjD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Nov 2009 18:39:03 -0500
Received: by bwz27 with SMTP id 27so1629493bwz.21
        for <linux-omap@vger.kernel.org>; Wed, 11 Nov 2009 15:39:07 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi,

I'm trying to get latest linux-omap working with N810. I got an error
with watchdog(commit e7e7a613eded2732b68496f69ff8fc
34f16e1dd0) that I'm trying to solve the problem.

Any idea?

Thanks in advance,
Alecrim.

PS:
R&D flags : no-omap-wd, no-retu-wd, no-lifeguard-reset, serial-console =
=2E
Kernel output :
Timeout waiting for flashing commands
Loading kernel image info... done.
Loading kernel (1189 kB)... done in 60 ms (19596 kB/s)
Total bootup time 2763 ms
Uncompressing Linux....................................................=
=2E.........................
done, booting the kernel.
[=A0=A0=A0 0.000000] Linux version 2.6.32-rc6-06432-ge7e7a61
(alecrim@alecrim) (gcc version 4.3.2 (Sourcery G++ Lite 2008q3-72) )
#10 Wed Nov 11 17:05:29 AMT 2009
[=A0=A0=A0 0.000000] CPU: ARMv6-compatible processor [4107b362] revisio=
n 2
(ARMv6TEJ), cr=3D00c5387f
[=A0=A0=A0 0.000000] CPU: VIPT aliasing data cache, VIPT aliasing instr=
uction cache
[=A0=A0=A0 0.000000] Machine: Nokia N810
[=A0=A0=A0 0.000000] Ignoring unrecognised tag 0x414f4d50
[=A0=A0=A0 0.000000] Memory policy: ECC disabled, Data cache writeback
[=A0=A0=A0 0.000000] BUG: mapping for 0x58000000 at 0xe0000000 overlaps=
 vmalloc space
[=A0=A0=A0 0.000000] BUG: mapping for 0x59000000 at 0xe1000000 overlaps=
 vmalloc space
[=A0=A0=A0 0.000000] BUG: mapping for 0x5a000000 at 0xe2000000 overlaps=
 vmalloc space
[=A0=A0=A0 0.000000] OMAP2420
[=A0=A0=A0 0.000000]
[=A0=A0=A0 0.000000] SRAM: Mapped pa 0x40200000 to va 0xfe400000 size: =
0x100000
[=A0=A0=A0 0.000000] Built 1 zonelists in Zone order, mobility grouping=
 on.
Total pages: 32512
[=A0=A0=A0 0.000000] Kernel command line: root=3D1f03 rootfstype=3Djffs=
2
console=3DttyS2,115200n8
[=A0=A0=A0 0.000000] PID hash table entries: 512 (order: -1, 2048 bytes=
)
[=A0=A0=A0 0.000000] Dentry cache hash table entries: 16384 (order: 4, =
65536 bytes)
[=A0=A0=A0 0.000000] Inode-cache hash table entries: 8192 (order: 3, 32=
768 bytes)
[=A0=A0=A0 0.000000] Memory: 64MB 64MB =3D 128MB total
[=A0=A0=A0 0.000000] Memory: 127316KB available (2068K code, 189K data,=
 104K
init, 0K highmem)
[=A0=A0=A0 0.000000] SLUB: Genslabs=3D11, HWalign=3D32, Order=3D0-3, Mi=
nObjects=3D0,
CPUs=3D1, Nodes=3D1
[=A0=A0=A0 0.000000] Hierarchical RCU implementation.
[=A0=A0=A0 0.000000] NR_IRQS:368
[=A0=A0=A0 0.000000] Clocking rate (Crystal/DPLL/MPU): 19.2/658/329 MHz
[=A0=A0=A0 0.000000] GPMC revision 2.0
[=A0=A0=A0 0.000000] IRQ: Found an INTC at 0xfa0fe000 (revision 2.0) wi=
th 96
interrupts
[=A0=A0=A0 0.000000] Total of 96 interrupts on 1 active controller
[=A0=A0=A0 0.000000] OMAP GPIO hardware version 1.8
[=A0=A0=A0 0.000000] OMAP clockevent source: GPTIMER1 at 32000 Hz
[=A0=A0=A0 0.000000] Console: colour dummy device 80x30
[=A0=A0=A0 0.000000] Calibrating delay loop... 320.37 BogoMIPS (lpj=3D1=
253376)
[=A0=A0=A0 0.000000] Mount-cache hash table entries: 512
[=A0=A0=A0 0.000000] CPU: Testing write buffer coherency: ok
[=A0=A0=A0 0.000000] NET: Registered protocol family 16
[=A0=A0=A0 5.921752] OMAP DMA hardware revision 2.0
[=A0=A0=A0 5.940643] bio: create slab <bio-0> at 0
[=A0=A0=A0 5.945556] usbcore: registered new interface driver usbfs
[=A0=A0=A0 5.946472] usbcore: registered new interface driver hub
[=A0=A0=A0 5.947082] usbcore: registered new device driver usb
[=A0=A0=A0 5.949523] Switching to clocksource 32k_counter
[=A0=A0=A0 5.954376] musb_hdrc: version 6.0, tusb-omap-dma, peripheral,=
 debug=3D0
[=A0=A0=A0 5.955291] NET: Registered protocol family 2
[=A0=A0=A0 5.955566] IP route cache hash table entries: 1024 (order: 0,=
 4096 bytes)
[=A0=A0=A0 5.956024] TCP established hash table entries: 4096 (order: 3=
, 32768 bytes)
[=A0=A0=A0 5.956329] TCP bind hash table entries: 4096 (order: 2, 16384=
 bytes)
[=A0=A0=A0 5.956542] TCP: Hash tables configured (established 4096 bind=
 4096)
[=A0=A0=A0 5.956573] TCP reno registered
[=A0=A0=A0 5.956817] NET: Registered protocol family 1
[=A0=A0=A0 5.958831] NetWinder Floating Point Emulator V0.97 (double pr=
ecision)
[=A0=A0=A0 5.992065] JFFS2 version 2.2. (NAND) (SUMMARY)=A0 =A9 2001-20=
06 Red Hat, Inc.
[=A0=A0=A0 5.994750] msgmni has been set to 248
[=A0=A0=A0 5.994873] io scheduler noop registered
[=A0=A0=A0 5.995849] io scheduler cfq registered (default)
[=A0=A0=A0 6.035827] Serial: 8250/16550 driver, 4 ports, IRQ sharing di=
sabled
[=A0=A0=A0 6.059661] serial8250.0: ttyS0 at MMIO 0x4806a000 (irq =3D 72=
) is a ST16654
[=A0=A0=A0 6.080871] serial8250.1: ttyS1 at MMIO 0x4806c000 (irq =3D 73=
) is a ST16654
[=A0=A0=A0 6.102111] serial8250.2: ttyS2 at MMIO 0x4806e000 (irq =3D 74=
) is a ST16654
[=A0=A0=A0 6.420166] console [ttyS2] enabled
[=A0=A0=A0 6.446960] brd: module loaded
[=A0=A0=A0 6.450775] OneNAND driver initializing
[=A0=A0=A0 6.455047] omap2-onenand omap2-onenand: initializing on CS0, =
phys
base 0x04000000, virtual base c8880000
[=A0=A0=A0 6.464965] Muxed OneNAND 256MB 1.8V 16-bit (0x40)
[=A0=A0=A0 6.469787] OneNAND version =3D 0x0022
[=A0=A0=A0 6.475006] Scanning device for bad blocks
[=A0=A0=A0 6.489166] onenand_bbt_wait: ecc error =3D 0x2222, controller=
 error 0x2440
[=A0=A0=A0 6.496032] Bad eraseblock 183 at 0x016e0000
[=A0=A0=A0 6.570098] onenand_bbt_wait: ecc error =3D 0x2222, controller=
 error 0x2440
[=A0=A0=A0 6.576965] Bad eraseblock 1461 at 0x0b6a0000
[=A0=A0=A0 6.613372] Creating 5 MTD partitions on "omap2-onenand":
[=A0=A0=A0 6.618865] 0x000000000000-0x000000020000 : "bootloader"
[=A0=A0=A0 6.624938] 0x000000020000-0x000000080000 : "config"
[=A0=A0=A0 6.630554] 0x000000080000-0x000000280000 : "kernel"
[=A0=A0=A0 6.636260] 0x000000280000-0x000000680000 : "initfs"
[=A0=A0=A0 6.642028] 0x000000680000-0x000010000000 : "rootfs"
[=A0=A0=A0 6.650695] mice: PS/2 mouse device common for all mice
[=A0=A0=A0 6.656219] TCP cubic registered
[=A0=A0=A0 6.660308] VFP support v0.3: implementor 41 architecture 1 pa=
rt 20
variant b rev 2
[=A0=A0=A0 6.728607] Empty flash at 0x002384fc ends at 0x00238800
[=A0=A0=A0 6.740478] VFS: Mounted root (jffs2 filesystem) on device 31:=
3.
[=A0=A0=A0 6.746734] Freeing init memory: 104K
BusyBox v1.00 (2008.09.02-06:38+0000) multi-call binary

Usage: mknod [OPTIONS] NAME TYPE MAJOR MINOR

Create a special file (block, character, or pipe).

Options:
=A0=A0=A0=A0=A0=A0=A0 -m=A0=A0=A0=A0=A0 create the special file using t=
he specified mode (default a=3Drw)

TYPEs include:
=A0=A0=A0=A0=A0=A0=A0 b:=A0=A0=A0=A0=A0 Make a block (buffered) device.
=A0=A0=A0=A0=A0=A0=A0 c or u: Make a character (un-buffered) device.
=A0=A0=A0=A0=A0=A0=A0 p:=A0=A0=A0=A0=A0 Make a named pipe. MAJOR and MI=
NOR are ignored for named pipes.

BusyBox v1.00 (2008.09.02-06:38+0000) multi-call binary

Usage: mknod [OPTIONS] NAME TYPE MAJOR MINOR

Create a special file (block, character, or pipe).

Options:
=A0=A0=A0=A0=A0=A0=A0 -m=A0=A0=A0=A0=A0 create the special file using t=
he specified mode (default a=3Drw)

TYPEs include:
=A0=A0=A0=A0=A0=A0=A0 b:=A0=A0=A0=A0=A0 Make a block (buffered) device.
=A0=A0=A0=A0=A0=A0=A0 c or u: Make a character (un-buffered) device.
=A0=A0=A0=A0=A0=A0=A0 p:=A0=A0=A0=A0=A0 Make a named pipe. MAJOR and MI=
NOR are ignored for named pipes.

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
exiting...DSME: process '/usr/sbin/kicker' with pid 328 exited with
return value: 1
DSME: process '/usr/sbin/kicker' exited
=A0and restarted with pid 338
cal_read_block(r&d_mode): size zero, block not found?
Kicker: error reading R&D mode flags, both watchdogs enabledKicker:
Error initialising OMAP watchdogKicker: failed to init WDs,
exiting...DSME: process '/usr/sbin/kicker' with pid 1
DSME: process '/usr/sbin/kicker' exited
=A0and restarted with pid 350
Entering state 'MALF'.
Houston, we have a problem, powering off...
cal_read_block(r&d_mode): size zero, block not found?
Kicker: error reading R&D mode flags, both watchdogs enabled
The system is going down NOW !!
Sending SIGTERM to all processes.
Sending SIGKILL to all processes.
[=A0=A0=A0 9.813659] System halted.
grep: /proc/component_version: No such file or directory
Loading WLAN module...
[=A0=A0 10.018249] umac: version magic '2.6.21-omap1 mod_unload ARMv6 '
should be '2.6.32-rc6-06432-ge7e7a61 mod_unload ARMv6 '
insmod: cannot insert `/lib/modules/current/umac.ko': Invalid module
format (-1): Exec format error
[=A0=A0 10.062286] cx3110x: version magic '2.6.21-omap1 mod_unload ARMv=
6 '
should be '2.6.32-rc6-06432-ge7e7a61 mod_unload ARMv6 '
insmod: cannot insert `/lib/modules/current/cx3110x.ko': Invalid
module format (-1): Exec format error
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
(default values)Couldn't open /sys/devices/platform/wlan-omap/cal_pa_cu=
rve_data
[FAILED]
Pushing TX limits...Couldn't open
/sys/devices/platform/wlan-omap/cal_output_limits
[FAILED]
Pushing RX tuned values...Using default values Couldn't open
/sys/devices/platform/wlan-omap/cal_rssi
[FAILED]
real=A0=A0=A0 0m 1.62s
user=A0=A0=A0 0m 0.00s
sys=A0=A0=A0=A0 0m 1.64s
dsmesock_connect: Connection refused
dsmesock_connect
Entering state 'MALF'.
Houston, we have a problem, powering off...

The system is going down NOW !!
Sending SIGTERM to all processes.
Sending SIGKILL to all processes.
[=A0=A0 13.895050] ------------[ cut here ]------------
[=A0=A0 13.899749] WARNING: at lib/kobject.c:595 kobject_put+0x30/0x5c(=
)
[=A0=A0 13.905944] kobject:: is not initialized, yet kobject_put() is b=
eing called.
[=A0=A0 13.914886] Modules linked in:
[=A0=A0 13.918090] [<c0028930>] (unwind_backtrace+0x0/0xdc) from
[<c0046e3c>] (warn_slowpath_common+0x48/0x60)
[=A0=A0 13.927612] [<c0046e3c>] (warn_slowpath_common+0x48/0x60) from
[<c0046e8c>] (warn_slowpath_fmt+0x24/0x30)
[=A0=A0 13.937286] [<c0046e8c>] (warn_slowpath_fmt+0x24/0x30) from
[<c00fa034>] (kobject_put+0x30/0x5c)
[=A0=A0 13.946197] [<c00fa034>] (kobject_put+0x30/0x5c) from [<c0125e70=
>]
(device_shutdown+0x88/0x9c)
[=A0=A0 13.954956] [<c0125e70>] (device_shutdown+0x88/0x9c) from
[<c0054afc>] (kernel_halt+0xc/0x24)
[=A0=A0 13.963592] [<c0054afc>] (kernel_halt+0xc/0x24) from [<c0054c58>=
]
(sys_reboot+0xfc/0x1a8)
[=A0=A0 13.971862] [<c0054c58>] (sys_reboot+0xfc/0x1a8) from [<c0022e20=
>]
(ret_fast_syscall+0x0/0x2c)
[=A0=A0 13.980560] ---[ end trace 5961c93356cd0604 ]---
[=A0=A0 13.985229] ------------[ cut here ]------------
[=A0=A0 13.989898] WARNING: at lib/kobject.c:595 kobject_put+0x30/0x5c(=
)
[=A0=A0 13.996063] kobject:: is not initialized, yet kobject_put() is b=
eing called.
[=A0=A0 14.005004] Modules linked in:
[=A0=A0 14.008148] [<c0028930>] (unwind_backtrace+0x0/0xdc) from
[<c0046e3c>] (warn_slowpath_common+0x48/0x60)
[=A0=A0 14.017669] [<c0046e3c>] (warn_slowpath_common+0x48/0x60) from
[<c0046e8c>] (warn_slowpath_fmt+0x24/0x30)
[=A0=A0 14.027343] [<c0046e8c>] (warn_slowpath_fmt+0x24/0x30) from
[<c00fa034>] (kobject_put+0x30/0x5c)
[=A0=A0 14.036254] [<c00fa034>] (kobject_put+0x30/0x5c) from [<c0125e78=
>]
(device_shutdown+0x90/0x9c)
[=A0=A0 14.044982] [<c0125e78>] (device_shutdown+0x90/0x9c) from
[<c0054afc>] (kernel_halt+0xc/0x24)
[=A0=A0 14.053619] [<c0054afc>] (kernel_halt+0xc/0x24) from [<c0054c58>=
]
(sys_reboot+0xfc/0x1a8)
[=A0=A0 14.061889] [<c0054c58>] (sys_reboot+0xfc/0x1a8) from [<c0022e20=
>]
(ret_fast_syscall+0x0/0x2c)
[=A0=A0 14.070587] ---[ end trace 5961c93356cd0605 ]---
[=A0=A0 14.075256] System halted.
mount: Mounting /tmp on /mnt/new_root/tmp failed: No such file or direc=
tory
cat: can't open '/etc/osso_software_version': No such file or directory
Starting init
INIT: version 2.86 booting
Please wait: booting...
mount: mounting sysfs on /sys failed: Device or resource busy
Starting udev
[=A0=A0 15.750457] JFFS2 notice: (410) check_node_data: wrong data CRC =
in
data node at 0x0d213f24: read 0xa5cd5de3, calculated 0x88cfb26e.
Populating dev cache
Root filesystem already rw, not remounting
ALSA: Restoring mixer settings...
Setting up IP spoofing protection: rp_filter.
/usr/sbin/alsactl: load_state:1608: No soundcards found...
hwclock: can't open '/dev/misc/rtc': No such file or directory
Wed Nov 11 12:56:00 UTC 2009
hwclock: can't open '/dev/misc/rtc': No such file or directory
INIT: Entering runlevel: 5
Starting system message bus: dbus.
Starting Hardware abstraction layer hald
run-parts: /etc/dbus-1/event.d/20hal exited with code 1
Starting syslogd/klogd: done
Starting Xserver
Starting Bluetooth subsystem: bluetoothd.
fbset: can't open '/dev/fb0': No such file or directory
Starting Network connection manager daemon: NetworkManager.
--
--
=46rancisco Keppler Silva Alecrim
http://franciscoalecrim.com/
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

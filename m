From: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Subject: RE: TI-OMAP 2430 SDP McSPI problem
Date: Tue, 12 Dec 2006 00:03:31 -0600
Message-ID: <9C23CDD79DA20A479D4615857B2E2C4706D0DE@dlee13.ent.ti.com>
References: <dbf1574b0612062307l4e021859n94ceb5b86898112a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <dbf1574b0612062307l4e021859n94ceb5b86898112a@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: RobertChou <rbtchc@gmail.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

You are using 2.6.10 ?? Is it possible for you to switch over to 2.6.14?

Regards,
Khasim

-----Original Message-----
From: linux-omap-open-source-bounces@linux.omap.com
[mailto:linux-omap-open-source-bounces@linux.omap.com] On Behalf Of
RobertChou
Sent: Thursday, December 07, 2006 1:07 AM
To: linux-omap-open-source@linux.omap.com
Subject: TI-OMAP 2430 SDP McSPI problem

Dear all:

   While i'm trying to bootup my system, i found this error

   "MCSPI ERROR: attempt to write to free or non-existant spi:0:0"

    And then the following touchscreen TSC2046 initialization
failed,too.
    Once I touch the screen, it will results in kernel panic

    Also, i can't see anything on the screen besides noises....

    Would somebody please help me to figure out what the problem is..
    And i'll be very appreciated, thx :)

    I'm currently using Linux 2.6.10 as kernel and U-boot 1.1.3 as
bootloader.
    Toolchain: gcc3.3.4 w/ glibc 2.3.3

    The following is the whole error log
----

U-Boot 1.1.3 (Dec  4 2006 - 09:33:22)

U-Boot code: 80E80000 -> 80E9F948  BSS: -> 80EA51F4
OMAP2430C-GP revision 0, PRCM #5A
TI 2430SDP Base Board + 0.1 Version + mDDR
RAM Configuration:
Bank #0: 80000000 128 MB
Bank #1: 88000000  0 kB
Flash: 192 MB
NAND:64 MB
In:    serial
Out:   serial
Err:   serial
OMAP243X SDP # setenv bootargs mem=3D32M console=3DttyS0,115200n8 =
noinitrd
rootfstype=3Dnfs root=3D/dev/nfs rw
nfsroot=3D10.36.252.193:/home/h3usr/nfs,nolock
devfs=3Dmount ip=3D10.36.252.196
OMAP243X SDP # tftpboot 80000000 uImage_ti
Using MAC Address 08:00:28:01:03:18
TFTP from server 10.36.252.167; our IP address is 10.36.252.196
Filename 'uImage_ti'.
Load address: 0x80000000
Loading:
#################################################################
=20
#################################################################
=20
#################################################################
         #########################################################
done
Bytes transferred =3D 1288224 (13a820 hex)
OMAP243X SDP # bootm
## Booting image at 80000000 ...
   Image Name:   Linux-2.6.10-omap
   Image Type:   ARM Linux Kernel Image (uncompressed)
   Data Size:    1288160 Bytes =3D  1.2 MB
   Load Address: 80008000
   Entry Point:  80008000
   Verifying Checksum ... OK
OK

Starting kernel ...

Uncompressing
Linux...................................................................
...................
done, booting the kernel.
Linux version 2.6.10-omap (a0867901@dirac.dal.design.ti.com) (gcc
version
3.4.3 (MontaVista 3.4.3-25.0.78.0600240 2006-02-15)) #1 Wed May 24
00:43:03
CDT 2006
CPU: TI OMAP2430 (ARM1136JF-S) [4107b362] revision 2 (ARMv6TEJ)
CPU: D VIPT write-back cache
CPU: I cache: 32768 bytes, associativity 4, 32 byte lines, 256 sets
CPU: D cache: 32768 bytes, associativity 4, 32 byte lines, 256 sets
Machine: OMAP24xx 2430SDP
Memory policy: ECC disabled, Data cache writeback

--
Power Management for TI OMAP.
Clocking rate (xtal/DPLL/MPU): 13.0/532/266 MHz
clock.c: Enable for dpll_ck without enable code
Disabling unused clock "i2chs2_fck"... <6> done
Disabling unused clock "i2c2_ick"... <6> done
Disabling unused clock "i2chs1_fck"... <6> done
Disabling unused clock "i2c1_ick"... <6> done
Disabling unused clock "wdt1_ick"... <6> done
Disabling unused clock "mpu_wdt_fck"... <6> done
Disabling unused clock "mpu_wdt_ick"... <6> done
Disabling unused clock "gpios_fck"... <6> done
Disabling unused clock "gpios_ick"... <6> done
Disabling unused clock "gpt2_fck"... <6> done
Disabling unused clock "gpt2_ick"... <6> done
Disabling unused clock "mdm_osc_ck"... <6> done
--

Built 1 zonelists
Kernel command line: mem=3D32M console=3DttyS0,115200n8 noinitrd
rootfstype=3Dnfs
root=3D/dev/nfs rw nfsroot=3D10.36.252.193:/home/h3usr/nfs,nolock
devfs=3Dmount
ip=3D10.36.252.196
PID hash table entries: 256 (order: 8, 4096 bytes)

System clock 13MHz

Console: colour dummy device 80x30
Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
Memory: 32MB =3D 32MB total
Memory: 29584KB available (2210K code, 455K data, 124K init)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
NET: Registered protocol family 16
OMAP DMA4 hardware Initialized
OMAP DMA4 hardware Initialized (max lch=3D32)
OMAP GPIO hardware version 2.2
omap2_disp: timeout waiting for display controller reset
OMAP Display hardware version 1.0
TWL4030: Driver registration complete.
SCSI subsystem initialized
musb_hdrc: version 2.2a/db-0.4.8 [musb-dma] [peripheral] [debug=3D0]
musb_hdrc: USB Peripheral mode controller at c2800000 using DMA, IRQ 92
Checking V6 block cache operations:
           Prefetch data range: supported
   Clean+Invalidate data range: supported
              Clean data range: supported
         Invalidate data range: supported
        Invalidate instr range: supported
 --> Using harvard block cache invalidate
 --> Using block cache clean
 --> Using block cache clean+invalidate (cache aliasing)
OMAP virtual buses initialized
NetWinder Floating Point Emulator V0.97 (double precision)
devfs: 2004-01-31 Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
JFFS2 version 2.2. (NAND) (C) 2001-2003 Red Hat, Inc.
i2c /dev entries driver
TWL4030 Interrupt Subsystem active

omap24xxfb: Options "<NULL>"
Console: switching to colour frame buffer device 30x40
omap24xxfb: fb0 frame buffer device
omap24xxfb: display mode 240x320x16 hsync 20kHz vsync 61Hz
omap_wdt: TI OMAP Watchdog Timer: timer margin 10000 sec
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing
disabled
ttyS0 at MMIO 0x4806a000 (irq =3D 72) is a ST16654
ttyS1 at MMIO 0x4806c000 (irq =3D 73) is a ST16650V2
ttyS2 at MMIO 0x4806e000 (irq =3D 74) is a ST16654
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
loop: loaded (max 8 devices)
smc91x.c: v1.1, sep 22 2004 by Nicolas Pitre <nico@cam.org>
eth0: SMC91C94 (rev 9) at 0xc2864300 IRQ 245 [nowait]
eth0: Ethernet addr: 08:00:28:01:03:18
 OMAP Timer32K is initialized
omap-twl4030rtc:TWL4030-RTC Power up reset detected.
omap-twl4030rtc:Enabling TWL4030-RTC.
Linux video capture interface: v1.00
EX3691:Failed to detect EX3691 SOC.
omap24xxcam: cannot initialize sensor
omap24xxvout: registered device video1 [v4l2]
omap24xxvout: registered device video2 [v4l2]
elevator: using anticipatory as default io scheduler
sibley0: Found 1 x16 devices at 0x0 in 16-bit bank
sibley0: Found 1 x16 devices at 0x4000000 in 16-bit bank
 Intel/Sharp Extended Query Table at 0x010A
 Intel/Sharp Extended Query Table at 0x010A
 Intel/Sharp Extended Query Table at 0x010A
 Intel/Sharp Extended Query Table at 0x010A
Using buffer write method
cfi_cmdset_0001: Erase suspend on write enabled
MTD partition
Creating 4 MTD partitions on "sibley0":
0x00000000-0x00040000 : "bootloader"
0x00040000-0x00080000 : "params"
0x00080000-0x00280000 : "kernel"
0x00280000-0x08000000 : "filesystem"
NAND: on CS 1
NAND device: Manufacturer ID: 0xec, Chip ID: 0x46 (Samsung NAND 64MiB
1,8V
16-bit)
Scanning device for bad blocks
Bad eraseblock 0 at 0x00000000
Bad eraseblock 1 at 0x00004000
Bad eraseblock 2 at 0x00008000
Bad eraseblock 3 at 0x0000c000
Bad eraseblock 4 at 0x00010000
Bad eraseblock 5 at 0x00014000
Bad eraseblock 6 at 0x00018000
Bad eraseblock 7 at 0x0001c000
Bad eraseblock 8 at 0x00020000
Bad eraseblock 9 at 0x00024000
Bad eraseblock 10 at 0x00028000
Bad eraseblock 11 at 0x0002c000
Bad eraseblock 12 at 0x00030000
Bad eraseblock 13 at 0x00034000
Bad eraseblock 14 at 0x00038000
Bad eraseblock 15 at 0x0003c000
Bad eraseblock 16 at 0x00040000
Bad eraseblock 17 at 0x00044000
Bad eraseblock 18 at 0x00048000
Bad eraseblock 19 at 0x0004c000
Bad eraseblock 20 at 0x00050000
Bad eraseblock 21 at 0x00054000
Bad eraseblock 22 at 0x00058000
Bad eraseblock 23 at 0x0005c000
Bad eraseblock 24 at 0x00060000
Bad eraseblock 25 at 0x00064000
Bad eraseblock 26 at 0x00068000
Bad eraseblock 27 at 0x0006c000
Bad eraseblock 28 at 0x00070000
Bad eraseblock 29 at 0x00074000
Bad eraseblock 30 at 0x00078000
Bad eraseblock 31 at 0x0007c000
Bad eraseblock 32 at 0x00080000
Bad eraseblock 33 at 0x00084000
Bad eraseblock 34 at 0x00088000
Bad eraseblock 766 at 0x00bf8000
Bad eraseblock 3796 at 0x03b50000
Creating 5 MTD partitions on "NAND 64MiB 1,8V 16-bit":
0x00000000-0x00040000 : "Booting Image"
0x00040000-0x00080000 : "U-Boot"
0x00080000-0x000b0000 : "U-Boot Environment"
0x000b0000-0x002b0000 : "Kernel"
0x002b0000-0x04000000 : "File System"
oneNAND: Unable to find oneNAND configuration in GPMC - quitting
mice: PS/2 mouse device common for all mice
MCSPI ERROR: attempt to write to free or non-existant spi:0:0
TSC2046 write failed for command :32768[8000]Registering OMAP device
'omap2430-mmc2'. Parent at L3
OMAP243X TWL4030 Audio Support: Chip Rev[0x2f] Initialized
NET: Registered protocol family 2
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 2048 bind 4096)
NET: Registered protocol family 1
NET: Registered protocol family 17
VFP support v0.3: implementor 41 architecture 1 part 20 variant b rev 2
eth0: link up
IP-Config: Guessing netmask 255.0.0.0
IP-Config: Complete:
      device=3Deth0, addr=3D10.36.252.196, mask=3D255.0.0.0,
gw=3D255.255.255.255,
     host=3D10.36.252.196, domain=3D, nis-domain=3D(none),
     bootserver=3D255.255.255.255, rootserver=3D10.36.252.193, =
rootpath=3D
Looking up port of RPC 100003/2 on 10.36.252.193
Looking up port of RPC 100005/1 on 10.36.252.193
VFS: Mounted root (nfs filesystem).
Mounted devfs on /dev
Freeing init memory: 124K
init started:  BusyBox v1.00-pre8 (2004.03.05-22:18+0000) multi-call
binary

******************************************
Starting System Init for innovator
******************************************

Please press Enter to activate this console. MCSPI ERROR: attempt to
write
to free or non-existant spi:0:0
TSC2046 write failed for command :32768[8000]<3>MCSPI ERROR: TIMEDOUT!!
Unable to recieve RXS_FULL for ch 0 proceeding anyway
MCSPI ERROR: MCSPI_CHSTAT_RXS_FULL =3D 1
MCSPI ERROR: bus 0 reg contents 0 <----
MCSPI ERROR: SPI1:0 syst: 0
MCSPI ERROR: SPI2:0 syst: 0
TSC2046 read failed for channel : 0[0]<1>Unable to handle kernel NULL
pointer dereference at virtual address 00000000
pgd =3D c0004000
[00000000] *pgd=3D00000000
Internal error: Oops: 807 [#1]
Modules linked in:
CPU: 0
PC is at preempt_return+0xc/0x20
LR is at __do_softirq+0x54/0xc8
pc : [<c00275c0>]    lr : [<c0053da8>]    Not tainted
sp : c0251f6c  ip : c0251f14  fp : c0251fc0
r10: 00c0387d  r9 : 00000001  r8 : c0250000
r7 : 00000002  r6 : c00293b0  r5 : d80fe000  r4 : c0251fa0
r3 : 00000004  r2 : c02aa1c8  r1 : 00000000  r0 : 00000004
Flags: nzCv  IRQs off  FIQs on  Mode SVC_32  Segment kernel
Control: C5387F  Table: 81DBC000  DAC: 0000001D
Process swapper (pid: 0, stack limit =3D 0xc0250194)
Stack: (0xc0251f6c to 0xc0252000)
1f60:                            67de1041 60000093 00000001 00000000
c0250000
1f80: c0029378 c02ab350 c02a1acc c0252fb8 4107b362 00c0387d c0251fc0
c0251fc4
1fa0: c0251fb4 c00293b0 c00293b4 60000013 ffffffff c0251fd8 c0251fc4
c0029404
1fc0: c0029384 c02c1e84 c029e41c c0251ffc c0251fdc c0008760 c00293c8
c00082a0
1fe0: c02a1b0c c02c1e84 c02c1e84 c02a1afc 00000000 c0252000 c0008080
c0008600
Backtrace:
[<c0029378>] (default_idle+0x0/0x44) from [<c0029404>]
(cpu_idle+0x48/0x80)
[<c00293bc>] (cpu_idle+0x0/0x80) from [<c0008760>]
(start_kernel+0x16c/0x1b0)
 r5 =3D C029E41C  r4 =3D C02C1E84
[<c00085f4>] (start_kernel+0x0/0x1b0) from [<c0008080>]
(__mmap_switched+0x0/0x40)
Code: 1b000007 e5980004 e1300007 e5889004 (17000000)
 <0>Kernel panic - not syncing: Attempted to kill the idle task!
 <3>MCSPI ERROR: attempt to write to free or non-existant spi:0:0
TSC2046 write failed for command :32768[8000]<3>MCSPI ERROR: TIMEDOUT!!
Unable to recieve RXS_FULL for ch 0 proceeding anyway
MCSPI ERROR: MCSPI_CHSTAT_RXS_FULL =3D 1
MCSPI ERROR: bus 0 reg contents 0 <----
MCSPI ERROR: SPI1:0 syst: 0
MCSPI ERROR: SPI2:0 syst: 0
TSC2046 read failed for channel : 0[0]<1>Unable to handle kernel NULL
pointer dereference at virtual address 00000000
pgd =3D c0004000
[00000000] *pgd=3D00000000
Internal error: Oops: 807 [#2]
Modules linked in:
CPU: 0
PC is at preempt_return+0xc/0x20
LR is at preempt_return+0x0/0x20
pc : [<c00275c0>]    lr : [<c00275b4>]    Not tainted
sp : c0251e0c  ip : c0251d8c  fp : c0251e60
r10: 0000000b  r9 : 00000001  r8 : c0250000
r7 : 00000002  r6 : c004eb10  r5 : d80fe000  r4 : c0251e40
r3 : 00000004  r2 : c02aa1c8  r1 : 00000004  r0 : 00000004
Flags: nzCv  IRQs off  FIQs on  Mode SVC_32  Segment kernel
Control: C5387F  Table: 81DBC000  DAC: 0000001D
Process swapper (pid: 0, stack limit =3D 0xc0250194)
Stack: (0xc0251e0c to 0xc0252000)
1e00:                            000031bf 00000000 000001b0 00000000
0000111e
1e20: c02a3dcc c02a3dc0 c0251f6c ffffffff c0251f24 0000000b c0251e60
c0251e54
1e40: c0251e54 c004eb10 c01144cc 20000113 ffffffff c0251e90 c0251e74
c0050fa4
1e60: c004ea2c c02207a0 00000000 00000001 00000000 c02520c0 c0251ea4
00000000
1e80: c0251e94 c0251ea4 c0251e94 c002cc80 c0050f58 00000000 c0251ec4
c0251ea8
1ea0: c002e1ec c002ca20 00000807 c0251f58 c02520c0 00000000 c0251efc
c0251ec8
1ec0: c002e580 c002e18c c0251f6c c0251ef4 c0251f24 00000807 c0251f58
00000000
1ee0: c02533e0 c0251f24 20000193 00c0387d c0251f20 c0251f00 c002e6e0
c002e304
1f00: ffffffff c0251f58 c00293b0 00000002 c0250000 c0251fc0 c0251f24
c002751c
1f20: c002e6b0 00000004 00000000 c02aa1c8 00000004 c0251fa0 d80fe000
c00293b0
1f40: 00000002 c0250000 00000001 00c0387d c0251fc0 c0251f14 c0251f6c
c0053da8
1f60: c00275c0 20000193 ffffffff 67de1041 60000093 00000001 00000000
c0250000
1f80: c0029378 c02ab350 c02a1acc c0252fb8 4107b362 00c0387d c0251fc0
c0251fc4
1fa0: c0251fb4 c00293b0 c00293b4 60000013 ffffffff c0251fd8 c0251fc4
c0029404
1fc0: c0029384 c02c1e84 c029e41c c0251ffc c0251fdc c0008760 c00293c8
c00082a0
1fe0: c02a1b0c c02c1e84 c02c1e84 c02a1afc 00000000 c0252000 c0008080
c0008600
Backtrace:
[<c004ea1c>] (panic+0x0/0x11c) from [<c0050fa4>] (do_exit+0x58/0xd98)
 r3 =3D 00000000  r2 =3D 00000001  r1 =3D 00000000  r0 =3D C02207A0
[<c0050f4c>] (do_exit+0x0/0xd98) from [<c002cc80>] (die+0x26c/0x2ac)
[<c002ca14>] (die+0x0/0x2ac) from [<c002e1ec>]
(__do_kernel_fault+0x6c/0x7c)
[<c002e180>] (__do_kernel_fault+0x0/0x7c) from [<c002e580>]
(do_page_fault+0x288/0x2ac)
 r7 =3D 00000000  r6 =3D C02520C0  r5 =3D C0251F58  r4 =3D 00000807
[<c002e2f8>] (do_page_fault+0x0/0x2ac) from [<c002e6e0>]
(do_DataAbort+0x3c/0xa0)
[<c002e6a4>] (do_DataAbort+0x0/0xa0) from [<c002751c>]
(__dabt_svc+0x3c/0x60)
 r8 =3D C0250000  r7 =3D 00000002  r6 =3D C00293B0  r5 =3D C0251F58
 r4 =3D FFFFFFFF
[<c0029378>] (default_idle+0x0/0x44) from [<c0029404>]
(cpu_idle+0x48/0x80)
[<c00293bc>] (cpu_idle+0x0/0x80) from [<c0008760>]
(start_kernel+0x16c/0x1b0)
 r5 =3D C029E41C  r4 =3D C02C1E84
[<c00085f4>] (start_kernel+0x0/0x1b0) from [<c0008080>]
(__mmap_switched+0x0/0x40)
Code: 1b000007 e5980004 e1300007 e5889004 (17000000)
 <0>Kernel panic - not syncing: Attempted to kill the idle task!
 <3>MCSPI ERROR: attempt to write to free or non-existant spi:0:0
TSC2046 write failed for command :32768[8000]<3>MCSPI ERROR: TIMEDOUT!!
Unable to recieve RXS_FULL for ch 0 proceeding anyway
MCSPI ERROR: MCSPI_CHSTAT_RXS_FULL =3D 1
MCSPI ERROR: bus 0 reg contents 0 <----
MCSPI ERROR: SPI1:0 syst: 0
MCSPI ERROR: SPI2:0 syst: 0
TSC2046 read failed for channel : 0[0]<1>Unable to handle kernel NULL
pointer dereference at virtual address 00000000
pgd =3D c0004000
[00000000] *pgd=3D00000000
Internal error: Oops: 807 [#3]
Modules linked in:
CPU: 0
PC is at preempt_return+0xc/0x20
LR is at preempt_return+0x0/0x20
pc : [<c00275c0>]    lr : [<c00275b4>]    Not tainted
sp : c0251cac  ip : c0251c2c  fp : c0251d00
r10: 0000000b  r9 : 00000001  r8 : c0250000
r7 : 00000002  r6 : c004eb10  r5 : d80fe000  r4 : c0251ce0
r3 : 00000004  r2 : c02aa1c8  r1 : 00000004  r0 : 00000004
Flags: nzCv  IRQs off  FIQs on  Mode SVC_32  Segment kernel
Control: C5387F  Table: 81DBC000  DAC: 0000001D
Process swapper (pid: 0, stack limit =3D 0xc0250194)
Stack: (0xc0251cac to 0xc0252000)
1ca0:                            0000ee88 00000000 000001b0 00000000
00000145
1cc0: c02a3dcc c02a3dc0 c0251e0c ffffffff c0251dc4 0000000b c0251d00
c0251cf4
1ce0: c0251cf4 c004eb10 c01144cc 20000113 ffffffff c0251d30 c0251d14
c0050fa4
1d00: c004ea2c c02207a0 00000004 00000001 00000000 c02520c0 c0251d44
c0251ca8
1d20: c0251e60 c0251d44 c0251d34 c002cc80 c0050f58 00000000 c0251d64
c0251d48
1d40: c002e1ec c002ca20 00000807 c0251df8 c02520c0 00000000 c0251d9c
c0251d68
1d60: c002e580 c002e18c c0251e0c c0251d94 c0251dc4 00000807 c0251df8
00000000
1d80: c02533e0 c0251dc4 20000193 0000000b c0251dc0 c0251da0 c002e6e0
c002e304
1da0: ffffffff c0251df8 c004eb10 00000002 c0250000 c0251e60 c0251dc4
c002751c
1dc0: c002e6b0 00000004 00000004 c02aa1c8 00000004 c0251e40 d80fe000
c004eb10
1de0: 00000002 c0250000 00000001 0000000b c0251e60 c0251d8c c0251e0c
c00275b4
1e00: c00275c0 20000193 ffffffff 000031bf 00000000 000001b0 00000000
0000111e
1e20: c02a3dcc c02a3dc0 c0251f6c ffffffff c0251f24 0000000b c0251e60
c0251e54
1e40: c0251e54 c004eb10 c01144cc 20000113 ffffffff c0251e90 c0251e74
c0050fa4
1e60: c004ea2c c02207a0 00000000 00000001 00000000 c02520c0 c0251ea4
00000000
1e80: c0251e94 c0251ea4 c0251e94 c002cc80 c0050f58 00000000 c0251ec4
c0251ea8
1ea0: c002e1ec c002ca20 00000807 c0251f58 c02520c0 00000000 c0251efc
c0251ec8
1ec0: c002e580 c002e18c c0251f6c c0251ef4 c0251f24 00000807 c0251f58
00000000
1ee0: c02533e0 c0251f24 20000193 00c0387d c0251f20 c0251f00 c002e6e0
c002e304
1f00: ffffffff c0251f58 c00293b0 00000002 c0250000 c0251fc0 c0251f24
c002751c
1f20: c002e6b0 00000004 00000000 c02aa1c8 00000004 c0251fa0 d80fe000
c00293b0
1f40: 00000002 c0250000 00000001 00c0387d c0251fc0 c0251f14 c0251f6c
c0053da8
1f60: c00275c0 20000193 ffffffff 67de1041 60000093 00000001 00000000
c0250000
1f80: c0029378 c02ab350 c02a1acc c0252fb8 4107b362 00c0387d c0251fc0
c0251fc4
1fa0: c0251fb4 c00293b0 c00293b4 60000013 ffffffff c0251fd8 c0251fc4
c0029404
1fc0: c0029384 c02c1e84 c029e41c c0251ffc c0251fdc c0008760 c00293c8
c00082a0
1fe0: c02a1b0c c02c1e84 c02c1e84 c02a1afc 00000000 c0252000 c0008080
c0008600
Backtrace:
[<c004ea1c>] (panic+0x0/0x11c) from [<c0050fa4>] (do_exit+0x58/0xd98)
 r3 =3D 00000000  r2 =3D 00000001  r1 =3D 00000004  r0 =3D C02207A0
[<c0050f4c>] (do_exit+0x0/0xd98) from [<c002cc80>] (die+0x26c/0x2ac)
[<c002ca14>] (die+0x0/0x2ac) from [<c002e1ec>]
(__do_kernel_fault+0x6c/0x7c)
[<c002e180>] (__do_kernel_fault+0x0/0x7c) from [<c002e580>]
(do_page_fault+0x288/0x2ac)
 r7 =3D 00000000  r6 =3D C02520C0  r5 =3D C0251DF8  r4 =3D 00000807
[<c002e2f8>] (do_page_fault+0x0/0x2ac) from [<c002e6e0>]
(do_DataAbort+0x3c/0xa0)
[<c002e6a4>] (do_DataAbort+0x0/0xa0) from [<c002751c>]
(__dabt_svc+0x3c/0x60)
 r8 =3D C0250000  r7 =3D 00000002  r6 =3D C004EB10  r5 =3D C0251DF8
 r4 =3D FFFFFFFF
[<c004ea1c>] (panic+0x0/0x11c) from [<c0050fa4>] (do_exit+0x58/0xd98)
 r3 =3D 00000000  r2 =3D 00000001  r1 =3D 00000000  r0 =3D C02207A0
[<c0050f4c>] (do_exit+0x0/0xd98) from [<c002cc80>] (die+0x26c/0x2ac)
[<c002ca14>] (die+0x0/0x2ac) from [<c002e1ec>]
(__do_kernel_fault+0x6c/0x7c)
[<c002e180>] (__do_kernel_fault+0x0/0x7c) from [<c002e580>]
(do_page_fault+0x288/0x2ac)
 r7 =3D 00000000  r6 =3D C02520C0  r5 =3D C0251F58  r4 =3D 00000807
[<c002e2f8>] (do_page_fault+0x0/0x2ac) from [<c002e6e0>]
(do_DataAbort+0x3c/0xa0)
[<c002e6a4>] (do_DataAbort+0x0/0xa0) from [<c002751c>]
(__dabt_svc+0x3c/0x60)
 r8 =3D C0250000  r7 =3D 00000002  r6 =3D C00293B0  r5 =3D C0251F58
 r4 =3D FFFFFFFF
[<c0029378>] (default_idle+0x0/0x44) from [<c0029404>]
(cpu_idle+0x48/0x80)
[<c00293bc>] (cpu_idle+0x0/0x80) from [<c0008760>]
(start_kernel+0x16c/0x1b0)
 r5 =3D C029E41C  r4 =3D C02C1E84
[<c00085f4>] (start_kernel+0x0/0x1b0) from [<c0008080>]
(__mmap_switched+0x0/0x40)
Code: 1b000007 e5980004 e1300007 e5889004 (17000000)
 <0>Kernel panic - not syncing: Attempted to kill the idle task!
 <3>MCSPI ERROR: attempt to write to free or non-existant spi:0:0
TSC2046 write failed for command :32768[8000]<3>MCSPI ERROR: TIMEDOUT!!
Unable to recieve RXS_FULL for ch 0 proceeding anyway
MCSPI ERROR: MCSPI_CHSTAT_RXS_FULL =3D 1
MCSPI ERROR: bus 0 reg contents 0 <----
MCSPI ERROR: SPI1:0 syst: 0
MCSPI ERROR: SPI2:0 syst: 0
TSC2046 read failed for channel : 0[0]<1>Unable to handle kernel NULL
pointer dereference at virtual address 00000000
pgd =3D c0004000
[00000000] *pgd=3D00000000
Internal error: Oops: 807 [#4]
Modules linked in:
CPU: 0
PC is at preempt_return+0xc/0x20
LR is at preempt_return+0x0/0x20
pc : [<c00275c0>]    lr : [<c00275b4>]    Not tainted
sp : c0251b4c  ip : c0251ad8  fp : c0251ba0
r10: 0000000b  r9 : 00000001  r8 : c0250000
r7 : 00000002  r6 : c004eb10  r5 : d80fe000  r4 : c0251b80
r3 : 00000004  r2 : c02aa1c8  r1 : ffff9b7a  r0 : 00000004
Flags: nzCv  IRQs off  FIQs on  Mode SVC_32  Segment kernel
Control: C5387F  Table: 81DBC000  DAC: 0000001D
Process swapper (pid: 0, stack limit =3D 0xc0250194)
Stack: (0xc0251b4c to 0xc0252000)
1b40:                            00005190 00000000 000001b0 00000000
0000069a
1b60: c02a3dcc c02a3dc0 c0251cac ffffffff c0251c64 0000000b c0251ba0
c0251b94
1b80: c0251b94 c004eb10 c01144cc 20000113 ffffffff c0251bd0 c0251bb4
c0050fa4
1ba0: c004ea2c c02207a0 00000004 00000001 00000000 c02520c0 c0251be4
c0251b48
1bc0: c0251d00 c0251be4 c0251bd4 c002cc80 c0050f58 00000000 c0251c04
c0251be8
1be0: c002e1ec c002ca20 00000807 c0251c98 c02520c0 00000000 c0251c3c
c0251c08
1c00: c002e580 c002e18c c0251cac c0251c34 c0251c64 00000807 c0251c98
00000000
1c20: c02533e0 c0251c64 20000193 0000000b c0251c60 c0251c40 c002e6e0
c002e304
1c40: ffffffff c0251c98 c004eb10 00000002 c0250000 c0251d00 c0251c64
c002751c
1c60: c002e6b0 00000004 00000004 c02aa1c8 00000004 c0251ce0 d80fe000
c004eb10
1c80: 00000002 c0250000 00000001 0000000b c0251d00 c0251c2c c0251cac
c00275b4
1ca0: c00275c0 20000193 ffffffff 0000ee88 00000000 000001b0 00000000
00000145
1cc0: c02a3dcc c02a3dc0 c0251e0c ffffffff c0251dc4 0000000b c0251d00
c0251cf4
1ce0: c0251cf4 c004eb10 c01144cc 20000113 ffffffff c0251d30 c0251d14
c0050fa4
1d00: c004ea2c c02207a0 00000004 00000001 00000000 c02520c0 c0251d44
c0251ca8
1d20: c0251e60 c0251d44 c0251d34 c002cc80 c0050f58 00000000 c0251d64
c0251d48
1d40: c002e1ec c002ca20 00000807 c0251df8 c02520c0 00000000 c0251d9c
c0251d68
1d60: c002e580 c002e18c c0251e0c c0251d94 c0251dc4 00000807 c0251df8
00000000
1d80: c02533e0 c0251dc4 20000193 0000000b c0251dc0 c0251da0 c002e6e0
c002e304
1da0: ffffffff c0251df8 c004eb10 00000002 c0250000 c0251e60 c0251dc4
c002751c
1dc0: c002e6b0 00000004 00000004 c02aa1c8 00000004 c0251e40 d80fe000
c004eb10
1de0: 00000002 c0250000 00000001 0000000b c0251e60 c0251d8c c0251e0c
c00275b4
1e00: c00275c0 20000193 ffffffff 000031bf 00000000 000001b0 00000000
0000111e
1e20: c02a3dcc c02a3dc0 c0251f6c ffffffff c0251f24 0000000b c0251e60
c0251e54
1e40: c0251e54 c004eb10 c01144cc 20000113 ffffffff c0251e90 c0251e74
c0050fa4
1e60: c004ea2c c02207a0 00000000 00000001 00000000 c02520c0 c0251ea4
00000000
1e80: c0251e94 c0251ea4 c0251e94 c002cc80 c0050f58 00000000 c0251ec4
c0251ea8
1ea0: c002e1ec c002ca20 00000807 c0251f58 c02520c0 00000000 c0251efc
c0251ec8
1ec0: c002e580 c002e18c c0251f6c c0251ef4 c0251f24 00000807 c0251f58
00000000
1ee0: c02533e0 c0251f24 20000193 00c0387d c0251f20 c0251f00 c002e6e0
c002e304
1f00: ffffffff c0251f58 c00293b0 00000002 c0250000 c0251fc0 c0251f24
c002751c
1f20: c002e6b0 00000004 00000000 c02aa1c8 00000004 c0251fa0 d80fe000
c00293b0
1f40: 00000002 c0250000 00000001 00c0387d c0251fc0 c0251f14 c0251f6c
c0053da8
1f60: c00275c0 20000193 ffffffff 67de1041 60000093 00000001 00000000
c0250000
1f80: c0029378 c02ab350 c02a1acc c0252fb8 4107b362 00c0387d c0251fc0
c0251fc4
1fa0: c0251fb4 c00293b0 c00293b4 60000013 ffffffff c0251fd8 c0251fc4
c0029404
1fc0: c0029384 c02c1e84 c029e41c c0251ffc c0251fdc c0008760 c00293c8
c00082a0
1fe0: c02a1b0c c02c1e84 c02c1e84 c02a1afc 00000000 c0252000 c0008080
c0008600
Backtrace:
[<c004ea1c>] (panic+0x0/0x11c) from [<c0050fa4>] (do_exit+0x58/0xd98)
 r3 =3D 00000000  r2 =3D 00000001  r1 =3D 00000004  r0 =3D C02207A0
[<c0050f4c>] (do_exit+0x0/0xd98) from [<c002cc80>] (die+0x26c/0x2ac)
[<c002ca14>] (die+0x0/0x2ac) from [<c002e1ec>]
(__do_kernel_fault+0x6c/0x7c)
[<c002e180>] (__do_kernel_fault+0x0/0x7c) from [<c002e580>]
(do_page_fault+0x288/0x2ac)
 r7 =3D 00000000  r6 =3D C02520C0  r5 =3D C0251C98  r4 =3D 00000807
[<c002e2f8>] (do_page_fault+0x0/0x2ac) from [<c002e6e0>]
(do_DataAbort+0x3c/0xa0)
[<c002e6a4>] (do_DataAbort+0x0/0xa0) from [<c002751c>]
(__dabt_svc+0x3c/0x60)
 r8 =3D C0250000  r7 =3D 00000002  r6 =3D C004EB10  r5 =3D C0251C98
 r4 =3D FFFFFFFF
[<c004ea1c>] (panic+0x0/0x11c) from [<c0050fa4>] (do_exit+0x58/0xd98)
 r3 =3D 00000000  r2 =3D 00000001  r1 =3D 00000004  r0 =3D C02207A0
[<c0050f4c>] (do_exit+0x0/0xd98) from [<c002cc80>] (die+0x26c/0x2ac)
[<c002ca14>] (die+0x0/0x2ac) from [<c002e1ec>]
(__do_kernel_fault+0x6c/0x7c)
[<c002e180>] (__do_kernel_fault+0x0/0x7c) from [<c002e580>]
(do_page_fault+0x288/0x2ac)
 r7 =3D 00000000  r6 =3D C02520C0  r5 =3D C0251DF8  r4 =3D 00000807
[<c002e2f8>] (do_page_fault+0x0/0x2ac) from [<c002e6e0>]
(do_DataAbort+0x3c/0xa0)
[<c002e6a4>] (do_DataAbort+0x0/0xa0) from [<c002751c>]
(__dabt_svc+0x3c/0x60)
 r8 =3D C0250000  r7 =3D 00000002  r6 =3D C004EB10  r5 =3D C0251DF8
 r4 =3D FFFFFFFF
[<c004ea1c>] (panic+0x0/0x11c) from [<c0050fa4>] (do_exit+0x58/0xd98)
 r3 =3D 00000000  r2 =3D 00000001  r1 =3D 00000000  r0 =3D C02207A0
[<c0050f4c>] (do_exit+0x0/0xd98) from [<c002cc80>] (die+0x26c/0x2ac)
[<c002ca14>] (die+0x0/0x2ac) from [<c002e1ec>]
(__do_kernel_fault+0x6c/0x7c)
[<c002e180>] (__do_kernel_fault+0x0/0x7c) from [<c002e580>]
(do_page_fault+0x288/0x2ac)
 r7 =3D 00000000  r6 =3D C02520C0  r5 =3D C0251F58  r4 =3D 00000807
[<c002e2f8>] (do_page_fault+0x0/0x2ac) from [<c002e6e0>]
(do_DataAbort+0x3c/0xa0)
[<c002e6a4>] (do_DataAbort+0x0/0xa0) from [<c002751c>]
(__dabt_svc+0x3c/0x60)
 r8 =3D C0250000  r7 =3D 00000002  r6 =3D C00293B0  r5 =3D C0251F58
 r4 =3D FFFFFFFF
[<c0029378>] (default_idle+0x0/0x44) from [<c0029404>]
(cpu_idle+0x48/0x80)
[<c00293bc>] (cpu_idle+0x0/0x80) from [<c0008760>]
(start_kernel+0x16c/0x1b0)
 r5 =3D C029E41C  r4 =3D C02C1E84
[<c00085f4>] (start_kernel+0x0/0x1b0) from [<c0008080>]
(__mmap_switched+0x0/0x40)
Code: 1b000007 e5980004 e1300007 e5889004 (17000000)
 <0>Kernel panic - not syncing: Attempted to kill the idle task!
_______________________________________________
Linux-omap-open-source mailing list
Linux-omap-open-source@linux.omap.com
http://linux.omap.com/mailman/listinfo/linux-omap-open-source

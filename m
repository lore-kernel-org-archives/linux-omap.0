From: "Carl Benson" <Carl.Benson@combra.se>
Subject: Unhandled fault: external abort
Date: Tue, 20 Nov 2007 16:37:24 +0100
Message-ID: <D0D7E940253EF8428A27241F8E3CABA3A88DFA@zeus.Combra.se>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi. Trying to boot latest OMAP kernel from GIT tree (as of 2007-11-20) =
on an 3430 SDP ES1.0 board and get an "Unhandled fault: external abort =
on non-linefetch" and "Internal error 1028".=20

PC is at serial_in+0x6c/0xac which in my kernel suggest the error =
occuring from executing line 366 from drivers/serial/8250.c:

static unsigned int serial_in(struct uart_8250_port *up, int offset)
    355 {
    356         unsigned int tmp;
    357         offset =3D map_8250_in_reg(up, offset) << =
up->port.regshift;
    358
    359         switch (up->port.iotype) {
    360         case UPIO_HUB6:
    361                 outb(up->port.hub6 - 1 + offset, =
up->port.iobase);
    362                 return inb(up->port.iobase + 1);
    363
    364         case UPIO_MEM:
    365         case UPIO_DWAPB:
>>> 366                 return readb(up->port.membase + offset);
    367
    368         case UPIO_RM9000:

Disassembly of vmlinux with serial_in at c017d304 + 06c =3D c017d370

        case UPIO_MEM:
        case UPIO_DWAPB:
                return readb(up->port.membase + offset);
c017d36c:       e5903004        ldr     r3, [r0, #4]
c017d370:       e7d33001        ldrb    r3, [r3, r1]
c017d374:       ea000007        b       c017d398 <serial_in+0x94>

I have no clue to why this happens.
Any help greatly appreciated!

Regards,
Carl Benson

kernel dump below:
U-Boot 1.1.4 (Nov 20 2007 - 15:41:02)

OMAP3430-GP rev 1, CPU-OPP2 L3-165MHz
TI 3430SDP 1.0 Version + mDDR (Boot NOR)
DRAM:  128 MB
Flash: 64 MB
NAND:128 MiB
Muxed OneNAND 128MB 1.8V 16-bit (0x30)
Scanning device for bad blocks
num of blocks =3D 2048
In:    serial
Out:   serial
Err:   serial
OMAP34XX SDP # d

*** Warning: ethaddr is not set properly, ignoring!!
Using MAC Address 08:00:28:01:19:03
BOOTP broadcast 1
DHCP client bound to address 192.168.0.39
TFTP from server 192.168.0.1; our IP address is 192.168.0.39
Filename 'uImage'.
Load address: 0x80000000
Loading: =
#################################################################
         =
#################################################################
         =
#################################################################
         =
#################################################################
         ##############################
done
Bytes transferred =3D 1483676 (16a39c hex)
OMAP34XX SDP # bootm
## Booting image at 80000000 ...
   Image Name:   Linux-2.6.23-omap1
   Image Type:   ARM Linux Kernel Image (uncompressed)
   Data Size:    1483612 Bytes =3D  1.4 MB
   Load Address: 80008000
   Entry Point:  80008000
   Verifying Checksum ... Header address: 80eabab4OK
OK

Starting kernel ...

Uncompressing =
Linux....................................................................=
............................. done, booting the kernel.
<5>Linux version 2.6.23-omap1 (carlb@tesla) (gcc version 4.2.1) #7 Tue =
Nov 20 16:12:10 CET 2007
CPU: ARMv7 Processor [410fc080] revision 0 (ARMv7), cr=3D00c5387f
Machine: OMAP3430 3430SDP board
Memory policy: ECC disabled, Data cache writeback
<7>On node 0 totalpages: 16384
<7>  DMA zone: 128 pages used for memmap
<7>  DMA zone: 0 pages reserved
<7>  DMA zone: 16256 pages, LIFO batch:3
<7>  Normal zone: 0 pages used for memmap
<7>  Movable zone: 0 pages used for memmap
<6>OMAP3430ES0
<6>SRAM: Mapped pa 0x40200000 to va 0xd7000000 size: 0x100000
CPU0: D VIPT write-through cache
CPU0: cache: 768 bytes, associativity 1, 8 byte lines, 64 sets
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: =
16256
<5>Kernel command line: root=3D/dev/nfs mem=3D64M =
console=3DttyS0,115200n8
<6>Clocking rate (Crystal/DPLL/MPU): 19.2/166/83 MHz
<6>GPMC revision 4.0
<6>IRQ: Found an INTC at 0xd8200000 (revision 4.0) with 96 interrupts
<6>Total of 96 interrupts on 1 active controller
<3>clock.c: Enable for wkup_l4_ick without enable code
<3>clock.c: Enable for wkup_32k_fck without enable code
<3>clock.c: Enable for dpll3_ck without enable code
<3>clock.c: Enable for dpll3_m2_ck without enable code
<3>clock.c: Enable for core_ck without enable code
<3>clock.c: Enable for l3_ick without enable code
<3>clock.c: Enable for l4_ick without enable code
<3>clock.c: Enable for per_l4_ick without enable code
<3>clock.c: Enable for per_32k_alwon_fck without enable code
<6>OMAP34xx GPIO hardware version 2.4
PID hash table entries: 256 (order: 8, 1024 bytes)
Console: colour dummy device 80x30
<6>Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
<6>Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
<6>Memory: 64MB =3D 64MB total
<5>Memory: 61824KB available (2748K code, 236K data, 112K init)
<7>Calibrating delay loop... 380.10 BogoMIPS (lpj=3D1900544)
Mount-cache hash table entries: 512
<6>CPU: Testing write buffer coherency: ok
<6>net_namespace: 64 bytes
<6>NET: Registered protocol family 16
<3>clock.c: Enable for core_l4_ick without enable code
<3>clock.c: Enable for dpll4_ck without enable code
<3>clock.c: Enable for dpll4_x2_ck without enable code
<3>clock.c: Enable for cm_96m_fck without enable code
<3>clock.c: Enable for omap_48m_fck without enable code
<3>clock.c: Enable for core_48m_fck without enable code
<3>clock.c: Enable for per_48m_fck without enable code
<6>OMAP DMA hardware revision 4.0
<3>USB: No board-specific platform config found
<6>i2c_omap i2c_omap.1: bus 1 rev3.8 at 2600 kHz
<6>i2c_omap i2c_omap.2: bus 2 rev3.8 at 400 kHz
<6>i2c_omap i2c_omap.3: bus 3 rev3.8 at 400 kHz
<6>TWL4030: TRY attach Slave TWL4030-ID0 on Adapter OMAP I2C adapter [1]
<6>TWL4030: TRY attach Slave TWL4030-ID1 on Adapter OMAP I2C adapter [1]
<6>TWL4030: TRY attach Slave TWL4030-ID2 on Adapter OMAP I2C adapter [1]
<6>TWL4030: TRY attach Slave TWL4030-ID3 on Adapter OMAP I2C adapter [1]
<6><6>TWL4030: Driver registration complete.
<6>NET: Registered protocol family 2
<6>Time: gp timer clocksource has been installed.
<6>IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
<6>TCP established hash table entries: 2048 (order: 2, 16384 bytes)
<6>TCP bind hash table entries: 2048 (order: 1, 8192 bytes)
<6>TCP: Hash tables configured (established 2048 bind 2048)
<6>TCP reno registered
<4>NetWinder Floating Point Emulator V0.97 (double precision)
<5>VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
<6>JFFS2 version 2.2. (NAND) =C2=A9 2001-2006 Red Hat, Inc.
<6>io scheduler noop registered
<6>io scheduler anticipatory registered (default)
<6>io scheduler deadline registered
<6>io scheduler cfq registered
<6>Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing =
disabled
<6>serial8250.0: ttyS0 at MMIO 0x4806a000 (irq =3D 72) is a ST16654
<6>console [ttyS0] enabled
Linux version 2.6.23-omap1 (carlb@tesla) (gcc version 4.2.1) #7 Tue Nov =
20 16:12:10 CET 2007
CPU: ARMv7 Processor [410fc080] revision 0 (ARMv7), cr=3D00c5387f
Machine: OMAP3430 3430SDP board
Memory policy: ECC disabled, Data cache writeback
OMAP3430ES0
SRAM: Mapped pa 0x40200000 to va 0xd7000000 size: 0x100000
CPU0: D VIPT write-through cache
CPU0: cache: 768 bytes, associativity 1, 8 byte lines, 64 sets
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: =
16256
Kernel command line: root=3D/dev/nfs mem=3D64M console=3DttyS0,115200n8
Clocking rate (Crystal/DPLL/MPU): 19.2/166/83 MHz
GPMC revision 4.0
IRQ: Found an INTC at 0xd8200000 (revision 4.0) with 96 interrupts
Total of 96 interrupts on 1 active controller
clock.c: Enable for wkup_l4_ick without enable code
clock.c: Enable for wkup_32k_fck without enable code
clock.c: Enable for dpll3_ck without enable code
clock.c: Enable for dpll3_m2_ck without enable code
clock.c: Enable for core_ck without enable code
clock.c: Enable for l3_ick without enable code
clock.c: Enable for l4_ick without enable code
clock.c: Enable for per_l4_ick without enable code
clock.c: Enable for per_32k_alwon_fck without enable code
OMAP34xx GPIO hardware version 2.4
PID hash table entries: 256 (order: 8, 1024 bytes)
Console: colour dummy device 80x30
Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
Memory: 64MB =3D 64MB total
Memory: 61824KB available (2748K code, 236K data, 112K init)
Mount-cache hash table entries: 512
CPU: Testing write buffer coherency: ok
net_namespace: 64 bytes
NET: Registered protocol family 16
clock.c: Enable for core_l4_ick without enable code
clock.c: Enable for dpll4_ck without enable code
clock.c: Enable for dpll4_x2_ck without enable code
clock.c: Enable for cm_96m_fck without enable code
clock.c: Enable for omap_48m_fck without enable code
clock.c: Enable for core_48m_fck without enable code
clock.c: Enable for per_48m_fck without enable code
OMAP DMA hardware revision 4.0
USB: No board-specific platform config found
i2c_omap i2c_omap.1: bus 1 rev3.8 at 2600 kHz
i2c_omap i2c_omap.2: bus 2 rev3.8 at 400 kHz
i2c_omap i2c_omap.3: bus 3 rev3.8 at 400 kHz
TWL4030: TRY attach Slave TWL4030-ID0 on Adapter OMAP I2C adapter [1]
TWL4030: TRY attach Slave TWL4030-ID1 on Adapter OMAP I2C adapter [1]
TWL4030: TRY attach Slave TWL4030-ID2 on Adapter OMAP I2C adapter [1]
TWL4030: TRY attach Slave TWL4030-ID3 on Adapter OMAP I2C adapter [1]
<6>TWL4030: Driver registration complete.
NET: Registered protocol family 2
Time: gp timer clocksource has been installed.
IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
TCP established hash table entries: 2048 (order: 2, 16384 bytes)
TCP bind hash table entries: 2048 (order: 1, 8192 bytes)
TCP: Hash tables configured (established 2048 bind 2048)
TCP reno registered
NetWinder Floating Point Emulator V0.97 (double precision)
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
JFFS2 version 2.2. (NAND) =C2=A9 2001-2006 Red Hat, Inc.
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing =
disabled
serial8250.0: ttyS0 at MMIO 0x4806a000 (irq =3D 72) is a ST16654
console [ttyS0] enabled
<6>serial8250.0: ttyS1 at MMIO 0x4806c000 (irq =3D 73) is a ST16654
serial8250.0: ttyS1 at MMIO 0x4806c000 (irq =3D 73) is a ST16654
<1>Unhandled fault: external abort on non-linefetch (0x1028) at =
0xd9020004
Unhandled fault: external abort on non-linefetch (0x1028) at 0xd9020004
Internal error: : 1028 [#1]
Internal error: : 1028 [#1]
Modules linked in:Modules linked in:

CPU: 0    Not tainted  (2.6.23-omap1 #7)
CPU: 0    Not tainted  (2.6.23-omap1 #7)
PC is at serial_in+0x6c/0xac
PC is at serial_in+0x6c/0xac
LR is at serial8250_config_port+0x94/0x990
LR is at serial8250_config_port+0x94/0x990
pc : [<c017d370>]    lr : [<c017e2f8>]    psr: 80000093
sp : c0419cd8  ip : c0419ce8  fp : c0419ce4
pc : [<c017d370>]    lr : [<c017e2f8>]    psr: 80000093
sp : c0419cd8  ip : c0419ce8  fp : c0419ce4
r10: c0468060  r9 : 00000001  r8 : 20000013
r10: c0468060  r9 : 00000001  r8 : 20000013
r7 : c0306cb0  r6 : 49020000  r5 : 00000000  r4 : 00000002
r7 : c0306cb0  r6 : 49020000  r5 : 00000000  r4 : 00000002
r3 : d9020000  r2 : 00000002  r1 : 00000004  r0 : c0306cb0
r3 : d9020000  r2 : 00000002  r1 : 00000004  r0 : c0306cb0
Flags: Nzcv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
Flags: Nzcv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
Control: 00c5387f  Table: 80004018  DAC: 00000017
Control: 00c5387f  Table: 80004018  DAC: 00000017
Process swapper (pid: 1, stack limit =3D 0xc04182d0)
Process swapper (pid: 1, stack limit =3D 0xc04182d0)
Stack: (0xc0419cd8 to 0xc041a000)
Stack: (0xc0419cd8 to 0xc041a000)
9cc0: 9cc0:                                                              =
                                               c0419d1c c0419d1c =
c0419ce8 c0419ce8

9ce0: 9ce0: c017e2f8 c017e2f8 c017d310 c017d310 fffffffe fffffffe =
49020000 49020000 c0306cb0 c0306cb0 00000002 00000002 00000002 00000002 =
49020000 49020000

9d00: 9d00: c0306cb0 c0306cb0 c02d9968 c02d9968 c02d99f0 c02d99f0 =
c0468060 c0468060 c0419da4 c0419da4 c0419d20 c0419d20 c017c958 c017c958 =
c017e270 c017e270

9d20: 9d20: c01577f4 c01577f4 c01586a0 c01586a0 c0419d44 c0419d44 =
c0419d38 c0419d38 c02f1234 c02f1234 c0468078 c0468078 c0419d5c c0419d5c =
c0419d48 c0419d48

9d40: 9d40: c0180f18 c0180f18 00000000 00000000 c0419d74 c0419d74 =
c0419d58 c0419d58 c0239278 c0239278 c0061b20 c0061b20 c0180fb8 c0180fb8 =
00000000 00000000

9d60: 9d60: c0306cb0 c0306cb0 c0468060 c0468060 c0419d84 c0419d84 =
c0419d78 c0419d78 c02392e0 c02392e0 c02391d0 c02391d0 c0419da4 c0419da4 =
00000002 00000002

9d80: 9d80: 00000002 00000002 49020000 49020000 c0306cb0 c0306cb0 =
c02d9968 c02d9968 c02d99f0 c02d99f0 c02f11f8 c02f11f8 c0419dcc c0419dcc =
c0419da8 c0419da8

9da0: 9da0: c017f760 c017f760 c017c860 c017c860 c02d9960 c02d9960 =
c0419dec c0419dec c02d9ab0 c02d9ab0 00000001 00000001 00000002 00000002 =
c02d9968 c02d9968

9dc0: 9dc0: c0419e9c c0419e9c c0419dd0 c0419dd0 c017f830 c017f830 =
c017f614 c017f614 c0419dfc c0419dfc c0419de0 c0419de0 c0239278 c0239278 =
c0061b20 c0061b20

9de0: 9de0: c00ce0c8 c00ce0c8 c0419e60 c0419e60 00000000 00000000 =
00000000 00000000 d9020000 d9020000 0000004a 0000004a 02dc6c00 02dc6c00 =
00000000 00000000

9e00: 9e00: 00020200 00020200 00000000 00000000 00000000 00000000 =
00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 =
00000000 00000000

9e20: 9e20: 00000000 00000000 00000000 00000000 00000000 00000000 =
00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 =
00000000 00000000

9e40: 9e40: 00000000 00000000 10000000 10000000 00000000 00000000 =
00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 =
00000000 00000000

9e60: 9e60: 49020000 49020000 c02d9968 c02d9968 00000000 00000000 =
00000000 00000000 c02d9968 c02d9968 c02d9968 c02d9968 c02d9968 c02d9968 =
c02f12c8 c02f12c8

9e80: 9e80: c02f12c8 c02f12c8 c0418000 c0418000 00000000 00000000 =
c0021404 c0021404 c0419eac c0419eac c0419ea0 c0419ea0 c0184d68 c0184d68 =
c017f7a0 c017f7a0

9ea0: 9ea0: c0419ecc c0419ecc c0419eb0 c0419eb0 c0183590 c0183590 =
c0184d54 c0184d54 c02d9a0c c02d9a0c c02d9968 c02d9968 c0183714 c0183714 =
c02f12c8 c02f12c8

9ec0: 9ec0: c0419ee4 c0419ee4 c0419ed0 c0419ed0 c0183790 c0183790 =
c01834c0 c01834c0 00000000 00000000 c0419eec c0419eec c0419f14 c0419f14 =
c0419ee8 c0419ee8

9ee0: 9ee0: c01828e4 c01828e4 c0183720 c0183720 00000000 00000000 =
c02f1780 c02f1780 c02f1780 c02f1780 c02d99b0 c02d99b0 c02f12c8 c02f12c8 =
c02f12d0 c02f12d0

9f00: 9f00: 00000000 00000000 c02f16e8 c02f16e8 c0419f24 c0419f24 =
c0419f18 c0419f18 c01833d0 c01833d0 c01828a0 c01828a0 c0419f44 c0419f44 =
c0419f28 c0419f28

9f20: 9f20: c0182c94 c0182c94 c01833bc c01833bc c02f12c8 c02f12c8 =
c0306e20 c0306e20 c0574408 c0574408 c02f11f8 c02f11f8 c0419f5c c0419f5c =
c0419f48 c0419f48

9f40: 9f40: c01839f8 c01839f8 c0182c30 c0182c30 c0306d68 c0306d68 =
00000005 00000005 c0419f6c c0419f6c c0419f60 c0419f60 c0184ff4 c0184ff4 =
c0183980 c0183980

9f60: 9f60: c0419f8c c0419f8c c0419f70 c0419f70 c001a5f8 c001a5f8 =
c0184f94 c0184f94 00000000 00000000 00000000 00000000 00000000 00000000 =
c0020614 c0020614

9f80: 9f80: c0419ff4 c0419ff4 c0419f90 c0419f90 c0008954 c0008954 =
c001a544 c001a544 c0419fac c0419fac c0419fa0 c0419fa0 c00432ac c00432ac =
c0043048 c0043048

9fa0: 9fa0: 00000000 00000000 c0419fb0 c0419fb0 c0024e84 c0024e84 =
c00432a0 c00432a0 00000000 00000000 00000000 00000000 c000888c c000888c =
c00498ec c00498ec

9fc0: 9fc0: 00000000 00000000 00000000 00000000 00000000 00000000 =
00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 =
00000000 00000000

9fe0: 9fe0: 00000000 00000000 00000000 00000000 00000000 00000000 =
c0419ff8 c0419ff8 c00498ec c00498ec c0008898 c0008898 6972656e 6972656e =
6d6f2063 6d6f2063

Backtrace: Backtrace:

[<c017d304>] [<c017d304>] (serial_in+0x0/0xac) (serial_in+0x0/0xac) from =
[<c017e2f8>] from [<c017e2f8>] (serial8250_config_port+0x94/0x990)
(serial8250_config_port+0x94/0x990)
[<c017e264>] [<c017e264>] (serial8250_config_port+0x0/0x990) =
(serial8250_config_port+0x0/0x990) from [<c017c958>] from [<c017c958>] =
(uart_add_one_port+0x104/0x2e8)
(uart_add_one_port+0x104/0x2e8)
[<c017c854>] [<c017c854>] (uart_add_one_port+0x0/0x2e8) =
(uart_add_one_port+0x0/0x2e8) from [<c017f760>] from [<c017f760>] =
(serial8250_register_port+0x158/0x18c)
(serial8250_register_port+0x158/0x18c)
[<c017f608>] [<c017f608>] (serial8250_register_port+0x0/0x18c) =
(serial8250_register_port+0x0/0x18c) from [<c017f830>] from [<c017f830>] =
(serial8250_probe+0x9c/0x118)
(serial8250_probe+0x9c/0x118)
[<c017f794>] [<c017f794>] (serial8250_probe+0x0/0x118) =
(serial8250_probe+0x0/0x118) from [<c0184d68>] from [<c0184d68>] =
(platform_drv_probe+0x20/0x24)
(platform_drv_probe+0x20/0x24)
[<c0184d48>] [<c0184d48>] (platform_drv_probe+0x0/0x24) =
(platform_drv_probe+0x0/0x24) from [<c0183590>] from [<c0183590>] =
(driver_probe_device+0xdc/0x18c)
(driver_probe_device+0xdc/0x18c)
[<c01834b4>] [<c01834b4>] (driver_probe_device+0x0/0x18c) =
(driver_probe_device+0x0/0x18c) from [<c0183790>] from [<c0183790>] =
(__driver_attach+0x7c/0xd4)
(__driver_attach+0x7c/0xd4)
 r7:c02f12c8 r7:c02f12c8 r6:c0183714 r6:c0183714 r5:c02d9968 r5:c02d9968 =
r4:c02d9a0c r4:c02d9a0c

[<c0183714>] [<c0183714>] (__driver_attach+0x0/0xd4) =
(__driver_attach+0x0/0xd4) from [<c01828e4>] from [<c01828e4>] =
(bus_for_each_dev+0x50/0x84)
(bus_for_each_dev+0x50/0x84)
 r5:c0419eec r5:c0419eec r4:00000000 r4:00000000

[<c0182894>] [<c0182894>] (bus_for_each_dev+0x0/0x84) =
(bus_for_each_dev+0x0/0x84) from [<c01833d0>] from [<c01833d0>] =
(driver_attach+0x20/0x28)
(driver_attach+0x20/0x28)
 r7:c02f16e8 r7:c02f16e8 r6:00000000 r6:00000000 r5:c02f12d0 r5:c02f12d0 =
r4:c02f12c8 r4:c02f12c8

[<c01833b0>] [<c01833b0>] (driver_attach+0x0/0x28) =
(driver_attach+0x0/0x28) from [<c0182c94>] from [<c0182c94>] =
(bus_add_driver+0x70/0x1c0)
(bus_add_driver+0x70/0x1c0)
[<c0182c24>] [<c0182c24>] (bus_add_driver+0x0/0x1c0) =
(bus_add_driver+0x0/0x1c0) from [<c01839f8>] from [<c01839f8>] =
(driver_register+0x84/0x8c)
(driver_register+0x84/0x8c)
 r7:c02f11f8 r7:c02f11f8 r6:c0574408 r6:c0574408 r5:c0306e20 r5:c0306e20 =
r4:c02f12c8 r4:c02f12c8

[<c0183974>] [<c0183974>] (driver_register+0x0/0x8c) =
(driver_register+0x0/0x8c) from [<c0184ff4>] from [<c0184ff4>] =
(platform_driver_register+0x6c/0x88)
(platform_driver_register+0x6c/0x88)
 r4:00000005 r4:00000005

[<c0184f88>] [<c0184f88>] (platform_driver_register+0x0/0x88) =
(platform_driver_register+0x0/0x88) from [<c001a5f8>] from [<c001a5f8>] =
(serial8250_init+0xc0/0x118)
(serial8250_init+0xc0/0x118)
[<c001a538>] [<c001a538>] (serial8250_init+0x0/0x118) =
(serial8250_init+0x0/0x118) from [<c0008954>] from [<c0008954>] =
(kernel_init+0xc8/0x288)
(kernel_init+0xc8/0x288)
 r7:c0020614 r7:c0020614 r6:00000000 r6:00000000 r5:00000000 r5:00000000 =
r4:00000000 r4:00000000

[<c000888c>] [<c000888c>] (kernel_init+0x0/0x288) =
(kernel_init+0x0/0x288) from [<c00498ec>] from [<c00498ec>] =
(do_exit+0x0/0x6e0)
(do_exit+0x0/0x6e0)
Code: Code: e5903000 e5903000 e5d33001 e5d33001 ea00000a ea00000a =
e5903004 e5903004 (e7d33001) (e7d33001)

<0>Kernel panic - not syncing: Attempted to kill init!
Kernel panic - not syncing: Attempted to kill init!

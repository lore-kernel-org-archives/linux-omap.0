From: =?iso-8859-2?Q?Micha=B3_Szabat?= <michal611@interia.pl>
Subject: problem with dspgateway on osk5912
Date: Sat, 25 Mar 2006 20:46:13 +0100
Message-ID: <001901c65044$cc156430$0301a8c0@hydra>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hello.
I want use dspgateway with osk omap 5912 but I have a problem. I use =
kernel 2.6.15-omap1 with options DSPgateway. Filesystem is mounted by =
nfs. When i use command "~/demo # /usr/sbin/dspctl start =
demo_console.out" this returned=20
"
...
vector to 0x017968
releasing DSP reset
DSP configuration ... succeeded
open taskdev: No such file or directory
"
Next when i want use command "~/demo # ./demo_console" this returned =
"open: No such file or directory".
I used precompiled demo and compiled by arm-gcc-3.4.1 and ever it =
returned the same.=20
Where is the problem? Maybe this examples can work only with omap 1510?

log from console:


~/demo # /usr/sbin/dspctl start demo_console.out
loading demo_console.out...
dspgw_task      : adr =3D 0x00c4d4, size=3D   36
dspgw_version   : adr =3D 0x000000, size=3D    8  ... ignored.
SARAM_seq       : adr =3D 0x010000, size=3D    8  ... initialized.
DARAM_seq       : adr =3D 0x000100, size=3D    8  ... initialized.
SDRAM_seq       : adr =3D 0xfffd00, size=3D    8  ... initialized.
SDRAM_system_data : adr =3D 0xfffd08, size=3D  136  ... initialized.
sleep_code      : adr =3D 0x000108, size=3D  242  ... initialized.
.vers           : adr =3D 0x000000, size=3D  120  ... ignored.
.sysstack       : adr =3D 0x0001fc, size=3D  512  ... initialized.
.clk            : adr =3D 0x0003fc, size=3D    8  ... initialized.
.prd            : adr =3D 0x000404, size=3D   48  ... initialized.
.swi            : adr =3D 0x000434, size=3D   80  ... initialized.
.tsk            : adr =3D 0x000484, size=3D  264  ... initialized.
.idl            : adr =3D 0x00058c, size=3D    8  ... initiomapdsp: =
IPBUF configuran           1 words * 1 lines at 0xe000c4f8.
alized.
.hwi_disp_sec   : adr =3Domapdsp: found 1 task(s)
 0x000594, size=3D  384  ... initiomapdsp: task 0: name demo_console
alized.
.bss            : adr =3D 0x000714, size=3D 2792  ... initiomapdsp: =
taskdev demo_co.alized.
.far            : adr =3D 0x000100, size=3D    0
.sysdata        : adr =3D 0x0011fc, size=3D  316  ... initialized.
.mem            : adr =3D 0x0001fa, size=3D    2  ... initialized.
.cio            : adr =3D 0x000100, size=3D    0
.sysregs        : adr =3D 0x000100, size=3D    0
.sem            : adr =3D 0x001338, size=3D  132  ... initialized.
.dsm            : adr =3D 0x000100, size=3D    0
.data           : adr =3D 0x0013bc, size=3D    4  ... initialized.
.gio            : adr =3D 0x000100, size=3D    0
.sys            : adr =3D 0x0013c0, size=3D   16  ... initialized.
.TSK_idle$stk   : adr =3D 0x0013d0, size=3D 2560  ... initialized.
.TSK_sleep$stk  : adr =3D 0x001dd0, size=3D 2560  ... initialized.
.TSK_super$stk  : adr =3D 0x0027d0, size=3D 2560  ... initialized.
.const          : adr =3D 0x0031d0, size=3D 1814  ... initialized.
.printf         : adr =3D 0x0038e6, size=3D  236  ... ignored.
.args           : adr =3D 0x0038e8, size=3D   16  ... initialized.
.LOG_system$buf : adr =3D 0x003900, size=3D  128  ... initialized.
.trace          : adr =3D 0x003980, size=3D 1024  ... initialized.
.stack          : adr =3D 0x003d80, size=3D 2048  ... initialized.
.hst            : adr =3D 0x000100, size=3D    0
.log            : adr =3D 0x004580, size=3D   20  ... initialized.
.pip            : adr =3D 0x000100, size=3D    0
.sts            : adr =3D 0x004594, size=3D   64  ... initialized.
.DARAM$heap     : adr =3D 0x0045d4, size=3D32512
frt             : adr =3D 0x010000, size=3D    0
.bios           : adr =3D 0x010008, size=3D10215  ... initialized.
.text           : adr =3D 0x0127f0, size=3D20642  ... initialized.
.switch         : adr =3D 0x010000, size=3D    0
.sysinit        : adr =3D 0x017892, size=3D  437  ... initialized.
.trcdata        : adr =3D 0x017a48, size=3D    6  ... initialized.
.pinit          : adr =3D 0x010000, size=3D    0
.gblinit        : adr =3D 0x017a4e, size=3D   74  ... initialized.
.hwi            : adr =3D 0x010000, size=3D    0
.SARAM$heap     : adr =3D 0x017a98, size=3D   16
.hwi_vec        : adr =3D 0xffff00, size=3D  256  ... initialized.
ipbuf           : adr =3D 0x00c4f8, size=3D   14  ... initialized.
dbgbuf          : adr =3D 0x00c506, size=3D 4096  ... initialized.
warning: found zero-sized cinit entry at 0x9f2
.cinit          : adr =3D 0x010000, size=3D 2548   ... .bss variables =
are initializ.setting DSP reset vector to 0x017968
releasing DSP reset
DSP configuration ... succeeded
open taskdev: No such file or directory
~/demo # ./demo_console
open: No such file or directory
~/demo # dmesg
Linux version 2.6.15-omap1 (root@hydra.izi.int.pl) (gcc version 3.4.1) =
#1 Sun M6CPU: ARM926EJ-Sid(wb) [41069263] revision 3 (ARMv5TEJ)
Machine: TI-OSK
Memory policy: ECC disabled, Data cache writeback
On node 0 totalpages: 7680
  DMA zone: 7680 pages, LIFO batch:0
  DMA32 zone: 0 pages, LIFO batch:0
  Normal zone: 0 pages, LIFO batch:0
  HighMem zone: 0 pages, LIFO batch:0
OMAP162123 revision 2 handled as 16xx id: 44059089bfcb0f21
SRAM: Mapped pa 0x00020000 to va 0xd0000000 size: 0x4000
CPU0: D VIVT write-back cache
CPU0: I cache: 16384 bytes, associativity 4, 32 byte lines, 128 sets
CPU0: D cache: 8192 bytes, associativity 4, 32 byte lines, 64 sets
Built 1 zonelists
Kernel command line: console=3DttyS0,115200n8 noinitrd =
ip=3D::::osk:eth0:off root=3D/MClocks: ARM_SYSST: 0x1000 DPLL_CTL: =
0x2833 ARM_CKCTL: 0x3000
Clocking rate (xtal/DPLL1/MPU): 12.0/192.0/192.0 MHz
Total of 128 interrupts in 4 interrupt banks
OMAP GPIO hardware version 1.0
MUX: initialized M7_1610_GPIO62
PID hash table entries: 128 (order: 7, 2048 bytes)
Console: colour dummy device 80x30
Dentry cache hash table entries: 4096 (order: 2, 16384 bytes)
Inode-cache hash table entries: 2048 (order: 1, 8192 bytes)
Memory: 30MB =3D 30MB total
Memory: 27904KB available (1969K code, 409K data, 108K init)
Calibrating delay loop... 95.83 BogoMIPS (lpj=3D373760)
Mount-cache hash table entries: 512
CPU: Testing write buffer coherency: ok
NET: Registered protocol family 16
OMAP DMA hardware version 1
DMA capabilities: 000c0000:00000000:01ff:003f:007f
Initializing OMAP McBSP system
USB: hmc 16, usb0 2 wires
i2c_omap: bus 0 rev2.2 at 100 KHz
tps65010: version 2 May 2005
MUX: initialized N14_1610_UWIRE_CS0
MUX: initialized P15_1610_UWIRE_CS3
Power Management for TI OMAP.
MUX: initialized T20_1610_LOW_PWR
NetWinder Floating Point Emulator V0.97 (double precision)
OMAP OCPI interconnect driver loaded
OMAP DSP driver initialization
omapdsp: mapping in ARM MMU, v=3D0xe0fff000, p=3D0x10328000, sz=3D0x1000
JFFS2 version 2.2. (NAND) (C) 2001-2003 Red Hat, Inc.
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
omapfb: configured for panel osk
omapfb-lcdc: init
omapfb-lcdc: Pixel clock divider value is obsolete.
omapfb-lcdc: Try to set pixel_clock to 8000 and pcd to 0 in =
drivers/video/omap/.MUX: initialized PWL
Console: switching to colour frame buffer device 30x40
omapfb: initialized vram=3D153600 pixclock 8000 kHz hfreq 20.1 kHz vfreq =
63.3 Hz
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing =
disabled
serial8250.0: ttyS0 at MMIO 0xfffb0000 (irq =3D 46) is a ST16654
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
loop: loaded (max 8 devices)
PPP generic driver version 2.4.2
smc91x.c: v1.1, sep 22 2004 by Nicolas Pitre <nico@cam.org>
eth0: SMC91C94 (rev 9) at c2052300 IRQ 160 [nowait]
eth0: Ethernet addr: 00:0e:99:02:08:b9
eth0: No PHY found
i2c /dev entries driver
TLV320AIC23 I2C version 0.1 (12-Aug-2004)
omapflash.0: Found 1 x16 devices at 0x0 in 16-bit bank
omapflash.0: Found 1 x16 devices at 0x1000000 in 16-bit bank
 Intel/Sharp Extended Query Table at 0x0031
Using buffer write method
cfi_cmdset_0001: Erase suspend on write enabled
erase region 0: offset=3D0x0,size=3D0x20000,blocks=3D128
erase region 1: offset=3D0x1000000,size=3D0x20000,blocks=3D128
Creating 4 MTD partitions on "omapflash.0":
0x00000000-0x00020000 : "bootloader"
0x00020000-0x00040000 : "params"
0x00040000-0x00240000 : "kernel"
0x00240000-0x02000000 : "filesystem"
MUX: initialized W11_1610_CF_CD1
MUX: initialized P11_1610_CF_CD2
MUX: initialized R11_1610_CF_IOIS16
MUX: initialized V10_1610_CF_IREQ
MUX: initialized W10_1610_CF_RESET
omap_cf: cs2 on irq 222
mice: PS/2 mouse device common for all mice
OMAP Keypad Driver
input: omap-keypad as /class/input/input0
OMAP OSK AIC23 audio support initialized
NET: Registered protocol family 2
IP route cache hash table entries: 256 (order: -2, 1024 bytes)
TCP established hash table entries: 1024 (order: 0, 4096 bytes)
TCP bind hash table entries: 1024 (order: 0, 4096 bytes)
TCP: Hash tables configured (established 1024 bind 1024)
TCP reno registered
TCP bic registered
NET: Registered protocol family 1
Disabling unused clock "usb_dc_ck"...  done
FIXME: Clock "tc2_ck" seems unused
Disabling unused clock "tc1_ck"...  done
Skipping reset check for DSP domain clock "dsptim_ck"
Skipping reset check for DSP domain clock "dspxor_ck"
Skipping reset check for DSP domain clock "dspper_ck"
eth0: link up
Sending DHCP requests ., OKdspctl start demo_console.out

IP-Config: Got DHCP answer from 0.0.0.0, my address is 10.3.0.2
IP-Config: Complete:
      device=3Deth0, addr=3D10.3.0.2, mask=3D255.255.0.0, gw=3D10.3.0.1,
     host=3Dosk, domain=3D, nis-domain=3D(none),
     bootserver=3D0.0.0.0, rootserver=3D10.3.0.1, rootpath=3D
Looking up port of RPC 100003/2 on 10.3.0.1
Looking up port of RPC 100005/1 on 10.3.0.1
VFS: Mounted root (nfs filesystem).
Freeing init memory: 108K
mbx: sending seq=3D0, cmd=3D70:00(DSPCFG:REQ), data=3D0000
mbx: receiving seq=3D0, cmd=3D70:70(DSPCFG:PROTREV), data=3D0019
mbx: receiving seq=3D1, cmd=3D70:28(DSPCFG:SYSADRH), data=3D007f
mbx: receiving seq=3D0, cmd=3D70:a9(DSPCFG:SYSADRL), data=3Dfe88
omapdsp: IPBUF configuration
           1 words * 1 lines at 0xe000c4f8.
mbx: receiving seq=3D1, cmd=3D23:00(BKYLD), data=3D0000
omapdsp: found 1 task(s)
mbx: sending seq=3D0, cmd=3D60:00(TCFG:task 0), data=3D0000
mbx: receiving seq=3D0, cmd=3D60:00(TCFG:task 0), data=3D0000
omapdsp: task 0: name demo_console
mbx: sending seq=3D1, cmd=3D30:00(TCTL:task 0), data=3D0000
omapdsp: taskdev demo_console enabled.
mbx: sending seq=3D0, cmd=3D75:00(SETVAR:ICRMASK), data=3Dffff
mbx: sending seq=3D1, cmd=3D52:00(PM:DISABLE), data=3D0002
~/demo # ./demo_console
open: No such file or directory
~/demo #


Please help me.
Michal.

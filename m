From: Cyrille Chartrain <cyrille.chartrain@purplelabs.com>
Subject: ARM: OMAP1: kernel 2.6.21-omap1 and 2.6.22-omap1 causing issue on
 DSP Gateway
Date: Fri, 08 Jun 2007 16:38:53 +0200
Message-ID: <466969FD.20709@purplelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hello all,

I would like to report a regression caused by kernel 2.6.21-omap1 and 
2.6.22-omap1 on DSP Gateway when working on a H3 board.
I used to work with kernel 2.6.20-rc5-omap1 and latest DSP Gateway 
(3.3.1). Everything works great with this kernel.

I tried to switch on latest kernel 2.6.22-rc4-omap1 (still using DSP 
Gateway 3.3.1)
and I have a NULL pointer error when I start dspctl on one of the 
example program
(see trace below).
I have the same issue on kernel 2.6.21-omap1.

The error is caused by the fact that mmu->twl_mm is not allocated. It 
seems this allocation is done in  omap_mmu_register() function
only if  ".pte_get_attr" callback of "omap1_mmu_ops" structure is 
defined. Is it normal .pte_get_attr is not defined for OMAP1?


Has anybody tested DSP Gateway and OMAP1 configuration with latest 
changes in the kernel concerning MMU, ....?
Is it a problem of DSP gateway modifications made for OMAP2 not reported 
into OMAP1 code?

Thanks for your help on this matter,

Cyrille Chartrain

--

Uncompressing 
Linux..................................................................................... 
done
, booting the kernel.
Linux version 2.6.22-rc4-omap1-g0e13579c (cchartrai@l1_cch_lin) (gcc 
version 3.4.4 (release) (CodeSourcery AR
M 2005q3-2)) #2 Fri Jun 8 15:57:18 CEST 2007
CPU: ARM926EJ-S [41069263] revision 3 (ARMv5TEJ), cr=00053177
Machine: TI OMAP1710 H3 board
Memory policy: ECC disabled, Data cache writeback
OMAP1710 revision 0 handled as 16xx id: 0b5f702f03330000
SRAM: Mapped pa 0x20000000 to va 0xd0000000 size: 0x100000
CPU0: D VIVT write-back cache
CPU0: I cache: 32768 bytes, associativity 4, 32 byte lines, 256 sets
CPU0: D cache: 16384 bytes, associativity 4, 32 byte lines, 128 sets
Built 1 zonelists.  Total pages: 4064
Kernel command line: mem=16M console=ttyS0,115200n8 noinitrd 
root=/dev/nfs rw nfsroot=10.1.2.35:/home/cchartr
ai/env/arm_fs,nolock ip=dhcp
Clocks: ARM_SYSST: 0x1000 DPLL_CTL: 0x2813 ARM_CKCTL: 0x350e
Clocking rate (xtal/DPLL1/MPU): 12.0/168.0/168.0 MHz
Total of 128 interrupts in 4 interrupt banks
OMAP GPIO hardware version 1.1
MUX: initialized W15_1710_GPIO40
PID hash table entries: 64 (order: 6, 256 bytes)
Console: colour dummy device 80x30
Dentry cache hash table entries: 2048 (order: 1, 8192 bytes)
Inode-cache hash table entries: 1024 (order: 0, 4096 bytes)
Memory: 16MB = 16MB total
Memory: 13484KB available (2364K code, 218K data, 124K init)
Mount-cache hash table entries: 512
CPU: Testing write buffer coherency: ok
NET: Registered protocol family 16
MUX: initialized V2_1710_GPIO10
MUX: initialized G18_1610_KBR0
MUX: initialized F19_1610_KBR1
MUX: initialized H14_1610_KBR2
MUX: initialized E20_1610_KBR3
MUX: initialized E19_1610_KBR4
MUX: initialized N19_1610_KBR5
OMAP DMA hardware version 1
DMA capabilities: 000c0000:00000000:01ff:003f:007f
Initializing OMAP McBSP system
omap_dsp_init() done
MUX: initialized USB1_TXD
MUX: initialized USB1_TXEN
MUX: initialized R13_1710_USB1_SEO
USB: hmc 20, usb2 alt 0 wires, usb1 3 wires, Mini-AB on usb1
i2c_omap i2c_omap.1: bus 1 rev3.1 at 100 kHz
tps65010: version 2 May 2005
tps65010: IRQ not configured!
tps65010: battery charging
NET: Registered protocol family 23
Time: mpu_timer2 clocksource has been installed.
NET: Registered protocol family 2
IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
TCP established hash table entries: 512 (order: 0, 4096 bytes)
TCP bind hash table entries: 512 (order: -1, 2048 bytes)
TCP: Hash tables configured (established 512 bind 512)
TCP reno registered
Power Management for TI OMAP.
MUX: initialized T20_1610_LOW_PWR
MUX: initialized P18_1610_GPIO3
NetWinder Floating Point Emulator V0.97 (double precision)
OMAP OCPI interconnect driver loaded
dsp dsp: OMAP DSP driver initialization
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
omapfb: configured for panel h3
omapfb: LCDC initialized
Console: switching to colour frame buffer device 30x40
omapfb: Framebuffer initialized. Total vram 155648 planes 1
omapfb: Pixclock 10500 kHz hfreq 32.5 kHz vfreq 100.0 Hz
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
serial8250.0: ttyS0 at MMIO 0xfffb0000 (irq = 46) is a ST16654
serial8250.0: ttyS1 at MMIO 0xfffb0800 (irq = 47) is a ST16654
serial8250.0: ttyS2 at MMIO 0xfffb9800 (irq = 15) is a ST16654
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
PPP generic driver version 2.4.2
SLIP: version 0.8.4-NET3.019-NEWTTY (dynamic channels, max=256).
CSLIP: code copyright 1989 Regents of the University of California.
smc91x.c: v1.1, sep 22 2004 by Nicolas Pitre <nico@cam.org>
eth0: SMC91C94 (rev 9) at c1802300 IRQ 200 [nowait]
eth0: Ethernet addr: 00:10:20:30:40:50
Linux video capture interface: v2.00
mice: PS/2 mouse device common for all mice
OMAP Keypad Driver
input: omap-keypad as /class/input/input0
TCP cubic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
eth0: link up
Sending DHCP requests ., OK
IP-Config: Got DHCP answer from 10.1.1.76, my address is 10.1.2.8
IP-Config: Complete:
      device=eth0, addr=10.1.2.8, mask=255.255.0.0, gw=10.1.1.50,
     host=10.1.2.8, domain=purplelabs.com, nis-domain=(none),
     bootserver=10.1.1.76, rootserver=10.1.2.35, rootpath=/home/tftproot
Looking up port of RPC 100003/2 on 10.1.2.35
Looking up port of RPC 100005/1 on 10.1.2.35
VFS: Mounted root (nfs filesystem).
Freeing init memory: 124K
starting up local systems
dev/pts unmount ok
Mounting a tmpfs over /dev...done.
Creating initial device nodes...done.
done

10.1.2.8 login: root
login[605]: root login on 'tts/0'


BusyBox v1.3.1 (2007-01-25 11:07:19 CET) Built-in shell (ash)
Enter 'help' for a list of built-in commands.

~ $ dspctl start demo_console.out
MMU: OMAP mmu:dsp MMU initialized (HW v0.0)
Unable to handle kernel NULL pointer dereference at virtual address 00000024
pgd = c0db8000
[00000024] *pgd=10342031, *pte=00000000, *ppte=00000000
Internal error: Oops: 17 [#1]
Modules linked in:
CPU: 0
PC is at omap_mmu_enable+0x10/0x80
LR is at omap_mmu_register+0x124/0x268
pc : [<c003fe60>]    lr : [<c00407e0>]    Not tainted
sp : c0d8bde0  ip : c0d8bdf0  fp : c0d8bdec
r10: c0f5eeb8  r9 : c0d8a000  r8 : c0280328
r7 : c02801d8  r6 : 00000000  r5 : 00000000  r4 : c02801b8
r3 : 00000000  r2 : 00000199  r1 : 00000001  r0 : c02801b8
Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  Segment user
Control: 5317F
Table: 10DB8000  DAC: 00000015
Process dspctl (pid: 606, stack limit = 0xc0d8a260)
Stack: (0xc0d8bde0 to 0xc0d8c000)
bde0: c0d8be24 c0d8bdf0 c00407e0 c003fe60 c02801b8 c0340740 c0d8be1c 
c0d8be08
be00: c0113124 c0340740 c02801b8 c02956e8 c0f40878 c034f820 c0d8be3c 
c0d8be28
be20: c004b0fc c00406cc c0340740 c034f820 c0d8be5c c0d8be40 c004260c 
c004b0d4
be40: c014e770 c0340740 c034f820 c02956e8 c0d8be7c c0d8be60 c00488ac 
c0042608
be60: c0340740 c0f40878 00000000 00000000 c0d8beac c0d8be80 c0098bfc 
c004887c
be80: c0d8bea4 00000000 00000000 c034f820 c0f40878 00000000 c0098ab8 
c02e1f20
bea0: c0d8bed4 c0d8beb0 c0095078 c0098ac8 c034f820 c0d8bf00 00000003 
ffffff9c
bec0: c0028674 c0f03000 c0d8bef4 c0d8bed8 c00951a0 c0094f8c 00000000 
c0028674
bee0: c0d8a000 00000002 c0d8bf64 c0d8bef8 c0095200 c009517c c0d8bf00 
c0d8bf08
bf00: c0f5eeb8 c02e1f20 00000000 c0db8000 00000000 00000101 00000001 
00000000
bf20: c02ef5c8 c02ef5c0 ffffffe8 c0f03000 c0d8bf64 c0d8bf40 c00953cc 
c00ab4fc
bf40: c009ccb8 00000003 00000000 c034f820 00000002 bee17f83 c0d8bf94 
c0d8bf68
bf60: c0095560 c00951c8 00000000 00000000 00000000 4001de14 0000c2e4 
00000005
bf80: c0028674 00900005 c0d8bfa4 c0d8bf98 c009561c c0095518 00000000 
c0d8bfa8
bfa0: c0027e80 c0095604 00000000 4001de14 0000c9fc 00000002 bee17f83 
00000000
bfc0: 00000000 4001de14 0000c2e4 00000000 00000000 00000000 40128000 
bee17d24
bfe0: 00000000 bee17cfc 400c25fc 400c2618 60000010 0000c9fc 00000000 
00000000
Backtrace:
[<c003fe50>] (omap_mmu_enable+0x0/0x80) from [<c00407e0>] 
(omap_mmu_register+0x124/0x268)
[<c00406bc>] (omap_mmu_register+0x0/0x268) from [<c004b0fc>] 
(dsp_mem_late_init+0x38/0x68)
 r8:c034f820 r7:c0f40878 r6:c02956e8 r5:c02801b8 r4:c0340740
[<c004b0c4>] (dsp_mem_late_init+0x0/0x68) from [<c004260c>] 
(dsp_late_init+0x14/0xe0)
 r5:c034f820 r4:c0340740
[<c00425f8>] (dsp_late_init+0x0/0xe0) from [<c00488ac>] 
(dsp_ctl_core_open+0x40/0x10c)
 r6:c02956e8 r5:c034f820 r4:c0340740
[<c004886c>] (dsp_ctl_core_open+0x0/0x10c) from [<c0098bfc>] 
(chrdev_open+0x144/0x168)
 r7:00000000 r6:00000000 r5:c0f40878 r4:c0340740
[<c0098ab8>] (chrdev_open+0x0/0x168) from [<c0095078>] 
(__dentry_open+0xfc/0x1f0)
 r8:c02e1f20 r7:c0098ab8 r6:00000000 r5:c0f40878 r4:c034f820
[<c0094f7c>] (__dentry_open+0x0/0x1f0) from [<c00951a0>] 
(nameidata_to_filp+0x34/0x4c)
[<c009516c>] (nameidata_to_filp+0x0/0x4c) from [<c0095200>] 
(do_filp_open+0x48/0x50)
 r4:00000002
[<c00951b8>] (do_filp_open+0x0/0x50) from [<c0095560>] 
(do_sys_open+0x58/0xec)
 r5:bee17f83 r4:00000002
[<c0095508>] (do_sys_open+0x0/0xec) from [<c009561c>] (sys_open+0x28/0x2c)
[<c00955f4>] (sys_open+0x0/0x2c) from [<c0027e80>] 
(ret_fast_syscall+0x0/0x2c)
Code: e1a0c00d e92dd800 e24cb004 e5903188 (e5933024)
Segmentation fault

From: "Trilok Soni" <soni.trilok@gmail.com>
Subject: H4 boot with latest git kernel
Date: Fri, 9 Feb 2007 16:54:39 +0530
Message-ID: <5d5443650702090324g6048af71u17f20a55f823edda@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
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

Hi,

H4 booting sequence stops just after the following NET messages. I am
using latest pull from git. I have tried disabling IrDA, thinking that
it might had created some problems. Is it working for anyone out
there?

------
Linux version 2.6.20-rc7-omap1-g4a71abfb-dirty (trilok@cauveri) (gcc
version 4.1.
1 (CodeSourcery ARM Sourcery G++ 2006q3-26)) #33 Fri Feb 9 22:20:38 IST 2007
CPU: ARMv6-compatible processor [4107b362] revision 2 (ARMv6TEJ), cr=00c5387f
Machine: OMAP2420 H4 board
Memory policy: ECC disabled, Data cache writeback
OMAP2420
SRAM: Mapped pa 0x40200000 to va 0xd0000000 size: 0x100000
CPU0: D VIPT write-back cache
CPU0: I cache: 32768 bytes, associativity 4, 32 byte lines, 256 sets
CPU0: D cache: 32768 bytes, associativity 4, 32 byte lines, 256 sets
Built 1 zonelists.  Total pages: 32512
Kernel command line: console=ttyS0,115200n8 noinitrd root=/dev/nfs rw nfsroot=10
.203.97.28:/pub/fs/eabi,rsize=1024,wsize=1024 ip=10.203.97.29:10.203.97.28:255.2
55.255.192:omap2:eth0
Clocking rate (Crystal/DPLL/MPU): 12.0/600/300 MHz
clock.c: Enable for dpll_ck without enable code
GPMC revision 1.0
IRQ: Found an INTC at 0xd80fe000 (revision 1.0) with 96 interrupts
Total of 96 interrupts on 1 active controller
OMAP242x GPIO hardware version 1.5
PID hash table entries: 512 (order: 9, 2048 bytes)
Console: colour dummy device 80x30
Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
Memory: 128MB 0MB = 128MB total
Memory: 126848KB available (2568K code, 240K data, 112K init)
Mount-cache hash table entries: 512
CPU: Testing write buffer coherency: ok
NET: Registered protocol family 16
MUX: setup M15_24XX_GPIO92 (0x4800010a): 0x03 -> 0x03
MUX: setup T19_24XX_KBR0 (0x48000106): 0x0f -> 0x1b
MUX: setup R19_24XX_KBR1 (0x48000107): 0x0f -> 0x1b
MUX: setup V18_24XX_KBR2 (0x48000139): 0x07 -> 0x1b
MUX: setup M21_24XX_KBR3 (0x480000c9): 0x0f -> 0x1b
MUX: setup E5__24XX_KBR4 (0x48000138): 0x0f -> 0x1b
MUX: setup B3__24XX_KBR5 (0x48000030): 0x03 -> 0x1b
MUX: setup AA4_24XX_KBC2 (0x480000e7): 0x03 -> 0x03
MUX: setup B13_24XX_KBC6 (0x48000110): 0x03 -> 0x03
MUX: setup R20_24XX_KBC0 (0x48000108): 0x0f -> 0x03
MUX: setup M14_24XX_KBC1 (0x48000109): 0x1f -> 0x03
MUX: setup V17_24XX_KBC3 (0x48000135): 0x07 -> 0x03
MUX: setup P21_24XX_KBC4 (0x480000ca): 0x0f -> 0x03
MUX: setup L14_24XX_KBC5 (0x4800010f): 0x0f -> 0x03
MUX: setup H18_24XX_MMC_CMD (0x480000f4): 0x00 -> 0x00
MUX: setup H15_24XX_MMC_CLKI (0x480000fe): 0x00 -> 0x00
MUX: setup G19_24XX_MMC_CLKO (0x480000f3): 0x00 -> 0x00
MUX: setup F20_24XX_MMC_DAT0 (0x480000f5): 0x00 -> 0x00
MUX: setup F19_24XX_MMC_DAT_DIR0 (0x480000f9): 0x00 -> 0x00
MUX: setup G18_24XX_MMC_CMD_DIR (0x480000fd): 0x00 -> 0x00
MUX: setup H14_24XX_MMC_DAT1 (0x480000f6): 0x00 -> 0x00
MUX: setup E19_24XX_MMC_DAT2 (0x480000f7): 0x00 -> 0x00
MUX: setup D19_24XX_MMC_DAT3 (0x480000f8): 0x00 -> 0x00
MUX: setup E20_24XX_MMC_DAT_DIR1 (0x480000fa): 0x00 -> 0x00
MUX: setup F18_24XX_MMC_DAT_DIR2 (0x480000fb): 0x00 -> 0x00
MUX: setup E18_24XX_MMC_DAT_DIR3 (0x480000fc): 0x00 -> 0x00
MUX: setup M19_24XX_I2C1_SCL (0x48000111): 0x00 -> 0x00
MUX: setup L15_24XX_I2C1_SDA (0x48000112): 0x00 -> 0x00
OMAP DMA hardware revision 1.0
Initializing OMAP McBSP system
MUX: setup Y15_24XX_MCBSP2_CLKX (0x48000124): 0x0f -> 0x09
MUX: setup R14_24XX_MCBSP2_FSX (0x48000125): 0x0f -> 0x09
MUX: setup W15_24XX_MCBSP2_DR (0x48000126): 0x0f -> 0x09
MUX: setup V15_24XX_MCBSP2_DX (0x48000127): 0x0f -> 0x09
MUX: setup V14_24XX_GPIO117 (0x48000128): 0x0f -> 0x0b
omap_dsp_init() done
MUX: setup K18_24XX_USB0_DAT (0x48000123): 0x00 -> 0x00
MUX: setup K19_24XX_USB0_TXEN (0x48000121): 0x00 -> 0x00
MUX: setup J14_24XX_USB0_SE0 (0x48000122): 0x00 -> 0x00
USB: hmc 0, usb0 3 wires
i2c_omap i2c_omap.1: bus 1 rev3.1 at 100 kHz
NET: Registered protocol family 2
IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
TCP established hash table entries: 4096 (order: 2, 16384 bytes)
TCP bind hash table entries: 2048 (order: 1, 8192 bytes)
TCP: Hash tables configured (established 4096 bind 2048)
TCP reno registered
NetWinder Floating Point Emulator V0.97 (double precision)
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
JFFS2 version 2.2. (NAND) (C) 2001-2006 Red Hat, Inc.
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
omapfb: configured for panel h4
omapfb: DISPC version 1.0 initialized
Console: switching to colour frame buffer device 30x40
omapfb: Framebuffer initialized. Total vram 153600 planes 1
omapfb: Pixclock 6250 kHz hfreq 18.3 kHz vfreq 58.6 Hz
OMAP Watchdog Timer: initial timeout 60 sec
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
serial8250.0: ttyS0 at MMIO 0x4806a000 (irq = 72) is a ST16654
serial8250.0: ttyS1 at MMIO 0x4806c000 (irq = 73) is a ST16654
serial8250.0: ttyS2 at MMIO 0x4806e000 (irq = 74) is a ST16654
RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
loop: loaded (max 8 devices)
smc91x.c: v1.1, sep 22 2004 by Nicolas Pitre <nico@cam.org>
eth0: SMC91C94 (rev 9) at c8850300 IRQ 252 [nowait]
eth0: Ethernet addr: 00:50:c2:27:1e:ab
MUX: setup W19_24XX_SYS_NIRQ (0x4800012c): 0x00 -> 0x18
Menelaus rev 1.1
omapflash.0: Found 1 x16 devices at 0x0 in 16-bit bank
omapflash.0: Found 1 x16 devices at 0x2000000 in 16-bit bank
 Intel/Sharp Extended Query Table at 0x010A
 Intel/Sharp Extended Query Table at 0x010A
 Intel/Sharp Extended Query Table at 0x010A
 Intel/Sharp Extended Query Table at 0x010A
 Intel/Sharp Extended Query Table at 0x010A
 Intel/Sharp Extended Query Table at 0x010A
Using buffer write method
cfi_cmdset_0001: Erase suspend on write enabled
Creating 4 MTD partitions on "omapflash.0":
0x00000000-0x00020000 : "bootloader"
0x00020000-0x00040000 : "params"
0x00040000-0x00240000 : "kernel"
0x00240000-0x04000000 : "filesystem"
OMAP Keypad Driver
input: omap-keypad as /class/input/input0
TCP cubic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
NET: Registered protocol family 15
----

-- 
--Trilok Soni

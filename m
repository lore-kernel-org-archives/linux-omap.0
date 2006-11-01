From: Hingkwan Huen <hkh@cypress.com>
Subject: RE: OMAP H4 Boot from MMC Card
Date: Tue, 31 Oct 2006 19:06:38 -0800
Message-ID: <1162350399.2816.32.camel@localhost.localdomain>
References: <77C7F7CB1230A74A9D19C0C111E6EDBE01C1A0EF@DLEE09.ent.ti.com>
Reply-To: hkh@cypress.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <77C7F7CB1230A74A9D19C0C111E6EDBE01C1A0EF@DLEE09.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hello Khasim,

Many thanks for the help! I've tried your mentioned bootargs, and copied
all files and subdirectories from the existing NFS target to the MMC
card. However, it failed to mount root on /dev/mmc0 that I created with
mknod, and eventually crashed. Do you know what could be wrong here?
BTW, I was using kernel 2.6.16. I had a typo on my original email.

Any suggestions are greatly appreciated!

Thanks and regards,
kwan

P.S. Below is the boot log file...

OMAP242x H4 # printenv
bootdelay=3
baudrate=115200
bootfile="uImage.cc"
ethaddr=08:00:28:01:12:7E
stdin=serial
stdout=serial
stderr=serial
bootargs=mem=64M console=ttyS0,115200n8 noinitrd root=/dev/mmc0 rw
ip=off devfs=mount
filesize=1677e1
fileaddr=82000000
netmask=255.255.0.0
ipaddr=172.16.150.186
serverip=172.16.142.59

Environment size: 301/131068 bytes
OMAP242x H4 # bootm 82000000
## Booting image at 82000000 ...
   Image Name:   Linux Kernel
   Image Type:   ARM Linux Kernel Image (gzip compressed)
   Data Size:    1472417 Bytes =  1.4 MB
   Load Address: 80008000
   Entry Point:  80008000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK

Starting kernel ...

Linux version 2.6.16-omap2 (hkh@localhost.localdomain) (gcc version
3.4.5) #5 Tue Oct 31 15:40:41 PST 2006
CPU: Some Random V6 Processor [4107b362] revision 2 (ARMv6TEJ)
Machine: OMAP2420 H4 board
Memory policy: ECC disabled, Data cache writeback
OMAP24205
SRAM: Mapped pa 0x40200000 to va 0xd0000000 size: 0xa0000
CPU0: D VIPT write-back cache
CPU0: I cache: 32768 bytes, associativity 4, 32 byte lines, 256 sets
CPU0: D cache: 32768 bytes, associativity 4, 32 byte lines, 256 sets
Built 1 zonelists
Kernel command line: mem=64M console=ttyS0,115200n8 noinitrd
root=/dev/mmc0 rw ip=off devfs=mount
Clocking rate (Crystal/DPLL/MPU): 12.0/532/266 MHz
clock.c: Enable for dpll_ck without enable code
IRQ: Found an INTC at 0x480fe000 (revision 2.0) with 96 interrupts
Total of 96 interrupts on 1 active controller
OMAP24xx GPIO hardware version 1.8
Muxing M15_24XX_GPIO92 (0x4800010a): 0x03 -> 0x03
PID hash table entries: 512 (order: 9, 8192 bytes)
OMAP2 GP timer (HW version 1.3)
Console: colour dummy device 80x30
Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
Memory: 64MB = 64MB total
Memory: 61696KB available (2512K code, 526K data, 112K init)
Mount-cache hash table entries: 512
CPU: Testing write buffer coherency: ok
NET: Registered protocol family 16
Muxing K15_24XX_UART3_TX (0x48000118): 0x00 -> 0x00
Muxing K14_24XX_UART3_RX (0x48000119): 0x00 -> 0x00
Muxing M19_24XX_I2C1_SCL (0x48000111): 0x00 -> 0x00
Muxing L15_24XX_I2C1_SDA (0x48000112): 0x00 -> 0x00
Muxing T19_24XX_KBR0 (0x48000106): 0x0f -> 0x1b
Muxing R19_24XX_KBR1 (0x48000107): 0x0f -> 0x1b
Muxing V18_24XX_KBR2 (0x48000139): 0x07 -> 0x1b
Muxing M21_24XX_KBR3 (0x480000c9): 0x0f -> 0x1b
Muxing E5__24XX_KBR4 (0x48000138): 0x0f -> 0x1b
Muxing B3__24XX_KBR5 (0x48000030): 0x03 -> 0x1b
Muxing AA4_24XX_KBC2 (0x480000e7): 0x03 -> 0x03
Muxing B13_24XX_KBC6 (0x48000110): 0x03 -> 0x03
Muxing R20_24XX_KBC0 (0x48000108): 0x0f -> 0x03
Muxing M14_24XX_KBC1 (0x48000109): 0x1f -> 0x03
Muxing V17_24XX_KBC3 (0x48000135): 0x07 -> 0x03
Muxing P21_24XX_KBC4 (0x480000ca): 0x0f -> 0x03
Muxing L14_24XX_KBC5 (0x4800010f): 0x0f -> 0x03
OMAP DMA hardware revision 2.0
Initializing OMAP McBSP system
Muxing Y15_24XX_MCBSP2_CLKX (0x48000124): 0x0f -> 0x09
Muxing R14_24XX_MCBSP2_FSX (0x48000125): 0x0f -> 0x09
Muxing W15_24XX_MCBSP2_DR (0x48000126): 0x0f -> 0x09
Muxing V15_24XX_MCBSP2_DX (0x48000127): 0x0f -> 0x09
Muxing V14_24XX_GPIO117 (0x48000128): 0x0f -> 0x0b
Muxing W14_24XX_SYS_CLKOUT (0x48000137): 0x0f -> 0x18
omapdsp: unsupported omap architecture.
USB: No board-specific platform config found
i2c_omap i2c_omap.1: bus 0 rev3.4 at 100 kHz
OMAP24xx McSPI driver initializing
NET: Registered protocol family 23
NetWinder Floating Point Emulator V0.97 (double precision)
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
NTFS driver 2.1.26 [Flags: R/W].
JFFS2 version 2.2. (NAND) (C) 2001-2003 Red Hat, Inc.
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
omapfb: configured for panel h4
omapfb-dispc: version 2.0
Console: switching to colour frame buffer device 30x40
omapfb: initialized vram=159744 pixclock 5541 kHz hfreq 16.9 kHz vfreq
51.9 Hz
OMAP Watchdog Timer: initial timeout 60 sec
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
serial8250.0: ttyS0 at MMIO 0x4806a000 (irq = 72) is a ST16654
serial8250.0: ttyS1 at MMIO 0x4806c000 (irq = 73) is a ST16654
serial8250.0: ttyS2 at MMIO 0x4806e000 (irq = 74) is a ST16654
RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
loop: loaded (max 8 devices)
smc91x.c: v1.1, sep 22 2004 by Nicolas Pitre <nico@cam.org>
eth0: SMC91C94 (rev 9) at c4851300 IRQ 252 [nowait]
eth0: Ethernet addr: 08:00:28:01:12:7e
OMAP IrDA driver initializing
Muxing W19_24XX_SYS_NIRQ (0x4800012c): 0x00 -> 0x18
Menelaus rev 2.1
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
TI TSC2102 driver initializing
ts: Compaq touchscreen protocol output
OMAP Keypad Driver
input: omap-keypad as /class/input/input0
NET: Registered protocol family 2
MMC1: Command timeout, CMD0
MMC1: Command timeout, CMD0
IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
TCP established hash table entries: 4096 (order: 2, 16384 bytes)
TCP bind hash table entries: 4096 (order: 2, 16384 bytes)
TCP: Hash tables configured (established 4096 bind 4096)
TCP reno registered
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
NET: Registered protocol family 15
IrCOMM protocol (Dag Brattli)
MMC1: Command timeout, CMD0
MMC1: Command timeout, CMD0
mmcblk0: mmc0:0001 MP     498944KiB
 mmcblk0: unknown partition table
XXX card in slot 1
Root-NFS: No NFS server available, giving up.
VFS: Unable to mount root fs via NFS, trying floppy.
VFS: No root yet, retrying to mount root on mmc0 (unknown-block(2,0))
VFS: No root yet, retrying to mount root on mmc0 (unknown-block(2,0))
VFS: No root yet, retrying to mount root on mmc0 (unknown-block(2,0))
VFS: No root yet, retrying to mount root on mmc0 (unknown-block(2,0))
VFS: No root yet, retrying to mount root on mmc0 (unknown-block(2,0))
VFS: No root yet, retrying to mount root on mmc0 (unknown-block(2,0))
VFS: Cannot open root device "mmc0" or unknown-block(2,0)
Please append a correct "root=" boot option
Kernel panic - not syncing: VFS: Unable to mount root fs on
unknown-block(2,0)


On Tue, 2006-10-31 at 19:30 -0600, Syed Mohammed, Khasim wrote:
> Hi,
> 
> Format the MMC card to EXT2 FS. 
> Copy your existing NFS target file system MMC partition.
> (You can do this on any standard Linux PC with card reader or use the
> board itself)
> 
> Modify the bootargs to 
> setenv bootargs console=ttyS0,115200n8 noinitrd root=/dev/mmcblk0p1 rw
> ip=off devfs=mount
> 
> Note: You might have to change the /dev/mmcblk0p1 to what ever you are
> getting for MMC dev on your board.
> 
> Regards,
> Khasim
> -----Original Message-----
> From: linux-omap-open-source-bounces+x0khasim=ti.com@linux.omap.com
> [mailto:linux-omap-open-source-bounces+x0khasim=ti.com@linux.omap.com]
> On Behalf Of Hingkwan Huen
> Sent: Tuesday, October 31, 2006 6:57 PM
> To: linux-omap-open-source@linux.omap.com
> Subject: OMAP H4 Boot from MMC Card
> 
> Dear All,
> 
> I am currently running 2.6.17 and OPIE on the OMAP2420 H4 with rootfs
> via NFS. In order to make the whole setup more portable and not
> depending on the network, I would like to have the rootfs on the MMC
> card. Could anyone help provide an instruction how to set this up,
> please?
> 
> Thanks,
> kwan
> 
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
> 
> 

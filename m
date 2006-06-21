From: Komal Shah <komal_shah802003@yahoo.com>
Subject: Re: Power domain addition.
Date: Wed, 21 Jun 2006 06:15:16 -0700 (PDT)
Message-ID: <20060621131516.57479.qmail@web37909.mail.mud.yahoo.com>
References: <20060620180901.GE4257@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20060620180901.GE4257@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Tony Lindgren <tony@atomide.com>, "Woodruff, Richard" <r-woodruff2@ti.com>
Cc: linux-omap-open-source@linux.omap.com, sampsa.fabritius@nokia.com
List-Id: linux-omap@vger.kernel.org

--- Tony Lindgren <tony@atomide.com> wrote:
> 
> OK, I've pushed that chunk along with Komal's smc91x patches so H4
> boots
> and works with PM and cpufreq.
>  

Well, I have tried the latest kernel, but with MT_MEMORY and no PM
support kernel stops here:

----------snip------------------
<5>Linux version 2.6.17-omap1-gea5858eb-dirty (komal@everest) (gcc
version 3.4.0
 20040409 (CodeSourcery ARM Q1A 2004)) #49 Wed Jun 21 23:43:30 IST 2006
CPU: Some Random V6 Processor [4107b362] revision 2 (ARMv6TEJ)
Machine: OMAP2420 H4 board
Memory policy: ECC disabled, Data cache writeback
<7>On node 0 totalpages: 32768
<7>  DMA zone: 32768 pages, LIFO batch:7
<6>OMAP2420
<4>BUG: map for 0x4020f000 at 0xd0000000 can not be mapped using pages,
ignoring
.
<6>SRAM: Mapped pa 0x4020f000 to va 0xd0000000 size: 0x100000
----------snip------------------

And with MT_DEVICE and PM support, it stops after IrDA driver
initialzing message:

----------snip------------------
Linux version 2.6.17-omap1-gea5858eb-dirty (komal@everest) (gcc version
3.4.0 20
040409 (CodeSourcery ARM Q1A 2004)) #52 Wed Jun 21 23:59:23 IST 2006
CPU: Some Random V6 Processor [4107b362] revision 2 (ARMv6TEJ)
Machine: OMAP2420 H4 board
Memory policy: ECC disabled, Data cache writeback
OMAP2420
SRAM: Mapped pa 0x4020f000 to va 0xd0000000 size: 0x100000
CPU0: D VIPT write-back cache
CPU0: I cache: 32768 bytes, associativity 4, 32 byte lines, 256 sets
CPU0: D cache: 32768 bytes, associativity 4, 32 byte lines, 256 sets
Built 1 zonelists
Kernel command line: console=ttyS0,115200n8 noinitrd root=/dev/nfs rw
nfsroot=10
.203.97.52:/pub/fs/git,rsize=1024,wsize=1024 init=/linuxrc ip=dhcp
Clocking rate (Crystal/DPLL/MPU): 12.0/600/300 MHz
clock.c: Enable for dpll_ck without enable code
GPMC revision 1.0
IRQ: Found an INTC at 0x480fe000 (revision 1.0) with 96 interrupts
Total of 96 interrupts on 1 active controller
OMAP24xx GPIO hardware version 1.5
Muxing M15_24XX_GPIO92 (0x4800010a): 0x03 -> 0x03
PID hash table entries: 1024 (order: 10, 4096 bytes)
Console: colour dummy device 80x30
Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
Memory: 128MB 0MB = 128MB total
Memory: 126848KB available (2308K code, 522K data, 108K init)
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
OMAP DMA hardware revision 1.0
Initializing OMAP McBSP system
Muxing Y15_24XX_MCBSP2_CLKX (0x48000124): 0x0f -> 0x09
Muxing R14_24XX_MCBSP2_FSX (0x48000125): 0x0f -> 0x09
Muxing W15_24XX_MCBSP2_DR (0x48000126): 0x0f -> 0x09
Muxing V15_24XX_MCBSP2_DX (0x48000127): 0x0f -> 0x09
Muxing V14_24XX_GPIO117 (0x48000128): 0x0f -> 0x0b
Muxing W14_24XX_SYS_CLKOUT (0x48000137): 0x0f -> 0x18
omapdsp: unsupported omap architecture.
USB: No board-specific platform config found
i2c_omap i2c_omap.1: bus 0 rev3.1 at 100 kHz
NET: Registered protocol family 23
NET: Registered protocol family 2
IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
TCP established hash table entries: 4096 (order: 2, 16384 bytes)
TCP bind hash table entries: 2048 (order: 1, 8192 bytes)
TCP: Hash tables configured (established 4096 bind 2048)
TCP reno registered
Power Management for TI OMAP.
NetWinder Floating Point Emulator V0.97 (double precision)
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
JFFS2 version 2.2. (NAND) (C) 2001-2003 Red Hat, Inc.
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
omapfb: configured for panel h4
omapfb-dispc: version 1.0
Console: switching to colour frame buffer device 30x40
omapfb: initialized vram=159744 pixclock 6250 kHz hfreq 18.3 kHz vfreq
58.6 Hz
OMAP Watchdog Timer: initial timeout 60 sec
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing
enabled
serial8250.0: ttyS0 at MMIO 0x4806a000 (irq = 72) is a ST16654
serial8250.0: ttyS1 at MMIO 0x4806c000 (irq = 73) is a ST16654
serial8250.0: ttyS2 at MMIO 0x4806e000 (irq = 74) is a ST16654
RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
loop: loaded (max 8 devices)
smc91x.c: v1.1, sep 22 2004 by Nicolas Pitre <nico@cam.org>
eth0: SMC91C94 (rev 9) at c8851300 IRQ 252 [nowait]
eth0: Ethernet addr: 00:50:c2:27:1e:ab
OMAP IrDA driver initializing

----------snip------------------

But with MT_DEVICE and no PM support kernel boots fine with NFS.


---Komal Shah
http://komalshah.blogspot.com/

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 

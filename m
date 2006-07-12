From: Kyungmin Park <kyungmin.park@samsung.com>
Subject: RE: 2420 boot BUG(): failure to map SRAM
Date: Thu, 13 Jul 2006 08:20:50 +0900
Message-ID: <004e01c6a609$d0182e80$c7a3580a@swcenter.sec.samsung.co.kr>
References: <1152743312.14885.11.camel@vence.internal.net>
Reply-To: kyungmin.park@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ks_c_5601-1987
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-reply-to: <1152743312.14885.11.camel@vence.internal.net>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: 'Kevin Hilman' <khilman@deeprooted.net>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi

It can boot with no problem with current git tree in OMAP2420

I think your detected SRAM phys address is wrong

There's only two phys addresses in arch/arm/plat-omap/sram.c
#define OMAP2_SRAM_PA           0x40200000
#define OMAP2_SRAM_PUB_PA       0x4020f800

but your sram phys addr is detected as 0x4020f000
"SRAM: Mapped pa 0x4020f000 to va 0xd0000000 size: 0x100000"
instead of
"SRAM: Mapped pa 0x40200000 to va 0xd0000000 size: 0x100000"

here's my boot messages

Uncompressing
Linux.............................................................
............ done, booting the kernel.
Linux version 2.6.17-omap1 (kmpark@cass) (gcc version 4.1.0 (CodeSourcery
ARM))
#220 Thu Jul 13 08:13:21 KST 2006
CPU: Some Random V6 Processor [4107b362] revision 2 (ARMv6TEJ)
Machine: OMAP24xx Apollon
Memory policy: ECC disabled, Data cache writeback
OMAP24204
SRAM: Mapped pa 0x40200000 to va 0xd0000000 size: 0x100000
CPU0: D VIPT write-back cache
CPU0: I cache: 32768 bytes, associativity 4, 32 byte lines, 256 sets
CPU0: D cache: 32768 bytes, associativity 4, 32 byte lines, 256 sets
Built 1 zonelists
kernel profiling enabled (shift: 2)
Clocking rate (Crystal/DPLL/MPU): 12.0/660/330 MHz
clock.c: Enable for dpll_ck without enable code
GPMC revision 2.0
IRQ: Found an INTC at 0x480fe000 (revision 2.0) with 96 interrupts
Total of 96 interrupts on 1 active controller
OMAP24xx GPIO hardware version 1.8
Muxing W4__24XX_GPIO74 (0x480000f2): 0x03 -> 0x03
PID hash table entries: 1024 (order: 10, 4096 bytes)
Console: colour dummy device 80x30
Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
Memory: 128MB = 128MB total
Memory: 125568KB available (1848K code, 444K data, 92K init)
Mount-cache hash table entries: 512
CPU: Testing write buffer coherency: ok
NET: Registered protocol family 16
Muxing AA10_242X_GPIO13 (0x480000e5): 0x1f -> 0x03
Muxing AA6_242X_GPIO14 (0x480000e6): 0x0f -> 0x03
Muxing AA4_242X_GPIO15 (0x480000e7): 0x0f -> 0x03
Muxing Y11_242X_GPIO16 (0x480000e8): 0x0f -> 0x03
Muxing AA12_242X_GPIO17 (0x480000e9): 0x0f -> 0x03
Muxing AA8_242X_GPIO58 (0x480000ea): 0x1f -> 0x03
Muxing W19_24XX_SYS_NIRQ (0x4800012c): 0x1f -> 0x18
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
OMAP24xx McSPI driver initializing
NET: Registered protocol family 2
IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
TCP established hash table entries: 4096 (order: 4, 65536 bytes)
TCP bind hash table entries: 2048 (order: 3, 40960 bytes)
TCP: Hash tables configured (established 4096 bind 2048)
TCP reno registered
JFFS2 version 2.2. (NAND) (C) 2001-2003 Red Hat, Inc.
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
omapfb: configured for panel apollon
omapfb: DISPC version 2.0 initialized
Muxing M21_242X_GPIO11 (0x480000c9): 0x0f -> 0x1b
Console: switching to colour frame buffer device 60x34
omapfb: Framebuffer initialized. Total vram 261120 planes 1
omapfb: Pixclock 6111 kHz hfreq 11.0 kHz vfreq 40.6 Hz
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
serial8250.0: ttyS0 at MMIO 0x4806a000 (irq = 72) is a ST16654
loop: loaded (max 8 devices)
smc91x.c: v1.1, sep 22 2004 by Nicolas Pitre <nico@cam.org>
eth0: SMC91C94 (rev 9) at c885e300 IRQ 234 [nowait]
eth0: Ethernet addr: 00:0e:99:00:24:71
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
VFP support v0.3: implementor 41 architecture 1 part 20 variant b rev 2
Freeing init memory: 92K

Regards
Kyungmin Park 

> -----Original Message-----
> From: linux-omap-open-source-bounces@linux.omap.com 
> [mailto:linux-omap-open-source-bounces@linux.omap.com] On 
> Behalf Of Kevin Hilman
> Sent: Thursday, July 13, 2006 7:29 AM
> To: linux-omap-open-source@linux.omap.com
> Subject: 2420 boot BUG(): failure to map SRAM
> 
> I just discovered that today's git doesn't boot on 2420 (boot 
> log below).  I haven't debugged yet, but wanted to post in 
> case anyone as seen/solved this.
> 
> Kevin
> 
> Uncompressing
> Linux.........................................................
> .................................. done, booting the kernel.
> <5>Linux version 2.6.17-omap1-default-g64929d88-dirty 
> (khilman@paris) (gcc version 4.1.1 (MontaVista 
> 4.1.1-2.0.0.0601007 2006-07-10)) #15 Wed Jul 12 15:33:33 PDT 2006
> CPU: Some Random V6 Processor [4107b362] revision 2 (ARMv6TEJ)
> Machine: OMAP2420 H4 board
> Memory policy: ECC disabled, Data cache writeback <7>On node 
> 0 totalpages: 8192 <7>  DMA zone: 8192 pages, LIFO batch:1 <6>OMAP2420
> <4>BUG: map for 0x4020f000 at 0xd0000000 can not be mapped 
> using pages, ignoring.
> <6>SRAM: Mapped pa 0x4020f000 to va 0xd0000000 size: 0x100000
> 
> 
> 
> 
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
> 
> 

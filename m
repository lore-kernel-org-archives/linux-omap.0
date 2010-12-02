From: Charles Manning <manningc2@actrix.gen.nz>
Subject: Re: [PATCH v6 0/7] nand prefetch-irq support and ecc layout chanage
Date: Thu, 2 Dec 2010 17:09:59 +1300
Message-ID: <201012021710.00367.manningc2@actrix.gen.nz>
References: <1290785677-16005-1-git-send-email-s-ghorai@ti.com> <2A3DCF3DA181AD40BDE86A3150B27B6B0369E7B95B@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.scorch.co.nz ([27.110.127.199]:53331 "HELO scorch.co.nz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1756915Ab0LBEKI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 1 Dec 2010 23:10:08 -0500
In-Reply-To: <2A3DCF3DA181AD40BDE86A3150B27B6B0369E7B95B@dbde02.ent.ti.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Ghorai, Sukumar" <s-ghorai@ti.com>
Cc: Grazvydas Ignotas <notasas@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Saturday 27 November 2010 06:57:37 Ghorai, Sukumar wrote:
> Hello Grazvydas & Charles,
> Would you please check this series in you setup and please update the
> status or any issue you observe?

Hello

It took a while for me to get back to this.

I applied the patches but still no luck running with the HW ECC disabled.

The image was written with SW ECC  using UBOOT.

This system is actually running on an Overo with a customised kernel.

Ideally, the ECC will not change from version to version.

I shall explore further...

Here is a boot log:

[    0.000000] Linux version 2.6.37-rc3-sdu-1+ (charles@charles-laptop) (gcc 
version 4.3.3 (GCC) ) #27 Thu Dec 2 16:43:03 NZDT 2010
[    0.000000] CPU: ARMv7 Processor [411fc082] revision 2 (ARMv7), cr=10c53c7f
[    0.000000] CPU: VIPT nonaliasing data cache, VIPT nonaliasing instruction 
cache
[    0.000000] Machine: Gumstix Overo
[    0.000000] Memory policy: ECC disabled, Data cache writeback
[    0.000000] OMAP3525 ES2.1 (l2cache iva neon isp )
[    0.000000] SRAM: Mapped pa 0x40200000 to va 0xfe400000 size: 0x10000
[    0.000000] pcpu-alloc: s0 r0 d32768 u32768 alloc=1*32768
[    0.000000] pcpu-alloc: [0] 0 
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total 
pages: 65024
[    0.000000] Kernel command line: console=ttyO2,115200n8 
video=omapfb:vram:2M,vram:4M root=ubi0:root rw rootfstype=ubifs ubi.mtd=7
[    0.000000] PID hash table entries: 1024 (order: 0, 4096 bytes)
[    0.000000] Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
[    0.000000] Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
[    0.000000] Memory: 256MB = 256MB total
[    0.000000] Memory: 256664k/256664k available, 5480k reserved, 0K highmem
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
[    0.000000]     DMA     : 0xffc00000 - 0xffe00000   (   2 MB)
[    0.000000]     vmalloc : 0xd0800000 - 0xf8000000   ( 632 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xd0000000   ( 256 MB)
[    0.000000]     modules : 0xbf000000 - 0xc0000000   (  16 MB)
[    0.000000]       .init : 0xc0008000 - 0xc0038000   ( 192 kB)
[    0.000000]       .text : 0xc0038000 - 0xc02c2000   (2600 kB)
[    0.000000]       .data : 0xc02c2000 - 0xc02fac80   ( 228 kB)
[    0.000000] NR_IRQS:409
[    0.000000] Clocking rate (Crystal/Core/MPU): 26.0/331/500 MHz
[    0.000000] Reprogramming SDRC clock to 331882352 Hz
[    0.000000] IRQ: Found an INTC at 0xfa200000 (revision 4.0) with 96 
interrupts
[    0.000000] Total of 96 interrupts on 1 active controller
[    0.000000] GPMC revision 5.0
[    0.000000] Trying to install interrupt handler for IRQ402
[    0.000000] Trying to install interrupt handler for IRQ403
[    0.000000] Trying to install interrupt handler for IRQ404
[    0.000000] Trying to install interrupt handler for IRQ405
[    0.000000] Trying to install interrupt handler for IRQ406
[    0.000000] Trying to install interrupt handler for IRQ407
[    0.000000] Trying to install interrupt handler for IRQ408
[    0.000000] Trying to install type control for IRQ409
[    0.000000] Trying to set irq flags for IRQ409
[    0.000000] Could not get gpios_ick
[    0.000000] Could not get gpios_fck
[    0.000000] OMAP GPIO hardware version 2.5
[    0.000000] OMAP clockevent source: GPTIMER1 at 32768 Hz
[    0.000000] Console: colour dummy device 80x30
[    0.000000] Calibrating delay loop... 499.92 BogoMIPS (lpj=1949696)
[    0.000000] pid_max: default: 32768 minimum: 301
[    0.000000] Mount-cache hash table entries: 512
[    0.000000] CPU: Testing write buffer coherency: ok
[    0.000000] regulator: core version 0.5
[    0.000000] regulator: dummy: 
[    0.000000] NET: Registered protocol family 16
[    0.000000] omap_mux_init: Add partition: #1: core, flags: 0
[    0.000000] Found NAND on CS0
[    0.000000] Registering NAND on CS0
[    0.000000] finished sdu_init
[    0.000000] hw-breakpoint: debug architecture 0x4 unsupported.
[    0.000000] OMAP DMA hardware revision 4.0
[    0.010284] bio: create slab <bio-0> at 0
[    0.014343] omap_device: i2c_omap.1: new worst case activate latency 0: 
30517
[    0.014434] i2c_omap i2c_omap.1: bus 1 rev3.12 at 2600 kHz
[    0.017730] twl4030: PIH (irq 7) chaining IRQs 368..375
[    0.017761] twl4030: power (irq 373) chaining IRQs 376..383
[    0.018432] twl4030: gpio (irq 368) chaining IRQs 384..401
[    0.022277] regulator: VMMC1: 1850 <--> 3150 mV at 3000 mV normal standby
[    0.022552] i2c_omap i2c_omap.3: bus 3 rev3.12 at 100 kHz
[    0.025238] Bluetooth: Core ver 2.15
[    0.025512] NET: Registered protocol family 31
[    0.025512] Bluetooth: HCI device and connection manager initialized
[    0.025543] Bluetooth: HCI socket layer initialized
[    0.025573] Switching to clocksource 32k_counter
[    0.048950] NET: Registered protocol family 2
[    0.049255] IP route cache hash table entries: 2048 (order: 1, 8192 bytes)
[    0.049743] TCP established hash table entries: 8192 (order: 4, 65536 
bytes)
[    0.049987] TCP bind hash table entries: 8192 (order: 3, 32768 bytes)
[    0.050109] TCP: Hash tables configured (established 8192 bind 8192)
[    0.050140] TCP reno registered
[    0.050140] UDP hash table entries: 256 (order: 0, 4096 bytes)
[    0.050201] UDP-Lite hash table entries: 256 (order: 0, 4096 bytes)
[    0.050445] NET: Registered protocol family 1
[    0.050537] NetWinder Floating Point Emulator V0.97 (double precision)
[    0.054443] msgmni has been set to 501
[    0.055175] io scheduler noop registered
[    0.055206] io scheduler deadline registered
[    0.055328] io scheduler cfq registered (default)
[    0.056762] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    0.058959] omap-hsuart.0: ttyO0 at MMIO 0x4806a000 (irq = 72) is a OMAP 
UART0
[    0.059387] omap-hsuart.1: ttyO1 at MMIO 0x4806c000 (irq = 73) is a OMAP 
UART1
[    0.059783] omap-hsuart.2: ttyO2 at MMIO 0x49020000 (irq = 74) is a OMAP 
UART2
[    0.565887] console [ttyO2] enabled
[    0.582672] brd: module loaded
[    0.592285] loop: module loaded
[    0.597106] omap2-nand driver initializing
[    0.601715] ONFI flash detected
[    0.605316] NAND device: Manufacturer ID: 0x2c, Chip ID: 0xba (Micron )
[    0.612548] cmdlinepart partition parsing not available
[    0.618011] Creating 10 MTD partitions on "omap2-nand.0":
[    0.623718] 0x000000000000-0x000000080000 : "xloader"
[    0.630035] 0x000000080000-0x000000100000 : "uboot"
[    0.636077] 0x000000100000-0x000000180000 : "mandata"
[    0.642242] 0x000000180000-0x000000200000 : "upgradestate"
[    0.648895] 0x000000200000-0x000000400000 : "linux0"
[    0.655639] 0x000000400000-0x000000600000 : "linux1"
[    0.662322] 0x000000600000-0x000001000000 : "earlyrw"
[    0.672454] 0x000001000000-0x000004000000 : "root0"
[    0.698394] 0x000004000000-0x000007000000 : "root1"
[    0.724304] 0x000007000000-0x000010000000 : "laterw"
[    0.791564] UBI: attaching mtd7 to ubi0
[    0.795562] UBI: physical eraseblock size:   131072 bytes (128 KiB)
[    0.802154] UBI: logical eraseblock size:    129024 bytes
[    0.807830] UBI: smallest flash I/O unit:    2048
[    0.812744] UBI: sub-page size:              512
[    0.817626] UBI: VID header offset:          512 (aligned 512)
[    0.823760] UBI: data offset:                2048
[    0.829162] uncorrectable error : 
[    0.832611] UBI error: ubi_io_read: error -74 (ECC error) while reading 512 
bytes from PEB 0:512, read 512 bytes
[    0.843872] uncorrectable error : 
[    0.847290] UBI error: ubi_io_read: error -74 (ECC error) while reading 512 
bytes from PEB 1:512, read 512 bytes
[    0.858398] uncorrectable error : 
[    0.861816] UBI error: ubi_io_read: error -74 (ECC error) while reading 512 
bytes from PEB 2:512, read 512 bytes
[    0.872924] uncorrectable error : 
[    0.876312] UBI error: ubi_io_read: error -74 (ECC error) while reading 512 
bytes from PEB 3:512, read 512 bytes
[    0.887420] uncorrectable error : 
[    0.890808] UBI error: ubi_io_read: error -74 (ECC error) while reading 512 
bytes from PEB 4:512, read 512 bytes



>
> Regards,
> Ghorai
>
> > -----Original Message-----
> > From: Ghorai, Sukumar
> > Sent: Friday, November 26, 2010 9:05 PM
> > To: linux-omap@vger.kernel.org
> > Cc: linux-mtd@lists.infradead.org; linux-arm-kernel@lists.infradead.org;
> > Ghorai, Sukumar
> > Subject: [PATCH v6 0/7] nand prefetch-irq support and ecc layout chanage
> >
> > The following set of patches applies on linux-2.6.
> >
> > The main motivations behind this patch series are -
> >         1. support NAND I/O in irq mode.
> >         2. support of different ECC schema.
> >         3. also to make ecc layout as like in romcode ecc layout
> >
> >
> > v6: configurable transfer type from board file;
> >     #define irq number used for nand-irq
> >
> > v5: http://www.mail-archive.com/linux-omap@vger.kernel.org/msg35860.html
> > This address the input as to support the irq_chained in GPMC.
> > And resend of
> > http://www.mail-archive.com/linux-omap@vger.kernel.org/msg35848.html
> >
> > v4: http://www.mail-archive.com/linux-omap@vger.kernel.org/msg34882.html
> > and resend of
> > http://www.mail-archive.com/linux-omap@vger.kernel.org/msg32689.html
> >
> > v3: http://www.mail-archive.com/linux-omap@vger.kernel.org/msg32071.html
> > Rebase on latest codebase and previous patch(posted).
> > http://www.mail-archive.com/linux-omap@vger.kernel.org/msg31963.html
> >
> > v2: Rebase on latest codebase and previous patch(posted).
> > http://www.mail-archive.com/linux-omap@vger.kernel.org/msg31471.html
> >
> > v1: http://www.mail-archive.com/linux-omap@vger.kernel.org/msg26666.html
> >
> > Sukumar Ghorai (7):
> >   omap3630: nand: fix device size to work in polled mode
> >   omap3: nand: configurable transfer type per board
> >   omap: gpmc: enable irq mode in gpmc
> >   omap3: nand: prefetch in irq mode support
> >   omap3: nand: configurable fifo threshold to gain the throughput
> >   omap: nand: ecc layout select from board file
> >   omap: nand: making ecc layout as compatible with romcode ecc
> >
> >  arch/arm/mach-omap2/board-2430sdp.c        |    1 +
> >  arch/arm/mach-omap2/board-3430sdp.c        |    1 +
> >  arch/arm/mach-omap2/board-3630sdp.c        |    1 +
> >  arch/arm/mach-omap2/board-4430sdp.c        |    2 +
> >  arch/arm/mach-omap2/board-am3517evm.c      |    2 +
> >  arch/arm/mach-omap2/board-apollon.c        |    1 +
> >  arch/arm/mach-omap2/board-cm-t35.c         |    1 +
> >  arch/arm/mach-omap2/board-devkit8000.c     |    1 +
> >  arch/arm/mach-omap2/board-flash.c          |    7 +
> >  arch/arm/mach-omap2/board-generic.c        |    2 +
> >  arch/arm/mach-omap2/board-h4.c             |    1 +
> >  arch/arm/mach-omap2/board-igep0020.c       |    1 +
> >  arch/arm/mach-omap2/board-ldp.c            |    1 +
> >  arch/arm/mach-omap2/board-n8x0.c           |    2 +
> >  arch/arm/mach-omap2/board-omap3beagle.c    |    1 +
> >  arch/arm/mach-omap2/board-omap3evm.c       |    2 +
> >  arch/arm/mach-omap2/board-omap3pandora.c   |    2 +
> >  arch/arm/mach-omap2/board-omap3stalker.c   |    1 +
> >  arch/arm/mach-omap2/board-omap3touchbook.c |    1 +
> >  arch/arm/mach-omap2/board-omap4panda.c     |    2 +
> >  arch/arm/mach-omap2/board-overo.c          |    1 +
> >  arch/arm/mach-omap2/board-rx51.c           |    1 +
> >  arch/arm/mach-omap2/board-zoom2.c          |    2 +
> >  arch/arm/mach-omap2/board-zoom3.c          |    2 +
> >  arch/arm/mach-omap2/gpmc.c                 |   50 ++++-
> >  arch/arm/mach-omap2/io.c                   |    2 -
> >  arch/arm/plat-omap/include/plat/gpmc.h     |   16 ++-
> >  arch/arm/plat-omap/include/plat/irqs.h     |    9 +-
> >  arch/arm/plat-omap/include/plat/nand.h     |   11 +
> >  drivers/mtd/nand/Kconfig                   |   17 --
> >  drivers/mtd/nand/omap2.c                   |  314
> > ++++++++++++++++++++++- -----
> >  31 files changed, 364 insertions(+), 94 deletions(-)
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



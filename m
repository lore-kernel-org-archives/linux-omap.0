From: "Nayak, Rajendra" <rnayak@ti.com>
Subject: RE: [PATCH v2 1/5] OMAP2xxx: hwmod: add I2C hwmods for OMAP2420,
 2430
Date: Tue, 21 Sep 2010 12:50:35 +0530
Message-ID: <0680EC522D0CC943BC586913CF3768C003C21EE0E9@dbde02.ent.ti.com>
References: <1284734229-16281-1-git-send-email-rnayak@ti.com>
 <1284734229-16281-2-git-send-email-rnayak@ti.com>
 <alpine.DEB.2.00.1009210101560.17727@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:40632 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755589Ab0IUHUl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 Sep 2010 03:20:41 -0400
In-Reply-To: <alpine.DEB.2.00.1009210101560.17727@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Kevin Hilman <khilman@deeprootsystems.com>



> -----Original Message-----
> From: Paul Walmsley [mailto:paul@pwsan.com]
> Sent: Tuesday, September 21, 2010 12:39 PM
> To: Nayak, Rajendra
> Cc: linux-omap@vger.kernel.org; Kevin Hilman
> Subject: Re: [PATCH v2 1/5] OMAP2xxx: hwmod: add I2C hwmods for OMAP2420,
> 2430
> 
> On Fri, 17 Sep 2010, Rajendra Nayak wrote:
> 
> > From: Paul Walmsley <paul@pwsan.com>
> >
> > Add hwmod structures for I2C controllers on OMAP2420/2430.
> >
> > Signed-off-by: Paul Walmsley <paul@pwsan.com>
> > Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> 
> Some items that stick out in this patch that should be fixed:
> 
> > +static struct omap_hwmod omap2420_i2c1_hwmod = {
> > +	.name		= "i2c1",
> > +	.mpu_irqs	= i2c1_mpu_irqs,
> > +	.mpu_irqs_cnt	= ARRAY_SIZE(i2c1_mpu_irqs),
> > +	.sdma_reqs	= i2c1_sdma_reqs,
> > +	.sdma_reqs_cnt	= ARRAY_SIZE(i2c1_sdma_reqs),
> > +	.main_clk	= "i2c1_fck",
> > +	.prcm		= {
> > +		.omap2 = {
> > +			.prcm_reg_id = 1,
> > +			.module_bit = OMAP2420_EN_I2C1_SHIFT,
> > +			.idlest_reg_id = 1,
> > +			.idlest_idle_bit = OMAP2420_EN_I2C1_SHIFT,
> 
> This should be OMAP2420_ST_I2C1_SHIFT, not OMAP2420_EN_I2C1_SHIFT.
> Likewise for the other entries.

Thanks for catching this Paul, will fix it before I repost.

> 
> > +static struct omap_hwmod omap2430_i2c1_hwmod = {
> > +	.name		= "i2c1",
> > +	.mpu_irqs	= i2c1_mpu_irqs,
> > +	.mpu_irqs_cnt	= ARRAY_SIZE(i2c1_mpu_irqs),
> > +	.sdma_reqs	= i2c1_sdma_reqs,
> > +	.sdma_reqs_cnt	= ARRAY_SIZE(i2c1_sdma_reqs),
> > +	.main_clk	= "i2c1_fck",
> > +	.prcm		= {
> > +		.omap2 = {
> > +			.prcm_reg_id = 1,
> > +			.module_bit = OMAP2430_EN_I2CHS1_SHIFT,
> > +			.idlest_reg_id = 1,
> 
> This is wrong - the idlest_reg_id for the 2430 I2CHS blocks is different.
> Were these patches tested on 2430?

I did boot test on a 2430SDP after hacking around a lot with configs and commenting
out a bunch of stuff.

And I looked for this in the boot log and assumed I2C was fine
"i2c_omap i2c_omap.1: bus 1 rev3.7 at 100 kHz
 i2c_omap i2c_omap.2: bus 2 rev3.7 at 2600 kHz"

I will certainly have a relook again.

---- 2430 SDP boot log ---
Uncompressing Linux... done, booting the kernel.
Linux version 2.6.36-rc3-00044-g27f5f22-dirty (x0016154@omaplbp) (gcc version 4.4.1 (Sourcery G++ Lite 2010q1-202) ) #14 PREEMPT Wed Sep 15 15:02:45 IST 2010
CPU: ARMv6-compatible processor [4107b366] revision 6 (ARMv6TEJ), cr=00c5387f
CPU: VIPT aliasing data cache, VIPT aliasing instruction cache
Machine: OMAP2430 sdp2430 board
Memory policy: ECC disabled, Data cache writeback OMAP2430

SRAM: Mapped pa 0x40200000 to va 0xfe400000 size: 0x100000 Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 32512 Kernel command line: root=/dev/ram0 rw console=ttyS0,115200n8 initrd=0x81600000,20M ramdisk_size=20480 PID hash table entries: 512 (order: -1, 2048 bytes) Dentry cache hash table entries: 16384 (order: 4, 65536 bytes) Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
Memory: 128MB = 128MB total
Memory: 105540k/105540k available, 25532k reserved, 0K highmem Virtual kernel memory layout:
    vector  : 0xffff0000 - 0xffff1000   (   4 kB)
    fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
    DMA     : 0xffc00000 - 0xffe00000   (   2 MB)
    vmalloc : 0xc8800000 - 0xf8000000   ( 760 MB)
    lowmem  : 0xc0000000 - 0xc8000000   ( 128 MB)
    modules : 0xbf000000 - 0xc0000000   (  16 MB)
      .init : 0xc0008000 - 0xc002c000   ( 144 kB)
      .text : 0xc002c000 - 0xc0367000   (3308 kB)
      .data : 0xc0380000 - 0xc03b0160   ( 193 kB)
Hierarchical RCU implementation.
        Verbose stalled-CPUs detection is disabled.
NR_IRQS:388
Clocking rate (Crystal/DPLL/MPU): 13.0/660/330 MHz GPMC revision 3.0
IRQ: Found an INTC at 0xfa0fe000 (revision 3.0) with 96 interrupts Total of 96 interrupts on 1 active controller OMAP GPIO hardware version 2.4 OMAP clockevent source: GPTIMER1 at 32000 Hz
Console: colour dummy device 80x30
Calibrating delay loop... 320.37 BogoMIPS (lpj=1253376)
pid_max: default: 32768 minimum: 301
Mount-cache hash table entries: 512
CPU: Testing write buffer coherency: ok
regulator: core version 0.5
NET: Registered protocol family 16
USB: hmc 0, usb0 3 wires, Mini-AB on usb0 OMAP DMA hardware revision 4.0
bio: create slab <bio-0> at 0
i2c_omap i2c_omap.1: bus 1 rev3.7 at 100 kHz i2c_omap i2c_omap.2: bus 2 rev3.7 at 2600 kHz
twl4030: PIH (irq 7) chaining IRQs 368..375
twl4030: power (irq 373) chaining IRQs 376..383 Switching to clocksource 32k_counter
NET: Registered protocol family 2
IP route cache hash table entries: 1024 (order: 0, 4096 bytes) TCP established hash table entries: 4096 (order: 3, 32768 bytes) TCP bind hash table entries: 4096 (order: 2, 16384 bytes)
TCP: Hash tables configured (established 4096 bind 4096) TCP reno registered UDP hash table entries: 256 (order: 0, 4096 bytes) UDP-Lite hash table entries: 256 (order: 0, 4096 bytes)
NET: Registered protocol family 1
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
RPC: Registered tcp NFSv4.1 backchannel transport module.
Trying to unpack rootfs image as initramfs...
rootfs image is not initramfs (junk in compressed archive); looks like an initrd Freeing initrd memory: 20480K
PMU: registered new PMU device of type 0 NetWinder Floating Point Emulator V0.97 (double precision)
VFS: Disk quotas dquot_6.5.2
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
JFFS2 version 2.2. (NAND) (c) 2001-2006 Red Hat, Inc.
msgmni has been set to 246
alg: No test for stdrng (krng)
io scheduler noop registered
io scheduler deadline registered
io scheduler cfq registered (default)
omapfb: configured for panel sdp2430
omapfb: DISPC version 3.0 initialized
Console: switching to colour frame buffer device 30x40
omapfb: Framebuffer initialized. Total vram 155648 planes 1
omapfb: Pixclock 5156 kHz hfreq 18.2 kHz vfreq 54.8 Hz omap_rng omap_rng: OMAP Random Number Generator ver. 50
Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
serial8250.0: ttyS0 at MMIO 0x4806a000 (irq = 72) is a ST16654 console [ttyS0] enabled
serial8250.1: ttyS1 at MMIO 0x4806c000 (irq = 73) is a ST16654
serial8250.2: ttyS2 at MMIO 0x4806e000 (irq = 74) is a ST16654
brd: module loaded
loop: module loaded
OneNAND driver initializing
smc91x.c: v1.1, sep 22 2004 by Nicolas Pitre <nico@fluxnic.net>
eth0: SMC91C94 (rev 9) at c8858300 IRQ 309 [nowait]
eth0: Ethernet addr: 00:08:ff:03:47:43
i2c /dev entries driver
OMAP Watchdog Timer Rev 0x22: initial timeout 60 sec TCP cubic registered
NET: Registered protocol family 17
NET: Registered protocol family 15
Power Management for OMAP2 initializing
PRCM revision 1.0
VFP support v0.3: implementor 41 architecture 1 part 20 variant b rev 2
RAMDISK: ext2 filesystem found at block 0
RAMDISK: Loading 20480KiB [1 disk] into ram disk... done.
EXT2-fs (ram0): warning: mounting unchecked fs, running e2fsck is recommended
VFS: Mounted root (ext2 filesystem) on device 1:0.
Freeing init memory: 144K

> 
> > +			.idlest_idle_bit = OMAP2430_EN_I2CHS1_SHIFT,
> > +		},
> > +	},
> > +	.slaves		= omap2430_i2c1_slaves,
> > +	.slaves_cnt	= ARRAY_SIZE(omap2430_i2c1_slaves),
> > +	.class		= &i2c_class,
> > +	.dev_attr	= &i2c1_dev_attr,
> > +	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2430),
> > +};
> 
> 
> - Paul

From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] OMAP4: clockdomain: Follow recommended enable sequence
Date: Thu, 10 Mar 2011 05:18:08 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1103100514210.15132@utopia.booyaka.com>
References: <1299245123-23444-1-git-send-email-rnayak@ti.com> <alpine.DEB.2.00.1103081937100.15132@utopia.booyaka.com> <4D775418.6050105@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:55112 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752573Ab1CJMSJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 Mar 2011 07:18:09 -0500
In-Reply-To: <4D775418.6050105@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org, b-cousson@ti.com, khilman@ti.com, santosh.shilimkar@ti.com, linux-arm-kernel@lists.infradead.org

Hi Rajendra,

On Wed, 9 Mar 2011, Rajendra Nayak wrote:

> On Wednesday 09 March 2011 09:20 AM, Paul Walmsley wrote:
> > On Fri, 4 Mar 2011, Rajendra Nayak wrote:
> > 
> > > On OMAP4, the PRCM recommended sequence for enabling
> > > a module after power-on-reset is
> > > -1- Force clkdm to SW_WKUP
> > > -2- Configure desired module mode to "enable" or "auto"
> > > -3- Wait for the desired module idle status to be FUNC
> > > -4- Program clkdm in HW_AUTO(if supported)
> > > 
> > > This sequence applies to all older OMAPs' as well,
> > > however since they use autodeps, it makes sure that
> > > no clkdm is in IDLE, and hence not requiring a force
> > > SW_WKUP when a module is being enabled.

This patch is currently breaking boot on OMAP4430 ES2.0 Pandaboard,
so I've dropped it from the integration branch until it can be
debugged.  Could you check it, please?

The tag "integration-2.6.39-20110310-008" of
git://git.pwsan.com/linux-integration boots fine; it's got everything
but this patch.  Then when this patch is applied, I2C problems show
up, and root (on MMC) doesn't mount.


- Paul


Uncompressing Linux... done, booting the kernel.
[    0.000000] Linux version 2.6.38-rc7-00238-g3dfe14f (paul@twilight) (gcc version 4.5.1 (Sourcery G1
[    0.000000] CPU: ARMv7 Processor [411fc092] revision 2 (ARMv7), cr=10c53c7f
[    0.000000] CPU: VIPT nonaliasing data cache, VIPT aliasing instruction cache
[    0.000000] Machine: OMAP4 Panda board
[    0.000000] Memory policy: ECC disabled, Data cache writealloc
[    0.000000] OMAP4430 ES2.0
[    0.000000] SRAM: Mapped pa 0x40300000 to va 0xfe400000 size: 0xe000
[    0.000000] PERCPU: Embedded 7 pages/cpu @c0efa000 s8032 r8192 d12448 u32768
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 117602
[    0.000000] Kernel command line: root=/dev/mmcblk0p2 ro rootwait mem=463M console=ttyO2,115200n8 ik
[    0.000000] PID hash table entries: 2048 (order: 1, 8192 bytes)
[    0.000000] Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
[    0.000000] Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
[    0.000000] Memory: 463MB = 463MB total
[    0.000000] Memory: 458320k/458320k available, 15792k reserved, 0K highmem
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
[    0.000000]     DMA     : 0xffc00000 - 0xffe00000   (   2 MB)
[    0.000000]     vmalloc : 0xdd000000 - 0xf8000000   ( 432 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xdcf00000   ( 463 MB)
[    0.000000]     modules : 0xbf000000 - 0xc0000000   (  16 MB)
[    0.000000]       .init : 0xc0008000 - 0xc0050000   ( 288 kB)
[    0.000000]       .text : 0xc0050000 - 0xc05812c4   (5317 kB)
[    0.000000]       .data : 0xc0582000 - 0xc05fa2e0   ( 481 kB)
[    0.000000] Hierarchical RCU implementation.
[    0.000000]  RCU-based detection of stalled CPUs is disabled.
[    0.000000] NR_IRQS:409
[    0.000000] omap_hwmod: dpll_mpu_m2_ck: missing clockdomain for dpll_mpu_m2_ck.
[    0.000000] OMAP clockevent source: GPTIMER1 at 32768 Hz
[    0.000000] sched_clock: 32 bits at 32kHz, resolution 30517ns, wraps every 131071999ms
[    0.000000] Console: colour dummy device 80x30
[    0.000000] Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
[    0.000000] ... MAX_LOCKDEP_SUBCLASSES:  8
[    0.000000] ... MAX_LOCK_DEPTH:          48
[    0.000000] ... MAX_LOCKDEP_KEYS:        8191
[    0.000000] ... CLASSHASH_SIZE:          4096
[    0.000000] ... MAX_LOCKDEP_ENTRIES:     16384
[    0.000000] ... MAX_LOCKDEP_CHAINS:      32768
[    0.000000] ... CHAINHASH_SIZE:          16384
[    0.000000]  memory used by lock dependency info: 3695 kB
[    0.000000]  per task-struct memory footprint: 1152 bytes
[    0.001098] Calibrating delay loop... 2009.29 BogoMIPS (lpj=7847936)
[    0.171905] pid_max: default: 32768 minimum: 301
[    0.172760] Security Framework initialized
[    0.172760] Mount-cache hash table entries: 512
[    0.172760] CPU: Testing write buffer coherency: ok
[    0.179107] L310 cache controller enabled
[    0.179107] l2x0: 16 ways, CACHE_ID 0x410000c4, AUX_CTRL 0x7e470000, Cache size: 1048576 B
[    0.181701] CPU1: Booted secondary processor
[    0.182434] CPU1: Unknown IPI message 0x1
[    0.374694] Brought up 2 CPUs
[    0.374755] SMP: Total of 2 processors activated (4022.78 BogoMIPS).
[    0.382324] omap_hwmod: _populate_mpu_rt_base found no _mpu_rt_va for emif_fw
[    0.382324] omap_hwmod: _populate_mpu_rt_base found no _mpu_rt_va for l3_instr
[    0.382324] omap_hwmod: _populate_mpu_rt_base found no _mpu_rt_va for l3_main_1
[    0.384887] omap_hwmod: _populate_mpu_rt_base found no _mpu_rt_va for l3_main_2
[    0.384887] omap_hwmod: _populate_mpu_rt_base found no _mpu_rt_va for l4_abe
[    0.384887] omap_hwmod: _populate_mpu_rt_base found no _mpu_rt_va for l4_cfg
[    0.384948] omap_hwmod: _populate_mpu_rt_base found no _mpu_rt_va for l4_per
[    0.384948] omap_hwmod: _populate_mpu_rt_base found no _mpu_rt_va for l4_wkup
[    0.384979] omap_hwmod: _populate_mpu_rt_base found no _mpu_rt_va for mpu_private
[   10.694824] omap_i2c omap_i2c.1: controller timed out
[   10.710449] twl: i2c_write failed to transfer all messages
[   10.711578] print_constraints: VCXIO: 1800 mV normal standby
[   11.710449] omap_i2c omap_i2c.1: controller timed out
[   11.726074] twl: i2c_write failed to transfer all messages
[   11.727416] print_constraints: VDAC: 1800 mV normal standby
[   12.726074] omap_i2c omap_i2c.1: controller timed out
[   12.741699] twl: i2c_write failed to transfer all messages
[   13.741699] omap_i2c omap_i2c.1: controller timed out
[   13.757324] twl: i2c_read failed to transfer all messages
[   13.757324] print_constraints: VAUX1_6030: 1000 <--> 3000 mV normal standby
[   14.757324] omap_i2c omap_i2c.1: controller timed out
[   14.772949] twl: i2c_write failed to transfer all messages
[   15.772949] omap_i2c omap_i2c.1: controller timed out
[   15.788574] twl: i2c_read failed to transfer all messages
[   15.788635] print_constraints: VAUX2_6030: 1200 <--> 2800 mV normal standby
[   16.788574] omap_i2c omap_i2c.1: controller timed out
[   16.804199] twl: i2c_write failed to transfer all messages
[   17.804199] omap_i2c omap_i2c.1: contrre: registered new interface driver cdc_subset
[   20.744201] usbcore: registered new interface driver zaurus
[   20.750091] cdc_ncm: 7-Feb-2011
[   20.753692] usbcore: registered new interface driver cdc_ncm
[   20.760955] usbcore: registered new interface driver cdc_wdm
[   20.766937] Initializing USB Mass Storage driver...
[   20.772399] usbcore: registered new interface driver usb-storage
[   20.778747] USB Mass Storage support registered.
[   20.784332] usbcore: registered new interface driver libusual
[   20.790740] usbcore: registered new interface driver usbtest
[   20.796722] udc: OMAP UDC driver, version: 4 October 2004 (iso) (dma)
[   20.805206] mousedev: PS/2 mouse device common for all mice
[   20.814331] input: twl4030_pwrbutton as /devices/platform/omap/omap_i2c.1/i2c-1/1-0049/twl4030_pwr0
[   20.827728] twl_rtc twl_rtc: rtc core: registered twl_rtc as rtc0
[   20.834472] omap_device: omap_i2c.1: new worst case activate latency 0: 6744384
[   21.835449] omap_i2c omap_i2c.1: controller timed out
[   21.851074] twl: i2c_read failed to transfer all messages
[   21.856872] twl_rtc: Could not read TWLregister E - error -110
[   21.866058] twl_rtc: probe of twl_rtc failed with error -110
[   21.872314] i2cs, leaving on
[   28.336883] regulator_init_complete: VANA: incomplete constraints, leaving on
[   28.359039] regulator_init_complete: VUSIM: incomplete constraints, leaving on
[   29.366699] omap_i2c omap_i2c.1: controller timed out
[   29.382415] twl: i2c_read failed to transfer all messages
[   29.382415] regulator_init_complete: VPP: incomplete constraints, leaving on
[   30.390136] omap_i2c omap_i2c.1: controller timed out
[   30.405822] twl: i2c_read failed to transfer all messages
[   30.405822] regulator_init_complete: VMMC: incomplete constraints, leaving on
[   30.419006] drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
[   30.425689] Waiting for root device /dev/mmcblk0p2...

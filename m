From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: State of SDP4430 platform
Date: Sun, 6 Feb 2011 09:49:19 +0000
Message-ID: <20110206094919.GA11707@n2100.arm.linux.org.uk>
References: <20110116010936.GA21795@n2100.arm.linux.org.uk> <alpine.DEB.2.00.1101152255100.13225@utopia.booyaka.com> <a40bc7a304b60cef73a3a0cfb84b2ee8@mail.gmail.com> <ceedbf20a12a6e821fda1496b10297a2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:58149 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751899Ab1BFJtg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 6 Feb 2011 04:49:36 -0500
Content-Disposition: inline
In-Reply-To: <ceedbf20a12a6e821fda1496b10297a2@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org

On Mon, Jan 17, 2011 at 03:37:34PM +0530, Santosh Shilimkar wrote:
> The I2C timeout issue I could reproduce on my ES1.0 board. It's ES1.0
> specific issue because I2C burst mode wasn't fuctional on it. Twl RTC
> driver uses I2C burst mode and hence it times out. Other TWL I2C
> module has no such issue.
> The pull work-around we tried was not reliable hence it was dropped.
> 
> In short the TWL RTC driver won't function on ES1.0. Apart from that
> rest of the I2C clients should work as usual.

The ES2.2 OMAP4 arrived on Friday.  Fitting it resulted in no change
to the I2C timeouts:

Linux version 2.6.38-rc3+ (rmk@rmk-PC) (gcc version 4.3.5 (GCC) ) #167 SMP PREEMPT Sat Feb 5 17:56:32 GMT 2011
CPU: ARMv7 Processor [411fc092] revision 2 (ARMv7), cr=10c53c7f
CPU: VIPT nonaliasing data cache, VIPT aliasing instruction cache
Machine: OMAP4430 4430SDP board
vmalloc area is too big, limiting to 864MB
Memory policy: ECC disabled, Data cache writealloc
OMAP4430 ES2.0
SRAM: Mapped pa 0x40300000 to va 0xfe400000 size: 0xe000
FIXME: omap44xx_sram_init not implemented
On node 0 totalpages: 131072
free_area_init_node: node 0, pgdat c0374d40, node_mem_map c0396000
  Normal zone: 64 pages used for memmap
  Normal zone: 0 pages reserved
  Normal zone: 8128 pages, LIFO batch:0
  HighMem zone: 960 pages used for memmap
  HighMem zone: 121920 pages, LIFO batch:31
PERCPU: Embedded 7 pages/cpu @c079b000 s4192 r8192 d16288 u32768
pcpu-alloc: s4192 r8192 d16288 u32768 alloc=8*4096
pcpu-alloc: [0] 0 [0] 1 
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 130048
Kernel command line: root=/dev/mmcblk0p2 rw mem=512M vmalloc=1G console=ttyO2,115200n8 rootdelay=2
PID hash table entries: 128 (order: -3, 512 bytes)
Dentry cache hash table entries: 4096 (order: 2, 16384 bytes)
Inode-cache hash table entries: 2048 (order: 1, 8192 bytes)
Memory: 512MB = 512MB total
Memory: 516408k/516408k available, 7880k reserved, 491520K highmem
Virtual kernel memory layout:
    vector  : 0xffff0000 - 0xffff1000   (   4 kB)
    fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
    DMA     : 0xffc00000 - 0xffe00000   (   2 MB)
    vmalloc : 0xc2800000 - 0xf8000000   ( 856 MB)
    lowmem  : 0xc0000000 - 0xc2000000   (  32 MB)
    pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
    modules : 0xbf000000 - 0xbfe00000   (  14 MB)
      .init : 0xc0008000 - 0xc002f000   ( 156 kB)
      .text : 0xc002f000 - 0xc0347000   (3168 kB)
      .data : 0xc0348000 - 0xc0375700   ( 182 kB)
SLUB: Genslabs=13, HWalign=32, Order=0-3, MinObjects=0, CPUs=2, Nodes=1
Preemptable hierarchical RCU implementation.
	RCU-based detection of stalled CPUs is disabled.
	Verbose stalled-CPUs detection is disabled.
NR_IRQS:402
clockdomain: l3_dma_clkdm: clkdm_clear_all_wkdeps: not yet implemented
clockdomain: emu_sys_clkdm: OMAP4 wakeup/sleep dependency support: not yet implemented
clockdomain: emu_sys_clkdm: clkdm_clear_all_wkdeps: not yet implemented
clockdomain: l4_wkup_clkdm: OMAP4 wakeup/sleep dependency support: not yet implemented
clockdomain: l4_wkup_clkdm: clkdm_clear_all_wkdeps: not yet implemented
clockdomain: l3_dss_clkdm: clkdm_clear_all_wkdeps: not yet implemented
clockdomain: iss_clkdm: clkdm_clear_all_wkdeps: not yet implemented
clockdomain: l3_d2d_clkdm: clkdm_clear_all_wkdeps: not yet implemented
clockdomain: l3_1_clkdm: OMAP4 wakeup/sleep dependency support: not yet implemented
clockdomain: l3_1_clkdm: clkdm_clear_all_wkdeps: not yet implemented
clockdomain: l3_2_clkdm: OMAP4 wakeup/sleep dependency support: not yet implemented
clockdomain: l3_2_clkdm: clkdm_clear_all_wkdeps: not yet implemented
clockdomain: ducati_clkdm: clkdm_clear_all_wkdeps: not yet implemented
clockdomain: l4_ao_clkdm: clkdm_clear_all_wkdeps: not yet implemented
clockdomain: l3_emif_clkdm: clkdm_clear_all_wkdeps: not yet implemented
clockdomain: mpu1_clkdm: clkdm_clear_all_wkdeps: not yet implemented
clockdomain: mpu0_clkdm: clkdm_clear_all_wkdeps: not yet implemented
clockdomain: mpuss_clkdm: clkdm_clear_all_wkdeps: not yet implemented
clockdomain: l3_init_clkdm: clkdm_clear_all_wkdeps: not yet implemented
clockdomain: l3_instr_clkdm: clkdm_clear_all_wkdeps: not yet implemented
clockdomain: abe_clkdm: clkdm_clear_all_wkdeps: not yet implemented
clockdomain: l4_per_clkdm: clkdm_clear_all_wkdeps: not yet implemented
clockdomain: l4_secure_clkdm: clkdm_clear_all_wkdeps: not yet implemented
clockdomain: ivahd_clkdm: clkdm_clear_all_wkdeps: not yet implemented
clockdomain: l3_gfx_clkdm: clkdm_clear_all_wkdeps: not yet implemented
clockdomain: tesla_clkdm: clkdm_clear_all_wkdeps: not yet implemented
clockdomain: l4_cfg_clkdm: OMAP4 wakeup/sleep dependency support: not yet implemented
clockdomain: l4_cfg_clkdm: clkdm_clear_all_wkdeps: not yet implemented
clockdomain: l4_cefuse_clkdm: clkdm_clear_all_wkdeps: not yet implemented
omap_hwmod: l3_div_ck: missing clockdomain for l3_div_ck.
omap_hwmod: dpll_mpu_m2_ck: missing clockdomain for dpll_mpu_m2_ck.
GPMC revision 6.0
OMAP clockevent source: GPTIMER1 at 32768 Hz
sched_clock: 32 bits at 32kHz, resolution 30517ns, wraps every 131071999ms
Console: colour dummy device 80x30
Calibrating delay loop... 2013.49 BogoMIPS (lpj=7864320)
pid_max: default: 32768 minimum: 301
Mount-cache hash table entries: 512
CPU: Testing write buffer coherency: ok
L310 cache controller enabled
l2x0: 16 ways, CACHE_ID 0x410000c4, AUX_CTRL 0x7e470000, Cache size: 1048576 B
CPU1: Booted secondary processor
CPU1: Unknown IPI message 0x1
Brought up 2 CPUs
SMP: Total of 2 processors activated (4026.98 BogoMIPS).
print_constraints: dummy: 
NET: Registered protocol family 16
OMAP GPIO hardware version 0.1
omap_device: omap_gpio.1: new worst case activate latency 0: 30517
OMAP GPIO hardware version 0.1
OMAP GPIO hardware version 0.1
OMAP GPIO hardware version 0.1
OMAP GPIO hardware version 0.1
OMAP GPIO hardware version 0.1
omap_mux_init: Add partition: #1: core, flags: 2
omap_mux_init: Add partition: #2: wkup, flags: 2
omap_device: omap_uart.2: new worst case activate latency 0: 30517
pm_dbg_init: only OMAP3 supported
OMAP DMA hardware revision 0.0
bio: create slab <bio-0> at 0
omap_i2c omap_i2c.1: bus 1 rev4.0 at 400 kHz
Skipping twl internal clock init and using bootloader value (unknown osc rate)
twl6030: PIH (irq 39) chaining IRQs 368..387
print_constraints: VMMC: 1200 <--> 3000 mV at 3000 mV normal standby
print_constraints: VPP: 1800 <--> 2500 mV at 1900 mV normal standby
print_constraints: VUSIM: 1200 <--> 2900 mV at 1800 mV normal standby
machine_constraints_voltage: VANA: failed to apply 2100000uV constraint
twl_reg twl_reg.43: can't register VANA, -22
twl_reg: probe of twl_reg.43 failed with error -22
machine_constraints_voltage: VCXIO: failed to apply 1800000uV constraint
twl_reg twl_reg.44: can't register VCXIO, -22
twl_reg: probe of twl_reg.44 failed with error -22
machine_constraints_voltage: VDAC: failed to apply 1800000uV constraint
twl_reg twl_reg.45: can't register VDAC, -22
twl_reg: probe of twl_reg.45 failed with error -22
print_constraints: VAUX1_6030: 1000 <--> 3000 mV at 2800 mV normal standby
print_constraints: VAUX2_6030: 1200 <--> 2800 mV at 1800 mV normal standby
print_constraints: VAUX3_6030: 1000 <--> 3000 mV at 1200 mV normal standby
omap_device: omap_i2c.2: new worst case activate latency 0: 30517
omap_i2c omap_i2c.2: bus 2 rev4.0 at 400 kHz
omap_i2c omap_i2c.3: bus 3 rev4.0 at 400 kHz
omap_i2c omap_i2c.4: bus 4 rev4.0 at 400 kHz
omap_device: omap_i2c.4: new worst case deactivate latency 0: 30517
DMA-API: preallocated 4096 debug entries
DMA-API: debugging enabled by kernel config
Switching to clocksource 32k_counter
NET: Registered protocol family 2
IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
TCP established hash table entries: 1024 (order: 1, 8192 bytes)
TCP bind hash table entries: 1024 (order: 1, 12288 bytes)
TCP: Hash tables configured (established 1024 bind 1024)
TCP reno registered
UDP hash table entries: 128 (order: 0, 4096 bytes)
UDP-Lite hash table entries: 128 (order: 0, 4096 bytes)
NET: Registered protocol family 1
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
RPC: Registered tcp NFSv4.1 backchannel transport module.
NetWinder Floating Point Emulator V0.97 (double precision)
highmem bounce pool size: 64 pages
VFS: Disk quotas dquot_6.5.2
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
msgmni has been set to 48
io scheduler noop registered
io scheduler deadline registered
io scheduler cfq registered (default)
Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
omap_uart.0: ttyO0 at MMIO 0x4806a000 (irq = 104) is a OMAP UART0
omap_uart.1: ttyO1 at MMIO 0x4806c000 (irq = 105) is a OMAP UART1
omap_uart.2: ttyO2 at MMIO 0x48020000 (irq = 106) is a OMAP UART2
console [ttyO2] enabled
omap_uart.3: ttyO3 at MMIO 0x4806e000 (irq = 102) is a OMAP UART3
brd: module loaded
loop: module loaded
ks8851 spi1.0: message enable is 0
ks8851 spi1.0: eth0: revision 0, MAC 08:00:28:01:4d:c6, IRQ 194
input: gpio-keys as /devices/platform/gpio-keys/input/input0
twl_rtc twl_rtc: rtc core: registered twl_rtc as rtc0
i2c /dev entries driver
lm75 3-0048: hwmon0: sensor 'tmp105'
omap_i2c omap_i2c.1: controller timed out
omap_i2c omap_i2c.1: controller timed out
omap_i2c omap_i2c.2: controller timed out
omap_i2c omap_i2c.2: controller timed out
omap_i2c omap_i2c.2: controller timed out
omap_i2c omap_i2c.2: controller timed out
omap_i2c omap_i2c.3: controller timed out
omap_i2c omap_i2c.3: controller timed out
omap_i2c omap_i2c.3: controller timed out
omap_i2c omap_i2c.4: controller timed out
omap_i2c omap_i2c.4: controller timed out
omap_i2c omap_i2c.4: controller timed out
omap_i2c omap_i2c.4: controller timed out
Registered led device: omap4:green:debug0
Registered led device: omap4:green:debug1
Registered led device: omap4:green:debug2
Registered led device: omap4:green:debug3
Registered led device: omap4:green:debug4
Registered led device: omap4:blue:user
Registered led device: omap4:red:user
Registered led device: omap4:green:user
TCP cubic registered
NET: Registered protocol family 17
VFP support v0.3: implementor 41 architecture 3 part 30 variant 9 rev 1
omap2_set_init_voltage: unable to find boot up OPP for vdd_mpu
omap2_set_init_voltage: Unable to put vdd_mpu to its init voltage

omap2_set_init_voltage: unable to find boot up OPP for vdd_iva
omap2_set_init_voltage: Unable to put vdd_iva to its init voltage

Power Management for TI OMAP4.
regulator_init_complete: VAUX3_6030: incomplete constraints, leaving on
regulator_init_complete: VAUX2_6030: incomplete constraints, leaving on
regulator_init_complete: VUSIM: incomplete constraints, leaving on
regulator_init_complete: VPP: incomplete constraints, leaving on
twl_rtc twl_rtc: setting system clock to 2000-01-01 00:10:18 UTC (946685418)
Waiting 2sec before mounting root device...
mmc0: host does not support reading read-only switch. assuming write-enable.
mmc0: new high speed SD card at address 0002
mmcblk0: mmc0:0002 00000 971 MiB 
 mmcblk0: p1 p2
mmc1: new high speed MMC card at address 0001
mmcblk1: mmc1:0001 SEM08G 7.39 GiB 
 mmcblk1: unknown partition table
EXT3-fs: barriers not enabled
kjournald starting.  Commit interval 5 seconds
EXT3-fs (mmcblk0p2): warning: maximal mount count reached, running e2fsck is recommended
EXT3-fs (mmcblk0p2): using internal journal
EXT3-fs (mmcblk0p2): recovery complete
EXT3-fs (mmcblk0p2): mounted filesystem with writeback data mode
VFS: Mounted root (ext3 filesystem) on device 179:2.
Freeing init memory: 156K
udevd (471): /proc/471/oom_adj is deprecated, please use /proc/471/oom_score_adj instead.
udevd version 124 started
EXT3-fs (mmcblk0p2): error: unrecognized mount option "relatime" or missing value
